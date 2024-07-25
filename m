Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F79AC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB2410E841;
	Thu, 25 Jul 2024 15:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYEzL35C";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA7D10E29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKgNB8s8UEYdu9xW7ceH9wIqrAb3n6SCJkYEUm9OuYSOEJkIRG3sIcAvS2cV46N8xZS05tqg0Thar/qnq2/mcPKVVD1XYnqDfiGmnXsWATuoMsCH+GYlTf8zH2NCAoLzngG5n9T1uZg1r9Iio5tMSYoTUOJbcuF46qPTZvLk0Kd0dK61HUbjMK7xFX9rVDz6bGsDJYQSyzuNa/NFF1hIP5CQ3lq1ibtBTCPKMD6wVub7BNC48JE2vPNr8ebCv6G2VMRKNV/D0AspM4UVjaovmqoxLqJQpVVScXdTPLn00DKLa2SJU5F9zMsNZcwhvfxzLNmCZFfinMMST0m9NQejYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pqEZSmP1B6EuYeXjR7lELnQEQ8rQVrAuF9wD/n1TWA=;
 b=SEfFDv0ho/TjmlIdMpAXYj1QYBlwYWdNc4aE94CE3r/g4MVDPXFD8STHYj93Uut0HwUvRKtu0CAskyhd2URXAaKiAXodLR6YDPmVtkSl4XN5t436c7qgB8sMnlC9vW/BNzrObmLebGWJlPc1I+11/kRP/fO1fhxHqVGYd178XtF85ZBUrmoLelDW5GW6Hkm3/B3WeJneDqUiQr2BH278F/92TEf3sFM8p5cAiQ9C3QJzDcFC8vb5qLY5YJRSPXZp8h7x53YGvI9oUSv0nyMRGCXPg9clzh83QkWXJ7SnYxMgEZ2WMNIhjLF0BGJQ8Mqj4juy20o3wBBvo7IBPOyHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pqEZSmP1B6EuYeXjR7lELnQEQ8rQVrAuF9wD/n1TWA=;
 b=ZYEzL35CGI1NTzCoetlHMV8u9MeFaELWI0sA7Svef0fHFwEeJZ5AquYMoZXWXcWc2CVf6cQeF4INtDAoNkYYu9PlnGRAWGe/NbYG5NH/72sAuJmpivoRpImWJus/91mTg0Qm1fa8/vy/V0z5mrhC/sSmEpJ7CgJLtpU9D1Kfn4U=
Received: from SJ0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:33b::8)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:13 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::65) by SJ0PR05CA0003.outlook.office365.com
 (2603:10b6:a03:33b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/53] drm/amdgpu/mes11: handle second gfx pipe
Date: Thu, 25 Jul 2024 11:00:04 -0400
Message-ID: <20240725150055.1991893-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c54ac2-ca3b-46db-d199-08dcacbaa039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PImBm4mvl0vrwWfBnRE7KjS0a3l7xH76b/0dovYj75hZmv8Xyt0/qPMXr2dH?=
 =?us-ascii?Q?xq8Kf9jowCDsVDaSAqnbT53qpwVLtm081E7GE8FMu+BC0l6swpYFOuQTCFNY?=
 =?us-ascii?Q?H4GfKmiXY89GGEq/A0X+8gsr3IDodP/McnHb0Egad9TqiIsXIYFsK3m9ynr2?=
 =?us-ascii?Q?GzwvUU+gwTmU2LvyOYBbBiChh7qYMy1CPP9JA9iZEmGssR4JB2PoDFlDBhWf?=
 =?us-ascii?Q?xqvn5gWYVCH0b3UdoLBVtlWx0x9LqRf11NxtYPuuiGDGaRXZO3Kou4tDeS3o?=
 =?us-ascii?Q?oFauBqlPXDkUYB/bCC6sFoIFM7mzlFTixi9iFfEu1cvvUZWTRTF6EdOXHgst?=
 =?us-ascii?Q?nedVpHrG3cUeClGZEyTuhMY4fH2mHQgSz2UpskMpravPgF4LSaaLzUtP9KtK?=
 =?us-ascii?Q?Pv5vwyzot+hGMtQsF588VIACvaOP0BNIB72vPKxoTnRi6wH+1kElF10n9VC/?=
 =?us-ascii?Q?dlorx9AR2CB5y/HZVH5Rxe4EarKTllKPtHU8wBwQHeoJi9sfCWcGXcyMjTEC?=
 =?us-ascii?Q?iRYa3amifmolsKb0JdOlYrql689dDp64bZ6iF/UlXWBP4SPky2JhpSPZ8REV?=
 =?us-ascii?Q?M6zmpJd2U/OoXU978sVbkva/UmDX3MjIq6OCN7OUWNEelt5i9R8jaPGeUoTt?=
 =?us-ascii?Q?0Zd3rIO+e9OMpuX/TDAfrw+62fcqQ/v3IbJpkcrNU1vuWg3lStitHMh2uY8Z?=
 =?us-ascii?Q?v0A4cTLPOxmCxq8md8ZtwFsLz1b5uL3OTKtXjgF9ywk5zwGPt2ILljyptWGK?=
 =?us-ascii?Q?FqK77HyBQgB1ZhniJwfrkXtjDPWb5Z5KdX5rmzHga3iAautWfIn7PWAha1TX?=
 =?us-ascii?Q?rgSXLSSJ4oRqJaLs3pWyfshNwpva1i/2Q3jUWD83/ckC8zXVi2HIYQ5Yi6UO?=
 =?us-ascii?Q?EwXoRb51auCjJAeUBXXlBEXENMD910LVGfOmO8n5R3chiOnTxQZkANiplLv7?=
 =?us-ascii?Q?9UT5lO1/DkA8OxQrtlYlPAF3R5woILXMTsl7leyEooWsfptESUmsMss/F7Ty?=
 =?us-ascii?Q?TCc6COoAWBtmCYamSyu9ZevcVUmqZ2AqNjexoTCfb/TGGxxnvabT9oplfvva?=
 =?us-ascii?Q?9xBx9uMQ8TkQanR5EGwWL06qhkmPeM1wisEX4CYGkAMel10DEPNRi1M/NVp1?=
 =?us-ascii?Q?Na7UbcPp5pZ8GZcuHwKXClQC93zvoOPoQYMmAMgeENmqHHyTMaMMxqPN23+n?=
 =?us-ascii?Q?Xdqxd2P4PA4frfeYF21nwYT3VoZaw4N/j/Q9NW38Fp7SHQRXH2k1rjxtELp3?=
 =?us-ascii?Q?RhfwpQK+qyUjMTu0h9OTUxn3LpTg/8Qzw9N4+GiImCE/1CIxOg/ZG7xTkHAv?=
 =?us-ascii?Q?XgjgMUKKuzk/7u3Zg4EXex88VAoeNaVXCrkldz97VS3dRYt3WaiL+JTqkZXp?=
 =?us-ascii?Q?4srkBgTy7WtdUphkczVWQGdK92J37s5od6MmilSzk/zNvhqWnlolXFFAABn3?=
 =?us-ascii?Q?eyilnDaKUroLrExtUK9WlOS6SoJNk9Cn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:13.0556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c54ac2-ca3b-46db-d199-08dcacbaa039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

Handle the second pipe in mes_v11_0_set_hw_resources().

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 68c74adf79f1..218323e59f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -554,6 +554,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.second_gfx_pipe_enabled =
+		(adev->gfx.me.num_pipe_per_me > 1);
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
-- 
2.45.2

