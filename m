Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E1AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 18:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFF310E320;
	Tue, 11 Jan 2022 18:58:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF42D10E320
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 18:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9VIK6FrHsE9H2ZvmA4I4UoGsDxr38LuZ1/SRgJpU12mNF9h9R0kLPXhDfl1CpZ2CYzGhpKNwIht8ReiG32Z92UGuGobx9OFncTXg7omIdDFTt2LPprE7DceN5IIV9cKYOc2fwE99KkSafZGEHGCKrP/SBKu+uVCIgFf+bvQC6ZdaxztyWs16Te3U5C6MfUGKfkR7X4RzEdMVixjlCSSkx3NxhIVy8BHgYyYvBcTsrDg2CFd/rFS9Yz3FcAHTWAzhi1mWj9QS/YNZZNb/pSWH4JW6mghcuoQQV4JYbhL5oTIKHzLh0pgx41W0R0yRlR25HoLV5XDiFZcXwjXBR2bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctSA+0NGeFoEMNFS46gi6NE0SLunqU6+wtcYnpVh0wc=;
 b=kbp5dA6oYwn3FUkOZLoumR19wg/YYrHRsJeZiIiq9c2Dyfv2drGWoNDxzpCPDZUrs4s3VCaZO2qjtmHctWemhgCmG5FZcQhgrloB3BRntoRZnurcDVKwI+nyH/egfo4vvUgLq5nnAForF14r/VYkblpftiBOUExTyyAgk1naPYwcBsEZ0IxBvsZorTrZwlAeRV5fXQMPD4NLT8wbEwaDR31KxsEZdN/chal1M6LBL730dyaDJfr4IFOQRWtdXwKnH3/deNyVOUJJDflFWeZVrCAUxRIarMlQ889wmclQNcBL4sHGvjBmqoiHCS2s530i1Cr/BMY6pW9mFLYPFMtyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctSA+0NGeFoEMNFS46gi6NE0SLunqU6+wtcYnpVh0wc=;
 b=VJtrzPeujEGHiZc3KJN4PGt7cewcj5wtQsumctuInKxcZXC9n6psZGd5Sj4UyCXlBgXTAitXvqamO12tITuo6RWFLpxhjcZ0DqJHh/MOqJNezBrzr0e+oLqxZMAOl7eDBa038NveX92CmpY8pnNSRzpau+0gKhz8y8O/4bfQfaI=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 18:58:05 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 18:58:05 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: apply s0ix codepath to more cases
Thread-Topic: [PATCH] drm/amd: apply s0ix codepath to more cases
Thread-Index: AQHYBxDUUoy94WfIh0eMVwOU3PMYuKxeKy6AgAAAVRA=
Date: Tue, 11 Jan 2022 18:58:05 +0000
Message-ID: <BL1PR12MB51578E35FBFF49982D74961CE2519@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220111172940.2561-1-mario.limonciello@amd.com>
 <a40849f0-aee5-9f8e-aca1-a95a92ef75b2@amd.com>
In-Reply-To: <a40849f0-aee5-9f8e-aca1-a95a92ef75b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T18:55:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=afa68ad4-2f0a-4693-b3aa-92ddbf95aaab;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-11T18:58:03Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 68df8e5e-4cbc-482c-b710-3d5d6770fa5d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2f78939-d3b8-4784-ec18-08d9d5344cce
x-ms-traffictypediagnostic: BL1PR12MB5125:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51258B6624389CA25307C2F3E2519@BL1PR12MB5125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:260;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDaCmGZJyRtAmnnXSpa/H8wBTqbPqgsEF2Vt4BsaQjKdIag7QwjxM+0u8Bzs1rRuL8vge04F8hLyKkiLJgVf6KSDx44Mc8x4yUoCqa3ykk83mJyTLTX18d1jkbu9PxGnrQPqlSHx0703ntxBlit00MTK5yc5RZgTfXQCIOMtDiny2fOZAM2/ur8mA51ycwPT82Z6N7cQUUVaq5LY5d8Yd9OGxVLMMYOnJzITH+Qn7uIVj/FNL1oNc2zGkY5DSa4vOqX5PISP/7YRGccp4ZE9gohKZ8gCa/HAOxsbWLnIfjRspjmmXDrKvJt/mg5rOZxOP/v1QAUMkO9UX8sHmPrnjGtuD64qDxdASI09dK93/yhNjlRa2mB2AlHV1P8XJtPk1f/w8XUunSZap+LOLPxSqNGIZnK4ppkRQSeye/PQlks4uTKky+4pCh+9gu0sYQwcEgbfQK6yI7ynEp0J6PH3NAnXD8pQe6uYz4KuLmPW5o1nsZ9AJWjEyDfo39/030c4ojj6GY+KkadigCA+Jz3pBCmISIFa9WI3RBJ9QJ22F247xfi/m+K5j376oh3Pgsw7Ww+k9htwkmF/wTOSML6UZ1qrA6xI1lTLGo8tJVpt+QOm7q2wrfpchOW8Zn/i4IY78+TrioASeoMJQL4cVOV5iRJrD4pDEjbwVCOXUeSiOUaud5c4JFcxqmMUQtFZCn446suyUBKPe9KauZppR1uXhPvtX5VWJYNBMAJOBGlPt/ODCt18sRHbmwYWCNqtC8/pltdniKE/Eb2nd8b6tSDNyFz29StWM62MIf26z3Ohg54cZe6tUUi84Er7rAYIx8E9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(83380400001)(110136005)(316002)(38070700005)(2906002)(38100700002)(122000001)(9686003)(53546011)(6506007)(52536014)(33656002)(508600001)(8676002)(966005)(8936002)(4326008)(71200400001)(186003)(26005)(7696005)(86362001)(55016003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW16M0JGRXFWdUFzamFJa0U4QXRwUitzaVNSMkY2RTBUUmpSdXN0Szg1Zmo5?=
 =?utf-8?B?a2E5YXozYUxvbkd4OVZId2FMc0F2WngrODBYcVBtd3NtN0IweUhUM1kvSzl4?=
 =?utf-8?B?QndTT0JsaUEvRm5vRU4xd3BMelJOc1BYRG9kSyttcmZiUlN2WTQ0bDc4WUc2?=
 =?utf-8?B?ZlZpcmVZbE5HU08yOFZTbUNKUG8zaURjbkFBeUJkMXdoRkdEeDhIU1ltdUpr?=
 =?utf-8?B?YnZJSFdOampGcHo1RENLUlA3b3ExekFuc01CQVA2OWFmQWQxQXNwNUVkSnAz?=
 =?utf-8?B?N3FZRWRXcHhSczdYcVdqSGJjTFdMRkI2MVRacjdNam0rVDlpWEtUS3JhZ254?=
 =?utf-8?B?SzdnT3d5V214RGJ5c3dlL2pVWEFLbkxNa1JnMUdxZUE2MEJIMjA0Q2drZCtL?=
 =?utf-8?B?OWZKa3ZkK05WOEVhNkhhK0dTRTNLZk0rYitablFZU21PMHcyVzhZa2pkTVFt?=
 =?utf-8?B?NXlwenlQTlp6SE9LNHEwMXZ4TnFNUkFGc0hueFNHWXVjb0ZobDMrSSsxVU9J?=
 =?utf-8?B?WVZPbU9LRkcyTVdGMUd4dHkzUVFjZWUveHlzcTNqTUdmNmZhdnBLSWgxdEh6?=
 =?utf-8?B?K0JhTUpFUmJQeHdIbWM5cWNpeUNRSEdSMk5zWTdmZVBOY0U0dEhpeDlBSUZO?=
 =?utf-8?B?SDU2WUVUeEFZVHIyVVpkR21kNi9ZQzJKbDc3NjluQ0YyYXU0SWgzSXZXMzhF?=
 =?utf-8?B?ZnBSWHozakdMR1hkWTIvUXg1cG93T2ZPNVdvMXpHQmo4cUM1QTdjb3lzMFNP?=
 =?utf-8?B?ODRBVHlOU1dYakxSREFJUG9OYTdEY1h2MWpFOXUvdUxSbHRMYU1udUtGQk5x?=
 =?utf-8?B?SlBxTzJtQnV1dWo0dVJRQlVDaWVWSnJQTWRRYUVuSFN1a2ovS2JLVHhNQjFh?=
 =?utf-8?B?RElPNnN3V1F4VUxLM3BuNU5wb0N2NGFkeEl0ZG5xWXBOb2Yva1VrZjdDUHl2?=
 =?utf-8?B?TnlMWlM4ZnM5UzdzZVJudnE5aGtYOUU0b2VWUU1MQ2hmVG8vS3Bla0QzYit4?=
 =?utf-8?B?amRCRWpsNzM2YUI3b3pOOEZFVm1uYjQzUWVYTUZ4NlptMGhUamU4R2toN2lG?=
 =?utf-8?B?YWtFaE9oejYwMnRaMmZESU9GY3pySkxZN1ExYkU2WFoyZVBCeUFES2RsWFJ6?=
 =?utf-8?B?SHhQNlQ3MkFEbGhZTGcvRTMzbWR5cnFkMVRGQk5zMFFGWm1kRGJJQk1zTzlv?=
 =?utf-8?B?a3IxUjduZ3VzNUMrNkt0YzVWOHpNaGRnYmo1UW9hRWI4NXk1RC9adGlZenRa?=
 =?utf-8?B?WEpXb1BneHJGSHZrYzZJNHA2UXlMMU9neldqbGtEaHE3QnFDS2pMK3dUaXJv?=
 =?utf-8?B?WGpKUzZNcEdLeTBXS3Rkd0JJRko3bVAzL2J5Q1BJWUNGWjNUaURiVERRZlRH?=
 =?utf-8?B?L3BtT0xXaExCeGVYYlFHQlV0cDJIOGd6M0hXdHRJYWNUTVNDY0JSM3BZUjg0?=
 =?utf-8?B?NEsyYjMwRzh5OURublNEUDRLTjNtNWo0MXE1OTFPYXcxUWMrcWJzdzM5UkEx?=
 =?utf-8?B?ZStSQUFMMHdLcElqeFlsTkwwQUhBN1JoQk1POWZYK2VnT1dTeWxQbStXb3dS?=
 =?utf-8?B?TzBXWEpLbHFIdTBDQnFCbWt2UERRQ1ZWdGIxM3NaY2hDa3lhUDZvbDlKWEgw?=
 =?utf-8?B?R2dNUUQ0d1hKU21ZUlhzUUtpTjFEWnZ1Ny8wZ2lmSTJCS2NhLzlCRVhxdUtv?=
 =?utf-8?B?NGtFMTNyVGVHQlpKU3gyM2ViQlN5VlA2bUZpSVpndVFZK2p2WkF3bGVXVVh4?=
 =?utf-8?B?dW5xWVBxQlZ3RkVxWk15cWROQkQ4N2lFM09sdmVPUU5aVWxwYmlzbU95OFpB?=
 =?utf-8?B?SXZOa0FkdDdycjBub2FadWRJeUlBMHZRaUFieEVLU3oyTnQ0b1FIVHF0Umo0?=
 =?utf-8?B?WUpXU1R3VXNiZkoyWnUzMzVFSERjK0hxYlM1NVV5VW1vTjJwR2c1enJqOVZP?=
 =?utf-8?B?VXJlTE1JQnVKaVJqR1dzZUdwaVUwaHk0dHRiQUllaisyWlpTOGtrajMxbU5Y?=
 =?utf-8?B?K3RSVWViS2puRHc5Qmp5Rlc5dUpBR2lNSDN5d3pyYUdFclF0OGpycTRUb2FE?=
 =?utf-8?B?amdiblFBSTJiSnZSaVpsN1ZqK2lvYVY5SE5TU1NLVk4wSFpnVHdiZVBMN1Fu?=
 =?utf-8?B?dSttN1lVcFBIclNVTmNQLzhIN3ZMSmFqekhlc0xzZzVQUC9INVlKNWRpVHQw?=
 =?utf-8?Q?GWkF3Vkz8tBCHAt0VlBtOuw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f78939-d3b8-4784-ec18-08d9d5344cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 18:58:05.2967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEIKjmxPpRRJN4gSwEb4X3SzW9uIergIgytiTfp9Fk1kwwvG2pTMUo6rdUgYh9bWu5GLn0o29TkFHyqpySbiRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgSmFudWFyeSAxMSwgMjAyMiAxMjo1NA0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxN
YXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBCam9yZW4gRGFzc2UgPGJqb2Vybi5kYWFzZUBnbWFpbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQ6IGFwcGx5IHMwaXggY29kZXBhdGggdG8gbW9yZSBjYXNl
cw0KPiANCj4gDQo+IA0KPiBPbiAxLzExLzIwMjIgMTA6NTkgUE0sIE1hcmlvIExpbW9uY2llbGxv
IHdyb3RlOg0KPiA+IE9uIHNvbWUgT0VNIHNldHVwcyB1c2VycyBjYW4gY29uZmlndXJlIHRoZSBC
SU9TIGZvciBTMyBvciBTMmlkbGUuDQo+ID4gV2hlbiBjb25maWd1cmVkIHRvIFMzIHVzZXJzIGNh
biBzdGlsbCBjaG9vc2UgJ3MyaWRsZScgaW4gdGhlIGtlcm5lbA0KPiA+IGJ5IHVzaW5nIGAvc3lz
L3Bvd2VyL21lbV9zbGVlcGAuICBXaGVuIGNvbmZpZ3VyZWQgdGhpcyB3YXksIHRoZSBzeXN0ZW0N
Cj4gPiB3aWxsIHVzZSBtb3JlIHBvd2VyIGJ1dCBzaG91bGQgc3RpbGwgd29yayBmb3Igc3VzcGVu
ZCBhbmQgcmVzdW1lLg0KPiA+DQo+ID4gQXMgc3VjaCwgcmVtb3ZlIHRoZSBjaGVja3MgdGhhdCBw
dXQgdGhlIEdQVSBkcml2ZXIgaW50byB0aGUgUzMgY29kZXBhdGhzDQo+ID4gd2hlbiB0aGUgdXNl
ciBoYXMgc2VsZWN0ZWQgczJpZGxlLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IEJqb3JlbiBEYXNz
ZSA8YmpvZXJuLmRhYXNlQGdtYWlsLmNvbT4NCj4gPiBCdWdMaW5rOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xODI0DQo+ID4gQnVnTGluazogaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTUzODcNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMgfCAx
NSArKysrKysrKystLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hY3BpLmMNCj4gPiBpbmRleCA0ODExYjBmYWFmZDkuLmE0NmJhYzhmNzlhZiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+IEBAIC0x
MDQwLDExICsxMDQwLDE0IEBAIHZvaWQgYW1kZ3B1X2FjcGlfZGV0ZWN0KHZvaWQpDQo+ID4gICAg
Ki8NCj4gPiAgIGJvb2wgYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ID4gICB7DQo+ID4gLSNpZiBJU19FTkFCTEVEKENPTkZJR19BTURfUE1D
KSAmJiBJU19FTkFCTEVEKENPTkZJR19TVVNQRU5EKQ0KPiA+IC0JaWYgKGFjcGlfZ2JsX0ZBRFQu
ZmxhZ3MgJiBBQ1BJX0ZBRFRfTE9XX1BPV0VSX1MwKSB7DQo+ID4gLQkJaWYgKGFkZXYtPmZsYWdz
ICYgQU1EX0lTX0FQVSkNCj4gPiAtCQkJcmV0dXJuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlID09
DQo+IFBNX1NVU1BFTkRfVE9fSURMRTsNCj4gPiAtCX0NCj4gPiArCWlmICghKGFkZXYtPmZsYWdz
ICYgQU1EX0lTX0FQVSkpDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJaWYgKCEoYWNwaV9n
YmxfRkFEVC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApKQ0KPiA+ICsJCWRldl93YXJu
X29uY2UoYWRldi0+ZGV2LA0KPiA+ICsJCQkgICAgICAiQklPUyBpcyBub3QgY29uZmlndXJlZCBm
b3Igc3VzcGVuZC10by1pZGxlLCBwb3dlcg0KPiBjb25zdW1wdGlvbiB3aWxsIGJlIGhpZ2hlclxu
Iik7DQo+ID4gKyNpZiAhSVNfRU5BQkxFRChDT05GSUdfQU1EX1BNQykNCj4gPiArCWRldl93YXJu
X29uY2UoYWRldi0+ZGV2LA0KPiA+ICsJCSAgICAgICJhbWQtcG1jIGlzIG5vdCBlbmFibGVkIGlu
IHRoZSBrZXJuZWwsIHBvd2VyIGNvbnN1bXB0aW9uDQo+IHdpbGwgYmUgaGlnaGVyXG4iKTsNCj4g
PiAgICNlbmRpZg0KPiANCj4gSXQgbWFrZXMgc2Vuc2UgdG8gZW1pdCB0aGVzZSB3YXJuaW5ncyBv
bmx5IHdoZW4gcG1fc3VzcGVuZF90YXJnZXRfc3RhdGUNCj4gPT0gUE1fU1VTUEVORF9UT19JRExF
Lg0KPiANCg0KVGhhdCdzIHRydWUgLSB0aGFua3MuICBUaGUgb3RoZXIgb3BlbiBxdWVzdGlvbiBl
bmRzIHVwIGJlaW5nIHdoZXRoZXIgdGhpcyBldmVuDQp3aWxsIHdvcmsgc2luY2UgdGhlIFNNVSBu
ZXZlciBwb3dlcnMgZG93biB0aGUgR1BVIHdpdGhvdXQgdGhlIHJlc3Qgb2YgdGhlDQpmaXJtd2Fy
ZSBzdXBwb3J0Lg0KDQpUaGUgcG9zc2liaWxpdGllcyBJIHNlZSBhcmU6DQoxKSBKdXN0IHRyeSBp
dCAod2hhdCBpcyBoYXBwZW5pbmcgbm93KS4NCjIpIFJlc2V0IEdQVSBhZnRlciBjb21pbmcgYmFj
ayBmb3Igc2FmZXR5Lg0KMykgRG9uJ3QgcG93ZXIgZG93biBHUFUgd2l0aG91dCBmaXJtd2FyZSBz
dXBwb3J0Lg0KNCkgRmFpbCB0aGUgc3VzcGVuZCB3aXRob3V0IGZpcm13YXJlIHN1cHBvcnQuDQoN
Cj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+IC0JcmV0dXJuIGZhbHNlOw0KPiA+ICsJcmV0dXJu
IHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlID09IFBNX1NVU1BFTkRfVE9fSURMRTsNCj4gPiAgIH0N
Cj4gPg0K
