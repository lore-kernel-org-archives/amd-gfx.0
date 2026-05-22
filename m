Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA73CD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE77C10F492;
	Fri, 22 May 2026 00:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JRzaQBS0";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C875110F491
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJqU/MIOQHm18owGTzbG6mHli08z9AWD+0NHjlQg0miORdQncdhwIOboSnzgWPfLJqH30/myynnLZ7av3nK0tpT5imUZQQ2lrqiJZHzN53rU2Rz0rgIZhDSPvLROo4AWAhP87pdTUgZbAWH2eyNTg4+XCm2duZ2zNQ1grPoLVNmZ+FpxexApt3gr51FWYCxHGYeJF7ShrkQ6KI3uqc58Ko9Agw8YX+h/7MPaXbEYhCQNNLq0gMTy49JCQrhYIIlzOjO3zpuv89wH1NNABP+kCQ9d6NuO4xkoEv+LOAi75wB8BWZJjZCnNhahmfKmvdHm2aKKp7ubDZevm3fVG2Jqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOMqMr/tV1Iuc7QyQgBhBCbolJg/hYjAFrzo+UUlRuM=;
 b=KLqZcsNFaV295crEZj/RJjThTvMbx4TdKZ8L2Oart27m/Ee5ksI7mSxunL8M3cCHLcCZ5NODOckHIuVfptXVw+JlmCYxTiTSMiFhtNrzeHjBGyEc7edyy6/KDDpIY7suEsR4e7W73MVPscDzj1Z621/dz2kJfNqQObxgWRafvDUAGUV6t6a+unwRYAEWJWXTDi93EBqxBXGL11Oesd0KQAIRqDPHnbrHPrAsUAUIIhbNLa0iwrUXzU4ZJhNZUOqw3dTJimA2cCPESW5zvTnW8N9xtxIgwS1Yk/kieh92IzdFGCo2q8FKZqrO6caWj4ok/Mhw/lzqloIKTid+HuF3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOMqMr/tV1Iuc7QyQgBhBCbolJg/hYjAFrzo+UUlRuM=;
 b=JRzaQBS0aFDz+asPUvKQvzeCwtjre0vxlph7AWR4tPctj50IileCtmaD31ozFvHJe96Ajb9V9Rc8mGRUleH4kNv4ANTDRlA9OB4MoS3RFVQzjoN8AvTPI85gCQeYHLExsXkg2+zEnAWI1oJD02ssJzEu12Rs/2iLnhKw34/K7W8=
Received: from DM6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:5:174::29)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 00:22:25 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::1c) by DM6PR21CA0019.outlook.office365.com
 (2603:10b6:5:174::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.8 via Frontend Transport; Fri, 22
 May 2026 00:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/42] drm/amdgpu/mes11: enable compute MMIO pipe reset
Date: Thu, 21 May 2026 20:20:45 -0400
Message-ID: <20260522002048.98506-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: ef032a77-ea49-48e8-6baa-08deb7983343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: PYczeZplL9+PF1QVleQomAulj+lsjkLNs/x5oEfElslcl2PE9+rPenIWFf2lGJbexuKTUaYYgCXq3CXfIUtnG9R3ZprYRip9+44e/6MqpsFIVaxdLaWhaxwjgY+V301lYOI/EJkcSlPNd5vVfK6FpsUBdG3LN17qvFk00EytaoFqDjdOvm29MK6XhRPtyBuu/9Tvb8IKpnrFjtoRMrDaoXwYHvA9abiwY8BV0jRkdYR6HpMujoh/Fl7IB7IabRTYO5HS0cGB+9lDvlp7Srq3U3JEH62uMimxgY8sB+yij5ASae89VZ1GPdNL8lUffwspeW//gboRYqhVW3LR5Ml1QdFA7SNN0F6BvJTH0JB2/NAeqiRtMbMY3cMyKkZPdVY7RIA4qWSiTHUyjBAH7gn2zmNNpKZEqt42ENaNCqZ4TRgKcELmLBR5DKDvBywbZYG+PktZvaA/D4F5bYRqj/GcZ3JFF4nAeufcFeRX3LBPQ4CiQTiuMlnFvkEUXL6Y15FfCv4CFBlJYAkekaf9eKqFCpRza0eayGlvPAzGr8uBSR9ZIjwiUaDNGD0CYaPUNjQnCU0eYPXinA1TdKIeLqeCdPuYK4Wh53T/HjUUbqH5APnvUnOjLU1HKdv/2lkIkZ5r+Y4zbrxAtZVS6ABAVHZkNHGXl7LjUQMw4quzGDyM4hap4KyHEqa6zkKgfpnEWXMuL/ru2DCFOtzOEKQ1F1Ip/ntNaNyu1+RM9Em2EEfzh8o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: In082cYVQrEKQLJYbjJ7AhH4Gojgve20M6hnzR5ZzwSGdEIRS2cWSdnebetwKlT8xfByXZJXQQCAijwTKv22p/zlxzGANrxjD9tS9ekbOszS44Wz1RS+sOpk4QFfL/dpTYeA5q5OP1jSecPR7d+PphmqBLRrw4oaviYlN+aow8c9eLztQEPVXEg6SIiboNjTJ3+YCNg5xU7mF990G5bn3Mo5pDNyTNs7R7W986iySAz8TEznqq63IirOkhTZUjKjMIur1VnaiCvdfN5MtTWdHmZ8w33fgtVHItS1lsxPtmWkYwW0ro8zeJe6/bpcg9EH9KlA5pgFmcVLHp9b8Ay+9JV/yVvFxDYphPx99YnCFfyedhEv4nMhJsDCvo6WRBf/RQheL9BQB3/ZNTZ4ofxpAo2ydlIXNG/Y6QN1OG1q5rW3y7u3eGnqelSlUMTStUf/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:25.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef032a77-ea49-48e8-6baa-08deb7983343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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

Enable MMIO pipe reset for compute pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 385dbb1680b3b..d9dbfadbda892 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -486,9 +486,6 @@ static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 	uint32_t reset_val, clean_val;
 	int r;
 
-	if (!mes_v11_0_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, me, pipe, queue, 0);
-- 
2.54.0

