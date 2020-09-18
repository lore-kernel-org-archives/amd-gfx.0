Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC73C43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 08:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AB420872
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 08:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="35phC4DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AB420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E276E123;
	Fri, 18 Sep 2020 08:29:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF6E6E123
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 08:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXU815gnQGEKtLOvBAUcHVTJWg2a+hz2Ick0qrcHZbBivG3GelZIggVTrzSNw8R682w0o/Zug2SalfyRo3SAG9X4CETH9jfIVqMQ6BOoVcQaGSFHMZR7jwyVjn7NQm4wxkCEkLjccifK6WN9Fc1Ijv9OXxDoyrXggm99kmUgIV93Op9RiUMCEvfJ9S/Q2TCnEZrVLHkE7iQHrt4Jx0PQvvFdmvRiHHKODd+XGZ5CfhLcu+gU+SkZLRrvkP/giLYIl9+0EcGe63zBiaB/dgU4vNp6zPQaBYp8RwESYaPseZeATj2lEd7k+q8wX6N+GChItoa0WiQBTS0W2DvwWHEIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBb1uE1aHpnzduynKx/MlXuROLbQwOmpn+svM/9Wbec=;
 b=cL9yE6pxhZRuXCopv/JlniYm2vFJHewYI2cmyupuGugkpbAUsE3SdTFqumLNlazHSwXwHfTkhO7186d5o5noqn4f/jSpHvRf8lBfm+uRbOjqIE7X9cLQl/GlppcL6ClxNGgrqGWzuzD57sYwnTgovXg2EDUtXcu/0vMy5rfLbXa3ULWnWMUwXFUB/KE6JPl5tGGGDWHfABdBhkVmCxFDjqvRtZxHe9u/Xu9F1BbVNKm+SboCuF3JPD0pwZRz2LZW6+xIx8gXrBLrJWXPwKf87EUR03dds2DO0uXu7L9NeG/ajAqSEjxw6yxDd0t0H7zeOqniLwLUTAnaCeatQk9Kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBb1uE1aHpnzduynKx/MlXuROLbQwOmpn+svM/9Wbec=;
 b=35phC4DAk6rgsaTvOMxAke+mMECS0VBFtkv0/QMW/bAmsMDuYAdS8hnfs1jgzKd77eeOwVb7DjqqTujavL8JNuXxFSYqvp73G8SVB9d/3aRfoux2gwq+ZjwDVnxFggOFINwpTYkeocK7LajbzhqiwDZcof8UhseDpJHJ2M+74pw=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2789.namprd12.prod.outlook.com (2603:10b6:a03:72::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 08:29:30 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 08:29:30 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
Thread-Index: AQHWjWumxPvLTX4BYUC0KjCQB7XsXKluDjwAgAACdVA=
Date: Fri, 18 Sep 2020 08:29:30 +0000
Message-ID: <BY5PR12MB41152670E59BB7CD2CAE52F88F3F0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200918032717.184758-1-Emily.Deng@amd.com>
 <20200918032717.184758-2-Emily.Deng@amd.com>
 <DM6PR12MB4075C89B8F981E8BB463F0CBFC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075C89B8F981E8BB463F0CBFC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-18T08:20:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=061adb61-9a2b-4f1c-8b0c-0000e5abbde6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7530c5f0-2a27-4cd6-a76e-08d85bacf691
x-ms-traffictypediagnostic: BYAPR12MB2789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2789D8BA986F7BF895C1FC588F3F0@BYAPR12MB2789.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uqHzsJuxEf9AC8FS7JzNPxg34WdFGgU09M+eSMYfqp10qQiwGzjt6XhKSTQT3NAbOtu+5+3O5JdR/vmoLyHFIb2P+3jpzNbIOAqEn5ci4T+8dMVNIBF9Fxooju2QJ0Ya43nklYyOBtoP5F2nMcGWS+ek8kuKCBR3179fZMLT1Z+t76CSob4EvQ+OO/WYlMeRy1ujXNwiEXvGC/jfabUCzvEO1BMeYjB9C+mETpGrgq0rlhzCdl3VtiugtxfuIxKO11yUWNr2OKWlHM/gbxBP0kyA0eG3oPOTcH5QP4/9PDp4mwBghx5Pz2sYEKwghL+UcLtYzT+MtbfiivelIY+gVCf4xT9xjprpG6GijvC70pXWHseTA3HYUWj019SOO6zWYkmvI9mBzvov5VkJH+Q3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(186003)(26005)(83080400001)(8936002)(45080400002)(83380400001)(2906002)(8676002)(66556008)(7696005)(478600001)(64756008)(66476007)(66446008)(66946007)(55016002)(76116006)(6506007)(52536014)(5660300002)(71200400001)(9686003)(316002)(33656002)(86362001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: g56wHgx84JMhVQvIBrPxpYkYoOSpRfgSbNG+Reh3u0OBtLa2+1/tJmlRYpyeoAHUPQIzkW58PkHQtziRDGRGeRJ8+JQ5Ig26WE1r0FPBoeC98vz1RULlPp4HE4HjEygKn6ZpHX7K8QqcnkWiFXnAIr1KTdfoVXMPy32Jq8VS39AHeDhxKUu9yP1A+mOpg/OGDcSAdTAfvGgPgYIW94LSR/GSyXM+WH+jpxEwQFz5HIUrguvKZXV/ylQH66dk4drhUTlKUWwmsiLQjVZBcO4B8Pren+bqQ9rkjyjVG5TLlRuKhMTpcLW/WyMJoL62EaX4sT3xxTHni52jBqt9M6Rs0zACssMouMgmVfyUdPTctVEaWTSocalOnkZTm/kTFhn/arIWvFpAvMph2KBoKzL2PxL0+6HrEtBG4NQYOM9fU3js+d7Pmqrv6FvWY0tCDlajF8JvLV9uSYZXSDsTAG21ob6ShZSV7MT+6sE42DbE5MWRePFt4NIyZ7OTkf1rlH/YdqO2RG7SNmFUJqIaU48d0nly2Q5th8ZC4NLjRfDWnLUdE1//RfADYuArlBk5ha/4NVLotUQRu1kJAK+4ul8LYKUpkBvfb8BlGWvqvIJrUSzWppzhQuujRiVXvIHBPJPeMp2QHkLl0f6JuGleUHNmxQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7530c5f0-2a27-4cd6-a76e-08d85bacf691
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 08:29:30.0635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thHugQGV/YB7DFOenWvh3Fn7L4QMIRH07NhtRFA6l52LzEuY8TbpmKQV5a7xZGyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2789
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

Thanks, will double check.

Best wishes
Emily Deng



>-----Original Message-----
>From: Zhang, Hawking <Hawking.Zhang@amd.com>
>Sent: Friday, September 18, 2020 4:20 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
>
>[AMD Public Use]
>
>+	spin_lock_irqsave(&adev->ddev->event_lock, flags);
>
>Are you sure you used the latest code base? I think recently we already switch
>to adev_to_drm(adev).
>
>Could you please double check?
>
>Regards,
>Hawking
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Emily.Deng
>Sent: Friday, September 18, 2020 11:27
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
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
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 155 +++++++++++------------
> 1 file changed, 77 insertions(+), 78 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index cc93577dee03..8c02ab74c1de 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -226,6 +226,74 @@ static const struct drm_crtc_helper_funcs
>dce_virtual_crtc_helper_funcs = {
> 	.get_scanout_position = amdgpu_crtc_get_scanout_position,  };
>
>+static int dce_virtual_pageflip(struct amdgpu_device *adev,
>+				unsigned crtc_id)
>+{
>+	unsigned long flags;
>+	struct amdgpu_crtc *amdgpu_crtc;
>+	struct amdgpu_flip_work *works;
>+
>+	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
>+
>+	if (crtc_id >= adev->mode_info.num_crtc) {
>+		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
>+		return -EINVAL;
>+	}
>+
>+	/* IRQ could occur when in initial stage */
>+	if (amdgpu_crtc == NULL)
>+		return 0;
>+
>+	spin_lock_irqsave(&adev->ddev->event_lock, flags);
>+	works = amdgpu_crtc->pflip_works;
>+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
>+		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>+			"AMDGPU_FLIP_SUBMITTED(%d)\n",
>+			amdgpu_crtc->pflip_status,
>+			AMDGPU_FLIP_SUBMITTED);
>+		spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
>+		return 0;
>+	}
>+
>+	/* page flip completed. clean up */
>+	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
>+	amdgpu_crtc->pflip_works = NULL;
>+
>+	/* wakeup usersapce */
>+	if (works->event)
>+		drm_crtc_send_vblank_event(&amdgpu_crtc->base, works-
>>event);
>+
>+	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
>+
>+	drm_crtc_vblank_put(&amdgpu_crtc->base);
>+	amdgpu_bo_unref(&works->old_abo);
>+	kfree(works->shared);
>+	kfree(works);
>+
>+	return 0;
>+}
>+
>+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct
>+hrtimer *vblank_timer) {
>+	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
>+						       struct amdgpu_crtc,
>vblank_timer);
>+	struct drm_device *ddev = amdgpu_crtc->base.dev;
>+	struct amdgpu_device *adev = ddev->dev_private;
>+	struct amdgpu_irq_src *source = adev-
>>irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
>+		[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
>+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>+						amdgpu_crtc->crtc_id);
>+
>+	if (amdgpu_irq_enabled(adev, source, irq_type)) {
>+		drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
>+		dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
>+	}
>+	hrtimer_start(vblank_timer, ktime_set(0,
>DCE_VIRTUAL_VBLANK_PERIOD),
>+		      HRTIMER_MODE_REL);
>+
>+	return HRTIMER_NORESTART;
>+}
>+
> static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)  {
> 	struct amdgpu_crtc *amdgpu_crtc;
>@@ -247,6 +315,14 @@ static int dce_virtual_crtc_init(struct amdgpu_device
>*adev, int index)
> 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
> 	drm_crtc_helper_add(&amdgpu_crtc->base,
>&dce_virtual_crtc_helper_funcs);
>
>+	hrtimer_init(&amdgpu_crtc->vblank_timer,
>+		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>+	hrtimer_set_expires(&amdgpu_crtc->vblank_timer,
>+			    ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD));
>+	amdgpu_crtc->vblank_timer.function =
>+		dce_virtual_vblank_timer_handle;
>+	hrtimer_start(&amdgpu_crtc->vblank_timer,
>+			      ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD),
>HRTIMER_MODE_REL);
> 	return 0;
> }
>
>@@ -476,7 +552,7 @@ static int dce_virtual_hw_fini(void *handle)
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
>@@ -645,68 +721,6 @@ static void dce_virtual_set_display_funcs(struct
>amdgpu_device *adev)
> 	adev->mode_info.funcs = &dce_virtual_display_funcs;  }
>
>-static int dce_virtual_pageflip(struct amdgpu_device *adev,
>-				unsigned crtc_id)
>-{
>-	unsigned long flags;
>-	struct amdgpu_crtc *amdgpu_crtc;
>-	struct amdgpu_flip_work *works;
>-
>-	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
>-
>-	if (crtc_id >= adev->mode_info.num_crtc) {
>-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
>-		return -EINVAL;
>-	}
>-
>-	/* IRQ could occur when in initial stage */
>-	if (amdgpu_crtc == NULL)
>-		return 0;
>-
>-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>-	works = amdgpu_crtc->pflip_works;
>-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
>-		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>-			"AMDGPU_FLIP_SUBMITTED(%d)\n",
>-			amdgpu_crtc->pflip_status,
>-			AMDGPU_FLIP_SUBMITTED);
>-		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock,
>flags);
>-		return 0;
>-	}
>-
>-	/* page flip completed. clean up */
>-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
>-	amdgpu_crtc->pflip_works = NULL;
>-
>-	/* wakeup usersapce */
>-	if (works->event)
>-		drm_crtc_send_vblank_event(&amdgpu_crtc->base, works-
>>event);
>-
>-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>-
>-	drm_crtc_vblank_put(&amdgpu_crtc->base);
>-	amdgpu_bo_unref(&works->old_abo);
>-	kfree(works->shared);
>-	kfree(works);
>-
>-	return 0;
>-}
>-
>-static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer
>*vblank_timer) -{
>-	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
>-						       struct amdgpu_crtc,
>vblank_timer);
>-	struct drm_device *ddev = amdgpu_crtc->base.dev;
>-	struct amdgpu_device *adev = drm_to_adev(ddev);
>-
>-	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
>-	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
>-	hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
>-		      HRTIMER_MODE_REL);
>-
>-	return HRTIMER_NORESTART;
>-}
>-
> static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device
>*adev,
> 							int crtc,
> 							enum
>amdgpu_interrupt_state state) @@ -716,21 +730,6 @@ static void
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
>gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C4aa2942fb0bd4a
>25c66a08d85b82c813%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
>%7C637359964549266369&amp;sdata=1ohOBjPciizMDNdCYnMUj9e160K%2F
>QyKzpgmmEYhCIOM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
