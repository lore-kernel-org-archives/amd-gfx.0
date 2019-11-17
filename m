Return-Path: <SRS0=bvuQ=ZJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC013C432C0
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Nov 2019 01:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A2D20730
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Nov 2019 01:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A2D20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F45C6E126;
	Sun, 17 Nov 2019 01:48:03 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820040.outbound.protection.outlook.com [40.107.82.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730AE6E1BD
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Nov 2019 01:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCUlm++cJ9O0ccauBwS2euDhAsIJDrCwRRmfpElq199iGRC5D2QKGEb5aeEG1YdX6mJBDn44RIx9YDQlQd8iju6Uiqlqk73rZ4GfmW4j0accpoXPX15ZuuqBY+zCLd+IpqkfwNkcrlnVpsL+qyS8b4mqhyomS50ahAhSdr4IKAk1Zo4LhXUSqc/nw4HCieFzFhLUDunv5K5xdqPanedoHwub4LBpuBk3qGev52qJZvsgV0dwgJgX0xaviWw9Xy0Zy8dva/zyzlXlSDs1lMSfIFyfCVM6orOFiXt0CzbeOSCiSYB8/xFAQe7H+C62sCHuhxk4wR4Y6mjX6YIInP9HzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mnvWGfrVXZglMUwe8nSbux4A2tBx7rrS7G/lgYWEVE=;
 b=dgGf4auwfw4lMotKc53SwBAfd77nEccgyLN9KWaYaMi0v19Liu/c8UPJ2HRpiotb2XGLKexy4mwHlySm1WfygAOkYvMpqHudyXjuQX+JKMIyb9if213mlP6AQoyTr6VDfKvHOvuKS0rW/wD7qpSVd6wWrvj6UJx04ikXD5m1mYbP+QpmFysU3GWow9EMSKcB0Q8XQXbjhLWWg0ggmHM2odW/boIwMc2SrZlaOFQPlDi9cqyfByrB0isz0VpZbUHefpZvmXhVwlZJdYrhnI64WAdYklpJknDTpFZYOQ7zJRacRVKdDybQTQBmha4qddH0y6i890PsFAz8SO5GB5K08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB4090.namprd12.prod.outlook.com (10.141.185.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Sun, 17 Nov 2019 01:47:59 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::4831:3ea2:2d94:66d3]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::4831:3ea2:2d94:66d3%7]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 01:47:59 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Babutzka, Martin" <martin.babutzka@online.de>
Subject: RE: Rebasing of amd-staging-drm-next
Thread-Topic: Rebasing of amd-staging-drm-next
Thread-Index: AQHVnJpuZgn9J85FXUu8e+ixBvMh3KeN/IGAgACYkeA=
Date: Sun, 17 Nov 2019 01:47:59 +0000
Message-ID:
 <DM6PR12MB3466C76C7D76E7F2587176E49E720@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <54001452.28591.1573888462309@localhost>
 <CADnq5_O-5qW6o=96iJoBf=0ZjJWA+RjcYiuRuLfWXpsG=m_JpQ@mail.gmail.com>
In-Reply-To: <CADnq5_O-5qW6o=96iJoBf=0ZjJWA+RjcYiuRuLfWXpsG=m_JpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 675816e2-a91b-41f7-b27e-08d76b002d18
x-ms-traffictypediagnostic: DM6PR12MB4090:
x-microsoft-antispam-prvs: <DM6PR12MB4090D4AA33EA7FC5A2AD6E969E720@DM6PR12MB4090.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(13464003)(54906003)(8936002)(86362001)(26005)(102836004)(305945005)(7736002)(186003)(53546011)(6506007)(66066001)(6116002)(2906002)(3846002)(476003)(71200400001)(71190400001)(76176011)(7696005)(446003)(486006)(11346002)(229853002)(9686003)(6436002)(6306002)(256004)(55016002)(52536014)(316002)(33656002)(64756008)(478600001)(6916009)(74316002)(66476007)(66946007)(14454004)(66446008)(66556008)(81166006)(76116006)(81156014)(5660300002)(8676002)(6246003)(25786009)(99286004)(966005)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4090;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VR20gHFLZAHWHIj21VBrMjXYuo/9xAcW36PKHctqKO6LJ7eUGVHZZpIQdqlXTvR8Qr5qwVucGAPsdvltEkBxIXBcRBdR19WqxBXbmhcLPhHP8fCTijAlip51t/QQmqk0PcgmDD0ZXZJFhA2MTlMV9qr1vCX5BqQ3rW6PMbpI4r+nMvx4l+Uha91C6KrlzhPl1jHu8PeWS4ljxgxODn507AeUFQH8/Rf2hx8bzZwRbS9U17dpum6r9qWSKGsFmA4wTLTQAqYXSmVikSlyfRoFL+2oPT6Cc9NOGaBQuJyJxgq/eN7okBzsWgtay3oKgkgWXuugsomFTwsAr9wzqR4o0k5+VUFpR0eMY+smt49fhUsjH+iEFz7n2xw5bM3R0zSpjkaeLpeflZNfpHH40I5aByEZh/3uqVeg42xZmIFvNKer3m5EdSXjcTsNVHdwqL2s
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675816e2-a91b-41f7-b27e-08d76b002d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 01:47:59.4911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YN9F91drAKrH4EbxvihTmMLc9h4b1ZkO7dxjSBA+uRe0BSWNVx976mghpLQXhT2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mnvWGfrVXZglMUwe8nSbux4A2tBx7rrS7G/lgYWEVE=;
 b=wsznQzlFrnegMd4ECFIqrB1VsydtOmtrZSVuIcMJjYrpMKcpgwmMzvGanignyHJFsL66LfwVLVvhkiebzaiucWj1seJ237zexLZq3uzhuermDoqbVykFIT60yFlEJx4hvILTkxDh8XwbmmyZHEJi4Mp5OWY/jiCb8hE4cTdCSXY=
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191117014759.6l4ZyT8fBnLmv2l_0OIzubukoRZ0hVGpMq4rc4qG6XA@z>

SGkgTWFydGluLA0KDQpQcm9iYWJseSB5b3UgYXJlIG1pc3NpbmcgYSBidWlsZGluZyBwYWNrYWdl
LiBZb3UgY2FuIGdpdmUgaXQgYW5vdGhlciB0cnkgYWZ0ZXIgaW5zdGFsbGluZyB0aGUgZm9sbG93
aW5nIHRvb2xzOg0KCXN1ZG8gYXB0IGluc3RhbGwga2VybmVsLXBhY2thZ2UgbGlibmN1cnNlczUt
ZGV2IHBrZy1jb25maWcgbGlic3NsLWRldiBsaWJlbGYtZGV2IGJ1aWxkLWVzc2VudGlhbCBiaXNv
biBmbGV4DQoNCkNvdWxkIHlvdSBhbHNvIGVsYWJvcmF0ZSBtb3JlIG9uIHdoYXQgYnVpbGRpbmcg
ZXJyb3JzIGRpZCB5b3UgZW5jb3VudGVyLCBhbmQgd2hpY2ggYnJhbmNoIChhbmQgd2hpY2ggbGF0
ZXN0IGNvbW1pdCkgd2VyZSB5b3UgdXNpbmc/IE1heSBiZSBJIGNhbiBoZWxwIHlvdSB3aXRoIGl0
Lg0KDQpUaGFua3MsDQpaaGFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiAyMDE5L05vdmVtYmVyLzE2LCBTYXR1cmRh
eSAxMToyOCBBTQ0KPiBUbzogQmFidXR6a2EsIE1hcnRpbiA8bWFydGluLmJhYnV0emthQG9ubGlu
ZS5kZT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBSZWJhc2luZyBvZiBhbWQtc3RhZ2luZy1kcm0tbmV4dA0KPiANCj4g
SXQgcm91Z2hseSBmb2xsb3dzIGRybS1uZXh0LiAgSWYgeW91IHdhbnQgc29tZXRoaW5nIG1vcmUg
dXAgdG8gZGF0ZSwgeW91IGNhbg0KPiB1c2UgbXkgZHJtLW5leHQgYnJhbmNoOg0KPiBodHRwczov
L2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC9sb2cvP2g9ZHJtLW5leHQNCj4gDQo+
IEFsZXgNCj4gDQo+IE9uIFNhdCwgTm92IDE2LCAyMDE5IGF0IDExOjI1IEFNIEJhYnV0emthLCBN
YXJ0aW4NCj4gPG1hcnRpbi5iYWJ1dHprYUBvbmxpbmUuZGU+IHdyb3RlOg0KPiA+DQo+ID4gRGVh
ciBBTUQgZGV2ZWxvcGVycywNCj4gPg0KPiA+IEFyZSB0aGVyZSBwbGFucyB0byByZWJhc2UgdGhl
IHN0YWdpbmcga2VubmVsIHRvIDUuND8gV291bGQgYmUgZ3JlYXQNCj4gYmVjYXVzZSA1LjMgZG9l
cyBub3QgYnVpbGRzIHByb3Blcmx5IGZvciBtZS4NCj4gPg0KPiA+IE1hbnkgcmVnYXJkcywNCj4g
PiBNYXJ0aW4NCj4gPg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiA+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
