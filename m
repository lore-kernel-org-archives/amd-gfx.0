Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EFDCD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A60810E484;
	Mon, 22 Jun 2026 04:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GaFet9/A";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D19410E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMe6VHg1JGiLfuI80Zd3xVKuDmix0M3w/U7Mci6sulaUDiBmAH5WI0Kjhq5BU89gerucxwluPXIKC5Gxh2+gtHMnXFxGWFmS/cvBcDrCoAm3mQvzPd+SjWl8p0WxIBkbgfq8ME3HkB3iOzm2hCDky71f9GqG4nbdFGBNgzhZWFRcrntVzuCUNP4qbl5ijfN7Rz3rcmuDFV1r0XG6TU1bvDqrNLyFvbaEeSc5qdXnM7QEpYZGi16Tzi+HnSt5qDlnJIugL/8mNMOL0TbVE1pyoKE1j6Bb+0hQ3YDxTRfWcD/iQNWH6nZEDpA5z0aUaySxiFGVzqkWen3MW9zu6cLfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5ok40vPD0firo4DXv43OqqlvoEk+RfAq8BMZUsq5I4=;
 b=s7dGxcINQgp/6c8y2bb2C/4zMssSmxXvEHK4PQLJf3IKvUCJ1s69QJhRJBDsQwKFHqCgTsLaJhsv23vgLMrGEljw4AeulyQgj4dEQsT0niUA+JdWb0zUcoCyiDTbD1alO9vkeAlluGaoS+W4oR/N03u9KjtoR2IHsUgyiUzlzGRptCOsRyhWeLkaleEmvNQzaOv0/gtmQ2plhGr6lq/+9K/IWQqip6C5NR49RGE8Pha4JPmGspvEa8mpZZuhL9Llq24jtWAqLcWF1aNNT6YhygkYEOQ+r/7Qj2TXaeibPJ463jXXQGJIxrRmOLAkYS25HIfl0dYO1p7y0Ls/pjkLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5ok40vPD0firo4DXv43OqqlvoEk+RfAq8BMZUsq5I4=;
 b=GaFet9/Ab2ITl1WE1sP4NOHtvPPNyOIMmR49APEIVC2mtMrhehiuCqdnJwk61DexXx3Zss9Te6XjnygH38Oqs7tJQSek9zBNt0rL61pV6KbXoNUjj3oA1Qx3nzMDH1iFoVaB0lS8E+rb6vu3gjwPPvrlAX4Mj/DOgi6k+EsuBKY=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:43:03 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::3c) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:03 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:01 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 33/48] drm/amdgpu: retire legacy ras_eeprom_read_idx
 interface
Date: Mon, 22 Jun 2026 12:40:22 +0800
Message-ID: <2c27f0f7c96bcc0ae910ec12b0d1f8197ab569a5.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbea9c7-f1d0-4433-7bb9-08ded018beed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Sdwq5WEKnEftsgsm042wUWDVKJLsW0FLfn1hdh4UyrrHEtHdCkmqSswDoCsFwLXrK9Moy9cCkfYLsba61xIUVU3qWEBUTouPh6XahKm4SOGOsddV2x+tiskJxXJhaafsAk4pnD8dIaFEvGElElbEsbx+wK0cuQXj9f+kWtVdqm462UYECxU3Pw1vQIm9dqscKU19HQecCLa2JbAC1h2DYSm3LQw8XxU2UjCa4V5ywhV1y91slc0/2nDSzYDy9RkwYssn8VHITs9tCa6bCh1Tz0T12i9UdjRBEN2AamcZ47SA8p3x5na3iBNrOW84239Rt9qFmFxeurDouuQ5AuUouGkfH7e7qzZeBizBP9dx6NIjkVgFfdQwtVVFpuDZK+IcZZ7/dvNaYzX6am9Mvfmakc/EMQCrUdZLuiaAx12yyU6OjXPNTtGzv8YxjB1hGKgdk6VrR16OdIx3kMwJXU7v3HVcr5n2LIX5nWZCCFhobyzzV7ieEf6mzbUEh6+EwwnTBWXnmnWsXHzb3TqztyccvACyEgOFCiRAfGG63W7SZW4tQdJ7BHnIVRAjmhBdyOXoLmBlHsggjLk6SQ3AVr9Op2kI7b/qMVX53dElBK2Yb2CsmJHXCmLLqQcb3p9RikXATp8ayCQUEN4Ev0sVeJjBcNf+/Ej0Pb6dbCtcZDEgTfZfqqQPvmSZa5jorhzRifTIhp6289V+8B0Fr3W5HAG10w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zDv1/pwfbzcya1YdPz+0yhfXLy5fCp6qsqVbw1E60ZuI/clX0Ytncc434dUwkLl2bIympC9swUMHy4F8Wd648qHfkcQs67luYaVMb2FTyP6aSUtJBjSxK9VWuGytKz7wsxpSz2Bv4PnfKbfCcZzD686iK/DAEcTQ4OzxG+O8brg2EyGvJty3wSO/dlQF4CHriSTyxrIFafTr+AtPssp3cow1qW556l16YtXomWz2UlQQLRKYb9PWI8YACgNwwK4NXK35a4Z4Ms/sjvdqxNVUc8RHvKUz7p5eXgvVXej1MfdQ0cSBYvaAKoC1nAgVtz5NordS8xpFPNgmtLuPvfK93aWepIW/3L6QLYPbVlTJboHLpERvbobiV8hJ4vkYIEvtY6NA1VRwMox1xKj/3UnxGPZd/3A4l3OnIdpFmyQmhf6AyiNWg1eJXsRx9ClvSkg+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:03.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbea9c7-f1d0-4433-7bb9-08ded018beed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

