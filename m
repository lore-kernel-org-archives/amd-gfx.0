Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B6DC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 08:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5E410E54D;
	Wed, 28 May 2025 08:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQYOumeP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF8F10E5B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 08:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WetdtNCoj4JaIKSQ6zmPGMrTL6KlKWjTM6sqk27r6WSRum7mYVzhF8JvQ3fpRgkAObVQ8tOC+kq5YpRZx6MPDBHmo1oQS06BAkgwAKaMxsvkTdlu2hivIQqk+QkR8JMcESiEbjsDnSFjiiEmBVAAOEHBMApAMdf5ZdqtdU5MSuzWbFNSSf1tdah8aGNJFjRbVe6UOFaPpAyxK/YU952MApTH7p+Z2C+H0ZMa9ftURYfQ+hY9gfoizPUuerGjXnlTddSiYGVIGMJcLYTYa/dHUUnqxDrmQ97MIt8aXa/4qMjx42vUgX3w9sB3eT2oJPUNwHB6c5LRqq3yxbACjiUmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoIEADsnbXZ+VydTnALginszZ++urbmsAmBBvK8Pn88=;
 b=vsNr+MpKMzyqEjBlCyiCaOfUXFA6jBBYOsApluivJQjzJ29T71RYNCYjZGW1t4ptf3wgtvxyVGNEzEBFQmQlCQh+E8IncBL/D6OTw482U3mGle2Yu+uGjicmHRrIBNUlFUSKvgsJ3cO6XZsqXobM9ozXYCjl9DVi/WWYoFRFKhU3B+DRiCZ9MhFl7l7wzNyPmwrUfHTsgyBg3YczZB+wTIvnii6WgTuVQ02yxSg6pUBQVWMps13FRc4aKj2eGjaNw/ti4WVfto0nJTjXMVqj65ye7VkVE+A6iYKQtS31LQnER3kOuZ3u3q0yt4RMvIxbCVSzh64SOspGBAcrSisatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoIEADsnbXZ+VydTnALginszZ++urbmsAmBBvK8Pn88=;
 b=RQYOumePJSeI8iEvv0qhzFUzBHzhzaU2esuzN/prrgqMVauochAvem0aew/LqkCLVvpykzN+bbUf39cmeHopJQhAiVGJgKW4jHmHSxJjfqB/0yajwqqoWTqpag3LAuQ36EDRefT0M6p5Jtphwku76ud6gI4KpP5lrWvdfgpwqr4=
Received: from CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 08:38:07 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a6) by CH0PR13CA0007.outlook.office365.com
 (2603:10b6:610:b1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 08:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 08:38:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 03:38:05 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: only export available rings to mesa for enabling
 kq|uq
Date: Wed, 28 May 2025 16:37:56 +0800
Message-ID: <20250528083756.847677-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 90816314-85d4-44aa-5a6b-08dd9dc2f86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o57DPP4igyL9FtHAEKIYVIJcpA5dHVEc03XxxmMFJEdefPiOJhrqHmtmTm3L?=
 =?us-ascii?Q?Heuq5ozg7y+L6LfZka9JnE9aHafFtng7uSKKRY6Y7xqZZZ3TiUj8oHE6yT7E?=
 =?us-ascii?Q?/jJ88dpGM6TUto7sbBq0X38BPHQkOwhrK0TpjhDBIkMjYo1Fcd3PaXsH7wEL?=
 =?us-ascii?Q?wKvotDmQQFsoo78lw+dYlHUbnlBk2JjS0+YhWpv/GRlzxJObOmIxNMeCqMv1?=
 =?us-ascii?Q?TRJ/LO9LqH/XGTED7pgxIZ8g/+G3/78ZNvcAsjqd3fEfAgV6FXqI9B3IwIMb?=
 =?us-ascii?Q?qN/PmaOL6xw6xC+mYZ2+oHIosdf41y/1azMI4zoCuCd55FQSP1KDToydIWzB?=
 =?us-ascii?Q?+05WJovCzA7Bkv8cKzTxOLTCj0lRziiIp5OCX+KhJIpztOWkTzbHTw6uBu7J?=
 =?us-ascii?Q?6Fzzn6ZzMSfTEpot2/q/exN1FsJeQA8XF6s97MI33cD9GudQWJ1uaDrN6Hoa?=
 =?us-ascii?Q?uNVwqu/7VKISZq/9ZAEDla7d/wyX6aKu7JtsYMwd86klk8wDlM4OjH2omZsb?=
 =?us-ascii?Q?t2rbw9DgDWwcT1b1yAe5xjHgoGQfYYCraajFnOuurWBA8QahbUcUDYjqQ39g?=
 =?us-ascii?Q?xTQSsk6NvuwAu6lDB7pOKnRDdPJd7lxgB21ls14gdsSITCnwvCOWvS+0WPE6?=
 =?us-ascii?Q?N+XKqGeIV43xkP7fA3qnszywwMMlX1D1vHhQriONfF2M5aoVG7gZox+x105s?=
 =?us-ascii?Q?jy9ZG0Rt/Z9gz7pthXQi6l6HftKjNxmd6FFDcQYDf0odPYvtrcTXja6Jx2RW?=
 =?us-ascii?Q?1mPerbEDeOle/ftTalywM8VK0O1bIGmQEpZxtSEK+Fp1KIZEft8W4VE8IHIa?=
 =?us-ascii?Q?f3LWiOhbW0g332Xgqc3A4bxFcvxwZclQeKTqNTIIhDoCrPkM2jA9nlpd+yBg?=
 =?us-ascii?Q?7UUUarCQLmBn5Vkb/j9qIiLufwBWkKzqFl0FF6wA9TlTy+bQU5M7vCvPN8SI?=
 =?us-ascii?Q?2dqu1l0tIGYENWdXDP4igAsWLiaGhAVp7rvfiAmJAm2wIF86bJnF1bGe5wnt?=
 =?us-ascii?Q?RpwaxHCdpHcBBdfPBGpLwfC69wgfh1Vq4m//Mw3T/OVvpM62pVuH41ZqCp2B?=
 =?us-ascii?Q?hJo4SYorPf2j5Cl9GAA75dirBXxgbp/AOx+m47RcDNRJMDz9MW9zcIjxH9jT?=
 =?us-ascii?Q?PmzXmDN5yd8zMhcToluB3T2E8GClGBTze6HBkJkskBHHa39HDMFJppuHpmGJ?=
 =?us-ascii?Q?j8snSL6Pzf5I5lBsASa5o6pxEFWSrpatH7LgQADYQCrTfZhWoM7K4nyVg+Lr?=
 =?us-ascii?Q?0Oj0j96/LQhmnyQx4gRFECUR8FJsHW7Pb7WDB6iUqooQKfcsnpWL0Jq/aZPz?=
 =?us-ascii?Q?LZJve+3vREvPgSGcsaRHJZOey7TRpBI1c6+ujwAuFXBpTnLKlHJYOAVmC9Nc?=
 =?us-ascii?Q?zekkWgqTnvPBF8BRJtD3cr3cTgkSTjHlP5rXog09NFSGQpNnRfPsulmCEYqP?=
 =?us-ascii?Q?EjggIr4dwmqtdDcOmKIoBPLvZ9uBildWwoTyhxO2MPuDRuetY3dHaT4YcHtJ?=
 =?us-ascii?Q?HpsX5YIL3KsXVqwyE4wb6/XGcycVRBxiHrd+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:38:07.2857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90816314-85d4-44aa-5a6b-08dd9dc2f86a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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

The kernel driver only requires exporting available rings to the mesa
when the userq is disabled; otherwise, the userq IP mask will be cleaned
up in the mesa.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2ce7d86dbc8..43d86c09d8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -409,7 +409,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_GFX;
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			if (adev->gfx.gfx_ring[i].sched.ready &&
-			    !adev->gfx.gfx_ring[i].no_user_submission)
+			    adev->gfx.disable_uq)
 				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
@@ -418,7 +418,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_GFX;
 		for (i = 0; i < adev->gfx.num_compute_rings; i++)
 			if (adev->gfx.compute_ring[i].sched.ready &&
-			    !adev->gfx.compute_ring[i].no_user_submission)
+			    adev->gfx.disable_uq)
 				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
@@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			if (adev->sdma.instance[i].ring.sched.ready &&
-			    !adev->sdma.instance[i].ring.no_user_submission)
+				adev->gfx.disable_uq)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
@@ -439,7 +439,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			if (adev->uvd.inst[i].ring.sched.ready &&
-			    !adev->uvd.inst[i].ring.no_user_submission)
+			    adev->gfx.disable_uq)
 				++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -449,7 +449,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_VCE;
 		for (i = 0; i < adev->vce.num_rings; i++)
 			if (adev->vce.ring[i].sched.ready &&
-			    !adev->vce.ring[i].no_user_submission)
+			    adev->gfx.disable_uq)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
@@ -462,7 +462,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 			for (j = 0; j < adev->uvd.num_enc_rings; j++)
 				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
-				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
+				    adev->gfx.disable_uq)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -475,7 +475,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			if (adev->vcn.inst[i].ring_dec.sched.ready &&
-			    !adev->vcn.inst[i].ring_dec.no_user_submission)
+			    adev->gfx.disable_uq)
 				++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -489,7 +489,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
 				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
-				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
+				    adev->gfx.disable_uq)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -505,7 +505,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
 				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
-				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
+				    adev->gfx.disable_uq)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -514,7 +514,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VPE:
 		type = AMD_IP_BLOCK_TYPE_VPE;
 		if (adev->vpe.ring.sched.ready &&
-		    !adev->vpe.ring.no_user_submission)
+		    adev->gfx.disable_uq)
 			++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
-- 
2.34.1

