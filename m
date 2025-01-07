Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7D9E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC9410E71E;
	Tue,  7 Jan 2025 15:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ItnrPA+B";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77CF10E718
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdlKqflQygzpaRyrUINuOdWniMYdK867uJILq+tg8FY1v17dUQ9FCwTjy5CUKPKEbsnCqSC4axJse692C6tLPPzWWE0S40M/mEf5Cn93huBniSYHsfMq7YoPQg4PjR1Kbx4GU5TJ3qQJofImEwQNpkwBrbubGJZNmpOPWbh+6tpstClLgOIxDYegPiBopagbzLLpVbwqPZGd7/OF7F7G/woW3HRaI6v0eumJytLdoUVH2z0qNdVf8K26Gk/II/qcOzLqnEFalnhRNzfJQUMiq3cqk6YASLRfgjFNpc4n98+p5oEeTCmiHcBRudGQ+3HElSRCDoNA6PR5/J23slo+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9GINH3YzT+S8+N6HgVIrRf8WAUed2XYVImADBMX1rQ=;
 b=BB5UXRZgg3+WLchEBLx77k8XYrhQe0L+aTLApuCCuZ0ap45Hk0jib+NEkYTWL/tyf8lJdT7q0IvDnk0lyk8ze9FW6F540ZwHVZ+RBYfmL8ZMbFmhMnlxeLnTydL6oI/oSre867JsOwPDpfNlV92wIQoeJzOFYHnKOMfwkrplkiPfwkQKe19ADdylaHNorJjXLP3pjkhJ32ct/e/WAp4NadEHd/nlZivZEXDp5UX+eGJwNyNeQzzNQ7Dkvb4/sZ55DKNVmbvApeHF8mtdhVWfsZ9j3G5CB/K7Pl7u8AIM4mrmFT/w+PvyXk0/Qke9nR/AuYjXlGbSlPxSjw285ekq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9GINH3YzT+S8+N6HgVIrRf8WAUed2XYVImADBMX1rQ=;
 b=ItnrPA+BDRmcA52ZpNjvriVNyym0hyQ4E4zuGLJ6n/q0KrzI9OcqYMQ28ke2rb98NVSJi15FiJWJlu181rNIG//YmWVHXoLq6jmTux70w8Icfu5DcA6SdEffgeCZdbR+z+osP1L58YJDhe73aCT7jYYbsl9ElXxuCG6a2Ylw3Hs=
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 15:29:15 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::7) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 15:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:14 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:10 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Jack Chang
 <jack.chang@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 03/24] drm/amd/display: Add replay desync error count tracking
 and reset functionality
Date: Tue, 7 Jan 2025 23:28:34 +0800
Message-ID: <20250107152855.2953302-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677c9f0-5cab-4810-7eb5-08dd2f300b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kzhfz21IWHYJ/whbnr0vBSzpzJAdIa826buRmtUUmvKE9/Xd6TJ6BEyg3DgD?=
 =?us-ascii?Q?fa6pnzQSBuDDaE6UnvXrhbDvJCqAoyygw5E8u2v6x81pQH48GHA/NDu9Rs2c?=
 =?us-ascii?Q?/4itkDWAhARO+ws3gaEjAVqU2+ObciXpM4jSkbC2k+3p2jwb5bvkIrzF/+gi?=
 =?us-ascii?Q?gEy4JSABiw+WKMV1pAEo6w/DlYBk9D7Akj1o6RB0sTyD7cuwtKvWlqeTWU7P?=
 =?us-ascii?Q?8TTZn234y+f2jfwiik2pki7+J/RG9J+4Wi6nxJChUura9gZbKb5EWjnnsgwf?=
 =?us-ascii?Q?Ys8RR3drsUdAxTbhRDndwWRl+Ig58XVKAYTq3bzKWuFq9UFaS9K+xAZCNef3?=
 =?us-ascii?Q?qxIwPZT7aVgr4nOG8X2XvMUjg18BxxzRGC5xt9EZujCAGad4bq5JSyI7mZ9K?=
 =?us-ascii?Q?PKi+th411AI8fcKdVi+45Sbr4tHztaUW1fIKY9xSdnIUdFq7/ugtt005fT80?=
 =?us-ascii?Q?b2bQe7KczOhNgZmOWDk7Ic2cSA+7+YeQmro63Im0/J2RbG/sWxpWzmBgLtny?=
 =?us-ascii?Q?M790mwRi2+FuNpuHDp8X0jplNOlW8m5TetpaiFpdOwfpu0CBEHMZ0cIS92y/?=
 =?us-ascii?Q?XzyBQwYzri1qCyqnv4pUxPzWxRePTZLxbmodY808GzFtsGR4mPgYarZ5/Dpc?=
 =?us-ascii?Q?Q3d9Btf7zJQ90N5FqMq2/wqygPMOzRCKVMSnO0m5jzxwt/52zIxBtv6yOrIA?=
 =?us-ascii?Q?+MKpIok/KYVrU4CALFv148NkTVaz4q1KaVY9OAvHcqH3LP2agAdDRAnMhioE?=
 =?us-ascii?Q?44lHUrwcqAoLJ5PsGe0T428TKOrjMj8uO1vEdE9DwBuWZhm1QmMpqx2jkrAc?=
 =?us-ascii?Q?FVspkfCAgSDUMiFUfHK81HRVH4EU1g5zOWqJQtIAE9rEDZx31LfqVqb8dKj6?=
 =?us-ascii?Q?eV4RVc89643QJ5zwhVqLKJ7jA67MIU8qlcRhSzhI40Tnc+fxltANvAJWXB3p?=
 =?us-ascii?Q?Bpu+v8bvV71Eub3LXoFQ7dbjOpPHCt/rrTyxswfpTWrwttYZsrHuaomvBcyA?=
 =?us-ascii?Q?Us0cSm29Y9E+A3j8NjoCGOWf5eW101bxRWt0EIsVYkUtXVHdGeIXBZ6NgGqH?=
 =?us-ascii?Q?O2qh7mNNcMbrLiuycuJJGlWbsq89PC5C/q0HOK9d5EDQoKtxd40EeHEwOKeQ?=
 =?us-ascii?Q?ArBx4OVKQlGO9I4RrlYof++ahiM/Ee7Mvqe+0jdoURQDxsLjkL2ymz0EzxP8?=
 =?us-ascii?Q?h5sy4+SOFYhfp9fEIBYc/mhXxcatE71ydMPxYEG9D7wjlh7GxObmp4AZ3k6u?=
 =?us-ascii?Q?hg5F5p9Ht9jA/iEktOdinmOJhp0JQcvEv6iMXFntYjQS3EEsM30Izok36la/?=
 =?us-ascii?Q?Twpeu9IRgQnHR40W3qgGyt3BYOGXdYweCCLwR+c6yXdRjyAcdW8kV7hmaY9+?=
 =?us-ascii?Q?qMIIDzbXpqL35axCJb1jVNL4JQukrce5Udmov0QmJQLdy7QzfQDThQUd71xF?=
 =?us-ascii?Q?4jYWf5D4fHCqjE3b0K06zqeDP+iMT329N/8sZMiew9vcaD2tnKTnClBDZVeu?=
 =?us-ascii?Q?L2CMJMWEZLbNPYs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:15.0326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677c9f0-5cab-4810-7eb5-08dd2f300b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
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

From: Jack Chang <jack.chang@amd.com>

[Why & How]
Build-up get/reset desync error count interface and implement the functions.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                    | 2 ++
 .../drm/amd/display/dc/link/protocols/link_dp_irq_handler.c  | 3 +++
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c    | 5 +++++
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h    | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index ff5b162f3916..0aef2d84c3a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1147,6 +1147,8 @@ struct replay_settings {
 	uint16_t abm_with_ips_on_full_screen_video_pseudo_vtotal;
 	/* Replay last pseudo vtotal set to DMUB */
 	uint16_t last_pseudo_vtotal;
+	/* Replay desync error */
+	uint32_t replay_desync_error_fail_count;
 };
 
 /* To split out "global" and "per-panel" config settings.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index ae47bb5975af..a08403c022ea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -239,6 +239,9 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 			&replay_configuration.raw,
 			sizeof(replay_configuration.raw));
 
+		/* Update desync error counter */
+		link->replay_settings.replay_desync_error_fail_count++;
+
 		/* Acknowledge and clear error bits */
 		dm_helpers_dp_write_dpcd(
 			link->ctx,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 95838c7ab054..f4b86a63f25d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -1039,3 +1039,8 @@ bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_back
 	memcpy(caps->data_points, custom_backlight_profiles[config_no].data_points, data_points_size);
 	return true;
 }
+
+void reset_replay_dsync_error_count(struct dc_link *link)
+{
+	link->replay_settings.replay_desync_error_fail_count = 0;
+}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index cac302e8fa10..94ade0ef18a3 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -78,4 +78,5 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 
 bool fill_custom_backlight_caps(unsigned int config_no,
 		struct dm_acpi_atif_backlight_caps *caps);
+void reset_replay_dsync_error_count(struct dc_link *link);
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.34.1

