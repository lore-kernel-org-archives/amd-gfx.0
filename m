Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FCECD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 21:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8962B10F5C6;
	Mon,  1 Apr 2024 21:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFxGRSiq";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC70410F5C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 21:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kgr7XXIqKegXQaKmBqwOYQjjgt/yQcnsxvO/KEEfMi/Bw6WYkvB1UQLg02Cnl26fK+6WFKgULkjAVE3AKNY5mPZFm+02VXlstSqIwL2S1vq6tKt9wQ5lohGI9jAjq4vJWzjr+n5Uk2JNM/WljPDbJAkghHYemKA0rcaIXc4HnF+OwKdvRsiQQTVNvxX8b4/H68w3e3F6A6tpaYBX3LNLHnv18VPvRPyvAuvvwZofX1KjCOiUn7q9jRF4urY+mwb4sCsLylAELUQwcQSpW3RlZ42osOaT6QY4tUDL+Az+QKFD2Cwy2n8oyQWVlnBxJ+YTfdwNN2qaOiUjKf+sAdu7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j3clrDIItz9Q8g9JIy0jHd/CTyerolVpuncp1chQ7k=;
 b=UVzyOGSftR40W8C7QUS48gMNIL22FLdO0QbudgYY2wuLmFuIbzv6j1nS8yFgIF3COUsklBMswyRajidQEzCcwOVYJpuu6YPuu1WdK/kH9KxYGPyDWYe4riMmObaMM9g6N9ox7gbuR5e6e4JfG8h8QXG0b8nVSt4XeQo5PlvtLz7tnZ1mRiOgG4KlHjeQeT148j/XfMl1V3IU5KsG3sFiACJitu+oRV/8+/XXItX91d5fp27pQvtR5YC4vsDwQAeCDfo20Zu687pEt2wdX7StbECPyNw7znOic78nhiV6474ncKzMsKBJtCk2R+jNLJbDcCBwWhMRCwvnkiyJ2rEj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j3clrDIItz9Q8g9JIy0jHd/CTyerolVpuncp1chQ7k=;
 b=YFxGRSiqpBNwcZNwoBoGHkCAaDh34nPYaLZYcZtIu5LhU1k3w2SYx4U1tHhIT52/+5qDFvS3VjrA/ceENsTd9zF4aE3AUGtzpM/1arHlDDbrNJk/UZOmEe4jzkSF0K1yTnhFI/xO0T4mvUMLgQWnVkxD6ly9iSXwxEJ3/rumG/Q=
Received: from BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 21:54:02 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::2b) by BY3PR10CA0012.outlook.office365.com
 (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 21:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 21:54:01 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 16:54:00 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, <felix.kuehling@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH 1/2] amd/amdkfd: sync all devices to wait all processes being
 evicted
Date: Mon, 1 Apr 2024 17:53:48 -0400
Message-ID: <20240401215349.23361-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3be71d-3fbd-4199-432d-08dc52963dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvmrhM18wghRfE/c6KPOodR1AcG5vAr292es9vxnBlsv8aeneDZZJnkwkB9WGik1f5Lzr+hwgokq4gsvywWQcEMrZwPfIWKtp9TRfc75mmhoERM2Cf07c5JLunwSX6wJZ9x5ETcRCf/cOKuLG4srjlGQyPQFg9JTPUnAHS0ZdGSYnQYfsbeyXFFaiUF9lKijoFr9iFDHWTDPl2NjpXvy9Q/xSLcsnVHrJ2uAYpKOrEDYTjDWqTIbphAyDVovbr2XBHtTJX9PRIXeR4YXFqNyR9swCYU6nCHHGiXg7KXWPu4lUD3/vIF+gyo2qjguJMIkWcUGUI4u1dvu/vEAAA5M5vGfqQoduJidnoABbXMqo1WW/nOluogErgn/TGK/RxuskiAVQ26BVncb1jth35CUQvQaUhAGPfGUYoEd57rogmR9xZeAzLCTd1R6XMVyslDt3w7hF+0pPJLcKpZIXn0NhqQ/Td+RoGNrxzb1qRBFB451zxuxqacJgQOS9THIuD2qj493ceMpYe2DcaGkikcw4PzV4+ROyeLb3ef8NvGEFkN+Bj7b1wI8ZLn/oigWvMst0TpQ37PeJheJXgb1VPxkydsoUgcOOHZiBiTwV/GbiaceQzdD8jCugMU6dMmLlg4P+s9AVK2aNHWCcxO9B8q6eXJR1UNalutW+qqO00k0ZzadaL++EPiWKCgvJNkAkxpfaQ3qESnZ7Sy9qOYE8VOXi8im0/KPN8xWyVOzNlqAgVnQt6VODB2AyzAmENeDPmR8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 21:54:01.5983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3be71d-3fbd-4199-432d-08dc52963dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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

If there are more than one device doing reset in parallel, the first
device will call kfd_suspend_all_processes() to evict all processes
on all devices, this call takes time to finish. other device will
start reset and recover without waiting. if the process has not been
evicted before doing recover, it will be restored, then caused page
fault.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 041ec3de55e7..55f89c858c7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -969,11 +969,11 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
 		count = ++kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
 
 		/* For first KFD device suspend all the KFD processes */
 		if (count == 1)
 			kfd_suspend_all_processes();
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	for (i = 0; i < kfd->num_nodes; i++) {
-- 
2.25.1

