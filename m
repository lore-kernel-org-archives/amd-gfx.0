Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E11BC9EC94
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 15:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4197010E04A;
	Mon, 12 Jan 2026 15:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XnNGvjqy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9710E04A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 15:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebLiel1FAoZ7k1BefkU5EMXE6lE8InWZ0BS5/MK27I2LQWzS/UcBTd0ypyALKgrof203YwzQQ/nDX+HKlw2dmtckqJph8JAUI5cuj91+e8A7o0zOhxwnduSj+qvh0U3LHJIwG9gWpcne5W2P/l2fAPK6R3TIGtMkQfX/+D2/7ZhLEf1SC0SAa/MWobKtLdHd9RQHPlLAnTwa6HV3dLuP69XnutVNtZwLqmYbESd0HPm1kfu3+Ivf0GR+NC8i4Yc6NgAYG9d7DGqdoMB9SlyH4yQSmX6u9t7PS+YKjWbyIFEEHnLTMGYsHjwFrlAbhy6G7ZJcuJk5O482nlcfmgvoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEMd7NY9VH2dtFKN9H69xm/UXmm5LBRpDPd9/fHjs90=;
 b=jy9zuaW8lGp7YhsefsS9snYmSBAdgQNpu7oxmUG/SrMmVN2/sNEK6YZKuOu3BBU9ucnxsw6ecgicddpBbk1QlSFQg2J/Jka0xdWHkM0MFvD5nPdyyxliP5+96yvL+vBcik9FJ/SxwvI13IkcaGDhQpgLxeFwrPUD4rxP1hOxlF82UDBICPgRXuiPKhcd1NKB772pBO3g2n2AmKn0ExybpuTkiNDnDmBQrIeWA3MTV6MpkY4mNdkjdmiidoJTDm6xI5OIb601OAswLY+C+U/Gf02VfuhPvfda9kjih9/q/Brqz6ge9G8s0nFNSzu6eFvLwAEmVS8MaVyHKC2KeZqxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEMd7NY9VH2dtFKN9H69xm/UXmm5LBRpDPd9/fHjs90=;
 b=XnNGvjqyZMo9hN3FeC6f5SsWWzwX46scWg0ZIugNnTvHkcGXxSBR0seDVoktN23jziAwbcE+EZ5Lqb4Wh755bmu5ya0C8su/5JS2tVwObyE9sVERoQ/S/fUU6ZuwFVS5E/iN8giGTZYwgPq6g9UoiaEJeQSJeXlGT/JxLL8IJjo=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:21:32 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::e1) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 15:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Mon, 12 Jan 2026 15:21:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 12 Jan
 2026 09:21:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Jan
 2026 09:21:31 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 12 Jan 2026 09:21:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: program some additional registers for
 resets
Date: Mon, 12 Jan 2026 10:20:40 -0500
Message-ID: <20260112152041.441734-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: f109ded7-09aa-4a58-5758-08de51ee4441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JAm32YBGudl7RdSuRyIItc8YMw6YrzvSY/D2my3sm6Odjv5XzFWjFDZxuwXS?=
 =?us-ascii?Q?nFtn08JdVLYdw9KS1XEG+OaOZcE/vPZzrLtVRtiRd9YjjyXiIaQe0c520hUi?=
 =?us-ascii?Q?SnfggyBho+8BGWys+Ov8DEyBxC4pWk39UbzrLOlO352bKRsnlpkwrU0nv5kw?=
 =?us-ascii?Q?Xpe7Dpk5xc1fxhEqvqAXDbuL1kfkiB40wUnC8awJa2G4DID3AamYixkDlv2d?=
 =?us-ascii?Q?C6mtmQZPm5c4B64tev+O0zBQUzEEtiEg2tAWVC42aEQHHOc16hYxC3LTKSFi?=
 =?us-ascii?Q?iY3Op6BHO7VCSV8OguZ5OXPU5zo/diTbB/ae9NMTuNhuEExns+zgp8D5glNa?=
 =?us-ascii?Q?FQUNJImcpMqeE35VF3VsddaPswhG5e/xsoyOsjocNf1Z+zwAg/tMOTLo1B7c?=
 =?us-ascii?Q?YuREftOeP+LSt9WLwRKC80OjElf7pKZcztb8L3ccnEpaSjV3dkbZrOKu6/yH?=
 =?us-ascii?Q?sI1IeyptaoO9K8XxIDGpJPS5+rib3afVA4ehL9oKrUTnb4Lvzi2XzmpCFW2G?=
 =?us-ascii?Q?FXuFyz8UEHI3F90kbi4bdO1fvE5F5QPPHlAkBlcd/7MKct5LdFV4pLop4736?=
 =?us-ascii?Q?Un+mYuayJCQnFrFAgPC7U4UVqxdXIUoDGNPK3NSYKRUozYYXqfdp9rORn95P?=
 =?us-ascii?Q?hCvtU+VM9o7ylLKu0Und7VRKPV1cq0cYmW+kaGz0tEjiXgtJNJxJ+uI2Sxfl?=
 =?us-ascii?Q?v4yaJUknfr1YyqzWpkWNiD1N0K5SbOJ2EX7nihaTk5oNaeUHjyqCpxC22D9j?=
 =?us-ascii?Q?yTyJGp7Jho4/Cjybjpil3g1m4+f1mYhSHzJm+x3RVsylovlGMQF5bgOhc/QP?=
 =?us-ascii?Q?CSROaHWu2nUlo/ULz3WY+iCekG4MnXHKKl9Fbq9QN8uFqnWH3CiKCvNmrSjc?=
 =?us-ascii?Q?KGiUR70maNZhVSIDvx52lzOz/IDqMQP+0qIuUG7zVFcbpFvdgm8lqUGHLiKu?=
 =?us-ascii?Q?MI2Wdk/C1wnchU7PZ74TOlkekPZRK9N9fx37Za32eyvAGzEpLTZGi4dduIpv?=
 =?us-ascii?Q?zmI1ESOWOcMOHao0fF2NFgZ2Yoi7h/yVMf9tKMTTnsPFwiLkNbwX/1bqvx0q?=
 =?us-ascii?Q?W/ldFfA6QntdxhEXlrgfis4OfTWunUryMVgCUh6s2KvRU4iX3yJYC8PgzUEL?=
 =?us-ascii?Q?yaoLs7KVl1uAFGBiiA4rE5LzPz4/mcTwGPHnRBTX5xwqQUOuaUg2vmsoOPNC?=
 =?us-ascii?Q?xj4RmCu0U4n2H82uZmk1Onc1Jo/trepRl0Ejlw5xRFMSANynDXSrnGgJMSHG?=
 =?us-ascii?Q?ZIzhMV1OVJoZ/G+FUnVLBMqwGpJPdgwDmxm9WHEKrc9+eCY0o9EDToXaomo1?=
 =?us-ascii?Q?PhGyyaRBr0zkXSmB75Giw3ekpGfgZ/g4oeKTPegRV9F9YAQqw0s7fIc0NCgM?=
 =?us-ascii?Q?fWk5RaOAb4Hrdq0l5BTersjImjdGWv+upwD0Z1pI1ofWtD/BMWGMFtvHEUWI?=
 =?us-ascii?Q?aPB8uaqm0bMuuj8Zt+7yHyivWuo/8s30MBT2x7Xh3xs3H8RPbj35TsAyEXwN?=
 =?us-ascii?Q?5YQ0vJ2gwej4C89CcXi09gvP0fnAMemizV+3nWnYoTK9OLcEzi/sgrOr/zOP?=
 =?us-ascii?Q?ghlD59S7qQ+arviZZQ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:21:32.1956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f109ded7-09aa-4a58-5758-08de51ee4441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

The first change prevents the hw from overwriting the ring with
NOOPs after a reset.  This is helpful for debugging user queues
since the contents will be retained.  The second change disables
conversion of XNACK to XACK during a queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 624929473b136..6145cfc0334b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3616,14 +3616,24 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	const struct cs_section_def *sect = NULL;
 	const struct cs_extent_def *ext = NULL;
-	int r, i;
 	int ctx_reg_offset;
+	int r, i;
+	u32 val;
 
 	/* init the CP */
 	WREG32_SOC15(GC, 0, regCP_MAX_CONTEXT,
 		     adev->gfx.config.max_hw_contexts - 1);
 	WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
 
+	if (!amdgpu_sriov_vf(adev)) {
+		val = RREG32_SOC15(GC, 0, regCP_DEBUG_2);
+		val = REG_SET_FIELD(val, CP_DEBUG_2, RB_PACKET_INJECTOR_DISABLE, 1);
+		WREG32_SOC15(GC, 0, regCP_DEBUG_2, val);
+		val = RREG32_SOC15(GC, 0, regCPF_UTCL1_CNTL);
+		val = REG_SET_FIELD(val, CPF_UTCL1_CNTL, VMID_RESET_MODE, 1);
+		WREG32_SOC15(GC, 0, regCPF_UTCL1_CNTL, val);
+	}
+
 	if (!amdgpu_async_gfx_ring)
 		gfx_v11_0_cp_gfx_enable(adev, true);
 
-- 
2.52.0

