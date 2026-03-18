Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE28103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D6110E82F;
	Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LNsfld3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD6D10E826
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6x69hIKbGBSEiXfpaOKv7ITU//65/OtJhGmoibCt2KifsshwxruGlCAxKYMsx/YBBI7eUCqDp0n5QoD0nUhDAD6nQqtZzO0fr0guo38U4bty6iFmnVy3YrQdnN3oaVkUucHx0jGSYtQwA2LlCu/yzLeylEHY+86pMYCJlXEcVQsWQkttAiW9Ns7xTEyf826Fw8tevuy8dDaZPkFZrk9zifAhRN8/T/lRhQteRazDtLfBW6RPmWs4tA1ovZgwxDErAlCTutcqppP4jXzy6m+R8AZ3RKVggeeyXkjeoJ983w/sqcybvVdw5o/t77O5GLscruQTolMY53EmjGQcHgs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My7EJmCuNGUiaoqpKSp5LKy4SQdWuI+IkArRlUtmgIE=;
 b=gcc40VVH2VueZDDCRt1vAMF1OWuRNhZSqfZX/b6LLBcj44+JOFCuncmvY361/EWh2ZXNpF9ipOEAdsoVQEpfCiWyboBgVwvaKzYSNh/9tPQBaPIR4dUfvKajWey1iK4cCebuH71zS4KvE8yU5wt6IbGvJ1yUUpGTPC2v/JR572hLbstOvs5gRQyk19PicxHH771lD/ZGzeMAnNxmDAKLS7GU+cIDJtv9PvBm9QMG92WXaWBVw1YH5Wnz0/vspbI8on6WNalN6gEc0QibwZMJG2rn1adk4r9z5vRhLH2iCzpH/SmGS/zps7uAhBJ/16wj8QK/l9usb7435Rkt1paMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My7EJmCuNGUiaoqpKSp5LKy4SQdWuI+IkArRlUtmgIE=;
 b=0LNsfld3xRttHe8F4eryRvaCQwa7VEHeZKbh32xB1RT5xfKgNr+AZfc6XXubmXZpZXujVwbA+8nXS9IrsNXRqMIu7l9/qOZJLwmcjdAWRhksXHvDCWPl0NJoXE9TYA1d6YVYh48VI3wCxYYI2e91hWX8PfChu4Ki5J3//Mt4B/Q=
Received: from BN9P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::19)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:09:05 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::b9) by BN9P223CA0014.outlook.office365.com
 (2603:10b6:408:10b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:09:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:09:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/16] drm/amdgpu/gfx10: rework kernel queue priority handling
Date: Wed, 18 Mar 2026 10:08:33 -0400
Message-ID: <20260318140837.582776-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: e8340ee0-b1b3-4549-1bb7-08de84f7ea15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IkRYlrh3XAyhTjBjQT3RnBB8P3sW/kBvp1KhynldEb4uZQCvhOBGrvLR22YJ5JEr5y63n7YvN1w914ER1YnpDweoC/E0sWjS62Pk/v4VtiuURdTLUyu94pZ3HaYs6tFxhasVF+W5bcj0NeezsVgnxAq7knP56l/Tg/Cvfp0FSm12PqVdtbtbwY+qvfc4kReyKNS7iGD0p6cYXjWE68xqRSU9fdEOTwWjSRqXk6FflvLYSEv97PcdBNr247Oach6/HaA3dOl5ORc1ytG7m/ABp9/UXAu0vC9do3hCBKS8BbwQ2v9dWff1jIM9sOgNuSDe6/BMqtZwPLO4Tm9ZzJgjxDclUHU+5chvzVwa9gB7Gz1kMeM8n+25zaqKduR+kkN9e/2Sa7tkMeYV2bX2cK+UVYLMB+2nyOv1XuZj8VeRersVATZ1SNyArf8lRrK+Xnh9wDd7FyP2M6sA9cFw0iz8z5MqnxZsN9D8yHRerx96REwfI64lTGtIrIP6Rqb2nH4YBmMddgqxJI+Oso5flaCidUpP23A46XsA5yZo0ZWWGBwv7P7GSFwBIM9jDd9b7Qwt6TM3AIoJtoTJr40j7onSYXuHE2GFvukp3iLjAbGuL0Ign7Qq9mykH/SK8P7pG5Vw5tIffk2KyhJS+R5Y2VDFPI0Lv8DXHkUECKobdNC7bYM+rf8eXCdqaurPSSj3x+C7A4oCgjzw1lna/E6UKBpCL+wKviKfrL2ux1NTxxWm3JaJ1OaOQIzmDDtDa0htRls8MyTe+VoI6gRszm36xiAu8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UbHTTfk0RiByYaK04RCr6xbPS1NQR/IpqPVp2EaIZNokpvmxMwXhkNdS57U2pPw/rKyEeJIb9F1F6gbGsqmWrz6ezoUI8wfRQqw+/vX+jazL8v45Z6IS9tutAtMVRpUcT2QUgLPh9mKY6dDyFF8ePEW3ie9r0TKH/WsYNpnH2C1LMV8CspSojHKz7X0YjPLbXjB62xGia+Eg7HxFIB/EwTEBsozPKwg4/fO5awB0myXfmoZMoTby6jAraDx1VCYDeHd64jPDTaICTAJjAyQ8ZLNHiNtVc5Qon0yZhOudvZHclbjJNfJMjQ+hPCxsCkt8NxLW1Q9FD8/Iu1HHEmjMtLWrhBOu5Jblk6MtP9TbcYk+P3fiFjBiQQETedSy99rTMuF0IV2+3Zo59yuVB39hhIqBmlHi5FMakEgZOcwmQ5TaTKsxWoyUXfNOl2HbxFcz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:05.1776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8340ee0-b1b3-4549-1bb7-08de84f7ea15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 58c69dcb527f7..3618e68222458 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6794,6 +6794,12 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set up time quantum */
 	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 20);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
 	/* set up gfx hqd base. this is similar as CP_RB_BASE */
@@ -7013,7 +7019,12 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* set static priority for a compute queue/ring */
-- 
2.53.0

