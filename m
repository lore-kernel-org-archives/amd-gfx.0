Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA21606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oYKBScQ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477911121EF;
	Wed, 21 Oct 2026 20:15:27 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4821710E3A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 20:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBG0nFppM9glG2YZaDZfPALN4UB0CFhlwacfjztROSdzPflUZB2unE8sQ2NCkgOADWCteMDDd7PkTXCyW/rec/Nfy3N9U38yLgO/jFk2UNDylIkYFgPk57dpVYsdU36eb4hLlavW/K5/rBbT82I4/s7BGkbvBUQHBToBUra8JAGsjsczwckIGVibuNghRte0juYTiU99VpqQLddKh7rmPOq+fXzPZHti6D4D9ujKLiHNPCwPpu4sSMOnFI7lf5xsl30V0OpXFEeCsSED1w3289aIW1/DZTFz4OK+ZQAhA+jCeF2sKfy3yfC8fg5cQQsv+aUjTLmG8l2A+SK2AX6ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJrXkHZitIZV9+SzrC8oeDwvpSkYCzqm/Q3Nbfp+2wc=;
 b=gbLftyDjo2JC71OpMAzqv3ptg4lfTaXfza+1L1wnzDD1ZUV/3m/IAIefHhUa/5qCMmNARjDTZBXR9iQ8C6Ksq2heqFxkMsp0MrJ6YjXJ86VsfWRfia6GSByAsGgmdbBOmiiJXiNAAn2N2z5lZHbgP6bNXpSGiEypNa4hiZhdrByXXAok75L4Zui8UFtqFvzVvZgD5+BgHAD4w83SKpNva4SwHhA9rKQXaLQchteEUmiVa9ugBUhr+naeY+L8iYcBr9HEe3ZXYbK1zKMtmYKlQCXgxZwwJ24atsu5EvrjZMu1KA/a29A2S0cod2PrOkohHmjUCHASvIY91Rd21InV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJrXkHZitIZV9+SzrC8oeDwvpSkYCzqm/Q3Nbfp+2wc=;
 b=oYKBScQ0Aj6BihvyMMhEslQfUEMYLOe/caP9kexIhjMdwmGYC/ssOGzicgMNxxADamRQflCI0zlzWB5BEeIq3cBLv6wJkGA0jQ+gQ/vmODIXa3MAuFuHqeHk5cBKg+IChOx1NE2hr08zDjv/e6ZmdIuKpCdKW8owBkYHPWoFrBI=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 20:15:13 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::5e) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Wed,
 21 Oct 2026 20:15:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Wed, 21 Oct 2026 20:15:13 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 15:15:09 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: add 1 to to result of vram_lost_counter
Date: Wed, 21 Oct 2026 16:14:57 -0400
Message-ID: <20261021201459.715423-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021201459.715423-1-shahyan.soltani@amd.com>
References: <20261021201459.715423-1-shahyan.soltani@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a935be-6c79-40f4-5878-08df2fb003ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S2CZ+w2l7Rf/Px/HYmiwUEj/Qid46nCazIseCJubc5Mv5jknWA+6k4jrQqdL+DqA7ghQX+TspgXqYIRRhbfpTy1KV5Kpauj1idFVZIQ79/PlI1xoqH5YRQW6kFJqTj3XAsfVL0ijOQ8Jtcaddu7pZ7CwKgMEAxkNVMk05nTPnll/4ljBnR8uEHguxS5/AtRiQBLBWNS2kH1cCEqRjWovZm3xL7PKwnKW4CQ1uWN/LOJNDgmW1xG6trW3OrCTImo4aj5yGXobm4ulfPSVDmqAPfnA/sG54rseGAVwDL8/vde0jVUAPYAlCTZRjNgCe8LT+QfiiuoW9rOtcAEYzlUHmjQDq3Q/ecHa7CrFcdnBhvyHbRVAd72UneTEFpJvIkZo2o7QpdpFIxPMGONCTRrg7IijpLg7eDvqq8QiAgSx79ywBl5Xg899Zr2efJWR7MarZ4LtlQ/vN/mwwEyzAd0YtkGE2/0TKukKlD2GLvJwKjcEHzqWHeVbRjvvMUssXD4p7bO7Eh5iW3/8DNZehtG9nuWwfv5g4n1P32nhznrbec0OTIEW/NejPHBuuactNDZ0IXX59ojORL3b/clGRJ3U296np+n93b7UOUvn6dSMYtqI8OlnInlFP+sZZ5zra602Ql9oQpT6u0GFJL5haE/znmyyD6Aeo4WqK7f5+OnknQU2e2lfs2DFNNoNC08ofa5xtJtxoa4Kn4qtReANVw2pWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rIAhujPqEatMOWczOEZYdbspw/FFGSuwGmrha9MFre5k+550DuxJs3f+CD8z4XDnWuoPPfeWzIsjymd27EjkkmB8OBPl0jL1Fvh1UOxgL/g4O3f9mps2On4jbHXF5QR6t3tQRosARUISxGof+u4/j8A8Mt39oJPycDLCra5qDcMhYTbkz4+DT0TPiSrL5k+Vb5KVoq+xLtFmDSbZhV++z+cl6cScXR49msEDyBmidrlHuYcuc+Jaw9+6F96gAWXuVzZnBB39lMIf38I/3p51ULzqXXn3Kbpzdz4qXMdNcpq9bdRA1+8CPWka3wkVRaYXZSljArAqnJQq6VK4J+0cScwztsPHCEbH3Va71uXgP7fcZ/gLQACPtGX9bCSqiphCqqQIm7JXhVqI++YqMnLxq4xXwfuEEq7/oAj1jWA4v95iQJa1hUwxY05i27S/lzfV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:15:13.6035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a935be-6c79-40f4-5878-08df2fb003ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
The current implementation of page table validation does not process a
vm->generation != amdgpu_vm_generation() mismatch if vm->generation is
never assigned a value. This discrepancy is due to vm->generation having
a default value of 0 on kzalloc.

[What]
By simply adding 1 to the result of the vram_lost_counter, 0 is never a
valid result of amdgpu_vm_generation(). This forces a mismatch between
vm->generation and amdgpu_vm_generation() if vm->generation was never
assigned a value.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3f19d03fd7d8..1843b9d7bbf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -555,7 +555,7 @@ static void amdgpu_vm_fini_entities(struct amdgpu_vm *vm)
  */
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	uint64_t result = (u64)atomic_read(&adev->vram_lost_counter) << 32;
+	uint64_t result = ((u64)atomic_read(&adev->vram_lost_counter) + 1) << 32;
 
 	if (!vm)
 		return result;
-- 
2.56.0

