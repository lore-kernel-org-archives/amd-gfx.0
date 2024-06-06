Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4080FC27C6F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C02110EAC4;
	Thu,  6 Jun 2024 21:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eUDc6jCO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B6210EAC8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4dKqQ94tCPfFTdC7hzO13BA6f4oogHoOVOZO9LdSdE+j7z6LSsXxRapJYZmJgGO8MT0EDQrwa0E65+SI552NQAQZ3Il48b3etjXCj8CxlmQEWSl6za/IIedFTp4zNxwS0VweXe3Cjx35tX6sKGc/6T9vNGroZu1TH90uyj61R5osPhnrX00WzpAgZtXsd+xd+VTka70psSdAKXiP2yDVpANfRekeE2Tovr0YUoqw+yGwIjcUkS+O04gnnnmtGilquWOMChv7KYNrdNyHQ1PZo8m7pqatdF7QOMbkeN+kG//87V8+AKnUPPqGJn43n/8ejl6Tzwcazz8/S26VKrDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfYfFvP4KYoQ3DbnvTxVzoaizYQkUYII7JOhubN/fj0=;
 b=Y63ss8T21LTty0qwWS2axHWUqqBkWmshaaTetQTpZWHK5rjddJSymugYXiqExPdz8dP7ijLyMpFkOqy2TaxJijWAyUaSNrFPX0UBqdGMgzUqBrMzdDzWqB6yDCRwbnBXo0R6rlWtwMQwsQO+oLKzljqPVLDIYL+yR2GEvDx9XqzTQQ0/Xu4ymOhV6WhQyfsF1BuQtvRoQKpethrQzJh4lw8zxcPQ7ksojdQ4ENCb6qs3cWGKz6qRgRKNu1ZiLvjfEx6DiC4fWKKE0NDYlkpm4h+SFHxE2zg+p2GUL9mbDW7H7vH8vb9xX/lHvVbiJxTGLn4O8mlN46WSM+4Nqub1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfYfFvP4KYoQ3DbnvTxVzoaizYQkUYII7JOhubN/fj0=;
 b=eUDc6jCOIbcmlhv860NmmMmzVxdgRY3iMQWgRWYuaxBoY9c3wiDrgucNccHM3emcNB6O7tqdFoW3ekxaD0PTyCEYXBX7CK28DvbmBkTECM193MP7h+vvSxKMaR/hdPdQ2sgrInjzdyiyPP4zzAKheqmrIOuR5dDwNU675OJhRjw=
Received: from MN2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:208:e8::21)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:56:58 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::84) by MN2PR20CA0008.outlook.office365.com
 (2603:10b6:208:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:58 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:57 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 06/67] drm/amd/display: use even ODM slice width for two
 pixels per container
Date: Thu, 6 Jun 2024 17:55:31 -0400
Message-ID: <20240606215632.4061204-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1090693f-94a4-42c0-bd25-08dc867396ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3e0uJOU0mPCJuPe8A/jAAnMCS17JxAasmt9YKHElUq4F40XfGSRhWp84aqW/?=
 =?us-ascii?Q?lF99e4JqrqP9EIf+2lWC/b8ZL9DyQmdudMVUDE5sC/bGMCnmvur8xl44bLb8?=
 =?us-ascii?Q?gKFjrigQ5n6/JYDYoykiiOkio6GAb2UJbazYpVBHFvwZitVpyQR08zRNUTNz?=
 =?us-ascii?Q?lx8grwjpU6zH7ui1cyax6tcaflz7sSXC/rqVc2ULVKJRom4ZyO+hiujHMlUk?=
 =?us-ascii?Q?x2yNFj4Nr86TXKUbxkUyFnUEDk0rL80vUfWwnpj8YPC5bUuIa/pPhXF18las?=
 =?us-ascii?Q?6PlPegRYgXKY7ocpB2flmT7pYSVqjRpzaQnEyzcBWCN5PXxvhno4O9F+8I+f?=
 =?us-ascii?Q?BfgLawrxpXQDSSOtRofEWDMCxOOqJZgZkDLFvtHD/bOa/VSCYH+GyDFY9ugP?=
 =?us-ascii?Q?OYWTd30ghGH1t8kaPe1e6QMxaxLGZS7HRbcVxHjsFtSO0Ox6d0tHXVVm6w0u?=
 =?us-ascii?Q?dMQRckjFps8hYCL3dbqmPUZLTkH8dJnnTEmxd4/wZYB3gSKTR30i4OiJmVde?=
 =?us-ascii?Q?8N+5V1ZKLqrNgK8vb/dmp4bdumlk51LpxgnkpwnqqChkDxBuNzK50zuviNYJ?=
 =?us-ascii?Q?qyNJ6tmhyBsuqRv1H7QixraxImXpWqby6YAku+ucxPQPOR14UjbUkvoDmpFy?=
 =?us-ascii?Q?Gu3BwjY6h65bOQsrzQj+9UTTq6y8L0bXvLQT0/O5SyNYgNjrUzIWXEhXcgI2?=
 =?us-ascii?Q?ZqGUkSjIdVX/uXy2lWBGPtzA+Uow6tAuK3i5CcTXaRz+/U3KxBwfyl86qWhw?=
 =?us-ascii?Q?25byv9YDhqH/yVDQP4mJ7R7zKsvgll/Fd7v/wlkj7eMrbTQgqazJ4djbMflZ?=
 =?us-ascii?Q?jsW5OlTi008L1/rvO+CV66SN52y0k8s/rk8I85rxpWYe+oQOE/rUDma7WUJ7?=
 =?us-ascii?Q?whziRvZ6xbPpxBs+vMAv8NRAuxu5rViq0I+FtSfMMADHxAu2q63w2MuYUH2G?=
 =?us-ascii?Q?9UJf3tv38y1gWRHk/EN4PyEDu6WpWg/eSniHKqfg/6r805BlliVfnflSC8Zh?=
 =?us-ascii?Q?hZPWWhviX6a8vwjFakqLoPc/wzv/1le/hkCJng93GzADtQKSqRp0G1L+si23?=
 =?us-ascii?Q?ZDtDa6y6vryP9qb8lnj10Ga/XVS04tmgAAZ1Dm+/zouhRp3sk3pvg00YFI+E?=
 =?us-ascii?Q?pKA+qp1AgVl/Hog4sc0ITnQjqRCHdDpADfXAnVNpzdoVwDziCQcXFoi7NImI?=
 =?us-ascii?Q?5rcUN3q1Pedarxu2wkreyWMzVSNONnNq+W4Si6Bfd+G3zCHrHLn3Z+RehgPQ?=
 =?us-ascii?Q?WsQTHCJ3UJeTqj9r9M8JtX2C0mzXDTbZIcfu4Dq2mKJYpz6grIOrVKSAiwL3?=
 =?us-ascii?Q?X9bI8A7qooDcm2W4gtKP+ApMR69n0irOGv+9BV6/EXZV3yoP85gxobz4vyWw?=
 =?us-ascii?Q?EBhQ24TW/qqDfg4te2ZRrL4wg4ePzmkOEMhFsuTIVWDBo/Z/aA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:58.6537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090693f-94a4-42c0-bd25-08dc867396ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When optc uses two pixel per container, each ODM slice width must be an
even number.

[how]
If ODM slice width is odd number increase it by 1.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 2836f28fa3af..9c6171e90163 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -173,6 +173,9 @@ static struct spl_rect calculate_odm_slice_in_timing_active(struct spl_in *spl_i
 	int odm_slice_width = h_active / odm_slice_count;
 	struct spl_rect odm_rec;
 
+	if (spl_in->basic_out.use_two_pixels_per_container && (odm_slice_width % 2))
+		odm_slice_width++;
+
 	odm_rec.x = odm_slice_width * odm_slice_idx;
 	odm_rec.width = is_last_odm_slice ?
 			/* last slice width is the reminder of h_active */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index a8f7fccfa16b..49c866a558f6 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -441,6 +441,7 @@ struct basic_out {
 	bool always_scale;	// Is always scale enabled? Required for getting SCL_MODE
 	int max_downscale_src_width; // Required to get optimal no of taps
 	bool alpha_en;
+	bool use_two_pixels_per_container;
 };
 enum explicit_sharpness	{
 	SHARPNESS_LOW = 0,
-- 
2.34.1

