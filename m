Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF9EC00140
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 02:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61747BE6B8;
	Tue,  9 Aug 2022 02:34:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F82BD5B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 02:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDOE20+TfPe1YBWfaVPSlhoPSjEq8QaT7ctbfGakTpfj8YZ8fz7xL3zkytkKhAxopfA916LBdolV1V7y7lNeO0DWqMICT9sN2LwBbgbWAIdrJIaVATRH1MS4PjyVid6KjGH0QUn7LpIdYeWdbM3Zbjo75FNaGgW9ZN5H8R+aiWHbM/dvrKd5MRpgDRFe5BB2EyN6dH8k+DtZwlt5lXPcnJb41fiAjiKVvEotMH48d2LQaBZgo3AIb8Y3ZjRx/djBdB12vYdQvtQ4rgHmQ87YHUnkA742LG1N2fLPKRZFWQdiExMXbDUhsoKGr7EMxTImltrl5nAfyiAcqtVXexgOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tTFlVOl9NYCShsoUI4uUOgNFT5f7UlipGL/QBxwlrM=;
 b=Ixqnymy9bh1RR8ZR4YPE3r1rsS/qJ6Peh/IzL5UMWoPAV0zlOWnwEHWO75BZNB5MClob0TH+OD1h8k8BJcA8ppZVzYeLMASS8SClJl6L2j0z4eIAkB7drPLSPEIEe/YlezbozNmCwmL/vTVO5L6mP9IIoavx4mMVIESsVFrt7p3gD1ZM/ap2qWfC6gWhPb/PJs0vOIw4cW/OYo0glZtUSglf8nsXonuFyimhNuzMYCiWbM6wDBBxtizFj6io1Btkm/pE2Lcn3kW+Odt2W2xxIcD34J/B89TZhVkPPv+7a+CtnBO4leq8fn8LYiBt5n8SkKMFMUo5ma2kr94ZXq2bVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tTFlVOl9NYCShsoUI4uUOgNFT5f7UlipGL/QBxwlrM=;
 b=gkdNDLHnr6/6LBwG808xQVzC71pcbYuv4bf/ZardYj3Naync4ZJVnuQwWRhFcvWycpKA7nLgL2vtRZcwrqQF07fW/9TLuDr7VSrMnGECKsBIM+dAhzrubJfaAJQIwHEIWF2o1y+omA7XaT2wzqnyrrFfAehkMlhJ4nql1SWDTIk=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 02:34:17 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 02:34:17 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
Thread-Topic: [PATCH 1/2] drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
Thread-Index: AQHYqxIgWHx+Qk3s1k6jWMeImMadu62lcEaAgABhmOA=
Date: Tue, 9 Aug 2022 02:34:17 +0000
Message-ID: <BY5PR12MB38737D40DED5E853BBA02994F6629@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220808103103.3143927-1-tim.huang@amd.com>
 <CADnq5_NNWH=fatzgnH=N6qrG2AwVJBxRrFsPMR3DnG0cmW7w1A@mail.gmail.com>
In-Reply-To: <CADnq5_NNWH=fatzgnH=N6qrG2AwVJBxRrFsPMR3DnG0cmW7w1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0f85f907-09e7-4476-947a-a8c70a178296;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T02:01:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3b2f09b-46ff-4789-6fec-08da79afa85a
x-ms-traffictypediagnostic: DM4PR12MB5264:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eOh84MuQnuCAVqXjDcK2ZR8CZ2lSXuMGK5eThiXWs5M61apz6xC0c55ECoPmH1WvtiGbG2fQmGzWxfpQR9a2asWKAs8CAkTZhwDeUK6usdgF7Cqi/rrEPtD2Atf5vd5pexbiFR32RavSvXf9sidMwpEeZwaM+7QeaFh3eheEAy4v4VF/nDOwloAJ1c/ZNYLDy0dYqPR3t4eM4GXDH6v8v9ut+nwwS3JAlbOyUgSvwTN3ZLJF8/74JKoykxZK/nn1RR4jKhUEyFQmMD44o6rbsMnn865c/sVkQuOTH4RutPQ9zciZ+2/ubChdL2vcydIzeu4SEWOEdiyrOPXyBwju1Un1GjAkVtD6/LF0wmd0LuBsNxNy3G3FrVWUnR9qleXnBcvOO4WFiCWTdKESH9Oo4CQjdRjp87x3pIxocvWHSHeed0j2jZfTI8wLhpl4u6xMaOKLUzzQ9cFqpDxUbwBc2rCu1iFYs0nRIYhT+4C/r2WHxzdbx66iP5Y9Yf4z7lrA8xFbRGzBdnpqwwgSH2aU6V+Qi2IWfFOGN0DSR89C92pQLfgZLse73RKgSV3FEXQclvUbuPGEvHBFykKu7v9jr8sFDJanWIiOp4Kz4P6RCf7m/Upd0jiySeqcop2WmOrm/GTRCfeNXRGQtPkAFXzL2X5yW4qhqBXTTiVO/xs6FcnsMRuChPYhjym+ZoCXq8adz33awlOMwiliDXIXkMNGB4MKmqNyFTTdInJMRLAAAsgFVbBvF1EPDJ6IFT7fBv6KycyCUdtyMmmRq6v4hfggrNiWIxxZiOGcUozmsSylX92gKSZLY/va5iJZIqUgubC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(41300700001)(9686003)(7696005)(6506007)(2906002)(33656002)(55016003)(53546011)(83380400001)(38070700005)(186003)(26005)(122000001)(54906003)(86362001)(66476007)(64756008)(66946007)(66556008)(316002)(76116006)(8676002)(4326008)(71200400001)(6916009)(66446008)(478600001)(5660300002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Skp0amRJaXNqQmJoTFowK2ZpTFNBWnpUVG5jaUt6L1cyRGVvNTJaNFhNYVNn?=
 =?utf-8?B?U0gwZ3dkTVFXbjRRd2QwR0lscWhvckYycmlJT3FYSVQ4WG41dXZ6RFQ0Vjh0?=
 =?utf-8?B?RFRvQUw4c2V5Mnd3MkJjbXlvbkxyUWhtMENlM2xvYkFkMjVLRFJ2WldMdk1j?=
 =?utf-8?B?Q1FhMGlEbTFZak9ib3h1MURlUkF0bnRGQnpHdi8zOGxrbGRGT01rd3YxMXRM?=
 =?utf-8?B?UWdsd0xVMmI3Yk5ORGJiU0k0anhBUVFJRi9MdEJUV3ZSa3RMQVpteW1RZlp6?=
 =?utf-8?B?dEhCOW94ZkR1S1NMY1MrdTN0QVBkOGc0aFVZaVRmM3lXcCtWYTZtWEdMNWY2?=
 =?utf-8?B?ZDBxWmZFdkwyQ2tlVHJKS2orMG1qTlRsTWVScGJHd0pMZ0xnL05Hckt1OUlV?=
 =?utf-8?B?QUUyc1Bia1VGbm9rejREdHVyTEw3RktyWjFYR1AxeERhQWtIM0JpNEtOK2dU?=
 =?utf-8?B?bHoyQXJEbXdHV1ROYUNVNDZEbzZEWVNGdExtMkQzVWR0WThoL3RxOFQrNlIw?=
 =?utf-8?B?Y1NvUG1SK3BueGN4VllpL29CRklSaExIUzd2WHRDME41NkpBSHcrKzhkZXNu?=
 =?utf-8?B?YUtHaVZNQ1BVRlpQRFJpaXpPcEM3Y0o2WmJLczlaZXR1aFZSKys5QlRVcDBS?=
 =?utf-8?B?eFNoZVVwc1RhMUR3dzY0dXBCdXVJeFRiUk9zUnNNcUM1Vy9JREJYdTFLaHJt?=
 =?utf-8?B?d2pWWXlia3hLU0pyQzZFOS9qT2NqcklMMFpDem9EczlmUm51cW5aaHI3dVR1?=
 =?utf-8?B?TlJBdy85U09LbFF1dEIvNjlyTjF2a2R6dFNzZHY5a29KZ2FZb3JMVXRDKzRv?=
 =?utf-8?B?VW5HRkNqc3FJUGpnSllodk9mM2tYdzZ6NjlYZ2UwQk9Cbmd4eHR2RGt5RU9Y?=
 =?utf-8?B?YjN4RVVDL0VYakY2cFdPWjZOSGQyV1FMQ2VzSUhIQ2I1dDlpVlo4N3dSeXVJ?=
 =?utf-8?B?TUNOUURHTXRueXB0Z2QvT3plSFBQSHVZUFYxVFAyYjJvZGlXejU4YkwvSVho?=
 =?utf-8?B?OHEyaDNORjVKTUtzaHhBOEY3RHB2VE9BSjZaTU9qdk04dVVJQmN5RGZWM0Jl?=
 =?utf-8?B?Z2E0dzRkVFZRQTlvRVdrenkwb2N0QkxacmU2bHlkeEFkMDlKSGFuUUVRcFVU?=
 =?utf-8?B?dWIrZkQvbitPanJNS1FFSG4rdnVDZ0ZmWU42U25VTElkZ29PZjZ5UitQUlNt?=
 =?utf-8?B?cG90OFJkY3JJd0FMTWtxS1ZDYVJPWVJuNHBLRG1sckN2Zmd1ZCtCaHBHUVFm?=
 =?utf-8?B?cXhwNVdGbE00NTFPK2hPdW5HQS8vWEo3d2E5RllOM0QxaitJS1JaRlduR1dx?=
 =?utf-8?B?QXIwWUM5R0VmcUhnZVhydStRaG0yUGNDT0dHdVJSRzd6bk9mM2xSRGlFdTRM?=
 =?utf-8?B?SjNZNXc2U0xsZUVLUUtlYUVRNlY1bTJUdnM4T1AwMUZwM3pEMURscXFMRTA3?=
 =?utf-8?B?NjQ3ekFDUlNxaWMrbnl6Q2ZiYUZoUzM1Nk96eFFyMXdBTStCYXhya251NVhq?=
 =?utf-8?B?UHVZL0s0cTl1UkNiYW1pL2lWSjVmVlR1ZGR1ZFNQYnhzbkgxZVRyVGR0RXlt?=
 =?utf-8?B?dGc0TzFnZDRDcWxoTVFwMWIrQTlITnE5ZExkTmJkRHE4ZllsMmtCckZidFFq?=
 =?utf-8?B?NUZYSU1hM0FMYUhnTDhub3FOMkNBekY2RFNieHVrZW9KL2NDQ0ltUytaSXdw?=
 =?utf-8?B?N3V1UVMvbTdYb09IWW81TXBITnQxOVc5Yk1KQnptRDdnb290UzR2TGMwK2Ex?=
 =?utf-8?B?YW44dGdFSVpZeVpvZUk3cVdQTFIzYVlCYUk3NFZJWEM0VHA0L0wxd3F3R3dr?=
 =?utf-8?B?ZGFPSkxmc1V3a0lMM1pZMk1KdWFEZHZkQXNiVkRranRTMGplR0xjVjdRMDVP?=
 =?utf-8?B?OW8vekpXRk56Y2Zyd3BReTdOZGp2aThPUzk5N0ZDdkJrVlAwTUhBZUxEY3o5?=
 =?utf-8?B?MW9YNlVady9rR0J2akpzYUJSUDArS1NnTlZmTFZPYmRSTXh4bmtNM29Ta2lm?=
 =?utf-8?B?TGNOcTQ1LytJWlFBN0xqVjRFUVcvZjRtb08yVjNza0Q0RDBGUmRxMXNkdEk5?=
 =?utf-8?B?bk9iZElMa3dZNUcydjhuaWRqUnRXRGVmZ0ZCOGFLTUV1aWdPdUdyY2twQVZn?=
 =?utf-8?Q?/xiAb72tWeKosqSsPDobv5ynN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b2f09b-46ff-4789-6fec-08da79afa85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 02:34:17.6770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPFE5CHmCPmIaJmhEJTNqL/Cx3ppAi/ZY0Zf538IZLoF4HmmzW8hu8AXNcxr45cavjDSMcSNDB3d3C4I0k4yMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNClllcywgd2Ug
bmVlZCB0byBjYWxsIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZW5hYmxlKSBhcyB3ZWxsLCAg
YnV0IG5vdyB0aGUgR0ZYT0ZGIGZlYXR1cmUgaXMgc3RpbGwgbm90IHJlYWR5DQpvbiB0aGUgRlcg
c2lkZS4gSSB3aWxsIGFkZCBzb21lIGNvbW1lbnRzIGFib3V0IHRoaXMgYW5kIHJlc2VuZCB0aGlz
IHBhdGNoIHRvIGF2b2lkIGNvbmZ1c2lvbi4NCg0KQmVzdCBSZWdhcmRzLA0KVGltIEh1YW5nDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVj
aGVyQGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDQ6MTMgQU0NClRv
OiBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlh
b2ppYW4uRHVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBl
bmFibGUgR0ZYIFBvd2VyIEdhdGluZyBmb3IgR0MgSVAgdjExLjAuMQ0KDQpPbiBNb24sIEF1ZyA4
LCAyMDIyIGF0IDY6MzIgQU0gVGltIEh1YW5nIDx0aW0uaHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+
DQo+IEVuYWJsZSBHRlggUG93ZXIgR2F0aW5nIGNvbnRyb2wgZm9yIEdDIElQIHYxMS4wLjEuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IFRpbSBIdWFuZyA8dGltLmh1YW5nQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCAzNQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gaW5kZXggZTAz
NjE4ODAzYTFjLi4zMTlmMDdmNjFiZTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTFfMC5jDQo+IEBAIC01Myw2ICs1Myw3IEBADQo+ICAjZGVmaW5lIEdGWDExX01FQ19I
UERfU0laRSAgICAgMjA0OA0KPg0KPiAgI2RlZmluZSBSTENHX1VDT0RFX0xPQURJTkdfU1RBUlRf
QUREUkVTUyAgICAgICAweDAwMDAyMDAwTA0KPiArI2RlZmluZSBSTENfUEdfREVMQVlfM19ERUZB
VUxUX0dDXzExXzBfMSAgICAgICAweDEzODgNCj4NCj4gICNkZWZpbmUgcmVnQ0dUVF9XRF9DTEtf
Q1RSTCAgICAgICAgICAgIDB4NTA4Ng0KPiAgI2RlZmluZSByZWdDR1RUX1dEX0NMS19DVFJMX0JB
U0VfSURYICAgMQ0KPiBAQCAtNTI3OSw2ICs1MjgwLDM4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X3JsY19mdW5jcyBnZnhfdjExXzBfcmxjX2Z1bmNzID0gew0KPiAgICAgICAgIC51cGRh
dGVfc3BtX3ZtaWQgPSBnZnhfdjExXzBfdXBkYXRlX3NwbV92bWlkLCAgfTsNCj4NCj4gK3N0YXRp
YyB2b2lkIGdmeF92MTFfY250bF9wb3dlcl9nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQo+ICtib29sIGVuYWJsZSkgew0KPiArICAgICAgIHUzMiBkYXRhID0gUlJFRzMyX1NPQzE1
KEdDLCAwLCByZWdSTENfUEdfQ05UTCk7DQo+ICsNCj4gKyAgICAgICBpZiAoZW5hYmxlICYmIChh
ZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX0dGWF9QRykpDQo+ICsgICAgICAgICAgICAg
ICBkYXRhIHw9IFJMQ19QR19DTlRMX19HRlhfUE9XRVJfR0FUSU5HX0VOQUJMRV9NQVNLOw0KPiAr
ICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIGRhdGEgJj0gflJMQ19QR19DTlRMX19HRlhf
UE9XRVJfR0FUSU5HX0VOQUJMRV9NQVNLOw0KPiArDQo+ICsgICAgICAgV1JFRzMyX1NPQzE1KEdD
LCAwLCByZWdSTENfUEdfQ05UTCwgZGF0YSk7DQo+ICsNCj4gKyAgICAgICAvLyBQcm9ncmFtIFJM
Q19QR19ERUxBWTMgZm9yIENHUEcgaHlzdGVyZXNpcw0KPiArICAgICAgIGlmIChlbmFibGUgJiYg
KGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfR0ZYX1BHKSkgew0KPiArICAgICAgICAg
ICAgICAgc3dpdGNoIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSkgew0KPiArICAgICAg
ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAxKToNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCByZWdSTENfUEdfREVMQVlfMywgUkxDX1BHX0RFTEFZ
XzNfREVGQVVMVF9HQ18xMV8wXzEpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gKyAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAgICAgIH0NCj4gK30NCj4gKw0KPiArc3Rh
dGljIHZvaWQgZ2Z4X3YxMV9jbnRsX3BnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29s
IGVuYWJsZSkNCj4gK3sNCj4gKyAgICAgICBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUo
YWRldik7DQo+ICsNCj4gKyAgICAgICBnZnhfdjExX2NudGxfcG93ZXJfZ2F0aW5nKGFkZXYsIGVu
YWJsZSk7DQo+ICsNCj4gKyAgICAgICBhbWRncHVfZ2Z4X3JsY19leGl0X3NhZmVfbW9kZShhZGV2
KTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBnZnhfdjExXzBfc2V0X3Bvd2VyZ2F0aW5nX3N0
YXRlKHZvaWQgKmhhbmRsZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVudW0gYW1kX3Bvd2VyZ2F0aW5nX3N0YXRlDQo+IHN0YXRlKSAgeyBAQCAtNTI5Myw2
ICs1MzI2LDggQEAgc3RhdGljIGludA0KPiBnZnhfdjExXzBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRl
KHZvaWQgKmhhbmRsZSwNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDAsIDIpOg0KPiAg
ICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBlbmFibGUpOw0KPiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAxKToN
Cj4gKyAgICAgICAgICAgICAgIGdmeF92MTFfY250bF9wZyhhZGV2LCBlbmFibGUpOw0KDQpkbyB3
ZSBuZWVkIHRvIGNhbGwgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBlbmFibGUpOyBoZXJlIGFz
IHdlbGw/DQoNCkFsZXgNCg0KPiAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAgICBi
cmVhazsNCj4gICAgICAgICB9DQo+IC0tDQo+IDIuMjUuMQ0KPg0K
