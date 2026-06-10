Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FCBCD8C90
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 18:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B87010EB23;
	Wed, 10 Jun 2026 18:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DtC1K8+R";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1CB10EB23
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 18:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ7NQcunlTUGoCQ7P1KJ1JAa30XWJtLaAi7ztMyQzIhPgs3b8tk6hYTHKt15B8XsQfp5owp+bUBd4h38cpM/L8lx+8bOC28zSOyxxFROrwhp6WkSesT7taqmEdNWvUJzho8El3PB1KHIPNALvYhzvhuPbWuGlFar+W0/xJoWle5rttmDwOa3ApzkxUvJPgGum+oc5v+pZqwL45MIdrSoIVTgbbhdYqanNKs2mIk6DG06M5nUK26AaADTGP608IyGjX3ImwNIP8UBnUdeAz4tMEzAufoY22ut/T2kEDqvgj4uqPjFvV+Xb1fQrh/hplFJFKkieR6358ymrIMsYUHU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD0CCDI/QcS/ajAQ7XQceV9gxzNepgm8Oi8Pg9t4v0w=;
 b=oemlp4VpUz+d3Tq6uDGlIvU33wMkl20Gn0vUelugRZzsQlHLp86Q75BqQgwdanQYFDdN2fdHAXofy5DzM6U+k/TjwT8zDwPJo8VCpjaPvybzEW5ksCxuYNCqdYt/hoqJcqtAr4cKDD5x+Tb94BUse2onojUoEfhhnquMI4AQ/g6z7h58e/HnbWo/1UVUkCDz32/jIFNl733aPlcykgWUkiAhAlyng8/S+FOZL7sFFJicAhz+IEPnPNcM/gC94q0LwTo0Hq2IklXNY5qEu372L0IOj6UjoUYgKXMfgWCIA24X3i3bXx+IzOXu37TIkeLlIcuKb0AicC5ArnO0dAAE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD0CCDI/QcS/ajAQ7XQceV9gxzNepgm8Oi8Pg9t4v0w=;
 b=DtC1K8+RkSlbXIRQ3qFqoRpggv3jGEpv7F0msK388sVIqdwlqPMKrKZUZB3JiRF0SCk89HYOYDHzd76QqoKXWsm5FNNjbNbEJjMCEIhOZTizYa88Fn4xupESlMsw4qnwaNtaAaBKUqnzezN/KO0m20Zl9QHaMbh/2Q/J5u9upvQ=
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 18:23:49 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::7a) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Wed, 10
 Jun 2026 18:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 18:23:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 13:23:48 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 13:23:46 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v2 4/4] drm/amd/pm: smu_v14_0_0: add closest-match fallback
 for DPM level marking
Date: Wed, 10 Jun 2026 23:53:33 +0530
Message-ID: <20260610182333.3922-5-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610182333.3922-1-Priya.Hosur@amd.com>
References: <20260610182333.3922-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: ba875be0-44d2-4129-0ea6-08dec71d6a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SSKa+ql7XooX48TxcECsX5NU0j1HKnQSV84Ce/tCuBmbp94uhogPosCOGjpnfzScoEjeOaoWyT7+4viimv38hBseOQIp8hsEuXsxr8J06WmNQVI3ag40vtG2ZxSEDFMXNmvEQu6382JCOPcK9neuHReWjDDDLavMF3j0pmHzzx+qAtaTgJoEApJbm4tE94q/qKN41zSTqo65HKeyUaoLjaf5F9tLsrV9oCJVwhSGphSn9C7V4MY5ilaLQnp2FJ8TJ5/JZ8v8PYNpHBvS9Kj8qUJFCzdsjxDdKtJMZsKGtfmwoV0nuP9TZ8ZC+eH3RZ1YbbFIZfqt4ltOpIxa9YwWyfwaygL0wb4cXaT3OdmACwCI3TxH68FY4318Ji5YcLVfDJQ9OA7raMPrUJJ0ey6YflItDtI858ga6zaGzHtQNIosLq3KW+0L82EofbobItELrMQ943jsLPcx6pAiZn4/X/MurIZWGEgsguvLO0YMy+70BiyxhUdlJ8nA7r2g9UJyAVYfYA9H8MkL3EB4Ijw5jgC+9SUMwX+14N2AWARLCo2+HAT9T4VO95N/3cQH4kVzIEoTy0inWDqfCJOSVehkS/7Arht9og6ddcs3BsfxsPBCQoiVTTErbCzWo3wHonQMY4P4lisB9ft7iK4vWrRy4iE/Ju80+ikCO5JvN6yqKXkfLtDmM1yArdQFq1Lq/XPZbhK8mXUqsQOB5yhHytqjI1lM61sPdBLv/3o2GR/ussE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RlsJnhQLxKXNkhgJMKK9U2JlqOIBZU2jIA2l9oXEdYXzUl9X9Qy5EUKduyIK/AntJbZLsck6Y6aOxMj5OL55EM9HrVow4248au1zQroBkZaGKCKqyuCXqFDo01LRtSVhahypWXvZ77Rs0+MrriIQFYEjFgf3Sk4mRnKDfIBeDdc5qqaiJIxaXuCcxfblvi8Mz8kRSHwr4cdMlV+4MSRKkDowJJ6fh7jWiQ3w30CMBBa2Iq1Mw9m+Rs6U07RSoVTWKq4DWRuuLJE7fok+qbvDvcKHAIRCXeEJuoKLXrdK5gXIpgrjdev4cS4E6Q7KhNacQ00QpytgvhgXuT0X7f/9IuL+zQid84WnwDvww0SitdDFG+cwm7Os9AIs4o9p5vTR9yUwN0oNC42qnX9/T+GduTf1PSJQ7X9Uncb5EiR/HM+pjQ2pWb9+Qti0ho/ByB2B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:23:48.9085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba875be0-44d2-4129-0ea6-08dec71d6a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
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

Replace the simple exact-match loop in emit_clk_levels with a
two-pass approach: the first pass checks whether the current
frequency matches any DPM level exactly and also tracks the closest
level by absolute frequency difference. The second pass emits the
levels, marking the exact match if found, otherwise the closest
level.

The SMU reports time-filtered average frequencies that often do not
match any DPM table entry exactly. Without this fallback, MCLK,
FCLK and other clocks show DPM levels but never display the *
marker, breaking userspace tools that rely on it to identify the
active frequency.

Also uses reverse DPM index for SMU_MCLK since MemPstateTable
stores levels high-to-low.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 53 ++++++++++++++++---
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 1be8d1a8da19..c01c71acbe3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1190,14 +1190,53 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		for (i = 0; i < count; i++) {
-			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
-			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
-			if (ret)
-				return ret;
+		/*
+		 * Try exact match first. If the SMU reports a time-averaged
+		 * frequency that doesn't match any DPM level exactly, fall
+		 * back to marking the closest DPM level.
+		 */
+		{
+			int closest_idx = 0;
+			uint32_t closest_diff = U32_MAX;
+			uint32_t diff;
+			bool exact_match = false;
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				if (cur_value == value) {
+					closest_idx = i;
+					exact_match = true;
+					break;
+				}
+
+				diff = abs((int)cur_value - (int)value);
+				if (diff < closest_diff) {
+					closest_diff = diff;
+					closest_idx = i;
+				} else if (diff > closest_diff) {
+					break;
+				}
+			}
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					      cur_value == value ? "*" : "");
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				if (exact_match)
+					size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+							      i, value,
+							      cur_value == value ? "*" : "");
+				else
+					size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+							      i, value,
+							      i == closest_idx ? "*" : "");
+			}
 		}
 		break;
 	case SMU_DCEFCLK:
-- 
2.43.0

