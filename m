Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C6AD5AE6F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 07:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A234E10E1E5;
	Thu,  7 Nov 2024 07:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V6FAJahH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F06510E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 07:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwbU2UH8YUNyLJtKMbx1qX+EhMgcBHGb1ICiqerQShwjMWpmUTP8/46Mhn39AWY7ZaN6MNN2zNPtbX/fIYEq9dpOCJjeHHsAbVuOWVY6eMhTY/QiU0wtU3CeL8iaYtKPCPHPB+8u9XCytQ/Rx/U8yoYYXOxbLJT/hXMyutLefBrbx8toAYACWk/yJKJrAH7u3OMuMuOsRYtMR8Rfno1f28BGkVS90xxthCQsANSbV+rTTzY4oTQvb8bH+d4Ufxnf6V2DT0QUZDJ/DhfKs7kL7Xh3lWjRDae+Eaw5vm4/qiqR8sx7NxJosWUPax4GxpXd9zGogTxx/syYGNc0kExBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXDsQdwfLHqe8IWYUgWTp6VIJOPe8vZ1Hc+WOifYpcI=;
 b=bqj8+Ps3xCde+JsJbvkJ3/5Ld1G1WIwy3u3dCZYxItYhF3HOZK07+DjnBfGKB46X0geEQOQP+bH9W7LNrDw1nzrvlBiY8zEKUB3VlVoiMwUSTf7nC+V9OX5+/OOCEewCvBheRsdRHZazdc870qYO0OW9GnaNObfJZiymBWblGKI8fi1jZHH1deluYEwMOlHo6+evv4wXMAaLEt1VmHwa2+MYCrXMTkmukobTBc56jxas8kYZAxXZhJEVcmyf4sfKKKApGALYexmsCcZtiUOtFqXCWa6XGOfWjDjQEDFA3MAATBP3LyBY+QyMKZmehqjJXpDTF05lh/8o/y1uyfm5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXDsQdwfLHqe8IWYUgWTp6VIJOPe8vZ1Hc+WOifYpcI=;
 b=V6FAJahHlYkpNfx+jMZmFosCb9fRaKrXeoW4+C+5y6KiRAHmRqW1DYgG4cKq6crAjc0sfGxHdKMyxw+WzwgT/LKkMVb3FiTqZUZH5Cn6VT3DYA/Uo/YJ59PFiGRtjvNGq4NvbKLrQpchZZ5S4WW2Io1uWZKwq76Uaasnl9+vpr0=
Received: from LV3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::28)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 07:38:56 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::8a) by LV3P220CA0027.outlook.office365.com
 (2603:10b6:408:234::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 07:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 07:38:55 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 01:38:53 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: correct kiq unmap latency
Date: Thu, 7 Nov 2024 15:38:37 +0800
Message-ID: <20241107073837.3532220-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d28d29-90a4-4a25-1724-08dcfeff3c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ARf75uoTXK5I+bagBFD4o9g3ATVcQVd0sVMdPLrAetCru37HMsTEbnbM3DAQ?=
 =?us-ascii?Q?A5x6c8fIHIHy3gknqHG6P0N8s6ZSiQdaZuXL/qU9KvkxTDSQhWm0/78T+4dx?=
 =?us-ascii?Q?YLKFMkMWkw219rxH6MZdUtQ0pG3Zpz6YaPcYYJLYdxJ6PjcfCgHeGuWBsnj1?=
 =?us-ascii?Q?S+RLKLrtgO4ulkzDqu1curVt4tQpf55VRXdFwD0xgt1ypsIipzs1yGeOLseh?=
 =?us-ascii?Q?grXhPIYyVeLUzs0H6/sR97tAG1Mow0j5LJDDbwMuCSTDC9AyvPSrzpgQi2u9?=
 =?us-ascii?Q?kOwGulpVWdY83KvS+ehCv0p5hOU6bpbR5BFbrtA3+5uEfkNo4y/WxLmIw3VW?=
 =?us-ascii?Q?TArd2gzP/8zPeFH93JGKj8SnnawCrRofNhYxuL1+SH2262Q1pUUGY0p9L/eX?=
 =?us-ascii?Q?7amvd+HREa2caWPjLmykZ72UDBwkCGAdy7SWqP53OIkP31qBVU0tYY6XZelb?=
 =?us-ascii?Q?2iIzX0pMklCJlUFJVNzozKwRMs+xAP/POlv3vjDThqs5eDIWAYL8OC8DPKZU?=
 =?us-ascii?Q?f7tg00vsnIEY2HShjm9LPYLxilVF11iSRvISMzCGSfxc+dIJUKcJ6j53kqOD?=
 =?us-ascii?Q?E0ThWkonGgsq1LVDtkRlpoHo3T30ybEXHRR4VjuAK1d4WGBtxfyZacDrI9ko?=
 =?us-ascii?Q?bT/MPRsAFOzt2ta60x7WYASGlROCGWI6fxStYA1y5QXVFxF/+n1sFKXXNdrh?=
 =?us-ascii?Q?j15S30rFqRlBNUTXxTZYhrlP/EXTXKXMVgYMtAu+0hSbHrVdmyY94E4sMJWa?=
 =?us-ascii?Q?QaMF/uc59/i2F10rVciKPntjrkJDzzxS3+fgbh5HIn+mABs2mAKyHRdq4I+i?=
 =?us-ascii?Q?Np3LO7j/+mERVCthsMS5CvD2f7O76ThGt0o//UrgXqYhi7ttHvo1HEyznaEm?=
 =?us-ascii?Q?SVAOQvJOw6h2g4R4jY9YAnyQgvmlyy5z5DaiQ4YbSH9zYBK0u0RC3+DonSlB?=
 =?us-ascii?Q?4KidALVMvCaC0MqtmbWdzEwVHDIEH3aqJugCaP20bRV3j+2FiUXQbDZ0hzSi?=
 =?us-ascii?Q?a1Bg+xjJOVfy++l+Tg9s9MaIOCDCUUGYCetSvtu5nEABqQ4acW5Eu+7t3RNT?=
 =?us-ascii?Q?kcAXguqUvmjihezmYb0eHHkTPATUpZ2AASieOsW9dPf1J5OoC0gOPU9UtXYI?=
 =?us-ascii?Q?GyhYZAei6VF26mj1LNMoqWTtlvPr2XY+f5O4xta4ZFJZORlriQ+o8leTvUti?=
 =?us-ascii?Q?0m2OA9UwC84KQj5Tl9X3/I/Q7G3T+EAHtvroOdq4AnhOVYWRt9dT1B6HE8Tx?=
 =?us-ascii?Q?3+v/HstgniWB+MQBINP4Xre45eTSIQhyD9w/gDMjmbwjqtIKcXEDx9ms0iMS?=
 =?us-ascii?Q?lUnrfNeZWNBWjnYYrZECWknmYkTBLkekd2uAgePCp+RgNIsffPsd8NIpY399?=
 =?us-ascii?Q?t9AKhWUls07RpeeV2Dd+4myWKFzErqRFXUWZy3fFTNXoJyJ56g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 07:38:55.8296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d28d29-90a4-4a25-1724-08dcfeff3c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
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

Correct kiq unmap queue timeout value.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9d0e342a2f81..1ce935e684c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -550,7 +550,7 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_1_pkt.header.type = MES_API_TYPE_SCHEDULER;
 	mes_set_hw_res_1_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
-	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 100;
+	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 0xa;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
-- 
2.41.0

