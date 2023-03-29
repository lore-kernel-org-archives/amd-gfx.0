Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A08C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D49510EC59;
	Wed, 29 Mar 2023 20:26:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0F010EC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFPmvX4IEj0zCZ0eTZLKQ+WUIdzxbu08PY2KhK1H2yWRaa9jq8afPVTF3z+Vb+zNCeTE4Lt8Xl9EylRmOX4/98kawt2LFZaipAoZsGVtdUprG0GWyZKnJJQAX7+2ACycHJBEQ+m3ASeQ0qH57A+rv3n35vXkIr/3VQZXRilbQVmciRqwNaX4ffr8yjCe6ZIG5kS4Vz321nqNxTlUFG1i69+2Def/Mf+g+VDTbhGfd2RygpusOMFsUhg7T8xAIIcNjGBY2bqMmHfNHE04qZQljGGWI9lRIMASzNkglFx0pVQZP1nyXiLlEkKgSOQdS+WHuDcNerfjO+SH2JgCRldt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/9sWEjgjhaJNjyYOB6w39AzdCy4IuHPVSwusWnDlbQ=;
 b=JhHuGSAbLRXLJPDds2pfVfXgIngnzpBqcpcYk1gKfLMwpW9GkVGIAlIcEkAk0SkrMFWyHNTDCHv2KTpXhohT0SKHswWzU3Xn0lKtWn9UbT44q0m5GInwOWdih/pvhMmhy/ctpC1+kXiYD6fvWe2b+1i+6eiUvD/UVtyNcEZ+1MGjNwXfQOexiO3KMgOktkHtHxNKFyropzzcO7UUrKJMf5o9qEuJnN/BxQUml9Jpgw371luS+p/K/5KssobU3z/AJq8xfO3zLW0wBFnNtYZF+1ZZdRYmDLnrANjBs2iJOaAE+naVk19lYGczcM1DW4MYNdodRHlNfyMEXIG2RQBmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/9sWEjgjhaJNjyYOB6w39AzdCy4IuHPVSwusWnDlbQ=;
 b=MgWHTqRyrEuvvdUgLjtTtGnKvJDNx3AKzHEk45ZbU0/mqfzRJKTAhZ9Ejgzc0uNlP3vfgrl0Plkde+g5m8zR0KihvxG6tO/bKkKtAK4QqZFNtHJSoO4Zb+CYGoXD6Nb3nI8DVPi4exyr+8hN+d0Tm1VTsn0H5NFWkFg1OtNAX6w=
Received: from DS7PR03CA0135.namprd03.prod.outlook.com (2603:10b6:5:3b4::20)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:26:04 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::97) by DS7PR03CA0135.outlook.office365.com
 (2603:10b6:5:3b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amdgpu: do some register access cleanup in nbio v7_9
Date: Wed, 29 Mar 2023 16:25:39 -0400
Message-ID: <20230329202548.1983334-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e271e67-78e6-450d-8f1b-08db3093d1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0UUezS6HO+oZ3lgIHNDnlc7Q86uQDhajKSBQK3U29d30akqOtTAS10DPzvdoIxDkqfLCNVGHghGIBmbf7QALkgI5EJJiscb1wrnJGUuJJKwTpQtOL+oUVM553NSQ6iTeNmWse2s2QNSLF3M6e5LEKbMBcPw2QaIgw9Z9bybh+3RklsnacbUyUTAyE+QYnV6BvL555Fncl7SJOUmEXvzMF6F2xVnYWS7lW5GxBbe+lehSmujmywn+8QD+W34Rg7A+vk5teeMWyHytU6SbeT8W78VpRiUDMtomFZZFyyB5kyd2r3BEZa1tFz4zacUgVAiQOCZlFw4paoQ5uR2zsEUUghY/W2McBy6Gemo+igJsiz+qraAsu+b+K8KDSl/Kgg1zwO/C/jTt4L3DkFLNU1VhqdVOGz8MlG2Qen9upuE/R4pvnG9uZzhvcJd445yygfUXlGKLIM5ejvc1QprwHJd2Fkee7wbl6d70YvKPWXWPpO/LADnNSHor3o3yppWAzT7I5lIvHjkXvvB0zgsyOkt/vhEyurMtCqNQ6qqxJ/qiSbYDRt4BuqYiFRVoRn5wZa70V/byQbZImt90kLOqV4/6+xJY83dwMrkhL8q6B9c0H4GRb4kWuU7NonOpRe+02+GIdChn+hZAiEjqr15L1jJNIMCTPnA4+mEf/cIwpqVPhT9UVNivKdJB8DymL+r8Av7Ti10XtxhnNPAhriZVCivuIFfnPO3o0vL9oqqNgYtL2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(356005)(6666004)(82740400003)(81166007)(26005)(336012)(2616005)(47076005)(36860700001)(16526019)(186003)(426003)(2906002)(5660300002)(8936002)(40460700003)(36756003)(478600001)(82310400005)(54906003)(316002)(7696005)(41300700001)(86362001)(4326008)(8676002)(70586007)(70206006)(6916009)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:03.9331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e271e67-78e6-450d-8f1b-08db3093d1bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Use WREG_SOC15x() instead of WREG32(SOC15_REG_OFFSET())

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 172f7f6807fa..301d26da3716 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -98,7 +98,7 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 
 	switch (dev_inst % adev->sdma.num_inst_per_aid) {
 	case 0:
-		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1) +
+		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1,
 			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
@@ -118,7 +118,7 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 			doorbell_ctrl);
 		break;
 	case 1:
-		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2) +
+		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2,
 			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
@@ -138,7 +138,7 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 			doorbell_ctrl);
 		break;
 	case 2:
-		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3) +
+		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3,
 			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
@@ -157,7 +157,7 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 			doorbell_ctrl);
 		break;
 	case 3:
-		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4) +
+		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4,
 			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
@@ -219,7 +219,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
 
-		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17) +
+		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17,
 					aid_id, doorbell_range);
 		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL) * 4
 				+ AMDGPU_SMN_TARGET_AID(aid_id)
@@ -233,7 +233,8 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_RANGE_SIZE, 0);
 
-		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17, doorbell_range);
+		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17,
+					aid_id, doorbell_range);
 		WREG32(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL),
 						doorbell_ctrl);
 	}
-- 
2.39.2

