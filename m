Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A89C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C30020FC3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uQytzMiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C30020FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E666E948;
	Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3908289A94
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3oPIvEKjlCXO8w6pRH+hF+mzpS1/GPNcSiUrahMPwOXj4RhOvtYHO4uuI5VBJ2wSPCTbt/xLT/7Mor54VWeNmG93e7hf0wrWKFuHLCzGuZy4UY9sTE0x8b6yCV5MXmBNTwQtp9o2qpsAKDcC0ufX3ZrZYbE5ayqec912fBFdzvkPDE1+06bQwUXgoVZ7uKi0yh1SmyE8NrFLRWzCeLleYl3xdJCtfg1SB9GEHHZoqesZ2NEwWu8sy7s/TCvZufamAZ3ScLrc8ulhrXg8Bi4sj9M1uRGocOK8rUv5ZZRz7PtKJDlSOQZz7elw0E5Z1bea2IqkLSc8Ne8pQv/GTazoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glh2UY+KvrZ6iRcOvQq/XKwiNetLhPKBNJtwl7zlnjA=;
 b=iNCof2OFwuVOIIrptrdSNW7Yo+3Oiv6q4Mg+1jELyu7XJ+Q/t5Ah8fixhdUCk2gcuipEPzvlC8fzS4q4JeOKq1+mLMkvwtIzCBpKfb/WWbInKLAPNuD+T5FRPP1Ors07XUo4iN/nvC9jwUACFiw2h2NoHnkotKu8O1WGCvzKbVA3CliXAFr841ycHypSaVWDZ1HeMPlf4RhAXxkiRNkYQk4Z22k6kSzd9Pi/PIG3KhdVpKm52ObUKQgpedJuBB+d9rCZ6Wqrb24/o1rQYMeHoWvS+i9c+ZYqHWKeEoJOvQaKUu8iI6fiF3vIMv7RHvWybSrrsu32NZah6FfS+Roo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glh2UY+KvrZ6iRcOvQq/XKwiNetLhPKBNJtwl7zlnjA=;
 b=uQytzMiZRcg+cLs648lK+bzF/uXZPSRdJ8OHetIjDX9OTu+KasxpNZ7IEpaEFfg7EGZKHa1X2vK2pul5U9bgjREZdlydAFyx2HFqRiVHzvnuhG71u6vqqHB1cqdZSQKelCxtjOeHKKtmk46qYFfxb/w0XBcDNSEoeS8enfX8z08=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:02 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/30] drm/amd/display: VSC SDP supported for SST
Date: Fri, 19 Jun 2020 16:12:13 -0400
Message-Id: <20200619201222.2916504-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:01 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31977c33-258e-4615-b311-08d8148d2b45
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40871E17C1B47C53B616879198980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlbXZcwysaAw4ESiD+8nM7HVmP5sWsdiZcm56MWmTwjStBYigJKg5Cl8TEg/ADi3BRV/+dZbn/UR2W4Jq3VP2cpSnUekt/O50578sFrZ6/3Di+gW3SpZTxspaFGltqEvkN/AU8xFo/LCIV+r43Idscke7MeKWeU6yoa2jLltWAZirEN5smYhYheZZDXdZ7rfT8M/pH/lGm5mMtIkcEWxRgr+JE1aZv7fcOStMPMSGKC/LdPC52KgQ4xLsqnroJoGyHM0oBBQG36Y67iRoRUvmtFhCXRZYJ8278wnif/9PFxcTJYHxVrZMieeri5r/KSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: D5cQUTDvOfOtIILR3OtB4IKFHd9dp5ZdlEckt6MeDR1qZxB7ZWsu5EqIco6H+BQaT36C6MMr3mIjJNzkN8rf6Tj3XyruAdE+ohbasAmwNqoTwXSAHisEDicTv6UCX6lPbK5GRFRA+mUDUVKVFjOdHBQ9TsLhxGRen/4CUYOL7cwfpmzBQQrKSM++xm7GhbJtJacPzTC8NcxxHOT3K918bxczu70b4zmSKOp61FTZFW0f2d9RVEUWX8JRqACJTsU2SLG870ee6oyNrflAQy6F9ORdvIDj5OsswF2XqmNLIR+SPFR1Ojpb3z1hQ5eJSIKyJhTIa41RAZgXBwTECXpn5VAUNLt87ceZ8fFwY9pgCNJR/tyyr/JX1uXsWM8OZVhhfF/zka7mStQonwrzOazkHs6usvNEAo+rPSjnHv8o73lUOzGFk0Ek5wpe2mYq4EXEmNN3tPWyHXvwlvm0hFvAVPy37tWvzGUNWyuqcsY3Bj98ClobB3n9C+k0JaV48glxeKlm9YnLqBqUA6yxlhE/EQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31977c33-258e-4615-b311-08d8148d2b45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:02.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47cs9bA8eknAsZ0gTmO5WqWFTtHY7jBJ9rjGWrToUueFW24fyszG2+LFpvqKQ7ID/07UfNugCn5BUDvPO+qfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[why]
If a typeC to HDMI dongle supports YCbCr420 pass through and VSC
colorimetry and pixel encoding formats in the Extended Receiver
Capability, we shall allow VSC SDP to be used.

[How]
The Extended Receiver Capability field shall check the
EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT bit in the
TRAINING_AUX_RD_INTERVAL register.  Removed DPCD rev checking for VSC
SDP.

Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c  | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2dc419194817..e35fd2225972 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4646,10 +4646,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				stream->use_vsc_sdp_for_colorimetry =
 					aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
 			} else {
-				if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-					stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED) {
+				if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 					stream->use_vsc_sdp_for_colorimetry = true;
-				}
 			}
 			mod_build_vsc_infopacket(stream, &stream->vsc_infopacket);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3da5d76ee8b6..d9b53654c35a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3376,7 +3376,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	link->dpcd_caps.dpcd_rev.raw =
 			dpcd_data[DP_DPCD_REV - DP_DPCD_REV];
 
-	if (link->dpcd_caps.dpcd_rev.raw >= 0x14) {
+	if (link->dpcd_caps.ext_receiver_cap_field_present) {
 		for (i = 0; i < read_dpcd_retry_cnt; i++) {
 			status = core_link_read_dpcd(
 					link,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
