Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59602CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 06:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3B310EA56;
	Fri, 22 Aug 2025 06:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qHVXJAH4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED17010EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 06:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sovHssjY52LlCXLWrfsTS5mKpf5ujz1Ut+06p7V/+W7ExwVnWm1y7KbTVxAathFgGKgskK1lQXwzl9FwF8lwaL2Y1WtlO7SyXtWGn0SVAm681wbEB/OnTW/3a2DNd//m3bnybCu5jKWNZBlDVX5whv2ElZJWHNf65ZW0J0uxhVX9kYAOStfPjfSlbOxjQAdWPN0yo0pldwAFiDzMx7PvYlCAM5abZaxcXMsY7bDuGe4MLP+6vJIHk6Z/lEwhgU+jvKEB1RvXFCWOXdMc23NL/SYTxmUFjJw1kInM17isPQqNSOTRdUkCCCooCC673+xOXXcfZVLJZB2KUREsRVMxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgeumJyjZu9fuJDOvFCDyEq/tNqqLTB2u0wm8/w4p84=;
 b=pqU1a3M1qBSQwkS0miBPhij4dUOoODPj0+2lFbF7PFUpVYehNmYB/ay7Qc5VUqx/fG6fq+0Hd5ImQxPPRZupgeW2y5nZfrnq6onHHIDdANBLzA7zi1er9HoC2luTMgr/8ePM+JeYmMpXNcDV2ERKFKi0+5dtti5TXVfhWQR+YOe27Dshdrjp0E7u0HIsqeZG8eaCda0ZJLkBA9LVG3qKLjXE1DuZUz0FafCtHP8QhelZuewx2eYnSbzme5enPZaP28ggDtg6DnL4suMUSfV61eDSUC+a3OtTwx209mBxX8kK11qx2sIi+eNVE8CsbvAuCExilZqEkdyiFhKe1NpzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgeumJyjZu9fuJDOvFCDyEq/tNqqLTB2u0wm8/w4p84=;
 b=qHVXJAH4gV11FV+rt6+tn2gAIJh8UCBoLoB6iD/BxVz+WEulnMkMIv84PvOZpkV8TlkLoVyRgzKyrNwD/v9blHL/BVSmuY7s+Sd4Y+EaLZgUmMSgxOEnsy0LxEqD7kCkF205BckY4RhJ6XepayKcM8q2bAHxF1xGzcI6l5vh0M0=
Received: from BYAPR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:40::23)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 06:19:35 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::96) by BYAPR04CA0010.outlook.office365.com
 (2603:10b6:a03:40::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 06:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 06:19:34 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 01:19:32 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Extend the bad page check to page range
Date: Fri, 22 Aug 2025 14:18:58 +0800
Message-ID: <20250822061858.6550-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: 4311a6fc-288d-479d-a9a7-08dde143dd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+S7EoGqOxNxBYsSBxHoU7/dEttLevItEUo6wKQi9phb/wcg2MrmC9UgGpU2f?=
 =?us-ascii?Q?x0oe5jNjYWGBKDSj9oa43QtYHSufTveRinFYwljrtMFe9ohNJsybsxLjJyyn?=
 =?us-ascii?Q?oGJWnslgp3fn/QwBKAPJFYCOUwxsgf4arzy10iRFTc+8qLZ4dNL/ISsFnWXT?=
 =?us-ascii?Q?qbONt3F0/w16bDMbX1WBRcUIdexzssFkEOBriJiFtwaqZA16u6tHWBMJ1GAV?=
 =?us-ascii?Q?i4IWFmbi8np8TpUfzomtw/BrldjBIO3VZjRrS3/TWehl1xVeDzW2oonmTj+x?=
 =?us-ascii?Q?EpRdSOkGtOFmhmPdhdrmGo/scqPLYZGTMqLfqOC/DkdVAgQ6C85gi3JTWBrE?=
 =?us-ascii?Q?0FAuD/xRt3QBDZlgPMCDRyfQ9O2Zd5W5xh3+cKb9LCRkpmX37mOclm/Us/Kw?=
 =?us-ascii?Q?4yfFzsjwqF0i4wdm1MlYojWl8fMfVkgWlWm+T82ufpnte6+wEKag+pvzYLJB?=
 =?us-ascii?Q?ADw700aT8jdxfJpUNFv20OrlNML9zc0WCYzdNiAvUySJcMyk1baUFBO27cvm?=
 =?us-ascii?Q?CKGa5WlW/nkom4LKFu4bBG4Y6a16xWBdzHz2hCaEYUScbuGOkSi1TBA/XLkB?=
 =?us-ascii?Q?ehx3EHDGqlej6iaS4e/0S5bUeYF2W7T3iq5Jufrx+rhQUkin0x6Lo+c/HWMd?=
 =?us-ascii?Q?NFTtmbN71fnQC8dhkXcflAIKLA2ARV0UZOlpyp/mo3f5KzD1IYz6SRgXvuKd?=
 =?us-ascii?Q?GyZLXAfR0Zn99WPZ6fpOonZGhGcSdKsQWul9W64Q4dBZbdOQKCy5O6o9VFVj?=
 =?us-ascii?Q?LNayCT8zCdfEtsu7OTvEVg7vB7MjzJBMXRSKExCLP7VO2p3Njty9+Benh4uH?=
 =?us-ascii?Q?9pLg+hVOXDDVUdPacW3hfdlibVmG8rDL/2wpr0ugxzOT2C7KyWQV6VJMwRPc?=
 =?us-ascii?Q?8qjZjlbHFNiPRIoy0VgCVgraM9ErdRXNykaoHzz7EMnQX8dqqY77ohRtmBX7?=
 =?us-ascii?Q?8uaHVUZz20KH46StVL1JQEMDK26UJpE6xRcU9bCQ6px84Usa5QwoAHXTmqPq?=
 =?us-ascii?Q?Qbb4oETwjD5CbX9QC8X17i79xZxsZRBm5NW0s1iPbU5DLvaa8qEPBgANMO/f?=
 =?us-ascii?Q?QfiyNnb08WT1q0x+UU+9H7w0VYkVjHzthJzdmGlmUecxsIAKIt/+2hREPC0T?=
 =?us-ascii?Q?W4SJIbCpAOTxZUDcuXa8Pv3ZR3O1/9ntlvzS6IoZ/MIYvUs3VtSRdnc4uLqP?=
 =?us-ascii?Q?MqH+s5EIQzlq9HfK1O4TT+4Em7l0ICI0frLALgCQstOTVQZWyWKGvt7Fe5wu?=
 =?us-ascii?Q?DOl2cga4n+G24ah4XUKUcJjWy9OzYoNwQ7OlN/UyT0nkY+PmjJhZ+f8gA+Yc?=
 =?us-ascii?Q?7V1iljCmZ67T2aH9T0SeyMjR8hfc9kErs7itnTZW1pXBm8ix6aGPaQ1AvtQK?=
 =?us-ascii?Q?+TG91dNVXwWvCMNinnCID8HZwLKwo7d+LF5n+CQimZLkQx4TJ8bq302ISDOl?=
 =?us-ascii?Q?BThrvO+8YbaQaCB2lbCTfcNaNQoSlCd0kC27nKD6LoRKOM2dzDPCH54Djz/+?=
 =?us-ascii?Q?mlR/FwNl+Hh1GmKKzBi7+AWhM6//ygGwbnO+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 06:19:34.6918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4311a6fc-288d-479d-a9a7-08dde143dd4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
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

The page range should be checked for the critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index c9df026e53f7..db7fd21b2c04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -406,15 +406,18 @@ int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,
 {
 	struct amdgpu_vram_mgr_resource *vres;
 	struct drm_buddy_block *block;
-	u64 start, size;
+	u64 start, size, addr_begin, addr_end;
 	int ret = -ENOENT;
 
+	addr_begin = address & PAGE_MASK;
+	addr_end = address | (PAGE_SIZE - 1);
+
 	mutex_lock(&mgr->lock);
 	list_for_each_entry(vres, &mgr->allocated_vres_list, vres_node) {
 		list_for_each_entry(block, &vres->blocks, link) {
 			start = amdgpu_vram_mgr_block_start(block);
 			size = amdgpu_vram_mgr_block_size(block);
-			if ((start <= address) && (address < (start + size))) {
+			if ((start <= addr_begin) && (addr_end < (start + size))) {
 				info->start = start;
 				info->size = size;
 				memcpy(&info->task, &vres->task, sizeof(vres->task));
-- 
2.34.1

