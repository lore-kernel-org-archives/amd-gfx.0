Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23FDC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F85721D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q8cE5xC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F85721D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534DA6E947;
	Thu, 10 Sep 2020 13:47:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA9EF6E93E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ3KGkjpleXX8ZvepozMfv9q+Co3zF/baFz9k5KIlC7Qt5DIdOvhLuSPIT9JLcG68npXwcrbQXwNMAFbKW6E7IA4sCOIRatKk8Hb0Vxj/pDW4Z5LU6qGzce9C+xADbCRoML9DH6mtv8NwuJtG4bWFFlB9E1Y5v/t9YvqcJK/u2Si/42gnohSo2F28joqtp/c4bf7iylTheu888nndOOETbtCSAll+dnnvNpQu6VKwlT8m94LcGEWC5JNA/6iOVhMMrMgywbeUfZyOMl+IPtDkI6hjXa/y4XmPYwSt1ED319XFQk8at1dJtlpa2uQw7y4fuhM6s+bxVIviw1WX4NTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXV8intqLOZp08Lfyn+ivHDWnvc3qvsSeQO/tLmH/Nw=;
 b=RpJGtLJtZ9SO4+kj++0x8lK4cbkmiQ5DcWZbroLM3GtV0dUEaptUbmdz34qP2jlDh1UnwVPduNnOR393pvhQ0RZ+8xzEM8N+K002M12MFUXIR4IkJwK6QNBG81vH4xgrANkGZhf6FW4S3N1ZkZ/gt5mkPtuE6Q4iaeqwwv/bxcnihKZWPPrm87EnG6ykKCaSIGHetcEDgr+cv/W9zeMp2IjWG5/zDy5ruA9KwvS15oeN71UbjTq4sLLUfbpe8Hhft3tpZdV6yrMUVxUd0EDTG9qIUX5YfKFxfsfnNxnGL5sUcdHYknonfo28DPlBiJ7nEVMKbB3rFFYGm3mKT4p3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXV8intqLOZp08Lfyn+ivHDWnvc3qvsSeQO/tLmH/Nw=;
 b=Q8cE5xC2/0varqWAMxDBn/AJkvz3x4LwhBme/ZwIBcG64l0CnbKHScWQn7N6oLgY+7yzEuSUSVMcc75CzU9JYQUAdRWrJRaFY5Ara+OjGacB0aWoNpRhJQW4pK7GfUrxIu/Ec0ixUQ96Wy0HlVOMUjHpfJTJHSOzYiAZafye4wc=
Received: from BN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:e6::32)
 by MN2PR12MB3296.namprd12.prod.outlook.com (2603:10b6:208:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:32 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::6d) by BN0PR03CA0027.outlook.office365.com
 (2603:10b6:408:e6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:31 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:31 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/42] drm/amd/display: 3.2.101
Date: Thu, 10 Sep 2020 09:46:52 -0400
Message-ID: <20200910134723.27410-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48591e4-a301-4bb0-c4da-08d8559010d8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3296:
X-Microsoft-Antispam-PRVS: <MN2PR12MB329665AB8962D83E0A2621D38B270@MN2PR12MB3296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAPNAFylhz8M9aZlP5IiQtOZlmUfTUVcr9fU+vTV/5wWnFMR0eSm6zMSs2yQEI7uiwq25Kdhq7L4GKxivlS8pC8ttWUpXESTpwgh7WjxOeE1RvlLSEfzKJ6G0neGJw63w+4U7C+DUtrEfEqh7Jo5NrvOWjBf2yqVO7zXwwo38WksmGA5vXFwIQm4bjqtyjSXW/aVYQFrkcQfw2KxHpGjOLkfloJtwoBv6iTWvP6xmSSd4H/y2wSK/6/h7Xio9M33NT8QJv65CXEoqQ6nK2dsqVyi709Vibe8EFvkomkH6aJDc1ttzgzTioQVP1jkdf7X0hDb39I0PtwgnfuC2TyhLMf8AibiwVywzF1d83ueyIR+sVrxPUn/qV0VseBOlOyWgxNx3SW9To5/L4yhsnKntg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(5660300002)(7696005)(2906002)(336012)(356005)(426003)(70586007)(81166007)(26005)(36756003)(86362001)(4326008)(82740400003)(47076004)(186003)(82310400003)(316002)(6916009)(2616005)(6666004)(70206006)(8936002)(44832011)(83380400001)(8676002)(54906003)(4744005)(1076003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:31.8788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48591e4-a301-4bb0-c4da-08d8559010d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3296
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
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
index 0607122e04de..464f2c657597 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.100"
+#define DC_VER "3.2.101"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
