Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EE5C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 07:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF90010EE71;
	Wed, 12 Aug 2026 07:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M8Osb0Jn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D609010EE71
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 07:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNHLPQMus2BpfpFcu192YtG6jpUbkL/VM6pwoszo23u9qfS88+N2TeIDK+n7+lhYSABuf7aLAvseghtqnSN9Zy/Tol4BR1UlKOeV5AdvVQlJj5JpcloqesMylEEu4J3ZWW5GAFwjO77EXX1T4cOPh0tWQCLc7ZrEfWa2DN4n09ieOgnSh+T4NFAXsrX6O/KQwMzB7BNO5zzjKRihy9WEvuKJqIhExA9Qg/Cg9jD7ticyQ9Xr0DX3BIY7+xrjp5ot72RuPA84wgya91pCb3TFz48CLDXKfM44KpSIno8/aP80fnI2a3FQDBoOVXhOrRUaU8+0OXI0kyPLvVc5QrCc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB54BCMhdbFbASNiyUDKjKbnCcoNb1QLDViVPdjdJPM=;
 b=axzwthgx/bv8D3rpWRbQzG6rmoIDKaZ6FrIJ9s1NCA44t1Zk7fPVmET4rT/PjAnoFj5Yo9TTjaliXFftGb3SioI0DjMOozeEsjG3mDxxGJidNiNse+gHi2Rp6mCe/vNwcLpdd68AxG+UEyS8BMYaGFfwYF1Xe/ao1ppojElx2WT70JP2VYn/ErrzN0PO6k4zXwqOoFcK2+Z+hY7uD4Y9NLANhD4gNLtEEo+CgE6q0tusQ01Hair/lTqF/e31ytHnxTi6Zb6hir82et9imqbqcex0OHeV+Z8O+1BUNL0rHftP+5cPYTpSBM9spW3Nk67R8ha4AuBNa51hUGGD+bVzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB54BCMhdbFbASNiyUDKjKbnCcoNb1QLDViVPdjdJPM=;
 b=M8Osb0JniiFZtN4imkHea/L6AnLYZZ5Z1keBpfjaY74bAdGVVsTamBxKYg7+TTk1hkZX00ic+bQQdHIhOwSoyzsU3QrveZDqmETiSnz/JhHkwADKrlofLhof+S2T9L7FXSeeeyct5MzYJ6SpSTXW3dJDBUIYncUQxRcAenWLEf8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 07:16:43 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 07:16:43 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Ghosh, Prerona" <Prerona.Ghosh@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: bind imported BOs before mapping them into
 a VM
Thread-Topic: [PATCH v2] drm/amdgpu: bind imported BOs before mapping them
 into a VM
Thread-Index: AQHdKWh6IzrR0btdHUmHRpj9DOuPXraYxt4AgAE6ysA=
Date: Wed, 12 Aug 2026 07:16:43 +0000
Message-ID: <CY5PR12MB636936558E2C3AB838F05C91C1DC2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260811080717.547510-1-yifan1.zhang@amd.com>
 <d2d08abf-989d-4e88-a69e-a8ab1ffd4cb1@amd.com>
In-Reply-To: <d2d08abf-989d-4e88-a69e-a8ab1ffd4cb1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T07:14:38.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB6691:EE_
x-ms-office365-filtering-correlation-id: 3861c4db-f5e6-404e-bb02-08def841a9b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: LhmEWl+OY3M9TB6IVKYgKRvqcUwVTwOCvIMT9DTbiQK0mQsTjyPsf5C/5U1fQqI0Gxpxow6/hnJ5iuizQ3MM7wgGHlS+bWWTH6WxWxyJFgwSLaYZlhuGTHdP9Eg8UCnJ/v1x0GhCKGylf5j3SOXA8brbiOuNzhAU/UsENAfRKSNSgUzNILma8H3qERC9HIGnrSjduKJdmWcpLnI/0uU5Pj21E4RXNlEzjAl51w1CtBWfv4wV7KNC9Hm6FUCDxccmwal2ixAdDRYL5wocC6kOhj6gjz2rtSw1T+21lEM1QzfPcMgxPCGbQl4OqzqyRVOCbzJbiE+bcTp7RB4Wehs0R8awcK1FqFxAF5RTKYU3TbkoEneubihGdhw9gdVyhlurbdKebHqkq4GRWHZ2KRamlBXgbE1TvCedhlRtXWimr/+ItBm22Qev4U2E48+Eg3Q/edMgCHDBbu5wPGWkf0g7xrj/zt8Oi3jeINz3XJ1OivBGw7FXealwSLbUJnXv59EBpwn8/UR0tTTg8xKkIWEhOxh1rCE2AH+3u9yU5KSgIo0ZLVtYsP6y6/xnfqdykU1IiUXkGa2mHzvaW4iqnWohH4/+E4FOXTYFTfcMXx1RDrWyWZ2A4PCsqYC6LqEMiIUvb+rJSt3oVZ1It5T55RFYqJPTi1uKJbLNZ2ONlruniT7QjtLJQFyGiBofxn7VEG9W4vvalQFLnmT/SIyBqG4R/VNG4Tp9O4KpwPrziOccpt4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3ZoQmdLR2dIcEpHdG9sK1BOZ1BmMzlRWWZ6ZTZYbUZSSVM0SE9HZXBVdkxD?=
 =?utf-8?B?U09KdlBaN2hzQXFFTmtGaGJHSlFXSDZ1aXN6NVYzemFuWkFsNkJya0dFYVRa?=
 =?utf-8?B?TWdWSXdWMFZMSWNoOFBBb3l2Tk9DZUtNa1g0VzVDOGJUTEJPcDBqcnlpdE8x?=
 =?utf-8?B?YU9NSlQ2M3M3WnpxOFZMeUVmTGx6RHFySWp0REpnY2hpUnBXM0t5MnhQTTJD?=
 =?utf-8?B?K3BoUGVmcHdSTXBUalFSWFptMGcxM2NZb28rMWM1ZzdvYU95M0xSeTl1cnRL?=
 =?utf-8?B?cDIxcHZaQ0k2WUNyM3NsYmFxTE1yWVNGaWRNa1daNTJ1RGlWa0VDTUJUOFNs?=
 =?utf-8?B?YUovNVNQbVJIbW5va0lRMGVDRERyWFBXN0doZ0ZxcE8rTGdzc0FaQi91WUk3?=
 =?utf-8?B?a0xBa3lkYmxTYUcyeVkxSzkxQkN5RWFnekxiaU01VHBVZkVFZnV4dS82bk5Y?=
 =?utf-8?B?cGczOFNKOTB3emNuL0hYcWhtUys1ODV6aTE4QXRtVkx4VDhFNHBhZi8rMlUz?=
 =?utf-8?B?L2V1UklJVm1jSWQrcmc0QXg2Y2ZSb2pGV0lSQ0VNcW8zM0xBVUpoYytiQzNT?=
 =?utf-8?B?eC9qd2JJNDFscWd1S2NVQzROaHp3dG1UZ1VHUTUvNG1lOTM3eEFRZ1lTZTZh?=
 =?utf-8?B?aFFnd1FXeWxwTDQ0Q3IxOU14OWNRU2dEdzhPNnd2cUVuTFU1S25ZUmN0L3lz?=
 =?utf-8?B?RHdXVWJvbHI2dGtnaHY2cVFYV05ZREpSdVUyQ09WV1lzc2ZPS3JCSHBkTGVR?=
 =?utf-8?B?a29BMStZRXRnWVI5ckJEZ0lTZFNmV1NWS2RnNE00cmVaeUdmTTdnblFkVlpI?=
 =?utf-8?B?K2tFMVVEdVdySlYyaFVyMkxiSGVRNHlubXVia2thVkpreWRaNFNtNGN5WTZK?=
 =?utf-8?B?cXA1NEYvWU1GMmFwQTl5VDJoYktYSHVycDlxRzNTNUdlM3VSdExTVHJPaDVn?=
 =?utf-8?B?a2pFTzViUWRIbVZSNTUyc04wTGdCbkZXR2E5MU1lTngzWE43ZHE1ZkJIQkha?=
 =?utf-8?B?YWZzVFp3NFZJRkpVTEhlSmZ0QjlMS29SWk02U3hOSVB2UHVwY2VkTm83d0J3?=
 =?utf-8?B?UmtmK2hWS0VvSkpTZ090aUt5WjZ5NERXTEtaTElMbmRoTG5hSTlPcDNDeTZK?=
 =?utf-8?B?OEpxTlNFcW1LUjljM0EyRGkwQUY4RVhsSmgwckxxbzRYa1lpMS9tZCtzMjAz?=
 =?utf-8?B?VGFKdEJJS0txTTBzbkFqUDJzZjk4Y0ExN21KV0NCSUNjM2U3dU1CNUJZZEVW?=
 =?utf-8?B?cWZweDg2RE5JTGhqL25DMEM1RXRMOFp4d3hXR3Q1dU43VjlNUjduVGdLSXVj?=
 =?utf-8?B?bEtoYVhyTkFFWkJ1SmRaL3c1UDBndDdUd2U4UXl1dGprb0NleDhneGU5VFEw?=
 =?utf-8?B?SVhQSEJheWlmVWdEaUpXT0t2cDFEUmlrOTlhS0R5YVN1M3dBTHl3NzlCeWxH?=
 =?utf-8?B?NUNEUkdLeElyY0NNZ1J1eFJBUnNGMlhNQTF5RzJOQU5kVmpERE9WVUgyMEFw?=
 =?utf-8?B?aGVGekh0Wk16WFF6bUlXNkJFWURja2NybkZZaHlGR0hCbElHUVZwU01PeUdn?=
 =?utf-8?B?NExVZklxUkFIcTdmWWJoZlZRYlZwcStGRExEQ1UxVXljYkRYMjcrYnRoeXFX?=
 =?utf-8?B?Q3lsWGxQajl4WFpTWVh5Z2VBT3pzbW05Lzl4eVYrbEZWQXRDU3NDREVJUjlR?=
 =?utf-8?B?MEM0WVh1Vk1mcTFLM3kvakduMnNhSllaQ1lmZGorUk5EN0I0MkFrOXdYTUlN?=
 =?utf-8?B?VWk3cGFqeUtjbUlkL1lETHl3aDlBTENYYXA3M0FLT1RqZ2VBamhsN0xFdEUv?=
 =?utf-8?B?NHgwZ291SEg0Rzh4Uy8xMXVjMTl4MmNzZnlyQW5kN3R3eDdwVWtJcmx1MTc1?=
 =?utf-8?B?MUk1TUZXbnZGQWZkOUJtRnhMTU5zbEt1NG9McnlrekpoSlNRZjZPa2JzdnRR?=
 =?utf-8?B?eFJTMThEQXlZWUg5QXZDY3Foa2dmM2VOWXFmUUpYT21tMFpRSmF2QnRCZkJt?=
 =?utf-8?B?NWl3NjRhN045UGo0TkpuUEpENVFyMVJKSEE1L2lCalVIZVlKeVJsL2ludXo2?=
 =?utf-8?B?YmxwODRnRno1UEJuOGhGQ0RhcC9KTVhUMkFuMkJnZC9mbVRYSEJsM2ROaFM5?=
 =?utf-8?B?YnZPMVo4dC8yM0daaW9sYzU4eTBDZG1VaUo0ZjZWZmt6RDJzeDViUlNZWTFs?=
 =?utf-8?B?bXFsdGxHV2FKZkVvQ1pjZkduSDQyQkFodld5eXMxQVJ6bTZydm9OemxzZTh1?=
 =?utf-8?B?NHVhTnc1KzFmQldTdDNhdWhUR0R5WnVTTGhjVlJlUE5jOW1laGlQN0JJVXJQ?=
 =?utf-8?Q?RhpaDAuRlSqxtjUy8a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3861c4db-f5e6-404e-bb02-08def841a9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 07:16:43.6400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RysPFN06aSvQGunVSudGsBaDuyv9e22Sc4/26rBkIbufqHSadk5TClR2rkI2KIDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQp2MyBtb3ZlcyB0aGUgdmFsaWRhdGlvbiBp
bnRvIGFtZGdwdV9nZW1fb2JqZWN0X29wZW4oKSBhcyB5b3Ugc3VnZ2VzdGVkLHNvIGltcG9ydHMg
YXJlIGJvdW5kIG9uY2UgYXQgb3BlbiB0aW1lIGFuZCBncmFwaGljcyBhbmQgY29tcHV0ZSBWTXMg
Zm9sbG93IHRoZSBzYW1lIHJ1bGUuDQoNCkkgY291bGRuJ3QgZmluZCB0aGUgZWFybGllciBwYXRj
aGVzIHlvdSBtZW50aW9uZWQgb24gdGhlIGxpc3QsIHNvIHRoaXMgaXMgYSBmcmVzaCBpbXBsZW1l
bnRhdGlvbi4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgbWlzc2VkIHRoZW0uDQoNCkJlc3QgUmVn
YXJkcywNCllpZmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogVHVlc2RheSwgQXVn
dXN0IDExLCAyMDI2IDg6MjggUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBh
bWQuY29tPjsgR2hvc2gsIFByZXJvbmEgPFByZXJvbmEuR2hvc2hAYW1kLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IGJpbmQgaW1wb3J0ZWQgQk9zIGJlZm9yZSBtYXBw
aW5nIHRoZW0gaW50byBhIFZNDQoNCk9uIDgvMTEvMjYgMTA6MDcsIFlpZmFuIFpoYW5nIHdyb3Rl
Og0KPiBGcm9tOiBQcmVyb25hIEdob3NoIDxQcmVyb25hLkdob3NoQGFtZC5jb20+DQo+DQo+IEFu
IGltcG9ydGVkIGRtYS1idWYgd2l0aCBhIGR5bmFtaWMgYXR0YWNobWVudCBpcyBub3QgYm91bmQg
dG8gR1RUDQo+IHVudGlsIGl0IGlzIHZhbGlkYXRlZC4gSW4gYSBWTSB0aGF0IGlzIG5vdCBhIEtG
RCBjb21wdXRlIGNvbnRleHQNCj4gbm90aGluZyBkb2VzDQo+IHRoYXQ6IGFtZGdwdV9nZW1fb2Jq
ZWN0X29wZW4oKSBvbmx5IHZhbGlkYXRlcyBhbmQgZmVuY2VzIGltcG9ydHMgZm9yDQo+IGNvbXB1
dGUgVk1zLCBhbmQgY2xpZW50cyBzdWJtaXR0aW5nIHRocm91Z2ggSFcgcXVldWVzIG5ldmVyIGdv
IHRocm91Z2gNCj4gYW1kZ3B1X2NzLCBzbyBhbWRncHVfdm1fdmFsaWRhdGUoKSBkb2VzIG5vdCBy
dW4gZWl0aGVyLg0KDQpXZWxsIHRoYXQgaXMgYSBnb29kIGNhdGNoLCBidXQgY2xlYXIgTkFLIHRv
IHRoaXMgaGFja3kgd29ya2Fyb3VuZC4NCg0KSSBzdWdnZXN0ZWQgYSBsb25nIHRpbWUgYWdvIGFs
cmVhZHkgdG8gY2hhbmdlIHRoaXMgYmVoYXZpb3IgYW5kIHZhbGlkYXRlIGluc2lkZSBhbWRncHVf
Z2VtX29iamVjdF9vcGVuKCksIElJUkMgd2UgZXZlbiBoYWQgcGF0Y2hlcyBmb3IgdGhhdCBvbiB0
aGUgbWFpbGluZyBsaXN0Lg0KDQpEaWQgd2UgYWNjaWRlbnRhbGx5IGRyb3BwZWQgdGhvc2U/DQoN
ClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gQU1ER1BVX0dFTV9WQSB0aGVuIG1hcHMgdGhl
IEJPIHdoaWxlIGl0cyByZXNvdXJjZSBpcyBzdGlsbA0KPiBUVE1fUExfU1lTVEVNLiBhbWRncHVf
dHRtX3R0X3BkZV9mbGFncygpIGRyb3BzIEFNREdQVV9QVEVfVkFMSUQgYW5kDQo+IEFNREdQVV9Q
VEVfU1lTVEVNIGZvciB0aGF0IG1lbW9yeSB0eXBlLCBzbyB0aGUgcmFuZ2UgaXMgcHJvZ3JhbW1l
ZA0KPiB3aXRoIFBURSBmbGFncyAweDYwIChyZWFkYWJsZSBhbmQgd3JpdGVhYmxlIG9ubHkpIGFu
ZCB0aGUgZmlyc3QgR1BVDQo+IGFjY2VzcyB0byBpdCBmYXVsdHM6DQo+DQo+ICBhbWRncHUgMDAw
MDoyNjowMC4wOiBbZ2Z4aHViMF0gcmV0cnkgcGFnZSBmYXVsdCAoc3JjX2lkOjAgcmluZzowIHZt
aWQ6MyBwYXNpZDo0NikNCj4gIGFtZGdwdSAwMDAwOjI2OjAwLjA6ICAgaW4gcGFnZSBzdGFydGlu
ZyBhdCBhZGRyZXNzIDB4MDAwMDdmMTQyZDZkODAwMCBmcm9tIElIIGNsaWVudCAweDFiIChVVENM
MikNCj4gIGFtZGdwdSAwMDAwOjI2OjAwLjA6IFZNX0wyX1BST1RFQ1RJT05fRkFVTFRfU1RBVFVT
OjB4MDAzMDEwMTENCj4gIGFtZGdwdSAwMDAwOjI2OjAwLjA6ICAgICAgRmF1bHR5IFVUQ0wyIGNs
aWVudCBJRDogVENQICgweDgpDQo+ICBhbWRncHUgMDAwMDoyNjowMC4wOiAgICAgIFBFUk1JU1NJ
T05fRkFVTFRTOiAweDENCj4NCj4gVmFsaWRhdGUgaW1wb3J0ZWQgQk9zIGludG8gdGhlaXIgYWxs
b3dlZCBkb21haW5zIGJlZm9yZSBNQVAgYW5kDQo+IFJFUExBQ0Ugc28gdGhhdCB0aGUgbWFwcGlu
ZyBpcyBhbHdheXMgY3JlYXRlZCBmcm9tIGEgYm91bmQgcmVzb3VyY2UuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gQXNzaXN0ZWQtYnk6
IENsYXVkZTpvcHVzLTUNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMgfCAyOQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jDQo+IGluZGV4IGY3NTRhNGEzYTFjMi4uMjE0YWUyYTk1ZGEyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+IEBAIC03NDcsNiArNzQ3
LDI3IEBAIGludCBhbWRncHVfZ2VtX21ldGFkYXRhX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHZvaWQgKmRhdGEsDQo+ICAgICAgIHJldHVybiByOw0KPiAgfQ0KPg0KPiArLyoqDQo+ICsg
KiBhbWRncHVfZ2VtX3ZhX21ha2VfcmVzaWRlbnQgLSBiaW5kIGFuIGltcG9ydGVkIEJPIGJlZm9y
ZSBpdCBnZXRzDQo+ICttYXBwZWQNCj4gKyAqDQo+ICsgKiBAYm86IHRoZSBCTyBhYm91dCB0byBi
ZSBtYXBwZWQgaW50byBhIFZNDQo+ICsgKg0KPiArICogSW1wb3J0ZWQgZG1hLWJ1ZnMgd2l0aCBh
IGR5bmFtaWMgYXR0YWNobWVudCBzdGF5IHVuYm91bmQgdW50aWwNCj4gK3RoZXkgYXJlDQo+ICsg
KiB2YWxpZGF0ZWQuIE1hcHBpbmcgb25lIHdoaWxlIGl0IGlzIHN0aWxsIGluIFRUTV9QTF9TWVNU
RU0gd291bGQNCj4gK3Byb2dyYW0NCj4gKyAqIFBURXMgd2l0aG91dCBBTURHUFVfUFRFX1ZBTElE
IGFuZCBhbnkgR1BVIGFjY2VzcyB0byB0aGVtIGZhdWx0cy4NCj4gKyAqLw0KPiArc3RhdGljIGlu
dCBhbWRncHVfZ2VtX3ZhX21ha2VfcmVzaWRlbnQoc3RydWN0IGFtZGdwdV9ibyAqYm8pIHsNCj4g
KyAgICAgc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4IGN0eCA9IHsgdHJ1ZSwgZmFsc2UgfTsNCj4g
Kw0KPiArICAgICBpZiAoYm8tPnRiby5yZXNvdXJjZSAmJg0KPiArICAgICAgICAgYm8tPnRiby5y
ZXNvdXJjZS0+bWVtX3R5cGUgIT0gVFRNX1BMX1NZU1RFTSkNCj4gKyAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gKw0KPiArICAgICBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLCBi
by0+YWxsb3dlZF9kb21haW5zKTsNCj4gKyAgICAgcmV0dXJuIHR0bV9ib192YWxpZGF0ZSgmYm8t
PnRibywgJmJvLT5wbGFjZW1lbnQsICZjdHgpOyB9DQo+ICsNCj4gIC8qKg0KPiAgICogYW1kZ3B1
X2dlbV92YV91cGRhdGVfdm0gLXVwZGF0ZSB0aGUgYm9fdmEgaW4gaXRzIFZNDQo+ICAgKg0KPiBA
QCAtOTYyLDYgKzk4MywxNCBAQCBpbnQgYW1kZ3B1X2dlbV92YV9pb2N0bChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiAgICAgICBpZiAocikNCj4gICAgICAgICAgICAgICBn
b3RvIGVycm9yOw0KPg0KPiArICAgICBpZiAoYWJvICYmIGRybV9nZW1faXNfaW1wb3J0ZWQoJmFi
by0+dGJvLmJhc2UpICYmDQo+ICsgICAgICAgICAoYXJncy0+b3BlcmF0aW9uID09IEFNREdQVV9W
QV9PUF9NQVAgfHwNCj4gKyAgICAgICAgICBhcmdzLT5vcGVyYXRpb24gPT0gQU1ER1BVX1ZBX09Q
X1JFUExBQ0UpKSB7DQo+ICsgICAgICAgICAgICAgciA9IGFtZGdwdV9nZW1fdmFfbWFrZV9yZXNp
ZGVudChhYm8pOw0KPiArICAgICAgICAgICAgIGlmIChyKQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnJvcjsNCj4gKyAgICAgfQ0KPiArDQo+ICAgICAgIHN3aXRjaCAoYXJncy0+b3Bl
cmF0aW9uKSB7DQo+ICAgICAgIGNhc2UgQU1ER1BVX1ZBX09QX01BUDoNCj4gICAgICAgICAgICAg
ICByID0gYW1kZ3B1X3ZtX2JvX21hcChhZGV2LCBib192YSwgYXJncy0+dmFfYWRkcmVzcywNCg0K
