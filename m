Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D3C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD4D2158A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD4D2158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59E16E5E7;
	Thu, 28 Nov 2019 02:23:33 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800082.outbound.protection.outlook.com [40.107.80.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8FC6E5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 02:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhT41osxiJNFl2//a90pa0m6R+6h6NEVAkMeOEexIpfYT/SnmYAhQGxiCfJixMmQyxIriDb831t+ruYnmcPCJ25ar9DKa4tfAkkWuNbxAiZ9jovD6+EUxz8psVXcco0iklnPM723Ir0VdcjRyirvHs8T14q4XR/edU/6/nUK3Ut0td5wBN6fhY/so597xp4YJUHfLyutNExskdKF4GG4j+mF9ZMXIkGrrqd+FF6EhnhbuYOG2wXK1ggq9hlMod39BG/026VvVoqciSwL6bsHtocHtrdc3Stb6hk91Ryisibj4QnhKqdboPIW2Usvkx9p3LHSIwz2NGQ+FJlnYVTD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gwplGTBujIQ1KWMGFwqX2Ju5U6JfVl/OoXE0TEGu5w=;
 b=Oc8Y4hdwKOqXOp/TwKMtkg4btw5zuBFp3JQzdboQnTwLK19e7Kv0e/eRzNyZ7MeQi1mHaf+Z+r3QDGtPWdbKy0IQxAJgspv6Irh+RSlgBidAfZg33zzX2ZOXtzqQdPD0gTOuYqj5WuHaCp0szyFSl34naIz/sW567gmqsXICcfDos6l7YfB7gB0f4Ra14lQWguBftdguW4PHevpMOSTqDDFVXfT8CUfiYTwfB+E1cmG+hXUBY/L7vjkIB/5xfobxXtVK5jIC3uZHzuxSO9l0onv1nms/z45UXq/wTK5+smlJBiR7zB66+RIKDC0fZIjfOrDBmJA8C6u6xNiLPmwKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 02:23:31 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 02:23:30 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
Thread-Topic: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
Thread-Index: AQHVpE+7WWAKa/OFpEW63kBQw2nn6qedXwwAgAJ9npA=
Date: Thu, 28 Nov 2019 02:23:30 +0000
Message-ID:
 <MN2PR12MB39334CE435B70273914CF4B284470@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
 <74af5d01-6d42-113e-9e74-4e481bb6bf2d@gmail.com>
In-Reply-To: <74af5d01-6d42-113e-9e74-4e481bb6bf2d@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c234c7b-3967-4f40-8541-08d773a9f5fa
x-ms-traffictypediagnostic: MN2PR12MB4256:|MN2PR12MB4256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4256E5390CE40225DAC0517184470@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(13464003)(6506007)(11346002)(229853002)(6436002)(66066001)(53546011)(9686003)(5660300002)(55016002)(110136005)(6246003)(99286004)(446003)(316002)(86362001)(66574012)(26005)(52536014)(2501003)(186003)(14454004)(33656002)(2906002)(256004)(76116006)(3846002)(6116002)(478600001)(71200400001)(71190400001)(25786009)(66946007)(64756008)(66476007)(66556008)(66446008)(81166006)(8936002)(81156014)(8676002)(14444005)(102836004)(74316002)(7696005)(76176011)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmqjnnLTkUVFESJr9rSzxlzB9jn5Qgy8tmcKlEfyiCJeXNgoD5zxMGDdCZIHX00NgzTryHU7sarIcOi6EpYU31eSmv4YcwzkxDWpxy8IeskUxLEWyI7MMcfyIDltqSiJHxNOt5JQrUm0ViT90K8UZc76bx2T7UuDwT98If6O/FScj7Gzej8PGOTZ1wkFS/P1oeT4wMhdw7guLuV/h/ETWH2HE6/a1k7sMpUCM8bp1qfkkri/sGsJK3Wk9VP91nJ3tMdHM/sbssj1qSZ1gOqiM1BppnDwce754sb9biN4pb8h3XshZItOwyiqYRTIAFNt6dy7IM8JTgGOI4OpkZUv6d0nGG3Q26UjkMETxA5mbeIJ5ZtVhVHkxWAoIJ8npx0+g0YQTzKs1mTBxRQjUsJbWS16op/d6iMDLuaZ1tb8M3a6BF25KK8L8vSueh0ykmES
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c234c7b-3967-4f40-8541-08d773a9f5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 02:23:30.5190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HLx39Cb9xVAtoBCx2jvV481iHEri+2T89J7HNHey3YW8wywaRWlXc57yqFJtk8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gwplGTBujIQ1KWMGFwqX2Ju5U6JfVl/OoXE0TEGu5w=;
 b=OEEf4qz50ZlTpMns/GJTRuL/80ynRM81STGucYPQ05qmNMuvlJDqNJ3K6jLlaWYRZQGacQl/MPkFKHz48fECLlqfv+1VgcVKl+Vj5mJvCtyZaZVTcOuKGITDXGtG6buEUkKhGD0+7OIwtteBVyRUrtl0yNkl/PLwXZOGAfa2Dwg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Message-ID: <20191128022330.ZqWDj3UJZLWY44B6GGIAromdXqrsY_ft1BGJiMe8bDU@z>

Q2hyaXN0aWFuIA0KDQo+PiBHb29kIGNhdGNoLCBidXQgeW91IGFyZSBzb21laG93IG1lc3Npbmcg
dXAgdGhlIGluZGVudGF0aW9uIGhlcmUuDQpJIGNhbm5vdCBhbGlnbiB3aXRoIHRoZSBpbmRlbnRh
dGlvbiwgYmVjYXVzZSBteSBjb2Rpbmcgc3R5bGUgY2hlY2sgc2NyaXB0ICh3ZSB1c2UgaXQgdG8g
cHVzaCBjb2RlIHRvIGdlcnJpdGdpdCkgcmVxdWlyZXMgbWUgdG8gdXNlICJ0YWIiIGluc3RlYWQg
b2YgInNwYWNlIg0KSXQgbWVhbnMgdGhlIGN1cnJlbnQgY29kaW5nIHN0eWxlIGlzIGluIGZhY3Qg
d3JvbmcgLi4uLiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk1vbmsg
TGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBn
bWFpbC5jb20+IA0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjYsIDIwMTkgODoyMCBQTQ0KVG86
IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTogdXNlIENQVSB0byBmbHVz
aCB2bWh1YiBpZiBzY2hlZCBzdG9wcGVkDQoNCkFtIDI2LjExLjE5IHVtIDEyOjUwIHNjaHJpZWIg
TW9uayBMaXU6DQo+IG90aGVyd3NlIHRoZSBmbHVzaF9ncHVfdGxiIHdpbGwgaGFuZyBpZiB3ZSB1
bmxvYWQgdGhlIEtNRCBiZWN1YXNlIHRoZSANCj4gc2NoZWR1bGVycyBhbHJlYWR5IHN0b3BwZWQN
Cj4NCj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgMyArKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyANCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiBpbmRleCAzMjFmOGE5Li40YmI0
ZDI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiBAQCAt
MzI2LDcgKzMyNiw4IEBAIHN0YXRpYyB2b2lkIGdtY192MTBfMF9mbHVzaF9ncHVfdGxiKHN0cnVj
dCANCj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwNCj4gICANCj4gICAJaWYg
KCFhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19lbmFibGVkIHx8DQo+ICAgCSAgICAhYWRldi0+aWJf
cG9vbF9yZWFkeSB8fA0KPiAtCSAgICBhZGV2LT5pbl9ncHVfcmVzZXQpIHsNCj4gKwkgICAgYWRl
di0+aW5fZ3B1X3Jlc2V0IHx8DQo+ICsJCXJpbmctPnNjaGVkLnJlYWR5ID09IGZhbHNlKSB7DQoN
Ckdvb2QgY2F0Y2gsIGJ1dCB5b3UgYXJlIHNvbWVob3cgbWVzc2luZyB1cCB0aGUgaW5kZW50YXRp
b24gaGVyZS4NCg0KV2l0aCB0aGF0IGZpeGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQo+ICAgCQlnbWNfdjEw
XzBfZmx1c2hfdm1faHViKGFkZXYsIHZtaWQsIEFNREdQVV9HRlhIVUJfMCwgMCk7DQo+ICAgCQlt
dXRleF91bmxvY2soJmFkZXYtPm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsNCj4gICAJCXJldHVybjsN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
