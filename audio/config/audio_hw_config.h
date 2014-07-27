#define PCM_CARD                0
#define PCM_CARD_HDMI           1

#define PCM_CARD_DEFAULT        PCM_CARD

#define MIXER_CARD              0

/* MultiMedia1 LP */
#define PCM_DEVICE_MM           0
#define PCM_DEVICE_MM_UL        1
#define PCM_DEVICE_VOICE        2
#define PCM_DEVICE_TONE         3
#define PCM_DEVICE_VIB_DL       4
#define PCM_DEVICE_MODEM        5
#define PCM_DEVICE_MM_LP        6
#define PCM_DEVICE_MM_FM        7
#define PCM_DEVICE_HEADSET      8
#define PCM_DEVICE_DMIC_IN      9
#define PCM_DEVICE_HEADSET2     10
#define PCM_DEVICE_ANALOG_CAP   11
#define PCM_DEVICE_HF_OUT_DL2   12
#define PCM_DEVICE_VIBRA_OUT    13
#define PCM_DEVICE_SCO_IN       14
#define PCM_DEVICE_SCO_OUT      15
#define PCM_DEVICE_FM_OUT       16
#define PCM_DEVICE_MODEM2       17
#define PCM_DEVICE_DMIC0_IN     18
#define PCM_DEVICE_DMIC1_IN     19
#define PCM_DEVICE_DMIC2_IN     20
#define PCM_DEVICE_VXREC_IN     21

#define PCM_DEVICE_DEFAULT_OUT  PCM_DEVICE_MM
#define PCM_DEVICE_DEFAULT_IN   PCM_DEVICE_MM_UL

struct pcm_config pcm_config_out = {
    .channels = 2,
    .rate = 48000,
    .period_size = 960,
    .period_count = 4,
    .format = PCM_FORMAT_S16_LE,
    .start_threshold = 960 * 4,
};

struct pcm_config pcm_config_out_lp = {
    .channels = 2,
    .rate = 48000,
    .period_size = 960,
    .period_count = 8,
    .format = PCM_FORMAT_S16_LE,
    .start_threshold = 960 * 4,
};

struct pcm_config pcm_config_in = {
    .channels = 2,
    .rate = 48000,
    .period_size = 960,
    .period_count = 4,
    .start_threshold = 1,
    .stop_threshold = 960 * 4,
    .format = PCM_FORMAT_S16_LE,
};

struct pcm_config pcm_config_in_low_latency = {
    .channels = 2,
    .rate = 48000,
    .period_size = 960 / 2,
    .period_count = 4,
    .start_threshold = 1,
    .stop_threshold = 960 * 2,
    .format = PCM_FORMAT_S16_LE,
};

struct pcm_config pcm_config_sco = {
    .channels = 1,
    .rate = 8000,
    .period_size = 256,
    .period_count = 4,
    .format = PCM_FORMAT_S16_LE,
};

struct pcm_config pcm_config_hdmi = {
    .channels = 2,
    .rate = 48000,
    .period_size = 960,
    .period_count = 8,
    .format = PCM_FORMAT_S16_LE,
    .start_threshold = 960 * 4,
};

