Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF8CE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 20:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E144C10E924;
	Wed,  8 Jan 2025 20:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GkxfLK1+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF96010E924
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 20:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9MmodecA7ROtrXeKl3BXHzU+G9WsTTJVr2uf4EnTOa1fvbLveHQYyvp07eTGyEDjQDI/HeeJcq70huPfdIRqXosJduuZCkImquoc62nzcdOyS0iFspUNbnom0ddg2QfH2YEbB07jqy5B9lgzF0fW4DB3BlbUcnqKXJtILfq0dUjryzbk0owPoO40MVik7vD4y/XzQgZm6TKZBIHTwtFVXLzuD1c61gqldReuYRacQFsytIu6xFvD9jL5+Cwh6GnnwApegxZDCGYtoczwRfiF8YN6z29Lmumtr61SuN7EMJV1pPcUjEB7uX35JIOrUWCzAcmdqO+Ja1FKPFiM6Dp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrUvCHIW/c9wQxtSrkkwH18Ig1lX8ftG82O3PBcxj6E=;
 b=V/ykjTCt481UmhFy5c7assnX4Ejx4Tl4ibz5M7G0DZaNKhAEXOLldzLF2NGYFcLKoy8E6Zy8Gz2pe6xJPixa2pEITjSvy/049Kp+E6WteFJQHpzbppaKpGotk3k4LPvuGXDD/NOGbGnCGzbzAkFcvD6M8Va/VKxYSdV5t1lzzBSSRWk9tfhRZ7Mijrn2RMSReT6XTZLKmUKWDa9P59Jhy+Omp+U22QBLbCRJCz2Ly0Xtw1jT4DgFxAWQfMAQN/q6wdhmCTMm3Y5OSGvJ51RYUj9qyDBF13L19UE4B3EnT+x2SeyT2XCAcR/ht0ZSQDogMGZl988HjZMIh/clmJdS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrUvCHIW/c9wQxtSrkkwH18Ig1lX8ftG82O3PBcxj6E=;
 b=GkxfLK1+sUBk1jNQGfUsYVH4maNp3zGbQPPEIbjIKFhkTzF1SHhHBYT1EOiboqqygkIoso/UV3hkAXkHIwH/espnqdhgfl7HED51x0uHx5FFlPgt5j++5inPpuxTJ/xwqIWD3GJO90ZTWMc5d5LWRV70tnA7VhN81qupRseJMV0=
Received: from YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::21)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 20:01:35 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:b01:86:cafe::ce) by YT3PR01CA0009.outlook.office365.com
 (2603:10b6:b01:86::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 20:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 20:01:34 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 14:01:33 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Date: Wed, 8 Jan 2025 15:01:21 -0500
Message-ID: <20250108200121.2808908-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e40e60-0f6b-4704-7b8e-08dd301f40ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IIjH18f/+Iu2k7qXW4333521Mz5vXLyjMTaBT0HBG9vvHHx/+KX4w2T67Esx?=
 =?us-ascii?Q?5vnZrFlmuYo9ZeGH5Es0BkUrjWVXG3PHk3KDzOzzZ04eiPKpMQRCtwcoE3Uc?=
 =?us-ascii?Q?wvhdG4o8pwPzt5/QOx6WRd1gH+dYp7XUxAehIVBIfXFFBabAxGPWhKWEbn3c?=
 =?us-ascii?Q?4JVr2bFckIYz1QvnlUWEmr3dp9F+GScrZ7EOpPKkttVemQ7AEqp1kJkotCdl?=
 =?us-ascii?Q?ozIEimy+sXGlItlBssFgfM+6JV/GDEUCPPe2amsoHws9+MHJEZh2dMJFUS3Z?=
 =?us-ascii?Q?yNbMHGOFNaANzz2wHx22jqG6e4CcdfVZOQw2YWssiteD9SxurslNy7gQiS9s?=
 =?us-ascii?Q?zklmDCwTSiU6q3s/4M/v6Q/RRa+tY0po5IXl7IRStImbAy6lb81xJD282fkm?=
 =?us-ascii?Q?53EmYs+j6m2FLqk87j2pM74g9MaQxDZgTjUl4dxYzgCzilZu0sbRPQ5rmtMw?=
 =?us-ascii?Q?+yetCSmgNHYHEURKU7y9OYvbqRLBXTMnGwOiLsEjCw0ffj6IkcGChv+yqjZ1?=
 =?us-ascii?Q?QjQSYbBppahgyUvqf/Er/287B8VC+ZZNNvTmgIYxd+0Xx1WgFNsQCRlfdArl?=
 =?us-ascii?Q?aULh37PkYJNetOInymlDawV7DwBs9yT/zRTm0Dsp2YzlpZVhbBRoNB5T4QL/?=
 =?us-ascii?Q?ZoZpBTYlyY6SkSxOP6Np+E60AhZoqN56UIVmEPVWrDJcsxoW7AArCGztXdq/?=
 =?us-ascii?Q?m7lWhgeE5oPwZOCo0ceRasrhJA7TDMQWD4tOS7fS7WgHW7u48HDpKrciVng1?=
 =?us-ascii?Q?EaUap2Q5/hFjA5XaAoJ1Uw+jPGN1P+MyJJYHxNOFZIexv2YQmmZFIjQvsVOn?=
 =?us-ascii?Q?6s3LbRoCLlhTReVzBFsUswK+rXGfzuNYtJhUwYjHjF3v9mETE0Xgcd8qfMIu?=
 =?us-ascii?Q?tA0+zIES44+HsTeBj2E/i5C3b+lxsi8a7895F5eaj8Kx9jRtT7JYGTtxaGJD?=
 =?us-ascii?Q?nSfA7Qqvb8X6LAhQdg1HuVWzk/MFDH8zItf/oRkFp3Au0Xd/wjU485n7J6Hw?=
 =?us-ascii?Q?qG3fQm//Lp1B6JbAAELVYWo49wFOw5rEa+dnMRySvyB3lfcTrnlsWpEN8A1j?=
 =?us-ascii?Q?bSmLhBgxmYeVHWRVmt/qZ5VmgNnGGGONqyMBFvWmwHd1lz/6+SDEivvIZRlA?=
 =?us-ascii?Q?VPQ+Xts4ga9BwuW1B6s/IC3V663MssR4geAXRDjyrzu4wQHlRDC8D0BE2zJa?=
 =?us-ascii?Q?gfa30M0Mc5RNtVc1A1Sv/3uzPXKdUi7Q/JZeMC9RMlUUESjmv5tnrIQg1AZy?=
 =?us-ascii?Q?+Jyf8A5AAw3dOep92ZAUmdx0lYFy6GxxYqVcqDVHqoPpc0k2HcrZtMhTorhR?=
 =?us-ascii?Q?dBMI5xnlW69TQLY4mquQlfI9dQFLfw2FyWQ/2a0HrdXHLyHREK6vGyMD0Ol6?=
 =?us-ascii?Q?ntbIANwSn9uCgsHbF6l+yCnbiSSrQiVssLhhuTbRH4uBHy3bm7/d1kks6l8d?=
 =?us-ascii?Q?WSEMgU47QC/baOJ9QIOPTmWpYBcP32zFCEoHyk87CnpBkcI+NJfCG89H3wke?=
 =?us-ascii?Q?aoxVIgc+TYkiwVE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:01:34.4047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e40e60-0f6b-4704-7b8e-08dd301f40ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697
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

Per queue reset should be bypassed when gpu recovery is disabled
with module parameter.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index cc66ebb7bae1..441568163e20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 	uint32_t low, high;
 	uint64_t queue_addr = 0;
 
+	if (!amdgpu_gpu_recovery)
+		return 0;
+
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
@@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 	uint32_t low, high, pipe_reset_data = 0;
 	uint64_t queue_addr = 0;
 
+	if (!amdgpu_gpu_recovery)
+		return 0;
+
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
-- 
2.34.1

