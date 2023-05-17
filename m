Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F6C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 10:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0674210E3D8;
	Wed, 17 May 2023 10:10:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8A210E3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 10:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBJ8wXRL2ub4pPK56Tv0ANVeQRd9lHCxp3MuTvJVGyOVrwyutD4q9fOnGj9MUz0L2FrOqq3nYBvsamiH/WmNawXYO55o/d3KYrUJouv5tWvz2Wmy2LBNH6PL6+ErpR39UJ4P23MFmGJL46S9xz3/XrqXLRu3AKoYSI7DhamwMz0beAtGwER3uuBB8E7rnDObQWZfA4uL73PymYHkmUA0lZW/qF286+nKFa5c+fDa0mJ5FuKZjNxtp25R17ALXpC2TqK5wzjcVLuhG02eSZ5/FfMKIpuP3aPQ28QyraFgyRYNCU5j0l9EDkOyknBBIYaHn14CwoOiRpUTggI2GF94Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aADtFIO9kKE+jt+GI1QqlH3tNujr2cLTxHQZuF9qI0=;
 b=XXLnqOBnZz7DvW9cklk+Y3Zn5LdcaHKMKrJTeDe9NxB60Zns14nAlKLIoYyh03M/mcXWbK9dpP46VGEV/wWL1abxK95nHl07SWpwoNnV7R4f5+RjjTxBvraLYChnAogoR0qhKmcaUlNJBVUnSYXr+v4AGPBTfD6LKXoAzR3gD5VjBFF8JfQx/axVpFkRm0Vs6fxBJBm9vx6DvN4VF7yMPHgyEmFhSpTsbeUZmZWQaSWwigdyKbLf4MpvOBN+i4hc6f3g5B8H9DrRt9cXxYvUK3tLxJgXTsGMU7thK7M5vkh9cvWziQe9W07gWikMtt08D9WD/dTvMpxk9uqDCxCVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aADtFIO9kKE+jt+GI1QqlH3tNujr2cLTxHQZuF9qI0=;
 b=gLfLy9b88Q9Dt4OkEeG41RKSuVFcBiXd0CcMFEDXad6t5vW7NQFrfePXpbqrssR4hZVmmux39pyl6CMdtK5lJF8CB/9DeiNJalgBCN15l1R9rSKsKSlheY/sWNeOXGT0sEJKF+jcBMd5/1GQx2jKtJNj3JHb0DjsjxgEieCB8pg=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 10:10:41 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3d86:2abb:7487:b5ab]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3d86:2abb:7487:b5ab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 10:10:41 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Thread-Topic: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Thread-Index: AQHZgcHtF6F57Ybf/k24YLD+3QyGKa9Qh+OAgADedGCAAvWlgIAJ7+Ag
Date: Wed, 17 May 2023 10:10:40 +0000
Message-ID: <MN2PR12MB4128B0111B4006B241E6E16E907E9@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230508152929.1114091-1-srinivasan.shanmugam@amd.com>
 <CADnq5_OfvZbUCiiOw1CHs2DkfjnmTwWedvDvnVgZUif7NBtUyg@mail.gmail.com>
 <MN2PR12MB41289C3850B0CEF7E2D0687390769@MN2PR12MB4128.namprd12.prod.outlook.com>
 <CADnq5_OSa_8DzrP=vwbQPUof=DgfDMeSm=kAM01rYyY0PVmAdw@mail.gmail.com>
In-Reply-To: <CADnq5_OSa_8DzrP=vwbQPUof=DgfDMeSm=kAM01rYyY0PVmAdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2966d963-5c09-4d97-8aef-71053f2454a9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T10:09:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|PH7PR12MB6860:EE_
x-ms-office365-filtering-correlation-id: 37411e7a-3c0c-421e-2609-08db56bef80e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGLMpJ4PBBotzRqNZbHKkcajEvZgRSTezxMXyRc3L+ON1jZ7E2InhNuCZOzyl9VO7L49lfxTZL8tBZi4UM2xITviF/1RYcUhs4/qB6CxRJWeKr9R1aICMsRo8tMG2tVmWPanXq9L07qS+gWWBVXafHW1qYXP+aWMLYJWKTgxbSx/zcyizYX1dapD8Hk+4villWmiBRCEs2QLnRreiaJId3/5Etr+fzrTCxQfA7Wqy0nRJRl+6P7MDcf7Kj7TlfEuQ3Gevth6Fuq+wn1K+N/ukIRO/sH+rk2JfWvS64YycvA5SYWOQ84k5l42jzKZppLJQvqZSnw34coffkEY0Xf+aH32UQVF1qcEISsZ4lPbXEOddyJczeFf+fQ3o6jYxblTnyQDvrOnL9jX4cl8wXuLOLFKz0cpNjFyUwXwCu6hEcztkCO8pOVQfd4K5ncrwA3i/TRZOZG+VXHqnACIeK+UqAPkp4ruWX9FgXADeUlyQAhVahVSAYOndSFKgOe9BeY2tK3uE7gdDQkejg7ojeXp9wGzlbPFEfqBb65AHfYfdUfHAb6mL9iJ77BEZ+32qpI8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(122000001)(6916009)(33656002)(41300700001)(8676002)(2906002)(8936002)(52536014)(5660300002)(55016003)(86362001)(316002)(38070700005)(38100700002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(966005)(66574015)(53546011)(9686003)(6506007)(26005)(186003)(478600001)(7696005)(54906003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHUvY0ZLcmVDNVl0NzRaT2VMMm1XKzJBekxnV2RYK1JIL0tOTzYzMkdJTVgy?=
 =?utf-8?B?V3RUWTRUWUNRMTBZbXUxak5vR0NGMW5DeUpQL2NnRFA5eEpLM3BERUlLdlI3?=
 =?utf-8?B?OUhXOEU0VzFmZjJXZWVGU3lNbmFUUVlzeDNJSmVweVdUVTFpRzVZNGJySHl1?=
 =?utf-8?B?WjVqK2trTVA0QXpOeTl3YWxnY2ZUV1BleUNlVUV3ZmFKVTVtRkJyTWVjWXNZ?=
 =?utf-8?B?R0I2M2dNa3dLaUZSTTRITU1Yb3EycjFmZ212Nyt2RjR0dzFyakMvclVheFBU?=
 =?utf-8?B?SjBNSjlTZWlIdUNMVkFJWmNtcUVPelRGN3JnVm8xMExyZDIvTW5VU1ZXY0FR?=
 =?utf-8?B?ZldRaXZMNHlBZGhBUUV1SnRYeEVzRDJNemdpSWUxTnQ2NFBhb0lpVG9WTmIy?=
 =?utf-8?B?YzhndmV0RkZIQ1laSm4xYUNlMWhoeEJLVllkbWR4RjQ1c3JuTERac0xQS3B5?=
 =?utf-8?B?QjJNZ0dkc205S2hLd2hpSTYzZXFlTW5qWk03cngzc0tmNHBNMzNiSWc0eUhJ?=
 =?utf-8?B?TmhWN3NyMFY3bXZiY3ZQLyt0c2duM0FQd3g5TUxqQTlZb25NcS93d01DcU42?=
 =?utf-8?B?SDNWbVBJcnFaQkg3dm9GRDZLUmhvdkNwTGNqTHArUzR3bytreUJjZ2l4TytI?=
 =?utf-8?B?RFpuMitrTDkyVnRNall0MEYvMVVXQUswUXR2MllTaFpncHd2RE1jWnF5UDFl?=
 =?utf-8?B?bC9XdXE0alBpTkluSjhCSXlwWmlraUdnVTZvNzQ4MFZlZlpFZVBXMklIeE5M?=
 =?utf-8?B?TzBiczI1UE9zTXRvMW9rUVJ5N0J3SnhldTJzYm1CRGhNM3FCc25BRU94Rm92?=
 =?utf-8?B?dDBFWXdxeCtwWUdSL0t0Y0hzamt2WlAyaXRyMzByNE9QSCtMZkZGSUJqVTRT?=
 =?utf-8?B?V1J5Zm84VmswYmQ1TVFtejdvUWZJZTJNS2JNRUYvN2NjT1l6ZWlTN2xTZmhL?=
 =?utf-8?B?V3cyMTVETmhadW9BclBaVGkzc3ZLVVhvaUhrMXllTzkrcmtPQ1pWMTdtaURJ?=
 =?utf-8?B?NWtqN01wS29oQVk3dHV4SUNoUVl0VG45Qk5sMlV2eXVTMjJtRXg0YUFKS1JN?=
 =?utf-8?B?QXBIaFpocGt5ejRNNGR2eDZUeDJJZVR2UkMwK2daenVFT291Ujl5bVhxTW9s?=
 =?utf-8?B?MlNjZEtuTlVjcVE4OFI1UzNtZjNubjlySDUxVDZDaDNGai94dkFDMTFMK3lj?=
 =?utf-8?B?NEV0R1dKTDVnbHU3YWtUaGMzSHN4OXd0RWtNMWVPSjFrcjNheFNwd3NQKzYx?=
 =?utf-8?B?S3pYa3JYSEpNeTlNY0RlWXJsVUlJZCtPV3lHVFlNajZRY3owVVVzNDhmQnRx?=
 =?utf-8?B?a2VSNmR1VDFEdG02VCtsZEhSL010cUVXalJIek84SjVBNGk4WU9QQXpGVHF6?=
 =?utf-8?B?RHZ4eXIyTldGTDhBaVFMbUlQN0xDSEhXWENFR0UvcjcrVDJRN0dvVDE3YW5O?=
 =?utf-8?B?NHl2UGF3SlZsS2pwY3VtVFo3M1Qyc1pLMnVrUDJXT0xpaFp5UHhSN3RqU0dE?=
 =?utf-8?B?KzJhUnRmdExjUHl2Q21hYlpiNHdnNEQvT1RIUnhMeGNQOStxbnJXN2ZWZFV1?=
 =?utf-8?B?OGhCY1FyMFUzMkc4eXdybThZQk4vOXRPeVFqZlVvNTlCM3BtZzBMQWxwZlF5?=
 =?utf-8?B?ZUZLc08wQmNHeWNzcmtXTEJPbDhsYUI1eTRXT2dxVTJFSDFiazcxcHJIVzN6?=
 =?utf-8?B?dnVua3FDZnhnK1d6YmZBaUxjc0xBVlBVSnI1Skc1VjIzWEM5OXJWL1JGNmp0?=
 =?utf-8?B?dkNSZ1Q5WS9FM0pIdjU3U1BCN1A2NWdDMC9odGJWUEtLLzVmcDJTNTk5Wkdx?=
 =?utf-8?B?UFZDZENwQmtkRVc2MUwxVWtKbXdUN1V5RlFOd2o0T0ZWOW0zMWxleUcxbGdO?=
 =?utf-8?B?bE9yUTJNWnZCRCtsY2NQbW1oKzQ3L1NUalMyVnJtOUpMQUU1MFNsV2F1RnJ0?=
 =?utf-8?B?TlljSjdIblZseDhvN0dLZ3JPZkliK2h2M05OWmtGMy9aRFk2TjZVSlZnTDN3?=
 =?utf-8?B?MGRMR3dFYmRlbkh1ZGN0RC9XMnR4VURWNUJkVklZV3pUWnIrQXhKTVFUdGJH?=
 =?utf-8?B?eFIxODYxWmpwN1lXMFFOQ0E4MTRJcXdkMm8zbjZFVTZ5UUJaTGgrVGpmeU5a?=
 =?utf-8?Q?fgdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37411e7a-3c0c-421e-2609-08db56bef80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 10:10:40.8239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDdl3UXT9/cvoqUI7z5ViIeZuIvodAfPWKjbggNR97PxUiqxIkucf4jwL303oPQcORkEXSPzlulDI1+WEr/l3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6
IFRodXJzZGF5LCBNYXkgMTEsIDIwMjMgNzo1NSBBTQ0KVG86IFNIQU5NVUdBTSwgU1JJTklWQVNB
TiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCkNjOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBSZW1vdmUgcmVkdW5kYW50IGVsc2UgYnJhbmNo
IGluIGFtZGdwdV9lbmNvZGVycy5jDQoNCk9uIFR1ZSwgTWF5IDksIDIwMjMgYXQgMToxN+KAr0FN
IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4gd3Jv
dGU6DQo+DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPg0KPg0KPg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVj
aGVyQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXkgOCwgMjAyMyA5OjI3IFBNDQo+IFRv
OiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+
IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hl
ciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6
IFJlbW92ZSByZWR1bmRhbnQgZWxzZSBicmFuY2ggaW4NCj4gYW1kZ3B1X2VuY29kZXJzLmMNCj4N
Cj4gT24gTW9uLCBNYXkgOCwgMjAyMyBhdCAxMToyOeKAr0FNIFNyaW5pdmFzYW4gU2hhbm11Z2Ft
IDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkaGVyZSB0
byBMaW51eCBrZXJuZWwgY29kaW5nIHN0eWxlLg0KPiA+DQo+ID4gUmVwb3J0ZWQgYnkgY2hlY2tw
YXRjaDoNCj4gPg0KPiA+IFdBUk5JTkc6IGVsc2UgaXMgbm90IGdlbmVyYWxseSB1c2VmdWwgYWZ0
ZXIgYSBicmVhayBvciByZXR1cm4NCj4gPg0KPg0KPiBXaGF0IGFib3V0IHRoZSBlbHNlIGluIHRo
ZSBwcmV2aW91cyBjYXNlIHN0YXRlbWVudD8NCj4NCj4gQWxleA0KPg0KPiBIaSBBbGV4LA0KPg0K
PiBUaGFua3MgYSBsb3QgZm9yIHlvdXIgZmVlZGJhY2tzLA0KPg0KPiB0aGUgZWxzZSBpbiB0aGUg
cHJldmlvdXMgY2FzZSBpZS4sIGlzIGJpbmRlZCB0byBpZiBzdGF0ZW1lbnQgaWUuLCAiaWYgKGFt
ZGdwdV9jb25uZWN0b3ItPnVzZV9kaWdpdGFsKSB7IiwgYW0gSSBjb3JyZWN0IHBsZWFzZT8sIHBs
ZWFzZSBjb3JyZWN0IG1lLCBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nPyAmIHRoZSBiZXN0
IHNvbHV0aW9uIHdpdGggeW91ciB0aXBzIHBscywgc28gdGhhdCBJIGNhbiBlZGl0ICYgcmVzZW5k
IHRoZSBwYXRjaCBwbGVhc2U/DQo+DQoNClllcyB0aGF0IG9uZS4gIEl0IGZvbGxvd3MgYSBzaW1p
bGFyIHBhdHRlcm4gdG8gdGhlIGNhc2UgeW91IGNoYW5nZWQuDQpTaG91bGRuJ3QgY2hlY2twYXRj
aCB3YXJuIG9uIGJvdGg/DQoNCkFsZXgNCg0KU28gc29ycnkgQWxleCwgY291bGRuJ3QgcmVwbHkg
aW5zdGFudGx5LCB3YXMgb2NjdXBpZWQgd2l0aCBzb21ldGhpbmcgZWxzZS4NCg0KWWVzIEFsZXgs
IHNvbWVob3cgY2hlY2twYXRjaCB3YXMgcG9pbnRpbmcgb25seSB0byBiZWxvdywgaGVuY2UgYXZv
aWRlZCBtdWx0aXBsZSByZXR1cm4gc3RhdGVtZW50cyB3aXRoIGEgYnJlYWsgd2l0aG91dCBhZmZl
Y3RpbmcgZnVuY3Rpb25hbGl0eSAmIHByb3Bvc2VkIGEgdjIgcGF0Y2g6IGh0dHBzOi8vcGF0Y2h3
b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC81Mzc1MjAvP3Nlcmllcz0xMTc0NjgmcmV2PTINCg0K
V0FSTklORzogZWxzZSBpcyBub3QgZ2VuZXJhbGx5IHVzZWZ1bCBhZnRlciBhIGJyZWFrIG9yIHJl
dHVybg0KIzI0NTogRklMRTogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2VuY29k
ZXJzLmM6MjQ1Og0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICAg
ICAgICAgICAgIGVsc2Ugew0KDQpTcmluaQ0KPiBNdWNoIGFwcHJlY2lhdGUgZm9yIHlvdXIgaGVs
cCBpbiBhZHZhbmNlLA0KPg0KPiA+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+DQo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNh
bi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2VuY29kZXJzLmMgfCAyNg0KPiA+ICsrKysrKysrKystLS0tLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZW5j
b2RlcnMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2VuY29kZXJz
LmMNCj4gPiBpbmRleCBjOTZlNDU4ZWQwODguLjA0OWU5OTc2ZmYzNCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZW5jb2RlcnMuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9lbmNvZGVycy5jDQo+ID4gQEAgLTI0
MiwxOSArMjQyLDE4IEBAIGJvb2wgYW1kZ3B1X2RpZ19tb25pdG9yX2lzX2R1YWxsaW5rKHN0cnVj
dCBkcm1fZW5jb2RlciAqZW5jb2RlciwNCj4gPiAgICAgICAgICAgICAgICAgaWYgKChkaWdfY29u
bmVjdG9yLT5kcF9zaW5rX3R5cGUgPT0gQ09OTkVDVE9SX09CSkVDVF9JRF9ESVNQTEFZUE9SVCkg
fHwNCj4gPiAgICAgICAgICAgICAgICAgICAgIChkaWdfY29ubmVjdG9yLT5kcF9zaW5rX3R5cGUg
PT0gQ09OTkVDVE9SX09CSkVDVF9JRF9lRFApKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiAtICAgICAgICAgICAgICAgZWxzZSB7DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgLyogSERNSSAxLjMgc3VwcG9ydHMgdXAgdG8gMzQwIE1oeiBvdmVyIHNp
bmdsZSBsaW5rICovDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNvbm5lY3Rvci0+
ZGlzcGxheV9pbmZvLmlzX2hkbWkpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChwaXhlbF9jbG9jayA+IDM0MDAwMCkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbHNlDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBpeGVsX2Nsb2NrID4gMTY1
MDAwKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
dHJ1ZTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIC8qIEhE
TUkgMS4zIHN1cHBvcnRzIHVwIHRvIDM0MCBNaHogb3ZlciBzaW5nbGUgbGluayAqLw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAoY29ubmVjdG9yLT5kaXNwbGF5X2luZm8uaXNfaGRtaSkgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChwaXhlbF9jbG9jayA+IDM0MDAwMCkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAocGl4ZWxfY2xvY2sgPiAxNjUwMDApDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIGRlZmF1bHQ6DQo+ID4g
ICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
