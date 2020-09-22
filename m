Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6481AC2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBDB206FB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rCHUp8in"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBDB206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60B46E845;
	Tue, 22 Sep 2020 10:39:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723D06E845
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 10:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTEiohUBD4FszbR4cwG7io4E7BDqZ7Dqqgjte14h62F4iEG7dJnHH61TT0Oo0btErO5lrnaYm8raMJ3I6KVDWPSBbfMHyqS18wStJ3ulHln+FV0YXhGs3f2CuSd2XHQGDqwcLNz9a34HPNldZsLVBOSQoODkxjhktPJPkbDTASI2ijeGqqR7tgxvYoc+EuO730BuLlK+Z+ug1BP0+PIbKX35mKZB89SOADzNIBQYWS33E5Y6Jdg3MZHAlIhccHv7nZhWfZzHREwiDK7STbKvF/Kg7ml5bAL+/almoA0eRazyaWYo6yzxVqAw35M4271tospHzl6W1ttsIw3QiX4/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpXnnhzia9vpgG6gHM72Cnk+tfozmhsvY0hRpQrqBe0=;
 b=F5v9yD0z5hu2rQFwv7k4MDbPxu3K8E8cn5usM9YiqSEDfxL7LhwOSGq8UNnhj05MPlsWeUcdVQUlEu84EEcWJwomidX7Q/6328qkaPO9kBUYqGO2PKJopumFxNzqpxHEEK2a9gwEkk1GCNV4arjK8p8+VPdZjLECitcFWl+EZvNJbppozGOcgTKDhDZN1F9gOJkKUQVY9Uh0hEFNRJL4qvXdGbM5d66m7GQPq2FUXV3q3V+SzzCI/st21Iy5JgLws8pQhwmiVGfUcYRqYWZlvGKYFJ4Mp0Qb5qWIXz92jeECCBJTXUDeAaP2uuocU2h2r3JrECFo0YkCCsWth3oIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpXnnhzia9vpgG6gHM72Cnk+tfozmhsvY0hRpQrqBe0=;
 b=rCHUp8inOGGyfXlBU0t+vRGRHmLADAZM7+e9LBsB4mmA2epbcGoUQy5QQhoJJm4wmEgJQpC7nZONZbzT6/Rd2MxlwoVKQKZhBljiW9gkN1b+xBtBLAKT0h7Gfet/kZsMb5e5pZ8LtQk6T9rW5GOVI+DH/D9Laslaje1WG9Qoqmo=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 10:38:55 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 10:38:55 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add uid info to process BO list
Thread-Topic: [PATCH] drm/amdgpu: Add uid info to process BO list
Thread-Index: AQHWkEv8O2wK3EdE60uagzsInOT55qlzeQyAgAAHcbCAALamgIAAPsIQ
Date: Tue, 22 Sep 2020 10:38:55 +0000
Message-ID: <BL0PR12MB2433166825CCE596D7B2ACA69C3B0@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20200921191803.18549-1-madhav.chauhan@amd.com>
 <be158145-41b9-c319-8e46-cda88d5cb9c2@gmail.com>
 <BL0PR12MB2433A91BE80EF2D8DFAB85E09C3A0@BL0PR12MB2433.namprd12.prod.outlook.com>
 <9ebed42d-06f2-bbd6-f702-8e707ea1ac84@amd.com>
In-Reply-To: <9ebed42d-06f2-bbd6-f702-8e707ea1ac84@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T10:38:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4583fcd2-5d54-407e-9b27-0000c69e2575;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T10:38:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c0b6cee4-eb7b-45c2-9747-00005036b7a1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T10:38:52Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 03d2513e-ef41-4900-bf7a-0000ab1de7e9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.167.148.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 117ce430-7057-4893-ea9e-08d85ee3b4ad
x-ms-traffictypediagnostic: MN2PR12MB4990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4990512161A538EBD86FB0769C3B0@MN2PR12MB4990.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n00lO3w9eNFiAAiGxhxketDok1Pa3RWVxzuVXQTeZbStesJ1Kv2UDf9H6sWYm7ASSOQ0wcGGmX3tqJbWFf/3zuFPIIY41uKjfwXN3VruKZOb9j77I9mJ62X3uyg06rY4Ik3qimmX3psUYgnkB/ZaiWzPCkGuT+4ZKvL/AKQrX+LmuClXHakpxFOs/qfh4MF4SfQploNeoVuds6u7PcuYhfNTX5C3tjh2iA+Pqo1cK8sqUCUOyUPFVj5J5Sq3WL+l/zp0ui7jnRdNKixOy2uTSNfKMVV+bpqxEOOC69yxn7XDWWZAn52OLsO7MhSIbUQyCyPbYoowbB/JbhyXrh4XGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(33656002)(86362001)(8676002)(316002)(186003)(8936002)(7696005)(83380400001)(52536014)(2906002)(55016002)(5660300002)(9686003)(76116006)(66946007)(110136005)(64756008)(66556008)(66446008)(26005)(478600001)(71200400001)(53546011)(66476007)(54906003)(66574015)(6506007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: blQ41ss01zP4nZfhgc1MGTPqE0z+9Dg7aTEA/wsod6DYHGxv3KtGnMzIjKt7d0DP3OSq5UTeYK51ZKVUsm/tB30qSEXunadQ6L9ahlLzaVZSmMMn9Y6ldYEJjTEYVwyJjL+HdEPAI8NzhcLX0EQHR9j5RxD6bz0GdaPIdTlrFqcOUfduWwjwnwKhNbTeoY8Ms6R29RqztlN2MHq7rX/0gfMoZUMy4r/5XhRqqAMLGIzP1DPuj8Ey0rE9mspRqv51RMQV7A9UQZ+8rOpk4f9TPNQmG6ZqJMLM+CR7lYbybTqghx58S12dAOpDOme30dZArWsvHE+5RRbB+SSQ5nzdTx9seWDVTIlOid87gtyv5yITrxMY9UZ3ERl0oGrm7qvEYRCx87nQuiT0cztgV1Gx57/8PYTVA1wNFbK4Ackj3i0f8O83x+HveC+/DAEk1f3npXUWoIzshw+sk2S3xuHrW4W7SWnhBrevtk7VUdd3gq5YNfNKZUYYHLF2RkA1Q/tUZ0zPYl2eSGKyeqhhNZu4mn85ppY0PzI4lzU+mDLX1q0YwmF3XTdzXzmFk8Hn76Qsx9WHuv/CAzmqf/KO96WnCuSm34LrqmpLWTk6k0bT0HpzoJdHAYBJlkvWaHPx3ZLjzr223onueDXdnUOINZmxsA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117ce430-7057-4893-ea9e-08d85ee3b4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 10:38:55.3779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlF1wbDeIbPjWNiWufd0l4VDGpT0hkAkyQT3xuR+EdIaxcusrAZrCIHs6PipYv5JAOn5fnAxU5aiFpMB7X7d1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gDQpTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgMjIsIDIwMjAgMTI6MTUgUE0NClRvOiBDaGF1aGFuLCBNYWRoYXYgPE1hZGhh
di5DaGF1aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFN1
cmFtcGFsbGksIEtpc2hvcmUgPEtpc2hvcmUuU3VyYW1wYWxsaUBhbWQuY29tPjsgUGF0ZWwsIE1p
aGlyIDxNaWhpci5QYXRlbEBhbWQuY29tPjsgU2hhcm1hLCBTaGFzaGFuayA8U2hhc2hhbmsuU2hh
cm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBTYWxlZW0sIEF0aGFyIDxBdGhhci5TYWxlZW1AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IEFkZCB1aWQgaW5mbyB0byBwcm9jZXNzIEJPIGxpc3QNCg0KQW0g
MjEuMDkuMjAgdW0gMjE6NTUgc2NocmllYiBDaGF1aGFuLCBNYWRoYXY6DQo+IFtBTUQgUHVibGlj
IFVzZV0NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAyMiwgMjAyMCAxMjo1NCBBTQ0KPiBUbzogQ2hhdWhhbiwgTWFkaGF2IDxN
YWRoYXYuQ2hhdWhhbkBhbWQuY29tPjsgDQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBTdXJhbXBhbGxpLCBLaXNob3JlIDxLaXNob3JlLlN1cmFtcGFsbGlAYW1kLmNvbT47
IFBhdGVsLCBNaWhpciANCj4gPE1paGlyLlBhdGVsQGFtZC5jb20+OyBTaGFybWEsIFNoYXNoYW5r
IDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT47IA0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBTYWxlZW0sIEF0aGFyIA0KPiA8QXRoYXIuU2FsZWVtQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEFkZCB1aWQgaW5mbyB0
byBwcm9jZXNzIEJPIGxpc3QNCj4NCj4gQW0gMjEuMDkuMjAgdW0gMjE6MTggc2NocmllYiBNYWRo
YXYgQ2hhdWhhbjoNCj4+IFVJRCBpcyBoZWxwZnVsIHdoaWxlIGRvaW5nIGFuYWx5c2lzIG9mIEJP
IGFsbG9jYXRlZCBieSBhIHByb2Nlc3MuDQo+IExvb2tzIGxpa2UgYSBiaXQgb3ZlcmtpbGwgdG8g
bWUsIHdoeSBub3QgZ2V0IHRoZSB1aWQgZnJvbSB0aGUgcHJvY2VzcyBpbmZvPw0KPg0KPiBOb3Qg
c3VyZSBpZiBJIGdvdCB5b3VyIHBvaW50ICwgYnV0IHVzZWQgdGhlIHNpbWlsYXIgbWV0aG9kIGlt
cGxlbWVudGVkIA0KPiBhdCBkcm0gbGV2ZWwgaW5zaWRlIGRybV9kZWJ1Z2ZzLmMuIFRoYW5rcw0K
DQpHb29kIGFyZ3VtZW50LCBidXQgSSdtIG5vdCBzdXJlIGlmIHdlIHNob3VsZCBkdXBsaWNhdGUg
dGhhdCBoZXJlLiBXaGF0IGRvIHlvdSBuZWVkIHRoaXMgZm9yPw0KDQpUaGFua3MsIFdlIG5lZWQg
ZGV0YWlscyBvZiBCT3MgYWxsb2NhdGVkIGJ5IGEgcHJvY2VzcyBhbmQgYXNzb2NpYXRlZCBVSUQg
c28gdGhhdCB3ZSBjYW4gZG8gbWVtb3J5IHBlcmYgYW5hbHlzaXMgdXNpbmcgc29tZSBzY3JpcHRz
DQpUbyBmaW5kIHRoZSB0b3AgY29uc3VtZXIgb2YgR1BVIG1lbW9yeSBhbmQgc2VlIGlmIHRob3Nl
IGFwcGxpY2F0aW9uIGNhbiBiZSBvcHRpbWl6ZWQuIA0KDQpDbGllbnRzIGluZm9ybWF0aW9uIGF0
IERSTSBsZXZlbCBkb2VzbuKAmXQgcHJpbnQgbGlzdCBvZiBCTyBwZXIgcHJvY2VzcyBhbmQgc2lu
Y2UgdGhhdCBpcyBoYW5kbGVkIGJ5IGFtZGdwdSBkcml2ZXIgc3BlY2lmaWMNCkZ1bmN0aW9ucy4g
IFNvIGFsbCB0aGUgQk8gbGlzdCBpbmZvcm1hdGlvbiBhdCBvbmUgcGxhY2UgaXMgcmVhbGx5IHVz
ZWZ1bCBhbmQgbmVlZGVkIGJ5IG91ciBjdXN0b21lcnMgYXMgdmFyaW91cyBvdGhlciB2ZW5kb3Jz
DQpBbHJlYWR5IHByb3ZpZGUgdGhpcy4NCg0KUmVnYXJkcywNCk1hZGhhdg0KDQpDaHJpc3RpYW4u
DQoNCj4NCj4gUmVnYXJkcywNCj4gTWFkaGF2DQo+DQo+IENocmlzdGlhbi4NCj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IE1hZGhhdiBDaGF1aGFuIDxtYWRoYXYuY2hhdWhhbkBhbWQuY29tPg0KPj4gLS0t
DQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCA2ICsrKysr
LQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+PiBpbmRl
eCBmNGMyZTJlNzViOGYuLmMxOTgyMzQ5ZWM3YiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+PiBAQCAtODkyLDYgKzg5Miw3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X2RlYnVnZnNfZ2VtX2luZm8oc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpkYXRhKQ0K
Pj4gICAgCXN0cnVjdCBkcm1faW5mb19ub2RlICpub2RlID0gKHN0cnVjdCBkcm1faW5mb19ub2Rl
ICopbS0+cHJpdmF0ZTsNCj4+ICAgIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gbm9kZS0+bWlu
b3ItPmRldjsNCj4+ICAgIAlzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGU7DQo+PiArCWt1aWRfdCB1aWQ7
DQo+PiAgICAJaW50IHI7DQo+PiAgICANCj4+ICAgIAlyID0gbXV0ZXhfbG9ja19pbnRlcnJ1cHRp
YmxlKCZkZXYtPmZpbGVsaXN0X211dGV4KTsNCj4+IEBAIC05MDksNyArOTEwLDEwIEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X2RlYnVnZnNfZ2VtX2luZm8oc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpk
YXRhKQ0KPj4gICAgCQkgKi8NCj4+ICAgIAkJcmN1X3JlYWRfbG9jaygpOw0KPj4gICAgCQl0YXNr
ID0gcGlkX3Rhc2soZmlsZS0+cGlkLCBQSURUWVBFX1BJRCk7DQo+PiAtCQlzZXFfcHJpbnRmKG0s
ICJwaWQgJThkIGNvbW1hbmQgJXM6XG4iLCBwaWRfbnIoZmlsZS0+cGlkKSwNCj4+ICsJCXVpZCA9
IHRhc2sgPyBfX3Rhc2tfY3JlZCh0YXNrKS0+ZXVpZCA6IEdMT0JBTF9ST09UX1VJRDsNCj4+ICsJ
CXNlcV9wcmludGYobSwgInBpZCAlOGQgdWlkICU1ZCBjb21tYW5kICVzOlxuIiwNCj4+ICsJCQkg
ICBwaWRfbnIoZmlsZS0+cGlkKSwNCj4+ICsJCQkgICBmcm9tX2t1aWRfbXVuZ2VkKHNlcV91c2Vy
X25zKG0pLCB1aWQpLA0KPj4gICAgCQkJICAgdGFzayA/IHRhc2stPmNvbW0gOiAiPHVua25vd24+
Iik7DQo+PiAgICAJCXJjdV9yZWFkX3VubG9jaygpOw0KPj4gICAgDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
