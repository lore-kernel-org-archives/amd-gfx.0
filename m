Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EAE103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6720D10E06C;
	Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Px9ZJO71";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017C110E823
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtiBfI/D708w7mvhh43XR3V2nrLSJWXLLYisdfsUc8xu9Lfbaw0Qb4owUZbNIHsghH3/Ld2mN05vYhAkglhO3hXPd0vf58HEjKPqBWOHZ+Japr7q8fe6txV6Di/Y1FiPhcfxS0CfeN4Uva8mFie13sLfKGzSDBC1ZbBK8vWE4l+q5UewoLvG4CU84Lk0/Qv2+M2R4Oxf1B8XplE8pjd3/qY/d3nkHTFbPo8/snigj0uyTB0nx648IxGRz1SZKbbOyNqpS84d65d5uadO3q0Ms40Xd0Eq+sT/DivThjp42M7AYB+II+MwOQg3OfANC9zpGIJVZDcBWYjDoIkHXExyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1AaKgft04+DeEzjp6saKcPO1MGL6whXOlmz9YT6RKc=;
 b=w5oj0F1YAFmchbclo7AFZEmiUs/KnPOudEfvtjq9zk91mRWSigBEhQHiEGBjLZa8wuUJaF7kMfNxuYmTz1Nc8JCkLeiZsm8yLL0UbKzTT83F+k2S74g7181fEhVzcJ6SBajE5cRhGvMuK7vJkqiO67KPkxOA/GY0wZOogwp8jlQBtRHln8ZvGSC3hf1d8hVVhmJZGjlqwbNjhv3de5Fez16OxpS4ectvAzEhkkFRMhgYHFybJMKhEgJc8NHR5DhvgGSPTd6T/jLd+DAmfNwM1gNxJ5IUvSK2OWxK8di1G5zlLkH4so+2Sjo9JB5YUYxroUTYp6kPJQUmSuPRxiCVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1AaKgft04+DeEzjp6saKcPO1MGL6whXOlmz9YT6RKc=;
 b=Px9ZJO716ANQD1+f1Uer1w+Owd37XwFyDWpg58xQyZ5nYk0shCzppqHUTytfgyJGyya3p+ZOS7PVlEsEqHSlFr/pfzCiSW932YJfdaHRwWqGmcIdaNZTw4FJ7JM/BVIV6YqWIEbIaSZ5gDCupwrsYxuLTXp1O1z6gsvuA55E6pA=
Received: from BYAPR07CA0048.namprd07.prod.outlook.com (2603:10b6:a03:60::25)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:08:57 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::2d) by BYAPR07CA0048.outlook.office365.com
 (2603:10b6:a03:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:08:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/16] drm/amdgpu/gfx7: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:22 -0400
Message-ID: <20260318140837.582776-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbb902e-dd8f-4983-dafa-08de84f7e540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: T4aKHcEsgDPA5QGIOGHeRHWPuJjO4zlv/8j/DnIro2CRgms8KMP5p+3rXYX1v5qbiHVvyaZPhb0ESSwkTpQ+7p2Lx9SGsV1qoojdMKWH1mLBcDE0ul3TjOmtKXc4F9P5hI7bkRS+GZyAWGxzGj6mJUG7cd2OWqVTk7hmGoa/ki9VZ/IYCxxz+r6kJWwmxDDwyTHjSXniLVjMO7YsKIaOrTQrYkcAznRte3KYIhx9UrEM5v/KjEr/euR1kY3Ah1kNx5F1pPE8zcxwQ298sD0k1XoXY/JQUr2O6WG7vT1/2tVSLypXjNiEx4IAy3knZQcpyXGGmHUc3Ki3HwbY1UVpF2KlGy/fWUYk/BwfibPDKPytqSbjagUIBlBJGt1k0Z2vXtMipcEJO6StjBKpVnrUTt3IhoV2Hd7XoeAAiDOrofmTi2I/3BH+LuUrVvO7yPV7zMTGa0vDKAjUYpkPmD4pvFkzSFH9qtUywZLTtUjjxYOPANNuCR9Ggtby53TE4yv5bhgS5lyxfHsFA6MPNWE11AQLfT4wdhAjxE6VMuVsyNzsKceuaRNz986UYpRGT4w50Qn6Vi3F8YteCHDAPet4p2iIfCzD4UpJJOu0CIaY4WssYfaTWVIPSryoKWkHW4iaMQRMO8vqfXENSoMUd/JZafrQKciN54SzUHV7qJFvHqNMNAWEud+/rXTxPWnAmrm3WvhKJqkTDK8M58/IIyogV0+UHSEC6iRSUQyf5cP0SNmxCqGnuBiQ9+jOx7kqTaJ6+EBaUo1M+4svqzVnhdADcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qRZRaXWwrqaU8As4D0D6Hn8ozKCSVERXyhwi+R41lrWN7pMs1MxhdeDaOtftecnee+a0u7pc1rO0Oj/zyGFzai7FcGBbThdPqAT12h4vcQZcpcaEe/ta2ZgW2HmSYaE9FhPWzmmSZVd+3L/aCFbl4vGtrQud8ACndWyBxLDdsy/XJ1QIxNjv/QQvAqUQEF1BOrO6e9IcLewez6W8ebKP/VMH0wqL7vtPgU+KRYjaJoXnE00MKvzWfE9RTYyyYV1iPMka/WE9GOle2zP0fLuYafQ8M6TgEWhscpXOWlum1KY+Vp0IfbPC0ojbJxdQulQ7sQnQghTTetBnKE7RfKDkiUqZU3t3vpSxXjPS4MNv2Ov6QYuEXN+OUkaGc+PmCmJAlcKJNHDyVjR49MQ+yYEf+Z++5xsXps89sjK9IfKQWI/cWbA9ccqw2GG1TuibuXC7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:08:56.9810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbb902e-dd8f-4983-dafa-08de84f7e540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2b691452775bc..65b8497ad5f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2819,6 +2819,7 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 {
 	u64 hqd_gpu_addr;
 	u64 wb_gpu_addr;
+	u32 tmp;
 
 	/* init the mqd struct */
 	memset(mqd, 0, sizeof(struct cik_mqd));
@@ -2923,7 +2924,11 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 	mqd->cp_hqd_atomic1_preop_lo = RREG32(mmCP_HQD_ATOMIC1_PREOP_LO);
 	mqd->cp_hqd_atomic1_preop_hi = RREG32(mmCP_HQD_ATOMIC1_PREOP_HI);
 	mqd->cp_hqd_pq_rptr = RREG32(mmCP_HQD_PQ_RPTR);
-	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	tmp = RREG32(mmCP_HQD_QUANTUM);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	mqd->cp_hqd_quantum = tmp;
 	mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
 	mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
 	mqd->cp_hqd_iq_rptr = RREG32(mmCP_HQD_IQ_RPTR);
-- 
2.53.0

