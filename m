Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED8C2BB55
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 09:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E31207FC
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 09:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rSjY6hIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E31207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0F06E3DA;
	Fri, 17 Apr 2020 09:06:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185F46E108
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 09:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxXE4edbsj7H2yCZ8+DTrEX7YxDtL1UdVRDH/kRN8nK+GdlQ+U3JNygrz6tx65sxc/5+pnTlyh60zzCau2lVeht+UoYaO0VI9xDnlEmxoNdlXV+P5EThKkRs7ZjoJEawOVkmaf8ZwNUzg1oXczSS0ttKYZ1kGWCqTU2Ktnsl0FTQvUlUo9ACceL7Ch9/hNmtLFv10w1yv6bosl20ldx+faorlav4qwBpeBlJY2HqiYEcLefF7vblFJQitwzeiC2Fq3uU/3VT/kN1HJgcEzYT3Iy6A6nYxqP/EHpy/aDf/5oC7nCxNNblqBDuHiPl6ZVrTbVpfqzchI5j9tjVLcyy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUc1gqz5L7MYqgaNhVLmGkafM9XhfzNA+ZiOGesC0HI=;
 b=GPePI3l8i/1tectszZmtth0AtVz3sRe3BEH5owRgAXfgOrV597/bPFIueyrXVtXJ1NQEHZeRYiws+SmxvJJZmtxwHQ7OPeASrJjJETwmSB9LAY4v2zoituhVJf9lux4iUrlQd6zVdfdoXD6K5wzTF+K4n9tgIssGCY/FqCC52851HHLPFHtyrozezwgxLxHYS/sait6PDzH14GVOSqxaAVo2uinGEafhNmAG0r7Z1BP/Bvzj+bKk0vZnw9VADS49IlY7Wlyzhx608VACP4HRj5+kjZB6d++F0FeJ0POfolBCwOMfWYmzp6Q0eav/ygV1qyZkO9+a6+HFwGf8EJZGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUc1gqz5L7MYqgaNhVLmGkafM9XhfzNA+ZiOGesC0HI=;
 b=rSjY6hIBc1eXPjiU49OnshfnMSvBJpKPCl2RWQpgIJ4+frkUwdXiAeIXQOlS4InVkiikNZhBoxfQwP9xid8QlKl5xOTn7fmfMek/ObDWYrQg4SC/0dKcYeetH3fWNhWLjO8CvrCl2SF0SM5HNBAhT6nbwd3Y3F/n/mxC/zJcNBM=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1403.namprd12.prod.outlook.com (2603:10b6:3:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Fri, 17 Apr
 2020 09:06:36 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 09:06:36 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine kiq read register
Thread-Topic: [PATCH] drm/amdgpu: refine kiq read register
Thread-Index: AQHWFITfuUsBKum0lUeua8U6BgyKnKh84n1wgAAhSQCAAAEeMA==
Date: Fri, 17 Apr 2020 09:06:36 +0000
Message-ID: <DM5PR12MB170834047A4ABBC474F0CE1084D90@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200417065310.21108-1-yttao@amd.com>
 <DM5PR12MB1708AB26054FA715829B65A684D90@DM5PR12MB1708.namprd12.prod.outlook.com>
 <a65bfe3f-0340-7e3b-24e4-bfc1850b01a4@amd.com>
In-Reply-To: <a65bfe3f-0340-7e3b-24e4-bfc1850b01a4@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [101.87.149.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f22176b-e6c7-48c1-1b97-08d7e2aea1b4
x-ms-traffictypediagnostic: DM5PR12MB1403:|DM5PR12MB1403:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1403373BC364BB7166B390BC84D90@DM5PR12MB1403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(55016002)(9686003)(86362001)(26005)(6636002)(76116006)(186003)(7696005)(52536014)(66946007)(6506007)(66556008)(66476007)(71200400001)(66446008)(64756008)(5660300002)(8676002)(4326008)(2906002)(30864003)(33656002)(8936002)(81156014)(316002)(53546011)(478600001)(110136005)(921003)(1121003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CJYb4aw/Iaw6buB3S+28wwG3ulmp83x2jGOn79YM9mxZpOFnRR9nvsam3s+7FO24eBWAEAtBbTTidxd9UIFFV4DE7+8cdBUM9g4lQ3IMzrBpOdy+Zsf0n01DVulIz/kzK3xQLpMpyA3WsWVX1rT65P6ejhmOpehpAMBoLcfFZZAvJjWEhFsL/I6T/qbFIODXUX9S2D8rK6ftJstnmo/gWd2smYrgRpsrQEMJa5Let+xUKZhVzFAU7OMBEK8VGmxr7wJX5IEr1xpa7+gTF7sVdn6odONF6PNY+jRfYDmNbPCxMlALfCheaC0hh5ItknfOi/Bws3FKTR1ygWxqtylert8QmLPAGlFhr4d92uPZf+T054X5nnNbweRoODbP8nkbW2/4qheG3XEJKbT+AyegUMpPrWQb4YzjiuI1/KLIzlXc/zfSLOJgU5aFghSZQCTknEYu36sWPJh2SZJ/N4X9OGEk1e+ZVJoF79YZnRsNOljmpPtT4hrZREQbdgk9Thuc
x-ms-exchange-antispam-messagedata: dq//IOvJ4nBPiAkfexp26jikr80PzY6706RtYeZvNP0GnMbIn/a7WsIMhVtL2TJkDad3o56ObYwExsUKxyoyP6/FfDaiB7RmxxNa2viguEj8SkaioE+DHdfLninmkC9zn1v5Fpu1d7+rJuOWYgk/HQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f22176b-e6c7-48c1-1b97-08d7e2aea1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 09:06:36.0537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qft3qKnHxQbXX0+23SXNARUMl6Csf4JijmFeEllFFC4L2fJXhOMwbvCwaxeGLS5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Christian

>>
See we wanted to map the ring buffers read only and USWC for some time. 
That would result in either not working driver or rather crappy performance.
<<

For KIQ the ring buffer wouldn't be read only ... should be cacheable type 

Dynamic alloc each time doing KIQ reg read is a overkill to me, leverage ring buffer is a high efficient way. 

Besides looks now the KIQ register reading is really massive, check this code:

4949 static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
4950 {
4951     u32 data;
4952
4953     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
4954
4955     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
4956     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
4957
4958     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
4959 }

Now  we do KIQ read and write *every time* we do amdgpu_vm_flush  (omg... what's this  ??)



_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Friday, April 17, 2020 4:59 PM
To: Liu, Monk <Monk.Liu@amd.com>; Tao, Yintian <Yintian.Tao@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: refine kiq read register

Looks like a rather important bug fix to me, but I'm not sure if writing the value into the ring buffer is a good idea.

See we wanted to map the ring buffers read only and USWC for some time. 
That would result in either not working driver or rather crappy performance.

Can't we just call amdgpu_device_wb_get() in amdgpu_device_wb_get() instead and allocate the wb address dynamically?

Regards,
Christian.

Am 17.04.20 um 09:01 schrieb Liu, Monk:
> The change Looks good with me, you can put my RB to your patch .
>
> Since this patch impact on general logic (not SRIOV only) I would like 
> you wait a little longer for @Kuehling, Felix and @Deucher, Alexander 
> and @Koenig, Christian  @Zhang, Hawking
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index ea576b4260a4..4e1c0239e561 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -304,10 +304,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device 
> *adev,
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
> @@ -331,7 +327,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device 
> *adev,
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
>   	pr_err("failed to read reg:%x\n", reg); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
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
>   			      uint32_t val, uint32_t mask); @@ -265,7 +266,7 @@ struct 
> amdgpu_ring {  #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))  #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) 
> (r)->funcs->emit_cntxcntl((r), (d)) -#define amdgpu_ring_emit_rreg(r, 
> d) (r)->funcs->emit_rreg((r), (d))
> +#define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), 
> +(d),
> +(o))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), 
> (d), (v))  #define amdgpu_ring_emit_reg_wait(r, d, v, m) 
> (r)->funcs->emit_reg_wait((r), (d), (v), (m))  #define 
> amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) 
> (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m)) diff 
> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 0a03e2ad5d95..7c9a5e440509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7594,21 +7594,19 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
>   	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));  }
>   
> -static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, 
> uint32_t reg)
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
>   static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, 
> uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fc6c2f2bc76c..8e7eee7838e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6383,21 +6383,19 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;  }
>   
> -static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, 
> uint32_t reg)
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
>   static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, 
> uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
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
>   	pr_err("failed to read gpu clock\n"); @@ -5482,21 +5484,19 @@ 
> static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;  }
>   
> -static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, 
> uint32_t reg)
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
>   static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, 
> uint32_t reg,
> --
> 2.17.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
