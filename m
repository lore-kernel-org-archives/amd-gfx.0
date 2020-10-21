Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5562C55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE1A2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oiVa4ZQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE1A2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728526EDD0;
	Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0326EDC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxj0uk4CWRb153d/Bc5WnDd67fO6Ivr4PJKzXAORkzasGIeQyc4SMnA3YP/WeP6ea3Je5xu4O0OLAakFOOQAVWf/xuRDkjkYtA9o7mQR8Ek6Jss4rEVMEq0hoaU3e9FSr/MeUtD8FD9YIbGnIxiLI8Av4pQBnEmz61nVBUy1k7QA1j8WCXDjmPPcRCodSl1eUEkIOaiNBox73qW+2D4hEP4OKX/uvdm0l7shGZlgvC2fo5Yg9RtlxXJHdZkT/OaUBFXKfm4K5gWNikjmeiCHFWzcDN3aOyrsTTXe+SjT3W34qzPiczUeNEwBXQ5eKL0VTFWKEYkWAh7uQn9MWwH6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzzd9L/YAfT1heG78t0InqLzlYUqrZX4GjenXd4vKdw=;
 b=nn6jfCwFFc2nAalwwTryPiVJ9hh0ZUBhnEsyRpKEh9CbJofuYrqKnjb5v2PSwPzL+ZwwEOOt9RrbfFRX1ptinVfNn0scSx6gwzxDPd5IBLNic15x/SgwDhcJ8ctJNxcu3sEw17hfHhyvUkmaM1UB+5XC1ijvRlvOLqmKVBFb5KSrPlLVskmBlbe/yTC3qqDcWgCDe9A/f8rLdStKkUqr8mQuxfElCElH1CgSdZ5NQy7XN1t3h2rJsOlyZGuCZfbs4TQXPKHPsRKu/e5uvXP2OEkhnaHUyAtY73caBvdCqG/KSdo7tP4QrDyEeh2OEDoXAMsF4QyweB0V7+z8TWv6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzzd9L/YAfT1heG78t0InqLzlYUqrZX4GjenXd4vKdw=;
 b=oiVa4ZQabIZHVtJoVYwlIoNkY/BahPQrt70VLLgsdY4d8lW2N8bIaUqE/HQjwjHO3VEC536FgP1lMx9HYRvqt3VbgZM4Mi8GdBOOh9nSKDcfSKgFg4bv6Pb4jV8OGCAE+VnRgdsVb/KHByrKsIbNzRE21yr3wjLYfW+b1zm6zus=
Received: from DM5PR22CA0013.namprd22.prod.outlook.com (2603:10b6:3:101::23)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:23:19 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::4d) by DM5PR22CA0013.outlook.office365.com
 (2603:10b6:3:101::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:19 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:18 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/33] drm/amd/display: disable seamless boot for VSC_SDP
Date: Wed, 21 Oct 2020 10:22:42 -0400
Message-ID: <20201021142257.190969-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 643a29e9-da0b-48eb-a47e-08d875ccdbcd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047EAC806B6E71B8A4233DA8B1C0@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lZPDGaMpDBa7w4ZsdM+Osw/VVApAm8+1ZB5o28OJhw7BQuOZFOf+I0q4c2jJ8QxGhFoJQSZbpN7Tn+Quw+Rq8ho2T+0k86MzKq9cZxu9E2WZEWlBhvH0v2o7aIC9cVQ8WJFssj7oMPNFQ9wwHQUcxbm2p5JC+IJne/4gRIFWoxp7Ue9njw2PP/m/kHzNmn8QPbVUfNTCNlZzMl4vz68XhSpq4lRNQgAIToFF8S66XbvUANrHVIwVOwRKXX14zDlrsvZMSUcyayo21sHk8F13Zb6+V/E5wWlyhVADmUDqcDpezcCk7uMyGCO0Wo2j7YGlNd3EaAw6qG7mpBBzgtuzg324hZ3MEZf8M1swCRs/tN0KFk8IOUqY8kjZbm2rcHF3axY2LSefN72BQGwflFYmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966005)(47076004)(6916009)(81166007)(2616005)(5660300002)(82740400003)(316002)(7696005)(8936002)(356005)(54906003)(478600001)(86362001)(1076003)(426003)(2906002)(6666004)(36756003)(26005)(186003)(70206006)(82310400003)(4326008)(336012)(4744005)(70586007)(83380400001)(8676002)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:19.3411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643a29e9-da0b-48eb-a47e-08d875ccdbcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
Cc: Eryk.Brol@amd.com, Yu-Ting Shen <Yu-ting.Shen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yu-Ting Shen <Yu-ting.Shen@amd.com>

[WHY]
VBIOS will not enable VSC_SDP during pre-OS to lead
MISC1[6] wasn't matched with driver.

[HOW]
disabled seamless boot if sink supports VSC_SDP

Signed-off-by: Yu-Ting Shen <Yu-ting.Shen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8f4738b09922..21423ebc9c04 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1264,6 +1264,10 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 			return false;
 	}
 
+	if (link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED) {
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
