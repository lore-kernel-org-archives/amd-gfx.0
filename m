Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79E5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D93B1130DC;
	Wed,  1 May 2024 07:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SkFpea31";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AE21130DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6a0VgdUDlI7so2MyaKWUZbM4eZYQ2cMuSwRKw8T3/kfjKytaeDtwDJs5Sf4VOhw3APsUL9WlE2lKrRjZqRcoodF1f+YyxOYVhSmdDvMwx4beoKganorq9gWUB0GJVAa86Vu7mq5cTGXs+dJhFmC+mL7DYLQKPPCWiPYj4v+Q/J4Y7cCVJEXqQC8lkAYoyJGoj19Zty+HFGtyWmMEOLs3I7juf0rXwNV5L/yrP3QHOF08mkBh7LLRrQpOMu0kYYjs9pyjuHEbAgpXy9OoqEPVbSkZUtTPkNDSX3+4OOSVudFnDnQy3osjQvkergy+JZANsFbSgPg9TVTpPzcputJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxkAErdR1S4yNFfji+7HL45SUX4Ln0GVrqyOnqJCgw8=;
 b=PJD+XLNLH3ilz7BWAyyTuLL+7BIHge64ik4sKRSSlZXnD55OcsT+ErLhtlGRhhn1/wpb/LkW+QYA7FX+838xKIiQx16SnYxsE285aJTOvJPT7HAs+ftejIB+bej0hrpixqOK79VNXlnVf9whBYqLE0nXQ7DopPvLp1/XSlcAW5nDbvOwehNTafkoeBlX6oV/W7yZFRsYnQXoYJDCiiiaJlUtxNfgLpVU3bPM0GFtlBlk7rps53PzdriZem02jgXBtuWXRocirDeJEj0tprdrL7fRssr1oEdZeJ5kSkEr3z22E6cVYAeO/W33HS2PY6w7xKHiGYRPejeN8hdQrprpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxkAErdR1S4yNFfji+7HL45SUX4Ln0GVrqyOnqJCgw8=;
 b=SkFpea31CF9XHhhzBW15h9HdRW9Ti+zaAR84skBJaDjUbk+W6HlaEMIobvPkDT/z4lIKKTo3VdN5HkYKhuqwOiRiLrMljXWxUvstITsg5C8dGSEhng3BMM3PXjP0pEZB01GQ9UMEBNhfLgMY3FN6bg1SmN0zoyZOecZy8E/PE2k=
Received: from PH7PR17CA0058.namprd17.prod.outlook.com (2603:10b6:510:325::7)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:21:41 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::d8) by PH7PR17CA0058.outlook.office365.com
 (2603:10b6:510:325::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:39 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:21:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 44/45] drm/amd/display: [FW Promotion] Release 0.0.216.0
Date: Wed, 1 May 2024 15:16:50 +0800
Message-ID: <20240501071651.3541919-45-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd28805-90d7-4b49-bcb7-08dc69af585a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nv5A1a30rKjCLV4kSDcjvL9CNnyRMuNaHutWwoHw7o1pCrywMkj0XpzVrdvB?=
 =?us-ascii?Q?QN7R9fDOhtUeqwANUEWzZXb2LWUwNzn6BQmM43LAGvHiq6O2X/9+nkLMvVN3?=
 =?us-ascii?Q?e3cU2b4Or9BnYKRdVqeHMgo3L2C35oEhVxaXqOKhZHJNZZk6vQEXcH3ADYhI?=
 =?us-ascii?Q?O+hRbVYO1ixw7ebkDXHGpM6BHSbxFGonTQ7GKFp+vSZql8wXtn2TmryM9/x5?=
 =?us-ascii?Q?Ltmp676Gj+L6f50fJtYz5v/bJuRQ2hTEn3gdj0dDTyPG5jr0FmyM6poSzL3+?=
 =?us-ascii?Q?gBTX4hPFCGoz1l7+JeqWkuEBe78HZkD88lIaybHc9RGHeVJTmd4gNU96arDi?=
 =?us-ascii?Q?uD9oojdVjxq7kP/0pFcBAaGl0mpjxR5nc6m1vv99uTdBtM2l0/uNJHv7ju7p?=
 =?us-ascii?Q?+XnDNMINN0EoVCvyXuV4CJJ7uhdLp9vQ3HF5sR1A+qupgyeP7NtvdsSoAvQ6?=
 =?us-ascii?Q?d+HAVjAB4eLMxlfD+iVxelDhtNnmkyTnymSI+JHLs+0CevTPtQ7VtIx8SqnX?=
 =?us-ascii?Q?CzGWdJ/gka1fqqJ74sPLxRAg0wV0vZXxm8uxZDhBaDKIvCwx8APLvgkR7mbI?=
 =?us-ascii?Q?vhcj4xW5pHq9EdjnPkL9vUalr+w1BhictXoPUe709Vz/KnmZXEM0DF8Xsqim?=
 =?us-ascii?Q?i6mFXdQ0n56LF1Kwpf7MtcA425PtnPFL4CHaDUtIUpnb09hGBUy1F5ke9Fp5?=
 =?us-ascii?Q?WFHrBJDsXXpwRwMP5ArKA46OVn9KiM1gkvh8L+CVNOpQn03/5JOQ6eHHbzC4?=
 =?us-ascii?Q?8YsvxQThh3uzvH05kxyqc5rNGWH4QosNi64KeyjXxoqZSQiyG7Y1lmHTtrl5?=
 =?us-ascii?Q?gUsMJYD2E5YAxEszCbnizKUzWu3coCIvvPiQm5DASXayQcUivKkTB5mJVHaY?=
 =?us-ascii?Q?eOIM5cF/RWkCQazmh3S97S2ZKMqwB9y2qYy7c++BH2AW0Q+vqn65zgPir8lR?=
 =?us-ascii?Q?TbqImcBvFdmosWEPULMiqyhNiRhzH0SZ/JGKKP0TPkViFuI1zJqOlK6rnt1I?=
 =?us-ascii?Q?LaURHvlAsDfou/TA72iIA2Tgv+gJBVLnhGnfD7gjyGu193c1qN31KSUen/Mn?=
 =?us-ascii?Q?DuEQjSgQeQQ2Bw7K1LVLc97NA1oSfQnF9ODLLI9B08AF4WfuXWUaMzFREJ/g?=
 =?us-ascii?Q?I1ujiSC2xlYJAhpmKlLP0hEXkkm4eifqlb7FVtSCT0g+jokNcRH2kRseCvPf?=
 =?us-ascii?Q?1NpK8gCgi+dnOQkKcts8/DSeAq+afXCHUUZKTymBPasE/am6YHPLrumno187?=
 =?us-ascii?Q?sYa2IgZOZ3vs4pcsKhelc7b5ZXXeIyqpk3yNEpQrgW+VNzOVDtzOXKtWnvbh?=
 =?us-ascii?Q?pEDLgkLffkIGgBkUT33B0dof6I3Fos0RHWZZnNmWmOC3BBaCN3IjqbUCVYsS?=
 =?us-ascii?Q?fJ9UAfY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:40.1677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd28805-90d7-4b49-bcb7-08dc69af585a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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

From: Anthony Koo <anthony.koo@amd.com>

 - Implement command interface to query ABM SW algorithm and
   HW caps. This is primarily intended as a debugging interface

 - Add new definitions for max number of histogram bins and ABM
   curve segments available in hardware

 - Add structures to retrieve caps to describe ABM HW caps
   since not all ASICs have the same number of cure segments and
   bins

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 35096aa3d85b..abf248d46b1c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -81,6 +81,16 @@
  */
 #define NUM_BL_CURVE_SEGS               16
 
+/**
+ * Maximum number of segments in ABM ACE curve.
+ */
+#define ABM_MAX_NUM_OF_ACE_SEGMENTS         64
+
+/**
+ * Maximum number of bins in ABM histogram.
+ */
+#define ABM_MAX_NUM_OF_HG_BINS              64
+
 /* Maximum number of SubVP streams */
 #define DMUB_MAX_SUBVP_STREAMS 2
 
@@ -3865,6 +3875,82 @@ enum dmub_cmd_abm_type {
 	 * on restore we update state with passed in data.
 	 */
 	DMUB_CMD__ABM_SAVE_RESTORE	= 7,
+
+	/**
+	 * Query ABM caps.
+	 */
+	DMUB_CMD__ABM_QUERY_CAPS	= 8,
+};
+
+struct abm_ace_curve {
+	/**
+	 * @offsets: ACE curve offsets.
+	 */
+	uint32_t offsets[ABM_MAX_NUM_OF_ACE_SEGMENTS];
+
+	/**
+	 * @thresholds: ACE curve thresholds.
+	 */
+	uint32_t thresholds[ABM_MAX_NUM_OF_ACE_SEGMENTS];
+
+	/**
+	 * @slopes: ACE curve slopes.
+	 */
+	uint32_t slopes[ABM_MAX_NUM_OF_ACE_SEGMENTS];
+};
+
+struct fixed_pt_format {
+	/**
+	 * @sign_bit: Indicates whether one bit is reserved for the sign.
+	 */
+	bool sign_bit;
+
+	/**
+	 * @num_int_bits: Number of bits used for integer part.
+	 */
+	uint8_t num_int_bits;
+
+	/**
+	 * @num_frac_bits: Number of bits used for fractional part.
+	 */
+	uint8_t num_frac_bits;
+
+	/**
+	 * @pad: Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad;
+};
+
+struct abm_caps {
+	/**
+	 * @num_hg_bins: Number of histogram bins.
+	 */
+	uint8_t num_hg_bins;
+
+	/**
+	 * @num_ace_segments: Number of ACE curve segments.
+	 */
+	uint8_t num_ace_segments;
+
+	/**
+	 * @pad: Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+
+	/**
+	 * @ace_thresholds_format: Format of the ACE thresholds. If not programmable, it is set to 0.
+	 */
+	struct fixed_pt_format ace_thresholds_format;
+
+	/**
+	 * @ace_offsets_format: Format of the ACE offsets. If not programmable, it is set to 0.
+	 */
+	struct fixed_pt_format ace_offsets_format;
+
+	/**
+	 * @ace_slopes_format: Format of the ACE slopes.
+	 */
+	struct fixed_pt_format ace_slopes_format;
 };
 
 /**
@@ -4274,6 +4360,54 @@ struct dmub_rb_cmd_abm_pause {
 	struct dmub_cmd_abm_pause_data abm_pause_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_QUERY_CAPS command.
+ */
+struct dmub_cmd_abm_query_caps_in {
+	/**
+	 * Panel instance.
+	 */
+	uint8_t panel_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
+};
+
+/**
+ * Data passed from FW to driver in a DMUB_CMD__ABM_QUERY_CAPS command.
+ */
+struct dmub_cmd_abm_query_caps_out {
+	/**
+	 * SW Algorithm caps.
+	 */
+	struct abm_caps sw_caps;
+
+	/**
+	 * ABM HW caps.
+	 */
+	struct abm_caps hw_caps;
+};
+
+/**
+ * Definition of a DMUB_CMD__ABM_QUERY_CAPS command.
+ */
+struct dmub_rb_cmd_abm_query_caps {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed between FW and driver in a DMUB_CMD__ABM_QUERY_CAPS command.
+	 */
+	union {
+		struct dmub_cmd_abm_query_caps_in  abm_query_caps_in;
+		struct dmub_cmd_abm_query_caps_out abm_query_caps_out;
+	} data;
+};
+
 /**
  * Definition of a DMUB_CMD__ABM_SAVE_RESTORE command.
  */
@@ -4838,6 +4972,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_abm_save_restore abm_save_restore;
 
+	/**
+	 * Definition of a DMUB_CMD__ABM_QUERY_CAPS command.
+	 */
+	struct dmub_rb_cmd_abm_query_caps abm_query_caps;
+
 	/**
 	 * Definition of a DMUB_CMD__DP_AUX_ACCESS command.
 	 */
-- 
2.34.1

