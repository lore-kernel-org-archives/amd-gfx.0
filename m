Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F33FC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BA121721
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BA121721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03D46E02F;
	Fri, 29 Nov 2019 08:46:43 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740055.outbound.protection.outlook.com [40.107.74.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514B06E02F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfMY9fYR5JO6tO7hWSFUqoawmRAZHEZD1gXCFJ8P/4+tOjKxe7Bgs2EGU7zU/VgXv3Z9xsRQ/PT0+BkcoQ8W0hs20G1ywPJqWfsAdAsy5PK9pDRQYtAoxk4yw916jfalfEW83grV0CTdUPeBLDbopyheSytoZjtQFzTRU9HAC088Ts+nbeKM84Lm5zpIBoj7SYK3/rn1lZ5bTf0R8bqJd3HbBX43OjJKypVFHA0B/+k7LZGKfJnJxsmhl33GoQ8OiZLBaQfInSd3s3HIS4QcVN97kDWpk8COkQq63r9x5NKOPFPokYWSaGBzxhq5S91236wYrNBxH9mLNRBYTeKErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVcg3bsZzhFoD24gUwfpfriT7NgLKH7z1T6lY5/RwcI=;
 b=Dcc3UaxdKRrU8F51Ltr9xo0mMimKdpPFYorsjJygDDWVg7sIpelpvSOJ2LxDuUcad1JRuiqi/sY42PpgMKrv0/AuWOLKk1cEFgOPzH6zy6RiKyucqiVO9gRGov9b560RqOhcpCXgMENNXYnUaJn0WKpqwV1T6cQNO92QZH/zrG/vgJEteQY4uOLpx0JGmq7xhFQo14Bv0kZhtbZMR2FhtUMqftugUAJgYB7ZpcW0ed50zxwdcBE0tILwtM8hPfipYmzUK6t4iN1xrhE1rRFznoK4D7Tkxuj1iStqMb0zTyZ17qYisHh6w3+WdHADlTzlS0aWt3ogA+GnFm1jA1W+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3757.namprd12.prod.outlook.com (10.255.86.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 29 Nov 2019 08:46:40 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 08:46:40 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Index: AQHVpo5MI8MlYXFVxEaZ238/KW/rXaeh1OYAgAAAgWA=
Date: Fri, 29 Nov 2019 08:46:40 +0000
Message-ID: <MN2PR12MB39330EA36530757CE5F3D0B784460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418C0672D65E71D75E039DDFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418C0672D65E71D75E039DDFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-29T08:42:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=35f992a8-ce68-4de1-928c-0000be5751a9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9706db2f-a53c-479a-96f6-08d774a8a709
x-ms-traffictypediagnostic: MN2PR12MB3757:|MN2PR12MB3757:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37574F08C008C8E10D7F532E84460@MN2PR12MB3757.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(13464003)(8936002)(55016002)(6436002)(6306002)(3846002)(9686003)(6116002)(966005)(33656002)(14454004)(2906002)(25786009)(229853002)(2501003)(66556008)(45080400002)(7696005)(478600001)(8676002)(81156014)(81166006)(66476007)(6506007)(446003)(66446008)(64756008)(11346002)(186003)(26005)(53546011)(76176011)(66066001)(102836004)(6246003)(256004)(76116006)(66946007)(71200400001)(71190400001)(74316002)(52536014)(7736002)(99286004)(305945005)(316002)(110136005)(86362001)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3757;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +troTxoYYJ2LLZrKdkRZbxPzOEWZHyinfmT5NIM9v8EkeB07t/1EB3T59r0XQWFd1bHVRsgSrv/MjwArNc2csR+Mz64jocIhac1+XSbl8L/7zg+NDqf52XCpSOXY6iL3eGj+inj3mHLhuvoILte8i2OMx+ZeftVAcfQlEHMXd2JLXqjPyu7jJ20YrKtJKzEVV84WUx+xq0gAD4oD+UlU2BJcgfaVUV6utOpz9sPmXY1fJy4rWZ+Ri/nQJDHMFp2BCtsh4njiRr/dYJwZB8hG7dqNVg5yt+Cyi1MH+sE5jZTizLxS71aYwVHgAhtwJ3DyRFKS9JIZ8Zt3EA5mlG+A0aX5XnsppwLL9OGywiEwHIaClM45VFKPOIJqKtwZHUu7vxyfdeTABpcXpSmsYk/L0KKB5426cezx9QRVJyfXRwwc1KbPXo+CxRI4v1IwaNRblMYOViuV4M/0HpHTlkBfcIj/FxW8zMhVzgO55/16g4Y=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9706db2f-a53c-479a-96f6-08d774a8a709
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:46:40.1006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwVoeCBBruBreoVz5jM08+KjBERueXn7mAFo6LzqV1WY1DL9cHFgz5o2C2YDgAvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVcg3bsZzhFoD24gUwfpfriT7NgLKH7z1T6lY5/RwcI=;
 b=eR9BIK8vdi8FiD/8XAWO4XfxqTQrHVQyXaTikSAwvhsTK/4Wy2hsJ9gb9OK+4CZBfN4X+CjTHAT+gxWRFPzHXjSpxzTtzfv/e0pbZEWL90lOwGaW9AqRJfR73j9rDFbuh5bE6Ot5KosB9NZ5oH57pxV2wrnBLI7HwfkRqLPlDPg=
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

Rm9yIG5vdyBpbml0X3BnKCkgaXMgZ29vZCBlbm91Z2ggZm9yIGJhcmUtbWV0YWwgYW5kIFNSLUlP
ViwgYnV0IGNoZWNrb3V0IEdGWDksIHRoZXJlIGFyZSBtb3JlIGpvYnMgaW4gaW5pdF9wZygpLCBz
byBpbiB0aGUgZnV0dXJlIEknZCBleHBlY3QgdGhlcmUgd2lsbCBiZSANCk1vcmUgbGluZXMgY29t
ZSBpbnRvIGluaXRfcGcoKSBvbiBnZngxMCBhbmQgYnkgdGhhdCB0aW1lIEkgbmVlZCB0byBtb2Rp
ZnkgaW5pdF9wZygpICwgDQoNClNvIElNSE8gdGhlIGJlc3Qgd2F5IGlzIHVzZSBpbml0X2NzYigp
IGZyb20gdGhlIGJlZ2lubmluZyANCg0KVGhhbmtzIA0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjksIDIwMTkgNDo0MyBQ
TQ0KVG86IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpDYzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPg0KU3ViamVjdDogUkU6
IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBHRlgxMCBtaXNzaW5nIENTSUIgc2V0DQoNCltB
TUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KSSBk
b24ndCB0aGluayB5b3UgbmVlZCB0byBpbnRyb2R1Y2UgU1JJT1Ygc3BlY2lmaWMgcGF0aCBoZXJl
LiBUaGUgZ2Z4X3YxMF8wX2luaXRfcGcgc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvIGNvdmVyIGJv
dGggYmFyZS1tZXRhbCBhbmQgdmlydHVhbGl6YXRpb24gY2FzZS4gDQoNCllvdSBjYW4gZHJvcCB0
aGUgdGxiIGZsdXNoIGluIHRoYXQgZnVuY3Rpb24gaWYgdGhhdCdzIHlvdXIgbWFqb3IgY29uY2Vy
bi4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhh
bGYgT2YgTW9uayBMaXUNClNlbnQ6IDIwMTnlubQxMeaciDI55pelIDE2OjI0DQpUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBmaXggR0ZYMTAgbWlzc2luZyBDU0lC
IHNldA0KDQpzdGlsbCBuZWVkIHRvIGluaXQgY3NiIGV2ZW4gZm9yIFNSSU9WDQoNClNpZ25lZC1v
ZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCA4ICsrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMNCmluZGV4IDc0ZWRmZDkuLjIzMGU4YWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC0xODc0LDE0ICsxODc0LDE2IEBAIHN0YXRpYyBpbnQg
Z2Z4X3YxMF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpICB7DQogCWlu
dCByOw0KIA0KLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KLQkJcmV0dXJuIDA7DQotDQog
CWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSB7DQog
CQlyID0gZ2Z4X3YxMF8wX3dhaXRfZm9yX3JsY19hdXRvbG9hZF9jb21wbGV0ZShhZGV2KTsNCiAJ
CWlmIChyKQ0KIAkJCXJldHVybiByOw0KIA0KKwkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkg
ew0KKwkJCWdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsNCisJCQlyZXR1cm4gMDsNCisJCX0NCisN
CiAJCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCiAJCWlmIChyKQ0KIAkJCXJldHVybiBy
Ow0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2hhd2tpbmcuemhhbmclNDBhbWQuY29tJTdDYzM0
M2FmYTlhYTIzNGNiYjgyNzUwOGQ3NzRhNTcyNjglN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5
OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTA2MTI3Mjc3MzUzMDg2JmFtcDtzZGF0YT1LdCUyRmQxNjgw
UmMzbHlGd3o0bmc1ZUE3SnhpWVdqZjF3aERCcGZuSHpUSnMlM0QmYW1wO3Jlc2VydmVkPTANCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
