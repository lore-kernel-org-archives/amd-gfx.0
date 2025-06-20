Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FFEC7115D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 15:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5E510E0F8;
	Fri, 20 Jun 2025 15:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MehiA7Aq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB8610E054
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 15:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlbbCMgxTtIMR4TEZo9ABmtNruZKFsd+wEL1Zs82m+wcVjSFBz0Pscq1e3oXBUYFvndVw+/Z/aPWqIGyYKsYWGpeLpwN9vb1T93YBzUkZ1x9X7cWZqWe6DUI3nqmH29GhDrIo5ZvDZYayjOVDEUxYBGy3XZTfsT7jg4AapjBH4a6GTgT22T4ZLl4+AxpC+fjYO1hkYohKbfyeZi0WIXLfZFA951za+0u3qO2f++wwKOcLps+fvo+uq0O5FQzfdn2+VXxDEMNkspVTTXlHDkYA4eq0QWSu5GlIKYLAcuByYo2HApZ1WZdfQtlTQj7OQLzwCCvOfnxng9qKYGwzl8Fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkufq3GuUGUEsRehasG7mImmdYYkWFzCv0kgGzwUccQ=;
 b=XnMPJuOH1E7sKotk/qd5eWAqjkkj2O9DJkzNs2k9KHo+KaPBC3Zo8nLVDXq8jdiC90nMezPOQlBP+ryieGbEPJI4uglFSwfzNLvHJIC6RCxWUlDTj8K0Nrh4DWIqIO+qX99+bhHIpigDCcBN9lFs9n242JMkeGah29JJGgEIZRB/oPtFkdsctg5oNWkfGUiqdxHT5BQdocdSnRmg4Q4b22jgjtadF+2WNCgAGHi3v2HdGD3xaVm9JOTC3QYg+bzLlNbDjV2NF+w8GWiZhk3Ny0l3Sa702azPKX5EUtl+2c8XEoOeCnH1Mx08biDUEOXvaSaPOvAKm2USxOj71rW7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkufq3GuUGUEsRehasG7mImmdYYkWFzCv0kgGzwUccQ=;
 b=MehiA7AqZX9b2jBU5zrlDqOn2mkEATgAqbwYBkaIyxu2KUV4+vlQMLQ+pe6sijfeymNKMef6rpTWt/JZCLuQQf3dZcnFuzXQmhMjDWKHFE62kSscAId91Y7IaGxrh3CsJLuCFQZOiPicf/BiRHdNnf3txdRG1YPzfATHmChmaFw=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 15:41:21 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e5) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.26 via Frontend Transport; Fri,
 20 Jun 2025 15:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 15:41:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 10:41:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/sdma6: add ucode version checks for userq
 support
Date: Fri, 20 Jun 2025 11:41:01 -0400
Message-ID: <20250620154102.49652-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 164b5aa0-e6ac-4f67-5955-08ddb010e7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WtkUPwQT7SVMYOBJzBq1xqD4RQqwmZY9yepwUd6f5ZnRGniI+POrUh8/Jtgg?=
 =?us-ascii?Q?LQFKzGVZtGStVfMbQmDMPAt8qXTvgs9BFCnAX4wfSb7JDF4s/vMzcukPggpb?=
 =?us-ascii?Q?Qm6g380/zyuDZaWXh7R17A4fGAm/dRGLeWIFHlULamiFmkVPoQeCJNelBTQQ?=
 =?us-ascii?Q?wkTzyEEbP5D64+xzStFcGX3xSbFmeiYA1R/hHu43QWrMJSejHVYidBekTYoc?=
 =?us-ascii?Q?VoapRW/0zy/MHTfCa7utlV5P1IdkoqoxHTRJG3iM8f/2MW4faFQ1y/Jvtduu?=
 =?us-ascii?Q?Dp6YYGqnOn4W5PF1Jq50GHPnDtIH4mUJK8+vmJCWc/2AMYeL0GfuCFJ52v74?=
 =?us-ascii?Q?tXisMbby3uyZ1DOk7nDXFnd2qGzbOF1muw1BwGNa9qIEUrpgYOXHZTrbU5jQ?=
 =?us-ascii?Q?FyndGDUiUblSVwDSeDGwc+SGbSFL64yJNhPNswiAzwnExS7MbMGOWhB5IVIB?=
 =?us-ascii?Q?RWBC7m9MmBJXgVun7dioyFf1YtPIYsEFViRe/Uon2UAO3M4P5KB04lrmDyk/?=
 =?us-ascii?Q?7cULwkkuRnQU09eLroqE2H1vTQx0HdHO9p1y5bb1FJBBpw3WjGpgQXVMOAAT?=
 =?us-ascii?Q?1wfmb6N0vp7y/8GbBc4cfYb6HEpbrCrI/YELVDEFzZgzaDQ+HVwF9V+sEfh1?=
 =?us-ascii?Q?BJyhhSg7nVbZfqntFUSN6cFfYtjOhnuLvUQzM4Ri8jDqltPPWYOq/tFj+svz?=
 =?us-ascii?Q?qn1UVNoZuj0YVlYQ702jpKV1dvnzcpxYddgpTlnG6ZFqRTDMs6h3OTdeto0a?=
 =?us-ascii?Q?Z28X/qam39sQSOWiM2WGwbyCVKB5YkWDxNZcRl15UMncOqcTkWrxrVu10tpm?=
 =?us-ascii?Q?yeEc000m9Ldcz5sT2fAw6+36zt67o2+rleD6s8ekLB3hjtfhj/HSD9nCr2zk?=
 =?us-ascii?Q?Nnyf4pbB3KUiGzCKAms6cSvMxesDIzeyeRlq6o8lnB7rg4yNa0t5Rtjh8w00?=
 =?us-ascii?Q?FAanYwgRwe57TlTZUT7GDo1ckpW03EKzPLkb5+zaiw6SgRtJeajsiujaFAJh?=
 =?us-ascii?Q?kGtR+NxdHjS/al5X45JOrO6rRpD6SL/MWOEuz8o9ZXo10vabHAPFaVpW1/z6?=
 =?us-ascii?Q?R4ldWmgVLFuca3ZgzBfV5AF7+T+EXuhDReRAJ1LDFqEMgdh0YTpLAmLVUvgQ?=
 =?us-ascii?Q?vtjJyHxp1WB+45HPPIea8ajhAZhqIcEgr1ogmgwfA5r0ZWD2SntWMMQ/3mDf?=
 =?us-ascii?Q?NL22SS5AM3TU60nhBg81vFhoYsjwRM8ZaobUZlWte0r67EiGBYBnl4OjSKMB?=
 =?us-ascii?Q?IJcC4fXSoFpz/fhepw6sfD/yb5jXrr0k6pR2g0nH+qauKwH8GSBmY+gwNCQ7?=
 =?us-ascii?Q?F6dsQu43ej1NLhFNIe+7gGKDGSCh9jl4f0+kK+Q2a6dM1/FJXc7pPy3UnpDC?=
 =?us-ascii?Q?PcmwrqI7zWMQeCZn4TkPa70T16S+1FvoFIv5HIn9kbODrUQmdYsTIpnUA/EM?=
 =?us-ascii?Q?1Q5DKj4jvXZazaWxKiZhMdWbHD4D7CIc0nfmy14f7TJH0vBS4KCX+O5FyEmB?=
 =?us-ascii?Q?DEgnpPiIgJRmBEMGk+2PErDLMHQ4vFJ4C2xX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 15:41:20.7330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164b5aa0-e6ac-4f67-5955-08ddb010e7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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

SDMA 6.0.0 version 24
SDMA 6.0.2 version 21
SDMA 6.0.3 version 25

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5a70ae17be04e..a9bdf8d61d6ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1374,9 +1374,22 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	/* add firmware version checks here */
-	if (0 && !adev->sdma.disable_uq)
-		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+		if ((adev->sdma.instance[0].fw_version >= 24) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	case IP_VERSION(6, 0, 2):
+		if ((adev->sdma.instance[0].fw_version >= 21) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	case IP_VERSION(6, 0, 3):
+		if ((adev->sdma.instance[0].fw_version >= 25) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	default:
+		break;
+	}
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
-- 
2.49.0

