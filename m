Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E87606A32D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IAbIpaxy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB82E10EA4D;
	Fri,  6 Nov 2026 15:27:01 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E663210EA4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 15:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDpWd6KNJU9zz59005v/UTm+G+WFdBnJgE/y+7Nksg7Zz/nsLM5vSB9b+Zl6sJhSFcRBLUKYiY1b988cSkld4TQhTS9qCesLxeM/Xnt7sgqZQOaoHW/JPV0s2B1fYNh6j8ZD3YZe1Ny7VKYjdf+gvY49KCGAM/TaFNGysJss5Vp184q3mslDNMx1FJsspXpuNiwL9gpG8s6AO13I3Xnj+XS/CqCjUOS2OkUwNuCVb/fHPgEcuYSNvL4r5f6j75XWnsyJtjpnNGvxaL7tHW/rd70sxxPXcRAYZP9tf71bUZwBArNed8cWHmaD2X/pW4dnmryis+ARbiQB9TgEAG/ytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jIrTCooqAEbCGwZHLZLCYGKfk58lDzNj0vHE//Xb/E=;
 b=kZpzAtjatjmym31D1+TQ+9iJ3VK/Ykw6UT0XF5Dl+3ohWHd2XXeyfVaz/coGKpXorc0DhJkBrbduXH6lh3gE6VeGRFumEomPcgiOzdZqtQYATFM2cuarNTRW4Af76+of61suSRUwk6WRuwSqOtRd4HVMxYvOqbX7yfpmvBEBldPXhUEc2X4On/stl+qRbX/qrlqiopd9MA0Y/smHN1aKayx1kEkPKaGZoQyfxw8TFftpLYk01vmA8oiFRDXsFkYvFBwlWeIORe1w1LNp/E4KHK9FLhrkmZEKka4qr5l4d2IWa2/GWgULPhf/md2p3PW10pLP7aTjenMHh4NtDOO/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jIrTCooqAEbCGwZHLZLCYGKfk58lDzNj0vHE//Xb/E=;
 b=IAbIpaxyVwFR1dKw8hx2HSUFRQ0FLeeZvBXuWhaza0i5co2Qf+TRTpu9Ih8ZWCsrKlpi+qE3YoGtRWBqPdPviRcZd3fh1+wF7b1U0hI9PBNYjiqF8t6IcB9C7dR+pjkPC4aONhs/ILBKzaNO/EcLJgZJJfNdqErX4wO8IYw+RMQ=
Received: from CH2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:610:4d::30)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 15:26:51 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::7) by CH2PR19CA0020.outlook.office365.com
 (2603:10b6:610:4d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 15:26:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 15:26:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 09:26:49 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 09:26:49 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH v2] drm/amdgpu: wait for tlb flush before freeing BO
Date: Fri, 6 Nov 2026 10:20:32 -0500
Message-ID: <20261106152031.4040973-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014022107.2511834-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: d22e7ea5-ca1f-49cd-41f2-08df3c1a6186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|261022105027099003|56012099006|11063799006|5023799004|261026140227099003|261102123227099003|261028144727099003|261021123027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: TOEBs+VLaXIknHIonNmhUGtAIDE2W5zmPLRIRCRNsoP9QdGILgrzbcow/o2ela4NFnBhpmhcssxHlWZBj250wiAA5BVJUo4rAGWZtHRvZP7oKFwW4igBEU14lJLGuQfPtOT9QPcYGhOnRJvDlx6QaiN4dNKhUSHYGDHF/aDwjp6PwhVssgrpNdSBIjWUSAuh3sfeTwsy2+DroaXfluSQtMKrFq6KZP2Tg55uSOyyBZbXIH6JOrzy4DXxhfxNS1PyVG2Lvj+OmpSEvfyg9nIcUGbF1y8VHM8qZbowxeFZERtg5d4YRXzn1GJpN/KhDyc5BomgKjSB1TA4lC/6IyXJ5QHvvHAr+WFE9NekICQkhgm/Zzu5nVf6+YjK1CAql2U+68H7h4x8SDReQCLtZXxENtMC7OlyR39p3PjNfFQA07WEldksgFZlGo7ilbGBpqYzaeBkjm/1NTKz6E4wBPue4J4ZmmZsJ1de0sr8UKOYjdNMMP/P7g3Aexoa9qCCm8r/O9aLXc2PObbAGtFGnuqg7QNeBSEmOag5EW/n6DALq6isbDyzn+xfshDEbWLMd/M9s+Sbkrb4iH/lA4W+hfomqrTtCpyqIMHUpTU2PYyrC2sNUEhxBhDkslctndVh4RzLP9P7pVFbvq8EXPp1kl4BJY+nQ86w/GetXOEMMMMqGor1a4x7CgsfYQdOx3aXJiRFF+2cMk5Vazbo5j0DiCNSrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(261022105027099003)(56012099006)(11063799006)(5023799004)(261026140227099003)(261102123227099003)(261028144727099003)(261021123027099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vQf0C/KKdSbT7aHwp9vhmSLJYcranYsJIXe5Usmn2+r4OjngVAkTvs5hLs5daroSf2gbeaM0KsuA9opOCn225rc4nflVxxMgSt2D0C58FD4uNvV06dFeVVZo1fR4+uQA4QotafSZYVaGf3dIEx0cDnq8l3QHi4IRPkbZ0QSwJpwD24s+9Titss2CFst580HNpBJa91e0B9s0zmeLhTSZaAtb89Ad9b3kK+GKZcC92fnS28yc97F3k9CWcHtoOiaE/umKbgBNkBxXJdh52r3jCB+N2MZmxM45xgfAqAUTZOSTKwF/C1o5kpJEXpzVE9Q6MkleEg7N+y0pJpMPbkFoVHI7cPw0WT6r2POQyYzw61vvTbmYnMSmPl9CMDsN6cNOQf8DgWpAVCoBgCGDsk7gNMRRAGRLA6E4LqyrDklhwohLMgINI/zdgpIFPoDMj9x7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:26:51.2341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22e7ea5-ca1f-49cd-41f2-08df3c1a6186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

On gem object close, we previously only attached the fence of its own
clear_freed() call to the BO's resv. If an unmap of this BO happened
prior to the close call, clear_freed() would be invoked, leaving
vm->freed empty, and no meaningful fence to be attached to the resv.
Because of that the memory may be freed before the TLB flush is
complete, and give a running userq potential access to a stale
address translation.

Fix this by attaching the last_tlb_inv fence to the BO's resv.

Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v2:
- Rebase on "drm/amdgpu: fix TLB invalidation fence handling v4" to get
  last_tlb_inv
- Move the fence after the clear_freed call to make sure we wait for the
  right invalidation.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6137ab4211be..36b0bd85616f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -371,11 +371,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		dev_err(adev->dev, "failed to clear page "
 			"tables on GEM object close (%ld)\n", r);
 	if (r || !fence)
-		goto out_unlock;
+		goto out_tlb;
 
 	amdgpu_bo_fence(bo, fence, true);
 	dma_fence_put(fence);
 
+out_tlb:
+	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
+
 out_unlock:
 	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
 		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
-- 
2.56.0

