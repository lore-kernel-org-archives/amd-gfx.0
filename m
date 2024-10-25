Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAFDD0C5F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 09:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D46D10EA51;
	Fri, 25 Oct 2024 09:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iW/q1f8w";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FD710EA51
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 09:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueKD2cJBKvVBZRqR+8wtkE0n/pkrp9H+S00YZN3pbeIoRh4tKlnumogRiHB+jq8jbc+KMyfpAjvei+Is4XdFI/XqEx7n4uj2QOtHl5ImJFCFdFiz/hPD8XlDYfGUU+L/RIhufLzEM1A9ujzSSjzQOuszM41Ig9m6jPhSkACvq9cFJprYt20O0oVpSPoA/+ZYr012mSsgKASTKrSxJNX0+UvzTC0g18+jzIRK8BODroP8MeU+29Umc6aJ7hJVVsV9jO3UfRYVyySJptoOxsdJoASCMkDjRPEWIUo0GjgssuU1e79VfHLcobPdHl5XrcKP5J9P3rNUwPS+0iTLU8Ocsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYjnrSLg93R3Y3BRgYKj5fjm0wGy+KNrlekGzKJ93ZE=;
 b=YJd8TZub2yPNMNWqJbzQ4qNbB5Twhhq4XQVW2ITMSAn/OHFQdqwMnTF63vEfJvAN8Gh+HAysgFzsGy+XUnkPcWXpf6pmhtJBdu6D6hYV6xH2zmt2OXQMZDyQqPyQ78abKAGctGUsxGiVOdZTlfzslCLi5BnXeki/4pxrykumkSyMdUUHwQ4AQ7dcMx7gpAFrZcojFThxN8JYwwpRrgzSC1lp+dLH+1TxYGgG5/t1Xqse2Z9pvpy2ItDFURc7hXHAbNrxzboCj7UINmmhPtsRDIM3PoUkZT9YQojqVhpnC89PHguT6FaAkhI5NOUDp1Y29fo+JAV3/3mND222vX28mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYjnrSLg93R3Y3BRgYKj5fjm0wGy+KNrlekGzKJ93ZE=;
 b=iW/q1f8wMUNKx3qhj6tmRkRoHfs1oCmRpzDAa/Nf+Ii1uY0d+oUis3O1owDXNtUyiwQsNoU2KJOgjYH9YgSQ5ENjerS+X5404AbtoQqVDR14mQH0l6oYcoxOr/4T7YSvjH0go5fjkTFswGBcWUxYtdHFekWxPZ7CK7IO6ajdOqQ=
Received: from MN0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:52c::34)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 09:45:32 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::dc) by MN0PR05CA0020.outlook.office365.com
 (2603:10b6:208:52c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.9 via Frontend
 Transport; Fri, 25 Oct 2024 09:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 09:45:32 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 04:45:30 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: clean up the suspend_complete
Date: Fri, 25 Oct 2024 17:45:19 +0800
Message-ID: <20241025094519.55723-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025094519.55723-1-Prike.Liang@amd.com>
References: <20241025094519.55723-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6920c860-82bf-4407-3c58-08dcf4d9c4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b6+9kIfMHbtOM1uyCrDMaigl+IQbL+fLjMruZQ/e1J3qpTazW1zTa5NyF5hr?=
 =?us-ascii?Q?3Qe3JTHxzfNsjX4MRa8LNZd1hhzsL4PlkXSPwvbU5EhVwAwA6YPGXJOVWmfs?=
 =?us-ascii?Q?RZVRl5z6vfN+KzkdBBscEP9EzWyanxtjp6yTBloymrjVc6aomrT+4PTj3YHl?=
 =?us-ascii?Q?r85OC+e3Y010d31SGd9EdAh2xmRGr9H+YRmdrJEXcqKMAT2fFlkQhRtG9mdr?=
 =?us-ascii?Q?ZOoYJuk4rYGx/Pxnddti8tIhrtMQoi9g4czKIhBaJCGFPwMSOhtKmxF1V0V5?=
 =?us-ascii?Q?NXcPXUeIZYJ/+Zgxt72pn2BAUDRzSg8yZuisD25q/upfcgdjrL5jLEsLxEnx?=
 =?us-ascii?Q?xOWOvOiyoaTNgaYfzRTpcDtj6hHHCUrRvFuUcHynSBcbr2tVZha5F/aeHtvc?=
 =?us-ascii?Q?stJ2qOWbWlOUZ97Ck9RqiBxUVvylvg2pHGi7yWSeU9rRAntW4Y04nnb4RDHs?=
 =?us-ascii?Q?OxLin72bTM6Mnvb74wZHe2+EpK30RLxZit3HVyatU0vI5GDvOBWF39BVabFN?=
 =?us-ascii?Q?XSSJXJ4P/wFM8GLmzIknklZ7oTPf4TRV/6LOevGUz9o1vMNKTY7Cx0Cw0WBp?=
 =?us-ascii?Q?+fOmjaoGHZnUJr0y/1Ke7IXO5xTAACqdtO3/i9cdDGsy3vjsSwbR6U7t+l7r?=
 =?us-ascii?Q?PR+w97WRD+7S7h5s8rxYZpMX5MHz4LhyjJJlisNoHYx3LndigrL0cIFh8fY3?=
 =?us-ascii?Q?PPybIZ/Sz/RqSue9U+1daL5z1Bd5rKQhrtgW6/AxD0YEqublJLL+2XEZ7mPT?=
 =?us-ascii?Q?+95PzSRsC+IEdbabH8gw4V+X+ASyuIBNZPBjReScgbX3PwZwe7fNBukjeHN+?=
 =?us-ascii?Q?JnveqoQ06Zi6mOAA+m6lqDAUE1qrTm9X46Ho31ymL6gCCspFc/i81ttCD4S+?=
 =?us-ascii?Q?atolFqh5awiWLJjd6UVwyWrkmiDshRBhfZCGRUdFbIwjsAsmhtvERRCGVI1r?=
 =?us-ascii?Q?FSQxnH3sP7JoOOr/3U6qNnwlQd+cRP6+XiedVwt+6Tsae6V7a6vZuV0oO+0O?=
 =?us-ascii?Q?SYhK71J8jXiELXxRQLArZ9j1e668PvVmSM3Co9g1+Uwwizwk2f062a/uFV42?=
 =?us-ascii?Q?r0b6SXnGkzwWzvnr9xQ60lCboUzs3j2a0ejBWfwM5/wkyHUm+hMOCUoKrjZ2?=
 =?us-ascii?Q?tuMNZOBigfQYMASjbYqrTZT8VE5CYoTvz/TJsjT3nix3DgtCN3WrTXNDaIkf?=
 =?us-ascii?Q?OW51LZhiMxJfBFrsQmwEFmuHWYAmN81ixymrsCCsYbXInsVoIt/A6GSDz0//?=
 =?us-ascii?Q?6qrYJvtmGRc41ozvAAQAEmV4Wf8SdxpNs11Fky61LZ5N2CB0wUlRW1Nin701?=
 =?us-ascii?Q?AxFAN21zEFeYjifKLDoKNl/P76TtepFJgM5J9k2I9/EY7tABXJhPM4L1E0bE?=
 =?us-ascii?Q?kQVcwtQlGMTjzotakmyiyo+BYyWRo14Ovbu6LPSJTeufn0nAkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:45:32.5287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6920c860-82bf-4407-3c58-08dcf4d9c4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 5 +++--
 5 files changed, 7 insertions(+), 13 deletions(-)

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
index c4b950e75133..6a54d9c14157 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -902,9 +902,10 @@ static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
 	/* Will reset for the following suspend abort cases.
 	 * 1) Only reset dGPU side.
 	 * 2) S3 suspend got aborted and TOS is active.
+	 *    As for dGPU suspend abort cases the SOL value
+	 *    will be kept as zero at this resume point.
 	 */
-	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
-	    !adev->suspend_complete) {
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
 		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
 		msleep(100);
 		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
-- 
2.34.1

