Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15FCC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 22:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD5420659
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 22:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD5420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2EA6F918;
	Thu,  5 Dec 2019 22:16:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4A76F918
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 22:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arw4W4/XMTKrrkyZSts+V9WvsnU22ip9beI1nd0quRMDH6NnkzBIG/S9IYBkpFZfkVCFM35wRXOmvHAeyVLzlh0RqIvK4mKS0d5cPhisgB74IQWuOA8ZSUpbeDgSlb7Lrd+oTJb7Kh5Q+MbLYavd90hZphiuDQZKTuyTbRko62dzPtEoh22CbrBZYG+ABOIBlsgWpw1pbDPsS4+Tyk0st1+HsrkgJ4rMLmNk2LN1R5hAM7hV86gJF0Yfowo0lz1mRrl1hkGKhKcJplRdInCJ2tNtXBZehX+jAqvUTn/0rZwkPSI7VJBi0A0o06NF7EEOttEj8V7vcK1XDqI90125dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/zdTPKWMxYKLiJODAtA+XZNNr4q9jVPP7WNUdxLSbM=;
 b=dlrmAZsFaK2MtV/3b1+s93tF4v+RDUsJzW27ekoM0jMzZEZ1kt+HRig/AoDs7n5butnzR+oqW3X0FgpPErjriZctkQVKA7ob7es6djEcTZL2VQ3EMJjjojP1I6+7s4tJMb8DrBC7BC5ENlToy3QFQHGRk6FEbDcAsgVjcb4dvdcUvHeU06itRehvMj59DourLIvgPDNWcSGvatUZmOui7T+NtWnXPUmi2v78N72U0Eqdq6diQKsiZLZmcKVrK+ycobEC1HJS/xYVag+v0BAzWGhXDHUvGwVCtMvkWJpfdOStK1g14jDm1UThT5JPjt13xeDv4DiYwyxeN8tXtbLgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3834.namprd12.prod.outlook.com (10.255.76.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 22:16:12 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 22:16:12 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/display: add fallthrough comment
Thread-Topic: [PATCH] drm/amdgpu/display: add fallthrough comment
Thread-Index: AQHVq7SYFVeUqb3bUEqWQOVaRjBN26esGcQggAABAYCAAAA9gA==
Date: Thu, 5 Dec 2019 22:16:11 +0000
Message-ID: <DM6PR12MB3466E0D8A51B36AAA10202479E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191205213904.278244-1-alexander.deucher@amd.com>
 <DM6PR12MB3466EA1AD3EB09CE509900B19E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <CADnq5_Nqy+thHD-9jirZD9h=J+gE9_NnTwrzD3K-ZkvVJ0UHgQ@mail.gmail.com>
In-Reply-To: <CADnq5_Nqy+thHD-9jirZD9h=J+gE9_NnTwrzD3K-ZkvVJ0UHgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 189671cc-3033-4dc8-230d-08d779d0bc95
x-ms-traffictypediagnostic: DM6PR12MB3834:|DM6PR12MB3834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3834A51BCD93873947142FC99E5C0@DM6PR12MB3834.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:219;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(13464003)(199004)(189003)(478600001)(5660300002)(14454004)(966005)(52536014)(2906002)(45080400002)(6916009)(66946007)(66476007)(66446008)(66556008)(64756008)(71190400001)(229853002)(102836004)(71200400001)(81156014)(55016002)(81166006)(11346002)(76116006)(26005)(6506007)(8936002)(8676002)(76176011)(86362001)(7696005)(54906003)(4326008)(74316002)(316002)(186003)(53546011)(33656002)(25786009)(99286004)(9686003)(305945005)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3834;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzNYmwFbWxRKOd6zvqnOUwRj7ggA8iXabRzk2euq75noCN74Nn8sPqnYE/F/R3sqSsQAdUJnDcWWXEHHBiEfXHvBsNH+yszKTeKPtekbDhrFGiyMB6iB2uyLo/B7nItvjl2l8pOoQ2u9/k/nZRfolUnoZ7LeEN2ByatztS9sy4MI3R/MXoEfccQi0WYLvVE6rPSaMQC2/dtaYrH2iWWyBudgmtr/vK0IxuMWieFh0pIptW8P3EIET+GX/taf72IBq+bxiTDXdw9oRVA/MLuIR71n1JFiO0i/J56QWT6RC+Myn+hLLSm2nVEl87NUrwdtrz72kZ1WfnkZeV+FDKOJQ/zwM4/9RJkJ5R/6Ihy1cLWiYOAOMJqBhobYa8fENxxdshADcQa+Vq6uzOrQ6iw9cAGwmeZSNmcG1XXGpbo0TK4G1N93gF6Z1/zPkAG4JRCP8INq/kURuJuLIXxMEF3pv/F5b8pY4+V7KFJtopHAuRBx9B8VCvw2w2f6vw84ZgG2
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189671cc-3033-4dc8-230d-08d779d0bc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 22:16:11.9443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVaYYxCbQkmMr3CB+QG0obG6YeHW29pAFGdX9ukd/03kMh3v/IlsZ7q0lueOxY21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/zdTPKWMxYKLiJODAtA+XZNNr4q9jVPP7WNUdxLSbM=;
 b=eKc7qb2BfPdCZoWmyNa3cHmzUd2PW1oOlCwe3TorY6KrUUJgAX0iCYmV3ZiLwvioMMRLS+tp7rY99Ufjq1brSEADegMVQ8WA7h2KR/ym0YRJ6+0tfqJ96GaCHbC+9a0tiVUaTXgo/U5NkPoBa3vRHeR2waFeqzNmRfen9aOn/iI=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMTkvRGVjZW1iZXIvMDUsIFRodXJzZGF5
IDU6MTMgUE0NCj4gVG86IExpdSwgWmhhbiA8Wmhhbi5MaXVAYW1kLmNvbT4NCj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvZGlz
cGxheTogYWRkIGZhbGx0aHJvdWdoIGNvbW1lbnQNCj4gDQo+IE9uIFRodSwgRGVjIDUsIDIwMTkg
YXQgNToxMCBQTSBMaXUsIFpoYW4gPFpoYW4uTGl1QGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0K
PiA+ID4gQWxleCBEZXVjaGVyDQo+ID4gPiBTZW50OiAyMDE5L0RlY2VtYmVyLzA1LCBUaHVyc2Rh
eSA0OjM5IFBNDQo+ID4gPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4g
PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvZGlzcGxheTogYWRkIGZhbGx0aHJvdWdoIGNv
bW1lbnQNCj4gPiA+DQo+ID4gPiBUbyBhdm9pZCBhIGNvbXBpbGVyIHdhcm5pbmcuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfYXV4LmMgfCAxICsNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjZS9kY2VfYXV4LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfYXV4LmMNCj4gPiA+IGluZGV4IDE5MWI2OGI4MTYzYS4uZjFhNWQyYzZhYTM3IDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1
eC5jDQo+ID4gPiBAQCAtNjQ1LDYgKzY0NSw3IEBAIGJvb2wgZGNlX2F1eF90cmFuc2Zlcl93aXRo
X3JldHJpZXMoc3RydWN0DQo+ID4gPiBkZGNfc2VydmljZSAqZGRjLA0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGNhc2UgQVVYX1RSQU5TQUNUSU9OX1JFUExZX0FVWF9ERUZFUjoNCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICBjYXNlDQo+ID4gPiBBVVhfVFJBTlNBQ1RJT05fUkVQTFlf
STJDX09WRVJfQVVYX0RFRkVSOg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0cnlfb25fZGVmZXIgPSB0cnVlOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyogZmFsbCB0aHJvdWdoICovDQo+ID4NCj4gPiBJIGFtIGEgYml0IGNvbmZ1c2luZyBoZXJl
LiBXaHkgYSBjb21tZW50IGNhbiBhdm9pZCBhIGNvbXBpbGVyIHdhcm5pbmc/DQo+IA0KPiBUaGUg
a2VybmVsIGVuYWJsZXMgZmFsbCB0aHJvdWdoIHdhcm5pbmdzLCBzbyB1bmxlc3MgdGhlcmUgaXMg
YSBjb21tZW50DQo+IG1lbnRpb25pbmcgdGhhdCBhcmUgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRo
cm91Z2ggaGVyZSwgd2UgZ2V0IGEgd2FybmluZy4NCj4gVGhlIGlkZWEgaXMgdG8gZmluZCBtaXNz
aW5nIGJyZWFrcyBpbiBzd2l0Y2ggY29kZS4NCj4gDQo+IEFsZXgNCg0KR290IHlvdS4gVGhhbmsg
eW91IGZvciB5b3VyIGV4cGxhbmF0aW9uLg0KDQpSZXZpZXdlZC1ieTogWmhhbiBMaXUgPHpoYW4u
bGl1QGFtZC5jb20+DQoNCj4gDQo+ID4NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBjYXNl
DQo+ID4gPiBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfSTJDX09WRVJfQVVYX05BQ0s6DQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoKythdXhfZGVmZXJfcmV0cmllcyA+PQ0K
PiA+ID4gQVVYX01BWF9ERUZFUl9SRVRSSUVTKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4gPiA+IC0tDQo+ID4gPiAyLjIzLjANCj4g
PiA+DQo+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiA+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+ID4gPg0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy4NCj4gPiA+IGZyZWVkZXNrdG9wLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gPiA+DQo+IGdmeCZhbXA7ZGF0YT0wMiU3
QzAxJTdDemhhbi5saXUlNDBhbWQuY29tJTdDNzdkODVhMDI3NWFhNGMwYTc4DQo+ID4gPg0KPiAy
ZjA4ZDc3OWNiOTcxNiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2DQo+ID4gPg0KPiAzNzExMTc4ODIwODcwMjM0MCZhbXA7c2RhdGE9M20lMkZ1TnVOSWdxODJ6
JTJCQWVYSjl5N3duODFrViUNCj4gPiA+IDJGaUR0M0F5QzNDRGlUUnJjJTNEJmFtcDtyZXNlcnZl
ZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
