Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2D0D59F52
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 16:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F2810E740;
	Wed,  6 Nov 2024 16:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ikzdk/rF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A75A10E729
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 16:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAQpQNNusWC5sYmjuLfwiF8kR3GyO7t9htlhOPoynpmIGL3bIVKys8GmVaNcuRQQ2WIVW+WcC7taQ78XarDEKoYt/Qus+zprdjmQ8CJpGrKnWxobWiQMNxzM4rPQMLfq6enV1joNmIZuZaJp4Wbf01haAxMO0EGE+C6DdPMStf8DLnxb/kenTkuAkIIRGNxOzH6mLwid6x4xwvhO6gA1I6sA/iWL6Q/Ay6ND74YHD3RltSE6FTryVwXaJjtrAyo4s7miw3QUPSFpEjtitu36LvzUmdyrboLnhNzAVq0TOQ3KF/y28hYtYHpY5rPeeuLYjrb7MjigmBhb/YZ5Jihk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMUUN/wU7mtPKRqxbRb3wpjCYv/mTm2fvEZ26SAqi7c=;
 b=g8Oaoa/RlWZ4ckPNhPowptKjVUVijSTJL7Z8/2otd/R1sgcYpgjMKuantUbUQ+67Xn9/RZZTaVEEDGHwjnwgJYbSYXXnW6n1dTFrhqlFNMoxKoS6M6rSrIaoB6PxkyKXT2JHpRo6j0J0CmARGL6dUEuBGLhmY9KRt4qPmm8XKS2OLcesse3EOjqDH4rYNtdnsioXQ+uJ8mAyTfzHQJcw+MMeBI9hvThnZi2tKIXCO3R+EN6BsApvom/xtsUODahP0hnAJ5tOXXT9cTp9WAG9THCSw+7dBBFoYFjQaqGPmS8XpWe4tk+1VjymKtEIAlwfH4ZG/IcR+o2rVO2mddtKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMUUN/wU7mtPKRqxbRb3wpjCYv/mTm2fvEZ26SAqi7c=;
 b=ikzdk/rFEi/VmQOvTl04d7rNZ4hSuZDDxuR5V2t7pEgq9ho6dXmKM5erhyCL9RIqeLNMfkmRD4PrCyzGdexUc6amfC9yKz/+V1CIE8rp5wp3ZVT8A7hc4TtAbfGrPtiwXrWzSw70TbzuWtNQ35Kkq7iLx4DVhozBHG9zAzuUEEQ=
Received: from PH7PR13CA0015.namprd13.prod.outlook.com (2603:10b6:510:174::21)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 16:08:44 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::4d) by PH7PR13CA0015.outlook.office365.com
 (2603:10b6:510:174::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 16:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 16:08:43 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 10:08:42 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Max Erenberg <Max.Erenberg@amd.com>
Subject: [PATCH] x86/configs: add VIRTIO configs to debug rock defconfig
Date: Wed, 6 Nov 2024 11:08:10 -0500
Message-ID: <20241106160810.156698-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 586539e7-d422-4769-7201-08dcfe7d496d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CjZjp7NlftMowKZRejTEj5Tuw8X9aGLdy8R0duzvm5qVjDuqUo8Wq08IFmRE?=
 =?us-ascii?Q?vOAAWo9fFkGlddJhhMzWK/pgL3UiDM6LOO5p0Xp5fk8PxvaeOFvB5raX0Fax?=
 =?us-ascii?Q?fOGySl4feF51rZXDfsrsOKznvsfkt9lwjjQizyW5tU6vLKdYlJCAroQnx7ZO?=
 =?us-ascii?Q?T+syqUWAQxqe5fkgyzoyJWiV76hXGzKyGplp0IsSwIt5ILLCPCL4hHBKICJb?=
 =?us-ascii?Q?opa36wWaNMwbqwjDzwreHdyvOKidKSfdTM3gKaTamEd5d+6VU0Hwyymwp6+D?=
 =?us-ascii?Q?VwtnWwKHBLkt7K8KH0AKsasXYlk1lARzmG1OmhdBPuTtQe/CMm7oDoFecMub?=
 =?us-ascii?Q?uNAVIDAyBnO9gCT+njPlNRg+dnRKYuKS/myXG1jup8aQdnijnMdL/nKdyP5F?=
 =?us-ascii?Q?PHnbXKBo4EIn7K93wvvnRmrz3QjMaJEVtraEj8YR1fnP3YRZ7SnbHTceJflB?=
 =?us-ascii?Q?TPWzqvStA0R8ZC2erCTGd5RElgfO7jWRAZeRq3o8IkqXjtwKFC1Emcrm+lUK?=
 =?us-ascii?Q?ox5EobmaLy8mLTO6/FxGhrVJBhKZst2xbEVCwrT394zlcRDZgrok9pS/UNJa?=
 =?us-ascii?Q?2Gf0QyZHqyMrtpRfRRsMdURMU4OFf3s3MH/7ChCUL16mgvgVg6spf9JCaHJy?=
 =?us-ascii?Q?GEPSZLojp8eNMhB7+FR3r+549m7uW4sAQsjQ+Ki6XHZv1UA1xOdU7Chs9xMW?=
 =?us-ascii?Q?6xY/G1V1eEQ01QCIbzKBULN/e2b6zUeJPQSlUxP+Pi3/R3kUCb0JUs8GpCkm?=
 =?us-ascii?Q?4GGUnj70HKJh19teKCCWtig0IfqpP4z1TDzME6gt1iv/JZlvTHmbB+YxYrIM?=
 =?us-ascii?Q?rbOtEoy+Q2gPn2d9puqXmg/tuZ5GWX+pzG/KhhOKWh4NOO82Cud0BwXAR/IC?=
 =?us-ascii?Q?zsyHmOaGlEoQxiawzG419YJcTl67Jiw3UWX+fp9+4rFvvYQg9tRmRsSDpTLT?=
 =?us-ascii?Q?TdM9/gTFtJestvfG5b4E/00mlqoEzBULk6VC2gB3tosbBmr6qn38rz3Fx2pX?=
 =?us-ascii?Q?nNR0ZfbXQRV968XHfmX9pHvu0o3ywUuz9lbCRTR7MgiRqfI3oFdK067c8aSU?=
 =?us-ascii?Q?sXeR0hKMPNy5IimNqBBmiNfS9BCWAqTp3LgRZgF1AiJenxoHYyXjD3gctigw?=
 =?us-ascii?Q?MjKH2Oba1oHLBs4WUfaUVY5bIlREMcWtKl14q9aIFEP08GkWphWCzrs7RwKa?=
 =?us-ascii?Q?p2L082dVVGMBMb3y6KUvbPsDicdt6dpTbVR7jfzLT272eEKgfGVShKv2dNUM?=
 =?us-ascii?Q?uohvtEoiCUsNugFYGuXBJc30LZZOsK65EAMUybdlr3QOfWBJWX4pYJ0+n6sA?=
 =?us-ascii?Q?yqb6nLzwUF2wbV+KoqvfasElNP1UPfkK88MRkno2tXHSSga5vcLJq68txFv/?=
 =?us-ascii?Q?7AeKgaJQvzIR6/Hu3bZdV1cMgrW6F8vDMKFBzXWxM2FC7M28KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 16:08:43.4481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586539e7-d422-4769-7201-08dcfe7d496d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

From: Max Erenberg <Max.Erenberg@amd.com>

These options are necessary to use virtio devices with QEMU.

Signed-off-by: Max Erenberg <Max.Erenberg@amd.com>
---
 arch/x86/configs/rock-dbg_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-dbg_defconfig
index 0ad80a8c8eab..565e447c6230 100644
--- a/arch/x86/configs/rock-dbg_defconfig
+++ b/arch/x86/configs/rock-dbg_defconfig
@@ -353,6 +353,20 @@ CONFIG_NETCONSOLE=y
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_TUN=y
 CONFIG_VETH=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_PCI_LIB=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MENU=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_9P_FS=y
+CONFIG_9P_FSCACHE=y
+CONFIG_9P_FS_POSIX_ACL=y
+CONFIG_9P_FS_SECURITY=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_ALX=y
 CONFIG_BNX2=y
 CONFIG_TIGON3=y
-- 
2.34.1

