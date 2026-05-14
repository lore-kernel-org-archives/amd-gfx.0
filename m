Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D28CD37AC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 02:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A5F10E108;
	Thu, 14 May 2026 02:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mw9AuUSL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18AE10E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 02:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlJ3/yUsrkXfV/4/XxBCWSSfVs3CPNrLGGRO/0TlrGTctAkjGY9YaN+YA/+MAxTLLXzy7o5+E/dYdAnmrjrw11/f5EN42yojeItjgEE8MjF68DWzNnZyi+MuRXiSsotjPemoPC1cZXPi0yzkhF6oLHKcu8dVDdN94xaFPUQgIVIfg5pjMQ/gXnRPh5v0JZ86CTL5X/FautGRBz9JpSU+kFIEfiCYQIIxh/iOLJfC7SykUuw1Vrn6iZnSUUEML1PRfIcuMoiEuMC/JVCi5u6zubOe/W+in6d/4o99cosRqVekISiIddincMxIxsikMpIBhsZ0ba6u/QqsDhbJCbsZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kav9xOeEgodtM54aRIa/NQwnizSDi2E21gvfKMHRBIQ=;
 b=pZb9Pr25njL5zG5kxZDe7iwKulOjSz003/Z2xLt1Aje8YACAJwsRwKgeG9wXSbqbTQ/JgHkUXWZypyXBiGqEqacgh8XakbU1fA7oVVDcCOFWxEtDM7YT+TJ5TLi148V94Xt7c4s8bqRWwnTZOUQRq6WNp8h/awnzFXMyQyFIG1CpCWSdFMF+RAtRf+J6tXUjogyhhZKRMRYHxW0Q0vgD8mkXEhwbuTiBVJ64FDhH1UzThG/hYvD7AGvBuTpQZYEHkekHKAY811D5f5Ps/juoaPligRB+98TuEAHVhOYhU9ErjJGgy+qkKtTvK8mqMsHQ4iiBcxkJHxGyWBDmfRXOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kav9xOeEgodtM54aRIa/NQwnizSDi2E21gvfKMHRBIQ=;
 b=mw9AuUSLEYoF0Ebr/TeVUPjZrtA7nmS247GybEWM906u71e+YBkRbpMlSSUpHQoZO9+f9sqBrHdn2xBOsR/yUPnQYQi6p4WH0oxKNlRerbiSx1qU5bZVz0axAUpyVPWEbcOknk+Qp62I+IBf985Og9G8SmFJ4S2rU0F55IxZ6Xo=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 02:58:41 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:58:41 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add eviction fence tracepoints for userq
 profiling
Thread-Topic: [PATCH 4/4] drm/amdgpu: add eviction fence tracepoints for userq
 profiling
Thread-Index: AQHc4U3A2U5XyGyxykCQilQQs5aH/7YLsB6AgAEnknA=
Date: Thu, 14 May 2026 02:58:41 +0000
Message-ID: <DS7PR12MB600512BDCE3695F9911A8403FB072@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <20260511135435.3818345-4-Prike.Liang@amd.com>
 <9132afee-bc28-4e70-9f5d-9065f425a871@damsy.net>
In-Reply-To: <9132afee-bc28-4e70-9f5d-9065f425a871@damsy.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-14T02:55:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4302:EE_
x-ms-office365-filtering-correlation-id: 2ac1aaaa-976c-405e-b088-08deb164b428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|11063799003|56012099003|4143699003;
x-microsoft-antispam-message-info: Zbf2072Btu228qXM7sqWzSzI2fQytd0m8Jm66EWu7Iwoerbv1PNWwYp1LDZd8HqzFP9ThzRTvsZyniYt/nPDTTzi0sVo0ZyYCdoVYWBvlppLvyKrKar3tFh1Q2VStDUmKm7D/R4iTgbQgdqsv9YNWqPEirHRzVKH17T91Z8Y1NbwhRJwnCtRsZb6jyCk0oBMyG8NoS0uh53ipYePkFCtUu/lxj48pTltHChdnmzgMQ+c7SUA2C7kMAwBF+kMmyMKuA4sSUOYlFIELWJvOYHvw6W5efgQC2B2vywrFqECqP1Hju9GfnsmNAPJ5w8ASkpj7Cvd+p8Tks78LbOR7M1KT8KE/dKX7AYimePykm+jHev/pMvNWhSWoNyD6Gg8oaZ+VuNFrkmVqEKiR17SzIC3aus1UP6uZjX0z8qaKMmfbWvcijgrQz9OpWwwZvztm+uC1lx3yJcTahE9IffIjmX8OEUjBenWK0q6ybcxgf7CxcaIZuNvDfHtccfHm4/SMhnmOBx4tJY44+JpwrLRJBSE3wMs8NtT+GZCNyQkO9r5eujQBTj005KL0hxinrqoDfReFp6+MQhcZF8Qk2L/Cc5TgbIy4CYfo+ox6Q68rYq8icDEhhv7oSYcheFp0U5tK7/rutSMYXJeIRSnnPE59SDpU7vrtZJYD6DgeZGWQ78+E87ssuOeOvCjpBNf2IGz9qbbsPMNq5vHNotsEua9eWcoxEitEfKK4gY/bS+69mlsoK1r3pDk85nhSaOsT5G0PYhr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2d5WkZUemNCNEdSN0gyV2s5ZC9ZMnM4R3R3WTJ2OXR4MFdJeEZKSkh0d29i?=
 =?utf-8?B?cGpJYlZqUE1DTGFlVFAzR21ySDJBTmxEL1B4Y0pTRzRIMDdtb2ZZMnBnaWJY?=
 =?utf-8?B?VER4R1U5MlpEZGsvR2d1b3NlM0hyMWJPRXlNQlFqM2NzaTZVcFBiWkxzUTg4?=
 =?utf-8?B?K0txSk9HK3dEYjJjNmJNRlVDZVYyNDVDekMweVMrQXdERDJlcmZWY1JKd0pR?=
 =?utf-8?B?MExjQjNIbXZTSFZ0aGpWV0J6R3I0Wnh6QUR0MFd1TURWNzE3UlRlRWxwWk1y?=
 =?utf-8?B?WHZZWkRHV3ErS3FEWUNmYjhmVDlDemlURGlBaEJLdVNwOEYzTEFtYjFwMkR2?=
 =?utf-8?B?dVkyTlEyY29kQmFLcSs2VEhaa3BDT2tkdjVGaGV4MVFlVitPVW9xeE1CQ3Zn?=
 =?utf-8?B?U2JyVTdUOVBzOHIyNEozRmVROFErSUF6OW5FVzFOaEhRY3p4TXRVNW1nL0No?=
 =?utf-8?B?UC85aXFOMXY2ZWEvcE9ybHA0VUdjemE4c0pQbFcyanB3TnVaa2J2SkpEdThR?=
 =?utf-8?B?QnV0dkg3Wk9XZEM2RlUwaUViaFZaQXlESWJqZlVjbjhCMlhMRWdQMXNubkEw?=
 =?utf-8?B?QUJBVkNlQnl1NGN3dy9WVm9ZZ09rZDNocFVRNVU4UEtsS3NlYitidHBvZEta?=
 =?utf-8?B?THJpMUdXb2FYdEk4MGt0TWl2cDlkTW9pL1RCRXZ1amRVbnFSMDNzTUJoWEpV?=
 =?utf-8?B?clo5QmF2TEhsUWlybFV4aVlZUlQweGZHYVpVNURSRDVkS3p0aWE1eG9OS2hY?=
 =?utf-8?B?R25YSGJKMHh5d2N3MGNSdFZuNVkyazRUSjZmK05Md0ttLzR0RHBVc2hnMUpN?=
 =?utf-8?B?cDV3dHdqRU15bW9YRWdTV2hLcnJKbytrbjdiT0JYS1BDTU5xeE15U3VVUWM5?=
 =?utf-8?B?dlA2R2FIL2p2elJJTWl0YzRsZHhxQTVpZ3VlUDRrN1JxYit2N3pEekFXNnJt?=
 =?utf-8?B?bFZNY29IUUZYQThaU05XRWQrREh0NDFUVlNGekM3bmtLdk8yamFsWmZydHdP?=
 =?utf-8?B?RXVrNzlLaDRLU1piZHM0KzhiaS9rUFFXTFZQS1hFOGtTWm9JTGpaUkNYYllK?=
 =?utf-8?B?M0ZjVmgzWTFscmhwRXl4WEZNZmhUWWNsODU5eEQyYnhLVlg1OFZwY1czM0tz?=
 =?utf-8?B?OXMyRnJoVnpaUXMwY2YrMUtudFhJbVJzbXg1dnp0T1gxbFN2ZXhNNlNmNHlY?=
 =?utf-8?B?WEhwNmVOcjRwdnNFL0RVL0l1WWN2djBkSkdya0piZWlLZDA2aFhERGRVTUhj?=
 =?utf-8?B?Q1UyS1hwcGYxTEpUTTQ5VXBGQkZXM3pZbUtMT0k3M0RuUnVBZEtaVWVuM3lR?=
 =?utf-8?B?RTBLRzBOTzlXRkQ3b1l6TlFvR0hPTm5zOXRiT1lQMHNtY05QVS83MUptR1hn?=
 =?utf-8?B?Tncwd0Z0T1JMbit1TkNaazlBRmkxcjBzVlNLNnVLTVJIek9pb2xMdE1RWEZw?=
 =?utf-8?B?VnMxSFJIOTJuZyt0YzJnQzlqcCtWeS9lWHdRWkRSWTdxdG1BWUQ5cCt0SXlK?=
 =?utf-8?B?blNScFFkZk9jNlBJNEJxSGFCY1J5dnkvV3Bydnl0Ulh3UHhWZWJPczk3MFRT?=
 =?utf-8?B?R3lYMm94OWVOS241elF6WVY3YWtXOGg5cDhwZWh2Z3oyZG83eGRVL2prVVQ3?=
 =?utf-8?B?aWlNc3V5cFAzeVI5V1ZOWmw4ZlRkajIwTWpneUNScDlOQjhnYzV0eVpDL1c2?=
 =?utf-8?B?N2F3VHg2RndIbkQ5V0RXS0JTaGlycXoyOXd5d1dIKy9RdEpmaEJiNzM3N0kr?=
 =?utf-8?B?dGpsTHVKWVdkcFZGTFdOd05zQ3JGU3NwandHNk1XK01ySWRrZHB3MVRhR3pw?=
 =?utf-8?B?SW1HcHlNSURPN04xQjJ2ZmE2dk9zTndEczk0M2UvRkxwNkhJR0JzVTBqM0lY?=
 =?utf-8?B?VkJTMm9DS0NoTTI2dzI5dFR5dmRzalhtMTFrQ0RkNW53aFR6U2s4RDNsN0NM?=
 =?utf-8?B?b0ZDWmUvdGtxRTFNMFhBMXNkanpLSkNEU2xIWVFKaG9RSFZEeGVldW41L2h4?=
 =?utf-8?B?R1BiaXdZcllnRHVUdHRFRUM4Vm9wSS9LdW1Yc0NUYWs4QlM5cGErL1g0Tkdi?=
 =?utf-8?B?NDZKdU5tOXQ4bEF6SXJVbGl1bnRwREVNc0Jrclc3UnZsbFlabjd6ak9MQlNj?=
 =?utf-8?B?aGd5c1RFdVdqbzNBSHpKc0U5bHE1U09BWDQ0blhuYnhDQUwxUWlyT09YSDVj?=
 =?utf-8?B?NFZVMSswWWI2dEVjSUNyYVZldkdKNjJ3bUpDM3lhRzUzNEg3Z25jMHFsM1ZT?=
 =?utf-8?B?YzBWbUl5Z2k0c2ZHbEtLS0lLSGl2OUVLSDQxUVQzeVpUVmVxKzlkeVpjY3hu?=
 =?utf-8?Q?a8DbaHwu5eeNdFa5Jm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac1aaaa-976c-405e-b088-08deb164b428
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:58:41.0512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWnfGA7VQ6f+RRI3pgyW8nIQgjonRKypZ2MNm/mGEKa54xDRnLATbuVSdmR8Qo0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJyZS1l
cmljQGRhbXN5Lm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTMsIDIwMjYgNToxOCBQTQ0K
PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBkcm0vYW1kZ3B1OiBhZGQgZXZpY3Rpb24g
ZmVuY2UgdHJhY2Vwb2ludHMgZm9yIHVzZXJxDQo+IHByb2ZpbGluZw0KPg0KPg0KPg0KPiBMZSAx
MS8wNS8yMDI2IMOgIDE1OjU0LCBQcmlrZSBMaWFuZyBhIMOpY3JpdCA6DQo+ID4gQWRkIGZ0cmFj
ZSBldmVudHMgZm9yIHRoZSB1c2VycSBldmljdGlvbiBmZW5jZSBsaWZlY3ljbGUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIC4uLi9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYyAgICB8
ICA4ICsrKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5o
ICAgICB8IDQyICsrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDkg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+IGluZGV4
IDVhZTQ3N2M0OWE1My4uOTM1OGY5YjM1OTE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBAQCAtMjQs
NiArMjQsNyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+ID4gICAjaW5jbHVk
ZSA8ZHJtL2RybV9leGVjLmg+DQo+ID4gICAjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+ID4gKyNpbmNs
dWRlICJhbWRncHVfdHJhY2UuaCINCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IGNoYXIgKg0KPiA+
ICAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2dldF9kcml2ZXJfbmFtZShzdHJ1Y3QgZG1hX2ZlbmNl
ICpmZW5jZSkgQEANCj4gPiAtNDQsNiArNDUsOCBAQCBzdGF0aWMgYm9vbCBhbWRncHVfZXZpY3Rp
b25fZmVuY2VfZW5hYmxlX3NpZ25hbGluZyhzdHJ1Y3QNCj4gZG1hX2ZlbmNlICpmKQ0KPiA+ICAg
ew0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlICpldl9mZW5jZSA9IHRvX2V2
X2ZlbmNlKGYpOw0KPiA+DQo+ID4gKyAgIHRyYWNlX2FtZGdwdV91c2VycV9ldmljdGlvbl9mZW5j
ZV9lbmFibGVfc2lnbmFsaW5nKGYtPmNvbnRleHQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYtPnNlcW5vKTsNCj4gPiAgICAgc2No
ZWR1bGVfd29yaygmZXZfZmVuY2UtPmV2Zl9tZ3ItPnN1c3BlbmRfd29yayk7DQo+ID4gICAgIHJl
dHVybiB0cnVlOw0KPiA+ICAgfQ0KPiA+IEBAIC04NCw2ICs4Nyw4IEBAIGFtZGdwdV9ldmljdGlv
bl9mZW5jZV9zdXNwZW5kX3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ID4g
ICAgICAqIG5leHQgZmVuY2UuDQo+ID4gICAgICAqLw0KPiA+ICAgICBkbWFfZmVuY2Vfc2lnbmFs
KGV2X2ZlbmNlKTsNCj4gPiArICAgdHJhY2VfYW1kZ3B1X3VzZXJxX2V2aWN0aW9uX2ZlbmNlX3Np
Z25hbChldl9mZW5jZS0+Y29udGV4dCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBldl9mZW5jZS0+c2Vxbm8pOw0KPiA+ICAgICBkbWFfZmVuY2VfZW5k
X3NpZ25hbGxpbmcoY29va2llKTsNCj4gPiAgICAgZG1hX2ZlbmNlX3B1dChldl9mZW5jZSk7DQo+
ID4NCj4gPiBAQCAtMTM4LDcgKzE0Myw4IEBAIGludCBhbWRncHVfZXZmX21ncl9yZWFybShzdHJ1
Y3QNCj4gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21nciwNCj4gPiAgICAgLyogUmVt
ZW1iZXIgaXQgZm9yIG5ld2x5IGFkZGVkIEJPcyAqLw0KPiA+ICAgICBkbWFfZmVuY2VfcHV0KGV2
Zl9tZ3ItPmV2X2ZlbmNlKTsNCj4gPiAgICAgZXZmX21nci0+ZXZfZmVuY2UgPSAmZXZfZmVuY2Ut
PmJhc2U7DQo+ID4gLQ0KPiA+ICsgICB0cmFjZV9hbWRncHVfdXNlcnFfZXZpY3Rpb25fZmVuY2Vf
ZW1pdChldl9mZW5jZS0+YmFzZS5jb250ZXh0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBldl9mZW5jZS0+YmFzZS5zZXFubyk7DQo+ID4gICAgIC8qIEFu
ZCBhZGQgaXQgdG8gYWxsIGV4aXN0aW5nIEJPcyAqLw0KPiA+ICAgICBkcm1fZXhlY19mb3JfZWFj
aF9sb2NrZWRfb2JqZWN0KGV4ZWMsIGluZGV4LCBvYmopIHsNCj4gPiAgICAgICAgICAgICBzdHJ1
Y3QgYW1kZ3B1X2JvICpibyA9IGdlbV90b19hbWRncHVfYm8ob2JqKTsgZGlmZiAtLWdpdA0KPiA+
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oDQo+ID4gaW5kZXggZDQyMWE0NGVm
OTMzLi41MTkxZjRlOTU3ZDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3RyYWNlLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHJhY2UuaA0KPiA+IEBAIC03MDksNiArNzA5LDQ4IEBAIFRSQUNFX0VWRU5UKGFt
ZGdwdV91c2VycV9mZW5jZV9zaWduYWwsDQo+ID4gICAgICAgICBUUF9wcmludGsoImNvbnRleHQ9
JWxsdSwgc2Vxbm89JWxsdSwgcnB0cj0lbGx1IiwNCj4gPiAgICAgICAgICAgICAgICAgICBfX2Vu
dHJ5LT5jb250ZXh0LCBfX2VudHJ5LT5zZXFubywgX19lbnRyeS0+cnB0cikNCj4gPiAgICk7DQo+
ID4gK1RSQUNFX0VWRU5UKGFtZGdwdV91c2VycV9ldmljdGlvbl9mZW5jZV9lbWl0LA0KPiA+ICsg
ICAgICAgVFBfUFJPVE8odTY0IGNvbnRleHQsIHU2NCBzZXFubyksDQo+ID4gKyAgICAgICBUUF9B
UkdTKGNvbnRleHQsIHNlcW5vKSwNCj4gPiArICAgICAgIFRQX1NUUlVDVF9fZW50cnkoDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgIF9fZmllbGQodTY0LCBjb250ZXh0KQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICBfX2ZpZWxkKHU2NCwgc2Vxbm8pDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICksDQo+ID4gKyAgICAgICBUUF9mYXN0X2Fzc2lnbigNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgIF9fZW50cnktPmNvbnRleHQgPSBjb250ZXh0Ow0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgX19lbnRyeS0+c2Vxbm8gPSBzZXFubzsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICksDQo+ID4gKyAgICAgICBUUF9wcmludGsoImNvbnRleHQ9JWxsdSwgc2Vxbm89
JWxsdSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgX19lbnRyeS0+Y29udGV4dCwgX19lbnRyeS0+
c2Vxbm8pDQo+DQo+IEknbGwgbGVhdmUgaXQgdG8gb3RoZXJzIHRvIGRlY2lkZSBpZiB0aGVzZSBl
dmVudHMgYXJlIHVzZWZ1bCwgYnV0IGlmIHlvdSBrZWVwIHRoZW0gcGxlYXNlDQo+IHVzZSAiZmVu
Y2U9JWxsdTolbGx1IiBmb3IgY29uc2lzdGVuY3kuDQoNCkkgdGhpbmsgdGhpcyB3aWxsIGhlbHAg
dW5kZXJzdGFuZGluZyBhbmQgcHJvZmlsaW5nIHRoZSB1c2VycSBvYmplY3RzIGJvb2trZWVwaW5n
IHVzYWdlIGFuZCB1c2VycSBldmljdGlvbiBsYXRlbmN5Lg0KDQo+IFBpZXJyZS1FcmljDQo+DQo+
ID4gKyk7DQo+ID4gK1RSQUNFX0VWRU5UKGFtZGdwdV91c2VycV9ldmljdGlvbl9mZW5jZV9lbmFi
bGVfc2lnbmFsaW5nLA0KPiA+ICsgICAgICAgVFBfUFJPVE8odTY0IGNvbnRleHQsIHU2NCBzZXFu
byksDQo+ID4gKyAgICAgICBUUF9BUkdTKGNvbnRleHQsIHNlcW5vKSwNCj4gPiArICAgICAgIFRQ
X1NUUlVDVF9fZW50cnkoDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIF9fZmllbGQodTY0
LCBjb250ZXh0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBfX2ZpZWxkKHU2NCwgc2Vx
bm8pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICksDQo+ID4gKyAgICAgICBUUF9mYXN0
X2Fzc2lnbigNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmNvbnRleHQgPSBj
b250ZXh0Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgX19lbnRyeS0+c2Vxbm8gPSBzZXFu
bzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICksDQo+ID4gKyAgICAgICBUUF9wcmludGso
ImNvbnRleHQ9JWxsdSwgc2Vxbm89JWxsdSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgX19lbnRy
eS0+Y29udGV4dCwgX19lbnRyeS0+c2Vxbm8pICk7DQo+ID4gK1RSQUNFX0VWRU5UKGFtZGdwdV91
c2VycV9ldmljdGlvbl9mZW5jZV9zaWduYWwsDQo+ID4gKyAgICAgICBUUF9QUk9UTyh1NjQgY29u
dGV4dCwgdTY0IHNlcW5vKSwNCj4gPiArICAgICAgIFRQX0FSR1MoY29udGV4dCwgc2Vxbm8pLA0K
PiA+ICsgICAgICAgVFBfU1RSVUNUX19lbnRyeSgNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgX19maWVsZCh1NjQsIGNvbnRleHQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIF9f
ZmllbGQodTY0LCBzZXFubykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKSwNCj4gPiAr
ICAgICAgIFRQX2Zhc3RfYXNzaWduKA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgX19lbnRy
eS0+Y29udGV4dCA9IGNvbnRleHQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5
LT5zZXFubyA9IHNlcW5vOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgKSwNCj4gPiArICAg
ICAgIFRQX3ByaW50aygiY29udGV4dD0lbGx1LCBzZXFubz0lbGx1IiwNCj4gPiArICAgICAgICAg
ICAgICAgICBfX2VudHJ5LT5jb250ZXh0LCBfX2VudHJ5LT5zZXFubykgKTsNCj4gPiAgICN1bmRl
ZiBBTURHUFVfSk9CX0dFVF9USU1FTElORV9OQU1FDQo+ID4gICAjZW5kaWYNCj4gPg0K
