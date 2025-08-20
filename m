Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43892CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 13:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92CD10E73F;
	Wed, 20 Aug 2025 13:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pdp9BbEo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DDC10E74A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 13:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQucbvhTMCXPpQngoIJuOLBeyHBRuKu3WYWUBEJTOGhWRAHykc7q+niR5BldmYqfuDqJOYc8Syrig5YeiWL4OoYtpRweOgCn9akJcrId1rO39kEUOdlNMhQL2snR5KdNUCmAf2bvI1UsCPF4GcAlSBULI++ZcSmwPhgQu5M5bcoMBSeTohXHoikpDZ9KFs61DgaSeTXItP/+8U6QF/UDV9IsYyCeuOOu66Yu6IpetLCjF0kxJJ1iR+YyUVe0IWirWek2Ai+/ULVmGJWeKy3+V74N2F8jFPvQG/2geW9bXnMLZk+syhF+OgYkFMq1JE7HS6x6B297VNwPcNq1H4W8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG8FHUajE2MDn+5gsxPFAQvWRqH5CfB0abyUDKYcpDw=;
 b=Bpsxf9c7znkKvqcflyAPmRuXPXQU/q4jfbbgO2NPrsg0SyiKf14jWYVktSXmjqmAJ9CB0AtGpWsn0meRXw4DgNDVdgqeUcEpcHCTJy+iZP4pZJE8AY5JAHKa/uuIFooGUVeZFfUpI9V+/CHBwhf2P3QPt/3RmNqUT+G7u9abuY1drX8YlvlsLJhfaglN4L36Fx6ZaNRqqzogx2YONGW6XIDG7sEKdN/Nlcc8jZF1F9PmdDGusSomqc4yOvEUUvXjG9qgtWYA2DAhC9ihCu/ryr1KEXPujQ38zKUIjuGxyxGx3ke4djX8Z4AtboS20joccbFFOWNNHEEKib6b7zGy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG8FHUajE2MDn+5gsxPFAQvWRqH5CfB0abyUDKYcpDw=;
 b=Pdp9BbEoFxfHftOqBJ/8hPphJMchhQ/QZu3NQ5mIFQ338FI4ix4wdfqWL3RZTsLd3eTeW054cSlwzC8H2U8g/Fr85YR3baf4ZHJTw9WpYfF/y0sLFZweOXTq4KmthgB4Xi0H4ABxYtIDJxXlJFesUpgf/fPo+qICr3/jP0JgtX0=
Received: from MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::22)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:52:08 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::bf) by MN0P222CA0017.outlook.office365.com
 (2603:10b6:208:531::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 13:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:52:07 +0000
Received: from sriov-ubuntu-161.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 08:52:03 -0500
From: Tony Yi <Tony.Yi@amd.com>
To: <tony.yi@amd.com>, <victor.skvortsov@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <zhigang.luo@amd.com>, <shravankumar.gande@amd.com>, <jeffrey.chan@amd.com>
CC: Tony Yi <Tony.Yi@amd.com>
Subject: [PATCH] drm/amdgpu: update CPER century timestamp
Date: Wed, 20 Aug 2025 08:50:53 -0500
Message-ID: <20250820135053.2587444-1-Tony.Yi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 21250e2a-956b-4714-2d9c-08dddff0c10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JO1tb5eUmtDXFOxBmjpgxLG6Eac2yMNyRm6Sk+AD3U7jsSVO/6Fh+6sYqrz6?=
 =?us-ascii?Q?PoqJvHwjR4BRpx8gTi6URL8zm6H/E5UBR9NPkwiO1zSjHfomVIsuW7czVaJi?=
 =?us-ascii?Q?a4omSR1EikWtdDRBJFn9H932U22/yvQepjkIBY4/VH7T16RzBLdloz1NUz3U?=
 =?us-ascii?Q?cfm+Dc/7lYTCdUke7Cewf6WKwHNWMunzzjdcY8y4KYt1V4y4Bc4+M4IDAKJg?=
 =?us-ascii?Q?8TzDP2HnpS55qDiXJYylOOembSkmzOXzzAgL7K4VSM9f/TeZqm01vwuN2xM/?=
 =?us-ascii?Q?D/E2B3hBgUofbl9P+IPpo7B/RTtyaQpjAVgOd75jk5/vPxjbppLqC2F2Dhhg?=
 =?us-ascii?Q?kM9IEMUM84PdwS/AqPuWZe/QbHKgenEKBmBswZLhqOqX7zhtKi+EgEyHUY+K?=
 =?us-ascii?Q?yP8kj5jxPWY6+jMDenksviZJ7jAc599A9RTkwZroyr6EN6vtNgGsdGXGcyaa?=
 =?us-ascii?Q?rv/K21qMZvIitkg1hr7IOQ8nuVSIxz/A8PNzo+jvFUeXSfFD7uZR1j978tb3?=
 =?us-ascii?Q?GvSxbOXsjSHbbT/ubFO9aA0Ts6bbH5rW1GcoKONLIN/RxdE3GtK9N+ZbpyWE?=
 =?us-ascii?Q?fCFQGobEcgZ4fMlB9zGXfiVY/1aSs507V0FnHeGC/a3qEO4rH8DSnvBs4vZn?=
 =?us-ascii?Q?+8bZ46v+Fc3kKGMm/8o9qr/i2K3o40Pzl6ml95IRgKQyLcniy8iqp+9QotSE?=
 =?us-ascii?Q?398m/FNmWKNihQz9NXCqsO2oVSk7qBKUC/v5B6fKjOP/fVy6RlAzZ32u4XCP?=
 =?us-ascii?Q?ROuo74H0IzGRnF6CskCmsBRCL/BbLozwz3pSvZnQNAgl2XyTJhmsRmdR/Cq+?=
 =?us-ascii?Q?IUHxptnHoxe4Yc32MPf7ajJ5fSVdHXxh4qsh/CpN0yiHc5uIxvsOmv1e5Xmo?=
 =?us-ascii?Q?Ukz9ryHQFgOS7Cu4e/PU+VGC5FqEbwYdZgRyd9ONwqA0fNuQ77EuBABk82ro?=
 =?us-ascii?Q?oVJikpzP6Pf4qeMuIgY9cX9Vbg/nmGVjl1zyhkN8NRosvOtrkM4ElVTFWnQn?=
 =?us-ascii?Q?aMquOxx9eeJNV7fIzwc9gwLRU9OlWGbpv1iwEHGVn6mN8cN/fPVWgayKKuk+?=
 =?us-ascii?Q?cjnm7sPtEyQ6voTNmdRClQtPF8oHWFXKk2ZVMOtA/5wR2QkDMTTC2Am/azS2?=
 =?us-ascii?Q?YjkEy8t/hjZ5YzivKqFkrt5DMkukOH9kTZJPZe/4V8rJTakaKBOJHDS82wQv?=
 =?us-ascii?Q?wjfpvBjPw6QFfl09UzFhqWCE4k6f+KA50WFmOlzTMz4RjtlqTp6eU1eFrooP?=
 =?us-ascii?Q?JNJh/LfTGqioTs2hRNylL1Vr79Nuee+u3bv/Nv25fjuAk/YbBdT/aAs0Yn2x?=
 =?us-ascii?Q?BmxO7zy+AzxJwDparwegqq2SCczWaukFH8vE1HVtz6bB3RH/zMyVrieXDUem?=
 =?us-ascii?Q?wqUm62cUJwRpzDNINtWdKl/GEgB6jPlCYFM1PgXDpzy0VG68Tb5ctwLGCuJn?=
 =?us-ascii?Q?h1t8T78nb0c2YT5uU0eTAdkceIDPsrfeeSoMqoNRH9vSjltS+EE0K0UFkVfL?=
 =?us-ascii?Q?aYIokWLN/URdQKInO1W/uAWl/1bexlSqW3Im?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:52:07.9859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21250e2a-956b-4714-2d9c-08dddff0c10a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

Update the amdgpu CPER century timestamp to UEFI
century + 1 (i.e. 21) to align with CPERs generated
by other AMD products.

Signed-off-by: Tony Yi <Tony.Yi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 6c266f18c598..6ec68ba31ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -49,7 +49,7 @@ static void amdgpu_cper_get_timestamp(struct cper_timestamp *timestamp)
 	timestamp->day = tm.tm_mday;
 	timestamp->month = 1 + tm.tm_mon;
 	timestamp->year = (1900 + tm.tm_year) % 100;
-	timestamp->century = (1900 + tm.tm_year) / 100;
+	timestamp->century = (1900 + tm.tm_year) / 100 + 1;
 }
 
 void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
-- 
2.34.1

