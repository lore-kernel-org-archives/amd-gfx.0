Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53FBD65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723A810ECD5;
	Wed, 17 Dec 2025 13:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="af/kWySr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA81A10ECD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxUXgU46AP9JpFvcpw10CrRjduTGsK4pfAg8D/EDNt81j8JJx6dFK1pNJLFnedP/bYQYImH+bz0BMlysVhDBGkv3TkWfExxmR4NfnupEtvR2ty8R2juHKVgExxYllueDYI+gNOBKBTqAmqymqOCZJp+rqnw7i62Aj7GhyMDuTXQYvqM4dsUMNA9FzsQktTQA6/d+GXy5LnMTAdQKG1SM7XLEYiAkfzB8EVVeFEYoms1IsSNI19Ff/YKB7+wd0NnW52UOhR/GWyhX3scRZjxlY3t4x4Tmq/3Up9IxAx5WPl7SbAVFQjW+UJZS571/pfBdmY+nPK0QNbmSI5tAmYyjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSrP3q7Sx1TNZ14udyu5jqVl8T47K8Vc5lYQKzkabmc=;
 b=OCZU6pEU3COIBg0mfCPIPiZdhs1ZJoCNhoHvvsHX/aTjH0hF/zkyoN5/f5LQUWHAW5hW1BscQ53p3xNJJAxiZKH2iKomvFcIOZ3a29hD0F0Lekk6PDzGV7z52Q0MlPJW0+4ePJL1oPZBmaOiZgnr30ecOoW+tZSPirwiiERBOnH8rvUr5Himk0H8JKoQ9vIZurqzp0645wy3lkq2hui702clTP/L62G3chBIVjCHugoVz2Y/prpwuQS3Oo86wC5UetGp7Wst1dWh8ptzfL9oFoWr2uNOhm3MvJIJkKG0IzxvUsT9WiV9x2DNJHsuDfubl+Ty7xfZDrbUvvlnLe3TzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSrP3q7Sx1TNZ14udyu5jqVl8T47K8Vc5lYQKzkabmc=;
 b=af/kWySrf26GQh/CjWs1HugLQLtX7s1vkl2+URbkClTWz4io1UAlfNzeaRie1IiinyssnPOleTdHpA8vTx3c3OO6/JZfHYZF0A9tXs5Gyo660fIisDq7XejUbZmMxod9w+qs+7vTncfMAcEg8sCcmi7SGeINuCifdiCTKsAmyHc=
Received: from CH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::24)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Wed, 17 Dec
 2025 13:55:06 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::85) by CH5P222CA0003.outlook.office365.com
 (2603:10b6:610:1ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:55:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:01 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 06/21] drm/amd/pm: Use message control in messaging
Date: Wed, 17 Dec 2025 19:17:59 +0530
Message-ID: <20251217135431.2943441-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3d4325-e431-41f5-5ef9-08de3d73e2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qYwTS2yrh0oKGCsQO2KnIN7MgsWjIBhPnjYm7rWJgqbrP1Rrr9FyjFAnBdwd?=
 =?us-ascii?Q?k3PuLAUnCf+T+dK+nifCCF5VCPXrjOrc7/zXAurNG0E7PCdifyxTh+A6W77i?=
 =?us-ascii?Q?9BJ9bN+qHv6DSiJjpIWoKm+P/85VKmFrbfHQULuSHsZ6PFnPlmjkuFsnqrWl?=
 =?us-ascii?Q?CoMCzQGsU0Dw3N2VluGgUVyESUbuv5kxD0+N/PllKRQRMCAbNb9Sosx+MmGB?=
 =?us-ascii?Q?1dYMEFvNaNXDd1bezaemdeZYvOm6rMUko5jx+rZinpMIBTSoHFK95sx2EAoU?=
 =?us-ascii?Q?zysmi5Hx42DNvWwe0dcwCDJvSzvb89Ym18r0K9pYeUVRs/shzYuruftytbSp?=
 =?us-ascii?Q?smT+gC31WtpWhT+9GtdyyxaZBP0xw5k4yH7sPYz5eP3++5/TMfz3Z+/ZjJBs?=
 =?us-ascii?Q?eclc3uaoXOUabv11Bb7XIetVa+isWS0lzPbIg/3nENNocRXVAd72WxgSugPZ?=
 =?us-ascii?Q?LzXFK4ZsPGuxbasrF4DjyR0zs+zhb+Vlb67be3dj6KcazRPU7in/8toG3PPT?=
 =?us-ascii?Q?DE3LbD3PoueLDdbnO9HMl54frzdi/ok3HvLsVHLw7R7xxY1xB9X2E5LalSTR?=
 =?us-ascii?Q?A4NxACXXEe03i+FOc3shKIYqbSzaqj7xWVtx6XO9B9lOtWTXnx1KGQNQxmlH?=
 =?us-ascii?Q?aZH+md9ULT/AG5e+ymVxPLj4538LnPSSby+A9DfK+wxv3eOxWawpsQEsvbxT?=
 =?us-ascii?Q?/RccvM0zQfHFHGDE9U+3I/IMHsbkEQEOe35Yspb5l1R/ccoCLs7o7l1E1hhS?=
 =?us-ascii?Q?SZYl/jrKE2XNRWiM44qpKwikxc0uVmgcGpOAhvPrSrJ0Tw3Q004t2gVuspjE?=
 =?us-ascii?Q?vm7A+cYbbtosSOGZ2qBbWAwGHooe2YpQCwq7JSkDQAVzSIABWMh6N8zEdE7m?=
 =?us-ascii?Q?OzFdQwuLMuuFdfOxVRnGd7cEJi791yb6k24EAoEcvtiXH57vLT/xJSJukmzN?=
 =?us-ascii?Q?OPODO8boX8L95Vjvu3h7Tj9rjwT9PGftWvEjeydHCkXX8NdQPb0nMI6e6mKw?=
 =?us-ascii?Q?nK+aH1Ftzf6FJrlbJv+MS93OsoPl/K96CWAyV5LbQMMTnpgDxigiypg2pYML?=
 =?us-ascii?Q?gaD9b1cG62PVTxzWstZugBJUtBgXQwmVt0VJIeesxu16jcdYSwsYagySM4f7?=
 =?us-ascii?Q?ACFbq9gEDhMCaRWTePZkfpWtWeY1iJbRUIYwmSaKm95zthEYxcAMilHGWUG9?=
 =?us-ascii?Q?b7xgc+FSV8sj7LqRWJLBIK+xybniuXhi6w28kPuvkOzp4tLZxhENrcLbvQlQ?=
 =?us-ascii?Q?k4D7ZOowb6EayHgqz5GBkW2Urzw81gC+vSe5gS9G8u41Ew2k5zk94JhZpV6H?=
 =?us-ascii?Q?/pzDNoO11h60AAHkZOwYNtgC5HChogdSm1jNbqD+G/2XWYbcpWMPeBaXsoDj?=
 =?us-ascii?Q?97u19buYkia0PhFTCIuTdAMT/iWkPii7bhsxGCvqOnNAl2bTpPA6OiU8tgpN?=
 =?us-ascii?Q?XNwqvDwkmCRtzDVYmywdyj17CVME/HTE6sL19ubbw0Q9IBAEFJoo6vskw2ZC?=
 =?us-ascii?Q?mE2iS6/6BRYtvmDbXAJXHXoIrfKNkkRs+RlpQZNc4kyJ3+3mzj89J00oD8+Z?=
 =?us-ascii?Q?WTk2hhFLrad8IPtc8LA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:06.6346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3d4325-e431-41f5-5ef9-08de3d73e2af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
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

Use message control block operations in common message functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 92 +++++---------------------
 1 file changed, 15 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 266aca5ed559..1e6a8623a300 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -372,22 +372,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
-	u32 reg;
-	int res;
-
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-
-	if (res == -EREMOTEIO)
-		smu->smc_fw_state = SMU_FW_HANG;
-
-	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
-	    res && (res != -ETIME)) {
-		amdgpu_device_halt(smu->adev);
-		WARN_ON(1);
-	}
-
-	return res;
+	return smu_msg_wait_response(&smu->msg_ctl, 0);
 }
 
 /**
@@ -427,70 +412,23 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int res, index;
-	bool poll = true;
-	u32 reg;
-
-	if (adev->no_hw_access)
-		return 0;
-
-	index = smu_cmn_to_asic_specific_index(smu,
-					       CMN2ASIC_MAPPING_MSG,
-					       msg);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
-
-	if (smu->smc_fw_caps & SMU_FW_CAP_RAS_PRI) {
-		res = __smu_cmn_ras_filter_msg(smu, msg, &poll);
-		if (res)
-			goto Out;
-	}
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg = msg,
+		.args[0] = param,
+		.num_args = 1,
+		.num_out_args = read_arg ? 1 : 0,
+		.flags = 0,
+		.timeout = 0,
+	};
+	int ret;
 
-	if (smu->smc_fw_state == SMU_FW_HANG) {
-		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
-		res = -EREMOTEIO;
-		goto Out;
-	} else if (smu->smc_fw_state == SMU_FW_INIT) {
-		/* Ignore initial smu response register value */
-		poll = false;
-		smu->smc_fw_state = SMU_FW_RUNTIME;
-	}
+	ret = ctl->ops->send_msg(ctl, &args);
 
-	if (poll) {
-		reg = __smu_cmn_poll_stat(smu);
-		res = __smu_cmn_reg2errno(smu, reg);
-		if (reg == SMU_RESP_NONE || res == -EREMOTEIO) {
-			__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-			goto Out;
-		}
-	}
-	__smu_cmn_send_msg(smu, (uint16_t) index, param);
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0) {
-		if (res == -EREMOTEIO)
-			smu->smc_fw_state = SMU_FW_HANG;
-		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-	}
-	if (read_arg) {
-		smu_cmn_read_arg(smu, read_arg);
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x, readval: 0x%08x\n",
-			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
-	} else {
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
-			smu_get_message_name(smu, msg), index, param, reg);
-	}
-Out:
-	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
-		amdgpu_device_halt(adev);
-		WARN_ON(1);
-	}
+	if (read_arg)
+		*read_arg = args.out_args[0];
 
-	mutex_unlock(&smu->message_lock);
-	return res;
+	return ret;
 }
 
 int smu_cmn_send_smc_msg(struct smu_context *smu,
-- 
2.49.0

