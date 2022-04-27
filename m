Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD0FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 05:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5587210F026;
	Wed, 27 Apr 2022 05:52:26 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D8310F026
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:52:25 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id i27so1207877ejd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 22:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=/Gl29Vm/dhmsAQLQyoMOaSrjuWEFdPUoT3TJCs6H348=;
 b=INh6mxtmmJPID7KVFxS0sGfjlfKLXN/7X8atvk4pIHcIYwSks2fv/v+bncuuPezip4
 1eJItWq8rzjhACPzCwHA+8QAOvhkVwF3+DnKUnD5CAfJqqXNt0bRBdGC6MkYiRriz21G
 U1fkUfUttOOoLuOXUjCDJ5CQhdHCL/rLU7F93dQuMz0arumNq5lsTp4eTJPJfm4sVafF
 REnByI+3KlzlCFjpV6CMh24B7jrRFNk0mi0yEI+7jKKnzjrK5KZUzP9J5ynQ7EPVuuLz
 dR8+5/o8WBIxYNF+9/vi3fYDWpPDeGa4ruIKpsb8dj9jZ9pYBEgbyYh2JIVHEa3MvL3n
 vseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/Gl29Vm/dhmsAQLQyoMOaSrjuWEFdPUoT3TJCs6H348=;
 b=vy/dsewgSd1yLA4F3fyolvhdXvDmBJfolgz8BivJAZeiTy4Jz48GrDfaSTb1iuGCMW
 x91syeTuMPyZO/cO+mGMk4LDFwuriFPE0kIV7zwbboCBw7mhTRil3bvugs0EkSdoAdt5
 wRGJdtcmApHLGOoa/IksiOVgLbO56Y+9OTBRxHWHDVnScZJx8O2EgHZZCXGOR/XWVKTR
 uH7Q/dw51sfBVvy0rimEInp9gwRrQY6ww0yTWD+z7qXdPjroOpkyyloLqNteY5Dlgel7
 jm/gAJ6/clToo1KZeRAtAqN6cEhkVzdcdh8I6SWaq9CqS//G5NKIcO1k0dNe86q6/cWQ
 Jzrg==
X-Gm-Message-State: AOAM532TqTxHNmHD7v3FC/oF4alRfUsQcXuXwOVAliAHebZbgGe8Z/vX
 R/4mVrFgirmNXNmP5jGwioP/gAeJz+8=
X-Google-Smtp-Source: ABdhPJxs3QnQysnHdfyCuuQTARtXbm8R9G8fWsucja+iG2/QlVNSt8HeAD0t34KyxR89frkMjVd5EA==
X-Received: by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id
 d2-20020a170906304200b006cd20ed7c5cmr24806558ejd.241.1651038743824; 
 Tue, 26 Apr 2022 22:52:23 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 x1-20020a170906148100b006efa8a81a52sm6030309ejc.120.2022.04.26.22.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 22:52:22 -0700 (PDT)
Message-ID: <cb29a75c-b969-6971-63e3-82750787b3c3@gmail.com>
Date: Wed, 27 Apr 2022 07:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] drm/amdgpu: update latest IP discovery table
 structures
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

Am 26.04.22 um 20:27 schrieb Alex Deucher:
> Add new tables.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/include/discovery.h | 114 +++++++++++++++++++++++-
>   1 file changed, 111 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
> index b25026c3ec96..f150404ffc68 100644
> --- a/drivers/gpu/drm/amd/include/discovery.h
> +++ b/drivers/gpu/drm/amd/include/discovery.h
> @@ -27,15 +27,19 @@
>   #define PSP_HEADER_SIZE                 256
>   #define BINARY_SIGNATURE                0x28211407
>   #define DISCOVERY_TABLE_SIGNATURE       0x53445049
> +#define GC_TABLE_ID                     0x4347
> +#define HARVEST_TABLE_SIGNATURE         0x56524148
> +#define VCN_INFO_TABLE_ID               0x004E4356
> +#define MALL_INFO_TABLE_ID              0x4D414C4C
>   
>   typedef enum
>   {
>   	IP_DISCOVERY = 0,
>   	GC,
>   	HARVEST_INFO,
> -	TABLE_4,
> +	VCN_INFO,
> +	MALL_INFO,
>   	RESERVED_1,
> -	RESERVED_2,
>   	TOTAL_TABLES = 6
>   } table;
>   
> @@ -96,6 +100,24 @@ typedef struct ip
>   	uint32_t base_address[]; /* variable number of Addresses */
>   } ip;
>   
> +typedef struct ip_v3
> +{
> +	uint16_t hw_id;                         /* Hardware ID */
> +	uint8_t instance_number;                /* Instance number for the IP */
> +	uint8_t num_base_address;               /* Number of base addresses*/
> +	uint8_t major;                          /* Hardware ID.major version */
> +	uint8_t minor;                          /* Hardware ID.minor version */
> +	uint8_t revision;                       /* Hardware ID.revision version */
> +#if defined(__BIG_ENDIAN)
> +	uint8_t variant : 4;                    /* HW variant */
> +	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
> +#else
> +	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
> +	uint8_t variant : 4;                    /* HW variant */
> +#endif
> +	uint32_t base_address[1];               /* Base Address list. Corresponds to the num_base_address field*/
> +} ip_v3;
> +
>   typedef struct die_header
>   {
>   	uint16_t die_id;
> @@ -108,7 +130,11 @@ typedef struct ip_structure
>   	struct die
>   	{
>   		die_header *die_header;
> -		ip *ip_list;
> +		union
> +		{
> +			ip *ip_list;
> +			ip_v3 *ip_v3_list;
> +		};                                  /* IP list. Variable size*/
>   	} die;
>   } ip_structure;
>   
> @@ -170,6 +196,40 @@ struct gc_info_v1_1 {
>   	uint32_t gc_num_tcps;
>   };
>   
> +struct gc_info_v1_2 {
> +	struct gpu_info_header header;
> +	uint32_t gc_num_se;
> +	uint32_t gc_num_wgp0_per_sa;
> +	uint32_t gc_num_wgp1_per_sa;
> +	uint32_t gc_num_rb_per_se;
> +	uint32_t gc_num_gl2c;
> +	uint32_t gc_num_gprs;
> +	uint32_t gc_num_max_gs_thds;
> +	uint32_t gc_gs_table_depth;
> +	uint32_t gc_gsprim_buff_depth;
> +	uint32_t gc_parameter_cache_depth;
> +	uint32_t gc_double_offchip_lds_buffer;
> +	uint32_t gc_wave_size;
> +	uint32_t gc_max_waves_per_simd;
> +	uint32_t gc_max_scratch_slots_per_cu;
> +	uint32_t gc_lds_size;
> +	uint32_t gc_num_sc_per_se;
> +	uint32_t gc_num_sa_per_se;
> +	uint32_t gc_num_packer_per_sc;
> +	uint32_t gc_num_gl2a;
> +	uint32_t gc_num_tcp_per_sa;
> +	uint32_t gc_num_sdp_interface;
> +	uint32_t gc_num_tcps;
> +	uint32_t gc_num_tcp_per_wpg;
> +	uint32_t gc_tcp_l1_size;
> +	uint32_t gc_num_sqc_per_wgp;
> +	uint32_t gc_l1_instruction_cache_size_per_sqc;
> +	uint32_t gc_l1_data_cache_size_per_sqc;
> +	uint32_t gc_gl1c_per_sa;
> +	uint32_t gc_gl1c_size_per_instance;
> +	uint32_t gc_gl2c_per_gpu;
> +};
> +
>   struct gc_info_v2_0 {
>   	struct gpu_info_header header;
>   
> @@ -208,6 +268,54 @@ typedef struct harvest_table {
>   	harvest_info list[32];
>   } harvest_table;
>   
> +struct mall_info_header {
> +	uint32_t table_id; /* table ID */
> +	uint16_t version_major; /* table version */
> +	uint16_t version_minor; /* table version */
> +	uint32_t size_bytes; /* size of the entire header+data in bytes */
> +};
> +
> +struct mall_info_v1_0 {
> +	struct mall_info_header header;
> +	uint32_t mall_size_per_m;
> +	uint32_t m_s_present;
> +	uint32_t m_half_use;
> +	uint32_t m_mall_config;
> +	uint32_t reserved[5];
> +};
> +
> +#define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
> +
> +struct vcn_info_header {
> +    uint32_t table_id; /* table ID */
> +    uint16_t version_major; /* table version */
> +    uint16_t version_minor; /* table version */
> +    uint32_t size_bytes; /* size of the entire header+data in bytes */
> +};
> +
> +struct vcn_instance_info_v1_0
> +{
> +	uint32_t instance_num; /* VCN IP instance number. 0 - VCN0; 1 - VCN1 etc*/
> +	union _fuse_data {
> +		struct {
> +			uint32_t av1_disabled : 1;
> +			uint32_t vp9_disabled : 1;
> +			uint32_t hevc_disabled : 1;
> +			uint32_t h264_disabled : 1;
> +			uint32_t reserved : 28;
> +		} bits;
> +		uint32_t all_bits;
> +	} fuse_data;
> +	uint32_t reserved[2];
> +};
> +
> +struct vcn_info_v1_0 {
> +	struct vcn_info_header header;
> +	uint32_t num_of_instances; /* number of entries used in instance_info below*/
> +	struct vcn_instance_info_v1_0 instance_info[VCN_INFO_TABLE_MAX_NUM_INSTANCES];
> +	uint32_t reserved[4];
> +};
> +
>   #pragma pack()
>   
>   #endif

