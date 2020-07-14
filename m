Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAB3C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 04:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4370A207BB
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 04:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s21mbahm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4370A207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BCE6E8B1;
	Tue, 14 Jul 2020 04:18:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDA36E8B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 04:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNEFZwiBG3eRsWaDksfjI3lzzLU5Ui78U7uat7fbd53lcaYLI9mbiye1JTu5WBryVNfT7hZRQ1TBatGGeZWliDA5+A1Fsfz9YdxtXuxPEIYrI7KjMVddXqfuW1YMiwAnh+/zaDMrlyihXsRsoVVlA4+4W3zvz0XbRb2N/Gw1FrUBSMuKD1IR46evunFu6gO5AN3kHUQ0T+MkPONM2Fj1wYq0+SmlzNUA9i0r/a0veYDdZ6PVZejzb/JWtPJBJBCkYnvL2SrPeddiTQnxgKcLd1G8jPcdBJ7DMHjN49FubAQ6xSEJbFoW35oBKB/DrbYqpq8Dccbws1Sj0R7ctDvCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjB2cqvetwBtA0wHTTfMTwyzRdXO2qV2PL8nCOWz8mg=;
 b=OTvxrHB05xcG5KhPHo3tlLC0RO7sbNFRTwBcAlcZpjsacDnT/QJLrhcWMqeRl6PYTvLd49ZidMUflzfRX5xYS3GElT2Acb6w76Q0FGhLQTxlgiVCQtCf9cvkN8UHA9WTZ4NULq27BZrqlsDzE+vHu1lqmAUPDLnnUpkB5A1UGKUtHamuJoTS4Yi15liGek+Bzqn9R7CSL+nzu9WIX/p4x0EvDSBVLDLXnj2Mfitp6l09o0bRqCmqWETECvuZNiPSeTa6f1i9JmjRDoM+8Okv6SSMyDg/abQnbxdXfQgeqOZ+W4e6mC7ijExy2bOhQOoN0FGPHgn5qh2JvYnG9nHWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjB2cqvetwBtA0wHTTfMTwyzRdXO2qV2PL8nCOWz8mg=;
 b=s21mbahmuqpn/KhQq+afhsZbMhqBd2PE5qsXRSJgi43kEEakEhoI5RYsHf59fBJ7kad/moXuyGYXz8PUJQ3x5VRXiGWlPDGX14RvkM3nEaZDeVrxKE5HJPPRy2F1ZbG8ViCBnQpln2xBGiMOKSXRqRIyDglH/sQxv29m/EG9ScQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2394.namprd12.prod.outlook.com (2603:10b6:907:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 04:18:42 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 04:18:42 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH UMR] Fix off-by-one error for decoding sdma linear write packet
Date: Tue, 14 Jul 2020 12:18:30 +0800
Message-Id: <20200714041830.29358-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (58.247.170.242) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Tue, 14 Jul 2020 04:18:41 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df53062d-cf26-4ed7-531b-08d827acfe0d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23944BCC9B07ACBC88664D8689610@MW2PR12MB2394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaq1NQow5/OJ6SGjOo7asCsmnuXWoUXmk2kcn7R+/jYJ/kUSJFbDP9BE/mGgGsfHkwUOIqPtNSc6hiuwZFrGECnCS4pVOLCa/5GoQMF9CyV/tEiIQaon3Cz00NObbHf1APki7/FUlgCAB4JZiAmNSnmXqP0SBZx2+h9186yeiPEyTEfDMy6PMhe11fS6JqW0SiSWAWERiGi8aVtt4WVvP+XumB4qpZIfrZ9ccZepJrYdnuU9qE1aYLlW0oIkj9aNpoSgsUyz9xZ5ddwPTJmmXheCXN5tb+k4btnf8YHjG1p76A1TqwP6ytSKtRbOWzguH6BYJV6awsRYpMKtSKYdNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(26005)(478600001)(83380400001)(8676002)(7696005)(44832011)(16526019)(4326008)(186003)(6636002)(66946007)(6486002)(5660300002)(66556008)(52116002)(8936002)(1076003)(2906002)(956004)(316002)(86362001)(2616005)(36756003)(66476007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Jhh5AkfyAUS8oGJMdD+CCbD0eK5aaBEZQVcEe9oEa9aTDwepnA7y24RTKYnbhraIOJPLY06k/cQxw9/FrOIaDjN8tkxcZnqV8lFnXojOdmLDs4071SU5evk0LC3xjXOpOYc/w/cUkX0pkKt/yS1TZ4my/K+Nnwu3Phj04NSE7LbEeJb74BKXDWV/qxDMb2jW8eRTqV+LuR+ay7bEIMR+SBzs94MC/nvlXWIWnagp79zvOnk2RLWuaenbMuZyG7TzmSwX/dinqyiL7W/GoWpOjjstpSCBE1mZphC6jz7e8SiOQ24Gw0e/cVrjwMB7nMZbKSsHhxR9R3ks33Qv3Rfl2lZzFLX3Rm+Z20kRRKXnkCfZctQo5CiZK6Yt96jNGdXZEAIaP9R1T7hHrs7sQpl0WF3YebTqMkBlImN1UvubEKLwIn8NWZKbWgRyxrdIm1OumEHONu9Z3cdReAwgSj1vlU6obvomVy4df99Re6Xcbh9r8xLP0pCP4cXOAzRhK74A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df53062d-cf26-4ed7-531b-08d827acfe0d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 04:18:42.5697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsHPYF3f9MFKIvKQwfDekyAV22cxm26y5iSBzbhMOPLc0I+1p2r1U2I4H6qKLO5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2394
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

COUNT in linear write packet represents dword number - 1

Before fix:
navi10.sdma0.ring[   0] == 0x00000002    .w. OPCODE: [WRITE], SUB-OPCODE: [0], LINEAR_WRITE
navi10.sdma0.ring[   1] == 0x00400a60    ... |---+ WORD [1]: DST_ADDR_LO: 0x00400a60
navi10.sdma0.ring[   2] == 0x00000000    ... |---+ WORD [2]: DST_ADDR_HI: 0x00000000
navi10.sdma0.ring[   3] == 0x00000000    ... |---+ WORD [3]: COUNT: 0x00000000
navi10.sdma0.ring[   4] == 0xdeadbeef    ...

After fix:
navi10.sdma0.ring[   0] == 0x00000002    .w. OPCODE: [WRITE], SUB-OPCODE: [0], LINEAR_WRITE
navi10.sdma0.ring[   1] == 0x00400a60    ... |---+ WORD [1]: DST_ADDR_LOa: 0x00400a60
navi10.sdma0.ring[   2] == 0x00000000    ... |---+ WORD [2]: DST_ADDR_HIb: 0x00000000
navi10.sdma0.ring[   3] == 0x00000000    ... |---+ WORD [3]: COUNTc: 0x00000000
navi10.sdma0.ring[   4] == 0xdeadbeef    ... \---+ WORD [4]: DATA: 0xdeadbeef

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index c3b5d18..a74229d 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -1819,7 +1819,7 @@ static void parse_next_sdma_pkt(struct umr_asic *asic, struct umr_ring_decoder *
 						case 2: printf("DST_ADDR_HI: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
 							break;
 						case 3: printf("COUNT: %s0x%08lx%s", BLUE, (unsigned long)ib, RST);
-							decoder->sdma.n_words += ib - 1;
+							decoder->sdma.n_words += ib;
 							break;
 						default: printf("DATA: %s0x%08lx%s", BLUE, (unsigned long)ib, RST);
 							break;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
