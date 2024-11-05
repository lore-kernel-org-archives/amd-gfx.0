Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C9D1CA38
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 06:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEAB10E0D5;
	Tue,  5 Nov 2024 06:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxfuw16e";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A787D10E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 06:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8O4MfwMq4SlaG3Uf5InrCIQkP0+9UMXBlC5NkFmi64luaXsIF3MG+dbudhO4Lki0yGSeHKSvO0b4s6wKZfJm2V3CVfD8EwYrbAL6CDkkZOvczqfdTmfCS+zifQSpc3mHh8qExnFpZhnhLbNAoM17BiAx8r6LleUUDIT288lbqLa0ukQp0c5wg8R5m43+7+zeSB0uP2uaAwmynzoKDvP2JrOMEngO+dgYlOiyQCM91oMgvAP1wq3U+RbiiEutQCNljGdbCKnw0JOUC0/kVNEkZwviutS0xgCWhFa9TARvGJYKJ2ry5tAO1PXGn/6TjmPhGzEpZUSAA6p2yTXcE/hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DmcjlVJmRRZTZslut2yBzul6177s+Q4pGpkMPFTblo=;
 b=BhngdbM/teMGLa+tWTZdCOUtYuyFEGfglmgreR8lHuVbrgFpwjfWxciZDeH6SsXz1tUsU2KawXJfSs+Q9+qq2q7QX4R+efvJDYZGv5wbr2JeOog4paQEhrttNmTwIJAflrrFVfP/1S3oFC4TQVpAjzR0ou5hbOiCGuiqI9YUbcOEvaMXeybXVmUl0ZdrYv69fBYL9W/t+D+ZDfIim356LXEdjYGjDjbXD8Y6SG68EDnvtwJbf4w29WZ4WKiaL4K+GDTB1PNkkdFwdgzVQrnw0oLPmQI8qoPWPuxtEelu9vkm1YSi16xoFM//+F0nOhpOVMS4oiYSSQuy3ktTZlRKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DmcjlVJmRRZTZslut2yBzul6177s+Q4pGpkMPFTblo=;
 b=pxfuw16e3t2xJQ3ePpBr5U42ads7DuNiYVq2W1y6h2DdBBCZLiHSReKajWE7nR60I7mXEWDnSglvMhGG17QINlt07v+bFsd4c5R/nSnJdNEKau8RaXo4v5r/9sjcmNoSmFvcs2xFGtXp0hsZv8/takaFAWBrW+Qvi+crz+CbKHQ=
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:45:10 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:45:10 +0000
From: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Normalize reg offsets on VCN v4.0.3
Thread-Topic: [PATCH] drm/amdgpu: Normalize reg offsets on VCN v4.0.3
Thread-Index: AQHbL00QCapkXbSSSEGIlATzBclGbLKoPUIQ
Date: Tue, 5 Nov 2024 06:45:10 +0000
Message-ID: <MN0PR12MB62931D3D8A6685D7729F281A9D522@MN0PR12MB6293.namprd12.prod.outlook.com>
References: <20241105063612.519691-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20241105063612.519691-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=884071a9-bd52-4fa4-9680-d2ce6e352777;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-05T06:42:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6293:EE_|CY8PR12MB8193:EE_
x-ms-office365-filtering-correlation-id: 638b0a66-77ec-4cdf-510f-08dcfd6564b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjZrdmJEYis5bmdFaGlCclhXSmQ4UlIwM25ENFQ1RGhPbWw2dW1UcUVVcmVO?=
 =?utf-8?B?cC9LZlArN2pJc2J2bVhESkFlVXk0SHdmOStQc2JjNWdUbVBhR2lzSVpFOFNK?=
 =?utf-8?B?STFBY2V3VDcybHA1SWpzV0REL3VrYzdGdmR1aktDcG8rMTJyYm52S3hRRHpr?=
 =?utf-8?B?MElUNnhPaWtveWd4MGRkT05hcWRDUm1rd0p3UXpySlYwemoxSjR3R0E2RDdo?=
 =?utf-8?B?K2I1ZmhCZG5SeXRkblBCU0tKSzJUUFRKU08yUDFVNWliODJFbG9nZDJ0OURF?=
 =?utf-8?B?RlUxeU90YUpXN2twUk5lN3FKQ0FvakdHL09vQjZGVUc4Q0h1RWxIRU1HUG81?=
 =?utf-8?B?OWtOc2R4Rkw3eWhGLzRuRVQ4RURIeTJWOTljbHgxMTJqOW9EbTVFK1hYelU5?=
 =?utf-8?B?d0J4SWF5c3dVV0RPWEY2UmdyRUk2bFkvcU5IVGlMK3NkRktPTjBSNE9ueWZt?=
 =?utf-8?B?K0RQT2ZFN2xab2NCbEZvOGhOdExsRGpNMHU2SnhrV2RhMThIS2ZzbnVHeFo4?=
 =?utf-8?B?dHBwY1N5eEgvL24rZ3hWTlNUYSt0Y29UbHowdHg2V3VLa1J1c0ZCcFE3LzNO?=
 =?utf-8?B?b3ZoZkF4YVVVZU12R282dVBRRFo4S1N3SmZSRktFUUhCYXBTajFzbXNaaWds?=
 =?utf-8?B?NW5VMndTVWdON3VsR2pmbDBka3N5SzJSdzBBbmtqaDZVczJCczM1dkZTUTNI?=
 =?utf-8?B?NHdyN3Q4Yml6OHFDTVpFOC9LT1NXNFNwNGN5dlZjOERad0JvOFZwcTJRUFdX?=
 =?utf-8?B?OWVVYlQrQ0N3a2hCVmJjZHpHcUFUdnF3anlud0RFYzRYTnIxWEFROExlK0ps?=
 =?utf-8?B?Unk0czU5T2l6ME9VdDg0Z3FxOVl1bytEU0IvN3ZJUjd0NG1FZE5RRzZ4Njdw?=
 =?utf-8?B?ZVF3bWVlQ0Z1UWIwemNPZjJ3Y0xxZWh6RnkzUFFhY09PY1ZtOHUyNS93b1Jr?=
 =?utf-8?B?bmxwQW4wYkFRMkNhQkhaS1V0ZFVoa3J0VHN5WTc0aDBPbXRmNUtZT2xXNFEv?=
 =?utf-8?B?b3IzRGtWa3dhaHJWaWZlMktzZHdVMTRrQTZqeFBiMyt4K0FzRTk5VmMwVVk3?=
 =?utf-8?B?RkxwL1JoU3NXN2w1WUVwd2s0VWlLZXlwT1NyWkM5WEM4T3JESDlndFVEL0N5?=
 =?utf-8?B?Y2lneHk3Z0Z1cjVvTDVucHl1R0ZyWWtiUnQ5UUxRSFE5LzdPU3Z4QmVONUFJ?=
 =?utf-8?B?RVlwZElJYmcwY0QvcEROWnZJdEI2R3pLcFJ2dEZSMHBqY3BVM21MOEl5a3Ir?=
 =?utf-8?B?V0hRR1J0dlh2VmN3WElFVzVyb2QxbEFiYWZwY3pWQktzV1I0WjVRN1IwY1Jt?=
 =?utf-8?B?cmlZTG8vV3BOa3F5bEJaRzZNUGZ4bGswbVNUSWtldTl4TlBVSWtzTWZ6NVNt?=
 =?utf-8?B?RktCcU40T3dEQmFzWjMwMUpqR0w4RER3enZqYTlmWTlZWDdsSzFkaXhoVzE5?=
 =?utf-8?B?bXZHK3oraVBkRnhTZzRiaEc2UHZDdWppTGRXUGVURW1vbzJBekdEUjVhc3U5?=
 =?utf-8?B?UmtYUmJraWNvU3k2ZUdleitnQTR2aExIZWJ6OW5mOGYyVk1sUUhla2htM3lM?=
 =?utf-8?B?WWJjR1RlaHNhdlRJNkpJQy9lNzIwY29jV2luRk5EWktyT3UxdzNwRUl1akYy?=
 =?utf-8?B?Ym1XL0E4d3FuUjdvU2NHNUhkWnVKYU5YdHlsSjluVG5rbWxlT2RjMExZaWJH?=
 =?utf-8?B?dmRoTEc3a1hLT3VHRWtMT0ttcU1JN0t1SU9SMWxVM2EwS2FNbXlPaXRiMGpa?=
 =?utf-8?B?YmF2NjhTMWVnMmloL3lxbnNhK2NSamZDMldmTUszMlBtUE1FVnhENUxZS3dj?=
 =?utf-8?Q?sjMHeeoEf4ORW47xC52o5VgTJ2axUM+jo4ST0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0xuY0xQMnRjRDRQVFZpRGFTdjU4eU41RUxybjhIREFrT05DV1M1dmNaVlQv?=
 =?utf-8?B?cnJxZGxKTGs0NDBSMjNCM0pYUHBkVGgrZ1BjMjBsYVhIMGVvM0JyNG9DQ0lm?=
 =?utf-8?B?eHFVb0lWYXYyZS82UlkyRVJWTFp4TUtjN211c1pndTRwV3BWTzVqUm14RlF3?=
 =?utf-8?B?cDAxZEJTNlRCUDIycXF6eVQ4dlhFd2pCWU10ZFkxZ0lWV1YwZFFjb0ZPRkdZ?=
 =?utf-8?B?RzNmdEIvR2JIOGRYcHgybDZsY2M5ZTZTZnMrMGRVeWlyT0JpKzkrVndCS2Jk?=
 =?utf-8?B?SU1iVThBUm5nUmNUaDV3cnIrVXlXNmVpMUMwUk5lMWduNGt2QXpuY25Kckpt?=
 =?utf-8?B?WlJXZkxPMVlId0hYRC96d3dKcW9VVU95OFRHTnI4OEQ1MnZ1NGxFelR0aWUy?=
 =?utf-8?B?d3VZRmQxWThJT3RMU0txbzAxM2pnVU11eXFRQlV2NkUrMUZPMVUrWk9LN29U?=
 =?utf-8?B?a1B6V1VFUEh5RUx0bjdhNlIyZTQ5eGlkalpEVzhnTlljS21vUG9wc2hMdkRL?=
 =?utf-8?B?OWdiNW9xYmYyd3c3ZTNKVFByU1M3d1VsbzR1UXRGNkhtMmI2dDNoVEhvR1B6?=
 =?utf-8?B?ci9senVWRm5YMHdyWCtNVWpKMHl6YnRhaDJ6S0dKYmc2WitHTTcrWXd1ZkxK?=
 =?utf-8?B?NVRTUFZ6S0Z3OGxKOTlWQ0c4Y0ZsMEhXVWYvSU9EQldXaVpFbHBzWjVRM1Nq?=
 =?utf-8?B?Qko0Z3RtRjl3MkpYK2ZiTTlXNjFKQnk5UzZtSUpRMERWNGY4OEx0S2FYRjls?=
 =?utf-8?B?Nk1uVENKd1lzdkpDaTJCZml2NHVqOWJuazl3aEY3MzQvREV5MFVCejRSekto?=
 =?utf-8?B?OU9zVWdtOEJVbU8xUFdJcHFlNFAramVDU1RyRDAzbWNOZDZ1MmFmdE5NL2x5?=
 =?utf-8?B?SE8xU1IyWVF3bTB6V2h6RkZYMXMvU2pIQ3BGdWtHNWpjeE9kbS92TWZ5d3dH?=
 =?utf-8?B?MG8xZXFqdlBST0dzTmNTd2JLa2QwVkNiZ2xhVkpOdmh1Sk9HMHAwMXRDNXRp?=
 =?utf-8?B?NUR5aEhiM2UvZVJPQ0JCTUpTRGh0R1E2UUNoczVmSWQ5Tlc0VnhTeTliRDI2?=
 =?utf-8?B?Z25ObFhjTkZBUHRJK3pWS1paQmc5YUZyOTdXQk9iWHZVcFVFYlpzV0lmM3VT?=
 =?utf-8?B?OGRvM1ZSTzhDejQybXZFUlN4eTAwcmMycDhwMjdrc3dWNXZsTkt5OEdCM04v?=
 =?utf-8?B?ZldsT0RMLzlkNXhCYm9GUzl3bzgyTWpqYVJkVk9IRERkZjlWT0JGUUhTQTlh?=
 =?utf-8?B?ZXV4VWJLSStyVWpyUXYzMmx2L1FxSHNNSVdleXVhcGpsNFlOZTllR1NZVWJ1?=
 =?utf-8?B?elB3SjBHTGN3NXpLVUZXKy9LWC9vYW1yK05zNUtnbklqQzdJQ2phRmp4bEgw?=
 =?utf-8?B?VUV5UFFIRVVvbnlkM1pNQVBVRmtoNm5rMUJyYkthUlY4Q1Z3ZFJ1cURtemFt?=
 =?utf-8?B?V3orajNsWnR1eW9UOFJjME5iaVI0QmUzNWk3c1F5WHZPQUVXRDFSc3RKV3FU?=
 =?utf-8?B?b3dyNGJTL0JBV3RRZ01IRVhrdlVlUk5mbkp5b1dyd2VHOWxMMHdKSG1mem5E?=
 =?utf-8?B?czhrUkI5WCtic3VrUnBZUmZqTHNUU0JlVkdXeVMrZ0Nqb3RtSHBzSUtUcTAv?=
 =?utf-8?B?aHR2cDgrazdGY0E3eFpuTXUydm0yRkN4aURNUWh0ZmUyR2YyYXlWMmRwZmNL?=
 =?utf-8?B?aTJNK0VJeXVDQytwM2Z1dERCRmYvRWw1K1h1MkV2eG5oandvTlhUTmo1cktG?=
 =?utf-8?B?clB0eUJiMVZEdThGbytQS3RYT3RLYkFUUytEc3E1WktwSGsrbmlrdVpGT0RL?=
 =?utf-8?B?T0s1QnlBbVJSMEdQZXc4bDRUWlEyNCtpN0RjclA5ajBnSHFFdUxESzRuUjdi?=
 =?utf-8?B?NDJaUXVvM0xpSU9JRGxjK0VUbmZJVlB3QnpRQmw2ellycnZ4Z3lQUERxTURq?=
 =?utf-8?B?Rmw3cXJhbHRsS1J4UkJyZ1lsUW40Mks4WThnUUFhS0w3OVZoM2pUaWFMTzh6?=
 =?utf-8?B?UFlHRzFiVGVkMVRJSUJreXEwcGNRb0ZMalFoNHBrZTlaSE1Rdk91R1ROcWdj?=
 =?utf-8?B?U3Q1bTVSdktWT1d1dC9OOWRFb0NscmxkNVY1UzYzMXN1OERLbk8rZUtNU1Ri?=
 =?utf-8?Q?XrkQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638b0a66-77ec-4cdf-510f-08dcfd6564b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:45:10.3012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wANvjuqgU21Pkh5F3AW5ZeosQ1ynRPOxc6MGr/egQCM8NXEuMSuGTPyNI669uSsEd1po1SHhAoB7ZAE7SGD1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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
Cg0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoICwgdGhlcmUgaXMgYW4gdW5pbnRlbmRlZCBuZXcg
bGluZSBhZGRlZCwgd2lsbCByZW1vdmUgaXQuDQoNClJlZ2FyZHMsDQpTYXRoaXNoDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxT
YXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDUsIDIwMjQgMTI6MDYgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6
IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxT
YXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogTm9ybWFsaXplIHJlZyBvZmZzZXRzIG9uIFZDTiB2NC4wLjMNCg0KUmVtb3RlIGFjY2Vz
cyB0byBleHRlcm5hbCBBSURzIGlzbid0IHBvc3NpYmxlIHdpdGggVkNOIFJSTVQgZGlzYWJsZWQg
YW5kIGl0IGlzIGRpc2FibGVkIG9uIFNvQ3Mgd2l0aCBHQyA5LjQuNCwgc28gdXNlIG9ubHkgbG9j
YWwgb2Zmc2V0cy4NCg0KU2lnbmVkLW9mZi1ieTogU2F0aGlzaGt1bWFyIFMgPHNhdGhpc2hrdW1h
ci5zdW5kYXJhcmFqdUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3Y0XzBfMy5jIHwgMTYgKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3Y0XzBfMy5jDQppbmRleCA4YTFkYjhiMzNlYTAuLjk2MjYzYWZiM2ZkNCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzMuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jDQpAQCAtOTUsNiArOTUsMTMgQEAgc3Rh
dGljIHZvaWQgdmNuX3Y0XzBfM191bmlmaWVkX3Jpbmdfc2V0X3dwdHIoc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nKTsgIHN0YXRpYyB2b2lkIHZjbl92NF8wXzNfc2V0X3Jhc19mdW5jcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldik7ICBzdGF0aWMgdm9pZCB2Y25fdjRfMF8zX2VuYWJsZV9yYXMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IGluc3RfaWR4LCBib29sIGluZGlyZWN0KTsNCisNCitzdGF0aWMgaW5saW5lIGJv
b2wgdmNuX3Y0XzBfM19ub3JtYWxpem5fcmVxZChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KKyphZGV2
KSB7DQorICAgICAgIHJldHVybiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpIHx8DQorICAgICAgICAg
ICAgICAgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApID09IElQX1ZFUlNJT04o
OSwgNCwgNCkpKTsgfQ0KKw0KIC8qKg0KICAqIHZjbl92NF8wXzNfZWFybHlfaW5pdCAtIHNldCBm
dW5jdGlvbiBwb2ludGVycw0KICAqDQpAQCAtNTg5LDYgKzU5Niw3IEBAIHN0YXRpYyB2b2lkIHZj
bl92NF8wXzNfZGlzYWJsZV9jbG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IGludCBpbnN0DQogICAgICAgICAgICAgICAgfCBVVkRfQ0dDX0dBVEVfX0xSQkJNX01BU0sNCiAg
ICAgICAgICAgICAgICB8IFVWRF9DR0NfR0FURV9fV0NCX01BU0sNCiAgICAgICAgICAgICAgICB8
IFVWRF9DR0NfR0FURV9fVkNQVV9NQVNLDQorDQogICAgICAgICAgICAgICAgfCBVVkRfQ0dDX0dB
VEVfX01NU0NIX01BU0spOw0KDQogICAgICAgIFdSRUczMl9TT0MxNShWQ04sIHZjbl9pbnN0LCBy
ZWdVVkRfQ0dDX0dBVEUsIGRhdGEpOyBAQCAtMTQzMiw4ICsxNDQwLDggQEAgc3RhdGljIHVpbnQ2
NF90IHZjbl92NF8wXzNfdW5pZmllZF9yaW5nX2dldF93cHRyKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZykgIHN0YXRpYyB2b2lkIHZjbl92NF8wXzNfZW5jX3JpbmdfZW1pdF9yZWdfd2FpdChzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90IHJlZywNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgdmFsLCB1aW50MzJfdCBtYXNrKQ0KIHsNCi0gICAgICAgLyog
Rm9yIFZGLCBvbmx5IGxvY2FsIG9mZnNldHMgc2hvdWxkIGJlIHVzZWQgKi8NCi0gICAgICAgaWYg
KGFtZGdwdV9zcmlvdl92ZihyaW5nLT5hZGV2KSkNCisgICAgICAgLyogVXNlIG5vcm1hbGl6ZWQg
b2Zmc2V0cyB3aGVuIHJlcXVpcmVkICovDQorICAgICAgIGlmICh2Y25fdjRfMF8zX25vcm1hbGl6
bl9yZXFkKHJpbmctPmFkZXYpKQ0KICAgICAgICAgICAgICAgIHJlZyA9IE5PUk1BTElaRV9WQ05f
UkVHX09GRlNFVChyZWcpOw0KDQogICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFZDTl9F
TkNfQ01EX1JFR19XQUlUKTsgQEAgLTE0NDQsOCArMTQ1Miw4IEBAIHN0YXRpYyB2b2lkIHZjbl92
NF8wXzNfZW5jX3JpbmdfZW1pdF9yZWdfd2FpdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVp
bnQzMl90DQoNCiBzdGF0aWMgdm9pZCB2Y25fdjRfMF8zX2VuY19yaW5nX2VtaXRfd3JlZyhzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90IHJlZywgdWludDMyX3QgdmFsKSAgew0KLSAg
ICAgICAvKiBGb3IgVkYsIG9ubHkgbG9jYWwgb2Zmc2V0cyBzaG91bGQgYmUgdXNlZCAqLw0KLSAg
ICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHJpbmctPmFkZXYpKQ0KKyAgICAgICAvKiBVc2Ugbm9y
bWFsaXplZCBvZmZzZXRzIHdoZW4gcmVxdWlyZWQgKi8NCisgICAgICAgaWYgKHZjbl92NF8wXzNf
bm9ybWFsaXpuX3JlcWQocmluZy0+YWRldikpDQogICAgICAgICAgICAgICAgcmVnID0gTk9STUFM
SVpFX1ZDTl9SRUdfT0ZGU0VUKHJlZyk7DQoNCiAgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmlu
ZywgVkNOX0VOQ19DTURfUkVHX1dSSVRFKTsNCi0tDQoyLjI1LjENCg0K
