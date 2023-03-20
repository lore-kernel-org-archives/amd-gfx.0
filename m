Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F588C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 09:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C0310E1ED;
	Mon, 20 Mar 2023 09:37:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129D210E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 09:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdJ0HiDfDTLIESB4Hifdg15biLcwThtryniFdnDz0LvO4L+AS1/PHVB9wlUaIrOxE82bKVB1S+tCxUZZQaDD71Omqe3yJZ6d3nP+1jtEK7oVbAauDHqLa5LfJRohrjVUHGbkbFsPKRKr+xMagj5ZPrRJKQR6TW+eWWMpuPSKSbRl8fUn9RMb50+MP9htX1raHnpIBwrboziFIZv7lGG/HuX7JAELy8dg0F3t2+oBMPEB+WK71rwcDOn7B3nkcz1iRau4Vu/9rtleKLxu3KOiiDAGSBwM/tRksxvMEN0d+7qLgJ1oG2/wq2L6jFCuE1SgWYEQ1qD+aqU4Z0vw6FdtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwCtZ/p7N0o53ya3cGQXWa/eqGQFSC7u4bMhl6ABC3g=;
 b=GiKEN4ns7DzgQiQIWjzaTSbtyQnvWGvrlRKwttUUAAdkpZrXXmYmMDyGg78YEp+a8jNHRDKB0qeMujIFhtg4Gq0uV3DGOCo0WNaA8J++02TA/5O4vbEiqZP7b4xlPdXXJMhoN9B3vwWOzR3pmXtfriSmsVJy3AI+gifQB8i/+Yx5/wpq68Bp3w4+2RqtsJLs/J4BTdeDKIeRjrzX78yqTthfZ2Nn68kQB6Ol3sKlCDetMDMw+ThQ3/RlwywhWEQXg6DOctfXAP19i/cN4+huWCvetZwoeWilxjmi+NRhRE0kN6MZYiCmyYZj6Pp03SaXLJXkwdHuKc4/mtTm+zSBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwCtZ/p7N0o53ya3cGQXWa/eqGQFSC7u4bMhl6ABC3g=;
 b=tHlQ7VnBF7qS6KqPsjjw/ElcU+VRb+bPGCnRNmubW0ZDt0rRcjHlWaoRmJbE3RzFF9TgI1K2/SAA1C19ru8Na9vVS2DexJ2xotKXq7iAk1i+dgTK/H9e4FbJ32zkCZDLwT0rhokBN5UU8dyQjOEbxIVt2Kf5ZOIbiueiit7DbCE=
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 09:37:06 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::72) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 09:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 09:37:06 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 20 Mar 2023 04:37:03 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize umc ras callback
Date: Mon, 20 Mar 2023 17:36:48 +0800
Message-ID: <20230320093648.30914-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 73422135-6536-427a-667f-08db2926ab4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynt0I+/O8BYqvyU7Xn0EjFn3tuLAqmUnlfgAvukObpoBem7iVeNKOhZ3D5R7vTQ0Vm0JPO3sbMyZdwvtvip5B3/+OwywYWo/CR1e6Jm8asb6Mtw91n8kTKBX4ExFHE1FopoGDOOxYm/9QuWpkC/hYqWAEW34fdmdCghUMS7LmZ3ixIYkmTG8pS6R+u3O3r5bhz1cF3Q/kF967WAYZ8V6jffeDw9bT7mMCPeg1OkbR1QQrEFJ/dT6+WHpaTjVu9Cssy14TZnlsviqe2xFjSmxhLxswYUlegrBy5PNftKpX9CmRRDE4K5fXTJY9f2/mWOZ0xcObIuK8owiVb0hE/aHFcM+NbXD/xQdKbyb2+pZ/dM5esnEHgKDyPsJS25YYBgI+jE3vIlU+oDCNEdrFqZJfldI/BtkteNcKdg7vNwxQXnCiLZw25P85NjMvBLuTA1SkAmDDWFIqw6xm1Xq7enU8ZStJqk/v5xAERSzbTVQSq+UapuHWHdKHn8ZWw2JlRshZqzIU6jkOpBEEqRgyvX22mOXTxJN5nngvkgsY13UnYSSrLucJ94onI5VHUOR+A5RynZcEegQTVjXrUFZEofcOirl1K79zCwfLeeYYU2aSFs98knfGyUBV+AeEcIq4lYXaG3lJSWMCSb9KfE4JXeZ8fsljcGKbeCHRsxsSFWb2LtrjJtlLkCzSw3ECbLgpI26phUV//ztD5EHCNbm1gttd0WvYYujyzVWClgHRvRDpYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(426003)(47076005)(7696005)(4744005)(316002)(110136005)(6636002)(8676002)(70586007)(36756003)(70206006)(4326008)(8936002)(5660300002)(41300700001)(36860700001)(2906002)(40460700003)(478600001)(81166007)(83380400001)(82310400005)(82740400003)(336012)(6666004)(356005)(86362001)(2616005)(16526019)(186003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 09:37:06.0811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73422135-6536-427a-667f-08db2926ab4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a coding error which results to null interrupt
handler for umc ras.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index da68ceaa024c..9e2e97207e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -232,7 +232,7 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
 	if (!ras->ras_block.ras_late_init)
 		ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
 
-	if (ras->ras_block.ras_cb)
+	if (!ras->ras_block.ras_cb)
 		ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
 
 	return 0;
-- 
2.17.1

