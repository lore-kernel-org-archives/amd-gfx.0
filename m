Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305DE9380B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 02:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA55810E2F3;
	Mon, 13 Apr 2026 02:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/InvhvS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB3910E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 02:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCBs07YuVlYtkaZRv5kJfwzaRFUFTDaXA72lJJBC2OdfpPJEReQDMCWWrAubznw4tBoMUXJDMVFpV9GZgIJYaaKPDgjFy1Sdb92Js/qHeZdkKMx3A7XHiNkpP3q2VXomGeTs12513dZ5QHP25tzLd8Ghc6az/k+re2VrXqCaY9srXeAu1rF6/YMnOtuHUa8nQg5CI37NKkbJxm5ir/ZvUOAo1qGhmbVDRW2xlhDoclMVgV6CqkHbnK6DYrJdj6LXs1GiiGMabDietpiCkVsGAjI6Vop78206bF4HnM4Ko0UzicAvaZ2n5wGqxY+8YALt2xOA/e5mKMxvhw2xaCj+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AEcCbdnRuVleCmMxTjn+YRBIGQW680R/q/o47dr6Vc=;
 b=RqVIxcQu+PnmicQxusKyUIzaOeuOPO3+32hawJZnX3YaAXnjTqOmC7+/7b0y6q3mcVN+4neKKQJh9I4XVwZFUUH9tYw35Bo6ba4Y3thtzOxtcxYUtu3nwOA0qai1GZOWI0x8Nu8uzy7FD0IWUQaySbSXYsnWwC+jcomdpnZ4LnSsqxyyWS38Dnaxjvyr9jOBqa+ZkvPiuPonV8h6T4HHErBrj1GyMmOiRCtH45iiDYGT3qnhUxnaj2zvos5iApl81qdBhRB9lTsndluop6ER45R4Yk+6STnYHxXA4/vfjoUljjq3acFywn2LO42UsFDMXauBxLOm2JLMsNJqrwdwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AEcCbdnRuVleCmMxTjn+YRBIGQW680R/q/o47dr6Vc=;
 b=g/InvhvSurN7bnwchZbr6b2QJ4zjUYjq3JtyEJ4WFiIONt24234OFXvJIzEcy2AYT9uULbDz/S/ar26jbU3XUeg1+u7sMyPKh1ZT507E0a2X1VIX1ZDUrFNItpA/ncV2mvjNuQxGCyrZxkl/8C/pKLye31chqsWqQwp5jZ3hB1I=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Mon, 13 Apr
 2026 02:11:50 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 02:11:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
Thread-Topic: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
Thread-Index: AQHcxyu56w9gd+5d2kWBov5rm4hthrXU1KIAgAMiQBCAADssgIAEFR1g
Date: Mon, 13 Apr 2026 02:11:49 +0000
Message-ID: <PH7PR12MB6000FF5DF3D9CCC44FD0D3C5FB242@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260408074537.3439191-1-Prike.Liang@amd.com>
 <9a52847a-eb80-4008-8d18-9707bd1751ca@amd.com>
 <PH7PR12MB6000867DFA188AEA5489ADE7FB592@PH7PR12MB6000.namprd12.prod.outlook.com>
 <8f7a2920-b8db-42ab-820f-63de5eb89e23@amd.com>
In-Reply-To: <8f7a2920-b8db-42ab-820f-63de5eb89e23@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-13T02:11:03.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DS7PR12MB9552:EE_
x-ms-office365-filtering-correlation-id: 3ef4fc6b-5615-4b5c-9f4d-08de990205e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: fk+3SgUyXoMSV/8N57okvdMAAYTUTqRBmEg7Vk36RscLrNzyzkpN8b8AzZyzJLOPB8ZMTkpuGryizeHU1MIbP4nqHff3O+EVIABifP4tzroi1F6dP/u38MwNyPyNf1O+rSyNBwVFHi+iu9zz60xo26UySzEEpLmslXGCq8iyOuNGQ+sfegd9MntDE/F95Avak2akXc2dwmCz1CfO+dvY4p0KvcUGyHYX0BfROEEj/5DXxU7uI8Iz1DJJQ2rcXmuUD0EYlziga/WKOcm9AbgkpweRL+P+pMb+Yp50oyGRmEhjTI5FPBRQA2Kzda9Z1vTVASDQsdC06P22jNn7DYpkcRGdoatIP1sPMSsNznNuBM6Tp6x67hwgUB41Fux6TWRB2NkXQlk3Mb+TEU+vyGjStNsbbCrZ5SB9yYnbxzGtiZ3t8nniQhVcBd87+b9lIdRawJCVxVBw76WvpK2vC6ip7nq6uJedb1ZFAMd2a3390kSxTZ38t5HoVOCXVziiRMslZqtmClTM5d1YMxDCe+xVL6EOn9nWFj2tWRWz9K0qfvt79iEp7utaO6lzgJajQXy1plZ5KfvlNv+BAWI/mvKAt2JMs3xvP+1Ck5teE0qa/Aou3fhe13D7uRXwsR+l4YIIuoPBC2fcoheiTcm7J8IA4opl/nppLXCHr9b8sg5r9C+mGAsKovObutD1LdnE8hV/fdl1Yd9CX14tBiVeL6XB4yt0quCSfuv+eK3w+gPupn45c+cq3fDPvw81rw4XJueP8OODY20p9WZI4hYvv2gyLWHK2/d5MVVee9vUpqSYEKQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXIwNXA5VUxXWEVwZ0lraWoyQUJJcWZvN2hRbGdkS2l5V05seWk3NkJUa1lz?=
 =?utf-8?B?NzhWOXl5QThlTm8xSnVNbzRTdFZ4RkU0NjlyeS9QdzBpU3d3VnQ5dEJxRGlW?=
 =?utf-8?B?WnFqemQrajFsN3k0NzZ1WURuMFJXY0FMc0pHRkRNV1pLaUFYSTdQbHgwazRL?=
 =?utf-8?B?MGdIZklQZVk3d1czaG9PZTVoaVozRCtuMmt4ZXRoQ2JhRVVTeXEySjVKOVhk?=
 =?utf-8?B?RzFNZHlKL29HaFR1Q3VNUjMzOTBSajJHZkdFSko1WTlkQTdzRXdtRWRtd2t4?=
 =?utf-8?B?ZHU1cEQ3WHQrbXd6ZThnWTJoeGdMT1hXbVhkVnFlYjJQcDRkSkRLRklRdnA3?=
 =?utf-8?B?OHhQaDR2bWRLd0pBenpiSlRSamhSRlNxczhDUkpiRlYrM0Nqa0F5ZFVROWt0?=
 =?utf-8?B?ZGdLaFJ6eDk2MURJelhGVGNwQnByVnlYMm9FeUFnOW9SUmMva3ZSc3pvMmR4?=
 =?utf-8?B?T1htb05iZzc2aXI3aktiZW9HTVc1SEFtWnZqb3JGMjJKOGRqVU96OXcvSGZ3?=
 =?utf-8?B?SWszNXdxOVJXUGowbGJQTW5ZZG1uNThXaWd6cStNK09zQ0ZkMHNmZ3BMcUFB?=
 =?utf-8?B?bHlBaEd5bGNLMkdDT2pIWlMzbnlIYlB0RmU5TEZPZzNScncwcWtIOE1BcVRn?=
 =?utf-8?B?VDhHRjF4dHpXVldNcG5kVEJOeElXa0gycWhkUi84VmxkRm9pTkdBblpyL3Q5?=
 =?utf-8?B?cUw5ZGpSTWdLYW5BTnNndjBrNmx6UG41NU10eVhraGlvanA5bUwvbmtRUFZW?=
 =?utf-8?B?dTBQdG14Ry92TjRtSDhFclZTemI0VHRyMWovUlZ0VG9paXRqbkxFN3F2cm1V?=
 =?utf-8?B?VWttQXVoSDhyclptNDJ5VGJ5d3VrMzY5dnFrM2Y5Nyt1emp6MUppeTVTV0JI?=
 =?utf-8?B?SnNLQ1FOdHo3NHlzdy9hTjlNejRUMEd0Q2VvWkZTMmJMRmNGWm5Lek1SMGp6?=
 =?utf-8?B?NVN0dzkvNUcxajd6MWpCMFdUczNtRWloZ2pWSGtoNzVUc2ZIZzJmS1ZteTV2?=
 =?utf-8?B?Ymo4bVRGM00yaFlMZld0ZHNhZGhiRm5ZVTlzTm9ROFNxR0hnV2wzNnBRRklJ?=
 =?utf-8?B?ZCtmM0NtVGtHV1NDOXZaSXc1VHluNERsWm82d2VFQ0w5ZWdHMTFDUC9yWVNH?=
 =?utf-8?B?MmNTLzBkdDBUNU1VMVdqSmM3L09JZUtwT2ZQK3JLMDdRUlphMUhjK3BHRm9U?=
 =?utf-8?B?elViZlVFUkZPeEdWWkZNTklzbDJRd0JJR3hhOHpQTTlmT2tBTTdkd0k3OXhs?=
 =?utf-8?B?bGpqendmTXJranlOMWE4UTk4VDJQS0V1czFvTW5XL0JJTzl0K0xzWklLdTFZ?=
 =?utf-8?B?U1FsOEpBN2U5U1NUV3ZCbGU0Q0w5Tk5vY3FzMDFDWDdDUEhxMjg2aCtmTGlM?=
 =?utf-8?B?UWJsVTJhZVRydSt1SURyQVh1eDBmTEk4WkJraW1FWHJnTERvWm50cERLZ05U?=
 =?utf-8?B?Um5SbGpIc0hXekJkMXpBdmFWczR4Z0xsbExVcWJmOURzZ0I3Y0Q3akRhcEZS?=
 =?utf-8?B?dlpiR0tDbzNxZzkzVGNiK25KS3c4NzdNdk03OTlXbzFJUlA4MUhmK2phQjlD?=
 =?utf-8?B?RncyckRxNXVmaGQ4ditHZmZZVXBFc2NrTDY0QTFoSldRVUt5WnJtTkNzQTNi?=
 =?utf-8?B?SVJmZXpUN3NOVnkwS0VLY0pWVDlmOHpZR044MW1TMEN0eGxUditzSHNmM0Qv?=
 =?utf-8?B?NWhDQlI3YjJsYUVBdlZDbnBmazdUY25aMXdJM1kySlZpeXVrRmNXYi9oR1pi?=
 =?utf-8?B?OGhlQWNvNjRhUzEvUW5kWHZBYlNKU2wzMWFhbHA2SnhOZHdxa0tUalJIQVNh?=
 =?utf-8?B?KzdwM1FRWC9MSlZQUEhNblRRb2lUUlBveTg0allqMTZweDRicUp1RnYyQi8x?=
 =?utf-8?B?c1p1Vm1EWTlxekdmUFF4N0tSNUovZFp2Sjc5ZVQ1aWtxNDlDT2dwNHpmSmFP?=
 =?utf-8?B?RmVFUThJZlBLY2hVcGxKU21ISmZWUFZOV0w3bWZQZGd3Z0F1ZVBNbkpLZUFB?=
 =?utf-8?B?TGF6WmtpZ1A1NjBkNEwzd1dlV2cvUjM5bjNFeW1tRXZwSzNZekVRUFZ3ZTcy?=
 =?utf-8?B?VWhDQmF4czFWYno0YU9wd2J2RXFqeG1sSU1seDFCcWk0b2xPNURCMzlCM2xM?=
 =?utf-8?B?WlBueFVaUjYvQUF6NE1vVFRQWWc1MDErZDg5SXVsREZsa2dmczVUdUxtQk9J?=
 =?utf-8?B?WnRzMG1QUS9nV2laSUxZZmpnQSsyN2hraElqUEFEeHRsbVRWUnIwbU1MaXhF?=
 =?utf-8?B?VUkwb3JyZklSZ1ZDU1ZteEdDRHJDT25Fa29lWGZHbWZ3QVl4TW5RNnZhUldj?=
 =?utf-8?Q?zwFqC6pJQICAu4VHVx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef4fc6b-5615-4b5c-9f4d-08de990205e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 02:11:50.0779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQQJRudc7qKed9t4pjSreZLvDcWN/T4EVvj9dNmgMIfdgT20I1GT1u4KItvAJwpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxMCwgMjAyNiA3OjUwIFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkcm9wIHVzZXJxIGZlbmNlIGRy
aXZlciByZWZzIG9uIGZlbmNlIHJlbGVhc2UNCj4NCj4gT24gNC8xMC8yNiAxMDozMiwgTGlhbmcs
IFByaWtlIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgICAg
IFByaWtlDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPj4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCA4LCAyMDI2IDQ6MjcgUE0NCj4gPj4gVG86IExpYW5nLCBQcmlrZSA8
UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGRyb3AgdXNlcnEgZmVuY2UgZHJpdmVy
IHJlZnMgb24NCj4gPj4gZmVuY2UgcmVsZWFzZQ0KPiA+Pg0KPiA+PiBPbiA0LzgvMjYgMDk6NDUs
IFByaWtlIExpYW5nIHdyb3RlOg0KPiA+Pj4gYW1kZ3B1X3VzZXJxX3dhaXRfaW9jdGwoKSB0YWtl
cyBleHRyYSByZWZlcmVuY2VzIG9uIHdhaXRlZC1vbiBmZW5jZQ0KPiA+Pj4gZHJpdmVycyBhbmQg
c3RvcmVzIHRoZW0gaW4gd2FpdHEtPmZlbmNlX2Rydl94YS4gV2hlbiBhIG5ldyB1c2VycQ0KPiA+
Pj4gZmVuY2UgaXMgY3JlYXRlZCwgdGhvc2UgcmVmZXJlbmNlcyBhcmUgdHJhbnNmZXJyZWQgaW50
bw0KPiA+Pj4gdXNlcnFfZmVuY2UtPmZlbmNlX2Rydl9hcnJheSBzbyB0aGV5IGNhbiBiZSByZWxl
YXNlZCB3aGVuIHRoZSBmZW5jZQ0KPiBjb21wbGV0ZXMuDQo+ID4+Pg0KPiA+Pj4gSG93ZXZlciwg
dGhvc2UgaW5oZXJpdGVkIHJlZmVyZW5jZXMgYXJlIGN1cnJlbnRseSBvbmx5IGRyb3BwZWQgZnJv
bQ0KPiA+Pj4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9wcm9jZXNzKCkuIElmIGEgZmVuY2Ug
bmV2ZXIgcmVhY2hlcyB0aGF0DQo+ID4+PiBwYXRoLCBzdWNoIGFzIGl0IGlzIGFscmVhZHkgc2ln
bmFsZWQgd2hlbiBjcmVhdGVkIG9yIGl0IGlzIGRyb3BwZWQNCj4gPj4+IHRocm91Z2ggYW4gZXJy
b3IvY2xlYW51cCBwYXRoLCBhbWRncHVfdXNlcnFfZmVuY2VfZnJlZSgpIGZyZWVzDQo+ID4+PiBm
ZW5jZV9kcnZfYXJyYXkgd2l0aG91dCBwdXR0aW5nIHRoZSByZWZlcmVuY2VkIGZlbmNlIGRyaXZl
cnMuDQo+ID4+DQo+ID4+IENsZWFyIE5BSyB0byB0aGF0IGFzIHdlbGwuDQo+ID4+DQo+ID4+IEFu
IHVzZXJxIGZlbmNlIG11c3QgYmUgc2lnbmFsZWQgYXQgc29tZSBwb2ludCBhbmQgd2hlbiB0aGF0
IGhhcHBlbnMNCj4gPj4gdGhlIHJlZmVyZW5jZSBmZW5jZSBkcml2ZXJzIGNhbiBiZSBwdXQuDQo+
ID4+DQo+ID4+IFdoYXQgY291bGQgYmUgaXMgdGhhdCB3ZSBoYXZlIGFub3RoZXIgY2FsbCB0byBk
bWFfZmVuY2Vfc2lnbmFsKCkNCj4gPj4gd2hlcmUgd2UgZm9yZ2V0IHRvIGRvIHRoYXQsIGJ1dCBp
dCBzaG91bGQgKm5ldmVyKiBiZSBkb25lIGluDQo+IGFtZGdwdV91c2VycV9mZW5jZV9mcmVlKCku
DQo+ID4gSXQgbG9va3MgbGlrZSB3ZeKAmXJlIG1pc3NpbmcgdGhlIHVzZXJxIGZlbmNlLWFycmF5
IHB1dCBvbiB0aGUgc2lnbmFsZWQtZmVuY2UgYnJhbmNoDQo+IGluIGFtZGdwdV91c2VycV9mZW5j
ZV9jcmVhdGUoKS4NCj4NCj4gQWggeWVzLCBJIHNlZS4gR29vZCBjYXRjaC4NCj4NCj4gPiBJZiB3
ZSBlbnN1cmUgdGhlIGZlbmNlLWFycmF5IGlzIHByb3Blcmx5IHB1dC9iYWxhbmNlZCBlYXJsaWVy
IGluIHRoZQ0KPiA+IGZsb3csIHRoZW4gYW1kZ3B1X3VzZXJxX2ZlbmNlX3B1dF9mZW5jZV9kcnZf
YXJyYXkoKSB3aWxsICBuYXR1cmFsbHkgYmVjb21lIGENCj4gbm8tb3AgaW4gYW1kZ3B1X3VzZXJx
X2ZlbmNlX2ZyZWUoKS4gTWVhbndoaWxlLCBrZWVwaW5nIHRoZSAqX3B1dCBjYWxsIGluIGZyZWUo
KQ0KPiBzZXJ2ZXMgYXMgYSBmaW5hbCBiYWNrc3RvcCB0byBjb3ZlciBhbnkgb3RoZXIgb3Zlcmxv
b2tlZC91bmJhbGFuY2VkIHBhdGhzLg0KPiA+DQo+ID4gSWYgeW91IHN0aWxsIHByZWZlciB0aGF0
IGFtZGdwdV91c2VycV9mZW5jZV9wdXRfZmVuY2VfZHJ2X2FycmF5KCkNCj4gPiBzaG91bGQgbm90
IGJlIGNhbGxlZCBmcm9tIGZyZWUoKSwgSSBjYW4gcmVtb3ZlIGl0IGFuZCBjbGVhbiB0aGlzIHVw
DQo+ID4gYWNjb3JkaW5nbHkgYW5kIG9ubHkgcHV0IGl0IGluIHRoZSAqY3JlYXRlKCkNCj4NCj4g
YW1kZ3B1X3VzZXJxX2ZlbmNlX2ZyZWUoKSBpcyBjb21wbGV0ZWx5IHJlbW92ZWQgYnkgbXkgcmVj
ZW50IERNQS1mZW5jZQ0KPiBpbmRlcGVuZGVuY2UgcGF0Y2hlcy4gU2VlIHRoZW0gb24gdGhlIG1h
aWxpbmcgbGlzdC4NCj4NCj4gSSdtIGN1cnJlbnRseSB3b3JraW5nIG9uIGZpeGluZyB0aGUgcmVz
ZXQgaGFuZGxpbmcgYW5kIGZlbmNlIGFsbG9jYXRpb24uIFBsZWFzZSB3cml0ZSBhDQo+IHN0YW5k
IGFsb25lIHBhdGNoIHRvIGZpeCB0aGlzIGlzc3VlIHdoaWNoIHdlIGNhbiBwdXNoIGJlZm9yZSBt
eSB3b3JrIGxhbmRzLg0KU3VyZSwgdGhhbmsgeW91IGZvciB0aGUgaGVhZHMgdXAuDQoNCj4gVGhh
bmtzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0aWFu
Lg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgfCAxNw0KPiA+Pj4gKysrKysrKysrKystLS0tLS0NCj4g
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
Pj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3VzZXJxX2ZlbmNlLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3VzZXJxX2ZlbmNlLmMNCj4gPj4+IGluZGV4IDNiZTgwYTgyNzg4YS4uYmQxOTY1OTlkM2Q2IDEw
MDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
X2ZlbmNlLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycV9mZW5jZS5jDQo+ID4+PiBAQCAtMTQ1LDEzICsxNDUsMjEgQEAgYW1kZ3B1X3VzZXJxX2Zl
bmNlX2RyaXZlcl9mcmVlKHN0cnVjdA0KPiA+PiBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnVzZXJx
KQ0KPiA+Pj4gICAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfcHV0KHVzZXJxLT5mZW5jZV9k
cnYpOw0KPiA+Pj4gIH0NCj4gPj4+DQo+ID4+PiArc3RhdGljIHZvaWQNCj4gPj4+ICthbWRncHVf
dXNlcnFfZmVuY2VfcHV0X2ZlbmNlX2Rydl9hcnJheShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX2ZlbmNl
DQo+ID4+PiArKnVzZXJxX2ZlbmNlKSB7DQo+ID4+PiArICAgdW5zaWduZWQgbG9uZyBpOw0KPiA+
Pj4gKyAgIGZvciAoaSA9IDA7IGkgPCB1c2VycV9mZW5jZS0+ZmVuY2VfZHJ2X2FycmF5X2NvdW50
OyBpKyspDQo+ID4+PiArICAgICAgICAgICBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX3B1dCh1
c2VycV9mZW5jZS0+ZmVuY2VfZHJ2X2FycmF5W2ldKTsNCj4gPj4+ICsgICB1c2VycV9mZW5jZS0+
ZmVuY2VfZHJ2X2FycmF5X2NvdW50ID0gMDsgfQ0KPiA+Pj4gKw0KPiA+Pj4gIHZvaWQgYW1kZ3B1
X3VzZXJxX2ZlbmNlX2RyaXZlcl9wcm9jZXNzKHN0cnVjdA0KPiA+Pj4gYW1kZ3B1X3VzZXJxX2Zl
bmNlX2RyaXZlciAqZmVuY2VfZHJ2KSAgew0KPiA+Pj4gICAgIHN0cnVjdCBhbWRncHVfdXNlcnFf
ZmVuY2UgKnVzZXJxX2ZlbmNlLCAqdG1wOw0KPiA+Pj4gICAgIHN0cnVjdCBkbWFfZmVuY2UgKmZl
bmNlOw0KPiA+Pj4gICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4+PiAgICAgdTY0IHJwdHI7
DQo+ID4+PiAtICAgaW50IGk7DQo+ID4+Pg0KPiA+Pj4gICAgIGlmICghZmVuY2VfZHJ2KQ0KPiA+
Pj4gICAgICAgICAgICAgcmV0dXJuOw0KPiA+Pj4gQEAgLTE2NiwxMCArMTc0LDcgQEAgdm9pZCBh
bWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX3Byb2Nlc3Moc3RydWN0DQo+ID4+IGFtZGdwdV91c2Vy
cV9mZW5jZV9kcml2ZXIgKmZlbmNlX2QNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgZG1hX2ZlbmNlX3NpZ25hbChmZW5jZSk7DQo+ID4+
PiAtDQo+ID4+PiAtICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdXNlcnFfZmVuY2UtPmZlbmNl
X2Rydl9hcnJheV9jb3VudDsgaSsrKQ0KPiA+Pj4gLSAgICAgICAgICAgICAgICAgICBhbWRncHVf
dXNlcnFfZmVuY2VfZHJpdmVyX3B1dCh1c2VycV9mZW5jZS0NCj4gPj4+IGZlbmNlX2Rydl9hcnJh
eVtpXSk7DQo+ID4+PiAtDQo+ID4+PiArICAgICAgICAgICBhbWRncHVfdXNlcnFfZmVuY2VfcHV0
X2ZlbmNlX2Rydl9hcnJheSh1c2VycV9mZW5jZSk7DQo+ID4+PiAgICAgICAgICAgICBsaXN0X2Rl
bCgmdXNlcnFfZmVuY2UtPmxpbmspOw0KPiA+Pj4gICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChm
ZW5jZSk7DQo+ID4+PiAgICAgfQ0KPiA+Pj4gQEAgLTMyMCw5ICszMjUsOSBAQCBzdGF0aWMgdm9p
ZCBhbWRncHVfdXNlcnFfZmVuY2VfZnJlZShzdHJ1Y3QNCj4gPj4+IHJjdV9oZWFkDQo+ID4+ICpy
Y3UpDQo+ID4+PiAgICAgc3RydWN0IGFtZGdwdV91c2VycV9mZW5jZSAqdXNlcnFfZmVuY2UgPSB0
b19hbWRncHVfdXNlcnFfZmVuY2UoZmVuY2UpOw0KPiA+Pj4gICAgIHN0cnVjdCBhbWRncHVfdXNl
cnFfZmVuY2VfZHJpdmVyICpmZW5jZV9kcnYgPQ0KPiA+Pj4gdXNlcnFfZmVuY2UtPmZlbmNlX2Ry
djsNCj4gPj4+DQo+ID4+PiArICAgYW1kZ3B1X3VzZXJxX2ZlbmNlX3B1dF9mZW5jZV9kcnZfYXJy
YXkodXNlcnFfZmVuY2UpOw0KPiA+Pj4gICAgIC8qIFJlbGVhc2UgdGhlIGZlbmNlIGRyaXZlciBy
ZWZlcmVuY2UgKi8NCj4gPj4+ICAgICBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX3B1dChmZW5j
ZV9kcnYpOw0KPiA+Pj4gLQ0KPiA+Pj4gICAgIGt2ZnJlZSh1c2VycV9mZW5jZS0+ZmVuY2VfZHJ2
X2FycmF5KTsNCj4gPj4+ICAgICBrbWVtX2NhY2hlX2ZyZWUoYW1kZ3B1X3VzZXJxX2ZlbmNlX3Ns
YWIsIHVzZXJxX2ZlbmNlKTsgIH0NCj4gPg0KDQo=
