Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B66BC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E6E112416;
	Fri, 26 Apr 2024 13:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ov8Fwadz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2611411240F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktpyg2331SS+pcURKFto2e1jdkm/vmedv8EhA1OWEYVmF32RcTx61CXkZMNUdjTvipTiC+LEgeC1EeqvnNU2VjAUvCTR2YxmpGn3uJnnOjCLCWWHjTTWoOt3NIZ3RiZYNmFO7TVmO6ds1k7qv8ripcwKby1u2+wbUGHLdrrN6VyfM35z15W8MhbMlXGPh8dSC2hSZQegRWOM3k3CKiRh0YejCbz0FIHbMvsCOSS1LuifyidJGUwA5jvSTesgLwOs9bA2dcfwXkbyKqUfvo8J1vU50DnPWkP3EZjGu3fn1X4XBZqPyVvx5qPJ5gEg2eJcA7EooB25pcibkEpMHSTfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQNUaPECiJk4fqIiJmlbrl2S7qo9aNcLWlqJy7xRfqU=;
 b=Yzk6EsQB2I8VkmRdSvh7SVAWTNfieL3g40xQKe2na/Fz2s9S0VTyfUfBNhdxcp/azsZJw8r/hRROSU0InKSnGfOu7imVcLlGq0M2GplnLi/423c+DA5TY+ZgC3I2rZFDRxCnLwkgZ/txsDbxnJuVQhbGVk7OjH3xiOKrdhk39CbQZAWDHQ5QTFL2xRXoWh1XQmDEC82G1IwOT5BZvK0tMayUfImXg1tr5nMUTRCP6Pilyst1dCxqAKqs0E3MhsQuvEvqv6FnZML4bm5nXVinBbUwWorRbAKEfSrzlDvvg5wmqDY/uhkjr9wn1AfjRS0a1OBvDtf0hRIYh05SUr2IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQNUaPECiJk4fqIiJmlbrl2S7qo9aNcLWlqJy7xRfqU=;
 b=Ov8FwadzMNp38SBRxo/Z+9Y6vXEf6I+bf0f1RngjFzDGYLmGB16MFMS3VmhC8SxHxpQhKwdYuUOhvdn0goj/7HVfmOtDHYkRwflwViEh5BeBWRkfaFUoWoT4VjjR8fknzUhy7FFp+IIZ271RcrzkLZXkT3IGMkahd8LKtl4W6Mg=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 13:48:53 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::70) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:52 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:51 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Bas Nieuwenhuizen
 <bas@basnieuwenhuizen.nl>
Subject: [PATCH v9 10/14] drm/amdgpu: cleanup leftover queues
Date: Fri, 26 Apr 2024 15:48:06 +0200
Message-ID: <20240426134810.1250-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 351c5431-05ab-4740-3a56-08dc65f79c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQQZK085lr37qhVLtzENNEJ0OE0y7oYCw+cMYZZMKLGHpXgkAiWyt4rXSH+t?=
 =?us-ascii?Q?MaUz3wiWTHsFlU/B9O4Nmeptwcwdnf9ER6J6dMrxXxeElF0KnSlihUel9kov?=
 =?us-ascii?Q?VPuf/6MyfDaSbDltxZ7MGPrxuGRr2nO0OwxXs6nauFadW2VID8XOCLHXQnLn?=
 =?us-ascii?Q?tyu+33EWYL84yRYIIW+FFDYjHqCNKwk+ayoO6cW8SwJZYmM+498QNqzLWo1S?=
 =?us-ascii?Q?lua+7hwIeEmZOm/A0toKlPuLZYcKU5nxqBmqJcEYJGetb37njhfCKMIVCWOD?=
 =?us-ascii?Q?Cf1kOIKT8iM5dkMrYWHdCjtcq4gnMbGOj6ZcfKRqaJdxd5s6ujtJkbFjhZeg?=
 =?us-ascii?Q?HVghiRjma8jOc7eyB7kL8umhlRAcjls6y7iGNYVp2JvZQRnkgaKUdyL1Dr8Y?=
 =?us-ascii?Q?N6nX3f0woI/0Ogio9+SvJ3gU50wCDH+xVVXZOKkehA3CZUXPqq7QcXqcKmzQ?=
 =?us-ascii?Q?paOJNtHrVzDZQWnSmZn51HZG3sAtxFiEajcZtKt3nKFW4ZL+RSp186+ZXwnV?=
 =?us-ascii?Q?psHXkNJKY1acBG3eSuYBhy5yHEny+xMNX+7U9WJfoPEb7jEIORW4BpVpAWQp?=
 =?us-ascii?Q?bXh5dIgJNurdccV9YKMD5zIyN45YThQDmjgmH/XjCZEtOyPE/e18q6U54DqZ?=
 =?us-ascii?Q?5xv4ZR9rqpuLFYqKvWJnKBu2IMG2pYmX6Ya7YvTiMROoIpsI4OC0niHd0FnB?=
 =?us-ascii?Q?cxV31qf7mZWJYpFhz3/2oQm691GIcQ0I7ERkZEimJpSQsY5kleYVEfm8DCZz?=
 =?us-ascii?Q?sA3R7dxlk0vvTYhWOAw/aIEYOpMdssUgZSo8wp82Wn5kGxoNM2gB/FQK3EDm?=
 =?us-ascii?Q?RUvwx0r49Ex7Sz3EDWXTFdoRrErrYXH2p887F6sBNSGO0M8GyAdiI9P6SRNB?=
 =?us-ascii?Q?oWep5NoxluIeXkhJQOxJ75cpDlAc6NAwgWSilkbFa6AEHtksBxCC/pbjxZ2z?=
 =?us-ascii?Q?5+0kDzwxFvvi1XS56K1Rr+4LZI2MddzqbcsZ+LwQIMDF8WfGdwtpl6ndpcCW?=
 =?us-ascii?Q?P6W9vDEzc8gIkLlfeKJ7qGgDvpxY2UUw4k4rccQFX0TITM/MPIoN3iYzzqMQ?=
 =?us-ascii?Q?njla5nWNBjib4kpypNUNyBmQjj8bim5lT9mYDJ2RehzQUETcWi1bTNAdFJD8?=
 =?us-ascii?Q?NbBfAm3nBc+OGvIZoNu/onNdPw0KYfIN8N2DVpJKnyrpo6exX1PPBTE2HUZV?=
 =?us-ascii?Q?aaKiqSXTagMoQ9z9KCE8ntrkZ0BEldOC1DKM3Poq1ooop9KS0pvGmf5hm2qI?=
 =?us-ascii?Q?fMJM1B1o/G38ob+RlbhtRAGGJeY65lCuqe0T0uaF6K2J6G6Pwk8qebCbpwjm?=
 =?us-ascii?Q?Z+YZAYYMaUvstrGEaPhW8kNcCjaBqT+O7glZxhJoyLfDbUSH/22HHrMvvMxe?=
 =?us-ascii?Q?W80JvzjmSS1cUESi3sKjkRMK1hUW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:52.9228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351c5431-05ab-4740-3a56-08dc65f79c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

This patch adds code to cleanup any leftover userqueues which
a user might have missed to destroy due to a crash or any other
programming error.

V7: Added Alex's R-B
V8: Rebase
V9: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index fbc7313710f6..781283753804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -26,6 +26,19 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+}
+
 static struct amdgpu_usermode_queue *
 amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
@@ -146,8 +159,6 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -159,13 +170,9 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 
-	uq_funcs = adev->userq_funcs[queue->queue_type];
-	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
-	kfree(queue);
-
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 }
@@ -277,6 +284,12 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	uint32_t queue_id;
+	struct amdgpu_usermode_queue *queue;
+
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.43.2

