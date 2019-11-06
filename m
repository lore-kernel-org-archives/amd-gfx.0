Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9BBC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 14:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D00A20663
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 14:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D00A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203C389157;
	Wed,  6 Nov 2019 14:04:10 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800074.outbound.protection.outlook.com [40.107.80.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E8789157
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 14:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP8+pToHkYhyt1H8YYaMzzmNqDTzYKSzd8Oc3lY+FBgQ/Sq0wA80MIW9qWhupNEMwXiV+2zDNVL/QQ7L8M+INbBcLUG0K8hb2ridQ22Ti2WnWjxA4TPRDd+MTSt0ZF3UdTaUTj3u6lTYJuLXTrHjZjL1L1fCnX8/2nQVV17gqGhAeh6QeqxJvt4P9qYStak2VvLa1ZX3zW5+RUp56Gi4qb8UO9PnAf8Wi4Nrs1bgxdlmZQPtawJgKSuDYvD5BZ7cGbOUejKO6cgFSgeA2MsOXgZ8UiIHCSZV5+qIXpQUOVRnrT4yNNZSr7MXYAO55WWfJbw0EKj3xHUHQa7Aava8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od41rM1U2QwcBiX9d2+JGzh8BoS+eIeXm1WR42bwroM=;
 b=PiWqQY/hLTaIk0S0xaW9YBH3ronyD1Zgdk4PMTZCGxTfbhpvqtlikHmi3vHCHfpZjHZnv83ED3BSucEVUXCzhc87tLiSbqZASXPW2bZTn7VT77tS3C6WNtjUx5505Y8lQZloDfWOS9xWDAQeJAdaeewedayEL8EJzehVQB0TsmQnYr0kWNVI+J4LxcErjhsiOOfTN3S8qUHlk7OzPjujANM3KSNSIzl/zD5hcQ5FTuyK+B10aTkMkkIQ24bpvvw/7N4pBCVQXgR5s9PaO0CUFOoDKRaEJ54wkHDJ2QQ3JstfUyJMyaaiw+X+2865puvy3yfXAaVUt+m8eX8PMWaS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (10.255.138.16) by
 BY5PR12MB3891.namprd12.prod.outlook.com (10.255.136.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 14:04:07 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::64e6:a72:1282:ab3a]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::64e6:a72:1282:ab3a%7]) with mapi id 15.20.2408.025; Wed, 6 Nov 2019
 14:04:07 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix vega20 pstate status change
Thread-Topic: [PATCH] drm/amdgpu: fix vega20 pstate status change
Thread-Index: AQHVlKsN6bKM8GOI9k2oUvJy2j0txg==
Date: Wed, 6 Nov 2019 14:04:06 +0000
Message-ID: <20191106140351.36350-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e30581dc-6494-491c-6302-08d762c23007
x-ms-traffictypediagnostic: BY5PR12MB3891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB389189F6839C5C0A35CE90D285790@BY5PR12MB3891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(8676002)(14454004)(81166006)(81156014)(8936002)(486006)(25786009)(2616005)(476003)(5640700003)(7736002)(6436002)(2501003)(50226002)(478600001)(2906002)(6512007)(4326008)(71190400001)(71200400001)(6916009)(2351001)(305945005)(6486002)(66556008)(86362001)(256004)(14444005)(66066001)(36756003)(5660300002)(102836004)(386003)(6506007)(3846002)(6116002)(99286004)(26005)(52116002)(54906003)(316002)(66446008)(64756008)(66476007)(66946007)(186003)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3891;
 H:BY5PR12MB3827.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6ws/6RT9BXnLawVMOHcMl0HdlHGImU1hxXNCMMMEve2oLCKPiA6xtfEvvzPThQhmg2j6UebITE4IAlv7nqYBjzbrHLZOIqdRX/PqnK61Dba1ku7eNlBA1tHnpxzokK1/MVvynzlgrdXGd0kX/ajaU9j4lEYPc0Cb3GkRqhy6/i0CpbtniyKU++ZNO8OGSK2SgC/4D4rECJSBqHP4L2L9sXsW+BH63zVogV7v+HeoYgAvr1uMtdVYVUWKHNa1b+jKIT6w0PSvGWM8WNBidHtbjVeTynrafxNk9ZV7AqR9LxOTC1O9PNLEtT4yHJkAhw6aRtkJnTUXE0vI5buvTt4OjSLjGSOs2QO9T0CKMASWEYEFFmkO26sp8BnpAimS8XMBguQJeH24BiSOcCpag6hc+EEm0k03tKmBIMd4PssiWBWDTxrK0+7AwRzMLgE5YBg
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30581dc-6494-491c-6302-08d762c23007
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 14:04:06.8690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwIWG0NfYPbQK7fgRylYb4hjX71xpnmAnK/0pBHOP9DIlWIN9GVUsN7AklDqv5S1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od41rM1U2QwcBiX9d2+JGzh8BoS+eIeXm1WR42bwroM=;
 b=AuezF3bCjHzOvvN09ECUegyJmhhep/SbtIqMtaNT10M+CRyTyI7+HC9Md74Zyx+o3YXIcYpF3EvRNp2dFkquoylSj51ASUeGctUweLLikn30e3fsjyYuedDjz+gDLEG2zpfi9/HkVdyoRdr1owGBbMSr06VFInadqrRmVsLnQms=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
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
Cc: "Strawbridge, Michael" <Michael.Strawbridge@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106140406.zzU_IJJq5eE_m3OPprJ1anZIGFvDrk3GrnK4NKJQeXg@z>

dmVnYTIwIG9ubHkgcmVxdWlyZXMgYWxsIGRldmljZXMgYmUgc2V0IHRvIHNhbWUgcHN0YXRlIGxl
dmVsIGZvciBsb3cKcHN0YXRlIGFuZCBub3QgaGlnaC4KCkNoYW5nZS1JZDogSTM5OWM4NGE0N2Y2
ZTI0YWJjYTkzN2NlOTUwNjg1YzBjN2YwZTMyNzkKU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2lt
IDxKb25hdGhhbi5LaW1AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfeGdtaS5jIHwgNyArKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV94Z21pLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5j
CmluZGV4IGRlMjBhOWExYzQ0NC4uNjFkMTNkOGI3YjIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV94Z21pLmMKQEAgLTI3Niw2ICsyNzYsNyBAQCBpbnQgYW1kZ3B1X3hnbWlf
c2V0X3BzdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IHBzdGF0ZSkKIAlzdHJ1
Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFkZXYsIDAp
OwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICp0bXBfYWRldjsKIAlib29sIHVwZGF0ZV9oaXZlX3Bz
dGF0ZSA9IHRydWU7CisJYm9vbCBpc19oaWdoX3BzdGF0ZSA9IHBzdGF0ZSAmJiBhZGV2LT5hc2lj
X3R5cGUgPT0gQ0hJUF9WRUdBMjA7CiAKIAlpZiAoIWhpdmUpCiAJCXJldHVybiAwOwpAQCAtMjgz
LDggKzI4NCw4IEBAIGludCBhbWRncHVfeGdtaV9zZXRfcHN0YXRlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBpbnQgcHN0YXRlKQogCW11dGV4X2xvY2soJmhpdmUtPmhpdmVfbG9jayk7CiAK
IAlpZiAoaGl2ZS0+cHN0YXRlID09IHBzdGF0ZSkgewotCQltdXRleF91bmxvY2soJmhpdmUtPmhp
dmVfbG9jayk7Ci0JCXJldHVybiAwOworCQlhZGV2LT5wc3RhdGUgPSBpc19oaWdoX3BzdGF0ZSA/
IHBzdGF0ZSA6IGFkZXYtPnBzdGF0ZTsKKwkJZ290byBvdXQ7CiAJfQogCiAJZGV2X2RiZyhhZGV2
LT5kZXYsICJTZXQgeGdtaSBwc3RhdGUgJWQuXG4iLCBwc3RhdGUpOwpAQCAtMzE3LDcgKzMxOCw3
IEBAIGludCBhbWRncHVfeGdtaV9zZXRfcHN0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBpbnQgcHN0YXRlKQogCQkJYnJlYWs7CiAJCX0KIAl9Ci0JaWYgKHVwZGF0ZV9oaXZlX3BzdGF0
ZSkKKwlpZiAodXBkYXRlX2hpdmVfcHN0YXRlIHx8IGlzX2hpZ2hfcHN0YXRlKQogCQloaXZlLT5w
c3RhdGUgPSBwc3RhdGU7CiAKIG91dDoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
