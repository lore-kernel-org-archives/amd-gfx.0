Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B450EC79FA1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22AA410E567;
	Mon,  7 Sep 2026 01:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKOefuLi";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3BC10E3F3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwC8rIX8tE4JRZWhkMx3QXGgMTb4IYvYYQUW9W/G3+/Rey3x3O2QCD79rgBmkI3yaCi5047PERAuWG25qAUq2gCLjVKzHg8n174tT4/yCsoqWu56U3ks3qS5kRCAWDXPmG46nBNjjx2QvGyrB7xLcQAvqX4V63ZJ283V0FBeFjP1g+WwkQc/WkTtykEmBZ7Uz22WwIB1SzuJyHEdKrTM2mEy15H0LdGv1tjZgFt19AVJL2KmVtGsQ47jDkyJJyRstBRh+GMN+5rBt7oet4aofQdGt4BA5cC2y7HVQcJdY3Vw/GglMLfEqftu/rqREg1l5Wd/+iuWKhOEQYWN3oudqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7fWDn+XOPMzfOVKQaGdpgvw2/aFdQD4o3IGccBAnnM=;
 b=IkBk33yZBzSmknSmZRHcaBBZgqUt3zYDEAgidtY1K0pMhVjLvg2fQ3TBPBwuPR0/XviOQUdxbSuC823zAdS18rLEDji4mTkvvnwmia42yKfP36O3enAznNdxb3W3moVB887+wmjnSiHK3yo6q2In5/nswAvemXBMN0Cc2uRuzsGbAJVspVm+lsRRbkkO0LRp4yo7JggiLny9+yvMawCLFiLx3NbLgjysoQIKuf78FkAxkC3z/M87Y+F6VPhzgsY5BYsKcbQA0SSJP227sb55ZixlVTposQvLXGDmvJMvU+bmCM+D7+MBsZ7G7mfPiWYyrHeFYVH+z5BO9LlNc/z98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7fWDn+XOPMzfOVKQaGdpgvw2/aFdQD4o3IGccBAnnM=;
 b=lKOefuLipKh9/CrbVeKYnuy1/bvLtntH+Iaopb2vebiRWaiSCB6nIJ5isMFwGJXjmY+Fedw2+RBsStbHsdyZc0BF9nj5M6YhMOcwGeFIHvNyKmPc1yfJxmxpE0I6Z4+jSUkkcD4gqNyyi4ZGGp7pApSLa3KbJZXg1j4UpJuzTa8=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Mon, 7 Sep
 2026 01:46:45 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::99) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 5/8] drm/amdgpu/sdma6: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 7 Sep 2026 09:45:32 +0800
Message-ID: <20260907014629.2186163-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: c811525e-4a53-4bc2-985b-08df0c81df24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3xV3HUYfeHAC3Yq6V45Ch31TADAKxbWvvql907OIWeaGsf1MhdwxwIxg04pRYyr2bJS323WCEx+M5m0hNyMlnkxFDk57+osC+KNdpSC8ANRuny/sB4A84l/4MNpAIosLAlCeu2cw9g3lfvjIavvebpahQYbac7JqHdsv2kES7AeAP2DpZz5WI75b3agYaIwCO4FDnhizjvAbP0aDXVEnBko7EHDd0dQVhoshtfFj2DFF6NQxUo7C06LSljEkT8GUof5N2ilaDP1ynWf5HYVhWV0wd5nLmJs4TBMHbdBz0e/7VODu+Mx8BCwBhj4sEWQrtEgkvH3Gh2Xo66tKXxpO1ZJ7K8iwdkYwhCicBAgO/zySb4Y6NjKKg7Wjic6dIf0kCfL98h2h61QZjV3cf3aEMUGjBvyhuHYpIR2tNk6569j66UdADfYqqZUzniG6gOqgPjsx2qU2JiwdTIp4HD/AcDIHxRa+iS9fGUGPCHPDjPHPDzcMa2XCMnNr4ewIPNb7PbSo/djAf8C389LMFRFWJBNQB3FTbhjow9q61me3zo2nq06ugq863krXKfYwa+nQcqNHNQdAVJkh98U6HJrdwUj0wXNwDpPgxOkSS52mEGMEO6qX8vcl5rNN0TQeBd/t6ixSD9NlqgsC0DM9Y0otyggw9c1mtU5IP3kvukSaw8oq+KGmop/r0Dcp1EvS7L8YMsd0LBb1JxPOTfZg/NYiNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +BUTWlJCJxOuTKmotJ8+BWF1nwxHpjKP3ISTLWhtbE9RUqrvztfLOYYB4cElX4m/9bWNv6FKMo8ClchbvJ8KnSDBgmVulU4t/p+IxMKKvRNQqPWQ9X2PLQcJRwRO2Kmf0mTeMMOjzv9N0tPqRIi/IC4+P1143D7tACYmPyemsghE3+sKg8a7yC/2jc78/6KOEFdsynotWMgVdUX4egGBRWL4/BxbEr4lO35somK2kUUcJgRk6OawyQjTdx/TWTYyR/KNp92V/Pjr15/99XLqRHkRe8hrFhVCpiCS/KGTD+N9tRPtR3XMI2nm+80ALUteiP2v2v1JQgWMllNoiPybzV5GzNG6dRAedb19rZt4mxzIctpnkellQ+644SxD9OP7eWdcd7s5cGPtrmOwgl9szk95qDmW5Q8THeGfGj82fMjt+bVcdU1xS4hkZ0vjBzMm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:44.2654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c811525e-4a53-4bc2-985b-08df0c81df24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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

On a queue MODIFY (prop->modify) sdma6 init_mqd keeps the ring rptr/wptr
that firmware context-saved into the MQD, so a re-enabled queue resumes
at the first un-consumed packet. It also forces IB_ENABLE back on, since
ib_cntl reads back IB_ENABLE=0 on a stopped queue.

v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate sdma6 update_mqd callback, per review.
v4: also keep the context-saved wptr instead of programming a user_wptr,
    per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3fd3e530c76b..a7dac93386db 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -881,6 +881,14 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_f32_dbg0 = lower_32_bits(prop->fence_address);
 	m->sdmax_rlcx_f32_dbg1 = upper_32_bits(prop->fence_address);
 
+	if (prop->modify) {
+		/*
+		 * MODIFY keeps the firmware-saved rptr/wptr (left untouched above);
+		 * ib_cntl read back IB_ENABLE=0 on the stopped queue, so force it on.
+		 */
+		m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+	}
+
 	return 0;
 }
 
-- 
2.49.0

