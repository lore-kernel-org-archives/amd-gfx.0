Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E05BC10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C6610E07C;
	Fri, 10 May 2024 02:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tAMfWyoz";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB1F10E06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNjRurZC3nUXFVrDefXCcvVyoSfwPfeTXYgCTnDbA38w2W5F9fRc5EE+J8qfIR2JeXvdneb/w6gEICij1PDjQUATGpkMn5sxArmjENUZ88i7gNnes2RcGou9OY2Qj08ahXgmbwoCQrU+A6JUTrGxKEMqnCAfzT83jJpuKz3jivpb2vu/HlSFxjhiRR+e6Ee2VGfGZcwtiDcAv6LY6tHc6F/vcosW/WWgooWhdO/ibfzeECmS7Oibrt68yNGWt5//7UpjSIf+HcxL2Wx/XLZ+M5efNQ8J+oDWh0WvQXg4uorWSmvdk2JsulhCJh83n/AtOExzW8aDb93NKMgs4xmnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEC+8Tov+sEOlU0gfA+o0je6xVyvDdHM2mvSCsCRbe8=;
 b=ZQIBKXDb9sGiHNTqVQzvgP5PHXUcd9S6GYcup4LBCCitRML8r5bnlyX8kjbs9hJiJShXm2rjoSoEtRVJnH3pq3rZwbE8h8UqgTSu5qfyIoETJBM35QEextmdLREboXJ1HvCgE1FXiohMib052L3dG4zxrNSll9vOZJ5cK6J8SWmv+nfBXSzu6Q7f37/CNZJNfJYysfi1cW3CmbPth+EJfvACQrqKHT9/dfsmIHRC+a9OjqjnquziMzdMttjUJGoArrulfnHi6dOkXVtlCLOJayHozn8gQIo0jj5bkCC2TLKZKgedgq1w+rHuGvWts7NKLrNcsEF9I4RwdG/9o2rXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEC+8Tov+sEOlU0gfA+o0je6xVyvDdHM2mvSCsCRbe8=;
 b=tAMfWyozymRJEXICsoZUQy3hpg6EME8xiPXIlegYG/xQeAnncSBXu/tRpBoPeFrMujK9jaYVLUSSaii1YbzvFYwmBM+g9/qbQRBbONaQzfiwq+Fq+VqAF3s7eKYvQy9fEfXnapXs/E2QWKeaG3DuFKjkIKyeydrtyL2z7TdWxmk=
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 02:52:11 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::21) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 02:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:52:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:51:12 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 04/22] drm/amd: fix the warning unchecking return vaule for
 sdma_v7
Date: Fri, 10 May 2024 10:50:20 +0800
Message-ID: <20240510025038.3488381-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d52f175-55ab-4409-3a42-08dc709c3094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xm0ZitUdwWLKKF/pDWltxZhbr2JAYbOR6yRq++7fG5DSnjzREcjAyMLo6eIh?=
 =?us-ascii?Q?RK0sruYZ0rXVtKgGIgBoKy1D1mz9kIOzOhpuw+sGXLaWWlICRvrmdh4K2MG0?=
 =?us-ascii?Q?apTc/XAcbnW19toRyni5VEk+qLSTQswAjWrZOqotXrc9skwb0BY8TrnzFgvE?=
 =?us-ascii?Q?Y+TrV4gMVA3VR4nQumzhh43e0yuoHR/ua5G9c9RTzYjdASSkcMcnoeKB5bt6?=
 =?us-ascii?Q?64Js653W62ocYvTx7UDvXAJCdSxC7MKt41Qd0w3GSxEFs++xcLAHLKSJVrpG?=
 =?us-ascii?Q?4PtrSM6Km+EXcjnwsxmIawfW9lrOUWakkt3NqHZIbMXbx6TXSXzsGBOW9wf7?=
 =?us-ascii?Q?aR+4iu3uWIvAn4HowNrFxsaRFtsa43P8QFrG4Wd8HgfohIeBVU5Ae1jVBUhB?=
 =?us-ascii?Q?XTMfqcu5VA8mB6PDJzjkq+kzqGSD7VdUnNqDlGdzSjVSLfQDpd6RDjzOiKGS?=
 =?us-ascii?Q?+JDALonxEtb/V+LSUDZciNcijHSe5sGOVTqiDG9f3+OE5oF/7emu9fkFxnFc?=
 =?us-ascii?Q?sGFcjkb8ipiA4BSkaiJ2ebGZWeQNeavOxERzxXKDSArvEvjdS0PAOTb7eUJl?=
 =?us-ascii?Q?f34Le8HBt7HyzslbwRtOHMBjpgW/bCuUlrBmHyHFSfDPkR7tIrd3Z0x0uB+G?=
 =?us-ascii?Q?dOYkvMbhgzuhjurz0YuROsJ732JUU0JqPWnBmc6FsHV7GEXhGhjIgVREsseg?=
 =?us-ascii?Q?pe85qHcPRl6MxELqGVxVTkZvvaO5hAdcANir0XCBm0Ym4pNVvaLofiDyZciH?=
 =?us-ascii?Q?yU20z0AhHcrxNx6e0NULMXUyK+kkmnoXGA3NqEFm1lND5gto6pve/9YASySS?=
 =?us-ascii?Q?fMLomK7/4zoX25JXQ+1ugaEJmM/oMI+KCqk/kp1TXTkouM1rts+zR9AVyuss?=
 =?us-ascii?Q?HAdKrIM3I0oW/CXIqOLdjyLYIRFdb4+mgiPE2xw1eHrLu193uAM4j/ziol5h?=
 =?us-ascii?Q?DCZcGVzDde/O+UoVkG2mCFBubSM0xoJGpgGZI3pISHfm+jMtmcJCAH+b5H5Y?=
 =?us-ascii?Q?g/aVFDQ8M7UCUo7xcDsWhIdvfy6qP9p9OfPfwMe1QDR6AKa5mc/de/M6xTAp?=
 =?us-ascii?Q?hs/umk/BabcfifVRBWdGNw+vi7LpOL01PBDGuTNbmxPqad9/aDvR7MjSwFYw?=
 =?us-ascii?Q?e7/QCZONMylTk2uT6azL0Pm4ItXBFJkHhqhO1plFBS/zozW3yTqpONxxX3fw?=
 =?us-ascii?Q?mTkwlV7tXh3a5ZkDlhm7YWxyvZ67mKa55ONq3EzExtnNIysa98OIAOzvIW+x?=
 =?us-ascii?Q?0goUiMR+Mhg9PXbDrOYvirzSzsY9VA1HQ/OFobynvplcrmpge2liMq8Lwq6Z?=
 =?us-ascii?Q?vac6R5WPUk2+iiXVZjfAQJ+icq6Jb8Kf+8784gNBn9CGWWmKKBQCH2bZgIWt?=
 =?us-ascii?Q?oZpgHqHPL3p1s7Wgt5WcTOTWEkn2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:11.0747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d52f175-55ab-4409-3a42-08dc709c3094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

check ring allocate success before emit preempt ib

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 0b5af1c50461..7db53a96cff0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1347,7 +1347,11 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	/* emit the trailing fence */
 	ring->trail_seq += 1;
-	amdgpu_ring_alloc(ring, 10);
+	r = amdgpu_ring_alloc(ring, 10);
+	if (r) {
+		DRM_ERROR("ring %d failed to be allocated \n", ring->idx);
+		return r;
+	}
 	sdma_v7_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				  ring->trail_seq, 0);
 	amdgpu_ring_commit(ring);
-- 
2.25.1

