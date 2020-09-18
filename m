Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BCAC43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 10:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1E9208C3
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UjttqjZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1E9208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2126ECCE;
	Fri, 18 Sep 2020 10:15:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B026ECCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 10:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrfQAYmU8ozvMOYGxwBop7BUE5QN4+P91GGqIAfQ2xxj8idEtgxbrTyp1BikZQlQy7iES1Dgjs5S1PQzcA/4CxaOHpQWSG8urIfWMPTATZVLTSstWKVAZhhUXI2KwKpGECte588Z5VPlQDskcEAOe7aGOyZeYW8BzB9vtt5VEPFNELpJvmg0f08rAmd8mRMTkHIeJadwdfkoI9NjU7DAEPZI681+hRT92DsA1SSRLlb2WB2Z4gFaTC+TJs76C/WPClo8TQxzfQqTfVHqdgDxA3vgU/LCpzcuFDgIIWWjcWxXxIuIlPmwdTZS49VHT8ikA2yCQ8sQDIu9qXj9gvPuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38kO7F/3v2+YrCB+bgWO5mNO5dwOqXUYW9GftBRJLto=;
 b=bh9hIc+3/qwYB7LUIdvXbzKgt87P+FTec9a2Vdh8aLz+Z02oFCKhQpQgH1I2QuSiXpjqFaDQ35PAaObv1oFQbJJGpixLAyxnoaTcVDyXGT25/iBWa8AH5HUKocUByEXMUrMmLj8zUH/zVGvrurflBdAYe/dClP9m+oDwqQYSd4YIKpiLoGhyEhzrQXdUOYF0THwUZuT7uTQU+ZYh8mQYx5lVGcVtnO9f5jUAm+q5GVU9jllkrpjTGC2Sjfd+lEvRAAe3JTsBF7sId4hC1Z7PxNd1yW70ZQ4+ElJrZ2V1B3Wad4aAjmeq0mvF4K/iv4Npjaq/baQgs+j+Z9JuRJipFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38kO7F/3v2+YrCB+bgWO5mNO5dwOqXUYW9GftBRJLto=;
 b=UjttqjZtZfBV9yJVwE2+IA7ZWRmdPN5J/mEiwWIUQerIvFs+6DgLELJk7+Ugrah9y3927LJwYL2yGPG6bnK2weG1wLdo/dE7vNyaer79kK5weeZu3wGGXxEywrtddJNTsHCGj0s1JTycZhPIt3ZUEU/6+GvncnRAViQrsYvn0aQ=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3875.namprd12.prod.outlook.com (2603:10b6:a03:1ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 18 Sep
 2020 10:15:08 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 10:15:08 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Topic: [PATCH] drm/amdgpu: Fix dead lock issue for vblank
Thread-Index: AQHWjaRgMi9HPk/1B0yQmSlhyMYKZKluLacg
Date: Fri, 18 Sep 2020 10:15:08 +0000
Message-ID: <BY5PR12MB41154A3A6AE983F7442B5D478F3F0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200918101327.986586-1-Emily.Deng@amd.com>
In-Reply-To: <20200918101327.986586-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5bdbe42a-2faa-4c9c-a03c-5c2cff67e8fe;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-18T10:14:21Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2c63d23-f590-45b0-7f18-08d85bbbb869
x-ms-traffictypediagnostic: BY5PR12MB3875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB38756C03C6C1DC481D4169A18F3F0@BY5PR12MB3875.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /S/DLVZDzHR6eASNlp7cubw9emm0h9WAVsiwtZa89qDMdD4tMyAggy/8yfBGiDoot4F1skSozeiqNeS2eGb9wckyInAKqSnGOqTm5UpWuZH26NxvkHBOBjbMpBSEGK5zhVcThe7+xRsodJy7CWxPPYGS9jK/DuxavXXYFudZQxZZ/9VPliGZjOYiIjrVDskBg/5ujWgnn/PVd35FQQmfRwJUaEJ9uBzfe+AJXB6u0X24JxgV6fdDCVQpi7qzAZNpgK/oKsReUfVkT7DIQI6kY3BZImF5KQQK5aD+VYIlavNwQUKT4yTD9UbWdLnOmxlPYdB5nb50EkG8p+s5ER7BPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(2906002)(55016002)(66946007)(66476007)(66556008)(64756008)(76116006)(66446008)(5660300002)(9686003)(52536014)(71200400001)(316002)(6506007)(8936002)(110136005)(8676002)(86362001)(478600001)(83380400001)(26005)(186003)(7696005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EZCm/Mh2gd52PdR5ZwQ85j3CespjWiWGZyGyutXsNRD3kfGYjZmzLyzA4NrWRf6f2oatUXHqMb17MJ+XjqdkWUHW49sfqpZjg/9bxDyQLTciO93zA2gQwjQa+iCc0ET5qUAUpsvdtlvrsAzPMo81GPUI5+ALbmC5mNk3tw4ypx39CbEluOh12cj6wx+TOBigMgrH0iJhs8JNRqLFKPbkbKtKeHL6yxueY/Gj/wm+tMUSD6XaG8guqDlphykUDhNMAO0yi43AfULKfMXYi25SW9xjspNveMd8dE8HO/0bK565KMcNB5zuOm+08t0viVxVtzSmHPTzvdI3m+G+Kw4iswuRiWVa2CwC1gndIlr3shZTiDPwBGPZtKnUgJS7cOhJX0lX7LDGV9gfq859XZESBGsNtlfPLllpn74ijTvmeacwVRCs6zv2oVqPzbq4jQCsgy9XQEQCghOL05Gq7+OuBd92HYpqFWpvkgetlmAH+ZOOxtK0G9LhRd3GuLQydwSy+V+qepcitYf94AE4scG61G1a61DpRLPl39QSBaAsG3iYrJTgG0gQyW9c60PhteXXehQRK/iqcWxskNC9qOj/lkwl8ggb/wHcM5zgKPwX/oWxV9SM92+2tyEZFEtJdQg6utxv7HpYiJXFytaz11wItA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c63d23-f590-45b0-7f18-08d85bbbb869
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 10:15:08.1598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezvpPUgeQqvdMUyPmm3gOKNlobQrDdpAnXx+sRU+LupY1SfsomKIWpM+1M1b2qCB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3875
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

[AMD Official Use Only - Internal Distribution Only]

Hi Hawking,
    You are right, my base is not the tip. I have updated now. Please help to review again.

Best wishes
Emily Deng



>-----Original Message-----
>From: Emily.Deng <Emily.Deng@amd.com>
>Sent: Friday, September 18, 2020 6:13 PM
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
>       int index);
>+static int dce_virtual_pageflip(struct amdgpu_device *adev,
>+unsigned crtc_id);
>+static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct
>+hrtimer *vblank_timer);
> static void dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device
>*adev,
> int crtc,
> enum
>amdgpu_interrupt_state state); @@ -247,6 +250,11 @@ static int
>dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
> amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
> drm_crtc_helper_add(&amdgpu_crtc->base,
>&dce_virtual_crtc_helper_funcs);
>
>+hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC,
>HRTIMER_MODE_REL);
>+hrtimer_set_expires(&amdgpu_crtc->vblank_timer,
>DCE_VIRTUAL_VBLANK_PERIOD);
>+amdgpu_crtc->vblank_timer.function =
>dce_virtual_vblank_timer_handle;
>+hrtimer_start(&amdgpu_crtc->vblank_timer,
>+      DCE_VIRTUAL_VBLANK_PERIOD, HRTIMER_MODE_REL);
> return 0;
> }
>
>@@ -476,7 +484,7 @@ static int dce_virtual_hw_fini(void *handle)
>
> for (i = 0; i<adev->mode_info.num_crtc; i++)
> if (adev->mode_info.crtcs[i])
>-dce_virtual_set_crtc_vblank_interrupt_state(adev, i,
>AMDGPU_IRQ_STATE_DISABLE);
>+hrtimer_cancel(&adev->mode_info.crtcs[i]-
>>vblank_timer);
>
> return 0;
> }
>@@ -698,9 +706,15 @@ static enum hrtimer_restart
>dce_virtual_vblank_timer_handle(struct hrtimer *vbla
>        struct amdgpu_crtc,
>vblank_timer);
> struct drm_device *ddev = amdgpu_crtc->base.dev;
> struct amdgpu_device *adev = drm_to_adev(ddev);
>+struct amdgpu_irq_src *source = adev-
>>irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources
>+[VISLANDS30_IV_SRCID_SMU_DISP_TIMER2_TRIGGER];
>+int irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>+amdgpu_crtc->crtc_id);
>
>-drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
>-dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
>+if (amdgpu_irq_enabled(adev, source, irq_type)) {
>+drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
>+dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
>+}
> hrtimer_start(vblank_timer, DCE_VIRTUAL_VBLANK_PERIOD,
>       HRTIMER_MODE_REL);
>
>@@ -716,21 +730,6 @@ static void
>dce_virtual_set_crtc_vblank_interrupt_state(struct amdgpu_device *ad
> return;
> }
>
>-if (state && !adev->mode_info.crtcs[crtc]->vsync_timer_enabled) {
>-DRM_DEBUG("Enable software vsync timer\n");
>-hrtimer_init(&adev->mode_info.crtcs[crtc]->vblank_timer,
>-     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>-hrtimer_set_expires(&adev->mode_info.crtcs[crtc]-
>>vblank_timer,
>-    DCE_VIRTUAL_VBLANK_PERIOD);
>-adev->mode_info.crtcs[crtc]->vblank_timer.function =
>-dce_virtual_vblank_timer_handle;
>-hrtimer_start(&adev->mode_info.crtcs[crtc]->vblank_timer,
>-      DCE_VIRTUAL_VBLANK_PERIOD,
>HRTIMER_MODE_REL);
>-} else if (!state && adev->mode_info.crtcs[crtc]->vsync_timer_enabled)
>{
>-DRM_DEBUG("Disable software vsync timer\n");
>-hrtimer_cancel(&adev->mode_info.crtcs[crtc]->vblank_timer);
>-}
>-
> adev->mode_info.crtcs[crtc]->vsync_timer_enabled = state;
> DRM_DEBUG("[FM]set crtc %d vblank interrupt state %d\n", crtc,
>state);  }
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
