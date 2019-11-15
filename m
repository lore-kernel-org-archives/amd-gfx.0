Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2BFC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A2820709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A2820709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD8A6F3EF;
	Fri, 15 Nov 2019 03:35:41 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690070.outbound.protection.outlook.com [40.107.69.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADA66F3EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbA1eUZ1sBM3/9G6y0w27gGQ1ToGp0Gfrn202G4vtzLpOtuC2XkrnPmu794UkqZ/QET/7l35ILqHBJjVdFcjvULDpHZvF03D5K35JACmmFmf2vGHMmW/jDtPNWCBdEPqtvINxnaDOMg1siwsT6HYLvLC0XIJpco9iV52yWZyenOUrAe9plQvS9OJPVkHiS7fec0gt52RfxqeNo1evW06WkkYLnVhbpaS9bn2v1gN/5Nf/MBtiVVn1badkWYPqt5322sjhcM3qBUQC5JmzaY2HpwbmzBkVjvzxWgYDE0eyaRRCqRSCVtE3k8I6oJwxxeNP9/oOfD3ImtEle49nn1WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpUCW/dAwR4wZXQzvm5d/5kXRkIrJdOiElel76DD3oo=;
 b=EvUAinQ9E725g3zNown5IoS9vkQRnMK9STFW8z7jXTeUoz+QSs7Zx+p3anA34SAUs/r+3+3pztoZL0R5vtpKpMkUm/Lk6gon9uT9SDI66KqY92x3Q+/hekIXMh1vK9BkT1GKveW3TKNdq1tJl2Ty9i9v/iTZeoqX4puRwdPtP5UpUCR8qT3AzCagBgzdwFGV9vE4S4NRBn6xLdIL9Y1my7Ekkdmvwlh25r8wFsqw4+fWLwElrEWRA9p5MuuJ7vw8+ykLThGdRDZFo09vFMjwNGvdgmjMXYB+STnvx7Z+qTjc08BBGeM8XpWjh3YJEIpJzZhuWtFnLc8YbgVQrEshrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:39 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:39 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/12] tests/amdgpu: expand secure param for exec_cs_helper
Date: Fri, 15 Nov 2019 11:34:51 +0800
Message-Id: <1573788895-3936-8-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28d5b76a-1a8d-4a1d-8fc9-08d7697ce268
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB366391065BAB8C42D6458AB0F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: od13Jc656duifDdowpcBx36GGFziqaMK1pfzd8xvtUFTcaqG3yXz355s37sbWU994+W0YmykenBSRV/HoyKx8wqpWTJvLF/tVkHAISvC20xqMiKAa2+Y4CZJLhkhqzWCdag19b0/Miuhsi2kkJ/sTxNie+lYxNPKFS6YFWZE7QDPNh6/LHpcbSUXNhAWxTTZpQllysbm/ZJ+1N9ws8JixGGrwXcd8NIxeqlBG1k6tuH3QSy39jETFVNwPRzbS7TNrLDMy0WC59z4G+VEmfRjAqCX+PWke0BPKYcZK+gh3m8ekQZcMFMTwRQzEeReWBhip1YnEJ/CqKUI8GkjqY7jTqLKzDg5IriPjUMgMnCrEKwrz5QOc74fdTgotSMyaep4fEHoWhcPuaddI+xy6h7tRGfV+u4sNJ3f+9NeHP6Ahe7BggWpCQc7zIRujI/GR2Cu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d5b76a-1a8d-4a1d-8fc9-08d7697ce268
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:39.4846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9Alu/8W0zXzYgsPKTdKmAuZ9ZgR/zBN908jx5cOlPvXVutQamdY5OKexNqYchEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpUCW/dAwR4wZXQzvm5d/5kXRkIrJdOiElel76DD3oo=;
 b=LbwCEhvVHUAW0hKgorQSxtKr4xnoh1An4cbqeCtwfBrQzWOwScKdmwUuh/tFlp1UVIC+bZ9/D2Sk5+Srf+aSd9zYPDI+bRmMdj3t+fgZOeoNeO1ngKeBySvtgLZNdaeeJ8Qw/LCrFteNGy4xUrwa2jW+eYXYmGsm2nDsAIaylcY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 Luben.Tuikov@amd.com, Alexander.Deucher@amd.com, Leo.Liu@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033451.QAoCpVaYpbuTM29pkg3yPMkw2lgmVCrX7p8R92N6YDs@z>

VGhpcyBwYXRjaCBleHBhbmRzIHNlY3VyZSBwYXJhbSBmb3IgYW1kZ3B1X3Rlc3RfZXhlY19jc19o
ZWxwZXJfcmF3LgpUaGUgZmxhZyBpcyB0cmFuc2ZlcmVkIHRvIGtlcm5lbCB3aXRoIGNzLgoKU2ln
bmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRn
cHUvYmFzaWNfdGVzdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rl
c3RzLmMgYi90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYwppbmRleCA1MTU0ODEyLi45NTZiZTkz
IDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYworKysgYi90ZXN0cy9hbWRn
cHUvYmFzaWNfdGVzdHMuYwpAQCAtMTI5MCw3ICsxMjkwLDggQEAgYW1kZ3B1X3Rlc3RfZXhlY19j
c19oZWxwZXJfcmF3KGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldmljZV9oYW5kbGUsCiAJCQkgICAg
ICAgdWludDMyX3QgKnBtNF9zcmMsIGludCByZXNfY250LAogCQkJICAgICAgIGFtZGdwdV9ib19o
YW5kbGUgKnJlc291cmNlcywKIAkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2NzX2liX2luZm8gKmli
X2luZm8sCi0JCQkgICAgICAgc3RydWN0IGFtZGdwdV9jc19yZXF1ZXN0ICppYnNfcmVxdWVzdCkK
KwkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2NzX3JlcXVlc3QgKmlic19yZXF1ZXN0LAorCQkJICAg
ICAgIGJvb2wgc2VjdXJlKQogewogCWludCByOwogCXVpbnQzMl90IGV4cGlyZWQ7CkBAIC0xMzI0
LDYgKzEzMjUsNyBAQCBhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcl9yYXcoYW1kZ3B1X2Rldmlj
ZV9oYW5kbGUgZGV2aWNlX2hhbmRsZSwKIAlpYl9pbmZvLT5zaXplID0gcG00X2R3OwogCiAJaWJz
X3JlcXVlc3QtPmlwX3R5cGUgPSBpcF90eXBlOworCWlic19yZXF1ZXN0LT5mbGFncyA9IHNlY3Vy
ZSA/IDEgOiAwOwogCWlic19yZXF1ZXN0LT5yaW5nID0gaW5zdGFuY2U7CiAJaWJzX3JlcXVlc3Qt
Pm51bWJlcl9vZl9pYnMgPSAxOwogCWlic19yZXF1ZXN0LT5pYnMgPSBpYl9pbmZvOwpAQCAtMTM3
NCw3ICsxMzc2LDcgQEAgYW1kZ3B1X3Rlc3RfZXhlY19jc19oZWxwZXIoYW1kZ3B1X2NvbnRleHRf
aGFuZGxlIGNvbnRleHRfaGFuZGxlLAogCWFtZGdwdV90ZXN0X2V4ZWNfY3NfaGVscGVyX3Jhdyhk
ZXZpY2VfaGFuZGxlLCBjb250ZXh0X2hhbmRsZSwKIAkJCQkgICAgICAgaXBfdHlwZSwgaW5zdGFu
Y2UsIHBtNF9kdywgcG00X3NyYywKIAkJCQkgICAgICAgcmVzX2NudCwgcmVzb3VyY2VzLCBpYl9p
bmZvLAotCQkJCSAgICAgICBpYnNfcmVxdWVzdCk7CisJCQkJICAgICAgIGlic19yZXF1ZXN0LCBm
YWxzZSk7CiB9CiAKIHZvaWQKQEAgLTE0NjYsNyArMTQ2OCw3IEBAIGFtZGdwdV9jb21tYW5kX3N1
Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShhbWRncHVfZGV2aWNlX2hh
bmRsZQogCQkJYW1kZ3B1X3Rlc3RfZXhlY19jc19oZWxwZXJfcmF3KGRldmljZSwgY29udGV4dF9o
YW5kbGUsCiAJCQkJCQkgICAgICAgaXBfdHlwZSwgcmluZ19pZCwgaSwgcG00LAogCQkJCQkJICAg
ICAgIDEsIHJlc291cmNlcywgaWJfaW5mbywKLQkJCQkJCSAgICAgICBpYnNfcmVxdWVzdCk7CisJ
CQkJCQkgICAgICAgaWJzX3JlcXVlc3QsIHNlY3VyZSk7CiAKIAkJCS8qIHZlcmlmeSBpZiBTRE1B
IHRlc3QgcmVzdWx0IG1lZXRzIHdpdGggZXhwZWN0ZWQgKi8KIAkJCWkgPSAwOwotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
