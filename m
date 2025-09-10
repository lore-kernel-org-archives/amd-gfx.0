Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC1CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 04:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F62110E83A;
	Wed, 10 Sep 2025 04:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DJCQSAhn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C2710E2AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 04:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcLkokohPC+JYoNtv6fJwU1ZuNNspUIoMdrTrWn2Xz95YP6PJ5fvRwBDvW0vaj/qV/E/F2AvPBTyulSi38yKs5wgkhEOFnafFn992qtGywlfn3OuAc7sYpRyG0P9sW1eJet1B6ute2hXPCKPYkfc3kAsDJKFP9H3CKplhSJjU+Yo9EQPp5tR/yAyb9yhsudsvjfebSRc+3H4ryAmsH5bNX9EdVe665QcSOn7FXTjLD5C3LR0kWmWHQVZ0d+AYhdPc49HJRtltmGoJZy0VejVWkjb3UOLGrTSfjCaspkvJAJ2NhATAOzT/UqpKQN42WRMrWGtYKhbMzV1ErPqTgtxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcVDU3KJcuyjJIPSX/3cXxruQ64r6YR5eDr7gdSf7JU=;
 b=Sw0xZv6hy+Q0PpDJyz6YDPe4KlpgsBqkhjvIeyNVPvIio1YWwDJ8j28kZ6Pro+xOO/OK4GJv+3wqkaAzTVg2R4gwU5+at8MZV8DY+Rgak61bd+3R67komTU5/11QYmgtd7j9sqkPGisllPRxySupxMVc/nm53WFn/qmWcQ8ggf0tntvccWeyrEH4NToSF5tFAMJkt0ZN5+LTqj4eca8xvWp0nIcs7aGT8SMGJPjhL+HjPTyMd2JxetBKdZHbH8iKwpiZfeOVYhn/7CzXsBnHOEjWxoH58Wqh5obx7FCZzHiMyTY+ds6y2uc5O34Z2eKgUMXadXDwiGodaTtLG8FgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcVDU3KJcuyjJIPSX/3cXxruQ64r6YR5eDr7gdSf7JU=;
 b=DJCQSAhnmB51xCkdRF/Z4i+BvYWw9Kt5hGSkAx5fWdVqNehquFUA1V1puduLsPc7LHZIOLUPTtQAFmWz3WSwMUG37A7otFnY/lX4EeCZqMUkcSYbJJO3LIqrnBRV1t9YMucnl/c7w55oRm2rkDWy907cxHY3uOIAYGSZpgBlKJw=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 04:23:14 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::e0) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Wed,
 10 Sep 2025 04:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 04:23:13 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:23:13 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] Documentation/amdgpu: Add Ryzen AI 330 series processor
Date: Tue, 9 Sep 2025 23:22:54 -0500
Message-ID: <20250910042254.3718982-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 533eddf9-ccc6-43d2-6f47-08ddf021c232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PYQ3fp5fqWSm/uaTzp6WgSeaUO4mign8XskmLEpaHjeBAspRXi00aNkOG2Bz?=
 =?us-ascii?Q?Nny+G3jeloVoox18Wwsr4LAhCUFA8xEzJVyMUI2f7ZEU3UBAvq/1c98GHZTt?=
 =?us-ascii?Q?nRu77SrgqdFwFGE5z0MIHvO8Wqb7YgosZCPXtH+mFBLb+fCWWxOmjPBOUBRJ?=
 =?us-ascii?Q?kTJmBqRhEDoD6quBIyui8BoO5cQ0eFYIvliqtx5rsja1TtFLJaWVdywPCWUY?=
 =?us-ascii?Q?cAVtcrZx93P2fnGELS3PazHifBolNISuKMa0i83sSGPZHW0ezyLGtn91DpH2?=
 =?us-ascii?Q?SrVShX5dArdoyQ0K+RUzknZjfeZhavvWgGK6IWDuTQIxqNDNvJ1j6z+NdViJ?=
 =?us-ascii?Q?9lw5wRosBL2P/eWOwrI3mW9HQIzpeMsLMrAb0iYTJ+MCnk+aMDy9FgXr50xK?=
 =?us-ascii?Q?xsZtwQFENdclUWSO9VA+W11vw/E6b/I43mTdyUbGMpctIBY+vjVckyo5lXVS?=
 =?us-ascii?Q?kOzl1adWBna4bI6CUZizu7FWC30Ucvn86w2EYho7NVo+BXI3J8ZCGaZk7Dfk?=
 =?us-ascii?Q?YDU4cNZezPbNrUIdloYX5BcqseknquNuUlMa+3EAQs7srUws4BleaJcDMf51?=
 =?us-ascii?Q?lotKzxUaOdsqy5r4uZblEVUPCiCMUIPPLUBUC7AdQOX+phfIGPtOPKv45jio?=
 =?us-ascii?Q?9M8wqsdXaFlUQT5OH1I9LpqjB3u4Z8ILtVhEzNDB1Go8gTdLtAnkqaINyVvL?=
 =?us-ascii?Q?dNWx6ackDEYZgjTf1Eh4teYrVYclig3P+cKvIUrzxtGKWLg8zVtBluixPg3i?=
 =?us-ascii?Q?v4cNeX9uFaAaZca0kMkn6ZaiMf4FnT6UbVpIMQejZhRUO6OXkjAlXRzSlCvY?=
 =?us-ascii?Q?EjB8empuyrIQQC0LWopAhW1EwF3X605IoUrpuTQQsrKtyUGPH0bKkZSfdV1b?=
 =?us-ascii?Q?Im+qmsbrFi4fKD92gaRekZ6ds9Si8o2Zei/7qqyJWBLj+QiPCJW2Ejpwg/mi?=
 =?us-ascii?Q?9+zb6ewyjXCEKmyMTyguYutn0HlC1WwhoCoOBFKGr8ILoU7K2YZ6aeCF+8jg?=
 =?us-ascii?Q?un9TrM+1b4bJiUS+CLhPLaMxIRBjH+ap4tkvbwbr2R9uNTXOL3+kXTDnQhQn?=
 =?us-ascii?Q?u+0+ZYLUJZQdJSRUdMz13ae6m+2tTY81w8YxJDctT3gm2ARCkO0Awr0KA1Cu?=
 =?us-ascii?Q?Ai+1xm1KTWoqyVh9NxzTmYuY4ZtsulUCTw6QKD5TySd34iucH9n3bBWlgJf+?=
 =?us-ascii?Q?aTuTcSQj+l5mXcbb7RR9tHCSe4F6wbin2vHQuaej13tbXNxwf3409QoCNRTK?=
 =?us-ascii?Q?/D4n1BtZ8c5Rc9tDqstWBgBLd5tth5SFVddCS2dQUanZ9q/9C9hTchMZVRj4?=
 =?us-ascii?Q?Lwt5unyywuni8y/mmqJH673d3ZlREYKW3mMu2J/eX2hl4T9T5rWigccIyXzg?=
 =?us-ascii?Q?IDykWWlQXcVhKftSRnm50ZRdWdoC+xsDgbdlE8YvJ6xbkjq1gGLdajuwPIih?=
 =?us-ascii?Q?qoWsdEbJapXQCf1wxowqUnEO4wlAY8R03JcDTHRpnXrLgUwloF2EBul/KcsP?=
 =?us-ascii?Q?o82v7TQXzYBsa+/OAJ45Rhy9Lv8kAmXup+xP843o5TpFJ1UMDy+oh3/VtA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 04:23:13.8717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533eddf9-ccc6-43d2-6f47-08ddf021c232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

From: "Mario Limonciello" <mario.limonciello@amd.com>

This has been announced so add to the table.

Link: https://www.amd.com/en/products/processors/laptop/ryzen/ai-300-series/amd-ryzen-ai-5-330.html
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index b479c5629146..dee5f663a47f 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -13,5 +13,6 @@ Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11, 13.0.4 / 13.0.11
 Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11, 13.0.4 / 13.0.11
 Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0, 14.0.0
+Ryzen AI 330 series, Krackan Point, 3.6.0, 11.5.3, 4.0.5, 6.1.3, 14.0.5, 14.0.5
 Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4, 14.0.4
 Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1, 14.0.1
-- 
2.49.0

