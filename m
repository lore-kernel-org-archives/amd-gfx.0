Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A1CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46B96F503;
	Tue, 30 Nov 2021 07:43:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CF06F4D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4Yk7cAPs5HEyZZ2vSjtCdYPS9aUT2nmsy/gUQ/G+CrpHgUxxbdJaHboMoe9t7nsUnb81YHjvslZQjNuYAakv+cN4L8ZwBIPXmzxbwdvCMcQ9wLN22tvzvkjsSFBxWftPqDFdHMpkX7ksUf0aHGqNUcITUL7+/8eyfhbcUS9HpJWR9FKRTRNDv6vEeD3bGDPJXviCM9UjW/RHJKeasieWpGg2Nht5BpnFGrWAeBVu1Jo3YFKYKoKiWVevRib3Wwk5VrQe4diXy43aSMpRWj0CnB2txLJ/HaU7+PHRSxD7+8Bc09uQcDQw6Iwtr7WsqhXf1nA9W59/x6+TzhJLBNbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BL/W8Z6WzJuWZUn0rjVEO/nKgLlGpjt9nffpvzjNoU=;
 b=AnI6tuzIR9YQXDyoocTv/Clk6E2QYDeS+xlawB8/yxwUGKvM1iDo+SzMt0ERl9r7NAwSTkg1fYJcGDuiQCPvFxtOQt2RGQiofHSNVQrMNteDmqgsTh/gJZjfjOgaf+mmjizv9yoOgAacYvStHk2qdu0u6pDLSQV0GBmfzV/bF782OwQ4+184Caw5l/d2wBSsgaLWB10zZLYVj/pq5CMsK/hnpm4W/UmDVYItieI73FFYVJmVXtQPkcuYS/pAACxHnp1g+tNPmsL7qxJPJm5vPSMJBoyquDBQBs/+CdFWfSlIRR7bjc77+3xT1wWWOeJIFlbfOTk7L5IY/5T7xZdmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BL/W8Z6WzJuWZUn0rjVEO/nKgLlGpjt9nffpvzjNoU=;
 b=d0uBFNKyoQXxPOqQVMWP63JDfiXCvWUD34W9c+XBZNUGEp2EqLuK7G+ZESCZ2rv8dThCSIYShn3gLFhWLL3t4lxR82Zu1K+qqmH1QfECfF6BhDcw43EapXdZmHWL4siEAI4lrfzXKQNCDV62XSQAEYWjyOs2+dw5KP3ibul4RTg=
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 07:43:54 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::d7) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:52 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 15/17] drm/amd/pm: drop unnecessary gfxoff controls
Date: Tue, 30 Nov 2021 15:42:57 +0800
Message-ID: <20211130074259.1271965-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df10234c-f888-4e14-a020-08d9b3d528d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3484D129A46E360BEC8E74DBE4679@DM6PR12MB3484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Daa6n4smOVXwee9aLjQTA2rW4Wt1i0wAhTzPu9s0rITp2CagOCKZCfDoXIOppMSCSVhdfFAbATQEbbfzeCwdB5IAMUg23tDFspZWionNEMAebMWYylEpYdFoyKsIKZIRy9nKpjgdOn//LVe5HS6PFp0l5DrhWr/8zJJG99FkPM6Rv+UnRXHVT9d7q4NwoDbik71WsOXGIzeZk4ACNQMJ9+IyWzeQd/QLhtjHqXdxnPe16dmFP0uOYy+4nBpOH4lB61SdMx1r+UQ2F85bJ35QylLMwsMDsMr1YqJYAQ56EkhmA+1Ydds7cTyMCPVaDHK1wqNiq4QWIgf0Zy3QkmfoTtiz+9K7Hn3oJsec9b9bPkLkk8KFw9DwN/C5qv758zurE6t6dJex4W2uS0Cai12wP45D+EjCsSmSdapKVW7EBH7s5Sg59Y82hLVDOtv8f/5WV+TT6tuovPWubNXI7pYUAiCvga1C3NVWhYpu2cABCaJXlJkO6uCBAOVrs9MIq6H1+LPsgAMAQzCaP8ndMalcWp0zbiwEUrlDLJtpsWRNzEiHzaOPZ8nwETSrqvIg7HZGfxnglR7dS0ZoLo1dRlcK5bex7YdeZZJtHSziqEvVl6lyxC7svD4/7J5cBDz+NAY/tQ+XkbevReMRB7SQKhTywUttW4L4k1xfISogJ7VoArV7gvVNVslHqr6bbmZmSrGYObiHF/vGzq8VEWDApXmf4oV498tljT0ZPtxlqRgdPzOhGGjsFv/zNyNixjNle2VvivAEwWAaSCsswkMSgfx9rmEyfDDQKDRD1MFFdXCeh+QJBbiq6Tp9kaLRGYu1ytwYAWpgijdfZRB5SZV5cjhDwmSSFXKSYiRBAtzsggB1pPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36756003)(82310400004)(8676002)(356005)(81166007)(336012)(186003)(1076003)(47076005)(16526019)(8936002)(70586007)(44832011)(86362001)(5660300002)(316002)(70206006)(2906002)(2616005)(4326008)(54906003)(6916009)(26005)(7696005)(426003)(36860700001)(508600001)(83380400001)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:54.3353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df10234c-f888-4e14-a020-08d9b3d528d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those gfxoff controls added for some specific ASICs are unnecessary.
The functionalities are not affected without them. Also to align with
other ASICs, they should also be dropped.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia8475ef9e97635441aca5e0a7693e2a515498523
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +------------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  7 ------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  7 ------
 4 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2c3fd3cfef05..6f5a6886d3cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1541,8 +1541,6 @@ static int smu_reset(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, false);
-
 	ret = smu_hw_fini(adev);
 	if (ret)
 		return ret;
@@ -1555,8 +1553,6 @@ static int smu_reset(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, true);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6a5064f4ea86..9766870987db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1036,10 +1036,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		/* no need to disable gfxoff when retrieving the current gfxclk */
-		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-			amdgpu_gfx_off_ctrl(adev, false);
-
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			goto print_clk_out;
@@ -1168,25 +1164,18 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return size;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, max_freq = 0;
 
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1220,9 +1209,6 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	}
 
 forec_level_out:
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return 0;
 }
 
@@ -1865,16 +1851,7 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 				enum smu_clk_type clk_type,
 				uint32_t *min, uint32_t *max)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	return ret;
+	return smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 }
 
 static void sienna_cichlid_dump_od_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 2a53b5b1d261..fd188ee3ab54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1798,7 +1798,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1811,9 +1810,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
@@ -1831,9 +1827,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4ed01e9d88fb..1635916be851 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1528,7 +1528,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1541,9 +1540,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
@@ -1561,9 +1557,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return ret;
 }
 
-- 
2.29.0

