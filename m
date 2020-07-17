Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72222C433F2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C5820737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s/2tmoTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C5820737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FF26EE24;
	Fri, 17 Jul 2020 17:38:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D4F6EE24
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsamcBYtG9EHZSStXhqOo1KiKDRJ72NsS4sBppGHETBFZ6AhA2S1q1gdVSOEbMsIHCvdqon2+BDZaRgpsa1uNphDmnYNjoURRCo92IzDWv/a5e3Y+2xe62tf5uz2d6fyILbKf96KgW8+MLZrUgG6YrRz0yeylJF9BffHgkQoPBgOzZY58YXveT0EN9GyGb7YFrloOQbsR545EokNPp8Mtkp1zDa3n1vVnq4JBWdctGMcolOGMaOYtuncbA4EjFZ1rsxemIeRrQktC+ZI6Yfc2GqwjdXjaq+w0Qbs1DFophliLzP0aYpv+bvMnppGnxE5rHxrP1didhadcDfq6gAbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjrDCxOl+yNeBVdGACMF7sACfLe57zsOlpryUYfKQDY=;
 b=DanO8fRlTBLPl7S3P/yaJOs5tapJt/13I7KCU/o3aP0yS+ghtUJyjJ+MDoBp0FXqCPr5sN8+Qqep5gwemqWfg0TKgdqfILv9lfK96nNrVcV7GiPc9cJyqnILwnS0XKWE/uOwVREkqGZTTpNoCVOyWFaibXGiNs2AZV5WU5fvpOssSmtkfR2ZhLdZhH4cpOn/L0QgBWB+to1YvPNQ6xT94wMXLwMfelMAV9ORTqvOuu4JgagbhFtKlwVbQDMwb+p5Y+kcOk/izpCX6fGm4KNEhCbpFungWqUsyOH6gPSRDokrdINLWsWPH8QscXrheHMKhVQPWxo0dWNRaE1Sv5tXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjrDCxOl+yNeBVdGACMF7sACfLe57zsOlpryUYfKQDY=;
 b=s/2tmoTeFOCI+S4F7MRa2Ls/lyBhSLzvyRbhZeH6ic4GgaGK1+sXt5OokcdgqG+GGAo4dwVaMdQmu60nTecn/f9ztf2hcTNoszuwoYUh7BuPecCIjC2ujMyLDxQO+WpVcfX9ZF1iVTyYidD3cyjLiSVDJPw6YUu30GHPmCKwc2A=
Received: from DM5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:3:23::14) by
 BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Fri, 17 Jul 2020 17:38:28 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::c3) by DM5PR13CA0004.outlook.office365.com
 (2603:10b6:3:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:27 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:27 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:26 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.95
Date: Fri, 17 Jul 2020 13:38:13 -0400
Message-ID: <20200717173813.11674-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(36756003)(8676002)(70206006)(54906003)(5660300002)(70586007)(44832011)(2616005)(6666004)(47076004)(478600001)(8936002)(86362001)(82740400003)(336012)(2906002)(83380400001)(356005)(316002)(186003)(6916009)(82310400002)(1076003)(81166007)(426003)(26005)(4744005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bfb2b2d-2cfe-4cac-b70b-08d82a783717
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2728CD15325953E63D269420FB7C0@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHza+7Kvgm8uXgkinszmIw6XtfiYxpc13z51iZxNfljP0Zs7ysxxGZSvT6CHrh/8CTvWpXBvFIOy7R6Pl7JOQO3sb+PDPAhJdmgRp9C9EB/NuwWA5TCORI1qSYLWZhYGOwSXjyKcr/7LW5DbMDgDMRqYYekWVjWxfSuXtDFllLFdOIFiNu14C2jqV14oYii27y78kgugQLqIiMMUqcXZM6unyJ02faHzwd9Zq1z0ONz9P9bIgusL72VCRnehJLwjnijqAzfldnozG7ToQ+owJr1imjZpLGm27dLG4p5wKQFQ+2CMrnTYlQRPiPmS1uPIEYx7PGSPun88MYArBKu5TsOlP3hI3jIKrYgH9uKh7R45DW8bvDYGRqfC7kRZ1sEqF/oEJxb13O5SNTt6UGEXKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:28.0838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfb2b2d-2cfe-4cac-b70b-08d82a783717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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
 Bhawanpreet.Lakha@amd.com
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
index a5faedf66470..f50ef4255020 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.94"
+#define DC_VER "3.2.95"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
