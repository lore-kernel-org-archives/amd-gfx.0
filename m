Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 09:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEDD61175
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 09:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DEDD61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2AC6F3E7;
	Thu,  7 Oct 2021 09:22:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8DB86F3E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 09:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7g1L21QMbmRWtZoBwcAFof+mm/Ult2cy3hkKe/cwc2ODZRgM0f3f3EZNQ1/iBWNiWKT/nmXScyM44mWbwSG9iMfq3j1thaYw9jmCOdyGqNPz9ne5Mz3IZ8QZXVBnI//qh8wbNYHJShGqK2gpyFoXPM8O31QkzJ0ZnyuTUOct5a77NH8+qjdRcVQ239XHMtfFWtwHMT2nUx7UT+skBYlaokE5yGAixoUyiMg092g97450jNg4HeU/3e2QuvkxSCAgVqZ2IZ4lVNZ/STEGCoVZbJruzxfG/KHpwEVnVW/7Htwyf7jFRK3U3VRAGh/pCAMz2RW7qO2LabuMSs0renI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGUjvDb2C1ukqXR/1RqQSlFktBF+zIIrSjiHlQBavts=;
 b=P3xdriHa7SgqZXM5IyBmSZSpdU/fvim/iknoYEltx2bQphBUp+8/+BtSC3sOoKOuMezAnqJKECzXaW1SuNnDKroD/y2oCc1AmAvtQc9IqAnbToDsiVQZCbA2unehmM040pKtHL8LZdv/n2Tlc92Cg3dz9fUeXKKKkGJNgh9uSZfv+1jPeulxMV/z4YJFQER83s56/WNI0UhvcmGQpwl1GIpnKPAn7ztuLuOxXZT1Rd9AxqG+VrQfyVLtBgYXHYXWModTtDnQCZqSAupB0Rorp8YZ3y83GkMXNqDxMuSk0IKoK2OFMAP2x1FJuviXkKN5klHbPrNcY8mdut+qODEaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGUjvDb2C1ukqXR/1RqQSlFktBF+zIIrSjiHlQBavts=;
 b=YIFkciU/439nXIRyG1V3BQr+1eMImG96+OrGsEasrt5zB6+1HQrVcJjZbymiCuSxC15C6Zt9neR6FdtdiPkTy+GvdIOPiXyvdWsKUrzU6ihJS7DJ/ELw0wD78udRsUNiHkuTg7UJrVuFI8nS5kKu12ibtjBoMT+Yfz6/1G2msXs=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 09:22:25 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c%2]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 09:22:25 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "Shih, Jude" <Jude.Shih@amd.com>, "Kizito, Jimmy" <Jimmy.Kizito@amd.com>,
 "Somasundaram, Meenakshikumar" <Meenakshikumar.Somasundaram@amd.com>, "Lei,
 Jun" <Jun.Lei@amd.com>
Subject: RE: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP
 link training
Thread-Topic: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP
 link training
Thread-Index: AQHXub8bFV9A5Kq0aE2v3YqOrJdZnavEpHCAgAEVgKCAAEhCgIABQuww
Date: Thu, 7 Oct 2021 09:22:25 +0000
Message-ID: <CO6PR12MB548967D8BD887A5D2B26F133FCB19@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-20-Wayne.Lin@amd.com>
 <33774abc-c31d-e3d6-43ec-b80bc7e946c5@amd.com>
 <CO6PR12MB5489C5E88F098D2C6BC7AF69FCB09@CO6PR12MB5489.namprd12.prod.outlook.com>
 <16f62843-883d-0ddf-8545-d2806a5ab82b@amd.com>
In-Reply-To: <16f62843-883d-0ddf-8545-d2806a5ab82b@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a7dc716a-79ca-488d-97c5-0396ce7e619b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-07T09:18:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e42d10f1-28e9-4104-fdb5-08d98973f9ad
x-ms-traffictypediagnostic: CO6PR12MB5395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5395331C14A7C0689F038DABFCB19@CO6PR12MB5395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swQdqCBQrsKOuYHIxdeG9D3wXjzDvMeUywNuGVRgCNcaqHC4d/glTqBmIWZedSqGy8aRa0vxKKEkwZMbUtjPN/vlTwPJ9JRep1i2nmyQM0Tb5YjnALFa2skuKpxeDZvRRcdZMdJUSBuOBE7mG211Blc8zDTL8Vo+4iRdUYvVBPlf8AYKgiaGgQIHPhPq9Qtx0/B5FsUyYwwZ/8drVT7coWpi6H3GEGce6Ed0S/4VuOVHK/9aIEwvenzFW0FAyv4cGNdFLUi2rloWBPuuYdX5ymNN+6NWHN2bCt90SN60j5jS5XrMSYWKxvlEpElDYPpqhJ+iXePyWEdMxSTLCrhI5Q8vR9f2F75JZ8McwTUvjnZE4tXQYv95DzFT1UrgSddj/mFHMN4+4WKlbEU1sOXfKWYGidJewnTKUAsIJBiV8BSVa4bPAXQrnzXJuH4vANDBQB33vtqEf7OI1QgAgEBw/9mrFGuWaPHj6viZ4BcJdFDQUHEtcI8Lf8iteT4r+LMoM/n+G2RRbgHt5vpZC5KCJLlu1HBY8LTq5zAIdjpR9i4YruJ6+swhyvOylmPez6nrzO90wKxvNtsCGZmnp+nvuDxwL7d3McPT7oDopzJeS7DRlyfhMizuDjGhzsg3EtpSa4ki+akE7HckHosByfpeuAHgIYbboc3conG4n0DdCj+S3MM8C8i9QDGOJqEN5sMdR2YgpoDEyZT3dUgkKx99DA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(55016002)(38100700002)(9686003)(122000001)(66556008)(71200400001)(66476007)(64756008)(66446008)(66946007)(76116006)(2906002)(54906003)(110136005)(86362001)(33656002)(4326008)(26005)(8936002)(316002)(186003)(38070700005)(5660300002)(508600001)(53546011)(83380400001)(6506007)(8676002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFVFV1N1RTJTeGsyN0VWQUtoM0lER3F6Zm9kdjVTRjhsREQ4dmtEdEdFS0do?=
 =?utf-8?B?QTV2RGhsdVZna3JBeWVEZEhDd2NpbEtMTDhsWDRTS2doQ3NzSWg5T0hVQ3k0?=
 =?utf-8?B?a1hreno4L0UxQzdoOFZDS3dNNXVVSzVkMkg2T2ZNSDdWcHlnU1laSllwWU1o?=
 =?utf-8?B?NWFKbHl2TllLNy9WZG8xaFRIVmM4RGlERGxMU2daREJnZXQxK3JtREZRUjl3?=
 =?utf-8?B?bEJGYmliQUJCQVN2M3RteGZZQ0QySzdXUnNYek5ac1RVM2c3TnlmSDM1VXRQ?=
 =?utf-8?B?RWNJRlhmVFduWjZaSDcwdzlhTXdiNHU2QlJQa2duOG9GOHRMS0l3NDFSeHFa?=
 =?utf-8?B?YjlCQUtYZkRtcjM0QmVvVFVCSjcvWmVRbDVhbmxxcVhmbTNRME5GTjhRR2p1?=
 =?utf-8?B?UlFtVzNiVWFzRC9zUTQyN1hkRFVMRk1OTmViMWROSzVac3dpa0tNakxUWW4w?=
 =?utf-8?B?bk9pUDNtQU1VMWd0K2xuUGoyNCtEYmw0TTVjZVcxTTJiM2ZlaVd6TGVNQ0do?=
 =?utf-8?B?Ulh5NWw1NGlSVVZQaWNmOVlSYjdZTjYzdG05WEc1RmFzSExCbERyek1CWG1n?=
 =?utf-8?B?amtyQnRTaVRuSkZLanQycnZDck9CNWJBekN3bkxtZDF0emNjZXZtYUVvTk9x?=
 =?utf-8?B?bnB6d2xOcFFIRkwycExmV0hBS0tXOHNmZUlJNnl3anA3Ukt3dXVWeXJ4SERq?=
 =?utf-8?B?ZkNBbUZYMXJyOFRSSjZRdlNlZDNwSU94OFdOYkNCRTBGMTQzTjhUV3BueHhu?=
 =?utf-8?B?ODZjSEFFS3ducDEvRFNtaTJodVFocGFBc0JIcGROTUtZeVhaakJLa1I2c3dV?=
 =?utf-8?B?R3Z5OGtlOFNFTTRkOHZ3Y2wyN3VueUdGV3BMcHBqVzhyaDNRSklraEg1bzJL?=
 =?utf-8?B?RXpuM0lxWTJPSFdsaHBISmdUanZwdjQ0U1poMWFoS3lXSE5uayt6ZW8xVktk?=
 =?utf-8?B?Vld4ZC9zMXlESmZJNC90aFZsa21tNTZMbXJqVXR3dkxjWXI3VEV6aS9TODls?=
 =?utf-8?B?K0pYcWkyS2t3VGNqL0lXekFTT0hIa3BScUsxSGUxbG15QzhGcnloSnJDOW5j?=
 =?utf-8?B?Y0tGSzQ3UmxoTjB4M3JtRndNRnJlV28xMWFRQ2E0Z21mbzNqZndEUHQzWkMv?=
 =?utf-8?B?YnN6aWhXdzk4dHFqQ2ZGVWxlc2xETmE4OWVtMENqbTZsRW5WZmFEUHR0b2NI?=
 =?utf-8?B?dUVCR0EwWXU0N0NSaFp5Z0pRZGp6UXNRbHorbHZNMG5wdFNEV1JjVHpUOGdO?=
 =?utf-8?B?NlYxa2hGMStjTUxvRnNhdTNZVnhqUFZXOVpRU1E1NnBPMlRHYnVlK1RrSml2?=
 =?utf-8?B?NkhySDdJSElyeFlXM09xWE5wbDU4Qk5zdkt4VzhPWVlSbEgxemxMMm5VRDZj?=
 =?utf-8?B?ekV0bG9KeHhBNjYwWEJydmxwRllqYmV2WDh2ZlpQNkt4RkRmbWZlM1EzSkdY?=
 =?utf-8?B?MWVvZHFyOWU3MjJOcjB6VUJ0dWhaOGpyWGVrdCtIdmZjelZsSEtqNkZvWTY3?=
 =?utf-8?B?bUM0WCt5dThiL2wyZS94Ymd3cHRWaGRibFA5NVNqSDZwZjVROEVyOWErNjVT?=
 =?utf-8?B?TlF0VStIVVVoYld6UTFkVERTVVFZMFlBMG1kNWg3TUUrWGY5MHdOVUVQVXhh?=
 =?utf-8?B?cHYzSk5tamxRN1hkTTNQL1hob0NDWU9YbDlvL3FIUHBMNXBncXBDdExmVmZ3?=
 =?utf-8?B?azZrSFhRWk1qdkRienN3SDFvdmtEOHVwZjZ5S1MvTmNJbXVYTU1tZU9FdXpQ?=
 =?utf-8?Q?ZKg8264UAIkXqH4OyyH+FLydLo3+Zzp/GrE6ibw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42d10f1-28e9-4104-fdb5-08d98973f9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 09:22:25.0937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Od9rZ2evCK6jEdTkwSyksR3YP24wITu3V4R3f2OYR5GZofnGQBdErHepamhlBVdQdnJO3qW/qGl0Ea60H5QOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZW50bGFu
ZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0
b2JlciA2LCAyMDIxIDEwOjAzIFBNDQo+IFRvOiBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLYXpsYXVza2FzLCBOaWNob2xhcyA8Tmlj
aG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28NCj4gPFJvZHJpZ28u
U2lxdWVpcmFAYW1kLmNvbT47IFdhbmcsIENoYW8ta2FpIChTdHlsb24pIDxTdHlsb24uV2FuZ0Bh
bWQuY29tPjsgU2hpaCwgSnVkZSA8SnVkZS5TaGloQGFtZC5jb20+OyBLaXppdG8sIEppbW15DQo+
IDxKaW1teS5LaXppdG9AYW1kLmNvbT47IFNvbWFzdW5kYXJhbSwgTWVlbmFrc2hpa3VtYXIgPE1l
ZW5ha3NoaWt1bWFyLlNvbWFzdW5kYXJhbUBhbWQuY29tPjsgTGVpLCBKdW4NCj4gPEp1bi5MZWlA
YW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxOS8yM10gZHJtL2FtZC9kaXNwbGF5
OiBBZGQgZGVidWcgZmxhZ3MgZm9yIFVTQjQgRFAgbGluayB0cmFpbmluZw0KPg0KPg0KPg0KPiBP
biAyMDIxLTEwLTA2IDA2OjE0LCBMaW4sIFdheW5lIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogV2VudGxhbmQsIEhh
cnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgNiwgMjAyMSAxOjExIEFNDQo+ID4+IFRvOiBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLYXpsYXVza2FzLA0KPiA+PiBOaWNo
b2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28NCj4g
Pj4gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47IFdhbmcsIENoYW8ta2FpIChTdHlsb24pDQo+
ID4+IDxTdHlsb24uV2FuZ0BhbWQuY29tPjsgU2hpaCwgSnVkZSA8SnVkZS5TaGloQGFtZC5jb20+
OyBLaXppdG8sIEppbW15DQo+ID4+IDxKaW1teS5LaXppdG9AYW1kLmNvbT47IFNvbWFzdW5kYXJh
bSwgTWVlbmFrc2hpa3VtYXINCj4gPj4gPE1lZW5ha3NoaWt1bWFyLlNvbWFzdW5kYXJhbUBhbWQu
Y29tPjsgTGVpLCBKdW4gPEp1bi5MZWlAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxOS8yM10gZHJtL2FtZC9kaXNwbGF5OiBBZGQgZGVidWcgZmxhZ3MgZm9yDQo+ID4+IFVT
QjQgRFAgbGluayB0cmFpbmluZw0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMDIxLTEwLTA1
IDAzOjUyLCBXYXluZSBMaW4gd3JvdGU6DQo+ID4+PiBGcm9tOiBKaW1teSBLaXppdG8gPEppbW15
Lktpeml0b0BhbWQuY29tPg0KPiA+Pj4NCj4gPj4+IFtXaHkgJiBIb3ddDQo+ID4+PiBBZGRpdGlv
bmFsIGRlYnVnIGZsYWdzIHRoYXQgY2FuIGJlIHVzZWZ1bCBmb3IgdGVzdGluZyBVU0I0IERQIGxp
bmsNCj4gPj4+IHRyYWluaW5nLg0KPiA+Pj4NCj4gPj4+IEFkZCBmbGFnczoNCj4gPj4+IC0gMHgy
IDogRm9yY2VzIFVTQjQgRFAgbGluayB0byBub24tTFRUUFIgbW9kZQ0KPiA+Pj4gLSAweDQgOiBF
eHRlbmRzIHN0YXR1cyByZWFkIGludGVydmFscyB0byBhYm91dCA2MHMuDQo+ID4+Pg0KPiA+Pj4g
UmV2aWV3ZWQtYnk6IE1lZW5ha3NoaWt1bWFyIFNvbWFzdW5kYXJhbQ0KPiA+Pj4gPG1lZW5ha3No
aWt1bWFyLnNvbWFzdW5kYXJhbUBhbWQuY29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEp1biBMZWkg
PEp1bi5MZWlAYW1kLmNvbT4NCj4gPj4+IEFja2VkLWJ5OiBXYXluZSBMaW4gPFdheW5lLkxpbkBh
bWQuY29tPg0KPiA+Pj4gQWNrZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmth
emxhdXNrYXNAYW1kLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEppbW15IEtpeml0byA8Smlt
bXkuS2l6aXRvQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMgICB8IDYgKysrKysrDQo+ID4+PiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcGlhLmMgfCA2ICsrKysrKw0K
PiA+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oICAgICAgICAgICAgICAg
IHwgNCArKystDQo+ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9kY19s
aW5rX2RwaWEuaCAgfCAzICsrKw0KPiA+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMNCj4gPj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+ID4+PiBpbmRleCBiZmJh
MWQyYzZhMTguLjQyM2ZiZDJiOWIzOSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+ID4+PiBAQCAtNDUyOCw2
ICs0NTI4LDEyIEBAIGJvb2wgZHBfcmV0cmlldmVfbHR0cHJfY2FwKHN0cnVjdCBkY19saW5rICps
aW5rKQ0KPiA+Pj4gICAgICAgICAgICAgZWxzZQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICBs
aW5rLT5sdHRwcl9tb2RlID0gTFRUUFJfTU9ERV9OT05fVFJBTlNQQVJFTlQ7DQo+ID4+PiAgICAg
fQ0KPiA+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikNCj4gPj4NCj4gPj4g
V2h5IGlzIHRoaXMgZ3VhcmRlZCB3aXRoIERDX0RDTiB3aGVuIGFsbCBvdGhlciBEUElBIGNvZGUg
aXNuJ3Q/DQo+ID4+IEl0IGxvb2tzIGxpa2UgaXQgbWlnaHQgYmUgdW5uZWNlc3NhcnkuDQo+ID4g
VGhhbmtzIEhhcnJ5Lg0KPiA+DQo+ID4gU2luY2UgZGVjbGFyYXRpb24gb2YgZHBpYV9kZWJ1ZyB2
YXJpYWJsZSBpcyBndWFyZGVkIGJ5DQo+ID4gQ09ORklHX0RSTV9BTURfRENfRENOLCB3ZSBzaG91
bGQga2VlcCB0aGlzIGhlcmUuDQo+ID4NCj4NCj4gQWgsIHRoYXQncyB0aGUgb25lIEkgd2FzIG1p
c3NpbmcuDQo+DQo+IFdlIGNvdWxkIHByb2JhYmx5IG1vdmUgaXQgb3V0IG9mIHRoZSBEQ04gZ3Vh
cmQgaW4gcGF0Y2ggMTYgYnV0IHRoYXQgY2FuIGJlIGRvbmUgd2l0aCBhIGZvbGxvdy11cCBwYXRj
aC4NCj4NCj4gVGVjaG5pY2FsbHkgRFBJQSBvbmx5IG1ha2VzIHNlbnNlIGZvciBEQ04gYnV0IHRo
ZXJlIGlzIG5vIHJlYXNvbiB0byBndWFyZCBpdCBzcGVjaWZpY2FsbHkgZm9yIERDTi4gVGhlIG9u
bHkgcmVhc29uIHdlIGhhdmUgdGhlIERDTg0KPiBndWFyZCBpcyB0byBhbGxvdyBidWlsZHMgb2Yg
b3VyIGRyaXZlciB3aXRob3V0IGZsb2F0aW5nIHBvaW50IG9uIG9sZGVyIEhXLiBJIHdvbmRlciBp
ZiB0aGF0J3MgZXZlbiBzdGlsbCBuZWVkZWQgc2luY2Ugd2Ugbm93IGhhdmUgdGhlDQo+IGZpeHVw
cyBvZiB0aGUgZmxvYXRpbmcgcG9pbnQgc3R1ZmYgZm9yIFBQQyBhbmQgQVJNLg0KVGhhbmtzIEhh
cnJ5Lg0KDQpNdWNoIGFwcHJlY2lhdGVkIGZvciB0aGUgZWxhYm9yYXRpb25zLiBXaWxsIGdpdmUg
YSBmb2xsb3ctdXAgcGF0Y2guIFRoYW5rcyENCg0KPg0KPiBIYXJyeQ0KPg0KPiA+IFRoYW5rcyEN
Cj4gPj4NCj4gPj4+ICsgICAvKiBDaGVjayBEUCB0dW5uZWwgTFRUUFIgbW9kZSBkZWJ1ZyBvcHRp
b24uICovDQo+ID4+PiArICAgaWYgKGxpbmstPmVwX3R5cGUgPT0gRElTUExBWV9FTkRQT0lOVF9V
U0I0X0RQSUEgJiYNCj4gPj4+ICsgICAgICAgbGluay0+ZGMtPmRlYnVnLmRwaWFfZGVidWcuYml0
cy5mb3JjZV9ub25fbHR0cHIpDQo+ID4+PiArICAgICAgICAgICBsaW5rLT5sdHRwcl9tb2RlID0g
TFRUUFJfTU9ERV9OT05fTFRUUFI7ICNlbmRpZg0KPiA+Pj4NCj4gPj4+ICAgICBpZiAobGluay0+
bHR0cHJfbW9kZSA9PSBMVFRQUl9NT0RFX05PTl9UUkFOU1BBUkVOVCB8fCBsaW5rLT5sdHRwcl9t
b2RlID09IExUVFBSX01PREVfVFJBTlNQQVJFTlQpIHsNCj4gPj4+ICAgICAgICAgICAgIC8qIEJ5
IHJlYWRpbmcgTFRUUFIgY2FwYWJpbGl0eSwgUlggYXNzdW1lcyB0aGF0IHdlIHdpbGwNCj4gPj4+
IGVuYWJsZSBkaWZmIC0tZ2l0DQo+ID4+PiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX2xpbmtfZHBpYS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHBpYS5jDQo+ID4+PiBpbmRleCA3NDA3Yzc1NWE3M2UuLmNlMTVh
MzhjMmFlYSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX2xpbmtfZHBpYS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kY19saW5rX2RwaWEuYw0KPiA+Pj4gQEAgLTUyOCw2ICs1MjgsMTIgQEAg
c3RhdGljIHVpbnQzMl90IGRwaWFfZ2V0X2VxX2F1eF9yZF9pbnRlcnZhbChjb25zdCBzdHJ1Y3Qg
ZGNfbGluayAqbGluaywNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcF90cmFu
c2xhdGVfdHJhaW5pbmdfYXV4X3JlYWRfaW50ZXJ2YWwoDQo+ID4+Pg0KPiA+Pj4gbGluay0+ZHBj
ZF9jYXBzLmx0dHByX2NhcHMuYXV4X3JkX2ludGVydmFsW2hvcCAtIDFdKTsNCj4gPj4+DQo+ID4+
PiArI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfRENfRENOKQ0KPiA+Pg0KPiA+PiBTYW1lIGhl
cmUuIFBsZWFzZSBkcm9wIHRoaXMgZ3VhcmQgaWYgd2UgZG9uJ3QgbmVlZCBpdC4NCj4gPj4NCj4g
Pj4gSGFycnkNCj4gPj4NCj4gPj4+ICsgICAvKiBDaGVjayBkZWJ1ZyBvcHRpb24gZm9yIGV4dGVu
ZGluZyBhdXggcmVhZCBpbnRlcnZhbC4gKi8NCj4gPj4+ICsgICBpZiAobGluay0+ZGMtPmRlYnVn
LmRwaWFfZGVidWcuYml0cy5leHRlbmRfYXV4X3JkX2ludGVydmFsKQ0KPiA+Pj4gKyAgICAgICAg
ICAgd2FpdF90aW1lX21pY3Jvc2VjID0NCj4gPj4+ICtEUElBX0RFQlVHX0VYVEVOREVEX0FVWF9S
RF9JTlRFUlZBTF9VUzsNCj4gPj4+ICsjZW5kaWYNCj4gPj4+ICsNCj4gPj4+ICAgICByZXR1cm4g
d2FpdF90aW1lX21pY3Jvc2VjOw0KPiA+Pj4gIH0NCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgNCj4gPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgNCj4gPj4+IGluZGV4IGUzZjg4NDk0MmUwNC4uODZmYTk0
YTJlZjQ4IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjLmgNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oDQo+
ID4+PiBAQCAtNDk5LDcgKzQ5OSw5IEBAIHVuaW9uIHJvb3RfY2xvY2tfb3B0aW1pemF0aW9uX29w
dGlvbnMgeyAgdW5pb24NCj4gPj4+IGRwaWFfZGVidWdfb3B0aW9ucyB7DQo+ID4+PiAgICAgc3Ry
dWN0IHsNCj4gPj4+ICAgICAgICAgICAgIHVpbnQzMl90IGRpc2FibGVfZHBpYToxOw0KPiA+Pj4g
LSAgICAgICAgICAgdWludDMyX3QgcmVzZXJ2ZWQ6MzE7DQo+ID4+PiArICAgICAgICAgICB1aW50
MzJfdCBmb3JjZV9ub25fbHR0cHI6MTsNCj4gPj4+ICsgICAgICAgICAgIHVpbnQzMl90IGV4dGVu
ZF9hdXhfcmRfaW50ZXJ2YWw6MTsNCj4gPj4+ICsgICAgICAgICAgIHVpbnQzMl90IHJlc2VydmVk
OjI5Ow0KPiA+Pj4gICAgIH0gYml0czsNCj4gPj4+ICAgICB1aW50MzJfdCByYXc7DQo+ID4+PiAg
fTsNCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5j
L2RjX2xpbmtfZHBpYS5oDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9p
bmMvZGNfbGlua19kcGlhLmgNCj4gPj4+IGluZGV4IDc5MGI5MDRlMzdlMS4uZTNkZmU0Yzg5Y2Uw
IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9k
Y19saW5rX2RwaWEuaA0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2luYy9kY19saW5rX2RwaWEuaA0KPiA+Pj4gQEAgLTM0LDYgKzM0LDkgQEAgc3RydWN0IGRjX2xp
bmtfc2V0dGluZ3M7DQo+ID4+PiAgLyogVGhlIGFwcHJveGltYXRlIHRpbWUgKHVzKSBpdCB0YWtl
cyB0byB0cmFuc21pdCA5IFVTQjQgRFAgY2xvY2sNCj4gPj4+IHN5bmMgcGFja2V0cy4gKi8gICNk
ZWZpbmUgRFBJQV9DTEtfU1lOQ19ERUxBWSAxNjAwMA0KPiA+Pj4NCj4gPj4+ICsvKiBFeHRlbmQg
aW50ZXJ2YWwgYmV0d2VlbiB0cmFpbmluZyBzdGF0dXMgY2hlY2tzIGZvciBtYW51YWwgdGVzdGlu
Zy4NCj4gPj4+ICsqLyAjZGVmaW5lIERQSUFfREVCVUdfRVhURU5ERURfQVVYX1JEX0lOVEVSVkFM
X1VTIDYwMDAwMDAwDQo+ID4+PiArDQo+ID4+PiAgLyoqIEBub3RlIENhbiByZW1vdmUgb25jZSBE
UCB0dW5uZWxpbmcgcmVnaXN0ZXJzIGluIHVwc3RyZWFtDQo+ID4+PiBpbmNsdWRlL2RybS9kcm1f
ZHBfaGVscGVyLmggKi8NCj4gPj4+ICAvKiBEUENEIERQIFR1bm5lbGluZyBvdmVyIFVTQjQgKi8N
Cj4gPj4+ICAjZGVmaW5lIERQX1RVTk5FTElOR19DQVBBQklMSVRJRVNfU1VQUE9SVCAweGUwMDBk
DQo+ID4+Pg0KPiA+IC0tDQo+ID4gUmVnYXJkcywNCj4gPiBXYXluZQ0KPiA+DQotLQ0KUmVnYXJk
cywNCldheW5lDQoNCg==
