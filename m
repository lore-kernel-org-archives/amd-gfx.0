Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A929E6917F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 16:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4309F10EC0B;
	Fri, 22 Nov 2024 16:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLXD1EaV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3151110EC0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 16:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUxfC1LvTQuTEsmwUumsm4UrHilP0UsRrzDXYZ/UFesMbLgkLYixm88HmLwwjcp8ut5xPr5Dj8U3Xjig0FjpDe7zeGSb79gMm/16Jnt6/d68H/e47EuIg2Ce3OuLYHV6BH7BqixvZystE0Ah6tVhiICjI6VpqWZuLELPKu5GKnZNr6b4kvf+RFdz54FVfq8iTRV/zpdbIe3y0hjCKb0naQdyByVFVT13EaGUZf48eUGzm9v450vqhQbF0/0GrmZb1+id+Sn6WAiZWfR3UGifRnc/Zlbkd0i05Ocx+Cq76FvhA3shA3vRdxYCzbZwfC+AxW2xUw1+0rsUwT8m890Big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drRasaNpoN0yWkZjVhz0xoUkm0bDxASduKLOlgjJfoQ=;
 b=L/T8mpNHF9DTo/s3ChLji2/MDu8kdvWLRk8/3Iz99oKF2f/rWIvT7N3EESE4rYtwLV/uS8PnAbn5sF/t4boz0pJbVQviMt4HM2xAvV65Sula/GhiHQwoAc63sAevDvEy/59PTqNvGj09lXCy/5RN8z93jfMkuH0l2LN5YCnftGWKGzdancCu9qrifIOKlaXY2wY8bDDl5xYR5+Iv5oBeP897azosOs19EBLlWbahhAnaqAfA0YNcEmmR4dFgzEuwnzZR68J/q+rmXtPAretJoFqcYN3kLZPLIh/xtMl5S13ly3OcXNuA+gJIhstXNU+j4n+0z4OiANoHo9nurFgtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drRasaNpoN0yWkZjVhz0xoUkm0bDxASduKLOlgjJfoQ=;
 b=FLXD1EaVupy++BlzJRvJpFLlIS3bQnW7jrzzOuKV+W3WZVlQFs65kkBeGpqyPkyflXpxv6xolMTrAKbxhp3WTZaaTY+8MCUo5vWgAYyw0NwzBSf+74GRRcqj04IShHPgIdBoBrITeAhqWaEGCqoeK68L2iFlkbCsmwSS7acHvVo=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 16:27:19 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a6) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Fri, 22 Nov 2024 16:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 16:27:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 10:27:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Belanger
 <david.belanger@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/hdp5.2: do a posting read when flushing HDP
Date: Fri, 22 Nov 2024 11:26:55 -0500
Message-ID: <20241122162657.1056489-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122162657.1056489-1-alexander.deucher@amd.com>
References: <20241122162657.1056489-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b11b8f-f005-4582-263f-08dd0b1288ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WrefXvz/pmvviISk6QhAY8VgioLzLNJdAnb0IIvvQWB66ugRFRonfYC1Ucc0?=
 =?us-ascii?Q?TpoIYVL0+Jf34NKyhRO/Aj6GWZrLMMqf6OTXKQpkuatby5BgYlWDyH3y9tAK?=
 =?us-ascii?Q?Y8Eb5cdU0cJ7o0cAsoU7F8rXdgWxJt/7UTmaLZWhBAQWEynJOhNU8bu3WcCv?=
 =?us-ascii?Q?v9s1WunEFTx2831+mSNZaaqivQZvflOKhHD381u/1O4LL6z+FT1n2qbhwnKu?=
 =?us-ascii?Q?xmr5u/6uCvlLHs6dOG6ahfjFFldZzMllaFqREF1lTiLsmgUEpWF+ebo1LV/0?=
 =?us-ascii?Q?64ucv+a2TIOp2UKsHcxe2e+HrhJw380JAaqUZqj/L05OZOSXmNg+TD5eMywz?=
 =?us-ascii?Q?77Rer0uIYrR1rx5zOuGPo0tN8j4/c88TN6rGFxJYiGKXXH6zHfxw8clucjUe?=
 =?us-ascii?Q?SoASRsiZrOFjJBQ2d+8n2Cj6h5HL4v4Nl1HRa+JKzxwiDDotCfveQ2fdLPyk?=
 =?us-ascii?Q?N83iTAKwcJr6Cw+af01DdFgKQqAGEBePiE3FFwKZmMcLeTfB8aG13jxyIqBW?=
 =?us-ascii?Q?a3augAzleflGdK2+GnqMxLPuGWhnLpg0PcxSCcmtxWX87+xebcbonN1W5UEI?=
 =?us-ascii?Q?WEq1m6tMAqWhnb1mpzDjHxa2qoz1Ja88qVj6wOi8b71gXCxStBHCYAiin+4f?=
 =?us-ascii?Q?V1ABNboumQpUayHeQ1d8kKKZ1TaI2bFeLnSPLZ4OZQJJGnj4bfk6rufaoFqI?=
 =?us-ascii?Q?mk2TsioPZyDdMFJqmzuMst5CzpkqTarqaBREOUfOpvIp75/nGxZnOcB/Jbks?=
 =?us-ascii?Q?eSm2GMHwE30q45Vxe1MDLsFB0LkTVYP7VFtc2pVdEeSZnW0Ll4k9JB/Zg0S5?=
 =?us-ascii?Q?06kOpEmYirRI2So5/7rhFXM9L3KsKBbHIEnLRn7hgCH27lwbWksRUF5A5JWq?=
 =?us-ascii?Q?r/gGXfEXYsAarLK2FUXGESCujGGCtyREtHiZbCRplOiT1jW2pwhJkgewd0RV?=
 =?us-ascii?Q?KeuiciowcHmFyUk0nv/O5uCEzL1Oy9gWfiVrVUgnqWr8pIBmLiNfqWX6T++K?=
 =?us-ascii?Q?2alvFlwBN3RqZhBby0FSCaVQ2FrAzcobPVNDSq2DKFJaSJLyRdgplFfwjmXp?=
 =?us-ascii?Q?lMzxmpRspEphSSMidkRGAPwi6k0Mvmio6o26r0YVFXm4Z/7xelWJMZmWJR/I?=
 =?us-ascii?Q?bO7ExEMj80y8SRQaYzTF16UbobktL8jHnA2ay4+/92Pa24tJ29GjTwxviHNt?=
 =?us-ascii?Q?khZUDJ87kZbPREbrCPCzXZCSWRpauUjbl6+BqqmuVlbdX5JvzGwRWnM0/IQM?=
 =?us-ascii?Q?Qy0Iw5ehqCLJTg0yHUpjW0g/hIe5VpcbSA+knUlf5FKbCTOpLAb32WUtI/KZ?=
 =?us-ascii?Q?qzrRRw2O2r9aiVwI4YZBXarftXY0pAndLGVkw5mHW5z1/kRCEztxcycw/ZJo?=
 =?us-ascii?Q?tt77+550YeyjOusZwHV3aXdGvmzeZKjfdVdXoz1yaDv4rQN8rA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:27:18.9254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b11b8f-f005-4582-263f-08dd0b1288ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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

Need to read back to make sure the write goes through.

Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
index 29c3484ae1f1..f52552c5fa27 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -31,13 +31,15 @@
 static void hdp_v5_2_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
+	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
 			0);
-	else
+		RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
 		amdgpu_ring_emit_wreg(ring,
 			(adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
 			0);
+	}
 }
 
 static void hdp_v5_2_update_mem_power_gating(struct amdgpu_device *adev,
-- 
2.47.0

