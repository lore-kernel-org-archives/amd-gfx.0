Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB13C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72018222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VgpRfWP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72018222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DBF6E0A8;
	Thu, 19 Dec 2019 02:12:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690067.outbound.protection.outlook.com [40.107.69.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5166E0A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 02:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZEfEdT3SDganJttafeR/UCN2rDUa60uPo41qWYQ/xRXpLn5AFQ/mGBAPbexFgyaf/4BWL8Qy7MIk1/2msxsRJ/rbUKTZ/vgCeJ/Yo4lHvMbzfFleBq6WUa3+HTdtnZBLFygYoeztGmsYDQEUELt4RuYWEVX7auXRDMoptqRDjPZfx9fKu9fS1grPMyY8reIeHq04Eb4ALuw52B9udTmn3TDkBb5xrc6cBG4fxAqA7XWgjrB6wPWPEDTibpmLP03HeCpM9sKxM2QW14U2AQWwV8EVdvncebszYWPrYRzhHQVmOX7cXhhW0dIRd4mCon1Bp6oJfVJHAI9sy3QhYPMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icnHQrS2RQzVvsL9Dp82ZKFv7FVQLbU2n5yqZcZDSQg=;
 b=IfQ7L37wvnSM9h8Ni0j+FP2kqfm584jrjO6xBmqv9DFOF/qGDgI81kf3acvBI/gIDJEY8nmpd7BE/tYEx7CBwk0/fKfVRM6a2TQsqNVGKKbRL5rC799GvtcDYYYjSatH1h2KPHvRIGaNjpcDY7idsnDNvvD0LIRLypsdFY0CS2vbqTIUvPbtFrz0E5UnD8Xhijud7OQPypFSd1plPI2iR+TdyfE/MecZJKmbs9SY8IE7gj8pQ0oUMXteToSGMSAggaFCgs6cxv8/SXfJXyL0Rkew86Td5bdVC1iPCxICYcupLGibfAD7yUoS9ZuY8lFQRplQ5s7AcEYEiV6Ya/ebQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icnHQrS2RQzVvsL9Dp82ZKFv7FVQLbU2n5yqZcZDSQg=;
 b=VgpRfWP/gf41PdzaahzGTu4UtJZH1u8Dc0/9OoCnQRzvzfIBKsg5OdEtelr6P7d6X4KF3KkffYle8Aeu9I1mqLKLQZ/PDq5lLjCUf4pCJ0k2Ey1xg3VLZqA0ppu+b3GClJu9jgV+kpPaZ02wtj4cGwT9iwI9+0VmDQdPX7pqaqA=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3165.namprd12.prod.outlook.com (20.179.81.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 02:12:18 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 02:12:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS baco
 reset
Thread-Topic: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS baco
 reset
Thread-Index: AQHVtVLHSon+kVYPDkCLEnIMRVSdzKe/+9WAgAC3A3A=
Date: Thu, 19 Dec 2019 02:12:18 +0000
Message-ID: <MN2PR12MB33440E09FC04B87E06695B6CE4520@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191218032457.28424-1-evan.quan@amd.com>
 <CADnq5_PXP-TTS46rw6HcxPo8ZM_2djf9Ct12dyBQ9sMs7Cxv3g@mail.gmail.com>
In-Reply-To: <CADnq5_PXP-TTS46rw6HcxPo8ZM_2djf9Ct12dyBQ9sMs7Cxv3g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5ce7f6f7-ceda-47bf-9baa-0000f31e3d06;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T01:50:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b8f1978-ff6f-4b91-8fbc-08d78428dfb4
x-ms-traffictypediagnostic: MN2PR12MB3165:
x-microsoft-antispam-prvs: <MN2PR12MB3165B15BAA865ABC33259F88E4520@MN2PR12MB3165.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(13464003)(7696005)(45080400002)(71200400001)(76116006)(64756008)(53546011)(6506007)(9686003)(52536014)(55016002)(8676002)(81156014)(86362001)(2906002)(4326008)(966005)(81166006)(8936002)(26005)(6916009)(186003)(33656002)(316002)(478600001)(66946007)(66556008)(66476007)(5660300002)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3165;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lLtLpWLsntLnGw/hq5W/gja0/YtbGNYf445DD/OHpwaV1Ed0nkHKWIV+W++IqwUKzZSb9UL/KYXU91Nzk+VRGPUc1hT80CEG/9Pik+t6nyMtAO6QYFgkO8qjFpiLdi2JzGwpeWeQAFgV05yMTVqI+nUshgzr4kLaUPpU/v3Nb396XKHGitrmku6BC/Oh2tS3S/1/srIbVqNBsYQKz5Y1Aa04g3oaa+tDgnJ/G8dCDLuz27HCM8pWzI/5PNbjrk54jOXcXFj7VIcUdlVRp8osTDgYizpG3EZNGaXqy5a4NNAsAoIVAQklLIvhq/jxf1qXyDBDoRM2BRdA9cAAPEjKi9rCYDptdF9jd1PxXyQPQhX2/HRHA32JozBoKptK/V1Yec1k0DUAR0L1xZaqDFmpF5UcjHnowcE7+aPZGBxepVpOGI6UqhsnqCgrdQ0uUUonlt5G09azBvAfFe5jVREA6Uu62ecS3SYLSFd7xFKj79RzMvKlu5ISfHbO1MCZB2i
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f1978-ff6f-4b91-8fbc-08d78428dfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 02:12:18.1386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fdrfWTbpvzUW64MFIkLFDLrEVc4gO+ddGgGv+RCtA0Wy+xMz15kyeb4ZFKo/YuQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

"Power saving" means the regular suspend/resume case, right? That was considered. 
With current amdgpu code, the MP1 state was not correctly set for the regular suspend case. 
More straightforwardly I believe PrepareMP1_for_unload should be issued to MP1 on regular suspend path(excluding gpu reset case).

And with the MP1 state correctly set for all case, we can remove the "adev->in_gpu_reset".
But for now, I do not want to involve too many changes and limit this to the gpu reset case.

P.S. the mp1 state was correctly handled for mode1 reset. So, it's safe to enforce this for all gpu reset case instead of baco reset only. 

Regards,
Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, December 18, 2019 10:56 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS
> baco reset
> 
> On Tue, Dec 17, 2019 at 10:25 PM Evan Quan <evan.quan@amd.com> wrote:
> >
> > For non-RAS baco reset, there is no need to reset the SMC. Thus the
> > firmware reloading should be avoided.
> >
> > Change-Id: I73f6284541d0ca0e82761380a27e32484fb0061c
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  3 ++-
> > drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index c14f2ccd0677..9bf7e92394f5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -1439,7 +1439,8 @@ static int psp_np_fw_load(struct psp_context *psp)
> >                         continue;
> >
> >                 if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
> > -                   (psp_smu_reload_quirk(psp) || psp->autoload_supported))
> > +                   ((adev->in_gpu_reset && psp_smu_reload_quirk(psp))
> > +                     || psp->autoload_supported))
> 
> Will this cover the power saving case as well?  Do we need to check
> adev->in_gpu_reset as well or can we drop that part?
> 
> Alex
> 
> >                         continue;
> >
> >                 if (amdgpu_sriov_vf(adev) && diff --git
> > a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > index c66ca8cc2ebd..ba761e9366e3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > @@ -676,6 +676,19 @@ static bool psp_v11_0_compare_sram_data(struct
> psp_context *psp,
> >         return true;
> >  }
> >
> > +/*
> > + * Check whether SMU is still alive. If that's true
> > + * (e.g. for non-RAS baco reset), we need to skip SMC firmware reloading.
> > + */
> > +static bool psp_v11_0_smu_reload_quirk(struct psp_context *psp) {
> > +       struct amdgpu_device *adev = psp->adev;
> > +       uint32_t reg;
> > +
> > +       reg = RREG32_PCIE(smnMP1_FIRMWARE_FLAGS | 0x03b00000);
> > +       return (reg &
> MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ?
> > +true : false; }
> > +
> >  static int psp_v11_0_mode1_reset(struct psp_context *psp)  {
> >         int ret;
> > @@ -1070,6 +1083,7 @@ static const struct psp_funcs psp_v11_0_funcs = {
> >         .ring_stop = psp_v11_0_ring_stop,
> >         .ring_destroy = psp_v11_0_ring_destroy,
> >         .compare_sram_data = psp_v11_0_compare_sram_data,
> > +       .smu_reload_quirk = psp_v11_0_smu_reload_quirk,
> >         .mode1_reset = psp_v11_0_mode1_reset,
> >         .xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
> >         .xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
> > --
> > 2.24.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cev
> >
> an.quan%40amd.com%7C8781ad2ef92d4a188c3008d783ca6846%7C3dd8961fe
> 4884e6
> >
> 08e11a82d994e183d%7C0%7C0%7C637122777663939524&amp;sdata=DMLV%
> 2Bz%2FsG
> > nXhpsiOdv9EZrsBcn6HGJ3L7lKdKL2PaPQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
