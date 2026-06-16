Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D3DCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64CE10E12D;
	Tue, 16 Jun 2026 09:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lnBQv8Cx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B890510E12D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAcCmTGBsXgk95ykWumQJI7D7lp2w4vANoYyKI4MNDN5jJnp3RjrLITh5CH9aB8xbVqjJ0fqcmTe+BPhUafFhKQQ9Gy2eKJbUdQzG3u0RXtlvfwU1njKWErl/EDYnr5AgdCJcIP72stMibRVbD0eLiEj37gmT7K1ow95scpLQ2oRKBe+LivbKSnPgF/MuWjkeOnpuhFG2cHUAueoXQfX5sXUKSLiA7Ew2iF3yGHZHgfBJdM3qxJk4EgdXt7l8wQuBu/Ad1BkP7jnY6zqqKW6NFEd/UqHApW6negM1GKkSU02v+u04wnZkqaevMHGu+yjuau0/qooOztLuaUcyIuhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=OzR5TigJySFgK0e3lfdjoMnu0qNmVDTo+u6tBqGr+hjpBpdEqh4KmUSnh218absgIo/bcEVYqh3ob4hn7XBHgTd0rdNAz32iQJpO6YrRmKoUv5xjlb05P85ancEdJ7+uH2Prfa0jA4M3p5NOzaDZsuDHYd8Sl80GMol8kednNzzlYpmswHshqiNxCkWgLl3disBBSWnhRPzZzGltDETGjTNbsx+4ZMwE53joWVeNcagXdwS7pIEH0Hm5o0mLAEcwI3Xx9QefMIqyisLv9V2X2RFoxnmxvI1ekx6xShsEoxeJiPfsBReFV/ZHi5uE6bTEhfM85EErtDN5Pb9QPQvWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=lnBQv8CxWEvVM8cJNiO2UOjGvvjlPpyiBQEeqTdbq1Ca+2kK9Sa/vwj6o5+82CSt8f//y0xUdMFBnyaHQe2FrBVPsTemYfj7/CEcpnMWN9fHEyZrmUdB1d1vdRGNAp4Xn7JO+qCU5yvvERXDl2JvZZI1uLeW1/Mi9xcZFp3sI7Y=
Received: from BL1PR13CA0403.namprd13.prod.outlook.com (2603:10b6:208:2c2::18)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:25:19 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::8b) by BL1PR13CA0403.outlook.office365.com
 (2603:10b6:208:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 09:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:25:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:25:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:25:07 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 04:25:00 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 4/4] drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM
 level marking
Date: Tue, 16 Jun 2026 14:54:56 +0530
Message-ID: <20260616092456.3973-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616092456.3973-1-Priya.Hosur@amd.com>
References: <20260616091731.3722-1-Priya.Hosur@amd.com>
 <20260616092456.3973-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a75136-56f5-4508-d56f-08decb892e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|11063799006|56012099006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xK7Q4/JjI/lIipnJu8oDBWAe2KqNdcJE8ZcTgwgqsB6tBw5biCkHDIPKFCcEz7CI2Bzqog74TZqHP5Q0n7lJkHFavtNu1n9qMoHA73rekK+S7bu+8RvuRMpRIcPMPeOUWEjXYbTZZhB1z3qGK6KS27uDbPQvTPW43GiS1KhEGl5NqUhYRXSzpG2YOl0Abae/EaB3gFxaS/XEDhyXlvSznWkVTEqhE5xp2LHhQ8Yby+Ou3CzMHkHj8/UKEQM0TJlEgk+EYBAK0Lo5dqfTAQBh9whV0m+IwsDuc/Hq6n+daLzVAcpXZofAjSeFbeZQ0QULdiqeVEYEy0hCyuh1/gg+Rg5NbQa+7I4jI75HDN5ffRwEvy0AIsKtsJumqdZ+0Vizy5e7rjf2SuJauLpJlhmPsGmr6o8qN6j2vWvFuQV3U6LbEabVcncGIhvksnIhGSYTV1B1jTOet2VcqA4WOpGGTM1/wEP2j7X/Uo6ixUoZr13aEr8W9V0hZGGlAVVNIWRrLZrMln7DQhuhk5g6ZZoLK7+jPRIWGVcCk/tZIdI7lVCr0c9KA34k0n88bXWgy55ikGI/E+9uNMrD8yZQ9o5SElHxynZQbZyme49LOcWCuO6iv3AbScZkTYd6YEJlDv3Cx7eAMNyuw1Sc+kpI0v8jzg8y7w10USNMxDZH5ORKaBXgjy5pjhoWWh6ErzLx4SqG4zrKYYfyjkRoA8gocENEz05kZRjSQvYobsHaIJ+guBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7sz6Xkb49w4WI3L3QDLzNfCxidTjJft+Doc9bpM7IoDiSJiWNCZTynjOel0dS8LFQ6Jgu2m1Hj51a0MwbmjFB8sdmFyiPA8mYVHnTlfOclT+ftFkppFxgc3S9s/gih4wJuktKFqsc5pxnKtVbyBiOUAYMRuNm7F9qBZxoK2mZGkiwYiEVTlV95TPq0BOX/LAc+XsgLpEjLGExCM6OCQkpOuE3zqlPn53aTuxE/tKMXfGqJbF3WuLHkDNL5OC0V+Cg41DOYpKIwt3fU9so532s0fnWfKMMIFkdnOJT8Eno78HO/UptzSIJpcsYdRygAei3vS1PIX6MlBhqcUi6LLtblZGtas5CAWK6l/YkTmlhbgiLdnzBctnujCWy12S85TuVvEhY+sdm5hRg9zoSODUY7Vm+EOuQAikN6JKnCI1We20ObxBGlm5iuIzhUHut6UX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:25:18.0445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a75136-56f5-4508-d56f-08decb892e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

Replace the simple exact-match loop in emit_clk_levels with a call
to smu_v14_0_0_find_clk_level() introduced in patch 1.  The helper
already handles both exact and closest-match semantics.

Build a stack-local frequency table from the DPM levels (using
reverse index for SMU_MCLK since MemPstateTable stores levels
high-to-low), then call the helper once to find the active level.

The SMU reports time-filtered average frequencies that often do not
match any DPM table entry exactly.  Without closest-match fallback,
MCLK, FCLK and other clocks show DPM levels but never display the
* marker, breaking userspace tools that rely on it to identify the
active frequency.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index f273b95928c9..9efeaedbe317 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1243,14 +1243,29 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		for (i = 0; i < count; i++) {
-			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
-			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
-			if (ret)
-				return ret;
+		/*
+		 * Build a frequency table and use find_clk_level() to
+		 * locate the closest DPM level.  The SMU often reports
+		 * time-averaged frequencies that do not match any DPM
+		 * entry exactly.
+		 */
+		{
+			uint32_t freqs[NUM_SOCCLK_DPM_LEVELS];
+			int active;
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &freqs[i]);
+				if (ret)
+					return ret;
+			}
+
+			active = smu_v14_0_0_find_clk_level(freqs, count, cur_value);
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					      cur_value == value ? "*" : "");
+			for (i = 0; i < count; i++)
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+						      i, freqs[i],
+						      i == active ? "*" : "");
 		}
 		break;
 	case SMU_DCEFCLK:
-- 
2.43.0

