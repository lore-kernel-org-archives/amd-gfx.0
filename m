Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BBDC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C99210ED5D;
	Thu, 20 Apr 2023 23:50:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B872A10ED55
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DllfIoymsYvudxhP1bEy8FQEaUJXunrZBCtgLXyuKUghdNjzvbo/tdVlRxdH+hae7EbYMrkpBBpoiBXiz9xIPeZBhyUE6Ten1spbQ84dhtucKZI5l0L3vxO71qaubNZwnqslpQf23E8JHY31ouj/EG0ANlAB2B9q0MkaCH1rw+xeXgy4CyoFlEowQEhzWAMgS4mYqadcAJwpH+jyFXeY5HkvFWqIYdnkBgIr366Bf4786Oju++kIaAYKC8ywHza74iBPyVdbJt+LzbP4+2ZfjatA2G9qE/0yr6Nr/wz7aYguYeE2XpMl5iTdBcdbx9rk0V8ZdQ5+dgiOl4F1T7kX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cTvsSfrYBOhKoNRKeqagzMvCvzzSoua+sDfxxpssmA=;
 b=D2sUS1Nn7+jdT1M2bozjSgal29EeIQP8gt0k2Mgk1dNNqceMfmLHLMIt9mYuRS53TPyuApwfbL7iwAxIMPAUGH3cgk/z7HlXAIXRkZIR554oe8OM/bGmzq/8haEIIi81zG2CW8l++srpIKHC2dIvbO3TF4h6o/N0NQ6ncjaSSa0Gl6yw6x3BPBQaa1d27xsWilkg3FRRBWN7TU1YAlpn03z4Aie7Rwo1hQn92p8h6nWBB5/DRJqLA15bFKn1UWUNRlyvKIH+z1vkMfuDdUeO9tDNrXW8vVeS6ibxdS/ImhA+/ogtlJoW8w0CB/aQU+mblKqdZwKmZskAh/DvCpi1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cTvsSfrYBOhKoNRKeqagzMvCvzzSoua+sDfxxpssmA=;
 b=nwG4C7k23kNofzjVGGrA0QxFXibxqzu8QJ15un/FTPPQ+Z10t3UsN6q5idiQ6WmcfdcU9OqfST5bTOmvy33tx84f10MJp6zK3ArmVaNvC61ArN1RQOK0T31cZknvd19P+YfodgxTE5C0OQeeRMRBQK7faCLrnleppTtD9uWnwbg=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Thu, 20 Apr 2023 23:50:41 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::b1) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amd/display: Add p-state debugging
Date: Thu, 20 Apr 2023 17:49:48 -0600
Message-ID: <20230420234951.1772270-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|SA0PR12MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2143fd-84ff-4a20-9670-08db41fa0c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KM+a2ZRD/z7WTJaDejvCK7+3Yw7Yfu2qMgxUivNZJMmwa2MRkAmruj+2Ed41B2CZQbxurdkuF8fdL81uJm0jr5Y9AasQpYOhK+8fEZFW905zTKKSULv3QX4Cpn3vaDZaQQXOTQFrLszcN8V+TD56pj0zJShm5i/Cnv4XdyHjAzGHpxbfIEBfHYjwUs706WZEs+xxiJfjIaDvGQU1I8+8S/B8U69OwkoiAcYf8GVI5P3ckWkFjPStkHB2q2AqDruCPKI62mPypOIZX4ytwXBGftHZOE7HFLciXHNic9EgTaoo2uXd0mAnNLzkUR4SeyHCre7tglfiv2InK+o0dBpF8tUTM5ZAEwQhegkmBwhypshCWxKLgI7YA0a0bYoxDp8EDRWL3KIv3hn7TZ9BNzdxBwZpzxp6qxHfMW8p1Ain8thTf91BFaB0KtA/yHzGl+tmqbe3bb3aNl7m1fN3unMoJx8FmiU8UGGeDpy/n45Va+ybeD8+380UKFe2mavRG/Br6Z4FXztHeWDzY90iEMvWWDYC1sIUuR643JNuK03afsqlMI2AGwIjoTmhHQDeUUS+XZTMui0lZgq7LPnFRNAy/glXXhf3QS+wtkj0GlPBSZgCuHQnv8FVj25eitzq5jjP8pFsSml6XQOsSUW8O9b3lvheTGrrTFovbTPHv42khw5izjxTy0tn7ufbor/zxARu83FjaW2TiBmxilUVnVM3ffMtM3YHwYG4JzFsAgqTEE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(81166007)(40460700003)(70206006)(316002)(4326008)(6916009)(70586007)(478600001)(82740400003)(8936002)(8676002)(54906003)(356005)(41300700001)(336012)(36860700001)(426003)(83380400001)(16526019)(2616005)(6666004)(47076005)(186003)(1076003)(26005)(36756003)(82310400005)(86362001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:41.1297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2143fd-84ff-4a20-9670-08db41fa0c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Sung Lee <sunglee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sunglee@amd.com>

[WHY]
P-State related issues are fairly common but currently
there is no way to debug these issues after the fact.

[HOW]
Add helpful registers to HW state queries

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sung Lee <sunglee@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h    | 1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h         | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c   | 3 +++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h   | 1 +
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 24bd93219936..0ddd310cc971 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -623,6 +623,11 @@ void hubbub2_read_state(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_s
 		 REG_GET(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, &hubbub_state->vm_error_vmid);
 		 REG_GET(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, &hubbub_state->vm_error_pipe);
 	}
+
+	if (REG(DCHUBBUB_TEST_DEBUG_INDEX) && REG(DCHUBBUB_TEST_DEBUG_DATA)) {
+		REG_WRITE(DCHUBBUB_TEST_DEBUG_INDEX, 0x6);
+		hubbub_state->test_debug_data = REG_READ(DCHUBBUB_TEST_DEBUG_DATA);
+	}
 }
 
 static const struct hubbub_funcs hubbub2_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index beb26dc8a07f..aa80b3f2ca3f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -111,6 +111,7 @@ struct dcn_hubbub_state {
 	uint32_t vm_error_vmid;
 	uint32_t vm_error_pipe;
 	uint32_t vm_error_mode;
+	uint32_t test_debug_data;
 };
 
 struct hubbub_funcs {
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index d35432c21856..7c9a2b34bd05 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -271,7 +271,7 @@ struct dmub_srv_hw_params {
  */
 struct dmub_diagnostic_data {
 	uint32_t dmcub_version;
-	uint32_t scratch[16];
+	uint32_t scratch[17];
 	uint32_t pc;
 	uint32_t undefined_address_fault_addr;
 	uint32_t inst_fetch_fault_addr;
@@ -282,6 +282,7 @@ struct dmub_diagnostic_data {
 	uint32_t inbox0_rptr;
 	uint32_t inbox0_wptr;
 	uint32_t inbox0_size;
+	uint32_t gpint_datain0;
 	uint8_t is_dmcub_enabled : 1;
 	uint8_t is_dmcub_soft_reset : 1;
 	uint8_t is_dmcub_secure_reset : 1;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 21dd6cbdb106..bf5994e292d9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -439,6 +439,7 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
 	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
 	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	diag_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
 
 	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
 	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
@@ -469,6 +470,8 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	diag_data->is_cw6_enabled = is_cw6_enabled;
+
+	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index f15336b6e22b..d58a1e4b9f1c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -107,6 +107,7 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH15) \
 	DMUB_SR(DMCUB_SCRATCH16) \
 	DMUB_SR(DMCUB_SCRATCH17) \
+	DMUB_SR(DMCUB_GPINT_DATAIN0) \
 	DMUB_SR(DMCUB_GPINT_DATAIN1) \
 	DMUB_SR(DMCUB_GPINT_DATAOUT) \
 	DMUB_SR(CC_DC_PIPE_DIS) \
-- 
2.39.2

