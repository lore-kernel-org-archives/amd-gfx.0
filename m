Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB4CCCF2E9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 11:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EC310E02B;
	Mon, 19 Jan 2026 11:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/cCLsIk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C018710E401
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 11:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiF8F5JV8fmr2gy2qSpyBA2HZVrLjToZuwzf1NRvoyxJ1gPbhIwHrOUNjcbTG8XbVzJj1bYTNP2QzJpr7v14/GEa1/rk+ppw5z9s8C7THQhv4xw/QaN14aKtoXPFYW/hntvOLug1Htqs0dAtCfQOUP5jchi4LzSt/ljjUHM4P3xUdJxlPP1Aozv+9kXtbO2fNTkbj84a9bFdugahasA0/WgZ/HsQY8PUH5nN7QK75z9ANy4qssmVh9X8DfqP6M00saGop6wyoUPqOKhFxe5iIAhKg7SJkfWQ8Shs0yxfrvZH+RRYt0EXSXgxeOOYfcE/CquzzCVQLosdTzXkSWU9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYIqtIDMRN5BlK/cul9RwZ7PQGeGPwZHcrGBYyT0lIk=;
 b=aYrbv+l+kbOjlblUwVwT7mU0co3zzPrJjZVzc6R7VXuFrQon5R69r1Gt+ImzzbxiLERev4De6UKBvX3LZEqiGMARolh4wuwHkfSDm3gJe+5Y4yor6lu++HSItOxQ+zBUskYk3abc31bjMY5eTPbRB9fkAA9AZ2zpelinQdCeAL6Il8Jx3qoJ1cO1IbT2kIL+C4Z7wWWsdYO/E8oKZGKwWocdvfz36NTKmE6RfZ/HFpVsuMqxiWW7qa0xD1ITmW/kV71Tu7TQZOGeaEbIimgzYhatWZPpureGD1UYG2ZI8UnYFGf/tU7pkxxbaUPnpE0UcdE9sy4rVEUVLLdJdAgWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYIqtIDMRN5BlK/cul9RwZ7PQGeGPwZHcrGBYyT0lIk=;
 b=W/cCLsIkkDU2r8ln/XECWlh8zdHckoauGXf24kjVUvQXiethn8tVChFwhStdAODXc9o3tHzzoKzGAmsAUpA35sbwhoVU9DDbwrD7rjflVv/r0ycVULuC48yyAW//+T8a+p1MLTEyWa1b00+/VXvk5u+ZowjnMxelA2mnq9DyVuU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 11:47:23 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 11:47:23 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Topic: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Index: AQHciHoQTQHvCiULiku9PJWO956CHLVZRycAgAATM4CAAAbQwA==
Date: Mon, 19 Jan 2026 11:47:22 +0000
Message-ID: <DS7PR12MB600522DDBA98922B7F3E318CFB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
 <0b3603e5-f6d1-4be8-80dc-e9aaaac48e40@amd.com>
 <4856897.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <4856897.vXUDI8C0e8@timur-hyperion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T11:45:13.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: deb6d113-a858-4cda-9a12-08de57508270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZVdZdkRoOWd5NkJLNitjTnBWb2QvTlIydklVVUZrTGU5MHRqUFlSMjFWQWFz?=
 =?utf-8?B?WklTR3pSU01wbS9uMWZWNWFMbFFvYWNDSktMT0NHdG5XMUVvcFhoWDFqalMx?=
 =?utf-8?B?WnA2UEtYVC9iTktXclBkdVpLeDRqSzVvUHZQY3hrajhaMXJLYXV3OTFsL2R6?=
 =?utf-8?B?c3VXUXkwUzZ4c3I4TWJlOTFJZ0dQZVVGRm9ocU9kakhWZ2Z2Y1VvZGFaRTdr?=
 =?utf-8?B?TFJxQy9yY1R4N09STUphMDV5eXBkMUZGY0NjSjZERllhdEdJMTVPN1ZhT2pC?=
 =?utf-8?B?Mk5zbjd3Y28ydi84ZU1KUk83SDFIdUdMWmdpS0F3dXhOM1lJUmdab1dPS0Yy?=
 =?utf-8?B?a2lFQWpKTG5neFA2Y1NxK0hzbzIrOEZ4Q2U2S1RzUmMxeTZyOGYwOWtlTE1p?=
 =?utf-8?B?MTA0bDVwS0Q5ZDhFWFlHQnJXQVllOUtSdURyL0t3NFdkUzA4NFY0NVAyQlJx?=
 =?utf-8?B?VFFhSTJqUDdTRFJDUUM5NlRmenRiQVVCWDhHNm4vTk1jUmdBS2k2SUM3U3hR?=
 =?utf-8?B?bG9LSlU3VlFGWGZnbStXMVhYRzRHS2xSSDgzQUtURG04OHFsTG9JSzNoazln?=
 =?utf-8?B?RVFZTmZOUEl1QzNPMVF6KzlUWXNrUlJpSkpPVDJISU54Q3hYVlA1QzV5STRZ?=
 =?utf-8?B?bDVWRlNGejNXNThlR3VZaWpkQWNPQTh3TXpFcUpTcHZpemx1Mzh3TmkvT2Z1?=
 =?utf-8?B?bGR6b0I2eVcvSDVHbGJpMmJFY0ZuWlkyTGgwVVpmSWJWR2FwYU5IQnU1ditq?=
 =?utf-8?B?dlRYWVBDbEliK293M29jK0x1UTQzMWZwQjZmVjJEUzJ6OVo3djhYNHFtMnBa?=
 =?utf-8?B?ckNzNU44eXZiQmVKVzJ6T3NhbmhUbVMxM0w3YWZhL1NrdkR2cGNHako5QUtS?=
 =?utf-8?B?K1dJeC9Jd2hTM1QyWXhSTU5EUldiZmV3MHdQUU91VC9HZFRoMi9GVStyZE5u?=
 =?utf-8?B?cFdjMEV1QWJLZVEvdE4waURrTGdSMTlWTG9kNEFQU1NzTDV0bTJ6R2VacFht?=
 =?utf-8?B?SkVHSk5QZDZ4bHJ4YWFsdEVPUzdmT1djRG43OWtzeVd5WjlQbEp0RzBKOGNW?=
 =?utf-8?B?Qlk0MThXcmNnRmN3Nk9rVnB4a2NSQWswS3o1eEZJU1FyTmJycFpwQUhoaUhQ?=
 =?utf-8?B?Tk1nT1crSFltMXVDVVhmSVBBS2NkdXU1eDBsalBXL3VKK2xEMmhZL1BUY2xD?=
 =?utf-8?B?aWMwU3NCRjU3bEVqVnhGVWZMU1FpdUxlZEVhekdRSkdnVEZiSTd3ZEFnSGtY?=
 =?utf-8?B?emlCc1VZZTVPU3BoOUwxdlMybVk4R3FoMnB4MHFCSkdqM0xqeWJnOVc1aTVC?=
 =?utf-8?B?R25aQ3dpWmg3ZzVNbWM5UWJuMnYyejBpY2Q4UDc1eUc3dldPbG9FYmYwZjN3?=
 =?utf-8?B?UnVLTVZuNVpPNDgvV3JTR1VNWmQrenRGcEhHdmQyTHBjejlRNG8zRWhwY21K?=
 =?utf-8?B?YnB4N1RaMHRGT015V21oNFFzVkFJWm56aE1qUUhPV2pYRWZyMTJOWHhMRG0r?=
 =?utf-8?B?bmVHbGh3K01pNWJCeUI3M2ZLM1crZXhJTlA4OTRMSi9CYkluY3ljbm9rVGZV?=
 =?utf-8?B?NDQwRkhqOEZwbTVuaEVCRkkxelhqbGtFSmxPWjhJZnU0aVAzVXBmQytUMkky?=
 =?utf-8?B?bCs4U0FOZ2p4aC9FTW0yUHB1RUdSVTAvQzdsd1ZoNlBxcDB0YTlFQUcwNTAz?=
 =?utf-8?B?Ung0Wmd2blhYZFB1WnZIaCtnMlFGU0M3UTh4dmRiMDRFa0YyWXByTDRjaWk4?=
 =?utf-8?B?MmFON0JpekpmVEFHZzYveGU0L0F4U2EzZXh6Rkh1NnREU0VTcUhDR1FBeEFx?=
 =?utf-8?B?UXNtcmpFam9NN0VPaElzOVJWKzU0Q2NCMVJ0M0R1TUdEb1ZaQ1ZYQnMvS0g2?=
 =?utf-8?B?OWd4UkR0QU1pM24wY2FnelltdEVBUUp3SjFQZWhZdUg0NVlZN2QzdEhTRTNn?=
 =?utf-8?B?T1Jld21YcTFZamlwVXFyN0tBVVBuSnhJMWVzTktwTlJhaElSN1FWRnloQm5o?=
 =?utf-8?B?UlYrTGViRjFyTUxLSU9xTUo5bDRkOW92bzBmdU9pS1ZjaGhlR0d2OGFFWC9D?=
 =?utf-8?B?YncrdEdSc0YyNnJBZmkzWmgrbjJqQ0hDU1p3c2N6WVdtSzFZUGxoOTdsc3Vh?=
 =?utf-8?B?T0twT1dRamRnbDFDcnpCQkV5dXNiU2NmMzhUUnBnd2RtK0RTcmo5Q0hDRlVt?=
 =?utf-8?Q?6CMDH8osj6ZCav02d4uUIpI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkpOWklILzg5OXF0dzFWWHYzc3VQVS9ZL0k2em02b01hMmFQTFRiQjhZUUho?=
 =?utf-8?B?eWhNWTVtNUgwUzEzQlhacExsVks2Rk9FQUlIMEp5OFRMMnV6elUxZzJMbmZo?=
 =?utf-8?B?NEZuN21RLzgzUFZOY2FqYldvUG91b2xMMi9adVF1YjBHMElmQ0NZQjVxeGI4?=
 =?utf-8?B?Y2RwejdhcVNaRTRwU25yQUQxOThFaWRUY1VYbzFDZ2dNTVE2RGFLMWVJUXUx?=
 =?utf-8?B?MTJicjFMU3V5VUhjZGhFck1oV1JoRjRseSsvZUdYVE5aWDJqSlh3Yk02SGVJ?=
 =?utf-8?B?TmtwVFlmbUhxcklVdm81UGRLb1BBYTJpQ3NFc1NhMHZxUUpVdTQxdUczNzdo?=
 =?utf-8?B?VlMzNEQ2amV6ZXEwblhtL2cyTXdnN1c2Qm0xdEVIK2EvV3Z1TmR4TkdYZUts?=
 =?utf-8?B?djRaQWU4UFRvb25KVEFHU3NwaGwrb0hRUFZSakV0Szh1STJwNzlMbWVXWEky?=
 =?utf-8?B?S0h3TjQzMXZoU0hjNDlpUlcyYlBncnQ4NUMrR1RnRGR6TTR5SWVhYjZzcmpJ?=
 =?utf-8?B?OW85SVdRbml6R1F2TXUyK2FadWQ3Tm5ySDFuOGdHSWtlYWQ3SElFdkc1RVRp?=
 =?utf-8?B?VFYzRUhiU0t2WlJFcXJsVjBqdzFQU21acGVzMmoxTlV4Q1hIVkF5TGhUYmx6?=
 =?utf-8?B?OHAyT3g3ZUlrcldhd0JJTEt4OVVoM3NDZlk1K3B6UFhtOFZzdEhZaDk2b3cv?=
 =?utf-8?B?enVXaVJHN2NzVFQrWlFMK25LU0RranViK2NDQitBUjV0bzZoNE1OekdDSHlY?=
 =?utf-8?B?aVhWVlZzM1F3Y2s2S2k5K1ptNHdhMXdlRzRwMmU5T1J6S3FrSk0wZGFkTEVF?=
 =?utf-8?B?eU8wSUtFa0YrZHFXN09hc0NqQnVLZVIvZXJWN1FmbkVGaUtnS3ViU3VPdS9r?=
 =?utf-8?B?d0duSmJqeHpETjFXc1FjOW4rTy92ZDl0YjVEa0VIdmpvQTE2MTNQWDluMUtq?=
 =?utf-8?B?VUJDaU1EQkg2MUQ2aFRCdFdCTStnREZQcDhlKzFyWWg0enZOdE5oMEJRTzRl?=
 =?utf-8?B?cmxSS1M1amZuS1ppV1A3dWJTNE9vR2RQYmR4Zm1KMVIySkdGWFI4clkvVzZJ?=
 =?utf-8?B?Wmg2bnNyNzJUS3hJciswTFQ3ekZkN2h1SnJobXVaSmZ2ZkZjSGFFQWRmeG5B?=
 =?utf-8?B?YzdUdHNabzdFelNBQXJkN0NDQ09OT3JPdzNqNGJwM0lOVnphL0hSNnk3WGtx?=
 =?utf-8?B?N2x6T0NBajNPSGg5RU02SmdXQUVpUjJZeXpvQXdxSTRZazFTd3Q4VzRkNnlt?=
 =?utf-8?B?RW42d253SWRvMjBsM1dkWkpaZXNub0lsMDg2RVdDZlBuYllFVUlFdDhrT1Bz?=
 =?utf-8?B?ZzdQbHJsUVZhQ3RyaFEvWmRkb204Z1ZBSDhxZEdqMmZlMEh4bkNrbUlXSkZl?=
 =?utf-8?B?dnpiN1ZYY2lpT2dPVUs5eTFtNENxa0UrclpLQjFNYXRhMUtVTUlBbW1MOFA4?=
 =?utf-8?B?UzNoOTYzWWFkT1cyempDM1JJODM1NXg3VGNOR2ZtT05haTRzbHhZbmVZTGx4?=
 =?utf-8?B?OEwxVDBRWk83c2g0T2RuYVdEaFR0V0xRbVRaVDlDS3UrdWlLbnRXOXhOOHNU?=
 =?utf-8?B?YTBJRlMrQlAxYlBLSkFiZ0RvMEo4OFlrd1dvL1E5b01CaEZRQjU2QVpCUHV5?=
 =?utf-8?B?Sk1qa2k5WFovTlMwWkdpTHl3WTRwQ2RaUXl2NTN1d2ZUWndnZCtCZlp2Um9B?=
 =?utf-8?B?SlBhanU5SFJFdm5YSEYxVFQ5aEEzd1lNbXNNeUxlV3NKS2xnVjdSL1V6eUJs?=
 =?utf-8?B?c083RGxtVUwxcFJUL2hpNWNHUGowUHZYUjdwMUhYenhpeHdOY25tdTVrM3Zr?=
 =?utf-8?B?amlsYStUYWhGdTZJZURlQ1JORnQ0QlRyL3IwRUREWTh2Q0M3K2kvMkRMRWRv?=
 =?utf-8?B?cVd3a1J3V2luaU9UN0IyeXUxSFRxeFRONC83TnlvR2RuYzN0UVJNbWhSMTFH?=
 =?utf-8?B?Z2djOWxrcmQzRHN4bFU0SzRWSDhleUZQb3FMOGdXVzIxaTZsTXpkOFlHR2kv?=
 =?utf-8?B?MkU1dnhaRm1TU1lwYm9oazNqWFA2eGdKMEN2Qk8xcnQwNC9Sb0lYaWc4NmNX?=
 =?utf-8?B?dE01alR5bU5qdlJ6VCthM1RaRnIycjRiT2dTVExnUWFuakhLR2RMZjZaTGNJ?=
 =?utf-8?B?TTh4bnhEM2ptQnp3TnIwUDEwaFc4MnQ0VW1LUEtwanRxMm90MWhWL0QxbDVI?=
 =?utf-8?B?Nnh6cHR2OUkyVFdJRHIxN2hkbVg2TFdodm5RK1JudmdpNndmeTArN1VJcTJJ?=
 =?utf-8?B?MU5yNkZZWEkyTE9TL0hRcnZteTgyNTVLTUgzTHR2Y09yWUdxYVhkcmtJdlgv?=
 =?utf-8?Q?sELyOeFWbmYJUC1Zqv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb6d113-a858-4cda-9a12-08de57508270
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 11:47:23.0057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwe2jcGV5zK8QBfovBOCrl0yF8xT+xCzvN/3ajQbTQr2CYxIgI+lClNzpvs5zJyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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
YWdlLS0tLS0NCj4gRnJvbTogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29t
Pg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMTksIDIwMjYgNzoyMSBQTQ0KPiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47DQo+
IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEtvZW5pZywg
Q2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IEZpeCB2YWxpZGF0aW5nIGZsdXNoX2dwdV90bGJfcGFzaWQoKQ0K
Pg0KPiBPbiBNb25kYXksIEphbnVhcnkgMTksIDIwMjYgMTE6MTI6MDLigK9BTSBDZW50cmFsIEV1
cm9wZWFuIFN0YW5kYXJkIFRpbWUNCj4gQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gPiBPbiAx
LzE4LzI2IDEzOjU3LCBUaW11ciBLcmlzdMOzZiB3cm90ZToNCj4gPiA+IFdoZW4gYSBmdW5jdGlv
biBob2xkcyBhIGxvY2sgYW5kIHdlIHJldHVybiB3aXRob3V0IHVubG9ja2luZyBpdCwgaXQNCj4g
PiA+IGRlYWRsb2NrcyB0aGUga2VybmVsLiBXZSBzaG91bGQgYWx3YXlzIHVubG9jayBiZWZvcmUg
cmV0dXJuaW5nLg0KPiA+ID4NCj4gPiA+IFRoaXMgY29tbWl0IGZpeGVzIHN1c3BlbmQvcmVzdW1l
IG9uIFNJLg0KPiA+ID4gVGVzdGVkIG9uIHR3byBUYWhpdGkgR1BVczogRmlyZVBybyBXOTAwMCBh
bmQgUjkgMjgwWC4NCj4gPiA+DQo+ID4gPiBGaXhlczogYmMyZGVhMzAwMzhhICgiZHJtL2FtZGdw
dTogdmFsaWRhdGUgdGhlDQo+ID4gPiBmbHVzaF9ncHVfdGxiX3Bhc2lkKCkiKQ0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPg0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuYyB8IDUgKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dtYy5jIGluZGV4DQo+ID4gPiAwZTY3ZmE0MzM4ZmYuLjRmYTI0YmUxYmY0NSAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+
ID4gPiBAQCAtNzY5LDcgKzc2OSw3IEBAIGludCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFz
aWQoc3RydWN0DQo+ID4gPiBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MTZfdCBwYXNpZCw+DQo+
ID4gPiAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT5nZngua2lxW2luc3RdLnJp
bmc7DQo+ID4gPiAgIHN0cnVjdCBhbWRncHVfa2lxICpraXEgPSAmYWRldi0+Z2Z4LmtpcVtpbnN0
XTsNCj4gPiA+ICAgdW5zaWduZWQgaW50IG5kdzsNCj4gPiA+DQo+ID4gPiAtIGludCByLCBjbnQg
PSAwOw0KPiA+ID4gKyBpbnQgciA9IDAsIGNudCA9IDA7DQo+ID4NCj4gPiBQbGVhc2UgZG9uJ3Qg
aW5pdGlhbGl6ZSByZXR1cm4gdmFsdWVzIGluIHRoZSBkZWNsYXJhdGlvbiwgdGhhdCBpcw0KPiA+
IHVzdWFsbHkgY29uc2lkZXJlZCBiYWQgY29kaW5nIHN0eWxlLg0KPg0KPiBUaGUgaW5pdGlhbGl6
YXRpb24gaXMgbmVjZXNzYXJ5LCBvdGhlcndpc2UgdGhlIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGFu
IHVuaW5pdGlhbGl6ZWQgdmFsdWUNCj4gd2hlbiBmbHVzaF9ncHVfdGxiX3Bhc2lkPT1OVUxMDQoN
CldlIGNhbiBpbml0aWFsaXplIHRoZSByIGJlZm9yZSBnb3RvIGVycm9yX3VubG9ja19yZXNldC4N
Cg0KPiA+ID4gICB1aW50MzJfdCBzZXE7DQo+ID4gPg0KPiA+ID4gICAvKg0KPiA+ID4NCj4gPiA+
IEBAIC03ODIsNyArNzgyLDcgQEAgaW50IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYl9wYXNpZChz
dHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLD4NCj4gPiA+
ICAgaWYgKCFhZGV2LT5nbWMuZmx1c2hfcGFzaWRfdXNlc19raXEgfHwgIXJpbmctPnNjaGVkLnJl
YWR5KSB7DQo+ID4gPg0KPiA+ID4gICAgICAgICAgIGlmICghYWRldi0+Z21jLmdtY19mdW5jcy0+
Zmx1c2hfZ3B1X3RsYl9wYXNpZCkNCj4gPiA+DQo+ID4gPiAtICAgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gPiA+ICsgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5sb2NrX3Jlc2V0Ow0K
PiA+DQo+ID4gQWgsIHllcyBnb29kIGNhdGNoIQ0KPiA+DQo+ID4gV2l0aCB0aGUgY2hhbmdlIHRv
IHIgaW5pdGlhbGl6YXRpb24gZHJvcHBlZDogUmV2aWV3ZWQtYnk6IENocmlzdGlhbg0KPiA+IEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPg0KPiBJZiBJIGRyb3AgaXQsIHRoZW4g
aXQgd2lsbCByZWdyZXNzIGFnYWluIGJlY2F1c2UgaXQgcmV0dXJucyBhbiB1bmluaXRpYWxpemVk
IHZhbHVlLg0KPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPiA+
ICAgICAgICAgICBpZiAoYWRldi0+Z21jLmZsdXNoX3RsYl9uZWVkc19leHRyYV90eXBlXzIpDQo+
ID4gPg0KPiA+ID4gICAgICAgICAgICAgICAgICAgYWRldi0+Z21jLmdtY19mdW5jcy0NCj4gPmZs
dXNoX2dwdV90bGJfcGFzaWQoYWRldiwgcGFzaWQsDQo+ID4gPg0KPiA+ID4gQEAgLTc5Nyw3ICs3
OTcsNiBAQCBpbnQgYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdA0KPiA+ID4g
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDE2X3QgcGFzaWQsPg0KPiA+ID4gICAgICAgICAgIGFk
ZXYtPmdtYy5nbWNfZnVuY3MtPmZsdXNoX2dwdV90bGJfcGFzaWQoYWRldiwgcGFzaWQsDQo+ID4g
Pg0KPiA+ID4NCj4gZmx1c2hfdHlwZSwgYWxsX2h1YiwNCj4gPiA+DQo+IGluc3QpOw0KPiA+ID4N
Cj4gPiA+IC0gICAgICAgICByID0gMDsNCj4gPiA+DQo+ID4gPiAgIH0gZWxzZSB7DQo+ID4gPg0K
PiA+ID4gICAgICAgICAgIC8qIDIgZHdvcmRzIGZsdXNoICsgOCBkd29yZHMgZmVuY2UgKi8NCj4g
PiA+ICAgICAgICAgICBuZHcgPSBraXEtPnBtZi0+aW52YWxpZGF0ZV90bGJzX3NpemUgKyA4Ow0K
Pg0KPg0KPg0KDQo=
