Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A20EC25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B836C112326;
	Mon,  6 May 2024 18:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lsTNSUJb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173A911231F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na6ofAkw7Xm7Dg8yM/P+mpGzW3ARhzWH7tvQcn6y6RcqkE5a5CjsIKeNKgAGHGaMpxVdJ6363Mm91HVIpLeuBaU+0UErdIvgIvRxvsOyPqsOlI4mVqLwnM8PnLnM65ErT5Uf10EOYoqP7eDmH6EQ+ZwGSFAij2bs3fXbcG8l2J8zHUGI+BEBoFr/2EdFspFzaxsmqm7KFxQv9kJIdFhBxWt2rFKt8njE6ejLFmrfVyzUK5jWBdAW5AjsctgDWd/4nPEhOJflbZnl0BLlkXkLRaO05m4gto/rrHEj1RqVXo05Wmz0YFhClHOHcT017oASw4pUdUOdhU2bPI/lg7p+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuxSvpm7rCw66HlAjYZFYfUZjxdaemfBk2XLCutI5BA=;
 b=Md0jHyi56RiDmhfhiJkIsfJTd2svQ7FfZnYSN6TyD6CiyRU54MDI2sXaxtKAT/zBLlykN18lyvtG3nggXQYDwSV16g5D//liuGsLHjNXaFUlpv6i0/2vWN9Dk6jDNEPWKFE55nXKzUwhe0Nf17W2obU1lgt5D6sqL8XderjZ8bZq+hcXhLuwNm3R7pii6nGQ7GVztl8xy9VRCLn2WPJ6waLvblinyDPcGY2Jgdtq8nTaIdL96Xi+RnnYpfB0oFaCpsRGlEzp2ncy892WZuSebIt0KNPMFZOprOrLI+VOIZDjQWtTMfBT5cUaBpuM195Io0B3UEQKq+B1k1eegYwN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuxSvpm7rCw66HlAjYZFYfUZjxdaemfBk2XLCutI5BA=;
 b=lsTNSUJbB6/Hw9vrXmWqN+I0rQdCkwfQQJAZNkcSEWPrOgF4rP4FUQ8nV3xc3My6xUNtmCOPLxo8OqX3MV7N/Ogoet0R1VRvTkxZX46g7sa/vDXPOKj4Yp1PQjNBHUx0fADpKFrKsPD40nV68hYJArxJnnPbO1G2C5RjnLcbcZo=
Received: from PH1PEPF00013310.namprd07.prod.outlook.com (2603:10b6:518:1::b)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:46:05 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF00013310.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 06/14] drm/amdgpu: add set_reg_remap callback for NBIO 7.11
Date: Mon, 6 May 2024 14:45:31 -0400
Message-ID: <20240506184539.1669157-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: db7125f4-5360-4d61-83c6-08dc6dfcc74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fCu0bw7aKnCEl0/eqFJl0N7kRYBUvlWkDorfjBlJhtfq7CheXXjSwIYdb5eY?=
 =?us-ascii?Q?JfIVfGuRn7ZdLpioShmJB0UTxnxuPgBvtIIwT/OUJ8zgVWqxKwS2IehvYEOt?=
 =?us-ascii?Q?AGKwvqiGCw2pUAr6e+w2cBwZ8hhy5O+ACWR5nQWiSzbjm86M9s9oKd0w7gbg?=
 =?us-ascii?Q?VYH35xpK7iNPvmaDXZ3gCUK/kbUZwomZhaN8p4d6fFOYEJpLZRCM8TGCz5Qi?=
 =?us-ascii?Q?t5Ss+L1ZZMRYjhjiDHs7XgffZd3KDhXNNnlBVpEcwu/c45ZNYIWz179snpdg?=
 =?us-ascii?Q?FvzwEHoBb8tSYNJTsTsPeMRX9/KcOhgv9UZGczm4YgZ7E6ofRqnTaJpGSZ6R?=
 =?us-ascii?Q?o1/kWbINrlS0Z4TzVmfIQwFHGc+N9I6mykbrY3RFKH5yvEPyuyP4XalDfVLB?=
 =?us-ascii?Q?9q5H/adU25FTmFb+9TVgkORozGWdaGhuBqfJyShpCvBDezIvdpcASmotUDBt?=
 =?us-ascii?Q?J40iaO4iCKB2Gg3aStpbmcleQa+fxFOyvYcWLolMryhi1G7+F2yJHVBtM80r?=
 =?us-ascii?Q?Lh/I19fYTER6pM7/qKr0Cw+rICF0GnjAubfjqGiQ1HWrXEyNPIEaeLpfEEAA?=
 =?us-ascii?Q?UpSdxRxcJCz4eSJdbudfAv17oRfOgl0IgPocO/alaWFZNDwLM5zqo1/KtGOw?=
 =?us-ascii?Q?sto84LO5Uo7iTgfDCg+NTqCwtWWMQBxKpcBex0HJiHsrtcSpregWsRuAQbYA?=
 =?us-ascii?Q?otBPPaJElCV7h76MeLe2O++lANdhzeozg95v+UDj4b4vH38wjAyMZrlckACN?=
 =?us-ascii?Q?VRHbzJ0KIWTgngKaxrC9cqXQLO1ZG/8wbvAsOsvhqn0BjG8cZBaYqZl/V19Q?=
 =?us-ascii?Q?qAIlLK5lLvIdQvl4KEnVIKedYqYZqP+aAQjXpwZ3gJ9Y3t8TGL6EI0EL9M20?=
 =?us-ascii?Q?Dk3h/eZYcirrGS4iAPeoxCUEnesg9/cvNPiarKces3o9EYrmTDgMo3b/QJoD?=
 =?us-ascii?Q?cDXlWTh5ImFLwyYUW9t/kOauszKU5LgZ/sp2y7IRrUIh1HHZCnv7IXMQ2c08?=
 =?us-ascii?Q?bVfvlZg8Na9UreJEZc4c32UdNwWNs8yBQzvxnBpkp1P0YT7AZmOkeetC04CJ?=
 =?us-ascii?Q?A9RKBevKaBDHc/AC0VH/UPEKj522PG+baoe0PaHYfNW3zml+OGv2Nwobnq8d?=
 =?us-ascii?Q?MQHIUSE1cV7NSQdmsv2iX3z8A3KwUbdLmfoP+BXuUi8G0ZTQFUZRZL66Y/1h?=
 =?us-ascii?Q?1uPe3OCrTXlJhku4GcpCYDu4PKcBkXvRABqs/oHbXhVnJJRE8kFnfcurjX9Y?=
 =?us-ascii?Q?LIjDV7eoEuYFLpIjrSKvib1MX7Nw0RBT70x60tYQ9tpx8qeEzu8JNcm3bujQ?=
 =?us-ascii?Q?USNulN2kOTZQTCFup+uNyHaYHhCfd0zVH9UhfChYG/0s6BTTJ3wcNuWChiVe?=
 =?us-ascii?Q?ppXI2n8ONXhlHHVA0L9RGXnlqOUW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:02.1762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7125f4-5360-4d61-83c6-08dc6dfcc74d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 05020141c0aeb..7a9adfda5814a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -352,6 +352,20 @@ static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
 		*flags |= AMD_CG_SUPPORT_BIF_LS;
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_11_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_11_get_hdp_flush_done_offset,
@@ -374,4 +388,5 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.ih_control = nbio_v7_11_ih_control,
 	.init_registers = nbio_v7_11_init_registers,
 	.remap_hdp_registers = nbio_v7_11_remap_hdp_registers,
+	.set_reg_remap = nbio_v7_11_set_reg_remap,
 };
-- 
2.44.0

