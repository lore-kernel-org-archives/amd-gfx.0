Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCCACD343F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D6E10E0EB;
	Mon, 18 May 2026 06:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZyvbXe3X";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2BD10E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUq91pdjIENT4M9n4FoxWlvrJxCEKKns5A6CLZYq/r7usT/ru2ow6SN8bQfSdSVCrTItEqFRWxCHdM3UuEmH9pYvk5naHR35cF74pDoWDsU3iOYongcd06jST3fE4muleUnNQo7wtyfQ/Q5L+TcSIIw8h/2icCW4BIx+kpAyryNv04LiJAPLxHx3IHYkUuAfHE3bCAw/ytdqmv2QpxUF4dSi2Hz1bmMPbDW1Gz6bSn/1WQCYfVCDMobhG8covYOj/2eUV/YKbJqPH7AXz21vrHZJn32KIOZdEiJv9FlZ/xv+bgSf6cmcG67/gURxKB5h8FOpTEHsFD1+qLQBhkhLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i79p8aSulDk5jU0Gr0iq5WUHKG4Yw6rqLm93cmcKe4=;
 b=BS8VRMB85KjtJv20wUAwBMftEEkEC5zB4ae8r4HbwZFKxqs2+LCg+N5cFwEj8HJ30WlyqMedFr5OnfC3/X8sTLZWt0RUzTeOoqM6qCHHBAXdHaL23zr0XL25pPXgKC9WFqcRNu7Y/eER/ZZWBfn8EeBCzcU4v+5DzIzn5Lq78enlbJk0fBmtoeWjgitDt9fNFQiWk7VD3WShOVmUrYH6vPFF22zUHSoUpA/YZS7rx8iUeFFCiDZV+qpJtPhNNa7juRBzqXQSj0BzmdJhfc8CuvRdgfV5ztmJsbnORShPfa8EoUCzehOCwsrCmBPSf8z2RntkQxMK9jhgAZdi3unTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i79p8aSulDk5jU0Gr0iq5WUHKG4Yw6rqLm93cmcKe4=;
 b=ZyvbXe3Xu2dUCzy5NITriEO1VGOIwVstJW8cZ6X09JEgNit+ZAhrDz0CQgQ54pE+rtSQ+Y7EUq5wT6hBeNYsAA6vSqalix4ba7x4JEKSHyRvK/mf7zB/GFLWU5dTZxBcZNZc9jXop/RJ+OX2cmi/oXu5D4yEIniRbba4Rlp5OgE=
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 06:50:57 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::7c) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.10 via Frontend Transport; Mon, 18
 May 2026 06:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:50:56 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 01:50:54 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: Fix SMU EEPROM record field decoding
Date: Mon, 18 May 2026 14:50:28 +0800
Message-ID: <20260518065030.2311-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7044af00-76c4-4004-15ca-08deb4a9d019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|3023799003|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yJ29zWEB+Pjc4/twuHbyD/g2wiy5VRsB1byXXji4hvmsM6fv/dGsrMFLD1d07wr375Yf0tA3l+3w1B9XlfOfz1I7UcusKq+QG7D31QTESh8QVxf8Hb/28O5BYPGOFNRA8IEJDHUtYaCieE8lUtLOMcT+jHh0YKDYn/Tj8770+UR7KNiNinBrveVXCiqcthd5VHlyEcNAu+HkzlmsGjXg+JuoVb1T2LtYYdCBhoxnGaCknSBehExiyICw9jJQ2GyWswNDiYJSQ9CQynYyLIvnKPg0N1ll66r7xbHyyBRsr3aWAcFL0nn5nhgcffup3x2aZy1GwOfk8LmgJy3CqVMLfzrgIJ9+IIAm5AjjBAPK4rEfARCzQeIUO+U2wMvpVf+qzLzC6EJRrrrxBuWhytD3LSWWV+Aab3m05R+SOh7yHBPLxKpSQoTZBq30XWgxKpMPuT4Q75IAzzZuBzEsR7fj3HmF7rMc+IJAYFxT8fu5eD4IkOhs/kUgVZpi+h0emTFEAGxart2/5uMn0iXDFey1FOL5IzMPwVsLgzq7qPyIYsZ7bgb2SZAnDWHRFWNn4FPgNED+IiyC8wEa0Aw+7U3El3445r+d6PFTc2uM31wJMJcgTFVGEDaJqa4JcJJkoojP644fiSxs2Q/wIyC/zTBAermEpGmCzMUpU1cq2WjmjGwOQheSNxpiYw5vWLwBVRTscVviMkBPI27Rr+M1ZDFemUaduTSi2oD1rDRg8HuB6iQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(3023799003)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aq5P9i25bZxnemZkUIDpUEWuxnav4z7/feiZQS7uIE/swiVe56qesdCxvakSz456vzcKz7pNLTuUWEBU7jYEVZaJt5ZA+eB8Ihf3wHYHK36yHxbnGMuDf/5GKT36lVnKBwPr1Y5Cy7Ity35yYiTSwtyI6UyYe8lSHqbosnAknMjDHXUshxVfZ+RxEWia3K8fxH58VEyTNyqVRj3kOEECttZcWIs9HAnEsEKubZ4cshBBVfZRrlLX+nPrIMZQupbow1XOZrbiePqsCi3zhtXMOxgaX6VsRamJwW0JseM3KqXkV6+KhrDgP29OWuPoY/aiwNv5T0PorHeNICJ3/hloqX/cntaAMmkVJD44J6V6lncdOYIT7FcJB5uTg1mEeRBhBNJIaG1AsKzKgyQ6P2UulAUsfoDJ6ho7JlAq9k3Xrwt8O0AeUEaKcOnME1I0l+Ja
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:50:56.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7044af00-76c4-4004-15ca-08deb4a9d019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

The SMU EEPROM read paths pass byte-sized record field addresses
to mca_ipid_parse(), whose outputs are u32 pointers.

Writing through those widened pointers can clobber adjacent fields
and bytes beyond the record storage.

Parse the IPID values into local u32 temporaries instead, then
explicitly narrow the values when storing them in the EEPROM record.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c  | 8 +++++---
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0c57fe259894..5e35a6c14149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1051,6 +1051,7 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 	uint64_t ts, end_idx;
 	int i, ret;
 	u64 mca, ipid;
+	u32 cu, mem_channel, mcumc_id;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev))
 		return 0;
@@ -1079,9 +1080,10 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
 
 		adev->umc.ras->mca_ipid_parse(adev, ipid,
-			(uint32_t *)&(record[i - rec_idx].cu),
-			(uint32_t *)&(record[i - rec_idx].mem_channel),
-			(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
+			&cu, &mem_channel, &mcumc_id, NULL);
+		record[i - rec_idx].cu = (u8)cu;
+		record[i - rec_idx].mem_channel = (u8)mem_channel;
+		record[i - rec_idx].mcumc_id = (u8)mcumc_id;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 29001e606d1b..f5fa80db91fb 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -270,6 +270,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
 	int i, ret, end_idx;
 	u64 mca, ipid, ts;
+	u32 cu, mem_channel, mcumc_id;
 
 	if (!ras_core->ras_umc.ip_func ||
 	    !ras_core->ras_umc.ip_func->mca_ipid_parse)
@@ -299,9 +300,10 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 			record_umc[i - rec_idx].err_type = RAS_EEPROM_ERR_NON_RECOVERABLE;
 
 			ras_core->ras_umc.ip_func->mca_ipid_parse(ras_core, ipid,
-				(uint32_t *)&(record_umc[i - rec_idx].cu),
-				(uint32_t *)&(record_umc[i - rec_idx].mem_channel),
-				(uint32_t *)&(record_umc[i - rec_idx].mcumc_id), NULL);
+				&cu, &mem_channel, &mcumc_id, NULL);
+			record_umc[i - rec_idx].cu = (u8)cu;
+			record_umc[i - rec_idx].mem_channel = (u8)mem_channel;
+			record_umc[i - rec_idx].mcumc_id = (u8)mcumc_id;
 
 			/* update bad channel bitmap */
 			if ((record_umc[i - rec_idx].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
-- 
2.54.0

