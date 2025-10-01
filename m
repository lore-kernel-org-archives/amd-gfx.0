Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462F9CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 21:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FB310E27C;
	Wed,  1 Oct 2025 21:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3TMCPFpv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83FB10E27C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 21:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpyOeTIdJjI9EMd/G4RbzufewI60kRv7OOyWV3f6Vm177m82ILhfHH5RMKXdn7LPc4b7TTGvqhPOF7vwA9ytAzRGgGo0j2geVKCquWhvtvcV6S+zljSWwIkOPzw/cEnSTFe6uwOQ2qWjDFedoG/0NSfD2kbu6a9t6XiMVpoB+rJdi4AkfKtlvvhgvEmT7eVAw3CPycBoZXZZkm3mFoB3WEpeXRHofn5pKfXsEMSYU6u5QTn99RYqkG6UevkEHZ29VJSUKhUpmDaRW7j7/WqnCWXNc5meYcTbxThnJaFfrIODwyNQ4vVyPduPbf/SrJvfx1x5PH7Q6CfGUM4b6Xcy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbnE3/38MyyL/XESXcjYh1ermTfXg+vNxfqbakwgBQg=;
 b=jnx7fbP9u0obdI+I5KztfkC34JpwiTqmODKMd1+SrxV4hDJ/e4s1A39rFqbH5OoK6/DyR0p7LmD56bMxqmS145AbNgCXhP7tACW6KHs1EbOyUps6LBO3iGywcbKS8yFdyXcZYxAzYbaLeyFCVhYzUHl4pPWQ244rtI6t75ORoAXeeVyKVJHEputlPQ1OASJghVTgYo+ckbn9YMSmu/vl8GcfMXtryS7rb4EK+CX8WGLjLjDUSCFhy1/YTqBT5ekqWyFsXd6eoo4Te1R9lWXxEdxVxv4NeEr1gEeTVuAa9WlRxdtE04EMwJms5OF25Ppewmar0kwUZiwphUBrc8aXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbnE3/38MyyL/XESXcjYh1ermTfXg+vNxfqbakwgBQg=;
 b=3TMCPFpvJAYGDb6cHhQjiEcqKKUityypdzU/6AFYFFJjORAEUz3yAcuJhHRf21NKVgf+YD6XBdZAjU9a4hK6+gh24jvYNBqZ0FsebiV+OCkt+bALrmJN9pgS42kvAkeiY0x1t1cRQvGvOMDjFFnWaUN6+a89LxZwGjWhWQoVt5M=
Received: from SA0PR12CA0005.namprd12.prod.outlook.com (2603:10b6:806:6f::10)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 21:28:43 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::d6) by SA0PR12CA0005.outlook.office365.com
 (2603:10b6:806:6f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 21:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:28:43 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:28:41 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 6/7] drm/amd/display: [FW Promotion] Release 0.1.30.0
Date: Wed, 1 Oct 2025 15:24:11 -0600
Message-ID: <20251001212700.1458245-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c8c31c-0104-4f61-9b3a-08de01317f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uWp4tA76XXi1p2IdgpAcq2Yaw/RBtmGn900iQJ3Ev84srEk/ONB9a36rayJM?=
 =?us-ascii?Q?PsQ1buE9SvA72bVSeDK4yuvg6tT0VjTvGiBQtMks6wOWczSs8meBP5KtZtKr?=
 =?us-ascii?Q?4mNdNQ9FVn2jvlsNTiz2FB2iUt06cd5yERMrgxATTq1r0GekbVD9A2gRCZgy?=
 =?us-ascii?Q?weKcSAG6lWhSuZA+y/p/afmFOx+79JS4VykEBYZM6WgdRoeO9po8+4lxQLOj?=
 =?us-ascii?Q?Tmon8PyuJIq3wEqsQp26e3Nb1YTUhxudXBKrkyD98BZU4UvPI7p+q7b+ckH0?=
 =?us-ascii?Q?znjD7e8V76Cd8BFfgi4IsxUqk2EmL1JtH7sX7B9KIUVEWTFlXLCCOkBb7tkR?=
 =?us-ascii?Q?ZWI9gocc7ThmgvkOMUD282YPkV3k1Z15Dn35fKenpzoyZxh06+x5TvToP5tc?=
 =?us-ascii?Q?hyHdXN0vul+y2mPOfY+XSU3QSb0ZAk9uMQcM0zv5xhUZPUQuJ55cx+w9pmz4?=
 =?us-ascii?Q?ZizEIh+H3FByiUXpyLPbYE2vPcWuYwEH6q6syuwztEjp5qRZkX4HVfceaCHu?=
 =?us-ascii?Q?FJnIjL0xuvlKtuXqt36kaiO+ABiyzb/yTRvZkNYXUgAsLhbH0526bwXKTjqd?=
 =?us-ascii?Q?JjCWroI0kYiITBbd0VKc5nQ0H+sg6exjaFqmZLVAzvZ39PEA+0sM8pMRDZwc?=
 =?us-ascii?Q?CwFKrX3OEdZbnvEY+927/okhyNmZyu5wpp4FqfBJkUChfez0tGDIGxTET7Ez?=
 =?us-ascii?Q?dJKmRsEwmDN2Kno0bx6bJ4AboZibHWxRjYyWIK6TQSPu/twzd5y2yD5XpRMG?=
 =?us-ascii?Q?4rOAtoRYHSC+oMgnZWLLRA24KgNiuuDL8Dox5qlCqNknUzj7yGOiE+xHI7Dj?=
 =?us-ascii?Q?pjMMCx2TiIS63vqgbuGKScnQ2/weu1Pu6STJZt/eBuPMRR5lebcl/eYougJB?=
 =?us-ascii?Q?YwKvJHPs3xRL9oo+QGMkkFI07nC+6rVKfMcfOIrB3FHEpUv4AmtjwhscKvrh?=
 =?us-ascii?Q?i4+muz5DuVSwPIcZ0qwK6Jvy2V13hcRTJlevXCx8mTKstvj0cjp7RV+/vXbB?=
 =?us-ascii?Q?DLW/+DlgumMhC56PlPCE4rnyszXNxaQj+QDQ6Mc+AbjxgHp2FOkTmazCvfnv?=
 =?us-ascii?Q?buUMhpfcNwFbpqFkY5pKRzJYbMD+G3mzffNZDBpyBvs1hS62lzCqYSfKWRuj?=
 =?us-ascii?Q?fJSVHBn4qKW5I3Ds2Yxn3f3NSFZA9H4Av0ANK4C0NrEQQuVPLNLxGoJIt36T?=
 =?us-ascii?Q?HtLVWxMfMAHwnIzbpErZ/uEqlDc5fnXxUx5KLJP7zddXmcpiDGJmVFn7ACg3?=
 =?us-ascii?Q?GiwLsUZzgHas4iBetSgfbmdXfNqGiIRfM7vo2LU1U/adD3zL6kaqwxPT6XVj?=
 =?us-ascii?Q?OgUDUr3m8QfDinHb7cfwbAVAJPop/3p4daa90HYmO5HuPf4QC5RqFK07Tggk?=
 =?us-ascii?Q?IrSyVkbcyK7lLrtVA0GhvvgZEHZFgduhq789bWs0seFlwYF9Ud9fTCap/0oI?=
 =?us-ascii?Q?y2euSD7/HCQ31CvPGbnbyG/1iRpkyuW/ZSXCQbYq1eLGIRxIW6iQdw8kf1qZ?=
 =?us-ascii?Q?Y7g+K+/G0hRl22tK/D71sqc0Z3nYKAtdlDsX75bmCZXVp5JylkyyDe79xNJN?=
 =?us-ascii?Q?rNF98Zmed09MKApjQOA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:28:43.1808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c8c31c-0104-4f61-9b3a-08de01317f35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Add new SMART_POWER_HDR commands.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9d2a02bd00e2..5df050a90634 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1724,6 +1724,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD = 92,
 
+	/**
+	 * Command type used for all SMART_POWER_HDR commands.
+	 */
+	DMUB_CMD__SMART_POWER_HDR = 93,
+
 	/**
 	 * Command type use for VBIOS shared commands.
 	 */
@@ -4392,6 +4397,45 @@ enum replay_enable {
 	REPLAY_ENABLE				= 1,
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__SMART_POWER_HDR_ENABLE command.
+ */
+struct dmub_rb_cmd_smart_power_hdr_enable_data {
+	/**
+	 * SMART_POWER_HDR enable or disable.
+	 */
+	uint8_t enable;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+
+	uint16_t peak_nits;
+	/**
+	 * OTG HW instance.
+	 */
+	uint8_t otg_inst;
+	/**
+	 * DIG FE HW instance.
+	 */
+	uint8_t digfe_inst;
+	/**
+	 * DIG BE HW instance.
+	 */
+	uint8_t digbe_inst;
+	uint8_t debugcontrol;
+	/*
+	 * vertical interrupt trigger line
+	 */
+	uint32_t triggerline;
+
+	uint16_t fixed_max_cll;
+
+	uint8_t pad[2];
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__REPLAY_ENABLE command.
  */
@@ -4737,6 +4781,58 @@ union dmub_replay_cmd_set {
 	struct dmub_cmd_replay_set_general_cmd_data set_general_cmd_data;
 };
 
+/**
+ * SMART POWER HDR command sub-types.
+ */
+enum dmub_cmd_smart_power_hdr_type {
+
+	/**
+	 * Enable/Disable SMART_POWER_HDR.
+	 */
+	DMUB_CMD__SMART_POWER_HDR_ENABLE = 1,
+	/**
+	 * Get current MaxCLL value if SMART POWER HDR is enabled.
+	 */
+	DMUB_CMD__SMART_POWER_HDR_GETMAXCLL = 2,
+};
+
+/**
+ * Definition of a DMUB_CMD__SMART_POWER_HDR command.
+ */
+struct dmub_rb_cmd_smart_power_hdr_enable {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	struct dmub_rb_cmd_smart_power_hdr_enable_data data;
+};
+
+struct dmub_cmd_smart_power_hdr_getmaxcll_input {
+	uint8_t panel_inst;
+	uint8_t pad[3];
+};
+
+struct dmub_cmd_smart_power_hdr_getmaxcll_output {
+	uint16_t current_max_cll;
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__SMART_POWER_HDR command.
+ */
+struct dmub_rb_cmd_smart_power_hdr_getmaxcll {
+	struct dmub_cmd_header header; /**< Command header */
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__SMART_POWER_HDR_GETMAXCLL command.
+	 */
+	union dmub_cmd_smart_power_hdr_getmaxcll_data {
+		struct dmub_cmd_smart_power_hdr_getmaxcll_input input; /**< Input */
+		struct dmub_cmd_smart_power_hdr_getmaxcll_output output; /**< Output */
+		uint32_t output_raw; /**< Raw data output */
+	} data;
+};
+
 /**
  * Set of HW components that can be locked.
  *
@@ -6606,6 +6702,14 @@ union dmub_rb_cmd {
 	 * - DMUB_CMD__CURSOR_OFFLOAD_STREAM_UPDATE_DRR
 	 */
 	struct dmub_rb_cmd_cursor_offload_stream_cntl cursor_offload_stream_ctnl;
+	/**
+	 * Definition of a DMUB_CMD__SMART_POWER_HDR_ENABLE command.
+	 */
+	struct dmub_rb_cmd_smart_power_hdr_enable smart_power_hdr_enable;
+	/**
+	 * Definition of a DMUB_CMD__DMUB_CMD__SMART_POWER_HDR_GETMAXCLL command.
+	 */
+	struct dmub_rb_cmd_smart_power_hdr_getmaxcll smart_power_hdr_getmaxcll;
 };
 
 /**
-- 
2.43.0

