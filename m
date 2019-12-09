Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DBC43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F905206D5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F905206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C705B6E52F;
	Mon,  9 Dec 2019 21:11:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2706E53C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 21:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx25FBYci6u1r//2UrcFCu16cNnL7roJn68/IGLWEFe7UUoNxPmnjQ4sCyov7axBFmJr0BoqzyxgZWjwoyHi37XT/GnKb3lJdDjqT479YerNB0DHjnnMmb0PSpCPxFygEjo+CtZwN1Fey5I4Uq1Zsi7I8um7k2ZdoTWISPRGAUfPZJgTDUGyjmqo+ZH+hI4xPrCgagKEfJF8Sqgj3q1rUB/GH5tC2SvN66Sqbo9cwoeq8hmiwPIUP9wApKGY2oUqmHRS/6M01nTxCAmJz8GPLY5rN0IhOtSjJA9DAYkIxlcDChsJpnrY52ErE6rVpf/F0HPf2NcHCmFhmtg/IoTjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHZWl6JoNaOS7s8kpgTDsB7FCv33LGZeifw1RpBFTb4=;
 b=GwWbLnPvhmjzlRIImCujsMvs4yGbV+LsS6zhaLz7bZFvcML90J6PHQvWEXaqz+BChQorw1aTwHUXRLQFkbEzJl37lsq1hUsFnqK4ivlOnPTAN6vJE06KhQ7i/wqnTc5TG+Q3WzhYkYHLAQUyvhX43wavXgWb/9SN5ddQ+t0GGcaJn5YblW05Wu1oR5B136xTgZe8RqDlETtXlKPK2dWHGAL+H+uE5oifMILLtwPtRBGCgMzl9j/ZZe+cA/FKNqBacZZa95RkrL+S86LMiLqMP7EVZd9OhEOTIe4Sw6oNLdld7XRvzfmm8f2R1ayg2CEKggBNsfn7CL5nFuHXoW3Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1754.namprd12.prod.outlook.com (10.175.89.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 21:11:11 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:11:11 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix JPEG instance checking when ctx init
Date: Mon,  9 Dec 2019 16:10:48 -0500
Message-Id: <20191209211048.6937-2-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209211048.6937-1-leo.liu@amd.com>
References: <20191209211048.6937-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d382446b-2ae5-4e83-41ea-08d77cec50cf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:|DM5PR12MB1754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17540505F23A39E303BF122AE5580@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(305945005)(52116002)(186003)(26005)(44832011)(2616005)(36756003)(478600001)(316002)(6506007)(6916009)(2906002)(66946007)(6512007)(4744005)(8676002)(81166006)(6666004)(66556008)(5660300002)(81156014)(1076003)(66476007)(8936002)(4326008)(6486002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1754;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrUG4UpOn/axMTpykG0xMAUtcqdqCZ/paqsqf4uYPlpxRILYI7dneVPJpSTfcCD0YPM9rqPlhEUVF2q0GkPY8bQFD/F2vl2CpLaWJUIS7neGmANsMSue/LOy1o8uh4T87G7eiYWhARkucO/vkgn/B585pAoxw03m9WTxKYTW8A3KXrcZJDzla08BacCQQ6pM6ae8vOWE/BszeCOCSbtpYmDshISIiMvECfE0Y++6vJV7uAHTqax9mCoMHRbl4p4p37wWLjHDWL8dLPw4EdjO7WE6Lrv/aY0uqAyVt+KpeIcV8zqljfwzxgWOc9SatQkuQqAKc3sROUhw7ueFISJYYhRFKCf7WS/esWJS21yebMkQfchSbKBmHmUQydFKntyWphBoZD9l7xXgNFCiX+ZLyHSu8JwVbdRXLE63jIWBb9GyyJTdlT0zNQuGU5h5vF8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d382446b-2ae5-4e83-41ea-08d77cec50cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 21:11:10.9298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unTQenlsyizSnU9rUVVSGf11huGnc5bxDszR/K5cwTuZpIMIyQL5vo87QBkWGOVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHZWl6JoNaOS7s8kpgTDsB7FCv33LGZeifw1RpBFTb4=;
 b=i41Stesb217d0VISQ8zU4JuCoEQjTeofsh3Ui8T/iaPFUOyzOKfj9JgvdG9YCm82ITEUC40eXzjQCPs5iu/KjcGy0ttnAujnGpCwPtXZelUJeDU3dFVXBA9dMpoVYIIEJvAIjIqa2FNm+IghY4sukhi67k9uwQBBSj+WZFROPOU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXM6IDAzODhhZWU3NigiZHJtL2FtZGdwdTogdXNlIHRoZSBKUEVHIHN0cnVjdHVyZSBmb3IK
Z2VuZXJhbCBkcml2ZXIgc3VwcG9ydCIpCgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4IGEwZDNkN2I3NTZlYi4uZGI0
YjYyODNjMjhjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3R4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCkBAIC0x
NzAsNyArMTcwLDcgQEAgc3RhdGljIGludCBhbWRncHVfY3R4X2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiAJCQlicmVhazsKIAkJY2FzZSBBTURHUFVfSFdfSVBfVkNOX0pQRUc6CiAJ
CQlmb3IgKGogPSAwOyBqIDwgYWRldi0+anBlZy5udW1fanBlZ19pbnN0OyArK2opIHsKLQkJCQlp
ZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaikpCisJCQkJaWYgKGFkZXYtPmpw
ZWcuaGFydmVzdF9jb25maWcgJiAoMSA8PCBqKSkKIAkJCQkJY29udGludWU7CiAJCQkJcmluZ3Nb
bnVtX3JpbmdzKytdID0gJmFkZXYtPmpwZWcuaW5zdFtqXS5yaW5nX2RlYzsKIAkJCX0KLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
