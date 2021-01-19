Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EFAC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 22:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C14E22E01
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 22:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C14E22E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEC86E10F;
	Tue, 19 Jan 2021 22:10:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70956E111
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 22:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrrwgP41HKozsb9K1aKErsotZZU/KxbhrXjOLYpi3vX2fbbuJKdixSVKO8gEzgbXMGfFH3S6OWW1SR2G/dDni3NqSMAsmptosf0Glx6zSOIXtGjHxyYH8ix1IJeEUYT3PfTHRNaFMxeMb95sATy1Ul/YV9ZvJUkmj0UIKFtK2iFoHOAQmdvgZGzE8sHvMyZKNbjUCqNT1S4fi5HeYgNuMX1RUi0pY4BrsxyeAsVYxpfJQkUsMGW1CWRe0IkcUKXT+9c08+CNGS6WU8/IgkBI4CRuUUGiSlVns+/mLWhWkzbfFqjvu+CExMqBo5rPjwnbOWuUaFYPhB/qr1tNn5w2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FijHCsT+IpsiK7vwIlKV7PX+p01VYt837XET4+FTxmQ=;
 b=NH9L419uVr8IrELZ+BNGvP7Etcun0JrvHGTb4QINJIo+GnzLoiBO0L5T2nSzWgItBaTjt8oXRV6MoyrvpIMxUbwfCTJcAP4mrlwvmOBk/HC898MJV8rbdFAPMRry5L+cvo4ZU/TSDTfpBUZW02706KDMcHieqo12cbcK9YBZpkvC2m1bgn+UVErRTN7y3NcQ+XjEid37g9zo/WiF/SCr3bp4IikyhHZ1JOCvtcuteYtOho+DwZmWOxfndrxLeO2aY+QCuFXTYwEiDsYwBkj0d4RTqQKNWwei0hzZgnEc0KOIpUU9Pd/kciqeeFPvZ/PTMp7DIGitBN0wPOTrj74eMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FijHCsT+IpsiK7vwIlKV7PX+p01VYt837XET4+FTxmQ=;
 b=QI27ykTid5ZDXtAL+rByOq18KBIW6TzhdjlwIueVs4+1o1ANkBD0Fl32iRm2MNrY/SYr/IR/206+T6RrQzzQONUOHV9KG11/c7l9HVNch7I35m2nB8PgRLXgqvX3vRwmuL9PEN1n+rbotNv2xlNH5i8JJwe6XZRSd3d2QRe0Dp4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 22:10:52 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471%3]) with mapi id 15.20.3742.014; Tue, 19 Jan 2021
 22:10:52 +0000
Subject: Re: [PATCH] drm/amd/display: Implement functions to let DC allocate
 GPU memory
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <03d53a31-18f7-3581-ba2b-99c10f0eb303@amd.com>
Date: Tue, 19 Jan 2021 17:10:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 19 Jan 2021 22:10:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5faf019-435c-4f0f-6d69-08d8bcc715bd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4997013A286EC05CB00A8E3CECA30@BY5PR12MB4997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5pZKRGyoo3nELXoCfeJHep9WrZHZIQO7JP+AtQ+gAw8utSDuYfLH4aiPDNJbWc3OiQrG9LSXblXTUfuGHEWD+6rD4OGKvm9jnTKnmVi3qn2UohaGj+YnT/Sz3BloR3iXBag/60yp387qPDvWO8zdchtCDKih61tbUY1uz+O94AhOZRSKWBDi8Hu0YHbI4nYWRF7/zauSIc50BvwFMniFx2NRo2vEmAOR9m4y31t+MpG5emKLWRxV+1C47Cft+4Ht0xXMQ5d0cGZk7/Z4VbOWOEi1tUC11mPVH2EaB01wQ91Slzq159slONPfXwtxnMHyPSRyd7L8Ih1wS02dyDx7M+NvEPvXcpAkWt9AEZP1oSNVGXJGeYuihfNxFKVifGTXf+qO7VA6531LM1MoRQ3hU9EpS0Cb6bGdN1giVv7JIoaHJPL6GeDHdSdh/GK6UiAMQiPBFmVgG2ZzSxJ1N3FEvsJLUQZf6wmBFmZibaDzS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39850400004)(396003)(136003)(346002)(16576012)(316002)(2616005)(6636002)(6486002)(8676002)(478600001)(53546011)(956004)(4326008)(66476007)(52116002)(83380400001)(2906002)(66946007)(86362001)(26005)(8936002)(5660300002)(31686004)(66556008)(16526019)(186003)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QlhseWxPNHdxWm9INWlvUU5OaStaN3hYL2wySms3K3RoOHBzeFdqWWZmaHBG?=
 =?utf-8?B?Zk9SMDVTMm85N2RWWENaWTVMSDI0WU5oRTJsU2JkNkN4bERjM0hhMDRRVlVL?=
 =?utf-8?B?ZVE4ZnN1YzBUbjdaSy8xWVpmTjFvaXJSTGhxd2NKMTJSeVJ4bEJBSzRPZTBJ?=
 =?utf-8?B?bDRtSXBaQjNKZ0l3VExESXp0YjVrMGJJZStqdi9YUzRJWlZLTm9jZ0syWERR?=
 =?utf-8?B?MjF0N1RzZlU2alNUUEYvOXF4a0hoZXJ3d3B2SnJEU1NUcjJJbnlyVEJqUEdu?=
 =?utf-8?B?SkorV28wZEoveGkyS0d2YU16UDQ0em43VnpMS1UrY0pZLzhMcFdHa1ZiYllR?=
 =?utf-8?B?QkxJQ1E5WFVGVjJ5MXFWenh0ZzVCY0h3TS9TK3lnTHpjV3lqR1QxWmZRRXhE?=
 =?utf-8?B?bGVsM29uRU0wa0V1ZlQ5eGtYR25ZT1Fxc25nR0VteW9Yd00zM1pHZ0N5MFNW?=
 =?utf-8?B?eGRaQXJZS1VWNWIrTjVCZUxlWkFhWDdTUTVad0dDL0FkaG1pYldXci9NOHhu?=
 =?utf-8?B?SVRpK1B5T000bHFFbXoxR3F1SjZLQTJyMDVNUzY0d09XcG1aK3hyYzZxSHdU?=
 =?utf-8?B?OWcvYmRsY25NbWNOL2REUHkrcWJYOFRHbzQwUWZxcG12a09XVmVFTjJZSUMz?=
 =?utf-8?B?VDlQSk5FSE5DSFoydFhweDRETXlJUmp3bVo4ekxGSDltd0dSWmo4VDZJeFQ1?=
 =?utf-8?B?dklSTEVoZ3dJbUp5K3ZBNGxtNlNxSUhSN243N0pwQlF4YjlndXB1OUk4cXoy?=
 =?utf-8?B?SlVKVXM2ZzhleFo0OUxDdm5SdWR2M0RzSVJOTzk0bVppcjJsaGJISzVublpz?=
 =?utf-8?B?RnN1MnY1TFVtRTg3OUJWRWNIWThzNFRUR0k2dkxXUVF3aFZ1WHkySUY1V3RJ?=
 =?utf-8?B?dkQ5OEkza0FsVWtlYzlFT0lja3JpRmZxNS9BcXBiZlJnandRMlgzeEc3ZDlL?=
 =?utf-8?B?a2dhT3E3MFRnSmxzL0IrVGFOYlprdVhvcGh4Sm9VS2JvNXZZZGJQdHRDZlJP?=
 =?utf-8?B?ZHVYb3Z5K1krdFlMdk0vcUtQSUk4bVhEWjd1d1BIYjd4dUxVM2RseHh4bzRF?=
 =?utf-8?B?RkhaWE9RNHJqWFRDRnltajgrSjJpT2QvV0VPWm1RcGU3bERMTFh4aTFDTFVp?=
 =?utf-8?B?OGdZZWhIQVJQWjQxY3pIYWw2RXhtL01ZVVV3MkFLeWRDS1dKVW4xblczV0J6?=
 =?utf-8?B?eG5DU0RkRjMvYjdvei9LclIvN0xkZkxvUmZodm5ZcGcvN1JCRW5XT1FjZFYw?=
 =?utf-8?B?ZEthNEVOK01wYjE2aFlUN2dXaElHYXZkRVgxMGhkV0tsUThtb1RWUVRybU1s?=
 =?utf-8?Q?A9RAqGIJMkoMWx9VbsmjzJJhY8YpyJBoN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5faf019-435c-4f0f-6d69-08d8bcc715bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 22:10:52.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNKI9/D811FqWEG1a4fEZVpEx8kWrC10OJcxDXBr5lYuoV3iLRLCpn69fk3fd6JwHFPAXV3C0HlPUFVmzrB/KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-01-19 3:40 p.m., Bhawanpreet Lakha wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [Why]
> DC needs to communicate with PM FW through GPU memory. In order
> to do so we need to be able to allocate memory from within DC.
> 
> [How]
> Call amdgpu_bo_create_kernel to allocate GPU memory and use a
> list in amdgpu_display_manager to track our allocations so we
> can clean them up later.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 +++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 +++++++++++++++++--
>   3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e490fc2486f7..83ec92a69cba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1017,6 +1017,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	init_data.soc_bounding_box = adev->dm.soc_bounding_box;
>   
> +	INIT_LIST_HEAD(&adev->dm.da_list);
> +
>   	/* Display Core create. */
>   	adev->dm.dc = dc_create(&init_data);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 38bc0f88b29c..49137924a855 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -130,6 +130,13 @@ struct amdgpu_dm_backlight_caps {
>   	bool aux_support;
>   };
>   
> +struct dal_allocation {
> +	struct list_head list;
> +	struct amdgpu_bo *bo;
> +	void *cpu_ptr;
> +	u64 gpu_addr;
> +};
> +
>   /**
>    * struct amdgpu_display_manager - Central amdgpu display manager device
>    *
> @@ -350,6 +357,8 @@ struct amdgpu_display_manager {
>   	 */
>   	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
>   	bool force_timing_sync;
> +
> +	struct list_head da_list;
>   };
>   
>   enum dsc_clock_force_state {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3244a6ea7a65..5dc426e6e785 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -652,8 +652,31 @@ void *dm_helpers_allocate_gpu_mem(
>   		size_t size,
>   		long long *addr)
>   {
> -	// TODO
> -	return NULL;
> +	struct amdgpu_device *adev = ctx->driver_context;
> +	struct dal_allocation *da;
> +	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
> +		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
> +	int ret;
> +
> +	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
> +	if (!da)
> +		return NULL;
> +
> +	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				      domain, &da->bo,
> +				      &da->gpu_addr, &da->cpu_ptr);
> +
> +	*addr = da->gpu_addr;
> +
> +	if (ret) {
> +		kfree(da);
> +		return NULL;
> +	}
> +
> +	/* add da to list in dm */
> +	list_add(&da->list, &adev->dm.da_list);
> +
> +	return da->cpu_ptr;
>   }
>   
>   void dm_helpers_free_gpu_mem(
> @@ -661,5 +684,16 @@ void dm_helpers_free_gpu_mem(
>   		enum dc_gpu_mem_alloc_type type,
>   		void *pvMem)
>   {
> -	// TODO
> +	struct amdgpu_device *adev = ctx->driver_context;
> +	struct dal_allocation *da;
> +
> +	/* walk the da list in DM */
> +	list_for_each_entry(da, &adev->dm.da_list, list) {
> +		if (pvMem == da->cpu_ptr) {
> +			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
> +			list_del(&da->list);
> +			kfree(da);
> +			break;
> +		}
> +	}
>   }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
