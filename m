Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF2FC72903
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A7824656
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZUzSku9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7824656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B91C6E8D8;
	Thu, 27 Feb 2020 14:23:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7F16E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awiHRzRKoi3mv/H4ganZjI8c+xfqM3q6FBS+XmUESWDQyQj39ysl7Duu+MQ/NvJaQmr01uSL5I9J1N+mR0+rX1NYiGlTDWJjsMSxM4NvAnuP7UPVyX6MPl5Ul5Xfj+uKy0WBiamfRH3iIGFPThN8x2rifVoED/VUPmddJzWieXR8Zv5OUsjwwBjiJxTURLubAWH0NvaB+BTWSTcmtaUxYzNZlzzXjkEN/spaZPu+mDtsoSHexvR3E+B0rvFuyPloP/KKrEdPgVXN0fz+opo1x0Bj4mSbTm5t7JBhRnXEZ3KNnMXCPAhrCY8fUhXrhfv1KsEFWpWND9Ok05/G48LwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgphlKhpTLC++pGGegDWIcInLH1ujc/9d390D6+DlAY=;
 b=cUfdK0Y597pCuRgm9eGuZsw5T7DaotDMhVKbew5XQV9UgjqrnGKAyQy+SBOkVdkDQJwsh6ZuVqRnGs9D32Jb2ZmAklG0KVxVEu3lpqyVqJBzYosN896WC9P8pCZWNOGO5Kz1/jx98NNMxYqbQYodJAt7HYY9ufdUhr6+GSfQLPdPFQvpncZzXtKMzZyBRemmpCMkbUYhwvI+x7JZVsNU+WFf9f/EdWcmmBe4aubYG3FmqhVDeYV58hCHqBkTEdsWOH+dD1yYJ0gB+/eCsowEMhJb1818nZUYeOlbFr4RsbLuOni3pbEGNH2NGdtyWZ+opVucJj7NLb2hAmEdWcTF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgphlKhpTLC++pGGegDWIcInLH1ujc/9d390D6+DlAY=;
 b=ZUzSku9pNziEFa+jtZ/1pCcbbtKjwhYTqBzWr5/ZwkF2L+Kqx7V8kzEQ1lT4+we/d0nWwM3JW4Bg8DQpwhSRPvGKUG7X6vslVpYgrtfGjLTr1y9DAnbYq5MCVtHs03eKgn9Qej4CfIdT+gnRd4ySsnrw11iRlK6tYz49T2w6mMU=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 14:23:55 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::7cc0:785c:ea66:ef94]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::7cc0:785c:ea66:ef94%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 14:23:55 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: release drm_device after
 amdgpu_driver_unload_kms
Thread-Topic: [PATCH] drm/amdgpu: release drm_device after
 amdgpu_driver_unload_kms
Thread-Index: AQHV7WU00w+VuhWfCE+7Zssp8BrwdKgvF32AgAAAtkA=
Date: Thu, 27 Feb 2020 14:23:55 +0000
Message-ID: <MN2PR12MB3039E6228EDB281A5740D054E5EB0@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200227115807.32698-1-yttao@amd.com>
 <9f4eba96-e0a1-0823-4189-1c9f6d8bd248@gmail.com>
In-Reply-To: <9f4eba96-e0a1-0823-4189-1c9f6d8bd248@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7c646c3-abab-4572-4a46-08d7bb90ad4e
x-ms-traffictypediagnostic: MN2PR12MB4344:|MN2PR12MB4344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4344DF82472C1ACFAC521889E5EB0@MN2PR12MB4344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(71200400001)(66946007)(8936002)(76116006)(81156014)(8676002)(81166006)(52536014)(6636002)(4326008)(5660300002)(2906002)(6506007)(478600001)(316002)(53546011)(64756008)(66446008)(66556008)(86362001)(110136005)(26005)(55016002)(7696005)(33656002)(9686003)(186003)(45080400002)(66574012)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4344;
 H:MN2PR12MB3039.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oDf47Kt1cBl3JPKS4WEy5B/txzLMKuIECi1L8DGFUPAHnr9AURD17eEV12Auhxj7XYlqXM6uhJFkNdktdUhEVWChF2OVPvQ9kCf01efgWawy+dUeHivxC0WE7u0eAWjosJ/1Wwq4ApWLSFlCjUK9ZpYCjphGJ0juKARFCUMRCCAO+MTindw/fMFJk1aAgwM5ct2bYrO33wtGzTD4MNz5ov2cIyblB7TgfY6ktwa3dEo0ScMYqyMAj+QmaWChpmjkCnEkYSU429Et16MEB6EIE9HF+f4LzmNafSJ/QyL6jBOYnkIIpM+QWpTmyq76Y1e8g7gy9GKGenpRAAqfdgx7b0uMMntsQH1NC1L8ZyLGOb0/W4+G3UMPImZKRDg9EqgJCjgQeTyDnaCOohjSXUwuTK6VfKcvjp/etfHLuIPQknMtuqovDPgknoREdrXRUcOs
x-ms-exchange-antispam-messagedata: 7Rg0Q5bmd9MAZdGgVj+IMjxACT3DuwOhfU+/7cVYTHBq5l+qkQDldyfGPTuJvjR+lDei1g4IjmIJH2vkyLBUgJKS5Cf8BNH/fK1FgcmKFTlzROOYsFFYRHODcZyZ+Xj37TD3nrIjCemqm/AZTE0Z0g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c646c3-abab-4572-4a46-08d7bb90ad4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:23:55.1709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNp/JxFJbyBVx03pvIrQBc3zDv8X2yakTCiRcj0UeAjUnJovjQg2og4n1nuqCPkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TWFueSB0aGFua3MuIEkgd2lsbCBwdXQgaXQgYWZ0ZXIgcGNpXyogZnVuY3Rpb25zLg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDogMjAyMOW5tDLmnIgyN+aXpSAyMjoyMQ0K
VG86IFRhbywgWWludGlhbiA8WWludGlhbi5UYW9AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlbGVhc2UgZHJtX2RldmljZSBhZnRlciBh
bWRncHVfZHJpdmVyX3VubG9hZF9rbXMNCg0KQW0gMjcuMDIuMjAgdW0gMTI6NTggc2NocmllYiBZ
aW50aWFuIFRhbzoNCj4gSWYgd2UgcmVsZWFzZSBkcm1fZGV2aWNlIGJlZm9yZSBhbWRncHVfZHJp
dmVyX3VubG9hZF9rbXMsIHRoZW4gaXQgd2lsbCANCj4gcmFpc2UgdGhlIGVycm9yIGJlbG93LiBU
aGVyZWZvcmUsIHdlIG5lZWQgdG8gcGxhY2UgaXQgYmVmb3JlIA0KPiBhbWRncHVfZHJpdmVyX3Vu
bG9hZF9rbXMuDQo+IFsgICA0My4wNTU3MzZdIE1lbW9yeSBtYW5hZ2VyIG5vdCBjbGVhbiBkdXJp
bmcgdGFrZWRvd24uDQo+IFsgICA0My4wNTU3NzddIFdBUk5JTkc6IENQVTogMSBQSUQ6IDI4MDcg
YXQgL2J1aWxkL2xpbnV4LWh3ZS05S0owN3EvbGludXgtaHdlLTQuMTguMC9kcml2ZXJzL2dwdS9k
cm0vZHJtX21tLmM6OTEzIGRybV9tbV90YWtlZG93bisweDI0LzB4MzAgW2RybV0NCj4gWyAgIDQz
LjA1NTc3OF0gTW9kdWxlcyBsaW5rZWQgaW46IGFtZGdwdShPRS0pIGFtZF9zY2hlZChPRSkgYW1k
dHRtKE9FKSBhbWRrY2woT0UpIGFtZF9pb21tdV92MiBkcm1fa21zX2hlbHBlciBkcm0gaTJjX2Fs
Z29fYml0IGZiX3N5c19mb3BzIHN5c2NvcHlhcmVhIHN5c2ZpbGxyZWN0IHN5c2ltZ2JsdCBzbmRf
aGRhX2NvZGVjX2dlbmVyaWMgbmZpdCBrdm1faW50ZWwga3ZtIGlycWJ5cGFzcyBjcmN0MTBkaWZf
cGNsbXVsIGNyYzMyX3BjbG11bCBzbmRfaGRhX2ludGVsIHNuZF9oZGFfY29kZWMgc25kX2hkYV9j
b3JlIHNuZF9od2RlcCBzbmRfcGNtIGdoYXNoX2NsbXVsbmlfaW50ZWwgc25kX3NlcV9taWRpIHNu
ZF9zZXFfbWlkaV9ldmVudCBwY2JjIHNuZF9yYXdtaWRpIHNuZF9zZXEgc25kX3NlcV9kZXZpY2Ug
YWVzbmlfaW50ZWwgc25kX3RpbWVyIGpveWRldiBhZXNfeDg2XzY0IGNyeXB0b19zaW1kIGNyeXB0
ZCBnbHVlX2hlbHBlciBzbmQgc291bmRjb3JlIGlucHV0X2xlZHMgbWFjX2hpZCBzZXJpb19yYXcg
cWVtdV9md19jZmcgYmluZm10X21pc2Mgc2NoX2ZxX2NvZGVsIG5mc2QgYXV0aF9ycGNnc3MgbmZz
X2FjbCBsb2NrZCBncmFjZSBzdW5ycGMgcGFycG9ydF9wYyBwcGRldiBscCBwYXJwb3J0IGlwX3Rh
YmxlcyB4X3RhYmxlcyBhdXRvZnM0IGhpZF9nZW5lcmljIGZsb3BweSB1c2JoaWQgcHNtb3VzZSBo
aWQgaTJjX3BpaXg0IGUxMDAwIHBhdGFfYWNwaQ0KPiBbICAgNDMuMDU1ODE5XSBDUFU6IDEgUElE
OiAyODA3IENvbW06IG1vZHByb2JlIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICA0LjE4LjAt
MTUtZ2VuZXJpYyAjMTZ+MTguMDQuMS1VYnVudHUNCj4gWyAgIDQzLjA1NTgyMF0gSGFyZHdhcmUg
bmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xMi4w
LTEgMDQvMDEvMjAxNA0KPiBbICAgNDMuMDU1ODMwXSBSSVA6IDAwMTA6ZHJtX21tX3Rha2Vkb3du
KzB4MjQvMHgzMCBbZHJtXQ0KPiBbICAgNDMuMDU1ODMxXSBDb2RlOiA4NCAwMCAwMCAwMCAwMCAw
MCAwZiAxZiA0NCAwMCAwMCA0OCA4YiA0NyAzOCA0OCA4MyBjNyAzOCA0OCAzOSBjNyA3NSAwMiBm
MyBjMyA1NSA0OCBjNyBjNyAzOCAzMyA4MCBjMCA0OCA4OSBlNSBlOCAxYyA0MSBlYyBkMCA8MGY+
IDBiIDVkIGMzIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwIDU1IDQ4IDg5
IGU1IDQxDQo+IFsgICA0My4wNTU4NTddIFJTUDogMDAxODpmZmZmYWUzM2MxMzkzZDI4IEVGTEFH
UzogMDAwMTAyODYNCj4gWyAgIDQzLjA1NTg1OV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDog
ZmZmZjk2NTFiNGEyOTgwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDYNCj4gWyAgIDQzLjA1NTg2MF0g
UkRYOiAwMDAwMDAwMDAwMDAwMDA3IFJTSTogMDAwMDAwMDAwMDAwMDA5NiBSREk6IGZmZmY5NjUx
YmZjOTY0YjANCj4gWyAgIDQzLjA1NTg2MV0gUkJQOiBmZmZmYWUzM2MxMzkzZDI4IFIwODogMDAw
MDAwMDAwMDAwMDJhNiBSMDk6IDAwMDAwMDAwMDAwMDAwMDQNCj4gWyAgIDQzLjA1NTg2MV0gUjEw
OiBmZmZmYWUzM2MxMzkzZDIwIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IGZmZmY5NjUxYmE2
Y2IwMDANCj4gWyAgIDQzLjA1NTg2M10gUjEzOiBmZmZmOTY1MWI3ZjQwMDAwIFIxNDogZmZmZmZm
ZmZjMGRlM2ExMCBSMTU6IGZmZmY5NjUxYmE1YzY0NjANCj4gWyAgIDQzLjA1NTg2NF0gRlM6ICAw
MDAwN2YxZDNjMDhkNTQwKDAwMDApIEdTOmZmZmY5NjUxYmZjODAwMDAoMDAwMCkga25sR1M6MDAw
MDAwMDAwMDAwMDAwMA0KPiBbICAgNDMuMDU1ODY1XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAw
MDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsgICA0My4wNTU4NjZdIENSMjogMDAwMDU2MzBh
NTgzMTY0MCBDUjM6IDAwMDAwMDAxMmUyNzQwMDQgQ1I0OiAwMDAwMDAwMDAwMzYwNmUwDQo+IFsg
ICA0My4wNTU4NzBdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAg
RFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICA0My4wNTU4NzFdIERSMzogMDAwMDAwMDAwMDAw
MDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IFsgICA0
My4wNTU4NzFdIENhbGwgVHJhY2U6DQo+IFsgICA0My4wNTU4ODVdICBkcm1fdm1hX29mZnNldF9t
YW5hZ2VyX2Rlc3Ryb3krMHgxYi8weDMwIFtkcm1dDQo+IFsgICA0My4wNTU4OTRdICBkcm1fZ2Vt
X2Rlc3Ryb3krMHgxOS8weDQwIFtkcm1dDQo+IFsgICA0My4wNTU5MDNdICBkcm1fZGV2X2Zpbmkr
MHg3Zi8weDkwIFtkcm1dDQo+IFsgICA0My4wNTU5MTFdICBkcm1fZGV2X3JlbGVhc2UrMHgyYi8w
eDQwIFtkcm1dDQo+IFsgICA0My4wNTU5MTldICBkcm1fZGV2X3VucGx1ZysweDY0LzB4ODAgW2Ry
bV0NCj4gWyAgIDQzLjA1NTk5NF0gIGFtZGdwdV9wY2lfcmVtb3ZlKzB4MzkvMHg3MCBbYW1kZ3B1
XQ0KPiBbICAgNDMuMDU1OTk4XSAgcGNpX2RldmljZV9yZW1vdmUrMHgzZS8weGMwDQo+IFsgICA0
My4wNTYwMDFdICBkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHgxOGEvMHgyNjANCj4g
WyAgIDQzLjA1NjAwM10gIGRyaXZlcl9kZXRhY2grMHgzZi8weDgwDQo+IFsgICA0My4wNTYwMDRd
ICBidXNfcmVtb3ZlX2RyaXZlcisweDU5LzB4ZDANCj4gWyAgIDQzLjA1NjAwNl0gIGRyaXZlcl91
bnJlZ2lzdGVyKzB4MmMvMHg0MA0KPiBbICAgNDMuMDU2MDA4XSAgcGNpX3VucmVnaXN0ZXJfZHJp
dmVyKzB4MjIvMHhhMA0KPiBbICAgNDMuMDU2MDg3XSAgYW1kZ3B1X2V4aXQrMHgxNS8weDU3YyBb
YW1kZ3B1XQ0KPiBbICAgNDMuMDU2MDkwXSAgX194NjRfc3lzX2RlbGV0ZV9tb2R1bGUrMHgxNDYv
MHgyODANCj4gWyAgIDQzLjA1NjA5NF0gIGRvX3N5c2NhbGxfNjQrMHg1YS8weDEyMA0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMiArLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBpbmRleCAwMmQ4MGI5ZGJmZTEuLjAxYTEw
ODJiNWNhYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0K
PiBAQCAtMTEzOCw4ICsxMTM4LDggQEAgYW1kZ3B1X3BjaV9yZW1vdmUoc3RydWN0IHBjaV9kZXYg
KnBkZXYpDQo+ICAgI2VuZGlmDQo+ICAgCQlEUk1fRVJST1IoIkhvdHBsdWcgcmVtb3ZhbCBpcyBu
b3Qgc3VwcG9ydGVkXG4iKTsNCj4gICAJZHJtX2Rldl91bnBsdWcoZGV2KTsNCj4gLQlkcm1fZGV2
X3B1dChkZXYpOw0KPiAgIAlhbWRncHVfZHJpdmVyX3VubG9hZF9rbXMoZGV2KTsNCj4gKwlkcm1f
ZGV2X3B1dChkZXYpOw0KPiAgIAlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7DQo+ICAgCXBjaV9z
ZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsNCg0KTWF5YmUgZXZlbiBwdXQgdGhpcyBhZnRlciB0aGUg
cGNpXyogZnVuY3Rpb25zPw0KDQpBdCBsZWFzdCBwY2lfc2V0X2RydmRhdGEoKSBzb3VuZHMgbGlr
ZSBpdCBuZWVkcyB0byBjb21lIGJlZm9yZSB3ZSByZWxlYXNlIHRoZSBzdHJ1Y3R1cmUuDQoNCkNo
cmlzdGlhbi4NCg0KPiAgIH0NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
