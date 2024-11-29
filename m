Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571BBD70E07
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 02:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E340110E293;
	Fri, 29 Nov 2024 02:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1A+Ms6g";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863C110E293
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 02:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmyMJaN72elZTNNAkjrr1fbhv+VHmNTtoheLYUc1hHPnQoXXHDx0hbZ5CO6kSfat0GSTcV09x06X6oEL+jLYZE//wi/aSTMPrsyEoREpFOyqLtPkGINuMxJD6aQntcGPtjUgJgdFDG3VsfyfdXzNWjZS+5aaQ9KtSEdKapHVGXFyxoJ0cz/dtMXTe1hr61ieMftaLEIpZzreQdLI15wIZiqO36Ke65hoKx6L6mp6OQVgnHU50nLzmmgqH+Me0n8A6ebvR3SAkMjpX/py4irnwnfUCyKPa6KTpQ0t+K/8O/Xn6qlYHVR18D1h9wLxkqFqnY9C6J74o5XjA6oNu7xarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjHYKZsFqHGhxXNKcwT7mj7Pqfwb2q60zJZwepBe3Yc=;
 b=AUFWKmRHHJCv+RseN0eGoH8qy5zmBKJualcCWypUWtzFKmmI0wM031iDMEUaH5bgP7afhtZBW60po4GjIAursR/PpkuU1sjxOy3nzixcgCX/XoPm8tJVIu38WtmnOkCHhxi/VvQTKggzEAGtBj0pjOjYSOmvo8eXdGBC7cv5vfTi/bscY1X1cpRQJGOVUEta9QwjQB1MDrfHvI13koE/NQ9CJYFagLgy3xOzHENoeTTcOLmxUd8FQpkvjyhBAtxZjhShuxLTshry9WDw/ARr8GnBb3XoY/6c7S6tnvgIHD8+Oz4KglcmnbOQ1cl30u5UOjUfJ6hvnR6tEsWn+b7tZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjHYKZsFqHGhxXNKcwT7mj7Pqfwb2q60zJZwepBe3Yc=;
 b=V1A+Ms6gSlr8lVZAQj+Ol39+9NOcponFNAPnNbND3L4HFy7ZmevPCtYsvzjniGOxbfLHPYzI4mBWXJSShqw8cqa5HJsRv1L8m8X0J2bWkuHzw+KVp1RHDoVbBs+EGkyk6XlEOqFEnJrHZLBr2GJfUSWxeeQSEkVfPi6LLveKhho=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Fri, 29 Nov
 2024 02:31:57 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::ef) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Fri,
 29 Nov 2024 02:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Fri, 29 Nov 2024 02:31:57 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 20:30:59 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <wayne.lin@amd.com>, <andrew.strauss@amd.com>,
 <lang.yu@amd.com>, Jinzhou Su <jinzhou.su@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Add secure display v2 command
Date: Fri, 29 Nov 2024 10:30:10 +0800
Message-ID: <20241129023010.9624-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a117da-89bc-427a-4857-08dd101dfee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+E8DHFZg90W3Azdj1dp9vzrdMj+ddmrIWf/OTkALmQ5TLpEIHZnP/0naMQwo?=
 =?us-ascii?Q?cQo8tdG3FBlNQTEaNsSxLKAw1+6TRhnjzUIaqFqxhYdLPElhHRJUVnetP2u0?=
 =?us-ascii?Q?AvOgwfzU3zj9zaei4sWC+mqiqiNMC88oPYiDG8aaExkS3sePwKDxl2YHOaaZ?=
 =?us-ascii?Q?R+3e0uCDLHVJUjM83cpzDsjw8NxoGozyHS/ACLkV3oJADT4LcREydZ+GlMPS?=
 =?us-ascii?Q?9bEWXR9mdKRY3RpK0P8Q47vwWwD/LGtnyJ+5iWc/SWecK8l2hhHgrKoWd898?=
 =?us-ascii?Q?43nQXR6A3NlMRZuYPDXaLiFe7u6R+wUBhuTT/tsXrWFzewWZ/DXBPJaZpH73?=
 =?us-ascii?Q?meIOnzdKDoXA35viANm3XgY74ODJj29nptKJzG4E3CcYR/wbM6Kn8zyhEEdJ?=
 =?us-ascii?Q?o0Ey+ja2t/pdgWcBQpbfb4XIxFABKqxk3yn8I4LG8Zb+J6EYJN5WOYueMmqJ?=
 =?us-ascii?Q?T8USHiQFNdULdj5M1TkzzCoVPIpYK43Nu4Tbku7spWK/gZs2Igl11sVa5LTq?=
 =?us-ascii?Q?xW7H/7e4twBUMdQ+GwT/ubfrWqUAX3OH8uePWQ/uTDtbAKO4PyGmTobX4zdF?=
 =?us-ascii?Q?rqD+wxBzP5PP/K2huK8Zw3TFX5tJn3AP7ufHy7Okkj02xpQ4cDOGNMF1LNa4?=
 =?us-ascii?Q?ogAyq3HAHmyqh/7GKj4sAeXuEnu6eE6nWywtgHIhtB0b/vDt/fDjybz1xWJh?=
 =?us-ascii?Q?sjCMSfSDSJp2SD8pPFSxdZrvUFD0ppljwVjwUf3lAD9se2xeUrDcI143dDRs?=
 =?us-ascii?Q?T7bjP0Ps8a0rCBtI1Sojg7Vnp7LW/dpe+FKaV9zYRL9qm0DHue7s22NVT0EK?=
 =?us-ascii?Q?k6No6KXg13fXknxZrDI7i0tW8wNe+G1vd+dIyCAWlAWORD4rn1e4NqhsCzYQ?=
 =?us-ascii?Q?LGHGwLK+Cyz1BYSNGOPaABtToHOELmUP1dSvA91bUYyCbY8D0OwNXuMghYFf?=
 =?us-ascii?Q?JZWglnCUdEBFnBhPPG+SplcSGMR+harY7jLFW4INa0nQK8dzbQJD6BvLnbp7?=
 =?us-ascii?Q?48Rfp9Oxc9MFzEG98hMxjUYVI2QEkTS5N45Os/4LUnXUPDj0GmEUBXZifevo?=
 =?us-ascii?Q?Gpwy4FzM/eWxm1C20aIfpFrI1ruaDIoR2UOH9xnFRlK2WJJDH5TrSuA/zSyb?=
 =?us-ascii?Q?8B6jXLcB+HadsrehNALF9nAJaa8Kj79QLz2vkrGnTiLSbu3ZjrlNP/Dhf2sO?=
 =?us-ascii?Q?Dh2s5YbzcJAB5VAKUmKwePX5P7NeR9qxaVymLTPUOd0E4jFK1lrN0WDkEC9k?=
 =?us-ascii?Q?X4MV4vhHt5XZzOw9Y0A5TxujOdiikG8RBjlVouACelwDNIA/0eiLkvci0aAU?=
 =?us-ascii?Q?4o2h/JCVLIs9gJp1RpRDd7cZtys3FpTbcLQpuwf168/OeeVZ3QwA2uXJ+l1s?=
 =?us-ascii?Q?4bG/p/ImRiMD+KcgQNSYaphXuqoR5zHDNOyEtbgQ9kQt49rUCSWpHeTzVOIE?=
 =?us-ascii?Q?AZsYdJbJOuU88/7tcqRXAElxVQVcrjdS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 02:31:57.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a117da-89bc-427a-4857-08dd101dfee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

v2: fix typo and coding style issue

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
 .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 25 +++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

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
index 00d8bdb8254f..926da6d46322 100644
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
+	/* 16 bytes = 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) + 1 byte(roi_idx) */
+	TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE             = 16,
 };
 
 /** Input/output structures for Secure Display commands */
@@ -95,7 +99,15 @@ enum ta_securedisplay_buffer_size {
  *    Physical ID to determine which DIO scratch register should be used to get ROI
  */
 struct ta_securedisplay_send_roi_crc_input {
-	uint32_t  phy_id;  /* Physical ID */
+	/* Physical ID */
+	uint32_t  phy_id;
+};
+
+struct ta_securedisplay_send_roi_crc_v2_input {
+	/* Physical ID */
+	uint32_t phy_id;
+	/* Region of interest index */
+	uint8_t  roi_idx;
 };
 
 /** @union ta_securedisplay_cmd_input
@@ -104,6 +116,9 @@ struct ta_securedisplay_send_roi_crc_input {
 union ta_securedisplay_cmd_input {
 	/* send ROI and CRC input buffer format */
 	struct ta_securedisplay_send_roi_crc_input        send_roi_crc;
+	/* send ROI and CRC input buffer format, v2 adds a ROI index */
+	struct ta_securedisplay_send_roi_crc_v2_input     send_roi_crc_v2;
+	/* Reserved space for future expansion */
 	uint32_t                                          reserved[4];
 };
 
@@ -128,6 +143,10 @@ struct ta_securedisplay_send_roi_crc_output {
 	uint8_t  reserved;
 };
 
+struct ta_securedisplay_send_roi_crc_v2_output {
+	uint8_t  i2c_buf[TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE];  /* I2C buffer */
+};
+
 /** @union ta_securedisplay_cmd_output
  *    Output buffer
  */
@@ -136,6 +155,8 @@ union ta_securedisplay_cmd_output {
 	struct ta_securedisplay_query_ta_output            query_ta;
 	/* Send ROI CRC output buffer format used only for validation purpose */
 	struct ta_securedisplay_send_roi_crc_output        send_roi_crc;
+	/* Send ROI CRC output buffer format used only for validation purpose */
+	struct ta_securedisplay_send_roi_crc_v2_output     send_roi_crc_v2;
 	uint32_t                                           reserved[4];
 };
 
-- 
2.43.0

