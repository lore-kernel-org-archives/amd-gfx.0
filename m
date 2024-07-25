Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698BCC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B85E10E8BA;
	Thu, 25 Jul 2024 18:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8FD6pir";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEA210E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz+EET6YIoqAh1CTmN7WdlTODDRZzDatn0ek8mIHcjCk6SajHFhFt2txBbS3L/4TCtpS00Wmicqz/Rn6+RvZiusQXFUMMIAGfaRr7j4aeuDNlM1R5NWJL3OPFgA6/wT3Q3KlZOwnIbr/AhhN3wntUQODudScGt+Sq3kmS9xK6gy5s8TTlXaQsPWQ1xNuE/LC1EmERetvctHaQKrRkMEhMzWTp/WODAyBsMx/vjZtgJ8bVRVrBrFy2jb50gSUWx0eTBk3+pn94rkdQOTcL/6G4/AdzqyT9WQfZ4xvQo7gSuNmuy0LG8L9WY1mFfx97ckLwZUmxjGn1WKFQMddHJVXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZaQTqw8/Elsw2gCzzKOrnFRG82GPVSUwJKM1homxYM=;
 b=UJ8oE7cjqHbsT8DjGQC2fZ59+WZ2VUaI5JCcJVyUrDGcFe1YLkmIHOv8Niv9b7UXxNjmjHuLGz0UuhUkDq3c2gVKBgHUXTmp55nqyK+J80OC+R2nRRAKJl06NyhbDtBB2gpr/7RtEgk4YlTyJIjutuBU6U2xl1KsqF2B0/4DzJNi/myblcYXv/4yhGZBXZgrl42IT2VVx+SwZT2h/mwRZt7tSEpjZ9GoV441UUC7M+/zO+Ru/+39hiT/MWZDh2NsMCGfzUtgTCduU3fd/3Ff4ZMWQPoPw2cXoH7P9lM0XxqDi5KwVTBDIcT5qkIbYf/d6/RXO8DNAjTGk6oee1xOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZaQTqw8/Elsw2gCzzKOrnFRG82GPVSUwJKM1homxYM=;
 b=G8FD6pircnKl2arouxMnO5MfORDOWhz+eBstC2FOHtvReCAvuZIdWDPeLi+2ws+K8dbSGjgOZzGQcvD8w7gjbLX7k/lMbtRkP4R+Jx26TrIKnL0HAz0fpVM7AeDHSxUk1HZtuGpkfdP5iI77mvliUlxH+RTqVWgVokYPuNMMwmY=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:04:40 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::18) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:30 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 33/39] drm/amd/display: Add missing DET segments programming
Date: Thu, 25 Jul 2024 12:01:17 -0600
Message-ID: <20240725180309.105968-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 612e0a6e-bc2e-492d-67a7-08dcacd440b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oDGS2vDyxPKF4SnpeTKigCyWm1O9Aa4PCxFfzsD2agzb4NBQM7IkOCM0hrj+?=
 =?us-ascii?Q?gGj8JU5ZZkwlGrrFXiMfBG/1VksET9C+2IdcTMSD9GWDE7O7jRQhfkcj6zTm?=
 =?us-ascii?Q?2+heGx1mMLtrngvC4RjT8+GBZvxIb+wHBFV+OnMi3fCfUbC/FVhd6Inio0bd?=
 =?us-ascii?Q?lwuHetcWpa/ok9hV+gx2YhV6m48Bm6jAG2u8FP/ZlX+j6wgaGVnHZz34v/SD?=
 =?us-ascii?Q?mCvm/GGae4kcb4a/KeBBrADgXmAJlWOQ+894soji59SGd0ttnpv7PocJ4oZ+?=
 =?us-ascii?Q?hJ/FbGtPzO620/37XHzrpR4TaHyIfNP9sQezXuC85GO62Us7rbGQXdRaICWu?=
 =?us-ascii?Q?gUckWygbwyeLEuuZ745/GYXZiWEQEvOfRqN1taTfmbso2r4okrtyo9K52+Yg?=
 =?us-ascii?Q?xIGs2pgljN05XIldMkbgUeZAmZgB3Zno/I84jsZSi8pS3Wnh7E+61lIYvfMe?=
 =?us-ascii?Q?qOhatxvpWOWVnCtNMGBuiw52ejAZoWLU+3mP59QUbZqTBdYjbBWYTfpUMi1d?=
 =?us-ascii?Q?bPj/i/nO1ellMtW/ApJFQRCeczK3Bvji3T9A9T7Qb7bRVT34GHOx59e/xFWA?=
 =?us-ascii?Q?Ioz0LgihvH2DNj5wdLH8WpMi2Jp8IgqR1MI2H8hLKzEydSPCu2AsOhWjkflA?=
 =?us-ascii?Q?LbZ3DCKYhFvY7bi0+3tInw+7S+3KS8WTjDC1fwj0UNnv2w3QVksNzyT2B4DI?=
 =?us-ascii?Q?YfscD7q1+g0//DWlnxFMlzDwoGy9bVyl5pDdS/0255DRjLBE4THlxiiyxH+T?=
 =?us-ascii?Q?VdIYTkELjrBtjSsAhU5ZLbo6JmG7pxlI0f/1TlQ4CONosqWg+O7UiHlkEekH?=
 =?us-ascii?Q?FBs3z2/sZN59DeVP0oGaLPNtCjTBr/1X69drCx9AuK2dWPp0vQ2z469OaMii?=
 =?us-ascii?Q?mOT2oUfAU9ckzJZXkMuACOktbubZm/BK2a1hUcybrmrtuQY5nSnDG01T3/k8?=
 =?us-ascii?Q?nM4C9QrTRdRLA2vJWUWGfFpIKisl0dsOgbqgEXwLoqV8GqfTE39GWUydIsUV?=
 =?us-ascii?Q?Y9jjxM65GH9JhwvlXnwOcWsh/Vpa05HQvEKh5djRBGqLpJKcUlak6crRXX8d?=
 =?us-ascii?Q?/P0rRswphKnTap78pYX01vzcTIi6zi9qio48Ee7sZDcQGTi5J/4VkTCJ/yW5?=
 =?us-ascii?Q?2R5TzwITl3H2NKDf+kMXEJ7NBmoIHILzTkWPy6AX6Ul7+1fJlFaY/J3lLShV?=
 =?us-ascii?Q?UiUo3P1R9wDzoaBrxOA9QWvAou7ZnMsQTwAGHyv6IptUwCB4PwcmQhQK0Kuq?=
 =?us-ascii?Q?Pvyg3Y24IOyJDwuemXEKP+Vt/VGQMQjrYzZIBx/WF6cqTf/wdC3tehlrV2xC?=
 =?us-ascii?Q?4SXtyFBSMPQNNc9G/fFhxKnYpO0j9sPA38lo3fJWVPu1JeuxCQb51cLb4NXa?=
 =?us-ascii?Q?ZrzTdO4nFinUV32oVPVHAERu/P6YRdeb4KmVSHcY84tC5GLWFZQAwVuvXy57?=
 =?us-ascii?Q?Gy++XdJgMReObHg4DEZ4kBRqWqNAm9mS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:39.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612e0a6e-bc2e-492d-67a7-08dcacd440b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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

The commit 54bd97eedd39 ("drm/amd/display: Modify DHCUB waterwark
structures and functions") introduced a code refactor for DCHUB, but
during the merge process into amd-staging-drm-next, the program det
segments were removed. This commit adds the DET segment programming for
DCN35.

Fixes: 54bd97eedd39 ("drm/amd/display: Modify DHCUB waterwark structures and functions")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index a9dc7cf12dac..899e239352aa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -771,6 +771,8 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 		if (hubbub && hubp) {
 			if (hubbub->funcs->program_det_size)
 				hubbub->funcs->program_det_size(hubbub, hubp->inst, 0);
+			if (hubbub->funcs->program_det_segments)
+				hubbub->funcs->program_det_segments(hubbub, hubp->inst, 0);
 		}
 	}
 
-- 
2.43.0

