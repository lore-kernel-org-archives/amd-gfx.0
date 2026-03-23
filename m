Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE0EC01A6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 08:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E149810E059;
	Mon, 23 Mar 2026 08:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpOeuJr5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD5B10E059
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 08:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE85NYR1070ahuDmxeUyqFyo/U8jLJ4rrZ0hSK9oUDC6uAconlf+EKZLNjoocnGpe+EV582C5DMU6lC9IM1PqxihwGu6kgVshJjdop1ZTgCPBZujZRdJP/r2u5l9+m0Lhsfig58LrZ50RdSi6vzEtqnIoL9OwmgRlVwJJv6TS47IZurh5ulCcO3DxwO+nqzNyr6NVSo4aryVYDRjatEUTJeZNQertWf44g2cpzwYw02dW2GUgdUw0heSMmB2+W57Ag7PxAC0aWO13WPcwJqi0Ypew4d75LTHXU34sUvQl0x0+oaKAMfKxfu7WvxLhUXtwnpkIuuR0yhI+IfxcHJH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHw4SWmbbGTUl9SGfAZqfspb7Plw5yzLEiGkrq/xHJc=;
 b=yIeBvaWz3TFI4Kf0y0Mc+TJfCFhSDOiB7nOf7346s7ixRXSFGXMQOO75+QCwz7MTyxB7NYBJo61kX/iRl5J60iyh++wR7rQFjvKFT+9e3iOxqzBjvDDsqmPly8IeEbXQNUyDbvfeIRnpz+slcBPcDne/Kb6+aluw978QMnw1XOAyLZ4z6t35+NqOfA5sJXUtXnGZCc9Q9znDO+q2dsvZ5IkVvNuFfKS/T6Bnu7FyXVvXZzKrM9MqOV/nlTGZBQhfR+JmbnZzjrRoKAtjeIfbAokxF5vVFxO2+J43rsvTn+BC7iKb4gJbBI+E7s5pCmryHkySQGk1UbNBV+uWXZPk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHw4SWmbbGTUl9SGfAZqfspb7Plw5yzLEiGkrq/xHJc=;
 b=TpOeuJr53MR66Brl9Qdmm0eSeefnXD+fzcO/w7+Ipnx8NxL6wzITp9RS3gJDcyYAcODNvIPSpHQNs9TKndCyH1CrqYo2LdqFVBKJmSY+Sa4jx+97ue7ZlJ6BJqsyxihFFj8j6WBOzIaYij09GCmOUxKIGLxNGcpw+UMiBskM5js=
Received: from CH0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:610:b1::7)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 08:39:35 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::18) by CH0PR13CA0002.outlook.office365.com
 (2603:10b6:610:b1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 08:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:39:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 03:39:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <jinhuieric.huang@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the idr allocation flags
Date: Mon, 23 Mar 2026 16:39:23 +0800
Message-ID: <20260323083923.3348059-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8899e4-b33b-455e-b474-08de88b7b667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +dEftlq4YkrVj/YNstF2oseFB35EZfH3WX43jU0awObvLqHOjh/zNiHJaSyhZQ0o/Yu3uib4mNnuerDnI3RLUOZt8c51qGi6ROjMQNNfa2axPi8DLCnZqY63yFlZkiMKPZddS1iIxzKEW47ce2Kh9cOaTQjuqsqU9rO7QfWInducerzNO35Nv36GlYRj7zd6BUBreLfXxsLT/go4bmHUBvyH1yJNdwu/yoN2LvfUA7OyAu/Fyr8bPYAlHpmZpvAWcg5bqeQRGtwEunNnLnaW6t/cszjphe1Q8BbWq30jSiy5b95ue83K0PXs49Uv20UkCRYubklv4vXfOSGOKLW6qXWvLe/rCuXSPhWtKcnPNJtSeIENvd3zRT462USJpHG63i0VziI/Q1Qwb0mnS5/3lKzmDALu3DPHyrcpgS+uJpFWUQ/HLsoZsHAS1+CyItKDX+PbNb23xxd66k5zwdQOsqEtnacYsDHdehjlq1XCToz7MeAkNESCCAc6guNfCIrcnH1RiClpKRK2h+CR3aX+u4wbFNFJ1Az0lGZlmNnBillX3Fb7JU76Jn5GdR0xxS9XQZg8qtCDRznFFNe8wdT4g1nvIUWHDOFiDabb3A2thuTi/OImOyPoi8YrkIGIl/XCFgY4gNWBzavM8gE+inYBLUqluTKyG7zeTyksRoFHbQjnQQARiu9+zcnl/NuQ3U/DrduKyZVBJx8GB22eF8NtvIXxbLmd7SiMikLgleWXHx4AmIzsMHAl9kMCk0hkPvhKblvURumeCb8moXpm3vXiJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O72rmW2t969bpBt/qhSNvk0epBsxgIPHxxkFLQAy726+7yubVtqDaTkMEgbcP4BT0nzigRrldG/mgyI7lhIMSdX3Aj+UflOFuXpXUtaSO9/NX57o20X5f7cJ3AWyXIUgZ62VbTE+Z8ASlhmCvJcpdoLW2XRzU7TxsxAZIOqbCRwAm+dULX5iVOPdVjojgmOuPl7i83VIB565rJVS1LIcEkbRRTO7ZrKL+XNZGTLm0WZ0z3sbJzsuEWcG8SPl+5EazNVfpOfLJ5abaRz7oN2xmXRNrvAaRMiGGODcCflJpEbVnEVd1VBV1IDnJzAYy8aCb4qKmHFQCkhRf5nHsbK4cfxvMx3I+zLZFVUjYL21jUCNCgM9l8OnYJskaBEe+2t8a+83oiOIIfjzv692sB657KpiERRgnd8hgUAVE2/P+QgThjrphK2hQImlsKjXqJtL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:39:35.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8899e4-b33b-455e-b474-08de88b7b667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513
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

Fix the IDR allocation flags by using atomic GFP
flags in non‑sleepable contexts to avoid the __might_sleep()
complaint.

  268.290239] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
[  268.294900] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
[  268.295355] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1744, name: modprobe
[  268.295705] preempt_count: 1, expected: 0
[  268.295886] RCU nest depth: 0, expected: 0
[  268.296072] 2 locks held by modprobe/1744:
[  268.296077]  #0: ffff8c3a44abd1b8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xe4/0x210
[  268.296100]  #1: ffffffffc1a6ea78 (amdgpu_pasid_idr_lock){+.+.}-{3:3}, at: amdgpu_pasid_alloc+0x26/0xe0 [amdgpu]
[  268.296494] CPU: 12 UID: 0 PID: 1744 Comm: modprobe Tainted: G     U     OE       6.19.0-custom #16 PREEMPT(voluntary)
[  268.296498] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  268.296499] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06/13/2021
[  268.296501] Call Trace:

Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 644e413a4e69..2f552352e046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -69,7 +69,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 
 	spin_lock(&amdgpu_pasid_idr_lock);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
+				 1U << bits, GFP_ATOMIC);
 	spin_unlock(&amdgpu_pasid_idr_lock);
 
 	if (pasid >= 0)
-- 
2.34.1

