Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D873C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 15:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C5B2151B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 15:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ckeLalcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C5B2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19756E869;
	Tue,  1 Sep 2020 15:21:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6186E869
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 15:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKa47idtxGqLR+OLk2GV/eb/bhvoekB9LZ7lyZljGBQrIC+Z4iDbXusR5GTKigakWuBIFPG370wDkE7yp/0WT3/L43vbdZCwWRWnZwDZCmWL76mDVP0jV8SK6WFCc7yghRF3/Y9lQY6xohvFqAfxfF9bt8Bzed/Wlwg/JbNqMuesdxD2GEjK9jzFW4M70E4GtDw7Tmqxmp4BUylTGAk7bzhPwc2XILb3pwmKmEpxg2Goyo4d8Ql3Nsf7jVTHFAN9holdoIV+a5Powk0FVTHCW10CKmdyt4QcQu7mCuOP0HTksAInNn6OmLgsQKp3068pAYnvTqDUbhLB2qxfiJVSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t/bJWUTzvZiBW3uc8tV2q7EnB1ZJ7ZCi8fkLATyWGg=;
 b=ZBXSbF3LRNa5ptbB88g8Zk1cnxBUh3sxBvwQJ83ivuZwZRfeL0l/jGon3idSvuVF57eMna22fxcqbbxY4H9A5aLrIW76TTM/lUHe/nHHSReThlOKhRb3GHvBcQp13EMB5s5KC5gqY5CBiMndOEBXOeiW0Rq+SZbwX+Ot3SJeVp64SLteVqXhmiwpvh889vHwSA30qdJJkK8RrnqROmSFx+PgpZxUPb7rAGzcnNnVQvq3jg62XJmuagBQ4uLHDptZ8KlJ8fNjX22PWvfhwTuXvm4SlI/HYvRJpwyjh/6DkjlCrlKOqvS1uG7cpAH1mliLScV3SHsG0QF4aFhaveFI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t/bJWUTzvZiBW3uc8tV2q7EnB1ZJ7ZCi8fkLATyWGg=;
 b=ckeLalcF5uK1AD6ssPtwB5tMvpksKdIYyRPimaYOzm4g1NqSGrH+xH0/EhviqEm56DtrLQlLusxOIoO8o8ml8HZkZqkKAfdKkyTrx67vux8L8yS2bMsQvc6oEiveyXYR26aWRGOnluev0KOtbjnSaY1zCFhqrNrNu4eBc9J9fdE=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3387.namprd12.prod.outlook.com (2603:10b6:5:3a::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 1 Sep 2020 15:21:20 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3348.015; Tue, 1 Sep 2020
 15:21:19 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/kfd: fix a system crash issue during GPU recovery
Thread-Topic: [PATCH] drm/kfd: fix a system crash issue during GPU recovery
Thread-Index: AQHWgABVG7oHycuRYEW6iaAbRdpqA6lTxuEAgAAeCvA=
Date: Tue, 1 Sep 2020 15:21:19 +0000
Message-ID: <DM5PR12MB2533DD201C0444D4EC55C48FED2E0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200901013619.14836-1-Dennis.Li@amd.com>
 <44930860-7c61-c984-9c32-90a2cc0a3732@amd.com>
In-Reply-To: <44930860-7c61-c984-9c32-90a2cc0a3732@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-01T15:20:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9748745e-acee-4262-ab74-817da13648b7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.86.2.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a32f91b-1d80-48e8-f6f2-08d84e8aada6
x-ms-traffictypediagnostic: DM6PR12MB3387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33877E293D890B83A3E36BAFED2E0@DM6PR12MB3387.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G97gJBu8XgUpdfH9o8f1AztHzRUnO6nPN0zcGOOE3fmvNKg32ybVm9SNaOnJBfPuSVtjosqXaKLfg/5oU2wXso8baw6JZhwJu60N7zXBllP/hZ+4Sa2Gr1vXGz3ToZk9oCxIgNtrF/Tmo+YRv5zlLP0tX1AZNb6QqO3OpmMw9B+V5mpht+pig27MChrN5lM62rHCnB+Zpqg8jS+FQpPv/dFyHsWO7cljoraYoi63UXaTe4qT8U3ytA09WDoYZJss8GKEjEM9qXbKYoHxMkukGsd51T24xcXfAKTifmzwU/04ea/vmtB13Bt6oU5pGXVE3QUKbZEky/EcEN0AI0WnBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(33656002)(71200400001)(86362001)(52536014)(478600001)(55016002)(8676002)(110136005)(6506007)(8936002)(316002)(7696005)(9686003)(66476007)(53546011)(26005)(66446008)(64756008)(6636002)(66946007)(66556008)(76116006)(83380400001)(5660300002)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dQ24VSS5x8jeQ57/SBmP/8TUNtLF6aLlHylZAxB1W1LFnBREtVAvmTMyMfCqjNzAhkYVLzcHOSMkqq8cG9rTYVpfkQJDHVnWI9ge/u0SjfeZXJE9d4r/8ATQ/8DJ2hlgGQfwXrjf2lFBitjOTEeICB9jlJGl87G0YX+78YJVEk2NWLp5INnku3HQ9ySSl2tRHphlMzAk93FzWU+IYR6NzeR20jA54we5idLQtyVVQMuCHnIsNMJPn3rRECqQOP7ibqqj8zY0MNojXZ4AT2Wg+cVcEPUpxILgQbjkNpqWHeevbSxsep3bn6oPcZ+LvgE6PX8k6BrkFWp5IF7nap2MdtHZ3bj8Cwzci3JcmoS+EZiL/qoWLHekr3Phb+JStgZxDyfA86qBqX8ujsUjuzjABwArHju0oM+ByarSNj8X2u16ic+vX9y55t40J4smyD0k9W3srBvFiX98fIQJI8r5vhY/WyLtQQJqi6jmDk/vqSFafeNf8zJl7GQHvWSKXXNXZNRVWMB40x/w0G5lJyc1e3oaBz98Seyzm1HF2j4NRw2C0Yx5k8AA+Gd46AojNNc9nN0evAWD1MRfq3SGh94fFTQ2HWgMTree7yxpha8jax3oRc+Nr36D6droeBc4ytrXbcwCgkVegHqwb4Ert/cKag==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a32f91b-1d80-48e8-f6f2-08d84e8aada6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 15:21:19.6700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2Nk5T8geR4UqeTekyTkizKUpPhrbssSNqJ06lRgOoq5xPVW8kOmM5PBhpJfSvG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3387
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgRmVsaXgsDQogICAgIElmIEdQVSBoYW5nLCBleGVjdXRlX3F1ZXVlc19jcHNjaCB3aWxsIGZh
aWwgdG8gdW5tYXAgb3IgbWFwIHF1ZXVlcyBhbmQgdGhlbiBjcmVhdGVfcXVldWVfY3BzY2ggd2ls
bCByZXR1cm4gZXJyb3IuIElmIHBxbV9jcmVhdGVfcXVldWUgZmluZCBjcmVhdGVfcXVldWVfY3Bz
Y2ggZmFpbGVkLCBpdCB3aWxsIGNhbGwgdW5pbml0X3F1ZXVlIHRvIGZyZWUgcXVldWUgb2JqZWN0
LiBIb3dldmVyIHRoaXMgcXVldWUgb2JqZWN0IGhhcyBiZWVuIGFkZGVkIGluIHRvIHFwZC0+cXVl
dWVzX2xpc3QgaW4gdGhlIG9sZCBjb2RlLiANCg0KQmVzdCBSZWdhcmRzDQpEZW5uaXMgTGkNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMSwgMjAyMCA5OjI2
IFBNDQpUbzogTGksIERlbm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0va2ZkOiBmaXggYSBzeXN0ZW0gY3Jhc2ggaXNzdWUgZHVyaW5nIEdQVSByZWNvdmVyeQ0KDQpJ
J20gbm90IHN1cmUgaG93IHRoZSBidWcgeW91J3JlIGZpeGluZyBpcyBjYXVzZWQsIGJ1dCB5b3Vy
IGZpeCBpcyBjbGVhcmx5IGluIHRoZSB3cm9uZyBwbGFjZS4NCg0KQSBxdWV1ZSBiZWluZyBkaXNh
YmxlZCBpcyBub3QgdGhlIHNhbWUgdGhpbmcgYXMgYSBxdWV1ZSBiZWluZyBkZXN0cm95ZWQuDQpR
dWV1ZXMgY2FuIGJlIGRpc2FibGVkIGZvciBsZWdpdGltYXRlIHJlYXNvbnMsIGJ1dCB0aGV5IHN0
aWxsIHNob3VsZCBleGlzdCBhbmQgYmUgaW4gdGhlIHFwZC0+cXVldWVzX2xpc3QuDQoNCklmIGEg
ZGVzdHJveWVkIHF1ZXVlIGlzIGxlZnQgb24gdGhlIHFwZC0+cXVldWVzX2xpc3QsIHRoYXQgd291
bGQgYmUgYSBwcm9ibGVtLiBDYW4geW91IHBvaW50IG91dCB3aGVyZSBzdWNoIGEgdGhpbmcgaXMg
aGFwcGVuaW5nPw0KDQpUaGFua3MsDQrCoCBGZWxpeA0KDQoNCkFtIDIwMjAtMDgtMzEgdW0gOToz
NiBwLm0uIHNjaHJpZWIgRGVubmlzIExpOg0KPiBUaGUgY3Jhc2ggbG9nIGFzIHRoZSBiZWxvdzoN
Cj4NCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0
OiAwMDAwIFsjMV0gU01QIE5PUFRJDQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIENQVTog
MTUyIFBJRDogMTgzNyBDb21tOiBrd29ya2VyLzE1MjoxIFRhaW50ZWQ6IEcgICAgICAgICAgIE9F
ICAgICA1LjQuMC00Mi1nZW5lcmljICM0Nn4xOC4wNC4xLVVidW50dQ0KPiBbVGh1IEF1ZyAyMCAy
MzoxODoxNCAyMDIwXSBIYXJkd2FyZSBuYW1lOiBHSUdBQllURSANCj4gRzQ4Mi1aNTMtWUYvTVo1
Mi1HNDAtMDAsIEJJT1MgUjEyIDA1LzEzLzIwMjAgW1RodSBBdWcgMjAgMjM6MTg6MTQgDQo+IDIw
MjBdIFdvcmtxdWV1ZTogZXZlbnRzIGFtZGdwdV9yYXNfZG9fcmVjb3ZlcnkgW2FtZGdwdV0gW1Ro
dSBBdWcgMjAgDQo+IDIzOjE4OjE0IDIwMjBdIFJJUDogMDAxMDpldmljdF9wcm9jZXNzX3F1ZXVl
c19jcHNjaCsweGM5LzB4MTMwIA0KPiBbYW1kZ3B1XSBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIw
XSBDb2RlOiA0OSA4ZCA0ZCAxMCA0OCAzOSBjOCA3NSAyMSANCj4gZWIgNDQgODMgZmEgMDMgNzQg
MzYgODAgNzggNzIgMDAgNzQgMGMgODMgYWIgNjggMDEgMDAgMDAgMDEgNDEgYzYgNDUgDQo+IDQx
IDAwIDQ4IDhiIDAwIDQ4IDM5IGM4IDc0IDI1IDw4MD4gNzggNzAgMDAgYzYgNDAgNmQgMDEgNzQg
ZWUgOGIgNTAgMjggDQo+IGM2IDQwIDcwIDAwIDgzIGFiIDYwIDAxIDAwIFtUaHUgQXVnIDIwIDIz
OjE4OjE0IDIwMjBdIFJTUDogDQo+IDAwMTg6ZmZmZmIyOWI1MmY2ZmM5MCBFRkxBR1M6IDAwMDEw
MjEzIFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIFJBWDogDQo+IDFjODg0ZWRiMGExMTg5MTQg
UkJYOiBmZmZmOGEwZDQ1ZmYzYzAwIFJDWDogZmZmZjhhMmQ4M2U0MTAzOCBbVGh1IEF1ZyANCj4g
MjAgMjM6MTg6MTQgMjAyMF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAw
MDA4MiBSREk6IA0KPiBmZmZmOGEwZTJlNDE3OGMwIFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBd
IFJCUDogZmZmZmIyOWI1MmY2ZmNiMCBSMDg6IA0KPiAwMDAwMDAwMDAwMDAxYjY0IFIwOTogMDAw
MDAwMDAwMDAwMDAwNCBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBSMTA6IA0KPiBmZmZmYjI5
YjUyZjZmYjc4IFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IGZmZmY4YTBkNDVmZjNkMjggW1Ro
dSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gUjEzOiBmZmZmOGEyZDgzZTQxMDI4IFIxNDogMDAwMDAw
MDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDAgW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAy
MF0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4YTBlMmU0MDAwMDAoMDAwMCkg
a25sR1M6MDAwMDAwMDAwMDAwMDAwMCBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzIFtUaHUgQXVnIDIwIDIz
OjE4OjE0IDIwMjBdIENSMjogMDAwMDU1Yzc4M2MwZTZhOCBDUjM6IDAwMDAwMDM0YTEyODQwMDAg
Q1I0OiAwMDAwMDAwMDAwMzQwZWUwIFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIENhbGwgVHJh
Y2U6DQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdICBrZmRfcHJvY2Vzc19ldmljdF9xdWV1
ZXMrMHg0My8weGQwIA0KPiBbYW1kZ3B1XSBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSAgDQo+
IGtmZF9zdXNwZW5kX2FsbF9wcm9jZXNzZXMrMHg2MC8weGYwIFthbWRncHVdIFtUaHUgQXVnIDIw
IDIzOjE4OjE0IA0KPiAyMDIwXSAga2dkMmtmZF9zdXNwZW5kLnBhcnQuNysweDQzLzB4NTAgW2Ft
ZGdwdV0gW1RodSBBdWcgMjAgMjM6MTg6MTQgDQo+IDIwMjBdICBrZ2Qya2ZkX3ByZV9yZXNldCsw
eDQ2LzB4NjAgW2FtZGdwdV0gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gIA0KPiBhbWRncHVf
YW1ka2ZkX3ByZV9yZXNldCsweDFhLzB4MjAgW2FtZGdwdV0gW1RodSBBdWcgMjAgMjM6MTg6MTQg
MjAyMF0gIA0KPiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKzB4Mzc3LzB4ZjkwIFthbWRncHVd
IFtUaHUgQXVnIDIwIDIzOjE4OjE0IA0KPiAyMDIwXSAgPyBhbWRncHVfcmFzX2Vycm9yX3F1ZXJ5
KzB4MWI4LzB4MmEwIFthbWRncHVdIFtUaHUgQXVnIDIwIA0KPiAyMzoxODoxNCAyMDIwXSAgYW1k
Z3B1X3Jhc19kb19yZWNvdmVyeSsweDE1OS8weDE5MCBbYW1kZ3B1XSBbVGh1IEF1ZyANCj4gMjAg
MjM6MTg6MTQgMjAyMF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgyMGYvMHg0MDAgW1RodSBBdWcgMjAg
MjM6MTg6MTQgDQo+IDIwMjBdICB3b3JrZXJfdGhyZWFkKzB4MzQvMHg0MTANCj4NCj4gV2hlbiBH
UFUgaGFuZywgdXNlciBwcm9jZXNzIHdpbGwgZmFpbCB0byBjcmVhdGUgYSBjb21wdXRlIHF1ZXVl
IHdob3NlIA0KPiBzdHJ1Y3Qgb2JqZWN0IHdpbGwgYmUgZnJlZWQgbGF0ZXIsIGJ1dCBkcml2ZXIg
d3JvbmdseSBhZGQgdGhpcyBxdWV1ZSANCj4gdG8gcXVldWUgbGlzdCBvZiB0aGUgcHJvY2Nlc3Mu
IEFuZCB0aGVuIGtmZF9wcm9jZXNzX2V2aWN0X3F1ZXVlcyB3aWxsIA0KPiBhY2Nlc3MgYSBmcmVl
ZCBtZW1vcnksIHdoaWNoIGNhdXNlIGEgc3lzdGVtIGNyYXNoLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBEZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPg0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gaW5k
ZXggNTYwYWRjNTdhMDUwLi5kNWU2YjA3ZmZiMjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+IEBAIC0x
Mjk2LDE2ICsxMjk2LDE4IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3F1ZXVlX2Nwc2NoKHN0cnVjdCBk
ZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLCBzdHJ1Y3QgcXVldWUgKnEsDQo+ICAJbXFkX21nci0+
aW5pdF9tcWQobXFkX21nciwgJnEtPm1xZCwgcS0+bXFkX21lbV9vYmosDQo+ICAJCQkJJnEtPmdh
cnRfbXFkX2FkZHIsICZxLT5wcm9wZXJ0aWVzKTsNCj4gIA0KPiAtCWxpc3RfYWRkKCZxLT5saXN0
LCAmcXBkLT5xdWV1ZXNfbGlzdCk7DQo+IC0JcXBkLT5xdWV1ZV9jb3VudCsrOw0KPiAtDQo+ICAJ
aWYgKHEtPnByb3BlcnRpZXMuaXNfYWN0aXZlKSB7DQo+ICAJCWluY3JlbWVudF9xdWV1ZV9jb3Vu
dChkcW0sIHEtPnByb3BlcnRpZXMudHlwZSk7DQo+ICANCj4gIAkJcmV0dmFsID0gZXhlY3V0ZV9x
dWV1ZXNfY3BzY2goZHFtLA0KPiAgCQkJCUtGRF9VTk1BUF9RVUVVRVNfRklMVEVSX0RZTkFNSUNf
UVVFVUVTLCAwKTsNCj4gKwkJaWYgKHJldHZhbCkNCj4gKwkJCWdvdG8gb3V0X2V4ZWN1dGVfY3Bz
Y2g7DQo+ICAJfQ0KPiAgDQo+ICsJbGlzdF9hZGQoJnEtPmxpc3QsICZxcGQtPnF1ZXVlc19saXN0
KTsNCj4gKwlxcGQtPnF1ZXVlX2NvdW50Kys7DQo+ICsNCj4gIAkvKg0KPiAgCSAqIFVuY29uZGl0
aW9uYWxseSBpbmNyZW1lbnQgdGhpcyBjb3VudGVyLCByZWdhcmRsZXNzIG9mIHRoZSBxdWV1ZSdz
DQo+ICAJICogdHlwZSBvciB3aGV0aGVyIHRoZSBxdWV1ZSBpcyBhY3RpdmUuDQo+IEBAIC0xMzE4
LDYgKzEzMjAsOSBAQCBzdGF0aWMgaW50IGNyZWF0ZV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNl
X3F1ZXVlX21hbmFnZXIgKmRxbSwgc3RydWN0IHF1ZXVlICpxLA0KPiAgCWRxbV91bmxvY2soZHFt
KTsNCj4gIAlyZXR1cm4gcmV0dmFsOw0KPiAgDQo+ICtvdXRfZXhlY3V0ZV9jcHNjaDoNCj4gKwlk
ZWNyZW1lbnRfcXVldWVfY291bnQoZHFtLCBxLT5wcm9wZXJ0aWVzLnR5cGUpOw0KPiArCWRxbV91
bmxvY2soZHFtKTsNCj4gIG91dF9kZWFsbG9jYXRlX2Rvb3JiZWxsOg0KPiAgCWRlYWxsb2NhdGVf
ZG9vcmJlbGwocXBkLCBxKTsNCj4gIG91dF9kZWFsbG9jYXRlX3NkbWFfcXVldWU6DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
