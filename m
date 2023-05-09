Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EA9C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D786210E3DC;
	Tue,  9 May 2023 22:06:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8010310E3E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCqM0BWkrIjDI2A/CBIXTw0cHQSSsmXkWqD7rbWCDsUEkrIvqTeGxChWL9vxtDUJ/+QYoHeeW1IfvXl+padfV8cslDa0gSN/HFXL9RaaEy+dYEtOC4CZ3OtTKvmtPB3QGmm0EHwqCHm+eeLOIm7SDEuPc+aO1BiAeiWLtYLQV4aAvWB9Cl2cWEtbswFTbnPeHpj7PTtyK8n+zsuBS6kyF0NG9qajwnMaB1BOGR05d4+0onmXb9rjH7fSBZobp4TFyKHscviknNa96i5SLy9Xg2WlVzNy2YvQ91uGlZBhK0l0FOdWpyTD0G+mPFEgHOfAMw9D4cw4Al1Q2GElfVC0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L2ZpsNesyEvW35L208qiWEavuEMD8vhOMNXREQ/ms0=;
 b=PEi6okWAdaNTkRKZwYOluOZqAu/AMs23o0Yf/7SIlHJ3Fvw9Z2Bho/B/TfEA6QwD/IZhw7NQcSw8eQpnrhLZKgYGTc3MWW9+wGut4xdyVNYhl3cdrnuFC4BDZCEVi/kXLXaKIDhm2L317qrShA5s42VTCJ5r24+FrCtYFTqZDCBYdbFbzZb+rc6Vg+zIMX3ozf7VDo9OeKm6AHYuNpWEtnmJtgjTfTD3vlCJ1mWX92dgBsfvJXySNFI1FvbRGIFpNWJtfHTousx9t6bQbSvOZrXKxGAqToysHalk/EOjJDGxc5p0uuBt0burDojX/y38++MaKgPveG9NAV8R0kW2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L2ZpsNesyEvW35L208qiWEavuEMD8vhOMNXREQ/ms0=;
 b=3znrn5o7O8AvHJp5wwg2Rko1WW81T2V5rJrNIRyROl5S6yxyYQ9MH94foTdznLfVWerofAKrWPeyX4ucy4c9Pw2AAwkzy8TKkqOyLewTIwPvxYn2gZ+car6sDdxXsxAZ5f3gIfAzRLhBHvQkqKTxwTnReIE8MENPAAWgHtjApyA=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:06:01 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::9) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:06:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:05:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change the print level to warn for ip block
 disabled
Date: Tue, 9 May 2023 18:05:43 -0400
Message-ID: <20230509220545.474998-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220545.474998-1-alexander.deucher@amd.com>
References: <20230509220545.474998-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e55338-b407-435f-6a4e-08db50d9933f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va09S5RgjYgD5fSdmft7iYhOKybS75sH866ZH3inRnFGNFarWWUdplciqZhWAHjwPQriUN5fquxH5hv66R37GzOXEEenbWFHhs3ek8nDvk+47HEdsUm7yKHQlruNVtc9QjF75gfdxK4Q6/rpNHV9u7KZ5gqc1xVkwfctY8jr3+U9Q+4LJbMi/61MBB1FBsnCdZxr/ZbeHs1RM+FQ06nzQL9VNMpMkWXiv5ZzdYSobPR2vARdFH7QARZ1CojNtYDe4DQgip0qTOJ4Sm0r9tyh0+9R/va6fJCEtB0j49acHvPpLHidjBtz96olzicIrYL1U/n+r3EhyiSDuXiBT8cmmU/wNsPQbY9j1JUg8WQmd5tHP1piPpX7ihWuE7UB5nrPS2+aamyq+CQeBzF2O+XjlsTRdHV0oCkvmpvg5sa9rBOiuikMo3u6wywGrNKSKu1lOOZD1JbAUaNbljGKurtvJjVlm1vgZXIEeUztTWoQwyuZ10i/ZHDOed6ZXu7hC6FB1c64uo6MTL3tHBpZ5lwJE53331rlS1bif9y6mgejYnh/5VZHy3iDaK0JDT7CXQVCD4H1pZa1v6PZS9Ok/jy3G7P9sWi2LHm8h/lGuKwAw2hfDg9tAQidU1b46Dc/WeERaaDniN9g8JW9+EUyx+mB2EoBOlTj+2A9nWd04bYf4jW8g/0sFsvQiMO7AiwoC4hL7bmYd/hDzidWrpBZCP/LYFv1CH395tDAAp1r/cRO9kE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(16526019)(356005)(86362001)(8676002)(478600001)(54906003)(41300700001)(70586007)(6916009)(70206006)(82310400005)(6666004)(40480700001)(7696005)(316002)(5660300002)(4326008)(8936002)(83380400001)(2616005)(26005)(36860700001)(1076003)(336012)(82740400003)(186003)(2906002)(426003)(36756003)(40460700003)(4744005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:06:00.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e55338-b407-435f-6a4e-08db50d9933f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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
Cc: Amber Lin <Amber.Lin@amd.com>, Le Ma <le.ma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Avoid to mislead users as it's not a real error.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f95591b90f0b..d1dca02860b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2291,7 +2291,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
-			DRM_ERROR("disabled ip block: %d <%s>\n",
+			DRM_WARN("disabled ip block: %d <%s>\n",
 				  i, adev->ip_blocks[i].version->funcs->name);
 			adev->ip_blocks[i].status.valid = false;
 		} else {
-- 
2.40.1

