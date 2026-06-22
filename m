Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15653CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D3510E482;
	Mon, 22 Jun 2026 04:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghZvAYSW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9684710E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7/jX2oEYUX4iXDOCdHAVVpDKJv6azYIFKu7n0oYsxt3Ezj4GEz0lgIwseMdKr1PpG1UMC0n5IbK+IQm4CkrZyK4/VVp5UPaXh8VyyMX7mH0hyx9hNQdBgg5x7cqp8n6yIld1rhzilK8JGhBYoVbam24B8q4Ujrk9Nw+0j4MIwiA11BryPMX80ec5HJC6GCDVUp/Vtyur5aiXoc1L9oyD0MK+z9qo684DP9dXDOkD37y+eFM1bRtNI/vHiuQm8qK08SEmHauBzfDt6SKO4S4L8+Jw0aEfE0duuxjT0D8oKWIyzoe48lSi2Ki4MjnVVdC5wUwZVvd85ev/3yKp8bmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMcdubtyTaEkg8cVhuPnyFKmX+XDwaLtKWMexUc86tc=;
 b=pOp93yH0CRLnEYJ859IufKttody7egWtn6cQWMG6SNG5gbZJ7nZ8gB1s6el+AfVdQ1iKtb9yKrT710BMArDQcyRQYQ8nXys3e8GYttNmjeU1jB1ILns+Kxr77rQQq/9cGrLXBzU6N/3ZBfDi38JIqNUHdi9ojw843qvOl6AoXFZfnOdEyLB1r9FIK+EXXG1YaTRWdb00LukXObhMcn+dcxfqkZ6ycVf1RFrrm91pPP89wuZ7hUfXa2pd3adMFRYW78pgFxH2JiRm8K1tnEWc1NS4PH0u0jf/vyjd4dH64+yWZO4lfbD/d1gjyCZZ8GAS0NiHgAuOHLMiQXHWXcXJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMcdubtyTaEkg8cVhuPnyFKmX+XDwaLtKWMexUc86tc=;
 b=ghZvAYSWUxUQrePgoLq3ZwBqEvuoPKFcHSj8OtwVNWMMSC+cvm6U3TrcvjYvN/UY1fnL7/BHW83vWrH5X803gzR67nUjeL115E796Vybzzzc966qX20QvcUKsIMFoGCRwucAU6DBNbfaHvWne1cfNfWBJLuB9Re2OxbVEJ9/ITs=
Received: from IA4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::8)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 22 Jun
 2026 04:43:02 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::45) by IA4P220CA0004.outlook.office365.com
 (2603:10b6:208:558::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:02 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:59 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 32/48] drm/amdgpu: retire legacy PMFW RAS eeprom write skip
Date: Mon, 22 Jun 2026 12:40:21 +0800
Message-ID: <0eb9ed4dba4ff11c398be50beda9c609c9caff34.1782103074.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea01ac6-f5d8-4e1b-77a7-08ded018be27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: +fNG8TsVkzUaWjUCamuzjFDax4oBTAz8MVSVS7yaPKmDjbhbtjmTpasv7UlzTOgtk+Y3X7y0mHY75uY/mJEV1XIkhKwsqc/gvU7uZPth/kgOOYYgUMvGqvVYw2Y13CluAE7ytb/Xi3R71P2IlLUMDVZYsaA17Y+TDUGHuaEIQJzxDX4jOrkQ6wh/Vvbwb10weMxuqmQQ+YeYTfkvcDpJM1ZeGLwTCHPTmQsmBbQ1k4m5buzTAD8BFMz92eTakdV1NgZr3vge/kNgqBLEr7iWKZS0xzE+Vpp7nxcTXCpYuPBP3DANQ7v7Qng8MxEckA059La/AsRA5av/gLN/MGGahzXq+163OR8amHvhliYcQaOxcZByHzmlQwt/Dbb7cUdcn7gm/9AOrDvzm3K5CkuTKHuKm9uDA8YFFgjH0LW/JP7ZAzWzUNdG2OEhQjomZwQBqXyNsEIXBsBNE4YFDIdjkovGPYVdfqBBcQKrBYiHvW3hu8wCI8FOpk74rhxc3eXFXuZ86RnNHOg5iOyZnMEi+Ya3RX+oyxU7GdSnmKUF6t6L9s1xNq1RbA2p0IDC0Yi1yROVx9Ox+fPLAImSboP/lwfpJR1/YDRRJbiYJ4ZZhTuFzecYO0egRmaeqmE1u2pu3p2vTX5dEJu//70YHMSRd1DRld8wg9itMDm9JeHsMrMBMmeKblSHE8mgqFQ6wa4CSnN2Q6WCQh1GJOsFJpAT9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CX134rN20LWQQT7q7g+vTPdQG1ny6LMfzMbgBd2T484p27Otd/pqJzCqm9rZRb7+YllIhyv4n7l23RQu25nhzqA4YvgUIk2unVVL3pPkexIXXRVM6J/i7FDo1HfKrN+OP7w0bbHQjTZNDtvyVGxCpwjFhe64PgpOWB8BwU78kety5ABu7MoIYJqoo+YwBVdFig6JAqbJoCyyvySnvVwXdyjFx7+MyB4nxY+S7CF542XENsjTnklgJkaLFb5PyJ8MtciqCgW7ODF/NjF9ncuvtbV5s2jUUGjvl9xCnp0tw4H6U9qq05/SGbPclGE2gJtGweqDqxPIxMtGn4nC2ajLFtvmNAzP8N5ebbH0u1jDAy5iQkGHMmWWzhhp1z97YAmesGcw/0C0yaXZkN6weoog/jogUdZr7DD0lDh/WaXsyTuQSoWx+LWrfRDATiOB1HF5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:02.0811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea01ac6-f5d8-4e1b-77a7-08ded018be27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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

Remove the legacy logic that skips eeprom writes for PMFW-managed RAS data

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 43 +------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  3 --
 2 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d28e8958b0ff..80de2459c76a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -124,8 +124,6 @@
 					RAS_TABLE_V2_1_INFO_SIZE) \
 					/ RAS_TABLE_RECORD_SIZE)
 
-#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
-
 /* Given a zero-based index of an EEPROM RAS record, yields the EEPROM
  * offset off of RAS_TABLE_START.  That is, this is something you can
  * add to control->i2c_address, and then tell I2C layer to read
@@ -878,44 +876,6 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	return res;
 }
 
-int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int ret, retry = 20;
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return 0;
-
-	control->ras_num_recs_old = control->ras_num_recs;
-
-	do {
-		/* 1000ms timeout is long enough, smu_get_badpage_count won't
-		 * return -EBUSY before timeout.
-		 */
-		ret = amdgpu_ras_smu_get_badpage_count(adev,
-			&(control->ras_num_recs), RAS_SMU_MESSAGE_TIMEOUT_MS);
-		if (!ret &&
-		    (control->ras_num_recs_old == control->ras_num_recs)) {
-			/* record number update in PMFW needs some time,
-			 * smu_get_badpage_count may return immediately without
-			 * count update, sleep for a while and retry again.
-			 */
-			msleep(50);
-			retry--;
-		} else {
-			break;
-		}
-	} while (retry);
-
-	/* no update of record number is not a real failure,
-	 * don't print warning here
-	 */
-	if (!ret && (control->ras_num_recs_old == control->ras_num_recs))
-		ret = -EINVAL;
-
-	return ret;
-}
-
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -934,11 +894,10 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev) || !con)
+	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
 	if (num == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index a62114800a92..3c7fcce5fe8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,7 +82,6 @@ struct amdgpu_ras_eeprom_control {
 	/* Number of records in the table.
 	 */
 	u32 ras_num_recs;
-	u32 ras_num_recs_old;
 
 	/* the bad page number is ras_num_recs or
 	 * ras_num_recs * umc.retire_unit
@@ -191,8 +190,6 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
 
-int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control);
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev);
 
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
-- 
2.34.1

