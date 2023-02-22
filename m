Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E072C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A928F10E3D9;
	Wed, 22 Feb 2023 06:41:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E77310E3D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhjyPM9oxrecRANl1jI4HWlc8S9gngATNxCx6jzZBy4LQ2wWt2Dju8cux1z7taaVGBxTHGG9yykh26gtLg6cmt6hvLg49uueT1wzEJqzrI32ZrySWjgBeRYgD613F7kqNccLcHNau7GoCe3JwdGaX+j2U4WAcfiw9Mku9Q8WuF7ch/qRk3yyJZ7R3C8XudwMmRpu1sZMky3zx4hFQT8UEytjcXh90sNFIS710/bULG+wAnFmL+UTbeTQPUZPgFgdIz7Fh5jeWOlv7bMBtGCpUqUZhF4CS4pt5HbQR9jUV0YLsHab58agk53bA6QQMKzlXmGoZYyBhHokJGx366BpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49A7Za/2ELqNKAuoWWcHFKjetNahc0Ux070efiK6n3I=;
 b=lgoF4UdS8fERpAo1D4Oekh3pM5V3d0ieqHDWNPzVmGjnWOfPe8JBYJV/EymQZAxN5MHrvIXw/Lnq01Z4hRRd1UdiKGdioQ8KuMMfJAPulo2GHFHjWwadgjTssnE36O0ro7T9+9/veYLvqO4WCGfM5BZ7GtYZvr74afA35RhSQaSx5MoJ8Kvq+A2xGPQp+DsoXr4q9GtXwQqgJPI7hJvUgguSlUeMfrFyxdRQ6jsARXmrp7lkPRVfVElOY3cCR0pAgFXC8aLtdIBxnOLvxmZBhso6rifR7HjWRWRAr2FoQq3KBdXE395gsH4KYpVbbdZxzcRRUq1icLKKmLM9g4iyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49A7Za/2ELqNKAuoWWcHFKjetNahc0Ux070efiK6n3I=;
 b=x+4RPnT2Cu1UHR+1lLcleE5I6OR0s77KXaaoyk1D8X7beqSgZVne1AHVcnihHGIFMzxozVCzBWSp21g4XCCi69mgXM8Pqy3Ql4xW2GQB133Pw5lJbv38pT2MIDAkr7F/+F4/NPYPPYPYutUBjs8a3RpYg+RDMGGdKygVE5LEBDo=
Received: from DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Wed, 22 Feb 2023 06:41:29 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::fa) by DM6PR13CA0014.outlook.office365.com
 (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:28 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:21 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/20] drm/amd/display: Reduce CPU busy-waiting for long delays
Date: Wed, 22 Feb 2023 01:40:24 -0500
Message-ID: <20230222064041.2824-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 44db0d80-2726-4a23-d1bd-08db149fd3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KAUr5A2nALp5Rsi0Vj0vwBAKlpFrXldqnKeC8BvVQySm021qTN5PVb4puGYMtPb3bjoJpOkDOClulPLyHzRbvFJSk8XcoXMJkUrRkodlSQfjXRNZsWzEXAJnajlO2S48PpMqLa0yXx+M9vkTLXJss7oAzQ7hxiQNFBAh6g3rVKXgHe8XIyAfW/tLSZ7Sqh85wpX+c0GVXxK4CtTX4TBOw+xcUZgWkaw6GBfyDVTUPBJyuK22fFHHQXNwvMwg93COMFOLAvW4nBXLHV6YeYtWF0FZXVRug76TA9KiLrZWln7ltOaXPT4A4MhGjkaKs38OyPl/KE5ktSdKEILqJDIZkkpWCgC4pk4LQeY1uwCpeM91XfbGEho0MtpULVMVbyvzM+Rze6zIHbu1m0IuDN8xbfdk2dviVpIPRwoVkyZH+B4kF6eUH8okBYco3/8ROK4qKLQGu2wNIAQEAtG3h5DU5VpZy/BOaJsup70mADg7RVTPw8fzdmpz747/191VL9FeVIXA4Sgi89FlBYkds9KOyHOcbhRx1i/v5lP1cuRrdvbEaHngOUXkwVFkdtXWqmSGw9RcMgNq1ULaORa93M2SpotAOjtngSVnURKWudmuzJAVLB2MQBLC3ARV1A/dpPy9nTn7xM1nTKxi2od9pg/7tIOSzJ8sMpZHwOtsjznRCutNaW5YWG1YPNA7mnN0e3KVUdRT+OU8V8vzRRjQiENQ8oQmZcpdbFkgXcoqLnwR9g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(2616005)(36860700001)(5660300002)(336012)(1076003)(16526019)(26005)(186003)(54906003)(426003)(47076005)(478600001)(316002)(83380400001)(356005)(6916009)(4326008)(40460700003)(8676002)(41300700001)(8936002)(40480700001)(70586007)(70206006)(36756003)(44832011)(81166007)(82310400005)(86362001)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:28.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44db0d80-2726-4a23-d1bd-08db149fd3b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[WHY]
udelay should not be used for long waits since it keeps CPU active,
wasting power.

[HOW]
Use fsleep where acceptable to allow CPU cores to be parked by the scheduler.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c             | 9 ++-------
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 4 ++--
 .../amd/display/dc/link/protocols/link_dp_capability.c   | 8 ++++----
 .../drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c  | 2 +-
 .../drm/amd/display/dc/link/protocols/link_dp_training.c | 7 ++-----
 .../display/dc/link/protocols/link_dp_training_dpia.c    | 2 +-
 .../display/dc/link/protocols/link_edp_panel_control.c   | 4 ++--
 9 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 140297c8ff55..739298d2dff3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -832,13 +832,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 									LOG_FLAG_I2cAux_DceAux,
 									"dce_aux_transfer_with_retries: payload->defer_delay=%u",
 									payload->defer_delay);
-						if (payload->defer_delay > 1) {
-							msleep(payload->defer_delay);
-							defer_time_in_ms += payload->defer_delay;
-						} else if (payload->defer_delay <= 1) {
-							udelay(payload->defer_delay * 1000);
-							defer_time_in_ms += payload->defer_delay;
-						}
+						fsleep(payload->defer_delay * 1000);
+						defer_time_in_ms += payload->defer_delay;
 					}
 				}
 				break;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index d3cc5ec46956..e74266cc0098 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -586,7 +586,7 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 				if (state == PSR_STATE0)
 					break;
 			}
-			udelay(500);
+			fsleep(500);
 		}
 
 		/* assert if max retry hit */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 1e2d2cbe2c37..19440bdf6344 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -215,7 +215,7 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8
 					break;
 			}
 
-			udelay(500);
+			fsleep(500);
 		}
 
 		/* assert if max retry hit */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 257e1c3ba00a..180c92a9f117 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1153,7 +1153,7 @@ static bool poll_for_allocation_change_trigger(struct dc_link *link)
 			break;
 		}
 
-		msleep(5);
+		fsleep(5000);
 	}
 
 	if (result == ACT_FAILED) {
@@ -1640,7 +1640,7 @@ static bool write_128b_132b_sst_payload_allocation_table(
 			}
 		}
 		retries++;
-		msleep(5);
+		fsleep(5000);
 	}
 
 	if (!result && retries == max_retries) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d4370856f164..0f2c59807079 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1005,7 +1005,7 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
 		 * signal and may need up to 1 ms before being able to reply.
 		 */
 		if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3) {
-			udelay(1000);
+			fsleep(1000);
 			aux_channel_retry_cnt++;
 		}
 	}
@@ -2121,7 +2121,7 @@ static bool dp_verify_link_cap(
 
 		if (status == LINK_TRAINING_SUCCESS) {
 			success = true;
-			udelay(1000);
+			fsleep(1000);
 			if (dc_link_dp_read_hpd_rx_irq_data(link, &irq_data) == DC_OK &&
 					dc_link_check_link_loss_status(
 							link,
@@ -2171,7 +2171,7 @@ bool dp_verify_link_cap_with_retries(
 			success = true;
 			break;
 		}
-		msleep(10);
+		fsleep(10 * 1000);
 	}
 
 	dp_trace_lt_fail_count_update(link, fail_count, true);
@@ -2231,7 +2231,7 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 		gpio_result = dal_gpio_get_value(ddc->pin_clock, &clock_pin);
 		ASSERT(gpio_result == GPIO_RESULT_OK);
 		if (clock_pin)
-			udelay(1000);
+			fsleep(1000);
 		else
 			break;
 	} while (retry++ < 3);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index f69e681b3b5b..fcb82bb855ed 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -424,7 +424,7 @@ int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *li
 				timeout--;
 			else
 				break;
-			udelay(10 * 1000);
+			fsleep(10 * 1000);
 		} while (!get_cm_response_ready_flag(link));
 
 		if (!timeout)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index b48d4d822991..5e613ea2cd3f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -258,10 +258,7 @@ void dp_wait_for_training_aux_rd_interval(
 	struct dc_link *link,
 	uint32_t wait_in_micro_secs)
 {
-	if (wait_in_micro_secs > 1000)
-		msleep(wait_in_micro_secs/1000);
-	else
-		udelay(wait_in_micro_secs);
+	fsleep(wait_in_micro_secs);
 
 	DC_LOG_HW_LINK_TRAINING("%s:\n wait = %d\n",
 		__func__,
@@ -970,7 +967,7 @@ static void dpcd_exit_training_mode(struct dc_link *link, enum dp_link_encoding
 			if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
 					(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
 				break;
-			udelay(1000);
+			fsleep(1000);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index e60da0532c53..9715fa754d56 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -1035,7 +1035,7 @@ enum link_training_result dc_link_dpia_perform_link_training(
 	 * falling back to lower bandwidth settings possible.
 	 */
 	if (result == LINK_TRAINING_SUCCESS) {
-		msleep(5);
+		fsleep(5000);
 		if (!link->is_automated)
 			result = dp_check_link_loss_status(link, &lt_settings);
 	} else if (result == LINK_TRAINING_ABORT)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 97e02b5b21ae..da7f83835f78 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -325,7 +325,7 @@ bool dc_link_wait_for_t12(struct dc_link *link)
 void link_edp_add_delay_for_T9(struct dc_link *link)
 {
 	if (link && link->panel_config.pps.extra_delay_backlight_off > 0)
-		udelay(link->panel_config.pps.extra_delay_backlight_off * 1000);
+		fsleep(link->panel_config.pps.extra_delay_backlight_off * 1000);
 }
 
 bool link_edp_receiver_ready_T9(struct dc_link *link)
@@ -383,7 +383,7 @@ bool link_edp_receiver_ready_T7(struct dc_link *link)
 	}
 
 	if (link && link->panel_config.pps.extra_t7_ms > 0)
-		udelay(link->panel_config.pps.extra_t7_ms * 1000);
+		fsleep(link->panel_config.pps.extra_t7_ms * 1000);
 
 	return result;
 }
-- 
2.34.1

