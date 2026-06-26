Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32D4CDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6306710F43A;
	Fri, 26 Jun 2026 07:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1/lOAqP";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F3010F43A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 07:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1vQ7EkvUzCtcha1b1x1CALrj/0JjaERvlgo9ilnfRdX46ySi6bbccDn0UNc3ThsDLjxhwXAIlI28B0pCJrzCgAp2gg8hYP3aVgW2wfDdp2ZgyiaW6e+yzivT+c9GrD0gPJySfUa3wQLn6Bok4dftKielpCVgl4gYjBvHtZJy8b+818Fs1EMiLZ6E6R8pQxcuhRD9V7kmHxTdbxIj66jLlLL3+NdVOn2mOQvw1uyIhVh9ZQRU0kJFJHOOKjALU7IKsnMK+q0kxl1oeYXF+mD7fnLpiud/PJ5ipmx8TDGTr44Z5EIqlLOeYT2tjDjvUuEeSOWx1eejwWXBTmsXnHLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xl0P5bsFbjaRzl1B58PlD9SeUSBzfxnZ4bG0ty9CDY=;
 b=vmOnti9yO9G0mG2r3JZ7lXZqsR4XQpMDHk3sSdUquUS3CDFZwtnjBomVgQKiabrg4hkJe/vxvtyUIOZ+PF4hksYdM0ysrCondm83W/54mSlrA1gi4mDlsR7/QcRxnbWkHt5/hocaIrVX0aXc9NCZnA7Zu1rD0cmDWnCgueZmsdf73Vqmam6qPiKA9UopcvYVYrliDoxxRhQrKs56iqWIVbzSsiL+jbJSnRpFSV9Vaes947Iu+WFC+GrXgGSCxyLTomJrV85dfJH5M36r7OY7LSWRtaEwMuqj92vD8DEvtZt1NX0xOxuAVbouchlhVnd+ZHOSTIq1LmcqS1R3XCThYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xl0P5bsFbjaRzl1B58PlD9SeUSBzfxnZ4bG0ty9CDY=;
 b=b1/lOAqPu+X07Ug0qTca+0yiNrQp/wNAlrb4Otu+gdw5bM2HOwhj3mklFU9mWVF8bkfxn9LUYUma4klTYrmUfupqrv0QzL5JyOEAdIiG++AdQvMJ2h5LZfWedMEytMvBOs1thsrA5EAM/L1aT3ybApph1sDqQ/HN+LUeSTqdsAk=
Received: from PH7P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::15)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::996) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 26 Jun
 2026 07:18:19 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::59) by PH7P221CA0035.outlook.office365.com
 (2603:10b6:510:33c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 07:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 07:18:18 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 02:18:17 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps dynamic
 switch
Date: Fri, 26 Jun 2026 15:17:52 +0800
Message-ID: <20260626071752.192163-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: e73922b1-57f4-4aa5-eef8-08ded3531923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Utc00IiUCuf/V2MVUmdxlnYLlddKpK5fItTSGBGFHRLGGirlCkzlUOj28FXZqXxfaG5wQY86e8fxb4rb4FkmoQB4Wn21yf3ZJ7nUD/RyvCb3BCR6AMC/v4pAocUnrFeK380je45r2v0UDjZmRTCLEmdmHc6NNj+R9+jo/iB4FdIKjpWC40y9V3j2W1X3AQ2blYyt8J9AYHIlX5pD6b2dDnv5kmxoCiH3Kshut1YAbuQr/oB1YdcMnBREDsB4tGVtaod0MMZ+Gg27y+X1hKe6EWH7jxh6smn3BT023AySKqvZnndmbPJcJV1/oRXXzVqmnO+WPqjWiE3gCYwSlvJnaWEquWzWtbDOe1fFsXmoRSXecSj2xGs2dI7DfuekAUg95XCmso31vwyuhJSLc1fwutwHt65CPbJNChXKgQsr6mAq4KiPys8DGW6SFYX2qWA9f0HR1pKM4/yGTU0fDAEZ4zUFzDeWRq43RdA01uqgtVoSH46FjqIB+UEtmwXYYbASODtZttvGgMEUpDdeHBjKWpzmQgLFyzkHqRHIDXy7+UUvLNrU0Ue5osSbIk1+Ouw5rjqu62avKGybCPHTYqrT+m3WrVmRTeZ9/i0irU+vf9CIPgTWH1+LWsDaCM7AJgrkoYQ7/tT3ISDwojM8ur1dMoNOMElQLbngs+/l5UlEA0dPcK+kshJiGR4ITzk4M3erWOFAH874gTqCa9oYt0CZxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7ffLBMaHNfHSSoQwdNYWgT5Kq9aUg7NTGFazrFO7NwA5681pb9YM1yGlNieJiPTR9YEFj0bfWvzRf9LI+3nhHtHjfOyDfnZr0xWrr2YoCo1fVxfRo917IqhrrBOiR4sJKlq7YwciK0N2AamIX+FL98Cfp4RaYMVH3blzIyNJVVBbm93s8yAYPby8+ICBfaVxwj7BozkpOe+xxBAogwz/GYlZ2gAM3sOn+1TaCf4V4rxFhdlYkIAJBMB50AF2Yp27EAxmxqPIS8JoodTU/5eDF+ZpKc60T/m/iKzhplJ3Jj/xivtSvyJ0wlKO3ZCkAmESdHy5xUn1T17OQ4Mc/V/knwuzWMZM2fg/C4eddBsNOGDCAIX3vjFJ/kz2lqZ+I9LwZUSAfwLlxby1AN6vDgiBBYKZcrX+EAW3MIN1r3p5TKoOz7HNBs29QQNMWTvAc0qR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:18:18.9848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73922b1-57f4-4aa5-eef8-08ded3531923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
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

On an XGMI reset-on-init (NPS memory patition mode swith), RAS
IP hw fini, sw fini is called but hw init is skipped due to
RAS IP block is not included in hwinit mask, so need call
RAS IP hw init during XGMI reset-on-init.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 14 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 10 +++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22 +++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7ef7c54ab982..e11c542a01b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3857,7 +3857,14 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (!con || amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (amdgpu_uniras_enabled(adev))
+	/*
+	 * For the reset-on-init path (e.g. an NPS memory partition,
+	 * switch) the RAS IP block hw_init has not been enabled and
+	 * the amdgpu_uniras_enabled return false, check amdgpu ras
+	 * context uniras_enabled flag, eepron init will be called
+	 * during RAS IP block hw_init.
+	 */
+	if (amdgpu_uniras_enabled(adev) || con->uniras_enabled)
 		return 0;
 
 	control = &con->eeprom_control;
@@ -5859,3 +5866,8 @@ void amdgpu_ras_post_reset(struct amdgpu_device *adev,
 			amdgpu_ras_mgr_post_reset(tmp_adev);
 	}
 }
+
+void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
+{
+	amdgpu_ras_mgr_resume_after_reset(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a86ab65aa2f0..ad24c7cf8936 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -1045,4 +1045,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
 					  struct list_head *device_list);
 void amdgpu_ras_post_reset(struct amdgpu_device *adev,
 					  struct list_head *device_list);
+void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 9a4e8715742a..f175c8987aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1669,6 +1669,16 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 		if (r && r != -EHWPOISON)
 			dev_err(tmp_adev->dev,
 				"error during bad page data initialization");
+
+		/*
+		 * For the reset-on-init path (e.g. an NPS memory partition
+		 * switch) the RAS IP block hw_init was skipped under the
+		 * minimal init level, so uniras was never enabled. Bring it
+		 * up now that the reset domain has been unlocked. This is a
+		 * no-op for any other reset path where RAS is already
+		 * initialized, and for non-uniras devices.
+		 */
+		amdgpu_ras_resume_after_reset(tmp_adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index f627a97797ed..a70e532b3d00 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -465,6 +465,28 @@ static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_ip_block *ip_block;
+
+	if (!con || !con->uniras_enabled)
+		return 0;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return -EINVAL;
+
+	if (ras_mgr->ras_is_ready)
+		return 0;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_RAS);
+	if (!ip_block)
+		return -EINVAL;
+
+	return amdgpu_ras_mgr_hw_init(ip_block);
+}
+
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
 {
 	if (!adev || !adev->psp.ras_context.ras)
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 4f44a917d48b..3f80b9f1f0ac 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -82,6 +82,7 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 		void *output, uint32_t out_size);
 int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count);
 #endif
-- 
2.43.0

