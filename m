Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B24AC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AC7208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U+uCBAHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AC7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845C26EADE;
	Wed, 16 Sep 2020 19:42:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB296EAD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snh1Zss37ZI3JKadbbBMuJsG8FY/W0ol6UCPWBJSAfkUlFdlL84LS1KmFejXGrT50c7MP98SCxwn+NhxJdNjfesESKrvaNCecer4Mba8kTMLJWlIgb4nJ8+c17IpFe+Uu+5m0Ozhj9x8Bkj0PIXIt1TtKaWxNrIEVECFP2TA9PXeoaaT1mxDAdtLqY9/SzmAgO/1HZPewZrPuTmQU17Ssy6UD8lEVtU4kJWHOtxWZ1ZiHuxzS9/VVE+QENWlkzQUXWFW0NlImrfkx2DMbL1eUNs0iAbXWpN6IFFWcAoG+/VbtTnXhoXJjTHXFzrEiDU0DJHzHJ9UbFiWJj4vTHQP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bENoVKQPw88wjP1PnBzblW0GxClBpB4gkEHtooaes2Q=;
 b=mBY0X+WiiA3f+CSHXFBb5q41+z7QuOtQ1OPFCR/F8zF+Vdwr7wfWyyLoZdntlSvHey5R/CK+69xkmIUVTm5nhdexBbuh7DbvkHNd8c18kMsFN+z+KcPkCm92aECR1N8m94mkipExQMtz+qdFkwhI7QjIdPPz5FvMqqEd7Euuv1+RfN+6kB9tiacHo1Ho4MiApZkXGNv2fTKL+1GNiVyOyrcg6+MuzpZ0E85AlErNJOYF2BVIFk4hme8h13WI9sW45tsKsDpqurUBBQemnp7a/PsCuBPWXkedMh5QLg7OWRL70/9YpfiU55DlflLIsQPx7P3A6FY799oBUof+qX+DBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bENoVKQPw88wjP1PnBzblW0GxClBpB4gkEHtooaes2Q=;
 b=U+uCBAHT+H4FnMSX/UO6l3MqWaadHvtjIWPrk/wofJh8IcHyKjhpN4Dwfqh1Dbehc3MvHF93f6bWoQW8quDOWRyxnEaaLPN7fyR1AQwR4U/VNTJHkizzE0dEAO5uJUIemJSe0oEW7WUwB52/+xl5Q+se1nt2wKGCCPuMsDZD/AA=
Received: from DM6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:5:190::42)
 by CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 19:36:39 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::a6) by DM6PR11CA0029.outlook.office365.com
 (2603:10b6:5:190::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:37 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:37 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/15] drm/amd/display: 3.2.103
Date: Wed, 16 Sep 2020 15:36:23 -0400
Message-ID: <20200916193635.5169-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402893f1-17c3-4bb3-eb02-08d85a77d4b0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1765D46FE1ECA86FE3D5341DFB210@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4uvue8JKIFhxRlbpIg4KsrCBomPS3VkDojXZzemAE4ed5EmBJNZxDs1b5UxuNw2n2CFF2pLTiiHVFPr7mx8Fv4ZzcZ4GCmgzfkPlJVPzUymU5xkU0zQEj0HEgUMzdAEDgQrG5bJ3fATdAobOXI+eA6zlhoGFS5XI0BIF6Xi+EcrCIJDPkh7lwaOTwYMBNDia5e1mAYpHFEiyPc0pOAvzKf5ZEbF8P/VU6+sOAI8NtsBymuZQk+lwIYjBf2BbGOkekeQQINd5IHtL2tG47XhRAJn4L2+EzsnpJ8wieDQxiBm/XZfFOH2gMhXH9fQbSC0Mymy/9BXvnS+hvco86ZLwMZmPP5odSI9H/GDiF/1HR7Jack4cv+apIjEO3KyW7SA13Z5/ejQB7xHWLhDicTnSfqtDNUqqvMmOFD1ca7EEZ2aQKZMLqB0ksnwt1rkUouU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(346002)(376002)(396003)(46966005)(4326008)(26005)(2906002)(70586007)(70206006)(316002)(186003)(36756003)(6666004)(6916009)(82310400003)(54906003)(1076003)(5660300002)(83380400001)(4744005)(81166007)(8936002)(2616005)(47076004)(82740400003)(86362001)(8676002)(426003)(336012)(356005)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:38.7948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402893f1-17c3-4bb3-eb02-08d85a77d4b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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
index d9b22d6a985a..d65483483d05 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.102"
+#define DC_VER "3.2.103"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
