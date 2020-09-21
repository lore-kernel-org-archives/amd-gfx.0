Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3015C43465
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 01:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113ED207EA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 01:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Eu/hXYft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113ED207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E5B6E104;
	Mon, 21 Sep 2020 01:14:34 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680079.outbound.protection.outlook.com [40.107.68.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21F76E104
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 01:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMu36PjyPMXL9wRLY0RCKJv3DvHFuJqI5maMM2IycMk1R8RoHqQV9gnqFyBy6F8Bc47x/cwcRE0sPJUspDgt7epN2YI5AeS1dMDrxyGNcnQ8zt547Xwc6G00CnSAafG8D15VDNNl0sMygYuVF0Ez0x6MxHmow88vFKHXVcmYS0MUGFVxAzl/+fJe8EN5oaoTG+e8BccFIwqC3onHgaVbIFeYazcKoEatUSLVCsqjO6zmfEoRioMR62b+V/lkQv50bCMh0EABRiN3MMk3ENvPWW9LYiz9qnZVk+oUGgPt03aQGDHHM9k0YxwSb8CPx3Lp3qoZohM2jJbBB7ldJPHBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdSY9/VsnwtIXrKczit/09KMgscQAHWczJYAwyiUM+A=;
 b=HF/uyezE+BTseTAOJHUM7v73E7bE9odhoDU6CJy/WSBtp/SxtAynwDQvDT89b1pNDi0AvTu4rr8p7uBDubxuVx8rMnBQy7nh8F8nuAaAzQw03tAI0Da6W8R8xB/t86mdAj79MWEXAYmIFG+R2HZX4A3wY8Huduol6HbeynawIEOVSSH+1MqTyAZDLANeNsHH869wDX6MBZKFUyTQAoYxtwT94wc9i7qmIBvo4dqwTBXNCl6ofT4u7P9sKrpiNGyN6/6NEpNjgfnR5zqRJkUP66a0jfpk1WZ731n7HeZCYXp+bKHIGlBYGYbbzdAeAu8N9hUF6CNgDohjaBcl0QM4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdSY9/VsnwtIXrKczit/09KMgscQAHWczJYAwyiUM+A=;
 b=Eu/hXYft7Dpq0aQT/gJFzJpf5IGGR0lO+iAcSAzz3GvCmPHeuCp00SqbVzkaHkqeKukkrPbgru04CgGiz5LKos67kcSToUS67+/zT+JXh/ysF6epILnOlbcqQlJu4YtFvoM1X+sfJdaqUAYZO+PubAzJhzg7xVEc9q4bMZiNa3k=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 01:14:29 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 01:14:29 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Topic: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Index: AQHWjaRgMi9HPk/1B0yQmSlhyMYKZKluTqyAgAP+xZA=
Date: Mon, 21 Sep 2020 01:14:28 +0000
Message-ID: <BY5PR12MB4115E633E7FB3F3EB74DFA5E8F3A0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200918101327.986586-1-Emily.Deng@amd.com>
 <DM6PR12MB407563400D44EBCCABEE0765FC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407563400D44EBCCABEE0765FC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-18T12:12:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6489ba66-06fd-45ce-88e6-0000087344af;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38533376-3adb-49cf-f050-08d85dcbb050
x-ms-traffictypediagnostic: BYAPR12MB3333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3333CC37CCA792CB375DA5508F3A0@BYAPR12MB3333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvKOisogqqO62wd7IdB0NI8tkC7jIHeAmVlm5+8182/FAbfdBQPe1qg3XlRFPMy/6zIh2OF6PzfqfttFQjLs9ZYuyfDoiJFeGgYD6FAGO1XVPoyIolwMBLCm07KqqizqoZZPKvwYOK3RdEIMAQer2IdGhbz2itkCB0yQtCJ8CmFIQPDh/pwN9xvaEd/dtqM3/BRKBLoGLTOms3Howe/R8Ow+OYBBQknedYFV4z6UZYuZU/vxB2PcguzwoFh6lHRb0EQpGHCeyem6h+H1VxTMIz0JEiBDUUbUJQRqCnLISvXA6hEchvjfDeQ1pi7AafcmJTOq9srb5Kx16smjtJD1Kt9qtPfhCwplBwEjkZHhdV//JJgbzmKXM8vssvDPDZ7fSt1NwPhGzBXFbCSqU0wEEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(5660300002)(186003)(66946007)(76116006)(83080400001)(7696005)(9686003)(45080400002)(33656002)(6506007)(86362001)(478600001)(26005)(2906002)(316002)(71200400001)(52536014)(8676002)(110136005)(83380400001)(55016002)(8936002)(64756008)(66556008)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: j8bhHdMShGTE7If/AAZWQzvYN/0e3gJcgR2g51fM+L3OsBjY6Y3gZ+EOWkPmsvRTp2GQe5BdWhEyUVT9+2U1Z2MRv6zO4FnKBtkC82HTxtE1BBS0SNqVhHxZWNcynFwCjP5j7z/GMkpxgh9SoRbjndd5/JL/f0Wc19xq0EoVmVb/1Vzs9uaGBN2aPIHsfnPZFPDSxLrElGjCNp8vRTsVo5Kswl7r7G+aNWNtUPe/bswIrwJ+grFiqhRD7ujmoI0ooHPuht7QRe5DCWLMSwQ8zeuKQH6fGJB1al0j0iPhcObrYUbhGtNZtSKBPHmsKBsWm+b7QNzjzrQoWY60pI315fTBNO1qhJua8d+5bFRViFrrSNhroWEs+Wx8GsbY+DZaKdULhp98HM3fxnMYJpTHMZm3FwTEN+DRs1iHd1XmYf4udc5B+sqx+LFBa89HbkXkPpVG7Fd1vuJJWWxrVMhHOWv4ZR+LOw50vBJ8M6w/xSlMsa8iUCD/+HgwHyNUbFBIsY9b+wM+/TWCSq78JNpi0Lfl6tqv3/ll/jUldJDGy54nNCIrZAQNJdkh0sagMgcEpmCAgEmAT+gdUAXNmet74q5TM0Ulo59xrT0xBXiCrMAGrWW0vX2Lkekqzh3Vvxw5/FSzjfYdj+3WTSFNHcd/2g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38533376-3adb-49cf-f050-08d85dcbb050
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 01:14:28.8692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/n3MdDwYH8440NlY2/v50t6Vd3MXlaphdH6IGZv0M7cMV53n5gs1XfG6txdaL53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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

Hi Hawking,
    It already exit in the original file, for before patch, I move it to another place, for this V2 patch, I just use:
static int dce_virtual_pageflip(struct amdgpu_device *adev,
>+				unsigned crtc_id);


>-----Original Message-----
>From: Zhang, Hawking <Hawking.Zhang@amd.com>
>Sent: Friday, September 18, 2020 8:12 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
>
>[AMD Public Use]
>
>Hi Emily,
>
>I can't find the implementation of dce_virtual_pageflip in the patch. Is it
>dropped by accident?
>
>Regards,
>Hawking
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Emily.Deng
>Sent: Friday, September 18, 2020 18:13
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
>
>Always start vblank timer, but only calls vblank function when vblank is enabled.
>
>This is used to fix the dead lock issue.
>When drm_crtc_vblank_off want to disable vblank, it first get event_lock, and
>then call hrtimer_cancel, but hrtimer_cancel want to wait timer handler
>function finished.
>Timer handler also want to aquire event_lock in drm_handle_vblank.
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>Change-Id: I7d3cfb1202cd030fdcdec3e7483fcc4c9fa8db70
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 35 ++++++++++++------------
> 1 file changed, 17 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index cc93577dee03..469c05fd43d5 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -47,6 +47,9 @@ static void dce_virtual_set_display_funcs(struct
>amdgpu_device *adev);  static void dce_virtual_set_irq_funcs(struct
>amdgpu_device *adev);  static int dce_virtual_connector_encoder_init(struct
>amdgpu_device *adev,
> 					      int index);
>+static int dce_virtual_pageflip(struct amdgpu_device *adev,
>+				unsigned crtc_id);
>+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct
>+hrtimer *vblank_timer);
> static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device
>*adev,
> 							int crtc,
> 							enum
>amdgpu_interrupt_state state); @@ -247,6 +250,11 @@ static int
>dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
> 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
> 	drm_crtc_helper_add(&amdgpu_crtc->base,
>&dce_virtual_crtc_helper_funcs);
>
>+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC,
>HRTIMER_MODE_REL);
>+	hrtimer_set_expires(&amdgpu_crtc->vblank_timer,
>DCE_VIRTUAL_VBLANK_PERIOD);
>+	amdgpu_crtc->vblank_timer.function =
>dce_virtual_vblank_timer_handle;
>+	hrtimer_start(&amdgpu_crtc->vblank_timer,
>+		      DCE_VIRTUAL_VBLANK_PERIOD, HRTIMER_MODE_REL);
> 	return 0;
> }
>
>@@ -476,7 +484,7 @@ static int dce_virtual_hw_fini(void *handle)
>
> 	for (i = 0; i<adev->mode_info.num_crtc; i++)
> 		if (adev->mode_info.crtcs[i])
>-			dce_virtual_set_crtc_vblank_interrupt_state(adev, i,
>AMDGPU_IRQ_STATE_DISABLE);
>+			hrtimer_cancel(&adev->mode_info.crtcs[i]-
>>vblank_timer);
>
> 	return 0;
> }
>@@ -698,9 +706,15 @@ static enum hrtimer_restart
>dce_virtual_vblank_timer_handle(struct hrtimer *vbla
> 						       struct amdgpu_crtc,
>vblank_timer);
> 	struct drm_device *ddev = amdgpu_crtc->base.dev;
> 	struct amdgpu_device *adev = drm_to_adev(ddev);
>+	struct amdgpu_irq_src *source = adev-
>>irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
>+		[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
>+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>+						amdgpu_crtc->crtc_id);
>
>-	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
>-	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
>+	if (amdgpu_irq_enabled(adev, source, irq_type)) {
>+		drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
>+		dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
>+	}
> 	hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
> 		      HRTIMER_MODE_REL);
>
>@@ -716,21 +730,6 @@ static void
>dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *ad
> 		return;
> 	}
>
>-	if (state && !adev->mode_info.crtcs[crtc]->vsync_timer_enabled) {
>-		DRM_DEBUG("Enable software vsync timer\n");
>-		hrtimer_init(&adev->mode_info.crtcs[crtc]->vblank_timer,
>-			     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>-		hrtimer_set_expires(&adev->mode_info.crtcs[crtc]-
>>vblank_timer,
>-				    DCE_VIRTUAL_VBLANK_PERIOD);
>-		adev->mode_info.crtcs[crtc]->vblank_timer.function =
>-			dce_virtual_vblank_timer_handle;
>-		hrtimer_start(&adev->mode_info.crtcs[crtc]->vblank_timer,
>-			      DCE_VIRTUAL_VBLANK_PERIOD,
>HRTIMER_MODE_REL);
>-	} else if (!state && adev->mode_info.crtcs[crtc]->vsync_timer_enabled)
>{
>-		DRM_DEBUG("Disable software vsync timer\n");
>-		hrtimer_cancel(&adev->mode_info.crtcs[crtc]->vblank_timer);
>-	}
>-
> 	adev->mode_info.crtcs[crtc]->vsync_timer_enabled = state;
> 	DRM_DEBUG("[FM]set crtc %d vblank interrupt state %d\n", crtc,
>state);  }
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cabf1fe6040c6488
>e4c2808d85bbb8623%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
>%7C637360208252937744&amp;sdata=rDwqEd0k94ih31%2B%2FgfzcMW%2B
>JT1VxUp0Cvh3JvoTy76s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
