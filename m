Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1339C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD0910E5DE;
	Wed, 20 Dec 2023 16:37:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1408710E5D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPv/LpZAVLe3pplxgFnfV6ZqVuUDTrmxPVnYej1o2Uig7qz3vvumlnJsfvNiPZUikHUh2GXtKsrG43hX+i2f7AsOvy5XGXKPQzJFGu1YqXDQmJT5Ue1b6FsyAGIN2T7BOeoN9MISOadfG2zjodyyiOfJnxYvnKh+DsGEu4BnoVYOvxH5jWOh4tjsJ71u6hGSa/SisM5gGgkATz4ixTGEdEh7W4rPbkXBTOeLY2ll3fUEGEfe7t7rgtppxBzAzwP1lGxuaQC13kqyn3ZcwZ16NZtr0Uhxf/w4mtPpt3GMDTD2nQhQkflX2pSdKRBaS40FJ3aZ/Raidu7CSaa5iZ1GxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1YSzYHZiUQR+FfDWHWJvxMCdSeD2yOPt95MMLUAK+8=;
 b=jzTFAz8XszJCGu4y7Xexv43/26TXw2Zbc6gvAa1KIEwp+HCoHd+HqHgaNYy5maDsALGj587+UMvf32iedaiy1DRtmj7+IUhvbOPxzNePif/bymdBrykeT6m4nJrdN85cZl3+BQpQ+goGcSXg4/jO2/TD2G6HJu0u1b7qn6x9Cu2zburvMA+F2/x8RyPyB/FMsElEpTibRrWZN8IQTJyhWX9rGdunqAToRYXHYAKJ4hhPSYPnR7YWLHwJ2PvAX1YuaDdDTtPiWLwC+Xv5JA+8lstMdnLPzguQzCo8iRMXRAvvKO+XBZnEbHpOydYJYG7oNlfshdqVFjBLrqZ5+ayM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1YSzYHZiUQR+FfDWHWJvxMCdSeD2yOPt95MMLUAK+8=;
 b=dzR/Nwxy4ARxFTsTcOknx5nydO6lCCmlxDcSTXFDHY8Az4ZQzec4M+oWjAUp+UBN+LLMcCJv/8AByi0w2ArFH7cTG6lzU2VTHJuKFJDZUQyHI71gGltbmBH2bkQjITeS1XikGc6O0AU4RrKDRoQyU9MDaDYCxXQDmiexbQyYv64=
Received: from MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) by
 DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Wed, 20 Dec 2023 16:36:58 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::a7) by MN2PR01CA0061.outlook.office365.com
 (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Wed, 20 Dec 2023 16:36:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:55 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/20] drm/amd/display: Assign stream status for FPO + Vactive
 cases
Date: Wed, 20 Dec 2023 09:33:41 -0700
Message-ID: <20231220163538.1742834-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 78139e2c-cf2f-4b3e-6505-08dc0179e25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAAGnDOfUTgydXcJwLTiAn3UJ3TTYs9NULyo+Ek7arpG+TmiWDnm4L+//s9bVTEJxWdT0f2coWFVrZ8GFX4wg43UJuJ6OAgjjcK1s+XMcAJKn6pOegE5SH3dxm744MCpzgPbr1cQqYHErcXjgCv9+O5rVO5ZUrMWfkV/45iuKPjwWO3IkgBIz8JHq4x6baQm+wV9vomwijCyZ1BNvIMVk498UU+Xjl+x4A99AxaV88fEEfwany24LcS02RIZ+9GIJYWJfxn2xfZ1YHH7LtZJ8sXKUL2XU+DM2igck6UtMQ0K6nipDXbU3MkegZgz25rEHLLU24UZF//flvZFvzgMjX2cKdo4GZWcgnPDtKCXQfuQlgrmu1V7dcZjxL8Kusyd7vZV8KvKq0JGNC5nbRz7lmuTBHxncf/L1w3gTlYdvuvhX56xsdGZVPL0eSWbgNZX0//ld7sVr/zYOYXg0Adjbzy+JuDHmTUAaONeWnUvzzVkFPHOGk6XSH2JXqQOXcvuxCkgYjjvRr48dORm1pm3WfPte/7pe6uk4kNcpGNAH9seUsA2znMY829MuHCn8Gks87hy8tqMOSuolMFOZdyCbejw5hRJFERJ+i+6QcfdvZImg+1dVuINjZOakxA8uAnC9yZfhjSy/ekr+kUknEaObyXpJ8bUmrOpkH9nZOVhXfVSAOMdeoSWB3G8dZxHM/NLrJn/lCvN9In0ANLaHkWcMGQLsmYrcLBsK7l5zFY/azCzxZaYEGjRvXyB6DwWWmQFBNkrXaJKgZ0f3Hdpeg8k3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(426003)(26005)(336012)(2616005)(1076003)(16526019)(36860700001)(47076005)(5660300002)(41300700001)(83380400001)(4326008)(8676002)(8936002)(316002)(478600001)(6916009)(70206006)(70586007)(2906002)(54906003)(86362001)(82740400003)(36756003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:57.9675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78139e2c-cf2f-4b3e-6505-08dc0179e25c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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
Cc: stylon.wang@amd.com, Relja Vojvodic <relja.vojvodic@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

A new check was added to ensure FPO is not enabled when the FPO pipe has
0 planes. This requires the stream status to check the plane count, but
the stream status was not assigned for FPO + Vactive cases which leads
to FPO not be enabled always.

Reviewed-by: Relja Vojvodic <relja.vojvodic@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index cca6436ecdf5..f698a7e63291 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -554,7 +554,8 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 		DC_FP_START();
 		dcn32_assign_fpo_vactive_candidate(dc, context, &fpo_candidate_stream);
 		DC_FP_END();
-
+		if (fpo_candidate_stream)
+			fpo_stream_status = dc_state_get_stream_status(context, fpo_candidate_stream);
 		DC_FP_START();
 		is_fpo_vactive = dcn32_find_vactive_pipe(dc, context, dc->debug.fpo_vactive_min_active_margin_us);
 		DC_FP_END();
-- 
2.42.0

