Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE9C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C968206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MJ0KA07Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C968206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3386EDE7;
	Fri, 27 Nov 2020 14:11:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971B56EDE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlTnsvI+izk4EkTuQybrDC7to3J7uj9ywq/buDrJpOnwWdGgq+7wNtV5VZjdrDq3U4ZFvt7+0P73tJv3zRlNdvWAtNc8aDokbnZWasAn2P5zlj6vlu6icFyGZF/q8VnHHT5K/xItqJttUAmFDv+Za7IsYFZCwO10JMEOEX8Xgkh7BXOYC2e9p0rjJtNEjgzPq/WA0eDzlJDIQoeUNtaR/DAAs/IeS0C1ZGRAQXhrcmoIGlHTtmJ16fkTcYLNPHSuk1lDrEqtioVWzRHM34s6MfwAQN/IKem/BTQNKE22jSOozxSzlJHtm5ck2CbjcSWduOahjl/K4Zj0jC1anvsM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK0/myIdC2FgYe98vTanQPRsy1MoVPkb7HZcc3Z7NAc=;
 b=IOJXRG/wo/hgqvTp8baOV21JGRyliNXoPbO/tFcFKjJl/1bo5GjY/Tc4EcoiFVyoXgo5josZb4yC0Fb/1hlueYFRVsoo/vf1uhP8XoocxTBV7zYtnvSyGAw+PDeIGTgc+CbbxYs4/hdtLnfNRAZ8FhpByVQNEj9e2KnFvHHzdXhRHfwDgYSRnmPVtK+gkVuvVqdrnHT0rkVkXkiIyOpxIWg2GMhfr0/53R0C86EaM5Wyz3RV2vVMSyZ0LK/PMoA9xhteYA7w5BgLaqDAENoA4sTi++3YX9bspmokQ+nkH3wsZ3dfdU+VneLV1PwcO6axhUZsnRuyqtQP+t+yCFJ4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK0/myIdC2FgYe98vTanQPRsy1MoVPkb7HZcc3Z7NAc=;
 b=MJ0KA07YoQazLJUsTPiVIJSgePp8xs8fB52Sh0NsVexBReupue/7Lqk/HT8Y9woyyPeQM5kLbkrwwRfdYTqLibi/NCQxTu0xdaM/b2rhgyIN90wcjiXeUZhFmjhqMpePguenBp5P/TizZQfQWHRCSivU0gxNFmsB1fvkgb9PYAY=
Received: from MWHPR15CA0069.namprd15.prod.outlook.com (2603:10b6:301:4c::31)
 by SN6PR12MB2653.namprd12.prod.outlook.com (2603:10b6:805:6f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Fri, 27 Nov
 2020 14:11:34 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::e3) by MWHPR15CA0069.outlook.office365.com
 (2603:10b6:301:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:32 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:31 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amd/display: DC Release 3.2.114
Date: Fri, 27 Nov 2020 09:11:07 -0500
Message-ID: <20201127141107.7731-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5124eb2-b4ed-46da-792d-08d892de5891
X-MS-TrafficTypeDiagnostic: SN6PR12MB2653:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2653E3F68D77C8AA277BBF808BF80@SN6PR12MB2653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Js/mpjSPCZsnyY51NHYyOf+adOPckaTCH1TStne/WJ8ojOKgNi65XKLNvxw8GosdEmIJ4FkfUniG9QQNtHjTtwDw7ynxRrDEFlkNAMMiX7TUZefqE9kmGH4UeTuKaUjj4JdZHPutyQYNEJXCib0IumXNGasnlRyHQtiuVi/AW145lWsBRKITkBz0bVSCmo3WrZKG8RlGw5xl6raFiYAHSTcQnBDH5s2ItzQImv6JtarJjWpJdYx6m2G5jRBsZyvxzxzR0tY+ReUbhKxR3rGyR9EdJrNFbbJSW4itH1gG6B1exzERHh7GkPkpuJ2NKGnQHWGPvIKhrfTGfzp4hDPhLSD7jyFPLIPSTpJUBEsEAl59+dzRoVyF0zYUOapARjg0p23BRoLuEX7uRb+7IAvpMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(478600001)(4744005)(4326008)(2616005)(5660300002)(70586007)(6666004)(6916009)(54906003)(83380400001)(316002)(186003)(1076003)(2906002)(47076004)(81166007)(86362001)(7696005)(36756003)(70206006)(82740400003)(82310400003)(8936002)(356005)(26005)(44832011)(8676002)(336012)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:33.7529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5124eb2-b4ed-46da-792d-08d892de5891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7400b0b449eb..54a829f95346 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.113"
+#define DC_VER "3.2.114"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
