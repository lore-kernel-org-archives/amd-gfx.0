Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68C1CA9EB5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 20:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A8B2084D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 20:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A8B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41929892A9;
	Mon,  4 Nov 2019 20:02:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F95A892A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 20:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu4DZcNqDMHKZYDr+JPknfX74/+qunv2ZzAgt8TL6HONrfjnk5vI2TsOVLulLJfmHhc+eJvOgARVBlu60Hb5JVf+a8K4pAa5O8iYwaVekBGvnJmmc/1iaVND+z140MjYVPy6Uyd/md/VhY02M5yZifCgZ9sRTt55Z8qr/BvJWK+1QT0p4PyAPLPyPr5zkj+8kgL5xYVguhr3pLKuMKH+rSf12ejN3RuwqmqIkzJK9uKS3S6M8qVOnrqhaeMdRNCkgB0L0Bh4H5tZH2Awt+ObRFcujBjdDj8hW1Spq4qwXRONCanjQNuLpWkduP2W47kGQlmWqWhP87mVtBU1N+Aj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlKVws5T1mH6CiM5rWQz4nCrOIu8+Ea0uay4cKcThnM=;
 b=TbseiK6QNW0g263iQJxZCzxmt08yqZT1xgYShrBXV0FyoQiR2mTbgYsR5VgDWoytD6FijpiFWQ1BWcXpfuZ7MsE33psxAcnrNFxk1DSStJPuijrHaQqDy8D4UwbBiiz0offtTnND0dYEx+q1F0WsMEKRYorHcVBjClNwqqwkJmFLP+S8QmPFzXo3FW3kMJTQkPTu93tpVF0NHJM/xjNpQwxWf+H/nD7NLv1mYybtl3ND3M0CRQDgauo/Cn3hs9y8sSw/b3RndkWPg+VtSKDGpH88DtUvxwx397gumZbXumpAwtEs6782PpDx+tOQxXQ1xiTQQXQmMwRLIKPA4O8jAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2982.namprd12.prod.outlook.com (20.178.55.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 20:02:48 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 20:02:47 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wu, Hersen" <hersenxs.wu@amd.com>
Subject: Re: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Topic: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Index: AQHVkymI1xwlEiK2sE2bB6BNavcbhqd7OjOAgAAAKyCAADT0gA==
Date: Mon, 4 Nov 2019 20:02:47 +0000
Message-ID: <c3a4168f-5462-dbf4-aecb-7bfb242677d6@amd.com>
References: <DM6PR12MB3466E5EF19CE8BBD78AC6BBE9E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <9d0a0e07-f68a-8e93-3003-f19ca056b2ff@amd.com>
 <DM6PR12MB34661BBB5BF6989CF63389D19E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB34661BBB5BF6989CF63389D19E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80600448-3c04-44fd-eed0-08d76161f6ba
x-ms-traffictypediagnostic: BYAPR12MB2982:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2982E16A1CF580FEEB24A252EC7F0@BYAPR12MB2982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(13464003)(76176011)(6512007)(6486002)(8676002)(305945005)(7736002)(2906002)(478600001)(316002)(52116002)(6246003)(6306002)(71190400001)(71200400001)(53546011)(6506007)(256004)(186003)(6436002)(26005)(6116002)(3846002)(386003)(229853002)(102836004)(66946007)(66446008)(64756008)(66556008)(66476007)(476003)(81156014)(36756003)(110136005)(81166006)(25786009)(31686004)(5660300002)(31696002)(966005)(86362001)(2501003)(6636002)(14454004)(99286004)(11346002)(446003)(66066001)(2616005)(486006)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2982;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: boEUOZVqHaTo0tSyUDVHYDlH+WgeT9u+9epRr+WJhNMS1dcbV0WXA3wHfVlxnTnsfGcGo5nWnD4v6yximQy+WaY0L0jhE8hSma/LUesWEmFJ5I/rihUaYx5/2fD+P710psySV1JBcWwSHqR04BdkOOG+SsCmz5FWMwlJ0IR0We32ZpLjpavPrjg7Se8pUTLhzAFYI583vBq7v/+GiY9Tau0wn0oUUdErPnQ8awqy9cwj6Xi5Yclt7TX3j8vQwbp/+yKn2kmMunNIKTiI3sV/AyiUGN1RwIF36yyNckaaCs/XRrRn8iIND14U8R+BqpIshOvqMztHiIvt2qDuW0pQQqMygLDtZpHfaN65ezEWEKyshhXprCbACRtR8rPnXQ2vl3y3XJHL2Jt8ufUYHLWPp97kcO3PsFdMra3CYySKcyQmocFW3Dz8mpK9HT28g7JRFma1EKTbgt4Z84XjBrDuMEBy9jQ44xns+2cXOhIFdLg=
Content-ID: <DE70AEA3A5907949964842CBD5230C28@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80600448-3c04-44fd-eed0-08d76161f6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 20:02:47.7921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 855FJEyVM+9VhP34cbnbzfOndTT+zzsVuv8NFUjesSrc8TLoXAHuJDajQBi2VqrGxUPoep4WKwWucLE3NERloQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlKVws5T1mH6CiM5rWQz4nCrOIu8+Ea0uay4cKcThnM=;
 b=ZRn+xOPSdEd+Fkhx1mp8Y2Jhe6S1qd+ef7CtrM4JiaI4RIcl0E8rHjvKskXKW5vkFdGtFXDTXPjq2ph8n4L2P2roUrW4xtDue2VjelZ6ypmQSij1JHdevCpMmWUZDDGjKKEiqIWeNfAilqw9qP2+zBtR89/Mm9v/hqV/CCMRUq8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Message-ID: <20191104200247.dNrBPGI0hv88pIZlmVby1WDKzYqsPak7cohBr5rLitw@z>

T24gMjAxOS0xMS0wNCAyOjQ5IHAubS4sIExpdSwgWmhhbiB3cm90ZToNCj4gVGhhbmsgeW91IE5p
Y2sgZm9yIHRoZSBhZHZpY2UuIEkganVzdCByZXZlcnRlZCB0aGUgb3JpZ2luYWwgY29tbWl0Lg0K
PiANCj4gWmhhbg0KDQpUaGUgcmV2ZXJ0IHN0aWxsIG5lZWRzIGNvZGUgcmV2aWV3Lg0KDQpOaWNo
b2xhcyBLYXpsYXVza2FzDQoNCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4g
RnJvbTogS2F6bGF1c2thcywgTmljaG9sYXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4N
Cj4+IFNlbnQ6IDIwMTkvTm92ZW1iZXIvMDQsIE1vbmRheSAxMTo1MyBBTQ0KPj4gVG86IExpdSwg
WmhhbiA8Wmhhbi5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBX
dSwNCj4+IEhlcnNlbiA8aGVyc2VueHMud3VAYW1kLmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWQvZGlzcGxheTogcmVtb3ZlICJzZXR0aW5nIERJR19NT0RFIHR3aWNlIg0KPj4g
d29ya2Fyb3VuZA0KPj4NCj4+IE9uIDIwMTktMTEtMDQgMTE6MDYgYS5tLiwgTGl1LCBaaGFuIHdy
b3RlOg0KPj4+IFtXaHldDQo+Pj4gVGhlIHJvb3QgY2F1c2Ugb2YgTmF2aTE0IEhETUkgcGluayBz
Y3JlZW4gaXNzdWUgaGFzIGJlZW4gZm91bmQuDQo+Pj4gVGhlcmUgaXMgbm8gbmVlZCB0byBzZXQg
RElHX01PREUgdHdpY2UgYW55bW9yZS4NCj4+Pg0KPj4+IFtIb3ddDQo+Pj4gUmVtb3ZlICJzZXR0
aW5nIERJR19NT0RFIiB0d2ljZSB3b3JrYXJvdW5kLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
WmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5jb20+DQo+Pg0KPj4gUGxlYXNlIHVzZSBnaXQgdG8gcmV2
ZXJ0IHRoZSBjb21taXQgaW5zdGVhZDoNCj4+DQo+PiBlZy4NCj4+DQo+PiBnaXQgcmV2ZXJ0IDxT
SEE+DQo+Pg0KPj4gVGhlbiBhZGQgdGhlIHJlYXNvbmluZyB0byB0aGUgcmV2ZXJ0IGNvbW1pdCBt
ZXNzYWdlLg0KPj4NCj4+IFRoYW5rcywNCj4+DQo+PiBOaWNob2xhcyBLYXpsYXVza2FzDQo+Pg0K
Pj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmsuYyB8IDkgLS0tLS0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDkgZGVsZXRpb25zKC0p
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfbGluay5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
X2xpbmsuYw0KPj4+IGluZGV4IGNjOTRjMWE3M2RhYS4uMTJiYTZmZGY4OWI3IDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPj4+
IEBAIC0zMDI3LDE1ICszMDI3LDYgQEAgdm9pZCBjb3JlX2xpbmtfZW5hYmxlX3N0cmVhbSgNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDT05UUk9MTEVSX0RQ
X1RFU1RfUEFUVEVSTl9WSURFT01PREUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQ09MT1JfREVQVEhfVU5ERUZJTkVEKTsNCj4+Pg0KPj4+IC0gICAgICAg
ICAgICAgICAvKiBUaGlzIHNlY29uZCBjYWxsIGlzIG5lZWRlZCB0byByZWNvbmZpZ3VyZSB0aGUg
RElHDQo+Pj4gLSAgICAgICAgICAgICAgICAqIGFzIGEgd29ya2Fyb3VuZCBmb3IgdGhlIGluY29y
cmVjdCB2YWx1ZSBiZWluZyBhcHBsaWVkDQo+Pj4gLSAgICAgICAgICAgICAgICAqIGZyb20gdHJh
bnNtaXR0ZXIgY29udHJvbC4NCj4+PiAtICAgICAgICAgICAgICAgICovDQo+Pj4gLSAgICAgICAg
ICAgICAgIGlmICghZGNfaXNfdmlydHVhbF9zaWduYWwocGlwZV9jdHgtPnN0cmVhbS0+c2lnbmFs
KSkNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBzdHJlYW0tPmxpbmstPmxpbmtfZW5jLT5m
dW5jcy0+c2V0dXAoDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJlYW0t
PmxpbmstPmxpbmtfZW5jLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlw
ZV9jdHgtPnN0cmVhbS0+c2lnbmFsKTsNCj4+PiAtDQo+Pj4gICAgI2lmZGVmIENPTkZJR19EUk1f
QU1EX0RDX0RTQ19TVVBQT1JUDQo+Pj4gICAgICAgICAgICAgICAgICAgaWYgKHBpcGVfY3R4LT5z
dHJlYW0tPnRpbWluZy5mbGFncy5EU0MpIHsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChkY19pc19kcF9zaWduYWwocGlwZV9jdHgtPnN0cmVhbS0+c2lnbmFsKSB8fA0KPj4+IC0t
DQo+Pj4gMi4yMS4wDQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4DQo+Pj4NCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
