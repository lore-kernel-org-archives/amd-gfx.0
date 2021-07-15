Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AEDC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A817760041
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A817760041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9766E446;
	Thu, 15 Jul 2021 09:24:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4A86E446
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 09:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVU6Bl1JqzfyymtJ1pBkY/67HnkLOSUWN/lgvmPNM6kBYwkSrfE9T0tgtZ7bAeisZwlQ4eLzkxus6Hy97g80IQUJK2SXea27F1z3vuZY65pV6qnoe8eetkiQT1ZIef+mFErZiFMxmUr470M60tNoQiNKn1Lj9pEdoRWIb2DBUp9IUCY+yn4vksZipHiXy07SrYAMN5TiHHWlZYWBYR8h1Tvhkuflk3S3YP5UnL7otEdwDE4ByecKDFZ/GB0ILMzZdg8uFJAx9LVT6AFOVvvwJ2W4GpemmtRV96xhm2Dv7OaJFTj5FUZp/ZnsEk5FTEAj2OX4bCUqUpHW1w9ZevFSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+11D20HqASb7XZN/C+g221dusiB3cSRgf4ykKVr5M+A=;
 b=oO7R4lkP2QpCKas/Ejd9RQfvF4G2NTJdqTaCI2Jq4getvXlyk5Tw4HQbN8Vgh+G0jh/g/tTUq7oIsZJoysZbiZJr/xQ95kopoOHeIAy1lDzv+1ZoK7xN+AMXbOOLgIGxoMDGet2cCjXBqc9uA0IOB3Zp5K9kA2Qk+SPTWFyQV5S7naRDwVCt1CBtjA9R0zKA2elgMDDPI+/HA22eFCU8+GE4BXtPf3QLlxtMg8jvlm8BgqmZT2OAXZjHWrndtcl5OYxu4yjOoYu0fY7+T5SthhcTC16MILmSxMAKuC6WbCEmuI8HFC4icLHYdT6lKGoDQ1oLQHPToj3hh5daPChaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+11D20HqASb7XZN/C+g221dusiB3cSRgf4ykKVr5M+A=;
 b=FmSSkUSSmRee+H7jLmcj/lJQFFJ41DxvjoowBSWPzSWcxTcr6pk3PnJCQEE3RIMcLDHbPgHHJJ6yxANGFP4589U+R/8o+Fg0H0WOR3at7pUAXHA6yZaHIqM7IedLSDgkrBe+lczAMa5QIdRKdxjRNih47Yvzvx5ORVu1ceTiv7U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 09:23:54 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 09:23:54 +0000
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: split amdgpu_device_access_vram()
 into two small parts
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210715082439.678512-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d2462552-9cd3-f34b-d67e-442405b4b7ba@amd.com>
Date: Thu, 15 Jul 2021 11:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715082439.678512-1-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR3P189CA0038.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:36d5:a331:b1c9:384b]
 (2a02:908:1252:fb60:36d5:a331:b1c9:384b) by
 PR3P189CA0038.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:23:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3235446d-8f6d-4d0a-09a0-08d9477243e4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109D24B5EE8AE8F947ED9F983129@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8IKrOqmHBiN59EoBwvyySekNGN6WUwyGRMN74ViHYzwP/qXYcegd5vKObjaV5R23GbsJRR3aa/4WdCiHPhQwrGz+Sbjb9hRmiN/Tm8LreFDLRMWCOUXUZKnpNxuZiCFDYjEF7zJuHqt4M4C+qgV9j8MyduRy8MSJZFn5KMQ+4bRCH2Jb8Dn8f82YgYVC+3wrcWkpVLx2ViBrDmOIpr0cRq9rii+AwPYSG1+JrzJJIRLkqn1gvdo/kOt5PK5iwhq1II9FHP2sYthior77+3lM+Q8H6cDJtCZ5YlwuTmfr2oHgRy/j/I1JSn8hktUrtQpjX1DEysHzr1j1w2qdPVj34RoKyn+iP5GXuMcjXCwABCUACVEsKgVsS9zqEk5yY1Zplkjrkw0/7U1KiCI3/x+twh7Ql7JmT407VbP974CjWS5jv1Z+p5BCXDdEaZ6eub/g8Fn7dBHB68OHarBPEVC79hbc7XBpHfj4Fk7h9Ek//aBVjnV/6B8aT/x8w3Knllk4IduWdEoKMCaXfidiWZj1dm3CQmQNKoR0AZGxULYyAzvaS4l5RLPqjn9NYR2Cpqqo/dULbcM6iKKTCdaffXMCrpR2AsBok08PCR+TsVYJSgBcvGpEHG5XXh2SHXNAqCuBmVgf9z9HGAXXS7qUeepRNfcMk830vpAzzdXQ7Go/cRvwQqlSOJyPZlcIQIPwKZjmWhQAmP0KptXSOqbBRo1o/8WfGQxTPhZ8/yDnfYz2AU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(31686004)(6486002)(36756003)(83380400001)(478600001)(86362001)(31696002)(2616005)(316002)(8676002)(66556008)(66476007)(66946007)(8936002)(2906002)(6666004)(186003)(4326008)(5660300002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JOY3JtQVRQeHpVVTZlL2sveVJiaVFMdG5RN2lFaUwzcnVCRWRlNWVidk5Y?=
 =?utf-8?B?c2h6WW9xa1VvTmo0cG5VZDM2bjhTMU1ETUtWODhSSnFsZEhNRXlqS1p3M2wy?=
 =?utf-8?B?MlVnd1lJRUZyQ2FZVDF5TXUzSjBhTTVSM2dXQTNMamxwZmU3NkRHV1F0b1o1?=
 =?utf-8?B?RlljYkdXZit3ZGN2T0tqY0prbjV0dkNTZW9pV0tCalNCOGp3SkJ2aXNqMXpC?=
 =?utf-8?B?T3oxMXlGa0NVV01sb3ZkYmpqU1Q1ZTFYTy9KMWhIejIzY0hvck5DRVczS05I?=
 =?utf-8?B?SFgycHpQSFZwVUZqdWxDbXhMRVRVSG5mcTVOLzJ1MTNPZXFWNVBpMFdQU1lW?=
 =?utf-8?B?aXV5TitKS09hNFRPR01qdVZueEsvNzZ2WVE2WTNLcGFPVERmcGlxUXpkTEI0?=
 =?utf-8?B?WmdTTUFpM3VxeUdTczJhckZValZqbzFsaXNtMzlCcVV3b09NWGtLclJlMVIv?=
 =?utf-8?B?N3l6aGVZSW9aVm5MV25OcmhlQWlxbEJ2ZDloQno0OWlkcUJUWENvRk5qUFhB?=
 =?utf-8?B?QlZ4K3VmcVhpbGRIdTMraUV4eng4Q2lDVUNoR3J5alZWcmpzb2srNkJnb2Nz?=
 =?utf-8?B?bzdXcjlYalU0azdma3prLzlxK1lJTWFYRTVnRnBkY05Hd1pUREU5WGhMQ1BM?=
 =?utf-8?B?c3lhZmxjTkZGRk5id3V3c2VGbW5GaGErU2dSVE9mbWtkK3RIckhabWFVaEUw?=
 =?utf-8?B?a3VURDBXc3AyR0RoOVUrZHBXZnJGWnByVWppUkxmZHlkbmxNdFl5ZnJUQ2RN?=
 =?utf-8?B?cmo2QnlCeC9oYkJEN0JNVjE3UVBubmw1bHZKYUI2aitibmhwSmJoU3Z5dzRJ?=
 =?utf-8?B?Zm5jSTgyeWIxU2lUVENiNUgvLzllNlFERnE1bTlBOUdLc3dhZldBSU91TERV?=
 =?utf-8?B?eE9penJuYUF5aGF5Qis2SHRGVTR3Vk9ueUJML1F1aXh2RjdyZHJvdmFNZXUx?=
 =?utf-8?B?cGhKZFBMKzAwaVlsR29nSlFMZlYwRFgxek1TU0N2STdkNmNuNmhGbDNYU0Vr?=
 =?utf-8?B?TlFwZWZ6clR5cnpiQ2hvU2R2eHRrRlJUTFJuWnlIWS9vYUN5THNhMVZSQmxk?=
 =?utf-8?B?c25uWTBvdzJVOWhQTVh3a1V5WXYrSEdRVkVIREJadEUrdC9aQXZEbXhJUldU?=
 =?utf-8?B?S0NmdWNOL1FXYlMyQWtFbk5CZTdQL3FaR1pXU0srQVROUXlmaGpzM2E3Um1Y?=
 =?utf-8?B?VDlRZDlZZkVqbEhNZ2JZRUIwbG5vU3FpNXZPZ0Fud2s1MXFHZVVKSWJZUFBC?=
 =?utf-8?B?ZVBLZ2x4UWFmb0tXNVUrS2JLL2RZcGxaUThVbFB2aHZRQ0N6U2k1TGI5REZw?=
 =?utf-8?B?b2JERHUvZUd0NTllMG1QdWZoNWROR0Y4eEdUSS9ZaVlZc3cxbDEwRnlNbU5X?=
 =?utf-8?B?dm1xSzFTR1pHb3A1RU9FTjQ3N0h3bWhBcFk3WktScVcraHAvdDV0b3ZBSzlI?=
 =?utf-8?B?U2wvOVA0QmdWaXYzNkttM3o3bXpxNHdaMzcvNXpQK3VLUkVLQll5aHdLZEFq?=
 =?utf-8?B?Z3h1enEvaWJpaW8rdzlIT0s1dC9OK3k4M2lpZFVvcVN1ekJzbTVxemtYd0RK?=
 =?utf-8?B?enJ1YXo4emc4Q3VhUFFPSXkvMURwM3Z3T3MvdkZ1OFgvZEYzV08rc3NyeWo5?=
 =?utf-8?B?dWJ4RmhHZXJIZlUwalBpZTZiUHk5TGhLUWJzaTRYc0I1ZGJxMW9rRWRHMEJ5?=
 =?utf-8?B?YVN2Uk9zWTJUS1lnRnBINm01WGxkOThLdGNYOWs0Rkp3Yy9rVUpCRFRYYXMv?=
 =?utf-8?B?VlpYYlhVSytzMmNnTlVXZU8vRUVldXZPdTcrWjkwYkMxOUN1SGEvR0ROYmwz?=
 =?utf-8?B?ekVsNUNKRGIwNjdTQWN3aXh4a2UwU1o2RjFTb0FqWjB3anI5M2tvbnpvZWRj?=
 =?utf-8?Q?FgizWgvMSycav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3235446d-8f6d-4d0a-09a0-08d9477243e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:23:54.1777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2CNAbVQNVDSbOiZ4aqZAZjcNDXO6i3ZBpC5EnI7RPW49uDkVVr7TH7QbJm4fEFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, frank.min@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.07.21 um 10:24 schrieb Kevin Wang:
> split amdgpu_device_access_vram()
> 1. amdgpu_device_mm_access(): using MM_INDEX/MM_DATA to access vram
> 2. amdgpu_device_aper_access(): using vram aperature to access vram (option)

Still not the approach I had in mind, but let's move forward we need to 
get this fixed.

>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 101 ++++++++++++++++-----
>   2 files changed, 82 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d14b4968a026..dd2fc89f5c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1102,8 +1102,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   void amdgpu_device_fini(struct amdgpu_device *adev);
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>   
> +void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
> +			     void *buf, size_t size, bool write);
> +size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
> +				 void *buf, size_t size, bool write);
> +
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -			       uint32_t *buf, size_t size, bool write);
> +			       void *buf, size_t size, bool write);
>   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   			    uint32_t reg, uint32_t acc_flags);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index eb1f3f42e00b..4a9a7e4d3908 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -285,7 +285,7 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
>    */
>   
>   /**
> - * amdgpu_device_vram_access - read/write a buffer in vram
> + * amdgpu_device_mm_access - access vram by MM_INDEX/MM_DATA
>    *
>    * @adev: amdgpu_device pointer
>    * @pos: offset of the buffer in vram
> @@ -293,19 +293,58 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
>    * @size: read/write size, sizeof(@buf) must > @size
>    * @write: true - write to vram, otherwise - read from vram
>    */
> -void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -			       uint32_t *buf, size_t size, bool write)
> +void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
> +			     void *buf, size_t size, bool write)
>   {
>   	unsigned long flags;
> -	uint32_t hi = ~0;
> +	uint32_t hi = ~0, tmp = 0;
> +	uint32_t *data = buf;
>   	uint64_t last;
>   
> +	BUG_ON(!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4));
> +
> +	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> +	for (last = pos + size; pos < last; pos += 4) {
> +		tmp = pos >> 31;
> +
> +		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +		if (tmp != hi) {
> +			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> +			hi = tmp;
> +		}
> +		if (write)
> +			WREG32_NO_KIQ(mmMM_DATA, *data++);
> +		else
> +			*data++ = RREG32_NO_KIQ(mmMM_DATA);
> +	}
>   
> +	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +}
> +
> +/**
> + * amdgpu_device_vram_access - access vram by vram aperature
> + *
> + * @adev: amdgpu_device pointer
> + * @pos: offset of the buffer in vram
> + * @buf: virtual address of the buffer in system memory
> + * @size: read/write size, sizeof(@buf) must > @size
> + * @write: true - write to vram, otherwise - read from vram

Here we need an one line sentence that the function returns the number 
of bytes transferred.

> + */
> +size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
> +				 void *buf, size_t size, bool write)
> +{
>   #ifdef CONFIG_64BIT
> +	void __iomem *addr;
> +	size_t count = 0;
> +	uint64_t last;
> +
> +	if (!adev->mman.aper_base_kaddr)
> +		return 0;
> +
>   	last = min(pos + size, adev->gmc.visible_vram_size);
>   	if (last > pos) {
> -		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> -		size_t count = last - pos;
> +		addr = adev->mman.aper_base_kaddr + pos;
> +		count = last - pos;
>   
>   		if (write) {
>   			memcpy_toio(addr, buf, count);
> @@ -317,30 +356,42 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>   			memcpy_fromio(buf, addr, count);
>   		}
>   
> -		if (count == size)
> -			return;
> -
> -		pos += count;
> -		buf += count / 4;
> -		size -= count;
>   	}
> +
> +	return count;
> +#else
> +	return 0;
>   #endif
> +}
>   
> -	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -	for (last = pos + size; pos < last; pos += 4) {
> -		uint32_t tmp = pos >> 31;
> +/**
> + * amdgpu_device_vram_access - read/write a buffer in vram
> + *
> + * @adev: amdgpu_device pointer
> + * @pos: offset of the buffer in vram
> + * @buf: virtual address of the buffer in system memory
> + * @size: read/write size, sizeof(@buf) must > @size
> + * @write: true - write to vram, otherwise - read from vram
> + */
> +void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> +			       void *buf, size_t size, bool write)
> +{
> +	size_t count;
>   
> -		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -		if (tmp != hi) {
> -			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -			hi = tmp;
> -		}
> -		if (write)
> -			WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -		else
> -			*buf++ = RREG32_NO_KIQ(mmMM_DATA);
> +	/* try to using vram apreature to access vram first */
> +	count = amdgpu_device_aper_access(adev, pos, buf, size, write);
> +	if (count == size)
> +		return;
> +
> +	 if (count && count < size) {
> +		pos += count;
> +		buf += count;
> +		size -= count;
>   	}

Either just do it like this:

size -= amdgpu_device_aper_access()
if (size) ....

Or use ssize_t as return value for amdgpu_device_aper_access() and add 
error handling here, but I don't see the need for this.

Apart from that the patch looks good to me.

Regards,
Christian.

> -	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +
> +	/* using MM to access rest vram */
> +	if (size)
> +		amdgpu_device_mm_access(adev, pos, buf, size, write);
>   }
>   
>   /*

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
