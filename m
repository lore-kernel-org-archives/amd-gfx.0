Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CBFEE49BC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 15:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8815410EA36;
	Wed, 11 Sep 2024 15:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="auQBVOFc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5E10EA36
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 15:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RT2Rl/MDTjIFU9GsMr9cv/5u0Z5ALHlOMi+0p2yNHIxtaAsLhPklT/2TFji2PZeh/gvMvfcpo7i2t8PMXScZVdrfttHkmDshaSCqHhx7gysWcRyevngYpFNR4F7Xjv8/1fBBCDR/A/xDeMVDhKYEz8xFdvqbxRUae/clZgr0hGeehNGfYUm8KK9HtiZR3k3oFVGf/wpqJ4CCDtaaFaIOmHTKEVji/DArSQrRE/W7Gb0qg+DPpImC05CETwkPJ2aO4bcqKwClPh3hLuo+DMVxDkkICpBAij7rYgKRaiNZiFkbpo/DNdh16acR3JcFdMyXddwq+C6s2cPPZGHcQEtsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXGLOlPxwSC/gQj23INdpvsYAdYMTKcIAtGODOJhHMM=;
 b=irFgWRWzWQMTX8dnc6wNKDNeXxpploE7AVu2xVF4UHA+MW25VnKynU/6Lnma4YKXvvAMVmaj9eK7ZaSjBZOBVsConqfPYGMQqDzNbkYIFqIAHWHKAFqvCV5BaG6Fpn01LawNy1RfgQ5J7v5FGudbrlvcVqvdkifFJCxxSEPrsaFsejhn+g9k0XL1g426wIipsID3uJCfZCWXa+7BTa0lY13NqEr6RvZeDIYg5WaMVpHTDx8xrq1/yQLeP0mvUvOBepDKqc6OcaDoM9hV6GEwE4NGKwjKAVRuqrO4CntrqZgNP2AmFofSPQsyYuS4DF5+n/TEuWnzCCKCWdO/l8Vm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXGLOlPxwSC/gQj23INdpvsYAdYMTKcIAtGODOJhHMM=;
 b=auQBVOFcHGbhXL6Hf85ETnbrD23xU66/jHh7qqcvHQ8BzL6BOUBHzl4qX89c0ENTOT16F/bGZGcq5YTLq/xKyBgW0rZXKISUbgjqII2R2wK1DAnFf3P5Iv6LIW2EG2SHXOxDjlagSCc6+b/VnRBnmqjLew0XGmp/QVOkTCLEgBc=
Received: from CH0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:610:118::16)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 15:47:36 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:610:118:cafe::61) by CH0PR03CA0303.outlook.office365.com
 (2603:10b6:610:118::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 15:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 15:47:35 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 10:47:34 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH] drm/amdgpu: Fix selfring initialization sequence on soc24
Date: Wed, 11 Sep 2024 11:47:18 -0400
Message-ID: <20240911154718.39846-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3105b499-abe3-46ac-600a-08dcd2790e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fiVuPfFiLNv3xv1nyTdfvnuB6FDA50XZEZa7pO08yW+1gzNF0qp71SSeSrMy?=
 =?us-ascii?Q?or89gMcZHgQcgpzmXYpLFyhRsvs0KKjO2U3DQf79cz0QnxxSZt6PYPCF8lw1?=
 =?us-ascii?Q?t1Q8DMqPr85st6dFJzxJzK490pcdgVv4Uu6NKkQwKT97iSgqdVyro/J5hJVj?=
 =?us-ascii?Q?UtW+xc+c2rN6R60ilFQGu9LoNJ8Qm1CId1B7UiB5/AcCm0709jkqlu8P1LJ2?=
 =?us-ascii?Q?+PK08lwbG4v9oiWUiF71x1Oc2plREP2z2VUjo1/2QyuWViIhPy8FKLuxrl4u?=
 =?us-ascii?Q?7Lo1wKPYgCW7LFMGiX0Hj4aATZvGsvsXlqs/Zyj/jP/kNh0b0PNJlxzjjbZ3?=
 =?us-ascii?Q?o49aHTsBsrvMn+/osIEF8TlA8ixEAnMxWGqlKBtLv2qepc9jaEZhSZbK5zoy?=
 =?us-ascii?Q?dqzUm2sbM3K6oB+H3S7o65aGCKQ2+F0wLcAruUUslAibw+aeT5DltleKTCQI?=
 =?us-ascii?Q?tvrj2VNm2ywr4JuaSGP8Yjstr2aTKjZMpbnFJzxDdsxIb0WZ6tXYlYf1BFed?=
 =?us-ascii?Q?asiv7z29H7BMZsFLtLhVQRJChnj9jC7btPjuxYV/TqLRle/8T0FPNpUc1DrB?=
 =?us-ascii?Q?DRXA10mzUll3HdHPtPz/qYV9wv8gk/nhge9KLZnnaPlBGMPj1fsn2vsnrJVF?=
 =?us-ascii?Q?6X5hbHBtn+lDqJzxkFDFr0NLJwXW9sw3/ubWEG+fdKVDv3qv+M8iOtEGi7Gn?=
 =?us-ascii?Q?Nb2MlHNhRr7FGfHF0n5s8JhyCobGPa0jn2wXhkmECfMeJMbemVCgtDO3EC19?=
 =?us-ascii?Q?0vu57c1BbT7GmxFWl49sfaTaIu89ybVzUfpAgf9M5PvVFlgaezc0shPgL0M6?=
 =?us-ascii?Q?/ZluG2jDfMnbMbCdbIHRM4qgXFmzx1XI0koJbxSLaiNdLwayLDTXWSi41zca?=
 =?us-ascii?Q?+AF7pTU7tSTK3lTHh69pAI2Nt5iS0gd52oyWYLskmL3tPGmnJYE56LYbvGxD?=
 =?us-ascii?Q?AE6PU057+ylVQ3RpOqWKHzRhIXx1Uk3a/j650XrQUSVCjREjSZ9dQjERgRTe?=
 =?us-ascii?Q?+sFfSXlDrlN6FanLhmtS7Mq4C0GWVyDUuIrfpndlvOydZTHFExXaHNkTw0/A?=
 =?us-ascii?Q?+PNbItFd7RPq9Yq6Rd8b34cjn02j82mRZZ11/tdJOxKKDziZp4MUqdRBxw0P?=
 =?us-ascii?Q?0nwUS0DqbelQ5qhSa1K1LVROYZ+nz2/br91LdMAAyeTm/My6HBt/TWnaB8o3?=
 =?us-ascii?Q?PzsnJ6mPf/oYX67bUiCgLE8iVS6qFvo4I0/eiqfxVaRQ+qUGa6r7JuxOuJxu?=
 =?us-ascii?Q?MKnazhomUEnS2PKMFKZj/GG8tc6loJqRcXqDGyly2XUfy8BU8mzRcj2BNOWJ?=
 =?us-ascii?Q?py3J54EDErmCkYmr/Ov4yw+6+j96OE7+B4FrVDTge72S7iUs8fIWeECD/E7k?=
 =?us-ascii?Q?nD2X3PWIvfAd1AAMQ2mHf/qn5rKqcvZ1Ah2XQe0WbRxP3gUKPpwg2xpnKHZP?=
 =?us-ascii?Q?PcQQXYHDgF4ENdKQXqtrKKpILTT8zZkD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:47:35.3674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3105b499-abe3-46ac-600a-08dcd2790e67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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

Move enable_doorbell_selfring_aperture from common_hw_init
to common_late_init in soc24, otherwise selfring aperture is
initialized with an incorrect doorbell aperture base.

Port changes from this commit from soc21 to soc24:
commit 1c312e816c40 ("drm/amdgpu: Enable doorbell selfring after resize FB
BAR")

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index b0c3678cfb31..fd4c3d4f8387 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -250,13 +250,6 @@ static void soc24_program_aspm(struct amdgpu_device *adev)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
-static void soc24_enable_doorbell_aperture(struct amdgpu_device *adev,
-					   bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version soc24_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
@@ -454,6 +447,11 @@ static int soc24_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_nv_mailbox_get_irq(adev);
 
+	/* Enable selfring doorbell aperture late because doorbell BAR
+	 * aperture will change if resize BAR successfully in gmc sw_init.
+	 */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -491,7 +489,7 @@ static int soc24_common_hw_init(void *handle)
 		adev->df.funcs->hw_init(adev);
 
 	/* enable the doorbell aperture */
-	soc24_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
 
 	return 0;
 }
@@ -500,8 +498,13 @@ static int soc24_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	soc24_enable_doorbell_aperture(adev, false);
+	/* Disable the doorbell aperture and selfring doorbell aperture
+	 * separately in hw_fini because soc21_enable_doorbell_aperture
+	 * has been removed and there is no need to delay disabling
+	 * selfring doorbell.
+	 */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_nv_mailbox_put_irq(adev);
-- 
2.41.0

