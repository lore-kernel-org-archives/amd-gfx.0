Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE8C432C3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 02:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CF220684
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 02:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CF220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2A96E36F;
	Tue,  3 Dec 2019 02:45:25 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051906E36F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 02:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1L2Bpd2Flb44uOfrq2TAMteulS5exCKo6cbPv1mfwSoALW7+mkea6qzWCRt0NEjnqUNEeFVOcbqm7HEfjufwv0BXd6Le3xc1Cgw2bBLU4mazPFSbAKp9FZOWAa7TLSYaJQw6L7H8jWQcl8z4y9H0BL88HR07kjVplhxOkbY1SgXljiHelbZ1mgy40Z4Ak2Z5EGmqzzCKH7CZel7PJXSuVEpgiMMtLfPZsOLha4iBb4oxmKcz4Mvu49Mf/C8zZ2ROHs3JMRqxrsWHib5ciLDfKbO7ltCcguXCtSABecu4uv/dvixBqOpHl0JOCy51O1q1RW8QPSqo0Nzh49wZU/sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY3dfJk7BqUvrGrRjSRIHsvNrHX/J/tGHkUK45qhp2A=;
 b=UzG8Uu1t0MGa2wkmUYCnf8gCHbtjgMx6xFSti57eWiUX9kljVireOPBEpwIyK00fT/LP2447x8yyuFYnlE9OLGTXeYm3PCjUetmbZUAS7p7ng9Y/SzN3fps3WCfkaUVa19GeOHjeIJ8NUh60fZ5ifqwv+LafTE28mXHRYvTe3vK4Rg8iHwam0Edhg3gHHs82pwDiQX0xNA3ViN1YVWqE9kOf/cbId+wsi12YsBtlcL08+rsmerZScvmd0VcXfiJsK/CsPy6rbm8YEY26VUmXeUcFjODXIk8+fFC+Cycpd5p7ApfrkgAAL1oQdJg+mat34MceaVSafg2y2WzVX3dt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3053.namprd12.prod.outlook.com (20.178.241.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 02:45:21 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:45:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Topic: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Index: AQHVqQBtXBi8Xe8ibU6y7MepLXu1v6entITA
Date: Tue, 3 Dec 2019 02:45:21 +0000
Message-ID: <MN2PR12MB33443E4D35A2E56F584EFAECE4420@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191202110519.3504-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191202110519.3504-1-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d1026164-0d2f-4b15-8098-0000ec740321;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-03T02:42:10Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c01d089-6558-40c2-c790-08d7779ad76c
x-ms-traffictypediagnostic: MN2PR12MB3053:|MN2PR12MB3053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30532553A295C8D01E784354E4420@MN2PR12MB3053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(13464003)(199004)(189003)(45080400002)(71200400001)(66556008)(305945005)(186003)(74316002)(76176011)(14454004)(66946007)(966005)(76116006)(66476007)(64756008)(66446008)(86362001)(8676002)(66066001)(33656002)(2501003)(6116002)(3846002)(99286004)(2906002)(11346002)(26005)(446003)(6506007)(229853002)(102836004)(6306002)(25786009)(9686003)(7736002)(8936002)(14444005)(4326008)(316002)(6246003)(53546011)(256004)(81156014)(81166006)(5660300002)(478600001)(110136005)(6436002)(71190400001)(52536014)(7696005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3053;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OE5w9kC3iuM/Wra8Cw7YODOFmuddFUuzm+J5ZoiqryH/xFjeSwIhLcon/+LGC9cyJP4WHEpbwzqMwm2JZTxjixw1kFrCf55MubtWD47e0V+Id5uvHuKWyokOnQ6FDI8f5k3peZfSHBtVNCuTVZyLgO59T9rGwOe+pAiCLzKZX+q7lUCZR6Zbps7D/q5281VerfjBTHs8shDIMZe0wfFHa89tMXS/k6y5JBGMoKxqft5wLrncIZueGk/crl9/t05D6gM4cHqAkLu0gNwr3mBxrrN2Vm6Es5iMvk10yvRWQ+QNtMFHdwLmFFCg5Ktlix4x8BxM/AcwzWZguzR03OjU7UCO1kxyN3+KV0EkmH7vpMXaW3eEpbDZ8wp6gr0EafRM9C1t/efAeptAk/xQhhpdMNa3YgpZk0zE/8fhl/VFrHA2v16RqXlUnledp3r3Tl8fFZpRdgrzjPLUyyYfUJKNCVHVMzyX7LVhZKMaDaYo300=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c01d089-6558-40c2-c790-08d7779ad76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:45:21.8234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDzArOW4xYC5gXT1VUdyuzSsupkA9tVdv0hxSfF1bzOteCr1si7nZYCecpB4EGaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY3dfJk7BqUvrGrRjSRIHsvNrHX/J/tGHkUK45qhp2A=;
 b=mDpaS08NjH5IXhL23wqaN6/iU1NiqyVe9kj511TQXgW4SVemrL2+l8tNENS7N24N5FVJ/TPUighQS0cL6kMls6c0jIwDDMwyXL1p0x6O38U8v3rpoykOvvJesesoRvse1f58RfCUvtlQA4JID3Awqd7syish+NGzaewOqRGKqFY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEphY2sNCj4gWmhh
bmcNCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDE5IDc6MDUgUE0NCj4gVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaGFuZywgSmFjayAoSmlhbikgPEphY2su
WmhhbmcxQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gYW1kL2FtZGdwdS9zcmlvdiBzd1NN
VSBkaXNhYmxlIGZvciBzcmlvdg0KPiANCj4gRm9yIGJvYXJkcyBncmVhdGVyIHRoYW4gQVJDVFVS
VVMsIGFuZCB1bmRlciBzcmlvdiBwbGF0Zm9ybSwNCj4gc3dTTVUgaXMgbm90IHN1cHBvcnRlZCBi
ZWNhdXNlIHNtdSBpcCBibG9jayBpcyBjb21tZW50ZWQgYXQNCj4gZ3Vlc3QgZHJpdmVyLg0KPiAN
Cj4gR2VuZXJhbGx5IGZvciBzcmlvdiwgaW5pdGlhbGl6YXRpb24gb2Ygc211IGlzIG1vdmVkIHRv
IGhvc3QgZHJpdmVyLg0KPiBUaHVzLCBzbXUgc3dfaW5pdCBhbmQgaHdfaW5pdCB3aWxsIG5vdCBi
ZSBleGVjdXRlZCBhdCBndWVzdCBkcml2ZXIuDQo+IA0KPiBXaXRob3V0IHN3IHN0cnVjdHVyZSBi
ZWluZyBpbml0aWFsaXplZCBpbiBndWVzdCBkcml2ZXIsIHN3U01VIGNhbm5vdA0KPiBkZWNsYXJl
IHRvIGJlIHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphY2sgWmhhbmcgPEphY2su
WmhhbmcxQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYw0KPiBpbmRleCAzNjAwMWE0Li4wYjhhNTNiIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+IEBAIC01MzEsNyArNTMxLDEw
IEBAIGJvb2wgaXNfc3VwcG9ydF9zd19zbXUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
ICAJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkNCj4gIAkJcmV0dXJuIChhbWRn
cHVfZHBtID09IDIpID8gdHJ1ZSA6IGZhbHNlOw0KPiAgCWVsc2UgaWYgKGFkZXYtPmFzaWNfdHlw
ZSA+PSBDSElQX0FSQ1RVUlVTKQ0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gKwkJaWYgKGFtZGdwdV9z
cmlvdl92ZihhZGV2KSkNCj4gKwkJCXJldHVybiBmYWxzZTsNCj4gKwkJZWxzZQ0KPiArCQkJcmV0
dXJuIHRydWU7DQpbUXVhbiwgRXZhbl0gQXJlICJ7IiBhbmQgIn0iIG1pc3NpbmcgYXJvdW5kIHRo
aXMgY29kZSBibG9jaz8gVGhpcyBzZWVtcyBhIGxpdHRsZSB3ZWlyZC4NCj4gIAllbHNlDQo+ICAJ
CXJldHVybiBmYWxzZTsNCj4gIH0NCj4gLS0NCj4gMi43LjQNCj4gDQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0
DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWUN
Cj4gZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+IGdmeCZhbXA7ZGF0
YT0wMiU3QzAxJTdDZXZhbi5xdWFuJTQwYW1kLmNvbSU3Q2EwMTE5MDk5YTNkYjQ1MDU1NA0KPiBm
MjA4ZDc3NzE3OGI1ZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2MzcxDQo+IDA4ODE1Mzg0NzcyMDQwJmFtcDtzZGF0YT04UkoxUXlEekhFY25PbmswRUJHa2hm
VmxqZWlQV2FaU05sTzZPeUFhDQo+IGVuYyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
