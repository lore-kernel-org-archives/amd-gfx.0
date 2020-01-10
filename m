Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC69C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 22:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AFB206DA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Xyk1+Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AFB206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE266E0F4;
	Fri, 10 Jan 2020 22:58:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358A06E188
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 22:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ10iZjs2XHP/9H+aCoP7cpGB0TB8f8NjoUnblEPHPnfr4XdN1b89CuZdjdy3y1/ZrflJmIavGKZJvILtEnlt/gdCrQwOsA6ZTAvZ+yLWhRxQ6eLoyN0gaJNaGSjKcd56/5qlBqCZxlxUE68SrpPGlg4ECvOyAItuFL1c1XS5yBeS9+JDlexOzOMyEIqNuf/BzwgE8SOyHK7nCTt63o/IDoaP34y5sP9w7eq/gP+s95eN+6KDkkzFYT6Q6WGwbQ52MlrDL6cvm0fwEhyvMkJz6jQmexjpN7tZpSD1nexkiEkhT+DpKRGEp6SSXgTy7Z85ib0tsmisnDOI5+qBtMc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCOrIAlmbF/Xu9f+v1Kz0xHWZSxLDbw/mx1cpxR9vVk=;
 b=L5rP2EqADjVbUcUMop83k5lDbsP991BmFX/HW3mv5kxyaUUiF1iAGuqX/x6LSe5ZVOr8yx6b76q9SKHZ2dMVESsYwvpLy7VEjt500w649uyg59myQ/PP7BJChHSWoqwPTUE6xe+UvPQxk1R31dJB2f4bQEq7p7jAMv8zn8XdsM26JTrftQt+cVKXL65MYVj2xzAR3yLLG4dOnOnj48Alk/G6OLGUji/nJTcDuB0X/SYkN7wZz93pSgZxqTFNQg6V9MHCSbY4ek0nIxOu6pFjrk/FUoOmv430Pc+JL8DHFxQXsH10/Q0HErTpeX6rW13V3yzCPyutKl+C5l2i91S4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCOrIAlmbF/Xu9f+v1Kz0xHWZSxLDbw/mx1cpxR9vVk=;
 b=2Xyk1+OdM9WgVd4RxoNA2rMsqMpF6RkeRWAjYu3YIsmJGIduKVPyE8zdFtUO+G3e1isG++S814YOhDJ5XY3fo/GhFrZD6EhU5ZZ6y1vj4Vf7+IID3yBOMbjTq6iVT9Uzn4VPMJNFFa0fwhBhgyEqEpXD7uy4V+PsK5XwywWusLM=
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2797.namprd12.prod.outlook.com (52.135.102.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 22:58:48 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 22:58:48 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/8] drm/amdgpu: Avoid reclaim fs while eviction lock
Thread-Topic: [PATCH 1/8] drm/amdgpu: Avoid reclaim fs while eviction lock
Thread-Index: AQHVx08EsBwK/4dfOUmqVn69aOVydqfjw7GAgADASTA=
Date: Fri, 10 Jan 2020 22:58:48 +0000
Message-ID: <SN6PR12MB2621423E9B51FB845C1AF9DCFD380@SN6PR12MB2621.namprd12.prod.outlook.com>
References: <20200110004335.113095-1-alex.sierra@amd.com>
 <6eadf115-8ed0-22bd-9de9-b036c772e08c@gmail.com>
In-Reply-To: <6eadf115-8ed0-22bd-9de9-b036c772e08c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-10T22:58:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a9520863-87ac-44a6-8876-0000500f12d8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-10T22:58:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6dfb38fc-f90a-41d7-ad00-0000cc60cf09
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
x-originating-ip: [136.49.240.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d30df5bc-2bbd-4cad-6545-08d79620a731
x-ms-traffictypediagnostic: SN6PR12MB2797:|SN6PR12MB2797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27979A96EDEC70F18DB2D903FD380@SN6PR12MB2797.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:250;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(76116006)(316002)(81166006)(33656002)(66946007)(26005)(2906002)(86362001)(186003)(8676002)(9686003)(66476007)(66574012)(110136005)(5660300002)(52536014)(8936002)(66446008)(64756008)(55016002)(66556008)(7696005)(478600001)(53546011)(6506007)(71200400001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2797;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WV5fRGz2NrlwLJwpM3Nk1CRdjYM+0zTeqyPrQG6PkuXP6iT/NVohxTfMiDzkY7/TCFPukeDiae9hBfOhP7nWLovrRff3LL4yY4nz/bfWxVQMjKQPv1JHUxQaynZ+I02/h8Iue8Qmmt1LqGJFVrrH+wXtOne6jk4kAkNhaxzjXvUdfIqgfILjvgcs4sWuyVm5dFLQtlUZ/04Vml+T6Uqb0iEbxh2yXsmxp/yFnxl3lQIeWu/lMU+7xbKrPu7Gm+8EkT+RmRkfl6k+XsA6JLtmcpwYrfFOOsiqsOlO0fwgkhHIFQGO1T2uzHA7EETy9yXCp7TdAKT+mQryPGYkchUY/daxIe4pUh3ASenfH2RX//w0R8bglUepxPVNIa53n1I3IJMFKAEKun5JDBd/bCOqQXYPyanomUr6M6gfGJZcLR0qXzUeArYZPQ1CEjzrRlqE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30df5bc-2bbd-4cad-6545-08d79620a731
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 22:58:48.2167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Al2jVGjR7ASfVPXrLJOCIKwOnPz0rPGxpm4vWM16KqDLiyBjMuyz7XyQQcYxiCPR2vsMGSC4GGFXm96jByHpfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2797
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgbW9zdCByZWNlbiBvbmVzIHN0YXJ0IGF0Og0KW1BBVENIIDEvOF0gZHJtL2FtZGdwdTogQXZv
aWQgcmVjbGFpbSBmcyB3aGlsZSBldmljdGlvbiBsb2NrDQpUaHJvdWdoOg0KW1BBVENIIDgvOF0g
ZHJtL2FtZGdwdTogcmVwbGFjZSBrY3EgZW5hYmxlIGZ1bmN0aW9uIG9uIGdmeF92OQ0KDQpSZWdh
cmRzLA0KQWxleCBTaWVycmENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENo
cmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6
IEZyaWRheSwgSmFudWFyeSAxMCwgMjAyMCA1OjI5IEFNDQpUbzogU2llcnJhIEd1aXphLCBBbGVq
YW5kcm8gKEFsZXgpIDxBbGV4LlNpZXJyYUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS84XSBkcm0vYW1kZ3B1OiBBdm9pZCByZWNs
YWltIGZzIHdoaWxlIGV2aWN0aW9uIGxvY2sNCg0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0K
DQpMb29rcyBsaWtlIHlvdSBzZW5kIHRoYXQgcGF0Y2ggc2V0IG91dCB0d2ljZS4NCg0KV2hpY2gg
b25lIGlzIHRoZSBtb3N0IHJlY2VudCBvbmU/DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCkFt
IDEwLjAxLjIwIHVtIDAxOjQzIHNjaHJpZWIgQWxleCBTaWVycmE6DQo+IFtXaHldDQo+IEF2b2lk
IHJlY2xhaW0gZmlsZXN5c3RlbSB3aGlsZSBldmljdGlvbiBsb2NrIGlzIGhlbGQgY2FsbGVkIGZy
b20gTU1VIA0KPiBub3RpZmllci4NCj4NCj4gW0hvd10NCj4gU2V0dGluZyBQRl9NRU1BTExPQ19O
T0ZTIGZsYWdzIHdoaWxlIGV2aWN0aW9uIG11dGV4IGlzIGxvY2tlZC4NCj4gVXNpbmcgbWVtYWxs
b2Nfbm9mc19zYXZlIC8gbWVtYWxsb2Nfbm9mc19yZXN0b3JlIEFQSS4NCj4NCj4gQ2hhbmdlLUlk
OiBJNTUzMWM5MzM3ODM2ZTdkNGE0MzBkZjNmMTZkY2M4Mjg4OGU4MDE4Yw0KPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA0MCArKysrKysrKysrKysrKysrKysr
KystLS0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgIDYg
KysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4
IGI5OTliNjdmZjU3YS4uZDZhYmE0ZjlkZjc0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtODIsNiArODIsMzIgQEAgc3RydWN0IGFtZGdwdV9wcnRf
Y2Igew0KPiAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlX2NiIGNiOw0KPiAgIH07DQo+DQo+ICsvKioN
Cj4gKyAqIHZtIGV2aWN0aW9uX2xvY2sgY2FuIGJlIHRha2VuIGluIE1NVSBub3RpZmllcnMuIE1h
a2Ugc3VyZSBubyANCj4gK3JlY2xhaW0tRlMNCj4gKyAqIGhhcHBlbnMgd2hpbGUgaG9sZGluZyB0
aGlzIGxvY2sgYW55d2hlcmUgdG8gcHJldmVudCBkZWFkbG9ja3Mgd2hlbg0KPiArICogYW4gTU1V
IG5vdGlmaWVyIHJ1bnMgaW4gcmVjbGFpbS1GUyBjb250ZXh0Lg0KPiArICovDQo+ICtzdGF0aWMg
aW5saW5lIHZvaWQgYW1kZ3B1X3ZtX2V2aWN0aW9uX2xvY2soc3RydWN0IGFtZGdwdV92bSAqdm0p
IHsNCj4gKyAgICAgbXV0ZXhfbG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOw0KPiArICAgICB2bS0+
c2F2ZWRfZmxhZ3MgPSBtZW1hbGxvY19ub2ZzX3NhdmUoKTsgfQ0KPiArDQo+ICtzdGF0aWMgaW5s
aW5lIGludCBhbWRncHVfdm1fZXZpY3Rpb25fdHJ5bG9jayhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkg
ew0KPiArICAgICBpZiAobXV0ZXhfdHJ5bG9jaygmdm0tPmV2aWN0aW9uX2xvY2spKSB7DQo+ICsg
ICAgICAgICAgICAgdm0tPnNhdmVkX2ZsYWdzID0gbWVtYWxsb2Nfbm9mc19zYXZlKCk7DQo+ICsg
ICAgICAgICAgICAgcmV0dXJuIDE7DQo+ICsgICAgIH0NCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHN0
cnVjdCBhbWRncHVfdm0gKnZtKSB7DQo+ICsgICAgIG1lbWFsbG9jX25vZnNfcmVzdG9yZSh2bS0+
c2F2ZWRfZmxhZ3MpOw0KPiArICAgICBtdXRleF91bmxvY2soJnZtLT5ldmljdGlvbl9sb2NrKTsg
fQ0KPiArDQo+ICAgLyoqDQo+ICAgICogYW1kZ3B1X3ZtX2xldmVsX3NoaWZ0IC0gcmV0dXJuIHRo
ZSBhZGRyIHNoaWZ0IGZvciBlYWNoIGxldmVsDQo+ICAgICoNCj4gQEAgLTY3OCw5ICs3MDQsOSBA
QCBpbnQgYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+
DQo+IC0gICAgIG11dGV4X2xvY2soJnZtLT5ldmljdGlvbl9sb2NrKTsNCj4gKyAgICAgYW1kZ3B1
X3ZtX2V2aWN0aW9uX2xvY2sodm0pOw0KPiAgICAgICB2bS0+ZXZpY3RpbmcgPSBmYWxzZTsNCj4g
LSAgICAgbXV0ZXhfdW5sb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7DQo+ICsgICAgIGFtZGdwdV92
bV9ldmljdGlvbl91bmxvY2sodm0pOw0KPg0KPiAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+IEBA
IC0xNTU5LDcgKzE1ODUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGlu
ZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgaWYgKCEoZmxhZ3MgJiBBTURH
UFVfUFRFX1ZBTElEKSkNCj4gICAgICAgICAgICAgICBvd25lciA9IEFNREdQVV9GRU5DRV9PV05F
Ul9LRkQ7DQo+DQo+IC0gICAgIG11dGV4X2xvY2soJnZtLT5ldmljdGlvbl9sb2NrKTsNCj4gKyAg
ICAgYW1kZ3B1X3ZtX2V2aWN0aW9uX2xvY2sodm0pOw0KPiAgICAgICBpZiAodm0tPmV2aWN0aW5n
KSB7DQo+ICAgICAgICAgICAgICAgciA9IC1FQlVTWTsNCj4gICAgICAgICAgICAgICBnb3RvIGVy
cm9yX3VubG9jazsNCj4gQEAgLTE1NzYsNyArMTYwMiw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zt
X2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICBy
ID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsNCj4NCj4gICBlcnJv
cl91bmxvY2s6DQo+IC0gICAgIG11dGV4X3VubG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOw0KPiAr
ICAgICBhbWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsNCj4gICAgICAgcmV0dXJuIHI7DQo+
ICAgfQ0KPg0KPiBAQCAtMjUzNywxOCArMjU2MywxOCBAQCBib29sIGFtZGdwdV92bV9ldmljdGFi
bGUoc3RydWN0IGFtZGdwdV9ibyAqYm8pDQo+ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
Pg0KPiAgICAgICAvKiBUcnkgdG8gYmxvY2sgb25nb2luZyB1cGRhdGVzICovDQo+IC0gICAgIGlm
ICghbXV0ZXhfdHJ5bG9jaygmYm9fYmFzZS0+dm0tPmV2aWN0aW9uX2xvY2spKQ0KPiArICAgICBp
ZiAoIWFtZGdwdV92bV9ldmljdGlvbl90cnlsb2NrKGJvX2Jhc2UtPnZtKSkNCj4gICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+DQo+ICAgICAgIC8qIERvbid0IGV2aWN0IFZNIHBhZ2UgdGFi
bGVzIHdoaWxlIHRoZXkgYXJlIHVwZGF0ZWQgKi8NCj4gICAgICAgaWYgKCFkbWFfZmVuY2VfaXNf
c2lnbmFsZWQoYm9fYmFzZS0+dm0tPmxhc3RfZGlyZWN0KSB8fA0KPiAgICAgICAgICAgIWRtYV9m
ZW5jZV9pc19zaWduYWxlZChib19iYXNlLT52bS0+bGFzdF9kZWxheWVkKSkgew0KPiAtICAgICAg
ICAgICAgIG11dGV4X3VubG9jaygmYm9fYmFzZS0+dm0tPmV2aWN0aW9uX2xvY2spOw0KPiArICAg
ICAgICAgICAgIGFtZGdwdV92bV9ldmljdGlvbl91bmxvY2soYm9fYmFzZS0+dm0pOw0KPiAgICAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPg0KPiAgICAgICBib19iYXNlLT52
bS0+ZXZpY3RpbmcgPSB0cnVlOw0KPiAtICAgICBtdXRleF91bmxvY2soJmJvX2Jhc2UtPnZtLT5l
dmljdGlvbl9sb2NrKTsNCj4gKyAgICAgYW1kZ3B1X3ZtX2V2aWN0aW9uX3VubG9jayhib19iYXNl
LT52bSk7DQo+ICAgICAgIHJldHVybiB0cnVlOw0KPiAgIH0NCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oDQo+IGluZGV4IDEwMDU0N2YwOTRmZi4uYzIxYTM2YmVi
YzBjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
aA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KPiBAQCAt
MzAsNiArMzAsNyBAQA0KPiAgICNpbmNsdWRlIDxkcm0vZ3B1X3NjaGVkdWxlci5oPg0KPiAgICNp
bmNsdWRlIDxkcm0vZHJtX2ZpbGUuaD4NCj4gICAjaW5jbHVkZSA8ZHJtL3R0bS90dG1fYm9fZHJp
dmVyLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQvbW0uaD4NCj4NCj4gICAjaW5jbHVkZSAi
YW1kZ3B1X3N5bmMuaCINCj4gICAjaW5jbHVkZSAiYW1kZ3B1X3JpbmcuaCINCj4gQEAgLTI0Miw5
ICsyNDMsMTIgQEAgc3RydWN0IGFtZGdwdV92bSB7DQo+ICAgICAgIC8qIHRyZWUgb2YgdmlydHVh
bCBhZGRyZXNzZXMgbWFwcGVkICovDQo+ICAgICAgIHN0cnVjdCByYl9yb290X2NhY2hlZCAgIHZh
Ow0KPg0KPiAtICAgICAvKiBMb2NrIHRvIHByZXZlbnQgZXZpY3Rpb24gd2hpbGUgd2UgYXJlIHVw
ZGF0aW5nIHBhZ2UgdGFibGVzICovDQo+ICsgICAgIC8qIExvY2sgdG8gcHJldmVudCBldmljdGlv
biB3aGlsZSB3ZSBhcmUgdXBkYXRpbmcgcGFnZSB0YWJsZXMNCj4gKyAgICAgICogdXNlIHZtX2V2
aWN0aW9uX2xvY2svdW5sb2NrKHZtKQ0KPiArICAgICAgKi8NCj4gICAgICAgc3RydWN0IG11dGV4
ICAgICAgICAgICAgZXZpY3Rpb25fbG9jazsNCj4gICAgICAgYm9vbCAgICAgICAgICAgICAgICAg
ICAgZXZpY3Rpbmc7DQo+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIHNhdmVkX2ZsYWdz
Ow0KPg0KPiAgICAgICAvKiBCT3Mgd2hvIG5lZWRzIGEgdmFsaWRhdGlvbiAqLw0KPiAgICAgICBz
dHJ1Y3QgbGlzdF9oZWFkICAgICAgICBldmljdGVkOw0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
