Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A27ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A761210EB92;
	Sat, 27 Aug 2022 02:53:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C39D10EB92
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fji5k7SWCnUSl2qpF/ll7W9F2mnp/vL2vbH9V5TSrAFgHG0vRN/6+wixRkiQHdsKJ9COE8cOI08BaJ0/GGuliNUKl9vIX/eOP0zzBlcsOz1QWlNx4teArCDBxr3xcETMAHiWV7/HtNdsuQ2pOCZs70aI7OzyaIb/GJVIBeiR1B6opLzX0N029eBg91t766gdqRA0yF1OdtC/px+9mf9EPaox1VF2MFMim4perv/+8w8yohIv+fEAqDi2KTzcQ1NVVgL7gS5Jj7ImJ+tnAH3UKEnKvqBLbzfxAN6lRc2ppXAWEUboZQpQlVrgquun1d+y6NKaGZ84eiZh/ZZWcjz5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYg0oa7rbnFWIY9SG65PCpXSOWv7mA+1EAaSKmm9L2U=;
 b=M34JJHpo1Ap2hoVg7rBpkkJsso0gqm+r6z9tn28kz9bTXPIJLC91pDLMdm3P4vTyn4SeGNubYiWGJNT3OKHCZSf3ML4dfa9qpaMsdkMrbxpxqVetyx7OScHstBlwaqtR4l33GfcEox1EDx2jBFSFnaXQivrX6tzEs2jgKB04EH7D7DnQg/GoLIosWpcvsIP3x6KR5j5zRrNEHKmyYBc4wNwmGBDwZ14wcjZs19alhPPkEVcPVzCx7UlzBbYRRxkviFwtVGgUu+bZxCUHeDi4O/EtQPUgkPPfxnsQGIs4oPD3Z/hMtW485oV5BtDMl5l3BnstMpeZd5StITxrEHKt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYg0oa7rbnFWIY9SG65PCpXSOWv7mA+1EAaSKmm9L2U=;
 b=l8Qh28yRlCbjwKYcVJFev1AJCZN6dzKEVhcu4ukJdwt3oGiiHkiTSNkmMSB/88GmBbBhsKCBdRRQOTPKS0V/64eLwF5IwpZoQB+WFpqNIIdDVOm7+bX9zZcEjICz9i9RwjVjYvneFVwUfgdu1yfLbkb1r01X943zSESpgeTa1Bs=
Received: from DM5PR07CA0081.namprd07.prod.outlook.com (2603:10b6:4:ad::46) by
 IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Sat, 27 Aug
 2022 02:52:55 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::b0) by DM5PR07CA0081.outlook.office365.com
 (2603:10b6:4:ad::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:54 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:50
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/33] drm/amd/display: Re-initialize viewport after pipe merge
Date: Sat, 27 Aug 2022 06:50:50 +0800
Message-ID: <20220826225053.1435588-31-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ecc5b4-dfcd-4c54-8ac0-08da87d73e03
X-MS-TrafficTypeDiagnostic: IA1PR12MB6355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwuwuYOg4IYSS/NaE2HRKa6zw2OZyzrndNHp2Wa+9PrnscRiu1irMlzyLPfXVcNX2J+ryv1+q6aUl+bnYZm90mkDNjI7SoCVon2u1SmkzlskfL/349wFOeGOUzKz/IPaAH/vlbxq17lS5eLCwcrKh5xcY5kDgzopGu8azBo3NZQBf4D5MqRxjYYoBoeKY8WiPRE1k0YNQNOTAeNhWTU/iX+BXIithtSoe+rAQrqUMlVjcV/jBh8tAewPfuJAk9uF+/iWNTKhLSI51KkiesOk+sHeJfj2bGdO2J2Lmd7n7XMJY71BADMkd3GWJq7Q6bf4POdrktW5jpUsqZW+GdB0cNxxx3UDycxZ4wSKEsVDAgoOKGzKWz1YHhTQ9xp9To99wL6goKtYZ5v38CFJC8VcsJCeRv9sW8hkHM+zaQLGBfHpEHkRb7b5wcPekebwRxbaPtTdrdBRTWiPCu6gznytrSEaNQfgoWcQ+ARgsnF6GOj4loS/OF44C+yIA0JMWMQTfsTm+J59eqpeoQUAmKTy1hSSo8DMOo6FtfE8WSOk91UwqWq1bU/WPpvzhHF0jsfhMnFHpx3OlINe+jhmwSHYXUAgfBi6vAe9Vz8fo5TdDvicGmtwUpFS1hTOIQ/0tgwNu/A2d/RXxeu8y+UbbFX5lJWFWTuMTAb6EppZCwvxk83J6r4XNTpk6p5xsMdUrK0f9x+8ZlpuHbaIHfU8FOI+v6t9u83za337g5NWJLP6d65ymKiCMewGibSnnbfy3k8Fs4sUUcz/JdSMnxM5kKzZZBvAVv8bPtEpeqUP6US8GZrGdCIzJStrJfZ1kvpXFSXpJkwtrRakb2Z7Uhu+CWum1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(81166007)(2616005)(36860700001)(316002)(2906002)(478600001)(70206006)(356005)(8676002)(40460700003)(70586007)(36756003)(82740400003)(40480700001)(82310400005)(4326008)(7696005)(86362001)(8936002)(6916009)(41300700001)(83380400001)(54906003)(426003)(336012)(1076003)(5660300002)(47076005)(26005)(186003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:55.3547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ecc5b4-dfcd-4c54-8ac0-08da87d73e03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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
 Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>

[Why]
Pipes get merged in preparation for SubVP but if they don't get used, and
are in ODM or some other multi pipe config, it would calculate the
voltage level with a viewport of just one pipe from when they were split
resulting in too low of a voltage level.

[How]
Made it so that the viewport and other timing settings get rebuilt and re-
initialized after the pipe merge, before calculating the voltage level so it
would calculate it correctly.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 23a661f541a5..1b62be823b59 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1024,6 +1024,15 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	    dc->debug.force_subvp_mclk_switch)) {
 
 		dcn32_merge_pipes_for_subvp(dc, context);
+		// to re-initialize viewport after the pipe merge
+		for (int i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (!pipe_ctx->plane_state || !pipe_ctx->stream)
+				continue;
+
+			resource_build_scaling_params(pipe_ctx);
+		}
 
 		while (!found_supported_config && dcn32_enough_pipes_for_subvp(dc, context) &&
 			dcn32_assign_subvp_pipe(dc, context, &dc_pipe_idx)) {
-- 
2.25.1

