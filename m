Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF1EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 11:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CF510E1DC;
	Fri, 30 Sep 2022 11:31:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E6210E1DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 11:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Crqphn0Hqm4poa2ZnpQ5qdroT8bly77r8TmI7ZsqtRTfUFhBlJ99cKTF6oOJ96nEGIiRAFfuisfqMczn1vrT6VG3ql6prd2LrOrrx7vWaunxVbaeKIye0v3iQnIIetqhKbaIDZa+b4tprmn5rLEqbjxZGtnkm56WW7KXzOTMDweWXWLJ3UdIrKzfuyjNCKCJMdoweOVlB48Khgec3nbA9taCCQDoKMInZMeT3IaHOIqFUV/ofqSxGa3GPQpOelWTn09rpHUMotn6RZiwAON4ZtsCHarDYQWuQRNg+9xmLJpesyXNG/e9Iahj0j3MbKkz30l6X4a2AZReEwjpOxCv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4+snjbhFV+cugje1N1Fgc+S79PhAA7mko3hrAXKu3k=;
 b=XOPcbHxFHCEnhUSsNdFKOwQAIgarXFvqPXSVNyjZwMaNXu22FmRYs/8RAkZ5zaXgfA95eztRE3JGeN9IFTrOlAHj4m+YWuPi8N3+jElJyQMsN7DOV9LvW8Brar0gtdfMeSEncNIYiN4tyFIfqV82gwjT211W0M2m9BJrpaJ78YFyIqLC2P2Qlyub3GOih7g8cK5nfooEWcbzgKQmcKAPvfUBbrsMXT/fUry2wZ1aFKicCJEufWZNuESNNLc41iinjBlfpKOUsa+DV7HnhBbmMn6Fhk+MePNut4w7MzlKOmJPIaBPq3OK6Vwy8k/469nG5s6/oFazFPql2hMqZfmkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4+snjbhFV+cugje1N1Fgc+S79PhAA7mko3hrAXKu3k=;
 b=qN0RyhrHR05EN82wQM1Q0bL85P1xxz2FMtyZOKAw34XthCcgmXQ1Tf4O8CU6Qq1xRfp9CQEv/H4ahx6XmTFWxf9jfYQgyD5fV4EqSFwmEA4H0KJ5iWM3eAiZSBsOEHt0FOa3ICTOe+dG4o/Mlsdo2WyXhp7RnygNilr5yr+1XSc=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 30 Sep
 2022 11:31:47 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::64) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Fri, 30 Sep 2022 11:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 11:31:46 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 30 Sep
 2022 06:31:44 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable F32_WPTR_POLL_ENABLE in mqd
Date: Fri, 30 Sep 2022 19:31:05 +0800
Message-ID: <20220930113105.6495-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: d72a96ed-b290-49a3-f524-08daa2d75be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSsTQ/YjwTV3kuYz+wljX3kIfgmV06ly5kv9T54PH2ZDOOranwsBZrgVe/qaHJSY1XCPU+WOn+02M7wKC5pDs6nqthg8aBOWD7RQ8GKl6ZuCqU6QfrjlPV77begaBCHz8UvyENO9FxtWyQRNK1tcRMNsck1rMF5hCVDVDaU1+U+1Cd8B6buBHxfhjl1emzXAB9rbhvdR18Ie8l2givuKUtChiEBs5P9j++3KnjNB3B4RVNGXHvZnwxx8yQfY24WBRChSCJwVv/YVLMB0xBXhsQGvoHSeKhdP+Zs6q3m37Y0GlXIVUzpZZbOhOghE7pwXzmBeP7Vy+zzjhLqJH8np2sKv/VOGDtD9qkmfILQ5fxsc44r9tvbpul9zwf1P+rhXwZ2UeFO7/IexwPXA0FpI9WkuxH0wUQzKgikdKgMjlYHrINL6cKDXig0xoeA33x6x4DTgUEtx/2nk32horNTnnw2LAhGC3jWJ8rFhazh2wKXYYHz6wWU1Rsx5/zfG+wCyeU3Modfbgg0Dbal7up7fkojG2s0LZ/imeZM1e0Sb8FsET1diJqJ39Wyv3OvZpMmLnSqKkyZYMqmikdqtv19rXTqmiBPbSXx7HiAHqN3zpg8l/hx+XtU+8P431km7Q+wuNMM53kVEuKL7za0rYIXWQt0jU+qDrdkAVwsSDjeItNMFDAw2/7MlDEgU6KwVCJZ1ECpL8fSFFhK4bIrzktqNq8zA+/fCSn1HNGv5VztYKOM+hbV4gnRSUSCa5ZajXVKtzekjXYKNBAcvoNu4KHbnnOK2PmOxk9Uaa275DxYsmWjHvcs9Zb4myvTa+5x1V6nL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(2906002)(8936002)(5660300002)(41300700001)(36756003)(6916009)(478600001)(81166007)(356005)(36860700001)(2616005)(70586007)(4326008)(70206006)(316002)(8676002)(40480700001)(54906003)(336012)(26005)(82740400003)(6666004)(86362001)(426003)(47076005)(16526019)(186003)(1076003)(7696005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 11:31:46.9227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72a96ed-b290-49a3-f524-08daa2d75be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327
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
Cc: yifan1.zhang@amd.com, Ruili Ji <Ruili.Ji@amd.com>, felix.kuehling@amd.com,
 Aaron Liu <aaron.liu@amd.com>, Ruili Ji <ruiliji2@amd.com>,
 Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

This patch is to fix the SDMA user queue doorbell missing issue on
SDMA 6.0. F32_WPTR_POLL_ENABLE has to be set if doorbell mode is used.
Otherwise ringing SDMA user queue doorbell can't wake up system from gfxoff.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Ruili Ji <Ruili.Ji@amd.com>
Change-Id: Icfb97c3551509b4d7fb172ebc4200edf5844e5e1
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db51230163c5..0150f66a5ae6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -846,7 +846,8 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
-		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT;
+		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
 
 	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
 	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 26b53b6d673e..4f6390f3236e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -333,7 +333,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		<< SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		q->vmid << SDMA0_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
-		6 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT;
+		6 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
 
 	m->sdmax_rlcx_rb_base = lower_32_bits(q->queue_address >> 8);
 	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
-- 
2.25.1

