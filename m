Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951FFC3600E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 09:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3285B10E267;
	Thu, 27 Mar 2025 09:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d6mKtjTp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206CB10E267
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 09:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F58zJQI9DHjqqIEbA2KKTErdyYkRT3bBGgyGNyGgOyMiSqG9eqRxPMVOr92MqgFJWsfoxvgou6dLs383dzM8BYe/lSF+I23+hcH5s2Szva0a6YBkum+ZQD4bC20NIWXGsMi4dV2Mcsimzkh1162At8WIx8Rwcg09bgrJrGgDFGbvFrhNZ94OejpChlHBov8vt00yMeAQHAuj9Y5ikseu6gkgOrQGWNsgFQXdgT0QbfR+2QN8WtXy9GFEQTdqIJQldykmZ6ZNWxa81vCjPlrObrbPB2doyIBF2QBGKsiZJ23fhfUYcqps+UhVqPXzdhpYoTAtZRBzxGtuff1D9MErcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHjOYKa/p+NkBvzrtWR+9ZutZYKrjjciD8c9HDUI9qA=;
 b=EN2ybBfKolqpPG5JuIUKxptJkD7XHCwT1nDbHzjy+ukZ7YE7BVCNj/RWHdZJFZWt3rI0rvp9+1CA14I7cuNWB0PO0ZeMhpPHLtPARQUFKWUnOTuqjkre+onF3IIi43JB+e8dL1I1XB/vfhNoAm4tSJwQkzSijUKkP19kdBlSzrYjblUsfU4SjXz7pOzJ/a8AtbjPfouG9gaYT8usEh4CmrBp6GvePCZrUqffby/iNnqXeK9ipP2niS6rRBPtlk7qzqFBgKMIJbN9FagCf2ORxEK24af7yMLdhPfxpBgF8LpbBCsIKWcCD8xdIuCvhXRyJPy32gt20C59DWu153xIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHjOYKa/p+NkBvzrtWR+9ZutZYKrjjciD8c9HDUI9qA=;
 b=d6mKtjTpDlD7Pwzealr1Q4m4+K7uS0NnV3asRSB7shf7USqCyv+PjpDlki1v0ZFRPcFn4NqhrMWXTYh5jVF1I2MLgfG/DylGZZb6og7xj47DYreTy/K904y6Z4IxbGmf14DZJgj1bYIeeC2wA6064I/LJQGw4s7yHF9J59Dc0Nc=
Received: from MW4PR03CA0197.namprd03.prod.outlook.com (2603:10b6:303:b8::22)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:28:04 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::14) by MW4PR03CA0197.outlook.office365.com
 (2603:10b6:303:b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Thu,
 27 Mar 2025 09:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 09:28:03 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 04:28:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: only lock the valid list of invalidated bo
Date: Thu, 27 Mar 2025 17:27:51 +0800
Message-ID: <20250327092752.1734634-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: eb331496-f5b7-4d99-c714-08dd6d11ad05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?87Fa5BaEEu9/jCXf3M+1dglfkFLeeRpB3/ZFUrMiVg+ZdBSL1wR+Wvvg5a54?=
 =?us-ascii?Q?pIbCPFqXbVfRqH9Mtqq0WiGkedfv1OcOFVp75E9DNi/vKt/HnSKu2kUv6GZH?=
 =?us-ascii?Q?HEZkrw9Egd6dH75qqBCYynXvBFb+XG+KoFBwheTTbDXfr/8eJsI/KBdxOLF+?=
 =?us-ascii?Q?vGFrb6USlKXYEOksjcp72nwENNOB+D3iblkLnn67baURdjviWnYv+4exTy/L?=
 =?us-ascii?Q?DmbR2914XdSo2bw4lSSlLzUj1qPjqsjM2x9qU6U16QXael+eOB4okYjEos2a?=
 =?us-ascii?Q?n7c56nMO4oMGUnUtxMyIRdxsm+DqjFDegb/1JijzJXp9icCm1RnZNESLivWZ?=
 =?us-ascii?Q?nx0uw5vFGSjoeqo3sXv8TgLZzjNLWYQ08VbN63bZA4tly80rk5TqxvWdy+M0?=
 =?us-ascii?Q?i2wD0xJT4N/xPcoJQ7pJN8+Nn6PPXOri1AWyXJGR0t9MZW85Uk7D95Wv+9xk?=
 =?us-ascii?Q?pdSv0JVUDHi/vEEMnMV+jUczwDIP79jLXdkpbRnSWGHL/3rqefqrLFWpH606?=
 =?us-ascii?Q?xRtdgnINep/yCYSYK8hBkyuiL9xE9ZSzdgE2SY6xy919dDojdSVHy6AZu/LG?=
 =?us-ascii?Q?aEKizRXqL8TKnmEcLFjxhExAMNus0oGNL4/RaX/XdDj94PlJwmICjh41gB7C?=
 =?us-ascii?Q?NS53RyXuL5gQuqzVDrzXoc4Ql2ywbocsFGgiSQTnYTx64EugQSGS9r77wQRk?=
 =?us-ascii?Q?UrYX0bgR0rTgzmEEEuQE17UNFa8Qcl3HkfoadfW1wGldeQwpHYfYIyq0k1zk?=
 =?us-ascii?Q?yLfSz9bZ11C1SwnIDRinrRe69Cte/lyGAUsG4zr3uUP1ojKSP+NlDIdMb0fH?=
 =?us-ascii?Q?tJsuoBjMJuV+6EqK3FBDVjH20hBgQRd9qmn3TbJ6SKlQDMHQVeqwkPDsm3kd?=
 =?us-ascii?Q?wdyiPfcFgR2r/F95t31mms4wYBLpXODlWr1wmDpfmuM76HMxyyGs9up5q//o?=
 =?us-ascii?Q?BapOrwOahSDihklC888NaLcsDfJfdsStqs7B5MfpnpdtzhwXNl45AEwfoBCz?=
 =?us-ascii?Q?iStXGWLdPOKiWJ2ZUCow/ozxXSHzuuZUcfzjVNK7DtXBG90q/kSYtfvGstai?=
 =?us-ascii?Q?DeRhLivppQgqzWnOexH4m5+E4b+7lSauzYc2mFSx8VhV4exmxdSRXfIdpPl/?=
 =?us-ascii?Q?3gbaqNtfMEoTDdYkuolAXd7bVrU0T+49Nn3UTtdG5+8xzRNuJpTWYqQmXejl?=
 =?us-ascii?Q?hnKMRJ95FYi/usfRrscstEb+yP/YSAPcIUEAA2bg5rP/NZkbV7tQzsjMQ4X9?=
 =?us-ascii?Q?r52wntlO0hikQo/B7kyihontfuxTyAhsXcqLp4zbW5yZBqHkw9vxXvXMcgbu?=
 =?us-ascii?Q?6TNWkBbXaQNXVbgoblq2Wi3o7QpfRSffzni6RHKAjsUCQ1x7/0jI81gGe57Y?=
 =?us-ascii?Q?hh7xwIOutzaIShGygUUh4wwh2Eo38a67/VKnQ+cCErs/J5MqmOmBxTW6Sdd8?=
 =?us-ascii?Q?w5a/uFc64OaX4Hw2fXPDVAN/HHyiSvG3/k1SArnICDGjbrGRx/yqs31hX2ZA?=
 =?us-ascii?Q?WR42p8w/HeG6++Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:28:03.9624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb331496-f5b7-4d99-c714-08dd6d11ad05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

Before locking and traversing the user queue invalidated BO list,
it requires ensuring the VM done list is available.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ecd49cf15b2a..cb6b89da73c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -479,15 +479,17 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 		}
 
 		/* Lock the done list */
-		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
-			bo = bo_va->base.bo;
-			if (!bo)
-				continue;
-
-			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
-			drm_exec_retry_on_contention(&exec);
-			if (unlikely(ret))
-				goto unlock_all;
+		if (!list_empty(&vm->done)) {
+			list_for_each_entry(bo_va, &vm->done, base.vm_status) {
+				bo = bo_va->base.bo;
+				if (!bo)
+					continue;
+
+				ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
+				drm_exec_retry_on_contention(&exec);
+				if (unlikely(ret))
+					goto unlock_all;
+			}
 		}
 	}
 
-- 
2.34.1

