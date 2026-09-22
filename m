Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C9BC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F142E10ED8C;
	Tue, 22 Sep 2026 15:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxzfi2OO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2523D10ED8C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFJW/Un0RwoiSNAy4aSxilowb2inghJeX6NsAW2SRs3EzW4NPJxnup/qXACQpoUSyqGSxQPe63SpoAGzkE8tiWw2RVZfBZz86V+MpOCOIToOtSN+vs1UXye9e9KLJ+tRoUm3yMDp8I8Ixtz2p2JkaGtQHD0XG4FoEQtViYpToskStJx0Dt+wV46SL0/h7/qIPcbda8OlcmhTtK0EZwLX2zt+OOUt3LqKod42yOOCFVZ+hcE5J1NVcOK6ROyVrhdLv9lE0eQzJgb/tgenYz5WDueJT1EUH/ZBpw/H6LIHs8zJulHxGGMBhiY5IwA0qkT4C3n0c1JUObjwUQT+TGqqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMfiSEc61l7BGwMm4An0gpbUwzHQ0e9tC7zq7qa4HKM=;
 b=xAVB9w3WteoGCI404lDcTFqouZeAKl0VP6Vc838NCrxzSwXayJGO6ZbY8fuEDOhfmII9JJUO+gDZXk8o2RjuVXnZ9G/S6r1JIG8cEkWbq2pwSuS6pqSadXmxmP4vljXJjft5SlxhKoZ2juwydZ1DzRsHElUIRgv6XS+4+2ccBn6Qr6bcw6koHa2Y8nCDgRuJWA6KAEGS6J0qz8FusbjtM9P/Z8sPI8FX24aiUQ9CEQG1k3/WQNuoOv30lakiN4DY90n86rjCwaTCh6lOo5dpsUOZswVgrd6Hhgp6ynscmiVpZ8zi1S/uWn7V2KLfqX2oIGSUfeHo2qwbrA/wEkp5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMfiSEc61l7BGwMm4An0gpbUwzHQ0e9tC7zq7qa4HKM=;
 b=uxzfi2OO32vCFRqGeKkv0id//vkO230wXOZj2SQDnp0XORuI3crYWl0iRVGymJvxN5qv4mNC7SAkdnkhyDkR47UykFeVVs/6j0vLkPr5tXMRF3ITdjm+Ad5YeuY4G8btJqqmy+8caC3nGA7w+OVavwk7RIE7kKH9nPmTX1I7S+U=
Received: from DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21)
 by DS4PR12MB634945.namprd12.prod.outlook.com (2603:10b6:8:514::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:26:03 +0000
Received: from DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce]) by DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 15:26:03 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: don't widen the validate GPU set past one
 page owner
Thread-Topic: [PATCH] drm/amdkfd: don't widen the validate GPU set past one
 page owner
Thread-Index: AQHdRSK/4T+kZj/BlEeD5uuiGsAm1rbTFvxQgAaB2ICAASn7EA==
Date: Tue, 22 Sep 2026 15:26:02 +0000
Message-ID: <DS0PR12MB7536D63AB9B3F0E9F939B86AF5832@DS0PR12MB7536.namprd12.prod.outlook.com>
References: <20260915145833.601947-1-andrew.martin@amd.com>
 <DS0PR12MB75369C49F33D3D517826ED21F5B82@DS0PR12MB7536.namprd12.prod.outlook.com>
 <CADnq5_PG1xYL_LvVgtjA=4-O_xqGW3sA5xVmb_D0XO+CDUFwJQ@mail.gmail.com>
In-Reply-To: <CADnq5_PG1xYL_LvVgtjA=4-O_xqGW3sA5xVmb_D0XO+CDUFwJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-22T15:25:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7536:EE_|DS4PR12MB634945:EE_
x-ms-office365-filtering-correlation-id: bb29083b-d540-442b-5a94-08df18bdcfe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|5023799004|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: djT9ue9mh9tFZThbpWhEOIV5J+g5f+OFSRsw6AUykFI/z6hj60paaTgKKzhpS9fuwSDolbTEvch1usPWaB8Aaycvd5YqWYCt+sG0mu7bFKM7vydKBL6H1bJT7feuySpdzkq+H+h/bqDRHeBDNawyYRQ7107MGqAH2EyWiO+T8J6jQRY3+JyhMFnNs2o96ZMnvtcS5Ebaeq3p3wCNhH0R6r52jRtWBs5Jm/p+Vx1OKYKBTwZwq3dDVehj7Q799ZCurXOh47/xJ0LALbf5hA32wPTZIK5F62DJcR4fJOE0tQMPq/C1l04vTPcIQGbjFA7eyUC4ZdKnL1ejpdWXPGj6TIci3B2+s0NrMI0U0dnl00jI2F6+IysKQ0wtHFwoH97hlXq4dnrC30e1NWjSpiiXCV9ChF05TJ80ZDiZAMbOdD7Pku+u/0Yt2k2OhI/zAsLM3SBA5bAD73D9Uhe5l9YbmuxwXO71ITj0I17wz2aKWrr/NJ3dW9OQ89r8LJ8bQ4xVg5vo9+RyybUirIv2MOjIILJXNX/1paCRFtS5NfcflT5Gq0nbU8kAqmKKgxwtpzFuEEh27oDzC0Gv7I+BHQmwEm+y/WD7mLXR/IZzPmY34GjJ7/s7Itm2zti0dZz/WGbMjR6RH+pD/C/l409Olk7C8YJgnGOmdOEvQUpk0c8JLkrlYgFXKeZSRjxLbCtLauS7g3xVgn/gMzXWFm+tJOVd0OEa5zfHJIRsXWyTp3wvOYA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3c2SkV2cmJ5OU9hVzBjNnIwcExDSHpKMnR2SytQTUN5Mm1uOXIybm5DR2Jw?=
 =?utf-8?B?OEpvc3k3MFBwYzFDU0R1Ui9VNHpRWFB1K2VYT1dnbnVmV1JqWktxQWZIWjJk?=
 =?utf-8?B?NTF4Uy96Yjhab3hyMFA1aEowNFljMWZyTzAxcGYzMEVxUm10U1M2QUV1NGV1?=
 =?utf-8?B?L0ozWmdMMzFtbjZlWDA0cUtldHRUZTM5Mis4NVlRVGVpMEdXNDJ1Q3VBdmhT?=
 =?utf-8?B?Nk1UUUdRZFI3U2lqaDVkeElhN1g1cWtEd09DWFpnWmVpRzNPZ0Z6WkZ5MS9r?=
 =?utf-8?B?TzQ3R0pUbjlRVVdMMm1TYy8rMHdCclo5M0JXM2tmTlFsc0tKeWtadVh2V1ZY?=
 =?utf-8?B?aE9mMDdkb0E2MlBnUGJnTE94WGFlYWYvb3ZUL1dFcG9zV0FIVGZnanZLQWRl?=
 =?utf-8?B?eWdnSEg1WlVHdFN0dDNIOER1YlNBN0FpajJvZWx1YmF4YUcxVkwvTW1MeElW?=
 =?utf-8?B?b0JSNTVNQzNFL2xqd0VVSERrcHJPVHR6STZWR2NLVVlLU1hoRXQwbXNUckdm?=
 =?utf-8?B?QzZ6eHVwOVpFWDJmS3lOeXAvRElyZ2RPYmhyKytTTlY5TXNjbDY1NlJrUk5a?=
 =?utf-8?B?Qmp5QzVacTZYVmpodWd5N0FWUE9vWmNRZExTeE5xeWtKVHBkREVIVk82Nzcv?=
 =?utf-8?B?Z3Y3Y29BK3QySi8rTTFOYy9WK1EvWFpTTlZyK3dDem1EUDk5T29zTnJEdnBt?=
 =?utf-8?B?QlF6djk0UFF1UkxJRm10dWdjOU5qQldoSzRsTHhNNEs5aUR2Nm5OaGlob2tm?=
 =?utf-8?B?cHJPQ1NTM3RHbTJsVDhZNFVUTUdXWVJESWhjV3BHOFdBVE5CcndZN0ovWmtM?=
 =?utf-8?B?cmUxd0wwVnpaYUNRKzk5d1BjOURsb3hwbU1ySUYvaG1XOUdjYVVKQ2J2a2xW?=
 =?utf-8?B?SHp5Z2t3R2ZFdng3L1BVdkpoK0xVZmpFeW8ybjFrVk4za0gxWHl3amNWTGMw?=
 =?utf-8?B?MGFMTWFleGFpZUorcmQ1WmNLTjA4d1JWWXZaWElJVnFScGtSaGxyWlhSMkZP?=
 =?utf-8?B?Wm8rSEZEdC91bEpoNk1MZWtBNU5sSFJlZTB6d2tPbnVyRmVVV2dSU1ZSN1ZE?=
 =?utf-8?B?ZGdtUm5NVElXMVUxa1Q4alEzMW81SG1wYy8vRW1vRXBSTUpZS1NxVU5kR0c3?=
 =?utf-8?B?OW5IWks4aGpSdG4zRU82VVhZQ0twbkdFSDdyN1FESE9nemVheHBHbnRYWGQw?=
 =?utf-8?B?bFVvVXlXM0hhTUcxMm11MXJvMUlNdzhNU0tHVTkvc1ZQWnZxRG9nc1g4dG5Z?=
 =?utf-8?B?TUticTNpNllraXg2czRPWTJmY2N3OHhWWmgreWs4cVR2NVByQVRRRHV2K2Iv?=
 =?utf-8?B?YkVqeHY4TUppR1lUTkl5TVRMWFh3V1JLbDd0cUNVVm9naGFENVZZa2toNTJT?=
 =?utf-8?B?YjJkY0tRVUJhcDJRVVR2TUsvU28xMUhtbHgxclBkdFc3dkFNZkJ0N3ExMzhS?=
 =?utf-8?B?ZHJnS1dIVjVuT1pzcjIwa3dldzNHZ2dtZk1OZU1sbFA3bmwyaUMwQlNhZHFZ?=
 =?utf-8?B?UjQxSzJkcnpiNmhQT0pXUklXSWtCZmR1MEN4Y0Z6RFJRZGVFenNTRkorWkZT?=
 =?utf-8?B?SUxsS05RdTJ6ZG8xL2tJL3drRFVoVlRjcmRRQmx0ZlRoZnh3S2ltMG5UOHBV?=
 =?utf-8?B?c2I0WlR5bmhGUnpoMlJuY3ZNQldLakoyMnZHeFN5SDZiUkVEdHVsSFFXaDQ1?=
 =?utf-8?B?WDlJVFRVcVo5cnZ6dlduVEVic1F2UkF0eHQzUzJzbEo1N1k2b1pnSXAzV3Zz?=
 =?utf-8?B?SHoxM1FoTHV4U3Z4dnFSaTlHTE03L3dzM1hzN2tjVCtPc1JvODNDTEZKdEZv?=
 =?utf-8?B?bEtvVHpTVlFYSXd1UzNFcHRTZk5ybWQxUVFPYUVSSjhxK1NIcERsYzNacEN1?=
 =?utf-8?B?SnJqZDRWSElWVGFlMVpDM3B2NUltdUk0NnNsSmllQi9KMlRvZ3VDU0UrUXhl?=
 =?utf-8?B?dEsyMFBzWEZrMng5dUtMNjFVblh5WW9OREJEWEZUVXd2NVFqc1hnQW1Md21h?=
 =?utf-8?B?dHZwUUNybXdYczlUVlliaS9xcjVocEFYeTAyWXp5QUV1VG5hc09GNW5oY1J1?=
 =?utf-8?B?STIwZU1TUjZmdHlWVjVtVzJlc2R6Mi83L2hCOFlxc2xLUzNabjNEOTlWa1J6?=
 =?utf-8?B?b2V2SXdrY3d0MjZLQnZBNE45RVY1ejNlU1Qxd2FJaXZUamFyT1RFajd4Y3Vp?=
 =?utf-8?B?UzI4WUpHckpTb1hJZUpJdmlEaXU2b1ppbVovRHV5ektJU205eHBoUG95QWVy?=
 =?utf-8?B?bW82OURrYkhGV05zSUcvWTJpbnNaRGtFRWdPa1dCZ09Cem45M2FhK0ZMT1RJ?=
 =?utf-8?Q?ITbttFS0Dv1UbHzZS/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7536.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb29083b-d540-442b-5a94-08df18bdcfe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:26:02.5466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yv/oLvv/w4H+EPpJL/JJFBA0FI+dRJ9Pe1G3QPx/Aqb6d2Vmmh9Iml0Po0jh/x/NJnJamQKnId8INUo5+0Ibw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB634945
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

QU1EIEdlbmVyYWwNCg0KVGhhbmtzIEFsZXghDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDIxLCAyMDI2IDU6MzkgUE0NCj4gVG86IE1hcnRpbiwgQW5kcmV3
IDxBbmRyZXcuTWFydGluQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1ka2ZkOiBkb24ndCB3aWRlbiB0aGUgdmFsaWRhdGUgR1BVIHNldCBwYXN0
IG9uZQ0KPiBwYWdlIG93bmVyDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVk
IGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4g
T24gVGh1LCBTZXAgMTcsIDIwMjYgYXQgMjoyNuKAr1BNIE1hcnRpbiwgQW5kcmV3IDxBbmRyZXcu
TWFydGluQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQU1EIEdlbmVyYWwNCj4gPg0KPiA+
IEdyZWV0aW5ncywgc2VuZGluZyBwZWFjZQ0KPiA+DQo+ID4gSnVzdCBhIFBpbmcgdG8gaGF2ZSBh
IGxvb2sgYXQgdGhpcy4NCj4NCj4gTG9va3MgcmVhc29uYWJsZSB0byBtZS4NCj4gQWNrZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4NCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hcnRpbiwgQW5kcmV3IDxB
bmRyZXcuTWFydGluQGFtZC5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUs
IDIwMjYgMTA6NTkgQU0NCj4gPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiA+ID4gQ2M6IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IE1hcnRpbiwgQW5k
cmV3DQo+ID4gPiA8QW5kcmV3Lk1hcnRpbkBhbWQuY29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1ka2ZkOiBkb24ndCB3aWRlbiB0aGUgdmFsaWRhdGUgR1BVIHNldCBwYXN0DQo+ID4g
PiBvbmUgcGFnZSBvd25lcg0KPiA+ID4gSW1wb3J0YW5jZTogSGlnaA0KPiA+ID4NCj4gPiA+IENv
bW1pdCA2YjI5Njk4MzFmN2UgKCJkcm0vYW1ka2ZkOiBVbm1hcCBzdm0gcmFuZ2UgZnJvbSBHUFUg
c2V0IHRvDQo+ID4gPiBuby1hY2Nlc3MiKSBtYWRlIHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFw
KCkgT1IgYml0bWFwX2FjY2VzcyBpbnRvDQo+ID4gPiBjdHgtPmJpdG1hcCB1bmNvbmRpdGlvbmFs
bHkgZm9yIGEgcmFuZ2UgY2FycnlpbmcNCj4gPiA+IEtGRF9JT0NUTF9TVk1fRkxBR19HUFVfQUxX
QVlTX01BUFBFRC4gIFByZXZpb3VzbHkgdGhhdCBvbmx5DQo+IGhhcHBlbmVkDQo+ID4gPiB3aGVu
DQo+ID4gPiBjdHgtPmJpdG1hcCB3YXMgc3RpbGwgZW1wdHk6DQo+ID4gPg0KPiA+ID4gICAgICAg
aWYgKGJpdG1hcF9lbXB0eShjdHgtPmJpdG1hcCwgTUFYX0dQVV9JTlNUQU5DRSkpIHsNCj4gPiA+
ICAgICAgICAgICAgICAgaWYgKHByYW5nZS0+bWFwcGVkX3RvX2dwdSB8fA0KPiA+ID4gICAgICAg
ICAgICAgICAgICAgcHJhbmdlLT5mbGFncyAmDQo+ID4gPiBLRkRfSU9DVExfU1ZNX0ZMQUdfR1BV
X0FMV0FZU19NQVBQRUQpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgYml0bWFwX2NvcHko
Y3R4LT5iaXRtYXAsIHByYW5nZS0+Yml0bWFwX2FjY2VzcywNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBNQVhfR1BVX0lOU1RBTkNFKTsNCj4gPiA+ICAgICAgIH0NCj4g
PiA+DQo+ID4gPiBUaGUgYmxvY2sganVzdCBhYm92ZSBhbHJlYWR5IHNldHMgdGhlIGJpdCBmb3Ig
cHJhbmdlLT5hY3R1YWxfbG9jDQo+ID4gPiB3aGVuIHRoZSByYW5nZSBoYXMgYmVlbiBtaWdyYXRl
ZCB0byBWUkFNLCBzbyB1bmRlciB0aGUgb2xkIGNvZGUNCj4gPiA+IGN0eC0+Yml0bWFwIHdhcyBs
ZWZ0IGhvbGRpbmcgdGhhdCBzaW5nbGUgR1BVIGFuZCB0aGUgT1Igd2FzIHNraXBwZWQuDQo+ID4g
PiBXaXRob3V0IHRoZSBndWFyZCBpdCBub3cgYWxzbyBwaWNrcyB1cCBldmVyeSBvdGhlciBHUFUg
d2l0aCB0aGUgQUNDRVNTDQo+IGF0dHJpYnV0ZS4NCj4gPiA+DQo+ID4gPiBUaGF0IG1hdHRlcnMg
YmVjYXVzZSBjdHgtPmJpdG1hcCBpcyBub3Qgb25seSB0aGUgc2V0IG9mIEdQVXMgdG8gbWFwLg0K
PiA+ID4gSXQgYWxzbyBzZWxlY3RzIHRoZSBITU0gb3duZXI6IG93bmVyIGlzIHRha2VuIGZyb20g
dGhlIGZpcnN0IHNldCBiaXQNCj4gPiA+IGFuZCByZXNldCB0byBOVUxMIGFzIHNvb24gYXMgdHdv
IHNldCBiaXRzIGRpc2FncmVlLiAgT24gYSB0d28gR1BVDQo+ID4gPiBzeXN0ZW0gd2l0aCBBQ0NF
U1Mgb24gYm90aCwgb3duZXIgYmVjb21lcyBOVUxMLCBhbmQNCj4gPiA+IGFtZGdwdV9obW1fcmFu
Z2VfZ2V0X3BhZ2VzKCkgdGhlbiBubyBsb25nZXIgcmVjb2duaXNlcyB0aGUgcHJvY2VzcydzDQo+
ID4gPiBvd24gZGV2aWNlLXByaXZhdGUgcGFnZXMuICBITU0gY2FsbHMgbWlncmF0ZV90b19yYW0g
b24gZWFjaCBvZiB0aGVtLA0KPiA+ID4gc3ZtX21pZ3JhdGVfdG9fcmFtKCkgc2Vlcw0KPiA+ID4g
cC0+c3Ztcy5mYXVsdGluZ190YXNrID09IGN1cnJlbnQgYW5kIHJldHVybnMgMCB3aXRob3V0IG1p
Z3JhdGluZywNCj4gPiA+IHAtPmFuZA0KPiA+ID4gaG1tX3JhbmdlX2ZhdWx0KCkgcmV0cmllcyB0
aGUgc2FtZSBwYWdlIGZvcmV2ZXIuDQo+ID4gPg0KPiA+ID4gV2hpY2ggR1BVcyBkaXNhZ3JlZSBk
ZXBlbmRzIG9uIHRoZSBpbnRlcmNvbm5lY3QuDQo+ID4gPiBTVk1fQURFVl9QR01BUF9PV05FUigp
IGlzIHRoZSBYR01JIGhpdmUgd2hlbiB0aGUgZGV2aWNlIGhhcyBvbmUNCj4gYW5kDQo+ID4gPiB0
aGUgYWRldiBvdGhlcndpc2UsIHNvIEdQVXMgc2hhcmluZyBhIGhpdmUgYWxzbyBzaGFyZSBhbiBv
d25lciBhbmQNCj4gPiA+IG5ldmVyIHRyaXAgdGhpcy4gIEl0IHRha2VzIHR3byBvciBtb3JlIEdQ
VXMgd2l0aCBBQ0NFU1MgdGhhdCBhcmUgbm90DQo+ID4gPiBpbiBhIGNvbW1vbiBoaXZlLCB3aGlj
aCBpcyB3aHkgdGhpcyBvbmx5IHNob3dzIHVwIG9uIG11bHRpLUdQVQ0KPiA+ID4gbWFjaGluZXMg
d2l0aCBubyBYR01JIGxpbmsgYmV0d2VlbiB0aGUgY2FyZHMuDQo+ID4gPg0KPiA+ID4gT24gYSAy
eCBJbnN0aW5jdCBNSTM1MFAgKGdmeDk1MCkgdGhpcyBoYW5ncw0KPiA+ID4NCj4gPiA+ICAgSFNB
X1hOQUNLPTEgaGlwYmxhc2x0LXRlc3QgXA0KPiA+ID4NCj4gPiA+IC0tZ3Rlc3RfZmlsdGVyPWF1
eF9oYW5kbGVfdGVzdC5zZXRfc21fY291bnRfdGFyZ2V0X2RlZmF1bHRfaXNfemVybw0KPiA+ID4N
Cj4gPiA+IFRoZSBhcHBsaWNhdGlvbiBuZXZlciBjb21wbGV0ZXMgYW5kIGJ1cm5zIDEwMCUgb2Yg
YSBDUFUgaW4gdGhlIGtlcm5lbC4NCj4gPiA+IC9wcm9jLzxwaWQ+L3N0YXQgc2hvd3MgdXRpbWUg
ZnJvemVuIHdoaWxlIHN0aW1lIGNsaW1icyBhbmQgbWluZmx0DQo+ID4gPiBhZHZhbmNlcyBhdCBy
b3VnaGx5IDEyIG1pbGxpb24gZmF1bHRzIHBlciBzZWNvbmQsIHJlYWNoaW5nIGJpbGxpb25zOw0K
PiA+ID4gbWFqZmx0IHN0YXlzIGF0IDAgYW5kIHRoZSBHUFUgc2l0cyBhdCAwJSBidXN5LiAgcGVy
ZiBvbiB0aGUgc3R1Y2sNCj4gPiA+IHRhc2sgaXMgMjQlIHN2bV9taWdyYXRlX3RvX3JhbSwgMjMl
IF9faGFuZGxlX21tX2ZhdWx0LCA1JQ0KPiA+ID4gZG9fc3dhcF9wYWdlLiAgVGhlIHByb2Nlc3Mg
Y2Fubm90IGJlIGtpbGxlZCBhbmQgdGhlIG1hY2hpbmUgaGFzIHRvIGJlDQo+IHJlYm9vdGVkLg0K
PiA+ID4NCj4gPiA+IFJlc3RvcmUgdGhlIGJpdG1hcF9lbXB0eSgpIGd1YXJkLiAgVGhlIHJlc3Qg
b2YgdGhhdCBjb21taXQgaXMga2VwdDoNCj4gPiA+IHRoZSBiaXRtYXBfbWFwcGVkIHRyYWNraW5n
LCBiaXRtYXBfbmVlZHNfdW5tYXAsIG1hcHBpbmdfZG9uZSBhbmQNCj4gdGhlDQo+ID4gPiB1bm1h
cCBvZiByYW5nZXMgc2V0IHRvIG5vLWFjY2VzcyBhcmUgYWxsIHVuYWZmZWN0ZWQsIGFuZA0KPiA+
ID4gYml0bWFwX21hcHBlZCBpcyBzdGlsbCBPUmVkIGluIGF0IHRoZSB0b3Agb2YgdGhlIGJyYW5j
aCwgc28gYSByYW5nZQ0KPiA+ID4gYWxyZWFkeSBtYXBwZWQgb24gYSBHUFUgc3RpbGwgaGFzIGl0
cyBtYXBwaW5nIHVwZGF0ZWQgdGhlcmUuDQo+ID4gPg0KPiA+ID4gVGhlIGluc3RydW1lbnRhdGlv
biwgdGhlIGhhcmR3YXJlIHRlc3RpbmcgYW5kIHRoaXMgY2hhbmdlbG9nIHdlcmUNCj4gPiA+IGRv
bmUgd2l0aCB0aGUgYXNzaXN0YW5jZSBvZiBhbiBBSSBjb2RpbmcgYWdlbnQ7IHRoZSByZXN1bHRp
bmcgY2hhbmdlDQo+ID4gPiBoYXMgYmVlbiByZXZpZXdlZCBieSBoYW5kLg0KPiA+ID4NCj4gPiA+
IEZpeGVzOiA2YjI5Njk4MzFmN2UgKCJkcm0vYW1ka2ZkOiBVbm1hcCBzdm0gcmFuZ2UgZnJvbSBH
UFUgc2V0IHRvDQo+ID4gPiBuby0NCj4gPiA+IGFjY2VzcyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZXcgTWFydGluIDxhbmRyZXcubWFydGluQGFtZC5jb20+DQo+ID4gPiBBc3Npc3RlZC1i
eTogQ2xhdWRlOmNsYXVkZS1vcHVzLTUNCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyB8IDkgKysrKysrKy0tDQo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+ID4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+ID4gaW5kZXggYzUyMWVjMDdiZjNj
Li43NWUyNWYwNzVkYTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfc3ZtLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9zdm0uYw0KPiA+ID4gQEAgLTE3NTgsOSArMTc1OCwxNCBAQCBzdGF0aWMgaW50IHN2bV9yYW5n
ZV92YWxpZGF0ZV9hbmRfbWFwKHN0cnVjdA0KPiA+ID4gbW1fc3RydWN0ICptbSwNCj4gPiA+DQo+
ID4gPiAgICAgICAgICAgICAgIC8qDQo+ID4gPiAgICAgICAgICAgICAgICAqIElmIHByYW5nZSB3
aXRoIGFsd2F5cyBtYXBwZWQgZmxhZywgdXBkYXRlIG1hcHBpbmcNCj4gPiA+IG9uIEdQVXMgd2l0
aA0KPiA+ID4gLSAgICAgICAgICAgICAgKiBBQ0NFU1MgYXR0cmlidXRlDQo+ID4gPiArICAgICAg
ICAgICAgICAqIEFDQ0VTUyBhdHRyaWJ1dGUuICBPbmx5IHdpZGVuIHRoZSBzZXQgd2hlbiBub3Ro
aW5nIGVsc2UgaGFzDQo+ID4gPiArICAgICAgICAgICAgICAqIHNlbGVjdGVkIGEgR1BVOiBjdHgt
PmJpdG1hcCBhbHNvIHBpY2tzIHRoZSBvd25lciBwYXNzZWQgdG8NCj4gPiA+ICsgICAgICAgICAg
ICAgICogYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXMoKSBiZWxvdywgYW5kIHNwYW5uaW5nDQo+
ID4gPiBHUFVzIHdpdGgNCj4gPiA+ICsgICAgICAgICAgICAgICogZGlmZmVyZW50IHBhZ2Ugb3du
ZXJzIGZvcmNlcyB0aGF0IG93bmVyIHRvIE5VTEwsDQo+ID4gPiArIHdoaWNoDQo+ID4gPiBtYWtl
cw0KPiA+ID4gKyAgICAgICAgICAgICAgKiBITU0gZmF1bHQgb24gdGhlIHByb2Nlc3MncyBvd24g
bWlncmF0ZWQgcGFnZXMuDQo+ID4gPiAgICAgICAgICAgICAgICAqLw0KPiA+ID4gLSAgICAgICAg
ICAgICBpZiAocHJhbmdlLT5mbGFncyAmDQo+ID4gPiBLRkRfSU9DVExfU1ZNX0ZMQUdfR1BVX0FM
V0FZU19NQVBQRUQpDQo+ID4gPiArICAgICAgICAgICAgIGlmIChiaXRtYXBfZW1wdHkoY3R4LT5i
aXRtYXAsIE1BWF9HUFVfSU5TVEFOQ0UpICYmDQo+ID4gPiArICAgICAgICAgICAgICAgICBwcmFu
Z2UtPmZsYWdzICYNCj4gPiA+IEtGRF9JT0NUTF9TVk1fRkxBR19HUFVfQUxXQVlTX01BUFBFRCkN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBiaXRtYXBfb3IoY3R4LT5iaXRtYXAsIGN0eC0+
Yml0bWFwLCBwcmFuZ2UtDQo+ID4gPiA+Yml0bWFwX2FjY2VzcywNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTUFYX0dQVV9JTlNUQU5DRSk7DQo+ID4gPiAgICAgICB9IGVs
c2Ugew0KPiA+ID4gLS0NCj4gPiA+IDIuNDMuMA0KPiA+DQo=
