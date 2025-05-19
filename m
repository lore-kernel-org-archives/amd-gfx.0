Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE137C3ABDD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D8910E3BE;
	Mon, 19 May 2025 18:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fci2iFY+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944E310E39F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGtkOkST3OCrS0VL8aqHX1l9ouHX+yAEpMH5IkuxRxocRaEE3Y9ASMrKFTJwgOozl0nvR8ISFT5cWrS8+sN5Hi7JVDCSzospyNoUscdoMOXgvkOaFTAhPqJla9dmwWmqFKJE7bEQgE3nGk2VaFHMjSJSPijB1c7gF5Qf4gAkCckOV1pyLwbDp/iehWVvoOtp2+pscvA7yZ7kBXVXEIC+6JyDLTop55YTvuCnXVLzoScN7RkA/YNUKrdP3KwTP8Dv1BSSMOvuWSiJmRoDwMF8GRGjGKpmKDJDnH+2saEwOqYAAH8tenIcEDbRJJNQAZOYHOD2jToms2yEgCW6IukPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgCMljaTY7QXqp0u+QjcSlDpAH9+YBq3YFr1UQo14uA=;
 b=m/lwF87v+JgZzg+KQPXNR4JZ1MlgtTI+vx2waxXx01Vv19ykbjGJ2D0Iphx6FboSusUKMXRtZwB0HAinZ237VaN47ojVrLgdZ0Z8iCpeTKF2c0AI0vWeAu/mtlrAd/Lc7+Yzwo6qDdNqxVO4aI/RzP2zMTCSKSDJEK+BSsf9DnMIOHI7v5MrmDjnGEbCqayBCnxJd5N9P+Q44/vnK6lqv9xIOThx/tBNKxfYWvyiLD585CPLaHX2+cV13tNFsvGaNWvPPbYywXfJMj0AFb16HEMAPquJDCbwUH7vdmMo52byx3npuvZgxXKOgHqlkirXL3tZ9ODM3PjpDKe/DDcLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgCMljaTY7QXqp0u+QjcSlDpAH9+YBq3YFr1UQo14uA=;
 b=fci2iFY+EMAkgLFI7QyvRE3gVYrY0zSiEZZCEF2RoDW/vgeaUeSQOseHwb5K0daHdvtkS2s4eY4QNu4BgzQM0Tq4ZqmPlSAhpbF2bBtpGnyj0MFVEFp+a+iTbf93Gbfz4uw4wsrXKmxtM6NFaI/HjzMas5E9lt4hLnX+M4+dwfY=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:23 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::f9) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Mon,
 19 May 2025 18:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/8] Revert "drm/amd/amdgpu: add pipe1 hardware support"
Date: Mon, 19 May 2025 14:22:02 -0400
Message-ID: <20250519182209.18273-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4974ee83-95e0-4577-606d-08dd970219ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gcUhbNQgZA3pqL6GQ7ebmk3MdbPD4BALbq4v2FmzrizhC5PBvkNfeKX4pSFW?=
 =?us-ascii?Q?5aBcrAr0RMmirlFOu90ZFRdEP3T72W91alGRt0hLG9zsjaqQ6Opgb9DE4lY/?=
 =?us-ascii?Q?/8mjseEHt7oPgTw+c2dqdrtA9xZPHgU2ukNAfj5X23uKr7lgW0wx+IGaDdm5?=
 =?us-ascii?Q?3rfweXVDmhGY5DSZpp6uVy10UzyAP30YGGm5yzgmQJGFIuiQBOCrd28s4/w+?=
 =?us-ascii?Q?pM794V/7eylscFOpiQtfKEMP+iv3x5locv+3zj5QGPaO1ikh7pO7Gq5YXHkW?=
 =?us-ascii?Q?70tUcYcnGPipPQao5szoSi/XaIZWUs7D5hslwuwvW6AhQ/k+K7x+9guscC72?=
 =?us-ascii?Q?NJrev5ZYsqGvjN5tbrSrzcQfnWKA0lmaj+qwTtUIoZU85hTJdwA3ZZT7OVKs?=
 =?us-ascii?Q?9ct0X5sES1b4+u1eG7idFKqobpk/rtHibULoiM7NCnbM80JVTBXfRS+9yOv6?=
 =?us-ascii?Q?5Qtqh/L7V7RWc5o3uVRi5yP576OCAh9/M7k9n7xEBBd+sn0HeJYwpMh5ftes?=
 =?us-ascii?Q?NMzgcdN4+4ABzZSvROTBfu24uk9dTFb0ViVUHzhEU4Cgl9GqgO4FwlFmWzJG?=
 =?us-ascii?Q?+8StWAqojMcLL8ttgrm4zAkOuEWf374Z5hS7nNa0Ktx40Fn6VanI3AQM8o0x?=
 =?us-ascii?Q?wNcPJjlCeE8veJ/zZOTgMFpY9M2EJrSNfIErE37V51r9Xh+DpBCQjC5N0ude?=
 =?us-ascii?Q?lh5nDJ/9KC2qGv/If/4CGyA/WfvxsmWHlqUfZyY91es78laqfWbprqXxLThx?=
 =?us-ascii?Q?Ax0Uf6BJsYNJ12GSHm0041wVJ/P2SozPBkUYPZd0LHNgZrr9YzvyPPe4psli?=
 =?us-ascii?Q?WfWH4s6M6VAZ4znSHPsj9EXXajOAnaix9tzqxWLvd37VpzRA+6z8VRDQCgCE?=
 =?us-ascii?Q?BKI3VyqQxeXNk6bFz+bArdb1twuQZn7wElrGKlblwg+vvFAdJupaMWpx8TV9?=
 =?us-ascii?Q?8kRAApLJYqz862l8g62kL34XXRD1dkE4t2S1/zzEJZYsPdpP1zRf1+c3yYQq?=
 =?us-ascii?Q?OQHQH7mUJM8Z2cYE08/logVqc+7AMyZObdeM+ngMRhyogOdO7Kbq6qd8PJgW?=
 =?us-ascii?Q?xLGKBPR6sstVZXrp9muwXaO7kKAPPZ+cO6vgBiXbpULWgfm3ac6HZLetd3yK?=
 =?us-ascii?Q?yBNiHHjFMt1znqL+3xNzbwLTZ27OFCCcZpgxf53dZVCp7fBVtZu1r46Xl42C?=
 =?us-ascii?Q?eP/HZ3RERSOFFDekJFqisPBET+lNJZFmJzpMphs/6HemRosWGHRjSryZnX9v?=
 =?us-ascii?Q?xSDjcVavAr0bqPHo6Uf03B5K2p1WuZhORVKKf4oa4oOSDgYSR6L351+UPOVT?=
 =?us-ascii?Q?r6yJxAEsEfNuhrjarH0vYV3sLRZ5X1gMxHk6u7fyNd28niFmDukD1gNwuhjV?=
 =?us-ascii?Q?mjYaZhzWjrLVX2IRxJJLUaCr4sgFtwFzzo3VDFFuSYodjR3AQ1hFTEbV7hN1?=
 =?us-ascii?Q?onos1xPdvUpaFiTFmcQmCTUOm3wyZrEHfmDltiNPY48+nwmhJ2cqzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:23.1560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4974ee83-95e0-4577-606d-08dd970219ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
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

This reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.

A user reported stuttering under heavy gfx load with this commit.
I suspect it's due to the fact that the gfx contexts are shared
between the pipes so if there is alot of load on one pipe, we could
end up stalling waiting for a context.

On top of that, disabling the second pipe may fix the reliability
of vmid resets.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..14cbd1f08eb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4781,7 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.49.0

