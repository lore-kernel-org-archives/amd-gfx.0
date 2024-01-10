Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39B1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 05:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573B210E043;
	Wed, 10 Jan 2024 05:13:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBDE10E043
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 05:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8R8knL9aIMMwxLLrYWgO55MUgWJmnSkHZggfRIT2OrIBb4xBLiRVuXjGcIWyEalnnm90PC9eAxeJWo/Qa/ttsIJA3ohtlqvdvwJO8UhuQdn1X+sLTDZdAnpQuf+oSt50vXPa/Vu6Rz+znS90Jng3nv//ziA+OMFjaWCIrRQYYbgSaYWhH1FT/NWv1UGm3hmGtxDcHNtiSk7cv/ix23d9ySch5kHLDpVtw1FOAKJ01L+pTcgO9e7Vye8d4rltK+ptd+Ybx/b4xh4OudwsZvfXJzsy5ZqwaWUOp7Q7TZ2si6uU3iw/i5j25lX4t8g1AoOAraVVo+snySdYa2tqs+pQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6343dnv/BAiOakwOeJMTX9MJWQ/3NG6BsmHRyppI3aQ=;
 b=Xf4bcs8rPLEZ0nNcpUdbq5dTRPJ4qzWz3DgJyF+RxE3t7g2ES3/EcUf+v0UG+sWcToS2HXoy6gS9xHOZpoVScorj0Q6F64WYHXmQIVa09YPpnOX8IGJO7LjQhaGmjpYZC1A1SLbdU9IO2hDJt55vHsegzdUXkk8pFtI6FCtrnVlJlgYtafi7A/Wuq6NSFXH1csvTHEEpQnV/9xUqFVYK872xgPyWn94IUOcXDkR//K+v+Jb6m+AIs5hpOTNH+B4eTR/5tZKTSqohqUkQhYXV4WU7VAzCKJjUAjZGRuobb3387zJ8Zx2gCGK/49q8lX1oUm0Czs1BlvD+E+bfYMz59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6343dnv/BAiOakwOeJMTX9MJWQ/3NG6BsmHRyppI3aQ=;
 b=vg0qqDyQ2udEZZNWXuPnvnrCOf8WtAi5gHRRd268EqvanJpLmjt5K+b/CSycMoAVcsdFA4+5AQTSdQM6xbACVDasuTUBVSl+gcT9lbJHO9LChObzz8nSvreqzvv4HiGWFPa39junnNOrmBI7NWfLkghDb526GrWrGYcvnzz9BkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 05:13:06 +0000
Received: from SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635]) by SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 05:13:06 +0000
Message-ID: <7996197f-c465-4023-8646-dbe30731d32e@amd.com>
Date: Wed, 10 Jan 2024 10:42:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v2] drm/amdgpu: add debug flag to place fw bo on vram
 for frontdoor loading
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109130008.30294-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240109130008.30294-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To SA3PR12MB7808.namprd12.prod.outlook.com
 (2603:10b6:806:31b::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7808:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 024e45a5-02a4-409c-5a43-08dc119ad3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQjayw5SbqU0+AUf6NMd7JGD0yObMbPH7KK+Hq7wg7zcseRexWxy2mCEYh0kpnlIdw37TAvratl9hgIKnjUUUa4CBdy9dbt8pY2dKUw/mWtjQN8uIpYNLl1BI4qugJvw444LtcYwrniTCYbM5QEJ9/51n0QoboiPKmrE+srrx8xrfSg0S/L79LJa6nOpE/8RGUc+3DpkfbuSRrgVzH2S5DVVIl4cwBMqkz4ampTtq12dPgxKyt9Wzgv/mtpMuXbv2zNVad4Dr8SMuGBX5tz74EIwMMSzRUl0OMnDHsmwwgyZC+0issUdhCixnIvIAAVqASt+ZFuSDBKoymMC1wUfXAadPoVSgBOXy+C6z7tLcDydH611TaKElL8eW0fhoQ9qHFy+yxxJg9wdDck2IF5Jh4b55BVoeoAkK76yq6cqGHp39JDIh2vCFzrBT4l0ZLnuZCJ0wG6r2+orRdQLVKVdPUfGFJSPWj29CaW8J2u1YvIfm2F9YzfmDSKEtYHtt2d+B5QjmjyqgFH+KMjJ3lmB8R4oajhqW/t4t2LtG8F7bg9TY3SaIQ5fszubZKSevtGVTFHUmUxkU7XjEImIs1bHo81fh2QO7UaHKv/HAqjFa2o5Iy7Py/41fZ2ZvEiW8/ZseDCoO/vwTxQ+o/0dVNTUVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7808.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4326008)(66946007)(66476007)(66556008)(316002)(8676002)(8936002)(26005)(478600001)(2616005)(31696002)(83380400001)(2906002)(41300700001)(5660300002)(38100700002)(31686004)(86362001)(6666004)(6506007)(6512007)(6486002)(53546011)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGtncDRrdWVlcGp1KzBXOEh1cUI1NWJINGJnZzE2UHVqT3d4MHExNE1PWnFW?=
 =?utf-8?B?M25kelZGSDQ5SG9ROVA3bkphcW9HbmZYZ21yUHBPaWY4UVRvZFc3aC9jT1RE?=
 =?utf-8?B?cnNzOW1UTGFxYml2NjZhY2V5OFVsa2xTRlVnV3EzZEZ0MWUzN2VLRWRvZWxw?=
 =?utf-8?B?dUFDTXpuN0IrUytQaDdUUjh2N3lxNnRhMjhpaEhKeXpWZ2UxRmJIVzZSc2pN?=
 =?utf-8?B?QWxNNlgzdlV5UEtSVGhGT3QvZi92LzBxcHFZNS93SUt5SVpSN2NGSWY1OW9E?=
 =?utf-8?B?eWJlSndnQm1ML01Fd2V0OG1Nenk5a1ppcEJ5RG1VRm1VL0t0c0czc0s0UEd6?=
 =?utf-8?B?VEhRb2NjQjVTMkgvY2dLbk0xYU9OdDBOdkVWa2VkVTAySCtKTHl4YWJiYlh3?=
 =?utf-8?B?bU1lbXRFRTNMeW5UWlRKYnU0MCt2akEzOUNaWlFKK0Y1MmNZUjZpUmNqajBC?=
 =?utf-8?B?TFVTQmM4R3FNdmE3Q2VGMk9oYVdBV1ZsRFJBS0syZUlFL1BaQ0Jra0RpdnJ2?=
 =?utf-8?B?ZStaS01GY1I2cVpHYUg2bEQ0ZjY2Sm5uK0FTZEFCa0JVTk5MUm1FOGRUaFhv?=
 =?utf-8?B?T3ErOHpsRmp5cnE3NFphbFBTaS96WmZibGZoQU9rZDMyY2lTM1FNblh0aDND?=
 =?utf-8?B?RzRaTktPWndMYzQ2ZWZuTkRySi9pNklkS3ZKdmdhRmd6VWhwdGFmeFlWSlJL?=
 =?utf-8?B?L1dMTHhrcGcrRnRpQTk2dTdhMHZmVmpPdDh0SDFERVVPZFovNUVvUlZ1REM3?=
 =?utf-8?B?U01ud2dEUi92dnppa2orWUlmeTBZektwTkRzUjJ6aTRtdHZieGRZcjJlV1di?=
 =?utf-8?B?Y29hRDMrbXVDcEdRRHEzNXJBTkJoeXZKa3IvS0k3L3ZmUzZ1Tmx3bUtxS2RU?=
 =?utf-8?B?Rm4vOVk1VFlObXRJUEp4QmViM0U3UUI3S2FxYU5OeVVOUDE3K3VjNEdwR3NE?=
 =?utf-8?B?YnhSaHJXUU84ZndsTk0rcnJscTlVeTI2MC9xSFZJdWtzbXYyd0FNR2RaN3hV?=
 =?utf-8?B?MkttdzFwOGFvYVV6RjB2VVVnTjdOWHFyYnpYYWIzSWdSVkJJZjVJV0xtcGMx?=
 =?utf-8?B?NUJuU2paL1ZrZE1Dajl1Wmt3ZDNWa3VWKzVnSVFqVSt0QkdYZHloUjY5ZDNo?=
 =?utf-8?B?eE9wZzBPV093K0RObGQ0d0l3OEVQSWVldXJOOFROREZwVG9TbXJQZGRacWRw?=
 =?utf-8?B?WmFwS05Qd3VWTmhSYmFuNy9CTVZnSGxRK21lQ3hDVGs3TmxTV0ZmTStFMVBR?=
 =?utf-8?B?MVpDRTJoQmZLTVY3VWJQbitCSkZuK21Wa0pmZnFQb3dpeEE0bG1GcEpVN1ow?=
 =?utf-8?B?VENjekoyTk5oUDNGTVJiRFFnUThCM0ZoeENrVHd3TlF1T2wyY2hOQUFQRlJN?=
 =?utf-8?B?bUI5OEdQRzVSQkY0SjcvajhuY0NTVmpQUDBKYmVBcmZwc1NkUCt5cUpidHdQ?=
 =?utf-8?B?QUFvbDgveU1xWUJGVGc2cXBRNm1FSE92NURNbzdYSmx0anNSOFg2aEFFSDhu?=
 =?utf-8?B?bzVYNkhkcDlaZVY4cExKSk1CNzgrVjg0c2gyb0ErcFhpL3hPMjhoNGFYeXls?=
 =?utf-8?B?T0VWeXAvL0hoU3plYXZQQ1FTSkVJbEhvcGtuMDVMSGZaVGhPcko0VUhhY0RR?=
 =?utf-8?B?ZEFRN011aGQ5WDhLYU10SVA5dHFVNXE1cUxHNEpPSkJObkJmZjdmWlR2N0tt?=
 =?utf-8?B?RG5ma2lKdnVoTnhRQlBDQnBuQk5mMkR3Zm53VHZuYVZRaVV6NzZqT1Nsa1o0?=
 =?utf-8?B?YUhZSVhzc3ZxT0tyTnFPa0NsN1JKTlJ5VjRvaldySjhIdVZrMHpGZ2x4TEM0?=
 =?utf-8?B?U1JWZVpLek5oV0srU0V0RmdCMkswcmYvaVV3WTBkUGQxeFRMMEdHbmlzTjFC?=
 =?utf-8?B?NXAzTWJsbjZkUkdNeW1weVpsclY5L2RCWmFOTGtSM2dKVFJZcXBqQllwajN4?=
 =?utf-8?B?bDNtT1hNVU5EOUcyMUQ1cVpma3lXL3EwUnFsVlRPeHBsY2MwWGVxUVE4cW5q?=
 =?utf-8?B?MHBpVHRVSGtGWER4VThCQ01KMy8wV2JXYllZOS9KQlFORnArdVdtaW1Rdjdr?=
 =?utf-8?B?UnZSV0tXMENSVnExajFTZjA5bTZxelpSUWRLK2xPam9BUWk5cXl2SUpMVUY0?=
 =?utf-8?Q?7+KProy1UurFPaxxmAgixKivi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024e45a5-02a4-409c-5a43-08dc119ad3cf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7808.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 05:13:05.9843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZIiKQ6Gwr7gXXGx2YRQUQhCq2mh9jSLxXO4zxXgl9yHpyTytfymaS94jHqpqmSs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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
Cc: Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/9/2024 6:30 PM, Le Ma wrote:
> Use debug_mask=0x8 param to help isolating data path issues
> on new systems in early phase.
> 
> v2: rename the flag for explicitness (lijo)
> 
> Signed-off-by: Le Ma <le.ma@amd.com>

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
>   4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..3d8a48f46b01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1144,6 +1144,7 @@ struct amdgpu_device {
>   	bool                            debug_vm;
>   	bool                            debug_largebar;
>   	bool                            debug_disable_soft_recovery;
> +	bool                            debug_use_vram_fw_buf;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 880137774b4e..0776b0c5e4e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -128,6 +128,7 @@ enum AMDGPU_DEBUG_MASK {
>   	AMDGPU_DEBUG_VM = BIT(0),
>   	AMDGPU_DEBUG_LARGEBAR = BIT(1),
>   	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
> +	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
>   };
>   
>   unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2117,6 +2118,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>   		pr_info("debug: soft reset for GPU recovery disabled\n");
>   		adev->debug_disable_soft_recovery = true;
>   	}
> +
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_USE_VRAM_FW_BUF) {
> +		pr_info("debug: place fw in vram for frontdoor loading\n");
> +		adev->debug_use_vram_fw_buf = true;
> +	}
>   }
>   
>   static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 51bfe3757c89..215994409ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -467,7 +467,7 @@ static int psp_sw_init(void *handle)
>   	}
>   
>   	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> -				      amdgpu_sriov_vf(adev) ?
> +				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
>   				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   				      &psp->fw_pri_bo,
>   				      &psp->fw_pri_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 0efb2568cb65..3e12763e477a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
>   {
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
>   		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
> -			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> +			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
> +			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>   			&adev->firmware.fw_buf,
>   			&adev->firmware.fw_buf_mc,
>   			&adev->firmware.fw_buf_ptr);

