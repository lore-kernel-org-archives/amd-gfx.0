Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9236C4706C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 21:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A0110E4E7;
	Tue,  9 Jan 2024 21:53:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76E710E4E7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 21:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORte71pZfAcUg9xPtYY/yENaX6w7vSMVoq9KGQtknL1ZJx8K5/XSrqoa/brbu5MxbzN3RsDT5PJbDn3qJ1uTQSKYbQCiDUXAusyg6RLPCLWjS1n9rHWn75+3Tp1oRasmm0qKEtDOBqeAjERArsLwDIElhrNhGgmMXzlrUFTTKTIxfFz4OLG+yf0uJ3HyYK1UyWEG0OQRQYRuTclaO19252Zw6+CEfXtx96mNQZekcY7rK5ym5wCjuRARm0REGqFKI2eHwVNw/jTC0mA8OM5SGFlH//quC9WAEuAU6k7R/sJV3IciY9j3bjuwYItod1VE04AhOD6iLH9TC2GcWZHsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StY0EAfq9RVYuu3opHDwTMrFRx2jRb8zGaWn8qFU3NI=;
 b=PsgEYOKzubH4cGvfxDPUXC7iy9n72RviCKRim0RnnllowqiWBCld6zSyYfye6hj8UOSu6nd8B3oZ8DWZiGQSeRIa3b9DWSGE0ajsu8iMjLi4fNsxm1Pby1GqpvmASudaFfih3QJgPFgzol1g7cehDS5WqkVwFZad6dD3HhCzgDLhuCbd7zBr+wfClEJ4mkfEwLyU7nWCls9ZD/O7bO8pRqV4QKgNFytGeDFRF1V/Yfg0YlTA1vOuEfd6OsOA3gElrg9zsrNbPWYRS+6mFanC7zC1MeB2Yiom0zGrTUhjCWeWWuYfvp8NZjneZZjF2dNPoFB0mB80UpSloVOgRPTvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StY0EAfq9RVYuu3opHDwTMrFRx2jRb8zGaWn8qFU3NI=;
 b=cCPIwkEOJHxUrcCnNMKnNKQoJqIFHPz9xEWe3uanl70OxRXLaLN63fpUumKiKwKr26wi9PocnSGkJXcvO9hmrkkUKa6eQk+ZpSguFT3zxEkAjJO38HecVJilw9EX8QARIvgELEx6cUboulMCXvTdGE8BuGXZAmOtPHtV+/e8Fgg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 21:53:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 21:53:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Topic: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Index: AQHaQg5xcJeFw0AC60y3NTa3oyYX3rDQfpSAgAAhGwCAAPZNgIAAWl0AgAAXaDA=
Date: Tue, 9 Jan 2024 21:53:15 +0000
Message-ID: <BL1PR12MB5144B46479ABF320088A4976F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
 <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <Z8njgokdcTunZi6xnF-M7IGXA4_xj14qJE91X07_kII2oHfXkYWS45kIoKR3en9EIFyylWj5U_VFOjZkqcgbN_14JkeMlNtsRc13Jjvro58=@protonmail.com>
In-Reply-To: <Z8njgokdcTunZi6xnF-M7IGXA4_xj14qJE91X07_kII2oHfXkYWS45kIoKR3en9EIFyylWj5U_VFOjZkqcgbN_14JkeMlNtsRc13Jjvro58=@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=27fe85f3-576d-4e79-a42d-4434d887c2df;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-09T21:51:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8478:EE_
x-ms-office365-filtering-correlation-id: a67b29f1-2733-47f1-72cc-08dc115d624e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWY/9BrT1fKAmLzmJYr3HuO8TA+cNnSOsmDQ5E3ZnZDdL3lpXFmQKyTqZ049P+ZY5Vwzqr8jOGZwp2TUZjeHbETMz7Bi5xN5Wq+ybVn6wF9Wc+vOn93ihR6Ip80z9rQpRgkHN/i1mYgjxP97CSvkHNXZTBWU2O8Xi5Qhojwcacnr+0jxO+BVz5G+zLd9TONTOpTRUT1otkjlSwTtmXFbQrsmu++lD2w6erRd8kFs/LTadR73dNW4FNqca97vGYskOA+vccR/g0e4iFiz5QEZas8fVNVbs5ulvlCOUQX8hlJK0aUUAj+ArPrv3ABOhqmaAeDCHa+YzQU6I9meY4lAH5DQ6XXxnMIhOhNHTi+Mel0LGsPepzMrp3HK7LeyglCnY93DRILOjcr1Jcs+yu2S4qZ2hQc+9/TPkIdWxavPb6Td+h8AmFE6QHMlojEY0Tc3vbP1WR6stN/arNPD5SrA9Yu+sVZblafo7MzFFzlsZmwp9Pw8ANeoWt9T0dxQe4HCIFX3gZpFFbN7c08IfsM36L3wMCOK3xRAOCeSwB/qLJQe+7tqWLLv5cWDZ/oN0FzNjpmgOxNBj8T7XlMtwtF/MP/s4mU0rIeguRiVMNlAeGU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(2906002)(478600001)(5660300002)(966005)(52536014)(4326008)(38070700009)(41300700001)(8936002)(316002)(66476007)(66946007)(66556008)(76116006)(64756008)(66446008)(6916009)(38100700002)(33656002)(71200400001)(7696005)(8676002)(9686003)(6506007)(53546011)(86362001)(26005)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNIZDlBWXZOSGVadVNJVmh0eDlpbzQrRFJiS1BvU1Zhbmt0d2hVL0JCczV6?=
 =?utf-8?B?bmloS3dLcnVObGxieGVjU1lhTlh6ZFFZemVzWHFkRjRONjg5TjhMcWZtZXBR?=
 =?utf-8?B?dFp2VVoyV0ErQ1Fab2gvZFlaUVdsbG9zWWlndmMxK1NpbklSMlF1VUs4UW4y?=
 =?utf-8?B?VjdqaG9IOFlzWXBBUlc4Mzg2UXBCLzR0Vm9mbVA4RXk3dXJHTjhYU2ozUHJK?=
 =?utf-8?B?V3hGdEJNSmV5S2FweWcxSmdLN1FVSmE3aC8wWTRTcXI4MFdPUlBjQ1JLSVNL?=
 =?utf-8?B?eEd3dWtvK0FXOHRGUENBTDk1eHIxVmpRUjFLeXVUK1c0WTJsaVZLRjVXdHBX?=
 =?utf-8?B?ZjNWcis5bzR6VEI2cGUrSmtnNVRaamwvTnUzb1o5UE4rT2RoczVmd21Ud256?=
 =?utf-8?B?YjFQcDhMZlA4eXlJS08zbW5JZ3R1TmkzTjU0YVByRHN4UVViZDFwcXZ0OTI5?=
 =?utf-8?B?aUdhT2xyMzZaRFhiVDJKWmhlZU9KbzBIeVVKakNzdGpPczZCb1ZXSlpidzYv?=
 =?utf-8?B?MGxpbVpIYXc1Y2JwUVBqV3NtV1FwbVdJY21QQ0Z1ZXd3b0IxaEN1dTN1VlpC?=
 =?utf-8?B?bDRtaHpLV1kwUXM3Mkc3ZVNpc0paTFZrNlBRVHlWdG1CUTJhTVYrdHpLVDRF?=
 =?utf-8?B?SXpudmdpUDI3QUF1Z0RZU0UwRFlabnB6TTZHUVNlQW52UlhFUEpraVB3K3dC?=
 =?utf-8?B?M1ZOUmtUSjNiSzVXRk5SOG1SOEVjaG42d3hLYmFxK3ZVeVhMcE5tM0RjWExj?=
 =?utf-8?B?RERkT05aRktWK205NVh6SEZQL04vaXY0WktHVlZkOUd5dElZK0d4RjR3cHE3?=
 =?utf-8?B?ZW53ZFQ4U2d1eVF0QVBtT1hpRWxUM3JYTEpKbDNtcFAzQlRhSFlQOGd5WGlB?=
 =?utf-8?B?NTZBcGNDcTRoNW94MlNheVJDVXVOQUxTZk81Z2ZPS2NtdmtPR2M2ejB4N1BS?=
 =?utf-8?B?bWg0R0pyd2ZsT2pyaWRwd3RDZnVXSDRxZkZYZXFSRmVBajZsMVhZZDJPREFZ?=
 =?utf-8?B?MzdXUGltT3N6Q05FOENaUWpOcUl5OXAzQ2g1VDhMQmJLaUhFR2w2bWVDSnZI?=
 =?utf-8?B?Uk5IZDNneWRuR0VUbzRTbVJkYWdPQjFSdEUwUkZoaE5oQzlZVFQxcWxqNDc1?=
 =?utf-8?B?cG1mdmlCbTQrN2NiTTY1aCtlOVgrYmY3M1l1K0w3LzRja1hwQlpETDBtbWVl?=
 =?utf-8?B?SzNYUEU2bG5Pc09sSkswRU0xM2NZaW5MbTRmSGpCQ3pZTmtPYlZxV1Z2RGdu?=
 =?utf-8?B?dUlqU0V5T3hHTjluWW1ybWhUVTZja3NNT0EvMkJvY2kvZE9sSWIrMUZsRlFH?=
 =?utf-8?B?NUQza08wV0pMK1JLYncyN0ZTelFzdHBoMGQ0cUxQQm9BbW5JSXJZaDR5QXQ1?=
 =?utf-8?B?ZGJvUHBzVHJGVGRxaWZLQWQwSTZOL01Qejk4Rlp0Tk9teDJBaEZTcUpIdlpX?=
 =?utf-8?B?YVNJQmNkclFjWTBHRUowb0FoQjA1Z3dlRmt0U2FXajZ1UlZtSnQ3YWxSVG9U?=
 =?utf-8?B?aC82MkpKcS9uV3MvZjdTcU02ZkhNbEw2ZE9DYzd0MG9HRy8vR2JucTZRVXlz?=
 =?utf-8?B?SXltNW5sajdoNGhZQmxpYjN2TGx3RXhaVmxBSkR0WnFtMjR6R2IzNjVIZ0s2?=
 =?utf-8?B?UnhtVllEbnRveE8vSmEvL1J1WGxkN3Rsbmt4QVh5NWtEVm5aT0VvczFJS1hX?=
 =?utf-8?B?OVZJd0NmbDZkOG53dmlpYTlQZ1FOMGo0MzZ2dFREQk9PeGVtaW9QcEx6cGpk?=
 =?utf-8?B?QUwwV1N3NkhVQ25RdVcvNExzMXZjR3dvU0lXaExaRkVJTDVabG9kZGloelh3?=
 =?utf-8?B?Um5sSHR4UlAvcXNRaC9scE9aTWJwVWs1bnkreUcwVU9kKzduZDVzcjlja2Mw?=
 =?utf-8?B?dmpzeWNFT01vL1o1RTIwNzAybTNLSEtvWlg4dVFBbVlFbXljT1BrQWEwYmd4?=
 =?utf-8?B?VnplY09HSUV5ZDJjT0lIM0RZUVJROWVBbHpabWxoNUdDR2IzS2kzVnZnelN1?=
 =?utf-8?B?TElSL2Uzd3c4cDlqREZURmt6UHN3eDYxZGRoazVWVWdJbllyQXRWdFczYjZ0?=
 =?utf-8?B?N2VNcDVhRGRmZG9ta2VYZ2tINnlsYkZzeXdvVFZZYTFmdjI0NzJMbmdSbXp1?=
 =?utf-8?Q?b19I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b29f1-2733-47f1-72cc-08dc115d624e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 21:53:15.8579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxGWKKl9jJwTBksfKMw9O9EZrlOqo7j9pqkmFt+uhA1jevpLGqpZKFBMT3Y5/8qCi2GdRUU+hNOd9774FGmp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEtvc2tvdmljaCA8QUtvc2tvdmljaEBwcm90b25t
YWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA5LCAyMDI0IDM6MjcgUE0NCj4gVG86
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJFOiBEb2N1bWVudGF0aW9u
IGZvciBSR0Igc3RyaXAgb24gUlggNzkwMCBYVFggKFJlZmVyZW5jZSkNCj4NCj4gRG9lIEFNRCBo
YXZlIGRvY3VtZW50YXRpb24gb24gdGhlIGkyYyBkYXRhIHRoYXQgZ2V0cyBzZW50IGN1cnJlbnRs
eQ0KPiB0aG91Z2g/IEkgd2FzIGhvcGluZyB0byBmaWd1cmUgb3V0IHdoYXQgeW91IG5lZWQgdG8g
Y2hhbmdlIGluIHRoZSBjb21tYW5kDQo+IHRoYXQgZ2V0cyBzZW50IHRvIGNoYW5nZSBzdHVmZiBs
aWtlIGJyaWdodG5lc3MsIGNvbG9yIChyZWQsIGdyZWVuLCBibHVlKSwgcmFpbmJvdywNCj4gbW9y
c2UgY29kZSwgZXRjLg0KPg0KDQpJdCBkZXBlbmRzIG9uIHRoZSBMRUQgY29udHJvbGxlciB1c2Vk
IGJ5IHRoZSBBSUIvT0VNLiAgVGhlIHByb2dyYW1taW5nIHNlcXVlbmNlIGlzIGRlcGVuZGVudCBv
biB0aGUgTEVEIGNvbnRyb2xsZXIuDQoNCkFsZXgNCg0KDQo+IE9uIFR1ZXNkYXksIEphbnVhcnkg
OXRoLCAyMDI0IGF0IDEwOjEwIEFNLCBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPg0KPg0KPiA+DQo+ID4NCj4gPiBbUHVibGljXQ0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxleGFuZGVy
IEtvc2tvdmljaCBBS29za292aWNoQHByb3Rvbm1haWwuY29tDQo+ID4gPiBTZW50OiBNb25kYXks
IEphbnVhcnkgOCwgMjAyNCA3OjIyIFBNDQo+ID4gPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20NCj4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiA+ID4gU3ViamVjdDogUkU6IERvY3VtZW50YXRpb24gZm9yIFJHQiBzdHJpcCBv
biBSWCA3OTAwIFhUWCAoUmVmZXJlbmNlKQ0KPiA+ID4NCj4gPiA+IEN1cnJlbnRseSB0aGUgcmVm
ZXJlbmNlIGNvb2xlciBmcm9tIEFNRCBkb2VzIG5vdCBoYXZlIGFuIGV4aXN0aW5nDQo+ID4gPiBS
R0IgY29udHJvbGxlciBmb3IgT3BlblJHQiwgdGhhdCdzIHdoeSBJIHdhcyBsb29raW5nIGZvcg0K
PiA+ID4gZG9jdW1lbnRhdGlvbiBvbiB0aGUgSTJDIGNvbW1hbmRzIHRvIHNlbmQgdG8gdGhlIHNl
Y29uZCBTTVUsIHNvIEkNCj4gPiA+IGRvbid0IHJpc2sgYnJpY2tpbmcgbXkgY2FyZCBieSBzZW5k
aW5nIHdyb25nIGNvbW1hbmRzIGR1cmluZw0KPiBkZXZlbG9wbWVudCBzb21laG93Lg0KPiA+ID4N
Cj4gPiA+IHdyaXRlU2V0Q01EV2l0aERhdGE6DQo+ID4gPiAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiA+ID4gYWRsaTJjLmlT
aXplID0gc2l6ZW9mKEFETEkyQykNCj4gPiA+IGFkbGkyYy5pQWN0aW9uID0gQURMX0RMX0kyQ19B
Q1RJT05XUklURSBhZGxpMmMuaUFkZHJlc3MgPSAweGI0DQo+ID4gPiBhZGxpMmMuaVNwZWVkID0g
MTAwDQo+ID4gPiAwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiBEZXYgMDogQURMX0Rpc3BsYXlfV3JpdGVBbmRSZWFkU01VSTJDKDAsICZh
ZGxpMmMpID0gMA0KPiA+ID4gYWRsaTJjLmlEYXRhU2l6ZSA9DQo+ID4gPiAyNCBpMmNEYXRhWzBd
flsyNF0NCj4gPiA+IDQwIDUxIDJjIDAxIDAwIDAwIGZmIDAwIGZmIGZmIGZmIGNjIDAwIGNjIDAw
IDAwIDAwIGZmIGZmIGZmIGZmIGZmIGZmDQo+ID4gPiBmZg0KPiA+ID4NCj4gPiA+IEZyb20gdGhl
IFJHQiBhcHAncyBsb2dzIHRoaXMgaXMgYW4gZXhhbXBsZSBvZiB3aGF0IHRoZSBvZmZpY2lhbCBB
TUQNCj4gPiA+IGFwcGxpY2F0aW9uIG9uIFdpbmRvd3MgaXMgc2VuZGluZyB3aGVuIGl0IGNoYW5n
ZXMgY29sb3JzIG9uIHRoZSBSR0Igc3RyaXAuDQo+ID4gPg0KPiA+ID4gRnJvbSB0aGlzIGNhbiBp
dCBiZSBhc3N1bWVkIHRoZSBBTUQgY2FyZCBpcyB1c2luZyB0aGUgbGF0dGVyIG1ldGhvZA0KPiA+
ID4geW91IG1lbnRpb25lZCB3aXRoIHRoZSBzZWNvbmQgU01VIEkyQyBidXMsIGluIHdoaWNoIGNh
c2Ugbm8gZHJpdmVyDQo+ID4gPiBjaGFuZ2VzIHdvdWxkIGJlIG5lZWRlZD8NCj4gPg0KPiA+DQo+
ID4NCj4gPiBJSVJDLCBlYWNoIEFJQi9PRU0gdXNlcyBpdHMgb3duIHByZWZlcnJlZCBSR0IgY29u
dHJvbGxlci4gVGhlIHJlZmVyZW5jZQ0KPiBib2FyZCBqdXN0IGRlZmluZXMgd2hpY2ggaTJjIGJ1
c2VzIGNhbiBiZSB1c2VkLiBUaGUgUkdCIGNvbnRyb2wgYXBwbGljYXRpb24gaXMNCj4ganVzdCBh
IHVzZXJzcGFjZSBhcHAgcHJvdmlkZWQgYnkgdGhlIEFJQi9PRU0gdGhhdCBjYWxscyBBREwgdG8g
dGFsayB0bw0KPiB3aGljaGV2ZXIgaTJjIGJ1cyB0aGUgdmVuZG9yIHB1dCB0aGVpciBSR0IgY29u
dHJvbGxlciBvbi4gT24gTGludXggeW91IGNhbiBkbw0KPiBzb21ldGhpbmcgc2ltaWxhciB1c2lu
ZyB0aGUgaTJjX2RldiBtb2R1bGUgdG8gb3BlbiBhIGNvbm5lY3Rpb24gdG8gdGhlIGkyYw0KPiBi
dXMgZHJpdmVyIHByb3ZpZGVkIGJ5IHRoZSBrZXJuZWwuIEkgYmVsaWV2ZSB0aGF0IGlzIHdoYXQg
b3BlblJHQiBkb2VzIHRvZGF5Lg0KPiBJdCBsb29rcyBsaWtlIHlvdSBhbHJlYWR5IGhhdmUgdGhl
IHByb2dyYW1taW5nIHNlcXVlbmNlIGFib3ZlLg0KPiA+DQo+ID4gQWxleA0KPiA+DQo+ID4gPiBP
biBNb25kYXksIEphbnVhcnkgOHRoLCAyMDI0IGF0IDU6MzIgUE0sIERldWNoZXIsIEFsZXhhbmRl
cg0KPiA+ID4gQWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbSB3cm90ZToNCj4gPiA+DQo+ID4gPiA+
IFtQdWJsaWNdDQo+ID4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+ID4gPiBGcm9tOiBhbWQtZ2Z4IGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmcgT24gQmVoYWxmIE9mDQo+ID4gPiA+ID4gQWxleGFuZGVyIEtvc2tvdmljaA0KPiA+ID4g
PiA+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSA3LCAyMDI0IDExOjE5IFBNDQo+ID4gPiA+ID4gVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiA+ID4gU3ViamVjdDogRG9jdW1l
bnRhdGlvbiBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5MDAgWFRYIChSZWZlcmVuY2UpDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBIZWxsbywNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgd2FzIHdvbmRlcmlu
ZyBpZiBBTUQgd291bGQgYmUgYWJsZSBwcm92aWRlIGFueSBkb2N1bWVudGF0aW9uDQo+ID4gPiA+
ID4gZm9yIHRoZSBSR0Igc3RyaXAgb24gdGhlIHJlZmVyZW5jZSBjb29sZXINCj4gPiA+ID4gPiAo
aHR0cHM6Ly93d3cuYW1kLmNvbS9lbi9wcm9kdWN0cy9ncmFwaGljcy9hbWQtcmFkZW9uLXJ4LQ0K
PiA3OTAweHR4KT8NCj4gPiA+ID4gPiBJdA0KPiA+ID4gPiA+IGxvb2tzIHRvIGJlIGhhbmRsZWQg
dmlhIEkyQyBjb21tYW5kcyB0byB0aGUgU01VLCBidXQgaGF2aW5nDQo+ID4gPiA+ID4gcHJvcGVy
IGRvY3VtZW50YXRpb24gd291bGQgYmUgZXh0cmVtZWx5IGhlbHBmdWwuDQo+ID4gPiA+DQo+ID4g
PiA+IEl0IGRlcGVuZHMgb24gdGhlIEFJQi9PRU0gYW5kIGhvdyB0aGV5IGRlc2lnbmVkIHRoZSBz
cGVjaWZpYw0KPiA+ID4gPiBib2FyZC4gVGhlIFJHQiBjb250cm9sbGVyIHdpbGwgZWl0aGVyIGJl
IGF0dGFjaGVkIHRvIHRoZSBERENWR0ENCj4gPiA+ID4gaTJjIGJ1cyBvbiB0aGUgZGlzcGxheSBo
YXJkd2FyZSBvciB0aGUgc2Vjb25kIFNNVSBpMmMgYnVzLiBUaGUNCj4gPiA+ID4gZm9ybWVyIHdp
bGwgcmVxdWlyZSBjaGFuZ2VzIHRvIHRoZSBhbWRncHUgZGlzcGxheSBjb2RlIHRvIHJlZ2lzdGVy
DQo+ID4gPiA+IGRpc3BsYXkgaTJjIGJ1c2VzIHRoYXQgYXJlIG5vdCB1c2VkIGJ5IHRoZSBkaXNw
bGF5IGNvbm5lY3RvcnMgb24gdGhlDQo+IGJvYXJkIHNvIHRoZXkgY2FuIGJlIHVzZWQgYnkgM3Jk
IHBhcnR5IGFwcGxpY2F0aW9ucy4NCj4gPiA+ID4gQ3VycmVudGx5IHdlIG9ubHkgcmVnaXN0ZXIg
aTJjIGJ1c2VzIHVzZWQgZm9yIGRpc3BsYXkgY29ubmVjdG9ycy4NCj4gPiA+ID4gVGhlIGxhdHRl
ciBidXNlcyBhcmUgYWxyZWFkeSByZWdpc3RlcmVkIHdpdGggdGhlIGkyYyBzdWJzeXN0ZW0NCj4g
PiA+ID4gc2luY2UgdGhleSBhcmUgdXNlZCBmb3Igb3RoZXIgdGhpbmdzIGxpa2UgRUVQUk9NcyBv
biBzZXJ2ZXIgYW5kDQo+ID4gPiA+IHdvcmtzdGF0aW9uIGNhcmRzIGFuZCBzaG91bGQgYmUgYXZh
aWxhYmxlIHZpYSBzdGFuZGFyZCBMaW51eCBpMmMNCj4gPiA+ID4gQVBJcy4gSSdtIG5vdCBzdXJl
IHdoYXQgaTJjIExFRCBjb250cm9sbGVycyBlYWNoIEFJQiB2ZW5kb3IgdXNlcw0KPiA+ID4gPiBv
ZmYgaGFuZC4gaHR0cHM6Ly9vcGVucmdiLm9yZy9pbmRleC5odG1sIHdvdWxkIHByb2JhYmx5IGJl
IGEgZ29vZA0KPiByZXNvdXJjZSBmb3IgdGhhdCBpbmZvcm1hdGlvbi4NCj4gPiA+ID4NCj4gPiA+
ID4gQWxleA0K
