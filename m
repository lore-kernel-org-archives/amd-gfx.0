Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1266CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C4E10F240;
	Wed, 30 Sep 2026 08:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuZDWvXf";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C907510F240
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhy0frYz/D1eXDQ5Svj3mxUkwv5Qh2daMqd+anhdt636qpwLfWYiEMjpqm0RUxxncQjroytzFeuOY1Lc8ub1MROBbMp9kPY2ikXgA30aJ2TD5ZzVSGuDb4zBMckFF6qYA9OKiAJXUvFpvXaDRn4X+nydZXnDkOFO7NB2Xuna8s3hytyvW6WXHAQ4jzzjM3xj8LKWeq3yAuCyw4qh57KJvJp1tFg3FdvBHJOf6tKMd2Yl/ilOXKpGeqNceanHXVqW1jdBaf7IKoGqF0r+P25VjmcVjd+UIwa8WgViUlIm57rB5a+GypdcCL9FEzRRnU67UeSSygERnY+2L/SumHAD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0I3Um7D2F6PpBfNTAsKNcgqa+u1YZCgbfdl0gYRjDw=;
 b=IQ1YMw6cuKb9WJ+lytx1jpgdcHVNGkM81xaKoD/xileWu0kcNhXGB7ZSVWQgT7bSV4VXm0dPIF1kWdiiPtyvhLF+H0RdHCZC822+EpwgMal+WZlaDTJkHM1R18/0qzRiOnDqytXA5UYr3XKi5Caf5X6AIae12MBS8v3Yw0C4RrwW4iTMZhZDMdYe3fnLXQFEJwStK82gAwKdKGatqKN2H6HcZ9dJvlwbQPEiu6K45DPAO+hggE3w5sARg0v9popq4ZyGVOjtIk495b/6DKUqySc8YNr/LEB1eF15HM53vPsOvXpuh+0g3Hi8mIzcEG8WRa+0+QFVWmDw611OebK9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0I3Um7D2F6PpBfNTAsKNcgqa+u1YZCgbfdl0gYRjDw=;
 b=fuZDWvXfw2vQ6dHBGv5dXm20Lzh+Etaf6z5G+fj4z6KzVBvrjo6VOvktc5wTJTS5nB/PduHoOC88PPwFc18pDPjgWwTMjsyY25H6/SCRnKTzKaFJm6Eb8zBXPq3lG2m/INCEuy3qmPkYS6DO84Z2WLs2TqXVHy+QAKeRImG4AQY=
Received: from BN9PR03CA0341.namprd03.prod.outlook.com (2603:10b6:408:f6::16)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:40:14 +0000
Received: from BN2PEPF0000A993.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::2a) by BN9PR03CA0341.outlook.office365.com
 (2603:10b6:408:f6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 08:40:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A993.mail.protection.outlook.com (10.167.248.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 08:40:14 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:40:10 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: report bad page threshold only when exceeded
Date: Wed, 30 Sep 2026 16:39:44 +0800
Message-ID: <20260930083945.1362254-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A993:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: c171a7f4-55bb-40d7-6ee3-08df1ece72be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Jdft4g2a78E4CUkTc6jHWJP3i7MO4n1XL8uxbKIE8Juai2e99WH3FmzfxlaJWo+Yed+mX/DKiyjRLnlHYjviUo1Z0xJoRhexbfJiQqfW5tbW7pUvJ7zXNXaDLCxCEdnTUEFl9Qz36tNKCVoHh4pw9Yrh0OzaNsSbT3nYdJXSve4Li1zgitkGDVnRIU63zlVaxz/a67nh0nG0CV5Y/fs/XD/0O8xGqQxDI5Xs8NHGVy/JsM+vFA9Z2wxKJCAch6Sr3WQlizbcVi1EUf/imYNa/JuuvYW4CMrWwFORWcPj7mKjG9XlpP5aZ9wwkch80mgGiLBYarOpLQ2gzsXVIMAKJyUgH+enDE9uvHDaujN295hyKnHvjVVuuKam08HMvvsFxZMGDjtDgtxNx7tN6RX2rNyGxRwJs5mpPK+ALe3uIYak8N3VJoEG4ddPXirG+3eM0D1SugUbrgZSSNp9tClHaKSRG37DzwfOlTSKSe7ZVR4ZlfwLbs1weytzkBXIuNiI2DQXThymRGz7oNetbGAxUtl4rmSGqQVhBKqJC2p+PqMJa52L01kYHUd8EEsjKMMYkD0jweLxjcwMCRecadLLPn7DABZU86vMoqq3neIDcMsux286nTYTQhe/yNW+LNwfSt7KPON4An70e9Co1MnJj6Dpo2e/Kn8sAxy3OZdXL+p4MYN/HJgYNEPvCxIC9Qgqz4AIl7klDk0I9NOqQqIySw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CPV2Hu8L1JLgEduaSJuOqXWIehc3ICVxq60tvRBLrbJoPzTjYbqsuP9grb+5qtGpmyDVLYY4K33wPT3JHvQ3VXXrl9+hVjTl4r6VlsEZNU7IvaP8Ef02rNW2mO1DG3yvavXxpGhLfzL2+CuJzPALp2aAQag3pNWYNAGOLULAoiPuMQSLFKHA5mNxN5MCRk/0ZPYJNBCoyY75CnCoyU7kMIYSgOL+E8M2zDBoQb/7uNalkUfkCQwX6ULHm/cP9sDgPkzO2jOLer5ZFHkLOUqmzZ5v6ZylKTehBxeSoauGmQIJb5zWxxMM10ECJbkcpTOwwQcfOE0N+pWgs0XM84kRN8tZa3OSdBbSGhOergFaMW8HlLr+jrRh2AE6Ec8PUnSEq8uI5X1o7kG06caPBnizNbbF/Glok+UXhdbxayL5AZaof+UfoMHpil82402zRUPY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:40:14.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c171a7f4-55bb-40d7-6ee3-08df1ece72be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A993.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

Report a bad page threshold breach only when the saved record count
exceeds the configured limit. Allow unlocking at equality to keep the
EEPROM status consistent with that boundary.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c         | 2 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index e7aad113b98a..562763d33ac8 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -693,7 +693,7 @@ static int ras_eeprom_update_header(struct ras_eeprom_control *control)
 	record_count = ras_umc_get_saved_eeprom_count(ras_core);
 	/* Modify the header if it exceeds.
 	 */
-	if (record_count >= control->record_threshold_count) {
+	if (record_count > control->record_threshold_count) {
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
 		if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
 			control->tbl_rai.rma_status = RAS_GPU_RETIRED__ECC_REACH_THRESHOLD;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index 2f33e3132f76..e90f89be7ebf 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -286,7 +286,7 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 				valid_err_count, mgr->ras_err_threshold);
 
 	} else if (info.eeprom_status == RAS_EEPROM_LOCKED) {
-		if (info.rma_status || (valid_err_count >= mgr->ras_err_threshold)) {
+		if (info.rma_status || valid_err_count > mgr->ras_err_threshold) {
 			if (info.rma_status)
 				RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed error threshold",
 					valid_err_count);
@@ -305,13 +305,13 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 				RAS_DEV_ERR(ras_core->dev,
 				"User defined threshold is set, runtime service will be halt when threshold is reached\n");
 			}
-		} else if ((valid_err_count < mgr->ras_err_threshold) &&
+		} else if ((valid_err_count <= mgr->ras_err_threshold) &&
 				mgr->eeprom_ops->unlock_eeprom) {
 			/* This means that, the threshold was increased since
 			 * the last time the system was booted, and now,
-			 * the saved error count is less than threshold,
+			 * the saved error count does not exceed the threshold,
 			 * so that at least one more record can be saved,
-			 * before the page count threshold is reached.
+			 * before the page count threshold is exceeded.
 			 */
 			ret = mgr->eeprom_ops->unlock_eeprom(ras_core);
 			if (ret) {
-- 
2.34.1

