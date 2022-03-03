Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0797C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 02:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1813010EDA8;
	Thu,  3 Mar 2022 02:59:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB5DA10EDA8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 02:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWijH5b+uMipnjWYZ5gEft4TBHND76BfmdgULtvk+s8A7p12an435bjYNN8s9rN1DRK9evcDl6pWmBaTAi6lzmTFNGvfhazRlWVqPY2i5p76us7eEDGA9UWpQc6Ag2R0+fU6GnALJ6w5D01gERlMythM1UeH2pob53V6moMit102sZ09YG2onHnNZpnrspZKkQpFk1uNjiAtKOcAa44eEUAM4BOK9m22q0/FtNWKwADCBozbtao+c1/vFgU8CtOVRtPECubN/SzvoinXZSSkXgJsT73rq5NBxjzr+XLMbROXz8gO/ynGkxHg5QZf8e5YqIFQgMlUNnpqoRGAqVShAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU9apeVrasap4lElTq3CG1Rb0dFgKQXACgVE2hHHROM=;
 b=XuQFgq7ZEAmzucpBB6XBKNSKxQ6ZRtiAbXwOMu/SDefaBuK7wJMiUAOKGKEtunGranmNmecfoC144jGpiH+E4VdyobJ8GKokvYxg3UVgzV4QvEmrYdmrrUHgIG4RK5qyumKJH7h2Y/DeZ6yTE1iCZgBRjbUsDYtQXjz6eg4hZ2gevT7IlCmcXt9sOYnEoAlQbkXB9ytnHNNcpEL1HQrRZpAzEwfpWo5enZI2mh8NLm0HZxIbUqpSrLOXE9lM7o+DrXRl6ay+HTRuW2/cOtY8LLckBRs7PcNZfdAyPUY6tvYdE2wMXXYf5TrrgPHgc+ggDHlmep0LRBeUjbodroyQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU9apeVrasap4lElTq3CG1Rb0dFgKQXACgVE2hHHROM=;
 b=do/eqeCz3kpJVtCV+zAdoPYk6kYfq4dU87CtJIOAxeFCjDhftUagr252b70It9QUjaKPnOY0UXLwLwwAiAGT6Zg/cAwfIWKr3mLikX8k12WAWzP/loU1TxKMtCwQxzrmWimG2UGxCP9jo16aB217aQ6o9ORz+j37REKhWDdCUyo=
Received: from CY4PR12MB1927.namprd12.prod.outlook.com (2603:10b6:903:127::15)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 02:59:08 +0000
Received: from CY4PR12MB1927.namprd12.prod.outlook.com
 ([fe80::4c2d:a4b8:3d26:8dcb]) by CY4PR12MB1927.namprd12.prod.outlook.com
 ([fe80::4c2d:a4b8:3d26:8dcb%4]) with mapi id 15.20.5038.013; Thu, 3 Mar 2022
 02:59:08 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Thread-Topic: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Thread-Index: AQHYHUtOdZTRleTQLkS6G3YM+VdPOayK2a6AgACrOgCAF1tqgIAAGyAAgAANfYCAAAOsgIABKkMAgACqPYCAB6CWgIAAAT2AgACXx4A=
Date: Thu, 3 Mar 2022 02:59:08 +0000
Message-ID: <C3715E75-B013-409C-B2A3-E10CD79FD027@amd.com>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
 <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
 <0049c754-2af6-0558-3278-620faa4ed7e3@amd.com>
In-Reply-To: <0049c754-2af6-0558-3278-620faa4ed7e3@amd.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52afd3b2-b8d4-4539-17d3-08d9fcc1c95e
x-ms-traffictypediagnostic: BL0PR12MB4708:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4708CE7861F2A07E4E683E87B7049@BL0PR12MB4708.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIM6jI0OIC9ytgM+oKkJyYzTmvdr835GLCLPzpewlGh+4Q6Yjh1J7UVB+bcCxtBU/0lGcNYwlTt0C5l3B1174YHPAwT5Hb9rqjxtBrEcdlqxM5KFm5QVQITnMFtRTfiSxhHbq3o4ZUbUQGZfZOCbNAJfByna7ULDhHmlTgUy9t3ujkC4IQS6xV2UiBwywuthBnotkJKG0QD2+0C6tOmGDP/cfFB6F5hFeMHUixnK/btvdtKdERfvWeT/UGoG3xbB7OZOW1SNSJKJpjYhal3Ixxoue1cuL+dsK9a1hlNzDf6BhySZsbj3QRNN45cFDcIchqMhnf65nkMVO+hlZ94SNEN+6oHLtPlV9YhZG4Ry0geXuXjbvvPcj7wJ4/PGNHK6ue0kBI/ROGhbdtbumtm2c3NERwFgV8O+AchBtoHcfly3jI9eXUrtdwlhgSZDbphyuHfN62PI1s9sf/WOd7J3hV3+VccUb/zpr+EjxMLDlkbPAbOdzLQyzFJs8VZUjQ3Hgzq7DQpughtZWZvlRoRPpioHComMWnwrRh/5+xZKHebfdehAZuVwAN30VDs8I+PmbRi4zv9MXqpfG16rZ98XoBQ7p2JXrUEJQucKMyNJm71gk1J8kN8X40GSdmISiaflFa0kNRrSuCqlksGW+LkqFIj0V2GjwOG/hacBKxjNDh1WXE7YvD6Vc7asYZOBsrTRUF/KxOD5EaiND+6iHdjjKiNCHxjq1rtKsNi015Q/JG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1927.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(91956017)(8936002)(66446008)(8676002)(33656002)(66556008)(66946007)(64756008)(66476007)(4326008)(36756003)(26005)(6862004)(2616005)(186003)(508600001)(5660300002)(6506007)(6512007)(53546011)(37006003)(86362001)(316002)(71200400001)(6486002)(66574015)(83380400001)(6636002)(54906003)(122000001)(38070700005)(2906002)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xzSGlTWGhtcXhWVW9kbm1kUm01R2xONThLb3dSNWV3TnRYUldOR2JQU0NN?=
 =?utf-8?B?L240NFpRL3pNTlNVSHpMdjIya1hjbjZNc01SbEhDSkloTlFyK0RNRENwUys0?=
 =?utf-8?B?dU5PTDVlNTBzRFZ3YWx0enFjelc4QTFHR1VvTnlYY1JGRGJ2aWRnUGp5cUdV?=
 =?utf-8?B?czRvQjdHRFNSWGRDNXg4WUk2UXJBQ1RUQmRyclU3SFlEQ1pUdGtiVW5KVU5j?=
 =?utf-8?B?V1Q2cWdhTG84NGpNNmhuUStYS29saitKdnJjdjdGdkVaZ3hKMmxHVzNLWEYr?=
 =?utf-8?B?YTNyNnp0MmwwYmZhR3hocDRxTkdobERZRG5aVG9md095Rm1mK0FTZWZuQ1M3?=
 =?utf-8?B?dnlCTGJrWWE2YTE3SXB4UDJKZ0dtbWFpN0RhZ1JwekhqUy9sZktNdE11RmRD?=
 =?utf-8?B?ZnRzZUxRcmhEdUlHbVpXdm5qZGcyZG1BbzBWNjdYbC91Sk5KZVlNYTN4b0Zy?=
 =?utf-8?B?RTlqSERQdGdLTkVkdHFPR0doNmlJQTlPSkc0Ymg3LzJPenk2QnprZEl0YkhR?=
 =?utf-8?B?K0VoQThGTDA4TytydHkxdlp6MnJwamFFMElCOHFXa3Y0ckRLMXprU1B6ZkZY?=
 =?utf-8?B?Snk1UWI5RE55V0ZqVXNvVGMvQkwxNitab0RMN2VOUjBBaXIwWFJOTlVzUk0z?=
 =?utf-8?B?cGRJc0ZILytsRlQxeVJ4eVhUYU5VQ2dHb21yK3FLYVpweFN4b3dKR0ZrYkJ5?=
 =?utf-8?B?T2I5aDJCaHFzQU5pWmZQL0NGdWcxNjVqdEtuQVBWOHB6VXVReGhmMExVSk01?=
 =?utf-8?B?OUNPSFRDL3VtblZtbDNqbnBUdDVKMTVGK2ZEMDN6MnhSd2JIajgwUUdvOFAv?=
 =?utf-8?B?czJtVFF6SEhtWTkxVWgwbm5CZ1V4TlF0cW5wOTVFZEFhM28xNGpQWGdycVIw?=
 =?utf-8?B?SFcvZmMyb0RreFlNV1pwbTB1V3FQNXVtVHJadnU2czY4NnZyaTJwU0hqdE55?=
 =?utf-8?B?MWVqanRRNkcyd3JZcWVyMXF0VmVVbjJBTFJTem9BcmhmYUxhODdrV2RlSG5U?=
 =?utf-8?B?YmI5Yys5aDBISXZ6WVlvWCt3OXowd2Vua0xCWWhyRHNycFVsTUlQSjNvUGc2?=
 =?utf-8?B?T1dTd1JjNnd6Z1I5UHRsQkhidWRvbDBFS0hLaStQN1BQOXNkb2dWWDYvWTRZ?=
 =?utf-8?B?YjJBVHBwSkJFL3AvWFJUd1BlMUx1bG5ZaHRReE5WWThSeWtKUHhSN3RPRFVW?=
 =?utf-8?B?Ymx6REI3T0RlY1krSWVvNHlaV1NvWUlNdHVpdDUvdkl5eXJoSUNNU01OZDNw?=
 =?utf-8?B?WGZ1S1VrbzVXUVladTBscFVVb2RoRUZxU0xqT2RodHNGN1F5MVRvSHA1MmpL?=
 =?utf-8?B?NERCSTI5NmRlV0FRUnZMYXdGY2tjSGtrYWVuejdLVGhuc1dUWHU4NHo4MmRK?=
 =?utf-8?B?SFZxaUxZNTkwUG1rVGhWS1NzZWpvYjdSYkl4WHI2dTlnQ2E1ZFFpcElUMFdW?=
 =?utf-8?B?QXJoV0s4ZFovN0VqVVc5eCs4b0JudFhZdVFQY3ZMUE5aRUxtRHlvYkJzVkM2?=
 =?utf-8?B?YmxCN24xdmo3MVFiZ0lNblBlUmtqTGxXbkhoWmVzSUprMUROOW1VQXRMMmxq?=
 =?utf-8?B?M1d0RGFXWmI5UkcrTkYyVjk5MklkU2g3Ulc1VSs1dDF0NEFmemhESWxPTnBC?=
 =?utf-8?B?ZVZlUnZrU0RrOVZtYlR1ODVZMDhrWDg2MUhQLzRRckEyVzZyVUtwNW13bGJU?=
 =?utf-8?B?T2hBQjZMSjZQYlE3eGV0N0FTb3BFTHdzTk5zUURla1M0bnZUeDVmUE1YeGtQ?=
 =?utf-8?B?Qm9UVDVVMkNRaFhSNWhYazdIT2ZoU3FoNWtvMHM3VmVRWGZhVGdTQ29Ja2JV?=
 =?utf-8?B?OFVhNUxJVmhUMzlleWlKNDVmUU9BRmNhaDlLcGNzbkxsSStkUTh3VVp2TkI2?=
 =?utf-8?B?cnNRT0J5QTJMZmljUGlha1cwa2ZrS3lUN1I2cCtQRFFxNE1IVGFYYy9lb2FK?=
 =?utf-8?B?YkcybFQrVVYxN3BISzZRUjRBZHlhWVJsRlUrQUFHcmo1OUdaRnpCbWVwRUFu?=
 =?utf-8?B?S2tqdU1xZjJiMVhwZHJOektOMGVSdk9HL1NrcEJlL3ZQOHFYOGpqTHBrbDA3?=
 =?utf-8?B?dTJSZ1ZKOFZjeWgzc29tMnZBWDQ0NHZpM1k3ZGcvRmZjTUlVbWJucURUeGEx?=
 =?utf-8?B?RkljV2F4QlJIVmxWSGNZcVhZNE5rNUluN2tTcVc1NWNNZDNSZlhWRU01M1VH?=
 =?utf-8?Q?ym4PeyCwQty/nCjCIo5fVTs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51E0B6F6A7FBA34BA4FE9A3F6B84555A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1927.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52afd3b2-b8d4-4539-17d3-08d9fcc1c95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 02:59:08.3473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WX/z3LftAuPKY+HbTKhLhDt2MSaPO4VknfKp6TwQnlDnynnFwq7/bzOQ0fHqcYpmYrjfsmVO3DH5V/F9oKITbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
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
Cc: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, 
 Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQW5kcmV5LA0KDQpJIGRvbid0IGhhdmUgdGhlIGJhcmUgbWVudGFsIGVudmlyb25tZW50LCBJ
IGNhbiBvbmx5IHRlc3QgdGhlIFNSSU9WIGNhc2VzLg0KDQpCZXN0IFJlZ2FyZHMsDQpKaW5nV2Vu
IENoZW4NCg0KDQoNCj4gT24gTWFyIDMsIDIwMjIsIGF0IDAxOjU1LCBHcm9kem92c2t5LCBBbmRy
ZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+IHdyb3RlOg0KPiANCj4gVGhlIHBhdGNoIGlz
IGFja2VkLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4N
Cj4gDQo+IElmIHlvdSBhbHNvIHNtb2tlZCB0ZXN0ZWQgYmFyZSBtZXRhbCBmZWVsIGZyZWUgdG8g
YXBwbHkgYWxsIHRoZSBwYXRjaGVzLCBpZiBubyBsZXQgbWUga25vdy4NCj4gDQo+IEFuZHJleQ0K
PiANCj4gT24gMjAyMi0wMy0wMiAwNDo1MSwgSmluZ1dlbiBDaGVuIHdyb3RlOg0KPj4gSGkgQW5k
cmV5LA0KPj4gDQo+PiBNb3N0IHBhcnQgb2YgdGhlIHBhdGNoZXMgYXJlIE9LLCBidXQgdGhlIGNv
ZGUgd2lsbCBpbnRyb2R1Y2UgYSBpYiB0ZXN0IGZhaWwgb24gdGhlIGRpc2FibGVkIHZjbiBvZiBz
aWVubmFfY2ljaGxpZC4NCj4+IA0KPj4gSW4gU1JJT1YgdXNlIGNhc2Ugd2Ugd2lsbCBkaXNhYmxl
IG9uZSB2Y24gb24gc2llbm5hX2NpY2hsaWQsIEkgaGF2ZSBhdHRhY2hlZCBhIHBhdGNoIHRvIGZp
eCB0aGlzIGlzc3VlLCBwbGVhc2UgY2hlY2sgdGhlIGF0dGFjaG1lbnQuDQo+PiANCj4+IEJlc3Qg
UmVnYXJkcywNCj4+IA0KPj4gSmluZ3dlbiBDaGVuDQo+PiANCj4+IA0KPj4gT24gMi8yNi8yMiA1
OjIyIEFNLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToNCj4+PiBIZXksIHBhdGNoZXMgYXR0YWNo
ZWQgLSBpIGFwcGxpZWQgdGhlIHBhdGNoZXMgYW5kIHJlc29sdmVkIG1lcmdlIGNvbmZsaWN0cyBi
dXQgd2VyZW4ndCBhYmxlIHRvIHRlc3QgYXMgbXkgb24gYm9hcmQncyBuZXR3b3JrIGNhcmQgZG9l
c24ndCB3b3JrIHdpdGggNS4xNiBrZXJuZWwgKGl0IGRvZXMgd2l0aCA1LjE3LCBtYXliZSBpdCdz
IEtjb25maWcgaXNzdWUgYW5kIGkgbmVlZCB0byBjaGVjayBtb3JlKS4NCj4+PiBUaGUgcGF0Y2hl
cyBhcmUgb24gdG9wIG9mICdjYWJhYmRlMTkyYjIgWWlmYW4gWmhhbmcgICAgICAgICAyIGRheXMg
YWdvICAgICBkcm0vYW1kL3BtOiBmaXggbW9kZTIgcmVzZXQgZmFpbCBmb3Igc211IDEzLjAuNSAn
IGNvbW1pdC4NCj4+PiANCj4+PiBQbGVhc2UgdGVzdCBhbmQgbGV0IG1lIGtub3cuIE1heWJlIGJ5
IE1vbmRheSBJIHdpbGwgYmUgYWJsZSB0byByZXNvbHZlIHRoZSBjb25uZWN0aXZpdHkgaXNzdWUg
b24gNS4xNi4NCj4+PiANCj4+PiBBbmRyZXkNCj4+PiANCj4+PiBPbiAyMDIyLTAyLTI0IDIyOjEz
LCBKaW5nV2VuIENoZW4gd3JvdGU6DQo+Pj4+IEhpIEFuZHJleSwNCj4+Pj4gDQo+Pj4+IFNvcnJ5
IGZvciB0aGUgbWlzbGVhZGluZywgSSBtZWFuIHRoZSB3aG9sZSBwYXRjaCBzZXJpZXMuIFdlIGFy
ZSBkZXBlbmRpbmcgb24gdGhpcyBwYXRjaCBzZXJpZXMgdG8gZml4IHRoZSBjb25jdXJyZW5jeSBp
c3N1ZSB3aXRoaW4gU1JJT1YgVERSIHNlcXVlbmNlLg0KPj4+PiANCj4+Pj4gDQo+Pj4+IA0KPj4+
PiBPbiAyLzI1LzIyIDE6MjYgQU0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOg0KPj4+Pj4gTm8g
cHJvYmxlbSBpZiBzbyBidXQgYmVmb3JlIEkgZG8sDQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gSmlu
Z1dlbiAtIHdoeSB5b3UgdGhpbmsgdGhpcyBwYXRjaCBpcyBuZWVkZWQgYXMgYSBzdGFuZGFsb25l
IG5vdyA/IEl0IGhhcyBubyB1c2Ugd2l0aG91dCB0aGUNCj4+Pj4+IGVudGlyZSBmZWF0dXJlIHRv
Z2V0aGVyIHdpdGggaXQuIElzIGl0IHNvbWUgY2hhbmdlcyB5b3Ugd2FudCB0byBkbyBvbiB0b3Ag
b2YgdGhhdCBjb2RlID8NCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBBbmRyZXkNCj4+Pj4+IA0KPj4+
Pj4gDQo+Pj4+PiBPbiAyMDIyLTAyLTI0IDEyOjEyLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6
DQo+Pj4+Pj4gW1B1YmxpY10NCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBJZiBpdCBhcHBsaWVz
IGNsZWFubHksIGZlZWwgZnJlZSB0byBkcm9wIGl0IGluLiAgSSdsbCBkcm9wIHRob3NlIHBhdGNo
ZXMgZm9yIGRybS1uZXh0IHNpbmNlIHRoZXkgYXJlIGFscmVhZHkgaW4gZHJtLW1pc2MuDQo+Pj4+
Pj4gDQo+Pj4+Pj4gQWxleA0KPj4+Pj4+IA0KPj4+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4+
ICpGcm9tOiogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g
b24gYmVoYWxmIG9mIEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
Pg0KPj4+Pj4+ICpTZW50OiogVGh1cnNkYXksIEZlYnJ1YXJ5IDI0LCAyMDIyIDExOjI0IEFNDQo+
Pj4+Pj4gKlRvOiogQ2hlbiwgSmluZ1dlbiA8SmluZ1dlbi5DaGVuMkBhbWQuY29tPjsgQ2hyaXN0
aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+OyBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPg0KPj4+Pj4+ICpDYzoqIExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IENoZW4sIEhv
cmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgZGFuaWVs
QGZmd2xsLmNoIDxkYW5pZWxAZmZ3bGwuY2g+DQo+Pj4+Pj4gKlN1YmplY3Q6KiBSZTogW1JGQyB2
NCAwMi8xMV0gZHJtL2FtZGdwdTogTW92ZSBzY2hlZHVsZXIgaW5pdCB0byBhZnRlciBYR01JIGlz
IHJlYWR5DQo+Pj4+Pj4gTm8gYmVjYXVzZSBhbGwgdGhlIHBhdGNoLXNldCBpbmNsdWRpbmcgdGhp
cyBwYXRjaCB3YXMgbGFuZGVkIGludG8NCj4+Pj4+PiBkcm0tbWlzYy1uZXh0IGFuZCB3aWxsIHJl
YWNoIGFtZC1zdGFnaW5nLWRybS1uZXh0IG9uIHRoZSBuZXh0IHVwc3RyZWFtDQo+Pj4+Pj4gcmVi
YXNlIGkgZ3Vlc3MuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQW5kcmV5DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24g
MjAyMi0wMi0yNCAwMTo0NywgSmluZ1dlbiBDaGVuIHdyb3RlOg0KPj4+Pj4+PiBIaSBBbmRyZXks
DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBXaWxsIHlvdSBwb3J0IHRoaXMgcGF0Y2ggaW50byBhbWQtc3Rh
Z2luZy1kcm0tbmV4dD8NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IG9uIDIvMTAvMjIgMjowNiBBTSwgQW5k
cmV5IEdyb2R6b3Zza3kgd3JvdGU6DQo+Pj4+Pj4+PiBBbGwgY29tbWVudHMgYXJlIGZpeGVkIGFu
ZCBjb2RlIHB1c2hlZC4gVGhhbmtzIGZvciBldmVyeW9uZQ0KPj4+Pj4+Pj4gd2hvIGhlbHBlZCBy
ZXZpZXdpbmcuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEFuZHJleQ0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
PiBPbiAyMDIyLTAyLTA5IDAyOjUzLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPj4+Pj4+Pj4+
IEFtIDA5LjAyLjIyIHVtIDAxOjIzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6DQo+Pj4+Pj4+
Pj4+IEJlZm9yZSB3ZSBpbml0aWFsaXplIHNjaGVkdWxlcnMgd2UgbXVzdCBrbm93IHdoaWNoIHJl
c2V0DQo+Pj4+Pj4+Pj4+IGRvbWFpbiBhcmUgd2UgaW4gLSBmb3Igc2luZ2xlIGRldmljZSB0aGVy
ZSBpaXMgYSBzaW5nbGUNCj4+Pj4+Pj4+Pj4gZG9tYWluIHBlciBkZXZpY2UgYW5kIHNvIHNpbmds
ZSB3cSBwZXIgZGV2aWNlLiBGb3IgWEdNSQ0KPj4+Pj4+Pj4+PiB0aGUgcmVzZXQgZG9tYWluIHNw
YW5zIHRoZSBlbnRpcmUgWEdNSSBoaXZlIGFuZCBzbyB0aGUNCj4+Pj4+Pj4+Pj4gcmVzZXQgd3Eg
aXMgcGVyIGhpdmUuDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4NCj4+Pj4+Pj4+PiBPbmUg
bW9yZSBjb21tZW50IGJlbG93LCB3aXRoIHRoYXQgZml4ZWQgUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+IC0tLQ0KPj4+Pj4+Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+Pj4+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jICB8IDM0ICsrLS0tLS0tLS0tLS0tLS0NCj4+
Pj4+Pj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCAgIHwgIDIg
Kw0KPj4+Pj4+Pj4+PiAgICAgIDMgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMzAg
ZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+Pj4+Pj4+Pj4+IGluZGV4IDk3MDRiMGUxZmQ4Mi4u
MDAxMjNiMDAxM2QzIDEwMDY0NA0KPj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+Pj4+Pj4+Pj4+IEBAIC0yMjg3LDYgKzIyODcs
NDcgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2Z3X2xvYWRpbmcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+Pj4+Pj4+Pj4+ICAgICAgICAgIHJldHVybiByOw0KPj4+Pj4+Pj4+PiAg
ICAgIH0NCj4+Pj4+Pj4+Pj4gICAgICArc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2luaXRfc2No
ZWR1bGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+Pj4+Pj4+Pj4gK3sNCj4+Pj4+
Pj4+Pj4gKyAgICBsb25nIHRpbWVvdXQ7DQo+Pj4+Pj4+Pj4+ICsgICAgaW50IHIsIGk7DQo+Pj4+
Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5H
UzsgKytpKSB7DQo+Pj4+Pj4+Pj4+ICsgICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9
IGFkZXYtPnJpbmdzW2ldOw0KPj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+ICsgICAgICAgIC8qIE5v
IG5lZWQgdG8gc2V0dXAgdGhlIEdQVSBzY2hlZHVsZXIgZm9yIHJpbmdzIHRoYXQgZG9uJ3QgbmVl
ZCBpdCAqLw0KPj4+Pj4+Pj4+PiArICAgICAgICBpZiAoIXJpbmcgfHwgcmluZy0+bm9fc2NoZWR1
bGVyKQ0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAgY29udGludWU7DQo+Pj4+Pj4+Pj4+ICsNCj4+
Pj4+Pj4+Pj4gKyAgICAgICAgc3dpdGNoIChyaW5nLT5mdW5jcy0+dHlwZSkgew0KPj4+Pj4+Pj4+
PiArICAgICAgICBjYXNlIEFNREdQVV9SSU5HX1RZUEVfR0ZYOg0KPj4+Pj4+Pj4+PiArICAgICAg
ICAgICAgdGltZW91dCA9IGFkZXYtPmdmeF90aW1lb3V0Ow0KPj4+Pj4+Pj4+PiArICAgICAgICAg
ICAgYnJlYWs7DQo+Pj4+Pj4+Pj4+ICsgICAgICAgIGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9DT01Q
VVRFOg0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAgdGltZW91dCA9IGFkZXYtPmNvbXB1dGVfdGlt
ZW91dDsNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4+Pj4+Pj4+PiArICAgICAg
ICBjYXNlIEFNREdQVV9SSU5HX1RZUEVfU0RNQToNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIHRp
bWVvdXQgPSBhZGV2LT5zZG1hX3RpbWVvdXQ7DQo+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICBicmVh
azsNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgZGVmYXVsdDoNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAg
IHRpbWVvdXQgPSBhZGV2LT52aWRlb190aW1lb3V0Ow0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAg
YnJlYWs7DQo+Pj4+Pj4+Pj4+ICsgICAgICAgIH0NCj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+PiAr
ICAgICAgICByID0gZHJtX3NjaGVkX2luaXQoJnJpbmctPnNjaGVkLCAmYW1kZ3B1X3NjaGVkX29w
cywNCj4+Pj4+Pj4+Pj4gKyByaW5nLT5udW1faHdfc3VibWlzc2lvbiwgYW1kZ3B1X2pvYl9oYW5n
X2xpbWl0LA0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgIHRpbWVvdXQsIGFkZXYtPnJl
c2V0X2RvbWFpbi53cSwgcmluZy0+c2NoZWRfc2NvcmUsIHJpbmctPm5hbWUpOw0KPj4+Pj4+Pj4+
PiArICAgICAgICBpZiAocikgew0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAgRFJNX0VSUk9SKCJG
YWlsZWQgdG8gY3JlYXRlIHNjaGVkdWxlciBvbiByaW5nICVzLlxuIiwNCj4+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgICAgICAgIHJpbmctPm5hbWUpOw0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAgcmV0
dXJuIHI7DQo+Pj4+Pj4+Pj4+ICsgICAgICAgIH0NCj4+Pj4+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4+
Pj4+ICsNCj4+Pj4+Pj4+Pj4gKyAgICByZXR1cm4gMDsNCj4+Pj4+Pj4+Pj4gK30NCj4+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+ICAgICAgLyoqDQo+Pj4+Pj4+Pj4+ICAgICAg
ICogYW1kZ3B1X2RldmljZV9pcF9pbml0IC0gcnVuIGluaXQgZm9yIGhhcmR3YXJlIElQcw0KPj4+
Pj4+Pj4+PiAgICAgICAqDQo+Pj4+Pj4+Pj4+IEBAIC0yNDE5LDYgKzI0NjAsMTAgQEAgc3RhdGlj
IGludCBhbWRncHVfZGV2aWNlX2lwX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
Pj4+Pj4+Pj4+ICAgICAgICAgICAgICB9DQo+Pj4+Pj4+Pj4+ICAgICAgICAgIH0NCj4+Pj4+Pj4+
Pj4gICAgICArICAgIHIgPSBhbWRncHVfZGV2aWNlX2luaXRfc2NoZWR1bGVycyhhZGV2KTsNCj4+
Pj4+Pj4+Pj4gKyAgICBpZiAocikNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgZ290byBpbml0X2ZhaWxl
ZDsNCj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+PiAgICAgICAgICAvKiBEb24ndCBpbml0IGtmZCBp
ZiB3aG9sZSBoaXZlIG5lZWQgdG8gYmUgcmVzZXQgZHVyaW5nIGluaXQgKi8NCj4+Pj4+Pj4+Pj4g
ICAgICAgICAgaWYgKCFhZGV2LT5nbWMueGdtaS5wZW5kaW5nX3Jlc2V0KQ0KPj4+Pj4+Pj4+PiBh
bWRncHVfYW1ka2ZkX2RldmljZV9pbml0KGFkZXYpOw0KPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPj4+Pj4+Pj4+PiBpbmRleCA0NTk3N2E3MmI1
ZGQuLmZhMzAyNTQwYzY5YSAxMDA2NDQNCj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4+Pj4+Pj4+Pj4gQEAgLTQ1Nyw4ICs0NTcs
NiBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9pbml0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nLA0KPj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgIGF0b21pY190ICpzY2hl
ZF9zY29yZSkNCj4+Pj4+Pj4+Pj4gICAgICB7DQo+Pj4+Pj4+Pj4+ICAgICAgICAgIHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsNCj4+Pj4+Pj4+Pj4gLSAgICBsb25nIHRp
bWVvdXQ7DQo+Pj4+Pj4+Pj4+IC0gICAgaW50IHI7DQo+Pj4+Pj4+Pj4+ICAgICAgICAgICAgaWYg
KCFhZGV2KQ0KPj4+Pj4+Pj4+PiAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4+Pj4+
Pj4+IEBAIC00NzgsMzYgKzQ3NiwxMiBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9pbml0X3Jp
bmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPj4+Pj4+Pj4+PiBzcGluX2xvY2tfaW5pdCgm
cmluZy0+ZmVuY2VfZHJ2LmxvY2spOw0KPj4+Pj4+Pj4+PiAgICAgICAgICByaW5nLT5mZW5jZV9k
cnYuZmVuY2VzID0ga2NhbGxvYyhudW1faHdfc3VibWlzc2lvbiAqIDIsIHNpemVvZih2b2lkICop
LA0KPj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0KPj4+
Pj4+Pj4+PiAtICAgIGlmICghcmluZy0+ZmVuY2VfZHJ2LmZlbmNlcykNCj4+Pj4+Pj4+Pj4gLSAg
ICAgICAgcmV0dXJuIC1FTk9NRU07DQo+Pj4+Pj4+Pj4+ICAgICAgLSAgICAvKiBObyBuZWVkIHRv
IHNldHVwIHRoZSBHUFUgc2NoZWR1bGVyIGZvciByaW5ncyB0aGF0IGRvbid0IG5lZWQgaXQgKi8N
Cj4+Pj4+Pj4+Pj4gLSAgICBpZiAocmluZy0+bm9fc2NoZWR1bGVyKQ0KPj4+Pj4+Pj4+PiAtICAg
ICAgICByZXR1cm4gMDsNCj4+Pj4+Pj4+Pj4gKyAgICByaW5nLT5udW1faHdfc3VibWlzc2lvbiA9
IG51bV9od19zdWJtaXNzaW9uOw0KPj4+Pj4+Pj4+PiArICAgIHJpbmctPnNjaGVkX3Njb3JlID0g
c2NoZWRfc2NvcmU7DQo+Pj4+Pj4+Pj4gTGV0J3MgbW92ZSB0aGlzIGludG8gdGhlIGNhbGxlciBh
bmQgdGhlbiB1c2UgcmluZy0+bnVtX2h3X3N1Ym1pc3Npb24gaW4gdGhlIGZlbmNlIGNvZGUgYXMg
d2VsbC4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBUaGUgbWF4aW11bSBudW1iZXIgb2Ygam9icyBv
biB0aGUgcmluZyBpcyBub3QgcmVhbGx5IGZlbmNlIHNwZWNpZmljLg0KPj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+IFJlZ2FyZHMsDQo+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4+PiAgICAgIC0gICAgc3dpdGNoIChyaW5nLT5mdW5jcy0+dHlwZSkgew0KPj4+Pj4+Pj4+PiAt
ICAgIGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9HRlg6DQo+Pj4+Pj4+Pj4+IC0gICAgICAgIHRpbWVv
dXQgPSBhZGV2LT5nZnhfdGltZW91dDsNCj4+Pj4+Pj4+Pj4gLSAgICAgICAgYnJlYWs7DQo+Pj4+
Pj4+Pj4+IC0gICAgY2FzZSBBTURHUFVfUklOR19UWVBFX0NPTVBVVEU6DQo+Pj4+Pj4+Pj4+IC0g
ICAgICAgIHRpbWVvdXQgPSBhZGV2LT5jb21wdXRlX3RpbWVvdXQ7DQo+Pj4+Pj4+Pj4+IC0gICAg
ICAgIGJyZWFrOw0KPj4+Pj4+Pj4+PiAtICAgIGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9TRE1BOg0K
Pj4+Pj4+Pj4+PiAtICAgICAgICB0aW1lb3V0ID0gYWRldi0+c2RtYV90aW1lb3V0Ow0KPj4+Pj4+
Pj4+PiAtICAgICAgICBicmVhazsNCj4+Pj4+Pj4+Pj4gLSAgICBkZWZhdWx0Og0KPj4+Pj4+Pj4+
PiAtICAgICAgICB0aW1lb3V0ID0gYWRldi0+dmlkZW9fdGltZW91dDsNCj4+Pj4+Pj4+Pj4gLSAg
ICAgICAgYnJlYWs7DQo+Pj4+Pj4+Pj4+IC0gICAgfQ0KPj4+Pj4+Pj4+PiAtDQo+Pj4+Pj4+Pj4+
IC0gICAgciA9IGRybV9zY2hlZF9pbml0KCZyaW5nLT5zY2hlZCwgJmFtZGdwdV9zY2hlZF9vcHMs
DQo+Pj4+Pj4+Pj4+IC0gICAgICAgICAgICAgICBudW1faHdfc3VibWlzc2lvbiwgYW1kZ3B1X2pv
Yl9oYW5nX2xpbWl0LA0KPj4+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgdGltZW91dCwgTlVMTCwg
c2NoZWRfc2NvcmUsIHJpbmctPm5hbWUpOw0KPj4+Pj4+Pj4+PiAtICAgIGlmIChyKSB7DQo+Pj4+
Pj4+Pj4+IC0gICAgICAgIERSTV9FUlJPUigiRmFpbGVkIHRvIGNyZWF0ZSBzY2hlZHVsZXIgb24g
cmluZyAlcy5cbiIsDQo+Pj4+Pj4+Pj4+IC0gICAgICAgICAgICAgIHJpbmctPm5hbWUpOw0KPj4+
Pj4+Pj4+PiAtICAgICAgICByZXR1cm4gcjsNCj4+Pj4+Pj4+Pj4gLSAgICB9DQo+Pj4+Pj4+Pj4+
ICsgICAgaWYgKCFyaW5nLT5mZW5jZV9kcnYuZmVuY2VzKQ0KPj4+Pj4+Pj4+PiArICAgICAgICBy
ZXR1cm4gLUVOT01FTTsNCj4+Pj4+Pj4+Pj4gICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4+Pj4+
Pj4gICAgICB9DQo+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuaA0KPj4+Pj4+Pj4+PiBpbmRleCBmYWU3ZDE4NWFkMGQuLjdmMjBjZTczYTI0MyAxMDA2NDQN
Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jpbmcu
aA0KPj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Zy5oDQo+Pj4+Pj4+Pj4+IEBAIC0yNTEsNiArMjUxLDggQEAgc3RydWN0IGFtZGdwdV9yaW5nIHsN
Cj4+Pj4+Pj4+Pj4gICAgICAgICAgYm9vbCBoYXNfY29tcHV0ZV92bV9idWc7DQo+Pj4+Pj4+Pj4+
ICAgICAgICAgIGJvb2wgICAgICAgICAgICBub19zY2hlZHVsZXI7DQo+Pj4+Pj4+Pj4+ICAgICAg
ICAgIGludCAgICAgICAgICAgIGh3X3ByaW87DQo+Pj4+Pj4+Pj4+ICsgICAgdW5zaWduZWQgbnVt
X2h3X3N1Ym1pc3Npb247DQo+Pj4+Pj4+Pj4+ICsgICAgYXRvbWljX3QgICAgICAgICpzY2hlZF9z
Y29yZTsNCj4+Pj4+Pj4+Pj4gICAgICB9Ow0KPj4+Pj4+Pj4+PiAgICAgICAgI2RlZmluZSBhbWRn
cHVfcmluZ19wYXJzZV9jcyhyLCBwLCBpYikgKChyKS0+ZnVuY3MtPnBhcnNlX2NzKChwKSwgKGli
KSkpDQoNCg==
