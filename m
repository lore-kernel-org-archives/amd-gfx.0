Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0DDC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1FB20724
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oEP2AA5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1FB20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF716ED93;
	Fri, 30 Oct 2020 11:06:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17BF06ED93
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da+OUXIAUP5UKpGbD2NPr87CmVQTwKXdGflmQnxOYgp888gYIz3Rr6mfk7V9X2Mog+yFYdugxXENGiV2+qmwl7rzivWrMdm8k5z6BEdC1uf64DyVyJebFwngJ+3zguBJ+ICSU4NoKy1ooPT3a/dMqd5Few5Vk7xJJ3oQSYbqP5OkAIV/OfdSAx1Iv7PDm53DPY2ZIy6OV5Emh/+fxXDKIMkJHlbrfvoUjH/jmkNaCnAXh5u55OkDrKzWXPiuu1W1b9iiRb5WeNXs6VUeq/JGR2ZlnoHei4i0qVeOwvlGgYnlQpREQUVpbwPDzBDUVh1XsEcqsqz3RnDVWsLyLs17HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7V6zGrmNqyRHJN3ADO0Yb9VT1ZluSbvoRL+FfQWJ84=;
 b=ZP6i7Ogkqxt5TSTByrFz985Ad0scBuOsCzsc2ls1jUF0TD9Xo2Vqr0SVCVpQB1l2zSPl68yD7sMmE0a0vJ3CHTpWJ9PcaWCb+6vZoG36OVDI6EOZaf1vLA5H0VPzp3cfAtR8SLD5YXgZrJ9fhBE3ZhOZc0FKweYFiyP81MtUOn2on3VHiZ0zR+vBkzXirYbNEW5fsMD3W46Z1cRk+n8ST24l+FXQptyrnFYmxCpdWz1g6Vpyr6Avyf28+y3Lf79q1sL9jMvIT5jMGCxa6qfwENuf7qkC9yAJyrsqhb+5IirmRnwrsRw7ES0jEp/hUOtHh8ZRaZJufMImazSr2tWttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7V6zGrmNqyRHJN3ADO0Yb9VT1ZluSbvoRL+FfQWJ84=;
 b=oEP2AA5AeNH/mwMICf9pLDS3S9d37rX4Wte4OHHEPvj6HM1PgHVGlJsCBC815PsX7MBI21PS6wII6rYr/7g5qcJ0DRnWpBtTiOZicYcqwakcJmXDdU+V2q6aHBNVDky+hO1S4VIsQM6xvXaC626bcK4rPq7CG8nYmbcgeMS7akY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Fri, 30 Oct 2020 11:06:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 11:06:47 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 37/40] drm/amd/pm: enable Polaris watermark table setting
Thread-Topic: [PATCH 37/40] drm/amd/pm: enable Polaris watermark table setting
Thread-Index: AQHWo2xwKcrIyEGsSEy8Mh7c13mhuamuaeCAgAGolkA=
Date: Fri, 30 Oct 2020 11:06:47 +0000
Message-ID: <DM6PR12MB261920F2E02EE630E2485D4FE4150@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201016032652.507-1-evan.quan@amd.com>
 <20201016032652.507-38-evan.quan@amd.com>
 <9dc45588-d70e-0e3d-5131-22994ab2c757@gmail.com>
In-Reply-To: <9dc45588-d70e-0e3d-5131-22994ab2c757@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0a7413d-7e2e-4422-9d2d-a2d270f38d89;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-30T11:06:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c38ad646-1d0e-417c-d217-08d87cc3e545
x-ms-traffictypediagnostic: DM6PR12MB2794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2794CF073D136DDA4E5624D2E4150@DM6PR12MB2794.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+BnTBVyA5chmRmOo0uLTjeRpOLlpdkAyJrYpCH9BUzXjvjQUaqritJ1Qim1/iYAq9DKXDU4waSUPQJUQD1H/+tyKUdpGJY3Tg6sm4Zevdy3aTKb1izRm/jEsHfiY7w6/J6gibxBl/N36K5lFU6CiBG2gQHGr6H1a4/uL2tSWehRPYZN0d8YlbYw7COnNyPkoJATeJuALRRdG9WrW8UaAkpTILVPCO4wyEzMOsYMRz6BPKRlBYvRnThQoxIB4dgI22sNVk4fP5Hqz+v69YCZjl2G/+OsNl0vDjBq/lHxMUl+NgPiv0RXc8jFeI19xU+Wa8TGb63RqMTuHuHDu7Xd00Dc4nUHtuQYE4GYCqjiLk0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(966005)(7696005)(4326008)(2906002)(6506007)(66946007)(9686003)(76116006)(66574015)(55016002)(83380400001)(478600001)(52536014)(66476007)(66556008)(66446008)(64756008)(33656002)(71200400001)(316002)(8936002)(53546011)(86362001)(5660300002)(110136005)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uk+z+kVBPvtK7ImFzDrZioJSmzqjxLK3ZcYhvSaiXWmTJGlODrPIYwOKrBY3jDn9SRuiqvnV9kcSXRS952AXVnNGQKPuXcWPtkn5MF8k+BwzUd+vhouncHv79tDoD0hmtYzhT6hHKDyOeULP36SceVYwEp5dp8GPAaDe1pQJVQ1BqhIVouLr9OVpQ2U+v1ddD9bFF0pnEI94HIXWYjkZ4bHdcdmY8PxestXeu82h7x7zW1LF9RjhRbbuf36NvR4m7B5R8DHnirSnwN/9AcOlo+NZiWdEv00uYBBI40CKJZypvgOhnVvB/mCDGcpPhI2z7/L+b7mZm7McaECocNThKBU8dxxJoqcB1O2n2VGLT5EFKPiMv5xChDHP2syktSa7RoTr5wTFr7H8gWjIXbuKqKGxOpRoVJmaLbQALu60bhCidOdtr9lUdHkrU5THj1msfZ2VMoJRfArnvMJr1DfnVeiE5nPvpSaZ5PtASnVaPqZwAbGVwbeSrC7iNbasA4xqu0ZJJ18h/B+rEf9P7ah3GnCS9+fTGsdqyvJ7n8iuaOrlVhS4pHeO5xW28iDMerba1dXAO9QKruAyOFGDTJDI31CtrzRLDmxDc24sDSCgIrRrDpPIEg1Hi4yhg5VlXxOmzuyE2o57MRxiY0oLUqLVCg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38ad646-1d0e-417c-d217-08d87cc3e545
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 11:06:47.9190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRqW014g9XVgpimX4sI4PBYMw4xqwqvLELBmiy/+qKvxKYsXtzJ3bvayGmIV7Tiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBDaHJpc3RpYW4sDQoNCkp1c3Qgc2VudCBvdXQgYSBwYXRjaCB3aGljaCBzaG91bGQgYmUgYWJs
ZSB0byBhZGRyZXNzIHRoaXMgaXNzdWUgeW91IHNhdy4NCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL2FyY2hpdmVzL2FtZC1nZngvMjAyMC1PY3RvYmVyLzA1NTQzMS5odG1sDQoNCkJSDQpF
dmFuDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAyOSwgMjAyMCA1OjQ2IFBNDQpUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMzcvNDBdIGRybS9h
bWQvcG06IGVuYWJsZSBQb2xhcmlzIHdhdGVybWFyayB0YWJsZSBzZXR0aW5nDQoNCkhpIGd1eXMs
DQoNCnRoaXMgY29tbWl0IGhlcmUgY29tcGxldGVseSBicmVha3MgVmVnYTIwLg0KDQpBbnkgaWRl
YSB3aHkgYSBjaGFuZ2UgZm9yIFBvbGFyaXMgc2hvdWxkIGhhdmUgdGhhdCBlZmZlY3Q/IENhbiB3
ZSBwbGVhc2UgZml4IHRoaXMgQVNBUD8NCg0KVGhhbmtzLA0KQ2hyaXN0aWFuLg0KDQpBbSAxNi4x
MC4yMCB1bSAwNToyNiBzY2hyaWViIEV2YW4gUXVhbjoNCj4gRW5hYmxlIHdhdGVybWFyayB0YWJs
ZSBzZXR0aW5nIGZvciBQb2xhcmlzLg0KPg0KPiBDaGFuZ2UtSWQ6IEkzOTViNzRmMmNlNWI3NGU2
ZDFjNzY1OTgxNmVlMzg2YmE1NTZlMTRjDQo+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZh
bi5xdWFuQGFtZC5jb20+DQo+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtX3BwX3NtdS5jICB8IDExICsrKy0NCj4gICAuLi4vZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdt
Z3Ivc211N19od21nci5jICAgfCA1MCArKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Bw
X3NtdS5jDQo+IGluZGV4IGRlYjkxNjRlYjVmZS4uZmQzOWRkNjdiZmE0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bV9wcF9zbXUuYw0KPiBAQCAtNDU4LDcgKzQ1OCwxNiBAQCBib29sIGRtX3BwX25vdGlmeV93bV9j
bG9ja19jaGFuZ2VzKA0KPiAgIGNvbnN0IHN0cnVjdCBkY19jb250ZXh0ICpjdHgsDQo+ICAgc3Ry
dWN0IGRtX3BwX3dtX3NldHNfd2l0aF9jbG9ja19yYW5nZXMgKndtX3dpdGhfY2xvY2tfcmFuZ2Vz
KQ0KPiAgIHsNCj4gLS8qIFRPRE86IHRvIGJlIGltcGxlbWVudGVkICovDQo+ICtzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGN0eC0+ZHJpdmVyX2NvbnRleHQ7DQo+ICt2b2lkICpwcF9oYW5k
bGUgPSBhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlOw0KPiArY29uc3Qgc3RydWN0IGFtZF9wbV9m
dW5jcyAqcHBfZnVuY3MgPSBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3M7DQo+ICsNCj4gK2lmIChw
cF9mdW5jcyAmJiBwcF9mdW5jcy0+c2V0X3dhdGVybWFya3NfZm9yX2Nsb2Nrc19yYW5nZXMpIHsN
Cj4gK2lmICghcHBfZnVuY3MtPnNldF93YXRlcm1hcmtzX2Zvcl9jbG9ja3NfcmFuZ2VzKHBwX2hh
bmRsZSwNCj4gKyh2b2lkICopd21fd2l0aF9jbG9ja19yYW5nZXMpKQ0KPiArcmV0dXJuIHRydWU7
DQo+ICt9DQo+ICsNCj4gICByZXR1cm4gZmFsc2U7DQo+ICAgfQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jDQo+IGlu
ZGV4IDM3MDAzNTIyODZjNS4uY2U4ZjM2OGMwYThjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jDQo+IEBAIC00OSw2
ICs0OSw4IEBADQo+ICAgI2luY2x1ZGUgInByb2Nlc3NwcHRhYmxlcy5oIg0KPiAgICNpbmNsdWRl
ICJwcF90aGVybWFsLmgiDQo+ICAgI2luY2x1ZGUgInNtdTdfYmFjby5oIg0KPiArI2luY2x1ZGUg
InNtdTdfc211bWdyLmgiDQo+ICsjaW5jbHVkZSAicG9sYXJpczEwX3NtdW1nci5oIg0KPg0KPiAg
ICNpbmNsdWRlICJpdnNyY2lkL2l2c3JjaWRfdmlzbGFuZHMzMC5oIg0KPg0KPiBAQCAtNTEwNyw2
ICs1MTA5LDUzIEBAIHN0YXRpYyBpbnQgc211N19nZXRfY2xvY2tfYnlfdHlwZV93aXRoX2xhdGVu
Y3koc3RydWN0IHBwX2h3bWdyICpod21nciwNCj4gICByZXR1cm4gMDsNCj4gICB9DQo+DQo+ICtz
dGF0aWMgaW50IHNtdTdfc2V0X3dhdGVybWFya3NfZm9yX2Nsb2Nrc19yYW5nZXMoc3RydWN0IHBw
X2h3bWdyICpod21nciwNCj4gKyB2b2lkICpjbG9ja19yYW5nZSkNCj4gK3sNCj4gK3N0cnVjdCBw
aG1fcHB0X3YxX2luZm9ybWF0aW9uICp0YWJsZV9pbmZvID0NCj4gKyhzdHJ1Y3QgcGhtX3BwdF92
MV9pbmZvcm1hdGlvbiAqKWh3bWdyLT5wcHRhYmxlOw0KPiArc3RydWN0IHBobV9wcHRfdjFfY2xv
Y2tfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlICpkZXBfbWNsa190YWJsZSA9DQo+ICt0YWJsZV9p
bmZvLT52ZGRfZGVwX29uX21jbGs7DQo+ICtzdHJ1Y3QgcGhtX3BwdF92MV9jbG9ja192b2x0YWdl
X2RlcGVuZGVuY3lfdGFibGUgKmRlcF9zY2xrX3RhYmxlID0NCj4gK3RhYmxlX2luZm8tPnZkZF9k
ZXBfb25fc2NsazsNCj4gK3N0cnVjdCBwb2xhcmlzMTBfc211bWdyICpzbXVfZGF0YSA9DQo+ICso
c3RydWN0IHBvbGFyaXMxMF9zbXVtZ3IgKikoaHdtZ3ItPnNtdV9iYWNrZW5kKTsNCj4gK1NNVTc0
X0Rpc2NyZXRlX0RwbVRhYmxlICAqdGFibGUgPSAmKHNtdV9kYXRhLT5zbWNfc3RhdGVfdGFibGUp
Ow0KPiArc3RydWN0IGRtX3BwX3dtX3NldHNfd2l0aF9jbG9ja19yYW5nZXMgKndhdGVybWFya3Mg
PQ0KPiArKHN0cnVjdCBkbV9wcF93bV9zZXRzX3dpdGhfY2xvY2tfcmFuZ2VzICopY2xvY2tfcmFu
Z2U7DQo+ICt1aW50MzJfdCBpLCBqLCBrOw0KPiArYm9vbCB2YWxpZF9lbnRyeTsNCj4gKw0KPiAr
aWYgKCEoaHdtZ3ItPmNoaXBfaWQgPj0gQ0hJUF9QT0xBUklTMTAgJiYNCj4gKyAgICAgIGh3bWdy
LT5jaGlwX2lkIDw9IENISVBfVkVHQU0pKQ0KPiArcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gK2Zv
ciAoaSA9IDA7IGkgPCBkZXBfbWNsa190YWJsZS0+Y291bnQ7IGkrKykgew0KPiArZm9yIChqID0g
MDsgaiA8IGRlcF9zY2xrX3RhYmxlLT5jb3VudDsgaisrKSB7DQo+ICt2YWxpZF9lbnRyeSA9IGZh
bHNlOw0KPiArZm9yIChrID0gMDsgayA8IHdhdGVybWFya3MtPm51bV93bV9zZXRzOyBrKyspIHsN
Cj4gK2lmIChkZXBfc2Nsa190YWJsZS0+ZW50cmllc1tpXS5jbGsgLyAxMCA+PSB3YXRlcm1hcmtz
LT53bV9jbGtfcmFuZ2VzW2tdLndtX21pbl9lbmdfY2xrX2luX2toeiAmJg0KPiArICAgIGRlcF9z
Y2xrX3RhYmxlLT5lbnRyaWVzW2ldLmNsayAvIDEwIDwgd2F0ZXJtYXJrcy0+d21fY2xrX3Jhbmdl
c1trXS53bV9tYXhfZW5nX2Nsa19pbl9raHogJiYNCj4gKyAgICBkZXBfbWNsa190YWJsZS0+ZW50
cmllc1tpXS5jbGsgLyAxMCA+PSB3YXRlcm1hcmtzLT53bV9jbGtfcmFuZ2VzW2tdLndtX21pbl9t
ZW1fY2xrX2luX2toeiAmJg0KPiArICAgIGRlcF9tY2xrX3RhYmxlLT5lbnRyaWVzW2ldLmNsayAv
IDEwIDwgd2F0ZXJtYXJrcy0+d21fY2xrX3Jhbmdlc1trXS53bV9tYXhfbWVtX2Nsa19pbl9raHop
IHsNCj4gK3ZhbGlkX2VudHJ5ID0gdHJ1ZTsNCj4gK3RhYmxlLT5EaXNwbGF5V2F0ZXJtYXJrW2ld
W2pdID0gd2F0ZXJtYXJrcy0+d21fY2xrX3Jhbmdlc1trXS53bV9zZXRfaWQ7DQo+ICticmVhazsN
Cj4gK30NCj4gK30NCj4gK1BQX0FTU0VSVF9XSVRIX0NPREUodmFsaWRfZW50cnksDQo+ICsiQ2xv
Y2sgaXMgbm90IGluIHJhbmdlIG9mIHNwZWNpZmllZCBjbG9jayByYW5nZSBmb3Igd2F0ZXJtYXJr
IGZyb20gREFMISAgVXNpbmcgaGlnaGVzdCB3YXRlciBtYXJrIHNldC4iLA0KPiArdGFibGUtPkRp
c3BsYXlXYXRlcm1hcmtbaV1bal0gPSB3YXRlcm1hcmtzLT53bV9jbGtfcmFuZ2VzW2sgLSAxXS53
bV9zZXRfaWQpOw0KPiArfQ0KPiArfQ0KPiArDQo+ICtyZXR1cm4gc211N19jb3B5X2J5dGVzX3Rv
X3NtYyhod21nciwNCj4gKyAgICAgIHNtdV9kYXRhLT5zbXU3X2RhdGEuZHBtX3RhYmxlX3N0YXJ0
ICsgb2Zmc2V0b2YoU01VNzRfRGlzY3JldGVfRHBtVGFibGUsIERpc3BsYXlXYXRlcm1hcmspLA0K
PiArICAgICAgKHVpbnQ4X3QgKil0YWJsZS0+RGlzcGxheVdhdGVybWFyaywNCj4gKyAgICAgIHNp
emVvZih1aW50OF90KSAqIFNNVTc0X01BWF9MRVZFTFNfTUVNT1JZICogU01VNzRfTUFYX0xFVkVM
U19HUkFQSElDUywNCj4gKyAgICAgIFNNQ19SQU1fRU5EKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRp
YyBpbnQgc211N19ub3RpZnlfY2FjX2J1ZmZlcl9pbmZvKHN0cnVjdCBwcF9od21nciAqaHdtZ3Is
DQo+ICAgdWludDMyX3QgdmlydHVhbF9hZGRyX2xvdywNCj4gICB1aW50MzJfdCB2aXJ0dWFsX2Fk
ZHJfaGksDQo+IEBAIC01NTI1LDYgKzU1NzQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwX2h3
bWdyX2Z1bmMgc211N19od21ncl9mdW5jcyA9IHsNCj4gICAuc2V0X21jbGtfb2QgPSBzbXU3X3Nl
dF9tY2xrX29kLA0KPiAgIC5nZXRfY2xvY2tfYnlfdHlwZSA9IHNtdTdfZ2V0X2Nsb2NrX2J5X3R5
cGUsDQo+ICAgLmdldF9jbG9ja19ieV90eXBlX3dpdGhfbGF0ZW5jeSA9DQo+IHNtdTdfZ2V0X2Ns
b2NrX2J5X3R5cGVfd2l0aF9sYXRlbmN5LA0KPiArLnNldF93YXRlcm1hcmtzX2Zvcl9jbG9ja3Nf
cmFuZ2VzID0NCj4gK3NtdTdfc2V0X3dhdGVybWFya3NfZm9yX2Nsb2Nrc19yYW5nZXMsDQo+ICAg
LnJlYWRfc2Vuc29yID0gc211N19yZWFkX3NlbnNvciwNCj4gICAuZHluYW1pY19zdGF0ZV9tYW5h
Z2VtZW50X2Rpc2FibGUgPSBzbXU3X2Rpc2FibGVfZHBtX3Rhc2tzLA0KPiAgIC5hdmZzX2NvbnRy
b2wgPSBzbXU3X2F2ZnNfY29udHJvbCwNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
