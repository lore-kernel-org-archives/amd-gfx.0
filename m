Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B14CCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B85B10E77A;
	Wed,  5 Nov 2025 15:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0p36bgG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7154A10E78B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ju/N1PDhq3MqRG1Zqd1EbdI0usGq+bPNvltMwHhPIpjAQv8uxLYQmFqdCVYNao58GgFv1Y1K6ueL9pfZyTAoH5dQn1oyM+nQVsPcri4dTt5/4bxGRRqfDXmcqvj8ESv5JBwmysK8RDnv1kfqIpJMM/tDn8r3GC51KSFKMfVX9CgUOqAcDsyqdjn5uYUlIEf7eYv+dgou3Aje7YlPI6XMS+L+IOHV64BJokqatsWdjMW9RrRMi+ZxvQxJEwnOrvjTfDHBS8xsdKph8e7AAp3NXq1rXCsHvicMK2baBTmfM6s7+Uaf+swQuLGF2tij1PYPRWyWtO+neNO5Xy1afKeIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePqmpjppC/qu7A7ddr/Po7cRsBroq4foz/a1b4WPBfc=;
 b=e8YHcBbaUCXOXUxeamw0Z8BNl9xVPAAzsiZIUOvQgsrtqoDoV011UjHhRbwrLt6i/ty4tUZsfjgkgh6EISRD9jt/0X9nIP57ow7y7ZL3h3ApZ2+3RXFYblbxagafSQ3w0CrKJZlrhc7mHjxNKvbt44MMYNAWlL6oPyeH5gFJ3t9BUXi9kRSazLetomNrPpHitfUjBAm62rzxJRjawcTPS3C7yAw0is89Rh1t+OTaR8iIihOoVLwPrvGkSW/KY3PH9Gj2T4BAtD5dgS+bicjcC4OdG5F+nzSSlSuQxFBOE3WuyqgQ2GZLHysL+UBUfVgCVFOlDHyAcZVKv5PoV9wb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePqmpjppC/qu7A7ddr/Po7cRsBroq4foz/a1b4WPBfc=;
 b=W0p36bgGgj1fAfoFFphXWU4lVDlrUz5pfFZKbce2J6NQAjx1/P7e9xMt7RXo/al+8azhgUZbbnfEhyC9/IVqhHFG8j1C+50gwImGGpYB9rx4mWuDNwiMQ1An2kb0MOzmPe0u7MK2I4OQLfHb1+LVb3C79Jea1vM1m98nVgCkUJY=
Received: from PH8PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:2da::27)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 15:49:16 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::11) by PH8PR02CA0029.outlook.office365.com
 (2603:10b6:510:2da::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 15:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:49:15 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 07:49:14 -0800
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fix suspend failure with secure display TA
Date: Wed, 5 Nov 2025 09:49:02 -0600
Message-ID: <20251105154902.75998-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f157562-b87d-45d2-1301-08de1c82df8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZi03Tz/gZT/yhMSNaqk1TDYdfg3+OqT3ibTNhCAwMoRnkt+awQATKgTwJzd?=
 =?us-ascii?Q?YQiZYGgPthjtMTSEa0h4Mh9IBilH1rvYt/Opfoj+esYd2hnkWmDMhukDS2YL?=
 =?us-ascii?Q?N4d0W5ksZzWhsY7nIUaEYm72G3Gqe5jxBEjYYznWsjR1Mzw2Lu06T0WBMBkV?=
 =?us-ascii?Q?oVUPdfPCFWrQ6gVJ/QHrK59H+1KcOuoZHBuGKFqgmzIm+TSRt9yONb3dVhJC?=
 =?us-ascii?Q?mohIzrOfupo1AGFsf8tXyLxGIpC5dV3w9wW0z7T2l+GmLaVUI1i0O9I+dvJz?=
 =?us-ascii?Q?RIbcD6+cCysP5bnX0Jo0u4ztvABCeUtXZjKFlAhIb/GEv9VNyqkxzFButd8W?=
 =?us-ascii?Q?yrLIYIdhfcs/q/N3+392azA2p2oTKqSzvpeUybGWCdPkwEloz77s2URX59tz?=
 =?us-ascii?Q?W/samzhaIVgxViAkDJhn9yzWFJKVwJ7YdFF2OXBimbnQ3Eqod0VfN6mqOP3x?=
 =?us-ascii?Q?q7he3/ZIcG/z6vbrBhdVTj317hVN8CFgmUWlc1QOH0PG2Z1VCo9mPFj3mPYJ?=
 =?us-ascii?Q?GKb6WC1vGoXSV/VL/gr5aBrfrvm6gGDtvwxgvlyEIB0aawjGduEgXWmqcRH0?=
 =?us-ascii?Q?UFyWgbrMiVga1PXmy6jN9mQfQuVtLQQrUYPxdxtx3wJFyaaO8xbSikXGx9M6?=
 =?us-ascii?Q?KP/6N+cSxCnybQKAHOgqDK1aaPHJ+chPWIN6GaI+aB9/4DxNuv4qPSPiIEyj?=
 =?us-ascii?Q?5mhKYbygUbn9C5WMgDVnStmg9so+atoQVCuu5t5IbPSHFx93XW4fCXd7g4OS?=
 =?us-ascii?Q?TYNXomrIXgVpjkdQW2gK1aQoQAQ9QbU3UGkCAk6MAlyFtrPIK9bVhf8xgbFW?=
 =?us-ascii?Q?+Tf+ADUZIJA1i130QiX5wc8KOrAY0hhBin/YZI00G0GnNUEFZ6NqRjqusu7F?=
 =?us-ascii?Q?o0WzQF5aUuVTA89CQn48rquHzQbWj6jr87YuL/ZkWDyQdHkr8lY7aPwmJQEc?=
 =?us-ascii?Q?8TLPQWnZ5E2eB1pvcTWnFfsUZbLtyh74yZjbXKcvXIqIsYjbzqKBdTn9/E70?=
 =?us-ascii?Q?S84w5uMAxGSuXEouowZtqXx9Ou+I+imT/qevsNKeGoDzPdGAWj+av6BWSQSh?=
 =?us-ascii?Q?K7tnV3gR9jMSI8ISPBdoSqyqGJDMBJRd9bzw+ms9gaB2qrcyj2KtEanWKIQE?=
 =?us-ascii?Q?j9foNS6XYAwVXPH8CE1hHRkxNQELfG1h2aMs438rJHBJi9W7gEq09SY+5rNn?=
 =?us-ascii?Q?TzupncaUkxI5rpg3KvCKNnLKMXbzG7c0iZWPDlx/PVyaPByW6eKKjiNDYgp1?=
 =?us-ascii?Q?I7vlql/NGiXo/o2xFlqTIzyVIsPQR5YuIhXHyl7VVhaXG0+FLNKcA+IZ2//p?=
 =?us-ascii?Q?/KiedB+vxDThSM3Mdkvjt52FbwOrRziUbZ+5ZQ9bO1E2+9Z78X6BpTtwt1RU?=
 =?us-ascii?Q?h3AZKHBxf+p8a12fXljAvfIjuHUCLJaa3JybDVr0mJJaLZuv2EZjXhbUgBVg?=
 =?us-ascii?Q?kPDkeyhObd25OXPAeFtAVvipC15mFXV7tEHvzfOzBGTtbGoVvk0hG82qyFSz?=
 =?us-ascii?Q?0vpDHN/iIBfLS6c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:49:15.4533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f157562-b87d-45d2-1301-08de1c82df8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787
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

commit c760bcda83571 ("drm/amd: Check whether secure display TA loaded
successfully") attempted to fix extra messages, but failed to port the
cleanup that was in commit 5c6d52ff4b61e ("drm/amd: Don't try to enable
secure display TA multiple times") to prevent multiple tries.

Add that to the failure handling path even on a quick failure.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4679
Fixes: c760bcda83571 ("drm/amd: Check whether secure display TA loaded successfully")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8c0e5d03de50..aa7987d0806c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2355,8 +2355,11 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
-	} else
+	} else {
+		/* don't try again */
+		psp->securedisplay_context.context.bin_desc.size_bytes = 0;
 		return ret;
+	}
 
 	mutex_lock(&psp->securedisplay_context.mutex);
 
-- 
2.51.2

