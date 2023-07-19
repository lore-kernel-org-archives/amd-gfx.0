Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0635EC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3A510E497;
	Wed, 19 Jul 2023 12:40:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBF510E494
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 12:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy94dubuVqqsjsQAXc02nGo74GCw1t6J9Q+hWGFYolfIGrXlugcMJUrHrZ8fxFS9/l1GhDaBeoK2aVbzyipCGYBGypQbfczjDlq0kETULT3QBH/jXTWq1ogQTUQ/8H3fKcqxpYIDPrWiLs9X3kPWJisTs/vv9lI8aLdO/RcS7iOFyYLzGYKunTGNrCCIm6haPr4Kg5U43CS7ArnRG4Mq4QDIuYKlfrMpRwpjVcPKs0XJDtQLoIlz9qYw//dl6JnOXccUZB+19LImW/6l2MqNRj5yts/Ke2nfCnUS6VaVYq0r+FCp3Ho1z25R8sCGxkAL/VlqKKdbqWYijifdzrQT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYSYMC/G3aVRV8+2PjPDhzyGmanAovNpKyNinSGGWHI=;
 b=dWo2HJATEsMLm8E1FLs1nlGowH6dgvduUoEuDffUUQaG5U9GV5ZyFQ1gR3mToa4Y/8rOFWn2ndtPojHP5ILhyh/X//IRyScYjOuX0nytnCaz1HYvSy7QRsMmrtl+kc9vpjp8oq8NJIlUCoyJhJBI1s24wWVIDs2WiA95Xv6QYOMpQ4i57CYFN8nuAomWnnNfrr7NqT45w3c0MhirIVQuxCMzqMRdQD5JAwJb2QNu8NI3uRFjdWQv+QI3E1RkwYlSiohxPgsZ8K7zIsPlcLjpplPznQGG0042UfnX6T250Gc1SRX0na75KVaNFLA441ixBi3rwoqWrGSOSXIgZXeomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYSYMC/G3aVRV8+2PjPDhzyGmanAovNpKyNinSGGWHI=;
 b=lSjqXx9xljBXown62BiKPlkYdRYu1ctu1D0mSH1NAX3xC1/QWYCIOcfAEAVLEW9TkrUnlWGL7ntOsRYUTShJvjicc1uG32q1aNiYI8BhR56YXiJhrI3TtDgpRi1gCtfnvtwi4/DB5d8ZE5x11OgFydXZmnXAgkABFZw66FoETwM=
Received: from BN9PR03CA0708.namprd03.prod.outlook.com (2603:10b6:408:ef::23)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 12:40:47 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::4e) by BN9PR03CA0708.outlook.office365.com
 (2603:10b6:408:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 12:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 12:40:47 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 07:40:45 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add ta initialization failure check condition
Date: Wed, 19 Jul 2023 20:39:55 +0800
Message-ID: <20230719123956.1163008-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af1b48e-b8c6-4d46-d7d0-08db8855605e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrXMu3TzYTViMsjZQCAPY1PG/H5/lJuvCAVP5H3dYW4wplw35l+L4E5xeAmd99mYZ3BRveFGD56gREIfTDZEDl0JQN8u4Yt6yGEuXhpGZxnB7fb3DVbrNbzxC+MIpy3E7UBPMEmzkBQONwq+Uv2KxYSaOw0C8l/jjI1dX+3D5Vf9p5ZJSNQNwvX9FWJmY+2s5LSf6wAEy4SQyjG+HjlNcELw3fVW3KMkm0d33cYYZ3AngW4ixr8BrX6ONdt7e+nzlpLiCkDrTLff7DtBLgUf5HiOqsCmlcEtkph+hP0eyUpRzwjvbdRVeHPQ975FVYmUVqZD7kGc1WpndAnDdJPtC+IbmQ0n/J975p3R/2c/UsD5rs2g0dmXlQyqFw84lLh/1Ca033EioGZZjHLHIbmjKySLIjRb69EHmevSMy9TZNaxBe1TkOElKegDbFsCBzPQuLmaa7etUY/Mgf7xGxiCjhWEzpznb3K7nv2E6JbJ1hb3F0yucN/XPzOBVGx23Csu3/SfUFrDPM0qXQ3R+oTW2DpH8oOrCsVrt9RYaZX+iMfN/417fiGiRnKNYFbrQfksrll+jDZtNWJ+GdgKhEMqFQT+Lh90pIVsfUTwy+GOMOmyXc/I2MiH06xzCtaK5PbpwDCvE0Gqwy0G+V8RlUqLQ3jwqzop+v8w84VLyuUQG1S+c1dj9J826F73rAMiTu7Zs09udvYjWrp6JUy/xFLweRiaCp8tohdjqQgwhJrXjrOFVazJh1Nct7782vGMWsIjjwKBXq5LfeymI6AsUBmSxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(54906003)(336012)(186003)(16526019)(26005)(1076003)(2906002)(4744005)(82740400003)(316002)(41300700001)(4326008)(6916009)(70206006)(5660300002)(70586007)(8936002)(8676002)(356005)(81166007)(86362001)(40460700003)(36756003)(36860700001)(426003)(2616005)(83380400001)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 12:40:47.3014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af1b48e-b8c6-4d46-d7d0-08db8855605e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ta initialization failure check condition.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 468a67b302d4..049d34fd5ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -220,7 +220,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	}
 
 	ret = psp_fn_ta_initialize(psp);
-	if (ret || context->resp_status) {
+	if (ret || context->resp_status || !context->initialized) {
 		dev_err(adev->dev, "Failed to load TA via debugfs (%d) and status (0x%X)\n",
 			ret, context->resp_status);
 		if (!ret)
-- 
2.34.1

