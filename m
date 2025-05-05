Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8316C3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE8210E3F3;
	Mon,  5 May 2025 13:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UpwR3pc/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861AE10E3F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRIv/XD7MTrFs7w3Koyw6y5G2o6t986nMhMhtUzXlx2kW0PwBgQQRKkZtd+MwsrFXRNbnv1mnWmHGamcNBoWeNMUnqmy8UlwVX84QzKwrApDTLfXiqIJRwSwTJ0Z5f0qnzBSkACT9ZWH+9GmZK+Gyn5ItSdkEjS15rHNq+OtytEKH4aUbX3Ht+/pH+ZVKoOdIJz7KAc8aB1d/aH6baOEKjnBfOxlMiu97+O2jGofdlrl2DQszfevqctkeeqPNQtR1KI3ByLIHMq6eyioyc+DDUUYD0yvz6NJz8pv0Sq1tQcBxdTut12EqZMt1MbOvnrhUnuC+Q/bIpW12BEEmCx/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGbCCdB0/vAkclv14DjnndJa4ZJ5njGvBCUxRsyNCqA=;
 b=SSkbV8vd1DRcpHkK/MKIkrPtVvYawXc7QMtQ9L399b5nQhumT1re0PViAMEN3HKiLJaMfkXplnCknzHLaJ90gxO+qKrnAUIRumMBTzDDAKgs1AUI42jHIQbjkMiiTjn0Y5d7jTaVBgV8tiAi7cMcGmrjXpsRYKcP8PQwojOOnOjFRpaVqsN/VDwB46MhMsBJRl5Hpl9lEqrbNaK6yYVWDPtEIUJuwkrK7w5HpXtl3Kc2pmrjwOgFeEhLPhPFSUneEzNk9TKNwv1RLOIxzUQlpMed8+sLp0MVWOAg70s+pufsfLyPUG4mP8/Yx8zH/qfW+AZjU8WhTOhAfNAgCVPZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGbCCdB0/vAkclv14DjnndJa4ZJ5njGvBCUxRsyNCqA=;
 b=UpwR3pc/poh/YeYW9+49G5YgkjHmfALHkQjtQNSoG4l3SrwReSzW5Q4NlhMl9qZxv43qZ+8GHaTNmyklBvmT4xoXAILDZE2HEB5EHXWXR2jqiOEui8Z0qLyJ5VozF1Js8rA5bWMQnXak9Sq9mjVnTV9nKBxxn3qhCyFtQcF6w4o=
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:05:19 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::d1) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 13:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 6/7] drm/amdgpu/hdp7: use memcfg register to post the write
 for HDP flush
Date: Mon, 5 May 2025 09:04:58 -0400
Message-ID: <20250505130459.1985637-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: a00206af-9a14-4b59-a5b4-08dd8bd57caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fnMXZUwXLvMNbxE8Ru9PdohLdJ6TT9TgBFhagWp2BABSrvDlQ0wHvkUXz3w1?=
 =?us-ascii?Q?wVGZkstPGnh0PmU1VKSqM8CyMoSzdLWZ3e+T93qoZQy9hIvNoCbmAWmgaclR?=
 =?us-ascii?Q?jYFUtAbFWu22wvj2IEad/fLvsRTIM+GObhs1GnvC3eGCNVdaHyfXPRBoTDI1?=
 =?us-ascii?Q?4YfiZK41dv9JxeJglY6gDg5c3Zrm+t6/5Ne98L8rZjAti92LK/YsFiD1gJr3?=
 =?us-ascii?Q?DyxxpwDHBhgbdhJw3Iiq4vivr7ymEdxuBRKvW0j/eO2Fht5Z9DmR7Xw2irdS?=
 =?us-ascii?Q?bOq8fmteM+C1hwTxY/GiVHLvzJrTUPtXfJggro8st/pNvTGHIWu0gJaePa/L?=
 =?us-ascii?Q?dpjBWD0z9tqMDafFZEq2VKzAc1y5lk5tIyYNipVYqC2QOvDqAtVxGn5Nazn7?=
 =?us-ascii?Q?UDD7f4G+/7pLXVLxU+Sr4D89tFef58Mdbj/+Rbc6pWE8bsM17s8teOXXBpm7?=
 =?us-ascii?Q?+RxbzbSzfcsNzvW4zBXgG/GW5SQy8JS9TqzNS96fscL5kEZg58864E4Vl3TA?=
 =?us-ascii?Q?c/WbazKXkhOBTyrGpn7nduvt8p+0Eg62cg102nePlFQMAVI9qtNOAwp9sebc?=
 =?us-ascii?Q?4G1tjyitxOyhf015ChqVPyLwD3chEzU2by6F6gDLEw6q7BxtngwHxPzken5S?=
 =?us-ascii?Q?+uHcfgxa91D/YparSzV+nccTCoDZfHyDyBlXqXnbHo3n6cpIAJAsNiCcBOZY?=
 =?us-ascii?Q?/MlPZ1RYoL+YHjuJy8hfQ22OLCqOgQOvYRn5iUMLPPU4U9xD+w1XViurHxQq?=
 =?us-ascii?Q?wEuK6kTUMai/IOMsvVZPcG3EynCMnmmvvX2Qq/7kRnuKY1qp1ZGycdbP6YNM?=
 =?us-ascii?Q?jKiYxyzWPUX8lUA3i1qsWZpbMUpdg5a9JfoU/WdjHGUtNr0mezTeYEnKg8W7?=
 =?us-ascii?Q?IUbDb2B+8qd0qB6wzMv34w3JWMCTKk4uSM0hcYK5KPkJZNaCa7zFgf6oeOf1?=
 =?us-ascii?Q?9tzUNXuUSrnYZayGgGuka8bYOLhvPh77tVqPpB7t4XUtOjp8ck/EOH9r4h4S?=
 =?us-ascii?Q?YgU8FrMlPRGQBenQrsd7wuZoICNuFe1kbFT/XwnRXLmSX8RVYw5GfbDHXKGT?=
 =?us-ascii?Q?T3BSVxe29eSAgeMiiaK7LjeIhi7S7aenEfKko/cQek9hFClF8/pxST3SiDEf?=
 =?us-ascii?Q?8h9/yuloD2++4tZvu8OIbuMibwPXpZkhZqMKSB5rhDWb7nTFaZmo1YqLVjTT?=
 =?us-ascii?Q?khXo7PJ2Hka59nxZ2KdoN1yrOIMEzi4UCPsp6X49UlEzWkPJuU5EmTjnoagY?=
 =?us-ascii?Q?OXM4U598NIvIV7h+9qmuDFzWJyOrSl/MubB4PyDf1V98w8mRKDoOUUKoPL70?=
 =?us-ascii?Q?ecE7DzOjWJOwfj/Of/9S66Iiupu6AbU/eAoUGuMU6/O4h9gCW0tvLBq9HJ2e?=
 =?us-ascii?Q?Uye7JNAaaAI+Jk9splOC3cVF0TdI/6GlTvLHJ9OOzPkmRwwDj6uuVA0EtdQD?=
 =?us-ascii?Q?e7ENfhyPfbrgHJnk0sqiqOYToks4fToEXBHDra1Jyxd7XU4Asm5W3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:19.1781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00206af-9a14-4b59-a5b4-08dd8bd57caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: 689275140cb8 ("drm/amdgpu/hdp7.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 49f7eb4fbd117..2c9239a22f398 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -32,7 +32,12 @@ static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

