Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66573C4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 12:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3446324692
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 12:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UHq8mVtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3446324692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200086E85D;
	Thu, 27 Feb 2020 12:01:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233466E85D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 12:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPeK2umCwGqvHaG6cfeAXQkWHwIc5UETzEv8VvnWKi0tz/5Y9PQIcHvJk4ZyokIc1RXsDQ3Oy1734Xf1Wb07o3I9gTyiqOd0LU3pCoThjmpvjONHRt/fzywRjurO+Wrd1AKakwyODl50+KcCCubx758Us8S0BlTmK7r5G+5MKvoB3EdIqfZOXbK4920UAL3+lKmFv5+c48hEs7YQRimD4ijS/JTrB6dm11CONTeq82tf8t9J3J90BrDmcawuTC6vP+4GSBEUAnrDQuggESfonXJwLKx1dur8p7WYsOHwq/7kX2KyumCx81DGL2jEFbgPkb3imrYe39zYzD0DOQFn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe7eqtjZxzxd+HModmoj4iqMr2j3jDJRODplM1xZwgg=;
 b=KAY1f/Bj//WlJptVHa1njU+Pnxj0XnTOJK0eArAb0xyW8Jv2IJ2sjRCOotOXNMvd6spBqiC6OEK9lI+2WKdzxx/I2/ao4ZnUWjm5DErp19ZI6JzS6OSuhuRDGk9cLgSoaiRpDX30VQRBZicCWwHFRmRjP9hGHfVGR7fKjDPKCKm/ySYNJk7HpJyOvhHrcGgrTJt60Ezd0tAAvcsqCT7dpNq5mT4szrCTOvRnlh/vQBc/zsYNX9RKRplHTViW6D5qdvmTbkzMgbdHg8xzMBpaVzXTZeqcN2WFOPGZvHvGCDTCBmfncEJzTJ7yeBnTnWkXqmYn64tQRvQxjUHiEtXNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe7eqtjZxzxd+HModmoj4iqMr2j3jDJRODplM1xZwgg=;
 b=UHq8mVtjTUPrDcywIaiMpzarrRlocXQ1U5sL1lTub2aFZ7LbahrKTn8Qorh6iVdxqUM3obdXf7RHmbNFULgqj0Y9MIdxeXsdqFPy4leLYxdqRJSGa5o45FdSmxlBOVeU69qYpWausz7gvGa3yhhBBXoqHwrATpwyYEJjos75e5M=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB3182.namprd12.prod.outlook.com (2603:10b6:208:107::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 12:01:00 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::7cc0:785c:ea66:ef94]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::7cc0:785c:ea66:ef94%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 12:01:00 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no need to clean debugfs at amdgpu
Thread-Topic: [PATCH] drm/amdgpu: no need to clean debugfs at amdgpu
Thread-Index: AQHV7WQmoYRozgPMN0SHYSNl+T6rQagu7k0AgAAB4WA=
Date: Thu, 27 Feb 2020 12:01:00 +0000
Message-ID: <MN2PR12MB3039B218E0835F63639C54B4E5EB0@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200227115040.32447-1-yttao@amd.com>
 <fa0bfba9-cd46-de37-2bf4-8f4c3fe4cd74@amd.com>
In-Reply-To: <fa0bfba9-cd46-de37-2bf4-8f4c3fe4cd74@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb8ac152-903e-455a-fd99-08d7bb7cb64e
x-ms-traffictypediagnostic: MN2PR12MB3182:|MN2PR12MB3182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3182AAB71F7600EEE7818FB6E5EB0@MN2PR12MB3182.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(86362001)(76116006)(71200400001)(478600001)(53546011)(66556008)(66476007)(64756008)(66946007)(66446008)(110136005)(81166006)(81156014)(9686003)(186003)(6506007)(26005)(55016002)(8676002)(2906002)(7696005)(8936002)(4326008)(316002)(6636002)(52536014)(33656002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3182;
 H:MN2PR12MB3039.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Auu7nHAk/Pe2aR0Wg14898H9AgdlhXgRpvzR7G/vjHx6nB6FJFOxIjrYQOcqgKJ1ZUuvdZDxYhkQbMNyuHmkvxhPB2si4fxrGr0qs+8ldS7EwNXn1va8YfFek0OKdRjFCUl7gnqU1eMbX8Vsr42NEquHMggVjXoZHCNzPoHzCnuvTtTEXky+QlDVIFsLjXdX1uDWyxZeiH1lTdSxhu0i0xQnzq5foMvTGr6pQWGmuhvCgsfcCxnzfktRXdBez9YUjtnwLjcOMcpMb5KWoF8/yQH9oPDwBDQAd8vJnYlHpVOqqetDOs6zpmYdDZC+w3q7T20JL1jAq+H/gTkxHzNZZBz6Eh+6QAFl0mK03l+fuUqzRKnY3Dr57ayLeTM/By7aBpQyR9JQwdN4td/VQrDIExenfC+MUtXH5tnPBUUAJpP3ROBkwPYjmlsVnX7Bz4u
x-ms-exchange-antispam-messagedata: WfNCA6Y1gZP1sN9XXbKQd+Bktn7qNQEV6Z4c43zrCa4rYETvL2Y9UNJrPXuHtaEKo+8QOMhrcem8vcmFjMGvXPWXXAbJCPcRarpvqrfuL9a+GA0gjWmBFudZgdu8qkERtGNvQ/P6bWii9OQGxAHSmA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ac152-903e-455a-fd99-08d7bb7cb64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 12:01:00.4143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49YWXjbpeFJpbk09O7USk8aCQpON5N2Npue9j+efzqhpxp5fLvVLcAmGoSmvTOx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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

SGkgIENocmlzdGlhbg0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gSSB3aWxsIHJlbW92
ZSBhbGwgY2xlYW51cC9maW5pIGNvZGUgYXMgd2VsbC4NCg0KQmVzdCBSZWdhcmRzDQpZaW50aWFu
IFRhbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gDQpTZW50OiAyMDIw5bm0MuaciDI35pelIDE5
OjU0DQpUbzogVGFvLCBZaW50aWFuIDxZaW50aWFuLlRhb0BhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBubyBuZWVkIHRv
IGNsZWFuIGRlYnVnZnMgYXQgYW1kZ3B1DQoNCklmIHdlIGRvIHRoaXMgd2Ugc2hvdWxkIHByb2Jh
Ymx5IG1ha2UgbmFpbHMgd2l0aCBoZWFkcyBhbmQgcmVtb3ZlIHRoZSB3aG9sZSBjbGVhbnVwL2Zp
bmkgY29kZSBhcyB3ZWxsLg0KDQpDaHJpc3RpYW4uDQoNCkFtIDI3LjAyLjIwIHVtIDEyOjUwIHNj
aHJpZWIgWWludGlhbiBUYW86DQo+IGRybV9taW5vcl91bnJlZ2lzdGVyIHdpbGwgaW52b2tlIGRy
bV9kZWJ1Z2ZzX2NsZWFudXAgdG8gY2xlYW4gYWxsIHRoZSANCj4gY2hpbGQgbm9kZSB1bmRlciBw
cmltYXJ5IG1pbm9yIG5vZGUuDQo+IFdlIGRvbid0IG5lZWQgdG8gaW52b2tlIGFtZGdwdV9kZWJ1
Z2ZzX2ZpbmkgYW5kIA0KPiBhbWRncHVfZGVidWdmc19yZWdzX2NsZWFudXAgdG8gY2xlYW4gYWdp
YW4uDQo+IE90aGVyd2lzZSwgaXQgd2lsbCByYWlzZSB0aGUgTlVMTCBwb2ludGVyIGxpa2UgYmVs
b3cuDQo+IFsgICA0NS4wNDYwMjldIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlIGF0IDAwMDAwMDAwMDAwMDAwYTgNCj4gWyAgIDQ1LjA0NzI1Nl0g
UEdEIDAgUDREIDANCj4gWyAgIDQ1LjA0NzcxM10gT29wczogMDAwMiBbIzFdIFNNUCBQVEkNCj4g
WyAgIDQ1LjA0ODE5OF0gQ1BVOiAwIFBJRDogMjc5NiBDb21tOiBtb2Rwcm9iZSBUYWludGVkOiBH
ICAgICAgICBXICBPRSAgICAgNC4xOC4wLTE1LWdlbmVyaWMgIzE2fjE4LjA0LjEtVWJ1bnR1DQo+
IFsgICA0NS4wNDk1MzhdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCAr
IFBJSVgsIDE5OTYpLCBCSU9TIDEuMTIuMC0xIDA0LzAxLzIwMTQNCj4gWyAgIDQ1LjA1MDY1MV0g
UklQOiAwMDEwOmRvd25fd3JpdGUrMHgxZi8weDQwDQo+IFsgICA0NS4wNTExOTRdIENvZGU6IDkw
IDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwIDU1IDQ4IDg5IGU1
IDUzIDQ4IDg5IGZiIGU4IGNlIGQ5IGZmIGZmIDQ4IGJhIDAxIDAwIDAwIDAwIGZmIGZmIGZmIGZm
IDQ4IDg5IGQ4IDxmMD4gNDggMGYgYzEgMTAgODUgZDIgNzQgMDUgZTggNTMgMWMgZmYgZmYgNjUg
NDggOGIgMDQgMjUgMDAgNWMgMDENCj4gWyAgIDQ1LjA1MzcwMl0gUlNQOiAwMDE4OmZmZmZhZDhm
NDEzM2ZkNDAgRUZMQUdTOiAwMDAxMDI0Ng0KPiBbICAgNDUuMDU0Mzg0XSBSQVg6IDAwMDAwMDAw
MDAwMDAwYTggUkJYOiAwMDAwMDAwMDAwMDAwMGE4IFJDWDogZmZmZmEwMTEzMjdkZDgxNA0KPiBb
ICAgNDUuMDU1MzQ5XSBSRFg6IGZmZmZmZmZmMDAwMDAwMDEgUlNJOiAwMDAwMDAwMDAwMDAwMDAx
IFJESTogMDAwMDAwMDAwMDAwMDBhOA0KPiBbICAgNDUuMDU2MzQ2XSBSQlA6IGZmZmZhZDhmNDEz
M2ZkNDggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZmZmZmZjMDY5MGEwMA0KPiBbICAg
NDUuMDU3MzI2XSBSMTA6IGZmZmZhZDhmNDEzM2ZkNTggUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIx
MjogZmZmZmEwMTEzY2ZmMDMwMA0KPiBbICAgNDUuMDU4MjY2XSBSMTM6IGZmZmZhMDExM2MwYTAw
MDAgUjE0OiBmZmZmZmZmZmMwYzAyYTEwIFIxNTogZmZmZmEwMTEzZTVjNzg2MA0KPiBbICAgNDUu
MDU5MjIxXSBGUzogIDAwMDA3ZjYwZDQ2Zjk1NDAoMDAwMCkgR1M6ZmZmZmEwMTEzZmMwMDAwMCgw
MDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+IFsgICA0NS4wNjA4MDldIENTOiAgMDAxMCBE
UzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gWyAgIDQ1LjA2MTgyNl0g
Q1IyOiAwMDAwMDAwMDAwMDAwMGE4IENSMzogMDAwMDAwMDEzNjI1MDAwNCBDUjQ6IDAwMDAwMDAw
MDAzNjA2ZjANCj4gWyAgIDQ1LjA2MjkxM10gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAw
MDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgIDQ1LjA2NDQwNF0gRFIz
OiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAw
MDA0MDANCj4gWyAgIDQ1LjA2NTg5N10gQ2FsbCBUcmFjZToNCj4gWyAgIDQ1LjA2NjQyNl0gIGRl
YnVnZnNfcmVtb3ZlKzB4MzYvMHhhMA0KPiBbICAgNDUuMDY3MTMxXSAgYW1kZ3B1X2RlYnVnZnNf
cmluZ19maW5pKzB4MTUvMHgyMCBbYW1kZ3B1XQ0KPiBbICAgNDUuMDY4MDE5XSAgYW1kZ3B1X2Rl
YnVnZnNfZmluaSsweDJjLzB4NTAgW2FtZGdwdV0NCj4gWyAgIDQ1LjA2ODc1Nl0gIGFtZGdwdV9w
Y2lfcmVtb3ZlKzB4NDkvMHg3MCBbYW1kZ3B1XQ0KPiBbICAgNDUuMDY5NDM5XSAgcGNpX2Rldmlj
ZV9yZW1vdmUrMHgzZS8weGMwDQo+IFsgICA0NS4wNzAwMzddICBkZXZpY2VfcmVsZWFzZV9kcml2
ZXJfaW50ZXJuYWwrMHgxOGEvMHgyNjANCj4gWyAgIDQ1LjA3MDg0Ml0gIGRyaXZlcl9kZXRhY2gr
MHgzZi8weDgwDQo+IFsgICA0NS4wNzEzMjVdICBidXNfcmVtb3ZlX2RyaXZlcisweDU5LzB4ZDAN
Cj4gWyAgIDQ1LjA3MTg1MF0gIGRyaXZlcl91bnJlZ2lzdGVyKzB4MmMvMHg0MA0KPiBbICAgNDUu
MDcyMzc3XSAgcGNpX3VucmVnaXN0ZXJfZHJpdmVyKzB4MjIvMHhhMA0KPiBbICAgNDUuMDczMDQz
XSAgYW1kZ3B1X2V4aXQrMHgxNS8weDU3YyBbYW1kZ3B1XQ0KPiBbICAgNDUuMDczNjgzXSAgX194
NjRfc3lzX2RlbGV0ZV9tb2R1bGUrMHgxNDYvMHgyODANCj4gWyAgIDQ1LjA3NDM2OV0gIGRvX3N5
c2NhbGxfNjQrMHg1YS8weDEyMA0KPiBbICAgNDUuMDc0OTE2XSAgZW50cnlfU1lTQ0FMTF82NF9h
ZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8
eXR0YW9AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMSAtDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jICAgIHwgMSAtDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRl
eCA4ZWY4YTQ5YjkyNTUuLjM1MTA5NmFiNDMwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtMzIzNyw3ICszMjM3LDYgQEAgdm9pZCBh
bWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgCWFkZXYt
PnJtbWlvID0gTlVMTDsNCj4gICAJYW1kZ3B1X2RldmljZV9kb29yYmVsbF9maW5pKGFkZXYpOw0K
PiAgIA0KPiAtCWFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfY2xlYW51cChhZGV2KTsNCj4gICAJZGV2aWNl
X3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3BjaWVfcmVwbGF5X2NvdW50KTsNCj4g
ICAJaWYgKGFkZXYtPnVjb2RlX3N5c2ZzX2VuKQ0KPiAgIAkJYW1kZ3B1X3Vjb2RlX3N5c2ZzX2Zp
bmkoYWRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+
IGluZGV4IDdjZjVmNTk3YjkwYS4uMDJkODBiOWRiZmUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IEBAIC0xMTM5LDcgKzExMzksNiBAQCBhbWRncHVf
cGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gICAJCURSTV9FUlJPUigiSG90cGx1
ZyByZW1vdmFsIGlzIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiAgIAlkcm1fZGV2X3VucGx1ZyhkZXYp
Ow0KPiAgIAlkcm1fZGV2X3B1dChkZXYpOw0KPiAtCWFtZGdwdV9kZWJ1Z2ZzX2ZpbmkoYWRldik7
DQo+ICAgCWFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyhkZXYpOw0KPiAgIAlwY2lfZGlzYWJsZV9k
ZXZpY2UocGRldik7DQo+ICAgCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
