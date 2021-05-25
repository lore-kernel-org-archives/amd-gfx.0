Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE36C47086
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 20:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7626611C9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 20:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7626611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB656E436;
	Tue, 25 May 2021 20:20:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6186E436
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 20:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXwgzjtf455qe9iirbamACPCngslNVl88Gjh0yiCYUEhpf1usPysGYf6LP6H8pX3PymbA0eKVMDzj1V2udL5nymD3YOfLDRuFcA1A9q+cc2i+H8YtOyo5shsrL3t0uhaK12lcFv1HD9wQpQpJa6uHmaWi04k/1l5Qn0XjcfJ4Bo3HSIsZOn5lLZ4wc2SyjTqwLV8xKLdxFvjmGyYfnr9V/XaLQLPwm9lK+0PkR0DlkA9kTK9IV3fMwfOOq7+4tTjA4FzEllN/T+vySMRcCu6OpUqqy/WG4kTYER7YSdiqejx3Ww7RPPKtvpa1Zl15HjD0akl90ueJDKsKil2rJK2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZJR668pzozrRwIdMZp2xS6YRkGXURgKN6P47zSfZts=;
 b=jB8u8oDN7VCFAN4SJmZYTi8Bt7eFbynh6ihkgeQG+n3NXsfQz8pDjfllwdFHApVrY8Ds50p8k9RkG//nc3VjvaThdFHUVsoSHcFJy+7kqaCNZI+itb++765p/urZYhXkiU+VsoPjc/DcUKBge9wFPzfIufmKvQ7uezbWQPej4fPvWw6XZa1kYUfoNMrljm9IDo9NaS1LegMqE4RVG2KRXiLrpb1sHwdC3K1ofvJ0d6WVM5PY8utESL0YTGDqtTceReeo5h5qU0tOu/Sed3SquSAd6nJvolGWZHG82CmqAva71HgY7EOKlPHyLAqk6u927NiEmjeviYK+QlX97V3szA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZJR668pzozrRwIdMZp2xS6YRkGXURgKN6P47zSfZts=;
 b=XyHeTqcWMB2yhTW40zl0qDtTXeg2T+BBMY29FNTBNgp3p2Z3TQHdpW5arKBnKrY2V6xRIWia4pSYnRjsizILo2KXNwB5yxHJIqeEtlGDdQ9f+3Z3CoL4tgYZV3oYudK76wsNKFbNqvELcvPkqoUSv1OmPaSahLPJAtfLnyZivwI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 20:20:44 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 20:20:44 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Correctly clear GCEA error status
Date: Tue, 25 May 2021 16:20:20 -0400
Message-Id: <20210525202020.21280-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To DM4PR12MB5263.namprd12.prod.outlook.com
 (2603:10b6:5:39b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mukjoshi-dev.amd.com (165.204.55.251) by
 YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 20:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb6cf7e-8f5e-493f-95d0-08d91fba92f9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50697C2AF5A012B3C4BEE4FCEE259@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssBUy15nOPxgAn/vCCqE2IuA77yBe8KnxCxIq8UZBMkDe0SxC5kAQNYIjB/JKqvhP6ExtQHpa7k0FtuzQFvz+uHfY8MWtH31FvVVKLltt0aVeZhL48xyRTt6OAz1l8ten4Ilg5tYWpNNhF+7CXbYEWoeXTspw1x24SJuBvJYj6CoWGPsGg+esPXb91IzA45Lum/ZMug89JMVQzrk/5CcmlOaD2H2D1mloTexrOcvsQKp+H48UmvBhj712TjnjUbKLD7CRVodxWaHsZN287qQcXe1LLA1pt8qcAtRUrMX3ZrH2Vy1tFmS/0dzzSV2IQVr0+phDYgeo55O4rXORhG7HmomqdLGNQvb2xpXbWNW5NO/PmvGvudv/1ox23VphqxAdxZlFuUwXGmFmXz8VVIID2FpiyQwjvoPwKhhUN4MHJ0snX61P+aESgnRMPoIfqS6BtYtljLJw9iyBrGACQuPrAL12AKHpAdA+Fnq+terW+gS9cmJGkuu00PVoN8fBi77zBt6EeDDHR/Y18WTHr06/tmdoNacHzRZFD2PI+X92jNpM90pp9RjSR+3bJbHRrdC5Duk3cGW3SbFzc3/KSUwCFJvVighA4ZJAL6oAFAQVctj7iEcFwmilMx0l78A9f6b32PA1mln7R9FFSDHkFGGgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(16526019)(26005)(186003)(1076003)(44832011)(316002)(956004)(478600001)(6486002)(2616005)(86362001)(38100700002)(38350700002)(66946007)(6666004)(66476007)(6916009)(8936002)(5660300002)(83380400001)(8676002)(7696005)(4326008)(2906002)(36756003)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F2nTSLaXvbrMwyJmQVjUksBxwsKJEMugzNkwaLLVUaX894gNIUefAiqmXPQ+?=
 =?us-ascii?Q?B0M6fdVgrqiHqbLzVskyvM1FR96fOCk1yu4Ty6mPuLE1zGDgZxGhtUmJ61Rh?=
 =?us-ascii?Q?H4n2rXbzTnHqpg85DLE5+I+osM/+RGF9XAeeoP+eFi/Nk1xm5HCPaUy5go4W?=
 =?us-ascii?Q?Xz5zJomf/ftGs2FfD9owkA7IAgg649MeT+nKoxzhLpWxBXOEQNrla+ZWZi/S?=
 =?us-ascii?Q?GBFuuQtkr2pDeKQ2bO4gXBgxhtk26jHa94jHZNYV7MEfLsyuV9fXd0NmO4DH?=
 =?us-ascii?Q?4icFGkFJvgRkso2EbV8monJvjHglpowsFCt8/eMpy82/QVmo2FMscZ1eESHG?=
 =?us-ascii?Q?z+eYph/PM0pyKlVdbYGo6P3sjLxDJUiBAjPlQOObEiZnGQ7GhAOac5O8nOF0?=
 =?us-ascii?Q?cmdUcYMoxjONTH/+nTWRVEoBtsUuneOey2Ws5bFgQLETHhJAx3wURgolDK6G?=
 =?us-ascii?Q?dEjEAou3uSocsEkzRthyzkwoHq+7WZpGg+rcEZjXCujmFXXhN3+sC9Gg/LNE?=
 =?us-ascii?Q?rq7OP89wFbKxjGwAtj/0I4nmWLA/zouBaUNNkMVEaUvJKl17lDANxS1tD+Xr?=
 =?us-ascii?Q?HspTCHAby2b4PoVLCHe7HRCtRSwahq/Ry/FJK4thdplm53nqYRN07QHPNL02?=
 =?us-ascii?Q?NgHIBTmBj12Fgkq10fUf+RILS+/ncVjwtLiTHEgYAvRZ7V1w3j8Q9tc08JxM?=
 =?us-ascii?Q?uHF/4fHxC0v8HZzbjRnq9utzh31TLtQqBn64d4Z9SN8LGhjpyJPCdL/3t9Ps?=
 =?us-ascii?Q?LwX+oTGg6VANd9oOPHaFywuaQpqSWX+0FAEoq9bOFaxPSQDZIHF6ULYsXt8e?=
 =?us-ascii?Q?rOO25wSbvSrs0LQT8Qwc2QonO2By2bV/KAosVhLht/DjaEM5ws5QITNAxH6y?=
 =?us-ascii?Q?NCjlCgNrji3X/GpXHLrZ7oufqGDCkDEPl/Q8op5fAdT7iaY2LOuYgDDGSjXL?=
 =?us-ascii?Q?HhaosU4TL0sOibUgit0tEXqIv4lgnh3ZMTxyJ/RxXbGEvVWY4eElkx8Zm9OB?=
 =?us-ascii?Q?Isuul+4nkVrd+qhrjyz2jAMsgWsuhrJR3/wUL0qpIPAN/nktr7WPdVmvTqFR?=
 =?us-ascii?Q?yDtSFOGiXshuxvZqQ42CgqEJ08Vn/utdVfzVzf/sdzJq/0sDkIVSvxFYMLng?=
 =?us-ascii?Q?yAGyaG2Z5RUp+BNZq236B9UX8cZ2Ku39h+uDBsAVEWotzpanjmcYuLIdwWdL?=
 =?us-ascii?Q?HYtkS1b00IxSzH/PnSMTDkEXSZscnIhbGeUwzlLmehCS0Co4532oTRVxVGhj?=
 =?us-ascii?Q?NBJDne+Sukqr360uBiP4pQwtLIajSo6WiOGB+0hM8cUJ8l/sdDVIws7YD+qW?=
 =?us-ascii?Q?+wUBfsoPTySdUivzs/AnSL2Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb6cf7e-8f5e-493f-95d0-08d91fba92f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 20:20:44.0710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR+Qwfwr3VkREv9HOYMzjwiCE9DgmpvlDY6sBRvgkzmPIaaHB3xIKoxem9ZhkHMkX44W/D09ocY/iQV9HLpMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, john.clements@amd.com, dennis.li@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While clearing GCEA error status, do not clear the bits
set by RAS TA.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 87ec96a18a5d..c0352dcc89be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1676,13 +1676,14 @@ static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
 	uint32_t i, j;
 	uint32_t value;
 
-	value = REG_SET_FIELD(0, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 0x1);
-
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
 		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
+			value = RREG32(SOC15_REG_ENTRY_OFFSET(
+				gfx_v9_4_2_ea_err_status_regs));
+			value = REG_SET_FIELD(value, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 0x1);
 			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), value);
 		}
 	}
@@ -1734,6 +1735,7 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
 			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
 				gfx_v9_4_2_ea_err_status_regs));
+
 			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
@@ -1741,7 +1743,9 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 						j, reg_value);
 			}
 			/* clear after read */
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
+			reg_value = REG_SET_FIELD(reg_value, GCEA_ERR_STATUS,
+						  CLEAR_ERROR_STATUS, 0x1);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), reg_value);
 		}
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
