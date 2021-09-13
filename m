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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE74C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA9360FA0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EA9360FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543086E176;
	Mon, 13 Sep 2021 08:48:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5876EC99
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 08:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1R/JA8nLCNk9WCj37VJcrc03ZO3xiKDj1ppY2uIcaCBjvJ3CUnPfRbd+4+0Za6BjFvmoakPzVToJalcgUJSYujymfzB63QCXm8zBPBwFCzdPY1kKE4Ug8umLDGPgillKJ4fDKamqcFDBDO7Qbww9qjEBqlf8C2mRgePDe9rmD/I/xFcCses5uxTcrmoCoRuJ3EshX+WjkrNvSIh4s9i0XHmncexHMxIb+TZKO8tRAlJV6Cvur1AtDije/HXTTlteNqVR22+EEuBdzQA9x4+C9ElviVm0QfvxJ2vl4CP+N4UG2Zju9EP77fKBkh3fc0FQoxMIjsAaxu9p7BV8ZHrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jOkdgb7gMw2y8m8eQ5vym+J39ARobjszh5DXLHZNY7w=;
 b=PpePrifligueZWOG6LPwCQUviJSItsMxittf9k4okWsf0oErzVKrmICY4odc8Kr2dqWpGMXoSkjHR6ims7DzuOPZDX4czBtc45awtL+vv/IFKbo4VeVQA0jtZoJ9AkFVEiYY2iKsMjA89O/OkFF6ZbVEuJP2bOKI632NCoAelfnKYt817EyytN14oRlATw+GV7Wy1C7Kd7aBkUIL76Y7P5ijfH1qcHTKu2sYO1UNhU1H0l5XyQLtjYfReuo4FvWUSpzsbcIIxC0AlZfrRx64XRs0NBNlrjhNMyS3RCxufphY7/hZinPbLtY6Udie0ZXWdR3mtMAUuG3NJ4gjafz86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOkdgb7gMw2y8m8eQ5vym+J39ARobjszh5DXLHZNY7w=;
 b=HvQ1UmgGY6chy7mSpoF5dr5sM0jOwMGPKmpC48UKXJ/JyEOzJ45AHI8I3RN1Zf5+MqNWQCph9BLmPFt1jsCuc8GMcxmKYt7aUkJhgljht4vYNIcjrNWtbrJ4v3ud06051F0V2NwuAIExxUgmW+BXRljtAWA7FnhCOnPDIhMBKFc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 08:48:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 08:48:28 +0000
Subject: Re: [PATCH v4 1/3] drm/amdgpu: UVD avoid memory allocation during IB
 test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, James.Zhu@amd.com
References: <20210913084253.241955-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b080e258-9e2e-d3ba-9676-7f2ac69265a7@amd.com>
Date: Mon, 13 Sep 2021 10:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913084253.241955-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:205:1::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM4PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:205:1::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.9 via Frontend Transport; Mon, 13 Sep 2021 08:48:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2188ca-f55d-45fe-86ce-08d97693412b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966284A3954B6D39840E68C83D99@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftCCXQKSA++RilGWWeSAQuRFbDHEpwQea9bsFP1WE1Pf/7I1jbwUzrXvq5LxNVs3t2FdMQgUlfIBiW5jeKl3j7PoqUDyaMzisj1cacf2SIqSwg26UKG4/UmO0zaY9drmWAeA4MN5Mn2U/EC93Ht4au0vzkQxKqPOZodQ6qdHKMvjit5TYEbxmhZgjMjZevp4yTOBaum2H3T018b/duCtp8HXEA7p/xP68jsbyZk41GFbxIHSkXI2/bdl9nbPayLMggWZTR2ZZKJGE3m+fKxhb7QdTUAGL5R1DQaMZXCQ4hZ7sDFJ/PuTWv52sm6XhfwQrGQGVlaidrVJwqYVeSxeg9RNcln7O1GrG8TFqYLSj/gqnvW8NeTZn0gKUOLm/zKTuMJk+6W6BPe38swFH8ZQ5xM2fhhawnwIb89VpdQvHM9zLahW94l6uMWfd3erSIB8zLlPUh29+q6UVDVO+3MI5GxCrg5r1C7CKSCJl9T55GcU70gs85I+OoxxvV+e8V104kGL+SbDWdYEhkxcmSMyyfj/XO6gAfofvn3inB1E6ewlpLTpJ+ZtE1Azl9pt+OwjWPcwbHwJdZes3E0OgvmIbu+inKVP7a6iTx219HDqVU21YpnmiOJ5JPFH877GdyPoDrEoWRzw0WR4DqGCZbUj2AsQQ6mfUXyVbMBhe9dOKCm41j2WNxJm1UbXagOBpp84DZ1eUrvwPxGlgywUJsT2E9YCxy1afEA7deotFr3Q25s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(31686004)(956004)(2616005)(38100700002)(186003)(2906002)(5660300002)(83380400001)(31696002)(4326008)(66476007)(66556008)(316002)(36756003)(66946007)(66574015)(16576012)(6486002)(6666004)(8676002)(8936002)(478600001)(86362001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjB0cW9mUFk3bVF2WGlrSElpbFhEdWV0OEd6RjdIS2RDUlV5MnNabFl2cUkr?=
 =?utf-8?B?bndGOHdjaENYZElZS1ZEQlF0bzdvK3lkRHNVZjRJbHZ6dHRHR3MvaWd2dVpt?=
 =?utf-8?B?amFIT2FuV1NQWmRIRGZDdk9tc2xsZXoxU1NIc0l2bEZoWkdydUhseGJwekFj?=
 =?utf-8?B?ZlA5WXlTeGJDK1E2VXNoaHhPSUxKanB4bVJSVzlUaC9GV0ZscmF3dmF2TWNQ?=
 =?utf-8?B?b2xncm10d2p0ZWJ0Y3VLaW4xVitoUkRzYWFKMmcyRFA3QzgwelZnOUdnNWNv?=
 =?utf-8?B?UEsvclh0WmlOTkhoVkloK0RQaG01dnB4TUliUlo5d3NLc1Z4czNmQ05QaFdF?=
 =?utf-8?B?NFJZWHBSY2lJWHZkSjJIZEsvMUpMY0Y4K1VYU1N5aUQ2blQyYkFFYkhIZjNG?=
 =?utf-8?B?Y3JSaUZOVEFja3pwOWx1eElmeEE1d3JvMjBCY3V1ZzJWN1NhN01VQ2ZPVktR?=
 =?utf-8?B?VU1pZUVkNHM1Y2l6ZWEvMUxiOWNOVWcwZmpMcTB3UW0ybHhLRTQ4eFhMc0hC?=
 =?utf-8?B?a2J6NVJNQnFJMGxDTjhWTGVEUnFoUEZMTVFUdHpERlBaek1VWVRXU0cxMUpI?=
 =?utf-8?B?T0FVNS9yZTJtOUZCb2lqTEVSMkVUSC8rZjF5cGRsNWw3ZzlhUlhqdjNhNmNy?=
 =?utf-8?B?TkxmWG05ZjNXYk5LMnhOczdoMlRHSm0rRHhsc2NjM3dtMm45bnl1Ym9INTZ0?=
 =?utf-8?B?ajJLUkVJRmpBeVp4WktqZGg0aXJhUmZ4dm0rMENwK3JZWlM2ZDhUcElMblNR?=
 =?utf-8?B?TzNRNVlUS0N6Vi90YmU5dUJZSWhac0VOMmg4aDFGbXU5SWhDQ2FRb2k5QTdG?=
 =?utf-8?B?YjhQd2dYSjFpdzJ4cW9LbnMveHgvZkZsMWdQZGMrcjNFZzhiQTZqdW85bm5y?=
 =?utf-8?B?YlliK0EvUmwwU1VCL0oxdjUxS0ZuT3V0QlplemtIN3pud1M1akRoTXNSQ3l3?=
 =?utf-8?B?bTBuYVRqWW9sK1dERURGTEdpUzhpdlhKbG1naUNLVEdqYnJWaUpkUTFDakU0?=
 =?utf-8?B?NkVZVTVtSjRHZnkxNXpIVjRMS3NGMlErRU1wK2paWDdZbnoyckZYbFRJWURB?=
 =?utf-8?B?bCtmWWM0NnZKQ1IzRUNZTnJ4K0dMZ2Q0Z0QwYVF1MjFUWWpkZ1NwY1JUVW9E?=
 =?utf-8?B?Y3phNXdybkRhNE5MckNZSzRKQlFXaU1ZVjV4UUtjQ2wreWIzOFNmaXRBdEFC?=
 =?utf-8?B?VW1KK1FvdytmYUJSblEyYUtBU3dFcmppOXNqNk5wMXluR3RkcThsSWc1bG1j?=
 =?utf-8?B?bE5uQ29DMnhzU0lFa09BNmF4dFV0alZJOXR2bVQvMUFhQkltS3djL3hFaksy?=
 =?utf-8?B?VW5rcHRrSlJpeWF1dUJJSjIzZ2JtSWhzSEwxZFo2My8yN2NCcHZDbFBHYngw?=
 =?utf-8?B?d2RKRDhTd1p5cStZL0hnN3BGMTZWNDdUdFkydzZXMnhramE4VUozMFBIYjlM?=
 =?utf-8?B?NVRPeituTEpZcTdxb0ZBL3ZhQzllTjUyVmVDTVZhVS9ldytHamxleTMxWXUy?=
 =?utf-8?B?UDRmenlodXRlSmtuNVhQd2VhMXRkYlFoNnJPRzQ1NUc1SDRvZHZwL0IzZ3dX?=
 =?utf-8?B?WS9KSzdWREZ3Qm5YTmJIQWp3RHBiMWZRUGZ4dFQ4VVd1NVZxeTArTDFzZVFo?=
 =?utf-8?B?ZXExdGN4Ryt2dzBHczg4d3pLMnZnclJoTmp4b2hLOUVYMkl1RjBNZ2JCUENs?=
 =?utf-8?B?ZnpGL0xWczJiNzhVUDE0NmhvS00yMUlpVUtWV1lDdHVFRklCN202S09Bd25o?=
 =?utf-8?Q?bxQaKVksme/YSpK1jQkQx6w2Yj6614Ibyx5W0kF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2188ca-f55d-45fe-86ce-08d97693412b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:48:27.7256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRjxV+BithMXAKvIIgRqY9nlqE6gfmRvyxUAyMgi+WiiVz0kMRVYTJBNptwlLM3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
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

Am 13.09.21 um 10:42 schrieb xinhui pan:
> move BO allocation in sw_init.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
> change from v3:
> drop the bo resv lock in ib test.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 102 ++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  11 +--
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  11 +--
>   4 files changed, 72 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d451c359606a..b0fbd5a1d5af 100644
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
> +	if (adev->uvd.address_64_bit)
> +		goto succ;
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
> +succ:
> +	amdgpu_bo_unreserve(bo);
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
> @@ -302,6 +347,10 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>   		adev->uvd.address_64_bit = true;
>   
> +	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
> +	if (r)
> +		return r;
> +
>   	switch (adev->asic_type) {
>   	case CHIP_TONGA:
>   		adev->uvd.use_ctx_buf = adev->uvd.fw_version >= FW_1_65_10;
> @@ -324,6 +373,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   
>   int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   {
> +	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
>   	int i, j;
>   
>   	drm_sched_entity_destroy(&adev->uvd.entity);
> @@ -342,6 +392,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>   			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>   	}
> +	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, &addr);
>   	release_firmware(adev->uvd.fw);
>   
>   	return 0;
> @@ -1080,23 +1131,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
> @@ -1148,8 +1186,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	}
>   
>   	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -1159,10 +1195,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
> @@ -1173,16 +1205,11 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
> -	if (r)
> -		return r;
> -
> +	msg = amdgpu_bo_kptr(bo);
>   	/* stitch together an UVD create msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000000);
> @@ -1198,7 +1225,9 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 11; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, true, fence);
> +	r = amdgpu_uvd_send_msg(ring, bo, true, fence);
> +
> +	return r;

Drop that change, the code can now keep as it is.

>   }
>   
>   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> @@ -1207,14 +1236,16 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_bo *bo = NULL;
>   	uint32_t *msg;
> -	int r, i;
> +	int r = 0, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> +	if (direct)
> +		bo = adev->uvd.ib_bo;
> +	else
> +		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
>   	if (r)
>   		return r;

Better use { r= ..; if(r) return r; } instead of initializing r to zero 
above. Initializing r like that is often seen as bad style.

Apart from those two nit picks the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

>   
> +	msg = amdgpu_bo_kptr(bo);
>   	/* stitch together an UVD destroy msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000002);
> @@ -1223,7 +1254,12 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 4; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +
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
> index bc571833632e..d5d023a24269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -332,15 +332,9 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
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
> -	if (r)
> -		return r;
> -
>   	r = uvd_v6_0_enc_get_create_msg(ring, 1, bo, NULL);
>   	if (r)
>   		goto error;
> @@ -357,9 +351,6 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unpin(bo);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index b6e82d75561f..c115b2da22ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -338,15 +338,9 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
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
> -	if (r)
> -		return r;
> -
>   	r = uvd_v7_0_enc_get_create_msg(ring, 1, bo, NULL);
>   	if (r)
>   		goto error;
> @@ -363,9 +357,6 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unpin(bo);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   

