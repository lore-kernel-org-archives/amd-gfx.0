Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE61C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A94310E47B;
	Wed, 31 May 2023 04:49:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C051D10E477
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXp4r75U8ZqNAcRFQTEKnMkiRMprX4+HkAXxhs0pYKttyw94U7QrbszlN4uPtC+h/EbPlmIJOIrLZtdPI29ZdaCzEZ//4nefyOnYOIb0NnfU0WCt2GSH+mYFcu22qp1pNwXQadT4hIlX9OXASvinMVPIOlEzjNGmiQSF1BCt4GJtVw5v6HleTre/bUdg/T0DNsxvaAWcCQELvl34hKcRdjOX1524cfmdLSv+cnFM8bDmHbINg4MglupQJB+QLkOF/UNck0rIsmf9fSIygQacwPjidoTRUu6Tl7d3kG1iR2ejVkc3muqq+6sUgC+YtojWWMGPi/HfdfYxGdComreC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkTrPOBJ4v6GNWlhhjnincIWkI+UjRPzxaCoToMXrB4=;
 b=GwLBLLbAi5MKkqdv9+8pMRnNxYrJVu3FY14CACqXD9VAdDyTv2UyBH5v7RO1SmyzFd7KIQ79Q+g/4rQCx4tJg9oTWab0BPNyb7NylBL9buL2ek1AvIUPejAJBaxtRIrm3fwkvjqvGTGkQY8eVf3NgH1Y7hrFIpaSuVRXw6w2n6sEvdSAaF0W8JHELi5FAw/bkmHwvkV0vs77MdkPAMY9sj7WJo9TDUeiXrNxMepzZlDknkQjyihyTO3C77jKpbr8UXnYZlaLvXFC303E8a8iuwCyyavMg5fLaI17xv+hBsdf0TBKGl5TvHkItacR/d8FYe4/+6zoDdhevoppTBSQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkTrPOBJ4v6GNWlhhjnincIWkI+UjRPzxaCoToMXrB4=;
 b=DyaZSMvUoPV9JwlM+3+IFa0IYPoicJuHfjx2KDArKkZS6OCuRSLSgXEIthn8SJdJ98CiqH3+3ZaC2FMhHRlUC5cR5801a7xBDeIznmVtx3Vs2v0DAOwBBp7AkLStWePlzAjNHlIikrrN6W59+j7Xm7zuXAqXugtrAkE5VgLI64U=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:52 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::cb) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:51 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:47 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: Enable dcn314 DPP RCO
Date: Wed, 31 May 2023 12:48:13 +0800
Message-ID: <20230531044813.145361-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0508f730-1dba-4f8c-efd0-08db6192786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DHZ5q6W2iNrb6qlX5SaKU0cGszJ0ceEBXWszzGSUd071xhvSDCGoJ2Id56QZLwNzxLEci1S7m5e63ErrQWhk0swYsLji9XVXO2xQzfkF7iCKQXi7dtnna23WH9KKJoWOkJejOK1mGVubnfJCg212qkOp7oh1sIqcWGgC6xEn+HuXk8sKDJt5tIwRfLlA5zLMmQ/YI/tKHggFXd2hZrkoowbjU7kwNNFy0MtSvaffOSRXK2DQBD1Xv/vHm0luar00EQxs7bEoy9nnvZu6yOWxXBB/xEcob9QE5AlVarX4dNZdqqiitf+lK8isho6YSRkC3ix0FShItjl97Al/OHzdJU1jROjZ6kbrV4ajh8Ntee4nuK/vIXRP7Xj14/j9O9KTYAaQCI4JQ84e8n68+x8yg8EwXGSJgNKKYv9ebSOiINZn9FWx2iATlGvD4GRqjBD4IYOy1gjJCrLFBdGAKG6PquQA5nlP4fM5GTGHtG90KY8reoCr46R/Ch+1sx9XbiNypEO3IQnQHkrNBz7I03RAQHX4VGIaV2+fdfI9UiKDCUZjE9K0kym1DzsdM1wrU0yg4mAYlbYXLfwzkiMH73+Xk6AbyIaD1coro4ooYBhsiaMGfc6YWl95cn+ytU+zJNevdORxOPuapY2cllN3Y0V7Aopgmpco+xzw0kdOojVRgRskob5ncicQ5kJn7F0YhqRIzoN/YSTNkH2xVKjtRnUXk1kgfVxjK0S0tZDGHINXp+Vn5K+hxM4zGY4jOk9xuyJyyXOlAt5QphCC9fezbzPAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(26005)(36860700001)(1076003)(41300700001)(7696005)(6666004)(16526019)(186003)(47076005)(336012)(426003)(83380400001)(2616005)(478600001)(54906003)(40460700003)(6916009)(4326008)(70586007)(81166007)(70206006)(40480700001)(316002)(5660300002)(44832011)(356005)(8936002)(8676002)(82310400005)(82740400003)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:51.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0508f730-1dba-4f8c-efd0-08db6192786f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why and How]
Add back debug bits enabling RCO for dcn314 as underflow
associated with this change has been resolved

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_resource.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 3592efcc7fae..fbed835ffb54 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -921,6 +921,22 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+
+	.root_clock_optimization = {
+			.bits = {
+					.dpp = true,
+					.dsc = false,
+					.hdmistream = false,
+					.hdmichar = false,
+					.dpstream = false,
+					.symclk32_se = false,
+					.symclk32_le = false,
+					.symclk_fe = false,
+					.physymclk = false,
+					.dpiasymclk = false,
+			}
+	},
+
 	.seamless_boot_odm_combine = true
 };
 
-- 
2.40.1

