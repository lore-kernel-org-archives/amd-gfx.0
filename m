Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D5CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89186112DD0;
	Mon,  1 Jun 2026 05:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0YzVXiyq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6744112DD0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anTyxj91iWAg7czoitZWtDB+/1cuHWKBvOCtL4sicOZUV4z+ToV+v4fos1SyhWzu2L39LOXpJmazoJP4ShQv8jFJzagxIg/uN2uG9qVArB2DDXB3FkG1gPfcCCTJUKIV8P7mAucFpbAz2l81PC1IpE1RhZhOxHMC6by1s7pLJ/OLl0DlVE9XukQOBRrLPXlcNlGvS95MKqI9po+puLjv0X+iEyYJc7hGI2XxNxwJ1I6m/zZTZn9vJZzpuKjVQjbF/Qs3U7G7ozIVXm3dFVyhzkcnjm1d3GFEm+xYNIVNhQtWDjZB62fEZ0Zyvm30/tN8qgCVet7X/YKad5J0YoOQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HviqDOStOUy0vpRMLSFMKQPtwcbIAwpsmG5fYMPQ05w=;
 b=k9J0HUTq9n9UK4iRAdHuKQSVP0sdTgYMBjdclAaX08dzgWPCCoNiiGQEF0aDGpElom3rX0Dxj5NUDzhLlu5TuttLgjR7c50iaMo3H/0dZ392skHg3FOr+sMLoLF8WiYOri7xGBo1V8T9pEaOwb97Bj3MrmPjbxa8k3I3pkEMgV/V1SCcyU8Ib3wKKFAw8Z1ulydIu15FtZSDJS1dDYwEb2mGuMvS5WwIsubzjbBFw7AyTA6cyvWbCfhBQ61Ma/G9MKabIcHGrqg0BqhQVwHQSlkg90PavEvkfRRifexCGl2bdNf/qLib2JLVlwxVmBe6qtXbZm6hB+pX64KoILw6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HviqDOStOUy0vpRMLSFMKQPtwcbIAwpsmG5fYMPQ05w=;
 b=0YzVXiyq9QDIZRZeTLNLTtFy9rvfL79w/b1yWr/qnrM8Ty1jtnYcPJ70xpq65UE9ZYETGVvnsriT/h+to3YN4R+oCnMAGmP36itTTefT+otxj7dxq970qZ37eGB1CXeiGLRwvdX4swAVtEWagp9NolX7aFUZlmOAYpzqph/XB3w=
Received: from DM6PR02CA0148.namprd02.prod.outlook.com (2603:10b6:5:332::15)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 05:53:40 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::3b) by DM6PR02CA0148.outlook.office365.com
 (2603:10b6:5:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:32 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 24/42] drm/amd/amdgpu/include : update mes api header
 v11/v12
Date: Mon, 1 Jun 2026 13:49:10 +0800
Message-ID: <20260601055034.3700921-24-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: f3633982-790d-484c-3eba-08debfa22172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: X+oP3RsFilXCzIfHTs+pHWFQSiblc83TiH4LRo9L5scVhqmGzrTFzoZ5Fc52flAfdugSabQ6dzRV/c+mmpZDcBP5bMEW5Z3R6MRJ967fnIA2WxdjCG4bNqmQcEopKshN4gxtw3oqwlHEM/wnLz45Ta5Dc0LCOf0P/+kvG/KzSzyE86E03etUSGpvV9hEA9czi4hPb1QsJBi5ubWYOYgS1fDAHfdGXZhs6NctP4oaByNrK2zoSvEMPQzllBoQEzn7EmPQsG3EQJvTPky5i110AmGoLdHJyNbEPjiWbiUeY2Gfy/O4nr6XcN4HvyDHY5cagG3ARG5gZBK5niMIcnZ6OyFBjVUizPpFWSYZX29AzjeKWROb6Fk4kQ+MmfQwqquf4bZSiIcogJh/UA2mdd98kYlaO3RORqMaZrsZaEdc74GemvUGXu6YEynddbRNhbqgg+78t6uBpr8269t61b2fMzXzNVShYEhn3DsecaScZOKlZoqLzeHbvnR/CXOjbI3g9kPlpwxtRNa/YgBW0UX8lndQsAgacubEOjFkVgGnnp46S7LdMjepH7J/7E2vE/NsYMVdOtkYsp5/VrS6w6+MRwQfBuj0cGJPQZez/NzhlMrKw2FHATbEmu9EMJXQNRFfZVZtf3pYC6AyCv+ciIga1KM8F4sckE51sCUpbxTDMXbjmpdafHPrYBuQkV10csnydFSHc1rrkVw04EitcSpm+hPhsbEk4gJvDsqkZiGuQYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8MnW8OsZLO6oFoW0I4t3pnQwHb2m+HAKUI0YdSJf+Is0Gqwmvt26qF/yKbP3dmT2cFWkQi8EEC+RyxVij/iHiCoCbPcwQQTK8LPm4GzEebjHEbrdngNFu5JhvUc45mGBBbF5UYBZZkQcKKskPvwGqqe0/f8fnddQYIOt0RRBBfzwhQmqxwH6zNStZk/UgFsAtXjq6SFZlVyhqvaW2lFkANb6wp8Yi4MfmI7h8EIGX01iwhFjfePasLcwkLvBD/ZQ2ft2AxfB9I3snUAMQ5RVCfFYLVnjpeidN/ypqJis5Yx8wKOyrYdm9Ng/djMQKukoTak7F5TCAaKr1GU5QMNWkQ5CU2/AqleU60cndkyVzl3kS4PTD+GVjYjJ4NATcMvuIBpa591DsDGRH4VNEIKBf2zP/PFoLQZFK8EHjsokrXD//kREj0rfSLtef1KixarM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:39.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3633982-790d-484c-3eba-08debfa22172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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

From: Shaoyun Liu <shaoyun.liu@amd.com>

Update the parameter in SET_HW_RESOURCES API 1. Align with the setting
of enable_lr_compute_wa 2. Add enable_compute_pipe_reset to enable
pipe reset when compute queue reset failes

v2: add driver flags to track when we enable it

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 3 +++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 5 +++--
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index de7307ef60c1..edcfaa5b3e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -168,6 +168,9 @@ struct amdgpu_mes {
 	int                 master_xcc_ids[AMDGPU_MAX_MES_INST_PIPES];
 	struct amdgpu_bo    *shared_cmd_buf_obj[AMDGPU_MAX_MES_INST_PIPES];
 	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+
+	bool			compute_pipe_reset_enabled;
+	bool			gfx_pipe_reset_enabled;
 };
 
 struct amdgpu_mes_hung_queue_hqd_info {
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index f9629d42ada2..6644fabeb0b7 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,8 +238,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t enable_lr_compute_wa : 1;
-				uint32_t reserved : 12;
+				uint32_t enable_lr_compute_wa : 2;
+				uint32_t enable_compute_pipe_reset : 1;
+				uint32_t reserved : 10;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index e541a43714a1..cb7ebdfffeeb 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -294,8 +294,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t enable_lr_compute_wa : 1;
-				uint32_t reserved : 9;
+				uint32_t enable_lr_compute_wa : 2;
+				uint32_t enable_compute_pipe_reset : 1;
+				uint32_t reserved : 7;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.49.0

