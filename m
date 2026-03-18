Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E6F107BCF2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5123710E0F9;
	Wed, 18 Mar 2026 10:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mVeKFqp7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821C710E0F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Djmj5Zvi+4CPZP1zmIq8YcIPV2ExJtTGUVy6rdhhmNv3/hl+kclkl2JvuzUcryxFyYC20mzdIsNFkjCCzOGNiOrpGuz2Vip0A2ot1cDLaeH7TXPnrnDVlhezfwgXRualj8aORhW4UkVekE6gUe9AzTmuSJ0f7452wFw9SnsaQagCTZDV1dvopaAKn7009Dc/9RuEC8WZPFsDnsuOW6bixIsV2qNs5aaSw0XBT5d9qgOuu5m4KkvGqPYuMG9eAcuW4KaGWpUTk4c6DGYsWVFOD4qfsmxWSQr2zO1moDhkFLNtk6PUTQJbC6KldRuhcnXt7ADNjlRfmbUMnEo48laZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNcTog/+aHqq/G9wuY3CTYBqz8ujCBnHxiRs3g51heo=;
 b=o7QeXyOsorj3+uIIkJoNpug+uPwrnJd/N8UrF1tHS6Fyg/VCFIiLv04TGrGw9AVhQ9HggTNk3NChSC54wINobEbM4sKNeOaDnAJ8TciefbrpqMQ/mOy39ybQ9z3Lyo/hXwT3kXFrqRCdAHSD1JCXWE+lhlNqt0+oNlGp6Z86aHwvioWnh82bRyfrZdNyLBl+d8J+fIMYcK9sAjqCEZDS3zx3fi69Xk4v/kHzZMz0wCtVhdqfnHpKsSBGKL6IvnPLuAvhhFPl+a2lOnJhqN3jWy+CRG6VgXl4SyulH1OR5ZElqE9empAnzlPAW4Vaz/8Q+ZtKMpIckGnJ/yTm92QWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNcTog/+aHqq/G9wuY3CTYBqz8ujCBnHxiRs3g51heo=;
 b=mVeKFqp71EGYGgXaA9VIEd2ywH5OC6C0pFsltr7vunXHxO+lp2P8eFVYcak6pgDnxqjgIn2OEu+MuU3INW0uRenOlLMlWsWFOZ4t8vR3GR9OJgLUmIF87Vgdkb71d9jfK/CivYfrEkczdWp90OqHwBKnKj5kCmUkvv+7VfTqoa4=
Received: from MN2PR20CA0057.namprd20.prod.outlook.com (2603:10b6:208:235::26)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 10:39:28 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::54) by MN2PR20CA0057.outlook.office365.com
 (2603:10b6:208:235::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 10:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:39:27 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 05:39:25 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v3 1/4] drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6
Date: Wed, 18 Mar 2026 18:39:03 +0800
Message-ID: <20260318103906.3107670-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dead7e1-0a62-4888-b7dc-08de84daa13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5+WiB+pOopgbWrwaPMS22yyqzRypaL4ZKQXU3/SGYOyA863bNeTvk8/HLnYK6upQX6KlglKsxW9h5KjJPCB4ybAyV0JHM3RC6APIoQKGxzIRUk0MzC9UXqJy7AT+5siaaXrhNhe+QPDa+fmA3LdAm6VbGmo8HfJ7PsWxQFVepmc9YZh7xVqbi9IqrLE0ADfObfMXjeU2cMVQCj0P+HrS2SOkEQcDSJCHkKRzvCbP3xoWbjb8M8JHBAfvyZy4j0P64qiHrMOj+zhxYUXRTke1464OI027NxElJ9FgT2/ycvvlHCStuz0aO/GjITScNsNhit4rVHOU3nXV3k1LbA09GjW2oSH7Ij34JWWxjE2FsNnRKAauAJ0RhilxOobhB5nR4BuECWy4KwnTDWKJtfSpSJXUHj2KP9YUcsyyLbFHh6Rlp+Hp/dVCVIApuHvc5DJh7I+n8Orn6/U5/WReHVqovJ2fmpkgUmUdydTHb56WGPNU2p/Rb9GUSSsceCY6HSFbWixj2sNtjnZMru+qUAH8v2A+zxArcA1oWGdvApV1ZMaYGFEuewEIYUJd+CE+TGTApRkx3DS3pzOn5lmhg71qBcHzBBdS6glikINb3hokeVlSn0BfN9tUcsry1BcN/bRM7vFOtvuuDGNWX6EtDv1FE4njRZ6fCcj8yb2JtJPh993S2iQtk0DR5JEVa+1FCxZpaKi7nqmojwxQ+2BEVDz4j6iFZGp57zlC/BgASb4jsbw5nqsKxgGkF8+JcKKCJKB7ifWaiNMZnYfgjbCrIYjkCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OmmJ5omkXNz1lT6V0oJPjnfT9JlsAPIBi9a0kBNYVxXsOfHCXpTGDChNm+Fs/qME3sqdQlP9qyFQ+XImu1axt7XRS12j/+R3EI6m33acwJTNOKVSJdf/UWEoqutY3RJIFM+r5K94txWVDbexZhGcto32MRFsa3lg1IoPA9EUMC4a8ZCzfDz8yu6nadf0D3TVYP4YQk0CCNxhYoUx1ul0w3T/AiGa23v1cr8b+AdXm+EMADh14ZYnCGJ7bKFrmaeLYoYeg3LhN3ApoCcxn6pNX2nMN4xA8odqNKvyTO63XngB2yybTPDX11Kkz9qrvm7rNG2jkDPf3D4viudhLf3Y1FlnR71gaMm4xirz6z7HYy18fPGYJ5olfm5DYgM3+3juCLF/X+alVwn6OgS3pemNdZAmlIg56J9AxYPzQiMz6E0l3FzQ2uElsM6x+lSm+5C1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:39:27.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dead7e1-0a62-4888-b7dc-08de84daa13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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

Only reapply UCLK soft limits during PP_OD_RESTORE_DEFAULT when the
current max differs from the DPM table max. This avoids redundant
SMC updates and prevents -EINVAL on restore when no change is needed.

Fixes: b7a900344546 ("drm/amd/pm: Allow setting max UCLK on SMU v13.0.6")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5b9580034641..dcc447e5044f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2125,6 +2125,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 {
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	uint32_t min_clk;
 	uint32_t max_clk;
@@ -2224,14 +2225,16 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			min_clk = SMU_DPM_TABLE_MIN(
-				&dpm_context->dpm_tables.uclk_table);
-			max_clk = SMU_DPM_TABLE_MAX(
-				&dpm_context->dpm_tables.uclk_table);
-			ret = smu_v13_0_6_set_soft_freq_limited_range(
-				smu, SMU_UCLK, min_clk, max_clk, false);
-			if (ret)
-				return ret;
+			if (SMU_DPM_TABLE_MAX(uclk_table) !=
+			    pstate_table->uclk_pstate.curr.max) {
+				min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
+				max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
+				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
+									      SMU_UCLK, min_clk,
+									      max_clk, false);
+				if (ret)
+					return ret;
+			}
 			smu_v13_0_reset_custom_level(smu);
 		}
 		break;
-- 
2.46.0

