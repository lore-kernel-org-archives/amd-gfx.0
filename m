Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF35C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 13:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7427E10E135;
	Wed, 26 Mar 2025 13:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYLyibzM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0921D10E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 13:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qxo6lySCTChuBWIWjtn8ouGRocLGh5OUzj8w41G7XG1Y2f2FWBJvjMyG3krcPYSLeIHhoZCq3sjWIrIFmuKDvGdZUaC1sKBfAvtRPw7jRcszvWIhBFBwNEp3yprFkCT8NKe2EUdpr7hzs+jw/pilmj0vTKj5e7xdLssOzm1VZvcC6gLz2LYs3HsnPYkBWkSXeWk7aDWR8F+4YFsN6Fi6utuQMMokixFdahTmrO9VV/p5qjZ465Np/j2plCc8pC0jCO26UYs/HghmURBvZ3o7AQ6eEAA9H25au8H95fuDmUApd/yNDavLnCP7YhV/xXf1RHIQb6MjNvwzKD8blWlSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm2hrwo2HL0WvZdi7lo/j07C2e9fqk/LNALNn4muc/4=;
 b=Qy/OcZgDdlFIphXfA1icWGnIgdeviHIHGNXFneDu/MUArv++OQ6BX26yI3ZrY3vXgZi1JkMdJcrikFQH71LypwGBXwB8aRAiIX5o2AT1NmLyNbxGfk5vwldC9NkpTwVI6ZWfbYBrUROtZl2ql4Alx4HAZ0Tir7Cg3DR4yQa4xR95Y/8j/c10MWsZ9YZUp6bOl7vmRgA56VTMVsrMoutcXrwnTGupl+zt8d5XulgXPH2gV6iIUZU+O5JMOc5Fu/TOX+KcxtcvGoIFsPnIP/6GnDh1JX9aIQKdzJ2SxM0ePUCe8fViCLnv3SJNndBcu99EDNIFDpHp/Yh3I8HdYoUpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm2hrwo2HL0WvZdi7lo/j07C2e9fqk/LNALNn4muc/4=;
 b=PYLyibzMwQSQsq4Qt4t416VQ6hhF/7ckhK0xN44y8zDVgYkrcYICcahy192yhdsCsv5aJ2JP3sbDj4usUnQV2SAUqmIiR3fx8DdntWDrGGTVwv5OTMKlT+A6wky1uRlzTJTOiZaLaRNz6aTZi6PR1eS10UvhEDyhSzFMVsVoxUs=
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 13:43:15 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::7e) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 13:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 13:43:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 08:43:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Date: Wed, 26 Mar 2025 09:43:00 -0400
Message-ID: <20250326134301.1012270-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d549c7-0ac3-47ef-7885-08dd6c6c2817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6sQhfCNX/57qkrCgcepYl2gXg3YwCF9G/hNEbk8nyIzZAqEAlowE0Zmwa1k2?=
 =?us-ascii?Q?mqElMKqOUpmz7cszishmkY4jk4xxzWK6/Ogi6aIf5nQC2BWOf3ZktEZOVVHw?=
 =?us-ascii?Q?rUYIgZ5fyoPMB1bZo4x+l2CNar25HupTAJM1TOHx4ZcnGG+8GXCue8CMO/12?=
 =?us-ascii?Q?bAcw54/vgHW6cFc3aH0suBt4wPCoiKFlV5Zz1BhrH11b3y7IW2VW7JJsubfm?=
 =?us-ascii?Q?19F3FqSdsupIcHOAJ9u7t8xbj/xz0o4xIuIdfixEdNw1EUqjDkPMoQZSKcj3?=
 =?us-ascii?Q?4TxatIK11rEECBgiq/3mHJByrI6FWlPucire2B9lVnXa4NcnZL+vcryISA9K?=
 =?us-ascii?Q?21wNi21G3BwbQb3dHet1jIhCQw1349x8quxk0WRTby1DI0+JYaLT/nG2BPdv?=
 =?us-ascii?Q?Sz+L3bUwgkoFTbqz/zQiRvjh15rNL291B2PmB0nwfhPZa9Ac+GW/vzL0hDwI?=
 =?us-ascii?Q?bIhnoGAxPy+ryRWkIGjALomkU2p5BmcG4h1N+26QwzHlFaDckucWGWyTINyi?=
 =?us-ascii?Q?H34DXZrxCPwBc+UvwXJ/Y/TmZJeU+AcB/lMxqsdgTloE+KwEfsh5cVW4e26q?=
 =?us-ascii?Q?qH4sg3fZ++0IhJ5ECJiK4bpIKcw5kuwIdMrMFpe1GPaYtgJ/EmmgOz4cLubG?=
 =?us-ascii?Q?aFaJoJg077djc+zP6gz5QTKDPDYXjHJ43AzA52crlj3F03ssehRzHVZAnFys?=
 =?us-ascii?Q?sUi7DHTEzViBXvRkBUl6QqkCzuseLbRM1v0IIFsZWpynkbpSc6GLfSf2ofQc?=
 =?us-ascii?Q?O8iirb0YPZT2zVf3EWcyuHv9cwciq3QC0CS8upx+Gl+g0v8bgrb1mDZJU2Qj?=
 =?us-ascii?Q?wfa5dlrSQ7Lq5xzYtkicAfKy68gATz2uQcKQK/7HuUDt1u05HOVtFZeNFHk7?=
 =?us-ascii?Q?QRNw0NDts1OvJ2deiCFpfwkmeckStDIQj1A3R/DUaRgsWd3TUX/oA/Tyn8CG?=
 =?us-ascii?Q?6dvu3/KINq59/xhl2WaU+NSDf3mB9hg8wIWDOeIL/jKyYmnaUU4bmQlNSQ79?=
 =?us-ascii?Q?uYnBdia5HcZR2LY6ULLqyw4Clu4qHzbcLGcMxoOhTcMv7IIjJUcClmtzY1nT?=
 =?us-ascii?Q?75vQZEis7xxGljJX8MVhVQPK6tItef5IMpGyHBMUSQPdP7WUTVCjHEzuaUPD?=
 =?us-ascii?Q?ASpfuTbSI+glVXGuaPzszu5Nm6hmhIjOlP6rrgEMWXyKfYgN7U4FXIfqDhVb?=
 =?us-ascii?Q?rk25C+qOQPyKCc86vhpByGfMIWirZvn/fXuVGAcKYS0dCFeWFKw6ygkIH13U?=
 =?us-ascii?Q?fImX4oY0WOsb9dKSsVLGGul7vnFmLIj2uK9BUu5bU13VGMZVk0zhwlgMWDc0?=
 =?us-ascii?Q?MjpZOoJwuewfKH3D+9ea5cm+1ORmMmkKPLJfjLDyJhbaWWvB4TyBigQL9Yn3?=
 =?us-ascii?Q?ryGMRq1GW8sFayJWIRXoB83ULFHX1fYX79OYLZT4TfG5dXxuEdG7J3EWTnkM?=
 =?us-ascii?Q?TpRgMlIOUe5S6LX6NmrFT7soQodYm9rDFukY7tuGkZoPLsxcLeMTZPdSWvOn?=
 =?us-ascii?Q?44OE8MXZI0nsjoY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:43:14.0748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d549c7-0ac3-47ef-7885-08dd6c6c2817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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

GC11 only has 1 mec.

Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e0a9b10d645c6..a9ef33205c541 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1573,7 +1573,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-- 
2.49.0

