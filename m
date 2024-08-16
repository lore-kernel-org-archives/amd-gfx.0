Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C97AC5320D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 22:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2F410E85A;
	Fri, 16 Aug 2024 22:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i/2ZLk59";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598C810E857
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 22:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlDeP6xptRf+f7WWPc3H45vcvFy4XIqd99GzB/8Kkyx+xhkOLajVK9tp+hhufljzyUwBKPberOfsLKbvrME6dVW+GxvfBnnPL/lV3Th04YmXx+3BdtHoabzlZxdFWlthQNSAQtacBOWbQEgTl+IeXZ6683qe+eWa9MIO3MfGNVN8QS4ks+pAKB3HV32ARUdexK2ZoYxTnjPMg2/3BkgbaV416u8pJ2HBE2VqWYy1HLtlm/POv0+QFUAQRiNrHfKzVSLCVmME/annR+nLv54O7EOm2O+umb1FSJ18Lq2cO/9SocF6PzZuWuCzhY/ncvx2HRM5zGA9ABzpOc3J2oVxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQkWoPE1FpEGxMAIpnsgv/EsYfUnLLI9Xk+Py7ktEdc=;
 b=QIXFgLF5nhJ/sJh76OVO183dLcUw7udoMLkaQKXg9ULkXrVIahAjq6s/o0QEcJUfWLgmP0bEkgj+2Gg9bAjMB+yQUtN0PAWhgQ4TmhvkeHtimGUteDfCvbresxL3jxzTHFTPCXBxY6GBgNAQADP+PEwAolMnYGKL5TOfFtlWVcVXU5h0aueWCw3vCpmyG+ZOUfXG/RQxsCZtW90Gx+LVIXY3qT+VYcGr9wZ4mqiWsak5jbCSzT7tbV7IXWGdTnZOCqCKH6SP7PY3AjJfPYNt1rqouLlZ2hRYhx0OWvpEBj1il6NO/mrbUjtRaMX7jpEmGTTVPKr71ng1iKjDUi+Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQkWoPE1FpEGxMAIpnsgv/EsYfUnLLI9Xk+Py7ktEdc=;
 b=i/2ZLk59QCjv07zaShnAcUgC1Yx38a+JPDDEe529a6rhRp4fvhPcvVh5SyQhyeo3jIc6UYBgAjK+CAHyiRNpayfakbdR/sJ3Wl1hFTSnxASyBsm6N5Dhl9csDta33jpCiMr7C5a2oeDO2Gaatr6Mkw3yEFzW4vKao6TBlMwyrgg=
Received: from PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::15)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 22:58:15 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::ad) by PH7P220CA0153.outlook.office365.com
 (2603:10b6:510:33b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 22:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 22:58:15 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:58:14 -0500
From: <sunpeng.li@amd.com>
To: <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 4/5] drm/amd/display: Implement DMUB_IPS_DISABLE_DYNAMIC
Date: Fri, 16 Aug 2024 18:57:53 -0400
Message-ID: <20240816225754.156098-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816225754.156098-1-sunpeng.li@amd.com>
References: <20240816225754.156098-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: da549eeb-99f4-419a-b33d-08dcbe46e988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVB3lQGYOSYnVXlUkmEd0jGtL9gYdTgT8N8/CSAjg+U7NC/Glq5/Mg7Ae2vJ?=
 =?us-ascii?Q?yaVyI8hbj6lQOUDVOTru8s48UScM6Oylv7ACuhiYN1V59wuJFyCzkZw29Y0d?=
 =?us-ascii?Q?0kfE6MF5B1tw1bV8HjdmGAlOdWYosHj5jieqlQtO0zPXyzXa+OPimUyAmxsF?=
 =?us-ascii?Q?QULxBH0qt71IBCgaUy5P7wdq6fB05J/k92MYZUCiQ2ihFPwGCx3Vbhb+4VGU?=
 =?us-ascii?Q?m8VAIiWcCemNmkTyvftJ99N168KkFgfu+00ia3kCOd/p3MEWKhiFmXUvRj/X?=
 =?us-ascii?Q?hkaVsnst5cI3V7GrV4m0+OK56imr1XJ4hyeheE3Hqn/N9By40NF8j1xfj2IZ?=
 =?us-ascii?Q?cKG3wS/sNMQXDrMp+dZhflWUdGQq2hjmCDd/9gcNbPobb7qH4E21T39vddHl?=
 =?us-ascii?Q?UF40upVptrss9+obullJp+7gSgQNx0hnK4OT3yVEwugVeBaHENzuiZcU7oFD?=
 =?us-ascii?Q?0H6buvqjRHuGsaDdtXpK2MJd1hgPgAjtvNaohli9ZWGnccquKj1W5A/WVfBe?=
 =?us-ascii?Q?IaigaPae8x/w3u9LhPpXfi/Wt3F4bqmPMOqjRJTSDt6UlIby9mi/H4JSAsdj?=
 =?us-ascii?Q?bxfs8WNO+lnVnISvG8SVchGm/najA0OOi5Xda9ltkM/tGEIOFOnzmy330oJo?=
 =?us-ascii?Q?rG9q12NPHqItmcu7wv/Vtc5elhwRt+cgqxBaucB+fMwsuhVvt1DSR8j0kZm7?=
 =?us-ascii?Q?jawACGCiFULjCP9W8UJE07HgJ0+yVhAgax0xvsVvBZPaobbWg/3HH/AvBZGN?=
 =?us-ascii?Q?Oyml3e5MRLBMnTJajZSNqWhhr1BMPPgi0K+uXwB5CJBGKEMciMMRCbjV2Nq9?=
 =?us-ascii?Q?+5o0bdLkKkgk//+qd+GBD0t0wpLE6v47AwKRXqAOdwSXU83s1CVgxbR0gDqR?=
 =?us-ascii?Q?+4fJQlc/Itoq9IdrnurUh+hKh3b6+i+SZ+Bkfa5cBVX+b/ygLVsTG9lbj1pe?=
 =?us-ascii?Q?GdjVGfbkJQO6RcaPdG5Fq5x/JDwfP950aggm8b6oOBR7xCDL+TI67BNjU3iW?=
 =?us-ascii?Q?Jls6jWZv59M+4NB1fWJsrjIRqfSm5mi0WLcQjgQW4IdQ+EeA1Cj1CT0kSuIW?=
 =?us-ascii?Q?klFtrmrDkayMXXUoXeiIT7x80IwnP9zCWguDuvoeL8i0WhauCsSyXhb8iQoe?=
 =?us-ascii?Q?Zuyla2MGgbWc+uKdfvNdvf2AJqqUEfyWg1G9YEgeBCyJVNjW4jUmn/ByOK8I?=
 =?us-ascii?Q?OBUomNrwyVxaZH1h7GG6kqxT+Dteff20YIdhErLTydw3RanSdV+7ZFoEoRK0?=
 =?us-ascii?Q?jOYaOOH+H5wyFuh1Sgntux9yhRHor5NWLYvmQK+b6BH79gnZSNFPZEbTwzf0?=
 =?us-ascii?Q?MNtc4UCy6AOzqQwpt0USaUqXGCfHKWNBvW8c2FfGL32o7iwufX1ucOt0QMZU?=
 =?us-ascii?Q?aJ8Gct2Yq5fBRhth40XNeWliUUeRR6yThrdN6/yO9sswrIZ2TboHtNdCsDGI?=
 =?us-ascii?Q?WwSa6PZdrcAEXd5akBxOsCuUDpzCWotv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:58:15.3556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da549eeb-99f4-419a-b33d-08dcbe46e988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

The IPS_DISABLE_DYNAMIC configuration disables IPS in all cases except
for when the driver is put into d3 for s0ix.

[How]

Now that we have a common entry point into dc_allow_idle_optimizations
from dm, implement said configuration there.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 +++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++-
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c99cff3650f14..f9b5966746c73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -247,10 +247,38 @@ static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
 
+/**
+ * dm_allow_idle_optimizations_internal() - Allow or disallow idle state entry
+ * @dc: pointer to display core struct
+ * @allow: If true, DC is allowed to go into idle power states. If false, DC
+ * will immediately exit idle power states
+ * @suspend_resume_path: Set to true if the caller is part of the suspend or
+ * resume path
+ * @caller_name: Function name of the caller - for debugging purposes
+ *
+ * Debug flags are considered in this function, so any DM callers should go
+ * thorugh this rather than call dc/dmcub interfaces directly.
+ */
 void dm_allow_idle_optimizations_internal(struct dc *dc,
 					  bool allow,
+					  bool suspend_resume_path,
 					  char const *caller_name)
 {
+	/*
+	 * We can early-return here if IPS support exists, and DISABLE_ALL debug
+	 * flag is set.
+	 *
+	 * We also need special handling for IPS_DISABLE_DYNAMIC in DM to allow
+	 * IPS only for the suspend/resume call path.
+	 *
+	 * The rest of the debug flags are handled in `dc_dmub_srv_notify_idle`,
+	 * which if IPS is supported, will eventually be called.
+	 */
+	if (dc->caps.ips_support &&
+	    (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL ||
+	    (!suspend_resume_path && dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC)))
+		return;
+
 	dc_allow_idle_optimizations_internal(dc, allow, caller_name);
 }
 
@@ -2891,7 +2919,7 @@ static int dm_suspend(void *handle)
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
 
-		dm_allow_idle_optimizations(adev->dm.dc, false);
+		dm_allow_idle_optimizations_suspend(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
 
@@ -2918,8 +2946,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
+	/* IPS2 entry is required for standby */
 	if (adev->dm.dc->caps.ips_support)
-		dm_allow_idle_optimizations(adev->dm.dc, true);
+		dm_allow_idle_optimizations_suspend(adev->dm.dc, true);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
@@ -3091,9 +3120,8 @@ static int dm_resume(void *handle)
 	bool need_hotplug = false;
 	struct dc_commit_streams_params commit_params = {};
 
-	if (dm->dc->caps.ips_support) {
-		dm_allow_idle_optimizations(dm->dc, false);
-	}
+	if (dm->dc->caps.ips_support)
+		dm_allow_idle_optimizations_suspend(dm->dc, false);
 
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
@@ -3142,7 +3170,7 @@ static int dm_resume(void *handle)
 		commit_params.streams = dc_state->streams;
 		commit_params.stream_count = dc_state->stream_count;
 		if (dm->dc->caps.ips_support)
-			dm_allow_idle_optimizations(dm->dc, false);
+			dm_allow_idle_optimizations_suspend(dm->dc, false);
 		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
@@ -3216,7 +3244,7 @@ static int dm_resume(void *handle)
 		} else {
 			mutex_lock(&dm->dc_lock);
 			if (dm->dc->caps.ips_support)
-				dm_allow_idle_optimizations(dm->dc, false);
+				dm_allow_idle_optimizations_suspend(dm->dc, false);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
 			mutex_unlock(&dm->dc_lock);
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3fc3c12b3a4a1..da7283c67b13c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1009,8 +1009,11 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
 void dm_allow_idle_optimizations_internal(struct dc *dc,
 					  bool allow,
+					  bool suspend_resume_path,
 					  char const *caller_name);
 #define dm_allow_idle_optimizations(dc, allow) \
-	dm_allow_idle_optimizations_internal(dc, allow, __func__)
+	dm_allow_idle_optimizations_internal(dc, allow, false, __func__)
+#define dm_allow_idle_optimizations_suspend(dc, allow) \
+	dm_allow_idle_optimizations_internal(dc, allow, true, __func__)
 
 #endif /* __AMDGPU_DM_H__ */
-- 
2.46.0

