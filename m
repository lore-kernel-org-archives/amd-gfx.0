Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2DCC88E47
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E55B10E398;
	Mon, 26 Jan 2026 03:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpwSw6Bp";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632FA10E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or1OL8ejxbDZqirXIwC92TyB2+0w8iGXrEJGBvykEgbVzMM6ntoNtgACM/3jqiB9eKlIWW6Xxk3DmCWIz0b4HhXMSnPhpk+OqMePMg07vruiteClf0v4HA7NtTZqQ/BLEacjGedLODYt5hYDPd9lFcVbwaLVwiKwINrHDCPEfKL5tMKYGSKCegtGBhOK4PDeDJHZejuOeSHJG6d3gu4zGV9YfZL9FDGYPJZ8FnIFUJc1dnM3wlFF9dfZZ2GPCWhXXJ+xNMnwQSjeyi5gn6SQG7A6gq4Iyx3XssR6BuFBwxB6PmdUzyfNF53ABgcKrhiymzb1Lyq4oveaaKmcVt9+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXSWR+odHUX4vGxm2w3xU9+lqTqGhasoCh0ktvxPPC0=;
 b=bpUDFG+2qMKYUB4bcpfsvVwV7Tc2sPsyXxEi8q1U6TNXsxmMdOBst7tSABzvONjomARvQy5lpncF473CbOSxUUZIAhlsDz4KHBmebKxYSnq9R7GGMkiwX/Q6JyZKFJC9v7qvBq2Vp3sajbR8sQUim+6p8Haj8PmZHKj6kta0tBNCcsUxqsjOWxp+V1MiWHDLzY2zq/vf3iymDUn1IBsHeyF+CK7B2J3O0Y4A96IK3IJGJDNRNDTmza/9ehrQlrlRpFC3h+ylMQKtbjKB/rUkpThLrVsNQ1/1SnHlIa/syu6IVyneCTrCOT5gItkw/B12ed6Js0rgS1nY/XqPbIbbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXSWR+odHUX4vGxm2w3xU9+lqTqGhasoCh0ktvxPPC0=;
 b=wpwSw6BpTyuCQOqBqyms4Fr8D0ht5WC5fU9FanE7mtFJBtlse5GOApzQBspY2MC0DlgGynPUcWPuX3jN4ooYiFrSAXsOHac8VJHGGrrMFYcSilvlSZR2WwjH7K77SjihiQSl8Ts0D84GVtIwG4yuNrZ5sLtog0/0269VeWSSNt8=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 03:56:06 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::dc) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:05 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:56:04 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:23 +0800
Message-ID: <20260126035527.1108488-10-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b099cb8-deb4-443b-0afb-08de5c8ed4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GAFRayAxL+fFQnwMcZ8YItHMipABvBy5SlUCCuYSHVlyfUNDocSaW26HS+4?=
 =?us-ascii?Q?G6rp26PME74q2+Ecany44+4QdnhNPpKQsFi/mCkOIArSMFMudYKPTkeQAPcd?=
 =?us-ascii?Q?J6lJ3cn4ziueCXAuo+qOoQnO2/raVndBMVURYZuTf1kl6gv9YnCDrtK/wI1/?=
 =?us-ascii?Q?mpmvKQXL6pSrkbZ4LgayQHi1+tXq1dkZxFvOnjk5LKhsNhn1i6oYnmhdazfS?=
 =?us-ascii?Q?2z1iYDasMKaoT19PZ2NqHpDYY78fALoi/4Pt/DFfYCbNrCwM92Nknb+cF9F0?=
 =?us-ascii?Q?GgZIQUpT4Hw5d47kjru/PzjqOOin6192sTRj3q9Q/XjmWnSnnVIl1nVrUKVf?=
 =?us-ascii?Q?SuRVNPNz3xIMbYsfCMDbbpKm+kKe7/uoB4x5JsxcP6NSAWG0fTd/qdjwPard?=
 =?us-ascii?Q?TjVKWNnsEJIFOBJrNXh5mW3F80FMbeBn/cTt8BVH8UYmkEftnKUO1WVvaX5Z?=
 =?us-ascii?Q?sX+RbrGdM780ddDSNZ9I5ANCzAtVYtxSYbsxc5as5G1towonzKoXLCmY95G/?=
 =?us-ascii?Q?/KfFXbqd4DetmgU3rIqonT1TFZdvIiQyoc2u0lWNInU2E7RO5mj7HpPaYSm3?=
 =?us-ascii?Q?fsa2iqg108NrW4zFBTuB7l0CXbUrjesKjNYRHOgnJ+MLjkd8oMku1oXVvb1i?=
 =?us-ascii?Q?F2TyT4yPUSCXA0FAxV5Vyrn2SyZS9LIcdlbre2EdUfmrtSy01wFon7zY0IOo?=
 =?us-ascii?Q?eJOZZ867lUGXswy6cJgiYDuYJrpuFdQcP1VeqauWVpJP/aq+CHxipsRUVEi7?=
 =?us-ascii?Q?A8p9siLmQyVTsqDtqt0R+tV3hEAfjDlcv8a50e6CCNFQLJ2/Io5Vhg1ctkUa?=
 =?us-ascii?Q?iYKbQtrqc+ELCccvZIV4L/LNjWYrpTfBswgda3+ZXKMGceBCMnQqB0UydyaL?=
 =?us-ascii?Q?F8VP+pbjyNDdU8XO6d8TVTEPIBVqBNlaOz+jVLDkEwAtvvik+ax+xS2f7Fqs?=
 =?us-ascii?Q?J5v4SCUMvIOyeOXH9Oz6duHtnAWd49veUy4JIJb+G4zI/euQWROC3hvcbBmk?=
 =?us-ascii?Q?faun70qYSFVnKw8zWLmQvyCFP//MZLHl2vADU29zd5S3MKGaBk+bdTEpV81L?=
 =?us-ascii?Q?GBCp5hOZ/vkeveJE4nfNGEYvuBXPhNI1V09UyWSIfHxFjIWrvnSUTtyZWxMR?=
 =?us-ascii?Q?HBl2xWoWcAt0XvYIWbtZRImcX+CcdUzt6oCq8k4b2MP+bt1rENVHFleHPBxc?=
 =?us-ascii?Q?fc8v8BLY/6C2t7VNwvsRNCPj57LNaJBlGf3aIss2pGtM5r9iIpj20NIyDSpn?=
 =?us-ascii?Q?8md5eOmAEYXeX2oZ+rIlUp5jENZU07HztcpwxbQD9kbwoGAVmjxsKKZm0e2T?=
 =?us-ascii?Q?32/URLljplAhMzHEftQOpgkh6ifh/V0KgMlvNu8fAC0Kowybql/fgklDSj4a?=
 =?us-ascii?Q?2VE+qY/V8w83Rbd+kL8sUuOOAEC/yRamCoROQ8jEnGLNSvCgEbAmxRFyjfem?=
 =?us-ascii?Q?Aa4KWla/1laOAwNAy9N2Boq97A4Oy2cOHgymK+lu6LENl/UjQ/3E1h3OXfgl?=
 =?us-ascii?Q?2Ngf9FsWzmYG15KFSULoO0vpbXghjvNf/fSLunhzClhfLYvRMwmCzukgc9nu?=
 =?us-ascii?Q?YmJu8r0NiuDdjy0Zvzf5A5m2X30kpKxlmPQJmsio8YogqjqzyxFht/hyTUQ3?=
 =?us-ascii?Q?v0PZbU18eRx4mfphmk213FY0LqWLnGnIvLHOAYAVRa1wLWrMTZsnBPwAUrQK?=
 =?us-ascii?Q?80B/bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:05.8633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b099cb8-deb4-443b-0afb-08de5c8ed4db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

add read func for pmfw eeprom, and adapt address converting
for bad pages loaded from pmfw eeprom

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +-
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 70 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  5 ++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 27 +++++--
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  2 +-
 6 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index ae10d853c565..05c7923e8f0f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -241,6 +241,7 @@ struct ras_bank_ecc {
 	uint64_t status;
 	uint64_t ipid;
 	uint64_t addr;
+	uint64_t ts;
 };
 
 struct ras_bank_ecc_node {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 1f2ce3749d43..fe188a5304d9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -239,7 +239,10 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 	int count;
 	int ret;
 
-	count = ras_eeprom_get_record_count(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		count = ras_fw_eeprom_get_record_count(ras_core);
+	else
+		count = ras_eeprom_get_record_count(ras_core);
 	if (!count)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index f7a6f2368530..69e1aef67ab9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -259,3 +259,73 @@ int ras_fw_eeprom_append(struct ras_core_context *ras_core,
 	mutex_unlock(&control->ras_tbl_mutex);
 	return 0;
 }
+
+int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
+			 struct eeprom_umc_record *record_umc,
+			 struct ras_bank_ecc *ras_ecc,
+			 u32 rec_idx, const u32 num)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int i, ret, end_idx;
+	u64 mca, ipid, ts;
+
+	if (!ras_core->ras_umc.ip_func ||
+	    !ras_core->ras_umc.ip_func->mca_ipid_parse)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	end_idx = rec_idx + num;
+	for (i = rec_idx; i < end_idx; i++) {
+		ret = ras_fw_get_badpage_mca_addr(ras_core, i, &mca);
+		if (ret)
+			goto Out;
+
+		ret = ras_fw_get_badpage_ipid(ras_core, i, &ipid);
+		if (ret)
+			goto Out;
+
+		ret = ras_fw_get_timestamp(ras_core, i, &ts);
+		if (ret)
+			goto Out;
+
+		if (record_umc) {
+			record_umc[i - rec_idx].address = mca;
+			/* retired_page (pa) is unused now */
+			record_umc[i - rec_idx].retired_row_pfn = 0x1ULL;
+			record_umc[i - rec_idx].ts = ts;
+			record_umc[i - rec_idx].err_type = RAS_EEPROM_ERR_NON_RECOVERABLE;
+
+			ras_core->ras_umc.ip_func->mca_ipid_parse(ras_core, ipid,
+				(uint32_t *)&(record_umc[i - rec_idx].cu),
+				(uint32_t *)&(record_umc[i - rec_idx].mem_channel),
+				(uint32_t *)&(record_umc[i - rec_idx].mcumc_id), NULL);
+
+			/* update bad channel bitmap */
+			if ((record_umc[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
+				!(control->bad_channel_bitmap & (1 << record_umc[i].mem_channel))) {
+				control->bad_channel_bitmap |= 1 << record_umc[i].mem_channel;
+				control->update_channel_flag = true;
+			}
+		}
+
+		if (ras_ecc) {
+			ras_ecc[i - rec_idx].addr = mca;
+			ras_ecc[i - rec_idx].ipid = ipid;
+			ras_ecc[i - rec_idx].ts = ts;
+		}
+
+	}
+
+Out:
+	mutex_unlock(&control->ras_tbl_mutex);
+	return ret;
+}
+
+uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
+{
+	if (!ras_core)
+		return 0;
+
+	return ras_core->ras_fw_eeprom.ras_num_recs;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 27507bb38135..7daf903ad5aa 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -70,5 +70,10 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
 bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 int ras_fw_eeprom_append(struct ras_core_context *ras_core,
 			   struct eeprom_umc_record *record, const u32 num);
+int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
+			 struct eeprom_umc_record *record_umc,
+			 struct ras_bank_ecc *ras_ecc,
+			 u32 rec_idx, const u32 num);
+uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index fd427fd59ecf..eb5bb6df18f5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -436,17 +436,27 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 	uint32_t ras_num_recs;
 	int ret;
 
-	ras_num_recs = ras_eeprom_get_record_count(ras_core);
-	/* no bad page record, skip eeprom access */
-	if (!ras_num_recs ||
-	    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
-		return 0;
+	if (ras_fw_eeprom_supported(ras_core)) {
+		ras_num_recs = ras_fw_eeprom_get_record_count(ras_core);
+		/* no bad page record, skip eeprom access */
+		if (!ras_num_recs ||
+		    ras_core->ras_fw_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
+			return 0;
+	} else {
+		ras_num_recs = ras_eeprom_get_record_count(ras_core);
+		if (!ras_num_recs ||
+		    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
+			return 0;
+	}
 
 	bps = kcalloc(ras_num_recs, sizeof(*bps), GFP_KERNEL);
 	if (!bps)
 		return -ENOMEM;
 
-	ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_read_idx(ras_core, bps, 0, 0, ras_num_recs);
+	else
+		ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to load EEPROM table records!");
 	} else {
@@ -474,7 +484,10 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	if (!data->bps)
 		return 0;
 
-	eeprom_record_num = ras_eeprom_get_record_count(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		eeprom_record_num = ras_fw_eeprom_get_record_count(ras_core);
+	else
+		eeprom_record_num = ras_eeprom_get_record_count(ras_core);
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
 	/* only new entries are saved */
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index e2792b239bea..53dc59e4de0c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -413,7 +413,7 @@ static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_co
 	uint64_t pa = 0;
 	int ret = 0;
 
-	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
+	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record) && !ras_fw_eeprom_supported(ras_core)) {
 		record->cur_nps_retired_row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
 	} else {
 		ret = convert_eeprom_record_to_nps_addr(ras_core,
-- 
2.34.1

