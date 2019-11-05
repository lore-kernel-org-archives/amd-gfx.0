Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB72C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE682087E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE682087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716926EB66;
	Tue,  5 Nov 2019 22:17:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0816EB66
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 22:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPP7U0bxFwiy406ju3szF30//EUZKiwZbxbyFuG0cO+QTa1mgK+8U84pOq9+lNBFC7d91VpP/lVNrrLwSwkHnd5fMxLhK/l/jrZYAngfKicU9LSpV0qmH7VSFVcFLb10h3yXPVzqzJeC4CG8yCeKCASOD1SZWyE7MhtQNboGWuMGpKC6LbgWnx2mReCMf869mA+Jto4nAiqD3CKL/AOJw6YR46EmajsFm5PNnx3F4MUcPHXJ9Z2PlLR12IzDJcY54lZslHFa5rndJ75tFymiuGzVZxOHF9EsdPioj2mV74+xQ5i3FlRzJ4vsZZL+AYThC3OkvM3pDK9IqBHMrCppGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETBW0szElI0OpX26SwZIEQetaWuGr9LXWO2VUnBn1uA=;
 b=SyZVpTaTqbuVFym/aHreBy2GMw6tbIAM0RnFY3VCv+qYgSFbWWJYp0uwR8VpJkXjyvwr+pmO1L12wFuosGMx3cqnWEFy6bPGD6TqPtgrQ9x2Pn657Bvo+sFvntYGCta0WyrVSeznN647aG6yn+nKXubiIeudSm006y8akngL27lxtMEEJbSgLDDsUZMmkucHqhWibi8UneDYxOqgm+hHLuWeFXbkuxN8uAgR4rV32FPISIjfVxb3vjivrISELR8JriCP3rZW+xvjiF0LyuZKDvfjiJWKwJYy2MzKbTblYnbCuNwW3yKJv6+T3C0wxX/OiAc38JQ+Lq+gYif1cZel+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3228.namprd12.prod.outlook.com (20.179.105.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 22:17:14 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 22:17:14 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCTVx9bG9gJ+/E2S0FH9h0Ut0ad9JUEA
Date: Tue, 5 Nov 2019 22:17:14 +0000
Message-ID: <e6ecd9fd-58be-428f-6c29-f5dfee699a05@amd.com>
References: <1572991381-19907-1-git-send-email-JinhuiEric.Huang@amd.com>
In-Reply-To: <1572991381-19907-1-git-send-email-JinhuiEric.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25456b26-68b8-4ee9-1399-08d7623de93d
x-ms-traffictypediagnostic: DM6PR12MB3228:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB322802672C53CB78A5D316F4927E0@DM6PR12MB3228.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(31696002)(71190400001)(316002)(86362001)(58126008)(6246003)(2906002)(478600001)(6512007)(36756003)(99286004)(256004)(14444005)(66476007)(66556008)(64756008)(66446008)(66946007)(486006)(11346002)(52116002)(446003)(14454004)(31686004)(76176011)(66066001)(65806001)(65956001)(6116002)(229853002)(81156014)(102836004)(8936002)(81166006)(6436002)(6506007)(2501003)(3846002)(2616005)(476003)(386003)(7736002)(25786009)(26005)(305945005)(186003)(110136005)(6486002)(5660300002)(53546011)(71200400001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3228;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ym/kcyublfiFziDCDw42z67fyHx7t3FpcoWP1+cMgOfDkApqGWZTSETRgidd84QX6S02RgX0YOE5OREvfD2VarvbI1PXccH3oSmMqpxeoo9Js2Fsh/X108olTsYoc5m81GgNbUrBjypXSPDsISWANdceS3e5KbXrdLjJwSrQA4kRLeSEBOf4HP/mhSDH+0I5qZzobwq2ePEwtQDpyQ0VlKzYXwTtD1YjkMjZzbmP1f/+/9gi+InLacQ5JlndRrzGNXJpm91+PuLVE/BjOwdhJbhK8OmwoVscK0B1rN2rtUMqD9CV9Cr3hhR3CpdssplXiJQ2M0Hd/1jo8OS9I6oHgScjGumlwjpGOswyfcJ1fAFpQERdgTopzmYfAd8YMY6b0NukN0eomhOSeMnPaQxTgKHeXtifI4D/cbGQ3TC32XEuyBKDAPJW9TiOnnkImEpb
Content-ID: <1559C25F6E190D4CB6C4921AE9E2FB9D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25456b26-68b8-4ee9-1399-08d7623de93d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 22:17:14.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n38zo1A9FDAa0L9kLi6f39iaIVFoNdXo8E+6weXNcuqvCfU/MfGzxZSQqhamNddMZijzuVnYoysOFDeGQitu0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETBW0szElI0OpX26SwZIEQetaWuGr9LXWO2VUnBn1uA=;
 b=zP66uUOJnsTmWqtFweYm2uNa4FZ5u1NFOKNsDpEfTBEUozHPyC/xvJEhs+0VWe2qEvI6QHuWwwIQC6imIh3mx29vs3nqVtrLOpyqrRIgPK6TLEy6xXOglkTsqLeX0r3rTM0VPvRv6wt99Xs810Ycnc23r0xuk1rKa9UhoD4E1ls=
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
Message-ID: <20191105221714.zQlc5_SFS-aTjxRGRs5hO8fm4FSZT7vSC76Rh7n_dhQ@z>

DQpPbiAyMDE5LTExLTA1IDU6MDMgcC5tLiwgSHVhbmcsIEppbkh1aUVyaWMgd3JvdGU6DQo+IFVz
aW5nIHVuaWZpZWQgVkJJT1MgaGFzIHBlcmZvcm1hbmNlIGRyb3AgaW4gc3Jpb3YgZW52aXJvbm1l
bnQuDQo+IFRoZSBmaXggaXMgc3dpdGNoaW5nIHRvIGFub3RoZXIgcmVnaXN0ZXIgaW5zdGVhZC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8SmluaHVpRXJpYy5IdWFuZ0BhbWQuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMTgg
KysrKysrKysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0K
PiBpbmRleCA4MjlkNjIzLi42NzcwYmQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMNCj4gQEAgLTM4ODUsOSArMzg4NSwyMSBAQCBzdGF0aWMgdWludDY0X3QgZ2Z4
X3Y5XzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
PiAgIAl1aW50NjRfdCBjbG9jazsNCj4gICANCj4gICAJbXV0ZXhfbG9jaygmYWRldi0+Z2Z4Lmdw
dV9jbG9ja19tdXRleCk7DQo+IC0JV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DQVBUVVJFX0dQ
VV9DTE9DS19DT1VOVCwgMSk7DQo+IC0JY2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KEdD
LCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTFNCKSB8DQo+IC0JCSgodWludDY0X3QpUlJFRzMy
X1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTVNCKSA8PCAzMlVMTCk7DQo+ICsJ
aWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0ExMCAmJiBhbWRncHVfc3Jpb3ZfcnVudGlt
ZShhZGV2KSkgew0KPiArCQl1aW50MzJfdCB0bXAsIGxzYiwgbXNiLCBpID0gMDsNCj4gKwkJZG8g
ew0KPiArCQkJdG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19SRUZDTE9DS19USU1FU1RB
TVBfTVNCKTsNCj4gKwkJCWxzYiA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfUkVGQ0xPQ0tf
VElNRVNUQU1QX0xTQik7DQo+ICsJCQltc2IgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1JF
RkNMT0NLX1RJTUVTVEFNUF9NU0IpOw0KPiArCQkJaSsrOw0KPiArCQkJdWRlbGF5KDEpOw0KDQpU
aGlzIHVkZWxheSBzaG91bGQgYmUgY29uZGl0aW9uYWwuIEluIHRoZSBsaWtlbHkgY2FzZSB0aGF0
IHRtcCA9PSBtc2IsIA0KeW91IHNob3VsZCBuZXZlciBoYXZlIHRvIGRlbGF5IGF0IGFsbC4gTWF5
YmUgcHV0IHRoZSBkZWxheSBhdCB0aGUgc3RhcnQgDQpvZiB0aGUgbG9vcCB3aXRoIGEgY29uZGl0
aW9uOg0KDQogwqDCoMKgIGlmIChpICE9IDApDQogwqDCoMKgIMKgwqDCoCB1ZGVsYXkoMSk7DQoN
ClNvIHRoYXQgaXQgb25seSBhcHBsaWVzIGJlZm9yZSB0aGUgc2Vjb25kIGFuZCBsYXRlciBsb29w
cy4NCg0KUmVnYXJkcywNCiDCoCBGZWxpeA0KDQoNCj4gKwkJfSB3aGlsZSAodW5saWtlbHkodG1w
ICE9IG1zYikgJiYgKGkgPCBhZGV2LT51c2VjX3RpbWVvdXQpKTsNCj4gKwkJY2xvY2sgPSAodWlu
dDY0X3QpbHNiIHwgKCh1aW50NjRfdCltc2IgPDwgMzJVTEwpOw0KPiArCX0gZWxzZSB7DQo+ICsJ
CVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQsIDEpOw0K
PiArCQljbG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9D
S19DT1VOVF9MU0IpIHwNCj4gKwkJCSgodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJM
Q19HUFVfQ0xPQ0tfQ09VTlRfTVNCKSA8PCAzMlVMTCk7DQo+ICsJfQ0KPiAgIAltdXRleF91bmxv
Y2soJmFkZXYtPmdmeC5ncHVfY2xvY2tfbXV0ZXgpOw0KPiAgIAlyZXR1cm4gY2xvY2s7DQo+ICAg
fQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
