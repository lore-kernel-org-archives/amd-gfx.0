Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D8CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 21:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4158821734
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 21:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4158821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C676F87B;
	Fri,  1 Nov 2019 21:13:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on0617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7680E6E320
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 21:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euk40xKmzN+rmZIXFiwvywADPTNfAeOEnzPtSkZiJkRduLH2sJfCddgVVOg5DqPqGBiX6e6VOn241vqemdvJl6ibEPoNJCM+ij4UGFoTpqfnEnWYeMGBolCdPtzZ8EQJ47LRO2XlLNoJIba3SmmWDf0nxwQh3HZY2SzFcHXWsxM+5eoDKgBeuPR0XL9wQTLzZ5i20/kR/L0ml/teFf6eReSzsMljfodAs0nyYAkTqYnYgyhAjAXsWisV4nANFdUvrT0cfv7YRQgw9FYs25raIbWosYMvs/6aRc5yH6iu1nL3rhdtu3GFqInE0BkTz+iQsVLQ2m58z2GHCwFg9C8HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3DrkzxE9fo23+AGEpZ6hyrTX/SGDoaLo9UHrHT6QcU=;
 b=f4W+V5GQ+K8Mno1FP22YE4dMcBqmek6iYwSS9sDfZ2aafSBs3d8w/hbMwp98GbnyhdvFuI450r47XsMrNvZl/ZZG6DkRsJi2UguGFV1YANSSMCx6wOXDywTSKF2cAM07DY8PeB2l+BE/EMoqHIF8PTt9dumbMvQmtYUn4Sip4B/53MrwJXq0gxte5BZwS/FtR6OnZd/7Q4bsIfIkgA6VXvfkpuwXNmd3LbU/0zfLtbiKXw+n1jLGxckJjM4hS1VIvzLaf57CCaQo7pJiJcHBGW/PEGeBCSRGZsZ1tyPX3+0/H3YF+sXoV3V8+PoVfnXhuyq4XLskTzyMYV+JaGh7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2826.namprd12.prod.outlook.com (20.177.221.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Fri, 1 Nov 2019 21:13:16 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 21:13:16 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhao,
 Yong" <Yong.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVkPW3xyVHQwVd5kGLa7uEKtffqqd20G6A
Date: Fri, 1 Nov 2019 21:13:16 +0000
Message-ID: <c237f5bf-6638-2d90-3f94-e1eca2c22780@amd.com>
References: <20191101204818.8125-1-Yong.Zhao@amd.com>
In-Reply-To: <20191101204818.8125-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1981733b-99bc-406c-a55f-08d75f105004
x-ms-traffictypediagnostic: DM6PR12MB2826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28266CA6A7BC5CB79573CBB892620@DM6PR12MB2826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(102836004)(65956001)(52116002)(26005)(6506007)(6246003)(2501003)(11346002)(478600001)(65806001)(6486002)(6636002)(99286004)(66066001)(5660300002)(31696002)(86362001)(229853002)(186003)(53546011)(305945005)(386003)(76176011)(6512007)(6436002)(2616005)(8676002)(8936002)(58126008)(31686004)(81156014)(81166006)(36756003)(64756008)(486006)(6116002)(446003)(2906002)(3846002)(7736002)(476003)(110136005)(256004)(25786009)(71190400001)(14454004)(66476007)(66446008)(66556008)(66946007)(71200400001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2826;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFAin0cCGaattUEafzLExHHGM2+YFqwq2UluvfUQ3eFccGR3rtv6/zVdXY4ZiXllkAo+fQ9e3Nhac03PVYqQwQ3IcjSQGJjjJkg1mug7cgOYyCQxzlkhe6Vz07RitQ5ldM5tGieo61YsrvLuchjEtoOJQC2TSn7/fQJXwgQjg6MsmxX/J6Kyy5RjRuJwDgWp1rFdgaDpcVSEV4Gj+thVByQkKXv3w9grR0J1xSvqMMkmODmGiFCNO0C/oksSHmImCijaaCrPlMzbx+Ty2cAiJgD7iucJiFtRav1ERye5rFbE8R1Pz4daHPDtNu2y8PbVCK/0sAFDuGZEtKAugbRlEMZ650Ms5nzRLgQm8MqktUvYQaXnXFzIL3z77bW6XVGDXM43gkTIL5rcAmDAIh+tV+xOUWXqRQEUQ50hL0RkvQoDWxvp/2O0m4TVzCxO0F9a
Content-ID: <92F339DDFB9ABE4CB822A38C1719D22D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1981733b-99bc-406c-a55f-08d75f105004
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 21:13:16.5500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MD86nOSScZXq/h7Px5i3oSPLFpy2bx24gInEqY7H0yp+SUXzkN0hDKGBLaA8SullAfDoPmwosE81AFw0UeK6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3DrkzxE9fo23+AGEpZ6hyrTX/SGDoaLo9UHrHT6QcU=;
 b=dsPFj08OUGzgJe/rit0v9GUwvfktRjTU5a18Fr03Z/dHNfQzTyL0ChimByInhdRRLwF3unBfxZW4ygv4JMcVVR1/IkmNFKvhP1wcelPwWevNsxQ2m/jwJ8JLX7mTVhAgeoZWzkz2BUsd7dc+lHbSsYEMOZ7KMAFQRy952gdLQ2I=
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
Message-ID: <20191101211316.uk_1J9h97E0HykLDeSF9K34zriROPtuXBeN69ZZE5zg@z>

TkFLLiBUaGlzIHdvbid0IHdvcmsgZm9yIHNldmVyYWwgcmVhc29ucy4NCg0KVGhlIG1tYXBfb2Zm
c2V0IGlzIHVzZWQgYXMgb2Zmc2V0IHBhcmFtZXRlciBpbiB0aGUgbW1hcCBzeXN0ZW0gY2FsbC4g
SWYgDQp5b3UgY2hlY2sgdGhlIG1hbiBwYWdlIG9mIG1tYXAsIHlvdSdsbCBzZWUgdGhhdCAib2Zm
c2V0IG11c3QgYmUgYSANCm11bHRpcGxlIG9mIHRoZSBwYWdlIHNpemUiLiBUaGVyZWZvcmUgdGhl
IFBBR0VfU0hJRlQgaXMgbmVjZXNzYXJ5Lg0KDQpJbiB0aGUgY2FzZSBvZiBkb29yYmVsbCBvZmZz
ZXRzLCB0aGUgb2Zmc2V0IGlzIHBhcnNlZCBhbmQgcHJvY2Vzc2VkIGJ5IA0KdGhlIFRodW5rIGlu
IHVzZXIgbW9kZS4gT24gR0ZYOSBHUFVzIHRoZSBsb3dlciBiaXRzIGFyZSB1c2VkIGZvciB0aGUg
DQpvZmZzZXQgb2YgdGhlIGRvb3JiZWxsIHdpdGhpbiB0aGUgZG9vcmJlbGwgcGFnZS4gT24gR0ZY
OCB0aGUgcXVldWUgSUQgDQp3YXMgdXNlZCwgYnV0IG9uIEdGWDkgd2UgaGFkIHRvIGRlY291cGxl
ZCB0aGUgZG9vcmJlbGwgSUQgZnJvbSB0aGUgcXVldWUgDQpJRC4gSWYgeW91IHJlbW92ZSB0aGUg
UEFHRV9TSElGVCwgeW91J2xsIG5lZWQgdG8gcHV0IHRob3NlIGJpdHMgDQpzb21ld2hlcmUgZWxz
ZS4gQnV0IHRoYXQgY2hhbmdlIGluIHRoZSBlbmNvZGluZyB3b3VsZCBicmVhayB0aGUgQUJJIHdp
dGggDQp0aGUgVGh1bmsuDQoNClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KT24gMjAxOS0xMS0wMSA0
OjQ4IHAubS4sIFpoYW8sIFlvbmcgd3JvdGU6DQo+IFRoZSBuZXcgY29kZSBpcyBtdWNoIGNsZWFu
ZXIgYW5kIHJlc3VsdHMgaW4gYmV0dGVyIHJlYWRhYmlsaXR5Lg0KPg0KPiBDaGFuZ2UtSWQ6IEkw
YzFmN2NjYTdlMjRkZGI3YjRmZmUxY2IwZmE3MTk0MzgyOGFlMzczDQo+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAxMyArKysrKysrLS0tLS0tDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jICB8ICAxIC0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgIHwgIDkgKysrLS0tLS0tDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyB8ICAzICstLQ0KPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiBpbmRleCBiOTE5OTM3NTNiODIuLjU5
MDEzODcyN2NhOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2NoYXJkZXYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRl
di5jDQo+IEBAIC0yOTgsNyArMjk4LDYgQEAgc3RhdGljIGludCBrZmRfaW9jdGxfY3JlYXRlX3F1
ZXVlKHN0cnVjdCBmaWxlICpmaWxlcCwgc3RydWN0IGtmZF9wcm9jZXNzICpwLA0KPiAgIAkvKiBS
ZXR1cm4gZ3B1X2lkIGFzIGRvb3JiZWxsIG9mZnNldCBmb3IgbW1hcCB1c2FnZSAqLw0KPiAgIAlh
cmdzLT5kb29yYmVsbF9vZmZzZXQgPSBLRkRfTU1BUF9UWVBFX0RPT1JCRUxMOw0KPiAgIAlhcmdz
LT5kb29yYmVsbF9vZmZzZXQgfD0gS0ZEX01NQVBfR1BVX0lEKGFyZ3MtPmdwdV9pZCk7DQo+IC0J
YXJncy0+ZG9vcmJlbGxfb2Zmc2V0IDw8PSBQQUdFX1NISUZUOw0KPiAgIAlpZiAoS0ZEX0lTX1NP
QzE1KGRldi0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5KSkNCj4gICAJCS8qIE9uIFNPQzE1IEFT
SUNzLCBpbmNsdWRlIHRoZSBkb29yYmVsbCBvZmZzZXQgd2l0aGluIHRoZQ0KPiAgIAkJICogcHJv
Y2VzcyBkb29yYmVsbCBmcmFtZSwgd2hpY2ggY291bGQgYmUgMSBwYWdlIG9yIDIgcGFnZXMuDQo+
IEBAIC0xOTM4LDIwICsxOTM3LDIyIEBAIHN0YXRpYyBpbnQga2ZkX21tYXAoc3RydWN0IGZpbGUg
KmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiAgIHsNCj4gICAJc3RydWN0IGtm
ZF9wcm9jZXNzICpwcm9jZXNzOw0KPiAgIAlzdHJ1Y3Qga2ZkX2RldiAqZGV2ID0gTlVMTDsNCj4g
LQl1bnNpZ25lZCBsb25nIHZtX3Bnb2ZmOw0KPiArCXVuc2lnbmVkIGxvbmcgbW1hcF9vZmZzZXQ7
DQo+ICAgCXVuc2lnbmVkIGludCBncHVfaWQ7DQo+ICAgDQo+ICAgCXByb2Nlc3MgPSBrZmRfZ2V0
X3Byb2Nlc3MoY3VycmVudCk7DQo+ICAgCWlmIChJU19FUlIocHJvY2VzcykpDQo+ICAgCQlyZXR1
cm4gUFRSX0VSUihwcm9jZXNzKTsNCj4gICANCj4gLQl2bV9wZ29mZiA9IHZtYS0+dm1fcGdvZmY7
DQo+IC0Jdm1hLT52bV9wZ29mZiA9IEtGRF9NTUFQX09GRlNFVF9WQUxVRV9HRVQodm1fcGdvZmYp
Ow0KPiAtCWdwdV9pZCA9IEtGRF9NTUFQX0dQVV9JRF9HRVQodm1fcGdvZmYpOw0KPiArCW1tYXBf
b2Zmc2V0ID0gdm1hLT52bV9wZ29mZiA8PCBQQUdFX1NISUZUOw0KPiArCWdwdV9pZCA9IEtGRF9N
TUFQX0dFVF9HUFVfSUQobW1hcF9vZmZzZXQpOw0KPiAgIAlpZiAoZ3B1X2lkKQ0KPiAgIAkJZGV2
ID0ga2ZkX2RldmljZV9ieV9pZChncHVfaWQpOw0KPiAgIA0KPiAtCXN3aXRjaCAodm1fcGdvZmYg
JiBLRkRfTU1BUF9UWVBFX01BU0spIHsNCj4gKwkvKiBvbmx5IGxlYXZlIHRoZSBvZmZzZXQgc2Vn
bWVudCAqLw0KPiArCXZtYS0+dm1fcGdvZmYgJj0gKDFVTEwgPDwgKEtGRF9NTUFQX0dQVV9JRF9T
SElGVCAtIFBBR0VfU0hJRlQpKSAtIDE7DQo+ICsNCj4gKwlzd2l0Y2ggKG1tYXBfb2Zmc2V0ICYg
S0ZEX01NQVBfVFlQRV9NQVNLKSB7DQo+ICAgCWNhc2UgS0ZEX01NQVBfVFlQRV9ET09SQkVMTDoN
Cj4gICAJCWlmICghZGV2KQ0KPiAgIAkJCXJldHVybiAtRU5PREVWOw0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+IGluZGV4IDkwODA4MWM4NWRlMS4uMWY4MzY1NTc1
YjEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRz
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+IEBA
IC0zNDYsNyArMzQ2LDYgQEAgaW50IGtmZF9ldmVudF9jcmVhdGUoc3RydWN0IGZpbGUgKmRldmtm
ZCwgc3RydWN0IGtmZF9wcm9jZXNzICpwLA0KPiAgIAkJcmV0ID0gY3JlYXRlX3NpZ25hbF9ldmVu
dChkZXZrZmQsIHAsIGV2KTsNCj4gICAJCWlmICghcmV0KSB7DQo+ICAgCQkJKmV2ZW50X3BhZ2Vf
b2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9FVkVOVFM7DQo+IC0JCQkqZXZlbnRfcGFnZV9vZmZzZXQg
PDw9IFBBR0VfU0hJRlQ7DQo+ICAgCQkJKmV2ZW50X3Nsb3RfaW5kZXggPSBldi0+ZXZlbnRfaWQ7
DQo+ICAgCQl9DQo+ICAgCQlicmVhazsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJp
di5oDQo+IGluZGV4IDY2YmFlOGYyZGFkMS4uOGVlY2QyY2QxZmQyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gQEAgLTU5LDI0ICs1OSwyMSBAQA0KPiAgICAq
IE5PVEU6IHN0cnVjdCB2bV9hcmVhX3N0cnVjdC52bV9wZ29mZiB1c2VzIG9mZnNldCBpbiBwYWdl
cy4gSGVuY2UsIHRoZXNlDQo+ICAgICogIGRlZmluZXMgYXJlIHcuci50IHRvIFBBR0VfU0laRQ0K
PiAgICAqLw0KPiAtI2RlZmluZSBLRkRfTU1BUF9UWVBFX1NISUZUCSg2MiAtIFBBR0VfU0hJRlQp
DQo+ICsjZGVmaW5lIEtGRF9NTUFQX1RZUEVfU0hJRlQJKDYyKQ0KPiAgICNkZWZpbmUgS0ZEX01N
QVBfVFlQRV9NQVNLCSgweDNVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkNCj4gICAjZGVmaW5l
IEtGRF9NTUFQX1RZUEVfRE9PUkJFTEwJKDB4M1VMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQ0K
PiAgICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9FVkVOVFMJKDB4MlVMTCA8PCBLRkRfTU1BUF9UWVBF
X1NISUZUKQ0KPiAgICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9SRVNFUlZFRF9NRU0JKDB4MVVMTCA8
PCBLRkRfTU1BUF9UWVBFX1NISUZUKQ0KPiAgICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9NTUlPCSgw
eDBVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkNCj4gICANCj4gLSNkZWZpbmUgS0ZEX01NQVBf
R1BVX0lEX1NISUZUICg0NiAtIFBBR0VfU0hJRlQpDQo+ICsjZGVmaW5lIEtGRF9NTUFQX0dQVV9J
RF9TSElGVCAoNDYpDQo+ICAgI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfTUFTSyAoKCgxVUxMIDw8
IEtGRF9HUFVfSURfSEFTSF9XSURUSCkgLSAxKSBcDQo+ICAgCQkJCTw8IEtGRF9NTUFQX0dQVV9J
RF9TSElGVCkNCj4gICAjZGVmaW5lIEtGRF9NTUFQX0dQVV9JRChncHVfaWQpICgoKCh1aW50NjRf
dClncHVfaWQpIDw8IEtGRF9NTUFQX0dQVV9JRF9TSElGVClcDQo+ICAgCQkJCSYgS0ZEX01NQVBf
R1BVX0lEX01BU0spDQo+IC0jZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9HRVQob2Zmc2V0KSAgICAo
KG9mZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKSBcDQo+ICsjZGVmaW5lIEtGRF9NTUFQX0dF
VF9HUFVfSUQob2Zmc2V0KSAgICAoKG9mZnNldCAmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKSBcDQo+
ICAgCQkJCT4+IEtGRF9NTUFQX0dQVV9JRF9TSElGVCkNCj4gICANCj4gLSNkZWZpbmUgS0ZEX01N
QVBfT0ZGU0VUX1ZBTFVFX01BU0sJKDB4M0ZGRkZGRkZGRkZGVUxMID4+IFBBR0VfU0hJRlQpDQo+
IC0jZGVmaW5lIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9HRVQob2Zmc2V0KSAob2Zmc2V0ICYgS0ZE
X01NQVBfT0ZGU0VUX1ZBTFVFX01BU0spDQo+IC0NCj4gICAvKg0KPiAgICAqIFdoZW4gd29ya2lu
ZyB3aXRoIGNwIHNjaGVkdWxlciB3ZSBzaG91bGQgYXNzaWduIHRoZSBISVEgbWFudWFsbHkgb3Ig
dmlhDQo+ICAgICogdGhlIGFtZGdwdSBkcml2ZXIgdG8gYSBmaXhlZCBocWQgc2xvdCwgaGVyZSBh
cmUgdGhlIGZpeGVkIEhJUSBocWQgc2xvdA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMNCj4gaW5kZXggNmFiZmI3N2FlNTQwLi4zOWRjNDliOGZkODUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiBAQCAtNTU0LDggKzU1
NCw3IEBAIHN0YXRpYyBpbnQga2ZkX3Byb2Nlc3NfaW5pdF9jd3NyX2FwdShzdHJ1Y3Qga2ZkX3By
b2Nlc3MgKnAsIHN0cnVjdCBmaWxlICpmaWxlcCkNCj4gICAJCWlmICghZGV2LT5jd3NyX2VuYWJs
ZWQgfHwgcXBkLT5jd3NyX2thZGRyIHx8IHFwZC0+Y3dzcl9iYXNlKQ0KPiAgIAkJCWNvbnRpbnVl
Ow0KPiAgIA0KPiAtCQlvZmZzZXQgPSAoS0ZEX01NQVBfVFlQRV9SRVNFUlZFRF9NRU0gfCBLRkRf
TU1BUF9HUFVfSUQoZGV2LT5pZCkpDQo+IC0JCQk8PCBQQUdFX1NISUZUOw0KPiArCQlvZmZzZXQg
PSBLRkRfTU1BUF9UWVBFX1JFU0VSVkVEX01FTSB8IEtGRF9NTUFQX0dQVV9JRChkZXYtPmlkKTsN
Cj4gICAJCXFwZC0+dGJhX2FkZHIgPSAoaW50NjRfdCl2bV9tbWFwKGZpbGVwLCAwLA0KPiAgIAkJ
CUtGRF9DV1NSX1RCQV9UTUFfU0laRSwgUFJPVF9SRUFEIHwgUFJPVF9FWEVDLA0KPiAgIAkJCU1B
UF9TSEFSRUQsIG9mZnNldCk7DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
