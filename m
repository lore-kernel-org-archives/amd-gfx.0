Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F23C0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7875310E5F3;
	Fri, 20 Oct 2023 21:30:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5F310E5F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqs4NtVLqjo4y7DuTsq53ATFzqQww//iuOlql8CJr1G3IHYrJSzMKS+kxZug1pWPc99GgGazrBff74FFiCahJShyEe4UFO7LWj4BuSFhL84QmB0ZOZGbx/Ews+0lXYpZTeTYSUuoCB+Y7jvALLc2gm/geuxuNejCrgnq0rZvFl9hcLVjO+YG7sAOZL/mSne+CQX+QWTHR6l6O3J0gGRBW0W29C7oJwedYROFSgoZ43MiFuli4KqBwWAf4L5T92MiKmQDj6e8JmY9GG1Ud5dbXF2Tp0e5lLrabZr6LWJLrP/YSQQn5HLy3z55QtMD1zcCsNennLdLLEQD0Ito9jBipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/5d0h5P8VSUN13TrXCCGovwz8Jx0b0QCKbTZV99qfk=;
 b=QIlN5fUKMFgZHk1hTrQn+egbL/yp2U/LesZAvEOybL1xLpjChnpS1xWUMEso2DkIYGR0jC7dlJleGxIJpw34kK9tBTQeO4kSTBLM0jZ9eVmY51TRztFCHODPNi2MrHuwcAivoZwIMxri5ub2JdIWNRamWV13dil3glWw5xynid/OjKnF6VZfPOsaCC5OqWX+diyg+jgHD2M070V4QujBIsk/MwJ1kIYe4Mo4+xL0dEeO/HzyNa6hHDLhf3art7+Bm/NQtPVhCkMm7VTBWEePb896+lb2zzB9l8PFPaYSj3RkQtX7YA2D212QwFcZOb2v8l5/JX2zRmFql0AFqZyuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/5d0h5P8VSUN13TrXCCGovwz8Jx0b0QCKbTZV99qfk=;
 b=y4BvyahBfZI0I10s2A9kZp+c52yXLZDnPt1WrRFttccMufQfpoDIyg3kIMU0S2b0XTkckMUYeFDEz1vrK0ArvUW4f3TuBZI5bKqFlRmM2iEfAlkVCFs627F2XgPQ8LlTRKrqYGuLNpe2CUpOIyLps5gxYALNjyqzdyIoHBHBaB0=
Received: from MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15) by
 DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 20 Oct 2023 21:30:40 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::16) by MN2PR01CA0046.outlook.office365.com
 (2603:10b6:208:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 21:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 21:30:40 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 16:30:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/display: Fix DMUB errors introduced by DML2
Date: Fri, 20 Oct 2023 15:26:34 -0600
Message-ID: <20231020213009.486473-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
References: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 6581e533-da61-417b-688d-08dbd1b3cec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhs9wWvIMl9HYBf8mtUWvTe1bYF03RwLmuWHC9deGTQdHyHNfq5dfUI0dhXB2XBD+YdGZEfSAJklxG3AD5UbIH+SX7qb4TX/zPcWAt9hYC9iM2sGHtRPsojCjH0jNtJipZ20oQlW33vYEJRIEasJujxWIfReEby6oG/80YKQTN+QfHSe00TqGZLXh/rJPLheR1v7NS3a5Np6LFIMDVBaAS/7csJPM0diV7nvAcoFsh6HaTGGOOHXOR1jYx7cMYY2Di8QvL3JgZ484V4V6o/M7NYPDvRKCxc9Mw1wreidmNhPJ9HA5uksfGPFGwPwG0Vwbz+5ZNyBd6Ko8eSooCz6DqaW7539qjDwY+Wk5YY2Wl7mv4lZoGFYOYmMERhLHVF4+qD5PYp4seIHmexlVQJxQynDdQyxI/0MH7BanLoiz/OfVBjeJaVv7+O8U2RmK37zbqGrn+d2n1MC8DnmTI7ipEQ5v/TouH41yA79nnrdWNxHJNCX8D6WIRq13HEiq3WdEB7SxcOsykv0qG4bbctnA+E+iO+4VBNH0m3ti8VexNsXS/JV9I607G2mddoxx4a9urflhSRWUXtYhVQb/G213DAmwZon049MmhRaaqe+rxe/XRzLiLfWXEXlBsYYd3+jjw+VYK3Qo7e4nrooUIz7Nzyf/dZkTOGmQjy8yTD6zWnvfv4llB0lrNpWxB8hfe1u3E77JCQdD94t7dll9Vw3mmKZ/SDvFqjpuURS1dubBCU+VnqT6k7CXF3Epwn7XDQkoZ0XRNvGAJJDZjmYLkXB4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(2906002)(47076005)(4326008)(41300700001)(36756003)(83380400001)(81166007)(16526019)(1076003)(36860700001)(336012)(5660300002)(82740400003)(40480700001)(26005)(2616005)(356005)(426003)(6666004)(8936002)(478600001)(8676002)(70206006)(6916009)(70586007)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:30:40.1048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6581e533-da61-417b-688d-08dbd1b3cec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When DML 2 was introduced, it changed part of the generic sequence of
DC, which caused issues on previous DCNs with DMUB support. This commit
ensures the new sequence only works for new DCNs from 3.5 and above.

Changes since V1:
- Harry: Use the attribute using_dml2 instead of check the DCN version.

Cc: Vitaly Prosyak <vprosyak@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 7966f319c66d ("drm/amd/display: Introduce DML2")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 97f402123fbb..f9e472f08e21 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -321,10 +321,11 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 				res_pool->ref_clocks.xtalin_clock_inKhz;
 			res_pool->ref_clocks.dchub_ref_clock_inKhz =
 				res_pool->ref_clocks.xtalin_clock_inKhz;
-			if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
-				res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
-					res_pool->ref_clocks.dccg_ref_clock_inKhz,
-					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
+			if (dc->debug.using_dml2)
+				if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
+					res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
+										    res_pool->ref_clocks.dccg_ref_clock_inKhz,
+										    &res_pool->ref_clocks.dchub_ref_clock_inKhz);
 		} else
 			ASSERT_CRITICAL(false);
 	}
-- 
2.42.0

