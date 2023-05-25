Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E74C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 02:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BE910E6AC;
	Thu, 25 May 2023 02:51:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5942A10E6AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 02:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYMsQH9nn2uKz0wag1igBv9EZSHSNCOhZBc3xaSKYOA6THquSK47May8m1PuOYZ1mMtzthoXJ4jyX0c7Lg+F/Fx2tFdIQS/cHBhMq0Y3zdNg4ZRlGeellMffMt+Pi2rpnHWc2pP8N8PMKqCy+dJXb081fHq+C0RR2VC2XSYzylsM2yVmFgXluQtO3JrJG99KEWHWYmrWvGbTAI+i2hTdSjKVcr1axKYBwGxVP+FOi3WmYLIRfWBLWQkpU4imGKivAdjxwjOi350P48NS0F+xD/RnTr3BuAhTd/MDElv5AKCU9BLnytbxM43J1kPD0QnCbZs7Ghxrz1CPox0mZ5ZCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9N7kPc6Wa6BysTRU/EQytgHX+JHZ9gx0gwL4stNTW8=;
 b=OOQiv6DGs/WSbDBCqxD+k1sXT+H4Uwm9BuJfnQYKXWjoY/T9Gy6u5oISw87S1q/+G7tSgHNbWALa5WxtsIA0AFbmu/UvHjoHCXWo6la5B5uqrNnKnsu85aTtgraUhGZT5QpGi8TqDKCETo1QJB4Z+GDpzKYOpWQawLEEau5u/xnbZHMRIdiKTmA+yl2UFQfvrXXZBo/Kmok7gz23auB/rYQ1/fmGFHwRZ+P86JWw1DOOTboFUnEjx7q810dzyVM4WxS4AsCzKC8GhXx+VGXazSHQ+qLyXO/BgysVW63ch+FR16NcL4t/tUWP1WvMQKPxHaLnim9TZUC0kWtV77Jrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9N7kPc6Wa6BysTRU/EQytgHX+JHZ9gx0gwL4stNTW8=;
 b=Kc8N1BZf69CYsLYgpAD4VpBNk4HZfwl+7UHydTZqpqRqejwyK/OekUx5OYDS8pN7oRgwgn5b36RXl/CT3qjpSAzC64jw/9z0lWH2aCeJXRLN2f9KWt+kvFC0Vgk0e2lWDf8YvjDnWzb/4aqmGy6m3jYjEHbGTqpesbdJlm2vQ5I=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.23; Thu, 25 May
 2023 02:51:31 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::1870:9a86:60d7:f41b]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::1870:9a86:60d7:f41b%6]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 02:51:31 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Program gds backup address as zero if no gds
 allocated
Thread-Topic: [PATCH] drm/amdgpu: Program gds backup address as zero if no gds
 allocated
Thread-Index: AQHZjh4rPE9Xgv8kEEiawB6dnkGuB69pWokAgADKi1A=
Date: Thu, 25 May 2023 02:51:30 +0000
Message-ID: <DS7PR12MB6333628A4BAB27A7F0CCF493F4469@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20230524090001.3276718-1-jiadong.zhu@amd.com>
 <CADnq5_NzJ7XuOms1ppQpei-UpRwGFuA8ehSGs9P8TR2+GuNX_Q@mail.gmail.com>
In-Reply-To: <CADnq5_NzJ7XuOms1ppQpei-UpRwGFuA8ehSGs9P8TR2+GuNX_Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1446b8c0-82e5-440f-b5fd-011ab68bfa4e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-25T00:34:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|SA1PR12MB6969:EE_
x-ms-office365-filtering-correlation-id: 48b6752c-4bc8-4d94-fd6e-08db5ccaf16c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXdPMtAi3VVlga4mfSrrjIDNR9Nxp49FR8KZfQ8KJRqT/9hHKEWYrwwCE5kDFeu2ZnCXAGl/fSAFPnOFCjfls5Ot6Gl9ErX0R8j6iS+bQ5FoQX9Qy9PL8OOSZWlzOIov1nyfYwWJGbUd5g9RLOw384/LQeN5DrTth8jwzk7ahyX76D7vFRK7jFAmo8y0wdXrYtLrRB2ettlaAAnfz8Gj6k3oJ3Et5JPD2tbkX11z7Msi9/Wx7Mh3RrM98kho8KX4oCcyd8NlaBB94O+5yM65Y8AhDOlCSS4z6gRfGs+VBUWIPqe7gQiOhRmY3ar7uvRSR2DBFIteQN3tTP9hPT+Ggn3t38zLLbXQFPymFRlqhoRSv2vOWY1x2s3seRwfeSZzRm1QBWnmV9uc2/3NCTMu9OxHqF0FQHHU3Xd+IPwcBsY70Snl6z2qdipE5s815xCiWdVqEPqqThx9dtndVTG2Tlqo6XaZXoRIM+ix50x7Y7LGZTCxK0YT+oxAPcnAOybtMpu7/sIxsxOKKl3W90/l7NSgEuRj2iuiQl7cFC11Gz0Ta1f1jPMz4xMV6OIp0ybzHudronf0EqMjSrB4yf3t6PFtw6EQJVq6UUVQsLKI8KCZNWV6x81nldS6XvGmxes4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(8936002)(8676002)(5660300002)(52536014)(186003)(83380400001)(9686003)(6506007)(53546011)(86362001)(26005)(122000001)(38100700002)(38070700005)(41300700001)(71200400001)(76116006)(7696005)(33656002)(66946007)(55016003)(66446008)(64756008)(66476007)(6916009)(66556008)(316002)(478600001)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFBRMklNUHl0YVpyMmt4c1FMR0g1NXdqNHJ0eWJpZnpoanhnUDE5YmhuY3lL?=
 =?utf-8?B?ckljK3lDU3BVaVBRZkpvN0phUndVeTJubllHWXY3TmFjaFdOTW1nZ05oRlB4?=
 =?utf-8?B?Z3c4ZHZ2RndPQjZYNk5OUWRoUzhKOGwzZW9GUVUrV0FGekpUdnBpRmtiVjh5?=
 =?utf-8?B?QlZXaU91eXFNTHFlUkJ1M2xIYzV2ZTh2Nk90NmF0MVpMRUdSWUk1L29aNnlZ?=
 =?utf-8?B?WXJ4enV5d3BpWmdxdmt3UWtaQmhuYktJQldvdUcvUEpFdVZYdnhWVHQ1Y09w?=
 =?utf-8?B?QkhhYm43b1l5Q1JZQmVtOHVheC8yU1FEekNXWUxDWnlNWGMyR0ZhbW5xVStM?=
 =?utf-8?B?S0N1YjJhd0tiZGpHT1VNVVA2RGQ0YXlDSml1dm5ORnF2SitpOFIwMnRSTVJU?=
 =?utf-8?B?M0dFWCtOOTd2a0NzbEdsUWhSMm5PYmtwcGRpekwrN1R0YU5PVTZJSitEWWFE?=
 =?utf-8?B?WVlyWnlMaDhaTUdrdzNFNHo5dkNwUGpoOHJuMTdzbjZuMjRxMjkvbkt2ejFw?=
 =?utf-8?B?YklSL1QwZ1VtY0duTXgzMituekRmc3A5NHpnc04xN0V2Witpdkp1eEJmaGt1?=
 =?utf-8?B?cndsb0kvclZnRDZNeEFDQmFRL2hSUDltclJWMjBjcjhZMmFpNXF1WVYzWFFy?=
 =?utf-8?B?RjVrcFVHbi9mbDhtUEFhcTRvY3lxSTJlSXF5NUVJRGVpSEx0cFFOY0dNdm5O?=
 =?utf-8?B?SHR0Q3g0OVJFSllqUUk3Q1lZSVZjUmtmeXQrYk1kZlFMU3oxbllBVGFWZTJu?=
 =?utf-8?B?SDZWYnJGL3VhZTRRR01QWWFBSDdJZytKK3Q1WVhJWUQvT3NITUt2ZFdWU3pt?=
 =?utf-8?B?NGVEU09YWXdRdksvNU1LOEZwa2gzU01BZlVoc1VENlk5cXFWVGtNOU1oL3kw?=
 =?utf-8?B?d21uZTRsZEM1UWxsVk1KZmJEQmFPbmthSGd3V0RSMEVGUzRFMWtLU2VoNjdu?=
 =?utf-8?B?dmhJQzlyVk5yTXY4Ky9wMFQwV21PMmV6bytBdTluaWlPT1dCOXNsbFY3VFJL?=
 =?utf-8?B?aU9OUnFLMXltbEVNaG0rVDdDbDRGazBjdThiL2U2bm5rd2QvTHdJZUR0Smpq?=
 =?utf-8?B?OFlJWGZCVjhKeVBMcW0rMTduTDl5Z3AyK09hSENWM01DeHFIdThkRHIrdHNJ?=
 =?utf-8?B?Z21TT0xxd1JSV0tCMHM2SkdMQ0tIa2owZnhwY3A1K0MzZTA5cy9sZHJHQmJh?=
 =?utf-8?B?Qk1YN3RVVDNZeVBaMHJLZmlBWFh3WWhRNnorcmR3MWR0Qlo1c0QwVndpTHdW?=
 =?utf-8?B?VFd5Q2tGQkpHY05OVURnUDI0dkpUQjIvdk5ILzZQM2h4Y1kwUVYzZkxVVmpw?=
 =?utf-8?B?Y2VVN0tTRklwdEhQKzZrbWY2L2g1M1oycHpZa3dhZnBER1Z1WGFjbjROMXRp?=
 =?utf-8?B?Sk5TZE1lbGRJNFBldVhyK0lsZUtpSDJsRkdEU3pLSGtKN3BlRGJtQ3l0Sy9x?=
 =?utf-8?B?OENKeXI5SlhCYjMwT3FUaXVXaFVBUUpOWlNXMzJ5YjVKQ1B2Zk9yTGpaMkc4?=
 =?utf-8?B?NXZELzk5LzhLWnpCaXBTMTBrL0p1RFJpN2JZNW9NTVU0Rmh6VzVrQ2dUTXpH?=
 =?utf-8?B?bTJPZ2ZlN3R6SnVLVlZ3bVRDR2JwMzRPUWhkS0ZaMXJJTTVjSU01dEY4SERZ?=
 =?utf-8?B?L0pwZGUwc2tnRmh5M2owUE5UNGJQNGlzbmpWYjVhdHN5Rlg2YnBoYUh0ODNt?=
 =?utf-8?B?Lzd5Um5DeERHa1VWNmNZNVpvaUpweFNUYnkwZnRqbHM4WnhoZFVYajhzd08x?=
 =?utf-8?B?L3cvL3FiUmlBYVBGcDZ0S0xwZnJkQ1BuME80bWwvb09uNEFtbnB0Qlc2ZnVy?=
 =?utf-8?B?bjliVTNaZmJMU0tmL3FRL3Z1T0FJQ2JVMC9zQ3M0VEE4RHRmdUlXdnFBeUtx?=
 =?utf-8?B?SFk0ald4ZW5KenhvZ2dEZUxkWU5uaDUyWndOamJoR3RhTnFwQThTdURjYkpy?=
 =?utf-8?B?QWk2ejRMUFgzUFFQM2JzN3ZOQmExbnU3MVVRN3ZqaVRlMmVhejdhc05kWi9H?=
 =?utf-8?B?c1hkQ0hLTEF5THJiTG85RHg4TzhINDRaeTgxeWEwVnJiMEQ1bDQzYStpL3RH?=
 =?utf-8?B?cnpuU2hiaFM5Nm5JdEVCbUVMeVVkWlVWbjFvL0FOTlFFTzZ2aldsYXZDNStT?=
 =?utf-8?Q?Jlzo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6752c-4bc8-4d94-fd6e-08db5ccaf16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 02:51:30.6088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coXS0ktEQJD/zHe6ug2AEUKVyKnopeCsRvKpfrS5iMBshwlDDaqfFUkbdfbkBG3EJ9jnfJwSQbLul+XDgtVfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gUHJlc3VtYWJseSBvdGhlciBn
ZnggdmVyc2lvbnMgcmVxdWlyZSBzb21ldGhpbmcgc2ltaWxhcj8NCg0KRnJvbSBmaXJtd2FyZSBn
dXlzLCB0aGF0IGlzIGFsd2F5cyB0aGUgY2FzZS4gZmlybXdhcmUgd291bGQgY2hlY2tzIGdkc19i
YWNrdXBfYWRkciB6ZXJvIG9yIG5vdCB0byByZXN0b3JlIGdkcyBwYXJ0aXRpb24gaW4gdGhlIHJl
c3VtZWQgc2VxdWVuY2UuDQpDdXJyZW50bHksIG9ubHkgZ2Z4OSBoYXMgdGhlIHNjZW5hcmlvIHRo
YXQgb3Mgc2VuZGluZyByZXN1Ym1pc3Npb24gaWIgYWZ0ZXIgbWNicCBoYXBwZW5zLg0KDQpUaGFu
a3MsDQpKaWFkb25nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgTWF5IDI0LCAy
MDIzIDg6MzAgUE0NClRvOiBaaHUsIEppYWRvbmcgPEppYWRvbmcuWmh1QGFtZC5jb20+DQpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHU6IFByb2dyYW0gZ2RzIGJhY2t1cCBhZGRyZXNzIGFzIHplcm8gaWYgbm8gZ2RzIGFsbG9j
YXRlZA0KDQpPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCA1OjAw4oCvQU0gPGppYWRvbmcuemh1QGFt
ZC5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBKaWFkb25nIFpodSA8SmlhZG9uZy5aaHVAYW1kLmNv
bT4NCj4NCj4gSXQgaXMgZmlybXdhcmUgcmVxdWlyZW1lbnQgdG8gc2V0IGdkc19iYWNrdXBfYWRk
cmxvIGFuZA0KPiBnZHNfYmFja3VwX2FkZHJoaSBvZiBERSBtZXRhIGJvdGggemVybyBpZiBubyBn
ZHMgcGFydGl0aW9uIGlzIGFsbG9jYXRlZCBmb3IgdGhlIGZyYW1lLg0KDQpQcmVzdW1hYmx5IG90
aGVyIGdmeCB2ZXJzaW9ucyByZXF1aXJlIHNvbWV0aGluZyBzaW1pbGFyPw0KDQpSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEppYWRvbmcgWmh1IDxKaWFkb25nLlpodUBhbWQuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxMyArKysrKysrKy0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gaW5kZXggY2JkZDk5MThiM2U3
Li5jYmNmNjEyNmNjZTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
Yw0KPiBAQCAtNzY1LDcgKzc2NSw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NldF9ybGNfZnVu
Y3Moc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpOyAgc3RhdGljIGludCBnZnhfdjlfMF9n
ZXRfY3VfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2N1X2luZm8gKmN1X2luZm8pOw0KPiBzdGF0
aWMgdWludDY0X3QgZ2Z4X3Y5XzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVf
ZGV2aWNlDQo+ICphZGV2KTsgLXN0YXRpYyB2b2lkIGdmeF92OV8wX3JpbmdfZW1pdF9kZV9tZXRh
KHN0cnVjdCBhbWRncHVfcmluZw0KPiAqcmluZywgYm9vbCByZXN1bWUpOw0KPiArc3RhdGljIHZv
aWQgZ2Z4X3Y5XzBfcmluZ19lbWl0X2RlX21ldGEoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBi
b29sDQo+ICtyZXN1bWUsIGJvb2wgdXNlZ2RzKTsNCj4gIHN0YXRpYyB1NjQgZ2Z4X3Y5XzBfcmlu
Z19nZXRfcnB0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7DQo+IHN0YXRpYyB2
b2lkIGdmeF92OV8wX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
cmFzX2Vycm9yX3N0YXR1cyk7IEBADQo+IC01MTYwLDcgKzUxNjAsOCBAQCBzdGF0aWMgdm9pZCBn
ZnhfdjlfMF9yaW5nX2VtaXRfaWJfZ2Z4KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgZ2Z4X3Y5XzBfcmluZ19lbWl0X2RlX21ldGEocmluZywNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCFhbWRn
cHVfc3Jpb3ZfdmYocmluZy0+YWRldikgJiYNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MgJiBBTURHUFVfSUJfUFJFRU1QVEVEKSA/DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRydWUg
OiBmYWxzZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRydWUgOiBmYWxzZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgam9iLT5nZHNfc2l6ZSA+IDANCj4gKyAmJiBqb2ItPmdkc19iYXNl
ICE9IDApOw0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5n
LCBoZWFkZXIpOyBAQCAtNTQzNSw3ICs1NDM2LDcgQEAgc3RhdGljDQo+IGludCBnZnhfdjlfMF9y
aW5nX3ByZWVtcHRfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiAgICAgICAgIHJldHVy
biByOw0KPiAgfQ0KPg0KPiAtc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmluZ19lbWl0X2RlX21ldGEo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBib29sDQo+IHJlc3VtZSkNCj4gK3N0YXRpYyB2b2lk
IGdmeF92OV8wX3JpbmdfZW1pdF9kZV9tZXRhKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgYm9v
bA0KPiArcmVzdW1lLCBib29sIHVzZWdkcykNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7DQo+ICAgICAgICAgc3RydWN0IHY5X2RlX2liX3N0
YXRlIGRlX3BheWxvYWQgPSB7MH07IEBAIC01NDY2LDggKzU0NjcsMTAgQEANCj4gc3RhdGljIHZv
aWQgZ2Z4X3Y5XzBfcmluZ19lbWl0X2RlX21ldGEoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBi
b29sIHJlc3VtZSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFHRV9TSVpF
KTsNCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAgZGVfcGF5bG9hZC5nZHNfYmFja3VwX2FkZHJs
byA9IGxvd2VyXzMyX2JpdHMoZ2RzX2FkZHIpOw0KPiAtICAgICAgIGRlX3BheWxvYWQuZ2RzX2Jh
Y2t1cF9hZGRyaGkgPSB1cHBlcl8zMl9iaXRzKGdkc19hZGRyKTsNCj4gKyAgICAgICBpZiAodXNl
Z2RzKSB7DQo+ICsgICAgICAgICAgICAgICBkZV9wYXlsb2FkLmdkc19iYWNrdXBfYWRkcmxvID0g
bG93ZXJfMzJfYml0cyhnZHNfYWRkcik7DQo+ICsgICAgICAgICAgICAgICBkZV9wYXlsb2FkLmdk
c19iYWNrdXBfYWRkcmhpID0gdXBwZXJfMzJfYml0cyhnZHNfYWRkcik7DQo+ICsgICAgICAgfQ0K
Pg0KPiAgICAgICAgIGNudCA9IChzaXplb2YoZGVfcGF5bG9hZCkgPj4gMikgKyA0IC0gMjsNCj4g
ICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfV1JJVEVfREFU
QSwgY250KSk7DQo+IC0tDQo+IDIuMjUuMQ0KPg0K
