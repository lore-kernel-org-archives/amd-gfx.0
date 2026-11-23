Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED0606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HHrU1At+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20E510E086;
	Mon, 23 Nov 2026 04:19:21 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1786210E2B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 04:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHcZf8+n945nzssrjjrJEkURxq3OKWcecwtxFlw7XX4+za1PMS4I+nkbpBNOPFVADm1iPjvTg0FULKF7VSSAc+89DWsz0AyxgzJUwi4olAkfIr7V7lFOGPE+znZCzXkOFXfvdh4Ad8zs7i/N4NJ53iw9D6G5366Izkd/IZshK5XPypCxy8BYkG9Uw6p/PFInVV2HEe6df/T1bdIkhmDshJe1t+IuwBZait6dYVFVGUQW1T757j0dRZnMwDcTGsuMla9QXR0WHuPBuOv+8vdb7skyb/eE97PiVpLF2AnFRPp6sVVwFEukLXvPhEa0cZ384fUWMZIDi6Bf3QhLGUSLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku7Fz7ltSy+3obVYcbF+2NqFOKS0HXBkCXVai8JuS8M=;
 b=Zciq0KT/YALvVXYWEUcg12mjiZpojGAqo2d87dGOwjLBlpQrFGFBfX57dBr+9fOzl+d8HMRF5NoN62lW7RhLEgIiYjMLhxS4b2Eupsivx6HRnRiLgAjQxCAcwpZmxNGIq4X6zgHszl6xYVpSEbF5GF/gSrT7FzpSNvITKzndSP+Dbr9WT5fWAJIPeimg7U1xq+RODffS0Mg7XsweRzlRfLDopOE/dm1NDWYElma7UD/6UtPlZhxGiLl7PxycHfrbmv1ZCGvBo3ITivEbaIZgeLiiC3rUquungE7W+3QeWz/zZZ4OMcxgwQWEblfRop+PDlNHwnmSoIepLpTj87jcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku7Fz7ltSy+3obVYcbF+2NqFOKS0HXBkCXVai8JuS8M=;
 b=HHrU1At+Qi0nwDeAPAWcGRm7rNKMbsTXEYeXcHKgr7kO/A/JwPsX/4fRGDFszhxN5NZmfkd9X6hWXkJUt45A33QGar4lAsDq+e8+RO6KsJ5wfBUR9RSHxRsOUK6Tv29MCN/NaempBDYvupYoHyuF91R19XVW8iZWBSroDqM3CYk=
Received: from CH2PR14CA0058.namprd14.prod.outlook.com (2603:10b6:610:56::38)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 04:19:11 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::14) by CH2PR14CA0058.outlook.office365.com
 (2603:10b6:610:56::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 04:19:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 04:19:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 22:19:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use min/2 as deep sleep threshold
Date: Mon, 23 Nov 2026 09:48:50 +0530
Message-ID: <20261123041850.2586764-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddc37da-d309-45f5-2702-08df4918ec9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|18002099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ZhE0kB1I6WSkUDOHDWvKeTEX15XVXhTvz95m5j9OIuO2UyLseq4N6YCw8Kq6S2wLHK+HeQ9XiYgFqUX81HGZQ0IyQfcutpG8wmlE+5CcVypKpTmFIJBXbnyii12fQuQtka9bCGoGLk2BubKSk9YZLviztSfQguJkUuzoevVYMROp0CFTR7lPLW30VQdOSsrrskH5IezERvwy5Dci5eKiZ2A502VBkMkNNFMFofnMNY9IytBzFiC1SqDEkQW8FK45Nz/sdRg2Pm0N7ZQ70xD3qEXimy3b8P5maWMqy2e3I40r/s7Ar0/k7mAvhXLtWwnq3ccQlpiKn2qomBaP7kMxOAs+cabnn7xxB+e3CtRfD7fKgn4lQUDxdIQBPIZq3uFaXvFbQ1kIPTf4siLM9Aam3WiY1V/bdf0I2hcNnTMzukFeGWWwn5EttqGUnDKTP0a1f0s3pr0B4t2Vu+2DLdu0atuj+OKHR5HYmekXAW4U911Drh1IEP6WQtKdM1baXlp35G2TbdXmZP5MvHbyCc65lRRNktbNiujMJcan7OCresrdPfqIifEiFeQpmMncr7TbCQ/JbLwzThI+5izqc8e3xs977kJYNkY6MestS/kj2cb9qFjiFD90+Dz1sCeUAnWChIjezmWRQAstHDYzJFFJD0/r33Pi3FeXe4ChfgEs/Dl8i8MHe0+TxzqdhHxQGWRA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HZ6xaOIWiXFDn+VKEV4prlCgMToTBEibvVW5avegjMrKXHWaOkz3iTQJ2gEmhx2GZuuO5VNtTmVf1JsNW1XOOw4TstCxywMyVKXOr4oop13G4r5lP6oUuzvF/nB9Y8iFCgI73GTWjSSHt5+AFALujC8WZrx7mf9cPn+jMT+/Kk7/ueBYDRBY8rEOtPEG9dd9sJLmhPBbEX6L2PFfr23jNtpj6xOpLPxLYr3TBTV2Z8E4X4iDJ19TknQ5glzQYvnX26igisrvk+WsVRhRz4HTOs+IKUH0bKkcUnQQAZCjyEhdSFdLUNoqAly82gY182uMiUA3lWzMLwQYCsk63QjWqcW4q750uaOa8rfWNUEeaZBvMZsB6H4CgPqg8LzEifYdeWmETrBRRwkJNL1QT4rNdlws99jl3poNuVTMECQav18ZqOwbr07pOJ/J3STUJrHO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 04:19:10.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddc37da-d309-45f5-2702-08df4918ec9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Deep sleep clock levels are lower than min clock/2. Report as deep sleep
level only if current clock is lower than half of min clock.

Show current, min, max in ascending order for fine grained clock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 4b31c99ab7e9..b83ee7cf56e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1428,8 +1428,8 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
 	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
 
-	/* A clock below DPM0 is reported as a special deep-sleep level. */
-	is_deep_sleep = cur_clk < min_clk;
+	/* Deep sleep threshold is half of the min clock */
+	is_deep_sleep = cur_clk < min_clk / 2;
 	if (is_deep_sleep) {
 		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
 		level_index = 1;
@@ -1475,11 +1475,25 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 			} else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
 				lvl = 1;
 			} else {
-				/* NOTE: use index '1' to show current clock value */
-				lvl = 1;
 				count = 3;
-				freq_values[1] = cur_clk;
-				freq_values[2] = max_clk;
+				/*
+				 * Current clock may lie outside [min, max].
+				 * Print values in ascending order.
+				 */
+				if (cur_clk < min_clk) {
+					freq_values[0] = cur_clk;
+					freq_values[1] = min_clk;
+					freq_values[2] = max_clk;
+					lvl = 0;
+				} else if (cur_clk > max_clk) {
+					freq_values[2] = cur_clk;
+					lvl = 2;
+				} else {
+					freq_values[0] = min_clk;
+					freq_values[1] = cur_clk;
+					freq_values[2] = max_clk;
+					lvl = 1;
+				}
 			}
 		}
 
-- 
2.49.0

