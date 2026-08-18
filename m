Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FE5C5DF70
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 07:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E6F10E215;
	Tue, 18 Aug 2026 07:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cl7E+qQV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D7110E215
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 07:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7RUVWKdJrxG3dQ1fkfQ768BuTHL2uuzOYQvFdJBXmewe+EPziH7TsJAtjFBBgg2qtbNmkGgJq8abxXPXbLbNvuL4Hoi6SmL1jnChFiVm049pE8fgtoywSWdG/enGk1+FCJrfRSjJW35mEln8dkCttzvW3+BYzs6mX85PFz9qzUp8MOKnrO5JTsWM5IjASFNYAgY3M1bX9VkUFwrG0bU7hziUdqsi/XGRdpFMKqDzvc3BumvIanjrbcbVdbCiih00gC+mVVpk/WXiAdku0/KDrZfrusu7YsdxK1yDTlS56b9Q47ErgGnFHjPWeMUfwKOrTXcHitR0vNl7uXdc7Ucxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyplSzUlD535Yp+WmC7XZSdqqqR9CPh9qDcwKBt14bk=;
 b=bLgiI8hgp/5BwsAMRs8mFfLCEq2UPh8q3nXj6UVGC0I8EcGZeEr42JwDINESNvATKr02YALe8s4A3NC4NaAnLwBrmToc3xdeAgwFf/nbxS6yUAgTAYXvcWisN6fEi/9kZjwUze/geERgT4C5aIBE96VSkoVadQ9tE3/rIo20q972dDBZwPxJWHfGLoq3C/cKcwrS3HIoXC3/6JvFueIlkRVSM4DzM1FM5UCrxZgVRCIjUJ5sHUaPm/5lrW/Xk1ee8EZCFPhtIibMQfxGifYnTME7G7yul7/7tQqwLoPDAdJPp87Qt6+vvVGyTQWXocKvQfucIAQiIEuimQSWANMwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyplSzUlD535Yp+WmC7XZSdqqqR9CPh9qDcwKBt14bk=;
 b=Cl7E+qQVbCHXMWzHCJbdOmxqG/f4DwpyXpAZlMcFNYuJ/Rb+esOCet9tjhlmoM+ME+1z2BWuGZaPTyYi6E3wU0pMsQX/b2hdqNwq5N/tOvYtNU6Ly86UhzADJxsLU4lsE9/ML9LEz54h5luBYAxb0fsO2Hgui4zXOGkjVKEpn04=
Received: from CH2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:610:53::31)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:30:08 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::6d) by CH2PR17CA0021.outlook.office365.com
 (2603:10b6:610:53::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 07:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 07:30:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 02:30:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 02:30:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 02:30:04 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: skip unmapped queues in
 amdgpu_userq_wait_for_signal
Date: Tue, 18 Aug 2026 15:29:25 +0800
Message-ID: <20260818072959.3356764-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc9f9ab-7158-4b8a-5fd2-08defcfa87a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XBVTPdIotnLGVbFNmF2uH7DLhbwhxvuwGyeSgz5Gpx1oRax1ndwAY34lc6ZLeKbegUGOHx0awiOI7MBMF+rF9acD2ftFhtp5Aifb9Tx6hSfi2urhZo4O4ePiBad2qZ9zHmkfvwfFYvJD7l1BxLCuF2+gCARc4wL7rkHjlaD0xOBgCJD92J/yNWXT7jshX6tPwuE4GYXPljmEV1nqM0xvIiz81TSQ6/pf1go34SSbwbwiO5DnCJVjTKSf1/EvbEPVPJJ01NEub6Teb4y+Ywc4o7GilMveUorT72J9o8P9unuCe4qOASRZQLCRhEeqb5V1WEee42r5uO0AZ7JEZ9jKt+yyAIhp0ZE1x1FygAMvC04CbCZEBFdjm8fS9SZKexuGWLFIpdGNAUekM4k1KHksatuX9yGZKCq7QO+A/jznaLqvHvR+pKxe0nztnVj0EBNajr+Wj7V32cSYAE0kz6a5u1M5zhdZMXKB6LNqC5hBZQ4pqJB58713rZ1+l1ocMHoQ9nlmSOhigwgwEHtiL/EPd7wmci+3YUZSv8rYhAnWSR6xweXPi6gOumMHuPxkpTl0MC3UFkwbGv/CJzodOOgL/le0VZOsyD10rQvNmkupaYIV6bveLRr5yttrGm26rTrtRQTZAXrNQ6m1tb3XbeDll3YTmnHyzd1E/+lx7Y4TEVW6L8I29a5SpbxblBto9rVIRBMvb518eg8KmgSSEGDRUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TlvyEYyIHhSySnCFvUm2JXRAeU9oDPEr0HuuThZ2CcWPbE4Uouq9mV0ba5itZGPpZOxkg6KEARSVATxwg7wFSZkWbmDzRheJGlb27/aKMD7jVUpL2wSa35zUBl1ty0LXfNYNBuQtAcl2VjFRRUMnTJbbO0+waIf6RzS75nzsTMfOhDJMG9ZQnWBaWXKUAChmOJE80oMLMI0Qv4/Mngkaf1OPc8NlYN5aUoWYYUxQSfdsvX+gB1ltGEZjjDMYyfmWU4hx3yltX4ekHMuxKYISyMn8BuZ3OTueLo9DYIbfEPRPV9FldqU8bvY6S7ZbRNIpmSuSpHx6lLN6Yy/4Q4CcmubZayFf2/9monLaiuH2/GTv0X2w2pSg+PTnJjN0XCONE45cTT6q2jSBWBUTM7Va9X5IZ2/P6QpkUYwzZStvSs0ec4nim8F5NRzN5vIqtwgD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:30:08.0453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc9f9ab-7158-4b8a-5fd2-08defcfa87a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
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

amdgpu_userq_wait_for_signal() does an unbounded dma_fence_wait() on
every queue's last_fence before eviction. A queue disabled via MODIFY
with queue_percentage == 0 is unmapped but stays in the xarray, and its
pending fence never signals because the work will not run while the
queue is unmapped. Eviction then blocks forever, hanging the task and
wedging the GPU on a forced reset.

Only wait on fences of queues that are still mapped.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index feffebb210ea..cfbfecb05768 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1302,6 +1302,16 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 		if (!f)
 			continue;
 
+		/*
+		 * Only a mapped queue can make progress on its fences. A queue
+		 * that has been unmapped (e.g. disabled through a MODIFY with
+		 * queue_percentage == 0) will never execute its pending work,
+		 * so its last_fence would never signal. Waiting on it here would
+		 * block the eviction path forever, so skip such queues.
+		 */
+		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+
 		dma_fence_wait(f, false);
 	}
 }
-- 
2.49.0

