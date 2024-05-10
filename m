Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B1C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 04:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FE810E027;
	Fri, 10 May 2024 04:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dW3PTeSW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71DA10E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 04:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8IMv86jKtilFN48WkbKXrCOrtqT4jtO5guNNk+CBvvxnDNmzBx5oBWfZcluCp9zllfjqUxJnnRH/JqIvPCjD/rZVqM/JyCdeigwD0QsQ5VJ46QluMcmVxTYaPzbxD5KMjzpgdUYFQHPuNNZ7i6HHIpV1ABiFiabVZqETqlsaD72QFDz2LpjEVYVUdBVxKcwhrFH3ByzXkaE8/DOr1gCEzpnmB9f5VGBk1VaP+185Q0oscLe25MVfzuTlj2reFrP7qUrV3g5YkTYotYJpudbK6W5FrTUdsbh5RbkbBHh3zayliWYVTQmb/5pUFepJQLqe5h7SBn3wmaxv7vYINwjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auRZ4bLyMSmWUdz0sTVNxQ5B9+q6YYRxdH8NwUlSEvQ=;
 b=OlImNGPYR4cO8/iEEX3+pqdeJ6QbVz0keVqx/ovm5bnuhHOePY7Nk/H1z+/Uc+AIyIa09IuzVMTinzFKPDP4/kxz+Tt1T9tnM83t+EfrVIe7f+XFP79MYauZnLiBphGzo6WNo7Z+jMitaN6BzdJQDmYh1crXKGYsTKEmHkq4EMivsCy/8ITOrsl2NZ+n1yplzku+gFHX7GsuxF2hK7L5yBW8Z3BzgbGILaOM0iSW0AHuv08ktIvjpZ2iM4YHFb+8nvSZ9lG5k833kb2yaqdVhZkaB94mfQnNoTXe4iHuG5kxTFC1eqJx0QXcLogPmHqfiKMzctnvQZrnHaJ42RGaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auRZ4bLyMSmWUdz0sTVNxQ5B9+q6YYRxdH8NwUlSEvQ=;
 b=dW3PTeSWMHZRDsKnWzOfFGHonw29Blm19r0I8GsVrJwTX0Cv9jg0TmBg+IFwgqm5AI/vM1sHsW66ijYE2UKtZIVkuwoh3vNGnztNYHE3aETCG5ObQgA2fmyVmuX/IfDO7C+rCPdHU3428LfVBPwHZkC+YXiSWuvlSlo9OZnP7OQ=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 04:56:26 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::8e) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.13 via Frontend
 Transport; Fri, 10 May 2024 04:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 04:56:26 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 23:56:25 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Sreekant Somasekharan
 <sreekant.somasekharan@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
Date: Fri, 10 May 2024 00:55:41 -0400
Message-ID: <20240510045541.533908-2-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
References: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: f07ca1e7-f9f8-4520-afd3-08dc70ad8c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVvtG+z6CpPCCez6iCRyO9UPOyQ38nFAhdnMWGnIckev7NDKqQLUQj6kGfGT?=
 =?us-ascii?Q?JhLoObXseuS+1wIS0ytrOaypzDWDdRjT64ANPEIehQ0QqdZfaR98KST2iRMR?=
 =?us-ascii?Q?v1CojjVrLufTZdVclnhmzEq+gbSj0ifZLg1YlcZ7jm4GJnnUWSRLf67EVkOe?=
 =?us-ascii?Q?+XOzpeeSlGSnOvxkoNgvcLa1b9Ixh3gKbL2as1xGH19a7vCgvEHt28r1lXi0?=
 =?us-ascii?Q?o8xXhQkBKHo0np4RPAakOcOIhIX5Ozp41eTbGGR2C/zHjnJkYtZ8hceDmo96?=
 =?us-ascii?Q?waQN4k2zuThHowD3wCWzThbO5DfO9FCZiIAFAUJxriNodHDnPq1WpxHKfNfc?=
 =?us-ascii?Q?sgX0pmrdgsXuf0zelmm0JZOKnJZZnEm3w8fGnhbx1kF623iE296ErzPndivK?=
 =?us-ascii?Q?eI5eHwxjpqGq5M1cQYJs8PZZnRinf6jjK27P7U+AN6OH/joE5TrtktHGoI4y?=
 =?us-ascii?Q?LSPgf8iXL5/AppxnEhKwgCZTsQ+IeStwgMqDScDCseAFA8PtqKLu8DHkye7w?=
 =?us-ascii?Q?L3luX7C7SHQrax+T1Vcb+V/wnbo+AETC6m2NZuptMoUFviCKhODHo6DHJT74?=
 =?us-ascii?Q?KidO9+c5XM9CHvO8wSUOqWYhHJ4CpXUuBqDLPOIBE/QnqVUdQchKZGRWRBui?=
 =?us-ascii?Q?aUn2b0aS9S5RU9uzKqvsIty54KFd6K0K0dthmmPF2y09z2p2r5ZhmwudoOF7?=
 =?us-ascii?Q?YE2hMd52gSXhJS377qcfZmvF/XSdYqB9V+pdwEULr+7hX9Ik2nObv2iphVco?=
 =?us-ascii?Q?AmKuGyD2z5mEn/FUjJVMITVMlGXIA0HwBjVPWAqBNHvMnU2siP6LFxYy0FLF?=
 =?us-ascii?Q?5VFqTpwSMRq94qAUcCyENNFqmIs80x0fUwvv7DREhKzMevRG+kwPq/nlcmNU?=
 =?us-ascii?Q?ryjUIji/uEOUIQC68afjvHA/ykgC7WlDRfQRYfCTXdTgGePfHOJMJASfVeab?=
 =?us-ascii?Q?d5O1j3WCFTM4DmKeEtihC8EyqPX3POsFfZLssRGHlgKIi44i4BZQxaR9k1Sr?=
 =?us-ascii?Q?K78nrSw3k6r2yEUL82Oy3RDD3lsXcAgAusRvI7X153taL1+iUkOGwDhL+Nzi?=
 =?us-ascii?Q?MF1GxpXOLXd8MFe1yLV0RMxxLEKw/RPc047t9BqYDlC+LX7qLvlo44ReFFmE?=
 =?us-ascii?Q?IkvUkzKZXZ+c/BPy86ZsO3aHMnPR5KKggMUh8d5CvfIpMQFFsX8z8CCvDIro?=
 =?us-ascii?Q?5FLLRDYzo6zg9ZtSvDvKvE/4D3kTD1E14p07pIGwWSy1BBOX8u7yzF7J0w79?=
 =?us-ascii?Q?3SYd/S+n6enOAi9yKNfDtihl6kMBePnXVdc0oqrkxw7teh7ObN+OcIwY450P?=
 =?us-ascii?Q?d06kbXW8LgXjGne4YwrUsgK7JSiES9ZtnZ4ZGAiNp4wQ+bymBtYbFnjvwhg1?=
 =?us-ascii?Q?AN9RD/ry5EHfcuh2618SOmj7gJvz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 04:56:26.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07ca1e7-f9f8-4520-afd3-08dc70ad8c41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

This patch rectifies mistake in previous commit:
'drm/amdkfd: mark GFX12 system and peer GPU memory mappings as MTYPE_NC'.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index df0363ad1a51..6eb370609d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -495,7 +495,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
-	bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
+	bool is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
+		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
 
 
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2aea33d2c4d4..6175800f50f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1253,6 +1253,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_node != node)
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-- 
2.34.1

