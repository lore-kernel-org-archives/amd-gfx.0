Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0FDC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 19:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8731610E49E;
	Tue, 23 May 2023 19:07:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC7210E49E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 19:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTvZFatN5yz5Bo/9CKTZeCw/qi5MzHfWbCACpQaEXBFJSy7IbDi4r1BeeV56yd7bvR8o0a3a7axbzTygze6BZuYSa+V6l4zVXgZngSN4BauZCrGhyWYjS1qEQgb0yzcJzuijbUEBNEJGI0HHd5Nb9rYKE+powTDXTKSxR56SYYiGqpRhrx/rLB1hw3P8amCdjWMpo17y0Egf5mDgUsOO6nEQOGZenpXCKyfMN/ONc6vCNioALzm2yyoiqLyROAT8JJ+JuQPRo8+e0Y57dVdE9sVUlmbi/6IJDm8G9DnuVsc/6r+wSinemJ+vRBDUErZJi7sR9fOZZqtlnBV8vJzzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6AryWEjLSkE3JDhqsRNuixKa29UTEp+HV4EZltbe9o=;
 b=lzIyZnqtHpBv0psQ4Rx5djjQzcaMJpCDepsMH4NRnxYRWG1sJgClo9waO/QE7GRjH3rIibvFxVXuJTv21fKaLmVPWGZ4U63CoW2Leyx7eh/aGSvXvqq1P/0gD4u3hJJIQ6Uy/LvdPIwldDJfxSy22WmtTidL9QXPPsIQzbFQ2twoeOVTEWVK79kzYnz3sdYYdmonNjgw0YZiioJnxJfDQfhcaijQn4py1po7HePrn6HxrLNIjsHOEipIXSTChvXz/QDpLn244wanqhM6B3DpafaL1ErdnhqJYNWPMXVXudMS5oNI32mwVstffPfz8I1mCcdCdmGWWKUBJyLyc3jM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6AryWEjLSkE3JDhqsRNuixKa29UTEp+HV4EZltbe9o=;
 b=UnMqy5TZjb8ok++YH5bw3GptIakJFGqTx0SvkwDRwZQ8rItkZQGcBpbhKTqCwJU6GJ7qdQJ1Z+ZdmKmfmHUqFRjd/O8IrSEQuy2dfVmv2rc61m8wW9sZl7CXpWgFsRvqXWdZzeoGAfTl2MF4DOUWc83/pz4AhRSo/L4HYHacxk8=
Received: from BN9PR03CA0794.namprd03.prod.outlook.com (2603:10b6:408:13f::19)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 19:07:07 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::7a) by BN9PR03CA0794.outlook.office365.com
 (2603:10b6:408:13f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 19:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 19:07:07 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 14:07:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unused variable in amdgpu_gfx.c
Date: Wed, 24 May 2023 00:36:34 +0530
Message-ID: <20230523190634.3094481-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: e80885fb-6f02-4cd6-6a7c-08db5bc0e758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvRg9ydMZpm+LYUzmpROjrg0tAssu8J+JUZSsNQ36sl0sUIF0h0UkiO6bDQkkyl0fFjKVAjmKIlTEeRLFt339dWyvJ/CY9MKVZlrawMOOkk9utMZbVsErxo8oxmG2ju1YOlqYUTqHQkKZNSSWW1MdnfbOgXQT0xdK4CITzZ63f35eyqwXDSMJlG+GEtCfdd3AS6UwDX9fCQi/Xb9oxXE1qvjnFD4y+gOKD0pXoEW00bxZU/6TiM5sIlYWbvPMbtUHHJnnyL1AeaXADEBqizTbFMhXSYQ9dGxxvspC5FI10magorGnyzKpKoXSxaqz81X/XWE3zdBQg2L1CUzn31uS9covifKO0sD86PURFsPaN3EcxGb+kA7/3H4WGYfIoY8eRNDssHaMy5l61+p24svc7C1Uit0D1QlMwlDM3udd68syZWrn7SMccYICcoVrp0WpaPve+SjuWK1sRQIplOkOQAE9Ft3VaLTbZuWod0Sm0W1gDIGyqBUmfCmxTJGIHEXSOr/6xmSauP36ULP08/Ij+k4BtC7ffiKIwfDDqIjTQwY/geFc8uyEQW3YE/Emoz60R8+eovyemvZUEh5ArlG1nm4QmzpmIQopot1l9hJWtIbXarBhDy0XfhuvrjQ2z2SOWJhqhpZIFGhgL6/u47G50nGPViCRlDPhRaEzhVDazZac5WBB7voDKLUsr1ZmxkLoh71oVINqeHdVy1G/HrflFjT9WOpiHIGPnYMN8O4qJes1FJVLWMeRwn8yofjZL7e/N4dtP/iYKX/JQS+R0xIIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(110136005)(4326008)(70206006)(6636002)(70586007)(478600001)(86362001)(54906003)(6666004)(41300700001)(7696005)(316002)(5660300002)(8936002)(8676002)(44832011)(1076003)(40460700003)(26005)(186003)(356005)(81166007)(82740400003)(40480700001)(2906002)(16526019)(36860700001)(36756003)(426003)(83380400001)(336012)(2616005)(66574015)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 19:07:07.5768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80885fb-6f02-4cd6-6a7c-08db5bc0e758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_disable_kcq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:497:6: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]
  497 |  int j;
      |      ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_disable_kgq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:528:6: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]
  528 |  int j;
      |      ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_enable_kgq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:630:12: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]
  630 |  int r, i, j;
      |

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2b4bf6c11ae4..a33d4bc34cee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -509,7 +509,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
 		kiq->pmf->kiq_unmap_queues(kiq_ring,
-					   &adev->gfx.compute_ring[i],
+					   &adev->gfx.compute_ring[j],
 					   RESET_QUEUES, 0, 0);
 	}
 
@@ -541,7 +541,7 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			j = i + xcc_id * adev->gfx.num_gfx_rings;
 			kiq->pmf->kiq_unmap_queues(kiq_ring,
-						   &adev->gfx.gfx_ring[i],
+						   &adev->gfx.gfx_ring[j],
 						   PREEMPT_QUEUES, 0, 0);
 		}
 	}
@@ -648,7 +648,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			j = i + xcc_id * adev->gfx.num_gfx_rings;
 			kiq->pmf->kiq_map_queues(kiq_ring,
-						 &adev->gfx.gfx_ring[i]);
+						 &adev->gfx.gfx_ring[j]);
 		}
 	}
 
-- 
2.25.1

