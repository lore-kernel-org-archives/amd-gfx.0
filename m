Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1589BC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 05:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD492146E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 05:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qxFefMA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD492146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA3A6E5D5;
	Tue, 10 Mar 2020 05:38:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE2A6E34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 05:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCU5T4Ker9iEn/egyzRjmytqjCjdIt6ifrJ0I4FglYLFRQh2O4oHZLdIjoievugSd/m1h7MH0nFfceWPNzBzfD+lcuavc2YbtRLphDoustxNFyZf8KOL5+mW8CX40X5n5Gn1gkTDh36318xg2syYpmBBuv1WOXsqaYQO7iNDp/bRnkzS1yU3t/MlUHEQv62x+D8z8cfnegX1wjd4jS62Ns0mAqGyQusRMB8OHQWZY7pfU9IJWxBO5ZYl/u8J0qglHgaa0Iz4sFMBe2hRyWWr046ttXrPw28zUlK8aCP5b8s4BVTlAu0r/X+DiieYG2dJBfma9eCeKM7ZlRtXnot+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytWB15NBZyR7Fc0V05WwjIKr9tNeeUggRML6+qEH5WA=;
 b=CYzXbZ4H5A/uAUyzaVkonwDWLAh0bKnjOKbOfDhTCIsM/wSe4VuPeNY6QACShru43gDAKbHZyiNDxiZuYfYAtOKyzZzdwyDK1YLzUzjRoCm9kMjW/cgdPYOOe2854GU6Ust6wh/OhHRJ52MNcE8qAl++UD3yxAbGrdizBibPsCzIRl3THh9FfwWalX5lyUndsaTcHQAPMQLZdXenhzHbvAtK4HxxQd8gS4kdQ1N7TEHOEhje+OYMVUdPPjvMBHFZUaYA/pElZCc5vt6TZsv8OBtfIKBT0C1lLFPXnB6/MxmPTPVbVv3DamOIb2+WplvHUSSuboXj3r1/RYmUfZfkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytWB15NBZyR7Fc0V05WwjIKr9tNeeUggRML6+qEH5WA=;
 b=qxFefMA9u2LAC3cLFVclJjsYFiGxVozesMu+It0+C+X68VJ6qL9dPczOUzTeZbRFn3dyRGT+IQGT1QJhJxTz4HojHJK8dQLc6glNVNWGMleCMIgQT4BHsGbeahE6728kYFD1eqJhgdv/jbsE9i0mXzVxs7HK3ION9c1jIEZ02Ig=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by MN2PR12MB3072.namprd12.prod.outlook.com (2603:10b6:208:c5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 05:38:37 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::700c:bda1:a8f8:2dbd]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::700c:bda1:a8f8:2dbd%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 05:38:37 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check for the existence of RAS dir before
 creating
Thread-Topic: [PATCH] drm/amdgpu: check for the existence of RAS dir before
 creating
Thread-Index: AQHV9pyioA3yVAwPWku8PUgafayAAqhBTmRQ
Date: Tue, 10 Mar 2020 05:38:37 +0000
Message-ID: <MN2PR12MB3054A7246FCEFB9A2BB1742EB0FF0@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20200310052614.22208-1-evan.quan@amd.com>
In-Reply-To: <20200310052614.22208-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T05:38:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7e3509de-497f-4903-ae84-0000feec9fca;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-10T05:38:34Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 39350a82-e033-4bea-a8da-00001900a52c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [59.63.203.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fc09305-0d86-4ca4-bf3b-08d7c4b54837
x-ms-traffictypediagnostic: MN2PR12MB3072:|MN2PR12MB3072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3072CBEECBE7A35DD53DC498B0FF0@MN2PR12MB3072.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(4326008)(6636002)(86362001)(81166006)(55016002)(81156014)(8936002)(478600001)(52536014)(6506007)(54906003)(71200400001)(33656002)(110136005)(5660300002)(26005)(9686003)(186003)(7696005)(316002)(53546011)(76116006)(45080400002)(66476007)(966005)(8676002)(2906002)(66446008)(66556008)(64756008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3072;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QcFlZ1NfUfBcjVlwYVc4mZ/kyRTYfEkKPE4fHWNE1nJ0I/fOS5wbezd0920soBwyIwu78t0ejf1NEOxt8orOVMfWBypImf85/WG+I1JtTJPOi/FVaFR6Abs8S9qzeGclc7tF7MXsB/WJC+HJaSPvXxP45dHv1Hm6hx1l4aP1GCmWrsikUc4y2Xm61Sj95Lagg6bnd/pTxY4v2YymReutjeHrL4Zy6FEfdRKGKn2Vx4A8md9qV6xG4v4SnumfsrWOUPtelLTdiBuTc9sy3kmTaAwA4gUgvbNe4nd1/QrWEhyxnTXa3hjWT9Pv7h8voENSnhebMRSicYjhSZ218lOyarPjqSZQUlc4MGdd4VLAQwcvBkA0h/E4BQ97EhTcMS1TFl5ARutu8a1dB9VzKXTkmvKdGvjv6NAkfoy5p3cEOlN9976SC7C/pwxuyeh32RZ6gz3V63IxdfGT1s2PkffgSkw7SB2IaBfp/da+KrK/CYsacwq6s05+NCYkKeKVabRJ6Z4XIXMvEKOuFvDiM+KnoQ==
x-ms-exchange-antispam-messagedata: ORXkn3SxiB4tWFj8spbGWCkU/P3bd0r51n4KKALllNlV2aZhXJWKnLwW2e+2Nw8x+sVcutsxISLkyw3Lmx8judQi+e2KwCao9bfM2kn+NH4g4q46yLiuNwXsQMsu89WscCcZQ9tu1vcenmooiLRsJw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc09305-0d86-4ca4-bf3b-08d7c4b54837
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 05:38:37.4742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Os6b7Dr1CQ06AgvDkY+qAMdEI8Leby7t3gnboV+JNQlh76BaQJ0Er4lZEjnRFiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3072
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgaXNzdWUgaXMgZml4ZWQgYnk6DQoNCmNlbnRyYWxpemUgYWxsIGRlYnVnZnMgY3JlYXRpb24g
aW4gb25lIHBsYWNlIGZvciByYXMNCg0KU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91
MUBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1k
LmNvbT4NCkNoYW5nZS1JZDogSTc0ODljY2I0MWRjZjdhMTFlY2M0NTMxM2FkNDI5NDA0NzQ5OTlk
ODENCg0KSGkgU3RhbmxleToNCg0KSGF2ZSB5b3UgcHVzaGVkIHRoZSBwYXRjaD8NCg0KUmVnYXJk
cywNClRhbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBFdmFu
DQo+IFF1YW4NCj4gU2VudDogMjAyMMTqM9TCMTDI1SAxMzoyNg0KPiBUbzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsg
WmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kZ3B1OiBjaGVjayBmb3IgdGhlIGV4aXN0ZW5jZSBvZiBSQVMgZGlyIGJlZm9y
ZQ0KPiBjcmVhdGluZw0KPiANCj4gVG8gYWRkcmVzcyB0aGUgZXJyb3IgbWVzc2FnZSBiZWxvdzoN
Cj4gZGVidWdmczogRGlyZWN0b3J5ICdyYXMnIHdpdGggcGFyZW50ICcvJyBhbHJlYWR5IHByZXNl
bnQhDQo+IA0KPiBDaGFuZ2UtSWQ6IEkyNTM5ZTg5ZmRmZTRlMjIwNTVjM2JlNWE0OGE4YzBhZGFk
MzE1ZjkxDQo+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNCArKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IGUxZThm
ZDRiMmI4OS4uMjE5NWY2YzYzYjUwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jDQo+IEBAIC0xMDc1LDcgKzEwNzUsOSBAQCBzdGF0aWMgdm9pZA0KPiBhbWRn
cHVfcmFzX2RlYnVnZnNfY3JlYXRlX2N0cmxfbm9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4gIAlzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChh
ZGV2KTsNCj4gIAlzdHJ1Y3QgZHJtX21pbm9yICptaW5vciA9IGFkZXYtPmRkZXYtPnByaW1hcnk7
DQo+IA0KPiAtCWNvbi0+ZGlyID0gZGVidWdmc19jcmVhdGVfZGlyKCJyYXMiLCBtaW5vci0+ZGVi
dWdmc19yb290KTsNCj4gKwljb24tPmRpciA9IGRlYnVnZnNfbG9va3VwKCJyYXMiLCBtaW5vci0+
ZGVidWdmc19yb290KTsNCj4gKwlpZiAoIWNvbi0+ZGlyKQ0KPiArCQljb24tPmRpciA9IGRlYnVn
ZnNfY3JlYXRlX2RpcigicmFzIiwgbWlub3ItPmRlYnVnZnNfcm9vdCk7DQo+ICAJZGVidWdmc19j
cmVhdGVfZmlsZSgicmFzX2N0cmwiLCBTX0lXVUdPIHwgU19JUlVHTywgY29uLT5kaXIsDQo+ICAJ
CQkJYWRldiwgJmFtZGdwdV9yYXNfZGVidWdmc19jdHJsX29wcyk7DQo+ICAJZGVidWdmc19jcmVh
dGVfZmlsZSgicmFzX2VlcHJvbV9yZXNldCIsIFNfSVdVR08gfCBTX0lSVUdPLCBjb24tDQo+ID5k
aXIsDQo+IC0tDQo+IDIuMjUuMQ0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZg0KPiByZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N0YW8u
emhvdTElNDBhbWQuY29tJTdDOWI1M2E2MDQ3ODVmNGFhNjkNCj4gMDE4MDhkN2M0YjM5ZDUwJTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3Qw0KPiA2MzcxOTQxNDg2
NzkzNzM0OTMmYW1wO3NkYXRhPWo5TDBpYmJoJTJGbDlidHNaQ3dPUUswRDg2TnJwMXhSJTINCj4g
QlRaV0NpeG5TRFklMkZZJTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
