Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2DEC88E4C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A0C10F570;
	Fri, 11 Sep 2026 08:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uF4aM9Gc";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991D210F570
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 08:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsbnqm2BfHOxNwngreMiCWVneEypItGEBDl4K4hOrUF/0yu/QK1u/Lclunm0PbXqKqNgyv0ZreVT/ssFTrNmK5TP3TapVmAfFmWz11kjLKiV+vB3k3jm5gjVGsJv1lsNoQv1yACfhfWzNVi/dzRVPAA64lG2kd4PftgyT/5XR3/xV5NgRVjl1IX41UXXsoRUJVvsL6LAox4mw6nbZIZEOd0bGxtl8sS/JN8oLzwNnm5kB/FF5tqZqW9+moDDOxIT9SsxF1TgCb73p37HBRY8owqlnKDK+JiGIJPbyZEqbO9CmywsoqwVZbG4qSGFWVZOx6RUaunfDg16kKRe7zxsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx1xKDv29gR/IM8/fAKZ98luLGEauUxID5ynp1hg8Ck=;
 b=qbkd1m7BQwtPOhBQAoT7gL5CiNz2iwSg558VYupEpQFTN5XcZLBVGOzDe/0+Hm0AtTvo+Tm5j5yDmUmPxNIsHx3yfLhFo73PE7OG13WWl2Cs8ajiRe2IBAbDFYQCEuIo7LpImWVXEz63iYEb7p7iliptw3/5nXFXXBCQaxktQYIIEGvLsT+w0jRHiIPEk7SE76beSpf87jRpoeolpuVMg1Sr9psGFwuA16xR2ZOkK5Y4L48HkZfnwCt43SSEsi0aFqejCFq8GoSJZaePIDyVPY7G9DjLeaagnNBS3QjJETEDsMBr6thdbktROVAjb3eUkhvijJxA1I2e7Jy5H34yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx1xKDv29gR/IM8/fAKZ98luLGEauUxID5ynp1hg8Ck=;
 b=uF4aM9GcECsg0nlXt3tPHMxwIVKOSXpsi1+y4pODVP1bWE+zVlLIapbKJZwq2dUw0bdYlEwtQF/AGbEPPs6alhD1dmYcTmEpI/eGA4Xj/JN6VF5pfDOJti5LxZxOv3uX+AGNrUV4VA7yMBWyU2KzR8B8fMvsYxsMOPW6Hp99DiQ=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:22:56 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::23) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:22:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:22:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Fri, 11 Sep 2026 16:22:32 +0800
Message-ID: <20260911082233.694414-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911082233.694414-1-Prike.Liang@amd.com>
References: <20260911082233.694414-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc8dd39-f3c6-4df0-8f76-08df0fdde1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MvNsfSO2xUlcOxmxCb86dwzvoF/xtK0A2myd94CX2c70FBvx3K/Pk9XC2nj8ICGrv0fvOnErCbJpDQENWBC+dnbp93y7t5UszpBKPV42gafUO/1HP6tHXMkPIVF820OYBex7jfd4K99zFyGJCZqq5Xi6h39MRoC82EZ/laDZd+r/aO6zbSNzHatz4D7MtbVjn8SB1nbp8I1bcUC7S8MlBCCEDi2Ai2F0qxrJbDbeI7IaI6ZxKHVICJIrMT5WcjfOor3w1iUqZNfoEsSDsbKT1VluY4jexdOpnU95BYfrhbC95YOasFPuK0biHME7TebpUY20uuObkaH2TmcRz9RPVT5B0wgU3gsBumpGT6Mz/I5E8KdiiJGnQyrR7ZjzoO7gp798Il5ZS92lvO60Hsak+F+n4dce49KYI7XM2VxPQ8UtutI5QprQiG0ayHzoMWdlKB0KP+e1rycAgUiKIb9je5PKTfPcQ66Modb4gxg2rc/mH9FGbiQP59X7I4zGnnKXdV5swYCt/ytytqENjffr3KaAHPmLuIN+As3aOXIGVHN8xy5WFn7Te6HQ8gu3JMV5OGCXyw6NtL+BePu41/r4qogXNJJCEXoJGXRLTPLzlEvcv3pIKpGQSyrg5p3B1LhPD9aKY0IoDkrfbWQcvblCn9QTrO8cnUpcDf8ABrgto3LnaYvPcHF4RinOvsjil2LpGYFQoPPc8nJv9/hhtyFzdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0PEtY0t+8S4HLNsDeSToU5pxLclBYzeb4GzOeIpHqL+4Gc8kaav2p+Yv0CIY2pIqQq3h6h2o6Cw9E40QkeE7hmFIu7jdq3dYGpaWpnR6B/xp0hGwCtFZejH0wT4rXU8oc/3NrOTG4O25Hst/X5LSZOLv240JDRahf5zjEoZB8fvze9azMGb+wvOv8a9fgFnR2fkMMOnrAHTLC4PWZhNyPzlh8cPXFFttN0E0/WyNKrFq0Z8F6LhiNlIoVqhmFwpec3yfEh15PXoWzkqq1ahynhkHTz2x2E6eGldCDUEwhZmHKEDERWOtwR7By4xygnBG54bky4JTOOlBdF5ENAPKvYSfgM81MYluuAWL9xPijBJ6C8UGP+i5Xcv2nFL24WW7559YJRV86uSDU5V7Q02RF4kw50mOsnJn/k7SmylFA/mbRZpJclA49weqIz/wy8w6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:22:55.8724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc8dd39-f3c6-4df0-8f76-08df0fdde1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1be5e70dd4e8..6c92575213c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -835,6 +835,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 	amdgpu_userq_put(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

