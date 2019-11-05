Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E560C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090B42084D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090B42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98E16EB76;
	Tue,  5 Nov 2019 22:36:57 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820058.outbound.protection.outlook.com [40.107.82.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6132D6EB76
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 22:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy1+qXRg4KibBB9EL7vZqR0aR8/nahS0BdJunBuOor0dV7OyOyiHpM9jfhOTCqBGqN1+ddRMn6bIXagtEoNyzh4juEXVJvS1UBlcvdyGfk/BGVvT54bMetVte9PKZUonZFAQug3eMdyCcWcAoKAnBb6t/0t3t+Bu9bdL/RVy0+ks6O719m4+C/J0OiwZ1zbPJL9FipHP7qmeZ7tEkRcHs89WBqyTga5wSdwezpIIdinEaoLO/e2+bXmyNlR9W+jJ16YSsMIL91qaHApFVwwliyzP2ez914Trf7tAZS5Y7jg/LWe5LgNZAUmnPXz9gf0vxFxYLJczRjTaHUQBLe3KhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRZLpfpdX3dl0zYGt8H2sT0rEt6WdplnLD+OqVDYrrc=;
 b=myB9cRiOLsSgJRWSMKaTkEG3Y0uEay+Dpea6E566I+mwFz5tFKNkhRoKCpfko23SPQL6RP+f8Phvwiiiu6smu7H2w1ndBOn6AUi1fXZgmAnIqMirHp/+/sN9YQ4EBoKNyCA5wRtTWqNcOwWrec+5Dm/7m3XhAQ6uTxbzENCasatcwXXkXjyvn3cSz5NFYkqN/WV1DNRe4AUEEjO1KCEWODt6P5R/H+hFaInMmOjZHkKWM0/4j93M3q1SfWJ4Ehs87QQd65MQR+U5G0kqbfptPkfSBfsiR8llXr5DvKhQOXpSNBmFi5Cei7Gckg1EERXQzEfGeOf5giTEMRV/8u0OiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB4057.namprd12.prod.outlook.com (10.141.184.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 22:36:55 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 22:36:55 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCgfmdBRrOtnp0CjqhT72Mz92ad9KrqA
Date: Tue, 5 Nov 2019 22:36:54 +0000
Message-ID: <175c5d68-f245-ba76-e635-a1abe2136981@amd.com>
References: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
In-Reply-To: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e02cfb9-50c4-4a23-cbf6-08d76240a8f2
x-ms-traffictypediagnostic: DM6PR12MB4057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4057279BA593C5C877A612DC927E0@DM6PR12MB4057.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(7736002)(6436002)(14444005)(65956001)(65806001)(14454004)(256004)(81156014)(31696002)(8676002)(6116002)(11346002)(86362001)(446003)(6512007)(229853002)(6486002)(36756003)(476003)(66066001)(26005)(3846002)(478600001)(486006)(5660300002)(102836004)(25786009)(31686004)(53546011)(6506007)(316002)(386003)(2616005)(186003)(2501003)(110136005)(2906002)(58126008)(99286004)(8936002)(76176011)(71190400001)(71200400001)(66476007)(66946007)(66446008)(305945005)(64756008)(52116002)(66556008)(6246003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4057;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3KrApbPje/DdmQjkGqR7PnyR7SX0m7CgKMUkywNAX10QgWW57TbWcDQvaO8w7rZZnn1/Pzj7Tof4uBQs8ATpZ0XKFpzP4sZztYo3lCACYZGgE8gavf5Pmb6vNKq1iz3sNMyAni3K5LrS5Te37mf8XVspcpmWIHQ7MsJWm3aQ8w+xT7ApNssrTVG/5CvndT8IaWjZwpTV1BdYRhFjhIzntWQxaGxYswRV2CzY0/6lQ8wC08LXWrzxTLxl7BWK0BEfJd8btiuV4q56KlDrdMedzCc6ztc22NMDFEt8MXuJ6O7bK1NzNUVuogHmzyLldyKfkuzA8vUQhahTgwkHgJP59GEIDVPYOyMoWyZl2ml10NnSDHKdqmKgd6dFoHnNF+dtN3tKy062uOMDrvWktB9OsxL3cLdhp3w7Jz61tZnfK7vPHobigUGV/VODdCBoF+N
Content-ID: <E590EE3A4E84CE4B8FF86520A9A1086C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02cfb9-50c4-4a23-cbf6-08d76240a8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 22:36:54.9986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJiCUOBXpcsqRF8o+2Z3ucSmHiGXDT7IQ+2t+QZCOWmP0phuCMyuLRpQSfMH/iOVNHFpvziVT5cripgEtTJcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRZLpfpdX3dl0zYGt8H2sT0rEt6WdplnLD+OqVDYrrc=;
 b=koap/3GpltHhpMxzYZOeNefzisT+hll1VM3yRtEhyJXCJQ3MDTmZLOZK2eaU8NYL0X+KQpXTyKv7DlUNIckFGECe/IrgAJIwsSZta254WsRz+ub5JE8CfLSTKW1cu49aPDAXQ3jg8iGTzzwcSWbJELtTO1DFyX6yCn5Tj7e66w4=
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
Message-ID: <20191105223654.jgPTpTwCym42Mnhg4TflgEr6_OK_jY2tNSu1-U78vT8@z>

T24gMjAxOS0xMS0wNSA1OjI2IHAubS4sIEh1YW5nLCBKaW5IdWlFcmljIHdyb3RlOg0KPiBVc2lu
ZyB1bmlmaWVkIFZCSU9TIGhhcyBwZXJmb3JtYW5jZSBkcm9wIGluIHNyaW92IGVudmlyb25tZW50
Lg0KPiBUaGUgZml4IGlzIHN3aXRjaGluZyB0byBhbm90aGVyIHJlZ2lzdGVyIGluc3RlYWQuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPEppbmh1aUVyaWMuSHVhbmdAYW1kLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0K
DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDE5
ICsrKysrKysrKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
DQo+IGluZGV4IDgyOWQ2MjMuLmU0NGEzZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYw0KPiBAQCAtMzg4NSw5ICszODg1LDIyIEBAIHN0YXRpYyB1aW50NjRfdCBn
ZnhfdjlfMF9nZXRfZ3B1X2Nsb2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQo+ICAgCXVpbnQ2NF90IGNsb2NrOw0KPiAgIA0KPiAgIAltdXRleF9sb2NrKCZhZGV2LT5nZngu
Z3B1X2Nsb2NrX211dGV4KTsNCj4gLQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NBUFRVUkVf
R1BVX0NMT0NLX0NPVU5ULCAxKTsNCj4gLQljbG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUo
R0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VOVF9MU0IpIHwNCj4gLQkJKCh1aW50NjRfdClSUkVH
MzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VOVF9NU0IpIDw8IDMyVUxMKTsNCj4g
KwlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEwICYmIGFtZGdwdV9zcmlvdl9ydW50
aW1lKGFkZXYpKSB7DQo+ICsJCXVpbnQzMl90IHRtcCwgbHNiLCBtc2IsIGkgPSAwOw0KPiArCQlk
byB7DQo+ICsJCQlpZiAoaSAhPSAwKQ0KPiArCQkJCXVkZWxheSgxKTsNCj4gKwkJCXRtcCA9IFJS
RUczMl9TT0MxNShHQywgMCwgbW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX01TQik7DQo+ICsJCQls
c2IgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1JFRkNMT0NLX1RJTUVTVEFNUF9MU0IpOw0K
PiArCQkJbXNiID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19SRUZDTE9DS19USU1FU1RBTVBf
TVNCKTsNCj4gKwkJCWkrKzsNCj4gKwkJfSB3aGlsZSAodW5saWtlbHkodG1wICE9IG1zYikgJiYg
KGkgPCBhZGV2LT51c2VjX3RpbWVvdXQpKTsNCj4gKwkJY2xvY2sgPSAodWludDY0X3QpbHNiIHwg
KCh1aW50NjRfdCltc2IgPDwgMzJVTEwpOw0KPiArCX0gZWxzZSB7DQo+ICsJCVdSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfQ0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQsIDEpOw0KPiArCQljbG9jayA9
ICh1aW50NjRfdClSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VOVF9MU0Ip
IHwNCj4gKwkJCSgodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tf
Q09VTlRfTVNCKSA8PCAzMlVMTCk7DQo+ICsJfQ0KPiAgIAltdXRleF91bmxvY2soJmFkZXYtPmdm
eC5ncHVfY2xvY2tfbXV0ZXgpOw0KPiAgIAlyZXR1cm4gY2xvY2s7DQo+ICAgfQ0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
