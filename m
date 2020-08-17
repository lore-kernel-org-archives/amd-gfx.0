Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5145C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730F72063A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v/NowaT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730F72063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139626E4B3;
	Mon, 17 Aug 2020 08:30:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39456E4B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnxMN8vsvDkPgJ70Gw+Iumcvr4aA+wCCLtDk942d2RRj/hO4VztELvDvNt+BxliZ4M2fb4oBnEQwBxXRntA7G7NBe61S9Kg/fQsv8CBfF9+EpYJU5UHyqlFdBgwY6M9jDFCYG9dDkTOya72CMRPxfFdtUkoVqTdvRzb8dQne7U3esx4P3VdHbTdb3VWQMCKOee+oCEWqQ4ABN2uSAjtNltXCTraLePqKySzFVS+v+Q+Bn1W7vxFu5mo7EQJvZ9Q032sLmvs+UGb55q5lXPrqJnICBTeHNiCz+58rcsb/wxY0TkS6YMUbyfiEL5+XkVYcARagGunPIgR+1VY8koH9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiJYtyIjg1Ukh0cLLVaLgzK6d4mYiaY3IpdWSnk2UcM=;
 b=VmDKOaEWnEpbsxDk5m1Ib4cBMJJC3/BFCxtqm2Wj4lEiEEFCijTm8Ote4CZD6hOdl9PaJxwjjigsrejmzMfApeLszig5IfcFgqzeoE611RuX7VvvHGcb15NVqG7X0gbz424kOsL2TKZUykKG+VOSSXTPSRktI3U7wG9LHbBExTyQ07K+EYSjsWyelj8kfCCuWJueYD293qDZdOoGqph3tXGvvzTfa6LtouuNcHtm3O+s7GHH1oGwCVgaSWew1vjf4FApGfF+noMBI3z2Qy9QyZNTA4GYIKoW9Pn6RYlA/l0k8Wz4DFqOg50OMfxwkRweWSwyJEvHtycWEBad/G1ZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiJYtyIjg1Ukh0cLLVaLgzK6d4mYiaY3IpdWSnk2UcM=;
 b=v/NowaT0M+6zaItuXsBOh5074ovMEk+xJOYf2l/DyJcJ+oARDMgbuGDeP2E1CbKY57tZPd+T+vRnx3SHXb1HlGWAS0PyOrkxCsxgJ4sIf3NnI+Rc7KIGXS6Q+4RKYsObyd4EABy8xrt4HHZxphxLpp4c5Mejf8ke0xqUclip3yU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 08:30:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 08:30:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amd/pm: disable/enable deep sleep features on UMD
 pstate enter/exit
Date: Mon, 17 Aug 2020 16:29:38 +0800
Message-Id: <20200817082942.25733-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 08:30:02 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f30ec21c-2711-4d51-79fe-08d84287bd55
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31773263FA7FA8D4BB640824E45F0@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tp1XbSYPbQ6l6TXOzWyzzdw7CFCWjZy4PJ1HvNKj/8ERx1hCXNBi6VsK1WBHFxov5+Lbp0woiJlMI1jwZ/+PVrlgBqKo6WEDXipvB4+zDYVxw9cC+S4Ribc5KdwiSbjaUTy3V72RPjXWfYFN2BR6lrAC4Jl1jkXVDiBmWW9nwYHvNKEg0nIJ3Q3qb8HWwSUrngrPunOwCucqFhkB6zes+kbj8bJByVnAgc6vD8zG5WZhoyx+FEUkbONQLeqNUswSnNCbLNQEDyHs2PEdu3FwXDVoi7ilmAMcBjmyP41jUYqSrPMXCTx/exRctnPoMywV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(66476007)(86362001)(66556008)(316002)(5660300002)(44832011)(83380400001)(4326008)(2906002)(36756003)(6666004)(8936002)(6486002)(8676002)(26005)(956004)(2616005)(6916009)(7696005)(52116002)(478600001)(186003)(16526019)(66946007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EbJ6GL9ZOOOJKl0cT/pOTiFPFAHrbVcfL2cBvPhBN5Ziy4LZHExhcFSUhKqWvZ9DC2D5QPjQh8zSlLOr1AlJu3BYtOgWtTGZuvcmsWc/2uuvwh0HU4PtHb2JZWeugJo0DzD75ajlptRXBywLeo6ZLSHQGOn8atXum7IXBadoMOhmx8q9tn6D/1Ki8mqRgoyZ1glmv1bqW31c6MTV574P5RqCdyWe1Kyvyr3xjy8f1gIcrr1HeivXLIZXmWpYicKoFBXxR99dJxZJz5KHRv7ujLanK1ijsknhZ0wfR4sDs+bFglyIs4QgqitOf0UEtDWUiWsDfxa5L01yBZwU93GYiTiZhnBt50vI+/R/qZkE9rLnMG8L//nlETYp5AVdHzzwZtzBXriI4tMPkM8ibX6cYafP15GBZo27zwpzA8EKUmpMtMxdUUlULME7yNuqpmqWPIxyrNdhDVJdyKq+VuyEl+VdaKMvpGKeTQ56R5tWKwL6//4sX7tQPxnXQBIAW4/6pAylQ6nVcKgCqX3lc1sleswDPrh51U+8L8mLqh6r3A601inc2gTgQiXMjNLTbBISokvjECa7/j4jFRXhQjGVYf44B5kiSzxGw3g0RahbQLhJlF0k6yBJHV6MorgtXj5Y7f4wfUhi+v59EsBleUfuzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30ec21c-2711-4d51-79fe-08d84287bd55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 08:30:04.6164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAIt1Yx2p7ZJBWZQCVMkx1yw1zmrbgWnFdYHAby7Ab2tk+cZM0Kf7U3ymiBI1Lfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add deep sleep disablement/enablement on UMD pstate entering/exiting.

Change-Id: I4fbc02bb4a390ab82293a5ff9c91f2a8beb0a3c9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 7cc707ec21c3..4c5c041af4ee 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -597,6 +597,7 @@ struct pptable_funcs {
 	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
 	int (*enable_mgpu_fan_boost)(struct smu_context *smu);
 	int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
+	int (*deep_sleep_control)(struct smu_context *smu, bool enablement);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 221b5c923ce1..8eb5b92903cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1441,6 +1441,7 @@ static int smu_enable_umd_pstate(void *handle,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_UNGATE);
 			smu_gfx_ulv_control(smu, false);
+			smu_deep_sleep_control(smu, false);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
@@ -1448,6 +1449,7 @@ static int smu_enable_umd_pstate(void *handle,
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = smu_dpm_ctx->saved_dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = false;
+			smu_deep_sleep_control(smu, true);
 			smu_gfx_ulv_control(smu, true);
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 2fe29c6a00ce..c88f8fab1bae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -93,6 +93,7 @@
 #define smu_get_pp_feature_mask(smu, buf)				smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
+#define smu_deep_sleep_control(smu, enablement)				smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)
 
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
