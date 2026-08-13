Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D7BC5AC67
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 08:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E543510E29C;
	Thu, 13 Aug 2026 08:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhuGYu3+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C50110E29C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkvihuYmEr0CW3V495FNqlCI7UvUmtkCXdotMcghm3PkaZQRGx5SznOP/DrGEDVrY5YX3N/U9xkcJwkJAjhtOBirR7Ps7QVcPIxNPs+Io1MZzdnVS6bbGwXNZ4OkKHgcgW/WSTPfI9x87OQTTNIUbT9G1uJFcunT1neIdBYgTq7FSWrGZmfg9X7RqZMZ7LAOZ/ssOOSfLwPnbe97R4l4RjiOxUQngIpJt0OfxS3FQL6Mj6O3l4f+gEiN2OWwb9W4/PYfzCT2CMFUP/RER8Q1rIKkjZJJgc3uP8TL8nGj1ALtM9F58OAQCqhy7t7Z4bO5hS8GAxvQ35DWKFKvcVFoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQOAzc9KPq2xaPVWTtJDj5dR6S2wlzpoAW9jlO+uaS0=;
 b=QP7Z0cbsL+HVwjWxNZP9Br2ui3kbkw4NnIFv6LaPeRGQFeNHxAxSNvlBJlrU4LGBwu4o2Tu149Tvih5Ncj6n9MFk5Iwix2DtLmy+n+BLq0qUhoVr2QaTdPnESzzR20KCWd3PwvnRBfdnT1LacL8l+qmqvNgrHC0vfaKRFwDRfH7f9pe1BGIK/oTA+ITZp2EwUmll6N94UOSFb37hqj3kYrfwhQylXRJiaXYU2Bc+RM3cmjZg8l6aAxUfaXjhObo6CaG5F8Y65abgKgq+TAM6KBPZYt6+2zgQsz9PB+4iQX0TphtYxPPq62c0Rr3app6O54dNE10GZ5Stv+wMpkaNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQOAzc9KPq2xaPVWTtJDj5dR6S2wlzpoAW9jlO+uaS0=;
 b=dhuGYu3+L+vN2zLvmJYt3N4PB0HsFVvyfYrbT/5eQEf0ps4v1ysZNpSDwAp4lVPGoYlpY9/+r0vU+H6fvqQicV9ohxHnXZ2OtlWGdlItCsptFZkT92QNLH3PPT6DjuVjBNHG2lExflk6Az1+1TyTstHSY+GAdmVPSjYtfVegEFs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Thu, 13 Aug 2026 08:18:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 08:18:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error
 set
Thread-Topic: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error
 set
Thread-Index: AQHdJjQH7M7Z2USK00ac+D5D0Up0CbabpXeAgAACdvA=
Date: Thu, 13 Aug 2026 08:18:07 +0000
Message-ID: <DS7PR12MB6005E7C627EEB20339B7E8ABFBDB2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260807061422.365929-1-Prike.Liang@amd.com>
 <f2418e1b-43fd-4d3d-9f52-10bd50dfe68d@amd.com>
In-Reply-To: <f2418e1b-43fd-4d3d-9f52-10bd50dfe68d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T08:03:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB7208:EE_
x-ms-office365-filtering-correlation-id: 3185da0a-3dbb-49e5-eb74-08def9136823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: 4utJepXu4MhziylR9GcuwkqFkFojBbxCJI1ohGrrAWN89SVGPBLgC2s7sfBT6NsE8PEah6BKDNJx1yTv4I93iP7mRBCXuFRM2WMGMO8eZr/j2KmTUknBXAqNkplJbpxaxzpa0mcg5G6KEgtIIdKj81z6H1BdhlhVn/bYtnX7SMP7CKs61BuFSxeXD7INSoDUsmyfLNBl5uDDhZsM0nlXWiMRFzvgD09gOK/fwWr6CkMiqGcwAbSL/Sp4g2ZQSFzXZDb53a7b77bK1OAxxJYJbK3zzxWTnD/W+y1XlwoYflavRP2toKUqPeN7xNeCTb1kIWdL1WhmJt17kMWmGlR3ySEGAfELgVBfWFyEiJgyH6DRdN66tdR2ihrFXJyjyE+L1sHabMgRzS+R1baPpFQ3hBEm4bh1XX4Y+wGhUv+t6gODoPa9ryLHBuqDjX6nAW3i/dxfS14USqtnLCvq+rtNDHkYZUIsRcdmOQ6qtEN3fvefeP1rMOSJ1bPddeDrp7kfEWebAcGcV3f28f2ksgfLEZ8ShME5hEZY+Hemwxw9l8dYuS8TMp6bmZ0SIDKBXwOXFhXrkWZWD8PyCsDDlABI+R7l5PagQJb0O2EMJ9sG55DO0YBjnh3Z4XrhKImN3WRuBdfvt70FoYfBmwotYTPYj3uvS+bd9fbT+fD9K6swzUJX51HtGtVnNsP4rYNjqrNJRR8ux7j3eFYitPVVw2/8fIcvi/DnM0PGKASv1XESAF0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklDeHhPYWZ4NnNFL0FLUGJiRGF3cVFOMlB0dERoT05JUnVtN1RGTFZWWUJn?=
 =?utf-8?B?cStiT3JhQTh4elV2d0x3V1daVUtLQnFzNmF6NFJYcjZLNkx3WEVGWnhPMjAv?=
 =?utf-8?B?dFIxSmx5UUZBVWdqbHc3ekxVZzVWcjl1L3huRCtHcXlnNkpVb2MwN0dzQ3hH?=
 =?utf-8?B?VWRPV094c05yS0ZUMC9oZHlZSGtZUnZraXh1dm5KcU5CQ1gwbzBFbWJUWkZ6?=
 =?utf-8?B?SVNDbXA1SVM3TDMxQk13eDl0cnJKbmUxRW1JcjBlWnkyOUxhejB3ckhmWmhy?=
 =?utf-8?B?UEVVc0hCa1BwVmJDTFA4ZTBSSFBWVVFIMldDZEc5d296THc5cmEvVEdDb0NG?=
 =?utf-8?B?QXI2SjJGUldINVV4NHRQc0NVQlcvbE5kOVh1NGlqWUFpaWd2ZW90UWVGd2g3?=
 =?utf-8?B?YlhxVVpYeU84V2xtK055OG1Xb3U5OHJOeDMwRzlSZnhiRVBwamMyemJJT1hG?=
 =?utf-8?B?dkR3dmxKeGttODBtSTBuZFQyOHdBam1oOElQMWNBMUFLWUtRdStWSExRdjlQ?=
 =?utf-8?B?SkVWQmxlRDBFRGxFaVhJMkd3L2N0TkNhU1ZGUXFQUWpLZ2E0akZVQVJ4MXdD?=
 =?utf-8?B?cmJoOVR4R05NNyt4VVVDVG8wZ21qclhjM21hOTE4Wnpvc216SGp2YzRNWVJW?=
 =?utf-8?B?aXlPVDlKSkpyek5ZYm5KY1hkbmdKMFZGRXRLRDB2KzNhUmt4UkwvOGhvdW5N?=
 =?utf-8?B?L3VVZnZZQ09FV2cyT0tnSERWdW9wRGkwZnBMeWtuWnhEZ0FvNXFaY0x3d3kx?=
 =?utf-8?B?aW81d2NQRkZadWhpcnN0TUZJQVMzeWxCSWt6QkZFd3lzWVQvRWpQSFQwSXAw?=
 =?utf-8?B?N2tYS0xhRmZZUElWZVMxYW5MY3RkRlpQUjNxY0I5NGFKbGd5bWp0SjdKdkww?=
 =?utf-8?B?dnJudDgvMUJYM3k5MW5UWHdQSW5ZaTVxS1ptU1Q5b2ltNWh0eXNzUTN6NElv?=
 =?utf-8?B?NDRxMkNGT09YdmRlck9VWjI3L290WStsV0wyaFN3M0ExTDl4WDIxaEpSU3ZK?=
 =?utf-8?B?U1h4RzBBNzI0d1AzNjEvWjNISDZncGNxcDRtbFNGVVhzZitBV0tOTGYrV2VH?=
 =?utf-8?B?Zjd1NGVEVnhCUHlpWEdqVVZiM2hORHJmZXNhaWdJd1JYRWhDcmZQUEZ3MjIz?=
 =?utf-8?B?a2Zlb0h1aVQ4NVNPbXJaWndUQ2NGT0UrdGQ1K1hOZGhjU3FIVTFIVEk3OEJw?=
 =?utf-8?B?OEozVzVqakV1bnpUaU5GQ2xPcmxSTzJqajNUWDNSRSsydVQxb2xyeCtFakdG?=
 =?utf-8?B?OHdmNEhLNFVVSHdBckYybTZqVFNneEdCckFEbGhkZ0c0dEluV3M3dEc2OGZi?=
 =?utf-8?B?R0JTN285OE1iSWVPYU9wMUxkaCttQjNUYzVZanZKNlRQckxRUFQyTDVrOEtE?=
 =?utf-8?B?YjJ6bjZzV04zaXZaTm1ZSUVzYmNPMXE4OS8ycFpEM0RhOGsvWjI1cW9GODNq?=
 =?utf-8?B?SUtzcjJneFBSS1Z4RDFaZHVjaEJsZXF0clk0RWQ1czlMZnUxc3hMUW5oUEUr?=
 =?utf-8?B?NVJzVWt4NTRydE5MZjZDZ05OWUVWbGtjQTltMWpteVZQMUZyK0g0eTZ3Y1o0?=
 =?utf-8?B?dElrRUdpRkRJbmVQL3JNbEpTaWZlM0VjUy9MZTN0N0dKejgwWnArL2htSlNx?=
 =?utf-8?B?aVAwMkRNSE1zeG1jNWVjZkNTYUhyMjVpZjdpN2pOeE4zVkZOR2FyR3ZiTXho?=
 =?utf-8?B?TFluOHpZbTBUZC94ekV0SDRuZFdjdXc3MW1BaWQ1a1JZT0hYUXUyMkRCWGt5?=
 =?utf-8?B?RWl2cjJVK2FjNHhUb1MyenVBaHdYUzhWS0F5eVB2Q0RWRmpkeUZSaWVmUk0z?=
 =?utf-8?B?dkcvL3NtQ2VwL09veGw1SEdoT0ZPdWlTenk0a1p6VVZoS0x2ZmhhK2MzRUls?=
 =?utf-8?B?V0ROemo3YUIwc09PamhPd0tUQUZhUk5jZTR5UU1mS3BDdFFoVHJPcHE0c0R0?=
 =?utf-8?B?RUd5cVNnZVZja2FiODhiTVlnOGtUWlN1cE40TmxKT29WekVsMUJWWngySDNw?=
 =?utf-8?B?a2FhdzNzcTZVR2xtcktHbGdUdy9LdXBFZUlhanZIRTRFTENEYnovalEzNlYz?=
 =?utf-8?B?TTNMVmVRUCtEcGhGV3lsRHh6eDJLRk1oSEJrWFovb2pCem1GRzhnRXBUYi9q?=
 =?utf-8?B?WWxlTDJFVnJmU3N0Y01RZ0Jzc201NmtKQ1NSekE5blMyaHRsL3gzVnBBbEhR?=
 =?utf-8?B?a3I4Z1hQUVYxeGlZR1JpVGZhM3RVeENyckVVcmcxbkR3eVB3V1pubzFURW1q?=
 =?utf-8?B?cGkwVUdjdncxeDh1aEJjelZhNjRiNzRlWnRJamNYU09qSGllZ3hCakJqdWls?=
 =?utf-8?Q?ySjf80NkJ8zOr1XwVl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3185da0a-3dbb-49e5-eb74-08def9136823
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 08:18:07.9996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqFhrDPmyRtMrophzCCbSH1IvqMtYpezKLLfuK4IzMUhdRTaSY3Wpp/s2d7qRn6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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
YW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMywgMjAyNiAzOjU0IFBNDQo+IFRv
OiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBmaXggbG9j
ayBtaXNzaW5nIGZvciB1c2VycSBmZW5jZSBlcnJvciBzZXQNCj4NCj4NCj4NCj4gT24gOC83LzI2
IDA4OjE0LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVy
KCkgYW5kIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZGVzdHJveSgpDQo+ID4gZG9uJ3QgYWNx
dWlyZSB0aGUgZG1hX2ZlbmNlIHNwaW5sb2NrLCBzbyBsb2NraW5nIHRoZSBkbWFfZmVuY2UgbG9j
aw0KPiA+IGJlZm9yZSB0ZXN0IHRoZSBzaWduYWxlZCBzdGF0ZSBhbmQgc2V0IGVycm9yIHN0YXRl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cV9mZW5jZS5jIHwgMTUgKysrKysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+IGluZGV4IGU4ZGU2
NGY4MzU3ZC4uZGI1YmZkNzllYzFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBAQCAtMTkzLDEyICsxOTMsMTIg
QEAgdm9pZCBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2Rlc3Ryb3koc3RydWN0IGtyZWYNCj4g
KnJlZikNCj4gPiAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmZlbmNlX2Rydi0+ZmVuY2VfbGlzdF9s
b2NrLCBmbGFncyk7DQo+ID4gICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShmZW5jZSwgdG1w
LCAmZmVuY2VfZHJ2LT5mZW5jZXMsIGxpbmspIHsNCj4gPiAgICAgICAgICAgICBmID0gJmZlbmNl
LT5iYXNlOw0KPiA+IC0NCj4gPiAtICAgICAgICAgICBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxl
ZChmKSkgew0KPiA+ICsgICAgICAgICAgIHNwaW5fbG9jayhkbWFfZmVuY2Vfc3BpbmxvY2soZikp
Ow0KPg0KPiBQbGVhc2UgdXNlIGRtYV9mZW5jZV9sb2NrX2lycXNhdmUoKSBoZXJlIGFuZCBiZWxv
dywgdXNpbmcgb25seSBzcGluX2xvY2sgaXMNCj4gY29tcGxldGVseSB1bnNhZmUhDQoNClNpbmNl
IGFjcXVpcmluZyBmZW5jZV9kcnYtPmZlbmNlX2xpc3RfbG9jayB3aXRoIHNwaW5fbG9ja19pcnFz
YXZlKCkgYWxyZWFkeSBkaXNhYmxlcyBsb2NhbCBJUlEsIGRvIHdlIG5lZWQgdG8gZGlzYWJsZSBp
dCBhZ2FpbiB3aGlsZSB0aGUgbG9jayBpcyBoZWxkPw0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UN
Cg0KPiBBcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0byBtZSwNCj4gQ2hyaXN0aWFuLg0KPg0K
PiA+ICsgICAgICAgICAgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkX2xvY2tlZChmKSkgew0K
PiA+ICAgICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3NldF9lcnJvcihmLCAtRUNBTkNFTEVE
KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9zaWduYWwoZik7DQo+ID4gICAg
ICAgICAgICAgfQ0KPiA+IC0NCj4gPiArICAgICAgICAgICBzcGluX3VubG9jayhkbWFfZmVuY2Vf
c3BpbmxvY2soZikpOw0KPiA+ICAgICAgICAgICAgIGxpc3RfZGVsKCZmZW5jZS0+bGluayk7DQo+
ID4gICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmKTsNCj4gPiAgICAgfQ0KPiA+IEBAIC00Mjgs
OCArNDI4LDEzIEBAIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfc2V0X2Vycm9yKHN0cnVjdA0K
PiA+IGFtZGdwdV91c2VycV9mZW5jZSAqZmVuY2UsDQo+ID4NCj4gPiAgICAgZiA9IHJjdV9kZXJl
ZmVyZW5jZV9wcm90ZWN0ZWQoJmZlbmNlLT5iYXNlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsb2NrZGVwX2lzX2hlbGQoJmZlbmNlX2Rydi0+ZmVuY2VfbGlzdF9sb2Nr
KSk7DQo+ID4gLSAgIGlmIChmICYmICFkbWFfZmVuY2VfaXNfc2lnbmFsZWRfbG9ja2VkKGYpKQ0K
PiA+IC0gICAgICAgICAgIGRtYV9mZW5jZV9zZXRfZXJyb3IoZiwgZXJyb3IpOw0KPiA+ICsgICBp
ZiAoZikgew0KPiA+ICsgICAgICAgICAgIC8qIG5lc3QgZi0+bG9jayBpbnNpZGUgZmVuY2VfbGlz
dF9sb2NrICovDQo+ID4gKyAgICAgICAgICAgc3Bpbl9sb2NrKGRtYV9mZW5jZV9zcGlubG9jayhm
KSk7DQo+ID4gKyAgICAgICAgICAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWRfbG9ja2VkKGYp
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3NldF9lcnJvcihmLCBlcnJvcik7
DQo+ID4gKyAgICAgICAgICAgc3Bpbl91bmxvY2soZG1hX2ZlbmNlX3NwaW5sb2NrKGYpKTsNCj4g
PiArICAgfQ0KPiA+ICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZmZW5jZV9kcnYtPmZlbmNl
X2xpc3RfbG9jaywgZmxhZ3MpOyAgfQ0KPiA+DQoNCg==
