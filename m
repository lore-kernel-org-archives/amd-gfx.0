Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B990DC18E5B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 09:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F70920722
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 09:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="saqh3xph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F70920722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD606E7D7;
	Wed, 25 Mar 2020 09:23:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7687D6E7D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 09:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxdusyj6XVvyZfRtpY98OM60FDp1G7dmeHwrDjtnUSwUGUrBO5xcvwHJi0r6gQwpXprYVcFyjvrlgngSt8hU1GY5lE7/eAzWYY/x9/zCOMnuHL0Z6/Cyzy3vbThfjGq9Nzrsml9xrSGIWEP0gPI71Ifn4t+j05TEnjeXVSTp1MAdrDPkbv71Ek1gJ0aoAPTRMRCMJSkIpfE9VqEJs5GWXBYkRLUcUJtSAKiEChf3pw/rq6YLMxy7DmCIJdgLYYqdS+Nh0rOqe/CgMhweBinHotLyEFoqVQGjHreE/wdnQ7npBuYtfnSM4jytB1gwHHYWTqySjSYkeOCsIP36iq73sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdHw+f6/VXW1gJ2YVvWKUpR5FaI5s8IZ0WQnvmm5hog=;
 b=em1dO0AkAXsAyY7PeV6eSPgt5AtFybYksY7fwJu6p/IcQCGy/nvLm6acOV7lXskiyaY1uzF3EDWJwVF31Tayw1Mwk/KluWbMej8GXO4pYq6oElo2aCIlPrY77VlTZg4I5RBEKSD7/z0UnldS5BDeZPkF9a0tRHCxfvbxfoSr+9kZCme8mImHodGDO/XtPJUrdG5vTmRZUV9uYRVOEViVTxd5AHctRsTQw5mw13gvgn/8yCsPqrHcZoPWfXJz1sU4NF07O+SsyOSz5fqAaHk4t2a+u5vxsl5BGFnrIbvzCYKASp14zqNeQOmFxNXS8rgju/Vq+wYswdGUeB/0Vq4QOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdHw+f6/VXW1gJ2YVvWKUpR5FaI5s8IZ0WQnvmm5hog=;
 b=saqh3xphI6AVbCSCwVo14UM3iv5QVJa4l9RaTUGXvzXPQPr+QSIeXK9Pwe3ce1PWOUhVx3U+ha8X1eswBhZb/U8K9DGU4L4UqM9xLRqffOSwd35HrXI0QJckSvN7roCnFerCANhL7Gl7LG2vY/JgKWDCuER+CeWusfCH3D9H+6s=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 09:23:52 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 09:23:52 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Check entity rq
Thread-Topic: [PATCH] drm/amdgpu: Check entity rq
Thread-Index: AQHWAmjqp4hkBZWRykOLL0pF4X2gK6hY7sIAgAAanYA=
Date: Wed, 25 Mar 2020 09:23:52 +0000
Message-ID: <E108D9FC-CE64-4F4F-B5C9-08780CFF1356@amd.com>
References: <20200325054723.4560-1-xinhui.pan@amd.com>
 <15d695c5-539b-2461-c265-d3590f1540e5@amd.com>
In-Reply-To: <15d695c5-539b-2461-c265-d3590f1540e5@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0436248-3cf5-4205-6b2f-08d7d09e3c11
x-ms-traffictypediagnostic: SN6PR12MB2623:|SN6PR12MB2623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2623DA8F92A0F873D130302B87CE0@SN6PR12MB2623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(86362001)(6486002)(6506007)(71200400001)(6512007)(66574012)(26005)(316002)(37006003)(186003)(66446008)(64756008)(66946007)(66556008)(66476007)(478600001)(54906003)(5660300002)(36756003)(8936002)(8676002)(6862004)(6636002)(81166006)(81156014)(33656002)(4326008)(76116006)(2906002)(91956017)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2623;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ii0V+P72oEURGe0xPAEfzDl+JxgEZmfJCVOSY77SdcVOdEbRQ1yOJ9KIw4nrFTDXIGKruJdF5HBGI6sVi63S/wwyDV8s8FA70f/rHQRIwmvApw1rZiVd9UguNW1LG7AKyqjuMlnFyxs5ONvHH3cD3R1+GEniPF/CbXzrIB45wuql+4m+EqPqw1+e6eR6nXpyv8/SudJluWjaascxpdRuMYD0YI3f10cxIR+mL8L0ZIzJ2U41zeG48BgWyMjmPW0YX5d8lk8YYxBNQdUWoKZEsauInRJJ++b57EUKFCfK6fFr+KqaSyhLNuUSc/8fH4KKYBKVZeBQaOKnMDnL+mTfKhnBvMSWsQTJoHv3RJ017+pQXaxYkMJ9/3qioBZ06XrgUyUIEYKRgbhphhAn1tkvc0pBcozU29OZhEoOZfWXjB2u3EDiq/uNM98SaM58oa8u
x-ms-exchange-antispam-messagedata: Chb4da4W9BXo8v9HG0pCQaj5GCdLyznLOYII3GiUMUvTML23lpESG/RPkrQ1/MBcDg5JS7uUMC1y2JIg27IHLGQ19RngAPD25aiO80f4hgOKWKxN5XqyI97zVg6oHPAdYLqR9c5E/i3OuzKYM5vLuw==
Content-ID: <66933BCBCE499D44A3793A955719EFC3@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0436248-3cf5-4205-6b2f-08d7d09e3c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 09:23:52.6020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BMZBc1T5xfSSOwuUs/xyFC0g202qRPZ4+PKVS8rCzSecd6vk55G884onNa42DH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDPmnIgyNeaXpSAxNTo0OO+8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMjUuMDMuMjAgdW0gMDY6NDcg
c2NocmllYiB4aW5odWkgcGFuOg0KPj4gSGl0IHBhbmljIGR1cmluZyBHUFUgcmVjb3ZlcnkgdGVz
dC4gZHJtX3NjaGVkX2VudGl0eV9zZWxlY3RfcnEgbWlnaHQNCj4+IHNldCBOVUxMIHRvIHJxLiBT
byBhZGQgYSBjaGVjayBsaWtlIGRybV9zY2hlZF9qb2JfaW5pdCBkb2VzLg0KPiANCj4gTkFLLCB0
aGUgcnEgc2hvdWxkIG5ldmVyIGJlIHNldCB0byBOVUxMIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4g
DQo+IEhvdyBkaWQgdGhhdCBoYXBwZW5lZD8NCg0Kd2VsbCwgSSBoYXZlIG5vdCBjaGVjayB0aGUg
ZGV0YWlscy4NCmJ1dCBqdXN0IGdvdCB0aGUgY2FsbCB0cmFjZSBiZWxvdy4NCmxvb2tzIGxpa2Ug
c2NoZWQgaXMgbm90IHJlYWR5LCBhbmQgZHJtX3NjaGVkX2VudGl0eV9zZWxlY3RfcnEgc2V0IGVu
dGl0eS0+cnEgdG8gTlVMTC4NCmluIHRoZSBuZXh0IGFtZGdwdV92bV9zZG1hX2NvbW1pdCwgaGl0
IHBhbmljIHdoZW4gd2UgZGVmZXJlbmNlIGVudGl0eS0+cnEuDQoNCjI5NzU2NyBbICAgNDQuNjY3
Njc3XSBhbWRncHUgMDAwMDowMzowMC4wOiBHUFUgcmVzZXQgYmVnaW4hDQoyOTc1NjggWyAgIDQ0
LjkyOTA0N10gW2RybV0gc2NoZWR1bGVyIHNkbWEwIGlzIG5vdCByZWFkeSwgc2tpcHBpbmcNCjI5
NzU2OSBbICAgNDQuOTI5MDQ4XSBbZHJtXSBzY2hlZHVsZXIgc2RtYTEgaXMgbm90IHJlYWR5LCBz
a2lwcGluZw0KMjk3NTcwIFsgICA0NC45MzQ2MDhdIFtkcm06YW1kZ3B1X2dlbV92YV9pb2N0bCBb
YW1kZ3B1XV0gKkVSUk9SKiBDb3VsZG4ndCB1cGRhdGUgQk9fVkEgKC0yKQ0KMjk3NTcxIFsgICA0
NC45NDc5NDFdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczog
MDAwMDAwMDAwMDAwMDAzOA0KMjk3NTcyIFsgICA0NC45NTUxMzJdICNQRjogc3VwZXJ2aXNvciBy
ZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KMjk3NTczIFsgICA0NC45NjA0NTFdICNQRjogZXJy
b3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KMjk3NTc0IFsgICA0NC45NjU3MTRd
IFBHRCAwIFA0RCAwDQoyOTc1NzUgWyAgIDQ0Ljk2ODMzMV0gT29wczogMDAwMCBbIzFdIFNNUCBQ
VEkNCjI5NzU3NiBbICAgNDQuOTcxOTExXSBDUFU6IDcgUElEOiAyNDk2IENvbW06IGdub21lLXNo
ZWxsIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA1LjQuMC1yYzcrICMxDQoyOTc1NzcgWyAg
IDQ0Ljk4MDIyMV0gSGFyZHdhcmUgbmFtZTogU3lzdGVtIG1hbnVmYWN0dXJlciBTeXN0ZW0gUHJv
ZHVjdCBOYW1lL1oxNzAtQSwgQklPUyAxNzAyIDAxLzI4LzIwMTYNCjI5NzU3OCBbICAgNDQuOTg5
MTc3XSBSSVA6IDAwMTA6YW1kZ3B1X3ZtX3NkbWFfY29tbWl0KzB4NTUvMHgxOTAgW2FtZGdwdV0N
CjI5NzU3OSBbICAgNDQuOTk1MjQyXSBDb2RlOiA0NyAyMCA4MCA3ZiAxMCAwMCA0YyA4YiBhMCA4
OCAwMSAwMCAwMCA0OCA4YiA0NyAwOCA0YyA4ZCBhOCA3MCAwMSAwMCAwMCA3NSAwNyA0YyA4ZCBh
OCA4OCAwMiAwMCAwMCA0OSA4YiA0NSAxMCA0MSA4YiA1NCAyNCAwOCA8NDg+IDhiIDQwIDM4IDg1
IGQyIDQ4IDhkIGI4IDMwIGZmIGZmIGYgICAgICAgZiAwZiA4NCAwNiAwMSAwMCAwMCA0OCA4YiA4
MA0KMjk3NTgwIFsgICA0NS4wMTQ5MzFdIFJTUDogMDAxODpmZmZmYjY2ZTAwODgzOWQwIEVGTEFH
UzogMDAwMTAyNDYNCjI5NzU4MSBbICAgNDUuMDIwNTA0XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAg
UkJYOiBmZmZmYjY2ZTAwODgzYTMwIFJDWDogMDAwMDAwMDAwMDEwMDQwMA0KMjk3NTgyIFsgICA0
NS4wMjgwNjJdIFJEWDogMDAwMDAwMDAwMDAwMDAzYyBSU0k6IGZmZmY4ZGYxMjM2NjIxMzggUkRJ
OiBmZmZmYjY2ZTAwODgzYTMwDQoyOTc1ODMgWyAgIDQ1LjAzNTY2Ml0gUkJQOiBmZmZmYjY2ZTAw
ODgzYTAwIFIwODogZmZmZmI2NmUwMDg4Mzk1YyBSMDk6IGZmZmZiNjZlMDA4ODM5NjANCjI5NzU4
NCBbICAgNDUuMDQzMjk4XSBSMTA6IDAwMDAwMDAwMDAxMDAyNDAgUjExOiAwMDAwMDAwMDAwMDAw
MDM1IFIxMjogZmZmZjhkZjE0MjUzODVlOA0KMjk3NTg1IFsgICA0NS4wNTA5MTZdIFIxMzogZmZm
ZjhkZjEzY2ZkMTI4OCBSMTQ6IGZmZmY4ZGYxMjM2NjIxMzggUjE1OiBmZmZmOGRmMTNjZmQxMDAw
DQoyOTc1ODYgWyAgIDQ1LjA1ODUyNF0gRlM6ICAwMDAwN2ZjYzhmNmIyMTAwKDAwMDApIEdTOmZm
ZmY4ZGYxNWUzODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KMjk3NTg3IFsgICA0
NS4wNjcxMTRdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMNCjI5NzU4OCBbICAgNDUuMDczMjA2XSBDUjI6IDAwMDAwMDAwMDAwMDAwMzggQ1IzOiAwMDAw
MDAwNjQxZmI2MDA2IENSNDogMDAwMDAwMDAwMDM2MDZlMA0KMjk3NTg5IFsgICA0NS4wODA3OTFd
IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAw
MDAwMDAwMDAwDQoyOTc1OTAgWyAgIDQ1LjA4ODI3N10gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERS
NjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCjI5NzU5MSBbICAgNDUu
MDk1NzczXSBDYWxsIFRyYWNlOg0KMjk3NTkyIFsgICA0NS4wOTgzNTRdICBhbWRncHVfdm1fYm9f
dXBkYXRlX21hcHBpbmcrMHgxYzEvMHgxZjAgW2FtZGdwdV0NCjI5NzU5MyBbICAgNDUuMTA0NDI3
XSAgPyBtYXJrX2hlbGRfbG9ja3MrMHg0ZC8weDgwDQoyOTc1OTQgWyAgIDQ1LjEwODY4Ml0gIGFt
ZGdwdV92bV9ib191cGRhdGUrMHgzYjcvMHg5NjAgW2FtZGdwdV0NCjI5NzU5NSBbICAgNDUuMTE0
MDQ5XSAgPyByY3VfcmVhZF9sb2NrX3NjaGVkX2hlbGQrMHg0Zi8weDgwDQoyOTc1OTYgWyAgIDQ1
LjExOTExMV0gIGFtZGdwdV9nZW1fdmFfaW9jdGwrMHg0ZjMvMHg1MTAgW2FtZGdwdV0NCjI5NzU5
NyBbICAgNDUuMTI0NDk1XSAgPyBhbWRncHVfZ2VtX3ZhX21hcF9mbGFncysweDcwLzB4NzAgW2Ft
ZGdwdV0NCjI5NzU5OCBbICAgNDUuMTMwMjUwXSAgZHJtX2lvY3RsX2tlcm5lbCsweGIwLzB4MTAw
IFtkcm1dDQoyOTc1OTkgWyAgIDQ1LjEzNDk4OF0gID8gYW1kZ3B1X2dlbV92YV9tYXBfZmxhZ3Mr
MHg3MC8weDcwIFthbWRncHVdDQoyOTc2MDAgWyAgIDQ1LjE0MDc0Ml0gID8gZHJtX2lvY3RsX2tl
cm5lbCsweGIwLzB4MTAwIFtkcm1dDQoyOTc2MDEgWyAgIDQ1LjE0NTYyMl0gIGRybV9pb2N0bCsw
eDM4OS8weDQ1MCBbZHJtXQ0KMjk3NjAyIFsgICA0NS4xNDk4MDRdICA/IGFtZGdwdV9nZW1fdmFf
bWFwX2ZsYWdzKzB4NzAvMHg3MCBbYW1kZ3B1XQ0KMjk3NjAzIFsgICA0NS4xNTU1NTFdICA/IHRy
YWNlX2hhcmRpcnFzX29uKzB4M2IvMHhmMA0KMjk3NjA0IFsgICA0NS4xNTk4OTJdICBhbWRncHVf
ZHJtX2lvY3RsKzB4NGYvMHg4MCBbYW1kZ3B1XQ0KMjk3NjA1IFsgICA0NS4xNzIxMDRdICBkb192
ZnNfaW9jdGwrMHhhOS8weDZmMA0KMjk3NjA2IFsgICA0NS4xNzU5MDldICA/IHRvbW95b19maWxl
X2lvY3RsKzB4MTkvMHgyMA0KMjk3NjA3IFsgICA0NS4xODAyNDFdICBrc3lzX2lvY3RsKzB4NzUv
MHg4MA0KMjk3NjA4IFsgICA0NS4xODM3NjBdICA/IGRvX3N5c2NhbGxfNjQrMHgxNy8weDIzMA0K
Mjk3NjA5IFsgICA0NS4xODc4MzNdICBfX3g2NF9zeXNfaW9jdGwrMHgxYS8weDIwDQoyOTc2MTAg
WyAgIDQ1LjE5MTg0Nl0gIGRvX3N5c2NhbGxfNjQrMHg1Zi8weDIzMA0KMjk3NjExIFsgICA0NS4x
OTU3NjRdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJlDQoyOTc2MTIg
WyAgIDQ1LjIwMTEyNl0gUklQOiAwMDMzOjB4N2ZjYzhjNzcyNWQ3DQoNCj4gDQo+IFJlZ2FyZHMs
DQo+IENocmlzdGlhbi4NCj4gDQo+PiANCj4+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQo+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KPj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPg0KPj4g
LS0tDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyB8IDIg
KysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYw0KPj4gaW5kZXggY2Y5NmMzMzVi
MjU4Li5kMzBkMTAzZTQ4YTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm1fc2RtYS5jDQo+PiBAQCAtOTUsNiArOTUsOCBAQCBzdGF0aWMgaW50IGFtZGdw
dV92bV9zZG1hX2NvbW1pdChzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsDQo+PiAg
CWludCByOw0KPj4gICAgCWVudGl0eSA9IHAtPmRpcmVjdCA/ICZwLT52bS0+ZGlyZWN0IDogJnAt
PnZtLT5kZWxheWVkOw0KPj4gKwlpZiAoIWVudGl0eS0+cnEpDQo+PiArCQlyZXR1cm4gLUVOT0VO
VDsNCj4+ICAJcmluZyA9IGNvbnRhaW5lcl9vZihlbnRpdHktPnJxLT5zY2hlZCwgc3RydWN0IGFt
ZGdwdV9yaW5nLCBzY2hlZCk7DQo+PiAgICAJV0FSTl9PTihpYi0+bGVuZ3RoX2R3ID09IDApOw0K
PiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
