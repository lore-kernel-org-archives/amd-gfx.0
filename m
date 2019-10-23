Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D17CCA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD9220640
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD9220640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF176EA8A;
	Wed, 23 Oct 2019 12:49:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D526EA8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 12:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5VKGnRjuB6teCO42r64BqBtzM4coagEy6oCauKDGKxsesmnlH7w2w5lDTGONkTlv4mbA2Xda47WSxTHLiNm4Iz5XwnUbU1xoS0SUYHVbPYBXXeM7vRySriXz73w0iYL1tTAcZdSax7h0ovcbohEVvmovwsgyzrWRtxf4DiXuyL//CB7fY2GRQGCi8Uimo5TpRKSijUDikwXL0Z12fdFS1F/7FjunmiATAw0VYKSmKaHpNhfgcgi6LYRUUNpIDwZdW+05o09yVcD8kC8VhFaAeael9LRSlbVZ5wnwSjC545OJWvKwTOQzzKFjO++hbL1XjSX3BnTg5bi+8KbTjkKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzWGJsJeogd8qYLJLSZJ9DA4hZKLk9Hlp1T5B1+EmwU=;
 b=Qsz8aEAMITXTY3DcjvN+bRpAoblFYUxroTgkGTxf8ZJ17F7ogPgEzQk/9KlIgUZ25OAHE+byqvUgHpvmjCzecEMJ7u3tAYs9JpBs/2wlf+kViragmWubNEtflUvEihChxojLQCEiCHhLaU2N3UDiYYXWWV+skMIb1fVnxVBahXd3JGGDfO4AwpSztRJgul2730Db636D024SdIBI8BeL4tGhEYSBS3GeyMPc/AhRFaC4lZQ5s860KaksfPSqsEndBuH9ab4Mitdqo9QkruC7fLknr1zRIxAyjgW7FbtbvLNDZ9Myjwu7W6CvJFFY10VywJsmihCDYOq6laORU2HPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1649.namprd12.prod.outlook.com (10.172.18.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 12:49:40 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::f16d:2fda:9e18:a554]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::f16d:2fda:9e18:a554%12]) with mapi id 15.20.2347.029; Wed, 23 Oct
 2019 12:49:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix SDMA hang when performing VKexample test
Thread-Topic: [PATCH] drm/amdgpu: Fix SDMA hang when performing VKexample test
Thread-Index: AQHViW5UTkwQEGoji0azQRIh9ii4TqdoLbKw
Date: Wed, 23 Oct 2019 12:49:39 +0000
Message-ID:
 <BN6PR12MB1809075B6F21ED6C68BEDBEFF76B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1571813487-31589-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1571813487-31589-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0daf9d7a-a69c-4226-da59-08d757b777e1
x-ms-traffictypediagnostic: BN6PR12MB1649:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB16496B978752148A20D0CD6DF76B0@BN6PR12MB1649.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(13464003)(6506007)(76176011)(7696005)(53546011)(8936002)(8676002)(81166006)(71190400001)(4326008)(14454004)(478600001)(99286004)(26005)(9686003)(6246003)(81156014)(316002)(71200400001)(102836004)(110136005)(966005)(74316002)(76116006)(66946007)(64756008)(66476007)(186003)(66446008)(305945005)(55016002)(52536014)(7736002)(11346002)(446003)(256004)(486006)(66556008)(6116002)(3846002)(5660300002)(66066001)(33656002)(229853002)(2906002)(6436002)(86362001)(2501003)(476003)(6306002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1649;
 H:BN6PR12MB1809.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXfouku1awaH5l5TrNkVvfR163zYWEziF94LuOOrnunszks8N55+1ytRoWBMMld9PgwQewNYvt1+U2/F5tAwVtj3IIZ8ULMbz57j71i/w7Cg1ynjKypryq0RLXslZDFcsbS2y5lwQAy9Eckq57y5PUKlBZy/MgWWEtb5GY2MYEcoE+Ojh5oaRDGFgiDhuFJ6ihejlsOBLtans+v/KDg2H/+1BsnkFbD6ZbXUj1Ql62whG3zojUtVUXcKbwoE1bwXsM3zAHLeQV2PcwEcNdPrOvWl+9AYv3l/C5AcsPLEsXRJ0ZhyYYIGpTWsYIMOygEdBIwKUUqZX2hOrVh02WmgkIFtjRZFcgpVyJbH8225g0Oq4UdeH01oUFSGxxi09gW2MKAX6Cr7jz4+2bJq36axZaY5IoCjrI51gB37XLBzirjB0rgGw8tmpxy2V/nxKZ9R6gPnkj+SPFJ179S5QWsojbttx+F8jsPa7T9ksujK4Qo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daf9d7a-a69c-4226-da59-08d757b777e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 12:49:39.6597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFBJjdm8FcsAsnvxilWMNThq4FgoVa+Srr+MOxAyt/Wiwh9vrfZse0x7Np7jQtkeIDBCJQAfrsvp/cDjWzPQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1649
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzWGJsJeogd8qYLJLSZJ9DA4hZKLk9Hlp1T5B1+EmwU=;
 b=p0MqoFibq+O5ob4VwTxCB1ekk5S3Kea/BabVwP/x4ARvbOE6rc9fNgv5VU5LfF3RkZcOmpsfyrvgYXtegldasjEKXRC1jTbJihcQsPcxVS2sSXUfuG8YGqJNjhpUsGQ+reqD+snSDUi9i2HAhdWoAcJZG/h/Elc6ZRDgRFOwIsI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023124939.-rDcDp2MUuK5CnezMJvTH48IBJiSxxhlK9gl0sEONc0@z>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gY2hlbiBnb25nDQo+
IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMywgMjAxOSAyOjUxIEFNDQo+IFRvOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogR29uZywgQ3VycnkgPEN1cnJ5LkdvbmdAYW1k
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggU0RNQSBoYW5nIHdoZW4g
cGVyZm9ybWluZyBWS2V4YW1wbGUNCj4gdGVzdA0KPiANCj4gVktleGFtcGxlIHRlc3QgaGFuZyBk
dXJpbmcgT2NjbHVzaW9uL1NETUEvVmFyaWEgcnVucy4NCj4gQ2xlYXIgWE5BQ0tfV0FURVJNSyBp
biByZWcgU0RNQTBfVVRDTDFfV0FURVJNSyB0byBmaXggdGhpcyBpc3N1ZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IGNoZW4gZ29uZyA8Y3VycnkuZ29uZ0BhbWQuY29tPg0KDQpBY2tlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjRfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92
NF8wLmMNCj4gaW5kZXggNjNhMzc5Mi4uNDViZDUzOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2RtYV92NF8wLmMNCj4gQEAgLTI1NCw2ICsyNTQsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHNvYzE1X3JlZ19nb2xkZW4NCj4gZ29sZGVuX3NldHRpbmdzX3NkbWFfNF8zW10gPSB7
DQo+ICAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShTRE1BMCwgMCwNCj4gbW1TRE1BMF9STEMwX1JC
X1dQVFJfUE9MTF9DTlRMLCAweGZmZmZmZmY3LCAweDAwNDAzMDAwKSwNCj4gIAlTT0MxNV9SRUdf
R09MREVOX1ZBTFVFKFNETUEwLCAwLA0KPiBtbVNETUEwX1JMQzFfUkJfV1BUUl9QT0xMX0NOVEws
IDB4ZmZmZmZmZjcsIDB4MDA0MDMwMDApLA0KPiAgCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoU0RN
QTAsIDAsIG1tU0RNQTBfVVRDTDFfUEFHRSwNCj4gMHgwMDAwMDNmZiwgMHgwMDAwMDNjMCksDQo+
ICsJU09DMTVfUkVHX0dPTERFTl9WQUxVRShTRE1BMCwgMCwNCj4gbW1TRE1BMF9VVENMMV9XQVRF
Uk1LLCAweGZjMDAwMDAwLCAweDAwMDAwMDAwKQ0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgdTMyIHNk
bWFfdjRfMF9nZXRfcmVnX29mZnNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gLS0N
Cj4gMi43LjQNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
