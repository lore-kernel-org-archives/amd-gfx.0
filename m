Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746EC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47062071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GfM9zYka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47062071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268AB6E11F;
	Mon, 25 May 2020 18:13:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E540A6E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNCPVJTvzzseOBmW+mus+YhkKZlTqltK8sutbAeRKc3IjdhpZjlaAamjYi/CzwS9ZVTihUux+U2JxrSb7nscq7frs544WMcs7x82NgfCvrdxxbqgt1WPrKu9tfkpco+v9qFEQusgNw3SN6wJ1u48M+ZcDVu5ow6qu6/+EPA5cxSDL2bZo+Ps4RA3YPHVhaL2pyfrVON0bSlbjLqRgDuBPPqIL/z8DPflQhZ2cJzhBSIWjGqzu/XmiOE5ZJEV3/EUQycblw7+wC28GOF9FeRu/fC1ctco+FtaBNaocIZWZBXyNf114lAGT6H8+TvoPxM/ocKSb/NTcJZTXhcw4MPi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vus7MwYEab9kGePEN1KMGRljKeL/fPnlr3SnliznRqo=;
 b=fAhXe7idJCPwZyX5vsDjKDXmwPQkwRgFZPjUibpMa9GKD9Fyv/Ls9BvDQ4oRCSrFGGmWB4Sg7iXuh/XRkKEfn0VcG1T+nrN760nhTXOgF9spW7HnvBR9WaNNnsS9KtptySoE8G3MNkPIOTTTytFnzfM4qAcKVNxghUQ5W/yYVry3ON8l7UL7AItA8L3ESg0fMdLW1OZh3nwvxGeLLiAZtvyxPuCz0K6gUu65LiNRqCgIU0q49Nh/sZvMyZ0UWLIOya2vSz6gYxrRyZnoyLiJG5gOQhBCse8IfUZEHQrxF8mMq91kpbmXhhVba3OW9ledm2ZMgaKVmKNUCfBUp9CacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vus7MwYEab9kGePEN1KMGRljKeL/fPnlr3SnliznRqo=;
 b=GfM9zYkatRdM6HRpDTa1ynmSTZwAJkptwYe6G9DOVi625DGFGBT64GFs3Epd5DHaSkPF4qmVdQiQh1ole++Rl0km6L7avS9Tgh9WV4j8GO1q3RNLqYHGI2ju+/q5vdmkf69g3e8VO5abLo4Uvuqo+3xFddklAweIbdbTLAbfB+E=
Received: from MWHPR21CA0064.namprd21.prod.outlook.com (2603:10b6:300:db::26)
 by MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:10::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:21 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::6e) by MWHPR21CA0064.outlook.office365.com
 (2603:10b6:300:db::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.2 via Frontend
 Transport; Mon, 25 May 2020 18:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:17 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:17 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.87
Date: Mon, 25 May 2020 14:13:06 -0400
Message-ID: <20200525181306.3749-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(8676002)(82740400003)(54906003)(5660300002)(4744005)(478600001)(6916009)(70206006)(47076004)(82310400002)(8936002)(81166007)(86362001)(356005)(2906002)(70586007)(4326008)(1076003)(186003)(44832011)(426003)(316002)(336012)(6666004)(2616005)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd0a0512-731b-4fc3-e031-08d800d74ea1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:
X-Microsoft-Antispam-PRVS: <MWHPR12MB145591DCCA1ECF9FF3A51BB9FBB30@MWHPR12MB1455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIs4e6xhbnhKddhLxlSM8qNt+TUsDXn0JFORIB7yxsbxeYcyk6L7TwLCFZ+En8zSYE2jGQhUn5meMekNRJrtA06lbSPhbSmPM+Y6nJyES7RDOMsBZ+DccMQTfQqm8FM2wpf1+4sztfmie3RY8ZD9lEdFyVxJNyWy0ZtK8+LP1TpKK8GQqOodxSprBz5S7K4zXGucADLVt3JO6Na0oZHJguFgACTNo6Op5pJR3Ino8bl+CNK6w9lJgEnMrUBFWQTdhTCp/hDbaEc5+k661NEWxN5MLYf8Y+aC/Ox30kfICnI8c+NhEx20SY7sQaoWDGqd0XeNDSWUiMNE+0D+lsakwiRI3gfi3POji9sPpiGK//yoCa8ILTOCI3cy+BEsCn30Ve69RrYJF8L2oNq2riS8YA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:20.8536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0a0512-731b-4fc3-e031-08d800d74ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
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
index 687faf83a54c..ecbdca6d4a79 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.86"
+#define DC_VER "3.2.87"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
