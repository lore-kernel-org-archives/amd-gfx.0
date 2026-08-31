Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDF0C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 12:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0680C10E80A;
	Mon, 31 Aug 2026 12:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvZ1VfMf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EBC10E51A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4n80yb4Pe9G5w9+lo/+Yu6IVBoswWsOHb4wM/WiOF1DxNqlwY4vHyOjV/uPCLKzmvA26wAPl5NoyHZ5MgDDwvYoIr/dizrZ//xPtgn1b8lb1KEnEG91CoAQpcR9TAtETxDGPE5s17GEcxGQ0DLldRgkylJDgVLgpTPh9b7E+vs6MOgokcvpDQEJlSQq/DU8Ma0IVG2tMsWFxeLrEExztPABPTLkUSzQI2Pi3CyePGnUdSEnbpWRMOCetcYDtiVw+906DWHbICK25VMH+BMcoR9OOEv0p8GLWvzWSf07wG2WzqG9MKx0diX/0NS2T0hIChqwCSGOaLUVcWZrjsB2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feq4WdH/jhpINcKmZL2l3RoHlSXOj9BRFLy1WTGWbJQ=;
 b=NIxnP//n3SP5utfgieILcrHglVSVRAKoI6s8HiXox4jbxKRdSUZ9TFW7B0VHhXASqGpSxn6hWSVo/TlUJLW5YklSw/U7311A3ir8c5mdnZ6Fus8szs0eQM+lJkhQe1w36PwOTiK7U2y+wN1kJ409GzaMjjRqLGM9N50CJoYqppq8jzCvY1oyHCu8MNnquQy+lU9pxRjwbAmtoMY4rD38HKoKesJujS6Vd4FieD84pAykB/MpR0995+jp0We06azhMrvg5t+7Y1UGkpCMEIC3K/xZ3E7vBM1lmKHGjlP9/wMbLuXCMlyy0EGuNi2GbhWq0z4he71/Zxf/JwLaoh6r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feq4WdH/jhpINcKmZL2l3RoHlSXOj9BRFLy1WTGWbJQ=;
 b=ZvZ1VfMfs4b0zVU/yS0Tbr2ougW21fbTZSg+oZQw+KT/ek4DhETKRxa8yFTfm0CNEb4qmzMsLF7RbXhI5Wtb8cXXqsq+b6spPm2+Otrrya4YVDyD0ceeB8zitELCAcDutOa5EwBuVam5qm0L18LAoOSDSLaPHX5foug3nk+B0/Q=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 12:06:12 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:06:11 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Topic: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Index: AQHdOQIsOtLaxb5uKU2B0jqBexC/y7a3/IKAgAACwoCAABBroA==
Date: Mon, 31 Aug 2026 12:06:11 +0000
Message-ID: <BN9PR12MB5211F46FDD421E130B99248793A92@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
 <0e34543c-4802-4023-befa-480b5452d92b@amd.com>
In-Reply-To: <0e34543c-4802-4023-befa-480b5452d92b@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T12:04:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|SJ2PR12MB9115:EE_
x-ms-office365-filtering-correlation-id: 1de93918-7db3-49b8-cf29-08df07583fba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|3023799007|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: j5XthFh39COOfX7/ikZcOw3nxhgyorQe611DwYNqEJvWJVhHTsNg7TDPg/FLkcpM0e1xAp3ByJO40D7gdc5UPX8rKeafM9lEipza+A5OhYsGDkayYWo1040KXzqcfrXBHcvSf4Whcpby6r2Lcn3EQ7En1lxpzXsd9L4mqyWl1o4UAGD6s2JYRwjB0gIVzWd20nlDJ65VhdrRi0r1Ad77JkmsF0xIzfIOhq2diwjKgBAtPDj10+lekB0B0JTLzCOrOpYmbxYJhel4+VmyHUR59mwovFcfFrJV35Xw9Bk6S6Pfb4QSpWvJuFWuz1tAgFz3ZLXQoKuCvd39S2SsGQWIYIn7hi2iH3gTS4exZHMdiynC76iZ11WLfAFRIdlzLksSYgnO6NCYdDwT2zs5dNJkQQlEBz+Azh/hQ8odGUHYre3FeLS3cQp51dJE32eVZVE9V2jTFfwTqPli/Kyg5y44qUNb9CFStTIQ9GdMaTI9dbBJOo6EWyNfKiIYuflDFdSWA2ZWOcbcP94kElKHSS/VMYF3bN28xH1693hcHVi+KSuuD7Erkul5554FZV5goPL4RLMP/Xa/rwsSasN5Ryr9jLVbZ8flfPZtIYhfFfFMLCXkF+KkIjDFVNYEd1RbgvflvYTHRvPUOIKDAWP8RRyZSL8K+GJhx49hROVeVB1562s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akJKWWZYd0hwQ1RlaHV5bGhDNlAwbEFLNTgxcjlmdlBBOXF2N2xKeHBtZUhX?=
 =?utf-8?B?SnREdjRYalpjSFlEalA3MENwTUp6RGJJNlYxQ2xac0NqaDdxVHpWQzhVUG1Z?=
 =?utf-8?B?WEdQUGxBbi9YSzZ5amdUVVZybHZUM09iUGtnWUdTYTBQcjk5R3FjUldyV1BL?=
 =?utf-8?B?Uk54VDNIQVdGUnVFaVczcGJnSmJqOTYxUUhBV2wxb1RHZUNxN05rQ0FpOTBw?=
 =?utf-8?B?Tk5xY0JkejVHemlCckVQL3IxcWRRbnBUTCtzaE5IWTdycmplYndQU2lCdFZK?=
 =?utf-8?B?enhsR1FsbElTNVg4MmlwcG1YVmpMeFkyeVEyRExjVlNtSE4yTnhpRzVJbDNh?=
 =?utf-8?B?endMbzdZTExUN0dBUzNmdTg2M3BVWDJnNEdRTmp5UGZNYmpDdmhWOGRqNXFL?=
 =?utf-8?B?ZldrT0FUWElwN2RDSG9NUitoVW95SGdPS3VsdGJiWlBsNjdVaE5hdmJRMzdt?=
 =?utf-8?B?QmhXallGUmdpNjdvVkVuNVhRNE1nRDJIY2VNaTE4WDNiMzV1eXlaNm54Q2Vn?=
 =?utf-8?B?K2l3eEhHMCttZFJwNysxU2R5MnR5Z1kzMGpHS1FoWm8rL3ZBMWVKZ3BiSklO?=
 =?utf-8?B?ZzY2SkFrN0lKYjREeUUvbUxzOSt4SmJMb3E2RjJGeEFVUEdwUTB1cnYrb2Zv?=
 =?utf-8?B?YXpqWmJBektVbWl2UlBTbkpvUk8zbCtXRHUxbXNOcytuN2U1NXlQK0RhbERC?=
 =?utf-8?B?VDUxUnhoZGRjb2dZQ3FHUjlXaW0zd2F2SjR6ZU1remorV0w5d0dCQlhJQUhS?=
 =?utf-8?B?WVY1ZExZQ2prMndkaXBjNUg0VGlTYy9PRHhYZmd2V3NBVzNlYVpTckxneng5?=
 =?utf-8?B?c3diZ3gyNDZ3QlRHa0g0QmIvZUE3dmliQXN0dzA5UUJ5OUk4c3haYk5yQkV5?=
 =?utf-8?B?S0g3MjZTU3I3QUp1K1pob3l0bE5QcFhUZmExQlhzMlVhRHBiQ2FjdFdNRURn?=
 =?utf-8?B?c3drNzZIWlo2QlpzeVRrMjcrYUdmbmY2dEVyQjlITEtCZER0MG9nMlVqR3I5?=
 =?utf-8?B?Nk5BYXBjc0ZEU09YYUY2eEZ6VW5TTUJXSWpoT3lrdVozbXRVYUdWM1Z2Q2R6?=
 =?utf-8?B?UFhPYTh0TVVQQ2Y3NEhMemdYVTdMK2ZsMVhYZzlKNnRTVnFaZ0Q4dDVyN0ZV?=
 =?utf-8?B?U3JkNUZoaFZEcGhhd051ZEFoMkFzck9wMk9PZlFUVjBra2kxWGQ1TFE2YlpT?=
 =?utf-8?B?ZStkZUNFeHFLYm1LRjlqL3B3bDRhQ2owRnB4aTRCWTBvSzBoME5PaHJ5bU8x?=
 =?utf-8?B?VjBPWHNFQXFzT0JpNkVaaFdheWh3eTJKdHJ6V3FkQ1d4SFBHZTB3RzRWaW8v?=
 =?utf-8?B?dU5EMW5nc2dmWHZBa0FoQzhiYkw2ckwwRFZJR25saXNYR25RaHFNNUN3Rjd0?=
 =?utf-8?B?VmtvVDBpVFUxSkdUVW44aTVXdEhRd1RUa2FQU3MxcHVJRG8rMTZrWEcvamVh?=
 =?utf-8?B?UksxVTRvWVpmVGk0SjkvSGlNdWZneDFvOEY1ZzBWRHRVYnlSRi9vRElwZVRk?=
 =?utf-8?B?ajl3REpobkJZbnJta2I5eWRTWlhrZkpLTVphdDE0cm1kcmR5NjBRTU92dHYx?=
 =?utf-8?B?eUVmanZobmk4QmlBNlQ0UlIwSmQ3eVVDV3VITlhHMC85Z1ZkdVRZV1pwMmx5?=
 =?utf-8?B?TjVOUzIwMFIvV1dYb2JETEdOR3MrUjFudXQvZ2k5b04vZWFNMmpNa01HSEY5?=
 =?utf-8?B?Ui9BSFFVY1RiRjgzUW9CSlRsSkZZZkRSQnNRdFZBMXk4M0d5RlZnaWFpdXht?=
 =?utf-8?B?bFJIajc3c3V3VGp6SFVoemlkK3pyZWE4NFl2UFkyd24wTDRtVDBVdXd1ejRx?=
 =?utf-8?B?R241VGcyOXVZRDNRTGZRcm94bW1rQ3d6eHhkZDFCbXFSWXZuRE5Dbnp5M2lt?=
 =?utf-8?B?TW1PRWgyQ3IzNGhBSWJlWWNYWWhOYy9nb0REVWwzeHc3ZnlnWWdZanJZaDla?=
 =?utf-8?B?QWdmSVZuU1pjc0Q1R29Fbi9yTXZOa2FhSUtHNWJSYmF4cVZkcXl4bzlUR3o5?=
 =?utf-8?B?alZZenNvb1kyTjJyZUV2bzJRSkRkamhMQVYyUHFSVkNXL3N5d2paYy9xMUNG?=
 =?utf-8?B?S1M3VjdtMFdGWEVabWtLSzJ1Tlg5MEtLSkJwbEg3cWFOdGxpcGhVa2xJdW9W?=
 =?utf-8?B?ZFFRdG4veVpiL0JBY2pqY1lSS0JmWUVLVWVoNnBhQlB1SnpXd2xJM1lWZWNH?=
 =?utf-8?B?NkYrVThFZVVNSXcvN3BjaFpFaEdvYVMxeU1zaEJoTGFxUzRabVlET1VIcGZa?=
 =?utf-8?B?dU1Gc083OUdaMTBGUEdONHlFTUtyRmpIaTlWZGd4MXQwWHpMZUpKbVMrNDh3?=
 =?utf-8?Q?bmaV6qOp1tvecRfg5H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de93918-7db3-49b8-cf29-08df07583fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 12:06:11.7352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9YKwfyfvem5IAdo2FQhbSLtHUzMA/o7et9OfygEfsIWX2kZ7HU8B1RUoblk1SPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAzMSwg
MjAyNiA3OjA2IFBNDQo+IFRvOiBXYW5nLCBLZXZpbiA8S2V2aW4uV2FuZ0BhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAwLzddIGRybS9hbWQvcG06IHN0YWdlIE9EIHJlc2V0IHVudGlsIGNvbW1p
dA0KPg0KPg0KPg0KPiBPbiAzMS1BdWctMjYgNDoyNSBQTSwgTGF6YXIsIExpam8gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+IE9uIDMxLUF1Zy0yNiAxMDowNSBBTSwgS2V2aW4gV2FuZyB3cm90ZToNCj4g
Pj4gW1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0
IGVtYWlsIGZyb20NCj4gPj4ga2V2aW4ud2FuZ0BhbWQuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBp
bXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvDQo+ID4+IExlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+ID4+DQo+ID4+IFRoZSBwcF9vZF9jbGtfdm9sdGFnZSBpbnRlcmZhY2UgZXhw
b3NlcyBhIHN0YWdlZCBPdmVyRHJpdmUgd29ya2Zsb3c6DQo+ID4+IHVzZXJzIGVkaXQgY2xvY2ss
IHZvbHRhZ2UsIGFuZCBwb3dlciBzZXR0aW5ncywgdGhlbiB3cml0ZSAiYyIgdG8NCj4gPj4gY29t
bWl0IHRoZW0gdG8gdGhlIFNNVS4NCj4gPj4NCj4gPj4gSG93ZXZlciwgUFBfT0RfUkVTVE9SRV9E
RUZBVUxUX1RBQkxFIGRvZXMgbm90IGZvbGxvdyB0aGlzIHdvcmtmbG93DQo+IG9uDQo+ID4+IGV2
ZXJ5IFNNVSB2ZXJzaW9uLiBTb21lIGJhY2tlbmRzIHJlc3RvcmUgdGhlaXIgY2FjaGVkIHNldHRp
bmdzIGFuZA0KPiA+PiB3YWl0IGZvciAiYyIsIHdoaWxlIG90aGVycyB1cGxvYWQgdGhlIHJlc2V0
IHRhYmxlIG9yIHNlbmQNCj4gPj4gZnJlcXVlbmN5LWxpbWl0IGNvbW1hbmRzIGRpcmVjdGx5IGZy
b20gInIiLiBBcyBhIHJlc3VsdCwgdGhlIHNhbWUNCj4gPj4gdXNlcnNwYWNlIHNlcXVlbmNlIGhh
cyBkaWZmZXJlbnQgaGFyZHdhcmUgZWZmZWN0cyBhY3Jvc3MgQVNJQ3MuDQo+ID4+DQo+ID4+IEZv
ciBleGFtcGxlOg0KPiA+Pg0KPiA+PiAtIFNNVSAxNC4wLjAgYW5kIFNNVSAxMy4wLjUgc3RhZ2Ug
cmVzZXQgbGltaXRzIHVudGlsICJjIi4NCj4gPj4gLSBTTVUgMTQuMC4yIGFuZCBTTVUgMTMuMC42
IGFwcGx5IHJlc2V0IHZhbHVlcyBpbW1lZGlhdGVseS4NCj4gPj4gLSBOYXZpMTAgc3RhZ2VzIHRo
ZSBib290IE9EIHRhYmxlLCB3aGlsZSBWZWdhMjAgcmVhZHMgdGhlIGN1cnJlbnQgU01VDQo+ID4+
ICAgIHRhYmxlIGluc3RlYWQgb2YgcmVzdG9yaW5nIHRoZSBzYXZlZCBkZWZhdWx0cy4NCj4gPj4N
Cj4gPj4gVGhpcyBzZXJpZXMgbWFrZXMgInIiIHJlc3RvcmUgZGVmYXVsdCB2YWx1ZXMgb25seSBp
biBkcml2ZXItc2lkZQ0KPiA+PiBzdGFnaW5nIHN0YXRlLiAiYyIgcmVtYWlucyB0aGUgc29sZSBv
cGVyYXRpb24gdGhhdCB1cGxvYWRzIGFuIE9EDQo+ID4+IHRhYmxlIG9yIHNlbmRzIGZyZXF1ZW5j
eS1saW1pdCBjb21tYW5kcyB0byBQTUZXLg0KPiA+Pg0KPiA+PiBUaGlzIGdpdmVzIHBwX29kX2Ns
a192b2x0YWdlIG9uZSBjb25zaXN0ZW50IHRyYW5zYWN0aW9uIG1vZGVsOg0KPiA+Pg0KPiA+PiAg
ICBlZGl0L3Jlc2V0IC0+IHN0YWdlZCBkcml2ZXIgc3RhdGUgLT4gY29tbWl0DQo+ID4NCj4gPiBS
ZXNldCBzaG91bGQgYmUgcmVzZXQgdG8gZGVmYXVsdHMgYW5kIHNob3VsZG4ndCByZXF1aXJlIGV4
dHJhIGNvbW1pdC4NCj4gPiBUaGlzIGJyZWFrcyBleGlzdGluZyB1c2Vyc3BhY2UgZm9yIFNNVSAx
My4wLjYuDQo+ID4NCj4NCj4gSSBzZWUgdGhhdCB0aGlzIGJyZWFrcyBleGlzdGluZyB1c2Vyc3Bh
Y2UgZm9yIGFsbW9zdCBhbGwgb2YgaXQuIFNNVQ0KPiAxMy4wLjIgYWxzbyByZXNldHMgdG8gdGhl
IGRlZmF1bHQgY2xvY2tzIGltbWVkaWF0ZWx5LCB3aGlsZSBvdGhlcnMgdXNlIGENCj4gZmFsbHRo
cm91Z2ggbG9naWMgdG8gY29tbWl0IHRoZSBjaGFuZ2VzIGltbWVkaWF0ZWx5LmFwcGxpZWQuDQo+
DQo+IFRoaXMgYmVoYXZpb3IgbmVlZHMgdG8gYmUga2VwdCBhcyBpdCBpcy4NCg0KVGhpcyBiZWhh
dmlvciBjaGFuZ2UgaXMgaW50ZW50aW9uYWwsIGFuZCB0aGVzZSBwYXRjaOKAkXNlcmllcyBpbnRy
b2R1Y2VzIGEgdW5pZmllZCB0cmFuc2FjdGlvbmFsIG1vZGVsIGZvciBwcF9vZF9jbGtfdm9sdGFn
ZToNCi0gYHJgIHJlc3RvcmVzIGRlZmF1bHRzIHdpdGhpbiBkcml2ZXIgY2FjaGUuDQotIG9ubHkg
YGNgIGNvbW1pdHMgc2V0dGluZ3MgdG8gUE1GVy4NClRoZSBleGlzdGluZyBpbW1lZGlhdGXigJFy
ZXNldCBwYXRocyBhcmUgQVNJQ+KAkXNwZWNpZmljIGluY29uc2lzdGVuY2llcy4NClNNVSAxMy4w
LjIgcHVzaGVzIGRlZmF1bHQgY2xvY2sgbGltaXRzIGRpcmVjdGx5LCB3aGVyZWFzIG90aGVyIGJh
Y2tlbmRzIGFjaGlldmUgZXF1aXZhbGVudCByZXN1bHRzIHZpYSB0aGUgY29tbWl0IHBhdGguDQpU
aGlzIHNlcmllcyB1bmlmaWVzIGJvdGggdW5kZXIgUG93ZXJQbGF54oCZcyBzdGFnZWTigJFyZXNl
dCBtb2RlbC4NCkJ0dywgdXNlciBzcGFjZSBkZXNpcmluZyBpbW1lZGlhdGUgcmVzZXQgc2hhbGwg
aXNzdWUgYCJyImAgZm9sbG93ZWQgYnkgYCJjImAuDQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoN
Cj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+DQo+ID4gVGhhbmtzLA0KPiA+IExpam8NCj4gPg0K
PiA+Pg0KPg0KPiA+PiBJdCBhbHNvIHBlcm1pdHMgdXNlcnNwYWNlIHRvIHJlc2V0IGEgc3RhZ2Vk
IGNvbmZpZ3VyYXRpb24sIGFkanVzdCBvbmUNCj4gPj4gb3IgbW9yZSBzZXR0aW5ncywgYW5kIHN1
Ym1pdCB0aGUgZmluYWwgY29uZmlndXJhdGlvbiB3aXRoIG9uZSBjb21taXQsDQo+IHdpdGhvdXQg
dGVtcG9yYXJpbHkgYXBwbHlpbmcgYW4gaW50ZXJtZWRpYXRlIGRlZmF1bHQgY29uZmlndXJhdGlv
bi4NCj4gPj4NCj4gPj4gTGluazogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9h
bWQvLS93b3JrX2l0ZW1zLzU2OTANCj4gPj4NCj4gPj4gS2V2aW4gV2FuZyAoNyk6DQo+ID4+ICAg
IGRybS9hbWQvcG06IHN0YWdlIG9kIHJlc2V0IGZvciBzbXUgMTEuMC43DQo+ID4+ICAgIGRybS9h
bWQvcG06IHN0YWdlIG9kIHJlc2V0IGZvciBzbXUgMTMuMC4yDQo+ID4+ICAgIGRybS9hbWQvcG06
IHN0YWdlIG9kIHJlc2V0IGZvciBzbXUgMTMuMC4wLzEzLjAuNw0KPiA+PiAgICBkcm0vYW1kL3Bt
OiBzdGFnZSBvZCByZXNldCBmb3Igc211IDEzLjAuNg0KPiA+PiAgICBkcm0vYW1kL3BtOiBzdGFn
ZSBvZCByZXNldCBmb3Igc211IDE0LjAuMg0KPiA+PiAgICBkcm0vYW1kL3BtOiBzdGFnZSBvZCBy
ZXNldCBmb3Igc211IDE1LjAuOA0KPiA+PiAgICBkcm0vYW1kL3BtOiBzdGFnZSBvZCByZXNldCBm
b3Igc211IHZlZ2EyMA0KPiA+Pg0KPiA+PiAgIC4uLi9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21n
ci92ZWdhMjBfaHdtZ3IuYyB8IDc1DQo+ICsrKysrKysrKysrKysrLS0NCj4gPj4gICAuLi4vYW1k
L3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jICAgfCAgMiArLQ0KPiA+PiAgIC4u
Li9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyAgICB8IDE1ICstLS0NCj4g
Pj4gICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYyAgfCAgMiAr
LQ0KPiA+PiAgIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICB8
IDg1DQo+ID4+ICsrKysrKysrKystLS0tLS0tLS0NCj4gPj4gICAuLi4vZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyAgfCAgMiArLQ0KPiA+PiAgIC4uLi9kcm0vYW1kL3Bt
L3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jICB8ICAyICstDQo+ID4+ICAgLi4uL2RybS9h
bWQvcG0vc3dzbXUvc211MTUvc211X3YxNV8wXzhfcHB0LmMgIHwgNTAgKysrKysrLS0tLS0NCj4g
Pj4gICA4IGZpbGVzIGNoYW5nZWQsIDE0NSBpbnNlcnRpb25zKCspLCA4OCBkZWxldGlvbnMoLSkN
Cj4gPj4NCj4gPj4gLS0NCj4gPj4gMi41NS4wDQo+ID4+DQo+ID4NCg0K
