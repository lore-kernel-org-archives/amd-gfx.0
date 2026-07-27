Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27376C53209
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 17:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C2710E491;
	Mon, 27 Jul 2026 17:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRAS/qwM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AFE10E483
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 17:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHZQN5sxrxxQ57G/gENd708cNNTAxVOya7lPCj+BlwUVlnI0X7MP587vZnXBxDC17sga/tNW67CMBLVGxiPRZN09WuL/JVwb+OQ9feTcOChHQ9laq8BlEEmi/lddG97V4qRDxA/NbKKo18QfuDMAEZTwdMru8U89SzuXSycuSfz2Hjhlyjm7htlNjVBrEaPPOOlzKFrfCGVw3zpdSekD2CzK2qMV1OScgPHsOFe0mnJkZabnqGPDFyZOk3rlDcFF6ICvxUyZ+S+Tutirx+4x1mQ4cZOfDO/J6wCJRcAb/UvayfSS81KEE/d95mmhdje4JiLcUxPgX6DwLU5uVSrUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TyMaso+2aRy/Pd7PQEcnlJKTU0f9PEB8BgBQazFFME=;
 b=rEdCkGsBkWrM3Z+RpFRdlse7zxBXpRLB6wk4hqTHB/8P/ZkyOZpSNGMhCjeKWSHX0pI5hhjKztYdujOxquw/ADJQBa4iz8ukrA5sm1sVdfzuymJbH0/+VjuHjdz3NUAax2SOQIZtVBCPxsOCBQbpgG25Mktr1Zh/Db/9Jjx+a7KQbKAOK1I28Fy/Cnz8xi7rTVicvZ3U3QmlAutX7WGdX5L8Nk7Kzuts6Sd+FsPz4Jw8XRIX6Datka5/omi9E37NCDSCZzMjYJ7fKAbUZgvHpqmCPmjfyQSgAONiBl93JQ1/X7ogRRdFrVtWysVkLCszz2ooM1JQIcBEy8wbD9E4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TyMaso+2aRy/Pd7PQEcnlJKTU0f9PEB8BgBQazFFME=;
 b=VRAS/qwMwkAMEKpHSSZb0MYHB3qVD8fNlGvG+9qv/nrV9dO7FuFssXLwCgBaGc/BMl4orvrWmDTqtHlDCqEzY+S4dBDYPJboAt7WiQKAarFa5dvmlR5lztERXuYU8IUCuFZlVPsNO69RL329Mo8aO/uUpN8GB25j0Ibo+k4C3Zk=
Received: from BYAPR21CA0007.namprd21.prod.outlook.com (2603:10b6:a03:114::17)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:27:37 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::a2) by BYAPR21CA0007.outlook.office365.com
 (2603:10b6:a03:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.5 via Frontend Transport; Mon, 27
 Jul 2026 17:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 17:27:36 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 12:27:35 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kent.Russell@amd.com>, <Alysa.Liu@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <William.Palacek@amd.com>
Subject: [PATCH v2] drm/amdkfd: allow CWSR grace period of 0 on supported
 firmware
Date: Mon, 27 Jul 2026 13:27:29 -0400
Message-ID: <20260727172729.2173487-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: a11bb2ed-2490-4374-83a3-08deec045a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 4KjeQmPbX+PT75FtoEJ9NRmrVPgQHefn/RnQQ4vjpteKVEsTZ7zFSEVJjsE1aDYLqWMovlVDPHZolhVBjgbL0cCHXfqX5tqeeaobVLgLzE6b63yYqpma0zxIGmvj30XK6tY7QQusfrJgmczLyGyVE9iorkHCtnaHoQj4QRUvT5IWg73GMKO6HjmlXtf1uuusVzaoWg4y7jMD/QA0Asu68I4hado7XDZddozpsxnS6VUzM2t2b+S+GWya69Zpgz3cHWSRVbn43c8zE2GBMzDNqg9eiYTRLE3lM5bq0MQDBuEP5JEm00f/Dwrv5ntPAMaBHDqvZG3zrxVD0IlSEXRn9LXlMgbOU922QEGOp362Miwtbpx/uAxA4CJ8WoAJMFrLZ5b+ELJm0F2WQnKPS0v6p5QtK0nK2piB7lbqELNfcn9ISSVvYBCTb4R1PmUOFqyqrpgUgwASGTed+SYZWd+MgJVLt3HI3MaGFqKbtTGzlI77sUGthtKi/jspecL7FaKrsS1mIp+U9xa30wIFV/iSQy+dTrSdOToVA2gFJwz92Sfyh4AQ48hk5eMLlD6GwSClK28sfoUAJ94LwO4hym+j4U8kyIjDlD+IBdsIVu9bQnkIY2CFprk3EMq9ZIqTuHnyrjxGMtTNTzhQ11HsAW+VpjfkQbt9WnWTkwcuCs0wAYi6SRP/31q6p9VeE+r606T9VuBY+8riVqHAhHEVwZ4ZrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: paSjAHxCQVDgu5cEW0Nm6yHFZcDXtS9tFVVxwvf//f6KXZSAn8XTGAlz4hLRbdrZuzqZc+ZDj03tCTR+xwQWjQWNDVD3FcXfcnpalROF7cvXggC5+S01G/GBbuhtZOt/PaCX/RENkcNfuDrd8KicON4WFh8WVPDjv4XvY3fTpB8SG3wbr3nnO+VgVTrBN16W9ziZN/+eyrcyJJV5KFjP9DyQW5SLXjSOxkSMd536wCV+Kg59XcsEV0I5AzSuoouKSbQzxdZ75Ojs8JjO9YTwgx/C/dNoOSTtRROFyA3xar7hXSOKUFdmvF2h2xtXb+xqpTWd45BQOjD0FmMST2USjX9yzX/HV3HLnPoBEsQSAdYg/46X1SJJsY1CdvD82wH1jIY9rqKKpZ1BjU82c3+tG6P2GlmeTYU+w9B7hjKeNdSkBsKKmjDLEoSutQLRxu9d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 17:27:36.6441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11bb2ed-2490-4374-83a3-08deec045a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
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

The debugger sets the CWSR grace period via AMDKFD_IOC_DBG_TRAP and may
request a value of 0. An earlier change clamped 0 to 1 unconditionally
because most firmware revisions locked up when given an infinite (0)
grace period.

Firmware has since been fixed on most ASICs, so gate the clamp on ASIC
type and MEC firmware version and allow 0 where the running firmware is
known to handle it. Navi3x and MI350 support 0 in every firmware
revision and need no version check. MI100 never received the firmware
fix and is kept clamped. Any unlisted or future ASIC defaults to the
safe (clamped) behaviour.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
v2:
 - MI350 (gfx9.5.0) supports a grace period of 0 in every firmware
   revision, so return true for it unconditionally instead of falling
   through to the clamped default.
 - Confirmed the MI300 threshold of 96 is decimal. No code change; all
   thresholds are decimal and unchanged from v1.

 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 70 +++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 3d2375817c3e..54868b81086e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -309,6 +309,67 @@ static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manage
 		reg_data);
 }
 
+/* pm_grace_period_0_supported - whether firmware tolerates a CWSR grace
+ * period of 0 on this ASIC.
+ *
+ * The debugger may request a grace period of 0 via AMDKFD_IOC_DBG_TRAP.
+ * Most firmware revisions locked up on an infinite (0) grace period, so
+ * an earlier change clamped 0 to 1 for all ASICs. Firmware has since been
+ * fixed on most ASICs; return true only where the running MEC firmware is
+ * known to handle 0. The +32768 offset on IP_VERSION(9, 0, 1) accounts for
+ * the SR-IOV firmware version encoding.
+ *
+ * Navi3x (gfx11) and MI350 (IP_VERSION(9, 5, 0)) support a grace period of
+ * 0 in every firmware revision and need no version check. MI100
+ * (IP_VERSION(9, 4, 1)) never received the fix and is intentionally kept
+ * clamped. Any unlisted or future ASIC defaults to the safe behaviour
+ * (clamp).
+ */
+static bool pm_grace_period_0_supported(struct packet_manager *pm)
+{
+	struct kfd_node *dev = pm->dqm->dev;
+	uint32_t mec_fw_version = dev->kfd->mec_fw_version;
+
+	/* Navi3x (gfx11) always supports a grace period of 0. */
+	if (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0))
+		return true;
+
+	switch (KFD_GC_VERSION(dev)) {
+	case IP_VERSION(9, 0, 1):
+		return mec_fw_version >= 461 + 32768;
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+		return mec_fw_version >= 461;
+	/* MI100/Arcturus never received the firmware fix; keep clamped. */
+	case IP_VERSION(9, 4, 1):
+		return false;
+	case IP_VERSION(9, 4, 2):
+		return mec_fw_version >= 63;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		return mec_fw_version >= 96;
+	/* MI350 supports a grace period of 0 in every firmware revision. */
+	case IP_VERSION(9, 5, 0):
+		return true;
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 1):
+		return mec_fw_version >= 146;
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		return mec_fw_version >= 93;
+	default:
+		return false;
+	}
+}
+
 /* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
  *    register/value for configuring dequeue wait counts
  *
@@ -357,11 +418,12 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 		break;
 
 	case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
-		/* The CP cannot handle value 0 and it will result in
-		 * an infinite grace period being set so set to 1 to prevent this. Also
-		 * avoid debugger API breakage as it sets 0 and expects a low value.
+		/* A grace period of 0 requests an infinite CWSR grace period.
+		 * Older firmware locks up on this, so clamp to 1 unless the ASIC
+		 * firmware is known to handle 0. Also avoid debugger API breakage
+		 * as it sets 0 and expects a low value.
 		 */
-		if (!value)
+		if (!value && !pm_grace_period_0_supported(pm))
 			value = 1;
 		pm_build_dequeue_wait_counts_packet_info(pm, value, 0, &reg_offset, &reg_data);
 		break;
-- 
2.34.1

