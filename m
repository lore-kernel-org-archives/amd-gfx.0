Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F30C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 03:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC2410E525;
	Thu, 17 Nov 2022 03:01:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB6710E525
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 03:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoLJ38ADmVjOU/F9QswcVKAAwmCcYeaYajecsAZQBLQgMQe64JvWiKBj2oJN5/nlWOYMtr+K2akSXsQ6qzy6+jdtj4ss//hKvDXdRkc4vo+xov9VkB5W5d7ci6hp69a6CQ74z0boLBD9gJHHikU+RiuF6N/oOUwkM14N5BiI/1x0KZpX7yzAfKhq5T7tD2fvdlbHSPtHozsPNRX6TXaLl+hA1Q9MjdU9lL1btmkWp6f14TkfNHgvBzn/uWhywVNodVGUZfS5z0saOdDjNmatpoKeevXcenG5DpXk8elFJxCSexfPJJjBASPWgYmApUuY76Bk1sC8KRL3DtFoP7QW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdXMI/7o7viIsXmwjq9tgvg4PNBDxsD1rk7uEygl8sE=;
 b=eQIXmc+hrRQibSMSiwzQSKw1KkFwm08d7z0VfuJoGb3n58V8g3AU3BXCw1wJBSRD5Oo2q3D93zfWOpLtnYS76XkpXRlnmIg4BQEvx4hYOylt3vVmKSE4ddELrBNdBN9avOMYnFQN0q5wLNYed8F/AlMQEcY7np8CNWyCLeu9/b3ivkbXoQilF83FroguLmztnDAtLBEHGpTLZYeCUdsM/JLq1yxdktxsG6QQ+HqdXPVg4eD1s36+WDtBMgbDOZqp8hUt97hDPbJUHAgbIGrh7s1SIkZun1ASX6DQbrFAxZgVEhi7GCL8XJqnI8cemjZ9knZpO4jGWC0bTpyLs0OggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdXMI/7o7viIsXmwjq9tgvg4PNBDxsD1rk7uEygl8sE=;
 b=Ql+vR7YhRb/KHabBVNCzxcyiRUOWtKAXnLyUgofUiIzfHKh7SkUsGOgQudFYvbvF4rol1Kx/u8eU4qv+EEYpLKtzMi8uYZLlHD27in+Npwdg5iV3d8BT+OlMWvzjxQ1EKgannMqxj60o20Su91XiMC+ZqVQEPgb8wPMX1LAFVqw=
Received: from DM6PR07CA0059.namprd07.prod.outlook.com (2603:10b6:5:74::36) by
 LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 03:01:27 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::21) by DM6PR07CA0059.outlook.office365.com
 (2603:10b6:5:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Thu, 17 Nov 2022 03:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 03:01:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 21:01:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 19:00:52 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 16 Nov 2022 21:00:50 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Reivew 1/1] drm/amdgpu: fix use-after-free during gpu recovery
Date: Thu, 17 Nov 2022 11:00:48 +0800
Message-ID: <20221117030048.21200-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf6b3c8-d99d-4b35-bd97-08dac84804a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVf9i0zoYOzFbIABGZGSJYs+ylwo8M3YGjC1qUOooJAAk0ok0XworX7NY8cVTAHJ60agMRTJZx+KWH1bUXpXQmr0bfpsBJguR2gAXNOYmitl9NfKP2A5u93D14QBFebXZ83q8xVHlW5XCtCjQH7c1e+GKhwk7sCm1ZU5ZbTFxAVgaZDmUJfyyD25rGCTeEvZgT9QA72ONtaO23PVN8FAYmnYcmJu3Rt3RDib3nLN6CLjRgVy8qO9BoTZJL7dk1PMLpm9K0Gfzm9uXruLWlAd/0zyvT7jNiRei1CkcPsiTdOc6HN+g/kG8bhgc/3BtnhZ9LddfBVlOW/CU3IkZ581jJJN4yKSv641l5yAAbZx+pCL6s6nQLQBrS2mtvGwh8yqjhoynwYTPzXuL2U2U/gnqS/3Ofch2exZgk2L/UuRVlkr/Bi+oM9W2Z+d6VnvYwgHSsB+vFUt9Kbd2dny0QfkmySEZbr/+EZmxPQu/7mhmI0lg2qModXNE/AxB1BxeAyzUAI+sBXPm9wmoZIZitt6BMBv+Aw+MzNnu4uPjT/BiSMsFTaxCzlDh5paA9HfMhp1POyaC7tUPVV+504yhtj+huwyhL8WDzaw84Av3suu8Xm45ez6maT5JmisWCdsVL+e89MqMnCy1BD8l6CnP43tdFV31JkH6JiNx+hYy8SWhSPWGa18+U7r2/BJYilsm+35i/2oboA8qQLaXr1SIeqSw9jY8mtXUuICxgR3OCCXNTaGQklDputMY1U13vmXfqRP0U/pOMn/Rgal19QciQ/JjeHX7ZFwo0h+zbIEAYMatiI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(426003)(47076005)(336012)(8936002)(82310400005)(5660300002)(2616005)(1076003)(186003)(41300700001)(83380400001)(36756003)(316002)(26005)(36860700001)(4326008)(7696005)(356005)(478600001)(70206006)(81166007)(70586007)(54906003)(40460700003)(40480700001)(2906002)(82740400003)(8676002)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 03:01:26.6933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf6b3c8-d99d-4b35-bd97-08dac84804a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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
Cc: YuBiao.Wang@amd.com, andrey.grodzovsky@amd.com,
 "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
    [  754.862560] refcount_t: underflow; use-after-free.
    [  754.862898] Call Trace:
    [  754.862903]  <TASK>
    [  754.862913]  amdgpu_job_free_cb+0xc2/0xe1 [amdgpu]
    [  754.863543]  drm_sched_main.cold+0x34/0x39 [amd_sched]

[How]
    The fw_fence may be not init, check whether dma_fence_init
    is performed before job free

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8771df97d590..ddee6a6b133d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -169,7 +169,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
 
-	dma_fence_put(&job->hw_fence);
+	/* only put the hw fence if has embedded fence */
+	if (!job->hw_fence.ops)
+		kfree(job);
+	else
+		dma_fence_put(&job->hw_fence);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
-- 
2.17.1

