Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B2EC64EC4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 17:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EA210E3ED;
	Mon,  6 Mar 2023 17:57:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE5B10E3ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 17:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftRXcybbYwbuROvOMuFuccQyM8q7HBceLpWBJI4FBZofnd+QkYno8izV4BRtphrZgCJXzQFb6gcoiZ3FawRpLsWJVAd35EKKkZyqVGfvvJ7b/US9wB435/O69LPmdwNyXKUUgNRf/ycdQ6xyZb9ffi3Zhg7+hcvH6HdU2C2a4HlmkGGMWDvUjZU/AisJWYj3drn4dlJ75J5XPnda0s9t4R2DqVhYh4JCSDbI5IIgyTRUr/OLWWM0ayVvJ4OMlfQGbLlrvY+YZnOq3jnzmGF1YzXJ2QfzX1VTAka+3lmELqW/wjUDJzstAh4lTuf5O7XhJgRbT6oAcnnT2uOktKo1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOiHq8/4+Oe1NfzCuFLmos3raXqCUzVWm59+AO8ZMNk=;
 b=QFqtfBLcHiaOzQ2mGTb2x2kubA7TJGLjGiUNIxJiHY6+zQZgqpIrFoWwfP3yy6RmaQETImWd3K6EvtCMXdMVl6jRj61/td8v4DfUobugQ/rf5n1UYGaLjEsk/O+zqYXYtRZ3Xml5fMflOK8r4+0TeFtdbqWGTQKsWSzkjj7/sPJE6Hb6ibfhlidJLyEV20ztODx3kEkrblE7KITW5YGMufwJon7t4blFblMIo2PaIcN4tMSVJmjwcCz7hrj1hgZVnRZjAFezUeqFKFHU2O0tka/icAPoEZlIxeiaQG0y80HGr5FnppULtYQ1xT22+mJmDAiHD2y/WyN9g/ZKkfDQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOiHq8/4+Oe1NfzCuFLmos3raXqCUzVWm59+AO8ZMNk=;
 b=qFtx7LR0sbsThrfWdqLY1Vd3hjPXX5eP3n1fCzhp9W4swJqFKWIaFo8gl6UdkfQhLsBcKC2tC7QoUmvDkucN+vs5MMeLskmBoi3uH10ewovxh4td+ilCbExYmjNS+g3thFxOyfFgPGWRK2ZmIPzMCf+fzqJA1S7ltyCXI4LvF9w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 17:57:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4e0d:adcd:8547:2ff6]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4e0d:adcd:8547:2ff6%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 17:57:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Topic: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Index: AQHZTNSNPQx9NP+0VU64Q6uaYJ4O667nKA6AgAAM3gCAAAH2gIAAAsgAgABhpnCAAARgAIAFo4WAgADNQEA=
Date: Mon, 6 Mar 2023 17:57:39 +0000
Message-ID: <BL1PR12MB5144D42B9EC8D851A0E09A52F7B69@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
 <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
 <DM6PR12MB261981BCAAB3ECAC82031921E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51446EF4033480FC8BB6F82BF7B29@BL1PR12MB5144.namprd12.prod.outlook.com>
 <ea9fdc41-f61f-35da-b35e-e710fb621b1e@amd.com>
 <924b9a34-2df9-f94a-16ab-d171b03fe9dd@amd.com>
In-Reply-To: <924b9a34-2df9-f94a-16ab-d171b03fe9dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-06T17:57:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c390e686-ec21-4c31-87ce-f01531ace41b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-06T17:57:38Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3fbff508-1ec4-43eb-ac58-90d25ed46786
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7211:EE_
x-ms-office365-filtering-correlation-id: bed5bb72-b3cd-4808-5906-08db1e6c46d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axLpjA35kfc6QeSb4K3vA8DWbpMYLCA+f8k/jfjv+gogTp3TWuTifN32yWpeW1ZW0Lo0yUrSNstOtLoFr9A59GDD3O5dYap1rikyDVnwhS6gGyLecn6FZWHmfDpRboK7nOrNSWhBALZkQj21ERezpH+rrmVegop3IopAERVk1rtSFrAR0FQRe4SSdDw3p+6FR/gdD7+3pbJOQ7R/pWz1W+WdE/yiZJ9T2zJ8bxuz2ZugSvo4P/jlrxEGHOtV1sCWaWklQsddG7DBUm+FqovIE894LEzb1hCKKlVRInpdDFmRIrFgqQmNkCudZJ9m5ES4UkSAl0nFaGwZn2Vs2qIO85UEU5BPOgH7yX59w3jAp2auElkaelIfQ+NahEVe0B8b5U4KtW/uE+4nZkRKiQf+gQZ2fQ8wNCY6HKKOvFZfoBO5wZqUrAWAvcuRDW7iwe+g8iFnUyuVhxUkmke4ucdlSP7xqHZ99kUGBQLa8qO/rgbQfKmv6ZaYx83PzV9nqVijlpyAw6xM0uJIwFuRe0XV4/Mv3xv6pFZdom3JsGltFrSpRXB0ckBOKDtD4pKBGfg0gAJtTjaD8rZ6LJcrll2XparkbFGFljv5n7dQvG6m8jgMm9U4uKjqQJjPnD2JjyqQe33s76s/nwz8VazY/nJ13leTAdP69pGehmfz725OFk5KLG8hA2bx9at+Off7xZAGWi68QA2BXvX1H94h67pqjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(52536014)(5660300002)(8936002)(66476007)(66446008)(41300700001)(66556008)(66946007)(2906002)(76116006)(8676002)(64756008)(110136005)(316002)(478600001)(7696005)(71200400001)(26005)(6506007)(53546011)(186003)(55016003)(122000001)(33656002)(86362001)(38070700005)(83380400001)(38100700002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW1jTmJVSUFYQnNUK0pPNW9MYnZyTlZwV2h6U0grM20xeElsNGdXRndyRjdJ?=
 =?utf-8?B?Rk1VcjRvVDQxMm5OM0g0ak9TTkpoMWpDZXI5VnYzbTRUYU1rVXg0NyszSmdh?=
 =?utf-8?B?bVhHSzBsZUxNa05hRHBjS05sVkVjUysxdXhoWVNxaDM2ZE5pMTExMEV5YURt?=
 =?utf-8?B?bWovWmRYeUM5ZG1hN01CVzVPWlBNSmZhU0RMaEpTN2NxblRRdG9qUkc5UGh1?=
 =?utf-8?B?UFJ3czNaVnBISFM4MmlucDV6TytpaWVRcjFqK01JdTFWTFZpT2hCWkczWmQ1?=
 =?utf-8?B?NzNadTRKRGNadFhmSlFoS0tFNUdZMXhiTFdNNDNZbTN3YTZ2dy9VNDFrNlg2?=
 =?utf-8?B?T2kyWlVhWVZ5TDJmV2FlcGdQWGY3eEdlVWd2cWF0OHlyNnBqY3RGLy8vaVo2?=
 =?utf-8?B?dmdVaUdNR2pYYVFldGxIZTNvZDdRZ0EwMGVybkR2bkk4eEd1dTFDRGlIUUk5?=
 =?utf-8?B?L3FpWTdqWUZIT1MxZDg0NG9EdEVYNnN6OXFZV25TWDE0K0hPdkI5V1g0dENZ?=
 =?utf-8?B?V3ZwbzI3dFV4QnA3NDVmdHdtZ0NRWFdSN1JjcGJTZWZPN1JRN2ljT1lPQ0Vi?=
 =?utf-8?B?Z00yNkZERlF2Wndna1I4WnFWMnNXMCtwUDluWFI1NFloMmhDSjVseitleU14?=
 =?utf-8?B?aGdmNGcxczdlbkRRdzl0MFN3Z1JBSVhmSnFmWVlyQ0kzT0FGT2tiQjBNZk1r?=
 =?utf-8?B?U2l1ZUZBUVlDRUNWTU5EczZ4ckRVUG5YdllEWFF4NFgyQXI5K1RhL3J5UjI3?=
 =?utf-8?B?d2FSdlBKcEs3UFhHSWRwZktnSHBENCtYdWVuZi9wdzg0bHZmNldtR05DTmZB?=
 =?utf-8?B?Uk9TcUlIRVpjSGRHYW0rTkdSOUh2SSs5YitLWkVFQ1h5YjRGREJRV0ZJZks1?=
 =?utf-8?B?Snd5Q3dyc1Nid0ZsdGFDazBvWlI3c0llMGVvbHBaNlBQRG1vbG1TU01wSmdk?=
 =?utf-8?B?c0NsQnJTT1lkZ09KcStoYmNmS2JwTkw3Vm5weTJCSURtL3RhT0U0L0JhUTlG?=
 =?utf-8?B?R0l2UXE1ajBtWVlwM3hWMW1kQm9wM2pvSSt6V3p2MzZSK3pvbTRLUUFjTmMy?=
 =?utf-8?B?bW5sbkRMdG1kUTRZZEtxQ1d0emtwb29ZQUpIUzdQejRDbjR1cFRBZnQyaTVv?=
 =?utf-8?B?RlNQdkkyMVZ1UkZvYUZNY2NZTlJTbFlEbHRYVzNLSitHYmJEQWZXL3U3UEN1?=
 =?utf-8?B?N2lGMnN6dE9WNDdLNVBWMlJJYm55R1JiMFIrWk5YaTkwYkUyVHFHb3BvaHE5?=
 =?utf-8?B?bjFRdDRPYnNBZkR2WW5QOUlhRjNwc1FXWjQyY2l3d1pPVUJKNUxBaHBXalhJ?=
 =?utf-8?B?TWJOdHNhZWdMOVJxQTNPUGo0Vld0dWdqZWFFNHk1QkI2T2IwWkVYR1h0OEZ1?=
 =?utf-8?B?VU1HL2grZi9Gc3FLOWpST1dGUnplYWlqNFpoZktPTlJDNUdqZS9HT2ErZmlt?=
 =?utf-8?B?elc0TGRrKzRmOTlIY21hRmRYc1BxVXBtTnBTaFdOek4wQXozS0Z4RkNqaEVC?=
 =?utf-8?B?STZ6NS83Z2NJSWp0RkhTSGJQVWNOdlVURWRrVXhZMmJmMXMyVk05eDJqOGx2?=
 =?utf-8?B?ekk4YkdYK3BBdDAyQ0xMd0dpc2JqVVg4WS8zVHF0YzlEUXF2enEyN3pHaFNP?=
 =?utf-8?B?QW91bHUxNnYwc0EzY2Ruck9yUWo5ZU96MjBEK05ubWp3RVU5Z3ROS0l1NHFn?=
 =?utf-8?B?R3d6d3l6Qi9IVURhTGFJejBET0lVUk95a0JvM3oxdHZZTkJSZWhwN0t1Qngr?=
 =?utf-8?B?YXQ3SDllMU1HaDJHSzk4dTNqdS9KRmJ1S2JvVXZMbU5BQzY0eXIyWThnY1Nj?=
 =?utf-8?B?OEhiM3d2d1I0aDl2d01ydm1hQTZ4V2dSdDJiQ3Z5dUcyWmxrbWRrVDhaUHQw?=
 =?utf-8?B?SEUrODdTVGl6ODRwUUs0dHB6MzI5bCt1aHdyWGlxNFNYVlZLOVpxM3VTY2VF?=
 =?utf-8?B?QnU1MWNtNExwTUhZdkh0M0UrSS9FRDZDdEhWTUNmNXhMWjJzMENpR0hraTJm?=
 =?utf-8?B?c0MrU1hFK2RKdzhYOXpNNDAwRHp5RTAyeDFlbkszQ2Uwd3dFVWdXaUVmR2lF?=
 =?utf-8?B?Z2hWSzMxN1BZUVgyZjQzNVllTlVsTFg3THQxSmRsalkxalZ6aFNvck94bmdp?=
 =?utf-8?Q?6pZ4NluTm4Rb73MuDiFebl5P8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed5bb72-b3cd-4808-5906-08db1e6c46d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 17:57:39.6458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIJjQNdzaw3uWa08iYlVxPqfrqEkLnWy8HiZBdxBr9UUtyS6thLDyKgvcUafSvGZVBJBWwRMsaB5peTM9OxE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
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
YWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBNYXJjaCA2LCAyMDIzIDEyOjQyIEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBRdWFuLCBFdmFuDQo+IDxFdmFuLlF1YW5A
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGRpc2FibGUgY3N0YXRlIHByb3Blcmx5IGZvciBkcml2ZXINCj4g
cmVsb2FkaW5nIHNjZW5hcmlvDQo+IA0KPiANCj4gDQo+IE9uIDMvMi8yMDIzIDk6MDUgUE0sIExh
emFyLCBMaWpvIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiAzLzIvMjAyMyA4OjU2IFBNLCBEZXVj
aGVyLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5l
cmFsXQ0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206
IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDIsIDIwMjMgNDozMSBBTQ0KPiA+Pj4gVG86IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gPj4+IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPj4+IFN1YmplY3Q6IFJFOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGRpc2FibGUgY3N0YXRlIHByb3Blcmx5IGZvciBkcml2ZXINCj4g
Pj4+IHJlbG9hZGluZyBzY2VuYXJpbw0KPiA+Pj4NCj4gPj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBHZW5lcmFsXQ0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT4NCj4gPj4+PiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMiwgMjAyMyA1OjIxIFBNDQo+ID4+Pj4g
VG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+ID4+Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBk
aXNhYmxlIGNzdGF0ZSBwcm9wZXJseSBmb3IgZHJpdmVyDQo+ID4+Pj4gcmVsb2FkaW5nIHNjZW5h
cmlvDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMy8yLzIwMjMgMjo0MyBQTSwg
UXVhbiwgRXZhbiB3cm90ZToNCj4gPj4+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVy
YWxdDQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+Pj4+Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT4NCj4gPj4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyLCAyMDIzIDQ6MjggUE0NCj4gPj4+
Pj4+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC0NCj4gPj4+IGdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4+Pj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBkaXNhYmxlIGNzdGF0ZSBwcm9wZXJseSBmb3INCj4gPj4+Pj4+IGRyaXZlciBy
ZWxvYWRpbmcgc2NlbmFyaW8NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IE9uIDMvMi8yMDIzIDEyOjI4IFBNLCBFdmFuIFF1YW4gd3JvdGU6DQo+ID4+Pj4+Pj4gR3B1IHJl
c2V0IG1pZ2h0IGJlIG5lZWRlZCBkdXJpbmcgZHJpdmVyIHJlbG9hZGluZy4gVG8gZ3VhcmQNCj4g
Pj4+Pj4+PiB0aGF0KGdwdQ0KPiA+Pj4+Pj4+IHJlc2V0KSB3b3JrLCBkZiBjc3RhdGUgbmVlZHMg
dG8gYmUgZGlzYWJsZWQgcHJvcGVybHkuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+Pj4+Pj4+IENoYW5nZS1JZDog
STVjMDc0YzI2NWMwYjA4YTY3YjY5MzRhZTFhZDlhYTNmZWQyNDU0NjENCj4gPj4+Pj4+PiAtLS0N
Cj4gPj4+Pj4+PiDCoMKgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIHwgOQ0KPiArKysrKysrKysNCj4gPj4+Pj4+PiDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+Pj4+Pj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4+Pj4gaW5kZXggNTFiYmVh
YTFmMzExLi4zYzg1NDQ2MWVmMzIgMTAwNjQ0DQo+ID4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4+Pj4gQEAgLTI4MTYsNiAr
MjgxNiwxNSBAQCBzdGF0aWMgaW50DQo+ID4+Pj4+Pj4gYW1kZ3B1X2RldmljZV9pcF9maW5pX2Vh
cmx5KHN0cnVjdA0KPiA+Pj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4+Pj4+PiDCoMKg
wqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX3NldF9wZ19zdGF0ZShhZGV2LA0KPiA+Pj4gQU1EX1BH
X1NUQVRFX1VOR0FURSk7DQo+ID4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2RldmljZV9z
ZXRfY2dfc3RhdGUoYWRldiwNCj4gPj4+IEFNRF9DR19TVEFURV9VTkdBVEUpOw0KPiA+Pj4+Pj4+
DQo+ID4+Pj4+Pj4gK8KgwqDCoCAvKg0KPiA+Pj4+Pj4+ICvCoMKgwqDCoCAqIEdldCBkZiBjc3Rh
dGUgZGlzYWJsZWQgcHJvcGVybHkgb24gZHJpdmVyIHVubG9hZGluZy4NCj4gPj4+Pj4+PiArwqDC
oMKgwqAgKiBTaW5jZSBvbiB0aGUgc3VjY2VlZGluZyBkcml2ZXIgcmVsb2FkaW5nLCBncHUgcmVz
ZXQNCj4gPj4+Pj4+PiArbWlnaHQNCj4gPj4+Pj4+PiArwqDCoMKgwqAgKiBiZSByZXF1aXJlZC4g
QW5kIGNzdGF0ZSBkaXNhYmxlZCBpcyBhIHByZXJlcXVpc2l0ZSBmb3INCj4gPj4+Pj4+PiArwqDC
oMKgwqAgKiB0aGF0KGdwdSByZXNldCkuDQo+ID4+Pj4+Pj4gK8KgwqDCoMKgICovDQo+ID4+Pj4+
Pj4gK8KgwqDCoCBpZiAoYW1kZ3B1X2RwbV9zZXRfZGZfY3N0YXRlKGFkZXYsIERGX0NTVEFURV9E
SVNBTExPVykpDQo+ID4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRldl93YXJuKGFkZXYtPmRldiwg
IkZhaWxlZCB0byBkaXNhbGxvdyBkZiBjc3RhdGUiKTsNCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gVGhpcyBsb29rcyBtb3JlIGxpa2UgYSBmaXJtd2FyZSBidWcuIERyaXZlciBzZW5k
cyB0aGUgVW5sb2FkDQo+ID4+Pj4+PiBtZXNzYWdlIHRvDQo+ID4+Pj4gRlcuDQo+ID4+Pj4+PiBJ
biB0aGF0IGNhc2UgRlcgc2hvdWxkIGRpc2FibGUgYWxsIGZlYXR1cmVzIGluY2x1ZGluZyBDLXN0
YXRlLg0KPiA+Pj4+PiBEcml2ZXIgZG9lcyBub3Qgc2VuZCB0aGUgVW5sb2FkIG1lc3NhZ2UuIFdl
IHdhbnQgUE1GTSBhbGl2ZSBhbmQNCj4gPj4+Pj4gcmVhZHkNCj4gPj4+PiBmb3IgaGFuZGxpbmcg
cG9zc2libGUgZ3B1IHJlc2V0IG9uIHJlbG9hZGluZy4NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+
IEFjdHVhbGx5LCBzb2MyMV9uZWVkX3Jlc2V0X29uX2luaXQgY29kZSBpdHNlbGYgaGFzIGEgYnVn
LiBQU1Agd29uJ3QNCj4gPj4+PiBnZXQgdW5sb2FkZWQgYnkgZGVmYXVsdCBvbiByaW5nIGRlc3Ry
dWN0aW9uLiBFdmVuIGlmIFBTUCBzdG9wcywgaXQNCj4gPj4+PiBjb3VsZCBqdXN0IGtlZXAgdGhl
IGhlYXJ0YmVhdCB2YWx1ZSBhcyBub24temVybyAoanVzdCB0aGF0IGl0IHdvbid0DQo+ID4+PiBp
bmNyZW1lbnQpLg0KPiA+Pj4+DQo+ID4+Pj4gUHJvYmFibHksIHRoYXQgbmVlZHMgdG8gYmUgZml4
ZWQgZmlyc3QgcmF0aGVyIHRoYW4ga2VlcGluZyBQTUZXDQo+ID4+Pj4gYWxpdmUgZm9yIGEgcmVz
ZXQuDQo+ID4+PiBBcyBJIHJlbWVtYmVyZWQsIHRoZSBjaGFuZ2UoYXNpYyByZXNldCBkdXJpbmcg
cmVsb2FkaW5nKSBzZWVtZWQNCj4gPj4+IGludHJvZHVjZWQgdG8gYWRkcmVzcyBzb21lIHNyaW92
IGlzc3Vlcy4NCj4gPj4+IEBEZXVjaGVyLCBBbGV4YW5kZXIgbWlnaHQgc2hhcmUgbW9yZSBiYWNr
Z3JvdW5kcyBhYm91dCB0aGlzLg0KPiA+Pj4gVG8gYmUgaG9uZXN0LCBJJ20gbm90IGEgZmFuIG9m
IHRoaXMocGVyZm9ybSBhc2ljIHJlc2V0IGR1cmluZw0KPiA+Pj4gcmVsb2FkaW5nKS4NCj4gPj4N
Cj4gPj4gSSdtIG9wZW4gdG8gZG9pbmcgaXQgYSBiZXR0ZXIgd2F5LsKgIFdlIGRpZCBpdCBmb3Ig
dHdvIHJlYXNvbnM6DQo+ID4+IDEuIG9mdGVuIHRpbWVzIHRoZSBkZXZpY2Ugd2FzIGxlZnQgaW4g
YSB3ZWlyZCBzdGF0ZSBhZnRlciB0aGUgZHJpdmVyDQo+ID4+IHVubG9hZC9WTSBraWxsZWQuIEV0
Yy7CoCBXZSBuZWVkZWQgYSB3YXkgdG8gcHV0IHRoZSBkZXZpY2UgaW50byBhDQo+ID4+IGtub3du
IGdvb2Qgc3RhdGUgc28gdGhlIGRyaXZlciBjb3VsZCByZS1pbml0aWFsaXplIGl0LsKgIFBsdXMs
IElJUkMsDQo+ID4+IG9uIHNvbWUgb2YgdGhlIG9sZGVyIEFTSUNTLCBvbmNlIHRoZSBTTVUgb3Ig
UFNQIGZpcm13YXJlIHdhcyBsb2FkZWQsDQo+ID4+IHRoZXJlIHdhcyBubyB3YXkgdG8gcmVsb2Fk
IGl0IHdpdGhvdXQgYSByZXNldCBzbyB5b3UgbmVlZGVkIG9uZQ0KPiA+PiBhbnl3YXkuwqAgVGhp
cyBpcyBsYXJnZWx5IHdoeSB3ZSBoYXZlIHRvIHJlc2V0IGZvciBTNCBhcyB3ZWxsLg0KPiA+PiAy
LiBTb21lIGxhcmdlIHNlcnZlcnMgZGlkbid0IHBvd2VyIG9mZiBQQ0kgZGV2aWNlcyBvbiByZWJv
b3RzIHRvIHNhdmUNCj4gPj4gdGltZS7CoCBUaGlzIGxlZnQgdGhlIGRldmljZXMgd2l0aCB3aGF0
ZXZlciBzdGF0ZSB0aGV5IGhhZCBiZWZvcmUgdGhlDQo+ID4+IHN5c3RlbSB3YXMgcmVib290ZWQg
d2hpY2ggbGVkIHRvIGRyaXZlciBpbml0aWFsaXphdGlvbiBwcm9ibGVtcyBvbg0KPiA+PiBzdWJz
ZXF1ZW50IGJvb3RzIGJlY2F1c2UgdGhlIGRldmljZSB3YXMgaW4gYW4gdW5rbm93biBzdGF0ZS4N
Cj4gPj4NCj4gPj4gSWYgdGhlcmUgaXMgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGVzZSBzaXR1
YXRpb25zLCBJJ20gYWxsIGZvciBpdC4NCj4gDQo+IEhpIEFsZXgsDQo+IA0KPiBUaGVyZSBpcyBh
IHBhcnQgb2YgRlcgcnVubmluZyB0byBoYW5kbGUgZ2VuZXJpYyByZXNldCByZXF1ZXN0cyBvbiBT
T0MyMQ0KPiBTT0NzLiBDYW4gd2UgcmVtb3ZlIHRoZSByZXNldC1vbi1yZWxvYWQgZm9yIHNvYzIx
IFNPQ3MsIHVubG9hZCBQTUZXIGFzDQo+IHVzdWFsIGFuZCBzZWUgaG93IGl0IGdvZXM/DQoNClN1
cmUuDQoNCkFsZXgNCg0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+Pg0KPiA+DQo+ID4g
QXJlIHRob3NlIGNhc2VzIHZhbGlkIHN0aWxsPyBXZSBoYXZlIHRoaXMgZm9yIEdGWDkgLSByZXNl
dCBkb25lIG9ubHkNCj4gPiBmb3IgcGFzcyB0aHJvdWdoLiBBbmQgc29tZSBvZiB0aGUgR0ZYOSBB
U0lDcyBhcmUgdXNlZCBpbiBsYXJnZSBzZXJ2ZXJzLg0KPiA+DQo+ID4gIMKgwqDCoMKgwqDCoMKg
IC8qIEp1c3QgcmV0dXJuIGZhbHNlIGZvciBzb2MxNSBHUFVzLsKgIFJlc2V0IGRvZXMgbm90IHNl
ZW0gdG8NCj4gPiAgwqDCoMKgwqDCoMKgwqDCoCAqIGJlIG5lY2Vzc2FyeS4NCj4gPiAgwqDCoMKg
wqDCoMKgwqDCoCAqLw0KPiA+ICDCoMKgwqDCoMKgwqDCoCBpZiAoIWFtZGdwdV9wYXNzdGhyb3Vn
aChhZGV2KSkNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsNCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBMaWpvDQo+ID4NCj4gPj4gQWxleA0KPiA+Pg0KPiA+
Pg0KPiA+Pj4NCj4gPj4+IEV2YW4NCj4gPj4+Pg0KPiA+Pj4+IFRoYW5rcywNCj4gPj4+PiBMaWpv
DQo+ID4+Pj4NCj4gPj4+Pj4gQlINCj4gPj4+Pj4gRXZhbg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRo
YW5rcywNCj4gPj4+Pj4+IExpam8NCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAg
YW1kZ3B1X2FtZGtmZF9zdXNwZW5kKGFkZXYsIGZhbHNlKTsNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+
IMKgwqDCoMKgwqDCoMKgIC8qIFdvcmthcm91ZCBmb3IgQVNJQ3MgbmVlZCB0byBkaXNhYmxlIFNN
QyBmaXJzdCAqLw0K
