Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA440C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAFB6135F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AAFB6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104DB6E8BF;
	Tue, 19 Oct 2021 20:51:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20ECA6E8BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 20:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/1vgMqLIhzgO83wdO30lZmGGyAYoz9V9ixeJTP+wO5px45BmrSBrfY+xhB/IwCYu4PxL2NnYSfSyQ6ROMD/mSbH1+lAf1iJNvo1au97FTP+gVKMdvG5rBOK8Zs1iBt/lNp8+QmOKTSaZgj0wbYuJHmcTykP6cPGVz0y6ElsYgVk3frkn99o6rLusfo7IuSLmKRJeA6AW9vpZdCCv+zQy2XylrplESSRw+o5+KERIF/ARCZ3ZF4LpXjfReOLOeitVc0BwCfZLry7pRfiK6WwavanBC5FdGneSIk93/C4eXWvl1jp5t6c2YY77kVlTyPcO4SUM5VN1CzZmWGzpBFDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWuAG2jSGMgJIFMijnNE79ovlz+xexqjpLVxXbQmKwg=;
 b=fNHvJsuhhK6e8+BtaKIIOomR/g+bU6eRgRac1XGag70vl52+iHrGSHPjZXZb6ITX0cnA8eoe3Y0C89sL6h+fmKxU+sJdTKm7TTMzeH/KByAP4J0t1VONo0STINDOb5Et+68ik72gMVPCDZulK7hiVXouog6P/88qLh1rv5qjKXeoyieVdKqeyV0H9lQTrTcARmtYsd6v8iObZOv/2vI82a4TdrPDUYpTBGbEVNDNQOxR3DWiOG0JVP1zslDnGp9Rpn277T6QsYm4KGZHxILSxlZ0ug5lEH6qJ3a3sCX9ft65aQwAKPtPJbZg7fcKFnConAVacW9pb2GRfuc59LKIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWuAG2jSGMgJIFMijnNE79ovlz+xexqjpLVxXbQmKwg=;
 b=OipNOJkgd7ZxYzJes7M2+cLEdMdzm54loUmp49/tQy47HRsBZ9y+BMeTCi5Qy27DSXyG/APR9SQPhHoptRoPGKkqP3agQQxKkTDnCPM8VJtQhPK7ANOgoCn98joFF5H5xor/91lvO3wugNUUuLNhU3SlsNGEYts/ADHLVG4K1ow=
Received: from BN6PR1401CA0022.namprd14.prod.outlook.com
 (2603:10b6:405:4b::32) by BL1PR12MB5350.namprd12.prod.outlook.com
 (2603:10b6:208:31d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 20:51:25 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::32) by BN6PR1401CA0022.outlook.office365.com
 (2603:10b6:405:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 20:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 20:51:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 15:51:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: remove unused variable in dcn31_init_hw()
Date: Tue, 19 Oct 2021 16:51:12 -0400
Message-ID: <20211019205112.682009-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ddc2e58-a100-43f3-54b4-08d9934236fd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350DCA9A1A113385B7245C9F7BD9@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEwaTwisYqBGau1G49SPKJEB+DAv98icffqTI0qYUUPc/i7evVLjTOgKu7/+NJUYMf9Kyfdk1AvWHRb6fpyvd4vrfgLOpue8/4kZ1n/pkHD1m1HRSxH70FMPyHRenUcF3t6xoLKasXQOUAfzcEnURha3cSwu8Swolie3m7TLLiVy0/AypztNdzoy0Cf4Y93uvkkKSEnRLPcZAVW9EZx8VGLLdByg4Vi30KC1roNQZ/Alx2NLqvPznZvCm3UuENrYF4aK1FKB1A9FX95nI6thgytv5Nj0whb1XyXpT5EEBYsn6H60OtXyOVEAmSqcqm1m90TVbDWCKC5xt8eFUrU0ZLOsxUg4stmoZfl6+TmqcEH3V5s5Rua3P1FL/UGS1wBlS6ifthxgM8YCnnn4ZoM8VJWA9Y3yVWEFAbtUDWxyzW/v/MhV4rNvY6ni6UFJiNLQrF+o5N91DGUbeTxes7ufyFCm0j/9CoZmc0Klsy/e54p1kf7bZklWbcYGqR/iRRO6uSAHC3Qz64TFHfGKpWrCiFUCMBjhNF52dMY9w7cRojwwm+girlvf0it2PHh2QYUwZYOTN9CeRhfZWkX1DRaLPj6M0aS6SmZraRQAdLYzCrgMrNOAtpaMftHqnmqfwd1seM/FXNMkeHmaiRKhLGzDgjtMJN8aiqNvBXgIQA9e1Mwnk+rlyCQ5gqY2JCj8pDkOYHuEf2eCjTs4LI9149v10KktBv4mh+XfzB+rktxGl/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(508600001)(426003)(336012)(4744005)(4326008)(1076003)(356005)(186003)(16526019)(47076005)(7696005)(36756003)(2616005)(81166007)(316002)(8676002)(70206006)(6666004)(26005)(6916009)(82310400003)(5660300002)(86362001)(83380400001)(8936002)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 20:51:24.8892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc2e58-a100-43f3-54b4-08d9934236fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
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

Unused.  Remove it.

Fixes: d1065882691179 ("Revert "drm/amd/display: Add helper for blanking all dp displays"")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 7308c4c744ba..9a6ad1cebc85 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -73,7 +73,6 @@ void dcn31_init_hw(struct dc *dc)
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	int i, j;
-	int edp_num;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
-- 
2.31.1

