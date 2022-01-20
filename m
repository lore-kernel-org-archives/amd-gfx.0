Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17477C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 19:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966D410F217;
	Wed, 19 Jan 2022 19:56:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C4D10F229
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 19:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZLj05FzKWpafUg3JPOCvMpdvNr34nvCm3LgGpasWVRhs8xSTr0cj8X7Be9NOfuTM7qylYxpT6PqJ6xW43iI3QenjCcmiNr5TvDyA8qjMUqW+wbeYXDJULU0ZQXaG2UVf1Pgy6iKaY98gh2WZjzlzPNKETTLI2iuBLJM33uZwNK1oN5/7X9Hjt/VJA4UiyXS0Q4c3+gBecaMUeGJndVH5NbqO3nf4yrYtHyN7GMBkndVq5uwGGhNRlzdA8xS/TkUE1rxKz0fkIACQ3pIVYNKhD0NuiZztn6I3ZHbRZQTPVyLwp301FQJRe6UYZpyiba2viaAahgvOUdDPQ2jQ1Cghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4vYxmmDBEvqSb0r4Kj53UExxnXvdvLq2IvaTVZOvlk=;
 b=l/WDxFC4ysyLevV83rv03AZHfqQjO3cvlzFawiTLUqDEdTbm7OoimaMXCrRKb+4wJjenAnOkUscQPB71EXuB5Yy4Upjkk7CtlMbBwJxK6TdzesEVIfBjaWucOp9Mi+LjwlbAd3jDib41Y31yl9MjAKfP/EOFDilhetw7Wa7KMAxHo+33pBdyEd1LfnQ0WdFGPOiV5IVOW9jQfSrjMkesNj0+YzjzybMvzGartKYZK1qm/0gBQE1w49VRTyeF41eLsJ2wvKw2oGMRxTJPqv+fhfG2wo3UVsDdxdefG29tfC30+wE2bIVOxQSPRHAvcoZ7WvIDYHPCNDGAruiirpTeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4vYxmmDBEvqSb0r4Kj53UExxnXvdvLq2IvaTVZOvlk=;
 b=tYjS6YsFk2/XoTc4RseMh5LjuqwhgHO22Va5Bs69pelsrQ+FUeXQm0jGNC4o50GCYPvraWePM4Z5CppAsjeYH8/kzAxx+3VNRqPgEA7pL0+wLW8dlBh6LZgzid+YmUtn56P0CLRaPd+PmYUp2Ns2rr1yz4DlBaG1gaIHYx+jtzI=
Received: from DM6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:5:80::42) by
 DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Wed, 19 Jan 2022 19:56:28 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f6) by DM6PR08CA0029.outlook.office365.com
 (2603:10b6:5:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 19:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 19:56:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 13:56:27 -0600
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 19 Jan 2022 13:56:25 -0600
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkcl: Resolve build issue with
 kcl_amdgpu_get_vblank_time_ns
Date: Thu, 20 Jan 2022 05:00:52 +0100
Message-ID: <20220120040052.1826154-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d110681b-c0fc-4db9-d223-08d9db85c812
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53448F8A006396C21C403E8F98599@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peS32H6iJwy9yeA64JxsgIG5mRc9WiI5V3+gwuALd1MqhSZFUQbqqD5S7dmU9I7NOgvuvBitbMiL0bBKXfsKHUlIFBHHhrZInAdrNLHqlZEGcsPD3VYU0LrBEJWcAjKYIfJybi1l9TxdjxWbz9k8nOt1JLAzPXu5jEJxDP/a65pqqbF3l0D0Vo3QoO9V/1WfbHIF5W4xUS91jkgwX+ErSRpWlXLM3pNB/Jpx+Bri5CPOMdQwRtpJkHts5lihDh5Z4qjhhq7WftVco9CS99hEK8FnzjKKocjtAlPZ5jjIGkd3PtgigXzXAgzRvV2Q7oRWHipZ+1NuzZuE/fSoHsJbWiJj0dXi5CB0UVMwozjw42QqQPGtv3EzVYXI9I0lE8GRSjt59yjGejLcwSo784+l4Q14Ufg4yMOwsUkdSdbbb9Go2iMF4PVkwmmA5WuVPEakBCRs2eJYWgDMCnXQNNnpVMT5fcaVFaJDKBsqinwrtbqfDtzqOWtzkn/KqgBZl7xbxkWz9j9RHfKMyejI7hD6hdCzWsffvqSVP+QevGuxC8td5rLQdOgZK9OI/S4pW4T+DdqYtM04wTSIW/0S0uOaiyAX7qrFSm+uVM41AJClwavZgoL5/mDO/P4dTC2QTxc1JUjox6Q6/lUtWGeqp/nya3xP9Vj1fTV734Hjlgzyl+mMLiamqIHfBSq6xq4YyXB3sRs84TBjOLGV6pEhFWD9agZ1eFjcL7MIb3Tqo4PvHq0ye8i/XNhzxkpkBUFCj1+2PxhDsBzXuzcHDl7+1+NUFZWL4qMpP8rc2c8JolVFxK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(508600001)(36860700001)(426003)(81166007)(316002)(186003)(82310400004)(5660300002)(356005)(7696005)(86362001)(26005)(336012)(70586007)(36756003)(1076003)(6666004)(8936002)(40460700001)(6916009)(4326008)(2906002)(70206006)(8676002)(44832011)(2616005)(47076005)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 19:56:28.2664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d110681b-c0fc-4db9-d223-08d9db85c812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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
Cc: Yuliang.Shi@amd.com, Danijel Slivka <danijel.slivka@amd.com>,
 Nikola.Prica@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix incompatible pointer type passed as argument 1
of 'drm_crtc_vblank_count_and_time'. Wrapp the code that uses
drm_vblank_crtc->time under HAVE_DRM_VBLANK_CRTC_STRUCT and
access time field of drm_vblank_crtc structure depending on
the field type, defined by HAVE_DRM_VBLANK_USE_KTIME_T or
HAVE_DRM_VBLANK_CRTC_HAS_ARRAY_TIME_FIELD.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 .../drm/amd/backport/include/kcl/kcl_amdgpu.h | 16 ++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  2 +-
 drivers/gpu/drm/amd/dkms/config/config.h      |  6 +++
 .../drm/amd/dkms/m4/drm_vblank_crtc_struct.m4 | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/dkms/m4/kernel.m4         |  2 +
 6 files changed, 65 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/dkms/m4/drm_vblank_crtc_struct.m4

diff --git a/drivers/gpu/drm/amd/backport/include/kcl/kcl_amdgpu.h b/drivers/gpu/drm/amd/backport/include/kcl/kcl_amdgpu.h
index fc2eecd49d62..21dd7f1dd2e9 100644
--- a/drivers/gpu/drm/amd/backport/include/kcl/kcl_amdgpu.h
+++ b/drivers/gpu/drm/amd/backport/include/kcl/kcl_amdgpu.h
@@ -90,16 +90,20 @@ static inline int kcl_amdgpu_get_vblank_timestamp_kms(struct drm_device *dev, un
 #endif /* HAVE_STRUCT_DRM_CRTC_FUNCS_GET_VBLANK_TIMESTAMP */
 
 #if defined(HAVE_DRM_VBLANK_USE_KTIME_T)
-static inline ktime_t kcl_amdgpu_get_vblank_time_ns(struct drm_vblank_crtc *vblank) {
+static inline ktime_t kcl_amdgpu_get_vblank_time_ns(struct drm_vblank_crtc *vblank)
+{
 	return vblank->time;
 }
+#elif defined(HAVE_DRM_VBLANK_CRTC_HAS_ARRAY_TIME_FIELD)
+static inline ktime_t kcl_amdgpu_get_vblank_time_ns(struct drm_vblank_crtc *vblank)
+{
+	return timeval_to_ktime(vblank->time[(vblank->count) % DRM_VBLANKTIME_RBSIZE]);
+}
 #else
-static inline ktime_t kcl_amdgpu_get_vblank_time_ns(struct drm_vblank_crtc *vblank) {
-	struct timeval tv;
-	drm_crtc_vblank_count_and_time(vblank, &tv);
-	return timeval_to_ktime(tv);
+static inline ktime_t kcl_amdgpu_get_vblank_time_ns(struct drm_vblank_crtc *vblank)
+{
+	return timeval_to_ktime(vblank->time);
 }
 #endif /* HAVE_DRM_VBLANK_USE_KTIME_T */
 
-
 #endif /* AMDGPU_BACKPORT_KCL_AMDGPU_H */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c8ba92e9ff1b..443dbf152734 100755
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -495,7 +495,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 		     vrr_active, (int) !e);
 }
 
-#ifndef HAVE_KTIME_IS_UNION
+#if defined(HAVE_DRM_VBLANK_CRTC_STRUCT) && !defined(HAVE_KTIME_IS_UNION)
 static inline ktime_t get_drm_vblank_crtc_time(struct drm_vblank_crtc *vblank)
 {
 	return kcl_amdgpu_get_vblank_time_ns(vblank);
@@ -507,7 +507,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_crtc *acrtc;
-#ifndef HAVE_KTIME_IS_UNION
+#if defined(HAVE_DRM_VBLANK_CRTC_STRUCT) && !defined(HAVE_KTIME_IS_UNION)
 	struct drm_device *drm_dev;
 	struct drm_vblank_crtc *vblank;
 	ktime_t frame_duration_ns, previous_timestamp;
@@ -519,7 +519,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 
 	if (acrtc) {
 		vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
-#ifndef HAVE_KTIME_IS_UNION
+#if defined(HAVE_DRM_VBLANK_CRTC_STRUCT) && !defined(HAVE_KTIME_IS_UNION)
 		drm_dev = acrtc->base.dev;
 		vblank = &drm_dev->vblank[acrtc->base.index];
 		previous_timestamp = atomic64_read(&irq_params->previous_timestamp);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 5e83030ce88b..7b6634617fca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -684,7 +684,7 @@ TRACE_EVENT(amdgpu_dmub_trace_high_irq,
 		  __entry->param0, __entry->param1)
 );
 
-#ifndef HAVE_KTIME_IS_UNION
+#if defined(HAVE_DRM_VBLANK_CRTC_STRUCT) && !defined(HAVE_KTIME_IS_UNION)
 TRACE_EVENT(amdgpu_refresh_rate_track,
 	TP_PROTO(int crtc_index, ktime_t refresh_rate_ns, uint32_t refresh_rate_hz),
 	TP_ARGS(crtc_index, refresh_rate_ns, refresh_rate_hz),
diff --git a/drivers/gpu/drm/amd/dkms/config/config.h b/drivers/gpu/drm/amd/dkms/config/config.h
index 39ca152effa3..98f38a604d28 100644
--- a/drivers/gpu/drm/amd/dkms/config/config.h
+++ b/drivers/gpu/drm/amd/dkms/config/config.h
@@ -386,6 +386,12 @@
 /* drm_vblank struct use ktime_t for time field */
 #define HAVE_DRM_VBLANK_USE_KTIME_T 1
 
+/* drm_vblank->time is array */
+#define HAVE_DRM_VBLANK_CRTC_HAS_ARRAY_TIME_FIELD 1
+
+/* drm_vblank_crtc struct exists */
+#define HAVE_DRM_VBLANK_CRTC_STRUCT 1
+
 /* drm_driver->release() is available */
 #define HAVE_DRM_DRIVER_RELEASE 1
 
diff --git a/drivers/gpu/drm/amd/dkms/m4/drm_vblank_crtc_struct.m4 b/drivers/gpu/drm/amd/dkms/m4/drm_vblank_crtc_struct.m4
new file mode 100644
index 000000000000..380424bf0401
--- /dev/null
+++ b/drivers/gpu/drm/amd/dkms/m4/drm_vblank_crtc_struct.m4
@@ -0,0 +1,43 @@
+dnl #
+dnl # commit v3.12-rc3-146-g5380e9293b86
+dnl # drm: Collect per-crtc vblank stuff to a struct
+dnl #
+AC_DEFUN([AC_AMDGPU_DRM_VBLANK_CRTC_STRUCT], [
+        AC_KERNEL_DO_BACKGROUND([
+                AC_KERNEL_TRY_COMPILE([
+                        #ifdef HAVE_DRM_DRMP_H
+                        #include <drm/drmP.h>
+                        #else
+                        #include <drm/drm_vblank.h>
+                        #endif
+                ], [
+                        struct drm_vblank_crtc *vblank = NULL;
+                ], [ AC_DEFINE(HAVE_DRM_VBLANK_CRTC_STRUCT, 1,
+                          [drm_vblank_crtc struct exists])
+                ])
+        ])
+])
+
+dnl #
+dnl #  commit v4.6-rc7-1094-gd4055a9b2079
+dnl # drm: use seqlock for vblank time/count
+dnl #
+AC_DEFUN([AC_AMDGPU_DRM_VBLANK_CRTC_HAS_ARRAY_TIME_FIELD], [
+        AC_KERNEL_DO_BACKGROUND([
+               AC_KERNEL_TRY_COMPILE([
+                        #ifdef HAVE_DRM_DRMP_H
+                        #include <drm/drmP.h>
+                        #else
+                        #include <drm/drm_vblank.h>
+                        #endif
+                        #include <linux/ktime.h>
+               ], [
+                       struct drm_vblank_crtc *vblank = NULL;
+                       sizeof(vblank->time[DRM_VBLANKTIME_RBSIZE - 1]);
+               ], [
+                       AC_DEFINE(HAVE_DRM_VBLANK_CRTC_HAS_ARRAY_TIME_FIELD, 1,
+                       [drm_vblank->time is array])
+               ])
+        ])
+])
+
diff --git a/drivers/gpu/drm/amd/dkms/m4/kernel.m4 b/drivers/gpu/drm/amd/dkms/m4/kernel.m4
index cf4f9e7011d7..7b77926c172c 100644
--- a/drivers/gpu/drm/amd/dkms/m4/kernel.m4
+++ b/drivers/gpu/drm/amd/dkms/m4/kernel.m4
@@ -249,6 +249,8 @@ AC_DEFUN([AC_CONFIG_KERNEL], [
 	AC_AMDGPU_DRM_EDID_GET_MONITOR_NAME
 	AC_AMDGPU_STRUCT_KOBJ_TYPE
 	AC_AMDGPU_CLOSE_FD
+	AC_AMDGPU_DRM_VBLANK_CRTC_STRUCT
+        AC_AMDGPU_DRM_VBLANK_CRTC_HAS_ARRAY_TIME_FIELD
 
 	AC_KERNEL_WAIT
 	AS_IF([test "$LINUX_OBJ" != "$LINUX"], [
-- 
2.25.1

