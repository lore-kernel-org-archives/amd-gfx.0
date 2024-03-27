Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0503C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 08:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F52010F919;
	Wed, 27 Mar 2024 08:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQBRwV/l";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E146510F91C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 08:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyUTZBQapoGc2sofPbaIYa7fkt/3NR9uRVWf9iYJnWt7dymDjzpeLt1gX+Jb5EnjCz+HhY4CcrHQdnLYFpq1tZJitY0r0gu4lG3EpL9yDHUqmkEng91S/X8fHQle248AwQDvLZeFmLH2ITPVz8Qfx77IFQXzYIrZyYSm0y+KF/TUR47y/R2M5kGw2525C1zFzLTEpUd5ymd+Q/JE8KMYz/AzkJgvlGN+SP1ChrnXZarmM9ezV24MBlnHr3CTRIqqK6wINp6E8+J34E4Lhyul5IFXxnQ+wsxm1ydi6TVVhDVQyj6oFAHCm9X3+waDavXjiZ0RWgDHPGLiMS18vNr9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aY83yzXbqK7Kuj4WIg9HeWaxbeBD4J2w0DN9RmfJSM=;
 b=EQHGw8GPmhfepwT108np5BEoOlqn0f7nDztmnXmQOKIdZqEj2JkNTfQ88m7moeiZjCfNegA1OQDrquuYCwNoDtMf8z84Cfg8+QhKPcAeRGkbHrMU3gkQlVRNhSa67RBgLwWA9u3c92k/arnObIxfJLCgB6qBPwY6+hoNaSAP3opJnD/1co4oAcYs/0izB0AP5ogH1dmN8t2VTPsWD6br3sYko5+QBrYJEzgiKQDo+2doahmsvFq3dVwEcUrnRtktvtkdld/i2Yxdlqo2vrDg2OuBgigYxdu4cidstkP0vTJuiMgIQJN+URfAOZQRPcZmaXM52h7MNFob/K/rJc3fuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aY83yzXbqK7Kuj4WIg9HeWaxbeBD4J2w0DN9RmfJSM=;
 b=uQBRwV/lQ5M45lTjnKTkrNVbZNqGPu5dOoqEmzT3fXbAUm091myn3kWRzcQDmknpHvcxClGQoTm2DupJx6bNBVKhAeI80zTrziqUzBMX73FsHOgUkb1l0nXFs/ZpkWkaVBCQq0RFdFK6oVUe2mizQzu2fq1ncmY3s5dQJp6FQgA=
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 08:03:28 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::f) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14 via Frontend
 Transport; Wed, 27 Mar 2024 08:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 08:03:27 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 03:03:25 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu/pm: Check AMDGPU_RUNPM_BAMACO when setting
 baco state
Date: Wed, 27 Mar 2024 16:02:59 +0800
Message-ID: <20240327080259.2947891-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327080259.2947891-1-Jun.Ma2@amd.com>
References: <20240327080259.2947891-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6249fe-d8af-4c1e-d494-08dc4e34627b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPIsnmmDbg01oOLtcAzoMbCqAIo3EUvnep5fQ3VJ5gM8qGHQBi7toLhvBCF3kbXwov0IvmkmOAUU7JVZBrB5XURDyX/RkwdNCmnLH6fxPHF+2EPPXlSyBbsMrZdsCIVEm5rwFV6yWbMtUQBxNZO40HgpAEz1zGf8iFR+ntyALkuSEurU8tJ17TisnZRteA3thso9ZcvrnNbHRP4hPdZ4p2kjkmqOlmMdzjTg4NShpGh9QQSroB0DUBTlAUOHBJAGlklz2U7ZFAg0GbU8pouWS6XRzCWCoi/+6i5gPyFRZHwrVq4hIp5F265rFLR4kSYH3pC8JPwduLZeNBZpSbSD1k4N6Kw1AJ8Kj5wzQAmPWeL2XRMK9CHJvjXiSbyAcpU9eH22/m3qE3+pGxPPdKn8lRC7I+4kmwZ6Pg483Wu7Wi1WWYV+VU7NgFiTlwsBpYNbExkfq6GtQ47eagBzNS/JxPkiKoG1ob3zATIDYkhfrZq0SZLgneqpVOK29LDZJaopRavjUYfn5Jc3gn68VjG0L3c8h5u3tsPT+zP1OMWYJLj92i1+pNAUeT8PraojcCrkMDZEFPFM0dxbRLxbtfc8O2ulkUBIWDR1YrgOJXG+w8ASQ3fZ2IZdhJ2+zirQmOqDX3FgmwcVtA7s3HBZTtB+SmODnAY74QXB0aVxsFBevl+ts5yzXwMFsL9rEcUSRVjpqI6rGs6jUdU41gkTI6sBnk0q/ORaGE1nYuaawB18BL1qKDTjusIChabloIR7n4SP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:03:27.6535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6249fe-d8af-4c1e-d494-08dc4e34627b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check AMDGPU_RUNPM_BAMACO intead of amdgpu_runtime_pm
when setting baco state.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d0c6dad24458..a8046aaca936 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1607,7 +1607,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		case IP_VERSION(11, 0, 11):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
-			if (amdgpu_runtime_pm == 2)
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_EnterBaco,
 								      D3HOT_BAMACO_SEQUENCE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a65877eeaa8d..8247eeab3bd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2247,7 +2247,7 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
@@ -2292,13 +2292,12 @@ int smu_v13_0_baco_is_support(struct smu_context *smu)
 
 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+				(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	} else {
 		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index cc7cc2a6d871..39f130035ec8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1633,7 +1633,7 @@ int smu_v14_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      smu_baco->maco_support ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-- 
2.34.1

