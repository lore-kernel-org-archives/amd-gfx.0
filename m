Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46239C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF2D10EBC2;
	Thu, 17 Mar 2022 13:22:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEBB10EBC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE8wGnCFrp9/M8cwlQ0HLnOJhIlN3TmhsyO4B/CTes1al8DHDGWGkG8nBG5KaEmkJ/9MRbhBEMO2+JPFGso+oSZrEDLUQuoQcXpsL09yS39dAZBQVvKnenCTHQJQFZZTr9XPqSP3PcnOSLcDR6GvYnLrqURR5jcE9rfnxkpIcrO5fO13ZvUqOIpW3y4l8imBY6I+qCYFsZL9+jHwaQi+SewB88OT9xGdnzEeY5mROAlUz9L5ExhMFoiuYch3Wp2r5rwxZsv2PXyIj7Qf6baCERgEZQ51fYwScnMniu397ByQscBRBgWt04La9sOZzkxR5vISvyhuthNPB9oSbSxGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shjXal26u7o95jvt+GANz1wjekmTukKvF6a7sAWkGE4=;
 b=KU6mGm6oq0MzUmYPLkao3xdk+OXfZhtvGs5ZT33SrCGWGp75NXE9w5cIjpHn/2ZuvT53TNSWDs/RJ9DYMXlFu0OoSMyxOwQ5rNpyYOMV+Ul1BRnFQL8WGhdZZDhGyzmppX5MrdvQN3l4LHtKHgRC0CftrSHa+nCpllwIGQXLmZpl9p1Ny/9lnCtntFdfjTKxEvuoxKVBy+dLbD7ZQERleiEbl3gc2UfPcqc3Jumc2Kajk+lo7HnJZ6PYhi9erFOIL3iQFeqhiAltsBe6CQ4UDmTKj1hkkQlkDpW5ADBJerXz+S0ijibnoun4LNRJ4NcQPIFzr+HnEJZoqPCKB2xnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shjXal26u7o95jvt+GANz1wjekmTukKvF6a7sAWkGE4=;
 b=FGLowU3hnDNztqZvlnWEglAeluyHCA0fEDPADdezoK1KiSONA8tq/WADwL4i1AZxzHF0xTYwZIV5PCLEAhO3vVVfiBPt6FhsiJ81T+QsxsWQDOkYrhA4DG6S1buQNKc7EbLAmjZavsagzQ4neVgzPGVeGw7w1i8dpasyIxIl6vw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Thu, 17 Mar 2022 13:22:41 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4%7]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 13:22:40 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc
 function
Thread-Topic: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc
 function
Thread-Index: AQHYOfEtBB6ZkwM61UGeE6kvIrPU66zDfTWAgAAIINCAAANPAIAABt+g
Date: Thu, 17 Mar 2022 13:22:40 +0000
Message-ID: <DM5PR12MB2469B160D2136669F68ECD06F1129@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220317112118.7411-1-guchun.chen@amd.com>
 <4b9f67aa-8cff-5e7d-7d01-a382dbfb5ae6@gmail.com>
 <DM5PR12MB24699CF6EC99DCE0BA4A5EB0F1129@DM5PR12MB2469.namprd12.prod.outlook.com>
 <cec91f67-4881-dd11-7b11-512748f5803e@amd.com>
In-Reply-To: <cec91f67-4881-dd11-7b11-512748f5803e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d35f7ad-c9ae-4115-a5ce-08da08193693
x-ms-traffictypediagnostic: CY4PR12MB1493:EE_
x-microsoft-antispam-prvs: <CY4PR12MB149302748372A55C513E23FDF1129@CY4PR12MB1493.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6zbU3SYi8hS0CIaDhTkYtnpvEjNeGqsn40h/c4dv/HAoLQyaO087Nj6Wu4Cqq8qcJlBNhwZmL4bGdpkoYsX4vm/5w7uLBmDw1A6U8YKxUKG/QzKgSKIxnxjDjg84jyaVHzwUQCwmNS+0+QLTBjAD7AYGWrE0Eah+Kn6tFo3MoPhIMvc9g2G7i8OfiOb4KaHKkOIp2UqXTJis84S/IJ9mEwxaW1XosyXrWflWOVhmDhEzqrU227IzxQbFtHjPkvfQiSIsZTwfgMaMyEHodkuHyLVBgW1uZdTuazLJtkysnynt2lZKwiee/4DBzJlqKRwNhT+IuzWOpk9kmA/igEt/EYXeqDAZ1gWV+AEuQwrLDAixD1BzBBEELQAsCI/8iDoAdYiIzMkBuqbRpSDtQ+CiTqe1A9t3c4181rLY2YOKh0b45AbzRKq7AO4R1vnvqjW2cOak+MpqUVp/SsMKutNRy2/dYfHz37upaX64xnGFaSeFqg3CEIC6ft5JN5xruv6J4eJd2UYyEU7ow+o8ZHpBIKCnqTpsJPpwRqB3rrQiqvoEdyAqaItKuj0uCDb8Sl/Kyqc+d6Hxfvl+v5LlSsBpc9qZSu9ItpJkItH+HLiYy9bcK+A8CMgeNG6oK4y5sKYcnT9KfL6+M8/htzUvReMY7naRi666Q5zlWwgREOkZKZY7nq6WazeY/ErM2ErVGKSpWUCvSo5tvFF8i3NqDzM4HZyTWBcsRGyZn6YZAQYeEqPtTWFnREMjaYFZ9uQX0Tg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(508600001)(5660300002)(66446008)(66946007)(52536014)(8676002)(76116006)(64756008)(86362001)(38070700005)(8936002)(66476007)(921005)(316002)(66556008)(122000001)(110136005)(55016003)(6636002)(38100700002)(186003)(26005)(7696005)(9686003)(53546011)(83380400001)(2906002)(71200400001)(6506007)(66574015)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRjb2x4ejNERFFNWFBtSFFHeTIyamNnMjJGWFpybUtlR1RlNkdtMjZybHJK?=
 =?utf-8?B?QU9OaGVSN2dyajdzOUY5OUpRQUJGREJGdFYyQU5rTXI3ZkhReVVYVTJtdy8x?=
 =?utf-8?B?UFhGdXZWMEt1ekgyVEl0SVdmS1ZnWWNleVFhSU02RGpCQklGSTFibkV4Yjc1?=
 =?utf-8?B?b2ZmQ1FHVnBBLytoamM2N0RyTkhEaEFtUWNSN1htdzJHSmN1Y1JPQTNjWW9z?=
 =?utf-8?B?aDMvZjd0bmQ5aFk4Q0RqMktuTU9BcTN4aW9mY0pwTU9zRi9JNTBPWFVoWjBH?=
 =?utf-8?B?aFU0N0FGV3VkTm1hNCtVdzk4blZXOTJqL0lFM0RpYTRwY2xmSDFkQ0ltcmhG?=
 =?utf-8?B?eWdRU1dpekp5eVFRUVo1d0hsTEl1UEhhWTdzZEtqeVhZVzA0RHU3QUZQTFZB?=
 =?utf-8?B?ZGpIUXhGVWJod2k5ckFucDNUTDhWTEhtQlVNeCt5VmlMaHlPM1FadlhIVHk3?=
 =?utf-8?B?ZlJSalczblRvYzZzWGFSQld2emNnTTMzOXlNcUdjYVFLZFB2aXlsRHBWMkhN?=
 =?utf-8?B?Mjhyd3JMdDBMT1dnaGhTV1RDays3TTRLSnZBTEFrVUcyV1dSY1UyblVTb05v?=
 =?utf-8?B?OHUxckZDdGw4Rnc0SGFYNjNnOVRLMEpNamNZclRpbk4zTnM2M0lWVFcyT1FC?=
 =?utf-8?B?cXNNTkMyT1RKbEdSZzFqYVVEUktYRHRtNUtYMmlKUHRLZ1c2cFBsVFdWTDZs?=
 =?utf-8?B?VURaUE13d2VxL0pzUVk1UURtazF0ZEFFb0pCQkVmRmR5OExlelpUOG5vZjFX?=
 =?utf-8?B?RGhnR0VHR1MrcmRRelF3OXFEaEdQazBQTWpwWUxEeHJCSlBpakpJMEk4ZXZp?=
 =?utf-8?B?TjlpdnNTYm5kS0oxbGRNTEJ0ZmxORStyWjhkWkZIdGoxNzlFL3VRNGdkSVA5?=
 =?utf-8?B?Sm1PRmtSM3pXRWJPQnVONnRFSEo2YU95dHE3aWtNeTRMMUphTlRheXdjNVpJ?=
 =?utf-8?B?aXQra0RrWkVjRHlFMERwbTI2L2h1VmtidjdKT1llaDdXeG9pSHJPdDkxSlhH?=
 =?utf-8?B?UloyMXpmVjVybGVyMUlPRXhNUVQ2Vlp2ZnI2blQvSldlOGZXOWR3WXZEaU42?=
 =?utf-8?B?S0I2VlQzaWJTREdDV1BXSy82RWM1QlF1UGloOC85VHhVVEErWjd0clh4bkxt?=
 =?utf-8?B?dGtPSE1aeGFFOWtZelB1RDRiQWZ6SVlpbkFDZDJrTWE3N2JoNGtialdzTFZL?=
 =?utf-8?B?Y2QvMnBBVjFVWmcrRnppalVVbERIU0NnSmZXMnM3MEsyWlpzTmNTUm5ZM0ZR?=
 =?utf-8?B?cGQ3T0xQay94SG9MUlZsUUlkWEl0YUxUU2JsT0Z6Y3lrcXJYQU56NVRXcG5F?=
 =?utf-8?B?S3gwTkw2STg5ZUJORFlvRUNleVM1cUlqQ0ExNnJGRmszbTg3ck1WK2pYVWdJ?=
 =?utf-8?B?ejR6S1VtOXNuQ0JTNHVnNFk0UTEwc1hNQWFwbDA4aUkwZktxZGJuUmJ0V2FX?=
 =?utf-8?B?MHFOd2lydHNWY2lOZHQ5YncyZ1lBenNneTdiUCtKV3o3Q200ZVhaWnI0ZTh4?=
 =?utf-8?B?UHJ2MUhFbHNRZzV4OTdwLzk2V0ZJQWdGc292OWRYaForeWcyQ0NRRFVmcXp6?=
 =?utf-8?B?SFYxdjJ4WVlEbXhmaDZaWU5nT2hOeGJZVFlCRjhtaFZYdTlYSlJnM2NUYktN?=
 =?utf-8?B?cHhCeEpoTzgxeGdLVFMybFdrUzRHVGtxOFJTWTI4YTVJQS9zWWRMcDQreWdX?=
 =?utf-8?B?Y29ySDN1bE1nQmN6ZVlYMGIyOUNCdm9xQ3pvQWdvTy9XVnh4aVpMcS9tcmcz?=
 =?utf-8?B?bXJMQ3ptR3U4bkxwMGhMUlNOd0xORTJhSmE0U1cxMngwNUZkb2VMVU1NYVpE?=
 =?utf-8?B?V2lGTytzNTJzaHRPYVduMXhxVmdGOTkxaGlobjJyTzZxRVJJR2k4R1QvSGl5?=
 =?utf-8?B?c1lROGRQbkpWTFFydWhLczhDTTloQ2ZMTjJJZk4wVGx6SzBWaUIyajFIQkdx?=
 =?utf-8?Q?6EkSQ8Z49/X2DT4fPiDm0S5oGkEf1mu1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d35f7ad-c9ae-4115-a5ce-08da08193693
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 13:22:40.7634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MR35gLujK1xkqjQA5lHDosYDNL+D5AsIp5uchuM7Hvye6iZxSPV5+MBGSLKASU7DHMNB2s+JANaqRmB1KUYHoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIGZvciB0aGUgaW5mbywgQ2hyaXN0aWFuLCBhbmQgSSB3aWxsIGFiYW5kb24gdGhpcyBw
YXRjaC4gV2UgZG9u4oCZdCBoYXZlIGEgZ2VuZXJpYyBhbWRncHVfZ21jX3N3X2ZpbmkuDQoNClJl
Z2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5p
ZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXks
IE1hcmNoIDE3LCAyMDIyIDg6NTUgUE0NClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFt
ZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IG1vdmUgUERCIGJvIHJlbGVhc2UgaW50byBhIGdlbmVyaWMgZ21j
IGZ1bmN0aW9uDQoNCk1obSwgYWN0dWFsbHkgdGhhdCBpcyBpbmRlZWQgcHVyZWx5IGdtYyA5IHNw
ZWNpZmljLg0KDQpUaGlzIGlzIGEgd29ya2Fyb3VuZCBmb3IgYSB2ZXJ5IHNwZWNpZmljIGhhcmR3
YXJlIGJ1ZyBpc3N1ZSB3aGljaCB3aWxsIGhvcGVmdWxseSBuZXZlciBoYXBwZW4gYWdhaW4gOikN
Cg0KV2UganVzdCBpbXBsZW1lbnRlZCBpdCBpbiB0aGUgY29tbW9uIGhhbmRsZXIgdG8gYmUgYWJs
ZSB0byB0ZXN0IGl0IHdpdGggZ21jIDggYmVmb3JlIGdtYyA5IGNhbWUgb3V0IG9mIHByb2R1Y3Rp
b24uDQoNCkRvIHdlIGhhdmUgYSBnZW5lcmljIGFtZGdwdV9nbWNfc3dfZmluaXQoKT8gSWYgeWVz
IEkgd291bGQgcHV0IGl0IHRoZXJlIGluc3RlYWQsIGlmIG5vIHdlIG1pZ2h0IHdhbnQgdG8gY3Jl
YXRlIG9uZS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KQW0gMTcuMDMuMjIgdW0gMTM6NTAg
c2NocmllYiBDaGVuLCBHdWNodW46DQo+IEhpIENocmlzdGlhbiwNCj4NCj4gTXkgaW50ZW50aW9u
IGlzIHRvIHVzZSBhIHBhaXJlZCBnZW5lcmljIGdtYyBhbGxvYy9mcmVlIGZ1bmN0aW9uIHRvIHBy
b2NlZWQgUERCIGJvLiBDdXJyZW50IGNvZGUgaXMgZ21jIHY5IGNvZGUgY2FsbHMgYW1kZ3B1X2dt
Y19wZGIwX2FsbG9jIHRvIGFsbG9jYXRlIFBEQiBibyBidWZmZXIsIGFuZCByZWxlYXNlIHRoZSBi
byBkaXJlY3RseSBpbiBnbWNfdjlfMF9zd19maW5pLiBJIGd1ZXNzIFBEQiBibyBpcyBub3QgYSBn
bWMgdjkgc3BlY2lmaWMgYnVmZmVyLCBzbyBpdCdzIGJldHRlciB0byB1c2UgYSByZWxlYXNlIGZ1
bmN0aW9uIGZyb20gYW1kZ3B1X2dlbS5jIGluIGZpbmkuIFRoaXMgbWF5IGJlbmVmaXQgdGhlIGNh
c2UgdGhhdCB1c2VycyBkbyB0aGUgc2FtZSBpbiBHTUMgbmV3ZXIgSVAgY29kZS4NCj4NCj4gUmVn
YXJkcywNCj4gR3VjaHVuDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMTcsIDIwMjIgODoxNCBQTQ0KPiBUbzogQ2hlbiwgR3VjaHVu
IDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IA0K
PiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4gDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBh
bkBhbWQuY29tPjsgRGV1Y2hlciwgDQo+IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogbW92ZSBQREIgYm8gcmVs
ZWFzZSBpbnRvIGEgZ2VuZXJpYyANCj4gZ21jIGZ1bmN0aW9uDQo+DQo+IEFtIDE3LjAzLjIyIHVt
IDEyOjIxIHNjaHJpZWIgR3VjaHVuIENoZW46DQo+PiBUbyBwYWlyIHdpdGggYW1kZ3B1X2dtY19w
ZGIwX2FsbG9jIGFzIGEgbW9yZSBnZW5lcmljIGhhbmRsaW5nIGluIA0KPj4gYW1kZ3B1X2dtYy5j
LCBubyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hl
biA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgNiArKysrKysNCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCB8IDEgKw0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYyAgIHwgMiArLQ0KPj4gICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYw0KPj4gaW5kZXggNzAyMWU4ZjM5MGJkLi4zNmY2YjMyMTQzOGYgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPj4gQEAgLTEz
Niw2ICsxMzYsMTIgQEAgdWludDY0X3QgYW1kZ3B1X2dtY19wZF9hZGRyKHN0cnVjdCBhbWRncHVf
Ym8gKmJvKQ0KPj4gICAgCXJldHVybiBwZF9hZGRyOw0KPj4gICAgfQ0KPj4gICAgDQo+PiArLyog
YW1kZ3B1X2dtY19wZGIwX2ZyZWUgLSBmcmVlIHBkYjAgdnJhbSAqLyB2b2lkIA0KPj4gK2FtZGdw
dV9nbWNfcGRiMF9mcmVlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+PiArCWFtZGdw
dV9ib19mcmVlX2tlcm5lbCgmYWRldi0+Z21jLnBkYjBfYm8sIE5VTEwsIA0KPj4gKyZhZGV2LT5n
bWMucHRyX3BkYjApOyB9DQo+PiArDQo+IFNpbmdsZSBsaW5lIGZ1bmN0aW9uIHVzdWFsbHkgZG9l
c24ndCBsb29rIHRoYXQgdXNlZnVsIHRvIG1lLg0KPg0KPiBXaHkgaXMgdGhhdCBhbnkgaW1wcm92
ZW1lbnQ/DQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4+ICAgIC8qKg0KPj4gICAg
ICogYW1kZ3B1X2dtY19zZXRfcHRlX3BkZSAtIHVwZGF0ZSB0aGUgcGFnZSB0YWJsZXMgdXNpbmcg
Q1BVDQo+PiAgICAgKg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nbWMuaCANCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5oDQo+PiBpbmRleCAwMzJiMDMxM2YyNzcuLjZmNDI1ZTNhOWI2ZSAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaA0KPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+PiBAQCAtMjk5LDYgKzI5OSw3IEBA
IHN0YXRpYyBpbmxpbmUgdWludDY0X3QgYW1kZ3B1X2dtY19zaWduX2V4dGVuZCh1aW50NjRfdCBh
ZGRyKQ0KPj4gICAgfQ0KPj4gICAgDQo+PiAgICBpbnQgYW1kZ3B1X2dtY19wZGIwX2FsbG9jKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4+ICt2b2lkIGFtZGdwdV9nbWNfcGRiMF9mcmVl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4+ICAgIHZvaWQgYW1kZ3B1X2dtY19nZXRf
cGRlX2Zvcl9ibyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgaW50IGxldmVsLA0KPj4gICAgCQkJICAg
ICAgIHVpbnQ2NF90ICphZGRyLCB1aW50NjRfdCAqZmxhZ3MpOw0KPj4gICAgaW50IGFtZGdwdV9n
bWNfc2V0X3B0ZV9wZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHZvaWQgDQo+PiAqY3B1
X3B0X2FkZHIsIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jIA0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+PiBpbmRl
eCAwOGNlYWJkNmM4NTMuLmFkNjAwZjcyYTUxYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMNCj4+IEBAIC0xNzIxLDcgKzE3MjEsNyBAQCBzdGF0aWMgaW50IGdt
Y192OV8wX3N3X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPj4gICAgCWFtZGdwdV9nZW1fZm9yY2VfcmVs
ZWFzZShhZGV2KTsNCj4+ICAgIAlhbWRncHVfdm1fbWFuYWdlcl9maW5pKGFkZXYpOw0KPj4gICAg
CWFtZGdwdV9nYXJ0X3RhYmxlX3ZyYW1fZnJlZShhZGV2KTsNCj4+IC0JYW1kZ3B1X2JvX2ZyZWVf
a2VybmVsKCZhZGV2LT5nbWMucGRiMF9ibywgTlVMTCwgJmFkZXYtPmdtYy5wdHJfcGRiMCk7DQo+
PiArCWFtZGdwdV9nbWNfcGRiMF9mcmVlKGFkZXYpOw0KPj4gICAgCWFtZGdwdV9ib19maW5pKGFk
ZXYpOw0KPj4gICAgDQo+PiAgICAJcmV0dXJuIDA7DQoNCg==
