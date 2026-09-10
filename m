Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FB8C79FB7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 00:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57DB10E223;
	Thu, 10 Sep 2026 00:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4hevG41P";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4017010E223
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 00:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRHM7riD11dyuiGVAkDH4EcVSTahrTFJ+dkWKVpB4rLx6bPkBr/cgB4uojMvnHShLLIl4N99CXr791DO9GcyymwpRjiaJ1MRHnhBMM4vqjYPmJ9vB7hz2B+gtC9QRR/1BEfeSjqQGS2gMsmuFCkvBoSytbe9eqsnt5KjvXRolsfT0ftzdZKpcPWgS5hZVD+uP1Xjdk+cMMPlB8GhMHp/6ImACsWqIw4c21CXdfRahZ491ZMaPZ3+nkZ9tBNEWOdANyG8QbH+QGGOfSeQ4LYspiB5jRS7kADEhoo2xQryO4n7QrcqWRj2yApwuy61Er/nfsn4zNki43rT0lLVNRPWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi3Vsuj/HNokdKxPxhQZm48YdpiuBy96XDgG+Xqdo/4=;
 b=XMJh0PHcdlWVoG3AAHTXtdb9NG+iP+nGbE5Ayqk941xlmJWb6N1jPkYLLdBLuHpMvIBKpln+C2+EM8mnnxxkPoa/QF+5RPVB4ou3R0HJ2MPAgh//b7C+Tjl2Ua4LGI+syO7ra2xflanQZrlIXc/v6L+GdSyzG5tHoWxyRvzai5eMljOkN/bxFJgpq6WcAyVxCOQd9E4SwVCwa/oRPPl2P8W25/kihtG1VCoOp4liDsVOF5oQOIY7xnAfjdQbpVJpUW0ALz4rX773CDT+TmOxvwaoxIqB4SGIx1UQ+l7cxfIsNJB0XKNk8jl+gM8/zJYOUT2fz3wKkkqKCb5xvSrjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi3Vsuj/HNokdKxPxhQZm48YdpiuBy96XDgG+Xqdo/4=;
 b=4hevG41P3uo1DnD3io2ykjGY+NfgrKtzj37x0lrDHBQ374Va+UAnjRXKQmUhxSKIANZLIBQ8enClaKoApYsOsOh/LkL6Is/U7tzRIplhQSz9XaetFUb3vLbgi90nN3iIrzDhuZi+LT8Xk2PmWzE46UuvC6GbMXvwWrEVKB6QP9k=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 00:47:10 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a9) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 00:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 00:47:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 19:47:08 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 19:47:08 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Prike Liang <prike.liang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: reserve eviction-fence slot at WPTR caller
Date: Wed, 9 Sep 2026 20:45:39 -0400
Message-ID: <20260910004701.94511-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1a3145-5484-4e8b-60af-08df0ed50b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: GQ9MTyEWZgP3ZEQO2FG7PXIFvTNiTMNkZ3LYBORWmAuj5LGZNxH93BhoBJ/VPdH8Wj9oFa9XqIWU5Pu17ZBY/KOGUUgNWn5E7iIrKZZTBiMxhz9qPl6fzl41Tub2LjPS3ASxk9EfVgoFC+Rpa8QaZVZ9vou6zhAlZ3uniYNRX/LBNkvBSQO9Nh3lfGF0UgATNVk+5iHoczOHEJRksT7k6nqOLn+/9MIqnRZHGAEAFLQe0HO8K/M/BEffjU0rb486Om3fvFZwhrF1oOy34+XWR+Vk3CnRl7eKUm2RLylFhy2pHBrrxoodxG6lzbks32cFeikDj+ku3DW2lO4He5ZSecRShsKYnHb/uuoJXpuvFjzPiM4DZ2ngqZ80oWEuuAbZhWydCkfj2R7tPfhmhZiK3T2BEfwyQc1qZa6tieflXISWinQ0tRygpeeQkZFTROJxFEDltYT+eVqa4odGX6+sftV4GHk01ihdSJ777WRwgrGLC6W+S3BMSjE2sjQ4Fpc7+Ljlxu2a8Vcw9rzaeXyOkWYST/C/ARQEhpqUDT3dkLw+hHlWGxL23jnyD90h3qQ+hWVfUYEYiay5e8Lu5Ansm7owCThPDveh886dJqnMBOw+lixE6U242u51LKkxWkvhrI5yk0TZXzd48oqAXUVyG5IfZ0mzo7jLbi60XcEBa0usPmxZwPAXbBDt/s0z/qfEldgblewOLIEmbmfs3yIz9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3/ngwdoqEc6rmAPPl292RhWRTCx0f47c56yIgnGOmIi9jQ5Ex88mIqXV8Mgjt/PdBx8MTDbLQBjxEQnw59dabZgvNPuVGxiFof1ukdUe+UTo1fBuG/Vc+ITOoptyasjD+xC/WFRYk4PY2+Q44ucYTLbjxU8El8Krvxebp9ReOQdx5qMoel3Ll/EwktDoOFfhpCLTNTSwVmsrcz/GLg16OxejN8xaz4m/GZzzrEW/kTh55+P3eXmnBatVSdMxuIRJXExF/98qesPerNjAosF8ORM257H1GgGdO0crRz/QzMAkcCFJc9pblebAudSZJKDRDYigLsYLIDBQEhe+B5iyyzeCeNd+DF92TzCCJ8lQTQGb2yJwxWAQBsEBAccUkoBRp1+dANOj5CJ8EKO8lrRlI6S+sapyk48XE6eW5ZqVoKklFFDV8cdGzmqColyjVXVQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:47:09.4919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1a3145-5484-4e8b-60af-08df0ed50b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Root cause analysis showed that the previous workaround was fixing the
symptom in the wrong layer.

Problem:
  kernel BUG at drivers/dma-buf/dma-resv.c:319!
  BUG_ON(fobj->num_fences >= fobj->max_fences)
  Workqueue: events amdgpu_userq_restore_worker

- amdgpu_evf_mgr_attach_fence() had been temporarily taught to reserve/add
  fence bookkeeping internally as a workaround.
- This hid the real contract violation and made reservation policy implicit
  inside a helper.

Review clarification:
- The helper-side dma_resv_add_fence-related workaround was only an intended
  proposal sent for review discussion, not the final direction.
- Final fix keeps fence-slot reservation explicit in callers and leaves the
  helper free of policy decisions.

Findings from investigation:
- drm_exec_prepare_obj() both locks and reserves fence slots.
- drm_exec_lock_obj() only locks and does not reserve slots.
- Existing attach_fence callers in the GEM/userq restore flows already reserve
  TTM_NUM_MOVE_FENCES + 1 before adding the bookkeeping eviction fence.
- The WPTR mapping path in mes_userq_create_wptr_mapping() used
  drm_exec_lock_obj() and then called amdgpu_evf_mgr_attach_fence(), so this
  specific path could add a fence without pre-reserved space.

Fix:
- Switch the WPTR mapping path to drm_exec_prepare_obj(...,
  TTM_NUM_MOVE_FENCES + 1), restoring the caller-side reservation contract.
- Remove the helper-side reservation workaround from
  amdgpu_evf_mgr_attach_fence().

Why this is the right layer:
- Reservation policy stays explicit at call sites that define how many fences
  may be added in that execution context.
- The helper only performs validate + add_fence when called with a properly
  prepared reservation object, matching the existing drm_exec model.

Fixes: 91a358fe99d86 (drm/amdgpu: dont pin wptr bo instead use eviction fence)

Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: Ibb2ec1f210a8c6e5d2a48ed9b8ec77c6dabddb7e
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 68beccee9fc0..fe49aa4dc5ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -60,7 +60,8 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		}
 
 		obj = wptr_mapping->bo_va->base.bo;
-		ret = drm_exec_lock_obj(&exec, &obj->tbo.base);
+		ret = drm_exec_prepare_obj(&exec, &obj->tbo.base,
+					   TTM_NUM_MOVE_FENCES + 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto fail_lock;
-- 
2.54.0

