Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63723C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 01:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7AF2075C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 01:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7AF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A7B6E0BA;
	Fri,  6 Dec 2019 01:43:13 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700066.outbound.protection.outlook.com [40.107.70.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177936E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 01:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLOXGxcuiOaoJWerTaCZxd/j9bDTY95KH820tMeuj3tpdLbfKjDqJPv8qjKOjo/BNd73tUoF4vGI8kEkF3yuXXOZU9ahgjVagjDa67c1+U+KjPJGFIxVkouz1WaNsZeQxqV44tUnLDspG+m6t6E7TlnBtdWt/Can6L4ZnvGbza6CBrCXXNd5dfLnxjlouZVK6l+3i9llYyY35WtBxSbpWFUF5medXKGU0wAsBsY/q1mgE1ItK0ijz+vt/zIxltKFlgB72WcSA1SP3ym4T1/v9fpRfLN7LKM0Tg/E1Eh+KH0Z98Rb1++TtobUFm9YwCG4OYFW1syVRQtvwiOClHrdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4Hzx6XeIw8b+OncYChknwYLqkT2ncwJv7TxFMx5CGw=;
 b=Y1mZrWtq/bFmQASnDl2Gcpu3ZaOKi183yz033IyYJv1fkcpjrBtS4TciOsV/o+k6Skb4fUSpmKKNLv0hndH9RLOokxb/8rBWgNRCfqS3xVkS7PCj0w4gx4JSTuxZvCAjivI7YzS6FTJDNFi8Sva/e3rl8CZdhd1X3TTLrdG8yeXgu7xDaCFfLT5YwKt1BpU2+q6wrAJgnw4nMo4rGyBHP0OYmTvbBWJ23jSFu28WNow1pjiszQ9RO+z3KN08cgKWEwV/7fvPfGXftN5K6RABbg57zu/Px9Fvdl2rs3ncuYgUyafStY28/ORtZyInlP16m0ypHvJVjMECYcb2e5BJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3129.namprd12.prod.outlook.com (20.178.198.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 01:43:10 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 01:43:10 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Christian Pernegger <pernegger@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for
 fences timed out or interrupted!
Thread-Topic: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for
 fences timed out or interrupted!
Thread-Index: AQHVq8HxWxtHAPTWe0S5DBDk33/qO6esU+MA
Date: Fri, 6 Dec 2019 01:43:10 +0000
Message-ID: <DM6PR12MB3466514DDFE311ACBECE0B259E5F0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <CAKbQEqEE3dgcF1bi-Sh5FQoHiU2TEHYn-H5fE92g6Pa+rgXbiQ@mail.gmail.com>
In-Reply-To: <CAKbQEqEE3dgcF1bi-Sh5FQoHiU2TEHYn-H5fE92g6Pa+rgXbiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2207e8d3-b91c-4193-170e-08d779eda6c4
x-ms-traffictypediagnostic: DM6PR12MB3129:
x-microsoft-antispam-prvs: <DM6PR12MB3129854E374D28A398B35F6A9E5F0@DM6PR12MB3129.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(13464003)(199004)(189003)(229853002)(71200400001)(7696005)(11346002)(25786009)(316002)(8676002)(86362001)(71190400001)(14454004)(2906002)(966005)(55016002)(110136005)(478600001)(53546011)(6506007)(76176011)(9686003)(102836004)(52536014)(76116006)(66556008)(8936002)(74316002)(64756008)(66476007)(66946007)(66446008)(81156014)(81166006)(186003)(26005)(99286004)(5660300002)(305945005)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3129;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2zJGdWWCeOKfKWZW/DOZlAV/0m6swR/9B4vAAG2LurUSHSBGgBNlQItiFpSK9bvFSk+MSpajgAOOEJmPxoYvlWnAr/VvgWfBtzb+frIYufoH//9jBFx23KkU39jtxaW+NB2SPnMoh0+8pMB43I+Zl+y/+H31j0UOElqTzTQTS1JhAfh9gwplE/uAsBeEydizbd9gkpZQ2VS3Ho5AjKvyP6lcni9G1yHksEpg6+hNUbt1Kx3drnq5mcH3JuCOnImwGarNkpjvPgScoGFyWRZNch1RsXQbbSpbzworZD5NbgRFMc6zKW36BOFaT/oOhWWE7waO3L6gyMBYe5Ugp5+Cmuxorwq6lLNtqj3Cb5M+ZUse4O4gerXsh5QVnXe3NC8kz4J3vRDsnzImOdqZqhVRK8J26Kf0+wuGsF+nWEhFcri++PVKG4TKNahIlsMtDQ94qk+qYB3FlDjdvbmLZ/IIS2unJjo2b92ZpBi0JfiWwqT2cvn9kvGFdEhYqLXKOZIvekimIoOGRpkevYr1WtegvVhZGz6lyK/m8+B4waPukk=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207e8d3-b91c-4193-170e-08d779eda6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 01:43:10.6364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4V1oQiVErGwYvD3xQVY47tpYTHJBUK/w66Me72+MLyMJPpXzQ1/spg/tY+k8sXKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4Hzx6XeIw8b+OncYChknwYLqkT2ncwJv7TxFMx5CGw=;
 b=ZVwVr1tYTNNltzfUqLd5E0RQISYH92CXQuHKHUZDx683vPzgcXO6fRvVmj16A7kBJYYkxvOu4jczWvpx6rMYD3z8OnbjEyVJ4DRw45kpe6d7KHLqj7EZuTe/aAxtc2vupGksKkq8gyl/atkmbbmEGJ124mOMQJVgoGgcB3cEnho=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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

SSd2ZSBzZWVuIGEgZmV3IHBlb3BsZSByZXBvcnRlZCB0aGlzIGlzc3VlIG9uIEZyZWVkZXNrdG9w
L0J1Z3ppbGxhLiBGb3IgZXhhbXBsZToNCmh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hv
d19idWcuY2dpP2lkPTExMTEyNC4NCg0KVGhleSBhbGwgZXhwZXJpZW5jZWQgdGhpcyBpc3N1ZSB3
aGlsZSBwbGF5aW5nIGdhbWVzLiBUaGUgaGlnaGVyIEdQVSBjbG9jayBpcywgdGhlIG1vcmUgZnJl
cXVlbnQgaXNzdWUgY2FuIGJlIHJlcHJvZHVjZWQuDQoNCkFsc28sIHNvbWUgUmVkZGl0IHVzZXJz
IHBvaW50ZWQgb3V0IGFsbCB0aGVzZSBnYW1lcyBhcmUgVnVsa2FuIGJhc2VkLiBJdCBjb3VsZCBi
ZSBhIFZ1bGthbiBzcGVjaWZpYyBpc3N1ZS4NCg0KVGhhbmtzLA0KWmhhbg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBDaHJpc3RpYW4gUGVybmVnZ2VyDQo+
IFNlbnQ6IDIwMTkvRGVjZW1iZXIvMDUsIFRodXJzZGF5IDY6MTUgUE0NCj4gVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFtkcm06YW1kZ3B1X2RtX2F0b21pY19j
b21taXRfdGFpbCBbYW1kZ3B1XV0gKkVSUk9SKg0KPiBXYWl0aW5nIGZvciBmZW5jZXMgdGltZWQg
b3V0IG9yIGludGVycnVwdGVkIQ0KPiANCj4gSGVsbG8sDQo+IA0KPiBvbmUgb2YgbXkgY29tcHV0
ZXJzIGhhcyBiZWVuIGNyYXNoaW5nIHdoaWxlIGdhbWluZyByYXRoZXIgYSBsb3QgbGF0ZWx5LCB3
aXRoDQo+IGtlcm5lbCBtZXNzYWdlcyBwb2ludGluZyB0byBhbWRncHUuIEZpcnN0IGxpbmUgc2Vl
IHN1YmplY3QsIHJlc3QgaW4gdGhlDQo+IGF0dGFjaGVkIGxvZy4NCj4gU1NIIHN0aWxsIHdvcmtz
LCBhdHRlbXB0cyB0byBzaHV0ZG93bi9yZWJvb3QgZG9uJ3QgcXVpdGUgZmluaXNoLg0KPiANCj4g
UmFkZW9uIFZJSSBpbiBhbiBBc3VzIFBybyBXUyBYNTcwLUFjZS4gVWJ1bnR1IDE4LjA0LjMgSFdF
LCBtZXNhLWFjby4NCj4gVGhpcyBvbmUgd2FzIHdpdGgga2VybmVsIDUuMy4wLTI0LWdlbmVyaWMg
W2h3ZS1lZGdlXSwgbWVzYQ0KPiAxOS4zLjArYWNvK2dpdDE1NzU0NTI4MzMtMzQwOWMwNmUyNmQt
MWJpb25pYzEsIHZlc2EyMF8qIGZyb20gbGludXgtDQo+IGZpcm13YXJlLTIwMTkxMDIyLCBydW5u
aW5nIE9yaSBhbmQgdGhlIEJsaW5kIEZvcmVzdDogRGVmaW5pdGl2ZSBFZGl0aW9uIHZpYQ0KPiBQ
cm90b24vV0lORUQzRDExIHVuZGVyIFN0ZWFtIFJlbW90ZSBQbGF5LiBJJ3ZlIGhhZCBzaW1pbGFy
IGNyYXNoZXMNCj4gc3BvcmFkaWNhbGx5IGV2ZW4gd2l0aCA1LjAgW3BsYWluIGh3ZV0gYW5kIGxp
bnV4LWZpcm13YXJlIGNvbXBsZXRlbHkgc3RvY2ssDQo+IGFuZCB3aXRoIG5hdGl2ZSBnYW1lcyAo
ZS5nLiBDcnVzYWRlciBLaW5ncyBJSSkgcnVubmluZyBsb2NhbGx5Lg0KPiBJdCB1c2VkIHRvIGJl
IG1heWJlIG9uY2UgZXZlcnkgb3RoZXIgd2VlaywgdGhvdWdoLCB0aGF0IHdhcyB0b2xlcmFibGUs
IG5vdw0KPiBPcmkgdXN1YWxseSB0cmlnZ2VycyBpdCBpbiB1bmRlciBhbiBob3VyLiBUdXJuaW5n
IG9mZiBBQ08gdmlhDQo+IFJBRFZfUEVSRlRFU1Q9bGx2bSBtYWtlcyBpdCB3b3JzZSAobm90IGJh
ZCBlbm91Z2ggdG8gbWFrZSBpdCB0cmlnZ2VyDQo+IHF1aWNrbHkgYW5kIHJlbGlhYmx5LiB0aG91
Z2gpLCBnb2luZyBiYWNrIHRvIGtlcm5lbCA1LjAgaGVscHMgKGFzIGluIGFuIGhvdXIgb3INCj4g
dHdvIG1pZ2h0IGdvIGJ5IHdpdGhvdXQgYSBjcmFzaCwgYnV0IHRoZSBwZXJmb3JtYW5jZSBpbXBh
Y3QgaXMgc2V2ZXJlKS4NCj4gDQo+IEFsbCB2ZXJ5IHZhZ3VlLiBXaGljaCBpcyB3aHkgdGhpcyBp
c24ndCBwcmV0ZW5kaW5nIHRvIGJlIGEgYnVnIHJlcG9ydCwganVzdCBhDQo+ICJoYXMgYW55b25l
IHNlZW4gdGhpcz8iIGtpbmQgb2Ygc2hvdXQtb3V0LiBJZiBpdCdzIHdvcnRoeSBvZiBmb2xsb3dp
bmcgdXAsIEknZA0KPiBiZSBoYXBweSB0byBwcm92aWRlIGZ1cnRoZXIgaW5mbywganVzdCB0ZWxs
IG1lIHdoYXQuDQo+IA0KPiBDaGVlcnMsDQo+IEMuDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
