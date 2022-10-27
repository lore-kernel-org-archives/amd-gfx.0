Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C404FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC49410E6CA;
	Thu, 27 Oct 2022 18:39:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE8A10E6CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZryQanKTGuL10eoECD/hT5HcAptJcJAhWn3/r4YenJmIbF8fiVcS4KARpTKyVXqMLZimCkqA5A9QMjBzAWx0VAI7+PPbYLguJtsIJI5sTGbJ5c74yeHsyovrUonv8hZHKSRdbDlX9fKSKJctjEjFbDwlQlKMYyiKlGq22xuWwQiS9+waQktk8DRnbL8t5t/+ypRvV4sBoWiJ7i95iOogpamhK9DIUcYJEP6s9ZJ0Cn87Rpr2R2LB7C2PcM/FpA74IzlGoZPmH/3cgmd1An2aV6RxY6s4XRE1UF+ZcS9CtSm51VLzu+QH+tk/MLd10u0stKgoIK8zXUJCvf4qyJIgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhA5t7PugjfIH4N7vWd8gRSZCvAJ+blJw+KkRfjk04I=;
 b=V9OsPLo1dGZap/Dilre+mN34GIH6G/Yb5r9xcl0z16fBNCR9+PyvQ4szFkqY3b8ntaRlOZQKp9v387Vstu5kwUXhpK2Xz1xqUrADKGSpeCzxWn8EfghoO4XV0RPL8hRPEpmQCb2jV3FclR/TN7CnOhtAC4B12xaJd0Hd8oQ9P6Wd9aGJrUik3vkskDPcXFnLQSDFZYJ4liVeezgPyP2mODXsLMmP22wDpS1R5dXbd5POQfqs4KQ4xWg943fLpRXtvOTHMKYWIvmnd8bxgA2YXpRSkrSMkLxqwd+uYPevMyMhKVYhwZqUYzuKQH+U+oFN63/DFrYVTfrkSPIY+nMo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhA5t7PugjfIH4N7vWd8gRSZCvAJ+blJw+KkRfjk04I=;
 b=Rbimb4LCX9GkzPcBLDfk0kClc/jBtH70ixGvg4GQaYMzXyPhaeDhWLVXTomURXwj0m1UbWziHbYvUqwVW/A/R34L/rQr+xOcymLDxIAzlZt+zvhW93cLzrFs4wM5dPqU3zlxo4zJxEjriNI3kACwZFd8QV386XvIcghSGJMGJeo=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:39:52 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::1) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 18:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:39:51 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:39:48 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/18] drm/amd/display: Check validation passed after applying
 pipe split changes
Date: Thu, 27 Oct 2022 12:35:30 -0600
Message-ID: <20221027183543.1117976-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b22b99-cfdb-4eaf-8daf-08dab84aa242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubT6vealntEUE8O8sk9Ov1voooqwGsz5JXtLGTCxChMlnSOjISLAN3hHucRVY7/zfDfeoGs34q9YZZ2U4TtobzTRHu3H/OaqbTZQsx/wYIEtdKLvqS7x7t8X0p4fUvHoAPYhoacqOyR4P/pKjY0XKoodsqNBI2DAG15/AtDWgs+AiXGRKZhe2vrNfYw95Ojj5tC1NmNW08CfSrkEjcDDG/7LNafZFAcv9/SJGvNwUAltzuvFiX5mKesICGZ5FXHrghn2MivfdU0B/8U0TMmdeitxfi3jLBGJ2QwPvDglblFa/tGgI8oVkmTN8v76V6yHJaMFYPBxJIizjotxTouUFUjPUF0pX9hX3L6RX+HnwcVnLSR6mR4jl3zjvB6e+/w0KECz+8POrH9lQw13RUSSeTtZj8hXTvHvyoP2+5C086A3HE+mpWNFVEYlrjejayIL3v+LmTQgmanyZTvIwX+jkFDqMWb6iMo+mhRGOX12IoITDNmZ6Tu6yn+cI9aHFNsEx1idaD+yEKuZ2k8r0QYV1teQSejiKbGGXzRLvOaBQgJ+wjvQ5eoqmJgLZ5XP47F+yykHwGcm9GEUCLyxcHE5r3lFYXL7h5fQnH6LDbWcFSVVnf7Ab8Ovy5eVFgo54y4+RPKjz+AAC4ncmCsGCcCWisaAzhutVxpOEekazot0xT7YLGKLJHB0uJbJsd83WFU5dMUtlvd395MyFcly6CIvocNJNqUzxStz880Np0YmSdgRXQGzvZ5kJ2/JPhMzIn4v/FurISksvoeEYOwHoyxWvhJuA9wO0ElU4kd8eTpnApnwdsqajbHCK+oCwQ69d4lX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(186003)(478600001)(81166007)(82310400005)(356005)(82740400003)(316002)(16526019)(6916009)(36860700001)(40480700001)(86362001)(1076003)(54906003)(426003)(8676002)(70586007)(70206006)(47076005)(41300700001)(2616005)(26005)(83380400001)(4326008)(2906002)(8936002)(6666004)(336012)(5660300002)(44832011)(36756003)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:39:51.5239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b22b99-cfdb-4eaf-8daf-08dab84aa242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Validation can fail for configurations that were previously supported, by only
changing parameters such as the DET allocations, which is currently unexpected.

[HOW?]
Add a check that validation passes after applying pipe split related changes.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b6cd10f3181c..9c03f62b9d19 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1736,10 +1736,12 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		 * ensure all the params are calculated correctly. We do not need to run the
 		 * pipe split check again after this call (pipes are already split / merged).
 		 * */
-		if (!fast_validate) {
-			context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
-						dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
-			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+					dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		if (vlevel == context->bw_ctx.dml.soc.num_states) {
+			/* failed after DET size changes */
+			goto validate_fail;
 		}
 	}
 	*vlevel_out = vlevel;
-- 
2.38.1

