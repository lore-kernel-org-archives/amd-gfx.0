Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0FFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 21:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0D360F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 21:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE0D360F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7258489E3F;
	Mon, 27 Sep 2021 21:13:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41C289E3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 21:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+I1yrByr5x/6xU7jT1i9euf+1hRaAlJ86qDMR/Wj3RYj2GHsOHB882zXnq6epJ1kqx82E/Dd1iFfjNUucBinV8cZqv31pSJIkPv6uCKYcx9FksTit6lcVrPJo47Jh639iOIzexP0n6aDC/ZtoVGDsadOQXFBlJa8NUCKESEUK+54cWKxOx2Fm1wZVZiND9cSi65YwF4l89e2qded+zwcQHClgKwyW9Cb/CGT6wDP5OfFvhVcMjzFXB0k1Vx5ABJWqhkbmuC5Kzj99yUJbrIUjLZyKT2kx6Mxg/uP4GQF466FNkRe/7bMt85NbyJg+vici0Y+ZnvLT0VykqTxgBLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QhcLB9QzLR92igGPRqiWKt4naIuTmkwivzyIBAs5EzM=;
 b=JLww5FS1ow7S8m7hrJDUERHUHw2beHIBEwAgPHYCAb5M7TDzei7992fM22XaJoMTQTB+li5zD0VrxoQOS/4o1j/e6XIHTVyK3iN1uN3hgoccSW4fY0ijev+8qJvQOLjvn8fZ66LEYGaQviVMa+LCT1jp/ZugaH4lUXFMd2uhn6dWclZu+tW3cPsff4y1aAonljGjsLx0GWrBKWWTHDkjsxBmKRWyLaDQ6M5DzBAwyDkLjbcFlub5mXdngz09+rTEDeY3Ix0lCsHuWqwTHkruiUopJQ2DR/5UBYyK7Dp/nNuBkYZObKBOvQ5+f/y6tTok2nBD3bQ+MQCcJHC0GnUvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhcLB9QzLR92igGPRqiWKt4naIuTmkwivzyIBAs5EzM=;
 b=CrVk11kQHz2jGdqJMa/8UHgegaJPTG9T3HdBaTAFV+4/CmBe8cUDTQ7AboVgqL1nn2FKu6utCupzuBgPenNqffsrsiv9n18OakdKEb4LMt8vJUqQTBijoYZ6pQEEuFXt4jb4hZIg+U7idOi9CINjjL6nCAssNrTKLnTzlTxQKaY=
Received: from CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 21:13:50 +0000
Received: from CH0PR12MB5201.namprd12.prod.outlook.com
 ([fe80::c09b:77fe:f749:15c6]) by CH0PR12MB5201.namprd12.prod.outlook.com
 ([fe80::c09b:77fe:f749:15c6%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 21:13:49 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lei, Jun"
 <Jun.Lei@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH 02/02] drm/amd/display: add cyan_skillfish display support
Thread-Topic: [PATCH 02/02] drm/amd/display: add cyan_skillfish display support
Thread-Index: Adez4CHKpP4tWiahQrm1YcExrvIVaAAARnUAAADJnLA=
Date: Mon, 27 Sep 2021 21:13:49 +0000
Message-ID: <CH0PR12MB520100AB5D6B518327EEF7489EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
References: <CH0PR12MB5201597F1A8806EA0456548D9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
 <CADnq5_PoDA1C72AwVBDibA947=U0ojWho7bQXk6VJvnB2jmhyg@mail.gmail.com>
In-Reply-To: <CADnq5_PoDA1C72AwVBDibA947=U0ojWho7bQXk6VJvnB2jmhyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a91fa778-336b-4810-b45f-28acc879c2a7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-27T21:12:39Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c9ced2c-096c-4a00-4d87-08d981fbb378
x-ms-traffictypediagnostic: CH0PR12MB5026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5026D95B3007E6B41EBA1B4B9EA79@CH0PR12MB5026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TL+6Ya8jc/Rgvo0Lb6V/ZGZWntKivwPYmSavgmY5WIkvTbnR5LAC4kpP++5qBBy0DLgS5hdtk3SJ/nkToBhOnE6xuvnren7b6TuzZ1whDyr8i/U8oDvlKUtvmkHe1+nJKdTQ7NtvEQjn7C8EicLeJud9rZtYOnjtmpwc9yELugV7I1mkOq/smFppOlivyZHqztWzh4dBW1JghJTMgWFQree5UJECpELTKATqYryK5l9zGahzZrMcXpIF7XryLfa71Tl089FlhL9sxT0G4rC7Dpm7zpt+ZemxpwBA1SuETuTFmSjrmmAijxfpikNxcSsE4v2EHOtoqx3dVwVWYkk3VclqNGUq9vaBDymhjRQT3kSLzjPIfGzTsZ00zb7Zy8GGnS/i4iRiAXKxmq4jV2CEkzxGZp4BJ1KEpKI58/6QSMcG7DxDl8Snw4iLN/gyo/mGHfhHzKqvrEZYYGDhbXWkU0L3Gr/l324CkVVy4+AWu+7MiVXjgdYjVaD4Rbup8KAlSJqddF5KHoMEVNIlKQn+y64e2VwwfYz/Vf448sgJ3nJBGwRjzksGIUmEf8G4bR6XLAg9niBs1gSUOSqHC4KPKPkFCnDYoSdix71/yJUYcYjmOUm/Z/7/iBEbKNgojyYIf1qMxfQDgVwPcHuHbsQOrb8/fsKpsvBa+qTyzX1S8+v9XrP38moqW3PSqLMTG2I1oTFECf8ltABtnh/k8zFitg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(86362001)(4326008)(54906003)(53546011)(6916009)(71200400001)(316002)(66476007)(52536014)(66556008)(64756008)(83380400001)(66446008)(76116006)(8936002)(33656002)(38100700002)(8676002)(66946007)(7696005)(508600001)(38070700005)(2906002)(9686003)(55016002)(5660300002)(186003)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlNLZnBxWmp1S0FXWWFNWGk2TFYvckhXVVRzMWlteFJwVGVKVEdSUlRlVkJV?=
 =?utf-8?B?RlNqRkNtdzc5M3cyRWlkTHJyeXg1R1htbm83b3ZCTDRXWEp0L0pmSTkzMVNH?=
 =?utf-8?B?QjBZd3VHOHBYUGlKaVJTNENYdlZFTXhqckEvclorUjhNUDNvMG1pWE5lejRY?=
 =?utf-8?B?NHpRSTNWM0dpa3lTZlhJRXl3RGJhNjUrNTVTVFkreUtEOGg4c2twWGxNS3RD?=
 =?utf-8?B?TTY1c09ObHlCeU9tRU9JWlk5cXBMS3ZZbjJVZVduZUEzMS9LZFBJQjJyZVVJ?=
 =?utf-8?B?aE1INDdIRFU3Ukp4VFlBMkFsUnRvcjBqQjN0T1Q0RFI0VlV1VVlYQ2hhWTJs?=
 =?utf-8?B?Nk94b0dGTkl4UkcxNWd1RitVRXgxT0UvdGd3eTlFUHRMU0tYMU0vR2N0aUpG?=
 =?utf-8?B?ZTNHYk82RHpYalpQZ2hFaFlMcGExczFoVk1oZXk5RUdhV1dzTGl3UG9reXVj?=
 =?utf-8?B?R1BWcitaWmFJeHRRcWZNeHNWWm1VWk55MDhvcDkzUEsrS28yRWlWRzQ5VE5J?=
 =?utf-8?B?RExBK3gvQ1R3WGJNeUtNZnBsbWczbXJYSGdnN1BZc1VXeTc0N0NJaWpyR2Yy?=
 =?utf-8?B?TGQvYzBKVXdYQStNMEpQNjJsUDdPaGlOQ0FLVHVERk9LbXpDVHFiK0M5VVU3?=
 =?utf-8?B?M0ZlOHRsOGt5Zi9ZQnJZdElNOEhFZWRDdi9TVTd4ZnFlYmNqRU5IcndqSlVy?=
 =?utf-8?B?TVVOVVdRanF4ZnA2SGp0enFrYzlyZTFzdUExU3dKdEJ2ZmVvaXdodUNkaUhz?=
 =?utf-8?B?ZHp2VzNTWTlJcEtsWGxxMjBQNjB1Wm5YaS8xQTIyVW8xTUhWUy9GTVJMcjBv?=
 =?utf-8?B?dDNlQjJEbDAxMk5RaUhaMGIza21wVCt2RGJOWmJNZ0pSbnRZbzdvQ2JNc29p?=
 =?utf-8?B?RjlodjBIbXYzOHdQbW5EUm9nd0Q5VzNNbENLWSt0NXZSUHVIT2FSbUFFT21G?=
 =?utf-8?B?WlAvVnhuTTQra253ZzIzZTBvOE5sR3BUY2xUYnNOeWFhaXBNUTVZd2pLR1ZF?=
 =?utf-8?B?bERxV29YdjVBV3dSQ1BGdnM4LzN1bzcwWTRSZEpKZnpzMXVpVDlQbE1wNTZB?=
 =?utf-8?B?MGVhN2RJdzhHM21RVEUzYUNZMnVPTDdWd0sxc1RYZkp4UC82RmpuRE1reWRT?=
 =?utf-8?B?VUwxZW5qUGVwdUhrK2RMZ1F3Q0dCakhTQ1JLMGd5R21HVzhUVWVxb2xaSEhh?=
 =?utf-8?B?ZDI4Nm5Iakd6ZUx1MXRkb2tWbG9lMndTN09nM0w1cDJsNXl3MFN2eVJMcmZw?=
 =?utf-8?B?NXhwMHV3N3VrdU55YUc4bERJRDZHMmc0bmtaT2E3eEhwY2pLOVdTSHYydWZJ?=
 =?utf-8?B?eXg4dWhtOUdUSmxNd0t5SGdJV0NpUi9CSUUrQlpSRlZVQXJOd0xIYzVDWXBn?=
 =?utf-8?B?cnluZjBlY2VzNXVHbDZzd3ZUSUx3YVR4TVpFbUhpT3NjZWU4aVNnM1MzM1c4?=
 =?utf-8?B?OVRuQUZHMkY2eWZONkE4aXErdVd5Y0xzZlZMMUg4UzB6WjFQdjl0ejBKNGd1?=
 =?utf-8?B?ejJJamZTQkNVL3c2QXE2S3gvcTFhMTlXOFY5ZU5pakR2Y0xCUFpZRGdVZFYv?=
 =?utf-8?B?YjlYQkdrNThpWHRVWTlTT2xaNUFXYkpKZGg1b2t0KytGb0haRmRvOUdvRnF0?=
 =?utf-8?B?SUxNYUh4TVpuR1ZwcXhMeldHUlozUGRYTTZnVUp1U0dYdjEvQ0VtZzgxWnU0?=
 =?utf-8?B?OHdUeG9SVnlvOU9OWC93UWxMUGpuMWpmbDJzUjZGVkxHMVJWaE5zdjFETXdq?=
 =?utf-8?Q?nCJImtGoUbqpCvVbK5536G7URS6mDu+TJ9+R9sO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9ced2c-096c-4a00-4d87-08d981fbb378
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 21:13:49.4877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJa3djEe+R9SBV/2mJj+gE4x8NJ3UwKkP0DGe3yl6EPTs/VIE1Cie7WeVSWd/pWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMS9TZXB0ZW1iZXIvMjcs
IE1vbmRheSA0OjUwIFBNDQo+IFRvOiBMaXUsIFpoYW4gPFpoYW4uTGl1QGFtZC5jb20+DQo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBDaGFybGVuZSA8Q2hhcmxlbmUu
TGl1QGFtZC5jb20+Ow0KPiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMZWks
IEp1biA8SnVuLkxlaUBhbWQuY29tPjsgUGlsbGFpLA0KPiBBdXJhYmluZG8gPEF1cmFiaW5kby5Q
aWxsYWlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMi8wMl0gZHJtL2FtZC9kaXNw
bGF5OiBhZGQgY3lhbl9za2lsbGZpc2ggZGlzcGxheQ0KPiBzdXBwb3J0DQo+DQo+IE9uIE1vbiwg
U2VwIDI3LCAyMDIxIGF0IDQ6NDMgUE0gTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPiB3cm90
ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBbV2h5XQ0KPiA+IGFkZCBkaXNwbGF5IHJl
bGF0ZWQgY3lhbl9za2lsbGZpc2ggZmlsZXMgaW4uDQo+ID4NCj4gPiBtYWtlZmlsZSBjb250cm9s
bGVkIGJ5IENPTkZJR19EUk1fQU1EX0RDX0RDTjIwMSBmbGFnLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBaaGFuIExpdSA8emhhbi5saXVAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ2hhcmxl
bmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4NCj4gPiBBY2tlZC1ieTogSnVuIExlaSA8anVu
LmxlaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA8c25pcD4NCj4NCj4gPiBAQCAtMTQ1NywzNCArMTQ2
MCwzMyBAQA0KPiA+ICAjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9TRUNVUkVfRElTUExBWSkN
Cj4gPiAgICAgICAgIGFkZXYtPmRtLmNyY19yZF93cmsgPQ0KPiBhbWRncHVfZG1fY3J0Y19zZWN1
cmVfZGlzcGxheV9jcmVhdGVfd29yaygpOw0KPiA+ICAjZW5kaWYNCj4gPiAtICAgICAgIGlmIChk
Y19lbmFibGVfZG11Yl9ub3RpZmljYXRpb25zKGFkZXYtPmRtLmRjKSkgew0KPiA+IC0gICAgICAg
ICAgICAgICBpbml0X2NvbXBsZXRpb24oJmFkZXYtPmRtLmRtdWJfYXV4X3RyYW5zZmVyX2RvbmUp
Ow0KPiA+IC0gICAgICAgICAgICAgICBhZGV2LT5kbS5kbXViX25vdGlmeSA9IGt6YWxsb2Moc2l6
ZW9mKHN0cnVjdCBkbXViX25vdGlmaWNhdGlvbiksDQo+IEdGUF9LRVJORUwpOw0KPiA+IC0gICAg
ICAgICAgICAgICBpZiAoIWFkZXYtPmRtLmRtdWJfbm90aWZ5KSB7DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgRFJNX0lORk8oImFtZGdwdTogZmFpbCB0byBhbGxvY2F0ZSBhZGV2LT5kbS5k
bXViX25vdGlmeSIpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+
ID4gLSAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBhZGV2LT5kbS5k
ZWxheWVkX2hwZF93cSA9DQo+IGNyZWF0ZV9zaW5nbGV0aHJlYWRfd29ya3F1ZXVlKCJhbWRncHVf
ZG1faHBkX3dxIik7DQo+ID4gLSAgICAgICAgICAgICAgIGlmICghYWRldi0+ZG0uZGVsYXllZF9o
cGRfd3EpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBEUk1fRVJST1IoImFtZGdwdTog
ZmFpbGVkIHRvIGNyZWF0ZSBocGQgb2ZmbG9hZA0KPiB3b3JrcXVldWUuXG4iKTsNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+
ID4gLQ0KPiA+IC0gICAgICAgICAgICAgICBhbWRncHVfZG1fb3V0Ym94X2luaXQoYWRldik7DQo+
ID4gLSNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikNCj4gPiAtICAgICAgICAgICAg
ICAgaWYgKCFyZWdpc3Rlcl9kbXViX25vdGlmeV9jYWxsYmFjayhhZGV2LA0KPiBETVVCX05PVElG
SUNBVElPTl9BVVhfUkVQTFksDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZG11Yl9hdXhf
c2V0Y29uZmlnX2NhbGxiYWNrLCBmYWxzZSkpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICBEUk1fRVJST1IoImFtZGdwdTogZmFpbCB0byByZWdpc3RlciBkbXViIGF1eCBjYWxsYmFjayIp
Ow0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4gLSAgICAgICAg
ICAgICAgIH0NCj4gPiAtICAgICAgICAgICAgICAgaWYgKCFyZWdpc3Rlcl9kbXViX25vdGlmeV9j
YWxsYmFjayhhZGV2LA0KPiBETVVCX05PVElGSUNBVElPTl9IUEQsIGRtdWJfaHBkX2NhbGxiYWNr
LCB0cnVlKSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIERSTV9FUlJPUigiYW1kZ3B1
OiBmYWlsIHRvIHJlZ2lzdGVyIGRtdWIgaHBkIGNhbGxiYWNrIik7DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gPiAtICAgICAgICAgICAgICAgfQ0KPiA+IC0jZW5k
aWYNCj4gPiArICAgICAgIGluaXRfY29tcGxldGlvbigmYWRldi0+ZG0uZG11Yl9hdXhfdHJhbnNm
ZXJfZG9uZSk7DQo+ID4gKyAgICAgICBhZGV2LT5kbS5kbXViX25vdGlmeSA9IGt6YWxsb2Moc2l6
ZW9mKHN0cnVjdCBkbXViX25vdGlmaWNhdGlvbiksDQo+IEdGUF9LRVJORUwpOw0KPiA+ICsgICAg
ICAgaWYgKCFhZGV2LT5kbS5kbXViX25vdGlmeSkgew0KPiA+ICsgICAgICAgICAgICAgICBEUk1f
SU5GTygiYW1kZ3B1OiBmYWlsIHRvIGFsbG9jYXRlIGFkZXYtPmRtLmRtdWJfbm90aWZ5Iik7DQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAr
ICAgICAgIGFkZXYtPmRtLmRlbGF5ZWRfaHBkX3dxID0NCj4gY3JlYXRlX3NpbmdsZXRocmVhZF93
b3JrcXVldWUoImFtZGdwdV9kbV9ocGRfd3EiKTsNCj4gPiArICAgICAgIGlmICghYWRldi0+ZG0u
ZGVsYXllZF9ocGRfd3EpIHsNCj4gPiArICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJhbWRncHU6
IGZhaWxlZCB0byBjcmVhdGUgaHBkIG9mZmxvYWQNCj4gd29ya3F1ZXVlLlxuIik7DQo+ID4gKyAg
ICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
ICAgYW1kZ3B1X2RtX291dGJveF9pbml0KGFkZXYpOw0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdf
RFJNX0FNRF9EQ19EQ04pDQo+ID4gKyAgICAgICBpZiAoIXJlZ2lzdGVyX2RtdWJfbm90aWZ5X2Nh
bGxiYWNrKGFkZXYsDQo+IERNVUJfTk9USUZJQ0FUSU9OX0FVWF9SRVBMWSwNCj4gPiArICAgICAg
ICAgICAgICAgZG11Yl9hdXhfc2V0Y29uZmlnX2NhbGxiYWNrLCBmYWxzZSkpIHsNCj4gPiArICAg
ICAgICAgICAgICAgRFJNX0VSUk9SKCJhbWRncHU6IGZhaWwgdG8gcmVnaXN0ZXIgZG11YiBhdXgg
Y2FsbGJhY2siKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gPiArICAgICAg
IH0NCj4gPiArICAgICAgIGlmICghcmVnaXN0ZXJfZG11Yl9ub3RpZnlfY2FsbGJhY2soYWRldiwg
RE1VQl9OT1RJRklDQVRJT05fSFBELA0KPiBkbXViX2hwZF9jYWxsYmFjaywgdHJ1ZSkpIHsNCj4g
PiArICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJhbWRncHU6IGZhaWwgdG8gcmVnaXN0ZXIgZG11
YiBocGQgY2FsbGJhY2siKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gPiAr
ICAgICAgIH0NCj4gPiArI2VuZGlmDQo+ID4gKw0KPg0KPiBUaGlzIGNoYW5nZSBhYm92ZSBsb29r
cyB1bnJlbGF0ZWQuICBQbGVhc2UgZG91YmxlIGNoZWNrIHRoaXMgaXMgY29ycmVjdC4NCg0KSGkg
QWxleCwgc29ycnkgaXQgd2FzIG15IGJhZC4gWWVzLCB5b3UgYXJlIHRvdGFsbHkgY29ycmVjdCwg
dGhhbmtzIGEgbG90IGZvciBjYXRjaGluZyB0aGF0LiBMZXQgbWUgc2VuZCBvdXQgbXkgcGF0Y2gg
djIgc29vbi4NCg0KVGhhbmtzLA0KWmhhbg0KDQo+DQo+IEFsZXgNCg==
