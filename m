Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0DC432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2336C2084F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2336C2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893D36E28A;
	Mon,  2 Dec 2019 17:35:54 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8390E6E29B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbESRGE7d3kTnM9bjylcuYHoJJiiy4DqhXpE3EOJI1O/hDH3QVrL1hTx3Pv+h61GEnTRQtDFU7U9hDSQpZMh66bTmdFjHVNiUigItBr5W7CD/z5hP1yFVnxqZ6/Bvs7/ABNO7UU++XpZCOUTZyab3MJ50a/lJlRFoVjNZWnuJA4I+LV8g76YFiZAZlWit0jb7wQZxNhGGzasb9djcD29++VwbACsjNL9tfcZqiu24NnTEPr/LF4XFSgCisobHpZosyWqE3clePoGFDRIuXblmPhZlEbRKwntT7Mi1w0zCK/pJH9KFnenAP6LsjVJPhW/uyUrUOCJX/ajdahczP0qIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSqtKHx3zLLles2apP/hUXlhAMowsuIfHrjB86CycOQ=;
 b=Dz3/yi8tjcdpXPOhMBqokdq+z0N+UwLVfvgPRgB66Rm9CkHdYibyKyGzAc4zhsRAL+MJ7fjocSaySq+8UuIBUjkiVUQbMmcfPERs1o0qKwdIHMdPD0h6hV97te05iQuSUyu+UYoVnCXx+p+ogXh7PlBV48I2b2hkaXXdwkrkE14WsnOFPFCazOork9Sh1Z/7E09g3E3TOtY143l7XMikNwdXj2G6FjnJ0hLN543WuSdLiWT1GRxjWuCa28w/t8LGJlsYMmxnJa183kwjk8jKzwRCBRsxMWkaDkmHRrqALOAhQuPFvO1BO6WVpfwLlMzq7Pep/vWUSmNXu42YIJN0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:49 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:49 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/51] drm/amd/display: add dc dsc functions to return bpp
 range for pixel encoding
Date: Mon,  2 Dec 2019 12:33:51 -0500
Message-Id: <20191202173405.31582-38-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a65efcd-fd9b-414f-0317-08d7774e0148
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610DCB8804C3AF18818C00582430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yr2CIPcWIuY9mDPWqiN0KDZQWUPPoi77tuzHzM++VkqrwueOf5I58pDs+JC7PjpadYHe6/sdz5t+qnQzYVJxkD66DLz2XA4QCmJckLiMs4cY4yGga7nWXKGVQuvQEsjo/WNTc74NKYb3gQQQRnM3s+5fUFZy9LOdluG/ZB4iZT6KMpqygv27+tq8MTsz3tprnM20G+T6DDPieaQrAeWdU8MafAyN5zvZrtsjwkFjQG+Ck09MSkBr6IcJpJiEQP7m/bk7rlFtDt8+aHH5055YMc47iWYi67feXZD4qtaydKlsp85bPrgqx4EQDJytT4SYsD4u2a495ZbArP0XtkEY7HWkgNAVJDKB0Q0mVq6dnfu7Lco17smrF8krECD/bKYyqj0sGvGfoVBmI3GjZCtwfJ29LEvuwyKd18BZqTbj1OFgEqBaQL+8o18g8v5JajnI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a65efcd-fd9b-414f-0317-08d7774e0148
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:21.2833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pEwgovh789/xZyLiobMJ8efbZ1bng9en7qUl8iqLJFELi0haCzQrWglcOogECoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSqtKHx3zLLles2apP/hUXlhAMowsuIfHrjB86CycOQ=;
 b=O1jmrg1k7ylqF8A7yBURpPGBrJdunSxAIXW3z2rqUeohyGY0GoGerCPaTUd1rY8GwsEskuhnLmMxAeDcMz/Z+CeUsvkFboxzhxnBlOc+IQeW2tsf6uiNdhFQ5c4VJZTRZaQIiHFjR4clAdKHLfQ6K9jKp/1D+aioZf0/01VmlK8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Nikola Cornij <Nikola.Cornij@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogV2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFtZC5jb20+Cgpbd2h5XQpOZWVkIHRvIHN1
cHBvcnQgNiBicHAgZm9yIDQyMCBwaXhlbCBlbmNvZGluZyBvbmx5LgoKW2hvd10KQWRkIGEgZGMg
ZnVuY3Rpb24gdG8gZGV0ZXJtaW5lIHdoYXQgYnBwIHJhbmdlIGNhbiBiZSBzdXBwb3J0ZWQKZm9y
IGdpdmVuIHBpeGVsIGVuY29kaW5nLgoKU2lnbmVkLW9mZi1ieTogV2VuamluZyBMaXUgPFdlbmpp
bmcuTGl1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBOaWtvbGEgQ29ybmlqIDxOaWtvbGEuQ29ybmlq
QGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZHNjLmggICAgIHwgIDggKysrLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kc2MvZGNfZHNjLmMgfCAzOCArKysrKysrKysrKysr
KysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZHNjLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZHNjLmgKaW5kZXggY2M5OTE1ZTU0
NWNkLi5kOThiODliYWQzNTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY19kc2MuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZHNj
LmgKQEAgLTUyLDggKzUyLDggQEAgYm9vbCBkY19kc2NfcGFyc2VfZHNjX2RwY2QoY29uc3QgdWlu
dDhfdCAqZHBjZF9kc2NfYmFzaWNfZGF0YSwKIGJvb2wgZGNfZHNjX2NvbXB1dGVfYmFuZHdpZHRo
X3JhbmdlKAogCQljb25zdCBzdHJ1Y3QgZGlzcGxheV9zdHJlYW1fY29tcHJlc3NvciAqZHNjLAog
CQljb25zdCB1aW50MzJfdCBkc2NfbWluX3NsaWNlX2hlaWdodF9vdmVycmlkZSwKLQkJY29uc3Qg
dWludDMyX3QgbWluX2ticHMsCi0JCWNvbnN0IHVpbnQzMl90IG1heF9rYnBzLAorCQljb25zdCB1
aW50MzJfdCBtaW5fYnBwLAorCQljb25zdCB1aW50MzJfdCBtYXhfYnBwLAogCQljb25zdCBzdHJ1
Y3QgZHNjX2RlY19kcGNkX2NhcHMgKmRzY19zaW5rX2NhcHMsCiAJCWNvbnN0IHN0cnVjdCBkY19j
cnRjX3RpbWluZyAqdGltaW5nLAogCQlzdHJ1Y3QgZGNfZHNjX2J3X3JhbmdlICpyYW5nZSk7CkBA
IC02NSw0ICs2NSw4IEBAIGJvb2wgZGNfZHNjX2NvbXB1dGVfY29uZmlnKAogCQl1aW50MzJfdCB0
YXJnZXRfYmFuZHdpZHRoX2ticHMsCiAJCWNvbnN0IHN0cnVjdCBkY19jcnRjX3RpbWluZyAqdGlt
aW5nLAogCQlzdHJ1Y3QgZGNfZHNjX2NvbmZpZyAqZHNjX2NmZyk7CisKK2Jvb2wgZGNfZHNjX2dl
dF9icHBfcmFuZ2VfZm9yX3BpeGVsX2VuY29kaW5nKGVudW0gZGNfcGl4ZWxfZW5jb2RpbmcgcGl4
ZWxfZW5jLAorCQl1aW50MzJfdCAqbWluX2JwcCwKKwkJdWludDMyX3QgKm1heF9icHApOwogI2Vu
ZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZHNjL2RjX2Rz
Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RzYy9kY19kc2MuYwppbmRleCBl
Yzg2YmE3M2EwMzkuLmZlYmFlNmNjNzI5NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RzYy9kY19kc2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZHNjL2RjX2RzYy5jCkBAIC0zMSwxNiArMzEsMTIgQEAgc3RydWN0IGRjX2RzY19wb2xp
Y3kgewogCWJvb2wgdXNlX21pbl9zbGljZXNfaDsKIAlpbnQgbWF4X3NsaWNlc19oOyAvLyBNYXhp
bXVtIGF2YWlsYWJsZSBpZiAwCiAJaW50IG1pbl9zaWNlX2hlaWdodDsgLy8gTXVzdCBub3QgYmUg
bGVzcyB0aGFuIDgKLQlpbnQgbWF4X3RhcmdldF9icHA7Ci0JaW50IG1pbl90YXJnZXRfYnBwOyAv
LyBNaW5pbXVtIHRhcmdldCBiaXRzIHBlciBwaXhlbAogfTsKIAogY29uc3Qgc3RydWN0IGRjX2Rz
Y19wb2xpY3kgZHNjX3BvbGljeSA9IHsKIAkudXNlX21pbl9zbGljZXNfaCA9IHRydWUsIC8vIERT
QyBQb2xpY3k6IFVzZSBtaW5pbXVtIG51bWJlciBvZiBzbGljZXMgdGhhdCBmaXRzIHRoZSBwaXhl
bCBjbG9jawogCS5tYXhfc2xpY2VzX2ggPSAwLCAvLyBEU0MgUG9saWN5OiBVc2UgbWF4IGF2YWls
YWJsZSBzbGljZXMgKGluIG91ciBjYXNlIDQgZm9yIG9yIDgsIGRlcGVuZGluZyBvbiB0aGUgbW9k
ZSkKIAkubWluX3NpY2VfaGVpZ2h0ID0gMTA4LCAvLyBEU0MgUG9saWN5OiBVc2Ugc2xpY2UgaGVp
Z2h0IHJlY29tbWVuZGVkIGJ5IFZFU0EgRFNDIFNwcmVhZHNoZWV0IHVzZXIgZ3VpZGUKLQkubWF4
X3RhcmdldF9icHAgPSAxNiwKLQkubWluX3RhcmdldF9icHAgPSA4LAogfTsKIAogCkBAIC0zNzQs
NyArMzcwLDYgQEAgc3RhdGljIHZvaWQgZ2V0X2RzY19iYW5kd2lkdGhfcmFuZ2UoCiAgKiAgICAg
ICAgb3IgaWYgaXQgY291bGRuJ3QgYmUgYXBwbGllZCBiYXNlZCBvbiBEU0MgcG9saWN5LgogICov
CiBzdGF0aWMgYm9vbCBkZWNpZGVfZHNjX3RhcmdldF9icHBfeDE2KAotCQljb25zdCBzdHJ1Y3Qg
ZGNfZHNjX3BvbGljeSAqcG9saWN5LAogCQljb25zdCBzdHJ1Y3QgZHNjX2VuY19jYXBzICpkc2Nf
Y29tbW9uX2NhcHMsCiAJCWNvbnN0IGludCB0YXJnZXRfYmFuZHdpZHRoX2ticHMsCiAJCWNvbnN0
IHN0cnVjdCBkY19jcnRjX3RpbWluZyAqdGltaW5nLApAQCAtMzgyLDEwICszNzcsMTMgQEAgc3Rh
dGljIGJvb2wgZGVjaWRlX2RzY190YXJnZXRfYnBwX3gxNigKIHsKIAlib29sIHNob3VsZF91c2Vf
ZHNjID0gZmFsc2U7CiAJc3RydWN0IGRjX2RzY19id19yYW5nZSByYW5nZTsKKwl1aW50MzJfdCBt
aW5fdGFyZ2V0X2JwcCA9IDA7CisJdWludDMyX3QgbWF4X3RhcmdldF9icHAgPSAwOwogCiAJbWVt
c2V0KCZyYW5nZSwgMCwgc2l6ZW9mKHJhbmdlKSk7CiAKLQlnZXRfZHNjX2JhbmR3aWR0aF9yYW5n
ZShwb2xpY3ktPm1pbl90YXJnZXRfYnBwLCBwb2xpY3ktPm1heF90YXJnZXRfYnBwLAorCWRjX2Rz
Y19nZXRfYnBwX3JhbmdlX2Zvcl9waXhlbF9lbmNvZGluZyh0aW1pbmctPnBpeGVsX2VuY29kaW5n
LCAmbWluX3RhcmdldF9icHAsICZtYXhfdGFyZ2V0X2JwcCk7CisJZ2V0X2RzY19iYW5kd2lkdGhf
cmFuZ2UobWluX3RhcmdldF9icHAsIG1heF90YXJnZXRfYnBwLAogCQkJZHNjX2NvbW1vbl9jYXBz
LCB0aW1pbmcsICZyYW5nZSk7CiAJaWYgKHRhcmdldF9iYW5kd2lkdGhfa2JwcyA+PSByYW5nZS5z
dHJlYW1fa2JwcykgewogCQkvKiBlbm91Z2ggYmFuZHdpZHRoIHdpdGhvdXQgZHNjICovCkBAIC01
OTksNyArNTk3LDcgQEAgc3RhdGljIGJvb2wgc2V0dXBfZHNjX2NvbmZpZygKIAkJZ290byBkb25l
OwogCiAJaWYgKHRhcmdldF9iYW5kd2lkdGhfa2JwcyA+IDApIHsKLQkJaXNfZHNjX3Bvc3NpYmxl
ID0gZGVjaWRlX2RzY190YXJnZXRfYnBwX3gxNigmZHNjX3BvbGljeSwgJmRzY19jb21tb25fY2Fw
cywgdGFyZ2V0X2JhbmR3aWR0aF9rYnBzLCB0aW1pbmcsICZ0YXJnZXRfYnBwKTsKKwkJaXNfZHNj
X3Bvc3NpYmxlID0gZGVjaWRlX2RzY190YXJnZXRfYnBwX3gxNigmZHNjX2NvbW1vbl9jYXBzLCB0
YXJnZXRfYmFuZHdpZHRoX2ticHMsIHRpbWluZywgJnRhcmdldF9icHApOwogCQlkc2NfY2ZnLT5i
aXRzX3Blcl9waXhlbCA9IHRhcmdldF9icHA7CiAJfQogCWlmICghaXNfZHNjX3Bvc3NpYmxlKQpA
QCAtOTA2LDMgKzkwNCwyOSBAQCBib29sIGRjX2RzY19jb21wdXRlX2NvbmZpZygKIAkJCXRpbWlu
ZywgZHNjX21pbl9zbGljZV9oZWlnaHRfb3ZlcnJpZGUsIGRzY19jZmcpOwogCXJldHVybiBpc19k
c2NfcG9zc2libGU7CiB9CisKK2Jvb2wgZGNfZHNjX2dldF9icHBfcmFuZ2VfZm9yX3BpeGVsX2Vu
Y29kaW5nKGVudW0gZGNfcGl4ZWxfZW5jb2RpbmcgcGl4ZWxfZW5jLAorCQl1aW50MzJfdCAqbWlu
X2JwcCwKKwkJdWludDMyX3QgKm1heF9icHApCit7CisJYm9vbCByZXN1bHQgPSB0cnVlOworCisJ
c3dpdGNoIChwaXhlbF9lbmMpIHsKKwljYXNlIFBJWEVMX0VOQ09ESU5HX1JHQjoKKwljYXNlIFBJ
WEVMX0VOQ09ESU5HX1lDQkNSNDQ0OgorCWNhc2UgUElYRUxfRU5DT0RJTkdfWUNCQ1I0MjI6CisJ
CSptaW5fYnBwID0gODsKKwkJKm1heF9icHAgPSAxNjsKKwkJYnJlYWs7CisJY2FzZSBQSVhFTF9F
TkNPRElOR19ZQ0JDUjQyMDoKKwkJKm1pbl9icHAgPSA2OworCQkqbWF4X2JwcCA9IDE2OworCQli
cmVhazsKKwlkZWZhdWx0OgorCQkqbWluX2JwcCA9IDA7CisJCSptYXhfYnBwID0gMDsKKwkJcmVz
dWx0ID0gZmFsc2U7CisJfQorCisJcmV0dXJuIHJlc3VsdDsKK30KLS0gCjIuMjQuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
