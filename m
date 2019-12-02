Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CA8C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819D520833
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819D520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BB06E25B;
	Mon,  2 Dec 2019 16:45:34 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790072.outbound.protection.outlook.com [40.107.79.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35636E25B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 16:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKNcs0B7XZXC7r9un23JDnevKN+9ICP35vzWJ0n0pMaiL9ejc5F+61G9Ey9+PYMwEW3oaHD0uPiYYaTKKp2+qWI8Tj2Rp/v+Kj/lley0/Hb7ODncJODy5Dm7fpZGBbdLvTS9BHjBXdLWP9zFx40sZ1buFLIMnQVXtjQqLH37d+JPGYB7flLokftutE4SHVsm9GQ/yM+EHp7MQlmvi+ceBofiK8RypMbpR0YQPoDFBxI6NQEs+XqWiE3Gt0qqkBaDhQFKbRfoJhjuFPCBDOMt0C1AyiE4X3OhlO4jjV5/yU51BPe3v7VzPV12KtibJsZR4WeDaCRGEkSgqphbtx6v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMCAqf8QMbwknanbTwp0Ic8hYo9ieLD9CmwnlMfqHWM=;
 b=LjPCAMJoGTJDSycrqL8j+ZG+r/gC5zyO+FwaRIeYotgAt8UN/ZY++L4S+cCInTwZ9k8fDciNTYw8ouVXy8XaL66tcjb9hdHQINkH9Z8Oz0TXhlfbSbs8GuhoXzDkqo95SvfSVhvqS1UcWDA6AmcS8KghvRozUsEVpG8b4CV8b1jDlgyIs4HsyjMjYbDIMFMjxTB3IR8PPmoI8HfwG10UtR5AxSAvqR6lAlVgPbeEjThgXliWAJTtBGni9v9C6nBp6tOv0BOLA8Vu++8V8L4dZaS+EMT+hKfRin+fie1+BTI/oPeS+txzqB4fTD1KpvuvJqDBo4p9ttrFUZOVfEI0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1757.namprd12.prod.outlook.com (10.175.54.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Mon, 2 Dec 2019 16:45:25 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:45:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: load np fw prior before loading the TAs
Thread-Topic: [PATCH 3/3] drm/amdgpu: load np fw prior before loading the TAs
Thread-Index: AQHVqNZKVcGq5MjdEkCbk9JDvyKg1aenDhCg
Date: Mon, 2 Dec 2019 16:45:24 +0000
Message-ID: <MWHPR12MB1358DE938B0F3438DBB1535AF7430@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191202060337.22435-1-Hawking.Zhang@amd.com>
 <20191202060337.22435-3-Hawking.Zhang@amd.com>
In-Reply-To: <20191202060337.22435-3-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b99bab91-5235-4a8d-532d-08d7774707a5
x-ms-traffictypediagnostic: MWHPR12MB1757:|MWHPR12MB1757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB17576A183CF5A47A820BECCDF7430@MWHPR12MB1757.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(13464003)(189003)(199004)(66556008)(76116006)(7696005)(6116002)(66946007)(102836004)(3846002)(4326008)(2501003)(66476007)(7736002)(64756008)(6246003)(76176011)(55016002)(9686003)(74316002)(186003)(6636002)(53546011)(14454004)(66446008)(6506007)(26005)(305945005)(66066001)(229853002)(2906002)(6436002)(256004)(14444005)(11346002)(316002)(8676002)(52536014)(5660300002)(110136005)(99286004)(446003)(81156014)(71190400001)(71200400001)(81166006)(478600001)(33656002)(25786009)(8936002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1757;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjDjymehQRnWEBdlrzCYl0ZkYes6jxmjMxCjdA6vY3YDd7ujH3zR+DdH3x52yCFWGYwowRbjTJXCG7ixZYxbXsOG5WCgqmIGx34yAgDZKER6V25cDDJ4Iq1AnLtzLs8CMm/nQsWhorAZu6RZojqLN3J5CCVx6rzBJ2ukENn2+Wqk/cOR+N4POfvqNRCW83lbjjWEvz2vv+d7JStgdNTapBQzIMu+mXy6goTXNZGjs2UZXxGhBebTbgtj4HNF2tmHV9d0tn3HDn9FVgoFHcmTKq4TrZ7DmyRSnXIlTuOT+8mD7pfjDmModkZBagm546sEY3RFgup6zIUpk69JlCMrFgwKF3OVUI7o/Xicv0zm8ho+g0K0N3B/0sZk3Il4M3xZ7tNqeLzeRkuhPnW4+OUXGeaC5ccYFFrXeqTxUcq5bbbUrugSHV/sNqfBajVbmZIB
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99bab91-5235-4a8d-532d-08d7774707a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:45:24.9343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3U+JladbeA4/RPuG/64itXzy012xwJra3CQvW9NEpHTS8uw+TVFjSilKuozbU3KAwiGzsd0iCyL6u3OW3kBaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1757
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMCAqf8QMbwknanbTwp0Ic8hYo9ieLD9CmwnlMfqHWM=;
 b=yTCf6f5FFRnAOPfREsJ4sc+ysojGLv6cyjdS8hYuvvCKoGagJJUsxFhEa+SEZ41E47MAU1CLUpNaCqRpkNCgHcRM0al88IoztC2vHDgMj1kpwHGjWuJ9I5qVu0kCPjHQ1hMkVp8z7NDKfoNVRGm7/fp3prw+Q7A/bK8aqPTp4Vk=
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEhhd2tpbmcgWmhhbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDIsIDIwMTkgMTowNCBB
TQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWluLCBGcmFuayA8RnJhbmsu
TWluQGFtZC5jb20+Owo+IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIKPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KPiBDYzogWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMy8z
XSBkcm0vYW1kZ3B1OiBsb2FkIG5wIGZ3IHByaW9yIGJlZm9yZSBsb2FkaW5nIHRoZSBUQXMKPiAK
PiBQbGF0Zm9ybSBUQXMgd2lsbCBpbmRlcGVuZGVudGx5IHRvZ2dsZSBERiBDc3RhdGUuCj4gZm9y
IGluc3RhbmNlLCBnZXQvc2V0IHRvcG9sb2d5IGZyb20geGdtaSB0YS4gZG8gZXJyb3IgaW5qZWN0
aW9uIGZyb20gcmFzIHRhLiBJbgo+IHN1Y2ggY2FzZSwgUE1GVyBuZWVkcyB0byBiZSBsb2FkZWQg
YmVmb3JlIFRBcyBzbyB0aGF0IGFsbCB0aGUgc3Vic2VxdWVudAo+IENzdGF0ZSBjYWxscyByZWNp
ZXZlZCBieSBQU1AgRlcgY2FuIGJlIHJvdXRlZCB0byBQTUZXLgo+IAo+IENoYW5nZS1JZDogSTgz
ZGIxYTIyNTc3YTg0YWU2NDdlN2U1NzBjMjAwMDU3NjUwMDk2YzUKPiBTaWduZWQtb2ZmLWJ5OiBI
YXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CgoKUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDY2ICsrKysrKysrKysrKy0tLS0tLS0tLS0K
PiAtLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IGluZGV4IDBl
ODkwNzE3OWUwNy4uY2VlYTgzMTRkODhkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYwo+IEBAIC0xMjE4LDM5ICsxMjE4LDYgQEAgc3RhdGljIGludCBwc3BfaHdf
c3RhcnQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gIAkJcmV0dXJuIHJldDsKPiAgCX0KPiAK
PiAtCXJldCA9IHBzcF9hc2RfbG9hZChwc3ApOwo+IC0JaWYgKHJldCkgewo+IC0JCURSTV9FUlJP
UigiUFNQIGxvYWQgYXNkIGZhaWxlZCFcbiIpOwo+IC0JCXJldHVybiByZXQ7Cj4gLQl9Cj4gLQo+
IC0JaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKPiAtCQlyZXQg
PSBwc3BfeGdtaV9pbml0aWFsaXplKHBzcCk7Cj4gLQkJLyogV2FybmluZyB0aGUgWEdNSSBzZWVz
aW9uIGluaXRpYWxpemUgZmFpbHVyZQo+IC0JCSAqIEluc3RlYWQgb2Ygc3RvcCBkcml2ZXIgaW5p
dGlhbGl6YXRpb24KPiAtCQkgKi8KPiAtCQlpZiAocmV0KQo+IC0JCQlkZXZfZXJyKHBzcC0+YWRl
di0+ZGV2LAo+IC0JCQkJIlhHTUk6IEZhaWxlZCB0byBpbml0aWFsaXplIFhHTUkgc2Vzc2lvblxu
Iik7Cj4gLQl9Cj4gLQo+IC0JaWYgKHBzcC0+YWRldi0+cHNwLnRhX2Z3KSB7Cj4gLQkJcmV0ID0g
cHNwX3Jhc19pbml0aWFsaXplKHBzcCk7Cj4gLQkJaWYgKHJldCkKPiAtCQkJZGV2X2Vycihwc3At
PmFkZXYtPmRldiwKPiAtCQkJCQkiUkFTOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBSQVNcbiIpOwo+
IC0KPiAtCQlyZXQgPSBwc3BfaGRjcF9pbml0aWFsaXplKHBzcCk7Cj4gLQkJaWYgKHJldCkKPiAt
CQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKPiAtCQkJCSJIRENQOiBGYWlsZWQgdG8gaW5pdGlh
bGl6ZSBIRENQXG4iKTsKPiAtCj4gLQkJcmV0ID0gcHNwX2R0bV9pbml0aWFsaXplKHBzcCk7Cj4g
LQkJaWYgKHJldCkKPiAtCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKPiAtCQkJCSJEVE06IEZh
aWxlZCB0byBpbml0aWFsaXplIERUTVxuIik7Cj4gLQl9Cj4gLQo+ICAJcmV0dXJuIDA7Cj4gIH0K
PiAKPiBAQCAtMTU2MCw2ICsxNTI3LDM5IEBAIHN0YXRpYyBpbnQgcHNwX2xvYWRfZncoc3RydWN0
IGFtZGdwdV9kZXZpY2UKPiAqYWRldikKPiAgCWlmIChyZXQpCj4gIAkJZ290byBmYWlsZWQ7Cj4g
Cj4gKwlyZXQgPSBwc3BfYXNkX2xvYWQocHNwKTsKPiArCWlmIChyZXQpIHsKPiArCQlEUk1fRVJS
T1IoIlBTUCBsb2FkIGFzZCBmYWlsZWQhXG4iKTsKPiArCQlyZXR1cm4gcmV0Owo+ICsJfQo+ICsK
PiArCWlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7Cj4gKwkJcmV0
ID0gcHNwX3hnbWlfaW5pdGlhbGl6ZShwc3ApOwo+ICsJCS8qIFdhcm5pbmcgdGhlIFhHTUkgc2Vl
c2lvbiBpbml0aWFsaXplIGZhaWx1cmUKPiArCQkgKiBJbnN0ZWFkIG9mIHN0b3AgZHJpdmVyIGlu
aXRpYWxpemF0aW9uCj4gKwkJICovCj4gKwkJaWYgKHJldCkKPiArCQkJZGV2X2Vycihwc3AtPmFk
ZXYtPmRldiwKPiArCQkJCSJYR01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBYR01JIHNlc3Npb25c
biIpOwo+ICsJfQo+ICsKPiArCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgewo+ICsJCXJldCA9
IHBzcF9yYXNfaW5pdGlhbGl6ZShwc3ApOwo+ICsJCWlmIChyZXQpCj4gKwkJCWRldl9lcnIocHNw
LT5hZGV2LT5kZXYsCj4gKwkJCQkJIlJBUzogRmFpbGVkIHRvIGluaXRpYWxpemUgUkFTXG4iKTsK
PiArCj4gKwkJcmV0ID0gcHNwX2hkY3BfaW5pdGlhbGl6ZShwc3ApOwo+ICsJCWlmIChyZXQpCj4g
KwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCj4gKwkJCQkiSERDUDogRmFpbGVkIHRvIGluaXRp
YWxpemUgSERDUFxuIik7Cj4gKwo+ICsJCXJldCA9IHBzcF9kdG1faW5pdGlhbGl6ZShwc3ApOwo+
ICsJCWlmIChyZXQpCj4gKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCj4gKwkJCQkiRFRNOiBG
YWlsZWQgdG8gaW5pdGlhbGl6ZSBEVE1cbiIpOwo+ICsJfQo+ICsKPiAgCXJldHVybiAwOwo+IAo+
ICBmYWlsZWQ6Cj4gLS0KPiAyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
