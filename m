Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12F3C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AB110F19E;
	Tue, 15 Sep 2026 07:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O7nnpThr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2A810F19E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrsEjUhtx3cIbb0hJyBEwxnbYIbmZv5cs4orvcOuiLiE+N0OwYNcJfTx65DwG8GYWohfEDDx1X/SfVc3jQ/82W1I8wnYdS5E3pkkGmf5PQ5f6rNtO/ZudtfaeR1m639LOTiFlbVUzlKa2T93XoFBXIvgG5d3R6VTFcHkXMyDzM2sRaeCR/jupsYc/Z781tN3Imq3SVTq/VZSwocUQp5MIJRABu8HS2Md2x+wgDpNiguMgpeEpiZAi1utD+6mB2RGeBFw1KZdhN3IZPdGaTFs/xu6/jUuV5qzu4bukhRvXWQUA/zU6PEsN2KZGt0T4BdiQH35mBuJYDTF/yV+n7GQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkjbKg+BCzUlQUj+JgfCqv214r/ZnlFnyh8DoBW92T0=;
 b=v8kaH3yBr8lnIqgd+C+9vFGKRHFenuhQA2DLSzB3t76yeFG5CCJSWVTCuuVCwjtyEagjqZ7x6I8On927rEkav4QtWrJZ/CDhDa4m2w1P8xc+/TNKmGcf+Rdz4cyglQIm6gmKEj88H2Ibknmj539yyF2m5VY+UW1yvn1RzCIkvEPVfuYP9LJ9/n8r2Auoi4ytu6BkRmLgkQAsEIn/SWHrma33qLUz7cFCaOkPNU9tEkexB4qE7kbSWtZVTS8UjGEH8ZYJJKtgg6roSNu2ldnpd2ZbN3I/pb3C8p5bf3Hz+fTE13wIu3Ru1Xgm/ug0w91vQZ/IIP9BEKuSJCRbtsYagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkjbKg+BCzUlQUj+JgfCqv214r/ZnlFnyh8DoBW92T0=;
 b=O7nnpThrv8rcXHTkF7oEAygWtqv4VxSNbonghzr/Bjuq8ecPvP40u1X4EJhUtm9/OzYyscSsJ5U4GewcdjzNAZpM5ir+MAUUs0AAlMwXU4CV/TUIdgPzFiVU5BCJaxBA7G1MW2WsOTr4qKndYf49lbO4l0xNs6uub5WnmsXyT78=
Received: from DM6PR05CA0041.namprd05.prod.outlook.com (2603:10b6:5:335::10)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:25:20 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::7d) by DM6PR05CA0041.outlook.office365.com
 (2603:10b6:5:335::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 07:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:25:20 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:25:10 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: add error log for unhandled gpu mce data
Date: Tue, 15 Sep 2026 15:24:30 +0800
Message-ID: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: f23a10ef-641b-4cc7-8fad-08df12fa7fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Iuym/+aniVI3b+TyL7p71f3lDFwZS48Iukt+GwpO5XPB/vwouNy85Ve3Vg9bS3IKDLM97gjichKxXmDQps8a/D+yEAE+KyLihXkKmXnQ4NQIYJZmC5G6Nm6u7LjfLlZewTyLDHEXI9DM6cJJ6ZJ0G4hv0wCVCK4YEc7K5bCWrZTn6rNGgX5yk/tqaUiS4D6q74uQKXH5QbD5OpQ5pnpa5ZxV3HyZ7vvcMSu4R7KPaSj0RrzDXc/5vTjHKt49DJTJ92npqXYXCILQ58Z0L85jK2ilr1TbHYNGUULCD/hU29N9gTyP4cR+MSx4jXyf/a066H1MjwPEo7D9/aE0JtqQEXyusm65oMon2koIW8hPhQ5oXIwfcHWA+At3akQryWLFjv4oJMQWaxPZv1Krzzup9sqObZJr4MuzaNeEMOGIBs7sHzMzeIKFZiE5y+R5SsXhGZrzCu2YpAq4Nu/e/nVct3FT85tCYUSDab89f06AbtnNjTyUdAPFbCo+KtVVsMUB/Qf8PjApDCc3STz+j9qdg+hPKdTkgsQsi7jKQd4vGlItLe71C5puqc8bCR0y23s1kIiaai2OHOi+VVOLzqPJOrCd7erwbTtactBZdWgDhYiBTFET0lXsOKq3TedDGpX6CUJ2EvbY7pghNbg3LSIz/zd2N10Kqogi88ILwsaNEDZYXLymlPX3Lnh1FnswOv4MnPKGYEvpyAAw3Vnn6/g1Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C+LKt6qKAFg0W7mU3g8FqTDEYqFKLPnfF75w7SIfzR+W86XHnrxo1sQKYaWGvGF1eOHX6KzT7/e5aBf60cl1cvaXNlY76IrNOtD5Mw+H79tzuPRNihh3SbAC4NBvy+GsYS52TjKKOxV2cktVN+AF/ohUFzouk77JeFtf5d/byCgt/whLIu2EzAB7gFp6U2Gp3+2ZEeHJtXdc+Fd9e0gx1k185UZAZZKeLzTtzewliiHMLp2JJPo3RBn8MCCvrh8uziMkeRZ+u5iRJWWDNVptq67qbiBhX3GGAW/dBiGw0aDE1dEZtIIhmP3nlNPAzl+jjAgyGUZkxeW9gNBNKyIlOt7GVLXcnsptq5pNz709XY/cLRtM0EZauksSTwJPUFxdoyoaFX0prn9ghlAis6rpua8u5AD8dZi0Fvo5/gIGH9Ap0v7JEA9FwS2o7y2DpaWl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:25:20.3920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23a10ef-641b-4cc7-8fad-08df12fa7fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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

Add error log for unhandled gpu mce data.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index 0edb3dc06a69..6bb8bc1b52a9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -163,8 +163,13 @@ static int amdgpu_ras_mce_notifier_v1(struct amdgpu_device *adev, unsigned int i
 
 	__fill_mce_to_aca_bank(adev, MCE_BANK_TYPE_GPU, m, &aca_bank);
 
-	if (ras_aca_parse_bank(ras_mgr->ras_core, &aca_bank, &err))
+	if (ras_aca_parse_bank(ras_mgr->ras_core, &aca_bank, &err)) {
+		RAS_DEV_ERR(adev,
+			"Unrecognized gpu mce: bank:%u IPID:0x%llx"
+			" STATUS:0x%llx ADDR:0x%llx SYND:0x%llx\n",
+			m->bank, m->ipid, m->status, m->addr, m->synd);
 		return -EINVAL;
+	}
 
 	/* GPU device only record bank data that matches its own socket id.*/
 	if (adev->smuio.funcs->get_socket_id(adev) != err.bank_info.socket_id)
@@ -201,9 +206,13 @@ static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev, unsigned int i
 	__fill_mce_to_aca_bank(adev, bank_type, m, &aca_bank);
 
 	if (bank_type == MCE_BANK_TYPE_GPU) {
-
-		if (ras_aca_parse_bank(ras_mgr->ras_core, &aca_bank, &err))
+		if (ras_aca_parse_bank(ras_mgr->ras_core, &aca_bank, &err)) {
+			RAS_DEV_ERR(adev,
+				"Unrecognized gpu mce: bank:%u IPID:0x%llx"
+				" STATUS:0x%llx ADDR:0x%llx SYND:0x%llx\n",
+				m->bank, m->ipid, m->status, m->addr, m->synd);
 			return -EINVAL;
+		}
 
 		/* GPU device only record bank data that matches its own socket id.*/
 		if (adev->smuio.funcs->get_socket_id(adev) != err.bank_info.socket_id)
-- 
2.43.0

