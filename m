Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C2ED0BB6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 08:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB0C10E8D0;
	Thu, 24 Oct 2024 08:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLsZ6thi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B1B10E8D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 08:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFT7dJyden7Cyj2HhtOXd9rYmp8kzyARWJb/ujfkSy72c9ybe5AX1lhZa+IHONMR4syRfgJWMPtCtkqrqIRu07X0+nSOSD8ayLctcZ2kggbv3LXYNLUCFBA9XqwdgcrYGChTlyxj8IOwUtKiX4zMP8ZbFmxyU2j7FE0QPEr/sRAT7LVdxoUmrmnzYtKFB7QgpF+lf11UMHHFHosAvBkpgKUUl2p7EKaTyfLWAGdMsXRoHR5w3RsM6eDLyOK48OT8smRmle7H9xtEArXZXtHz9N0Yg6us0/Jh7axTyvs1yiyj1wdAa2QFpdRBCIhnT6BHGIv2i64iEYsAMMa8NkbZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erPPRYNGWf0mIsx0h/53GXAxhMxOL/D1GNdjpO+xNvo=;
 b=l9v5Y1YNUAXtY4BeChgL0tDx6rbwBthwYBK70sAbLrKh0zu9TEGrQUaQM8v4WtLAxfjHWPkrD9+6WGGrMcpy6beo1J0FpNYbK6HehIIEpSzitiFZ232W8l0kC73g0sF/A33pFb0UolkR3DUFTkS8UYmdzrThFfOlliH2rV0ZszZWEdx9JMdYefXgm0PJBEUsz5rZ96YnGYBdYRs1Qnngiifl3QvyFj4UPjeUM3UPEvmjTniL3+ePDKBU2AONyOPD44IkrmEI1quLjZ2OeVaEZlR4wFcz5hBkzeY6wB36MvJZpplq4JPmvrK6r5pr0PTnun6Jt8TI78moO+0Hmc58hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erPPRYNGWf0mIsx0h/53GXAxhMxOL/D1GNdjpO+xNvo=;
 b=jLsZ6thiSoaYJBzucCOfw5OduC6m90otvwarEkziElaUo47ZOEnuJ/XPCfFIzVUm/vR7ycwysnrmWQryQlA7dNNpPi7v7eEwIoyd9F4CHAk4NBvjfgtenOotOFk2gwtXiggw13TlHmEcP6CFXvbysNJl7aD2VcWqRBU/M7Azd8s=
Received: from SN1PR12CA0096.namprd12.prod.outlook.com (2603:10b6:802:21::31)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 08:22:16 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::f4) by SN1PR12CA0096.outlook.office365.com
 (2603:10b6:802:21::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 08:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 08:22:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 03:22:10 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: clean up the suspend_complete
Date: Thu, 24 Oct 2024 16:21:59 +0800
Message-ID: <20241024082159.45701-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024082159.45701-1-Prike.Liang@amd.com>
References: <20241024082159.45701-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1dd683-9da3-4966-4b18-08dcf404f788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fvR3nkM2p3dP6UQDHs6r2vSDN2Kltz1Q2t3yo7+GsVhJVkuWvpD8Lx2sMYe2?=
 =?us-ascii?Q?c4yR0YV28AWwiJQxYFctyFkigy5dbkotN3e7IX6oBVP65xjYtSQsRB5LxNI/?=
 =?us-ascii?Q?mO6VtMYOAQdhOwyeVkhiOzasyUbKo7yGzl+/GdW18sNwQf1rkBTG4trNy5uQ?=
 =?us-ascii?Q?0QmgZo571kd/NkuT5iQXE6rGjQCHIrphFIDqyzLe6qSF/Zje38E1ssfYA6aH?=
 =?us-ascii?Q?bZLfHoSWfCUv0zNRPqpgX5Fb3F3wl0puLC8Pf6b5vxaUdXhzlXrBq/qpHJBW?=
 =?us-ascii?Q?eQ2okS3bQnrMJus55T2VF68Xu0G7amfJmV2LaThQ/bugDfZt37YBx0wBmJ7Z?=
 =?us-ascii?Q?d4L5kAdw/tGnXL9NuDKfU9KzL52yLY9dJQfHpm8tjzzKEdOw314YCeJNIIXr?=
 =?us-ascii?Q?6mPpMR5GBoiuSyGr1aIYEnlmr92AQxlNiWM2jxgmzMVipZ0fkz9s+Zbz3E3g?=
 =?us-ascii?Q?6W22sq4oV93Xwtr2XJmiNTXHWiIIUx6X4APwf0elEdkZMhUO7wawHBjF/dpb?=
 =?us-ascii?Q?OyfgF77+oGhWbLWUFtsSGq6myVwRIepT7bFaDoLCwX7lAbatg3stVWvE1jlY?=
 =?us-ascii?Q?JxC63Mj2Gv4Aw2xYzJm/tQAzqHH8bWPgKVI0/2tHDjJGlGRvzWQFSDfHisz9?=
 =?us-ascii?Q?8YJFtrahG8rjB7V0yOAyL5Zcy1DJTZTqkTrdOLrNd0tHBsgyJNlCpXDR/Gjj?=
 =?us-ascii?Q?/zxEfidw3qve3v4MgmqCALyBxghqsjlWoVQVvw+elWxZEhkv1VmeeNY24sqp?=
 =?us-ascii?Q?k2PMPvqw6tJcHkb0bCvHMvlOB3U2dItEhq6HgE6XkL850mIP916yonCgFBbH?=
 =?us-ascii?Q?bO9VPFSowxgIStR2J97DRCd9IWv77IZV6HjgsQdU7UoiKSHp+6Ob5PAzE1eM?=
 =?us-ascii?Q?UItYIUovkVVIjSjuPjNOMk/gbf8sEvkS1X+Hb1KpPPiIDjKYvlVo0L5yRNzH?=
 =?us-ascii?Q?EnBZsDYq6AV6oikfveLcTGj/vHKrabJloSuoNdOiMhme/uWEWgSHe4XvbodO?=
 =?us-ascii?Q?o65akq1sUx0lhGbXwDi9PQlIIspd7r3sttCzb97/norKHkNZGXNjnQSY2XcZ?=
 =?us-ascii?Q?pH+LnpiX386w+g8XOsv/QIe1ZAMyQHY5WD13luM1gydd4YtzpuHvN0h52LHd?=
 =?us-ascii?Q?jPYgNh/tdpiXxcZWV4nPSmdRNIdAP7zGvZena0PGHrU0Cz5KiyPRrGJjP84T?=
 =?us-ascii?Q?kokY1cEdz2dHqwyIsfGKohpthflVxrcBgUGnUgurmRP9u0AGiYH3EfrZOil8?=
 =?us-ascii?Q?2jrnGzkSeVBv4EcN3x/5LKhoyae3NtNXHvcZ3/qcW7uAn3v0TfpX9m2SvVYU?=
 =?us-ascii?Q?7nlff2EemCZVtSKu3LeAQEghxZxd2s0wzYtMP3EmpGSo+gzinkVSgeRHCbRE?=
 =?us-ascii?Q?DeDyfPnm4AmZFTR+naLVgJBgdlxsq9kf0QP21fAS0Yy48EQoOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:22:14.8937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1dd683-9da3-4966-4b18-08dcf404f788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

To check the status of S3 suspend completion,
use the PM core pm_suspend_global_flags bit(1)
to detect S3 abort events. Therefore, clean up
the AMDGPU driver's private flag suspend_complete.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 16 ++++++----------
 5 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..9b35763ae0a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1111,8 +1111,6 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
-	/* indicate amdgpu suspension status */
-	bool				suspend_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 680e44fdee6e..78972151b970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2516,7 +2515,6 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b4c4b9916289..6ffcee3008ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	 * confirmed that the APU gfx10/gfx11 needn't such update.
 	 */
 	if (adev->flags & AMD_IS_APU &&
-			adev->in_s3 && !adev->suspend_complete) {
-		DRM_INFO(" Will skip the CSB packet resubmit\n");
+			adev->in_s3 && !pm_resume_via_firmware()) {
+		DRM_INFO("Will skip the CSB packet resubmit\n");
 		return 0;
 	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 12ff6cf568dc..d9d11131a744 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 	 *    performing pm core test.
 	 */
 	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!pm_resume_via_firmware()) {
-		adev->suspend_complete = false;
+			!pm_resume_via_firmware())
 		return true;
-	} else {
-		adev->suspend_complete = true;
+	else
 		return false;
-	}
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c4b950e75133..8d5844d7a10f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -897,22 +897,18 @@ static int soc21_common_suspend(struct amdgpu_ip_block *ip_block)
 
 static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
 {
-	u32 sol_reg1, sol_reg2;
+	u32 sol_reg;
 
 	/* Will reset for the following suspend abort cases.
 	 * 1) Only reset dGPU side.
 	 * 2) S3 suspend got aborted and TOS is active.
 	 */
-	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
-	    !adev->suspend_complete) {
-		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
-		msleep(100);
-		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
-
-		return (sol_reg1 != sol_reg2);
-	}
 
-	return false;
+	sol_reg = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+	if (!(adev->flags & AMD_IS_APU) && sol_reg)
+		return true;
+	else
+		return false;
 }
 
 static int soc21_common_resume(struct amdgpu_ip_block *ip_block)
-- 
2.34.1

