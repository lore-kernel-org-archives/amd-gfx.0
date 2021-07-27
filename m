Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73822C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 17:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3416C60FEE
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 17:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3416C60FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24646E364;
	Tue, 27 Jul 2021 17:13:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEEF6E364
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jul 2021 17:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpgP//jw7oNEzynoeuRgrF8dDPbhR10t2XtSSnW+btRlGMYhD3PuzAWIH9i0KB4n5gJnvPlZPW50i+E6tvEYrXygah1KsgzHzJ2O4VhXsKhGc8QVmNYHbzONd6NxU8F2dsepQjJjGm9V96zT41vFi/0tuVkmkTJbApAba1m5LGOYikTmcpa7nqGxOn2pfflX5K/xK93WUw06cAT5oPOau4t/u5ssmKTFMzFGfQaOuTmdcM+H8rD/cmExLOvWbjitX6dGq3k8N0P9T8cBltcEpJYYLT1Va1E8+Ut7xLxy7Typdlrp7KofzMRo+lSErjw/UgU6S0MfWQuBjB75njCbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x86ip7l87degKZleeuZO8ADCUC7vNrj3jVeRVaLkup4=;
 b=Cp6WVKUAdHULKrjvBNYWQ4FO18C2/XIw7lMaUj33/xvjsfPRpSEloMK1OLt7r1I82VGpsgbBPCd23U7s5+qKrpLC3dIDpPVfaWR5ad0JsmU+iULZ3maowLWKiSJPixtMi8mlTPslSrWQOHs6YSl95XFJZDvggSJbmD2Qt2EgkpPmTnlrHpXRzUW7lRxGabEj7jUZWYUQhihng0KxMkRkDFRJfreHm1AwNn85Gk6HEE777hdtF3CIlTzl5hSkSABGLemsOwRbcP3f0j3/8a4fPnxBMAbzP7jzzWUac8hCmTfIYC1jX33AYz9sbTs6NRFZmtDtjYIKEZcF5yfgfwU+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x86ip7l87degKZleeuZO8ADCUC7vNrj3jVeRVaLkup4=;
 b=k4TTpaj2QN+zoOkVkgXzZ49oyM0yIvM92BU02TS3ksVGeCQozcwUACsxjuphHvE2vOp+HivyVUUdX7v3pEVA2Oz1L/vnLF7Y0VhfOkKGtvpcYV9KIcaLz9xyYc0/xFMbTBbH/CAnQfdZwIhpWbyNeusn2J/5FTVsoUVg47RDT0o=
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Tue, 27 Jul 2021 17:13:22 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::ec:57a7:8def:e21b]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::ec:57a7:8def:e21b%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 17:13:22 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu/display: add support for multiple backlights
Thread-Topic: [PATCH V2] drm/amdgpu/display: add support for multiple
 backlights
Thread-Index: AQHXeOKFnyTPAOVaMEyOT3RjlG6F06tXHgNA
Date: Tue, 27 Jul 2021 17:13:22 +0000
Message-ID: <DM8PR12MB541322294C56D7CD61D3116189E99@DM8PR12MB5413.namprd12.prod.outlook.com>
References: <20210714190012.1169489-1-alexander.deucher@amd.com>
In-Reply-To: <20210714190012.1169489-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6061f939-e85b-408a-9504-c1ea778ba356;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-27T16:53:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12547f24-8ce0-447c-0778-08d95121d6a0
x-ms-traffictypediagnostic: DM4PR12MB5181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB518170313D22A4DD501B2C2489E99@DM4PR12MB5181.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:181;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBkMQpmWcyct3Gh01wlNXO06912qBwtNZsuBwUK7E1ruUOeNP+dGd9dElyUcKobXw14dQhbmPMf+c7lDYEv8nCF7PblBslAH0hWu9yFijUtsIrLnX4hguC6okCW98f8zNs7WZ5j8dSmmpqt/Wn6LmfZRLyo39EQ1/kctsZPvjH8x3LF+yS2/7Gz6d3nogy+XH6DjljjUmUm3iblCs5W+81ORwGRdSFGS0DZOMgzaWeJXvO8gcbsEdPOXjtceQ7EzCv8HOdCoNBbG65VFqZq1B3XFzkiV/+tfoWcwdhZow7nMuil+dWKbnbFgO2BSCSpcAEeLvMhqdWgr2BmWAIl89QYCxqM7xxfZP5uTUAXQQdl4Vu9OyS8lnZMrxy2Rlb5kTJyvQbgHN4sZsk7BvxDilSFVoZ0y+zyNEMDTmQe2nv0bJdg+s1HrtirlOeNpq709/rmzQg9M/N8qhWB4CdUA6mqPaQz02Lyhj06zFzh8Yhxw7p9c8hLuwhYIRp7JH0aBmZs5BWtaOPp+VxhZZMakNpvGdtS9DvSs+kXDQIqJ0rsRWu1Zxrghp6EZAHODMUMt5P2FC8hg7rf7vzIbG4+kVG1osYYvDbL7fPXbSor7LRhNz0TXjDBQamB8uxo5GkfVzsxPvVIUuPFH6EVgA8evxqjkfjJf8HiUuF+Px+k82H/nJ9wyRraio6K0uyKNWxaSjgFxjNjSl1jITJyrOWxK0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(5660300002)(53546011)(54906003)(6506007)(83380400001)(55016002)(64756008)(4326008)(66446008)(76116006)(110136005)(86362001)(8676002)(33656002)(66946007)(316002)(66556008)(38100700002)(966005)(66476007)(30864003)(7696005)(2906002)(52536014)(122000001)(45080400002)(478600001)(26005)(186003)(8936002)(71200400001)(9686003)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zpcnss2kZGAy7zN6JHHQbBpaRDifCMX6k37DctlIUj2D/SMHJWvKBOPV2FQv?=
 =?us-ascii?Q?BmYPMTE3NWUUrNGEJurs477UQgi7eWgAPLazcWzsdtS7QN3D+cGjwZCg1olv?=
 =?us-ascii?Q?RT8ON5ZYxHhyQzGwrov9Km4mF++SS9TP/3yubrMnw6UEIERdTBzUAWRmMzm/?=
 =?us-ascii?Q?4lzKj9RgB50ZUnrxROg0ILDHJStxDl4PiQUbsbl7JoxD3Vq53HikTnJMg+xQ?=
 =?us-ascii?Q?FCP+gsqc3zwpJdUoyWqmgR7EeemAZMOFUnbvLpHB0uqICpx425IZKy3tE5vR?=
 =?us-ascii?Q?wEweOEYfLekf8yGsdAujoAkiG+1KuYPZaUYCSAe8omQT59at59bVWVXIQj25?=
 =?us-ascii?Q?VgYrOcxI+tHi8YkdO0geBNdHmHcFbHVqk5LTGX27p7nqwlnkWCd7g4ZNjvUL?=
 =?us-ascii?Q?S0TmDJQsrTJZ40tPaPb070p82liVtmglOX2BVAkeYLFtqyT1QgKDSIL18ALK?=
 =?us-ascii?Q?aQ2PmTHnXTmOc8yekI3jbJgpOmHu91L/8HdRnqwoDPWPjT+vsgKgfvhbv1ME?=
 =?us-ascii?Q?tU225kVyXwQFs+mKL14uEYgR8jCyCUPoVWl8OC0SeoZf55V9mQ6hvEjc+6cD?=
 =?us-ascii?Q?TXqQ5cfxSrNhUwlZHizsdQCaeEW/cDdidVfQXm7YYADKGJylX5mXwTE4/gg3?=
 =?us-ascii?Q?lqJ3ZdsrNiXhQx3ifDhTiFNadkIAWVJN/QDgKoSfphRMDnBp752XYYflNlYG?=
 =?us-ascii?Q?wOzVHzow1T6iwV2iicRkqpDWJrHNKkaGme60zxBid+s/9i5uUN9U5AzqU/D9?=
 =?us-ascii?Q?/IyYuhahJ9lw0H1Dx8O5hP3kR278KRiowvxHuq/3MR8Gyc+g0Ivo9eKZaIRv?=
 =?us-ascii?Q?gCdXGG8j+QezCPxwsWhJJHo5yYGjOGoXrhuT3UzVcwm0++5+ZAJ+g3E2TgRF?=
 =?us-ascii?Q?/Kql/W7HYZQIleGpdNfnsvWPY5sPv+suBEih2/jHcqLAH9ABD230KvwRUpgl?=
 =?us-ascii?Q?zH9QZO7TnkSV7Erhplxl/JJGkO6St6hr393OvAhsO70k+YjbjudcPmN9HwzA?=
 =?us-ascii?Q?S/i+jydTmhMq1kYGwFEFnn3wztZAgcMUNlXeK7bA1SiLjfOrnjjHh01TzuCy?=
 =?us-ascii?Q?DNfXJle9e5K5XCDJPvKoGpdSJ7JFRRgRPgVftWwBMXplwSvID41ZzxmaDdQF?=
 =?us-ascii?Q?mOTQgQESQVanebE1VDgFN8VzGgxqo3JBzk2IWekCejPgmG//a0qtbFUukeFl?=
 =?us-ascii?Q?SSfYVGYwl35/+STit/Vd1GJ3bEsyBrXBxs+8wPHIC26ighKFhSMF0jJZAtEY?=
 =?us-ascii?Q?/9kFsP6IxowwYhfyfvNZWk+Rg3HFRHZ6xj+3vRDB9am5HhpNDRBQ3GjMMBKU?=
 =?us-ascii?Q?x6OVRrcTx1YV6boORUcTyPuv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12547f24-8ce0-447c-0778-08d95121d6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:13:22.4247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1UDMQROcfo8Dc46J1hBz39FyZRBKRqsurdAPinVUBnFsp7VGwAFndaTARraG3kn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, July 14, 2021 3:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH V2] drm/amdgpu/display: add support for multiple backlights

On platforms that support multiple backlights, register each one separately.  This lets us manage them independently rather than registering a single backlight and applying the same settings to both.

v2: fix typo:
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 147 ++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +-
 3 files changed, 84 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 59373c697b00..9122dcf42c46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -854,8 +854,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
                if (amdgpu_device_has_dc_support(adev)) {  #if defined(CONFIG_DRM_AMD_DC)
                        struct amdgpu_display_manager *dm = &adev->dm;
-                       if (dm->backlight_dev)
-                               atif->bd = dm->backlight_dev;
+                       if (dm->backlight_dev[0])
+                               atif->bd = dm->backlight_dev[0];
 #endif
                } else {
                        struct drm_encoder *tmp;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5cdb0e75d36b..2d48bb09645f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2412,6 +2412,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
        static const u8 pre_computed_values[] = {
                50, 51, 52, 53, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 68, 69,
                71, 72, 74, 75, 77, 79, 81, 82, 84, 86, 88, 90, 92, 94, 96, 98};
+       int i;

        if (!aconnector || !aconnector->dc_link)
                return;
@@ -2423,7 +2424,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
        conn_base = &aconnector->base;
        adev = drm_to_adev(conn_base->dev);
        dm = &adev->dm;
-       caps = &dm->backlight_caps;
+       for (i = 0; i < dm->num_of_edps; i++) {
+               if (link == dm->backlight_link[i])
+                       break;
+       }
+       if (i >= dm->num_of_edps)
+               return;
+       caps = &dm->backlight_caps[i];
        caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
        caps->aux_support = false;
        max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
@@ -3423,35 +3430,36 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)  #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
        defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)

-static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
+static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
+                                           int bl_idx)
 {
 #if defined(CONFIG_ACPI)
        struct amdgpu_dm_backlight_caps caps;

        memset(&caps, 0, sizeof(caps));

-       if (dm->backlight_caps.caps_valid)
+       if (dm->backlight_caps[bl_idx].caps_valid)
                return;

        amdgpu_acpi_get_backlight_caps(&caps);
        if (caps.caps_valid) {
-               dm->backlight_caps.caps_valid = true;
+               dm->backlight_caps[bl_idx].caps_valid = true;
                if (caps.aux_support)
                        return;
-               dm->backlight_caps.min_input_signal = caps.min_input_signal;
-               dm->backlight_caps.max_input_signal = caps.max_input_signal;
+               dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
+               dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
        } else {
-               dm->backlight_caps.min_input_signal =
+               dm->backlight_caps[bl_idx].min_input_signal =
                                AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-               dm->backlight_caps.max_input_signal =
+               dm->backlight_caps[bl_idx].max_input_signal =
                                AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
        }
 #else
-       if (dm->backlight_caps.aux_support)
+       if (dm->backlight_caps[bl_idx].aux_support)
                return;

-       dm->backlight_caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-       dm->backlight_caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+       dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+       dm->backlight_caps[bl_idx].max_input_signal =
+AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 #endif
 }

@@ -3502,41 +3510,31 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap  }

 static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+                                        int bl_idx,
                                         u32 user_brightness)
 {
        struct amdgpu_dm_backlight_caps caps;
-       struct dc_link *link[AMDGPU_DM_MAX_NUM_EDP];
-       u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
+       struct dc_link *link;
+       u32 brightness;
        bool rc;
-       int i;

-       amdgpu_dm_update_backlight_caps(dm);
-       caps = dm->backlight_caps;
+       amdgpu_dm_update_backlight_caps(dm, bl_idx);
+       caps = dm->backlight_caps[bl_idx];

-       for (i = 0; i < dm->num_of_edps; i++) {
-               dm->brightness[i] = user_brightness;
-               brightness[i] = convert_brightness_from_user(&caps, dm->brightness[i]);
-               link[i] = (struct dc_link *)dm->backlight_link[i];
-       }
+       dm->brightness[bl_idx] = user_brightness;
+       brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
+       link = (struct dc_link *)dm->backlight_link[bl_idx];

        /* Change brightness based on AUX property */
        if (caps.aux_support) {
-               for (i = 0; i < dm->num_of_edps; i++) {
-                       rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
-                               AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-                       if (!rc) {
-                               DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
-                               break;
-                       }
-               }
+               rc = dc_link_set_backlight_level_nits(link, true, brightness,
+                                                     AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+               if (!rc)
+                       DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n",
+bl_idx);
        } else {
-               for (i = 0; i < dm->num_of_edps; i++) {
-                       rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
-                       if (!rc) {
-                               DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", i);
-                               break;
-                       }
-               }
+               rc = dc_link_set_backlight_level(link, brightness, 0);
+               if (!rc)
+                       DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
        }

        return rc ? 0 : 1;
@@ -3545,33 +3543,41 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,  static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)  {
        struct amdgpu_display_manager *dm = bl_get_data(bd);
+       int i;

-       amdgpu_dm_backlight_set_level(dm, bd->props.brightness);
+       for (i = 0; i < dm->num_of_edps; i++) {
+               if (bd == dm->backlight_dev[i])
+                       break;
+       }
+       if (i >= AMDGPU_DM_MAX_NUM_EDP)
+               i = 0;
+       amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);

        return 0;
 }

-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
+static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+                                        int bl_idx)
 {
        struct amdgpu_dm_backlight_caps caps;
+       struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];

-       amdgpu_dm_update_backlight_caps(dm);
-       caps = dm->backlight_caps;
+       amdgpu_dm_update_backlight_caps(dm, bl_idx);
+       caps = dm->backlight_caps[bl_idx];

        if (caps.aux_support) {
-               struct dc_link *link = (struct dc_link *)dm->backlight_link[0];
                u32 avg, peak;
                bool rc;

                rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
                if (!rc)
-                       return dm->brightness[0];
+                       return dm->brightness[bl_idx];
                return convert_brightness_to_user(&caps, avg);
        } else {
-               int ret = dc_link_get_backlight_level(dm->backlight_link[0]);
+               int ret = dc_link_get_backlight_level(link);

                if (ret == DC_ERROR_UNEXPECTED)
-                       return dm->brightness[0];
+                       return dm->brightness[bl_idx];
                return convert_brightness_to_user(&caps, ret);
        }
 }
@@ -3579,8 +3585,15 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)  static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)  {
        struct amdgpu_display_manager *dm = bl_get_data(bd);
+       int i;

-       return amdgpu_dm_backlight_get_level(dm);
+       for (i = 0; i < dm->num_of_edps; i++) {
+               if (bd == dm->backlight_dev[i])
+                       break;
+       }
+       if (i >= AMDGPU_DM_MAX_NUM_EDP)
+               i = 0;
+       return amdgpu_dm_backlight_get_level(dm, i);
 }

 static const struct backlight_ops amdgpu_dm_backlight_ops = { @@ -3594,31 +3607,28 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)  {
        char bl_name[16];
        struct backlight_properties props = { 0 };
-       int i;

-       amdgpu_dm_update_backlight_caps(dm);
-       for (i = 0; i < dm->num_of_edps; i++)
-               dm->brightness[i] = AMDGPU_MAX_BL_LEVEL;
+       amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
+       dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;

        props.max_brightness = AMDGPU_MAX_BL_LEVEL;
        props.brightness = AMDGPU_MAX_BL_LEVEL;
        props.type = BACKLIGHT_RAW;

        snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
-                adev_to_drm(dm->adev)->primary->index);
+                adev_to_drm(dm->adev)->primary->index + dm->num_of_edps);

-       dm->backlight_dev = backlight_device_register(bl_name,
-                                                     adev_to_drm(dm->adev)->dev,
-                                                     dm,
-                                                     &amdgpu_dm_backlight_ops,
-                                                     &props);
+       dm->backlight_dev[dm->num_of_edps] = backlight_device_register(bl_name,
+                                                                      adev_to_drm(dm->adev)->dev,
+                                                                      dm,
+                                                                      &amdgpu_dm_backlight_ops,
+                                                                      &props);

-       if (IS_ERR(dm->backlight_dev))
+       if (IS_ERR(dm->backlight_dev[dm->num_of_edps]))
                DRM_ERROR("DM: Backlight registration failed!\n");
        else
                DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);  }
-
 #endif

 static int initialize_plane(struct amdgpu_display_manager *dm, @@ -3675,10 +3685,10 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
                 * DM initialization because not having a backlight control
                 * is better then a black screen.
                 */
-               if (!dm->backlight_dev)
+               if (!dm->backlight_dev[dm->num_of_edps])
                        amdgpu_dm_register_backlight_device(dm);

-               if (dm->backlight_dev) {
+               if (dm->backlight_dev[dm->num_of_edps]) {
                        dm->backlight_link[dm->num_of_edps] = link;
                        dm->num_of_edps++;
                }
@@ -6198,6 +6208,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
        const struct dc_link *link = aconnector->dc_link;
        struct amdgpu_device *adev = drm_to_adev(connector->dev);
        struct amdgpu_display_manager *dm = &adev->dm;
+       int i;

        /*
         * Call only if mst_mgr was iniitalized before since it's not done @@ -6208,12 +6219,11 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)

 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
        defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-
-       if ((link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) &&
-           link->type != dc_connection_none &&
-           dm->backlight_dev) {
-               backlight_device_unregister(dm->backlight_dev);
-               dm->backlight_dev = NULL;
+       for (i = 0; i < dm->num_of_edps; i++) {
+               if ((link == dm->backlight_link[i]) && dm->backlight_dev[i]) {
+                       backlight_device_unregister(dm->backlight_dev[i]);
+                       dm->backlight_dev[i] = NULL;
+               }
        }
 #endif

@@ -9191,8 +9201,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||          \
        defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
        /* restore the backlight level */
-       if (dm->backlight_dev && (amdgpu_dm_backlight_get_level(dm) != dm->brightness[0]))
-               amdgpu_dm_backlight_set_level(dm, dm->brightness[0]);
+       for (i = 0; i < dm->num_of_edps; i++) {
+               if (dm->backlight_dev[i] &&
+                   (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
+                       amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+       }
 #endif
        /*
         * send vblank event on all events not handled in flip and diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9522d4ca299e..ab1670b16b02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -365,13 +365,13 @@ struct amdgpu_display_manager {

        spinlock_t irq_handler_list_table_lock;

-       struct backlight_device *backlight_dev;
+       struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];

        const struct dc_link *backlight_link[AMDGPU_DM_MAX_NUM_EDP];

        uint8_t num_of_edps;

-       struct amdgpu_dm_backlight_caps backlight_caps;
+       struct amdgpu_dm_backlight_caps backlight_caps[AMDGPU_DM_MAX_NUM_EDP];

        struct mod_freesync *freesync_module;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Croman.li%40amd.com%7C4e1f8a3d82c94bb5a6c608d946f9a646%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618860323313878%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=wTGk3rrbxTa2gWnTgI%2FCic0Dqr7ERPgbanwXpn47ZiA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
