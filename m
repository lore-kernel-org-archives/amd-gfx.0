Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F61CD13CF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DA010E218;
	Mon,  2 Sep 2024 07:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svjFrOQy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1627910E218
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lismimcFI0OF/p1lGNfoQrc16tcOywm8EKgweuXnZKi1G5xbqSqytAdK6x00gXaBg4TX1TuUFWZdTR46KKLr5fn8yQi2A+KJDzd1tTTzXfeQPiE7Z7ZwoJTMUqf++qU6qaaLN2sSul+KFaEFqgkQ7BHUdxAbRaPkiNShr/Egqh5H2nvlDo+JY4kQ1CEMg0dqdG4+18uWsGPD5HQ7g4dYm2THcOaWKmJdOQn1OR/7NHNRf4XKFPdjAkHK9xjttMOZaGTSOR5v8ITKm135KsFTr+UuHQU2/K3eWFoXJOmvoHeCJTqQjmGeFm95R7neDmiL5c4ZJGXrET1mFmTK0Chhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQK46J+btcdOuKsolB5D56fIPXyDdLFP8HSektLywNg=;
 b=FYfkCw1du+CPJWj68bW4kJQFAiku8hXZlrGTxGa1su6o6BSYvq7uq0pbpVZ1Zj/9oHzwkWZeU5jmCIY5q8KkJbpLvv02UAtUzErS5Td3pYwSM6F15OuJv9QAcTh75tdJZGHP8c9q+Ad1TXceiJRfmYZmX25kLvVMhpyHyDmCeBFIgQyCB0vvIvfhf5hpIOOeNqRRwBwnrqkG/yIQ2nJKn1f8ygIViFtGSAd4pQx3v9j5ZWbmjryR8dXrgLOzH4+SpZVPqQnIo9phaUeZ1ypxkJhFNE5YusZb3RNY35HziH1vSXDbbLG8plJwNQLbCT3ToDLyicBIO4+ilXz1zRz6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQK46J+btcdOuKsolB5D56fIPXyDdLFP8HSektLywNg=;
 b=svjFrOQyNJvpjK9e67ifhonZB+uYJKgkmntKuSKPAsYVJZGJhKuGyST8rlcMPgtKg3Xr2DMgBPDRYkcXnPVVZXD1f2RruVFhiNp16ckBtLm90vcUbxDr1zV/h76pTwhM1/rqAOqYiCTBi88qtI7wxiSKsEC+0QftS5bIB061m3w=
Received: from BN9PR03CA0584.namprd03.prod.outlook.com (2603:10b6:408:10d::19)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:34:44 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::8a) by BN9PR03CA0584.outlook.office365.com
 (2603:10b6:408:10d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: Add helper to initialize badpage info
Date: Mon, 2 Sep 2024 13:04:12 +0530
Message-ID: <20240902073417.2025971-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 245237bd-25db-4c81-83a9-08dccb21b6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GWKEaB5ixx4hxFP1rsAbXHoZG0nDyjFSvmv9QyHuNKWkKLCQYNfC9Wrt5IAa?=
 =?us-ascii?Q?vEb9Wo+pzu28yHLH1gis81X/NNrV0pEu1UXYSj+d6Ay/dFkz7aq5L8XhMo8e?=
 =?us-ascii?Q?AaXaZQqX2wjfdYVtCr7UwAGwJBm42O0ulv/fNJHNqmmEvUD2CNPzUV8NnuTi?=
 =?us-ascii?Q?8/50Gq2uxOvjHX0OnG+4gxdX72fN7Wa1GKBmaPA3N0ZraXSXgl+SdPaEEBkY?=
 =?us-ascii?Q?Xx/NSOTBmf7SAuvfVW3baTPqoRNA87QsdXBy/Hk31Hd1RsqpUduMps1PJG5R?=
 =?us-ascii?Q?PvVsMzGU+ZujVIcEKHlojzu8aUdvChMMIZp/BU21hjkf54/uCpCTL6HC0PZs?=
 =?us-ascii?Q?sA+doVMypMUr0Ux57j0f23CHFA5YpbCJfX06DlkF/hTxX4PyeWUMjdCank1K?=
 =?us-ascii?Q?Z+norGu3LUGRGJXDVOjv+Z38gi84gj91FlnErO2sx22oxvf6tUzRLTsTaIyR?=
 =?us-ascii?Q?qoNudNXHQAB66kVp5LBc6yBMKsN/r59NFUPDks5DdTZoOyKPQhwJ3ovQuSGI?=
 =?us-ascii?Q?lMPnSCcrJrxHIcuMMsXFxhgEKTzwg6ToHjVezsvXLi9NyeZfHLfvUSqn0AcD?=
 =?us-ascii?Q?S0EinVrODeU7xBTHDWuJGFJjvCkYS9X/a+DiHAScPhVWb44o6I798IPHZioO?=
 =?us-ascii?Q?1etOZXCDR0lMiCoAXL458nsUxeXkYh0trMg/UHhKpxKqymOooCwvK5BJKRnC?=
 =?us-ascii?Q?y1khGgzt5i1QOybRXKGvTMVkveJIow+68olj9pOQPmBeM3qRa+uZvei1lSF/?=
 =?us-ascii?Q?+VvaYbVc1u4ZMGIQ7D10ZZQHKH+8NKmzhnPRDnZbjzCqtj3d7ziaT6CgV5rN?=
 =?us-ascii?Q?mdP9NKS4ahz0FIerQ7jeYVPms8AmjCLY8gOnmMnTa7JbNt4kVok+nPnRgUt7?=
 =?us-ascii?Q?PwzSK3IoXPvTGIgJianu84CXuRgq7Tsm4eA33o1qOuEotmu2tNe+M7Sy/4yT?=
 =?us-ascii?Q?yXTYhiVqdzI9CCoWyDPOisYzd3h91tVvURRqWPiX04E5GdEP7xp7odgS0eIy?=
 =?us-ascii?Q?nGqr6qYGmpqImb+NEXG+zUpONDUUfvQynKAzsHDwGbkUencNZEGGRPxMCtu+?=
 =?us-ascii?Q?Ft5Wrx+nKmSN9zXfZbk2rutq8xb1Irh+tDQAACHGqT/976Y994L+FFJQXPsP?=
 =?us-ascii?Q?MLFgINc3AfDYxVq/rqnAH7hYyrWMkDXMhZz3wykzJbYmkTPeY9dO1ZcKt5mb?=
 =?us-ascii?Q?KzHFsEoSTgPUhy7CGzKKDTx/FYa3ohqBChNE6LDzXg3VG79ZEh8laxtGx70C?=
 =?us-ascii?Q?Uon/Pp6Zzzf3DkrpWPiQuC8PARMIaKZVvlqOGEBRHtd1TCuo3zNXuhBsQjAp?=
 =?us-ascii?Q?IGl7Dlm+Uu/aUd4molaJPTc4ErsjSOBjubIB9Sg5jAwAlvFW5tYisjUy81og?=
 =?us-ascii?Q?Tsl4zuYb9L5hl8yk8G9AbrKIzn7F0XX/EvZE3tnwMLzWMz9gLKVFen3TzU14?=
 =?us-ascii?Q?oqM04jLL2R07z9O8KeUEMOtFFcarX2Hg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:44.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245237bd-25db-4c81-83a9-08dccb21b6fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
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

Add a separate function to read badpage data during initialization.
Reading bad pages will need hardware access and cannot be done during
reset. Hence in cases where device needs a full reset during
init itself, attempting to read will cause a deadlock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 56 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  4 +-
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e28227869307..468c4f590183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2945,7 +2945,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	r = amdgpu_ras_recovery_init(adev);
+	r = amdgpu_ras_recovery_init(adev, true);
 	if (r)
 		goto init_failed;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2076f157cb6a..65c891b6b999 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3146,7 +3146,42 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 	return 0;
 }
 
-int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
+int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int ret;
+
+	if (!con || amdgpu_sriov_vf(adev))
+		return 0;
+
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
+
+	if (ret)
+		return ret;
+
+	/* HW not usable */
+	if (amdgpu_ras_is_rma(adev))
+		return -EHWPOISON;
+
+	if (con->eeprom_control.ras_num_recs) {
+		ret = amdgpu_ras_load_bad_pages(adev);
+		if (ret)
+			return ret;
+
+		amdgpu_dpm_send_hbm_bad_pages_num(
+			adev, con->eeprom_control.ras_num_recs);
+
+		if (con->update_channel_flag == true) {
+			amdgpu_dpm_send_hbm_bad_channel_flag(
+				adev, con->eeprom_control.bad_channel_bitmap);
+			con->update_channel_flag = false;
+		}
+	}
+
+	return ret;
+}
+
+int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
@@ -3187,25 +3222,10 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 */
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
 		return 0;
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-	/*
-	 * This calling fails when is_rma is true or
-	 * ret != 0.
-	 */
-	if (amdgpu_ras_is_rma(adev) || ret)
-		goto free;
-
-	if (con->eeprom_control.ras_num_recs) {
-		ret = amdgpu_ras_load_bad_pages(adev);
+	if (init_bp_info) {
+		ret = amdgpu_ras_init_badpage_info(adev);
 		if (ret)
 			goto free;
-
-		amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-
-		if (con->update_channel_flag == true) {
-			amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->eeprom_control.bad_channel_bitmap);
-			con->update_channel_flag = false;
-		}
 	}
 
 	mutex_init(&con->page_rsv_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 669720a9c60a..871b2d6278e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -736,8 +736,8 @@ struct amdgpu_ras_block_hw_ops {
  * 8: feature disable
  */
 
-
-int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
+int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev);
+int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info);
 
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
-- 
2.25.1

