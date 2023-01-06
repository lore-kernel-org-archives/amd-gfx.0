Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A3AC3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 02:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D4410E825;
	Fri,  6 Jan 2023 02:14:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1C910E825
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 02:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc2tOJxCdkuFLPC3vBNSFsvRwkmR4bkv8m2CgppKwT0kf2yjj2tfkNX1XDrrVm0lDcZK2mXflJI1gVJTHrvTEsxsxTrbPSK/iHpxaxrrtyad6yQ2JoL9cMbfWLc0TWv3CMfPIBvLbc1ebwydY1uvW0Ml/jtmFEh9kwNg3MY58UG+nu9Ig0StdgnFaMnArkDn0gp4ExEBij7w+5/NIZu0nePPcE4T/dGOLyH13v75FBcSAKnMzrDt3bURiYHb8NN0j3oBlHUltp4ZgdVswNlJ5DMlVgMpQGR0HL+bb2x5Y3TFUYCFjGBwI/GauyCi53xSiJN0hALc9j+pF+mLnewlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X93CN7WyxzxIu//CPcARv2uwtzoe8XmW8yImPsYRZic=;
 b=NqhuvTR7lWbArWweRflnXrmg5EOZ3vih9SIYLjSJRqx193Sw7CgDuIQ52hexdGpbeDxvO3k4igRYPlrmUCAavEjzZrR43jn8RVFqI78r58v04fcmqm8K4W/+0RGSDA5Ga9Ru7i8Cs23WOgnMq1Rn1cPrrkuSkytfpiLYcGs47L+zbDMEG5sMBg+N84tVZ8wX+y3l2GuKZ1hcqhzebt+wkjImBiMIuNvErxOKj+UygV7AKmXk3V8GK1UplbDC8KkLAAh3W6GJncvpS6MN9HYmjSefUqY7PdZUCOYxguI8tNs6FGlkcB/cPeqsxpCWoDGISNoHzKfrRP6jxD/FIIlB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X93CN7WyxzxIu//CPcARv2uwtzoe8XmW8yImPsYRZic=;
 b=YyVAMfzN5bvlDmi0n3zrmLLU+0qp/plNEp5Q3SDPQiaDXgyH26LBuIab0YE2xTNIWoURqd1IdgLMBBd7tOQBqnV3LxvJNcnIBUQndPBBrRgcOlHCCoH+T3cinsWFIYCU3BOz7fnn8c+L3SAUxP4N4pdG53z488imzW0o8SDfoMQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 02:14:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 02:14:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.0
Thread-Topic: [PATCH 7/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.0
Thread-Index: AQHZILUVUPoHqDeJvESAi8m9X+tJTq6P3OGAgADIJOA=
Date: Fri, 6 Jan 2023 02:14:22 +0000
Message-ID: <DM6PR12MB26196E46B21ED7F3DC2F07B7E4FB9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-7-evan.quan@amd.com>
 <5bb75811-629a-4cb3-49e2-accd7e7ec23c@amd.com>
In-Reply-To: <5bb75811-629a-4cb3-49e2-accd7e7ec23c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-06T02:14:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=91419007-fab9-48ad-af55-3c39e6da520b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|PH7PR12MB5925:EE_
x-ms-office365-filtering-correlation-id: 619935b6-3704-42d1-5fc4-08daef8bba12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/LT6sz8gQ2VCLW6rGvt2RgL+p3imesOqHU3Zz5fF8yKySpvRHD7Yqpur2/yHjyjAKvSTLFhldjwv65CQuZPRTv1PWXzPV8IidHyMBaonsKeNqqaaDGgeOBy1vwa+0PO0EV0hzIrB4RfJy8MD42yg9bPc0pe1ze69jxQ+Q9IjS0VcDiXYZsiJQ0L7qKQmt1JSeirNCiWbiThSIDn+USOtyKwzBprk1Nfe6AHK/qMOsMxijRc8/9xiSwaIAECI0tloPbVYexexWAG2kA41rd6SubV+g9hwUfh1hE/+CR+Oa5Ej/+FNRWFrB2Vj2zJj1XfxYieLuLiGKomch7pfhvrbsp3/Ls6xvEfVO9ax6VgcpHoi5PHczDkl5YOJF/tX0t4aGSk887jYOYRu2zN4cv4TyhSXzaxOmvflsJLG9iyZd16NTxylfppVdGoCfH8JOdyG2SMbZki1SWY4BXIhj9P8p/mP2LYHgT5AdR6kAwOf65jPfC2yvChcEkBdV5KjtP8d1WH5rdlgHI4Qwj9hH4W3oYVgw3eUZMFg1E57pUUoUmw20ZQdJDk9RewT318vHtd6C+Yx5M4orxMieOaLR0t8QO+lsCf2y4R2XVncASEIJMzPtmEifWgNXXSdslrf0iccIHxoWrtLGrIZS+IlXnOYR8YFLAhG/IN7mWd4o5+plR0VrgW3n2ZfBM7b0yvHYElL1y49a5g2CpwVct7/tfwCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(9686003)(186003)(26005)(71200400001)(478600001)(6506007)(110136005)(53546011)(7696005)(8676002)(66556008)(66946007)(4326008)(66446008)(64756008)(41300700001)(8936002)(76116006)(52536014)(66476007)(83380400001)(5660300002)(2906002)(55016003)(122000001)(33656002)(38070700005)(38100700002)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TldFWlYrL25adzNGSUlQNUlNSUFtUVBFV0w5aERSYVU2eklZVVI2MkxiSGx6?=
 =?utf-8?B?eFU1blVNSkwzTlJaTG1SMzRZd1NsV01yNGl6YnRRelRxNGo0QjFhYy9RdDNr?=
 =?utf-8?B?STQzWlBobi9tYnQvWUs0U1EydUZwME5BR2twTVpPaWxnQWhRR2lTZlU3akVJ?=
 =?utf-8?B?S014TTBjYytTRGo1TXdOSEJaN1Axbk9ZaG16UmhFUHRQSHV3cjRodHlXa09D?=
 =?utf-8?B?cGt3RVpWMnM0MWgxN0tUdHBKYnNsSFZMZngwZmxOVTN6dS9sSlNmUnp2N0tr?=
 =?utf-8?B?MUFPV25ueVBVZWVJYkxXYVpZSlovWkhuQU1lVS9LUEZPQWZtZTJTVGJwcGVr?=
 =?utf-8?B?d3FIcUdnMmdFZlNHTldCZ0lZbU5tZk5qWjBPMkx0T3BmRUV4bmFhWVJuU3Fm?=
 =?utf-8?B?T0k1ODFqZDduZ21ydWtFcUUvOWNNSTkvc2hrZTN4R1RodHBHb3UrdEM1OWtJ?=
 =?utf-8?B?STR6TGpsY3UyMHJmOFdLazdRQThmK3JwUWtCQ1NucXJFWjNLalhLeHZ5N0My?=
 =?utf-8?B?bmlNczJWYStWeUpHbzdXRmNyRDFGTkVObVFCMXMxRG5ZZ0RPZDY4ZFZVUG55?=
 =?utf-8?B?eS9QRm8zbENzZUNLVXRWSHErSld5Z1c0Z1BwUGYrT0szeUE1YmRyL1NxZTh1?=
 =?utf-8?B?S3VuTEtJelR0RmppalpiU2lreEx6dEU2ZlNWV1BDZzhHS1Y1Q2lpVTZaYUNI?=
 =?utf-8?B?VjRDT2NMUWdrbzV2WUVwVHhGSFFmanpqRGdueXhrOVVmamoydXpvdGV1V04y?=
 =?utf-8?B?VU5lSmlkN095TnBpY3EwZjFVTktGM3ZaNkd4Tk5UT2I1YWsxOVhZaGNqRXl5?=
 =?utf-8?B?Sk93b3k1alhFKzc5UzhBc1VMWWhtU3c2Rkw1R2VWYnBHbmxZWVlZVlBtc2Vz?=
 =?utf-8?B?Z1lqdElpYWwybXVIR0RnQ0Y2bjRRTzdFQXdZVnl1dnJBT3dXdHdKN09mLzNW?=
 =?utf-8?B?RER2d2ZKWUxtUGdOdklaNG8yaGZBNUdMOGFBbEFwb3EzOEVld1J0T1NWbitl?=
 =?utf-8?B?ditKUjdMZVl2Q2x2dlNsUTdSRmp5MktzTTJZRS9qbHlRRGFwSVpSdzJVdUFT?=
 =?utf-8?B?SFBjWnNFZkJPNFVRd0t4WStRcllzOGhBS3FxZXZVT3IyQ2FjdjQrNml6SDEx?=
 =?utf-8?B?d2pIZnRHYkt1MkZjTXBVNFk3MG5WSnZsWW1pOXJEVm9RYkFWb3hSTnhEeWE1?=
 =?utf-8?B?aE9ndXRESksyMkhwekprYWpYRmR0dkVaRVA0UER1SGxQa0NPOXZDbDArblZZ?=
 =?utf-8?B?K3pKbVNTd2hoU1pXeU1sdVZQQlRJV1orMnZkdm5xd3VDZ1lUZnZ4Y2FkVjZq?=
 =?utf-8?B?dk9ad09Yd2hLcVkrTUQxRDM3Z2U3T0pFNE9GVkVwbjVpVlZ2ZXZmS2NoK0U5?=
 =?utf-8?B?MzhQYktsNVlzajJ2Tkl4ei84YXFRSzY5QmtxQTFPWWtNS2NCTVpHS1FCMHgr?=
 =?utf-8?B?THR4OEtWZGdPdVpLOFpiYS96eTRaK2VHUjRHcHYzdUg5SlRnaVNXUzBOemdM?=
 =?utf-8?B?TlFULzZuVjB1Ukh5K3pxNWc1SjRMODdKdDhBK0tvMm93Mi9OY252U3ZXOG01?=
 =?utf-8?B?c3J2SVZwQ3lBaXQzQ3k4MUxpZW1lQ0dHcWljNnR5Zml5RDF1UGc1TzBjbjVi?=
 =?utf-8?B?NFVlNS9RczJwaFlVYkwzZzY4V2lvcjJYbFBvY09VMDNTUUxscGorRDdxbUdO?=
 =?utf-8?B?QTA2eVNPMlNBazVxekdiQ2tDZm4vOWpMZno5ZFZ5dTgzaHhwa2MwU3FxTllB?=
 =?utf-8?B?eE1vUjdTUzMwamFTK2VQbytnTGdPU1NIWGQvcHhZSUdPRDlRS1JOWjRqbHdB?=
 =?utf-8?B?dDlTMHA3dXdwS2t1UHZuaEs3K1BpVE8xejdCNWNoL1NQUDg0T3hrS2ZyWENa?=
 =?utf-8?B?TjZQNGR2d3l6SnJ3UE5zd2UxbTgvOWhVQ0xDMW14b3FKSEdrR0NIbVFIL0RB?=
 =?utf-8?B?MnM2UlBTTWFldFdVTldZd2tYTGpTdzN4Tm5NcE0zSGVVTitYMVlRRm5lM3BV?=
 =?utf-8?B?MnNNTnVkLzNsQkZqKytyVDhSdE9BblRDdW1DOFJqQnJaa3IrRnRRYVRXQ3hK?=
 =?utf-8?B?Z3BlLzA3YmJucExMb0lkTXZJZ29vQXkvOGpDbk8ybk5Nc25DaHdBMW5FRFM3?=
 =?utf-8?Q?brcs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619935b6-3704-42d1-5fc4-08daef8bba12
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 02:14:22.6980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+P5YeA3ML8HyboNkSjWv8sXZPa97QedyX0mbW+/g0mtEIlq3iLRxQZTJSt83bcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDUsIDIwMjMgMTA6MDggUE0NCj4gVG86IFF1YW4sIEV2
YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA3LzhdIGRybS9hbWQvcG06IGRyb3AgdGhlIHN1cHBvcnQgZm9yIG1h
bnVhbCBmYW4NCj4gc3BlZWQgc2V0dGluZyBvbiBTTVUxMy4wLjANCj4gDQo+IA0KPiANCj4gT24g
MS81LzIwMjMgODo1MiBBTSwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+IER1ZSB0byBsYWNrIG9mIHN1
cHBvcnQgZnJvbSBQTUZXLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFu
LnF1YW5AYW1kLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEk1ZDQ2NmQzZDUyMWIyNmE0ODRiZDgzN2Ux
NzNiOWIyODlkNDAyMGVjDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jIHwgNSArKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+ID4gaW5kZXggNzVjOWY1
MTBlNzEzLi41OWNkNjg4NjI5NzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMNCj4gPiBAQCAtMjA2MSw0
ICsyMDYxLDkgQEAgdm9pZCBzbXVfdjEzXzBfMF9zZXRfcHB0X2Z1bmNzKHN0cnVjdA0KPiBzbXVf
Y29udGV4dCAqc211KQ0KPiA+DQo+IEJJVF9VTEwoQU1EX1NZU0ZTX0lGX1BQX0RQTV9EQ0VGQ0xL
X0JJVCkgfA0KPiA+DQo+IEJJVF9VTEwoQU1EX1NZU0ZTX0lGX1BQX1NDTEtfT0RfQklUKSB8DQo+
ID4NCj4gQklUX1VMTChBTURfU1lTRlNfSUZfUFBfTUNMS19PRF9CSVQpKTsNCj4gPiArCS8qIERy
b3AgdGhlIHN1cHBvcnQgZm9yIG1hbnVhbCBmYW4gc3BlZWQoUlBNIGFuZCBQV00pIHNldHRpbmcg
Ki8NCj4gPiArCXNtdS0+YWRldi0NCj4gPnBtLmh3bW9uX2lmX2F0dHJfbW9kZVtBTURfSFdNT05f
SUZfUFdNMV9FTkFCTEVfQklUXSAmPQ0KPiB+U19JV1VTUjsNCj4gPiArCXNtdS0+YWRldi0NCj4g
PnBtLmh3bW9uX2lmX2F0dHJfbW9kZVtBTURfSFdNT05fSUZfUFdNMV9CSVRdICY9IH5TX0lXVVNS
Ow0KPiA+ICsJc211LT5hZGV2LQ0KPiA+cG0uaHdtb25faWZfYXR0cl9tb2RlW0FNRF9IV01PTl9J
Rl9GQU4xX0VOQUJMRV9CSVRdICY9DQo+IH5TX0lXVVNSOw0KPiA+ICsJc211LT5hZGV2LQ0KPiA+
cG0uaHdtb25faWZfYXR0cl9tb2RlW0FNRF9IV01PTl9JRl9GQU4xX1RBUkdFVF9CSVRdICY9DQo+
IH5TX0lXVVNSOw0KPiANCj4gVGhpcyB3aWxsIGJlIHRha2VuIGNhcmUgaWYgeW91IHNldCB0aGUg
Y29ycmVzcG9uZGluZyBzZXQgcHB0IGZ1bmNzIHRvIE5VTEwuDQpbUXVhbiwgRXZhbl0gWWVzLCB0
aGF0IHNob3VsZCBhbHNvIHdvcmsuIEJ1dCBpbnN0ZWFkIG9mIHVzaW5nIHRoYXQgaW1wbGljaXQg
d2F5LCBJIHdvdWxkIHByZWZlciB0aGlzIHN0cmFpZ2h0Zm9yd2FyZCBtZXRob2QuDQpJZiB0byBk
cm9wIHRoZSBzdXBwb3J0KG9yIHNldHRpbmcgc3VwcG9ydCkgZm9yIHNvbWUgc3BlY2lmaWMgaW50
ZXJmYWNlLCB0aGV5IGp1c3QgbmVlZCB0byBzZXQgdGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSBi
aXQgYWNjb3JkaW5nbHkuIE5vIG5lZWQgdG8gY2FyZSBob3cgdGhlIGludGVybmFsIGltcGxlbWVu
dGF0aW9ucyBhcmUuDQpUaGF0IHNlZW1zIG1vcmUgZnJpZW5kbHkuIEhvdyBkbyB5b3UgdGhpbms/
DQoNCkV2YW4NCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIH0NCg==
