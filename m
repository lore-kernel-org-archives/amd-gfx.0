Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39883F8D761
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5E310E916;
	Thu, 16 Apr 2026 17:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KpV4rz7g";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2325010E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gprRgJunP/bgVAX4LMQTzPRzd+fW52iSEdi+WnZekh7coXsn32kuVxqX3AXtoYKnlHl7Iz2id/k88rmljuMepx+GYW7hlrUmbzDOdklovQP2gbwyF78Yi5AcIgd191mIm1PL90Zki7eMttDx2s9pd71N/9aPCp98QxW1ioE0Epi+dqVA+jkf3EGpfX/ElY2/TWs0SdhPUCHLO2p0lkm+8uhGmpOI/Q370djvpBwfQ9a9YJVkAqI4GWLb8vnNbxtfun8osFk77eCY70mTmGOcZe7H2GMqXz8QGvvkaFTM1Lbdo/jADWg8MJoUpG5ImO1vJDxm4mX12FeVnjs8HGDaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHDw8uRpG86/kJVRe30LK1yUvqP4mIdRiTJDS+HxQXs=;
 b=sPDz+lDJHv5ThNPdDq6C4SyWwUyI1HsksgovIdNyFLuCnpQgBkuuvgtILp3+Y6eMuVMS78/H1klhKD91cLjcCeiS3ZfutuP2aNdJC7NJ3m5VwUqdX2vj8TwN1C6ayHVjarImMmwHYIhPrpBz2xtlZcJhIl5CpUjg080/y7ZnI2oJdtkKWSn49beVNppx+OcJdoO24QOvBZes3xDhDQOOabyCdCV+HZhjzIPtS7dnjNC6Zx3KQWJIwyRLmTh1NV1P3eHM4AueTQFamXswuRUCR4/q4/rXZ0JTM0KJ/J2Ynfa1xvCKmeEoDYcWgNyQVQ0xcpBf1xhKV9dSlaemnuttRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHDw8uRpG86/kJVRe30LK1yUvqP4mIdRiTJDS+HxQXs=;
 b=KpV4rz7gbmfBtwAv9DqMENcSMTixLCj1LvbQIYCyG8PS1JjnnVUsb/EMofStKMYn3sRwXHMnI/Ta6/0NM/Cew1IO1SLVRUzGyadFYka51F4SFFA+EDeprzMJfTqb0XH0GkEKX5rTI5q1V6exU6GXJNwKCQizHPE/en4Qd3GTdvA=
Received: from BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 17:32:21 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::b7) by BY3PR10CA0012.outlook.office365.com
 (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 17:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 17:32:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 12:32:21 -0500
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 10:32:19 -0700
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>,
 <KevinYang.Wang@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu: smu: fix unified metrics handling for SMU
 15.0.0
Date: Thu, 16 Apr 2026 23:01:45 +0530
Message-ID: <20260416173145.856326-4-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 86230914-0929-45c1-dc63-08de9bde1dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tp7DtNvtVfz34dhnT1LLwU5nX5bRwDgdSM72/aBTucGrD1atUk0PZ63vPK5GcnGl8VrFX5qL3o9j1ptK3bcCjk68cYaG68KheMwdYSkCG8col8kmY7XRRvjQmYyGbCAqPOoi53H4VTUe2COv7Qv2fUJC10GU/aCKmtwsJTkJv5F1LgHiw4oNrYHG38xat/p2Wwj/Hrs3HeUyicrq8F6vVHhNHVBDPMOMZTg3HJChoPRE0xzmwvkOpW/PCmJ9RDfncMTo5D8T64+yoUoG+YLzihf80aOENgXhARFm3MwVL9FescwoA0TeUatEy+hCNt3vSqON1V63rO4FayRAcIaiNoJaenmlSEqU3CTju5J6dGp2lnH1w/Oiqg93KqeOGGsIAoPrNe6fjEVS3dyi2cbZ76zdPgbXYcPhIFTSXPGt1LLu6IiXxDepEkLnnjm0DBgBVxwkNj8W/VSox4nuAFxnkbxIvOy/Y5AxUBc4G2jCVBY67IeiCgrliMuTGH/EI2XPw43TLQ5rwuHSt5kC92arZIWdOHT9tUmtXPFtdMx8mefa9NeYegc6/+uDpFpJUFc43BzaiqTR/l7S7GKiO3q+Gp40OBlVGt5yjUiwAfwFEfQ9WAMthZ7xOcE+48WtZNXXvnt2qEcUOTB0vI/Dy+D2JcYuf+XT4nTRoFXcFpP3D8dtYau1AqQ7RRAnDAnCN6FS6xJEDF8PWNdV/zR+4CNPsf6rZcYJowuuE26pHNrqPZHbLVGzMhs7Sj9EHfIvJyhesdcmBA4hUEOKszsNEVW1OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FVIUNPdjjh38QMj4X5iRLgTuNxxjEyrqHNvL6JVrulk9WIpHee7hORIsLyB5Zlfoi4YPns5stSNah0ypPbsosHRL7HdPTkLQkMgvCrol2k0OjXPdq8OvYMOFmrMncQlSRkXE36zsTlcWWRA1EUQj77gbFmAqmicNNA19SfTqup8SxYtY4Hm3pQEgxSlLBVGmTY6+Nj4LtNjkwO5kshKj2sZsov/yu6JedPDy0IBhV/ZpJPPNAcdTBQZR3FDB+9gKlUch64fJUQVd6ioSf1cRnFv/3yJCS3Kojj4EaQZLa4wWe3/xyHm6ihczuD0ACTy1ff72BPzKTy6U+oV+41ak6nUzpaZ3iqfkIGtz5wKPTqODxS31AezQAcw9PRed03/ODS7BuaY8eUBndDN9VNJsedklA9k6l5nL+OiOWrNJHBKL3OSxv5Tg+O6BgM/SPuBF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:32:21.6399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86230914-0929-45c1-dc63-08de9bde1dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

Address review comments by invoking SMU_MSG_GetMetricsTableLogDramAddr
only once during the first metrics request. Cache the DRAM address and
metrics table size returned by the SMU and reuse them for subsequent
metrics queries to avoid redundant SMU calls.

Add a NULL check for the ioremap_wc() return value and ensure the mapping
is released with iounmap() before returning from the function.
Also add sanity checks for the SMU‑reported metrics table size against
the expected size and perform memcpy() accordingly to prevent
out‑of‑bounds access.

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 41 ++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index f0a798631903..8f97bc6b6235 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -336,26 +336,35 @@ static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 					SMU_15_0_0_MetricsTable_t *metrics)
 {
-	uint64_t addr;
-	void __iomem *cpu_addr;
+	void __iomem *cpu_addr = NULL;
 	struct smu_msg_ctl *ctl = &smu->msg_ctl;
-	int ret, table_size;
+	struct smu_msg_args args = {0};
+	//store table_size and DramAddr value returned by SMU in static at first request,
+	//use these valuse to read LogSample in case of later requests
+	static int table_size;
+	static uint64_t addr0;
+	int ret;
 
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_GetMetricsTableLogDramAddr,
-		.num_args = 0,
-		.num_out_args = 3,
-	};
+	if (addr == 0) {
+		// Send SMU_MSG_GetMetricsTableLogDramAddr only once to get DramAddr and
+		// table_size at first request
+		args.msg = SMU_MSG_GetMetricsTableLogDramAddr,
+		args.num_args = 0,
+		args.num_out_args = 3,
 
-	ret = ctl->ops->send_msg(ctl, &args);
+		ret = ctl->ops->send_msg(ctl, &args);
 
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
 
-	addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
-	table_size = args.out_args[2];
+		addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
+		table_size = args.out_args[2];
+
+	}
 
 	cpu_addr = ioremap_wc(addr, table_size);
+	if (!cpu_addr)
+		return -ENOMEM;
 
 	args.msg = SMU_MSG_GetMetricsTableLogSample;
 	args.num_args = 0;
@@ -364,8 +373,12 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	ret = ctl->ops->send_msg(ctl, &args);
 	if (!ret) {
 		amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush before copy?
-		memcpy(metrics, cpu_addr, table_size);
+		if (table_size <= sizeof(SMU_15_0_0_MetricsTable_t))
+			memcpy(metrics, cpu_addr, table_size);
+		else
+			memcpy(metrics, cpu_addr, sizeof(SMU_15_0_0_MetricsTable_t));
 	}
+	iounmap(cpu_addr);
 	return ret;
 }
 
-- 
2.53.0

