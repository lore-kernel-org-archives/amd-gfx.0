Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EF9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 06:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449B410EB83;
	Fri, 30 Sep 2022 06:17:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CBD10EB83
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 06:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSvO8/jYBuduxMZr/ayNye0u0FwLZnhO4cBcDQf2WsQYsVmzlWLPFEHVpKIHFYh20ANO0+MNr1/2GGmRkwSYL70ZCmtbbAVb5Vggtc3RWEn3UbTPpZE8dLbWiFgpuBuVnGknIIrwl3HfzWo5H7IDMJ75eVZItVuHfETTcl7guwLeUrdu+3RJ9atH1yAHtU+9hcMf3zpbIF9Qwy/QHISQ0K/dpJmv5mFZ5R9Jr+L3chYpP0M57kXRVRwK6kd7GzG53SCS2OmKWxgqJEkBYGURWrWJN05yqjaBFmdh66ll4439m1TS/XTUr/10iNuwR3WflJ1FUahDlfczIf7+n1YIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w43C3RR/cwK3KT1ClT6IdkEaJRLq0fGs4vGUuEwqT4=;
 b=exmSseqdOnYijwu7GEsGUXJ2xlV7S4ePNuFBXtjrdClIkElUqa87nr6eI6de0/0TGEOLkjpZtef1mkQ6UeUaAdkbRP208O+eIpIaWDWYCEgo1Y0YpqCjSuTPos4hD8eCLOql0yGG//DR3MHJGV+EhoX7zOzlu/iheYlF7uEvHIJfFHg8XupM9IEIQEeeALL6WZ699K/y6SCeIObchp+KFd5+b1RnV+Gtpf016tP/lxp/J6p8UrDAxNEvmco/5Dpl/bZz9jGOz3lxBS4wn2+qe6p84H4XleTCOWlFaVt9Sv+8IBTSN/BFwMGxwp4NIZiCYz0ti1j76H3CO4RAYS57JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w43C3RR/cwK3KT1ClT6IdkEaJRLq0fGs4vGUuEwqT4=;
 b=pval3VJ7y8Zsu9RJIn+6RzCPUSiH7cvYTgw4/gNh6g/0T136mxv4m5D+jIdcQzgXbag/xYX63AYYDAnaBaQeVUCjeYqBGGwX96AaqcpIdKqyaESDCcO+Vd2I/QxQVOKrrm/dglwcUsT3i7PlePoarhiEc4Ev1KQi78gonzoDRrM=
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:16:55 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::ab) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Fri, 30 Sep 2022 06:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 06:16:54 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 30 Sep
 2022 01:16:51 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: correct RB_SIZE in SDMA0_QUEUE0_RB_CNTL
Date: Fri, 30 Sep 2022 14:16:33 +0800
Message-ID: <20220930061634.1531705-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|BN9PR12MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bda4a3-b5d5-4977-9117-08daa2ab5f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20SJQPK71ND+BqFTLch8cLDE+R/FOjtVZqncaChSLh5kYEPVZFG3GWw5PTan+IdS2xJOM6QAI+fjzT84WJsb16nB5I4rhUCPavkd3LDBELNX4lqxcRl5Z1jbJiyt8XlmK6S7s//YN8HNGgaTpfBGx6bkif00tjWwHCCMCTIthNALbgqg7VpI1kPlZ6H/oKUWNjLOOxqlPwfc9Hh3+vPHO+Tal9vxY1v23nry17+atBaSS2dgmrXUWvyu8zWij4fem7NiPQ5oG/u4jyBSYp9a+7IaK7eWgVPOyLtXF0A+UXrEiD/dT6HTJiGV3rp0iGTfYGLu/tEqCW0nxWdBvCgxXKWJCIDU8QcTdT1B3lpFdtjNH0Bm16Awsb6cJ5EQQ51Po5j3jPFwf6QVzERoxTkl4LTapINISx+vUGrwb/nDze46B4Vf7lwL33poUrG440D6BGEm/eqTlJk4qDfsDtu/nL4YqEdwc8Addp2fgRcV6oeEU4UCDLAI7IxQla8Uxylmavj8jVmfULArj3PDJemTtIIcPctcX45LcAPq0UgzFwQ8BImQdtLPGf4FhoYtu1OEh7jzdM8DLulXQuEyDiWiU8iYyTyiSvZQpIJmXeekkIQVMh7T1wP2uZUEw2VkfCbF1V+ayAEjlmzEAizY9XgXZbsVSrtzYZsuNYzAxnZIPYRR42fU8diUJwjEGemFcY1xFK7EwL3wRt2EvHU8YXuMnKgXY1uk1N/L7Na6XOLYJZAJ6S0EUTc6arFtol4iZLkrP2HTnuVDA81GrCKyYVylxmo4m4lC/zsOf9u/iEuNyGKF9JTN5jcc1JN8zK2v/W7X
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(356005)(40480700001)(81166007)(82310400005)(82740400003)(36860700001)(47076005)(478600001)(8676002)(26005)(2616005)(2906002)(186003)(426003)(40460700003)(16526019)(1076003)(336012)(4326008)(70586007)(8936002)(86362001)(70206006)(41300700001)(6666004)(54906003)(6916009)(316002)(7696005)(5660300002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 06:16:54.9946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bda4a3-b5d5-4977-9117-08daa2ab5f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com, ruiliji2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SDMA0_QUEUE0_RB_CNTL, queue size is 2^RB_SIZE, not 2^(RB_SIZE +1).

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index d3e2b6a599a4..03699a9ad3d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -329,7 +329,7 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	struct v10_sdma_mqd *m;
 
 	m = get_sdma_mqd(mqd);
-	m->sdmax_rlcx_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+	m->sdmax_rlcx_rb_cntl = order_base_2(q->queue_size / 4)
 		<< SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
 		q->vmid << SDMA0_RLC0_RB_CNTL__RB_VMID__SHIFT |
 		1 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 26b53b6d673e..451fcb9bb051 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -329,7 +329,7 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	struct v11_sdma_mqd *m;
 
 	m = get_sdma_mqd(mqd);
-	m->sdmax_rlcx_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+	m->sdmax_rlcx_rb_cntl = order_base_2(q->queue_size / 4)
 		<< SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		q->vmid << SDMA0_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
-- 
2.37.3

