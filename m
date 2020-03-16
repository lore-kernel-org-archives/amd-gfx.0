Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA3C2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C335A2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mU1JLfZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C335A2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791446E452;
	Mon, 16 Mar 2020 13:50:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBDB6E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0Nnu+zl21pFXuVw9aWcA6XyzqaHKpHCjLFbbV8tz+Q9E9fRumE5Qfwr+YQQCxnXSYrltsNHTsdf4BCynZ104fzsMN4hqZslDgxi2Z6o5mJazrb/CcDLPyl2pncRXZV5dOha9pUOnU8Z7cF8beqdxAZg0Nw9R0fRQu9ZIFO1rfND3EtKeNT13OxqMOSHmEBGY+BpvK0MOyxma7QVYWY/vc623PVpaSqDqhwKzKggdJrV/6RKZmk7sCqhN4FBNABUP8IcE9CBwexrpFkvnfxrey4MTlktf8mYqRJsu8npiTpDToOGvW4O2czaVavNwtEc7vNVIfS+8bb7uRyM9rjdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMwYI7lghAKD+hg/uqnIWrzj/fADGUvTfTZCBMFyryU=;
 b=AfsJrtpDf7TJoHx/O4DC+rliyGFSkdhij9gTqfIs5DES4f1UwKgwPR/XSt0Ft9BET6yuunzn6hJpeVrIfU5Q4WdtercAb/ucuWMdVO0c4YIkwtLdhC8tn7sH/SLlM/+uZcg4JYYLNaxxNJBppESVoSBGxf+Z5Cx7LoH/alWHuAoAf1cbe2y+NcY53ZFvPDow42TLMWpwc1xDCRzjGLkFdwrG/CRsSD8/i2Y8qraUmMul6WNY7txgsNWJQ86DHj7vCpDek2OLfaKz3xysvIydMr5VXuyWfcM+f7vjj5qkyYI4ANGixd33KALRtVeW5BTYGbGFuH/pOWYQt4wGoXT4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMwYI7lghAKD+hg/uqnIWrzj/fADGUvTfTZCBMFyryU=;
 b=mU1JLfZzh8EZyTKm2eja9TliFnxdSUeAXkou+q9r0I1pGIWkYD1/pP5jSA4h8joSYTafyupQ9QTmytN90V2KTRxAKnftLW2z2WOO6t/8CcLRG9w3mGo8byUy14OSyCvP4WEbiYRlld8OBe50aTPkRbnQbAscJynyGkofeexQ6+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:07 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:07 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/19] drm/amd/display: guard DPPHY_Internal_ctrl
Date: Mon, 16 Mar 2020 09:49:15 -0400
Message-Id: <20200316134920.2526155-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c719bb84-c1ab-4f3d-4266-08d7c9b0f00b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB239607B9AE1DA8F59D9E0FEC98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2JoE1sb4oAkU9QIi8J1JXUMJ8p2gCA2EXeFwAuD7QBcap7iyStjZUaPnb4pCMkRLXSXoEvZAWN00+DQ0HDF9ulabmXmt6fAx5TGMfz39ZIT6XxQL3urT8On2rBTlbLRwz1KLJIfS6AWtkC7kVS5cX3PX+gcaOAr5869BAnGvNhw0xEiWWRw5yMc0K8DBGQoh1HdPL8jyiyhuusurEvpqupQfEiLnLRTAB6jWWsHgqvGxNuNmTkfa6xpBScsKl234dbsVQkJzD9natcupySPvWwf0yOmgIzkCRofpO7s9hTllbewRti5ADER/I1DXlCfpF7DuLi67T9VMGrN9DW3dgN6mgZwN6g1IqRqVH7/8JnHUNo+37gH2eU41N7jE09/ksXdt2IgUafnqAPr5rb/pp/awK7DLNLmKOCyDznQoQ0hus53bmLguFGpqKngUx8g
X-MS-Exchange-AntiSpam-MessageData: fOW0bVNgU6z2qzG20SbwbeqbQY7gDjVqw9eMmdVigshO64qUSetowqxj3YXDwvUh/H4pZgeE/yyBXlKO/XbKkxbNVPm4NdGZxbCc0mNMCVDMk3cSy8BTDblY4lB7mVvr8FqawLK1fgejb9xvBdRz6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c719bb84-c1ab-4f3d-4266-08d7c9b0f00b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:07.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLn+Jbrs67pllhQie6rhywH479rMxKnGpudvp3CxomRwKlpX/YLvNlCH4d5XbBJra0ciFK+Gak4GvduYygA8Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
this register not exist in some asic, based on request remove this from
dc.

[how]
add guard for sanization.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index eb13589b9a81..762109174fb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -62,11 +62,11 @@
 	SRI(DP_DPHY_FAST_TRAINING, DP, id), \
 	SRI(DP_SEC_CNTL1, DP, id), \
 	SRI(DP_DPHY_BS_SR_SWAP_CNTL, DP, id), \
-	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
 	SRI(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id)
 
 
 #define LE_DCN10_REG_LIST(id)\
+	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
 	LE_DCN_COMMON_REG_LIST(id)
 
 struct dcn10_link_enc_aux_registers {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
