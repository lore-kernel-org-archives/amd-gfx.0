Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61698CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 12:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F217210E917;
	Wed, 10 Jun 2026 12:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtEg7ZXz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7560510E91D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 12:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PU9tZCEvyO4ESJCh2xJK+IRkwc+C/iy5q/SWTITIwCL/2MbVGR5mz6AYt1lvZa6kqI65CZAYysR6xAT6oAXFyb2o/4hzZawzLPesTAL9SYOLECHoIf7Sg0bOCqlKA30EgFD8UrnwiSIjM1523NjQ2XLf6rGgOHNkY5k5S6izDzzodyOa5ODEMeJqbPelKeXDcMlFUOzOiG7Oi5z183tB/NWLNSu01ovXd4lkxxzfQngcHhMZrTabpAOvckuEkTDCzd8lQAEcdt3wkd5BKYz+lXup7/Uhb30omK7wXn4R5VYOQwSvF6OlaGOcBzDkI89hYGyaXegNwgARmlXHp7VYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmNw9WtT0SF2mHZeHCag3YnA/I4CFVCrDsO/g9C8m7c=;
 b=zD5MonUUlUq2T57UdHSFcSCurD+A7oHwOmbMjxrMX3GdlFEQQ3u2Bt3pDtpUw3QjXo5tSI6Z/vR1qbXuihVvH/XucCKSqwa7vtKU7yNt488Dl7fECGp73upTOyFlREDXPNDrQaHFCzIosexrcQaSu3z3zbNUtJCyQNWgGsu6wVEU297LLXY8XUgybjtynICGKLGa0GAK+kjzwgjUam0K4GiJUVK+8FM1DzJVZLJ9DFlivbQG9GlKaie3uI1MS4wNj4OoPbBhxSX85MeIomrIaGXLQHAw+SYxRAQj7z73nRnQfHOCoTOyZnHyo4F0VKO4rqwHNpmz1MZ3z88iSESszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmNw9WtT0SF2mHZeHCag3YnA/I4CFVCrDsO/g9C8m7c=;
 b=VtEg7ZXzz//bjbaKxoF4uSr+lGAbm8uEsgZHrayx1i3CWuEcN1/aleqIYZXKGjo1/lGX9mAyZq7NTBoiAGXU6aC0uRKt0km7MGTfA2ag9vrcXPth0Dd7FeZmLgmXNYztAmhQezprXcJwZCBOjOqYhZVQa4igoX+yUvcSLX0vko0=
Received: from CH5PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:1ed::20)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 12:11:52 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::5b) by CH5PR02CA0018.outlook.office365.com
 (2603:10b6:610:1ed::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 12:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 12:11:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:11:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 05:09:58 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 07:09:56 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: smu_v14_0_0: add closest-match fallback for
 DPM level marking
Date: Wed, 10 Jun 2026 17:39:44 +0530
Message-ID: <20260610120944.124040-5-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610120944.124040-1-Priya.Hosur@amd.com>
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 9880e2cb-c572-470a-e77f-08dec6e974b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mabud8kfMLu6j8uYel/VWeGW4IBxWHeQjzG5CLBEuAil8Aqu4e20ZjjXHl/uoSQisAAwmL4WeJht1d7bIOUIJQ3WVnGtCYGX8HMlARZX5GTyi9L3ZnzlOeA65DvBcwitCq3UNLYo5NW5mIOMCkFIHoohhLbMC1U2uzTlHaeXltO+tZ2vY33mTgDA+TpSoDjhRe7ZQj0SXiNw8oc3Bdu8E2PMfFMnZ/nelaLpVw9vW29Z8YtObLiFssIwa4PODllqyk84GA85WV+ENfhqyu7tt2jnjhRBBPxgRE3VK1DM75zlNt/TDVtdR+s7tj5hmioGUS5/k3jzZuzaH+JL1esy1sEQaDBrWBn3L8Ua723V3V2qy95ABn9+6MTmW1hBXsRijA/JnIbXGjsSabQkEPIDKXQ4wdVQfys2DZbALdSyKXw2uJWZ2HFsLrRDoI+RbK6jZbGJdzDJUy5NHRBwqCnoj6YKsKcIG+qK0jHq+xbEEcpyTMUT0XGrZiPbaDyXuuSSPvPRPyhMlfLg97K63FEGExojWgSmPH+mhZeyrdjBl7Ik8MDzv/kefMKv1H1lL22JdIuU2zTnbDFzhE9kXy0ZnSre7XsDSz0ICx6KRInqOXuOJVqPFMNdWKdR0eZtkFgfN7NFOSML4877wV6k49Ch7n+ODMGSz0iuyYhs4U6bQLHYZ+AVc6YvpTNyD5lSJ7239pZrasZG5+j8N4sEplk5qtuDgxGddGWvDR0sJqk1Ivk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YyPH+ggms6DzrSpmfvSjkfYsoNF+8Vd9FYpBzcxq3fIOfzIIY6BmTRuimSYomL23vX7YV/JRvtDKt3xZ9HVf68kkybACPrq0sbz4KGul8V7Pb5StXEBt4RgZQopPKqGsD1Cg2xSgnUPWKHC2NVvQYJNe0+3whr+8dH1jxvNNyeR6tQxmM7Cuoks7EDraugCgyePepcgx8BNfdXxP8yt0OtPImQiUVtZIW+0DCim0192SReKDr1wm+6dMzHjxhA8hqLfEtrJuxdIUWirAnkCkSeex0Cpp1ulKzG5HNa1MEIWQjksf0q2Nmz6HPTOFQNbNifgR5l+uL2eg/mtOqmF/XCM/9l+CVjkNTFGQ5ZqL4d7ON2jyVK017YGJg8oYAe1f2oCnyHZ/+n1imhWaAYu0SHm48s8fuwwcm4k0tmfVPzSlhp2YlcRXPhcMnyy7NpSp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:11:52.0334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9880e2cb-c572-470a-e77f-08dec6e974b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c203e828cce4..b113cf2b26fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1195,14 +1195,46 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
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
+			bool exact_match = false;
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				if (cur_value == value)
+					exact_match = true;
+
+				if (abs((int)cur_value - (int)value) < closest_diff) {
+					closest_diff = abs((int)cur_value - (int)value);
+					closest_idx = i;
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

