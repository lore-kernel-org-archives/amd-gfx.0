Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EE5FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062BB10E7E8;
	Mon, 27 Apr 2026 15:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fb7gx/sr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B20810E7E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpMTuEmrrX+Bqwd9CY0k9kenmZYbv/hYFWUsXXh3f9rweF6FTCxMoItgzNlYcavda8yn0IaQGs68gPyY4U8bcSHgKfP0GZlCTldnxODp7Tz/kpvAnc19dBVFcMUreE6yxbm2OmdTPszUejR0QdWrDwKzlH7AwwQ62p3tIoE2LdlKSWiJHMBLR9STj0OjvgaM52LaTC/eNpPbsGhtaICMCYuT7Eeak8RKxuNylPRE9eMuLuGxr5Ng14/XQIdz3vy3jaHZV5CEO3XWssYdB/9Tfb1gLK53kGOP0YyoYInSTzxtQg7NAdWbs/SbQqGjF8lcvxoObPNGt0yOZxLOATsjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV+PoUCwjG4E5KAivsR0FKeppm4ei/8f8ogQb8XbREw=;
 b=NkwJC0mqDUaOpf15wTLGZO1fC0wiwnYyhzorGkyXvisA1QD7h2XX3/KnLW6hanm49Gfx5puV9LIvAKEG5n4N6NegHz5MuVpEEl00qaP5EzAawUMb7il0fKiQFFFBvjo2OlNU3d4yX8D6IJUa0++sUotAeMESuaKZMM08paTRrF4GWiLI2b1gPsy633/e9TCat0jAxoue7B3NnREau/eD6MWqpCXd6Q1HFwVzWLGNkqWpI0bTIiJh+PeaszlS3dyj42ztWFvvbCTRED/LTimre5XR6hpGr62u9HN7ZnYUH25mxPEUAxOzOklGWxt6UyazzL1reXO3qvhj+5eRN241TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV+PoUCwjG4E5KAivsR0FKeppm4ei/8f8ogQb8XbREw=;
 b=Fb7gx/srLC6YO1P/wz9mXAa4yt4mLU0ICTojkdWPrwrbScPwb0Y8yVd4v+nGOBhER4RzaLz0wIXOY+Ba4q7YG0EyYgAuuihAjk7dPeqlvguMnTccsHHLBO0OTMlVAcyaIIF05uNabrBXvci9oysffoTlUforF1YL9BeX9K/NeO4=
Received: from BN9PR03CA0362.namprd03.prod.outlook.com (2603:10b6:408:f7::7)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:47 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::91) by BN9PR03CA0362.outlook.office365.com
 (2603:10b6:408:f7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:46 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:46 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 06/19] drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc
 ring
Date: Mon, 27 Apr 2026 11:58:44 -0400
Message-ID: <20260427155857.1370151-6-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 257c464a-789c-4c01-0c8a-08dea476014f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oz3rLfuaZLBnxZDg2B/vqajcCHKlkUUpxmzPSMVMbCGx4j21gMrysgl+ftgYy5eKtgJCrv/Dt7G9FRt3GDvS7mYkJ7WLfOYu/Bwz54RNm4QUCzQ9Zg0lNN5uIxV8FwYnpyzhHSwuYRlFvNs6vMSlEwJppGu6lw/OFH21JqFDPQH8Szf3FAai5b/AHEfe40xWfERJdTW7k1fJKDCf40CnIX6F6b98tkilTuntmz72N1iK7+9J0kX3kqFscRnXrF4y1GjCtwu2muJJ2Cjywv1XFVwAK3VGTjP514qq5tPYAefg5lOp+M3w1kZl4r2Nd+blouKI6+zcpOD0lxJ4rZ4aa+9tSLBL5tDsykU4lABQXRJZty31h+qcs2/YY00Sdhc6hAXBtGmgsLDJA5GvZ9ZrsViH/oioGhvDExYsdbRqdgjQnFj4z4Zibv2jkmhc5R5a4iAxesjNcnmhanyh/ygRrVcAMEy5DC7sWiqpBYkfCa9xLffXwIHWujaB/OooPRzEMev/UFrdvFaHcIy5cCKr2toTO5FKl7h7EfPLLstvum8EQI3WWYr7S9UOnKOgGCsvR4IssyRgin49RlBnyWuxorho6ycIL3ZPKjUwKSWmvcLIuJAQkZAXK1kI/KNl4jlgE9P7ijqtzyD9ztKJZnNFGI9ZXEac1eGwTBZNSHAQy6ULp3kX/XPyFPobJ24K/PsBF7PFYbquYzB5VQPSBpd2Kf5gEnNDu7hVesxXvRGi3YxpJX3JMc0du8rZV0UgjdX72NTK9VEhyniBM9oJyGJrcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GA6jLkC8Pv+pWV93IHomh6DcbGhvGDPgP17lTKqSUYaIaTm96Cyd20TImXrL+Dhv88zexNmajA4P9GGe9duAeZWTxtM46F1Tl0zcu553eOKakllr+dAX9YXZmREM3x8rmdaHImslgwuerwcrwPk8FFM5g+Q68bsP69zoBAoF3Jpoo4i///L7XU3qo21GRkisBbWyFWna4FxJOZNxkGVB0GEjUgNqSoJvf1Ao4zhec/1rMnK0TApQShU64l8uXBtAp771+BaX33HQkz+nHr/8Nhq4nw/nySzg9Jh/Pz82bbXUowpGvXJZsgsB+HOMPDTtMZmfJtIgePqfw9TVFg6BclWkO7zt8PbvxAPV1hHtZJ8glYha5hVZ7PkolxQ4rqJTIRPq22C1wpkvHtylyCfmixBU2H64ZsSlVY6co9MMbH/+q01NHPU941s9ft9mPdJr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:46.7823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257c464a-789c-4c01-0c8a-08dea476014f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 547aad32edac ("drm/amdgpu: add VCN4 ip block support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1f6a22983c0d..1571cc5a148c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1483,6 +1483,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
-- 
2.43.0

