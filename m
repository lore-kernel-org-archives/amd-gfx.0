Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F317E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 03:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C401310E5C0;
	Tue, 10 Dec 2024 03:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GqASceuc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3619F10E5C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 03:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ4Ko7QfVU4qpXzoRmdvYUt2aoxRIH5OgDhffUgwR1E/ZuF6xfeNoQ2nnI+OEI/zMAJa1Oz/zYifklRjZzCoxvy6ahR3XKAsoAiQekXUlG+8zBVbeIRtH1dJnrNNYUUabXZToo0yVtTQ7Jy7g57PlBBm/U2NULuuz6pGBjjFCt+5Tn47/ZjHX9qorzJok0h8NeAQH4m7pJEUa0Woh5eb5wxhfuOBCKVbXT7jsKXHR+rQwTBkYwGuxETbLYx+dOIIWSyiJ6mLCNS80a+VQhZsqBcoEpIMu7B5G+Z7K5tkZGhZIIvATenEbFpypntmI6MIwIPFe5np1H5jtabgSFk3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvEs8VvExQ9bqNEgaRAqTu6AZVbmD5k23hYimpy6uLY=;
 b=ws5y5pP8bRWwX8tLhtSu8LUSBUNldcABmXSs4gBH3HfEsVSXpr2tAYX64hcwgHIZybcOf/Xw7EoLleAq1PPss98z5cEBGQGaWIesewjWKkxAT5e/2H2aiPFWRQWhjgxvh/A3fOx+3thkDNo+qK603/HHbaln/iAjO2ANFa2n1FHfwbVfB1zZULxniUv80KTlQ0UkjoGMFaOCBbgwWiTljM/yEqnIfIR7sv8eg2DVgnrptLsDTbNfwPVtjNMhcZaGdC9sLGS3Cduw+NWWbsU0vjHYcEjZiK6HByXBxbTLOjtG70tZ4eZoxQtDrkg/sl0xwTrkeWFHrN6oanmTbpSgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvEs8VvExQ9bqNEgaRAqTu6AZVbmD5k23hYimpy6uLY=;
 b=GqASceucCAky4XXnnT4y/VB9melPcB64GY1xFM+YaPUSTUY+ZE1abt70MifQvLSh7GzJdoozu4A4zdUv9tAGH16/opi//7N8OhghiMPjuKjvMvWYTAcnKoZR+Fo1NrsTKAH9oC5kQQTE1/A8H5Ms5zrpeL4W+kYy/mMZ0R9L2OI=
Received: from MW2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:907:1::26)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 03:54:09 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::6b) by MW2PR16CA0049.outlook.office365.com
 (2603:10b6:907:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.26 via Frontend Transport; Tue,
 10 Dec 2024 03:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 03:54:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:53:41 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 9 Dec 2024 21:53:19 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma7: Add queue reset sysfs for sdmav7
Date: Tue, 10 Dec 2024 11:53:18 +0800
Message-ID: <20241210035318.2159002-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: fea6ae2d-96f9-4d8c-0abf-08dd18ce4cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pBPjP40Nqv/zs2uBYIa4GnGTT7ygWqm5cXu1RHtPWFpR/CFJa600OlnAcuHJ?=
 =?us-ascii?Q?vGrWFM1dY01eRAeuha04zDb+F6hQmH+BaR2DwfXllvBymZyI1ghzN5lWcCSt?=
 =?us-ascii?Q?Xs59NgiAawchO37bW9m7UN4lm45jWyK1A5ihSE442/NsslvUci5fgQWF52PT?=
 =?us-ascii?Q?TOwpEUzEHgEhy42Dbaz0O56IzmqUISwz6FTtutq+xY0mj5y9pI4DftWuT2Wy?=
 =?us-ascii?Q?355kOrkt+8zr6R2dr/xtpn7GgsP8VnMhrmQCh19foioc0RKxENDURYo5i48C?=
 =?us-ascii?Q?mbYgYkcw0YXRexZniws3aorZPQmtIUn7Eh8paNyLiZNXlRVDFvx4U54TyLqs?=
 =?us-ascii?Q?wvYdcSQlurhdbTI9rSu1yUsMHOZY1eJVkXu7+vuaEu7YJxjUxIy1PCiZuDjO?=
 =?us-ascii?Q?MyymKZ+hgppYUrZTmxpNmz8XxZ0qyNFZfp2IUOaHJrTggvAAomR5WlcZeXre?=
 =?us-ascii?Q?rAlTJ4+PLlPQKkBKOJa53JJ1IRxU3o2Q5V6rszpnNNsZ++TXzXc9uVo71vUo?=
 =?us-ascii?Q?yMtF9j2+n2Oe+YK0Fpcd58RO2galuSXP5diRFXerCgMYM94+eECh8oCFns8q?=
 =?us-ascii?Q?oXTj5gNuD9pYvxGqpAJstuaXuRXkquin0Cb15qP7Olv3i1p9mwBCd4cCp+rV?=
 =?us-ascii?Q?Z7zNqoELXiPkLds41tMdM66elkyHZpMzH+r7JiefAYxy/kP8OMmcTC13AP6Z?=
 =?us-ascii?Q?ZofbkkYa2FSOf1wZnXrw5v6gSWNzSryfmL6pFABRRtR5hfzRMsrqGWq1pBU5?=
 =?us-ascii?Q?DavOvZzycmgnbFfZ8FfRul6ArCTUP4b2z1FaOIJ4tiRcSzRbODX3E9Xqx4Wv?=
 =?us-ascii?Q?zUmTJ/1MZcqIYic/8TKbOZ+cQe95sKXonynZIVO/jh4iw5UuEs4bs39bMt7m?=
 =?us-ascii?Q?57kwnEOkojshyjy8JQnGz5yhqB6wI3rU/o9KPgtwLGj7AoLzRJHyJCJXIIT/?=
 =?us-ascii?Q?k1NZ5oZv0dZi3iR+VSLeqvQzJWtGejj6nQQL8P9SqiRgZ0/iT2UaEYeGWAKe?=
 =?us-ascii?Q?OXFVhOuJiM3WdcIce0ew2MOAUTZIZ2HwbTcUOfYbpFuGZuFYA1lIgMWKqeQU?=
 =?us-ascii?Q?j/DY3+w+lP2ViX7kpRNMuI1DA0NmuA7FhlYphuCfSOfNdJOdfpMVYzaYT4+3?=
 =?us-ascii?Q?cmywwjQ3rRJIBB4uCd1VTFkm58VzEAgOUyeqNv6K726SRucjBvR4270Q69P6?=
 =?us-ascii?Q?GyE9irntDPxIjQGgE6J9xV49Nw5DzbT8DyrrSMm0yypJK/SzskXcLE/eDUWr?=
 =?us-ascii?Q?/x3ZUD6H9ByOj7gWqYrtNTvaB57hmmybKX1/f4Y0pVIZCgJ7CpJY2wksyh54?=
 =?us-ascii?Q?nCz8MId/c8zlgaGn+t0XUz7GTpIr5JuNek39dYMMaP6mQiaXl3xOGvQPDqZO?=
 =?us-ascii?Q?jGYPJ5ND0f+srLAqx3HUfOXbqlUDKdvj9yH9p74dDzY3MEeTokKR1QFEoRNa?=
 =?us-ascii?Q?2c1KcAH/KlXFOmJa/2yhXVT8eqFVal7R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:54:08.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea6ae2d-96f9-4d8c-0abf-08dd18ce4cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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

sdmv7 queue reset already supports by mmio, add its sys file.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 627e0173b64d..8e69b84e0165 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1368,6 +1368,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1378,7 +1381,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
-
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 
 	return r;
 }
@@ -1391,6 +1396,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-- 
2.25.1

