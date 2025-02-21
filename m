Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD79C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F1B10EB04;
	Fri, 21 Feb 2025 17:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y1dokg5H";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F9510EB04
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqlFa8KVYICS2qFuaNJv2XhggOaZgrvnO9Uj3STW3JXsS743OjKQbv6VRC1s/oWg71SkGSnlWdkZbdnBDpdB0+OpmCP+nDw11mAU+AecuL3dIOIL01AWoP0UVFkBB6nMuj2OEVBMURBsaN6Ow3NWOu+5K0LulWoWLeOsiXYOrf6oT9jBY9pPSSMlNd85czHrZrES97l1DqeB9hQsxjUUsi0DddJbM+2Snxe0CrhVI+n2apJmjHkW2mC2vYFQns2hxbB6P8E5NKrutxW91OzHCu3jhbumSw29qRA84HIE2FUwmdyfpJMybuSHwmRm2NCJ8KXp5UBEdyZhoGaf4hf3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYyvQBOtPZn2Q9c2jPoe7AY6bQwY7Au3Qr8NZ0Iglk8=;
 b=JBYde4F/2lhJVZ3TJsGLdOin8XIUM3AFqzCmQUwFxCI6RaMZkDA+DNhYVO7ef70gsgFFConTiTXWhvIpvdUUDv+fWWfVzBwS1dgqgZ/LDcApyGtz3PU+GsQZvAkMetlgwiljwZmhOAG3bsvznTzYLMNgkmzOR4LzYvXg6AkecHWkfd9Sdc7Nk1cD7OBzNXCNYcItys5XhYJ9tg5g3Q4lrq6A4AnL6u/bRtmQ8rEZS2KNExZ3Z1/9E+I9Gn9zU61OE+sLFb/K1TOmqPTJ+p3vIQ1TU3PA6dqs9wt1m6cU72sWFZnoNeSFPR7+cn+DBJLzeT+4QPdcecepPv7ZyHKMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYyvQBOtPZn2Q9c2jPoe7AY6bQwY7Au3Qr8NZ0Iglk8=;
 b=y1dokg5HyKITQRuwTar/OEI+fTz2LCHhP5BiULAMoa7pm56JdEZpImF5BwJD9ZlZhuVfodl/Y4hEJG4HMdGnDDrRQFPtWe0UNiWugzZShUBYFA2CTv6J5RqzlcEL/PQcCd8bXmdmmmIxJ8XWKxJEZRC6zWt2l21ulc/tjVqph/I=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 17:10:17 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::37) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 17:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:10:17 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:10:16 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 2/5] drm/amd: Pass luminance data to amdgpu_dm_backlight_caps
Date: Fri, 21 Feb 2025 11:09:59 -0600
Message-ID: <20250221171002.209895-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221171002.209895-1-mario.limonciello@amd.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 3caddc53-7579-4986-b521-08dd529a9d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8OpbIUo3kAAgmYa/I6CqODIE21zvLpJjof8svg4r3bIcka86kWKJno7JWtwE?=
 =?us-ascii?Q?8ou9UfNAu5/dp8YbC8KpnXGxFZcIJJkulMPQs/k/FXweg6OXp1C6SIqa1anP?=
 =?us-ascii?Q?TnbluSCOoLSWoiZPC/oN3ZD3Ly5ht8qi9p0Mf/f3SMQGqyyU7/xv+SAvcoKB?=
 =?us-ascii?Q?MWzHP/gf8xsLMeBH4U7D/lTEiS+I1lKwYPC6bwd+CS+lXXbj2cJUWilg0e9A?=
 =?us-ascii?Q?Ia3C31cxBia3oz7DbzIGHRbN6KWSE2zUn0eAmjYKT/dw3vuRvEOdDeVBOmGr?=
 =?us-ascii?Q?IwjOf9V/SCb/wrZeiP2MI8KQCyD8d9TFQfZSZU3DF+RnAN3kFFKc7Rj25YC8?=
 =?us-ascii?Q?hY1AUT2vPA48vRW0nSwnT0mcwEEKpQyPUVMxjSbwM0kLeF1bMKJG4ohC8B+g?=
 =?us-ascii?Q?qPACkAx27Eb2RB55XRnLBoj2ODNhpikg79LzAtakB10HqKYgWGRONyqjoyz6?=
 =?us-ascii?Q?5Gi7QmFc7SdkXUIpXMKOYD0HQOTU97xDodGuWEFrOYDbjJUqcJS3W1e+QIM6?=
 =?us-ascii?Q?kQtn8FL1BE0CHo7BXe5Owi7fEoOnA6dniupaHszQ1HtOH+yS75f0l5XSPNH9?=
 =?us-ascii?Q?CCjZIpw+u7Vu7mYF2vcx3A3sItRo1j0n1uodLn0kLD7b0vlrV+JRz9CdD6WB?=
 =?us-ascii?Q?YL2186wamS7NW+qddk0IMW0G2NWtIj7aYtOTiVd8yTK1jAJxQiKiTK2yQesl?=
 =?us-ascii?Q?Oe91t+v2NZEusG1ADgRKOM9iAnXZZAAQa9Kt8xUFQ1VvjpiR+1izeFaz84WW?=
 =?us-ascii?Q?um2WAUwO3OLFQ3opmeC3LmS1dZDVADOCufVyBE/QM989oAu8Ha8EMfl4FRCh?=
 =?us-ascii?Q?IxD33bXm4xw+i0wVQcDKlRnQMqYQ85F50mjWRey/+VrosRPaBUcr8ZT/OaRr?=
 =?us-ascii?Q?lXgd8Llc+gEntprysVIrSpl4JTZQHhV12XdH/db1Fd+WDWA314ahk46YwTWl?=
 =?us-ascii?Q?mgGhN/rwmZTzrwBIFoSkUWW/mxK/ZfgXLjfsRpBdB8UBLfqbyclk73pVxbNy?=
 =?us-ascii?Q?WGP0yFlPeggPbthEgDzPd68uOfWynpPsAcihuTHS+In9XNv42Zc7hasiplaS?=
 =?us-ascii?Q?0J7+CGxuoLTwrfRktRjfjhZAbC2YhAi//CCFJwTgoJvrUxIDM6ddREYnlm2c?=
 =?us-ascii?Q?iibcZZEFRcmd0KVjamlSHVYxJVjAPOTscEPKRc4OGK+91olaTy1/tXR955r2?=
 =?us-ascii?Q?9ZBl/vRiiLZ62COdZkV5SSeqrLyXZxDIHjxdsSgdb/3cqTbETTgHFM9vUnyx?=
 =?us-ascii?Q?ZLztMsdtKavf1/s7MjKmskvlH/Lg5otX+wQWxblk1ybo8H/epm9WY+Mqg7Nq?=
 =?us-ascii?Q?gxg/cZb4HQlGCdhXXC8oyiXPEm3DWNMhSnxwzcVsmh03xvkYR1PAHWgjJHfO?=
 =?us-ascii?Q?808RrtDkwLwMkmgsSeV1Wtf292hV1fWXaHez5UqU0T3Kc4RApOFPl3ExfdEh?=
 =?us-ascii?Q?ZnGXwY50wUHVIam9mLp11C9hYco33CQOYjDiZLw0CpbI4wPGNM6NhrnBGOfX?=
 =?us-ascii?Q?5cr5qgr9rXG+tCM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:10:17.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caddc53-7579-4986-b521-08dd529a9d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ATIF method on some systems will provide a backlight curve. Pass
this curve into amdgpu_dm add it to the structures.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  4 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_acpi.h        |  9 +--------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 515c6f32448d..b7f8f2ff143d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -394,6 +394,10 @@ static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
 			characteristics.max_input_signal;
 	atif->backlight_caps.ac_level = characteristics.ac_level;
 	atif->backlight_caps.dc_level = characteristics.dc_level;
+	atif->backlight_caps.data_points = characteristics.number_of_points;
+	memcpy(atif->backlight_caps.luminance_data,
+	       characteristics.data_points,
+	       sizeof(atif->backlight_caps.luminance_data));
 out:
 	kfree(info);
 	return err;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f3bc00e587ad..85b64c457ed6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -151,6 +151,18 @@ struct idle_workqueue {
 	bool running;
 };
 
+#define MAX_LUMINANCE_DATA_POINTS 99
+
+/**
+ * struct amdgpu_dm_luminance_data - Custom luminance data
+ * @luminance: Luminance in percent
+ * @input_signal: Input signal in range 0-255
+ */
+struct amdgpu_dm_luminance_data {
+	u8 luminance;
+	u8 input_signal;
+} __packed;
+
 /**
  * struct amdgpu_dm_backlight_caps - Information about backlight
  *
@@ -195,6 +207,14 @@ struct amdgpu_dm_backlight_caps {
 	 * @dc_level: the default brightness if booted on DC
 	 */
 	u8 dc_level;
+	/**
+	 * @data_points: the number of custom luminance data points
+	 */
+	u8 data_points;
+	/**
+	 * @luminance_data: custom luminance data
+	 */
+	struct amdgpu_dm_luminance_data luminance_data[MAX_LUMINANCE_DATA_POINTS];
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd/include/amd_acpi.h
index 2d089d30518f..63713fdca428 100644
--- a/drivers/gpu/drm/amd/include/amd_acpi.h
+++ b/drivers/gpu/drm/amd/include/amd_acpi.h
@@ -57,13 +57,6 @@ struct atif_qbtc_arguments {
 	u8 requested_display;	/* which display is requested */
 } __packed;
 
-#define ATIF_QBTC_MAX_DATA_POINTS 99
-
-struct atif_qbtc_data_point {
-	u8 luminance;		/* luminance in percent */
-	u8 ipnut_signal;	/* input signal in range 0-255 */
-} __packed;
-
 struct atif_qbtc_output {
 	u16 size;		/* structure size in bytes (includes size field) */
 	u16 flags;		/* all zeroes */
@@ -73,7 +66,7 @@ struct atif_qbtc_output {
 	u8 min_input_signal;	/* max input signal in range 0-255 */
 	u8 max_input_signal;	/* min input signal in range 0-255 */
 	u8 number_of_points;	/* number of data points */
-	struct atif_qbtc_data_point data_points[ATIF_QBTC_MAX_DATA_POINTS];
+	struct amdgpu_dm_luminance_data data_points[MAX_LUMINANCE_DATA_POINTS];
 } __packed;
 
 #define ATIF_NOTIFY_MASK	0x3
-- 
2.48.1

