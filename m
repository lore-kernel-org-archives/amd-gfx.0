Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A2C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 07:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6354310E5AC;
	Wed, 31 Jul 2024 07:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wHJg8JKt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C937B10E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 07:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myO0ah8CpmGNt9NrtKhw3bi/JXRTYvDPTw8a8SHQL5fUqOcovSFPtSr9DqwLZDGj6EmGkd4198snjnhcMwu0LsODV0tccuiJhe2ipwr9b4xYRLZVVArrCNQql6H5tutJph2bBBY2vv7jnP9wYi1NgYU5TM5UH/12g5D/jIr1f9AdHCo9+QDvao2cCKennZCQhCdmTH3y9hNNDyeC2W8Fyftx+sWdN4HAT2MQ+4wnSk81Ym6DtaEPvgKHAfu6Nk7a4eYWyDkPMGt4VO23i8zIgfQKexn1vtIbokLWKSw5YrZ5Ka/5y5dr6ClTGTaZl2hIZzMCDNcM/gfmDV+C3sdb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=no3/VuY/4tXb2q8Z7bSR260mUhzsDiKEjVy/Q+9ekoo=;
 b=ORPuxDTaMlMjx4lKztb4eTF1WZ6DZqCp2d3O/OxAoz0+IfgXxwlggcyZ4hrDB7UQskBu4d9j7j6H/IjoHrRdTdgcmh7wkeNifBO4MDtrjkeuVSVdWh1We+hXM+iF2+R7s+oSj3wZsJRR2/pb65LFgi4UoQFIXZhtYK7q7t3174iYrC0I4A1cVZWyH7RKl4fQmmxYgWibYD5+0BA2CyWbOLYfAfFFKUl1O9SD35bH6XvgL8SyxhcVNwqjYn45EHc7xbFze9Duhts+NXviIJVKTu5XVyDfH8PNDdChvQYftL9nqjv3z4vagxu2JP2snlYXhmUDyJY9dKkLUnohncNdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no3/VuY/4tXb2q8Z7bSR260mUhzsDiKEjVy/Q+9ekoo=;
 b=wHJg8JKtj1ifYAVBZzh456iHrDg9JNIuBitCgn42O18IP5KkvX23jB/yjt5r1vhDn+wnBa+GwId6n68RtwxvS0E8jGqxObU7X++eMDzx2+0RrF7P/CUnvNeD887lPHVQcN1ArZVUgjmWf4a3epRLAV/oF8J39Ph/UP73mpJZBe4=
Received: from PH8PR21CA0010.namprd21.prod.outlook.com (2603:10b6:510:2ce::10)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 31 Jul
 2024 07:57:54 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::ab) by PH8PR21CA0010.outlook.office365.com
 (2603:10b6:510:2ce::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Wed, 31 Jul 2024 07:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 07:57:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 02:57:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 2/3] drm/amd/display: Add NULL check for function pointer in
 dcn32_set_output_transfer_func
Date: Wed, 31 Jul 2024 13:27:32 +0530
Message-ID: <20240731075733.1025866-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
References: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc6096e-d03e-43ff-fbd2-08dcb1367b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bki5RmQ9AW+7wlP/NgB20iZQi05CHE1/adqSm9y3P5pwkxbNfFXqsfk5AsBA?=
 =?us-ascii?Q?rh6tsnuK2IUeY81//dc6u39a/XpV1uXheQOAGdx62tYWklEpgt2b1EkhAJoY?=
 =?us-ascii?Q?4I2gxMyJ2DrZTtltCPZzrl0rbMwn8EfqZ+FLo8c8TH2Wsi47OnSsebGB33fL?=
 =?us-ascii?Q?YYt3TwZG+4JGiixtvTpphYZuv9GCddLQFIW9TQjk/cQlYn6kjeE9eYHQWkGj?=
 =?us-ascii?Q?qwIqRpNyVKeRHXRDUG1t8mzG6frdx+L+K+JHJPEdA+exAaaOH9VSmmtSF/ut?=
 =?us-ascii?Q?1TBe8PkRZ+cf6LW8HdWU+geeY7g4mE767qX2CrZULpZOj238rGeP4M7XluKa?=
 =?us-ascii?Q?5ULW+YrMA9r/1VyCMoNuQ8uc/UOJUEGIDVXKNmO6NYOF/b9xvp2V+6sqaF8Z?=
 =?us-ascii?Q?V3D3WjiTYNeFIGSZDF6IARiNx4SlBqNx90rer8YL6ln82XzYirSiw7LE8jru?=
 =?us-ascii?Q?NHquNVUAycNJbif8qht6MWQy2TwAXpvqAja54FoPa3yeUk7fHE5/0pduo4zu?=
 =?us-ascii?Q?/FrDRLzAqCl2jxqtAykO8Gk3WyLk6VepRXGOHrtHmtCOo2qMuEw+PBQlMTi6?=
 =?us-ascii?Q?Uk3NKX2enYdzsWZaljhjhBR6VsXAdveOqq652jgcLFFItziuaog3kYzCKL3S?=
 =?us-ascii?Q?i+H/qwhAE3S3HLiZYzNk1A3bCtfI5L9I2DbW9cvofRKLDX50b07jSBvEWH0f?=
 =?us-ascii?Q?MqXCB13E1vI7czLTb0cq216D+v+ynyWhOGcbOiS38uH9iScW+xnCq5FcdHiL?=
 =?us-ascii?Q?05v2sRPzfskJHUV4ZAVD/W/DlywbeGMZvw7ajREAc7NarEHt7OmwSbRIMfMa?=
 =?us-ascii?Q?M5+88uErB21xC0CRMDAXgwtrPbFnW9HeULZ8HZ3AnNKoLwPG/WZYPNGm+dmM?=
 =?us-ascii?Q?78NESpp7YlmwFV9VX9k/453I4ALIYrF4FOiBaxDvvJ5Vh80jogNKVh3AXmsK?=
 =?us-ascii?Q?oUz6Gbd/0Gz0olM0lZvs14kknhW/AhD6QN2noevZECi9+lvSf6GKtTtHAVHi?=
 =?us-ascii?Q?i53+h/BWIcuOC7YGxDoM8fbCjkgjIeHjCEG6cRul/olvVrkQjWXUoPu5NHAK?=
 =?us-ascii?Q?ElVhrWnwdOmq+UXGz/RegBndNs/AfWGPaEAkb6SQYRkWrxQuoJMMB7h2GMc5?=
 =?us-ascii?Q?/6g3YAwKPMfzKAalVR2GzbhJ+L0W/qQlWMHr5XvqGp4Fk7t6xMIAri9t/wHy?=
 =?us-ascii?Q?VWlZL2723tACskwyA+vw5IkOb6vrxamfCefk/c1h6QEya7Go9xnHtUL6TbKR?=
 =?us-ascii?Q?xrvfrnnjxW/aBViOkFnh/1C2HG5O9F7/IX3rOumh/Ll0Nj+xPNwO6f9f00WV?=
 =?us-ascii?Q?ydABKnt8qJStA4SxACsRU0dZ398bntTejfvEN3hX0sYG6hEsynF5YMHpWvi/?=
 =?us-ascii?Q?MptIT3E4eEv88WqB2kgdKkFmscG7is3l8XjBvOsU2e0Uj7fOHhevc7Zszjia?=
 =?us-ascii?Q?+BedSKhVMMG61JA518fc1HeeglLfFh96?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 07:57:53.2855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc6096e-d03e-43ff-fbd2-08dcb1367b42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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

This commit adds a null check for the set_output_gamma function pointer
in the dcn32_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null, but then it was being
dereferenced without any null check. This could lead to a null pointer
dereference if set_output_gamma is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index fcaabad204a2..c3bbbfd1be94 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -582,7 +582,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+
 	return ret;
 }
 
-- 
2.34.1

