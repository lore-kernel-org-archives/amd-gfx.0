Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1E606A81B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vjpuKIN7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A96B10E7FE;
	Thu, 29 Oct 2026 13:55:26 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEF210E7FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcP7F+lg5/HLJcvw7LDBsLAqRjxAVuupW28Xwbizc6UvQ5+iFPHrr62WHTX6AiUNlzJJaDmJjAdiDRg7Sc2feZgjZ1rTMkWDK8/nyc9ADVoC+LlIVAWblHcAbbRS3kuNaYmU+KIsSpExJ1P3NHMcZs7FxUXKT8EQPOpVCkaVmLA6kh70IdvKJJgfcgf7qKaxYK6iuY32tuMFdqutYdaqdrEOC+6sFwKa94c9+5mo1EFo8DeE4ALUwdNuCcHM1yFNuYAbylGKXdgrq+Y34VgArQNaUVoZ4Kw43LnEdSk8INWzbSqwR1yN2u8SAFHj+RTwohAYuF3m47m+ERI1mMv32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk4u2OW57pth8mTwqtHWFGIWUXk5O+6zflQ2OZ3kMq8=;
 b=HLtgmQSAvJvuM6uMFlxbj3AKBhlvozL9gOOpo9KGCBh0MRqAtDbCBQ4uuTJTpfG7s4CENIclDYPTZGcqzjCs69k2Ju6CEsLDy34Ryy2JwcrCLeyFwZAl0L6anaoWecYHcGPQhTUytcnbB/HegN4PWz6eKL6adavX0ETIWsqdrZ5onDCPQxbp8aoHqyI+TXQccud0pBkUCoA2HtUv1FeHKLUhMFYNN+Q1ijTyPBkE2vLC+0CEwhXIlj1spmM2JX84+XmmZSVyAYfMAZ8/uOM/MSbTL6Gtn3ZAosJGqsoXlly5YxYW0OXvHptOC8/Oti4Fkubl9rabH6Ujrz5lGvDM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk4u2OW57pth8mTwqtHWFGIWUXk5O+6zflQ2OZ3kMq8=;
 b=vjpuKIN7dHFHzOOe3pAZTVU2Juuctq2mrEZ+azYCKMm381UvSGZ9iwqFqVy3ulSkhs1BDYeMYM/dJi/EfKoB2sXlguu0sg3F+H9Uy1ho9298XoU0CDB3vMpeRsew2LGdqruUZkjxI0O0T5oZYNnqMcZNqCSbcsGCLzclZq4ugIQ=
Received: from CYZPR14CA0034.namprd14.prod.outlook.com (2603:10b6:930:a0::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:55:15 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:930:a0:cafe::7b) by CYZPR14CA0034.outlook.office365.com
 (2603:10b6:930:a0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 13:55:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 29 Oct 2026 13:55:15 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:55:12 -0500
From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu:smu: Update stapm_power_limit values in
 gpu_metrics for SMU14
Date: Thu, 29 Oct 2026 19:24:55 +0530
Message-ID: <20261029135455.1822487-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 452c3879-0326-468d-c58b-08df35c44281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261028144727099003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261022113327099003|261022075727099003|261022115727099003|261026135527099003|261021123027099003|261026130827099003|261021135927099003|261021121427099003|261022105027099003|10067099003|261021130227099003|261021133027099003|18002099003;
X-Microsoft-Antispam-Message-Info: RUQ/IUPQhIzuUAfg9RsMXqEzuzTtmgsgkbfb9mlOJTKJLa/Md5nu9RgsiOWJ9aWbp6FLftA0kRdeZ8RbgMphFBuY4rzKKF0RhGwSiyiAaGb7u8DB+l0Vj1g4z3zxYs0Fj9s/ThxRjFEZatX/C69t1vRlGN/Q7iCI9Bd3PEHY2kDbCCx+fjxXNuSY1h01uPGvqmeNSEc3zQolwrjKMGysciivYvcoN7Hg2LBHO31gvpaFhZ1BxTv1D4+kryYfQKGGrP7g9v7//2BMcsyZN4zOOr+E/wgSfsmrU5kB7nkRWvh/I81xAwRMgXpOkrnM90DLsRUsgCVOmt9rmXbwlKeGsJ7N8PuY6en+JaXRDCME/t/Wi6xRUGrpyBLZCfqC/kd8EGjd0xKlt6g7BLRdMflc4APmW3zPWOMahd7b1CyeJMDdV+n6PO0acTqoVBBlrIwhAY3I9HDNt98fMTySsdfg6BSnZE2JrSdBHUcjMWG9Q/SoyCKtJcmsaia6zRmwxT8cd7Gr/mgU6k9WePXaSJsZrEAk7PYlzhK0j+Ko4iLLL9D1izBxUklGe9yVmvKLCoBWd9P3C63cbIUAff9rBBWtpzwlXiLOBy0GFdPIfpJhTFAklY3hdXEOqgBizsN+CYTsk/bzP+rWec8fwZg6G2hU4GU8DvFsZwlW8lK62Vbpqxjtw+qmnuoW+ODFQgpApUN0oarflqgrI23kGDnKcpJAhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261026135527099003)(261021123027099003)(261026130827099003)(261021135927099003)(261021121427099003)(261022105027099003)(10067099003)(261021130227099003)(261021133027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W70cpDp44XLRZ3LU44zz047WsylOhTVdKwyf84Mn1R8HDbDukW8cxVTmq6uSDIA+h0EkZ1U5OIrSxg3tBgdiZKztGlZ1hYkaE1BQgbe2XTq0XzuvDdV+ljDzERenarDL0/atK+jrKBow+Zmxojtbzp1PuRKRzmU2u4Ibk61RsAY5it+ZgZA8sdFyY4KLxOlDL2IjQ9OYc3jaXZaEORiNObfgaWXU864vcEQn1njJxY2ZdvC6ov6eAkRayOO+juqi5Mq/72Y1pDJXYXFhLE2Xk18kSG7EkDHvvAk7gD1vgpNwDyrNyAg3/3JBWcsVd2O7dX2flLE7VwJ/8R+69VmcE2zbyrQB4Th5v8XxogFC53ivvLCoX4RoIkUU32U+2XOW70T5dFk20ElwgmQfKV/ElRtC37bOBjju20JOVeU4Qkk2jObcNkFuwAQQoN5aHNsL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:55:15.2888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452c3879-0326-468d-c58b-08df35c44281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
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

Allow amdgpu to read and update stapm_power_limit and
current_stapm_power_limit values in gpu_metrics
for SMU v14.0.0 and SMU v14.0.1.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c83c58d5a2e2..94e3401b000a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -637,6 +637,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
 	gpu_metrics->average_all_core_power = metrics.AllCorePower;
 	gpu_metrics->average_sys_power = metrics.Psys;
+	gpu_metrics->stapm_power_limit = metrics.StapmOpnLimit;
+	gpu_metrics->current_stapm_power_limit = metrics.StapmCurrentLimit;
 	memcpy(&gpu_metrics->average_core_power[0],
 		&metrics.CorePower[0],
 		sizeof(uint16_t) * 16);
-- 
2.53.0

