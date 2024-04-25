Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E3C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 20:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CC711A884;
	Thu, 25 Apr 2024 20:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wcDiyPhS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A911811A884
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 20:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsootmPifZo2cVGHr0FjpkPrUKBteJIPR7BNwn799QomXOYi6wE15ALGSt6xpY6U4y3A4ILQA7ZULnXasREhcTOYVSj0OSnxVYTlehuD7nsN/+ymmLirjDmcbsmGJ/FIHCHlBYmDkpxHy5xQR7OG3nzuk0oteOEavWTzRkdaWUJarSddl9N8NFl2LvEJ6oy75A2fWM0kh6LsIEmuw3e1CBNck18uc7z7/9gYe3y8rz+8IbrSg/SNhfPmnQK2BLmgdOHCkeK9v8UStuP8Kvv7CK8LwQ/qajcFFbRbaYusAN9EZRGxLoPhVXvju5MqEFVygpwsYtXvfaVoo5sbVJq2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtmvVKZK1OQyn2otEF+Oh5xcgdRj9HethEy5p7FHX7s=;
 b=a9LzWs62mIBlzdGFmcEINn77Kj2E87N17TjJDl9ysTy3wVn2oaIcxdBH64a6yLAx7ILqhVBkAjnuAA+8b4ZIoMuE/kR/oAjY1SJI6atNMibuSx1OAbqkxiikd5AD1gQmuBRZ0hvje+LvXgT+VySl4/HrW6sb/63n0Jb3XNFhQLpr83e0IWu3hntxdhKsO1ImlIdoIJJ/siy0Zbo5zPVgBjpbfhYxh8F47qw1PM2w3Ts17unhuZMV68RUcQ5Isb6zLyikpxipEF8sLKQ51v+PkhNip49bjILHjiScv6m+qicaW/KPteBy1dJpKXIpX9k3s/ViRBdDPDyDeDogP1KdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtmvVKZK1OQyn2otEF+Oh5xcgdRj9HethEy5p7FHX7s=;
 b=wcDiyPhSWtdyl4XiqmrtGLtzvWTXUTgjIVG/ULwZ8dyWoIs6n23R5OHrZs7hy0g3a4a9opSODs5F7bPUnu4z2Afanb8aCWD+YSNVTFEs3IcdKRoYEc96GE0rNtciaCismOfx7pcVvChap7yNutZIwBbsUqaQBGdLoNgSk2XR65A=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:11:13 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::8c) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 20:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 20:11:12 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:11:12 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5
Date: Thu, 25 Apr 2024 16:10:58 -0400
Message-ID: <20240425201058.3240622-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbfa728-2376-494c-07d2-08dc6563daf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Huc6kpBCgV02qxasLi4gWcMCmemnhn0kQyJt83PuybcgiYkLTk2QNYafGAlj?=
 =?us-ascii?Q?WiLR6qRjGE5nUKOFBT4Aw2QPbuf/MHAuVkdfUUpqtK601AmBgbgqxO9t35O6?=
 =?us-ascii?Q?fQp46ETe4t1H56lPj6RRNbglStmqer02s9BxHCJxLvRMj/u0lkYYE5jGpvN4?=
 =?us-ascii?Q?asgIdyOosksKBTcpRHD3jdi5CAY+OtYmZH9mbc3v4RYjpDzrfTlPfRMCTlZL?=
 =?us-ascii?Q?w+BTHf8r92KPcC4O0l3NvGlr3t0jhc4c2lfimKXjR0yxEzjff+Rb20RRX0UV?=
 =?us-ascii?Q?COwcvb9Bxe957gMzOfxXpjMxDpj+OK2BPA2eO3bgABLX5VqGghp8BNfzP/GH?=
 =?us-ascii?Q?teDaSaN2q/9ExafEA9usR1rtoRMbzUTgl3qWKIDt1yQ674Jq96aoLN0iSsjf?=
 =?us-ascii?Q?SdjoiKemGdcqc7uwKpsqGoiplfmpvK0k2cOhurOZS8nWXsSwoXG5BqgkXldM?=
 =?us-ascii?Q?RW4X+x990v6u6KvmCaSjgQObrHOxXaA/gPLKfmAjP7em8Ns0YsKjNjNyDZxv?=
 =?us-ascii?Q?FzoBxl1EDt7pZIFbIey1IC4I9bCcEh7ZHhmIzHz2fbv5QGyMRf4WXppUV8qU?=
 =?us-ascii?Q?l4z6HTdFuWQE0UXR5Bm4EQOAd1gmD1BWuLyo8LmZoNzex+hgU2y7ZrlrO8n6?=
 =?us-ascii?Q?97TxKaUdaRUQX7QCC9ifWxE4HLnx0qxwAnoTyRj02cUke+s26KNGGlTzcbym?=
 =?us-ascii?Q?YCkeIk+xpQIRyPOjcEiSspDZpaSf4l4PMqOBXp4yRaCx73SYX4SMDuKldMDC?=
 =?us-ascii?Q?z/5xLOTzEc3Wty6IYsQ3HnM4piXGjJ0OMS73yhhJOEVX+7CDCe5QWTsjJOZe?=
 =?us-ascii?Q?3jiW1qwrjElMmD/a/Wpf181eArEiukY+XOQMZAfzveLfXnNZyMffZnApSogv?=
 =?us-ascii?Q?xWRFGwpEXZNTqw8efIKoUTpIfM0r4OnzqT+QN1ThBSbYtSDkkHqd7u13iYv+?=
 =?us-ascii?Q?rZlmZtLgSK9EPtvS9XOSNn67yQOLo8gWFmRZ4asmMzT4X05meOb1pVwOHKME?=
 =?us-ascii?Q?Z+NB9RfnhUhbe5bDjnC9lcT8WHoRwBD3tyzPM0tMd1o9TUq9+mnWn0oEbviG?=
 =?us-ascii?Q?By4L2XXOS/KopP6DYZYWmOQXmgz/Z1lRZgqW6lQRM5tzdb/YIfkeq6Hev9Fh?=
 =?us-ascii?Q?RUQ3eSDFLauckuw3/LMolU4/Qy+NyNoWfkDLbHuWVA8xXw7rYLbK4ck7ADdq?=
 =?us-ascii?Q?ILzgxeO2QEmvIqCPgeMWiIbCkCsm7vJdTY5CsvzVhzsxM2IFhDIGPJq4TZ18?=
 =?us-ascii?Q?zewxjecgPhj7PS6h+34RagmOWEVQNvphDt6gIVwO86MFjebvaGjV9KlmedQu?=
 =?us-ascii?Q?E8ziYGD5aEd9kxf54IbpWxyTyMQfqvMTUuUm6/yeq5K0V0fx8JU4/9FVVqGH?=
 =?us-ascii?Q?e5R4dHI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:11:12.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbfa728-2376-494c-07d2-08dc6563daf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

From: Sonny Jiang <sonjiang@amd.com>

VCN5 session info package interface changed

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 677eb141554e..b89605b400c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -885,7 +885,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	ib->ptr[ib->length_dw++] = handle;
 	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
 	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x0000000b;
+	ib->ptr[ib->length_dw++] = 0x00000000;
 
 	ib->ptr[ib->length_dw++] = 0x00000014;
 	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
@@ -952,7 +952,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	ib->ptr[ib->length_dw++] = handle;
 	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
 	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x0000000b;
+	ib->ptr[ib->length_dw++] = 0x00000000;
 
 	ib->ptr[ib->length_dw++] = 0x00000014;
 	ib->ptr[ib->length_dw++] = 0x00000002;
-- 
2.43.2

