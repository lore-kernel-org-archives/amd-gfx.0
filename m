Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB896C07E99
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 15:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960016147D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 15:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960016147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550B46E8DC;
	Thu,  8 Jul 2021 15:29:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED846E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 15:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hb35Bvo9mRUlEkyLp3TbSOBBouysVZF6dvDWYb6RJWznkaruutWNdwzbCZuMTawWXrMwkEVrcsLIlYZ1cYspzM7gePYzpLv1vIeiVwaWrnmXGB8nRx/jPkGEbs0RB2TUZRV4GcVjJDLBwxxyvdAVvZfRJx0u1zxPBDMPVH8xNhOVFX/iiD5PreOUIHDBtnUp6S7tKz5ICEAI7cTC/DyLT0XebHz83wcFEUVxJUuzv9UqlaAI0+HT7PpbqL/WV8HDW0pvPDUTUsuFK9cbMxg6M4ggNvR6XuJL37UJv17NzYbMR7iK8NwcI+bkVM8S6izlpzyAXNtQCgsc/thDCaq+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKGOvO0PsKUyqIPWIX1E9wxxBpRIKwlPV6qRH/xD4T8=;
 b=bSH+lMz8pGTrBr0gXL2s/GteJ2rEpHwb652OFirPjbVuIk5bXE49RlUT/gXl7ZwATwg1QIWGCJTcE3IRFr57UrHlJhlb7wF7GJfACv+XO3fhRriRU319Ug5FvKm5TUjloaM9SE8HgASYSXClCNG4VLuGVcbIf4vd5a0vZXELFaxJUWGceI+Yi+ps7xf9ztGmUDKPjIiJ8aU1oAIvtu0mHfChcAUgNtAjsiUv39XzFboZJc37mKAWEGsSAn5k+MMxTp1LZ0gWqaK8Z/hIZFYyzYv9uiJytKN5j52YntU5qSTkGSJPTk7jvuMILmzTeNSsXI9STNVmz1zYssTNXvUDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKGOvO0PsKUyqIPWIX1E9wxxBpRIKwlPV6qRH/xD4T8=;
 b=Xy4O94Uf9gbsr0F6TwVab6wtAnlO7wT7plSxb5JevYJ2DxVTyXrM7gt3GfpQIP6wbXOfZp2CnTS/S9OQWZwC58XGwmeEbI6yXk23QNUi1VFASw39ZiWYQ79VjTq3ZcYOoG7ayAZgyOLixNWqYdyzwH8Zlxtg9zFL9KjGzorNgrU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 15:29:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4308.023; Thu, 8 Jul 2021
 15:29:14 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: add support for multiple backlights
Date: Thu,  8 Jul 2021 11:29:01 -0400
Message-Id: <20210708152901.1904651-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend
 Transport; Thu, 8 Jul 2021 15:29:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c5d9a8-d3dd-4aee-34bb-08d94225249a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206AA9CF851996CB753FFDDF7199@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bR69+FiUKSXMLjd+EVoDkJDtO0ssXXjsTkOMR7UM/Bs4LwXTjegrT5jm/oDfaCkSx7bJV2aqQ3wkiCDML5tJbufab2KG9VvAGeoRWRKQ100GfOPngZ/Dl8TWh9nJdqAk7GpEETJKrzJ6jsmMIkYcoOtjWXdTP3D1mY0hNRfgbSsqmnGCiZ+FnnP21LLkWfNW0jEjJUEsbTeUQDoStU+7IdXbTmeaRB7IEFoE+QfNbeHCxG3NpgFFEjaGvnfgPqxHwwqy1tMFB5HAX+oOy0iikoQzTcBWgm4HoE1SplUR9XwqunkZxzkQeXzbZY1Im/4H+LpL6NwRxytrpGT9U8dZ+THq2m74n+/XwgqcOekADiyuioB+kSlSnSXaudD8s+Rbp3EIqKGaHYiehB2FvC9Hayc8VjBJnGZ+Po4M/9Pk5v/Qw8gpDHap2cdx3XZnhamvfWKBadzzBC7JG6sp8Ep75jQtfUaxLRkLnUCtlE2VfIGZ7GJpZgvH9geHU8gseElBrk+4SPFgjkONmDqO6FYOYUFH5UgbCer5Y8RsBUxqBvMQcbzIxcDBFgutEAQFtXy+pWCW9O1H9EP5LpigrciBwVAyi0PATxYZaXQ82f2jlI6EMcvjF4AJsMUeGYQ3gWcFiGE0GD4Z0cTQYQCfsV8/kg3LZZRvw4SoZ+1zzVaU4jSqRA13ilvkV7HRxi7X7BY4vXZat2PumzqBnn8qxB3mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(6666004)(30864003)(6486002)(86362001)(83380400001)(7696005)(2906002)(66476007)(66946007)(66556008)(186003)(52116002)(498600001)(8676002)(36756003)(4326008)(8936002)(2616005)(956004)(6916009)(1076003)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hmeAekLbt7hJKCvcQXhduJg4ezoVoKm8pEcXvhIicDCkqstoK3tTmCbfHTV?=
 =?us-ascii?Q?0M6m3xn4hO7yP0QasyyW8H9HyGJGmUY+qdJAp3V+Dc0Cs2ExBo+oBqFj+jpz?=
 =?us-ascii?Q?z6x1RO1PaCoGZLv1QbtU9QMe3QleTSR0h7ZjLWDj82z+vwU8ANQrKD8QimA8?=
 =?us-ascii?Q?L/ujZhw39g4r47oFc3F7K5JYIXkamX28ZepWB3cm76q719pSL9HTY89a23Qy?=
 =?us-ascii?Q?KdJmZBM3HjrgB5U2RkhbpQvNTAuxoZgVX+ojf8PL/dnNKz/7h5P2gkVUbCWF?=
 =?us-ascii?Q?oQo464J1Ujz3u8zJfuZd+CREAYEUMxIC9ka318TRYTeMGOdHI7XQbK46CVrK?=
 =?us-ascii?Q?gVPnKUXRv/ydM5Xthww6nLrvvYjGeqeW7mdl8HBFuon94yRJUmWwNm45xgqW?=
 =?us-ascii?Q?o0D6c0KesfPAwiMX4b97VM7HlxeBmVM5fLsXe5NqqXoHmz4bgczzs5jINDoa?=
 =?us-ascii?Q?S/Oun/hB4dnSb5x5KU9HRKYpo9Jlw3/dVHd2zI8kPG8m+6EVVsxpXwBtTPn4?=
 =?us-ascii?Q?oSZxaO9je84UTCr1RTN+AVSPKAieCYukzdkoLnLfMvukfK9TjhGiUOn+JhP5?=
 =?us-ascii?Q?ViCilrAZy/CsoSmxdful9ftO6dEDOaTbjEwIC0/Tmpls8VyP6uhoTmZZx58U?=
 =?us-ascii?Q?zN84ctzVtyPQ30VyNxzqRLmMVwKQPq//3q0HMxAba0uZ4K7acbpz6XDJs+tu?=
 =?us-ascii?Q?4yYVwFn7WE+mNUNuotYc1yZ+tZOvy/XLimjSVzowtGHr55U5n+wzZnJDSz2X?=
 =?us-ascii?Q?/t+Zsi2oQ4mWRsG7X06oBzr86uxlubUoyXGsMiD+QvfLr99Cf71gfeAX5stT?=
 =?us-ascii?Q?/NSCN8E/mlLZFW+BdvCSvohXIbm8gKJiboSPh4QpVs+TtQrUJu4+l5nQKFOf?=
 =?us-ascii?Q?gdwc2Wt7NpuaMYSKmznh8x56+xuzaxz4zEQhN9WheNmIiUjdLxeDzEQeIBjT?=
 =?us-ascii?Q?54/3Wpo29JEUs8W3ccOoxoAFlskLBLQLVwz0DzEveDK+xcW0v997U2+Mvwg4?=
 =?us-ascii?Q?Mr0oziyHNwn5S4xEiJV/zs0QZ+XzRdiRx3Lrjo/OQYK+sVfcquSoQyAtTG0M?=
 =?us-ascii?Q?jogK8Mknh+Z0qI5Vlomeh0mSMl2/3RK6PZN7XM98XutG7nwqtF02cDyKkG5a?=
 =?us-ascii?Q?t2uUsviMeHmw+Dz3Ifgw/04XUq5TGCKgqDkptoNo687BNpfOfu+yXw5wCrXZ?=
 =?us-ascii?Q?dOpsN3cvodhsyKwTV1U9ulTGMn+xLj0SFxOg0cxQ5qq+LXpC1UUZgJ5RZWQF?=
 =?us-ascii?Q?R6D0wRZkvMur3wsAkYIvg49qAA69CC1eWD3C2R4VfBS5GzLCj1PG/JQc+fap?=
 =?us-ascii?Q?O8WvTnPEvTOx8AnovCxBXH+/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c5d9a8-d3dd-4aee-34bb-08d94225249a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 15:29:14.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwXOAQ+yKTIqIFgMhJ45Mtt3KFz7o6uVUHmID7n08PeB4SQ8Z5h2Pyf1+5QzhFiZ0A20vbn0abmELRJKO6x9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On platforms that support multiple backlights, register
each one separately.  This lets us manage them independently
rather than registering a single backlight and applying the
same settings to both.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Does anyone have a multi-eDP board to test this?

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 146 ++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +-
 3 files changed, 82 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 84a1b4bc9bb4..eb5969dc6b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -854,7 +854,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
 			if (dm->backlight_dev)
-				atif->bd = dm->backlight_dev;
+				atif->bd = dm->backlight_dev[0];
 #endif
 		} else {
 			struct drm_encoder *tmp;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index add8a820424a..58995b147dda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2405,6 +2405,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	static const u8 pre_computed_values[] = {
 		50, 51, 52, 53, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 68, 69,
 		71, 72, 74, 75, 77, 79, 81, 82, 84, 86, 88, 90, 92, 94, 96, 98};
+	int i;
 
 	if (!aconnector || !aconnector->dc_link)
 		return;
@@ -2416,7 +2417,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	conn_base = &aconnector->base;
 	adev = drm_to_adev(conn_base->dev);
 	dm = &adev->dm;
-	caps = &dm->backlight_caps;
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (link == dm->backlight_link[i])
+			break;
+	}
+	if (i >= dm->num_of_edps)
+		return;
+	caps = &dm->backlight_caps[i];
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
 	max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
@@ -3416,35 +3423,36 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 
-static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
+static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
+					    int bl_idx)
 {
 #if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps;
 
 	memset(&caps, 0, sizeof(caps));
 
-	if (dm->backlight_caps.caps_valid)
+	if (dm->backlight_caps[bl_idx].caps_valid)
 		return;
 
 	amdgpu_acpi_get_backlight_caps(&caps);
 	if (caps.caps_valid) {
-		dm->backlight_caps.caps_valid = true;
+		dm->backlight_caps[bl_idx].caps_valid = true;
 		if (caps.aux_support)
 			return;
-		dm->backlight_caps.min_input_signal = caps.min_input_signal;
-		dm->backlight_caps.max_input_signal = caps.max_input_signal;
+		dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
+		dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
 	} else {
-		dm->backlight_caps.min_input_signal =
+		dm->backlight_caps[bl_idx].min_input_signal =
 				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-		dm->backlight_caps.max_input_signal =
+		dm->backlight_caps[bl_idx].max_input_signal =
 				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	}
 #else
-	if (dm->backlight_caps.aux_support)
+	if (dm->backlight_caps[bl_idx].aux_support)
 		return;
 
-	dm->backlight_caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	dm->backlight_caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 #endif
 }
 
@@ -3495,41 +3503,31 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 }
 
 static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 int bl_idx,
 					 u32 user_brightness)
 {
 	struct amdgpu_dm_backlight_caps caps;
-	struct dc_link *link[AMDGPU_DM_MAX_NUM_EDP];
-	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
+	struct dc_link *link;
+	u32 brightness;
 	bool rc;
-	int i;
 
-	amdgpu_dm_update_backlight_caps(dm);
-	caps = dm->backlight_caps;
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	caps = dm->backlight_caps[bl_idx];
 
-	for (i = 0; i < dm->num_of_edps; i++) {
-		dm->brightness[i] = user_brightness;
-		brightness[i] = convert_brightness_from_user(&caps, dm->brightness[i]);
-		link[i] = (struct dc_link *)dm->backlight_link[i];
-	}
+	dm->brightness[bl_idx] = user_brightness;
+	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
+	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
 	/* Change brightness based on AUX property */
 	if (caps.aux_support) {
-		for (i = 0; i < dm->num_of_edps; i++) {
-			rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
-				AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-			if (!rc) {
-				DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
-				break;
-			}
-		}
+		rc = dc_link_set_backlight_level_nits(link, true, brightness,
+						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+		if (!rc)
+			DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", bl_idx);
 	} else {
-		for (i = 0; i < dm->num_of_edps; i++) {
-			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
-			if (!rc) {
-				DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", i);
-				break;
-			}
-		}
+		rc = dc_link_set_backlight_level(link, brightness, 0);
+		if (!rc)
+			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
 	}
 
 	return rc ? 0 : 1;
@@ -3538,33 +3536,41 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
+	int i;
 
-	amdgpu_dm_backlight_set_level(dm, bd->props.brightness);
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			break;
+	}
+	if (i >= AMDGPU_DM_MAX_NUM_EDP)
+		i = 0;
+	amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);
 
 	return 0;
 }
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
+static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+					 int bl_idx)
 {
 	struct amdgpu_dm_backlight_caps caps;
+	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
 
-	amdgpu_dm_update_backlight_caps(dm);
-	caps = dm->backlight_caps;
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	caps = dm->backlight_caps[bl_idx];
 
 	if (caps.aux_support) {
-		struct dc_link *link = (struct dc_link *)dm->backlight_link[0];
 		u32 avg, peak;
 		bool rc;
 
 		rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
 		if (!rc)
-			return dm->brightness[0];
+			return dm->brightness[bl_idx];
 		return convert_brightness_to_user(&caps, avg);
 	} else {
-		int ret = dc_link_get_backlight_level(dm->backlight_link[0]);
+		int ret = dc_link_get_backlight_level(link);
 
 		if (ret == DC_ERROR_UNEXPECTED)
-			return dm->brightness[0];
+			return dm->brightness[bl_idx];
 		return convert_brightness_to_user(&caps, ret);
 	}
 }
@@ -3572,8 +3578,15 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
+	int i;
 
-	return amdgpu_dm_backlight_get_level(dm);
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			break;
+	}
+	if (i >= AMDGPU_DM_MAX_NUM_EDP)
+		i = 0;
+	return amdgpu_dm_backlight_get_level(dm, i);
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
@@ -3587,31 +3600,28 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
 {
 	char bl_name[16];
 	struct backlight_properties props = { 0 };
-	int i;
 
-	amdgpu_dm_update_backlight_caps(dm);
-	for (i = 0; i < dm->num_of_edps; i++)
-		dm->brightness[i] = AMDGPU_MAX_BL_LEVEL;
+	amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
+	dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;
 
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
-		 adev_to_drm(dm->adev)->primary->index);
+		 adev_to_drm(dm->adev)->primary->index + dm->num_of_edps);
 
-	dm->backlight_dev = backlight_device_register(bl_name,
-						      adev_to_drm(dm->adev)->dev,
-						      dm,
-						      &amdgpu_dm_backlight_ops,
-						      &props);
+	dm->backlight_dev[dm->num_of_edps] = backlight_device_register(bl_name,
+								       adev_to_drm(dm->adev)->dev,
+								       dm,
+								       &amdgpu_dm_backlight_ops,
+								       &props);
 
-	if (IS_ERR(dm->backlight_dev))
+	if (IS_ERR(dm->backlight_dev[dm->num_of_edps]))
 		DRM_ERROR("DM: Backlight registration failed!\n");
 	else
 		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);
 }
-
 #endif
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -3668,10 +3678,10 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
 		 * DM initialization because not having a backlight control
 		 * is better then a black screen.
 		 */
-		if (!dm->backlight_dev)
+		if (!dm->backlight_dev[dm->num_of_edps])
 			amdgpu_dm_register_backlight_device(dm);
 
-		if (dm->backlight_dev) {
+		if (dm->backlight_dev[dm->num_of_edps]) {
 			dm->backlight_link[dm->num_of_edps] = link;
 			dm->num_of_edps++;
 		}
@@ -6277,6 +6287,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	const struct dc_link *link = aconnector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
+	int i;
 
 	/*
 	 * Call only if mst_mgr was iniitalized before since it's not done
@@ -6287,12 +6298,11 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-
-	if ((link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) &&
-	    link->type != dc_connection_none &&
-	    dm->backlight_dev) {
-		backlight_device_unregister(dm->backlight_dev);
-		dm->backlight_dev = NULL;
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if ((link == dm->backlight_link[i]) && dm->backlight_dev[i]) {
+			backlight_device_unregister(dm->backlight_dev[i]);
+			dm->backlight_dev[i] = NULL;
+		}
 	}
 #endif
 
@@ -9292,8 +9302,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||		\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 	/* restore the backlight level */
-	if (dm->backlight_dev)
-		amdgpu_dm_backlight_set_level(dm, dm->brightness[0]);
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (dm->backlight_dev[i])
+			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+	}
 #endif
 	/*
 	 * send vblank event on all events not handled in flip and
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 57996c364940..4c7ad106353d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -365,13 +365,13 @@ struct amdgpu_display_manager {
 
 	spinlock_t irq_handler_list_table_lock;
 
-	struct backlight_device *backlight_dev;
+	struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];
 
 	const struct dc_link *backlight_link[AMDGPU_DM_MAX_NUM_EDP];
 
 	uint8_t num_of_edps;
 
-	struct amdgpu_dm_backlight_caps backlight_caps;
+	struct amdgpu_dm_backlight_caps backlight_caps[AMDGPU_DM_MAX_NUM_EDP];
 
 	struct mod_freesync *freesync_module;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
