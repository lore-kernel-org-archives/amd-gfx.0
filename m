Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CBFC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5F710F4D6;
	Fri, 21 Aug 2026 19:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8O73a2O";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FBF10F4D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRNggk0C0m6DKYudnROui51tIFh1ZSLfdrkcopV+izRJRe8YTg7XaJePf1rPLkmKwz/ltq3kiiNKoexnk26DU/X8EHVyyQemTu4Bu4nTuA1ydE2HyVJmwrC0hTJ+k1/wBkEsSr4Mn2/tUjdMajp4FMUPhmwzXf5C/bf3oAbJyeiiSgKjSP71OkR11k/9HLR7sraTjdyZIMevfnjxO5I9uzZK2Uquc3sueOT5ILkYUUwsLRIhQ8DBiv4V2WWqEjFwfJEVas6+Roo24Y1KIBOKfgorLxRH0mq/IUzmUVcDM0N2BKBENhJUmXVVw+MFvRjM/4Aepv0uCL/udM/5opafDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3NMA4jOKgQoWskqmGyX1im4jZ4CIIgBlij3TSDO9Uo=;
 b=C7N+AzWpQ5Rnm8QIMhRLbTWwfP0RNdIc2wL/Z0Z7GG2F19ihX6fv+NvWrjj6eJHsRnEHAIzmUhf3GwpboHQzUTWKACUfLvBQ3cGh1MPgNpbHsPb8tHu9yX+6Z8Ai86c/5Km8S0B/kUnFchA5qcvKaNeCzH8ARkC52022yDl4WpAcSTRtPTALRTjTLkCZWyzvOmqlQb8nAPJBWW2GcSprBJTRegk8z+Qyy//qVX5nwMPPxEM5HG8wD//eoSg+6bF5J+n5nTRZUuglA9uDsJrfTT0GRfyFBChZSXVIj7mSmw+PhXeWKOGisdou4HoqpUn+cJ9tQmS8DaE32CXxJy+/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3NMA4jOKgQoWskqmGyX1im4jZ4CIIgBlij3TSDO9Uo=;
 b=T8O73a2Ob7xDTFv/pmUSw0zYjoLfmxE5KFy2p2QbK4ydbWm0FFMzWRVG0QYAbWajq1PDrxaFZhWVGAOC/hxHPQL/FB2uNQjazfHd840sV+spAhPKK+/d70TWgUqC2Onx0O2v6Zzr18qYjOH+Xt50a+KCUGnr+7ND0LEPgexLOjk=
Received: from CH5PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:1ed::22)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:01 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::5f) by CH5PR02CA0010.outlook.office365.com
 (2603:10b6:610:1ed::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 69/95] drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
Date: Fri, 21 Aug 2026 15:34:32 -0400
Message-ID: <20260821193458.808626-70-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca40491-bcc5-4457-c24c-08deffbb6e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YH7uHkl0NfNyE+UJFhc33zotHv2TRS1//LyPPBL3BUPdBUWTMBRsPWslSKhNJZTHgDVOnI2SPCckeFWWgQL1nxxmbb+omic+eBOKHuB2BLI7/lLB4Ys/iKQYVWj0kU4b/5ChVBk1/TyXjxz9kxZa6LsXrWGqKpZFnKOCKnw68PDz1IGdP70BlIoxMisMc2ctm0e+Qb4LK+SID7/+GJLj6x8ouP/Is7eWv/AiLagaC1q2fCuqkJWxvb8e9gOYqcxK8f8Ab09fm8rauE7HgtIqhOL4JgghwolaPQ0+STRq/nTbj01ufDYdqRh1k3CZ0CbSsHfTD37G500uMBL6/Ii0+VOKph3kjjKqdqebsR0eujk1I3bTzJ80WV4jQCp1aQ29+V2goamS8S6a2Qnmzls1LOnJ1oJsHxWhT+GcqIOH/IyIRJ1NxCZG/VcMLjJ3U5XKuuFSToT/z2Sq3n8JWu3kwTuAhUsJciL8OLjiYuxSIzXJXuW7nQB3t42MXfHRXmds70lRzUHNHPZRHrro0eWeiPzcR+OpC84gfujBSWgQ3zkGep5wM18BfzJh+6pL8mNglshOG6bG23v6hUcFFUG4pssRNECr8FH/aYeRxwme6ByR45S/XF0sGKi+Bn6Q6clQVUSJXR361d9IwCIt5E9JhbWetJ7esN3EZ9gVuo2fOz7hgXeT0W0fWO44LlMVqpPHG4eZGQDMBzuOOTQKRLCU9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zurVzETb2HXyrJZTQGC7hxTRNXo5NyTdZQE4ikBwHtL0rmSafaZZURDjHDp8ewF/BtO0YhUAS/56NH/urYkKRL2OGsdNRh0qplzK8qdWG+kWZYGuF5VkzSk/OuQQftQDT8mLWrOkfucab5bDHbXzlCsoOv661K2NxG8iBCoML3T2z8yz9qp/flZIhaCb2YBXiWqmx2nSlBL9YX3HDoKNQB4kjYiT4GWZXUGxV3rdNt2cc0wJIOd9bg2aH66f4QUNTy0iOPrQJHffWAqxtrAo0QvFsOrtQYkaIFyNKGhlCvfCUQslSw7HT4iYOvFj7MaIF90UU4/2rcN+Zs2VcXQ37F3XdPNDrOwBGu/GGexJNlrVLsxlPUdtNZjqU5/W1q0elB978Q73T48W5yJ3MgEBTbnUqPaLxafKs9e5tUttV5m9l9zXR1vIfYDT8wrHymey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:00.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca40491-bcc5-4457-c24c-08deffbb6e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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

From: Mukul Joshi <mukul.joshi@amd.com>

Initialize fence to NULL in UALink NPA unmap to make sure we
don't end with a garbage value which then gets incorrectly
dereferenced inside amdgpu_vm_tlb_flush().

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 147a3744cccb9..0edfc685b70f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1443,7 +1443,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 {
 	uint64_t pte_value = adev->gmc.noretry_flags;
 	struct amdgpu_bo *bos[] = { bo };
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
 	struct drm_exec exec;
 	int r;
 
-- 
2.55.0

