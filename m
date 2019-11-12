Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A32C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 09:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D6A21783
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 09:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D6A21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157146EAD8;
	Tue, 12 Nov 2019 09:44:54 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790085.outbound.protection.outlook.com [40.107.79.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A317C6EAD8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 09:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O13L4SMz9tsdtAodrkdqa7DyyxTnodTz4RAT55iNlTCEivHUu4jBmGyUYNAFF8ONq4qrABbT2rL+0/gK+hqQS2tYsGmouS9/D5QBXDMipo60hjxQbdoFr0a6ARdm8E22sc1orQKzQtb7lKyqgRRDj9PQw1X11zkuWRyWHpEe7i1KGY8Ye1Lm1Uc/LwGjzW4KKWYXDGy308YiWzj0lmr6xMclhFntenq2Zw0droyXqJ1gR+xwW/+MJjCdUb9CKQ1lO26rfXtLTFpzmb8bCfBRXjnJaJ9MhOkIh1OBtn723HmOisZQHh+Fg1UJy43xxa5ApXNkzRFoJUKQg7C8r35O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MScEnQZTFTmSXoFNzbf+PtSsFIouGNReKfrMZ08eY0=;
 b=L0ccTlyN3hM4KiEQQuDv6dnpwPgab9/1tI2r1XUSkK3J/jnQD6mQ9JenWfTmiwnI4EMeNloZXm12YiXazfCheRvwrYE08lyPnPqhC1McwejTRl8L+caA9i94JkuJJzcF7iiOnkHASWfM8eIbNABqwJg1dHqmdj3q4dNOc1eg3m9MtKrGKlahE9ZJ4OOyHvDtHxegaYycNo2+9AetUkAIn7xBbJfE3JI9+lvJTPFpDUjztJ1HBuVLbLfGNDfLTzJf41bJnn3y3BO8hZ+2C8n7QNd5dn25zO27FhVzMhXnjFW5hfm0Q5py/sZpQnVyQ7NUGsDBjHQl9X1Ce5uDdnU1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3983.namprd12.prod.outlook.com (10.255.238.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 09:44:51 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 09:44:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x
 ASICs V2
Thread-Topic: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x
 ASICs V2
Thread-Index: AQHVmPsnRuJQnAVPSU65LIzos5RFA6eHSZjA
Date: Tue, 12 Nov 2019 09:44:51 +0000
Message-ID:
 <MN2PR12MB3598FE67DB5B6556B8862E4D8E770@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20191112014653.21325-1-evan.quan@amd.com>
In-Reply-To: <20191112014653.21325-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1cacd89-b42a-4c60-dd0c-08d76754f6e7
x-ms-traffictypediagnostic: MN2PR12MB3983:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39833A5FB927819B5550E2048E770@MN2PR12MB3983.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:54;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(13464003)(189003)(199004)(186003)(53546011)(26005)(4326008)(76116006)(64756008)(66446008)(66946007)(76176011)(66476007)(81166006)(6506007)(8676002)(478600001)(8936002)(5660300002)(25786009)(66556008)(102836004)(6246003)(52536014)(7696005)(81156014)(9686003)(11346002)(55016002)(6306002)(476003)(6436002)(229853002)(2906002)(33656002)(74316002)(99286004)(446003)(66066001)(966005)(7736002)(316002)(110136005)(486006)(3846002)(86362001)(71190400001)(71200400001)(305945005)(6116002)(14454004)(2501003)(54906003)(256004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3983;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+HjqIsYOdWEhC8TNrvNOdMKz5WsZCMpWYKKcssMo6pBgzeHMkYol0/KJvqrLiUTD70zFlaVWuW3bnCWsOTtyetoWS+lfnjlV95y3TTgSmf4u8YJkjt3Bnfb49oY10+Sx90So4G1/W4CRsEWLON6mF9+JIxqRqms6Qe8/xJ9Sa1yZkeBkpO3lvFie/AnVMU/iU7InXdaPy6qNIUOA1xxcjAwfpDNzj61jxUB8vpHCeSW9du6GPHM3PhDG378hMpDhfJe90qrdQ7kNFSOsOqC4fG04tFKKbO+6mJWEHljMEIh5W+KsReu/TDtVAgCAGBbduMzs1SMk+lU+xiSgSnyogSr1qoJ2K8YgLQ/DDLejuUjH3zWPE4Ofxktqjfqtd3grdhx9riv2hIbs7ZADTYiFyOfuxyZs0rnOdChnen9mu44mGqzwqHT0eSCXzR6atas7wpTMN4PWbB/xMYiPpgDtHcTT2YmaX6VoOHePfAS0FU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cacd89-b42a-4c60-dd0c-08d76754f6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 09:44:51.2639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UY573//lQ0NJ29LpGf6EIdvZJ2qJQAYajYoccP/UWLYT4vo4JUfDN2DXLYvFKJZ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MScEnQZTFTmSXoFNzbf+PtSsFIouGNReKfrMZ08eY0=;
 b=ecg7Vd9w6LJEJcdwwkzBLoZLO0UJi5fiw9aVaLXeuXQK5lSTaXMwXb5JHF9AoY57p3sewcqZaTIxs5FF76u7VLsKbyNIRmudTgf/zlzxpD2vqNrSghTUUg8vkF2fncSMIcl7EsjHqrtENJD6n/boFNrxY+whQiKVAa30VAtdaN0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>,
 Matt Coffin <mcoffin13@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112094451.Zm6cG4LDZDVPlZJ2Aniruv9PFG277eyZscFHVK7w97I@z>

UmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+DQoNCg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEV2YW4gUXVhbg0KU2VudDogVHVl
c2RheSwgTm92ZW1iZXIgMTIsIDIwMTkgOTo0NyBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpDYzogYWxleGRldWNoZXJAZ21haWwuY29tOyBNYXR0IENvZmZpbiA8bWNvZmZp
bjEzQGdtYWlsLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KU3ViamVjdDog
W1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogYXZvaWQgRFBNIHJlZW5hYmxlIHByb2Nlc3Mgb24g
TmF2aTF4IEFTSUNzIFYyDQoNCltDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCg0KT3RoZXJ3aXNl
LCB3aXRob3V0IFJMQyByZWluaXRpYWxpemF0aW9uLCB0aGUgRFBNIHJlZW5hYmxlbWVudCB3aWxs
IGZhaWwuIFRoYXQgYWZmZWN0cyB0aGUgY3VzdG9tIHBwdGFibGUgdXBsb2FkaW5nLg0KDQpWMjog
c2V0dGluZy9jbGVhcmluZyB1cGxvYWRpbmdfY3VzdG9tX3BwX3RhYmxlIGluDQogICAgc211X3N5
c19zZXRfcHBfdGFibGUoKQ0KDQpDaGFuZ2UtSWQ6IEk2ZmUyZWQ1Y2UyM2YyYTViNjZmMzcxYzBi
NmQxZjkyNDgzN2U1YWY2DQpSZXBvcnRlZC1ieTogTWF0dCBDb2ZmaW4gPG1jb2ZmaW4xM0BnbWFp
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KVGVz
dGVkLWJ5OiBNYXR0IENvZmZpbiA8bWNvZmZpbjEzQGdtYWlsLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgICB8IDMxICsrKysrKysrKysrKysr
KystLS0NCiAuLi4vZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmggICAgfCAg
MSArDQogMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQppbmRleCA3NmE0
MTU0YjNiZTIuLjU0YzIxZjVhMTg2MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYW1kZ3B1X3NtdS5jDQpAQCAtNTkxLDEwICs1OTEsMTggQEAgaW50IHNtdV9zeXNfc2V0X3Bw
X3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCAgdm9pZCAqYnVmLCBzaXplX3Qgc2l6ZSkN
CiAgICAgICAgc211X3RhYmxlLT5wb3dlcl9wbGF5X3RhYmxlID0gc211X3RhYmxlLT5oYXJkY29k
ZV9wcHRhYmxlOw0KICAgICAgICBzbXVfdGFibGUtPnBvd2VyX3BsYXlfdGFibGVfc2l6ZSA9IHNp
emU7DQoNCisgICAgICAgLyoNCisgICAgICAgICogU3BlY2lhbCBod19maW5pIGFjdGlvbihmb3Ig
TmF2aTF4LCB0aGUgRFBNcyBkaXNhYmxlbWVudCB3aWxsIGJlDQorICAgICAgICAqIHNraXBwZWQp
IG1heSBiZSBuZWVkZWQgZm9yIGN1c3RvbSBwcHRhYmxlIHVwbG9hZGluZy4NCisgICAgICAgICov
DQorICAgICAgIHNtdS0+dXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSA9IHRydWU7DQorDQogICAg
ICAgIHJldCA9IHNtdV9yZXNldChzbXUpOw0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAg
ICAgIHByX2luZm8oInNtdSByZXNldCBmYWlsZWQsIHJldCA9ICVkXG4iLCByZXQpOw0KDQorICAg
ICAgIHNtdS0+dXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSA9IGZhbHNlOw0KKw0KIGZhaWxlZDoN
CiAgICAgICAgbXV0ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsNCiAgICAgICAgcmV0dXJuIHJldDsN
CkBAIC0xMjkzLDEwICsxMzAxLDI1IEBAIHN0YXRpYyBpbnQgc211X2h3X2Zpbmkodm9pZCAqaGFu
ZGxlKQ0KICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICAgICAgIH0NCg0KLSAgICAgICBy
ZXQgPSBzbXVfc3RvcF9kcG1zKHNtdSk7DQotICAgICAgIGlmIChyZXQpIHsNCi0gICAgICAgICAg
ICAgICBwcl93YXJuKCJGYWlsIHRvIHN0b3AgRHBtcyFcbiIpOw0KLSAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQorICAgICAgIC8qDQorICAgICAgICAqIEZvciBjdXN0b20gcHB0YWJsZSB1cGxv
YWRpbmcsIHNraXAgdGhlIERQTSBmZWF0dXJlcw0KKyAgICAgICAgKiBkaXNhYmxlIHByb2Nlc3Mg
b24gTmF2aTF4IEFTSUNzLg0KKyAgICAgICAgKiAgIC0gQXMgdGhlIGdmeCByZWxhdGVkIGZlYXR1
cmVzIGFyZSB1bmRlciBjb250cm9sIG9mDQorICAgICAgICAqICAgICBSTEMgb24gdGhvc2UgQVNJ
Q3MuIFJMQyByZWluaXRpYWxpemF0aW9uIHdpbGwgYmUNCisgICAgICAgICogICAgIG5lZWRlZCB0
byByZWVuYWJsZSB0aGVtLiBUaGF0IHdpbGwgY29zdCBtdWNoIG1vcmUNCisgICAgICAgICogICAg
IGVmZm9ydHMuDQorICAgICAgICAqDQorICAgICAgICAqICAgLSBTTVUgZmlybXdhcmUgY2FuIGhh
bmRsZSB0aGUgRFBNIHJlZW5hYmxlbWVudA0KKyAgICAgICAgKiAgICAgcHJvcGVybHkuDQorICAg
ICAgICAqLw0KKyAgICAgICBpZiAoIXNtdS0+dXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSB8fA0K
KyAgICAgICAgICAgISgoYWRldi0+YXNpY190eXBlID49IENISVBfTkFWSTEwKSAmJg0KKyAgICAg
ICAgICAgICAoYWRldi0+YXNpY190eXBlIDw9IENISVBfTkFWSTEyKSkpIHsNCisgICAgICAgICAg
ICAgICByZXQgPSBzbXVfc3RvcF9kcG1zKHNtdSk7DQorICAgICAgICAgICAgICAgaWYgKHJldCkg
ew0KKyAgICAgICAgICAgICAgICAgICAgICAgcHJfd2FybigiRmFpbCB0byBzdG9wIERwbXMhXG4i
KTsNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorICAgICAgICAgICAgICAg
fQ0KICAgICAgICB9DQoNCiAgICAgICAga2ZyZWUodGFibGVfY29udGV4dC0+ZHJpdmVyX3BwdGFi
bGUpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRn
cHVfc211LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5o
DQppbmRleCA4MTIwZTc1ODc1ODUuLjIxNTg0MWY1ZmI5MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgNCkBAIC0zOTEsNiArMzkxLDcgQEAg
c3RydWN0IHNtdV9jb250ZXh0DQoNCiAgICAgICAgdWludDMyX3Qgc21jX2lmX3ZlcnNpb247DQoN
CisgICAgICAgYm9vbCB1cGxvYWRpbmdfY3VzdG9tX3BwX3RhYmxlOw0KIH07DQoNCiBzdHJ1Y3Qg
aTJjX2FkYXB0ZXI7DQotLQ0KMi4yNC4wDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
