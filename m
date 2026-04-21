Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF195F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BFD10E928;
	Tue, 21 Apr 2026 18:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CoFXSZq6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A86B10E924
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFl5ZJI2juJyG+L1SvQmiKb3CU2NVkJOShlvc2X/ShIB0/pbHY8xaAbzWkBaIN4HHFiXtetKA3u5O1vq1uv1OCeT0eili/Kl2QPiUhfTMjoosuXyMYm0h1a8mVKySi50H4vsuBeVYTOCFp7rLeRikieJNCGSpYrV+HcXhI0SGijrXvPsE3ftqdPkqWAWfE6GcnidVuiHONRp5cbLSOkj6soZsxymd4t9ZS8QDn6FfiS7qmTQZELunbgpHhiJIynfCRZy7GzYpd4zml0RyqdUexv4Smj+gRdGVr9PBePk5vlc+bJXzB17xtUSUD1T4DabTS46GMUgv1X4x1LTAL6AxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=ghWMuv7AUs/8FqAMdvw20SYeAu7Y33iQ2TtRs+of/ZhvkXjJWsW0J50mIPIVDDsoZf3JnrIUtYisJqjJpjGL4AzlxxGr4MmxmvqlmXPeh/He14Fi5+lxpFg6SerkaC10LqPGKsz/ClVnc6FPfQV0CMzJPUYbvtQDinPX8bPrhb4MX4cOkDw9BVR6Qmf0C2AlsS9Qc1IMAg5e3uCYlXgL5dvAoZJXJPvHFILWu4ecHa6O5uKhi4ffIYmnwZHAQSCCGK+A6ZwOjGMuU32syAjqmbbkTxHtpXBMgVjIDF5+g7nmlJ5zMaOEoOjnnziY8rIDq7pH7+g2+FBwep+vpuAEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=CoFXSZq603jW8epVL9cYDessoazJZNtXkYMWdmYelKfP8D7K32C2sbZQQLBEsruillrpmsnToUaBDURikhgwLy6yd2YKChEdNKINI5vF07fU9EHOeU7EoeAjuadTjzGzTCeVQSws4Ej6xRJCfSWHakbxixHPHfj4lXmPqZWoV2Y=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Tue, 21 Apr
 2026 18:07:49 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::63) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 18:07:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 07/11] drm/amdgpu: Document WAIT_EVENT condition semantics
Date: Tue, 21 Apr 2026 23:36:23 +0530
Message-ID: <20260421180627.2402093-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 345afda1-2192-435f-0080-08de9fd0e5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XZUGq5TKrHUFARnp5n7sAbXpmr+4unvIJwJnM+3Ma4ljGCY+j0N/lTvGhSFg6bOfPRZe9AvVp8a/F5aHfdEH5iSIxOiBXGU5mi8hl0+yZ9GGbpCPcwCooDxQfrPOPmRPoKWnvuFWlgT1TtrJSfBstdnEFuOTpVMa39QX1HJd/hO+Syf+daMcERN1eLOFhK+st8GFuRjqymJzASkTNrfdKdCXLrbsJGCO5zkg43nuoGg1aS5fAz9oV8tXkGR1fges5oscQPNqkZEIKwa+yk0LsKrmknhqncBT+LYDTXx58Zo8+1MSNpjkO/m4pQ2JJiRdPMHVr6zhacfujxObXfuFhdHmpqjS0AY31HfnCHe8MzsqJyozlGyCLa8TGGKFUr/vQmIbrXGJdi+U6YoiVViifScDjbE7pAuw9hYop4t7EE3uXjAtje00Erq7CID1igll39tOBljrTEM8QCjePiqeAE/NIgcLIxfNbL4Tf+FP2S+g0vHRmRXX+w+KhmaX+/lY6Ff6fgHQV78+8SHowdTAioBcLvnlmfvqTigRTmOG6kiP4jwzCb/yQ8YXRJsOYrf1cR7jkLuoUs4H/MAC3pJYwC5ID0/yxbq+Czi8IWvV5h2uQtPNfUTuQ9SraZdOlfnEBq/RMB/GUqX7Plqf1mywia06R6m2KJH3b+RUzD5Nmsivwk9tMVMaWuyMrTbKpdhksQeGpo8qb9WSd2szrpYfgewf+AvIQIJIJ79D7fdO6KFqKG4I1t8eNNWJu3u6a8UuukkydNMWk8MFHOssX19rZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8CgLyKG6R2or1LtFKJEBd2jEq2jjFJLYDvlTnv2hL5WZ2MB+hsYQFPYJRIqhuOdO1Y5MECpoGk2gYzC1iUohu6kjlyqekGwro/vc1VelCULgJwaew0FVzp//iGI1jE7M9JeuOX9iRYFdPdRIYdSSkKGJfVkfb8tvFXL68WRIHmjNEIDTR65Rhe1va2su/0JEW+3r0tq0CuTIIH4bBSmLS+ZnfbaPgLn21rK0GXJnc7bFHeexz7BWzw1u2HjfCqttvkaVczWGjTUof5zcI8b1xR2Bty/GG6eq2kUFJuW+zKnc/CmAcj6NUaKAQNSBafRG/M7PNQuBZcyC9if48134dsQpiUs8OQHBuz2f6Hf6ZMXM1hdmhv2WRFDbmZoX+VyHWubLUqfnTG2NNZcFDMxsmcv4THaXgSDm/3QoOoQ9blvZn4fJEPlmKFbW2s+Jt7Dk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:49.0921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345afda1-2192-435f-0080-08de9fd0e5d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

Document the optional condition semantics of WAIT_EVENT.

When condition fields are provided, WAIT_EVENT completes only when both:
- a matching event record exists, and
- the userspace condition passes

Matching records are consumed only on successful completion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index 67de685647c7..3cccc652360f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -45,6 +45,16 @@ struct amdgpu_wait_event_mgr {
 	bool dead;
 };
 
+/*
+ * WAIT_EVENT semantics:
+ *
+ * - WAIT_EVENT matches pending records by event type and optional queue id.
+ * - If cond_op is DRM_AMDGPU_WAIT_COND_NONE, a matching record completes
+ *   the wait immediately.
+ * - If cond_op is set, WAIT_EVENT completes only when both the record
+ *   match and the userspace memory condition pass.
+ * - Matching records are consumed only on successful completion.
+ */
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 
-- 
2.34.1

