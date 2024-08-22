Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4864C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 19:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8716810EBD8;
	Thu, 22 Aug 2024 19:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWKGrPH8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A4310EBD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 19:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG2pItlK1dgtrL+9bJlNHXuaUSfPj9nOvj+je3GSMJKe5QWvQXeUWlw+g0v/aXh2+wj7JCK1uTzcjb5zbBNjPxXkGmUlpwij/s3QUEpWzKJVVEX87C99P0p6TvE0vtc5CvJn1o3N+ypG6csHWuP2Z0Thw+oCDhYBubk3/PxZBpdTuKwdInXDYjeF5/g226kfdsWAK/qNwrHZGM2bZ8GkayNNwquOSXkT1v7IP6X0+RiVatFTV8dgO8nVF3or9NqaYgmQsVZ33DNBO16WbhFBuS9I/qrBt4dzWc9PfH1giBXbQ4PbxyBv5rUn1Z5Wg3f3msxekXdquPLdbdad4ReWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l/6YxiqCl2a1VOmXTJmiA23zlbw5AJu/1R8P5vKcF8=;
 b=Y7epEYvg2+6T0ALKI8gIeFq0Gi5gIU8VWmMjj8NlwOvIhGhW8x2z1/myhvaKbVPFVsS5wGPkYnCwnzUTBj9j7SMZrENnwtC0z4bC0bFH4HkudquULlp98Vd/wmkgOvpN3vDPNtpcrANJFWAtsjWhmFl2Ws69Lv95tBFDnQV0B6+7VtAz0UT8PdutqzAFzR/BsCeotvZNxCzMolfdpBUZiigL7Ym5eBrPYJOS0/OjLkNpzak6Ezqnjfrhzub2dOgAhr2hPzcz3Bxj2RB7bbMUn7KCoXqK/+/JmBxCXKympZ1ZO+J4epvu8PoFcrTRIotW7YLHqwVjyc43MgUbclmtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l/6YxiqCl2a1VOmXTJmiA23zlbw5AJu/1R8P5vKcF8=;
 b=nWKGrPH8whN0ieTw26UXlLD1CM+bnoL2IMOc7N+7owFYd4pva4tocGPU0MttT2CYHA2J0dEvwjf0g0URHnimpTnXHbbrRryxwprANKxtPITtDioANKbjGcDjEnBqDO/lZX533rFYRbWDpu4NfHIrYmnkGniQ+sdE5Ch+t5J/IEk=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 19:15:22 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::b9) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 19:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 19:15:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 14:15:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 14:15:20 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 Aug 2024 14:15:20 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <jirislaby@kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <roman.li@amd.com>, <hamza.mahfooz@amd.com>, <wayne.lin@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 0/2] Fix for lightup issue on Lenovo 4k60 HDMI
Date: Thu, 22 Aug 2024 15:14:15 -0400
Message-ID: <20240822191417.622336-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: d8836011-f8a8-4d97-3e1f-08dcc2dec50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KOo2lLpCDB+WySRfl+HV/b1jA7ueq3+N59yM+gagdUj5X8Mb6tRcb0d4Prmu?=
 =?us-ascii?Q?cUZJcNlVnGvcyCoHV+styunJnlDMjIpVSLUUVgICO2SCmx3BctLn3xzn82wE?=
 =?us-ascii?Q?lqB4Wk9BfLiwptcIyDjpyVUh7tOGVXPR8gLu2nh+MBvN9k9OFrejJcS34ihP?=
 =?us-ascii?Q?z7mjNMEZ8sgyNNqR+T3UySD8psdCerTTIoTKAh/no0/EAZmXTiyuwvv9euW4?=
 =?us-ascii?Q?OKTcWcm0ijmq3CjN+3jqgzNWU0DF162b6EUQL3ozYUyywaGwwzEp6e4A5fT+?=
 =?us-ascii?Q?WFKNY95pgTmW9I762jX7wJPvAMwwTVCK8Fll9GzVEaO61mspY3rvNCeARTvn?=
 =?us-ascii?Q?C9R4MYEzq0kQaW3VaUNmgdmMmHfWU98b0b6nzUdYH81rYsd5JLVB6/m+gmLP?=
 =?us-ascii?Q?mHGaSUW0X6hbGFBNumHk/POA2jhnvLTWfj3nLvWxT32cokrukYt5ISViWK5q?=
 =?us-ascii?Q?Yw74q9GVrts/96Axzq4aw5Y9QSNSKQpta+bymM2Wn8ZmukannVxay293JjJ+?=
 =?us-ascii?Q?c2w3Polzs96ebACH3W5XrQTCIOKreKwXsj0vb/faI4+S1WJQ9z0kiifoWmtv?=
 =?us-ascii?Q?vLIy2YUEnVDJzlBKFlHQEAem8aINEfjln34g4q9jIIytQqHj/xp0tNQbjWlv?=
 =?us-ascii?Q?cQetKgfNJCHSOZL/ncUCtV6jEwap8a+vRbSTa9dO3BQ3FSp8L3wpmjGoqDyt?=
 =?us-ascii?Q?DP8bYu3i2hJnqP4fzcIIKtUq6S+nU6i9Zk2A6QPgdhLU8FK9592RZcQfOasD?=
 =?us-ascii?Q?tIikCM3oAU9pESavT4KEnTUcI4kjbH4s0xyUPFgTd1aO1tOhHNicTiU4zgzd?=
 =?us-ascii?Q?0STkZHe7ohMYUyibMHSExAZ9kkZ1pV0+L9mlXizensgVa5ZAcPY9AcxMr/b8?=
 =?us-ascii?Q?IKqmqM51BC8bgSvhRQtLkUnM/eQ6+58f+HwBH3GtT1oG6VM+PutD2iTEW5O1?=
 =?us-ascii?Q?mgqoViXSxz8za+hLQzVPzz4cGqlDYtBzVrQqGvsXEQnTuPuLtj4Ih6bGcj4V?=
 =?us-ascii?Q?6uM2o/mdVldPAsNTykG2+YwK1MQuO4iLPtWmhUN+faBDWGWfDKZLDNUJ7Bqw?=
 =?us-ascii?Q?g4iSRoMACdUOCQMa1UmczsYE/r2M9iN/ljqQK0RhIxlSf1h7gkg750B0pdH6?=
 =?us-ascii?Q?GweLFrYxNiq+tiIiTk3WBcyKMzhfTtA39WUo0yu+/0BboDJdudBXy44Lmd9U?=
 =?us-ascii?Q?O6ux8TC255BtukaXJh2SGgO+v00QgiBKIGV41hJootYrzfjpEguwpNEu+bE9?=
 =?us-ascii?Q?ydlrjb0jv4cepSJ44stCxOecik0m/Efvlpkc/tXgqm1fvLsSpeh1JyxrR9rc?=
 =?us-ascii?Q?esCYZ5HX8qmQrKaHmzfNs1V8ZTFXU8coq3gc4TmvLBAnJ0fmmPrJPM1s9iEX?=
 =?us-ascii?Q?C8AjNvNrdPLq6dBlrlvtstqllza2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:15:22.3559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8836011-f8a8-4d97-3e1f-08dcc2dec50e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

338567d176 ("drm/amd/display: Fix MST BW calculation Regression") has been merged
with a mistake being fixed by "drm/amd/display: Fix a mistake in revert commit"
 
Fix dsc enablement for Synaptics Cascaded Panamera hub is included in
"drm/amd/display: Fix Synaptics Cascaded DSC Determination"

Please apply the two patches on
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next,
and give a sanity test on 4k60 over Lenovo HDMI output.

Fangzhi Zuo (2):
  drm/amd/display: Fix a mistake in revert commit
  drm/amd/display: Fix Synaptics Cascaded DSC Determination

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

