Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A36AC88E75
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 03:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7E210E2F4;
	Wed, 16 Sep 2026 03:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFkD/k4D";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB2E10E2F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 03:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo6CDEl3dks86yEthCgjS51YnEQXSuBTyZ6PNX4ggayavC4tF/1QpT1R8iN6UAvWpxiXzlCSgBt+gaVLf3c69BXx6HscV00CfrqnaByuvXdK+j+IS5UUaltgHV4+Nkk9ccmWeabCuYw9cYLHNG7y5VkNrmzb+ho4VoqFe/clvwzSRjRq+pROEe4hDCJDLVTXPbdZG1sPgyGpcrizyXUlFWAPZoyg7aHMAEZa/N0G1yaTu++f+RvqfPNtChuVUtbyBxU+dZxMJtPZrCcCdfTDwRQn4hcG0tXb2p6DHNb2KNTVXBcTIlJ8On49AO16VMtiQQSghP6Ur0gaRElNbE4Lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW77gxlC9st37yQwz/5fdl6Or20Hhbja1QePGU+FGko=;
 b=ip/vIAgJjKzENxfZL+lOhSjlNIk5dcW4nM5AH4SwcBXblB0j6ZW4lvCup9OXJ0JlNboep9h7QI4GiPpi3VzU0wOXPtmV9dlekysYdtG+kI3UiyHyvQWYtEhf+D8hXt11lPTcUMm6wIJ5M26XcSMGlSN898+z3Ov9XFxKN6cA+1uL1WMZyt1HZsLrsAhsw07LqI/ZWyooWejvzyuEOB7vwNt6EtamVpOCs1TnVo4tnTGatYaTbIIl1B6d+dY6BqHxdcIoK5wo71OM3GrSm/rPWpMmZVPjhw/IA3fiMFJ0Y+SQcK5SDcTqjbj5nd5LsDueDUVXupByL7OejVbj6njF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW77gxlC9st37yQwz/5fdl6Or20Hhbja1QePGU+FGko=;
 b=dFkD/k4DiADVopANXlQ10LTjUrVIo0QGzXv1a3/aUGQdjh5zZiOSNFaN5rceIZDFBbDpFC73nhp42Z++Otlg3VBLbwYMc3//UMEjoQOlZHSMPPYrP5whCq++tpNQf1pGKXHgsMghEIPT5+ki4REwK4oYe+OWZVaTllRmDjqImSc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 03:38:40 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 03:38:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
 hung user queue
Thread-Topic: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
 hung user queue
Thread-Index: AQHdROKq5LQe8E8Vfk6Hvw/GiuXcxrbPq/EAgADetpA=
Date: Wed, 16 Sep 2026 03:38:40 +0000
Message-ID: <DS7PR12MB6005BB1C3565E77FA94DD005FBB92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
 <20260915071946.710846-5-Prike.Liang@amd.com>
 <633738ea-bde0-4658-83e7-9cdf0f47c2e5@amd.com>
In-Reply-To: <633738ea-bde0-4658-83e7-9cdf0f47c2e5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T03:19:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV8PR12MB9110:EE_
x-ms-office365-filtering-correlation-id: bdaae3fa-c9ae-49f4-82aa-08df13a40004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|38070700021|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: PIUiKrB/RdwavsHnDACD8A+zWHE3QENJEGIcqrQUhf+fSwOrREP7VaxXHBKWNOTQF6aFar3ldQfuyeHONaucVtHHNyyDRYCjW6vKkH92+VtmSNGWZqPDqctkpthMD0Y3ZBAYx5C/hkP8cR9XnXRvsfeqMZtg5e5XXFCQCTlfVEJ+ZffSZOEtKwMbbIpwpeiwHOiAsXbu0WEN+7WetVjT5aQusOqLuR1S4eNyDP9msZ3ueuoRAiQROehmn9vHpAUxfwodB99gD6Vm90vvhBFfHXhZCaEbOMiKt9iwFZXW+rjHlTrl44K8uq6K/FhjnlC3b2bC86aMbysr3F4XIXKxOxkAcdQe2sZ2ko/o4ad0p2kRSjbf4XguOtVzwJkGmK4rRXInhLVpYEtrfDejGgR1oIcQyR8Vy0UcHw/Ej1Kqk22xgULA1G6zaroadek+XfekjEM4QLu5N3S3prBQMGEePvHBlVSaNs8ul+GpjNWDJGMZvsJXdYgq+VZQGeN53JqMVWOjI+oAc3xhV1oaEnBZ8J8GFdIkhLLyQMXLB903nC6ENtMNuVKog0DlMdIO3g4j7tvDedM7HwpCn9uB9VbhQ8hLWPKUr9GLBZgXRY+Nfk4wAso38ql3NryT682kQVfdLUgD0n5lTLTuvRt/rxobeERDNacSLhljSUk004LUyTcypxYuzzfZRqUkuLc1JXIIjyvjN9z34zC5apXeEoyI57P2tmKYe2KKWY72J8v7Cmw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2JRU2tWV2pFK0FWUWpsMFc1eVBRUVNYakQ3QTFVSHBpaEhPVXFoTEE4ZjZr?=
 =?utf-8?B?VUpWbEFxdzJyNEM5clRZQ2ZQMVdsNUxTNmU0SHdwMExwRXhjWXNsTHNZZytR?=
 =?utf-8?B?WTdUNWFhSmZFN0NSZzhTR0MxOEx2QWI4bXAxVXV2dnB3NlhyTVVYWlQwUUZY?=
 =?utf-8?B?MnZBeXRsdFF1TlR6L1RzUG95RW9aVmhQTDljOU9KUW5IV1Q0R29PSnBmd0lw?=
 =?utf-8?B?TjRrUkJnV1JvTzRTb2NOR3VvajVFTkZTYUZJM29Hb3UxTXEvOUZpNTVhUytL?=
 =?utf-8?B?MlROZDRHYndZNHBBNXlwTWJrZ1VUT0paVHFNbU0vK2dqRHNDMDdiSFNwRUNT?=
 =?utf-8?B?QkkxcFRGNTdlNnJ4d3B6VHFWU2VhNVdCaTZKazVnUGt4cEIzV3oyRldxTEdq?=
 =?utf-8?B?bk4rbmRPQnlYQnBLR0t1MGJZdklVTDkzeERVc3l4Q3d5UE9qZnc0L0xWRE9X?=
 =?utf-8?B?b0l5d3EwamltaEhKRTlVUGlUSzRXeWg0dFN4b1J2RFRlS3QwN3hOeTZ4UWZG?=
 =?utf-8?B?SjB5R093OU5iUmdadGNFWjkwcnhuenFBZFIrTjQzcE5oa3FIUmpNcDF4MWI5?=
 =?utf-8?B?RDNVbkxPZFFId3UrZ1RuRjlMYVVFbnYvd0tQam5sZWQ2KzJnOTVEekJvVmRy?=
 =?utf-8?B?bUZEMnZCT3lHOHJoYmFEdkpaQ2sxelFxRTVUUTB6OTlHU3l3R0RsWGNMTFh3?=
 =?utf-8?B?ZnFHSjB2cVdLbVNXWkRGaEF4aG5maXJDNk04Q3dYY3pGdUpqS1h0eCtvQ0ov?=
 =?utf-8?B?S2g4U3dkQk9Tdng2MkNWV0M0UGhvWjlacXNNNWcwSTdoY2p2SHhPaTVqVUYw?=
 =?utf-8?B?QXB1VUY4cThxcmJmV1J1d0JLc1I0ZzZYL3J4RWV5L2U5OCthWmxVamVwenhB?=
 =?utf-8?B?Q2FrMENQS2lZclltY21DS01sYlZxN0F2OGRKQThORWdtNGlqb2daeEFHeTlB?=
 =?utf-8?B?OEhrM2dIODltQ0Q2eHo1Y3V2YldteUlZakxPZUpzNXczWFdIRnJiYm1mTGwv?=
 =?utf-8?B?d1JuVHVQM0htcEdDb0h5M2FMd2ExTjh3a0RyRnFJZ0RCN01ON0tHd0pEOUJo?=
 =?utf-8?B?NmhVNkdEUlU0YXRvS0FQM00ybTlzSlc0VW9vcDhHcHdGVkV3dHR1dC9NWlpO?=
 =?utf-8?B?S3o2WTZRV3oyRTVIMm5SZktoSVdTN3VVdmZjSk1qMFluMTdXRnNtTEVIcWdF?=
 =?utf-8?B?UnB6R3dJbG1FM0xMUktHM2kydzJBU0kvdStacGNRaFFNUlZRVkJYdTJxTG5E?=
 =?utf-8?B?L0c5VGhrY0xqZmp6Q0QyQWJUMitMbkt5NTlnaHdWbUZDNGFpQjdaMUc3SVN6?=
 =?utf-8?B?M2M2L3o1NXBWcWN0OS9JUVZoMHBIaEJmb2hOQi9VWW1MbkpGdnFocVlmN1VM?=
 =?utf-8?B?eVRBSFFlcGVlMWRra0hmSXNoMWk2ekdyTGNUby9HNEZGSlg0MW04MXBsaXpm?=
 =?utf-8?B?clZlZDl4aGpJamRCRWt0cDZ2QmpPb0NhVFZDMWZ3VEEvWUNHUGFpNkRyTTVv?=
 =?utf-8?B?REpZUUtUN3Ztb1E5U0dlVkUzK09ab0ViVWJwVit4MUp6c25MZlVBc09UREpI?=
 =?utf-8?B?MEZoL3JKQUdmek5Yc0g3b3J5YU1SbTRXdmsyWVNCSUZZd1I3bFFqUGFzRzBL?=
 =?utf-8?B?eWtNVm9wbUQ3Z0c0NjFvNGRqZmZzMDBHVnptZmI4WDNDdlhuMUoxVmRPc0RK?=
 =?utf-8?B?WndURTF5YVQ0UW11bks3ekRLdnZmZE0ra3ZOeTF4ellNNGFxUzczRW5vQk0y?=
 =?utf-8?B?NWh4YkFPUzRMYUY3QjFFcXgyOWhuMjVHMnNZWUgzZGdmWGgrWGd2SFV2U3M4?=
 =?utf-8?B?SUh5a1dBRmdJVmcvdmlwQjlFSWtOdkpjaFZvdndCRStHRkZsZE5jQzFFUXRQ?=
 =?utf-8?B?VVZpa0hZcUpzM1J6aFB5c2haMXowVngyOHJaZ09kajFDSnY1aTRyR2gvSUQz?=
 =?utf-8?B?ZHpidTBJcWpmRVhpbCtNakp6bHVYa1kxZGtrU0ovblhLL1lxN2trbXZzMDln?=
 =?utf-8?B?R3hQUWZFYjRSZGUzZ05NUTJCSlp2djdCT1ozNGt1YldYQi9tcGlBemIzdml2?=
 =?utf-8?B?VFhTaDJlcDRZRzdOdVFDRzJ3cG4wRFJMRWpLSDg5V3VDWXM3SWQrZWhTMWZX?=
 =?utf-8?B?VXB1Vlo2Zm03ZXpPQzkzeDJKcktRL1RJQjZJRkgrWWJVdExUam1hRWM1aWJL?=
 =?utf-8?B?NHYvTmJiT0lOV1I1c1pWNVNDeGRBSnR1a0Z0Vm83a1YwR2lXWFZpK2pRVDZC?=
 =?utf-8?B?VEJuSk0ycFV5bEtpZ08yTlIwcTFET2JCK2hzVDBVNEFObzVMckNFRDhkYmRq?=
 =?utf-8?Q?oY8xioWgqzNXETReVb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaae3fa-c9ae-49f4-82aa-08df13a40004
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 03:38:40.5256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJlarF1ZRuZrY7Qe3C0cuYmiBPH4jHUmPteQGccux44oquqr9uIgW+W6pwP01S7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE1LCAyMDI2IDEwOjAzIFBNDQo+
IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgUGVsbG91eC1QcmF5ZXIsIFBpZXJyZS0NCj4gRXJpYyA8UGllcnJlLWVyaWMu
UGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzVdIGRy
bS9hbWRncHU6IG1hcmsgcXVldWUgYW5kIHByb2Nlc3MgYXMgZ3VpbHR5IGZvcg0KPiBodW5nIHVz
ZXIgcXVldWUNCj4NCj4gT24gOS8xNS8yNiAwOToxOSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+IC4u
Lg0KPiA+IEBAIC0xMzIsNyArMTM0LDggQEAgc3RydWN0IGFtZGdwdV91c2VycV9tZ3Igew0KPiA+
ICAgICBzdHJ1Y3QgZHJtX2ZpbGUgICAgICAgICAgICAgICAgICpmaWxlOw0KPiA+ICAgICBzdHJ1
Y3QgbXV0ZXggICAgICAgICAgICAgICAgICAgIHByb2NfY3R4X2xvY2s7DQo+ID4gICAgIHN0cnVj
dCBhbWRncHVfdXNlcnFfb2JqICAgICAgICAgcHJvY19jdHhfb2JqOw0KPiA+IC0NCj4gPiArICAg
LyogU2V0IHdoZW4gYW55IHF1ZXVlIG93bmVkIGJ5IHRoaXMgcHJvY2VzcyBpcyByZXNldCBndWls
dHkgKi8NCj4gPiArICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBndWlsdHk7DQo+
ID4gICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJvY19jdHhfYWxsb2NhdGVk
Ow0KPiA+ICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICAgICAgICAgIHByb2NfY3R4X2FycmF5
X2luZGV4Ow0KPiA+ICAgICAvKioNCj4NCj4gQWdhaW4sIGNsZWFyIE5BSyB0byBoYXZpbmcgYSBm
bGFnIGluIHRoZSBxdWV1ZSBtYW5hZ2VyIGFzIHdlbGwuDQo+DQo+IFdlIHNob3VsZCBub3QgdHJh
Y2sgdGhhdCBoZXJlLCBlc3BlY2lhbGx5IHNpbmNlIHRoZXJlIGlzIG5vIHdheSB0byByZXNldCBp
dCBhcyBmYXIgYXMgSQ0KPiBjYW4gc2VlLg0KDQpUaGUgdXNlcnFfbWdyLT5ndWlsdHkgd2FzIG9y
aWdpbmFsbHkgYWRkZWQgdG8gdHJhY2sgVlJBTS1sb3N0IHJlc2V0cyB0aHJvdWdoIGFtZGdwdV9j
dHhfcXVlcnkyKCkgc28gdXNlcnNwYWNlIGNvdWxkIHJldXNlIGl0cyBFR0xfRVhUX2NyZWF0ZV9j
b250ZXh0X3JvYnVzdG5lc3MgaGFuZGxpbmcuIElmIHVzZXJzcGFjZSBzd2l0Y2hlcyB0byBxdWVy
eWluZyB1c2VyIHF1ZXVlIHN0YXR1cyB2aWEgYW1kZ3B1X3VzZXJxX3F1ZXJ5X3N0YXR1cygpLCB3
ZSBjYW4gZHJvcCB1c2VycV9tZ3ItPmd1aWx0eSBhbmQgcmVseSBkaXJlY3RseSBvbiBBTURHUFVf
VVNFUlFfUVVFUllfU1RBVFVTX0ZMQUdTX1ZSQU1MT1NUIGZvciBpZGVudGlmeWluZyB0aGUgY2Fz
ZSBvZiB1c2VycSB2cmFtIGxvc3QuDQoNClRoYW5rcywNCiAgUHJpa2UNCg0KPiBSZWdhcmRzLA0K
PiBDaHJpc3RpYW4uDQo=
