Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14436EC875F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 22:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB51210E81E;
	Thu,  7 Sep 2023 22:39:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F8510E81E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 22:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCqfi7trDTIW7c9GmOzBR7Qu8O+PK4ctEaPjRk+wDT1AaZZIJiRHsi7P2IJqtO3aNoqxw6sBQuczLTLC+uL+9aYgUiWPi665v6yijUFjsbzD7iykW/3zUssBATBQDqEO+cgFVA0RukENmx347/tpU4rCLhmgHHJsIp7llhQQe4Oo/u97pqOCPR4GhGUptNs6REitSrkzvDdsIjRtZlEo7Ee3T/UOuvx+l8CFyIbW45PEfYwkXgK3eZKf5VVb9a92m71xaDSma/3WsnnwIJfPHTGoAOI+ILXctUUpXmGxVfNXFTM5hkZB4yfmtAe+wjQxVbJRywjryWfw/WZO2x7CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tV9vLmmFpWcB1rOIxEjdyrQeXrhMdqSjAj6o8Nosfo=;
 b=CY6FAhR6LpjeqIqLd3ZHJ1kC9dh4rSy0ozyOrwuiLoswrtPaDtCJ1PGv5lNaZMkGjbQ5KaYbm4TD+2fQtNrNe/Xm+OFQs4XtI1j+yo5iup7mm9peNQYXmljqkfuH9yHXyPsNr4iljQxVuDrscQenqxTSJfsUyHwlTqJbXoH2XZzRvwoxAPxOlEHBnSyDl8Sro9T0t0uER6RYg65sdEBSuBFFhgE4UZB7Ad3wJiXX3qXiJm97fTbHGHWb2tQdT45wom+3fpjBgVnINfpIDSgeFYsHpmTi1S78QwPOekfqdfr1XxmOegRIJjfVzbif7rHlHJG1tQafn/GAcawQQXNFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tV9vLmmFpWcB1rOIxEjdyrQeXrhMdqSjAj6o8Nosfo=;
 b=4PsfiJUpxQB77OXv9lRAal+anYtIASsvWyyziIL78gECBvHRqanyi7uYKAt9Lepv2AnXa5Mc5wXSZv7mtnAD8EN/eXACr3AJEjM0I8XTsiztR/yXG7NtqmI/v/o7pHmvfpY5oKkuzRMvkFajp1hqALn7dF00rhwd+/82+VbR80U=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 22:39:11 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::e56f:be25:cf96:2a59]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::e56f:be25:cf96:2a59%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 22:39:11 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2 1/4] drm/amdgpu: Store CU info from all XCCs for GFX
 v9.4.3
Thread-Topic: [PATCHv2 1/4] drm/amdgpu: Store CU info from all XCCs for GFX
 v9.4.3
Thread-Index: AQHZ4Nl73030ZljeJkemuJtZzi+ckrAP0s8AgAAi/3A=
Date: Thu, 7 Sep 2023 22:39:11 +0000
Message-ID: <BL3PR12MB64253E47D9DF889FA98C5F65EEEEA@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230906154429.216489-1-mukul.joshi@amd.com>
 <3010803b-edae-1878-e1d8-59523cad5e21@amd.com>
In-Reply-To: <3010803b-edae-1878-e1d8-59523cad5e21@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4a9a7921-72bf-4f26-b613-c0e5789d46c6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-07T22:36:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SN7PR12MB7812:EE_
x-ms-office365-filtering-correlation-id: efb783d5-857a-4782-ca2a-08dbaff34180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9sceJj0wicCD0q7FS2o1n4xskSvffG6kqj0nj3/Dl17oHYzLMTy8jYhMejrfBOefdf/EqryzZOPRbicvatGeY8t5UilbOS0Mt9x3C17ZAQed/d4LH4+1B86Vg+Ol0w8sdzUQGMz6eoIxSJHYyaDSghdvVN4dCjUEfnWFkBScChVQt1akwJwZoospemlpQ808E5ZQ+avNYw5mPZldrPEQjD8AMHZ9YUyJUpag8XwrexA6jYkZKGx6J8vskggI5xyiT9pxCdRNI1RWcz6mXv3f/iuNp8LM1gBIF5KMoTauxHfS77h22hjcdxJngsxn+o4EPAWap29QcCHXggxNjqPOoaUqzlqJjjTmF4IaBueymAt6XGUy2ShVaOO2RsqbCcIXbHxGpP8vZ9SdUG/xcdNhFAWiVsi+TNJriljUQ8ZIXO+vVdBq4BQjHB0LRy4hM7X7ld6+Y7UZaTrE67KE1ywfMpNJsB7Yj5ecflATMfit1tk3b6zVYvmPomkFhD5gO1Ci3mjbHGRShcpEuDkDRYW8m7LI2rFp87AlWBzcuw7ffvOx+7sIYEG8ajtOq8Q7waPnPEeeCvBiIqb/9m2KkKtyAXmIGroMETketzLpPZDkLXBr5Jw5TeF4f50NGhOtXN7i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(186009)(1800799009)(451199024)(83380400001)(53546011)(9686003)(52536014)(6506007)(5660300002)(41300700001)(2906002)(8676002)(8936002)(33656002)(66556008)(316002)(64756008)(76116006)(66446008)(66476007)(66946007)(71200400001)(478600001)(110136005)(122000001)(55016003)(38100700002)(38070700005)(86362001)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1p2L01mZm56V2dqTldTMHhveTAxU3c5VHFwaDFsQkJoY1Jid295Q21VMHRa?=
 =?utf-8?B?MGRPTCtZZDJ6TzE4VitKa0J0Uks2TVI1Zm9HN3dhYnljeE1DZ2xUcG1sOHVo?=
 =?utf-8?B?RVdGMUY1Z1JWTUNBYnB3dmlUdTlDaU9hOE5KdmVOY3dRL1Nrdi9La1dQdWkz?=
 =?utf-8?B?ZkV3QTRGSEdUeUhmYXN3L1NZVkt3aDFRdWVKT1hFMHRleE1YUW1OdDJjeXIr?=
 =?utf-8?B?dlJ2dXRHZlo4NnhxQzlsSFppbDRQZlZycFRZdExaSUNZRXlRampEdDVoUExV?=
 =?utf-8?B?VG5EZUhMOFFwcVJHOExFSmdVVGsrRTRMMjdNY1hSZWxCOElyR05CZkpFeWh3?=
 =?utf-8?B?dDRCbVJ2MEUybTBPVnhXN2UyZkFBaE85UE9FMnJ0UDFCOFpyQWx4cjZPa2RS?=
 =?utf-8?B?cm1raXc5c05mV1FmVkhoS015c2lmOVczSDh1aEsyY2cyd3oxN2NINkhQdkFm?=
 =?utf-8?B?MlkrcHcxb256SE0vOXhEeVg2elJyVGJCZEJoUVU4RmJRcFFrOUt4dUt2empR?=
 =?utf-8?B?Mm5XREljOGNrd3J3T2N2VW1kZElMR1d2Z29uVzc0S0RxbExZamFqVzFadHlP?=
 =?utf-8?B?ckh0WXpkdnpLblF4THJmT2tHdkpWeEFOSlpIaWtVcUYzaSsva1ZSOXNjcTZ6?=
 =?utf-8?B?OURhM05XazZ2QW9CZEVubUtrVlZLMWNwOG0wSWxrYUxLZlZqS3d6aDFGeVZY?=
 =?utf-8?B?bXkyM3FiYVZ4S1hoRmI3eHJ3NGFaM1lrVlBjUkYzb0xSNWNhOU9ZbXZqdWow?=
 =?utf-8?B?a25xUHU5Mk84UE8zRjNnQlZuUnFrT1BnS2RMWXY0aGRkajQ2YWlCRnc3SUxG?=
 =?utf-8?B?OHlLYUdBSXh3NnVkSWVPQ1ZrVjROS0JGN3RtVlBuclVvaS90QzcrbDBDSDVX?=
 =?utf-8?B?SXhWMWczeEViOWViRUdsNG1LSkZ3eUd2NGQzb0VIK3VkS2VOWTNpMU9QRmRl?=
 =?utf-8?B?SXhWREU2TVVuSHFGSm9RRDhYU1JEc2tKZnh6WHhTY2plc1lPM29xWjlkaVdI?=
 =?utf-8?B?Z0JpTWw5aVB3QWo0VlRtcWxBekVQVFJXQ21BU2VIMk5aZkpnelkvcE9pQWUy?=
 =?utf-8?B?L1VQV0lNRmpkTWhlSkIzUjBmNUw1bkorMDQ4OXpHM1JlUFIvbVd1ZW9XbUpx?=
 =?utf-8?B?Zlk3dzJCajBxRE9aMjdYVnhFK1hzcW9CU1RaMnBBM0FWYzQzaWFHeDdBQ0tB?=
 =?utf-8?B?ZUFYa3dIa1FYeGFUN2F1aVA2cFZkTjh1YU9wNG12Wk1EOFVjN3JhSFdFaHhr?=
 =?utf-8?B?MUVtalh6bkJITEVkaTdIMUdvK2gzQkIrN0RsNEdRc0ZicXo5L2JzemhtUkJS?=
 =?utf-8?B?SFVWREovYmF1dTh3aGdFTEdlR0lTNmxhOVl2d2hJTFN2YysrMXVoT3Fja25R?=
 =?utf-8?B?N2dIakpwYUJsb1lTSFpFakVHelFCZ0hRd1ZYeGQ5dld0eW1scURlWlV1WHNn?=
 =?utf-8?B?aVJ5aEdLdjJsb1p1T3IvRmhabkRKK05RS1RwUTdpN1h0OUdwVDRpc0xianB2?=
 =?utf-8?B?N2pRRWNVK2J5U2xtL0FKNTcyWExCZzY1UlFBQmx6Y05WNkg2dkYzcXc5VlYz?=
 =?utf-8?B?aXNMaEd3Ym5CYi85bXpvWmpIQmM3dDFocGY5MHpSVEJibGFDK1hmOGNXUko5?=
 =?utf-8?B?aHR6OGszaE1nakhNSWlHOFN4dzBnNVEzRjlBeVlZcEovRTZRM1hBSHlrWjVQ?=
 =?utf-8?B?NCtmbExyRlV0c0c0dzJ4WVdVKytaV1VJWlRndGxtbkJTcUs2aGRka2dHU040?=
 =?utf-8?B?eSswS0gxN3BPaW9tSUZGd05xRUdmanpYcWVsTmNKc1J1OFEvUkxVK2Z5N3lw?=
 =?utf-8?B?WFhHNzkxY3J6N244VlJnSk83UFVxMzU3dlZBYnpLd0h3NE5BNDRxZ2hXeFZs?=
 =?utf-8?B?NzVYKzJBR0lWV0xhMjVHMlo2Y0t6MTcyWmhHRndTU2hmRWRLVGt0ODlzUjJl?=
 =?utf-8?B?WlhMU1pZUEFjODNSbVZCWTVaaUxjL25qRnVydkZHQ3JvaThjaGt0Z3JvZGt1?=
 =?utf-8?B?L0ptMXdXaVFISC9RNEFhdkFncVBPMFpjRXRxMk80eVpoZytZdmcwTlAycTly?=
 =?utf-8?B?YVgreGRTT1ZyMk1VSzZtaEFkY1FVb3I0WEFDbDVSK1VSTFY3TFd6ZkZ5bW93?=
 =?utf-8?Q?VVfo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb783d5-857a-4782-ca2a-08dbaff34180
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 22:39:11.3531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8yZoHRiyC0BHMicY18qBBHwG3onD9xiolx56pFakU4PzyzzWyRdHOrqDQ7XbMpGg65f+XwltFjhH8kKTw+Ayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDcsIDIwMjMgNDozMSBQTQ0KPiBUbzogSm9z
aGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSHYyIDEvNF0gZHJtL2FtZGdwdTogU3RvcmUgQ1Ug
aW5mbyBmcm9tIGFsbCBYQ0NzIGZvciBHRlgNCj4gdjkuNC4zDQo+DQo+DQo+IE9uIDIwMjMtMDkt
MDYgMTE6NDQsIE11a3VsIEpvc2hpIHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgd2Ugc3RvcmUgQ1Ug
aW5mbyBvbmx5IGZvciBhIHNpbmdsZSBYQ0MgYXNzdW1pbmcgdGhhdCBpdCBpcw0KPiA+IHRoZSBz
YW1lIGZvciBhbGwgWENDcy4gSG93ZXZlciwgdGhhdCBtYXkgbm90IGJlIHRydWUuIEFzIGEgcmVz
dWx0LA0KPiA+IHN0b3JlIENVIGluZm8gZm9yIGFsbCBYQ0NzLiBUaGlzIGluZm8gaXMgbGF0ZXIg
dXNlZCBmb3IgQ1UgbWFza2luZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE11a3VsIEpvc2hp
IDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPg0KPiBPbmUgbGFzdCBuaXQtcGljayBpbmxpbmUuIFdp
dGggdGhhdCBmaXhlZCAob3IgZXhwbGFpbmVkKSwgdGhlIHBhdGNoIGlzDQo+DQo+IFJldmlld2Vk
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4NCj4NCj4gPiAt
LS0NCj4gPiB2MS0+djI6DQo+ID4gLSBJbmNvcnBvcmF0ZSBGZWxpeCdzIHJldmlldyBjb21tZW50
cy4NCj4gPg0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5j
ICAgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZngu
aCAgICAgICB8ICAzICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
a21zLmMgICAgICAgfCAgMiArLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMgICAgICAgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTFfMC5jICAgICAgICB8ICAyICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjZfMC5jICAgICAgICAgfCAgMiArLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y3XzAuYyAgICAgICAgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgICAgICAgICB8ICAyICstDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgICAgICAgfCAgNCArLQ0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMy5jICAgICAgIHwgNzYgKysrKysrKysrLS0t
LS0tLS0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyAgICAg
ICAgIHwgIDMgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFu
YWdlci5jICB8ICA4ICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9w
b2xvZ3kuYyAgICAgfCAxMSArKy0NCj4gPiAgIC4uLi9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9r
ZmRfaW50ZXJmYWNlLmggICB8ICA2ICstDQo+ID4gICAxNCBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNl
cnRpb25zKCspLCA2NSBkZWxldGlvbnMoLSkNCj4NCj4gW3NuaXBdDQo+DQo+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2Rfa2ZkX2ludGVyZmFjZS5oDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX2tmZF9pbnRlcmZhY2UuaA0KPiA+
IGluZGV4IGYzZjQwZGJiOGZmNy4uM2I1YTU2NTg1YzRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2Rfa2ZkX2ludGVyZmFjZS5oDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9rZmRfaW50ZXJmYWNlLmgNCj4gPiBAQCAtMzEs
MTIgKzMxLDEyIEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gPiAgICNpbmNs
dWRlIDxsaW51eC9iaXRtYXAuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9kbWEtZmVuY2UuaD4N
Cj4gPiArI2luY2x1ZGUgImFtZGdwdV9pcnEuaCINCj4gPiArI2luY2x1ZGUgImFtZGdwdV9nZngu
aCINCj4NCj4gV2h5IGRvIHdlIG5lZWQgdG8gaW5jbHVkZSBhbWRncHVfaXJxLmggaGVyZT8NCj4N
CmFtZGdwdV9nZnguaCBoYXMgc3RydWN0IGFtZGdwdV9pcnFfc3JjIHdoaWNoIGlzIGRlZmluZWQg
aW4gYW1kZ3B1X2lycS5oLg0KU28sIGNvbXBpbGF0aW9uIGZhaWxzIGlmIEkgZG9uJ3QgaW5jbHVk
ZSBhbWRncHVfaXJxLmgNCg0KUmVnYXJkcywNCk11a3VsDQoNCj4gUmVnYXJkcywNCj4gICAgRmVs
aXgNCj4NCj4NCj4gPg0KPiA+ICAgc3RydWN0IHBjaV9kZXY7DQo+ID4gICBzdHJ1Y3QgYW1kZ3B1
X2RldmljZTsNCj4gPg0KPiA+IC0jZGVmaW5lIEtHRF9NQVhfUVVFVUVTIDEyOA0KPiA+IC0NCj4g
PiAgIHN0cnVjdCBrZmRfZGV2Ow0KPiA+ICAgc3RydWN0IGtnZF9tZW07DQo+ID4NCj4gPiBAQCAt
NjgsNyArNjgsNyBAQCBzdHJ1Y3Qga2ZkX2N1X2luZm8gew0KPiA+ICAgICB1aW50MzJfdCB3YXZl
X2Zyb250X3NpemU7DQo+ID4gICAgIHVpbnQzMl90IG1heF9zY3JhdGNoX3Nsb3RzX3Blcl9jdTsN
Cj4gPiAgICAgdWludDMyX3QgbGRzX3NpemU7DQo+ID4gLSAgIHVpbnQzMl90IGN1X2JpdG1hcFs0
XVs0XTsNCj4gPiArICAgdWludDMyX3QgY3VfYml0bWFwW0FNREdQVV9NQVhfR0NfSU5TVEFOQ0VT
XVs0XVs0XTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIC8qIEZvciBnZXR0aW5nIEdQVSBsb2NhbCBt
ZW1vcnkgaW5mb3JtYXRpb24gZnJvbSBLR0QgKi8NCg==
