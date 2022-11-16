Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDD6C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 21:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3745710E504;
	Wed, 16 Nov 2022 21:08:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D999B10E504
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 21:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdHUK2G15PEkrTMJd7w4RDcRMg1OuvtfnmNnQ8hJoC2Mzy7FNgsJF29l/iqTR72SqAcbhfVOOUDDUeCDpAC96nqXDWf1DyIwJ0O2842q/lR7NEwpu4H1TaGLxwQa6PlsFx4gJqHRU7oZe3affgh7LFu5OW+gKp+VEM1kuOMnA04qExPfAmkaGtgHLm2KBYasbpm+fWTfW12CG9LmOPFyi7Lovb+LsxSs7HA2OqrxMTEz9cS92jGRrEMB60F+3/RXN3stFTfRxgyKtVFtf1unvhV5az8c1xIrZgfZwKl5JCMA8T5efZarw6424NG+midiG56QE5OaX4W2qzD0J7McYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc0T61rXDkGkVgFJAZm0FQiuMAHNMgqLg4kE7Er+W9U=;
 b=DCxlfQX+OS+ex2PdWbtsTJ3Q4cmCk+xY4FxBATlv9vEYyryTbak6bl9T4B9cgIpwSE25JPaT3FIbbSEoUR86rsDc+Ex9SxSXZ9h9Co7eTjBFZLsX5CWeebs91ZDVlctLyL5DnguIwCCkDu+C3MbUmtDtGjPb9JtzQ4ykSoPT7T1RzVdPK009rBWX1xBNgRDvCSQioaLPFE8nURBDEwN+hBmYM1oYsogjuYniggNprUqn/GVTlagLWeVK67tLG0MaynBMPfGI0tjD9ZF3Hu4KMzHBH1uzx53yImhb/Pk33cL7FwDEmsECV/fQ66gjBN0SKopnCsdHOpXPzgqpZUYSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc0T61rXDkGkVgFJAZm0FQiuMAHNMgqLg4kE7Er+W9U=;
 b=GOdPWBeUNZefTzBBwxahHeEtP0+C/znMJvaKGYtqmBJZt3sGp7i3q8Iu6tvI4s7yz+qOnFSy5YuPxKMe875MeoyetGNcWeZTvF4VE1tRXqbTky5ybV0lPxSWhMB5MrmLyey1RO8bouqmZasz/ay/k/Iw5lKZo9Cht0Sym4ELOSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:08:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 21:08:24 +0000
Message-ID: <46caf0b7-cad6-1a5d-a83d-f0b8d3d6b424@amd.com>
Date: Wed, 16 Nov 2022 16:08:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdgpu: make psp_ring_init common
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221116164042.2830086-1-alexander.deucher@amd.com>
 <20221116164042.2830086-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221116164042.2830086-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a979434-40f3-4013-faed-08dac816b1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUN1FN5DbPl253NK5U7zWc4rwSG7wXb9GK5tzxix4FcQweHJWpRP4QT40rwBncIjpCTqPpszSNYtGLuR2YrBzb0KPLNq5LBM2QogDaWllKDXu120He0pZtjlUtdyFOV8XJYSgmdbrkZ7ZYsyxGySp7ZQmBGi5Crs1jmFDJfEUpNY4tGt4spPJ/ljKscc8fZ6LA95PP+5gWCY1898Bm8GtE1lh+h5J6eujQTq1UCGELMO17tvkWWB6wQFrFCECGh+U/o3u7E/+YYwWb3XcBB7xnhYRPCpWlG/anea/SUB7jn6CGLbF9gE0FIYtsrXxjCmswCo41vsV/VEi9rhWyHfcl1Wmrz9st4ISV5MOQRlVC2ZgY8wJPPDO2NHsj1z0c+zUdQcNIxpwyCBqtyueeVlapB8ROfcwv80mwKY/Cnvi0gxUSprs9UsdEgCpL5mFAu6OB/agKN1qVwPjAWZF3EkpJTdVxfr+2Df0A42qN5D/pYyPBeB0Ht9+McPRysW9boySR4FFxF1Wzw8Pf1aTQYJs9XGOM5Bn76SqlzyW8TamFzinakCVdxOrWwxeB8Zg0KYYUarYpKgcmm1c5lD+4xcAj7RfgYQPhBBd4yurjyq/4swhpwNccPiA7dKTXd67qq/RStng5PklsLSbMdSwyStsk4+DyqAMCj7QUe+mlo/l8qhEf35C7eb3ezHxhCVdab2IizmGiEiYwXFPJUc+UuLElRRV18oMUSmJaZs6ySmgJmUIzXxoq53sBI7IqzgSCY1SJOjRsTbLkIAerm6/hEAc0GkidxeC0bB2PkPlOZ+jMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(44832011)(2906002)(4001150100001)(316002)(66556008)(66476007)(66946007)(8676002)(6506007)(36756003)(26005)(6512007)(8936002)(5660300002)(186003)(30864003)(2616005)(41300700001)(6666004)(86362001)(31696002)(31686004)(478600001)(6486002)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L28wTVUxRFdVZ1REdHh2Zm5CejVSQ1RPZzlwRDIzakxkNlI2MWlQK3RHT09a?=
 =?utf-8?B?WTdlMnlxSnVwN1hCRTB3ZmZpYml5Unl5UFMwbkEybkxOblJZVGN1Vmxvd2Fn?=
 =?utf-8?B?TnFKZlNGeHd2N0ZZcjJiL3Q2N04yY3pzd2krd2llT1BGOGJqdGQyNnhkeTIy?=
 =?utf-8?B?TFVRYU5NeTFVbUhkckx5cGdqTEJ1VE1CQjZQRk9IOGI4bkhySkdESjdKM01m?=
 =?utf-8?B?b2pXNTB0Rll6MUNUM0hIZ0pObVRmN05UclN4ZkNXRFFHZ2ozSFQ5VzVoMWZw?=
 =?utf-8?B?aFpQSC9hcGtsdHRrSDd5R0dzVk9MQnUvWHRrQmhrOUQ0Y1pwZDFJNzIzSHNi?=
 =?utf-8?B?SkMxWldJdUZjSXFtWllQOFQwU3NhZFUvYTJJVjVsWUVFMW1OZXZ5N2MzL2hl?=
 =?utf-8?B?R2dIdVdGOVQ4R3VlZFJONk5MSU05dTJFKzBkV253Tk9qd0tidnE2akUxRCtM?=
 =?utf-8?B?dzBKR1VBWWRONG1ieGxib0gvL2N4clRFdkdRL0dGbWU2YjI2cS9RWHMweXF5?=
 =?utf-8?B?c1JQNi9PMkFaay9zMHdPSGl0NnJCMmtOdXRJeXd4QWpVTW14RU1ESUU0SFl0?=
 =?utf-8?B?VHdFT2N5bnYvMDhKZXV2WWx6WGdEWEVaN3pFQUhRTGJqbW9sRHRkU0txV3Bl?=
 =?utf-8?B?cFVSQjdMakNHTUZobVduSHRPZHBkTUZJcHVtT3VWUlZWdVlRVStELzU1NmJK?=
 =?utf-8?B?NHgxUlhGR2pSd3RIRXo5VkpFOFFvWmRSOGVEMWdTRWxpQ09sVzFlSFVQUWwx?=
 =?utf-8?B?dTZOVk1jN2VIWWltQ2ZTMXBMSkxKYnpTZjJsTm8rQUNYWEY1NXpYWVpmNmlw?=
 =?utf-8?B?Uy84ZG5qTXZMVTRQcU53aEkzRm1jek9haWRoc2puMkdtYW5TMnJ6NllVdjdo?=
 =?utf-8?B?YmcyR09RcDRUak9mSXFkVlNCenQwWHArS0VtUzVJUmVoS0Z4dXlHZk9zVTR2?=
 =?utf-8?B?MURWMXk4eWdyeDkwTkwvdEhJdjNEWnJUcjdIeTJzaGJTSGdBUEM2MjlvWVR4?=
 =?utf-8?B?amVweU5QSU5MNVFyZWdvaVJwZTZXM1ZmZGJzV2dtOG02elEvbEtGRUE0d2Nl?=
 =?utf-8?B?RzNNRWQ2OE1zbWZTalJ4NTZSUEJEL0lBLzhFYndiNUJiTEFEVlZoMFpxMHBH?=
 =?utf-8?B?YTFyaVBGcGRRbW1IRzR2NGg4K3RzNFlkd2Flb0dnTGV6NkR6azUwV01yVVE3?=
 =?utf-8?B?ZXNNZFFWWXhJLzZ2VEV0bjUrKzRXbVpRTjB4YThUSDRNeml6TmdwMHJyemRH?=
 =?utf-8?B?ZnA5SEx2VXNEbmxLU040VlRzMFdXTnFqYVltN09LZExXK0tpZTgxa3JhZGFX?=
 =?utf-8?B?cm1ZczJNL1dUZWtlRU9ZeWh2ZThmL2NUSTRrdGk1M0pxM1IyczM0RlBUTUk5?=
 =?utf-8?B?TnB1a3ZLYkJYang0M0tKNE5LblVrWXBscDgxdXpvNGtYRmNNZk9OZ3I2d0xq?=
 =?utf-8?B?b0g0V3oxSCtPKzRHVGpZVTJiRFh0RFVxK1p3SlhLZGt2R0R3WEN5ZXRlRGZX?=
 =?utf-8?B?ZHdlaHRVS0FkMXZSaVpVbzViakFFYXcySFMwaE1TN1hYZk5IMVR4aFhrbVBL?=
 =?utf-8?B?VmltUndqNHVtd21ua25GclVzR3BRdngyKy85ald5TWordmEvR3hwbXJZQy9T?=
 =?utf-8?B?UHJOaWZvdy90dTg4b0NvOGJteUhIMzdaS1RqNHNmN3FZZUpJTGVHZEZVOTNa?=
 =?utf-8?B?V0RYUyt0ZTFYOU5NSUhWK1dqWEpMWmVmTEhLT09haW5xbml3cW8wS2hkVHpS?=
 =?utf-8?B?U3JuMSs1MUxKUzlYV202WUxudUsvTzAzNm5paE1VTGJoM2toVXlrL0pnbFpu?=
 =?utf-8?B?dFo0Mm5BSEJZd29xaS93Wm42cGF1WWM5bEpKMjkyTVZUWXEyc0lIRkpQV2pD?=
 =?utf-8?B?S3hxRE9rZldKYUh5TDJ6eS9nVkdBVjM5STQ3R1JvcHRzL1l6OXJGTnllb2hN?=
 =?utf-8?B?bTVvZERGVkk4WGQvR1puLytyaXAvYlZRRTdLbGxrenhlaVcraVdjSGpBTmx1?=
 =?utf-8?B?U1daRnhaME5obUVtMTNya3pOOUhGSXhlWGJDQWZOUEZ3TGRjZ2JLVG1XMjhh?=
 =?utf-8?B?TzEwYThCeW1kaHBpS0I5aHdyeHFqSFZ5Uk1CTHlkUm1Zd0g0RUc4dFc1UW1X?=
 =?utf-8?Q?pfOS3v855fGS2hHNSl+mQDENX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a979434-40f3-4013-faed-08dac816b1bb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:08:23.9785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr+nLR2qhbDhncBlOxcTmwH+FsSrXAu+R6VTOAS8E5EeYYj5HNJfAzn3Mb9W8bd65oxKgLphmBQmSt9/fjKKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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

Am 2022-11-16 um 11:40 schrieb Alex Deucher:
> All of the IP specific versions are the same now, so
> we can just use a common function.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 26 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 --
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   | 27 ------------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 27 ------------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 27 ------------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 27 ------------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 27 ------------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 27 ------------------------
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c    | 27 ------------------------
>   9 files changed, 26 insertions(+), 191 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d9cb4c4b8289..7bb2de1d11ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -52,6 +52,32 @@ static int psp_load_smu_fw(struct psp_context *psp);
>   static int psp_rap_terminate(struct psp_context *psp);
>   static int psp_securedisplay_terminate(struct psp_context *psp);
>   
> +static int psp_ring_init(struct psp_context *psp,
> +			 enum psp_ring_type ring_type)
> +{
> +	int ret = 0;
> +	struct psp_ring *ring;
> +	struct amdgpu_device *adev = psp->adev;
> +
> +	ring = &psp->km_ring;
> +
> +	ring->ring_type = ring_type;
> +
> +	/* allocate 4k Page of Local Frame Buffer memory for ring */
> +	ring->ring_size = 0x1000;
> +	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> +				      AMDGPU_GEM_DOMAIN_VRAM,
> +				      &adev->firmware.rbuf,
> +				      &ring->ring_mem_mc_addr,
> +				      (void **)&ring->ring_mem);
> +	if (ret) {
> +		ring->ring_size = 0;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Due to DF Cstate management centralized to PMFW, the firmware
>    * loading sequence will be updated as below:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index cbd4194a2883..cf4f60c66122 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -118,7 +118,6 @@ struct psp_funcs
>   	int (*bootloader_load_dbg_drv)(struct psp_context *psp);
>   	int (*bootloader_load_ras_drv)(struct psp_context *psp);
>   	int (*bootloader_load_sos)(struct psp_context *psp);
> -	int (*ring_init)(struct psp_context *psp, enum psp_ring_type ring_type);
>   	int (*ring_create)(struct psp_context *psp,
>   			   enum psp_ring_type ring_type);
>   	int (*ring_stop)(struct psp_context *psp,
> @@ -396,7 +395,6 @@ struct amdgpu_psp_funcs {
>   };
>   
>   
> -#define psp_ring_init(psp, type) (psp)->funcs->ring_init((psp), (type))
>   #define psp_ring_create(psp, type) (psp)->funcs->ring_create((psp), (type))
>   #define psp_ring_stop(psp, type) (psp)->funcs->ring_stop((psp), (type))
>   #define psp_ring_destroy(psp, type) ((psp)->funcs->ring_destroy((psp), (type)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> index ed2293686f0d..9de46fa8f46c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -126,32 +126,6 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
>   	return err;
>   }
>   
> -static int psp_v10_0_ring_init(struct psp_context *psp,
> -			       enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int psp_v10_0_ring_create(struct psp_context *psp,
>   				 enum psp_ring_type ring_type)
>   {
> @@ -245,7 +219,6 @@ static void psp_v10_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>   
>   static const struct psp_funcs psp_v10_0_funcs = {
>   	.init_microcode = psp_v10_0_init_microcode,
> -	.ring_init = psp_v10_0_ring_init,
>   	.ring_create = psp_v10_0_ring_create,
>   	.ring_stop = psp_v10_0_ring_stop,
>   	.ring_destroy = psp_v10_0_ring_destroy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 9518b4394a6e..bd3e3e23a939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -360,32 +360,6 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
>   	return ret;
>   }
>   
> -static int psp_v11_0_ring_init(struct psp_context *psp,
> -			      enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int psp_v11_0_ring_stop(struct psp_context *psp,
>   			      enum psp_ring_type ring_type)
>   {
> @@ -779,7 +753,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
>   	.bootloader_load_spl = psp_v11_0_bootloader_load_spl,
>   	.bootloader_load_sysdrv = psp_v11_0_bootloader_load_sysdrv,
>   	.bootloader_load_sos = psp_v11_0_bootloader_load_sos,
> -	.ring_init = psp_v11_0_ring_init,
>   	.ring_create = psp_v11_0_ring_create,
>   	.ring_stop = psp_v11_0_ring_stop,
>   	.ring_destroy = psp_v11_0_ring_destroy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> index ff13e1beb49b..5697760a819b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> @@ -28,32 +28,6 @@
>   
>   #include "mp/mp_11_0_8_offset.h"
>   
> -static int psp_v11_0_8_ring_init(struct psp_context *psp,
> -			      enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int psp_v11_0_8_ring_stop(struct psp_context *psp,
>   			       enum psp_ring_type ring_type)
>   {
> @@ -194,7 +168,6 @@ static void psp_v11_0_8_ring_set_wptr(struct psp_context *psp, uint32_t value)
>   }
>   
>   static const struct psp_funcs psp_v11_0_8_funcs = {
> -	.ring_init = psp_v11_0_8_ring_init,
>   	.ring_create = psp_v11_0_8_ring_create,
>   	.ring_stop = psp_v11_0_8_ring_stop,
>   	.ring_destroy = psp_v11_0_8_ring_destroy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index d7dd84090c09..8ed2281b6557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -236,32 +236,6 @@ static void psp_v12_0_reroute_ih(struct psp_context *psp)
>   		     0x80000000, 0x8000FFFF, false);
>   }
>   
> -static int psp_v12_0_ring_init(struct psp_context *psp,
> -			      enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int psp_v12_0_ring_create(struct psp_context *psp,
>   				enum psp_ring_type ring_type)
>   {
> @@ -425,7 +399,6 @@ static const struct psp_funcs psp_v12_0_funcs = {
>   	.init_microcode = psp_v12_0_init_microcode,
>   	.bootloader_load_sysdrv = psp_v12_0_bootloader_load_sysdrv,
>   	.bootloader_load_sos = psp_v12_0_bootloader_load_sos,
> -	.ring_init = psp_v12_0_ring_init,
>   	.ring_create = psp_v12_0_ring_create,
>   	.ring_stop = psp_v12_0_ring_stop,
>   	.ring_destroy = psp_v12_0_ring_destroy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 88f9b327183a..ee27bfaba6fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -268,32 +268,6 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
>   	return ret;
>   }
>   
> -static int psp_v13_0_ring_init(struct psp_context *psp,
> -			      enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int psp_v13_0_ring_stop(struct psp_context *psp,
>   			       enum psp_ring_type ring_type)
>   {
> @@ -729,7 +703,6 @@ static const struct psp_funcs psp_v13_0_funcs = {
>   	.bootloader_load_dbg_drv = psp_v13_0_bootloader_load_dbg_drv,
>   	.bootloader_load_ras_drv = psp_v13_0_bootloader_load_ras_drv,
>   	.bootloader_load_sos = psp_v13_0_bootloader_load_sos,
> -	.ring_init = psp_v13_0_ring_init,
>   	.ring_create = psp_v13_0_ring_create,
>   	.ring_stop = psp_v13_0_ring_stop,
>   	.ring_destroy = psp_v13_0_ring_destroy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> index 321089dfa7db..9d4e24e518e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> @@ -199,32 +199,6 @@ static int psp_v13_0_4_bootloader_load_sos(struct psp_context *psp)
>   	return ret;
>   }
>   
> -static int psp_v13_0_4_ring_init(struct psp_context *psp,
> -			      enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int psp_v13_0_4_ring_stop(struct psp_context *psp,
>   			       enum psp_ring_type ring_type)
>   {
> @@ -373,7 +347,6 @@ static const struct psp_funcs psp_v13_0_4_funcs = {
>   	.bootloader_load_intf_drv = psp_v13_0_4_bootloader_load_intf_drv,
>   	.bootloader_load_dbg_drv = psp_v13_0_4_bootloader_load_dbg_drv,
>   	.bootloader_load_sos = psp_v13_0_4_bootloader_load_sos,
> -	.ring_init = psp_v13_0_4_ring_init,
>   	.ring_create = psp_v13_0_4_ring_create,
>   	.ring_stop = psp_v13_0_4_ring_stop,
>   	.ring_destroy = psp_v13_0_4_ring_destroy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> index 01f3bcc62a6c..157147c6c94e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -160,32 +160,6 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
>   	return ret;
>   }
>   
> -static int psp_v3_1_ring_init(struct psp_context *psp,
> -			      enum psp_ring_type ring_type)
> -{
> -	int ret = 0;
> -	struct psp_ring *ring;
> -	struct amdgpu_device *adev = psp->adev;
> -
> -	ring = &psp->km_ring;
> -
> -	ring->ring_type = ring_type;
> -
> -	/* allocate 4k Page of Local Frame Buffer memory for ring */
> -	ring->ring_size = 0x1000;
> -	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->firmware.rbuf,
> -				      &ring->ring_mem_mc_addr,
> -				      (void **)&ring->ring_mem);
> -	if (ret) {
> -		ring->ring_size = 0;
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static void psp_v3_1_reroute_ih(struct psp_context *psp)
>   {
>   	struct amdgpu_device *adev = psp->adev;
> @@ -401,7 +375,6 @@ static const struct psp_funcs psp_v3_1_funcs = {
>   	.init_microcode = psp_v3_1_init_microcode,
>   	.bootloader_load_sysdrv = psp_v3_1_bootloader_load_sysdrv,
>   	.bootloader_load_sos = psp_v3_1_bootloader_load_sos,
> -	.ring_init = psp_v3_1_ring_init,
>   	.ring_create = psp_v3_1_ring_create,
>   	.ring_stop = psp_v3_1_ring_stop,
>   	.ring_destroy = psp_v3_1_ring_destroy,
