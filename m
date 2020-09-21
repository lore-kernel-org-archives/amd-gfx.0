Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E817C4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EF620B1F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k8K4MJ8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EF620B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7746E56A;
	Mon, 21 Sep 2020 19:55:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94536E56A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 19:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebg9ztIcY2nrCF3caJpQokq3ddmasSZ+r7yMfLo58bGU+cW+3pY/AYLH7CzXHeAxAaAUyosc7Ymt9t+IDehyNroz7NomTtPAkFbU+nobLoM03RXil87bept7XDk6c5bwgys5RIzs5fp6xE0o+NtheZ+249EAed7iCfS0xmgrbndrHMobGYiwj1CF/AuITyOtu0D9RJu9XDiKHgWqXAxZnQl8kH7fFrwNZrYip6eWmp/+1wc3OFzOymKrQHbPc38jwVrd9g4j/hNSpMrbuekgSZWDEZbHBLkSE18Ud97nt6DeNIvE+fNm4tqZSI0pUn18QTBWuf5Zt2P1NAI77TtoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdG2HJUZIFvB3mtF99PWT0BjVCnrlOkvjH13Nd8cjWU=;
 b=iKhuMWWlUbOA6bBuBoUrn8F6MURFBH057RO1M2YsIZqfVPDKZMsvDoi/pGUvLwk6e/SB/JNL5Evu7mkABlApAtW9ICCmtxZTcxcHcl6yXjYz6KjYhd8RLSrguGsF+PwSxB/PaCvTNXcj+4aCQH0FomjrFkJppZSGEK4AWEukfek1R9+DUUIwoH68t2ZzN8KnRer2trvwlSbvZKOdp5/gfMrW2OUpetRG1qwwUGjMMcf/njC5a0i1Vr6Pxsi3F6IdTztuzjhDQgyJdfc+tuAH1FSVK1Gqxc3Zmt71gBvxjk2alPCWQkPhnvdXnmKnOhf7UXo7pd0SoCTmEDYzYEJhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdG2HJUZIFvB3mtF99PWT0BjVCnrlOkvjH13Nd8cjWU=;
 b=k8K4MJ8ZVaUWIWEJBY73nyw1MhyJVmuI+JIx3PtMZXucqhdMUuMh96yVAHslx0vBAdjYlqeS696TE60zdMnGBh2Q+YBbTsTmg8EaPSZyCjfMBksilpL53I85dHxQRWCEpqiMxdWM1Ix2BoNNl08zAyoZjBXceesmDc1wng02q1o=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB3662.namprd12.prod.outlook.com (2603:10b6:208:164::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 19:55:23 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 19:55:23 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add uid info to process BO list
Thread-Topic: [PATCH] drm/amdgpu: Add uid info to process BO list
Thread-Index: AQHWkEv8O2wK3EdE60uagzsInOT55qlzeQyAgAAHcbA=
Date: Mon, 21 Sep 2020 19:55:23 +0000
Message-ID: <BL0PR12MB2433A91BE80EF2D8DFAB85E09C3A0@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20200921191803.18549-1-madhav.chauhan@amd.com>
 <be158145-41b9-c319-8e46-cda88d5cb9c2@gmail.com>
In-Reply-To: <be158145-41b9-c319-8e46-cda88d5cb9c2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T19:55:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a61218af-756e-4957-ba8d-00004d0c2ab0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-21T19:55:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: cccc8a99-0a40-458f-b1a6-0000752632ee
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-21T19:55:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 645a0e22-59ee-43d9-91ab-0000d7a535b5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.167.148.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65334fe3-2289-4a43-3ea1-08d85e68472b
x-ms-traffictypediagnostic: MN2PR12MB3662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3662B89C496F428EDFC76A419C3A0@MN2PR12MB3662.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ZC9wU0PU3M5ACMEW/VT0cnGDR0LvlSouGUhCowdEB66pz5gDPndXvc+x5xTVtcni4XZEwMEf6tffdHd6SeWx5Ud8GPHfOT9GCIcYA/wQR+WW08r3bi4DBOIDoNTdEdY5cGwRF7oybwpHI82UlsteHbAnAq0apzdT0zH3H1jv6lBkynJ9cBetzKZGYrJd37nACeD4tCrJXQnR2DW55Cv2oWVrqaYY7EBdkzlEOOJP0aMnTKtQAOU4fc2ClS3HlY7+2aS71dB8uPRaqZhTkIhrLDlOB/+/dbysOE/T2aa1+kV4UH4Vbztj5rdFRlpYoYdQZoJ67+tlxHxALjo9n9ABTrI12zLBD8RQcZaMUabt1wo17hk2y1qEHcNbD0I2hr/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(76116006)(66946007)(64756008)(66446008)(186003)(26005)(33656002)(7696005)(66476007)(54906003)(4326008)(478600001)(110136005)(8936002)(66556008)(316002)(5660300002)(66574015)(52536014)(53546011)(83380400001)(86362001)(9686003)(55016002)(8676002)(6506007)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fcVchc3yikTj6GUAIXllUemUGb3X6o0zXKVLdYxRxy4b5Tdoo2MqubKCF98K23rw9jAwIzvls8jSNZ2xsJuK5DmMWXwg5YEn6ViAXXhsE7GjoBptGoWzGVx8HfzoE567hApl/hW2P7EKgi1sBq2+JNWCVqUH7z9aOwRJrsO0azoeHTO2PM1+C5rO71B+Ss15yetgEWW/j745KTtDL/ZemefHekb8xkYkxT9nEsDLqQIpm9B4fGOnIPqDYCZrDDS4dzFU0WkjDMxhMzHSNV6sb8GidARpcONWY6XFK0TdVJIgxk8ctps1diODcsBD2GrQ7UTSCkTBqjuK7bU5U3LgUri5ayeQarbPLDH7HeN7fILUU+r4mXkIHCCiDVhqYq/UWAkyLYp/wW97vPEdpc+GKwb6miYwOBu5MAAS9f9uwu6PajglpUFJ8K6iWfUcteMjHexlH1MkDMfv7/sGdBXnyj0e+O3srpCFBoa8RlH9sgAD1lPyyEd5O+XFInZpLHC42C6UxN84PCzG0XMWS9F3m4vGX9UW3ikH/jSBFnZ4/R0WzO+0nN4/9FlEmUkewKQhlqVrUpEJWkP6ISZAy9xcE54OujTFT2lo4uEhsPHey8Q/9xIaG9U8pZpZhw/UVqvWk5cVMP3cEqAXjRJ6BId7xw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65334fe3-2289-4a43-3ea1-08d85e68472b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 19:55:23.3503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7MCGnG3DnuJLv2Aa9KzUavs/Ktl+Gep5a2S9ZqqKYvbIO4yVh3ORfnbIo+NuBzCK9s4mGzw3W0Xf8B0PSYJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>, "Patel, Mihir" <Mihir.Patel@amd.com>,
 "Saleem, Athar" <Athar.Saleem@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDog
VHVlc2RheSwgU2VwdGVtYmVyIDIyLCAyMDIwIDEyOjU0IEFNDQpUbzogQ2hhdWhhbiwgTWFkaGF2
IDxNYWRoYXYuQ2hhdWhhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBTdXJhbXBhbGxpLCBLaXNob3JlIDxLaXNob3JlLlN1cmFtcGFsbGlAYW1kLmNvbT47IFBh
dGVsLCBNaWhpciA8TWloaXIuUGF0ZWxAYW1kLmNvbT47IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNo
YW5rLlNoYXJtYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgU2FsZWVtLCBBdGhhciA8QXRoYXIuU2FsZWVtQGFtZC5jb20+DQpTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBBZGQgdWlkIGluZm8gdG8gcHJvY2VzcyBCTyBsaXN0
DQoNCkFtIDIxLjA5LjIwIHVtIDIxOjE4IHNjaHJpZWIgTWFkaGF2IENoYXVoYW46DQo+IFVJRCBp
cyBoZWxwZnVsIHdoaWxlIGRvaW5nIGFuYWx5c2lzIG9mIEJPIGFsbG9jYXRlZCBieSBhIHByb2Nl
c3MuDQoNCkxvb2tzIGxpa2UgYSBiaXQgb3ZlcmtpbGwgdG8gbWUsIHdoeSBub3QgZ2V0IHRoZSB1
aWQgZnJvbSB0aGUgcHJvY2VzcyBpbmZvPw0KDQpOb3Qgc3VyZSBpZiBJIGdvdCB5b3VyIHBvaW50
ICwgYnV0IHVzZWQgdGhlIHNpbWlsYXIgbWV0aG9kIGltcGxlbWVudGVkIGF0IGRybSBsZXZlbCBp
bnNpZGUgZHJtX2RlYnVnZnMuYy4gVGhhbmtzDQoNClJlZ2FyZHMsDQpNYWRoYXYNCg0KQ2hyaXN0
aWFuLg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hZGhhdiBDaGF1aGFuIDxtYWRoYXYuY2hhdWhh
bkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMgfCA2ICsrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMNCj4gaW5kZXggZjRjMmUyZTc1YjhmLi5jMTk4MjM0OWVjN2IgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gQEAgLTg5Miw2ICs4OTIsNyBAQCBzdGF0
aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX2dlbV9pbmZvKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAq
ZGF0YSkNCj4gICAJc3RydWN0IGRybV9pbmZvX25vZGUgKm5vZGUgPSAoc3RydWN0IGRybV9pbmZv
X25vZGUgKiltLT5wcml2YXRlOw0KPiAgIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gbm9kZS0+
bWlub3ItPmRldjsNCj4gICAJc3RydWN0IGRybV9maWxlICpmaWxlOw0KPiArCWt1aWRfdCB1aWQ7
DQo+ICAgCWludCByOw0KPiAgIA0KPiAgIAlyID0gbXV0ZXhfbG9ja19pbnRlcnJ1cHRpYmxlKCZk
ZXYtPmZpbGVsaXN0X211dGV4KTsNCj4gQEAgLTkwOSw3ICs5MTAsMTAgQEAgc3RhdGljIGludCBh
bWRncHVfZGVidWdmc19nZW1faW5mbyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpDQo+
ICAgCQkgKi8NCj4gICAJCXJjdV9yZWFkX2xvY2soKTsNCj4gICAJCXRhc2sgPSBwaWRfdGFzayhm
aWxlLT5waWQsIFBJRFRZUEVfUElEKTsNCj4gLQkJc2VxX3ByaW50ZihtLCAicGlkICU4ZCBjb21t
YW5kICVzOlxuIiwgcGlkX25yKGZpbGUtPnBpZCksDQo+ICsJCXVpZCA9IHRhc2sgPyBfX3Rhc2tf
Y3JlZCh0YXNrKS0+ZXVpZCA6IEdMT0JBTF9ST09UX1VJRDsNCj4gKwkJc2VxX3ByaW50ZihtLCAi
cGlkICU4ZCB1aWQgJTVkIGNvbW1hbmQgJXM6XG4iLA0KPiArCQkJICAgcGlkX25yKGZpbGUtPnBp
ZCksDQo+ICsJCQkgICBmcm9tX2t1aWRfbXVuZ2VkKHNlcV91c2VyX25zKG0pLCB1aWQpLA0KPiAg
IAkJCSAgIHRhc2sgPyB0YXNrLT5jb21tIDogIjx1bmtub3duPiIpOw0KPiAgIAkJcmN1X3JlYWRf
dW5sb2NrKCk7DQo+ICAgDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
