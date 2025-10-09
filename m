Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053DCCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F3C10EB0F;
	Thu,  9 Oct 2025 20:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yGrRCYYQ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038DF10E244
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDOB6kkamZI5Nyr7+KRWJDdzrWk3p1uWKod9Ke4+n0th3vqqKgvoV2lhKn5sP+fL4I8DVpJX3DcuCQAf5kxl6WyUgrBk5pSU0iS+pi4AGV/YOEQX5N8EnWcPH2MOrQSAt0Ls/GFNJfIoWD9dr6sNYpLSfrz7ejZsXgWRKpliAMdLOkeycf0fLWrQ74200MI2iykAhRebzAVUq2uO06Ny0VV2cYfvQAcG72poBnFnpXeMHQQnUD2a43l4LikrYVQ2g0AvriPDHT26y0KEOcJCMNYh3LD30gmxclEssEgrRg2Jba8CoHLKC59012S8+oRNPH6Xv91fONQUnbZqsyyiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1+cDz+r20fjBVJJ4jQdJDgVB3EX2UrwUthZWTdl9P4=;
 b=ZA1V+InZ7tx7VUtfX7doZSps8cMsS7LDpsg/cyYrL2znd+NILOcxu7nqzPOA+TBbMrQAeb2jv8cFEwktzZxlwyisbgfcsFExUgkTGICg0atfwbD/HtXT91jNThHSK6EUesfSlwHuUDBYLnr2rlzN5KAo5fthVFI/zbgDRFmnNcV6BtN26sLevQMGCzzvcImgSA2oG71D1ZDYzCuKaHxedNWH1zPorO/rLYo7ZBXUMtB4fF8jJVTFAbd2ahRjpj+z6KCjV1nnuAGArw8WszIvLUMIfzSX2vZQfg4XYpfthUxLPXQKqYTZkJtmlipVUmMKin+lbg/lKuW/TSFdUMw7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+cDz+r20fjBVJJ4jQdJDgVB3EX2UrwUthZWTdl9P4=;
 b=yGrRCYYQJsOGffckt9lzixSO6var8u1nvTF4doxcToSHYyfbApqEHNQxrmFne04d5bZ9PBdTpvj+nYG7bv1VzwUi5d93yN1jpxQBo67fraDvddCCGL59n8s+xEBmvrh/lo0zcIh1XNuhs6IqlR/ERrvzfkDDcXeZBcWldrg6Nx8=
Received: from BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27) by
 DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 20:55:57 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::93) by BYAPR01CA0050.outlook.office365.com
 (2603:10b6:a03:94::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 20:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:55:56 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:55:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
Date: Thu, 9 Oct 2025 15:55:08 -0500
Message-ID: <20251009205508.175269-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009205508.175269-1-mario.limonciello@amd.com>
References: <20251009205508.175269-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 697d79f0-9ffb-46a4-a76a-08de07763e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mej5EZ7LDsnPHZbYvaVFNs38Yiam9fops03Ic+rBaE87uGpQr9z2tzxitmRF?=
 =?us-ascii?Q?mkPJzlzAqyFjsw5gadSqeMmc/igF0qMmRVZNUV3J9NT9Bkdq5tG57mOkXWDy?=
 =?us-ascii?Q?rez5hlAjTjw5gEBghdKSJ0lAiqCgELRAgoxsDD3PbDLmLurGNTpOmd789olG?=
 =?us-ascii?Q?jgXuwaQbrley9jOhOC62f2eY+yi9AN7g1A5LF1UevIDmK2Z3T7wtSNAmovJz?=
 =?us-ascii?Q?HvrPayrBN18RwRqL0/66BVUiVemVMWIaXfRcz4rP8qIqdOFM0zbp7ZRkbxYm?=
 =?us-ascii?Q?f4tY47pFZHevEctkfmYPpnFTAOoHoxf2Lg+/VScmRvpx8y36PD4SgJF+FMba?=
 =?us-ascii?Q?GedTOcw40TEnyP7pOxSg3ny5zPJF54uxTUzFeN+1UBhxVCGlP3Lj0ZsLGfHP?=
 =?us-ascii?Q?q9tLhfigGTRl109XbXpuMP3qc586Xt6CN+0gS1dC6WLv1Vu/FIvWQ8o9IMuW?=
 =?us-ascii?Q?idnB3Nry2Ch6OgSG4La4eyTlB/dzhMXOCm/QfWI3NYsq/T0a7ES2Fe1LMNP/?=
 =?us-ascii?Q?X/DTxSkrxIXhRIrjpAhxjVT5X0GBGzWf3m3wLFa+RBHm9RppCLelmgpSAqvt?=
 =?us-ascii?Q?qUYbyVf/vJW2JPDJkPq/3m36ZOzfJjAl1jPqUH+mzMpO/hiEFgLLCUFdgmPC?=
 =?us-ascii?Q?b78bgElFvlulhZKUJ3Z6FAlbx/ZCqKqpaB+q0fGm4/GdYVvak0hfBrqx+Dof?=
 =?us-ascii?Q?wlltAjH8Fj0W79Ew3NYwy6zOMW3BpW1A+2aZ8BNse9mAJvHZcpaaWbw0TI9B?=
 =?us-ascii?Q?j+v0P6qrUdtZbfjjoMJcBx2YQVa6vdUmkzkSUI2zs2NZvsYFD9rdLJQp+NTu?=
 =?us-ascii?Q?ywqzMn+hOQu85QWl375RqzuNS7zbB69WvR0ozmDJ2us/pQ5afO5moC2/M4VH?=
 =?us-ascii?Q?FcbPMARrvaKV2na+h9yOERnKac7gKZUAb2hg+A8BamC2jrzJYlKyRjS3mPDe?=
 =?us-ascii?Q?6++2m5NEB/sfhOSxxzV5CrPOc+FWUM72XXeQfzaeRK/qLo5rJ8+W5xTSEU4S?=
 =?us-ascii?Q?YJeAw2xw6so/iB9VmWFeX7H14HuH/7NozWzxwFzjU3pQaghtWNSsElDCX1ms?=
 =?us-ascii?Q?FyaKeK9w6udgti7vqKn3fde8OEgo/8rTBXeZ5BaT1Ou5LWi2MhtSBnDLwXhW?=
 =?us-ascii?Q?MowVdHYo+Xky+JO1jf/SgVZTtJtgC9QKDACfM+zdghXPCMYUKqyWJA3i9rJA?=
 =?us-ascii?Q?G7sOHU7PrWQxlhj5hgtTVb7+95AZu1X0Sx4ktEVi51lPsZgUm6zvAcSRwk6A?=
 =?us-ascii?Q?yFI+cQvsp0UQ2Gt3IMLTmDzvXKhNHyI2bsqyVurUSHdOY39kC+7L/Nrb6qj2?=
 =?us-ascii?Q?bzumNV06sbiZWeaka2JKQl3DjTqfe5Guau4ITBA5ehQit5NjUFKbsWX4Nl21?=
 =?us-ascii?Q?4HNPGZO8JTqcaULk/znnCpPUdNMnshAqCi+PScNimC4yfmb60kPARy1XNrb5?=
 =?us-ascii?Q?npLtaE4ICI7oMDqsdK8WmNjL6WzBljekwpP63rNZsLdD3ZDWKMtFd8W2PfzU?=
 =?us-ascii?Q?EI1aLVa/UvC/RKg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:55:56.7410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697d79f0-9ffb-46a4-a76a-08de07763e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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

[Why]
If userspace hasn't frozen user processes (like systemd does with
user.slice) then an aborted hibernate could give control back to
userspace before display hardware is resumed.  IoW an atomic commit could
be done while the hardware is in D3, which could hang a system.

[How]
Add a check whether the IP block hardware is ready to the atomic check
handler and return a failure. Userspace shouldn't do an atomic commit if
the atomic check fails.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f5be090b744..5a189deac631 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12014,6 +12014,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	trace_amdgpu_dm_atomic_check_begin(state);
 
+	if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
+		ret = -ENXIO;
+		goto fail;
+	}
+
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret) {
 		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
-- 
2.51.0

