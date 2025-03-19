Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C889C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C0810E56B;
	Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UxIZM4aN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2C410E566
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cecv3OIjZJmblTBTzbJhFMUaIV7VoDyAKnWrXCSI6YSOM99tAB5aKyxOpaS4ANIz2Qol9tGOKLql/5az2GxvM6PaSRMQH65cvM3qnpiI73LLoMUJLSe8mr67yzIwI2/Gf/lDoRLeyejS22xjafpXFcFel4S/pNh63a/zuAtulJJhxzhgu96SGz1dlPXF9bhcPCDXEvjJHhoRlQQD1QFFJ1LWON/BCfu7RGzqq2W7myzOCtPCqs/kLN6N8thMoFpSOo6idTlHtjbt+/98BieKclqaDL9ki0bBFo3eIZDMJJj/C27fdMw6CbZOTea/efCw3PgVampDlE74J2kJwWNJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTZstqsCnBYB1ivYuMvAVchisXBdhx2tJgespkgb1w8=;
 b=n5Vw8HgqBos6jM+KHuuXPIqDs7rFdU0yuQHKWmC19aG7BMRsimJQfFVFf3oyygZJnjmCv5jNPMbXrVlod1E0yVkX+o/ihQfu6klY1VHij0th6ZCuZ8NfgDfd5BZIbf0UEJyWRl/NYTw9So96Xg0OLiujnRUS9Q9Lor6vnEMqTJOlSAOnetV9CSXNfj5sq7cW+NvMEnFlwNezrs2Lbx0VgMwdaj3xXeD8Ie5N+ZGe/05rWgXitGynbPBfil+Pahwgyy6GLbzMPa4WeGKMceVcZw71E9QwbaTbR4E1mnqAT7cxf+QYIEQ+wHDuoQ9GCiU7hrvv8j40xZjjaEkFuTlCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTZstqsCnBYB1ivYuMvAVchisXBdhx2tJgespkgb1w8=;
 b=UxIZM4aNIJLpuGXmKYtX0Y/bNMKOskvueFqk54JB2why4QK9RgwhuxL/mddYD0K/esa7kCY4OqlI7EnUWLOFTElpGj2owMl8xuR88TjSMY30L/dKzKTWIQc92GJSI9UwSOjbQMmxzJYF9wkpWoWWBqtEcZYG3xkJKezeldvbLpM=
Received: from CH0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:76::30)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:57:26 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com (2603:10b6:610:76::4)
 by CH0PR04CA0025.outlook.office365.com (2603:10b6:610:76::30) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34
 via Frontend Transport; Wed, 19 Mar 2025 17:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:24 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chun-Liang Chang <Chun-Liang.Chang@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Add Read Histogram command header
Date: Wed, 19 Mar 2025 13:55:13 -0400
Message-ID: <20250319175718.2578234-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: f1426115-604d-4b5a-f5da-08dd670f81d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9T4K6M0Kx92rut81cVXjEy4HkfmxXnMViBIeXDTrWDc/7MGDA53SSYI/pO5?=
 =?us-ascii?Q?by+RTFiOU0HAS46ANA90t++JoKsrKTNwJJVb7lJ1aIxjOTnDEhd1bA343ktl?=
 =?us-ascii?Q?n5lTx2LxQwgzjJeIClSQnEwMZDt0fWWoiUeVo8OHJOl6NzdC/qIRS7OXZhGy?=
 =?us-ascii?Q?K6P1derKEPCwLmNWxeHWlId0oSMk4Fu2LCWehcDZFz6faaJrDZjSEGSTW0Hk?=
 =?us-ascii?Q?ApFMgHK2TLo8EVmM/GeDGOIzTIoOeY7o8sNsafSJ30QeI8F3ttC77iRMdH+2?=
 =?us-ascii?Q?HM2zGyyYurb2F8bnqkO7jHu+eyZofBJQ5ZrgdWD+VZkxE2jRwIrsSKeJzsUb?=
 =?us-ascii?Q?QJyhxv7/K+VFledKR1Ml68Wv5j9cfE9HKWuAHrQD/zoUt4iXBd5X7k53J9Lq?=
 =?us-ascii?Q?soZZxQ1WmCuxWmlG/YxhqGk6FshgJxLAohN/CaAS0IAM8Owmoggjf8RJoRak?=
 =?us-ascii?Q?qV9zETE7OUdkf02falQuSTw9bf0n09MknxOwW0p4t2cNzuAXmnvQLjgb2pys?=
 =?us-ascii?Q?Y/kxPu2iBwpCcwuWagrWmhARdoobvMEVV3YV8uOhHuQeR0u4cYvuw5wSuPTC?=
 =?us-ascii?Q?DqiwspwXLlRf9vljexaQyQ8iwNpLOXq8EV/8U6u6qW0p/KMjTO00WUg7rduY?=
 =?us-ascii?Q?NdD9Xo5lVEnnbl/h70q3mera1I7brczzq4EtL9PNot2lWBjfIUqBq/ouoRiX?=
 =?us-ascii?Q?fXwpNhYH1eUX86OqNcjMdDd50TtWei9rfGyM2HW8oJN3+/ecxT+WC2B9kvxZ?=
 =?us-ascii?Q?bKOlrp6DKfvEGSRm7e7iETwsLXUoUZM6Iut6JHfdQEabxqi1JOSLIH0m2Ueo?=
 =?us-ascii?Q?c6zf4zT+a34a7qoPJVDi1IWkqaEhtZYXETb+VNGBiN+R/bs3j6sPFkXx3Mo8?=
 =?us-ascii?Q?FWWGOxID6Q81IdE1mPurWKk5HBAFfeTXyqiq4/uL3sJONmCLi9wUIQRMHyy/?=
 =?us-ascii?Q?UQO1ljqyIn7wb3Ztmur6WaGdcD/jPWpjz54S5ZtwxOYmT4qUjcuKMWe0VNQf?=
 =?us-ascii?Q?Hq0GU1IgE0qtEa06mbbTCn73Es6oZ8zSXyxP53hs4Mi8FYht6PIW4X9MXjfP?=
 =?us-ascii?Q?iAiH1jEOVKvAx3N57qAqjZipTVa7N7iUOt7iZSF5ZZtfW1MK9Xgf3iMa33uZ?=
 =?us-ascii?Q?6ToaRB5xIZFt3rwFnh8sv6dOtSbXd+fnCVK4c3hfMBEOdIAHgf6eBFYwqhSS?=
 =?us-ascii?Q?71YhtaCRlasorwTzDB7xeePVPi6fWuxUXZOzGIMRl3hTfZ03E6lepXqr+79y?=
 =?us-ascii?Q?YK89l6sPQsAsX6Bk/vit4Il4Flhp5yUgICl9XHFpRKRzrb8ySvcp7pu/SQl9?=
 =?us-ascii?Q?LoImdxXwFdkW80RV0DjqdkonAyD3BBtHFIjgYimN8sE2hyWPgKtl5nM1EysO?=
 =?us-ascii?Q?l3iWgXQzrMdj3vHhjFF1I84WgI1j1YB96KAKTZQN4YJz+J3HJG8z+Ar99C+2?=
 =?us-ascii?Q?qQztzfWFPh8eN8NbCrTxZ0oAjv9GImFs3MfyghJt0om4R8B1IuZQ2/5w1wov?=
 =?us-ascii?Q?OaTLUexN/NyJc/4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:25.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1426115-604d-4b5a-f5da-08dd670f81d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

From: Chun-Liang Chang <Chun-Liang.Chang@amd.com>

[Why]
Read the histogram for VariBright validation

[How]
Add dc/dmub functions to read histogram and ACE

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Chun-Liang Chang <Chun-Liang.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index ccc154b0281c..3b9011ef9b68 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -28,6 +28,8 @@
 #include "dc.h"
 #include "core_types.h"
 #include "dmub_cmd.h"
+#include "dc_dmub_srv.h"
+#include "dmub/dmub_srv.h"
 
 #define TO_DMUB_ABM(abm)\
 	container_of(abm, struct dce_abm, base)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1f5f4e3e49d4..5e7c698f9bfb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4360,6 +4360,11 @@ enum dmub_cmd_abm_type {
 	 * Get the current ACE curve.
 	 */
 	DMUB_CMD__ABM_GET_ACE_CURVE = 10,
+
+	/**
+	 * Get current histogram data
+	 */
+	DMUB_CMD__ABM_GET_HISTOGRAM_DATA = 11,
 };
 
 struct abm_ace_curve {
@@ -4953,6 +4958,20 @@ enum dmub_abm_ace_curve_type {
 	ABM_ACE_CURVE_TYPE__SW_IF = 1,
 };
 
+/**
+ * enum dmub_abm_histogram_type - Histogram type.
+ */
+enum dmub_abm_histogram_type {
+	/**
+	 * ACE curve as defined by the SW layer.
+	 */
+	ABM_HISTOGRAM_TYPE__SW = 0,
+	/**
+	 * ACE curve as defined by the SW to HW translation interface layer.
+	 */
+	ABM_HISTOGRAM_TYPE__SW_IF = 1,
+};
+
 /**
  * Definition of a DMUB_CMD__ABM_GET_ACE_CURVE command.
  */
@@ -4988,6 +5007,41 @@ struct dmub_rb_cmd_abm_get_ace_curve {
 	uint8_t pad;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_GET_HISTOGRAM command.
+ */
+struct dmub_rb_cmd_abm_get_histogram {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Address where Histogram should be copied.
+	 */
+	union dmub_addr dest;
+
+	/**
+	 * Type of Histogram being queried.
+	 */
+	enum dmub_abm_histogram_type histogram_type;
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
@@ -5686,6 +5740,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_abm_get_ace_curve abm_get_ace_curve;
 
+	/**
+	 * Definition of a DMUB_CMD__ABM_GET_HISTOGRAM command.
+	 */
+	struct dmub_rb_cmd_abm_get_histogram abm_get_histogram;
+
 	/**
 	 * Definition of a DMUB_CMD__ABM_SET_EVENT command.
 	 */
-- 
2.49.0

