Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7AC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 10:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEEC2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 10:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vXYvH3e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEEC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8C46EBBC;
	Fri, 13 Mar 2020 10:40:48 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690058.outbound.protection.outlook.com [40.107.69.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D96A6EBBC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 10:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAGViEHdTZO+xf/eLJU8aXvPcAvILgXTcjKJaSSSW01xU2FIH3j4Q5qeXllqAp43dXAqS0xYSgulRcZ4W810PgEAK/n1ITjk19MteU00v13qBhTIiKAd4tALK8BHYfuEjICKPV1shRdBATNNg2nrFhuqqYNDtD//o9krrujpjsA/iNech4zm+kN3hrHm5WM23PCnirwHjNWorMztdm6sDncjmDY+DvdykV/8O6Ei/WC+IY7S0Hta0oRTzE6W0YKAKnniZ8wSh5cCVajPK7dshPD7udxDvZUxcioo7+Lg+xW7vn6xc32+vqFS2mY0671hcVnkFOvhBBou3IuJRqQZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbFZxKtnmfS+LsfrVUFblfjvHULbkOlpGTnET+Jzjgw=;
 b=AzdiACwEpASGGfOb9a4DBiwMt9iW+d4Em+7ZIxafAsiCNSc/Gt+KoI7zAEBeB+7iy8qSvXWkwPGJxjFiZZTkj8gynizQxTeAEZCoVgnUzI16IcpCEtVh+uhyJ5O3Yu3g+kwb++nCquz71nSRhM5KJZRf9f5sDRp9LIR/BmhG2Z/YjTgvB2zd8sLu921/F2+s+U8otN/Zb1SidjEkj/RO2cbkFPEcduuVRxQEldBs8QHw7KbfZsoOxOTG7Xgux9TZF3el71UP6hg7S5NrKMoOMvGvxLnSawToiE9TwfhjcMkFDJAJRF8h4n9/bQAIRtP6SYVX+n4NQeQ/1NQIF+ZTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbFZxKtnmfS+LsfrVUFblfjvHULbkOlpGTnET+Jzjgw=;
 b=vXYvH3e4+QG4jRTP48RHbC3KZFRWAc0So3GBQZxIFzYeVFsgxzyAUlHDc7wfm/hswpVzda2h7vOzt9+jLLPcsmCWAOorrSirDansK5MFaYafInOWh48q5zMgQ+zhJVYKAuQNUvtKEf9Ibxn3abJ3+SB+3CnsHOuH9DhE6j5fBfg=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:40:43 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 10:40:43 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
Thread-Topic: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
Thread-Index: AQHV+QssFpyaZpcpG0W9yYu71Go6f6hGN1IAgAAKPoCAAAdWgIAABzqAgAAAwwCAAAS1gA==
Date: Fri, 13 Mar 2020 10:40:43 +0000
Message-ID: <FC898EB4-8E9D-460B-8D0A-D138582E315E@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
 <20200313074336.19545-2-xinhui.pan@amd.com>
 <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
 <0D32D879-69FB-4D0F-8742-1BB9BF0AB766@amd.com>
 <227b3535-83c2-87af-56c0-be3ed28a0413@amd.com>
 <4524679A-5CA8-4A7E-A9BD-F0E343931A25@amd.com>
 <ef06f480-c5d7-987f-4e84-24636f1d5770@amd.com>
In-Reply-To: <ef06f480-c5d7-987f-4e84-24636f1d5770@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68abbe4e-620d-4371-051a-08d7c73afb85
x-ms-traffictypediagnostic: SN6PR12MB2623:|SN6PR12MB2623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26237F0362D8C91E8C5DBB2187FA0@SN6PR12MB2623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(66946007)(64756008)(6636002)(5660300002)(8936002)(66446008)(66476007)(66556008)(6862004)(4326008)(2906002)(91956017)(8676002)(36756003)(76116006)(66574012)(6506007)(6512007)(316002)(478600001)(2616005)(6486002)(33656002)(54906003)(71200400001)(81156014)(37006003)(81166006)(186003)(86362001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2623;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPu/Yf0z9exl5pzphHKsD+vw/e0Xkqa9dJX6GoJaYVhDueN6rcXYAibPXcDdlXGJfZojjDqhVwCF7k9cSJTIDoHAUIRAWIFZkpNH3QW3lQ+En2HIkMROeLxwmJyq7Wfc31cVyvxb8NfSyi6apDkKBMm72vLBkbgSZWnP675i72/EfyKSrNa2ZnSq8hlrVFesmWJs3ANKwF7EoNRADS5ssfeBk175++HXYAus1hed2FZNkXRbOnyqLmgjyTSIr/xhwCdmaAFoj1+vEJIgX54eF2yuEV5KxTg9GQluTS8LYQGD4NfsmRiV+L7hHbRKV7aFBUM3qcsDE17ZiviCG4UZDeFBKOuiRALkthZfX/39n/Czk9bfChzCpYzq4jn5deu4MC7CB+BGk480ZEg4x3yvnBIJ2iPFBV4FocCNvEqzFZ/Jhf7Rd5x6aYyuMAYJsXRo
x-ms-exchange-antispam-messagedata: ZyItMFvMFFqE0QxnaZ4cozj194Pqn9usBu/q9khEkVB7WNG7FAodoLAymq7e2FLXW0sEavjtKGm0//w6/sxdFRLQkY1GzlEtiaRJDeRxIKodMfgKQHINjajw0ys7zWpx1imo49wCzwPu4iUoWkEQKQ==
Content-ID: <556095FA1315EF429D6E909693D13DCE@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68abbe4e-620d-4371-051a-08d7c73afb85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 10:40:43.6794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qCBL9DXBuUNC/EKN4VQnqrnEyJZIgk+76M6cuud75IxDnGdK9I2ndwbs/K6ZrJ+
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

DQoNCj4gMjAyMOW5tDPmnIgxM+aXpSAxODoyM++8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMTMuMDMuMjAgdW0gMTE6MjEg
c2NocmllYiBQYW4sIFhpbmh1aToNCj4+IA0KPj4+IDIwMjDlubQz5pyIMTPml6UgMTc6NTXvvIxL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiDlhpnpgZPvvJoNCj4+
PiANCj4+PiBBbSAxMy4wMy4yMCB1bSAxMDoyOSBzY2hyaWViIFBhbiwgWGluaHVpOg0KPj4+Pj4g
MjAyMOW5tDPmnIgxM+aXpSAxNjo1Mu+8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+IOWGmemBk++8mg0KPj4+Pj4gDQo+Pj4+PiBBbSAxMy4wMy4yMCB1bSAwODo0
MyBzY2hyaWViIHhpbmh1aSBwYW46DQo+Pj4+Pj4gVGhlIGZlbmNlIGdlbmVyYXRlZCBpbiAtPmNv
bW1pdCBpcyBhIHNoYXJlZCBvbmUsIHNvIGFkZCBpdCB0byByZXN2Lg0KPj4+Pj4+IEFuZCB3ZSBu
ZWVkIGRvIHRoYXQgd2l0aCBldmljdGlvbiBsb2NrIGhvbGQuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQ3Vy
cmVudGx5IHdlIG9ubHkgc3luYyBsYXN0X2RpcmVjdC9sYXN0X2RlbGF5ZWQgYmVmb3JlIC0+cHJl
cGFyZS4gQnV0IHdlDQo+Pj4+Pj4gZmFpbCB0byBzeW5jIHRoZSBsYXN0IGZlbmNlIGdlbmVyYXRl
ZCBieSAtPmNvbW1pdC4gVGhhdCBjdWFzZXMgcHJvYmxlbXMNCj4+Pj4+PiBpZiBldmljdGlvbiBo
YXBwZW5lcyBsYXRlciwgYnV0IGl0IGRvZXMgbm90IHN5bmMgdGhlIGxhc3QgZmVuY2UuDQo+Pj4+
PiBOQUssIHRoYXQgd29uJ3Qgd29yay4NCj4+Pj4+IA0KPj4+Pj4gV2UgY2FuIG9ubHkgYWRkIGZl
bmNlcyB3aGVuIHRoZSBkbWFfcmVzdiBvYmplY3QgaXMgbG9ja2VkIGFuZCB0aGF0IGlzIG9ubHkg
dGhlIGNhc2Ugd2hlbiB2YWxpZGF0aW5nLg0KPj4+Pj4gDQo+Pj4+IHdlbGwsIHRoYSB0aXMgdHJ1
ZS4NCj4+Pj4gYnV0IGNvbnNpZGVyaW5nIHRoaXMgaXMgYSBQVCBCTywgYW5kIG9ubHkgZXZpY3Rp
b24gaGFzIHJhY2Ugb24gaXQgQUZBSUsuDQo+Pj4+IGFzIGZvciB0aGUgaW5kaXZpZHVhbGl6ZWQg
cmVzdiBpbiBibyByZWxlYXNlLCB3ZSB1bnJlZiBQVCBCTyBqdXN0IGFmdGVyIHRoYXQuDQo+Pj4+
IEkgYW0gc3RpbGwgdGhpbmtpbmcgb2Ygb3RoZXIgcmFjZXMgaW4gdGhlIHJlYWwgd29ybGQuDQo+
Pj4gV2Ugc2hvdWxkIHByb2JhYmx5IGp1c3QgYWRkIGFsbCBwaXBlbGluZWQvZGVsYXllZCBzdWJt
aXNzaW9ucyBkaXJlY3RseSB0byB0aGUgcmVzZXJ2YXRpb24gb2JqZWN0IGluIGFtZGdwdV92bV9z
ZG1hX2NvbW1pdCgpLg0KPj4+IA0KPj4+IE9ubHkgdGhlIGRpcmVjdCBhbmQgaW52YWxpZGF0aW5n
IHN1Ym1pc3Npb25zIGNhbid0IGJlIGFkZGVkIGJlY2F1c2Ugd2UgY2FuJ3QgZ3JhYiB0aGUgcmVz
ZXJ2YXRpb24gb2JqZWN0IGluIHRoZSBNTVUgbm90aWZpZXIuDQoNCndhaXQsIEkgc2VlIGFtZGdw
dV92bV9oYW5kbGVfZmF1bHQgd2lsbCBncmFiIHRoZSByZXN2IGxvY2sgb2Ygcm9vdCBCTy4NCnNv
IG5vIHJhY2UgdGhlbj8NCg0KPj4+IA0KPj4+IENhbiB5b3UgcHJlcGFyZSBhIHBhdGNoIGZvciB0
aGlzPw0KPj4+IA0KPj4geWVwLCBJIGNhbi4NCj4+IEFkZGluZyBmZW5jZSB0byBibyByZXN2IGlu
IGV2ZXJ5IGNvbW1pdCBpbnRyb2R1Y2UgYSBsaXR0bGUgb3ZlcmxvYWQ/DQo+IA0KPiBZZXMgaXQg
ZG9lcywgYnV0IHdlIHVzZWQgdG8gaGF2ZSB0aGlzIGJlZm9yZSBhbmQgaXQgd2Fzbid0IHJlYWxs
eSBtZWFzdXJhYmxlLg0KPiANCj4gV2l0aCB0aGUgdW51c3VhbCBleGNlcHRpb24gb2YgbWFwcGlu
ZyByZWFsbHkgbGFyZ2UgY2h1bmtzIG9mIGZyYWdtZW50ZWQgc3lzdGVtIG1lbW9yeSB3ZSBvbmx5
IHVzZSBvbmUgY29tbWl0IGZvciBhbnl0aGluZyA8MUdCIGFueXdheS4NCj4gDQo+IENocmlzdGlh
bi4NCj4gDQo+PiBBcyB3ZSBvbmx5IG5lZWQgYWRkIHRoZSBsYXN0IGZlbmNlIHRvIHJlc3YgZ2l2
ZW4gdGhlIGZhY3QgdGhlIGpvYiBzY2hlZHVlciByaW5nIGlzIEZJRk8uDQo+PiB5ZXMsICBjb2Rl
IHNob3VsZCBiZSBzaW1wbGUgYW55d2F5IGFzIGxvbmcgYXMgaXQgd29ya3MuDQo+PiANCj4+IHRo
YW5rcw0KPj4geGluaHVpDQo+PiANCj4+PiBSZWdhcmRzLA0KPj4+IENocmlzdGlhbi4NCj4+PiAN
Cj4+Pj4gdGhhbmtzDQo+Pj4+IHhpbmh1aQ0KPj4+PiANCj4+Pj4+IEknbSBjb25zaWRlcmluZyB0
byBqdXN0IHBhcnRpYWxseSByZXZlcnQgdGhlIHBhdGNoIG9yaWdpbmFsbHkgc3RvcHBpbmcgdG8g
YWRkIGZlbmNlcyBhbmQgaW5zdGVhZCBvbmx5IG5vdCBhZGQgdGhlbSB3aGVuIGludmFsaWRhdGlu
ZyBpbiBhIGRpcmVjdCBzdWJtaXQuDQo+Pj4+PiANCj4+Pj4+IENocmlzdGlhbi4NCj4+Pj4+IA0K
Pj4+Pj4+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+
Pj4+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4+Pj4+
PiBDYzogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPg0KPj4+Pj4+IC0tLQ0K
Pj4+Pj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDkgKysrKysr
Ky0tDQo+Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pj4+Pj4gDQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMN
Cj4+Pj4+PiBpbmRleCA3MzM5ODgzMTE5NmYuLmY0MjRiNTk2OTkzMCAxMDA2NDQNCj4+Pj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPj4+Pj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+Pj4+Pj4gQEAgLTE1ODIs
NiArMTU4Miw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+Pj4+ICAJc3RydWN0IGFtZGdwdV92bV91cGRhdGVf
cGFyYW1zIHBhcmFtczsNCj4+Pj4+PiAgCWVudW0gYW1kZ3B1X3N5bmNfbW9kZSBzeW5jX21vZGU7
DQo+Pj4+Pj4gIAlpbnQgcjsNCj4+Pj4+PiArCXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+
cm9vdC5iYXNlLmJvOw0KPj4+Pj4+ICAgIAltZW1zZXQoJnBhcmFtcywgMCwgc2l6ZW9mKHBhcmFt
cykpOw0KPj4+Pj4+ICAJcGFyYW1zLmFkZXYgPSBhZGV2Ow0KPj4+Pj4+IEBAIC0xNjA0LDggKzE2
MDUsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4+Pj4+PiAgCX0NCj4+Pj4+PiAgICAJaWYgKGZsYWdzICYgQU1E
R1BVX1BURV9WQUxJRCkgew0KPj4+Pj4+IC0JCXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+
cm9vdC5iYXNlLmJvOw0KPj4+Pj4+IC0NCj4+Pj4+PiAgCQlpZiAoIWRtYV9mZW5jZV9pc19zaWdu
YWxlZCh2bS0+bGFzdF9kaXJlY3QpKQ0KPj4+Pj4+ICAJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwg
dm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsNCj4+Pj4+PiAgQEAgLTE2MjMsNiArMTYyMiwxMiBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4+Pj4+PiAgICAJciA9IHZtLT51cGRhdGVfZnVuY3MtPmNvbW1pdCgmcGFyYW1z
LCBmZW5jZSk7DQo+Pj4+Pj4gICsJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3Rf
ZGlyZWN0KSkNCj4+Pj4+PiArCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0
LCB0cnVlKTsNCj4+Pj4+PiArDQo+Pj4+Pj4gKwlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2
bS0+bGFzdF9kZWxheWVkKSkNCj4+Pj4+PiArCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxh
c3RfZGVsYXllZCwgdHJ1ZSk7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICBlcnJvcl91bmxvY2s6DQo+Pj4+
Pj4gIAlhbWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsNCj4+Pj4+PiAgCXJldHVybiByOw0K
PiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
