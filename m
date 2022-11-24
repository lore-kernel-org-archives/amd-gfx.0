Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FCFC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 05:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F1810E25A;
	Thu, 24 Nov 2022 05:29:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358F110E25A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 05:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+LZx2m8XbR1QzH2mvldauc6TTXhUYfQw8T/EIodqiRNcWg4NfUeU8j1C/b2470fNN0Olq23Zhv/+p++8vNhvA946VUH2+yroHq38RSfXkcQqPvxOfhQxsnGMP3+2+vOn3wgovg4r2RcUwRwQU1hv5gdFg8WMmu3GvuSH0jWu3Xs4l/LLXO0ooN7L/oysRAqDZsdz51HV6Vu8VsNI8Ngrssda/M+V1DCBw2ujlNQuqzZxDGy7P7OFP7ItvroFHMSyAA71Ui3AlUf9DfbnRejuGGl463sWDpWzlWMypRUfi4JZEGmIQ4R0b9D4njm938UsuKuQb+tbm3iGJrKvW5OjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PysmrUoYjr/tlSj7vxl/cdc58gZawJdNzQUCImoEOWM=;
 b=Z8uFFTgvmSdSkBDyAFFt8kBCTjTI4u34VAWpBEtmO6zyJkoa+IvQr+V4R54c8bpIVj7PJI0AMUCbz3lM2Y60y3TPHMVMxrD0WV0Kq0dS83fFWIEF83LlY3cYtbJZ6BTpwrnInFmZD9cVP9BZu6fpAfZLU/S7+yEoCmTNlVFusOBZk3pgqWKjw511BVH/VMbJ/K2ZkxJAHOGRylPIbjaCMj96hPTmdc+6CZw7rNvPngsFE4RKpHT9CU4G5LElF5oLnBekJgylIw74Y2eU4bOhHUyTOh7Eewlx5gvEJ6uyTDEXFSpduM8dLqLzNoklJvQsPknd2VAGhedCCUxhZdXqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PysmrUoYjr/tlSj7vxl/cdc58gZawJdNzQUCImoEOWM=;
 b=bGiqX3IFD5QWNrSdaYl6gGOsb1ReyOT7hO6dqx0CUv0PPlqgyn/0XwEVwYoM6jAKElosnnPY6clk+aYkQoLbwRDQogc6o+tgCXA6b8zJJC6IO4fdFjoijm24rIppxPncCnxRP+XWhb3MiTy/cA0Vohl+vN8ubami1XmhLDpsdrA=
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 05:29:19 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::3) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18 via Frontend
 Transport; Thu, 24 Nov 2022 05:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 05:29:18 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 23 Nov 2022 23:28:54 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: use dev_dbg to print messages in runtime cycle
Date: Thu, 24 Nov 2022 13:28:30 +0800
Message-ID: <20221124052830.1340810-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c251525-dadd-41dc-20a8-08dacddcd5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzbsUeMbb+p3/q6aEtDyXTF3OVLa66UNw4Ia99/dsiw4Kuzfibb+daSSUXYdP2Enn9CwIxLykaj2itEB2EWsthc+n6BGKfTz4qa5fd6YXzgb6krPU4+EJGqNy4pUEA+AhNi7xhDhwDzbyhGg5XXVTrKh6jpdcUeiF6nAlSCYQfcO864cdGbz/g/XLN6j/8f2LMKxCofk9lxIVGM29E3T1QuolVuCIeH08RuikYoBNc3+nJc5bf+MzIqJ6+eiejFakOBvtXd35C2jW55HOvIbQr3m+Wb5GIKEK/qt0HVP0KlBKRWKPJvtybZMezxcZjpcws6qWnc+gC92rAOVlYC542bYxZBkEmY1ubCoxIUlsTCLyWfMILvXEswG5hm7XODfkrM25tIIPJo8TvD9YA2p3rNajmL69ARapTS3ZbPq8DbmOXgmYkBDDq1obrcno+zHuweNGFFGEV7/uALUrQEZ1frpyzegsb6ONa0AhI8u1Q9aY9vbv9wGDyv+RoLLUB2w/8K4cUaJnnKmP3bU2MO0uRXj2uquVKe6Kri3/VLp9CMVO6nR6s9B/Z0B6jkXhTgOqvsUlVg9W41n8+ZkPor/vJjtklVxnZ5YzeGTUOzAJrT6c286nYjlMNrc7pvs/7alzr7CsQ2B1U+Uq5wN9O3gZ9u+dDMUvEACWcxJAfZ+fcFZ3dlPAN6Nh6GWnpUbxJICFqyAfU30plcbdO6/vH/7AsPKk0HA1KUb1zi5F2c5FIv6QSDd8zZxaTNS2C+EQGlb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(8936002)(15650500001)(4326008)(5660300002)(6666004)(82310400005)(70206006)(8676002)(2906002)(40460700003)(44832011)(36756003)(41300700001)(70586007)(81166007)(40480700001)(6636002)(110136005)(356005)(478600001)(86362001)(316002)(7696005)(336012)(36860700001)(1076003)(2616005)(26005)(16526019)(426003)(83380400001)(186003)(47076005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 05:29:18.9463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c251525-dadd-41dc-20a8-08dacddcd5d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Runtime PM can happen pretty frequently, as these printings
may be annoyed, switch to dev_dbg.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8b1f6c032a2e..447e27b2e16b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2568,7 +2568,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
-	dev_info(&pdev->dev, "asic/device is runtime suspended\n");
+	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7bb2de1d11ff..4a18d1944e4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -861,7 +861,7 @@ static int psp_tmr_unload(struct psp_context *psp)
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
 	psp_prep_tmr_unload_cmd_buf(psp, cmd);
-	dev_info(psp->adev->dev, "free PSP TMR buffer\n");
+	dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
-- 
2.25.1

