Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC731C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F349610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F349610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBFB6E22F;
	Fri, 24 Sep 2021 19:10:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA716E22B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdUnTywTMI85rx5SGgh3GPsflfRS7TsuaQqzH7wZbtO0o3pPVYXpGg2u8CVIeR95UCioeGHg2U3DXECY0CIZhdiaX72wXGUqSxgEInvev2Raoy2KPQxDpr0Nux4P+2nURyqhQtx0RVbh56XIab04MtVY0qQlxJPF3pS0wh0n67icwlcoXRkRQdPXhSu2YdK6MdcgnAQK7Y07fyCEVGqb6CRLH7v+ffS8Udq3n+DbkjBrc0STvKpmHVSErtnBFV2IzcJJduKlbdv2NBXb4/vi0y2rQKMaaSyeB/I+4weSgQKLWN3BvhQW7FUITNu2J7vB7SqYA4AcCa6EX0hs3FZfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9mXRlrfQHm0fdYgC1pReP42mv3Omaweo8IlMG6d25ek=;
 b=jqu5N3LYFbnQORVh/Msz9CKxGvhxCnJgud6H4Qu0K256rN3U4nJGqtIwNUplWRe0ELtCEEd73gAeYIGK7Lm7MDQOGqXJ56FWPug5DyGEm+LIdyVF1En8QpHbfkYu0NGqF1PiPebrEurt8xMTc0Yls+ye3JOVMxLgk06B9dIJDz9rmRCmX4dbmrB/XGciRQUMYHxI9XAi+VYZyjXXvLce7/+FQTKmRX4sm+2AD/aTmuuSfLOThaeOvTiP01LoDa1Ov+mwdkq8YCjOFX49Sl2McBXmNZOcVoHdea08BfgYqjJbEMlr90jL058RNnviKeEOITzLRKa7Wf8V5xexSzJp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mXRlrfQHm0fdYgC1pReP42mv3Omaweo8IlMG6d25ek=;
 b=KhwHuFXXFog31u+QwWDz6eCAeTDGQKUvWJyuxpjf58yoxkTSqwFUxcmzrUAeWBy7/2liK/urYGVjx8pZmwZE4Ai23k2g3Y4b+pWutoPVLNkdsvbE26h0RwiHABPnI6rsx8aGB/DTF0/wMKZLhNJ99+ZGG7j5SyRPZrJHR8XkQww=
Received: from BN0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:408:ea::34)
 by BN6PR1201MB0179.namprd12.prod.outlook.com (2603:10b6:405:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 19:10:47 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::e1) by BN0PR04CA0089.outlook.office365.com
 (2603:10b6:408:ea::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:45 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:43 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Zhan Liu <Zhan.Liu@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Pass PCI deviceid into DC
Date: Fri, 24 Sep 2021 15:09:34 -0400
Message-ID: <20210924190934.1193379-25-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc2e8173-5b3f-4f5a-3103-08d97f8f0387
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0179:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01790DB9C08C756DD2F771DBEBA49@BN6PR1201MB0179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQY8wX28Wn2D0xVYiM1P034fexByjJHEu9gIqHfcJNiVk/4edh6zqbCPCL+W6Qt9gZsKKKPIQdYVOP1BEwKBtcvxSacQzLtfefgQt93Kz2kDCOYv9+qeVu5qRHjwNZ2lc/XavRM0sKBRM2QARKfX1kPt8fkcak7CHjQC0HMnKM89BCly8KYu0Ar45DGymMEKxV0+Pt6HewUs1G+cQt1VwTb2p4FW6PQdEdtIVfrBZtRv4N9lY/K9fEFkP9SovFYcb0PBbIe0ZWzTLfnd+EW2G7DZpiOAj0CM+nfMoRxrGnyCowevCNLzHwu6IpoFsMHMMLmtAQFO1JxmMkTRt22S9E5WruKQyucHBteIibrdB/lscSIgK/ObWgaIBQrCO3bakJzTIx7Qez5Vl6QNfAumixziFkJss3Tp+Yoq4EWDrRFEHh1ZIyIULxVzYiWqsxc9Y0EndhFYxbSN9XOBRvGs2FCKF2rr1vHocuUF+0B3yAKsOwN0Uz7LJX7GRKTvXiL2Sz1mYba5fSk9IYCplxV4L9zBVeHDpsO5C0D9cX6ubfVsX0mliSIRrCHqziFKKRsFVluMjwTRz+E4Q4bkr/tlRm6QSpeVICh/UyjwsMRJzZ1NrEarO5CDTab7/qIk8Q1aSamRJBw5AAtD9dcYZf1pviR0WCD5r+RjMlGvGXn3xRWhWhJ7jG7rJsgCpzaz8QkiD4crYDHjY0hZ0W6lCcplbcMd7AeKNkLohTOtJlEWVWE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(8936002)(82310400003)(316002)(5660300002)(70206006)(2906002)(7696005)(508600001)(81166007)(36860700001)(70586007)(6916009)(356005)(8676002)(6666004)(336012)(54906003)(47076005)(26005)(1076003)(426003)(86362001)(36756003)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:46.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2e8173-5b3f-4f5a-3103-08d97f8f0387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0179
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
pci deviceid not passed to dal dc, without proper break,
dcn2.x falls into dcn3.x code path

[how]
pass in pci deviceid, and break once dal_version initialized.

Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 18899a391597..e676d0a56d50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1319,6 +1319,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.asic_id.pci_revision_id = adev->pdev->revision;
 	init_data.asic_id.hw_internal_rev = adev->external_rev_id;
+	init_data.asic_id.chip_id = adev->pdev->device;
 
 	init_data.asic_id.vram_width = adev->gmc.vram_width;
 	/* TODO: initialize init_data.asic_id.vram_type here!!!! */
-- 
2.25.1

