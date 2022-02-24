Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB9AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 15:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41F410EA64;
	Thu, 24 Feb 2022 15:43:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A3B10EA16
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 15:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0wv5vy2bG/Ng+Pu2nUtuqVx5nYVs5f4+Ue52F05tf8o214pWhAEm1DYkyIzCSLPjVNxBjqWFIRzsP5GNqviUzphEZj0ljvQDD5Y2ytocS7aAUcVSW38PCr15JBpTPCuMlONZbkrb2/SPSTiECO0vo5MDsmcj86XmSluiWLA4sCEFgiixLpz5/uoHUyqys0Q8the6yYSe1MCP7lSWX6a8iyECfO1S4FeUkDngi14MG9LmypLEUEYQn5MamecLuNmt4yWrmtZul3TTKNm7EulPyl0C9sUR7gZVhL4dEvw5SM134UI6QaOaPxi8N/b3zxerBi/q4tcwEI7rQci6rCm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP6/QWxh69uEfFpz7G0tkTAk8waJIU1+0tupi/YNNLA=;
 b=BE3/JqZPwMM7eXwlWW7FM90cEOReBrP87NTib7R5auRdFy23pxd0JHDNj6vikOS7nu4abdN/xNhgNNtAxixPgOlMYooZtQSGzP1RxAr0VggEhbMV6zhKWnigMq9K0LjrFhgqdXyWdEf1Zxez2I0G7iQPyVZIQbhPBHjLmB6LtkWWdTph726Nc3CF+4ukOrwYT36f3qATNs/IiJbL4aTxbYNsW2oUPcgplWzIxvRUdixfdLvSc6RHDU8F+FIPJzQqbReamQ8NaY8SPjqmx7M1PXHdGjtYzrF2hwuUWpALLELp1DbHlFtxhyGGbLT9Fnl0M8jBwGriWmu8n6GKjT7VIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP6/QWxh69uEfFpz7G0tkTAk8waJIU1+0tupi/YNNLA=;
 b=qo+VCnwEN51JFbYu8dJCX8gqaubQtS8KrIvQl2i6RuEo9rIigs09CzBZbkRUX9RnArDDM0ZFmxweJzEl3fJx1KfHlmsrQTnL6itnx55lXMxQmr1kvM4KaFPHCyI98vOCmrDz3LU3/rs/79/s9QnMm/ng6o+pyw/tJsNF2JpuWZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:43:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f%5]) with mapi id 15.20.5017.023; Thu, 24 Feb 2022
 15:43:06 +0000
Message-ID: <ff21cadb-73d3-21ee-8876-ffef10053cb7@amd.com>
Date: Thu, 24 Feb 2022 10:43:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <f55192e6-3f85-715e-6b5f-9b188a7ba949@amd.com>
 <20220224005418.23426-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220224005418.23426-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37cc68f5-f93a-4a6f-6612-08d9f7ac5a0a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2489D51D0EB8CEF511199001923D9@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Or5PXbVVVCl7qST2Tvt06Nf08PBm+ZB+U/zjecVBIsBpa4XowFf+BMNmX0SNxqNp8scuo6Adu8xkNtGKIs3FeGUg9SvAkO7cirkHaBoti+mbMQHVH0PjbvFRZ0AVOM1D7mt4zRcWULkSx4TE40VQDYuLbKCalF09medBQv95I0Tom3A1OZL3fMIJz3OL5weGAfNGcx7tUgFabA6L75PZL9L8wC5rYyE2lnBZ6zd910S+5JcUFhpA+iD5mldk06l5Gi7ToNv9V6VS1g8SKQvQ3H6AmyPdCnRAnqIkB2A7TKBlXH2aaUB6+RANSFLhsVsI1cRq29y7A/QKa7DP87T8H0duUXgPu6X2NJ3DsvslZJEaxrtmCPmbD5e8POZb8vbdLWOB2dxFRvKFDG6Ts8/yxm7CYBqG46QIIZqzoQyk6Hpwnxou/hrysNBd81pckb8IQo2vD443xOdpWXlO98fmgtQeaz6oE7gAHUbnxpxhtiYkuy8jOpli7OXnlMfBmsys/Dve/aC2tACOebEQQCu3esV8Lv93HeI2wmWihQtlI25+CHRMeWI0pOJZPVS5hgBz91d8KqMhIxFWdtW/C/8QjtzR+9eSGuFDqFfQ3dJlKRqfDzBIG7SOlG9m4QOpe2OVQhCdriHgS8Nyzz2OLjs0hs34kub6gjrqixbQbvL7Q8v15UBw1oj3OhcM8vTYS4qQRMjZ1oivOw5EAPdANmuGpEhw5aPGaUVC4Hc7oq5IbXXHrgG6RAthBoh3ND9/Cm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(66946007)(31686004)(38100700002)(4326008)(66476007)(8676002)(26005)(186003)(66556008)(44832011)(83380400001)(6512007)(2906002)(36756003)(8936002)(508600001)(6486002)(316002)(6506007)(2616005)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZGc0wvclpSTlF4ckgzQW1hYzZuQXAyRy9RcmdtYnNxV253L2NLV1lnZ3VM?=
 =?utf-8?B?ZXdESEltVHlwNFdPcjM0azk3VUl5Q2dIVDY5NldOMFpwd1ZBUUtFbmtYUVJE?=
 =?utf-8?B?amMrY0U0dEVYd3V1aGJRRWVMc05ta2F2QVB2MytlZTB3UmZIcUZrOHNZR0xI?=
 =?utf-8?B?WXc2cE9LUWh6OVdCRkFIRmJmc3dobkp1T1QzNnQ1Mlh5TjFDWGVqdEsxNmdN?=
 =?utf-8?B?TzNGY2M4U3doNE5GbmtBeENrMnJ5ZjFUSjYyRG9oaklBL21kZGFsWDRIaXly?=
 =?utf-8?B?NS9scTQvM3ZlQU93cy9BdEwxOGtIbzU0anU2bEwwSGN6djlvY1dwMWUrUG1a?=
 =?utf-8?B?bFF5TUtLeHNDR2ppcmU1SzZjaWVqTEE1NlZsWDd2cE9zZGlxMXd5V1Awb0Vm?=
 =?utf-8?B?NWxMRGtZeDNUNXE3UmFHelZieFlSSXdIMVlkak9KRGlIVWZvdGcycEpocU4w?=
 =?utf-8?B?U0hzTVA1ZFdONWN0TGdhT2xhcEpmaXcreE1EQTBtUzIxMi9BamJDZ0YyZVBP?=
 =?utf-8?B?NHVkeC92MEYvWWlCRDlLRHVjenRFaDZzS1dTRUUzbFRKMHpWMjhUR21XTm1h?=
 =?utf-8?B?N1hKOEYyeDJlRWduM0JrL28rWlAwUHdtNExQaHgvK1ljdXN4ZXVHdUhLcElt?=
 =?utf-8?B?bGs3L0VzZjJ1RGkyMHVhTEQ1c1VpVWxPQTdFaTczbUFrREszaVd6a1U1UUtG?=
 =?utf-8?B?NTJrMGJheXpkUnRFN3pTaVhISWwrbEFrWEFNNUdGU1BSZEhHcklNb2taSzdW?=
 =?utf-8?B?QUlGUW5SbGtsTnEzVUMxT2Y1MWxDaVNkaVY3QXU3TG1xcFVwVnFOSnZqT2ta?=
 =?utf-8?B?UHVUZ0N5djEyc2ZtVlBGWktIRjBnUnBUNE9OU1U2NUx2endKcGFvNG9sK0th?=
 =?utf-8?B?dGJZM1RsTHJ3akx3Y2hKM0o0NFJWREtCeVIzQU1jY1JGbGYwV01uaDdHeVlR?=
 =?utf-8?B?aElqT0xNVnpZTGxONjNWdytWSFFYdnVtdWI0OTF1em9KNEM4T2kyUFZ4RmVz?=
 =?utf-8?B?UE50dHFSU2o1NzloZVVQVlY0WlRaaGNGeHJsOHFObXdRSGlKbkRjV1c3bVlE?=
 =?utf-8?B?eEpyU2p6RGNPUlJ5N2pjOHdTdWF5WFllNUJPeUs4T2h5WWF3YmtlSWZqOTR2?=
 =?utf-8?B?L1FXYVFPTitpWGNQUUJXZmRmUHcyanFsMjNKWkV4cXVrSXgyeUdpTlBDM3h2?=
 =?utf-8?B?dE5JUXhhYUh1R0JGMWphS3VkR3ZRVlY0MUZZUXQ4QVQ5cW9sL0VKUE11Vnlh?=
 =?utf-8?B?NjlKcy9uWDJnbTZaQm5QU1V2OUhJRzR3VlNOQzR0R3dZTllaY3pEcGxIY1Jw?=
 =?utf-8?B?aG45UXRweU9BMDhQVjk0dlN4aEJFV29CalMxa3NXZW5ZTWc0U0trWnFaenpF?=
 =?utf-8?B?clFxdnVXRHRrYnhUeFl4N2hUdUVLMEpQcDVBM2JGSGV1Y2hVL1k5aXcyWC9C?=
 =?utf-8?B?OVF3SXJLbXE5UFMwRW5Mc0YwenE4TWNzQnY1WWM0b0F1UkUyNWJ3Y05FVXZm?=
 =?utf-8?B?Wkd1b1F0MXF4RmlFUXNsRGtvMWRsK2NsZ1g1U0dRY1llek9UWkRjRXIwdkdo?=
 =?utf-8?B?QlZRTTlyS2dwOThSRnRHeE4zZm5iYW9KUTNtUmFPczJMV0FicUVVSlowZnZ4?=
 =?utf-8?B?RWd6Y0FlSS95Uit5ZnM1SXFYN3NGZXo1Vm44UjY0dW9IRGxFWWoxRGZBNWhZ?=
 =?utf-8?B?VHJJNVVEd0tDbFUyYUFPblNwc1c1UHJTai9tTE82c0JadkdxOUhCVHpWd0Zm?=
 =?utf-8?B?cHZGZXpjenV2QmpwdEhzTjkyS3FQanIyakN5UEt6NnY0bXBLcVg5MW9qREZG?=
 =?utf-8?B?ZzQ3OE9hVHBKSDRFbVVnMlFYWkhFM05xaG9PTittcDBvMWltNmFvWmpyeGxx?=
 =?utf-8?B?ejM3NTdiOElEQzNBN1Fadis3alcwMEUrZUhCY01hM2FwVVpoclV6YWJadStF?=
 =?utf-8?B?Q2dsUjE5NHRTWHUzUnlLbnF3cEpJVjhsM0xQbE9QMUxYdlZiZm9xQ3JPS09l?=
 =?utf-8?B?YXlmb0wxa0tYN3k0T0lNejdQSFhVQXA0QTBsQlBLNTBZSGtBS2pCUTlEenRE?=
 =?utf-8?B?Z1BLbnYyMWJtc01VVGVIWG5VR1JseDB6bHpIYUQyeG5UMlNqUHBMeHRKTERH?=
 =?utf-8?B?a3ZlcU11QjlTNmRQK1I0bGFuTyt2bFc4NVNIOHBwMkhVTVpobDhCT1NCS3BF?=
 =?utf-8?Q?G6XmLDIXXBdI0qbjkSgw37s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cc68f5-f93a-4a6f-6612-08d9f7ac5a0a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:43:06.8108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaO/47IMTp2ms4fSmqcQm1xHarrI5f/T4dx0CePBaecmyEHxSoXOi293m/vTm8XALjhxuvk8z/ag7Chj/n+BVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
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
Cc: jonathan.kim@amd.com, Harish.Kasiviswanathan@amd.com, luben.tuikov@amd.com,
 aurabindo.pillai@amd.com, alexdeucher@gmail.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-02-23 um 19:54 schrieb Alex Sierra:
> This parameter controls xGMI p2p communication, which is enabled by
> default. However, it can be disabled by setting it to 0. In case xGMI
> p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
> This parameter is ignored in GPUs that do not support xGMI
> p2p configuration.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 3 ++-
>   3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f97848a0ed14..7e95d8bd2338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -217,6 +217,7 @@ extern int amdgpu_mes;
>   extern int amdgpu_noretry;
>   extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
> +extern int amdgpu_use_xgmi_p2p;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2f8eafb6cf22..2849972fd910 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   int amdgpu_smartshift_bias;
> +int amdgpu_use_xgmi_p2p = 1;
>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
>   	"A non negative value used to specify the asic type for all supported GPUs");
>   module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
>   
> +/**
> + * DOC: use_xgmi_p2p (int)
> + * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is 1 (enabled).
> + */
> +MODULE_PARM_DESC(use_xgmi_p2p,
> +	"Disable XGMI P2P interface (0 = disable; 1 = enable)");

The documentation of the option is misleading ("Disable XGMI ...") 
because the option actually ENables XGMI P2P. Also document the default 
here as well. Usually I see it like this in other options:

 > +    "Enable XGMI P2P interface (0 = disable; 1 = enable (default))");

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
>   
>   
>   #ifdef CONFIG_HSA_AMD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 0afca51c3c0c..095921851fb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -66,7 +66,8 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>   static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
>   		struct amdgpu_device *bo_adev)
>   {
> -	return (adev != bo_adev &&
> +	return (amdgpu_use_xgmi_p2p &&
> +		adev != bo_adev &&
>   		adev->gmc.xgmi.hive_id &&
>   		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
>   }
