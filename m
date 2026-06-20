Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C16DCD98F2
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 01:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CCB10E16E;
	Sat, 20 Jun 2026 01:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="geUxpn4y";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3F210E16E
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 01:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olanvFT6Tnrao4ndjjus5NKkFWlkjLgDpMSeCzEG3ZjzKDn/ENFcre/1B3qiaT0cTV5lKDtkCp4/qptewjth3IW092oo9jctLn7kZfbrvtgK6XhOiu8GD/nOSTiYfu/KNWrTt8+VhnB8sHHjPePQmZ21iXlCbp/JebViuNIgkirzxgw+wTSqJKxeOiWvH4jnxji48F18RpdKJZRj39cpcJ99MzQ3hRVCM82CLEgpaOB3e+WJYxOCC1AQzYTG5/ygQKc2FrGJK25n2Uk26pyXkaCMUgNM508MFiMdCAoRN+wPoUqrVlk5w3T3MPg2gtowB0ZY2gcsDV7SEXUUStF4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHud2PKJozPR9Isq9JsIrNX+tEx/EX2a37foy8UkNuM=;
 b=GaXYVbwuDz9PZlT2zlWiEbNUULGwvD4CeK+QBAZ4TSHsO8zqV+fY+iuVi5AjRJ6RETcht/j3I2x23DuK/ZgWKMjsFtP1KMRryo2VQYz+yWEPHEzoUDY+dIImial/3z2LnTjhd+PKM1JI43zJDUoaLSsrNix0xDKddi/AnMo7dEYnspzACIlMpWQNPqN4Za2GiitmgaRcTpF7Q24bEPE8HBoT0L/2zcBD+n5eeFLMDLeReSg3fNzgGsG2yFn3J1X96YsbuuC8fgrKVZKrrV4vURBoJRVHpRIlzdIfyV2LnwRj5WH/rwlc70r5mbNZZOf0kOI4iy0R8yPoWD4cdM3acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHud2PKJozPR9Isq9JsIrNX+tEx/EX2a37foy8UkNuM=;
 b=geUxpn4yi1iOb7uYDgXFxnlhl3L9vLGIijls+mlvO5460gb7NQ5QjIGyuf9S+2FzpOwTCjUbDjvHW6cg78PpQauD/WCcXyyE3iQEyeW+GbKluJfdJxmR0p3XjPcBf4h7nblfiFfOJM/NrpeYOrlFKAbW9DjItc/SfO8HLK/aq0g=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 01:18:01 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 01:18:00 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?=
 <timur.kristof@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Topic: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Index: AQHdAA+QIv+XVhj5VEWKsTwNX70BhrZGL6CAgAB1R/A=
Date: Sat, 20 Jun 2026 01:17:59 +0000
Message-ID: <IA0PR12MB82082DDFC1691693DBAE5C1A90E12@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
 <CADnq5_MhbBpkV6dyZsWrTTyhQNWBqU8FpQyFgkByzdtOf7MNHQ@mail.gmail.com>
In-Reply-To: <CADnq5_MhbBpkV6dyZsWrTTyhQNWBqU8FpQyFgkByzdtOf7MNHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-20T01:17:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB8414:EE_
x-ms-office365-filtering-correlation-id: 9ff507f1-c535-439f-b87b-08dece69c512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: 3Os015rG+j7SjFnLy1sYXFobtVT2qYWRKApK8fcdC7O2MvNjr6Ki7jWs7BakXQ30BsdsloDwgwsGCefF92vIiKqRlv0+ojhNOqWkKAgFCgYXkyarmcJ8Yyn67dDLFeDpB3drbzT98/lRddJ5wUN3ePasnh+S6cLF42HnJ1Bsi9ZG4iOO4u+quXBhqIcHByGmWsNyfMshAVGm1ZI9FU3gw3gb8CuVQXGu0vGoc6HSeZsVv0NdAMmo30xC4FR9+33/KFW6q31hSpLCPlBG8GxtXmaVyR2AjDiK8GrGoRqloml5Bte8+248NAQG85hCAdGvDWFCcqBEsVW/8gL26TQ5yy0PxLAF8rbjY/sD6T0NHEVCef0oyTVUArqdFva2biNT/F8pj+RFZwF1+pCcj2nXsfKJhX2X7V2Ne84V0JjWnFxUC/5nLZcajeO9BE7gjiFfINzOH+wNwZU7FokKoPYVLRk/cPa1Actv8j/qDkbHuGYMhNGJPEGoyzvfGdAMEtx6M0Q623SoY8UT7lf+rflFt8MI6sc9/sfuZNF/+88XJg5S7EQlV2JI+YluQv07KYmniPjUPsr8mh1+v/c0Hezk9jXs+sZ8SpAoxYVoNXjH0B7CWAWAtTvN+4bLAWsLp99laKa83LSDZdh3bWU9dvsbl4QxcIPzYQYbBMPotfSIZE7Bit3V87b6r8OzV6dpvyj/4G9VPwwHlIzfhnOBf0ZtaoJufOqPw8Q/JIY5ofSDUkw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFJhUlhOTnU1ODlPUUc1UVZtNzVlTklwMlVTNGZVSThXKzljRXVVWlZodmlF?=
 =?utf-8?B?U0R2RGNDM3R2Z2ZCWWtRcllPaHY3S25TZUxBcEhTTXI0QklVR01tMVVCOGpi?=
 =?utf-8?B?SmdiY0Rrb0NmcW05dXdYT2J1YUI0ZnFsVDA3ZWJrbVRQWE9NaDM2a09KalFK?=
 =?utf-8?B?S2pBaDVSZ3hXTGdzUjhmRTR1ZTJja3NaVXhCNzJubFdreW9yZEI1NnVaZTFq?=
 =?utf-8?B?Z1UzN2VSOWdqVkU5VmcrS3hoYXpBS21mWnZveTBIRnpSNjliak96WFVuQWtK?=
 =?utf-8?B?NmVHR0l6eHovMy9tUWRuVzBGckl0R2owV3FXZXZPTkZ6dDhXTVQ5TzZtazZ2?=
 =?utf-8?B?Z3lscFJPaXpLRVFxcXZYOFFrL21vS3RjOVAvaWI4RWJKU3Rya3JrdFFyeWtn?=
 =?utf-8?B?eEIxdXBiaWtVM2h2cGk3YzVvdVN4L1hYMm5xUEdodXgxL2U5bG8vbExzL3lI?=
 =?utf-8?B?VW9lK25kRnRaYzl2SFdqRTJLSGc5eUdwYkdjNjdDMVA1WG9ObUlVNWtiYWc0?=
 =?utf-8?B?RFN1Sjc4d0lpSUoxRlFadW4rMVhRT21DeGF6UENZNU1qdnZoSE5lQXVBdS9k?=
 =?utf-8?B?aUVZSkxmRzRGUVJINCtDMmUyQ1VUVEw4UEMzQmp1K3VNY3JQZlBlMFlteDI2?=
 =?utf-8?B?dVpubWdpbVJXV2F1Q0ZXTnhRaG9NUVlacXFZMUhTaDNuUnRxMHJ3V3dMeDdO?=
 =?utf-8?B?ZXY5NW1ROG0zcURkeThtYVRFTldOZmVrQVY1LzE3dUR1V3RvQk4ybXZJNGRh?=
 =?utf-8?B?TDd2WklDcWlvREpRRWZzc0NaSTdyazhMS1RSb3hYMGQrM3ZaSU1Dc0lBdHZC?=
 =?utf-8?B?TmJRT3VuVjdSTFlQaFZZZHRwdjdYeGpHMTZYLzVsZUdYRGtCVFpQSEdqODBO?=
 =?utf-8?B?eG8zR3RhSk9nVXFZSStQRHp3S2p6aFB6WDlsZE5nOTVJeTRwTXhTU3lucVcv?=
 =?utf-8?B?dFhnZFVFQlkzRUFkT21taC9xZHJOY1Y0SVdSTzhFbFVIWlV6Y01QOE0zSVpV?=
 =?utf-8?B?OXdITllsa2NvTkVtVSt1VzBhL3J4ekRoanNhS3NhdnRhRlBjVU9CRXBWays4?=
 =?utf-8?B?cFNOaVRwYlBIZFdtUk82Rm5yRmFNNVpKbktLdlAweXBYeXg0QXBLQUYrR3Fi?=
 =?utf-8?B?TlNoYlhYaEJ2Zno4ekhRN2ZvQnB5YmhheGsvam5YRDFwQVQyZnJSdmlNSVY0?=
 =?utf-8?B?azBES0hJcUJIZXh0N0U0THpSMXNIU2JtWVd6WVI5bFhHRHNkUStzSmc1cXJE?=
 =?utf-8?B?eTE0Sjd0cWR4VW9tWDJZZGFaODZsRUNXOU90ZndkWXlvLzA3SDBvRnl2eXBp?=
 =?utf-8?B?Y3dXVHZrcm1RUVFObWk0RXZtWEczbFJtVkZGVnVoM0tZRE9CVHBsR3c3bmpT?=
 =?utf-8?B?eTVxYUpNNkVWbXNoeGxIL2tUY0hmeXJodURZMEEzWW1PZ1FhZFRzRFF2c0x6?=
 =?utf-8?B?dUNTc2pPcEtmbndFdkZYYUhud2ZhWk1Zc2FXNlg0UkE5SWNQNnViR0s1WWd2?=
 =?utf-8?B?YnB3bDRkNXQ4SktiV25YZTZ2WWp5YnNPblVqZ2FrdXRBbUpaZEplMm5aSENV?=
 =?utf-8?B?bTJuNEpqVEdySWJNd3BMNkdPdXQ3TG52emNGNW1jSTFiUWdKc3NBUlFwamtH?=
 =?utf-8?B?ZGV1bzR2MDhLWnVXclN1aVVGejl6UnRkRjFpZ3BxdFhHQ0pOTTFhUFBBbXFp?=
 =?utf-8?B?WXU0YjY1WW5LODBhL1N2V05BVFNWdDN2UlhtU3k2VVVLdTkzT1prMjkzaU9r?=
 =?utf-8?B?YUc3NU5XemlLVlp4K1dXRVNwQ3dJbFdSNkQ5ZklsTTN6dFZwSUlybDluK3Qw?=
 =?utf-8?B?WUxMWHdCTk9nMjZES3pqZVJpV3M4ay94MzJJWTAzZE4xbEZJclBCcnRhb2tu?=
 =?utf-8?B?c1hLd0M4MS9hT1hJbndpeDdwc0RvWmQ1ODVPVlFPd1Y2dXdCUkVZK1U4ZkZD?=
 =?utf-8?B?VWs5L3FvdUVNam5PZ2N4U09FUy8zZmJXUlRJOGwvTXZTYjhVZVZoSmtBVVY5?=
 =?utf-8?B?MTF6TVdIVVFJTDVDSVhFMXB2dzlqdXcrNFdON3VZd3JkWHlTMHVVYVgvdENG?=
 =?utf-8?B?ak9PZ21TSUtuNndldjF3VUdhZG5qOFNiUTFoVnY2VE9hMjZsczJHb3BoSmVw?=
 =?utf-8?B?OFlqeVdNQk9iNmlYN3hQbVh4cWU4Skc0dlE1Nlo4ZEsxQ2dPUHYxUFZvbHpi?=
 =?utf-8?B?eG5BVm9TVG9tVjFBSlpUa2dlNEJQOGREQXB6NW1JRTluMHZWZDhJZVJxaGNJ?=
 =?utf-8?B?TExRZFpoVGt4UGh1dVBIVDZTTFRXaDlQdUl3L3dWMWtUakwyWXlQczhqYS9H?=
 =?utf-8?Q?/Ysg0V2whRVPaAfYSO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff507f1-c535-439f-b87b-08dece69c512
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 01:18:00.5419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxC5TZqjMnr+OMOrEy62I5wnU5Pa5nZry/rL3KUWJk1e9JTfTZyxiotZ0P4kCQmcHMCNacKvJ46bbZIPSQIkhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDE5
LCAyMDI2IDExOjQ3IFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+DQo+IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFRpbXVyIEtyaXN0w7NmDQo+
IDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogUmVkdWNlIHN0YWNrIHVzYWdlIGluIElQIGJsb2NrIHNvZnQgcmVzZXQNCj4NCj4gT24g
RnJpLCBKdW4gMTksIDIwMjYgYXQgMTo1NOKAr1BNIFNyaW5pdmFzYW4gU2hhbm11Z2FtDQo+IDxz
cmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IGFtZGdwdV9kZXZp
Y2VfaXBfc29mdF9yZXNldCgpIGFsbG9jYXRlcyBhbiBhcnJheSBvZiBBTURHUFVfTUFYX1JJTkdT
DQo+ID4gcmluZyBwb2ludGVycyBvbiB0aGUgc3RhY2suIE9uIDY0LWJpdCBidWlsZHMgdGhpcyBj
b25zdW1lcyBhcm91bmQgMTI4MA0KPiA+IGJ5dGVzIGFuZCB0cmlnZ2VyczoNCj4gPg0KPiA+IHdh
cm5pbmc6IHN0YWNrIGZyYW1lIHNpemUgKDEzMDQpIGV4Y2VlZHMgbGltaXQgKDEwMjQpDQo+ID4N
Cj4gPiBNb3ZlIHRoZSB0ZW1wb3JhcnkgcmluZyBwb2ludGVyIGFycmF5IHRvIGhlYXAgYWxsb2Nh
dGlvbiB0byByZWR1Y2UNCj4gPiBzdGFjayB1c2FnZS4NCj4gPg0KPiA+IEZpeGVzOiBhNjMxOWFj
MzRhMTMgKCJkcm0vYW1kZ3B1OiBBZGQgSVAgYmxvY2sgc29mdCByZXNldCBhcyBhIEdQVQ0KPiA+
IHJlY292ZXJ5IG1ldGhvZCIpDQo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCj4gPiBDYzogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2Fu
LnNoYW5tdWdhbUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaXAuYyB8IDE5ICsrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lwLmMNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcC5jDQo+ID4gaW5kZXggNjU1MDViYzUwMzk5
Li5lZWI5MzgzYjEwMTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2lwLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaXAuYw0KPiA+IEBAIC01MjQsNyArNTI0LDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfaXBfc29m
dF9yZXNldChzdHJ1Y3QgYW1kZ3B1X3JpbmcNCj4gKmd1aWx0eV9yaW5nLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9mZW5jZSAqZ3VpbHR5X2ZlbmNl
KSAgew0KPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBndWlsdHlfcmlu
Zy0+YWRldjsNCj4gPiAtICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZ3NbQU1ER1BVX01B
WF9SSU5HU107DQo+ID4gKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKipyaW5nczsNCj4gPiAg
ICAgICAgIHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrOw0KPiA+ICAgICAgICAgZW51
bSBhbWRfaXBfYmxvY2tfdHlwZSBpcF90eXBlOw0KPiA+ICAgICAgICAgdTMyIG51bV9yaW5ncywg
cmluZ190eXBlX21hc2s7IEBAIC01MzksNiArNTM5LDEwIEBAIGludA0KPiA+IGFtZGdwdV9kZXZp
Y2VfaXBfc29mdF9yZXNldChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKmd1aWx0eV9yaW5nLA0KPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gICAgICAgICB9DQo+ID4NCj4g
PiArICAgICAgIHJpbmdzID0ga2NhbGxvYyhBTURHUFVfTUFYX1JJTkdTLCBzaXplb2YoKnJpbmdz
KSwgR0ZQX0tFUk5FTCk7DQo+DQo+IFdlIGNhbid0IGFsbG9jYXRlIG1lbW9yeSBpbiB0aGUgcmVz
ZXQgcGF0aCBvdGhlcndpc2Ugd2UgY291bGQgZGVhZGxvY2ssIHRoaXMgbmVlZHMNCj4gdG8gYmUg
cHJlLWFsbG9jYXRlZCBpZiB5b3UgdXNlIHRoZSBoZWFwLg0KDQpUaGFua3MgQWxleC4gSSdsbCBh
dm9pZCBhbGxvY2F0aW9uIGluIHRoZSByZXNldCBwYXRoIGFuZCByZXNwaW4gdGhpcyBieQ0KdXNp
bmcgYSBwcmVhbGxvY2F0ZWQgcGVyLWRldmljZSBzY3JhdGNoIHJpbmcgYXJyYXkgaW5zdGVhZC4N
Cg0KQmVzdCByZWdhcmRzLA0KU3JpbmkNCg0KPg0KPiBBbGV4DQo=
