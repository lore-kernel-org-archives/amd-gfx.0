Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B494DD3EE72
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E129410E9D8;
	Thu, 22 Jan 2026 15:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJm+Z0uo";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7817D10E9D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2giXlxwXfUfSI7HAl0L9XKkUAm6dDr0N2dbDj985+TegekbsdArzL7O/WN2i+o4Y5Mo1S3TTseW+KPCBbz3nbtc8ACPn6e5pCTxd82g/yfbZ8vaRToOJhqdqCR5HIf8IAgiGgnWiupSYW7p0KA3l14CP9A0PR4lwKtvYucI3f1QRqlV467dwIhRfkC4Qmu6YXB3S+qwfDa3TX0C+LYrOkjV8xwEnb7r1xPGAoMKXCbCnDqslP8dD1B8SW7uWdaMf7pAYdTqMXqGUTTHhRbZNe9k5OtUJtXSL74narAHLaeyPSdcQcDjGhX4PMtNvb29py6GwTI8QPfRz8ZVZDDjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN5OyfI9iGpaEgcoTMrB+DVVuBCQ1kOuMN7vi302zx0=;
 b=dTGXSTZXHW7ybCjbCOOZCOOyxUeVe6yzNsWOQ/utZJgWCd756azc7mnPKWiF7MZmV3ErqQe3/S7Tn6OoJsDLLgXrX6qNjJH/GiVLJgSdIi9OOysIlwtbq3krbtrJHgWpwyXs3vQVEzcp/6nNU8Ffxig1duD5SYZ1Zo1lLnFxG0HYKZNBIzdcGxLcStUkyNSHWbOfHQMuQeJ70il46Ebn9NygZ95WINhDXPcxUysNcJn0uY6IK6L+zZR/YVhLnfLZzrIzXUoiVPimZX1jqeTyUO4KF2md/0lZHUOp/dk+mgltn90RMwOKMPn7VB7FUIHP//1ROkLQLX+dsu9tbShCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN5OyfI9iGpaEgcoTMrB+DVVuBCQ1kOuMN7vi302zx0=;
 b=mJm+Z0uojskkkoR3hN7DQlAO54tIvTCArR1/0OMGEvZIoumFcM0bQDuvPo3ivH4dvvEBWS+z5ZyZP4eZAr4f+ioj7VMfbCCi+IXDNZta6FQzJyhaXhnZX5GBkq+On1YS8oK4nYfcT0i2/4dyLnR3V7LapRhub2U7wVYliX+AVog=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 22 Jan
 2026 15:25:12 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::77) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 15:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 15:25:12 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 09:25:11 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Date: Thu, 22 Jan 2026 10:25:01 -0500
Message-ID: <20260122152501.351937-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 809647da-ba40-4d03-dc68-08de59ca6f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ddmoiI1XZKPqfgbWfDbHwvX0aWBI/3jswhn77W5J+4kn88b8GOrxyWaok4Z?=
 =?us-ascii?Q?VOrGHHkQIIfTtVsfGImTFWrpqaNvma2CXTsRPr+NKTXIkfnDfXs3QLczWARF?=
 =?us-ascii?Q?FABXnkcl1G2Q86oz3cuCIWlgqX0xcgwdZTcmo92lLn7sRZRUpIrKM8m6mhAu?=
 =?us-ascii?Q?XyI88n1O+AMAi2pChktFSEBhT522gaTwKGSzITJhf6WYBx1C7dBVp+8me/h7?=
 =?us-ascii?Q?NQMZoEwvB/ajNOlDoBMwpETAG7lUf+Skh6LIfQDWxDFHNEsJ/ch+Qb93g2Wq?=
 =?us-ascii?Q?od8j8OgCX66HgcYyjqfBl72Lw0M4RBiNQdR+uXKLZiJTiEm6C9ZZgotOvLMw?=
 =?us-ascii?Q?HFGfAzpOUGT6v28V+o4og7MtCButN43mfzgqKaPk4b2ljTdQXkg12YjoKpLh?=
 =?us-ascii?Q?NnBnMaoVCQGs+VN80nnm1rvCjsI5mKIR5fAHvvlUu/KHDMaco+336pHYF8Zm?=
 =?us-ascii?Q?XBAQwiJhRue4KWvlIAKBadKDccKZLLxi79/Mm1VKUZWXog+IbiCojx3023Q4?=
 =?us-ascii?Q?TfL7CkoZbOt5e2mxtr1+GHuSWXUeSgUu39SK4ZxUwPZRcmEayGEWc1Yyekcr?=
 =?us-ascii?Q?/K0I3+5m5yjFPX9xaoRI3n8Pw+tCh1o4NveR+Y0ObyebjgsYecRsoAaROGsL?=
 =?us-ascii?Q?NIf36jRq8WoVvWP6fXUUDOanv4E5JvGP/eHa8Z5frKjhl/ZpYyflXF7Kb1JB?=
 =?us-ascii?Q?jWZm3O98nfnt9SlziOLjrtzBCFcFzWJSZMo5sS/x5CQ7qSPfZUWNaFSGa4HX?=
 =?us-ascii?Q?y3hE6fbkSWtDJtmSKCDewksV+yMiC5/Hn2F/25UJET696cq1+214DOhempEu?=
 =?us-ascii?Q?E50RfJ4eMiSq6AW53QAuYuyeg4A6FYDpRS6ID9O4W7wr0XkN8eF2nTUPfwWX?=
 =?us-ascii?Q?DiXw5CiH16UNe9PqOquH/KtFOxmjoeKrnBYJWZVw2+oTmhi9YmSlQuJQTZZc?=
 =?us-ascii?Q?tKHMVDlOIfBvxUhRXvvGRXRg+705dc5TrLyNd9Apk8qfSSvXxip4Y0Rxihg9?=
 =?us-ascii?Q?EGUSjt5Wtc2FfJ+gKUh2YcDGdoAdj/+g4/+pGWFC/c84fgMQ1wQuOScy2PhY?=
 =?us-ascii?Q?7nfwMFeBsVZe7owYi8BNCRK+DtN6MI5/LGdfGMJLsrEKB63lRH772d4O+UJM?=
 =?us-ascii?Q?i7zmYUPmH6sAuxwHoB6VWaURvf9oDwv+Mz7b2vMsFG+5XkGYaPQVK6Nx63J/?=
 =?us-ascii?Q?obtuuilS0d4VHfvUum4irsyvUfrz3sNuO3ZgJepagkz02/BLZTTq9WWhNrZf?=
 =?us-ascii?Q?Tf6egcrgbyV7IAZla7s6vb5SfRJPOkD3CRq9TmT/QE+YFxx3Die/iFv82Fyy?=
 =?us-ascii?Q?RvH1PJpxYLNNUFIm8Ov2dzBgQW66E9KEEg5XhfJqC2EMrmb7c40lV1ya1pqy?=
 =?us-ascii?Q?5iBEBq06M22l6XEarhUvlUmsYnh/uZV890CzYBz/N3YMdAWdtb2Xg5ZEwesD?=
 =?us-ascii?Q?nWR1gRKTp4+t+qki1H6+9hFGQ9hu7/cB7Gz5SK04GrmqHK69yHRzgzKtqr9Z?=
 =?us-ascii?Q?1hQqAeKd2iCAg7rn/fIxSiKnzF1s/MX9dH1YoDWdp8Cbfehs5cEy8I9s/ejG?=
 =?us-ascii?Q?FPlRrFnt/lcDfXTazJq5jTwp8jdwXqc3OEViqPgLVBfdCUbnq8clPwpS67Jw?=
 =?us-ascii?Q?BBPrWCkApSNnFDg6N+tY/DlKQ4hYu/WGkRaAvXWuL3ma?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:25:12.0891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809647da-ba40-4d03-dc68-08de59ca6f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

Some older builds weren't sending RMA CPERs when the bad page threshold
was exceeded. Newer builds have resolved this, but there could be
systems out there with bad page numbers higher than the threshold, that
haven't sent out an RMA CPER. To be thorough and safe, send an RMA CPER
when we load the table, if the threshold is met or exceeded, instead of
waiting for the next UE to trigger the CPER.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 64dd7a81bff5..469d04a39d7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1712,6 +1712,10 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 			dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
 					control->ras_num_bad_pages,
 					ras->bad_page_cnt_threshold);
+		if (amdgpu_bad_page_threshold != 0 &&
+			control->ras_num_bad_pages >= ras->bad_page_cnt_threshold)
+			amdgpu_dpm_send_rma_reason(adev);
+
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		if (hdr->version >= RAS_TABLE_VER_V2_1) {
-- 
2.43.0

