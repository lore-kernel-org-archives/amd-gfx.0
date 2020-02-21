Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB61C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66692067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IANIvywT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66692067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772376F4C1;
	Fri, 21 Feb 2020 16:04:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133EF6F4BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BL9nu47UlUNy4cHlEJWkrSWBEi1P0us6XY1VALDN/a/v1inwFKqyTDyPSrUbvk/UT+9iI5477+ZodTXLEIOoC5Ux6sjGV4WVbWqSA91STRP6hZbJ7X6FYYiadCQh1n1WpVbcxSO4/ZBAEQMjsHbt7o2WVm4pQtoL0eSwDL+njRXrolMQNpMQMjjAuZhSxnSMp0ycb/Wc1Pxyvqz9zqbnt3AVNlur6eEtnCRDgznTSbpcp14BOZ42nHWHSNBA3Npk2SqtGnNDcP6n8+AuHB8nXB6B4ZFKK38C4BVrjcgIkuhi9rofBj/ICwf+cKRbExTMtKXM4Me7PViSWxMoI/34sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcwIGDw5txcJbLVx1WAAuan/bud2WadjYYQgZzZ4grA=;
 b=N6xjxdadsjq40iGVdGH0totjC+jaf9v6jGKlRl9swiuOdvXUjp1Sd24KkKx2avgAeMGSwad43W7gnrAB6Mb5245A6wHx7tZtT3D5ZAs1i9jnyijcvAREQdDmRJwi0fjoaJwbVB71Rt9Vb9NL2a6trz3SWEyG4K661AuQxKnAPL20vNi8ul17XNOG6ajgkrTEEflNgoxx5DF5At8jx3Dgx2E0J0vAiX05TQuTxB4adT96Q7faE9xLtE6YFNkX3nOgQqp0z/LetwAt/8ac8umK3uSN3T2j5K4mX/kuJLf6ZhV+nC3t9gF6eaHARV42VZde1S4YWggCFLcx0lCekxhbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcwIGDw5txcJbLVx1WAAuan/bud2WadjYYQgZzZ4grA=;
 b=IANIvywTj/4bBsstTrTGs7EAVgbx7LwoEv22ANbiAPgBts2ZxBRys+9HN5PpbekJfX1MqVR7dn1uMQp8Byq2kVH23Hdla78GsxWjZGxV+PWnqOBKBJN61j7hGPqMuzi2YthTQzZtfmnmDNshBHdZWiDF2WX2OU2lT3HCNMb8Fzk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/35] drm/amd/display: limit display clock to 100MHz to avoid
 FIFO error
Date: Fri, 21 Feb 2020 11:03:24 -0500
Message-Id: <20200221160324.2969975-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:17 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c068f96-9773-4c8a-885e-08d7b6e7b4b2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572C917421C0D5EBE0CAA6098120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGiudkydH2pkL+shXIsM4DW7LAz/AOgtn8px4WcqPo7AFFj5+5IG0fb6KjqvhNiGd23HNP151rAwiyVi2WqUZbrlJDJs20XaIkFrQH0+FapNk1uHorLTt9+7IdizcS/+n2yX823rYAO8Y3AiMjtJAAWI50x9Psttus905whSJb+HtcRInDk1tA6gQoNqGrmecrC2Y8HgVJev54YClCyw1d0v7ZId3bpzp+sdiU6sYmQ+xGFqx8nqzIKtPB9DiXgcLk9kNtTFXQo9pVY15UxwrvK6tqMS2QkkpiJPpuxWpPF2DuXAFDpPJ7Htmv8YUVEoTzz2CXu2ZOymAH8WAOPz7YbupcIECANoFmlkCOjzdD8hXFDa3WezQK3ALn/SyDqQdebDyqHG6QJNn1p2vgSwWJrZWJDk6w7+rQnhbqHhhi8yWpx5Y6ZWgCqL6ULTM+6d
X-MS-Exchange-AntiSpam-MessageData: rjJWQM5MSzrJX7gYX3TIF8Ydtd25PqYdw7gBHxi4D5KH8c6VxyJV5wNjYUOV/3dhGLsOrr+mEKy4yYS7LOfQ/V6TtbDGvB/lV790nrvgrsrYY0nwOiEVAsQDoTsuzSq1t6lw/uUtikz1kAz0nL74Hw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c068f96-9773-4c8a-885e-08d7b6e7b4b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:18.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiLbOomN0fF6nMFc0aH//h9sk9TBOrGJku0y3C1NATHF3xld59970mrV1PNmfuPa/6uJaUQW0bV5+OC9fDVvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Yu-ting Shen <Yu-ting.Shen@amd.com>, Sunpeng.Li@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yu-ting Shen <Yu-ting.Shen@amd.com>

[Why]
when changing display clock, SMU need to use power up DFS and use
DENTIST to ramp DFS DID to switch target frequency before switching back
to bypass.

[How]
fixed the minimum display clock to 100MHz, it's W/A the same with PCO.

Signed-off-by: Yu-ting Shen <Yu-ting.Shen@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 883ecd2ed4c8..78971b6b195c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2786,6 +2786,9 @@ void dcn20_calculate_dlg_params(
 							!= dm_dram_clock_change_unsupported;
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 
+	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
+		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
+
 	/*
 	 * An artifact of dml pipe split/odm is that pipes get merged back together for
 	 * calculation. Therefore we need to only extract for first pipe in ascending index order
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index aa73025c1747..dce4966eca20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -859,6 +859,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
+		.min_disp_clk_khz = 100000,
 		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
