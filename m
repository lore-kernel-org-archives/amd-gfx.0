Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76FC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EA3222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GbOh45rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EA3222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911806E0A1;
	Thu, 19 Dec 2019 02:59:38 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF90C6E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 02:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQRCdhM1NabpMBp9SE738DR9r3U801Gaw258a2Ns0BBrm1PAwIarF3cwgLOXI6fia2U/jt5iIh0sxsvMIejE1KQzxy3rxiIJNXiZ2nAFGoyrXCiL6wQPZq1XprR+AdEAMHAeyTnnM24HV3nUiM3lavaHbv1T71ukPJ+6VNsdIfwC6WFc0S3vjrCCrUkjHztJYeg2Q13YybZ5LvC65//Vg3Q7wb+CfuS4IC5FDR8nAPJRVb2aRJAByzoTvaonJvoOtfd6t3OVTz1bIC/ooI53ArcgaaM7tJgT9/PG7qK13sLRcaYi3CH9oQ3Otzi+6Zej13X6vkPDOBBsMhT2s/9qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXW2HXzPJ4tQcZ+/zeIL/UJuz6OiKYoOYilQYEvxYE4=;
 b=QCXt2QTp5LEQ+PKUgoxKQGCCHXZAUetwchG67qhp5DipgWCUyNCJHDp5BVgczq8RZgwnYcOXSiZRugg6LH5o0dC6MAmZfi63kTZ+h7VaL3AnrAS18DuYMiA32LfMSSZGLUXEf4/6x0b8+n10c1MJLteg6sHWZHvgl4ZbiAUt069xinar7em443Yowq+RgfRdycAUMzIMvGPP3gKI9q7t+BspnIGMAF4Z5PcMSpQfMMNCvr7F/95ONMMjTI26ioxT8HTafjjgr/HNwcjEcI94U+Zqzf8QtvbgUifjDYQDZG/ZFKSHvQ48WgBZ+cRyuRiyp9bX+1WRimzpI9/Y9SS4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXW2HXzPJ4tQcZ+/zeIL/UJuz6OiKYoOYilQYEvxYE4=;
 b=GbOh45rPr8rQ3P29/Hj0IVKHxnjY+catnwomGcaiR6sXfd41oQca5Z2R58eXkLh8NaTcs7oBN20OQACXxtyh+3zaqjDL/UKpVqn52k/Tkct9ioWqrRZ7sid4LB0fJqNJK+oPNgHMqSciRX9mM/ER7NFQozmwN4kLyAlSeLWWcZc=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1679.namprd12.prod.outlook.com (10.172.55.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 19 Dec 2019 02:59:33 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.022; Thu, 19 Dec 2019
 02:59:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify padding calculations (v3)
Thread-Topic: [PATCH] drm/amdgpu: simplify padding calculations (v3)
Thread-Index: AQHVtfihHzl/nww8DkWKF0mOw4HE86fAhm8AgAA9/oA=
Date: Thu, 19 Dec 2019 02:59:33 +0000
Message-ID: <MWHPR12MB13583FE24170AEBBBD3DD450F7520@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191218231217.204500-1-luben.tuikov@amd.com>
 <001a6842-50cb-dd1f-2adb-1cd24f03afec@amd.com>
In-Reply-To: <001a6842-50cb-dd1f-2adb-1cd24f03afec@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed38e793-ac20-422f-a4bf-08d7842f7997
x-ms-traffictypediagnostic: MWHPR12MB1679:|MWHPR12MB1679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1679F7C39DBD2A62BC3E63C4F7520@MWHPR12MB1679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(13464003)(199004)(189003)(26005)(186003)(81166006)(9686003)(71200400001)(110136005)(4001150100001)(53546011)(6506007)(33656002)(316002)(478600001)(81156014)(66446008)(76116006)(4326008)(8676002)(66556008)(66476007)(8936002)(64756008)(66946007)(2906002)(55016002)(7696005)(86362001)(52536014)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1679;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXtjiapzDqRGy9m5o5syAT/NMl0iMTrbYSlKoqmk8CmCk1uSAIJPn85Z/VacGUCApjMB+PpX6lyZuG5kEhkEitoMwAJP01VTZ5xM3dmttEioc1wnm2okH8rXyB8M/O7m3Yx0juYwsgnJzk/82G0uM7c+khvanGycZd3jxz5j4kLz7KP9xOGvtSafpHB0Q3KFWIg5F5yPt8H9Zsyb2JbfH5jydMKiNCBCXXfOIXoUe2mLIh9B9Gwt7bk/aQktGPQjwMXnyn7w+5tnTIFffB5TGZuAqmXb+xJ92tG/Axy6P9uJ7vrJUO0HXR9j0N0qJWJTc28HX0RaekwDdeQ/mDsAiClUSdPurf0OAA71uUBAo0YwfD9ZmZbED1zI6IgH9gT+rbLww6JrG1gzk7FPQ0k7ftOkHNxbW+2ZWseskNGC1nQmNeHrEx35aAo0R2iPy+NxpLCXgYOeU0yn4fQPGP1JFN7p8AgnbhNI3EUku8YCNufJNmcnrdh56G+zo+zfgHIV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed38e793-ac20-422f-a4bf-08d7842f7997
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 02:59:33.3025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjCWwKfj5a9wAv69M+SzxnYBtiXAhPyWi26hRZMfza7VhrK/S4wEi6qRmKlg6bJFTDlAOeyWW9KPCmddnR4Raw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1679
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Wednesday, December 18, 2019 6:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: simplify padding calculations (v3)
> 
> This patch seems to have been dropped after posting and reposting. I'm not
> sure why it keeps being dropped.

Dropped from what?  Once it's been reviewed, add the RBs and go ahead and push it to amd-staging-drm-next.

Alex

> 
> In v3, I added an explanation in the commit text below the original commit
> text of the single sentence of "Simplify padding calculations." Identical
> diffstat as v2.
> 
> Regards,
> Luben
> 
> On 2019-12-18 6:12 p.m., Luben Tuikov wrote:
> > Simplify padding calculations.
> >
> > 1. Taking the remainder of a binary value when the divisor is a power
> > of two, such as, a % 2^n is identical to, a & (2^n - 1) in base-2
> > arithmetic, and so expressions like this:
> >
> > (12 - (lower_32_bits(ring->wptr) & 7)) % 8
> >
> > are superflous. And can be reduced to a single remainder-taking
> > operation.
> >
> > 2. Subtracting the remainder modulo 8 out of 12 and then again taking
> > the remainder modulo 8, yields the same result as simply subtracting
> > the value out of 4 and then taking the remainder.
> > This is true because 4 belongs to the congruence
> > (residue) class {4 + 8*k}, k in Z. (So using,  {..., -12, -4, 4, 12,
> > 20, ...}, would yield  the same final result.
> >
> > So the above expression, becomes,
> >
> > (4 - lower_32_bits(ring->wptr)) & 7
> >
> > 3. Now since 8 is part of the conguence class
> > {0 + 8*k}, k in Z, and from 1) and 2) above, then,
> >
> > (8 - (ib->length_dw & 0x7)) % 8
> >
> > becomes, simply,
> >
> > (-ib->length_dw) & 7.
> >
> > This patch implements all of the above in this code.
> >
> > v2: Comment update and spacing.
> > v3: Add 1, 2, 3, above, in this commit message.
> >
> > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |  4 ++--
> > drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |  4 ++--
> > drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |  4 ++--
> > drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  4 ++--
> > drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 17 ++++++++++++-----
> >  5 files changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > index 1f22a8d0f7f3..4274ccf765de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > @@ -228,7 +228,7 @@ static void cik_sdma_ring_emit_ib(struct
> amdgpu_ring *ring,
> >  	u32 extra_bits = vmid & 0xf;
> >
> >  	/* IB packet must end on a 8 DW boundary */
> > -	cik_sdma_ring_insert_nop(ring, (12 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
> > +	cik_sdma_ring_insert_nop(ring, (4 - lower_32_bits(ring->wptr)) & 7);
> >
> >  	amdgpu_ring_write(ring,
> SDMA_PACKET(SDMA_OPCODE_INDIRECT_BUFFER, 0, extra_bits));
> >  	amdgpu_ring_write(ring, ib->gpu_addr & 0xffffffe0); /* base must
> be
> > 32 byte aligned */ @@ -811,7 +811,7 @@ static void
> cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
> >  	u32 pad_count;
> >  	int i;
> >
> > -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
> > +	pad_count = (-ib->length_dw) & 7;
> >  	for (i = 0; i < pad_count; i++)
> >  		if (sdma && sdma->burst_nop && (i == 0))
> >  			ib->ptr[ib->length_dw++] =
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > index 606b621145a1..fd7fa6082563 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > @@ -255,7 +255,7 @@ static void sdma_v2_4_ring_emit_ib(struct
> amdgpu_ring *ring,
> >  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
> >
> >  	/* IB packet must end on a 8 DW boundary */
> > -	sdma_v2_4_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
> > +	sdma_v2_4_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
> > +7);
> >
> >  	amdgpu_ring_write(ring,
> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
> >  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -750,7 +750,7 @@
> > static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct
> amdgpu_ib *ib
> >  	u32 pad_count;
> >  	int i;
> >
> > -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
> > +	pad_count = (-ib->length_dw) & 7;
> >  	for (i = 0; i < pad_count; i++)
> >  		if (sdma && sdma->burst_nop && (i == 0))
> >  			ib->ptr[ib->length_dw++] =
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > index a559573ec8fd..4a8a7f0f3a9c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -429,7 +429,7 @@ static void sdma_v3_0_ring_emit_ib(struct
> amdgpu_ring *ring,
> >  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
> >
> >  	/* IB packet must end on a 8 DW boundary */
> > -	sdma_v3_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
> > +	sdma_v3_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
> > +7);
> >
> >  	amdgpu_ring_write(ring,
> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
> >  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1021,7 +1021,7
> > @@ static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct
> amdgpu_ib *ib
> >  	u32 pad_count;
> >  	int i;
> >
> > -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
> > +	pad_count = (-ib->length_dw) & 7;
> >  	for (i = 0; i < pad_count; i++)
> >  		if (sdma && sdma->burst_nop && (i == 0))
> >  			ib->ptr[ib->length_dw++] =
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > index bd9ed33bab43..c69df0cb21ec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > @@ -698,7 +698,7 @@ static void sdma_v4_0_ring_emit_ib(struct
> amdgpu_ring *ring,
> >  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
> >
> >  	/* IB packet must end on a 8 DW boundary */
> > -	sdma_v4_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
> > +	sdma_v4_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
> > +7);
> >
> >  	amdgpu_ring_write(ring,
> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
> >  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1579,7 +1579,7
> > @@ static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct
> amdgpu_ib *ib
> >  	u32 pad_count;
> >  	int i;
> >
> > -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
> > +	pad_count = (-ib->length_dw) & 7;
> >  	for (i = 0; i < pad_count; i++)
> >  		if (sdma && sdma->burst_nop && (i == 0))
> >  			ib->ptr[ib->length_dw++] =
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > index 119364293cec..3912937f878f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -382,8 +382,15 @@ static void sdma_v5_0_ring_emit_ib(struct
> amdgpu_ring *ring,
> >  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
> >  	uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring,
> vmid);
> >
> > -	/* IB packet must end on a 8 DW boundary */
> > -	sdma_v5_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
> > +	/* An IB packet must end on a 8 DW boundary--the next dword
> > +	 * must be on a 8-dword boundary. Our IB packet below is 6
> > +	 * dwords long, thus add x number of NOPs, such that, in
> > +	 * modular arithmetic,
> > +	 * wptr + 6 + x = 8k, k >= 0, which in C is,
> > +	 * (wptr + 6 + x) % 8 = 0.
> > +	 * The expression below, is a solution of x.
> > +	 */
> > +	sdma_v5_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
> > +7);
> >
> >  	amdgpu_ring_write(ring,
> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
> >  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
> @@ -1076,10 +1083,10
> > @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,  }
> >
> >  /**
> > - * sdma_v5_0_ring_pad_ib - pad the IB to the required number of dw
> > - *
> > + * sdma_v5_0_ring_pad_ib - pad the IB
> >   * @ib: indirect buffer to fill with padding
> >   *
> > + * Pad the IB with NOPs to a boundary multiple of 8.
> >   */
> >  static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct
> > amdgpu_ib *ib)  { @@ -1087,7 +1094,7 @@ static void
> > sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
> >  	u32 pad_count;
> >  	int i;
> >
> > -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
> > +	pad_count = (-ib->length_dw) & 0x7;
> >  	for (i = 0; i < pad_count; i++)
> >  		if (sdma && sdma->burst_nop && (i == 0))
> >  			ib->ptr[ib->length_dw++] =
> >

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
