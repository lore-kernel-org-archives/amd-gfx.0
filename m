Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C2FCDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA27B10F196;
	Thu, 25 Jun 2026 08:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OooRmpRG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB90A10F195
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEdX3SHC5gSXur6WlbJG8Rj5pesSPBMUWqFKdE/j/q7q1i/xJTooMRblS42Wg1y/6CgqM8BAf4FED0szNUTIgFd3+jYHGm2l3QXppepaQH4AGoXee0mT96OgEXw8zveXPCeRU93kYmHslXpRxgcF7I1Dz90t9WULzeiRIUZWZZOclhX4AuYmrhM6HfQtM7ykya8BOtO1Rj/7GsCGjg8TgfoutrahsV4uhfsizsBxFv2GQIWugg66WnvOPnadYdyO7jTV+yiLDRjtNpHB9ipAkDuW1Vz0SeDorMaylIDqdaiXlmhZtr/ndVT48v37FOVwslqZmi0B1h3brPnp0ZVF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5ok40vPD0firo4DXv43OqqlvoEk+RfAq8BMZUsq5I4=;
 b=P4M+NqZa4f6/0wompv2ExO6pnfVuqNcg4DShuXiFcnIaS939v93v4HxngGPGw1/LFk8JAAqn48E59JVVF2b4fVE4K6NgjJkeZbwjFRhH+8fAUYvp8Rqo/4kszOc8HEeNHWP5rvkDff5kMz6iU3Tg3MaIf/mgyXpnXXEK3Dr/09rNdX4XeEEM3tTxk5hEflJJXzyw3AYdDTGddh4RTa+PX7UwflBiy80j6MIwthIbYxPIhbgspN9Y+53Lqlqg1dAH8yiziVNrUqJd4KqVGJDr/i17E4amsun3I+H7ROguSR4+jUGbLL+ynn/bqpdOcA5ck/Zjr9GbwnKRDYyTk5hA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5ok40vPD0firo4DXv43OqqlvoEk+RfAq8BMZUsq5I4=;
 b=OooRmpRG0l1b0UbiuVf5ro1e/1PakVQMHWMnqCrx1wm0JOaoN+Owoy4JGoWSOCAVjGOkYnUUsbvZuLtCijGBUz/hphrCCWV4TmLoRhA6acTAjf8m1imuIhVg9kvf4j6Z2NPy+uUOSHD7km1AzbYujOPMOSQo924QkhyEGWaJGc8=
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:14 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::b) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:10 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 31/44] drm/amdgpu: retire legacy ras_eeprom_read_idx
 interface
Date: Thu, 25 Jun 2026 16:19:24 +0800
Message-ID: <b2dc5e541e5e670d92593466053773ec9d8fa02c.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a1b6e-d11e-43d3-9969-08ded292b89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 39CFhnrzu9J2ESrl//0PsV+KwRVfqRcXqiX2tcbIfB1rQRfIA3vf66dQlkCWeeQDhT/TMi6V47I6+o378ZoZngaHG8fcy3GrrDdpFwNKXe3iek54qo/GcYWD+clRl9RP8vlXldCnaI0Iy8paeK1voKMJpaHg/4x75iAOnSfqicqKdOsPFozWL525lqe1PnnIQibojbo5N1cBin0OTmgiTcbHzJm/hKO8Emy2yJ+OjoKePBBsHxciyYaoyv+cg4mGkqOPQgI+C7z4MLi3DW22v1eLbyTNwd9x/T1ooXIJoAxIv2JFks5+z49jPqLPcNHuARsV8B+Ip3oLWrjDrjgFoMMH747nnAumDI8n9MVj3Zx/fdsh8dFnTPtJiLRiw4mmOiCOhQFi70VB5bMVV+nDLmURZdQHSWliVma/IuNlLz/tGtM9mYoR4HRRpVQEMl9PnWtDT7HFqhT+qWQjTvLp4uONvh9PJrsIUEPu8oyWOFSmFgip5s6j7DUbXwUB9ScYP8eoKKjiUgpTzXP+VhXOV6IQHaLen0RiViU5exjN50nfgNJplhaRmMSWPcV+nVR9zlNaih8V/72qpkavjKmBabrTc2JyOzcBi/UYbehEIk0NfG6RbcivP+0/cNUEwLECmWHfwiR/Dp7LUdy4BSOpu+ZvCdY8qjYS9NSYSCgJuGj/rjX+1kNEjCQKOrlGBrTBWXRZE+II+FjaQ2XYEFhdyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gXO5OCmoxrrbhp5bfxUFYsAJEVon10jRix5OtWYe4uL85UUAHUJrFb0blKmWPPrEVOz/mjXDEhJTGzgMlrSYr+eIxBb21psDj+/B4hMQU6/BDuvUiwmEch1pWKN4nGkb7xVX0taXL9RCMC+Bv/AhA/qh9E8k8AyTBeE1IjlHtHCTYASBbFSC8GD4vn9Sj27vkG2iFVv3IneMiOwrDAb4BcO77yDJLretZ2dZrV/2PIiuZLx8JDyKkg/GwzKG6ePnLtF7pU2RGTOmQ266XAMqGwzxGIVw/ynpDR9n5lNmFl/x4umI3Gh4AL1cWP9+X/5ZmnAAfPd9nNVoIxcvJeysfV2btrb3BKWXYe8UO87N5ZOjBVzvsrfDuszYzJKzz8vFwC2MCESecpIWtg1BCkELtZwAkyNyVp7hQebCjHcngnnCEhxDoJ02rCGRZfPFGYth
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:13.7012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a1b6e-d11e-43d3-9969-08ded292b89e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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

Remove the legacy ras_eeprom_read_idx interface for PMFW-managed RAS eeprom

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 49 -------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 80de2459c76a..9a9633b57022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -975,52 +975,6 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	return res;
 }
 
-int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
-			struct eeprom_table_record *record, u32 rec_idx,
-			const u32 num)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	uint64_t ts, end_idx;
-	int i, ret;
-	u64 mca, ipid;
-	u32 cu, mem_channel, mcumc_id;
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return 0;
-
-	if (!adev->umc.ras || !adev->umc.ras->mca_ipid_parse)
-		return -EOPNOTSUPP;
-
-	end_idx = rec_idx + num;
-	for (i = rec_idx; i < end_idx; i++) {
-		ret = amdgpu_ras_smu_get_badpage_mca_addr(adev, i, &mca);
-		if (ret)
-			return ret;
-
-		ret = amdgpu_ras_smu_get_badpage_ipid(adev, i, &ipid);
-		if (ret)
-			return ret;
-
-		ret = amdgpu_ras_smu_get_timestamp(adev, i, &ts);
-		if (ret)
-			return ret;
-
-		record[i - rec_idx].address = mca;
-		/* retired_page (pa) is unused now */
-		record[i - rec_idx].retired_page = 0x1ULL;
-		record[i - rec_idx].ts = ts;
-		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-
-		adev->umc.ras->mca_ipid_parse(adev, ipid,
-			&cu, &mem_channel, &mcumc_id, NULL);
-		record[i - rec_idx].cu = (u8)cu;
-		record[i - rec_idx].mem_channel = (u8)mem_channel;
-		record[i - rec_idx].mcumc_id = (u8)mcumc_id;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_ras_eeprom_read -- read EEPROM
  * @control: pointer to control structure
@@ -1042,9 +996,6 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	u8 *buf, *pp;
 	u32 g0, g1;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_eeprom_read_idx(control, record, 0, num);
-
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1

