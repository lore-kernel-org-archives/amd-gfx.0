Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF75C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D12B2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WTRlw7PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D12B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BB26E463;
	Mon, 17 Aug 2020 07:49:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6421F6E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 07:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROTu5Bx2t82VCZp4tAggz1uPFN/5DUg3zsC8txS56AsSoUJ1gYNiMZncsYEItDlXHwtOaoj2KABDtwq23cGBT4d+JiBbo+djwN+XkGI4CMm+SLBlgKGh0Jes6PUwzVyqBvzYlitJgNyu0SyeEjH2fH1Fb+mRCbx9ylgDgqT1bDX5FzpsrRbLfGwaXXs/0YHK5wKFi976q/mSIteXr+OO2KH0aa3WBuZv+EwOn9SVPGdnwUwMdsI/VFY8hbAxvYSy79LzOY6119v0XoeyZ23Qub5GHM3cfH0+d8jx3j6EYk3gMeqkPg8ZufZRReVAWolCk9ed98c4h9DwK6jt04ry5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fty2nhjjsZdUeeUY450vnJdxkH4w+urQZMb7XTw1Txk=;
 b=fdAgT9t51BEB4+nk/ovlIYUjKzNJBbrEvXt8jZ7XB1RI7aRdxSCmnjxc52iHO/lTMD2HMxlXA2yIe33sp1K3ncgOA8gV/TBy8bADWpxV2rs76ASAnI3ESfLTNtS+f4NmbwEYI9zLYHp6JmlUpWBcmXGt8aIODo6kbBqrw+d5pnW5il/n25mdYSbutORef7YxVIpQMHvZTo91uhKaZK64Bjxfvf2V2ugXox8mmJr6kqm4PiL8tmTOm7SLHLQRr+lfYKriJfGy0lujHsXDI++UZCFQw0o7zQ8/EAViDeOeYU/wYBcKE77/pT5yy7ElvZ27yjBKujSF1bsFUTDCf/TImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fty2nhjjsZdUeeUY450vnJdxkH4w+urQZMb7XTw1Txk=;
 b=WTRlw7PAEKKcLC3hrpX8sm28zuYrlcVJCt4sUdC3ywqIld1Y+Ra9YPiJ03tkiB+N4fvNdlD16wbYlShBCWskMKyNTsGXEKOewTLxvJcYxT3gIiUEAAf6XhgVHeZeVs44frts4ONSseY/kyiXinbUE6I9+xaqUrrVW5yl0qZcy/Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 07:49:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 07:49:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amd/pm: disable/enable gfx ulv on UMD pstate
 enter/exit
Date: Mon, 17 Aug 2020 15:49:13 +0800
Message-Id: <20200817074917.9607-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 07:49:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 488c4800-7d36-48ec-cc1c-08d842821674
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452A8A715BA1FC8D3882FF6E45F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LV77T1d1svnUZ2q4V29fPHkrYOt4wPdnreQOOgfZGfOPYKk7TetR5lOHQ9yBgZLk+5J1mRrwYOJcVILthbhXsWUtd9XrZxol8o4lqsiGY+FC51RY9Tkao40E5OrwBTEsZ27xyHo4Z9uEbKR9AlnGh80tty+tctOxBxKEsr5z4tCtUaVCxQdToslcFLRIMWXUeGWItzaeBh6ppai4W0eRGfgZjcl6D6452wc3gSm12AvQLjIGbrq+k8QRIQifrquBVjqjTzB4OpBwipzDueaXNgXFqXZ8mkKA1NeHP4fuXzMNJrxkdB6GH7tmtC6qqWTM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(4326008)(86362001)(16526019)(6666004)(186003)(2906002)(2616005)(478600001)(956004)(8676002)(6486002)(5660300002)(66946007)(66556008)(7696005)(316002)(83380400001)(66476007)(8936002)(52116002)(1076003)(36756003)(26005)(6916009)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ooDmLJlcxRjcdsJlvYRmil5dxDLCi52mikMi7POO9rerIMH7QF/v4pol/DtO8cTs+EcuGWFQhvAqEJgLYdBmOICO/nRNdD/7oSsoh0MOS44QncXlOAg4IYVsIiLLZF0KtfvQEavu6OxuWHDUCOzKPClFPIXHJrpz+Q0zakXd2HhuKNGKGj3X5gdQr1oPXaSfB/01QYepTiEVpCtFIonryyFJ7Gk5Fw/eBxelw7WiMXwT5D543DJyABG8pGlIh9hGGNuHbEPQC4+p2wfmNviqFXMdlyd9zy9VulWixGeMmZKK05aVHzQqWa4AyrVNoeoiURDzcHQVzwoagrEFVH7rEq6LMcC8XI3Cg+rDna/5w6P3VmskmXgvJuwLyKA5vKywszNP+8R+3khjaJFgbZ/ouRsvWEWUUAWUKq8aYszAHxLXHIc+nuRvDItg9E7gFYPCwjyCn+ZxdOcKS3gzq2I78Hi/TkXtWFzWMqUUN2KyFuwsMVYoVZbCAnJ2QGBFq6DUkXokPHCXOOdn09zFU4FP68KDCtQYUIsW0BByd5lT4yZntAKOCYz6vaJpDJ1XgMlacBNrPfmL+jcUJO0KGu0Bfo6qiCzy4RlWYornBu91qi46S0ofbaTd3xmUHdUQhVCD3n3Z9flGOF/wn8gOhvz7zQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488c4800-7d36-48ec-cc1c-08d842821674
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:49:36.6188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWPj0Gc1ejn/DCicpj8SegejxJyD2xVbhfj4ha7f8svJo26dSL2bso5STLNgLkfN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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

Add gfx ulv disablement/enablement on UMD pstate entering/exiting.

Change-Id: Ieb38fdb5975b563f24c0b172fedd01acf99afb10
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index bbe4a343e9f1..7cc707ec21c3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -596,6 +596,7 @@ struct pptable_funcs {
 	int (*set_pp_feature_mask)(struct smu_context *smu, uint64_t new_mask);
 	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
 	int (*enable_mgpu_fan_boost)(struct smu_context *smu);
+	int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7d17c4f1b489..221b5c923ce1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1440,6 +1440,7 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_UNGATE);
+			smu_gfx_ulv_control(smu, false);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
@@ -1447,6 +1448,7 @@ static int smu_enable_umd_pstate(void *handle,
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = smu_dpm_ctx->saved_dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = false;
+			smu_gfx_ulv_control(smu, true);
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 264073d4e263..2fe29c6a00ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -92,6 +92,7 @@
 #define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
 #define smu_get_pp_feature_mask(smu, buf)				smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
+#define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
 
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
