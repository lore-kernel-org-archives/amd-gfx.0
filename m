Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A60C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 07:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C220510E451;
	Thu, 20 Jan 2022 07:27:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0B410E47B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 07:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkkFBezrgnps3sVu9+ElTZaON/XbOk77kA1Zmi/qv5RVflNuysKxCcwYpiw7Zuol/RRe0U7isQvHOM3wSrsbYyKm2IHz1KB5mPAYYs8E0/96xpVAIByzKm4yS/fG+U+CFDiiXcdZgcEAVZecgFEQdU2Z/6r0rmA6GIipdvUArUzUu0LsCg0vYSEQaGvMcMd2fZkU/XZZ0IcF4IKLCJHdfDxMDawLXijNfGpwRTGmOfrC6BwljIAnfUnNl4MMdqkHJ0Whh2uJMT6uFlvE3hCYcWguEcgqIdRFMMhuUS4ekebeOo4dsKsUOE3CXsBqzej95OKmvgjwXX6suCbF0MJxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ADotupu5blVKpQSpnV0h5LPjYjSz0w/i36WMN7L1gw=;
 b=Icee32dQ8/nBlM3KfEwJQVRvxnlA94t1ABJw0gjaGOQVvOsOVo1xKoYo2X5Iq5Mny7XbncN1lBEUdzgfSfNNwiHdORqoedkVz/i3SRVGqiA7CnTsx79GwZq+TKowFsvJzVN+6ibngSZK4P3/LqtcqKW3N3+6brawgOGhlq/VEz565JOL3OsUcZMy5fThFl64dTuSP8MQQj4iaESksZZHypRY+UduLxep17kueMBhO4iZXhVTB9zdiPgnn0SG2rRNYChNdJiFXmik3zMlx3yMaNw+ORY6JrDt6B8oOPzCbdSTmN9etJZJ5NyWSt0vd4Tgnn8r/BoPdZfzUp5werUK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ADotupu5blVKpQSpnV0h5LPjYjSz0w/i36WMN7L1gw=;
 b=gdBMnITcl3Hnnl7oHZRZFfxPtPpcfAg80Esj6cwFDdsJcn8ZKatc1iRgCpIgRUCvMeNZA6Z/HWnFMoRA5500Btr5MFeT1OW3+cvPHX/rwPwEEtGpTcwmxl7kb3/1YkcA6/lIVepZnfC3z9DnkdptUGJ6LA7dej3yLmlptve2R/g=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BL0PR12MB4737.namprd12.prod.outlook.com (2603:10b6:208:8d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 07:27:39 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e%4]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 07:27:39 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Topic: [PATCH V2 1/2] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Index: AQHYDayJUhrAZOaLi0WzR73S0/qHU6xrZ5OAgAAOl6A=
Date: Thu, 20 Jan 2022 07:27:39 +0000
Message-ID: <CH2PR12MB421560F22FF5FFF14F7A19D5FC5A9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220120031850.350206-1-YiPeng.Chai@amd.com>
 <bed5d7a1-d7a1-5f4e-3c7c-b69a81d033c0@amd.com>
In-Reply-To: <bed5d7a1-d7a1-5f4e-3c7c-b69a81d033c0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 659c502d-2bfb-4031-719a-08d9dbe656cb
x-ms-traffictypediagnostic: BL0PR12MB4737:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4737E905F4807095B790D878FC5A9@BL0PR12MB4737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7ChlnkLBh/eowlv+elbnWV9w4gUmcjVrtKt9dFGVnbwRgjffj90F7/g9YIWl2oaQ65ezMVfNo/E3o5KCSDSK4YGmFN4qDWqRyEhE8rdRuoYgRL55mgC0k4JTHE2oCV7Cm58E9YcRkLgTGtxdDdvkDN6ON2Jj4H3HsLJCSUy3vK66BDDWTGPJq8TxyMBRWNoL/OZECYQmnkbMeMYgtOLVTN3mIcelGiUFg2EKQylhRwYGv+cxmkl7FV/GTdts+/clm8Sr8nkuHDKSTRGcaCA/2kttBlw2meN9dxVCKNUDSfudWY6k7niMnC7TBo7B6fNn1KXx0SYL3y4EEoptZCgI91puyJii7IbOUB1cvLU6Y5OPVU3x9yi6EJhfDqZjS0GiZmG7uNOhTuAa/iM7oaYl1Q1nPgM3ETbY+QklbYwxxDje0vk2O5tZBphLs+6BRlifk/wg+lOz5zfSKm6BQbLjfTjaZMLqKJMofZKnkO2v1n+afcCLMPngWGC0nt9R1w0hNGEM/7dIxaVjauXdGq0fufopeqpXZa2GvbG2IsgrYpdONG8ZevEG4moH1Y/KyHqBLO58CAHxnOP3zfL/Fi6Zp1Ui/6nsN8nt0Z5jcgyCaT4r+x6Y7h08vKQtAyWSEXJ260i9u3oAXAIcV95lOD6uAu9OwRiRzWGV/UPBnzI1KvYzeAOSKXkOFaDFNcZa6vC/wO1Bkcva4LkcWHzR8gU7uqDMJ9TH1iLnTNKEjzgysE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(55016003)(186003)(71200400001)(508600001)(26005)(2906002)(7696005)(122000001)(64756008)(38100700002)(52536014)(8936002)(6506007)(53546011)(5660300002)(8676002)(38070700005)(66556008)(66446008)(316002)(66476007)(66946007)(4326008)(76116006)(86362001)(110136005)(83380400001)(9686003)(54906003)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1U5Y09YTHdYSVZ0QTRjYlNPWEFydFhpL0ZNUzBUSm85dUlsRUdlRDEwNmJx?=
 =?utf-8?B?V1JKTElGakRRZWxiSFdNYzVwU2FiTVhNUXo0aCtJTUFWamRFZ2xBTDRmWWVV?=
 =?utf-8?B?ZDRCV1JlRjlkQUdjcjNSTVU3TmpHR25vbG1PTXpiOVl6ZllZVzJTQTMraUVW?=
 =?utf-8?B?QW94bXZBbVBtR2JVTTR2UGlucjJmS09oaWw0bHVqeENVMENqOUhlMnY3a0tl?=
 =?utf-8?B?bGMrOUowUW5rNEh4b3diWmhlbnVNOW5tTDBVNXdLVUJFN21wWW9YMHhjUnpL?=
 =?utf-8?B?SmZ2QUg3RWVnejZUMGprMHk1S2lQZVlCemlWQlRSKzVkK0kvOFp3ZjN0UHNU?=
 =?utf-8?B?ZVB6QzZDWk5kQk9kSm1VQzZmOE9STFFQcHJXWnhlTVVibytkc3orK0RrRjVp?=
 =?utf-8?B?eUh6T0ZjZmZ3T1ZxcFZ1bnM4OEx2ZGFRczNPMU1UTUduVEdRUlVCeFlQUSs0?=
 =?utf-8?B?dmdFMUZ6RWlXd1d0TWNiY3l6K1BNejc1MTQ0Y3FzN0QxV3J3T1JqQU5MaTJM?=
 =?utf-8?B?eWpJTGFvaHdEblZ3dm91VkVIRjZ2N0pHSGNMcFFBRjVBalB5UGlqWVpxVU9Z?=
 =?utf-8?B?REgzdDlRU0RxYnlINGNFRTR6ZFZoRGNyV1BDYzFicCtHWkZOdUFtR1FvMDl6?=
 =?utf-8?B?YmtuUFNFUEQ0Z3JRRXM1SEhCejJkZjJCUVZWalBETlhSeFdBWlVIR3I3U09y?=
 =?utf-8?B?enk5OW9jQzYzaVpBREo4Q2lKNk1yS1RDVWg3SGduSi9qZDBka3hjRjFHRWdm?=
 =?utf-8?B?RUViZnAwRmFsU0dYSm16Z1BFUjdMQU00MzlzVEJCRFlYclZ1RzExR2pWWTFQ?=
 =?utf-8?B?OStWREtTaXQxRWx0QUlnM1VLQWFISVRrbU1GWGVIaVE1T2ZIM2Zqd2MydHE1?=
 =?utf-8?B?ZDEwWElYN1QxdlEweUdvbFlzdUljTGZzN3ljUnJzc3FZQ0wwVkJ1TXN0TWk2?=
 =?utf-8?B?ZVZoZ0hWK0JscC9JZzBXOU53TFJJb1ZxVW9WYkJQZXpJUDh4RStZTEllcTdC?=
 =?utf-8?B?YnB1OGVxY2kwczJNWlhhdjZ5Zmd2TXhmTmhOS1VadkVodndIbkJPOUZyQS9T?=
 =?utf-8?B?RkgzWEFzRW42M0h6YXV1SzIyREdVZ2VXTlN5T1lOWFFTSjU2L1lzRzFXSHJR?=
 =?utf-8?B?bjlZNTVpSTNnRHZRUGZzWVNFRG1DZElrOHlSUDhVdDNRQjRRa0s1SHlzbU9R?=
 =?utf-8?B?RFVrTWdIV2NHdG5SdUFjNW9uOUlLdW10WkV5NDA4MGNmNkxNYmJJeXB5Q0Jk?=
 =?utf-8?B?N2htaXhRd2RrSWs2bko3VUVnZG9VdDFtQk1sb3FuTlpRQ3IrWnNxZEpaYms2?=
 =?utf-8?B?cGlhNS9OTStmQXVkUXhNQmFKaHY2NTZTb3UzazA0WFJBSEJhc00waFY5Z2NZ?=
 =?utf-8?B?N29EVGRaLytmMEhVSjlaQXN5b0hQK1FzNzJqQ0dFaUhWUERxOGdFWWh1QW1T?=
 =?utf-8?B?c0FzdEthdm5jVi90VWdhUmhlMklWNytKc3FtNUV0YWh6NVphWllsRldqMVhw?=
 =?utf-8?B?Y2d0ZmtaeFBiNmljRzBhREVIWmxudEt4cnVTeFJaSHkvVmJMQzVsdUgwREFl?=
 =?utf-8?B?YXJwM3NabkRGekI3OEF2WmdVbVEvTFlTanlBbC95MWFuSGZPTEtFaUpmdU9P?=
 =?utf-8?B?YzVkZWdNc09nd2NoeEthaDE3c2pmVGlTNFJzNjRxRTFHTjMzWEVGNGQvWHV5?=
 =?utf-8?B?QjJwNlpVVkd2TDJ4Y2dvY01XNEtrYU5yWjNnaTFVUGt1UlRTS3ZCSVZmSDRK?=
 =?utf-8?B?RzRSWGZ5anJYSkYyL2VWblNsUm1jQ1FvMWE5TGErSStwSmZRTk1FMXF6VFE2?=
 =?utf-8?B?bHdhcUdWWEVndmx5dlBmNVNRNE5FaUt2SE9YZkFyT2JqWjhBVERxZXlvTU9Z?=
 =?utf-8?B?OVJmcDNPYnR6YzRUYUZPOW9CK3RqSG42T0VOKzBUQXZ3dUx3K0pzQzh5aS9t?=
 =?utf-8?B?VTVjNHQwakNwd0htTFowL0NmeGRMa2tjRFl4TUh2aVJEODBiRnp6RTg1WHVP?=
 =?utf-8?B?ZWtqdFBaSDc4S0t1Nzhhb0liS3dmZWVLWGZ0TlZNUjcrempqaUlETUtYSERS?=
 =?utf-8?B?QVRmZG52WG8xMFh2U1haWlg2ZkZzbU9TYS9GbGZsUG0yMDA5Rlp2bjVrWHBw?=
 =?utf-8?B?Mm4zeU1FSzVCK0p6TzJwSXlOUzF0bEMxKzZvdWJsQ1NrVVovaE9HbHd2MGNP?=
 =?utf-8?Q?SKaVXVFsEVUQ7gSZtThXiSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659c502d-2bfb-4031-719a-08d9dbe656cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 07:27:39.1979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW5z2JraQBlCsfFVPGEHkjHQ6+rAqH8goG2G8XrJuAZuegZIFuK+Ppur0VBgZLaEhve5l9rGw4EC2r27lYwDQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4737
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAyMCwgMjAyMiAxOjQ5IFBNDQpU
bzogQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCkNjOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVt
ZW50c0BhbWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCBWMiAxLzJdIGRybS9hbWRncHU6IE1vdmUgeGdtaSByYXMgaW5pdGlhbGl6
YXRpb24gZnJvbSAubGF0ZV9pbml0IHRvIC5lYXJseV9pbml0DQoNCg0KDQpPbiAxLzIwLzIwMjIg
ODo0OCBBTSwgeWlwZWNoYWkgd3JvdGU6DQo+IE1vdmUgeGdtaSByYXMgaW5pdGlhbGl6YXRpb24g
ZnJvbSAubGF0ZV9pbml0IHRvIC5lYXJseV9pbml0LCB3aGljaCBsZXQgDQo+IHhnbWkgcmFzIGNh
biBiZSBpbml0aWFsaXplZCBvbmx5IG9uY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB5aXBlY2hh
aSA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5jIHwgMTUgKysrKysrKysrKy0tLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIHwgIDEgKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192MTBfMC5jICB8ICA1ICsrKysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYyAgIHwgIDUgKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBpbmRleCAzNDgzYTgyZjU3MzQuLjc4OGMwMjU3ODMy
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBAQCAt
NDM2LDYgKzQzNiwxNiBAQCB2b2lkIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0c19yZW1vdmUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IGFkZHIsDQo+ICAgCX0gd2hpbGUgKGZh
dWx0LT50aW1lc3RhbXAgPCB0bXApOw0KPiAgIH0NCj4gICANCj4gK2ludCBhbWRncHVfZ21jX3Jh
c19lYXJseV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+ICsJaWYgKCFhZGV2
LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KSB7DQo+ICsJCWFkZXYtPmdtYy54Z21pLnJhcyA9
ICZ4Z21pX3JhczsNCj4gKwkJYW1kZ3B1X3Jhc19yZWdpc3Rlcl9yYXNfYmxvY2soYWRldiwgJmFk
ZXYtPmdtYy54Z21pLnJhcy0+cmFzX2Jsb2NrKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsN
Cj4gK30NCj4gKw0KPiAgIGludCBhbWRncHVfZ21jX3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiAgIAlpbnQgcjsNCj4gQEAgLTQ1MiwxMSArNDYyLDYg
QEAgaW50IGFtZGdwdV9nbWNfcmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4gICAJCQlyZXR1cm4gcjsNCj4gICAJfQ0KPiAgIA0KPiAtCWlmICghYWRldi0+Z21jLnhn
bWkuY29ubmVjdGVkX3RvX2NwdSkgew0KPiAtCQlhZGV2LT5nbWMueGdtaS5yYXMgPSAmeGdtaV9y
YXM7DQo+IC0JCWFtZGdwdV9yYXNfcmVnaXN0ZXJfcmFzX2Jsb2NrKGFkZXYsICZhZGV2LT5nbWMu
eGdtaS5yYXMtPnJhc19ibG9jayk7DQo+IC0JfQ0KPiAtDQo+ICAgCWlmIChhZGV2LT5nbWMueGdt
aS5yYXMgJiYgYWRldi0+Z21jLnhnbWkucmFzLT5yYXNfYmxvY2sucmFzX2xhdGVfaW5pdCkgew0K
PiAgIAkJciA9IGFkZXYtPmdtYy54Z21pLnJhcy0+cmFzX2Jsb2NrLnJhc19sYXRlX2luaXQoYWRl
diwgTlVMTCk7DQo+ICAgCQlpZiAocikNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ21jLmgNCj4gaW5kZXggMDAwMTYzMWNmZWRiLi5hYzRjMGU1MGI0NWMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaA0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgNCj4gQEAgLTMxOCw2ICszMTgs
NyBAQCBib29sIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwNCj4gICAJCQkgICAgICB1aW50MTZfdCBwYXNpZCwgdWludDY0X3QgdGltZXN0YW1wKTsN
Cj4gICB2b2lkIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0c19yZW1vdmUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHVpbnQ2NF90IGFkZHIsDQo+ICAgCQkJCSAgICAgdWludDE2X3QgcGFzaWQp
Ow0KPiAraW50IGFtZGdwdV9nbWNfcmFzX2Vhcmx5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpOw0KPiAgIGludCBhbWRncHVfZ21jX3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpOw0KPiAgIHZvaWQgYW1kZ3B1X2dtY19yYXNfZmluaShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7DQo+ICAgaW50IGFtZGdwdV9nbWNfYWxsb2NhdGVfdm1faW52X2VuZyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7IGRpZmYgDQo+IC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMNCj4gaW5kZXggNGY4ZDM1NmY4NDMyLi43YTZhZDVkNDY3YjIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+IEBAIC03MTksNiArNzE5
LDcgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX3NldF9nZnhodWJfZnVuY3Moc3RydWN0IA0KPiBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2Vhcmx5
X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgIHsNCj4gKwlpbnQgcjsNCj4gICAJc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+ICAgDQo+
ICAgCWdtY192MTBfMF9zZXRfbW1odWJfZnVuY3MoYWRldik7DQo+IEBAIC03MzQsNiArNzM1LDEw
IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgIAlh
ZGV2LT5nbWMucHJpdmF0ZV9hcGVydHVyZV9lbmQgPQ0KPiAgIAkJYWRldi0+Z21jLnByaXZhdGVf
YXBlcnR1cmVfc3RhcnQgKyAoNFVMTCA8PCAzMCkgLSAxOw0KPiAgIA0KPiArCXIgPSBhbWRncHVf
Z21jX3Jhc19lYXJseV9pbml0KGFkZXYpOw0KPiArCWlmIChyKQ0KPiArCQlyZXR1cm4gcjsNCj4g
Kw0KDQo+QXQgdGhpcyBwb2ludCBpdCdzIHVua25vd24gaWYgUkFTIGlzIGFwcGxpY2FibGUgZm9y
IHRoZSBTS1UuIEkgdGhpbmsgdGhpcyBmYWlsdXJlIGNoZWNrIHNob3VsZG4ndCBiZSB0aGVyZSAo
aGVyZSBhbmQgYmVsb3cgb25lKS4NCg0KPmFtZGdwdV9nbWNfcmFzX2Vhcmx5X2luaXQgaXMgcmV0
dXJuIDAgYWx3YXlzLCB0aGF0IHdheSBhbHNvIHRoaXMgY2hlY2sgaXMgbm90IG5lZWRlZC4NCg0K
W1Rob21hc10gIEp1c3QgbGlrZSBjYWxsaW5nIGFtZGdwdV9nbWNfcmFzX2xhdGVfaW5pdCwgIGNo
ZWNraW5nIHRoZSByZXR1cm4gc3RhdHVzIG1heSBtYWtlIHRoZSBjb2RlIGV4dGVuc2libGUuICAN
CgkgICBJbiBhbWRncHVfZ21jX3Jhc19lYXJseV9pbml0LCAgdGhlIHhnbWkgcmFzIGluaXRpYWxp
emF0aW9uIG1heSBhbHdheXMgcmV0dXJuIDAsIGJ1dCBpdCBtYXkgYWRkIGZ1bmN0aW9ucyB0aGF0
IG5lZWQgdG8gY2hlY2sgdGhlIHJldHVybiBzdGF0dXMgaW4gZnV0dXJlLg0KDQpUaGFua3MsDQpM
aWpvDQoNCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jDQo+IGluZGV4IGM3NmZmZDFhNzBjZC4uM2NkZDNkNDU5ZDUxIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gQEAgLTEzMTgsNiAr
MTMxOCw3IEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX3NldF9tY2FfZnVuY3Moc3RydWN0IA0KPiBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZWFybHlf
aW5pdCh2b2lkICpoYW5kbGUpDQo+ICAgew0KPiArCWludCByOw0KPiAgIAlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsNCj4gICANCj4g
ICAJLyogQVJDVCBhbmQgVkVHQTIwIGRvbid0IGhhdmUgWEdNSSBkZWZpbmVkIGluIHRoZWlyIElQ
IGRpc2NvdmVyeSANCj4gdGFibGVzICovIEBAIC0xMzQ3LDYgKzEzNDgsMTAgQEAgc3RhdGljIGlu
dCBnbWNfdjlfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAJYWRldi0+Z21jLnByaXZh
dGVfYXBlcnR1cmVfZW5kID0NCj4gICAJCWFkZXYtPmdtYy5wcml2YXRlX2FwZXJ0dXJlX3N0YXJ0
ICsgKDRVTEwgPDwgMzApIC0gMTsNCj4gICANCj4gKwlyID0gYW1kZ3B1X2dtY19yYXNfZWFybHlf
aW5pdChhZGV2KTsNCj4gKwlpZiAocikNCj4gKwkJcmV0dXJuIHI7DQo+ICsNCj4gICAJcmV0dXJu
IDA7DQo+ICAgfQ0KPiAgIA0KPiANCg==
