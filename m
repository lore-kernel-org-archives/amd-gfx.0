Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A0EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 03:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441C12064C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 03:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KYgBvM3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441C12064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095496E88D;
	Thu, 11 Jun 2020 03:29:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6CA6E88D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 03:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsm31KpIlQFeSIx+EzjfwlBZViA6Wsr4NK8UeHtZdduX8Tyogny7JiQnFUY7tIBeLmCruTH8guLzzuF1PDUKkm1U8y+CGp6UB6u6Mm4ddXyJ6ytGo2qw/dg1+Cmc7681aDPLbGvBZUqNoTLFBCU/6PDIv+bYgBLsXRwW6knII0EWwwSp2+w6uT+BZnm9A4DoclfYAux+t77ahtJRY11Ylk4K/L9Cr2Ba1ONx9dOfs3t4LU47S6xGpZM5mbEiUkf3oVQLow8QnUpQpRH28p1yKThsu1mRPdCTZSSJ5xsurT5Ck8LwYjuVR+wKYXS/1VfxH+JgBsgIDUjeXZEeo3e7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoasPciVoWov/NiV1v6joFzCdtWz70yapRYW1xVTuXc=;
 b=KNYXmOR3eg4hLj3rVTkylfQJQL+EyHjIN8n7C6i7eA7I1co9vHBgAOm6BR8FSaKUmvNevRKRuQXcX+YZEsgbewTw7fdbERN9krgKJdu9VnMs8atdwvQvFL9k/MCqEQg721RdXS6Ek8tmhHr55RKqC9Z+9oATh3dGbtF+uJpw2yMfqKMWzN/pKnqFRhP0wEO38L7oHr48/ncOwek1rRNNOICjbyuoE8R9FCUy+vZKm6gAPqOXf4JLyl7Bf3Dol4WL+GNDrUsef+I2wE1iQiwGUOh1DCvMu3VewEcxugGq+WZCLjuOftevH713TRpmgoc9wVsSsY914wb9YRPfWfguTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoasPciVoWov/NiV1v6joFzCdtWz70yapRYW1xVTuXc=;
 b=KYgBvM3l0/7mSloKO8p8OWkjNrBZ10Xx4shXM4hzpNqkMqRHYp++pyTTRL/wfbiQWn0WDu5RRhzBjksNQ67yKWgNHOavJmBHMpvPIMAQuCzBk1l0j0ZXnNrfVpbdgOEtN7+ErMTnvptkruSdoQCNyTkMnWvtdapuozNvS1r+pFo=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 03:29:26 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 03:29:26 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Add clear vf fw support
Thread-Topic: [PATCH] drm/amdgpu/sriov: Add clear vf fw support
Thread-Index: AQHWP5gbaJAav4mqn0mbNKjRqSuWnKjSwc7w
Date: Thu, 11 Jun 2020 03:29:26 +0000
Message-ID: <DM5PR12MB17082312B402D765610A8E2F84800@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1591842541-29122-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1591842541-29122-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b93bdea-e65f-4498-f487-08d80db7a4d4
x-ms-traffictypediagnostic: DM5PR1201MB0123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0123BEA84A4C27D86C95032184800@DM5PR1201MB0123.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANip9RbwfkFIbgdBpJYo/kt9KfyVSOn7RLZN4RpjA6/XWEzXkpYh8+z4VMZDIX5R5LtyP/pAf1cws9UBq2teAnqDgc2Q98okW8SjPRc/Nx+bDuijipORro5jIpzu6KoaWSUqMhQNB69SnnqYtlWpwlWiQjBZi3sCr4wSOT/3/KlDguqF+9EyzOQWs4RNAXqGDgqzkaaH4TyUi4Qk5PxmNzAmP0vUw1TgktEQz8n1lIIWKW+4yRLYM81D5NM5i72y8gRXk3L4bLzz44NZg2sNXrDVBwcc3TOX1kU2612j5A7J8nt7FWIW2EccGbRqb7L+UjHWdHQfofVcUKY8DnEVXdfkPg1B8g39nNYs9ojMS8k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(83380400001)(33656002)(966005)(8676002)(52536014)(8936002)(316002)(110136005)(45080400002)(5660300002)(86362001)(66446008)(186003)(6506007)(76116006)(53546011)(26005)(9686003)(66556008)(7696005)(64756008)(478600001)(55016002)(4326008)(71200400001)(66476007)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YIsUjoIyl9igq+MtY9CC7VXl2NYEPTiD6F0E+/CKHTa7PoIIFskJkKwY4uZT0ycTVgs/mVemIpiqBMLIeOJdg6jc9nVA5NTiuydZKbE5RDqla2hu/BmPJ+SoSz4WBzmUjiM3ni7aWMVCyvKbOqP8J4f2hEQI41qYzxwNdBAFQMZE5yL4KD79jDCC8AJ2ixyr96EdjXJQBTg8JvYd7+jlJdDlvb/BGMvOUuNQE05sf82idxmkYkbmj31OwRJuyZ+qLTrcKee5gCK/gU0hevNWDIjdRTQiSTmxPSngkvXmCi2Oa3drRwu3HTDgffEFKZpSbXjE6e9ZA9dVoEJOIOBfZHUqY7ENQ8S8luRgWN5LOTAfTAywzEcYg9UkiJXHXdMWpAG3AOabHRUKvWKo08kR/Y1e/ONKCf11E4Sz1dhaVn21CNKz0dHjBzdTJrNHDBK0R9st38oCMbYN+8XFpvsiQnrOxDai4//vjekmMkXQ9ET5O2ZH17HZBmLgzWwX90Pk
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b93bdea-e65f-4498-f487-08d80db7a4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 03:29:26.6621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FJqKBAx4f2JWPPJmo9IRywEKpW/Ur/QkB+Rx5jNMFh6KR5M+oiz3h1EHTQ42JjW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrLWJ5OiBNb25rLmxpdSA8bW9uay5saXVAYW1kLmNvbT4NCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFN
RA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRW1pbHkgRGVuZw0K
U2VudDogVGh1cnNkYXksIEp1bmUgMTEsIDIwMjAgMTA6MjkgQU0NClRvOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+DQpT
dWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvc3Jpb3Y6IEFkZCBjbGVhciB2ZiBmdyBzdXBwb3J0
DQoNCkd1ZXN0IFZNIGlzc3VlIHRoZSBQU1AgY2xlYXJfdmZfZncgY29tbWFuZCBhdCAyIHBvaW50
czoNCjEuT24gVkYgZHJpdmVyIGxvYWRpbmcsIGFmdGVyIFZGIG1lc3NhZ2UgUFNQIHRvIHNldHVw
IHJpbmdzLCB0aGUgbmV4dCBjb21tYW5kIGlzIOKAnGNsZWFyX3ZmX2Z34oCdDQoyLk9uIFZGIGRy
aXZlciB1bmxvYWQgYmVmb3JlIFZGIG1lc3NhZ2UgdG8gZGVzdHJveSByaW5ncw0KDQpDaGFuZ2Ut
SWQ6IElhMzFhZGQzOGE2OTAzN2QxY2JiZjliNDhhZDgyN2ZhNjNiNDg2MGY3DQpTaWduZWQtb2Zm
LWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9nZnhfaWYuaCB8ICA4ICsr
KysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCmluZGV4IGNkZDY1YjUu
LjYwNTU4NDkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KQEAg
LTI3MCw4ICsyNzAsOSBAQCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3AsDQogCQlhbWRncHVfYXNpY19pbnZhbGlkYXRlX2hkcChwc3AtPmFkZXYsIE5VTEwpOw0KIAl9
DQogDQotCS8qIFdlIGFsbG93IFRFRV9FUlJPUl9OT1RfU1VQUE9SVEVEIGZvciBWTVIgY29tbWFu
ZCBpbiBTUklPViAqLw0KLQlza2lwX3Vuc3VwcG9ydCA9IChwc3AtPmNtZF9idWZfbWVtLT5yZXNw
LnN0YXR1cyA9PSAweGZmZmYwMDBhKSAmJiBhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KTsNCisJ
LyogV2UgYWxsb3cgVEVFX0VSUk9SX05PVF9TVVBQT1JURUQgZm9yIFZNUiBjb21tYW5kIGFuZCBQ
U1BfRVJSX1VOS05PV05fQ09NTUFORCBpbiBTUklPViAqLw0KKwlza2lwX3Vuc3VwcG9ydCA9IChw
c3AtPmNtZF9idWZfbWVtLT5yZXNwLnN0YXR1cyA9PSBURUVfRVJST1JfTk9UX1NVUFBPUlRFRCB8
fA0KKwkJcHNwLT5jbWRfYnVmX21lbS0+cmVzcC5zdGF0dXMgPT0gUFNQX0VSUl9VTktOT1dOX0NP
TU1BTkQpICYmIA0KK2FtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpOw0KIA0KIAkvKiBJbiBzb21l
IGNhc2VzLCBwc3AgcmVzcG9uc2Ugc3RhdHVzIGlzIG5vdCAwIGV2ZW4gdGhlcmUgaXMgbm8NCiAJ
ICogcHJvYmxlbSB3aGlsZSB0aGUgY29tbWFuZCBpcyBzdWJtaXR0ZWQuIFNvbWUgdmVyc2lvbiBv
ZiBQU1AgRlcgQEAgLTM4OSw2ICszOTAsMjYgQEAgc3RhdGljIGludCBwc3BfdG1yX2luaXQoc3Ry
dWN0IHBzcF9jb250ZXh0ICpwc3ApDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQg
cHNwX2NsZWFyX3ZmX2Z3KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKSB7DQorCWludCByZXQ7DQor
CXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7DQorDQorCWlmICghYW1kZ3B1X3NyaW92X3Zm
KHBzcC0+YWRldikgfHwgcHNwLT5hZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9OQVZJMTIpDQorCQly
ZXR1cm4gMDsNCisNCisJY21kID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHBzcF9nZnhfY21kX3Jl
c3ApLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFjbWQpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJ
Y21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0NMRUFSX1ZGX0ZXOw0KKw0KKwlyZXQgPSBwc3BfY21k
X3N1Ym1pdF9idWYocHNwLCBOVUxMLCBjbWQsIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOw0KKwlr
ZnJlZShjbWQpOw0KKw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCiBzdGF0aWMgaW50IHBzcF90bXJf
bG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgIHsNCiAJaW50IHJldDsNCkBAIC0xMzgyLDYg
KzE0MDMsMTIgQEAgc3RhdGljIGludCBwc3BfaHdfc3RhcnQoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQorCXJldCA9IHBzcF9jbGVhcl92Zl9mdyhwc3Ap
Ow0KKwlpZiAocmV0KSB7DQorCQlEUk1fRVJST1IoIlBTUCBjbGVhciB2ZiBmdyFcbiIpOw0KKwkJ
cmV0dXJuIHJldDsNCisJfQ0KKw0KIAlyZXQgPSBwc3BfdG1yX2luaXQocHNwKTsNCiAJaWYgKHJl
dCkgew0KIAkJRFJNX0VSUk9SKCJQU1AgdG1yIGluaXQgZmFpbGVkIVxuIik7DQpAQCAtMTg0Myw2
ICsxODcwLDcgQEAgc3RhdGljIGludCBwc3BfaHdfZmluaSh2b2lkICpoYW5kbGUpDQogCXN0cnVj
dCBwc3BfY29udGV4dCAqcHNwID0gJmFkZXYtPnBzcDsNCiAJdm9pZCAqdG1yX2J1ZjsNCiAJdm9p
ZCAqKnBwdHI7DQorCWludCByZXQ7DQogDQogCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgew0K
IAkJcHNwX3Jhc190ZXJtaW5hdGUocHNwKTsNCkBAIC0xODUxLDYgKzE4NzksMTEgQEAgc3RhdGlj
IGludCBwc3BfaHdfZmluaSh2b2lkICpoYW5kbGUpDQogCX0NCiANCiAJcHNwX2FzZF91bmxvYWQo
cHNwKTsNCisJcmV0ID0gcHNwX2NsZWFyX3ZmX2Z3KHBzcCk7DQorCWlmIChyZXQpIHsNCisJCURS
TV9FUlJPUigiUFNQIGNsZWFyIHZmIGZ3IVxuIik7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQogDQog
CXBzcF9yaW5nX2Rlc3Ryb3kocHNwLCBQU1BfUklOR19UWVBFX19LTSk7DQogDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9pZi5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9pZi5oDQppbmRleCBhNDRmZDYwLi5jYmMwNGE1IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9pZi5oDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfZ2Z4X2lmLmgNCkBAIC0xMTAsNiArMTEwLDcg
QEAgZW51bSBwc3BfZ2Z4X2NtZF9pZA0KICAgICBHRlhfQ01EX0lEX1NFVFVQX1ZNUiAgICA9IDB4
MDAwMDAwMDksICAgLyogc2V0dXAgVk1SIHJlZ2lvbiAqLw0KICAgICBHRlhfQ01EX0lEX0RFU1RS
T1lfVk1SICA9IDB4MDAwMDAwMEEsICAgLyogZGVzdHJveSBWTVIgcmVnaW9uICovDQogICAgIEdG
WF9DTURfSURfUFJPR19SRUcgICAgID0gMHgwMDAwMDAwQiwgICAvKiBwcm9ncmFtIHJlZ3MgKi8N
CisgICAgR0ZYX0NNRF9JRF9DTEVBUl9WRl9GVyAgPSAweDAwMDAwMDBELCAgIC8qIENsZWFyIFZG
IEZXLCB0byBiZSB1c2VkIG9uIFZGIHNodXRkb3duLiAqLw0KICAgICAvKiBJRHMgdXB0byAweDFG
IGFyZSByZXNlcnZlZCBmb3Igb2xkZXIgcHJvZ3JhbXMgKFJhdmVuLCBWZWdhIDEwLzEyLzIwKSAq
Lw0KICAgICBHRlhfQ01EX0lEX0xPQURfVE9DICAgICA9IDB4MDAwMDAwMjAsICAgLyogTG9hZCBU
T0MgYW5kIG9idGFpbiBUTVIgc2l6ZSAqLw0KICAgICBHRlhfQ01EX0lEX0FVVE9MT0FEX1JMQyA9
IDB4MDAwMDAwMjEsICAgLyogSW5kaWNhdGVzIGFsbCBncmFwaGljcyBmdyBsb2FkZWQsIHN0YXJ0
IFJMQyBhdXRvbG9hZCAqLw0KQEAgLTM2NSw0ICszNjYsMTEgQEAgc3RydWN0IHBzcF9nZnhfcmJf
ZnJhbWUNCiAgICAgICAgICAgICAgICAgLyogdG90YWwgNjQgYnl0ZXMgKi8NCiB9Ow0KIA0KKyNk
ZWZpbmUgUFNQX0VSUl9VTktOT1dOX0NPTU1BTkQgMHgwMDAwMDEwMA0KKw0KK2VudW0gdGVlX2Vy
cm9yX2NvZGUgew0KKyAgICBURUVfU1VDQ0VTUyAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4
MDAwMDAwMDAsDQorICAgIFRFRV9FUlJPUl9OT1RfU1VQUE9SVEVEICAgICAgICAgICAgID0gMHhG
RkZGMDAwQSwNCit9Ow0KKw0KICNlbmRpZiAvKiBfUFNQX1RFRV9HRlhfSUZfSF8gKi8NCi0tDQoy
LjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
YW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0Ntb25rLmxpdSU0MGFtZC5jb20lN0NhYTcwNmRiODU2NDk0ZTlh
YmJkODA4ZDgwZGFmM2FhMSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2MzcyNzQzOTM1NzYwMTIxMTkmYW1wO3NkYXRhPVNmQ0RaMjdYckVLREIyS1Jqek5CNmlH
WVRmc0NqbHN4czhEZjJxQzZidkklM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
