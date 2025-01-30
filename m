Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F12C02190
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 07:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6A310E2DD;
	Thu, 30 Jan 2025 07:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YvtNJsxl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A76110E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 07:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xez+kv3WMkzPKCKahSCcF9Pk7gkl9GzP7tm7vaisNEZkcVU3qydhGP6SoafTA5KZ0f8MPyIKTFiXSKJpqAeZaqSer5A+7B4lWA/jyLGZkguKDuhmdMmS7xlJQP/xF0L23P7blGpkn40mgBwgp1MowjtfFKNh0nRW6ik/+m9vPb0wm6s/DSQ7zLud57yTa7TELmc5/WYxqvi0py45XJwSEChRDabpONzGQw6oyHFQWQ8dv2EIiTzfW6ZO4GG70M7WPv/UsLz5TUxuvB+hY2Raynb9SWgvS15SYM8W0wkYHF96TN+YrXhSZ9vLGpGOArlPlGeUBjfKwEkdQKEMNCQhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeQhMt9BH4ixMVuisljPsIgXH46BptOvGEm4ekTNkH0=;
 b=jrZHLIyBvXj4jp7aqhai99axKzcGHEpq97JpjncAj9IrLACF7wC0uqR7VK9uKalPVk88LccLvnp2EVDJ6VolY3VQl7p4JXiNvbQ7XgGKaMq10yPIm78rOcJV2e4FmuIqiMTvQvIBHtVlO6GkaAcmFIQEcZ9C8q4cxQkk0v1DcBG31ZBSLciZULji6PdxiaTvMmyp6IY50Y0HSl4O2GvRoPRJASiuOXg12hFdrMkz0tLVhtRrsfA8p0jh8z38qnX/vxxzRY8bOgw4NhISqMOi5hlS8JlatHGD2glcn590P7xYg6SmE2NfW/rOvt9asf+c/4xoufXuwZxTOVqVVxAAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeQhMt9BH4ixMVuisljPsIgXH46BptOvGEm4ekTNkH0=;
 b=YvtNJsxlLbYlhvXD5cEI5etZ1LWo7Qpt3nzymib8XJhiZCvr6/Z83GZumyY5woTSy1bnW5WLEkCyPZRWoH8e8kW5HwUwFOsPh9PRgGxD3UUOYxNX8Lk1sd5F3yLC0gDYst3TmbnhPeBBf/KG8XeTKpzqk+9JOxMVcMe6UBw0Usc=
Received: from CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::12)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 07:32:25 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::e2) by CH0P223CA0024.outlook.office365.com
 (2603:10b6:610:116::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Thu,
 30 Jan 2025 07:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 07:32:24 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 01:32:22 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Hawking.Zhang@amd.com>
CC: <Mangesh.Gadre@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH] drm/amdgpu: enable gfx clock gating for gfx950
Date: Thu, 30 Jan 2025 15:31:41 +0800
Message-ID: <20250130073141.2219121-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 329a03d5-9660-4694-3cc2-08dd41003dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EhhtkUe8dMk8U1yVWoKRy7UOEU8csL3PNpGjyvDzFsLO4Yh69s9LOAU6dYSC?=
 =?us-ascii?Q?lHfpsqZaC2EmT+V6VBMNqRWRL3mYZqlKYr5TGkwefmrxFooy7hzHMHSIWf9w?=
 =?us-ascii?Q?p4k/3Cknmgm39MPOF42uXUYSZmYk3pGzAQUTU2Dm2Nb5HYTH8mV2dqeBwkwT?=
 =?us-ascii?Q?mzIK23pzRjOFz4mL64of7GpwMyYNCYwaK151D1t5QfA2RlsPjTsVLu4NLxZH?=
 =?us-ascii?Q?MQE2J7X2YHJDrw65c7tNiQYL08lba7yt5pvSPXsKoe0biTa1vdjyMBkE5+XX?=
 =?us-ascii?Q?m9W7DUzvTKQdSnlDmRiWIt1tkki1KFUqmqfWH9NOgCreIEA4wDEpDKBZeQ9F?=
 =?us-ascii?Q?Z7ZDSg6ZsF8mfNHKNHazLe7vmE/FbGZ+rnZ398cwWg3wecZRksWv4muv35Hs?=
 =?us-ascii?Q?CEdGc5G5Hc63kFLDrvoUMJESrvPJULkLsi/e4la25Q+BPQV06PSzd7ouIYPm?=
 =?us-ascii?Q?ej7ecsDH6yLvWfLIL+DpbWemIgEkyZfrXipBIVI4reZD+jC02MjCK4UnsJp6?=
 =?us-ascii?Q?mb/v81WQFAGrxm5fO9C22ysGsPUMdrw/GrwiTtxDeKW8ziozAHmaek55xL3R?=
 =?us-ascii?Q?7ad9H9GSWsShZ8xdFJJjoAdsKovyEA3vBhgeDMb2bcYR7YyOEXG9PDjVv5mE?=
 =?us-ascii?Q?+3NPk9EJU5BEvH1NOvnttGrFsUraTlmU4z+TKOMYHP3H5ewJaaUWvHAcgDhh?=
 =?us-ascii?Q?FmYGKjTGM4wOlTsufTGcLyqHDcprvIdkKO51GCOAe2w9mTfwI+RnNwSSoMje?=
 =?us-ascii?Q?znkvzocHPbk5wJqEvPb0X0YVvVevyD719/ZkZxTy9yNr3As/996+syIERkrl?=
 =?us-ascii?Q?X971uSKX0kEbd5nIpOyeOSG6BMgXEVHw0riU+1U19J51vecd4wgPSW9SsgCz?=
 =?us-ascii?Q?RXbUrg/6LTpEgpcztPkmyTmebksiWuVzI4GrMmZ4IbuHqFExNmLE7JFjUK6Q?=
 =?us-ascii?Q?jVOV7DhD4laKC2cjjVUu/qjyuKWAd5B0Kt/LItu99AfDqnx8UvH/HpvEXbav?=
 =?us-ascii?Q?W8A2EFgOXpStOyxBjnd2fNUFfIMjbHt3h1mFE/HJ4ecQINhSAWkW0oUeTJCX?=
 =?us-ascii?Q?zx3TwTVNLQckBuqgCPysz18ytRieXgP9ky+HrPV6LJ+giNW0Du+xtLizRgH0?=
 =?us-ascii?Q?iETIi+l2MMnZjB0T+TbKT2Fdxfl8WUd+WIi0kSkNXM0WGtiaRVvqlz1Cxj7s?=
 =?us-ascii?Q?eS6XQI4i7slPw/PYlEWN9ADgHAGzUMFUW5MTv3k4vj4/8GaCf2UmwdjHdBry?=
 =?us-ascii?Q?Z0Ho1JWGCYI/9FEbz0otZgw1m56osnqWuSEI6/6JbrrQc2pH1616dPHukuL8?=
 =?us-ascii?Q?V2NSqOdSydyCDgtY2g4oOhMPd5HH7o3RIhGYPjj7Dz/0rJRLr/VFLYRdV787?=
 =?us-ascii?Q?CVOF7j/h+Rj3tuXEAcgG5gj6kUMRzDSDs5iGnYoO+tA3oBZfmTWJgOzY4KwE?=
 =?us-ascii?Q?/3owti0Y6KNmxItZO9Z7s/9IakApbaCp9BKTvHHp3/2B5U4CWhm24RsyPi8V?=
 =?us-ascii?Q?MXAEaeUB/8qlYIA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:32:24.9149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329a03d5-9660-4694-3cc2-08dd41003dd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

From: Le Ma <le.ma@amd.com>

The CGCG residency can be observed with the change.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ba185875baa..28a2310a049e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2798,6 +2798,7 @@ static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		for (i = 0; i < num_xcc; i++)
 			gfx_v9_4_3_xcc_update_gfx_clock_gating(
 				adev, state == AMD_CG_STATE_GATE, i);
-- 
2.34.1

