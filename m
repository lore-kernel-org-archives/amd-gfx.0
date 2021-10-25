Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3AAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 09:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EF060E0B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 09:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35EF060E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B22899E7;
	Mon, 25 Oct 2021 09:07:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A8E899E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 09:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdEr+MPEDhRRg/mTBdGG5iE2jZCgUttqLR3SeMSg3DgrBovrv3BTPyRyqGt2w50IxKlQPjXL4kxG5toL8B9LJrLs+Z8XyoxK2lwUFNJdpauk5vI1mL2wWW2na1xPjkL8mqyOwRhruUMspIJjmqQE4LrUiWdwP0r0uNheXyIWO2+QW1AywZV/6XBUtRGSzBB1zrwWZ0PZKpxAc5jXpVkrtaK21orQJD/YHoUarnPo5bs8rgppSAI12mjxQEcazfx0nEDN3HNqYaRb661xofG5/C/FoL1PIYSYgTMHUzcICQEFgelKIs2dMK9apDjRGvcSzdnfm4Mjx+vCaK3gGD6V+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw8Yq09y9dRg4f8l+ybP6w6U7bS6YUYyJsvse4FO4pA=;
 b=kWiGH8Cxkm0V+2oSJjnSLK8+E6wIDC1c6sag5yPS6hHOmM73GmbzwE4x+sbJkfm6ueEplP+Qb8YZUtVTO4m+UwA3ff0HAN7dw9w+5wvG/iOcpQ+2KlgyDIvso4NhJ1gR9gd9E35ON8Wu2xDOvlM2q7VZR3ZRaaYSqQlQllcvFQXcIakcaSbiU7aBFDkrQoLH6peZ+rmsrzDQymsNHq+SqJ/jt7eyTjijazdzb5QJsFQBhNWheO8sWXOZ//yXToBAWWWddE6IzRSycERx+NzxVYsA/rSxqx+GTti56FI1rMHgWmCxHz7Q/GtwS+ShGpZXVHsIYoYUsptwdcR2OY4DEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw8Yq09y9dRg4f8l+ybP6w6U7bS6YUYyJsvse4FO4pA=;
 b=xkjUbLeHIvm+Ke7gJQZxGd5T2K33vTdWSeXlVuUIuA7aM7EteeMn7AxC1BSZmbpthltdVFv9MNFPyQ8Wl+++qKvgPCyWXwCdBKUh4yKyjkMe9OOKA4lRiUaoiKEgt/SFbduShGSpNPHarACc2FT4tDye0nbdgBlHWlDJ/5LoCQs=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Mon, 25 Oct 2021 09:07:42 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 09:07:42 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: Remove cu mask from struct
 queue_properties
Thread-Topic: [PATCH 2/2] drm/amdkfd: Remove cu mask from struct
 queue_properties
Thread-Index: AQHXwaF0bz7Ie1qdEEur6qOBzuJWWqvdue4AgAXCIAA=
Date: Mon, 25 Oct 2021 09:07:42 +0000
Message-ID: <DM6PR12MB4250F87B3ECBB8F232103B33FB839@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211015084807.2062053-1-lang.yu@amd.com>
 <20211015084807.2062053-2-lang.yu@amd.com>
 <d8823dae-a48a-d5c6-1807-6e35a073aae6@amd.com>
In-Reply-To: <d8823dae-a48a-d5c6-1807-6e35a073aae6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-25T09:07:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=61c19969-5ba0-4133-ad5d-353ef645efac;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5247be1-c1cc-41f2-548f-08d99796e701
x-ms-traffictypediagnostic: DM6PR12MB3211:
x-microsoft-antispam-prvs: <DM6PR12MB321135AAC5C06F20FC431291FB839@DM6PR12MB3211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/FqcKIUuJZqqNRYbsGl8DkAdZB2alZxgiHMggOKOGD+crekiyH0mPapn/pQ2XPvZHYEhqb8d43WLkO0YncrmLcYZR9HG48KGRJBF0Vb6j2w6Nv80hAN+BYvZlqOAx/jKc6xQqpqpMyJlaF5xUGnCbOoqh/BHjq5Q6EhZbVf1MPMrubSmplFMueUHel3kNrCgtBoYaCNKsceFk41D8vVmjhFElLb61vLgZuPpm+RpvGKsJ6LoaSe8kJAQWv7zzktxcJ1vLh/folzk1DUC1H2ZrFtEqH25S8SPCoSAclS3IpuxXPL5j6ZJ0C36geVuosragzPOuX9AT9TXdt63vBRfs/6ILt0VnUIx44EIpNzuTE3vHc3iDsanfereF3cddAbvscwVxNSJ3fhL/O0OuPMPiafvAnK4T9+bwhzbS4pvl6bfmMASuncr+5od5m3db+Ws4XWvuw2k5dgCHrMMCEBOVT42Qu/117Tsqams87fD/v329Iw4Cefq9oNecrzEXwvkSvyuZZdmhYjNDkzUBo3GhDAILVxwfYG9Qv9SASnA6dQ/7MEZrVS1CtDboS6eBiCMdsvwWu5C106kgCHkfDSgxPZVXke2EExpDxQ6ByyJUAkAhi3gEm53kafx32hAhL/jafWqmvIR7GNtJEQIqkmPuz0uAD6WSdymHihAuUQXr09wcATAytrtBw+EMmDOSdQOU4ae2D+6l3CwBjkep1uGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(6506007)(9686003)(508600001)(54906003)(55016002)(86362001)(64756008)(66446008)(7696005)(4326008)(76116006)(66946007)(110136005)(38070700005)(316002)(66556008)(66476007)(186003)(26005)(8936002)(4001150100001)(38100700002)(2906002)(122000001)(33656002)(5660300002)(8676002)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akduZHl2RVdjNlFSVzV2NnZDbENjeDF5TlVMMkFraFdtRytadGc1aEZtV0xw?=
 =?utf-8?B?cWlJNTdxa3R2bGV5YkFhbDBCVnQvdlV6M1MxVFE2M1FNbDNGbU5CYm1FNE5h?=
 =?utf-8?B?VGUzM3ErczJ3NnlsRy9aWkY0TU9mZzRyNGFVTHUyVjVNOVAyeEd3cWROMmlL?=
 =?utf-8?B?VE9xZGRicGZ3ejQ4V2RTcTBLWjRmY3k1a0ROOGhaYWsrZ1VUdmpVU3hIVFF4?=
 =?utf-8?B?eW9zVVpaNm9sUzRwSkJ5UTRndnNOYWEyeDhxNGZUcjU0SnNwRGlyemFHSVRQ?=
 =?utf-8?B?dlR4bGZKeE00d1VMTSthSmh1TEZWWk9kUk44clRhaTBEdFpSeFVLZGhqcUFp?=
 =?utf-8?B?OWJoRU5WS3JzSkMrQjlqd3dzcEdEUytTQjR0dFdrd1gxUnpZbDlUbnVDYWNW?=
 =?utf-8?B?WG93NjlUK09Jei8wZllxU2JFQUJRYUNLVUtIUmc5OE1tVEtNRFZuM0lQYmpS?=
 =?utf-8?B?Vi91eWVYL1M1ZW5HM0xYSTEwSHBBV1JRbjRtOE1NZjYrUGYzTGtUWmkwNnFR?=
 =?utf-8?B?V2pJQXNNZHp3Wk1JNy9tYVJSOEpiVHZud09hQkhEYWRVSDhDUHpkOWhhc0Nm?=
 =?utf-8?B?ZDdYbm5Ud1pEVXdNSjR2TUhoeiszYUk4cWpZQkJBcVk4ZkRuM1hrWnhodEk1?=
 =?utf-8?B?aGNJYTBOcTkzcHBYajA2NzVYMGVIdXFRcmx0aU5NOXd1bHZ3SVcwZDFYaTRI?=
 =?utf-8?B?ZHBSSGJ0aE00R0pkb1RtNUFhcjZHOWMrM2FtSFAxWndJci9nWGpsd3JjY2RO?=
 =?utf-8?B?NkY5SWFCMko4dCtwSU1wdWwra2R0YXRBTEVMYXd0c1dLRWJZNVRZb0szYis3?=
 =?utf-8?B?bFRkZTFTZmR1WUUzS2ZET0V4QUNxM2ExTWR5RlJXbXBzNVJ0Wi9KMld4ejBW?=
 =?utf-8?B?TmgrNEowanMySkJjS1RIVGNOTDNQSVljYVBRQWZzc0ZNbUZkalo2MlgzVG5s?=
 =?utf-8?B?QVE1VTBDUnQyQmd4TnpRYzdxVjNQQm5YVHFoTzYySjFvMEhQTHZMc0x3VkdG?=
 =?utf-8?B?R2U0NTZxVkpPQ0tlYWgwazVlWUhET05saXVNMDh3bFVpcjdVR1dMT1I4R2R2?=
 =?utf-8?B?SU82WHJjM0FIK1Vha01BMVZOZExSUzVrMzdXOWl2YkFTcG1HaFo1UmV5bFlO?=
 =?utf-8?B?WDZNbGNMSEZRVjM4N21xa2UrakRZZ3FkWHNUQVUrYnh4eTQ4QkVqNEVvTUFx?=
 =?utf-8?B?empyWm5aVVJxbXh6SnU1eVBud3RZdURxeVp0Qk9qa2swQ2kybG5aYW9wejBs?=
 =?utf-8?B?aUVvQXhyOTdkNDBOUEtjOFFuQ3dxdThONkE1VkJkNHdaOGJ4VWpDVmVqZkNq?=
 =?utf-8?B?bGV4UFU1VmxBbWxRNGZoaGFvSmE0aE9EdHBUZ0szVWJkWExVV29vOXRwUW9T?=
 =?utf-8?B?NjZuRXJwV1lmRFZwMG5kWDJUWTVpdS9LWW9hZFN5M0tGK04wTUVod1JtUkda?=
 =?utf-8?B?aG5oRnpCTDE5emphREMybFFRcHhGU2pGZ1dIZit6aWt3QkUrZCt5a2F6aGlh?=
 =?utf-8?B?KzYyZkZiYUQ4bkxWMG9ZeFFCSjAzWXpyOGEzSXZndVloVU0yaUFSOXFuM2xp?=
 =?utf-8?B?clFWOG5IeDF2WHBqZnRYa0JhcEpaVk5QZEtzaDFuVGx0aVB2TERtc0ZSQXEw?=
 =?utf-8?B?MGR6UWhQQXRlYzFFWU1NdVNyYnlvSUhPaHI2ZE9sVDhoekdQNkkrSnNVaW1X?=
 =?utf-8?B?a0FCWXRUSzV0WlM3NHR1Q3crOGNOZHlhcUNZcmFkVlVscDRqdlRpRzZHUytw?=
 =?utf-8?B?bXVPZ3FiNVk2b05sT3BLd0xscmU0NUJXdVBlWDQ4TzhNcXh6QnhvY2FGWWJQ?=
 =?utf-8?B?QzJiaVJtd3lzczE1SlZMbUxzTUZlaVFIdElqcVJhVVlydFdHNEp0a2tNZUNB?=
 =?utf-8?B?WWNGbE03b2IrVkRJVFBHSlkxMDV1aTd3eU56RkZKNytHdVFMOFEzcHk2dVVW?=
 =?utf-8?B?em4rQVBFR0E0SDRjM1dUVWJsVi9XTTNuVDBuU0dJaDBUSGQraVU0cnMwM0V0?=
 =?utf-8?B?amJIVGFCTFpOU0dHZXA5OHJtanZVTXQwUG44ZDJqcjVlTCtkdDFwREpVcWhQ?=
 =?utf-8?B?Z2Z5S1VFMmp5SEZEak1acjJwS1Fxcll1RFFYN2kzUm55c1ZNNXo5TTRzRjdq?=
 =?utf-8?B?YkFjRFBoQjlscGdTYytqVmVmUE9rTHIxQ1NQWnRqQXNIc3hHbnNQM1FWZDkv?=
 =?utf-8?Q?itluxQ9QVzj2aj6YLWgQ4go=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5247be1-c1cc-41f2-548f-08d99796e701
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 09:07:42.4376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nfivh3/ie1dQC4xYD3ohTC1zArVLO0TnSOqoTLQY0vC1bA2yf9wlDnyl1ZUSR5uauiBi2Ms9RhfNR61eRzVIYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TZW50
OiBGcmlkYXksIE9jdG9iZXIgMjIsIDIwMjEgMToxMSBBTQ0KPlRvOiBZdSwgTGFuZyA8TGFuZy5Z
dUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0KPjxSYXku
SHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGtmZDogUmVt
b3ZlIGN1IG1hc2sgZnJvbSBzdHJ1Y3QNCj5xdWV1ZV9wcm9wZXJ0aWVzDQo+DQo+QW0gMjAyMS0x
MC0xNSB1bSA0OjQ4IGEubS4gc2NocmllYiBMYW5nIFl1Og0KPj4gK2VudW0gcXVldWVfdXBkYXRl
X2ZsYWcgew0KPj4gKwlVUERBVEVfRkxBR19QUk9QRVJUSVRZID0gMCwNCj4+ICsJVVBEQVRFX0ZM
QUdfQ1VfTUFTSywNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBxdWV1ZV91cGRhdGVfaW5mbyB7
DQo+PiArCXVuaW9uIHsNCj4+ICsJCXN0cnVjdCBxdWV1ZV9wcm9wZXJ0aWVzIHByb3BlcnRpZXM7
DQo+PiArCQlzdHJ1Y3Qgew0KPj4gKwkJCXVpbnQzMl90IGNvdW50OyAvKiBNdXN0IGJlIGEgbXVs
dGlwbGUgb2YgMzIgKi8NCj4+ICsJCQl1aW50MzJfdCAqcHRyOw0KPj4gKwkJfSBjdV9tYXNrOw0K
Pj4gKwl9Ow0KPj4gKw0KPj4gKwllbnVtIHF1ZXVlX3VwZGF0ZV9mbGFnIHVwZGF0ZV9mbGFnOw0K
Pj4gK307DQo+PiArDQo+DQo+VGhpcyBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWUuIEFzIEkgdW5k
ZXJzdGFuZCBpdCwgcXVldWVfdXBkYXRlX2luZm8gaXMgZm9yDQo+aW5mb3JtYXRpb24gdGhhdCBp
cyBub3Qgc3RvcmVkIGluIHF1ZXVlX3Byb3BlcnRpZXMgYnV0IG9ubHkgaW4gdGhlIE1RRHMuDQo+
VGhlcmVmb3JlLCBpdCBzaG91bGQgbm90IGluY2x1ZGUgdGhlIHF1ZXVlX3Byb3BlcnRpZXMuDQo+
DQo+QWxsIHRoZSBsb3cgbGV2ZWwgZnVuY3Rpb25zIGluIHRoZSBNUUQgbWFuYWdlcnMgZ2V0IGJv
dGggdGhlIHF1ZXVlX3Byb3BlcnRpZXMNCj5hbmQgdGhlIHF1ZXVlX3VwZGF0ZV9pbmZvLiBTbyB0
cnlpbmcgdG8gd3JhcCBib3RoIGluIHRoZSBzYW1lIHVuaW9uIGRvZXNuJ3QNCj5tYWtlIHNlbnNl
IHRoZXJlIGVpdGhlci4NCj4NCj5JIHRoaW5rIHlvdSBvbmx5IG5lZWQgdGhpcyBiZWNhdXNlIHlv
dSB0cmllZCB0byBnZW5lcmFsaXplIHBxbV91cGRhdGVfcXVldWUgdG8NCj5oYW5kbGUgYm90aCB1
cGRhdGVzIHRvIHF1ZXVlX3Byb3BlcnRpZXMgYW5kIENVIG1hc2sgdXBkYXRlcyB3aXRoIGEgc2lu
Z2xlDQo+YXJndW1lbnQuIElNTyB0aGlzIGRvZXMgbm90IG1ha2UgdGhlIGludGVyZmFjZSBhbnkg
Y2xlYXJlci4gSSB0aGluayBpdCB3b3VsZCBiZQ0KPm1vcmUgc3RyYWlnaHQtZm9yd2FyZCB0byBr
ZWVwIGEgc2VwYXJhdGUgcHFtX3NldF9jdV9tYXNrIGZ1bmN0aW9uIHRoYXQgdGFrZXMNCj5hIHF1
ZXVlX3VwZGF0ZV9pbmZvIHBhcmFtZXRlci4gSWYgeW91J3JlIGxvb2tpbmcgZm9yIG1vcmUgZ2Vu
ZXJpYyBuYW1lcywgSQ0KPnN1Z2dlc3QgdGhlIGZvbGxvd2luZzoNCj4NCj4gICogUmVuYW1lIHBx
bV91cGRhdGVfcXVldWUgdG8gcHFtX3VwZGF0ZV9xdWV1ZV9wcm9wZXJ0aWVzDQo+ICAqIFJlbmFt
ZSBzdHJ1Y3QgcXVldWVfdXBkYXRlX2luZm8gdG8gc3RydWN0IG1xZF91cGRhdGVfaW5mbw0KPiAg
KiBSZW5hbWUgcHFtX3NldF9jdV9tYXNrIHRvIHBxbV91cGRhdGVfbXFkLiBGb3Igbm93IHRoaXMg
aXMgb25seSB1c2VkDQo+ICAgIGZvciBDVSBtYXNrICh0aGUgdW5pb24gaGFzIG9ubHkgb25lIHN0
cnVjdCBtZW1iZXIgZm9yIG5vdykuIEl0IG1heQ0KPiAgICBiZSB1c2VkIGZvciBvdGhlciBNUUQg
cHJvcGVydGllcyB0aGF0IGRvbid0IG5lZWQgdG8gYmUgc3RvcmVkIGluDQo+ICAgIHF1ZXVlX3By
b3BlcnRpZXMgaW4gdGhlIGZ1dHVyZQ0KDQpHb3QgaXQuIFRoYW5rcyBmb3IgeW91ciBzdWdnZXN0
aW9ucyENCg0KUmVnYXJkcywNCkxhbmcNCg0KPg0KPlJlZ2FyZHMsDQo+wqAgRmVsaXgNCj4NCg==
