Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23179C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E16310E788;
	Fri, 18 Nov 2022 17:00:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF21210E788
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnFmrD2XmUb54GC7KLFQywnsE4kfJ80JSargwDceKavjkoVcQ2yGYCXreqZt/tPLqtKEAGGv0Z9+bMa3AonyCIa9JzFTdNFTqh7kIA+2rksOfa1e8eAK+XWnfULNyXtegvAAF2E+86LadyBs5N241b+gHsfyQShf6FFDuPnD+yZVHTuZDIK5A3rLwQaDOwE6dCcw8Bev0Pj2KeWihPq6gakMXILquGGfkfwnFC5CMsHRkV4yK1dl/3hHU/yq5dRo8tr4X8nup9aLLVtwlq81Jxx5f/arQSVY0X9ivyUg43oKrL/CJ3o9TtPOR+SpvjsRTop8TwA+0jtGkJaUKEwtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sowyUm7T5Siy44ncYUzFbs7z8JPj42kXjatk8zSZTXQ=;
 b=I5B6JvDiJXGukM9bUWAzXqJJF1PmTlPGFqS2UGmnyA5vdaGOqLmKhXtqB8kJbMfuOqHQfrTWxmqXwErYxMJ2wbC8oOJT7+Lvkr8T89NgHfQUSHaEg/sptYzhx5gIRi9+OTnHGBYJeWXpg8Z3kaFcKSQa5M/PDspf5s7moM4IErBelYkgiWa4h469O5w3606MTv36ub197M5UIfZvgpzX+F9twjQsxsM3QxQUcbFPv6/OrA2dkI0i2nZNhqjEtcuyQi4OPK/6kJU+J9mHP8XcA4TTOynzNjbJoRDz3QU0rB0J9FynjW0fG4ITQ5tW7pbnSWUdefkJ7ysqKlKeblts7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sowyUm7T5Siy44ncYUzFbs7z8JPj42kXjatk8zSZTXQ=;
 b=LU8Lg1ZH7N42RfQiIJ3/8Hsg6pXzb1kThO/FHIpd/DzB0Kqf2GStkJRXmIdshvY6RmL9e1ki0IX/dNz9HDX9rSc+DO6Ej3Le3N8daZqNTC7GKiRdU2SRzHXo/A1KgyM8CMIQfU/5TxAAUB6IYywlHEhcrFIO3u4zBHxQLcpCfvI=
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Fri, 18 Nov 2022 17:00:34 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::15) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 17:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:00:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:00:32 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:00:29
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: Add YCBCR2020 coefficients to CSC
 matrix
Date: Fri, 18 Nov 2022 20:59:25 +0800
Message-ID: <20221118125935.4013669-13-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: bc449ad7-dc49-400e-d5e4-08dac9866856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuC2uKFmfGziTkPMxAJQWktAEt8GIP8GIqkscYKDARUK1pQTuE42IXF4pKIrwfPJKlZDWXSgLdcyWF6ebpMHQ892INNdea6oteExXuSvOihiPAoUmDzHSZFdKL5PflBAetF7NDYOZai9l6T8xYSi9PjriqhKLlkmGug2BAPk5S0IDXqA4AjpPxNN0BdNxb/RhW5zzTQ65P2WF8anueRgIdEStH0/ScMuTGovY0VM5D1RmqAIppUVfGyEDEDI3xUXWnT9oXYmaXdythUHHM1sUzXhJojLkjRHu/ZEPn+hoIp2iNrOeBGO/1hobK+qR8G3rFPJ+2JBVIkEPd7LD8liDrkfLpGjauD1+hTPnJ9QMgLp1exiKyyVRGyCO/mMsc6EFm3kKMlYe6YC0j8xOH7QVsM4Oj/YSK5ew7Ej+vy8viMn4UKNCnFUu03ub89qE+l1X8WlwOMOKDmZDfv0R1lCXHhZwcJZLfUbSqLmx9HizJ44c06UJPcNBex7gavMgWii2MJAh0QsEQZOmxXqDxv1bIiKsMux54VhojYXYMYVAeJtRYrb5b3wWcrC96QNuqLjPJbk6/vgtrWRNtLGOXf+8VrbtCSKhKH37C6jUx5oQyjBEL+8CsorGN78QF+4YnRC14YAcR8WPK554Zf1NOogKLCdWRfi6UfXt3QL7GRRPTl8YRI8eYoyR6YwxHw8+CISlCW+BDSmnP3PlO7Xbsnvg5Rph5bIQ303c1z9adg0g90PtijhnjIPdZgVcRrmp3gr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(82310400005)(2616005)(40460700003)(336012)(186003)(1076003)(47076005)(426003)(356005)(40480700001)(81166007)(478600001)(82740400003)(36860700001)(41300700001)(70206006)(8936002)(4326008)(70586007)(8676002)(2906002)(6666004)(7696005)(54906003)(6916009)(316002)(26005)(5660300002)(36756003)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:00:33.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc449ad7-dc49-400e-d5e4-08dac9866856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Nawwar Ali <nawwar.ali@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

When some of the IGT tests are executed in DCN31, it is possible to see
multiple occurrences of this warning:

 WARNING: CPU: 9 PID: 3482 at
 drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dcn30/dcn30_dpp.c:154
 dpp3_program_post_csc+0x196/0x220 [amdgpu]
 [..]
 PU: 9 PID: 3482 Comm: amd_hdr Tainted: G       W        5.18.0+ #3
 IP: 0010:dpp3_program_post_csc+0x196/0x220 [amdgpu]
 [..]
 all Trace:
 <TASK>
 dpp3_cnv_setup+0x5d9/0x5f0 [amdgpu]
 ? dcn20_blank_pixel_data+0x30a/0x330 [amdgpu]
 dcn20_program_pipe+0x259/0xb40 [amdgpu]
 ? offset_to_id+0x1b0/0x1c0 [amdgpu]
 dcn20_program_front_end_for_ctx+0x36a/0x450 [amdgpu]
 commit_planes_for_stream+0x8eb/0x13e0 [amdgpu]

This commit fix the above issue by adding YCBCR2020 coefficients to the
DPP Color Space Converter (CSC) matrix.

Reviewed-by: Nawwar Ali <nawwar.ali@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index dcb80c4747b0..131fcfa28bca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -83,10 +83,15 @@ static const struct dpp_input_csc_matrix __maybe_unused dpp_input_csc_matrix[] =
 	{COLOR_SPACE_YCBCR709,
 		{0x3265, 0x2000, 0, 0xe6ce, 0xf105, 0x2000, 0xfa01, 0xa7d, 0,
 						0x2000, 0x3b61, 0xe24f} },
-
 	{COLOR_SPACE_YCBCR709_LIMITED,
 		{0x39a6, 0x2568, 0, 0xe0d6, 0xeedd, 0x2568, 0xf925, 0x9a8, 0,
-						0x2568, 0x43ee, 0xdbb2} }
+						0x2568, 0x43ee, 0xdbb2} },
+	{COLOR_SPACE_2020_YCBCR,
+		{0x2F30, 0x2000, 0, 0xE869, 0xEDB7, 0x2000, 0xFABC, 0xBC6, 0,
+						0x2000, 0x3C34, 0xE1E6} },
+	{COLOR_SPACE_2020_RGB_LIMITEDRANGE,
+		{0x35E0, 0x255F, 0, 0xE2B3, 0xEB20, 0x255F, 0xF9FD, 0xB1E, 0,
+						0x255F, 0x44BD, 0xDB43} }
 };
 
 struct dpp_grph_csc_adjustment {
-- 
2.25.1

