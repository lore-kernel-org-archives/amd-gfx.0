Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9157C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B29E21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t1NyKiA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B29E21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E3F6E959;
	Thu, 10 Sep 2020 13:48:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464D96E938
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3ICU2VQvKV3BeMB04UZwrFe8ili6Q4inT2qW+7P9B/owzfc7X2XsMa2LuPFNuUid07MvYceRVRDYGqJjWgYs2NUN06TEWnnhdG3UK1MnjdFEZnDwaXgLBbbFbo11cbmkZiFNVlYN7R+uRHfMZo37gwHFJOSpgmdyKSrjrDcxOImGVDcv9BVJ25D1RFpywTGvwtzhD0FbhP2CMSt0GIGOgsQkr4+KqArbyyz8oLKX5J2EgCAIXSxEPz7UkY7v+37oJ9x0LhuTDfyEZKuQGpTysz5J2l3HaYkXk/LZ/yzFXmBK3yBCvURgAI9Ee7oHHat77ijMW72GKAnEVsZ4ezNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p7tyymQDiY2IMe61C1lhck/JbACBZHUA2hck+y5hLs=;
 b=D9c+FKS2Wle3Mn/q4ZNinNAyym2o9ZOe3UzoB+KpWXg4rGjExNSNPFjVPpC+f2tSRpGDG2Y3rVeO6+/6uHe3dyJtFjiYwu0fclmJEpyVFgBZnY0Qrf6GkziSp8qhXW6JbQhuoKMeobs+mctK1TQZHXYgGEMX8ntmAtNJ9bYhbWB+BGewqD34dLSrlNJr37vJpBiceQdOxf/ZKRCURaPm4U/e/h0RdiRwmxHJ2f0FVXFAB3JrO1BWhQuDBQvMgAG2hEguJOOeNJhaj+JMvvc7MYNGNGqKqwuPxOwHHfJOcQNhYPZb5nsHpAwRMtW3rhUUHds8CCPNc/8YJ5R9lvsj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p7tyymQDiY2IMe61C1lhck/JbACBZHUA2hck+y5hLs=;
 b=t1NyKiA0rJ5Ir655XV1fewq0pG9pMM+Vz0Z3wMKt4D7DcBrj41+S05glaJRqrcegatJxXGs7dj7t0c/jX57LzDvzB5lekEugLxJWalpqmT7dI/KxDq1ziPJZJxX5mjxiAtmc8FqZacES/3DgBwvzbGAE531NCi87Hds2DBtH7S4=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:17 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::20) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:16 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 39/42] drm/amd/display: Further fix of psr eDP p-state warning
Date: Thu, 10 Sep 2020 09:47:20 -0400
Message-ID: <20200910134723.27410-40-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f0c68b-fecf-43d4-6ad9-08d855902bac
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:
X-Microsoft-Antispam-PRVS: <BN8PR12MB294883A32289E105D3B2108F8B270@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJPhCA5SJu8EtSHInEsBKtsizpr5+WJi2eJa/VLjpGQx20FRGaCVETvHdrsD4LcDOm3/YHtDoUDNe2Lx+pi7lhAjVc1DufZ/uMOlRkpiE12D6gMPXh2VYuUB1D/EYirVpdi8B9qgex2DR6W9pXZL8G2NaR8DG8bkRW8RIoQppfKwWY8PBTR+8VsJ1Q5sIJcOf1EOByfk4EpwJFu3D9ZYL6s1cXl3LhObFs52fKpeIE7F/tDVNsKPejYvz9mbrR/v5/4bIdf/6fTrBSLCKR9dpiwviNao31G+jRhWSleXp/8Zifg4BWfmfSUEv0Zp8f9rqCMGAgFRW/IBEp4j6igvshUIjZaO02tsR3cULz4l0ClML8iSmDkdWoXXFEbdO4W4Snsq9ifyKKWWnCUV1odASg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(186003)(6666004)(8676002)(82740400003)(356005)(7696005)(86362001)(81166007)(478600001)(44832011)(8936002)(36756003)(2616005)(47076004)(6916009)(54906003)(26005)(70206006)(1076003)(336012)(4326008)(316002)(426003)(82310400003)(83380400001)(2906002)(5660300002)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:16.8856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f0c68b-fecf-43d4-6ad9-08d855902bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
psr doesn't get fully disabled before hitting hubbub1_wm_change_req_wa.

[How]
Pass TRUE to "wait" parameter to get psr fully disabled.

Follow-Up fix to:
dc: PSR eDP p-state warning occurs intermittently after unplug DP

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7ab82d6a5630..f01610df8045 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2986,7 +2986,7 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 			if (enable && !link->psr_settings.psr_allow_active)
 				return dc_link_set_psr_allow_active(link, true, false);
 			else if (!enable && link->psr_settings.psr_allow_active)
-				return dc_link_set_psr_allow_active(link, false, false);
+				return dc_link_set_psr_allow_active(link, false, true);
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
