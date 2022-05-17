Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1D0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A0F10E422;
	Tue, 17 May 2022 16:29:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F92810E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI5Snsg4S3kO0v9pHPx6Vxbk9vSg4K6wmPG1ihSnmI3N8LUnMqyPRd8PqTB6bIvQEpdjiZQOnLtFq+yiJuPhirl2SlMUuVcJ1vyNudom6dk38EvFaGa2+Os51gg0jQrIWbE4TMFIowBB1k2RP2lX0EdRJFic6shfsmXGuermYHSmAy1HSYiaxlwbZVNGI0I3ACVNKir/wod3isJrt6AqFux66eCHQM2+ZVdgxv9x1MmTJ14IpyunoX9uXtAwcNj4/BjBvQqd4YGSuYTA2/PV3KjmbbNu7Ohif85nbvgHhkvUz0UH/ik4rodxtQ3wiseGhdxiNGd1XfHbWTI58MQ1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51nYSudSJ4GFNr+3/bUtm4mK0X0it4YnsN8h9YagSCc=;
 b=YPDO54ffJbXXYA0deHhDosRdyZKY8NDi4LpyxKCOF9VaVg6d8GBpPzHqgsHyZwEUzIHo2UxtWUIv3Zu/yNq0UlQogbv+hlIVlWe6mLtbc99pueXa0RQCJ+RxpveuNltpG08s9CYbyoVv/9yrjgWFhvLLjQ0KdrZnfL8rlwc8w9T4qoAN1cskxKoybrZ/ZHmps3zFXRudVmBFiPlSNt92hiSQv9vx27+z6UCoTkjvCdOAsTy3z66CMnMuxRr/1Y0LaQPAdOcPMGwTyKf5KJRfgEKL28w1Dn1m22vmHkMU2bnyvsAET6BzswvyrhEKSGrqlpttj7HSD3VBKO4Ai7WCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51nYSudSJ4GFNr+3/bUtm4mK0X0it4YnsN8h9YagSCc=;
 b=5MCweEUEu9XQnJVLXl4+n133pjq97/2Cf2kwusX28lRL7u1Qwm1iZqwJOe4DKHAsYGUHS6EhldM3xHrQIKSURdpqVFPyIbopZ1muim2Gzxr4wOfmfCThOIoXy6/r2759sCsTynhHL8osvnurKlVcK7KDL3FCPI2UoL58wV7Hdq0=
Received: from DS7PR05CA0105.namprd05.prod.outlook.com (2603:10b6:8:56::19) by
 CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 16:29:35 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::34) by DS7PR05CA0105.outlook.office365.com
 (2603:10b6:8:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4 via Frontend
 Transport; Tue, 17 May 2022 16:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 16:29:34 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:29:32 -0500
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH 3/3] dmr/amdgpu: add support of tmz for GC 10.3.7
Date: Tue, 17 May 2022 21:58:54 +0530
Message-ID: <20220517162854.1017207-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517162854.1017207-1-sunil.khatri@amd.com>
References: <20220517162854.1017207-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c3f9c8-3e3f-4814-74de-08da38226dd6
X-MS-TrafficTypeDiagnostic: CY5PR12MB6550:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6550AE254E653899CE5132D293CE9@CY5PR12MB6550.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBMeo5j7tA4xMOfYxq9vbDWDt+0qXmPo45ScO3wJzW9KhZa7GfQiRf4/XuznXN2DOzdlYp1nm5D7RpxR//O2RsTnFfc1lRBxO49ijO/QbH/oqOyM0JlWUFJ36oFSktd3g3qYCIj0zqJJaZDr3ntyIyU4Fwc6Fi948ajM3ZmtyKIsv9NKeNJDQUl5H5XWRbGDXyPtopE8FaFJkFHZlq38kXxNaBoh7bf9an/Ev/QY3N5CqcXahJ7NoDkOso6f4MbsAbGoPI/wD/XMSE5mHSq4yWZcS2YrxK3bp6WYZdsf9VsabE4jk0bF3YIcXXjQpIsq1OAmihF/vTqgfhVcXfydZXxkKcEwWJVO00XjdWYVwBBrXwgzpRMaoFrv+RJkD+Go8JbrflcJ4HXLpLDSBx6uEL3juXNfQpHgqwRZxQZeRm6KHEErDJfs7eAUEOS35gPxk5X3QZY56VmZ9kItGsvQRw5d6nZKYQG0sr6yin0qqpil1yg1noHY7A0Yp+fAOLoz0K6EOEnfFISWr1m1Ol05mlUKgRhlllzoDsmXy8PQAVnXlRYplzNPYuHWHJQJB4lttzqaPnHvlrUFPzZ5d96HftjENGYW4zUvk5EhC1KTrZgunPHT8+GXGEjQDqS+43rxI6wweNdBgwXB8UabWgSp1NRm0IEdShm4Pyf6mDlNuIy1PV6/b/8r5C8b+Zyw5psTRI/BzxhpZ0CCuXuUxEEsSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(8676002)(8936002)(508600001)(44832011)(2616005)(82310400005)(316002)(5660300002)(6666004)(2906002)(336012)(426003)(47076005)(7696005)(36756003)(110136005)(36860700001)(40460700003)(26005)(356005)(54906003)(6636002)(81166007)(4744005)(4326008)(70586007)(70206006)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:29:34.8223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c3f9c8-3e3f-4814-74de-08da38226dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support of IP GC 10.3.7 in amdgpu_gmc_tmz_set.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7e55ee61f84c..798c56214a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -540,6 +540,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
+	/* GC 10.3.7 */
+	case IP_VERSION(10, 3, 7):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

