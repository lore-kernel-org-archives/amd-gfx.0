Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C05FC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 15:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A470F10E116;
	Wed, 15 Jul 2026 15:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZIZpOC2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC7910E116
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLQy1/CjeqYtgAEZyQCmdtPj/FsyIZNrtvcebiGixD9tsFEaN4nYdWQ9sLzDVheQ9/5MZtOWL7blBCf6jV8qKN3KvuGWHTPexJhZN8LmSTrg6Llot8il9+5uTzSuCktXm50BnVOQGFBwYE9uNWL40GTbjADZKlUe5n7JAhZQAh460s+OrxpGmibcvC8RLCBxiZ+n9BCXnRdRXX4bFEuIBusKQr0j/ljP+n0SDSVPgZJB/XNKvIM4A9fn0Eq0wOynmE/91reZlTPvzWrgovC0oFvXkeUGcQzF3zOCjXHZ1hGRG6TBr/mIRGkDb/frlFQbYNZVkrRZr0umpSrdvoYJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahbZqxT0rsnvSzzfelZN148Qj2WeuP7zcq/YxX1qIoo=;
 b=KL2VZddRhFnpYP8M0562ZZNltvnnB/78IQ6zVxRaTx8L+WH8/4IigsI1f2QoJvPsermELQYc0c/erC2Pij5cQd9cY8N+muZ+Y5RAFdZd0pMrzxtP4HsgXYasA2D8xnYNHUbI27wqScatPCQOv1b4uGhNfq6sRSctzsVXpwzNlFgFNMsMn51Y9nz1M9I89c/IRaq6pb5FSfx+/036kyBB1gR/BBwPGXN5pGDZ+X4sr+4GVNoMIhIq/FPEi2SK60AWTcCc7QZHThv7mFJZsPsPiiZfG38BvyF59Nc7/Nyc3AbHRWpkaU/9TtNsJbCgoUw71ISQ5kiryNKDOrfWA9f24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahbZqxT0rsnvSzzfelZN148Qj2WeuP7zcq/YxX1qIoo=;
 b=AZIZpOC2uv8q5lskdAvyzPchIp0pXWGulnAX+kQW2iiDSRr6pxtFHvvKw99xzwqjyW8/w5I8wg+Ww991uhDsXYok15JE0IFCcKbKkJydj1o3vxypaGFPta3cNZDEL4KyIe5ATjF7G7sJO6JOQvCXg37NJnRR+CRZgIoQWyE0GtI=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by MN2PR12MB4240.namprd12.prod.outlook.com
 (2603:10b6:208:1d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 15:46:42 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 15:46:42 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>, Melissa Wen
 <mwen@igalia.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before
 creating polling workqueue
Thread-Topic: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before
 creating polling workqueue
Thread-Index: AQHdESipWAyT4un6XEi8apnN+m86nLZuuglA
Date: Wed, 15 Jul 2026 15:46:41 +0000
Message-ID: <CHXPR12MB999220BD34392F514B0B5C948AE5F82@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260711113009.26512-1-timur.kristof@gmail.com>
 <20260711113009.26512-2-timur.kristof@gmail.com>
In-Reply-To: <20260711113009.26512-2-timur.kristof@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T15:25:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|MN2PR12MB4240:EE_
x-ms-office365-filtering-correlation-id: 37df8844-876f-4456-7b43-08dee2884421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|921020|38070700021|22082099003|18002099003|10067099003|4143699003|5023799004|56012099006|11063799006;
x-microsoft-antispam-message-info: P0JKAqIHbDzf9pDEPyUodcRItI1e7OMYIN60QVXwPwOfmcqa+8piBPEiIv6bAluSGKsduQh+mQzAMyAnkx9ufesvNioAB8Bov4+lBp+mVHaW5iV3HPJ0aA7wjiYsbYpjkYlA6fzn9eXzJGkLqpShs1DhtFlPn5DTfAjRwDhBCVqFft8vif/PeUGxCSMf7njh4mFOKkFBGFFdC0GQYH/riHJ6pO45a7Hq77siaLw8hj53pzYApdv0I4apYfeGDCGWx43o9jbvsuZyddHFdWtWd9WIxGPL+WbU8RVHKTHEY0EaoDWYJZv5fy9HDez6d2xaL/MxmABNQp1L6GANhm2fR3EwRePlRfDgSEQ1m0l8TfqPd3rhyzUECYhjpo+LIfEonqTTSSc8z6Y+fBzBl8oXGdu+ZZ/jedcWaQpCQWeZmoVu0h4DTIsRAka179hazQ8aJqwXgeym5z39tyvaq7zWTtCSicozntXiIb5Z4b/qKXj7xctlXqvupy5+W53Kafo441PCU1lFTmBjNpm4JyTsnhA6kId5mNTc8eS1mrzDhn586ROUhEIpgHgQs2i07o/6xdWGisfb9MJhcCBcT+zGbz+FqKGXkWT46oa9vG/JOwS2TsfEClDQ+wPP1Ei8JlHOfK4o9XMGRXAwjkx2w8qRWOxDxhI4g9cPW/QxcNTchSwFjt5zFGFqe9/vYr6gsaLokUT3rJTSbBnhpt7CYC8+zFa4+JFy7tTSDcAgMzbzTgyrfg6z5o1EpTeNKLN8LkIX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(921020)(38070700021)(22082099003)(18002099003)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkZxOUlnQnhURmRZbHZkMngwTHVVUnRiWGJ0dmhPNzQzQXNNalhNVFhmM3R6?=
 =?utf-8?B?ek1WaXV4ekRGMHpjY2Y0SHpBdFc5bk5Ya015QnVWcE5mREdkdzRZTTN1MFh6?=
 =?utf-8?B?MzQzWk1IVXNFb0dOVG1jRXB5Y2x0ek5UY29GbWVHQWpPaHdGT0NmWE1ZZWtz?=
 =?utf-8?B?ZUhRbHlEcTYvcDByNHpIc1FDTUJqM0FDb3NzdlM5MmlKUzhUQkFJQ3I4aHdi?=
 =?utf-8?B?TEYwMUxZL2RyVXQ5c0NkTm9nSUUybkhzdGkvWHlQb1BLQ3Fnd1c3RkJCZGRD?=
 =?utf-8?B?dXVNL2MrYUw5d09pdk0rQlF1UFp5ZXNwK05Wb3VNVjlaUUo4anJIdjlUREF0?=
 =?utf-8?B?UFBoSmZJN1VDT254eWd5TWsyNUpaYXZHV3lHSGgyVlYrNTU0ZjQxdDRYVms3?=
 =?utf-8?B?TDY3UnFpNEU5QjhkT29uUERienRndU02dWovb0gvTzhxUHdLdFQvZ25YWmpR?=
 =?utf-8?B?ZktXQ01ML3JBdjJDVjF3TFc1UWthYVJRSG9qUnRaMXI3QXkyZ3oyT1p4d1Mz?=
 =?utf-8?B?dEFWTU1pTnBnYXVmUU5VU1d6UHB4TmU2bnZGM3QvYUcydDVsRFp5aUdMbTJU?=
 =?utf-8?B?RndiMzhBZldvUzZrTFJJWXVKNzhjdXhqWGpocFM1NHh3TDIzSG5yU2ROQjRh?=
 =?utf-8?B?czFHelNsYXpMVW9VMVEySDkvZGxSMWR0OXhIYVZDT1lwaWtJNWx3U2NVOWRN?=
 =?utf-8?B?dmltZXl2ZCtCSzlpM3BwWDJyMmdoMXk4OW9XaTRDWld3VEhtRUJXcmV0OHp6?=
 =?utf-8?B?Y3Q1bnNmV2tMZTVYOXF2anZ1SkFHaEJoQ2d4bWJBc25PVElEaTNqV3owSlI5?=
 =?utf-8?B?dmhlU2dxSE9rQy8wNlBwTko4MDhQdUxtQVZEamxnRXlpZ2FNcE9WQ2lublg5?=
 =?utf-8?B?UHFKNkpqVUdMTkQ4Y2JzamF1TWF3WWlSL1o3UTBDWmVLVDNWanQxYnRmUEIw?=
 =?utf-8?B?TGY2UGdhZDFRZ3NNWU1rVFcraVRjY2d4Uk43RWFGZ3M3dDBKUlZLeTM5cWUv?=
 =?utf-8?B?UTRoMlk3eTFHL01oL3F3RnJVd25RcHlTcisxTWFSVytSbngyOVkyNUlVc0dS?=
 =?utf-8?B?c1ZOZHFiSm52SmdjOHBUQ1M2SEhqcHdZRlYrd3dTTllzUUZ4WUtjeEJtYlps?=
 =?utf-8?B?RWI3NjhUN1ZOOUFJQ3ZzN05IMjNaa3lTV3A2cmlzTGMxUXhSS21ob21PSmJY?=
 =?utf-8?B?dXdjZHJnVTg2QWNvVHcxMVd2WVV5dGFkR0xETElZQ01hdy9JcENMWGJxbWV0?=
 =?utf-8?B?dVlRVGlLbTlkd0Q3aTFoVnZhWWR2N0o2NEJHLy9pRTlOR3Z2YU5BcjZtaVFs?=
 =?utf-8?B?Vmh4UjVHQ1NxQ1JtK2xxVTRML3pHcnIxL0VCNEhnaEZmeDhzMjgzck9KMEJt?=
 =?utf-8?B?U3ZmSm8ydTF1S0VPOXpJZHdkL1hucDlidDRva3dWWlB1OFk2d3k2ampHQWdr?=
 =?utf-8?B?UVhJWm9xbTl3ZkR3NGZPUUdUYzlDS3MrK0hzd1ZOQjgvRkhRa3J3cXV2SGti?=
 =?utf-8?B?eVEvTVpHamI0WnRMaXpJcmUvMVEwdUFYc2JVN1g0L3VSOWl2MG5uWlpOMDFw?=
 =?utf-8?B?ZFoxQXZidUZJZHVXK2FtbkR6RDdZVDBxS1A2Y1Y1MWg3S1FpbTZDdUw5ay9P?=
 =?utf-8?B?S3Z4TGxrdzlkZUp6aHY3WmZhZ1Q2ZnZxS3hlN3ViU2p0RW9URUorcWFvTk42?=
 =?utf-8?B?bGpaekoyY1JzcVdzOTRQV0tJd2ZiT0FNUlozcStROWw1Wi9na2dnWHdOTVFw?=
 =?utf-8?B?U2J4RWRuRnZFQzkwbDQ1akNMV2NyOXNQbmV4ZjRZTldUUWlxNzczTUM4Tk84?=
 =?utf-8?B?TG14N0xoaU9UVzR5KzcyZENnZStkd1k2L0lOK1h3c2FIUnZIeHJGMmNFTzZR?=
 =?utf-8?B?VngzZ1JiZzBoN0VrRjU2cGtPS2d3cXVxVjBoT0F3NjVWVlpnNlVCQnJnVjNz?=
 =?utf-8?B?WWY3Tm5QN1gwZi8wNU5MZG1Wd0ZjYlltT2l6MEdYUHB5NFBiTkFHUmhKcXZZ?=
 =?utf-8?B?WHk5dFV4SStUZkNVb1lzRDZjbnBnREo1OXQ0cFEvRTN6S1dXMUkxRWxFV2NP?=
 =?utf-8?B?ekFCQVVLMmVZM0l0REpiRVp0L1h3RDEzNHA4K2wzWHl3VFVCS3dmWW90QjhV?=
 =?utf-8?B?WHlsOG9ibGtadHN1UHg4cHZGYlpKNlBqdGxScDFGWDZpZk9VUXpCQjZUbkI4?=
 =?utf-8?B?NTJNdG52L0pxQWxNclZHbFh1RmZpWjhOMThwajQxdW9zcHlHbnpRWFRRK2Vm?=
 =?utf-8?Q?O4JOSd2xtzD1RARaON9NdSxrlwC8pTj91kQxZSO5kQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37df8844-876f-4456-7b43-08dee2884421
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 15:46:41.9033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9bfDZ2jj1POrKbemgrnSQAd0NAayFN7SrN/m2DrjT8sBMobUDmiEEBjIdbGBBuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

QU1EIEdlbmVyYWwNCg0KSXQgbWF5IG5vdCBiZSBuZWNlc3NhcnkgdG8gaWRlbnRpZnkgd2hldGhl
ciBpdCBpcyBGUkwgd2hlbiBjcmVhdGluZyB0aGUgcXVldWUuIEZSTCBpcyBub3QgZGV0ZXJtaW5l
ZCB1bnRpbCBsaW5rIGRldGVjdGlvbi4gV2hldGhlciBtYWtlIHRoZSBxdWV1ZSBhY3RpdmUgb3Ig
bm90IGlzIGR5bmFtaWNhbGx5IGRldGVybWluZWQgYnkgd2hldGhlciBhbiBhY3RpdmUgRlJMIHN0
cmVhbSBwcmVzZW50cy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBh
bWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYg
T2YgVGltdXINCj4gS3Jpc3TDs2YNCj4gU2VudDogU2F0dXJkYXksIEp1bHkgMTEsIDIwMjYgMDc6
MzANCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBUdnJ0a28gVXJzdWxpbiA8dHVyc3Vs
aW5AdXJzdWxpbi5uZXQ+Ow0KPiBOYXRhbGllIFZvY2sgPG5hdGFsaWUudm9ja0BnbXguZGU+OyBN
ZWxpc3NhIFdlbiA8bXdlbkBpZ2FsaWEuY29tPjsNCj4gTGltb25jaWVsbG8sIE1hcmlvIDxNYXJp
by5MaW1vbmNpZWxsb0BhbWQuY29tPjsgSHVuZywgQWxleA0KPiA8QWxleC5IdW5nQGFtZC5jb20+
OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQo+IENjOiBUaW11ciBL
cmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAyLzJd
IGRybS9hbWQvZGlzcGxheTogQ2hlY2sgSERNSSBGUkwgc3VwcG9ydCBiZWZvcmUNCj4gY3JlYXRp
bmcgcG9sbGluZyB3b3JrcXVldWUNCj4NCj4gVGhlIHdvcmtxdWV1ZSBpcyBub3QgbmVjZXNzYXJ5
IHdoZW4gRlJMIGlzIG5vdCBzdXBwb3J0ZWQgb3Igd2hlbiBpdCdzDQo+IGRpc2FibGVkLiBBZGQg
YSBoZWxwZXIgdG8gdGVsbCB3aGVuIHRoZSBjdXJyZW50IGJvYXJkIGhhcyBhbnkgSERNSSBGUkwN
Cj4gY2FwYWJsZSBjb25uZWN0b3JzIGFuZCBjYWxsIHRoYXQgYmVmb3JlIGNyZWF0aW5nIHRoZSB3
b3JrcXVldWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlz
dG9mQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMgfCAgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGMuYyAgICAgIHwgMjYgKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggICAgICAgICAgIHwgIDIgKysNCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXgg
NjI5OWYwZTM4NGYxLi44N2Q3YjYwY2ViM2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBAQCAtODI3LDcgKzgyNyw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFk
ZXYpDQo+DQo+ICAgICAgICAgICAgICAgZGNfaW5pdF9jYWxsYmFja3MoYWRldi0+ZG0uZGMsICZp
bml0X3BhcmFtcyk7DQo+ICAgICAgIH0NCj4gLSAgICAgaWYgKGFkZXYtPmRtLmRjLT5jYXBzLm1h
eF9saW5rcyA+IDApIHsNCj4gKyAgICAgaWYgKGRjX2lzX2hkbWlfZnJsX3N1cHBvcnRlZChhZGV2
LT5kbS5kYykpIHsNCj4gICAgICAgICAgICAgICBhZGV2LT5kbS5oZG1pX2ZybF9zdGF0dXNfcG9s
bGluZ193cSA9DQo+DQo+ICAgICAgIGNyZWF0ZV9zaW5nbGV0aHJlYWRfd29ya3F1ZXVlKCJoZG1p
X2ZybF9zdGF0dXNfcG9sbGluZ193cSIpOw0KPiAgICAgICAgICAgICAgIGlmICghYWRldi0+ZG0u
aGRtaV9mcmxfc3RhdHVzX3BvbGxpbmdfd3EpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGMuYw0KPiBpbmRleCAxYjY2MjdhOTJkMjQuLjFhNzA3M2FiYjhiYSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jDQo+IEBAIC02NTky
LDYgKzY1OTIsMzIgQEAgdm9pZA0KPiBkY19tY2xrX3N3aXRjaF91c2luZ19md19iYXNlZF92Ymxh
bmtfc3RyZXRjaF9zaHV0X2Rvd24oc3RydWN0IGRjICpkYykNCj4gICAgICAgICAgICAgICBkYy0+
Y3VycmVudF9zdGF0ZS0NCj4gPmJ3X2N0eC5idy5kY24uY2xrLmZ3X2Jhc2VkX21jbGtfc3dpdGNo
aW5nX3NodXRfZG93biA9IHRydWU7ICB9DQo+DQo+ICsvKioNCj4gKyAqIGRjX2lzX2hkbWlfZnJs
X3N1cHBvcnRlZCgpIC0gQ2hlY2sgSERNSSBGUkwgc3VwcG9ydA0KPiArICoNCj4gKyAqIEBkYzog
W2luXSBkYyBzdHJ1Y3R1cmUNCj4gKyAqDQo+ICsgKiBSZXR1cm46DQo+ICsgKiBUcnVlIGlmIHRo
ZSBjdXJyZW50IGJvYXJkIGhhcyBhbnkgSERNSSBGUkwgY2FwYWJsZSBjb25uZWN0b3JzLA0KPiAr
ICogRmFsc2Ugb3RoZXJ3aXNlLg0KPiArICovDQo+ICtib29sIGRjX2lzX2hkbWlfZnJsX3N1cHBv
cnRlZChzdHJ1Y3QgZGMgKmRjKSB7DQo+ICsgICAgIGludCBpOw0KPiArDQo+ICsgICAgIGlmICgh
ZGMtPmNvbmZpZy5lbmFibGVfZnJsKQ0KPiArICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4g
Kw0KPiArICAgICBmb3IgKGkgPSAwOyBpIDwgZGMtPmxpbmtfY291bnQ7ICsraSkgew0KPiArICAg
ICAgICAgICAgIGlmIChkYy0+bGlua3NbaV0gJiYNCj4gKyAgICAgICAgICAgICAgICAgZGMtPmxp
bmtzW2ldLT5saW5rX2VuYyAmJg0KPiArICAgICAgICAgICAgICAgICBkYy0+bGlua3NbaV0tPmxp
bmtfZW5jLQ0KPiA+ZmVhdHVyZXMuZmxhZ3MuYml0cy5JU19IRE1JX0ZSTF9DQVBBQkxFKQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgIH0NCj4gKw0KPiArICAg
ICByZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogZGNfaXNfZG11Yl9vdXRi
b3hfc3VwcG9ydGVkIC0gQ2hlY2sgaWYgRE1VQiBmaXJtd2FyZSBzdXBwb3J0IG91dGJveA0KPiBu
b3RpZmljYXRpb24NCj4gICAqDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oDQo+
IGluZGV4IDEzYzFmN2NkOWQ3ZC4uZDI3Yzc0MzdlZTdhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGMuaA0KPiBAQCAtMzA1Niw2ICszMDU2LDggQEAgYm9vbCBkY19zZXRfaXBz
X2Rpc2FibGUoc3RydWN0IGRjICpkYywgdW5zaWduZWQgaW50DQo+IGRpc2FibGVfaXBzKTsgIHZv
aWQgZGNfejEwX3Jlc3RvcmUoY29uc3Qgc3RydWN0IGRjICpkYyk7ICB2b2lkDQo+IGRjX3oxMF9z
YXZlX2luaXQoc3RydWN0IGRjICpkYyk7DQo+DQo+ICtib29sIGRjX2lzX2hkbWlfZnJsX3N1cHBv
cnRlZChzdHJ1Y3QgZGMgKmRjKTsNCj4gKw0KPiAgYm9vbCBkY19pc19kbXViX291dGJveF9zdXBw
b3J0ZWQoc3RydWN0IGRjICpkYyk7ICBib29sDQo+IGRjX2VuYWJsZV9kbXViX25vdGlmaWNhdGlv
bnMoc3RydWN0IGRjICpkYyk7DQo+DQo+IC0tDQo+IDIuNTUuMA0KDQo=
