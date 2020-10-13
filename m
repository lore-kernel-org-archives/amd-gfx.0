Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6DDC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 08:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292FD207C3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 08:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YCrfd3v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292FD207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8DD6E8AF;
	Tue, 13 Oct 2020 08:15:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E916E8AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 08:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0QXOafAiDv+wHgqi/mVYRW1vbnHxLGrulsx9fNdwyOpumwE52Yk0AhGtuNdHXYm1cItyLI8sPuJG7/4GQbhzxUjEljeQfwGkZEoAjLhY9EZo9pwaPCubF4OuZZDbu3zF60F20iGtpdu51BIygREKKMJmLamS5T+LIRAF0sug0jKMkM79B0vxoafcL5lQE+pPbuaHidIx9LCt5/akujCQy94wAdWphWw9Y6afo6J0rKzOT6hDSxcXD7WeEOcqsk1YKdswZMWdXYMp5yhaWaVl/Gm99SUTfuJ/4P4hEu5Bz+3DZmLVRG8c+jsuTKlBCRsY1TIiXFrEeEWp/3BA8+W7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/o6vRIW1X9bgId4hD1tOo1x9sFMhA2XmB2f2nfZ7EQ=;
 b=IeQiWP/DQyLf6mL3yT00cTbbAefEklRrENZzcA5fExtpr4xzHD0TA1fCA6Yl1OxQ9G8WZRNAfw/iWTZYOsNMt3Adc00CnGKXPeHNTEP3ofroQCYj5XFfSQElSD+XhVR9wzflGA1fmkYmdpNvwEm2xqZsU5Awss94E+2j9kabXB3WS7722Cyd8vc7pwnXGmYhPSbOz8LLUz1dwZ++cqxoUfS3QqweThI/hAdU4t6RIOzKhxxGKLKKQiZYkwLxxsIhmAQYyTj9hD1qCWmGyyFqZNKFA3YwACsHfOVI9OXUAojJPI7b1GZe5xpOt7ZqFcDy064HFGwYazd2lOMvdkHPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/o6vRIW1X9bgId4hD1tOo1x9sFMhA2XmB2f2nfZ7EQ=;
 b=YCrfd3v0DoNkYShjcCZqtSEp+i6j0M4xyuInbM5v+/RL5h2s46HnPu9eEUbNiHLUdwdpalwDp8cGu3x0kF2X+WJldTg1EzuRVs0z7SpsU5aF2m7734BTNyeKdOyoFPtQZK3dlzJWPQHKwz+2EWmSH3zcoJkjx/uS2QvtkKmVBV8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 08:15:18 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::dd27:77ef:46e9:7135]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::dd27:77ef:46e9:7135%7]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 08:15:18 +0000
From: Carl Ritson <carl.ritson@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH umr] Fix build to use LLVM_INCLUDE_DIRS
Date: Tue, 13 Oct 2020 17:14:31 +0900
Message-Id: <20201013081431.15355-1-carl.ritson@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [240f:107:f604:1:7285:c2ff:fe85:4e7d]
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from manabi.joji.usamimi.uk (240f:107:f604:1:7285:c2ff:fe85:4e7d) by
 SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Tue, 13 Oct 2020 08:15:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f2fb986-77c1-401c-513d-08d86f501e99
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4492E023C6E5044D1EEA4A12F2040@MW3PR12MB4492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yZEh31iEL9IufdLIpjXNC1JYqS4GBtMeGlc/x0uHAx3SHeiTjd5nK8MC/sHieAx07/+dkJUkGfbTaKb0p4JPuvtpghDCg3paZuVCyRyLXoVjdIm1Wp0dpZwesYoxBkBmlS2frhzGWrD9EcceQVHhoFKot2ayr7vS8scsmurZj9J5su8y7xtd3v6Gz5H81gh7ECHlUO3fyM5VnrxekQxuxBDwVCyjkdqX/vcplOEoHhPEPj59WVqPcaxQvnrZvSJjYWRJdlORTiv0/xyMgtCge0frcFysvq8DE2a3ezDziCd37cAti2rEkgEipftPpzE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(4326008)(8676002)(4744005)(478600001)(6666004)(6916009)(6486002)(1076003)(2616005)(86362001)(5660300002)(66946007)(66476007)(6512007)(66556008)(44832011)(16526019)(2906002)(186003)(8936002)(316002)(52116002)(6506007)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: A6YEkuxwW8ey6H1NrNxb42fnH+9tSrfvhK6WSJElMjMgcmvEGzG1Gl9cxUu45ZTEQd1k1q2r8mDp9MoUTRqIp60u3OIksz6rcBbx9w04u+yknf7Z7Gsj2z+8TUug6Vt0ehSS6O2HHnxqnJYAZZGv/q+8pzeMbn/vZpUdLezITCHWRW6NpCorT5AHpr06BM6wCrdOVyv5LwhP8GGMz5yebMxTXdMtRwrsTqwb25UGH8ZLTJcXscrf9piO22Q2WAICpvcrYy8UXpoCWss+aBV3pg/pZBOtQzb4Vgw3MhD14wPyeDksVveAvkhHx9oaJTlM9gx26M//lsDtxBMYojBjlNnezk6MhzPkLzH+h3lmGiIGbKSSHa6YYp1J2IvgvY5vI1J+Hr6ktLBciL5bbR7gC+iJvtF18Hp/isq7mBfga4AtZKXQUr5iq77jtCBXhbCdJeaFjBylfF54/RMWfia8Ilw8mJnzfCN9IgUoNR9KRMtLj08OSplnIZqCglCA9UeEdRRs+eAJidf5RWeidz9Nv4hm/Q2KqxpHqmZCi+IlyoqFyloDhYyn9cu4OaDSsINtY6Kve7G4WoPI3tl5rJEgYnx6vHCStwj86lY/RTkISnxSPpSVo5NioTsAMUp4pRGbeLyZP0ac3LRdfsTrzzm3ceZqPOhPO3tTLmaaCn3T0sZOnjlrOX4WUse/fQBNDB5pYnOfcst6ff85n0+K1TGkdA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2fb986-77c1-401c-513d-08d86f501e99
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 08:15:17.9782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdeAhnHMHy3cSYLI0GW/kIYkCP19SKnEG2RB5HGWKRSbLQPmiIokM8ZMLQNuBbe4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
Cc: Tom.StDenis@amd.com, Carl Ritson <carl.ritson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use LLVM_INCLUDE_DIRS instead of LLVM_INCLUDE_DIR to support
local builds of LLVM where source and binaries are separate.
---
 CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index a8c08d6..8bf69a8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -66,7 +66,7 @@ if(UMR_NO_LLVM)
 set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUMR_NO_LLVM")
 else()
 find_package(LLVM REQUIRED COMPONENTS all)
-include_directories(${LLVM_INCLUDE_DIR})
+include_directories(${LLVM_INCLUDE_DIRS})
 
 if(LLVM_CMAKE_DIR)
   list(APPEND CMAKE_MODULE_PATH ${LLVM_CMAKE_DIR})
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
