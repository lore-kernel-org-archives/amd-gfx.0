Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C6BC001DE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 22:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5671410E38A;
	Mon,  7 Aug 2023 22:06:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A090D10E134
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 22:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oecmBrHwzlA5jeq1/cw1O9BdSV4hBuROpqayoZEBTkiKmQd1PNt4F7yLXCsu76orq/QRuM0POGri+wv7fBmMFEVi8AqjAocywCwu8Zy2ztfyHJ/2ZIkfo39fCe9YMJSnTG7pVs5OESUnWzp6HfOoehZa1XlafjKVlvKCQj6uNaDy9iQCVC0b2RmttGbxrH1GayIc+ttfdgBrBP3mmrAjGXUsox1XAiZvDghHpE6dt5MAKJ4mvMaWWpGrxPBqMG5RNzCsPzV7suf0xfcmI0Nnib7+wMwKBa7xA8RhOapxxKz9Klc1f5o4AcKYAmZYwT0pSEb+5ZHiKEHP0Gin1xMUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpoapIfFJtImw8DpgXhWdKEqO7dZiVHs1bChKRTUSgI=;
 b=kaXk1rOG19tfmP6KK8TjGgU8FqFqzu9Mb7snHZhgPmDv8LzXD2kP3ky4As7cOWotCJg8naRlOkMauj5dnVqsjgDArmDL/6IU8E0eXstur0El/XJ/icd+MlpuIxZKTVd7IFC9afOnQ1v6PkUCMcdfBaxqu1xD7JYkGeh4Lo5ibrnYhBmGiIYkw2V5Hxg1m0lM9iX72L37H5MUIKtn9a4dC+RaAlOFeW/7YnSeYHWXo2GIucycKvnM8emJkA3O7jbTz+vmVuXTatO9KJTWF1RptSrM6P3JbrZXatAg8XfcRvB/k7czKKAocL/nNtTd8hOc/zedEMgrseNZ8gBlPRSyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpoapIfFJtImw8DpgXhWdKEqO7dZiVHs1bChKRTUSgI=;
 b=rXKkjN7goJOZEVYljkfVqSfxz3EyJyht7bMh/39pHpMBOL3eIelUhnqm/iAg66dqWpTAff+R19K86hKqlXgVzWlknTXVe0ZzA+z2W4TeiU9UikCFPg/+y7TV8HLiXNdCOf/eXcW3DAfYEY4sjDbDH752Zc8smjUmSWKMLIR3MSo=
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 22:05:59 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::89) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 22:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 22:05:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 17:05:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/5] drm/amdkfd: rename
 device_queue_manager_init_v10_navi10()
Date: Mon, 7 Aug 2023 18:05:45 -0400
Message-ID: <20230807220545.1320198-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807220545.1320198-1-alexander.deucher@amd.com>
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: b2382aeb-716f-4227-c241-08db97927b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56r4B5dCxi4Udx7jkO3PRxb1iB6p9sz+o7+VdLk5wxwaqK4rH0ToFp8LW8bi1KjEPvtoR10/Jugh2uVYld9jWdzq01kmB++rjwdbdLgskOvcqGcvWoU+oY1HJgNWw0b/rIi6kj1kHjB9v+Rx67laT0jL60QWscbLLFEG6020Cjct4OmzfQFzkGmeqMrKXJLjSkrAfOtYcCSvbfJBdecm9ga+B7TPcoAjXEFQ23+JoayzIsdz2GBxNXNKlSUCb8Z2CMRMD4rFc0IIacJQers/EKqnH8UZwooaBW/sBGGbgjZbaUal3CHJuJ25l2frIvRcvUtEwBgQyeHU0chLuCsolEYgNxS+0lE1ZFPj5LXuH+sE+ncmCv+Ls73WkqsiDIbrisyBOMGjCuenlAO8xuCrx3hgn3NvyMCBC2iMS8emfoOFsXJ6om4rSxCavh5JyFQJh5P2pEFmiXLbW460xI2JJ2RS8YodnwNrFrQP1p3M3kl9OXi5QKUQMgjjMohRmQpZZ5S3kwEd2bfxpqiQWbO9NuiFBWlgrpT19mQRRQ4xHTC/laIo0iWbrHGWzlUR4oohumundxgmhcJWvcm+VHlBP810UmELHF9LrY0CSV3IgdMldA8iMfrX2DhoTumv9rpU9mYoDVcLVlhVVMSRKJIsuHYN/5S0yU/zUMDvsou+pV7HvhGqub1Dj8oDuk/djtIiqxgvyrkswaPcFZhEO3tnLtJjmLWM8Q9thAInoJK/PX7acMjQHcLMaaqIe17bDWhS71CEDayHnHYs7WIMCd8ZuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(82310400008)(451199021)(186006)(1800799003)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(41300700001)(16526019)(336012)(478600001)(40460700003)(1076003)(8936002)(8676002)(26005)(7696005)(6666004)(426003)(2616005)(5660300002)(47076005)(36756003)(2906002)(83380400001)(36860700001)(316002)(356005)(70206006)(70586007)(6916009)(4326008)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:05:59.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2382aeb-716f-4227-c241-08db97927b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop the navi10 in the name for consistency with other
families.  All gfx10 parts use the same implementation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c     | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h     | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 20aa3b7dbc362..24ea3a596b382 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2577,7 +2577,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		if (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0))
 			device_queue_manager_init_v11(&dqm->asic_ops);
 		else if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1))
-			device_queue_manager_init_v10_navi10(&dqm->asic_ops);
+			device_queue_manager_init_v10(&dqm->asic_ops);
 		else if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 0, 1))
 			device_queue_manager_init_v9(&dqm->asic_ops);
 		else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 805d2e4f907a8..cf7e182588f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -273,7 +273,7 @@ void device_queue_manager_init_vi(
 		struct device_queue_manager_asic_ops *asic_ops);
 void device_queue_manager_init_v9(
 		struct device_queue_manager_asic_ops *asic_ops);
-void device_queue_manager_init_v10_navi10(
+void device_queue_manager_init_v10(
 		struct device_queue_manager_asic_ops *asic_ops);
 void device_queue_manager_init_v11(
 		struct device_queue_manager_asic_ops *asic_ops);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
index f1a1f5753e652..245a90dfc2f6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
@@ -32,7 +32,7 @@ static int update_qpd_v10(struct device_queue_manager *dqm,
 static void init_sdma_vm_v10(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd);
 
-void device_queue_manager_init_v10_navi10(
+void device_queue_manager_init_v10(
 	struct device_queue_manager_asic_ops *asic_ops)
 {
 	asic_ops->update_qpd = update_qpd_v10;
-- 
2.41.0

