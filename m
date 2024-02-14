Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28502C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A776F10E365;
	Wed, 14 Feb 2024 18:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FV7ltaP3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4FD10E76E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkQSwrhS24PPpxg1A0GrzLbPJqLMkPau38NtdjtroKApldKJ3VUuwNoztMAA0LCmyU+dxl2h9C7HaiCSwLEdNsuMVeP2CMEalPsY1eOnW3M4/34w6qoQqvI6qD198V1Ri4Gl+43QpPx9Zgqgj6cic6Rnch2xi7HjksCIYkc+8rfY/LXoFjMXUt/EPg5FJzBysjn6KJTMPkpyHpo6O1jL2qLE5VmIfRLilnHbXeEaF9Gbhas999xooHkyVjWWBkDZjL4U0Qu3+HqFrnKank3A6/L1/P0ldOMQ7caw6JmThqYcmaNAxFLSAxxBCXOljBhnslIPibcdXU0FJ/xcACTHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwKxEmuwuFcYInkUrlK59LxBlT0ybkIEwwKUv41gHAY=;
 b=M2uhuc+MCOjzR9q8PO6sWy8ITzRDEg5jOuj5lc4VTgSEAWXBc5LDcWAhNk/t8tZUwsi8g5Yj9ttxFofBgbe/5LmtLjY0TblIAmBC84SzjpC/U//MfbK2GR/GWrua8SvLilXP+XWY5B80dcHBb0L/sXSFC1VwloFlhRzhaeYldOpe6MFNfDCASzzWwa4H/C/tsUhxxvsWqekcuYvm244drNUD3q0doowqQ1I7skSnRFSWMFa+PzchlOxGjy1Jev8CIHGzyzkDSDeunlcYwCia6+xHU1smxFmAXDluKgBLYQkou4HS9ez7BU0my4uDm/O1u76SWGePjQKsYgGVjUYvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwKxEmuwuFcYInkUrlK59LxBlT0ybkIEwwKUv41gHAY=;
 b=FV7ltaP3xpUHkcgn433VG9wkgfA+Y64J4NKkMuULtwzn0fArdVnRhuBQs7UVrjc9D18Ns/Xy5+RSFdRDYiNbuGcJTrJcwE17jIeUGJ0p4T2hsUA+S56cyzu00PWkppRVZVgNlkZyb/3m4l0DM0uMwzbBfz9j35kMdqvig5mTvtA=
Received: from DM6PR08CA0039.namprd08.prod.outlook.com (2603:10b6:5:1e0::13)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 18:40:54 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::a) by DM6PR08CA0039.outlook.office365.com
 (2603:10b6:5:1e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:52 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 16/17] drm/amd/display: Fix nanosec stat overflow
Date: Wed, 14 Feb 2024 11:38:47 -0700
Message-ID: <20240214184006.1356137-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5f84e8-9eab-422d-8096-08dc2d8c7a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qTxACRT9wF74Gq7VOYidv/trmN/cIZqzKv08kzFRVv5e000iqCW4rrcbrU2VvUVd9W6jTRNxYBa/Ke/OvejNfV7/soq1QQcZv1F4MvMh5UJUIBLuoL39YuomMXuzJmB1sf5mH6SPUf1+kpjwTG7MVGbYw6qpyEPtgHEvX9npH9akqSVU3La44O5HYfDcowke0dWqHHFeO15rZy6TwJGWgNo9oHw89gc3whJJTh6YDG3LC73jR70fs5snbeKGN85vmX1HmmHowwQjBXhDVvtLiXiqc1EN21rlVALh3oTmI+x3OaWai+bqz+/Ya4slICN5uToPyFdDKk4RQiv1lIKBTmecaayjihBPqfRaTSZwMdMrpqZgFKPPIMg1JJ6bseBqtTCKqDgoUH7UiYdmo7PCW2nZptzhpid321E6rWuxrmUDA4LULKyccS6nGy6UW+0nrTejvIp6/r0wb6hNsiQCzOyP1DIhDyy1C1J9k6hUWHHKMvUlgonSaQCyotzvqewFY/B79Wn/6H45sN4gkd/g1nX18x61ccQqlp+J/qK5vfEdqh4U7YJT77aa9vGsTIUB9APZlIYuvwNXwoLJgDzvlHqg+cxuS/tixqZCSS2FUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(6666004)(36756003)(426003)(70586007)(316002)(4326008)(8936002)(41300700001)(478600001)(2616005)(26005)(16526019)(336012)(1076003)(8676002)(70206006)(83380400001)(54906003)(6916009)(5660300002)(86362001)(82740400003)(356005)(81166007)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:54.7131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5f84e8-9eab-422d-8096-08dc2d8c7a28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Nanosec stats can overflow on long running systems potentially causing
statistic logging issues.

[How]
Use 64bit types for nanosec stats to ensure no overflow.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
index 5960dd760e91..8ce6c22e5d04 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -57,10 +57,10 @@ void mod_stats_update_event(struct mod_stats *mod_stats,
 		unsigned int length);
 
 void mod_stats_update_flip(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_vupdate(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_freesync(struct mod_stats *mod_stats,
 		unsigned int v_total_min,
-- 
2.43.0

