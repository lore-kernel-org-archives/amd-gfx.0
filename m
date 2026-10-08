Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0363CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 08:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6265510FCED;
	Thu,  8 Oct 2026 08:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5cuMdw7a";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A532C10FCED
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 08:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZmiWoHYM8HeVA8WLaeu2aNcYTyeW47db24tPn4jdEPluHRxY1KwIFa1sNuVZjxr3i0s1ZuaBzxg/Y09pBbeeiXnJTiNhZrqybdTrBmU3s4/gGk7U4j/BFh4KoacI6MXZwIaV69etv8zB9HV5ro4OK1JDWLTuDrGS6ZH/ydvMOAnE3G6rQzZZxYKceRktgtYUA+Dm/D24uqhjHBmIRPcG4XeqFjU1eP+uQCkZUVUry4ByanaalQ0h8vU/pbc651YdWWqEyZ/OYYN3glYFYeQi8MHhnGmd1pVhg6eCJcXIQeHmaWrZwoqgrc0QfdCeg0DuIb8eIqTQX3rVU4CDXIETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZJ7Kd27je/ER3HMaJYJgnE2xERrgWvbDyoInZcmhkw=;
 b=HRgfs9deQVXJh3ALY9RWLHmgUMyWJa0SYjIbLtfMpAkgJx6dY9AL6xBszX4waHaJHaEljwD4kN0qR36I1+sRICpnws1XG2qwEJt4CvFpp2jY+h1jXJCLwKJdLEml3eHDLpe2zCOo3h9lnFOj6GD3Ha+t78elq/ksa/fgUXwJFmlXUEUeULoTrOb/T1brZPPF/9uZL2vWM5TCNm1LNDqtYs8iVp8U0etsKuLfqqwTxX0iCxK/p8qyRYidigeF3fLaSOxkznYSjV9/nMNTIHTcIemfT2d2aj9QB2XhxfIY5R4bZOR5fcMye6lXdDHazyDSvoIoElD2z0o2HOHhw+FG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZJ7Kd27je/ER3HMaJYJgnE2xERrgWvbDyoInZcmhkw=;
 b=5cuMdw7aSPLO4nVm7ftw5FOGCOWTWM9ThmMRTta0K4RH86wbsD/nO9O6F9lSfTOIY4bk2+Mf2LTrILxGjR6UKizPS6SV14+dAKZpIV4SvDA0Qt+g9VVxTrgKrPEw1rpk0basSFf/tS2BFOL3XDo08k1/BIEwYwRHkvRMQm9bovQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 08:06:55 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 08:06:55 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx11
 userqueues
Thread-Topic: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx11
 userqueues
Thread-Index: AQHdOVtSywVSZMCaWkKLCbF1JXmYFrbzhDzg
Date: Thu, 8 Oct 2026 08:06:54 +0000
Message-ID: <DM4PR12MB5152CAC197B2A15B4D43596FE3932@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260831150211.1486154-1-sunil.khatri@amd.com>
 <CADnq5_Mz1KrT70mLEbJ4EqikmFGGRiJLXXEWF++pfu2LQC+wQQ@mail.gmail.com>
In-Reply-To: <CADnq5_Mz1KrT70mLEbJ4EqikmFGGRiJLXXEWF++pfu2LQC+wQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T08:03:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB9468:EE_
x-ms-office365-filtering-correlation-id: ec4e1520-922a-4e9c-3dd9-08df25131e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|4143699003|10067099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: IMhB4W3cx3FWQ8jEwYRI3xEVWt88UMd/9tzckcsv2nxVl2F27v/Lf/19SJUzMVSVgiaqm1I7Vb6Z9IlDQXo8YkVJCHcQBRzXV8RLlUMSGbXyUzGHrMn1TzzoEvWXT6uiilXsCuCPrqJaSKNyMbdRzyzKNmMdOqB9/8SCCA9eOm+JmUVMNvFiUEyGkEA7e5zkDpow38wkm+pLmkHjvvYBTlkABan8RUI9M32TSE2ZVvoBWm5tHeK7ul6EnaO7PhtWX7P+mdaJBXFvztSp5RcF/23GkN6FGGdFcVpGKnaNHxzTvD9yfAoIfRfNOx1iLD3DFHy0z/2WdhcgnxUkVGD3H8Tg7cye7AmSoNhlvhLfS4jVui9MEZpQmbFNZhVrpks+DvNda3lSZKokL1Kwv6U/Ln9IFqrqTiiGFYXgx2G3QcVcVrRcQTmnhBs1DZXmMCMIG+lq3pKGd1onHNTNYOM8EjwUfebsdugIlcHthdSbkKp0kwk3dyFQXwsE7zvEOQBe0fNVHtspqRXtzWmi8vIsco9ffWg6rKEgzHl/G+mmDJPQUff8Ig4GMn2dFLCnyWpvX+V0gJTG0QM3YtuiVY1WHKQJLqHdsd5PTX894o5dV5DhpOvCQl8Y8WUjteSL3Bpe7qgY1cCHG7JfuiVIzDTuy8LDQ+L/dAtvGiZeuBU2TA8mf7GjeRoh1l2VCHZb01YCn0x+ntkKirX8ruwcEbqLE459sEQd6cVbfCQbb305WaU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnk2QmZ4SmJ5ZkMrQ3VSaFJGWXRSclFMQ1RGRTljaEs1K0R6ZHNsU1NidVN0?=
 =?utf-8?B?a1pMWXplQzNRbUZtQ204dnp6SkRnZ05xNUk1SzZ0T01OeGNXVjh3QXZjZkxG?=
 =?utf-8?B?bXB0L3VLU2RtMkhqcG50ZDVIZWg4T25OSUgwSGg5RThsaW5uSnBBV1Z0NWF3?=
 =?utf-8?B?R2NxZzJ2RENhZDJENnoyNDQrRUdPQ1NVK2NQaU1udnA4Qzh1bnhCVFVwWHE5?=
 =?utf-8?B?NUdpdFFlSXB3dXNKdXVkdU5mTmhiR1YveWdGSHFKN0h0UjArMUdkTysxZkxN?=
 =?utf-8?B?OHlINEZWaGNqVUhRRk9RSXdUUFVJOWU0Njc4MysxbW85V3V4UXN1a2ludzVx?=
 =?utf-8?B?QkNHbm95SGZ6c3NyTnJUUVlreUpnTW5TSElhN0NVYWlMSWhLMVMvL2hCSVkr?=
 =?utf-8?B?THRrRjR3YklnUjJmdjUyTEt6clhLSkRCY3ZMalRpNTF2NEw4ZkovYWdPa0lQ?=
 =?utf-8?B?bmx6dXQyL0VsSkwzeEkzbXl2TlZMMGRJN3lJUHdxdzl3ZDlYWDk1Mi9XZlg1?=
 =?utf-8?B?WWtNTzA1NXk0Qm1kU3p2bnVUZG0vRGRORktSdzkrN2M4YjBFaVFpdm01R3Aw?=
 =?utf-8?B?MFFFRndNVTIwdXgwcEI5NUxSWThtcjVYNWZXZFVKRkNHSU1pWVp6TVFFblNX?=
 =?utf-8?B?TVhzMTA0YlJPMkc0T2ZJUWlFczdTMU5NZmY2azNRbWxHTlVSaDgvbTI4cmRV?=
 =?utf-8?B?SmV4RjZrbmN0blZUblNveWdFaXNzWXJoTFhSSVVPYjZ2dEg0bnRBZGRPMmVh?=
 =?utf-8?B?VFNqc2NIMUlEMGkrd3V5UHJmVFB5UmJtWHZmTlhaRTdhSXA2dUZJZHBhNmxy?=
 =?utf-8?B?QW5GV1NXelpaaXRrTjB2elBxcDRqdVl4amE2Q3p2YlpUeXdyMC9GRU45TTRm?=
 =?utf-8?B?d0M4ODZHcVRETXJVVXllYUdmT1gvb1g5eGRyN252TnpCQTRvOTBRUDliZ3B1?=
 =?utf-8?B?T29oL3ZyVmpqalQrcFM3S2tXQXNkaE9HR2QzMHB3Zlp2M3JGUTNCWVh5WjF0?=
 =?utf-8?B?SUhvV1Q0YkVpSGxRTzNtOXBHeW1ad3EzZWxxd1NrVnlIaElOQTlPVDhxUi9B?=
 =?utf-8?B?NHFLWHJMRktSYm1hNzZ6Y2tTd1FabkxPUno3WjRYTGdyVytQMW4zZXdKb3dR?=
 =?utf-8?B?NENQQ21TRE16ZW1XNWttSmd5RE5KbG9GeS9yTXYyU0VXVVRROWtSRnp5THd3?=
 =?utf-8?B?L0tpTEl3ZitXd0F1WFJlYm9tYW5kdmtwblpFdTN6dS8zTDl6dndCdTc0RXk2?=
 =?utf-8?B?WWVTTHY4NzBMU2FrU1hyc1FDZ21ldENrVjlQb1g1THRZNHhNbUFPQllDZlJq?=
 =?utf-8?B?WWo5cUJRTmtrSUhqVTdTSjJnME9wNkVNanozeldaNDBQSHhZeVg2ZHh0R09F?=
 =?utf-8?B?U2xvQkt4ZjBPMEdnTStWcTZFRFR4V3BOQnQybWpzaG1kK29WN29pZStwQlNV?=
 =?utf-8?B?ekIxVVBjUEV6RGZIQjNYMkRWRk12VkE0cjFZc05FQWV3Z3A2OWdXVEhkb0xq?=
 =?utf-8?B?K2lsUFhUdlVsdUtzS2xxZVM4RzJDWjhvVmxqTDFBMkxVc2k3R3BGdk4rbW5I?=
 =?utf-8?B?OXltNkVYM09DclBvUUJ5ZEtZenAyTWZHYTE0QVFrYWkwR1NlUEdySzlDNmQz?=
 =?utf-8?B?WlRta21SU1J2cXR6ckNJdUlycUdmakxQM29SM0pGcXdKZkt3eHJ0MlRyRjY5?=
 =?utf-8?B?NmJ3eXFrbDBmeFcySTBCVWgxZ3lDNk5aQ3BJQnNvSnByZlMvaDBHTjJCMlRM?=
 =?utf-8?B?V3k0Mk8yMk1QWVk2WnM1SG1mMDhXc1BpQjZ5amlINFBXUjhDVzduY2p5QXQ4?=
 =?utf-8?B?VkpwODZtWTdhUmxKb01jOG5WaXRHRWJPZm56bFFLdTVIZms5YnZhckpSS3d6?=
 =?utf-8?B?YmpFUkZ3RFB6QWxOUlNOU1dZbE1Hd1FSdURodW9kdTJUY3VyOXc3VjQxbzRx?=
 =?utf-8?B?V1ErTGs4ck5XMitYRXBpSkh1S0N1b21FSkJVY05ML1U0WElHSXh4bFZBc09m?=
 =?utf-8?B?elMvV21TeGtqbGFUazR2enlNTis5dDJUalVaTDJPaU9RU3B1cjRpWkswd1h5?=
 =?utf-8?B?Z2ZRSEw5UnVTR0VzT1B6d09jNWtQVUVIY3cwNzFveEtWYVZUVW91VExkTFVP?=
 =?utf-8?B?WkZtcVk3Y3RydlFTeGRwRng1d0NIQ2prcG5TQXQ0Q0s5bWNBeEpWUERPeG1Z?=
 =?utf-8?B?SzVzb2tBeHRuUmQ3amd5NkxmM3VhY3BiUXhHdGJYdjBZVStJeXNaMGZuRGRq?=
 =?utf-8?B?UEo5K1N0d0toaWxuZjB5NXM0QjdnZWVnS2R3WGhMdmRBbjNiUmoxN2NoVEtm?=
 =?utf-8?Q?vrGk7fJyAuH4g9CTiL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4e1520-922a-4e9c-3dd9-08df25131e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 08:06:55.0410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZM96nqxRWGHKuLikJbW+Sr1OuQ1XjsZPTQQctyT6uaH1uytSLb0PoDqnpAkEEwXFusydyG/E7LpMLd/S6+WbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468
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

QU1EIEdlbmVyYWwNCg0KSGkgU3VuaWwsDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCBjb25maXJt
IHdoZXRoZXIgdGhlIGZpcm13YXJlIHZlcnNpb24gY2hlY2sgaW4gdGhpcyBwYXRjaCBpcyBjb3Jy
ZWN0Pw0KDQpGb3IgZXhhbXBsZSwgdGhlIGxhdGVzdCBnZngxMSBNRSBmaXJtd2FyZSB2ZXJzaW9u
IEkgY2FuIHNlZSBpcyAyNTUwLCBidXQgdGhlIHBhdGNoIHJlcXVpcmVzIG1lX2Z3X3ZlcnNpb24g
Pj0gMzA5MC4gVGhhdCdzIHF1aXRlIGEgYmlnIGdhcCwgc28gSSdkIGxpa2UgdG8gbWFrZSBzdXJl
IHRoZXNlIHRocmVzaG9sZHMgYXJlIGludGVuZGVkIGZvciBnZngxMS4NCg0KSSBhbHNvIG5vdGlj
ZWQgdGhhdCB0aGUgbmV3IHZhbHVlcyAoTUUgMzA5MCAvIFBGUCAzMTkwIC8gTUVDIDM0NTApIG1h
dGNoIHRoZSB2ZXJzaW9ucyBpbiBvdXIgcmVjZW50IGdmeDEyIChuYXZpNDgpIENQIGZpcm13YXJl
IGJ1aWxkcy4gQ291bGQgdGhleSBoYXZlIGJlZW4gdGFrZW4gZnJvbSBnZngxMiBieSBtaXN0YWtl
Pw0KDQpJZiB0aGVzZSBudW1iZXJzIGFyZSBjb3JyZWN0LCBjb3VsZCB5b3UgbGV0IG1lIGtub3cg
d2hpY2ggZ2Z4MTEgZmlybXdhcmUgcmVsZWFzZSB0aGV5IGNvcnJlc3BvbmQgdG8/DQoNClRoYW5r
cywNCkplc3NlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFs
ZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAzMSwgMjAyNiAxMToxMyBQTQ0K
PiBUbzogS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+DQo+IENjOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
bg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzNdIGRybS9hbWRncHU6IHVwZGF0ZSB0
aGUgZncgdmVyc2lvbiBmb3IgZ2Z4MTENCj4gdXNlcnF1ZXVlcw0KPg0KPiBQYXRjaGVzIDEgYW5k
IDI6DQo+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
DQo+DQo+IE9uIE1vbiwgQXVnIDMxLCAyMDI2IGF0IDExOjAy4oCvQU0gU3VuaWwgS2hhdHJpIDxz
dW5pbC5raGF0cmlAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBVcGRhdGUgdG8gdGhlIGxh
dGVzdCBzdGFibGUgZncgdmVyc2lvbnMgd2hlcmUgdXNlcnF1ZXVlcyBpcyB3b3JraW5nIGFzDQo+
ID4gaXQgaXMgZXhwZWN0ZWQgd2l0aCBtYWpvciBmaXhlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jIHwgOCArKysrLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPiA+IGluZGV4IGQ3MDRj
ZTMyOGU2ZS4uMmMxNjBlYzlkYzU3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMV8wLmMNCj4gPiBAQCAtMTY1NSwxMCArMTY1NSwxMCBAQCBzdGF0aWMgaW50IGdm
eF92MTFfMF9zd19pbml0KHN0cnVjdA0KPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiA+
ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAyKToNCj4gPiAgICAgICAgIGNhc2UgSVBf
VkVSU0lPTigxMSwgMCwgMyk6DQo+ID4gICAgICAgICAgICAgICAgIGlmICghYWRldi0+Z2Z4LmRp
c2FibGVfdXEgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5tZV9md192ZXJz
aW9uICA+PSAyNDIwICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICBhZGV2LT5nZngucGZwX2Z3
X3ZlcnNpb24gPj0gMjU4MCAmJg0KPiA+IC0gICAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1l
Y19md192ZXJzaW9uID49IDI2NTAgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAgIGFkZXYtPm1l
cy5md192ZXJzaW9uWzBdID49IDEyMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgYWRldi0+
Z2Z4Lm1lX2Z3X3ZlcnNpb24gID49IDMwOTAgJiYNCj4gPiArICAgICAgICAgICAgICAgICAgIGFk
ZXYtPmdmeC5wZnBfZndfdmVyc2lvbiA+PSAzMTkwICYmDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICBhZGV2LT5nZngubWVjX2Z3X3ZlcnNpb24gPj0gMzQ1MCAmJg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgYWRldi0+bWVzLmZ3X3ZlcnNpb25bMF0gPj0gMTQ3KSB7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgYWRldi0+dXNlcnFfZnVuY3NbQU1ER1BVX0hXX0lQX0dGWF0gPQ0KPiAmdXNl
cnFfbWVzX2Z1bmNzOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnVzZXJxX2Z1
bmNzW0FNREdQVV9IV19JUF9DT01QVVRFXSA9DQo+ICZ1c2VycV9tZXNfZnVuY3M7DQo+ID4gICAg
ICAgICAgICAgICAgIH0NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
