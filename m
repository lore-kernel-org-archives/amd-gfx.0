Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A078C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 07:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD01A10E3C6;
	Fri,  1 Aug 2025 07:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3WMTtLa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED1F10E131
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 07:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuNr6EpBJw8DwFI9xFvR6RAtbtC0WvzBJWaNMkuo3iYq/PTXJWNAtCro1VuhFGpkITwxbhKvG5SJtHTVe9w8y7AG/zYoZSnBAFT8ZWcV56P0HErMkNMKW/yYZxTo6BwTf3ujgrfumK9L3iqKkm60WuJOTB8W+GTJwt8qaWB7fr+PyNDaNxpmlluwUBwPTar3CW5tstKbCfgx3EFE3TBfxKKdUJVlSBiQFh4IVOEZJZqCXYnPGdBBJoz3dthjpFWuFjaiD9MHKY8owf/6e8x/1Ce8jRVFEiaUXhefcppklUaI/oPY7cjkeUrj/VGkioj1uRhFcKSdG5n9EtP9CAKdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+15hk65Nwx82p2tqTFb7q/pJ3b96/muLYdiKqeH+KuY=;
 b=dk7ijN9Z4oWuFAByk5ElzR8idkHsgm2mnnoBeyeqIrL+Tz4SVyObAz/YQGTIvYUfrh8eCuI2F1D7dMLn9v78bn1tVcWZnDo2oxnZ4//XYBCUBSPsdZCjhn2NjAz0l6z0vlA60rAlPZaqqJmFqQe8PDVY1dMBcVe8Fnub9ymzHWFYVdNpb1PQQJRU8GeiZhKJS81mPQV6WnsbVLQGsa06ytyn332LFffNpmvAet2MgCXbJgTWKGlxrTk647szNnsXMfkBEPZtiWBsuuHG3E0VWYSgndZd48ZqPl6vnLRABewrXsXLHlYFUTPTbVFOkRTBtxICBoKfYx0rbepaMYcfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15hk65Nwx82p2tqTFb7q/pJ3b96/muLYdiKqeH+KuY=;
 b=e3WMTtLaTu63U9kn4lejop7kM61ZDyjPnC00ILhB5XAxTZIzIS//xreCbUUQZYKgW0DOH7UzThNowDwZSTxq/tu6TuqdQC4lAUHM/yzBnpYdVvG2fcvYq5EqPfClkjM9iy46vKvuUPQdr/Qwd66Wetm6VzsqKI3iC69g5uCZ5To=
Received: from BL0PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:207:17::15) by MW6PR12MB8662.namprd12.prod.outlook.com
 (2603:10b6:303:243::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 07:40:23 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:207:17:cafe::d5) by BL0PR1501CA0002.outlook.office365.com
 (2603:10b6:207:17::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 07:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 07:40:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 02:40:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 02:40:21 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 02:40:20 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update SDMA firmware version check for user queue
 support
Date: Fri, 1 Aug 2025 15:40:09 +0800
Message-ID: <20250801074020.4099827-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 789f68e6-06c3-4fd9-e9c4-08ddd0ceac24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WzkgIIm8VqAZu6cCKd3ZHqOrStTJjP3O+JP30L4dGxVNp407/5Vu1HMgMcxx?=
 =?us-ascii?Q?kg7aO3cpU4JXBvriHNctnZmHfPiDSd6f3nXQQZA2WKoIEfDNGiUjuuE3g6pE?=
 =?us-ascii?Q?nkW/MJfvb5wLWxXBD1hQo6x/e8PFqzIdOh4MBM1SvVVehoTrxwvMCwBJu/v8?=
 =?us-ascii?Q?qoesW890Gsah73tlht8JJCultR5F7b2dbaaD7TrZAhxZpAxbeIg8MxdGLH5u?=
 =?us-ascii?Q?B2ihXD181f5h32PYHarem5skrvhXb8mEIJXqNGIoIeZuWvGNozbTpw0WvX9L?=
 =?us-ascii?Q?N26OVEhu7QoSAjMif6Bf5T1FDhKmfwYp0OHBQpuo+Me1tcr+K7AEtLbwtHMi?=
 =?us-ascii?Q?rk/F7FoEpvA9L2C189FIOBFd7gI6lbl7MybeSamQypFVZdYMWiRjsttEpX33?=
 =?us-ascii?Q?hSvzITc8PJ9UyFi1pHkrJSYJpbvZFL1biVYakLB3PIvGP3M4O22vzSrsD17Z?=
 =?us-ascii?Q?aA/Hsxo2kx5ty2YLIvWdmTicT9UcAuyAgSewQzI00CztEm1FsbXc04iq+461?=
 =?us-ascii?Q?JZus4juFsppLnuorN2OUpdQOhPDKkRv2j7SMmolEfG+FJYkgEarK4eifiEfw?=
 =?us-ascii?Q?jWE8qjIVLh1HlDjxWvdgSnl6TXqKEeRtDFFtPo5NjzD3TGeibhBdWnu9TI2n?=
 =?us-ascii?Q?rO3mykrxAib2NotJpHNSA9pbA8Rx6jzdXt1Dxn2bYC2xzuZawK9vk4p2gIaj?=
 =?us-ascii?Q?fvpBGCUwJypizc5XMTK4xKTRvURS+JVOZjA9cJpV+u63ldYJfyrY3hYEzr6m?=
 =?us-ascii?Q?XJrk7bmwuflJ5OvWpqM5yK+gTi+t92uhAADmED14a2VB03oSataYxhoPMwLv?=
 =?us-ascii?Q?z0Cca8QJCZM25G4t4I6fggUwPF6F6qhghYg7Qb/V1w4YOyMed6cC70XgfCVF?=
 =?us-ascii?Q?86xETbhvmLZO2Qb6nFtJSChGxWxoMd9rRFM40mBn6Jmqw3j83HByg7XrjJvV?=
 =?us-ascii?Q?i2dgR5HKTfP6ZdQHc+8LojWZ63PwYFskJFZeJ2lB5eAgGYF9p8rks1DIcjTa?=
 =?us-ascii?Q?dDTEtXko/0R1DsHFavJgV8xaYzfciGz+q2GUKB8HzZQmSvmLHR14Jo9Wk7Wk?=
 =?us-ascii?Q?mckDJh6mSyGvOkOpRCJ5lMqU+3EUJlMc7CeZbeoTRLz9nK54V1s1mqQaleXI?=
 =?us-ascii?Q?8LWzydQlVlM8VskAa2uK+mREiqZs81/4Wr8SIrL97UrrdX/dk+8fZTHCTTg/?=
 =?us-ascii?Q?ybURDfteWbHxkfhWr8volx8mkXaG/xqPZ7m71bjV1HrTwEMDy7ICUyMVu+pj?=
 =?us-ascii?Q?9IoP+o1NYPnIhF3WoeyDijhg70QYJHnazSiObS4j4uaEtPYPAjxEWDo3oqZo?=
 =?us-ascii?Q?BOZGXTxg+JFBZvf4t/iR098pTxWRKXpudFk//cwzDjHnNoVCENEytfVDjk/3?=
 =?us-ascii?Q?r31audzWTsP05+HzgtgjLlggsdMKf0loKnbfbKYpO/SuDFkRnXqNNjTsVeib?=
 =?us-ascii?Q?rhkdHYJykcdSa/wzM7LWTRGEI5+1gEDr4TOdT0ohpZs/tTESa0AwnHq6e83V?=
 =?us-ascii?Q?GH/8AlAv6v2RbGNWG0gXpQGurbZ5LRe0v+JK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:40:22.5997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789f68e6-06c3-4fd9-e9c4-08ddd0ceac24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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

This commit fixes a firmware version check for enabling user queue
support in SDMA v7.0. The previous version check (7836028) was
incorrect and could lead to issues with PROTECTED_FENCE_SIGNAL
commands causing register conflicts between MCU_DBG0 and MCU_DBG1.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ba1f3e3b6eb6..d50db12a44a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1357,7 +1357,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
-		if ((adev->sdma.instance[0].fw_version >= 7836028) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 7966358) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	default:
-- 
2.49.0

