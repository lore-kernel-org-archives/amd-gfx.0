Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38161C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0395E61041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0395E61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321DF6EDC7;
	Fri, 15 Oct 2021 18:44:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3CA6EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QckJSfIP/JaAvGrhJ88inVI/Air9K/FD00jKNhkbZ3hanXVUgV9t/9A4FM1JzuWVu295Gw2JeaJQUudU/+G216iVDbX5hCMRWsCRQXSFcB4OB4izEETw3gzbcB4cwDUm/DajrGpO+gfDSgr62WJIIhsTKhR/y5tIk4P+JJCEAm+TmJx52qOV9LMyjf/2n9zGk/FnVIPTsDDos4jP0pvUpYPhBO5RXfA/e5gZBTg82jyIm60QTGtzoBlQ1uOOuR+t6PATymox9y10Tvw3PKMsPJ9u7a66z1tIwuDMJ+Ay8B/zi7qI3VXsMXk9w/7STur6hEAwnC9QAwEbbMMmvo+xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev3bWBC6cCdJQxQ23tYbaUzmTyojoRP4lEJ4JiE0ot0=;
 b=nYRKqXSCGJQD4dBtWFaSnmXHCmzMJo5eS8fENHCG1eD7qjhTGh4yJXXW7M6IjcHY7jb5RT+yZeJoSyFTqKDAh4dRIrsmaml6V0GfXEzkDZrqevfuICc03XY6NZg363HZvi8N/ucjOuTOT7dKN82+HiR1pEPEZZ7WwXT8qJm+K2dVo11+yW7nb9zyEAry9Ceysg9pGINy2ixbLWc0+y/wT+itmx6/V06mo5EbmI0zm/8Ah1fUyHi6Lzt8kf5wEnioHtTQaqTMKdokOC4R23rgul2b6EVzT7t78pJYGlMfUPTdu3S9CzVfkIslBZ2DVDSwzWf5Pjn2G4cB65Fe7QfTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev3bWBC6cCdJQxQ23tYbaUzmTyojoRP4lEJ4JiE0ot0=;
 b=4C+T5HsiU7Q/yWJladxwtROaQXPDnyylD5kJVmLVZS65yCEZEKy4PZcvqmapk1uJbS1XfkZInvvX4EDEuW6eAErMUr6cw+45glh9Z6dPc69H8DvaiFarkY+zvgBOe8cME8KrBiLLcC2zP8dvpWDC0CKZzh5s9yCcpXxPYd0c7DQ=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 18:43:58 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::da) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:57 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:56 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Nikola Cornij <nikola.cornij@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>
Subject: [PATCH 10/27] drm/amd/display: Limit display scaling to up to true 4k
 for DCN 3.1
Date: Fri, 15 Oct 2021 14:43:15 -0400
Message-ID: <20211015184332.221091-11-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129fdaa2-a4a8-41f5-79f8-08d9900bbf71
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1239DCDF3A09E5E6ECEBB4B8F5B99@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9U6qlq1YpGg6v/0k7xN99w87eU8O7q3cOfirsKGtf/0xNiTi6f5K91YBM4/OVBRl2ZRh0eOyXYWTdM5VeBoo3MVXNf3OlqxP4cZla98H9a8w//i/uI4wxkLP+qR2sC63hXKkUo8DNTGyFqgY1Ef4E13LgLwaY+AiikLl19VB0DajeIXuIQFrvN+C72JOYdXiqCY/kzileit9zhtYq35e8yz5CJ3stw20iXyqekFpnIxRoAwAXxCJwy2sqDRlB65+FLodbyqgepu5UfWFcBVmHAVzyCqgLHFlAA4xmpJnxQI3q6oUfQazqqTDQumYgXFuKYmhKCwBv/gUUQ2l3j+Crl9crsEwrnzDfBFIBQGvA9ej3K2e07A6vYSZxe8WhGI1liq+IZwg2eekj5p4DDhGNeE2gbkFx/Prki/74XVmv3chqdh+BRxgMbXsmAvnoGfGRdqmBvIkjXeGirYWQkj58LjQnbChyhtFTWDJ4OQTOURm9zHFFUkDgttB2MlqVsryVG9ygk90+N+GukixUB5qcjUydSeZTyZvVKcbFjLy6G7kb8doGyowimckHBIioZdoQRZ23MiIZ+THjFYlUPCTvQaGEgxcxeDTmM8+GrT/rfbMHIw4aUwfnhx1X3yqMAjY/pQ8Y07bo+9vR8j+O4sBR6saEPW3JAPo5/LCm5KOzHcOqXFafsC1p6NeWf6+locUbQhFoFXzKl6l2Ip62Mthj7ag+JCyDSaVPrnsHtc7rv8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(54906003)(508600001)(1076003)(2616005)(70206006)(4326008)(6666004)(44832011)(86362001)(8936002)(426003)(36860700001)(81166007)(36756003)(316002)(6916009)(8676002)(336012)(16526019)(83380400001)(47076005)(5660300002)(186003)(26005)(70586007)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:57.9771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129fdaa2-a4a8-41f5-79f8-08d9900bbf71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
The requirement is that image width up to 4096 shall be supported

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 20b4202bda13..a2e40405c97d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -998,7 +998,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
 	.performance_trace = false,
-	.max_downscale_src_width = 3840,/*upto 4K*/
+	.max_downscale_src_width = 4096,/*upto true 4K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
 	.sanity_checks = false,
-- 
2.25.1

