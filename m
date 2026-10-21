Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB85606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VmcoTKuM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3DF10F941;
	Wed, 21 Oct 2026 06:26:26 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAFC10F941
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjC/QgJUdzVF2rHSOtvkFffnJHzZqBUifSpMkUEapgUQVc1wwOjqzTY8agVEXxrlA1oIgWbIRRnXuxlb+0CVBJUsq6f8HVsER2xVyfEDP3ocbrulOs9opCYgA6mhqBMVxzeGmSsMmyoo4s7vFpKYzEZjJ3m3dveOHi/wx/RG0Upx4Z0wg6mXPWpq1mZQkGGWf2oWyShM1pn2lSzuyWhdN7BCaeFS3zPxWszcCSL8K+2fil2Mm34wk224T6S6YdM4ONNHIp7OAanPEDSm4Sj8g1vaZefnor+0Qb2P1gJSkLhQSQ0hUhnL5SUf+0hjasWXT3UjvFKSLDBm9O76+ibvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9rC6HI6MNVxiQqVnSqhxQL7DO6WEdZaaRtVvw1a+6w=;
 b=Jdlc54sVohNnyVw6Mxsm/lKjjpH+Ygh6GDO+V8r3j3qf4FciEHS+rinylCkjyl1BDNyTxsNufNea9pz4jyztLh3Bn8l8GSx+uIJgPkQhc0QAb/FUnAAH6KTPeNubC/M+/15X9SH/uUQcqfwmvm8ch3MvUqDsfTTqvgMYTK+EEFMLw1P03e3lEGbLdUWBwIFMslGXmdjEpwR/Tku9JSTl7hkaLxwmIWJqXYCMRLaLJbaouMbH1qxiYiEp8ytPt812ddi+6VqF71PUYZB2eqtjPiH6puEcRPQVbUhYDUE4hQ1/3J73KOcOdeWDEsOLb9KI/FFsQC7imWknYsBuccg0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9rC6HI6MNVxiQqVnSqhxQL7DO6WEdZaaRtVvw1a+6w=;
 b=VmcoTKuMq7OAzdMeaAAtVrbh0068H2gPQvWkOB1AxVbxu6aoZkavVR4UKFdxkXsx95o3jRZOYhQQ17YmNaN9LrTMFJ/NzgV5KFfstmjufxSLeUcwJ5K7bJN8lEqML00VhR8/yX+m03vPPtQRyKo16A7obHMdw1OH546/S1SkOJ8=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:18 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::51) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:17 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:14 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 15/49] drm/amd/display: Handle pipeline name OOM
Date: Wed, 21 Oct 2026 14:22:21 +0800
Message-ID: <20261021062519.674697-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd855cc-b4a0-4104-87e2-08df2f3c374b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DJCnaPJ+WbjXfyIMCzfYX6tZV7zYTSq/T/ZiMv9+1Vg5WRqzVI4voFpIgEchclEvElWcOOZDWzPZ499S/5LmezDr7i1L2QDX02dmJq/eam06++7XxiyzjV/uenfl6xiTf3T50OAkvD2RK8NWyCtZdpxFqJaWKucqbd30eQ3KinUqvDG/Y/0NWe95jbL74y9bXTTQS86Xsm4ZaG1YS5sg0wkNzMWBsWf9SN9yZ//LRlwOUR5rSSWudSwyT5Qd1QyP205FveVpgbXQqprX40VRxSPidRNTxvVih2vaGtV24gz/krv4J0IbBg5VMl7HS4Mgn45fUbUjI03e8UETDonYPXUnZlSW3EhTwN+MOJx4J10Ao5KUNVosUV5YQ3T2qTxCwVNWNzBxWdhVQ2alO0v4KwKf9zvAsr9bJbF+2SaNpXZ6i0DB4ogIJyn0b55/Xe+IfKUN1UQfIjGsiOZMJHg6TPOUxFeIp/Nfa0EicrxBosVPxdlgsm/v+sCF3P+VczRoeotD7ZFtyBLbN4W+a2vIcYWc0y0fF7T/vMVplmx5V5zVK4peD3sJ3BsWrGO2RcN3IgWzPjf2mR7nT2GHCAHp+crIyp9jO+R40DYcBK3D9ejl0sf3+E5YMHBGSuXjVu7UQACw1IPRbM7pLac27MngbHWgepxUjQ8colOH1FwwfG31Bw8PbxtMv91OID6Kt5u9wpVge6Fn8QKp9DF/KvA9gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TlWkOA+8MSRnxIlFz1AAUszmTraPnIer7Q2jgmqwV1GC+rye7uALXsXzRcZRf6ERAvvK5AJNcZuVCnr8u52rfNc+CdrDvmMZQaV83tcSnnLBj4yX0BC5YNcAoUW2zbAn9Px7mBak8kJrjOdxjUBZ72fzZ8ylKjhyVMFSF6wXqcbwRZGl3+ivSm696uU66EG7YdKUb9pOKGEv2LrT+AxiM8O/kyjLYV4UtsrkmqWIxiMue4AO+hvWBsyku6Kl2HKnHBeL60G4bFjRlMDTQoKm32fP9/JGBT/E6V91GcB8iU7aFG2TDiuNfF5TGZcLqIZpUEpQ9rJMlw9eGptT5UWR1jhlfiEBsFjn38HgBlex73qnqDpPLqXrXwbVKGxSrSrYi2k9OP5j+Ty0PLQdijqi2Vrh4AwuDMr7wZlHyUzvcnrKebNU1/FymPwO7Z39PDjQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:18.1698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd855cc-b4a0-4104-87e2-08df2f3c374b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHY]
A failed pipeline name allocation passes NULL to DRM property
creation and can cause a NULL pointer dereference.

[HOW]
Check the kasprintf result and return -ENOMEM through the existing
cleanup path when allocation fails.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index d7260518a23e..d32bf2bf2847 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -253,6 +253,10 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	drm_colorop_set_next_property(ops[i-1], ops[i]);
 
 	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
+	if (!list->name) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
 
 	return 0;
 
-- 
2.43.0

