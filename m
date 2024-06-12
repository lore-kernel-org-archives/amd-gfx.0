Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D2C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 03:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2290E10E773;
	Wed, 12 Jun 2024 03:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jmr6siuP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07ACD10E778
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 03:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwUsojp6nSFUwQcnqcNgV5ibbWHvoG670/x36Uiyj0amJTelWZyGhZgzxI5Y4K8jWUUr6wUCKC5Xn+THeM+QQQZ16vvx3pVoqDDxgqEKLNqqGKWkYkt0juYn5QwuuTc+uaNRPlb6UtJiVRGEuoTkh1C9pVjhIUqTyfUqtoaFTnqlq+0VjgEf6eVYPv/ZTsN1aPyoHeugfYAYm7pP05DJgGGE46i29Bt+X91CZHGChy4bZXK/tqkqUwnzvZCz7ZIYyxBsWQA0NbmcHSSo7AN4FNDoWWpuYG8RrBoWBN1y1EiQBJ5dLLASqyVQE3pnFuagxQ4b5zuK3u2W255kjIx7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc8fsLnJ8t1gAnzFm/3YYILWIo0DUmWSRBEQdtB2Il8=;
 b=kLZhvVey4RWuFgpZ4O+PZHdBm/QY/pDSObtjlW3lrXbdXUSL4vrYY1yYOsgtZ3lJwRRy22I7ZYvODscXKYajILwj/a9vG0gbN1EGIWYjEpQr77V2LPSbLLQOMWnJcFPxDprjFI8h/pDGPzYWtV1zvnNaqte/v7Vsu/tBnRhwuPafbr+NrMnAua61ckH6NSpIdsd4DAIK9zsYomYPqVGnWpPZBHEs5R/yzBFQ3Y/yNSPpHEHMLUX5LH3V84NTDS3dZ6X/nX/updxnRt5vwU954oU8TdcWGRSUfhaM2D2Mgj3t3bnJvh0P7ZqftOqvUM0l2OyNVXC6SkN44FYc0GjPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc8fsLnJ8t1gAnzFm/3YYILWIo0DUmWSRBEQdtB2Il8=;
 b=jmr6siuP1hflKQbLSBePsSWDv8RhatL6TCyP4dXlohPZO3jtNeEjZycQ7cw6JzZpyNed7LW0TxO9/2Lpb00hYmd3rLeLU8zLfoewxMAZOCyviyItJQu4LZXdQeYZKzeJe8kh6wj9Q+FTJKneZB+4hIILEg41xI0Oppmsoiri7DE=
Received: from CH5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:1f1::13)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 03:42:30 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2a) by CH5PR03CA0015.outlook.office365.com
 (2603:10b6:610:1f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Wed, 12 Jun 2024 03:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 03:42:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 22:42:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 22:42:24 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 22:42:23 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <JingWen.Chen2@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from jpeg v4
Date: Wed, 12 Jun 2024 11:41:53 +0800
Message-ID: <20240612034153.229075-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: e649d681-b870-4643-884f-08dc8a91af73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJTBISRx1fStrGYPOFgpPL2zlxWkPG0smoPjW5BzLa8TgWCxa2LDikBQ4SUI?=
 =?us-ascii?Q?Z9RPOFB9UpGnaBUuAnkbx3TfgiNmGWZ//K81LuXOWVejSmbeoc4oksrpQ5an?=
 =?us-ascii?Q?2Z5kcs9ftPn/dvB4QcRikNiLjF63iJIyfGl6dAF0nBZjTwqfDSDinvHOZR4f?=
 =?us-ascii?Q?WACqLDnKCIQcI7/ShN5HubJYGD+Yv2zOdKqrHmmqYr2D/jlrKYzHssXsa9/g?=
 =?us-ascii?Q?86VwTQvabMckuMede2tY+N/VzbArd+LMCV2dXIbLWOoKXQzm/PzDqeJVSkdR?=
 =?us-ascii?Q?dMx7Nxhxr/3fEWs/BO8c8X4GBt8xUgQ4IR3r31HBGW+3b8pF9QKAoxRUET3K?=
 =?us-ascii?Q?WcbVblk9Dm6MpUJCq7zMSeTjR0VA9dWNpKfDAdNlCah4n7KC6gM4bzVJdPS1?=
 =?us-ascii?Q?xaOtQcId6Gp2UbtPNTOOZqo1rP0NdPmpTH6VB9g/hz/gC7xZs/3g+YLWzCy4?=
 =?us-ascii?Q?gnWQKHHGBV00i7EongbcDnxrsAbYdmYRKVhuXBQgOpZyAXD/h2q+s5bI6a7g?=
 =?us-ascii?Q?pFBPst1/TGsg/QrW9t8yhwRwfv2dHKa2GxOSwRl0V//8e/lO6nztz+GqCKFP?=
 =?us-ascii?Q?4JO1aZOslwtakIuCEN5j5lUm9wGDSeOCaIAfKyNg3RH6weSi9H9h2VpN4gw4?=
 =?us-ascii?Q?qX9EpJk9R+jKTJui5Vlj4mcP6qhsErejofDc0aXJMrY10M2RKO9BenqZ+x9Q?=
 =?us-ascii?Q?bmsvxdiOPpz4uZy6IY1C2RvdXPa2nWnwfZK/ENqsm0AV+iOeN8DH6Ac2xNAA?=
 =?us-ascii?Q?klwYUNqRdv8ZXMmBXSJSN/flvwzAbxOf8gq+Qay3BqfaBaXZlVRsLGZr1Izq?=
 =?us-ascii?Q?798VovIQIdqH4Z9bXhAXdN2qMN/QL2hho9rXtiyQk7DmZdhrpx6tOHuz0wBE?=
 =?us-ascii?Q?TEXVS/Lgk3OiGfe1dplKY4SHatR+12O6Z2IBe7ttIWren8B2fNjSEQNVHaN2?=
 =?us-ascii?Q?Tcf+T1cXW0INa+fXQLR1RR2xxQM3O6wHve4IBO/C9/KHgXKZvOUYz+PwSvGq?=
 =?us-ascii?Q?LL8oCrFqTVI2Sd72NaZip2ABmTdqRGkrzebExGJf9Hd43xA0X0qk8odB8K+z?=
 =?us-ascii?Q?8QZqEguj7NNrzRdaE0w9LhWRCsAfUNRRHMdgg4FHQz9WsGbcLj56THp1Tmg3?=
 =?us-ascii?Q?dW/sPj1NZjMAhU2gFbdlXwFUsh/G4u7IUw2n2+1LJjfN1tft0D4O/i67rCwd?=
 =?us-ascii?Q?Amw4z9+BRI+1CBPlmLF2ARrXzc6eUOu+wb1ebfRDEobPuay5qoLuA0r1qRAh?=
 =?us-ascii?Q?BKZW3QT3qIARY4D9S9eJzNFxaiRZen0BK6Sjg2W5u+MfAHhl1Il/JVotNUMe?=
 =?us-ascii?Q?BUQFOXxaH5hCZgOMUGYCxDXHGB+HeUDnlJKmUc4YhyKJ609MOVApoMp/7Qlb?=
 =?us-ascii?Q?2kUp9wfGAh3PvfuLsrmBTznvR/lxmbTaalAlk3ZkJHarHVRqoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 03:42:29.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e649d681-b870-4643-884f-08dc8a91af73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

add jpeg table size to ctx table size rather than override it

v2:
save jpeg header info otherwise it will lose debug info
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..ba052b104668 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -200,9 +200,12 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
 		jpeg_inst = GET_INST(JPEG, i);
 
-		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
+		size = sizeof(struct mmsch_v4_0_3_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy(&header, (void *)table_loc, size);
+
 		header.version = MMSCH_VERSION;
-		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
+		header.total_size = RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE);
 
 		table_loc = (uint32_t *)table->cpu_addr;
 		table_loc += header.total_size;
-- 
2.34.1

