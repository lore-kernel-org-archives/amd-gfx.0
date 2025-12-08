Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D358D3B7DD
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 07:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC34410E3A7;
	Mon,  8 Dec 2025 07:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJuBaiUR";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8C810E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 07:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZngo3ZiU/ngyIhAgFjE+F0ik03gHn4L0idR1q2KEyRT+Mh9M/lJfiT4lfH3hInuhG1I4AL82Ny8eg3Oe1JmfsgrDcffMxJjjwEm6Ku1w9YiPkVrnMecoVxoizQzWyvi/I0+P5PLqUAr4DspMKLfv2a3mWBElAeZ1k/sJ2xq4IGYkwK369WAqKTWz0IjP3YwetjarAxVOH0SLB7JYcRUyq6X4TdlrziKSAUugarH+C+4BPntvPzYphF/lFJpeLF/8JijIhSg+kle652eWCOn1Pp3Xdf9ilYNuhnzIr3LfH5u25+JrauvRHi1a+HGYeobhDbMfj11PIc71h6FDaGfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z6VHfeyhZ4kpUueooLsKhdRf8E65emTEaxKrTAsZ2U=;
 b=D89YtlEiqBQkT02XxVU28mShecc333/Y9N9O9HgFeKUiWSXBCDAp3u3Jgo5GzIRAYKfjgZbYkH/PLP8uPpx87eTP0lWu/OiweQtv7OrXeE+jdwgwbIDvhnswClcumlkw4djPnI5szRxa30EDmNJ063FiAHFiMGwK2KOYBGKue6fg7i6EN9dl0tqZRdrTrbhU/nPCelyIzlS3fr92+tDyYBshcNU/k8gTB45yRyRNe27IIZAVBjg8ZTPwMXAhuPliCHgHMEdmExtBrWe7AqxHB1FK7CGeCxIal9kWBBoQ3T/1XUxWLkNUlvGnVKQStWz9jq3R+7i0lP3esCGBsjwa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z6VHfeyhZ4kpUueooLsKhdRf8E65emTEaxKrTAsZ2U=;
 b=qJuBaiURr27LvXtovd45ceDB1aT4e4297KIEB0K4htnljm047Pg3nOjFFK6xZPqxm2f7X1nY8EOGqdrcNeKlRXdbJhm2w0pnffU0M/lRQk0vgbLm98dxsv/CWIpSLoks5Xsk2pwzn2oGGU/X2ZZ9s6DWEnObOXKRZy7EjWLWGNc=
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:33:59 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ba) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:33:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 01:33:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Use helper to get ip block
Date: Mon, 8 Dec 2025 13:03:35 +0530
Message-ID: <20251208073336.1381340-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251208073336.1381340-1-lijo.lazar@amd.com>
References: <20251208073336.1381340-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cd20a2-a478-483d-9396-08de362c2674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTuYdCdCDu1wIWccbYZx0EvrH453HUUh/dVC55BmeNPLmQ6lnumpgKetros8?=
 =?us-ascii?Q?TOicO8OE+D4xZ2YgxHj5kQFiWNxvZAENJwmyy5M145FdN3cyhD1vjlCn1bRc?=
 =?us-ascii?Q?+fsTqSrEVmsKERYYfVXfbpORVEzSu2x6xRiDOynzYe3tmxHj2tqB0GGDkpZZ?=
 =?us-ascii?Q?wkcfQ/JVWhMOgYNcQ7UGBOwLr4rAmu4agFXEPBPklxJpbRtgwIkx52IxZyEF?=
 =?us-ascii?Q?GSmVy1Alk5f11OkOGBnSg5VZXt/72owtkAkp3HKVUHXOn2o01G3zp86j68T9?=
 =?us-ascii?Q?Ttv3ngIaVaYoUamqxa/KCiJspyJ9ihlwM5UXbcg2hFpbaZCEbSRK3WbX43xD?=
 =?us-ascii?Q?IKUxdrWquNBjH9a22bMcIzSrOOCS8dvmdmTe7eSpNUujHHp00U4GrEx/u/tb?=
 =?us-ascii?Q?J2exebId5WIQgKb06x9PBWV8xTCYLeHGy3D3gez7DqHjeHivkIyiiDu6cwPz?=
 =?us-ascii?Q?l0JxHCUcrQWX0SISOGyIp/M3ZvwWrixI6RbOh3SV+sQieCuU7ZmWwGhDcKwa?=
 =?us-ascii?Q?LbH8ZJjgP8VHu6fJW93R0iLUEY6NFomo2NuTY8YUz1be49hw+dbc8PIm0N/V?=
 =?us-ascii?Q?qG9OMLXhUQZYVZYBgQOv4YgrrLuNkHWKEKZRNdHK+3Mi4eMIBrUMaVuuTtCi?=
 =?us-ascii?Q?yE3JKCBzopfhpbMpOacxrjhuz3uVB+c/GngqSEzhVAB/YR9p6I9Hle+ju3Wh?=
 =?us-ascii?Q?Vp9aGuRQ9GQaTAQfPvAoeMFq7ckDHbCmSNVexBGt9dPy7Tsf3DmWW39NWQCd?=
 =?us-ascii?Q?3ddJM1bzhHASgSOVNAskYYeWRIXk3JtcBpZ9REyc5lFCFMZJ4TucVySpJ6i4?=
 =?us-ascii?Q?TZS0jISjpFCXcsMTE3LTCabFInvvr9wX8WYDKEzG0dzOlOSpDHG7gNXqOtgs?=
 =?us-ascii?Q?shDGQnrEI2lGJCXY5ezcJTtlvI6rmbCGP1U6UevQPiqs8Oik2l7eZ320666K?=
 =?us-ascii?Q?CLvU/smeXfy0qJXDbztjQeycVmDsXsmIqZkEgj09+D1LndJo+RbN/UX0kG+R?=
 =?us-ascii?Q?40PoUeou5dzEWNgvQ29pRc8bDZ0y3S39PcNIeCkZ/Mab7QID57gjV+Rm0EpT?=
 =?us-ascii?Q?mFt99zCZ9cAJ7KewppYIPCj/EGVdfSGQ40+YzO19Lnn+hrvJd341G/XjTwcG?=
 =?us-ascii?Q?JSvaqZYlgPzJiyjWOWuLjstHD356lBwNGUFDHH1PaTJm43T2F/EySrgDYbGs?=
 =?us-ascii?Q?haNOPFfpIFq3Zayd4QKIcEo9WxetgCN8UrHlefF+9dhmyTW3iED0RPKS/Pkk?=
 =?us-ascii?Q?UHBMxNBzdfG6CBc+DLBogqlgu/ZquaKzc8bmSNqOBGTyxl0kTZeI9dgQ8uR3?=
 =?us-ascii?Q?HhmmGimS4VYiqpkvgy+uPxmaIXBHvhbRf/i5LOJQv7P0Mt9zX0yFwDUcpELj?=
 =?us-ascii?Q?afxE4C1ZknbmXx2OZTn9F8oarIum8RIzQQ2nFI+BAbdZEf9fBpjpGjL2TUgh?=
 =?us-ascii?Q?1Sd/V9yX5/zuCw8yk86d0NQvOHbNIb0zSsuSrLHUBavsPWfS0uBV4NBuZ8EP?=
 =?us-ascii?Q?BHnaoqh4SbjoshnMGUK0JvhkyyV3I+2IUxjEtJnUdwwd4IJNIZMY12+GD517?=
 =?us-ascii?Q?4ijGS57D74UX7aBKRNo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:33:58.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cd20a2-a478-483d-9396-08de362c2674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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

Replace individual searches with the utility function get_ip_block

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 43 +++++++++++---------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index b5e6d9d6937a..677f730e2654 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -358,22 +358,15 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type)
 {
-	int i, r;
+	struct amdgpu_ip_block *ip_block;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, block_type);
+	if (!ip_block || !ip_block->status.valid)
+		return 0;
+
+	if (ip_block->version->funcs->wait_for_idle)
+		return ip_block->version->funcs->wait_for_idle(ip_block);
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->type == block_type) {
-			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
-				r = adev->ip_blocks[i]
-					    .version->funcs->wait_for_idle(
-						    &adev->ip_blocks[i]);
-				if (r)
-					return r;
-			}
-			break;
-		}
-	}
 	return 0;
 }
 
@@ -389,12 +382,12 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
 			    enum amd_ip_block_type block_type)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, block_type);
+	if (ip_block)
+		return ip_block->status.hw;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].status.hw;
-	}
 	return false;
 }
 
@@ -410,11 +403,11 @@ bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, block_type);
+	if (ip_block)
+		return ip_block->status.valid;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].status.valid;
-	}
 	return false;
 }
-- 
2.49.0

