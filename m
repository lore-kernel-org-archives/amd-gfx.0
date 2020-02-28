Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE0C3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA4424695
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0+3a7MBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA4424695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1C56E142;
	Fri, 28 Feb 2020 09:26:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E94F6E142
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTSAUEhk1DZ5qf3sL0tmE669wTWRAExsyrF/JThczeZ/gzlnB/4p5B98Nd5i9yxgnKF3+24SPegX74dZDjGohEHICPiJyaba/m1BNvHTwmq/uHEqOa/jec1s4xcBuAm/xgbCNdhLO3gh2ooWZS/vLTlCgVShHchkZcKCOdBCioqd35n0BVQOQtGCI/edxbja2m9rlbSQZCNq3dJbH/3m2UVxZhcQtrjPNrpb6G+OxndDr6GaH9wy6jHaMynvZIbCtkXmsD7dnbrpLKblYPXGA5FXXZ4pbaA8y5tZseQ2Gx3n4vO+yjkprb+YgwNLhQUKafAH+FTndDjV03gVoqaHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQ7++pCqQ+/8cRVsfCWYdEixj3u5sVjldIEFbgQAF0=;
 b=lRRJDlfcFQztQYLOWh9KPpjwxQmtjuddz+waR5avqbInU9bfiN5IUgkYAGlzB4uGVk0hi+ExngktSwTFWTvA58flUrLMX0+QcK4QOErkScqVC1v9nN7583ADa5iII7kMRSxZpYK9/R4daNyFUzMfBk4IEheCb3zLMuEZgOKEt6oIKVTz6SzJrDaQKyVHh89s2BxkvxodILw6XjXQp4rYI4fFfoyD9WxVyE5CKs99HFAfziNFpjwnqILVhW2xISCd9Qs1n+6FaW9NtAUux5wV3BosQK8KmQfRgrgDJOFuiZc/vG5MXKqJ7v765Vm7VC9kqvKe7l8yOLlPxVcRvwV+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQ7++pCqQ+/8cRVsfCWYdEixj3u5sVjldIEFbgQAF0=;
 b=0+3a7MBoPjnINPc7NEL8VZxVZUYooLIw1CorIbC8EMU9mbZtHlq3jDrgzcI3B5/vEtqQ3u7Cbr0O8MDlT3kGurHYB02QcZdwGp4yN1fmXyyGDakBcKtUHQDBY4+UVyPrQdrm2n7dZmtvTq68z9l3yXozsPsh012TdZJSeedW6P0=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Fri, 28 Feb
 2020 09:26:00 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 09:25:59 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: clean wptr on wb when gpu recovery
Thread-Topic: [PATCH] drm/amdgpu: clean wptr on wb when gpu recovery
Thread-Index: AQHV7gDEhiXkSZKAN0WJmCrFSuZfp6gwVGYAgAAA/XA=
Date: Fri, 28 Feb 2020 09:25:59 +0000
Message-ID: <MN2PR12MB39337B47051D5FE8227ADA2F84E80@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200228063131.2630-1-yttao@amd.com>
 <fd5c5d29-285d-ab18-b0b4-ca2540e456c2@gmail.com>
In-Reply-To: <fd5c5d29-285d-ab18-b0b4-ca2540e456c2@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [240e:e0:b16d:8000:c092:194e:2579:2313]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92781cf2-857e-423a-0c4a-08d7bc303919
x-ms-traffictypediagnostic: MN2PR12MB3439:|MN2PR12MB3439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34399001576452131663BAB584E80@MN2PR12MB3439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(66574012)(33656002)(55016002)(52536014)(9686003)(5660300002)(7696005)(316002)(2906002)(71200400001)(6636002)(6506007)(8676002)(8936002)(86362001)(110136005)(66446008)(81156014)(64756008)(81166006)(66556008)(478600001)(4326008)(53546011)(76116006)(186003)(66946007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3439;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YObRgE2jUrs/WxRdpyiICx4UJ3ky9HQ8biQWj1UnvJIVUdT+8u/IhX+oYNfazjP2aek0SWysnpUE4Bj3trvxqPKBBjFkD6EEd3r5CeuyGkgt9UVETmfebEaYDBbjzYt4L7zPn+pGmZWiG6cYoq8mdbVWNmkUpi1R6tTsnwfRHJ7GdAufCj9bCC39JeoZA1MMS5AyoiPNQB4q1Hl3zy/pKSENTN6Cqlf1zsuusUf1dvYF4FByTEtYJmN7RCb3PPx2zhl2oQZjUa95SUCEUzYoR3XQ5xKgKKvUx23ha1fgh5mqKZOS4VkSu61nD+/9nFtcvTGePSoxhSzuShaCzjZeSJOvmbA41abOWtjkKMvMgX13oBRZblUa6FacTkmT8Il/TVzp/DkXl0acvqkl2E4lfsbzccM3iYU63Yup2Iu91sxt+2Sjw1DlxDF+k0JZylJn
x-ms-exchange-antispam-messagedata: ci5dWZVfIJCaR8EL1DQGEPK4e6KdRikI3MnV7yV1Y2t97uZ5acseTi8Y/QxscFY4+tTP/z6x9bqHFhu3h5GwycbCrKxOwiy6x85GnE70PL+IIpmhaz0aGWJmuPsWwZ1nPvdVdppdkOeOMGDI9uGr8tbbtmaFEkcrI+HZ81lw7vh0K08KvsSBqsKNjDz7M/30IgXuhAE3s9nQMxeiCq4XYQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92781cf2-857e-423a-0c4a-08d7bc303919
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 09:25:59.6190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKq6AQJZkFIoTejFSIDe2bOiIRrOeQ8m+S+hDDqxcrHrTRbQPILKs5Xx5p5T+zF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBhIGNsZWFyIGZpeCA6DQoNCkFmdGVyIFREUiB3ZSBoYXZlIGEgY29tcHV0ZSByaW5n
IEhRRCByZXN0b3JlIGZyb20gaXRzIE1RRCwgYnV0IHRoZSBNUUQgb25seSByZWNvcmQgIldQVFJf
QUREUl9MTy9ISSIgc28gb25jZQ0KSFFEIHJlc3RvcmVkIHRoZSBNRUMgd291bGQgaW1tZWRpYXRl
bHkgcmVhZCB2YWx1ZSBmcm9tICJXUFRSX0FERFJfTE8vSEkiIHdoaWNoIGlzIGEgV0IgbWVtb3J5
LCAgYW5kIHRoYXQgdmFsdWUgaXMgc29tZXRpbWUgbm90ICIwIiAgKGJlY2F1c2UgVERSIHdvbid0
IGNsZWFyIFdCLCBpdHMgdmFsdWUgaXMgd2hhdCBhIGhhbmcgcHJvY2VzcyBsZWZ0IHRoZXJlICkN
ClNvIE1FQyBjb25zaWRlciB0aGVyZSBpcyBjb21tYW5kIGluIFJCIChzaW5jZSBSUFRSICE9IFdQ
VFIpIHRodXMgbGVhZCB0byBmdXJ0aGVyIGhhbmcgDQoNClJldmlld2VkLWJ5OiBNb25rIExpdSA8
bW9uay5saXVAYW1kLmNvbT4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDI4LCAyMDIwIDU6MjAg
UE0NClRvOiBUYW8sIFlpbnRpYW4gPFlpbnRpYW4uVGFvQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBjbGVhbiB3cHRyIG9uIHdiIHdoZW4gZ3B1IHJlY292ZXJ5DQoNCkFtIDI4LjAyLjIw
IHVtIDA3OjMxIHNjaHJpZWIgWWludGlhbiBUYW86DQo+IFRoZSBURFIgd2lsbCBiZSByYW5kb21s
eSBmYWlsZWQgZHVlIHRvIGNvbXB1dGUgcmluZyB0ZXN0IGZhaWx1cmUuIElmIA0KPiB0aGUgY29t
cHV0ZSByaW5nIHdwdHIgJiAweDdmZihyaW5nX2J1Zl9tYXNrKSBpcyAweDEwMCB0aGVuIGFmdGVy
IG1hcCANCj4gbXFkIHRoZSBjb21wdXRlIHJpbmcgcnB0ciB3aWxsIGJlIHN5bmNlZCB3aXRoIDB4
MTAwLiBBbmQgdGhlIHJpbmcgdGVzdCANCj4gcGFja2V0IHNpemUgaXMgYWxzbyAweDEwMC4NCj4g
VGhlbiBhZnRlciBpbnZvY2F0aW9uIG9mIGFtZGdwdV9yaW5nX2NvbW1pdCwgdGhlIGNwIHdpbGwg
bm90IHJlYWxseSANCj4gaGFuZGxlIHRoZSBwYWNrZXQgb24gdGhlIHJpbmcgYnVmZmVyIGJlY2F1
c2UgcnB0ciBpcyBlcXVhbCB0byB3cHRyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRh
byA8eXR0YW9AYW1kLmNvbT4NCg0KT2YgaGFuZCB0aGF0IGxvb2tzIGNvcnJlY3QgdG8gbWUsIGJ1
dCBJIGNhbid0IGZ1bGx5IGp1ZGdlIGlmIHRoYXQgd29uJ3QgaGF2ZSBhbnkgbmVnYXRpdmUgc2lk
ZSBlZmZlY3RzLiBQYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3Igbm93Lg0KDQpNb25rIGFjY29yZGluZyB0byBnaXQgeW91IG1v
ZGlmaWVkIHRoYXQgZnVuY3Rpb24gYXMgd2VsbC4gQ291bGQgdGhpcyBoYXZlIGFueSBwb3RlbnRp
YWwgbmVnYXRpdmUgZWZmZWN0IGZvciBTUklPVj8gSSBkb24ndCB0aGluayBzbywgYnV0IGJldHRl
ciBzYXZlIHRoYW4gc29ycnkuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAxICsNCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICB8IDEgKw0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEwXzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYw0KPiBpbmRleCA0NGYwMGVjZWEzMjIuLjVkZjFhNmQ0NTQ1NyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gQEAgLTM1MDgsNiArMzUwOCw3IEBA
IHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2tjcV9pbml0X3F1ZXVlKHN0cnVjdCANCj4gYW1kZ3B1X3Jp
bmcgKnJpbmcpDQo+ICAgDQo+ICAgCQkvKiByZXNldCByaW5nIGJ1ZmZlciAqLw0KPiAgIAkJcmlu
Zy0+d3B0ciA9IDA7DQo+ICsJCWF0b21pYzY0X3NldCgoYXRvbWljNjRfdCAqKSZhZGV2LT53Yi53
YltyaW5nLT53cHRyX29mZnNdLCAwKTsNCj4gICAJCWFtZGdwdV9yaW5nX2NsZWFyX3Jpbmcocmlu
Zyk7DQo+ICAgCX0gZWxzZSB7DQo+ICAgCQlhbWRncHVfcmluZ19jbGVhcl9yaW5nKHJpbmcpOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyANCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+IGluZGV4IDQxMzVlNDEy
NmU4Mi4uYWMyMjQ5MGU4NjU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMNCj4gQEAgLTM2NjQsNiArMzY2NCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfa2NxX2lu
aXRfcXVldWUoc3RydWN0IA0KPiBhbWRncHVfcmluZyAqcmluZykNCj4gICANCj4gICAJCS8qIHJl
c2V0IHJpbmcgYnVmZmVyICovDQo+ICAgCQlyaW5nLT53cHRyID0gMDsNCj4gKwkJYXRvbWljNjRf
c2V0KChhdG9taWM2NF90ICopJmFkZXYtPndiLndiW3JpbmctPndwdHJfb2Zmc10sIDApOw0KPiAg
IAkJYW1kZ3B1X3JpbmdfY2xlYXJfcmluZyhyaW5nKTsNCj4gICAJfSBlbHNlIHsNCj4gICAJCWFt
ZGdwdV9yaW5nX2NsZWFyX3JpbmcocmluZyk7DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
