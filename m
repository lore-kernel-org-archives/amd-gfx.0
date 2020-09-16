Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA347C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBE7208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y2/aMyCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBE7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922736E075;
	Wed, 16 Sep 2020 19:41:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5B26E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmelpah6WjKBljZoD/THy24NBsrw2LrwVcJ7dOlsoFqp9qei/IokFkwq9WfKH1JKu3ffpRR3974a1aFyNxviJT5PngUMQEEDCwYtWEuYU+Tcr8V9SMR8C94M+RhjJjVVx6mwO2GqgXDJ4Mn4vhu5NpPghNFwkQXsG7hZDRabtE8WcxlyoB5w2BwoLhJOkMD3cHktlBVLjtoT1rXo2wcrskW3mvMNtuPuDM+epSR+bk4xOZJb/qM3LgkYMXSKEiq48MZrgC5tjrJbDLS0dmN8kVF82+vLH+HsFQ/wunEFlRvyX+r2nBh0gzxaRmvmH9M+wlAMTuwYf2GFAPGQ6HpWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBJ1U5TuCN80QZDTKpom2inABfPjqqqIlIV07VeIZgI=;
 b=CFywj0+s93c+gg5/0LR/dn9FsNevO5xyZADNCRXLqasTA7AaXYLvp//26VaN5Xc1cU+V5T+IXL5jNF3zQAB+GBoeihqgPjydqXeN/Fc3fQqVJT469fN4rXc2eNx1GK3+Ch7mI7P+LdT2XI/WsNQOheRAb1t5VeCh0xsHQVeLwrtVK4HYwinw5xE3Ra6+5viwJ2zGxhJbW7k/3qNe22/qgn/PLTJ3pmT+CQnFt5U2Pd8XBUyxHDhZHyeD/JK4kv4kRclNPErAtHk7DAXmVimjRbJKZJm3KC1lPywcY5tfGBOCtJezsXXx05xCyRpp8Z8N13nvODvqYNsQjiepWbn28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBJ1U5TuCN80QZDTKpom2inABfPjqqqIlIV07VeIZgI=;
 b=Y2/aMyCGdg20VzmybafK09JpCmzyNsK2/W44nwhpckvWNBudKQCxHkjFgp0STXIMPpRhXcMaN6Jy3w5zuMrmVO8K4mAnrBy5SkXgngRu5pwZLSQw2Nw1EJJAO/lzMVjWnlmU3AbgxsqZx90RhkVknrUerHagBmRSYhgeLH56tX0=
Received: from DM5PR18CA0093.namprd18.prod.outlook.com (2603:10b6:3:3::31) by
 MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 19:36:47 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::f8) by DM5PR18CA0093.outlook.office365.com
 (2603:10b6:3:3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:46 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:45 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:45 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/15] drm/amd/display: 3.2.104
Date: Wed, 16 Sep 2020 15:36:35 -0400
Message-ID: <20200916193635.5169-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b103f76-007c-4930-0eed-08d85a77d970
X-MS-TrafficTypeDiagnostic: MW3PR12MB4346:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4346A9101902FA60D8669260FB210@MW3PR12MB4346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CKeYn5h+b9uUuzDVNwuAcMTvbBWD9lCfK3ZgwldFLAAH/uIBz2vUuFp9p+871KomtqBBv+me/wuyg3TJF1msDPCfatpIsGdCdpVV7SHWmd1xUfUm/+4VaMeH14ilMUXXglTXma/m3QGRFVilJzU4hekk7c1JhVOM2oG7QXw5alUtwGDL8En/iRJzF8D1jYgThVlOD9rMitUD4DixpGzUtAeQYxAVOiiTq4TwZ8nu3MQF7Om+aDsGxGP/Wif1x4M2YnsLTpggtpcPZX0m4SMb615k1VarUCPzYZ7oN9eCN6yOND+D4tES5JYTqk0L0/F94wkq2aVfPlYaNSEFQ2DdmiJDvfQArA8OYYX9hgt6JbzATLhUJSOlW4qMOVnKaXZKHHjFIkORcmXk3rwBICLoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(186003)(6916009)(70586007)(5660300002)(70206006)(36756003)(86362001)(1076003)(2906002)(8676002)(4744005)(82310400003)(8936002)(82740400003)(6666004)(26005)(478600001)(356005)(83380400001)(2616005)(81166007)(44832011)(316002)(47076004)(336012)(54906003)(4326008)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:46.7003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b103f76-007c-4930-0eed-08d85a77d970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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
index d65483483d05..061ca15660ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.103"
+#define DC_VER "3.2.104"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
