Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32341C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 17:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50CB10E10A;
	Mon,  6 Jul 2026 17:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dvIrociI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFC210E10A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 17:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtHzZ3Acm7Np8oGPabISxvWPLuXmM+eIETy3CLwhcDUSw/yHg+e4PecwGMW5mlOiF4Q5o/Pal7gdHW/wbo8ahvTa+9lZvdtRamd8NltXYGOEyAy5gj5arKEAhHqlrPra1OteeqKUN0CjQ2tFgcjps0GvfRcq2AIE8xGXJP0elln6lMjgMxQZt7ZsByDc2q+Lq0PpcBUIQzD7JYy6b+m/1qeVhN8SjT1aqx2UAgtBgJhvwOw4oOOgSI7y4DPJNr1sWk5mB6PlSfyOfBo11E9D0zwkNIg8fwVJuYMU0oR9yODJwdrWmGgsUyCEOnf/AgsTAPxJ6Gk7RGK+e4imPeNqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYmvonVd4JzoyIwL6SFYPEEhD8o+8fbKda0zcOw4+b0=;
 b=RyOQZoGg9Fy2iq4AHFYS84JcPqo/jd35f1D8trVrdf3pDfOcxPBignokhZSiU+DZhA9WkJdqQute6s/bh+cwT3BGBPoBaM+0DCsJbXGYG9Dr6in9ZDmuCUh0ec1GdyWUnQLje9jgsEt6KjjGIjCQlLg/f6Sh4LmivELQDm2oV8gtZkO3DHtQiK96wzw1K5EaCurSs5GYx3gHnDnTg7XVXuSiu3rNJ+GSyrpMY3iB6br/0XoH6WRrbOLfoezH79pW22p07JMP0+TsJcnD1HMFsQ5N0eZJuU0afyU86PxU3CvXC4LaS0qIfOmxriAvZgb6nqv005camFBhOcYVjAVCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYmvonVd4JzoyIwL6SFYPEEhD8o+8fbKda0zcOw4+b0=;
 b=dvIrociIEmr8MhKui6W0yftZ412hQlu6zBQnPNm9S3jAFVqvVSEUO43PAfHZjUbF/D7yE2/Y6J4y/GIwoWxbtQVl+ekOMz1j0CmYaVC8vQcZIzgP0vPEB8By8IyWkpJpGnkeNUyalrdVCMi1/kWxXL/hWLUjsM/8wSynesyEzwo=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Mon, 6 Jul 2026 17:30:09 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::59) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 17:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 17:30:09 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 12:30:03 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Clean up debug runlist printing
Date: Mon, 6 Jul 2026 13:29:50 -0400
Message-ID: <20260706172950.1586506-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d040c7d-65a1-49d7-b4c4-08dedb843a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: C8S/exy6k6jJl32SJPfudxHNgZz85Y3Q+cLVng4dBImbD6UThGFPEmZNaRw/Y3sFYHJ+qDMpOR9PhruOeLZfeFWg7C6ueOf68AsSaH0FgopLA5m04D/D8I/xunexGeB7KEaqNy1PGIgI7b4fpLDf9c4S9GnNVdOJOSBNmQYcc3HFpr6HknwMq3n/XunybgMIibUnawJ9Aiq787+61503F7hBYIN5gG8RXUoHoZ5fggtKi2PK907/FQymW4g/YRlSe9J1sTUwtUKsxyV3ez07QFE+srccYSjotehuCuCVIc7JhqBu0VpyrGLzygy6P87W1Wl4JY8silTxMGl6A2naBXTHAv7QveWF/fKoYEN7PK5m8VhdaElWZSx07SoEzhBf8OKMokpGcbKvkldpPd32VKcyMA+b5NA1OOVQehR6fkUTkiK1sqIY/FJc0S5xcX2q+5xj5eUGVAG5RTHFseEN371y3KDH4rx/S5GQGNfIyQj8GU4/jR9PTOFMMXVg/08RlH/pHeMyrVFUQYm7jH8Li4q6OfhIHJZYbi6PZHeDMA5smD3onT1JHXMsPqYCeIwXnD9tiOrgHGvfkAYEVXeSgulFjx1ebZa7i6uta1hNxDxi670szzgzldr/bphBU4YeQRiBa5kl8VYXNhgV5o6qaqyyvUWefHVitqvgeB0bkG7cOnCur4Uy4SyEPeqElN4XCG7HYqvbvysFdqDGKnoVkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XtdRkcTzu4INC4gnKlFHGNrzKvY/nJnVjO0e9Xoud4aAaw2EZSWVv1db3j0GYhwopccoBO3i6sMwJx+QI8L6o+uq/Z9LophkjKofUGPM3+OCBDst565Or+h0JuMP+USOwSCVt09PXWnX3AdgEU91LMQ1XkProxAe5hEpInRZ+33/Bn/DqcEpcGigFK3OND1/OIHhnWIclZd22wJc5qj65MHN+e+3LnAtmqdhkvDtVJ97k9RG2da6jS6KE4LH4ulMT0HMDVy2ZftA3hfDL9c2AP8iaKHtV55iP3pJxLYT58Z3QHUqLnxe6LMxWnA8z3LQKM7oOj8gfZywZ0/shmusdichCsC60nrSZ2cpqB8frGKYXFfQzhVPAgn+W7exxV7umkG8A2PYH6CVzFVkqM6aIqC7n/qhiD3laTO1XJnInVpVSr7cRUEoNKKydhJ0shnt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:30:09.1587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d040c7d-65a1-49d7-b4c4-08dedb843a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
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

Having single lines with random hex codes really doesn't help a user to
know what's going on. Give it a title, and print 8 8-length hex values
per line, instead of a single 2-length hex value per printed line.

Previous output:

...
amdgpu: 0x20000010
amdgpu: 0x3000
amdgpu: 0x12E6E00
amdgpu: 0xFF
amdgpu: 0x207008
amdgpu: 0x 0
amdgpu:

New output:

amdgpu: Runlist dump:
amdgpu:    0: 0xc00ea100 0x14008008 0x0f4fffc0 0x00000000 0x20002000 0x00000338 0x00000020 0x00080017
amdgpu:    8: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x03400000 0x00000000 0x00000000
amdgpu:   16: 0xc005a200 0x20000010 0x00003030 0x012ed000 0x000000ff 0x00252008 0x00000000 0xc005a200
amdgpu:   24: 0x20000010 0x0000302c 0x012ec800 0x000000ff 0x0024c008 0x00000000 0xc005a200 0x20000010
amdgpu:   32: 0x00003028 0x012ec000 0x000000ff 0x00246008 0x00000000 0xc005a200 0x20000010 0x00003024
amdgpu:   40: 0x012eb800 0x000000ff 0x00240008 0x00000000 0xc005a200 0x20000010 0x00003020 0x012eb000
amdgpu:   48: 0x000000ff 0x0023a008 0x00000000 0xc005a200 0x20000010 0x0000301c 0x012ea800 0x000000ff
amdgpu:   56: 0x00234008 0x00000000 0xc005a200 0x20000010 0x00003018 0x012ea000 0x000000ff 0x0022e008
amdgpu:   64: 0x00000000 0xc005a200 0x20000010 0x00003014 0x012e9800 0x000000ff 0x00228008 0x00000000
amdgpu:   72: 0xc005a200 0x20000010 0x00003010 0x012e9000 0x000000ff 0x00222008 0x00000000 0xc005a200
amdgpu:   80: 0x20000010 0x0000300c 0x012e8800 0x000000ff 0x0021c008 0x00000000 0xc005a200 0x20000010
amdgpu:   88: 0x00003008 0x012e8000 0x000000ff 0x00216008 0x00000000 0xc005a200 0x20000010 0x00003004
amdgpu:   96: 0x012e7800 0x000000ff 0x00210008 0x00000000 0xc005a200 0x20000010 0x00003000 0x012e6e00
amdgpu:  104: 0x000000ff 0x00207008 0x00000000

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index b1a6eb349bb3..85bf1790a6c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -269,9 +269,19 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	}
 	pm->is_over_subscription = !!is_over_subscription;
 
-	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
-		pr_debug("0x%2X ", rl_buffer[i]);
-	pr_debug("\n");
+	pr_debug("Runlist dump:");
+	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i += 8) {
+		char buf[128];
+		int j, len = 0;
+
+		/* Dump 8 entries per line with an index for each line */
+		len += scnprintf(buf + len, sizeof(buf) - len, "%4u:", i);
+
+		for (j = 0; j < 8 && (i + j) < alloc_size_bytes / sizeof(uint32_t); j++)
+			len += scnprintf(buf + len, sizeof(buf) - len, " 0x%08x", rl_buffer[i + j]);
+
+		pr_debug("%s\n", buf);
+	}
 
 	return retval;
 }
-- 
2.43.0

