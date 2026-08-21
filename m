Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23E0C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E12810F27E;
	Fri, 21 Aug 2026 09:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VvY4rXnR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A583B10F27E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC9HOsGxnTtRBp/xJT9roar4XNEthEOS+kJIZur7KxVa9wVQIexRvfnwja5C6vuMBVzUmtJYO2YLPPiDAVkooB+/s4s/J2DCJyBZGThCgSRCh8EugTDZaYXvABLYOq72s/XG3+wV+8MTBJXhTqwdaFcvrqbizoh7N43YxCstqTNShgu4RxDjKiL7UTpIbbO+JlzoUzPvp3T5PZK5ZVa+W3eC9FLxE4wvecOly4oHW0fFQKGVMmqjkNVPPlQW1U8N9GpuCiO+zkJyemPWCfVexsKuuNHzk52ppjw46nfVQGbOWEg1ur5yEg90MnxAlaW0c2QxTSNZYVsTp6ZPn+JiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EATHobJFPKAZ8+2v8L8bx4pVFAd3QwlRTJt9dlEe8Y=;
 b=zO4L8CvMHP/QpSnjO+m8VNtKkdlIJr2tRjxHY0iRZ3fmqo1X9Cy5fZZ4JkWj0yNS+ifJY/ZTxAjT7Ikm5tYv5sChEn+QdVlpkLNIss0QhGfC6P0bEwdAkXhSVtOLVLIX8JYfzCufOTBj7ZfDsmEjrnxYyiifLupm06NWKFLpY+TCQDC+BGjU6CT3bKc0nNLxreggHNdREt7l9QAgXXwCtkqUkBM+vTZdzoAi9IE85seIPv4pWo/rN4BtkbNWEvuEYOhfXfpVbqMIE+AWSNzxK3h0yyCyz6+4QNVsNoxCOpxBTNldBYGT+z4xWh8qFxiVnx7wN7K/OY3JQeZnoKGUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EATHobJFPKAZ8+2v8L8bx4pVFAd3QwlRTJt9dlEe8Y=;
 b=VvY4rXnR5Rt7DCmd/yg6PSNXuA03vC99SH2Jg/uUVmdtZ2PazYj+oD8rWt8jhxrkEruh8684yDiHGk3+A0Ef2k3WC5N/p6pAG4K3EDWs0fyio/0n3+gfgdCWtZnDIsgqSEGDNN+Nvi3OxDI3j05Z/yfpFjeKqHtqWbqaP40WZ60=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Fri, 21 Aug 2026 09:09:42 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 09:09:42 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
Thread-Topic: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
Thread-Index: AQHdK52lu6cNuxwavE+gPq8QvqJlL7aljgqAgAKyOaA=
Date: Fri, 21 Aug 2026 09:09:42 +0000
Message-ID: <DS7PR12MB60058101B79694CFFE687FC8FBA32@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260814033302.406402-1-Prike.Liang@amd.com>
 <CADnq5_OMJpBgYYev6nBf7BJD-+WxPc5YS-42vHkxQH_udD5hCQ@mail.gmail.com>
In-Reply-To: <CADnq5_OMJpBgYYev6nBf7BJD-+WxPc5YS-42vHkxQH_udD5hCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-21T09:02:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4331:EE_
x-ms-office365-filtering-correlation-id: aaa22de3-6ca5-406c-0ffc-08deff63eff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|38070700021|6133799003|11063799006|5023799004|4143699003|10067099003;
x-microsoft-antispam-message-info: rEWNlQdYqhv2nhFDXJgRBXujtwB6YnCBwEfxg0+kknoh742bH3c2Y5Ywhh1I2YjPIWIE6aO1B0RZsa2Iot0eXcZVfLvSpY64DaZemqm+gOUk82gH0CgRp/LKDDQtcMe5yM3R5C+i35PQS8oiGVvcpJcsj8o+7zGHureyXE6CXieaGPfJ+9QSlvklHqdXxHcUiz0Lnc7uwKhXgTWoAE7HG6AB4u0yQBOB7886xUHIlwpJxmVEmY4mmKX9JeOFEhVk0npAF3IubbzNGx9NXkiQaYXOkeiupX3bhoHAMGMt5esVB1Kw3iolKH5hllcEujyk3wChcgiX3r7ltour56VYWCDeswqGuDREiQykXo5xTHW6A2/lwbbpm1U8pG91Bem8bkWHEVkki3TrKwAWoDPctYNu/nFntLk59R4TEy+fo1V7UKeShXL5QROuZrIUm6UUoZ1BDGEVjy7Mh3hIikLgUJVoM/sbATXClRifxcv7/aDmQypGCXjPTJ0alqznOVjTRkPVDvJFXOPF+uS6+W9+2ZXgH7NalhvZXGjfatbeznklJ5CgNRknjuRzsVhB+Howa4N3un0M1DP+l4Os55VWtTDho0QtPc4qK+5m/4It50QwPdywVKw15KdSj1tT0/oVL3r5YX2LSgGUnCnULtKMhPH2OPf42YoQV+agwbCJ2jtIy+immALM1rnFIFk9pPzDefPtUqxs05e+knt8rvDDpJlVKNMZyL8ZVcjtcOsxWUQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(11063799006)(5023799004)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtKSVJvRzNaM1BDWmoxTDE5WXBzZ2Q0dmRScjluc2h5U2hPRUE1Qjg3NVNM?=
 =?utf-8?B?Wmc5RXgrampKSVd6RnlnOEFxRWh2L3g2bkRpd29VKzNPRk5FU0E0OVR1WlpP?=
 =?utf-8?B?TkRYVi9IOFhlS0VQalBaKzFXaHlIVlBoTXJrSFZxcG1ZSjMweno0L1djWHow?=
 =?utf-8?B?ZzFPWVBvYnJqUWRKUVZ4eFZETGY5V3hyVW9UYlp1N0N6QTdOUGhwTnUyVlpa?=
 =?utf-8?B?c3dBaEpQc1dHOHdnWTUwMHpqMXFkeEdnTlJmZXoxckRiYm9vd0pLVjNDSU13?=
 =?utf-8?B?dzVWRUU1UFBkdlFhV3liZkIyWEdBcTJ3WDdzZXdYNk1DTnBUa0U3TEIvL3dI?=
 =?utf-8?B?b3M4NGRvKzF4SzBuY1NpWk5jaVlVNngxMVBOMjBaTDFKMzlqbjYwb010bW9N?=
 =?utf-8?B?N1EzTm4yK3kvREhZSEIxWFVNQWtBMkc4Y0hjclVaNHBCOVN2VjBvWWtBWHM1?=
 =?utf-8?B?SDBSa2dDWW5LMlUvOHo4Y0hGMkFuditYcjFMbFhyaEU5SWdZU0RyaEpYRktP?=
 =?utf-8?B?UUN2a0xyeTcvL3BId3pmc3FTdUhUaGhNYzBZS1VhMVlLWE1FTXhIQmErdUdZ?=
 =?utf-8?B?aWxuZkUxcmlxKzlQeXJlV0xnWnlOTVJEM3YrbGFOVWdlUlkvbkhCOTNGNWRa?=
 =?utf-8?B?ejV6OFB1dXAzNzYxbUd4bW1GY3Fld252My83ZkZPcHFpQkZEMkEyMVAzOWd0?=
 =?utf-8?B?aXM5UDdISHNGVjdZOFB3ejQ2aUVQaWd3a2NQU0p3QWIzV3RTelNJcElib1Z2?=
 =?utf-8?B?LzNUVSsvK0g5UEpBb29yUzlvS0Q3clJvQlFaME5VeWNkcVZIelJqOVE2emxo?=
 =?utf-8?B?VFJoZmlrb2xRTzFDSWlNa0NtQU9GSHAzaC9pWW1iMk52UlBZZ0lxeG53UnZC?=
 =?utf-8?B?Ky9RT1ZWNUdxSDFvNzFQL3FacXdaQ0Z3Ylk4ejZMVGJMbXJwZ1FDbit2ekhS?=
 =?utf-8?B?SmIraGh4djdVOFJ0dHB5NEtWc3dla0UydDd4MmU5REt3S0VpS1VzcVVOZTVY?=
 =?utf-8?B?bmw1UVAwTEtrYU9EZUtnYS9US00veU5NV3BEYXBZbGt0MGlMZ3hHRmhRekFW?=
 =?utf-8?B?dmV5U1FON1NtOFY4QTROTCtXanduM0d1eWJPVlRSTDdHYVE3VDdXaFNUWUJw?=
 =?utf-8?B?WFNoN1NLcXFaR1JTZjZsbXIyaSs3b3RBWE9iaUljK1dtT0ZRNGQ0N3BBOHJP?=
 =?utf-8?B?eW5UelVDZk14U0dvRUlCZzZMcHBVdjQ4YXNtRi9ETW4venVuTUlNNEV3UThQ?=
 =?utf-8?B?cHR3Ymh1SHpieFc0S3FUUUZBa2dBWlppSWpadGdRSHBWL0NIT3kxNU4wcXFj?=
 =?utf-8?B?Um9pZlBCaklhekxqRVZVZkJKemozMElpWVJZbjltQkxFM1FTMnhsM0xLdmFa?=
 =?utf-8?B?c2lyb295ZlA1ZDIzL29tVVdrdG4zVXNSMldjNUk2RUtkQ1ZuM2JNbWVJRVVI?=
 =?utf-8?B?OXJNNmZwZzVuUEM1YTdGT1JJWXhtWTNHeXA5UlZDSjJhZkkxdHFmdjR1NUdC?=
 =?utf-8?B?NmNvVEdZL1RFMFRIY1p1WXRvd2o1QWd0bTdzWUhDNFdXRjRHUWdSdkt1R0xx?=
 =?utf-8?B?NWtJWFN3OFZrQjhmNEhTTmovYXVQUjlhclVuRDhMZ2ZOcHlBT1B2SGhQdlBS?=
 =?utf-8?B?ZWVLQmNjaC9waElvT3hBaXV1cnAzcFpKbGJINDdDMEVGaTJ1UDVnd3h5bjR4?=
 =?utf-8?B?eG5IVE15cUg4S3lQVnFRR2VIRnJyRHlvNzQxaklIVXNUMjg3QkZ4RGErMWdT?=
 =?utf-8?B?eDNCM3lMOE1DZzlNWm9FanNaOHd1bEJDWWJKNjdzWmJ5T0VmWGYzUllVeVRi?=
 =?utf-8?B?TW1yd1FKU3NTWCtOdWFzeFBQWEdaa1M2Z1RTTWRpZzFqMm1FaE9FVGlmWWRD?=
 =?utf-8?B?SGdkZm5UWG43Z3dTemhYbTQxb0Q0a3VPelpFbzR3OWVvZW92a0ZvWk84Rm5m?=
 =?utf-8?B?bVVkVVI5T3NBMkpSYXhTRXRIY0QwRk5makdyNXVCMFlpYVZmMmVMM3pVR1FK?=
 =?utf-8?B?aUsrRzhLY0pjR21uekp5R1FaNUg2TXhXV1o1dWVOd3k5dUNxV1Rwb1BGZm1H?=
 =?utf-8?B?cEtzQmxML2N2ZjlEUmxRUmRCRGp4aXBqL2JvSzRjRmlyeXZHa2NWbkhCSGtU?=
 =?utf-8?B?NjdFcGtLNUYvK1dGN1BoQ0Zzeis4d3hCb3pjTXA4amUwdW5taFBpUGlOT2Nq?=
 =?utf-8?B?MEdtbUs0aFJXUXhBMkRFQnF2TFFmakdQMUl6cHQ2amFiVTBxQ2h6bTdJZEFP?=
 =?utf-8?B?WlBIOERuMlNHTy9XWHlTTjI3dEpiQ2NWQ21VNE95cU5UcURMYWVNb2lLK2RO?=
 =?utf-8?Q?TJcazRC5rO2A3paH2y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa22de3-6ca5-406c-0ffc-08deff63eff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 09:09:42.6064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3D1Yzy4geQ9KppUDmHuo40A6m+vwJc5XUPLL5coOrP+rmZ2u9kADU5dP37gt1GW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE5LCAyMDI2IDExOjUyIFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdS91c2VycTogZml4IGxvY2sgbWlzc2luZyBm
b3IgdXNlcnEgZmVuY2UgZXJyb3INCj4gc2V0DQo+DQo+IE9uIFRodSwgQXVnIDEzLCAyMDI2IGF0
IDExOjUw4oCvUE0gUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcigpIGFuZCBhbWRncHVfdXNlcnFfZmVuY2Vf
ZHJpdmVyX2Rlc3Ryb3koKQ0KPiA+IGRvbid0IGFjcXVpcmUgdGhlIGRtYV9mZW5jZSBzcGlubG9j
aywgc28gbG9ja2luZyB0aGUgZG1hX2ZlbmNlIGxvY2sNCj4gPiBiZWZvcmUgdGVzdCB0aGUgc2ln
bmFsZWQgc3RhdGUgYW5kIHNldCBlcnJvciBzdGF0ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jICAgfCAyMCArKysrKysrKysrKyst
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdXNlcnFfZmVuY2UuYw0KPiA+IGluZGV4IDE5YWYxYWRjMjkyMS4uMDllMjA3OWNmZGJkIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9m
ZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
X2ZlbmNlLmMNCj4gPiBAQCAtMTkxLDE0ICsxOTEsMTUgQEAgdm9pZCBhbWRncHVfdXNlcnFfZmVu
Y2VfZHJpdmVyX2Rlc3Ryb3koc3RydWN0IGtyZWYNCj4gKnJlZikNCj4gPiAgICAgICAgIHN0cnVj
dCBkbWFfZmVuY2UgKmY7DQo+ID4NCj4gPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZmZW5j
ZV9kcnYtPmZlbmNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KPiA+ICsgICAgICAgbG9ja2RlcF9hc3Nl
cnRfaGVsZCgmZmVuY2VfZHJ2LT5mZW5jZV9saXN0X2xvY2spOw0KPiA+ICAgICAgICAgbGlzdF9m
b3JfZWFjaF9lbnRyeV9zYWZlKGZlbmNlLCB0bXAsICZmZW5jZV9kcnYtPmZlbmNlcywgbGluaykg
ew0KPiA+ICAgICAgICAgICAgICAgICBmID0gJmZlbmNlLT5iYXNlOw0KPiA+IC0NCj4gPiAtICAg
ICAgICAgICAgICAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZikpIHsNCj4gPiArICAgICAg
ICAgICAgICAgc3Bpbl9sb2NrKGRtYV9mZW5jZV9zcGlubG9jayhmKSk7DQo+ID4gKyAgICAgICAg
ICAgICAgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkX2xvY2tlZChmKSkgew0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9zZXRfZXJyb3IoZiwgLUVDQU5DRUxFRCk7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3NpZ25hbChmKTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZChmKTsNCj4gPiAgICAg
ICAgICAgICAgICAgfQ0KPiA+IC0NCj4gPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soZG1h
X2ZlbmNlX3NwaW5sb2NrKGYpKTsNCj4gPiAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJmZlbmNl
LT5saW5rKTsNCj4gPiAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmKTsNCj4gPiAgICAg
ICAgIH0NCj4gPiBAQCAtNDIzLDExICs0MjQsMTYgQEAgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZl
cl9zZXRfZXJyb3Ioc3RydWN0DQo+IGFtZGdwdV91c2VycV9mZW5jZSAqZmVuY2UsDQo+ID4gICAg
ICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmOw0KPiA+DQo+ID4gICAgICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmZmVuY2VfZHJ2LT5mZW5jZV9saXN0X2xvY2ssIGZsYWdzKTsNCj4gPiAtDQo+ID4gKyAg
ICAgICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZmZW5jZV9kcnYtPmZlbmNlX2xpc3RfbG9jayk7DQo+
ID4gICAgICAgICBmID0gcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZCgmZmVuY2UtPmJhc2UsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2NrZGVwX2lzX2hlbGQo
JmZlbmNlX2Rydi0+ZmVuY2VfbGlzdF9sb2NrKSk7DQo+ID4gLSAgICAgICBpZiAoZiAmJiAhZG1h
X2ZlbmNlX2lzX3NpZ25hbGVkX2xvY2tlZChmKSkNCj4gPiAtICAgICAgICAgICAgICAgZG1hX2Zl
bmNlX3NldF9lcnJvcihmLCBlcnJvcik7DQo+ID4gKyAgICAgICBpZiAoZikgew0KPiA+ICsgICAg
ICAgICAgICAgICAvKiBuZXN0IGYtPmxvY2sgaW5zaWRlIGZlbmNlX2xpc3RfbG9jayAqLw0KPiA+
ICsgICAgICAgICAgICAgICBzcGluX2xvY2soZG1hX2ZlbmNlX3NwaW5sb2NrKGYpKTsNCj4NCj4g
V2h5IGRvIHdlIG5lZWQgdG8gdGFrZSB0aGUgZmVuY2Ugc3BpbmxvY2sgZm9yIHVzZXJxcywgYnV0
IG5vdCBmb3Iga2VybmVsIHF1ZXVlcz8NCj4gU2VlIGFtZGdwdV9mZW5jZS5jDQoNCkZvciB0aGUg
a2VybmVsIHF1ZXVlIHJpbmcgZmVuY2UsIHdlIGFsc28gbmVlZCB0byBob2xkIHRoZSBkbWFfZmVu
Y2UgbG9jayB3aGVuIGNhbGxpbmcgZG1hX2ZlbmNlX2lzX3NpZ25hbGVkX2xvY2tlZCgpLiBUaGUg
cmVhc29uIHRoYXQgZG9lcyBub3QgYXNzZXJ0IHRoZSBsb2NrIG1pc3NpbmcgZm9yIHRoZSBrZXJu
ZWwgcmluZyBmZW5jZSBpcyB0aGUgLnNpZ25hbGVkKCkgY2FsbGJhY2sgaXMgbm90IGltcGxlbWVu
dGVkLCBzbyBkbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZCgpIHdpbGwgbmV2ZXIgYmUgaW52b2tlZC4N
Cg0KVGhhbmtzLA0KUHJpa2UNCg0KPiBBbGV4DQo+DQo+ID4gKyAgICAgICAgICAgICAgIGlmICgh
ZG1hX2ZlbmNlX2lzX3NpZ25hbGVkX2xvY2tlZChmKSkNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBkbWFfZmVuY2Vfc2V0X2Vycm9yKGYsIGVycm9yKTsNCj4gPiArICAgICAgICAgICAgICAg
c3Bpbl91bmxvY2soZG1hX2ZlbmNlX3NwaW5sb2NrKGYpKTsNCj4gPiArICAgICAgIH0NCj4gPiAg
ICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmZlbmNlX2Rydi0+ZmVuY2VfbGlzdF9sb2Nr
LCBmbGFncyk7ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
