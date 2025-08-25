Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9055CA0EED
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 01:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B81410E22B;
	Mon, 25 Aug 2025 01:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+bDUnm9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1446710E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 01:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewOlDhB1qtSKTY466JTpE4V2lO9IPYZDo+fF/c7Dj2AAQnApvYPZdTcghp4Ze9GsTDxDOBkDX8xH+Ywca5RO3cTlbIl3LvZTQhIqXTJwS0+WQrouH2LqkpEj6OCeVhk+iyKIKzBXXlP6R66ZLAccVw1guVqIsaPjLy5SdXDcqckEzGhbc/0tJc9o1+cpgy7Nsd6Qf+WiGC51AcxgJXYBFauLLVK8GRfGCzJz+YCkuwDH5sIizSHMJfOoyHSUm0sh2chwhyhxVGppCurZsYjVLtTGBjCPQXTQ3DduZ1som+kP7F+884PIHXXdH3Fx3J+++Lf6V76k5t9dYXbbZVVngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CZDccd9XMRvCPwh27ty1IFf54LXfUdJBqjtG1eCYZI=;
 b=OqkYchYDJMCgV+o2iyC8MuprPHOal0l7gmKmluHu3LUlm0XM+738IRWwXcGzF1B7VEPfYWBKH8s8Tx9Vv9zL9eVRxeeucO6qqwOuFg1B3ccQKlbLgAsrlH84snygzLJQg0VHhfXIS7NFp2jYReLt6qOebJrFOklLoKQU/WmcKDqAbBEB8hAL9txVdJ+CTOnTKaXb2TP3hoR0C8sb9jRJ9flY1mc5uBVRRgmtFUTfi72KzhxTXlRStT+GP9b8S9UTyS7PbDnok2gcrpIdv2TDcecqvNvNNrWsTH4EuIHvdE8Mt7vGjuXoYQVO69EXqqFcyACnc7laltRdLhWdmNh83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CZDccd9XMRvCPwh27ty1IFf54LXfUdJBqjtG1eCYZI=;
 b=n+bDUnm9Jce7Kg0GNpEbq4xkLKJzZY2pSOik/shKeThqVx0hzj2AbfV2xzeIFQWWS55sFeNVQj1VQzP4jU+01q8PlbpPPjl1Yo1c2SBbQfLKIU4LHJJNUEbwZqOGQy2LVi8KMtCXZ7sknrBva9yWdcA87EJJJTbhtXTrOAPtyfc=
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 01:21:27 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::1c) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 01:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 01:21:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Aug
 2025 20:21:25 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 24 Aug 2025 20:21:24 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix shift-out-of-bounds in
 amdgpu_debugfs_jpeg_sched_mask_set
Date: Mon, 25 Aug 2025 09:21:16 +0800
Message-ID: <20250825012123.1383301-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d381a2-8162-4138-b0fe-08dde375b694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vfMaiH6D3Pj1tXrw4XH1Zyk7eIQuCo+i7hZwdjJ2MAE7qS0vT/1/HSSayDCH?=
 =?us-ascii?Q?3wiXm9msiegTY8AApKkNMrfFcgzsMHo0kytisiYVtHAzT4gLf6na1acWcUNS?=
 =?us-ascii?Q?W3KmGS503BxoIMU0/la0eSzWVrORPxzzs4v8p8GuqC4V+9DSWSjkf3bLPYxz?=
 =?us-ascii?Q?c49edAYlnW6q/2fLjE2uqIUdXYXT/LWT2a+pdhmBlyZaE1OO/XPman7M7KTE?=
 =?us-ascii?Q?HpeDWM097s1vjonb8MsnZgF2ihTX8ZMbGD8VNROQOCSgu9vG+KpbiMjr5j+P?=
 =?us-ascii?Q?x0hbTQFk4cJ4rMSSIYLziHAqNBRUJojxuXiIxVCYTfWCDFQY+KjKwAhHht9C?=
 =?us-ascii?Q?I2egIFYq959Nxbzm/WarsRlbsxny+GvIBjp29CMg7oXUXeHaH0ejKsiaw3be?=
 =?us-ascii?Q?Ce6C+TjHpKawZmfq2v7arJKDIXRYlC/A7UOSpn1Pf0YPkuUlr/Om6ikiQtfo?=
 =?us-ascii?Q?CejkXrjNFgmTfCY2sl6xyOsq3Btu2gqKTBk8HDn5iSrIV2eGZtsflrXNWwsI?=
 =?us-ascii?Q?aHfxqYUIHIfKWP9otxRdRSNSOiDnDt4TI52eCDxRwoNYfQf+IyqqgJTUy4y1?=
 =?us-ascii?Q?KQM9G8i750bhBlrjtW/xCU20yfGQzB2PM8f38H6x4M9+++5JFs0z27BzpRul?=
 =?us-ascii?Q?G4bPUuMBaYPS1ONSOUVHcWoMFRMSyuLi3kG081rjS9Z8zc7Dj/UiveXqqURM?=
 =?us-ascii?Q?xkkoPlrWgzlJS7ZjIZcxlFvhg5GsOxrx2Bf2WhGagG2AJaEt4rJNUPcaZyyJ?=
 =?us-ascii?Q?uM8tucGaFbnMD5YJuMIXUVxgpEYpvaCJxIhfPSeCR0NgA4A84YL5dkVpUHEX?=
 =?us-ascii?Q?ifNL/43sQ2EDqRnKy1g5NsGi4nDwLni1VXTUzGJrzXT1u+i2IKLxS1dVsZNJ?=
 =?us-ascii?Q?5SdISBHoBxCfUtX9fDo+O847aFaIux/HsC7CyUZPuKphZDyLH8y+Wq966ZgA?=
 =?us-ascii?Q?j8+RPaJY1QgfoUcEA7m88s5RqB9R5sidUMf6YtyvNSyK0vZzffK8+7NpIsdh?=
 =?us-ascii?Q?xQEQN6QaNmLa+176DVmTImywOpN80yfl3rZASdXFgzLhHJw+NaUF83tNhzw0?=
 =?us-ascii?Q?ny4wRSMiMxARG7BABuiUvk8c9zLE9aa+qsONEYK50tz9xAKRxMlt2c+g8D+M?=
 =?us-ascii?Q?clYSMgPltSznQ3Sx3jvS9LNSvDmg998XSQw3H7Gk8EfhlnHST8sWxfLrqUg0?=
 =?us-ascii?Q?nebVBOWVRgxynfg0aSFPDoqEXcLnC0DRG1pVbaWn3yCNNB7yNAvYbkQweeMf?=
 =?us-ascii?Q?EODJldTDUEtddrDqNfxNrPTFNlOooMnyPc/BE0iI1h6xvgzt6EzzMsjwtWrk?=
 =?us-ascii?Q?XeEIxvmqFZUiH5TxKcscSNSMAwzqTPCQuRsljqA2LFVLPEsbyeJA5XSGfQnC?=
 =?us-ascii?Q?bVGucITqmaPgDuj22zk+UCsraPzx5ZCLYxv5GZyjn0R3cWRtksP6+2haRPss?=
 =?us-ascii?Q?jutbY4/+zht2LdiMd/iP1tuqvovWCHaDsIBPgUx6Mio0ugKZiQW7uEikp2lt?=
 =?us-ascii?Q?uRaELrJbKGLxpvSrR4Oc9wqGrqYYNgrfflvr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 01:21:26.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d381a2-8162-4138-b0fe-08dde375b694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679
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

Fix a UBSAN shift-out-of-bounds warning in amdgpu_debugfs_jpeg_sched_mask_set
when the shift exponent reaches or exceeds 32 bits. The issue occurred because
a 32-bit integer '1' was being shifted by up to 32 bits, which is undefined
behavior.

Replace '1' with '1ULL' to ensure 64-bit arithmetic, matching the u64 type of
'val' and preventing the shift overflow. This is consistent with the existing
mask calculation that already uses 1ULL.

The error manifested as:
UBSAN: shift-out-of-bounds in drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c:373:17
shift exponent 32 is too large for 32-bit type 'int'
v2: remove debug log

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5d5e9ee83a5d..88090adcb24b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -370,7 +370,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-			if (val & (1 << ((i * adev->jpeg.num_jpeg_rings) + j)))
+			if (val & (1ULL << ((i * adev->jpeg.num_jpeg_rings) + j)))
 				ring->sched.ready = true;
 			else
 				ring->sched.ready = false;
-- 
2.49.0

