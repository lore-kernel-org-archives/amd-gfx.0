Return-Path: <SRS0=roBy=Y2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97902CA9ECF
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3E1208CB
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3E1208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7E46F8AB;
	Sat,  2 Nov 2019 01:37:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700051.outbound.protection.outlook.com [40.107.70.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D346F8AB
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Nov 2019 01:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIKYAXLvB9/n02fz9+tJX4AQXNUOurbhjwJS3YZ9e45jRzUzKw2d7wdGSQKH+c0YM5a4TtAN/uHsANZuI0hx4j6rLfhMTOUKunnORDYcdiDyNKZDCp5iH8KsyRc4+33QXPqSr/gBcgCjqrB5DbJGGEnB8pqFnR9lxxHzuXvW33HoafetleaON5DJF+YIQNczho4auSsnxkEDUpALQbcGG52+GXwwlngk28TuKa4WASecLnVZ/z/VUyyyGy2QEPLg+kghCKXeDhrxv0FG88v5/zE/TlZgWY3dvTAEKSHytLi3FkKDn3AtS9DYWkJgdgaaLzc0+8xt7nrt5i3gRnq0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi0y6zoHdZXtMmPRLQbPc3MHMwYpj88u2yN6kXg/urg=;
 b=E8zwv972tVysr8Grhf914wsv1WOleoSDQRVYpXHkcwf+WPe3/8eEPvKn/3FzGF+VuX6uxFveJWq5NlQyelzd9biCbAOiTqwv5OwzlLRM57ib5bPE74z+3eOO79KmY95KNGItmeDxTCLYkZyn/21LH/bSac70xuZWZDW+i5E3uT6ORCRoifznkzzsTF/kDeoFCD0jlJTSGjBbBwhinhFn0THoFbnB4rnXf8PZOtUo7J1/TXPnpp7ypRtAI3G2LpC5vdKxn7/T0BwBwKsE4Gn28vgPnMyPbBn1C4xqoPNSCeukkUGC2itkwsI2tHV3h1YlTSy8ub/8iXFD61omWFeYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2339.namprd12.prod.outlook.com (52.132.11.148) by
 BL0PR12MB2545.namprd12.prod.outlook.com (52.132.11.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 01:37:01 +0000
Received: from BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::b807:6ac3:d720:5b56]) by BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::b807:6ac3:d720:5b56%5]) with mapi id 15.20.2387.027; Sat, 2 Nov 2019
 01:37:01 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Topic: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Index: AQHVkRtJPzPseCXxv0iiGbLb2otyPad3FY3QgAAAzXCAAAMoEA==
Date: Sat, 2 Nov 2019 01:37:01 +0000
Message-ID:
 <BL0PR12MB23395743667E0F1089F432F4FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
References: <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <BL0PR12MB2339B22CD38213ABB2CA34B6FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
 <DM6PR12MB346604E3AA9D244930BCD8669E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB346604E3AA9D244930BCD8669E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:3c60:111:e505:7c5e:39ee:d355]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d73618be-9a20-48de-7fb3-08d75f3528b5
x-ms-traffictypediagnostic: BL0PR12MB2545:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2545DF7201C30A9157123DD3FD7D0@BL0PR12MB2545.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(13464003)(189003)(199004)(11346002)(478600001)(33656002)(52536014)(6506007)(71190400001)(46003)(71200400001)(229853002)(76176011)(110136005)(186003)(256004)(53546011)(55016002)(74316002)(66556008)(8936002)(305945005)(102836004)(7696005)(6306002)(14444005)(99286004)(7736002)(6436002)(9686003)(6116002)(81156014)(486006)(86362001)(64756008)(2501003)(81166006)(316002)(5660300002)(2906002)(8676002)(6246003)(966005)(66446008)(14454004)(66946007)(476003)(54906003)(25786009)(446003)(6636002)(66476007)(76116006)(4326008)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2545;
 H:BL0PR12MB2339.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBPnqA1kZtfiFqhvZmHFxxjYhSptvCgtmRYDFrpQoeWqWPcO5fH6OVHLGxYbXI4D12MEZRLkdD8t7YMxliIO3/bJSZsS634Bu1Hczt9VpZI6xf74HEn7XX+Jc+hJ7u4iUJxGT5Ne4RgG1831MFjKPM53/1ILEkcVkjYP0XGprvyMXBpg/hfrG1zwj8j+kIh0IkB3aMMQlCwbU6LUUzU8Mcf5uzlATO2Avzseq+bT9uAs70PwR45GyTk3h19dS7RVgsqazgjXEFp2uQOXvDAnb8tnLgZY/gLQefDlNC8USZjoR2lvOQ+U1kiJo8xDnvTq32NhIAGAPX+f1NmTVRWfOO1Wpa92XfL99oJaCpCnEFoDyZHhyBM/hYkkZaYRHX1WaJs45EfXJV4gQBr4AsLOafIqXSGKGfN/mlUhO4w2t07eIYeHigONAu97ENBgMtuxNPssrGN1HwymfL9hgTKR1HPXe1qa0/kq0jZSKPXwefQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73618be-9a20-48de-7fb3-08d75f3528b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 01:37:01.5714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTrUbTNzIMesZcRZArbdwHBA1SGeYXWP/xlhx5b1ELAWQ2ge8aOaz3HlxO4w9oluP4NyBJ0k9NpGL81EddEwEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi0y6zoHdZXtMmPRLQbPc3MHMwYpj88u2yN6kXg/urg=;
 b=mwr+b76sgum0vRk025n9KjllzqCM1OccfuV17o8Ia3Ee1apgf7lDf1EI8zcgje+40Nw7IejmQm66Nzp1Ql1zO+ktnuq6/hi104gSFXx22m79p8I/Csi644bwDW8JDVfrZECTiseWRx2no4NCyDR+ZC8MmwiUJ83fexeeAIPY420=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hersenxs.wu@amd.com; 
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
Cc: "Yeh, Eagle" <Eagle.Yeh@amd.com>, "Lazare, Jordan" <Jordan.Lazare@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191102013701.acOyUrmKxu0sB1tVhVjAG72OrzCHSbflzFWo-L1OWjw@z>

ClJldmlld2VkLWJ5OiBIZXJzZW4gV3UgPGhlcnNlbnhzLnd1QGFtZC5jb20+CgoKCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCkZyb206IExpdSwgWmhhbiA8Wmhhbi5MaXVAYW1kLmNvbT4gClNl
bnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwgMjAxOSA5OjM1IFBNClRvOiBXdSwgSGVyc2VuIDxoZXJz
ZW54cy53dUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEthemxhdXNr
YXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBMYWtoYSwgQmhhd2Fu
cHJlZXQgPEJoYXdhbnByZWV0Lkxha2hhQGFtZC5jb20+OyBMaSwgUm9tYW4gPFJvbWFuLkxpQGFt
ZC5jb20+OyBTaXF1ZWlyYSwgUm9kcmlnbyA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPjsgV2Vu
dGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgWnVvLCBKZXJyeSA8SmVycnku
WnVvQGFtZC5jb20+CkNjOiBZZWgsIEVhZ2xlIDxFYWdsZS5ZZWhAYW1kLmNvbT47IExhemFyZSwg
Sm9yZGFuIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+ClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9h
bWQvZGlzcGxheTogQWRkIEVOR0lORV9JRF9ESUdEIGNvbmRpdGlvbiBjaGVjayBmb3IgTmF2aTE0
CgpUaGFuayB5b3UgSGVyc2VuLiBQbGVhc2UgY2hlY2sgdGhlIHVwZGF0ZWQgcGF0Y2g6CgpGcm9t
OiBMaXUsIFpoYW4gPFpoYW4uTGl1QGFtZC5jb20+ClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwg
MjAxOSA5OjE4IFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2F6bGF1c2th
cywgTmljaG9sYXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT47IExha2hhLCBCaGF3YW5w
cmVldCA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlAYW1k
LmNvbT47IExpdSwgWmhhbiA8Wmhhbi5MaXVAYW1kLmNvbT47IFNpcXVlaXJhLCBSb2RyaWdvIDxS
b2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5k
QGFtZC5jb20+OyBXdSwgSGVyc2VuIDxoZXJzZW54cy53dUBhbWQuY29tPjsgWnVvLCBKZXJyeSA8
SmVycnkuWnVvQGFtZC5jb20+CkNjOiBZZWgsIEVhZ2xlIDxFYWdsZS5ZZWhAYW1kLmNvbT47IExh
emFyZSwgSm9yZGFuIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+ClN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZC9kaXNwbGF5OiBBZGQgRU5HSU5FX0lEX0RJR0QgY29uZGl0aW9uIGNoZWNrIGZvciBOYXZp
MTQKCkZyb206IFpoYW4gbGl1IDx6aGFuLmxpdUBhbWQuY29tPgpEYXRlOiBGcmksIDEgTm92IDIw
MTkgMjE6MTA6MTcgLTA0MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBF
TkdJTkVfSURfRElHRCBjb25kaXRpb24gY2hlY2sgZm9yIE5hdmkxNAoKW1doeV0KTmF2aTEwIGhh
cyA2IFBIWSwgYnV0IE5hdmkxNCBvbmx5IGhhcyA1IFBIWSwgdGhhdCBpcyBiZWNhdXNlIHRoZXJl
IGlzIG5vIEVOR0lORV9JRF9ESUdEIGluIE5hdmkxNC4gV2l0aG91dCB0aGlzIHBhdGNoLCBtYW55
IEhETUkgcmVsYXRlZCBpc3N1ZXMgKGUuZy4gSERNSSBTMyByZXN1bWUgZmFpbHVyZSwgSERNSSBw
aW5rIHNjcmVlbiBvbiBib290KSB3aWxsIGJlIG9ic2VydmVkLgoKW0hvd10KSWYgZW5nX2lkIGlz
IGxhcmdlciB0aGFuIEVOR0lORV9JRF9ESUdELCB0aGVuIGFkZCBlbmdfaWQgYnkgMS4KClNpZ25l
ZC1vZmYtYnk6IFpoYW4gbGl1IDx6aGFuLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMyArKysKIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCmluZGV4IDkyNGMyZTMwMzU4OC4uY2Y4
ODY0ODNlMzgwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwpAQCAtMTE1Miw2ICsxMTUyLDExIEBAIHN0cnVjdCBzdHJl
YW1fZW5jb2RlciAqZGNuMjBfc3RyZWFtX2VuY29kZXJfY3JlYXRlKAogICAgICAgIGlmICghZW5j
MSkKICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwoKKwlpZiAoQVNJQ19SRVZfSVNfTkFWSTE0
X00oY3R4LT5hc2ljX2lkLmh3X2ludGVybmFsX3JldikpIHsKKwkJaWYgKGVuZ19pZCA+PSBFTkdJ
TkVfSURfRElHRCkKKwkJCWVuZ19pZCsrOworCX0KKwogICAgICAgIGRjbjIwX3N0cmVhbV9lbmNv
ZGVyX2NvbnN0cnVjdChlbmMxLCBjdHgsIGN0eC0+ZGNfYmlvcywgZW5nX2lkLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnN0cmVhbV9lbmNfcmVnc1tlbmdfaWRdLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNlX3NoaWZ0LCAmc2VfbWFz
ayk7Ci0tCjIuMjEuMAoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IFd1LCBI
ZXJzZW4gPGhlcnNlbnhzLnd1QGFtZC5jb20+Cj4gU2VudDogMjAxOS9Ob3ZlbWJlci8wMSwgRnJp
ZGF5IDk6MjMgUE0KPiBUbzogTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IAo+IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5L
YXpsYXVza2FzQGFtZC5jb20+OyBMYWtoYSwgQmhhd2FucHJlZXQgCj4gPEJoYXdhbnByZWV0Lkxh
a2hhQGFtZC5jb20+OyBMaSwgUm9tYW4gPFJvbWFuLkxpQGFtZC5jb20+OyBTaXF1ZWlyYSwgCj4g
Um9kcmlnbyA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPjsgV2VudGxhbmQsIEhhcnJ5IAo+IDxI
YXJyeS5XZW50bGFuZEBhbWQuY29tPjsgWnVvLCBKZXJyeSA8SmVycnkuWnVvQGFtZC5jb20+Cj4g
Q2M6IFllaCwgRWFnbGUgPEVhZ2xlLlllaEBhbWQuY29tPjsgTGF6YXJlLCBKb3JkYW4gCj4gPEpv
cmRhbi5MYXphcmVAYW1kLmNvbT4KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL2Rpc3Bs
YXk6IEFkZCBFTkdJTkVfSURfRElHRCBjb25kaXRpb24gCj4gY2hlY2sgZm9yIE5hdmkxNAo+IAo+
IEhpIFpoYW4sCj4gCj4gVGhlIGZ1bmN0aW9uIGlzIHNoYXJlZCBieSBOVjEwLDEyLDE0Lgo+IAo+
IFBsZWFzZSBhZGQgQVNJQyBJRCBjaGVjayAgZm9yIHRoZSBESUcgRCBza2lwLgo+IAo+IFRoYW5r
cyEKPiBIZXJzZW4KPiAKPiAKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IExp
dSwgWmhhbiA8Wmhhbi5MaXVAYW1kLmNvbT4KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEsIDIw
MTkgOToxOCBQTQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2F6bGF1c2th
cywgTmljaG9sYXMgCj4gPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT47IExha2hhLCBCaGF3
YW5wcmVldCAKPiA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4u
TGlAYW1kLmNvbT47IExpdSwgWmhhbiAKPiA8Wmhhbi5MaXVAYW1kLmNvbT47IFNpcXVlaXJhLCBS
b2RyaWdvIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyAKPiBXZW50bGFuZCwgSGFycnkgPEhh
cnJ5LldlbnRsYW5kQGFtZC5jb20+OyBXdSwgSGVyc2VuIAo+IDxoZXJzZW54cy53dUBhbWQuY29t
PjsgWnVvLCBKZXJyeSA8SmVycnkuWnVvQGFtZC5jb20+Cj4gQ2M6IFllaCwgRWFnbGUgPEVhZ2xl
LlllaEBhbWQuY29tPjsgTGF6YXJlLCBKb3JkYW4gCj4gPEpvcmRhbi5MYXphcmVAYW1kLmNvbT4K
PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVOR0lORV9JRF9ESUdEIGNv
bmRpdGlvbiBjaGVjayAKPiBmb3IgTmF2aTE0Cj4gCj4gRnJvbTogWmhhbiBsaXUgPHpoYW4ubGl1
QGFtZC5jb20+Cj4gRGF0ZTogRnJpLCAxIE5vdiAyMDE5IDIxOjEwOjE3IC0wNDAwCj4gU3ViamVj
dDogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBFTkdJTkVfSURfRElHRCBjb25kaXRpb24g
Y2hlY2sgCj4gZm9yIE5hdmkxNAo+IAo+IFtXaHldCj4gTmF2aTEwIGhhcyA2IFBIWSwgYnV0IE5h
dmkxNCBvbmx5IGhhcyA1IFBIWSwgdGhhdCBpcyBiZWNhdXNlIHRoZXJlIGlzIAo+IG5vIEVOR0lO
RV9JRF9ESUdEIGluIE5hdmkxNC4gV2l0aG91dCB0aGlzIHBhdGNoLCBtYW55IEhETUkgcmVsYXRl
ZCAKPiBpc3N1ZXMgKGUuZy4gSERNSSBTMyByZXN1bWUgZmFpbHVyZSwgSERNSSBwaW5rIHNjcmVl
biBvbiBib290KSB3aWxsIGJlIG9ic2VydmVkLgo+IAo+IFtIb3ddCj4gSWYgZW5nX2lkIGlzIGxh
cmdlciB0aGFuIEVOR0lORV9JRF9ESUdELCB0aGVuIGFkZCBlbmdfaWQgYnkgMS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBaaGFuIGxpdSA8emhhbi5saXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgfCAzICsrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwo+IGluZGV4IDky
NGMyZTMwMzU4OC4uY2Y4ODY0ODNlMzgwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiBAQCAtMTE1Miw2ICsx
MTUyLDkgQEAgc3RydWN0IHN0cmVhbV9lbmNvZGVyIAo+ICpkY24yMF9zdHJlYW1fZW5jb2Rlcl9j
cmVhdGUoCj4gICAgICAgICBpZiAoIWVuYzEpCj4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxM
Owo+IAo+ICsgICAgICAgaWYgKGVuZ19pZCA+PSBFTkdJTkVfSURfRElHRCkKPiArICAgICAgICAg
ICAgICAgZW5nX2lkKys7Cj4gKwo+ICAgICAgICAgZGNuMjBfc3RyZWFtX2VuY29kZXJfY29uc3Ry
dWN0KGVuYzEsIGN0eCwgY3R4LT5kY19iaW9zLCBlbmdfaWQsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZzdHJlYW1fZW5jX3JlZ3NbZW5nX2lkXSwKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNlX3NoaWZ0LCAmc2VfbWFzayk7Cj4g
LS0KPiAyLjIxLjAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IAo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gCj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiAKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
