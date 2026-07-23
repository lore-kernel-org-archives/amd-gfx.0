Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C437C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCBA10F1F4;
	Thu, 23 Jul 2026 20:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hzt7GjFT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A515D10F1F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUvVS03s37IfjirP0aTALGuzpHdwVqNwojUNRvYffFMjY4EZKpeULOL2dCEYtzv2jZpRCZJE+Bo/0LIr+ved7HKMk/aHxJuK0ccHt1dgjO9YoOZ++E6GdaSSQx6rW6a6XyjFIhqoM+VMB5p0FqWfpQD69Y81OhsSh6lCKX2SsNn6I3LbIdqxV8mSRRX6hVu4ATKCi68EOWvIyjL2orLbpTZFX/UQLfZLophcFxjz2ymhOIq79tWg48hxSHr02WAHZb5s4LUMWOit5CoyKjOOhVjZC3Guh/baW4RH0C042WbsF/HWsxOWHCrcKqd5MzsRAPsjwMjf9BRQdQzaiP7VGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/ENMOKOOhD7hFInLwLi8I4CP8EjrohZqKIu2d7NFwc=;
 b=U+q0SjjSgWwrte6GHacwJFP65/jNP49nZDyN+2X12H2qDLgWBeHxv1QXRIulED06hWDvYZ8l7VXbyGtDLtE9a03w3MXbT/usQNqrElM6fLhxcxvY9ompz7bbEL9t6KAlGRwiGqQZJ0zD0L8mBpJeVDonIR/95GfPX2vOKeORhX/CmyuMN+vvYLYvJvBxxAkBKMA7AwI3mPu/7tbewS1ch94XlldmeBFL9YEdjQq4HrmJiPfDovcj8Eg6LWM2oLSnNbzf7B8bSE9XjNMnJcGqLuunn3on3OOoaWjublrCpqRwqvVeA+0SNGCjcpb5E5iFaerVAeEl2wzhuWFzKZuU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/ENMOKOOhD7hFInLwLi8I4CP8EjrohZqKIu2d7NFwc=;
 b=Hzt7GjFTw1fkbFVuIFdy161Jc5C3MhIJPjWguCCgsWXYW8ZoiLKAsdwMZkdzam6ATj1alg1Wp4xrs3fnexjBA9GVTnCzLw/ifblPklJSIRhyzWFZmi7xCWt4k4tSbNBuFZR2vN2DVXYY+bB/IKu3sJEQqjGQE4fJD/O325WIv/I=
Received: from BLAPR03CA0067.namprd03.prod.outlook.com (2603:10b6:208:329::12)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:20:06 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::70) by BLAPR03CA0067.outlook.office365.com
 (2603:10b6:208:329::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:20:05 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:24 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 48/49] drm/amd/display: dispatch compressed FRL cap check
 inside dml1_frl_cap_chk_inter
Date: Thu, 23 Jul 2026 16:13:56 -0400
Message-ID: <20260723201908.373300-49-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: c989ce69-2246-4916-bf0e-08dee8f7c8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|10067099003|22082099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: dHjTYWW1vd3+xzlGGoJtGE0XE+onhRFc0aZY3P+a9tJZs+HmDIdT3XEbKYOy17MhxLn8p2L6Xffte/Mqo2AeLUCCL1c41TO8JpEatJemh10QYujk1WCklSso8CRo9eer7lQEhUVdhAbkGIPns3hIT7HuqvEOnOjAHEFedKU5hHS/4jcm/GEVNARlmlhjweZD8FKpJzrX1P70pMgVIA1RSUE/q2p4RJ3j6Fuys9Xs7yQiKn6MZO0LgG0mYjVSTUKqClEc8UQZOjPE0x7fEWuTieC9KZglrPC3DblCrbp7UKd0ccmI+bRNHxS8d+NdFu0KNBYEOGlHaj7Sn7sGvoEwPTK6Cxdl9eydauvdoXfvUernuQeyxQ/yxsKXrBChhIa15TorLR+n6bnVuwYBp5bHLTA9XQeFiXZxQTXZQ3isKTZc0LhJIiClJiYx4KtF7ozzFQ/Vx/3m1R4YKsp+WKE9hZo7b/YSBoX4MZ7bElw01lI19+Ey+ae/WH1DGwIQSKIS5SNBagQHWg9sAo32rLtJfSx6CopSFu5PvaauMWREuYHDp076b/e6ZvmAkqvo1F73AHSPIbX8LQ8Y3gloUB3S7SrEllbQJWPbM7Bj3IO5aLJb6siz4uI5QHqg9pbfw2q1BZwgI8hTtAYIqpo2HpnELx153bjVzzR+zDTpfzoZXqkri3yckrOunhFJee08/ncJx62M2+5tPge+QwQe14R4Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bzeEayR0hdHaRo5rM7/mpg5M1HSBZVcrVMo57jG3eB9UsxkFHNhUMCtyrS034kIJAufxn6gtGecc0GLbXDx1Q2JLHDG+StNBB2nMkUdeCtHrQy1Lr77+FQtBHt+Ta//2Lsn+zccBCiUOwaN1pe0Grz6vV/iLwaDsGSD6sKmElQRkU/5nNEAW0R2kMoRZ8zfK9V7CZlg7StunpLfqYn4QkDU3bEMmr/Hh/AQQTDHtSZ7M7gd/N83LMFohlnQpyTVLsHR6PZKpBbNtKlx+m1ThTjL+uDQ+ZiowsSwyCpUU60mmDLAT1uiz/2RZUJyr3MxIqREYuRJwkb+OSDqN6Yvl8ro8bCtmPRjZ8EIO2xncqcia3ujkNE4A4x18gHTzY+pjyLI4QAIgDoyLlj1iTZ+2kMaUal9P3gpyxPJvlwEh0faTbDdUOBzkqC/ERcvEXbVd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:20:05.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c989ce69-2246-4916-bf0e-08dee8f7c8c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
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

