Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD9C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 15:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22C3206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ugNw/oRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22C3206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1086E2C4;
	Mon, 23 Dec 2019 15:21:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5279C6E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 15:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtT+Rw6j7y9bN5Tq68S3JiAQglFnCh42FVAKk98o27pI1AtBJC0VeWc6Y1atpHbOeBce+7Jp8XO7n8Pxiq/OjI2Yb2qAzHSy9YnyTWqWbE9t0AzdnQY7PHFbsyTxq5j8aJFUVkEBeJWNcMdc9I6jTcXNfMMYaqeZXmJo+rqHbnXDuLLFMzfx0gboNCJ/arYZ9xoszV7PgMhVKP1gbIvLaV2CVQHUa6BpvKfNA4+LpzebRxvYgSt+rDqnqOqucWkBVLqQPEL3YCYh+LUF+aiBFLJcRoMnybbdCYMXuW6SOBcTQd+cOdQfgyMXzF0T4DKodsQoMqjJg2q0TA7iKnphSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYAT9k2A+1+kAd7gm7wVbQfhQGel5/XCL+qL0Ihr2/M=;
 b=IkNzlTV4fRxQdKIm1irX0TY9geKdNqModWJLJWimjhJRXdGdu13w1Q0QtvMaTVrR1LwEGm0/ILCJFQDiyOITrhW6Qa6ykewPqXq6zk85tXSdaksaVbpYuvfhwjFnQZNkJdcM7vLbsTZMWM65G4QSse00BSzh4c3mf34qoAno7FvNfigK1wXfniSNw/BokUxbStzrgf5gA00G3sbFjyOF48sJEILsfvf02TMDjvEuXFkt2ZzwCjrAap8yVRClTuXtJzDW8OBK4ab+Jt42ovO5YhxnEbqhFDrJlqrKzor37VUaAF2KdkZ6LFjqYKdQBWrAJSWlUSW12nPrXK1c8AY+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYAT9k2A+1+kAd7gm7wVbQfhQGel5/XCL+qL0Ihr2/M=;
 b=ugNw/oRO7W46uZcpbDWvP9zhaPFVNigrKhqN/9BKtvG0G7gEPkoJ6r/mJah+wWbfl6EoNYL+RVdsYDRAtf3hpUH8AKEZ9V8Pl0WQvHLjbBfhXTX0JL3jWlOl9FuVsRx/zqML4+JbfmIuJj6hPGpTixV7jWDYHjoZlJpmQCG+0Pw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0008.namprd12.prod.outlook.com (10.172.118.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 15:21:04 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d%11]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 15:21:04 +0000
Subject: Re: [PATCH] drm/amd/display: fix kernel_fpu_begin/_end() warnings
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191223032258.7327-1-xiaojie.yuan@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <569a81e1-e5df-2bdb-ba3e-11a22d2be73d@amd.com>
Date: Mon, 23 Dec 2019 10:21:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20191223032258.7327-1-xiaojie.yuan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 23 Dec 2019 15:21:03 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ef85ebd-0618-4be9-940d-08d787bbb9a7
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0008:|CY4PR1201MB0008:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB000810455AE8A43A1945C6EB8C2E0@CY4PR1201MB0008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(52116002)(16576012)(4326008)(4001150100001)(26005)(81166006)(81156014)(8676002)(186003)(16526019)(8936002)(316002)(31696002)(31686004)(66556008)(66476007)(66946007)(5660300002)(2616005)(6486002)(53546011)(956004)(478600001)(2906002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0008;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFQgJ4Bh31DMmZI8mL5pCUnsclXjscSC/YAr35pxv9SYTPnAfjzB5pnTWT5GW6zUWDhg+j8Hb10MjahSnRWBeACmojNOlKQuPB4TzEnHZG0ag3tuuywfxZaA8KZZpUXAXzFbdiehQogUbW6hU2PgeO+SMjQRIoUcsHX+lR9S7dgqzxSmwF3JrtQTHX7eufkHPXgJBqeIcSdbsJUlyiDVgdSQwi4BFexlgRzV5OjOMoa4z0tOfelWyU3Pp4UpbyugKk7t5TfZqGMcHs03El9gwY8kgIQNbAtvyyGz6QfVG1p1EcKqrs6X6MsvUnWKLVmoltBgNKxjdlztpR4ePNQW4KDE/jVMQt8WSrCf5K16CGp3ciJ8ZxWgmcF7xZXqtKFDv4O4ZfZ6n/VxJ0sk/KLhp40k8MWWF6p3omh6D+FSIcsb6n+3sc7ruHAZv+LRtM8s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef85ebd-0618-4be9-940d-08d787bbb9a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:21:04.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zbr/Xr6Mkwf1Btw5io/TH3lb0X+PL7aEkdaaSHvkuiYeY74e5bBRtoQRVSel+rtpBjzhdoBMCMAPqhTI+GUaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0008
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
Cc: harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-22 10:22 p.m., Xiaojie Yuan wrote:
> kernel_fpu_begin/_end() are already called inside dcn20_resource_construct,
> and calling kernel_fpu_begin/_end() recursively triggers WARN_ON() when
> CONFIG_X86_DEBUG_FPU is enabled.
> 
> [  107.060434] WARNING: CPU: 6 PID: 1370 at arch/x86/kernel/fpu/core.c:90 kernel_fpu_begin+0xbd/0xe0
> <snip>
> [  107.268197] Call Trace:
> [  107.270751]  dcn20_patch_bounding_box+0x17/0x100 [amdgpu]
> [  107.276204]  init_soc_bounding_box+0x1b3/0x5f0 [amdgpu]
> [  107.281536]  ? _cond_resched+0x19/0x30
> [  107.285307]  dcn20_resource_construct+0x3a9/0xa90 [amdgpu]
> [  107.290957]  ? dcn20_resource_construct+0x3a9/0xa90 [amdgpu]
> [  107.296621]  ? __alloc_pages_nodemask+0x16a/0x330
> [  107.301476]  ? _cond_resched+0x19/0x30
> [  107.305284]  ? kmem_cache_alloc_trace+0x197/0x230
> [  107.310063]  ? _cond_resched+0x19/0x30
> [  107.313783]  ? kmem_cache_alloc_trace+0x197/0x230
> [  107.318691]  dcn20_create_resource_pool+0x42/0x70 [amdgpu]
> [  107.324315]  dc_create_resource_pool+0x12d/0x170 [amdgpu]
> [  107.329851]  dc_create+0x1b8/0x6a0 [amdgpu]
> [  107.334013]  ? kmem_cache_alloc_trace+0x1e2/0x230
> [  107.338832]  amdgpu_dm_init+0x13e/0x1c0 [amdgpu]
> <snip>
> 
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index d72e921fffa0..9f346ffb6e78 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3225,7 +3225,6 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
>  
>  void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb)
>  {
> -	DC_FP_START();
>  	if ((int)(bb->sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
>  			&& dc->bb_overrides.sr_exit_time_ns) {
>  		bb->sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
> @@ -3249,7 +3248,6 @@ void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st
>  		bb->dram_clock_change_latency_us =
>  				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
>  	}
> -	DC_FP_END();
>  }
>  
>  static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
