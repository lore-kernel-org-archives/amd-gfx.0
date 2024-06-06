Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3124C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D7510EAF2;
	Thu,  6 Jun 2024 21:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IkHn/cTj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC7710EAF4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv2cikC0sGy12TjByg3Tsnv6MdHOPcS7vngu4EaMazfw+F1OeS5rkEgElZQYtkJuCUSZLqGkTshVCOvDoY/PWjBnzg0IWnSRf4F+PXAWFM68v+Iy5VUmuNsHD72tFavtdOh/Tb39tRw+3FCHAyEUF0XBc0Sa6gUskoSUQP4ZcqT9UYhQKgGa1/aHKc5W7PS/aR2Ymn+9p0w1NyJpX1yhe1cjffIu4l9Y9vei6xV45G/UV3PIKWljljtQN1gekycReIXXaLvwN9gTnHX71Ok3QLCQN2FM5Z+nRFv5s5NW+LeXgfb9eC9Oth14hdHEdqgvIngo53FGLklX97FKTktdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68ythT8E9eheRMG3vyfmFOLniU4pc5z4I1lOzJP6RCg=;
 b=j3Gpyta9P2QsnyqFtGt53kBSovd0o1gKgC8wbZwNtKxm7K4x/P1aToeAGFodXkj8FMvCjArN4e+Wc0d/mnddPnSNxk+zEMUV8zBfiJwkdAUbgfJlFHjv3m0n4td9KpFqeEYhq+x8lBSU3wPMLtUmC1Ge5wgVOm7eOTCLdmsqpQJblXyuKl+uai+ZzmQc3UWVaUvy+Ftqz78Ylo1gGKxwfKcJV6VlhPkQMKCK4OZTa3/QeC+L4x7rlnM4DM169NfX8yty1B10CMmX7qMLfUcP4bXxQBh644boUJJZi4AOwHanZdAng3fbM3geUcq2Qkv4VqDwGCDPYBBUJwiZb3gemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68ythT8E9eheRMG3vyfmFOLniU4pc5z4I1lOzJP6RCg=;
 b=IkHn/cTjRChIkg5eoFUcvx2NDdReKPFlKkBqWjUu9jazyyTqDv5SjQ1osw9VSHpnkZGVqSd8ZP35ppXFP9Obgq2HNY9u5mixv9dSUfoROceHwBWrwny0ShD1Z5EHwLeTQpDjGDEM1HMjOFWY+Hk++IviIFCRiPQ6SWfB9K/Fmxw=
Received: from BLAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:32b::21)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 6 Jun
 2024 21:57:54 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::e2) by BLAPR03CA0016.outlook.office365.com
 (2603:10b6:208:32b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:54 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:52 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Josip Pavic <josip.pavic@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 39/67] drm/amd/display: define abm debug interface
Date: Thu, 6 Jun 2024 17:56:04 -0400
Message-ID: <20240606215632.4061204-40-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4998c28d-6846-4375-727f-08dc8673b7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BCFjsX9KIVmluSBIhxVq/S5CDcDCZ5q6L5v3NCgdkb7/B1hcY575+v9NQj4G?=
 =?us-ascii?Q?1OgIyQPQV3dQPL3Ifu+Zy17Im1/YsbbCDJB0lmJD5G7sVVag6UGdNrM1GMED?=
 =?us-ascii?Q?uwiDsYpxeZYhrbeZGGFC6NJZLcwuZMzva+Sdz6NSTZw84I/SosrywG+d1QiI?=
 =?us-ascii?Q?9EjYcZ7oph4ManzFXck3WDJcbFAocQb1MG1ImkUDp43xSMEsl7YUdenkLUA/?=
 =?us-ascii?Q?SIF6HKZTwUg+yXCYHG+HGnreAE00EsKe1PXIGNNrFbE/qjQ94q/ufv2KQSCg?=
 =?us-ascii?Q?1e1uj0JfTMZNK48UnhwmTEOxouFggnOpyPQ/mjw0lI2Gd0Im9+MWfoqsj9t2?=
 =?us-ascii?Q?Th+/eWRGPchZXo/1nhFOqowyJa0m7w3+t6XoITG6YXC6X3/wWfbtuomngHMB?=
 =?us-ascii?Q?W3nKVukc8dHLn5yZojE3lCHRGeh67F+YcPAaC45Hq1JzblsLx188C2RTBC8d?=
 =?us-ascii?Q?An5MAHKwg9G1LZhdky9a51pUKfgLFIwpZWlJ6McnsMeJj60AATYIu2jxdJCM?=
 =?us-ascii?Q?Y8oVb79GeIvRUCeuW2HFkBE7L2L/L0bksHtUBmBS0j6OrerlruvJdsKBa4B+?=
 =?us-ascii?Q?rX3oKB6p1+7vNd4cTTgd+EruuvHValPveK/3Wap2QyfBtb7bVOIuPtFrp+ME?=
 =?us-ascii?Q?cwabLmJSH2ZCNudQq/8GT3+ftps6N+TnEONBJ4TRvBfgP9TLqXWBRx2uMbLi?=
 =?us-ascii?Q?HpggcozZOUsSsCBMScwAgv85o6e98GSGrG6BW7CUJUvTqBKkrwGaLy8XlM4P?=
 =?us-ascii?Q?Bw1OcxDSkVeFYIShFhFjz7VYYum+GQOIvZI5D8W6AKvpugnVJyRh3BrrYe4S?=
 =?us-ascii?Q?U/vSmTYj1DosDyDWzEzToQp2WXMJDwX2mTG8YEH98Ho04JDQ66zFhLKiHFAs?=
 =?us-ascii?Q?DQotBW8MydZ4xrEga5QSxER0KFuY1431khYc+l7xGS2rxLYu32Z0DOik/eAp?=
 =?us-ascii?Q?8V4GdxzQBHWgez+1fS9LgKrP++PWOkEMGmEWdHbSvw6eo69FdqpETMUXCrOG?=
 =?us-ascii?Q?pVCeBvYtXmaeuFx1DGs6kDaXwk/z5tAx9QEj8joSfndhgFjK1SdM7H5swD8R?=
 =?us-ascii?Q?4KhIPFsNvaQK2ub+tw38GZDj159h5365Qgy5jek7D4j5PWZU3lOHE/MZDM8q?=
 =?us-ascii?Q?MdrwTqHn/ZunDpL1kAzTjUpaHYixoqyyeKFz5xTPd+PcWL+oJ9k+uWAGK04O?=
 =?us-ascii?Q?WFrwGHTbTwxFC5k9QlhlxfzA9LjHnUFyMwtX4AcNphKNkEIoZmeMefn0iDVY?=
 =?us-ascii?Q?xSIDjgAVTmbs19epZ1XQf7sjmeN6kis6voLmst2jatvVRV6tyhfqKgeyrMqH?=
 =?us-ascii?Q?6P6ruVoW2ilnvqklQ5jcURv6pkrKudzZ28j0C+auCs2NQy53LWUQAGlSHxhc?=
 =?us-ascii?Q?zXtJpoqOA7i25kvV5xhsoGjH5M8XPuYN1hQCCUs/ihHrVXNLRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:54.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4998c28d-6846-4375-727f-08dc8673b7d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

From: Josip Pavic <josip.pavic@amd.com>

[Why & How]
Define debug interface to dmub for reading back abm data.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7fea9bec7b64..87f2e4e38f9a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3960,6 +3960,11 @@ enum dmub_cmd_abm_type {
 	 * Set ABM Events
 	 */
 	DMUB_CMD__ABM_SET_EVENT	= 9,
+
+	/**
+	 * Get the current ACE curve.
+	 */
+	DMUB_CMD__ABM_GET_ACE_CURVE = 10,
 };
 
 struct abm_ace_curve {
@@ -4488,6 +4493,55 @@ struct dmub_rb_cmd_abm_query_caps {
 	} data;
 };
 
+/**
+ * enum dmub_abm_ace_curve_type - ACE curve type.
+ */
+enum dmub_abm_ace_curve_type {
+	/**
+	 * ACE curve as defined by the SW layer.
+	 */
+	ABM_ACE_CURVE_TYPE__SW = 0,
+	/**
+	 * ACE curve as defined by the SW to HW translation interface layer.
+	 */
+	ABM_ACE_CURVE_TYPE__SW_IF = 1,
+};
+
+/**
+ * Definition of a DMUB_CMD__ABM_GET_ACE_CURVE command.
+ */
+struct dmub_rb_cmd_abm_get_ace_curve {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Address where ACE curve should be copied.
+	 */
+	union dmub_addr dest;
+
+	/**
+	 * Type of ACE curve being queried.
+	 */
+	enum dmub_abm_ace_curve_type ace_type;
+
+	/**
+	 * Indirect buffer length.
+	 */
+	uint16_t bytes;
+
+	/**
+	 * eDP panel instance.
+	 */
+	uint8_t panel_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad;
+};
+
 /**
  * Definition of a DMUB_CMD__ABM_SAVE_RESTORE command.
  */
@@ -4521,6 +4575,7 @@ struct dmub_rb_cmd_abm_save_restore {
 /**
  * Data passed from driver to FW in a DMUB_CMD__ABM_SET_EVENT command.
  */
+
 struct dmub_cmd_abm_set_event_data {
 
 	/**
@@ -5102,6 +5157,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_abm_query_caps abm_query_caps;
 
+	/**
+	 * Definition of a DMUB_CMD__ABM_GET_ACE_CURVE command.
+	 */
+	struct dmub_rb_cmd_abm_get_ace_curve abm_get_ace_curve;
+
 	/**
 	 * Definition of a DMUB_CMD__ABM_SET_EVENT command.
 	 */
-- 
2.34.1

