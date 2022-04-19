Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 12:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EB810E83B;
	Tue, 19 Apr 2022 12:24:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E8B10E83B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 12:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNBxdmryuIQZUAgEZIlysHjt4OesLHPgSUJoDgKzEpGzRSYLFNzWr1lcEkCePFTnPQ5ZYp0mr0EUjebT+Q7cAIizsNyUJeLWYQTcv0SwXJ12ra94bXBoOvwBAVdxulvQ53ioBD7tf+8CE/TQogqE4Qv5ckJtfDzqCNaGHaqLYoANJG53KoFuTFANfzazkOawItQocVZZs97/JJ5uhsrR9BdP1TF4+vwQN7jiGBOGa+WRnn9ynr9u6YxjCmrpS6Rz41rnXIxwGS3k//KRxkC+E3K/YJ2mPv4psZ7H1uHr1k5RCuJMu08z1o7XbJ800w+U+vQhJu9kE9N4NlTW0KrJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWNNOYFoI3+lTI8xXAf/b4Om4Yh9Fh4ECIrhmFEr7sY=;
 b=EkW2XEkx823tixMJ2UBLjh4xilC3MjS1vx6w0dAG76rCuQBkHER/dN1SpWQyjK45dADjJrFjUF6EK18pcgARdOg6jVIOLdi+v5uINOyiJ5xcbfl7/QwruSKtKDpvVuP3g8ew+03tcT2YwD8p0/yG7fJCKdi/d2wHhJIwoJoXtA9aKkjn2LhRAGPcEl5pMaTXlVCC5Af4vWqwrezp29AI+9UuW4uWE9oUeyqyZdejkvPgVUMaD2j+ZuAfATvGQpuu53lMm9e/eIy8zbELZMNwfNcy0wkftKsCZyf1mlNlPx/4i0N0eu7JP6VU/ja93hEejokPVZkuQWL2q6h9NdtE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWNNOYFoI3+lTI8xXAf/b4Om4Yh9Fh4ECIrhmFEr7sY=;
 b=TKXv+iuufKOfp8CRZVl7UTIm37g4427sSXiScdFnRamDBkdfleUd6Ewy6WdMVotR6pO3VC9oHoNy1GseJD4WiRMOtY/ES1rROiKX5AxGUGLdDABBCg457+Ro5sN1ck9nvfEwh3DjidupDFSUaCjnD1iXrMvfi6MZhi0b5EXWekI=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 12:24:17 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::94fe:5625:5a46:cd2]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::94fe:5625:5a46:cd2%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 12:24:15 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: CRIU add support for GWS queues
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: CRIU add support for GWS queues
Thread-Index: AQHYU0OhBUcv95gP0EW39JqnDDYP76z2HbyAgAA4T2CAAHf9AIAAWnbA
Date: Tue, 19 Apr 2022 12:24:14 +0000
Message-ID: <DM6PR12MB50210556B55CB21495F2451D95F29@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20220418164437.1875319-1-david.yatsin@amd.com>
 <20220418164437.1875319-2-david.yatsin@amd.com>
 <568532d5-e127-2d39-a455-e4102ab240b2@molgen.mpg.de>
 <DM6PR12MB5021D813258265387A23C2B895F29@DM6PR12MB5021.namprd12.prod.outlook.com>
 <fdd0477f-0874-3ffc-e46a-bb8b87103f96@molgen.mpg.de>
In-Reply-To: <fdd0477f-0874-3ffc-e46a-bb8b87103f96@molgen.mpg.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3acf1ef-1c76-4f89-ab0d-08da21ff848c
x-ms-traffictypediagnostic: BL0PR12MB4930:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4930B26F9730117EA3DA5E8295F29@BL0PR12MB4930.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPrjNOI8obVi7Ci4zbFeQApABbuTUlaeRf7JBBhVdv+e4zJ2G9/78ofAJrKYGY1aDsHSjGRGkn/WGRUu6LLd7lvrO8f0fcOgYuK0oNVAKBUGbW2oAsPfYIihi6yGRLDC02rYhCAyUG7kUOV8yDFTYNY5Ags3zW4T9PIaxfcmERvTaVvXKTzmbS5UPH1ddUohU3o9m+z7Yi/aJWkn0r4qs472730o+fClracMUGIR2Dr6T0MAZ+gvslPnxToevdGBR3hCbPbQ0RG4PzDAoqmODn0HC4crs7g4AuyADtiGz7kMhmSLX0bzV6FkrEuC7f+4noYxA4b0W9nvGQObfsFh7WpMtObERlILO8JqLvE1hhHc2uOAK3WUU8jSVT8yeBctdkRjSYRKP3rfdLmSsIv/r6egaJxEkrglrtvFEf7EC+9Aog19M0JoUPOJsg6NMW5/e+X1nj/JZhrDib5huNKuZA9GwYMiIMNbFgoBiHlI2Kb4BgG3FQaNCfgpQ4N8FWwDKo3zoQPZyvAJuvTtBzyk+I6UoqW8HOAL+MqhHUytPGLVeKzUB0QhGvrIGk8PVLqR0aPTGcu2pZRcEW0iByv4y5DI6fkD+Hoe+j9dj2ZWxoFCEMFLRCvquH9yznQQPPn9hig2CDEIdroDlScc2cy/En1qkf/6VoZnp7u9NAuP2BQWlZrscOeAGeFKWbcy6dE0peujBWCsxjn1JUrZ08eApsAYcGq4JJgbvoUZuzukJX8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(52536014)(9686003)(26005)(86362001)(2906002)(7696005)(6506007)(122000001)(55016003)(8936002)(54906003)(33656002)(6916009)(316002)(4326008)(5660300002)(38070700005)(38100700002)(66556008)(83380400001)(508600001)(76116006)(8676002)(66446008)(66946007)(186003)(71200400001)(66476007)(64756008)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVZqU2RtK2lhUHQ4MkF0UGNCNEoyeXZxWUFQNjdwZ05NVUV6Yno1clliYUh5?=
 =?utf-8?B?MnBKYlZMcVl5em5IREwxVEoyZnh0bWRreFZnS0lKbDROeDdOSVZXU3VUZUxx?=
 =?utf-8?B?a3NIdXNHalp5YmRiT0xkNFlBZnE4U3Z5VUxsQmk4d2o5MDUrYi8wUG9VOWow?=
 =?utf-8?B?WFNMRHlTOTk0YnordmxoL0I5QmFha3dhN0xRR0Npd0F0TmEwSVY5b1BrbnhF?=
 =?utf-8?B?dSs2cUpWY2l2dDR4MGJKaXNWNmNZTURwQ2NER1R2MG8xYktTaDBJb2NLbTVm?=
 =?utf-8?B?UG5iK0ZQUUJURWR0dUM3SFNpaHJLWXdsZmNtTDhqMHdFVkFIS054RXhCa3lp?=
 =?utf-8?B?MHNKQXZtQzF5cHlEWUJLZ0F0L1JtTXJlZEgwck9iUEwzck10ODBMUEtGcExS?=
 =?utf-8?B?R0lFTkt6NmtIa2Y5TytlY2RLOWYxa2laUVBZdjZHMmNUQ0dJYStQNytvUVRJ?=
 =?utf-8?B?N2hKUlFlUmN0L2JmT2RhQzFmd0FKY1AxVStxdzA1c3VsWUZxUVVMZi94QW53?=
 =?utf-8?B?L1Uwd1Y1TmdjTkhqNmtKSEE5ZHF1RWJxN3hkYlI0cjhFeUp4MVdpQXFqd05y?=
 =?utf-8?B?elppN3BKNm9lR0VmYlIvU3NVSmFHZVZrdTdyVTMrcGVLQlA3TnR3blpNQ1dx?=
 =?utf-8?B?K1ZXUHdtaUptVVdMeGR1bHJuT3UveEhhL3BrcUFuUm1USG1JRVhhUDM1NTNa?=
 =?utf-8?B?ZzcxWVZhQk1Oa0xFaWpaTE9adWgxaHFHdDB4S2haajYxUk9YVDdLcGdKWlZj?=
 =?utf-8?B?RlFpRkhRQVM5NXlnbVEwczE1TS9WbTdEOXI3TWY1YmFiU0tvNHlzSTEzY0RU?=
 =?utf-8?B?QUF1bktpSm9WMnNpZ0VJNEtlRVcxeTRKenlWM2w0Qkw3RTF3VEp3TmZYR0Vu?=
 =?utf-8?B?NENNb2dsTnRGYjJyTGRqVXNZS2NHOFM2d29mWUo0V055UHZ0WDJ2c0NHYzha?=
 =?utf-8?B?aXNLUDErdXhKV2tyb0h5VFBERXF0cURmdmR0TEVJMWk2MmdYMVVhM0d6OVBh?=
 =?utf-8?B?S2tSUnlHdkZFWVZNYXFHVTVBNDNYYUdHQWpNYUVHVDZ0VnJwTXl0OVU4Tjcx?=
 =?utf-8?B?K29ZcWZnRjY5UTJZa3JVT240NDVKUU1vVmU1WW9KRGJqVmxLc0N1akVjaVla?=
 =?utf-8?B?cGEvTzlPRTl3bjhoN2VteGJGUUE5eTltVkVGUi95V0RTTVpmZmNISXh5cm16?=
 =?utf-8?B?aXVBQkZGK1JDcnBIMzVCTGNJTzFtL2lEK0hwdE4yQk0zWVlteDVHRy9uc0E4?=
 =?utf-8?B?WUwwOVBjVU5MbUoyeFVyNGYrTVJGTUFYZWVGNjBVWHFJd0VqclA5N2hUaTNU?=
 =?utf-8?B?cEJCeUg3WmIyQmU2OGRaMzJaQUZ1V2ZkVno5dEpvc1lCUVkrMzd2b1VaeHBO?=
 =?utf-8?B?QTNwamlMMkpkS1ZqT3JYZXBYVC96WDdUcFh2RktRU0huYlpKTndIcFFhVUFq?=
 =?utf-8?B?L0t0RmVsUXJsSjJJemJtTFNJUmRvb3VEd2laazhOU3NHREZDeTNXRUw2YkMw?=
 =?utf-8?B?Qkc1UVFUbXVPT01KTzRrMUlJenNpOEIzMGhubUFQcUFQV3EzN2RjNGozSXFm?=
 =?utf-8?B?S1ZzUXg1N2ZSeUpVajkyZ21WWFV0OTk2QlUxNWpob1pyNlBTQit4VGkvSDNp?=
 =?utf-8?B?TDJxLzNacHBkZzVId0NpREJ5dUJoQU1zZ2JocHQ0aHoyR29XMi9rZ2NSUUUz?=
 =?utf-8?B?N01wdnE0R3l1UkhtbWVENTgzZ1ZkMTdWZWJjb1V5Y0dya1p6STlhZ01PUmx5?=
 =?utf-8?B?SlFmNkNsN1BBTUJIYnowR3B5aFhTVUM1YU9ISWFnekVSUFZNSnNrQmt1UnYr?=
 =?utf-8?B?aHp2SU5jYlhJZGxXS0pzWW9kZkoxakYxdGtRWTBQUGZUcjVoLzR3bE8xdkVX?=
 =?utf-8?B?SGw3QW53Y2d2N05iRFNvQWV4WTNmRFZ0aGxJVnp4VmJTZjVlVGJUREkvZ0Qv?=
 =?utf-8?B?ZkMrWHVBTGlCUjh0NTBhdHNCRE1sU1owWVpXYmltTytEczg4T2QzUlplZkg4?=
 =?utf-8?B?NWhleGVzc29iTGt0V1kvU1hSK0NTR1BLM1dOMVZUdlM0OERIM3JOdjJBOGd2?=
 =?utf-8?B?Z0xUQTdPR1dOTWxaR1d5MThJZnE3eWtjUStrOGRzT3NRamVJeDY5MHBxS0N5?=
 =?utf-8?B?OTZOUXFHS2l4UEtxMmYwQ1V1SWdUTVRhWHErcjI0WHR4L0x5anVyUml1Sld5?=
 =?utf-8?B?T0lIellTc1J2QWhKS092UUFGQlplZ05WVHA4TE1PaFd5V3RoOXU0Q3BFbFor?=
 =?utf-8?B?SFRFN1FqbEwzazBsNWgvMm53QnB1N1c1RjNCa0FRS3pQUWdYVDBzWnVCa240?=
 =?utf-8?B?aUlnaGdXQ2hhQ2JvNGJtQzYrRU1KNzdCSGJZRTNKRTVVV0NGRFlVUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3acf1ef-1c76-4f89-ab0d-08da21ff848c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 12:24:15.0066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNOYV1Y3+YT8BLyI7WIpy6+lBtSpQ07n1rmn+rGhDDMl5QvIvsCdeKt73SSbtrr6Uw7BKKYHwgfYHuGsqhaU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTksIDIwMjIgMjo1
NCBBTQ0KPiBUbzogWWF0IFNpbiwgRGF2aWQgPERhdmlkLllhdFNpbkBhbWQuY29tPg0KPiBDYzog
S3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBkcm0vYW1k
a2ZkOiBDUklVIGFkZCBzdXBwb3J0IGZvciBHV1MgcXVldWVzDQo+IA0KPiANCj4gRGVhciBEYXZp
ZCwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHNlbmRpbmcgb3V0IHYzIG9mIHRoZXNlIHBhdGNo
ZXMuDQo+IA0KPiBBbSAxOS4wNC4yMiB1bSAwMjowNCBzY2hyaWViIFlhdCBTaW4sIERhdmlkOg0K
PiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogUGF1
bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gPj4gU2VudDogTW9uZGF5LCBBcHJp
bCAxOCwgMjAyMiA0OjIzIFBNDQo+IA0KPiBb4oCmXQ0KPiA+PiBBbSAxOC4wNC4yMiB1bSAxODo0
NCBzY2hyaWViIERhdmlkIFlhdCBTaW46DQo+ID4+DQo+ID4+IEluIHRoZSBjb21taXQgbWVzc2Fn
ZSBzdW1tYXJ5LCB5b3UgY291bGQgcmVvcmRlciBzb21lIHdvcmRzOg0KPiA+Pg0KPiA+PiBBZGQg
Q1JJVSBzdXBwb3J0IGZvciBHV1MgcXVldWVzDQo+ID4+DQo+ID4+PiBBZGRpbmcgc3VwcG9ydCB0
byBjaGVja3BvaW50L3Jlc3RvcmUgR1dTKEdsb2JhbCBXYXZlIFN5bmMpIHF1ZXVlcy4NCj4gPj4N
Cj4gPj4gcy9BZGRpbmcvQWRkLw0KPiANCj4gRGlkIHlvdSBtaXNzIHRoZSB0d28gY29tbWVudHMg
YWJvdmU/DQpBQ0sNCj4gDQo+ID4+IFBsZWFzZSBhZGQgYSBzcGFjZSBiZWZvcmUgdGhlICguDQo+
ID4gQUNLDQo+ID4+DQo+ID4+IEhvdyBjYW4gdGhpcyBiZSB0ZXN0ZWQ/DQo+ID4gV2UgaGF2ZSBz
b21lIGludGVybmFsIHRlc3RzIHRoYXQgY2FuIHdlIGJlIHVzZWQgdG8gc3BlY2lmaWNhbGx5IHRl
c3QgdGhpcw0KPiBmZWF0dXJlLg0KPiANCj4gTmljZS4gQXJlIHlvdSBnb2luZyB0byBwdWJsaXNo
IHRoZXNlIGluIHRoZSBmdXR1cmU/DQpJIHRoaW5rIHNvbWUgb2YgdGhlc2UgdGVzdHMgZGVwZW5k
IG9uIG90aGVyIGZyYW1ld29ya3MsIHNvIGl0IG1pZ2h0IG5vdCBiZSBzdHJhaWdodCBmb3J3YXJk
IHRvIGRvIHRoaXMuDQo+IA0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgWWF0IFNpbiA8ZGF2
aWQueWF0c2luQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcml2LmggICAgICAgICAgICAgICAgICB8ICAyICstDQo+ID4+PiAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMgfCAx
MA0KPiArKysrKysrLS0tDQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaA0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfcHJpdi5oDQo+ID4+PiBpbmRleCBmMzYwNjJiZTljYTguLjE5MmRiZWYwNGM0MyAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgN
Cj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gPj4+
IEBAIC0xMTAyLDcgKzExMDIsNyBAQCBzdHJ1Y3Qga2ZkX2NyaXVfcXVldWVfcHJpdl9kYXRhIHsN
Cj4gPj4+ICAgIAl1aW50MzJfdCBwcmlvcml0eTsNCj4gPj4+ICAgIAl1aW50MzJfdCBxX3BlcmNl
bnQ7DQo+ID4+PiAgICAJdWludDMyX3QgZG9vcmJlbGxfaWQ7DQo+ID4+PiAtCXVpbnQzMl90IGlz
X2d3czsNCj4gPj4+ICsJdWludDMyX3QgZ3dzOw0KPiA+Pg0KPiA+PiBXaHkgaXMgdGhlIG5ldyBu
YW1lIGJldHRlcj8NCj4gPiBUaGUgb2xkIHZhcmlhYmxlIChpc19nd3MpIHdhcyBvYnRhaW5lZCBm
cm9tIHRoZSBxdWV1ZV9wcm9wZXJ0aWVzDQo+ID4gc3RydWN0dXJlIGR1cmluZyBjaGVja3BvaW50
IGFuZCBpcyBvbmx5IHVzZWQgdGVtcG9yYXJpbHkgZHVyaW5nIHF1ZXVlDQo+ID4gY3JlYXRpb24s
IHNvIHRoaXMgdmFyaWFibGUgY2Fubm90IGJlIHVzZWQgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgYSBx
dWV1ZQ0KPiA+IGFzIGd3cyBlbmFibGVkLiBUaGUgbmV3IHZhcmlhYmxlIChnd3MpIGlzIG9idGFp
bmVkIGZyb20gdGhlIHF1ZXVlDQo+ID4gc3RydWN0dXJlLiBUaGUgbmFtZSBpcyBjaGFuZ2VkIHRv
IGJldHRlciByZWZsZWN0IHRoaXMuDQo+IA0KPiBGdXJ0aGVyIGRvd24geW91IHNlZW0gdG8gdXNl
IGl0IGxpa2UgYSBib29sZWFuIHRob3VnaC4gU28gYSBuYW1lIHJlZmxlY3RpbmcNCj4gdGhhdCB3
b3VsZCBiZSBuaWNlLg0KVG8gbWUgdGhpcyBpcyBvay4gSSB3b3VsZCByYXRoZXIgaGF2ZSB0aGUg
dmFyaWFibGUgbmFtZSBtYXRjaCBpdHMgc291cmNlLg0KPiANCj4gPj4+ICAgIAl1aW50MzJfdCBz
ZG1hX2lkOw0KPiA+Pj4gICAgCXVpbnQzMl90IGVvcF9yaW5nX2J1ZmZlcl9zaXplOw0KPiA+Pj4g
ICAgCXVpbnQzMl90IGN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplOyBkaWZmIC0tZ2l0DQo+ID4+
PiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIu
Yw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9t
YW5hZ2VyLmMNCj4gPj4+IGluZGV4IDZlY2E5NTA5ZjJlMy4uNGY1OGU2NzFkMzliIDEwMDY0NA0K
PiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVf
bWFuYWdlci5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4gPj4+IEBAIC02MzYsNiArNjM2LDggQEAgc3RhdGljIGlu
dCBjcml1X2NoZWNrcG9pbnRfcXVldWUoc3RydWN0DQo+ID4+IGtmZF9wcm9jZXNzX2RldmljZSAq
cGRkLA0KPiA+Pj4gICAgCXFfZGF0YS0+Y3R4X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUgPQ0KPiA+
Pj4gICAgCQlxLT5wcm9wZXJ0aWVzLmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplOw0KPiA+Pj4N
Cj4gPj4+ICsJcV9kYXRhLT5nd3MgPSAhIXEtPmd3czsNCj4gPj4+ICsNCj4gPj4+ICAgIAlyZXQg
PSBwcW1fY2hlY2twb2ludF9tcWQoJnBkZC0+cHJvY2Vzcy0+cHFtLCBxLT4NCj4gcHJvcGVydGll
cy5xdWV1ZV9pZCwgbXFkLCBjdGxfc3RhY2spOw0KPiA+Pj4gICAgCWlmIChyZXQpIHsNCj4gPj4+
ICAgIAkJcHJfZXJyKCJGYWlsZWQgY2hlY2twb2ludCBxdWV1ZV9tcWQgKCVkKVxuIiwgcmV0KTsg
QEAgLQ0KPiA3NDMsNw0KPiA+Pj4gKzc0NSw2IEBAIHN0YXRpYyB2b2lkIHNldF9xdWV1ZV9wcm9w
ZXJ0aWVzX2Zyb21fY3JpdShzdHJ1Y3QNCj4gPj4+ICtxdWV1ZV9wcm9wZXJ0aWVzICpxcCwNCj4g
Pj4+ICAgIAkJCQkJICBzdHJ1Y3Qga2ZkX2NyaXVfcXVldWVfcHJpdl9kYXRhDQo+ICpxX2RhdGEp
DQo+ID4+PiAgICB7DQo+ID4+PiAgICAJcXAtPmlzX2ludGVyb3AgPSBmYWxzZTsNCj4gPj4+IC0J
cXAtPmlzX2d3cyA9IHFfZGF0YS0+aXNfZ3dzOw0KPiA+Pj4gICAgCXFwLT5xdWV1ZV9wZXJjZW50
ID0gcV9kYXRhLT5xX3BlcmNlbnQ7DQo+ID4+PiAgICAJcXAtPnByaW9yaXR5ID0gcV9kYXRhLT5w
cmlvcml0eTsNCj4gPj4+ICAgIAlxcC0+cXVldWVfYWRkcmVzcyA9IHFfZGF0YS0+cV9hZGRyZXNz
OyBAQCAtODI2LDEyICs4MjcsMTUgQEANCj4gPj4gaW50IGtmZF9jcml1X3Jlc3RvcmVfcXVldWUo
c3RydWN0IGtmZF9wcm9jZXNzICpwLA0KPiA+Pj4gICAgCQkJCU5VTEwpOw0KPiA+Pj4gICAgCWlm
IChyZXQpIHsNCj4gPj4+ICAgIAkJcHJfZXJyKCJGYWlsZWQgdG8gY3JlYXRlIG5ldyBxdWV1ZSBl
cnI6JWRcbiIsIHJldCk7DQo+ID4+PiAtCQlyZXQgPSAtRUlOVkFMOw0KPiA+Pj4gKwkJZ290byBl
eGl0Ow0KPiA+Pj4gICAgCX0NCj4gPj4+DQo+ID4+PiArCWlmIChxX2RhdGEtPmd3cykNCj4gPj4+
ICsJCXJldCA9IHBxbV9zZXRfZ3dzKCZwLT5wcW0sIHFfZGF0YS0+cV9pZCwgcGRkLT5kZXYtPmd3
cyk7DQo+ID4+PiArDQo+ID4+PiAgICBleGl0Og0KPiA+Pj4gICAgCWlmIChyZXQpDQo+ID4+PiAt
CQlwcl9lcnIoIkZhaWxlZCB0byBjcmVhdGUgcXVldWUgKCVkKVxuIiwgcmV0KTsNCj4gPj4+ICsJ
CXByX2VycigiRmFpbGVkIHRvIHJlc3RvcmUgcXVldWUgKCVkKVxuIiwgcmV0KTsNCj4gPj4NCj4g
Pj4gTWF5YmUgc2VwYXJhdGUgdGhpcyBvdXQsIHNvIGl0IGNhbiBiZSBhcHBsaWVkIHRvIHN0YWJs
ZSBzZXJpZXMuDQo+IA0KPiBEaWQgeW91IG1pc3MgdGhpcyBjb21tZW50Pw0KV2hhdCBkbyB5b3Ug
bWVhbiBieSBzdGFibGUgc2VyaWVzPw0KDQo+IA0KPiA+Pj4gICAgCWVsc2UNCj4gPj4+ICAgIAkJ
cHJfZGVidWcoIlF1ZXVlIGlkICVkIHdhcyByZXN0b3JlZCBzdWNjZXNzZnVsbHlcbiIsDQo+IHF1
ZXVlX2lkKTsNCj4gPj4+DQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K
