Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB3FC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E126820848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E126820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D4C6E2DE;
	Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820041.outbound.protection.outlook.com [40.107.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6606E28A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilBcidanpT6757WXesxVpwczZE7sv7JFRCYrRoJ6V2XVyCjh7hCfxPcvPdbv+g8pOKW7gr9vVtRdE8KBYtU3JZirqjCtfEtaLVcpi+MmZ2pNLT+zCDmunuOHvQZ3EGsHWAjOOuioo4iU+Q8TnYMlOtCdZcMGJ7PxdGJANXCqVpfSIG4Dbj6wF7WaGEN07Tw1bH4in7lpGP8eFHJSPIKYZqDOdrsa7fK95VvGaVblmiliaiObeSjseThYF951ju5tBJJzEGZpNk52flSBdJ57HmnFHw9I40qPXk3ZFUjds+RErHzwzXKqThi7OWfaLfU9J5rQaOTFNYBmN85jpWmiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCEI4fbP5FJLrcsqAkAHqaczFXaztcP02IEuYJGa2m8=;
 b=hdzLMzhEy5AlMCi/MBqBF45VXGNFa0sppvnzAXJO0bb9oCV35DZMMuZqCKhzNE+SmgzeScb4Ice0HOaVWe9h/8/lPrkiqwKuA7axDK+oaANI6YXfrAG4K3LMa/4/S7q1GZt7uiKraLcCYoG9COl29tX6IdvQu/YXXq5MzAR2CFOntnALC2g4UkqpIyaCgP5ZNTgEmu2IdzWzlD31vb/fzQMKs4yoCzNb6QJwHU4R+VMvT341Pu6gfxyC6Rs+srHLHaovHUpmNvGZPdCbo1njZFcYvM+yaCJnP3jYHs33aTLG1gEW1U90YIQYrlwgY4JGosta9m6QxXaEhotBqJ5cfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:52 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:52 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 42/51] drm/amd/display: Fix screen tearing on vrr tests
Date: Mon,  2 Dec 2019 12:33:56 -0500
Message-Id: <20191202173405.31582-43-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 65582f35-f6bd-42b4-30da-08d7774e03dc
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28022B17EB62270E8FB1119782430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ov1MZNpUKekGU/leh7SuywEd+8/CfkPH48ghVod0Hz+yWe+fSEG3oOrk/5uY73agspc4d0mNXP/ArapFQxAmwiBEiPRljlsguKJ9FKPl5bU1WUPqU/JkBNzjK2o7g4+VcMbJzqwXcM7tqidp+Ps0pTMovVIYWaIqwOJZWBzFKYxRlFbPxVTQti9sDDkfwB/bbAZErwGNgMpHV57ds+hA+XkA/bi/rixi39DxJFntWDwj5uFcQnaK2VG+C32eNZg2RMzE0R772tAVSvGvJ0iKC4jdCSHRtU3da7qxiu1jH5iIdJnoY80mfNz5lksYnLyHnkinUjcuwqrWSv2yZlLkxM8RmLMTFaAsWQzStcuudTulbbGPPBE+PkYRTBWsUQfCwSEyYwm/c/7Fba2RKQJlhkZymXuu8Z5CbkwULIHi+Okb9CFBmEByVit3P/SGbQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65582f35-f6bd-42b4-30da-08d7774e03dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:25.4869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyqii4kK4/+M+p1eqE6YotMSNCVsgj0cO5qXcakra1dl62kyiOmTcFZITsL0jkU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCEI4fbP5FJLrcsqAkAHqaczFXaztcP02IEuYJGa2m8=;
 b=w/7F8i/BZNahNZEcM4KKogNlS03MShSptK8cIoy1Pzw9YTy5tGmxMBZ2oAzykx4Jwl4H9Ilk3vlTKWH7oE9nz79YbtNDhycdK28da5hZNMw/kcUtMpmb8RgyzEhgohRypZx4Jch0BrP4pk6DO3LgDmLntTw+pMi8f9x3UZH4c/k=
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Amanda Liu <amanda.liu@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQW1hbmRhIExpdSA8YW1hbmRhLmxpdUBhbWQuY29tPgoKW1doeV0KU2NyZWVuIHRlYXJp
bmcgaXMgcHJlc2VudCBpbiB0ZXN0cyB3aGVuIHNldHRpbmcgdGhlIGZyYW1lIHJhdGUgdG8KY2Vy
dGFpbiBmcHMKCltIb3ddClJldmVydCBwcmV2aW91cyBvcHRpbWl6YXRpb25zIGZvciBsb3cgZnJh
bWUgcmF0ZXMuCgpTaWduZWQtb2ZmLWJ5OiBBbWFuZGEgTGl1IDxhbWFuZGEubGl1QGFtZC5jb20+
ClJldmlld2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5DeXJAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBM
aSA8c3VucGVuZy5saUBhbWQuY29tPgotLS0KIC4uLi9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVz
eW5jL2ZyZWVzeW5jLmMgICB8IDMyICsrKysrKysrLS0tLS0tLS0tLS0KIC4uLi9hbWQvZGlzcGxh
eS9tb2R1bGVzL2luYy9tb2RfZnJlZXN5bmMuaCAgICB8ICAxIC0KIDIgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMKaW5kZXggMTZl
NjliYmM2OWFhLi41NDM3YjUwZTlmOTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYwpAQCAtMzcsOCArMzcsOCBA
QAogI2RlZmluZSBTVEFUSUNfU0NSRUVOX1JBTVBfREVMVEFfUkVGUkVTSF9SQVRFX1BFUl9GUkFN
RSAoKDEwMDAgLyA2MCkgKiA2NSkKIC8qIE51bWJlciBvZiBlbGVtZW50cyBpbiB0aGUgcmVuZGVy
IHRpbWVzIGNhY2hlIGFycmF5ICovCiAjZGVmaW5lIFJFTkRFUl9USU1FU19NQVhfQ09VTlQgMTAK
LS8qIFRocmVzaG9sZCB0byBleGl0L2V4aXQgQlRSICh0byBhdm9pZCBmcmVxdWVudCBlbnRlci1l
eGl0cyBhdCB0aGUgbG93ZXIgbGltaXQpICovCi0jZGVmaW5lIEJUUl9NQVhfTUFSR0lOIDI1MDAK
Ky8qIFRocmVzaG9sZCB0byBleGl0IEJUUiAodG8gYXZvaWQgZnJlcXVlbnQgZW50ZXItZXhpdHMg
YXQgdGhlIGxvd2VyIGxpbWl0KSAqLworI2RlZmluZSBCVFJfRVhJVF9NQVJHSU4gMjAwMAogLyog
VGhyZXNob2xkIHRvIGNoYW5nZSBCVFIgbXVsdGlwbGllciAodG8gYXZvaWQgZnJlcXVlbnQgY2hh
bmdlcykgKi8KICNkZWZpbmUgQlRSX0RSSUZUX01BUkdJTiAyMDAwCiAvKlRocmVzaG9sZCB0byBl
eGl0IGZpeGVkIHJlZnJlc2ggcmF0ZSovCkBAIC0yNTQsMjIgKzI1NCwyNCBAQCBzdGF0aWMgdm9p
ZCBhcHBseV9iZWxvd190aGVfcmFuZ2Uoc3RydWN0IGNvcmVfZnJlZXN5bmMgKmNvcmVfZnJlZXN5
bmMsCiAJdW5zaWduZWQgaW50IGRlbHRhX2Zyb21fbWlkX3BvaW50X2luX3VzXzEgPSAweEZGRkZG
RkZGOwogCXVuc2lnbmVkIGludCBkZWx0YV9mcm9tX21pZF9wb2ludF9pbl91c18yID0gMHhGRkZG
RkZGRjsKIAl1bnNpZ25lZCBpbnQgZnJhbWVzX3RvX2luc2VydCA9IDA7CisJdW5zaWduZWQgaW50
IG1pbl9mcmFtZV9kdXJhdGlvbl9pbl9ucyA9IDA7CisJdW5zaWduZWQgaW50IG1heF9yZW5kZXJf
dGltZV9pbl91cyA9IGluX291dF92cnItPm1heF9kdXJhdGlvbl9pbl91czsKIAl1bnNpZ25lZCBp
bnQgZGVsdGFfZnJvbV9taWRfcG9pbnRfZGVsdGFfaW5fdXM7Ci0JdW5zaWduZWQgaW50IG1heF9y
ZW5kZXJfdGltZV9pbl91cyA9Ci0JCQlpbl9vdXRfdnJyLT5tYXhfZHVyYXRpb25faW5fdXMgLSBp
bl9vdXRfdnJyLT5idHIubWFyZ2luX2luX3VzOworCisJbWluX2ZyYW1lX2R1cmF0aW9uX2luX25z
ID0gKCh1bnNpZ25lZCBpbnQpIChkaXY2NF91NjQoCisJCSgxMDAwMDAwMDAwVUxMICogMTAwMDAw
MCksCisJCWluX291dF92cnItPm1heF9yZWZyZXNoX2luX3VoeikpKTsKIAogCS8qIFByb2dyYW0g
QlRSICovCi0JaWYgKChsYXN0X3JlbmRlcl90aW1lX2luX3VzICsgaW5fb3V0X3Zyci0+YnRyLm1h
cmdpbl9pbl91cyAvIDIpIDwgbWF4X3JlbmRlcl90aW1lX2luX3VzKSB7CisJaWYgKGxhc3RfcmVu
ZGVyX3RpbWVfaW5fdXMgKyBCVFJfRVhJVF9NQVJHSU4gPCBtYXhfcmVuZGVyX3RpbWVfaW5fdXMp
IHsKIAkJLyogRXhpdCBCZWxvdyB0aGUgUmFuZ2UgKi8KIAkJaWYgKGluX291dF92cnItPmJ0ci5i
dHJfYWN0aXZlKSB7CiAJCQlpbl9vdXRfdnJyLT5idHIuZnJhbWVfY291bnRlciA9IDA7CiAJCQlp
bl9vdXRfdnJyLT5idHIuYnRyX2FjdGl2ZSA9IGZhbHNlOwogCQl9Ci0JfSBlbHNlIGlmIChsYXN0
X3JlbmRlcl90aW1lX2luX3VzID4gKG1heF9yZW5kZXJfdGltZV9pbl91cyArIGluX291dF92cnIt
PmJ0ci5tYXJnaW5faW5fdXMgLyAyKSkgeworCX0gZWxzZSBpZiAobGFzdF9yZW5kZXJfdGltZV9p
bl91cyA+IG1heF9yZW5kZXJfdGltZV9pbl91cykgewogCQkvKiBFbnRlciBCZWxvdyB0aGUgUmFu
Z2UgKi8KLQkJaWYgKCFpbl9vdXRfdnJyLT5idHIuYnRyX2FjdGl2ZSkgewotCQkJaW5fb3V0X3Zy
ci0+YnRyLmJ0cl9hY3RpdmUgPSB0cnVlOwotCQl9CisJCWluX291dF92cnItPmJ0ci5idHJfYWN0
aXZlID0gdHJ1ZTsKIAl9CiAKIAkvKiBCVFIgc2V0IHRvICJub3QgYWN0aXZlIiBzbyBkaXNlbmdh
Z2UgKi8KQEAgLTMyNSw5ICszMjcsNyBAQCBzdGF0aWMgdm9pZCBhcHBseV9iZWxvd190aGVfcmFu
Z2Uoc3RydWN0IGNvcmVfZnJlZXN5bmMgKmNvcmVfZnJlZXN5bmMsCiAJCS8qIENob29zZSBudW1i
ZXIgb2YgZnJhbWVzIHRvIGluc2VydCBiYXNlZCBvbiBob3cgY2xvc2UgaXQKIAkJICogY2FuIGdl
dCB0byB0aGUgbWlkIHBvaW50IG9mIHRoZSB2YXJpYWJsZSByYW5nZS4KIAkJICovCi0JCWlmICgo
ZnJhbWVfdGltZV9pbl91cyAvIG1pZF9wb2ludF9mcmFtZXNfY2VpbCkgPiBpbl9vdXRfdnJyLT5t
aW5fZHVyYXRpb25faW5fdXMgJiYKLQkJCQkoZGVsdGFfZnJvbV9taWRfcG9pbnRfaW5fdXNfMSA8
IGRlbHRhX2Zyb21fbWlkX3BvaW50X2luX3VzXzIgfHwKLQkJCQkJCW1pZF9wb2ludF9mcmFtZXNf
Zmxvb3IgPCAyKSkgeworCQlpZiAoZGVsdGFfZnJvbV9taWRfcG9pbnRfaW5fdXNfMSA8IGRlbHRh
X2Zyb21fbWlkX3BvaW50X2luX3VzXzIpIHsKIAkJCWZyYW1lc190b19pbnNlcnQgPSBtaWRfcG9p
bnRfZnJhbWVzX2NlaWw7CiAJCQlkZWx0YV9mcm9tX21pZF9wb2ludF9kZWx0YV9pbl91cyA9IGRl
bHRhX2Zyb21fbWlkX3BvaW50X2luX3VzXzIgLQogCQkJCQlkZWx0YV9mcm9tX21pZF9wb2ludF9p
bl91c18xOwpAQCAtMzQzLDcgKzM0Myw3IEBAIHN0YXRpYyB2b2lkIGFwcGx5X2JlbG93X3RoZV9y
YW5nZShzdHJ1Y3QgY29yZV9mcmVlc3luYyAqY29yZV9mcmVlc3luYywKIAkJaWYgKGluX291dF92
cnItPmJ0ci5mcmFtZXNfdG9faW5zZXJ0ICE9IDAgJiYKIAkJCQlkZWx0YV9mcm9tX21pZF9wb2lu
dF9kZWx0YV9pbl91cyA8IEJUUl9EUklGVF9NQVJHSU4pIHsKIAkJCWlmICgoKGxhc3RfcmVuZGVy
X3RpbWVfaW5fdXMgLyBpbl9vdXRfdnJyLT5idHIuZnJhbWVzX3RvX2luc2VydCkgPAotCQkJCQlt
YXhfcmVuZGVyX3RpbWVfaW5fdXMpICYmCisJCQkJCWluX291dF92cnItPm1heF9kdXJhdGlvbl9p
bl91cykgJiYKIAkJCQkoKGxhc3RfcmVuZGVyX3RpbWVfaW5fdXMgLyBpbl9vdXRfdnJyLT5idHIu
ZnJhbWVzX3RvX2luc2VydCkgPgogCQkJCQlpbl9vdXRfdnJyLT5taW5fZHVyYXRpb25faW5fdXMp
KQogCQkJCWZyYW1lc190b19pbnNlcnQgPSBpbl9vdXRfdnJyLT5idHIuZnJhbWVzX3RvX2luc2Vy
dDsKQEAgLTc5NiwxMSArNzk2LDYgQEAgdm9pZCBtb2RfZnJlZXN5bmNfYnVpbGRfdnJyX3BhcmFt
cyhzdHJ1Y3QgbW9kX2ZyZWVzeW5jICptb2RfZnJlZXN5bmMsCiAJCXJlZnJlc2hfcmFuZ2UgPSBp
bl9vdXRfdnJyLT5tYXhfcmVmcmVzaF9pbl91aHogLQogCQkJCWluX291dF92cnItPm1pbl9yZWZy
ZXNoX2luX3VoejsKIAotCQlpbl9vdXRfdnJyLT5idHIubWFyZ2luX2luX3VzID0gaW5fb3V0X3Zy
ci0+bWF4X2R1cmF0aW9uX2luX3VzIC0KLQkJCQkyICogaW5fb3V0X3Zyci0+bWluX2R1cmF0aW9u
X2luX3VzOwotCQlpZiAoaW5fb3V0X3Zyci0+YnRyLm1hcmdpbl9pbl91cyA+IEJUUl9NQVhfTUFS
R0lOKQotCQkJaW5fb3V0X3Zyci0+YnRyLm1hcmdpbl9pbl91cyA9IEJUUl9NQVhfTUFSR0lOOwot
CiAJCWluX291dF92cnItPnN1cHBvcnRlZCA9IHRydWU7CiAJfQogCkBAIC04MTYsNyArODExLDYg
QEAgdm9pZCBtb2RfZnJlZXN5bmNfYnVpbGRfdnJyX3BhcmFtcyhzdHJ1Y3QgbW9kX2ZyZWVzeW5j
ICptb2RfZnJlZXN5bmMsCiAJaW5fb3V0X3Zyci0+YnRyLmluc2VydGVkX2R1cmF0aW9uX2luX3Vz
ID0gMDsKIAlpbl9vdXRfdnJyLT5idHIuZnJhbWVzX3RvX2luc2VydCA9IDA7CiAJaW5fb3V0X3Zy
ci0+YnRyLmZyYW1lX2NvdW50ZXIgPSAwOwotCiAJaW5fb3V0X3Zyci0+YnRyLm1pZF9wb2ludF9p
bl91cyA9CiAJCQkJKGluX291dF92cnItPm1pbl9kdXJhdGlvbl9pbl91cyArCiAJCQkJIGluX291
dF92cnItPm1heF9kdXJhdGlvbl9pbl91cykgLyAyOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5jL21vZF9mcmVlc3luYy5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5jL21vZF9mcmVlc3luYy5oCmluZGV4IGRiZTc4MzVh
YWJjZi4uZGMxODc4NDRkMTBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvbW9kdWxlcy9pbmMvbW9kX2ZyZWVzeW5jLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L21vZHVsZXMvaW5jL21vZF9mcmVlc3luYy5oCkBAIC05Miw3ICs5Miw2IEBAIHN0cnVj
dCBtb2RfdnJyX3BhcmFtc19idHIgewogCXVpbnQzMl90IGluc2VydGVkX2R1cmF0aW9uX2luX3Vz
OwogCXVpbnQzMl90IGZyYW1lc190b19pbnNlcnQ7CiAJdWludDMyX3QgZnJhbWVfY291bnRlcjsK
LQl1aW50MzJfdCBtYXJnaW5faW5fdXM7CiB9OwogCiBzdHJ1Y3QgbW9kX3Zycl9wYXJhbXNfZml4
ZWRfcmVmcmVzaCB7Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
