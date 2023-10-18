Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332B1CDB485
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB8D10E41E;
	Wed, 18 Oct 2023 17:42:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A80910E41F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4dtwMhYssOJKoOLSwvoyAUCGhcd5F6FWdAYm4UU036jPEtgtub0Pc4GR2dgCSmhvsSBBJHSrSyc4/R57YHO+LQqpnSMERQUjfbEXC+kfn0aJP0htqzTElMOAZTwF2+pK7E1uemwYqAKc68HuSoJS9J6LIL60eNPgMK032sGii8ySw0mQ86lX8egoCmmuaeaU/HOzj26xYg08nsofCSn94fNxgHsxsNJ+O0AKx6z3oCnfQELjxrY+SpQAK6/K6cA6KmV5LFAZSvu8kb5cdgC0HA3nZau8rIW7aaUAQspIuwGIJ6b7Y9bU0zWLIHGT/aczNlmKky7jbFkLjA6MYCxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGX1fjf26Z/gmlEXRGexcT1put7rNxW6JyzTSsp7y0s=;
 b=IhByQ4PPCOZu3mS61G5/41M7zGjhysRLZT2hv47JRNoxlvvfWZ4ktGWTqW51155K7Br1iomQwHSn/4dklNIgUevVxaDlkljUo3kfQtbdSpNN4MwFntkIWKxQpZeYBTx2bcetItHZg5GL8cBlahWC+kNR3kLYB4h/n8T3J8rOgduvZXZePD6yr7Sy+/nWdwhhvjYXW39B+CoyrzUHK//u3Q4+kLG3jBebRYmC94MzydxT0pPOs4yAEwfH3u5Q92uEHw4G2AgT9uR/xLCG7orhBroB8l44ZAUI+IvS+oKr1bbrgf5AHw8MWHHd97doXLfU7c3XRUss/XATpAVN3RCKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGX1fjf26Z/gmlEXRGexcT1put7rNxW6JyzTSsp7y0s=;
 b=iu2PffhTAvsI4FEOk9bRsmey/tKwps1xLO2MnOxB5sUwN2oHCH1mXj0hNleBKvGuj8Q2a5WXff8HhbrEFv+mE7USYCgmsYKvG/3H+HPPeEG6IwAb2SxY3UGUcCNkTPYAP8RNKDxa+WsrgDfo2Rk7P0O0RG6VZZhJNl5nByBwQSQ=
Received: from SJ0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:a03:3a1::35)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:42:01 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::82) by SJ0PR03CA0390.outlook.office365.com
 (2603:10b6:a03:3a1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:42:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:59 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/26] drm/amd/display: Update SDP VSC colorimetry from DP
 test automation request
Date: Wed, 18 Oct 2023 13:41:14 -0400
Message-ID: <20231018174133.1613439-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1828bb24-cfc5-4397-1d1a-08dbd00188fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ow6RhsOdAY6iwPMrQMH5c/JeR1puuw/L/Swe0RkC8WDncusJHqVuH5imlfXMHUREDLujbQqq1ap1+Z2GgL2HWL18I3Fa1HEnzDZ/6FMbqaZ0Sp+GzhHdFC3eP3UeLF1t0IRjDFaYHZLtReO4GWkvkxqSXIJ5g8pjlf88T07/wMUb1R5iGXY0/fGCpm4hDHpvCUyEAhkIM1TIZHSL14veKws14Sd+3uIPb52P/8vSbG/0HcmIiZmxhlv0HzRNLQBOVNLa+uXA+nArfYu5Fyd382CTKy0eucXu2nUwXw8q6oyw/rofTUlzw97lA3fMiwkvbVzaneyzHr5aW4oabXpuOAAh4aP2rMNnG3nNDSIwFPhbmRudAB5TqoVhLHLGwShwqlJL5J+JkLlRB9Pn0wA4Im3iKLCbn4Fk5w2R4kPSG2rcGXuVJ7tNgSC286Ooe2fL+3YfHzVxGIVR+HmpcF6C4TWEtKtUGAVASN3AWeFBWk9oV8abEibZWRk5M0rK/SeDbtYP9pDORixaoEftZnATNWOTH6Nf8Ry56YXnp8xO5Lici3k54S8ZdoNecOHVsIN+3z0qqPWsPZpANhf9e+EBpZWC9AZsoQ0VGlIHCiSfboBz5iX9qF0BbqscVGXsgWxUiTMgLC4a81y6W1/XiiyTqRjDuAGJuHsTLVxjD+LpnmxHgPu6CY5W4zLwrg67KQtyta6FODqPeLDHqp2Q8UI08eqRXku3dOemd+aVvecPQp2idFydI4vwDrpIUAawptSnHR4ok1LsQ+H710+FtlkBsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(70586007)(7696005)(6666004)(40460700003)(70206006)(478600001)(15650500001)(2906002)(2876002)(36756003)(41300700001)(86362001)(5660300002)(316002)(6916009)(54906003)(83380400001)(4326008)(8676002)(8936002)(81166007)(2616005)(1076003)(356005)(47076005)(36860700001)(336012)(426003)(82740400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:01.3288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1828bb24-cfc5-4397-1d1a-08dbd00188fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Certain test equipment vendors check the SDP VSC for colorimetry against
the value from the test request during certain DP link layer tests for
YCbCr test cases.

[How]
Update SDP VSC with colorimetry from test automation request.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 0894e6aef3dd..21a39afd274b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -839,6 +839,12 @@ bool dp_set_test_pattern(
 				pipe_ctx->stream->vsc_infopacket.sb[17] |= (1 << 7); // sb17 bit 7 Dynamic Range: 0 = VESA range, 1 = CTA range
 			else
 				pipe_ctx->stream->vsc_infopacket.sb[17] &= ~(1 << 7);
+
+			if (color_space == COLOR_SPACE_YCBCR601_LIMITED)
+				pipe_ctx->stream->vsc_infopacket.sb[16] &= 0xf0;
+			else if (color_space == COLOR_SPACE_YCBCR709_LIMITED)
+				pipe_ctx->stream->vsc_infopacket.sb[16] |= 1;
+
 			resource_build_info_frame(pipe_ctx);
 			link->dc->hwss.update_info_frame(pipe_ctx);
 		}
-- 
2.34.1

