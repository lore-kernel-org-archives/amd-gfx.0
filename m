Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57013CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 03:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C166010E2B4;
	Fri, 16 Oct 2026 03:03:33 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511D910E2B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 03:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfZvrDW2YI5k5NOf88FvEy/SNFFEogHE1zMiuysEXJkfhVH+i+AbuKeHgbG5QizYfJbEHUx5sXmjnlKtHQkx06rGhKftvX60kp3M3ogYQqtieyqluTIwckUklZ6OxHAONxGMcs1E54QvVsROqgGOpG1R5KIkhLkxhzxprrVSAG1JpHv0+UIuyWLDTq+CZJnCgPuLCNH+U8oEqe9HJvZzCvp6RPGfK3EYokZ5j+UncSs61e7S4BNFFdhv1gn0v/cCyqNZwz021Ey8pklh1xdP7NWcFBnII2MjlFuRGTPlQkCBXzopyG5KqBQnMpEoAo3p66iotIUpGrNJC0h0Q9w6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=456WqXBwrKe4ijh2LoldsUSgfEpZAxoA/uq+AuXvKjk=;
 b=dFtvOiHV+1vxmiO+Oz2LqQANY3uDzFDqJEcqeTOSqWlvxX/mHQ3S1escWvBeJINIkaXDqSYcLEteowl2nQt251WnjDMqWTxsNQ0/Z82g9owEaUOOlpeFdW6IvI5OeDkBN5XkjQ+s3W7BTzuSbRP4+CT+C5k7da/us8DOhUiAXWI4Ffa7staWsqxZ5ja69Txuj64atfm2bJWB4sISCC+xY2kRdM897VfcfCLcR7HAcAc6X1KBQrjReZm3nFrWI/QWwG9elOe8L7lmgGcaMr+bu0TT5VhWe384EVDJU2cJse4VFIBfqMcaKEv8yeagcVvuxKxAs1EYpt84RyaFZDTW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=456WqXBwrKe4ijh2LoldsUSgfEpZAxoA/uq+AuXvKjk=;
 b=NWrdub5mR7ZImJ0vH4TDZIcxCKyn8bIvWARtrdFRa9gKLiSBg7w0kCtCxiIDyugxWiCoxlACcL+AvsHRZF7Lw7j4ktIsL5xhabF4Y1tfMCO/e/mv5yYf3RAmuGna4vwyxky+R+WjbMQN6IdxFSFx7TrudOxte90qCMWp266BnLA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 03:03:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:03:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Soltani,
 Shahyan" <Shahyan.Soltani@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: map the seq64 memory when restoring
 user queues
Thread-Topic: [PATCH] drm/amdgpu/userq: map the seq64 memory when restoring
 user queues
Thread-Index: AQHdXHXhqE6XSGVd6k6KAXoQ7nvD3bb+aZMAgAES+QA=
Date: Fri, 16 Oct 2026 03:03:22 +0000
Message-ID: <BL1PR12MB51444FC74C3E3FDCC7BD8512E39B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20261015072150.3414162-1-Jesse.Zhang@amd.com>
 <262a4948-c17c-4cfb-8235-64c9b3f906de@amd.com>
In-Reply-To: <262a4948-c17c-4cfb-8235-64c9b3f906de@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T03:02:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8260:EE_
x-ms-office365-filtering-correlation-id: dbfdb954-97fd-4fdf-8596-08df2b320a1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 2XV2p2BikNwArV6vOywKZT8f2qKsCyyhnxY+358WVtVh9Jc3sdNeMMv+pUDo+ZcOL6iJQP+kJyTzE8K7M+ou5RLaywqoEGHoUJdslAU5qfUYPIe1E21ACD3NnJzV03Iu1oFmQc1SH3uH5OXFXIWnw5rvcbv03sYdzMP1a4yMLd5vCOmlFzMeK/tDCKozsi+TVnMQcwVBMLs5cSOba3CPMGyURhH753yuQxGznHRSeb4U3zD9B5qTGNIUkzc6SJxO1GmE3ttgwBinnc6ecR5eqXmLVGPKLyN5k5UbrBv1Fw4BZAgJ53OVIB98yRjd1ZG6ofhsGxQZlEcQx83cX7Q4Z2HdUvyoA5LqJLMWTom8ZM3jgc7Y7Ow5Cynoe5ePKUV7SY8mQ4zze600T1QQ8XlRI/OVwvIQR8MeIy480pWLf4ZofLYGUFwd7XFHoCzj/oDfEfkyiefe3j702WFLp6INZMwZBKvrY5K0jgTL8LVNtUJ3Epcz6A7ChBe4Waaj+Y/ZagcDERmuNLDHRmhbG/r87jMHncU8tkJ8lEYkZehszToxLPRukpQRHLMd/n0iPCIXBBKilT1EDm/BUH+1jSmMGK1wbnQLNJdHAvTsqfK6BfLoPpVLpGx9946etovyJpcx6rMQPNseQzHMWNVzbuLuddA1OVvYdURVW+qqCZPUKKIEfGYIDXUdYDa6PHBJ6xq9vL/NKeZp5afnguCvSxXIpHQDJxWAT6wFUHHW1exfJBA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3NiTVc4cmpPYXRMWXlocTBlSFllR0FwL2IySk9rNTVKMEZuRmxubWpqMXRz?=
 =?utf-8?B?RVhZU1dOb3h1eXNYV0RteGhXVXJwbll0VkpkclhEbkhTNEZ1d3lsaFVnNld5?=
 =?utf-8?B?M1hHT1VMdFZER3N4ZUV5emhnR2lrU0Jmb2JnVmJQNDRrQVpPc09MT2dhZU9Q?=
 =?utf-8?B?VHpHSlEwZGE5MExJWis4RDdGeWZKOWIrb1FZMGlrTGtwWlF0c0U1eXJmUS9S?=
 =?utf-8?B?bmQ5eWFxUy9wd0h3M1lCWjNLSzNGQks2TXhJTDJheFcvQ09IcDZEZ3k3QTRR?=
 =?utf-8?B?dzdPVG0veG5HaTczTm56MW9aSWdiNkFqanN6N3g2d3pFSEQxMHBRZEJEODM0?=
 =?utf-8?B?R0l5WWkwbk1QQlI0S2ZGUGp0N2RHZ1ZTSTlIREhTc2VvMi8xa3A5Y0xjWlFr?=
 =?utf-8?B?ZHdBZHdPRGZnYVBTOUsxTmozSnJDeHZYOGxsVnc3RFVGUnFvWjdLTTdCVThZ?=
 =?utf-8?B?eFBXTE1qOGF0TTdtNlIrUGtWQjBDWCttcUFNdHNDWittSWxXaTJBNFdaMVdS?=
 =?utf-8?B?c3UvT3BQQ2xscjhKcE9DbWIwRG1OWUJYSlNSMWtweWJYa2h6NDRlVy9TcEFQ?=
 =?utf-8?B?SnRYMFRGd3FVVVNNNFNpdCtlSmRGdWVRQS8zbGVOOThkTjlPRStwTmVIbVNB?=
 =?utf-8?B?N0h3cDgzVktQNjFXcUdPaGNaaHdURWZ1bTYybWYwZSt2SWVWWGNFUHZUSGxy?=
 =?utf-8?B?SEEwSzlzNjBjYlF4d01MV2M3NCtkcHoybVFRZ0hBVm9PR3gzZTdob0RScXht?=
 =?utf-8?B?TmZxaHMyMmNQZzM0VWpFc3NjUU9yaVNucCtWV2JPYVpSSEtLY2VMcW0vTHRp?=
 =?utf-8?B?a2JpY09MYTdoRHJRbEl0UW5zaUlqRSsvZEtRekorRnFHSThMc2RpQ2xIc3o1?=
 =?utf-8?B?MDYvSk9ZY3NMcVpLR1FKdkFHamVNanRtLzJwd1hUaW1nV2xUTnBlaG9saWZm?=
 =?utf-8?B?anBIQTRxTGlwRnVzUXBsQmlGVmJXZWZTeEwzMW5SbVVJVkRrMGhzUmx4Z1oz?=
 =?utf-8?B?eHJxdHlYc2NGaFdQM0NmNEtKY0FDMjBGYXJ6eDhEc2s4ZEVsUmExa2k3L2JL?=
 =?utf-8?B?cmR1WUhXWitGL05FSE1YOEhYajhzcHFzRW1iR1RYQWRhOXNYTEhoVEgzK25l?=
 =?utf-8?B?dmNPdFBmeS9NQ3RpdURRRDMrOEcyZEl0Wk84WDVndFJzRmt4U2FBWS9VdTly?=
 =?utf-8?B?MzNVb1Z2aU9hZEkzR0tBNFNYeVdYRVU3bVlGQUpSNmx5bFhXdkY2WUU3QWlp?=
 =?utf-8?B?WTY5bTN0eDNGalBvNHBFa2RCTkNxZlNkTnJSN0JQVHdQaGt1K1VWcTh1OW8r?=
 =?utf-8?B?ZFpvVEZ4MURHVENsQ1pmUDBsMC83N1Z4UWlJSVMwcTBTcktiWE9SM3RpUTVq?=
 =?utf-8?B?MDMyS3BhTSt2TllocDlBemU4MHhjZjJJVWx0cEpGQWdqL1ZOKzhYcThORDZa?=
 =?utf-8?B?RnI2WGNzRE9VZXhMTmIwdHhvNFlpRFpybkM4TjMzZ0lSQkpKN2M3WUI1MTRi?=
 =?utf-8?B?OFI4NFBWbnE3cjJybm5uRXlKL2c3MWtkT2hLSHhidnpMdkJFMnE2VjZCWXZE?=
 =?utf-8?B?cXI3M3ZTQmpZNWF3Q3VPVUg5QURKWEs4Wlp0SkR3MFNDekZIMU1aeVVqdFVG?=
 =?utf-8?B?YmlsQjhCOWtuNHdXRXVjMkliL3g5bnNQWGpNbTA5eHJ0QktEZmFReFZLQjR6?=
 =?utf-8?B?Z3RJRCt2TWhLWlpPNmxRRUVISDMrd2Fzc1VoTXQzZ1lsTDVOOWd0dExQci9Y?=
 =?utf-8?B?aTVZYTRmM1gvQmF5OGRhdVdzMTdnT1FFbEpESFBGRDBjZ3dqUlJncnNCNlRP?=
 =?utf-8?B?bU5xbU5lbXhLLzlkVzYzMFVWRE8wN3I4ckVva1ExQUVQdGdXTitCWEQxcjRV?=
 =?utf-8?B?bDBRR3RDQ1cydVF5YWpYTG5aMWVRN1czakJmUEpVOStlTWx5eW9JOUUzc3Yz?=
 =?utf-8?B?L0VKOEdkV1Y4TkQrN1J3eTZGTVpCYkxPMEZHODdwTGkwV0lJQUU2Y0VPblhW?=
 =?utf-8?B?UlNTbW16QmpmWVZWdGhTdkJCcXhJZTRPQjNHaWttd2tDMGg2clRrTUZwMHZ0?=
 =?utf-8?B?RDFEeG5EZWJtcVl3U1ZpWWF3TEYwM1ZwZHJUd3hSQUVsRTh2LzFEdUdKV2xJ?=
 =?utf-8?B?YUJlTGprNjlJUW9VMFdVVlVDTWlwaUZkK09sRUg0Q3pxWElEN3NEbjFsRXRZ?=
 =?utf-8?B?SjQzdEhuS1hZM2tyY0UxS2VPVHVHK2s1MWhUbzh1cEpDRDN5a0xmSFM0UUNx?=
 =?utf-8?B?TVRmY2tNZGQ5OFBpSDd1dGllYlh2WUJPZ0dOSVFvVTNwT3Jkc2dRWlQ2MVUz?=
 =?utf-8?Q?04QgeI+fQoY1VDQG9W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfdb954-97fd-4fdf-8596-08df2b320a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:03:22.7696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZP3BBfzcjYyGgEb9S4x2sjtddp4VRktrlw3LvqiCGCh1bQUANmgZhfNyKOuCiYdK7/twFwsxJQVqWEaLPwIAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgT2N0b2JlciAxNSwgMjAyNiA2OjM4IFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVz
c2UuWmhhbmdAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGlhbmcs
IFByaWtlDQo+IDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hh
dHJpQGFtZC5jb20+OyBTb2x0YW5pLA0KPiBTaGFoeWFuIDxTaGFoeWFuLlNvbHRhbmlAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS91c2VycTogbWFwIHRoZSBzZXE2
NCBtZW1vcnkgd2hlbg0KPiByZXN0b3JpbmcgdXNlciBxdWV1ZXMNCj4NCj4gT24gMTAvMTUvMjYg
MDk6MTksIEplc3NlIFpoYW5nIHdyb3RlOg0KPiA+IFNpbmNlIHRoZSBzZXE2NCBtYXBwaW5nIG9m
IGEgVk0gb25seSBnZXRzIGl0cyBwYWdlIHRhYmxlcyB1cGRhdGVkIGJ5DQo+ID4gdGhlIENTIGlv
Y3RsLCBhIHByb2Nlc3Mgd2hpY2ggb25seSB1c2VzIHVzZXIgcXVldWVzIG5ldmVyIGhhcyBpdHMN
Cj4gPiBzZXE2NCBtZW1vcnkgbWFwcGVkLiBVU0VSUV9XQUlUIGhhbmRzIG91dCB0aGUgc2VxNjQg
YWRkcmVzcyBvZiB1c2VyDQo+ID4gcXVldWUgZmVuY2VzIGZvciB0aGUgR1BVIHRvIHdhaXQgb24s
IHNvIGEgcXVldWUgd2FpdGluZyBmb3IgYW4gZWFybGllcg0KPiA+IGpvYiBmYXVsdHMgb24gaXQg
YW5kIGhhbmdzLg0KPiA+DQo+ID4gQSBHRlggdXNlciBxdWV1ZSB3YWl0aW5nIHdpdGggRkVOQ0Vf
V0FJVF9NVUxUSSBmb3IgdGhlIGFscmVhZHkNCj4gPiBzaWduYWxlZCBmZW5jZSBvZiBpdHMgcHJl
dmlvdXMgam9iICh2YSAweGZmZmZmZmZmZmZjMDAwMDAgZnJvbQ0KPiA+IFVTRVJRX1dBSVQpIG5l
dmVyIGdldHMgcGFzdCB0aGUgd2FpdDoNCj4gPg0KPiA+ICAgYW1kZ3B1IDAwMDA6MDM6MDAuMDog
W2dmeGh1Yl0gcGFnZSBmYXVsdCAoc3JjX2lkOjAgcmluZzoyNCB2bWlkOjgNCj4gcGFzaWQ6MTMp
DQo+ID4gICBhbWRncHUgMDAwMDowMzowMC4wOiAgICAgICBGYXVsdHkgVVRDTDIgY2xpZW50IElE
OiBDUEcgKDB4NikNCj4gPg0KPiA+IFVwZGF0ZSB0aGUgc2VxNjQgbWFwcGluZyB3aGVyZSB0aGUg
dXNlciBxdWV1ZXMgZ2V0IHRoZWlyIFZNIHJlc3RvcmVkLA0KPiA+IHdoaWNoIGFsc28gaGFwcGVu
cyBiZWZvcmUgdGhlIGZpcnN0IHF1ZXVlIG9mIGEgZmlsZSBpcyBtYXBwZWQsIG9uY2UNCj4gPiB0
aGUgcGFnZSB0YWJsZXMgYXJlIHZhbGlkYXRlZCBhZ2FpbiwgYW5kIHdhaXQgZm9yIGl0IGxpa2Ug
Zm9yIHRoZQ0KPiA+IG90aGVyIHBhZ2UgdGFibGUgdXBkYXRlcy4gT25seSBkbyBpdCB3aGVuIHRo
ZSBQVEVzIGFyZW4ndCB0aGVyZSB5ZXQgb3INCj4gPiB3ZXJlIGNsZWFyZWQsIHNvIHRoYXQgcmVz
dG9yaW5nIGFmdGVyIGV2ZXJ5IGV2aWN0aW9uIGRvZXNuJ3Qgd3JpdGUgdGhlbSBhZ2Fpbi4NCj4g
Pg0KPiA+IEZpeGVzOiBhZTA1ZTNmM2QwMmIgKCJkcm0vYW1kZ3B1OiBtb3ZlIGFtZGdwdV92bV9i
b191cGRhdGUoKSBjYWxsDQo+IGludG8NCj4gPiBjb3JyZWN0IGxvY2F0aW9uIikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4NCj4gVGhlIHNl
cTY0IG1hcHBpbmcgc2hvdWxkIGp1c3QgYmUgYSBub3JtYWwgaW5kaXZpZHVhbCBCTyBtYXBwaW5n
LCBzbyB0aGUNCj4gZXh0cmEgaGFuZGxpbmcgaGVyZSBzaG91bGQgYmUgc3VwZXJmbG91cy4NCj4N
Cj4gTXkgZWR1Y2F0ZWQgZ3Vlc3MgaXMgdGhhdCB0aGlzIGlzIGFscmVhZHkgZml4ZWQgZml4IHRo
ZSBwYXRjaA0KPiAiZHJtL2FtZGdwdS91c2VycTogYWN0dWFsbHkgdmFsaWRhdGUgdXNlcnEgQk9z
IiBmcm9tIEJlbmphbWluIENoZW5nIGZyb20NCj4gYSBmZXcgZGF5cyBhZ28uDQo+DQo+IFBsZWFz
ZSBtYWtlIHN1cmUgdGhhdCB5b3UgaGF2ZSB0aGlzIHBhdGNoIGFuZCByZS10ZXN0IGlmIHRoYXQg
aXNzdWUgc3RpbGwgaGFwcGVucw0KPiBvciBpZiB3ZSBhcmUgbWlzc2luZyBzb21ldGhpbmcgZWxz
ZS4NCkhpIENocmlzdGlhbiwNCkJlbmphbWlu4oCZcyBwYXRjaCwgZWE5YmU5MGE1NTU4ICjigJxk
cm0vYW1kZ3B1L3VzZXJxOiBhY3R1YWxseSB2YWxpZGF0ZSB1c2VycSBCT3PigJ0pLCBpcyBhbHJl
YWR5IGluY2x1ZGVkIGluIHRoZSBzb3VyY2UgYmFzZSBmb3IgdGhpcyBwYXRjaC4NCg0KVGhlIGdh
cCBJIHNlZSBpcyB0aGF0IHRoZSBzZXE2NCBCTyBpcyBwaW5uZWQgaW4gR1RUIGFuZCBpdHMgYm9f
dmEgcmVtYWlucyBvbiBpbmRpdmlkdWFsLmlkbGUuDQphbWRncHVfc2VxNjRfbWFwKCkgYWRkcyB0
aGUgbWFwcGluZyB0byBib192YS0+aW52YWxpZHMsIGJ1dCBhbWRncHVfdm1fYm9faW5zZXJ0X21h
cCgpIG9ubHkgbW92ZXMgYWx3YXlzLXZhbGlkIEJPcyB0byBuZWVkc191cGRhdGUuDQoNCkJlbmph
bWlu4oCZcyBwYXRjaCBvbmx5IGxvb2tzIGF0IHRoZSBpbmRpdmlkdWFsIGV2aWN0ZWQgbGlzdC4g
c28gaXQgZG9lcyBub3QgcGljayB1cCB0aGlzIGNhc2UuDQoNClRoYW5rcw0KSmVzc2UNCj4NCj4g
VGhhbmtzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgMTkNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IDRkY2ExYWI0ODQx
MC4uOTRiOWU2ODkwZjkxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmMNCj4gPiBAQCAtMTA3MCw2ICsxMDcwLDEyIEBADQo+IGFtZGdwdV91c2Vy
cV92bV92YWxpZGF0ZV9hbmRfcmVzdG9yZV9xdWV1ZShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21ncg0K
PiAqdXFfbWdyKQ0KPiA+ICAgICAgICAgICAgIGlmICh1bmxpa2VseShyZXQpKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgZ290byB1bmxvY2tfYWxsOw0KPiA+DQo+ID4gKyAgICAgICAgICAgLyog
VGhlIHBpbm5lZCBzZXE2NCBCTyBvbmx5IG5lZWRzIGEgc2xvdCBmb3IgdGhlIHJlYXJtICovDQo+
ID4gKyAgICAgICAgICAgcmV0ID0gZHJtX2V4ZWNfcHJlcGFyZV9vYmooJmV4ZWMsICZhZGV2LT5z
ZXE2NC5zYm8tDQo+ID50Ym8uYmFzZSwgMSk7DQo+ID4gKyAgICAgICAgICAgZHJtX2V4ZWNfcmV0
cnlfb25fY29udGVudGlvbigmZXhlYyk7DQo+ID4gKyAgICAgICAgICAgaWYgKHVubGlrZWx5KHJl
dCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICBnb3RvIHVubG9ja19hbGw7DQo+ID4gKw0KPiA+
ICAgICAgICAgICAgIC8qIFRoaXMgdmFsaWRhdGVzIFBEcywgUFRzIGFuZCBwZXIgVk0gQk9zICov
DQo+ID4gICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X3ZtX3ZhbGlkYXRlKGFkZXYsIHZtLCBOVUxM
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfdXNlcnFf
dmFsaWRhdGVfdm0sDQo+ID4gQEAgLTExNDAsNiArMTE0NiwxOCBAQA0KPiBhbWRncHVfdXNlcnFf
dm1fdmFsaWRhdGVfYW5kX3Jlc3RvcmVfcXVldWUoc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4g
KnVxX21ncikNCj4gPiAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICBnb3RvIHVubG9ja19h
bGw7DQo+ID4NCj4gPiArICAgLyoNCj4gPiArICAgICogVGhlIHNlcTY0IG1hcHBpbmcgaXMga2Vw
dCB1cCB0byBkYXRlIGJ5IHRoZSBDUyBwYXRoIG9ubHksIGJ1dCB0aGUNCj4gPiArICAgICogcXVl
dWVzIHdhaXQgZm9yIHVzZXIgcXVldWUgZmVuY2VzIHRocm91Z2ggdGhlaXIgc2VxNjQgYWRkcmVz
cy4gSXRzDQo+ID4gKyAgICAqIFBURXMgb25seSBuZWVkIHdyaXRpbmcgd2hlbiB0aGV5IGFyZW4n
dCB0aGVyZSB5ZXQgb3Igd2VyZSBjbGVhcmVkLA0KPiA+ICsgICAgKiBlLmcuIGJ5IGFtZGdwdV92
bV9oYW5kbGVfbW92ZWQoKSBhZnRlciBhIFZSQU0gbG9zcy4NCj4gPiArICAgICovDQo+ID4gKyAg
IGlmICghbGlzdF9lbXB0eSgmZnByaXYtPnNlcTY0X3ZhLT5pbnZhbGlkcykgfHwgZnByaXYtPnNl
cTY0X3ZhLQ0KPiA+Y2xlYXJlZCkgew0KPiA+ICsgICAgICAgICAgIHJldCA9IGFtZGdwdV92bV9i
b191cGRhdGUoYWRldiwgZnByaXYtPnNlcTY0X3ZhLCBmYWxzZSk7DQo+ID4gKyAgICAgICAgICAg
aWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgICAgIGdvdG8gdW5sb2NrX2FsbDsNCj4gPiAr
ICAgfQ0KPiA+ICsNCj4gPiAgICAga2V5ID0gMDsNCj4gPiAgICAgLyogVmFsaWRhdGUgVXNlciBQ
dHIgQk9zICovDQo+ID4gICAgIGxpc3RfZm9yX2VhY2hfZW50cnkoYm9fdmEsICZ2bS0+YWx3YXlz
X3ZhbGlkLmlkbGUsIGJhc2Uudm1fc3RhdHVzKSB7DQo+ID4gQEAgLTEyMDMsNiArMTIyMSw3IEBA
DQo+IGFtZGdwdV91c2VycV92bV92YWxpZGF0ZV9hbmRfcmVzdG9yZV9xdWV1ZShzdHJ1Y3QgYW1k
Z3B1X3VzZXJxX21ncg0KPiAqdXFfbWdyKQ0KPiA+ICAgICAgKiBpdCBleHBsaWNpdGx5IChhcyB0
aGUgQ1MgcGF0aCBzeW5jcyBpdCkgYmVmb3JlIHJlc3RhcnRpbmcgcXVldWVzLg0KPiA+ICAgICAg
Ki8NCj4gPiAgICAgZG1hX2ZlbmNlX3dhaXQoZnByaXYtPnBydF92YS0+bGFzdF9wdF91cGRhdGUs
IGZhbHNlKTsNCj4gPiArICAgZG1hX2ZlbmNlX3dhaXQoZnByaXYtPnNlcTY0X3ZhLT5sYXN0X3B0
X3VwZGF0ZSwgZmFsc2UpOw0KPiA+ICAgICBkbWFfZmVuY2Vfd2FpdCh2bS0+bGFzdF91cGRhdGUs
IGZhbHNlKTsNCj4gPg0KPiA+ICAgICB4YV9mb3JfZWFjaCgmdXFfbWdyLT51c2VycV94YSwgdG1w
X2tleSwgcXVldWUpIHsNCg0K
