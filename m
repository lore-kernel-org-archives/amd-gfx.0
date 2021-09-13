Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0BF60F25
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F0BF60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BAF89D40;
	Mon, 13 Sep 2021 06:31:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9256889D40
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4lc0cEIHivMo2zc7VTr3QALsJ4Xq5aF1dkr3+ODVTEZuzj7b0XtXqyeZmWF4w2NbYSLt5wC846mkhbD0WDadImju+B7mAaIlsaCRkZSP6AtUXBy1B/ycj6gZN4PooVDE6IoZe4Ii9ylLRPz0lCPJ1yo2AIYX/wec17lEepBDwuYHVvC/ChqHi0EzaxyT++TsOsnxyEQfVAx7/iBfjddPD0f0RAwtt+1ab3A4vl8AAwVqk6Hf5Z216j4swfl6xoBgHR6uQK2MAieSrh+j/c+wvVlOZYYFlyGAE6RRcOIraNuFQ3b8+vpFPADxDyuwllf73DFY0+6k9ISB87zp3UIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=W4sKonIAkdZIKg7LBzaxQJgKf/ovZwaSTVAO+vXqK50=;
 b=YIaLKsiIjjl5cjLexaoc3/yhKKMpfD9zpst2cEnBbvA7fTcPG2O82FqvI0bB1DcnGRtpdGWZ99C//jt4Zeq4iZYxlvrEGYzBhMHlec4jKN6OhRPwSUkTwc43YDtXYQfcADj7oth0OyQiZiEeuxS3+ZuIKk1NW2CJvXCTcHii/e4NoOS5pncBw6nlYhMRDV60pJ4rx+HwR8DUUtdG4VdVu6u8difkWrCO29A2cz25jCPrWjk4Oq3bAlI1NqQn2akO5FAYkqJugUet/jzYlUg3klmIiI52NLpBMqPxwUwLbiMauodN5SdMELHiZgENA3KwpU091EaZuzDsgM28+b2BVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4sKonIAkdZIKg7LBzaxQJgKf/ovZwaSTVAO+vXqK50=;
 b=iE2Je1uJ2rVpxbte0mLYdWO8sD9QNpSaey2XP83Hfk6FU1SK6XU7A7dpUOVWgXNOIxp1VypVMAznubIsINHKwuTWBaAovlQfBXx9i35I0dU/Klv+Rjh5C6lnCjHR1aBkdmQw7N9jKIRxfrqZqnyZqfZEbXtrHYO9onWdaW69E+Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 06:31:50 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:31:50 +0000
Subject: Re: [PATCH v3 1/3] drm/amdgpu: UVD avoid memory allocation during IB
 test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210911013421.5213-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <50096f9f-5113-8303-b1e8-32faa10a0ddd@amd.com>
Date: Mon, 13 Sep 2021 08:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210911013421.5213-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:205:1::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM4PR07CA0014.eurprd07.prod.outlook.com (2603:10a6:205:1::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.9 via Frontend Transport; Mon, 13 Sep 2021 06:31:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d2bae99-03c9-484f-fa32-08d976802b25
X-MS-TrafficTypeDiagnostic: BL0PR12MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB491617DD65B29A92F1D6376383D99@BL0PR12MB4916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SepNmEfhQJWbDvmA7TvIr7QXzfx8n5lvPnSd/aPUwkbcuTZxXDBdGVzpDaRdkGYZ6lMNW6zqvn5jyouzDwLUSOCQyqqlfhQVc+EUsqSNDYAHpwiEHkjn/O1Wu1K57mDiaCzNaq1AlBg5WpkyrEz4o8iuHC+giCZaOwaTmoINJZtXP6ONF6HA771D/Gt325Uzf6xhkNT8IU6HzUXzeTjQZxKsxYTE3iKpKhwHz3dQ3dmzJhXgnRMRt2iIFbyTADMZ5H6fwJKjeTqYDbauOVRMizBu47TeQn2j700NFDl2ZvfsNgadMs2/H9Tw8naNLmEft61CH9TXFEtdfHOJ54Vh2CSCJODskItFnKddcTRPQPq8ufomWBRjmWQz0UlNWrprVssdMysHspyYOPWalt0Nnm3ZuFuKgRoXY30pxP9V8kA+r34mGG88gsvKMy51jKBCJiROXDyJjFdfOWic6wNTTbM+HhZjKIjM44XCJr1pB4k4e9ZNryHzu5i3jzGtBWi2AjwZRqen5ZCIrK+otCKLyMNRlcmnHOlsNJrwGksPnxheDW2eK+Jj8ceH/F/6rrFfBC+6tfTl1RJ1x+/W2LgmYehD41XIcDfayfDbxhUMqPghOPikah+4xZTQ9pkwiGPeJjVlRomDF4NjjXFhzj/HbnD3NcNO3mkY5Ejt9flHqRafKr2P4g+klTF5flr3UTANi+0VB78oV4A4TGYtPgy9MTtz/JI4NNaPmGoYwDZ0dNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(6666004)(66946007)(66476007)(8936002)(956004)(66556008)(31686004)(2906002)(86362001)(38100700002)(186003)(316002)(6486002)(8676002)(2616005)(31696002)(478600001)(16576012)(26005)(4326008)(5660300002)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJqUVJXOGJoODg4M2J0Q3gwajBNYUl1V01ob0VnQmtaU0g2NXE4NmZsQU8v?=
 =?utf-8?B?TDJ0SnVWSEhyajJJcko0Y1BmaEtraWUvNEkyck0xaWJQalNKN2xrdjhIMmRx?=
 =?utf-8?B?V1V3ZE1IREU1di9LZEVWV2FNT2t6RFgvWGR5VUZGMWJkTGozZmphamxlL2U3?=
 =?utf-8?B?RnFhekE1T1FxZHB5MkxEREVIOXlZZldpTWN0KzlCc05zTjM0cUNVVTQ0K1RY?=
 =?utf-8?B?UUh6UGZNOHNCS0g1QzNaeWM1ZjljZUdESlpNY0hqdElkeDBYUUY4TzZPdG0r?=
 =?utf-8?B?a3ZoUW4vRTBIRG02VTF3cm5IRDE4alZKSm1IcDJmcDRlRHlLalFKckpRczUx?=
 =?utf-8?B?WWlZKytvRzBId2R4Y2JkZzZQODlVdW15eFl5LzlyZlA2QzhNL3R0Q1VhL2dF?=
 =?utf-8?B?VFJiMko1QlAvcEN6eUI0ZXh2S1drb1crVEhjMGZ2V1prTE9ZU3pUL3I3R0ll?=
 =?utf-8?B?WGFSS2NrUXo5K2huMzJjZWY3Uy9zS3loczZkbHRPN1plODVIVHk1WWh2b3B4?=
 =?utf-8?B?V3NoK0lUcWVneFU5SDNxcno5MVNqSzg3NncrOFV0V1pDR2NuWTlsS1dvU0w2?=
 =?utf-8?B?N05BMFhMQmRMbytybWpxU085Z0lreGk1S3JGYjdFbzlRNC80SGQ0WFBKaTQ3?=
 =?utf-8?B?WnZ3MGtzcjBVV1g2NlJRN1c1dnFsaWN3L0dkUngvK3p0Z3ZkUFA5NngzdG9m?=
 =?utf-8?B?QmtzVyszc0tYa29UWUxpelo0R1h6TVRUUi9CZGZJcGV6cU1aM3FJQllXOEZn?=
 =?utf-8?B?ejdNSkV2YlNkbE8yNkM3cHBZOWRkRVVoWnJndllyN3ZwTWJtSmRPYVQ3Y1Vo?=
 =?utf-8?B?S1BXMnJwVFRxV1c3dVcvQUllanYvcjdZeWM5RTFMVHB0TnNwb0cvb3ludjlQ?=
 =?utf-8?B?UWNGQ1dzREFna3YzTjhYNFBNTTkwK0ZDeDFuUGg5cmZyK2JUR2F6UUwxOU4x?=
 =?utf-8?B?NTNZbUZTMGc4T1BYbTJEVnlSSjdBL1kreGZWOUEzZmVYTk50MENndlQ5T2o2?=
 =?utf-8?B?ZWg1VlJjNGx5c1dMbkNZaUhSbVVsWjRTU2xOcWVOVFczMmhNaW14dGpweVJD?=
 =?utf-8?B?MTZaMWZjTENjRFlweWlNZjZXYzFlZGtzaUxsRVJOcVFBV2I0Qk43d011ZFhD?=
 =?utf-8?B?MU9wNjdrUHdvTzVYcEFsTmdLUy95cUZFd2ZRcmhhMzUxcXJYK1gvM0poMTBr?=
 =?utf-8?B?em8zVVdVQ0tMcHhzSG5JaXpDLys0cHNhQ2pBaWJYcFlEUElrTVpIZGJJMW5R?=
 =?utf-8?B?SkxTUVFyZm93VktJTkVkN2NoY29NWTE3dnljRGJMVU5TK0RXM0pkam5ERXpu?=
 =?utf-8?B?MWlTRXRFblVOUG80ejdPUEV2YnpvaExtU1FqeVVhcmtDRWh0SkkzMTZvdE90?=
 =?utf-8?B?NFRsZ2xQT0lBOFREQ1dNYWhUUDA4LzRIM1haN01teG5RVkhCRE11UVdYYUZF?=
 =?utf-8?B?ZCt3Qzh6QTR5OXY5czBUSjdHbnRwWUd4UmFKbEdEdU9udkFtMkhiRVh2VXJJ?=
 =?utf-8?B?RFF2WVVNQ3dnaXZIeENiRkhlbkxXMWR5b2oxdmVDbVRYOG5nYzJZZFA0UXBE?=
 =?utf-8?B?bmtReHVoZVFOdnRZZHI3NzhZYjRFVjY3T0NjQmRjSlRWUU41T1MrY1BRQnR2?=
 =?utf-8?B?SnpWUFhXNE1kMWR3RFVmTTU5MmtvQUFnTXVnV0lycmpuSUtRaFFUTkRVQ3Bp?=
 =?utf-8?B?dzE0bGRiVWtRY05KVVdQR1hhRTdmeTRnSG0zK1YvbHlFTUFtZ1BZOXZWN2NW?=
 =?utf-8?Q?x01bU6xTrEeurzJzgf6UbpnD75WN3GyrMhK4vEG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2bae99-03c9-484f-fa32-08d976802b25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 06:31:50.3935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpvFHPr0MZA3l6ndSUB+B/DiTapLwfsW+WQ84PxKIkx+yMmO4DDdbB1UoPqC0UwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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

Am 11.09.21 um 03:34 schrieb xinhui pan:
> move BO allocation in sw_init.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
> change from v2:
> use reservation trylock for direct IB test.
> change from v1:
> only use pre-allocated BO for direct IB submission.
> and take its reservation lock to avoid any potential race.
> better safe than sorry.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 104 +++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |   8 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |   8 +-
>   4 files changed, 79 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d451c359606a..a4b3dd6b38c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -134,6 +134,51 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
>   MODULE_FIRMWARE(FIRMWARE_VEGA20);
>   
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
> +static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
> +
> +static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
> +					   uint32_t size,
> +					   struct amdgpu_bo **bo_ptr)
> +{
> +	struct ttm_operation_ctx ctx = { true, false };
> +	struct amdgpu_bo *bo = NULL;
> +	void *addr;
> +	int r;
> +
> +	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> +				      AMDGPU_GEM_DOMAIN_GTT,
> +				      &bo, NULL, &addr);
> +	if (r)
> +		return r;
> +
> +	if (adev->uvd.address_64_bit) {
> +		*bo_ptr = bo;
> +		return 0;
> +	}
> +
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	amdgpu_uvd_force_into_uvd_segment(bo);
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (r)
> +		goto err;
> +	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (r)
> +		goto err_pin;
> +	r = amdgpu_bo_kmap(bo, &addr);
> +	if (r)
> +		goto err_kmap;
> +	*bo_ptr = bo;
> +	return 0;
> +err_kmap:
> +	amdgpu_bo_unpin(bo);
> +err_pin:
> +err:
> +	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_unref(&bo);
> +	return r;
> +}
>   
>   int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   {
> @@ -302,6 +347,11 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>   		adev->uvd.address_64_bit = true;
>   
> +	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
> +	if (r)
> +		return r;
> +	amdgpu_bo_unreserve(adev->uvd.ib_bo);
> +
>   	switch (adev->asic_type) {
>   	case CHIP_TONGA:
>   		adev->uvd.use_ctx_buf = adev->uvd.fw_version >= FW_1_65_10;
> @@ -324,6 +374,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   
>   int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   {
> +	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
>   	int i, j;
>   
>   	drm_sched_entity_destroy(&adev->uvd.entity);
> @@ -342,6 +393,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>   			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>   	}
> +	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, &addr);
>   	release_firmware(adev->uvd.fw);
>   
>   	return 0;
> @@ -1080,23 +1132,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	unsigned offset_idx = 0;
>   	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>   
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> -
> -	if (!ring->adev->uvd.address_64_bit) {
> -		struct ttm_operation_ctx ctx = { true, false };
> -
> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (r)
> -			goto err;
> -	}
> -
>   	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>   				     AMDGPU_IB_POOL_DELAYED, &job);
>   	if (r)
> -		goto err;
> +		return r;
>   
>   	if (adev->asic_type >= CHIP_VEGA10) {
>   		offset_idx = 1 + ring->me;
> @@ -1148,8 +1187,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	}
>   
>   	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -1159,10 +1196,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
> -err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> @@ -1173,16 +1206,16 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> +	/* Direct IB submission should be exclusive. */
> +	r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));

Please just completely drop taking the reservation for direct 
submission. I don't want lockdep to complain about that.

>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_bo_kptr(bo);
>   	/* stitch together an UVD create msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000000);
> @@ -1198,23 +1231,28 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 11; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, true, fence);
> +	r = amdgpu_uvd_send_msg(ring, bo, true, fence);
> +
> +	amdgpu_bo_unreserve(bo);
> +	return r;
>   }
>   
>   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;

That won't work. To make the allocation work bo must be NULL when 
amdgpu_uvd_create_msg_bo_helper() is called.

Probably best to add an "*bo = NULL" to amdgpu_uvd_create_msg_bo_helper().

Regards,
Christian.

>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> +	if (direct)
> +		r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
> +	else
> +		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_bo_kptr(bo);
>   	/* stitch together an UVD destroy msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000002);
> @@ -1223,7 +1261,13 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 4; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +
> +	amdgpu_bo_unreserve(bo);
> +	if (!direct)
> +		amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +
> +	return r;
>   }
>   
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> index edbb8194ee81..76ac9699885d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>   	/* store image width to adjust nb memory state */
>   	unsigned		decode_image_width;
>   	uint32_t                keyselect;
> +	struct amdgpu_bo	*ib_bo;
>   };
>   
>   int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index bc571833632e..dd92d96dd5a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>   static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>   	long r;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
>   	if (r)
>   		return r;
>   
> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unpin(bo);
>   	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index b6e82d75561f..271122cf2237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>   static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>   	long r;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
>   	if (r)
>   		return r;
>   
> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unpin(bo);
>   	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   

