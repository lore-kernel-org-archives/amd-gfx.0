Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C5C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235B8215F1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235B8215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CEC89117;
	Fri, 29 Nov 2019 09:07:34 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42318902B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+EEgtFtN8XvSFSGIIrkMuQhpbwP0R0yW0xp6fUKh5OUBurvp0NRPaIFHtKC39Y0HNRmG0db7qC5iaCH72CmtE+AVG73EPTgdoAnAN6NPKJ5IrbPTwmTsKOslyDS6wc836b6i2LNCfiHst6z99fKO0sZu2vC5ghoVdrd47/ZmkMsVRp/KJhGU6ENUt9axG3/Vl2YC04E70d3gS1bQYEWselcxmQXYKAMroYp57C6gwvRmX2LwWTgaJAz5bDwj5ne69alURrI2mh5zSxOrkMRv5rb3F84r5yeEulZA/W9GWbEZ+FWOHM5ErH+77W/H+sOnvtvF+hFmxtQFqRc2rh8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8kcMgm7LsZxf3ZqWONzlfJ79En9kZiNOoMV6zB1rtE=;
 b=DDLByi3pVi/Nt7UwPckFBY3/qmsph3k+H6bAYMqH5abRnSjFzczhKrC7OFTjs9S3qji2p5UO2sFMo6WIfCMDxGbUYvG5gKErTdBNnAPC7sahzvW1k9zd27nJ54AST2sB9dbFcAKry7+lOIxJ1T4tXDqYZ4C/Tisj3QfUy9l/Yb0t8bmnOe5PbH/sa22sfzNYITPgd8VfbjqZohC0nCIFKcIZPR0fpxQ5Cr6UmBFxXszuqyKNfbe8O9T/SU65KKTrAsKjVol3nkJe7HqtPBzShqlZVv/m4ZEV/f/ciCdxY2lR3P2EaoaEg2p6Wdb2tSIHNlg22N2TeG+E8yHuXfPXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 29 Nov 2019 09:07:31 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:07:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Index: AQHVpo6OZhUrafAMD0WsHkOCG51Braeh0m+ggAADfACAAANRsA==
Date: Fri, 29 Nov 2019 09:07:31 +0000
Message-ID: <DM5PR12MB1418A6FEA53EDF93DCB472EFFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418C0672D65E71D75E039DDFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB39330EA36530757CE5F3D0B784460@MN2PR12MB3933.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB39330EA36530757CE5F3D0B784460@MN2PR12MB3933.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-29T09:07:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b4ea8d3e-70d3-4c16-8c5e-000000f663d9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7936d2b-9823-4363-63cc-08d774ab90ea
x-ms-traffictypediagnostic: DM5PR12MB1145:|DM5PR12MB1145:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1145749257F83FE37042BA69FC460@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(13464003)(189003)(199004)(5660300002)(256004)(71190400001)(8936002)(2501003)(66066001)(25786009)(446003)(74316002)(7736002)(52536014)(305945005)(229853002)(71200400001)(11346002)(26005)(8676002)(6506007)(53546011)(186003)(966005)(2906002)(99286004)(316002)(3846002)(6116002)(6436002)(7696005)(76176011)(9686003)(76116006)(110136005)(478600001)(66446008)(6246003)(102836004)(6306002)(33656002)(86362001)(66946007)(81156014)(66476007)(81166006)(64756008)(66556008)(45080400002)(14454004)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2XQiL/D59PzIcpghw72xTvApft3M2Zbu1ZIxTBcHag/FEypF+RKfEewGDcz65TGLOQzVyV65WcTlYVsC8wb1plTsVvjyANonvzob5ZSRqNaDQlS1Xh5Kpkzw+PxucA9H1tRMlAUYW3kY6Gd5GgQEEpWfqUA7LFw+rsrD065ZEp+cmhu0uVYVEPcU/GO7Z3nz9bQVLqLDGOB8MvC7OxM5pWtYrZcz2YSMyudGPGRw7QqOVEg6VZKgLnbUuzdxEvgTLhmYQXH5/Bz8kRTR33ryakMbkbjyZoDvVosDsua6elMnwWeNJSQdD9wUhEtZB4Q/vxqobquyZ9/OG2wcQWgCLGyidpwD3z3GhGEQ6vM8W4U4TEZM78JwhbBkYxERRz47+76lWeewhFYmIH7jmVtN3SOfDhJmBn33nlKkjMj8C6gkO073zavGioPasnG7dZUg8Q1pm2P4FFImJISKKBHO6Q7uI+Ojzp9JtZPp+WS81I=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7936d2b-9823-4363-63cc-08d774ab90ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:07:31.4544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HCijmHP13HUDnJ6njvCc+r9C1kiOssq+56RUhzRI+tbQz1ZXBtoRXqqSNw5rgDQTWg1CCi2I1kOhm6aJMHBvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8kcMgm7LsZxf3ZqWONzlfJ79En9kZiNOoMV6zB1rtE=;
 b=ssEzXeGysuL1bYDcquz28iXYCm6inTtO/Q9ct+g98jiIre6ytkLcDirySyXxK4Vhow+0aO4Rp0/aCI77Q1ToF6YpMOhz+RLzNmGsT5/NleSNUR31Gz3LGzal4bluq5flQ/xG8DhHUxH4kMfNSUlmceLH1r+fx5xT8FWcVii1iqs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgZ2Z4MTAgUEcgYW5kIGdmeG9mZiBhcmUgZnVsbHkgY29udHJvbGxlZCBieSBSTEMgYW5kIFNN
VSBmdyBhbmQgZG9uJ3QgbmVlZCBkcml2ZXIgdG8gYmUgaW52b2x2ZWQgYW55bW9yZS4gU28gdGhl
IGxlZ2FjeSBwcm9ncmFtaW5nIGZvciBnZnhfaWRsZV90aHJlc2hvbGQuZXRjIHdpbGwgbm90IGJl
IGFwcGxpZWQgdG8gZ2Z4MTAuIA0KDQpNb3JlIGFnZ3Jlc3NpdmVseSwgbGV0J3MgZHJvcCBnZnhf
djEwXzBfaW5pdF9wZyBhbmQganVzdCBpbml0IGNzYi4gDQoNClJlZ2FyZHMsDQpIYXdraW5nDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQu
Y29tPiANClNlbnQ6IDIwMTnlubQxMeaciDI55pelIDE2OjQ3DQpUbzogWmhhbmcsIEhhd2tpbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogZml4IEdGWDEwIG1pc3NpbmcgQ1NJ
QiBzZXQNCg0KRm9yIG5vdyBpbml0X3BnKCkgaXMgZ29vZCBlbm91Z2ggZm9yIGJhcmUtbWV0YWwg
YW5kIFNSLUlPViwgYnV0IGNoZWNrb3V0IEdGWDksIHRoZXJlIGFyZSBtb3JlIGpvYnMgaW4gaW5p
dF9wZygpLCBzbyBpbiB0aGUgZnV0dXJlIEknZCBleHBlY3QgdGhlcmUgd2lsbCBiZSBNb3JlIGxp
bmVzIGNvbWUgaW50byBpbml0X3BnKCkgb24gZ2Z4MTAgYW5kIGJ5IHRoYXQgdGltZSBJIG5lZWQg
dG8gbW9kaWZ5IGluaXRfcGcoKSAsIA0KDQpTbyBJTUhPIHRoZSBiZXN0IHdheSBpcyB1c2UgaW5p
dF9jc2IoKSBmcm9tIHRoZSBiZWdpbm5pbmcgDQoNClRoYW5rcw0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFN
RA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjksIDIwMTkg
NDo0MyBQTQ0KVG86IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPg0KU3ViamVj
dDogUkU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBHRlgxMCBtaXNzaW5nIENTSUIgc2V0
DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBpbnRyb2R1Y2UgU1JJT1Ygc3BlY2lmaWMgcGF0
aCBoZXJlLiBUaGUgZ2Z4X3YxMF8wX2luaXRfcGcgc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvIGNv
dmVyIGJvdGggYmFyZS1tZXRhbCBhbmQgdmlydHVhbGl6YXRpb24gY2FzZS4gDQoNCllvdSBjYW4g
ZHJvcCB0aGUgdGxiIGZsdXNoIGluIHRoYXQgZnVuY3Rpb24gaWYgdGhhdCdzIHlvdXIgbWFqb3Ig
Y29uY2Vybi4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgTW9uayBMaXUNClNlbnQ6IDIwMTnlubQxMeaciDI55pelIDE2OjI0DQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFt
ZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBmaXggR0ZYMTAgbWlzc2lu
ZyBDU0lCIHNldA0KDQpzdGlsbCBuZWVkIHRvIGluaXQgY3NiIGV2ZW4gZm9yIFNSSU9WDQoNClNp
Z25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCA4ICsrKysrLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMNCmluZGV4IDc0ZWRmZDkuLjIzMGU4YWYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC0xODc0LDE0ICsxODc0LDE2IEBAIHN0YXRp
YyBpbnQgZ2Z4X3YxMF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpICB7
DQogCWludCByOw0KIA0KLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KLQkJcmV0dXJuIDA7
DQotDQogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQ
KSB7DQogCQlyID0gZ2Z4X3YxMF8wX3dhaXRfZm9yX3JsY19hdXRvbG9hZF9jb21wbGV0ZShhZGV2
KTsNCiAJCWlmIChyKQ0KIAkJCXJldHVybiByOw0KIA0KKwkJaWYgKGFtZGdwdV9zcmlvdl92Zihh
ZGV2KSkgew0KKwkJCWdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsNCisJCQlyZXR1cm4gMDsNCisJ
CX0NCisNCiAJCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCiAJCWlmIChyKQ0KIAkJCXJl
dHVybiByOw0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2hhd2tpbmcuemhhbmclNDBhbWQuY29t
JTdDYzM0M2FmYTlhYTIzNGNiYjgyNzUwOGQ3NzRhNTcyNjglN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTA2MTI3Mjc3MzUzMDg2JmFtcDtzZGF0YT1LdCUy
RmQxNjgwUmMzbHlGd3o0bmc1ZUE3SnhpWVdqZjF3aERCcGZuSHpUSnMlM0QmYW1wO3Jlc2VydmVk
PTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
