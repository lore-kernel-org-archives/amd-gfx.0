Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2627FC4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8FC22240
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8FC22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D7C6E11C;
	Mon, 25 Jan 2021 13:44:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C633D89F0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFLaDrUdmX1XrYB9A/ErNLFef0anneNwAC5HTVlwR57hjuWfNZr2V/9eHBQ5ahKlphEDIZ99/y04c8BUeirFgXKVbsiuZt7lmcPCUBAcUNoN9/2dAtqf/3V5rpIc3EqkCsWs6re7nFhoz0axKv93Thy0hwrw0wkJLhhbXi9o3SzY5zW0HogOFaXZGG/CUDPGvhPZ6JkTV9o0qGvwx+oTF3X6H9lBqPxjpH3k/o8JK9Op0ruoP6kuEQfyQn9TlGuhRQ8fK+LwL1pOWMfUshK4FPlO0BlpAxiSX/SEGobiqq5MM2Lv74Fkvo9gDn8bBF2MNoQT1z83GADoDvHc4VuetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=042DyyY+E5i0W038hYsMp7iZ/BYonQmOsKy5Oa/YLSU=;
 b=mghJaZnNv1sWihwYfJNrKJByP86eh3Z67ydfUzD53W+S3LtWV9oUlRLm80JlDi70sCd8sluhvTP2dlHAKugsTmN41p8StWls2JZMkjPy5VOtuEHp/icdmdhxUnDUyoIWBFmv77lcGBzNLFJGRUAS6w00SEpI0HzUcAbzL1i6hLCnuolYSRmHwozpJvZWz1ofg/pq7DdhjQbmFBWEZkKeeWtjdNz3S1rHEh+aZ1eBCs6JshE/cP+0wDyra20z6TS2QEZccG95x7ZF+lj2XJT4YiCiOdtE5aBDkV4opMYaKDLcnz81HoOn3Q7rJeqN0Lsty3s2WWiwYi8J6Y3+DnqcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=042DyyY+E5i0W038hYsMp7iZ/BYonQmOsKy5Oa/YLSU=;
 b=a53I14ZdIBRPPkMVHUx2eoK4ZmvnRiQZjUH6D1cRf/mbCdHDjGTJSCwm88GPdh/m64C95Jl3Q+sPh+9i0Nypqwjm0hWH4lzC6ZaGeH4hGte2vRZDdVVKakJn7Hx7Fltpp3ZnlGY6AXQMdf9acAsP5S8OE2xUHz+VfMTi6JoIR+k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Mon, 25 Jan 2021 13:44:19 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 4/7] drm/amd/display: Move calculate_wm_and_dlg to FPU folder
Date: Mon, 25 Jan 2021 08:43:10 -0500
Message-Id: <20210125134313.305184-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
References: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:7f86:f3af:1efb:628a]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:7f86:f3af:1efb:628a)
 by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 13:44:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d18b0f9a-1b35-4827-b929-08d8c137506c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041795C7D1177288D845EBF98BD9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjNvPLsF1XgawpyNuV8IUbjODvqGoQAj6xiu32rbL+NhmtiZdayHDnMiwLtYfOSMDfsldMPFF9WEzGLO4CHjUo+61rZjmBbafZrnjTQvpe+D9QIWR8aZZjAA/K7WLFh6UtSXaqMnJDGt2sLHLrsovi52i04QHLtDa5BxREfizc5G4fB4ulgrBJFg7iY/U+vxTZri0t40kcGMectHFwFcAOuFbpnPN0guL4oFLHqH9WRca/ynmVxDgZxzL/7p1TT2l+FJRH8k5dk8hhgtHYL4LKJPOJTM3pqUIhZ1XeqY+xt4RaNlt2mBfSF6s/BSio+8dfG9vvq1kGvJ6Rtxc6TUa1yLuznNJPP3gdLeE6QLVaoIyxpSKQHYefXoKQMlaKT1b8wPfMH4+KjRxEam6RVUBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(2616005)(316002)(16526019)(4326008)(6916009)(1076003)(30864003)(66946007)(5660300002)(66556008)(478600001)(66476007)(54906003)(6506007)(6666004)(52116002)(36756003)(8936002)(6512007)(83380400001)(8676002)(2906002)(86362001)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TWsCHAV/L/vNN2lOajwmhp6Rw9VPNj6qJvNQ28dQH+zWu23+Hzs8efr4rJ8F?=
 =?us-ascii?Q?r7G2Yk/wF9TYFInj3vWRWyypYz9qEA7ekINUkbqr/4Lk+0cgdZcU1F9oSuoq?=
 =?us-ascii?Q?Wycl3YeenS5VaJNwfShmx7vIyw6iYiIZmnQGms3ZzSkc/+v55aygc2+xJI/O?=
 =?us-ascii?Q?Vwx5Es/uBWdwso3Yl4gagIGHEaygZQQc361Q7MZCN+Md6H5MDj5ZgDRhVwMw?=
 =?us-ascii?Q?vTSGMv7jEnntLdfLecux0v8TloTG9/1xXeWdzTzGy46XzH2zMAFUh4G04PXS?=
 =?us-ascii?Q?Jo32r2WGJRu7NQgs0PquWMJB6uRXzMsI/rDvvJ/th9J4OVSdPO26l2OnYdfH?=
 =?us-ascii?Q?5TooOaDQRi0aOCwdGw9KbmoASXcIi5deDlgwyK0kdlcnfUx/WRi6HQYzKk2B?=
 =?us-ascii?Q?0127TxKfy6C/CkcobjMOAiwibihCYW713Zkd6L2LIXE6ardghlWiUBOeDtkD?=
 =?us-ascii?Q?Gr9in0K5D85VKT82bbXs7R8SEW5hj2wLNobI/tbY+rLGyVDgoDKhSwuBKG3u?=
 =?us-ascii?Q?WNzWacp9mK4dnP5ULvXBlf0biGl2t0r+he/HOQjGmCMWPCCSExSbCjVhru/s?=
 =?us-ascii?Q?oi9gcsUNQAFZVlCRyXz9vcWIuLPqY/EL/cdlbSmoDNLSdgcB05C3QMzUBzVH?=
 =?us-ascii?Q?V+wUtiLtmjbxarQ6ZQZBqNyTBJDouNEDKb8TsZUUJMamovfULSn/9TDS26dL?=
 =?us-ascii?Q?qC89PjOwLYyZzwLPDQOi6GlzwrsjN3gfOghQMKNKCPXciWKk+PwuZHN1obuc?=
 =?us-ascii?Q?2mKXWvuI28zN/15p7TR7Y2KZYRLSsZjiwwty/FkuK90umW9Q9gVlWEWqCIit?=
 =?us-ascii?Q?jQpQIq9K6SxmCv0A03Q8wGMj6G7lmUHwRJxdebjotyQ/dKxvH9AunRZCOok1?=
 =?us-ascii?Q?2NTkbtmzFRrAaYGHYap5ymAtbAqgw7fokHhf+NEFWmtiQm+U6kFCvUkm3IMb?=
 =?us-ascii?Q?ip+dljc97Ehlxhj383d1FkYSvRQ+GZQ8cz0dITVnLBj00v4AGeEum4ImHjpi?=
 =?us-ascii?Q?NCFpz78T8LOTDs/qjDzAsdMKFerDgvO/Qr+cHtHCmdgTdfPmn++jlhI/OwH1?=
 =?us-ascii?Q?qkxL1u5m0IStZm5s7dqLbLQKHXWGGnGvUmtkkSokEMYU872JIsKZ7WxbdyUH?=
 =?us-ascii?Q?eA5iYR+HUTJLYCn8I9eGxrzbVyMs+FSo2Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18b0f9a-1b35-4827-b929-08d8c137506c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:19.1378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzFOWxuXvF2mhdXjgmReF4btZV8IjJQAlPs7fOI4LQj5ahAY445FjEEmngSYqzryF2HpMoffbkQYghFfkM2ddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function dcn3x_calculate_wm_and_dlg and
dcn30_calculate_wm_and_dlg_fp require access to FPU operation; for this
reason, this commit moves this function to the fpu directory.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 181 +-----------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   5 -
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../display/dc/fpu_operation/dcn3x_commons.c  | 177 +++++++++++++++++
 .../display/dc/fpu_operation/dcn3x_commons.h  |   3 +
 6 files changed, 183 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index c97533b4ad09..4edebee00095 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1938,185 +1938,6 @@ static noinline bool dcn30_internal_validate_bw(
 	return out;
 }
 
-/*
- * This must be noinline to ensure anything that deals with FP registers
- * is contained within this call; previously our compiling with hard-float
- * would result in fp instructions being emitted outside of the boundaries
- * of the DC_FP_START/END macros, which makes sense as the compiler has no
- * idea about what is wrapped and what is not
- *
- * This is largely just a workaround to avoid breakage introduced with 5.6,
- * ideally all fp-using code should be moved into its own file, only that
- * should be compiled with hard-float, and all code exported from there
- * should be strictly wrapped with DC_FP_START/END
- */
-static noinline void dcn30_calculate_wm_and_dlg_fp(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
-{
-	int i, pipe_idx;
-	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
-	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
-			dm_dram_clock_change_unsupported;
-
-	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
-		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
-
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
-	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
-
-	/* Set B:
-	 * DCFCLK: 1GHz or min required above 1GHz
-	 * FCLK/UCLK: Max
-	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid) {
-		if (vlevel == 0) {
-			pipes[0].clks_cfg.voltage = 1;
-			pipes[0].clks_cfg.dcfclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dcfclk_mhz;
-		}
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.b.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
-
-	/* Set D:
-	 * DCFCLK: Min Required
-	 * FCLK(proportional to UCLK): 1GHz or Max
-	 * MALL stutter, sr_enter_exit = 4, sr_exit = 2us
-	 */
-	/*
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.d.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	*/
-
-	/* Set C:
-	 * DCFCLK: Min Required
-	 * FCLK(proportional to UCLK): 1GHz or Max
-	 * pstate latency overridden to 5us
-	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-		unsigned int min_dram_speed_mts_margin = 160;
-
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
-
-		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
-			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
-
-		for (i = 3; i > 0; i--) {
-			if ((min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts) &&
-					(min_dram_speed_mts - min_dram_speed_mts_margin < dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts))
-				context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
-		}
-
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	if (!pstate_en) {
-		/* The only difference between A and C is p-state latency, if p-state is not supported we want to
-		 * calculate DLG based on dummy p-state latency, and max out the set A p-state watermark
-		 */
-		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
-	} else {
-		/* Set A:
-		 * DCFCLK: Min Required
-		 * FCLK(proportional to UCLK): 1GHz or Max
-		 *
-		 * Set A calculated last so that following calculations are based on Set A
-		 */
-		if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
-			context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
-			context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
-		}
-		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	}
-
-	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
-
-	/* Make set D = set A until set D is enabled */
-	context->bw_ctx.bw.dcn.watermarks.d = context->bw_ctx.bw.dcn.watermarks.a;
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
-		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-		if (dc->config.forced_clocks) {
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
-		}
-		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
-		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
-
-		pipe_idx++;
-	}
-
-	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-
-	if (!pstate_en)
-		/* Restore full p-state latency */
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
-				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
-}
-
-void dcn30_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
-{
-	DC_FP_START();
-	dcn30_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
-	DC_FP_END();
-}
-
 bool dcn30_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -2317,7 +2138,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.link_enc_create = dcn30_link_encoder_create,
 	.panel_cntl_create = dcn30_panel_cntl_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
-	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+	.calculate_wm_and_dlg = dcn3x_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 42960574cce9..694ae4e4e88e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -44,11 +44,6 @@ struct resource_pool *dcn30_create_resource_pool(
 
 bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate);
-void dcn30_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel);
 
 int dcn30_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 8369b009a853..934df194db38 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1625,7 +1625,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.link_enc_create = dcn301_link_encoder_create,
 	.panel_cntl_create = dcn301_panel_cntl_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
-	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+	.calculate_wm_and_dlg = dcn3x_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 0554a3dd3214..539757ec3348 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1235,7 +1235,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.link_enc_create = dcn302_link_encoder_create,
 		.panel_cntl_create = dcn302_panel_cntl_create,
 		.validate_bandwidth = dcn30_validate_bandwidth,
-		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+		.calculate_wm_and_dlg = dcn3x_calculate_wm_and_dlg,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 		.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
index 06e9bd6d4d28..c3b06a8cf765 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
@@ -42,6 +42,7 @@
  *   kernel_fpu_begin/end macros.
  */
 
+#include "clk_mgr.h"
 #include "resource.h"
 #include "dml/dcn30/display_mode_vba_30.h"
 
@@ -213,6 +214,182 @@ static void _dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
 
 }
 
+/*
+ * This must be noinline to ensure anything that deals with FP registers
+ * is contained within this call; previously our compiling with hard-float
+ * would result in fp instructions being emitted outside of the boundaries
+ * of the DC_FP_START/END macros, which makes sense as the compiler has no
+ * idea about what is wrapped and what is not
+ *
+ * This is largely just a workaround to avoid breakage introduced with 5.6,
+ * ideally all fp-using code should be moved into its own file, only that
+ * should be compiled with hard-float, and all code exported from there
+ * should be strictly wrapped with DC_FP_START/END
+ */
+static noinline void _dcn30_calculate_wm_and_dlg_fp(struct dc *dc,
+		struct dc_state *context, display_e2e_pipe_params_st *pipes,
+		int pipe_cnt, int vlevel)
+{
+	int i, pipe_idx;
+	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
+			dm_dram_clock_change_unsupported;
+
+	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
+		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
+
+	pipes[0].clks_cfg.voltage = vlevel;
+	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
+	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
+
+	/* Set B:
+	 * DCFCLK: 1GHz or min required above 1GHz
+	 * FCLK/UCLK: Max
+	 */
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid) {
+		if (vlevel == 0) {
+			pipes[0].clks_cfg.voltage = 1;
+			pipes[0].clks_cfg.dcfclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dcfclk_mhz;
+		}
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us;
+	}
+	context->bw_ctx.bw.dcn.watermarks.b.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	pipes[0].clks_cfg.voltage = vlevel;
+	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
+
+	/* Set D:
+	 * DCFCLK: Min Required
+	 * FCLK(proportional to UCLK): 1GHz or Max
+	 * MALL stutter, sr_enter_exit = 4, sr_exit = 2us
+	 */
+	/*
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us;
+	}
+	context->bw_ctx.bw.dcn.watermarks.d.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	*/
+
+	/* Set C:
+	 * DCFCLK: Min Required
+	 * FCLK(proportional to UCLK): 1GHz or Max
+	 * pstate latency overridden to 5us
+	 */
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
+		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		unsigned int min_dram_speed_mts_margin = 160;
+
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
+
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
+			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
+
+		for (i = 3; i > 0; i--) {
+			if ((min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts) &&
+					(min_dram_speed_mts - min_dram_speed_mts_margin < dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts))
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
+		}
+
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
+	}
+	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	if (!pstate_en) {
+		/* The only difference between A and C is p-state latency, if p-state is not supported we want to
+		 * calculate DLG based on dummy p-state latency, and max out the set A p-state watermark
+		 */
+		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
+	} else {
+		/* Set A:
+		 * DCFCLK: Min Required
+		 * FCLK(proportional to UCLK): 1GHz or Max
+		 *
+		 * Set A calculated last so that following calculations are based on Set A
+		 */
+		if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+			context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
+			context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
+		}
+		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	}
+
+	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
+
+	/* Make set D = set A until set D is enabled */
+	context->bw_ctx.bw.dcn.watermarks.d = context->bw_ctx.bw.dcn.watermarks.a;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
+		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
+		if (dc->config.forced_clocks) {
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
+		}
+		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
+		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
+
+		pipe_idx++;
+	}
+
+	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+
+	if (!pstate_en)
+		/* Restore full p-state latency */
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+}
+
+void dcn3x_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int pipe_cnt,
+				int vlevel)
+{
+	DC_FP_START();
+	_dcn30_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
+	DC_FP_END();
+}
+
 void dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt)
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
index b3b6d8a66c28..7521498bbd3b 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
@@ -32,4 +32,7 @@ void dcn3x_populate_dml_writeback_from_context(struct dc *dc,
 void dcn3x_set_mcif_arb_params(struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes, int pipe_cnt);
 
+void dcn3x_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
+	display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel);
+
 #endif /* _DCN3X_COMMONS_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
