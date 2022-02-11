Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8618DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 06:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF43910E860;
	Fri, 11 Feb 2022 06:26:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE33A10E860
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 06:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2+k91TV2l7nIOge5ugtnnM7S7jbmmzcOpEvMnlQXVGGlKLlcvahaQZFphj2uWBygsTytPzAU0/vAqVucrk2zvqVNWbUEVjq4FVlFRHFLkXqgVdsN36h3c4OmM7EqChVwPVobDeW2iUTojQ3/ytxvDVNbgl+LwvaOJNKdyQFytioBVEYe6hmQsaGezTCtF8Ng09KkEEGnmFfQ2CvVYeFsxa51EG1JTJvD5Z2j0sXqAVvrJET1UvU+ZKH+vlGUrHBR2+aBWH1/EO3TLVGkwGzxuIq5p6WbfT83u2v+8rj5hBD0RELODCSnIFcsiqQZyEqSRpCnPm2hSgK+oQfFQVhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUFWs5QrG0vtspa/AmBOc/ujr8JV5UJiMwCjC2zNGSE=;
 b=OsfNR/CS396802UFJeCbsggIXSMV7lOzt373Y4lRyoSYD6guE46NQiLUa1aBBtgdV4HNVX6BsDeRVhGFlQIj8B2Jv7EOKZhquTFh6xXalkk/hvZu51oNg/TupI2fWqcJqu5rY+4Ksj/O3aBzq02wjpX56RyITq29xwzkFjnMAEb4vUkvuDDpDhqUktjfWE527e6ZATXttN0I0LG3DZCJRwVgiRUVhinQAkkR/dkjXdqhHjCUJzbeua9XfkOCVVivRXJi5A0QNjT7tMzCKI+h6wEqQG5r+HkRDiUrnz6td87WIT1wbsvy6QRicC6yO23Wi4FaNGHn8c5GsJOqOxl5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUFWs5QrG0vtspa/AmBOc/ujr8JV5UJiMwCjC2zNGSE=;
 b=yNDrIpWWD4yF7hFg3hufiye2tUzcNy9KCXYMytKlRTmxvQuAxNpuivEou9D7LAMx7QAO51Lk2lMKIfCngFho3c1aFWXNFMBhJHEW0q8fjiTVDf1cUkHC5fdRHxFylS9iZ/lKReFsEsA5zdrxP+ykMkk1/sNsu1+kKmKTMfLElKY=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 06:26:14 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba%7]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 06:26:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
Thread-Topic: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for
 S0ix.
Thread-Index: AQHYHoMUlwDiOMNB5ECBvoJ2Ivg4g6yM0U0AgAAXUACAAAPdAIAAAYcAgAAF94CAAO6T4A==
Date: Fri, 11 Feb 2022 06:26:14 +0000
Message-ID: <BYAPR12MB32383A0E2E77B4785479ACCDFB309@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
 <BL1PR12MB51574E5BD540B48C975D7502E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_N3fpN=HammdsurdACixsDEbFZ_3P0SD-UEKZ_4gQBSYg@mail.gmail.com>
 <BL1PR12MB51578A1CD77547A902BFA03BE22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51578A1CD77547A902BFA03BE22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T16:08:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0fbf4ff9-c99e-4c93-856d-00692919ad53;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffe413ce-0286-44de-132c-08d9ed27677f
x-ms-traffictypediagnostic: BN7PR12MB2836:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2836F425B7B43C3B71A12A38FB309@BN7PR12MB2836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5eayqd23lXorZYUIDPXDA+k6vGsn9PlmYLZf/XtJG4IVk5vYeWc1jGx4nl2+CyNbK1sJ4WggdqnUGs/abJ6VNIrq7rRRJlkC/UHHBRhL+saeQwk79Ly+WlGUByHqPuhNl5Rn4r5OEjaHqsYBSDu5RRXObY3vMeP+gteQgNRUkrRtIeVusxYFysfZxhHETuk6xHA7D/vvrUExnZQ2rzq0pnn6poVdWVxIAVfPnK7D0BLBKp+c07vdmrSvaCR0WJhFudohEQrALmPPXXWJDBnN7uv8TsuFY2+1d5Yz5RmBX5c6eE1FJNG+2jhp5rVMkx4rmy8sVGcOGPNP15SzCEwbTty/XnpIWpq9PxZacity9sTZocGrK4ZLVgrWYOhXNzc4YGzyYmZVyauzxa1u4ccc4Z/Yk33LvR2X+nkJynjtoO19rdcyT+/xWwXiRSrw/tr/jsGUVAOW5OhTIV6tutKpPnQOPoYjUuESY1Gbr69HTTzt9Gz/QaHdSsYObXyd4pZsag+4fn7lzG50Qmyv5PGVrjE93wv75ZytKXOfdE1pfMHJuJ+WxTf0IoYVL930lccu9IJapwFZQEN/WvMQF1dkiHGPXimfTRbAP+WAbu+AzLZIzBvLVQAJnhGHLF63dNlmN7FRKrkdN1TUjrVKx5VJu7MV/+YMmU5Y00K0k08yo2WW7YGVnTMty7v9OUv++nqAxq3aM+JM6eiHobpVad3DuK194lvko4ywT+rOtS7hSM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(7696005)(86362001)(508600001)(64756008)(66556008)(66446008)(66946007)(76116006)(38100700002)(66476007)(9686003)(4326008)(8936002)(5660300002)(6506007)(52536014)(33656002)(53546011)(8676002)(26005)(4744005)(83380400001)(186003)(54906003)(110136005)(122000001)(55016003)(316002)(38070700005)(71200400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEVSMGx3dVJQcDlBMHd4RnZ3OXdvTGRmQ3dTZlAzS1lPMTRwam5oNi81T3F0?=
 =?utf-8?B?S0t2N09tRm95UUs3UDU3cHdpMFNNMFo4VkVUWUYxVDZVOVRTK3Fnam9IeklF?=
 =?utf-8?B?UWZUWndoM2VWU29JUFMwV2R2QkZham9JcHJqS1gzMXZKSDZ2UFJ5V3RETElI?=
 =?utf-8?B?S0xqWGJyaVFXdFhJSWNxWWpQWTNKWjJmV214NTAxQVRhUXE2YnpIenJleTBL?=
 =?utf-8?B?ejYzalMvNUxuUWhjbnQxeUNzSlE3RTdtL3pBRGUxNzU2MWplMU9yNk00NE9U?=
 =?utf-8?B?ZnVzVjBJelBaZ2pMQU9qc3VTSWRhVjZ5TytTdWF0ZFZFMHJhLzZYdWFwUTlP?=
 =?utf-8?B?YjNSck9BckQvNFJNMzV3N3gySG4zc2ZKcFNqbXY5M2JMcFJsSnVQeGRZYkI4?=
 =?utf-8?B?S0ZMUTlWeVZwVUg1dmtLaERTT1haVjVzMTZQVnh5OGwzTGdoUGlzYXpNVllX?=
 =?utf-8?B?OEtWZGFUUmtSUUJIelljcDIxekJUSkxaNXpuUnp5V3laN1pRSG1HcnI2dWE2?=
 =?utf-8?B?OFMydnpvMi83eUEweDdkWW5xb09SWnVuTjRoWGpjSXVTQkhxM1kxV3hMS1BB?=
 =?utf-8?B?UTljRC9TRStYQXBYdjNtOEJabjdiZk5BZTNjeUFmMDB5MUJTd1E5SjVobVh1?=
 =?utf-8?B?bUl4L1I1Nnd1MTZOU3plREs1blNaNEtFMkZXTFRIRC9tdm5ScC9sQzNHazU2?=
 =?utf-8?B?aUNwazNzNTIxazZZL3pXblF3aWdBVlVVbzd5Y2JCVE0zTG5VS1hWYnJ1OHN1?=
 =?utf-8?B?R1F0RFU5Sk5tOXArTmlPUU1ESmJqREtOZ3g3aitCdXM3bjkxOU1aVC9JMndw?=
 =?utf-8?B?cmV2VWI5N21JLzBaZzBYMXc2M0xLNG5VQjlUaXFDWENnYXFWQTN2LzJzdW14?=
 =?utf-8?B?bm1VdEZLWWNNTHF1MTFPWW83Qyt0SEdYYjRZaHdqTjduY2trV0FYRnY4bXFm?=
 =?utf-8?B?cm9kYXpIY0lBSVJBb3BEdjJEZVRYUzBnbHhqTzlxbUNBUWwxbTJYek1CT3pT?=
 =?utf-8?B?Slo2dHBKeUF2R0s0SG15Y2ZaeFJTajBuOEdENnhObWhxdCtDejZPWXJFZVZu?=
 =?utf-8?B?TzBJT0hNQ1VoZ1l5cjJBVitPcGRMTkZXbUFUeGVMR1hHRXdRcGRuY1BnRWZq?=
 =?utf-8?B?cDRaZnlvV3liZkNwNisvTXg5Ym1EeGlCUmg0STBSUm1jN29hUWdHblgySHl6?=
 =?utf-8?B?aXpSQ210bzR4aVZEUVdPa2cvYkRVcENvUTd4OEQ3TW5sUFU5UFpSV1JWdzRM?=
 =?utf-8?B?anlWNmo3K0dnTnN6UDR4UnU2UG9GeW1nckZtcTZCMWpMYmJPRDNvU3BvbmZv?=
 =?utf-8?B?Qjkxa0pTWFJIUmJ2eXpVcFlTS0lRY2ZWZDBBakJKMG00UVcyN2krUVBhZW1p?=
 =?utf-8?B?M0VSUFcweXZ6UWl0NjA1cDFoYjhhQkJzR3YzUGZOT1NNYytFUTdmbzUxTlVR?=
 =?utf-8?B?UkZHYjNoZzlJL1FYWW9PMk5tSFVHWm9TTDFVUG0wZ2gwdGNuYzBKVDBETngz?=
 =?utf-8?B?cUNCNmtxaGw0N0NoYXgrT2VBMnd0eGZmTEU2cDh3cTJJcDQ5OGRsaDBIT3Fh?=
 =?utf-8?B?Nm4wMUlVWXpDYnA2SUxwdjh4YSs4YkxkRDBMVDEwZStZN2VkVmdMakZFTE9n?=
 =?utf-8?B?OGo0OElVVndOVlU1TUk3V0ZZZWVkOWE2NlVlQXN3Zy9MTlFrNXgrbXZPTWQw?=
 =?utf-8?B?NUR1VE00Yjc2dERDMW5SeXJXTnpXejdXTGN0R29uelZRN3N5bXhPczlmTnA2?=
 =?utf-8?B?TnUvKy9xODM0ZnZrZHhQTlRPeE1WOUFQS09CSWVEd0FGa2hkbWY1WFRhdkpz?=
 =?utf-8?B?bStnb1h3Y3NPZUZ1YkFIKzlpLzFpOVNGaW9tTEREQ1grUmRTRkYvYVhhbWtX?=
 =?utf-8?B?QmdyTzFxNzNKZFVIQTh1RExzVXNKNTFIN0VJbHpZZHRtVk9GSzBGTVpKbExl?=
 =?utf-8?B?TjB5c3hkRzdvVkFnazVTZzEwb3A0TkxBVjFvRkpBN3JGbk5lTHF5YUxNR253?=
 =?utf-8?B?YmZ4RjlUS2dPN1UxOFJWOVVBY3Y5aXdxK3lNN25SSmJteCtVVFBGRm1jNytY?=
 =?utf-8?B?bFFyS08waW9qSnQ0UVFkODJjQzFoQkFmeWpPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe413ce-0286-44de-132c-08d9ed27677f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 06:26:14.3493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3OK7wV72VnaPo0+2JfTodISkS2imyFBrWDc984AzsHF3hYdA6r8ty57G/x6Gdrg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahapatra,
 Rajib" <Rajib.Mahapatra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1h
cmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5
IDExLCAyMDIyIDEyOjA5IEFNDQo+IFRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWls
LmNvbT47IExpYW5nLCBQcmlrZQ0KPiA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IE1haGFw
YXRyYSwgUmFqaWIgPFJhamliLk1haGFwYXRyYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
DQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IFMsIFNoaXJpc2gNCj4gPFNoaXJpc2guU0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBza2lwcGluZyBTRE1BIGh3X2luaXQgYW5kIGh3X2Zpbmkg
Zm9yDQo+IFMwaXguDQo+IA0KPiBbUHVibGljXQ0KPiANCj4gPiA+IFZHIGRvZXNuJ3QgZG8gczBp
MyByaWdodD8NCj4gPg0KPiA+IFJpZ2h0Lg0KPiA+DQo+ID4gPiBObywgWUMgc2hvdWxkIG5vdCB0
YWtlIGEgc2ltaWxhciBmaXguICAgIFlDIGhhZCBhbiBhcmNoaXRlY3R1cmFsIGNoYW5nZSBhbmQN
Cj4gdG8NCj4gPiA+IGF2b2lkIGEgInNpbWlsYXIiIHByb2JsZW0gdGFrZXMNCj4gPiAyNmRiNzA2
YTZkNzdiOWUxODRmZWIxMTcyNWU5N2U1M2I3YTg5NTE5Lg0KPiA+DQo+ID4gSXNuJ3QgdGhhdCBs
aWtlbHkganVzdCBhIHdvcmthcm91bmQgZm9yIHRoZSBzYW1lIGlzc3VlPyAgVGhpcyBzZWVtcyBj
bGVhbmVyLg0KPiA+DQo+IA0KPiBUaGUgU01VIGRvZXNuJ3QgaGFuZGxlIHRoZSByZXN0b3JlIG9m
IHRoZSBTRE1BIHJlZ2lzdGVycyBmb3IgWUMgdGhvdWdoLA0KPiB0aGlzIGV4cGxpY2l0bHkgY2hh
bmdlZC4gIFNvIEkgZG9uJ3QgYmVsaWV2ZSB3ZSBjYW4gZG8gYW4gaWRlbnRpY2FsIGZpeCB0aGVy
ZS4NCj4gDQo+IEBMaWFuZywgUHJpa2UgY29tbWVudHM/DQoNClllYWgsIGluIHRoZSBnZngxMCBz
ZXJpZXMgbG9va3MgdGhlIFNNVSBkb2Vzbid0IGhhbmRsZSBTRE1BIHNhdmUgYW5kIHJlc3RvcmUg
aW4gdGhlIFBNRlcgYW55bW9yZS4gDQo=
