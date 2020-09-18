Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46876C43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 12:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9868422208
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 12:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gvcjj31F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9868422208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393286ECE2;
	Fri, 18 Sep 2020 12:12:36 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E951B6E150
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 12:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irt+8OACPaW8o3uEMfS18RH/yfvlPp+VbAxw7ZpR6pYuqqzCTQk5/j46plprZIXGQSiP/YTraFN1D2c0ChQjUsmtzeyunkuUeBVVV/MaHjhcuJp2mqoXNphkuev/CrWP+Rjpo8gNLZfOkJJCFOztZy+IyEHF7ojLRb+1mF8ovF/rhna97xqSqVnoEKC75K/TuaewMjqfp4eawoGU+8PxRTJyV+Yub8hWXMJ2yHARvobOhTIf4VieXJfze7iW5kCLsWuiGH6nQ3IBgLmaMc/qRc1BVayrjYtPR+N1pL2O8XX1vEAlJucx/0HeB4isrp7Q1j/zefl9Vr4C1F/OHpDB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnLcTefoxpK0qH9JOijz1HHvoU8mffsw+uBCylVu6HQ=;
 b=JqehgGTuE+Py+dLrTNzsnpgnD7303QSq0oQCJcHbIm2nrOnx3is3J55RB25q4mg5A3w8ymP+4V25fg8MdpcRnte56wsMMCX8bumpNvEQ7dUMuPZX6xC9xmWwMzYBkPon9ci1xABckwC4yJnddGLUhItex6FvunA7jXnrY0pQUEKhXoY1jfd5n4kR1R6BsyambUAjtbjPpVCFTL1/ac/T4fT5yYLN0Yja2SMPJd57raWwJEOEBoq7Zaiqfzf5C7hQEpiYw7zY0M8W3c8IlfbG8bbH56P3mBia+VxbYVDFmgTbOzsE74g2EtANZrDUCCZZhQl9lE6F8pam3I88Qz2DcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnLcTefoxpK0qH9JOijz1HHvoU8mffsw+uBCylVu6HQ=;
 b=Gvcjj31Fq2v1y2jAwu3vlxNy+F+rjcYcyfqjkmrodAm2J0s02A3A9cIPiE03BO0MiVvtfsK+IMEU10b2nF8FSiaIi7Hr4hpWloFj+9K4cj1LVgNPlfaA+W4sOR+iIMW4R0z1CAk8P0vveK8J5jKvoHpR14950uw2QdKAJOF8dU0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 12:12:29 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 12:12:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Topic: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Index: AQHWjaRkBfePj6YPJUqeZ9SBHG7j/KluTl2w
Date: Fri, 18 Sep 2020 12:12:29 +0000
Message-ID: <DM6PR12MB407563400D44EBCCABEE0765FC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200918101327.986586-1-Emily.Deng@amd.com>
In-Reply-To: <20200918101327.986586-1-Emily.Deng@amd.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-18T12:12:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0131de7d-c22e-4032-bd6d-000056f23392
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-18T12:12:25Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 36aa7941-f917-4988-a530-0000c34b833e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec939100-8409-4e62-1c2f-08d85bcc1d3e
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49570EBC13A2FA4A6B0FF466FC3F0@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YV3cg4a5cVrev2X93F6e20qIjFSuT/KMPRmopikc8B86qgzgnIR7Sve6y6UIxCzDZ04iy0fPKBgwciFHCnmlcxwVRjBtnK05OIGTfvySeoXmRphezC1LgdWif859hbeHgibj+LV3wj8inbG3sE3blzFCJB+1MHszXXqiJ9+KmGkAVqPVXXJ+jtao4sXZPLfcxZKtn/p2OwHh/EIwK1YM9xozCsI0Ol4MPLVJC8FrVbcTVVDuscWa2Vi7oVuMVHOHUuLFKHwR/wLIcLrYaw2+uhkQV+L7y7WoQxjL87UEfkYFw4o3A9W9Eq4B6/GkDQWNY68bQk3fedhPebC3Gx9KjKjJjFzXGuTJhUT6XcWPkUYeKSYkmqlxeC7XLb/UiMtvnxIKiMghFcJqvO/H3u5rXpW1Auiho43tC4IZqbog28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(5660300002)(7696005)(2906002)(8676002)(4326008)(52536014)(53546011)(6506007)(86362001)(26005)(186003)(83380400001)(110136005)(9686003)(55016002)(966005)(66946007)(66446008)(64756008)(66556008)(33656002)(76116006)(478600001)(71200400001)(316002)(8936002)(66476007)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jpAc0C7b59VHBRfI/kkspjsj0SLRU1/vxi8Roo8mftb67Shyx1TisVi6u6ep8sOu/NizhIEcGD/YxIb9MNqX6rFbgFfCkgd5iRV1oYdvMSNEVSq3t1A4PsHqTNoo8u7KcI6ZKtOYBhoHVBVO9jXDNnuOyNg7Zx8OTkNpsRv20ZCNA5xkXi/VYEfYoA3nFO7LQUQAtEG27zed1ntGGSEqwQ/6J8Ak7rxveeBJL0/ZgV7KJO4IpFbiKY2mEAO/3cCc+l7UOW3wOZkOG0ZPP+R5y42ZFlhlu9XHUrWa1j1OfwGna6992QyphBsZWJIDaZhBa8yMfG3/hJ5GVM56can5zM+2w2tsaKeRQvRWwSyPma+ttLbJaFQyEPrLaVq8+DapzpGz2bykBvuS+2aGmilnde/z35/q8svQ7O5ZK2Y647GVEpShT3uRtRxpa8X5wBNaNuVxy8V4miRcxPBPmEiLcrd3Ti65kTSpwGlo2mtrLvYWVXuPJvcJM+laLM3pYlPbHclWwfb0s//z9FA4NmWhJ6ypvh76yspJId5t15b8GIsnugs5VogXmaYUY+pxdoHlmTT+22IRMEDTxqcF+Pa2qB2Xz0Og4ifXD8mLFU6YM5WFO+ACPsvxaSWxfup3pCZwI9XhbqnyU6c2p/Y5l3gTGw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec939100-8409-4e62-1c2f-08d85bcc1d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 12:12:29.3258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0HYjbpe/PEMCXQyCxIAJBH7rq/SpjB4tb5iVzEBqoQPZNw7gc3Xx/ESwTF5IkvOkmhf14ifPg2C/xzOPvr8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Emily,

I can't find the implementation of dce_virtual_pageflip in the patch. Is it dropped by accident?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Friday, September 18, 2020 18:13
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix dead lock issue for vblank

Always start vblank timer, but only calls vblank function when vblank is enabled.

This is used to fix the dead lock issue.
When drm_crtc_vblank_off want to disable vblank, it first get event_lock, and then call hrtimer_cancel, but hrtimer_cancel want to wait timer handler function finished.
Timer handler also want to aquire event_lock in drm_handle_vblank.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I7d3cfb1202cd030fdcdec3e7483fcc4c9fa8db70
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 35 ++++++++++++------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index cc93577dee03..469c05fd43d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -47,6 +47,9 @@ static void dce_virtual_set_display_funcs(struct amdgpu_device *adev);  static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev);  static int dce_virtual_connector_encoder_init(struct amdgpu_device *adev,
 					      int index);
+static int dce_virtual_pageflip(struct amdgpu_device *adev,
+				unsigned crtc_id);
+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct 
+hrtimer *vblank_timer);
 static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 							int crtc,
 							enum amdgpu_interrupt_state state); @@ -247,6 +250,11 @@ static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_virtual_crtc_helper_funcs);
 
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires(&amdgpu_crtc->vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD);
+	amdgpu_crtc->vblank_timer.function = dce_virtual_vblank_timer_handle;
+	hrtimer_start(&amdgpu_crtc->vblank_timer,
+		      DCE_VIRTUAL_VBLANK_PERIOD, HRTIMER_MODE_REL);
 	return 0;
 }
 
@@ -476,7 +484,7 @@ static int dce_virtual_hw_fini(void *handle)
 
 	for (i = 0; i<adev->mode_info.num_crtc; i++)
 		if (adev->mode_info.crtcs[i])
-			dce_virtual_set_crtc_vblank_interrupt_state(adev, i, AMDGPU_IRQ_STATE_DISABLE);
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	return 0;
 }
@@ -698,9 +706,15 @@ static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vbla
 						       struct amdgpu_crtc, vblank_timer);
 	struct drm_device *ddev = amdgpu_crtc->base.dev;
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_irq_src *source = adev->irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
+		[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
 
-	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
-	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
+	if (amdgpu_irq_enabled(adev, source, irq_type)) {
+		drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
+		dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
+	}
 	hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
 		      HRTIMER_MODE_REL);
 
@@ -716,21 +730,6 @@ static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *ad
 		return;
 	}
 
-	if (state && !adev->mode_info.crtcs[crtc]->vsync_timer_enabled) {
-		DRM_DEBUG("Enable software vsync timer\n");
-		hrtimer_init(&adev->mode_info.crtcs[crtc]->vblank_timer,
-			     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		hrtimer_set_expires(&adev->mode_info.crtcs[crtc]->vblank_timer,
-				    DCE_VIRTUAL_VBLANK_PERIOD);
-		adev->mode_info.crtcs[crtc]->vblank_timer.function =
-			dce_virtual_vblank_timer_handle;
-		hrtimer_start(&adev->mode_info.crtcs[crtc]->vblank_timer,
-			      DCE_VIRTUAL_VBLANK_PERIOD, HRTIMER_MODE_REL);
-	} else if (!state && adev->mode_info.crtcs[crtc]->vsync_timer_enabled) {
-		DRM_DEBUG("Disable software vsync timer\n");
-		hrtimer_cancel(&adev->mode_info.crtcs[crtc]->vblank_timer);
-	}
-
 	adev->mode_info.crtcs[crtc]->vsync_timer_enabled = state;
 	DRM_DEBUG("[FM]set crtc %d vblank interrupt state %d\n", crtc, state);  }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cabf1fe6040c6488e4c2808d85bbb8623%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637360208252937744&amp;sdata=rDwqEd0k94ih31%2B%2FgfzcMW%2BJT1VxUp0Cvh3JvoTy76s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
