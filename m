Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB02C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 03:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB1210E280;
	Fri, 17 May 2024 03:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nmnVPQnb";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A053610E280
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 03:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clSmNP5rfwzrrmMaUTFJXpOq8qi72RpfDm5CSCrZB0phBZ9n24ktabc2wJaYoaro0HLqxRDq1hkKVWOAXqROBuazP4NOPk7wCwjqgvlB1zcmmPCo/6WvlFQP/FpKloKCuAsllTaaEpEQ8rWSDdvLzOuXTDzeF5keH0O7p+KQoicQsOjkTTV28gYi7gY7CUwk926G4gjW9tt8yM/6ivSRnuMOHTGKVjj3f07/BU03Pw4zDHK/JeylqCjDqn6NrUDCnG2zOSOjLEsBX4Mfu50Gw5rMey07JPYoWR+Rsx5vhaFeqI869vl7EkYkW5wiW028Is1XaYwI6GVOVozpD1GWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NOLcR+I4bk8TqyRbuLMXLpFITCjlmt7+IWvHQhUoL8=;
 b=hjG70uIR0XmPyKCa0vKYv3vjEmXUO7yc5cMOm5P1iDyzpcyqXohL9sIeQ8vDjLkn0lzasOZ2eVgpc4B3OFmEgSvOl4T9eRySxL29GjmwD0RJoxd+sJQmh+fUIhdUekhQylW1xRhFoJFYyqcLPHgGbzGB0Gh4oWbCquAO7K0gXyGthQc8PlsP6OviAoXLWKh4JK0cM6OGwVHvsAjsA4rTKYwBa9oDWP+x2WSKYkgt+cDmQyjggUJbtsVlUYjJcWx0ra0BLTyxOt1WYyDlIWQTonhwb8O1ajLWnbG3SGyieBaWMjx+6R5Mj70BM7YThgXKL3B+69jIm/Rc6jIM1aoNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NOLcR+I4bk8TqyRbuLMXLpFITCjlmt7+IWvHQhUoL8=;
 b=nmnVPQnbM6QSjy4JR4sTcnkL3pmRXFnSR7gPA2gdK9/CE0DDuO1JsI2egL9yeDFNuNP09wsn41ijJ4Y4ThZM37npfLVTHLxNn9ppUk1OyYr8ZUcfHcbKu13/tGQtdkdoLHh970cNgFSzYvZLrwyKEtCfZY7Jv++CKZGMNACyE/M=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 03:42:13 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::78) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Fri, 17 May 2024 03:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 03:42:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 22:41:45 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix ACA no query result after gpu reset
Date: Fri, 17 May 2024 11:40:57 +0800
Message-ID: <20240517034057.2015624-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517034057.2015624-1-kevinyang.wang@amd.com>
References: <20240517034057.2015624-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 8348f2c3-380b-4b6c-8516-08dc76235689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GfTqYnxAUzPPXp00dpqDw2RQtnE84sgU4QuB3k88+ELm5gI/omxOhCUARqNp?=
 =?us-ascii?Q?6qWnx/+NfMUWHHrxxc/uBqN8qn8OAIyD7EJAqbnZRXQ30jaNqZ79Da/j6PNP?=
 =?us-ascii?Q?q05SXlXVG/o6iXz9RmNAy3yqAikw2oEjpKIPG2klZ8glmf/fGXgqHbxCf89/?=
 =?us-ascii?Q?r+mswKd8Rl7+Ouy3klp2GcI4RKCVPcw6FipX5sT/CFoMvyzlxhD3sM7Kbbgv?=
 =?us-ascii?Q?wq2TORqiep3RTRY+W98zsbvVk8ECoASiQPAKwQLbyIQ8vJGf2YvmF3vlrchT?=
 =?us-ascii?Q?yr8zN4jk5W6RAKKh/b/jqR3Ni/2zLLy8H78EDL1WOfN/kpIqb2EsL/aHTyn1?=
 =?us-ascii?Q?kLatpz0S0OIHby81hehGQfzv8aOFMecq1vxvJjkp/VnfKKpfP3KOUgCqIBWG?=
 =?us-ascii?Q?XSq8VJ1z/FQBoFaAtzflFSgIitc7+zORIaS6kA3hiVh+CbQ3DRT0cPnHj7hk?=
 =?us-ascii?Q?8Ao9ZGJ/5NOXfon4B+pgn2vQYu3dVOI9qWJSgGQppja6+JiY46Fp2Ws7b4El?=
 =?us-ascii?Q?9wLjz32A7FgisfNgA0NwsHdjoephJ95Soi4BqRfRTN7oWNXp+owYyHcjy9N9?=
 =?us-ascii?Q?P0CmahCA0mgIsZtirrsVOhjOD1Lmpvf5GrfkP2GxPluReEbF3pRGMfUYwMtW?=
 =?us-ascii?Q?DrQYayTiv6PcbAKyAEytfvDBM/rLvDlm749Tl9/0tNY96P4bZPJ3Ob1ABeQq?=
 =?us-ascii?Q?Tw/AIPKNrVQwIOWqcezPa3K0sfh3P8wFoE3E3s3SMv5inDiossV+IP3CB1XC?=
 =?us-ascii?Q?bpeXJnSBi/lt9/pDWELyiXFg5xeMVv0+WL3s2R5ZwqAGNwz3d6ZvZ0ttG6wr?=
 =?us-ascii?Q?z6GCk9b7w1FfA2leBnS1ys05nJw0nvOn0qTTNeqRHE/PJDNhNmKHvQkZQVUX?=
 =?us-ascii?Q?X2Z0b0kZZUjxQPiHO22rXap9PwCUQbSWWnMPcyhL5h/W5WKZ/uXjDJyYTT8p?=
 =?us-ascii?Q?jX8m4ebwfREBjTejEwPPW689uXta6noM7lTET4shqsLe7qulbUCeAn8rgdb4?=
 =?us-ascii?Q?4CKPAcSVb82Cf9E8npsFDyBLrJVFb5CCebp+pw5/5FyGP2Y9J1HvqKeYn3zT?=
 =?us-ascii?Q?xbe5mEHRVfRkU8D7MS2+ciep0R3ZjH/OLBf2xOMRT8BihsIxxVsNbrjAd9c+?=
 =?us-ascii?Q?x6hUsSQsXw2wOxcz5iVcPkn5cxnJF34Q1u9KJTMhHuifEpUw+uGEgzFGK9yG?=
 =?us-ascii?Q?iCmzCQFf2GkwdH++5HK6XxXorgXucMalv/fRufhyHQESFPdH+oKOvVQ/a/aa?=
 =?us-ascii?Q?qLW+7G6GZDXjAgCfTuSkr1SX6b+uuiuheRAZjtHyXcOQpDHXePw2zfp6KxMa?=
 =?us-ascii?Q?7JcJBfhVozgEiArLgtcpi0Ek1Z45tBMgw7i8Xpmz2dn+zOiLnYtNqN+Y8kEN?=
 =?us-ascii?Q?fWgjrl7xyrGkboOnuEJHvjRxRheP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 03:42:12.7085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8348f2c3-380b-4b6c-8516-08dc76235689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

fix ACA no query result after gpu reset.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++-----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 05062f2581a1..6c6c387e5a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -712,13 +712,6 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	atomic_set(&aca->ue_update_flag, 0);
 }
 
-int amdgpu_aca_reset(struct amdgpu_device *adev)
-{
-	amdgpu_aca_fini(adev);
-
-	return amdgpu_aca_init(adev);
-}
-
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs)
 {
 	struct amdgpu_aca *aca = &adev->aca;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index ba724c2a997d..4327ce1ceacf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -192,7 +192,6 @@ struct aca_info {
 
 int amdgpu_aca_init(struct amdgpu_device *adev);
 void amdgpu_aca_fini(struct amdgpu_device *adev);
-int amdgpu_aca_reset(struct amdgpu_device *adev);
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs);
 bool amdgpu_aca_is_enabled(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 06c5f6e2ef7c..5af813eacfb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3617,12 +3617,11 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	amdgpu_ras_event_mgr_init(adev);
 
 	if (amdgpu_aca_is_enabled(adev)) {
-		if (amdgpu_in_reset(adev))
-			r = amdgpu_aca_reset(adev);
-		 else
+		if (!amdgpu_in_reset(adev)) {
 			r = amdgpu_aca_init(adev);
-		if (r)
-			return r;
+			if (r)
+				return r;
+		}
 
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_ras_set_aca_debug_mode(adev, false);
-- 
2.34.1

