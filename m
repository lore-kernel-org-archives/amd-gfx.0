Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDAED6D25A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 03:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6385310E46F;
	Thu, 28 Nov 2024 03:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oN2XbJMU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9AA10E46F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 03:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCEAtcue2sjHgKC0KlPOb5+gG8IFNVK02/nvBU1DoM4sB0S9WaT7IZn9EvnJSrSI0flwGxXmQVlS324bOijJOEbUaQojkLuISi4LUVkRNmC9K1TTWwqAJaOBjmC+sDoWsmDf9sRgE4jpB3qFZ0l2KfIjAOMWt8W8G0305eykH9cEYJ9SOLN2fH/THWDj2m8WdOrWUdYZ73ah1TeNSuTlO1pXbS0bwYQ1u5q5C4D70WkP8/KZVAGYGNu9/LtWJdm+dgAj3Qd2nKouLa8klXB99hU2V/R/LW1DUxxWmE6u2BntgIMjlh1rgruUNScQCvFKPlHziSB8DVPko63sWc/msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3Brwum/fnyUj0j8n1NsCc4fXlje5WU7K/Omdr/0BJs=;
 b=dID7VbFcA3s+A/qg74A9NXG8bKzW2JBNEwl4s1BVw38A6AelSsyHlM37PDpeaBG6s+9TmbOiFmhHjLpnKRvMJXX3zjkwtQFmEdU6idf7tECgiWXCVafLvgylRsS8uy+r9TXU/mBzwQ32I0aFs2MheLqy4c904H5jVks3sgioDh/rPSYzSFMz0DoAN/3X/LccR9spb7Q0UTZGlCLQbYtAY2GZI6yGolqZeHY9F+dRah6k4Hy001pNquRjHPAURnkQzvqDMuNBByivzZ2FA+kLZ8N+ZnYpIgtOIH05dw0/fETvsRlHY0DJNHWoILEEcV29SEiEqVYvdMDM3L0NnRagKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3Brwum/fnyUj0j8n1NsCc4fXlje5WU7K/Omdr/0BJs=;
 b=oN2XbJMUr3puRXjHMBslEaySYq6DACyjg3wvFg8oJqr+eRAHCIGlDxHdN+6rHRRrgFHrA8I1XIX4gEA+wOSNGYC1s42wEzKKUdrfK1Y00f09T8w8r1+eO0mtbDjoCaPO5bxlnOcptgHnzZZ7yaRyXMPeCPTaEDcVrv0HrJkUwEY=
Received: from SN4PR0501CA0110.namprd05.prod.outlook.com
 (2603:10b6:803:42::27) by CY8PR12MB7540.namprd12.prod.outlook.com
 (2603:10b6:930:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 03:32:47 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::c1) by SN4PR0501CA0110.outlook.office365.com
 (2603:10b6:803:42::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.10 via Frontend Transport; Thu,
 28 Nov 2024 03:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 03:32:47 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 21:31:37 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <wayne.lin@amd.com>, <andrew.strauss@amd.com>,
 Jinzhou Su <jinzhou.su@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Add secure display v2 command
Date: Thu, 28 Nov 2024 11:31:06 +0800
Message-ID: <20241128033106.45592-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7316dc9d-dfaa-4daa-1137-08dd0f5d53fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p+J1L6UX3mhWZXg5EYLBY4QuIBJvbJNzJgOqGxyROkDZNdzZZNM1RLiRS6ye?=
 =?us-ascii?Q?pZHt1JvacwdJOn69Vw7Q7w5aZUecGuEaC47stTUCwKNaA07TX3N0BtpgJM1W?=
 =?us-ascii?Q?HJxyP4pyLM9iaHDrFnYh+rlvTkT6ASMD3ketpKSzfXa9azxaVHsoWTaAlTJJ?=
 =?us-ascii?Q?d7Gcxe1S4rXc5MHxYyI752rjZhQT3JJ5A8RHJ1g4CIzhhF0ygFY8SL+ow2cN?=
 =?us-ascii?Q?UbCOH7r9nHTsqpHiBE4H7r6XdAN3s+xM7oMm+VE4F68DPsnW0HsjP6eT7sAP?=
 =?us-ascii?Q?OSwFtlofJS4DwGgK2WshdBCl4IHZwxeMcVQAWvjlUbRmn3kS91Fzkeif7xKs?=
 =?us-ascii?Q?uW7ZecLnfFB8Mu4Kx2cUpD+c+mjksGAiW5CYNTFWvFPvxLUmb1OYJ1ASqT0N?=
 =?us-ascii?Q?bDhAE6nYhjkKkfaH9SLyxQMI7zJq4f24vG6ZPYXche8POEQg+z97vp83qbnM?=
 =?us-ascii?Q?vtHU6YLla9D+kE/eC+0wun6uuGAMY3zKZLM5HzENp5MIFZG7dLV/whdB1ovy?=
 =?us-ascii?Q?Lbjs8E0crh9dr2gr+B+oTi3TqPDfJM3U+nDZ+1FSihnqqX2cARgQ8nCgWHpO?=
 =?us-ascii?Q?nNWDQvZS2/QxLvLsefGhc079oWXMxzVzmhwVP+rrhIfeynTcwxdZcD2pYQxi?=
 =?us-ascii?Q?NtxmhI+uCR2cfls82JqMjATSLBlXRCW2iCwILcVVbpzJrdPwKJnLRMpa2SMH?=
 =?us-ascii?Q?Eb38hS6Jl69F0mcXL4Ue+RU9qSJ4Eba9vUmBYidlOrQl1rZgN8kQaVnL62is?=
 =?us-ascii?Q?SXdF7MNzFGTijXKTCO+RmBLqN18yEfNRcoZ+2PwLlYbjd6Ixm7LiEbAXtc0E?=
 =?us-ascii?Q?Y0DHLGKIrF+SVfSZVsYC8/nixEvEqZ1gGPke4hp8Esfu4Zkf+oj5z/XNZyTd?=
 =?us-ascii?Q?QHy9XptxJE3LcWfD4qXVd/Q5g9dwHAig/kUExwkMtT7ejc1ev0EA8AvHduA8?=
 =?us-ascii?Q?RBh9Nh3HFQ/VGsQSUxCQ9iebNNpn6idzyqZ2EAwifa/yakwEp5Oevhc+lPWw?=
 =?us-ascii?Q?JyTmpRShg26FySRRnM1N0bP0zG4vqncdh+m2mibxovlCj1Op8Ga/1lcpWZBD?=
 =?us-ascii?Q?uWxxde8olOuZl2bvCoSXHG9NFUpsM20F/5frlKjA0M/Cy5r+XSETUQlYDUHY?=
 =?us-ascii?Q?A3UXSO1dESUegz3X0LL35kvjCS/rxvM2v+UhawrhVP/Xg0YE+QmrWLGopSHe?=
 =?us-ascii?Q?Q7eKjV/fDLkbVHzzvbAZRxuuEgV1TPjVhgnu2LQa8m8lNoVJxqr4zo3KcTib?=
 =?us-ascii?Q?cevzdKWqQaIWtEv5veHnYGC0bcu0s6oQJ3pFyK3NE8XvOzMQ9FGppNFDzphL?=
 =?us-ascii?Q?+xpCYNqCAfsbP419nzPrtzstt6VJbS1Frdv4vi26eHiZsyCb4Fg6E2OJtfJJ?=
 =?us-ascii?Q?fknZaEc2bozErFvvVZzwikLhlS6sx14RemLm5jUEq+NFdAZP4gjNcz2ga79q?=
 =?us-ascii?Q?QmrgGsq7VRrtIqLuDEnxMD+uHIGSKVSc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 03:32:47.1166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7316dc9d-dfaa-4daa-1137-08dd0f5d53fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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

Add secure display v2 command to support multiple ROI instances per
display.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
 .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 22 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f015961f257a..12832fd834fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2264,7 +2264,8 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 		return -EINVAL;
 
 	if (ta_cmd_id != TA_SECUREDISPLAY_COMMAND__QUERY_TA &&
-	    ta_cmd_id != TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
+	    ta_cmd_id != TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC &&
+	    ta_cmd_id != TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2)
 		return -EINVAL;
 
 	ret = psp_ta_invoke(psp, ta_cmd_id, &psp->securedisplay_context.context);
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
index 00d8bdb8254f..c5eddd685390 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
@@ -31,10 +31,12 @@
  *    Secure Display Command ID
  */
 enum ta_securedisplay_command {
-	/* Query whether TA is responding used only for validation purpose */
+	/* Query whether TA is responding. It is used only for validation purpose */
 	TA_SECUREDISPLAY_COMMAND__QUERY_TA              = 1,
 	/* Send region of Interest and CRC value to I2C */
 	TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC          = 2,
+	/* V2 to send multiple regions of Interest and CRC value to I2C */
+	TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2       = 3,
 	/* Maximum Command ID */
 	TA_SECUREDISPLAY_COMMAND__MAX_ID                = 0x7FFFFFFF,
 };
@@ -83,6 +85,8 @@ enum ta_securedisplay_ta_query_cmd_ret {
 enum ta_securedisplay_buffer_size {
 	/* 15 bytes = 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) */
 	TA_SECUREDISPLAY_I2C_BUFFER_SIZE                = 15,
+	/* 15 bytes = 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) + 1 byte(roi_idx) */
+	TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE             = 16,
 };
 
 /** Input/output structures for Secure Display commands */
@@ -98,12 +102,21 @@ struct ta_securedisplay_send_roi_crc_input {
 	uint32_t  phy_id;  /* Physical ID */
 };
 
+struct ta_securedisplay_send_roi_crc_v2_input
+{
+   uint32_t phy_id;  /* Physical ID */
+   uint8_t  roi_idx; /* Region of interest index */
+};
+
 /** @union ta_securedisplay_cmd_input
  *    Input buffer
  */
 union ta_securedisplay_cmd_input {
 	/* send ROI and CRC input buffer format */
 	struct ta_securedisplay_send_roi_crc_input        send_roi_crc;
+	/* send ROI and CRC input buffer format, v2 adds a ROI index */
+	struct ta_securedisplay_send_roi_crc_v2_input     send_roi_crc_v2;
+	/* Reserved space for future expansion */
 	uint32_t                                          reserved[4];
 };
 
@@ -128,6 +141,11 @@ struct ta_securedisplay_send_roi_crc_output {
 	uint8_t  reserved;
 };
 
+struct ta_securedisplay_send_roi_crc_v2_output
+{
+   uint8_t  i2c_buf[TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE];  /* I2C buffer */
+};
+
 /** @union ta_securedisplay_cmd_output
  *    Output buffer
  */
@@ -136,6 +154,8 @@ union ta_securedisplay_cmd_output {
 	struct ta_securedisplay_query_ta_output            query_ta;
 	/* Send ROI CRC output buffer format used only for validation purpose */
 	struct ta_securedisplay_send_roi_crc_output        send_roi_crc;
+	/* Send ROI CRC output buffer format used only for validation purpose */
+	struct ta_securedisplay_send_roi_crc_v2_output     send_roi_crc_v2;
 	uint32_t                                           reserved[4];
 };
 
-- 
2.43.0

