Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A53CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA33F10E90C;
	Tue, 16 Jun 2026 08:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GVhOnF0I";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A666010E889
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyg5dY6s3F9mcjLQCatGiSc22aezPdiUchDBKdKtBaCbPblHtyZH3wnsyYoFmuxyiZ1C19NmcEOAQMlwqLO4YTqVylSIDk04vu44T+PgsfvobFNND70kVK/ewcpK4mRDuWBUmLZq+V8j+E9JrMJQkr4JEOFVz+myTgjR6RUX0uRj0Mya1Jra+TWBiMJ6gwuRWOPa7mkOPkqGCVKqXNHK07niunTgmnjrjgO4tAGmmq8y2N55fmqkQFqI7q6DKZ+Qelr/DQfm1PtRJoVeJqUXvQGzp9qjoAdCgn4j9J4kftAq6NA2s+E6xSk1Xm579a1LC+6g8gof+y80eFznYz2e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5aQls3sbla6EQdkXrBZeGbkUx97DJLyUTvGLkbZIKY=;
 b=o6m2VBTQdnctkVIGmmzxIcgFN9vIQrN7Sh+gM+bWsGI5KOfwuLfrTfU7gMj1x9mNsj/DpQ/119mDDCTPzlKFYkjIuy4vn26w8iqq9/wwmwEBZ11YGBUiyukV/vXd8xfaYw0xCTwtjLH2SS5uFP7ax1RxFOcVyZ7ioYFayT6U8/fgRI14BFfKtTLIqmi4Jc9TFtuLnn6VxZWQU0QfafUR25B5VBgf7KIZQtxBPEzWjmQNihPahUn0WzPXs168n4EdGhfCwCWRnbDrB40BVjLDHTonQN15yfIJkwIeT6D1u5JjuQHUjYV4Z9JPKh70VMbCSisUGPnnnUDwFpET2IWTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5aQls3sbla6EQdkXrBZeGbkUx97DJLyUTvGLkbZIKY=;
 b=GVhOnF0IszfhfATQME/oclmNjKvnsdQK4ZkA0Cbp76hofAb180+uR9e4L3S1kfG9wK8ScpFLX19IovcHkeN7QKf7XJtb8PaUEPliBPVzlucry97pTtJdoHLl5CXF/jNoX5Z2r/kqORtstunS3tYqhJMnLmIIgX1fZdFwqtoERKM=
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:44:13 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::30) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 08:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 08:44:13 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 03:44:11 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 "YiPeng Chai" <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: use IS_ERR() to check thread creation result
Date: Tue, 16 Jun 2026 16:43:40 +0800
Message-ID: <20260616084340.4128985-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616084340.4128985-1-YiPeng.Chai@amd.com>
References: <20260616084340.4128985-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba487c8-248a-435e-66a3-08decb83713a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rAQ9wUx57UKncecDkzEYd8cticF6wB4eHqbF0FPvyzxLHThn8CMd1Xr3rx3dpkhjPr40NwFqo9wGLRHbDJHd9KYqeAfvUI+eTCsyGUxlHV7gcyiPR4v4w+G9cMwa6PRcnYomh7m7D5lIgrAVj17ARFUprU+R8SmJF1H/4uoAji1ppNuzyv7dUXkmFlVOxSfsik/lU+74O5LYL9UmUZC2bR3+9a7V6qFeX9Xd8+ZQMdJFXzlLiTdH/iiufmtiadkkG8Fiwmbjwu6X3G6Nwcq0H4u9LAzCgGFfFCO7Xe0uofIJ9DWQUvDqoNITOYbEM5EmwRzWC8q69C6IbuMEpM6TU6pxz30bP/TW6tjgec/4WibiVck5AM9HYzH4iCVGDVqrqqOaixbdbSCCXlPeWE41A5bjkABztVx+gfSz7mdnP08t87PhNlRVnIVZqR05uQ+zyrLMI4pWsTJWT3xuyTiw7fbhPnEywypwBjGIhiYQ2izKTln1hLUH4NhYjLmK5o3PXHVAKfwmXdrLysl5dmwgAmMPOPOXrvYupf0cMwcGjLCOtvYDQI/V2MJRN0hqVZA69/Tw0bzcDznj9FWVwpFWiyEjG/t0xRA74pVidC34utbO+3CvlxVY/wWeYMWTmA+slUk86kvpPkcKmjuCAyQfYTyUWzFTbEkXNrHTDg60BSr+adyACOi5hpqpcmbRtozXJ2hvHltqYA2QOxK9iP/tn5MZGldoI1iCsg/akRWc0mo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7RoK9Rb1zfK1+Gr25kXPGud2J0DTcPjYURy2i+kBf0aGC/g85G1xOugLBzvGDmMzmHrMpdpJ8Ti8Mm6aWxALeq/dgalS2hs6bQMnaquzHvMt024MQyJoxWcNUiWINVjb2IzDQFkdXI5EmMzS0qaM95bfoG1suEyLtZ5DeiN830SIMaZADsaFF2veUlptlLNcmZzaJvlaTLttJzzd4M4yV/L+GnsOgVei5qdUGjPbUcKu6WsZcwW2QKP0ptfnqDONHaf+ZWsY08TUZoHY4GgcH/NOIx8qfvVxig9l0BhQZCZJakg6/kGiYgf2/9Hzai+MHn7EicVn1vIby3fFrLB27KwgLGDILivBqjMSJyQ1SQvmUCgEzAMO6dCkDrzlfz+suqImA59+9rWgaomEd4n3HPB602/7FpWdGICtp2K/eNxZI+rLalBp6f4hfBRowRsM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:44:13.3615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba487c8-248a-435e-66a3-08decb83713a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
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

Use IS_ERR() to check thread creation result.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 3267dcdb169c..c001074c8c56 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -248,9 +248,10 @@ int ras_process_init(struct ras_core_context *ras_core)
 
 	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
 							(void *)ras_core, "ras_process_thread");
-	if (!ras_proc->ras_process_thread) {
+	if (IS_ERR(ras_proc->ras_process_thread)) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
-		ret =  -ENOMEM;
+		ret = PTR_ERR(ras_proc->ras_process_thread);
+		ras_proc->ras_process_thread = NULL;
 		goto err;
 	}
 
-- 
2.43.0

