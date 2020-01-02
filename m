Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167FCC2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 04:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E2C215A4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 04:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eOWvFsA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E2C215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1CE899EA;
	Thu,  2 Jan 2020 04:25:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F59E899EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 04:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTT2rVofgqzNGdkm2bKHHqVK1aoNnZB3U6tzPsV3L0BlWFmASb9B/Tp48k/vsgvhUHK6LL+I0IL4AGeFxqbhfqjCa86cPhOhlXqRAd4Wn5o2o3SP5LeAZ28+FTmmg9iTu70xQMV7vGtecn6PmSEAJxA3lx2XSaIk/Vg0ZMAHs4W5bLlEK8QX8n9koFkW2hZ9/IySd1dtQNZ8QV3COyaOkWWJhJfKMPQ1pkNMw/+iqDfeV+xacDUA6aaVcaSvey7Z3MZbtEkzPtRnWPt6wxdciHlv88OU3BBke9QonzD2hxtNUr7I02xegSnEhDoQiA1+Ew42HjKvbjRU/bxotWo+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNJEGYccW1tUxp/vaf4ih+XSza+3auu/eBXsw55Ghr4=;
 b=FLpKFRV6fPRtQ2EMvA1G43NTJTcobDbVRZ2y3WrZoTjfSOTsX9V0/hHWl88CbndH0Rr+l73IGlwmvPbrVhKaNXGvPJRWznLOksveU/BEvhG9wCwU/GjtomOfp7FGRVZkaxgm7oFXolbKse8wzHbBm8Fw/xKMxro9SloUQ7PCiyrWbQvkTrcFSHfDbW+Zcx7XBFW0SjbDYIaTvffbG4qEoiRIzq8uBj3hYIQJBEH5Rr+ce08dkX++dAu++qQWQk0cjPxCwPJX6+GZxAjUfrvbIFBOeWl7PHUQMgHxK+/LwlivKgwvtAKYMBamwQiXnE8NFOlO3FOM3D+UbjQ7CYrZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNJEGYccW1tUxp/vaf4ih+XSza+3auu/eBXsw55Ghr4=;
 b=eOWvFsA/U8TTsCY/Lapj0gUEfSyGdnDcidrowcxYtuLtxTGrvrfJUonuMxsL7wA3gwW+UEXtuW+qyMahH0a8V0/tkb/DhuPrLVDu8jbTlJhjNLOWzmTWMoF3BgauEkN4mJYSbmF2pdJ0rSCbd7jfzcBHta3w7WInYft7IIrU23E=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2863.namprd12.prod.outlook.com (20.179.82.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 04:25:42 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 04:25:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
 device removal
Thread-Topic: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
 device removal
Thread-Index: AQHVu8QIqYjleLHHRkS3uiLAhdh+QqfQrv+AgAYal4A=
Date: Thu, 2 Jan 2020 04:25:41 +0000
Message-ID: <MN2PR12MB3344D3F5BF89B4256C2A6DA5E4200@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191226081041.8747-1-evan.quan@amd.com>
 <MWHPR12MB13581836D6852083025FDD34F7240@MWHPR12MB1358.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB13581836D6852083025FDD34F7240@MWHPR12MB1358.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-29T06:38:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ad5783af-14ab-4252-b282-0000f1bbbdb5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fc3489e-713b-487a-89f3-08d78f3bd448
x-ms-traffictypediagnostic: MN2PR12MB2863:|MN2PR12MB2863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB286378ACF2F18A0D8BD480F6E4200@MN2PR12MB2863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:84;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(13464003)(52536014)(2906002)(110136005)(9686003)(55016002)(316002)(19627235002)(5660300002)(71200400001)(86362001)(8936002)(8676002)(81156014)(81166006)(26005)(64756008)(478600001)(186003)(66556008)(66946007)(15650500001)(66446008)(7696005)(76116006)(33656002)(53546011)(6506007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2863;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aW4vzuhKb4hpw9zx7g5vKAvFMbRDXFiA6GAg+CNEpknn26UYjATJKYlcEyFuxbK7XhvaE5N7Nx+i7QIh12Dz7N55W9+W3H8rwYZSLmTQk2MbqaKKdPquUu8M9nBLmxWe6iIE0e6A6JVB59bKUy93gTefD64W9eKiXaSbyi6wT8xkfHDUbmSdhjxqTEGjZ3vbZ0x5m60G+7dS0rlzw0QDm/XNGMzPpl/jPGppL/KQE+deZDoEOjFn97HuD+OhaxICc7/noHC4yuNf/gY+9a4xHG4sVF6tB1l0fC65l3Nft2QqMo1mHdr2khz0aWTf3ju5gfbu/15fbe2lYf476IXP/isnY30x3pe4FyzWnLOMQsKJPEHlPNQgXCijDQQOSxB7dp7kXx4eWpcoVM5VFq5tvPYaDFvmcI3X1xnD+QXSp+g3UWcsZiIyEKh2Xn+nPx4vdBBPEVkiVa54Q/a51aY+DqNcryQHinxtY2OCj+z0yFmBkz+MS56nI+YGQbYsH0BA
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc3489e-713b-487a-89f3-08d78f3bd448
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 04:25:42.1671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hO7WI+JbpJ9tvKOP9CoZQVIHA7EenplMlTXpur65/gqfsBedPm3Ja8nv2gW2SN5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Sunday, December 29, 2019 2:43 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend
> or device removal
> 
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Quan, Evan <Evan.Quan@amd.com>
> > Sent: Thursday, December 26, 2019 3:11 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
> > device removal
> >
> > Set mp1 state properly for non gpu reset cases.
> >
> > Change-Id: I2a007910da6b5e2d1f8915d17827621ebd2e8c59
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 16 ++++++++++++++--
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 13 +++++++++++++
> >  3 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index d36245321cb0..739ff4e4e845 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1089,6 +1089,7 @@ static int amdgpu_device_check_arguments(struct
> > amdgpu_device *adev)  static void amdgpu_switcheroo_set_state(struct
> > pci_dev *pdev, enum vga_switcheroo_state state)  {
> >  	struct drm_device *dev = pci_get_drvdata(pdev);
> > +	struct amdgpu_device *adev = dev->dev_private;
> >  	int r;
> >
> >  	if (amdgpu_device_supports_boco(dev) && state ==
> > VGA_SWITCHEROO_OFF) @@ -1112,7 +1113,9 @@ static void
> > amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
> >  		pr_info("amdgpu: switched off\n");
> >  		drm_kms_helper_poll_disable(dev);
> >  		dev->switch_power_state =
> > DRM_SWITCH_POWER_CHANGING;
> > +		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
> >  		amdgpu_device_suspend(dev, true);
> > +		adev->mp1_state = PP_MP1_STATE_NONE;
> >  		pci_save_state(dev->pdev);
> >  		/* Shut down the device */
> >  		pci_disable_device(dev->pdev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 61dc26515c7e..13278f1c1b14 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1157,8 +1157,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> > static int amdgpu_pmops_suspend(struct device *dev)  {
> >  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +	struct amdgpu_device *adev = drm_dev->dev_private;
> > +	int r;
> > +
> > +	adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
> > +	r = amdgpu_device_suspend(drm_dev, true);
> > +	adev->mp1_state = PP_MP1_STATE_NONE;
> >
> > -	return amdgpu_device_suspend(drm_dev, true);
> > +	return r;
> >  }
> >
> >  static int amdgpu_pmops_resume(struct device *dev) @@ -1198,8 +1204,14
> > @@ static int amdgpu_pmops_thaw(struct device *dev)  static int
> > amdgpu_pmops_poweroff(struct device *dev)  {
> >  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +	struct amdgpu_device *adev = drm_dev->dev_private;
> > +	int r;
> > +
> > +	adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
> 
> Should this be STATE_UNLOAD for poweroff?
[Quan, Evan] "PrepareMp1ForUnload is for PnP cases, where ASIC is not reset.  If the whole ASIC is reset or need to shutdown, then we can simply use PrepareMp1ForShutdown." - a quote from a SMC firmware developer.
According to that, I think PrepareMp1ForShutdown is more proper. How do you think?
> 
> > +	r = amdgpu_device_suspend(drm_dev, true);
> > +	adev->mp1_state = PP_MP1_STATE_NONE;
> >
> > -	return amdgpu_device_suspend(drm_dev, true);
> > +	return r;
> >  }
> >
> >  static int amdgpu_pmops_restore(struct device *dev) diff --git
> > a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index d07c4f2ccee7..4a7fb6b15635 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -1370,6 +1370,18 @@ int smu_reset(struct smu_context *smu)
> >  	return ret;
> >  }
> >
> > +void smu_late_fini(void *handle)
> > +{
> > +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +	struct smu_context *smu = &adev->smu;
> > +
> > +	/*
> > +	 * Put the mp1 in the right state.
> > +	 * This gets called on driver unloading.
> > +	 */
> > +	smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown); }
> > +
> 
> Do we need something similar for the powerplay code?  E.g., pp_late_fini()?
> Also shouldn't this be adev->mp1_state or prepare for unload rather than
> hardcoding it to prepare for shutdown?
[Quan, Evan] This is specifically for the amdgpu_driver_unload_kms() use case.
For that, the call path is amdgpu_driver_unload_kms() -> amdgpu_device_fini() -> amdgpu_device_ip_fini() -> hw_fini().
And the suspend routines are not on the call path. So, the adev->mp1_state way is not workable.
Yes, I think powerplay code needs this also.
Maybe we can use prepareMp1forunload. Considering amdgpu_driver_unload_kms() may be called on runtime driver/module unloading and
the ASIC needs no power down or reset for that.
> 
> Alex
> 
> >  static int smu_suspend(void *handle)
> >  {
> >  	int ret;
> > @@ -1931,6 +1943,7 @@ const struct amd_ip_funcs smu_ip_funcs = {
> >  	.sw_fini = smu_sw_fini,
> >  	.hw_init = smu_hw_init,
> >  	.hw_fini = smu_hw_fini,
> > +	.late_fini = smu_late_fini,
> >  	.suspend = smu_suspend,
> >  	.resume = smu_resume,
> >  	.is_idle = NULL,
> > --
> > 2.24.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
