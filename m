Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F8C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E72F10E1D3;
	Tue, 29 Apr 2025 19:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IcPBPhda";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D551D10E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLSAmUbdQ8mqsHk/594PUEzAnPwG4G55cdEBe6HsvcyBnQ3njv78rM8nMIDfk8Spo4iBqTMYqPtWdB7qHiwlxE2mUt8x83Qp6x7qbgoP3YIHftMQlZV1+T2ywKcZRywTeF+uceA6MNnaPUeLRZKM+wpOOxsh2Ovu8YdQpHQmMPMhyBKmp0GN3LbYpr+8UKggzL0R2qQBVTvI/U6DcvuessOhAyHfko+ZZIGeqdyRzHOXTlv2jFUvp8Zrs/qjDiuASnPn5XMlZ83bkTuYRr4CggjWBlMFwVSiITs5PvTkjXtkM+T5NTunTAlhbpbVkD+v0kqOzTG37p4SbopjI6//uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+Zpd8mqW8eOixYywgueR4gaaB7Se7rmi8D2wzAUqTU=;
 b=q5LKk/IM02TiFrstj5cGjBZHPizt17W5z+VmwH4rnA5kOP8Y8PfiFC5k52Cmz4Py92VyKcwe6RzKSvI7z6EDcqA/x8oE9xeesrG5qvuD69TUlXuvexT7wOwlhtOJLH/OPau4OMUId3rWHZF8khMdEpBgrs3UB9bMXhsrvtO3c8QBEY5llF94B86u5gWXXQfYG4XI40WMvisvgc6eqRb7r6SKqVbvJXdNPzOEPaabRp2Oz+luP0c++Gr7Z2lYJcV+IpJ6xbMAFtmZzAD0DKNikGaSPg5jp5hB8yvSMhCXdroCs7Vm+3G6TW/E0yEdww3HWlV5AtjfYSvNIhI7TF9giQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+Zpd8mqW8eOixYywgueR4gaaB7Se7rmi8D2wzAUqTU=;
 b=IcPBPhdaDkWZezMZW6w4BHMdTI2kXyG7MsX4xAyYv9hss+OVVh1qgNsS7j0wwlQ8Afeb9KmOsT7gi9OKl3hIc4tHPKcpx5Rgk7VPjQQ7zTa41wVpX/iSub89YuRwDEysF4SjkayWYVFIAbedtxdvqBDj4/sjRWoX0xH7KPc2VTI=
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 19:05:57 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::34) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 19:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 19:05:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 14:05:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Michael Chen
 <Michael.Chen@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes12: use AMDGPU_MES_SCHED_PIPE for legacy
 map/unmap queues
Date: Tue, 29 Apr 2025 15:05:41 -0400
Message-ID: <20250429190542.1896100-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7782ce-e489-4121-b161-08dd8750df26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bemUfPgEpD1rk9znVhUFto0oCPTuPO3Ea/QspBC7ExXNDFhR7Y2TaZeS3E2X?=
 =?us-ascii?Q?2fJ+4FPnahFq3i9w0iHOqyE3mj0fRHCBnAcckpMTshY+1AJrXUvRAoYFRGas?=
 =?us-ascii?Q?+7x76WqBH+0oI6+2KnrkcBThPM4lLeep9wHYrVlX6kbH8eYUJajzO2qaqKEl?=
 =?us-ascii?Q?yruWNdxfWkJJ7nO+44cWm2zdxP1al5QzWokUGruEHN/On+pLpb3dJFwg7vxR?=
 =?us-ascii?Q?N2qeb5MiEo0dMNtf/gpatKWoO1imL20idtpgBh/sAL1nDBm4nefyVarLXhZi?=
 =?us-ascii?Q?pnPLuzsTkxE0HaR0+By7FWRTdLUM8APi4GCnCxa/RW0AfK1tp03B1yUHBLjz?=
 =?us-ascii?Q?2eD+ildwfzbnbvDYhzIu58OlgDmMddIbC/HcMrmKsC1GLx5TPc2DJiGbxl8K?=
 =?us-ascii?Q?KQRUe8CIIh7MNT02rJjJhPTBVqtmZbObTwEfzk3tanYupxWttNCrSm8Fy2+M?=
 =?us-ascii?Q?00TTebPQFz+v2ahKNz8MhMn5XlYFL4lgtnO4kmq4xtQSca59dOXQ7M0qQ/8B?=
 =?us-ascii?Q?4ry1WKaP2TYjYGfinLK+CWD/+rl1vbSFK/RTBt9yu3w2YtZObzY6NcxvVqBP?=
 =?us-ascii?Q?4Lx5b0AvUsBItM478U3dbaAUzfcPFbC84MRBZXYfRd7M+UvQOwmF1bWYEuwr?=
 =?us-ascii?Q?ZgQLYQ9WDsq8/tjcDlMLSPl3T47AnPK1KnG1aZboLTvhB7qLYLYB4LDH6iyJ?=
 =?us-ascii?Q?kWP1Fs7wAIi+2Xyg7R8CxZ8yr4GvorcPv81tyELBYpbsZZZdsaqtczqZIvxv?=
 =?us-ascii?Q?rfgLf6RBoTwJQnjIEdbq+xSPQ47jKkU/gmYXrf3oZUdopOcIQ+fvp3JfWTMK?=
 =?us-ascii?Q?WzS9Und9Va+S99QrUjmsAmR42EhKArFnkq7A0Ihc6NhMguxc7+r2w+sVkGKe?=
 =?us-ascii?Q?wxh9R7G2FPmp4j9XpKloNSW6z+g5epSgRHZsRSg+POcDqvzWBQlUx8vqDmHb?=
 =?us-ascii?Q?W5UfCEUOrzEkSxeE0cU01yssSnneP4JHIiMI5wagKYl6z/RTIob66HW9SmOR?=
 =?us-ascii?Q?QDy3+yj2NDuf4d674xHMa8m6ZC2r5BZqx7VGo+p9JxtOlsEqVquW6PvKV+H1?=
 =?us-ascii?Q?1DiOa2O3pEA2G2id2Tg8ir9GyhdlZkDtejPzgGANgJ56uIPSvGTDaOmcFPyZ?=
 =?us-ascii?Q?TJjoKX37PpcgcUSm60tDTQG/pzc3TS1Qso+mgGyhciGMd8kgnUGq9JcYHKkf?=
 =?us-ascii?Q?IYfZ9l/Z9LS6GKD748uSMP9+HQ2v3r0G7HMUWS+u5SVtcRZpQlSc7Hfpmr+M?=
 =?us-ascii?Q?6nBR+IEqewYwKm9+6dOe8+1taREMgBEZwvq2ToHB30t78Ir82YBSARpbAEH8?=
 =?us-ascii?Q?bnAyTbrlbrsYoexzaDptgMZ/lbqJ98xjuCZMUtnbhUNWZ96AIFzvlmBykUTP?=
 =?us-ascii?Q?Do0m1WDACqg0hLK5JGUl/7KaxBK3eI1EwoSiwHzlMqdtd4i6MXDxtxvecB7Y?=
 =?us-ascii?Q?4xEZ5LYIHOd77uo8hcPRw25/ZOBH6zTrto7/gOBNsYoAtVHwySiY7VeYiCjV?=
 =?us-ascii?Q?FTzc2/9qFQD0P+hz6M1qB3yTpG7bb9ZXEy/R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:05:56.6579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7782ce-e489-4121-b161-08dd8750df26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
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

We should use the MES_SCHED_PIPE for everything queue related.

Cc: Michael Chen <Michael.Chen@amd.com>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f9f2fbc0a7166..83136fcbd50ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -498,7 +498,6 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
-	int pipe;
 
 	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
 
@@ -515,12 +514,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
-
-	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
@@ -529,7 +523,6 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			struct mes_unmap_legacy_queue_input *input)
 {
 	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
-	int pipe;
 
 	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
 
@@ -554,12 +547,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
-
-	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
-- 
2.49.0

