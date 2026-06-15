Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2D7CD98E3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AC110E783;
	Mon, 15 Jun 2026 23:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K8YcJ3SI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FEA10E76F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WISxiUmP44PUXiLRzH+WedceLD00rj96kCx+pczZG2PNm59mGtguLbGFMEBQgVnE2Vw5jCpnL0fA0XND+BL3HRpb1iTItBnRpstvkCZNKtb/MnOZ0NPvJCObpu8tt2Yfvn3bLIlDaoSa/ZJPdesPvUCD1NaoJ1d2aTdHqQM6VOy+QkDAPx/MgD77Dt6qc1exuFzLs2Fm0fgBcInk7wk2Rm851g6xuDP3j+NER3ZsJ0xjuJtC3SdHdEgmLjLiQGYAmx0oKqIvw4DKqeQOrVIGRy5oKb0IoneBvfDvnHeiJYWehCRzAV1Mqm0zSMpeZueY6PaXQ2Scj61cWqw6vQ0iZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXYwddnPvXKGl9RxizwDnJ8CPOKY2TUUN2Z87RtTg0g=;
 b=BHITLjNowg3Hj0V59b7hQsrTfCIojhej2uqOEbRYtmIn1kjwJq5YdJW7ywREsrVlSRyFUTNVjM1BR9Nbo5QBkbUpxXfMNkYFbVP1yfZPwLTDd39bDzi9QTQa/DN4s96OuxPyUhX6KmreqdUgCZuC3hfaZfN5R/0fJCNkZnvzls+DyRX1fj6JdaA/Dt9wAqhPVNWELgeQuwfxJJ2P8efftsVYaeRvPepZaqJ7W2t1RTz8LXETPqE7yniYWep5xPo/2aiexns3VDJVQv3itBDIstdzDQpkZKprcbDM1AdI0wj3cFGY7JQvxsCs0/hPVEZ0+97KwmCVwS784GFyJw3SnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXYwddnPvXKGl9RxizwDnJ8CPOKY2TUUN2Z87RtTg0g=;
 b=K8YcJ3SIvXzTNxrGBs0cDpn7zUGKlbqig9fHlZ35wsO/fnt+Gu/XePC15S/HpU4URR/dIodo7Z7u+T9/GdB//i/YpVLa0hJ7k77nUxlttIvRiYyuW6zU+CIqx2SqKsTznKYggOhwaAR61B8ziZN8UOQ5cb1uxfQyUUeB+AJDXwM=
Received: from CY5PR22CA0034.namprd22.prod.outlook.com (2603:10b6:930:1d::10)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:13 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::74) by CY5PR22CA0034.outlook.office365.com
 (2603:10b6:930:1d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/43] drm/amdgpu/mes11: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:30 -0400
Message-ID: <20260615235645.737189-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: e0abd9a1-2c32-4d4f-aaa3-08decb39d1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OXMiD26Fy0DjBSULDQAb+GtFTfzuWCJHGqQDfXS+zOjH1pOQFsz0is/ez2qr41qb/kS65n+MYBiGSCRRri62uXMXtmVdMlEiuJ++bfJxKXWw3C3ZWNeDOMmEI9TvqW8R3e0f51oq9aLwPJa6uQoobK/XNOgqdl1UKQAi1lHsMN5BCQ4Jd8LHKxmPi6ZpZ0S4jW5yCXV45+0GS2R5p6ROXFhpzqYkz1KJdyBN5G33mVxlGVmr3pGu09i2n9MV1z5kk/qpK0qsit/CIw8lPp5nB6MVLTUSKQMsYzKZUXTLBbU2zdaldSkGYBxg4VFuvpQFGxr1b850PkC2jUltD8aAMFDvONAjSKv7FAJ9Tgt9pdTEMyIn4n9jrqBmB6DsRZVFbVyY/KIWY237Mj1ijpK46CGxrUS55WQjmi/VjvmjWPQBCLaNadfdn84YSGvK6BgAA9ZSaQRj0Z5PQQJw+H0xsiOKlXmOVUukoArkE182oBoLny7ZO9MIUBHWmH9zPdtMu5otIuuqWkP0uX9+8Sd9rSgQQg8Zj+XC8CFRaS13ssTDqcsNC92/nIy793F/ZWLh9ssHct4zYsdlycMG1rIG+vdgMuA0vUzTmCgZPwacOQT8DbLU0bwRwoQ5dYHclYCJZJeoc3GqQP5v77RoPG8O7Wdpgi5PscUD7ILhG0RZvqit+0ptP6/SbPvXyRJw3XoTVZ+ShujIVlY4NPgUiPQCghza4xZhz70HjeNCUnIpfj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YMBGctk/ooEKlk+NQshsHIx+MOoektWrkVu+Is+XI32Lky/Rhl+XN+tmwog6kjXYWosrMLew7F7imszGaBUCTCuDcAYHESqJWX12V92v7v/OK7Cb///PSA/NZ6RX5PBihfg13MaPKHXV2VqtCd2VAbu+CbcVCrWTP7sA51a5OXFeodgQjzFZfX/vxGho3U6xrWgmNDPsEerdzJOcuy/k5eoL6HZPl2M1dx59527moDHWvlKfIj2DcjN2+uC5A7q4nLqrSyJQz+UzT2LY04Ce5kXEBV8jR1RX6nkTMXLzAlafMLSO0tX1JfV9T7fuNZh9+lb0NL1kIQ3rNX/C/bm1oTsE3obD4KmbF73/bp0gY5Lp9aOPJZlYIsFoBr5Cw0YiYhrYbvcQ4/ngmn84ev5FwAxcXXlLetjXLu/OCnE3E8q07xUKQ76coq79TtqEs+UC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:12.7170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0abd9a1-2c32-4d4f-aaa3-08decb39d1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9e27d01cbfa30..5c9f3a400c5f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -82,7 +82,7 @@ static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG();
+		dev_warn(adev->dev, "mes_v11_0_ring_set_wptr() requires doorbell!\n");
 	}
 }
 
@@ -93,12 +93,15 @@ static u64 mes_v11_0_ring_get_rptr(struct amdgpu_ring *ring)
 
 static u64 mes_v11_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "mes_v11_0_ring_get_wptr() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -290,7 +293,7 @@ static int convert_to_mes_queue_type(int queue_type)
 	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
 		return MES_QUEUE_TYPE_SDMA;
 	else
-		BUG();
+		WARN(1, "Invalid queue type %d\n", queue_type);
 	return -1;
 }
 
@@ -1536,7 +1539,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring[0];
 	else
-		BUG();
+		WARN(1, "Invalid MES pipe %d\n", pipe);
 
 	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
@@ -1619,7 +1622,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring[0];
 	else
-		BUG();
+		return -EINVAL;
 
 	if (ring->mqd_obj)
 		return 0;
-- 
2.54.0

