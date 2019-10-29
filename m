Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F09CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 20:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60CD20650
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 20:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60CD20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E6C6E5F0;
	Tue, 29 Oct 2019 20:06:46 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690068.outbound.protection.outlook.com [40.107.69.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D086E5F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 20:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0gN+bZWK9wyI+WHW8odwbfyc7T/2cBdz/hqAt9J+TnikaqJu7UYshKLsFpoizDgfcSGJUkHWp920gDEMuwtPyF2e0oYkZmz+KY7/svpXd0jAfIV/x+wL6itZsFcVcJ0jk7N/E6eK0l8VWFpFreWNhdKTkipDscFrEMgNeThyf6D6er8wxYG3W94Bxc7lYWOCjAuM0usFkcdvTyK2mJJQlddw9hoPc4KZ5bCwpY+b+i9ahrWkhZd8pPh70mT8qBlCxSosMKWUYo0K+X0uK1YFrIyXaEfg4UXpseQLLyODMl2S0y2Fx1QF2TA6smSRUTntzWBcN/bYiBQPGC7dU3Uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYMLdO7t5N0MxIvyeLtvdcjK0zEe9znkVa+5MGh/4uw=;
 b=SCot0sViNmV3kejwiwdG4G/fuywqzF2i+gDjxMZ+ihdinLVQlC6Pqdtcq3vHXGznYxoYFlI+Rkg7tDV1gDlRvMH13XbjRmpFLxQ0C7sWEiK0kptRH23718BV95SXgWIUAZFliJIYEzRRQV28uvMf0cNnK1vlEl8XDptiEZMMzBaeoMhsU8lJAZ/1spLaEm/l7CEToUaWpyOqlOCVq1jhRjeA3Miyf1YFy/k/B9A0xLG6JmTXA6qP7U56XQGrh8n2VVeyq/W7/DP1P6HpJFS6m0ffALzMEzi4AmwrnYI8TfCiHqgvKH7D263pRe7p63Rm9iPceJOAXGZgOPj9jgOPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR12MB1123.namprd12.prod.outlook.com (10.168.226.137) by
 BN6PR12MB1889.namprd12.prod.outlook.com (10.175.100.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 20:06:42 +0000
Received: from BN6PR12MB1123.namprd12.prod.outlook.com
 ([fe80::811e:d5a4:646a:7553]) by BN6PR12MB1123.namprd12.prod.outlook.com
 ([fe80::811e:d5a4:646a:7553%7]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 20:06:42 +0000
From: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove PT BOs when unmapping
Thread-Topic: [PATCH] drm/amdgpu: remove PT BOs when unmapping
Thread-Index: AQHVjpRhG4qMUtf7g0GYUhVpnQA38w==
Date: Tue, 29 Oct 2019 20:06:41 +0000
Message-ID: <1572379585-1401-1-git-send-email-JinhuiEric.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::37) To BN6PR12MB1123.namprd12.prod.outlook.com
 (2603:10b6:404:1b::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54fff503-2472-4df3-1f71-08d75cab83b5
x-ms-traffictypediagnostic: BN6PR12MB1889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1889AE66070EFBD1A6CAF56182610@BN6PR12MB1889.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(66946007)(478600001)(64756008)(2616005)(14444005)(66476007)(66446008)(316002)(14454004)(2501003)(66556008)(7736002)(256004)(6916009)(25786009)(305945005)(66066001)(476003)(5660300002)(86362001)(36756003)(486006)(386003)(102836004)(186003)(8936002)(81166006)(3846002)(6506007)(71190400001)(71200400001)(8676002)(81156014)(4326008)(6486002)(52116002)(99286004)(50226002)(6116002)(26005)(6512007)(5640700003)(2906002)(2351001)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1889;
 H:BN6PR12MB1123.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJxcWqs7ExRDIakq3S/KDN90viT9ikS7L3Yshgogpg53BY9l1TNZ2Fh6y38FfqUIyUgwibxVDuw6RagLwiNNHYP5/6xf+f7A/llQZIGpa6NMLAB1ILC2qMsay870RkdPoMBMUeTY9ALn1ch+ldvInCldNTZdivD2oLQ95ccR/5FOxT9MxUdUuf8Zw8TAC3rAuM6/OD3eLUivtzXWs6L3JKpH9byH6o1xArUJ8x8g85x46aAeL0GcvpiOAWEF4odvWYSAio7UoUjl7DqYSffcWPbgp7m6BJ0/jsI8jNUIOmOr0aer+HloL/B1VGffnfweiodW50JM2kSX6EsJQ2vv9ZUKt/kq4vCMfS4sfNdsPb87IUkjjf+MBgsUiph5RfJPIqxbowTTRHwzXdaFJib4D8N7Kmzral+3mLxUV2Z4c8Ngeh116SVWMHs8w55woyDx
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fff503-2472-4df3-1f71-08d75cab83b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 20:06:41.8201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tNGQWnNtL0HEfBCFx9PYB6IV3kgMZcpimwcd2bjD8YzkztB96c9alu5u6f/iGZrG6nV1T/vaUBHhTNKKygpAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYMLdO7t5N0MxIvyeLtvdcjK0zEe9znkVa+5MGh/4uw=;
 b=TPkMBi6ZpXy3lsYp1lXaphBT1nc/q74U7WfWel5V4IHyaJWOjKu8VegsaGwjWpUx8nvLVQfI2Hh2B55GsYNn9YsWk4Jn5d8NgMXdf7BArpJC4CAsKhS17x//W6aI/LGL4yY0EChLVMUwPE4S/uaKCDRz8yJw4j5zXTANZvubk8g=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=JinHuiEric.Huang@amd.com; 
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029200641.pPvuWjKwYABMqjF2A62EVgEzrpbFbrIxegevACX9w3M@z>

VGhlIGlzc3VlIGlzIFBUIEJPcyBhcmUgbm90IGZyZWVkIHdoZW4gdW5tYXBwaW5nIFZBLAp3aGlj
aCBjYXVzZXMgdnJhbSB1c2FnZSBhY2N1bXVsYXRlZCBpcyBodWdlIGluIHNvbWUKbWVtb3J5IHN0
cmVzcyB0ZXN0LCBzdWNoIGFzIGtmZCBiaWcgYnVmZmVyIHN0cmVzcyB0ZXN0LgpGdW5jdGlvbiBh
bWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoKSBpcyBjYWxsZWQgYnkgYm90aAphbWRncHVfdm1f
Ym9fdXBkYXRlKCkgYW5kIGFtZGdwdV92bV9jbGVhcl9mcmVlZCgpLiBUaGUKc29sdXRpb24gaXMg
cmVwbGFjaW5nIGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZygpIGluCmFtZGdwdV92bV9jbGVh
cl9mcmVlZCgpIHdpdGggcmVtb3ZpbmcgUFQgQk9zIGZ1bmN0aW9uCnRvIHNhdmUgdnJhbSB1c2Fn
ZS4KCkNoYW5nZS1JZDogSWMyNGUzNWJmZjhjYTg1MjY1YjQxOGE2NDIzNzNmMTg5ZDk3MmE5MjQK
U2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8SmluaHVpRXJpYy5IdWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNTYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRl
eCAwZjRjM2IyLi44YTQ4MGM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YwpAQCAtMTkzMCw2ICsxOTMwLDUxIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9wcnRfZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCiB9CiAKIC8q
KgorICogYW1kZ3B1X3ZtX3JlbW92ZV9wdGVzIC0gZnJlZSBQVCBCT3MKKyAqCisgKiBAYWRldjog
YW1kZ3B1IGRldmljZSBzdHJ1Y3R1cmUKKyAqIEB2bTogYW1kZ3B1IHZtIHN0cnVjdHVyZQorICog
QHN0YXJ0OiBzdGFydCBvZiBtYXBwZWQgcmFuZ2UKKyAqIEBlbmQ6IGVuZCBvZiBtYXBwZWQgZW50
cnkKKyAqCisgKiBGcmVlIHRoZSBwYWdlIHRhYmxlIGxldmVsLgorICovCitzdGF0aWMgaW50IGFt
ZGdwdV92bV9yZW1vdmVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJc3RydWN0
IGFtZGdwdV92bSAqdm0sIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQpCit7CisJc3RydWN0
IGFtZGdwdV92bV9wdF9jdXJzb3IgY3Vyc29yOworCXVuc2lnbmVkIHNoaWZ0LCBudW1fZW50cmll
czsKKworCWFtZGdwdV92bV9wdF9zdGFydChhZGV2LCB2bSwgc3RhcnQsICZjdXJzb3IpOworCXdo
aWxlIChjdXJzb3IubGV2ZWwgPCBBTURHUFVfVk1fUFRCKSB7CisJCWlmICghYW1kZ3B1X3ZtX3B0
X2Rlc2NlbmRhbnQoYWRldiwgJmN1cnNvcikpCisJCQlyZXR1cm4gLUVOT0VOVDsKKwl9CisKKwl3
aGlsZSAoY3Vyc29yLnBmbiA8IGVuZCkgeworCQlhbWRncHVfdm1fZnJlZV90YWJsZShjdXJzb3Iu
ZW50cnkpOworCQludW1fZW50cmllcyA9IGFtZGdwdV92bV9udW1fZW50cmllcyhhZGV2LCBjdXJz
b3IubGV2ZWwgLSAxKTsKKworCQlpZiAoY3Vyc29yLmVudHJ5ICE9ICZjdXJzb3IucGFyZW50LT5l
bnRyaWVzW251bV9lbnRyaWVzIC0gMV0pIHsKKwkJCS8qIE5leHQgcHRiIGVudHJ5ICovCisJCQlz
aGlmdCA9IGFtZGdwdV92bV9sZXZlbF9zaGlmdChhZGV2LCBjdXJzb3IubGV2ZWwgLSAxKTsKKwkJ
CWN1cnNvci5wZm4gKz0gMVVMTCA8PCBzaGlmdDsKKwkJCWN1cnNvci5wZm4gJj0gfigoMVVMTCA8
PCBzaGlmdCkgLSAxKTsKKwkJCWN1cnNvci5lbnRyeSsrOworCQl9IGVsc2UgeworCQkJLyogTmV4
dCBwdGIgZW50cnkgaW4gbmV4dCBwZDAgZW50cnkgKi8KKwkJCWFtZGdwdV92bV9wdF9hbmNlc3Rv
cigmY3Vyc29yKTsKKwkJCXNoaWZ0ID0gYW1kZ3B1X3ZtX2xldmVsX3NoaWZ0KGFkZXYsIGN1cnNv
ci5sZXZlbCAtIDEpOworCQkJY3Vyc29yLnBmbiArPSAxVUxMIDw8IHNoaWZ0OworCQkJY3Vyc29y
LnBmbiAmPSB+KCgxVUxMIDw8IHNoaWZ0KSAtIDEpOworCQkJYW1kZ3B1X3ZtX3B0X2Rlc2NlbmRh
bnQoYWRldiwgJmN1cnNvcik7CisJCX0KKwl9CisKKwlyZXR1cm4gMDsKK30KKworLyoqCiAgKiBh
bWRncHVfdm1fY2xlYXJfZnJlZWQgLSBjbGVhciBmcmVlZCBCT3MgaW4gdGhlIFBUCiAgKgogICog
QGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgpAQCAtMTk0OSw3ICsxOTk0LDYgQEAgaW50IGFt
ZGdwdV92bV9jbGVhcl9mcmVlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgc3Ry
dWN0IGRtYV9mZW5jZSAqKmZlbmNlKQogewogCXN0cnVjdCBhbWRncHVfYm9fdmFfbWFwcGluZyAq
bWFwcGluZzsKLQl1aW50NjRfdCBpbml0X3B0ZV92YWx1ZSA9IDA7CiAJc3RydWN0IGRtYV9mZW5j
ZSAqZiA9IE5VTEw7CiAJaW50IHI7CiAKQEAgLTE5NTgsMTMgKzIwMDIsMTAgQEAgaW50IGFtZGdw
dV92bV9jbGVhcl9mcmVlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCXN0cnVjdCBh
bWRncHVfYm9fdmFfbWFwcGluZywgbGlzdCk7CiAJCWxpc3RfZGVsKCZtYXBwaW5nLT5saXN0KTsK
IAotCQlpZiAodm0tPnB0ZV9zdXBwb3J0X2F0cyAmJgotCQkgICAgbWFwcGluZy0+c3RhcnQgPCBB
TURHUFVfR01DX0hPTEVfU1RBUlQpCi0JCQlpbml0X3B0ZV92YWx1ZSA9IEFNREdQVV9QVEVfREVG
QVVMVF9BVEM7CisJCXIgPSBhbWRncHVfdm1fcmVtb3ZlX3B0ZXMoYWRldiwgdm0sCisJCQkJKG1h
cHBpbmctPnN0YXJ0ICsgMHgxZmYpICYgKH4weDFmZmxsKSwKKwkJCQkobWFwcGluZy0+bGFzdCAr
IDEpICYgKH4weDFmZmxsKSk7CiAKLQkJciA9IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhh
ZGV2LCB2bSwgZmFsc2UsIE5VTEwsCi0JCQkJCQltYXBwaW5nLT5zdGFydCwgbWFwcGluZy0+bGFz
dCwKLQkJCQkJCWluaXRfcHRlX3ZhbHVlLCAwLCBOVUxMLCAmZik7CiAJCWFtZGdwdV92bV9mcmVl
X21hcHBpbmcoYWRldiwgdm0sIG1hcHBpbmcsIGYpOwogCQlpZiAocikgewogCQkJZG1hX2ZlbmNl
X3B1dChmKTsKQEAgLTE5ODAsNyArMjAyMSw2IEBAIGludCBhbWRncHVfdm1fY2xlYXJfZnJlZWQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJfQogCiAJcmV0dXJuIDA7Ci0KIH0KIAogLyoq
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
