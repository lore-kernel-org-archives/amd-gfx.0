Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275EDCA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 18:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059612086D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 18:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059612086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4BC6F84F;
	Fri,  1 Nov 2019 18:24:57 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BCB6F84F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 18:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ8HgyBjVDku3fEc/22ZB8RszRaxNJ6KSmb7nJqFsz0Vqqh91X08xIIDONaHzAjvlmqMH2i1MoB4BM+bHn4AwqAMDEDUfNStWt1/1XS64q0qiIW06a0m+stAgCramU6xVgICUeMIG+nLNkz2kUnZM1bEBfVgxUlj4NlZuVmsR3WZXSukR9wLtdk1s+XJahxdR3m+hnc+0OgGp7nnl05JqxSS1OBxN9Wce8edP0ufCHGf3uVBd9ZxMlwSu3yzku7h7/C18FRpLMpsXJM8WLs/rJklUYuPqwa8+1sjjhCh1usHczg3JnYY4JWrDPzgqPPOQBKJd9BoDK4M7QSbb89Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw8FPsmZyKOHa6WVTDfkka3X285GiDiTBEfegXiJo6w=;
 b=KNpoqPzrg+3tEfl0tKqixTkJV0XN5xxrgp8IJbgIXWPX4gC1eLPPR27l2vONExLqNK4yifc1H0Nyw8g3M3W6Oq4ddgkrizw6IS4EAOaF5wW5AHp3O2o2S78wZMVCftt6agNQtw5YVArorOOph4hojnRUFYZwiZuDqMncKAXp6/u9iijtyl/ZlxXG9h5+O5NGKsZTTRwWBi63+Ln1tgafCElAwwNmP6nGb6W9+0Lko3NrZMZltyjyI/NbePykj8oB9HsGHGFV1oLudJBuu8Oq14ktkb/Oq5/H+VQYPa4Xgg/FD+0UCW3PH5ESGZOF1pO+ZgrkQC4HGqfi0QnaWD0Q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.198.10) by
 DM6PR12MB3306.namprd12.prod.outlook.com (20.179.106.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 18:24:55 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::58fb:d29:4e24:b487]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::58fb:d29:4e24:b487%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 18:24:55 +0000
From: "Tuikov, Luben" <Luben.Tuikov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: implement TMZ accessor
Thread-Topic: [PATCH] drm/amdgpu: implement TMZ accessor
Thread-Index: AQHVj3vIu5o1QF1E1kiqpSkaiJP19ad0WsyAgADWBACAAXB9AIAAAwkA
Date: Fri, 1 Nov 2019 18:24:55 +0000
Message-ID: <29e89f79-6a46-1c3a-a070-0296a7bbb5b4@amd.com>
References: <20191030234233.9896-1-luben.tuikov@amd.com>
 <2723dbff-806b-542f-4ed1-0e9fc807ca15@gmail.com>
 <ad0649b5-44e9-055a-04a1-ca26fc588316@amd.com>
 <CADnq5_PEO=2K=8-CCtvX+KOJstx-g9ba-zkT0TKsXDhH_2H0zQ@mail.gmail.com>
In-Reply-To: <CADnq5_PEO=2K=8-CCtvX+KOJstx-g9ba-zkT0TKsXDhH_2H0zQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:38::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.162.138.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c75b174-a4bf-4975-3c50-08d75ef8cb49
x-ms-traffictypediagnostic: DM6PR12MB3306:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3306358467260DC8CD880EFF99620@DM6PR12MB3306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(189003)(199004)(6916009)(7736002)(66066001)(6512007)(66446008)(2906002)(305945005)(4001150100001)(186003)(71200400001)(71190400001)(31696002)(6116002)(11346002)(66574012)(3846002)(476003)(2616005)(446003)(14444005)(256004)(86362001)(486006)(5660300002)(31686004)(64756008)(14454004)(6486002)(6246003)(25786009)(81156014)(8676002)(81166006)(229853002)(6436002)(478600001)(1411001)(966005)(316002)(76176011)(55236004)(53546011)(6506007)(36756003)(386003)(102836004)(52116002)(6306002)(8936002)(26005)(54906003)(4326008)(66946007)(66556008)(66476007)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3306;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7DtFTV+q9SYmPSj0DI2acoIjc/cIZWiGN4c5lpuzss7g3tn2Igx0ySeS+3gve3jM8N3hNwjq2zvQFR1HGiSJwQqvS4x8NxQa0I825LhIGnmPnQ3ptlyv0YFOOahgdIO36zj3PW7Kp5P/zybK88gTc7NUNkER1JWEcuyJYSQVn3/090ShZVbWsT2TbMc55xxe9C9oUn0p/xgvBvlvbajgEEx8wDvH+xEaLXkJifgvoGFniJzdD4Xy6k0M3s73IGre1tS7m6COMwLD2OKjPXPvIXm4BoO3xBHeZiYnD7Qq1tPq7W5WFlpmMj/wD7maoiGduNzfxMLI0/Xr1ixXpiH/eOsuYDQdsISdx65pMNYLWnvYy6nCDETjnPmmOyP2WcrazdFIbKVYenV/gjFmxjtZ6ylps5a56IVFCT7KDwRpNVtXWyqqAoulIXWCdwfc2ocS36HlG+KygwAuCQWnBrYTOvRGeaf1dM3a2uEdD3Ko71w=
Content-ID: <D7338170D24A154A896DC944CAA3BDD5@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c75b174-a4bf-4975-3c50-08d75ef8cb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 18:24:55.4507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUhAqPbt+c4/T5P22psSVX0YeW4NOqpZcWV1OFtTzcbvCGq4QQ6S60ITt+kKQR1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw8FPsmZyKOHa6WVTDfkka3X285GiDiTBEfegXiJo6w=;
 b=W5r6CVcj7x6TIX9XXMwlsRgD7FZzNLWmxf4nAc4h3jFFpDO0BPj0vH92Qj2/2uLHRHHmRxitv/PhYn5PkZZsBKXZjWwfWi4ZW2ByoEUikXYErxN6sU1o1peZlu8axd7KE9iTxmZPJGlQU83btGDETO6v09dQY+zHUPIYMS2QzVI=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101182455.j2RwtUVlfRI9QSywebeqE6T60RKZgTAGuzdvpml72tI@z>

T24gMjAxOS0xMS0wMSAxNDoxNCwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBPbiBUaHUsIE9jdCAz
MSwgMjAxOSBhdCA4OjE1IFBNIFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPiB3
cm90ZToNCj4+DQo+PiBPbiAyMDE5LTEwLTMxIDM6MjkgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3
cm90ZToNCj4+PiBBbSAzMS4xMC4xOSB1bSAwMDo0MyBzY2hyaWViIFR1aWtvdiwgTHViZW46DQo+
Pj4+IEltcGxlbWVudCBhbiBhY2Nlc3NvciBvZiBhZGV2LT50bXouZW5hYmxlZC4gTGV0IG5vdA0K
Pj4+PiBjb2RlIGFyb3VuZCBhY2Nlc3MgaXQgYXMgImlmIChhZGV2LT50bXouZW5hYmxlZCkiDQo+
Pj4+IGFzIHRoZSBvcmdhbml6YXRpb24gbWF5IGNoYW5nZS4gSW5zdGVhZC4uLg0KPj4+Pg0KPj4+
PiBSZWNydWl0ICJib29sIGFtZGdwdV9pc190bXooYWRldikiIHRvIHJldHVybg0KPj4+PiBleGFj
dGx5IHRoaXMgQm9vbGVhbiB2YWx1ZS4gVGhhdCBpcywgdGhpcyBmdW5jdGlvbg0KPj4+PiBpcyBu
b3cgYW4gYWNjZXNzb3Igb2YgYW4gYWxyZWFkeSBpbml0aWFsaXplZCBhbmQNCj4+Pj4gc2V0IGFk
ZXYgYW5kIGFkZXYtPnRtei4NCj4+Pj4NCj4+Pj4gQWRkICJ2b2lkIGFtZGdwdV90bXpfc2V0KGFk
ZXYpIiB0byBjaGVjayBhbmQgc2V0DQo+Pj4+IGFkZXYtPnRtei4qIGF0IGluaXRpYWxpemF0aW9u
IHRpbWUuIEFmdGVyIHdoaWNoDQo+Pj4+IG9uZSB1c2VzICJib29sIGFtZGdwdV9pc190bXooYWRl
dikiIHRvIHF1ZXJ5DQo+Pj4+IHdoZXRoZXIgYWRldiBzdXBwb3J0cyBUTVouDQo+Pj4NCj4+PiBB
Y3R1YWxseSBJIHdvdWxkIHJhdGhlciBjb21wbGV0ZWx5IHJlbW92ZSB0aGUgYW1kZ3B1X3Rtei5b
aGNdIGZpbGVzLiBTZWUNCj4+PiBUTVogaXMgYSBmZWF0dXJlIGFuZCBub3QgYSBoYXJkd2FyZSBi
bG9jay4NCj4+Pg0KPj4+IEFsbCB0aGF0IHN0dWZmIHNob3VsZCBwcm9iYWJseSBtb3ZlZCBpbnRv
IHRoZSBQU1AgaGFuZGxpbmcsIHNpbmNlIHRoZQ0KPj4+IGNvbnRyb2wgb2YgVE1aIGlzIGVuYWJs
ZWQgb3IgZGlzYWJsZWQgaW4gdGhlIGhhcmR3YXJlIGlzIHRoZXJlLg0KPj4NCj4+IEhpIENocmlz
dGlhbiwNCj4+DQo+PiBUaGFua3MgZm9yIHJldmlld2luZyB0aGlzLiBTdXJlLCB3ZSBjYW4gZG8g
dGhhdCBhcyB3ZWxsLCBzaG91bGQNCj4+IHRoZXJlIGJlIGNvbnNlbnN1cyBvbiBpdC4NCj4+DQo+
PiBJIGp1c3Qgc2F3IG15c2VsZiBuZWVkaW5nIHRvIGtub3cgaWYgdGhlIGRldmljZSBpcyBUTVog
KGFzIHdlbGwNCj4+IGFzIGlmIGEgYnVmZmVyIGlzIFRNWiBmb3Igd2hpY2ggSSB1c2VkIGFtZGdw
dV9ib19lbmNyeXB0ZWQoKSkNCj4+IGFuZCBzbyBpdCBiZWNhbWUgbmF0dXJhbCB0byB3cml0ZSAo
YWZ0ZXIgdGhpcyBwYXRjaCk6DQo+Pg0KPj4gaWYgKCFhbWRncHVfYm9fZW5jcnlwdGVkKGFibykg
fHwgIWFtZGdwdV9pc190bXooYWRldikpIHsNCj4+ICAgICAgICAgLyogbm9ybWFsIHByb2Nlc3Np
bmcgKi8NCj4+IH0gZWxzZSB7DQo+PiAgICAgICAgIC8qIFRNWiBwcm9jZXNzaW5nICovDQo+PiB9
DQo+Pg0KPj4gQlRXLCBzaG91bGQgd2UgcHJvY2VlZCBhcyB5b3Ugc3VnZ2VzdGVkLCBkbyB5b3Ug
c2VlDQo+PiB0aG9zZSBwcmltaXRpdmVzIGdvaW5nIGludG8gcHNwX3YxMl8wLmM/DQo+Pg0KPiAN
Cj4gVGhleSBhcmUgbm90IHBzcCB2ZXJzaW9uIHNwZWNpZmljLiAgdGhlIFBTUCBoYW5kbGVzIHRo
ZSBzZWN1cml0eSwgYnV0DQo+IGl0J3Mgbm90IHJlYWxseSBpbnZvbHZlZCBtdWNoIGZyb20gYSBk
cml2ZXIgcGVyc3BlY3RpdmU7IHRoZXkgYXJlDQo+IHJlYWxseSBtb3JlIG9mIGEgbWVtb3J5IG1h
bmFnZW1lbnQgdGhpbmcuICBJJ2Qgc3VnZ2VzdCBwdXR0aW5nIHRoZW0gaW4NCj4gc3RydWN0IGFt
ZGdwdV9nbWMuDQoNClRoYW5rcyBBbGV4LiBTbyB0aGVuIEknZCBnZXQgcmlkIG9mIHRoZSBmaWxl
cyBhbmQgY29uc29saWRhdGUNCmludG8gc3RydWN0IGFtZGdwdV9nbWMsIHdpdGggdGhlIGZpbGVz
IGRpc2FwcGVhcmluZyBhcyBDaHJpc3RpYW4NCnN1Z2dlc3RlZC4NCg0KUmVnYXJkcywNCkx1YmVu
DQoNCj4gDQo+IEFsZXgNCj4gDQo+PiBSZWdhcmRzLA0KPj4gTHViZW4NCj4+DQo+Pj4NCj4+PiBS
ZWdhcmRzLA0KPj4+IENocmlzdGlhbi4NCj4+Pg0KPj4+Pg0KPj4+PiBBbHNvLCByZW1vdmUgY2ly
Y3VsYXIgaGVhZGVyIGZpbGUgaW5jbHVkZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTHVi
ZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgIHwgIDUgKysrKysNCj4+Pj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgMiArLQ0KPj4+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouYyAgICB8IDIzICsrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dG16LmggICAgfCAgNyArKy0tLS0tDQo+Pj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmgNCj4+Pj4gaW5kZXggN2QxZTUyOGNjNzgzLi4yM2JkODFhNzY1NzAgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+Pj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+Pj4+IEBAIC0xMjQ5LDUgKzEy
NDksMTAgQEAgX25hbWUjI19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4+PiAgIHN0YXRp
YyBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBwbXVfYXR0cl8jI19uYW1lID0gX19BVFRSX1JPKF9u
YW1lKQ0KPj4+Pg0KPj4+PiArc3RhdGljIGlubGluZSBib29sIGFtZGdwdV9pc190bXooc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgcmV0dXJuIGFkZXYtPnRt
ei5lbmFibGVkOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICAgI2VuZGlmDQo+Pj4+DQo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4gaW5kZXggNGVl
ZTQwYjlkMGIwLi5mMTJiODE3NDgwYmIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4gQEAgLTEwNTgsNyArMTA1OCw3IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9jaGVja19hcmd1bWVudHMoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+Pj4+DQo+Pj4+ICAgICAgYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID0gYW1k
Z3B1X3Vjb2RlX2dldF9sb2FkX3R5cGUoYWRldiwgYW1kZ3B1X2Z3X2xvYWRfdHlwZSk7DQo+Pj4+
DQo+Pj4+IC0gICAgYWRldi0+dG16LmVuYWJsZWQgPSBhbWRncHVfaXNfdG16KGFkZXYpOw0KPj4+
PiArICAgIGFtZGdwdV90bXpfc2V0KGFkZXYpOw0KPj4+Pg0KPj4+PiAgICAgIHJldHVybiByZXQ7
DQo+Pj4+ICAgfQ0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Rtei5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5jDQo+
Pj4+IGluZGV4IDgyMzUyN2EwZmE0Ny4uNTE4YjlkMzM1NTUwIDEwMDY0NA0KPj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdG16LmMNCj4+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5jDQo+Pj4+IEBAIC0yNywyNiArMjcsMjUg
QEANCj4+Pj4gICAjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+Pj4+ICAgI2luY2x1ZGUgImFtZGdwdV90
bXouaCINCj4+Pj4NCj4+Pj4gLQ0KPj4+PiAgIC8qKg0KPj4+PiAtICogYW1kZ3B1X2lzX3RteiAt
IHZhbGlkYXRlIHRydXN0IG1lbW9yeSB6b25lDQo+Pj4+IC0gKg0KPj4+PiArICogYW1kZ3B1X3Rt
el9zZXQgLS0gY2hlY2sgYW5kIHNldCBpZiBhIGRldmljZSBzdXBwb3J0cyBUTVoNCj4+Pj4gICAg
KiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyDQo+Pj4+ICAgICoNCj4+Pj4gLSAqIFJldHVy
biB0cnVlIGlmIEBkZXYgc3VwcG9ydHMgdHJ1c3RlZCBtZW1vcnkgem9uZXMgKFRNWiksIGFuZCBy
ZXR1cm4gZmFsc2UgaWYNCj4+Pj4gLSAqIEBkZXYgZG9lcyBub3Qgc3VwcG9ydCBUTVouDQo+Pj4+
ICsgKiBDaGVjayBhbmQgc2V0IGlmIGFuIHRoZSBkZXZpY2UgQGFkZXYgc3VwcG9ydHMgVHJ1c3Rl
ZCBNZW1vcnkNCj4+Pj4gKyAqIFpvbmVzIChUTVopLg0KPj4+PiAgICAqLw0KPj4+PiAtYm9vbCBh
bWRncHVfaXNfdG16KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4+PiArdm9pZCBhbWRn
cHVfdG16X3NldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+Pj4gICB7DQo+Pj4+ICAg
ICAgaWYgKCFhbWRncHVfdG16KQ0KPj4+PiAtICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+
PiArICAgICAgICAgICAgcmV0dXJuOw0KPj4+Pg0KPj4+PiAtICAgIGlmIChhZGV2LT5hc2ljX3R5
cGUgPCBDSElQX1JBVkVOIHx8IGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKSB7DQo+
Pj4+IC0gICAgICAgICAgICBkZXZfd2FybihhZGV2LT5kZXYsICJkb2Vzbid0IHN1cHBvcnQgdHJ1
c3RlZCBtZW1vcnkgem9uZXMgKFRNWilcbiIpOw0KPj4+PiAtICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPj4+PiArICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPCBDSElQX1JBVkVOIHx8DQo+Pj4+
ICsgICAgICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKSB7DQo+Pj4+ICsgICAg
ICAgICAgICBkZXZfd2FybihhZGV2LT5kZXYsICJUcnVzdGVkIE1lbW9yeSBab25lIChUTVopIGZl
YXR1cmUgbm90IHN1cHBvcnRlZFxuIik7DQo+Pj4+ICsgICAgICAgICAgICByZXR1cm47DQo+Pj4+
ICAgICAgfQ0KPj4+Pg0KPj4+PiAtICAgIGRldl9pbmZvKGFkZXYtPmRldiwgIlRNWiBmZWF0dXJl
IGlzIGVuYWJsZWRcbiIpOw0KPj4+PiArICAgIGFkZXYtPnRtei5lbmFibGVkID0gdHJ1ZTsNCj4+
Pj4NCj4+Pj4gLSAgICByZXR1cm4gdHJ1ZTsNCj4+Pj4gKyAgICBkZXZfaW5mbyhhZGV2LT5kZXYs
ICJUcnVzdGVkIE1lbW9yeSBab25lIChUTVopIGZlYXR1cmUgc3VwcG9ydGVkIGFuZCBlbmFibGVk
XG4iKTsNCj4+Pj4gICB9DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdG16LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdG16
LmgNCj4+Pj4gaW5kZXggMjhlMDUxNzdmYjg5Li5hZDNhZDhjMDExZjkgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouaA0KPj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdG16LmgNCj4+Pj4gQEAgLTI0LDE2ICsy
NCwxMyBAQA0KPj4+PiAgICNpZm5kZWYgX19BTURHUFVfVE1aX0hfXw0KPj4+PiAgICNkZWZpbmUg
X19BTURHUFVfVE1aX0hfXw0KPj4+Pg0KPj4+PiAtI2luY2x1ZGUgImFtZGdwdS5oIg0KPj4+PiAt
DQo+Pj4+ICAgLyoNCj4+Pj4gLSAqIFRydXN0IG1lbW9yeSB6b25lIHN0dWZmDQo+Pj4+ICsgKiBU
cnVzdGVkIE1lbW9yeSBab25lIHBhcnRpY3VsYXJzDQo+Pj4+ICAgICovDQo+Pj4+ICAgc3RydWN0
IGFtZGdwdV90bXogew0KPj4+PiAgICAgIGJvb2wgICAgZW5hYmxlZDsNCj4+Pj4gICB9Ow0KPj4+
Pg0KPj4+PiAtDQo+Pj4+IC1leHRlcm4gYm9vbCBhbWRncHVfaXNfdG16KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KTsNCj4+Pj4gK2V4dGVybiB2b2lkIGFtZGdwdV90bXpfc2V0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsNCj4+Pj4NCj4+Pj4gICAjZW5kaWYNCj4+Pg0KPj4NCj4+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdA0KPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
