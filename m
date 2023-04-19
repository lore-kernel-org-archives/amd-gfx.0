Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A84C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 09:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5A110E90B;
	Wed, 19 Apr 2023 09:40:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEAE10E90B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 09:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMzwVmKUvjnl+h19a05jNibOyUvpdphFc5fD9DoJtX1hkMJVToDn62jnMLxpbBtxW2qkDKtjuQbeXgyvJCMCKSy7KTpXeWpFt8nv8Bmkjp1fBR4pTRF6qUZnlSLunld37u68xzJGkUe0zP/p63D11H58PwPKPxjuNtCPJRmRq1yFPI5LCiB1yAKky+1+ljlaaMoIC7f9pO8jqaYdlsSSXfWD6HEcqNBrSiqaqdSQ5/xBwpUd9rvbnKGHitPNFOV8/mlR0cns0B60yDKN9Am/l0ItsBh6vian8GdPyoaZNkFTTMzRhU04T1T0SY6a5z2qFG8Zl7YVqqpdkhr08B+2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+b7pfW9jxoV4TuyLrq89ktvyMEQxccuzB9DXSuk6jU=;
 b=bA4+xid9fzFDSV1CIx3bBGd8b7NIy/3UK7NgyZY0Y4CyfaPEMLI784+zGGkM95HhVqU+7pk7uTNChCWFLy7xEtuhWQdIWE3fTdrvJwF6hDyhnbaRjQZl8OIXSgfzkcDZTa0YegfokY4Ud43/c0zec6aZvn+ISE2kjKYaJLdr3EJBLUw8XFbEYKEs4XVXXaMPslKLOcHIx2pwXQDjGJkhsisE9ObUf2Ljkh+kAJIywIgTmHRPJnKPetc4l2vGwrIqJrfkd6XLYJ8/LKCFqEUZmMbXuuxFH9fimLwAbNp5fRfgA87vzlp2mZzieGxYi4E2gdasrtEzrV9I1VF1bhrdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+b7pfW9jxoV4TuyLrq89ktvyMEQxccuzB9DXSuk6jU=;
 b=kAZ5HDN91F+Zv9jCvVl82ctNM2mV6aNA+tfiF5deejpU5HXrtROFIY1U11jHiYx20hf+1cTqIB658vgDPqr3pEm1KyWJQzLzjOAoENH+janIfnEo8FzqnvUDmFsHmX91Lv0rY1On0rkFKwvYqyTteOvF4CZOZjXsbBa5KndiUVg=
Received: from MW4PR04CA0328.namprd04.prod.outlook.com (2603:10b6:303:82::33)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 09:40:17 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::2c) by MW4PR04CA0328.outlook.office365.com
 (2603:10b6:303:82::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 09:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 09:40:16 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 04:40:15 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Drop pcie_bif ras check from fatal error handler
Date: Wed, 19 Apr 2023 17:40:03 +0800
Message-ID: <20230419094003.804-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: ca98f8da-fb34-4f31-5003-08db40ba155a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hB+aldZ1lO6+4ysetcnueVwn4EiR/U7EvvP2L05CuJ2pNMdbOjh+REOu76qvm9l6+mcibOeK2oJjt4wXFwfFatnX9viKdo61iPP8osOqjTyQk/EPBtOYO2RzoxKA/SZ8btmmjaRC1TuYVhRBDkJ+w1VMYBJyJoGvYne8Eufh+jF7Tv1bAYuzVb+wWxWXhI3xOio/rPzIO0Bo89P5B7Kjgv/HYnbFuGHBXc7rluI+4qLUZbWLG9By7nt64SpxyY4S3lghoLbGw/7CJzZA2O6n1RZ95/w+M2C88fEA0y4TssN4L+Z2iuzDG4B6r91xo7g2YJwSrqmMdWoCfPBlYZZV6CndaY6ijPM0Bm/u5c7aJs/CGt4OGjyRVONtLA6nh3Nj/JAoAO//GwM7gO2nI7Bhv5FHJXQXNoLVvzY9zRghJrXva7ca8soXPWN5Msa7TswSGG7CoC92D/XsPui3c7AA/DAvDqolBhfZUvqOKnkxmXN1Ompgaes7sh8d1eIw5IE/SN1Qz96qLj7SJ3+hBjYpC4E/fYEtIoUM02Bh73XB5Bnghn1GOeBLLlK3LAbzd/WuRhW2X8wNGO21ll7KGTphicXdm4qNsUYR8v+o8+CQeFRskKjGOM3jsvW4kkAALa8ERYGlQiRZMjjMR88t1e8WsB9mW5aqXMThY9m+SeIt7GHBHAC2cGBaZKvgNBJFehfKIlEYoR0zki8ikrKfwP0kQK9ohikPUbmgqLfMoCnN4ko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(186003)(6916009)(40480700001)(2616005)(82310400005)(4326008)(16526019)(40460700003)(47076005)(356005)(36860700001)(426003)(83380400001)(336012)(7696005)(41300700001)(6666004)(478600001)(1076003)(316002)(70586007)(26005)(81166007)(82740400003)(70206006)(8676002)(86362001)(36756003)(44832011)(8936002)(2906002)(4744005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 09:40:16.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca98f8da-fb34-4f31-5003-08db40ba155a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some ASICs support fatal error event but do not
support pcie_bif ras.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3ab8a88789c8fe..22f401fd1901cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1597,8 +1597,7 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 {
 	/* Fatal error events are handled on host side */
-	if (amdgpu_sriov_vf(adev) ||
-		!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF))
+	if (amdgpu_sriov_vf(adev))
 		return;
 
 	if (adev->nbio.ras &&
-- 
2.17.1

