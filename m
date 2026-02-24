Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB0AEFB7E1
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 02:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C65510E486;
	Tue, 24 Feb 2026 02:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgYcN7Wa";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AFF10E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 02:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyndT+2YeqrSuz/oStHU0z4QXTei8XzJJuwIiBEub/es9V87ZtEYONl+RGdR5s0kgm31gTmS1hMLq55QbeqWXGaUY2HQgNpGqBZ/m8BOj3oWNyMW6xGg3ph7Sl05xkGyTW6IjZIVDZjO7xXWnYCQ2zzycYHGLOw1vQXs75334P5BHxAQ1twUM/YR+Tcr3W93rys+PIXuqc7uICch0pclVz3JQg+gB/C45RLxgnG5bRmTbFtvT3BS8bg8E33otGjY5g7XKDsC2LpdUhwyflWgavZUohwo/UywC1XUwdVUqT5NIo/0Isf7j9lTVofXRcXTWdcdJeTj40sNFaV/Hl2XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5hEflEUS0Q9ZELYf9S2tVk9PyFGS3ZRSaitzHIGrsU=;
 b=d6dInqSejPp2kxFJIGqGuaKmxkm4uKVmMeUVR+ib+F20aA1jkLvUyQ9mDqzkWLIvG/kd7K3rVlG9KWJWNqSDsJy3KYfqNQYrtSFG551NXO3Mo52FhE9dfqlXdaFgeFnFFnVFSvR3OY+iIoCQy0lN9yoMFAp/dpGC/ifT0f4UFtLL5xGctFbkm8Qv9Oi+n+V/xQIvBKsbhmS08a9VmHA5zePZPHtKlpbx/7Q7uINOX0j98k92/mowz81H9PoNPGbu4JoCU3so17eCwiCNu4eQoeOBxs8duK5rF87wm/JnGKTdmyfVjGDT3mhpR7aS0hWrFF/7WVZrH5/OOZtC5i7f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5hEflEUS0Q9ZELYf9S2tVk9PyFGS3ZRSaitzHIGrsU=;
 b=YgYcN7Wa08U0Yv1CDQL8B8pjp+rILRfqc7Gz7k5Kv06Cl9Rpf2cL9dCwxDlATlA4eO4PTdUr9XyQMX2UcRpUrCUNmel3Yby4R7yL6MC7bkC7Gr/w29AaQTrJrLYhdscJ3jfW+RMgPwuSS4jGiMe4a8f8OFDsmHkmmsJ0kJKrZ8o=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Tue, 24 Feb 2026 02:41:47 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 02:41:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Bart Van Assche <bart.vanassche@linux.dev>, Peter Zijlstra
 <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marco Elver
 <elver@google.com>, Christoph Hellwig <hch@lst.de>, Steven Rostedt
 <rostedt@goodmis.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan
 Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn
 <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 07/62] drm/amdgpu: Unlock a mutex before destroying it
Thread-Topic: [PATCH 07/62] drm/amdgpu: Unlock a mutex before destroying it
Thread-Index: AQHcpRAA+RbAR6Bo6k+p/ZYEdV4mALWRI8Kg
Date: Tue, 24 Feb 2026 02:41:46 +0000
Message-ID: <DM6PR12MB29727B8394F53F1A0282D7E98274A@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
 <20260223220102.2158611-8-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-8-bart.vanassche@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-24T02:40:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DS4PR12MB9636:EE_
x-ms-office365-filtering-correlation-id: d3493996-f2ee-4b69-8dd5-08de734e4126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ckRUMndlbW53RkpsMExPL3B5bXNESEYvaW14MmcrT2UvakIxU3A4VGxpNDdL?=
 =?utf-8?B?SEtwSTluUHVlNm5vVWZOM0lmaHM5dlp4eTlTR09peXVGOGludnl0NHBYVWdn?=
 =?utf-8?B?WC9uUk50RlJpbnlZa1FUOGI5VHkxVUtVYlZxMkVpNXBEMURJd0h4Vk91eUZw?=
 =?utf-8?B?eDYzVFFTMk4yaXZKWmxWdk9FT2luTnJ0cWNSTnFQUERrc25rYytiSGkzVEJL?=
 =?utf-8?B?clcwNFM2NFlmQUNDL2NCc2o3azFzZE1DRmNoN0p4Y3hMN2NrQWkxalZkbitT?=
 =?utf-8?B?VGZkaCttMkROL2p6VVBFK2x3dk5KUUZLMWg1S1NtQ05uVkFUdWpxeFpKaTdt?=
 =?utf-8?B?U1FPV240cm40N2wzYU9SMHpVc29iYkFqUWxzREVTMDdjcDY2UFNUWlcwY2Jv?=
 =?utf-8?B?Q2pTb0UzVlR6NnY4SmtlY2U4L0VLaUpUREF1VnBQY3d5UlBLU0d6QzNWQkcv?=
 =?utf-8?B?V0w2cG9CK2pwODZ0SFYvR2VKRUpZU1J0UU4ydXVFdW5GYjF4TERSR05YT1ZJ?=
 =?utf-8?B?MmtBOGp2ZkNQYlR4TDgwKzZIYjdjUnhyaGlTZ2Q4Tkh3czhTOGh6OUlnbExQ?=
 =?utf-8?B?bmNSSGNaMmNTNHNuNEE1eWZad25JN3VEbG5rMkpMYjVNdHJsQXFMNVhwVitI?=
 =?utf-8?B?a2ZoblF0ZW1oYlc0ZnFVMTNTaFFuMkNrNVgvTktjc3VNbGV3QzV1QkxuQTAy?=
 =?utf-8?B?ZEdyUVRxRzJ0LzYvN3ZjdXZBeEExYk93dks4aG9wVnRHQ3hESkEvN1ZwcWlL?=
 =?utf-8?B?aFFDMmRpYlc2Njl3M0xCRWpKWENqZythWkc5SE85eGEwN3NyRW9Fc2JaTlJF?=
 =?utf-8?B?Q01ZVHBBUU9jMXpMaWVnaVJxVjQ1U2Z1T2dSdjdiaEJmVTMxcHgxckNVYVlX?=
 =?utf-8?B?N3kzejVJd2NkSmVhY0kyUm42alNIeW5wMmFwZ3VRSjlwZVhCZjcrWnRvNE1E?=
 =?utf-8?B?bXRFam5jV3A2Wno0VzlKZXRJU1pDbUZGMEkyWldmSFFXTDNQNzlDNXg2b3Rn?=
 =?utf-8?B?dXdaTExnT01RUnBYT3JkZGhFUllDc2F5dDBnZGovNVdMWkRUWkJicmExU0F2?=
 =?utf-8?B?WVlPMVYrOU1OLzVkUzFtL0pkaDJKOG55ZUIrbUY0Yi9CZ3lNbFdXVUM0TTVX?=
 =?utf-8?B?RnpCTzFzTjkrSTlQYitwVHdySUVMY1NoQlFnYysxQ24zM0lrWDg2MjcwWTg1?=
 =?utf-8?B?M25xdWtuU1JDRTNjd0FsYVFGSXRFaGFxbldESUpjUjNJblRCaHJOLzdkVkFp?=
 =?utf-8?B?SC92eEJ1KytpMnN1bm05M2laYVJwbXRzaVNzSExMV1J5VmVBb0dzVzJZRXV0?=
 =?utf-8?B?cjRlYkxkcDdpTWtDWVRWd2VnUGhENlBaWk1Yd2xTVmRlWkVEMGJLYWhLaEdS?=
 =?utf-8?B?eE5Gc3AyRXBhSXBpOHZ5T2hiZGlyTWhuUGl3NjhFRytVUkMxcmw3UlltK2xP?=
 =?utf-8?B?QWtYQ3Y0ZXNIOHFCdkJ4aU0ybFljL3RTSE5GbzY2L2JBMmRUTUxoNXhxUks4?=
 =?utf-8?B?ZFhHNUJySDlxUnJqS2pVVTd3V3NsdEVtZm5RanRQRTdFcmZzUFdncTM2K0tk?=
 =?utf-8?B?WkVKMFpXQ1VPTE9ITWpuQzlNaW1peU9ubGRFWHZFZXdaSFVZR2Y5a2dQOGFq?=
 =?utf-8?B?M1d0ejdYRWhRT096WnRZOC94Wk1ja2hsekl6NWdNWmFCZzdESzQxNStDZUtO?=
 =?utf-8?B?S3djUVJKajR0Q1RwT2c0OHIzS0E2bTJaNm1UQXRnZ3pwTnBVNGxhRWs0ckNE?=
 =?utf-8?B?bGRIVDVUdkVPbUFRQzNEVzE1WEZNWit4TGRHRzk0OWRpYkZVRGY0bkN5alJG?=
 =?utf-8?B?QW9CY3hnZGlGVy8yMXVxNHJkVmVzVU1CK2FqN3ZrNUdyYXNsWG4yYmIzd0RP?=
 =?utf-8?B?cGU2UTVaY0E4WExsSnhJUWxkUlNieExzWUJBRDd6NTRZUUV3UVplTTZONUFZ?=
 =?utf-8?B?bG4zMkIzQlBuWFUrR09IbXRJekFQRi9RcGY3MTBRQ2N2Wnd1Qk1ocldxQjNQ?=
 =?utf-8?B?NWZFVzZhWjNQTzRTRzdBVVNNcUVaSkdzSERlZnZBcmNQK0ErTXFzcnJ0L3NK?=
 =?utf-8?B?U3c4Q2EwVWxDMUFOaEJvSWZmNFNaOTFGMWx0RitSWS94L1ByNGIzbGVEUzRT?=
 =?utf-8?B?TFhoL1pRbFBvSG44VjdDYjRQc2lmN2dWV25vcXdteVdLZ1dFVHcvd0FRMjRt?=
 =?utf-8?Q?lfaPUrhaVfkhkS4wHQ1vhSI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGoxb3pkelNDK1Z4OXQwLzMzSWE2SU5PTWRHNUFLMUxxanFIc3hxckJUSVRE?=
 =?utf-8?B?ZnBObU1LNVpDUWhzK01wcFpNMTNOWDIwZUJIS1hrZ29xS0ZJL3Vvc1R5UXpQ?=
 =?utf-8?B?N3JNVjd3amNIUjNlaW01WjFnclIxenRyVW8va1dYVmVmbVMzMnE0MFRzNFVx?=
 =?utf-8?B?QkN0SHBUVGtKTld4NnNvOG1OdDZ6UzJTMURFcmVsaHNPT2NsS0JValBMUGtV?=
 =?utf-8?B?a0lWY3NQLzBacGhWaGxoWXNQejdsczByV29HRkRjN3FCSDFZb29yK09rcGZY?=
 =?utf-8?B?QS9pOVJhNVJ3R1hlNS9sNDRpc0RvUkN4K2huV1B1eWFxaVAyaEkxMFlXZWpo?=
 =?utf-8?B?aGErZnBLcnJJczd3TncxaURYQUZJV2hURENKb3VsVklUdzNJUnQyNlUrT2VV?=
 =?utf-8?B?MlIyUnYxSVpBYzRLbnVIZEpPWllYMjkxTUJiclh6ZjNhbXB4WFVRRURZSUVW?=
 =?utf-8?B?WmphZ1gwSStzdG1BU1JpVW1zNUVYVk82OTVucVZwZ0RXdkltNGs2N1dQbzJp?=
 =?utf-8?B?WmpZSjlYR0dVemIza29qa0pNUWlNNEM2K2s1Yis4Z0w4MnBFQXZlbkVrdUdD?=
 =?utf-8?B?ZXl4b1RzaFE0eXVqV1Y2TUVHL2FKRWlMejhBbHZGOTIzNWJJTWdod3VMajFk?=
 =?utf-8?B?OGZ6VU1adTFEeGsrc0RBQlBpN2o4RkU0azQ3MDhpSm5talpBcndsSTEvTnV2?=
 =?utf-8?B?ZStRZ3RGemhWQmRFMTBrbWkyOWxQNkFuOEZETCtaT2ZLS2Q4bS9WY2M2STBl?=
 =?utf-8?B?V1VxV1NMblp1NUlIVER2VUpGZU52VXJCV1JkdlpsRFIwN1ZkWTZPNlVCa1VL?=
 =?utf-8?B?a3RKdkJHZHBiRWdRMG54azlCL0RJWERQRDhKbTJIaWhneEZTdlFXNHplNXgy?=
 =?utf-8?B?UmJwNmJHKytzM2JBM05MbjJmaUQwWlhUR0lObGRHYjBUTitQQnA4ZGdMa09X?=
 =?utf-8?B?bTYyUGtXbVFXanJTdlp1WHFDUExORWMxRTlDdno4eG1hdVNUVVVvNXBWTXF5?=
 =?utf-8?B?Zm51QSs2ZzM2enVoNmdYYzk2bjZkenhNZDVyZ1ZoQ1E2cFpoZ0VaTVc4Z2c0?=
 =?utf-8?B?Nkg3SUoxY2lsbFlwSjRGREdmQmIvSlYvelVacU1RWis0QlBuT0l6bEYxdW5n?=
 =?utf-8?B?UU15WVdWVE9XTWV3eXhqcFhEWmlGUklvV0REZTFZZFAvcVozNCtKYVpCYzR2?=
 =?utf-8?B?aklsdG8wTjUzdlUvMTd5R0tJUE92ZnN3Q0lHdDdoSGZITU1pVitKM0hDZmRP?=
 =?utf-8?B?OVBsRVR3VTBud2RXR2F3UDJ2VFlvcFdWb0F0S3plTkpyU3RnWXo2OGZHRmVJ?=
 =?utf-8?B?b2RVbVMwbmpOaEJIaVBTMFVZcEVORkQ1WDEzYlI4aEgyQlh1TER0WTAxTjdx?=
 =?utf-8?B?aHpTbXRNYTd1Zi9scHNyMUtPd0RPVXlVQlB6aTh6OVBtd0pRRDFsVEZCTC93?=
 =?utf-8?B?K29xN0c2eFk2QXZVTHUrclVzMXpaMVRGT1A2c0plVm51MWRtMVVMTW5rVUZu?=
 =?utf-8?B?ZUliZW91NXNnOE5RMVdwaDBjK3dna3daT0xDeExQUHJGYm1pb0NpYnV5WXhx?=
 =?utf-8?B?ZlgwQ3ZlRU9VMmhZdG1qbWRYS1BnZFpaRGk2blZPL1lZQTFiYWN3RFlEdnVF?=
 =?utf-8?B?V0V2Mk1leURFOGFDZGp1cTJTaXY2akZkY0tiVUdHaEtJYWV4ekt6Skk3NUhV?=
 =?utf-8?B?bUhsYStkNm0waCtMelBncTk4NWRweHRtUWlnRHJCSlRJL1JoVTlSVlowSm5E?=
 =?utf-8?B?dHJ5Ujh5WDhDaE90V2RuMWpXQ1dubU1BaElKM2dCU0tzenVhMkluUXR6UE1P?=
 =?utf-8?B?MURGajBkdlVBZWRVSzBvUVpRbXBjMGJQTlNqVzNDdXUrM0VKRmtHMTZpdExi?=
 =?utf-8?B?ZVBMRkVISk16ZW5HUmtweFBqMXRPN0NlN2NtNm9zOWQ5REJuTXo1TlRPRkRt?=
 =?utf-8?B?SmFiOGZYWTZlY0dqL2NTYmg4RlJRaUh6OTIwYlNUb21tWWFURGlvV1hEOHhD?=
 =?utf-8?B?ME8vaDA0dWxWUnhYeVhnOVBWYWJpc3RtZlNoRzljTU9tUHRoSkJuV21oK0xK?=
 =?utf-8?B?dElISmZNYnZLc1dwajExZ2VWa21FKzVWVFhhSnpzQXF0elNXNFJGeU5UTkIr?=
 =?utf-8?B?YXpQOTgwMEFER29RbHpxN2wzUVd5bHQrbXlLeENhNlFjRGNVelFtcEVsanJ2?=
 =?utf-8?B?cWRiTG5PVllnbFFoazZIS1lRWG5NOVZOWXJJemxsWXFMWmNQQXZRcW8zRzE2?=
 =?utf-8?Q?4oAGZyiO3NprW9gpIx4CacNUuLRofiUhB1cQMdSbpQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3493996-f2ee-4b69-8dd5-08de734e4126
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 02:41:47.0580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agehHRkZA+URcvGpM61bKZ4O9hhIMAy2/b9Nq+JrlSf3naBZz7DR3g/awkukyYel
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
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
Cg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVz
dCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJh
cnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAbGludXguZGV2Pg0KU2VudDogVHVlc2RheSwg
RmVicnVhcnkgMjQsIDIwMjYgNjowMCBBTQ0KVG86IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4NCkNjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+OyBCb3F1biBGZW5nIDxib3F1bkBrZXJuZWwub3JnPjsgV2Fp
bWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IE1hcmNvIEVsdmVyIDxlbHZlckBnb29nbGUuY29tPjsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+OyBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz47IE5pY2sgRGVz
YXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPjsgTmF0aGFuIENoYW5jZWxsb3IgPG5h
dGhhbkBrZXJuZWwub3JnPjsgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+OyBKYW5uIEhvcm4g
PGphbm5oQGdvb2dsZS5jb20+OyBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz47
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8
S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogW1BBVENIIDA3
LzYyXSBkcm0vYW1kZ3B1OiBVbmxvY2sgYSBtdXRleCBiZWZvcmUgZGVzdHJveWluZyBpdA0KDQpb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGJhcnQudmFuYXNzY2hlQGxpbnV4LmRldi4g
TGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRT
ZW5kZXJJZGVudGlmaWNhdGlvbiBdDQoNCkZyb206IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2No
ZUBhY20ub3JnPg0KDQpNdXRleGVzIG11c3QgYmUgdW5sb2NrZWQgYmVmb3JlIHRoZXNlIGFyZSBk
ZXN0cm95ZWQuIFRoaXMgaGFzIGJlZW4gZGV0ZWN0ZWQgYnkgdGhlIENsYW5nIHRocmVhZC1zYWZl
dHkgYW5hbHl6ZXIuDQoNCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6
IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCkNjOiBIYXdraW5nIFpoYW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkZpeGVzOiBmNWU0Y2M4NDYxYzQgKCJkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgUkFTIEFDQSBkcml2
ZXIgZnJhbWV3b3JrIikNClNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2No
ZUBhY20ub3JnPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjYS5j
IHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNhLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYWNhLmMNCmluZGV4IGFmZTVjYTgxYmVlYy4uZGI3ODU4ZmUwYzNk
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjYS5jDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNhLmMNCkBAIC02NDEsNiAr
NjQxLDcgQEAgc3RhdGljIHZvaWQgYWNhX2Vycm9yX2Zpbmkoc3RydWN0IGFjYV9lcnJvciAqYWVy
cikNCiAgICAgICAgICAgICAgICBhY2FfYmFua19lcnJvcl9yZW1vdmUoYWVyciwgYmFua19lcnJv
cik7DQoNCiBvdXRfdW5sb2NrOg0KKyAgICAgICBtdXRleF91bmxvY2soJmFlcnItPmxvY2spOw0K
ICAgICAgICBtdXRleF9kZXN0cm95KCZhZXJyLT5sb2NrKTsNCiB9DQoNCg==
