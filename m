Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B55C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEE810E8C5;
	Thu,  6 Oct 2022 21:28:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86F210E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXoWRGtjTFMqUnnQieCREOhGBi9YmCwL+EmfcxooWVJoBdAy/3ACHKrqep14ArLRE34NuEMoYsOVFz0nMk765J9tpqHTE5YpXjWIEcvbQX2ZCjLBs3sA3LSpVEZhV4COg5YsDGZNeXNXbGnk8ujbHORGHx7jR4gZn49a7o/EJ+qpmgEfHwRnan/iBY1Fo/Jt6hYi2Y7LH54g0E1oMCqoEoxqM7yUfGFGp7Qkj3yjd2aY69O2Qi3aq2cnRzvBF/Z4w3N8f33ZXMLm10W2bpRspv1TCxIGrX/pSmWwQbo30gtAA/Lkwj1ZhTZDXXvVJ3n1R2pgRAXpW6AClivTseHq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC0Jjh/72roUZ/EO1x2pk0h29wSsrl/NSFdqNedP948=;
 b=fF9J0XRGqufhNnMmzURJVSE+F4FDDRE75m3JgPGDVu9xPJWFegmlvjEMIN6q4iaLel7bpnTKZflTqdmzIJuTKnUt0nvdY5TATjz1j9eqnvga844xi43IwBnN5dcyEC6JQQfbnPaSGRDIkZxAO9kghH0gQZcIPqgGhMhFRdAXqdT7kvMZTTy+X7rKgHKfIK1SAaaT83GZS6WSumlmjV3ZDPtHyQjurNYqLJgvvbcfUX+ENr4CQL9HMrakgtYwmxEp01Pg44evEA0tujGXhWr/zNssIxSOZwmYx81jQV8uVpOf72rrml88sYMHgu9sy6ElLITAVkXrcvHk22Ov9TilVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC0Jjh/72roUZ/EO1x2pk0h29wSsrl/NSFdqNedP948=;
 b=ZZcrB0Ekj0uV1a4P0ff1wOqQP2b/PZlEtYLUakFZ4xvrUjIzJvfNI1FuQGVIP0GmaVDLi2ib06NYf6Z/7Qxzw81SziBLiFiPWrn3Pq329cgGldp89G8oC7jwaSR5FqxZmAbPMsAV9y+XcHn0YDlQTGbcX8Cc4LPLH9x1dA1tY9s=
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 21:27:56 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::6d) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:56 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:54 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/23] drm/amd/display: Remove wrong pipe control lock
Date: Thu, 6 Oct 2022 17:26:48 -0400
Message-ID: <20221006212650.561923-22-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|BN9PR12MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: e495bd8d-97e4-401b-ae7d-08daa7e1a2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLAwv5cH+vmelr9eTUtNveisUCJjPEDp17k/pU9EB8gZl1WYC76GqXY3Ai30S7z6cNTBBZjqAFYKzH5P5+d+2iyJF86yaCYggPNK+QNsK/dTQ5RL5vLFFQnFOag0eOzGuK5BUL7+9uQPpQO7weWX+0aIWFQQ6hpbxt5tm79IlspWuxOhqpT45lkcPPjaQlXYGMdFDT9BWSiLO6/0PP5aYSN/HeAV5iW7srQjNrKAPA27cn/KAuip2AU+ZWsgjj8ZeugI1hSsiJxCE7WfFwpa43C45fyxxibTX8yviTZ2boIs17ogM7OWD3zsR/IZ71PlRRE6MMPirw5vUiju8biPLS5+OlUpw8rhMx8SU3XGcdpFI99EFydnWXC2fo9J7ZJMwGAt6eLcY730B+eYfAqRxYS0kL0SsMKOQdjKUpq2R1qc11M6R22S184L8bTucCaJBLLy79g5Frmct+cUfOQD4pW3dazhR+zel7GU0PNTqI0EjOjZKfdAriD1N+yY4fKPJ8hjj7cZw6FNClYij/QL4UF5Eluj0Ihbb/Fo0bYsodbv5mcg2NffvSR0sD/1omyuDa0YUaqNb9svLXphXhXR5msF+qGx57zVL3SIfi73GuMcu0dc8K4Y30Zu6E0FBOFVs6fsJVTkJpjq9whn7MuGmCXeXTKD8g6gDFlJaTcsl8NmHHEuG+dPSjg1+lmIYYhB2NCfI0rIq2tSdzlumNcQrAKAG3WIgPIhnQlbobyZ2tLjbzTKhEfNQa70dntBC4eMp1aO+j0SUvEO74S0UIA3Fh8ZWaTOZCB4hJ7VPNOWtvcxJfBZC5nr2gNF45pCXx+r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82310400005)(82740400003)(36860700001)(83380400001)(16526019)(336012)(426003)(186003)(47076005)(81166007)(356005)(1076003)(40460700003)(26005)(2906002)(2616005)(478600001)(44832011)(6916009)(316002)(41300700001)(5660300002)(4326008)(70206006)(8936002)(6666004)(54906003)(70586007)(8676002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:56.5541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e495bd8d-97e4-401b-ae7d-08daa7e1a2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

When using a device based on DCN32/321,
we have an issue where a second
4k@60Hz display does not light up,
and the system becomes unresponsive
for a few minutes. In the debug process,
it was possible to see a hang
in the function dcn20_post_unlock_program_front_end
in this part:

for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
	&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
	mdelay(1);
}

The hubp_is_flip_pending always returns positive
for waiting pending flips which is a symptom of
pipe hang. Additionally, the dmesg log shows
this message after a few minutes:

  BUG: soft lockup - CPU#4 stuck for 26s!
  ...
  [  +0.000003]  dcn20_post_unlock_program_front_end+0x112/0x340 [amdgpu]
  [  +0.000171]  dc_commit_state_no_check+0x63d/0xbf0 [amdgpu]
  [  +0.000155]  ? dc_validate_global_state+0x358/0x3d0 [amdgpu]
  [  +0.000154]  dc_commit_state+0xe2/0xf0 [amdgpu]

This confirmed the hypothesis that we had a pipe
hanging somewhere. Next, after checking the
ftrace entries, we have the below weird
sequence:

 [..]
  2)               |        dcn10_lock_all_pipes [amdgpu]() {
  2)   0.120 us    |          optc1_is_tg_enabled [amdgpu]();
  2)               |          dcn20_pipe_control_lock [amdgpu]() {
  2)               |            dc_dmub_srv_clear_inbox0_ack [amdgpu]() {
  2)   0.121 us    |              amdgpu_dm_dmub_reg_write [amdgpu]();
  2)   0.551 us    |            }
  2)               |            dc_dmub_srv_send_inbox0_cmd [amdgpu]() {
  2)   0.110 us    |              amdgpu_dm_dmub_reg_write [amdgpu]();
  2)   0.511 us    |            }
  2)               |            dc_dmub_srv_wait_for_inbox0_ack [amdgpu]() {
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
  2)   0.110 us    |              amdgpu_dm_dmub_reg_read [amdgpu]();
 [..]

We are not expected to read from dmub register
so many times and for so long. From the trace log,
it was possible to identify that the function
dcn20_pipe_control_lock was triggering the dmub
operation when it was unnecessary and causing
the hang issue. This commit drops the unnecessary
dmub code and, consequently, fixes the second display not
lighting up the issue.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index d732b6f031a1..a7e0001a8f46 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1270,16 +1270,6 @@ void dcn20_pipe_control_lock(
 					lock,
 					&hw_locks,
 					&inst_flags);
-	} else if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
-		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
-		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
-		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
-		hw_lock_cmd.bits.lock_pipe = 1;
-		hw_lock_cmd.bits.otg_inst = pipe->stream_res.tg->inst;
-		hw_lock_cmd.bits.lock = lock;
-		if (!lock)
-			hw_lock_cmd.bits.should_release = 1;
-		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
 	} else if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
 		if (lock)
 			pipe->stream_res.tg->funcs->triplebuffer_lock(pipe->stream_res.tg);
@@ -1856,7 +1846,7 @@ void dcn20_post_unlock_program_front_end(
 
 			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
 					&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
-				mdelay(1);
+				udelay(1);
 		}
 	}
 
-- 
2.25.1

