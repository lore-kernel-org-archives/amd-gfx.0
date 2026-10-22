Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779060A2627
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qxCoc3+k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68FF1126A1;
	Thu, 22 Oct 2026 14:09:59 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C561E112691
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 14:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBX1TsJUdzGVtzk1F3mJcpnyurFNr5MFk45gcXMxQTgj4DVfa2L/Uh6FlsslA4HHYZDj7b7SJWawYdVMQ9fc+VDki/Q/X/2BIPZ52H7vA2Y1dvcVFAQHafsCO1q4RnE9mj3h+GWV+m+LOgn2k/jd9MUZuxg0OdBgcp10WN4G9zvhpbGqQOhe2kn+do2v36H+wMvudRloE1g5nbwsuAG0ivFHUVSMgCpm3/cQ3X41XHi/DIFam8FPplNMIXHQE7YjGm+0koQMGEAJ8jNMHBnJlhlDxa+m+GCPtbbES/loVa1c2Kc21qhbQOHBtYTKPitl+F3bGdVCrmW7mRlk/gXvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/cBr6Hc4f8kaoJ/HxymtAH/rNtjBVZoTAf0ii1LviE=;
 b=rKOepl7Dbi5uOHEZQ2z/kAYBmBEaVUCvPQLyr3+jmLns5jpLP+qXoYcUtuKFFjs82PyGpV8VJGDKwiJCqsyiS+wdWLdp6xq9udDWgBdDnFNK26zLOOysjJNxUuyt/PExAVe5JaA3hAR+xWjjIyGEA7q+Ug/+yM/C3wmJVEotu07sHDZRQRmUcX8N3SUknBEGI633iclr0XiuAu1gvxbCmysNK0cFnRRWynXZAq73xT61XVZ2TlYa7wsmentMC2SueA2HkWFTNsWtnjIMNHF5TJ/tcu4K2lhptDmbPC2n6fikksCARaowfXesNA6CPL2jFHyPJqTXbVFGyHCgC7BF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/cBr6Hc4f8kaoJ/HxymtAH/rNtjBVZoTAf0ii1LviE=;
 b=qxCoc3+kWgGl0zGjrKmSzh9y38HRjWWcnHHFONa9GbBxQiwSH+7gzSM7r5scYxK5xGkEHYohEqKebHafO5GsPJ6HhR+54pQZD073K9llYMQQhZkAdx153zyUKHcYIHMfJgnVWjBPnEh2DrVqWxUXEsT8jwU1LOg3qT24gNxLEW0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:09:51 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 14:09:50 +0000
Message-ID: <f4f05437-8fc9-4916-b878-2479db75a8f4@amd.com>
Date: Thu, 22 Oct 2026 19:39:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: Add a metrics revision for SMU 15.0.8
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Kevin.Wang@amd.com
References: <20261022124917.2232285-1-asad.kamal@amd.com>
 <20261022124917.2232285-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261022124917.2232285-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0135.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1364dac9-41e4-4707-7d60-08df30462305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|261021121427099003|261021123027099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GsgyYksBfMsULUEoBcVpsvN4KpTFRQu7L0JlKX8XUXhCxiAu3GZ/xJBdPFlB0UUgMkk8avJpNwlXQt0lnC08GlDJEMxDyy0FxNN7nHN5Tb7ThEidk6bMvXpiHE699ONNgpbs5PemDjgqe1EkWTjSz0EtilKuHlD0WOvxNXYqkXShXKVbVgBMp9BzUqA+VEB1p2zXBlVobwNJyTbkgLqSWk8F8aUpriWcTFt3/xhUYlZ8TsJYXF/I2++Qx2AICc8jTMPPP90YoV/Uz4gBPotJLdb/1xbPHUq4LfgLiOAa4WDhwGTahgSyeLu9cEVKcObEx8V3D56eLZvbiRE50NE05FZ3thGoEz6rXbmQNTIwQun7wrC85Jv/ODwHnktt5517qgjqBTvmlXVbUwFumv7jnZscE7cWYBaA45imifNCUf8U6HDAq6sb+HfQv1UA1Da620Y6zhinYJNZnPp6FbrUMPdVz8f02MEf1duR1FJw7vcUHTj43AIwwMfxp+YXOcP0G8c9vqenzWF4r09y4UYLdoXh5pAcGNT4IFAIpDiSR2X6b0qehz7+/0LlZuXFBEoGbZNAY0DJAtOD1cNbRL55BoTAWHKCCt87N9urFDsLAKNHD6yXfXyf2TCu5y2o8BzyKqyChUXf1F73Lc8h9q5aKFRVs/KG+VlpeYFchECzK5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(261021121427099003)(261021123027099003)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWd1Q1ZuellCbFNDWUpEQVJsYWdRVEJmVzd2TzhWNHhiSXYzZjBEYTJkVi91?=
 =?utf-8?B?QW1RaFk1MGFMa3RxdlVyYnpzTVZFY010c2xsUVkzVGtKdGtPTXhiVXVudnB6?=
 =?utf-8?B?ak9sdXlKZTlrUFpPUmRPRUxzVndHU1FUTytsN1pEQVFVUXhRek1hVyt0V2dn?=
 =?utf-8?B?TDV6ZFc4T0tlR00xMUxHdDBTaDZqeUZESStjZmt6WGpCRlBnNFp1VWN5Wnhn?=
 =?utf-8?B?eVZBTldqWDJ3L1d1VFdweHplMS91bDNLZ042RmE3TVF4MHlCR2MrOUNNUnJK?=
 =?utf-8?B?blBYSFM3MGJ1UkxGSXkwYW9uM0lYY0lGeU9oV1BpanpRMTQzVHFvRWhrdHJl?=
 =?utf-8?B?YWJjd1U5TWZBOGU3UHFLc3RyUERaWGd4bUxGaGFTR09LUnUvZHNCUkkzOThi?=
 =?utf-8?B?d0lRRUtOUlE5TW9saWlOYzE1RUFOdHRlRlBlNnA5K2txWERDZ0tMOFBFdi9i?=
 =?utf-8?B?RW11WU9rR0JnUytzZUErQm1velhhN1hJNERMbFp3T3NwOTRTbjY1akMyM3or?=
 =?utf-8?B?NUlZM1E4T3BxVkZqSlFHQWQ1aW55cmFnZzhtaTBkZXc0ZHVzSGhzSlJabTNv?=
 =?utf-8?B?aVpEOVc1L0xnQW9iWEFubFZuYlloUGVMS0tiOHN2dCt3UmhjTytWZVhFY3Br?=
 =?utf-8?B?Ny9rQ2dqY05oVmEwdU5uWHgrcFA5NkVUN2tiblcrMjh6VitCTnRpMUFEdHc0?=
 =?utf-8?B?WlV3RzdpZ0U5SDRXcFd2ZzFaWTZHdTIxR0VyQXJNeXBqMzNRMzZMZzdMYkdh?=
 =?utf-8?B?NUtCa2RWTXh4Y2wxaXNQZnhLNmZ6YUtIMDFDWmN6cDFBMkFsMHNQNmwwRXky?=
 =?utf-8?B?TmRLMlc1K3JXVGhUVXp2cFhVeTFFZklIUkRBaTFYdnpIdFNRTHF2RU1iNjlk?=
 =?utf-8?B?dWNhTkx1bUpvcDNjTi83citHOEovQnpDUERmbFBiMjZqVHVMK1FHZko4THJj?=
 =?utf-8?B?RmRHTjUwV0ZxSkNyL200OUZQL25ZVllsZHZIeGYzU2E2K1F5YzF0MzFKWEhN?=
 =?utf-8?B?SytJWHh3Z09UZzFDL2JVa2FiSGI2SS9yck5MM2h2YWxBOC9sWDJOSFdTZ09I?=
 =?utf-8?B?b1Z2cXBDZWRXTUtqTXNLSjhUM2JjU00yTWw1Q1ZvOGQ1bWN6ck1aU0toaHIz?=
 =?utf-8?B?eXRYbFJ6TTlGekFDQ2tidWcvbUNKeUhaeE9xQ2s4TVFaQkt6TUp2QmExeWV6?=
 =?utf-8?B?Z25MYm4raG5NTXNqeEo2RFR2QjlFVjhQdUdicDlBdytlY2xOZ2drTmdVbzJk?=
 =?utf-8?B?SUdEcU5QMlU1aE80VU1SMkhjRTU3Z3FadFVIcHc3WDBYcFRkckRLbmRKRXBT?=
 =?utf-8?B?ajRRdmcyWVJoMThTdjZSemlOOWV3UEdTc2ZpZVN1d1B0YWx1TnZxQW44Um9K?=
 =?utf-8?B?UXg2dzNWMHI0ai9BOC9jWlJYL3psYmN1SGlOcTcyUG5BZEJQd0JGMlBwRUpO?=
 =?utf-8?B?alBxUjRMOFV6cFZyOFNHY3QwcGZmajh2MHVrZ29vWlFjZG5hc2l6Vjg5SHQ5?=
 =?utf-8?B?VmJiQXFYaHZYbEFJWW45SFZMRGhrMmFDRmY1Y1RJZFFwMytSd3puVm1tS0c0?=
 =?utf-8?B?QjdvSjE1U1A4aVg4L1V6N01HOERoRXNTT0R2dUQwTW51bFJOc29KdTZxQm4x?=
 =?utf-8?B?aUg3Lzh6ek4zMFRJY3lzVm5SdnY5aGRNMXc5S1JoUzl2Tk9NamllQTYrR0Mv?=
 =?utf-8?B?VHhMNk1BMEQrNW1TcUg1K1lOU1M5MC9XWElTUHpxbDdySDBOUGJCcEZFRFBk?=
 =?utf-8?B?Nk01LzhXOUZyNmV6N2FsN2lnUW9FY3NmQ1MweGw2b2VsanplN1NMZXhmNDZF?=
 =?utf-8?B?Z0V1dm1IQVRKZlZ3T1JoYkNrRWZIdlBKam5DYjVKMm1Ec3gyVTVCWGx4bUtP?=
 =?utf-8?B?bDR6Y3hRd1FlN3R1bm4yaW1oY04yUWhUMHIwMDBXSEx5KzNDY1BZKzFpZzN2?=
 =?utf-8?B?SldNTFpoUUt1czlIZVhpYkFRRHFwV2NZRWd1RjgxR3VsKzl3d1pXMnRTbUY0?=
 =?utf-8?B?VjIyaWJiS0h0RDJ6UE5pRktYa0I4WERERUpES2FZemduRjNVejJtcUlPeTRi?=
 =?utf-8?B?VnJqbXVvZm1uaFd5OXUxUi8yNExHaHE3Zk8xbzN5YlBTWTRlSUVYMnZuY2Js?=
 =?utf-8?B?dTlXN3gyclllOE9kQldJUDdCZWk1TUpjVWxQL3YyQTFFT1FPTWNsbThXeSt1?=
 =?utf-8?B?c2ZXaVp3OFdXSEFuT05rK1c2bk1yRWNVR2l2b0creEZ6WmM0VHNVRFJpa2dR?=
 =?utf-8?B?dEkrZGEyK29OMEJtKzFOL0ZtU0NYaGo1eUhNVkYrK1RsZVk5U21kclo2OGVW?=
 =?utf-8?Q?efaV/abM9NOGVa2So3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1364dac9-41e4-4707-7d60-08df30462305
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:09:50.7224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddXkdzVg17af/DW3j7/knu2Bim12hHW98gHjg3seYIYNIQcT7y4WLLcQwvkzjIbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 22-Oct-26 6:19 PM, Asad Kamal wrote:
> Publish a revision attribute from the SMU 15.0.8 GPU, partition, and
> temperature metrics tables. The value starts at 1.
> 
> Increment a table's revision when its fields change.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  6 ++++++
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  | 20 +++++++++++++++----
>   2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 82c2a379ba4b..22c8fe511fb0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -1652,6 +1652,8 @@ static void smu_v15_0_8_fill_baseboard_temp_metrics(
>   		metrics->SystemTemperatures[SYSTEM_TEMP_IBC_HSC];
>   	baseboard_temp_metrics->system_temp_ibc =
>   		metrics->SystemTemperatures[SYSTEM_TEMP_IBC];
> +	baseboard_temp_metrics->revision =
> +		SMU_15_0_8_BASEBOARD_TEMP_METRICS_REVISION;
>   }
>   
>   static void smu_v15_0_8_fill_gpuboard_temp_metrics(
> @@ -1717,6 +1719,8 @@ static void smu_v15_0_8_fill_gpuboard_temp_metrics(
>   		metrics->VrTemperatures[SVI_PLANE_VDDIO_065_UCIEAM_C_TEMP];
>   	gpuboard_temp_metrics->vr_temp_vddan_075 =
>   		metrics->VrTemperatures[SVI_PLANE_VDDAN_075_TEMP];
> +	gpuboard_temp_metrics->revision =
> +		SMU_15_0_8_GPUBOARD_TEMP_METRICS_REVISION;
>   }
>   
>   static ssize_t smu_v15_0_8_get_temp_metrics(struct smu_context *smu,
> @@ -1833,6 +1837,7 @@ static ssize_t smu_v15_0_8_get_xcp_metrics(struct smu_context *smu, int xcp_id,
>   
>   	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
>   	xcp_metrics->firmware_timestamp = metrics->Timestamp;
> +	xcp_metrics->revision = SMU_15_0_8_PARTITION_METRICS_REVISION;
>   
>   	return sizeof(*xcp_metrics);
>   }
> @@ -1993,6 +1998,7 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
>   	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
>   
>   	gpu_metrics->firmware_timestamp = metrics->Timestamp;
> +	gpu_metrics->revision = SMU_15_0_8_GPU_METRICS_REVISION;
>   
>   	*table = gpu_metrics;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
> index dff601bc0f9a..59fd8a31ae1f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
> @@ -35,6 +35,10 @@
>   #define SMU_15_0_8_CAP_NPM			1
>   #define SMU_15_0_8_CAP_NODE_UNLOAD		2
>   #define SMU_15_0_8_NODE_UNLOAD_MIN_FW_VERSION	0x027d0c00u /* 2.125.12.0 */
> +#define SMU_15_0_8_GPU_METRICS_REVISION			1
> +#define SMU_15_0_8_GPUBOARD_TEMP_METRICS_REVISION	1
> +#define SMU_15_0_8_BASEBOARD_TEMP_METRICS_REVISION	1
> +#define SMU_15_0_8_PARTITION_METRICS_REVISION		1
>   extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
>   
>   typedef struct {
> @@ -181,7 +185,9 @@ typedef struct {
>   		  SMU_15_0_8_MAX_XCC);                                         \
>   	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
>   		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
> -		  SMU_15_0_8_MAX_XCC);
> +		  SMU_15_0_8_MAX_XCC);                                         \
> +	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
> +		   SMU_MTYPE(U16), revision);
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
>   
> @@ -251,7 +257,9 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
>   	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_065_UCIEAM_C), SMU_MUNIT(TEMP_1),   \
>   		   SMU_MTYPE(S16), vr_temp_vddio_065_ucieam_c);                \
>   	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDAN_075), SMU_MUNIT(TEMP_1),            \
> -		   SMU_MTYPE(S16), vr_temp_vddan_075);
> +		   SMU_MTYPE(S16), vr_temp_vddan_075);                          \
> +	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
> +		   SMU_MTYPE(U16), revision);
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
>   			  SMU_15_0_8_GPUBOARD_TEMP_METRICS_FIELDS);
> @@ -309,7 +317,9 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
>   	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_IBC_HSC), SMU_MUNIT(TEMP_1),          \
>   		   SMU_MTYPE(S16), system_temp_ibc_hsc);                       \
>   	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_IBC), SMU_MUNIT(TEMP_1),              \
> -		   SMU_MTYPE(S16), system_temp_ibc);
> +		   SMU_MTYPE(S16), system_temp_ibc);                            \
> +	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
> +		   SMU_MTYPE(U16), revision);
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
>   			  SMU_15_0_8_BASEBOARD_TEMP_METRICS_FIELDS);
> @@ -343,7 +353,9 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
>   	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
>   		   SMU_MTYPE(U64), accumulation_counter);                      \
>   	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
> -		   SMU_MTYPE(U64), firmware_timestamp);
> +		   SMU_MTYPE(U64), firmware_timestamp);                         \
> +	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
> +		   SMU_MTYPE(U16), revision);
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_partition_metrics,
>   			  SMU_15_0_8_PARTITION_METRICS_FIELDS);

