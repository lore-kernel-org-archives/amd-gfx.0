Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE0AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAC410E1EF;
	Fri, 10 Dec 2021 16:19:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D83F10E1EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNfe3dP4AQmXQ4HRMKnCRI6xbSE5RRPKXJ7fxG6jqNV4Or2HvsUWAC/UwCyBiuKI1D4BcdNgEJHzszE8kcTFppIxIeNNDMq4fexwJfVmiIjHVqslYfUaNURzk0jIEeXWmWHFucGhIV74SlhETVmA2QfF/a4l1FtlS7noR+D+E3SfpR87bJzFRXFOtwWutDBlmGKYgLRBopADi11fg2E5l14xesEaCsmpwWGNLolJYq2WW/9c7wkm5XEeTr7/vgNboj820RFnkVFT4W6fKUiO9AdyAgkf5tX0u4A7MYskzyb8pMq0/ScBeGMnq4PvsPUBtGtcuP/2hCVNY6vKBOwKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMfun2wt8QsP1BrZpA6XNUpvRO6moovUnqennngjxRc=;
 b=lQjoeN+5V9wPuZdDDg+AirnDZmDouoM9s9VbTyLKDGoWK9/Pz3A+ts6yjikApCLvNEz1CpmQr+UHDYStzOANbQ4+ok6ZwFg3t5c4/XL+7X9T6GQ5rwHY5+NxqBYLFU2EYktJ7AtbmWWUUmbq3Tj4hLfkz7Q6swD+11DJrhKEgm1Q3oZn2mm299kkbzsYNVkl/Zr2ONKoDcDXkn/jGPXLZaTRSL72Q1BbrfEJWLwINvQyPwD5Hda7AEpuX66xNZc84CZ7gd9XLXh991kULFoJLk/2qmiPMn1HGIYXDw4lp1GS1CLhLSWIC7bpejn2yOM2Q+KIWwGdtQqTPC69renO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMfun2wt8QsP1BrZpA6XNUpvRO6moovUnqennngjxRc=;
 b=z+836Mv+j089oN7+o01tdlnCCOBrRCWv1/eEkxK9mh5YSVfKQhmjOzchSrsi5nt6piUhiif/fgKJL2huMQc2AuLs8Rofi0t1yTRtzMCqCOyhWyquV3/0EPX7Yxvb5aRijqbty4/kpOijUCB5XNwSDlam17UoDKesMM5ZqFdyReY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 16:19:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 16:19:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Gong, Curry" <Curry.Gong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Topic: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Index: AQHX7brzHYmPYDzJVEu2BZp1426D3KwrpoeAgAA90DA=
Date: Fri, 10 Dec 2021 16:19:29 +0000
Message-ID: <DM6PR12MB2619D1CD28F5D22322CDC40EE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <eb4b71d5-9e08-eac2-43a6-55c82467faca@amd.com>
In-Reply-To: <eb4b71d5-9e08-eac2-43a6-55c82467faca@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T16:19:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e56ef973-4dd0-4ce7-bd55-5bc2f929c823;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3870686-0dcc-404b-0bff-08d9bbf8d816
x-ms-traffictypediagnostic: DM5PR12MB1867:EE_
x-microsoft-antispam-prvs: <DM5PR12MB18677DEADAA7CC433058FAAFE4719@DM5PR12MB1867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RHZbi9AjwsIaoVeufwPygvxm501vtYM/BcrgogGrIFI2wuohtSwFKvkC4TFI03UXcOWf82g/55qf7tXvee6gV4hmlg1tKXI8rtT/NlaHwsUFaN90UCqVqRfsX8ztkP8PnUQu3tc+Xa9d/bghls6IoqmEyEzAKTGKjYK8LEQWBuf9i+UC+MzstO0SfHVN+XnzNV4JmEW7scRwzQzP7BVYhzBbe9x5il/FcZ1dVZoI8YXgBbzN7fe+TUkchSnyhD2YLpos7d6uhmgfL5ptMrUb49U8K/+rxpUU2Wi+zCV/bntpG3uzxNicCAWNROb/o9NuI+Tn9hDwoeOvTSEmZkqiVb9+fQRSZVSUAsTXoKq3EEtutU23VKYui4h5W3029qDAkxNmhEHaOFvP+Er/+QvVIcjbi+5JjIolKuTjZ3yBfDnNltIbsiyAM7PqID6DPKThQkJ8DwfjdoXfTIUevIz3XZSxonr8KZbYYQ2MbtTccnoM5avTMcMGiJaxmhG3FsOibi+dvGtKNbI1RETi8xWn535EWR6tm5lLNAEqv3gFLufq1bzsrhHiPWip0D6dE6KqKWmfGUMMgTKTUzIh71au/eE2Ic0jwJ6vXtzz9JPsoKUrtDresLzdDLlThpkyawfbnU2dPTqMuwZfDDbf6v16MIID1LgH+IDb8qpA8OhXU6Dxoo179SGlLIfhwcIuz1Z+9lHeiBXzX/qtWNbBXNsQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(15650500001)(8676002)(9686003)(33656002)(38070700005)(508600001)(186003)(5660300002)(122000001)(26005)(64756008)(7696005)(6506007)(71200400001)(66946007)(316002)(66476007)(52536014)(66556008)(55016003)(2906002)(53546011)(8936002)(54906003)(110136005)(4326008)(76116006)(83380400001)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlRkY2l1ekR0SnlGTWFZUW5MUUVFL05VN2RsZjlaanBPdjBML0pLOVNGOFNG?=
 =?utf-8?B?Ti9NaU9SQkxMWkZHT2dxTG5pZkN4ejhxV1B5UmZQS3dOTmp1MFp3Z3NMOWtV?=
 =?utf-8?B?dlZRTy9BR1FPTG9wZkYyeHphazZKaXcyQXQ3c3pKb2NKQWJLZ0psaXJxZzRz?=
 =?utf-8?B?MHdvWDlsRXZFT2R5Qkx4amwxLzVueFdwRGk4c1E1elZTaFMrNzJUb2FveE5B?=
 =?utf-8?B?OHdNTUJGdnphaTVUQzEzNjNpTXdmL2Vrd3pJWlBmeFYzOExONWxudXpLNDA2?=
 =?utf-8?B?aGE3OHo3YUsxV2wwT0NkOXEzVEd3QVdLc05uaUF1dFpWKzQweGVPMlFaM3Fj?=
 =?utf-8?B?c0FteDJRWHBoUVZ2cSs4WmhlVGN0ZnhOMU1hMlZzejYyWm0xaTlBZUpvYWt1?=
 =?utf-8?B?SUVEdzJCU0cxdU5UV3QzMEdNb3N0MVNSZjhQRjNRVmVsR0Mwd0IwKytLRThR?=
 =?utf-8?B?WVNVQVo2Mnoyd0toamExNE9SNUtXcjNhS2p3d25RVzgrTkVoQzR0eDRyWEdB?=
 =?utf-8?B?dTdnVlk3elBJUmFIOU1NV2pLcTJYSEIyZWVqbUZuQVN5NytVdWN1UU9zZFhl?=
 =?utf-8?B?ZTV2bXVBMzRjUjVHMTNiZnpvWGc5QUJYODRLWnprbWtYR0FkTXU0NUhBaHpi?=
 =?utf-8?B?WFplM2V1YkVoK2FKLzBuelVRTkgzclN4cmhxVXF5TzUzMHIveEZWcWpuUHZY?=
 =?utf-8?B?eHEwZXlxNG1kcy9oaGFYcmhETzh6R3U5aDNYYXdYTGM0YUFUeUVyL0NKLysr?=
 =?utf-8?B?V0JBc2VYanFUNnpCNjBDV2cyR3VReDArbll6UDFCbFNFUlgwQjZCSDRLMzkw?=
 =?utf-8?B?eUFSNnRLUlBMRm5FODQ1bURZU3lxQTcwc1pNeEdlanJvcTErWTJVWUhwbUlH?=
 =?utf-8?B?ZFVhTllucnBlN0FOUjNDSm9xYkx1Sk5ZVksxRXVnalRlK1djYlk3VE1NV0VP?=
 =?utf-8?B?ZS94M0FkcXNsOUc5RGVsaUNUTkJnaGRRaHVCMGNZZXkvSllxWmVEYmxLK0NR?=
 =?utf-8?B?MHVKVDk0YU1VL3pPc0hoSExyVUx0RWhROC9mNnRIdFFXTTd0WDIzZ05EZGNY?=
 =?utf-8?B?Y1BaUzErQjZ2blN5WWhtTnNRQTJFUXBDTUJ0K2hrdm0vKy95azhMU2tlcmdo?=
 =?utf-8?B?MVJYMnFSbDZGeVQyQWt6RVhmeCtaVWFvSUVGU1g1MEtZRnh2eXkvMyt2Wk5K?=
 =?utf-8?B?Z2ErTkEyYVpEczlROXJjSXhORmVaa3JDdWlYK0N0OTkvTHE2dlJyQVZOamRl?=
 =?utf-8?B?Qkora0lWZG1zM0ZIV1BwT3hlN0dlZURHOVA2dHRyV1NaV1pieTRBU1N0TEw2?=
 =?utf-8?B?T3pvSVVMOWZ0SWxHNTRJNStmNnBrUVlBNTdoUnZWaWRWYmdsbnFzQ202OTZY?=
 =?utf-8?B?cElxZmpTMGJhMFM1NzhOaHNZS2RHbm4zUHhIK1FFTFhyZllmQU5nUTlSQzMr?=
 =?utf-8?B?SnVIM1lpUnlqUnpuMTRvT1Rpd2NpTHdGMXpSM1drMFJFU3NUYVhyT3RGbjdM?=
 =?utf-8?B?VWM5blp2UmdJSERrWURKRUdQZTdiRjVhc1hwZjI4K3p1NlBuQ25rUHJUb2FH?=
 =?utf-8?B?eCtqbFVHUFRBWnpzdmkyWEJwVVFjQlV5WjdPa2hDYy9SemdrVmR6UmU5a0E3?=
 =?utf-8?B?Z1FaY1JaTStPS1ptdHhVeEt5d2xVc0JvUHVpSzZ2dE11dGdpUnVQQmUraGpq?=
 =?utf-8?B?RGJqeWlJdU56REJTbXpWNldrRFpyVnFCdEF5amdyaWNvUy9YZFhsSGJkSUpO?=
 =?utf-8?B?czZqdW1hOTU2Zm56ZlRpdG9pNnArYStmY2ZMc1hzMFpIKzJxZGh2NXZoblFD?=
 =?utf-8?B?Y2Nmd1ZjL0tKREwzS0p6clZNdW52UDZHYk4yQ1VLbXY4OGJHK1NKM1NqVERI?=
 =?utf-8?B?RGNjbnJMTythcFBOYnAzZmpzWUM1bjVuTXhqaXpyYWJKcmdCU3RhZjRZKzVY?=
 =?utf-8?B?bHFFVEFHSURkSXRSajlOZW1Pa1FRaWFCWGQvRER4b0twdFQrenJ3bTdPeFdV?=
 =?utf-8?B?Zi9Cd3UzWDdTVEgyT3Y5Rk1zL3MyOWVuL3JxTUZiTHpuNERqc0czV0Z0MTBv?=
 =?utf-8?B?N1ZYcEpNaHJaYXVKNmpBMzNXZ3hJSDh6aEJIWjkwRGxFc3dFVUhBcG5EUHhP?=
 =?utf-8?Q?zF6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3870686-0dcc-404b-0bff-08d9bbf8d816
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 16:19:29.8794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8DFj0rVlc25EtwCfsk3mTptU8YOuPq6PE3G2IZiIWUEE3ICRxT+btjqK1TUm6YP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBEZWNlbWJlciAxMCwgMjAyMSA4OjI1IFBNDQo+IFRvOiBHb25nLCBDdXJyeSA8Q3Vycnku
R29uZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpodSwgSmFtZXMNCj4g
PEphbWVzLlpodUBhbWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT47IFF1YW4sIEV2
YW4NCj4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBXaGVuIHRoZSBWQ04oMS4wKSBibG9jayBpcyBzdXNwZW5kZWQsDQo+IHBvd2VyZ2F0aW5n
IGlzIGV4cGxpY2l0bHkgZW5hYmxlZA0KPiANCj4gDQo+IA0KPiBPbiAxMi8xMC8yMDIxIDU6MTEg
UE0sIGNoZW4gZ29uZyB3cm90ZToNCj4gPiBQbGF5IGEgdmlkZW8gb24gdGhlIHJhdmVuIChvciBQ
Q08sIHJhdmVuMikgcGxhdGZvcm0sIGFuZCB0aGVuIGRvIHRoZQ0KPiA+IFMzIHRlc3QuIFdoZW4g
cmVzdW1lLCB0aGUgZm9sbG93aW5nIGVycm9yIHdpbGwgYmUgcmVwb3J0ZWQ6DQo+ID4NCj4gPiBh
bWRncHUgMDAwMDowMjowMC4wOiBbZHJtOmFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyIFthbWRncHVd
XSAqRVJST1IqDQo+ID4gcmluZyB2Y25fZGVjIHRlc3QgZmFpbGVkICgtMTEwKQ0KPiA+IFtkcm06
YW1kZ3B1X2RldmljZV9pcF9yZXN1bWVfcGhhc2UyIFthbWRncHVdXSAqRVJST1IqIHJlc3VtZSBv
Zg0KPiBJUA0KPiA+IGJsb2NrIDx2Y25fdjFfMD4gZmFpbGVkIC0xMTAgYW1kZ3B1IDAwMDA6MDI6
MDAuMDogYW1kZ3B1Og0KPiA+IGFtZGdwdV9kZXZpY2VfaXBfcmVzdW1lIGZhaWxlZCAoLTExMCku
DQo+ID4gUE06IGRwbV9ydW5fY2FsbGJhY2soKTogcGNpX3BtX3Jlc3VtZSsweDAvMHg5MCByZXR1
cm5zIC0xMTANCj4gPg0KPiA+IFt3aHldDQo+ID4gV2hlbiBwbGF5aW5nIHRoZSB2aWRlbzogVGhl
IHBvd2VyIHN0YXRlIGZsYWcgb2YgdGhlIHZjbiBibG9jayBpcyBzZXQNCj4gPiB0byBQT1dFUl9T
VEFURV9PTi4NCj4gPg0KPiA+IFdoZW4gZG9pbmcgc3VzcGVuZDogVGhlcmUgaXMgbm8gY2hhbmdl
IHRvIHRoZSBwb3dlciBzdGF0ZSBmbGFnIG9mIHRoZQ0KPiA+IHZjbiBibG9jaywgaXQgaXMgc3Rp
bGwgUE9XRVJfU1RBVEVfT04uDQo+ID4NCj4gPiBXaGVuIGRvaW5nIHJlc3VtZTogTmVlZCB0byBv
cGVuIHRoZSBwb3dlciBnYXRlIG9mIHRoZSB2Y24gYmxvY2sgYW5kDQo+ID4gc2V0IHRoZSBwb3dl
ciBzdGF0ZSBmbGFnIG9mIHRoZSBWQ04gYmxvY2sgdG8gUE9XRVJfU1RBVEVfT04uDQo+ID4gQnV0
IGF0IHRoaXMgdGltZSwgdGhlIHBvd2VyIHN0YXRlIGZsYWcgb2YgdGhlIHZjbiBibG9jayBpcyBh
bHJlYWR5DQo+ID4gUE9XRVJfU1RBVEVfT04uIFRoZSBwb3dlciBzdGF0dXMgZmxhZyBjaGVjayBp
biB0aGUgIjhmMmNkZWYNCj4gZHJtL2FtZC9wbToNCj4gPiBhdm9pZCBkdXBsaWNhdGUgcG93ZXJn
YXRlL3VuZ2F0ZSBzZXR0aW5nIiBwYXRjaCB3aWxsIHJldHVybiB0aGUNCj4gPiBhbWRncHVfZHBt
X3NldF9wb3dlcmdhdGluZ19ieV9zbXUgZnVuY3Rpb24gZGlyZWN0bHkuDQo+ID4gQXMgYSByZXN1
bHQsIHRoZSBnYXRlIG9mIHRoZSBwb3dlciB3YXMgbm90IG9wZW5lZCwgY2F1c2luZyB0aGUNCj4g
PiBzdWJzZXF1ZW50IHJpbmcgdGVzdCB0byBmYWlsLg0KPiA+DQo+ID4gW2hvd10NCj4gPiBJbiB0
aGUgc3VzcGVuZCBmdW5jdGlvbiBvZiB0aGUgdmNuIGJsb2NrLCBleHBsaWNpdGx5IGNoYW5nZSB0
aGUgcG93ZXINCj4gPiBzdGF0ZSBmbGFnIG9mIHRoZSB2Y24gYmxvY2sgdG8gUE9XRVJfU1RBVEVf
T0ZGLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogY2hlbiBnb25nIDxjdXJyeS5nb25nQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5j
IHwgNyArKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYw0KPiA+IGluZGV4IGQ1
NGQ3MjAuLmQ3MzY3NmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YxXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
MV8wLmMNCj4gPiBAQCAtMjQ2LDYgKzI0NiwxMyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX3N1c3Bl
bmQodm9pZCAqaGFuZGxlKQ0KPiA+ICAgew0KPiA+ICAgCWludCByOw0KPiA+ICAgCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0KPiA+
ICsJYm9vbCBjYW5jZWxfc3VjY2VzczsNCj4gPiArDQo+ID4gKwljYW5jZWxfc3VjY2VzcyA9IGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0NCj4gPnZjbi5pZGxlX3dvcmspOw0KPiA+ICsJ
aWYgKGNhbmNlbF9zdWNjZXNzKSB7DQo+ID4gKwkJaWYgKGFkZXYtPnBtLmRwbV9lbmFibGVkKQ0K
PiA+ICsJCQlhbWRncHVfZHBtX2VuYWJsZV91dmQoYWRldiwgZmFsc2UpOw0KPiA+ICsJfQ0KPiA+
DQo+IA0KPiBQcm9iYWJseSB0aGlzIGlzIGEgY29tbW9uIGlzc3VlLiBDYW4geW91IHRyeSBtb3Zp
bmcgdGhpcyB0bw0KPiBhbWRncHVfdmNuX3N1c3BlbmQ/DQpbUXVhbiwgRXZhbl0gWWVzLCBhbWRn
cHVfdmNuX3N1c3BlbmQgc2VlbXMgYSBtb3JlIHByb3BlciBwbGFjZS4gSG93ZXZlciwgdGhlIHZj
biBjb2RlIGlzIG5vdCBjb25zaXN0ZW50Lg0KRm9yIHZjbiB2MiBhbmQgbGF0ZXIsIHRoZXkgYWxy
ZWFkeSBkbyB0aGUgbWFudWFsIGdhdGUgb3BlcmF0aW9uIGluIHRoZWlyIHN1c3BlbmQgcm91dGlu
ZShsaWtlIHZjbl92Ml8wX3N0b3ApLg0KU28sIGl0IGlzIGFjdHVhbGx5IG9ubHkgdmNuX3YxXzAu
YyBzdWZmZXJzIHRoaXMgaXNzdWUuDQo+IA0KPiBpZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpDQo+
ICAgICBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LA0KPiBBTURf
SVBfQkxPQ0tfVFlQRV9WQ04sQU1EX1BHX1NUQVRFX0dBVEUpOw0KPiANCj4gQ2FsbCB0aGlzIGFm
dGVyIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYy4gU2hvdWxkbid0IGhhdmUgYW55IGVmZmVjdCBp
ZiBpZGxlDQo+IHdvcmsgYWxyZWFkeSBwdXQgaXQgaW4gUEcgc3RhdGUuIEV2YW4sIHdoYXQgZG8g
eW91IHRoaW5rPw0KW1F1YW4sIEV2YW5dIFNob3VsZCBub3QgZm9yIG5vdy4gQnV0IEknbSBjb25z
aWRlcmluZyB0byByYWlzZSB0aGUgZGV2X2RiZyBwcm9tcHQgaW4gYW1kZ3B1X2RwbV9zZXRfcG93
ZXJnYXRpbmdfYnlfc211IGZvciBkb3VibGUgZ2F0ZS91bmdhdGUgdG8gZGV2X2luZm8gb3IgZGV2
X3dhcm4uDQpIb3BlZnVsbHkgdGhhdCBjYW4gaGVscCB0byBjYXB0dXJlIHNvbWUgcG90ZW50aWFs
IGlzc3VlcyBsaWtlIHRoaXMuIFNvLCBiZXR0ZXIgdG8ga2VlcCB0aGUgY2hlY2sgZm9yIHRoZSBy
ZXR1cm4gdmFsdWUgb2YgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIGhlcmUuDQoNCkJSDQpFdmFu
DQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+ID4gICAJciA9IHZjbl92MV8wX2h3X2Zpbmko
YWRldik7DQo+ID4gICAJaWYgKHIpDQo+ID4NCg==
