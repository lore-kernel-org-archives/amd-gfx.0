Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E7C43465
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 08:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C869621D20
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 08:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tXuevTG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C869621D20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7856F6E12B;
	Fri, 18 Sep 2020 08:20:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FAA6E12B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 08:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4wQWyE46zow2FRUoqOQLVJ+nVM8WxnJtXgxRp0GsfwuL3EW9V+eiCpVOPaMNOEZn01fuemPHHF6K/H3A2M575hpRvxogC5YgzXtK4vVB54EOjR60b1OUe7o6d8Gp0imWLre50ZkPReIvwmEcK37uiKyoYE13JgLF2ETd5z2a/1eSoDi1urDczweEYMT/IG9+R2Ok+KaBQ5rjhDQRYfbasfBrw7J13neCqKJoOyGtPDJaKr8rjBTAPXNdeMWqOUgPQvmHBYRFLpwTgaAUx7Z9hS3U/CJrYtoylxH+CCN3uBUtPEf/w8qhNbsCSVFeYWd9szz0bu+FC2mitzEU+LABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9twMM/omUZD7zKequ+f3P6dIz9LQErJZqQUxkJviLc=;
 b=iJJ4Fp2W6po8b/+kz0kzXq5WqlJrEscZvvLBV4V+GS+Pd8ut66TD8sSxDPzBzK6zyp7nxue0YZGjEF3y3GpwjQumzOsVgdZfMgh78gaCDHsyri6NvCY9Bd+e5gQGBLjjt8IreGPDsAeq+/bSshBX5NWfCzXsG5RITxOoIfHwvONvObdK2djNGn/3739Vaqh8ZFla1Ts83+PxUwSK3ZzpOYllW1zXR1/x0dJL6EZgiL0qG+ZA7MBXIBpFb0yJu/IzKtC/1PEaEyFtOF0mBvneEUsnPioDOOo89eP/DO+l3nekaOeEhTi8AsdqmZtZovKchEr7syRIsCtlfEz4/b2wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9twMM/omUZD7zKequ+f3P6dIz9LQErJZqQUxkJviLc=;
 b=tXuevTG526GGZwdhT3UUdVfPcoeTEUtjKDVciJTEhuJuVEJ+6iH/ccz1QBDMXhvXYxk43nEViqWcFnyiLMHrBo1VTK+AwKXq5Hzr5I9hR3Z3SQrUYu4cXWeEyB8lw4//IGhhhCq52YGHZSIFKxgfPXDDSTmQv/MJzXjhzGuGnCY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 08:20:16 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 08:20:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank
Thread-Index: AQHWjWum3ujm0JlefEGRNu61UVKmUaluDOnA
Date: Fri, 18 Sep 2020 08:20:16 +0000
Message-ID: <DM6PR12MB4075C89B8F981E8BB463F0CBFC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200918032717.184758-1-Emily.Deng@amd.com>
 <20200918032717.184758-2-Emily.Deng@amd.com>
In-Reply-To: <20200918032717.184758-2-Emily.Deng@amd.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-18T08:20:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 95835619-5d91-40e6-ad43-000036176714
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-18T08:20:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 93879447-23cb-4ec5-806b-0000cb3c7508
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d7714e1-6f72-45fb-2363-08d85babaca4
x-ms-traffictypediagnostic: DM5PR1201MB0122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0122E0DFD3FEB6250D3044FCFC3F0@DM5PR1201MB0122.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sttee7oarxaUcH37BHYaNO69BKdSD6W5MWbYxwymKOqKzmBbuIZi8CjsAk2UWcqnZsXaYNrATzEQOw7CLWiimXM25/YD/9KG6qyQloIuu47F0ibP/ZP8PjdH0PSLrsB2txZ7AurhP4a4caKHEmvOwT6x053zmkjLh/G/udzvIFLAPWs4qHPOEoia3vE8U5ChOre2K4LzgYzAABe0zX31V2Bn02eP8znK4YU31SbGmx+mfP1YDVqxJw8yiRCaQbRNDccxXS5K9VuqCfcBol7qP5bqPcIncOoUm6gNMacI9ZqrPY6rn8S29fzImzIhiUqIcxsX4GIG1aKz4pOqQXGxvIFmN+daXdMwMY91HS5kNiqwKGEZNBu4VKQeWnAZMAkxv3eLR9361kTTC582OwxW3k2cHNRfvMdiwVK17uVDBx0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(186003)(5660300002)(9686003)(966005)(7696005)(45080400002)(8936002)(66946007)(26005)(4326008)(316002)(86362001)(53546011)(478600001)(76116006)(6506007)(2906002)(33656002)(66446008)(52536014)(64756008)(110136005)(8676002)(83380400001)(55016002)(71200400001)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZLOTOqtc+ETcF775uW2z+oUE0nv2JfTty0KQe2bSYsK+hXW+A2QdfkUKzKS/591UV7Ogf6yub/MHmvSweUhJY6zNM8f2aJaStFW28pxhkw0Wb24/27J9BRBNtu9Q4RAIxBlzZxGOeNlBCXN6tyzarJUycxeWSgMSLWL/W7QEy3rNHHNuj4y/RDXEdc+sNelF04tqbQEMYluAqriMLOqZy9Q/e8i8SUWKwEHpXT2C6zm0GErbAn4C1Tp3C6K+8eCAZ2UuaRoiagwmK9zW30euI3uYDI1FsglMieWtyZR6pya/0jIJWZ61PyL8Mgh+1FoOnCAs+a1GSnwmuMGCpKRQFHcKKwb4SmrDGHqZExlzkP5qQ38GT74YdekOaLawUsGvtTwR2QI1ZfBMZc9SC8RgwuJTxCGH3IhN4e1D79v/Nr0SlBzhqwefKCxlhHNWxOIr9hhf8lTtY+jzpSG+zWaKDUQ3LXZVFFqe0O+Lhz7IQCh+E6pHWtzx+JzAoKkjA4Mw0bDHZMgbTZrGWYfOtNY9TfJTkP2s8g/JTikgIL0dltfPCc3Fg13sAYYvR117oQWLJ399YOchOiFrSQIA2oahzoJT+VupqjTW8h+oEmrY8PtE3VH+LO/sase9Fg37dXXzfgk8u2J425O8AEJA2Zfm4Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7714e1-6f72-45fb-2363-08d85babaca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 08:20:16.4767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvRAho/g9z1Tq2eFw7EfD/wZkMpmRVunbDVaccnt/luOCxFUVOJlldZyyAN/kaRaP22V1E6iy2J+WM7SPHyKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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

+	spin_lock_irqsave(&adev->ddev->event_lock, flags);

Are you sure you used the latest code base? I think recently we already switch to adev_to_drm(adev). 

Could you please double check?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Friday, September 18, 2020 11:27
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix dead lock issue for vblank

Always start vblank timer, but only calls vblank function when vblank is enabled.

This is used to fix the dead lock issue.
When drm_crtc_vblank_off want to disable vblank, it first get event_lock, and then call hrtimer_cancel, but hrtimer_cancel want to wait timer handler function finished.
Timer handler also want to aquire event_lock in drm_handle_vblank.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I7d3cfb1202cd030fdcdec3e7483fcc4c9fa8db70
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 155 +++++++++++------------
 1 file changed, 77 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index cc93577dee03..8c02ab74c1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -226,6 +226,74 @@ static const struct drm_crtc_helper_funcs dce_virtual_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,  };
 
+static int dce_virtual_pageflip(struct amdgpu_device *adev,
+				unsigned crtc_id)
+{
+	unsigned long flags;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_flip_work *works;
+
+	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
+
+	if (crtc_id >= adev->mode_info.num_crtc) {
+		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
+		return -EINVAL;
+	}
+
+	/* IRQ could occur when in initial stage */
+	if (amdgpu_crtc == NULL)
+		return 0;
+
+	spin_lock_irqsave(&adev->ddev->event_lock, flags);
+	works = amdgpu_crtc->pflip_works;
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
+			"AMDGPU_FLIP_SUBMITTED(%d)\n",
+			amdgpu_crtc->pflip_status,
+			AMDGPU_FLIP_SUBMITTED);
+		spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
+		return 0;
+	}
+
+	/* page flip completed. clean up */
+	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
+	amdgpu_crtc->pflip_works = NULL;
+
+	/* wakeup usersapce */
+	if (works->event)
+		drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
+
+	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
+
+	drm_crtc_vblank_put(&amdgpu_crtc->base);
+	amdgpu_bo_unref(&works->old_abo);
+	kfree(works->shared);
+	kfree(works);
+
+	return 0;
+}
+
+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct 
+hrtimer *vblank_timer) {
+	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
+						       struct amdgpu_crtc, vblank_timer);
+	struct drm_device *ddev = amdgpu_crtc->base.dev;
+	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_irq_src *source = adev->irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
+		[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
+
+	if (amdgpu_irq_enabled(adev, source, irq_type)) {
+		drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
+		dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
+	}
+	hrtimer_start(vblank_timer, ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD),
+		      HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+
 static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)  {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -247,6 +315,14 @@ static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_virtual_crtc_helper_funcs);
 
+	hrtimer_init(&amdgpu_crtc->vblank_timer,
+		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires(&amdgpu_crtc->vblank_timer,
+			    ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD));
+	amdgpu_crtc->vblank_timer.function =
+		dce_virtual_vblank_timer_handle;
+	hrtimer_start(&amdgpu_crtc->vblank_timer,
+			      ktime_set(0, DCE_VIRTUAL_VBLANK_PERIOD), HRTIMER_MODE_REL);
 	return 0;
 }
 
@@ -476,7 +552,7 @@ static int dce_virtual_hw_fini(void *handle)
 
 	for (i = 0; i<adev->mode_info.num_crtc; i++)
 		if (adev->mode_info.crtcs[i])
-			dce_virtual_set_crtc_vblank_interrupt_state(adev, i, AMDGPU_IRQ_STATE_DISABLE);
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	return 0;
 }
@@ -645,68 +721,6 @@ static void dce_virtual_set_display_funcs(struct amdgpu_device *adev)
 	adev->mode_info.funcs = &dce_virtual_display_funcs;  }
 
-static int dce_virtual_pageflip(struct amdgpu_device *adev,
-				unsigned crtc_id)
-{
-	unsigned long flags;
-	struct amdgpu_crtc *amdgpu_crtc;
-	struct amdgpu_flip_work *works;
-
-	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
-
-	if (crtc_id >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
-		return -EINVAL;
-	}
-
-	/* IRQ could occur when in initial stage */
-	if (amdgpu_crtc == NULL)
-		return 0;
-
-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-	works = amdgpu_crtc->pflip_works;
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
-		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
-			"AMDGPU_FLIP_SUBMITTED(%d)\n",
-			amdgpu_crtc->pflip_status,
-			AMDGPU_FLIP_SUBMITTED);
-		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-		return 0;
-	}
-
-	/* page flip completed. clean up */
-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
-	amdgpu_crtc->pflip_works = NULL;
-
-	/* wakeup usersapce */
-	if (works->event)
-		drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
-
-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-
-	drm_crtc_vblank_put(&amdgpu_crtc->base);
-	amdgpu_bo_unref(&works->old_abo);
-	kfree(works->shared);
-	kfree(works);
-
-	return 0;
-}
-
-static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vblank_timer) -{
-	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
-						       struct amdgpu_crtc, vblank_timer);
-	struct drm_device *ddev = amdgpu_crtc->base.dev;
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-
-	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
-	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
-	hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
-		      HRTIMER_MODE_REL);
-
-	return HRTIMER_NORESTART;
-}
-
 static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 							int crtc,
 							enum amdgpu_interrupt_state state) @@ -716,21 +730,6 @@ static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *ad
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C4aa2942fb0bd4a25c66a08d85b82c813%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637359964549266369&amp;sdata=1ohOBjPciizMDNdCYnMUj9e160K%2FQyKzpgmmEYhCIOM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
