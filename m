Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE9C54FC6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 03:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEA010E0AD;
	Mon,  2 Sep 2024 03:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTMmjBnI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9824810E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 03:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg59cd52JVNwYJVVb54uwp+Y2tZva77MRo+H+EkHbJVtQUdC6mh1/ijUdztCUHLeCxSIsEFnLI51jpCaxz57THiqp116Pac2qUuZZzzRBFeRUM5/VxgoXGu40JeQxoDnBTnvu1VlhX7FMTC++crrElaLsaNwikdu1O6kQ9xBqNQXSP1NdHxuj2wxQsDqk0ozEFIFvxAHVogc1aiTnNm7cS7/Zr7NE9SO0OzA1xN8Sp/wOfck0dFqKssuoMTGWOjre2Q6hCVRDmNfpTAwZxiSQX3Ugzm7JYH/sT1gYxJRcF11fjodp5aXnHTqiskPNRn6VY1Lu+jrYWKCxFaUP6dmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVdQxQWJnf/+nKjWH9knHnV0SHNVxib88AYXvaOJLEw=;
 b=n/fpd5RaQid6Lv6DJdXDPKLlxYgSWRGusj3x+5k7J6z8w8v/h3SxOnofSOe8ZdRRnzzB5xUOY37ZIDt9GU6vAAsHk1bu7epPn0dQD7rDgRlUYXEm0Go2jj8o+pNaPYcmMjpcbp/Iqxl/BkWP9Uvyr/AhEvgrlXkaZZpYBtSDVZTacCJQArypBfcXh33p5hHrLCJ8se3ZIxb/1ZvTNNZjxl3exVaQyxebiyse8PwK8KTd470d5yrC/vAUo+sxXowHiTwoTDOh2FSkZo2RvhgMOFTvPh7Ja/7zrjf+Tn1+BjaUeuB0Rev32dpwa61vBfLksA89BKfP5WvMyMz+00skZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVdQxQWJnf/+nKjWH9knHnV0SHNVxib88AYXvaOJLEw=;
 b=JTMmjBnI8GjVhLfza3W9LMnhRBoG6a1LjSuXJpX5QP7M8plBufSlgIOePKj2rFOEqPT239xzPKl80Tba4dYj46Edhk8lRPpa9PWzdxr6x6xwqkArPik1nX1apUjIz26wtHoDOhrioHcx1X/jqyVvyH72vr1FvN2ftkZZCMA+jI0=
Received: from PH8P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::13)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 03:07:52 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::93) by PH8P222CA0018.outlook.office365.com
 (2603:10b6:510:2d7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 03:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 03:07:51 +0000
Received: from lang-maple.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Sep
 2024 22:03:20 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: fix invalid fence handling in amdgpu_vm_tlb_flush
Date: Sun, 1 Sep 2024 23:03:05 -0400
Message-ID: <20240902030305.11952-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: e892ce2a-8391-4207-efcc-08dccafc6ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OwQ08VzOKyVW/bh+UFUUmB5Mqnum0fZJVPF6q2kx4sNtjdDtb801ONn4dGD?=
 =?us-ascii?Q?VnO8xqabSYTqKt/sWt8kcGCmAz+dyhz1PrhZOlUXD7acn8YN32QPJ3dUMLyV?=
 =?us-ascii?Q?qsOgjFjFM9g8WkBuvjvExaJzxj0HmeKKwuMGpyEep74YMo4QAiTzFe1NLEX6?=
 =?us-ascii?Q?e3vAfNWPCQ3CvxVMMVS6Hh7eSjSvgaUTd034RokIlzzu+vLZXICNnoTGPKLK?=
 =?us-ascii?Q?klzpd/8JsXYck9gmybbO7XnhfGB8OxebwDkBwdGOazQ6S/FJ6J+8358EZMNT?=
 =?us-ascii?Q?PpkmcySo/WcMA54E1jtXPy9yP4bJ2GA1BagUNAvWXci05s8Jxo5o6rpT/SRl?=
 =?us-ascii?Q?Xda3akyQ7YboNV953HUkjTAOBndIa/LeJrFffbIzNVrXDC42P3FpJtC9TDBJ?=
 =?us-ascii?Q?D1/YqoylW7iaxPsxm4wgiuptW+GAQcmEWhSSyZZtMzLAHyf5Lg95uo1DzgFj?=
 =?us-ascii?Q?Qy9fWpmCGo2rk9tmgFrG/Xg6oGGenvAaPj8eVhQQp0K5Og5j3fJWRjmSfQWa?=
 =?us-ascii?Q?pqW5FaKcB24WsO2UwhcS6rnem029t+Fhg9003LlMrEC8WNnelXNQV/yeICuz?=
 =?us-ascii?Q?FTI2iGzkkkKmA1MBdnspzlbWg9uxYzhe3YYTGY4kVfh16nkUwSHzRpM6B4E5?=
 =?us-ascii?Q?uyxZBe9iwushKmFWwyNppe/PURfeho/TE+4oG1qNd3dbUCqIsvk7JPDjZ6RE?=
 =?us-ascii?Q?NoJXTB6cQajYB9B1HNc6/L8oqegkAgi/S5flmupYs6LfETZirrUDYJh41BL7?=
 =?us-ascii?Q?xU0bRqjY+y4f4+6W4pYElCE4TaL2e9q668P6GPKt/15oF/0Xfa9nUeGvZCaq?=
 =?us-ascii?Q?wEU53ck6A0zTuqFUI8dpgwrJLDmE+bin2eNw4pzqvzcWNTXXW42nCa1M3eGR?=
 =?us-ascii?Q?xD1YMMQZ+7QtiLykp0LtpRQKy6g2zE6IBtwMJ2Xuk3c2wfZoC+/M0gF/pzr4?=
 =?us-ascii?Q?3x09x53E1I3KmkSSOoa9RDVTi0WR9w2u7QaV9mGAntD+igv3flzlfsFvX64r?=
 =?us-ascii?Q?Ka07Mq4E3NzNRay72o96htZ2QXGbpEX1mqT0f7zmH2BMA74jSgh9jNoRqGyz?=
 =?us-ascii?Q?v6FCyC3JluQkLL2DND2EKEVOhXxzskj+i6pvEtdnxpa+VuigfiRvw57ck23N?=
 =?us-ascii?Q?BYZmKoVyuf2NSkeFlLYerRndGtEEKA/u4ZNRuyflBCQvTWZ0qMk+qYGh1Pox?=
 =?us-ascii?Q?0UOweegcMPrCvQtbKc+eSgallTKqQkhqsR0+1Rh9Pl93qYnrgNz7eydbvGmY?=
 =?us-ascii?Q?aY3UWH8gumJcUXZHM7h6fiRn98q0ZNzo/tvg3dH807T59632lc2z+DFToEgI?=
 =?us-ascii?Q?+GoPjHGIQWWnJA6HRKL9hUPoMACV3gUBW4QcqHhcFLIGFyhhzRACAP5XeuQl?=
 =?us-ascii?Q?rFLIhJLsnUY8KQqUIqaw0L1qbdPW9OBQkdK4t8fBsj7eBNwtyphD+ozMXm81?=
 =?us-ascii?Q?yncOzchuNYmjrrktMmS/x8warrpSOH0k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 03:07:51.7064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e892ce2a-8391-4207-efcc-08dccafc6ed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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

Fixes: 5a1c27951966 ("drm/amdgpu: implement TLB flush fence")

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1d46a5c81ec4..f93804902fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -908,10 +908,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 {
 	struct amdgpu_vm *vm = params->vm;
 
-	if (!fence || !*fence)
+	tlb_cb->vm = vm;
+	if (!fence || !*fence) {
+		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 		return;
+	}
 
-	tlb_cb->vm = vm;
 	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
 				    amdgpu_vm_tlb_seq_cb)) {
 		dma_fence_put(vm->last_tlb_flush);
-- 
2.25.1

