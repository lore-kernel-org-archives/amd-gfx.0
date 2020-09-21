Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6676BC43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97EA2078E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UujvSQyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97EA2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBDF89B62;
	Mon, 21 Sep 2020 02:46:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995458918A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 02:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6kU00ytgDd3+9sSmiFi63k0A1i8ovKeZzBh6qzljv5Eq5djX1EF+gbpxOQYOPkyTezTcIsBtHDPSsPcH38qFlCADHBVXhAQYhj4O/ybRPBRyShNncHQUQDJAU9ziaWcpZrqFqninwngYlloW3diAViK92mpXiRc9ZBr9r5/Aq9iX4joe4xGTha0EfkZyf38b7blrMxDnq8M8Hvtbmo7Qd1HM/IsqbLOpIhPuwubSJSL7nJdRbCdFaiz1gAx1tDoFzFxJWY+p1xTcCOZwKEgf2YVZFJ1lMBkzUQbSrP6jQ+3ng5evTYJ/CHy2F+7+Z8pqh+ABH7GB0SnZMELzC+QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew2w6zMRLyIwRRhZ1lnDf5xsL5Vi1trK6VXcYjHeUJc=;
 b=DAIQIVAA244wNjNx1nT28TDBSeOxKUd/xVRI5LQ0r/s+Qsk2K9oy0zKrs9Bh4dsvC3LpsqoBPMPC6TLaMdtfR2+izjntFXsGvgJWOGW0CRO8qp3Gztl3aP3uFHYJMT/txbuHjxL3MiMKKQsZtZE1rC82jOJ8SS2mHnmJ0CsOMFTf+nfoIC8C9OLCzs4lJGok+pk8Ufs1M2Np2kPXZlfjh8oM3aCJ4KoSS/v9Rt2tz09X0zlK24goOWFY1y6UNQKWnLC7CPOTZvxxgtNiOm0vZYg1WFRICTgVHzo5Mjn39gCwdve7qbhOHeH3RIbjUpals9Qut6+0IQCFu+bPMaG1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew2w6zMRLyIwRRhZ1lnDf5xsL5Vi1trK6VXcYjHeUJc=;
 b=UujvSQyh7q//UPPmpupWCVM4O4Arhrdoj6y4NVK1Tzv1pjXbQvmXALWCIO9ZsP8Shno0exncSVYVZxUtvh8+XKuRsDI/ythAN2SyYg/E3WQ2PghuxG1+hbJ+Qx09L0WPF1kQbQj4ONCOc1gox0s9ZBb2WixikGP7gl1WBoqkNDw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 02:45:56 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 02:45:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Topic: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Index: AQHWjaRkBfePj6YPJUqeZ9SBHG7j/KluTl2wgAP/dACAABi7gA==
Date: Mon, 21 Sep 2020 02:45:56 +0000
Message-ID: <DM6PR12MB407550879B8DD6730D076398FC3A0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200918101327.986586-1-Emily.Deng@amd.com>
 <DM6PR12MB407563400D44EBCCABEE0765FC3F0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <BY5PR12MB4115E633E7FB3F3EB74DFA5E8F3A0@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115E633E7FB3F3EB74DFA5E8F3A0@BY5PR12MB4115.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-21T02:45:52Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: cdba03e7-be38-412e-8a6f-00004095d68a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2067c171-8cfe-4920-12df-08d85dd87717
x-ms-traffictypediagnostic: DM5PR12MB1708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1708CE16325FA7F28E11DB69FC3A0@DM5PR12MB1708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FuicJJLgllpWuTU7vFpd4sBiLAqOPvp6dsN/887eah1S3HiCHNseaMfLypdR9BnlRDFHyMs6waIFdx2Kuqyp4sB3tjin2Z5pPnNLxDaMAq8IKNpD5BoZnix3wX8SnyxHoYwN0nlY5YHgsK6dUqKzs59ckYNsj+h28fvTTecELT9kFTVceWUDwzpV0tX4ZcHPwMeuGk23Lde7CJB170K+LFhY3vncO/xUrr+Hc+X3FLnT/QdrjaTyFid5ci1AL90FEYvR4Qa+EgMB6l0kW5RpnsiumTNi7weZRoyEJ9dD4Er7+ginp+/VwdYRrdANoWWEAbuX6+3Tg9V+SDxE9EB4yaf2i/fiTJ0b+ALD4uYIyUKfaAefGVZv0DlW2BAvGWbn7llRdjWWk7cGnXvYRwjupA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(53546011)(2906002)(83080400001)(83380400001)(45080400002)(6506007)(33656002)(316002)(8936002)(478600001)(186003)(26005)(110136005)(55016002)(7696005)(76116006)(5660300002)(86362001)(8676002)(66946007)(52536014)(66556008)(64756008)(66476007)(9686003)(66446008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: x/yFNz2rWv6osHW12yUKfGqPALZ7T3TMbT4mtJGBPj7ghakyLwE02JhIKDknTJJyn+OL1eRoba/6FM+Bh0P73syj0P4vgMGcXK8wbPYoOMrT9+q2iS2v/rM2GCPsuJW8Np0htxkgxDsj8V/poi4oUifjF1P+Ni73uDnn7yoIXdNtkM2q4r3p9u+XurfrWF4tT7SJ7bBfR1NE7sWsuByYnzBZXnR9mKLo/UvJy7XgGsfDKL8kVFNb0+KffqzZkHft/5eFl0TFNrBC7W90Bxv4yzylhXo4mZ51z8knQsvkz6DWrNQCcbtYIHD59DeGcAquA1R/owPDg9h+lRzk7CdRanfSFfo/iKTyeMrLWK3JV4kGwdoqBxjzMh7ArBn4aaUDAy7lQic8Nv62drHTCsgbXnjlvDqYzacqjERpqnIq7KV9Ef5eROQwSDB41rlh/eZ5RblWcsJzMeclxH8+2gn8GqsMnEUewS4EjMYIP6iJMQB7CQ5PVOIH2Qc045EO1i9Leuban7RojKVz/VyBm+Px+dIcvUR9VMASBqsKOj/bYiHy7+i+40tc407YcemF9UxxmPYJe5U3GW4ZqmS201hQeNy52IofUw252P6wNH1dtGdipZxpUCNlt6dLgXWzM8tq+Znm7wCm/2drMosnj6MMfQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2067c171-8cfe-4920-12df-08d85dd87717
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 02:45:56.4637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aev87cPU8D+ZXfViDgBKWsggoUpEiqvz2N4PX19VYFPU4wKvE5goOA+8gunVSdsct5X1SY0554cfH10joqYZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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

[AMD Public Use]

I see. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

-----Original Message-----
From: Deng, Emily <Emily.Deng@amd.com> 
Sent: Monday, September 21, 2020 09:14
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Fix dead lock issue for vblank

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
>I can't find the implementation of dce_virtual_pageflip in the patch. 
>Is it dropped by accident?
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
>When drm_crtc_vblank_off want to disable vblank, it first get 
>event_lock, and then call hrtimer_cancel, but hrtimer_cancel want to 
>wait timer handler function finished.
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
>amdgpu_device *adev);  static int 
>dce_virtual_connector_encoder_init(struct
>amdgpu_device *adev,
> 					      int index);
>+static int dce_virtual_pageflip(struct amdgpu_device *adev,
>+				unsigned crtc_id);
>+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct
>+hrtimer *vblank_timer);
> static void dce_virtual_set_crtc_vblank_interrupt_state(struct 
>amdgpu_device *adev,
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
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists
>.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cabf1fe6040c6488
>e4c2808d85bbb8623%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
>%7C637360208252937744&amp;sdata=rDwqEd0k94ih31%2B%2FgfzcMW%2B
>JT1VxUp0Cvh3JvoTy76s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
