Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E12AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 21:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943D210E7ED;
	Tue, 22 Feb 2022 21:53:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E4110E7FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 21:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENys19tmmzZ9NROU6Ojp7sia3BAnd17fbQGLe3QsXJHnDg9nzDKqmBoJXh9EpVjoT/+pL9czxnhVmGDKYeVJsLXMKHagJNsiQa31XEbl9IuxLDCRmPBi/1pHctPjF36U4lfApB8JcxOeysxfAbMEmcQxk/Lfb0UBN5+/hFbCEPKnyR3FMelEMai8C68JQgAqVI7GlR+hoWiQyBfQO1NAvzkZcM4yOIkgChkr3wlC0x1oxLzPPQo3Kr7rr0rBCQ94uiGEOhYD99Ra73GJc3Nt/n/NesFlAW+V4pFPdPZu3aYMeNfXJFE2MotBXGoFdZ6ZL9TzIJWLq0hSYYjASjqmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLPbeL4ecMVqspxK520KopcNjUQ6laVz7WBwEr6x+eI=;
 b=O48qgpwWUyZifxM0RuK/5a4dEeKvU3evJqEy7rXyUG8VIQsLmGq9Vtlx1lxGUR4Ey+UnAkP/B2f7CDgp2T6ht/vLz4zSXYfMGjqsu6AaRJXSYOAWxftd2qHNLMESt5Y+SeFuE/ek9tvqxd3xi5vL2S/VGYCQQGnDGRhHH58xltMR9FSuEdR8LUvz5/jVvE/O4+b3i+XjBTnpGR6rPwZwD5Sc7x5PL30bdgNlUkTdMx3TYV28NAy/u29nEw8wJEBPYR8Rm7c/YAd6AVRAFotzWZONsmggFq4UdS1GrG2KExlsa6zr549OiJqWznWUYIWDJJWKHjB0/bUfpNNBqHSM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLPbeL4ecMVqspxK520KopcNjUQ6laVz7WBwEr6x+eI=;
 b=pdsBwSeIhb4wkJsKbeFe6WXrIp17lMdX6OQCoTSbAtouMe8rjc6Vlwizogy1Nlssws1GPqF6o7iTpkMW6jyKnuIl10eKzKeGFMriCDPTBIjq5eDRzI6SDAwQvcixtqMknxMGtumTIUUz94qrcDaMCGchuDlMH2XJgCVJaahzWK4=
Received: from MW4PR03CA0093.namprd03.prod.outlook.com (2603:10b6:303:b7::8)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 22 Feb
 2022 21:53:47 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::ba) by MW4PR03CA0093.outlook.office365.com
 (2603:10b6:303:b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 21:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 21:53:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 15:53:44 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/display: limit unbounded requesting to 5k
Date: Tue, 22 Feb 2022 16:53:32 -0500
Message-ID: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c93b4aca-1352-4eb0-49fa-08d9f64dcd76
X-MS-TrafficTypeDiagnostic: CH2PR12MB4264:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB426433FBA69BC8E02CDF0B2FFB3B9@CH2PR12MB4264.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdtTsqo4e1BqpRCpAxoKy8UqtMsedbrGCu833lpxHiVa0v65+d3uNFKO5wD6YzNusXvc6HhKmIrmUes57cQcZotr27wnRXPx2h3U1DUwAL4qfdvDpw/lnJrY1FVV10ViaEbU8zCEMPzE2mSb8cCAJQYDAyDUNplbFzMeT/gRdcUBRjhMmkjgX6vF0bds2eeqTsufyLCqTuz3kGtJNUrhYW0dk/xqmIiCV80TNM2Cs5bFJFfX/fDfr4ouJR6ocX5CjnsuApluoqAz742QJbnIBqmc2/7lDeeYv1RVCbjcWOHIFF6ErfTIcUtHxb5S0ZRR+ApWd15n6vf0sk3mj82IhdP+OjIPlJP5dOoIJMYtPJYt4dpqUlSpE9THybaJiRYYda72yxRxbsCpP0Hzkr1FNvMfYsMKSA5Wjq4RNQuKzMPDXzrbbdEockY9jh6PuQGB7rO8r18ynEt4btpsvLqJ4DDxnottXZ4e7WV+QM1K9rR76vslPVGh9l0+K4+vqwJU2e0e/KicIsVvwdA+8ooapKg15aadPj4Ada2QaoUUddl2NRycbW4ISwdhCEnO9JllfJMRUpr3+7pDkg/ggeWhdmlTTztksVbFfl4FYuOTRELEw/XOXqeEL9IoFU54Jv6DE2GrJO98864AuQePeQDgNzMgTnSkzAYNWHaHoTUpk5LOGo3dtJB+OGPByh98EU1MThRix8fPw4yJnhii8Q67bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(36756003)(4326008)(16526019)(70586007)(5660300002)(1076003)(26005)(6666004)(83380400001)(70206006)(2616005)(316002)(47076005)(6916009)(508600001)(44832011)(8676002)(426003)(8936002)(336012)(36860700001)(2906002)(81166007)(356005)(54906003)(82310400004)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:53:46.7757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93b4aca-1352-4eb0-49fa-08d9f64dcd76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com, Harry
 Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[WHy & How]
Unbounded requesting is unsupported on pipe split modes
and this change prevents us running into such a situation
with wide modes.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 406492655dee..f22158bb4b13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1841,7 +1841,8 @@ static int dcn315_populate_dml_pipes_from_context(
 			dc->config.enable_4to1MPC = true;
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 					(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / 4) * DCN3_15_CRB_SEGMENT_SIZE_KB;
-		} else if (!is_dual_plane(pipe->plane_state->format)) {
+		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
 		}
-- 
2.25.1

