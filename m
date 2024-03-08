Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5914C54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 16:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5A011390F;
	Fri,  8 Mar 2024 16:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h63E61ac";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E82F11390F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 16:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVjj/lCZoD3hAFrgUSev/Ixv/xaaEyEYllSDKBsHM0UvQ9FggKbpyMt/CRCDHfzBjxgA+Q9iEzn8CzF4VGkx8LeQuuayx2r8LA1N7RWuEVJeoAHRdilJ4zkBtY+3hhOokw9KXRgiVgFpjHnTk3ufChWMiVP6B30uNSoJd28xRjm5+zf+qX4TKIBZIWjhJVStciGzKltSTjuv57OIS/VmmlqNLeJwEVDrS6O7UAUkw3Eyh7AxmX72mnmB2ktGGvuLATFSUgkoiMt4usR9sadIf/9StX8Jwv5PEZ/y6e5lCK1aNzN3fEPcigTlyyl7gEoEyBsFKDD89/LerRqto3gnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6diLFzMLoD+3CLySiI6VQ978kuhSyRQDQqmCKYkSKc=;
 b=bpKmugR7EAiY5UgDKHS8eJZqWVOKuN1qKmLpEaHmbv1VmRwlBkXuXInRbbD2vTVUGpTwJtqk4VUKy+t9Ej1PxvCYnoYyPLiW8XX1Z1BaEFgqNsgORosVkjk48nGpD8E48ZC1bzhktCaP/QIZtHLuZDwlWtF7PfEnOYosvukXHGkHNINJmEyJ3kuKEq+dpt4EJZuWqoKfpGbfHiuZtXv6pWlzmkAcqkLl2owZBVYudMtBcZLmHn4KoaNklSwj6NU4cwoFOvdZs0hrE2MHJo6d9ibxJpgKBWE/UTy8JE6sHlKkxPHV8R+B1+E3LbqI7guo/+5gbkYlp6aN75/W6fOfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6diLFzMLoD+3CLySiI6VQ978kuhSyRQDQqmCKYkSKc=;
 b=h63E61ackuluvWLq3DiEl5uOa7sDww8DtKmc3dMblavRLaGXQra94xMzCOMVPPh0ZSKAH9VeKEgkdfo2hqjMBfFls14jac16nEG9y8Xg8bBmIaiWOdQD0674m/Jk4d68ngVtvup2ye4PGc+LvNec2TAtHq3P0QxrYjIth5hbKQY=
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 16:23:07 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::6f) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.10 via Frontend
 Transport; Fri, 8 Mar 2024 16:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 16:23:06 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 10:23:06 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Date: Fri, 8 Mar 2024 11:22:53 -0500
Message-ID: <20240308162253.264154-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 068b5dec-e208-489f-25e8-08dc3f8c097c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9nTYsMi5PE3GJIvNb20I3690VVmnKiIjRRQ+ss0ZlmcAziVZSIibPhH3mH+XHn/KV90mBJkkom7ZeNRCTVbD0Ws+71PTAZN2d+/0B/n3kIz6ff6UdEHg+9Y0YWMktWhTIwgdDMYEfaelVEEp2uztpngV5DGX4Uait0QwM/S+pGqihAArghLvlMhlpbjJ0hHb+PYy+d1/oAsL9RS31csHfRXDHV80PHxvO6mQJw1xLM8pTsW4z2843576hXWWBxz5zMkCrM950K2u66by0ePOl1PUvZfvQcH8QQ3CBdam6qghnY+DnL1QCP4HkHRJlS4ow4tQF+NvATwlAi3KJ5BHZaSzWpaoFevbRQKKDnRrNhre4+aKtjNgLD3Zldq6bfcK3Qfy8EWaufGCTYNWMjbE93e5Iyc7E6n5pAfLmjMpaWFQlEmDagAbFu3blVQwgnrbDrH6BBS9IjlxiAFAfu5B9osLxIde15QQccUGp+Rs1ryBZ/inrXkdSKu1/y8rRxSPij0LMUfMiefawJe6NJdwwuUZjmFlvcF69v+b5IhtD4MqtjiwCCh/L7oPYEVOlG4OtW2PSHSRezM2+0dn8bf4fbC369CPBTSeZsJ4lOhILqn6PX97FkfPSpN8dYsN6tCzA0RelOZBZrvriMfL3q4cBwR5ZSsQXK2gIV/HKnnWVyM9zIBS6XV2hHf3hVm7y4CCJHGRUbMrenBWRAoZhfgjOMrw0cC6ROLNpvsrD4b6cnxxMZ+owQ/Eo1h9oqRuSzB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:23:06.6401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 068b5dec-e208-489f-25e8-08dc3f8c097c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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

In certain situations, some apps can import a BO multiple times
(through IPC for example). To restore such processes successfully,
we need to tell drm to ignore duplicate BOs.
While at it, also add additional logging to prevent silent failures
when process restore fails.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index bf8e6653341f..65d808d8b5da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2869,14 +2869,16 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 
 	mutex_lock(&process_info->lock);
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
 	drm_exec_until_all_locked(&exec) {
 		list_for_each_entry(peer_vm, &process_info->vm_list_head,
 				    vm_list_node) {
 			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
 			drm_exec_retry_on_contention(&exec);
-			if (unlikely(ret))
+			if (unlikely(ret)) {
+				pr_err("Locking VM PD failed, ret: %d\n", ret);
 				goto ttm_reserve_fail;
+			}
 		}
 
 		/* Reserve all BOs and page tables/directory. Add all BOs from
@@ -2889,8 +2891,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			gobj = &mem->bo->tbo.base;
 			ret = drm_exec_prepare_obj(&exec, gobj, 1);
 			drm_exec_retry_on_contention(&exec);
-			if (unlikely(ret))
+			if (unlikely(ret)) {
+				pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);
 				goto ttm_reserve_fail;
+			}
 		}
 	}
 
@@ -2950,8 +2954,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 	 * validations above would invalidate DMABuf imports again.
 	 */
 	ret = process_validate_vms(process_info, &exec.ticket);
-	if (ret)
+	if (ret) {
+		pr_err("Validating VMs failed, ret: %d\n", ret);
 		goto validate_map_fail;
+	}
 
 	/* Update mappings not managed by KFD */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
-- 
2.35.1

