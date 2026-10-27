Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BD606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c9aY8kcs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F27C10E3B7;
	Tue, 27 Oct 2026 08:30:50 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E3110E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXBKikRc4awKFT12dR38+fl5Mv5unLlRP75U30/B4UIaU4qVUTZU7W3u4+I9J2UJ2MLPS2smqsnMh9B3V8FRmMHNk1l8h8hhRKJUL6uf3zc8usD7NcsZ5xCswPDd+jxdoei+528jHXWUHfhkN/sPZ8iAFb15WWOLRC0rJfXLmiuxnIuz6TWVGxiPXs9AIGhIxOhkKMQJp7Gbwd8DhZ4RtGaqbxoObCOW2OZMSd6Dm7YKD+pE/YJ65wrsaWxAbM0+Vy+d/F2si7vyYpThnNywba7CAFv9mWiDA8cGu8UIJc4HxIsazHOdIJGHeJI8Wbq6LApDYR1UlbWAQIzFMftplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK+qFfM8bH9VoIPIHWgTVnHZ+skVwY9tlWyriP458eU=;
 b=vIbaKkNuketRuOHHRu7XRGWIWsss4+oEsLr5aGMb+b3e1511q7UxC95ChZN/z5qUviI76y8tvDjc+e6sXjZTAtRi6MXZ5x4vPSzl/aNokLRUWzRm3WV9pAxzZUivK7r7hHtQGAt4DDa/P/E1eLcicaZV/XaT65/JkE0aONeFdFA+e9SHKC4daA2gnPK3hNzRsB12hOmffIPVrrwMOzZLcmlPrm1ucVgIRN09oQbhOHR2xW61leGU341985bI7IZAkcVJmnvxxjbuJQ+DPgoHSR+gRpAq7FeBAe86UrferbIQxbZue5jqE7cik0laqL5DngR4d0AtrM5vw6n/voWTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK+qFfM8bH9VoIPIHWgTVnHZ+skVwY9tlWyriP458eU=;
 b=c9aY8kcspIrkcQhU+NraQ9B7hB5KjiGYztD7ER9CNEIEfUD6C1m1IIhdb2670bdat0C2NoZb8gdTWoJ0x3mtf/4Q9dC1oAIZzKMXxMfK0OeQwqXPJDRld9upIb6tpNh+wAOAp9j8zct3rNE1KSRfrA7BlQal+0o21ozbkbaGV80=
Received: from BN0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:408:142::25)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:30:39 +0000
Received: from BL6PEPF0006C3DA.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::11) by BN0PR08CA0027.outlook.office365.com
 (2603:10b6:408:142::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 08:30:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DA.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 08:30:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 03:30:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 03:30:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/userq: validate the moved individual BOs on
 restore
Date: Tue, 27 Oct 2026 16:28:42 +0800
Message-ID: <20261027083027.2776591-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261027083027.2776591-1-Jesse.Zhang@amd.com>
References: <20261027083027.2776591-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DA:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fd0a42-c905-46d9-dec5-08df34049425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|22082099003|18002099003|261026121527099003|5023799004|56012099006|11063799006|261021121427099003|10067099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: HQx/XO0lK1XtMJRGcWWpAtGNvSq4znyuI2v/jS3JdjaU3ly/k0vq2UGS0wFZqBKCzB32flah7q+uVbdIXKk6t8JOfiPnt58hYR60IzZEWCbxT+odkozO/qdLQ19Lo63qMEnXDereewvBj5KN7tzXWQSY8IKNu2beVDQEvTVnAs+7k3wsTZSTqPhi/eqxKwY0ZI71DIcUH5jwAFtZ2aadEpishu1hY4L5xmNS9wh8ZJstg+MryEMA9ojvaHgSRKq3azlp+ezyeJRg+A6iriZ/6duhOeSSHI8pRd3wCkPwmKHwaiqGckDZq26A+urW73NMIlcuSrEeNdlobM31YQV2euZjAlitev4G46D2AJ41rRWS7PmQfKIDsE0Evs+eTKb2l3ODG725kOgGA4TkVG017mtiUNH7O6qhxn5qPMS7QgJR8GXcam3hOP6Muh38SQ4rmQ9UzWknn93wNFWOX4AfcxmvS9Ew0nURM6eg8LxxSB6A28e+EgDzwj0vzG4OcK3Nv9dHfpvGq/QrEk0WC3mmy71gDXHPegMW8xREL4I8//uRLHwFOtNDVza3dt55ubzvYKkLofCL7pFBX56GzRuJnPDqcjXYPrMyTUZ/X8Jz8rMdyk6mPhxz3x0flrSF3Xl8qPBkePZT847sfVpGQKwE6Q8qYxw3+2lOFtQHSN3whRgu4gCsjDqE/byeKJgiRi6Txcerw5te5wPGabP7TBHf9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(22082099003)(18002099003)(261026121527099003)(5023799004)(56012099006)(11063799006)(261021121427099003)(10067099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P2wXXI5zWS53YYYPZinGNAZy+RGNLbOX07rCWTBLPLozxVHd3IYEInbFGYyCSt8yUbVPw/CeIHlTh01H9wuDS2GRX4snoWYVo6Hna2Xp4uUX+snk6B0ZsLsKvXXVdqj8o3b6Rfy/CnmNOI+bS/8wjj2Crs16kUSRZDT5BVFxkXQzvyuinVBEiQatF8SE6uJ7kTXbjnHuLryO8EBrN0BGwrFUsD3ULgW/771tpserA8rogZ3pFQSyozrVzsA0rzdSA6kYL1AxZJyXYl8RexhGvz5nYw02iCCOA2z8fljjLK8D88Ur0L3vFV77jpsFS6seeKNl8Pj/Ad7Ic3/VW5/Gs7svmIuUcJczPOhHE8nR/RGv3620Fqox0nOIMeEeWdJEanHYhfjdeg0WBUyn/K+4Vv64Z0bVH2wGspebNfc+qvFtMIJYrLGjSKcGPtHG+SMi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:30:37.9475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fd0a42-c905-46d9-dec5-08df34049425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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

An individual BO of a user queue VM, i.e. one which doesn't share the
root reservation, goes to the individual needs_update list when it is
evicted. The user queue restore looked at vm->invalidated for them, which
the VM state machine rework turned into the always_valid evicted list and
commit ea9be90a5558 ("drm/amdgpu/userq: actually validate userq BOs")
into the individual evicted one. That list only holds imported DMA-bufs of
compute VMs though, so for a user queue VM nothing is validated.

The restore then neither locks such a BO nor moves it back. Its PTEs are
updated to wherever it is now, cleared if it went to system memory, and
it doesn't get the new eviction fence, so it can move again under the
running queue.

On navi48, once the BOs of an SDMA user queue are evicted from GTT.
the queue faults on its ring and rptr:

  amdgpu 0000:03:00.0:   in page starting at address 0x0000000100000000 from client 10
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: SDMA0 (0xd)
  amdgpu 0000:03:00.0:   in page starting at address 0x0000000100101000 from client 10

Validate the BOs on the individual needs_update list like before.

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
Fixes: ea9be90a5558 ("drm/amdgpu/userq: actually validate userq BOs")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..15efe71594cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -991,7 +991,11 @@ static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
 	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 }
 
-/* Handle all BOs on the invalidated list, validate them and update the PTs */
+/*
+ * Handle all individual BOs which were moved, lock and validate them and
+ * update the PTs. An evicted individual BO lands on the needs_update list,
+ * the evicted one only holds imported DMA-bufs of compute VMs.
+ */
 static int
 amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 			 struct amdgpu_vm *vm)
@@ -1002,8 +1006,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	int ret;
 
 	spin_lock(&vm->individual_lock);
-	while (!list_empty(&vm->individual.evicted)) {
-		bo_va = list_first_entry(&vm->individual.evicted,
+	while (!list_empty(&vm->individual.needs_update)) {
+		bo_va = list_first_entry(&vm->individual.needs_update,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
 		bo = bo_va->base.bo;
-- 
2.50.1

