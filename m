Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54981C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316CC215A5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316CC215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C5B6E894;
	Fri, 29 Nov 2019 09:16:48 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE506E894
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddR1U/iBA827HCib0QxtrD/UVBahUfmEnKth5fcajgGkbbhxEYOnfAAd+s89bBYkQ4/pGTNY+bRJIip6sDo93vU3M5RsFLEnlF6rLOfGicStTIwnoENc3/mSA2RGtdITaGsQPjgivdAFWUgN+OUm/z+lgFoBXkD6Oo+HvgTIWL/S+XbNIjSBa7kvF7HTq7by0K1C7JMu8mIFqcHkGwhBy/r+orQ3gSWPzCtoh+mQyVKyfIBT2Hyob1n5r+jU5YmsGJ2NaEPw6/Cp4N1YujpQFY4EMklOnRobzz9SYbS8f7W7oMyiY7SSO42xGMrN5LqUu9/gBs0NMF3sXzTq7MMj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8UmxYlIX1OK3OkVrFSjDcCl6fQmzz6KtCMEkmyZBpU=;
 b=fF3iMsATprewN9gbY9uMbS0NkBCbOoBqNcDEd29XXo1OtpZ/thy3es2zU6+/CuLAgISlPudll5T7VausLUqHTgr9baFStlwt69DplOlNra7F3Q/fKIN34Oh1cBIaWGbW2HAyoz9wJR8+IaqmdQOQLwZoTpdsqPdCVToRckfR0HnoYrrp2v+fCJo2u9HPr4mkw/XSWBirDuwyniTh8oMTg6Kko8SaNhKCQ3/PRUUbJnElkFKuUbCuYMg2fPlImPdVkXq2Mp13RfwsgyDHGUTYJ+q/L5zi+x1sJAK6l8ZcJuJ9C8vyoFIQ5gmy4rDWxz9nqGwqX1ECbFed5zwM6MtA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3246.namprd12.prod.outlook.com (20.179.81.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Fri, 29 Nov 2019 09:16:45 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:16:45 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: should stop GFX ring in hw_fini
Thread-Topic: [PATCH] drm/amdgpu: should stop GFX ring in hw_fini
Thread-Index: AQHVpo7bNYNK1SwUE0643Mlt10vksqeh3F8AgAAB7CA=
Date: Fri, 29 Nov 2019 09:16:45 +0000
Message-ID: <MN2PR12MB3933DD065B4C377DD9D70A1784460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1575016052-26775-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418A01DA8C20B50AFE7E64DFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418A01DA8C20B50AFE7E64DFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-29T09:09:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fbbc44b8-75d4-428b-b58c-0000dc1219d7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42261cad-9817-4cdc-fa86-08d774acdb0c
x-ms-traffictypediagnostic: MN2PR12MB3246:|MN2PR12MB3246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3246565DC692334292D568EF84460@MN2PR12MB3246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(13464003)(199004)(189003)(446003)(9686003)(71200400001)(102836004)(8936002)(8676002)(55016002)(6306002)(186003)(52536014)(26005)(2906002)(81166006)(45080400002)(99286004)(5660300002)(14454004)(81156014)(66066001)(53546011)(71190400001)(6506007)(64756008)(229853002)(3846002)(76116006)(6246003)(66476007)(6116002)(66946007)(110136005)(74316002)(33656002)(316002)(11346002)(25786009)(256004)(7696005)(76176011)(305945005)(7736002)(2501003)(478600001)(966005)(86362001)(66446008)(6436002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3246;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhrF28wt5KSXW+4ClDHYSc8dwbiPkG+CeHK1Y5uMsxoJMLL+21O8nv3kuYlPAwcdp5u6yiB2hLgkoo0jqtcZ6QNC26cjjN+grYwVY3a6xiC2+/daX+bLOzmd1vWQ4glg6I9uCbVgRHRbLmUo0gwo1z7anLNKvG/jWhvDPBCqBzUnwcoXv7NdsLLx0ELuwzCb5YhFssyN7AC7ZDuo7bPoPgr02/doNAiPt7XbikAcA0gV8I4H/k3Ms7znS3B0fln0qIdcNdff0NdX7CZXjrE3uexjM2haACzlKXhjMxJLdJqYeyM3EI2Ukzm0WRzKPV8+MZ5EoZh4+3ChrMsll19FWsPQyPQza0xX8MUxQcqtgpPI3NezaOhAc1puAZxmnlDdnUF+hMQKgXOjHaYvsVWpetW+m7n7uQ0F4UMVTRpSnoihvj3rFLjQqmaPXDlHLgfbqnbUXnyvXGUSn/fooR9osHYxLUEmlhL+WTiWkr4O6Jo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42261cad-9817-4cdc-fa86-08d774acdb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:16:45.3302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2KphfDq3nCAyutMRvUaDtE7qypUSTf8OmEI/iDLa+cXgLakAoZ1CqBaQBeALNMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8UmxYlIX1OK3OkVrFSjDcCl6fQmzz6KtCMEkmyZBpU=;
 b=IHyttLIL8HWmGR5yPbIeg3JP9AomV4X99y/nftSWCCJ7rX8ivb5+j1EL4WM9fWnjuLwhXkiSGIv6B5Cg9TTauqLN0S9UUcryOZRxLVTyJj9kt6oRRCmLmwghMhpOwlHL5HFrCH6uRWkvGTtJoxoA6iQdsvLrmIcNxeZWwggaoAk=
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

b2theQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxH
UFUgVmlydHVhbGl6YXRpb24gVGVhbSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+IA0KU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAyOSwgMjAxOSA1OjEwIFBNDQpUbzogTGl1LCBNb25rIDxNb25rLkxp
dUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIE1vbmsg
PE1vbmsuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBzaG91
bGQgc3RvcCBHRlggcmluZyBpbiBod19maW5pDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJ
bnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KVGhlIGRlYnVnIG1lc3NhZ2UgYWZ0ZXIgZ2Z4
IGRpc2FibGVtZW50IGFjdHVhbGx5IG1ha2VzIG1lIGNvbmZ1c2luZywgd291bGQgeW91IG1pbmQg
dG8gZHJvcCB0aGF0Lg0KT3RoZXIgdGhhbiB0aGF0LCB0aGUgcGF0Y2ggaXMNCg0KUmV2aWV3ZWQt
Ynk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCkhh
d2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTW9uayBMaXUNClNl
bnQ6IDIwMTnlubQxMeaciDI55pelIDE2OjI4DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IHNob3VsZCBzdG9wIEdGWCByaW5nIGluIGh3X2ZpbmkNCg0KVG8gYWxpZ24g
d2l0aCB0aGUgc2NoZW1lIGZyb20gZ2Z4OQ0KDQpkaXNhYmxpbmcgR0ZYIHJpbmcgYWZ0ZXIgVk0g
c2h1dGRvd24gY291bGQgYXZvaWQgZ2FyYmFnZSBkYXRhIGJlIGZldGNoZWQgdG8gR0ZYIFJCIHdo
aWNoIG1heSBsZWFkIHRvIHVubmVjZXNzYXJ5IHNjcmV3IHVwIG9uIEdGWA0KDQpTaWduZWQtb2Zm
LWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQppbmRleCAyMzBlOGFm
Li44ODJjZjFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQpAQCAt
MzgwOSw2ICszODA5LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfaHdfZmluaSh2b2lkICpoYW5k
bGUpDQogCWlmIChhbWRncHVfZ2Z4X2Rpc2FibGVfa2NxKGFkZXYpKQ0KIAkJRFJNX0VSUk9SKCJL
Q1EgZGlzYWJsZSBmYWlsZWRcbiIpOw0KIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQor
CQlnZnhfdjEwXzBfY3BfZ2Z4X2VuYWJsZShhZGV2LCBmYWxzZSk7DQogCQlwcl9kZWJ1ZygiRm9y
IFNSSU9WIGNsaWVudCwgc2hvdWxkbid0IGRvIGFueXRoaW5nLlxuIik7DQogCQlyZXR1cm4gMDsN
CiAJfQ0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2hhd2tpbmcuemhhbmclNDBhbWQuY29tJTdD
NWE4MDk4NmQyYTA0NGY4NzBiODcwOGQ3NzRhNWZmYjklN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTA2MTI4NjkwNTM4OTQ4JmFtcDtzZGF0YT1WbDZBdnNC
RjJuQTdzYzNlWURqMGdWeTJKa2ZoSGdWMkpvNzhMd21nU1NNJTNEJmFtcDtyZXNlcnZlZD0wDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
