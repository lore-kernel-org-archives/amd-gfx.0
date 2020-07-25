Return-Path: <SRS0=m7X+=BE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118ACC433E3
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jul 2020 01:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03742070E
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jul 2020 01:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2MTC1iaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03742070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB2C6EA56;
	Sat, 25 Jul 2020 01:48:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C026EA56
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jul 2020 01:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evaI21KK6v1qtVhr9XH/jup6k2Z4a/ART50ladtbYJRg6pHvtUi1snWhjyJh79WkxXUc04N31LIMgIPctcSBJtjoY7DY56/9nACAEfIY18jrKnou8rljbOC/tzm60PbSjkFGGpIzn7VVLB06z7DfDBjuxqAFuj8GmIoFH4B3Eham90tie2WxmC42l8Gw9fWSt4Lkmtn/X6RHACi+agRiIbANbz5dsbs23dDudqF7iK/E9GyOXVin5g/ZHHQzj92a+QySGEMcDCb8oWxg2vQgoteO13sF8KqKV5fWERwMeUDSxTldE3uwoWxdzCvK8kL/0etKhSAHymg/y1hw1wrh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adkeKaiR2l++mOjdbla5hiAuVD2qxiO87x9M/y5ak+M=;
 b=TXgxP665t43CoZ+FLH0tT0Z72f/BKoNWDi6+y8nACa3J6HGMjS6GF/Q5GfRaPDN1f7fSt3BeKobAWQxCeiHFkqRmwAvzy0eBB+DIPMG2KHcXKd9AmuqrMaTzj3fioYt3gylfEtCsTwEpwrC1MJ0I8nik6ZzKjhV4VaZZkj7iwcawllR45BW+cMMTH6LTujl/lNnFf348gajV/DK5vJuA1iXAAQKOeUTI+qM0cKRJyHJ8KiPALamZ6gKGeDi2sECGBfF3LRS2f2ZO49OrV+oksnwWIh6iRlew0ecBNSOuM13vkXvKsLVwORLr7g//xgQDbS+xD21VV2KU89OKoDUDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adkeKaiR2l++mOjdbla5hiAuVD2qxiO87x9M/y5ak+M=;
 b=2MTC1iaTW+8uasWOJA0lKZhAeVcn0NBBbaa5uaosNMtTEErWBeqlgkvR5NCKZTes21H+MCUiMG8/DTqZ9t4alLRRYR8hei2A2NsqjqRd+fMU0vaX62VcDHOJ6krvmyjjJczFgyfxRi8CGf9o8N88LrUhFEg+IKgy8xo4TJwEjuU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Sat, 25 Jul
 2020 01:48:20 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::5d1d:887c:3ba6:1d0d]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::5d1d:887c:3ba6:1d0d%7]) with mapi id 15.20.3216.020; Sat, 25 Jul 2020
 01:48:20 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Fix spurious debug exception on gfx10
Date: Fri, 24 Jul 2020 21:47:41 -0400
Message-Id: <20200725014741.214-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: MN2PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:208:134::35) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.11.250) by
 MN2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:208:134::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Sat, 25 Jul 2020 01:48:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.11.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87b16f1e-81d4-40fb-d582-08d8303ccef3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2448DB00D851524862E8EFB692740@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJf8c5WRPaVhvPVyjhLEwEovCFrF1fZ06qHEQk+a0Ire7Pz2vWsRk/6J+3yRoIh0wAwHIOSSDG4dBtpXPUwaeyGcI5Ou6NDSw+SG81lLzn7w2p3drUl60QHRoNiNymV9Hw8U8r4ofPJly9eckrT7lcp0vNuZyqtEtXpejhB5jBYOJzkeOzW6X0+6CY6poiDjypnm/fpgcSxixiHgaarekOVAjGS6Nlgf2DtCF8yiWYaVjK3sXSgLiNsoY869BDQBkw3lIlVCS0pK9JOL8URDYP+jRNMoDGTOvlEoWxwC526SKO8jRhG+x6lDODp4zQgfMOsdg8pv1oS4ALEg86bq65iqmewrl6Q36wkSzadHoNBhf9F/+mDnutmFvSk6bOnp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(316002)(26005)(186003)(5660300002)(8676002)(6512007)(69590400007)(2906002)(6506007)(16526019)(6916009)(6666004)(83380400001)(86362001)(478600001)(52116002)(956004)(1076003)(66476007)(66946007)(8936002)(66556008)(36756003)(6486002)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OMjkD6dRjcvH1Um7sMJHhBQ0kg2oho/NvL/Z2oDj0WwQ9eUwcGY5F6vAVNREI1ANM7TGHZEzFSOS3YeQPF8MJWFyFfIG46Lbu6HGj3LDOPVt9DM5H7Ymw5Rb1z43JEf5lrTI18jpvfLlEjHqoEHA0C9LLi27QIi+q0RYVbH650JvqSkCyiI/B0yprGHCO9VyX8OVn2zAy5ADj6o0pJmCpkXjMhSDhcseQY1Ji9AsARxkIe0/VMsbwrJZ4NE7Mk4tJdLx5+7g3QU90EtGOsy0hOFnwYjizbMWgDKPUqkN0SFo/Pq/OiMFUpK4/t9AvCCScudp9yla5L+DJFrXA+Zx9e9k6X3otP6B6owfQ1wNcGUZdvYOm4SKy2qlDfIdl2BNpzCR+AD1aNqJsUFW5ufLUpzh8gpi6oBm6DiLoISIIMc+9Ll89QIsaUDebSOLTGcW/J29xzc2q5zA4XFA3OinwheDGuSF/lcPn4lnw76RF1TBHbOY6tyUGPcC5SkULiEE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b16f1e-81d4-40fb-d582-08d8303ccef3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 01:48:20.3771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XckFmBq21CG4s6YnLc0SfJp3Gbp1NzGDPjS8hg8x/3Efg64qqymyv3l/9k3ptwdAZzBF2quHcKnklDyPgRpGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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
Cc: jay.cornwall@amd.com, laurent.morichetti@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jay Cornwall <jay.cornwall@amd.com>

s_barrier triggers a debug exception when issued with PRIV=1,
DEBUG_EN=1. This causes spurious notifications to rocm-gdb.

Clear MODE before issuing s_barrier and restore MODE afterwards
in the context restore handler.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Tested-by: Laurent Morichetti <laurent.morichetti@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 178 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |   7 +-
 2 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 7290a30f26ca..a5cf735daf48 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -911,7 +911,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xe0704000, 0x705d0000,
 	0x807c817c, 0x8070ff70,
 	0x00000080, 0xbf0a7b7c,
-	0xbf85fff8, 0xbf820150,
+	0xbf85fff8, 0xbf820152,
 	0xbef4037e, 0x8775ff7f,
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
@@ -1024,62 +1024,63 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbe863106, 0xbe883108,
 	0xbe8a310a, 0xbe8c310c,
 	0xbe8e310e, 0xbf06807c,
-	0xbf84fff0, 0xb9782a05,
-	0x80788178, 0xbf0d9972,
-	0xbf850002, 0x8f788978,
-	0xbf820001, 0x8f788a78,
-	0xb96e1e06, 0x8f6e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef603ff,
-	0x01000000, 0xf4211bfa,
+	0xbf84fff0, 0xba80f801,
+	0x00000000, 0xbf8a0000,
+	0xb9782a05, 0x80788178,
+	0xbf0d9972, 0xbf850002,
+	0x8f788978, 0xbf820001,
+	0x8f788a78, 0xb96e1e06,
+	0x8f6e8a6e, 0x80786e78,
+	0x8078ff78, 0x00000200,
+	0xbef603ff, 0x01000000,
+	0xf4211bfa, 0xf0000000,
+	0x80788478, 0xf4211b3a,
 	0xf0000000, 0x80788478,
-	0xf4211b3a, 0xf0000000,
-	0x80788478, 0xf4211b7a,
+	0xf4211b7a, 0xf0000000,
+	0x80788478, 0xf4211c3a,
 	0xf0000000, 0x80788478,
-	0xf4211c3a, 0xf0000000,
-	0x80788478, 0xf4211c7a,
+	0xf4211c7a, 0xf0000000,
+	0x80788478, 0xf4211eba,
 	0xf0000000, 0x80788478,
-	0xf4211eba, 0xf0000000,
-	0x80788478, 0xf4211efa,
+	0xf4211efa, 0xf0000000,
+	0x80788478, 0xf4211e7a,
 	0xf0000000, 0x80788478,
-	0xf4211e7a, 0xf0000000,
-	0x80788478, 0x80788478,
-	0xf4211cfa, 0xf0000000,
-	0x80788478, 0xf4211bba,
+	0x80788478, 0xf4211cfa,
 	0xf0000000, 0x80788478,
-	0xbf8cc07f, 0xb9eef814,
 	0xf4211bba, 0xf0000000,
 	0x80788478, 0xbf8cc07f,
-	0xb9eef815, 0xbefc036f,
-	0xbefe0370, 0xbeff0371,
-	0x876f7bff, 0x000003ff,
-	0xb9ef4803, 0xb9f9f816,
-	0x876f7bff, 0xfffff800,
-	0x906f8b6f, 0xb9efa2c3,
-	0xb9f3f801, 0xb96e2a05,
-	0x806e816e, 0xbf0d9972,
-	0xbf850002, 0x8f6e896e,
-	0xbf820001, 0x8f6e8a6e,
-	0x806eff6e, 0x00000200,
-	0x806e746e, 0x826f8075,
-	0x876fff6f, 0x0000ffff,
-	0xf4091c37, 0xfa000050,
-	0xf4091d37, 0xfa000060,
-	0xf4011e77, 0xfa000074,
-	0xbf8cc07f, 0x876fff6d,
-	0xfc000000, 0x906f9a6f,
-	0x8f6f906f, 0xbeee0380,
+	0xb9eef814, 0xf4211bba,
+	0xf0000000, 0x80788478,
+	0xbf8cc07f, 0xb9eef815,
+	0xbefc036f, 0xbefe0370,
+	0xbeff0371, 0x876f7bff,
+	0x000003ff, 0xb9ef4803,
+	0xb9f9f816, 0x876f7bff,
+	0xfffff800, 0x906f8b6f,
+	0xb9efa2c3, 0xb9f3f801,
+	0xb96e2a05, 0x806e816e,
+	0xbf0d9972, 0xbf850002,
+	0x8f6e896e, 0xbf820001,
+	0x8f6e8a6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x876fff6f,
+	0x0000ffff, 0xf4091c37,
+	0xfa000050, 0xf4091d37,
+	0xfa000060, 0xf4011e77,
+	0xfa000074, 0xbf8cc07f,
+	0x876fff6d, 0xfc000000,
+	0x906f9a6f, 0x8f6f906f,
+	0xbeee0380, 0x886e6f6e,
+	0x876fff6d, 0x02000000,
+	0x906f996f, 0x8f6f8f6f,
 	0x886e6f6e, 0x876fff6d,
-	0x02000000, 0x906f996f,
-	0x8f6f8f6f, 0x886e6f6e,
-	0x876fff6d, 0x01000000,
-	0x906f986f, 0x8f6f996f,
-	0x886e6f6e, 0x876fff7a,
-	0x00800000, 0x906f976f,
-	0xb9eef807, 0x876dff6d,
-	0x0000ffff, 0x87fe7e7e,
-	0x87ea6a6a, 0xb9faf802,
-	0xbf8a0000, 0xbe80226c,
+	0x01000000, 0x906f986f,
+	0x8f6f996f, 0x886e6f6e,
+	0x876fff7a, 0x00800000,
+	0x906f976f, 0xb9eef807,
+	0x876dff6d, 0x0000ffff,
+	0x87fe7e7e, 0x87ea6a6a,
+	0xb9faf802, 0xbe80226c,
 	0xbf810000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
@@ -1808,7 +1809,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xe0704000, 0x705d0000,
 	0x807c817c, 0x8070ff70,
 	0x00000080, 0xbf0a7b7c,
-	0xbf85fff8, 0xbf82013b,
+	0xbf85fff8, 0xbf82013d,
 	0xbef4037e, 0x8775ff7f,
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
@@ -1921,51 +1922,52 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbe863106, 0xbe883108,
 	0xbe8a310a, 0xbe8c310c,
 	0xbe8e310e, 0xbf06807c,
-	0xbf84fff0, 0xb9782a05,
-	0x80788178, 0xbf0d9972,
-	0xbf850002, 0x8f788978,
-	0xbf820001, 0x8f788a78,
-	0xb96e1e06, 0x8f6e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef603ff,
-	0x01000000, 0xf4211bfa,
+	0xbf84fff0, 0xba80f801,
+	0x00000000, 0xbf8a0000,
+	0xb9782a05, 0x80788178,
+	0xbf0d9972, 0xbf850002,
+	0x8f788978, 0xbf820001,
+	0x8f788a78, 0xb96e1e06,
+	0x8f6e8a6e, 0x80786e78,
+	0x8078ff78, 0x00000200,
+	0xbef603ff, 0x01000000,
+	0xf4211bfa, 0xf0000000,
+	0x80788478, 0xf4211b3a,
 	0xf0000000, 0x80788478,
-	0xf4211b3a, 0xf0000000,
-	0x80788478, 0xf4211b7a,
+	0xf4211b7a, 0xf0000000,
+	0x80788478, 0xf4211c3a,
 	0xf0000000, 0x80788478,
-	0xf4211c3a, 0xf0000000,
-	0x80788478, 0xf4211c7a,
+	0xf4211c7a, 0xf0000000,
+	0x80788478, 0xf4211eba,
 	0xf0000000, 0x80788478,
-	0xf4211eba, 0xf0000000,
-	0x80788478, 0xf4211efa,
+	0xf4211efa, 0xf0000000,
+	0x80788478, 0xf4211e7a,
 	0xf0000000, 0x80788478,
-	0xf4211e7a, 0xf0000000,
-	0x80788478, 0x80788478,
-	0xf4211cfa, 0xf0000000,
-	0x80788478, 0xf4211bba,
+	0x80788478, 0xf4211cfa,
 	0xf0000000, 0x80788478,
-	0xbf8cc07f, 0xb9eef814,
 	0xf4211bba, 0xf0000000,
 	0x80788478, 0xbf8cc07f,
-	0xb9eef815, 0xbefc036f,
-	0xbefe0370, 0xbeff0371,
-	0x876f7bff, 0x000003ff,
-	0xb9ef4803, 0x876f7bff,
-	0xfffff800, 0x906f8b6f,
-	0xb9efa2c3, 0xb9f3f801,
-	0xb96e2a05, 0x806e816e,
-	0xbf0d9972, 0xbf850002,
-	0x8f6e896e, 0xbf820001,
-	0x8f6e8a6e, 0x806eff6e,
-	0x00000200, 0x806e746e,
-	0x826f8075, 0x876fff6f,
-	0x0000ffff, 0xf4091c37,
-	0xfa000050, 0xf4091d37,
-	0xfa000060, 0xf4011e77,
-	0xfa000074, 0xbf8cc07f,
-	0x876dff6d, 0x0000ffff,
-	0x87fe7e7e, 0x87ea6a6a,
-	0xb9faf802, 0xbf8a0000,
+	0xb9eef814, 0xf4211bba,
+	0xf0000000, 0x80788478,
+	0xbf8cc07f, 0xb9eef815,
+	0xbefc036f, 0xbefe0370,
+	0xbeff0371, 0x876f7bff,
+	0x000003ff, 0xb9ef4803,
+	0x876f7bff, 0xfffff800,
+	0x906f8b6f, 0xb9efa2c3,
+	0xb9f3f801, 0xb96e2a05,
+	0x806e816e, 0xbf0d9972,
+	0xbf850002, 0x8f6e896e,
+	0xbf820001, 0x8f6e8a6e,
+	0x806eff6e, 0x00000200,
+	0x806e746e, 0x826f8075,
+	0x876fff6f, 0x0000ffff,
+	0xf4091c37, 0xfa000050,
+	0xf4091d37, 0xfa000060,
+	0xf4011e77, 0xfa000074,
+	0xbf8cc07f, 0x876dff6d,
+	0x0000ffff, 0x87fe7e7e,
+	0x87ea6a6a, 0xb9faf802,
 	0xbe80226c, 0xbf810000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 4569db452160..0f8e06a2ea8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -895,6 +895,11 @@ L_RESTORE_SGPR:
 	s_cmp_eq_u32	m0, 0							//scc = (m0 < s_sgpr_save_num) ? 1 : 0
 	s_cbranch_scc0	L_RESTORE_SGPR_LOOP
 
+	// s_barrier with MODE.DEBUG_EN=1, STATUS.PRIV=1 incorrectly asserts debug exception.
+	// Clear DEBUG_EN before and restore MODE after the barrier.
+	s_setreg_imm32_b32	hwreg(HW_REG_MODE), 0
+	s_barrier								//barrier to ensure the readiness of LDS before access attemps from any other wave in the same TG
+
 	/* restore HW registers */
 L_RESTORE_HWREG:
 	// HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
@@ -978,8 +983,6 @@ L_RESTORE_HWREG:
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 	s_setreg_b32	hwreg(HW_REG_STATUS), s_restore_status			// SCC is included, which is changed by previous salu
 
-	s_barrier								//barrier to ensure the readiness of LDS before access attemps from any other wave in the same TG
-
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
