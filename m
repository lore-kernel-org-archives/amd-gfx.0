Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAA606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ryAxUqC7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EE910E291;
	Wed, 11 Nov 2026 17:32:07 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0F610E291
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd/TJZ7kzvgJiBM2fJyBp99OeDtdzDKL7DaLB4FskqOC0WjNVLGLW//cC4UwCrsKuauls6N0tnj3kZGS1kdOLW41dx5PzGl7C2iMoEEd851estGE/N1aot1U/j+PEM9eRaXImaOTspDV32rcm8O66SfN2BrvoZsaACGn/5nRMOOM+UlU/btz4VcNN57Rrt02ONg9w83CfPRsIyD17D+maGvl0a3eG1A1fH6yIImE8Ohc+qzCaFppDnAvMSZAU8CVEadi8V3sqtJHekfolAY5Sn0hQjGQ5+r8YrQa/VEtlCvLw3LFdp8vd8e0ieAnBSQ6Lrh9d2nzsH2irSm56aL9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k0beovIg+vH7eVvA09FA/j6Op5dVYYs9G57C2ETBnA=;
 b=N7BTXgV2bjIDD3BbboK1+pcjEqPDzwNlZJPM09E6WR+aJVvFtv0NXX+JzClDKvhX9UHO/E1TSbJcTSKyw5Hr32shn3AXuTxp9CGRxMJwFSdfHauamin0WiY9nxlPcXlmDD3eD6ypUVSK1NGFtvsrVC13N8dbCX6032/vYjtzqHtvxV0icMPZ5BPcE2YCbYYOXS5XPZtM1Uu3a1ye+v86seAtwiFZzpYcem6E24o/cGgzmOy7a+FqgD4UIsbxYg4TM1wlfWRP9Mnq99d+289JN034jwQzIuQzIpE7S1GL4RMh/g0d2WI5HfMkFgbjfcwXHvb4J66o+GkEZ3oN550xWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k0beovIg+vH7eVvA09FA/j6Op5dVYYs9G57C2ETBnA=;
 b=ryAxUqC7DK446XEkyDpw0Lu821HpFZPEfp6MZd+SKzOX12/4WpBPvVyAfFbBqz3BxRE8PRYfRPr8LRbDjH1Bgm4qKAnih57QTQG/wW1PPBj+pNqL36WlHb7Q/v+aHMW4/mG9kwI+TU6iYnf6QgWshmTR9pPYukf2ZbhmpJmFS0g=
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:31:56 +0000
Received: from CH3PEPF00024581.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::44) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 17:31:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00024581.mail.protection.outlook.com (10.167.252.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 17:31:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 11:31:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 11:31:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Jakub=20Oko=C5=84ski?=
 <jakub@okonski.org>
Subject: [PATCH 2/2] drm/amdgpu: allow dispatch tunneling on GFX12.1
Date: Wed, 11 Nov 2026 12:31:46 -0500
Message-ID: <20261111173146.3157865-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111173146.3157865-1-alexander.deucher@amd.com>
References: <20261111173146.3157865-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024581:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6cee38-4751-4cd7-5753-08df4019ae89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|11063799006|56012099006|22082099003|18002099003|10067099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: c2takLHFOYDR1kShjx5BgqxUcRiR+CiZ9qjriV48KI7eMPVHRHxOWPTIwsx9//dHNT58sRIcjXQVI5oFLw4JhQWY4s0NNLONY5tYFiBUM35e1in2/cJzJoCIvhIPDeAf10Jvk8YsjErih5ABzm4zv/zsGJ5VzEmMmnPCybmAuV3t4yU1JtjSBkglTFrntoHTPAMJWg/oea+K7ithE069IkSu9t6BUB1jV0mrfY2BE5J4hNlEOmLmQjIe5NIA2JHWL6jyMqKwAyp9xw77/G5xcJr6IMWj8dfi7W1EzKNxj0CX1rTfb5mm5ZoYJIr/wa/M8QbYkFHr+PxwKuvTFipnxcl4zr8oiMv45zaQuicH0FswPnCeihYeQ19LMenbO2Hq8oDcj2HXjppkTU1+YUpaoDifI8w3yNfbs2pbtmlWXhlc9jo+AnOYa9TnxpoTf4IgDh2A+ImuTPrSjcjIsD4Uhsbi1hwjP0bazxyu1A76scBVRRK8rpxcJoogOBzb10ckkDPdODYGz9BGcYcZ68GoRGIumcJkyjEHbSuf8hmlhgU+5cG9Y3iZw+64ueEL7alfVE2MjQZUKgh42eIWSQzHLTdldzTerg/7Xb0WrVJ6Inx6VSFTp2Zsg/MShvJFTQXQiTxhFhAVe0UFJdGdDVvtc71BUaJEP717THh1LT+/zESWRV44AuLW4Q76e9LIGrjMugJeVt/1hsUm1MwQB4ZlUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vwnm/qRtEWEerp8JcG5VMYmWCWWynk1ig79CvHzgrxWsAKdQY+2Wo0jrFZuV0RYE3E5Sr9le/ITBvZpNbql7GqSJSh5tEbBW6z2SrJeHX0lkllBEFrhrjkvAHhITJeYgy+srTLPo6NXtdcBl058myVkskXrMvS6iOUAO5Dfm4CsLSO8y+7nX+bUUYWP6oXdoWBXmOqIyZxG02mkaw3TRHKDvwE2Y5QmZ0vWG5MK2BV4JgNWG1aatRxb8kmwXhn+QXd41Ro9VtD5S1YOACzRsxXQXj4u+9U8C1JzhfJmSSDrT3JFfbfMKes6ga0+nvPwnjIP0dBe5tuc4IjrXdjzYx8uYUFNrzkDT+GKYF9NrRYaav7bmlHTeITSVZzoefeVgIcDSRle3hltI1lAprgCoBCURvTi1ud/LyK5F8495rgmjMQMMMWjqmLH6Co3QVPQ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:31:55.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6cee38-4751-4cd7-5753-08df4019ae89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024581.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

Was implemented for older gfx generations, but got missed
on gfx12.1.

Suggested-by: Jakub Okoński <jakub@okonski.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f57d0fa2c044..ef58a10146ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2309,7 +2309,8 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, SCOPE, 3);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
 	mqd->cp_hqd_pq_control = tmp;
-- 
2.56.0

