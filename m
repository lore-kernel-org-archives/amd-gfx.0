Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AE6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E549F10FA09;
	Tue, 10 May 2022 14:38:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9A410FA07
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI/Cg9CgxvFs9zpsPzJiSkgBeRBCR1zIik/cavJFAmqS+f7SC7E00KUyoWXF5JmIzaTepGNstcu6ojwWNoSfHXOgWYgAL8efSGKjH9ZcO/wIak6rkEMoUpKnokK6upyyYgfNuVQnEpMc8q3k1IYld3h4nmNOJH/1lIrI5kXPoA9CF8Q2fqXpb9h+Am3H71ahJBo6YBr7VOHazVjiJekxJim4Kh8lVTI672PswzB25A+/lRgPXMZeKbpmuydFA/e/A5Lapu+8xYXBmwRs4/BGoCIYVYrh/HpnXxyZAFaLY2GEzBVvCtuuwywEItQA77ZJThg7EjBBrLX9HQAK3OxyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4nzcsnwpHBqAkhyQJ+xSvXqwGp/dN0B8vX/n7BqKdM=;
 b=gQ1PSYzgzA4NKAULLCRj1zWRwVmphAGTdNB74jhNnXAq3M3uMbvMpTTfeWSrF7sDa4gtKVWIpSAslGRKrCeFHHaKkx9aeXD3WrLMPH+u0h6g9KgVkjB/QZCm5UD0IAzBM0Hi516bK5KDPUmojAI67ChAPpHGsDc5kw8xr15soZBipVKysbo/WToW7cmGpMhBrZiukrP9DW5PBmejOVlXo3V7KKxWl7VwOZJDnOvuNZk/zAXDNDbbky1I3FJGW0/g+pj9f/wybS12VnOH7Ji2d9a5b4YNhXaGkIJxTiuAtybOqlsqjaqSuoV3bELZZWWXfpp3upC4i/nbVpCkziFG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4nzcsnwpHBqAkhyQJ+xSvXqwGp/dN0B8vX/n7BqKdM=;
 b=l9ghJTOa4PGRzngXdvktvvGE21HuTK+C9+odBZ6VIFoTjRAVMdo+nx2wC4sBcmU9O0oYqDG7ygqCfBJVqXqhUeBYLFSgpWkLPXs1q5jjiE/LU9QaUk0RB1++2Hnx2fdGaVRZ2IibhTEbghwkhZWEn/MVthWT2+WW/xEUM13ia4c=
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by MWHPR1201MB0189.namprd12.prod.outlook.com (2603:10b6:301:59::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 14:38:04 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::36) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 14:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:38:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 09:38:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user changed
 it (v2)
Date: Tue, 10 May 2022 10:37:44 -0400
Message-ID: <20220510143744.622588-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 550ec3eb-dbd5-49bf-c782-08da3292b110
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0189CB598B4EE20666AF2368F7C99@MWHPR1201MB0189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lnxupjFx9bSV1tsLAZYoQI1zXYVTcqhmOQr4fjWSRvf0Zw/EcTQ9pMqfRg/atTqmIO/9Bg+rGrNmlzfkSvWg9I3c98O38w88wxJ+mZV7rSlbUryQ6H4vJ782AU5SlQzOJG39bzSWrUPtnl6XlLI6Yu+7XDqpYEL9WJbcyMJTwxEoJi0HiCeNYqwIJrO8KJfzdrvCniBsQfYwuDE2VMUHfmQbJDZ7s8GeNEMoQQT08vRSW1sCOvRlLefihazegZxX+mmYnlSjIx58zblIsl2YHWnL0ftwN0QE5y/N9OmThozD4HH5qKMIsEZr/Sd+BVI7JtZr256FjQlHOH1VZKQus95wjHvxVKoEHjk0PGWsfH+nAIXUrLPkAvk/CoI5N64mwsKqB5BPkwLOtbehuAVwkr6kI7YiMToojaN7rnBk7OuYmvPrqbMRZUN/JEc3QyMDCRvXcIDE8o/us1MO12crV8NJr3VKxjpcfREM2TS/eS+5H7Q1YCbhbeHZOhM7Xu+I+78zt0aabW0tBHvFOCGgItL8i8aD+gOYirwQPwykT0EQGtffNWuDV3Cn9cTlKWXS5cHLqyiIj7I5pGB6CSm0vk77PMVqhX4vGc7n2aCuzd2oOKdxNPRTo3GDNDnw4VqcUvm5UYbrDGT4TGEYXbiFQiEaItcfEqLOGXixE/9tS/dgAnJjJPjpmM4S755WX/7YCYVYMvbXnZK0LBJDQ0zUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(36756003)(81166007)(36860700001)(186003)(8936002)(70586007)(8676002)(2906002)(70206006)(356005)(6666004)(83380400001)(7696005)(6916009)(4326008)(316002)(426003)(86362001)(2616005)(1076003)(5660300002)(40460700003)(47076005)(16526019)(336012)(82310400005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:38:04.2846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550ec3eb-dbd5-49bf-c782-08da3292b110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0189
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

Check if the requested stable pstate matches the current one before
changing it.  This avoids changing the stable pstate on context
destroy if the user never changed it in the first place via the
IOCTL.

v2: compare the current and requested rather than setting a flag (Lijo)

Fixes: 8cda7a4f96e435 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5981c7d9bd48..94c3a52df131 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -295,6 +295,7 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 {
 	struct amdgpu_device *adev = ctx->adev;
 	enum amd_dpm_forced_level level;
+	u32 current_stable_pstate;
 	int r;
 
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
@@ -303,6 +304,10 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 		goto done;
 	}
 
+	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
+	if (r || (stable_pstate == current_stable_pstate))
+		goto done;
+
 	switch (stable_pstate) {
 	case AMDGPU_CTX_STABLE_PSTATE_NONE:
 		level = AMD_DPM_FORCED_LEVEL_AUTO;
-- 
2.35.1

