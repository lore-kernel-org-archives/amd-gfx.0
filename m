Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BD9C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 06:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E00210E59B;
	Fri, 16 Aug 2024 06:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpoiO2uO";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00D710E59B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKq8bwDhfzxm9EA6AK0cshFk93lKbgMqQmsbo15Y8YXeBJRl0rWuId0xuzWlbIHMiH9c+edIEuFTKSZ26hcIT6Ceb+Atjqi51amMtxivwApXamjL5NJF+gEqKDGVC4YVrIfT8PGOOiSqJrVUF+J4bKvh3/LYWkCv/v1hYvhOrNxkqb7Lrt28SHGrrfuLsQhvuc1GR4t8O+E/6xSQKeIK7YzuoASIbKkWqQdgYjghZAseBDyQYXKTVm25ISihkulIhcrA2+MJswdkEB1I0hNonI+vBpq0AggROHDDZZncWLczv1Eid8OXiY5gtQ02/sZMq408KtlVocSvRTeUoNQoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMDl08t2XXudM5AoFdUY6Nh23X1kneE8O1CF/4ISZDE=;
 b=UjSs7lEFlDz5G2Z/e4uVrte/THcuOpBHwGiaWJWsK+eu4gJ8rz3s68/U7ykQzTR5vLNgfX7b+vpyeEvCE8RmbPV0UXXtWLIZadQC1kiFFYsR+FwqBw4PF6ZX5uA3jjgemVA8llNljZnGzv3ZyFnfNMfQyyIrSpXPU40lzPqsxKSQOSmOz48T4em1iJ9P2acXJMNE5gK/lMYkQNpKMUkLH2urpHDg/QjxnhLBskxJ+FULAlhkfg6+zoopGM2MhukvJDYKCKF6/uJnNzgm4kONahhyH3NW/4svNAOw4+NiiWHDnr5TBmDOVlq8PxHo86KvTVBlzREQaKMzeb1+LnfxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMDl08t2XXudM5AoFdUY6Nh23X1kneE8O1CF/4ISZDE=;
 b=jpoiO2uO04UeiMo+Al1gmYQ+3QEwohL+h64u0Ol9gJXxFXNNWR8Yzt40P4uMDBoCKCEhEFCWHQHFMXhBEdyql9PCpsfXGCs6q6FLEVT0yauxm89AKx67U/MPk7rhTnrUDRbuF04qyXUFLFswyarHvpsw1XC1EOYzeWjovT1ZIQA=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 06:39:05 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 06:39:04 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "Huang, Trigger" <Trigger.Huang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Thread-Index: AQHa7we2tU++i7Ut3EaBHHrGEVd6bbIoer0AgADp8wCAAArjAA==
Date: Fri, 16 Aug 2024 06:39:04 +0000
Message-ID: <SA1PR12MB7442C8683B3C7082967C07C1FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-2-Trigger.Huang@amd.com>
 <CADnq5_NumwJ6ujpJERTF7gK7TAJMkG7MNMNgrtr3=k8pqYnBvg@mail.gmail.com>
 <SA1PR12MB74425F710D53EAA007A062F2FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB74425F710D53EAA007A062F2FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8eef2a34-773f-4030-9d05-7e64764eb1aa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-16T05:58:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|MW4PR12MB5667:EE_
x-ms-office365-filtering-correlation-id: 4d24449f-9134-4ef0-32c1-08dcbdbe1f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0VHcWFETU1vZkRzTytBSHE0Q08wNzRxbnV4Wkh6dkk1RnFlTUFOS1AxR2oz?=
 =?utf-8?B?dzFiL0Rwejhjbll6cE91dVJGaDBVR1NTeGdOS1Z6L0hwQVdRMWg1MkRoeXZ4?=
 =?utf-8?B?SENybFBKVUg1MCtrWVZWUjkrMWNoSDJVWEFEQ3R0Y1ZyUFBqTmZhVFh4TzYw?=
 =?utf-8?B?UitSMWtzaWhqb0Z3Qjg3eVZQQWQ4Zmg2bWFNM0llRXVReHhqMVh3SGVMYTMz?=
 =?utf-8?B?RVpQMUdoZStGRkZLLzhZSDJialBZYXBSdi9sNitoWms5NlFsT1p4ZExaN0dm?=
 =?utf-8?B?VXgzRllWN1ExZndwRlQxOTNzM1QycFdzNXg2S1Rkams3ZUxCSHNkbFQ0cjFO?=
 =?utf-8?B?MDBkbnYxWThMbjlNQzRPWmNUVUV5djZtcXhyaFhoV3ZjbnF2UDRPejl5WGlG?=
 =?utf-8?B?MXg2WjRhdldVbUg5YXNPMTBaR2xUWVN0NGY4NFNjMXB2VlpUZU5wNS9PY2x2?=
 =?utf-8?B?ZzM3TFdMeW4vRnZ0YjZKc1FuaDNoR1d3NlVWcUJDUlhSMVlUQURJeEkvaDFH?=
 =?utf-8?B?VjJGd1VkeWplcDRoZDJvcFpjVE02ZkVYblFmbFp1ZkUrRXE0YjRqZEgyVHNQ?=
 =?utf-8?B?RTg2Y1U1OVQzZFBIVHl5VGpFN3VZUnBKMVhWL0EyOFBGOWp4YmgvcjlRTzUv?=
 =?utf-8?B?TFlzVlVGcjVrK011T3NEVTZ6MWJFOS9FV3lWbWI0dWd2ZVpZNjAxNFNUREZn?=
 =?utf-8?B?Vzh3MW9xSStHR0FwU0xYbXM1a0ErMXk4VkdQZXluZFZ3UDFwcjB4WWZzVzR5?=
 =?utf-8?B?bmhlSVd1NDA3SGVSMmdaNkhHWFhXdjdXU1VwTFZYbmV0Y0dQL1VNZzR5NDU3?=
 =?utf-8?B?SVU4anVBOXZPZzhqcy8vTTExUkIvMk1od09uc29lZC94eHZMSHQxRGFTVFl0?=
 =?utf-8?B?Vk52UFBkTms1ZHc3dDV4T0M4Ly9VQ09uYWVMRk93K2cycE5xQnFySmNEc1dX?=
 =?utf-8?B?cldjQUR1Rk5UQ3ZjTWRXNDVnSHhybVNHVDUrTkE5ajRKbEJYSXBGUEhvaEww?=
 =?utf-8?B?ODBYcDJkWmhxWWJYcjJLL085TFpSL0RuaXVlWmlXbnArY2dpeHZ0Qnl5bU1M?=
 =?utf-8?B?a1N2bDNuNkNKU2pPRFJsdUlRNHlOL0czb3RtZ0ZaK3RpVFBMZnB3UGRhaVF0?=
 =?utf-8?B?QitDUTlDcTh5ZVVQN2JNOGJhdW9YTndRTUlST20rNGE2ZXBsaVN4Y2lVRW9i?=
 =?utf-8?B?bWVqZUJZQUNGbTg5c1lUaWUxVlBQWXV4VS9jaTRrQ2pyTkJ4VWxwVjZicEdj?=
 =?utf-8?B?RXdMWE1uclVDQ3pKVGFKaGZ6WkdtYlZndkZEVHdRSFZub1lEWkpBQ3F3SjlN?=
 =?utf-8?B?YjlJNTRsZ2RSbG5XZ2gzenA1aDB1N1hxejZsMGJhYXFrbm9vdG9pZ1ZiZEo5?=
 =?utf-8?B?YlMrODEzWFN0b3JuREdhV3VER25sRTk2YmhVbjVTeXAxK01PdWhvODFKMFEw?=
 =?utf-8?B?R0lFM2dDMEU3V3pNMlZnMEFrZXRHd3dnVzQ1YW1SdGw4L2xKT1Q2TnpYOTRm?=
 =?utf-8?B?dVczM3dBaE1nd3pPVFhzQmV1UDdpSElZeXNwckh0ZWttTFRCREYyU0YrNlBz?=
 =?utf-8?B?ZGtKSm9wTTdKbkVWYXZXSTFSZXFNVEsyTHk2UmoyQXVoTXRLYlBpZGVKWWRw?=
 =?utf-8?B?cS9kdjd0MGg2OGVZNVo5U1Y4T0MveXJlaWVRY0g5QngxVDUvcmdld0tCSjRn?=
 =?utf-8?B?TGsrM01xT0hVMnhsN1Q1Sm5OK1RPdFp0TnkvTldVVDk4azVEcnR1VjlreFRP?=
 =?utf-8?B?Wmp6ZUhXZzJERFhCYjdhQVl4SGdwaStWci9Yd1E3M0MvUi8yUUdTVjFFVlhL?=
 =?utf-8?B?T2paNklDdmhON0hkZlRSdjhTUXg5bEVOVnMyK2Zxdm5JRUE1Q3E3T1NCK2dR?=
 =?utf-8?B?WVVuRDVlVGlZZENMOXFiOWpUUHAwSDVwamQ3UndjdUpMU0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1BGSVRiS2hQdXluem9NVjlVMHpTdUVLWWRoR2FETzhlVUk5SHBtYlcyN3B4?=
 =?utf-8?B?d2VKb3R6eDVrTWRxS1pLQkxvVk9OU3hlb0paK0crWXgwTUw3RDQxS29aQm52?=
 =?utf-8?B?VG01MTNFYzNDYVFJRkY2L1VhZTFXM0ZHMXZOK1UveHlXanoydDdVV1J1RnA3?=
 =?utf-8?B?ZW1vOS9HVCtFeGY1V3JKSnU0cmhTeHg2WE1IK3lXSjRxdlFWZ2FmK2Z4c01T?=
 =?utf-8?B?Z0p2R0wrNFh0cE05WDJUbWZSZXN6SnUwdnpLWlM0S0J1d1dLWjM1NlZBUHMy?=
 =?utf-8?B?Rm5OdU94eVpCSEZJODNkSlhqSjZEVXJEM1o1bERBQ2RhMUgxOUhQWjcvdVdH?=
 =?utf-8?B?bUNUU0phRVlhRDVDYVYzV0xsbEtrTDQ1SU5sLzBrbXlWbWlaTUEwL2tZRytM?=
 =?utf-8?B?SlJRS3RaWTY0SEtzb2pLbmwvRjYrMUhjaTQyM3NOSmt5YWl4djZyK2ZUL2I4?=
 =?utf-8?B?dGoxZVM5dVlzMTE5UitLaVgwVnJRS3RkaHpZdDRFTVJyYml0R21oTmFGQjdw?=
 =?utf-8?B?bGVFeU9KUkNWQnpmSmovNGpWTWdQd1dKSlRWMFp1ekYyenpaM2Z2b1VMbFBD?=
 =?utf-8?B?cVk4Uk1mQ3lsOEpJUUhKTDVmWXR6aFZQb2YzWTNuV3FtN1RYMUNKbkdKckNU?=
 =?utf-8?B?UHB0cWF5M1lYcjFpcjVYYjZqTmJOazhWZ2ZUdHJZbWRadVFjekdmbkovaXFI?=
 =?utf-8?B?RmV1bHRqb0NLMHJ0WGZkWkFCRFozdGZrWFZOdko1VkFQWUJxTnhYSm1CWnJQ?=
 =?utf-8?B?Q2RHeHRWZmZBYndGSzFKNDFyc2E3Z1VFV21GRENqbmxoSVJ0OXVBeUFadGxQ?=
 =?utf-8?B?Tm90UzJybjd3Tkluc0dFeHFJVldjbEhVZ3hQS0IvbFNTZ09tc0N2cTVsdUNh?=
 =?utf-8?B?RFVPZUNsaHhTbk92cGVlTUpSaUxDME1tZkNkZXhPZ1Y5WWtERHZQdTl0SklM?=
 =?utf-8?B?RFJKL011VHlQcjV0Mm91MDJ6Zk4vdGJUcFllQ2piMUExNnZLS091QjZ2WkVP?=
 =?utf-8?B?N2RnbXJqellZN1U3VXVvdGNVcTNnc3Jsc3Q1d1RWWU4yV04zUG9NeHYxZ3Rq?=
 =?utf-8?B?RW5NTlcvaE8waVZOZUNHbE9GQ0VHZDhQK0xnd2daUndZYjFYRTljREhTeFRj?=
 =?utf-8?B?S2dDNFhlOUl3TjUvMkM3a0UyTjJ2cE9KVjRnbUhyeTAyakRoa3ZBMTBiSUgv?=
 =?utf-8?B?UEx3YW5sWjB2ekNjc0FXWkZoNjRyZEVZNng3T2w5UzViclQ1TEVKNDlCa1VL?=
 =?utf-8?B?Y056Z1pRbFZmaytBWkxpd2ZjT2ZXRytaSWZmd0RZRDIrUG5aNWorSXd5cmh1?=
 =?utf-8?B?UU5UVHBwYzExS2o3dXNTQUZWQ28zVEhURkNmbFdlRGdwMlRFMzJHcUFXUDdR?=
 =?utf-8?B?anNYL0dpcmNROWlZRndxWUQzQzBsL3c2dStCd2VOQXRmVWVLNUNTdjNNRkRI?=
 =?utf-8?B?MlBaZTAzVkc1MlV1Q2JDTVBGeCtscEh2b1VnWUE3dUhBb2dWdDV5dWlyNllI?=
 =?utf-8?B?Wk1PV1Jkb2V5S0NneU4wbWtBd2dmZGM5dmJtbVIxaUxKNVJiNTNWa25QY3dN?=
 =?utf-8?B?NTEvTGtBMkZaN0ZiWFBXRXUwYXdBTVBJYjUrWkFNZ0d5ZEU2eXZOOFBZNmtS?=
 =?utf-8?B?RTN6bmdNLzQ3QmhNazdjdHNPbzFwM3JianJrQ0ZsajhsYlE2cDBGaCsvaXZy?=
 =?utf-8?B?UFI3SkdFZklSS3o5UzVzL0ZseS9tV3NmbmV1Rlo5MmwyaEc1cHcvR2JLZkMx?=
 =?utf-8?B?L2piUVcweDUyWkovWFExQk9TdkFpQmh1alg0Qk51cHBGaitwazNRcnpZUDRK?=
 =?utf-8?B?dG1XcXdSZGZmaEg2THhTNFNXSnc4cWlXTjNBY3diYVlJUlVuczI4TkhxNEFw?=
 =?utf-8?B?ZzVjcXZOcDNRK0xMU3pXN0JnaHd0RGxoemhBRys2S20rMjg2Q0pvci9DK2dZ?=
 =?utf-8?B?M2NqaVBVbjFKaEdXNTljb3BnWURQcDRTdGhtejZPYksvbld1Z1RkSEV0UlB6?=
 =?utf-8?B?VHJmUHNuS1kvWUFzNUFkV25FaVRvdDVjanNlZkJwc1cxMlZaalorSmgyTms5?=
 =?utf-8?B?L3pkQnI2cDRrc3Awb2gzMnFwSEgvWGQ1bUZIOGRIUWYrQjJPVUxvWnRydDlO?=
 =?utf-8?Q?y3S0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d24449f-9134-4ef0-32c1-08dcbdbe1f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 06:39:04.9185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0dvKh6mNp7YfkgC8sFfIEFdAw1jUbHJ0rg6U9hkHxb9DSoQqXJb5hPkjqmU7HIvscsA2R0ZTgT6Xb6MSnRe+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gSHVhbmcsIFRy
aWdnZXINCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgMjozNiBQTQ0KPiBUbzogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+Ow0KPiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBBZGQgZ3B1X2NvcmVkdW1wIHBhcmFtZXRlcg0K
Pg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBP
bmx5XQ0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1
dGlvbiBPbmx5XQ0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
QWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBB
dWd1c3QgMTYsIDIwMjQgMTI6MDIgQU0NCj4gPiBUbzogSHVhbmcsIFRyaWdnZXIgPFRyaWdnZXIu
SHVhbmdAYW1kLmNvbT4NCj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEto
YXRyaSwgU3VuaWwNCj4gPiA8U3VuaWwuS2hhdHJpQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzNdIGRybS9hbWRncHU6IEFkZCBncHVfY29yZWR1bXAgcGFyYW1ldGVyDQo+ID4NCj4gPiBP
biBUaHUsIEF1ZyAxNSwgMjAyNCBhdCA3OjM54oCvQU0gPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4g
d3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0Bh
bWQuY29tPg0KPiA+ID4NCj4gPiA+IEFkZCBuZXcgc2VwYXJhdGUgcGFyYW1ldGVyIHRvIGNvbnRy
b2wgR1BVIGNvcmVkdW1wIHByb2NlZHVyZS4gVGhpcw0KPiA+ID4gY2FuIGJlIHVzZWQgdG8gZGVj
b3VwbGUgdGhlIGNvcmVkdW1wIHByb2NlZHVyZSBmcm9tIGdwdSByZWNvdmVyeQ0KPiA+ID4gcHJv
Y2VkdXJlDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dl
ci5IdWFuZ0BhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1LmggICAgIHwgMSArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jIHwgOCArKysrKysrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oDQo+ID4gPiBpbmRleCA5MzdkZTIxYTcxNDIuLjRkZDQ2NWFkMTRhZiAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+ID4gQEAgLTIwMSw2ICsy
MDEsNyBAQCBleHRlcm4gdWludCBhbWRncHVfZm9yY2VfbG9uZ190cmFpbmluZzsgIGV4dGVybg0K
PiA+ID4gaW50IGFtZGdwdV9sYnB3OyAgZXh0ZXJuIGludCBhbWRncHVfY29tcHV0ZV9tdWx0aXBp
cGU7ICBleHRlcm4gaW50DQo+ID4gPiBhbWRncHVfZ3B1X3JlY292ZXJ5Ow0KPiA+ID4gK2V4dGVy
biBpbnQgYW1kZ3B1X2dwdV9jb3JlZHVtcDsNCj4gPiA+ICBleHRlcm4gaW50IGFtZGdwdV9lbXVf
bW9kZTsNCj4gPiA+ICBleHRlcm4gdWludCBhbWRncHVfc211X21lbW9yeV9wb29sX3NpemU7ICBl
eHRlcm4gaW50DQo+ID4gPiBhbWRncHVfc211X3BwdGFibGVfaWQ7IGRpZmYgLS1naXQNCj4gPiA+
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4gaW5kZXggYjk1Mjk5NDhm
MmIyLi5jNWQzNTc0MjAyMzYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4gQEAgLTE3OCw2ICsxNzgsNyBAQCB1aW50IGFtZGdwdV9m
b3JjZV9sb25nX3RyYWluaW5nOyAgaW50DQo+ID4gYW1kZ3B1X2xicHcNCj4gPiA+ID0gLTE7ICBp
bnQgYW1kZ3B1X2NvbXB1dGVfbXVsdGlwaXBlID0gLTE7ICBpbnQgYW1kZ3B1X2dwdV9yZWNvdmVy
eSA9DQo+ID4gPiAtMTsgLyogYXV0byAqLw0KPiA+ID4gK2ludCBhbWRncHVfZ3B1X2NvcmVkdW1w
Ow0KPiA+ID4gIGludCBhbWRncHVfZW11X21vZGU7DQo+ID4gPiAgdWludCBhbWRncHVfc211X21l
bW9yeV9wb29sX3NpemU7DQo+ID4gPiAgaW50IGFtZGdwdV9zbXVfcHB0YWJsZV9pZCA9IC0xOw0K
PiA+ID4gQEAgLTU1Niw2ICs1NTcsMTMgQEAgbW9kdWxlX3BhcmFtX25hbWVkKGNvbXB1dGVfbXVs
dGlwaXBlLA0KPiA+ID4gYW1kZ3B1X2NvbXB1dGVfbXVsdGlwaXBlLCBpbnQsIDA0NDQpOw0KPiA+
IE1PRFVMRV9QQVJNX0RFU0MoZ3B1X3JlY292ZXJ5LA0KPiA+ID4gIkVuYWJsZSBHUFUgcmVjb3Zl
cnkgbWVjaGFuaXNtLCAoMSA9IGVuYWJsZSwgMCA9IGRpc2FibGUsIC0xID0NCj4gPiA+IGF1dG8p
Iik7ICBtb2R1bGVfcGFyYW1fbmFtZWQoZ3B1X3JlY292ZXJ5LCBhbWRncHVfZ3B1X3JlY292ZXJ5
LA0KPiBpbnQsDQo+ID4gPiAwNDQ0KTsNCj4gPiA+DQo+ID4gPiArLyoqDQo+ID4gPiArICogRE9D
OiBncHVfY29yZWR1bXAgKGludCkNCj4gPiA+ICsgKiBTZXQgdG8gZW5hYmxlIEdQVSBjb3JlZHVt
cCBtZWNoYW5pc20gKDEgPSBlbmFibGUsIDAgPSBkaXNhYmxlKS4NCj4gPiA+ICtUaGUgZGVmYXVs
dCBpcyAwICAqLyBNT0RVTEVfUEFSTV9ERVNDKGdwdV9jb3JlZHVtcCwgIkVuYWJsZSBHUFUNCj4g
PiA+ICtjb3JlZHVtcCBtZWNoYW5pc20sICgxID0gZW5hYmxlLCAwID0gZGlzYWJsZSAoZGVmYXVs
dCkpIik7DQo+ID4gPiArbW9kdWxlX3BhcmFtX25hbWVkKGdwdV9jb3JlZHVtcCwgYW1kZ3B1X2dw
dV9jb3JlZHVtcCwgaW50LA0KPiA+IDA0NDQpOw0KPiA+DQo+ID4gSSBkb24ndCB0aGluayB3ZSBu
ZWVkIGEgc2VwYXJhdGUgcGFyYW1ldGVyIGZvciB0aGlzLCBhbHRob3VnaCBpZiB3ZQ0KPiA+IGRv
LCB0aGlzIHdvdWxkIG5lZWQgdG8gYmUgZW5hYmxlZCBieSBkZWZhdWx0LiAgSWYgaXQgbmVlZHMg
dG8gYmUNCj4gPiBkZWNvdXBsZWQgZnJvbSByZXNldCwgdGhhdCdzIGZpbmUsIGJ1dCBJIGRvbid0
IHNlZSB0aGUgbmVlZCBmb3IgYSBzZXBhcmF0ZQ0KPiBrbm9iLg0KPiA+DQo+ID4gQWxleA0KPg0K
PiBIaSBBbGV4LA0KPiBJdCBpcyBmaW5lIHRvIGVuYWJsZSBpdCBieSBkZWZhdWx0DQo+IFRoZXJl
IGFyZSBzZXZlcmFsIGFwcGxpY2F0aW9uIHNjZW5hcmlvcyB0aGF0IEkgY2FuIHRoaW5rIG9mLg0K
PiAgICAgICAgIDEsIEN1c3RvbWVyIG1heSBuZWVkIHRvIGRvIHRoZSBjb3JlIGR1bXAgd2l0aCBn
cHVfcmVjb3ZlcnkgZGlzYWJsZWQuDQo+IFRoaXMgY2FuIGJlIHVzZWQgZm9yIEdQVSBoYW5nIGRl
YnVnDQo+ICAgICAgICAgMiwgQ3VzdG9tZXIgbWF5IG5lZWQgdG8gZGlzYWJsZSB0aGUgY29yZSBk
dW1wIHdpdGggZ3B1X3JlY292ZXJ5DQo+IGVuYWJsZWQuIFRoaXMgY2FuIGJlIHVzZWQgZm9yIHF1
aWNrIEdQVSByZWNvdmVyeSwgZXNwZWNpYWxseSBmb3Igc29tZQ0KPiBsaWdodHdlaWdodCBoYW5n
cyB0aGF0IGNhbiBiZSBwcm9jZXNzZWQgYnkgc29mdCByZWNvdmVyeSBvciBwZXIgcmluZyByZXNl
dC4NCj4gICAgICAgICAzLCBDdXN0b21lciBtYXkgbmVlZCB0byBlbmFibGUgdGhlIGNvcmUgZHVt
cCB3aXRoIGdwdV9yZWNvdmVyeQ0KPiBlbmFibGVkLiBUaGlzIGNhbiBiZSB1c2VkIGZvciBHUFUg
cmVjb3ZlcnkgYnV0IHJlY29yZCB0aGUgY29yZSBkdW1wIGZvcg0KPiBmdXJ0aGVyIGNoZWNrIGlu
IHN0cmVzcyB0ZXN0IG9yIHN5c3RlbSBoZWFsdGggY2hlY2suDQo+IEl0IHNlZW1zIG5vdCBlYXN5
IHRvIHN1cHBvcnQgYWxsIHRoZSBzY2VuYXJpb3MgYnkgb25seSB1c2luZw0KPiBhbWRncHVfZ3B1
X2NvcmVkdW1wLCByaWdodD8NCg0KU29ycnksIHRoaXMgaXMgYSB0eXBvLCBoZXJlIEkgbWVhbiBh
bWRncHVfZ3B1X3JlY292ZXJ5LCB3aGlsZSBub3QgYW1kZ3B1X2dwdV9jb3JlZHVtcC4NCg0KPg0K
PiBSZWdhcmRzLA0KPiBUcmlnZ2VyDQo+ID4NCj4gPiA+ICsNCj4gPiA+ICAvKioNCj4gPiA+ICAg
KiBET0M6IGVtdV9tb2RlIChpbnQpDQo+ID4gPiAgICogU2V0IHZhbHVlIDEgdG8gZW5hYmxlIGVt
dWxhdGlvbiBtb2RlLiBUaGlzIGlzIG9ubHkgbmVlZGVkIHdoZW4NCj4gPiA+IHJ1bm5pbmcNCj4g
PiBvbiBhbiBlbXVsYXRvci4gVGhlIGRlZmF1bHQgaXMgMCAoZGlzYWJsZWQpLg0KPiA+ID4gLS0N
Cj4gPiA+IDIuMzQuMQ0KPiA+ID4NCg==
