Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C919C5DF9B
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFABB10F3DB;
	Fri, 21 Aug 2026 19:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfVNJrmA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95F110F3DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhkp2yvUTYkqE2AcQV3tXT8usB7wIjN9tVR0h7oqjY/cBAdSe3ICihW8enLfHZBxvp+RB8T48loyhDNQzmppWNv8svAu/aIgdCyNGHVVobx5pJeyzpUwSql2PcOov6ixM3yge8gtstk7YU6NmodOXRzqz7pLa/9rxPiy6TMOV+Lu5NHm9l4GpsE0GuLZAmUxcv6WOlQle/ZHJwHQPu0SZ1QEpkPzoxjSPRmrcmiL2gcsbYR+cPmQ6TOBx87q/n7Z6bi+7fYusn/BObaIsBA1seAmFpAyvR+w/UNC4I+UOiJLq8BV8yb0HfQlwzLCZMupW9T7WzRxWMgkD3YWoNc1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9ogpgxZZiUuB+kMaZhLmW3p58ORAfMqhOk/P2o3B7A=;
 b=ruhve/dbZKPOZbE9tbKeV9Ct3xrHJYVTcGBQT/2oLHb4CKvBp9s54nkloYoUNx3oulGo08xj6t/LCbp2OS5QcJ7/qufO+zdFBsnqb6yGLJ3PP6UOd9FoJhmAwhUxveN+Sn65/drHdGTJonCMfy+PErHijreShP5MdCdgmRx1lY75PuGXqvCZt35F7fSeMu4pbGVZYz0tGi7QHWn2twJqP3tqhqTOkpto0Ghi9fur6shzP82/bOKFeAPcdyLnGiMmRjjFwVNNSeJsTlLQ9Yipxr06f8BDHNLLERhzH9QdBuK3+QWorPcEIEqWaPqtkxwbPNfffI5XT0cFrkuOrehHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9ogpgxZZiUuB+kMaZhLmW3p58ORAfMqhOk/P2o3B7A=;
 b=wfVNJrmAMXI+X/DrLlnXzeCbPg0msAQTH/8MOM+ix4/5K5qGMKxV1S2VUYMvatb/wAMEYBOOd0K104+1XPB8jaFceai0SsQP8Pj6CTstuLI1OPA8ok212L5EXxMHbRyU433bPaI+kaJ+ESqnlbiGCu6Rr/VQ1JwfemMiBT481Tk=
Received: from CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::23)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:27 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::1) by CH5P222CA0016.outlook.office365.com
 (2603:10b6:610:1ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/95] drm/amdgpu: Add helper function to check psp xgmi ta
Date: Fri, 21 Aug 2026 15:33:41 -0400
Message-ID: <20260821193458.808626-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 9103e4f0-8621-4f1d-e981-08deffbb5a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: SJjMhsoq7dVW/2QYmdrvuJU23kUJYLfNS/+Qo0Mk52iqDqBv5tEfFJhCUqjNW5hrCen2/fSp+n8RtURyrWxVetlmVfFID5oK1SMIDQm81kre6YxXjuR/BSdchQoFSq4KxAOlPAD83eGhXcyWyXzd66aIUxw3mLe58+s+tKiYBcqmlW4YBWoir1Mycxrjm/N6Cmh3QPXvTbfS8lRFnZTMU2G2EVSUepotVkHBcbpGsRjnDzBZWG+mEaVIut4Vp0N1Y0+Cf74cdM+nSKb2kR54TeJopSLpLzeVqh3llZWMTWsrtroSRu551ycnmGPG6iwFQ2G7+X1ZtyFQantFqzQquEZi5dbnS18Pc75d9ybZ16216XZkgELK2ffwL14JgZ8sbx0WMMhNgjm0C7tztxDLEqLYfN6FsDvf8CWpati6cWN1mvlUO3W5uaPHYIsMvD0ArLaqieT1/PkdKpcg6kgZASIqbAX5hTdlO9VUNHanDYWq4ULYazvdeyz0f9/s0vHw2LeJ2s4KW8vmKLMJ5/r9a631I9/EeKWneCc/x4Yzmjeq/XRvk5dIs17rtrtblkkrEjkxjn6FNf4wrzH72FfdH1IctKry0i3yQ3NpFcPAK5RHNIlPnvrH2Cu2rbR4+6Py1ncU0P5/m2SunEJqOzqms6QkdpQgTiSShVRxKqYbVEBLrPmD6kNmr45B4hFYJf85CWtTr7XJy3qBemmmCauEYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YI92K+jkNhPIuxgxiAQKL9ahjci2lZyq9eXP+sfPhXB6Zsfh3rCJPNrPm6A/2EY9Jbu3W9QgphcJmAFW4xX7oWBIbCLWe3q9nlo9iqUuSvQuYZAXc9J4r+LP1CGC42oXoYodqENCN+DRJSrueGUYmhdqs9Ap+94BcZ2V9oHE0YxnJuEFcmRqBIlLB9USQzP1OOIqLPNzujLEhIjwy/ytJCalof9HGB4Vbsa0rvBxQuFLE9s0KTt7GJuCsYQmIMTTDDuHXfL3mlqXY+z4VEL2Vd+gzKRdUwek3rZ3eOqIOus3HSxaSC1/Pu5YVn7M20Vki28Qx43inegeNTHtVgfGp7+AB1AiMKmGOBOSnaLmSJ2MaK6ttXIiesYYoII/VyZRRzUcuTzRIGoJS+Ljsne0msXuwzC2ZHP7dYvXTCNcQHoBcsVDgfD/Ax8Jh68aQ/K4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:27.6344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9103e4f0-8621-4f1d-e981-08deffbb5a91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Helper function to check if psp xgmi ta is supported

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d68b1e5118732..6a66a90c8e5b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2257,14 +2257,19 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	return ret;
 }
 
+bool psp_is_xgmi_ta_supported(struct psp_context *psp)
+{
+	return psp->ta_fw &&
+	       psp->xgmi_context.context.bin_desc.size_bytes &&
+	       psp->xgmi_context.context.bin_desc.start_addr;
+}
+
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
 
-	if (!psp->ta_fw ||
-	    !psp->xgmi_context.context.bin_desc.size_bytes ||
-	    !psp->xgmi_context.context.bin_desc.start_addr)
+	if (!psp_is_xgmi_ta_supported(psp))
 		return -ENOENT;
 
 	if (!load_ta)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index ee37170c1c2b3..bb84f3a3dc54b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -628,6 +628,7 @@ int psp_ta_invoke(struct psp_context *psp,
 			struct ta_context *context);
 
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
+bool psp_is_xgmi_ta_supported(struct psp_context *psp);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
-- 
2.55.0

