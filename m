Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BBC04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C71420720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s1VWQj4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E8F6FD0B;
	Fri,  7 Feb 2020 15:50:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235E66FD09
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgnbGbGzrE2I3Dx35Q7RvyKfdo3dgy08wyriiOdgX6vQyAaLMLycKQY5bEh20AeHbgRqlBcqgwV68fHsfJ7ptE7yn7Ttc9DoQYy7WnXaVTqUvj90Ma/t2oeW5qDryr/DAb5p3FIlFLqqvGBX7lFeA2Cn2YVuTpHR7wCx7UBcS6stoyKHFJPznSFLibl7P3W0crYvZ8H8RvI3vob0OhZqfGOxS58hjz294E0rZ8wyVPixaClbE0/eBlgd+NMt8hBk0xEDoG3sUt8xBUNUqQVVa427eJcbUldLeo/fkVIcqt2aATpRt220vRn3yD/iiMSdVolvo8uBCfglmztstUQP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9rX/+SgfEutIvbw/E8rgSu9TzlqDCGnwYbZ7solyX8=;
 b=nbrtLi1AL+8QD2zfp9k+B3wMKb9uBANyec2BSR8k613cdoR1GlVbVXwsITelds7WOqTIrIGxrmzan1JIZPumYDhMAD3oDzSR7mdA9k7CAchinQrBOjO2NbSXxAOYv0ZZgUcwjRVnxoCffRIBSLOvKzqfmjz1RSDQnFyBS0qMjFhREI8p6v2owGbMEpU2D2p4S5R9yyfWQjWhkcAPs8DHeFlpDadolvNy3aAOOuEeQgO/vP7TRWG/mtcSRuC19mVLwU3yQXyYkWGBN75KLw4Gk9Pd3vPp6X/YofBMs4fP5aIuOoX0qTCZlUhNuRJlG/P21lI/UDyqjnw5h0FkTv/+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9rX/+SgfEutIvbw/E8rgSu9TzlqDCGnwYbZ7solyX8=;
 b=s1VWQj4nBDNMTb1cgHpbWhlXCbJnSg+vy+OPQOYPxL4qtcWjcV6lHWWz0QYg2ZmuQ9nr26hPKE2uVMY9HnrNxWpF1zrQfm3oqegIjyjoPVNvw6RP9UsSrtYI6yjUyGa9HsbKgH0don+Q17CToWzguTnV0Zgj+XZXB6f37ytCkYY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:47 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/17] drm/amd/display: Add backlight support via AUX
Date: Fri,  7 Feb 2020 10:50:00 -0500
Message-Id: <20200207155010.1070737-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:45 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11b312c2-5cd6-43da-bc2c-08d7abe57e84
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24405A438E058D415F2C448A981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2syGiZXUu19tzXIC4/b2U5wc3mL+KQV6c9vRbX19FuwKuYxBrduDAzHfEVTWm0v7ZX/6OMpbWg4+1+APDhpHKQskGtm3HxViyzUn5vlhdUVjWqz922o0nW+lUMIbtR3VXLUJ4DEreqmz7Vkl6dfFx6QnV5uYPBYotVbnHWP/9lRhZAJcgyj1vs07fS4CmYxxQPfNDXe/7cDcJbHUBHEmHrJL11T06h9iUgbd1dyRhfyfucb+rqMpzrhU3pYywDzdz0wLgfRzaoNdVPO9/1Iq9cCwP6AN/WgFfio0iXc5VVfN7vm9DaAjB7x5OlvPR2n4OifHpcqkSRn2E132yFPX8B4hoCC3qjKK4OzJ21MW7SxLVJ2oUZmnUip/vl6e960auJ0T1syXAVOfh0euj6J3FwuodVqFmMospj8DLs2zcTayMT4LJCJRDoLgoU+b3BZV
X-MS-Exchange-AntiSpam-MessageData: 3lmgw2aE0ypyfM3LpmVRS9BLX+uDkBoY7QbprjqvkbQGambBuQsHB+Nkxt4yPAe8Us/FvEp78VnJb3p4HUBtp6YMscQ8J7WK3s94JR7TSAKZxJ3PEVWwTQE9aKBlchjiKyLpTOlpotOML92RWImakA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b312c2-5cd6-43da-bc2c-08d7abe57e84
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:45.6731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxogdaSN6S9Rxd+8NZbJ9jQGSO/2g2mk6XcWp9RN3gZRrgd1oJWi70/928jha3TQ5GrY9PfW67tfaKCtAFDSyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Several modern displays support HDR/OLED panel, and one of the
interesting changes provided by this technology is the new approach for
handling backlight. More precisely, in the traditional way, we use PWM
to manage display backlight; however, with HDR/OLED we begin to use DP
Aux channel for adjusting the backlight.

This patch, enable the backlight control in HDR/OLED display via DP Aux.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 161 +++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  34 +++-
 2 files changed, 167 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6786d34f7d04..1c9bacc9a1c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1758,6 +1758,61 @@ static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
 	.atomic_commit_tail = amdgpu_dm_atomic_commit_tail
 };
 
+static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
+{
+	u32 max_cll, min_cll, max, min, q, r;
+	struct amdgpu_dm_backlight_caps *caps;
+	struct amdgpu_display_manager *dm;
+	struct drm_connector *conn_base;
+	struct amdgpu_device *adev;
+	static const u8 pre_computed_values[] = {
+		50, 51, 52, 53, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 68, 69,
+		71, 72, 74, 75, 77, 79, 81, 82, 84, 86, 88, 90, 92, 94, 96, 98};
+
+	if (!aconnector || !aconnector->dc_link)
+		return;
+
+	conn_base = &aconnector->base;
+	adev = conn_base->dev->dev_private;
+	dm = &adev->dm;
+	caps = &dm->backlight_caps;
+	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
+	caps->aux_support = false;
+	max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
+	min_cll = conn_base->hdr_sink_metadata.hdmi_type1.min_cll;
+
+	if (caps->ext_caps->bits.oled == 1 ||
+	    caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
+	    caps->ext_caps->bits.hdr_aux_backlight_control == 1)
+		caps->aux_support = true;
+
+	/* From the specification (CTA-861-G), for calculating the maximum
+	 * luminance we need to use:
+	 *	Luminance = 50*2**(CV/32)
+	 * Where CV is a one-byte value.
+	 * For calculating this expression we may need float point precision;
+	 * to avoid this complexity level, we take advantage that CV is divided
+	 * by a constant. From the Euclids division algorithm, we know that CV
+	 * can be written as: CV = 32*q + r. Next, we replace CV in the
+	 * Luminance expression and get 50*(2**q)*(2**(r/32)), hence we just
+	 * need to pre-compute the value of r/32. For pre-computing the values
+	 * We just used the following Ruby line:
+	 *	(0...32).each {|cv| puts (50*2**(cv/32.0)).round}
+	 * The results of the above expressions can be verified at
+	 * pre_computed_values.
+	 */
+	q = max_cll >> 5;
+	r = max_cll % 32;
+	max = (1 << q) * pre_computed_values[r];
+
+	// min luminance: maxLum * (CV/255)^2 / 100
+	q = DIV_ROUND_CLOSEST(min_cll, 255);
+	min = max * DIV_ROUND_CLOSEST((q * q), 100);
+
+	caps->aux_max_input_signal = max;
+	caps->aux_min_input_signal = min;
+}
+
 static void
 amdgpu_dm_update_connector_after_detect(struct amdgpu_dm_connector *aconnector)
 {
@@ -1872,7 +1927,7 @@ amdgpu_dm_update_connector_after_detect(struct amdgpu_dm_connector *aconnector)
 					    aconnector->edid);
 		}
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
-
+		update_connector_ext_caps(aconnector);
 	} else {
 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
 		amdgpu_dm_update_freesync_caps(connector, NULL);
@@ -2484,6 +2539,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
 #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
+#define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
@@ -2498,9 +2554,11 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 
 	amdgpu_acpi_get_backlight_caps(dm->adev, &caps);
 	if (caps.caps_valid) {
+		dm->backlight_caps.caps_valid = true;
+		if (caps.aux_support)
+			return;
 		dm->backlight_caps.min_input_signal = caps.min_input_signal;
 		dm->backlight_caps.max_input_signal = caps.max_input_signal;
-		dm->backlight_caps.caps_valid = true;
 	} else {
 		dm->backlight_caps.min_input_signal =
 				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
@@ -2508,40 +2566,95 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	}
 #else
+	if (dm->backlight_caps.aux_support)
+		return;
+
 	dm->backlight_caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	dm->backlight_caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 #endif
 }
 
+static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
+{
+	bool rc;
+
+	if (!link)
+		return 1;
+
+	rc = dc_link_set_backlight_level_nits(link, true, brightness,
+					      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+
+	return rc ? 0 : 1;
+}
+
+static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
+			      const uint32_t user_brightness)
+{
+	u32 min, max, conversion_pace;
+	u32 brightness = user_brightness;
+
+	if (!caps)
+		goto out;
+
+	if (!caps->aux_support) {
+		max = caps->max_input_signal;
+		min = caps->min_input_signal;
+		/*
+		 * The brightness input is in the range 0-255
+		 * It needs to be rescaled to be between the
+		 * requested min and max input signal
+		 * It also needs to be scaled up by 0x101 to
+		 * match the DC interface which has a range of
+		 * 0 to 0xffff
+		 */
+		conversion_pace = 0x101;
+		brightness =
+			user_brightness
+			* conversion_pace
+			* (max - min)
+			/ AMDGPU_MAX_BL_LEVEL
+			+ min * conversion_pace;
+	} else {
+		/* TODO
+		 * We are doing a linear interpolation here, which is OK but
+		 * does not provide the optimal result. We probably want
+		 * something close to the Perceptual Quantizer (PQ) curve.
+		 */
+		max = caps->aux_max_input_signal;
+		min = caps->aux_min_input_signal;
+
+		brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
+			       + user_brightness * max;
+		// Multiple the value by 1000 since we use millinits
+		brightness *= 1000;
+		brightness = DIV_ROUND_CLOSEST(brightness, AMDGPU_MAX_BL_LEVEL);
+	}
+
+out:
+	return brightness;
+}
+
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	struct amdgpu_dm_backlight_caps caps;
-	uint32_t brightness = bd->props.brightness;
+	struct dc_link *link = NULL;
+	u32 brightness;
+	bool rc;
 
 	amdgpu_dm_update_backlight_caps(dm);
 	caps = dm->backlight_caps;
-	/*
-	 * The brightness input is in the range 0-255
-	 * It needs to be rescaled to be between the
-	 * requested min and max input signal
-	 *
-	 * It also needs to be scaled up by 0x101 to
-	 * match the DC interface which has a range of
-	 * 0 to 0xffff
-	 */
-	brightness =
-		brightness
-		* 0x101
-		* (caps.max_input_signal - caps.min_input_signal)
-		/ AMDGPU_MAX_BL_LEVEL
-		+ caps.min_input_signal * 0x101;
-
-	if (dc_link_set_backlight_level(dm->backlight_link,
-			brightness, 0))
-		return 0;
-	else
-		return 1;
+
+	link = (struct dc_link *)dm->backlight_link;
+
+	brightness = convert_brightness(&caps, bd->props.brightness);
+	// Change brightness based on AUX property
+	if (caps.aux_support)
+		return set_backlight_via_aux(link, brightness);
+
+	rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
+
+	return rc ? 0 : 1;
 }
 
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ef92822e86c2..ae25c4c2e18e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -90,15 +90,41 @@ struct dm_comressor_info {
 };
 
 /**
- * struct amdgpu_dm_backlight_caps - Usable range of backlight values from ACPI
- * @min_input_signal: minimum possible input in range 0-255
- * @max_input_signal: maximum possible input in range 0-255
- * @caps_valid: true if these values are from the ACPI interface
+ * struct amdgpu_dm_backlight_caps - Information about backlight
+ *
+ * Describe the backlight support for ACPI or eDP AUX.
  */
 struct amdgpu_dm_backlight_caps {
+	/**
+	 * @ext_caps: Keep the data struct with all the information about the
+	 * display support for HDR.
+	 */
+	union dpcd_sink_ext_caps *ext_caps;
+	/**
+	 * @aux_min_input_signal: Min brightness value supported by the display
+	 */
+	u32 aux_min_input_signal;
+	/**
+	 * @aux_max_input_signal: Max brightness value supported by the display
+	 * in nits.
+	 */
+	u32 aux_max_input_signal;
+	/**
+	 * @min_input_signal: minimum possible input in range 0-255.
+	 */
 	int min_input_signal;
+	/**
+	 * @max_input_signal: maximum possible input in range 0-255.
+	 */
 	int max_input_signal;
+	/**
+	 * @caps_valid: true if these values are from the ACPI interface.
+	 */
 	bool caps_valid;
+	/**
+	 * @aux_support: Describes if the display supports AUX backlight.
+	 */
+	bool aux_support;
 };
 
 /**
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
