Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD89CA9ECB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 00:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322C62086D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 00:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322C62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AED6F6A3;
	Fri,  1 Nov 2019 00:15:12 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790079.outbound.protection.outlook.com [40.107.79.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A9D6F6A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 00:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh/xLyF9H/qxk+LaYycyHc9ipwqauXibICcmsBMVpPZfxCi5Utw38M6BBHgB2QVsMsVDOU2kMQVNodvj+aVlV0y20jCiQvMloqo2uoYMXeLLRCPFpLRVv7vwgmrSzvPKR6FtBoCvEQxlcNSq3uB0uX5OjrxWzjUKpmYfDgD+IdKuRW05d/y9IHeASn5O6XZy6X69PQtHxdmbtMP1/XnD6JNg1T/R2zaVqF9NrRJTIYSREFWAY9jk6n497DR6/+Y2UDGVM4/nLh5P5GSRUKFT4jUgkoM3EZPgMT8o1gi8qh5dIOZ/ARB7XMkT6j645mahs4nTtfx0LTNAHptZyMV3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X776s054taQfr0EudaDCE4v3C1TRw4bR2UHQLlELJyU=;
 b=QZ2sqOKw5R9ADZYUbbVKyWnERO/GDUsQxM4Kajv1N/dMLgP1i0YQv8nV1STzxymM02dADOwA6FX7GBYLqrYuJGCbaq28MjfCthSDcOKugtKbiaTOfVH6ktFozamB7DyFRopNKVyjSIMC+UW03dvo/nVjAskqrYDLvs0gMp1Q2uVSHx4XhdwF7t387LieOlv/ro3/lMPp7UVyNvjZ/9tLOFylY90ByvRC40JKeI/WPDOcNheH+TKrXmsyvC1R3UbbpQEJjJQlMMuBvrhYmuc8GmHwWivu2X9zjzIIvuQm2b4DR64BRN8WZebxBZwJhVaRbKkHzeJ3RS3MsVK5IOF3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.198.10) by
 DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 00:15:10 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::58fb:d29:4e24:b487]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::58fb:d29:4e24:b487%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 00:15:10 +0000
From: "Tuikov, Luben" <Luben.Tuikov@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: implement TMZ accessor
Thread-Topic: [PATCH] drm/amdgpu: implement TMZ accessor
Thread-Index: AQHVj3vIu5o1QF1E1kiqpSkaiJP19ad0WsyAgAEZEgA=
Date: Fri, 1 Nov 2019 00:15:09 +0000
Message-ID: <ad0649b5-44e9-055a-04a1-ca26fc588316@amd.com>
References: <20191030234233.9896-1-luben.tuikov@amd.com>
 <2723dbff-806b-542f-4ed1-0e9fc807ca15@gmail.com>
In-Reply-To: <2723dbff-806b-542f-4ed1-0e9fc807ca15@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:38::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 804849ab-f5ad-4154-d9b2-08d75e608e97
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29077E8A6BAA383C8F651A8599620@DM6PR12MB2907.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(6512007)(2501003)(5660300002)(66446008)(8936002)(6116002)(3846002)(6436002)(66066001)(6246003)(81166006)(229853002)(7736002)(305945005)(81156014)(36756003)(6486002)(8676002)(2906002)(4001150100001)(31686004)(66476007)(66556008)(64756008)(66946007)(486006)(86362001)(25786009)(316002)(31696002)(14444005)(256004)(2616005)(476003)(478600001)(52116002)(110136005)(99286004)(71200400001)(186003)(14454004)(71190400001)(26005)(102836004)(66574012)(4326008)(53546011)(386003)(6506007)(446003)(11346002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwE+KoTUfcMt7tLPMREZW8YT27mdpXUVJLO9THCkkmUMe/ue0mrm1buWFcL1Ww+3diaRWsoAqGd931DtmfG2s8hoBASwrkceTlUBZjUimu+X/tZj9XDXZ4BvwndXB0aIWRGRaV6sIxKx/pfkvqIcl/anPmquhq29ADE4kwbUqFgsQ5qOc6qezdzwO68wBRakCL5xmoNiY/dEy+3950O0e+eA3AAF5fNdk4Duf25UQuGbyh3AMwe6U1i1lf7Y1u6uifP0JZ+k37YPR/Gg8nGz0oSCy/3wMhKs8TZ8SK46drNx52yYrjoaXpjEzJbHym0iTa2S+xQokLpY50TcUpCXoCyRzOyfzMb/9afenfN5g4j1aNv3kcZw/nrSgNdpsOFGDCxvFd5e8rt+Sg2U1RdRyda2WCtQ/uUefZ5d59UYfHy7Z9kEGlUFmEZBKeEpjHCZ
Content-ID: <CC83EC58B7A13247AC3F79600798D826@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804849ab-f5ad-4154-d9b2-08d75e608e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 00:15:09.9781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiPJCAz8oQQLzsHr/8kzgp2lSJEkIyVW4zbI/GwZ+3q3BJ8j1FV1CbmpNDF3GZPq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X776s054taQfr0EudaDCE4v3C1TRw4bR2UHQLlELJyU=;
 b=0Km/bc0xQ9/My/Yrbdf1sRr4G9k7VCjSGUmiGWy1pcGlk7sex7DTN2BrqCmXfbPpBzp7cD9iORtgg3dB7thhUr+sayGLkER2kyqBSO+jYcKdA+79RMFCJPT6Xxc5P57sTOZQjP30G4MnQvNeTfDnWXuD1EGC6kIWq1oMIS6b3E8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101001509.lwaaI0KjY61bd2BQfByj4Yfxn_DR6i7DZQo5pbqHFCM@z>

T24gMjAxOS0xMC0zMSAzOjI5IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IEFtIDMx
LjEwLjE5IHVtIDAwOjQzIHNjaHJpZWIgVHVpa292LCBMdWJlbjoNCj4+IEltcGxlbWVudCBhbiBh
Y2Nlc3NvciBvZiBhZGV2LT50bXouZW5hYmxlZC4gTGV0IG5vdA0KPj4gY29kZSBhcm91bmQgYWNj
ZXNzIGl0IGFzICJpZiAoYWRldi0+dG16LmVuYWJsZWQpIg0KPj4gYXMgdGhlIG9yZ2FuaXphdGlv
biBtYXkgY2hhbmdlLiBJbnN0ZWFkLi4uDQo+Pg0KPj4gUmVjcnVpdCAiYm9vbCBhbWRncHVfaXNf
dG16KGFkZXYpIiB0byByZXR1cm4NCj4+IGV4YWN0bHkgdGhpcyBCb29sZWFuIHZhbHVlLiBUaGF0
IGlzLCB0aGlzIGZ1bmN0aW9uDQo+PiBpcyBub3cgYW4gYWNjZXNzb3Igb2YgYW4gYWxyZWFkeSBp
bml0aWFsaXplZCBhbmQNCj4+IHNldCBhZGV2IGFuZCBhZGV2LT50bXouDQo+Pg0KPj4gQWRkICJ2
b2lkIGFtZGdwdV90bXpfc2V0KGFkZXYpIiB0byBjaGVjayBhbmQgc2V0DQo+PiBhZGV2LT50bXou
KiBhdCBpbml0aWFsaXphdGlvbiB0aW1lLiBBZnRlciB3aGljaA0KPj4gb25lIHVzZXMgImJvb2wg
YW1kZ3B1X2lzX3RteihhZGV2KSIgdG8gcXVlcnkNCj4+IHdoZXRoZXIgYWRldiBzdXBwb3J0cyBU
TVouDQo+IA0KPiBBY3R1YWxseSBJIHdvdWxkIHJhdGhlciBjb21wbGV0ZWx5IHJlbW92ZSB0aGUg
YW1kZ3B1X3Rtei5baGNdIGZpbGVzLiBTZWUgDQo+IFRNWiBpcyBhIGZlYXR1cmUgYW5kIG5vdCBh
IGhhcmR3YXJlIGJsb2NrLg0KPiANCj4gQWxsIHRoYXQgc3R1ZmYgc2hvdWxkIHByb2JhYmx5IG1v
dmVkIGludG8gdGhlIFBTUCBoYW5kbGluZywgc2luY2UgdGhlIA0KPiBjb250cm9sIG9mIFRNWiBp
cyBlbmFibGVkIG9yIGRpc2FibGVkIGluIHRoZSBoYXJkd2FyZSBpcyB0aGVyZS4NCg0KSGkgQ2hy
aXN0aWFuLA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGlzLiBTdXJlLCB3ZSBjYW4gZG8gdGhh
dCBhcyB3ZWxsLCBzaG91bGQNCnRoZXJlIGJlIGNvbnNlbnN1cyBvbiBpdC4NCg0KSSBqdXN0IHNh
dyBteXNlbGYgbmVlZGluZyB0byBrbm93IGlmIHRoZSBkZXZpY2UgaXMgVE1aIChhcyB3ZWxsDQph
cyBpZiBhIGJ1ZmZlciBpcyBUTVogZm9yIHdoaWNoIEkgdXNlZCBhbWRncHVfYm9fZW5jcnlwdGVk
KCkpDQphbmQgc28gaXQgYmVjYW1lIG5hdHVyYWwgdG8gd3JpdGUgKGFmdGVyIHRoaXMgcGF0Y2gp
Og0KDQppZiAoIWFtZGdwdV9ib19lbmNyeXB0ZWQoYWJvKSB8fCAhYW1kZ3B1X2lzX3RteihhZGV2
KSkgew0KCS8qIG5vcm1hbCBwcm9jZXNzaW5nICovDQp9IGVsc2Ugew0KCS8qIFRNWiBwcm9jZXNz
aW5nICovDQp9DQoNCkJUVywgc2hvdWxkIHdlIHByb2NlZWQgYXMgeW91IHN1Z2dlc3RlZCwgZG8g
eW91IHNlZQ0KdGhvc2UgcHJpbWl0aXZlcyBnb2luZyBpbnRvIHBzcF92MTJfMC5jPw0KDQpSZWdh
cmRzLA0KTHViZW4NCg0KPiANCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPiANCj4+DQo+PiBB
bHNvLCByZW1vdmUgY2lyY3VsYXIgaGVhZGVyIGZpbGUgaW5jbHVkZS4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPg0KPj4gLS0tDQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICA1ICsrKysrDQo+
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8ICAyICstDQo+
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouYyAgICB8IDIzICsrKysr
KysrKysrLS0tLS0tLS0tLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Rtei5oICAgIHwgIDcgKystLS0tLQ0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oDQo+PiBpbmRleCA3ZDFlNTI4Y2M3ODMuLjIzYmQ4MWE3NjU3MCAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPj4gQEAgLTEyNDksNSArMTI0OSwxMCBAQCBfbmFt
ZSMjX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAkJCQkJXA0KPj4gICAJCQkJCQkJCQlcDQo+PiAg
IHN0YXRpYyBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBwbXVfYXR0cl8jI19uYW1lID0gX19BVFRS
X1JPKF9uYW1lKQ0KPj4gICANCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X2lzX3Rteihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICt7DQo+PiArCXJldHVybiBhZGV2LT50bXou
ZW5hYmxlZDsNCj4+ICt9DQo+PiArDQo+PiAgICNlbmRpZg0KPj4gICANCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGluZGV4IDRlZWU0MGI5ZDBiMC4u
ZjEyYjgxNzQ4MGJiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4+IEBAIC0xMDU4LDcgKzEwNTgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9k
ZXZpY2VfY2hlY2tfYXJndW1lbnRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAN
Cj4+ICAgCWFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9IGFtZGdwdV91Y29kZV9nZXRfbG9hZF90
eXBlKGFkZXYsIGFtZGdwdV9md19sb2FkX3R5cGUpOw0KPj4gICANCj4+IC0JYWRldi0+dG16LmVu
YWJsZWQgPSBhbWRncHVfaXNfdG16KGFkZXYpOw0KPj4gKwlhbWRncHVfdG16X3NldChhZGV2KTsN
Cj4+ICAgDQo+PiAgIAlyZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Rtei5jDQo+PiBpbmRleCA4MjM1MjdhMGZhNDcuLjUxOGI5ZDMzNTU1MCAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouYw0K
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5jDQo+PiBAQCAt
MjcsMjYgKzI3LDI1IEBADQo+PiAgICNpbmNsdWRlICJhbWRncHUuaCINCj4+ICAgI2luY2x1ZGUg
ImFtZGdwdV90bXouaCINCj4+ICAgDQo+PiAtDQo+PiAgIC8qKg0KPj4gLSAqIGFtZGdwdV9pc190
bXogLSB2YWxpZGF0ZSB0cnVzdCBtZW1vcnkgem9uZQ0KPj4gLSAqDQo+PiArICogYW1kZ3B1X3Rt
el9zZXQgLS0gY2hlY2sgYW5kIHNldCBpZiBhIGRldmljZSBzdXBwb3J0cyBUTVoNCj4+ICAgICog
QGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcg0KPj4gICAgKg0KPj4gLSAqIFJldHVybiB0cnVl
IGlmIEBkZXYgc3VwcG9ydHMgdHJ1c3RlZCBtZW1vcnkgem9uZXMgKFRNWiksIGFuZCByZXR1cm4g
ZmFsc2UgaWYNCj4+IC0gKiBAZGV2IGRvZXMgbm90IHN1cHBvcnQgVE1aLg0KPj4gKyAqIENoZWNr
IGFuZCBzZXQgaWYgYW4gdGhlIGRldmljZSBAYWRldiBzdXBwb3J0cyBUcnVzdGVkIE1lbW9yeQ0K
Pj4gKyAqIFpvbmVzIChUTVopLg0KPj4gICAgKi8NCj4+IC1ib29sIGFtZGdwdV9pc190bXooc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiArdm9pZCBhbWRncHVfdG16X3NldChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgew0KPj4gICAJaWYgKCFhbWRncHVfdG16KQ0KPj4g
LQkJcmV0dXJuIGZhbHNlOw0KPj4gKwkJcmV0dXJuOw0KPj4gICANCj4+IC0JaWYgKGFkZXYtPmFz
aWNfdHlwZSA8IENISVBfUkFWRU4gfHwgYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMp
IHsNCj4+IC0JCWRldl93YXJuKGFkZXYtPmRldiwgImRvZXNuJ3Qgc3VwcG9ydCB0cnVzdGVkIG1l
bW9yeSB6b25lcyAoVE1aKVxuIik7DQo+PiAtCQlyZXR1cm4gZmFsc2U7DQo+PiArCWlmIChhZGV2
LT5hc2ljX3R5cGUgPCBDSElQX1JBVkVOIHx8DQo+PiArCSAgICBhZGV2LT5hc2ljX3R5cGUgPT0g
Q0hJUF9BUkNUVVJVUykgew0KPj4gKwkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiVHJ1c3RlZCBNZW1v
cnkgWm9uZSAoVE1aKSBmZWF0dXJlIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPj4gKwkJcmV0dXJuOw0K
Pj4gICAJfQ0KPj4gICANCj4+IC0JZGV2X2luZm8oYWRldi0+ZGV2LCAiVE1aIGZlYXR1cmUgaXMg
ZW5hYmxlZFxuIik7DQo+PiArCWFkZXYtPnRtei5lbmFibGVkID0gdHJ1ZTsNCj4+ICAgDQo+PiAt
CXJldHVybiB0cnVlOw0KPj4gKwlkZXZfaW5mbyhhZGV2LT5kZXYsICJUcnVzdGVkIE1lbW9yeSBa
b25lIChUTVopIGZlYXR1cmUgc3VwcG9ydGVkIGFuZCBlbmFibGVkXG4iKTsNCj4+ICAgfQ0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouaA0KPj4gaW5kZXggMjhlMDUxNzdm
Yjg5Li5hZDNhZDhjMDExZjkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdG16LmgNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90bXouaA0KPj4gQEAgLTI0LDE2ICsyNCwxMyBAQA0KPj4gICAjaWZuZGVmIF9fQU1ER1BV
X1RNWl9IX18NCj4+ICAgI2RlZmluZSBfX0FNREdQVV9UTVpfSF9fDQo+PiAgIA0KPj4gLSNpbmNs
dWRlICJhbWRncHUuaCINCj4+IC0NCj4+ICAgLyoNCj4+IC0gKiBUcnVzdCBtZW1vcnkgem9uZSBz
dHVmZg0KPj4gKyAqIFRydXN0ZWQgTWVtb3J5IFpvbmUgcGFydGljdWxhcnMNCj4+ICAgICovDQo+
PiAgIHN0cnVjdCBhbWRncHVfdG16IHsNCj4+ICAgCWJvb2wJZW5hYmxlZDsNCj4+ICAgfTsNCj4+
ICAgDQo+PiAtDQo+PiAtZXh0ZXJuIGJvb2wgYW1kZ3B1X2lzX3RteihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldik7DQo+PiArZXh0ZXJuIHZvaWQgYW1kZ3B1X3Rtel9zZXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpOw0KPj4gICANCj4+ICAgI2VuZGlmDQo+IA0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
