Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D54C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 20:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E027310E222;
	Wed, 15 Jul 2026 20:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uy9+28we";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD8C510E1F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 20:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm5nHTCgKA+SlpJaGES7CsyEt6CqQrIsgXrMpPyAcnPqxriTKqtRrbOBHjoLuW4NOuhrJrzBwdyRLrnY+VWoIhvjuTLZbxIzqpWZ8jXe4F44Br+qWV4aRvewhA4mnrIF/BtRUzaQydyIqq9un4H+uslKam5Qe5n43zbBUUiAOIhA5bHMc0ssGpQhQnKeYZfLCK/3apgcw2pVEGRkGuHiv0dDrMt6AtSz8/OWvLQg+YCrsA21AUU4mJh/JAYF5NEoOtK//IHYZ1DSE5dXEOfQUU5/k079lr4+p9DA5tCgHIyz13a8fw7hS56sr9J7thbTsSTB5OMW/pbI8si41UvK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPAE516Ydwbk9GmLLbZMJLVNM8pIGTPZ/cEg09+w1SE=;
 b=nVr/gFw5c5QMj+MAnP5oQBPlxUpVWV/LU+Ju9Hsk88OaTspjsHkSJMLeTlT0wlPOUve2t9B41QS6sqTQIn6uucXbM1h0VjbTpbYMlJA8YLt7QnWWYXDPZtr0FK2zObkYqemGyZ2m2VIQSk/Z1KFjvGD+Fo/JgsdCWbJtgz2ssyHb/6AkbZP8C4OTjaAkis+Cay2H3/QPfHIwouI1/bOvkXF2xPZA8pbmUYJYot56yMc3Afj3iwZdNjB4JxI3jrHxF4p4OmgV9UNHSABO3x1Pw6dSyt5hidI3ZWqQPvSEnjuMOtrC/x5kMR7Yukwj/7t5WvK61IMB3S8QsuFLn2p1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPAE516Ydwbk9GmLLbZMJLVNM8pIGTPZ/cEg09+w1SE=;
 b=Uy9+28weCAxHs8kvE7TwBc85OY3Leh3od0LjBq9AJ0pfYZmzZgrDbmzYjVfOeb2KC3fDj4XC9KBWus5u2L8Nj+ic9iGhABUTyPXjk3yE23yjYF85WarivQM+v/jLmXDrvwcS0mNIC2l0xbVIK4pde2LN947DZVYQmDPAx5nSJwY=
Received: from PH3PEPF000040A6.namprd05.prod.outlook.com (2603:10b6:518:1::55)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Wed, 15 Jul
 2026 20:02:11 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::6) by PH3PEPF000040A6.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 20:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 20:02:10 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 15:02:10 -0500
From: Fangzhi <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <aurabindo.pillai@amd.com>
CC: Fangzhi <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: dispatch compressed FRL cap check inside
 dml1_frl_cap_chk_inter
Date: Wed, 15 Jul 2026 16:02:01 -0400
Message-ID: <20260715200201.2458988-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faa7ac3-e3fc-47d4-e6bd-08dee2abf4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|11063799006|56012099006|3023799007|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: SQ16hcI147+4x13Q4UoP1+XxcwGcdcCH2X1EhXqvPA2JYZgbbnvbjV5zoy31IoiXGwcwCMNPz7Djyf3JDLgUQCokpuZcfKo+iVuWEOp4fs/CWMR3fjrX7pvD5JZBeU/0HLZJY61wZxF9cQ1PFmGLGrukVs688TkqajISKvjdRHLnNdYT1kOivaXb4/aCEgcqAX0sLk+pPxCpRJn1PNoohfTlWg8OL/7iIw6w+/GQV3CwFLVrbgfX8imS5c7GZH1BszgEb1DCgrxEcM6B9WMkX/guigu6KD8eJYT3Iqu7U/dQ0ppM3uNoSJ4jnaPMlCTupuzGz43tVNMxSC9/6pfxpcEwqA+KMFwpunltzifgCgGeliWkWnFCCwxNpnjWjQU9L/8fxLtBkT7GyRUraaM4mQkbBcOflA4knkVXnHcQP5/f6RwTfIz0O5lAJdo2Oni2qsxwecZRmCFpz22CWmkk/GA7u4+faA3gNEg+8Wo6BBREertCIUYrtnRmRI5UjJbhF1Gh5vnGyOo68YruOYxrDDRVjlu8mYR8JwSH/HE44Au24pEskHtjVZlFH0eSkhmOp/MUz1iFblTIF3JJ0VUIEXSxmOlcO6A1v8F5jhaVfiVhrkwVSEnYfaP57CLph+BrmKJBSIIJMe/OCL7iyvKBtY2yJp5ItLA1AJ9E2yH4Bk15JXJwgLNBVQJ9IUR2aF+WBWGpR4v4Z5xkwuwZ97MHrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(3023799007)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s095SaK6k6IuZ6OZzywp/3BdPKwklOQJ9aokMqcSUjlxdp4gIiQGeDREBzPazSpPYL6eBhh8VFju0zT3GK21DGFmxs8I+b8uBlRt6/z5jlT/PE4T2fYzuCYRjvroQPRteAz4nzf8XwmaBWdQ3Ghl2egGQtcuvFTyra1yKAiTPdPlJ/ueetHVMFNLefqGq6voX3yK1bE6Uq0AK0OpBuHm5zKwwkU8RRZRqAk7Ly/ruY1vOST/rDSCRBMuUrNKnRC48dPGJJVTFziOs3R2kZkgGev+QT8eE/u3pzr4loW57IN/d4vyR98WG7WYS8LJ+VouwRWAF4ogtpq6cfRZzNA3Byx+T0VXd6TAAu8kVnYl3wKmmhYGqe1Ov7Nr4XAhGTm4PZkkathp5+2eS/gpIPNZZ9zrTB8GE7UdM6YgchdYosK9I/YdpX12OFRpzPW6QCHu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:02:10.7178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faa7ac3-e3fc-47d4-e6bd-08dee2abf4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

[why]
DSC over HDMI FRL (e.g. 4k144) was pruned by DML mode support
because the compressed FRL cap check was never reached.

dml32_TruncToValidBPP() validates the FRL output by calling
dml1_frl_cap_chk_inter() directly. The compressed-vs-uncompressed
dispatch (if params->compressed -> dml1_frl_cap_chk_compressed()) had
been moved up into the top-level dml1_frl_cap_chk() wrapper, leaving
dml1_frl_cap_chk_inter() as uncompressed-only. As a result a DSC stream
routed through TruncToValidBPP was validated against the full
uncompressed bandwidth, failed the cap check, and the mode was pruned
(vlevel == num_states).

[how]
Move the compressed dispatch back into dml1_frl_cap_chk_inter() so every
caller of _inter() (including TruncToValidBPP) honours params->compressed.
This matches the internal DAL tree.
---
 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
index 260f58a97fc7..da2c92e5c02f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
@@ -630,17 +630,17 @@ enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params)
 {
 	struct frl_cap_chk_intermediates inter;
 
-#if defined (CONFIG_DRM_AMD_DC_FP)
-	if (params->compressed)
-		return dml1_frl_cap_chk_compressed(params, &inter);
-#endif
-
 	return dml1_frl_cap_chk_inter(params, &inter);
 }
 
 enum frl_cap_chk_result dml1_frl_cap_chk_inter(struct frl_cap_chk_params *params,
 					       struct frl_cap_chk_intermediates *inter)
 {
+#if defined (CONFIG_DRM_AMD_DC_FP)
+	if (params->compressed)
+		return dml1_frl_cap_chk_compressed(params, inter);
+#endif
+
 	return dml1_frl_cap_chk_uncompressed(params, inter);
 }
 
-- 
2.53.0

