Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E02606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z1U48z3P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C3B10FDF9;
	Wed, 21 Oct 2026 13:16:22 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B0310E03B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1IIGD7u5wikh0+kACYdHeiWlVtUUDWIeFGImCWmTsLyyt7hmudeIoZHN+oxrkwpt0USq1+QAp4aHCblz/ztp4W0DddWyxWgCHdtzSgIffQe+kHFW2tHC/CxKNilAIk9tX3ai9qnm2fSyZbEkvb0PnpXfwzDUlSDtEV6Ehat3rWcT6Lvb2KIflKeNoEMYyqFqHeXsRcFXVhypW29FW23mYJpf0gURDO8Vju8UhcKVH8wu4mw1fBPgXFrFaEB/Rtt91JhCL32VmHj+HwMhIJspIBARI78w8zYYZqTJQXtctwhNspYdfbh1mX1tbNhFq4CPipNyBE/IrZzX+mJJ4V/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7APgYyRDMqC8nS7JO1siQVa0TrpXajydjqi//Qj/8U=;
 b=sHqyPuAJiWRX2hWLTzKfqLvyTx1SYU4uxbp2mVltq2dFq2zBgQRS2E/nIbpHu4ipbVN9XxblJwmVQFgvmG5CysBhTtH7MdAZP3edFtCzW0J90W6XkYp5WchbnGVxPwfFMMdsya4ylQbodgC7+01Nc6y977UJuVMMiRXj08hf9Xp14A5BL9m8YeKrX8hA4r/wv6SwNPo9Z4JzLPeccH6CTMgwxkRT8GoxiHjhXvtXfFoaxizqvjs8aER9gCzeXNLyUOOxLgy6nkv8ARpD3c/+9g8xZzfVhUJrVuT5zP6lHP78CBc+jz80h0yZcZQHIXM2pDm/GItmGokOT9BgVr2D2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7APgYyRDMqC8nS7JO1siQVa0TrpXajydjqi//Qj/8U=;
 b=Z1U48z3PbPMqXndemnYkjiUBehPzUJG7LUcS1V3HC/sKzUlyfmOfqF5fmTdj8G50MYz4cfQOtpLof9jT1OQMDer2rtaigEO6LCClJRq7pJaI7DoNKuVTmQ93eTw0vO00DbBPOlsbfqqB3yEfRfLXymVv3M/1fe7rSN6T1kkiaHc=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by DSVPR12MB999173.namprd12.prod.outlook.com (2603:10b6:8:38a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 13:16:00 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::94) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 13:16:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:16:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/gfx12: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:43 -0400
Message-ID: <20261021131545.1962601-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DSVPR12MB999173:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bfc2ce-2466-4d3c-c8b9-08df2f7573af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: mTpIu5jUnJy/uau1aL3PoGr5VM5doH1TL3hKZl+BrqvrZkzXmlvSUkNgmUsqrVBW+JDPWkclLXwAsm0AiMnrLLtKtiLgEPqwQCr12hXfYplAQn+FBqZ+nUzzKVUegSlbK9qbQnTllM6vO3Igf1gYa9fWS00eG1ZtHEzL/IQ6VTIMpVvq9Xf+f2bZy7MdhKVRBwzC/FBtcjKhhmH1MU0zjc+G6J7aqS4X714799prIYqlR0HzHhiLsrYVGVKGzOGzVZkVQOL4nAntZmFYoRRfGQjHbx2PMVW4hxO9xVuH0H9X8WEvGiQKQ5IGVgBZvYU33JrIXVX1/vSBqYZ78boq9gtJbQWCk208Lp+20+4QrPow0GpE4bMfWRPiMzgKbaSi2+Kuc25GBNNjnIMRb70dektBMcBaGE/CBq+MGussIo4xtr18rvZSdKnW8Vu0TQP58ujRotgPk0e7Nl8RwSdYQU7Y+aTDOZITG4eufmf4mP+IQJn2uft0jFx9gJtodwCfKlZZJBRlFTFxtDHUbb0IMLvq5ZFD7hheXjPnueSRkWgm+uZFdAJQlmJ23o6uGFTJnRf/B51TGxrLjxAirUfRZ7cDefFA87wYOq4bFqi3D1gduoLEuuvOGSKAjm2pEA3hP11j/MXCVGyBQPDx5098/VmrEWOtliJtcqwTtXuV13KcYfZKoV1ui/nkOxFDVHZK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YAlUnLnC79PXO9QBpGmWTxHIQFilXPKJXrjqXkznFKOHo1szV5Iip2eEAcYg8dxlZTOn+YtTbkpuQX3SNXOkIDJCR24GbQs1+LVv1qM2ExxEPHsvkDt/bQ2xEM8MiZCFTCth4EUcjw2OWVht/XdfBOdHrqJyn/OgpWwhS/jbDn4AjKEpVVG5pZfQ1Nvhme8OUf15IQWHE4iBGIoP0WdCW4n6qArXK87NDhsYbWvEfuGk5MAF4M1RBz/mMonP4Zz9lr1G6uIEdePFjbhwI5kyn4l5nEh0OfBgxpXYQpMYywE0U/W12nq7NSknRsFXdzlwESlc+HM3AsgPik1fxR1uAc6y/8sXYgGNlagkwlCMuvcy5/COaksh5NDo2AaKR0wV/3l780hYbZSoET4/fJJoU5MS6cebW3YuxT4P4T/abXEmYLMbCvb8rgM2xQWLv4z3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:16:00.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bfc2ce-2466-4d3c-c8b9-08df2f7573af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999173
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb8050201..b9f847d9c8dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2945,6 +2945,12 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set up time quantum */
 	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 20);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
 	/* set up gfx hqd base. this is similar as CP_RB_BASE */
@@ -3213,7 +3219,12 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
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
 
 	mqd->cp_hqd_active = prop->hqd_active;
-- 
2.56.0

