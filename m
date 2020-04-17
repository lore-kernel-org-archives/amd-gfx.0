Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F52C2BB55
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 08:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C93208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HnhwbqAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C93208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C535B6E3DB;
	Fri, 17 Apr 2020 08:59:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2761E6E3D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 08:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4QQ9UEIMT3qcl5+yvxvaBrM4yDYZVNxTVJRu03fAGbFQVAoU+FOSSdQa/4JEl8UX2pJcLKJa9XoZTLPKBoJWwVKckGB29/qP7Dhcmn4zdnfc7qcpjyJRD0kSpforYHqV+GnkjOg1V347sMa7fPodoqgbqOZ6ulJl3XAZnSrMEEbkxyvIloxDINTgXIVzXEsyCcNgMjIsnBp/2jIsMOPnc11+c3p3ALcqDKW/0G2/oQB/dub3fWCmlEkqSlIHqHi21ogb3bA3gickZOeZLorhraL8lkHs7FPmpE+zE32CpVmFAPkJlBom1LDwu0pPGMw/fQUgkaEnEMWSesCkLP0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy6T0tYGyiXhur5Wa5R5Ai1oIKOwdB9gr39o/WUQu5o=;
 b=C22Apjr1EV1WLGadQKSSAcTCFQYUNjJXwQf1qdcOpLfUMKVkWVOQvJmh5zIVMns3M7Ptgr4ktIUiRCI2gHnK/nVlWKJmrSBY9Q3WzHgLHau4FcUUEcw1h6xEaswSg54rbQ9Y0WmWArKWsBvMGy5ndHBGVfrKfd5BknW2DaFf1B+P3D3EIYVNKqfLXWzyKK6WG3qfmWyuT8jMGBHymGJBIFkDnaf7utaRXFMIW5Imz81Rr4l1t+vuWU1axRk7DE7rmpQAPa22YtCZmIm3Qtc8XCWZtGSdkXzW2/zPDtZ6IknXQt87D0aKSGZZ5dgDzG1DC2n9TB+PAzmgorGnHGtvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy6T0tYGyiXhur5Wa5R5Ai1oIKOwdB9gr39o/WUQu5o=;
 b=HnhwbqAG2n3MMi/MM97dEGSwMmjesOw3PXFejgVJ0qo+PvmYVzNy69M7XZVFXkDSqnzwpnLM20C+Xmj+wd9geJqu5RhltRsHsOCJ43jiaMqExLpv8WJrPy1Ekyg8Gw00QVG3PVoXtg76sixP5Ct8pXafUaG/ZP2aMoaoGfLsWMc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 by MN2PR12MB3760.namprd12.prod.outlook.com (2603:10b6:208:158::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 08:58:54 +0000
Received: from MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::cc36:ee17:c768:8427]) by MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::cc36:ee17:c768:8427%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 08:58:54 +0000
Subject: Re: [PATCH] drm/amdgpu: refine kiq read register
To: "Liu, Monk" <Monk.Liu@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20200417065310.21108-1-yttao@amd.com>
 <DM5PR12MB1708AB26054FA715829B65A684D90@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a65bfe3f-0340-7e3b-24e4-bfc1850b01a4@amd.com>
Date: Fri, 17 Apr 2020 10:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM5PR12MB1708AB26054FA715829B65A684D90@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To MN2PR12MB4408.namprd12.prod.outlook.com
 (2603:10b6:208:26c::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Fri, 17 Apr 2020 08:58:53 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa96c03c-6285-4a28-3d4c-08d7e2ad8e66
X-MS-TrafficTypeDiagnostic: MN2PR12MB3760:|MN2PR12MB3760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3760DB5417B3FD27B0E5708683D90@MN2PR12MB3760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4408.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(66476007)(36756003)(8936002)(66556008)(5660300002)(66946007)(478600001)(30864003)(6636002)(81156014)(8676002)(2906002)(31696002)(31686004)(316002)(6666004)(4326008)(86362001)(186003)(6486002)(16526019)(2616005)(53546011)(52116002)(110136005)(921003)(1121003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xAXwzRPQSPwUR3B/fWgV/V0HSR+yV09R4etPXDnXUVeuhk1WlsxRZInDHOuSGBTi7i0vM3eK/4ZkfjLbYTDkNN3fqYjZoMboQ/DfQemmxEIk13HLz3oI2TN/q58RNhKCFtsu/hlOTbZ2Ttpxl3mKdXmJaFN1ATua39zmM9dNHXZgb7iUgelNl5PaWcbm1I5zFvYUUJdULhno0VMEt/sgQvJQp9tBsV8q4dY2uM93bUKLOwd5sOOOkNakPq27sbfuwtBA/UzWoAJq3BCnnlUxOfnEmyqeS6omH3PeSMF7kP1QPiPC7ixUScN9KkIEs3Zoz64Rb5PYmnoijlUpaJipeOCKMWn3Pmktp3vJ7za0ZaQi0wajl4e9wq6aSIo22m7BwX2oOt71MFA32E5uTgNLu+fLRupWTAiJ0JgqOe3d9hdbfzoS+xW9MrVdK2Wq8myYuWMzd8NSCOFd7qbKYcVNs4N7TnXth7iN9rm68YWi8J07xM9C1/z3dBEOxKy62Ei
X-MS-Exchange-AntiSpam-MessageData: mW3PucBVMszRbXw6sUdoM2gfua4IvJm4dLQD2fWeh7BKSXIrnxwOVaDFlarXdsQT/mNeyXSGWNVYOfxoqNbJIbOL/lGfhgmdKsR4Q7Sctc4C7fwMuJzeUHYZwOKuyMKgnOMy1MZl5cn8MQuqOxl89hkcTZqPtYh+W7jlRTZNzFJnBkUwUgAWl1VJP7wSSsIsNZdDVjGcNpG4uulNmmGuTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa96c03c-6285-4a28-3d4c-08d7e2ad8e66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 08:58:54.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXIM4+FIwGGVZhU02kF0dnlhnwdqG2WEuA9orsmkDAXIU0kStaGxcbGNbuGPeXeS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like a rather important bug fix to me, but I'm not sure if writing 
the value into the ring buffer is a good idea.

See we wanted to map the ring buffers read only and USWC for some time. 
That would result in either not working driver or rather crappy performance.

Can't we just call amdgpu_device_wb_get() in amdgpu_device_wb_get() 
instead and allocate the wb address dynamically?

Regards,
Christian.

Am 17.04.20 um 09:01 schrieb Liu, Monk:
> The change Looks good with me, you can put my RB to your patch .
>
> Since this patch impact on general logic (not SRIOV only) I would like you wait a little longer for @Kuehling, Felix and @Deucher, Alexander and @Koenig, Christian  @Zhang, Hawking
>
> If any of them gave you a RB I think we can go this way
>
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: Yintian Tao <yttao@amd.com>
> Sent: Friday, April 17, 2020 2:53 PM
> To: Liu, Monk <Monk.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
> Subject: [PATCH] drm/amdgpu: refine kiq read register
>
> According to the current kiq read register method, there will be race condition when using KIQ to read register if multiple clients want to read at same time just like the expample below:
> 1. client-A start to read REG-0 throguh KIQ 2. client-A poll the seqno-0 3. client-B start to read REG-1 through KIQ 4. client-B poll the seqno-1 5. the kiq complete these two read operation 6. client-A to read the register at the wb buffer and
>     get REG-1 value
>
> Therefore, directly make kiq write the register value at the ring buffer then there will be no race condition for the wb buffer.
>
> v2: supply the read_clock and move the reg_val_offs back
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 11 ++++------  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 -  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 14 +++++-------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 +++++-------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 28 ++++++++++++------------
>   6 files changed, 33 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index ea576b4260a4..4e1c0239e561 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -304,10 +304,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   
>   	spin_lock_init(&kiq->ring_lock);
>   
> -	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
> -	if (r)
> -		return r;
> -
>   	ring->adev = NULL;
>   	ring->ring_obj = NULL;
>   	ring->use_doorbell = true;
> @@ -331,7 +327,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   
>   void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)  {
> -	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
>   	amdgpu_ring_fini(ring);
>   }
>   
> @@ -675,12 +670,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	uint32_t seq;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *ring = &kiq->ring;
> +	uint64_t reg_val_offs = 0;
>   
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>   	amdgpu_ring_alloc(ring, 32);
> -	amdgpu_ring_emit_rreg(ring, reg);
> +	reg_val_offs = (ring->wptr & ring->buf_mask) + 30;
> +	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
>   	amdgpu_fence_emit_polling(ring, &seq);
>   	amdgpu_ring_commit(ring);
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags); @@ -707,7 +704,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	if (cnt > MAX_KIQ_REG_TRY)
>   		goto failed_kiq_read;
>   
> -	return adev->wb.wb[kiq->reg_val_offs];
> +	return ring->ring[reg_val_offs];
>   
>   failed_kiq_read:
>   	pr_err("failed to read reg:%x\n", reg); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 634746829024..ee698f0246d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -103,7 +103,6 @@ struct amdgpu_kiq {
>   	struct amdgpu_ring	ring;
>   	struct amdgpu_irq_src	irq;
>   	const struct kiq_pm4_funcs *pmf;
> -	uint32_t			reg_val_offs;
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index f61664ee4940..a3d88f2aa9f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -181,7 +181,8 @@ struct amdgpu_ring_funcs {
>   	void (*end_use)(struct amdgpu_ring *ring);
>   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>   	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> -	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
> +	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
> +			  uint64_t reg_val_offs);
>   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>   	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
>   			      uint32_t val, uint32_t mask);
> @@ -265,7 +266,7 @@ struct amdgpu_ring {  #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))  #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d)) -#define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
> +#define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d),
> +(o))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))  #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))  #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m)) diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 0a03e2ad5d95..7c9a5e440509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7594,21 +7594,19 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
>   	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));  }
>   
> -static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> +static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
> +				     uint64_t reg_val_offs)
>   {
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
>   				(5 << 8) |	/* dst: memory */
>   				(1 << 20));	/* write confirm */
>   	amdgpu_ring_write(ring, reg);
>   	amdgpu_ring_write(ring, 0);
> -	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> -	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
> +	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
>   }
>   
>   static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fc6c2f2bc76c..8e7eee7838e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6383,21 +6383,19 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;  }
>   
> -static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> +static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
> +				    uint64_t reg_val_offs)
>   {
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
>   				(5 << 8) |	/* dst: memory */
>   				(1 << 20));	/* write confirm */
>   	amdgpu_ring_write(ring, reg);
>   	amdgpu_ring_write(ring, 0);
> -	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> -	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
> +	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
>   }
>   
>   static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 84fcf842316d..ff279b1f5c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4046,11 +4046,13 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   	uint32_t seq;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *ring = &kiq->ring;
> +	uint64_t reg_val_offs = 0;
>   
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>   	amdgpu_ring_alloc(ring, 32);
> +	reg_val_offs = (ring->wptr & ring->buf_mask) + 30;
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 9 |	/* src: register*/
>   				(5 << 8) |	/* dst: memory */
> @@ -4058,10 +4060,10 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   				(1 << 20));	/* write confirm */
>   	amdgpu_ring_write(ring, 0);
>   	amdgpu_ring_write(ring, 0);
> -	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> -	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
> +	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
>   	amdgpu_fence_emit_polling(ring, &seq);
>   	amdgpu_ring_commit(ring);
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags); @@ -4088,8 +4090,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   	if (cnt > MAX_KIQ_REG_TRY)
>   		goto failed_kiq_read;
>   
> -	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
> -		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
> +	return (uint64_t)ring->ring[reg_val_offs] |
> +		(uint64_t)ring->ring[reg_val_offs + 1 ] << 32ULL;
>   
>   failed_kiq_read:
>   	pr_err("failed to read gpu clock\n");
> @@ -5482,21 +5484,19 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;  }
>   
> -static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> +static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
> +				    uint64_t reg_val_offs)
>   {
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
>   				(5 << 8) |	/* dst: memory */
>   				(1 << 20));	/* write confirm */
>   	amdgpu_ring_write(ring, reg);
>   	amdgpu_ring_write(ring, 0);
> -	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> -	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
> +	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
> +					      reg_val_offs * 4));
>   }
>   
>   static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> --
> 2.17.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
