Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68311103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B3710E835;
	Wed, 18 Mar 2026 14:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QsyJdDpB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158AB10E82C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m87Ns8r36pE/CocgGDSsBKhNmR1Or+xAGkYXT/ebT4NtxTE2ffcAMsTuBBZFS6myAJf8/d/u7NiyexCLJtM+cyVMsDAey8wMiZwYucnndWlD6B9e7uCcK/Se34h4cywhXk6hwySFrQfGojRRNAk1yV1JoRJW1letvIMw17uSMjKHi06Gqu0AELe3ha2NdMISY1k16nOoZ7KQpYrDBKhj+2E9UIXfFRfL8GGJTDsX/I0DXpYvMEF2a+2QZT1QxcDBTdkvLDGs4YC+uVmpVhhpV+w8Ai3ng8HnaFdcuaMf1Pkp1omNthv/l7eSXNfrIwSmCVcMyhO5UawBsXz/DaI5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXz3tq6CJIXb4cGrX3CLcX6mX0jKGpnXV+CNLVsfx0w=;
 b=XfvvkrCKTe1n1Q1gq/MKkBAenq5E4A5ykgAoBBF7VtXpX2RcJlHn1es1I3sCUwNptXeIdN52D9V+PoerVcVZ5+7YLUTs/IuO0fc47/UvlfXdVrUvA9DlZz0Ucx+L2lO5j4FusXpJHWBA4dt/THdAQnVxqfVe1L73D2DquPtdZZPNa21iKj3RRTBFQdlPBFpt97mYa+ep8NE9MU0ZVI969iFd+Adtp/j8jjgFzTl41EkHEivXfOaC8J7446YY8m5paihGmbzolac6Td+sbbN7cmG0heq8Ojarww0Xo9TZRY/uDetvteTry1hJJmsZTxHGgtp9TbZFQVhgtkBXlI60Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXz3tq6CJIXb4cGrX3CLcX6mX0jKGpnXV+CNLVsfx0w=;
 b=QsyJdDpB86vmbAYLff2GODr/KvpaiX29NNTCrcmy03plBTn7L9F5eLqvS0MaL7EzYX80Lqz+hzJJLdUEuf3j3cfe5QBlzjiFlZ58nZUSCAd+LSpl4BhFee8bb3Mwd2CjcK3NRc07XmSeLmTkqrQZd4XkAagrSxKDSnctHaP/Ku4=
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:09:02 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::5a) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:09:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:08:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/16] drm/amdgpu/gfx12: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:28 -0400
Message-ID: <20260318140837.582776-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bb4447-15c9-4fd4-10fe-08de84f7e897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MpT4qfsS0NwP+yfxKpCo3rdqtjGP+u+5WrYrTGk+26qGWEnZfysqqxhczRhMEfs3Ys+Xx/J7FzXJtjNQ06Yg+4oXCU85ACbzygSNaqMQuvFNYnMriqeJ6yx29oYo7xer7TkxsLuxlIXXNPg2YEJ4u3Ho22Vw18OxQb8AROCYU3Zzq/yg8/KTYCOUY2trl5AIS4ebwUGMpxdYm+rkkMnb7uaqklIyNMBo5Fx7K4D3qRttSiZ2YStkni0B1LwzbLjYOu9YNkXff5j48AhM++dV8QWLXpHeVdYdcvfYa5U/6J/5ictDDhq5SG67nv9gzT0mDLTgWkXi6LCLl31Ro9KuLSJ6lEvvjX4qLHwItEjfGls4M60pvhjMDIhsZvxB2wqA+tJxGSt5o7/CkTtE4jxZzWu8jtXtNO6kyZUi70FwZidqh4RBLDaTaMGuJbqhU1q7hRMYI6exxXC4Bawzvk0tS1xUyPupBxluZlJ8ylgIPtlWr5tyjorPTgZ4s6u7VsMPPpCNsigezlFiEc20J/m7kkFUdSXUJaAeRz2Xi30RqhBLEnTlZppT2SewyQEAEI73t0nrfMrOBGdq2l9BfOQ6VlAnxi2O1BmlzUJ4J2361uMZqM8GPp3Cl+9P76L9WOUYmprqmAUlfLOq2NdeLEQ8HjCscstIEvzU3Sp4zI4EGx7B39sfPjUL2xlNuTuvRZdqilLzi0+hLuBzb6teEIB+dMbn9Xg+kr+HyyESIst6TsNthKErCQ4AZPyL3/VopDMhohj1LWatcbNyJoyeLdDAfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ERNxka+8eANAA9cn9TAdNGhXPOKYU9ZtiCn2xL4UtzBSfKIbivGO1yNE706LMfh/lcISUv//Be92EcXWXRB7pHLAuyYnwzBQZLOnesY4DHqpLFqy3ZuW5VteRmq9bLWBa3HAXH3B5q2yp0dLaynbh0HkfBnrSmNE9evOQVojRIs9OP+HVLYzWeeoD6gqJhFqF2ACBk2mYqFh6tFcfEHyvTiVAQPDEDhmQ/LfCADIBAmzP1EJAUhBObUQ4BcxFPjUdJWbQol23EN0/wHXU7CVQyZXDFCfUkNML+/b1FFlw6NniDfsRLK05TiOwggiHe1hE0TzbOSfTELyotWHtEpMdFjy2LGClCJ3tFG2KOsyPveOOuBWgvCVYehjFOJEaoGQmAv4R4vMMUFZyP2gJqq98OAayzCwzpqccLCXAZjXn9cswoypQnTJklxDkNHCtoLm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:02.6738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bb4447-15c9-4fd4-10fe-08de84f7e897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Reviewed-by：Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c363..cd7b1ab2233f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3268,6 +3268,11 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	mqd->cp_hqd_active = prop->hqd_active;
 
 	/* set UQ fenceaddress */
-- 
2.53.0

