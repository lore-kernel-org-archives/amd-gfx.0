Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB00D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 14:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874E210E3ED;
	Mon,  1 Dec 2025 14:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQapu58M";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D476310E2B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 14:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I64MQZ6Rzag0bgFeSjIX/7nVX8e4kEmSjXu9Wz2JJWyHc054v6LnnlrgzRykT4MpP4bUf9naTwQX/q41Q67wsC98+ZkAr6R+0oAHiu4Ag+Fa26/ZLM6RG2Nqs77814FGmWnv0mZmXUMKmcWRUHkrofFHrDqZhen+Au5N6dywp98nwKkTfMv7DLznDj7/ed4iedFgqaiFW0KaoroVZIxhQ5TyLUD9+NcFTn6nuqexGSOHUOsiXkgOuQKE2oIi/rR0qfrcvVCYhFoaXCnzUz8oJ06Kq0j5+12gV19By0cQ7awGkNNoxFBKBNycOkC7LsFz67xFKuezYprThym+9b536Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGkviboNapONsM39vSlEjCtL1lx13bAOmdiJrooMiPE=;
 b=RjT9asoJ3p7UHf1WIMUWsq0sraHY4c+e66eefHc2Ck3l+HNJOyOCVqvsXSzu7S+oQALYRjOUUFE3VS3SfXDXnMpvr3YFRdKPGUAOrNe/vszAzGhV5CE5PmIqzLFe4WMiFqHowmCXACYyH8pGDQFzuA/nEM1uEp67j9vHfWcDvcydk/04OUJqk9bd2dNxq0xxkvB94QBu/txpHg+8Xs9wnThdMbut2VqMtDI6tPySbO9rh5zDE0GqNNS+2GFhVYA9Ax3lopXltPP9F7gSQYbUwaQLeWOfaCTE2uvPjLt0yiN6NAvJIqWC1prp1Z6NE8t6CQyGO156azTC9th6TYFEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGkviboNapONsM39vSlEjCtL1lx13bAOmdiJrooMiPE=;
 b=ZQapu58Mz+xEjiBk6Qn6iMYqvsixL/NoWmpmyw8AreDrwyXwq9VHlh80kwdge7wjwMCo6Md5hBkMbX3lJYtUq9Hv6TlIMzqGZQKQGVa9L8nNG3i5TbHyGbDqJFds2TQwcUrG0Ig5Xo4vn+tc8YkGTskk+6kXtA7ue9iqVY8eNEw=
Received: from CH5PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:1ed::12)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Mon, 1 Dec
 2025 14:28:57 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::67) by CH5PR02CA0019.outlook.office365.com
 (2603:10b6:610:1ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 14:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 14:28:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 08:28:55 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
Date: Mon, 1 Dec 2025 09:28:37 -0500
Message-ID: <20251201142838.1516452-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201142838.1516452-1-Philip.Yang@amd.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: ab120879-dc3b-41bf-3cf7-08de30e5f686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pHQ98+fksMkzNGVEtewKm7vAVl/uelT9UrzAYCJoSkA14iJOrSahtAnshZPe?=
 =?us-ascii?Q?lXNkMirpENk+s18euCp4ziAZF2eFpzXRXpOFnmrkAe6TZBO8R4+p3o5ptDb1?=
 =?us-ascii?Q?JC7bt1HnZ16Jn7gM6Zg/zpZ6kQQy/Ek9/qUenr4jsiDPEV2WY9YklS4/zvlD?=
 =?us-ascii?Q?oJFnB44pyhdQIp7sXaltCtwqNpeGg79DHFwSvjN4hRWzr1unrGa5Ai43vA++?=
 =?us-ascii?Q?XdXjiMUs/qBBclF0d7KvaHibAfaaoENopCKibEqjpCRctq/1vD6yB/Lbwsdc?=
 =?us-ascii?Q?48r0FPSOoOa6lHnCN38/U7qVEpwq+lxh+e065+hgkZ64rEY9lP5Clygpb2g4?=
 =?us-ascii?Q?1/MWrcTh9Z81UwMAImQ5Mmh4EtA9xLoGn8XKpT7mlxrQDh873XTkWxF6nKUG?=
 =?us-ascii?Q?fzC1GtzxxEP2tm6gGNoxQnT6Xh2qEUg807UW8uma160jVSfTIiosu5PLVgUW?=
 =?us-ascii?Q?83eE16NhVaD1Zk2CwMHYLhJpeyX3YP63NDiZ1snxMJT7y3QWsdKkBTyaTnS1?=
 =?us-ascii?Q?zFYIjrg4FrgXy2jIZxgBn3XCm9sok+OiKhuUygZk/oOuozFcSLg8QZ6631Cm?=
 =?us-ascii?Q?tkN2hk9OLNxYGb2MtG2C8u0geqU941CTZqWHiCNrCGNyn/TIuGvr6V+ii30W?=
 =?us-ascii?Q?G+npSkrii41Qd7Y+DECKescHO/II45A6IqFoQwn0D4YWSA6/pLn8k6o1RD00?=
 =?us-ascii?Q?aUFctvGiE3h47195QmyYT+zjvmTL/prwJzJ1p/gtQzLaEbSC00dzGvgS5DWe?=
 =?us-ascii?Q?qbWDIBMlziZJTrWVoc8DCZjBUKXc2gFWNtNK3+Wtg2mu6RiRqbS8/2UIiWLC?=
 =?us-ascii?Q?Q9Ey9xrsS7atpxEgTvEqyRXZGRXtJOv/+7kZ2bnKrwPkbeJrAcmoGsXyjmW0?=
 =?us-ascii?Q?ZFGYluQhcDjmRaVhyCjkCmtnYw2LScyQx1zibEPihDv9dzycj7kr6Lkc7SW1?=
 =?us-ascii?Q?EoVxxPhm8OOqhxrBn4P8BU+w1YiizdQaWNzwOvPs+YZTI7snW9qZ5J2k2jWD?=
 =?us-ascii?Q?/1gUG/azilbC8HlhXwaakrltzsCBetOsRs/E5OjSXqwBrPx/PpboFzmPMN/D?=
 =?us-ascii?Q?ik4Rnx5Vqo8b5c2alolSBHFrDCV3ck38WLEeNSym/HILLLvrOpCH/9Wc5DzD?=
 =?us-ascii?Q?R0WK2FqKgo9JdEQ6qFojWkIHrmJtp+8lDFlfg5ps9/xKOj3z1Lp7YjbcwQi+?=
 =?us-ascii?Q?dqkdInAt2CFJticYQ9Rw75MZQdq6lBAjNP7RQVsxAZN2GRhMibG2DE91dDIg?=
 =?us-ascii?Q?jz9MybgrPtJlZlifK9yTlf8RN/xdpZX+wEOyKnVqxXRtMZpzuCO992aily6W?=
 =?us-ascii?Q?Zuxs31w7H/xeV4LJm27DfLvUIG5NcQ0zrpHjWdAyAZFCnHSSnCejEYdF0HdZ?=
 =?us-ascii?Q?0cdQrUusIWpzPChdISxmPi4oK71ZsThePPHH5pCQQXz+BTGGwEsQe32hfs+Y?=
 =?us-ascii?Q?xiDJ0SEKM1rHdS7+gNfh4+4ArCc8NAWQ3dSJCoU+CU+u/29uEIhauT3gqROz?=
 =?us-ascii?Q?549fLq9T7H49sH+SsanIKaUNbPEiqZDHbGNvZ+QqH0VsPreMV15iudRhDLnX?=
 =?us-ascii?Q?1WMjrpPCikUgX4EJuPU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:28:57.4278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab120879-dc3b-41bf-3cf7-08de30e5f686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
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

To reduce queue switch latency further, move MQD to VRAM domain, add
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages
using one buddy block.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 9cd1660b8f60..c11e37915365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = domain;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index a489d43d5f64..c6945c842267 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
-			AMDGPU_GEM_DOMAIN_GTT,
+			AMDGPU_GEM_DOMAIN_VRAM,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
-- 
2.50.1

