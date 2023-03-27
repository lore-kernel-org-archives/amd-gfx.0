Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69853C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 18:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1762110E3DF;
	Mon, 27 Mar 2023 18:11:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A33510E3DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 18:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AamcNyBEMCuDboEET9xOZz4O0IQMBwSEA2baQaNbJ4S3P5fNliXZfXeHGU4VyjcAIzcqQ/+S1Rx2rdxFi1sYgZnLrQX6wFOpyGR+o+quOHOST86Lna0C8z9J+wBg9jNrdOXQVyU0ZkbSVleJZ7wslbekfFN2VVRqrXs5y0QATeQF3fMFom9t9EtnP+XIDfaRi0iImLwZ6Z6HU/97TJudEqto8Fwq+6WY1X8a+TmGpo2IL61VqoJH8COp7kKSxH3YsyCeDF8pbKxPFHoCY5vBiD3PfJ9M3egm6Fv/+npDjDC8HmJRuU2CvP6QFK/bAWYhDuMQTtg70cWarf6SVQ8Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsE/gcMqbfV40AoJlVB6vRqqLV+LrpQbH1kPB0IeyDM=;
 b=K6qDbqCw4xwakliSAGite1m2l+4pUTgiqWaKC7s/DQtWoVMxM6J1QxW1Ynh6BI1XpYVO9XLXt9j3goOqjVSI90e/WHeaiOsiKvAC6f+gSnJ2SfnowA3yYGsm7pqNnf+vgmmNNdWiKs/t37leI48GpdwpoXCoEDyOl2U4ZcZYG9PHow12snWsGWYsZExH/dtojF2t5Newiz7buqx3G/VpQVvf58nBboamQYVziqmEox/7hG+O/Vtdn8XmhPOOSli37r2xLQY8Dq60u3ITExnUuxYGElLjJj29cPIwpsqLwob2rbxTNhFexLIJDdU4KacYVnL5lNi8Iyxql3vhKRVN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsE/gcMqbfV40AoJlVB6vRqqLV+LrpQbH1kPB0IeyDM=;
 b=ZaBbUomJGE0SWQ75wzrS/4Vq+7fyVEWI1+bpORQ7fO1rgqWf3o9SVocnZufrpfmriA34ZgZmoC4AauYpamAvUE17cSyEw9P+M+U9Qr9ylsnplUK1u8g3PBgTBDW6PtE2UVySGfCIibkfFzEf1JIoJze8apYV6U2UQtUCqFlqiK8=
Received: from BN0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:408:142::9)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:11:16 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::91) by BN0PR08CA0030.outlook.office365.com
 (2603:10b6:408:142::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 18:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Mon, 27 Mar 2023 18:11:16 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 13:11:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Remove initialisation of globals to 0 or NULL
Date: Mon, 27 Mar 2023 23:40:40 +0530
Message-ID: <20230327181040.1972784-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bcd8f1-c3c0-4806-1933-08db2eeea82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THUw3qIWkKElNdCPIvRNz880a6ZeR4lqsltMqNNvYGnaSzUmVb2WZBlm+03kzGcnCFbfQefIL1pV9c6WvkSNWjAbGXLlkAIx3UZEfpNOVk9rUJV8mIlKbiEMu7SMkg1iGvXMOEtGiuGyRmVpw2iHKBl7PIThec0glZud9OIzSujGARVe60oOD5OLr9UjB7zUaqNv7Qv/VQh3KpS8CO0ZqzzBQpULQgrE6GCLg+H5N0tsV8+/KQNVDtzaxh0qb62YPegD+XHQ28MA4Wx6i4rO5Vf/88um9QwRhIj+CL7DJImr3UkImfgDIDsxiaPsyrA4sx6JTDkv3VCu0QfOB+tPxDa5261i4K/sW3aLPiXsIWDIEy9eVg5cS64PsSy30XqeelTtEaPKIYvDti0Va074Qs7ZONjIMVuRx9DyLiHMY/DYttKWD6NsWYiHsLYyLrFUqtL8BKwMTWFB40MnTq+tLjFOA3Fb2IYjwHkfvlEMQ0sKLTq2IT5bag17oOwLvGwwaao/f6Fx9hptyy+wmu/1WO1qQaCN2O0b29j8CQ09eoeYc5TzWib11jOv3qttCRJvsy4pB5PvGkTUTcBf3cfox10WEZJVhbIno+AgbinpxdwAsc4gKse/7vukAlsRPyku2fx/E/orh706cGV1cOqcxo78De5r5gqZtjEdN/1IVcY6VGCwc71eo6k7oOcma7ypnQfuPKs2uEgG/EyssWet200gdZwSd5s/kjD17vJKiPM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(66574015)(47076005)(356005)(478600001)(6666004)(16526019)(36756003)(26005)(83380400001)(1076003)(82310400005)(186003)(86362001)(7696005)(41300700001)(40480700001)(110136005)(54906003)(6636002)(8936002)(5660300002)(81166007)(316002)(70586007)(70206006)(8676002)(82740400003)(44832011)(36860700001)(4326008)(2906002)(336012)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:11:16.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bcd8f1-c3c0-4806-1933-08db2eeea82a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Global variables do not need to be initialized to 0 or NULL and checkpatch
flags this error in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:

ERROR: do not initialise globals to NULL
+char *amdgpu_disable_cu = NULL;
+char *amdgpu_virtual_display = NULL;

Fix this checkpatch error.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 917926c8dc5f5..ece8033dbad29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -149,8 +149,8 @@ uint amdgpu_pcie_lane_cap;
 u64 amdgpu_cg_mask = 0xffffffffffffffff;
 uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
-char *amdgpu_disable_cu = NULL;
-char *amdgpu_virtual_display = NULL;
+char *amdgpu_disable_cu;
+char *amdgpu_virtual_display;
 
 /*
  * OverDrive(bit 14) disabled by default
-- 
2.25.1

