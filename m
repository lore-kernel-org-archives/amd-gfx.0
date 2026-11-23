Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA7606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uJZANekf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6184910E2E5;
	Mon, 23 Nov 2026 07:23:19 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D418D10E12C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 07:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6VDhBV60E8BsTI2Cm72HAd8/Q/iX63/W+6ZtR6I40btYrTxmVTTU1xXbb1nVbu3lUTAEk38Ty679EW2gNKIhRh48d2moZMiUq+j4iNgTxpsORzJsmIJDaNex9zBKHG6qvoOBiSiscrcEuhYttDiokgIiTJwzmyGQ6cqDEEl6KbrTG9USpG12kOWn5tiSifzC4+J+AMOOua5i9nSKaOfwbhwFgJPmYx+wvX2WJzd/R9JH3Vjg4bE3pUaSoq9p0QQXYTZJJO93+2Gl/Yuh2GJMoBcl9sNn05rHMGGi/CyHtxU7b3bxZZ5FeOR2o3KoTYVMx1dva+on72p+CgvQOkItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nu4zDLHU8cEvkH8zCp1q1rXDz8qlWC5P5yjLEQ88uQ=;
 b=e/4diF8x/XEAvIO1Kp34rGwqLsgL9VAaw0g4h4ZXczhLY9IzDZ/NjlsZ3FpasSHPqOr46a7o48qCRKvKRyXBsH3JJX/3JZztBOf9XZP1y0GTQbsU6admMBM9/siFYUGolLAvfLPzWte5/D1pAKuUqbyMybzVm3VDYst/cBXnjFER+9Ckp9M/VmOEU8Z5xeJGJVEGaxsdPytyozwnGGsWCOBEZ8CtoNTeGJaXS8CvhipnuPl0GkkGXsYcqdzWnydmeCGUEcLrpPwhEqVqGXp3q/a7Fwqo2T4UMQJgvtObn7O9EpTSoxXCX/DPwtQ67CU5VxjrvLZB/uqlYuma5jR9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nu4zDLHU8cEvkH8zCp1q1rXDz8qlWC5P5yjLEQ88uQ=;
 b=uJZANekfaBgBW7nukiYbLSwlzlbKf0RGIk2A5Tqc3Kc4ilVRs+cN4jC6zHaHlA7HoPA3wWlRl+Q9/kyM5/riK8HiOFQX3AnNB+yOaD204ZQ9xNowlY+E8pBx+KnkYaQHF06mKnlJDrJ3ltZWqR2vCRiDlXAm8oO//Ykx9xNHxuY=
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:23:08 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::73) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 07:23:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 07:23:08 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 01:23:05 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add ptl_format module parameter
Date: Mon, 23 Nov 2026 15:22:46 +0800
Message-ID: <20261123072247.3612981-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd11375-94b4-4271-fd34-08df49329f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Pr0eySzsFrv0Q5otKh6nS6QNQ2c34zZCpyoeRXOkxMV0ANqKFSP65rkU+ZM378aMlHofaiZjL/HIA73MdAkIRwlK87d27f7c5/NOjebhamli7vmEcSleeJ1YE6P3wQIdRVUS+wCufBBenDWeZjW0+k2nDllQCZ9fuPCmJJRXjcNqkU61PNpqvMJYEvpHpATSymcDrGI2xNTcY+dMa2vaZqxETa+L+hAUBYV6k+VNsiPbiVzMxeGnVRCnsdzuC37y3gaDIO6nO9PGfmwBvePjgj03q57hhoDZYc+25o0HHcCxCGbu4GA6zFFxttsGJmAWVDdi9lnGUsIlD7J87EQJaRFvMj1/AxUTRLPxcTDDTJqoUfuaQI6ycTL6ruGinJBp2lDI+L6AR/i8m+2ugEyn0MkIE6eCOeVqXa2i+ru19FHTXmSuyh5262lIvnNcBciI3r3+ccQw996OAHyXUOwuIGWJmJ6nM1nS5bU4HOdyoQ3MZT1Uhj+2G2rFIT1bnDi7COP4JP27rxdQCyB0bB4zhT/6uftf6A4FALIXYVX4X0JLiuRk20X4wTgxN6T3S+pW3pfCvCmjHkT8bMXjIStiR+KGcMYSElQsGXasOEgr43C3q+ePGbTI90VNnr96zkHPXMD7jOLjFOnMdGxMiDZy3NOG6cgdGIO16805D6k1F4T0LpfJXCszaTRfDLhJ5ogXsP0la47AS4U+henB84RZtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aMachL14ir+ySKaI4NGFoK1Z5n0gf3Xf0kiqv1nH8HmSc7Y8MSokGo7gHtJiUN0PoFVCSW2M88Hz9HxheNuErsipqtJe2hNMfF6V83RnUzanE6xQXSI9es+dKj85aEe+pemt1ltbweCT4nKaMFPjmRg7gnkCpmbLj9DzrX+j72RrQQkXNdw+Xg+0+vd2SBI/4pG4nzbNd5GhHfndYkK0QpSSHQ/RKgHkleNl7VzMyu5D+o8f3Ckf8QmIVUCl9rUchDIwej6d0AIKscaaK6EMKktGjRXDV3bfuVanjCdLCuDbSe7RdIPMRdgA4B6L0jRyEgPHyOAfUgL0Yr90sFVU5uAcwS0EZPUSk9AlHrVrRrim2vir0QwAm0tiUslCz/eZTR87cWJPiebFMJnOAfBC62cCqLsJ4INKUsA7P+4f7JoXRLPMzbFqDT+sqBLu1zHe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:23:08.3048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd11375-94b4-4271-fd34-08df49329f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PTL always starts with VECTOR,F8 at driver load. Users who need other
formats have to rewrite the ptl_format sysfs file after every boot,
and that file only accepts writes once PTL is enabled.

Add an amdgpu.ptl_format module parameter that takes "FMT1,FMT2", for
example ptl_format=F8,BF16. The formats are applied on the first PTL
initialization; resume and reset keep using the cached formats as
before. An invalid value is reported and the VECTOR,F8 defaults are
kept.

Move the format parsing out of ptl_format_store() into
amdgpu_ptl_parse_formats() so the sysfs file and the module parameter
share the same validation.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 10 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 34 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 14 +++++++++-
 drivers/gpu/drm/amd/include/amdgpu_ptl.h |  3 +++
 5 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a7a2b6b5a497..53eb4824f922 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern int amdgpu_ptl;
+extern char *amdgpu_ptl_format;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6478506d8089..5b366fc910ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -254,6 +254,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 int amdgpu_ptl = -1; /* auto */
+char *amdgpu_ptl_format;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1183,6 +1184,15 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms
 MODULE_PARM_DESC(ptl, "Enable PTL (-1 = auto, 0 = disable (default), 1 = enable, 2 = permanently disable)");
 module_param_named(ptl, amdgpu_ptl, int, 0444);
 
+/**
+ * DOC: ptl_format (charp)
+ * PTL preferred formats applied at driver load, as "FMT1,FMT2"
+ * (e.g. "F8,BF16"). Supported formats: I8, F16, BF16, F32, F64, F8,
+ * VECTOR. The two formats must differ. Default is VECTOR,F8.
+ */
+MODULE_PARM_DESC(ptl_format, "PTL formats at load, \"FMT1,FMT2\" (default VECTOR,F8)");
+module_param_named(ptl_format, amdgpu_ptl_format, charp, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c19600f8b7f8..09648b68d066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1880,6 +1880,26 @@ static enum amdgpu_ptl_fmt str_to_ptl_fmt(const char *str)
 	return AMDGPU_PTL_FMT_INVALID;
 }
 
+int amdgpu_ptl_parse_formats(const char *buf, enum amdgpu_ptl_fmt *fmt1,
+		enum amdgpu_ptl_fmt *fmt2)
+{
+	char fmt1_str[8], fmt2_str[8];
+	enum amdgpu_ptl_fmt f1, f2;
+
+	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2)
+		return -EINVAL;
+
+	f1 = str_to_ptl_fmt(fmt1_str);
+	f2 = str_to_ptl_fmt(fmt2_str);
+	if (f1 >= AMDGPU_PTL_FMT_INVALID || f2 >= AMDGPU_PTL_FMT_INVALID ||
+	    f1 == f2)
+		return -EINVAL;
+
+	*fmt1 = f1;
+	*fmt2 = f2;
+	return 0;
+}
+
 static ssize_t ptl_supported_formats_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1979,7 +1999,6 @@ static ssize_t ptl_format_store(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char fmt1_str[8], fmt2_str[8];
 	enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	uint32_t ptl_state, fmt1, fmt2;
@@ -1990,18 +2009,7 @@ static ssize_t ptl_format_store(struct device *dev,
 		return -EPERM;
 
 	mutex_lock(&ptl->mutex);
-	/* Parse input, expecting "FMT1,FMT2" */
-	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2) {
-		mutex_unlock(&ptl->mutex);
-		return -EINVAL;
-	}
-
-	fmt1_enum = str_to_ptl_fmt(fmt1_str);
-	fmt2_enum = str_to_ptl_fmt(fmt2_str);
-
-	if (fmt1_enum >= AMDGPU_PTL_FMT_INVALID ||
-			fmt2_enum >= AMDGPU_PTL_FMT_INVALID ||
-			fmt1_enum == fmt2_enum) {
+	if (amdgpu_ptl_parse_formats(buf, &fmt1_enum, &fmt2_enum)) {
 		mutex_unlock(&ptl->mutex);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b789f528f3b0..0cf13e78b821 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2454,14 +2454,26 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool ena
 		return -EOPNOTSUPP;
 
 	if (ptl->hw_supported_state == AMDGPU_PTL_HW_UNINIT) {
+		enum amdgpu_ptl_fmt f1, f2;
+
 		fmt1 = GFX_FTYPE_VECTOR;
 		fmt2 = GFX_FTYPE_F8;
+		if (amdgpu_ptl_format) {
+			if (!amdgpu_ptl_parse_formats(amdgpu_ptl_format, &f1, &f2)) {
+				fmt1 = f1;
+				fmt2 = f2;
+			} else {
+				dev_warn(adev->dev,
+					 "Invalid amdgpu.ptl_format=%s, using VECTOR,F8\n",
+					 amdgpu_ptl_format);
+			}
+		}
 	} else {
 		fmt1 = ptl->fmt1;
 		fmt2 = ptl->fmt2;
 	}
 
-	/* initialize PTL with default formats: GFX_FTYPE_VECTOR & GFX_FTYPE_F8 */
+	/* Defaults or amdgpu.ptl_format on first init, cached formats after */
 	r = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state,
 							&fmt1, &fmt2);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
index eead62b4b327..c445525833a2 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_ptl.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -64,6 +64,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 		enum amdgpu_ptl_fmt *fmt1,
 		enum amdgpu_ptl_fmt *fmt2);
 
+int amdgpu_ptl_parse_formats(const char *buf, enum amdgpu_ptl_fmt *fmt1,
+		enum amdgpu_ptl_fmt *fmt2);
+
 int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
 
-- 
2.34.1

