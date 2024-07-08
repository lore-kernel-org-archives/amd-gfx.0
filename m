Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F22C3DA41
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 02:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204F410E06D;
	Mon,  8 Jul 2024 02:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DWgfrmGQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F3010E06D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 02:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew3fX1B8FUW+JquysfFf3GaUo9/PZafr5oDqor3VBznRTPy9ydoUhPK8JVqexmiRUa1xgw++ZyIeD8DGiEIRKMgbwQfFzNbayWSxhAWWbaq+odzDgqbX9pKrmRunlOgfFGwIGLDFsfXwy/2tl5zvzSSyGndSHsZmXfijY5qQyiaI33R4Y6p+tdYVdvTFJH5ShKWaVETHhhzdypCpkq/LWw/J1HuAl7JCZ6Cafb8DaW+KG20WS01gosn1zc73oWXZB+sEyUV+heCIn6CkDm7RZs5Lmm0BtbJG5ut3GUk/dNk9HH0ZTrS/22zqUCWgl16Tx0i7PxT88AD1K1s5vvff3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/kJmBfwYlk883ddWXL6swknmxdlYUvALDYNVJEmcuA=;
 b=gGgnkaPLQHRBYGaqlgvFfoQQaF+fYe1dSIuCQp6foUujdHWNMFQESwuxNjuQXvqv5zIOavmKJ91e3qg/IitWGou4OJbpO3I/aQHn7+MGcbVkxWzeCRKMhxU3+VnxOD/U1iBmdiv0R1S/W4Nkr/K/I3wfhULNTnURitdkLKJy6j2+z0OUlRx+RmCjbkvvufEdZplTJI80D7T4V57o11vyBtZUZM4v3EZxp/o0Ytd++wo0NXzpTE9ZQO+zT1CuoSQ/KdH0vNqQoFo57cBfh4CZkNGfsFgS8rmOCnO/o1HLqRfaBJJNb+IXCpEzSFw0HadGYkKT3OKPnzzTQkDXfUvHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/kJmBfwYlk883ddWXL6swknmxdlYUvALDYNVJEmcuA=;
 b=DWgfrmGQjuFe0T4WPW4JVzB8wWU2uFo9WBiT7J5jNtq5bEKTIYY2oIL1RQMS82WC4IjfN/xOWqvQyv+CZwlikGlqPsejoLPMB6tHBnvHpLgiPCwgN4gPgm5HxfQ8wokMtJvDp+SkLfHXN7EyETq5y0WbKn3SXWXTPEqoM4PTUJ0=
Received: from BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 8 Jul
 2024 02:02:35 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::ed) by BLAP220CA0016.outlook.office365.com
 (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 02:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Mon, 8 Jul 2024 02:02:34 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 7 Jul
 2024 21:02:30 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdkfd: Use mode1 reset for GFX v9.4.4
Date: Mon, 8 Jul 2024 10:01:46 +0800
Message-ID: <20240708020146.947040-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: c823b772-ac06-4fc5-5977-08dc9ef208f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?plzTTaHN4FU+wb/UfVaU4l86gQbPd84IGKPh6G7Jb4JwFPiPjl1CteNlKimP?=
 =?us-ascii?Q?uwX5ljyXAYcCvhwpw0UgfBXH+27QL9AO+ceVNl+OWzL5NlJFW1Ig/eVj7gpu?=
 =?us-ascii?Q?kU92LAWKW93SF3EgsQhQW8g+DFUsvQt3N3VROBjpHokOs/4k5wluO4KnRxMW?=
 =?us-ascii?Q?3FyXfhTRd1l2HLR2QafEZ3SlsEUV6us0qKhj6p1xzsyGuJCukmqhKqki4Q4/?=
 =?us-ascii?Q?Po/dP7X0MPgMeu5aKg02DR+8uMpmg+KIUN7zZHSn9Hq54izJ2kFVj2tQrpBc?=
 =?us-ascii?Q?jE4SFHOtRtv+/Yo0M/DZsq19wzNwXh7T2NqW0FuwWPfrgMuugipyhmoAUVzB?=
 =?us-ascii?Q?Uxy+Sg4seqLHpYcfW59iMrnNy9j2oXQyopVV08RmeY1bFj8zyM9vOjeOX55J?=
 =?us-ascii?Q?3B0c4piYNhx/tH6SEu31vyjOoMznChISxEw4nIqZwDEcvnYbQgai1woTNYAw?=
 =?us-ascii?Q?xi5jDHNqKP/oV7+uUoCkEMAhF+4pas48bvnkyFhkSNWCBvOKbh+w4QpWMW2a?=
 =?us-ascii?Q?GuGGkPKRvrE/tVg1grzseRRY7KM66t/bheGMQnOat1ALucQY6N4DLyU7swtB?=
 =?us-ascii?Q?XjwVklSv6nOVA4UKYF49Ux9BSwA9Qh+XMO5uHAXYCwFPlOVnIsiOG59Nj+DZ?=
 =?us-ascii?Q?ELzND20MM7TC9DQti2ir16WuVoR+CzJThINBEnbHFoYw3hr9sRtZSO+aiK9b?=
 =?us-ascii?Q?DNEidvmVfFJGIfrki17tK1eL2p80ER66gdvApF4WC+vvco46apgRPJPQ6qYE?=
 =?us-ascii?Q?Fd0w1Slh7psntiPL+vSSAAU/6E6zdKfp0qR1muAZsbC3L9wO5vLAnBIv38e+?=
 =?us-ascii?Q?4/wajlNXmCkuo71J/d8r9gADLrKidU1ec5fyBuDl0voJmatYsxRR8XpCMGlh?=
 =?us-ascii?Q?moxklphdWJkysLl4kqPzBVbqbk0RxcvIvil6MMar88nPaiOk0ImNAzFeLjFG?=
 =?us-ascii?Q?i+xdgKx1gfg6nhNg8ynlScQ4x06HWU8exrSumsB1/H3S5qiOw4MuVGF427A5?=
 =?us-ascii?Q?QNB7PHWPC71XcRwGvaDNIwUrgNQ3gxeRXhgobeXV/0qzIxM6F6s8PIH/CeTe?=
 =?us-ascii?Q?ygXeR/2O5q4LiqYrWgOqP92JyjXTh2xcY1Rnr5+Lekvsv8zsgngDZOo4mPtF?=
 =?us-ascii?Q?oDVmXHz6th+qjZtFQAMWYHD3VKPciRxGn1Yo5IbKmcPJPJ9OsNrnFEexLb4n?=
 =?us-ascii?Q?FSGs1cCM+9tvCBqwl5+8fgVen+dn7E4hwflz/l+wMD7Mc9Ac0FOWxw6hWfmS?=
 =?us-ascii?Q?+NYirb6p1Rb0CCR5ltPi4ZiRlLUM1724S05C/IDdsPZjvOH3cxWUMZ6nScql?=
 =?us-ascii?Q?W3ozXP7GF0nVc1CmaAqr8Vxva9X3yp+xU4I8+VJ0C+B3We7ewd8Nmy/4JLHy?=
 =?us-ascii?Q?6UQhlfCBId62/mOfi231TrwnB3kra5AnWhUG2JD00FhcJqZO0m2lloDzq/wB?=
 =?us-ascii?Q?JTwnoRVjkBwxE0TMhGPEUFfK3KCPogQv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 02:02:34.8714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c823b772-ac06-4fc5-5977-08dc9ef208f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

GFX v9.4.4 uses mode1 reset to handle poison consumption.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..da95b8ba87e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -164,7 +164,8 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		block = AMDGPU_RAS_BLOCK__GFX;
-		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+			amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		else
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
@@ -180,7 +181,8 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
-		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+			amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
 			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		else
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-- 
2.25.1

