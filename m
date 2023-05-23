Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7144C7EE29
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 10:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FD210E422;
	Tue, 23 May 2023 10:17:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF0010E429
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 10:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7q7iEP8ACEfA8cb6ftR4x5nP6oWfo+Pb5o8jSemhhWYBuPk3d19e9x+vOmsJQpbjJvX8MADe1iYxIR9zYnSUJS0sTRjEi/HHhefxWbIwp1zE/xAiRBD8FpttmUagw3FB82gxyxt9wGwbBRnqUix7rfwU5mWnacDjDXoqD1MIQD/9XaPJIS3RrkUA64MVMgBGiUYXvJ7Q7sXJg68dOwfbYhFt0BbDjCDrjuAIueMTwiQ4Qp0tsrzgv2WH8K6gpBVrDKM0U7rbVV39QIbza+bae+pR89qaQXxeHpQiHrE8wO6gpSxbPK7f2QlBRLR1kUGt6PBVvCwcOnXmxpVCrPL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CKLCxEiJnv6+MyT02aj08waGQrwPkbkuUL6n9OT6dg=;
 b=U8D6lhwcQItoy8Mcu72d9aYRAzjLs0krOK6HT5M0+qd/1HvLfAWxVw2ci1bLD/xc6xFFwgV1mRs9b8McAe3CwShhsR2dZ2Vkf5HnpMg3cJ2K7ysR273f9ftBPudfNaOaC1nkAkFmPWMQMD05EzieMzRmIG1tMAcp02sK+obCbL3ktROuWzHDuo1yPXMRGh6C2s26Cd65w6ZeVVVntot14oS1RdBLwf5M5xlOGXcmq19pdfXUBXkcdnrh66N5OtIZL7g7ZBVmicfFlMbPTfHqIaaBw/r0v6+O4iIqSJUFBu94ZE1LfLa7tvX2r2/xu7vXCzGmcHRGayiGXf+psWr79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CKLCxEiJnv6+MyT02aj08waGQrwPkbkuUL6n9OT6dg=;
 b=yH5VJm5pPKs4aMebnKXibWVV4KZrcFHQbzHO1HhhDWhcSYe8OWMB5cXLSsDxF7wrbB5yVvyG4rEwg8kHI4Kug8Vkt952Jn9a0LkLQbkNkdNcfKa6JtfErJCCH8fuVVElLRhA05OufzkYyd1tIWNuu/hStszDUGhfdBiEbinNIe8=
Received: from BN1PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:e1::29)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:17:33 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::9f) by BN1PR12CA0024.outlook.office365.com
 (2603:10b6:408:e1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 10:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Tue, 23 May 2023 10:17:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 05:17:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Mark amdgpu_acpi_get_node_id &
 amdgpu_acpi_get_dev functions as static
Date: Tue, 23 May 2023 15:47:12 +0530
Message-ID: <20230523101712.1134980-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c3203b-3619-4205-948b-08db5b76ebfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJ5URppLkl9YAOjehJcODsfRIf96pMVss8bPrxu/5OdGu4BQSazX7r8wYmAfpfBEV5k+sr1fYAXnCBdXyMJaR/n+jjBInd1TWHeNl66sQr2B1FEO2LJkJOonV9j5csmdoraecxY9mtDRRucbAPNg6U4a1YyXA/UBy38Mt1/MmqRckvs2LYNbgH2bUNneQHUqjqN5vKMcYhNNIDMAGqBIasYCPwi0jF5+S6Rs+ELA0iXav8Wkm9WI7SKnwqxj3i0JQNk2OCM5wATPNtzwHHUN276dQFbzF3wZa8UW3bMBI7oJE7aucvNYze5My6RcNG0DFlS3ImQKUoQjvEFethBF8brJZYma8tKSNGMI+XfKuGBcHRmzd8790HZRND972R+zjRAT2o+qehECjTkfOrh8Afz1BYbqtH/RYz+ubRfvmHr6K/UVLiBJEcUiF/aMFCdFwXIiOzZwTlHEc2M7rWIrK3fPzU8utT/MVyXP3Y+sVzkjyXSXMxzYsgYLsaX0S68YNAT05c6uAx8D5P49sTOG3mKQmJc+RLC/WF1rUOEUw9XpFJuiqwoYvaEvzFhPQ9MdZNFy7QbfBQZZEx1GLO1gTpKzc+LT6h+Fs/hGoYisZVUQwuBeAEYMZvgPX/991VXy3NfS2nj+3HVCX6QopkQT15kIvlciIVNBn9d2lbADaxsma0rBBjjyunUR3wAM4E0mnmFxnut2jSgjmmrevoyk0Yn7V1lIP6mHYKAhltGNwNL4Az9+nF2l6I7Fmyafo/KS+7l+xrpBtU1zf4iytJKnqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(40460700003)(5660300002)(8936002)(8676002)(83380400001)(66574015)(36860700001)(47076005)(2906002)(16526019)(36756003)(186003)(2616005)(426003)(336012)(356005)(82740400003)(81166007)(86362001)(82310400005)(40480700001)(1076003)(26005)(110136005)(54906003)(316002)(6666004)(478600001)(4326008)(6636002)(70206006)(70586007)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:17:32.5990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c3203b-3619-4205-948b-08db5b76ebfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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

Below two functions cause a warning because they lack a prototype:

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:904:13: warning: no previous prototype for ‘amdgpu_acpi_get_node_id’ [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:930:30: warning: no previous prototype for ‘amdgpu_acpi_get_dev’ [-Wmissing-prototypes]

There are no callers from other files, so just mark them as 'static'.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 1a66febf6981..82653f8496bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -901,8 +901,8 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
  *
  * Returns ACPI STATUS OK with Node ID on success or the corresponding failure reason
  */
-acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
-				    struct amdgpu_numa_info **numa_info)
+static acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
+					   struct amdgpu_numa_info **numa_info)
 {
 #ifdef CONFIG_ACPI_NUMA
 	u64 pxm;
@@ -927,7 +927,7 @@ acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
 #endif
 }
 
-struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
 {
 	struct amdgpu_acpi_dev_info *acpi_dev;
 
-- 
2.25.1

