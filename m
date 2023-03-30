Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87B3C77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4655210EFCD;
	Thu, 30 Mar 2023 19:27:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0741510EFB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyMgStjF8MFoWChDLWKW78B/qWsOwAZxI+kGeQEO5iG+t6TRZoDEtj66ArD4Cq+3MjV6lk5GcUJ75UrHK7KGSPij5oaClM+ANiKXCv3JxYJSEBFcbeBf3aKxk5Uu/cjahX60CwZRwJWir9Jo2TqDVsal84R8UHykjW1fydlm2pdGJ3eiXgbmPNLjqDJcTqRfcEyKDelyE9/cjKd4YTXD5/3qdMlshD5r5ujCDRKMEKIIi3bGFmHg0Jjr/Uhg67lnhQf8PRomQClJniBRmfrFVH6B1PS8kiwevwqzePW43tYA+2O8IZ4beYqq8nDGrbIB6UEC1yGb+ZdGv/b+V5Ly0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNpOgyes1p44IroEvTfPVz4hMKPFIt5KHztC7/JUxlc=;
 b=JRoP3HCdjpACHQeAOZyfG3Hdin+PTd7sAlEDxR0/yHpFVcy/IgRnDsMYvos3JPd0Qe7Ftgnch+OwyDwcZ2ConK+bZsi2m9cw5Z73EqJq1boZ6Bx6doA1pDUGAnYhCVPbqT/Si7R9ytkVdbavBrFON6/wbPXuz6osdWhRpLVsV2tW/ky8F3Q1XRttGenyhF9LGNJaJg2MQwmVTLNMvpEB5y/DSkA6+IdpP3ElCBBEQO2OzGWRMJhiE7tpAg/tSW/ipF7kiH9wLxEwHYndIO6qnasBzUxIaVvY7quR2W7FzEsOq+8x8CLFyZqTlCLJCOjolF3sW8RqKSuMKzS5KEAU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNpOgyes1p44IroEvTfPVz4hMKPFIt5KHztC7/JUxlc=;
 b=iE2K7DLqOY6JMCvtEY/4anBzwswgAMaizJk8U0b5dRp5phBk4Q41aTdI/UL4ZFPyWegd/SySkgKggwN6KU9GzYxLWGJi6fsqn/bKnuaOPrdq5ExMFpFml9gqf4O7flKBlJxRlGGuPRCG/TCxGOlpcmE/4yziwJFeX8clx/5Vxmc=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:27:14 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d3) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amdgpu: more GPU page fault info for GC v9.4.3
Date: Thu, 30 Mar 2023 15:26:55 -0400
Message-ID: <20230330192657.1134433-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 76039648-969b-491f-91c9-08db3154c466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE7bKQYs7Io4NNM7dDtSnPoXm16Ak2+tC+93pa/Z9lLwEMVPBkXd1OrpiyAw3f+ICGflIh8t2AGB41jwCuA+zOZg9EZPY67VG3wa3XfoLOBbq//8LEtSEuSjdSVH3xXdtBR6bVUGPXtOSCzklWo6EsoZygDB7Zg01PG9UKuS+GdtlSxB4OvXJwAUEIfUXYCo+jVvsFP32yLxOWQxyeiXvZdYS7mN/ZBT48q2hBULwVLBnVmBpuRvnaicWe+Rwv0NIilMzaFOqdTx1g0xDKEz7syEPCHdUs5/REfWzJips9T4ctpz9WQAKVvrJ+Z0opjz/vaMOrSZR+eos3QmXU8mAUIZsNVp5lIhEYf/TfhdZUECCweCe8H/p9ibpkpuZu0IltCzRltfcou+zJGtNPIvX4ehmiets7g8xGQC0fEgyvJgsHBj2DpRKEgrd3ssg7dAJF7+xni3P9QkpW9KcgmxUNnd4yvnGi03/QPtltoHzzmD5qr40tPsF6YLWhwbFUu0WiZkxuTDzwSQi0jXIhePu2gljMS6jPpBbBvO/DA0T1TNW9cJ4KkGW6pmXl75OwUrDH4zbJ+nkeA37TSDayhWJ8IYuV9TnEGciOZHgJiz8I30FC6ZGm8VjNfXJLoS6b91W91GLahKpQYiGG9mwMxFKKl6/F+3XIFYePwLgse7nQjI1Xq03E7EuCdfFVqcT944NWjksvfx6byC596FbD37+uc6oODz5pSXV9PhKvMeM9U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(4326008)(36756003)(8676002)(70206006)(356005)(2906002)(36860700001)(6916009)(41300700001)(5660300002)(81166007)(82740400003)(8936002)(40480700001)(86362001)(70586007)(82310400005)(316002)(186003)(26005)(16526019)(1076003)(6666004)(478600001)(83380400001)(54906003)(2616005)(47076005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:14.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76039648-969b-491f-91c9-08db3154c466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Output IH cookie node_id and translate it to the corresponding AID id
and XCC id, to help debug the GPU page fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d819b544b043..016adcfe8c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -555,7 +555,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	const char *mmhub_cid;
 	const char *hub_name;
 	u64 addr;
-	uint32_t node_id = 0;
+	uint32_t node_id;
+
+	node_id = (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) ? entry->node_id : 0;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
@@ -568,8 +570,6 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
 	} else {
 		hub_name = "gfxhub0";
-		node_id = (adev->ip_versions[GC_HWIP][0] ==
-			   IP_VERSION(9, 4, 3)) ? entry->node_id : 0;
 		hub = &adev->vmhub[node_id/2];
 	}
 
@@ -616,6 +616,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
+			node_id, node_id % 4 == 3 ? "RSV" : "AID", node_id / 4,
+			node_id % 4 == 1 ? ".XCD0" : node_id % 4 == 2 ? ".XCD1" : "");
+
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-- 
2.39.2

