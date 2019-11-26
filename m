Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD636C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 13:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EC42071E
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 13:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EC42071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BACA6E313;
	Tue, 26 Nov 2019 13:09:54 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790042.outbound.protection.outlook.com [40.107.79.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20866E313
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 13:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuaowbS6EmHaSPavglpSZkEE/RPiU1CZThrNAWJ5t+klEW5KFSu63VeLN86HN9uReUSgYmzqRWkE2nXjxKy+ScDroS1n424lECFkwvr0rYlENwfudT/0q5mXK+4dBzXgNA2yLpwnw0ZRoODK6QfjMUiiGnCdKmbZ9+uXqMdNyXI0DS+6dTr/ZhkFxmFJvs4JhnL4RdqCjX02sr6dR/VtXfgQUSkPbD3tHYqq2sVtTZCF2s+aSzpbYCl35oV3g86vGwQtlHlmUo7Dou8ZYJ7G9fDBRAHWsmLVvqzmqqygfV0MLzdBjrTvzKPwG+6o+NBm8vl9jCl8yp8bv5CyhhYYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV1BmEx4GurVdNBjp16PxgbosqOpXhREoxciY5RWXN8=;
 b=G8+1/gbtVWIc/uZAunwZBc70Ps2oGPu59fzm201XagmZraSNJg9vWZsNW30CiMIzK/msi+KYXV+m1eq7X5KJnBE2QYR+MwCVOwsKrjiYXOZSJUesmMYviGIAeJEPf7Wi5e8gQOf4c1baPAF5qZTPMW72a6kk1jVd09S5x2lNnHqS3Fvruy3+uAdbRr7yJbJGQKVs8X8jxn8hPXl3hwRzA9i2ooWZ3nlvkt2RIkmSCg6Kh0J6uOkNes7gdo8seeNLE4vg1KMO/Hnl2odMbIpPZhUQXw6lboRsIPsf8i+0vL7CgeOUysUN8XCEPVTZxX0akuHzRRXnvv80GSK1E2Acug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2SPR01MB0006.namprd12.prod.outlook.com (20.179.144.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 13:09:51 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:09:51 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: fix calltrace during kmd unload
Thread-Topic: [PATCH 5/5] drm/amdgpu: fix calltrace during kmd unload
Thread-Index: AQHVpE+9VL5hSXtN4U6/WOvxhiRHPqedbPNo
Date: Tue, 26 Nov 2019 13:09:51 +0000
Message-ID: <7D1BEE15-D37F-4821-9DFF-CC1DD258A2CB@amd.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>,
 <1574769024-30611-5-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1574769024-30611-5-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.97.201.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be53a965-60b1-44ba-d203-08d77271ec5a
x-ms-traffictypediagnostic: MN2SPR01MB0006:|MN2SPR01MB0006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2SPR01MB000669546C7505DC8D33C7B789450@MN2SPR01MB0006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(3846002)(66946007)(4326008)(5660300002)(86362001)(6116002)(478600001)(966005)(256004)(14444005)(6486002)(76176011)(71190400001)(71200400001)(186003)(6636002)(53546011)(7736002)(102836004)(6506007)(6512007)(45080400002)(26005)(6436002)(305945005)(6306002)(76116006)(91956017)(229853002)(37006003)(316002)(36756003)(11346002)(8936002)(6246003)(2616005)(81156014)(66476007)(66446008)(99286004)(66556008)(446003)(14454004)(64756008)(25786009)(2906002)(66066001)(6862004)(81166006)(8676002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2SPR01MB0006;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQHo5FH1fLyWTcXbZPwJvB3UbnXIIvEm+JAeu95W2Equ/N70XubC7PQDGS+Ip/xITSecOqpxgQkYsRmMF0sa5oPVZNnQVEzeYe0VuTm1wzMJHydc7X11CY0QSEDdJi6IJ62aYubK2yhcmDT1uVE2lvjlpWBa+2mMmmWQwKvNa1cwxHoljqUdr8e27o/7OBK8waKOSLn6UgeRXSjZjD++VT3mlG5d3qERi1k1RlNqDjSOfUTCNUzwYBw2i1hRAQyxRd8sMUfOj7LjXgYZgjWBw2rO4jSgYmRYYF9yNlCeD3WfdXsoc+TWUflTVfeaz8cTq6fcBXvKAPK/q7DexxyoD1gevo/rFj9Y6svuI+ob29d2IVkQd/MDzjD1J5+/DmIVCGbVQw0JndzYPGHn86elHLxKBnKIzcqY+baEQdiL6Q40phmiq8VO8/kpiydkYwQjlCV7df88nSxULjnFag2Cp0XwdnoSDBZHX+o5fLhVoQI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be53a965-60b1-44ba-d203-08d77271ec5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 13:09:51.7211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L2QVpKkPRki9Cjvu9b7RmJgeYShThBplWsf6fSZLe7uvHZzCXAHFEavzSUfHxoI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV1BmEx4GurVdNBjp16PxgbosqOpXhREoxciY5RWXN8=;
 b=hqU2IFGGSjJvDE9XxREsIs0jQkZaeekpvowWThGYanNEWhjd0Szm8+dvrNPiroKsTfH5YX9sb6X7Dp0AqlPXkJnQEPMfPkqSlhpw1lms2+x8lcXtm9cIhbkd3sSS95oSeNN59bNfAVFBpUB1Fi8QgeR2XcwZc9xQEXYZzjm2HS4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126130951.ih1_rVqmMGZfNNfItEVH-XSls7T-rcialLPTCyCEr0M@z>

SGkgTW9uaywKCmh3X2ZpbmkoKSBpcyBjYWxsZWQgaW4gc3VzcGVuZCBjb2RlIHBhdGggYXMgd2Vs
bC4gSSdtIHdvbmRlcmluZyBob3cgY3NiIGNhbiBiZSBldmljdGVkIGlmIGl0J3Mgbm90IHVucGlu
ZWQgYmVmb3JlIHN1c3BlbmQuCgpCUiwKWGlhb2ppZQoKPiBPbiBOb3YgMjYsIDIwMTksIGF0IDc6
NTAgUE0sIE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPiB3cm90ZToKPiAKPiBrZXJuZWwgd291
bGQgcmVwb3J0IGEgd2FybmluZyBvbiBkb3VibGUgdW5waW4KPiBvbiB0aGUgY3NiIEJPIGJlY2F1
c2Ugd2UgdW5waW4gaXQgZHVyaW5nIGh3X2ZpbmkKPiBidXQgYWN0dWFsbHkgd2UgZG9uJ3QgbmVl
ZCB0byBwaW4vdW5waW4gaXQgZHVyaW5nCj4gaHdfaW5pdC9maW5pIHNpbmNlIGl0IGlzIGNyZWF0
ZWQgd2l0aCBrZXJuZWwgcGlubmVkCj4gCj4gcmVtb3ZlIGFsbCB0aG9zZSB1c2VsZXNzIGNvZGUg
Zm9yIGdmeDkvMTAKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNv
bT4KPiAtLS0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmxjLmMgfCAgMSAt
Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgIHwgMzggLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jICAgfCAzOSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAzIGZpbGVz
IGNoYW5nZWQsIDc4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmxjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmxjLmMKPiBpbmRleCBjODc5M2U2Li4yODlmYWRhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ybGMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9ybGMuYwo+IEBAIC0xNDUsNyArMTQ1LDYgQEAgaW50IGFtZGdw
dV9nZnhfcmxjX2luaXRfY3NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgIGRzdF9w
dHIgPSBhZGV2LT5nZngucmxjLmNzX3B0cjsKPiAgICBhZGV2LT5nZngucmxjLmZ1bmNzLT5nZXRf
Y3NiX2J1ZmZlcihhZGV2LCBkc3RfcHRyKTsKPiAgICBhbWRncHVfYm9fa3VubWFwKGFkZXYtPmdm
eC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKPiAtICAgIGFtZGdwdV9ib191bnBpbihhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX29iaik7Cj4gICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX29iaik7Cj4gCj4gICAgcmV0dXJuIDA7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBpbmRleCBhNTZjYmE5Li41ZWU3NDY3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBAQCAtOTk2LDM5ICs5OTYsNiBAQCBz
dGF0aWMgaW50IGdmeF92MTBfMF9ybGNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgICByZXR1cm4gMDsKPiB9Cj4gCj4gLXN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2NzYl92cmFtX3Bp
bihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAtewo+IC0gICAgaW50IHI7Cj4gLQo+IC0g
ICAgciA9IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqLCBm
YWxzZSk7Cj4gLSAgICBpZiAodW5saWtlbHkociAhPSAwKSkKPiAtICAgICAgICByZXR1cm4gcjsK
PiAtCj4gLSAgICByID0gYW1kZ3B1X2JvX3BpbihhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29i
aiwKPiAtICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSk7Cj4gLSAgICBpZiAoIXIp
Cj4gLSAgICAgICAgYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciA9Cj4gLSAgICAg
ICAgICAgIGFtZGdwdV9ib19ncHVfb2Zmc2V0KGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2Jq
KTsKPiAtCj4gLSAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3Rh
dGVfb2JqKTsKPiAtCj4gLSAgICByZXR1cm4gcjsKPiAtfQo+IC0KPiAtc3RhdGljIHZvaWQgZ2Z4
X3YxMF8wX2NzYl92cmFtX3VucGluKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+IC17Cj4g
LSAgICBpbnQgcjsKPiAtCj4gLSAgICBpZiAoIWFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2Jq
KQo+IC0gICAgICAgIHJldHVybjsKPiAtCj4gLSAgICByID0gYW1kZ3B1X2JvX3Jlc2VydmUoYWRl
di0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosIHRydWUpOwo+IC0gICAgaWYgKGxpa2VseShyID09
IDApKSB7Cj4gLSAgICAgICAgYW1kZ3B1X2JvX3VucGluKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3Rh
dGVfb2JqKTsKPiAtICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xl
YXJfc3RhdGVfb2JqKTsKPiAtICAgIH0KPiAtfQo+IC0KPiBzdGF0aWMgdm9pZCBnZnhfdjEwXzBf
bWVjX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gewo+ICAgIGFtZGdwdV9ib19m
cmVlX2tlcm5lbCgmYWRldi0+Z2Z4Lm1lYy5ocGRfZW9wX29iaiwgTlVMTCwgTlVMTCk7Cj4gQEAg
LTM3ODAsMTAgKzM3NDcsNiBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9od19pbml0KHZvaWQgKmhh
bmRsZSkKPiAgICBpbnQgcjsKPiAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPiAKPiAtICAgIHIgPSBnZnhfdjEwXzBfY3NiX3Zy
YW1fcGluKGFkZXYpOwo+IC0gICAgaWYgKHIpCj4gLSAgICAgICAgcmV0dXJuIHI7Cj4gLQo+ICAg
IGlmICghYW1kZ3B1X2VtdV9tb2RlKQo+ICAgICAgICBnZnhfdjEwXzBfaW5pdF9nb2xkZW5fcmVn
aXN0ZXJzKGFkZXYpOwo+IAo+IEBAIC0zODcxLDcgKzM4MzQsNiBAQCBzdGF0aWMgaW50IGdmeF92
MTBfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKPiAgICB9Cj4gICAgZ2Z4X3YxMF8wX2NwX2VuYWJs
ZShhZGV2LCBmYWxzZSk7Cj4gICAgZ2Z4X3YxMF8wX2VuYWJsZV9ndWlfaWRsZV9pbnRlcnJ1cHQo
YWRldiwgZmFsc2UpOwo+IC0gICAgZ2Z4X3YxMF8wX2NzYl92cmFtX3VucGluKGFkZXYpOwo+IAo+
ICAgIHJldHVybiAwOwo+IH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBp
bmRleCA0Y2MyZTUwLi41MjRhN2JhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jCj4gQEAgLTE2ODMsMzkgKzE2ODMsNiBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3JsY19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgIHJldHVybiAwOwo+IH0KPiAKPiAt
c3RhdGljIGludCBnZnhfdjlfMF9jc2JfdnJhbV9waW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCj4gLXsKPiAtICAgIGludCByOwo+IC0KPiAtICAgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZShh
ZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaiwgZmFsc2UpOwo+IC0gICAgaWYgKHVubGlrZWx5
KHIgIT0gMCkpCj4gLSAgICAgICAgcmV0dXJuIHI7Cj4gLQo+IC0gICAgciA9IGFtZGdwdV9ib19w
aW4oYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosCj4gLSAgICAgICAgICAgIEFNREdQVV9H
RU1fRE9NQUlOX1ZSQU0pOwo+IC0gICAgaWYgKCFyKQo+IC0gICAgICAgIGFkZXYtPmdmeC5ybGMu
Y2xlYXJfc3RhdGVfZ3B1X2FkZHIgPQo+IC0gICAgICAgICAgICBhbWRncHVfYm9fZ3B1X29mZnNl
dChhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7Cj4gLQo+IC0gICAgYW1kZ3B1X2JvX3Vu
cmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7Cj4gLQo+IC0gICAgcmV0dXJu
IHI7Cj4gLX0KPiAtCj4gLXN0YXRpYyB2b2lkIGdmeF92OV8wX2NzYl92cmFtX3VucGluKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+IC17Cj4gLSAgICBpbnQgcjsKPiAtCj4gLSAgICBpZiAo
IWFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKQo+IC0gICAgICAgIHJldHVybjsKPiAtCj4g
LSAgICByID0gYW1kZ3B1X2JvX3Jlc2VydmUoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmos
IHRydWUpOwo+IC0gICAgaWYgKGxpa2VseShyID09IDApKSB7Cj4gLSAgICAgICAgYW1kZ3B1X2Jv
X3VucGluKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKPiAtICAgICAgICBhbWRncHVf
Ym9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKPiAtICAgIH0KPiAt
fQo+IC0KPiBzdGF0aWMgdm9pZCBnZnhfdjlfMF9tZWNfZmluaShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiB7Cj4gICAgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nZngubWVjLmhw
ZF9lb3Bfb2JqLCBOVUxMLCBOVUxMKTsKPiBAQCAtMzY5NCwxMCArMzY2MSw2IEBAIHN0YXRpYyBp
bnQgZ2Z4X3Y5XzBfaHdfaW5pdCh2b2lkICpoYW5kbGUpCj4gCj4gICAgZ2Z4X3Y5XzBfY29uc3Rh
bnRzX2luaXQoYWRldik7Cj4gCj4gLSAgICByID0gZ2Z4X3Y5XzBfY3NiX3ZyYW1fcGluKGFkZXYp
Owo+IC0gICAgaWYgKHIpCj4gLSAgICAgICAgcmV0dXJuIHI7Cj4gLQo+ICAgIHIgPSBhZGV2LT5n
ZngucmxjLmZ1bmNzLT5yZXN1bWUoYWRldik7Cj4gICAgaWYgKHIpCj4gICAgICAgIHJldHVybiBy
Owo+IEBAIC0zNzc5LDggKzM3NDIsNiBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2h3X2Zpbmkodm9p
ZCAqaGFuZGxlKQo+ICAgIGdmeF92OV8wX2NwX2VuYWJsZShhZGV2LCBmYWxzZSk7Cj4gICAgYWRl
di0+Z2Z4LnJsYy5mdW5jcy0+c3RvcChhZGV2KTsKPiAKPiAtICAgIGdmeF92OV8wX2NzYl92cmFt
X3VucGluKGFkZXYpOwo+IC0KPiAgICByZXR1cm4gMDsKPiB9Cj4gCj4gLS0gCj4gMi43LjQKPiAK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFt
cDtkYXRhPTAyJTdDMDElN0NYaWFvamllLll1YW4lNDBhbWQuY29tJTdDNjVlMTYyZTUwOWVhNGE5
MGY3OTMwOGQ3NzI2NmRlNjUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAl
N0MwJTdDNjM3MTAzNjU4NDY0NTEyNzUxJmFtcDtzZGF0YT1yNWZwaWQ1SXNQOGFuemclMkZaSVlI
bjBOOHhjZUJ2RzdydFJHODAlMkI3ODY4byUzRCZhbXA7cmVzZXJ2ZWQ9MApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
