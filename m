Return-Path: <SRS0=roBy=Y2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB13CA9ECF
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DCF208CB
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DCF208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8276E348;
	Sat,  2 Nov 2019 01:34:49 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820073.outbound.protection.outlook.com [40.107.82.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7D96E348
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Nov 2019 01:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHol5w9ybGEwm9skKNXCkIfgJDM7aaKNBGvFw/R9nqvL1FP/sNK0P2hl0xkfuiz7MAKyvpy7sYSJkXgvkVtn+LtcLXlkJCBdzRkRS2FlI2ZsYdxAn/hPJoIqwt5sDbizCQuw0QHaWEEU4Aa41hpmNqVYijL9QYUaw6aPq0WvNETJcBqv0hPR9LqO5Yy+ahVSwRhivkq354dEOpWntucbsRlhVi4vcuoyBkkmpTddluAzlLFw0CPOr9UfDPrdxRCwXI3LvxV9zm7FErrHjl4oJfOBpEorOyBBz+3zELAJh/uLPzpdJcAekKSB1WIswnr7QaQrm4Pqcnv3mG6foidv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qclp2uzlIXYoxnWghNLbWbcCIYwuEDbmtrbtQAy8GCc=;
 b=gxne9Htb3zu5EOfrCji20grkZZDxWeFKIxMSprudwgChBmqzJBKjsvaKRa3iN1xMWQc1fBiyV/7Ghls1+HDSNE3sQr6cjja+F5cF1pBwtGms+1xTAti9mvj6G039nzcZaaHKi2LBLG/nb69BK6/2eA40Rh7eL/9WsdA9JU8ah5hww73Pd5Xs4mW48rMQEtXE/RMrjjTXPKAkHfmU1lbMPUa78PvorSyNsZFzejOY3Gng/BGolIBAIEdm+abOIIGU9uwfuepDKXuzR0jXvzGP1b1cxOUP0Az/GZLBVJU4aoCqFZSve8X9uNpYvscr7wFvYFjv4p3Hi8xH0vNdJLgMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB4250.namprd12.prod.outlook.com (10.141.186.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sat, 2 Nov 2019 01:34:45 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::b5f1:6693:1573:ab1e]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::b5f1:6693:1573:ab1e%6]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 01:34:45 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Topic: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Index: AQHVkRtJPzPseCXxv0iiGbLb2otyPad3FY3QgAAAzXA=
Date: Sat, 2 Nov 2019 01:34:45 +0000
Message-ID:
 <DM6PR12MB346604E3AA9D244930BCD8669E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <BL0PR12MB2339B22CD38213ABB2CA34B6FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2339B22CD38213ABB2CA34B6FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa1150cd-d3a5-4102-b799-08d75f34d757
x-ms-traffictypediagnostic: DM6PR12MB4250:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42501D8659550301440383EB9E7D0@DM6PR12MB4250.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39850400004)(396003)(346002)(376002)(13464003)(199004)(189003)(81156014)(55016002)(99286004)(11346002)(476003)(86362001)(446003)(7696005)(478600001)(76116006)(76176011)(966005)(6506007)(53546011)(91956017)(71200400001)(4326008)(71190400001)(66946007)(66446008)(66476007)(66556008)(256004)(486006)(26005)(102836004)(14454004)(25786009)(14444005)(186003)(66066001)(2906002)(229853002)(6306002)(9686003)(81166006)(6636002)(8676002)(8936002)(110136005)(64756008)(6246003)(54906003)(52536014)(33656002)(6436002)(6116002)(316002)(3846002)(2501003)(74316002)(305945005)(5660300002)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4250;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHd9gNRU2yBGM2lVlTVeqCNj7K0ewXeALa/JgdyZ1xV/SK/6qq7ELn2Su4RmoDJwfN/zZfkXCK0iXE3D9sZPFmeZv4lKxVrQKbLhSF333VXV6BBEx9ig1rpUw9Lmlk3reBcQ8oWUermiILWH+Tx2WmKbHX8BCn9k8i/+EMWAj7bWYZWLJG+ppvDS9SRLb1txguf9dO+Qno4SzyQyy8/s9zte55L2AbeSTljnKgy0gP2/2XVcZb/PsRQFHxC7NLG3JhF2gkH/RFaYqXKDARYth2VozserI4+OlYc/ii/ys7+kCHpC+XV6EAzPg1EGnvStAGzrCWPug0Sqnt3KE31jol56DsuNNXcOudw0eeTMNb7kMNjtsGe2CSF8tW5ag2dawSdEjUf0IKv3HtoysgcywatnHtcGEStO/Q64oRezfkBIP/IkLRzFhgiGUsYwx4DctzE0lUDEDZOjS8MO5Ehrf8lRPTKnLWSNNMfLZQCcfGk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1150cd-d3a5-4102-b799-08d75f34d757
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 01:34:45.0733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+KXRTwwLyVDeLycc28r1hkfOh4PBs1TSTRIgJSveqUVOkrjvACc1R2ccIFhyqB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qclp2uzlIXYoxnWghNLbWbcCIYwuEDbmtrbtQAy8GCc=;
 b=NrXdFvhDe0UuTuL1P71zVYDGE5bvzRYj+5MTlCv/1jXRvK57LeiGF6QTKuSYjhwreHaa0qMpkqO5OuYT3jm9inCyVN42A2VKywUi0H1st5V0I1nl5+HjdGX1DSQWS2Xuss7D+Yh7CUW8yEsER0RlK3CN/ZOf1rj8sSI6ifkvC0I=
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
Cc: "Yeh, Eagle" <Eagle.Yeh@amd.com>, "Lazare, Jordan" <Jordan.Lazare@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191102013445.K2Fbv8GSR4AVPLMR0-VanPR_Tox52xLsVJABzyOb6EU@z>

VGhhbmsgeW91IEhlcnNlbi4gUGxlYXNlIGNoZWNrIHRoZSB1cGRhdGVkIHBhdGNoOgoKRnJvbTog
TGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPiAKU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAy
MDE5IDk6MTggUE0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLYXpsYXVza2Fz
LCBOaWNob2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPjsgTGFraGEsIEJoYXdhbnBy
ZWV0IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBhbWQu
Y29tPjsgTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJv
ZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRA
YW1kLmNvbT47IFd1LCBIZXJzZW4gPGhlcnNlbnhzLnd1QGFtZC5jb20+OyBadW8sIEplcnJ5IDxK
ZXJyeS5adW9AYW1kLmNvbT4KQ2M6IFllaCwgRWFnbGUgPEVhZ2xlLlllaEBhbWQuY29tPjsgTGF6
YXJlLCBKb3JkYW4gPEpvcmRhbi5MYXphcmVAYW1kLmNvbT4KU3ViamVjdDogW1BBVENIXSBkcm0v
YW1kL2Rpc3BsYXk6IEFkZCBFTkdJTkVfSURfRElHRCBjb25kaXRpb24gY2hlY2sgZm9yIE5hdmkx
NAoKRnJvbTogWmhhbiBsaXUgPHpoYW4ubGl1QGFtZC5jb20+CkRhdGU6IEZyaSwgMSBOb3YgMjAx
OSAyMToxMDoxNyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVO
R0lORV9JRF9ESUdEIGNvbmRpdGlvbiBjaGVjayBmb3IgTmF2aTE0CgpbV2h5XQpOYXZpMTAgaGFz
IDYgUEhZLCBidXQgTmF2aTE0IG9ubHkgaGFzIDUgUEhZLCB0aGF0IGlzIGJlY2F1c2UgdGhlcmUg
aXMgbm8gRU5HSU5FX0lEX0RJR0QgaW4gTmF2aTE0LiBXaXRob3V0IHRoaXMgcGF0Y2gsIG1hbnkg
SERNSSByZWxhdGVkIGlzc3VlcyAoZS5nLiBIRE1JIFMzIHJlc3VtZSBmYWlsdXJlLCBIRE1JIHBp
bmsgc2NyZWVuIG9uIGJvb3QpIHdpbGwgYmUgb2JzZXJ2ZWQuCgpbSG93XQpJZiBlbmdfaWQgaXMg
bGFyZ2VyIHRoYW4gRU5HSU5FX0lEX0RJR0QsIHRoZW4gYWRkIGVuZ19pZCBieSAxLgoKU2lnbmVk
LW9mZi1ieTogWmhhbiBsaXUgPHpoYW4ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgfCAzICsrKwogMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKaW5kZXggOTI0YzJlMzAzNTg4Li5jZjg4
NjQ4M2UzODAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24yMC9kY24yMF9yZXNvdXJjZS5jCkBAIC0xMTUyLDYgKzExNTIsMTEgQEAgc3RydWN0IHN0cmVh
bV9lbmNvZGVyICpkY24yMF9zdHJlYW1fZW5jb2Rlcl9jcmVhdGUoCiAgICAgICAgaWYgKCFlbmMx
KQogICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7CgorCWlmIChBU0lDX1JFVl9JU19OQVZJMTRf
TShjdHgtPmFzaWNfaWQuaHdfaW50ZXJuYWxfcmV2KSkgeworCQlpZiAoZW5nX2lkID49IEVOR0lO
RV9JRF9ESUdEKQorCQkJZW5nX2lkKys7CisJfQorCiAgICAgICAgZGNuMjBfc3RyZWFtX2VuY29k
ZXJfY29uc3RydWN0KGVuYzEsIGN0eCwgY3R4LT5kY19iaW9zLCBlbmdfaWQsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3RyZWFtX2VuY19yZWdzW2VuZ19pZF0sCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc2Vfc2hpZnQsICZzZV9tYXNr
KTsKLS0KMi4yMS4wCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogV3UsIEhl
cnNlbiA8aGVyc2VueHMud3VAYW1kLmNvbT4KPiBTZW50OiAyMDE5L05vdmVtYmVyLzAxLCBGcmlk
YXkgOToyMyBQTQo+IFRvOiBMaXUsIFpoYW4gPFpoYW4uTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsKPiBLYXpsYXVza2FzLCBOaWNob2xhcyA8TmljaG9sYXMuS2F6
bGF1c2thc0BhbWQuY29tPjsgTGFraGEsIEJoYXdhbnByZWV0Cj4gPEJoYXdhbnByZWV0Lkxha2hh
QGFtZC5jb20+OyBMaSwgUm9tYW4gPFJvbWFuLkxpQGFtZC5jb20+Owo+IFNpcXVlaXJhLCBSb2Ry
aWdvIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkKPiA8SGFycnku
V2VudGxhbmRAYW1kLmNvbT47IFp1bywgSmVycnkgPEplcnJ5Llp1b0BhbWQuY29tPgo+IENjOiBZ
ZWgsIEVhZ2xlIDxFYWdsZS5ZZWhAYW1kLmNvbT47IExhemFyZSwgSm9yZGFuCj4gPEpvcmRhbi5M
YXphcmVAYW1kLmNvbT4KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFk
ZCBFTkdJTkVfSURfRElHRCBjb25kaXRpb24KPiBjaGVjayBmb3IgTmF2aTE0Cj4gCj4gSGkgWmhh
biwKPiAKPiBUaGUgZnVuY3Rpb24gaXMgc2hhcmVkIGJ5IE5WMTAsMTIsMTQuCj4gCj4gUGxlYXNl
IGFkZCBBU0lDIElEIGNoZWNrICBmb3IgdGhlIERJRyBEIHNraXAuCj4gCj4gVGhhbmtzIQo+IEhl
cnNlbgo+IAo+IAo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogTGl1LCBaaGFu
IDxaaGFuLkxpdUBhbWQuY29tPgo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwgMjAxOSA5OjE4
IFBNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLYXpsYXVza2FzLCBOaWNo
b2xhcwo+IDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBMYWtoYSwgQmhhd2FucHJlZXQK
PiA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlAYW1kLmNv
bT47IExpdSwKPiBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJv
ZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47Cj4gV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFu
ZEBhbWQuY29tPjsgV3UsIEhlcnNlbgo+IDxoZXJzZW54cy53dUBhbWQuY29tPjsgWnVvLCBKZXJy
eSA8SmVycnkuWnVvQGFtZC5jb20+Cj4gQ2M6IFllaCwgRWFnbGUgPEVhZ2xlLlllaEBhbWQuY29t
PjsgTGF6YXJlLCBKb3JkYW4KPiA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgo+IFN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBBZGQgRU5HSU5FX0lEX0RJR0QgY29uZGl0aW9uIGNoZWNr
Cj4gZm9yIE5hdmkxNAo+IAo+IEZyb206IFpoYW4gbGl1IDx6aGFuLmxpdUBhbWQuY29tPgo+IERh
dGU6IEZyaSwgMSBOb3YgMjAxOSAyMToxMDoxNyAtMDQwMAo+IFN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZC9kaXNwbGF5OiBBZGQgRU5HSU5FX0lEX0RJR0QgY29uZGl0aW9uIGNoZWNrCj4gZm9yIE5h
dmkxNAo+IAo+IFtXaHldCj4gTmF2aTEwIGhhcyA2IFBIWSwgYnV0IE5hdmkxNCBvbmx5IGhhcyA1
IFBIWSwgdGhhdCBpcyBiZWNhdXNlIHRoZXJlIGlzIG5vCj4gRU5HSU5FX0lEX0RJR0QgaW4gTmF2
aTE0LiBXaXRob3V0IHRoaXMgcGF0Y2gsIG1hbnkgSERNSSByZWxhdGVkIGlzc3Vlcwo+IChlLmcu
IEhETUkgUzMgcmVzdW1lIGZhaWx1cmUsIEhETUkgcGluayBzY3JlZW4gb24gYm9vdCkgd2lsbCBi
ZSBvYnNlcnZlZC4KPiAKPiBbSG93XQo+IElmIGVuZ19pZCBpcyBsYXJnZXIgdGhhbiBFTkdJTkVf
SURfRElHRCwgdGhlbiBhZGQgZW5nX2lkIGJ5IDEuCj4gCj4gU2lnbmVkLW9mZi1ieTogWmhhbiBs
aXUgPHpoYW4ubGl1QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiBpbmRleCA5MjRjMmUzMDM1ODguLmNmODg2
NDgzZTM4MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfcmVzb3VyY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gQEAgLTExNTIsNiArMTE1Miw5IEBAIHN0cnVjdCBz
dHJlYW1fZW5jb2Rlcgo+ICpkY24yMF9zdHJlYW1fZW5jb2Rlcl9jcmVhdGUoCj4gICAgICAgICBp
ZiAoIWVuYzEpCj4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+IAo+ICsgICAgICAgaWYg
KGVuZ19pZCA+PSBFTkdJTkVfSURfRElHRCkKPiArICAgICAgICAgICAgICAgZW5nX2lkKys7Cj4g
Kwo+ICAgICAgICAgZGNuMjBfc3RyZWFtX2VuY29kZXJfY29uc3RydWN0KGVuYzEsIGN0eCwgY3R4
LT5kY19iaW9zLCBlbmdfaWQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZzdHJlYW1fZW5jX3JlZ3NbZW5nX2lkXSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJnNlX3NoaWZ0LCAmc2VfbWFzayk7Cj4gLS0KPiAyLjIxLjAKPiAKPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IAo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiAKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
