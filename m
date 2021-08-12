Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F473C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 08:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D6460F11
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 08:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48D6460F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704726E30F;
	Thu, 12 Aug 2021 08:19:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E8B6E30F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 08:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHl3DlHjWHkcxoyraUoyXHAnFRrdM+7ZexfqFsf1vd/w+QXoPKuDLf+Xyx+7FxRnXvnHpxWLsXPLcjZD0Jzx/6bmfoekIjjh5b9WhzYWMAYI0yQZQ1QLhBMv3pTpIOOvhwyRsmM2dLmfa6E5OwbT3Alk2kzv4EuDORyhRJmsWXRW5DdJWE5aK1SLbRrroAd7KZRDQruDD2vNjBm6fxZPcEnSE0azV7w3Xi0jZKoJCUc+XVSUrFLZ5ISrquMgV34t8/lOUC0Ay2lctuQsL+123SVOB8MgB45ubAR5LQG3w6X5eJ0dJA0Qy5pFyhfBTu2pDf9zmHG1Q+o/0qSC2F07+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp4tnJ04pDKA8HGlo0qAykdaZUlVdpx/iBzjfT+i2R8=;
 b=a3GB7ItLnaHw7LIm0ysmJ2LeuUTm1urLbr5VxK5cNrEG4lE8db07MeLspW/T+twJIvwRkwOlU4Y2/B93NUE7802me4V988lawaWBhQZCmm6uAoxFXhE61cekVLpuZUbgRdIQkE+F999zZKDaPiGVgjE+z/sfpr4xYjUd46ezgG7AWao2VbcFOVVC+M4bCv44/slu7q0w3VWxeR9jYZSB8Fhbd8r3XFT5ISrOKsnnaPEg2mgzbqkWkp6R1PdnGpRCWHPALMq2YxPXOpPlyk4zPk++vU0CaRrVM1M6Cm3YDwpP5fa1rYqbPg/rC679mFBOcPeHX0kumEAX2ekw0dsD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp4tnJ04pDKA8HGlo0qAykdaZUlVdpx/iBzjfT+i2R8=;
 b=s9jvW3x52r733xcT7Y4ZzcbmyZI+phvGex160tTHg+hbaYyID8Sj0xJ5wUINfrgtp1Np3hJpMIzIABzItrtHDPcC/+f0LmCnjSkXK57oZbPRHEF1bOmSNNfKzg09dJsEz4NA5uskdIObSBaA6BZ6bWtMX8AtGwBPZ+iiO4N0900=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Thu, 12 Aug 2021 08:19:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 08:19:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
Thread-Topic: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
Thread-Index: AQHXjy7EX5/K0IP6F0aXogKv63o5XqtvZKUAgAAHXdCAAA+0gIAACuOQ
Date: Thu, 12 Aug 2021 08:19:50 +0000
Message-ID: <DM6PR12MB261966A80354E978DA926CF1E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-6-evan.quan@amd.com>
 <0d76361c-e28e-cc8a-a050-668f38d4e251@amd.com>
 <DM6PR12MB2619197EFEF711E675799ED7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <1e7ac50e-0ba7-2a1f-8085-122de2fa99bd@amd.com>
In-Reply-To: <1e7ac50e-0ba7-2a1f-8085-122de2fa99bd@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T08:19:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7a00e873-59b2-4624-8a3c-9ac49e914f78;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24549ec8-a8a1-4a2f-1cde-08d95d69f468
x-ms-traffictypediagnostic: DM6PR12MB2987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2987FD9E4A017AA757FF51AEE4F99@DM6PR12MB2987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dho9TuIzppypXVCb1NIrzdBFmemVJhlBWChT+pcsG2WLw7rpIksJB4HbxiAnNCdX7Oa+ZhPXSGzvx3tAQ1yD+wYiSe1HsHB6qOyjArSO95Kyk3RcDwfrnCNyoGPBDWKtFc5u9z4RdZiKT4f+cd89LPIcntnREyEElfkuZEZmuDgerO/5En4Vt7Izf5DatckHp4QVrFmYCsL3V3fAyb4+eJ6HPghYhH+3yllCYWLQMuNIpf7gkTl5StIjR5XLNK9yJqqBgvNyckZk6NjAkYs6x6GjJ49S7NWikrLyochYyDbLp+qRlIJcqjnQo7H7PkbpckkZBTIz6bpbMJDbBQgBtJ50K/12ZJ+9+QhTXq3vPM+H0KjDLJxb7GiJSm1FtYYCkT1+CBJoxyipuI9lzjJttKpqzp39nK1F6y7hk0ScPozhsae9WdncOpurvXcUoXcy3NfGMdZyoZPBCssWhcuH/yQHdePQHsfjF9LLy7MMrCMl8OdY9Eh9Pi7r39Q4eQzF+7Th1qUHiCmbwSVIxXGUozSlodmjxHZ+MTMCx7eWRnmuWdco/jYlgnomG6nWx6SxVrtGnMVHxA85O3H34WrL2EEys+lWno4yxURpIHHDl/uMEIjerkjL2q/B/RzYghSrO/fMDqIbvIzPs5vGQj+2IAikc2bh70sEdIjZWae9GiIMNW6LGvSeGmEnE20/0tcH7hSiP0+uQxKiILBxwgsygA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(316002)(2906002)(53546011)(5660300002)(7696005)(4326008)(6506007)(55016002)(83380400001)(9686003)(38070700005)(52536014)(76116006)(38100700002)(71200400001)(66446008)(66946007)(122000001)(26005)(33656002)(508600001)(64756008)(66476007)(66556008)(8936002)(110136005)(186003)(54906003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVFpWVlYY2tVajV4Vm5GSVovUFc2YU9iOGoyN0FsanZIeXA5c08ySEhFUGY4?=
 =?utf-8?B?UysyUXNxeFpaWmdFOTdCTGp3bVFYYjlaU2pkU295dm43RnpVYzRTNCtIM1hv?=
 =?utf-8?B?ZnBEMURyNGZDMmxUZFExcUZ5cXp1akNrUnJGOWxLNTVyRE1UOE1pMm9JbVNH?=
 =?utf-8?B?TXJIaHltMmJ3c2w3UVJuV0dxdjJ2YmhnZzdmdDI0a3JxeGNJQm9uKzJSTlht?=
 =?utf-8?B?QjcxczRCcHBRUmROMHkvdU5tNjNmVXhqbGloR1R2VjhNVTZmRXlza0gxVnd6?=
 =?utf-8?B?VVlsRE9YZ1ArZXBIL1FqUHBueGp0elhtd0g2S1dZRGM3UldpK0dENDNqMUt4?=
 =?utf-8?B?MHVzT1I0SjFZTFZ0ZTVtK3lyQ1dPMllPMklRckdMbXRFU1JtYmZQMitvUDlp?=
 =?utf-8?B?aHg5dndpN3FEeFNZUTNnNnpVTWk0VEdEdlYrTDRTcHJaNW9sbjNheSttVFYw?=
 =?utf-8?B?T2Z5R2dkMllyamM4MGhGSmcvMi9YVnd2LzFET3p5NCtDemNpWm9CK0xvZVNi?=
 =?utf-8?B?S3RIZU85VEloS2tLM0hhSGlxVm5TMGZUOFF5UDNNUlF3Y3JnZXpMNTJoVWlP?=
 =?utf-8?B?YmQ0MENoZ2RwaTB6L245eWh3d3IrMjY4ckQ0WDdUMXNRR012ZGMyejcrNG9w?=
 =?utf-8?B?eWdvZkY3ZjBBaGJpVHhOc0xvOVAycjJGL0dGZXVZNEdMVEp6OUhlWmc5M1BY?=
 =?utf-8?B?Y2ViU1lIVFUvaitXNFQwRnljT1NxaERDNHU4VnVqQ3ZaS280NHJCZzhjaFdS?=
 =?utf-8?B?RFNDMXVQK0VDRFpaMlo1aC9ZMCtWOE9HbnZKU1lPMTBpaEYyOWh6Qm1PcXcw?=
 =?utf-8?B?T2lWdm90ZHZBd2ZHTEZrVGppOWE1WWdiTVhjSXJ6TnFWQXdqY0UrUFZqbnRU?=
 =?utf-8?B?aEVuYXlYUEJTOCtXZmZGUE5VdlFnZUEvaW5aVkxJd2V6Uk9CZHZ0NzluaG55?=
 =?utf-8?B?WW1GajE4dUxYdnlMdEFhKzJsNTQvZ3FYbm1MM1JqN2I1eE1Sck82NGlYNU1Z?=
 =?utf-8?B?dXAwanlPOThhaXIrVEltb2dkQWtZaktOUElXZ2ljT3FNOU85S25sSmRKbHh4?=
 =?utf-8?B?bklzQkdkalZLbnVmSjZFRWsrQWp1ejMyTXBrR00yVzNQcDZOaVhram1pVDdm?=
 =?utf-8?B?M1p1ckkrRXF0dWV3NHFIeitDTWVESXhyeHpPeXdrMi9heDNHYUhHem5LQ25t?=
 =?utf-8?B?OEhRNXZpb2xpWXprOUQrVTFUSDFoR2FVNWVsSTRDemZLbnExMnVnb0F2Qm5k?=
 =?utf-8?B?alhlOEdZQjczMC9rSE55QU9lTnozcGJZZDdkQTJxSDA5dHZzWXdsaVF4VFow?=
 =?utf-8?B?K0hmMW9SZ2llWlF0TExTTm9SUlZWbVZUcFZHaVBtZitIZXkvbkVuL0ZHMTRP?=
 =?utf-8?B?YmR6c0tUUTdVQXliTGpoZ1JTdVhJOGNaUkJEWkVWTDYrM0lqeURrNXlsMjZM?=
 =?utf-8?B?bVhtMWdSUU91RTJuMlBpNjFQVWt0dUtXcE1MRVlra2IvR1lwTjErWnZrbm1O?=
 =?utf-8?B?elEzUFVqZzNFTnQvZTFxMDdJdlhnYmNteDhnYjI4UkVxQmFUTXZ5VklXd2N5?=
 =?utf-8?B?bFFWM28yM3dVd2xYS0JWMG4yNm5DbGR6QXZzSHdSZ1IxR1Zmcythd05aS2x1?=
 =?utf-8?B?encxT1M0RVA0elFmT1hRK3FxZDU4Yis0SmdiQ05sODl6bWc2SEx6Q2VDU05r?=
 =?utf-8?B?SE5QUmJkZ3Y2dXJ6VFVzNjBCUCszK2VpdVRGS0dOU1JnT1MvM24xWnJscUhK?=
 =?utf-8?Q?1pUclCSa8aiR5AX/c7d9oxJi9AkrQoeHypRRUaJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24549ec8-a8a1-4a2f-1cde-08d95d69f468
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 08:19:50.1359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tm86EKwXru9MmthQU6V+L+g1TZjZ7ukqo135raKWZt16nPyz4vW0nnUS0TnDtzHN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSAzOjM4IFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBuaWxzLndh
bGxtZW5pdXNAZ21haWwuY29tOyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgNi83XSBkcm0vYW1kL3BtOiBkcm9wIHVubmVjZXNzYXJ5
IG1hbnVhbCBtb2RlDQo+IGNoZWNrDQo+IA0KPiANCj4gDQo+IE9uIDgvMTIvMjAyMSAxMjoxNiBQ
TSwgUXVhbiwgRXZhbiB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiA+DQo+
ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgQXVndXN0
IDEyLCAyMDIxIDI6MTYgUE0NCj4gPj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IG5pbHMud2FsbG1lbml1
c0BnbWFpbC5jb207IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBWMiA2LzddIGRybS9hbWQvcG06IGRyb3AgdW5uZWNlc3NhcnkgbWFu
dWFsDQo+IG1vZGUNCj4gPj4gY2hlY2sNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24gOC8xMi8y
MDIxIDk6MzEgQU0sIEV2YW4gUXVhbiB3cm90ZToNCj4gPj4+IEFzIHRoZSBmYW4gY29udHJvbCB3
YXMgZ3VhcmRlZCB1bmRlciBtYW51YWwgbW9kZSBiZWZvcmUgZmFuIHNwZWVkDQo+ID4+PiBSUE0v
UFdNIHNldHRpbmcuIFRodXMgdGhlIGV4dHJhIGNoZWNrIGlzIHRvdGFsbHkgcmVkdW5kYW50Lg0K
PiA+Pj4NCj4gPj4+IENoYW5nZS1JZDogSWE5ZDc3NjE0MWVjNGFhMzkyNTVhY2NiZjAwZDdlN2Vk
ODFjODQyNGQNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5j
b20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvc211X3YxMV8wLmMgfCAxMiArLS0tLS0tLS0tLQ0KPiAtDQo+ID4+PiAgICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFfMC5jDQo+
ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc211X3YxMV8wLmMNCj4g
Pj4+IGluZGV4IDkwMDE5NTI0NDJiYS4uMjBlY2UwOTYzZjUxIDEwMDY0NA0KPiA+Pj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjExXzAuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjExXzAuYw0KPiA+Pj4g
QEAgLTEyMDgsOSArMTIwOCw2IEBAIHNtdV92MTFfMF9zZXRfZmFuX3NwZWVkX3B3bShzdHJ1Y3QN
Cj4gPj4gc211X2NvbnRleHQNCj4gPj4+ICpzbXUsIHVpbnQzMl90IHNwZWVkKQ0KPiA+Pj4NCj4g
Pj4+ICAgIAlzcGVlZCA9IE1JTihzcGVlZCwgMjU1KTsNCj4gPj4+DQo+ID4+PiAtCWlmIChzbXVf
djExXzBfYXV0b19mYW5fY29udHJvbChzbXUsIDApKQ0KPiA+Pj4gLQkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4+PiAtDQo+ID4+DQo+ID4+IFRoZXJlIGlzIGEgRkFOX0NPTlRST0xfTk9ORSBtb2RlIHdo
ZXJlIGl0IGlzIHNldCB0byBmdWxsIHNwZWVkLiBJcw0KPiA+PiB0aGF0IGFmZmVjdGVkIGJ5IHRo
aXMgY2hhbmdlPw0KPiA+IFtRdWFuLCBFdmFuXSBUaGlzIGNoZWNrIHdhcyBkZXNpZ25lZCB0byBi
bG9jayAiYXV0byIgbW9kZShsaWtlIElmIGl0IHdhcw0KPiB1bmRlciBhdXRvIG1vZGUsIHRoZXNl
IG1hbnVhbCBzZXR0aW5ncyB3aWxsIGJlIG5vdCBwZXJtaXR0ZWQpLg0KPiA+IFRoZSBGQU5fQ09O
VFJPTF9OT05FIG1vZGUgaXMgbm90IGFmZmVjdGVkIHdpdGggYW5kIHdpdGhvdXQgdGhpcw0KPiBj
aGVjay4NCj4gPg0KPiANCj4gVG8gc2V0IEZBTl9DT05UUk9MX05PTkUsIGJhc2ljYWxseSBhbHNv
IG5lZWQgdG8gdHVybiBvZmYgYXV0byBtb2RlIGFuZA0KPiBtYW51YWxseSBzZXQgdG8gMTAwJSBz
cGVlZC4gSWYgd2UgdGFrZSBvdXQgdHVybmluZyBvZmYgYXV0byBtb2RlIGhlcmUsDQo+IHByb2Jh
Ymx5IHRoYXQgcGFydCBuZWVkcyB0byBiZSBoYW5kbGVkIGVsc2V3aGVyZS4NCltRdWFuLCBFdmFu
XSBPSywgSSBzZWUuICBXaWxsIGFkZCB0aGF0IGZvciBBTURfRkFOX0NUUkxfTk9ORSBpbiBzbXVf
djExXzBfc2V0X2Zhbl9jb250cm9sX21vZGUoKS4gVGhhdCdzIHRoZSByaWdodCBwbGFjZSBmb3Ig
bW9kZSBzd2l0Y2hpbmcuDQoNCkJSDQpFdmFuDQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+
ID4gQlINCj4gPiBFdmFuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+Pg0KPiA+
Pj4gICAgCWR1dHkxMDAgPSBSRUdfR0VUX0ZJRUxEKFJSRUczMl9TT0MxNShUSE0sIDAsDQo+ID4+
IG1tQ0dfRkRPX0NUUkwxKSwNCj4gPj4+ICAgIAkJCQlDR19GRE9fQ1RSTDEsIEZNQVhfRFVUWTEw
MCk7DQo+ID4+PiAgICAJaWYgKCFkdXR5MTAwKQ0KPiA+Pj4gQEAgLTEyMzcsMTEgKzEyMzQsNiBA
QCBpbnQgc211X3YxMV8wX3NldF9mYW5fc3BlZWRfcnBtKHN0cnVjdA0KPiA+PiBzbXVfY29udGV4
dCAqc211LA0KPiA+Pj4gICAgCSAqLw0KPiA+Pj4gICAgCXVpbnQzMl90IGNyeXN0YWxfY2xvY2tf
ZnJlcSA9IDI1MDA7DQo+ID4+PiAgICAJdWludDMyX3QgdGFjaF9wZXJpb2Q7DQo+ID4+PiAtCWlu
dCByZXQ7DQo+ID4+PiAtDQo+ID4+PiAtCXJldCA9IHNtdV92MTFfMF9hdXRvX2Zhbl9jb250cm9s
KHNtdSwgMCk7DQo+ID4+PiAtCWlmIChyZXQpDQo+ID4+PiAtCQlyZXR1cm4gcmV0Ow0KPiA+Pj4N
Cj4gPj4+ICAgIAkvKg0KPiA+Pj4gICAgCSAqIFRvIHByZXZlbnQgZnJvbSBwb3NzaWJsZSBvdmVy
aGVhdCwgc29tZSBBU0lDcyBtYXkgaGF2ZQ0KPiA+Pj4gcmVxdWlyZW1lbnQgQEAgLTEyNTcsOSAr
MTI0OSw3IEBAIGludA0KPiA+PiBzbXVfdjExXzBfc2V0X2Zhbl9zcGVlZF9ycG0oc3RydWN0IHNt
dV9jb250ZXh0ICpzbXUsDQo+ID4+PiAgICAJCQkJICAgQ0dfVEFDSF9DVFJMLCBUQVJHRVRfUEVS
SU9ELA0KPiA+Pj4gICAgCQkJCSAgIHRhY2hfcGVyaW9kKSk7DQo+ID4+Pg0KPiA+Pj4gLQlyZXQg
PSBzbXVfdjExXzBfc2V0X2Zhbl9zdGF0aWNfbW9kZShzbXUsDQo+ID4+IEZET19QV01fTU9ERV9T
VEFUSUNfUlBNKTsNCj4gPj4+IC0NCj4gPj4+IC0JcmV0dXJuIHJldDsNCj4gPj4+ICsJcmV0dXJu
IHNtdV92MTFfMF9zZXRfZmFuX3N0YXRpY19tb2RlKHNtdSwNCj4gPj4gRkRPX1BXTV9NT0RFX1NU
QVRJQ19SUE0pOw0KPiA+Pj4gICAgfQ0KPiA+Pj4NCj4gPj4+ICAgIGludCBzbXVfdjExXzBfZ2V0
X2Zhbl9zcGVlZF9wd20oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4+Pg0K
