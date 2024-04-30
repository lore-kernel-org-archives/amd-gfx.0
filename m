Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC86C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542F2112F2E;
	Tue, 30 Apr 2024 20:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="naGM3H6J";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669FC112F2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo6P8UVnXqKsmQFGXf14d33uL675E7T5O90VlHLOiJJzPeWE3TvRSA6Ww2wmDYU1YmnkkV+aQeJI2ViZfHS6OS6uZ+58TPBlvQOAQkQyML2UokeAFS3NBrrlyMdNkHVOhHOu9/nPI4qDGDl/xsMTnmyh/HQ/lCCUrtf3wLax+173dqwfjfWxAY6VWlG7VVGlX7zN/zAKIHZl/8cOHsftiVFZ53hERWesmvzYdCpsmSsAftokzDm2NizWAYupCJqJ4mYG0De9R39kRSP6M6HVh5cyZ+rIycx0bjlgtI12dObjkjD6boXFAexdLdYqt/DFrTG334LvNYqy43luNID8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smZA+41D5aTIS6djjHd2wmkHWAVUFqku88AT5VfK16Q=;
 b=kOZRkyZfiPLBu0CyOlNDYIxQWrbfqS+2HIU1AbTFIXZb3EFSYiVAxPBJckDbJhMJnKRZMD9t+lsh+XUzGF/4L3tQurbsikqXFyucvvV6tDKuF7JRsd3fNmykJhsPcBc5voLxFCa/LUMK1x8TDKBTBh5hh4mzV0GmM5CvUeh7snHanWlloPhCelF2l19tLC2y4NQEOxy0uuo1vHoIFZ/fNjqJXoEsyzubbYtYhUeZAHM5bjdHlJZFRGAEIjtWFFg6voPGpYaXKOlAQij2lHYR0A3d4W9nVfKULAn5qWNFu2PmW+zote+caOQCsXpE3w5ND3uyCqvKwMT2avi4UVHrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smZA+41D5aTIS6djjHd2wmkHWAVUFqku88AT5VfK16Q=;
 b=naGM3H6Jo5HIXDk/mQWWBal6HXVS/0hg0YBVmE5gqIsEUnhiJgnzdHQvMc/93mt2hVWkd6NtMX/eXIryFGUGW7nAKvnglnOgcIGHfXgTsNJtJAArAnNWbfrEZb7d07OqcWs8ZnypEeHmIpPb1TKW8mZClAp+6whQJwGrL3sC71k=
Received: from BYAPR11CA0096.namprd11.prod.outlook.com (2603:10b6:a03:f4::37)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:35:37 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1e) by BYAPR11CA0096.outlook.office365.com
 (2603:10b6:a03:f4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 20:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:35:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:35:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: enable mmhub and athub cg on gc 12.0.1
Date: Tue, 30 Apr 2024 16:35:18 -0400
Message-ID: <20240430203518.799286-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ef5b06-c821-458b-eada-08dc69551805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IBd2t3y2q2vRKbICsWufnD0es/nTyGpog+nvfz1X3UdZhyRsRqJfdVLgwlbL?=
 =?us-ascii?Q?qSZbmShNC9rHWIaBOdhPWVhd0ys9QsiAUC5Ym2A/f+9wYSue/V3U+6TIExbL?=
 =?us-ascii?Q?kdKePbWykhMegbdtTjkl5oDMEFAbf38o4Ix7YNptJVR8IpRcF+B1znjxBQBI?=
 =?us-ascii?Q?PrJcm0Xtz2oiCeHxqepBPEwzowhI0EZxJcbeGHKqmkBllX1T8U9N7jaeYCYA?=
 =?us-ascii?Q?VdnidcHvMY4x+ZqQi6EAIMtYFA8rlM5lCpNqZp+iTVGKkiI2JiDh1IrDBtzY?=
 =?us-ascii?Q?DVrd7nb8A+VTV/f1j+NP/8UWxJ6U1YnzGB1y1pr0V22hTZi3751W/yvMNu6z?=
 =?us-ascii?Q?OIrXrlS2AuV1wLHWPq9AhaUtssgB0QwVZhawu7ciidVF7buDZIkQlPGQdxM8?=
 =?us-ascii?Q?G8cKAMjtYX+b9LXveb607lPVpVwzcyvhDH/hq2veq2MROSBCL/i63Kxg7MFy?=
 =?us-ascii?Q?lp57w4dbNPNxFO0auHo+kgcizQ/TE91T4SYFvxgnhQKtvHIdg3Kza7lK6oJU?=
 =?us-ascii?Q?4LnRvaC7GymiX9Ouic2Nu1dyI73lhKchfURTNrcwI4envQQxFgYlhfyBUJm1?=
 =?us-ascii?Q?7vbv/sje00W5JbQ1CEJ4+r5tgl7M32H3dnQJp3RYGBdFhwIaO3rkCKkqdOIb?=
 =?us-ascii?Q?3BQleKIRiJOtXQjXE6QQhUO0H2LihoImC6RLztl6Htd/IKE/onna+OmtDKum?=
 =?us-ascii?Q?OJZEbSGG7/+IBLM61HggBVBjRjlewo7/qrO8ioLTu0Zcy/1D+NXApGcCfi+P?=
 =?us-ascii?Q?CsxBIarPN1dYI5pddL82hKbuVNjIGn+195AQy7Zm2kchxlyJtsRMyvTGAn7k?=
 =?us-ascii?Q?w/V4tufD7xYAqQmhTlWOaWAuLgepb1+USbtscR0x63XccEfuNu9VNT5u75By?=
 =?us-ascii?Q?hpoeJqywTmpJJ7p+SaG85tvPvJY1PfC/kFcay38gj3Qg24AnnDN8Sl5Bp+nW?=
 =?us-ascii?Q?Y0/+tVn1pHbkKBpZ4x2vjLqdlaydhq9DsXMjgaNRTir51/T1raUTHCn1PYr4?=
 =?us-ascii?Q?QeF2TXMyV4Bec3g5VyH3+/f/bx8p23GmQKcMr6aAeMurblO6UeBOi1tufGLN?=
 =?us-ascii?Q?eRWE10i2rTHbrwzT1kh0zZrXOZa1Vu3sXr1a6fDflc2Xsij3FjQ2dGNWkN+y?=
 =?us-ascii?Q?4j68aFwtYtEh01/mnRrFvNHu0kMAKlS1gDHLaOcTBYmwbq+944EXS7boFcqU?=
 =?us-ascii?Q?knhJ6SUrVb98CbdDc3gTqRV1Dgza3n4uxVooLBj1Kh331IcQLHSq0VLFkkAw?=
 =?us-ascii?Q?7g5suyFv/Ij2PTSs8AXmzcRmGYv0sa2MBc3FMW00z8DPP8IzDEdq7jsk7Qkq?=
 =?us-ascii?Q?s5673X5+i+4TBfICQDlYzFYCLHLvgZLeYKxuAH0cgKK0dBevbtGAjVpPIxze?=
 =?us-ascii?Q?790YQHco2K/lgEEqowZhdMQTrO3d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:35:37.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ef5b06-c821-458b-eada-08dc69551805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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

From: Kenneth Feng <kenneth.feng@amd.com>

enable mmhub and athub cg on gc 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 174126bc5f602..1bbcd23e703ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -408,7 +408,12 @@ static int soc24_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
 			AMD_CG_SUPPORT_GFX_FGCG |
-			AMD_CG_SUPPORT_GFX_PERF_CLK;
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
+
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_VCN_DPG;
-- 
2.44.0

