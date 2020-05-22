Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2BCC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B151120757
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ayvc3od9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B151120757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669BB6E0E7;
	Fri, 22 May 2020 05:53:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58DE6E0E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztu3rR1RVyxO2URFJ+3p+lQGqmjM3IjY6VAGkogmpcvEx0X2+MqfuuCrToiAztQRi/5cbXWp9R5PJIFR5G8gWRJ8HnDEDrhY2gZn9Ox2Zq78J0siBO51HtnEHd+wu+1loeyIo1Sx080CBeCCzPJTPQMP1RibzUBhs7Dqj6uzgkxAQi33mDy2zV4g2z7GVr6+KjJPVpheScFZqUXrHCevkNKPcS0HkVfn3JoNCEZfjPS4DvSYy0JPnKNuJQPT8qACiAtW/KTVpGM43VbuAN+0ipwPeNfr3v2l0DUK0pL0sywMJnUJmJGBWgjs7gIs5/AEYjSBNHoGMzupLmtuQGj21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDbuYAivULH0cjF1BLyt/I1K0e+YPqyQMKY53d+SgOw=;
 b=l7In4QyWWfty+WuWPyz/uddvAV8sW/JU4tq8qV5y02PvNKxrlpvQG4CiHuyOWa9XSgyiaPorV2nGx5Uat2VgH5/1HmTXZbGO1ipUccIesNV2ueDNqswaCb7hBLMP36jQhCHUPuw8jC4dCYlT3JXoM9fC0WG5226uhZjxBh/aRNUuSQ7g+S8h+AiqcUX+mQrMSIXoYw18g9vGLWgBkJDEmqlSH2AINRKWGHG3+KGFe4T+XANow4rYWylCl5AM/C4I8XyH/F4pIAfKWzImROUv0KaRUQP51J9Db5/yz0RKCmcgXYx+eOHofngD1zTK1JyC3sMVCYXnYN5jBUwfQBPz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDbuYAivULH0cjF1BLyt/I1K0e+YPqyQMKY53d+SgOw=;
 b=ayvc3od9ksCMrt7xxrbeNoioiAr7pGjpD6HZpsB4X+kKCMaR+9djR1zO6wAZuasx1Fn7UrXqoMfL8/rtJb4djkNgZMKxgB8W5xiqJ4UwR1ZEaUj18I+xMuMslo8YYYkCEL80QGOW5bW6+45vjSIvBDVAjr+klQI+DWt9qkkeeMg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.26; Fri, 22 May 2020 05:53:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Fri, 22 May 2020
 05:53:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify ATIF backlight handling
Thread-Topic: [PATCH] drm/amdgpu: simplify ATIF backlight handling
Thread-Index: AQHWIxZmuuN9wYGS5ky1efcZsYCLP6iztFSA
Date: Fri, 22 May 2020 05:53:25 +0000
Message-ID: <DM6PR12MB2619F921240B6C25712400F3E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200505194812.185370-1-alexander.deucher@amd.com>
In-Reply-To: <20200505194812.185370-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6ad81f59-c980-4562-80af-0000a3709c2e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:53:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e35c1daa-a927-4fac-5eda-08d7fe1471c5
x-ms-traffictypediagnostic: DM6PR12MB2987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2987134431944A9B29B67761E4B40@DM6PR12MB2987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0IFe3ITMmBcoignnRDAaSbdupNwYt/qVQ2gUNlsMlAhZ0HRH64jCD8X4UMBAHk1YjR6GKp4P/CVMZE5FGbMeOxuclF/3ykx24ZfglHvst2iQ3lcN5JkQZh7sCkkwcrCK9P2nY6DVE6Gssmx2BbhEtjnUyuZj0ip0RzRR9ThRS1XMTyT0eIwmhpvRytT6tJMdJeAoYl9s8WoW55MDbUy0viirsuqNmH/dSuiA/hGhZsWMUXvSeqRWXC/LpvfmJevTMuS6B5J9q0GzSAxFHv2gq33lF3JCub1MQxPHQveleUYG1xWVjlFPSIfY654KTuGap6Qs9BF8mdOhboYrcvPJ49P3OVnRhMDkUpsR+7wm8kfzFK0sCFeYcRess2TVhBOYFn/nJrPOe+Mk7TaznouitjQr/G1XLodjMn0JeKNctns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(9686003)(6506007)(53546011)(5660300002)(7696005)(316002)(86362001)(26005)(52536014)(33656002)(110136005)(4326008)(71200400001)(966005)(45080400002)(55016002)(2906002)(66446008)(64756008)(8936002)(186003)(66556008)(76116006)(478600001)(66946007)(8676002)(66476007)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 01iHWH9tt4+bCHbfoP6gQCZjy58dvlg8H24de295+HOX3/yD25CJla1v6PV+40wF7/c4QsD4KbIvZGVhpCIMk0h0pFw/tBB8neKnoRLBdE54f37VvfwosWjhtZ3FXGfst//3Ds7BPtNJiAjUFMVgTMrqpZIBSymekZoKw2AZO7byXcIO1eZe0IqMrhAz3ILixO9IM+K2Iu0ex+e7Rwo3HG6wgdTyeD/vR0XxaJk7r+r4D2g6EYMxltw2LPNS55o49/CTnwT2JPmBId3zGSaXaFuLbVMY4Ho9DYlRITcUkxYaM+7dY01J3Q1b/BgEUbdeRZaSzg4v1ucJi6QOiUewiI7LmB8ZbdjKlKVHtZ+LpMmwZlrLNa5OQIs7c8sNbgxw5GWnsNlYDDUuxXSaeF7IRtHv+P9HoNxqR8OCJG0lLfGw6K9UfUfPuT40yeI1ryRvnnEghY+ypUoDtrF2357LX4r9DsL2xNHSCWWXWrqhz2lChvpqqyo5rZQc+azH8mJh
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35c1daa-a927-4fac-5eda-08d7fe1471c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:53:25.6306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/+A+TBvbA4G0UB567+1NG57F4i4Ssnv8+NA1dMu5Y2Y0MqXTAjPxXj8Do8N6BRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, May 6, 2020 3:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: simplify ATIF backlight handling

Just register the a pointer to the backlight device and use that. Unifies the DC and non-DC handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 73 ++++++++++--------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 956cbbda4793..913c8f0513bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -64,7 +64,9 @@ struct amdgpu_atif {
 struct amdgpu_atif_notifications notifications;
 struct amdgpu_atif_functions functions;
 struct amdgpu_atif_notification_cfg notification_cfg;
-struct amdgpu_encoder *encoder_for_bl;
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+struct backlight_device *bd;
+#endif
 struct amdgpu_dm_backlight_caps backlight_caps;  };

@@ -444,45 +446,21 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,

 DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);

-if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
-    !amdgpu_device_has_dc_support(adev)) {
-struct amdgpu_encoder *enc = atif->encoder_for_bl;
-
-if (enc) {
-struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
-
-DRM_DEBUG_DRIVER("Changing brightness to %d\n",
- req.backlight_level);
-
-amdgpu_display_backlight_set_level(adev, enc, req.backlight_level);
-
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-backlight_force_update(dig->bl_dev,
-       BACKLIGHT_UPDATE_HOTKEY);
-#endif
-}
-}
-#if defined(CONFIG_DRM_AMD_DC)
+if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
-    amdgpu_device_has_dc_support(adev)) {
-struct amdgpu_display_manager *dm = &adev->dm;
-struct backlight_device *bd = dm->backlight_dev;
-
-if (bd) {
+if (atif->bd) {
 DRM_DEBUG_DRIVER("Changing brightness to %d\n",
  req.backlight_level);
-
 /*
  * XXX backlight_device_set_brightness() is
  * hardwired to post BACKLIGHT_UPDATE_SYSFS.
  * It probably should accept 'reason' parameter.
  */
-backlight_device_set_brightness(bd, req.backlight_level);
+backlight_device_set_brightness(atif->bd, req.backlight_level);
 }
-}
-#endif
 #endif
+}
+
 if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
 if (adev->flags & AMD_IS_PX) {
 pm_runtime_get_sync(adev->ddev->dev);
@@ -829,23 +807,32 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 adev->atif = atif;

 if (atif->notifications.brightness_change) {
-struct drm_encoder *tmp;
-
-/* Find the encoder controlling the brightness */
-list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
-head) {
-struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
-
-if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
-    enc->enc_priv) {
-struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
-if (dig->bl_dev) {
-atif->encoder_for_bl = enc;
-break;
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+if (amdgpu_device_has_dc_support(adev)) { #if
+defined(CONFIG_DRM_AMD_DC)
+struct amdgpu_display_manager *dm = &adev->dm;
+atif->bd = dm->backlight_dev;
+#endif
+} else {
+struct drm_encoder *tmp;
+
+/* Find the encoder controlling the brightness */
+list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
+    head) {
+struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
+
+if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
+    enc->enc_priv) {
+struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
+if (dig->bl_dev) {
+atif->bd = dig->bl_dev;
+break;
+}
 }
 }
 }
 }
+#endif

 if (atif->functions.sbios_requests && !atif->functions.system_params) {
 /* XXX check this workraround, if sbios request function is
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cf8a40f42e8ec4ea3c9e008d7f12d4592%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637243050173626661&amp;sdata=yj1OgR%2FXj4X0VvZ3%2F%2FOIGgA0RDN4JP%2FG7IOuBM9xEaA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
