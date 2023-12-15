Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942D1C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1988C10EA5D;
	Fri, 15 Dec 2023 16:02:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6B510EA5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D83kCXMvqUDtrLumLBzKWNjfL734kSpOQzzcpExNWvGa/nUpENWXHVH0IF8Xcx5OqhXxZI3xQzsKkHyOgM07yikiL9SA1E2h+z3n5oVfUe39MmJ+8x9fWWY3LmOapGwPVvJS5USVDwcvqzCsHtIvwVTITiP2JfW6xZBeVVqGyN3LIg8jX5Bf/Nc9Yn3oyvRdoBZfgU8BHe9lNxiuFY0impU3rn4O6tWoIJ5KT126BDXmpr/OmAPGRiuq3l16kizHqqB1hQJWmS8SlxwosF5J6luj0Oz6qFcDNSQmZcQ00pgjdXRywpHuv3mSkyf375BTi0+Emj/5DPbQ3mhdhiN4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctxaJ7MdCHY+QDZFnoDdK9Mw+njZtOVNvufVwrVKLqI=;
 b=J+BV9SPg38Mz3jhfBSsc/7WoYistpdxLX7rdjJNugix9RFl4Ym9OzKU8LROsH79sQRGZ1nip5ZBthOI3r+JRq93xdm43Fqf+pu+26tTnuJvwenE0PsQvRLM4aoz7xdPyxTcDPS1DBH5X28RMFaFF3m7Yo+eenw+o0HhEDhC1zU/gCW8zSZPgeKv7ypDib7osF6AqjicktS+OhEoNtzc9Gqimx5Aiai2GHgSr3z8BM/W9Bu0Yawb/03MnFIMvfAlZYjnrwKluSVJ5zVSvZwQktc980OnCAX2b9B2IAoTN4TBXmX62pZvDAHtAlvUuknH3hIoRYB6ByoPYA9GdZBnenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctxaJ7MdCHY+QDZFnoDdK9Mw+njZtOVNvufVwrVKLqI=;
 b=fOnRYbLqpAIh2yJXDKG44jT2YbksQ6A1Es8ngS23bLyayCIyjanUjWcGfj9ha6XBeQCvFWZBKfDuAUiX0yLEGSI5oZnI0xJyyLr8VNzUH2g219IGg756yTgZZE38LGJByblUeeLI6xv60n9UZMkO84xqzBBzoM4sMgXtPL/Ia98=
Received: from SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:02:11 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::f5) by SJ0PR03CA0191.outlook.office365.com
 (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:02:11 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:02:08 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: disable FPO and SubVP for older DMUB
 versions on DCN32x
Date: Fri, 15 Dec 2023 11:01:16 -0500
Message-ID: <20231215160116.17012-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: d09bc165-40a3-4deb-327e-08dbfd873267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WE2t8n2SDRWfRcu5lQEMmg72F/3EIT6Onr8j/Gz75XGqgHxBSBI+noP5m8V7+QrTHd2kAc/4QdYnh8T4dQAO0uRBeOvwJX2DkTByodTYuTMMLzrFqrzDBTSF1lQn85AotkSyIx2Y10b20/eFfCCT62Dg7kaRlEazKz6wRx4VajDxVTOa7lQgtpSm5soXZY2GTUKpkLWyuu/tLokLZcBkL8mTb7s42GNFdZn78WZQovJJpZw72N45dIbEOJdPEwXPpcmEIvC3CmFJGZ4S3QTWLjuJt/Yns/IjSaxM62+ApXbCwsEyWpsM6hZnVrFDODDp78a/PbdmeDtBLp/CkKrEfhbSM+gpEfs8uOWS3AiDI7Y7UXFxih74Th2KG5fw+xv68A0o/liUMmAE4lSLKOhtOn63dpLZC2vqGYZDsbjilF6v1kHSfrZ0/6mTEVdDTyA+A4rXMkH+b7CP923n62v+e4F0zJlQ3vL8fXVnHls1oK+lc2ikedEztkteJfgKvO5l45SYzKgIeq+PTD70NBDx52q5/lm/OdBrU0T8ZnQkISFealRdKXF2M96Xg+SDVyPXBwcqHBKdZBwEQB7BvNz3PPULXv44V5mNJrwqH65QaIbGgWb2eKzfQwyMs4Dp/pB5X7X2iVLfkUATPPUgXgwUtbICJM6o974DDua+dJ7c0CcnRIXozyzyU0vQHHP384hSpv7UZADAScBJGJoaR8fQWmeUrqK0Xm2ktt3xwySq3dFPM/mmOXXQmyVn9xvWu4uu23IT2/YIGLm9W9WEE9PPNpiW/kB5dxYq10DP2YyCAVxJUSHpP5TeLLuCSSQ94tluqEoXSTDb4d+qFVc7iEceFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(83380400001)(336012)(6666004)(426003)(16526019)(1076003)(26005)(2616005)(478600001)(6916009)(54906003)(70206006)(966005)(70586007)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(44832011)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:02:11.0312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09bc165-40a3-4deb-327e-08dbfd873267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Samson Tam <samson.tam@amd.com>, Saaem Rizvi <syedsaaem.rizvi@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There have recently been changes that break backwards compatibility,
that were introduced into DMUB firmware (for DCN32x) concerning FPO and
SubVP. So, since those are just power optimization features, we can just
disable them unless the user is using a new enough version of DMUB
firmware.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2870
Fixes: ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/r/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 5c323718ec90..0f0972ad441a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -960,6 +960,12 @@ void dcn32_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
 		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+
+		if (dc->ctx->dmub_srv->dmub->fw_version <
+		    DMUB_FW_VERSION(7, 0, 35)) {
+			dc->debug.force_disable_subvp = true;
+			dc->debug.disable_fpo_optimizations = true;
+		}
 	}
 }
 
-- 
2.43.0

