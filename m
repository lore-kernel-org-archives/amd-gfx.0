Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DF7E99052
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 08:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD7C10E87C;
	Fri, 10 Apr 2026 08:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkWYp/hq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C189710E87C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 08:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN6nrzsIwQIOYwJYNsiIndPq9BUO7Rzf26jEJ8PKetRQTs7NVjk42pPpaO5DemIiqhMBLBtr5O/K1m13vuAU1MdC8MD+Ij+IvQpouJf91OBx/P9taJuNV88qYOxjTDNg/yTSBvRZtyLRntNVKyndO69wA81ilWgrgF68iaOGD4jATVO5SiHAACPwYYD3ORXiV+f1fqCBRUSXCPfeXJeDXX6sxlv+dUZktirEB6ntX/tQ+nE+XWMrCAOyoRad8HVAI4h+kpeGLrFcZHaeMQKba5r6N99exiS1bcn4/oWys8KBwvrjD3/NW9eSi+EX/lRuUkjwIjG7hq6QdZEs6MHh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N++oTQIzLwqVu+REMT+OS+wqrBXznnNJ0L9G/xgBtuk=;
 b=QMG54mKJofPcX9uF+y06I0WdEkfgbUexDv5mDKRmDgXAUoFIXyz2FEg1fkplkjjeJFwx8hiswcEHIiQzCRdukPW4n6vqi0hMhW16Haz4oIrOaEGIphJUwgNXCO3ROYd39ZZ+xBUgiANX1HdGLcZRyuZkoFIjnlLL4nCDuVSpyDEzI4cR2oXWyyXmrhMz2L5LzEy8AV4PGPWOIP3rYpLOK7UdH4/jpe30YSPhQKxnQW3jrpNadg5u7X4APygyU/vdYeM9N5AnBw0SOjjDimpSJ9zMhAx522Nyuhst0lqp+1LolwnrM6vozfObWbGeL8qLwLv/u9ilFyJOC9J4ExhPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N++oTQIzLwqVu+REMT+OS+wqrBXznnNJ0L9G/xgBtuk=;
 b=LkWYp/hqqcpInBFgPymm9HnQIbldEXP+ErYOeLKCpk4rQf6fmmBf7PxMXWuMVxGBzaXxRIbY3coo/kmapR21wIgMsJPH+XMKqXETILyFDqkmmz1PgoI2DCM0fViYiYX1UuPgcPqgVgi/6G0wtD4gu9YvO4ZyHRmfebDaXmtvbII=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 08:32:52 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:32:51 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
Thread-Topic: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
Thread-Index: AQHcxyu56w9gd+5d2kWBov5rm4hthrXU1KIAgAMiQBA=
Date: Fri, 10 Apr 2026 08:32:51 +0000
Message-ID: <PH7PR12MB6000867DFA188AEA5489ADE7FB592@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260408074537.3439191-1-Prike.Liang@amd.com>
 <9a52847a-eb80-4008-8d18-9707bd1751ca@amd.com>
In-Reply-To: <9a52847a-eb80-4008-8d18-9707bd1751ca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-10T08:18:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH7PR12MB6657:EE_
x-ms-office365-filtering-correlation-id: 85977667-f4bd-4899-029a-08de96dbc14a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 04bbR/GpELXcreik9l90VcvXbC5QkXbSHZ8Xb6BO5++TyBvhlWgM7Nqun5WVihErSdFhBfnnmM9yoxdMGiZgZzezsotY/YTpNclEFoFACz9Zx4ckTZusE5Rq9Yk27ollNfJU2YxUP6xK/JekNGAq8gAeSSXzxVewoa/HojRiqhhVEIkGZm1qIY9ck+VXA8cBGLbuDp8AZegecqrOg++tP47VuTQyW9Yey90/htsSCdOEq8nx86xKKNq1xRrCZgIOCh+Ht0SQHt1KvCWaLK/up6Xu9vb1tFLq2wBHtJgqKMI5WFkR/UA0KbdxRvIHS0MN/vls6yAG0VnmLGtyIX62o09gxgIjWjGJaxM18RFqZeGN5RZijzlf/twioiJVCrA0QoClXxK0zHhCBhWG52a8lOsfBZqoWRWbxcmNiqncz88bEUIdwe3UrBvezfd2r37im+5DBJ0H698ZUdAJVNzmOuXXrD/1AE7ru7aDN/LoGn5eF/3y9SO/Ivu1cGCJwMRZPgpueRaHC/OIVzz99fg6tkJXRQqLpjnQZ7vHxsT6jyIkghtOVcXQLZpH7YlpbzsNwTL/+Qvb34x6hRrJYuTXj40Zply+0sSduq3Bg1eXFcosthLcXoLIrhdKogAY4LsgXdqDW+SXir+FNVdo27Wqi9bdW5n4jlrp62JG6fJn/O6P1/egnssbg5VbXPq36bNKNvFS14eGxVpy+fC5/EjF8s6qwxM7pX5ZMRyAc/AaWog3b0VPBf2ke6iu9y22PEC8zXwiHNF9wk9Gx0QgZygW0QMoCZgfEt14hnythGa+n5k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGxsZ2ViUmdXYTlKTUJaMlRrVVBxeFpiK0lzZXNHd0xYUHRtUlBtaEtVMzdm?=
 =?utf-8?B?VHRQSjVtOE9NbnB3K0FXaXlxa0lFSTlOdGd0WG8vRitmTEtLWTZvWTlma2hF?=
 =?utf-8?B?YVhDZ1hvdmNNTWw3aEQ0ZWY3OUJ0WjJVd25FeElGYWpzUnNKYXZWdld4TlY5?=
 =?utf-8?B?bFoyK0xWMzR5UjJRUWZST1F0cDFzdnFabWhHUFRET2RJdjh3Nlc2bnQ5M1ho?=
 =?utf-8?B?VnFSUUlNbTlHZ3VYTW1pN1BMQnpUY0NSWEVVcHVIcFFnMVozN2tVWWxhZlFZ?=
 =?utf-8?B?b1Fva01oeFJQMFVOZGtIZXB4U0doSEJKNTR2UWtBWm9Qb1pGaVphaTVubnox?=
 =?utf-8?B?T1Y3eVR6K3MzVXByTjhnZWErUzJzZHUrWWxDUmh2SGhmZ1h2V3g0KytEbHU5?=
 =?utf-8?B?WVhicFNwbkpxSXh2T25TMXlSUU1pKzFwbE1la201L3VXQlFXZGlQb1BaRWkx?=
 =?utf-8?B?Zkp2Z0xtV1hrZDVieUtyRU1kSXRVTlNSTDJCVzNENGtOZ042WU5CU2M5Zyta?=
 =?utf-8?B?cjJFS1FmOUhHdkxFUnJhSmFKWVJ0MnR3K01rZ3JxZXpudjJZeHJLc0RNRW5p?=
 =?utf-8?B?NnNXTDBLSnB4Rm5GeGozSGJGWlMvaVZmcjNqMDVjbWdmVGZLTTBYdnd5U2Zt?=
 =?utf-8?B?YW9nRE9wQnNwYTNScm9IU1pQMXQ5VTVZUG5uVWxKNnByMkRyNEFtMzdocFV0?=
 =?utf-8?B?eFc4NHRMSzNtdmRIU3JNR1pNTWNISlUrWGtJcmZ1TGQwaW95VDNmNENWaGZN?=
 =?utf-8?B?Tm1VMUQ2WmIwUFNleGhpa2tmSytMTjZRVWRRazBJYmI2eTI5Y05IbWNQTi9v?=
 =?utf-8?B?bGZPM3BCakQ0eEFXZXhicWVZUmgrZFoxRFpyUDdsZzA1KzUxc2pZck5GSk5x?=
 =?utf-8?B?bEhDcDB4Smk1anpPMjV5WnFWN1IvNjNYNkw1VXF6Zkp4dHN1ZHB6WTZUWUNU?=
 =?utf-8?B?a0VUbXcyTjQrN1o1alduWkljMjVYMTFwNDlFdk4vVzl3R1lMazNIOG9uTWJP?=
 =?utf-8?B?QzhQd2hFZ3lNeVBmazZ3d0lZdDB5WmVyWm9lcDU1VEFoYTlYWnpCck8wajZw?=
 =?utf-8?B?eFFiVWZtRFozbDdjcEU3MjMxaWNkV1ZTVzhnT2cxZk0xRUIyN1VpVmI2ek9r?=
 =?utf-8?B?dDZZdmh0bjV4TThQbmp4RUxmNmNKTGw2STdwUG15WXFNRkpWditVNFNJYUZS?=
 =?utf-8?B?YmZlbFZRU2UyK2dFQXV3STRlLzA5NVlmU1NoeXRZM0x6QXVmcTVBTlIzN2RN?=
 =?utf-8?B?L0NhZHRLeEtPMmtIZ3ZVTUpKTFJOdk5nQXg2cjJRYjdMcUxtWi9aUVFTWjhv?=
 =?utf-8?B?dnIwUzBBVnJ0MEZHTXhoK1JLNlczMmNmRzlqNFd1dGcvN1pCWURCQ1hUWWxL?=
 =?utf-8?B?MUdmYkc2TVY4ZjhscjQ3Ymovd1NBWGVQZVk3YTRIRkI4OUp3U0dDQy9HWlhm?=
 =?utf-8?B?Y2R6NythY1N3UHZJekdZSzVPQi9FRGRhZ3QzUXIvaUJuY3IzWHNhY1ZlSCt0?=
 =?utf-8?B?V21TZ3lITVBqK1VpUnVpbWFqTnh4Mjl1WXAxQVBBdXJMa2lwUmdaWnIwY0ZR?=
 =?utf-8?B?SWFwRUF1NWJiVEQyblhvVHptQVYzUUY3S3o5c1JxSnZmNnRhSHByY2s3akhF?=
 =?utf-8?B?aCtrL3dwbWs2ODBvT0JOMkhUMXFOZ0tZWTZNc09mUks0bXBYRFViS0VNNnd5?=
 =?utf-8?B?dDBLNlc2NTROSEE0VGJkZ3FaRDE5aSswWkVObkpZd3JEVEVsSHVVNnlPOHV2?=
 =?utf-8?B?YjZySzQweUVyVkpBUzdjSkEvVlE4ZEFOOE11SjZCRENnbzdaZWpQdHR6VVFt?=
 =?utf-8?B?RElyYjVHRkdzMnlVNGkxSVBHYXphTXVXMGg3ei8rZW9ic3lrcEpYNjNlRDVB?=
 =?utf-8?B?L3VSUFpSR1hyUjVUalVyZFRPLy9vMlJxdnpWWkRZdzdqTkFtNFJUSVVuRjJX?=
 =?utf-8?B?a21zQnBpbk1nbUlueEF2aUhmOVhUM3BtM0pYNFJEclR4cUNPcEpqL1RXOUhk?=
 =?utf-8?B?ZDBMWlhhZ1RPaThwb2drQ2hrMFZqWS9PdVF0bFUvRE9TN2crMlhxODU2VU9z?=
 =?utf-8?B?SFp3c2tMNDlIRW1WOXc0YmFKNCt5ampzZUxmeXpmTExWVXdlSTYydElvMFVl?=
 =?utf-8?B?STRUUFdDUlBkVm5COGhBWkFsQzh2bzVaaVI4dDY1RzM5MlRNZlg5R2ZuWTNG?=
 =?utf-8?B?REhlQVljSnVaeWVNTmptYW02NE5WTWdtOXdXNTF0ZUQ3Q0pFWlBzYmt4dFNy?=
 =?utf-8?B?SGdQTFd6cXUyYlR0S0FMb01xcEFBR3gzZ0xkYTduamJpNExYR1IyVVVrUk9X?=
 =?utf-8?Q?JiSrMq1ZIBAtueVOTL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85977667-f4bd-4899-029a-08de96dbc14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 08:32:51.7018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SEWEo+jRSKZ00vQZ40m+NfJM3cGoPixpkcquEbsqUrXGEhVeB34kJsE+AISNRqOc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCA4LCAyMDI2IDQ6MjcgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGRyb3AgdXNlcnEgZmVuY2Ug
ZHJpdmVyIHJlZnMgb24gZmVuY2UgcmVsZWFzZQ0KPg0KPiBPbiA0LzgvMjYgMDk6NDUsIFByaWtl
IExpYW5nIHdyb3RlOg0KPiA+IGFtZGdwdV91c2VycV93YWl0X2lvY3RsKCkgdGFrZXMgZXh0cmEg
cmVmZXJlbmNlcyBvbiB3YWl0ZWQtb24gZmVuY2UNCj4gPiBkcml2ZXJzIGFuZCBzdG9yZXMgdGhl
bSBpbiB3YWl0cS0+ZmVuY2VfZHJ2X3hhLiBXaGVuIGEgbmV3IHVzZXJxIGZlbmNlDQo+ID4gaXMg
Y3JlYXRlZCwgdGhvc2UgcmVmZXJlbmNlcyBhcmUgdHJhbnNmZXJyZWQgaW50bw0KPiA+IHVzZXJx
X2ZlbmNlLT5mZW5jZV9kcnZfYXJyYXkgc28gdGhleSBjYW4gYmUgcmVsZWFzZWQgd2hlbiB0aGUg
ZmVuY2UgY29tcGxldGVzLg0KPiA+DQo+ID4gSG93ZXZlciwgdGhvc2UgaW5oZXJpdGVkIHJlZmVy
ZW5jZXMgYXJlIGN1cnJlbnRseSBvbmx5IGRyb3BwZWQgZnJvbQ0KPiA+IGFtZGdwdV91c2VycV9m
ZW5jZV9kcml2ZXJfcHJvY2VzcygpLiBJZiBhIGZlbmNlIG5ldmVyIHJlYWNoZXMgdGhhdA0KPiA+
IHBhdGgsIHN1Y2ggYXMgaXQgaXMgYWxyZWFkeSBzaWduYWxlZCB3aGVuIGNyZWF0ZWQgb3IgaXQg
aXMgZHJvcHBlZA0KPiA+IHRocm91Z2ggYW4gZXJyb3IvY2xlYW51cCBwYXRoLCBhbWRncHVfdXNl
cnFfZmVuY2VfZnJlZSgpIGZyZWVzDQo+ID4gZmVuY2VfZHJ2X2FycmF5IHdpdGhvdXQgcHV0dGlu
ZyB0aGUgcmVmZXJlbmNlZCBmZW5jZSBkcml2ZXJzLg0KPg0KPiBDbGVhciBOQUsgdG8gdGhhdCBh
cyB3ZWxsLg0KPg0KPiBBbiB1c2VycSBmZW5jZSBtdXN0IGJlIHNpZ25hbGVkIGF0IHNvbWUgcG9p
bnQgYW5kIHdoZW4gdGhhdCBoYXBwZW5zIHRoZQ0KPiByZWZlcmVuY2UgZmVuY2UgZHJpdmVycyBj
YW4gYmUgcHV0Lg0KPg0KPiBXaGF0IGNvdWxkIGJlIGlzIHRoYXQgd2UgaGF2ZSBhbm90aGVyIGNh
bGwgdG8gZG1hX2ZlbmNlX3NpZ25hbCgpIHdoZXJlIHdlIGZvcmdldCB0bw0KPiBkbyB0aGF0LCBi
dXQgaXQgc2hvdWxkICpuZXZlciogYmUgZG9uZSBpbiBhbWRncHVfdXNlcnFfZmVuY2VfZnJlZSgp
Lg0KSXQgbG9va3MgbGlrZSB3ZeKAmXJlIG1pc3NpbmcgdGhlIHVzZXJxIGZlbmNlLWFycmF5IHB1
dCBvbiB0aGUgc2lnbmFsZWQtZmVuY2UgYnJhbmNoIGluIGFtZGdwdV91c2VycV9mZW5jZV9jcmVh
dGUoKS4NCg0KSWYgd2UgZW5zdXJlIHRoZSBmZW5jZS1hcnJheSBpcyBwcm9wZXJseSBwdXQvYmFs
YW5jZWQgZWFybGllciBpbiB0aGUgZmxvdywgdGhlbiBhbWRncHVfdXNlcnFfZmVuY2VfcHV0X2Zl
bmNlX2Rydl9hcnJheSgpIHdpbGwNCiBuYXR1cmFsbHkgYmVjb21lIGEgbm8tb3AgaW4gYW1kZ3B1
X3VzZXJxX2ZlbmNlX2ZyZWUoKS4gTWVhbndoaWxlLCBrZWVwaW5nIHRoZSAqX3B1dCBjYWxsIGlu
IGZyZWUoKSBzZXJ2ZXMgYXMgYSBmaW5hbCBiYWNrc3RvcCB0byBjb3ZlciBhbnkgb3RoZXIgb3Zl
cmxvb2tlZC91bmJhbGFuY2VkIHBhdGhzLg0KDQpJZiB5b3Ugc3RpbGwgcHJlZmVyIHRoYXQgYW1k
Z3B1X3VzZXJxX2ZlbmNlX3B1dF9mZW5jZV9kcnZfYXJyYXkoKSBzaG91bGQgbm90IGJlIGNhbGxl
ZCBmcm9tIGZyZWUoKSwgSSBjYW4gcmVtb3ZlIGl0IGFuZCBjbGVhbiB0aGlzIHVwIGFjY29yZGlu
Z2x5IGFuZCBvbmx5IHB1dCBpdCBpbiB0aGUgKmNyZWF0ZSgpDQoNCj4gUmVnYXJkcywNCj4gQ2hy
aXN0aWFuLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxp
YW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycV9mZW5jZS5jIHwgMTcNCj4gPiArKysrKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2Uu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMN
Cj4gPiBpbmRleCAzYmU4MGE4Mjc4OGEuLmJkMTk2NTk5ZDNkNiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gQEAg
LTE0NSwxMyArMTQ1LDIxIEBAIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZnJlZShzdHJ1Y3QN
Cj4gYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICp1c2VycSkNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX2Zl
bmNlX2RyaXZlcl9wdXQodXNlcnEtPmZlbmNlX2Rydik7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgdm9pZA0KPiA+ICthbWRncHVfdXNlcnFfZmVuY2VfcHV0X2ZlbmNlX2Rydl9hcnJheShzdHJ1
Y3QgYW1kZ3B1X3VzZXJxX2ZlbmNlDQo+ID4gKyp1c2VycV9mZW5jZSkgew0KPiA+ICsgICB1bnNp
Z25lZCBsb25nIGk7DQo+ID4gKyAgIGZvciAoaSA9IDA7IGkgPCB1c2VycV9mZW5jZS0+ZmVuY2Vf
ZHJ2X2FycmF5X2NvdW50OyBpKyspDQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X3VzZXJxX2ZlbmNl
X2RyaXZlcl9wdXQodXNlcnFfZmVuY2UtPmZlbmNlX2Rydl9hcnJheVtpXSk7DQo+ID4gKyAgIHVz
ZXJxX2ZlbmNlLT5mZW5jZV9kcnZfYXJyYXlfY291bnQgPSAwOyB9DQo+ID4gKw0KPiA+ICB2b2lk
IGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfcHJvY2VzcyhzdHJ1Y3QNCj4gPiBhbWRncHVfdXNl
cnFfZmVuY2VfZHJpdmVyICpmZW5jZV9kcnYpICB7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfdXNl
cnFfZmVuY2UgKnVzZXJxX2ZlbmNlLCAqdG1wOw0KPiA+ICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpm
ZW5jZTsNCj4gPiAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAgICAgdTY0IHJwdHI7DQo+
ID4gLSAgIGludCBpOw0KPiA+DQo+ID4gICAgIGlmICghZmVuY2VfZHJ2KQ0KPiA+ICAgICAgICAg
ICAgIHJldHVybjsNCj4gPiBAQCAtMTY2LDEwICsxNzQsNyBAQCB2b2lkIGFtZGdwdV91c2VycV9m
ZW5jZV9kcml2ZXJfcHJvY2VzcyhzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlciAq
ZmVuY2VfZA0KPiA+ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4NCj4gPiAgICAgICAg
ICAgICBkbWFfZmVuY2Vfc2lnbmFsKGZlbmNlKTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgZm9y
IChpID0gMDsgaSA8IHVzZXJxX2ZlbmNlLT5mZW5jZV9kcnZfYXJyYXlfY291bnQ7IGkrKykNCj4g
PiAtICAgICAgICAgICAgICAgICAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfcHV0KHVzZXJx
X2ZlbmNlLQ0KPiA+ZmVuY2VfZHJ2X2FycmF5W2ldKTsNCj4gPiAtDQo+ID4gKyAgICAgICAgICAg
YW1kZ3B1X3VzZXJxX2ZlbmNlX3B1dF9mZW5jZV9kcnZfYXJyYXkodXNlcnFfZmVuY2UpOw0KPiA+
ICAgICAgICAgICAgIGxpc3RfZGVsKCZ1c2VycV9mZW5jZS0+bGluayk7DQo+ID4gICAgICAgICAg
ICAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+ID4gICAgIH0NCj4gPiBAQCAtMzIwLDkgKzMyNSw5
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV91c2VycV9mZW5jZV9mcmVlKHN0cnVjdCByY3VfaGVhZA0K
PiAqcmN1KQ0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX2ZlbmNlICp1c2VycV9mZW5jZSA9
IHRvX2FtZGdwdV91c2VycV9mZW5jZShmZW5jZSk7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfdXNl
cnFfZmVuY2VfZHJpdmVyICpmZW5jZV9kcnYgPQ0KPiA+IHVzZXJxX2ZlbmNlLT5mZW5jZV9kcnY7
DQo+ID4NCj4gPiArICAgYW1kZ3B1X3VzZXJxX2ZlbmNlX3B1dF9mZW5jZV9kcnZfYXJyYXkodXNl
cnFfZmVuY2UpOw0KPiA+ICAgICAvKiBSZWxlYXNlIHRoZSBmZW5jZSBkcml2ZXIgcmVmZXJlbmNl
ICovDQo+ID4gICAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfcHV0KGZlbmNlX2Rydik7DQo+
ID4gLQ0KPiA+ICAgICBrdmZyZWUodXNlcnFfZmVuY2UtPmZlbmNlX2Rydl9hcnJheSk7DQo+ID4g
ICAgIGttZW1fY2FjaGVfZnJlZShhbWRncHVfdXNlcnFfZmVuY2Vfc2xhYiwgdXNlcnFfZmVuY2Up
OyAgfQ0KDQo=
