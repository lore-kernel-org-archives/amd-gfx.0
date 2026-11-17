Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BD606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=opaP7j4f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC9E10F8C7;
	Tue, 17 Nov 2026 19:24:43 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E70710F8C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlVzAESsJlBsIX/RmdkCcu7RUr7mo2EsshyhefZrAf2Se7Io80oV29yESfrLM16mJ0UW5NM+Jm3eXGY18gBnL8T6xGYIjO0a1A8Ys4QIZIPfZLFwX/v7bsrzDdN3+RwkT5mArE+w+YVUZ7l/Zgno616uOn9PjnbD72qVqwtvvasVtT+xWQtNudfDUYwGKuhmZQCkUu1KGAfgpOLezIADoAzkTIv9VS8taYB38tmxXLC9e16C0a6FRYDkX68Jw/ZdPhOMOP2gn7Y3Rph8nsq/SaqY1HjUjFk6sP3A9jH3+bXPuS2ECxykIVL0qaSf9dtwiqXebehQi88OZDVly5cSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqNe70Kud2Ja0mbeMDEyknZQjODNHXAKBFdTpSBoMh8=;
 b=xWwBMoiv/NmbRJLT9Pq6Qc1NH8PpPJe4bCzH2d0NObv4qBTd84DYcbypiwR1XT5djf/XjQ4TzQM9vUvoZDVOdFmvYoqAquMCTXcYv9dfYXlBJMHEROzmimBW4aPoGs/B/DdfKUh/nUSAfd1StYKBveNTxs49nlIGJvvT9iEOehtFuhLha4/bziJH5k2dSiq7b/YWqCHA+So6jUu83StDFRDiIYDi9sHhHfIUsnb+dFQAGCJzMUGEjPxf5QQJDFGzsm0Ejf5OYdHPESGBAgWEfmGUG4+mXvmHudBiypReQzVuKLW5IU2C/2CbDQoDaUM/o8b775G8nmRdGwZCFWB6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqNe70Kud2Ja0mbeMDEyknZQjODNHXAKBFdTpSBoMh8=;
 b=opaP7j4fVw03N5woTvG47aoE1t9B8yrwa90TEd/3eEHstod7VhQ/3YMs3dCcgK+2q9rRv2p2M8AGa/ITdBpSUHXw1buoRJx2iC+CnchDEMA1cFVysxqWA81GXFh7lWG671kJI6sOS65EohiaYCQ8mRtlIWZV1ljWgdY1pmDoLcs=
Received: from MN0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::30)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:24:28 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::31) by MN0P220CA0006.outlook.office365.com
 (2603:10b6:208:52e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/mes: add callback for gang submit
Date: Tue, 17 Nov 2026 14:24:08 -0500
Message-ID: <20261117192415.810117-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a63e2b-aa1e-4e37-89c7-08df44e0659c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261021121427099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: dUhpl2soy7AQSoF90gZm+jE4hd61VpKXR7hhlVLiGDQ4juD7AVyXDRKFvulpKj/JYHTw6jzDCoMj4PKA7UviTnPXLPPvZCxtqLAmrq6PHHNz7rQLJKr35Qi6IixxKi31AxwJFm6v7jvzFjBx6zfQ1bhVr7dqhzmScXaOBrbZkZTtrLKAOnmA9RtXmyRqSkj/wQKbckVlUp+AUhf/1bqc/7y2wawTPrMRO/HgTAQX9fdqN1UIfoLbKT4kJ+D97eV4Bj+gEzj6sXfc0DISLqTxzj+s3YYYPLSbfUaSJYdpjMR4Ml27ufm49FvFpRIMspvm7/X9lB01bwlwcZxf0a5MarRcyA/P47JznapRmtTebq8gXddJ9vpCOtYTehDwiqSHiYgCm61l8HSGtCvJAdZeo35Rx2VW4q+1rRGf7shhd9F4YmtTFE0Vteek1cWmSj964s/QpOUoNUBo6lLRrnd+TWqWD1VDQ4GgIkN82HcwOY+ri6sjktrWjTrv6vv5/sGJxy2lEie3ryDfniHjAlV+0ykTSqW5PwRXy/yXv/V3vt3EraOllpVgSZvMXNPk8XYJTpxLgD4r18wcKkOuoldrkQPMZAGpz/nzh3c3h9op0RsMdoc0zlHEr+RJ89DNMr/Mr4w+JZKE3sCS1sptTHFL8E21vzadYmZyDHJvvC+STRIK0KSAjqDwCOsJp+h+wZ2tUGAC9tv65Sk43MwxBoUaMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b8esuVdqriUFY9Z/xKD5ErjCNk2ScEIuvAcsKKmiLUcp8xkgw5B9688l0b3qwUL5swB8SpTChAmQ5SiYUmJ55Nh02g44DCmPoQsGIXM0V9kvu13E3IasOYmRFx+Ynd5Qu8FFFkfAmB+dtBhFzQ0qmDIN2WoDpiGmG4JPs7TezcOBkdOe2UPczB9xju5wulVwWuDA49c6MX9w7jRON/FDHMNf+NpyTZMA0bIHkZyHsR6iHbiIUVM6S4eP+XsreBxcQASmAjdKSGK6LKuvv+De/sYp2dWaOoBjNSNey3ZXBkG2VzQ0DQ+kTp+pHwuyo/Hr/gesewvRDsd6J6JqMOwtEZC1p4rIQXSPjFQYbN/WrZJXlTZLQ4XjjMGMiGFs0J5YJSQNrXEHXGj70OLOUuxKiumB/EKMjhBpEy/dM0+6wkU3hUP+wlz0yWSbjFeRDlTC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:27.7599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a63e2b-aa1e-4e37-89c7-08df44e0659c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add function pointer for gang submit setup.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e5dbcf8ef890a..223326669c109 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -401,6 +401,11 @@ struct mes_inv_tlbs_pasid_input {
 	uint8_t         flush_type;
 };
 
+struct mes_set_gang_submit_input {
+	uint64_t	primary_gang_context_addr;
+	uint64_t	secondary_gang_context_addr;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -520,6 +525,9 @@ struct amdgpu_mes_funcs {
 
 	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
 			      struct mes_inv_tlbs_pasid_input *input);
+
+	int (*set_gang_submit)(struct amdgpu_mes *mes,
+			       struct mes_set_gang_submit_input *input);
 };
 
 enum amdgpu_mqd_update_flag {
-- 
2.56.1

