Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E914CD54BF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC3C10E325;
	Mon, 25 Sep 2023 19:53:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9400D10E323
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjDzhGH5G1Aob9KcRjQMtne6DxqYKsdgeJpKWhlmcP0Vw0mrLvGpDwIKAw4G2w/0KMZJ7EzweflSEaTdkc2kLipHBR8HZsDnWle1hm+54y/fJo/gQakGo25XkrW3+PIBJyOuPOx/TCMG4N2XRb1nxO7J0HFH1dKTV6ZwbzfUZKsEYUqRzShakqZ0laAWljQRe6y5fmPuCncbL/2qd1uJOWjrLQUud9W+n0wzUWjaG4caW/MlVo1zJ9xeeAjHxK4dIoqkAJRW9BbKpzDrN3Fy7DJ9B5WFUTAoBOUTQshSPMWkihG/SPAMypH/gTjqXsabD+s4Sz/pev8m07tsiq+WSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck7sSoDxuyYR/OgZGEq07VVexCY23/x8X2KI5nTzOyg=;
 b=idGbu9pPcHeircpu/ZW87Shinua1sYBAPSTE8bYPBhcVQiMGeKLlxiW2sAyyA7kMfND/m36Drxdl/n0+ziMRjtwYFquYBPiGKgDDLZs51057fpGEXKQHxVFg0HZc/w2NT+bwuuOrnGFjS4iZB1aPhX19rQzI4lVannqqEyGa9eOwpVK0ZuqYmZijPpq3dcpuE87BszopLsUVc7LLjPM1Se8IQSVColiCA+0ySLDVLRlTGnFVfLOwHNhRHnHDe10B+Pp28Y1eeazNEC3nKw8YnnFm4/W2PfhnZQMuk1XR3kTY3EoR29wBr2Bhi7L0Ik/EL8GfW/BF+ieklYNv/RRVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck7sSoDxuyYR/OgZGEq07VVexCY23/x8X2KI5nTzOyg=;
 b=O5sRwDakmmTTLwLtNd/wKbgddNB6NkyNp1LPen+grTw82aen4T/cAZkRRgFFyaUo+JqkpUuLR+c0czpcRHT/mHdR0eS79wAQUrnb1DqY8HT+QxoM1oZNgDy2NpNAm6Jji++MnbkO1snOVSk4nOi1ikVonCqNlMu6b5n4qi7iyQk=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 19:52:51 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c0) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Mon, 25 Sep 2023 19:52:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd: Move microcode init from sw_init to early_init
 for CIK SDMA
Date: Mon, 25 Sep 2023 14:52:07 -0500
Message-ID: <20230925195207.124850-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: c21498b1-b1d3-4f08-1941-08dbbe010007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eajkTfBnqXqLpLKahFGQxtI5IGt7VrzxucP87CmesZ/QMLE4yzkCq9xiV2zgpgHpDluJp+VXOc9XoE5Kf/0UX5dXAf0uYBFGVTH5AuCtBsTcbdjNemu7l88sAx2p4JRX897QYo+YnbduGqXlGTTYG6Ic/EXJOMhgnH+tKFTwhC9yrmTKutEGk8c0qiCnBLMTqlpo5SlARdcPI+xUGZqR124BZ+lVcGqYId8HpMh0IUe5zzmSK/M+gcXKg/LBSIELxjM2s2jv1POBXqnL9iDHz2feSUkdtc+r4taqnYlTnXZYt5/IMKKArGdLpCagKb1ponZv+nqpbsnoXuMe+mMVhm+PBBwEPNml6HvMyIBZc4xFg3HjRlPpcgpH4F6Eph2xAUKW44xhUcFU/c9FSNGFIKYRs54y6/j1nbPrKnH4uxHdlAKPWVMwP6PCX7kxeLWFrpA3igRqQI4gRmCblSuMeOlHhg7DXf7uZwtrvbDUp1+jKEpBAW3NDZeQcJFPvpbghsOFBLpb24e7/ukVSEXk3IWyZPE04t0skC2yN8+g2n4nZbX/xP6sZ1JHul1jsbNlGR7OCWvgzbHdSJeyXKmkGjiOrc7FSsBLlLUQPKNXBDmL2Fj8piM1tSKM9wbqRyp05Q6TgOSFUs+5+D77LnFEKd6HhawjLSZprPLrvWlEdk6U6Sp4KcGf1KHLI33/85QVn+QqSAhtbyrIn1YSWkdHk91ntXIjZRFDLnVXUcQunPDVYm2V7tMsR319d679D8IRHjv2YKgff4teLWYZ86GgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(47076005)(16526019)(26005)(2616005)(2906002)(5660300002)(44832011)(1076003)(86362001)(336012)(316002)(8936002)(4326008)(478600001)(81166007)(41300700001)(6916009)(8676002)(70586007)(70206006)(36756003)(426003)(356005)(6666004)(82740400003)(83380400001)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:50.6204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c21498b1-b1d3-4f08-1941-08dbbe010007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of IP discovery early_init is run for all HW IP blocks.
During this phase all firmware is supposed to be identified that may
be missing so that the driver can avoid releasing resources used by
the EFI framebuffer or simpledrm until the last possible moment.

Move microcode loading from sw_init to early_init.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 4193289ae82f..ee5dce6f6043 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -925,9 +925,14 @@ static void cik_enable_sdma_mgls(struct amdgpu_device *adev,
 static int cik_sdma_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
 
 	adev->sdma.num_instances = SDMA_MAX_INSTANCE;
 
+	r = cik_sdma_init_microcode(adev);
+	if (r)
+		return r;
+
 	cik_sdma_set_ring_funcs(adev);
 	cik_sdma_set_irq_funcs(adev);
 	cik_sdma_set_buffer_funcs(adev);
@@ -942,10 +947,6 @@ static int cik_sdma_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r, i;
 
-	r = cik_sdma_init_microcode(adev);
-	if (r)
-		return r;
-
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 224,
 			      &adev->sdma.trap_irq);
-- 
2.34.1

