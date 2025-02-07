Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAA5C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED1210EA24;
	Fri,  7 Feb 2025 06:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5F8sA0C";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BC710EA1D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+2VQ4rLmA4EXRI5G2NbtPoeCKg9s1eI3KRXIdss3iRht+PWOIeRXeqiCKpV4VZZa1gfvcuKSc52EQqeBuE+yj+UYZF7oyUIdeUmNRygxCpPUBBJdAurQOAtKW/5adm/T8vknejt7sWVFbq6CmKsa3UnXQcQb3MMysOd91zCIiDSaBjzmBTIR1D5t36EGrguK6aPPIux9osWjPzeSkEiWQfILPxINzTo/PUr611R3kBOXpd4kQstI9Nnyd3i6RRgxFpK8yR6ZLOKAd7cQ5o3O+aWqC0/x7MDBa5YVsCfzEX64JVmFWZ1CguIOOiHZzI6IR4eTF7XnH7Kmf2U6CDiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+GoKC4dH2+l5V5f+TclibFBV258cMDKFGkqu0AP+UE=;
 b=B/4xWJZoN36KDNt1uZJY4M+NGWVuqr2mgWRbclmGOg/2lwjE9+nqQfUpFu/9BSIvAWtIpNn3U8fcjdi+OEIHhFstIj3aeOJlIwe1E6+rkv+RKX3qP3XgkZt6ClYResrG23y+0tMMPeMOfUvBNEsyHf48jRgn1KO/sHYUmgbaRLJy7XRutLSSDliyuvXdH9NDtqgudduMYOLAU+PR1B5YcAkrkIzVR/43ioZW0AB0dBDS972+uBN2+9ITFN25AbPvf04Zt49d6selisOGua5t79oH4uvofKLkQoicclmx4mrD+h73PsgXK3oppClK13My+WwHUcJYJQGRzuodK4AfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+GoKC4dH2+l5V5f+TclibFBV258cMDKFGkqu0AP+UE=;
 b=K5F8sA0C1rP1AuHl6PZ119gRS4xtt1J6Zme8ze+I6wzPKr5sRTga/XLcYiH+0sFifpEX6DXL1tSkK0Tzygli3iJLnbDZYAaMjNq34kZk53iNfMs+A69Bq/gu5y6rq8FXMe2heVTYrlRWa8qjsCbknuqXSGeYrfV3oiqK7mJ1xJE=
Received: from PH8P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::14)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 06:03:35 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::a3) by PH8P222CA0024.outlook.office365.com
 (2603:10b6:510:2d7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Fri,
 7 Feb 2025 06:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:03:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 00:03:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 00:03:28 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 00:03:27 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Add amdgpu_sriov_multi_vf_mode function
Date: Fri, 7 Feb 2025 14:03:19 +0800
Message-ID: <20250207060320.1564404-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: d567e71c-9059-43ec-b5ff-08dd473d2831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSGTe507EBJR3E+rQFu0ZNb9d/L2AEvf2l1tRZ8MAGMvRHay9SAUeESFSpY9?=
 =?us-ascii?Q?UpQi7p/To+TuQojgyptWRX/yIaaeJWT2EyEjBMQejAZ5YlC+Ryw0Z3gZmEDX?=
 =?us-ascii?Q?SNKkENoKvPRxSCLmo11kaSoB9rjKrpMx/jSu307B3EmN/Bv0qdwTZl7oXOt/?=
 =?us-ascii?Q?dm5WWIk2ewZR2xmppKjvhdYQIePdltR2TkH8imOt2ba1bWfDafFB7aOeC9Q4?=
 =?us-ascii?Q?2Ft/XSvJCV2Nh8Cyco2wPk9Cx7Z+dAyPa1Odi3BYhmK3TKRJRflye0SuJXdr?=
 =?us-ascii?Q?BaDiSI/8cOqDWdsTvbMKHfGMH/p/e0jdShxEgBwlgCVqJpUOJnYO4LafPFep?=
 =?us-ascii?Q?gPziCt0mdbys3x/r86t1fGnJPkbyrSgWcCjkxNCGESYvwoxQo5DfwmJpPzQ1?=
 =?us-ascii?Q?aq8GLWDngnr/k1gr1sa9GA/CqBLjD9E0P6PMS9vDQ9DwkH6pzyJmzmHA2Ku1?=
 =?us-ascii?Q?IPWAI/hTxGRzD8hCbbvIMaWgE8fhDUaPkWdvXTe8qdF7+lmm08cNsuZscTky?=
 =?us-ascii?Q?TZp+PowcfRDY0fIxhX3uVcScHaYPSdoc4kM8Neh2A7Qrw2zCc+TbYtqFNA9W?=
 =?us-ascii?Q?BqZUeijF6pxhk+Sur1rcoWUts5yZEOa1z1gCMyFOzCf6IAuzbPN6g2QrwkFP?=
 =?us-ascii?Q?Qq8gXQYookriymreGBGrrr1VteDwNJol7et3dksFG9xwPxJDfmKmVvHuta3n?=
 =?us-ascii?Q?H/wCMhkyc0VgQm9KIOEQ5u7Od9EhmnilGV3K6+0L5qGuIliKX+4IHdXiWiiQ?=
 =?us-ascii?Q?KARDNJrryPw++qTU7eyZHmk8EgKXgtyTVHbGW4C0ok6Llb9tTqG4wzL+morz?=
 =?us-ascii?Q?WQYrJ9qUkhKo8QUyR7JZJT6E6xVTXKsPSrQ3aifiPaUhJt2OWHkCdo2a6QOj?=
 =?us-ascii?Q?GSU7IyPdGo/q0YA7cdnmxu4GeKcU4bxClx/pQNborTEUCyexLRR8y6MYN98U?=
 =?us-ascii?Q?56htNUrjqFfKw7lvxCLAGqFLQNEQw3tIUQVc5ecg+R/z433mr9XHBIR5Si8c?=
 =?us-ascii?Q?GzAYQ7yJOFzVZF20ofPes4IQIflSg3dJvDTW1TiKWvsqL7Td2QWIhk6IuAJ6?=
 =?us-ascii?Q?5QRPt3lASU2Lz65kPeDayU3ZzgNMqvmmUoFfGHUmZj5t+IuFrAETRxO52/z1?=
 =?us-ascii?Q?/2TnHamoX4WUJ/q5g7Pepq7uWLzwt8nhz7k0GZSr69fnPvslS0fKSnFJOG4Q?=
 =?us-ascii?Q?3jlNW+sHSHg9SErV+Vf3iC/WLANgkoSjjH2mQhnVUURP8Z47Akmbai5/uBa3?=
 =?us-ascii?Q?ko7drrJb8twyG8DYvW8cXfqg22kwBTWkh2odijKkEl6OMBKw5E5OAkMvz/wD?=
 =?us-ascii?Q?nnJrrHMyokeIV/Nc21s1tzbHmRwr/TZxuIgJg4MIkUEQ67RavA7AqfTE3s5v?=
 =?us-ascii?Q?7O/YsWc4KVmbHrfOLg7AwL8kFhouI8lRIbT4zo6BCyN6x4CVpom8CzGQGGxb?=
 =?us-ascii?Q?pWIOImpmuTy8PWnUaP33VAiIZ/Z+9ggST5WxBlEwQ1rNJ71MtYJeBvrJ3O7I?=
 =?us-ascii?Q?zNsx5dQV7KIAbhA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:03:34.7839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d567e71c-9059-43ec-b5ff-08dd473d2831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

Use amdgpu_sriov_multi_vf_mode to replace amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev).

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 8 ++++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49ca8c814455..a1450f13d963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1990,7 +1990,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	uint32_t max_freq, min_freq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 5381b8d596e6..b28082084b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -352,6 +352,8 @@ static inline bool is_virtual_machine(void)
 
 #define amdgpu_sriov_is_pp_one_vf(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
+#define amdgpu_sriov_multi_vf_mode(adev) \
+	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 #define amdgpu_sriov_is_debug(adev) \
 	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
 #define amdgpu_sriov_is_normal(adev) \
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e8ae7681bf0a..9d8119d91f1f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2009,7 +2009,7 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
 	if (gc_ver == IP_VERSION(9, 4, 3) ||
 	    gc_ver == IP_VERSION(9, 4, 4)) {
-		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		if (amdgpu_sriov_multi_vf_mode(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
 	}
@@ -2044,7 +2044,7 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
 	 * setting should not be allowed from VF if not in one VF mode.
 	 */
 	if (gc_ver >= IP_VERSION(10, 0, 0) ||
-	    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))) {
+	    (amdgpu_sriov_multi_vf_mode(adev))) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..b4bdad79221e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1825,7 +1825,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (amdgpu_sriov_multi_vf_mode(adev)) {
 		smu->pm_enabled = false;
 		return 0;
 	}
@@ -2048,7 +2048,7 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int i, ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
@@ -2116,7 +2116,7 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	int ret;
 	uint64_t count;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
@@ -2152,7 +2152,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

