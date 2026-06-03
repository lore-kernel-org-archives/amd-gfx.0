Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE78CD6E4A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 06:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C6510F901;
	Wed,  3 Jun 2026 06:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0q1f8OSH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59F010F900
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 06:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwyL63nRALDIQw74fyHgPWfac1t5I34XGb+1w6fxI1bcBuRILd5tLWDn2A++SQ0n5lKysq11AKjiPUIE6DgtTRzid9J14z/RjNaxm3FFOmRdXPrrvgXF7BW9m8XW22zXUDgBLDobSbz5soGGDDH5nSy3vH6kJnVeoUHyDMrDzF/3PR4bJheIYikaL/aoF1zWvIbLGlm7vxLYZ7tUPKz1zs5fPTo0juEni/6uZrYoKnH3v4mj4kXLuOLcVT8UyZWaU1WWEPJY2tKKKEOtPhummLF00pnOFjDhqJxcwUYto0RkhnsRJzf23BhX9Z2kGtJtAVGWp2wI5cSgYsyZ6aPkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/0i9gPY9iQ4oyc7LlI28K44jw7xaq1M70fv7lyew/k=;
 b=U2rHu8ux1ozBEtKKut34WoxTPTRnSaOALHcgCCyJEAxq8Nez7syNmrGKb1E3arRXtTryCERtYFWpBMumfhGcsaT06xqwDANv+IrHFM28C1xna8aS4RTZLh10Z8fi+QXATuyowa00FzimAeelS564gjfI2jyJXK9djfEmL4ncaNGHnIbyF6UQsOqkD5blPtPQuURh2uOTb8VLVrGxkPSgGquzjWWgcBntPefFF0hEuLbWa/A2d0BPhsRL+JDavQemgJ8djyolAQOJcGUV9PIIz45s9Cz1sTCmzPyCSyyuICHxh/ACzpN1EsGagaRHfJKRy0Biwqx+8zSueZqrj801+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/0i9gPY9iQ4oyc7LlI28K44jw7xaq1M70fv7lyew/k=;
 b=0q1f8OSHCyU95ecbl23iUd7elJrijQj4KBi6PKf5aVfmGLZe2tRrQBPx0KiGUIs2z8Q7tMST2yah+CCEK8wpZFTm4i9dF6qVCoYwireNQcWZqhz/iISdnijiobZBJXNafQ/S7WhGXyVwfW+As7+YWmlS2L3fPmg7Zo9gzSQhklw=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:56:35 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:56:35 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Thread-Topic: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Thread-Index: AQHc8pClwY2ypZgtJUyvUNJ6nKyG07YsX9bw
Date: Wed, 3 Jun 2026 06:56:35 +0000
Message-ID: <IA0PR12MB88956AF8D27BFEE63E6E4332F3132@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20260507080137.841442-1-Priya.Hosur@amd.com>
 <20260507080137.841442-2-Priya.Hosur@amd.com>
 <f9d4a3ba-1b9c-4a19-8d34-bed73f1dc5ff@amd.com>
In-Reply-To: <f9d4a3ba-1b9c-4a19-8d34-bed73f1dc5ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-03T06:30:34.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|LV9PR12MB9831:EE_
x-ms-office365-filtering-correlation-id: f4084e13-bb00-45fb-2d65-08dec13d40b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: gZP4yNZUGYzLm0VJyyT31sb3mg+35iMjxvtFbC2kNuw9MFcgxN98Pt7r0Oz8yTB//20fZ3ZGa+laxJHnMNE2L+rEXcqodnWETFBuj5sH+umdm2J6KpfFtI9ibjkE4+RUXzqMXn0qAPZrI/5gzLGdIebkFB0tVQ4DOJE4Z7S9sUN6WBXXR9TIgUahf7Fq9HXCuxYM1yNXZvlJcixceOH9VXgm3PAkK02CpOexkUQhEG3e51yHM5Mt5HDrievmR+ykeBIiwIGpSUwewym5OcRNhgsMX9++sk707qhTFMD+n+ADcpo8LgZXvevxrH25uTisAbgAM4u81rrxfWiIfZAPzL8hHEhKa04zU8O+Coz4ZpcnURDXojIuyilNpDWHMFiGOO0TN7RtB0ALe3UrMm1kB/WSEJhAbZBT6QcmSPucrfqTa6oF01j3jy8AY6DZEveSFNvMXjyfM+ngatTYFWVQErdz9IXau/k4tc1t5NfJCdVZthYnfEDbhP8onDkY2nZIlG6+TprYckxfDn6xUr9bL7NBViYFnUbbPrWgCsUwG6pALBzqHCFIPoj7s0c+XRlA6KIlZLrFUDPlaMpV1ldtbGctylNxT5M4b4DI2r25MPzTgFSbC606I81jCCPkRRszyIk8kF0nx/Jv8G2Dw8kI5sClB00kFtKmPLu7dWRfg3Tuu9ppKljWD+mCpRc2uUO2nfVRTY7tFCw/3YIfPe3R06xxBZ762NwJm1bTx9mwQqbMFECIpKHLxugyf2OdeSO0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUxLYjZMYWtlQU0yWVhhYTdZcVlFL0tnQStFc1dkSWtQQUxoMGM0UmRGSHBV?=
 =?utf-8?B?R2t1QTlYaTluTmRJOXFGWkNKYm9ydkNiSGRHQnZHQ2ZNQ01CWXNabUczc0Rk?=
 =?utf-8?B?NFBMWHVLUGRuUWRqc2lMZXhwMys3Yi83djRra2NXODQyQ2pZeWJDSGgwWE5F?=
 =?utf-8?B?ZWF5c1pEcWoyZTlUQ3NYQW91V0p4ZEdnR2hHNVFpSTQ1T0E3OGY3MUt6RzhX?=
 =?utf-8?B?VHBCLzVuTlV6K1dPM0kzaXBQOTFVajFWaVlGa09ubUEyUHZadm1hbWh1VjBW?=
 =?utf-8?B?dzJ6TGRUcUdnR2xLS2ZOa1NGRUZBNFRFeWkvQUhNLys2ME5ERm9OWUZaSHpk?=
 =?utf-8?B?Y0NHNUVWTFo0dEpScnlIRW5wTFlteVY4V3NnejFQQ0tYOUwwT1dMVFFzVzZv?=
 =?utf-8?B?bktwamRXU2FTbk5CbnFlY2tQSGlPTk9MZjRueVpTZ09yYzM5bGFaUURZazdx?=
 =?utf-8?B?L01ndFk5aDJYVHE4dlkwY1h5QWlkQ2tTNmQ3cVc2TGN3dVdTWTdyaVFRU3V0?=
 =?utf-8?B?MXBTRkZmMFA5OElwQUd6MlE1Y1JqOTYrUEZKSWVpd1Q1SE5mQ3NxYUpYaUYv?=
 =?utf-8?B?ZzYyK3hqQmRGYmN1dWs3enBzcWdCM3ZQOVp0bnMwdE9GMnVHZGJJbkpMdWpt?=
 =?utf-8?B?V1hiZmhqcXpaQjhuSS8wMWl3eGY4U0pnYnNrM1Z2ekd6UEFmQjFXNDZ1QWcz?=
 =?utf-8?B?VmhZdXVieFgvWEx6MTBrcW1HY0cvVXA5eG1vK0hzakR3WGpETUZVdldWVGpo?=
 =?utf-8?B?c1IyZFJpWFVjQWM4eTY3TmZJRDBlWEVkNWxyaFZYZkxUWTFCQ1lVOTVSaWZT?=
 =?utf-8?B?SzR1V3BsamxUTks4ZkhibzUzbktxbjFXT0ZTY05YOHE0Tnc3YjN3WkY5ckx0?=
 =?utf-8?B?L01TbnA5TkZBWjNDM3F2a2wwWFkvRXBrcFJKODJsVEdEUlJwNGNHVU5ERVdt?=
 =?utf-8?B?S2R3ekhOZWFiV3lDUmJoVVJ3MkxLNTJNRHRTWVpmMGx5d1dDZ092YkdyQU5k?=
 =?utf-8?B?WVNMU251N2RycnRqSi9DbzdjbTNEN0dEdUFORGU2SEp2NHBFaVlsSk1FcGY1?=
 =?utf-8?B?OGFoMDg3ek9QT1FsOE1KK0xJTkpOUVA3WFUwU3cxZ2ZFYklyVWZFekRFQ0R2?=
 =?utf-8?B?MFBud24vNHdTdmprMUdFWTdnTE9OV0VrUGVMbEE5ay9HZkdiZUZwVnRVT3dG?=
 =?utf-8?B?K3JaYis4S2NKSE9wU2NFUXdZRjQ0eHdIMTMyK0lrQjFRczBwa3pHZWdlbXhS?=
 =?utf-8?B?K0hvcTJBOFRjVjVqZDJNbE9HZ0daOE1rSnFUdWMxcDJuamQxS1hJZVgrM05M?=
 =?utf-8?B?dm43UkxHT0dic1BUVFFUTTg5MHBGQTI3UncrM0xCTWcrUDJWa0RtcEdOdExR?=
 =?utf-8?B?QzJnYTRvTmJpQUlzcXZwVWtXSDFtVENjS29pRytyRnRGdHdpRGtJWVFicUdy?=
 =?utf-8?B?aURmV2ppTS9uMXpudEdTQVJGOEFHMGRmM1YrQWxOUjFJaWNvMCtYejZQcDlq?=
 =?utf-8?B?d2FWQitnREhiVVJqMVI5YmxoeHdKRG5wdlA0d1l6cEdhZGxYaXFIOUI3WVF4?=
 =?utf-8?B?L0VrODNUblFlL0s3UnBxUGZ6VVhUZy9raGltTzlranR5VHl5MlUzdit2Z0JJ?=
 =?utf-8?B?MVZIVDZIQmdRVnd5UnZ6ZG0raFVvNUNlNCtRaktOeVRyUVF0MGNvbGcvUmlW?=
 =?utf-8?B?eERDTkdKN3ViaURQNTFFU3ZVbHVPNy9nQmg2eWZEL21CeUtTSUtYZ0Z5Snk3?=
 =?utf-8?B?QlVycVhzak1TYVZFYitFMWhqbVhLbnJNb3ZVZldHa242K3NQdmVid2JOVis1?=
 =?utf-8?B?MjRtVFFLSDhVdGJ6STZSZU8yckhKLzBsTXhndXMyNjVzUWl1T3RKbkhYeG9F?=
 =?utf-8?B?Ukc5QmY3cHlod213SFFzdVByNytqVE1jY1V5cEpIeVUyZTVvNzlWUUFTTTJk?=
 =?utf-8?B?VDBuUXpGZ1g5UlJndml6Q1FWOFl5cGFrbXd5a045Zk5TQ0xVRTdCaG9uamFB?=
 =?utf-8?B?dGJiYTVoMTNIQ29MeStNY05nTFYzYWJhRkJ1Sm04L1NrbXg1TUdMUzI0ZDBF?=
 =?utf-8?B?eDNJblJYbCtkNmpBcElubXZOdTNlbTJHalRQWUZVVy9RVGpUb3c4MElBT0Yw?=
 =?utf-8?B?NTROQVVnUnl2RENPWlRTdkgrK1JtN0JNVlNPaVUzK3JKWktiMGdwbVVYRlJI?=
 =?utf-8?B?SW1aUTk3MlFjZDZGekFUcjdqMW45QWprRUNVTE91MlhxUFJXWUhVWmdnWk1j?=
 =?utf-8?B?R3pxYllUM0orcEFuTFl2a1RuSjJwN0ZVaHFibmV4Qnc2eXFjMVhuc3RIY0FR?=
 =?utf-8?Q?Py5PrhCDO8fqG/wL/x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4084e13-bb00-45fb-2d65-08dec13d40b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:56:35.5504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScznZ+qUzivD5tG1+VPoO6LECRT9Kr+0SA6nzsdQdMueHFIFqXGepFZpsQf4ALsKhd4wfeLLmMUUtPn7KeAJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
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

QU1EIEdlbmVyYWwNCg0KSGkgTGlqbywNCg0KR29vZCBwb2ludC4gU29mdE1pbiB2YXJpYW50cyBl
eGlzdCBmb3IgYWxsIGRvbWFpbnMgaW4gdGhlIFNNVSB2MTQgbWVzc2FnZSB0YWJsZSAoU2V0U29m
dE1pbkZjbGssIFNldFNvZnRNaW5Tb2NjbGtCeUZyZXEsIFNldFNvZnRNaW5WY24wKS4gVGhlIHRo
ZXJtYWwgaXNzdWUgSSBoaXQgd2FzIG9uIGdmeGNsayBzcGVjaWZpY2FsbHksIGJ1dCBmb3IgY29u
c2lzdGVuY3kgSSdsbCBzZW5kIGEgdjIgdGhhdCBzd2l0Y2hlcyBhbGwgY2xvY2sgZG9tYWlucyB0
byBTb2Z0TWluIHNvIFBNRlcgcmV0YWlucyB0aHJvdHRsaW5nIGF1dGhvcml0eSBhY3Jvc3MgdGhl
IGJvYXJkLiBJU1AgY2xvY2tzIChpc3BpY2xrLCBpc3B4Y2xrKSB3aWxsIHN0YXkgb24gSGFyZE1p
biBhcyBubyBTb2Z0TWluIG1lc3NhZ2UgdmFyaWFudHMgZXhpc3QgZm9yIHRoZW0uDQoNClRoYW5r
cyBhbmQgUmVnYXJkcywNClByaXlhIEhvc3VyDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogVHVlc2RheSwg
SnVuZSAyLCAyMDI2IDY6MzcgUE0NClRvOiBIb3N1ciwgUHJpeWEgPFByaXlhLkhvc3VyQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4NCkNjOiBWaXNod2FrYXJtYSwgUHJhdGlrIDxQcmF0aWsuVmlzaHdha2Fy
bWFAYW1kLmNvbT47IEdvcGFsYWtyaXNobmFuLCBWZWVyYWJhZGhyYW4gKFZlZXJhKSA8VmVlcmFi
YWRocmFuLkdvcGFsYWtyaXNobmFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0g
ZHJtL2FtZC9wbTogc211X3YxNF8wXzA6IHVzZSBTb2Z0TWluIGZvciBnZnhjbGsgaW4gc2V0X3Nv
ZnRfZnJlcV9saW1pdGVkX3JhbmdlDQoNCg0KDQpPbiAwNy1NYXktMjYgMTozMSBQTSwgUHJpeWEg
SG9zdXIgd3JvdGU6DQo+IEluIHNtdV92MTRfMF8wX3NldF9zb2Z0X2ZyZXFfbGltaXRlZF9yYW5n
ZSgpLCB0aGUgZ2Z4Y2xrIGZsb29yIGlzDQo+IHByb2dyYW1tZWQgdmlhIFNldEhhcmRNaW5HZnhD
bGsgdG9nZXRoZXIgd2l0aCBTZXRTb2Z0TWF4R2Z4Q2xrLiBVbmRlcg0KPiBwb3dlcl9kcG1fZm9y
Y2VfcGVyZm9ybWFuY2VfbGV2ZWw9aGlnaCB0aGlzIHBpbnMgSGFyZE1pbiB0byBwZWFrIGdmeGNs
ay4NCj4NCj4gSW4gUE1GVyBhcmJpdHJhdGlvbiBIYXJkTWluIGhhcyBoaWdoZXIgcHJpb3JpdHkg
dGhhbiBTb2Z0TWF4LCBzbyB0aGUNCj4gZmlybXdhcmUgdGhlcm1hbC9QUFQgdGhyb3R0bGVyIGNh
bm5vdCBjbGFtcCBnZnhjbGsgdmlhIFNvZnRNYXggb25jZQ0KPiBIYXJkTWluIGlzIHNldCB0byBw
ZWFrLiBSZXBsYWNlIFNldEhhcmRNaW5HZnhDbGsgd2l0aCBTZXRTb2Z0TWluR2Z4Y2xrDQo+IHNv
IHRoZSBkcml2ZXIgc3RpbGwgcmVxdWVzdHMgcGVhayBwZXJmb3JtYW5jZSBidXQgdGhlIGZpcm13
YXJlDQo+IHRocm90dGxlciByZXRhaW5zIHRoZSBhYmlsaXR5IHRvIGNsYW1wIGdmeGNsayB1bmRl
ciB0aGVybWFsL1BQVA0KPiBwcmVzc3VyZS4gU29mdE1heCBoYW5kbGluZyBpcyB1bmNoYW5nZWQg
YW5kIG5vIG90aGVyIGNsb2NrIGRvbWFpbnMgYXJlDQo+IGFmZmVjdGVkLg0KPg0KDQpUaG91Z2gg
c2h1dGRvd24gaXMgY29udHJvbGxlZCB3aXRoIGdmeCBjbG9jayBhZGp1c3RtZW50LCBpcyBpdCBl
eHBlY3RlZCB0byBzZXQgaGFyZG1pbiBmb3Igb3RoZXIgY2xvY2sgZG9tYWlucyBmb3IgcGVyZiBs
ZXZlbHMgb3Igc2hvdWxkIHRoZXkgYWxsIHNldCBzb2Z0bWluIG9ubHk/DQoNClRoYW5rcywNCkxp
am8NCj4gU2lnbmVkLW9mZi1ieTogUHJpeWEgSG9zdXIgPFByaXlhLkhvc3VyQGFtZC5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8wXzBf
cHB0LmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTQvc211X3YxNF8wXzBfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+IGluZGV4IGM3NmIxZjA3ODg1ZS4uMmZlMDA2ZGU5
MjdhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3Nt
dV92MTRfMF8wX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTQvc211X3YxNF8wXzBfcHB0LmMNCj4gQEAgLTEyMzEsNyArMTIzMSw4IEBAIHN0YXRpYyBpbnQg
c211X3YxNF8wXzBfc2V0X3NvZnRfZnJlcV9saW1pdGVkX3JhbmdlKHN0cnVjdCBzbXVfY29udGV4
dCAqc211LA0KPiAgICAgICBzd2l0Y2ggKGNsa190eXBlKSB7DQo+ICAgICAgIGNhc2UgU01VX0dG
WENMSzoNCj4gICAgICAgY2FzZSBTTVVfU0NMSzoNCj4gLSAgICAgICAgICAgICBtc2dfc2V0X21p
biA9IFNNVV9NU0dfU2V0SGFyZE1pbkdmeENsazsNCj4gKyAgICAgICAgICAgICAvKiBTb2Z0TWlu
IGxldHMgUE1GVyB0aHJvdHRsZSBnZnhjbGs7IEhhcmRNaW4gd291bGQgb3ZlcnJpZGUgU29mdE1h
eC4gKi8NCj4gKyAgICAgICAgICAgICBtc2dfc2V0X21pbiA9IFNNVV9NU0dfU2V0U29mdE1pbkdm
eGNsazsNCj4gICAgICAgICAgICAgICBtc2dfc2V0X21heCA9IFNNVV9NU0dfU2V0U29mdE1heEdm
eENsazsNCj4gICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgY2FzZSBTTVVfRkNMSzoNCg0K
