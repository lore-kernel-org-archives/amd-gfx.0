Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11FC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347492082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LFKqfExe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347492082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F566EA30;
	Fri, 10 Jan 2020 14:47:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3876EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHM/N4109ETZjRcvUUVorA/v8NxCxkbaLVkhegFkFVkOC29k4sKxw0hB1XjZnmsk9r1qL1Z4qVi3fQm9b+LVBqh/9n3HLX4sDg9M05zIJzp2JGQiDL+C5OQbrItNlQ0WbQgLLNWEIaa253URU50Of9Bg+D0gndMgY5C8BeC8IU3ZJHR8nZ3ynym+xpL4Sg8+F4hMODBsnCnjsfdbtT05uX/KuRybakbWCi04/aOo1Zz1zY2rjjEYv3VVLKm2LgbLDx5gRZuFywq5YGtYTp6P4x7Ss2fq3V2aEBrQT7bB7JtRPl/3OhSRBGTpVT8Rc5uNNzXRvAlmO85tVsYTiMwYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq51REvj48zef3VxhWv1BMhcR9OPDiO7X4aBJHLTmkw=;
 b=cVm7rGZpF7V3GmyWmnkT+BqMO19D1eIGv1sVHxbX5JnDWO2cG07HfbWJuKjAsZ1l0Ezy75YP8JTIm27HaJljriEzt5TqfJrUtK3A8On9Hl+uyVabRhj/KlQlWfgwCz6NQz8XUNKagiCLP3+shuH/x82SMdIOsJk1xTqq8h2c1wM551SNeXaULhe26PmiXt8rK0J0cB5it9FuhTEeHabHdA/GIE84fVuoYhOfkHhBEZtAMPcBgUNIE0QylMFgMVFJ9d36oRxP9mTcJLm90uE+m8LYBiEgmGjnAS1vv5uAQkMbvskaOessMpAqSNT2A7o8/Fk2TYO9MZuAJbpXAnkP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq51REvj48zef3VxhWv1BMhcR9OPDiO7X4aBJHLTmkw=;
 b=LFKqfExe6sefElpQJ0V4FwNSszAc2qGsd03wYJ7XqrCaxPt2lqZ90+qJ7aucmbgrArtWpN5Qj6Z7CTbLcg3FVEV9SxanlSeUzQA2kIbsHki74pBsb30wBaSaO2aVObV7YXuGDU7zI4Hb0saHlTD1KM6oCOoNwmh09c/LHnUyyP0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:23 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/43] drm/amd/display: 3.2.65
Date: Fri, 10 Jan 2020 09:46:15 -0500
Message-Id: <20200110144655.55845-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:22 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4248288d-f022-4a07-d73c-08d795dc008a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524CAE0536E17895D02299098380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(4744005)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvZawkxWMZZLf32OUukOubY01LxQZswu1RuY9sXFPV93dJErrXsCQG25u9V3DOS0MabxDXAV8Z1/L1rFueweAZ5KMvLXGdWHbV/WclpxBuXJE2/5MDrBfSxX6Cnb0Zu8N6rOZpw5Fe4gH80P1EvWtEn8f4FXdH+BqRzLYlqReiDqL9smANjyf3fWmNMu7HFs2HCPbsmGYBIJwYl8AS6CFaSBrVVDfXQ5KzfRat55lNI62nlZFGvaqdgOICJAy/tEs16GoAlNxTnSHU66Q8JIQyQHq+Lu2gl13TtzRGFIPek4NXLFYwKNN6l6mIyrsvaPQTahN97cfO84u5ay46PSB0XFVBWjxJcRtEZ8F7qK8epywS1inTwywBiaroHBtpjsA5432RsRgyLAv+ivRR0sLTNPdIaPScSSZZ/6gx3IwLQNbyI3VgA+5CoOuYDUJ6gu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4248288d-f022-4a07-d73c-08d795dc008a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:23.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMzHt4yumDOpDezXNmsFtx1Lto0a1CB+tNQ8nsdnVQeyZk245X/h8c/AJW/28e2nB5HOPQl8oqzmYxVvI4TyVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 039004344dc6..c4e6c696f06f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.64"
+#define DC_VER "3.2.65"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
