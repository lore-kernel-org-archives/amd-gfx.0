Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E63606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PKk1zX3b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D1E10E326;
	Wed, 21 Oct 2026 13:16:14 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4203F10F9E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjZKbhNoAwMRxLn7GBvEapOe94p+agU/V1bKFlbrBEFa94UM9vaPv57N+zL3LDSrUtk8D89NKFVF9CJz9GmauJPG7e1RaQX9lzSTgokH5rDUppiCwlD6LjuI9iD1Tz5rQpeapgUDmkPmkv1fprT06cj3wUOH/WD7WGJe77jqg5slkS5CGxmBfYtTa6j8/G3a0pKSfzghLv0PV5j4wf9n0nPrUGLsUamt3uZkwA0EIBxZcNKWQRrTp17yCMt6aCZnhR3kBWdNnOs+yp+7oozHvN9TMajqnjnK5kNaJZ2EOl28eDVywyZvxEA9UXpA1VlDCfGw5mDYVlZsOJfBZdT6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1o7e4MObTDJK82RkTji0dPMq6WHmW5/2MuBq7FouJs=;
 b=Tq7iA6trTBCSjFwctLWYM8NfXu1mVwk7nV3y98y6ljjBo+huwHxk0FOFHw9zvyNgTnrLvGUujYRLtvC0qEHrGJQruN+SeNOjYHN49GmCfG5o3eEW/Fd9FsFqB+sK4ZnNctde3YQuf3g6Pz3mmpVcBkqTdMUlYI0I/JTgQDBYyBBUL+5uiN8a25rfjq3bR31lXwVZ9x2QfolVIUHVNOsALCdKgbMDiHinN6LpWuVR1hSJpdeAJKSshEhQLYBh0oa9rf2eUMLO8QF+DbCLAzaYc/gn1z94hXFRBBWBdXF4IkIzRljZn5qE8EAV/u0QODWrSmMTSsVoR0EN+KEdu29TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1o7e4MObTDJK82RkTji0dPMq6WHmW5/2MuBq7FouJs=;
 b=PKk1zX3ba5Ko4AIXVhe/wa1mV7hSJgd7tDvsdcTabVLdiQCW0VnB3G5as+ifu/j6Vfi9nRDr3c5t7I0eG8EK9ll+2OVlTszhK3CI06M+SwYZuNpe0enUL6khWuZeuKQe49Uo5eKS5mL3GiyALsM7qb91gxXUNCAkuYy7WHqeO8U=
Received: from BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::10)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:15:59 +0000
Received: from CO1PEPF00018869.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::9e) by BY1P220CA0044.outlook.office365.com
 (2603:10b6:a03:59e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 13:15:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018869.mail.protection.outlook.com (10.167.249.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:15:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/gfx9.4.3: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:40 -0400
Message-ID: <20261021131545.1962601-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018869:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fb62a0-d462-4155-771e-08df2f75728c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|261009223027099003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y9jTU6WfBwUq0U7Y/QsJSQiZtUI7DUyrMHNo027MEsmrSX25fS0P8qUbpKIF6wyXw7nR8AzxCUBeE4EbkRVswI1usxADeV+0EEglZFP0jskNQVhtfcxecqiuvVHG3qISpaS90JacFXh9+UdZFUVUU4VLz+LsUAxmUsor6F/rE1yRpRWORhw4BMAwTSq2qQ5c3wUP92kGt1+n8sIETkqh5E5Kpx5xwKfoT06IxxLXwb9y2utj3G3Hct2Y/z3OtksaOOOpEQeg5CG15gD9lPssmsXQQucH6cBUQ/nBH5afPylpsyOkumblU+HUhSRDrdcUC7NWeisFRb14mAmaOiUOJKMLB0gcCeYYPTZWbfFiwbZ50IL2Q425xQ4uCZwIkY8033lCNVmiKUr63qgSwLmHFS9oRwB4whz2mDFBjCG463FzJMcK1vbJe9NTsV0H1noHuXaNs2qzOxgkE8nNQhmI3QO/W39r0G5qG36BjeNTR9J4g+pb8GbPHRJUbeCvsNBkmJqihNaob5NExbf5zZQ7HCHpH2z1TlCqmv4s8aq0r9o2xVQji1fTwNabnl492SBzjvCrdJ6Os1gGxfLbD5orhFkc8KCkmNEvhq578gH1bz+Lx987w/Gsf20sthyAt19CP5GS+Gq8y35ERmwdEmkQJHR+IbLuE/AtFqLxAIDYvWnH8nn7JeJqFymCs7oFQdPR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(261009223027099003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XQwYXavH7KjJPboySEhpoCs1cqyFTka8UKJRTwR6PhS97Pj8vDXSPXgNPvbBdwYIBWYUa8A3zblEAuFotQHeEryf3MRkD+61zEla6M30EORvY0vI3KQAelkUDbjlorLB7r3pWLZXESjHAjPV3HDeGihHxxeqUTSLXCOPXu6LV8p51fA6BS+oCLRx0/jufB9St2jbjO1LJHhGP+06Dp8x8oQCcO19Plc61bpTx+QzATI10r5I3V6EyyRUyiBq0GnCR+mtNWLZcTz5HoqCoBlVYhvymiTU70080u80gDm0Lz25s3jKN6tDooF6NRGHWEL4RE5VsuUmdmitlMcuuWdxUN+2dWjhFoPfaWqLLRxlm7TvS5oCHFQuVvKafbx3/CVhvLPLTeh9LELwOMCL8sbArTEwm4O0LVH8rIsPCf/gxw4ws+44qqX/QOcfak7J6wyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:15:58.8017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fb62a0-d462-4155-771e-08df2f75728c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018869.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d66c7901783ed..2240f61c5e6bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1885,7 +1885,10 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
-- 
2.56.0

