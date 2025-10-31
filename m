Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E3CCF9EB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 07:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2603A10E144;
	Fri, 31 Oct 2025 07:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LoLQEx+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8776F10E144
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI2J+CTDkE9KGwlfewEbwDx1EzoUIQLmia4VMbWPa5MquIny/lqRSucxeJghLmWqSBUDV2xgw16Qbftw878Ni2QS5DACJZxhH7UA1FW1rdwNFBFzq6s66R3YTFtJLUcCvd3cvQI1yjskAGdzj6qcPe/NY6ZBjoRp0PAMDgXl8gM89/4rqfdKEHQ7hg0gKXeFMOqk4nx5/vx04Cj9wa3hm4hx2SP5hY9DG5HjRdSG678gWAYTVdudLFg/78+K8gCjdD6B8iqier4rpCgXRHLcnDdNHOVej+DuUCLz8NrYMBsV0ZGh4R/Nd/ifpVj1UMjKNGWmHIVFQ3HkNhSsDacqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCcnaoityuCEDRlvDs/z2A0QzAw2yxT9wO6P1xZmy5c=;
 b=VyDuryKxut4H7oPPiu6BFNeHIiEl0vnecRxIPAg4wsUqVYRuurN1VJ04MQQO9LZkKC9Saxddgj3E/hQIMB65r1zvkN4iHc8v9U1nZ39OmpFGD1MrVkuosVxJjfo2lE6EczIAi9NZmax/WBduGQYOvmYprR+tgsD5CcMo+9S9W2ALhd+xuvG8ffXGD8TrSaEwFp2iPZEQf1FJBvX3BYHS4l36s6TEx2ffINsMWSC5qWT87PYHbKejK8aW7CW6AljWPTB2rKcM/pjaBt0l65TlCjZMEp6y7Xw2FfDbGjGnNx5L7+pfp3T7lhGz0R5GWGTbmDwU4HLXpqGtOKsSiHg9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCcnaoityuCEDRlvDs/z2A0QzAw2yxT9wO6P1xZmy5c=;
 b=0LoLQEx+HjOOCFXA1BhPYBjqIj6MUF5aWVBat2V3tsJJf0UnWvRoxs+y8KhC9eoujipqAdVU2um2Nmpk4mco8J7jf4h6iHnONEm1HSy11nD4P+DBY8/93eUl4YouGQrJpuRkQ7CQ+6PNiPazpAWN5Cc5qw+xbDAbZMHNCftQHOg=
Received: from SA1P222CA0099.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::13)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 07:05:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::e3) by SA1P222CA0099.outlook.office365.com
 (2603:10b6:806:35e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:05:56 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 00:05:54 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: Increase ras switch control range
Date: Fri, 31 Oct 2025 15:04:34 +0800
Message-ID: <20251031070435.2612918-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdf575b-4ddf-4724-d940-08de184bf05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ipjSh7VFowUqoq5oVLlONtDWrszUoA5H1ds2jIXhssnmddg3iBMJP2oOmTCT?=
 =?us-ascii?Q?FwQxmn1S+Vv9xYoH1nuOeJ+JJqwWWWn4qhOzeMANAlj6RYOmIBz2FhFM5DZV?=
 =?us-ascii?Q?ns7fSUDMjoV0I0ZsHmrFwsD6NjqUwjsmNzc7IEElzeAMjFyc//MxCPvvYZyJ?=
 =?us-ascii?Q?BAmI4ZcIl7W07WhJLUSPF8OlIm4sgq5NFkEH88MEDgzNbOGF9TRD2nZuXk+I?=
 =?us-ascii?Q?izkc0Sr5ASUyK/GLcqa2TNhQUm5NmGhWeK1coFPXdsQydON6smGwERkkqUht?=
 =?us-ascii?Q?REZrrfYuXVVpQvoFQelgvolQzbLo8VfrlwgofU2ZLmwUEEEu2vfJCF23Jdrv?=
 =?us-ascii?Q?6wNvGBKtyHqMKlQ1qbqAa+/49VZaoY7R0wN5E3gdQ6Mj+VbEzPwWA0MPFuo6?=
 =?us-ascii?Q?1R6MhRvP0W3xkXV49F7ACKUvpsibNpCg7zyzT8RI5Udq+WPGFuV8mNjilsop?=
 =?us-ascii?Q?5wslf+Cv4fZpjtbSXTh/wgRt9OqEIobB3CzeDDkXl00+uaCl+2jMHcxbLyLp?=
 =?us-ascii?Q?9ykmdRk4rgaXqwSOV1dHuyaqizqyIVr7PYvUVCrE4STBlBdiGLq8hkCC6kNW?=
 =?us-ascii?Q?ZsvQEq2amtu5JGlNA7789jX5a22+q7MyLCJ4a1MYDXL76xiIJOWBesauPfWj?=
 =?us-ascii?Q?8sawGdSGAoNpuckoQz9wmRqbe/Uk6hE4qabYLb++7bNRmFAPK9BzF5kCzGO5?=
 =?us-ascii?Q?t0Y1AErv3E2lY+aom37+3CD9SdexBWNlV72xeE7mErUfMGyPCwmm38/UHFgf?=
 =?us-ascii?Q?5N0gcD6XJicmB7RWXvRRfMZTHuJqEIru40ZziPA315z1g8usloTCguTzoN5Q?=
 =?us-ascii?Q?j+uFOktk79zz/gP1vgWfVGcfpsPgLujuE0PwMw4sGwI3XlQaGf2cFyn+o+NA?=
 =?us-ascii?Q?N9i6Fcmyx8D8ZHu0hzWRXorWrzLr9L3ApX/+qWySO3eZKiBLn/YBg0g4bXD9?=
 =?us-ascii?Q?s39DVmm4girDxy4ot9mXkdRpLLjn+2Uf9wD19G3iiZBiPsjzUx6Nn99utUBR?=
 =?us-ascii?Q?DFK7beqThxyvoPPRmbQIKm7mSvM3kgJJ4PqZWKQHl54itKLEgFuz8CfQ9C4I?=
 =?us-ascii?Q?mphOjmtDmyzuRENgxmoE7oMWdr7bqL39fkULmejcgE55aILEe18lQ4VGl4kQ?=
 =?us-ascii?Q?awcSC/zv1maEZwPRqzEbo4EA3C2Cxnm71GLhLXGkQssQZSs3V+2C1T+s1Dc9?=
 =?us-ascii?Q?LakAFMFDnLCMXa1xdBAjgHiwdHodpgzqxBtaM63BdIWIXdyzXvtOmdNHePUH?=
 =?us-ascii?Q?Fo/zF5iOHeRR2YlcLY+k1kQJdKU26xoTBZN/uzoTnxTtdSrk01xZIOJDa536?=
 =?us-ascii?Q?/KRX9/vhR8nPDZY2tXGbMMUdDyLGtn7hGU627lwJZPzKp11WX4ffDb+SqfFC?=
 =?us-ascii?Q?LEMVLRG1hr6S6OrfiJ0PccYz0csJBd+MGYWaiyiqoF9JXaJocm8bUt25Rz1Q?=
 =?us-ascii?Q?XBNJBB1HAetiAU9BaFrsM3cl0pmAbYXsR5zzO3ZIChC+DNPRYx4cmh7kTJGS?=
 =?us-ascii?Q?88qmmvkO4jq7cHdCB8Hd3wnhghV/ZlNP3P17eV7a9ZTQwo853D7CYon2iK6G?=
 =?us-ascii?Q?cWIzV2goli4GNU4tqAM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:05:56.6620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf575b-4ddf-4724-d940-08de184bf05a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

Increase ras switch control range.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 25 ++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 556cf4d7b5ef..40c0bf85f1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -591,6 +591,9 @@ struct amdgpu_ras {
 
 	/* Protect poison injection */
 	struct mutex poison_lock;
+
+	/* Disable/Enable uniras switch */
+	bool uniras_enabled;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 8007e49951d8..e1f6db13c55f 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -283,6 +283,18 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ras_mgr *ras_mgr;
 	int ret = 0;
 
+	/* Disabled by default */
+	con->uniras_enabled = false;
+
+	/* Enabled only in debug mode */
+	if (adev->debug_enable_ras_aca) {
+		con->uniras_enabled = true;
+		RAS_DEV_INFO(adev, "Debug amdgpu uniras!");
+	}
+
+	if (!con->uniras_enabled)
+		return 0;
+
 	ras_mgr = kzalloc(sizeof(*ras_mgr), GFP_KERNEL);
 	if (!ras_mgr)
 		return -EINVAL;
@@ -315,6 +327,9 @@ static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr = (struct amdgpu_ras_mgr *)con->ras_mgr;
 
+	if (!con->uniras_enabled)
+		return 0;
+
 	if (!ras_mgr)
 		return 0;
 
@@ -332,12 +347,11 @@ static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
 static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	int ret;
 
-	/* Currently only debug mode can enable the ras module
-	 */
-	if (!adev->debug_enable_ras_aca)
+	if (!con->uniras_enabled)
 		return 0;
 
 	if (!ras_mgr || !ras_mgr->ras_core)
@@ -360,11 +374,10 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 
-	/* Currently only debug mode can enable the ras module
-	 */
-	if (!adev->debug_enable_ras_aca)
+	if (!con->uniras_enabled)
 		return 0;
 
 	if (!ras_mgr || !ras_mgr->ras_core)
-- 
2.34.1

