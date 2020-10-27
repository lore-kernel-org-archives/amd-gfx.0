Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE51C55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0FE218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d76AEJtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0FE218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6146EC55;
	Tue, 27 Oct 2020 20:52:57 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E9B6EC51
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPKhGd2lphihQTHuzgUr5LZS//lw5SWHDVb0BeTgLdc16h8mS0zSxXIt+Ia7SV0v8Cj4vq1KAi5eGSwcpFUDL80BJNFO3z3JLrd0Ng8IBUn5AX87nJMGdzIRAS0VC6duDlVmlz14fKCTSX1G+btMmCNQQJDw6ncQ14IEHMhG0D+/rgLL0iJDpUex7AhWTMMnamfblnIjrp0FqO9gjzT84Zf8zbEnM6Okrd0PeoFtfTUoWm5/CSJ/YqJzuIRoucSQbJYbNM8FWPgMy9PLhQZN6Vov38szZz4OvrTJp6vJxzECy0mlx9aCagqhG4c6YncSJ2xbU8+z7vTl7IWrSKn7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlgtI8No7IEhnKf+mdxqnQzhiSncTNbNIoFxnxk5BDo=;
 b=Radht2ApfCkewkyNET8H4mWmt47xem1VgvSvJHc5Hnd911qiqo27IeEr0U9E9mOmRuQ9XVpNp4XKs9yQkFwTMzcl+MuYSToE854nEFtYvyX8kBb8C4k8R/0lhAwEnRVm7BZiDflW9RXSZ7DrX2KJ8tIBHnMLmL7BJHEtqfO7fId5A8pv/o13ydbBYlJMB3FNGm/WU8H2hN2Fv9LEyZ+dgG3kZwY7ytkQAkT8o2lzPh97YYZOIf2x6Q13IC5wi8SXKbfIMZJvdcicuGakcm/sJoz/Q9GxzDqYwkphfmvrcit87waLK8xcnh3EfZPpQF86BpQEzNlO1MVps8vT6E7bmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlgtI8No7IEhnKf+mdxqnQzhiSncTNbNIoFxnxk5BDo=;
 b=d76AEJtbbxJg/nuGLdlUD+xoo/IROPOZl+aNYsyjEQqeEvy2M1/HEpDFAwa9/12tCsvdyGjH3y4HRoHWDLEj3WzvNPgguJFtBKHx/tz06iRnSi8XjJ/mrCdOZD+T6xSuSCIx/sLk31DVLxOxVYurehUoVIcxRC1Fb1OyzShceFc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:51 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:51 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/25] drm/amd/display: Add MPC memory shutdown support for
 DCN3
Date: Tue, 27 Oct 2020 16:52:11 -0400
Message-Id: <20201027205234.8239-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d29a25a3-8281-4730-4439-08d87aba420f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359521AC8070F0DC43C828AEFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEYhwx5o2A8ZAL971D/AFEh7j89bN4UUfapyz02QgOuMzT0sterYFslfFi67Vfe3pYCQOGqvQ+Q9tah5+P5nW3wl4cnFoO/Wawu77wun50+JtgNgxmnZBbGTjOf1Jy3wyCS4Lo4p4jYQZOSgqVfkUI7adSC5bmh6TV2AcmdaJV0DNiZ1xV5UrLYLdR3BOPxrdun+HDIx5q9xr2UUvPRylwgtjoeA29NvTv8dUtaLU73wnsZbZCJPBbtEm9n+TcyloDeJLcYYURhZ7Cd8yAyWSP5822SkuyeqAYv6zvq0tKQLFceM+JukbnM6rjgeFMEn23f8S7jyPCUE9vfy9e4oj/EfAKaRoqSQX+8acLkC31maymewedm/Wq5s2BWivR37
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gbSAm9px/EmBi6Is51hIRP3ipYCHAtWa+Y2a3UntUp3MqPLOgqINys54M2F0isny8YJBhuA/Q2o3TIjlaymeCw2DM3ngFKg4iCzkAg4sQQmQszdSZEp/Icnl5Gzeq24nZZ+jRYgfrcRV/01J3aB21pC4N6W9eqT958zkHk44WBdUa4kq5/B4cOfV+6hVcEZBnwTWSyPLW4pyJHmbd1BGQcUwu9jMaS/ikI7XHgwysJpNF4snzq77ZwQPvpzCL0FN14TaL6nHJekCEGjNyn3LxHgAWyn1XBDbgYtoqvuenNhMOSAuWxq1tMCrbFk8H5QdAm7XnFG92bWD2ldiA6I8M80LcMWXgB9QI7lpc1DRGYglIsnqmdyYwgQxCHtLCNljE400KtkdC2Z9n/DYqB6PpKnvpow1Cz5fo6DyoYwbo4pMvJAEBi1C3El0/3019fIkEDtX0G5ssP7KPkJg3EUhNy4bUmvNT6MZahDE+zSKuRZ/XRhhibTOESpylgDAAQIiMmW/jBM+ToffFPiDsot2Q3r/mUF3I2TbRe1BDb4VRryUKRKkLaa83B7tOSfyLJbs/d3+xy3/clOvjs4iVlFTxIlTy2cxzjOmlGvibWeYOmH4/zR6ma7e0dDbKlKzGT5gW8F1kx/a84d4YPLZ/IgkUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29a25a3-8281-4730-4439-08d87aba420f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:46.5696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3NAm5UBJ/vpUMuAmxbsTW/GvbJSWIv+j3Lx/B6lNfGjgsTloAiCp4ARiMjDjw4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Jacky Liao <ziyu.liao@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The MPC memory blocks in DCN3 should be powered down completely when
they are not in use. This will reduce power consumption.

[How]
This commits changes behaviour for dcn3 and does the following:
1. Write to MPC_RMU<X>_LOW_PWR_MODE and MPCC_OGAM_MEM_LOW_PWR_MODE to
   automatically shut down memory when not in use
2. mpc3_power_on_shaper_3dlut and mpc3_power_on_ogam_lut are called
   to disable force power on when configuration finishes
3. Added a debug option to allow this behaviour to be turned off

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  | 56 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |  9 +++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b7f53908ebea..c74be6dafafc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -506,6 +506,7 @@ struct dc_debug_options {
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
 	bool force_ignore_link_settings;
+	bool enable_mpc_mem_powerdown: 1;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 8fadd61a55ec..1671688557f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -143,8 +143,16 @@ static void mpc3_power_on_ogam_lut(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-	REG_SET(MPCC_MEM_PWR_CTRL[mpcc_id], 0,
-			MPCC_OGAM_MEM_PWR_FORCE, power_on == true ? 0:1);
+	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+		// Force power on
+		REG_UPDATE(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_PWR_DIS, power_on == true ? 1:0);
+		// Wait for confirmation when powering on
+		if (power_on)
+			REG_WAIT(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_PWR_STATE, 0, 10, 10);
+	} else {
+		REG_SET(MPCC_MEM_PWR_CTRL[mpcc_id], 0,
+				MPCC_OGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
+	}
 }
 
 static void mpc3_configure_ogam_lut(
@@ -360,6 +368,9 @@ void mpc3_set_output_gamma(
 	/*we need to program 2 fields here as apposed to 1*/
 	REG_UPDATE(MPCC_OGAM_CONTROL[mpcc_id],
 			MPCC_OGAM_SELECT, next_mode == LUT_RAM_A ? 0:1);
+
+	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown)
+		mpc3_power_on_ogam_lut(mpc, mpcc_id, false);
 }
 
 void mpc3_set_denorm(
@@ -801,16 +812,28 @@ static void mpc3_power_on_shaper_3dlut(
 	uint32_t power_status_shaper = 2;
 	uint32_t power_status_3dlut  = 2;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	int max_retries = 10;
 
 	if (rmu_idx == 0) {
 		REG_SET(MPC_RMU_MEM_PWR_CTRL, 0,
 			MPC_RMU0_MEM_PWR_DIS, power_on == true ? 1:0);
+		/* wait for memory to fully power up */
+		if (power_on && mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
+			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
+		}
+
 		/*read status is not mandatory, it is just for debugging*/
 		REG_GET(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_SHAPER_MEM_PWR_STATE, &power_status_shaper);
 		REG_GET(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_3DLUT_MEM_PWR_STATE, &power_status_3dlut);
 	} else if (rmu_idx == 1) {
 		REG_SET(MPC_RMU_MEM_PWR_CTRL, 0,
 			MPC_RMU1_MEM_PWR_DIS, power_on == true ? 1:0);
+		if (power_on && mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
+			REG_WAIT(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
+		}
+
 		REG_GET(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_SHAPER_MEM_PWR_STATE, &power_status_shaper);
 		REG_GET(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_3DLUT_MEM_PWR_STATE, &power_status_3dlut);
 	}
@@ -838,6 +861,10 @@ bool mpc3_program_shaper(
 		REG_SET(SHAPER_CONTROL[rmu_idx], 0, MPC_RMU_SHAPER_LUT_MODE, 0);
 		return false;
 	}
+
+	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown)
+		mpc3_power_on_shaper_3dlut(mpc, rmu_idx, true);
+
 	current_mode = mpc3_get_shaper_current(mpc, rmu_idx);
 
 	if (current_mode == LUT_BYPASS || current_mode == LUT_RAM_A)
@@ -1196,6 +1223,9 @@ bool mpc3_program_3dlut(
 	mpc3_set_3dlut_mode(mpc, mode, is_12bits_color_channel,
 					is_17x17x17, rmu_idx);
 
+	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown)
+		mpc3_power_on_shaper_3dlut(mpc, rmu_idx, false);
+
 	return true;
 }
 
@@ -1349,11 +1379,31 @@ int mpcc3_release_rmu(struct mpc *mpc, int mpcc_id)
 
 }
 
+static void mpc3_mpc_init(struct mpc *mpc)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	int mpcc_id;
+
+	mpc1_mpc_init(mpc);
+
+	if (mpc->ctx->dc->debug.enable_mpc_mem_powerdown) {
+		if (mpc30->mpc_mask->MPC_RMU0_MEM_LOW_PWR_MODE && mpc30->mpc_mask->MPC_RMU1_MEM_LOW_PWR_MODE) {
+			REG_UPDATE(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_MEM_LOW_PWR_MODE, 3);
+			REG_UPDATE(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_MEM_LOW_PWR_MODE, 3);
+		}
+
+		if (mpc30->mpc_mask->MPCC_OGAM_MEM_LOW_PWR_MODE) {
+			for (mpcc_id = 0; mpcc_id < mpc30->num_mpcc; mpcc_id++)
+				REG_UPDATE(MPCC_MEM_PWR_CTRL[mpcc_id], MPCC_OGAM_MEM_LOW_PWR_MODE, 3);
+		}
+	}
+}
+
 const struct mpc_funcs dcn30_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
-	.mpc_init = mpc1_mpc_init,
+	.mpc_init = mpc3_mpc_init,
 	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
 	.cursor_lock = mpc1_cursor_lock,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index dfd3b9713df6..d1fd0b9aa0f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -300,6 +300,7 @@
 	SF(MPCC0_MPCC_STATUS, MPCC_DISABLED, mask_sh),\
 	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_PWR_FORCE, mask_sh),\
 	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_PWR_DIS, mask_sh),\
+	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_PWR_STATE, mask_sh),\
 	SF(MPC_OUT0_DENORM_CONTROL, MPC_OUT_DENORM_MODE, mask_sh),\
 	SF(MPC_OUT0_DENORM_CONTROL, MPC_OUT_DENORM_CLAMP_MAX_R_CR, mask_sh),\
 	SF(MPC_OUT0_DENORM_CONTROL, MPC_OUT_DENORM_CLAMP_MIN_R_CR, mask_sh),\
@@ -406,6 +407,8 @@
 	SF(MPCC0_MPCC_STATUS, MPCC_DISABLED, mask_sh),\
 	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_PWR_FORCE, mask_sh),\
 	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_PWR_DIS, mask_sh),\
+	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_LOW_PWR_MODE, mask_sh),\
+	SF(MPCC0_MPCC_MEM_PWR_CTRL, MPCC_OGAM_MEM_PWR_STATE, mask_sh),\
 	SF(MPC_OUT0_DENORM_CONTROL, MPC_OUT_DENORM_MODE, mask_sh),\
 	SF(MPC_OUT0_DENORM_CONTROL, MPC_OUT_DENORM_CLAMP_MAX_R_CR, mask_sh),\
 	SF(MPC_OUT0_DENORM_CONTROL, MPC_OUT_DENORM_CLAMP_MIN_R_CR, mask_sh),\
@@ -492,10 +495,12 @@
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_MEM_PWR_DIS, mask_sh),\
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_SHAPER_MEM_PWR_STATE, mask_sh),\
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_3DLUT_MEM_PWR_STATE, mask_sh),\
+	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_MEM_LOW_PWR_MODE, mask_sh),\
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_MEM_PWR_FORCE, mask_sh),\
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_MEM_PWR_DIS, mask_sh),\
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_SHAPER_MEM_PWR_STATE, mask_sh),\
 	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_3DLUT_MEM_PWR_STATE, mask_sh),\
+	SF(MPC_RMU_MEM_PWR_CTRL, MPC_RMU1_MEM_LOW_PWR_MODE, mask_sh),\
 	SF(MPC_RMU0_SHAPER_CONTROL, MPC_RMU_SHAPER_MODE_CURRENT, mask_sh),\
 	SF(CUR_VUPDATE_LOCK_SET0, CUR_VUPDATE_LOCK_SET, mask_sh)
 
@@ -519,10 +524,12 @@
 	type MPC_RMU1_MUX_STATUS; \
 	type MPC_RMU0_MEM_PWR_FORCE;\
 	type MPC_RMU0_MEM_PWR_DIS;\
+	type MPC_RMU0_MEM_LOW_PWR_MODE;\
 	type MPC_RMU0_SHAPER_MEM_PWR_STATE;\
 	type MPC_RMU0_3DLUT_MEM_PWR_STATE;\
 	type MPC_RMU1_MEM_PWR_FORCE;\
 	type MPC_RMU1_MEM_PWR_DIS;\
+	type MPC_RMU1_MEM_LOW_PWR_MODE;\
 	type MPC_RMU1_SHAPER_MEM_PWR_STATE;\
 	type MPC_RMU1_3DLUT_MEM_PWR_STATE;\
 	type MPCC_OGAM_RAMA_EXP_REGION_START_SLOPE_B; \
@@ -541,6 +548,8 @@
 	type MPCC_OGAM_LUT_CONFIG_MODE; \
 	type MPCC_OGAM_LUT_STATUS; \
 	type MPCC_OGAM_RAMA_START_BASE_CNTL_B;\
+	type MPCC_OGAM_MEM_LOW_PWR_MODE;\
+	type MPCC_OGAM_MEM_PWR_STATE;\
 	type MPC_RMU_3DLUT_MODE; \
 	type MPC_RMU_3DLUT_SIZE; \
 	type MPC_RMU_3DLUT_MODE_CURRENT; \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
