Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E7CC79F9F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3052010E23D;
	Mon,  7 Sep 2026 01:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHQkLjnI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74FB10E076
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocykStheUQLep20rlwMbeo+kuT+CQiB1GC7ZcPLJqMvbKOXIGkh6+VkJDvXNtNlFEYLaSKSgO0+oiFrjXBM14hdxKS+DeTljfqNu1/vd1ofhZAg/clkGIq/ri8sHmOxOIfV9aWGJn3G2xBBJ5i/ci1Eh70H23XYPq4kmVy7hY+qYpSPhwohft4qoNLZJ3rjCHDZHpT/ocMQTKHufHBjbVaIPzrzetM+0wNoRFzapkPOf7uDvqqUkMYN/B/UX0sGIqfw5HErFIj06iEcBLBlNfoOmnp4fKt+XQdjvIXlZmbg/Ztf1tvYk1484PBgrj62U5CUV2eXyKHii14YvCdBfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDjaN1B3D0a/efpJcVij48+92n524i8i7qxvYIiWqI0=;
 b=naJFPrhDolkRG6hE+C4yeShBEcCmvka3i9wxToCcxmgQfhG65/b0C2CzFnE/XhjxVcYul1QwQj2sB1XfI84JudM8wYQTvHam9JfGPZASKdpxMN4tpE/g0e7nViahm0IFkS+DX0sePoWQ6slF6EfAprJzu1hFRVyByKdwYzqM0yMeVwWhxADZ/9JZ6wdDz6z/Vx97undDogg42nk+qQ1eAvWu9FGcDCCGh3N1GLkDXKGyEK0Hh52v5bmKh5DGCUntm/ydGAcy7gZ3USsnteeEPnutAR3y1qVtHstH9sPNsTkgkK18o5CUqq/6ObvKj6VwEL1rDQDLhSQTa7MIkeU2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDjaN1B3D0a/efpJcVij48+92n524i8i7qxvYIiWqI0=;
 b=mHQkLjnI+lTs7cWEl7S6hzdGwtVu5frCO7qTgYnVhxJ7dHrrTtG5lJ95s56PJuJ7S67jbPLwtNMRQ+QWumoR2LU/CNqWt3xTCtiDSvdYz7Gcb2EYtmpBJwb8Pe8JuYoXsIDIegItRbarkLkV3fBjPjEGzdKRpqPG2nqLb3zU86Y=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 01:46:39 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::aa) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:38 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 2/8] drm/amdgpu: add mqd_prop modify flag for queue MODIFY
Date: Mon, 7 Sep 2026 09:45:29 +0800
Message-ID: <20260907014629.2186163-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c09cb9-29dc-4ff4-be63-08df0c81dc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: mVZmAGmkakXZxHEXLUAnzk58AEwJaw1pgUjxo22SZTnPo6JbresvoHECgUVgHyuZRwbRGLJfja+q18kkRPUymbJLBwvUmFXLCdk9jeJu0qkjhvuJX/wEWFpDYiEXovtbrvnCDnRWYRbd8vrpS74QX7LrTKN78O8EteEOL9Iv7BqULRhqqWpAVG3obhfCnluhv1suRLK4ga5z5sGO1l72YtDfQM4T91fZLPfoPMR5lrk5GFu/Q/6wBA7bsWZofS+OMtPhB0eaGM49Z4Y8+O0QRf1Il1NkU0HautumoIiBu09/ZaRMq7DNcTbVOgj3amog7pzbSfN6RzbvZW4tGy+kRJxEbRVyar1PDj+Vs6zBoiEJGLNEZO5NX6fP9eifLIDT4dW/3msshrfuEbDh6EOEPUf0++41xbSxxhTfYoA3x7FGw5Q5XzMYi/oH/niSAG6uCfdHIh0KjSDyqydze3fNn1jTMQNDqoQZs+X4IDlQnZII/+RT8H1oXLoa2lM6HHMSeafOaLtd2WB88m6hqugmXKxhPm+py2mcDqGl8pUzbp8fB/N49ORKY1g3p7VZUvSYd2CokNM9VpGFQu9BXy1IROT5zXKEbAjd4mqHjWKqzLPdnXPFlEf/k/KQTfqf0L2MMMuZMEq7OqkyGcMdt2MlfoAtUZRB6EFKB/tdodGC3d0PIaKDoAoNGfS5xELUBPnKUJDSFZ1tGj/kqlmnuEkzRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2TIn8d+sBIWv61rKXwlyHU2imkWRJSkhcC7KoRMErQ56eEgHA6NB3rY1MmGp3Hcrh41ULtc7wIKoni7GvcuVyXunAkfOe78cyPKwMdYQGtFt+6dRIuqAbGS3xoFrGJRR5bwDONWVFcy4Yw6FrB2V7ACHcyJ6R3uvP4X8qbAlewMg8/rBkPOxUWCVaodc2IQ7DdI/D1OWsNiTIjZ2+Z9Kw5D57J/H5q8om6cQ19s4NK36bto5+5HmiBguAQChZmOD4x8Yx9KM2AoDQOQMeXyNUjtUCRoELUZCiXWiaKr+Ktm915Qbix9nIV7xYB6S7fIu0QdMvkrzxLFSShwXFdbdYWWUJC2QlbzOjq7kzs1qM70c3d0dmGpDiC/wWT65HuBuFZLJ7EvWg4nrDPdeCUUhJrvSePko2Y/y4V/1kihbtIioxz2BFxjzlLDC+PgnmA6G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:39.3314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c09cb9-29dc-4ff4-be63-08df0c81dc33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050
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

Add a modify flag to struct amdgpu_mqd_prop. When set, init_mqd patches
the MQD in place, keeping the ring rptr/wptr that firmware context-saved
into it on unmap. KFD already patches the MQD in place for the same
disable/re-enable sequence.

v3: use an mqd_prop modify flag consumed by init_mqd instead of a
    separate per-IP update_mqd callback, per review.
v4: drop the user_wptr field - firmware context-saves the wptr into the
    MQD on unmap, so init_mqd just keeps it rather than restoring a value
    read back from the wptr BO.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 63670b41c26c..d231d5d283df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -494,6 +494,7 @@ struct amdgpu_mqd_prop {
 	uint64_t ctx_save_area_addr;
 	uint32_t ctx_save_area_size;
 	uint32_t ctl_stack_size;
+	bool modify;
 };
 
 struct amdgpu_mqd {
-- 
2.49.0

