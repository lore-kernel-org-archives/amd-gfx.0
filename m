Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949EDCFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 15:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF6910E2EF;
	Mon, 24 Nov 2025 15:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrHQKW+u";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3989E10E2F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 15:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le1nkqJRJWnFCRmA8B2185yLcs0orBpjtN6SkzLOIUvUC1KWnv2+WaP5YbcaHqcfdPPcq9EuSbHhatCLF9qoR6/FY6tj+rfbcSP4oVGrNXa7FTGyWMLeJLWJ68YuBFInWcILCC6MFq3UhzZVKXzXftSoJ8lsfxWF/YxmIx4lHYSTeWvJ67haxAxRehqwCahHj7altalLgIqWFRSgG/w09K+9nDDB9VfoNS9A+dAKeCkSlOOdPiLit/Tdn+lbx8W6JkWHfr0lP39S2A90eHr5mqltsIbYasTUz8a0HlxvzJXHzoOj8NpXbZtbrSWKHJH32XirrZL4AEMiTcuHIX9qkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I3onjO7MiEE+nppn3jUtLyO/meK8iRsJC82Hhf0+8k=;
 b=bHTOLhMyTRYZhwXvTxqwD2AMRzx3rgSxV+JWBrQxyTAhREjAmsxv3yOdJxYWZcqPbYEQ+giqUVDHhuk0JxLVaEcO/rF41TPapb5hllJpkIpfNv/flyP89WK34BsiytWxyuXgQKHR+BYXsZfIMl9kITFI0Z9oGodUo0u4gT4WPD7FYF8pC51P7WML1uZKc7vAkPoh9qEiaTqwHPUQem49f61NVlIxKpZM5odKa94ZgT0YzG/oViX1KMPQFb2BD11E0N0HDWRgE1v9qsSfbbj1fKVXi5XCYbi0GkXlBXON15aYWIjjbAoQUiEU+Q6h7pgMUrltmFzL8eSp6hZNSeIb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I3onjO7MiEE+nppn3jUtLyO/meK8iRsJC82Hhf0+8k=;
 b=qrHQKW+uabfe5lHmW8tv02I+1mrvtFcd0btnne3Rpm2qDKyjf13HHe6W55bByme5z1Ocz79+9cMNNaNnRGQQ0efkK9+cr6irR5xXmimzhzCrTtUPyzaVihm2JWItcSg1xVAayCb4FpVFjmq/kL31I7SZylAojbDSOJiB8EM4+lE=
Received: from BN9PR03CA0928.namprd03.prod.outlook.com (2603:10b6:408:107::33)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:20:37 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::db) by BN9PR03CA0928.outlook.office365.com
 (2603:10b6:408:107::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 15:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 15:20:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:20:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Set GC family for GC 12.1
Date: Mon, 24 Nov 2025 10:20:18 -0500
Message-ID: <20251124152018.428613-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: da404cfb-6a14-4e56-6ffe-08de2b6d0516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8NzD0LtBct2r21i7gYtAIROrzYvNA7cEhoekib0Ur5u2No2/LAMocU5MQbE3?=
 =?us-ascii?Q?lKcu7CEE+2MIENS1zlIQ/gTjmg8kqYXxCa6vFc6NsybX5ky4Rnr6iLlrbiS9?=
 =?us-ascii?Q?Xt5rGXPibSgryY7FIBQEBg+F6nLVUx2Lslx4MSHQ0ScYt+4bxS5G7iXHgtDO?=
 =?us-ascii?Q?vh2iDABUGIapc6CfyRlr/3uWl6ncGZoP84PlD12h34ysD81nnhTxENQsQw5k?=
 =?us-ascii?Q?eVi3bYGAkZV9CqeoDHX124+HOzbNIcoRHvW4b1Fa4hZuTzJUbtjwHtQX/UbV?=
 =?us-ascii?Q?8YbiBgohyzOcNg6NNyPkaSpdDeWwTxvxAHuir0P9gtOgei05UwkzS4A8rKRb?=
 =?us-ascii?Q?87huO1gh9JUfmnDo8/UClumORWgtpXoawMEUPV9E2tIHZXxGm0goybatOu8H?=
 =?us-ascii?Q?wzReh6ciKICqGk5EFfIaHN9d0xDjsE3/p4485SBm2/mlMRkjCJmLDNZNmt4G?=
 =?us-ascii?Q?jzGJL7SJxjRURnNR2x7f+8PYwXwHZCmcX+VfTzv1UKCb2c7BSOXChiTBzlye?=
 =?us-ascii?Q?5/Gc1x55Fs2p8sdEVdngIGZUzYzp9zi+pg1tVgz7imFPTPw3YT4YZOgSOaCd?=
 =?us-ascii?Q?wrNCiVOd3r2DCXycODzW5fyhv6BJErG/Cb4wjq8EHh6dUxTNhyBMBAuoqfVu?=
 =?us-ascii?Q?0ROXzcprrlCdMLca8E2NayuZHfjJLnxgR0X82dwL0PSEe+Fyrb3NH65jm2pT?=
 =?us-ascii?Q?9pEqLox50ik72SY7OROJCAGiQSDrCjRDrapy+tkp2t8KSTntx6GKCEmBViZM?=
 =?us-ascii?Q?w4q2dINUkR7KGtSjyhuSujkz5Mdfqqq4kPP45farXOjKi8oSysi7nnU4agGA?=
 =?us-ascii?Q?d6cDYlcC3kOIollDLZEEsh+roTbLXrSv6+d+lZRW2MPZ4QuYDgeBMj+HMm61?=
 =?us-ascii?Q?pOOdG4Jy/402HJqWPCC8euwH4xT+dTNDl0OK3a/oqD0cWvW4+KutpR86gYK9?=
 =?us-ascii?Q?M5/eZuH6LPLHdyHbTZ8VQcwZgzGs6G8Rd+HMMH/QzB2jSIKlUcwOaGPihOw4?=
 =?us-ascii?Q?fqlESnhwF9miX+dTAuls/yW89UucB6iDnIo/eagXiYxFW2R1sKAqy0D58/YN?=
 =?us-ascii?Q?JouelbWDaXUaBWmpcE4wJwZXRj8S80udQkokewxo2DxaptMFByr2gcUavYkJ?=
 =?us-ascii?Q?kzfJ2w9Uo2jaGT5rCTOWsrZAYiKH/o63U/kjfA/Mzn+O2dSa5tKaNiF0HgDT?=
 =?us-ascii?Q?bEHZi5jf25ZXUjvRXrvrr4dDyopVj9P2etEkQ+OeAwlQBUOCBPc6IPSe8K70?=
 =?us-ascii?Q?Q8YsJ51ixss8iOmaRqYLQpBt+tQ3utE7XQ/A3SlqIpaxaZXUG6P0elZlzd+J?=
 =?us-ascii?Q?qezpvd3yxNLWFHx08OvHdtnxijR0Kq54B9H5TeP/r4OlravusJ7kenYxoHvu?=
 =?us-ascii?Q?P4mAr/PJX79UR+7lRX+X7KDeJwfT1Y2o0Cc8A6XMW0efOabzJxhg3NUeIg3W?=
 =?us-ascii?Q?fFxhAFDCPRALs1rFakZ7Z6n2fOITtCOf0x+jE0yZU6lz7zbgCVYehZvdkSo0?=
 =?us-ascii?Q?+dMGSGNVezJjSGAhcG6NRuc0TTkDBqsc+zbStfFvTlW1G2kftx5VYGAPmVfe?=
 =?us-ascii?Q?XnYIUolV70jga5fgwDE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:20:36.9540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da404cfb-6a14-4e56-6ffe-08de2b6d0516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

From: Likun Gao <Likun.Gao@amd.com>

Set GC family for GC 12.1.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 92c959710355f..c43509f95b89d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2950,6 +2950,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
+	case IP_VERSION(12, 1, 0):
 		adev->family = AMDGPU_FAMILY_GC_12_0_0;
 		break;
 	default:
-- 
2.51.1

