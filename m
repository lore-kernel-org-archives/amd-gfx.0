Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75933C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F098210EA44;
	Wed, 26 Apr 2023 21:22:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A85510EA37
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJsdJ3XS63ED7nUiV+Kq/HNbD+ddZVOeGLkiGRnUm8TT3g47Eiuxg1wcdtiDixSKA+7Q2PS+BqEHN2CUwM8c921nfPXEzJPzKRoFfriPSq4U41AkGaqDzNudCzQvzjkpZR5Ltq2F3NnMG58sDDy67Eaj41Vs+RN3jKQCJJWFTXBBcdfPKQr6jItk854PUtKc0vtQWSIjHbB7k2tGC3s38laB2NX+8Ff8n5KnJIhMxXHQXUsuwU0zmM1pZJaXG9zoXIvjUWO2VZmOOAfQ4aHRwv67UqFxJRyuZGtlvj1tFHyUkiM3XbIy4oWXuiEUjsdWGfe1hvdyOXlS7GYNYWktZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKHvto1WDKy0m468nznH40F1Vf6pzoXABbm/uAhRNm4=;
 b=CERbH4M26Fhq60GPdXfHnLre+OxYVBwj1wOSZQP+UoYUM/n4lomJ2XOdxhLBxcTyoUJFnL/1W+VPlHPmzFzyLE5Z39kn2b5LfinvAm+hvvL1+TMy0l55OCnX65AAx1C9a37TagDUOwDtkS6suVKoJTBCDgjXgsEDqJqH/HbFnkSczvHc2myHcvlU0L9IJ2MjfzWW14M06GoaQaSNVZURu3iGDxJItUKDW85ZfJ4a1Oe2iNwWaFKtJbTi31B6SKF8GOrONrDwUKIagwJnmmSqKjSSIQ9rFFhbFtXNqxZLKZobWRbYC6A+sK3ATUg+KRzUGB5JBKP52sWrRIF2YkEhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKHvto1WDKy0m468nznH40F1Vf6pzoXABbm/uAhRNm4=;
 b=pnljsbfF0GiLhKI9wFXSl5wHxuoJTV5oGTvRMG7JLsTX69D8s4ExS12KUHd/PMEEMPQ1cURXTyHcChCSvpoUvx15g1MVO9Lc9n2R6uCJ8+SLAOaDU4O1VPR9L25z8AF1YWHGwQPbLD8i+g+ehpO4EQE9gmexQkTpdN/1JIQIWrQ=
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 21:22:05 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::9a) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu/gfx11: always restore kcq/kgq MQDs
Date: Wed, 26 Apr 2023 17:21:42 -0400
Message-ID: <20230426212143.7696-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 249d74dd-b06a-48f4-89f0-08db469c48f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83xuFBkZ1b7RyM5rLRDFMecXauc7C4dYCLJITLj7Da9m4HtMbM1iydMjsWZHOCG3y496ue5tt5M97OdSk02+1irxtbsFo7sAOPjvEiLuOMPNxa/S9+sO1D34RF+vOCVdFT/gdFTNfLZMcAnw+KyRYhAuwwwcZLT45oKUXoJ7iDmEt4ZLS2OhuZgh/pj+or5HS9DedcMJ5vs/r1lKtJO7xFqquOBf+G5sTOWBimTov7kY8xTtl8hZI5q7vqVmgV3Loz0Ab8TX5D5Ekq+p7qkaXkmNav8KowoRPsh14UTSQnry9Z7GWkj5kK68xGKq3P+rg5ERJUMFi2ulTWcUv0CGXoNRx9jNvXzGj24EuWj7wc48GtIykdW7beZhfBMAF5KQYQbkDBL2cTAUqKYGY6eREkDui9+hM05Aw+Mi42LSuWMw7zdk8sGKimtrTWcuX2+w3srJDEhEX8NI3a4dGDOS4OcvOI8XZSgLHcgwl+sl8WCQhD+emtXPOU9SNzNoUemqQa5jVc4fSumfVNu6nX3QvVNGICmxlxAcUj6vM+HrI3tfYHwAif8/I+Z9P1/t1UDipCDVELDoBkJwWjgA7mTk5PoMHH7MRi11CAUVUnZq7Mesu9BsFb3h+/oLoBSSCCoqHFozKKkmQfvIqIJlRSI0f6bYDfCTICmJW82V/73I5WAwsFB03ijTb5XpE9btDl4Fd8ctqCtSoKFaBOQgAFuRUafO3mOMC47ZdxnhKQPtqkI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(336012)(426003)(16526019)(26005)(1076003)(36860700001)(186003)(86362001)(2616005)(5660300002)(47076005)(83380400001)(82310400005)(7696005)(6666004)(40460700003)(36756003)(8936002)(8676002)(41300700001)(316002)(82740400003)(356005)(81166007)(2906002)(70586007)(70206006)(4326008)(6916009)(478600001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:05.5038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d74dd-b06a-48f4-89f0-08db469c48f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 256014a8c824..d420996920ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3695,15 +3695,16 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) {
-		/* reset mqd with the backup copy */
+	} else {
+		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
-		/* reset the ring */
-		ring->wptr = 0;
-		*ring->wptr_cpu_addr = 0;
-		amdgpu_ring_clear_ring(ring);
-	} else {
+
+		if (amdgpu_in_reset(adev)) {
+			/* reset the ring */
+			ring->wptr = 0;
+			*ring->wptr_cpu_addr = 0;
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -4043,16 +4044,16 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 
-		/* reset ring buffer */
-		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
-		amdgpu_ring_clear_ring(ring);
-	} else {
+		if (amdgpu_in_reset(adev)) {
+			/* reset ring buffer */
+			ring->wptr = 0;
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.40.0

