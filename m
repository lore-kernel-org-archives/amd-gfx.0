Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D6C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 12:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A5D10E141;
	Thu, 20 Feb 2025 12:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+gewikH";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D149D10E141
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 12:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyZW29scvmKEw96JwNKT9cYSpfO5m6rS0W5zg2oHJko+4B8pTrcFARL9Np8MKq8tClUo8ezks0iaH4I9Rttxm8UxLoTCeczzicJ4NgfnnE4SLy0JM/JPUiwsi5UaYpyAJQTEUwF+p0fHtO5z9BOMZ8s4XC8iFSzUzj6jp9S6j7rVekhuj2kPRFJy7xM7fugLmoMAyVN/6bvH8Y2YKC2FK+w0UXKNu/ZSpiJ9xzCWGdt3WwuENHZSpsiS5JGO9jiqBHR5MEjPATyndG85bngS4EkQVOb1YG5MAVlxskyBdljxfd++8+1CKvvfy96Ar3kWcC0MYDLI5RkN9dbS/paYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4kyQTJAOmG395fSsiFXnl5mEA90/kZQgHCu6Ysd3H8=;
 b=KNb+QdC3atgQIMUa+r6M2c0ArkY8WB4S9Q64VGBe98RrFdjHBk30Grwo+hmjfHnTj4K/bYw+7PSySkVwOjUxXMH2UTqFmbtGGMX4hq5xnNsglZW3oPXywl+ohOZMxWKvKbeK274DK15iPw7turK2sgj0bQUsJf+8HNf70EscveS7FplustyTVMntQOO24Wpy5h8rvNIK+4glrFmarkpJqvgxRfa0QuFtdfkGFFdrMQ8CdrVml+9Vg5ARV8Ja3yN/qyvRGq1gom2P/XdsHPSGXIWTujvnEqtR+4qZex9EOA1ierzXWITpYqfQX8WIF2VMbueTELEoF78zZ52m++BOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4kyQTJAOmG395fSsiFXnl5mEA90/kZQgHCu6Ysd3H8=;
 b=f+gewikHqD9k9q2qQrqdOcHLqV3r5z4ITOdIqGqJiH5UfMBItQpmRt1XsN2GTRIxBPgK0I7J+ZwZoTrz76x42aDnchifb4aRFPzP7Z9UF30jbj14JGz+EMt9ACc1ldAI/Y5CJBf6guTa3cps/Dgxo8KjyQBS/FLeIbcuICO0pC4=
Received: from DS7PR05CA0017.namprd05.prod.outlook.com (2603:10b6:5:3b9::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 12:00:19 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::37) by DS7PR05CA0017.outlook.office365.com
 (2603:10b6:5:3b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 12:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 12:00:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 06:00:16 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 06:00:15 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: Don't over commit vram while xnack is off
Date: Thu, 20 Feb 2025 20:00:13 +0800
Message-ID: <20250220120013.2051240-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f61427e-9a9f-4d2d-2dcf-08dd51a62482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nVEDn/VrLQLEILTmPmevg2ZjEjllLOcTcFSbMzXZCW1xhuV6g7KZGETBncm?=
 =?us-ascii?Q?BxfaugdvPwgzIDXiOJVa9/InIU7jqUNJYVztzidd/s8EvIE6h3ZhHL+j6y+/?=
 =?us-ascii?Q?RE17r1Zy8Yyz7/1wYX9Q1Q6RgrdO3KX9OwhxiPBHLA+qDUY0cKwOQq8ZcTOm?=
 =?us-ascii?Q?dpmmp+gq8chHA0VEW7Oa6QJpIqNcB6EDkIk9jfN2TODvsl+TosNiN6F98JJT?=
 =?us-ascii?Q?LdYFYtZV7dhP8SI5mCvJdjRFRW6sfXu3UC0rbIrGAy7074IuKk11ji3Y8GJ1?=
 =?us-ascii?Q?/k2YI3Z5iZGQqZgXWD9ncmoZjxBxtyCgwO4cSu7IFLkvSk3tSf356JF26IKi?=
 =?us-ascii?Q?5UEBFe5Ln5ypgPHyK/Od+myxyhyBcHTygxWmnKuqxa65DbKH+6gHL7t+2Mol?=
 =?us-ascii?Q?+/0laO5VxTrxaNNvX+SMU5mJntZ0hrCbARHYmbWIraLppli3MGP3YcarPZzn?=
 =?us-ascii?Q?SjzzwhRdDFtRnGHlQyYSvtxh9jLOyFniCIrY3hPjkYqPgClNvQoMSQyhKBHr?=
 =?us-ascii?Q?pVrQ1K2CcxTPHq9sa3DTGJwlfHx+BLZj3YfsPARQVjLwhWr4ZY0ZtAIshecD?=
 =?us-ascii?Q?hJyyQjTPFXRxxWOwE29U+/WM6/cY+vmKHwSx4S96w+LkMAH2S3WYqVVs/wm8?=
 =?us-ascii?Q?q5Tg272y/69QErZ7SBVIE9krIkMH7xMn/S3/AnOGK/16fXfbd4Zj0ZF9P3QK?=
 =?us-ascii?Q?nhSO7ZvGStTHZ1YyQM4imvBDZgfyGD4AeQ6ufTTWbcgR9kBVh5pboDlU8M9t?=
 =?us-ascii?Q?jfWa8Xxk4t8LDANvCcvEs6WDG0KXIp+/LLkKFf2yN8WvgEbAsIM+SMQrtYL5?=
 =?us-ascii?Q?5zVhHGZGITjIG3obhEdAXPlI3eaHnOC5788RNbrq4JyXD8QRl3g1WA2GVux0?=
 =?us-ascii?Q?2yMxmSxawbN4G6EqAZWODsN/B+WAjbG1TSon6WL2/LyMwHVmi/ei4dnrOlxm?=
 =?us-ascii?Q?5aH1o6R/WgKzTrFYbXbxnE76PJEpLOn8wdCLmdS0hy2dXw3RNNSnf1tHW1Zn?=
 =?us-ascii?Q?X9xsf0rVLQmXRfXWdN09wdF342NXHfYJjyO1W9mZ7R80wnyR176Q0SlxEGmJ?=
 =?us-ascii?Q?3ee3ZieTcip1K7Tr8CdtTgwUU084HemCP+x2Q70SX3kVkqHZM9AQb2q+CZRP?=
 =?us-ascii?Q?zLbYUy2Zvm43GNUuBpMFNicr6wWVJXOipmcE9etr2z+HAWwDGcioY1JHuXn3?=
 =?us-ascii?Q?Wf4zGF0jKyRvwnkc6lDPYtffnKqzMuvtt90H3/qohSD9NJPk2SKDN37f5WhH?=
 =?us-ascii?Q?DuVxSEaSYhM2Aa7rYoFn44DwS8LmyGyCE+YMtU57eSXhleFAfG+uEZlsQhXw?=
 =?us-ascii?Q?LOdqJaE1qBvVonyW3ZXfbc7HQ8cLO+JSPagOgmwoYJ2249dJE26U2DdDjb1k?=
 =?us-ascii?Q?m69kicIyPbKWVllSlbzbCJJevsoYJHO6aazBosSRymaW/+x6UCKSL+7ZZFVe?=
 =?us-ascii?Q?MhBBPecRUdqL0RdQPvKqscw0Cj/QDl8I18HBEcOZzo7HOX9glffGPS8BPkVU?=
 =?us-ascii?Q?/1mo+KrOFo1ZUM0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:00:17.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f61427e-9a9f-4d2d-2dcf-08dd51a62482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
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

For xnack is off, the application should ensure the vram not overcommit.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..1aad27994452 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -171,11 +171,17 @@ static void amdkfd_fence_release(struct dma_fence *f)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
+	struct kfd_process *p;
 
 	if (!fence)
 		return false;
 	else if (fence->mm == mm  && !fence->svm_bo)
 		return true;
+	else if (fence->svm_bo) {
+		p = kfd_lookup_process_by_mm(mm);
+		if (p && !p->xnack_enabled)
+			return true;
+	}
 
 	return false;
 }
-- 
2.36.1

