Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA82C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB6B246BB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="paaF4L6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB6B246BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEA96E213;
	Mon,  2 Mar 2020 09:39:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00596E213
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH+kS6qLD6VPB7VypMlAlakfnxdIKq8yPE1DdWs+EEHmY67BFNGAuuL/iUb+OPrMW5hM+qFLEYG6ao7MSAGRiiMAAE2M5ZHI/WiktD2NgCPeDp9tlctgnVoEHwKnHBFF0cKy16wlQcs9bgD9QLF9niugeLrshCnjkRDEzHhU7unt65fHVY1vDw1lrwDjUt8zyFF4BhEMLhDMzKFilSKpOAbCRHqBDQ2oSrKpH+lLSQOzGw8GDnhJyN79pRAJcVBqy8uKNb+EvBc3e4D0Uh+iHrr4ysduw9u/0RikkPIyLe1vD3RdnLUP/kTkdLa3bUpRAkAdiRtOJOltEWWBrYMJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zof0YwNALGf4ExP0JdA3oc7LOQxqCbuTejHsVcu2Ga8=;
 b=iXgSe0OeITc/gWBkvZBxcc3xA7fvwE5qHkzJtROSRoZZRD0VV60na+gPCr34U7R6fVxuNhpMbrKzHTs8MoJZIaxPDeyFTzkLRR2xbB+UIEMhQNWK9bvjGXcOL+sb1Wawhheqs+r9uL83El8GoUrClbDVZbcp18AwKyPSjjtYYbKuDi+KgWIX8/89m0XQTQBTitghjiMujmLzcnwCIt9Gg/TTcJptFUKqDU88mO2aAsOVEy2NC0ApmArOzVf841BoeyO3fgx0ygg2cBD12eW57UFE2ETxAcNaLve/Q/9VpiqJI8uiEBd7icMbJ4zax+eKCYFti0Bvhtmprs+UakuxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zof0YwNALGf4ExP0JdA3oc7LOQxqCbuTejHsVcu2Ga8=;
 b=paaF4L6tbmcLchKYhfamtEYbY77wCmy54BRy7njZMBoHbo5EIItFKad21YrrygWEkvYtVg/YKhePkb7az/xX5hGsQgsPC6KuRDUSQJbHvV80MV530sLVftmUTcdzpwPmI/jXbPKocVRqu0MWfC7++c/9aCCkSIguRWMEbMG4JCM=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 09:39:55 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:39:55 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: fix IB test MCBP bug
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix IB test MCBP bug
Thread-Index: AQHV8HQRSuziBiDCHEqkZwa5mo1oeqg1CrQAgAAARkA=
Date: Mon, 2 Mar 2020 09:39:55 +0000
Message-ID: <MN2PR12MB3933638FC598F979E2F3E65384E70@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
 <63e00945-68e3-f128-5a78-51c1d87bc778@gmail.com>
In-Reply-To: <63e00945-68e3-f128-5a78-51c1d87bc778@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 702fd3f0-0cf9-49af-1b5d-08d7be8daa6d
x-ms-traffictypediagnostic: MN2PR12MB3693:|MN2PR12MB3693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3693A022227E2BAF70BF75DE84E70@MN2PR12MB3693.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(71200400001)(33656002)(52536014)(86362001)(5660300002)(110136005)(53546011)(316002)(7696005)(6506007)(9686003)(55016002)(81156014)(81166006)(8676002)(76116006)(66574012)(66946007)(66476007)(66556008)(64756008)(8936002)(66446008)(26005)(186003)(478600001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3693;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmRY4DHRZaTz9LRcDP4q03OPtMkd0sH2K6JvMmxpnRclo3N132twbshh4GKEoNl31n+5pvRjPszO6hl5o29yk3NSPYNMI0ETVQL3znGWbgFpeqofa/mmkNuFIYBp2rwx1khDqZO9i4C+1+ZtTgrfEI4O8aeq2ONeVOtCaLUcj60I9NNifjfiBqJ3ilmW2bUiKPlz179Cz5zTKyKPLfdzI1p8nmpthYdvb62mEDERVMSokA8ph5GL7qYiIrvVMuqvNq8IghI7l5BplrVVbML6RB+9XWZmJwfir5MBQNHzrX4W8OgwtJywF9QlUZwCn9jq+T+gvWg0cQ3qK4pgK8zIzrccbVhtAth6UwqvrNDtYPgSDXVO6t0A2Yt6fJcu210MPHMOAQLdH+R8EGOqYe443G6bY6HO5t78BvjlaggGsnO1BPW5mrMUTBnsRw/umDqT
x-ms-exchange-antispam-messagedata: 4H1GljqBHgiNxryG+WSwrJo/37+3j99AXzBDnFm9JyPSsOpUQ99rgYyfyPA6gORMsO6HtiYLQp8mxBZKK7WhKEIyI8ydREhB+QNZVlThu3cTKt7XLaH3KS9irZ1xyixBhlhbOmJf3qpXkOEZdvPgGg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702fd3f0-0cf9-49af-1b5d-08d7be8daa6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 09:39:55.3578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGNSCW6J/0Q+hUSFJ3ql9CvlB4+jUCVlocUR+P/+rP7trWvy8Uy6v8xbscuKxIAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiAtCQlpZiAoIShpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19DRSkpDQo+ICsJCWlmICghKGli
LT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKSAmJiB2bWlkKQ0KDQpLZXJuZWwgY29waWVzIGFs
c28gZG9uJ3QgdXNlIGEgVk1JRCwgc28gSSB0aGluayB0aGF0IHRoaXMgd29uJ3Qgd29yayBjb3Jy
ZWN0bHkuDQoNCkRvIHlvdSBoYXZlIHRoZSBqb2IgYXZhaWxhYmxlIGFzIHdlbGw/IFRoYXQgd291
bGQgcHJvYmFibHkgYmUgYmV0dGVyIHRvIHRlc3QgZm9yIHNpbmNlIG9ubHkgSUIgdGVzdHMgZG9u
J3QgdXNlIGEgam9iLg0KDQpbTUxdIA0KVGhlIEBqb2IgaXMgbm90IHBhc3NlZCB0byB0aGUgZ2Z4
X3YxMF8wX3JpbmdfZW1pdF9pYl9nZngoKSByb3V0aW5lIHNvIEkgdGVuZCB0byBtb2RpZnkgYXMg
bGVzcyBhcyBwb3NzaWJsZQ0KQmVzaWRlcywgZm9yIGtlcm5lbCBjb3BpZXM6IEkgYmVsaWV2ZSB0
aGV5IGFsc28gZG8gbm90IHN1cHBvcnQgTUNCUCAoY2FuIHlvdSBwb2ludCBtZSB0aGUgY29kZSBp
biBzb3VyY2Ugb2YgdGhvc2Uga2VybmVsIGNvcGllcyA/KSAsIHNvIHVzZSBWTUlEIHRvIHRlc3Qg
aXMgZmluZSAoVG8gc3VwcG9ydCBNQ0JQIG9uIGdmeCByaW5nIHlvdSBuZWVkIGEgc2V0IG9mIGFk
ZGl0aW9uYWwgcHJlYW1ibGUgSUIgY28gd29yayB3aXRoIHlvdXIgd29ya2xvYWQgaUIgYW5kIGtl
cm5lbCBjb3BpZXMgYXBwYXJlbnRseSBkb24ndCBoYXZlIHRob3NlIHN0dWZmcykNCg0KVGhhbmtz
IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZp
cnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4g
DQpTZW50OiBNb25kYXksIE1hcmNoIDIsIDIwMjAgNTozNSBQTQ0KVG86IExpdSwgTW9uayA8TW9u
ay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBS
ZTogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogZml4IElCIHRlc3QgTUNCUCBidWcNCg0KQW0gMDIu
MDMuMjAgdW0gMTA6MjIgc2NocmllYiBNb25rIExpdToNCj4gMSlmb3IgZ2Z4IElCIHRlc3Qgd2Ug
c2hvdWxkbid0IGluc2VydCBERSBtZXRhIGRhdGENCj4NCj4gMil3ZSBzaG91bGQgbWFrZSBzdXJl
IElCIHRlc3QgZmluaXNoZWQgYmVmb3JlIHdlIHNlbmQgZXZlbnQgMyB0byANCj4gaHlwZXJ2aXNv
ciBvdGhlcndpc2UgdGhlIElETEUgZnJvbSBldmVudCAzIHdpbGwgcHJlZW1wdCBJQiB0ZXN0LCB3
aGljaCANCj4gaXMgbm90IGRlc2lnbmVkIGFzIGEgY29tcGF0aWJsZSBzdHJ1Y3R1cmUgZm9yIE1D
QlANCj4NCj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDYgKysr
KysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jICAgIHwgMyAt
LS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyAgICAgfCAyICst
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyAgICAgIHwgMiArLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICAgICB8IDIgKy0NCj4g
ICA1IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXgg
MzUxMDk2YS4uNTcyZWI2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPiBAQCAtMzE5NSw2ICszMTk1LDEyIEBAIHZvaWQgYW1kZ3B1X2Rldmlj
ZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAlmbHVzaF9kZWxheWVkX3dv
cmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsNCj4gICAJYWRldi0+c2h1dGRvd24gPSB0cnVl
Ow0KPiAgIA0KPiArCS8qIG1ha2Ugc3VyZSBJQiB0ZXN0IGZpbmlzaGVkIGJlZm9yZSBlbnRlcmlu
ZyBleGNsdXNpdmUgbW9kZQ0KPiArCSAqIHRvIGF2b2lkIHByZWVtcHRpb24gb24gSUIgdGVzdA0K
PiArCSAqICovDQo+ICsJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKwkJYW1kZ3B1X3Zp
cnRfcmVxdWVzdF9mdWxsX2dwdShhZGV2LCBmYWxzZSk7DQo+ICsNCj4gICAJLyogZGlzYWJsZSBh
bGwgaW50ZXJydXB0cyAqLw0KPiAgIAlhbWRncHVfaXJxX2Rpc2FibGVfYWxsKGFkZXYpOw0KPiAg
IAlpZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmlnX2luaXRpYWxpemVkKXsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyANCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gaW5kZXggMGYzNTYzOS4uMGIx
NTExYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiBA
QCAtODgsOSArODgsNiBAQCB2b2lkIGFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyhzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2KQ0KPiAgIAlpZiAoYWRldi0+cm1taW8gPT0gTlVMTCkNCj4gICAJCWdvdG8g
ZG9uZV9mcmVlOw0KPiAgIA0KPiAtCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+IC0JCWFt
ZGdwdV92aXJ0X3JlcXVlc3RfZnVsbF9ncHUoYWRldiwgZmFsc2UpOw0KPiAtDQo+ICAgCWlmIChh
ZGV2LT5ydW5wbSkgew0KPiAgIAkJcG1fcnVudGltZV9nZXRfc3luYyhkZXYtPmRldik7DQo+ICAg
CQlwbV9ydW50aW1lX2ZvcmJpZChkZXYtPmRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYw0KPiBpbmRleCA5NGNhOWZmLi4wNTU1OTg5IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPiBAQCAtNDQzMiw3ICs0NDMyLDcgQEAg
c3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3JpbmdfZW1pdF9pYl9nZngoc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nLA0KPiAgIAkJaWYgKGZsYWdzICYgQU1ER1BVX0lCX1BSRUVNUFRFRCkNCj4gICAJCQlj
b250cm9sIHw9IElORElSRUNUX0JVRkZFUl9QUkVfUkVTVU1FKDEpOw0KPiAgIA0KPiAtCQlpZiAo
IShpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19DRSkpDQo+ICsJCWlmICghKGliLT5mbGFncyAm
IEFNREdQVV9JQl9GTEFHX0NFKSAmJiB2bWlkKQ0KPiAgIAkJCWdmeF92MTBfMF9yaW5nX2VtaXRf
ZGVfbWV0YShyaW5nLA0KPiAgIAkJCQkgICAgKCFhbWRncHVfc3Jpb3ZfdmYocmluZy0+YWRldikg
JiYgZmxhZ3MgJiBBTURHUFVfSUJfUFJFRU1QVEVEKSA/IHRydWUgOiBmYWxzZSk7DQo+ICAgCX0N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KPiBpbmRleCAzOTNhMTMy
Li5iMTRmNDZhMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y4XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQo+
IEBAIC02MTE2LDcgKzYxMTYsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjhfMF9yaW5nX2VtaXRfaWJf
Z2Z4KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4gICAJaWYgKGFtZGdwdV9zcmlvdl92Zihy
aW5nLT5hZGV2KSAmJiAoaWItPmZsYWdzICYgQU1ER1BVX0lCX0ZMQUdfUFJFRU1QVCkpIHsNCj4g
ICAJCWNvbnRyb2wgfD0gSU5ESVJFQ1RfQlVGRkVSX1BSRV9FTkIoMSk7DQo+ICAgDQo+IC0JCWlm
ICghKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKSkNCj4gKwkJaWYgKCEoaWItPmZsYWdz
ICYgQU1ER1BVX0lCX0ZMQUdfQ0UpICYmIHZtaWQpDQoNCktlcm5lbCBjb3BpZXMgYWxzbyBkb24n
dCB1c2UgYSBWTUlELCBzbyBJIHRoaW5rIHRoYXQgdGhpcyB3b24ndCB3b3JrIGNvcnJlY3RseS4N
Cg0KRG8geW91IGhhdmUgdGhlIGpvYiBhdmFpbGFibGUgYXMgd2VsbD8gVGhhdCB3b3VsZCBwcm9i
YWJseSBiZSBiZXR0ZXIgdG8gdGVzdCBmb3Igc2luY2Ugb25seSBJQiB0ZXN0cyBkb24ndCB1c2Ug
YSBqb2IuDQoNCkNocmlzdGlhbi4NCg0KPiAgIAkJCWdmeF92OF8wX3JpbmdfZW1pdF9kZV9tZXRh
KHJpbmcpOw0KPiAgIAl9DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMNCj4gaW5kZXggMDE1NjQ3OS4uZDhkMjU2ZTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiBAQCAtNDk4NSw3ICs0OTg1LDcgQEAgc3RhdGljIHZvaWQg
Z2Z4X3Y5XzBfcmluZ19lbWl0X2liX2dmeChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsDQo+ICAg
CWlmIChhbWRncHVfc3Jpb3ZfdmYocmluZy0+YWRldikgJiYgKGliLT5mbGFncyAmIEFNREdQVV9J
Ql9GTEFHX1BSRUVNUFQpKSB7DQo+ICAgCQljb250cm9sIHw9IElORElSRUNUX0JVRkZFUl9QUkVf
RU5CKDEpOw0KPiAgIA0KPiAtCQlpZiAoIShpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19DRSkp
DQo+ICsJCWlmICghKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKSAmJiB2bWlkKQ0KPiAg
IAkJCWdmeF92OV8wX3JpbmdfZW1pdF9kZV9tZXRhKHJpbmcpOw0KPiAgIAl9DQo+ICAgDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
