Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB7DCD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56EB410EC96;
	Thu, 11 Jun 2026 03:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aDaiJcdB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B675F10EC96
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPDXAe1wa3n8Jf0SlNsTGnPvDezPtvKXerm/JRfjsoK7nnRmXdlrJO4+GDEH+5kZy/KM7spAWpfVtgCmP2n1yeRREidBJiMnzSBci978WDDuwsV0gq3076gt2moo6qxGbI5r715TUR3VAyvCIvQZRlfNQKHbFvUS+pq1C/L3ZTZlN7jOXYjl+B/lFHDESAoLZoV7Trr9gwt0TK5GrFYv6FzDQ+5ev+2/DTWSwj68Rc/O4IiVeJlkxtyllMdlLbh16G9pJrcx8yVgWFFiK+ind13h69j4oO9ufUuGleHHst9UJaEetiDKiRXSDKo+PUtxVs+RXBA8j/acwoBwvV9g+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKutIBCGrWwtMb32LImdwsgXotCBw3S2PPvWS0FBjIs=;
 b=Qva5RoxtRH4TG+PBtpTWdCPzo3FrOqipnu99StUjnmcjwqHaSoRbDooEia2YJTvmdS99cjBO+ci3iApXuMovoAv9FB0eO/D3WYcPbPvAAACcJwHfpq4sSZRK5FWuqkckxcZTtooORBIJ/UWPz1Vbq+tyVkeY25kjzkVIbAViAg1g7TgHH1Cd/Y9yl9NDQEvbPb31XXf7lmChpdOGW7uWfHOEalh9J9eKP13A2RdxatmY5/1SsLq+u/u2MBdAlAEvV/DWEwhm281aOEZQxA6Z1inagrJMYAX8SywC3wcuqbKVne1io+2y/sLJIlpAb/9AHLvKfFzBnt3+SD8KNx0rRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKutIBCGrWwtMb32LImdwsgXotCBw3S2PPvWS0FBjIs=;
 b=aDaiJcdBRlYaobCbnpz3P7e9+c09ASzVRiIGS0/yjnPZJW7CEBJSkpoZfbGkiPgwU+ZhcmUGZ7qi1LDKTZYIAk8/m4O3Yji4NkicGOF+YEeanb3Lkmb/7///vF7ZSOZbC+B68yXpBhyQ9B8XnlliJwHu28pfBloDZ75tjPoSc0U=
Received: from CH0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:610:b1::35)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 03:58:46 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:b1:cafe::80) by CH0PR13CA0030.outlook.office365.com
 (2603:10b6:610:b1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 03:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 03:58:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:45 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:58:34 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 7/7] drm/amdgpu/gfx12: try KQ first in EOP IRQ
Date: Thu, 11 Jun 2026 11:57:34 +0800
Message-ID: <20260611035747.548780-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 6386ea2a-24d2-47e4-ad27-08dec76dbc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: arHT0rD1LRVqXxN0G42Hi9UG9Wir+y9IHAqhB7/wTgvPNPLvoqONg2Hhfp/GocWekyTpj+7iNiBfOZx2uVMVqKDDYy2Ze8F/QerXALc16nxwAwCQMruFs28OFJBeYRr94XHg6mxfYB9SaSTykSj7l9LKOyjvEX3yZoqcCh3ZpByLgoze0Zkwu4ADLHmZGcFpFbs1RZPS9CiJCdakIitEUhgA2+hP4nGe5tRCu0IvU64YH3XCQN9W9Pvaq+rLI/TRQE3MnIxsSeoxoYWViuaJ1k4iEu4DslSJ04NV431PyGtQOX5T45h+l0KRcWaHxhdpnlMi7iDOKb0wK0vNL6Ve8FvxclfN4whRViBu8rzDRAt0O/dYPytU7Ab7KJ9w3jgRYNlqJKzyH76mbABhTECxfcFg0EkTTyW7nK8S9yMP42QCUaKgBMUpTEdy0awsphFk4haW7cXs4krYeoNuBDAJIE3AE+Jq9XIynAefsBfgDid+YCYGx4d+EltKDPC2kkm4Y4mqumTfby+Ud/RguQvS1bSiihx3qk5Uc6jtTcp4CFW0fynOMdWgmnjLZP0hHO2UMW/VlRmPklJRT70mg02VkuM4+uiRV7ppdVePshifGwH9Se26ldQ8KejnxBjlFPOH1rDP+N/83FQuM4N6t7ehlPRI8PAMsUC/LrjC1sJkJFuDo9i89F/DbCCmvgu/v30UPksHQBf7eeIZ0y8wgzkHd00AtCs07w7FHSXarMgCCpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lguhTk0892MksTH5eD2V7oeIvnlL3cNG7GFdsBcTPQ2XIYy/Q5jg4xlgF38iqBYeYqw6Ccjfpw2551qxH6vC+7TwsOSBw8QEZ6n/VpL3Ko7ZeEL2T+79wGLsoyto0y87RsBDRQBrtnhuBPnI/IIeFcPbSc4yC0Nh6cvXGd/EuW+dAIWKsWL1sf3zxx+W2Y1HaqAonInn7dhue77yHE+m4rPUComh7hvFH9UkGx8cG3ywsA7wexBE4jVGKkpTK/Q1VRqYpGWkj58Lc9PpflejSznZb7Noay9qV0LC6W925hZJSOep0fjArthrG1USht9S/Tb5Dw8V2JEDD+ppoboLcGpthdg0DX+938qxwCJxtEf47wP0ynOQU3YuIXJz70JiltdtiSTV2CbGT0VtWGWvzHeQTv28GIjDWqh4/LiQ1PemCMfYL3/H8BAKKsZB7T/1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:58:46.0630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6386ea2a-24d2-47e4-ad27-08dec76dbc7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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

KCQ EOPs were misrouted into the userq fence path when enable_mes
is true. Try KQ by ring_id first (KCQ and UQ never share a HW
slot); fall back to amdgpu_userq_process_fence_irq() on miss.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 30 ++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d9b1fc29e9d8..c5fbfc6d8338 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4843,31 +4843,32 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0];
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
-	} else {
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
+	if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
 
 		switch (me_id) {
 		case 0:
 			/*
 			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
 			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 * Require a strict (me,pipe,queue) match so userq gfx
+			 * EOPs fall through to amdgpu_userq_process_fence_irq().
 			 */
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 				ring = &adev->gfx.gfx_ring[i];
 				if ((ring->me == me_id) &&
 				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
+				    (ring->queue == queue_id)) {
 					amdgpu_fence_process(ring);
+					return 0;
+				}
 			}
 			break;
 		case 1:
@@ -4880,13 +4881,20 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 				 */
 				if ((ring->me == me_id) &&
 				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
+				    (ring->queue == queue_id)) {
 					amdgpu_fence_process(ring);
+					return 0;
+				}
 			}
 			break;
+		default:
+			break;
 		}
 	}
 
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
 	return 0;
 }
 
-- 
2.49.0

