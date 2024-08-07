Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D0C52D73
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 01:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B228710E0C0;
	Wed,  7 Aug 2024 01:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CR524naQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA61A10E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 01:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/gA04KqfZP8Z1du1OMR4TcKcxedSJbpGem5XJzE49tbC0i797meLfhwxl49koFs25Demw3/TXsKsu01iXtjYgTIM2hSFNcwexnGlzIbrxfkkzzG3ICLwrcK/TXAp8kWlXuby4FYI5NeLrwBIzCbMzdnBxZJ+fmKJnS7R9ejmR/yAiwJ5iE5gvgnqD/vE9Zcsq9pRI8yCG7V0Pxl3lwgl+fpBQyd5Uc7dd/d1sgbnm4nowxwBSgTubNL985rgbBW3J3R6PgJFui7/IQhxeMLDyggf3qGdyEjzqyNEQi9grrFxXQTUrdMavVfu18vmYVJ5zP2JGztbnx5lvlPKKFa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OtbOyODNzAJvg2jNN3Dh8KhTdS+INMonjJAJ9H0ksk=;
 b=I7bL3EmXFmleucK8m7QUlZu3yjaNUhSDPZlVhsMtJor7GRTnIZiLKQFkw4CATTIL+VO0KkG0KRbeHiueMk5VOSlOtnIEmXFGGMhLQa0jEVw1EWF6Z+3/aEJ05YuFA6Am2lY66fk69QP83AzNxUSSGcmD9WTHKpv7RvxsXcTyE4udOphg9FqSenJINI/ZYuOT09R3JTZDbs81RDzBANiOnzGNvc5SPnUu6fXMC4Ewmo+NRWzQU1oimF6e7rQ/EELHqmepHCYJm6tokf7nsQAERRQYwCYzb8Xv/dUOVlChgY8kialD+oPte8bs2bGnphh6zBn5uVHHbXSEQvR808jbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OtbOyODNzAJvg2jNN3Dh8KhTdS+INMonjJAJ9H0ksk=;
 b=CR524naQyDghRHSEtH8is5m9kREPerV0BgyNfvQQ447BeelzyU8KyPRjPC5a4o/8qUSpxUN7S5HTOkOOqFuvFKguzG0CS/wIKknrhJWIYh9lIDGPJfHWRDu5MX1S4X9R9RAAsyAt6UU/vbKIRO2caWvDrXDcc6IWkeHwr6NKzJo=
Received: from SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) by SJ2PR12MB8830.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 01:21:40 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::da) by SN4PR0501CA0126.outlook.office365.com
 (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Wed, 7 Aug 2024 01:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 01:21:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 20:21:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_plane_handle_cursor_update (v2)
Date: Wed, 7 Aug 2024 06:50:57 +0530
Message-ID: <20240807012057.1192380-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807012057.1192380-1-srinivasan.shanmugam@amd.com>
References: <20240807012057.1192380-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: ea82347d-4883-460a-f9ae-08dcb67f49e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S5ih/bmf0eLJA2z85P+B9MetYggOYE3IQQ8qOI26bJLGrVLKAHNgPbSDjsLV?=
 =?us-ascii?Q?0lMpPZo2NkpQkl7JQ5b5upPdU2tcmYuneYhkgcOGhyBIjmK/6KdpuOcFJSIn?=
 =?us-ascii?Q?7mrom0azSY7Un06ZmkoCa1Ed/7rlWlSKQeGcOD16U4TASIhXH9qm4fNLi+Vj?=
 =?us-ascii?Q?wXxW19ojxv8xgD9cm7Lz/RbaQOPNEM9h1MZDC8ahOg5SEQtMCrTIPmm0D2EN?=
 =?us-ascii?Q?62ZaPAwRZcemvADKtroXxFjazOqYYuuUzTcSzKjznmcyaDfmj0oKvjXQou+W?=
 =?us-ascii?Q?EIh/9jQ0FOoGsOEvNGJ0Zjes4qe6fqQDJ/3/1fLRhfW1G50BNW+31PH/0M5A?=
 =?us-ascii?Q?GZpF3KmV89t87jQnGRPYPb8LkLOqPZfeaDTDeV3cYFAReXr3SXhlBwbL9I3L?=
 =?us-ascii?Q?rQihKrD3/PAkyAQ9plSgwFFRsESMbamUKOk0Ivq6UyZA9QOMtUdStgrZsL9J?=
 =?us-ascii?Q?wlj17JgdidQfNUYSZ14nB20rfpN6c0DfEBzDVkJKYSb/oZkfufXb99g4FfGx?=
 =?us-ascii?Q?bEg6Ub3ohSBDIu5TOqrfvdc6JfkffI6GNiBgPVKZs4kph8M23dh4EU6PuFHb?=
 =?us-ascii?Q?enZqDwad6xiscM0oG45eIYGxhq2pMYAyr8Ub2UrkBVOTmkpvAU4pRcR6jPm7?=
 =?us-ascii?Q?1Nwcrrcdyi9V+fDEvGnCSxe4Rc14EXTaxRjM+Zmp4e5lhxTPQdpUSbuGMza3?=
 =?us-ascii?Q?/OR5fiNI0BrR7yC7oodIbz0eakQ99nZFgDTamN26dRqXVYs40itJdw/HhBLi?=
 =?us-ascii?Q?HPATEb8Dvm8je4rpz0LF7rimcs88RPrIqIgSCEnDaTWyBTrFABB2SZ9Ma8B+?=
 =?us-ascii?Q?AknFQRiiwoYnTYQWFBYzKpCjibanZnxjUyiMgIQkGWtqhA1LPn/qUjHws1gb?=
 =?us-ascii?Q?RsietLMlYCrF6DDfj/CjvxDnVeVXZAWX2LT8jN1ziNAZdksQ/Y069lzvr839?=
 =?us-ascii?Q?RdlP8dCcLnY3/Ez4J6/sA8C4svPZv0bXTLIcAPuOeO4pqe6kw1pPbyAKT0mN?=
 =?us-ascii?Q?oJf+I+1oua62YnfaYhJhSM2zRzgb3ZB2rIY244NItwY6V2P46YnyRReIUrH8?=
 =?us-ascii?Q?SgYt8dpdeYRPGdChgceeDPnyVu1A9g/1qzGRYMZj2G3KJXOqynzKxnhgJpHz?=
 =?us-ascii?Q?ullnIVg/0MfZ0acxiGMa1Qu4Z4bsn0GZ6C2+lnXwzkS8ATxKxTnAhgT5WcZy?=
 =?us-ascii?Q?H33njEnbs2cUsoFpDeiZrjopvPV/fNHfHKOMlGYxgYIOMbQ5/1tiXXb7X2va?=
 =?us-ascii?Q?CaPIFBWIdO6To8WASdoAh9Y8wHA1yUcOq6ry41T+r1/0IDym7GxjIq/Q2978?=
 =?us-ascii?Q?msbg+pJH9wZUZ2gmsYSrTkMvpG3Fcaw8tSvkpPpgL8g5tmmyZvkQnZXDX8yN?=
 =?us-ascii?Q?MAx+1xv3YElLz69x44vOzgEi3sVA/kZRUg34eJWPhM9BuZjhbywzOiZq4q03?=
 =?us-ascii?Q?OxXO8lgG67juMQgTO+Ry68RpHuMDrRZP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 01:21:39.6093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea82347d-4883-460a-f9ae-08dcb67f49e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
assumed to be null, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Changes since v1:
- Moved the null check for 'afb' to the line where 'afb' is used. (Alex)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Co-developed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index a83bd0331c3b..f8ad8114053e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1372,7 +1372,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	    adev->dm.dc->caps.color.dpp.gamma_corr)
 		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
 
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+	if (afb)
+		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
-- 
2.34.1

