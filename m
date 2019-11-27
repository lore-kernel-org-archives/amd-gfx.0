Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E66C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 21:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3A120665
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 21:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3A120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118E36E5BB;
	Wed, 27 Nov 2019 21:58:09 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800052.outbound.protection.outlook.com [40.107.80.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EA46E5BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 21:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz4aEAq6uOjBvq9HXJZPnSroZIOiKB2tHBsZllNGMGCK1TzYAbr+mhpWdoea+HkTW+BNxoMfadWv8/dqkVnDnH0ercxYQ4SvnZgpkjEolZZXOXzNRBk1y21bzobDEZC2O0l7k8ewry5016wWj2afbqjt1z8VelKbxUfs4NU4jsK4JDmwV2VttNwgebbHrO5Z7WIGvb12FunIVKTAeFKFpBZi6PO0ZmW4OfyhC2p0cVE69J8Ffvq+WY/zTeRH8ORpdHet9pDClKl8jOvIan+ZgsIVgOxBa/IVkkEOPNsBrswxtNB135nZmDL3q1G3g6o1KIcvvj7qEQ2QNv3bNr5cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogs0jrwUwkei65r4e1GMJ22yBw98BDy+vS0GsO06wl0=;
 b=jWW7LuScbQAmPDutG4XZrTnPITaIUpxSjf1yRUIgIiGx6gLdpfApqVY2RVuANHMBtLjQZwlnK9I3u0mZc/U0CbfTWnRmFHHbQqL+2COV2sxJTuJuBfg9/dvAtxE5sEqVTOxsARnBGJ0Y288MoxgjJjCgFsv7l/OQJGRhVh/huFTHIqAyXxmevS/ykjQgNYut5Cu/tyjiwfyD+2pmqCgS5eYAeQB4Fp7QwyachoUIQP/Wtcvib930JAlkgkQURYVFCz/R90l+LC4rqBgs+aydgugYb9G74+00oVt6l3/2Je/QsFpGLrdP5ZEhWspIIR6+kh91mLy6njYFq3lfB0ZaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3563.namprd12.prod.outlook.com (20.178.30.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 27 Nov 2019 21:58:06 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:58:06 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move CS secure flag next the structs where
 it's used
Thread-Topic: [PATCH] drm/amdgpu: move CS secure flag next the structs where
 it's used
Thread-Index: AQHVpWU66xXQ2Yx5MUeY6FoSnS8vGKefkIiQ
Date: Wed, 27 Nov 2019 21:58:05 +0000
Message-ID:
 <DM6PR12MB3466787C93C6B571A385E75A9E440@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191127205646.953566-1-alexander.deucher@amd.com>
In-Reply-To: <20191127205646.953566-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 383c165d-63f7-4b27-f7d8-08d77384e1fe
x-ms-traffictypediagnostic: DM6PR12MB3563:|DM6PR12MB3563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3563954236C472745C048FF89E440@DM6PR12MB3563.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(189003)(199004)(13464003)(4326008)(2906002)(71200400001)(86362001)(71190400001)(55016002)(6246003)(6116002)(6306002)(9686003)(3846002)(256004)(8676002)(2501003)(25786009)(8936002)(81166006)(81156014)(14454004)(45080400002)(478600001)(966005)(52536014)(305945005)(7736002)(66066001)(74316002)(11346002)(446003)(5660300002)(102836004)(99286004)(33656002)(110136005)(316002)(229853002)(7696005)(76176011)(76116006)(53546011)(66476007)(186003)(66446008)(26005)(66946007)(64756008)(66556008)(6436002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3563;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SGaZIwHMa0piLA00PKF/v118pSntnO6dfGKzzNjlvPQeKhqD0emY6gR3leT4nV3w8DmZ/px/QR1b+WtUQtrDjTYTY0fZs169bIP2Z3qlY8KocB0S75UP0GyYweM1a7EeKpYlwqX0MLOzBki02IwTsyV3y6vrycoZMIsax1saGcxiWTOovZveWAj7ltAfd/zcPLseh4ncpWMHKONjk9/0E+6vt9M/1cJPeYsxOrZud0fEqiH8XWnbnqKFIJJjpsY4NlItKEWbr+9rwoL87g8ncXmsERZGcRiZbrC+I3G1G6PK+OhTBeQ6YPIAmwed7xyAevgLVVV1WvNlGhxeQrLQcOszi3zuCN2O+nklJfMdLzH4W3zWEFxmKgav8v8GJ2IBCxR9RiLDnWujjbMYaPghMcrSnX7jnL1DiV8HDbXQl82cD6tjUrjTD6zHJ81QyJIvEKgNmKFA/6ekQGhuD/fRL9WxH1MlTyTlU0C57V3V/yg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383c165d-63f7-4b27-f7d8-08d77384e1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:58:05.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05CGTBqon8TqwIaMxPa9QTfB+vsaq4K2M8aXD/ETXK3RdhzPblYHvgXytvvtOrJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3563
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogs0jrwUwkei65r4e1GMJ22yBw98BDy+vS0GsO06wl0=;
 b=HMGGPYuDJq1AIl+07U4RgcYXRFRWe6zeVoz0YH2dIfgM005wIJqTlEGP0EqGF7XgwXEf0TR2+5Y7Q8FRcyVI8CcDhzTHCQYcX6Y7i0RD3C2l6QOjXZWljasWIEXpSVREF3sGkSjwRQZzy4EBJ5jUp4p9s50FkojIbhRdYwJT8Rc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127215805.FDn43fLbs930c7TlELBn3Xbm69hhc-djL5BNJ6mtXZ4@z>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1
Y2hlcg0KPiBTZW50OiAyMDE5L05vdmVtYmVyLzI3LCBXZWRuZXNkYXkgMzo1NyBQTQ0KPiBUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1
OiBtb3ZlIENTIHNlY3VyZSBmbGFnIG5leHQgdGhlIHN0cnVjdHMgd2hlcmUgaXQncw0KPiB1c2Vk
DQo+IA0KPiBTbyBpdCdzIG5vdCBtaXhlZCB1cCB3aXRoIHRoZSBDVFggc3R1ZmYuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoN
ClJldmlld2VkLWJ5OiBaaGFuIExpdSA8emhhbi5saXVAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGlu
Y2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9k
cm0uaCBpbmRleCBmNzVjNjk1NzA2NGQuLjkxOGFjMzU0OGNkMw0KPiAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9h
bWRncHVfZHJtLmgNCj4gQEAgLTIwNyw5ICsyMDcsNiBAQCB1bmlvbiBkcm1fYW1kZ3B1X2JvX2xp
c3Qgew0KPiAgI2RlZmluZSBBTURHUFVfQ1RYX09QX1FVRVJZX1NUQVRFCTMNCj4gICNkZWZpbmUg
QU1ER1BVX0NUWF9PUF9RVUVSWV9TVEFURTIJNA0KPiANCj4gLS8qIEZsYWcgdGhlIGNvbW1hbmQg
c3VibWlzc2lvbiBhcyBzZWN1cmUgKi8NCj4gLSNkZWZpbmUgQU1ER1BVX0NTX0ZMQUdTX1NFQ1VS
RSAgICAgICAgICAoMSA8PCAwKQ0KPiAtDQo+ICAvKiBHUFUgcmVzZXQgc3RhdHVzICovDQo+ICAj
ZGVmaW5lIEFNREdQVV9DVFhfTk9fUkVTRVQJCTANCj4gIC8qIHRoaXMgdGhlIGNvbnRleHQgY2F1
c2VkIGl0ICovDQo+IEBAIC01NTksNiArNTU2LDkgQEAgc3RydWN0IGRybV9hbWRncHVfY3NfY2h1
bmsgew0KPiAgCV9fdTY0CQljaHVua19kYXRhOw0KPiAgfTsNCj4gDQo+ICsvKiBGbGFnIHRoZSBj
b21tYW5kIHN1Ym1pc3Npb24gYXMgc2VjdXJlICovDQo+ICsjZGVmaW5lIEFNREdQVV9DU19GTEFH
U19TRUNVUkUgICAgICAgICAgKDEgPDwgMCkNCj4gKw0KPiAgc3RydWN0IGRybV9hbWRncHVfY3Nf
aW4gew0KPiAgCS8qKiBSZW5kZXJpbmcgY29udGV4dCBpZCAqLw0KPiAgCV9fdTMyCQljdHhfaWQ7
DQo+IC0tDQo+IDIuMjMuMA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlDQo+IGVkZXNrdG9wLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N6aGFuLmxp
dSU0MGFtZC5jb20lN0M4YzdiMGVkZGYwYzM0NTQ4NTQwDQo+IGEwOGQ3NzM3YzU3YjIlN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNg0KPiAzNzEwNDg1MDI2NzM0
NTU0NSZhbXA7c2RhdGE9M1EzJTJCTExwaUg3ZWt2REZncDF6bXJwR3d2WFFqMVJEDQo+IDJhS2U2
eWFwNTZVdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
