Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EAC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 06:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA37021548
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 06:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tiwPq0v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA37021548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0786E1A7;
	Mon, 14 Sep 2020 06:37:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89666E1A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 06:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/gvrX/1H93MoyfhG0vcZtiFbU2UBVWyAxoOSoo1Vr+P1SuRUfeoh2uvDLrlJZ17k/PKb/Xii9JVTaZWqOVMAG2tToCCOn0p4Na+YcK9AaE6o2YktEySTUbjJaKJUPWwIfrCtf/C9RACP1y5DR5HI/r6WZHXTKWXbbkrCdPl9vVPI5WkxXKkjuFm4ym5UTf1IkUlkWBDIwqvqkwFOghoIjqcbbnZo8ddnbXzfxAEQ4MMZ2rDc6EPzV/QY0ymqNH0tZ/I7kRZjA2r1guvd0CiMj3MBJXRdONKtBeErzzZSm+N6+gT/ItB7+oJqrP0R6HsZVv+0em+lovmi1m1Rt+Fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmPIaCPViC8uSIxM2LVyshf17Al3PUD0jQcNWNDeQ7E=;
 b=f+865ThGRSLv66eKPVC8cSsfVLW/8LXuMxFam7sMLVRZsebP3j/1gWxxePM66YX29FJQN/hds0V3rmG/uIW3S40FCjj4ALSUdNTE9nF7gbqPu4cAUWga/NPy75qYPnG9dloVcJB1+8GRUmn+N7Xwc1GAsHUKH4PrfU7UANdzRforAMnPeFpdBWlme34GYeyjY3UbECYW8suNPe3Bu3WfYwpPeFUWN+hlxRJ92CgPCsVSB5qkrkUf0P7fPfXbXiTLlg8sq5zazRlUZpsq5m9px4NuR1e93NwgdyMJCrvPueH0+Amp+LOSWasxL2tr7MjOvtm7yjhSoSQFvpL/Jd6k7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmPIaCPViC8uSIxM2LVyshf17Al3PUD0jQcNWNDeQ7E=;
 b=tiwPq0v2zD/Gk8116O0QHWucyDHC6My0jkjGpp+yclRd5Hj5GZriRjhUbhAGqozHX/AthXgcxuMP7msgDSRtJ76RP+I4PxhmsCHbgMIKl7CqMe4zELyxevSfdQDijGzN3v9qOvGilkz3uU2V+/10p1oBaWJa+/9/LbZekOKfQV0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 by BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Mon, 14 Sep
 2020 06:37:05 +0000
Received: from BY5PR12MB3762.namprd12.prod.outlook.com
 ([fe80::28eb:805b:95b2:b75d]) by BY5PR12MB3762.namprd12.prod.outlook.com
 ([fe80::28eb:805b:95b2:b75d%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 06:37:05 +0000
From: Flora Cui <flora.cui@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop BOOLEAN define in display part
Date: Mon, 14 Sep 2020 14:36:48 +0800
Message-Id: <20200914063648.22500-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To BY5PR12MB3762.namprd12.prod.outlook.com
 (2603:10b6:a03:196::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from flora.amd.com (58.247.170.242) by
 HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 06:37:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3ba5924-8fe3-478b-cdcf-08d858789813
X-MS-TrafficTypeDiagnostic: BYAPR12MB3269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3269B27A5A392F39DA1035F3FA230@BYAPR12MB3269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fLTFDKyZD8QX2QNs/unjtW3siIbUIwA/irYS+l1/IYP+Swt6S3s7UHHAhSsUCkPEoPuiw2/YgfMgWTjJnJY4neqlpGInEx+1FabIiYE+iSNXDdLczehOsfMqvuK87hIP81xwdboE9uQo5Va21mb7A8RrFuBw949hlcOkb5Zx6gX1nI/TQrq9XWA7Ctrqc+iy/mMs8chFSX5l0Oznl292YKgh8eAI+wQIQY+9cO1beSIdE6RH5TVAM9VPqHu/dJf7dzZC/iQQIR9p23Mo9lU6faRrmmpvIAx9qs7YWuu5e15o9HaoFbijucZd8EmCrmS48PcpmORGxaoaLe33Xi/Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(2906002)(66946007)(316002)(6916009)(36756003)(66556008)(8676002)(8936002)(66476007)(6666004)(5660300002)(1076003)(86362001)(44832011)(7696005)(26005)(52116002)(83380400001)(478600001)(186003)(16526019)(6486002)(2616005)(956004)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0zTzqRi8b4ATbS7H4D3V51Xc2v8K1WNIbuPe75MGGmKpvz1uWOhCs1jffPPqbjHxRmJBOU2JsIS3P8zuNIyoicTlLyCNGTWGq2PjVxrzYZZdAOST8h+HclBK7qF9d+RlvxiVtARZ37XR2ypyFaHlqR3mF8p3ZYYNJU1IdStrC3cV6TLwvkLrlJWbGk0Dg5zsriSjTWGWxnbrcq9mLJLB4FA0VXuIoA8gDoBhidBSahndRi/3MGKgWBPqewj0lRLSzIcZSXojjGMJoQPrz/dpA/vgopQ4iaz85yik3FdGMa65uEFWHA5PSswJ1xxATTKYuwERzWcwvbZJeVWsxrn1/Vi2nS25X24SG34WEKnvRqzlv6/ntVYyErnB5jb1qOsnX0l+TqsLvn2ieC6o5n9yYatJKvprKTdxigyTO590ptrHTJaL8vr3Xb1TnTgyvFGhbbVHPZ2hCNHPLb3CHAdfswvjpC0x5IShlVCOhYA3ejqYQr5XcxGoUrpgKdq1y7uRRCuyPJkjWkDM2Nr0wUGSQWtYlO9V2yKhL8GL4B25HxoBfm4Fu2isMbRZ2GGJDwAa6Ah5sdbpvtzuSWMTP9oxo2SAp0UvRGvc9O61BMblXsynYOWMXPt8zZy/E1VnLEgErk84BRJvt32ZHHs5d71qVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba5924-8fe3-478b-cdcf-08d858789813
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 06:37:04.7237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/7y1pfauUrW9veOrz+uJyhfhX8zvhr37uSST8zWZPz3VH6DAuo8kKU61CbKs50Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
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
Cc: Flora Cui <flora.cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use bool directly

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h               | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index c5f2216e59c4..6a28fdd50e05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -810,7 +810,7 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 }
 
 static enum pp_smu_status pp_nv_set_pstate_handshake_support(
-	struct pp_smu *pp, BOOLEAN pstate_handshake_supported)
+	struct pp_smu *pp, bool pstate_handshake_supported)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
index ae608c329366..3586934df25f 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -30,8 +30,6 @@
  * interface to PPLIB/SMU to setup clocks and pstate requirements on SoC
  */
 
-typedef bool BOOLEAN;
-
 enum pp_smu_ver {
 	/*
 	 * PP_SMU_INTERFACE_X should be interpreted as the interface defined
@@ -240,7 +238,7 @@ struct pp_smu_funcs_nv {
 	 * DC hardware
 	 */
 	enum pp_smu_status (*set_pstate_handshake_support)(struct pp_smu *pp,
-			BOOLEAN pstate_handshake_supported);
+			bool pstate_handshake_supported);
 };
 
 #define PP_SMU_NUM_SOCCLK_DPM_LEVELS  8
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
