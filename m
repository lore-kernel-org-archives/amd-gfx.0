Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E4C2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 02:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7346920732
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 02:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sJBC7Iu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7346920732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389B589A34;
	Tue, 14 Apr 2020 02:06:22 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FCA894E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 02:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6bdwAG31Tqhoa8WQ64BWf3j/t7a2Vi36QCn/Hw0MUo9f1h+E+am1VjBAhEuRlO3CWU70tKuwVrfzpOwVAsqHTRpv16vZupHYk7G17NOWcQwcXB3Jcd+72aDyzzj1+0Fs33AOUqhnvX6FWHYdzNrUDS8IHByJ6Hz/2SeBzLMjkGz9gOXA+3OhIoOBllXu/m37qpeY6uYqUrqqlhMZl2e8vdfSuIlZEt8Z7+xMfSPVTbCTA0BGtu20vO9vogWXRD4WZD0oQB9DDBzqev2sWEl5ORDyqbNo20DcIqbSpprB5Dp4M44djOl5Fp5QRdPwQQak4RUv/kisXl01nvH44eFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUOFvJzW+pcJeAL1nkC7UPmJNPTznoRfAZxtbzGFJSo=;
 b=aHsAp69hsZTzAuHPa71pjYfaF5YRtnf+KxbzrEujZ0GDedEK1b2nGV6fYtsBl/56mbOKJ9fPMmdwnbwf9jTjQS7QANzg3y3s9Ra2YMRO2TyOaCgGUoPdS3ezF7wLTgcADdfWI6BsvabRSCcmVBirK7wv3s/pbYUVAITYdMrbodDbDXYsbI8ovbnlQP4h8HYMktyam7KwJ99/eUoWJ2hF+VGt6dIjbvYr0/dr6tWgRQU/YbxaCIoiiYk9WuQ1CUeug/GXPN79zEKuGOsinkZd0FWg0hVOjnViFPHmTbhhbofxRq6yAQ3okHvar4megYSBc98ozaxhAZnqsU98Umv0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUOFvJzW+pcJeAL1nkC7UPmJNPTznoRfAZxtbzGFJSo=;
 b=sJBC7Iu6D7yGqgx9QFD5Ugq34BPGjldL3OGJQ5OyFUBRRF8lKo5Esot18c/JuIVPA2ruzmM7OWgA5k6gl/Lmc6I7qHyUst5+Rq8MhJPsowlk3k4YXeaS22Uj5177QmxOdQrMoi346JVLxP904Js83mtWAX5o3x/7ZFmASsj8SbQ=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 02:06:17 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 02:06:17 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Paul Menzel
 <pmenzel+amd-gfx@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdgpu: fix the hw hang during perform system reboot
 and reset
Thread-Topic: [PATCH] drm/amdgpu: fix the hw hang during perform system reboot
 and reset
Thread-Index: AQHWEaV6yroNaTGg5k+xvucKhdrbSqh3KRIAgAAzIoCAACXhgIAAXOlg
Date: Tue, 14 Apr 2020 02:06:17 +0000
Message-ID: <BY5PR12MB430704888B483B631A309B9BFBDA0@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <1586790530-19464-1-git-send-email-Prike.Liang@amd.com>
 <CADnq5_Os9ePu+u0cmroyKRVyXroYD9Bggyy0Do1mWW18m5-Pbg@mail.gmail.com>
 <1dce548a-c6ea-183c-4c33-6b8f6bc3c6c8@molgen.mpg.de>
 <CADnq5_PSiUFG1uYYhFPs_-ukydHG=ErkBdg3sf6LcMNimY-zQg@mail.gmail.com>
In-Reply-To: <CADnq5_PSiUFG1uYYhFPs_-ukydHG=ErkBdg3sf6LcMNimY-zQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=efbaa93f-0687-49d6-87cd-00000efd4756;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T02:05:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2743e157-c9a8-4795-1c94-08d7e0186b0c
x-ms-traffictypediagnostic: BY5PR12MB4323:|BY5PR12MB4323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB432316D8956072C94673289CFBDA0@BY5PR12MB4323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(64756008)(66446008)(52536014)(66556008)(71200400001)(2906002)(66476007)(478600001)(66946007)(54906003)(9686003)(4326008)(186003)(5660300002)(76116006)(7696005)(110136005)(86362001)(316002)(55016002)(8676002)(53546011)(26005)(6506007)(33656002)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGK04dIdFl3zgwteXS6VizXL+NVJGZzOD5YXYqi0zK9+pbQTAroIIbyi7qrzIqPopvev4ExXWQsJk8xroBKuqI6wOV/oGie/arCsC8qC1RACLmZfYExnDRUPFC8at0TR68Rzl0dQbAIB6FRAcTZrbn8yQkZJWNMxXy6WyrzL8TRq9SVoE/HfAZtBwehcGawXUF7SLBs57+XuZwjcYipgUhiQ1kSBVjaOII7WfOqGTq769subuUJdnUcMpU2/pXtvl2PkGQKC/O4C3hYKeRY493vuwTfQOBFVTE2QxpWiwZW4hM7hi4wZA6AdhuUUBRYHfVPxQLYLEkARBIqhYysPlu1NAY4qYclHkAsK5hvQK9FnQucQ8/qTwBSvvscqinFo1DmBPhBPXn1zM8+2io+dICh0VomgaDFLxjZKqWeeUiIIJ3bZ6RyF/eC1E+H/ZOkT
x-ms-exchange-antispam-messagedata: Tc1MuPOHV29p1UiJ5s8/WOUrdKJz/L0yNLRvsVQxNYBZziQ8tL8mhiL+UCMMYQcoKX/WK20mz6nOyftQj7BsGs6TXl0JCsff0/DyUXtwGRTHMVgOFmV1NqeZX2rWJEmZ7kG6gmLYybrBwfR+Z/cXgQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2743e157-c9a8-4795-1c94-08d7e0186b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 02:06:17.3906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yb0X5DfkHyheze7gZRi+4FZHdT593pO2MNpz38VUE6bY0Hsgm/b0ZDvAzZA672Il
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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
Cc: "Kumar1, Rahul" <Rahul.Kumar1@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Johannes Hirte <johannes.hirte@datenkhaos.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiANCj4gT24gTW9uLCBBcHIgMTMsIDIwMjAgYXQgMjoxNyBQTSBQYXVsIE1lbnplbCA8cG1lbnpl
bCthbWQtDQo+IGdmeEBtb2xnZW4ubXBnLmRlPiB3cm90ZToNCj4gPg0KPiA+IERlYXIgQWxleCwg
ZGVhciBQcmlrZSwNCj4gPg0KPiA+DQo+ID4gQW0gMTMuMDQuMjAgdW0gMTc6MTQgc2NocmllYiBB
bGV4IERldWNoZXI6DQo+ID4gPiBPbiBNb24sIEFwciAxMywgMjAyMCBhdCAxMTowOSBBTSBQcmlr
ZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBV
bmlmeSBzZXQgZGV2aWNlIENHUEcgdG8gdW5nYXRlIHN0YXRlIGJlZm9yZSBlbnRlciBwb3dlcm9m
ZiBvciByZXNldC4NCj4gPiA+Pg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQ
cmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4+IFRlc3RlZC1ieTogTWVuZ2JpbmcgV2FuZyA8TWVu
Z2JpbmcuV2FuZ0BhbWQuY29tPg0KPiA+ID4NCj4gPiA+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4NCj4gPiBGaXJzdDoNCj4gPg0KPiA+IFRl
c3RlZC1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4gKE1TSSBCMzUwTSBN
T1JUQVINCj4gPiAoTVMtN0EzNykgd2l0aCBhbiBBTUQgUnl6ZW4gMyAyMjAwRykNCj4gPg0KPiA+
IFNlY29uZCwgSSBhbSBoYXZpbmcgdHJvdWJsZSB0byB1bmRlcnN0YW5kLCBob3cgeW91IGNhbiBh
ZGQgeW91cg0KPiA+IEFja2VkLWJ5IHRhZyB0byBhIGNvbW1pdCB3aXRoIHN1Y2ggYSBjb21taXQg
bWVzc2FnZT8NCj4gPg0KPiA+IFRoZSBwcm9ibGVtIGlzIG5vdCBkZXNjcmliZWQgKGFwcGFyZW50
bHkgaXQgb25seSBhZmZlY3RlZCBjZXJ0YWluDQo+ID4gZGV2aWNlcyksIGl0IGlzIG5vdCBtZW50
aW9uZWQgdGhhdCBpdOKAmXMgYSByZWdyZXNzaW9uIChGaXhlczogdGFnL2xpbmUNCj4gPiBpcyBt
aXNzaW5nKSwgYW5kIEkgYW0gaGF2aW5nIGEgaGFyZCB0aW1lIHRvIHVuZGVyc3RhbmQgdGhlIGNv
bW1pdA0KPiA+IG1lc3NhZ2UgYXQgYWxsIChhbmQgdGhlIG9uZSBmcm9tIHRoZSBjb21taXQgaW50
cm9kdWNpbmcgdGhlDQo+ID4gcmVncmVzc2lvbikuIFdoeSBpcyBpdCBtb3JlIG9yIGxlc3MgcmV2
ZXJ0aW5nIHBhcnQgb2YgdGhlIG90aGVyDQo+ID4gY29tbWl0LCB3aGlsZSB0aGUgaXNzdWUgd2Fz
IG5vdCByZXByb2R1Y2libGUgb24gUHJpa2XigJlzIHN5c3RlbT8NCj4gDQo+IFRoZSBvcmlnaW5h
bCBpc3N1ZSB3YXMgdGhhdCB3ZSB3ZXJlIG5vdCBwcm9wZXJseSB1bmdhdGluZyBzb21lIG9mIHRo
ZSBodw0KPiBibG9ja3MgaW4gdGhlIHJpZ2h0IG9yZGVyIGZvciBTMyBzdXNwZW5kIG9uIHJlbm9p
ci4gIFNvIHRoZSBmaXggd2FzIHRvIGFkZA0KPiB1bmdhdGUgY2FsbHMgdG8gYW1kZ3B1X2Rldmlj
ZV9zdXNwZW5kKCkgdG8gaGFuZGxlIHRoYXQgY2FzZS4NCj4gSG93ZXZlciwgdGhlIG9yaWdpbmFs
IGZpeCBzaG91bGQgbm90IGhhdmUgcmVtb3ZlZCB0aGUgY2FsbHMgZnJvbQ0KPiBhbWRncHVfZGV2
aWNlX2lwX3N1c3BlbmRfcGhhc2UxKCkgc2luY2UgdGhhdCBpcyBjYWxsZWQgc2VwYXJhdGVseSBm
b3INCj4gc29tZSBvdGhlciB1c2UgY2FzZXMgKGUuZy4sIHBjaSBzaHV0ZG93bikuICBJdCBkaWRu
J3QgbWF0dGVyIGZvciBzb21lIGFzaWNzIGFzDQo+IHRoZXkgZG9uJ3QgaGF2ZSBkaWZmZXJlbnQg
bGV2ZWxzIG9mIHBvd2VyZ2F0aW5nIGZ1bmN0aW9uYWxpdHkuICBJJ2xsIGFkZCB0aGUgZml4ZXMN
Cj4gdGFnIGJlZm9yZSB0aGUgcGF0Y2ggZ29lcyB1cHN0cmVhbS4NCj4gDQo+IEFsZXgNCj4gDQpb
UHJpa2VdICBUaGFua3MgQWxleCBoZWxwIGNsYXJpZnkgYW5kIEkgd2lsbCBnaXZlIG1vcmUgZGV0
YWlsIGluIHRoZSBtZXNzYWdlLg0KPiA+DQo+ID4gPj4gLS0tDQo+ID4gPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICsrDQo+ID4gPj4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiA+PiBpbmRleCA4N2Y3YzEy
Li5iYmUwOTBhIDEwMDY0NA0KPiA+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4+IEBAIC0yNDEzLDYgKzI0MTMsOCBAQCBzdGF0aWMgaW50
DQo+IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTEoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpDQo+ID4gPj4gICB7DQo+ID4gPj4gICAgICAgICAgaW50IGksIHI7DQo+ID4gPj4NCj4g
PiA+PiArICAgICAgIGFtZGdwdV9kZXZpY2Vfc2V0X3BnX3N0YXRlKGFkZXYsIEFNRF9QR19TVEFU
RV9VTkdBVEUpOw0KPiA+ID4+ICsgICAgICAgYW1kZ3B1X2RldmljZV9zZXRfY2dfc3RhdGUoYWRl
diwgQU1EX0NHX1NUQVRFX1VOR0FURSk7DQo+ID4gPj4NCj4gPiA+PiAgICAgICAgICBmb3IgKGkg
PSBhZGV2LT5udW1faXBfYmxvY2tzIC0gMTsgaSA+PSAwOyBpLS0pIHsNCj4gPiA+PiAgICAgICAg
ICAgICAgICAgIGlmICghYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy52YWxpZCkNCj4gPiA+PiAt
LQ0KPiA+ID4+IDIuNy40DQo+ID4NCj4gPiBLaW5kIHJlZ2FyZHMsDQo+ID4NCj4gPiBQYXVsDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
