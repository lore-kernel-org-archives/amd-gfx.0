Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15EEC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 04:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9FA10E263;
	Wed, 19 Oct 2022 04:50:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC69210E263
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 04:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcU1s/1rWNmFOBbCqMrPE/Zr7F6+odh0NcZIR2v3AJ6c+4J7c8If+j3QqOAOA29RPofc2hxrsbSH8JyYXoLC1o+Kf8xqcfVBwLccvYFeMn+YnQWNShY6irNL+wSqJG7CE7wqIlGJaVDiOLE0+bwVev7hUVhsq+DYKW1HVtL5cqpmBjZHdovnZl8xQJDBUfsa6UD3srAl7vQUVHMbGg1MCVUoql+zESUnrgGa1Wv5/DlWVE07tmy0DsCN2XVDmoyuTiycc8I9o8zO1SAM6JWny6egQvWwEIzOOabz4jAnpgtmRCskY/52G6OntkBI0OwDc7kjgsYmuBczii4HYACCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJwBrrf7v3cf3HMHJG9idB3v/tXyQef+QDCJZH2E9pw=;
 b=n2ZBlpHNaXnTXCWIKFi9a+okY6NIp159PRw9JhgBq8eZ48F6Ik0ZCqPDOeOWaiXPzvIr6fEps5lTBhHGjztJgnNUcexL69dNYWIZpMGx2KeydR0Dt/qxygaXoOd5o9l/WgIOpkDij++lAWwL4XIsHgygAe3pryTPPksoTO1SUnxMGsFEkDTBKMFLgAukdtUhDeBrAbtrF32NQTUlJQFemHH0sBBq/6jHg7Z/wp+aieaNGzAJ0+XVyCPoRqvuKkJVCYPU3V+jU2ECm3T4OtLC9zq/g2LERpMFMX6JpNS/DFxX0HpC/4TahV1wnvI70sCfPvhqKCmiJ7/f6s4fotfs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJwBrrf7v3cf3HMHJG9idB3v/tXyQef+QDCJZH2E9pw=;
 b=H4bi8DSSWJUHxBay7XePlrAkqOgfxopX3GnuMmwcKvOLbcXmoIWtxBPf8cOfk5hBeQ0K2GPprc90jdX42O0HgwHjGw9KXMnO07rvfumiWvRw5hh0N7D4l36fRt7YeMJEp0tYWbiTGbyKQ1l5mCSJjnb2WUGXKPSXsdOyVQZjXeQ=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 CH0PR12MB5204.namprd12.prod.outlook.com (2603:10b6:610:bb::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Wed, 19 Oct 2022 04:50:19 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 04:50:19 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Thread-Topic: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Thread-Index: AQHY421FXC8+id4OoUiwRisi6tOO3q4VFb2AgAAPslA=
Date: Wed, 19 Oct 2022 04:50:19 +0000
Message-ID: <DM6PR12MB30354D8AA223C65454450E7FE52B9@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20221019034519.1558366-1-YuBiao.Wang@amd.com>
 <555e8453-d609-a78e-36a8-dd52b63332ac@amd.com>
In-Reply-To: <555e8453-d609-a78e-36a8-dd52b63332ac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|CH0PR12MB5204:EE_
x-ms-office365-filtering-correlation-id: 46e021d6-91f9-45ba-2010-08dab18d6c78
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZJhjOdJAZ3qF+P7GSDnv6R4/K5sBed+yaMKgCjXeL7EuL0LEAs1t27+3NvBX0xBkxe0W/kb7VjVx2odS0MdPOmEwxJF8BJKbXuiaE9hhNkXI1hyxxXCdilDyVailptzl4EM7XMS7umUq2rlWAIXFWN5bz+Zf2qk42Nn9QdTd/l766MslRKw2nPqfmKQ/vMbZWiHf3T7m9Xgx5adz4TuIQqpNAHkbYTyp41ga9Z7fTtwoJXdwIuO7JLz70p9ty1zHQWWkEWbS4bm08h30UeG1OnE4rgqGwWfZHXI+bgKxMewymbSxUFc2G2ORG6Uan2z4rJY07LTNCWD7wiaaVeqt8LQvKeD+TyJK0PUbQlkzEij4nW7lJ2jG6E5D+d2heJZB5DoLIrDwUMbpB390FH/Hodvd0jeV5aec2K6ZRSdXWdmzgp+eIfgefY755xxiQAksgyD8W0c3dZDOcvtLUMxX8UXAlSIl5Qm8UQm982K3DYBFQLk1cgXO6dTYPCKEzABhky2zVsI7FVXxVWzB5jsOmGx/momNnkM40ICXEFt2NDPwwgrt3GaHbp1xt0lkmNazKbk4lXPoKysTUAr+AEFl3fFRuEImsE7bQsfdIpM/H/dhVJ9lw+68e2FrCY2yvbnlyKIHg+qMkPU05sOUlTE8ns5AEMppOTD31FalchBq5KTKIwBJZCDnPcdI7soDZulPB5NxlKuzkimq4cI797cHv+8eHGHpLQciRIwzLAwzAXNrnMRkNINI5iHuA5/66Wz1f/Agj1jvOAfKc55cPlOxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(7696005)(33656002)(6506007)(2906002)(8936002)(4001150100001)(53546011)(5660300002)(52536014)(86362001)(186003)(9686003)(41300700001)(26005)(38070700005)(478600001)(4326008)(76116006)(66946007)(66446008)(64756008)(71200400001)(8676002)(55016003)(83380400001)(66476007)(66556008)(38100700002)(54906003)(316002)(110136005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzY5aUJhMkt5QUF3bkhxWVR0WXZDSHQvMzZDWEc5L1FVY1NJQXo5c21OSFY5?=
 =?utf-8?B?VEdxZVdQejVzU291b1FESHE1ZnE3SGtSYzd3WnEvU0dzMEZpYTBKYUxlTXRL?=
 =?utf-8?B?eG94ajVkL0NIU2swMTliV3hLakVxZFEzZmNwUTZIc1FjeFM2UFlpY0VYQTNi?=
 =?utf-8?B?ZUlKZzg2YmplTTUyaFh1WTlGOUtoRnZvOXorVWh0MFltdHh2YXhrTzBqYnZH?=
 =?utf-8?B?OEFPai9qUnZaZ3JDRDFRWmM0SWQ0RE1ZVkFOVURYTVhCNEh3RG9qUUhnU250?=
 =?utf-8?B?ckhDMWdWTnhNQ0szZndhYlM0eU5oOU5pbndZMnowRnN1T0JRc0d6eHUvU0hN?=
 =?utf-8?B?bEVWbVNJRXpJeHFWY25KZEgrc1NIbEx6UjFsZUxlTklXVzlWRFdFa3dBK2VC?=
 =?utf-8?B?Nlpzb3lkUlhxSEQ5eEJXTWNSNU9QKzRLYi83YlgzQWZkZ1A3UEVZeXpncW5Y?=
 =?utf-8?B?OUF4dzc3dTAwRkczWkNWaWpxanB0YjdVL3ZlVWk5em9QYnBDSDREVDF4RHBI?=
 =?utf-8?B?V3MwVkRyNVZGeDR2R0dSZGRTYytSOUdGbCs5bFMxTWdRaGpzb0kxUmVpMXBO?=
 =?utf-8?B?UjNFd09sYUtYbmdnYTlNM1ZjMzlaNEJ1bStVdUNreHRhUmFSbGhPTmxiUThq?=
 =?utf-8?B?WHp5NFBDV1QwUVNCUUVzb0NleDA3bm9LeDVlZEE3dy9XdGVVajViUkQ5dEY0?=
 =?utf-8?B?MWVRL2RrR3BtZ0hvaDFlMCtkblprRWxGWGFtT3ozMW5heCtMNnZSbVdVV3F4?=
 =?utf-8?B?MGd5K2VWWXJWNXR3UVU0dFlPRXRJMGZlYnZlaUd1WVdoU0dHWVBsVVFQNU1B?=
 =?utf-8?B?cEFNVEVwQWhmRzdzWHptZHVyOTVyblUvN3RRaVhibjVERTlwU0p2TDZ3WWFN?=
 =?utf-8?B?YkxNNFRoRGlsZGRjOEJHM3RpbVQxR0JVS0w0RXdTMjRtVHFnTklkVytpbVJW?=
 =?utf-8?B?YTdIVGFBbEw4U2ltTTdzclNDcnlQdUJQMGFMRHNKMzhwMnovWTEwTXJVS2JW?=
 =?utf-8?B?US9TSG03Zm1QRkcwb1d0di85eDQ1RnA3dXh4eE1vSTVxMVNrUnhVZzY4V2hs?=
 =?utf-8?B?Ylp3Z2FrMHpIcnRvRW1MdWFKbHhyNmtRcVdPMmI5QWZ6N0I0YTdUWTF5QldW?=
 =?utf-8?B?b1VHNlVMTFJTVlQrejVYTXdwT1cxSUtVOHFwTzJKTkM4UFlsS2VkSlhDNEhO?=
 =?utf-8?B?NmdOYUJwS3hleHZoUTJ2dUxrenZmODhKTU5VTnZZdXpWZWU5cEx5cy9KV3lk?=
 =?utf-8?B?enBjWmNmNkY3U2JHc2VQUnZqMmtlM3hqWCszMW81d1dveG9vNmM3aGdoZ2JF?=
 =?utf-8?B?NHVRK0ZxemFuRVdyWmFTOWlrcDhaSGpiZnR5V3B4MVUvcVREOGQ0RzJmQzhV?=
 =?utf-8?B?T3d5WFNqcnJQME1lK05nTUhLaEl4aGd0SmY4WGdWNFFBcXhBWmJUMXVlZ0pF?=
 =?utf-8?B?U1hDRE1UYkVtbm1GUTdmelRpRHBxNDZTd0h6L1ZHMTZQdk55TjdkUDBycnJP?=
 =?utf-8?B?OUt3WFhHeEJLanJMeE1kRGRBN3ZkNHVSWm1GUFdSRmRvTnNNVVNlK2J5SVE0?=
 =?utf-8?B?Z01BcDFvWXBwcVpyY1pibU52ZGNNaFJuSFpTdnBnRUgxdDVTVEpjT1lkUVl6?=
 =?utf-8?B?VWE5OGwzU3pYNGg0NUZtUCtRMEV2bURFS1hoYTYyOWNvTU5vWHJSd041ZXVQ?=
 =?utf-8?B?SU1Ddy94a2RGS1kvbWhDamhsTkEzbUk2M2FRRHZjQVJuWW4zd0xDTUlTZ2Fk?=
 =?utf-8?B?T21MbHlwMklQcFoyZmRwU1BYSkhiM1lJTUVvU1Y3cHpqRmhGN3JyZEtnVWpw?=
 =?utf-8?B?TzFJRDlwQzVsMHpmYnBTbkU0VGFIeEc1bXVUZUNvVy9SSUdQYWN4UkMwcmkw?=
 =?utf-8?B?SHRyc05WVG5IYVBUSktLNWhSS2tOMmt2WmEvbWRad0JMQXN5TVNlc04zejNt?=
 =?utf-8?B?ZlhoRDl6RDRTWjBZY09pR0JBTXhsQ1luRGFmR0VVZVpQaFNHSGtaK0xNSkpi?=
 =?utf-8?B?WWNpOW1jaWFCV1dvOThNS0gzWGI2NXFyc0c0WkNFcTZORzBQeWk4Y1ZKVWV2?=
 =?utf-8?B?S2M5SEF3SnV3VDMyVi8rY1QvSnJDZ0xrd1d3MVVSd3pDaTlkWlkvOENSWXIr?=
 =?utf-8?Q?BUfT2dkioOmyp0vj8Sh6lbAGO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e021d6-91f9-45ba-2010-08dab18d6c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 04:50:19.4507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2KuSbcdkVHdbQp4/7KPgm2Fr+Y8EQ9/VuKFw0CRkjSZJFlrPTc6oxXrwn8eIhsaYew0Qs0kUwz1ezm0rEmrJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5204
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTHViZW4sDQoNCkFzIGZhciBhcyBJIGtub3cgb2YgdGhpcyBpcyBvbmx5IGZvciBnYyAxMS4w
LjMuIE1lcyBzZWxmIHRlc3QgaXMgYWxzbyBza2lwcGVkIGluIG1lcyBsYXRlIGluaXQgZm9yIHRo
aXMgdmVyc2lvbiBvZiBJUC4NCg0KQmVzdCBSZWdhcmRzLA0KWXViaWFvIFdhbmcNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBh
bWQuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxOSwgMjAyMiAxMTo1MyBBTQ0KVG86
IFdhbmcsIFl1QmlhbyA8WXVCaWFvLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpDYzogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQu
Y29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFj
ZS5DaGVuQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWGlh
bywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVp
ZmVpLlh1QGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHNraXAgbWVzIHNlbGYgdGVzdCBm
b3IgZ2MgMTEuMC4zIGluIHJlY292ZXINCg0KT24gMjAyMi0xMC0xOCAyMzo0NSwgWXVCaWFvIFdh
bmcgd3JvdGU6DQo+IFRlbXBvcmFyeSBkaXNhYmxlIG1lcyBzZWxmIHRlc2V0IGZvciBnYyAxMS4w
LjMgZHVyaW5nIGdwdV9yZWNvdmVyeS4NCj4gDQoNCklzIHRoaXMgInRlbXBvcmFyeSIgYXMgaW4g
IndlJ2xsIHJldmVydCB0aGlzIGNvbW1pdCBsYXRlciIsIG9yIGlzIGl0ICJ0ZW1wb3JhcnkiIGFz
IGluIHRoZSBjb2RlIGV4ZWN1dGlvbiBpdHNlbGY/DQoNCj4gU2lnbmVkLW9mZi1ieTogWXVCaWFv
IFdhbmcgPFl1Qmlhby5XYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBlMDQ0NWU4Y2MzNDIuLjViODM2MjcyNzIy
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiBAQCAtNTM4MSw3ICs1MzgxLDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAJCQlkcm1fc2NoZWRfc3RhcnQoJnJpbmctPnNj
aGVkLCAhdG1wX2FkZXYtPmFzaWNfcmVzZXRfcmVzKTsNCj4gIAkJfQ0KPiAgDQo+IC0JCWlmIChh
ZGV2LT5lbmFibGVfbWVzKQ0KPiArCQlpZiAoYWRldi0+ZW5hYmxlX21lcyAmJiBhZGV2LT5pcF92
ZXJzaW9uc1tHQ19IV0lQXVswXSAhPSANCj4gK0lQX1ZFUlNJT04oMTEsIDAsIDMpKQ0KPiAgCQkJ
YW1kZ3B1X21lc19zZWxmX3Rlc3QodG1wX2FkZXYpOw0KDQpJcyB0aGlzIGp1c3QgZm9yIHRoaXMg
dmVyc2lvbiBvZiB0aGUgSVAgb3IgdGhpcyBhbmQgYW55IG5ld2VyIHZlcnNpb25zPw0KDQpSZWdh
cmRzLA0KTHViZW4NCg0KPiAgDQo+ICAJCWlmICghZHJtX2Rydl91c2VzX2F0b21pY19tb2Rlc2V0
KGFkZXZfdG9fZHJtKHRtcF9hZGV2KSkgJiYgDQo+ICFqb2Jfc2lnbmFsZWQpIHsNCg==
