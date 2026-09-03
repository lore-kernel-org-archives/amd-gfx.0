Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C43C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 09:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E155E10F4A2;
	Thu,  3 Sep 2026 09:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RahtN8KD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C71510F4A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 09:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMHjQccb9zftikRdkMIERHkz6w2kZQm0mL/h4fyhZ1KKEfJqKoCEVXU5nFQDDdyGn68A13OKhrIHSVzN52gbDKDxXs/vfdzTYdfDvzHnfkoOE9RHeAUGGgwbIqfbYFYwcTfG3NtXKR4TFhhbMK/HaqLwnJyEo9HF0DAisjghLG5wGtqVqtn0ANlC5dpSoq9q8QZnjj7oUrd18r6M8DZ5Ex2H3lLlx4wIfykSSr4/guNsZy8RYTsf3Uj/puAYCV45JF7imWZoFhxNgf9o2R4r5vjbdWzSmgjJ5jXP2Cf4PMW+IP4lFeC9iqVIG8yfaHm8QEiJWQLwMNGMqHjjfUz0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbac5L6sDdzhgQoa7LO0GB/nBpT0OnoJ6X1+fmfSjDM=;
 b=CyzDvXFKqU59FX7/Ka2KcOCXm0baMMAxe06PLrMs6kHaU1C175hmeCLdPq1rid77nvbr5bLrB3gcCPvL3eeq/5e89a3owYooF9Ialqn4+yDZYj1YvnnqIo6xxcGL5KZMTXkR5C6Yd+KVtAOH0YTu3bfer+8qDwcipaMmkVPePIjwyChdta9oX1O8fpSpCpMFlt2tBGbslH33PgzqrnlD9OhfEZcWzUFpzwjX22na0Vj0j7ZQOQcvWz5uah9jdx2sV4LRwOe1wNC0CxDC1GeqCdma/fWjRY+VJNdfjILNFdSU3i/Iybp7V9OmAuHMeYoxsTkNu52qbqCznQimiljFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbac5L6sDdzhgQoa7LO0GB/nBpT0OnoJ6X1+fmfSjDM=;
 b=RahtN8KDT8KARTWHELWTNN/6D9trh7eyIniyiZONqe2v+bpQJugUyzs+QBGDqq/UymKhnabKZg58y/ELa6DAFI2rdsnTkKLVd3H/H142NhkoiY8ODdJMr3Dr4b2YE6Mia+7Uz0hmwCz2LncqqgPhW7mzoVvRkPBlBVy27tKHXY4=
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:44:42 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::62) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 09:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 09:44:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:44:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 04:44:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/sdma: add detect_hung_queue callback
Date: Thu, 3 Sep 2026 17:42:03 +0800
Message-ID: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5d67d3-6fcc-4a50-65ae-08df099ffa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: tLRNh5CvyZXt1x67QL+NcAqA3tHZsVE2W/QJ3tkwnAj+Z6joS/xpxxh4XyGFA1Kw9A++1BAtk5PNZSQEatoBvd0/V8bLklLq/PlkfcKFa+pziruwY5iepnMSMJ42Y0Ma0M03RBvc+iu7PpBhdXJRFD2H3cqF1RiO0j2xlLPpQkLxrspH1ao5wSNxkzrMJDgx01WcV0FyMTZ8WF01at34OeiiSkYisJ+6D5z3GR6oZ19bkOyYrMnb+6whFd+vuRo/EcaJhOyo67Xw1K+6qxn289HA1eSwG7D7GhP5xb7WAKTRiCerj7uRF+YZ2N68o67LNhznTyPmaXJLotuvbOQ32No8vyOivRT6aem/ur/WyYG3994zH4Q4UbRCkun7xO72oGqzy7G6syKP2Nq+JtLGSenvkF+Z506QE7aNEgWT7k763eA74aQ+BIkXQ2GJ1uj19rnkm/nUIMUAa1kaX+wypR+shO6R7ZXLXl3I5n3qFZG6JyqyDqrTfSpkgUN/jd4U14g88THLu9FUTK32G7J04baD5WBKI5C1A3YZpIV9TppAf1JtQNbVmfX+EczpaX1MzvRNIRvd7EaMFMWjJ4utKZtQuT6nysBcJ/vnpdr7TLwBsA94WyJj9q3z9KtJotAJjen8bIVQ4cXLii3NsA26ZMccKN3xm7KDxs/xVZz1LNIP/C9zXZ4Lr8BKeBsLPAeBIla2E7Sqf0+ZUjASylmT5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ppkeiqRIHpMbiGI/ETZi2gXENW3FnqmbpzyD4uKcJbBK9MCtA2fBhaRWR2FGpoVtCkMOACFl0yalNRL+4yCCFvgrmk+sYF+fUjT16C48u23PEEXKnKBas2YqDhn5yq7OzS7WmpmcdU8Yq4Nvbjc2XoJvh4aSwGcJ+Bcl7j9voXgg9bZVdMD2YqZJCReEDvY0xP+P0HLPxNhqns2qCImqawlc4sCV7OHZr6I5vKLeSF/wSdEC9kQMmUpzakm/MmO8eooY6k2Bamw0V2NSiv4Nll8CHA0FR6EmX5VKyIa6ViobGhTzuFYmeklquIsA8F919auYSJc7IyqU1L3ZC8rrjghOHXP9T5V914b/vR46g30aTB62rDR4Ntr4IkE/uD2JU7d3ZtOsFfA7PJ5Hk6Oxszd80Oky2MMbJQdv//GCaKKT32TyjYgysgI8F0K9WTBp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:44:41.0281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d67d3-6fcc-4a50-65ae-08df099ffa1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

Add an optional per-IP callback that maps a user queue's doorbell index
to its HW slot (instance, queue_id). It is needed to reset a hung SDMA
user queue over MMIO, since struct amdgpu_usermode_queue does not store
its HW slot.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 671cfbb67b7a..659836c2c377 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -59,6 +59,8 @@ struct amdgpu_sdma_funcs {
 	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
 	int (*start_kernel_queue)(struct amdgpu_ring *ring);
 	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
+	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbell_index,
+				  u32 *instance_id, u32 *queue_id);
 };
 
 struct amdgpu_sdma_instance {
-- 
2.49.0

