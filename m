Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C512EC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3658C10EADC;
	Thu,  6 Jun 2024 21:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gq3tTIbN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F23710EADB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO/EWOHc3aycQruHTCh+lRislweJanDV6FVQJP0QAalCVy/QS5L3biImXSedzMj2HMCndiUdOvg9xs3c+A05xksHuXgse/4N3MCt2+i48luxorB50NCGT9t7HwQYMoVUx9Sh6b/7MN2t2FLswtqumgruGTMcuDx1RAxJimSp4McrSItpYEKjPRkJABlDayum/gAntPhOmbFUa6LYFFVKs3THs2PEuF3YzMQrrjrrWM3kHrlID2cU3bJnLzaeTm/6s2NSe/idxaPExjnz71QN0e1Se31uDJcgOkA0KqAgBpiqG0ioYroPSf8asPsZo6q3AXkKWq0ZypIonLy7Df4Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGcAWp5X8EucpTOP4RZsF4JY+UdHhLcPfn6Zqgd5FjQ=;
 b=k807U2Nhxb6R6pLf2sItVRygMKRMSZGT+PYKp1yIS1OFp7QpS4ayVKFKeYOOVoEq9BDLTVpNQ+OTNNZ3tBd0nAh7u3zykagMc5WpNiJ2pUukCh0K91eXSgWRWm2D6haIFe7R9/5zj8AFEZv3cHuMKy7mGbrD3rP+k/3ofxiYOEvC21iDP4nCrD7tz2Arc7ennpBISGyBLnFS4hht5q4uy6w/vqVJr8VVCxDjuG+yLvhuz2nK/tL4IpHANSZnvt4Mn3sZF6MHEGdlkNGfhgwdilN4e5qS81GEMp6rrFfVUlIl8IdNJ03dlqokHWGhpHtt/fBgAY+fbu/nv5ZeuWSXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGcAWp5X8EucpTOP4RZsF4JY+UdHhLcPfn6Zqgd5FjQ=;
 b=Gq3tTIbNckGP7uSQVDza5jK2QhFuUdYOboxxdjgKR+It7Zx7GApHOYdf3nHOUo40p30WrbHuf3BWbcUX1t6tt8Wpk04mGtD2ENd6cFbraslfWDuqpOer/hARvsSG+DGAejTleply/kZ4sSPriWtk5udJKYAb5TTDPdosfiB1jWg=
Received: from MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:20 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::41) by MN2PR03CA0008.outlook.office365.com
 (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:20 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:19 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 21/67] drm/amd/display: [FW Promotion] Release 0.0.220.0
Date: Thu, 6 Jun 2024 17:55:46 -0400
Message-ID: <20240606215632.4061204-22-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb38ba2-d646-4d9c-fc15-08dc8673a3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hwly5Ng+9bKEog2CW/RwHf5lb7F0b2P9iUXAHz9a+o8KHAMN9lbwolIIQf10?=
 =?us-ascii?Q?CfGN7UdvNEs4E3bXo0QJhOGUmq6r214Ih1gyDSjaEp/Xtt1ZlfGxNm/KECS1?=
 =?us-ascii?Q?7TSPXrywRdK1wc+LdMQQ387LPCeKth3LgGfvRIXaIeJeDwai5HVu7JHCOwzh?=
 =?us-ascii?Q?Os2iJUuzCT9/TISiOHbv+m2Fytv5x6zR2fPSX/5yttSy8VVDDkP3z6OxgL1e?=
 =?us-ascii?Q?v50WLnjL8mHcDp/ZmtZD/Glz3RO4ugv/5eBe54N7YHh6e6F8Y3TM1sXeq2lw?=
 =?us-ascii?Q?bKgt1jo8Xh6zI+JvTvrH84JlDQFvGRHAbEC/hqY0QMigru3C/2C5JeuRjwC2?=
 =?us-ascii?Q?NRySmHRLV5cvRJlAHaW5M94hHqLbyBQQsa+sQ+c3JsAsevGNGkJVg7rIz5N0?=
 =?us-ascii?Q?OpqCU3mvM7hPTJguR6zy8c1+QbiwRNUGeH06dKjRlNvqfgJ178ZeceFrMfoL?=
 =?us-ascii?Q?0lmHrcLH+TiGOW7y7mlrsVoLlKwfPch5ZdjBiLOYeUNBnxjf1tD3ZqBb76kX?=
 =?us-ascii?Q?djZYzOnVhe0GJ8THkDatfwpURmdCjmwHwjb2/N19Ub8oKikfaOUuCKe7jTy9?=
 =?us-ascii?Q?fBcSQS9ZFx/C1/5vc0wkjU4z3YVRakh2eSQWs45CdvjXUHM1tIoS9BnSOJGA?=
 =?us-ascii?Q?+Muo1NO/KLOEy7VWn9wqY8bLqGqiEpGL82ENiR9NKIDDwcWrbHb9lXtXUnMl?=
 =?us-ascii?Q?OR2mXsjhhhbRIoz39R2yW7WaRgL7K6DbKRfapLSTn7Qg58CVHARsN9DMfMui?=
 =?us-ascii?Q?gG5NNNCV8zs/DSp+pV1aa/2oRaflhVdru3hmPxq5Ir0f1a+8w5Nrk4Un0A2B?=
 =?us-ascii?Q?uY6RBfG8ZrHVOyUm9QdOWYpUKjES2BL3yYMfqzRKh/+yi7ksrNkc9YJaX3QP?=
 =?us-ascii?Q?cwsDfobE0iageLUbxCKYrOQDlAx36zr1JwJpoOY9a+B2AFE6SMrOdyH8SdKU?=
 =?us-ascii?Q?sMDXFFujY0jPjvHwV5LORoCSDrYBiPoffj4gZzf+2mhkml6YazKpzyRiD1Pd?=
 =?us-ascii?Q?pEjuaXalPAHgO6/jVjOe2zkKTmXg4RRxppc2A7WZjCBOe/NjmYjhiLqPPAG/?=
 =?us-ascii?Q?FoDw2RQ/a3WksMHgxqXkFXKuQSi7bQjh/K+/k9Y/H4PZHOqDBBKYXdR7e6wf?=
 =?us-ascii?Q?dRvEG7/mOA7kZjeDVi0lxd/kTzyL984ueau5l88QTunUqKqruuVkg45A3OeI?=
 =?us-ascii?Q?Bn8+UzT1umbyl87gSvBdCo/x589/maFaIpPOSWFeAUSFF1J/0Sx5NdLmtAMK?=
 =?us-ascii?Q?OuDEp609cJDBLfKLBqKedXBdr5c1g08OWq2Ob3DODbrlvl73t6vFe1xPhzMP?=
 =?us-ascii?Q?T9hsKYAF303D0mp5TXBKLZkmyQhuYJSihGKdceC1m88dp6ncS7keVZSlWRY1?=
 =?us-ascii?Q?A9e8cdBzPjAPPD6I3K//dD89lWISC6nW7AeKZiKIiln8smanLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:20.7475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb38ba2-d646-4d9c-fc15-08dc8673a3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

 - Change ordering of structs to put enums together
 - Add new define DMUB_TRACE_ENTRY_DEFINED to guard
   the trace code enum

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fe529b67369e..7fea9bec7b64 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -558,6 +558,7 @@ union dmub_fw_meta {
 //==============================================================================
 //< DMUB Trace Buffer>================================================================
 //==============================================================================
+#if !defined(TENSILICA) && !defined(DMUB_TRACE_ENTRY_DEFINED)
 /**
  * dmub_trace_code_t - firmware trace code, 32-bits
  */
@@ -572,6 +573,7 @@ struct dmcub_trace_buf_entry {
 	uint32_t param0; /**< trace defined parameter 0 */
 	uint32_t param1; /**< trace defined parameter 1 */
 };
+#endif
 
 //==============================================================================
 //< DMUB_STATUS>================================================================
@@ -2538,6 +2540,18 @@ enum dmub_cmd_psr_type {
 	DMUB_CMD__SET_PSR_POWER_OPT = 7,
 };
 
+/**
+ * Different PSR residency modes.
+ * Different modes change the definition of PSR residency.
+ */
+enum psr_residency_mode {
+	PSR_RESIDENCY_MODE_PHY = 0,
+	PSR_RESIDENCY_MODE_ALPM,
+	PSR_RESIDENCY_MODE_ENABLEMENT_PERIOD,
+	/* Do not add below. */
+	PSR_RESIDENCY_MODE_LAST_ELEMENT,
+};
+
 enum dmub_cmd_fams_type {
 	DMUB_CMD__FAMS_SETUP_FW_CTRL	= 0,
 	DMUB_CMD__FAMS_DRR_UPDATE		= 1,
@@ -3259,18 +3273,6 @@ struct dmub_rb_cmd_psr_set_power_opt {
 	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
 };
 
-/**
- * Different PSR residency modes.
- * Different modes change the definition of PSR residency.
- */
-enum psr_residency_mode {
-	PSR_RESIDENCY_MODE_PHY = 0,
-	PSR_RESIDENCY_MODE_ALPM,
-	PSR_RESIDENCY_MODE_ENABLEMENT_PERIOD,
-	/* Do not add below. */
-	PSR_RESIDENCY_MODE_LAST_ELEMENT,
-};
-
 /**
  * Definition of Replay Residency GPINT command.
  * Bit[0] - Residency mode for Revision 0
-- 
2.34.1

