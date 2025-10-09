Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2B7CCD18C
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7849D10EAEB;
	Thu,  9 Oct 2025 18:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ShnUwJYc";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD75210EAEB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/Q6InyEqC3q/2oj5NIsOn9LAcS03LeEThIbcx1i6YEgINw4+HSWa/AEGiHK98h2DB2xAQaWc/UxGrMXOW+vAAwAxTjtNwEIgxDtmhNF7EFd3RTtv4hSgyrlhM/41KQuVlJW/w3UJwJWncDsLthGHZ2Yt5pCIXIi2g5UJfJfkm/2WcIOkjb44SBdkMnccyU/thqbUpoLb15TumzMjn5al/JIbPfztI2X5qriuPQKF/zMlp1rirOcg804rg4KyaUz+246i6KK6Ohw6kpr3HKwXyjK73Eewk2s23ckHZkigSQ1f8mz77LE/y+9Q0YSWObQuhHS6MWTXOXhotHXwUnUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCELykIS3Yr7h8sYd+GSOFRgOwkQiyFrvrCeLblh5f0=;
 b=UHCe/xZf+K4Wm0FQWDudFh7d9sLR/eaIXLgEnwU3rrB0saN9jXJDypw5UCAU3gilBbXcqRkWdHXstEOwrImipHAHTz+kRzWzifys2x6wHkMYM/0QKxA4xJKJev+qLYhfo0YUEZQDxYZJrHVfu/etYsBr4PVMjS6XWwKWtUWB0ssno0JueqaKYmwOOObEsFpO47Hk6/c0QwGrf2z7zCgOnXZLuneKGtpkZhCP/++eF0t+3Nq1CtS8pg0U6xW7YOb3lHS649Yc1QpsdSWW+pnjrVS7AK5hGBS+wkrroC3KNnqk5HpjVZY3bd9FSiBbxNyFyeT9/x7DLkndMnefUmr2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCELykIS3Yr7h8sYd+GSOFRgOwkQiyFrvrCeLblh5f0=;
 b=ShnUwJYcy6DHQRJixTAjqN8uePlWGnFSehJs0Ou09mxpH2UY9AraDbxx4Aa9vGC/Bw7YyFCCWPQ23+R75atnyxtNL2YL6spgvVWySOom/O+iqLjeMEPlPg7ZQLqB4EKXmR5RacmA1xA3LrnltBof/UNytLlt7sAMSqJT8mP41Fs=
Received: from MN2PR01CA0032.prod.exchangelabs.com (2603:10b6:208:10c::45) by
 SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 18:49:54 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::73) by MN2PR01CA0032.outlook.office365.com
 (2603:10b6:208:10c::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 18:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:54 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:52 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: fix gfx12 mes packet status return check
Date: Thu, 9 Oct 2025 14:49:24 -0400
Message-ID: <20251009184929.1038298-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009184929.1038298-1-jonathan.kim@amd.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: a4da60a5-5935-4508-0add-08de0764a2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FtUmKdRcNgElCWP4hpFy3e2srSFnQfYrK/RUE8TvNxGbShkLaRSh+o0PgUdE?=
 =?us-ascii?Q?it706BmdCYKvbh7/W4l6VlwsACNWWzf8gM/cQy3jvZlEPg2RmwvwhNSc6q6I?=
 =?us-ascii?Q?PbcgKgHQR0/J6vngJhihI3E6egvE/nevsdPRlXVKHCin/SslNZWbr4pGM7HO?=
 =?us-ascii?Q?4pxjIaKJnWD4RBGlV1JV0x4krpgjhGFd9XsWoxLDKHLeBjnTLYdHZGBKkgqV?=
 =?us-ascii?Q?dsMvHx1jr00nHc8xq6vZ1OPDTdIcgRG7JHxd9NXVvW3mXq63JeP8zbLiw8uU?=
 =?us-ascii?Q?a4ehBQk/KihWWEoGVbVudYTfVg/9Vl/o3OgzKAOm/oZWkIpGyBAc1Z2AXQmu?=
 =?us-ascii?Q?cLIFf7asUsnjFzqC+DdjiQN3hxpbQXxWZfO+vfjdjsfYjZ8dpLnKNUNMNCy3?=
 =?us-ascii?Q?0xV8HYNAl+DT9/d8j6DSRgW10Me7UqYHT+1eMJ244icUlnzBC3R7VhvyNPZg?=
 =?us-ascii?Q?JbYxtZI2hQHOPY+Ir/EK/OpE0YT1lGwWeGlnNNM84J8liRbBxZ4NNbxe0lzJ?=
 =?us-ascii?Q?PQ8Pc4z8MPfz8F9ghLbIU8+EYt++o2IwQevmm31tRwaBIFt5xtAxVlg5SejT?=
 =?us-ascii?Q?vzywzjx6OHP8quHKYVdPZkf49ShAjdAfj/C0e/HQFjCI5Q2TDdaASrP7w01R?=
 =?us-ascii?Q?QeGxzzgF0S7cGwxHSx59V2E/hbZWnsxVR4n3IiUw1es1XYVQ/PImaOMVyiCV?=
 =?us-ascii?Q?x2WgMikekiFFb4/sxRhBfe75VNe6ZIWIzQhjlkfOH/sQuARW9yFHZwYwiSfn?=
 =?us-ascii?Q?fS3/34LO4xCG++2bL3nOcaUjG7ZpBhiMAa6KoG1tK+r2knW0RtY6ntVe4vdg?=
 =?us-ascii?Q?wSa8Vg7WaUVH+tlUkNRYQGiFSlEozw93qvyfFFuIBz2+VPpuOthoPI2iZgo6?=
 =?us-ascii?Q?AuwgFXHFZl/15ayxKo8BIpD4xxZrA8RCTNWzZVvgzXrwZFyh2ZHqKYJt3fbK?=
 =?us-ascii?Q?ouDhKoSQNOwalh4+7SsuFdslrgtND8YhBvRH9rbUy0iXr02Xz6s8HcGQhnXz?=
 =?us-ascii?Q?F0E9OXOXevhRDg3OxxBuyk6yuAKuQcDvOeCQE5fTkHNk5lq7+I7RXudy3Lqi?=
 =?us-ascii?Q?RxEr0d0l2HmVG98AR/Sgd3qxU3x6dwg2CKclGTI0wBh8iPz+5NfyoLeI18kT?=
 =?us-ascii?Q?5i1n7mPV/sLwTgHRRZRjeDLnRDAU4aaIedgOQZbeAzSOO6vR1qjvKfVrgAyh?=
 =?us-ascii?Q?x6r2KhbGeA6j+47z2dTJuu6lcwqBHWKsESdwti/ma+/pomPPjZq+3idFyur8?=
 =?us-ascii?Q?JxvBhC94IsA1k3/1NDXx1l7ANYWmIGDghF9yIBeV8VDBopZjrodQPJQE2IRC?=
 =?us-ascii?Q?lpkeFEd32+meaHvrDzGbkZLYLdSc7QHQx6QbD797plt+mPD4EfhcGE7W07Oe?=
 =?us-ascii?Q?PK+OCj2kcu5UMZwJ3XeD9t6gDTcU8A6yo7Ymo/lac9hS9o6k89sqEQkCJ/at?=
 =?us-ascii?Q?huq+ufHLlSYD6Ojh6XIham7EEZDQisf6jATskw0oL2kdfR2CL4Sip5rNlNDB?=
 =?us-ascii?Q?xbpRjaPQE/BPiHuWpUI55CpXTKaN1wLiFMqA3w4y/fTwP5n9Sfa74C/PFz7a?=
 =?us-ascii?Q?D8uy1tC3bjDD/RLCL6U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:54.2740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da60a5-5935-4508-0add-08de0764a2d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
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

GFX12 MES uses low 32 bits of status return for success (1 or 0)
and high bits for debug information if low bits are 0.

GFX11 MES doesn't do this so checking full 64-bit status return
for 1 or 0 is still valid.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index aff06f06aeee..be8a352f9771 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -228,7 +228,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !*status_ptr) {
+	if (r < 1 || !(*status_ptr & 0xffffffff)) {
 
 		if (misc_op_str)
 			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
-- 
2.34.1

