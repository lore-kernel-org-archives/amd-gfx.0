Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCD6C5475B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 01:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BD710E1BE;
	Thu, 29 Feb 2024 01:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oFhMhp6q";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD3510E1BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 01:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzLQRLt7FLYL3BIXr+mudnVvTV1kYTEeviLzDo/Kazs2uWMiFvX3nAsTfmyJiY7itOEim6XZwLvdD887UFP2GyHfWHI5ohE7D+KJnqzi009D8c0Ye1MDYFYR5YwiVwBmvcgomu1h/3inGgVEkbimJ3EADedNTZLlDZodPksx2293ndIHm1EuDPup1OipnyEXPIrf0EQo0+pl1398XZ00RTpLVagI+KASm0xRaCeN4ICZPZPm5ORPCPmoJgEXIbOI3hnA+EtvuZujSdOF0mwLp/4VLY6e1dWfWJolM+rFSfLQEguKmE7prXH6OQYyws0A6zYHG/CCgTveAUNauZRMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHT8r1x/B8K4iL+j/OLGbye5/q38ZNF1pCiHyGTnzjQ=;
 b=jUU+CAFFehE8pvLbyu5lgTqaxru4Q7ykxBGV94h0h2+IZ5Vf2ptK87E0LTu2h/s57dabm072K1GNdWDDeQC1EQEcI3gLgOUYNtqJHHwnqsqrhDnC85tEwHXVKrPOu/zFpxPgmct7lFrHicT8Wfc1IVNCjfsJZeezms63xHvIgaonuqyVz+TKkC6xxXCmS3MNZZUbDQkJlrqNV/FBG/fWus1o+zQV9srIc/SQpBkx9LeX4Obs8FpwZaM11MI8pvT48wDWSk/6Pj0tL4n+kAS8xFMecFtFL/KwW8kHyzMygbVWPPiF8s3RrI0VD2Dtc5FdJxKt+GLHdXgggZOZ1u6g3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHT8r1x/B8K4iL+j/OLGbye5/q38ZNF1pCiHyGTnzjQ=;
 b=oFhMhp6qAYYPqkqvN1/Wu9BfpMucFf4J3V1t5XFSOO/huMcWBr2TZVF0Sh0tjG+/oKDou55Yd9nyge2CdvpgJG9n/V0whfaMyrIvWWiR1zT6/8v2cWsnu+xv76m6BX+/l53Zn/DgOZYUVA0Fx3Pv0sXiQA+Kn/LHwxoMcgGouy4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:57:56 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 01:57:56 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Ma, Li" <Li.Ma@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: modify the gfx activity scaling
Thread-Topic: [PATCH] drm/amd/swsmu: modify the gfx activity scaling
Thread-Index: AQHaajrOzwzEIaTs10yqjrKsxvsdw7Efz3wAgADBJ2A=
Date: Thu, 29 Feb 2024 01:57:56 +0000
Message-ID: <CY5PR12MB6369533CD60ABEA515B697EAC15F2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240228113916.235390-1-li.ma@amd.com>
 <CADnq5_Puy+-6xfhjPSF_DjVo9ZJ65zZqkEMJB3qm3U+=tWrYaQ@mail.gmail.com>
In-Reply-To: <CADnq5_Puy+-6xfhjPSF_DjVo9ZJ65zZqkEMJB3qm3U+=tWrYaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab7f343a-230b-424b-aeab-cff72642ae2c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-29T01:56:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB5687:EE_
x-ms-office365-filtering-correlation-id: e174b37e-e6e4-47a2-e6ae-08dc38c9d948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7NEsjHUIuUK6r2SZXIuFU0Qqmls2bIhLpaOK2e10SPW4r0IHGHnfz5P2b3BLaiQqHT6oEw9ZlPaqVEPyry7pP7mlIfdVY2w1Bd8qiMDcSSwcHoc+RrOXVbtCKwxKJ21p3iFkg7KL1NcNODP6rKNK5hrOtZyJuIWZJDlsqUIJD+J4F05iQrEqEsN9VpLUT4p8r6DWVlxoKgAXiifdg1H1HXogYrkb7plwRvkVAhFq94R0oH2OfgzDHoJRuFXMfWL6XtHGsLi3tsYDtnezynsHicE3p/WZBcVek0neLSy9tvQK5V/IdYR7hpuaZNCzM04K+qqLn9dIbAsqMhLKsGg6vCONj0gLJG4mE3cjA9PV8qrpZELEpnOagLirbJ2/XQ7f9Nuat55YY82b7eE8TWuaKyHY69QJo00YACv2Fy97XZ5Xuw+bpUEB2Rz6lM8/hWr3DtnMKn6XbHSkUXWi4cqKjXnpENQXQnOf72xyCzCa2jftu1/dd3FbjKCvw2tV/+4V9o2uy41XdFCNb+OkrzTif5MEgZIe4N+ZPA7es4UscrvtINut6UT4vSgyov8cvESZOWsdfCzJ8TbexWW7oFIJ2eoHw63Bb1pynK11tiJQyuS2VIqa+C1O5nP4Fvl57UKlinC/zt/oeoO0mM2RNEiENCR2ssV+NiE9SR46kXv1MfeTkZq8zQK4vrV/p69McWjWSd+yNAL7apv5fZl2hWBi4l+Xiw2wfxCcsZXJZnsPQs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2hLeXlSUVdNSkpqNkhPZlA3TzZvSklmc2tlVVQvQnRVcHlUMkZYb3QzYnVi?=
 =?utf-8?B?bDV2OE05Y2YzU0duWW9Qd0o3M05XRER3ZDdkWTZGUzVEZFNPMElTb0hRZGk5?=
 =?utf-8?B?dllxcFFrWVNMN0RabXdZbjdYRUdMWmRYWHNIaDVleWtVY2ttNWtJcU9VK3dY?=
 =?utf-8?B?YUQ5WFhOa3VIZmI3YVlkR1oyT0FNTGFJQXI5cGhyQ2c1M0ZxN2wwWTdNcDBU?=
 =?utf-8?B?NzFQZFgvZnZIS2NhM2VCbVpYbzd3Y1JCa1cvTURFVEs3TGVLV0ptQUpxTlVz?=
 =?utf-8?B?cVQxNDhJUFFwRnNYbmlGdDczY1k3ZW9xYTdxRzlqQ3Nvd2FzU0Q1dGd3ZlRo?=
 =?utf-8?B?WkpyU0svYk5peC9sSFNPQnR1QTNpRG1LbnAvVEFIc1g1eFJpa0dBS0ZXeFpD?=
 =?utf-8?B?Z2VXYnhWOUxwV1hYWHZWcTRydzlia0ZQM3BzdGFlSnJmbFNabFM5ZlRKZzJw?=
 =?utf-8?B?eFBPL3djaWEvdmUrMXdnS2NTVGZVakFnSTNyYWpzR2QvSTR6QTUvdGxFMit1?=
 =?utf-8?B?cHNWeUJnRDd5Mjd3aktqb3lqL04rMDRmZVhyQ042QWZpUDV2VkpvcDVkNEUv?=
 =?utf-8?B?UXRaZTJGR2NJTnEzeWM2Q08wZlpNbHMyMEtra0dxMzVaYkRFSWgyUUxsVURF?=
 =?utf-8?B?SlZPMmNKcmJzTWdCdWxxWDZIZWh4QW94cGRRZkNzL3gzZW1oQTRyZGlnaWtr?=
 =?utf-8?B?ZVNrckR4aTE4U0F1S0hjQzJreWdCNUpYWGprbTM3S2JIaURHWmp5bXpSOWlM?=
 =?utf-8?B?L0hGV0ZPVVk0TGMvMDh0SW0rdi9CVk5jdmdoWXJYVDBvckhnSlVzcVZYRDA3?=
 =?utf-8?B?L1NUdEgzZldBK3BnajhWT1JBcnUzTU9qcnNOMWpVNHlBenBEcncwOUxEMnRY?=
 =?utf-8?B?VW96ekZoYXFHcDVjS2RTWnZVOU0zZG9xRVVVRGp0QUJhMStVVksxNXBYYis5?=
 =?utf-8?B?ZlREeHNmVGp6SnY4WTNCbFVHQXpnenNVVzJmZE9LelZOekhLNkZvVGVTQnVa?=
 =?utf-8?B?TUdPVEdnYWhHTWNiM3AzSFVydU1qaDRWWkhzbGUwUTJ5OUdmZ2xzdGNPVmdD?=
 =?utf-8?B?VDNOM3NjWDhlS0h0ZTFtekEwMnhBZG1aYUZJeXFGaG5LOXhUTFUwNG1zNGVB?=
 =?utf-8?B?V0lRUG9veTZDQUQwUjg2VHAxL0swVVlRYVJOUW1ReHNaYmRCQ1lMNUJ6em5i?=
 =?utf-8?B?R2Q1Zm5JTnVOSE9uSVVrbjN3alM2eGlER2FSa0cwZVU4R0xSQzN3WGd5dXJO?=
 =?utf-8?B?UytsNnpuOTJCd1ZuT2JGSFpMNS9TRU1ITWoxYi9YVS9QUWN5eUNidDVyZzZl?=
 =?utf-8?B?SERMbE10Y2NUcGFXTm82M2pLaHJPQUt1TlhHbkpQeEJrNzNYQjgrM0ordlpG?=
 =?utf-8?B?SjlQR2EvczJIUktldTB5enY0dlkrZFRQYmFmclAxRGtERDhTM3ZmendycURK?=
 =?utf-8?B?aHdxa0lSMDE3YXZJSXZROG5scSswblRaUGhEeGtmZmUxcy9YV01OcVY5QWpz?=
 =?utf-8?B?M09hSTlrdWRnM0IzTjhlTGRSUTFXVzlMYVAyVi9DN2NYMDVRZU5ybElrVGpC?=
 =?utf-8?B?U2NJbDF4dE0xK3dtWGVCQ0JsZ0VzSlFIMUtkbXhlalhmNmZ0VGlEaWVrU1By?=
 =?utf-8?B?TGhsK1E5QXV5cnhGY3M4UWRXRHdCdmIzQnY5NTU1RUx2SVBnRGdZZDFIT3Rz?=
 =?utf-8?B?TXRFRytkVU4rZDRKRnBjclozNlFGSUpVS2xHRjhleHlnUkpZQkFKZ2Yzb3Vo?=
 =?utf-8?B?NlF0c25TY3BZS3NQVUNObjBveTEzSmlWNFhmcjhXcmtpRFBORnFDRDRBUHd2?=
 =?utf-8?B?aklERmFTOFViVlQ5Q1ZUckJIRXE1TWZpbGUvRTNVZVhyM0FTeG9yVCs5WCt5?=
 =?utf-8?B?U1dEOGZqc0dUY0xxa1JVc3kxcEs1SDZXYzRPOTRyQ3dyZDJqbnNjTHJlS2Qr?=
 =?utf-8?B?WFczUFIwRWZ3QnZ5VGxDVGJLanllNmJCdHY3bE03RzI0SjhCRi9XQmYybGVW?=
 =?utf-8?B?WTJHa0hxR21oWlk1Tnp0Wk9JbXdUY0lXUklnWnVlRUp1NTlUSUNaWjkzbjNQ?=
 =?utf-8?B?allKYTBZMmYzdlRHdlVnM1U1ekVheUs1b3o1VUdyTE5QT3kxVGpsNm03WVph?=
 =?utf-8?Q?gymQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e174b37e-e6e4-47a2-e6ae-08dc38c9d948
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 01:57:56.4737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Q3v3pBWp0+1XKI3m5d1c62XKH1RD+cB3upkmXjh0V4fiiee8xmu2dPaFzQcjxS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBZaWZhbiBa
aGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFdlZG5l
c2RheSwgRmVicnVhcnkgMjgsIDIwMjQgMTA6MjUgUE0NClRvOiBNYSwgTGkgPExpLk1hQGFtZC5j
b20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5n
QGFtZC5jb20+OyBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZC9zd3NtdTogbW9kaWZ5IHRoZSBnZnggYWN0aXZpdHkgc2NhbGluZw0KDQpPbiBX
ZWQsIEZlYiAyOCwgMjAyNCBhdCA2OjM54oCvQU0gTGkgTWEgPGxpLm1hQGFtZC5jb20+IHdyb3Rl
Og0KPg0KPiBBZGQgYW4gaWYgY29uZGl0aW9uIGZvciBnZnggYWN0aXZpdHkgYmVjYXVzZSB0aGUg
c2NhbGluZyBoYXMgYmVlbiBjaGFuZ2VkIGFmdGVyIHNtdSBmdyB2ZXJzaW9uIDVkNDYwMC4NCj4g
QW5kIHJlbW92ZSBhIHdhcm5pbmcgbG9nLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBNYSA8bGku
bWFAYW1kLmNvbT4NCg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQv
c211X3YxNF8wLmMgICAgICAgfCAyIC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jIHwgNSArKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzAuYw0KPiBpbmRleCAyYWE3ZTk5NDVhMGIuLjdh
YzliYzBkZjhmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxNC9zbXVfdjE0XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTE0L3NtdV92MTRfMC5jDQo+IEBAIC0yMjksOCArMjI5LDYgQEAgaW50IHNtdV92MTRfMF9jaGVj
a19md192ZXJzaW9uKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KPiAgICAgICAgICAgICAgICAg
c211LT5zbWNfZHJpdmVyX2lmX3ZlcnNpb24gPSBTTVUxNF9EUklWRVJfSUZfVkVSU0lPTl9TTVVf
VjE0XzBfMjsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2UgSVBfVkVS
U0lPTigxNCwgMCwgMCk6DQo+IC0gICAgICAgICAgICAgICBpZiAoKHNtdS0+c21jX2Z3X3ZlcnNp
b24gPCAweDVkM2EwMCkpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKHNtdS0+
YWRldi0+ZGV2LCAiVGhlIFBNRlcgdmVyc2lvbigleCkgaXMgYmVoaW5kIGluIHRoaXMgQklPUyFc
biIsIHNtdS0+c21jX2Z3X3ZlcnNpb24pOw0KPiAgICAgICAgICAgICAgICAgc211LT5zbWNfZHJp
dmVyX2lmX3ZlcnNpb24gPSBTTVUxNF9EUklWRVJfSUZfVkVSU0lPTl9TTVVfVjE0XzBfMDsNCj4g
ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGRlZmF1bHQ6DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMF9wcHQuYw0KPiBp
bmRleCA0N2ZkYmFlNGFkZmMuLjkzMTBjNDc1OGUzOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMF9wcHQuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+IEBAIC0y
NjEsNyArMjYxLDEwIEBAIHN0YXRpYyBpbnQgc211X3YxNF8wXzBfZ2V0X3NtdV9tZXRyaWNzX2Rh
dGEoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgICAgICAgICAgICAqdmFsdWUgPSBt
ZXRyaWNzLT5NcGlwdWNsa0ZyZXF1ZW5jeTsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAg
ICAgICAgIGNhc2UgTUVUUklDU19BVkVSQUdFX0dGWEFDVElWSVRZOg0KPiAtICAgICAgICAgICAg
ICAgKnZhbHVlID0gbWV0cmljcy0+R2Z4QWN0aXZpdHkgLyAxMDA7DQo+ICsgICAgICAgICAgICAg
ICBpZiAoKHNtdS0+c21jX2Z3X3ZlcnNpb24gPiAweDVkNDYwMCkpDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICp2YWx1ZSA9IG1ldHJpY3MtPkdmeEFjdGl2aXR5Ow0KPiArICAgICAgICAgICAg
ICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAqdmFsdWUgPSBtZXRyaWNzLT5HZnhB
Y3Rpdml0eSAvIDEwMDsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2Ug
TUVUUklDU19BVkVSQUdFX1ZDTkFDVElWSVRZOg0KPiAgICAgICAgICAgICAgICAgKnZhbHVlID0g
bWV0cmljcy0+VmNuQWN0aXZpdHkgLyAxMDA7DQo+IC0tDQo+IDIuMjUuMQ0KPg0K
