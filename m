Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E32C43461
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E289E6138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E289E6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926506ECE7;
	Thu,  1 Apr 2021 16:46:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DAD6ECDE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LId/Sjy0zBj86LA63dKK0tTECG1Eb3wA8EwfSB8TH1b/1e9L9Vcr39G9sJu5R4fo92jXCwTnMdtHoeIO43TjzCe9maZ+IQUR0Xpm9CetsX1E9xb3opMjLWveBIXkLJJStVQKPfW6RnpiJd8YS1qfiZCDU92GM2EF0ILvgviC/kZlN5Dzq6a/0puWX1di1xgqTmbChdvLV4fFlVksSUxtb+pCf5srM185hLMZVF9ELAT7PaXWPKUl3NKvYsqpDJYy6cZQddX8wdbDMglT5dxv0MoS6riaSAGW+dMLVKz8021YyAwdUHdncq4mnWLlarX4QdJPA/MZKW+v+GmjUoVdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZmiS8N4tbyFBvhnvjfvED/YHeP/s46FhWWecjv0nbo=;
 b=RX/O2iidO1Z+UZHGPCQW6IO2OYtxccs/nhJLIcTqLZJlsFKF8VqjVngH1ms9IQkHfmcUuRzJQw8x45HsbN62hL7sZSuwK4R/8/j8CV7jZUcdP9fgbFMYUqHLVBj8vgoSK8yeNiPUUkm1mpk0XXFsh4frGLlqY05fhY+Xr3HGGLUi3x9sWuNPUESv+GQQ6/uJWYZev8KAinHxICyrtBfii7I7LVfCp/u9PF3yjS8T8qEOGU8VSLitFll7m8HSYyw8aXASRUpRjPdTKCkoHT88rsgiLST+g8Myuff0ltb0LpwjXZMUqIrWK6GZDztkDcN0ZwM/Yt2pU0QqU9CcwHtmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZmiS8N4tbyFBvhnvjfvED/YHeP/s46FhWWecjv0nbo=;
 b=tazcENFnb8bxQxkb83cNGJ0XAfAmg1BhtMKAyLqw496ROA+1PY4gD0qkU0jtdLVw/NmJZ45NK1aniRIRZKu3PNbGl1SxzHjwx+K06txnBud+Y0nzyVYfGb98cYdib/Z7B1bCqYYzPjLIRtyN7D9EmZDtztfwewxfE/GYLW403bk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:02 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:02 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/21] drm/amd/display: Add debug prints for SMU messages
Date: Thu,  1 Apr 2021 12:45:15 -0400
Message-Id: <20210401164527.26603-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70afa2ac-7eab-4a49-9953-08d8f52da2a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619E9E55DEDE3112B2442DDFB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxk/zRpRhOJlIH/frZL+B6jFyt8EpgLq0t3On74KJKXVys5H0jHJULTs89qm5dm90Txu0MFqmUpf19JWN1hbnrTVixsRsYXSYsDNbPQSdimHUfLIAxeV2A3aE7GIbVDGr0zuUM3vXcJeA1oEr61/gO2PGL1Kl0qaHuBwYJU9wdvsZNxGQsNTq0UvcpRthJmWVPIPpFwz+TUAhBglPlDg/x52P+aXDUXG9Z2VkJ5vN5ivaEM0OIcL46JfQpM5R4dTxLfpIlDuYLhbi0GiHXzRIBNCEoxpTSiRk2I6eXxdpiatJNYQvX+Jjiqrk9m0xQW0vNaVee8NWK7PzVhy4qO9ZXoQM+n+T2LV0Sgzz5VvBSfPmcMZqP+SlFCHxYf0OQ1qModdegftcDGQnZRL2IUf+tbT7WHRCg40G0++LclOhOHJHHHfY+PX+z4prnAZRnFKOXJN93AZIUwS4A+xFzkusovLVRQUnKinhntMlKdziZ8Phh1iuvd2MQ3OtyxUYt1x0BvTxTsQ03+WnYifkm70Vpk6NdFUdA8pmEG0ovnz77s4J6mc3Kd8Vz5hBqOOasQN6uW/vAJM4BJNqWHvlKLO9oUZU1ej4Xb2wnIu/UAfZZ+Bda/xCfHA9wkBDdX8YhnRKa05INj8TMwtn6QU6XZM/NthbfzMLZnpdG2GW7S/ar9AiSMv9YP7kFHMJt4Pgsxd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(83380400001)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(15650500001)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CWXaRQpGpoQplEGdy2+k21EOZuHrYK/KedBlDkLe4lMNM+d5P5DprLmAOkHw?=
 =?us-ascii?Q?gRJgi3if3BE4VQldDB5rrJIvu5pZUPjlRehOBoMGqCfHEpvGuPVDddkBxUhO?=
 =?us-ascii?Q?v6SETCtXMrPjwVNnzneIIMfrQLXAL/mNa7GMAV6JfflBIimI9IhPzNqRNtR4?=
 =?us-ascii?Q?e8yXX0qLGJMoqMpBsn+1593JtxrwMTFA+e2Fp7068obBqoUlKjOrOtvuSB3t?=
 =?us-ascii?Q?/xcNG1JDVu9Cb7TwL5C+HflCtiZ5WkQRM6GjJFsVNOyCUc3GgGCX7p1QEX6+?=
 =?us-ascii?Q?4fenZxTl9dAPdAeRVPmIfe6YkOCTnLz0n0W1n9qonaIVeOLfrvvFG/xz35FV?=
 =?us-ascii?Q?Ig7B7nXE/Po56OKW3WsbS1KM8WGAvXM4QtRi9aMa3b/wJidl6cjOhlSf1OxL?=
 =?us-ascii?Q?t8ddNybsODI7ir3WlH1TTcqa1gepyDyovvc82TkDqrLF21zlxi8NGiH2uZqr?=
 =?us-ascii?Q?lMwO3fgNX2GP6/bksnaEpP9P6Y9wj7CvRvar9tXeTW1qAcXRnz2F719rgsnV?=
 =?us-ascii?Q?DowbMbDlfveKrNIhjBWbK8OLtNIBX1Fy/14zcPX2f5P+NsF2nkrpSnVRDOKV?=
 =?us-ascii?Q?/wg9tb1WFdFpJTe4fMGsmprO3Ct+0MBwAuUBr/YtdqzPw+BsyomX65DBsjsj?=
 =?us-ascii?Q?Q3NusZKkNWdQjFJ+UoE2IXvwyNdg0F6kz2yusW8v11ZeozRVdC8VCp6Giczq?=
 =?us-ascii?Q?6czwAmRk6utyRB0BKEfeM914zI8/F7/EkQBE7J99KR22/fTN3MIO0BY/JOrl?=
 =?us-ascii?Q?xq5S0+LduIue4Wr1G0GTWbopocwr1AdVmeCmVp++5b71o6NiwKQMixLsyxr2?=
 =?us-ascii?Q?nHpZV8TlcUb7P5ropq9bnEn3Ke9NHvxmNdRKWGV8Obufx3SuaoOMuZ9KbphT?=
 =?us-ascii?Q?B1vsxODVwlG/oJIEOKfrKEIOXv6ikdGlZWDSy/yBGqsalnkRPXcVHNSR8SqB?=
 =?us-ascii?Q?+tF4f7Ps0SmjIVelreYL/zDHvAf6iKyTxzGrhxkmDDHFf5/9OCTxdr7AMBs+?=
 =?us-ascii?Q?xqlZvftTxTwwNXBmfYEFQan+vAdAOQif1SrCr2zgz+Aap5U3w2SgKeXfrmNb?=
 =?us-ascii?Q?x2xNRrpkxdG6GPJao/JIMVd+yjhXB9CpjZ+bmoUMLTlb9Ke6tHUDiSn3Hib/?=
 =?us-ascii?Q?z3W82t+Bf4FG+idsdxWPMIwfFJmnuxSpbFOelqn0ctrO1eYuTf4LGvTeCF48?=
 =?us-ascii?Q?1a1tiBTHd3BtqbNVsIEC+ohWGhYnFmaiTe8kXYXwLLrWN2HV8ab44Fv150Jb?=
 =?us-ascii?Q?Th7qtSOKBN3AollsfJTCR8FjQzlxth97D/kbRUVIQWmSHbXdAUAjCvq2Rh8d?=
 =?us-ascii?Q?oB4XjCjmE783vPmakK3veiqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70afa2ac-7eab-4a49-9953-08d8f52da2a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:02.5228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIek+yO1yOHIsZUTEXUmw/J4SM1iankrbhx1I/7D3exo6lnUPsDKrXKhpvYB9JgB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
Add debug prints for SMU messages with regard to
versions, clocks, and more.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Reviewed-by: Robin Singh <Robin.Singh@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index 68942bbc7472..07774fa2c2cf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -113,10 +113,13 @@ int dcn301_smu_send_msg_with_param(
 
 int dcn301_smu_get_smu_version(struct clk_mgr_internal *clk_mgr)
 {
-	return dcn301_smu_send_msg_with_param(
-			clk_mgr,
-			VBIOSSMC_MSG_GetSmuVersion,
-			0);
+	int smu_version = dcn301_smu_send_msg_with_param(clk_mgr,
+							 VBIOSSMC_MSG_GetSmuVersion,
+							 0);
+
+	DC_LOG_DEBUG("%s %x\n", __func__, smu_version);
+
+	return smu_version;
 }
 
 
@@ -124,6 +127,8 @@ int dcn301_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispc
 {
 	int actual_dispclk_set_mhz = -1;
 
+	DC_LOG_DEBUG("%s(%d)\n", __func__, requested_dispclk_khz);
+
 	/*  Unit of SMU msg parameter is Mhz */
 	actual_dispclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
@@ -137,6 +142,8 @@ int dcn301_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr)
 {
 	int actual_dprefclk_set_mhz = -1;
 
+	DC_LOG_DEBUG("%s %d\n", __func__, clk_mgr->base.dprefclk_khz / 1000);
+
 	actual_dprefclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDprefclkFreq,
@@ -151,6 +158,8 @@ int dcn301_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 {
 	int actual_dcfclk_set_mhz = -1;
 
+	DC_LOG_DEBUG("%s(%d)\n", __func__, requested_dcfclk_khz);
+
 	actual_dcfclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
@@ -163,6 +172,8 @@ int dcn301_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int r
 {
 	int actual_min_ds_dcfclk_mhz = -1;
 
+	DC_LOG_DEBUG("%s(%d)\n", __func__, requested_min_ds_dcfclk_khz);
+
 	actual_min_ds_dcfclk_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetMinDeepSleepDcfclk,
@@ -175,6 +186,8 @@ int dcn301_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_kh
 {
 	int actual_dppclk_set_mhz = -1;
 
+	DC_LOG_DEBUG("%s(%d)\n", __func__, requested_dpp_khz);
+
 	actual_dppclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDppclkFreq,
@@ -187,6 +200,8 @@ void dcn301_smu_set_display_idle_optimization(struct clk_mgr_internal *clk_mgr,
 {
 	//TODO: Work with smu team to define optimization options.
 
+	DC_LOG_DEBUG("%s(%x)\n", __func__, idle_info);
+
 	dcn301_smu_send_msg_with_param(
 		clk_mgr,
 		VBIOSSMC_MSG_SetDisplayIdleOptimizations,
@@ -202,6 +217,8 @@ void dcn301_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool
 		idle_info.idle_info.phy_ref_clk_off = 1;
 	}
 
+	DC_LOG_DEBUG("%s(%d)\n", __func__, enable);
+
 	dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDisplayIdleOptimizations,
@@ -218,12 +235,16 @@ void dcn301_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr)
 
 void dcn301_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high)
 {
+	DC_LOG_DEBUG("%s(%x)\n", __func__, addr_high);
+
 	dcn301_smu_send_msg_with_param(clk_mgr,
 			VBIOSSMC_MSG_SetVbiosDramAddrHigh, addr_high);
 }
 
 void dcn301_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low)
 {
+	DC_LOG_DEBUG("%s(%x)\n", __func__, addr_low);
+
 	dcn301_smu_send_msg_with_param(clk_mgr,
 			VBIOSSMC_MSG_SetVbiosDramAddrLow, addr_low);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
