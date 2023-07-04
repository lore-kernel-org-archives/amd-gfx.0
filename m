Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D391DEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 15:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0BE10E146;
	Tue,  4 Jul 2023 15:43:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C57510E146
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 15:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/2U5PyOuW8krOU9FByJnk0RstrYcOhQwxc2pQF0S6uHK2t3lLizi64IzrsoWoo7KWPWTUGTwAUOV3SOBT9QZ5Z4jdz8Wkq8fRdsNgJu6JsC63AUvaxMfK0WxjdkdfmBKjuXEOcGKEJegFQ5SuAZzcJHnGRsl/jeyRVxgn8TxkaJjtnmJTKmPq6osH5Gen0blEebfwpeK5LSVnGejCyLYLc0GmVVCF+tcq1EnolUSTqe/Vx5JJmGEzeLALaB/+3xXBlpZVgtdKWj80FNq0XXGl39EclQwHrjyiU3dAFRSAVawNkg2X/wjlWYESv7d9wTMH7IAwsBvBDsJsA/htVFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYl+uNAzCfH4ARWJCmNM1jEHjX4XoGgXZV/a768DqwA=;
 b=TBh3q9HXIeMO4RhKcfxUdbTB7ByodnJC3FR35qWar0hFz9v46z6MPg2ba2+v8BwHlvIwqKVTUIhEIFVNYQo+adYE6GFRTp8tYfMxAYXNmDvFkkokdRVUdNOQhrWxXu7Zoa+0nQqqhj9GZdsRfcws0J4Ukd4PGGsndg/hx/9zdhCuuXvbFTMKc1QPwDFCHD1XqdfVctfCYAkYs/QVw2RWnwOXrLykvGPyrSh1fVUpY2b1Uobj3SLtSw85M67WMZdbb7B4mJdJ+ChQJFOY6lI/ucDIKlDWVIJOS+5DO6XWRt5y+/8T8w/wsAf6lD2ya0v4VazXytkuuEiW2qEgqnKzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYl+uNAzCfH4ARWJCmNM1jEHjX4XoGgXZV/a768DqwA=;
 b=nlYuUSTxjKXxR0DnZUjObEr+Uwvqn8ajO+pc32jGKS+Tluo5bfVZyH0/ESMcWk4pBAcreaq0Xo3qcROdHKTnEtMI+4Cq2wXA7dyqJ5/2DdaHOK4A5ZKpriDmMaWuq8cMzNPN3NnQxkfc88vH06dPMaJURGIgN9TN37/NScOSX20=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:43:46 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::c8) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.31 via Frontend
 Transport; Tue, 4 Jul 2023 15:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 15:43:45 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Jul
 2023 10:43:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer dev_warn over printk
Date: Tue, 4 Jul 2023 21:13:24 +0530
Message-ID: <20230704154324.4094268-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a99c748-a281-4e16-d991-08db7ca573f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hRGvIEEUIj1uksZnR0UjpWVWp4/kbKQHuSxPPvhgH7OrlMG3vlH4L3i5wMJODwPmcgMQvhj4SbcOxuCj4oq0saJmmsWxAUvsf2etCVdwrjo0fB55dtoSz8JeH0u58BDxiVe/ilTeVqdYbk5+bcAnbng20sSrEffLwMoMcpYVbO8/SWqK3joycgpzshGlCRYDvuYMMyNKHGRPs8+AXMdSf/I8rHvMOFAvpi7/t/EoRdVp0WFopFsWGBA46gTdDqu2dL9c5jgHt8+DVHoOwY6XxgqQ59bAOs/V1JzDaDWLy6rMQwO40/tNbrNleFs0r4QzdixJ4Fdr9rH/oAm/b9aG3tf1ye16s36aIj+dbUfszN18B63T0AScbgLqujqsjm40GAaDibRlqjrLlGlhHXTgJHZPqd1YacTkiCII+7RDlftXzm9v2xLxdGIov37oMCN/WJr01+4BdTKqWgJlCgf7lXk/2oBnFDBdM9tHcHZ15iFqK8dhJnR5jSV1cK/LrCjeBC7yqOpBsCTPVJUAj9XKgFt6Ngqe8HupRYN8YpVGdgzfG6QjuCRbsaXQqrkLFKL0UffLhWBRra2LtmLYjhQ3JzRN2mhkUMhxrPCkXUpxv3wZZMFsdDf7ZZsNSuuU6o2cE3Qkj8v746u7XnchMVYEuk6q3UeCOP5gJjcLoIU4IqgWQsDNYekIz8twfT4dSPw+kfVbklp4zEjG7KwAfybT1I6FR7Df/yibf5Zhnyr3L/r8kcTInIis2/raxcpEQkyzhzaxxkhgjl1DDBHqOj+7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(44832011)(70206006)(4326008)(70586007)(2906002)(478600001)(316002)(36756003)(8936002)(8676002)(6636002)(5660300002)(40460700003)(336012)(41300700001)(40480700001)(36860700001)(86362001)(54906003)(110136005)(6666004)(16526019)(82310400005)(7696005)(1076003)(186003)(83380400001)(26005)(426003)(47076005)(66574015)(356005)(2616005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:43:45.9266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a99c748-a281-4e16-d991-08db7ca573f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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

Fix the below warning:

WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then
dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 13b89f78d07d..77a32d53655d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -973,7 +973,7 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c68ecb7dfa39..73ab3624f8fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -824,7 +824,7 @@ static int gmc_v11_0_sw_init(void *handle)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ebdbc823fae3..2aeeda276ab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2151,7 +2151,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	dma_addr_bits = adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) ? 48:44;
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
 	if (r) {
-		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);
-- 
2.25.1

