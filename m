Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A70C369C9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 14:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C0310EB3D;
	Thu, 17 Apr 2025 14:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HChBkOAH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B99A10EB3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 14:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha1z+ZpuoupRaj9KtYY5AapS7sR0MwVAimjGELrIrt92a/s9nIovMCldhc7z4x6jXRGEuUtqYbmRv7akRiEDhhiVR5JyR47+DsJsUSeXygwYrKz5A/jG12G+EqIfhOSuwMWUH5tQj2utR6AouKl0WiAevBn9DINMK7P+sZTXnhLWgw5M7cyPTlV1RbesCbaivwyZKhjpMxjDKvqCv6nl/dKvhOBvza2fl3LcfSCedQsds3eN0A3g5tZNhQk6TGS32+RM/+/w6lNLWW5kbJ4LMZGdWzNvSm6grBv2/Asx8Nve5yvt/CWJAekvlKqZwahXu4G9fjJiNIysI9QjMe9LRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdx19w4g67x+IUbmVpXvYSafAPchc5iCwnTlzJY+eoU=;
 b=Y49YWUeGKHn/2wkP5NAAsrwQ1TUNnccyFjfM1i4P7uT8kXVCEmbJKl5Q2XNgnRAw398rnDSenlZH4sxuoztRRIUMXowk79VyY9DcG28AjrsfADZDSxT2G0n2p5dFfW8G2Rjaqfh+Mh1ZEM8SPYlxdFW/PmryQ48u0W+/yFdJIbaJU4/sXbEjJZa8+xZKksof0o8K7H5vdu3UTWgu3P5cMrd4uSQ0GQoxvXFDQ820QZ94tMcuRNHpT1mnCHZDhM5nHaYi08X/L0ALlOL7Hvu8xw0302P3ukGk7rRfxemsIov7DsHoZOvGgOUUwZ81COyHDTKz1vOWfosJbHYomJV2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdx19w4g67x+IUbmVpXvYSafAPchc5iCwnTlzJY+eoU=;
 b=HChBkOAHLBcW0sEDMxvty/bne98u8tw4MKb7aX4fa1anK9oCwNBO+Ta8CVNFeacyNmZonYYk5wY5xra6Nl8ya09hbp145t63h8XQmSsi1QMDqDrS2O/QWjKPzFH5DfFjbh+ITQvaP+sIhSyoJ+Pw4yEMQeQ5iex7ILMUxaGj768=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 14:52:18 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::86) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Thu,
 17 Apr 2025 14:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 14:52:18 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 09:52:15 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu: Don't pin VRAM without DMABUF_MOVE_NOTIFY
Date: Thu, 17 Apr 2025 10:51:49 -0400
Message-ID: <20250417145151.1275415-2-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417145151.1275415-1-felix.kuehling@amd.com>
References: <20250417145151.1275415-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: ea453f4d-9d1b-4520-f485-08dd7dbf736f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TAQdislTgdJqTTr187NpiKVuwcK2mcsPZqW7hFs6DiSLsqnLt+B6elUyzFZv?=
 =?us-ascii?Q?MEmwLz8RVTGgRtjW23PPBgU0138TJ4xvleD4KgWVCuAS0psoaq+WfRRSb/YY?=
 =?us-ascii?Q?8nPUpX66GK8DKqoIChKeHfam0bYjfrDma6t7eNRCKO5gbySkXrBYiLEj2jX6?=
 =?us-ascii?Q?W+ukEXVPw0+iEhxWnDLHIpttkLeAKfwjNwwpby+OPGWcLlFxVbLxREkRcXPf?=
 =?us-ascii?Q?ubuEAKJ1dC7hu6Mz+N+U2waVk5hWIOWsHOz4k1dQ0l8cnkuU3xLIcQ8HReOk?=
 =?us-ascii?Q?push1HOorttKjfJHtrZj0MzW12EsNbXr8V141fnaD27xP4fnJDUtl0WMWnzk?=
 =?us-ascii?Q?Vrpsage/OngZOozzI0Uu61hcpQZgoHQ2gya475ExpPdj2u2JRRFWONVORdyk?=
 =?us-ascii?Q?k4uK1Qn48OYeZooe2CGm75TW+RKmY3pJdOO0fyNGzEeSRe4UHXIIq8hgZ/XA?=
 =?us-ascii?Q?fq9DF5CFoJ6UCxO8ioCy0IsqWdwM0gDHmbBxm5Eym1H2xdf26kiJ7CacZgvs?=
 =?us-ascii?Q?74rdnEb4fM/KBW+dxuANFzs9rxXRuTYvFuJCfG78roWrilyKStMwjY66NkQq?=
 =?us-ascii?Q?isR2Atb6KMZut4E84nT97vRap0utgdb4mU/vp1ieBQkCSHdn3QCoP+4WIUwN?=
 =?us-ascii?Q?BUvqFTJLxtzQv1NRuiHvO/RHIihPsIwnyiCyjCsQQykmywy/ugB9fSlej7Zm?=
 =?us-ascii?Q?IQUbHVy7hSeuvmOzLptJ+B7t3f+X9koX5TV6RW8Lfyes8D2CrLN7/cL51uv8?=
 =?us-ascii?Q?YMjdS19JzK8NuCg2HOS1PdfGSVIBaIe8/i3CAFDi5ynd9fQIbjtycFGq1I2c?=
 =?us-ascii?Q?2dW8IqU3reeQE4S2lktnd/E2bNDFA86oFEpXXzEp7fNU6SlB+s4n06UXwv0p?=
 =?us-ascii?Q?GB+qcbFixOQrJ21RgulgS9bQP4LJ52M8f6+zfkOvRRAKdSoZbTtTWrTrgReR?=
 =?us-ascii?Q?7QkwQ7y9145eXKqB82TEgmDnuxP7jFxjEQuUztqNacl7OxvydzgtJP5Yq79d?=
 =?us-ascii?Q?ktp7MSnWOZkcevrrorGUuUy7dkmEBjEwI4+Yoh9ZoIU2WbaIXG6wJumS95eb?=
 =?us-ascii?Q?BKfjDe7zMV5eR2b6tqIra6WWvShDVoQfZvlisSL7ZQPVQoOzgzMQK4Pbr9/W?=
 =?us-ascii?Q?x+eFfIVonafP8WxDbJ6ZiVrT4o0Q07EUPwQCKct8m1LV3MHm/fPW8xOUpr5z?=
 =?us-ascii?Q?Q0+2bO/BGBRKmY1GC0WLqrmD0QrV4QO+Bfj9TWRbkR0XVKxV7FqdNeOlq2SR?=
 =?us-ascii?Q?izX77H0qTY/TM7qfQaoUO/WEmRdYj3TXfx5kVLPfVbkc7oUfpik1czLJfLZk?=
 =?us-ascii?Q?CIm3YQDgyJhG2DGBQaBTxkVlqwrPht29Le9X5giztLS7lW7861WX2WTwOSHW?=
 =?us-ascii?Q?xdfD7/8hW5XYzuoh3zzuJ7lXtbGrW/k+Olk8/8KFMfq6UQCZL1xO++FGnTDp?=
 =?us-ascii?Q?KHlGU5oqTuKRhOHPSkPdgd6RdAK2U+0AIAaC0JLHPi0JsFmKXR5zxHAy/YeJ?=
 =?us-ascii?Q?7GvkdSASRFPpOvrwqd+X272oCdaLQYwsa8Mk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:52:18.3858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea453f4d-9d1b-4520-f485-08dd7dbf736f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
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

Pinning of VRAM is for peer devices that don't support dynamic attachment
and move notifiers. But it requires that all such peer devices are able to
access VRAM via PCIe P2P. Any device without P2P access requires migration
to GTT, which fails if the memory is already pinned for another peer
device.

Sharing between GPUs should not require pinning in VRAM. However, if
DMABUF_MOVE_NOTIFY is disabled in the kernel build, even DMABufs shared
between GPUs must be pinned, which can lead to failures and functional
regressions on systems where some peer GPUs are not P2P accessible.

Disable VRAM pinning if move notifiers are disabled in the kernel build
to fix regressions when sharing BOs between GPUs.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 0446586bd5a7..5740e8d1a522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -81,14 +81,21 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 
 	dma_resv_assert_held(dmabuf->resv);
 
-	/*
-	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
+	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
 	 * support if all attachments can do P2P. If any attachment can't do
 	 * P2P just pin into GTT instead.
+	 *
+	 * To avoid with conflicting pinnings between GPUs and RDMA when move
+	 * notifiers are disabled, only allow pinning in VRAM when move
+	 * notiers are enabled.
 	 */
-	list_for_each_entry(attach, &dmabuf->attachments, node)
-		if (!attach->peer2peer)
-			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+	if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
+		domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+	} else {
+		list_for_each_entry(attach, &dmabuf->attachments, node)
+			if (!attach->peer2peer)
+				domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+	}
 
 	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-- 
2.34.1

