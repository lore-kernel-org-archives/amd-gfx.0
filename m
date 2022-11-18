Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5946CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 09:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEB010E1B7;
	Fri, 18 Nov 2022 09:52:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E2610E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 09:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD7JHDF3wZKrQGnIpdexKy8Zf83nQHxMf2I74/DTb9swBCEj4MNZENp4idAU+ol24h84WODdwR+ry2avd9wb5lCgOhoXyFaWJSv4e2uPffMEPu1z/QUFTwun/l2hzWz/YO6/ndokjGFC/++cXzCicPuvBhW/G+sPaVC0ROvSUM8y58scIVGtWjcCSRqWvPBaOoyR7XCEGDKo9hUCN2Rg2v51celLvZos0sQV/4NyutNLQJu6xMhje8Sh3YJIaH8V6SJnFkO+qPmEv3B8YFlyfYIXPebCgZHftPsdIEOXpQd1DV1xIEDJJ1yBi4hvX+monatGANMQcD04ltJXvcJ0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T52vpY74L68A43qzY4LKptobkUPXc8fMEY/69fzJW7U=;
 b=bybGHEIcDT/K5ZK36y1J74fjs3aXBF7sPfSBY+Oqkt+ADH5kdXpvXvqqwtp64WMJ7Nf3Tu02Il6O4n8EShghVpJ0uUz+/tA3JgTSzF9cs4mAQM4IenOOn1+KGOLxFuqkCGuFIB9as2kh4jtC4CeNc8zZaB8Z9FYuu0doK7K0ZNNj/bq/utImsXSB7HlX+vtgXQf7GO8jf8QG//7IuwkhiQQFAGmVH5Z8Rm9TfO8M6fK2TAhS+UksTlYCqmp/X1/+Ass9fxRen3d7qiRA4JblLsecekGV8TEJ8S2yS88HD5YvUpNK9xI7x8kGTI7O7REA1ed+vDVRqidMDbkwNRuj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T52vpY74L68A43qzY4LKptobkUPXc8fMEY/69fzJW7U=;
 b=kJgbpjMklPEu/QaYJ55lkwW5og7AMlGo7wHSrOhkfCaI9VD9XB6O1sDkGo3mtD5affXViqhwv2xZ5/fTa1d7EPLFeJQYzgja87m14TQp9iQI+V0Nvju7azehZlMbAoL/GVDE4j9dqL8NqBYb+iLPO1QYUq30gByIQNOQLdX/omA=
Received: from DM6PR11CA0008.namprd11.prod.outlook.com (2603:10b6:5:190::21)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 09:52:03 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f2) by DM6PR11CA0008.outlook.office365.com
 (2603:10b6:5:190::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 09:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 09:52:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 03:52:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 03:52:02 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 18 Nov 2022 03:52:01 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix for suspend/resume kiq fence fallback under
 sriov
Date: Fri, 18 Nov 2022 17:51:56 +0800
Message-ID: <20221118095156.243889-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 232f4049-1877-4442-2e5f-08dac94a8bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcV0wqZPiSqyfBhbN+X0VuNpsoAIECndyr9s39G/AN+ZTZ60usDg/dTY0NjPOH3Yyi1o4nG3vUGNRXKJTapANmsxbAdCxXSBr2ZJ3fnF1Q8ySMDD0S727RszQqUQQAjJ+1UwPKBXIDodgUUVki5f1Yg/11jSqPqLWSFZ2MtaiZGsyKfm8aVntTj50hSDK3//zOkPUrbjRdW2MQnj6fORQb3VnKJAaGqpxj/PeKZdDH3/yrUfAMJ/vOuU+bANs30T/bapeqLxdj+8dK/vbs/caq05qQtvoBrMH3dhlJhckQekdt5UndMy984CMkFIaUenhq85pt5Bb9ihL0ZfrzKhKYIo+9lb1+jydZEYVsdN4EbiWZ6wFgWeU3MlQ+StBDr7suaKFG10L6lZts9+KU11NqH5v2mXB2HAx+fGC4ry43Q6c0lrmaGCt/9rtSMQW+8LW8BXX6VB68fAFF3nINhPkgfvMywy+IZ5+0Bo6d3dbVPIdAPHYgkKfe2f6KJdnUTHG0iI8A1+jcuNXJacxs8h/NgSUYw8BhsjiG7lJ4E3SrAc84CtNxTgOKzjp5AbOVs1paLSL8PpS27XGXrCfWOJBnIhyxVqHJ86pg61yEfsLYG+EtWw7kjmpPSRrL3HPAGbRBg3OkGq5iaDjbzhQFlbeLtFBInVonD9QLjD0hxEOxaeFZ7NxEY+kFiN/vQ3tL4su7rPIFArxGhj3W0oth8cobMoV1YL39ZvAzelEmUyd38=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(478600001)(47076005)(316002)(70586007)(70206006)(6666004)(6916009)(26005)(8676002)(41300700001)(4326008)(8936002)(1076003)(2616005)(186003)(5660300002)(426003)(336012)(2906002)(83380400001)(44832011)(36860700001)(40480700001)(82310400005)(86362001)(36756003)(40460700003)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 09:52:03.6004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232f4049-1877-4442-2e5f-08dac94a8bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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
Cc: Shikang Fan <shikang.fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- in device_resume, sriov configure interrupt should be in full access,
  so release_full_gpu should be done after kfd_resume.
- remove the previous workaround solution for sriov.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d5d5d49cfab..22723b4492a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4180,21 +4180,15 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 
 	r = amdgpu_device_ip_resume(adev);
 
-	/* no matter what r is, always need to properly release full GPU */
-	if (amdgpu_sriov_vf(adev)) {
-		amdgpu_virt_init_data_exchange(adev);
-		amdgpu_virt_release_full_gpu(adev, true);
-	}
-
 	if (r) {
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
-		return r;
+		goto exit;
 	}
 	amdgpu_fence_driver_hw_init(adev);
 
 	r = amdgpu_device_ip_late_init(adev);
 	if (r)
-		return r;
+		goto exit;
 
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
@@ -4202,12 +4196,19 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
-			return r;
+			goto exit;
+	}
+
+exit:
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_release_full_gpu(adev, true);
 	}
 
+	if (r)
+		return r;
+
 	/* Make sure IB tests flushed */
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_irq_gpu_reset_resume_helper(adev);
 	flush_delayed_work(&adev->delayed_init_work);
 
 	if (adev->in_s0ix) {
-- 
2.25.1

