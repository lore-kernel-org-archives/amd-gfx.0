Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A5C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE30F10E9BB;
	Fri, 31 May 2024 06:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDKIZ3dM";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBFC10FB99
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu3YaE4bEAU1n4WgAGCMbDyiDzVGcvVwStSeJ3R6RxAIg6bdfCIGC4fNAKGqL1SUivTJkcmxT0DXa2oujWppCDdsoNKiWFOWg/4ScGEzmKqBy5Yn8dvGAf4g6wGQpTHTS532ckvICdcRIQI1GMmwFpKX50RCKjFbk+Id8vnBWyKfip/Y7lD5Y8E3VJEulgQV9YZspm9C5ahB3jDVHjrcJZfBpCI0B54ER+lqVLJ/HMtT6CmHTLrCE/phNBmzxUlK7ZI0v0oJiDaSfpyrmBhK37dPbDKRUVyrDxHzqPQvZm6J6Kfm2qc4IdMN9V7LLQ0BPv5kU2v67cUaoF0fnnBQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv6EJLo0Gy5zBeBYPfp1tZBZVrR6tnHhMjo1GYKDL+8=;
 b=Wj2H9qKpIV6AwAFkDyziAGnsXd1+RK48XoXh+Ugjv+CA7Op3OirzaqQnAvFSHO2VwI1PUFlu7C3tkq350196G98KL5VC7UvSkA1KmlvAlPi2o3rT39wwQb9HZ2jh+tPVKZ5a3y2dGRLUwYp4tspT5purUhg2yJfexv89jECbbxKovJOoV1oh5cGmo7iR86giry2i1P2X/PEUH2HA2gW20wOe1Pk+Ov9Hg4yoFZe0E+tCo9jE7AnaNPyeuk6VI8wiU9bPaHzwusgkaSS859H3oUHYnCJlYsAY/yE8H8+a9zQyO8TnZva5eEPaeYeB7Pj+kf1tMhf4O4+eOdylP/tnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv6EJLo0Gy5zBeBYPfp1tZBZVrR6tnHhMjo1GYKDL+8=;
 b=qDKIZ3dM/JaVyYar5Heuds3VOq4wCVu1fy2HJchdQ/105cBdOf2SwNDmvdVxvjnrB6Hz4Er/SdNYAoWKPIpt09vKoJqNcmkRgpGBDGpg6ZsPzivLhFBN/7Tjrux5p9dqhfAJi0FQ512gtpCLRkAx6ey/Q2s61WvtaF/6AqRfs40=
Received: from BYAPR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:74::31)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:53:15 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::3e) by BYAPR05CA0054.outlook.office365.com
 (2603:10b6:a03:74::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.9 via Frontend
 Transport; Fri, 31 May 2024 06:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:15 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:13 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 10/18] drm/amdgpu: refine vcn firmware loading
Date: Fri, 31 May 2024 14:52:41 +0800
Message-ID: <20240531065249.1746350-10-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0e26f5-2843-43b8-ef59-08dc813e58a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GV/G4pRHdtcE2HgvZkUw9W4ULK5Dr3F1vkpvYp8iLmtDk9zELKtpj5pWbcKC?=
 =?us-ascii?Q?FE3C7qGxpfzQNJLoGGpsZR28fi7BG6LyY6EnaWiuxt32RdPKiYMvm1s8bSms?=
 =?us-ascii?Q?s73MQ6UlyEfZbYH8pCS3wyMpW227bj3HAzbz5TFnYPA+7CXK2cuYkRu+hEmf?=
 =?us-ascii?Q?EEhn5b3iD6IlTt0s//bhrjLQgDFm/O9mzx43537bSfPkX4fo2BIoO2uLC2B5?=
 =?us-ascii?Q?DVXW+dTDrsjtNYyHeOGYc4p7uV3UXdG8xOFRjDSFtPdBMvbmDCpPbPqYw3F/?=
 =?us-ascii?Q?VOsWQLr77xYPYfdcDc3yhODoTPrWIE6Et9oglADhx+YaSCseH46+/V4gGE3O?=
 =?us-ascii?Q?sBLA8MiKyB9iE0d/CfoYxxX8cwMlrT+HeS7yEM3lVmJIRe5XuDgUWqWZQKMd?=
 =?us-ascii?Q?VOav+TDhBGBjASglHr7FNkSdXsOAb+EfYnL00NK9V+JExovOXhCey3u7riQ9?=
 =?us-ascii?Q?b6+LkxE1Sf2Cjywi0X2bEsJIlUZgh9K6SohiSAFR/v8eaJmAEBK8pLAylsL5?=
 =?us-ascii?Q?ZkHNvTOM8DibVXkIldgSqw5rpbsnalojxraTO9Y4u4B3Xr9jNrIYemSutCAi?=
 =?us-ascii?Q?F5mmt0EAbhkQlAFTbaqZJKS8Lw2loEXIMvmYqnjbT8VmTnJgXyEBwWmxpGPW?=
 =?us-ascii?Q?2ZqXPT9/MNjV613D2jilVtM1Cw9a7Oy2MFFmpptdDgpAoXoKmApNuHdaw+Yl?=
 =?us-ascii?Q?KeyJyXuwIvx8/qmww2hef5WMmdm34kMpC/n8DOkwFXSVkhzSIVfDdiuLedTB?=
 =?us-ascii?Q?38nQkHgC66yUAgzV4RP8CKLeALwH2WMlsi9UIzEaSHfyPCc9S5fbAz2C4eGz?=
 =?us-ascii?Q?n4azajdRVc51HeIOOc9JUFLVsXqObn1DYB6JlIvYKBywAnz5EGIduQMAMuY9?=
 =?us-ascii?Q?foJWmn2mgZ4sa4j76A8ykUPU2Xod38ts1hRBe8CZDmSmopIu6c7s5gOWO0xe?=
 =?us-ascii?Q?P+EJO2u4LN+Ng1+hB4ObMo4dLXEcV+zqpjoJ1FcSaRb98lHnuicG3BZfV3pR?=
 =?us-ascii?Q?JHVgGUSdG1sS6UYznCh99anmjINEV7KV7iQTe6Y0Tl71wy8qKyyEOxb+AqZu?=
 =?us-ascii?Q?JaMhOSt6DF7vNYYJrAcKnf/TtZdVGZEq6roTf9fTiz9lZS+bJLQaURO7+Bur?=
 =?us-ascii?Q?OjI0gBmxq5LXeZF+8OvBfCqgabgvNO0WZWHWVZWWkG7Xz1RzI/suEoqV2JXQ?=
 =?us-ascii?Q?2JQu2ZBPpFBScyhjTws0q/SwRGLkH7vw45w7KyCbOhhK2oXHPD4lmgixRMXL?=
 =?us-ascii?Q?nHMRBGDRbASBjcPBHkSuK/hWxFmlDLKX32Mu+UZgzQ9W9lGCPhl57CPblsfT?=
 =?us-ascii?Q?TY4rHGOmFDaC5OX2lVO3upzPlttH71amdyNMBERSprp52GM7Sy9xbrUbKVH0?=
 =?us-ascii?Q?3ijodzo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:15.3546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0e26f5-2843-43b8-ef59-08dc813e58a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

refine vcn firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 5e2b7c340724..8d65b096db90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -94,18 +94,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[25];
-	char fw_name[40];
 	int r, i;
 
+	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6) &&
-			i == 1) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
-		}
-
-		r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], fw_name);
+		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s_%d.bin", ucode_prefix, i);
+		else
+			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s.bin", ucode_prefix);
 		if (r) {
 			amdgpu_ucode_release(&adev->vcn.fw[i]);
 			return r;
-- 
2.34.1

