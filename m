Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD5AC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 13:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52EA10E02B;
	Thu, 17 Apr 2025 13:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aJKLc1hT";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D6410E02B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 13:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns9irKf76pTlsZszNyIQ3YgQNa3UYp2Rm4RSp3aiOjFPrcyaZP0mCC9X/kBcHmPmfEkz6/Fy2W/Sdic0cNsjgmYJCsN8eJ/G+CVu3yDhbvfJNUlujR0SkB5VTDYCK/+XudeBkAxemYKH1RQCZ39kuDmgpJxNqZnpjOx+oh6Ow2NIvxcI6XxQ1ro9+ZXwF3zyi/ju99MRyn2NvFOcmb+YhU70nsePr7PammJ0ITWfCz3ytt1RsBKW3v9nfOOWfQUuaVnRNgC9J8O2lwrRj/5r54wHOkmoBIVFMUv3D92Fh6be6ew/A5Bg5VgHyVxFQeyrVxTeieQ6fVZ5duWM/Gd7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iquQVAwiS5z+JE2pn2cBJT10BmwtKVDedxdFyxKBKR8=;
 b=ijZepauBzqbJ824ZSFTIa8OX+a8jaDzLXYn+VaEQuOKHsNObto+bde7llnAGUTLU3iWODzNnRUFvVQgJPNsCdN44C5co0GO5lXjaBCJja+rE15fM//4cKxbpVsVRfh1Bv0RuW7jzJRpPRc6EqIYOaXKuC4oQKwhWUQ/0qq6/UCoG+WTxmyXrR3y7ksgUZuw6bha6trzFd3LkG/KqBw04vVpuGCA1ducuTHe3eX9RzF/XIk6mT/U/Wryf5maNU13ZL9QTizW3RZIxXb0/Z5XtbXPrZbZHXgQl/rHEUBWdgob8fnyLOerMrp8SGXO+mzOTfEymY7F3+++gNW1EbRJDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iquQVAwiS5z+JE2pn2cBJT10BmwtKVDedxdFyxKBKR8=;
 b=aJKLc1hTBmciGCZN18h0Ap9Ec0IZEML6FzI4beSPd/crlnMSveP/Rc12dIWGUq6MqC9oz8pXtxgdzNIn+5yhVbaLNoN12R9wQLzP+x4Gpheb3mBZWNeCkFTLKIf02+3S+2I3wyOd13wxRsFKP9qZU2WXRtyRuPifEskB0bMl2eo=
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 13:34:23 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::e3) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Thu,
 17 Apr 2025 13:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:34:23 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 08:34:22 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: Don't pin VRAM without DMABUF_MOVE_NOTIFY
Date: Thu, 17 Apr 2025 09:33:50 -0400
Message-ID: <20250417133352.1204510-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f7316b-b6bb-4b7d-d1f0-08dd7db490cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YD5AE7/sD0ZR5IpLGVd5qdQP9oNIDusKoaCmcw707MWr/pkgIpcrCpNmfhpl?=
 =?us-ascii?Q?Lk+zSwTki2BwAa5M5MrQks/FuXHEjDoU68/eZ0MPs1/ZIxm/xfYlAOmFguFS?=
 =?us-ascii?Q?jqqCFQOrqKZWCfjpl8XztdQhaE4IkUwFYSIoYtSF3n90WrVCtTT9Cxclw40l?=
 =?us-ascii?Q?4/wnNo++b9qx2gm5XZRllT9RpK5M/eGsIcXhDYsIagtN8KAXS6vBzxTMMMSh?=
 =?us-ascii?Q?upL1J/ijwkpMY9e6tgVhcUsgiYgt/mtJ6RJaKdeZykyRTPiEEQNn2mKovaOz?=
 =?us-ascii?Q?z2BHBLehFmR5nHnYzaw1GTZOLySNbNmFvJWX8BXsXVal+cSAQUWao74T5RYo?=
 =?us-ascii?Q?7iEbfeVZJ+sJVYKSWNfRdLWDIWLrxKZekD14zd7jAZnlC45oAWmsUoMYca1d?=
 =?us-ascii?Q?pb/1Q8rGKYudwUnGA1mvVKDUs+C4EOETBL6BiErgg543KgXBK/FdlBE+T3rW?=
 =?us-ascii?Q?JIcxp1bXcH+2d88SWhfmttPM8osnT8cz7pwRAzThf+FhMvA7763kistdwZoO?=
 =?us-ascii?Q?Pb2DWhY4UrNNDWbDDCFKaoJHbPyWrMB1JNwFFxM2NQ0fAdNHLELvPuWVF2Uh?=
 =?us-ascii?Q?97UsQJv23j1XfFLfAkItEbHvRa3MOA8bufjqRDisNIC/LjMJPnZHTOHojhrM?=
 =?us-ascii?Q?TZ4J+yO6sD+hDZGhuQKfPMzMYtaPwGZ38oFIi4btJ/FKApg9U2k/lvFmBWdw?=
 =?us-ascii?Q?FYJebqVzEgoNU9riDxQq/NLYf5jPtyKM/0P2Cj/pZkOmIY4wdmbt7iqXGXV+?=
 =?us-ascii?Q?PVcoMV4iszrYje3yAZ0/iLU6ufVkmi+1XJvn0poTnhvf+GyQrYG6Wni6XJvt?=
 =?us-ascii?Q?juw9bPwIU1XD3zdfJgwYT2e9qlT/0dOu96fyBBS+nUR6+Cawr0lJ5G+1EBck?=
 =?us-ascii?Q?5TZ6OvXJn1tmJV4oJ65O7ag6i5SmZH4+DkAC2e7IoRVHv59cYelSostMmDt9?=
 =?us-ascii?Q?S8Gn7TSL6NgN3lk0wAmLeMUm064Yf7aswx7hhD6vZdP4DbiRzEd0oqlTrL6B?=
 =?us-ascii?Q?8jo6KY9LkyH7sjKzVoRMzaRPOC/xsOTv/Od8jZK9jALgNGrTHciKjxQgJrl3?=
 =?us-ascii?Q?ylXfO5lyl5t5w0mepjAyZWre17ABmde/CmLeZdUPgRQbqQZRgTrKljVRTrQY?=
 =?us-ascii?Q?zd3VgJSGIFfF2kb5gPW5nt1f6DYO66qAOqIo1rfvOpJZ8qbelcyk6GIDkL7B?=
 =?us-ascii?Q?3zhO+4XlnWGTzvHhL/Bw6oyQxYp9IZrNL2R/dX/YAUdmTacG0cqxRo0QMGd6?=
 =?us-ascii?Q?peKMgtDPXGRDvxV2GI/x99dWaefSDRT4R4MQvQZOu/yVWwKlDZJzbRgBqG/V?=
 =?us-ascii?Q?BnSG38gxpYY6UxLW81gNy6aJqwVdHqtxavdAZGkOHZTiGrACZ9pXSO9hBhoU?=
 =?us-ascii?Q?KHvQGYXal7GnZi/Fdr3BNtMOI0uhjh6jSFrtvCjmkTTAa4x3P/Md/4WqHLEX?=
 =?us-ascii?Q?8bwbb4S3yv7rJ64z1JfGjYIk4gLNnO/x9zhhahydOS0sRWOHFs7F955RVBmk?=
 =?us-ascii?Q?zhwx1MF0nSLNHKAfQyL+WMbEWywyYFRkvs3m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:34:23.2665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f7316b-b6bb-4b7d-d1f0-08dd7db490cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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

v2: ensure domains is not 0, add GTT if necessary

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 667080cc9ae1..3c2c32a252d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -81,17 +81,26 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 
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
+	else if (!domains)
+		domains = AMDGPU_GEM_DOMAIN_GTT;
 
 	return amdgpu_bo_pin(bo, domains);
 }
-- 
2.34.1

