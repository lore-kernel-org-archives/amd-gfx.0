Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A8C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D24D206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D24D206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E5072BD0;
	Wed,  4 Dec 2019 09:54:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37EC72BEF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 09:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPISG/T9XZnY0Iy/m719KDgrTlUoD6hrTflc4q6YERpA39cYrJuFpJWLPtyDvnLj4Y2SCrMMSUpm9D7MXOvidWoMqnUz9FPI7bEvtIQwREfPEhJwsEByOHNG0lRrRL69UGPrYj4qJfahFvv2MH1eQ4UoWgECcQlOFDc3GN6wi4C4Mnn1LkTr/U41nHoBpJqzONlfl0RcEIwz2DE08WEKwu/W6alp4sUKDAL+Eo+EETRitNWPjDJECo7xHlsp6q+GXXvoEEIyaigMGqlH0y0lyF25lQDTgtUzM8K+snOM8ojZ4HeB8ZnvZL6M3IRDExTg5hfbTw08hks3KN0eO5Ujuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd5NUOW6aeDrvwybtDMFbUniwb7gzgk5QnpzE/GpMss=;
 b=PiLOD2XpGALZY/s+oyU72QDDKmGL3Z/AYPMjArHu67jClhRAFfSwhQVgqhq2w0W9Jv0/XvF3CND/747ObrsW+bcJqOcEdpNuGR0cq9+/axIAvVH9cOtVfFOMstmDnhMkR/ChRixaHKKAHHQY1LvpLc0sGUiLCSizT+QsiDBYp7O+J2IR8Sr9Iw0lKiW4bfdtjLDs5r09+F1FvZpHV22c3J5R8Az6uJ+/8BO27IWWfnN3Y0LdsrEP22RHzlpidFhqu+y/hB1n03CKHLLKinFqyxob8i+66lwWqHpUoPNPkSB7LX7ry30kkMLXMnbCXimFXtsGDRCOyXchsQyjXEs25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3021.namprd12.prod.outlook.com (20.178.240.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 09:54:09 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 09:54:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before issuing
 message
Date: Wed,  4 Dec 2019 17:53:39 +0800
Message-Id: <20191204095339.25497-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204095339.25497-1-evan.quan@amd.com>
References: <20191204095339.25497-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ad3069a-0ae1-40ee-df4f-08d7789fe854
X-MS-TrafficTypeDiagnostic: MN2PR12MB3021:|MN2PR12MB3021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3021E3F916D74C1108E83D44E45D0@MN2PR12MB3021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(36756003)(6512007)(3846002)(50466002)(4326008)(7736002)(15650500001)(446003)(305945005)(2361001)(6916009)(6486002)(6116002)(1076003)(2870700001)(2906002)(44832011)(26005)(6436002)(2351001)(11346002)(316002)(8676002)(48376002)(25786009)(6666004)(8936002)(66946007)(478600001)(86362001)(66476007)(6506007)(386003)(66556008)(5660300002)(81156014)(81166006)(99286004)(76176011)(51416003)(52116002)(50226002)(2616005)(14454004)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3021;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1AvP95QG9n37cp/+DIlriXdiXx1uCxXtDuB0jluFmsxUR/4grOPCI4xyOKTz0V1cyMuPDZ1t5hzWeDM3sE/vaED33Yd8LS1qbYveVg2H7aSQx2PgzXX/7ZB9puJpf5UgT/ZML+c+w5FYl5uDTceVe1sOV8EwMaBR18V+ZlOQt+OTUv0yR7Hjaa1xTPNuqxDk+gEeuFsg9z5J31XISbqE5jCX0I7U8ZSPlnF9nRsx+5Eu0yPlPjRsHiAAf2sZ1KeayietEhdh9NQX/pb60mH1xJ57LcEiGboqZ0mHtKni+bYTcDE0wLv/050Cniov29AXAC/FKltMiWrWZDN639TDuWnkX2cZsymB8vRkJL/BYVOj0ht4ngJ8P5wZ6TGXZ+mqEpDHtW3djlkDfHRG6MUysLkuKfzTNfeQQxfWDxpNbo9FoxuYrs3ovtFmCESXbFq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad3069a-0ae1-40ee-df4f-08d7789fe854
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 09:54:09.2202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHZUjMNqJLgH8+96dkAfJzEykwVbFjdSQrzgk1xj26TWAw6vs6gBVOBM4jgl8eB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3021
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd5NUOW6aeDrvwybtDMFbUniwb7gzgk5QnpzE/GpMss=;
 b=nmpoKF2Jw2C9MGIb94GunMdiZUM9Bo9g17BLe8yhurPBN+gU3rZXoZ8y81bDQSSM75oGlF06yOWpw/x2ulHSxLOH0P4xqoPoFsFGBZhDeZHGJO+Jz0hC9PHXG6imG3FTjAT0VbsIv2gW0ZeoZc3QBvX/Lee5qs/riy1ze+s8bs0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWJvcnQgdGhlIG1lc3NhZ2UgaXNzdWluZyBpZiB0aGUgU01VIHdhcyBub3QgaW4gdGhlIHJpZ2h0
IHN0YXRlLgoKQ2hhbmdlLUlkOiBJZGE5ZjkxMWUwNTFmNmU3OGRlNGY0NzU5NTZjNzg2MzdlNTZl
NmVhMwpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIHwgMTYgKysrKysrKystLS0t
LS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMgfCAxNiArKysr
KysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92
MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXgg
MzI1ZWM0ODY0ZjkwLi5kODRjN2Y1ZmIwMWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3NtdV92MTFfMC5jCkBAIC02OCwxNSArNjgsMTMgQEAgc3RhdGljIGludCBzbXVfdjExXzBf
d2FpdF9mb3JfcmVzcG9uc2Uoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiAJZm9yIChpID0gMDsg
aSA8IHRpbWVvdXQ7IGkrKykgewogCQljdXJfdmFsdWUgPSBSUkVHMzJfU09DMTUoTVAxLCAwLCBt
bU1QMV9TTU5fQzJQTVNHXzkwKTsKIAkJaWYgKChjdXJfdmFsdWUgJiBNUDFfQzJQTVNHXzkwX19D
T05URU5UX01BU0spICE9IDApCi0JCQlicmVhazsKKwkJCXJldHVybiBjdXJfdmFsdWUgPT0gMHgx
ID8gMCA6IC1FSU87CisKIAkJdWRlbGF5KDEpOwogCX0KIAogCS8qIHRpbWVvdXQgbWVhbnMgd3Jv
bmcgbG9naWMgKi8KLQlpZiAoaSA9PSB0aW1lb3V0KQotCQlyZXR1cm4gLUVUSU1FOwotCi0JcmV0
dXJuIFJSRUczMl9TT0MxNShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTApID09IDB4MSA/IDAg
OiAtRUlPOworCXJldHVybiAtRVRJTUU7CiB9CiAKIGludApAQCAtOTIsOSArOTAsMTEgQEAgc211
X3YxMV8wX3NlbmRfbXNnX3dpdGhfcGFyYW0oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJCXJl
dHVybiBpbmRleDsKIAogCXJldCA9IHNtdV92MTFfMF93YWl0X2Zvcl9yZXNwb25zZShzbXUpOwot
CWlmIChyZXQpCi0JCXByX2VycigiZmFpbGVkIHNlbmQgbWVzc2FnZTogJTEwcyAoJWQpIFx0cGFy
YW06IDB4JTA4eCByZXNwb25zZSAlI3hcbiIsCi0JCSAgICAgICBzbXVfZ2V0X21lc3NhZ2VfbmFt
ZShzbXUsIG1zZyksIGluZGV4LCBwYXJhbSwgcmV0KTsKKwlpZiAocmV0KSB7CisJCXByX2Vycigi
TXNnIGlzc3VpbmcgcHJlLWNoZWNrIGZhaWxlZCBhbmQgIgorCQkgICAgICAgIlNNVSBtYXkgYmUg
bm90IGluIHRoZSByaWdodCBzdGF0ZSFcbiIpOworCQlyZXR1cm4gcmV0OworCX0KIAogCVdSRUcz
Ml9TT0MxNShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTAsIDApOwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jCmluZGV4IDdmNWY3ZTEyYTQxZS4uYTYzODMyNmJh
MWI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYwpAQCAtNTYs
MTUgKzU2LDEzIEBAIGludCBzbXVfdjEyXzBfd2FpdF9mb3JfcmVzcG9uc2Uoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUpCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnVzZWNfdGltZW91dDsgaSsrKSB7
CiAJCWN1cl92YWx1ZSA9IFJSRUczMl9TT0MxNShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTAp
OwogCQlpZiAoKGN1cl92YWx1ZSAmIE1QMV9DMlBNU0dfOTBfX0NPTlRFTlRfTUFTSykgIT0gMCkK
LQkJCWJyZWFrOworCQkJcmV0dXJuIGN1cl92YWx1ZSA9PSAweDEgPyAwIDogLUVJTzsKKwogCQl1
ZGVsYXkoMSk7CiAJfQogCiAJLyogdGltZW91dCBtZWFucyB3cm9uZyBsb2dpYyAqLwotCWlmIChp
ID09IGFkZXYtPnVzZWNfdGltZW91dCkKLQkJcmV0dXJuIC1FVElNRTsKLQotCXJldHVybiBSUkVH
MzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKSA9PSAweDEgPyAwIDogLUVJTzsK
KwlyZXR1cm4gLUVUSU1FOwogfQogCiBpbnQKQEAgLTgwLDkgKzc4LDExIEBAIHNtdV92MTJfMF9z
ZW5kX21zZ193aXRoX3BhcmFtKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQlyZXR1cm4gaW5k
ZXg7CiAKIAlyZXQgPSBzbXVfdjEyXzBfd2FpdF9mb3JfcmVzcG9uc2Uoc211KTsKLQlpZiAocmV0
KQotCQlwcl9lcnIoIkZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMHgleCwgcmVzcG9uc2UgMHgleCwg
cGFyYW0gMHgleFxuIiwKLQkJICAgICAgIGluZGV4LCByZXQsIHBhcmFtKTsKKwlpZiAocmV0KSB7
CisJCXByX2VycigiTXNnIGlzc3VpbmcgcHJlLWNoZWNrIGZhaWxlZCBhbmQgIgorCQkgICAgICAg
IlNNVSBtYXkgYmUgbm90IGluIHRoZSByaWdodCBzdGF0ZSFcbiIpOworCQlyZXR1cm4gcmV0Owor
CX0KIAogCVdSRUczMl9TT0MxNShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTAsIDApOwogCi0t
IAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
