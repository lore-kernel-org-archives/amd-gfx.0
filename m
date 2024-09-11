Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF93EDE998
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E677510EA03;
	Wed, 11 Sep 2024 07:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2JEvDEIg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4601610EA03
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJUz/BEepKD5mGdoUC8yR225xbzVWoXLFF2mT4wBo3auzABx4WwPmt1SEULKSi7+DUHbgC7YvkGGgrtZAgH2PFHDN9nmkvwEXwu/InVCVaPRyxl/3v5CSVLaEoJlwGxmoJ1drlwmzEftY4eikdAgrFk8TSmPoIQ9AXXDddZ/9R27MF0VxRqmTwaukmxH5wp17X+XQEo0P9MK80HFGRX7OOEsoa2JZYAqZcQd55yWr6ZqfFfeCs8ct2mG0daRR5vzbcMba4cnWChcOsSUeJ3/9MsmmoOJwumJ64SonKEAx14RXOBOOO7n73XESkH0MxWiEao5TZK+T+ZjVgkRTW4lKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbtTf347CR3iIVIFsFBqQKHcklPevn0WgF5U/46nz6s=;
 b=Zz7fur/dBshjb5QcGqNmXUGgD+erRsr1bWWrj+msXuISEmdztvS2wgXws8PxqBQs+uKBGkuBQPnY08zgvYIlzZ/k7OaeGwX9dPhm+67XaoF60Vm0eWpr/a0dhQLqGwFNhm3P7YX/Wid2cEX6w/trQFvvMQAG7EJCqtxXXIjI2QDCcIp/gqz9Fijnh4p/DJEW0shn7ccVF390N7yeCzTegC2slHnhtAQdaNybQS3jjDpY2+pxE+3JJ0MPHEbjgkucECxouCY5s62nQ86yAw/96goSupSY+zPHwIiGwdZCEp3o2BMoNNELoXJomnCK2BQGJrYZ1z7eRS6oAslZMOcCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbtTf347CR3iIVIFsFBqQKHcklPevn0WgF5U/46nz6s=;
 b=2JEvDEIgLDk12vU8ohBrR8WmF5zVsoU1l+IL9pof4c2rxAENBfYajBRw5XwRowFrJ+zroxz+pZ4kUBeofxHbl2BVkt1xordkeHHbp5w+v60YCxWkHpQ1EocBzL55Gg5d4ZADRgaTc6eXioiObSjpbmn2WWzxOaQlr+gPKteTgOU=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 07:07:30 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::3) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 07:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:07:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:06:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 05/10] drm/amdgpu: Add helper to initialize badpage info
Date: Wed, 11 Sep 2024 12:28:53 +0530
Message-ID: <20240911065858.2224424-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2a1793-0d80-4c71-4f16-08dcd23066ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4wEV6CVjKXbu3+MJlU4xhvanuoBVOQ6fP8Nlgp9q8l/v/d9dut2+3loa1Gwv?=
 =?us-ascii?Q?dsSaQe7wminGlc5lKx5QpwIwX5b/9Jw7SkyNBHJPgkOsU6soAW3pj/+ecI7x?=
 =?us-ascii?Q?cnEHaEiO9jrXp97bPD00uLMX7DpCtH1qsEeY0AqGgYhSIA8/HN9xsxz2jsuq?=
 =?us-ascii?Q?ekGFjAoQVAiiMkBoJVOLn6b0DnkXA22D3lsOoQVD6/IgH0vsFNkleSgDMQ/6?=
 =?us-ascii?Q?2yPu2OfPLWrfnVmDEyBDnn/JiIjxWmPrLu6sCMQH5tZTHyZV8/RphoDaK6Hi?=
 =?us-ascii?Q?37F4iIiDs8QHQ2d/O39cNdtV6MMcm/qiFV3tCGyqWloSfiiGJanPwHbeO3NS?=
 =?us-ascii?Q?4UAdFIkO4ODQH0gLKcD1Q3jlL84smy4iaVzUHTB1Uu0ihANpQmeMIL2hU7L4?=
 =?us-ascii?Q?I4q+SNaz2pQM32RTYdbNVdeqkE4t8L18gNsPZbbuqh3pQSrI5SMlQjagNSb9?=
 =?us-ascii?Q?d8tjfAXzWhURQgXptNQ13ShXYWtlVVy52GJcmRKjsLaFxyCjA7bgpUAXFYPJ?=
 =?us-ascii?Q?gTwJxiX01Y3ffQ5KhX6teLqOtpsh0nPRa5s0KZ9Rly6Xj4O80RqdTCBhELr0?=
 =?us-ascii?Q?4xnV45s5zMO7gqa9ZxxsXb/2WiTLM7bpPMe4VJm7IWxYkWluQpOKu0gZ7mRs?=
 =?us-ascii?Q?7FMbjbqIU6UaAoCMVJdGDA1IXnhvJdvpnTY/2tyd6ewTk1EHy7dXP2P3n9Ij?=
 =?us-ascii?Q?Hr8Op+gw1lcIWdiUpI/W3V2z1d0fuTsPjMGC7ag5oHCIYjVLy9zeTk9R28uF?=
 =?us-ascii?Q?Yvbm0RLClHj7xStYXbWTJmYRl/ZLZLk0/yWW7350bwthTmzAtUnavk3j23S9?=
 =?us-ascii?Q?5n63Vw3M/BcpPYGV7P08WtXBut4qbyGRpk77KarhnQACnVdjhzii/yXSs1Es?=
 =?us-ascii?Q?M5fwECgTdAF3BInzUNncz/4xeLXg8UOTX5lXhCqdWZsNfj2JOxJdHf9iAfPT?=
 =?us-ascii?Q?N7WNS28tCrVjum/RQQ7klVxd9zXVw2yqPFnz8ruxLVyKBhAhgezC6WhAwFGA?=
 =?us-ascii?Q?GyRSQUejQbK8mrGGqy2cA/hcs2VJ9OvMgK8ZTCulOgLFL2yKKXPBEq0ZK5tX?=
 =?us-ascii?Q?qpQKUKMSBdcIRxeTpm+jRRLkbQyt8exx1z/EYjMI5Yo5QhK5m/O7FWYQmCWV?=
 =?us-ascii?Q?lnuyrbHxCQNLmFqK8onlXMckyo28PSaXvkAk2X41GXPGWdOCcUqZ7erWIM7F?=
 =?us-ascii?Q?GglLadGqPXGfQa+ScEGow2XHtpbjg9ZFFDL1Mr9YkEeuehqRU9G/dr3Q+GiI?=
 =?us-ascii?Q?Xj/evz6VZ1Bllir+q8Hkn910kzmWbVubutz0TuthI3GUGrhE+GxTnsktpTgV?=
 =?us-ascii?Q?Au9nhnxtwOfxBhsz+nfdM8N89ukXTPuuH59CSyJTNgtdNPTa0OuMIB+dV/E3?=
 =?us-ascii?Q?+3m+vlJ6GLn81YexvNA4a+YKU4tE75+6MOe8cBAQjpLIklJ4qNyr28gCTMHb?=
 =?us-ascii?Q?RyTELecxf1EF8+U70GVkEstDD4YSB+Ux?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:30.3733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2a1793-0d80-4c71-4f16-08dcd23066ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 56 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  4 +-
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0caab1a4ae8c..4928881c13b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2953,7 +2953,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	r = amdgpu_ras_recovery_init(adev);
+	r = amdgpu_ras_recovery_init(adev, true);
 	if (r)
 		goto init_failed;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c7cdbd2b5adc..f5cd91fd63ea 100644
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
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
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

