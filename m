Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B44606C680
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DW1joXPu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6522310E7BD;
	Tue,  3 Nov 2026 08:34:55 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A59A10E7BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRe4kfIuukCYDXFkGT1sfh9EIz7D9nRxgUnrv/wFkPy529/KfHKEZJuduPQ8X3JD89GHyDlMptf0+ABntS8cNC1CyvANkh61oM3bDa/aevYY/Jf0vDWbXohXpQbRZg6OoY1CW7WwgnHn7Ifi2K/izYrfFildgnK9erGYI5tuydv0FeewyF6La/eeail7Pg7OWzkrSD24sNsnfu+1iiD2miutGLG9c85KXR3t8qv8GeSQ4HeNv2RaLbHt/fomypYcAuSm4iTGX14Ytw1wk3CuhfadvACbID160XWale+sJjv4x2b18xL1gt6dciX44WtB+HSG0Uu0RzSQD8avu6el+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLHdGolmCpeHVKWgj52GWwj5sNehaGvXR1Ns0Qs7qGY=;
 b=oXPvnOlpuQT76kC0Wo0HhUWaJ2doyc1a3IbYjE20DXdeJjQZDs6pUgOgqft7+Nm/bCtf8sSitPslkjvotS/MTEpfP3JBTzZlZdCsCAIgZCLfGa8EtgFTO+XXVHzBWcaZjY9V8hDaI9X+ST00P4nkwb7cI1E0OIrWa5Bkydnu44LFsN3tE+qxXUkxdTLZ7QP4omYojCZt7GSEHHI7sMb7lQByT3igAQ6Pfmr0+ZWXUiORiwF0ocCq1jAqBVoo643edrMinho9TsQUiU1xAoGfJL1d2H+yW7bKb9cifZMV96Lb4uivwCJloKpWjaoKBYLk+IG/mk0rH/mH5ZeWzhowVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLHdGolmCpeHVKWgj52GWwj5sNehaGvXR1Ns0Qs7qGY=;
 b=DW1joXPuJPeU83gGWPGi3pqbqgow/L8t6EvM4PqU9CyZXJg06wouU/p//M4A2Q5tatzlB6Zuj3hrd6O5s16Wm6DUP0NFsCCWY1OnnN6TPCldaCJYulES0O59M1TWA4OhXvriWVomRvyP2opaLMoLAYYPbGLvyGP1XvaPBth1Ns4=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:34:46 +0000
Received: from MW2PEPF00014676.namprd04.prod.outlook.com
 (2603:10b6:a03:59d::4) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 08:34:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014676.mail.protection.outlook.com (10.167.249.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 08:34:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:34:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:34:41 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 02:34:40 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: validate evicted BOs on the individual idle
 list on restore
Date: Tue, 3 Nov 2026 16:34:30 +0800
Message-ID: <20261103083439.3057038-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014676:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: f648f2fb-1464-41e2-f910-08df398550f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|18002099003|261102123227099003|56012099006|11063799006|261026140227099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261009221227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: xQIZVqU4Dm8bFFQz9uvuEECyvao4x2zRuH7utkw+R11JMNGPPComIUDE5b/0P7bSJm7qVuDk+265WJOid6yG8ADvFYeTus4PI1gs29Yyu1WXMhLGhhTSHQG4/V98rc/ITyyjlnWRRKjBhcXBLCYSchWHLig5StQ2bsj4S8diX4fzD8VwnkZZtNWUPPO9h/58fejWD5ZDREEQWUIEF5NE6dmQnM1ZBYFhH8ThhZul1LgENPJSbsiK7n33V4cPdXW2pjbelbG/eO9fZuJ2b05u7JO5SPj3j2rOYZZvZcCOp8rbm+4ezvHoBYA3uDl15aQ887wOxA/MWBNaNCSQQ5K7BdPL0lfm2GrmIu7YXyHE7UQqxS4V20fdzgxkeDYg3vFlRdSSd8XObw4AwSE89LtBSrb956c7raWdJPqH3rk4U81fs9MQrcoXA8n+NQJT8htwJgVo/dVVeNPs1Pgn/p/Gf+D1AiuUlrBP+JpI++2B7Nwyo+kVr9rV+Sp+/3b1LsxqMcmFqws2B9q51zJACl2QuZ5uTWUgkBgPIds38pn6tePXFn7APL4PBVzvQXV8rY08/ALnjKznptxYaR5anNR+IvK3nbHnQ/PEgFBHfGEZYok1zTCaabi9LlNCKRVong6vojkst29AogCmghd+Qlj6dWpd4nUg1/xVr6AcpHhgfBp31i25Dm1Y0ZnKMwHT6QPzJ9Ub2B/y4g81H4KmGWbmKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(261026140227099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009221227099003)(261028144727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCLsAv4iqN3JoinPH8uJvEygGBTCR7odfjEcus8ZNyCUmloTbjSox7wBObi0m2amGkgCYFxpWmNb9w2bm0Qz7Elq27v27xGLzDTUngzjd/Ifp6E9EBpbCTXehAK7qW+OVofhyyF9szCJjCvVXelbxwuNTnyI3tdPqoNL96ZDCMU1v7b2zX+w0lOiKuVetHflh7XrCBgM3AOhlzAij2loXZbnnFrq3UVEqdq1bSKAfQnCDV8TWcjXUGTFLAOD93/w19ReUqI+ytmoRb43WXV1gff+0Db+UMqKBQ5Z8vNgsyYQrG30GymFcPOtRcQ67o2IbqMnWq9bAZxwscVmg9Dt5cWbHHK7v9ePpVaQL5k4E9eImr73cfdw67d+Ah/n16mkKLqjmXIYopPaimqoRMAUyYCt8jV3n/zVEPtEZ9mYY7Y8Ou5mODdgRf+k3fUiugdO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:34:46.0546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f648f2fb-1464-41e2-f910-08df398550f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014676.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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

amdgpu_vm_bo_update() moves an individual bo_va to the idle list even
when its BO has been evicted to system memory. A GEM_VA operation or
a kernel CS that does not use the BO can therefore leave it idle
with invalid PTEs.

User queue restore does not validate these idle BOs before updating
the page tables. Validation during eviction fence rearming happens
afterwards, without another PTE update before the queues resume.

A GTT BO evicted without user queues, mapped at a second VA,
then written by a new SDMA user queue:

  after the eviction and the second mapping: dword 0 0x00000000, 64 of 64 dwords differ
  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:8 vmid:8 pasid:289)
  amdgpu 0000:03:00.0:   Faulty UTCL2 client ID: SDMA0 (0xd)
  Subtest userq-evicted-bo-va-map: FAIL

Validate the BOs on the individual idle list that are in system memory
without being allowed there. Discarded BOs may have no resource, so
validate those as well to allocate new backing storage before updating
their PTEs.

With the fix userq-evicted-bo-va-map (3/3 failed before) and
userq-discarded-bo-va-map pass 3/3.

Fixes: 39203f5e6dcf ("drm/amdgpu: fix userq VM validation v4")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ccf0ff490ac2..889a55fd3f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -998,6 +998,7 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	struct amdgpu_bo *bo, *tmp;
 	int ret;
 
+retry:
 	spin_lock(&vm->individual_lock);
 	while (!list_empty(&vm->individual.needs_update)) {
 		bo_va = list_first_entry(&vm->individual.needs_update,
@@ -1025,6 +1026,35 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 
 		spin_lock(&vm->individual_lock);
 	}
+
+	/*
+	 * A GEM_VA operation or a kernel CS can update the PTEs of an evicted
+	 * BO without validating it, which moves it to the idle list with PTEs
+	 * pointing nowhere. Validate those as well, that moves them back to the
+	 * needs_update list.
+	 */
+	list_for_each_entry(bo_va, &vm->individual.idle, base.vm_status) {
+		bo = bo_va->base.bo;
+		if (!bo || amdgpu_ttm_tt_is_userptr(bo->tbo.ttm) ||
+		    (bo->allowed_domains & AMDGPU_GEM_DOMAIN_CPU) ||
+		    (bo->tbo.resource &&
+		     bo->tbo.resource->mem_type != TTM_PL_SYSTEM))
+			continue;
+
+		tmp = amdgpu_bo_ref(bo);
+		spin_unlock(&vm->individual_lock);
+
+		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
+					   TTM_NUM_MOVE_FENCES + 1);
+		if (likely(!ret)) {
+			amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		}
+		amdgpu_bo_unref(&tmp);
+		if (ret)
+			return ret;
+		goto retry;
+	}
 	spin_unlock(&vm->individual_lock);
 
 	return 0;
-- 
2.50.1

