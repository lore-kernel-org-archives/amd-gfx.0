Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE01F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3415E10E30D;
	Fri,  6 Mar 2026 03:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c/ZKJ5bp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9E510E30D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJsAI4pjWbihVwzOL9mUmz53qXya+nAVoU1pz/dxhYkHuqwFUeScdqJCjFSkSk5IO+bG3DWIEiyW6mLo3b2aYJf6oqMye6zD7gbmWeBbi7VGHUrFxS6jWAGnNG8SxyHns+vQisDY1z2L3NJhwgAOaX9IT0KAYW35tepgA/xgk+257T6nfAD7Os1vO0XJkpKBpgVv2x6ohFSKeu0hl2otCqpIcUHaAtK+CfGV6I/9aLmPHiR3C6+CGudIHjJURt/wfBZsJk+BFRxYpsTEaN346OOG72EGzTWcc/AkjL2DPHbx79GS8z/0rYItq4x/6sx2COLpK9mqpxVspUtT2mkauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=895FCoTK/JG3Xk0O+6786HzNZrIQnIn37LGFJcYy+C0=;
 b=CnU5xZUJA+L+UfW0Bp8BRlsZTd2GeI0ekbYVOmZJD2KbGFZdmkm4gJWUmZxuNavykmBiuiAfKRshLNuXjQPglFfKFmXXGw6erBwZQHVG8VyEpQqpN+9peRYn1J8RDWxTkwcM8tXZHQXajiLCV+BtAlATT7RjFZYsA4WI4uVINR5eMd0f3R9BehMt5/aYn9NNMdnITSc2eOHPuDJMMRSJMU7GtQwFc8TkEl4w3I5lpfJZPYZZqDiN4spCW4PhTO8MuFy56XVxUPs0UITU9LibhLPYIaUouf1G22JyFo9LWtMvpIdyqbFFW7LO+XN1zDLMhSc4mXpXKSymir68nZ5K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=895FCoTK/JG3Xk0O+6786HzNZrIQnIn37LGFJcYy+C0=;
 b=c/ZKJ5bpdqptxWi5IKzqDDC3Xd2AHfU3gNlIIrtcZdUxSHk0QwAASnMov3sVqbz5pjfJyTEgaqafZUVovDKjqYP97vw7HsaQR8hpcuiBUpxGz3ntmtI4HPQwe+XNlD4igrBsZAPOFuJdfq/wPeYP+rJK0XoHgImzz+a9TOYL5p4=
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 03:28:15 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::b4) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 03:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:28:15 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:28:13 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 20/21] drm/amd/display: [FW Promotion] Release 0.1.50.0
Date: Thu, 5 Mar 2026 20:13:46 -0700
Message-ID: <20260306031932.136179-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df6dc94-adac-4f33-6ca0-08de7b30675d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: /OBFNhzlaFaml5ix+dI/p35gvhCxkYb9gJfaDfd3LhCgEp34S1fyZsc5R3TVfxKxzjgA3vpJDs1ibO3I+3U4KLTtodbJOILl+zGfdYBcHbg6efo1gMBheGbjKVvSQTUjqeD7y4uuXtAcz8bLgRDUJabm4Z/1K2ezr25rtorIuNKA4REflaJp4z24TB3pNdystDXmFE8kkSjPMpYueodS9CjUg0X13Oc2RcGiYmc5EfcnKg5pmXrq7oA9pske/qELKGglpr3XydycAj+625YYhrrVIC2RtQkVfaQj75/b25nFKjhMoOcN+KIFk8XkR245tsxhtJrR0Mf6r9z/M3ZMWzdbOWxaegnDqy76WkLuJ1qAm+2HVqMxVT0IUTw2vCmW+aHKu2cLC7/Tg1PU7n7VFs3MKuZnMVPu062CTf1Zti/ni/xI1yNL6i5KVqJ3L72r2PHMZiXzS2//h3fjlwbr9wd+YP/d+J6hZWlA/uEGrmjj92QWN4277p6zzxMB1Bp7vJVF10kys28TpeaBjJmt0/ZgeIhmcesc43dQs8HeIFPI7wOk0ZDTG8Op1Gc6RI2+5+Ex3wUUwqgiYdFDTkjpdrG0mYl0ymFs3rEA++CQAS/pjWcuCVfjj+U6mW9lfK3ZeHZv5BHZrFcjgYyPmo4BNsStG8mT+8dCRWEQhwoQCjSlciNOummEh55txAlJrcxPhewpQ191qMEbZFEF3Jc8FVS10630YkBdEFSZZp117p7YbYdN7FkkU2QpNTJk5vexyRoJkpGSTht1pJ3hEaHCQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zl1lK/FnheZTQS1LyurlfEaIxWxe2f9RIx8ZuWLGoxGYiWuHiVanltGW3swZ72Rrm4QuZ6h6JZIWsoRMjlftcw2CjPvVojs1tbZvVDiK9kEoRp8QX2BHsdpCWgn3ufGDxY7vIz6cqWp0tVm9DK+Gubx4vFc/cEqdyua482tnSfG3N7OO2zyr81ebigtTtTZeAtj/oqo2BFQwhJcDq/0asEGr2VAuZ+OQAtLEauwSKf/gla1vssWSsU9cJ0psF/u5ZkTtdwAcLYKJul7V9KldV+wNli+B0uTRQU0O9Ma3jLFqutbtPOvjmhKqiPhL8THiDqJI8W+9g5pCt1J7jmBMBlPWAuX0r7VAJEkwwclyLI/5myv6D1zCuR76PcqjKdXBqUc+0drkaGc8GURawZhsNJ+cdDsErnR0yugZXt0CCebe0dEYGSBocm5uu5K3ZWDV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:28:15.5656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df6dc94-adac-4f33-6ca0-08de7b30675d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

[WHAT]
Introduce DMUB BOOT_TIME_CRC_INIT command.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0b04f985b15e..e11e32afac6b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1892,6 +1892,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__IHC = 95,
 
+	/**
+	 * Command type use for boot time crc commands.
+	 */
+	DMUB_CMD__BOOT_TIME_CRC = 96,
+
 	/**
 	 * Command type use for VBIOS shared commands.
 	 */
@@ -6838,6 +6843,29 @@ struct dmub_rb_cmd_pr_general_cmd {
 	struct dmub_cmd_pr_general_cmd_data data;
 };
 
+/**
+ * Command type of a DMUB_CMD__BOOT_TIME_CRC command
+ */
+enum dmub_cmd_boot_time_crc_type {
+	DMUB_CMD__BOOT_TIME_CRC_INIT_MEM = 0
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__BOOT_TIME_CRC_INIT command.
+ */
+struct dmub_cmd_boot_time_crc_init_data {
+	union dmub_addr buffer_addr;
+	uint32_t buffer_size;
+};
+
+/**
+ * Definition of a DMUB_CMD__BOOT_TIME_CRC_INIT command.
+ */
+struct dmub_rb_cmd_boot_time_crc_init {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_boot_time_crc_init_data data;
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -7199,6 +7227,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__IHC command.
 	 */
 	struct dmub_rb_cmd_ihc ihc;
+	/**
+	 * Definition of a DMUB_CMD__BOOT_TIME_CRC_INIT command.
+	 */
+	struct dmub_rb_cmd_boot_time_crc_init boot_time_crc_init;
 };
 
 /**
-- 
2.43.0

