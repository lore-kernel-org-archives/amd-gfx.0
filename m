Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02F8C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3008F109;
	Mon, 22 Aug 2022 13:59:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 102F08F191
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juO76LZ4+eI3cWAKLeiqCP/Q3ic0pHs3+Hbn9R1rafRl7/TZvxvc+EDe7Ye8SbOe8M39IP45HLFIKhR2QaAi5ozHAD60AQBcemUWaCVGp2hXiwLokTbUcFs9XntjS52+I4qY+1xA+eJSQWG2GpPjlmlOmIYaYHDENlHOZfYVn+yRO4l8yN/qckk//OOKYhj/JcKPabPa798Tr7qmMHb+pzfDBHe1sHQyIlbdEoBet90iyLUjXzcacv/1lHxTB6o/bc9NLGOjT3q1wt6bUmDmbAdyH5A6/SuIxchrd4Y99fYrTcv25+MwAGnp2jIcSiNjnrl7sY70tHmK47686vpo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xfB9f/475++k0IDUHHeilAmOQzeAMz187jEsORcF9Q=;
 b=AktcgKOMm/6Qe5e1Rv0anr81NNTyPgB+JdBKC0uPgKq5VAFvhzv/FlOg/k6kk/RPKDCido323UdlPiPERATvjAHaI5PA4oy12zOucz8RIgMDpVxWUCCVmccxjKSoVqfzwq+pyXGr8kAb1VOEjpO6c7cAL02MTPd3Ws2RGbbjgUF+1yojdOE8ZFpZ5KLbbDY21usyCgvZAWBC23w5C5LWcaekmsIw8EK8w4Q3MRIjL7bbGhmVZnVmipJ4JCGPeCdxcTtKodGuRbeb7eKpSfExO5Pw9my98vjMLG5XhFvad/zew+KyiMKkkScsBArR+qdAww5GGhewl5qaIVyzheGUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xfB9f/475++k0IDUHHeilAmOQzeAMz187jEsORcF9Q=;
 b=I4/3iX2c6PUdpwIX0v9o2X4dm7J2O0hTD3teTIsDooSkftBlvR43CmqDEWcu3u9DIoMx0b26n03AHE+NIYa+8oOB8irI3xZaspLY1VOuf6MINoYx/4tsvVSBnIpGXjv87Lv67iQd+7K+5lMeFgi5ZBJzWnDak0qHDY36inj9ckQ=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 13:59:03 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::86) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:59:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:01 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:58:57
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: fix odm 2:1 policy not being applied
 consistently in 4k144 modes
Date: Mon, 22 Aug 2022 17:57:41 +0800
Message-ID: <20220822095752.3750614-4-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f836098-e094-4f07-6a1d-08da84467851
X-MS-TrafficTypeDiagnostic: MN2PR12MB4271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75uurMh7h+pBj95jgSCxVmQs4r7SQNiscCMIJuVF7zcfaOBL5J3I7JfyLl+4a9r6ym1HnMfarjiHaioXPUl3fjPtjfsf6TVsGnRRUY+4N8aL71wIQc5aTLIqHw2m9N0jmiII8XJETyaDNzS3YO5EyCyx0nqekbO0E3PHaMHtODPrWOPohasg+wGNmXFC5zyDtOA+egKhHKekih6N5OuP6fehgtFUhY4RVPFJeKi5xSBQdiyy72M/t0ajWi0b+YdzRW2pxsybQz5Yft21nWxjTTZflsN+my2FoNfahHX8pHG7pjuUOkaLsxFa/uyhj8T3A1Es5DhTvHSHUhn2BUkdYVdWUml6hVDrbC2GSZB67aERHHvXJNhhH5gS9LWXeONSvXVohslaEGGK/fidDJ1uzNvxOxtWDhNQTh3sJgzPDxIXva5d14Xwm/jnEGKK8HqLA6iK1cnQIiVpdUDC5ZVLDyycVsZpUHG6NTo+Acu8Zia646oxZYmQWS4BHoE2SLfU4CF73kgz5Wud00CTDfrf0ENwyondx7CYi6ERAEFMT2ekQqRG9sjjDp+X/koTHrcx8U790NWYCqYWBhaxdarDxcbZI5cfFXcKVWTu9ELAdiXsJY7LK+QIiaLDrR8M9wvw2rrens8RbESdfFVsyHmb7wt4/XfSaFHmWBNM/3FsTNsCbk5l0Hg2AyKF1hzrhPuNv25rCvOGYoiu+eB5/YVoAX7MXdnn2cfyOm+zuTyn4lM2LqPn8X5cqNonw+dtnOrB+rYAbVe4vLOUI6B3geL3gYdWGO820jQ45NQrrW12CqfIxfoZsIeSezTUCsuxCU7QR/RG4Ka2F7kReyxTM53//Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(40470700004)(7696005)(6666004)(41300700001)(478600001)(47076005)(186003)(1076003)(426003)(8936002)(26005)(2616005)(2906002)(83380400001)(40460700003)(82310400005)(40480700001)(5660300002)(316002)(70586007)(6916009)(54906003)(70206006)(336012)(8676002)(4326008)(86362001)(81166007)(82740400003)(36860700001)(36756003)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:02.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f836098-e094-4f07-6a1d-08da84467851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
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
Cc: stylon.wang@amd.com, Brian
 Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, alvin.lee2@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
odm 2:1 policy is splitting the pipes in 4k144.
then in subvp code, we merge the pipes. but since the
 configuration is unsupported, we keep the pipes split

[How]
for unsupported subvp configuration, redo the dml and
 pipe split calls

Reviewed-by: Alvin Lee <USER DID NOT SET AN EMAIL>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 8118cfc5b405..edefb3fc1c3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1082,6 +1082,11 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			dc->res_pool->funcs->remove_phantom_pipes(dc, context);
 			vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] = dm_dram_clock_change_unsupported;
 			*pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, false);
+
+			*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
+			/* This may adjust vlevel and maxMpcComb */
+			if (*vlevel < context->bw_ctx.dml.soc.num_states)
+				*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
 		} else {
 			// only call dcn20_validate_apply_pipe_split_flags if we found a supported config
 			memset(split, 0, MAX_PIPES * sizeof(int));
-- 
2.25.1

