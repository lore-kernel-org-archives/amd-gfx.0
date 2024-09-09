Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF3BECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CE710E697;
	Mon,  9 Sep 2024 20:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYSXrqdH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADE010E697
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGC0VN0ERlRWlmeiCCfMtq/+9psh1QO60D55IMDku+02GpMCqUbz3a2wUx/a3aazIZYgW8VdpSacXRfznfMa+Pip/inn1Lpk7KvOxVtT7EMDpZ7IjWTePpxJSE3qXXENBsGUg1p3iSgb/1ePrIa6BN7pRH5gPRyMsjAwuZOY+XPwoPMxjKYaeNM0e00xRCS7lFtDihsVmYlMJMocGa0t5T2dhjW9tXfEGMV074H6C2Mbv2X/H/K75WG/5d06yRR8JYPfpfbARryiwhQu97jOz8OgPezsWRPFqxh4RGrxs7lbAXi5jglEIeZCZOVXrhtysNgQ3aBUtvOwkSsFeokSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BKTNVlvCwL6MbCWZrcib1oEjz+RLKPG3QhWo7x2hwQ=;
 b=OmmCPFvq90Jzh2sMQy2IRst3cpUjsaKT0o2FXmKYbeYCdvlCNS1efosKNr54QCo5NknKRfv4PUMI01eOXMz2DNTKjtepTblTE1JR95U/ne1BSAcJFoJ5ESZfjC1C/QAtyRDgx4887QfBQwvuXKZdYqwsHzqc2UD1o9eSju2CKWGFMfUbn+C73fCxRDhkw2iZjdWFzCH+rMvSLImCLl7m3tzZS93KaA7X/K9Hx6e4n/ev0TNyHKYJpqW0kojN9RARgW1J1YmjloGjbMDYkgRyNvRnpvedto4SNJ8ztZbIehJDF6UcJW+1aoDBsKpcwf0YYIAKUmC0FdTSdFHOCeg9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BKTNVlvCwL6MbCWZrcib1oEjz+RLKPG3QhWo7x2hwQ=;
 b=jYSXrqdH7ks5C7f1qyQ9R/+4JXuAeeSB/NYHstcyMh+zY6hCi1Nm3z2mUT/MNg6f/pg39b3Q0sBCC11cIHM9upABOJSGdbYpYFeVQNgdZkGxiFtYGf7QMx/laaRh4JCHwVVrhDn0/yNZe3IMPet8fioeJHtHtHWqXRfCHzj4VIk=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Mon, 9 Sep
 2024 20:07:30 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::98) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:27 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <Arvind.Yadav@amd.com>
Subject: [PATCH v11 28/28] Revert "drm/amdgpu: don't allow userspace to create
 a doorbell BO"
Date: Mon, 9 Sep 2024 22:06:14 +0200
Message-ID: <20240909200614.481-24-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: d31d1802-6106-4dee-5475-08dcd10b08a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqymiADdX0Pempi2zrZ8RrUFBVGIgahLdnuc2Q8mT78EnWokC0K58KePnK7Y?=
 =?us-ascii?Q?4LQhxVXwkhJrStbVOhYHJGay1U9CZy87TIHl3hyGIy59OkQwfyDwaF1hSWgU?=
 =?us-ascii?Q?Pmq8CdJdEIFeZIpAR49X3vQzLvD8yM3Ej2hkJlT1enE5PB58oeHLdtVPBCGB?=
 =?us-ascii?Q?tOonHHq149W4ZwhcEjv062pbkj59zpOO9Y32n0aDfZI17LWPExIiVg+HCEmd?=
 =?us-ascii?Q?hW7z6XEoaBPTEYz1+x06ptaQlV55Zj0K7Uc7Cr2ceLAmDDsoqMbAxbKEWfa4?=
 =?us-ascii?Q?mZElF56rtePoJhF+k4khu2C5uPURUGh+YC7FIdAtyrxKbZ/bUo/rlO+LuOHS?=
 =?us-ascii?Q?qn3AhEay2DXXc5gDj3l8/GmD2sLup/4/KKUra3RVtJjhRYKC30R14D8n5oog?=
 =?us-ascii?Q?FOnjN2AOO2JjuuDpdwLWqwdWNHfH92aPo/1RwL3nmTQCON7CxblLlrYSBOmm?=
 =?us-ascii?Q?48NSZJKu6nhk5VW+ihwO3/Ui61Tx2TkzJEZhD+dKcfomkYPtNRKgQfhm7Xqg?=
 =?us-ascii?Q?Y4Rqg/Q546vy9kdoTLAC6M08/LUXx/diNmgQLdBjh/nm7aeyIReO1yO0oeUC?=
 =?us-ascii?Q?sYB6CKYREZlX7wZJw5YsmKAQDjB2o13EqtdRXGUH4X0yKF5iwVPDlmNyAxGb?=
 =?us-ascii?Q?C+Mre4Xpl/98r5X/b6LrqoDedUKcqdghfmp8PodHUDvdQmmmZwYFsu30dG7f?=
 =?us-ascii?Q?iPkWXR1+HfwtOn1XXwp3qgRLpo+b32MOgq35jN/GKjb5vjDoPj32xsnexBjN?=
 =?us-ascii?Q?1nRir5ESXN6kbp8uFZceRy+1RR36LMdJbTZiuddM18BnmbEp83F58o82mQlp?=
 =?us-ascii?Q?B7x52GBPWE639pixwxULYE7kwPnieLDE7+zFjqIPkPYzLrj72TqjtdDTbMpz?=
 =?us-ascii?Q?iyFdYExYW3YgBrAZkoAKbF6g9jFsITgi/V9IWEya9nMubXOaH4mwNuqxvxTs?=
 =?us-ascii?Q?pu52Lo1TJBrScw+BlD9a8Yhi0aXNzsf34b7GGDJoZmy99nNIGKLCG29M3/+z?=
 =?us-ascii?Q?HBbVJdYvbiM8pT05UXhFvPlFQAMB5c1iAsWr7S8X7dR78ot3l2ocQQT9TsWf?=
 =?us-ascii?Q?LWeKm0HOWxYs5TsV/jFA9C/2JFZKEQ5sRsOIINfN0pL0JYwDxKQAeJkp/MRc?=
 =?us-ascii?Q?kABDBAOVHLt4Dd90kKZuKSrOK3iV6mdtLXznc7bTGf53Uc3CneXH+2c9D6Iq?=
 =?us-ascii?Q?PVuBDa/ENQylaEcdy5VF8aQmdImAiw1Bi7Uxv97YJnIKE6AGaxc39QKIUEQA?=
 =?us-ascii?Q?mdjlOpKkoavGOrNtG3bL+Lot5FtLR828mzz93Z4Rk/AHjZ407NaekGBQM2/N?=
 =?us-ascii?Q?YVynC2Ke/m6TG/C9r5Yp19tYA5bTCsDWIWEG7vOz/BobC9KbsN9UKc7ayFI/?=
 =?us-ascii?Q?ur7LMPUm2Q+JHFBePL80NiQ8l8yaeZ6uvsxMgtDSdI9yPKDRvNOYj25ASHZv?=
 =?us-ascii?Q?6CbRUM1E2gULc+QSQZjtmgfi1+6ZcmY9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:29.7906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31d1802-6106-4dee-5475-08dcd10b08a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
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

From: Arvind Yadav <Arvind.Yadav@amd.com>

This reverts commit 6be2ad4f0073c541146caa66c5ae936c955a8224.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7823faa3dbaa..2e3c974a3340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -365,10 +365,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle, initial_domain;
 	int r;
 
-	/* reject DOORBELLs until userspace code to use it is available */
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_DOORBELL)
-		return -EINVAL;
-
 	/* reject invalid gem flags */
 	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
 		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
-- 
2.45.1

