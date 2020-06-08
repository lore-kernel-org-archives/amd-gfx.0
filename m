Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE18C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2143420801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VQTuRqEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2143420801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44E26E48E;
	Mon,  8 Jun 2020 04:59:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966756E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbQ/iMoN7XFwSVfG4XJNeaLGU28vWrpvZ5hvTlN0tV99ziTlNbBNah9+h7cBh9BwI5gXqgPszag6n1t4CNiI6IbJe5IW7KiTabK7IMp5gSayK6ksVD3o/nzQceaBts70rRSp7g7DxHjEW7Ei/oP5Ikw3YM6TokPUY8E53noqyAKzU6unhtSgksSrpMFvg/Q/HE2QWXs5e5wuQeuHvz2dUVxtTPeXtARVWIvXlNoFbIQp21YlozQEMNLS3ATZLZ86CJrQQLohmv4mFR1/e1C9cYTYRbrO2qSroUMQojdSld68n6Db8ktzhflTxI2o6JV7c+FW/yYrhi0LPy8Ow8y3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI+phcdqUkKRKdFaxSL52yYVDX+44yBMOdFWD+qoXzg=;
 b=nDcaaTF3THY5awdAO6n7DPOEPN8oWc+0U7jHeYs2Lcx3WDGoJpnkYLXoIJiMqhHRSgrI+zQmAlYrv66DTdV7avmSvZQoeAPXqCp8HtJP5YySmz5UODC4hfqfrKcvOMkzCWE1soR+fRaHQh3ue9j4gve6cGplBwtgzGTywWoKOcpjt37QDfTj2838VQxY0jEFq5q94lHf7HpQPph+1UVyuALh0yXFqdBmP+29le4KSkYzV6VXJa/jvNVcG72rZcQB7q7KCIGGLgM6VXYdw8Nyr6g6WAvxTPGQRUwOenfepps434MSQrLdgGPR0zd6M7bLnY/LHZRBk1+GnjgxKaRQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI+phcdqUkKRKdFaxSL52yYVDX+44yBMOdFWD+qoXzg=;
 b=VQTuRqEfRc7DUOE038Xe6ANy/TrtOXlr6LR4vvrx6dxQvrcbFvWgm5SpxB9R9gGPgfIqe9HXnQP1R709p5dcw2dFfAFFpQdsQ92j1gYKRvZDH/6LWg/M7jIhWqgl+h2Oo/WU85c2gkIIlMkOvFEnOi69zbQAnsW74Yskz3aGZio=
Received: from MWHPR04CA0039.namprd04.prod.outlook.com (2603:10b6:300:ee::25)
 by MN2PR12MB3488.namprd12.prod.outlook.com (2603:10b6:208:ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:52 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::f2) by MWHPR04CA0039.outlook.office365.com
 (2603:10b6:300:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:49 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/28] drm/amd/display: 3.2.89
Date: Mon, 8 Jun 2020 00:59:26 -0400
Message-ID: <20200608045926.17197-29-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(83380400001)(82310400002)(356005)(8936002)(47076004)(82740400003)(316002)(5660300002)(36756003)(2906002)(8676002)(4326008)(81166007)(26005)(6666004)(86362001)(336012)(54906003)(4744005)(6916009)(70586007)(2616005)(426003)(1076003)(44832011)(186003)(478600001)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95e74e5a-476b-4e43-f194-08d80b68c729
X-MS-TrafficTypeDiagnostic: MN2PR12MB3488:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34885923D75C4C6C4F017C4AFB850@MN2PR12MB3488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDVDB/PwjHMvAOwHN1bd1XZohfAB5N3QDHezF/NeyGVxl1XujUIqF3nGatu7phvzlO0nVb/MYW4qTJG016GS8ezeCFrY5Tr2/RP5jXKuwIRgZ+lEUHXq06E5uPI9zZfBWgHIMlPDnJ7g85qM0kG5bvi/94gsUilpYjS0h6N8KIWt0/cf3MMZ4dKmjLQ9zQ+MkRDUH6pyFMGSk59dAJADZV1hEbScjnKLTA6TJV6LkmXlvprlDLwBlg1QuW1T38cgKsNa/m0L0Hm1xdk4kjJYu1mGb8+i0GXQdPiXyXchvIQpNozJizhS9dn+TG9LmFj2vNVx6LF2Oym8l9tJJKAGT5mYVcOKQjtH7QVmt6hJK3YTEQRQ9tm0v3759Jqjxp8zkAl+sjWyg2O06AOETHMeEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:51.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e74e5a-476b-4e43-f194-08d80b68c729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7da41d465a34..a45b5ea98918 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.88"
+#define DC_VER "3.2.89"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
