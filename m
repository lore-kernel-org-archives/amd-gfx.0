Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B8E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 17:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6FB10E3FB;
	Fri, 27 Dec 2024 17:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7RG7Qt5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40E810E3FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 17:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO5zlUb1keCfFZI7mrnpqBeCmjj8P8fW2BTZ+kDWNNCHTGxZmeqHuzVZJ+Eu6V6+27DOrLoltw/+2OsGDyYvHtRsN6UXlSI/IPdfui1+RpIgSsSnsbOdhEE2aN4hVEslQwnLXTnycWisMUBk4RiZFv+E9rX9vcqqcJGLMDvAsEK5ZBzZ/BCcj146pG4S4E4F4HsBU4g6qjfklcvn6YGmLUVByFTqUoeia26TCYwVj4ExHZj+AhMVO5Myeursc19zvQJNs8hyzNDp5bQwSguFrbQLXHMvLsP8gzUO463sRRhTcm+nhhAoWXoI47v+VC4R2MfPN+b8KNXxLWL4M2BtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3X0rJKwneGFbifqOcyQmxkEizvUrHpkYfe4Zgj9VyA=;
 b=ycsbge0hBhkr5Y1XfuRP1lZOt8F/sxeiV5rLn68rxy8Ete7X9D1vEZx5NJXYHEDabY+k3BT8qwNL/l8wxQfRobMdY39+SDbmMOB0erfasBjbDxPE30Prv1pMDPhcwD6BLwC1wuAx3Go/XCZQf+ZFPX/bnuKdq8NR4n8mCiVBB83Edu0k5YsEAd+Gch8/Y8vbT1U0ANQ72K5z8uwPEvzPeQmBcRSXxDP5HWN1Dzp56M5phRaHZ0ECANCZvkdpcCXZ8ZmfGz0/L6iz+Dem7jgPSD+ZRNeXqujCykxnQ+5MMnCeJj7lbXJCryV/WH0npD/Bedy/Il326o/EhXgqPpRbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3X0rJKwneGFbifqOcyQmxkEizvUrHpkYfe4Zgj9VyA=;
 b=C7RG7Qt5qPAAU0hTPWOojWPhkGWkLDsQ4Hyg9pW44P6fsZKl9sOvOj5vNiF0rNy/LhGcG90PQhmmIFycsdhZ/Ne++LV2aADUned+BnVPxcWrem9nT//rT58oYRiEDh++6ZiDevbqYkRiA/DP+VN2mEpFACAVXfvuclBLvAuda9I=
Received: from CH0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:610:e6::30)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 17:44:23 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::ac) by CH0PR03CA0295.outlook.office365.com
 (2603:10b6:610:e6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Fri,
 27 Dec 2024 17:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Fri, 27 Dec 2024 17:44:23 +0000
Received: from mkm-d10-yfeng11.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Dec
 2024 11:44:22 -0600
From: Yuan Feng <yfeng1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: yfeng1 <yfeng1@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Date: Fri, 27 Dec 2024 12:44:10 -0500
Message-ID: <20241227174410.5405-1-yfeng1@amd.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 2312e049-6551-438a-1075-08dd269e19a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iRo9vB9NOt17Jfdl8sH/0FKGZQUveXIuPh0kj4RC8tBfTmyRYZzZYsz54zbx?=
 =?us-ascii?Q?naqxLTJotLJE7C13DIdWc6kTIGTNYKAiDq+JcGv9kSGyAfbtXmK5tqiIvxsP?=
 =?us-ascii?Q?cu8t72+nv483PPLng/jE1A4FFnER5sYhgaW3+qtb75DOg1LU+bOGPmPqy0Sp?=
 =?us-ascii?Q?6/xNiSJbBaSyDc8Tud0g5da3x1svc1px8yE82jYVGffIjfJ+05ZwNk+oKipS?=
 =?us-ascii?Q?zp366n2d1V+m9BoN7WU61owAy3p0AFpj2HqpSOHoDg4JQwpo8YLBHrSYUlUq?=
 =?us-ascii?Q?RLQ0q0FjDlj9aymze50tbqKlT8XnPi6nvmVj0SoYCv9ltZ0DS+aSBtTVkFqq?=
 =?us-ascii?Q?m99QPU/WKXnsXI0huYZTCrpOwgiYcE8wFSa5HAv5lD0lh6ZXLx0Cv4DP7eQj?=
 =?us-ascii?Q?/7sb8LgAA2He6A2t1sW1DgpFxl/OVxhtwu3m97U+LobmlrfoZJ0VW0r+YZUn?=
 =?us-ascii?Q?VjsihpPwbg2Ju0mk4+TYvO029HPkJ/kQilG++al4v8nQrRijczV+qXzkV9Lv?=
 =?us-ascii?Q?c7KkGqSTMI8vbH+C4xPX0mJ8/3FdcwVkrJwSMZ/kkWFYESuSipOlgZWCQz+i?=
 =?us-ascii?Q?geQFr/vCLDOzEej7aEuoB+YfXiHL7YYwPWwWCCI0hnOoiaKpdXTK0I7t/utv?=
 =?us-ascii?Q?OaOA+81AlV/ZfG2bzcHHc4HmfVhkud3DJE8XfWJCgrcN9iQs7XQofPil4NwL?=
 =?us-ascii?Q?8+UcI7djO2lYFRCjn94N0xlX6MBbQvUXzkS3vsPGVm61zJbCXKU4phENXSko?=
 =?us-ascii?Q?NKtKht8Kx2rBd55EkVQyDEChyHmAyF+lei3xZp5bEJdOU4lfC4KZZ97FWGGP?=
 =?us-ascii?Q?nF9ROEL6S+mYc0JvqyOfQhJRaWk+0r43djkDo9grKcPuEs+jm42KAo8dQ5Eb?=
 =?us-ascii?Q?mfULJrPP/wjrSDb3E5WCJotyfQ6kt3P4gmbmDtd8uwEFTLVmm8J31yFR7R4j?=
 =?us-ascii?Q?ZRkM/IX4hxzJE2iRoSaKUVivMlFrZ0MjgpiaPzIZ4AhFy2YDL2Dci3PMxJIM?=
 =?us-ascii?Q?b86IZ+NHSA5s0WnxLuN7PeiylZdR2Vsl9P6tXbFcuMb26LlbhpLNdRjUIyDY?=
 =?us-ascii?Q?fxqzqsG8aF5Y7opOv5KhDMCUK2oilScKMqAsE99hFKx0dsMhjgbvVtD1WJVB?=
 =?us-ascii?Q?Ac5hOBtpqjsbj/n/TNyzKfb5Z9uKvStflbX5Sonkeoo5l5Rt3kvHk7mdzyG5?=
 =?us-ascii?Q?Qggzu/KWBMOSNoMkRvEOGpq1/IfqrzeIQnXxApXlu0j6vLnzFM+HQ5r4Xq4F?=
 =?us-ascii?Q?5jMp78asmFFHTWcEWcRrJD59/niCKNr8k9Hw/DiuJ4yjufe8PriR0qmQg7z0?=
 =?us-ascii?Q?1Ukkxgb3Xu3/ieCB8kpvIsqN5XbVltbV/1+zq2AS/++cJM+/UVZvkQ2NUS28?=
 =?us-ascii?Q?A/fBKinJqWdT8qwCHl5oYBpR1TbvGHKgp0eGGyuCxWGoCcOSuwXZEI7+gTU7?=
 =?us-ascii?Q?LF0YXKfUbHFbhyodpg7Odot2PY7b0x6EsYUTIY4MVXqhvkN6W4IjUbLK7roe?=
 =?us-ascii?Q?Btw9kTRewmAJS3A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 17:44:23.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2312e049-6551-438a-1075-08dd269e19a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
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

From: yfeng1 <yfeng1@amd.com>

Users might switch to ROCM build does not include MEC SJT FW and driver
needs to consider this case.w

Signed-off-by: yfeng1 <yfeng1@amd.com>
Change-Id: I6803818450bcfcc9d912c80ad351824be7a9694c
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a5bdcaf7a081..2ba185875baa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -579,11 +579,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 {
 	int err;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_sjt_mec.bin", chip_name);
-	else
+
+		if (err)
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+							AMDGPU_UCODE_REQUIRED,
+							"amdgpu/%s_mec.bin", chip_name);
+	} else
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_mec.bin", chip_name);
-- 
2.34.1

