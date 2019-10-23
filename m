Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C0CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 13:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A6A21872
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 13:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A6A21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4A86E0CB;
	Wed, 23 Oct 2019 13:01:15 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740058.outbound.protection.outlook.com [40.107.74.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC936E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 13:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW5+BkBqLd4U1MgEwpjtqQezNHcjVLsCFYNyxvzPRPs0QvkQpamZnBPqxmTJzRYWLmO/W1lueZZ94PmabUrBYp7f051Pe8ke+B1XORin6LcMThp43MQWsAAAb9uQxIq9YbTEnKfw9VDCfzGG4EVldMTqpTj1L739Rr+UbjioBETq1tQk8kDOD0vvfoTR2K2ThDBajQp8LcrLoC0pIUB7Ffm3wdVSA93/1Qu4k5cVo1bkJN0bncAphIY1+elukDKUBmgzPxTmshRyMsUCGaLWDKiWS73vAz9eY3xDAVA2/dJKkhrsnZOML+ZDaRQsKwc1L7l9r5uLm0t7ROcFk4sOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWkvz9uNEavmDsm72cv905zZT5Au4PnOFX0RVYSBDQM=;
 b=Jrih5OQyZAD7sk16Iwi9r+a9xJmJd88brEcz+AIcT+pxH4dKOLip4Lwy3PA2+cyY+EtNrXGpMVBlbxKNDIbJTeWnrejUFK0oYNEuaZcrEP1+Pj4GtueNngCSx72dZP2A2KgiAbeGVXzjIFdTWF+AMxVSUeozwV2F00IBiGwHra5yKvAQS4dODR9twHoKp1fFkj9QLN9RwNPHzOAzwxSP8IWL6oI1JszNuc+N4rOP8MkVaDSgMPkQJCj9ZFTL+tSJ22qin7SKKz4jFrCYOvkHVxhOyOrjfkZtVk5mjEG18XIGrH0KvcXhxdXjzg9Lud0BWeKBSywME99HeNoYVw5mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (10.174.109.137) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (10.172.87.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 23 Oct 2019 13:01:12 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::3dc3:4b65:db8a:47a2]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::3dc3:4b65:db8a:47a2%9]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 13:01:12 +0000
From: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)
Thread-Topic: [PATCH] drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)
Thread-Index: AQHViP090AZEFibW0UG1vMEf2pbBC6dn1jqAgABYmVCAAAMRAA==
Date: Wed, 23 Oct 2019 13:01:12 +0000
Message-ID: <d84ab4d8-4159-4e7a-6de3-4e39492e3df6@amd.com>
References: <20191022172136.15391-1-pierre-eric.pelloux-prayer@amd.com>
 <b3ddc981-c465-b008-705a-d01e44b783e3@gmail.com>
 <BN6PR12MB1809E6469D44AE818542299DF76B0@BN6PR12MB1809.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB1809E6469D44AE818542299DF76B0@BN6PR12MB1809.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0032.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::20) To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.190.135.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d7af9d6-33eb-40f8-ca2c-08d757b9146f
x-ms-traffictypediagnostic: DM5PR1201MB2504:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2504E0F6A894447E6214C5AC8D6B0@DM5PR1201MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(13464003)(6512007)(305945005)(76176011)(36756003)(25786009)(6486002)(11346002)(31696002)(478600001)(5660300002)(7736002)(31686004)(52116002)(966005)(71190400001)(71200400001)(486006)(6306002)(229853002)(2501003)(6436002)(2616005)(99286004)(476003)(6246003)(2906002)(446003)(256004)(26005)(66066001)(110136005)(66476007)(66446008)(86362001)(316002)(186003)(66556008)(64756008)(14454004)(8676002)(102836004)(55236004)(81156014)(3846002)(53546011)(6116002)(6506007)(386003)(81166006)(8936002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2504;
 H:DM5PR1201MB0187.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rLe+04m9B9k2v0aHddssuVrUjtPfuIHX1GDPk7gPYB1uoNmPzGhcwvdnrJnv/gvStBOB0orfY4AQLrTga2GO4W6yNjlj1+pTnYiR7ewZP/8huW63jdWJM7eh09nCc8UfJlZRXZO7xF+569uAO6aHNr8QZVv/okWJB600pOhr1LmZufyqRcykg3mee8T504uhLjmVujSZ3bY44lzJNXzXBsVeCuDaorHf2WEoHycd2EVqwRRJ9PPvUd/BnAZy/2i+ZPsSzr1TB+OUzvcBuSQQbdI1mQMN7W/uT5c2kw71oqK2Bah1J3QwuZfvH/HpTx1mvp+DZ3HvqB2HBBc6qniLlxQQnXViK8KOKtOQGQVPujBiCNLgbYIYt8jqbVIKYPKS9TRzpUowqLKmYTvngu6LLKL3GyIHv7IsmVfVxLtMlJgypEJ+vw7IKQtKF3i8LmmBVTIq732z113EPBTH/r6LmpbSUd81a0DaBk8pn9g0ro=
Content-ID: <E6DE1E6E2CC26845A9D78C22278361BC@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7af9d6-33eb-40f8-ca2c-08d757b9146f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 13:01:12.2200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iNzHalWmQW3d+lnXVqHDJSVubm6yjU42WI5vV6LB5soaB3+TgnC9lyXl7ewJfmLJgr7V3sUYdUnTIE1YoAVcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWkvz9uNEavmDsm72cv905zZT5Au4PnOFX0RVYSBDQM=;
 b=keXiiFSovj55FmShl7dg4aA/aQKkD1EoaHjjoL/H60QfYJaV96eAmurU7RmpEEqdGcptJk8PV+Rk1nDIabpO1k6Ts8m1cCB4ax4fra0MjJoDWh3Ww9GD6GspU7ApSgR7aPbVx5vyAuhKD0C4VzEBpSY+T9Bucu9CfhFp4YKXUhk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
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
Message-ID: <20191023130112.NlXAgTZkEt2C8s0lhmUtUOF4Jrdv_XKmTN39VG2Y4mw@z>

SGkgQWxleCwNCg0KT24gMjMvMTAvMjAxOSAxNDo1MCwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3Rl
Og0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPj4gQ2hyaXN0
aWFuIEvDtm5pZw0KPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIzLCAyMDE5IDM6MzMgQU0N
Cj4+IFRvOiBQZWxsb3V4LXByYXllciwgUGllcnJlLWVyaWMgPFBpZXJyZS1lcmljLlBlbGxvdXgt
cHJheWVyQGFtZC5jb20+OyBhbWQtDQo+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3NkbWE1OiBkbyBub3QgZXhlY3V0ZSAwLXNp
emVkIElCcyAodjIpDQo+Pg0KPj4gQW0gMjIuMTAuMTkgdW0gMTk6MjIgc2NocmllYiBQZWxsb3V4
LXByYXllciwgUGllcnJlLWVyaWM6DQo+Pj4gVGhpcyBzZWVtcyB0byBoZWxwIHdpdGgNCj4+IGh0
dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTExMTQ4MS4NCj4+Pg0K
Pj4+IHYyOiBpbnNlcnQgYSBOT1AgaW5zdGVhZCBvZiBza2lwcGluZyBhbGwgMC1zaXplZCBJQnMg
dG8gYXZvaWQgYnJlYWtpbmcgb2xkZXINCj4+IGh3DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBQ
aWVycmUtRXJpYyBQZWxsb3V4LVByYXllciA8cGllcnJlLWVyaWMucGVsbG91eC0NCj4+IHByYXll
ckBhbWQuY29tPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQo+IA0KPiBEbyBub3AgcGFja2V0cyBoYXZlIGFueSBhbGlnbm1l
bnQgcmVxdWlyZW1lbnRzIG9uIFNETUE/ICBTb21lIG9mIHRoZSBvdGhlciBwYWNrZXRzIGRvLg0K
DQpUaGVyZSdzIG5vIGFsaWdubWVudCByZXF1aXJlbWVudHMgZm9yIG5vcCBwYWNrZXRzLg0KDQpQ
aWVycmUtRXJpYw0KDQo+IA0KPiBBbGV4DQo+IA0KPj4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgMSArDQo+Pj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYw0KPj4+IGluZGV4IGZiNDg2MjJjMmFiZC4uNmUxYjI1YmQxZmU3IDEwMDY0NA0K
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4+PiBAQCAtMzA5LDYg
KzMwOSw3IEBAIHN0YXRpYyB2b2lkIGdtY192MTBfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdA0KPj4g
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwNCj4+Pg0KPj4+ICAgCWpvYi0+dm1f
cGRfYWRkciA9IGFtZGdwdV9nbWNfcGRfYWRkcihhZGV2LT5nYXJ0LmJvKTsNCj4+PiAgIAlqb2It
PnZtX25lZWRzX2ZsdXNoID0gdHJ1ZTsNCj4+PiArCWpvYi0+aWJzLT5wdHJbam9iLT5pYnMtPmxl
bmd0aF9kdysrXSA9IHJpbmctPmZ1bmNzLT5ub3A7DQo+Pj4gICAJYW1kZ3B1X3JpbmdfcGFkX2li
KHJpbmcsICZqb2ItPmlic1swXSk7DQo+Pj4gICAJciA9IGFtZGdwdV9qb2Jfc3VibWl0KGpvYiwg
JmFkZXYtPm1tYW4uZW50aXR5LA0KPj4+ICAgCQkJICAgICAgQU1ER1BVX0ZFTkNFX09XTkVSX1VO
REVGSU5FRCwgJmZlbmNlKTsNCj4+DQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
