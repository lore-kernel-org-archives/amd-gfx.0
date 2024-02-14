Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FBAC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B35910E252;
	Wed, 14 Feb 2024 18:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U168jboe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C77E10E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eslzStMX0UaUV//yQYuEk3EhQZ+1OaES3PB0bgeTETYC+IcuwMC0pqhJ5keJ9K2aoHVdnePdukxXDmcudWFuSXK3+RuiMLA0mmvRrzSc7GXbTeXRs2W26QzcjZE5Lgo4OIC3QbJJ/hbXTv1atI1+p2C3OGmryvdAgCK5DUCWFfXWVqcMQZ+S0MQipKG3LhIR3dhWn8UwJLh1TJQAmfAkgC02YzcNiroZJsWYfF8lqfEJ3buRmMU8pgaXI3q64rndrIbLQYAVYXEdocBoxR+iK3wvUOaWKEfXPCi4APgv6acVIsAobwnQxKba0dbbHdWfsQTHWGe6MUmCR2LXy9YVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoB9su3tkVoqbSoz4l36kaTqNzMuF2EvFkhNYH4NE9Y=;
 b=mOndoCRwjlHECvgIidkqoh5zzoVqRZYxGaAQGMYodazdgflGxX8cUHcyE4z8IZhG1RepuhUjqPWwZC5EAElp1RKeUHnoLAETVqMxm4HrKesVI+w35nBg3VraQ2dfvBnLRCCT43AX4DsyhRHaV2C3Urd/74JubuRw4Xc2E0DNdNajAM1GIoPfDjdylPgfZN7OvDfsRSUGcD5P7kZLaJ2XeVPzzIJUSvCIim/EMVmaEhvfwjCcuxhg5aWx83LEfoGFNnDFVvL67mYX9yBuX384BLGJ7nE7Y09M1TjS+WapOvWKxikxhQGAKABuzFnd/qTPGhisTvwlPBIvE7Zg46H7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoB9su3tkVoqbSoz4l36kaTqNzMuF2EvFkhNYH4NE9Y=;
 b=U168jboeIFPvF8s5Jz1Vb+hvWdWKbm502hHDgyoy41qqJyb/9NAgxUZqGXIq7nP3dya+dYp8roDhWWGiApdQFrZCpuypZZxEv8oh2uXT+psjtPQuLMZf30Gb8XwDdhUGdOOk2lH0iTFDigEHba4eG1Y8m2/XsBWZyDqU0tSV3Pc=
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 18:40:32 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::e0) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:30 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 01/17] drm/amd/display: Remove break after return
Date: Wed, 14 Feb 2024 11:38:32 -0700
Message-ID: <20240214184006.1356137-2-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 094c39a2-3b46-4095-7c83-08dc2d8c6cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE4TsZeXo8AVaEJdg6l6zVpgTdljpbXtUnLZG/fOaXAMwSNUORRWzluDo3NWSih8oCj2Ik6OsJ6kM/F8xXQ0kb3+yxf+vy/cV2EX450LAIQKdAfnTTFfkyzupuQStEiKPBM3qdHd90lMddA6I9fztw2rgtjdLVfqQX4pVxiWnojH04/t8p1A0lCBjnQTEeEuDW0YZDVDkdOFHyEf75iP+58isfAXpOX8muvA3lV3vudnnTn2/RpRkGT67opdBruLni55+Dtp03wSCc1pDFR8iTWjESiwxbA6Nza6dGZwG331RELEMqsJfzVlZqRHCYrwS3Bvma9PeTcUu3VLG11GPnLD01eydnWQTlV3DLCwKOs+S7f6T45K4xSCgqJjDoSxtA90o5krAhtXd0QC6dREkHn1/TW4DHS029fF4vIp2wxBIVJW4o1ca+jHt6LCeOFeUvvo1m6dSxD+uVykavbmk+xL36GrdqiW2ecgwEZiXCkfbklKgkZYIirqsF5BothqdY/MzQznxBZS7jqR2zo8jOERRhUMhF4LNlnOKepqqOMpisuyAzquzBy7CJr9rKry78COIcuICun8eRTS/g6uQBbX0m56Twv+WxUNSWxsIbo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(8936002)(70206006)(5660300002)(4744005)(8676002)(4326008)(6916009)(1076003)(478600001)(2906002)(41300700001)(426003)(336012)(26005)(16526019)(81166007)(82740400003)(2616005)(356005)(83380400001)(36756003)(70586007)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:32.0745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094c39a2-3b46-4095-7c83-08dc2d8c6cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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

Remove break after return since it will never be reached.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 28a2a837d2f0..86ee4fe4f5e3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -340,7 +340,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 
 	    dcn32_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 	    return &clk_mgr->base;
-	    break;
 	}
 
 	case AMDGPU_FAMILY_GC_11_0_1: {
-- 
2.43.0

