Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9F3C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 09:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D74B20B1F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 09:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="36YKENZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D74B20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E3C6E183;
	Thu,  1 Oct 2020 09:06:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504366E183
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 09:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I96ByhXhjZWfyglcyJSxt1CKnfgcPW6teSQ0uMYL0VhSd1H+JJKGBKBvpc/gGcN3y0ma12eDYDQyIb3/Lo3bGij2ovB+QmtenYf8+6oN1AVFYLsbvkwIfMqvHdImbTLh6CTcNB8d54+rODrguqT35xEdZYrLV8baWwRu/8jjjQ1w8GpUKBjPaI0YRVKJtXvlmme2FWrET0X/fEWmUITSSbFBPkhfRDtQGzW69M2XPZdAbYbsLscHkKecyFo2UFUGg99IFki86bQ1qlOjntBpY+GOivOZdY1SqBCiJTe/bN7+brjGFr0TX1YuWXuWSdAqccdHJmjTEEA2VfYi3zTAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/b5lkHghZyqp4STVLPvEfv9XUPRKXSibRAZzqiMzyI=;
 b=B+KrU/6ePNocWXx4dsTwFzYiJBYw5ccfOO0XcwOetq447nHx8Ej0y/gV/wEv8Qd0Qq8Ls7vt86OY2gMwxHUcLrBqXkLb569ZnavOXFlObbG750VMnBihBPPTGMBuclsSsZ/ALVPktziiagxy/+N31HjQKONzaVSwnx0hYx266sPZ8w5dDgfXcLMGofrtD2plghMQQ4QPYciJJg85Rnnd4HPC2MrnrV7ayv2VtYCpLuTsjy/ynzPPTlJmMee+Lv5ZS3rOdrFui7v+Uw3elnGzq3QEV7Ku345YhLipCK2nJV2MOA8PPcGFHPJTNWwxgzEyKghZLbvkftBIuWB91UD/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/b5lkHghZyqp4STVLPvEfv9XUPRKXSibRAZzqiMzyI=;
 b=36YKENZxUclrmXX3Tw9iMgqn2P21unHH2XXhyHWVhe4BVVBEv0CsOb4Fz5II3Y5YRGNIxSlTvGq8D1u/L9W94Q//ulEBIfPTocB4vd9KbZad5YoYfLYh76FVkm1nTGDvXEqeNz+6dYJ8y9E3bRBLNGZLrwM/cRZ4BM8vMGp5Pc8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Thu, 1 Oct
 2020 09:06:28 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345%7]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 09:06:28 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: nicholas.kazlauskas@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix external display detection with overlay
Date: Thu,  1 Oct 2020 14:36:07 +0530
Message-Id: <20201001090607.12481-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Thu, 1 Oct 2020 09:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2013c05-629a-452d-cc78-08d865e94795
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36133242724A2821229CDC0680300@MN2PR12MB3613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gi8lmQT2iyxFoA8gGEgGyAWPaULInWUr+YbpgHFDj6Vjs1txHlXeckE3XfMILwiiUlKR62u7MISkox+Lb8ljhW5RttAyCWsPxIPon8Z/MzC4MJlL05QIIU+graMU3kmhq4FraP81rfE2JW5lKjVno8QEW0cgXTy/XknrYl813lMnQIO1hJb9DMIOAGsFivyJITsRoKVIOCEjEgLNtYCGV2Q8ki/qG4zLjE+GKs8EbcL/9SLW0BBcWwVKNYj0I09PfXugFPV/h9UUez21UfV8Znt9flhUMV99kN3MOkDiqG+NnW+pUlR/qhtd6tExo3u+FXc1L/XQU5+fp3TFrh1XA38oqEj1rxVb87F1SFpDrIvCDAIFIIV0gNqHemj6xhm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(4326008)(83380400001)(186003)(16526019)(8676002)(36756003)(6666004)(956004)(2616005)(2906002)(86362001)(66476007)(66556008)(316002)(8936002)(26005)(7696005)(478600001)(52116002)(66946007)(5660300002)(1076003)(4744005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ihhaKJu4jbtjPH95SLFV3fC204u8WAjrwZvgc1wUYbBqpBuaRV5gjRZHfurpfplEvg0pcSc6o8xZdMDazgEcu3E16Ai88RM+ahOjhaRKdzgVNPo16gROs3d1exy+OiBshsAKTk0rDmKtAJhFjYe2vYox6AkQd1iQz+E/9HlM+W0iai4C6WCXkOEX+06OQMzwDI3A0yhgbGDNXspMhliVv+0O3qAXH7fKboFf6ZvH12HX+LVQ3Ywkz8YCXMikobC5GesCMtfiZCUvUNc+XOlM3lLB00VTJj1sj01wIImDEcM/rwIsdNMpB49sZiUduu/YxaaGHrb7boIX5leB0X5i9gVsfqbblC8s7G6h+r+taEz5ePME1vtbF+P1ARHB1ofF1X1WZ5Y63x7sEmcfYuwGBuyypVkjaXInhKZU12xF9GMdTSpW8nQLy9l+eNIriay4BGA5/nobfLjMgiuV2/crU2CptZ/Q3RS14byxIHUTLkEcfbF9NkQGe2fai4wmZvKCPNiFiDfuAHeEawtUWDj1FamFDlRXR6L/4Q0jytdbV+X7ddY/jVuTptGR7Mb2+p0KUBAxf55C12CLovzeQElyeT/Fh9q5zllr1lhZkT/mL3R4qsxeLmnMhqTfRNy1HVt7nBBJq13boL7mYjdTFpVRog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2013c05-629a-452d-cc78-08d865e94795
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 09:06:27.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX9ilOnyFq71QMNsAJyVVh04mrVTwCXY+ODM+NhFac5ArkKOUsnNtyHIwZYmObcMBwiz/wnXd1xb1glXZreF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3613
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When overlay plane is in use and external display
is connected, atomic check will fail.

[How]
Disable overlay plane on multi-monitor scenario
by tying it to single crtc.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e8177656e083..e45c1176048a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3149,7 +3149,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 	 */
 	possible_crtcs = 1 << plane_id;
 	if (plane_id >= dm->dc->caps.max_streams)
-		possible_crtcs = 0xff;
+		possible_crtcs = 0x01;
 
 	ret = amdgpu_dm_plane_init(dm, plane, possible_crtcs, plane_cap);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
