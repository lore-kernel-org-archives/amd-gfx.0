Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D110EC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 10:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA56246A3
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O7a8w8EJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA56246A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F6A6E4D4;
	Wed, 28 Oct 2020 10:00:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A016E4D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 10:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCpO5M9qTtGEE2+2R5EGUOmxlEAT/giKI93/bP8HEhE2N3pc/geH68hdUPzxXEX/Fng3CfjBWdLLWOWH67Tjcagcv/nTURMOiKvTYRJH8Ajz92WKrJdH40HE67bseULf2dcv4LqWEy5FvsRAOBktIcD050qc5/PJZLXi/4BoUhzMblsSZuymvPLVZFzJAUNoYdobJ42fXEIyYo/koJEanMAlDCyzwM7hOIwbO5XacqEM8WspIiTbvWdPudfrP4Lu6GaExQJbB5GGHBjAzgzsbi70m7FjXlDa8X9BC9A/ELqsSrOl1HaPZHRghd+UfrpuXApLKLeIOnMvQlVwHL9GxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWp8m07pxObGhfuWVZNrRI5ut+c1tb4x813bCegi544=;
 b=j1sXPejjxhHr7jiaTGrIRg4texMnwjQmVlmjiiG2sHtRKSujgOzIbWfWDczhQ4TA0IlbYJi6Zc2idJIh6tG3bQxkeUDP4Bs/Gg18XcHiP4CQuhX95MPgoHKbN+tG+D9M0eqCfDsKLQ6fjWPiWrKrb+zekOod4aBi7T760WnfXRE3MJHVmzf1wEqW0a3jsC3HDFx+TSSYsoQ2SzAUw9bGD/coY4kz8UkTrYS9mMNjuldqnXSjNX011i8YI7LZfNn8js2U7alntc/XP/FrhteV0inLS6yHZtzzpFkaFY5DGJrdGasBWBs7/IL+Ka22DRx4yswnGSW4IB8Lj5Mu+dDaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWp8m07pxObGhfuWVZNrRI5ut+c1tb4x813bCegi544=;
 b=O7a8w8EJueY4H0KedRT9JC4K9fu8Sv6oTZBVmqXxOTrFSd58ZjYCmVDRG7Eorzjw2xmupr5FpWVohuEVXD9+hnniq869Ol9XvExZtI5uR+ieYLZQdFSxpled3rvkCUqNqOAbtkWu2aVEcQPBm7Fqky8ziyjTl7g845KBg+aGkn4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 10:00:04 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 10:00:04 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: Add GFX MGCG and MGLS for vangogh
Date: Wed, 28 Oct 2020 17:59:45 +0800
Message-Id: <20201028095945.2627-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:203:c8::23) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0018.apcprd03.prod.outlook.com (2603:1096:203:c8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Wed, 28 Oct 2020 10:00:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3b4a3e5-4d9e-46ab-499b-08d87b283e20
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45162483077A77C744A4AA9A90170@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mySjHyMESRbqGAmsYHrMMku+9g/oNaM8MHeZtcA3gXv79isxEd35ZJWx/qEj7JbunExgDS4Ia4SZ1hlISnYys4Ma6R6fu6ChyxpvBZ7+KFLNA3/bN+j6p/izwz+dLxYt6KWCI2d2wECEHann4809jGaxyQuMqwAA/8UHESI2cqYMiRu65yxEu/o9h+pVM/7bwvFRLfuYNLa8ZHH8LiFdyf4oJKp7rRS285tyq9JPpZIvYBUR84+8cSs5HR+e6WWC1IlKSXq3mW+4miHlfERT2zm8shvbHmCHkUUfcZk59lHwSYIMilvegvNlDMe4nlxw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(7696005)(52116002)(4744005)(478600001)(66556008)(2906002)(66476007)(6666004)(83380400001)(5660300002)(1076003)(36756003)(6486002)(86362001)(26005)(316002)(66946007)(6916009)(4326008)(8936002)(16526019)(956004)(2616005)(8676002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iIZYNGtShQg9CZWdpKjHT6tA1Kz+2c5XSpvJ91VNLBLFddxGmlRpnsaeX67h1J5uSMXa1yuj7X84vMJ90NblEjy6//jXUoe07JvE1rQdumiItW5d2WOJ221ek6bkbgyXYysCCZuI1NLuzN5TxrP90izRDOU+u3r2+w7KWbk3g/fzkyKFzlmn8w4s+2ilvlXs7IfRD1lClytVOlF+5o2LN7c7oYq4E2EIblqgAxI1fw7eOZ1TggB61EN9qE6arBdrvNhe215CM+qTvXmfz8xJmK7RGdq0dbcscB+VXxEolOJakm8pWKEOPR2XeKBl5guO9omwy1/ZjUhdJXoARvtjpnc/+myCFt2sLUmG8eAD1qkd/lM0RSiXagr78OJoKhWEwp7sCOPlIAd6G4Jcab+ExdSw4ErDssz6xSq34ht5cqMJIs/8tJtKj69ZauY87Xx4KHp34Hf/EyZbrTK4njh0+P6Sy+D96hZuEeh43zq/UdMTN0b0KpApWTSFmo95MpgKl17keakqmiH+/44rHfV3i/JoGU+HJnJB4vgKiYV8g6tyj32NEjY92A+ktzaBxZrZ5z6OQg+XoRszo+Tc5CWCL2dcaF28Mvi2bUQepNLI/5rgZAn492dE0h5j3xjPiYptz9Jv6TWz1ZWSjog1BBSQow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b4a3e5-4d9e-46ab-499b-08d87b283e20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 10:00:04.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGg4mogMKDMWRjxfGohq/NnfNA1EFbBf+keKBN13B5ojvDRiZNm5tB5ULjMMHQnToW+ZSOQxcHEz5oejUfuUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add GFX Medium Grain Light Sleep support for vangogh

add AMD_CG_SUPPORT_GFX_CP_LS and AMD_CG_SUPPORT_GFX_RLC_LS

v2:
  add GFX Medium Grain Clock Gating

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
Change-Id: I38f4e36a896915f39fd7c2673e0041244006d1b8
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index c65b4462bf5e..026e0a8fd526 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -943,7 +943,11 @@ static int nv_common_early_init(void *handle)
 
 	case CHIP_VANGOGH:
 		adev->apu_flags |= AMD_APU_IS_VANGOGH;
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
