Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210B3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C200C10E8C4;
	Thu,  6 Oct 2022 21:28:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5E210E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBICTozTNLILGYaAnS6vT0YbM1kv6qPF9Ruf/wZQpLWa+qlwlDucZ7IJLkBNKG0/BmySNAfrWqoDljJu8pJLm4XAvbllxLATDJJ95F/HA7UPJCaF8sRtEP5+Y/1cA40BtVYtLcfJbvhaUw8aQkHDkV33vcTqJkD8bzvSo+krgYYA3o/zp6d6WpGINAO7NyuaSQR3zzhMRQGGIlu5S2+UwMhqSHmUFlKQ2FAyNKRnLilHtEQOR/ercLg1VFnuFPJuDVTvqpch2sdSZxVuoS59FauUSQmGspJx7ZcoThHkFou870yg5P9TyGmzqZ5kjd2sSeywyrC+cTqutfNJwgYL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxPPVo2u2lSMy4Io8TXIaf4s1Qh8LtB8qQ8mIII9KW4=;
 b=PL/k2/zY6QjrINVfe/kvdJLfCOiXhEum8JCzeo2VP7ZncKcQSuaM2SafTmXrzl6o14IFB44yMgr3Q3OMVTvYWmpifXmdvq8d7Ea70pmQgKwOMQzqn6Ue/ZadtwjlMBKRVDpv45VUl4nj1PwjDA/vf9ALaOZT2ORO+rvzFOU3PpIETfDmMTVSqXnIP+DuUEAHW3Ms3KozjMkjbQ9abBY1xI1FJUWTW+22Dnc1v7XmbzhJaGfIUJiFvFvoFM/Dg1ojmcb73VRQcC6c0d8VxmP69GuJiFY26S3pVOTtN2b6qgZ0PD9CrXpnkj92golxhs9N7GJVhMPPGOMoZcDnyQHtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxPPVo2u2lSMy4Io8TXIaf4s1Qh8LtB8qQ8mIII9KW4=;
 b=ACKpQe+shuHE4Yiajjnkwbzdp+060KiFCRXDTbrwNhPBus5DhSRU/48Osun5h5x/vZFZgsWkCpTzppixCAwb07k+loE+Xfe9b04/IhNpZjaAdZ2pRmyeurkK1blCLkhjUV4UwoHZPxzdwIZJI1oDjfcnPiDVOxI9f0Po+Gr61v4=
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Thu, 6 Oct 2022 21:27:56 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::53) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:52 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/23] drm/amd/display: Fix watermark calculation
Date: Thu, 6 Oct 2022 17:26:47 -0400
Message-ID: <20221006212650.561923-21-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbe3544-2ef5-4dcb-7d4b-08daa7e1a227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDVArF0R1h9BP+3chbU/w3UI0BWb8nuo+kKn7XMP1LGKWXng6LyJLn+4/khRdf1hph+GUZZIMTK6IvrQegoe71NIm5OxXNLpg6XBApehzhWXmrET7PurC9/WS1BIUM5UHBn7IoJRkTMUeyJ9Wucumz8UpM5imXunxaGux396uCwmZHcvfXDZEquATuXkVRWmN5pgSBQcYj2o9b8t+sQHSRnR+lsrRr27m32g4q9mFlmFRtQSddbeP6Q6XcGsiOjMi/4ZJlbQyeWfE64io8dtBKAPJcERZcKZAxZdO4L2wUrgQsUjOFkJTXH3Z2KE9T6fZdgA96EVuedRniMAihqDJi4erWOuQn1ozOYVyiVVjg4k/7oE7T+eK1t/DdQCqRBhG9D150Xnd8MnFTM4T3NEzPRQZZPPEh+vHF+IOKUCKRUVV3tSsmkPZa2T4mLux6ManuQdJdxgM3xdGdeZdJol/gRU/DQp2zbuJs8FGKc4CzbUAqfr/K/4AQpgzu6SPfFNyeagLCxQblLUDu/Quvs5Kql5ID5a4fEHl6GnBBKmybrZVoHcvhnYdVhaA1e8mR2uLKrHAW3TwRddmEK96DIk7dO6wU/PDhhkMEJxBLOWwMoVZw01NTn+i+e4+kMB/SbdXSUFPbnKPsCHOlOcDNhtr92NIy9yDKNr7QWbEgHlLHe521w/L9kb+slyWf4U/1zVjeezH2z2Do+5hZC13ItLSd3o+WJS5DZVPP8yeAJFmYhSWOURQHXzjBs12rmf8t0E8Z4nN1aCxugIWzw4ox9qAf55Vi2Xz+RMWDFD/Wfd5TVmpKkJXzus3MDFHMxlOfZd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(70206006)(44832011)(4326008)(41300700001)(83380400001)(6666004)(2906002)(8676002)(316002)(36756003)(26005)(6916009)(336012)(426003)(478600001)(81166007)(5660300002)(86362001)(186003)(36860700001)(40460700003)(54906003)(47076005)(70586007)(16526019)(2616005)(82740400003)(1076003)(356005)(82310400005)(8936002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:55.5542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe3544-2ef5-4dcb-7d4b-08daa7e1a227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Watermark calculation was incorrect
due to missing brackets.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index bbde635c56fc..0541e87e4f38 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -781,7 +781,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		// Store the original watermark value for this SubVP config so we can lower it when the
 		// MCLK switch starts
 		wm_val_refclk = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns *
-				dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 / 1000;
+				(dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000) / 1000;
 
 		cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF;
 	}
-- 
2.25.1

