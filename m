Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26D0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 16:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8EF10E4C1;
	Fri, 25 Feb 2022 16:15:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569B010E4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 16:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYM0twrFZVlmmpj0mOaujRulGE5WBOnCMhRjsIG8tGnJPcZnls+O4eIdGZcORc/qk1aUJ0uVQ4DvWWCoQYzI4h6p2uBNHKD8tT79M7C9yUotJ9LS/D2B7m03B21xi680npCdjXf9e593MFqTxrlgg/a2uttvQofp/72bCmj4u5UdstZ5jGYe7mf1uTGwDQUSJFN2AAM8ipn2g3Zwq42GWtcWycQFVDnYI2w/HZLw2+lFsOdSsaZI+JMnMgEa+JKE7ATm8pOQMnn39fH6sn+r8g3rMrUvBqXutJQYeRnIZd56NSic1BlE4hppTOAVsjpKmEvEU1ZwKZiaQLq1URKLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUcQkX+9sWrSBJnMeEMAhR2yG6plQL5gSRLvp/euMe8=;
 b=harjC89OjucsPf7YBiXH1FMQNfa04ywom7qj7m6vhsz+3FWmsG/1BTYbQ/RoBG1Gdqr3krNqWq+Gdf/ClcxVUQkaU6jhehGLLWBJzER+ib4A7xI2r4I8hOZ2YWnxxhui9CFsIjmEwOH8CNR5wQFIuzT1KhjjKoFAkUs54fW9YOI9lzAwNsiiiiR6LRxUekmIPLeOzQuyPewJcKQ3B+P9rfQ31EOYtRZcMpt3Cy9GheXm5pE+zRHQR6g9FFkZtUML09pHmbKIIwlslyX2JdFnT2N3yorckuPgLwhFQTwQ/MrUlw9P7kJgiEKwKcBpWidAntDv+iq4UOSn1wdbBI0iTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUcQkX+9sWrSBJnMeEMAhR2yG6plQL5gSRLvp/euMe8=;
 b=UdnABwIgPN6qFkFv3v+ognJSk3jgPDU4+7M9KnRqCaXeoB5rYWfui8WQ/LyDgXP2fRAZWp0DWy0KVCe/fPCh/IxXOq7giMjhd/P6yHgybEtCmk4OXOyqbe9F4lvWMOG4KmxpBkM2ytQl9agtl382YUZS276IZpZoGrFoZ7S6kNY=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by BN8PR12MB2913.namprd12.prod.outlook.com
 (2603:10b6:408:9c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 16:15:35 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::21a9:57f:b373:3a80]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::21a9:57f:b373:3a80%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 16:15:34 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/display: Don't fill up the logs
Thread-Topic: [PATCH] drm/amd/display: Don't fill up the logs
Thread-Index: AQHYKcf6YmsHiTgnYkqPpPKcJveJTKyjRheAgAAIAICAAR2koA==
Date: Fri, 25 Feb 2022 16:15:34 +0000
Message-ID: <BN6PR1201MB0084E3A5184F7665F6F47B99893E9@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20220224214531.6397-1-luben.tuikov@amd.com>
 <CADnq5_MvPWnrOnNb4Ggm-jUgyg7zq69WAthfZ2bZgTXAYzEG2Q@mail.gmail.com>
 <43b65bd6-b29b-9517-e011-63144e605c4d@amd.com>
In-Reply-To: <43b65bd6-b29b-9517-e011-63144e605c4d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1f0efcbf-96f7-4e39-82fe-f7de23a1016e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T15:52:10Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d495e90-c5f4-479f-b1a2-08d9f87a0db7
x-ms-traffictypediagnostic: BN8PR12MB2913:EE_
x-microsoft-antispam-prvs: <BN8PR12MB2913D017F3BA3A88FCFD1ABB893E9@BN8PR12MB2913.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwyNBXpDeo0IyHNnIGEouPNbtRLhvs9I2NVaMdgLjtshNQ6aTttD9Qr5CQP8cWV2sT1UlY5t6JJM1FA0H+czz6Gp8nbTFtfxpgT/OwgSHS+/egvgwWQAIsnXZ3JqcTJ84MFRSobF6CSPFPDRv3AKuZ4nWiPHfoEq1SYFuN6sSlsHo9QFhN45O1VeF9hiLjQd6ABQncQeJdTQYpSGknIR3eesAgfLY9PMtctK24DhZ4OYu4l2OVFNzAp8wE98A+7bJqCxa98/MGyUz3VkZlOq8d6jV9ZFd8kRgXiBd9ApqRoQ7XEshaQuVhADN7smngoUK4Cj0T1gxH8UEyHib1vTEq/bexfQVyv9QfFXjGjYxvKSc5IdYGNT3VRiuk/rvuwMVS4woUq0pwam0a6l2JtJZNhPudIGBA+Eo31qsq8voOaaqCZ3wju/e8ukkgbiA1G+C8DKvUNyKQAwzYL2THap5rQ4Alh7NLyoI1I7EOymfn0ZPnx2eNrevvtkX9/4pOLC5nIZqmOIFElosIirwCPcNAX+6ZK0N6RlOxi+1Gw7HMRXdDvKQICMcQ24+jEMhDWYnM6zJ8IpFm3JBoTOu2YWKjP3rBjqnp1W0uLRNkTzJfJWEih+PpR/GFvOiL5X0NpUB6mVotrm5dMiyLxjXUPMksyBYb+oQ9mOO7MJkG+gQFYxLIUourXj1WX9BzIXtU/rxnc7rv1DFMYk9WXZkpqu9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(55016003)(316002)(83380400001)(66556008)(54906003)(186003)(122000001)(508600001)(26005)(110136005)(86362001)(38100700002)(38070700005)(71200400001)(4326008)(9686003)(66476007)(66446008)(66946007)(76116006)(8676002)(64756008)(2906002)(7696005)(6506007)(33656002)(52536014)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWN3UHAwN21HRmIxd1RFU1VLLzY1T3RpeVFMVmhHcDBja3gwYkVGRU1NcU5S?=
 =?utf-8?B?eVhvMXVnOG1nc0txVElFVmkvRmc1NUdINW5kVVZsdVI2a1JkVG5FSmgxdmtt?=
 =?utf-8?B?R2svZnhFMkZraC9nMk9CdVRROVRnTmFWSVBpd2FtRFRmQm9ROFVobUNjTFU1?=
 =?utf-8?B?L3RORmh6Y1ZkUlJmeHBFclBZV0kzeHNxTVNRclluZ3VmMG4reDFaVmhqcWp2?=
 =?utf-8?B?TCtkNkxCeEI1d3lWcXpJZ2pYQndaUDF1YXNOS2V5WUVqb3I2THUvTXd2UkJx?=
 =?utf-8?B?TnA0NmlwM3RhSW9ZZFN1d3FrZ0dhcTMvalB0YXR0alFodjNTb0h6bm9sRTAz?=
 =?utf-8?B?VTFWQ1lOOUtGMlBCOFhGZG55SzZZQ1pGUnFTZWU5THYrajRZbUNmQ0ZuTzYv?=
 =?utf-8?B?Tk5lN29HamtiYTBkdCtQeGZjUGplazBTRS9tUzRycmdxWUpnTFVSVWJUY05Y?=
 =?utf-8?B?WDdXK3U1TGJNUDFiRHZTUk8zU0kzM05qTU5YOVBmaUZyeFQ0UWlPMlhPWXpm?=
 =?utf-8?B?cVplVEYvNXZLa0dWejZVTUVBVU8zZ0szM0c3dmwyVDFaeTNHRG03WHhFZ05m?=
 =?utf-8?B?S294SGNtR2ZLdkVjWXN1U3g0bmQ4bzg0aEtrNGJuS1ZRMjBIekZJb3FvTU9j?=
 =?utf-8?B?ZTROUlRUeStMcjR6SVJZaFJLeWs0aXkvb3BENDJ3Yi9WNzBVZS9PQTJta1ZT?=
 =?utf-8?B?b0V3dlF4QUxrTlJqcXgvOEt1eDR5MTVhV2kvNCttdVkxLzRwV0pkMnFiN2t2?=
 =?utf-8?B?alV6OG5qYWFXYkVTL0lwdTh2ZTRzOTI1VFZsSFcvZ0JJN09EdFh5OGtLY1Bp?=
 =?utf-8?B?anh6V1dRYitKalc3YjlxekZCN1lJSUNoVE1CdHF2RzEzcU1tRjY1MFRKdkNy?=
 =?utf-8?B?dHJRTHhLcFJucW1BSC9JZE5YVnIyMEZVSWhFRCt4ZTRUcWRZdkRocnZubmM3?=
 =?utf-8?B?YVpkT2p3RFp2Qnlwd0xHR2hBTUJxaWJBdzEvV2NrZXM2TjBOMEx4QzZocHBh?=
 =?utf-8?B?ZnFtd0g0ZFlyUGo1QXVwMzRkcVNhRDJVTWVPUHJFWkh5c3JQR2RMUTVkTFQ0?=
 =?utf-8?B?SUFRYlhLVnE2L1ZybDJMREVMYWhZQXZyQWdEMmU4bmMzakhVZzBwRHFrdEVq?=
 =?utf-8?B?V3BGZkpNTFN4WVVXaitsUTU3TlJSVzF4VVk2QUsycXJiV1cySUVnaFJjcXFE?=
 =?utf-8?B?T25QcVF5M2UxZDdoYlV1TGNOWmpyQ2V5UmJrQnlqRldVampUQmZnR1hvREZF?=
 =?utf-8?B?cElxNVU3L3lNVThMcWpMSlRBMURaUkJaU0R1U1cwR2poSnpGaEhtU25QOWQw?=
 =?utf-8?B?V2RmaUZNcWtMcnhPUFNWUm1Gcnd6YXUrblR1aTRWRmFSSzh1RUlMeG42NWxC?=
 =?utf-8?B?N1lWd1UxcHJZWjdoOElTUVM0ZWZNOVl6SGJiQ3dmbUpBS252VVpYbWJ2ZGNF?=
 =?utf-8?B?bzBseUVTcGZwM2ZzeU9nWHV6UndIUjh6MzBkOVR6VWtiRXJvRTRrVDVYNTI4?=
 =?utf-8?B?bWJPMFZTdm8ySFFDQStDNWdHSHNZSzQxajVnVFRCSGoxL094NWlLUzlmZldu?=
 =?utf-8?B?SVd6UVFqb0RJZ09KQ2s5ZEgxYjV5QXc5MUtUR29OMzYySk9paDZXWmN2VjR1?=
 =?utf-8?B?OEFBd0VJR0Q4S0dZTDRsd2JFdmgwYlUrS0RJMnYxMGt0YjllSlltZktjMXpn?=
 =?utf-8?B?clc1VkU5ZDk5cWlncnJHcXFFcUl3MWYvZldTOWFEU0QxMUMwVDRycEFNUXRD?=
 =?utf-8?B?ekdqRGRkU1duVmFFZ2YvcS85TmNkL1ZmMnM2VWFpTlVTcUdoQ1A3ZGwvL3VE?=
 =?utf-8?B?N283Mmt4bVFzOVdPbUhBME5HN0dpdUY2UnRzc2R3YTZpK09DLzJ0djdLUU1w?=
 =?utf-8?B?V1dqWERER1BHZjFtMzhIODdZOUZqNVdoUlRjWXZpdkk0YThvT3V2eURNbUtt?=
 =?utf-8?B?T1dXSFUzQ0ljZDQ5THNvL3p0VU1iQ2Y2WUp3OTd4M2d4NTlHS29tVVRYWG9P?=
 =?utf-8?B?YS8xa1lzYUdaQzBEekJOTmdFVHlQak11SWlVQUp1L0w5T1A5WFZUbXFjdmNt?=
 =?utf-8?B?dmRlb1pVVVdwempHc0xIanUwNm5YcDZ0RzJMaXhtRnpuYXExc1hMS2ZzdGRo?=
 =?utf-8?Q?L+FE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d495e90-c5f4-479f-b1a2-08d9f87a0db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 16:15:34.8226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyNBsMGvX2Odwxtu6Y4jxBBYx3uWPgsDxGpaFQjVS5f46T712V6RPO6G7nEJFtgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2913
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRGVmaW5pdGVseSBvdmVyZmxvd2VkIGxvZyBtYWtl
cyBubyBzZW5zZS4NCiJPTkNFIiBpcyBiZXR0ZXIgdGhhbiBub3RoaW5nIGZvciBkZWJ1Z2dpbmcu
DQpXaXRoIHRoYXQgc2FpZDoNCg0KUmV2aWV3ZWQtYnk6IFJvbWFuIExpIDxSb21hbi5MaUBhbWQu
Y29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFR1aWtvdiwgTHVi
ZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjQs
IDIwMjIgNTo1MCBQTQ0KPiBUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgS3Vl
aGxpbmcsIEZlbGl4DQo+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgTGksIFJvbWFuIDxSb21h
bi5MaUBhbWQuY29tPjsgV3UsIEhlcnNlbg0KPiA8aGVyc2VueHMud3VAYW1kLmNvbT47IFdoZWVs
ZXIsIERhbmllbCA8RGFuaWVsLldoZWVsZXJAYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZC9kaXNwbGF5OiBEb24ndCBmaWxsIHVwIHRoZSBsb2dzDQo+DQo+IEkgY291bGQsIGJ1dCBp
ZiB0aGV5IGVuYWJsZSBLTVMgZGVidWcsIHRoaXMgcHJpbnRzIDEwMHMgb2YgdGltZXMgYSBzZWNv
bmQuDQo+IEl0IGxpdGVyYWxseSBvdmVyZmxvd3MgdGhlIGxvZy4gSXQgbmVlZHMgdG8gYmUgcHJp
bnRlZCAiT05DRSIgaW4gd2hpY2hldmVyIG1vZGUuDQo+IEVpdGhlciB0aGF0LCBvciBub3QgcHJp
bnQgaXQgYXQgYWxsLS1pdCBpcyAiREVCVUciIGFmdGVyIGFsbC4NCj4NCj4gUmVnYXJkcywNCj4g
THViZW4NCj4NCj4gT24gMjAyMi0wMi0yNCAxNzoyMSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiA+
IE9uIFRodSwgRmViIDI0LCAyMDIyIGF0IDQ6NDYgUE0gTHViZW4gVHVpa292IDxsdWJlbi50dWlr
b3ZAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4+DQo+ID4+IERvbid0IGZpbGwgdXAgdGhlIGxvZ3Mg
d2l0aDoNCj4gPj4NCj4gPj4gWzI1MzU1Ny44NTk1NzVdIFtkcm06YW1kZ3B1X2RtX2F0b21pY19j
aGVjayBbYW1kZ3B1XV0gRFNDDQo+IHByZWNvbXB1dGUgaXMgbm90IG5lZWRlZC4NCj4gPj4gWzI1
MzU1Ny44OTI5NjZdIFtkcm06YW1kZ3B1X2RtX2F0b21pY19jaGVjayBbYW1kZ3B1XV0gRFNDDQo+
IHByZWNvbXB1dGUgaXMgbm90IG5lZWRlZC4NCj4gPj4gWzI1MzU1Ny45MjYwNzBdIFtkcm06YW1k
Z3B1X2RtX2F0b21pY19jaGVjayBbYW1kZ3B1XV0gRFNDDQo+IHByZWNvbXB1dGUgaXMgbm90IG5l
ZWRlZC4NCj4gPj4gWzI1MzU1Ny45NTkzNDRdIFtkcm06YW1kZ3B1X2RtX2F0b21pY19jaGVjayBb
YW1kZ3B1XV0gRFNDDQo+IHByZWNvbXB1dGUgaXMgbm90IG5lZWRlZC4NCj4gPj4NCj4gPj4gd2hp
Y2ggcHJpbnRzIG1hbnkgdGltZXMgYSBzZWNvbmQsIHdoZW4gdGhlIGtlcm5lbCBpcyBydW4gd2l0
aA0KPiA+PiBkcm0uZGVidWc9Mi4NCj4gPj4NCj4gPj4gSW5zdGVhZCBvZiBEUk1fREVCVUdfRFJJ
VkVSKCksIG1ha2UgaXQgRFJNX0lORk9fT05DRSgpLg0KPiA+DQo+ID4gTWF5YmUgY29udmVydCB0
byBEUk1fREVCVUdfS01TKCkgZm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIHJlc3Qgb2YgdGhlDQo+
ID4gZGlzcGxheSBjb2RlPw0KPiA+DQo+ID4gQWxleA0KPiA+DQo+ID4+DQo+ID4+IENjOiBBbGV4
IERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+IENjOiBSb21hbiBMaSA8
Um9tYW4uTGlAYW1kLmNvbT4NCj4gPj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGlu
Z0BhbWQuY29tPg0KPiA+PiBDYzogSGVyc2VuIFd1IDxoZXJzZW53dUBhbWQuY29tPg0KPiA+PiBD
YzogRGFuaWVsIFdoZWVsZXIgPGRhbmllbC53aGVlbGVyQGFtZC5jb20+DQo+ID4+IEZpeGVzOiA1
ODk4MjQzYmE3YWNkYiAoImRybS9hbWQvZGlzcGxheTogQWRkIGRzYyBwcmUtdmFsaWRhdGlvbiBp
bg0KPiA+PiBhdG9taWMgY2hlY2siKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlrb3Yg
PGx1YmVuLnR1aWtvdkBhbWQuY29tPg0KPiA+PiAtLS0NCj4gPj4gIC4uLi9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgICB8IDggKysrKy0NCj4gLS0t
DQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0DQo+ID4+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYw0KPiA+PiBpbmRleCAw
NTU3M2YwNzNiMjFmNy4uMDU0MjAzNDUzMGIxYjAgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jDQo+ID4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21z
dF90eXBlcy5jDQo+ID4+IEBAIC0xMTk4LDExICsxMTk4LDExIEBAIHZvaWQgcHJlX3ZhbGlkYXRl
X2RzYyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZQ0KPiAqc3RhdGUsDQo+ID4+ICAgICAgICAgc3Ry
dWN0IGRjX3N0YXRlICpsb2NhbF9kY19zdGF0ZSA9IE5VTEw7DQo+ID4+DQo+ID4+ICAgICAgICAg
aWYgKCFpc19kc2NfcHJlY29tcHV0ZV9uZWVkZWQoc3RhdGUpKSB7DQo+ID4+IC0gICAgICAgICAg
ICAgICBEUk1fREVCVUdfRFJJVkVSKCJEU0MgcHJlY29tcHV0ZSBpcyBub3QgbmVlZGVkLlxuIik7
DQo+ID4+ICsgICAgICAgICAgICAgICBEUk1fSU5GT19PTkNFKCJEU0MgcHJlY29tcHV0ZSBpcyBu
b3QgbmVlZGVkLlxuIik7DQo+ID4+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4+ICAgICAg
ICAgfQ0KPiA+PiAgICAgICAgIGlmIChkbV9hdG9taWNfZ2V0X3N0YXRlKHN0YXRlLCBkbV9zdGF0
ZV9wdHIpKSB7DQo+ID4+IC0gICAgICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVSKCJkbV9hdG9t
aWNfZ2V0X3N0YXRlKCkgZmFpbGVkXG4iKTsNCj4gPj4gKyAgICAgICAgICAgICAgIERSTV9JTkZP
X09OQ0UoImRtX2F0b21pY19nZXRfc3RhdGUoKSBmYWlsZWRcbiIpOw0KPiA+PiAgICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPiA+PiAgICAgICAgIH0NCj4gPj4gICAgICAgICBkbV9zdGF0ZSA9ICpk
bV9zdGF0ZV9wdHI7DQo+ID4+IEBAIC0xMjQ1LDcgKzEyNDUsNyBAQCB2b2lkIHByZV92YWxpZGF0
ZV9kc2Moc3RydWN0IGRybV9hdG9taWNfc3RhdGUNCj4gKnN0YXRlLA0KPiA+PiAgICAgICAgIH0N
Cj4gPj4NCj4gPj4gICAgICAgICBpZiAoIXByZV9jb21wdXRlX21zdF9kc2NfY29uZmlnc19mb3Jf
c3RhdGUoc3RhdGUsIGxvY2FsX2RjX3N0YXRlLA0KPiB2YXJzKSkgew0KPiA+PiAtDQo+IERSTV9E
RUJVR19EUklWRVIoInByZV9jb21wdXRlX21zdF9kc2NfY29uZmlnc19mb3Jfc3RhdGUoKSBmYWls
ZWRcbiIpOw0KPiA+PiArDQo+ID4+ICsgRFJNX0lORk9fT05DRSgicHJlX2NvbXB1dGVfbXN0X2Rz
Y19jb25maWdzX2Zvcl9zdGF0ZSgpIGZhaWxlZFxuIik7DQo+ID4+ICAgICAgICAgICAgICAgICBn
b3RvIGNsZWFuX2V4aXQ7DQo+ID4+ICAgICAgICAgfQ0KPiA+Pg0KPiA+PiBAQCAtMTI1OCw3ICsx
MjU4LDcgQEAgdm9pZCBwcmVfdmFsaWRhdGVfZHNjKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlDQo+
ID4+ICpzdGF0ZSwNCj4gPj4NCj4gPj4gICAgICAgICAgICAgICAgIGlmIChsb2NhbF9kY19zdGF0
ZS0+c3RyZWFtc1tpXSAmJg0KPiA+PiAgICAgICAgICAgICAgICAgICAgIGlzX3RpbWluZ19jaGFu
Z2VkKHN0cmVhbSwgbG9jYWxfZGNfc3RhdGUtPnN0cmVhbXNbaV0pKSB7DQo+ID4+IC0gICAgICAg
ICAgICAgICAgICAgICAgIERSTV9ERUJVR19EUklWRVIoImNydGNbJWRdIG5lZWRzIG1vZGVfY2hh
bmdlZFxuIiwgaSk7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIERSTV9JTkZPX09OQ0Uo
ImNydGNbJWRdIG5lZWRzDQo+ID4+ICsgbW9kZV9jaGFuZ2VkXG4iLCBpKTsNCj4gPj4gICAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpbmQg
PQ0KPiA+PiBmaW5kX2NydGNfaW5kZXhfaW5fc3RhdGVfYnlfc3RyZWFtKHN0YXRlLCBzdHJlYW0p
Ow0KPiA+Pg0KPiA+Pg0KPiA+PiBiYXNlLWNvbW1pdDogYmZmOTgwYzc2MzJlZjNiMDA5OWJhMjMw
Y2Y3ZDVjODY0ZGIzZTFhMw0KPiA+PiAtLQ0KPiA+PiAyLjM1LjEuMTI5LmdiODAxMjEwMjdkDQo+
ID4+DQo+DQo+IFJlZ2FyZHMsDQo+IC0tDQo+IEx1YmVuDQo=
