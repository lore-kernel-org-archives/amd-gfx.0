Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB19C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEBD214D8
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEBD214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BA36EB84;
	Tue,  5 Nov 2019 23:18:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC2E6EB84
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 23:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn/Utv+wLHiUpYEVYpZW4jlX7IB4AC6Eolkuj19c8YVzHa3EFuVNOfI+/Mjhfr+ItAE+6tox89ceJ4G0MfgygVeEb+ixPZI22aEfHcOpCuC76kxqY4b2euzcHX2ZyiqFIz5uJgbyDtMoEeUBUh7NP83uDm+Yp8SuX7L/TmsGWXp0KFPuHVmac1pRDIO5KolMEvfzv+TxgbcDrfAmkGLfjKUIZDPS9CwXlydBObs3D8d3Y+A0T/2n0ZWs+yiibQmfVaBXW/Bs23SOmL8r+IArFN/ifsg4YLFIkFyU6cx42RCy3GHIF6gCE5y6bNJC+BbnOAem/o17jLVnynIdjY77sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOCet/xDzPuQFrWoxBaCRfue+Y9BuP8wI5iaSPthfv0=;
 b=cnyO8JQRmbGGsyH8l56phheqc0EPNRquvr8AmByNuLgKwuN+Hh4oujZOf1Xjy8FzfjglgaqERlpyxxX2cujIfPND9bZq06M0cPDFy17DMLZdnrmYxSI0Sx0GGGgvyESxmEBQK4A5JOD28mf8ifDsNJuHv7j15ZGF8TQ3MtbC/fnVQ3jQIpdQi50AH8U7OZW14ys2BYqBCLm5bpwY3UXLejlmRm6IOl7s6Vpc3yPtSJKHcBAoz2ILxv8OF4cZo4aJmE5epoI136BDt/KAzMeoUMiVvWJ6K9lPdEnDtnQJowmo89CGRSt9YxEb6whPSJtHTMkG00vf0aYFXGvWJOO1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3753.namprd12.prod.outlook.com (10.255.172.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 23:18:11 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 23:18:11 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Simplify the mmap offset related bit operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVlC9KsVca0NKFMUCOBwbcLRM7OA==
Date: Tue, 5 Nov 2019 23:18:11 +0000
Message-ID: <20191105231759.19850-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e873c0d-ff5a-4cb3-3dc8-08d762466d33
x-ms-traffictypediagnostic: DM6PR12MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3753B5FFD8E5E6CE506ADD6BF07E0@DM6PR12MB3753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(26005)(14454004)(316002)(256004)(305945005)(86362001)(186003)(7736002)(478600001)(52116002)(6436002)(2616005)(8676002)(66946007)(2501003)(50226002)(66066001)(8936002)(476003)(81166006)(81156014)(4326008)(66446008)(66476007)(1076003)(66556008)(64756008)(99286004)(5660300002)(2351001)(2906002)(486006)(5640700003)(6486002)(102836004)(6506007)(386003)(6116002)(36756003)(3846002)(71200400001)(25786009)(6916009)(6512007)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3753;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TA6XwF6SjqkCRYcvlR19WSkTJ6i+4mj9ii/dRbCsKgEbxzoHj9GSOaCfCIHDx1gIqrZLWGX8tSD4R222ZPhGljyklXskqEG+yD70k7ffsLzkyiYWxi+MOTHgFiL1GxBOHVb28PycAUdiayT5NGK2bCfZ3CxeFc9f6dNlLJcv4bKS3q1nOgtUwXl1HB76Zydz4xzvugfwNnLnbhbz6kF4Bmq8iUYVrctC16V6qcFH7c5JZs5MM9PHU7Z0rtfZjoEcwRDvoTGgnfM2K2iPDBGGyw0PNZD1t5XUbabQmD11+trdWfGmd0efQffQ6deKOWRqy+RPNBM0ufiD/v7KGd1ioygyjps4N0F6A56wVvT4uSsYOhntkXSQqlLn7TffQ3SdeJ/5S1THp24NVKoDtQuyRmzKm8ZIdYUxENJ8vPUSRS0BZbK0ppbtG2qIS9i0P9iU
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e873c0d-ff5a-4cb3-3dc8-08d762466d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 23:18:11.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnCcY37qA/tp6JNEDYn6w5TZpSxXQZv1DYo93pKWZmiKKNofPptpzGD+hMll1ZWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOCet/xDzPuQFrWoxBaCRfue+Y9BuP8wI5iaSPthfv0=;
 b=Efk0YATaIh/7XNRBjKKz2thN6OG1wnuSgvtVAerK1tBZmGfKFUp8B6VGU4qUEoFHcPpkn7NKyxsbklhVmwCc9p7X32bdDcw0nFQegkACMre9U5kd93IExK2rXd0eotpqwhS7nYnu1p7X6UngFJ15mw7TYRmKUjpXp8kVqbcTGqk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105231811.gWrJQ7mIBtyX3KcTBVoCXDbLf24sS9fYgFTQugLQsuc@z>

VGhlIG5ldyBjb2RlIHVzZXMgc3RyYWlnaHRmb3J3YXJkIGJpdCBzaGlmdHMgYW5kIHRodXMgaGFz
IGJldHRlciByZWFkYWJpbGl0eS4KCkNoYW5nZS1JZDogSTBjMWY3Y2NhN2UyNGRkYjdiNGZmZTFj
YjBmYTcxOTQzODI4YWUzNzMKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMTAg
KysrKy0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jICB8ICAx
IC0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggICAgfCAgOSArKystLS0t
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgfCAgMyArLS0KIDQg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwppbmRleCBiOTE5OTM3NTNiODIuLjM0MDc4
ZGYzNjYyMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJk
ZXYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCkBAIC0y
OTgsNyArMjk4LDYgQEAgc3RhdGljIGludCBrZmRfaW9jdGxfY3JlYXRlX3F1ZXVlKHN0cnVjdCBm
aWxlICpmaWxlcCwgc3RydWN0IGtmZF9wcm9jZXNzICpwLAogCS8qIFJldHVybiBncHVfaWQgYXMg
ZG9vcmJlbGwgb2Zmc2V0IGZvciBtbWFwIHVzYWdlICovCiAJYXJncy0+ZG9vcmJlbGxfb2Zmc2V0
ID0gS0ZEX01NQVBfVFlQRV9ET09SQkVMTDsKIAlhcmdzLT5kb29yYmVsbF9vZmZzZXQgfD0gS0ZE
X01NQVBfR1BVX0lEKGFyZ3MtPmdwdV9pZCk7Ci0JYXJncy0+ZG9vcmJlbGxfb2Zmc2V0IDw8PSBQ
QUdFX1NISUZUOwogCWlmIChLRkRfSVNfU09DMTUoZGV2LT5kZXZpY2VfaW5mby0+YXNpY19mYW1p
bHkpKQogCQkvKiBPbiBTT0MxNSBBU0lDcywgaW5jbHVkZSB0aGUgZG9vcmJlbGwgb2Zmc2V0IHdp
dGhpbiB0aGUKIAkJICogcHJvY2VzcyBkb29yYmVsbCBmcmFtZSwgd2hpY2ggY291bGQgYmUgMSBw
YWdlIG9yIDIgcGFnZXMuCkBAIC0xOTM4LDIwICsxOTM3LDE5IEBAIHN0YXRpYyBpbnQga2ZkX21t
YXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQogewogCXN0
cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzczsKIAlzdHJ1Y3Qga2ZkX2RldiAqZGV2ID0gTlVMTDsK
LQl1bnNpZ25lZCBsb25nIHZtX3Bnb2ZmOworCXVuc2lnbmVkIGxvbmcgbW1hcF9vZmZzZXQ7CiAJ
dW5zaWduZWQgaW50IGdwdV9pZDsKIAogCXByb2Nlc3MgPSBrZmRfZ2V0X3Byb2Nlc3MoY3VycmVu
dCk7CiAJaWYgKElTX0VSUihwcm9jZXNzKSkKIAkJcmV0dXJuIFBUUl9FUlIocHJvY2Vzcyk7CiAK
LQl2bV9wZ29mZiA9IHZtYS0+dm1fcGdvZmY7Ci0Jdm1hLT52bV9wZ29mZiA9IEtGRF9NTUFQX09G
RlNFVF9WQUxVRV9HRVQodm1fcGdvZmYpOwotCWdwdV9pZCA9IEtGRF9NTUFQX0dQVV9JRF9HRVQo
dm1fcGdvZmYpOworCW1tYXBfb2Zmc2V0ID0gdm1hLT52bV9wZ29mZiA8PCBQQUdFX1NISUZUOwor
CWdwdV9pZCA9IEtGRF9NTUFQX0dFVF9HUFVfSUQobW1hcF9vZmZzZXQpOwogCWlmIChncHVfaWQp
CiAJCWRldiA9IGtmZF9kZXZpY2VfYnlfaWQoZ3B1X2lkKTsKIAotCXN3aXRjaCAodm1fcGdvZmYg
JiBLRkRfTU1BUF9UWVBFX01BU0spIHsKKwlzd2l0Y2ggKG1tYXBfb2Zmc2V0ICYgS0ZEX01NQVBf
VFlQRV9NQVNLKSB7CiAJY2FzZSBLRkRfTU1BUF9UWVBFX0RPT1JCRUxMOgogCQlpZiAoIWRldikK
IAkJCXJldHVybiAtRU5PREVWOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2V2ZW50cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5j
CmluZGV4IDkwODA4MWM4NWRlMS4uMWY4MzY1NTc1YjEyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2V2ZW50cy5jCkBAIC0zNDYsNyArMzQ2LDYgQEAgaW50IGtmZF9ldmVudF9jcmVh
dGUoc3RydWN0IGZpbGUgKmRldmtmZCwgc3RydWN0IGtmZF9wcm9jZXNzICpwLAogCQlyZXQgPSBj
cmVhdGVfc2lnbmFsX2V2ZW50KGRldmtmZCwgcCwgZXYpOwogCQlpZiAoIXJldCkgewogCQkJKmV2
ZW50X3BhZ2Vfb2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9FVkVOVFM7Ci0JCQkqZXZlbnRfcGFnZV9v
ZmZzZXQgPDw9IFBBR0VfU0hJRlQ7CiAJCQkqZXZlbnRfc2xvdF9pbmRleCA9IGV2LT5ldmVudF9p
ZDsKIAkJfQogCQlicmVhazsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCmluZGV4
IDY2YmFlOGYyZGFkMS4uOGVlY2QyY2QxZmQyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJpdi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcml2LmgKQEAgLTU5LDI0ICs1OSwyMSBAQAogICogTk9URTogc3RydWN0IHZtX2FyZWFfc3Ry
dWN0LnZtX3Bnb2ZmIHVzZXMgb2Zmc2V0IGluIHBhZ2VzLiBIZW5jZSwgdGhlc2UKICAqICBkZWZp
bmVzIGFyZSB3LnIudCB0byBQQUdFX1NJWkUKICAqLwotI2RlZmluZSBLRkRfTU1BUF9UWVBFX1NI
SUZUCSg2MiAtIFBBR0VfU0hJRlQpCisjZGVmaW5lIEtGRF9NTUFQX1RZUEVfU0hJRlQJKDYyKQog
I2RlZmluZSBLRkRfTU1BUF9UWVBFX01BU0sJKDB4M1VMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZU
KQogI2RlZmluZSBLRkRfTU1BUF9UWVBFX0RPT1JCRUxMCSgweDNVTEwgPDwgS0ZEX01NQVBfVFlQ
RV9TSElGVCkKICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9FVkVOVFMJKDB4MlVMTCA8PCBLRkRfTU1B
UF9UWVBFX1NISUZUKQogI2RlZmluZSBLRkRfTU1BUF9UWVBFX1JFU0VSVkVEX01FTQkoMHgxVUxM
IDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpCiAjZGVmaW5lIEtGRF9NTUFQX1RZUEVfTU1JTwkoMHgw
VUxMIDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpCiAKLSNkZWZpbmUgS0ZEX01NQVBfR1BVX0lEX1NI
SUZUICg0NiAtIFBBR0VfU0hJRlQpCisjZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9TSElGVCAoNDYp
CiAjZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9NQVNLICgoKDFVTEwgPDwgS0ZEX0dQVV9JRF9IQVNI
X1dJRFRIKSAtIDEpIFwKIAkJCQk8PCBLRkRfTU1BUF9HUFVfSURfU0hJRlQpCiAjZGVmaW5lIEtG
RF9NTUFQX0dQVV9JRChncHVfaWQpICgoKCh1aW50NjRfdClncHVfaWQpIDw8IEtGRF9NTUFQX0dQ
VV9JRF9TSElGVClcCiAJCQkJJiBLRkRfTU1BUF9HUFVfSURfTUFTSykKLSNkZWZpbmUgS0ZEX01N
QVBfR1BVX0lEX0dFVChvZmZzZXQpICAgICgob2Zmc2V0ICYgS0ZEX01NQVBfR1BVX0lEX01BU0sp
IFwKKyNkZWZpbmUgS0ZEX01NQVBfR0VUX0dQVV9JRChvZmZzZXQpICAgICgob2Zmc2V0ICYgS0ZE
X01NQVBfR1BVX0lEX01BU0spIFwKIAkJCQk+PiBLRkRfTU1BUF9HUFVfSURfU0hJRlQpCiAKLSNk
ZWZpbmUgS0ZEX01NQVBfT0ZGU0VUX1ZBTFVFX01BU0sJKDB4M0ZGRkZGRkZGRkZGVUxMID4+IFBB
R0VfU0hJRlQpCi0jZGVmaW5lIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9HRVQob2Zmc2V0KSAob2Zm
c2V0ICYgS0ZEX01NQVBfT0ZGU0VUX1ZBTFVFX01BU0spCi0KIC8qCiAgKiBXaGVuIHdvcmtpbmcg
d2l0aCBjcCBzY2hlZHVsZXIgd2Ugc2hvdWxkIGFzc2lnbiB0aGUgSElRIG1hbnVhbGx5IG9yIHZp
YQogICogdGhlIGFtZGdwdSBkcml2ZXIgdG8gYSBmaXhlZCBocWQgc2xvdCwgaGVyZSBhcmUgdGhl
IGZpeGVkIEhJUSBocWQgc2xvdApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3Byb2Nlc3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
LmMKaW5kZXggNmFiZmI3N2FlNTQwLi4zOWRjNDliOGZkODUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwpAQCAtNTU0LDggKzU1NCw3IEBAIHN0YXRpYyBpbnQga2Zk
X3Byb2Nlc3NfaW5pdF9jd3NyX2FwdShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsIHN0cnVjdCBmaWxl
ICpmaWxlcCkKIAkJaWYgKCFkZXYtPmN3c3JfZW5hYmxlZCB8fCBxcGQtPmN3c3Jfa2FkZHIgfHwg
cXBkLT5jd3NyX2Jhc2UpCiAJCQljb250aW51ZTsKIAotCQlvZmZzZXQgPSAoS0ZEX01NQVBfVFlQ
RV9SRVNFUlZFRF9NRU0gfCBLRkRfTU1BUF9HUFVfSUQoZGV2LT5pZCkpCi0JCQk8PCBQQUdFX1NI
SUZUOworCQlvZmZzZXQgPSBLRkRfTU1BUF9UWVBFX1JFU0VSVkVEX01FTSB8IEtGRF9NTUFQX0dQ
VV9JRChkZXYtPmlkKTsKIAkJcXBkLT50YmFfYWRkciA9IChpbnQ2NF90KXZtX21tYXAoZmlsZXAs
IDAsCiAJCQlLRkRfQ1dTUl9UQkFfVE1BX1NJWkUsIFBST1RfUkVBRCB8IFBST1RfRVhFQywKIAkJ
CU1BUF9TSEFSRUQsIG9mZnNldCk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
