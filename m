Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8070BCCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2323110EAC3;
	Fri, 24 Oct 2025 16:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5eJfAT3R";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24A810EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyKow4umdJ8KkG0Q8mRmcGYjYdszHUwD6sz7dvmVpEwSQzD0+xgmH0VnUw2h6eSfnjnrXX2VltpBzUzpsECtwlgUjLQjwRSio2Wvf1K1mNptpl1o4pdyJUl0PzW71kgRcqGQWtjaPD6NSdoub3V8JJrK3Dfc7I/O9nNYUlP98J6a/Poqz7Yt/7RX/05x6CvYX4Eot6nlsPAQCXWwm2PMO3za+GhsNeIYx55OjafD0ru9nzSndkF12NjO80sqe8K1/mfzFKAqXu9x6NRQerzdWDGLgZrcocgbGOuKwGHw1j7nfwSao6hiM7794LhtcPMDtO8IzuvGcGfQL/prHThMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL/5VP1mr0/oUmmC8bjvfqrkeCk8UdxGiGrHBIfY2lE=;
 b=BY4kWlh7iQjzDK8eQ4jpHSUXxpJsQsswQ2YfROuQFQYLWnTepnmvpI6ZLY7JRUHjBwa62aTAGOP19GmFakgljrW3xBGffRW8Hl9NowMc/j6Je+4TGbe73jVr8rba2bkpsdNWpWF1QzErfqcXQ10WtXrGjJNBugRLX3pxYjmKAOMTVFVzi5wlpqbfxA2Re4OnfHfwNlB86WDR70QC2YcdOudYqMSKqpYQF/cMvTPg1eL2a7WMpAj2P55TsqcxunP35TNe41eL+4OCKPfvoQCTxMRDFwtlQk/jvzYPqVDyUH3rkIpXW7gI9barrDWM6OSUCZMZ4vh03oHXsElWBqi+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL/5VP1mr0/oUmmC8bjvfqrkeCk8UdxGiGrHBIfY2lE=;
 b=5eJfAT3R1FoUExRGp7r0WzP0fNdr5q25zKQpjoh+1YAxxl9jYnEuBpvOmUO8tvtNZ8sJpf5wq0IMOpKxn+SUreOlPvUFbxsVMdqhvR/ofrAZtDl+l9qjsJS36UeaDupNbCl0r54DktTjtg+f/xThk3sBvZRyotasRdoHhu0YUPc=
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:12:39 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::e8) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.5 via Frontend Transport; Fri,
 24 Oct 2025 16:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 16:12:38 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Oct 2025 09:12:35 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Antheas Kapenekakis
 <lkml@antheas.dev>
Subject: [PATCH 1/2] drm/amd: Move Van Gogh specific suspend code into common
 `set_mp1_state`
Date: Fri, 24 Oct 2025 11:12:15 -0500
Message-ID: <20251024161216.345691-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024161216.345691-1-mario.limonciello@amd.com>
References: <20251024161216.345691-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb91ef5-a2c2-4c95-1567-08de13182711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ksQ086sq6OjPCWVksb3oKNnsECaQ9EHkm1Jxf2cW68S7nZhPv7X8r7Ix0+3Q?=
 =?us-ascii?Q?BmxRsHULLHkm7kl1gG+dB/uWRZWB6TbLRMAKTXlp/MBVqrnyrLUd8YQdln33?=
 =?us-ascii?Q?J5KR7eJA0TMwvyQaHb2csZ+gqLQ395Oz2SteYthaAGM/RsVKR+wR6jX6EnYA?=
 =?us-ascii?Q?KpPCDSi5xFCHZrvxjX/DjOHPop85Sv2twJzXazOB0DPcxoADg3LOdBYq5sie?=
 =?us-ascii?Q?xiRtLH70cKx+xFFVe8NJpyx6uYNrR8mNnqvkrgOPFFNMpYS5fNCZTCqiAZ6c?=
 =?us-ascii?Q?trhHv/xHW0JNp2HOlqGK13hOZv7517Gauk2ebw4yRXV5z3VPv1T0qAj1oAYN?=
 =?us-ascii?Q?BHCtAbuhjqIw6OxfFeSZCTADMGiUljSrXZ20SkFNvW5ouMwXlnvrpR+iptJp?=
 =?us-ascii?Q?wWfLGVAVNjdfoWR46tC201H1JDLQ7ukWUc1LJKY4oZTnuwGDjumY1G0i8Ozq?=
 =?us-ascii?Q?MHmw5z0Dx/wxS90tr2YhOBdMq4Ug1NOqDVSY4ez3Mruj8S5Pgmv1fs1MU4Vv?=
 =?us-ascii?Q?cL5rC484qBxQsq1G6tCO7OU1Ttn9DsqJQ3RY/qcJhRqTwnOdHUPo6nmZKOIz?=
 =?us-ascii?Q?wVee4kiwI+a2lHj+2CC5+/CPyv1wut3z+IJdsUtpp7zrHOSRwgWqZ4nopWTA?=
 =?us-ascii?Q?sL4X87Kpb3yC7d7IQz7OlbenkIyodwAEsKc1HQI9bzugmCJoi+fF/1Hqi6Pj?=
 =?us-ascii?Q?/qWayAth0yqiIUcfzuYSYs+WNIhbfS00dCvW0QBYknL4LbIjHp0uI92Ld+lP?=
 =?us-ascii?Q?xRKkzAHW9ioCrfcio4Nj7sHw6WZWqcnMGn2ZtzmUoSAb87wCIP2oXWtS3cIb?=
 =?us-ascii?Q?jrObRiWEW+xVAmjPFWdu8kZKZ9JlAuAxledcwPrQpxnoH/QA/gzP8EMDk5Ym?=
 =?us-ascii?Q?N1rP0I5aPlRyZ17flShTZsQIOdgQ7K46LSlmKO01qu4GfqQkNqc3kG1Y7u2k?=
 =?us-ascii?Q?s8osxZ0IMHp8syBUmBgQDzC8ozbdh5uu8Mtz94fkC1andgnQwVNYARoVpZhD?=
 =?us-ascii?Q?GsxKTz5lSzgfGCit7E3+8QwDbx5s8y0MDlX4nfFTF8+ixQAdLHNst8rqplq0?=
 =?us-ascii?Q?6A4OIVdtDsLd2ZbptY2BThpPc8+fykgeQNjXoToH9UXdlBaa7FaNTV9a2Lcp?=
 =?us-ascii?Q?4jy+IFroHNWl9rs1pH331CBvI8TfcUJR7eEYVv7MVxTZqUGQ9JWu0U2+sTnY?=
 =?us-ascii?Q?MMTn1fAXeI42bcuEyCyjlxJ8q+EUWpFyF6XBhejS9mK0Qqp7ue2yhZsEeu2p?=
 =?us-ascii?Q?N64zWlyXqpLAiYkdjPetX44+ISejy6cSjU/VyZSM2RjM1dMqoIrzY7JHcF2t?=
 =?us-ascii?Q?k3nVFJ2W5C+8/loyT4uafNtRM9WAT26SOFdOjzpqrG5y0h+m5OKlGmwbo+Pb?=
 =?us-ascii?Q?ZExr9qj6UkrPIBU1773SaWhIJ+cf9epoaIv5ih5Ft75SLPAVaJh7US9ZUEex?=
 =?us-ascii?Q?uV0OqgQjv+S9n3msdyLu0oIMZgZRh3gB1EKvQ7dNoP9bBDd0laLilS6uIezp?=
 =?us-ascii?Q?2BEkeHSu5HLGXImRDOQw7+esCxrEzTd47eatV9Nw6CEukfT0lFmf3KXWGavj?=
 =?us-ascii?Q?ypi5tpsUWD05ra7glw0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:12:38.7417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb91ef5-a2c2-4c95-1567-08de13182711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

[Why]
An `.notify_rlc_state` callback and wrappers for it were introduced
to support notifying the PMFW that the system is about to suspend.

There are already callbacks for `set_mp1_state` which get called at
suspend though from `amdgpu_device_ip_suspend_phase2`.

[How]
Tear out all the notify_rlc_state callbacks and instead move the
Van Gogh specific code to a `set_mp1_state` callback.

Cc: Robert Beckett <bob.beckett@collabora.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ----
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 -
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 18 ------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 -----
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
 8 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ffb9bb1ec0b..4dbdcb7b11e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5281,10 +5281,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
-	r = amdgpu_dpm_notify_rlc_state(adev, false);
-	if (r)
-		return r;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 87814c2b526e..48846a3e4b7b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -523,7 +523,6 @@ struct amd_pm_funcs {
 				   struct dpm_clocks *clock_table);
 	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
 	void (*pm_compute_clocks)(void *handle);
-	int (*notify_rlc_state)(void *handle, bool en);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5d08dc3b7110..5c4d0eb198c4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
-{
-	int ret = 0;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (pp_funcs && pp_funcs->notify_rlc_state) {
-		mutex_lock(&adev->pm.mutex);
-
-		ret = pp_funcs->notify_rlc_state(
-				adev->powerplay.pp_handle,
-				en);
-
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return ret;
-}
-
 int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 3bce74f8bb0a..c7ea29385682 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state);
 
-int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
-
 int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
 
 int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4317da6f7c38..10d42267085b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context *smu)
 		}
 	}
 
-	/* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
-	 * otherwise SMU will hang while interacting with RLC if RLC is halted
-	 * this is a WA for Vangogh asic which fix the SMU hang issue.
-	 */
-	ret = smu_notify_rlc_state(smu, false);
-	if (ret) {
-		dev_err(adev->dev, "Fail to notify rlc status!\n");
-		return ret;
-	}
-
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
 	    !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
 	    !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c48028abc8c4..361e09f20ead 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1496,11 +1496,6 @@ struct pptable_funcs {
 	 */
 	int (*set_mall_enable)(struct smu_context *smu);
 
-	/**
-	 * @notify_rlc_state: Notify RLC power state to SMU.
-	 */
-	int (*notify_rlc_state)(struct smu_context *smu, bool en);
-
 	/**
 	 * @is_asic_wbrf_supported: check whether PMFW supports the wbrf feature
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 53579208cffb..3dc1919b8c64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2208,6 +2208,23 @@ static int vangogh_notify_rlc_state(struct smu_context *smu, bool en)
 	return ret;
 }
 
+static int vangogh_set_mp1_state(struct smu_context *smu,
+				 enum pp_mp1_state mp1_state)
+{
+	int ret;
+
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		ret = vangogh_notify_rlc_state(smu, false);
+		break;
+	default:
+		/* Ignore others */
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int vangogh_post_smu_init(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2524,7 +2541,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.print_clk_levels = vangogh_common_print_clk_levels,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
-	.notify_rlc_state = vangogh_notify_rlc_state,
+	.set_mp1_state = vangogh_set_mp1_state,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_profile_mode = vangogh_set_power_profile_mode,
 	.get_power_profile_mode = vangogh_get_power_profile_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c09ecf1a68a0..b9976313e741 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -96,7 +96,6 @@
 #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
 #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
-#define smu_notify_rlc_state(smu, en)					smu_ppt_funcs(notify_rlc_state, 0, smu, en)
 #define smu_is_asic_wbrf_supported(smu)			smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
 #define smu_enable_uclk_shadow(smu, enable)		smu_ppt_funcs(enable_uclk_shadow, 0, smu, enable)
 #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
-- 
2.49.0

