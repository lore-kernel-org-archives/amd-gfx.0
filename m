Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD988C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008BA10E180;
	Wed,  5 Aug 2026 06:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K6r64yBK";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A626210E180
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nafXl3jMHvVv7qsJfRbJUd0fkTRx2lGvomWTPDUVneK92hbvl8BdEwKYjQSOY/fwmIvy1b/wcBaMv8aSr/ZF38VJPGTs8T/QQ5S5PFth1iT1xxtAdFvEk1sG8yI3UZu7Xb3MFHNxnzLOrIgZxlc6W4t1wWUo7d7Ack9fSZmYgXZfbBeBNiFzo1LJUkPtNjSbnB+lZ7SZxOj32fwEyvPzVCBJPLZOx146nXMpCxDO5qyLq1Pw1UcgYuJwEcvVLL58BSLb+wq6YzGGO+GnYH/jOoJ3Y4ur9qsh9+MKcIIhp4M+rK0+Fy7hK8H8RHrVeCvq1g9ZC1f6XNvv9PNv4fSz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzWjdp6EQz9ri6ANOIHTFD5EwEHCvjwgGJ5Vc6X/Ttc=;
 b=GX/eywuh23hr7R+qe6hENt5RufO6IxZGqSRTJlrEGii5WTEk6jp/RM2Qc9OjHP6eMRNmOxiBIvZA1ea97XHIK1mpQ025X0S0LE+2vRasmpcaJrZBDvCeFEWhyb/pcuscyXi9Xhm8K7RNoGyyH9ovI/2cylLpg2q5mCUJejoKA5CB9HyFNadJEEydSr1Jn4bqAjUvE8HxsFn7JvFoSXDt++iUZUpYpQyNgqeXfNeHH1iaj9DenMzr/9MNR4q7CTnGDEeGXMydAxMs4a9xVc/77acclZz+gC2pPAj5xbm6uBPoK+kRMccL/GkjxMbQQJK8CUy5s3M8zxrBZ09WvT2b9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzWjdp6EQz9ri6ANOIHTFD5EwEHCvjwgGJ5Vc6X/Ttc=;
 b=K6r64yBKf//Rf/B1BOsHVXbLUeXW0g8CObU5Cyv2bmAoXJfMCNPLFkbmlHAkrgnl+UYnLFe1fmWEQA2xsTNqMtcQYFSoaMr9m9154fhyo+StEpcHv7qLNQ4qtTR4Yik/RTD9fhL6zsU5anTucfjqSzwse+5em0fev8peUroM3dA=
Received: from BN9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::10)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 06:25:46 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::96) by BN9P223CA0005.outlook.office365.com
 (2603:10b6:408:10b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 06:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:25:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:25:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 23:25:44 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:25:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: keep PRT mappings off the vm_bo state lists
Date: Wed, 5 Aug 2026 14:25:23 +0800
Message-ID: <20260805062537.3855188-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: c629d407-9d57-47d7-9e1c-08def2ba6187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 5KHBiElfswyyY5Z5g4FQ6fm04BERI7B4KMgquN9urlNbyK3S5N5CxFzV0y9hU0EMkHa/qip5aiZLkgTLFXn2s1boU/HXxiCsoKgJRGZ4BJhZ+exCrrqM9zHpOf2291IAbzZMvkwGvLlNpRs5q+e8SLJ1gWqIZ3DDbNg2Ur0NY8nbe7B5cNiSrouGemGhOQbYzH84RCTAWj1vKXAz77hI4+Eh37ziwAXjRTfC7fmOIrnzF+Bt8EMYvZXTRNeQfvaYf6FSjslw/FgEDoY2LdmPyDkHsDOUfD9lRN2X8ILT1pH5IL8bt2rigLbc/C2UjfOP2Zum9pZXoHY/afVtOdFsRlouH1j+yfexCIYh7LxwgUgYIPIuG0YBkZuH29O40tkE6+n/BKZiAd4M7DinqhJoGoaIFJDoHqQ5cpgAKfnUOYeyIByIW1q/VjT3AeLZbint77DbXH0YuTBBp3MKUnLv4qQ6DlfsopXaH290LVh3pjrfUzG8Zep2BZ88Sxu0ws/WlINk2ABuOS2hksUpYqYXnqBVik3TAzr+ohSzyIkcmE0hfGCTsdvWaa6A4BXawbje9770rHty5WgDK1yXFzxbUHa8HAIsJayCkFZ9nn1xQgG71BUN9+NUjzVsftThcWvM7DsCaTf9lJUOLmOaSbFHSZ2IIpChnNF11ng6Cmk/rkMHZ0rozAbr18lNDGYVQOa3i/BWB5GgD3GL5bSzcFSO+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4uKoJzuDpWlK/sxewSH1KeTsXi9Q6sCLls2hBku8Aer9nRR4Nb0TlFjBK0Bnpw3ZyuldTkC2urYR0pT4TWoIlIj2eYIwMwA48LouISDlTcp1NQWKx9fk3/Dk1m8xYkQ03tLkpprOtboDLJYLOG/Zuxd2O/vzH8RqWBwM/bT51HbcQb7n/heMhNRibZzM+XtlyCU8djD7iHDPljFjlkbzXHci2NvKPBnn3oG/ENIfj9bt7KlsWKgZuaynx9CUn0i054QAnQ1NGEdUntkNt/v8JTCd0p/yx2rtQbRJeF+6DNVLPvmLEMg9+YPt5ogr/E6gkSCTgUhBt2cvJAsNWIViaaZzPvow2k3YRzU0oiNDGjjwq2+RMSQXT2+8wHrK6/hurxo5LEzK2d6aA1e3QWhLVcqDmkc39HQ0JgWxGJVbNfu3OR0WZdrNQ4dO0Dpcw3rX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:25:44.6880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c629d407-9d57-47d7-9e1c-08def2ba6187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

A PRT/sparse mapping has no backing BO, so its bo_va->base.bo is NULL.
amdgpu_vm_bo_base_init() deliberately keeps such a bo_va off the vm_bo
state lists, but the tail of amdgpu_vm_bo_update() unconditionally called
amdgpu_vm_bo_idle() for the !always_valid case, putting the NULL-bo PRT
bo_va onto the individual.idle list.

On a GPU reset amdgpu_vm_bo_reset_state_machine() moves individual.idle
to individual.needs_update with moved=true, and amdgpu_vm_handle_moved()
then dereferences bo_va->base.bo to read its reservation object,
crashing on the NULL bo (e.g. the userq eviction restore worker running
during a reset while a user queue is torn down):

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
  Call Trace:
   amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
   amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]

Skip amdgpu_vm_bo_idle() when bo is NULL so a PRT mapping never lands on
a state list in the first place, and refresh the PRT page tables
explicitly in the userq restore path (as the CS path already does) so
sparse mappings survive a VRAM-lost reset.

v2:
 - keep the PRT bo_va off the vm_bo state lists instead of NULL-guarding
   bo inside amdgpu_vm_handle_moved(); a PRT mapping should never be on
   the moved list in the first place (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 +++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 770635ab5298..fa67d76237d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1070,6 +1070,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	/*
+	 * PRT/sparse mappings are kept off the vm_bo state lists, so
+	 * amdgpu_vm_handle_moved() does not touch them. Refresh their PTEs
+	 * explicitly here (as the CS path does) so sparse mappings survive a
+	 * VRAM-lost reset.
+	 */
+	ret = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	if (ret)
+		goto unlock_all;
+
 	key = 0;
 	/* Validate User Ptr BOs */
 	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4c90e88e2e30..02e2e576f154 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1391,7 +1391,13 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 			amdgpu_vm_bo_evicted(&bo_va->base);
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
-	} else {
+	} else if (bo) {
+		/*
+		 * A PRT/sparse mapping has no BO and is kept off the vm_bo
+		 * state lists (see amdgpu_vm_bo_base_init()); putting it on the
+		 * idle list here would let amdgpu_vm_handle_moved() dereference
+		 * the NULL bo after a reset.
+		 */
 		amdgpu_vm_bo_idle(&bo_va->base);
 	}
 
-- 
2.49.0

