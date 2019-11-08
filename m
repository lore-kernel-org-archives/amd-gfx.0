Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9DFA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 09:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14CA214DA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 09:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14CA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913E66F8EC;
	Fri,  8 Nov 2019 09:42:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B4A6F8EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 09:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N59rPcGYKehV9biF+VqxC+sm3cQUmgxEtnRcVpAPwxckmdcCvJvL31T1HxFg6DvHbTUh8SbXDRpZij1cqpqhqCcHfKUIyVp4X4ZIHqBGOTFPlpjHxV9uKA+ibEH5vw8qGhZkOxYgd2SUWKwGcY0IqsIXO7J6LdSVb2WFW886Iaeks944KBQIy0+gCqbi4iawNIuDwVzoOP+RA3bkIrYaD3feTTKT+0k12iGFzW9hhEtXMMDzb/PLNnz/5fTOh+1cGaCdBIkbzSPvpDqwch64LgaZE0uC+ZOzLvG6gEftrtICXypCj23qQFoFSzFhuQ+l8ah2lI941bAQscJo6+3SQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14/u0Jv98ryj7CajIqJud24W6AHtPDXVez1f6Fcb0II=;
 b=d4mPufGp3ks1gqbKtRGt1D7q3/4Z+WWOkaLJ8AwoW253PJgLzl7QMP+faNaQf7WkUvceD/VFg26bw/mcgrdxnTwrgMKCX5KSKxaeUWuMoyyNMIAZzl7M9qPTbrxvl5jkhk6/CuMzYP6jwOsUD6rlo4GmvJL/szp+P/yvpSNuTBdZatJS3+ReckTCOzai8XqpWB0K7ZF7MD2zHbPigxB6+/kZJqVvH5bcmtoZePwY2LXlFIrwlgD3eIfl6l/ikmRRIjCQGE0gEdP7T/yXHpAPtqjJDpVw3jnkaAEsfDSrIM6bTSsKBPzyI2ymyQ6SMCqhxR9OHFJkT5ljwe6IVQf+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2390.namprd12.prod.outlook.com (52.132.141.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 8 Nov 2019 09:42:32 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.028; Fri, 8 Nov 2019
 09:42:32 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Topic: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Index: AQHVlVW9lxWirD8xeEyV09j5nQhNc6d/kjUAgAD+17CAAGgEQIAABCMAgAAI80CAAADWAA==
Date: Fri, 8 Nov 2019 09:42:32 +0000
Message-ID: <70c2c1cc-40b8-30da-7aee-f59fbc4d0d42@amd.com>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
 <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <MN2PR12MB2975E26D8A8352863BA01FCA8F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <c01acb29-72ce-a109-3ca5-166706327d61@amd.com>
 <MN2PR12MB29755CFCE09CEC0D9EB999D18F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB29755CFCE09CEC0D9EB999D18F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM4PR0501CA0062.eurprd05.prod.outlook.com
 (2603:10a6:200:68::30) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a58444c-cc5b-446e-2ea3-08d7642ffa5b
x-ms-traffictypediagnostic: DM5PR12MB2390:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2390ABA36488A0795A05F910837B0@DM5PR12MB2390.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(13464003)(186003)(25786009)(446003)(14444005)(86362001)(256004)(36756003)(66946007)(2616005)(7736002)(305945005)(8936002)(71190400001)(71200400001)(229853002)(6486002)(2501003)(14454004)(6436002)(46003)(5660300002)(99286004)(478600001)(11346002)(486006)(476003)(31696002)(2906002)(81156014)(102836004)(53546011)(6506007)(316002)(66446008)(64756008)(66556008)(386003)(66476007)(6512007)(31686004)(6306002)(65956001)(81166006)(65806001)(66574012)(52116002)(6246003)(76176011)(966005)(8676002)(6116002)(110136005)(58126008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2390;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLj4WJsUYLgTJIJnfI9ileNCuEnZPcmfrgWEwsnH8iYHMf7Wa0ZUlrnQ7W3pmuVhYlZLFh7o6wMBd25/vbPSlmMnBKM1CC9v/GEw4HVJM44WNTa8+tK+xtEKkNCLNN9dO2v+PKjWC29fXsHzCNkyacZuJNFuffVOYIvLCkw09Yv5RrQnev33ayM4oPOEMDxxQfhgxnq9pKwrETIT/PyO/LD+OFWe/1Fp2R6OGcIxOtxZ/gz0uZXT8ivNOrXhJft7RQv1O+ZMUoPJNyS059I/AKlWsOHx5pzci13GYEgcS3hmA3Om7zdWUrcE45y99DSb8s+v3QY2f0y6JuqFYDJ1ybC6pbR+K0zzKG7xo120WCQTZ2lHLRt6zsncE76BGohKNhSyA/l7kRgIoxwxHHnRiiH9kj9/LkJ8vVxsCML/nN52Emocomkpv7xAgMaqmxD971H9vAtUiTw7xGyQezIRvJ3v1FnPHfyc1/ualGclpJY=
Content-ID: <94E1799E5B62AC409C406200C90A5E82@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a58444c-cc5b-446e-2ea3-08d7642ffa5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 09:42:32.5023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+vgm4r070qw5WrFcbmZK9yzsuBlTO7LIPHwSguDSsR928jJRazXs32BQPH989pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2390
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14/u0Jv98ryj7CajIqJud24W6AHtPDXVez1f6Fcb0II=;
 b=hbMDg5v32BTdynSFPe4KaEHd8CTre+fzNjaEhL/7ls3OSv2cNB+ZRuz+PTNWXRrkL6nmae//PcqBW/XaujzIxv7t2la4gxzHg8LMRbeMjZ3MRAJnBcIELMwkry6heqU/OgFqsJRMAEviO5JULAdYKjWcZnjUZjuMuMjYMUv6zwc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Message-ID: <20191108094232.VIDYwEajeUYQq5K9y6I_oumOciEcJIIZKMdsFwS8s8Q@z>

QW0gMDguMTEuMTkgdW0gMTA6Mzkgc2NocmllYiBEZW5nLCBFbWlseToNCj4gU29ycnksIHBsZWFz
ZSB0YWtlIHlvdXIgdGltZS4NCg0KSGF2ZSB5b3Ugc2VlbiBteSBvdGhlciByZXNwb25zZSBhIGJp
dCBiZWxvdz8NCg0KSSBjYW4ndCBmb2xsb3cgaG93IGl0IHdvdWxkIGJlIHBvc3NpYmxlIGZvciBq
b2ItPnNfZmVuY2UgdG8gYmUgTlVMTCANCndpdGhvdXQgdGhlIGpvYiBhbHNvIGJlaW5nIGZyZWVk
Lg0KDQpTbyBpdCBsb29rcyBsaWtlIHRoaXMgcGF0Y2ggaXMganVzdCBwYXBlcmluZyBvdmVyIHNv
bWUgYmlnZ2VyIGlzc3Vlcy4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBCZXN0IHdp
c2hlcw0KPiBFbWlseSBEZW5nDQo+DQo+DQo+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgOCwgMjAxOSA1OjA4IFBNDQo+PiBUbzogRGVuZywg
RW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggdGhlIG51bGwgcG9pbnRl
ciBpc3N1ZSBmb3IgdGRyDQo+Pg0KPj4gQW0gMDguMTEuMTkgdW0gMDk6NTIgc2NocmllYiBEZW5n
LCBFbWlseToNCj4+PiBQaW5nLi4uLi4NCj4+IFlvdSBuZWVkIHRvIGdpdmUgbWUgYXQgbGVhc3Qg
ZW5vdWdoIHRpbWUgdG8gd2FrZSB1cCA6KQ0KPj4NCj4+Pg0KPj4+IEJlc3Qgd2lzaGVzDQo+Pj4g
RW1pbHkgRGVuZw0KPj4+DQo+Pj4NCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPiBPbiBCZWhhbGYgT2YNCj4+Pj4gRGVuZywgRW1pbHkNCj4+Pj4gU2VudDogRnJpZGF5LCBO
b3ZlbWJlciA4LCAyMDE5IDEwOjU2IEFNDQo+Pj4+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLQ0KPj4+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+Pj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB0aGUgbnVsbCBw
b2ludGVyIGlzc3VlIGZvciB0ZHINCj4+Pj4NCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+Pj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4NCj4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA3LCAyMDE5IDc6Mjgg
UE0NCj4+Pj4+IFRvOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IEZpeCB0aGUgbnVsbCBwb2ludGVyIGlzc3VlIGZvciB0ZHINCj4+Pj4+DQo+Pj4+PiBBbSAw
Ny4xMS4xOSB1bSAxMToyNSBzY2hyaWViIEVtaWx5IERlbmc6DQo+Pj4+Pj4gV2hlbiB0aGUgam9i
IGlzIGFscmVhZHkgc2lnbmFsZWQsIHRoZSBzX2ZlbmNlIGlzIGZyZWVkLiBUaGVuIGl0DQo+Pj4+
Pj4gd2lsbCBoYXMgbnVsbCBwb2ludGVyIGluIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIuDQo+
Pj4+PiBOQUssIHRoZSBzX2ZlbmNlIGlzIG9ubHkgc2V0IHRvIE5VTEwgd2hlbiB0aGUgam9iIGlz
IGRlc3Ryb3llZC4gU2VlDQo+Pj4+PiBkcm1fc2NoZWRfam9iX2NsZWFudXAoKS4NCj4+Pj4gSSBr
bm93IGl0IGlzIHNldCB0byBOVUxMIGluIGRybV9zY2hlZF9qb2JfY2xlYW51cC4gQnV0IGluIG9u
ZSBjYXNlLA0KPj4+PiB3aGVuIGl0IGVudGVyIGludG8gdGhlIGFtZGdwdV9kZXZpY2VfZ3B1X3Jl
Y292ZXIsIGl0IGFscmVhZHkgaW4NCj4+Pj4gZHJtX3NjaGVkX2pvYl9jbGVhbnVwLCBhbmQgYXQg
dGhpcyB0aW1lLCBpdCB3aWxsIGdvIHRvIGZyZWUgam9iLiBCdXQNCj4+Pj4gdGhlIGFtZGdwdV9k
ZXZpY2VfZ3B1X3JlY292ZXIgc29tZXRpbWVzIGlzIGZhc3Rlci4gQXQgdGhhdCB0aW1lLCBqb2IN
Cj4+Pj4gaXMgbm90IGZyZWVkLCBidXQgc19mZW5jZSBpcyBhbHJlYWR5IE5VTEwuDQo+PiBObywg
dGhhdCBjYXNlIGNhbid0IGhhcHBlbi4gU2VlIGhlcmU6DQo+Pg0KPj4+ICDCoMKgwqDCoMKgwqDC
oCBkcm1fc2NoZWRfam9iX2NsZWFudXAoc19qb2IpOw0KPj4+DQo+Pj4gIMKgwqDCoMKgwqDCoMKg
IGFtZGdwdV9yaW5nX3ByaW9yaXR5X3B1dChyaW5nLCBzX2pvYi0+c19wcmlvcml0eSk7DQo+Pj4g
IMKgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV9wdXQoam9iLT5mZW5jZSk7DQo+Pj4gIMKgwqDCoMKg
wqDCoMKgIGFtZGdwdV9zeW5jX2ZyZWUoJmpvYi0+c3luYyk7DQo+Pj4gIMKgwqDCoMKgwqDCoMKg
IGFtZGdwdV9zeW5jX2ZyZWUoJmpvYi0+c2NoZWRfc3luYyk7DQo+Pj4gIMKgwqDCoMKgwqDCoMKg
IGtmcmVlKGpvYik7DQo+PiBUaGUgam9iIGl0c2VsZiBpcyBmcmVlZCB1cCBkaXJlY3RseSBhZnRl
ciBmcmVlaW5nIHRoZSByZWZlcmVuY2UgdG8gdGhlIHNfZmVuY2UuDQo+Pg0KPj4gU28geW91IGFy
ZSBqdXN0IHBhcGVyaW5nIG92ZXIgYSBtdWNoIGJpZ2dlciBwcm9ibGVtIGhlcmUuIFRoaXMgcGF0
Y2ggaXMgYQ0KPj4gY2xlYXIgTkFLLg0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBDaHJpc3RpYW4uDQo+
Pg0KPj4+Pj4gV2hlbiB5b3Ugc2VlIGEgam9iIHdpdGhvdXQgYW4gc19mZW5jZSB0aGVuIHRoYXQg
bWVhbnMgdGhlIHByb2JsZW0gaXMNCj4+Pj4+IHNvbWV3aGVyZSBlbHNlLg0KPj4+Pj4NCj4+Pj4+
IFJlZ2FyZHMsDQo+Pj4+PiBDaHJpc3RpYW4uDQo+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgIDIgKy0NCj4+Pj4+
PiAgICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgICAgIHwgMTEgKysr
KysrLS0tLS0NCj4+Pj4+PiAgICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4+PiBpbmRleCBlNmNlOTQ5Li41YThmMDhlIDEw
MDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPj4+Pj4+IEBAIC00MDc1LDcgKzQwNzUsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVf
cmVjb3ZlcihzdHJ1Y3QNCj4+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4+Pj4gICAgIAkg
Kg0KPj4+Pj4+ICAgICAJICogam9iLT5iYXNlIGhvbGRzIGEgcmVmZXJlbmNlIHRvIHBhcmVudCBm
ZW5jZQ0KPj4+Pj4+ICAgICAJICovDQo+Pj4+Pj4gLQlpZiAoam9iICYmIGpvYi0+YmFzZS5zX2Zl
bmNlLT5wYXJlbnQgJiYNCj4+Pj4+PiArCWlmIChqb2IgJiYgam9iLT5iYXNlLnNfZmVuY2UgJiYg
am9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCAmJg0KPj4+Pj4+ICAgICAJICAgIGRtYV9mZW5jZV9p
c19zaWduYWxlZChqb2ItPmJhc2Uuc19mZW5jZS0+cGFyZW50KSkNCj4+Pj4+PiAgICAgCQlqb2Jf
c2lnbmFsZWQgPSB0cnVlOw0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX21haW4uYw0KPj4+Pj4+IGluZGV4IDMxODA5Y2EuLjU2Y2MxMGUgMTAwNjQ0
DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4+
Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPj4+Pj4+
IEBAIC0zMzQsOCArMzM0LDggQEAgdm9pZCBkcm1fc2NoZWRfaW5jcmVhc2Vfa2FybWEoc3RydWN0
DQo+Pj4+PiBkcm1fc2NoZWRfam9iDQo+Pj4+Pj4gKmJhZCkNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAJ
CQlzcGluX2xvY2soJnJxLT5sb2NrKTsNCj4+Pj4+PiAgICAgCQkJbGlzdF9mb3JfZWFjaF9lbnRy
eV9zYWZlKGVudGl0eSwgdG1wLCAmcnEtPmVudGl0aWVzLA0KPj4+Pj4gbGlzdCkgew0KPj4+Pj4+
IC0JCQkJaWYgKGJhZC0+c19mZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQgPT0NCj4+Pj4+PiAtCQkJ
CSAgICBlbnRpdHktPmZlbmNlX2NvbnRleHQpIHsNCj4+Pj4+PiArCQkJCWlmIChiYWQtPnNfZmVu
Y2UgJiYgKGJhZC0+c19mZW5jZS0NCj4+Pj4+PiBzY2hlZHVsZWQuY29udGV4dCA9PQ0KPj4+Pj4+
ICsJCQkJICAgIGVudGl0eS0+ZmVuY2VfY29udGV4dCkpIHsNCj4+Pj4+PiAgICAgCQkJCQlpZiAo
YXRvbWljX3JlYWQoJmJhZC0+a2FybWEpID4NCj4+Pj4+PiAgICAgCQkJCQkgICAgYmFkLT5zY2hl
ZC0+aGFuZ19saW1pdCkNCj4+Pj4+PiAgICAgCQkJCQkJaWYgKGVudGl0eS0+Z3VpbHR5KQ0KPj4+
Pj4+IEBAIC0zNzYsNyArMzc2LDcgQEAgdm9pZCBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dw
dV9zY2hlZHVsZXINCj4+Pj4+ICpzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCkNCj4+
Pj4+PiAgICAgCSAqIFRoaXMgaXRlcmF0aW9uIGlzIHRocmVhZCBzYWZlIGFzIHNjaGVkIHRocmVh
ZCBpcyBzdG9wcGVkLg0KPj4+Pj4+ICAgICAJICovDQo+Pj4+Pj4gICAgIAlsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmVfcmV2ZXJzZShzX2pvYiwgdG1wLCAmc2NoZWQtDQo+Pj4+Pj4gcmluZ19taXJy
b3JfbGlzdCwgbm9kZSkgew0KPj4+Pj4+IC0JCWlmIChzX2pvYi0+c19mZW5jZS0+cGFyZW50ICYm
DQo+Pj4+Pj4gKwkJaWYgKHNfam9iLT5zX2ZlbmNlICYmIHNfam9iLT5zX2ZlbmNlLT5wYXJlbnQg
JiYNCj4+Pj4+PiAgICAgCQkgICAgZG1hX2ZlbmNlX3JlbW92ZV9jYWxsYmFjayhzX2pvYi0+c19m
ZW5jZS0+cGFyZW50LA0KPj4+Pj4+ICAgICAJCQkJCSAgICAgICZzX2pvYi0+Y2IpKSB7DQo+Pj4+
Pj4gICAgIAkJCWF0b21pY19kZWMoJnNjaGVkLT5od19ycV9jb3VudCk7IEBAIC0zOTUsNw0KPj4+
PiArMzk1LDggQEAgdm9pZA0KPj4+Pj4+IGRybV9zY2hlZF9zdG9wKHN0cnVjdCBkcm1fZ3B1X3Nj
aGVkdWxlcg0KPj4+Pj4gKnNjaGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQ0KPj4+Pj4+
ICAgICAJCQkgKg0KPj4+Pj4+ICAgICAJCQkgKiBKb2IgaXMgc3RpbGwgYWxpdmUgc28gZmVuY2Ug
cmVmY291bnQgYXQgbGVhc3QgMQ0KPj4+Pj4+ICAgICAJCQkgKi8NCj4+Pj4+PiAtCQkJZG1hX2Zl
bmNlX3dhaXQoJnNfam9iLT5zX2ZlbmNlLT5maW5pc2hlZCwgZmFsc2UpOw0KPj4+Pj4+ICsJCQlp
ZiAoc19qb2ItPnNfZmVuY2UpDQo+Pj4+Pj4gKwkJCQlkbWFfZmVuY2Vfd2FpdCgmc19qb2ItPnNf
ZmVuY2UtPmZpbmlzaGVkLA0KPj4+Pj4gZmFsc2UpOw0KPj4+Pj4+ICAgICAJCQkvKg0KPj4+Pj4+
ICAgICAJCQkgKiBXZSBtdXN0IGtlZXAgYmFkIGpvYiBhbGl2ZSBmb3IgbGF0ZXIgdXNlIGR1cmlu
ZyBAQA0KPj4+Pj4gLTQzOCw3DQo+Pj4+Pj4gKzQzOSw3IEBAIHZvaWQgZHJtX3NjaGVkX3N0YXJ0
KHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQsDQo+Pj4+Pj4gK2Jvb2wNCj4+Pj4+IGZ1
bGxfcmVjb3ZlcnkpDQo+Pj4+Pj4gICAgIAkgKiBHUFUgcmVjb3ZlcnMgY2FuJ3QgcnVuIGluIHBh
cmFsbGVsLg0KPj4+Pj4+ICAgICAJICovDQo+Pj4+Pj4gICAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5
X3NhZmUoc19qb2IsIHRtcCwgJnNjaGVkLT5yaW5nX21pcnJvcl9saXN0LA0KPj4+Pj4+IG5vZGUp
DQo+Pj4+PiB7DQo+Pj4+Pj4gLQkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBzX2pvYi0+c19m
ZW5jZS0+cGFyZW50Ow0KPj4+Pj4+ICsJCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gc19qb2It
PnNfZmVuY2UgPyBzX2pvYi0+c19mZW5jZS0NCj4+Pj4+PiBwYXJlbnQgOg0KPj4+Pj4+ICtOVUxM
Ow0KPj4+Pj4+DQo+Pj4+Pj4gICAgIAkJYXRvbWljX2luYygmc2NoZWQtPmh3X3JxX2NvdW50KTsN
Cj4+Pj4+Pg0KPj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
