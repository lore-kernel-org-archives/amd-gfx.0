Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95162CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 22:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B848217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 22:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B848217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2732E6E2ED;
	Fri,  1 Nov 2019 22:48:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BA06E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 22:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duxhWqRQc66fDeM4PY+scQMEc/XMbmpU5OpFbq/tDYjverz8lWJX0EwThJEMG7fYFW7Hw3GeoWJVkVifTy8vgkOE65hrgQNCeFPwFuOVrh1tYZRddia0ZJbG5yVGYzRz4M4Wx+ywJ0ncjbNynvMWF4cbv0tteRkXwiLXI3gi6P3rNdNCgEnYM2bCeAB5nTZmHLHLaAoPEpOFL6AnkT9BxdWcPDoT8HB4Vr5NxQtrQ5/tfHg7whX+oUkr+L1b4Dl0Wd89kamEfBBPX8DMjZLb3NGXixJpxCqRfGQkawzD8hw7ivmIOTE17FwvJVmDCvD5y1ymUHiycf8fCNhKcpm80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF5LPbpuiO5arxGISr0CUzzdBqn8N5xKAk1X/410mA0=;
 b=RJ2HN14JJUV2064c0lE7CzXY0BPbk8J3EQOzkC9AmppuvUSgZRUai9iNJ/ifb7A3JHt9Ht247uV/p5todia2AMxGxalKnwK/yrqBKPXg7kczOgz6GqwDcGDrHBWyknxeklN5MoWbfIhcHm2cjqiFas9e8jbW717+J8Qgr1bLj0SNSwjKUMF7R8cYFRYx++Hh5wq+BaaNHvg2Hjquw9ZEds57DVp/HDF+mizFo3C/0n9A6C6SGHyxoN+baTkC55wBO3Ssjh0xebIhr+5I32K2t9MJwcc8R6A8XP+Z7HhdxxuAFyQY+hCsfdIBUisYP1tylyd/puUNRZVVvZbby0krgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3594.namprd12.prod.outlook.com (20.178.199.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 22:48:01 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 22:48:01 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVkPW3xyVHQwVd5kGLa7uEKtffqqd26ucA
Date: Fri, 1 Nov 2019 22:48:01 +0000
Message-ID: <2d2985b2-bcd2-3f56-918e-948020c61993@amd.com>
References: <20191101204818.8125-1-Yong.Zhao@amd.com>
In-Reply-To: <20191101204818.8125-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02484ef8-dc5d-4e00-296c-08d75f1d8c97
x-ms-traffictypediagnostic: DM6PR12MB3594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35947732F90A967E7066B87892620@DM6PR12MB3594.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(26005)(6116002)(3846002)(2501003)(66446008)(2616005)(305945005)(14444005)(316002)(58126008)(66556008)(2906002)(64756008)(386003)(6506007)(110136005)(71200400001)(31696002)(7736002)(256004)(6512007)(486006)(25786009)(446003)(53546011)(6436002)(6486002)(11346002)(71190400001)(81166006)(31686004)(229853002)(476003)(8936002)(81156014)(14454004)(76176011)(6246003)(66066001)(186003)(66476007)(5660300002)(66946007)(478600001)(99286004)(65956001)(65806001)(86362001)(102836004)(52116002)(36756003)(8676002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3594;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2yXFWOVTk9j38sgehpzgANZLMo15UMuoJfJWxgfK7RMML+9bDHjsE5RQ5MUMpMk12H0+ThdIBewf/IrAGuqYJCXfrsftbR0zUVwMvbX3gPSFsruEVxk1vwWDG16nGcXZpZDKr1thaB40AYNHZnneu1aZqbIOlMYS3E6Lq7Waj5JW8Tdr49zIFl7BC03MRVyJV9XuS0DL2NWIOrBzpw/SEVFSlOwn1cqK/Mwlt5c3jgLBciKkXTeQcfWWyl8cgunCdEVcyyJG7SmB3TR5HszgJqOtAWgIe1EUOm+E+jzJGt7xBlnJo/woOotMb9k3ZGeiOwriu/xu1ZCl1iSTG+yyAqyR/yU0nKtX5YRpEkXV2pqC3EBQ1Mt2oba9xtHCkj3AhOdFvzbZeBRHNvuYJXHKJ/hUmUvOPChWpu63UNS2Gmv25F+iFwbOAnGN/NVZ3KW
Content-ID: <7BE631ABD25DB44987B6C1032511A1D8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02484ef8-dc5d-4e00-296c-08d75f1d8c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 22:48:01.5810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tfc7tFI5T4IneaVXfJxtI9kqUwWfFsk7bWIpdlVwCKHLHTgS8X30DPfj51d2mEJFWEBxWGGKGBuIHA3vJ3CpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF5LPbpuiO5arxGISr0CUzzdBqn8N5xKAk1X/410mA0=;
 b=L7BKc70d+0/0wFY9U06kn0/Lgp3dJlbbuCx0lUPo7UXYp02Z9GVd2HhhKkNI6v9ERGkF1Mj221djlIY1KkaVUfhxzLOCMeoyKYgRw2z5m2UfkbJP+/XWKlV707Wyxwcb6a42rvp/N4oFltp+fesuI2lKt8egY56BT1CySkCZk0w=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101224801.vDDpQWO9pFNkUmjn3QIQxX-KvSMUu5ohF1oHNZruPYw@z>

T24gMjAxOS0xMS0wMSA0OjQ4IHAubS4sIFpoYW8sIFlvbmcgd3JvdGU6DQo+IFRoZSBuZXcgY29k
ZSBpcyBtdWNoIGNsZWFuZXIgYW5kIHJlc3VsdHMgaW4gYmV0dGVyIHJlYWRhYmlsaXR5Lg0KPg0K
PiBDaGFuZ2UtSWQ6IEkwYzFmN2NjYTdlMjRkZGI3YjRmZmUxY2IwZmE3MTk0MzgyOGFlMzczDQo+
IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAxMyArKysrKysrLS0t
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jICB8ICAxIC0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgIHwgIDkgKysrLS0t
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyB8ICAzICst
LQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRl
di5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiBpbmRleCBi
OTE5OTM3NTNiODIuLjU5MDEzODcyN2NhOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfY2hhcmRldi5jDQo+IEBAIC0yOTgsNyArMjk4LDYgQEAgc3RhdGljIGludCBrZmRf
aW9jdGxfY3JlYXRlX3F1ZXVlKHN0cnVjdCBmaWxlICpmaWxlcCwgc3RydWN0IGtmZF9wcm9jZXNz
ICpwLA0KPiAgIAkvKiBSZXR1cm4gZ3B1X2lkIGFzIGRvb3JiZWxsIG9mZnNldCBmb3IgbW1hcCB1
c2FnZSAqLw0KPiAgIAlhcmdzLT5kb29yYmVsbF9vZmZzZXQgPSBLRkRfTU1BUF9UWVBFX0RPT1JC
RUxMOw0KPiAgIAlhcmdzLT5kb29yYmVsbF9vZmZzZXQgfD0gS0ZEX01NQVBfR1BVX0lEKGFyZ3Mt
PmdwdV9pZCk7DQo+IC0JYXJncy0+ZG9vcmJlbGxfb2Zmc2V0IDw8PSBQQUdFX1NISUZUOw0KPiAg
IAlpZiAoS0ZEX0lTX1NPQzE1KGRldi0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5KSkNCj4gICAJ
CS8qIE9uIFNPQzE1IEFTSUNzLCBpbmNsdWRlIHRoZSBkb29yYmVsbCBvZmZzZXQgd2l0aGluIHRo
ZQ0KPiAgIAkJICogcHJvY2VzcyBkb29yYmVsbCBmcmFtZSwgd2hpY2ggY291bGQgYmUgMSBwYWdl
IG9yIDIgcGFnZXMuDQo+IEBAIC0xOTM4LDIwICsxOTM3LDIyIEBAIHN0YXRpYyBpbnQga2ZkX21t
YXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiAgIHsN
Cj4gICAJc3RydWN0IGtmZF9wcm9jZXNzICpwcm9jZXNzOw0KPiAgIAlzdHJ1Y3Qga2ZkX2RldiAq
ZGV2ID0gTlVMTDsNCj4gLQl1bnNpZ25lZCBsb25nIHZtX3Bnb2ZmOw0KPiArCXVuc2lnbmVkIGxv
bmcgbW1hcF9vZmZzZXQ7DQo+ICAgCXVuc2lnbmVkIGludCBncHVfaWQ7DQo+ICAgDQo+ICAgCXBy
b2Nlc3MgPSBrZmRfZ2V0X3Byb2Nlc3MoY3VycmVudCk7DQo+ICAgCWlmIChJU19FUlIocHJvY2Vz
cykpDQo+ICAgCQlyZXR1cm4gUFRSX0VSUihwcm9jZXNzKTsNCj4gICANCj4gLQl2bV9wZ29mZiA9
IHZtYS0+dm1fcGdvZmY7DQo+IC0Jdm1hLT52bV9wZ29mZiA9IEtGRF9NTUFQX09GRlNFVF9WQUxV
RV9HRVQodm1fcGdvZmYpOw0KPiAtCWdwdV9pZCA9IEtGRF9NTUFQX0dQVV9JRF9HRVQodm1fcGdv
ZmYpOw0KPiArCW1tYXBfb2Zmc2V0ID0gdm1hLT52bV9wZ29mZiA8PCBQQUdFX1NISUZUOw0KPiAr
CWdwdV9pZCA9IEtGRF9NTUFQX0dFVF9HUFVfSUQobW1hcF9vZmZzZXQpOw0KPiAgIAlpZiAoZ3B1
X2lkKQ0KPiAgIAkJZGV2ID0ga2ZkX2RldmljZV9ieV9pZChncHVfaWQpOw0KPiAgIA0KPiAtCXN3
aXRjaCAodm1fcGdvZmYgJiBLRkRfTU1BUF9UWVBFX01BU0spIHsNCj4gKwkvKiBvbmx5IGxlYXZl
IHRoZSBvZmZzZXQgc2VnbWVudCAqLw0KPiArCXZtYS0+dm1fcGdvZmYgJj0gKDFVTEwgPDwgKEtG
RF9NTUFQX0dQVV9JRF9TSElGVCAtIFBBR0VfU0hJRlQpKSAtIDE7DQoNCllvdSdyZSBub3cgb3Bl
bi1jb2Rpbmcgd2hhdCB1c2VkIHRvIGJlIGRvbmUgYnkgdGhlIA0KS0ZEX01NQVBfT0ZGU0VUX1ZB
TFVFX0dFVCBtYWNyby4gSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgYW4gaW1wcm92ZW1lbnQuIA0K
TWF5YmUgYmV0dGVyIHRvIHVwZGF0ZSB0aGUgbWFjcm8gdG8gZG8gdGhpcy4NCg0KDQo+ICsNCj4g
Kwlzd2l0Y2ggKG1tYXBfb2Zmc2V0ICYgS0ZEX01NQVBfVFlQRV9NQVNLKSB7DQo+ICAgCWNhc2Ug
S0ZEX01NQVBfVFlQRV9ET09SQkVMTDoNCj4gICAJCWlmICghZGV2KQ0KPiAgIAkJCXJldHVybiAt
RU5PREVWOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2
ZW50cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+IGluZGV4
IDkwODA4MWM4NWRlMS4uMWY4MzY1NTc1YjEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2V2ZW50cy5jDQo+IEBAIC0zNDYsNyArMzQ2LDYgQEAgaW50IGtmZF9ldmVudF9j
cmVhdGUoc3RydWN0IGZpbGUgKmRldmtmZCwgc3RydWN0IGtmZF9wcm9jZXNzICpwLA0KPiAgIAkJ
cmV0ID0gY3JlYXRlX3NpZ25hbF9ldmVudChkZXZrZmQsIHAsIGV2KTsNCj4gICAJCWlmICghcmV0
KSB7DQo+ICAgCQkJKmV2ZW50X3BhZ2Vfb2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9FVkVOVFM7DQo+
IC0JCQkqZXZlbnRfcGFnZV9vZmZzZXQgPDw9IFBBR0VfU0hJRlQ7DQo+ICAgCQkJKmV2ZW50X3Ns
b3RfaW5kZXggPSBldi0+ZXZlbnRfaWQ7DQo+ICAgCQl9DQo+ICAgCQlicmVhazsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+IGluZGV4IDY2YmFlOGYyZGFkMS4uOGVlY2Qy
Y2QxZmQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJp
di5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gQEAg
LTU5LDI0ICs1OSwyMSBAQA0KPiAgICAqIE5PVEU6IHN0cnVjdCB2bV9hcmVhX3N0cnVjdC52bV9w
Z29mZiB1c2VzIG9mZnNldCBpbiBwYWdlcy4gSGVuY2UsIHRoZXNlDQo+ICAgICogIGRlZmluZXMg
YXJlIHcuci50IHRvIFBBR0VfU0laRQ0KPiAgICAqLw0KPiAtI2RlZmluZSBLRkRfTU1BUF9UWVBF
X1NISUZUCSg2MiAtIFBBR0VfU0hJRlQpDQo+ICsjZGVmaW5lIEtGRF9NTUFQX1RZUEVfU0hJRlQJ
KDYyKQ0KPiAgICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9NQVNLCSgweDNVTEwgPDwgS0ZEX01NQVBf
VFlQRV9TSElGVCkNCj4gICAjZGVmaW5lIEtGRF9NTUFQX1RZUEVfRE9PUkJFTEwJKDB4M1VMTCA8
PCBLRkRfTU1BUF9UWVBFX1NISUZUKQ0KPiAgICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9FVkVOVFMJ
KDB4MlVMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQ0KPiAgICNkZWZpbmUgS0ZEX01NQVBfVFlQ
RV9SRVNFUlZFRF9NRU0JKDB4MVVMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQ0KPiAgICNkZWZp
bmUgS0ZEX01NQVBfVFlQRV9NTUlPCSgweDBVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkNCj4g
ICANCj4gLSNkZWZpbmUgS0ZEX01NQVBfR1BVX0lEX1NISUZUICg0NiAtIFBBR0VfU0hJRlQpDQo+
ICsjZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9TSElGVCAoNDYpDQo+ICAgI2RlZmluZSBLRkRfTU1B
UF9HUFVfSURfTUFTSyAoKCgxVUxMIDw8IEtGRF9HUFVfSURfSEFTSF9XSURUSCkgLSAxKSBcDQo+
ICAgCQkJCTw8IEtGRF9NTUFQX0dQVV9JRF9TSElGVCkNCj4gICAjZGVmaW5lIEtGRF9NTUFQX0dQ
VV9JRChncHVfaWQpICgoKCh1aW50NjRfdClncHVfaWQpIDw8IEtGRF9NTUFQX0dQVV9JRF9TSElG
VClcDQo+ICAgCQkJCSYgS0ZEX01NQVBfR1BVX0lEX01BU0spDQo+IC0jZGVmaW5lIEtGRF9NTUFQ
X0dQVV9JRF9HRVQob2Zmc2V0KSAgICAoKG9mZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKSBc
DQo+ICsjZGVmaW5lIEtGRF9NTUFQX0dFVF9HUFVfSUQob2Zmc2V0KSAgICAoKG9mZnNldCAmIEtG
RF9NTUFQX0dQVV9JRF9NQVNLKSBcDQo+ICAgCQkJCT4+IEtGRF9NTUFQX0dQVV9JRF9TSElGVCkN
Cj4gICANCj4gLSNkZWZpbmUgS0ZEX01NQVBfT0ZGU0VUX1ZBTFVFX01BU0sJKDB4M0ZGRkZGRkZG
RkZGVUxMID4+IFBBR0VfU0hJRlQpDQo+IC0jZGVmaW5lIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9H
RVQob2Zmc2V0KSAob2Zmc2V0ICYgS0ZEX01NQVBfT0ZGU0VUX1ZBTFVFX01BU0spDQoNClRoaXMg
bWFjcm8gaXMgc3RpbGwgdXNlZnVsLiBTZWUgYWJvdmUuIEkgdGhpbmsgeW91IHNob3VsZCBqdXN0
IHVwZGF0ZSANCnRoZSBtYXNrIGFuZCBjb250aW51ZSB1c2luZyBpdCBmb3IgY2xhcml0eS4NCg0K
UmVnYXJkcywNCiDCoCBGZWxpeA0KDQoNCj4gLQ0KPiAgIC8qDQo+ICAgICogV2hlbiB3b3JraW5n
IHdpdGggY3Agc2NoZWR1bGVyIHdlIHNob3VsZCBhc3NpZ24gdGhlIEhJUSBtYW51YWxseSBvciB2
aWENCj4gICAgKiB0aGUgYW1kZ3B1IGRyaXZlciB0byBhIGZpeGVkIGhxZCBzbG90LCBoZXJlIGFy
ZSB0aGUgZml4ZWQgSElRIGhxZCBzbG90DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYw0KPiBpbmRleCA2YWJmYjc3YWU1NDAuLjM5ZGM0OWI4ZmQ4NSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+IEBAIC01NTQsOCArNTU0
LDcgQEAgc3RhdGljIGludCBrZmRfcHJvY2Vzc19pbml0X2N3c3JfYXB1KHN0cnVjdCBrZmRfcHJv
Y2VzcyAqcCwgc3RydWN0IGZpbGUgKmZpbGVwKQ0KPiAgIAkJaWYgKCFkZXYtPmN3c3JfZW5hYmxl
ZCB8fCBxcGQtPmN3c3Jfa2FkZHIgfHwgcXBkLT5jd3NyX2Jhc2UpDQo+ICAgCQkJY29udGludWU7
DQo+ICAgDQo+IC0JCW9mZnNldCA9IChLRkRfTU1BUF9UWVBFX1JFU0VSVkVEX01FTSB8IEtGRF9N
TUFQX0dQVV9JRChkZXYtPmlkKSkNCj4gLQkJCTw8IFBBR0VfU0hJRlQ7DQo+ICsJCW9mZnNldCA9
IEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVNIHwgS0ZEX01NQVBfR1BVX0lEKGRldi0+aWQpOw0K
PiAgIAkJcXBkLT50YmFfYWRkciA9IChpbnQ2NF90KXZtX21tYXAoZmlsZXAsIDAsDQo+ICAgCQkJ
S0ZEX0NXU1JfVEJBX1RNQV9TSVpFLCBQUk9UX1JFQUQgfCBQUk9UX0VYRUMsDQo+ICAgCQkJTUFQ
X1NIQVJFRCwgb2Zmc2V0KTsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
