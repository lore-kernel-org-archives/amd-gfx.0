Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6338CE79AD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 06:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158DA10E442;
	Wed, 20 Sep 2023 06:45:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC7310E442
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 06:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1zD66c+PdHukjBTnRRmbKzNDOi03L3O1HJ1gT7TdwBena22+WUZ+JWVE4J6yxatuo4zsxX6SQOgXHDV4R03GZR829O+/QCelYDWVK94E9elRWzhrIq/gTdJp3DY0oJt9+AsKUtrg3Rd1w4Lj6cS+4D+ZTp8T8Swz1XRBLGvbtTipVIOiluTI9zAESVMfHWUwg5y8Rjbb00QFF4Jh5ozPiIigltebu2nGXiiWYoJCAKJ135toGk+nnlv9DWGrVuEL6pFCz1qEOyfdOktMiNhW1MVdukrJd32EcBi2QurRW5XVAhwewHOEd4cTJpCPTPQb3x4ewlEp5UUF5c0wSygSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFw7m25bH7LdnpzoT1Pz7Z9N3IEcpt7bRaaWcA4BMOU=;
 b=OZVf4wv/7iNfVPe79Q9csPZHoOKcfivutjXkqSco4FLk4HHT+y0BFBADNnLX6K+xSvwECUc4C0opzgcwoxAIPKb9KoETyCj8QR2+HlBadnGlgrCJlvoLTAr1Av/jlTNvvzAlpl2lyzY/EwCjcd1xghSNu2KCkJD7m8/9frdPcZD7fVNSz9aMFlqvTEfqh+1i0npzIx4RiP3ytqEXBU6NWsfo6unmnyWySpXznACJ/IH018fDF1/mEUjoe8PAWwnsPnJdymwELLgWtgNcz3g/Sqx+rSQ+umTUuJOnaZqPmLptZRPmuwoaFPmNGmpHWfXdvSs8gy3XpE1lS3fwkaGjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFw7m25bH7LdnpzoT1Pz7Z9N3IEcpt7bRaaWcA4BMOU=;
 b=q8ZE1MP4cd/eeHhSa9Ahzh2lt7OGi6sTtorCz0+VsTZOkmUtUhN9Mt9v/V3MKwvPCaWjd/1YnMWED1IG+3cd004DjTXZ6ZYJ0iJ/uS24mjmYSaXaMVIYJ+BMD0MkIbmdgDXs1bF8tMybLl5ypUstxM/K2erxLUeY/xmEUbSt8zw=
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Wed, 20 Sep 2023 06:45:37 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::a3) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 06:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 06:45:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 01:45:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 23:45:25 -0700
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 01:45:23 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Qingqing.Zhuo@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix null pointer for res_pool->hubbub
Date: Wed, 20 Sep 2023 14:45:23 +0800
Message-ID: <20230920064523.6361-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4243887f-6b7c-49f0-e4c1-08dbb9a53281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qq7XOJan9rOvTwO6S2v8MYq6gZGu0ZvOC1fPjgKhRuHrerFm0R9fCGDxH4ax1NlViJY0HnKs+WJPXvZb3cMV60At+F3Jl1abdZmcaM+MEmJftMuH2ZLQN4p6ofxpIf/BL0dLe7sdWvui7YwU8AxLCgegL4PaQrTPRtXCzX7ujbDrZ+pCsrkvop9+Oyg641Xw5dSUTm403pt3Cw7b8Gvy6kF9TcN8Oo2XVNcJkwURkOpp/7mcM9Tn9g1X+K5MXfSYyJ5m+VbeYBu7dm1T4KNbIV8vqjqP7jx5tiAr+Ny84CrHHltCMTZ17vITipODpwrCtC5gEsc4gGa8engNw557p81LAxYZtuK/he+zQja8LGNf7TJzkQf7mo9F7jvoUzeH8m+id3FzlRZvobF8YMXj/M5DYT1NAiX01v9xBRHs2+VIU/vmCYXk9M0qlhEs+XogGACLQNa8y/Bqr2a5Co26ckKrMy355zIOLz3Y23iWlPqRfbqN+wMIHPI89qjCkg2PRaOntZ+7I0DTp97E3h+tp8iyXtd/d6YtKfLiV5T0G2Bs4r9EbgShy3X2zDfPFMWrciqpJMbb3CNaskXJu/haPGEE9i8tVqFQ8BhlKddb8DvMBbAAuGHR7UAahNST3vs6Ge1OwMN5toBU0NwzxaFiyu+eEK0UaWrIOndA4R/wwv5zcAbMKLkhW7zdoI0lI+M4uB4yBa5d/+AYoeXNuXFsxIawBTYs64tmDakcn8QFVRK9r/Sl1yOPTEar5NPlrZxvWKddEiSTmxIC9u19WJzR1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(36756003)(81166007)(356005)(82740400003)(40480700001)(86362001)(36860700001)(2616005)(1076003)(47076005)(26005)(2906002)(426003)(336012)(83380400001)(478600001)(5660300002)(8676002)(4326008)(110136005)(8936002)(41300700001)(44832011)(70586007)(70206006)(6636002)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 06:45:37.0704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4243887f-6b7c-49f0-e4c1-08dbb9a53281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
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
Cc: Bob Zhou <bob.zhou@amd.com>, Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently, the driver introduce DML2 for future ASIC support.
But, some ASIC's hubbub pointer isn't set after calling
dce120_create_resource_pool(). Before setting get_dchub_ref_freq(),
these hubbub pointer is null, it cause the below null pointer issue.
So add check whether res_pool->hubbub to fix it.

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:dc_create_resource_pool+0xc1/0x2c0 [amdgpu]
Call Trace:
 <TASK>
 ? show_regs.cold+0x1a/0x1f
 ? __die_body+0x20/0x70
 ? __die+0x2b/0x37
 ? page_fault_oops+0x136/0x2c0
 ? do_user_addr_fault+0x303/0x660
 ? exc_page_fault+0x77/0x170
 ? asm_exc_page_fault+0x27/0x30
 ? dc_create_resource_pool+0xc1/0x2c0 [amdgpu]
 ? dc_create_resource_pool+0x243/0x2c0 [amdgpu]
 dc_create+0x23f/0x6b0 [amdgpu]
 ? dmi_matches+0xa3/0x200
 amdgpu_dm_init+0x2bd/0x22a0 [amdgpu]

Fixes: 50003b5aa5f5 ("drm/amd/display: Introduce DML2")
Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a93db60fe4d9..9cc7a001f9a1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -319,10 +319,12 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 				res_pool->ref_clocks.xtalin_clock_inKhz;
 			res_pool->ref_clocks.dchub_ref_clock_inKhz =
 				res_pool->ref_clocks.xtalin_clock_inKhz;
-			if ((res_pool->hubbub->funcs->get_dchub_ref_freq))
-				res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
-					res_pool->ref_clocks.dccg_ref_clock_inKhz,
-					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
+			if (res_pool->hubbub)
+				if (res_pool->hubbub->funcs->get_dchub_ref_freq)
+					res_pool->hubbub->funcs->get_dchub_ref_freq(
+						res_pool->hubbub,
+						res_pool->ref_clocks.dccg_ref_clock_inKhz,
+						&res_pool->ref_clocks.dchub_ref_clock_inKhz);
 		} else
 			ASSERT_CRITICAL(false);
 	}
-- 
2.34.1

