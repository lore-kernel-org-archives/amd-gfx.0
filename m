Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A61C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 03:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079D5611ED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 03:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 079D5611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4A76E2D7;
	Tue,  9 Nov 2021 03:56:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB0C6E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 03:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbmVTQynTx3R75mqWcVFkBHPdI3xjwd6aC0kRRr+3hyY++WGk4hzaNC/cqlrEQcalKM2sd4q0u242BTjanlFY8ZsxbS11WtNcUuQo0aGkpAY6sXv7DiVWR/zH6wFrL18pKa0aWpiqFTJ0wRGnPSOfv66aB8Ms4KM0AcX0hCpITN8vmQQKdgVeWKX2LIx0GzDB5CEdlQFJzNTG+wTMYjXmdkJPBGObM/sPfb7i1Ko0K0RO1+V9j6ZyxoweqmUp3YaNUs5TbsVnZ4gJmjbMWtCzPKjwsTjOe3KI+mpmnppoqISbjLd8cYawc9gsATpjM9EbjUexSukJT7i4WrqQNJZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtEg61K97qv+U6ChOBFDnTSawF5ePD+Az2bVi/9LY30=;
 b=IYGY7Vz3VT+H2ko7fKbddPoB59GgQvpT8z9Btr0G/Q4zn2DApO75lrfN2H+CMJ9ky/zk0TcHI9Z59WRLLZBW5GAYGbYeLtWK/tlcWTLV2BXDuhxUYYQgQztNU91PQXkIumS8FAisF3AMaAYgXGLnZYY6S/CfNh7QAS8daiqT+sgrHajCMCkkZ4TPs4C3qKNd4Ib0/P/uuH8lRuPWhxl6iE8HLxCTiMA3i2yL/1l1qErCMj4X4M7zf52xzFu3ErIfsq30OVhA2hNbx/i/SX+n2Aosik16AiW0BsMncHRIZ8TokD39si/sjJAMTri4ZNqHWw4krYv4M4RFfFN/oQhGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtEg61K97qv+U6ChOBFDnTSawF5ePD+Az2bVi/9LY30=;
 b=hrHMo8ysvFDuCBXTpGSIdAVOOLLzzPruFaC7RbtKqAZfGbnY8ZWVsGCZkCmKuZMgW4GXQIGFb7/mpNp/XRAFt4itbJDUPn9n6WSI9zkAuNfp6NI8Qux+z5NXJ25FWZBxb70zSnc8RFnI/Din4ucIFzgCranf3nn+7Cb9ChTc63o=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Tue, 9 Nov 2021 03:56:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 03:56:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Borislav Petkov <bp@suse.de>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Topic: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Index: AQHX1FvEu+OweiWVMEOG0w2/0y3AtKv5Us2AgAAoOYCAADIkAIAAB3mAgADaQHA=
Date: Tue, 9 Nov 2021 03:56:03 +0000
Message-ID: <DM6PR12MB26191E1D7E5FF947C484278EE4929@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic> <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
 <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
In-Reply-To: <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-09T03:56:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=01387880-3cb9-4dc4-b1f4-fcd90105c7dd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c849c615-f848-4aa0-4b68-08d9a334d9a6
x-ms-traffictypediagnostic: DM6PR12MB2825:
x-microsoft-antispam-prvs: <DM6PR12MB282500BC2EAF335983BFC905E4929@DM6PR12MB2825.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYREHvI6cqBw+Uw/y3papbzw2/NLACNRGaAjJf+1nFEdbF0JIWQhg3aOkkZMIIPvY1f2IgWoX3uh7Ual211NHaH4jIfAtkFmoIzWgj8+mhtd4lVn+2rSyy/75nVAF/xLGPZRc/bnokrGorUtKrja1vHwUrg6H0FXfpBxHtQtQ3qfw2wOklKJBlJmKTX37e1rBrly51PGZcWaH5KH8VHxle9tZc6ueC0T95fSjiTu41e6MMhkgmERFqaDVMsCDH6Bf+L9I8j/S+ljHSJjHnw2ngSIA/FHZ5nQgTGf7eph4ktMuehvt7pNxC9juoU8yiNv3CtNVnUSvxjYbVXVk3RI6PJdpdGYXj50Tf52xfIqVOH49cWQ7RxmlPFTNiaCgo8kAXs4WVC+zBfq/GsR5GHaAM7ww3xlmi7ckZypbzmXW1xMQKzTxwtmkOmbkNVl2FXeyjRzXlq1wU5pBSBF4C8hMir7LaEDROHwHVeI88yEbHB4oZPlkFqrpCJBXiAyoYFMrMAyv3sfhAYXNvGZyUJnDhxxeGZVSiGm2R18LrRxrzTWo6nRWxQ7AcP/GWaaytDMvfLPK+r5yhepp47AqA01XweYsJbq5xzvUw8Rfyuk7CUTg1YMTRPJBLH2qWgcPjqeuKIQdCmB3BGvTgrarXldUB67mLb8aprVVRyH8VlMZw5phLslrywzamtVSNWqU39I/0hM+2V2jB0ZozzemQLpkVTAj3Kwlbt0rk3P7Y0nUH7+UZkOF6dyBtrLq8pkriWc+SitY4zxIPpwhIkT/9iv2gVZKmc73IbqUcOr9oV/XfY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(52536014)(38100700002)(2906002)(7696005)(316002)(53546011)(508600001)(76116006)(8936002)(55016002)(66574015)(71200400001)(86362001)(122000001)(6506007)(66556008)(26005)(64756008)(66446008)(66476007)(8676002)(4326008)(186003)(38070700005)(54906003)(9686003)(66946007)(83380400001)(110136005)(5660300002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JKaVJobWRjeGYyS0laU1pkQWJVeGxhTHhZbUpkR2F5ZlQzNUJQOTRCbjhG?=
 =?utf-8?B?Qzc4UHloOXk0REhmaHdiMG9ZZXJsN0ZYSTVTbEFzSkU3NDI1bFhZUVc3MVRu?=
 =?utf-8?B?d04ycm02cGNudmxia3pwbVZhTFNFYkNVQ2NMSTB2TzRRUWVUVjdIdDNLUE9F?=
 =?utf-8?B?T2dJblBsNXhXbEhyeGNHK0g5TzNWNE55MENOZDJYUThvU1VDc1lUNXhwOC9t?=
 =?utf-8?B?ZFJYeWhSU0FXb2Q3N2s4RXBrZzZPcjJncGNmcFJ1WXI1SXk0bFliVVIvSFNR?=
 =?utf-8?B?dTdHL01ubkw0RWR1eWsydG05cWpqcUtGNnNHV2JZWU94anhacFhSVWIyd1lk?=
 =?utf-8?B?Vm1mOXlTd3VnU0IxaUlBcTd4bXdBNE5qejVMZ2xSWHNiZklqRkFXRWZDRWRr?=
 =?utf-8?B?WVlCMHhFWjdJb21Idkw2aFRQOWFXMStWUW1aNFlueE8wRW5hR0ZKaTdDNDJp?=
 =?utf-8?B?YVpDUW9VRWFCSHg5UlFQU2hjdDlZSi9ldEZHM2FnaTNIb3lOOVRLMGE0aS83?=
 =?utf-8?B?YnZJcjFDRGJHSkNQZmhDRTlMRGg2UDhNaEd0ZGlkdHlqU01BWmJLT0J4M2V2?=
 =?utf-8?B?R0pJK1dVQUN6L0ZJR00zb2VVYlpnNUxBcUNudE9Vb0ppdlVOMzRHTzc0Mzh2?=
 =?utf-8?B?YmNWbDkzQmFzWnVEbDllK1kyQlJQNGNCWTd1ai9rNlBDc3RCUlFmN09LMEhS?=
 =?utf-8?B?dXlnOGo5YTlMbWNONmhNaGM3NTBxSFRYaDdDcHN6YTZvZTZFL1Y2R1oyUjRO?=
 =?utf-8?B?R0RaWHNqUXphdmpjTFBhU00zNmw1RncxdFphWkRvblZ0WnNwRzlsTHRsVzBO?=
 =?utf-8?B?WndwcDh4SmpsRnhaQUh1Z1U0YXVzL2ZjR1BoemNaRXgzT1ZLZ0hWd0NiMUwy?=
 =?utf-8?B?OEU0T29nVHNNNkwyZWZKT3lkQmtNNWtKRUJRMGhKTTFiVHg0RHFlZUIwd3B2?=
 =?utf-8?B?NitWbVdmV0NDalh1TFUwOWxlYmovQ3NDeUJSUllXM3lMRU9jczNwaDg3cFQ1?=
 =?utf-8?B?VHZFRU5nVHdobUx3aFI3bnExZlBzSHo1V0dHNHBJQ2s2Y2JTUjc0LzhQYVZE?=
 =?utf-8?B?bU9lQVRZSTRsd3NsM3hqTnh5OWxpaml5cTl0SkNCY1VlMHRNZlM4NmhXNHRQ?=
 =?utf-8?B?YUZ4YlFaUmZWQjlHTWROSDA4TWp6MUlFKzNtcy9zNlBGdEo5amY3T3pMalJW?=
 =?utf-8?B?bDZXNlNOU0MxQUNVU0swbkF2bnY2R3BFcUZTQWNoYzFOR1J1REM1a2tjaEFD?=
 =?utf-8?B?K3FwODhmQkQ3cVlIZDdoTkl2NFN6QXpXN0xsbFk5dDJPMkUvUStDS3dKbGN6?=
 =?utf-8?B?NXA5TEYzajR3Yy9mN0d1Rk9xSjBhZ3Z1NEV2ajZ5cytxQXBDUVMxTGZCNDZG?=
 =?utf-8?B?QlQ4YUxvbGVKdmo4aGlzNWtTV0ZzVmI1SHZUZFhBZVBWZ25LRzBUcGVHdEVw?=
 =?utf-8?B?TmljZDRSSTQzelFEUzBmMkkyanBOL2xRWm45NE5NdEJNdUtBbVZub3dtbUsv?=
 =?utf-8?B?VWpkYm13NGhBNXZSMytBaGRFUHZuKyt1SnN1ZTY5ditHc0Z5R0l2c0gwTEl5?=
 =?utf-8?B?eldOZ1g3NWVQcnRocDFTOWxMdldyT2ErTjVrY2ZUN0tLcjRMbHFSb1RYczYw?=
 =?utf-8?B?QytacUc2RVd1dDRwdHQvQXhSVWRZS2FHdFJYcm5iMEhrZmNwQlkzQy9QRS9N?=
 =?utf-8?B?dzAvaHUvWnNRREVNV3gyTDAxdVFPYlRKSzVubGZOOHJWZVZaU3BYMGNiQ2xn?=
 =?utf-8?B?NGdrdDFvRzYyUWdXcTc2MCtqMERSYWc2UnlSUVRpMS9sbTFOczNNdW1nVTBJ?=
 =?utf-8?B?OXR1ZUxrV0daZ2dOUHlqSHE3eG5OVGoxU3JCYk4wWW9sYVc2TkhTWFExZXkx?=
 =?utf-8?B?UTdlMmxjbU0yUzZLN2p5WFNialJ4MS84SzRyT2ZLcER3NEpqcno0TFZIV2tT?=
 =?utf-8?B?NlVBOE5CVGFJdmV2TitkV0llUWQzb2tpZ3ozN05LQzFYR1pBdEgvZTBkWmtZ?=
 =?utf-8?B?NEJpVEJPdUtxa2JSRmhmd3I2STVtUkFsQXRuZVlKV2EyNEtqWVZ6UnNjajR0?=
 =?utf-8?B?U3JOaGxyQWU5eVJCcXBCTkFaSFFhdlBpaTY3RURjcEZ3c1cvS0p4NzlYSHhC?=
 =?utf-8?Q?YIYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c849c615-f848-4aa0-4b68-08d9a334d9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 03:56:03.3817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeP8I8wcqUb0mzKTig6OBR46fROEso3HA+wgyhbTy+plEl8sRsdHLsUao9kxpid1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciA4LCAyMDIxIDEwOjQxIFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgQm9yaXNsYXYgUGV0a292DQo+IDxicEBzdXNlLmRl
PjsgUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPEV2YW4u
UXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZC9wbTogYXZvaWQgZHVwbGljYXRlIHBvd2VyZ2F0ZS91bmdhdGUN
Cj4gc2V0dGluZw0KPiANCj4gDQo+IA0KPiBPbiAxMS84LzIwMjEgNzo0NCBQTSwgQ2hyaXN0aWFu
IEvDtm5pZyB3cm90ZToNCj4gPiBBbSAwOC4xMS4yMSB1bSAxMjoxNSBzY2hyaWViIEJvcmlzbGF2
IFBldGtvdjoNCj4gPj4gT24gTW9uLCBOb3YgMDgsIDIwMjEgYXQgMDk6NTE6MDNBTSArMDEwMCwg
UGF1bCBNZW56ZWwgd3JvdGU6DQo+ID4+PiBQbGVhc2UgZWxhYm9yYXRlIHRoZSBraW5kIG9mIGlz
c3Vlcy4NCj4gPj4gSXQgZmFpbHMgdG8gcmVib290IG9uIENhcnJpem8tYmFzZWQgbGFwdG9wcy4N
Cj4gPg0KPiA+IFRoYXQgZG9lc24ndCBuZWNlc3Nhcnkgc291bmRzIGxpa2UgYSBnb29kIGlkZWEg
dG8gbWUgdGhlbi4NCj4gPg0KPiA+IFdoYXQgZXhhY3RseSBpcyBnb2luZyB3cm9uZyBoZXJlPyBB
bmQgd2hhdCBpcyB0aGUgcmF0aW9uYWwgdGhhdCB3ZQ0KPiA+IG11c3QgZml4IHRoaXMgYnkgYXZv
aWRpbmcgdXBkYXRpbmcgdGhlIGN1cnJlbnQgc3RhdGU/DQo+ID4NCj4gDQo+IFJlYm9vdCB3aWxs
IHRyaWdnZXIgYSBzdXNwZW5kIG9mIElQcy4gQXMgcGFydCBvZiBVVkQvVkNFIHN1c3BlbmQsIG5v
dyB0aGVyZQ0KPiBpcyBhbiBhZGRlZCBsb2dpYyB0byBwb3dlciBnYXRlIHRoZSBJUCBhcyBwYXJ0
IG9mIHN1c3BlbmQgc2VxdWVuY2UuIEluIGNhc2Ugb2YNCj4gVVZEL1ZDRSwgcG93ZXIgZ2F0aW5n
IHdvdWxkIGhhdmUgYWxyZWFkeSBoYXBwZW5lZCBhcyBwYXJ0IG9mIGlkbGUgd29yaw0KPiBleGVj
dXRpb24uDQpbUXVhbiwgRXZhbl0gVGhhbmtzIExpam8uIFNvbWUgc3VwcGxlbWVudCBmb3IgdGhl
IGFkZGVkLW9uIHBvd2VyIGdhdGUgbG9naWMgb24gc3VzcGVuZDoNCjEuIGlmIHRoZSBVVkQvVkNF
IGlzIHN0aWxsIHVzaW5nIG9uIHJlYm9vdCB0cmlnZ2VyZWQsIGlkbGUgd29yayB3aWxsIGJlIG5v
dCB0cmlnZ2VyZWQgYW5kIHRoZSBhZGQtb24gcG93ZXIgZ2F0ZSBsb2dpYw0KY2FuIGhlbHAgdG8g
cHV0IHRoZSBJcHMgaW50byBjb3JyZWN0IGdhdGUgc3RhdGUuDQoyLiBJZiB0aGUgVVZEL1ZDRSBp
cyBhbHJlYWR5IGlkbGUgb24gcmVib290IHRyaWdnZXJlZCwgdGhlbiBhcyBMaWpvIG1lbnRpb25l
ZCwgdGhlIGlkbGUgd29yayB3aWxsIGJlIGFscmVhZHkgdHJpZ2dlcmVkDQphbmQgdGhlIGlQIGlz
IGluIGdhdGUgc3RhdGUuIFRoZW4gdGhlIGFkZC1vbiBwb3dlciBnYXRlIGxvZ2ljIG9uIHN1c3Bl
bmQgd2lsbCBiZSBleHRyYSBhbmQgZXZlbiBoYXJtZnVsKG9uIENhcnJpem8gcGxhdGZvcm0pLg0K
DQpTbywgdG8gYWRkcmVzcyB0aGUgaXNzdWUgb2YgMiBhbmQgbm90IGJyZWFrIDEsIHdlIHdpbGwg
dHJhY2sgdGhlIHBnIHN0YXRlIGludGVybmFsbHkgYW5kIGp1c3QgYmFpbCBvdXQgb24gMm5kIGNv
bnNlY3V0aXZlIGdhdGUgcmVxdWVzdC4NCg0KUC5TLiBnZnhvZmYgZmVhdHVyZSBzdWZmZXJzIHRo
ZSBzYW1lIGlzc3VlLiBUaGUgcGF0Y2ggY2FuIGFkZHJlc3MgaXQgYWxzby4NCiANCkJSDQpFdmFu
DQo+IA0KPiBJbiBhbnkgY2FzZSwgcG93ZXIgZ2F0aW5nIGlzIGRvbmUgYnkgU01VIEZXLiBUaGUg
YXNzdW1wdGlvbiBoZXJlIGlzIC0gdGhlDQo+IGxvZ2ljIHRvIHBvd2VyIGdhdGUgSVAgY291bGQg
aW52b2x2ZSByZWdpc3RlciBwcm9ncmFtbWluZy4gQUZBSUssIGFjY2Vzc2luZw0KPiBzb21lIFVW
RC9WQ0UgcmVncyBkdXJpbmcgcG93ZXJnYXRlIHN0YXRlIGNvdWxkIGNhdXNlIGEgaGFuZyB1bmxl
c3MgdGhlDQo+IGFudGktaGFuZyBtZWNoYW5pc20gaXMgbm90IHByb2dyYW1tZWQuIFRoYXQgbWVh
bnMgZWl0aGVyIEZXIG9yIGRyaXZlcg0KPiBuZWVkcyB0byB0cmFjayB0aGUgc3RhdGUgb2YgSVAg
YmVmb3JlIGFjY2Vzc2luZyB0aG9zZSByZWdzIGFuZCBpbiB0aGlzIGNhc2UNCj4gcHJvYmFibHkg
RlcgaXMgYXNzdW1pbmcgZHJpdmVyIHRvIGJlIHJlc3BvbnNpYmxlLiBpLmUuLCBub3QgdG8gY2Fs
bCBwb3dlciBvZmYNCj4gYWdhaW4gaWYgaXQncyBhbHJlYWR5IHBvd2VyZWQgZG93bi4NCj4gDQo+
IFRob3VnaCB0aGF0IHNlZW1zIHRvIGJlIGEgYmFkIGFzc3VtcHRpb24gb24gcGFydCBvZiBGVywg
aXQgaXMgc3RpbGwgYQ0KPiBwb3NzaWJpbGl0eS4gSGF2ZW4ndCBzZWVuIHRoZSBhY3R1YWwgRlcg
Y29kZSwgaXQncyBhIHZlcnkgb2xkIHByb2dyYW0uDQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4g
DQo+ID4gU2VlIHdlIHVzdWFsbHkgYXNzdW1lIHRoYXQgdXBkYXRpbmcgdG8gdGhlIGFscmVhZHkg
c2V0IHN0YXRlIGlzDQo+ID4gdW5wcm9ibGVtYXRpYyBhbmQgdGhhdCBoZXJlIHNvdW5kcyBsaWtl
IGp1c3QgdHJ5aW5nIHRvIG1pdGlnYXRlZCBzb21lDQo+ID4gaXNzdWVzIGluc3RlYWQgb2YgZml4
aW5nIHRoZSByb290IGNhdXNlLg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+
ID4NCj4gPj4NCj4gPj4gV2hvZXZlciBjb21taXRzIHRoaXMsIHBscyBhZGQNCj4gPj4NCj4gPj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9ZVjgxdmlkV1FMV3ZBVE1NQHpuLnRuaWMN
Cj4gPj4NCj4gPj4gc28gdGhhdCBpdCBpcyBjbGVhciB3aGF0IHRoZSB3aG9sZSBzdG9yeSB3YXku
DQo+ID4+DQo+ID4+IFRoeC4NCj4gPj4NCj4gPg0K
