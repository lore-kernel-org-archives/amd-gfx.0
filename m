Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B53C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9612420848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9612420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875E56E2B1;
	Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD576E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUjEV0Gg1ByoeO1NzVrwEtOly48BEoF+L+tHwODAv4lLWbVWWlhT5yM3TcBNe+xzw/s7/ShE17NPMpgbWNWgFOTplfmzzz4gmxWO5mfIDnv2elAtpc1JV/yVGtVO7WytaGrO8X/Toeb6oJnLW0OkMnx/+fKRJfixzGBxzDS+sg+hidnr+3YZs540tVGIkSjU8QNNnUljlLAzE3brfkTBgfdDwNGatPyVuvu5Dmw52JOjnzjFe4h8M/PmUq84b6ARURuQ2KrL6CW5Go8M+AzK5VYGKnpqAQvBaTm8Im7oBAnqno2kA9PhLw3tDuIqltMYCPg0PGGa0Mp7v2s0fDqYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iPpaOFqtLegt8v44KJ35/6sbHJ4bN9wZFJGiO7s2/Q=;
 b=JP9HpMbFbhqbvFG31fDYzoY8AJIF+UCSu+Oqo3T7LaIex/XmyPGhVcDhyLOHODSMVN27+KeQV697hJTLfzWDhxgtoP2V7gwk0tMLRSCqqtYgVtPcjLieWQk7OInVZgMcTOhZx1wYuZ7D60CpRaVzz+U8rEYduAiD0wv/EydFCmemSM2HtYeVQWYb0busj/X1BiogjRNb8bBo2r+ibjchICLSfiBtfUy0VmcoqMMyXImyh8/N3TWBqkYjjR4zwC2BWRhG1pG4WYb2PwkvKRkEW6LBiGtjV0nelbQKls9CDen1yZRkExK59IJCcoc9esLeDqW6gNGY3VGbALTVl80qBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:03 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:03 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/51] drm/amd/display: fix dprefclk and ss percentage reading
 on RN
Date: Mon,  2 Dec 2019 12:33:31 -0500
Message-Id: <20191202173405.31582-18-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60ce69ac-51e2-4f8c-c0b6-08d7774df6ba
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802BC9158C75EDA8217CE6E82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3QJE/d6ztpHy1O/U/Dk4UFD5/ZL0BfLsjqsnCId8eH7Axk1URXMNLG7HrrrImCD1X0j/Ara1tQSDZbpz5WctCmKBVZec1ohjfsB7n9GsWQPVBexWW48nyZjEBbaUSj4pnTldXig7Z0J8Kex+8kPA3iul/b/KGx4BO6AAd6MT4qW8/osERcPoJJL/AqDQclxbwwMT3OqdsZtOqLRPqKEWXhBPtg9wMtfaLT+uewEx/2lqHNw45jNHHxigiUmxEtAKqmwgpfXHbIXIH5Y7jIbW0K0mn+8NDJcWgAYhjTWbsey9RpbAXBxy2oo0aJ5VQCQivHsAqa4Vuno+YaZsLhvQRUAAJXbLgf/1o2yZPqs68pgGwJr6+K3iZAK3zDHVOIpTkMOfxgYc3IriJ+beTUsp4dNcb8QT1RHCnEGUTHb2i321r7TydAerz4A6q0TpwhJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ce69ac-51e2-4f8c-c0b6-08d7774df6ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:03.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo42SS5LLbY8fhTs1kshG45btER9uzpXElh3029supEosYzOotxfOQihjGHUplk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iPpaOFqtLegt8v44KJ35/6sbHJ4bN9wZFJGiO7s2/Q=;
 b=eplxBdLw/9iZMKjB8vPJj1xFuaurBeWvXyihMyDOSi+EedfheiOxK6FSMqDPsqpoOecbZcXJqfUZjpXLMyyS/w49tHc+jG//8D2D6Xglk9FCYuBD0BDpzPmYY3Ea/gVDAiKysnYRdsRVX6OeJMJvY5R4TyIa2tDN/6N6jydcXQM=
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, rodrigo.siqueira@amd.com,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+CgpbV2h5XQpCZWZvcmUgd2FzIHVz
aW5nIEhXIGNvdW50ZXIgdmFsdWUgdG8gZGV0ZXJtaW5lIHRoZSBkcHJlZmNsay4gV2hpY2gKdGFr
ZSBpbnRvIGFjY291bnQgc3MsIGJ1dCBoYXMgbGFyZ2UgdmFyaWF0aW9uLCBub3QgZ29vZCBlbm91
Z2ggZm9yCmdlbmVyYXRpbmcgYXVkaW8gZHRvLiBBbHNvLCB0aGUgYmlvcyBwYXJzZXIgY29kZSB0
byBnZXQgdGhlIHNzCnBlcmNlbnRhZ2Ugd2FzIG5vdCB3b3JraW5nLgoKW0hvd10KQWZ0ZXIgdGhp
cyBjaGFuZ2UsIGRwcmVmY2xrIGlzIGhhcmQgY29kZWQsIHNhbWUgYXMgb24gUlYuIFdlIGRvbid0
CmV4cGVjdCB0aGlzIHRvIGNoYW5nZSBvbiBSZW5vaXIuIE1vZGlmaWVkIGJpb3MgcGFyc2VyIGNv
ZGUgdG8gZ2V0CnRoZSByaWdodCBzcyBwZXJjZW50YWdlLgoKU2lnbmVkLW9mZi1ieTogRXJpYyBZ
YW5nIDxFcmljLllhbmcyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNo
ZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiAu
Li4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jICAgfCAgMSArCiAu
Li4vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9jbGtfbWdyLmMgICAgfCAxNiArKyst
LS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L2Nsa19t
Z3IuaCAgfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3Mv
Ymlvc19wYXJzZXIyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9z
X3BhcnNlcjIuYwppbmRleCA3Mjc5NWFlODFkZDAuLmRhMjlmZDYyZjU2YSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKQEAgLTgz
NCw2ICs4MzQsNyBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X3NwcmVh
ZF9zcGVjdHJ1bV9pbmZvKAogCQljYXNlIDE6CiAJCQlyZXR1cm4gZ2V0X3NzX2luZm9fdjRfMShi
cCwgc2lnbmFsLCBpbmRleCwgc3NfaW5mbyk7CiAJCWNhc2UgMjoKKwkJY2FzZSAzOgogCQkJcmV0
dXJuIGdldF9zc19pbmZvX3Y0XzIoYnAsIHNpZ25hbCwgaW5kZXgsIHNzX2luZm8pOwogCQlkZWZh
dWx0OgogCQkJYnJlYWs7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2xrX21nci9kY24yMS9ybl9jbGtfbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY2xrX21nci9kY24yMS9ybl9jbGtfbWdyLmMKaW5kZXggODllZDIzMGNkYjI2Li4zMDdj
ODU0MGUzNmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtf
bWdyL2RjbjIxL3JuX2Nsa19tZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2xrX21nci9kY24yMS9ybl9jbGtfbWdyLmMKQEAgLTY3NSw3ICs2NzUsNiBAQCB2b2lkIHJu
X2Nsa19tZ3JfY29uc3RydWN0KAogewogCXN0cnVjdCBkY19kZWJ1Z19vcHRpb25zICpkZWJ1ZyA9
ICZjdHgtPmRjLT5kZWJ1ZzsKIAlzdHJ1Y3QgZHBtX2Nsb2NrcyBjbG9ja190YWJsZSA9IHsgMCB9
OwotCXN0cnVjdCBjbGtfc3RhdGVfcmVnaXN0ZXJzX2FuZF9ieXBhc3MgcyA9IHsgMCB9OwogCiAJ
Y2xrX21nci0+YmFzZS5jdHggPSBjdHg7CiAJY2xrX21nci0+YmFzZS5mdW5jcyA9ICZkY24yMV9m
dW5jczsKQEAgLTY5NSw3ICs2OTQsNiBAQCB2b2lkIHJuX2Nsa19tZ3JfY29uc3RydWN0KAogCWlm
IChJU19GUEdBX01BWElNVVNfREMoY3R4LT5kY2VfZW52aXJvbm1lbnQpKSB7CiAJCWRjbjIxX2Z1
bmNzLnVwZGF0ZV9jbG9ja3MgPSBkY24yX3VwZGF0ZV9jbG9ja3NfZnBnYTsKIAkJY2xrX21nci0+
YmFzZS5kZW50aXN0X3Zjb19mcmVxX2toeiA9IDM2MDAwMDA7Ci0JCWNsa19tZ3ItPmJhc2UuZHBy
ZWZjbGtfa2h6ID0gNjAwMDAwOwogCX0gZWxzZSB7CiAJCXN0cnVjdCBjbGtfbG9nX2luZm8gbG9n
X2luZm8gPSB7MH07CiAKQEAgLTcwNiwyNCArNzA0LDE2IEBAIHZvaWQgcm5fY2xrX21ncl9jb25z
dHJ1Y3QoCiAJCWlmIChjbGtfbWdyLT5iYXNlLmRlbnRpc3RfdmNvX2ZyZXFfa2h6ID09IDApCiAJ
CQljbGtfbWdyLT5iYXNlLmRlbnRpc3RfdmNvX2ZyZXFfa2h6ID0gMzYwMDAwMDsKIAotCQlybl9k
dW1wX2Nsa19yZWdpc3RlcnMoJnMsICZjbGtfbWdyLT5iYXNlLCAmbG9nX2luZm8pOwotCQkvKiBD
b252ZXJ0IGRwcmVmY2xrIHVuaXRzIGZyb20gTUh6IHRvIEtIeiAqLwotCQkvKiBWYWx1ZSBhbHJl
YWR5IGRpdmlkZWQgYnkgMTAsIHNvbWUgcmVzb2x1dGlvbiBsb3N0ICovCi0JCWNsa19tZ3ItPmJh
c2UuZHByZWZjbGtfa2h6ID0gcy5kcHJlZmNsayAqIDEwMDA7Ci0KLQkJLyogaW4gY2FzZSB3ZSBk
b24ndCBnZXQgYSB2YWx1ZSBmcm9tIHRoZSByZWdpc3RlciwgdXNlIGRlZmF1bHQgKi8KLQkJaWYg
KGNsa19tZ3ItPmJhc2UuZHByZWZjbGtfa2h6ID09IDApIHsKLQkJCUFTU0VSVChjbGtfbWdyLT5i
YXNlLmRwcmVmY2xrX2toeiA9PSA2MDAwMDApOwotCQkJY2xrX21nci0+YmFzZS5kcHJlZmNsa19r
aHogPSA2MDAwMDA7Ci0JCX0KLQogCQlpZiAoY3R4LT5kY19iaW9zLT5pbnRlZ3JhdGVkX2luZm8t
Pm1lbW9yeV90eXBlID09IExwRGRyNE1lbVR5cGUpIHsKIAkJCXJuX2J3X3BhcmFtcy53bV90YWJs
ZSA9IGxwZGRyNF93bV90YWJsZTsKIAkJfSBlbHNlIHsKIAkJCXJuX2J3X3BhcmFtcy53bV90YWJs
ZSA9IGRkcjRfd21fdGFibGU7CiAJCX0KKwkJLyogU2F2ZWQgY2xvY2tzIGNvbmZpZ3VyZWQgYXQg
Ym9vdCBmb3IgZGVidWcgcHVycG9zZXMgKi8KKwkJcm5fZHVtcF9jbGtfcmVnaXN0ZXJzKCZjbGtf
bWdyLT5iYXNlLmJvb3Rfc25hcHNob3QsICZjbGtfbWdyLT5iYXNlLCAmbG9nX2luZm8pOwogCX0K
IAorCWNsa19tZ3ItPmJhc2UuZHByZWZjbGtfa2h6ID0gNjAwMDAwOwogCWRjZV9jbG9ja19yZWFk
X3NzX2luZm8oY2xrX21ncik7CiAKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2luYy9ody9jbGtfbWdyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvaW5jL2h3L2Nsa19tZ3IuaAppbmRleCA0YWEwOWZlOTU0YzUuLmFjNTMwYzA1N2RkZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9ody9jbGtfbWdyLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9ody9jbGtfbWdyLmgKQEAg
LTE5MSw2ICsxOTEsNyBAQCBzdHJ1Y3QgY2xrX21nciB7CiAJYm9vbCBwc3JfYWxsb3dfYWN0aXZl
X2NhY2hlOwogCWludCBkcHJlZmNsa19raHo7IC8vIFVzZWQgYnkgcHJvZ3JhbSBwaXhlbCBjbG9j
ayBpbiBjbG9jayBzb3VyY2UgZnVuY3MsIG5lZWQgdG8gZmlndXJlb3V0IHdoZXJlIHRoaXMgZ29l
cwogCWludCBkZW50aXN0X3Zjb19mcmVxX2toejsKKwlzdHJ1Y3QgY2xrX3N0YXRlX3JlZ2lzdGVy
c19hbmRfYnlwYXNzIGJvb3Rfc25hcHNob3Q7CiAJc3RydWN0IGNsa19id19wYXJhbXMgKmJ3X3Bh
cmFtczsKIH07CiAKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
