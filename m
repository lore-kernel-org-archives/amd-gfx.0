Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A6AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744B610EAF0;
	Thu, 28 Apr 2022 21:30:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B1510E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXSAAW/Wpys6/HXm+UIWLM0NCWoGX8q10+V+G5jq+Z3b/Q+pVYz9zNb1syDhsHl0fPkxYZtqSjCXCDVtjRBb5GgTomLTRtVZnAohN26Scl7X0G19eq0bMB59G76bCB2IzVg71NXDxcjKI3eu8NCRxri5V/lKVItP4jjX7QK+TwF8b11qzVQXh8TlzADNmIrWVd5InTw+uBS5VK1QqKIwxFVNgJPz59sbg4g+4yvLZBnTuo+u4x/OCTgQU3hUONCxux0WRvteZVOB8O27ilA0yfUYnvcusflhu54XQQ/UF+EgeFigC4YbuC/xlv+uIT3dp8sXijitcZDBkhWSmfrCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zBa04bOMFENM9jrEa+zc5qraKpov0yQMTCbJvYcSN8=;
 b=IX8amu1JjgApZx1BcULqyZ1dcioXNcW56/E7iia7TscNNz5+RbZZRvdueYOHobeo74NaVDzKSUu8WhDNV0seTwkgybxCLl/zpypS1JoH2fdE+w3QVEts3bv5PiYilokZ7uhcrc2hZNqZFZ+5C5Yiu9Tc++omK8n6iLD7YfH7qQ6slaWUVxNbiM8BQMcpXXbceNWSxgCQBcWv3J8zLkxZMAcolWM/Q2Bld4nYHOHtPyGOhpTryDuXLTVJvALB36Gx4QlSxxjLQt6Yym3RX/MVsJoEUV9BfGcgo1ZRLrm8H30txZU+rt32Waqp+1J7yqxqm602HP8gFVFfyiXmIwY/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zBa04bOMFENM9jrEa+zc5qraKpov0yQMTCbJvYcSN8=;
 b=YV07x+NE2cBG75iVvKo5gZZPRpebQFhul+7PSey0vjyOkIp7z6+AqMu3BktF1EGnDTyB0uk+dCf6rkR3CP8DYFIKbtV15dv/u0yobz0AmRvkltj5U4bWQHQaH0ACfaaRmOyHReSGEZllBakLQnMh0W2Ck2NbLCvHJ7smD/JIDok=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 21:30:07 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::9a) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable SCPM support for SMU
Date: Thu, 28 Apr 2022 17:29:44 -0400
Message-ID: <20220428212946.700296-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6baad358-e36c-4138-b7d5-08da295e43ce
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB432790820D109E1261AD2DEAF7FD9@CH2PR12MB4327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ssl3lQ5MUsEZ2q6kJUGGS7t6U32xeXMLLFm2so4oiRW1v8RD+ZzCXwoAWiDc5KHBRRm0WFCz3i7VF1mMmnroIbc1meuvBf+Invz4uBc66nQzEuOXfuIKFcf/6iEulDtl18XQ6cDxqjc+dxQazH9FYPKJb4qxWaxJKyAYhNkwv3H6gLf30BPCi2dX0ob/zgjmZEhOTD8rqJj1D6NKSqPus7uXUXy/GOi4LeJHVpe+DJuzv/aElqrIFuVaMo4L0xN1UNWCWRpu/7xKghCVuub9O7T1QMq2nFbOAN/aHxO9rXZCJkIIG7SXit7cRPY82eOHE5qeS79yb3XOyF5V5cXqAl0ZGJjRKzUhi2/paBGkeksJn7kjXXQbmVB3j7fMV9M5sBiY9Q0RA0cFzjLfObRgHEJGCQsrMGcEH0saFgEE7U/pUaZz8ZKi9DiW+/UG3f6DLaPveneBn302Yvat20iq3AYNumpI972JP9BPjdXOoboCWy7z2f0LvzuZfhSd1KyWYCmbLvsG5wIRKYkSAwrjBn2jUGHjZz/3t05C15Hib2Zqfu+2YZSPZ8ZFndVTiSPW1QAzGt2xulvts0geybsSwHKdj/kK7rSDBlkdtx1brng3HSonSoXbjaJOgjEQ5Y5SLZrYw499S1LZIb/uF9HUefcneoQnnVuSeVLhwDHkj7j+oWa7y7wy0nto2ezlJo49fudTIFKbJsQxGxtUREE9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(16526019)(82310400005)(186003)(356005)(47076005)(83380400001)(66574015)(19627235002)(54906003)(426003)(6916009)(336012)(36756003)(40460700003)(36860700001)(26005)(5660300002)(70206006)(70586007)(4326008)(2616005)(6666004)(8936002)(316002)(81166007)(508600001)(7696005)(1076003)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:06.5757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baad358-e36c-4138-b7d5-08da295e43ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

With SCPM enabled, the pptable used will be signed. It cannot
be used directly by driver. To get the raw pptable, we need to
rely on the combo pptable(and its revelant SMU message).

Also, the pptable transferring(to SMU) will be performed by PSP.
Some SMU messages will be not available to driver any more.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 55 +++++++++++++++++------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2513b1af76d8..85fbb18a9e4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -488,8 +488,20 @@ static int smu_sys_set_pp_table(void *handle,
 static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
-	int ret = 0;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
+	int ret = 0;
+
+	/*
+	 * With SCPM enabled, the allowed featuremasks setting(via
+	 * PPSMC_MSG_SetAllowedFeaturesMaskLow/High) is not permitted.
+	 * That means there is no way to let PMFW knows the settings below.
+	 * Thus, we just assume all the features are allowed under
+	 * such scenario.
+	 */
+	if (smu->adev->scpm_enabled) {
+		bitmap_fill(feature->allowed, SMU_FEATURE_MAX);
+		return 0;
+	}
 
 	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
 
@@ -1156,13 +1168,19 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	/* smu_dump_pptable(smu); */
 
 	/*
-	 * Copy pptable bo in the vram to smc with SMU MSGs such as
-	 * SetDriverDramAddr and TransferTableDram2Smu.
+	 * With SCPM enabled, PSP is responsible for the PPTable transferring
+	 * (to SMU). Driver involvement is not needed and permitted.
 	 */
-	ret = smu_write_pptable(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to transfer pptable to SMC!\n");
-		return ret;
+	if (!adev->scpm_enabled) {
+		/*
+		 * Copy pptable bo in the vram to smc with SMU MSGs such as
+		 * SetDriverDramAddr and TransferTableDram2Smu.
+		 */
+		ret = smu_write_pptable(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to transfer pptable to SMC!\n");
+			return ret;
+		}
 	}
 
 	/* issue Run*Btc msg */
@@ -1170,10 +1188,16 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_feature_set_allowed_mask(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to set driver allowed features mask!\n");
-		return ret;
+	/*
+	 * With SCPM enabled, these actions(and relevant messages) are
+	 * not needed and permitted.
+	 */
+	if (!adev->scpm_enabled) {
+		ret = smu_feature_set_allowed_mask(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to set driver allowed features mask!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_system_features_control(smu, true);
@@ -1422,9 +1446,12 @@ static int smu_disable_dpms(struct smu_context *smu)
 		if (ret)
 			dev_err(adev->dev, "Failed to disable smu features except BACO.\n");
 	} else {
-		ret = smu_system_features_control(smu, false);
-		if (ret)
-			dev_err(adev->dev, "Failed to disable smu features.\n");
+		/* DisableAllSmuFeatures message is not permitted with SCPM enabled */
+		if (!adev->scpm_enabled) {
+			ret = smu_system_features_control(smu, false);
+			if (ret)
+				dev_err(adev->dev, "Failed to disable smu features.\n");
+		}
 	}
 
 	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) &&
-- 
2.35.1

