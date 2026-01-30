Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AEBD73EBF
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 05:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CE910E8F5;
	Fri, 30 Jan 2026 05:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbk5aoiJ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E87410E8F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPgqbQz0eWxGNGwIyXEZSDJ8De2Q20108SMK8wCvjsF0s0vt1zk971PFHZGx1ZSfDZo8QJ58g0DyU6Ki0pasCvtGkZlWLmvAD8cmFFuXgzc5s8qSK+rE3DlrH3pM3im1WMNy/8DJcMtI44xRn6G1ec7cFMkU6bgW/l5a/IWc2PpK5AWcWwwpQZC5MVao8IAjqoDFWRuGN/UH6A8vZdsKS6bk5y034XgnXznMX6QQQk88WY5gI2NatD7w1C9k0jN+0cG+29M3rlifZ70UgVpTj8C2pO438EodrGNiQGj9wt4Z42F9TtCs2LZ6yY4Gf5NVcc47/9KNK/oHb6ND0DsSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjncZbbpndVcBrMolcxAS3dARzRoGi1fSrYu3d/W1ak=;
 b=MhLOGBtaRkD05s8FFbNjt1aNyyRbavutAXswGjlAygHn5osigI7JTrbfYW5DE2DustozNPiq5ImKLjJ6fmu16YCRke/k72bunPLAQzmWyPh+F+4KoQ6IDegsrXiSEpOoVs1IlheheukQEsdVtfh82k2sitRPWas9LI2sEFCUzLRlihByrSywk2vsmoONUY4/Ix+B61+iYNK1qgB8Uv9m7aNmbZcCaiqqdGjqkHymXyDkEPo39jR9x4SVUJOE22UYoRyC4UkXNUzm5tt0aziwvMN7DGJMh8pA3Sp0U9XnJGkDAAx+tyv3VY5YYclk45jSUdI3Zexb7MOoWo0kluj/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjncZbbpndVcBrMolcxAS3dARzRoGi1fSrYu3d/W1ak=;
 b=kbk5aoiJORpclIxcS7mM1s0dyOnoJoyn5WICTKNUS2ay9CHhY6Au/xOS5y0SXsxFGYnhvY5ad6TAlFCMWGJX4gNTTsex8IHxeS39Ux+me8dJieSrzAnDtkUxC6VtwZpDSrtI7Irwz0NAY+AT0wGgd95iSmEe1mAToirI+UO275k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 05:42:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:42:04 +0000
Message-ID: <dce52ed8-25fc-46a4-8395-435c6f544359@amd.com>
Date: Fri, 30 Jan 2026 11:11:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com, YiPeng.Chai@amd.com, KevinYang.Wang@amd.com
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-3-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260130022950.1160058-3-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: fb52ad17-32bc-4e4c-0bb3-08de5fc24c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cElkbGpvejk3RUtQVkhFRnlISEo5YjhmZ0J3clVRcnRkcjFyeW1McC9TdHNt?=
 =?utf-8?B?R0hvTXN1c3lkREpjOTB5RGJWdGs1aHJEeFUrMjVIdThqQnhia0FrclBkVlh2?=
 =?utf-8?B?WDFOckxOazV5akI3Wmk0ditHUjVCNzB5TW4zL25RazdNakk1bzlabDZSZERp?=
 =?utf-8?B?ZGZKcTFKcVh6M1Y0cUN3QjBKSFIwNEcvd3B0Wjk3cC94eWhpZEZVMUZycjUy?=
 =?utf-8?B?WWFNaW9KTWtseitLelBwZmVUQkpBR1cvaWV6clJJNElEeTRPZVNSZWljWHNI?=
 =?utf-8?B?VDZwazVDRm5qNk8zeCtQRWR4UVBBR1NLOFlBMGFpeFp4NFoxRzRyeTU4bDFN?=
 =?utf-8?B?R1pOemlua3FxZG01N1AwaCt1akRWbzAxZU50Y3Zla2NSOXBaWlhENms4WFps?=
 =?utf-8?B?UFVWdmVIWEl6dFphbzZFeDVmZVduSjJNb2pnQVVrN1RpaVVyTkVhMzNGMTFD?=
 =?utf-8?B?ZFpkTVB0MlF2L0ZZMWFreFlTOWh1WEtHOFpidG02K2w1MkF1Zm1qNWovZ2p2?=
 =?utf-8?B?eWVUb0FmcysxVG9GTm4vYTdYMi9zVHJkVlMvc3ptR2JYUDlVdGFpVWJIb2t1?=
 =?utf-8?B?d1VaZFF1UnE1ME9WdENMQ2Yrc3F2cnZuZllVa1BHdC9sQVFwek4zS0ZjYXly?=
 =?utf-8?B?Q1J0Znhrazd6UFpDN3BIY0t6dHc3NUJsdnFTVVBJZzMra1N5VzdIWlNQbkdS?=
 =?utf-8?B?RmJKajFzbVBodXF4dGErOStMWWI0bk4vdXRoQXNyVHowZlZwTkJMUHcrMUht?=
 =?utf-8?B?QU1Pa2g0ZzJBVy9FNUxpVkIvbThqWjdNSXdUZVBVazFheGxtakRjMkUzOWZC?=
 =?utf-8?B?VXZwQlNrSFh3d0RPd3NhRTIvMVJONXpOTkNtRFErcFg2Ykw0eUdCTjUzRU1z?=
 =?utf-8?B?UkM3MTRwaE1wUmtzbXJmaFNvUkpQVDYrYTJCeVZxWFBLTXhyVm9yeldYbFNT?=
 =?utf-8?B?WEp5bFlEVWswQm1UL0FjNW5IMDExd0orZHgyMTdvWXlySGE2dmRGcmkveDJ3?=
 =?utf-8?B?a1hDS3EyczBWV3lONVpCQTRwcUZZWEFIQmlHYit3bmUwSzFJYkJBNTlIQUxL?=
 =?utf-8?B?QjB3b05IQUJvbnFQMVRtSmQ0akJqVHJNbkhYK1JXZ21OSENwejhVK1dNc3JM?=
 =?utf-8?B?TklXQUdDRGVnbTRPZ2pOWjAvcDllNWwzNzdIdEJiQjQrclpOTUdGZzgyNm1D?=
 =?utf-8?B?YXlGSHZYWmVyaS9mMUxIMVBvWHhYcjFpNE5pNDZhRmFaWVVEMFNDT0pPcVNW?=
 =?utf-8?B?d0VrbUZtVUl3UnFNRXZtZ1JaUXFwNzNCL1BSa0tzSnJPME8wb29YY1d5VkJ4?=
 =?utf-8?B?RitUSmVMMVNwMnRFcnZXTnk2c3NMOGVibUFWZzl0WXBVK1JySHZpMVRIRTY1?=
 =?utf-8?B?UzRBNjIxdHRuSzlaVndiQWlVWUJwZFlvQ2luVVY5SG00NTVocDZsaWtvQThx?=
 =?utf-8?B?ZGVMUnZlOHlYMTRWYUNDWURTMlFhV0VSYTNEZ1pzaERiVVJsWDZWVllXbmVn?=
 =?utf-8?B?YnVFZEVOdnU2NkdoRmMzMjI2RXE0Wlp4SFNaOXhWSzFLM2VPN1JNL2ZjQks0?=
 =?utf-8?B?WDZOcEtKU2Rjd2pmcnYycVZ1T296R3p1b2kyMjEwa29ESXBtZHBNSHc4ZWgr?=
 =?utf-8?B?M0kyNmplTkt4TlpteExvZm9vNkdkSFU3aS9tMzRPamc3Nkt2Z3VzRGZYY3Nl?=
 =?utf-8?B?cjJoaWU3UWhoVUFBWDh4N3kzVHhMc2dpYU45U1VVUjNPdjNxS3RmT0JCbkxS?=
 =?utf-8?B?SmU2NWpUY3MvT3V5Ky8zc0VDL3IwZEhMZDM0U1h6WC9Ra1lQSHBuVzhKTGk3?=
 =?utf-8?B?WXlZb3hiTjJwa3VYWVJXQlZYM0Q2THNkU1E4RjBSc0I3ZUhueFBVMlNKWFhx?=
 =?utf-8?B?U1M1a200T2FFVjF4Rm5UM0RjcWVhb1JwWXJEamloZnZsQ0I5dG0rWS9lY29t?=
 =?utf-8?B?eHRwT3hkLzBwZ2orRUZHZTB4K0VKMVlwbWJUWmd3dUR3cWlWcWlqZWw5U0xz?=
 =?utf-8?B?ampOMVkrcytyczQwL05NcDlkcmFvcW5DS0QyTDAwRHpoS2xSVUJsYkNFREla?=
 =?utf-8?B?c1N3ai9oa3kyZ3VRbEUyeHp3bXdadUpjajJuZ1ZRRldaTzdmTU5XVXZqRDdX?=
 =?utf-8?Q?mmHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZYa3FLcXdzUTNNNmJkYXdTZzA0Q2pPM0dpVFI1WWh1VFJzUDhoTU9BUHMz?=
 =?utf-8?B?L3ZDMlpZVGppVFR1Y1dzTC9UVVpaYWlwRDBKTXZSbGZRREZRK0VxWDl5ZCtX?=
 =?utf-8?B?Y1IvNWp3dFdKUWtBZnkza1RUWlE2VUZKUm54YjQwTzU0TnZsUStKUi83d1V5?=
 =?utf-8?B?WW9jSDVjNTdlWUJKeHliZHZnMHVwOEV4SGlSTHU4TjVFeFVTcld1R1hvSmZP?=
 =?utf-8?B?UFYzOTMrbVg2OUh0YlZEaDBZYXNMaEJ4QmZ3aVpXcDcvNEtkUmtkTVprRWFN?=
 =?utf-8?B?TWl0QXNnRlhVaGUrdHZQYzl5S3cxWUNSbW00UjNDaXR2Y25NMTQ4My82YUUr?=
 =?utf-8?B?UnhDcy9tVStmcVUyREgxc3FzMERuU3FJUHZjVm5nTTloWFFIMFBOcW9SM3Y3?=
 =?utf-8?B?QlcwR2pDRW9EaThYR2M4Vkw3WXdDTWhWNFhXWTdyMkV5S2VlazlVQ3dMUU5Z?=
 =?utf-8?B?ZHMyNTZad3F3a1B6Z1E3RnhJZjlNd21mWU1DTnI1UnZoUU1RczZibTJZOWpx?=
 =?utf-8?B?bmE0dGs0ZUNET0l3OXVmQnhUenJXbFlQWW9YSk1EbVhKZGszWStnQy9icXJz?=
 =?utf-8?B?cWVsNHMvdjFHSDJ2MXdHUGtZMWRheGs1VC9oSG14MDdSSzhPdmRlcTVEYk9y?=
 =?utf-8?B?cU9IZmZTWEZwbG45WG5PMUpSMFFWMk94bm8zVmdKN0g4azAwcUQ2OURMUm56?=
 =?utf-8?B?bVlkQXl5QjJoSnRmUmVML2pBdTM4QWRXb2FrTTBFejlpMG9KVTRMMzkvcjN4?=
 =?utf-8?B?SFY2RkdxS3JRdWNFYm4wRzJPdnVMbDZjR2RMb1VmRXBuanBxbDdlWXZZQ1p0?=
 =?utf-8?B?M1JxYlFRVVY5eEVqWUFNWnNWUU1GNUY3Yk4yVTRZK1VjcHF6cVNDMnZCUjdZ?=
 =?utf-8?B?Q3F6clFoRG5PNEtjRjBRQzFuUHpuY0FIeEVnSVUzeHlCd0VmRnA2UmpvZ0pW?=
 =?utf-8?B?M0djWnUrSFl4Tkd5TjVRSGc3dHgrM0VMRUdaU2JlNVM0TlppSFNZbHVYcDEy?=
 =?utf-8?B?ZzF3T0FKQ0c2a0Zpc1NpOFF1OWp4ckZSdkNLaTU4SE9XeHEwN0FhR1RtRmxB?=
 =?utf-8?B?ODY2R09zc2srekJGUFFFSm90UENZeVpncytOZnhRTXNvYTBIeDdMbHNTZ3VL?=
 =?utf-8?B?TXBsMDF4b0tiZmFzWXJHOExvTnVxbEhwSmtYbEhpc2o0N0dRYkFJcUZZWnYr?=
 =?utf-8?B?TDk4QVJtOXhTNnlwL1hydUZIZHBycVVOS1JUMlMvd2tPN05XVm1YYjBBNWY4?=
 =?utf-8?B?QTErYzZzdmJUNG5xWTJXVzZRZTg0Q1Q2UzE4YVllVzVLZkdvckVWUFFMeGN1?=
 =?utf-8?B?SlRvY0dUSnAvc1gydTVtZ2Rpbnh3RHdFTnh0cUtFL3RKaW1jdHFxR29MYnJn?=
 =?utf-8?B?QUNQZHA4R3JkOU5NbU5JVythLy9MbWx3UEVURkpIOXRsUVo1bnNHbmduSzJu?=
 =?utf-8?B?c1hsOGhudU4rZ21ldzc5OHNmSU50ODhwQU12YVpXb3d3WkNRQkF3S2paWWtv?=
 =?utf-8?B?LzFCcUppZHVnbXRvcWhPUnZyaEk2MEFGSXg2cG80aTB4Rm1xNThTSlJsQ0dH?=
 =?utf-8?B?ekdMNUkyejN2ZFhmOVNxQmNSeGFTQ3MyMmhXWWprUkQvaTRhYTdXRWxEM3JM?=
 =?utf-8?B?bGtkRkxSUnJ3QU5mL25yc1hXMTc2ZmZWUjJ1aThzTVBaakk3YzBYNlVjL0pI?=
 =?utf-8?B?RnF2ckUrc3BhdHlHcmM1amIrSEhjR2d0SlUyVFhVNG5xaVUxeE5TZHh4aHdY?=
 =?utf-8?B?S3FyOXVNVW9ta3lrdnE1aTZxbnRQRjR6OU5LYS9iZWlqdjZMNnk4aTV5eDVx?=
 =?utf-8?B?NTFpb0NNcEZRQXlsR3lhUVkrTEFtSDY5cmRnaTJyWGZrejZ6TFRPaDFyeDY4?=
 =?utf-8?B?WVRhVjhXMHBxWTNOTWYwd2JqTHlNK3BUZVRIOFlhVmZYMUFiSG5WdlEvVXJT?=
 =?utf-8?B?cnA4Nm9qanVvSnloV3VOZDhyQ2tBZUQwNTZDWHpidnhTbkZaMXB5NzJHQ2l0?=
 =?utf-8?B?a3Q1SjVhdS9VT1ZpOW9ESWFtSkJiMmJ0UXViWnJlckV2THZlYmRWeGw0QWF6?=
 =?utf-8?B?VHMwbUxVcEpIdmxpZVJPN21LcHY2Vjl1eE0wYXVhSXcrSFJiSnhsU0RlTTJX?=
 =?utf-8?B?RFNoVjNOTTlNZkF5RWNnQXAxT292M1p2VFI3ZG4vQ3F5eWFaVE1jQWFtV0dV?=
 =?utf-8?B?YTFPU1M4VVFkZmNtL3BTbXF1VlRKUFRRSkdJaUEvR0lUbEJLMWpyR2NoMkRH?=
 =?utf-8?B?bHhUcU1EQUw5TkszRUU4ZEh0b2J5dzhFRnJ4ZjBMbURSMlZwTDNVUnBJRGZs?=
 =?utf-8?B?bGVkL090TGZZR2dZQy9uT2VMZWdQSkxTRHk0bXI4TVVCc20wdE1nQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb52ad17-32bc-4e4c-0bb3-08de5fc24c6b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:42:04.7541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L347vx7eJHqs6Lwp4Tmg3lOfKRDePOyzSE9g9xDPUO7KGDBtQAr/MH8qYMp2AwRt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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



On 30-Jan-26 7:59 AM, Gangliang Xie wrote:
> add smu interfaces and its data structures for
> pmfw eeprom in uniras
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 46 +++++++++++++++++++
>   drivers/gpu/drm/amd/ras/rascore/ras.h         | 18 ++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> index 79a51b1603ac..03922aa03417 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> @@ -28,6 +28,16 @@
>   #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
>   #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
>   
> +static enum smu_message_type pmfw_eeprom_msgs[] = {
> +	SMU_MSG_GetRASTableVersion,
> +	SMU_MSG_GetBadPageCount,
> +	SMU_MSG_SetTimestamp,
> +	SMU_MSG_GetTimestamp,
> +	SMU_MSG_GetBadPageIpid,
> +	SMU_MSG_EraseRasTable,
> +	SMU_MSG_GetBadPageMcaAddr,
> +};
> +

You may consider designated index initialization to be explicit.

[RAS_SMU_GetRASTableVersion] = SMU_MSG_GetRASTableVersion

Thanks,
Lijo

>   static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
>   					  u32 msg, u32 *count)
>   {
> @@ -87,8 +97,44 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
>   	return ret;
>   }
>   
> +static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
> +				enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	int ret = 0;
> +
> +	if (down_read_trylock(&adev->reset_domain->sem)) {
> +		ret = amdgpu_smu_ras_send_msg(adev,
> +			pmfw_eeprom_msgs[index], param, read_arg);
> +		up_read(&adev->reset_domain->sem);
> +	} else {
> +		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_core,
> +					     uint64_t *enabled_mask)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
> +	int ret = 0;
> +
> +	if (down_read_trylock(&adev->reset_domain->sem)) {
> +		if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HROM_EN_BIT))
> +			*enabled_mask |= RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM;
> +		up_read(&adev->reset_domain->sem);
> +	} else {
> +		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
> +	}
> +
> +	return ret;
> +}
> +
>   const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 = {
>   	.mp1_get_valid_bank_count = mp1_v13_0_get_valid_bank_count,
>   	.mp1_dump_valid_bank = mp1_v13_0_dump_valid_bank,
> +	.mp1_send_eeprom_msg = mp1_v13_0_eeprom_send_msg,
> +	.mp1_get_ras_enabled_mask = mp1_v13_0_get_ras_enabled_mask,
>   };
>   
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 3396b2e0949d..2db838c444f1 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -49,6 +49,10 @@
>   #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
>   #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)
>   
> +enum ras_core_fw_feature_flags {
> +	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
> +};
> +
>   enum ras_block_id {
>   	RAS_BLOCK_ID__UMC = 0,
>   	RAS_BLOCK_ID__SDMA,
> @@ -127,6 +131,16 @@ enum ras_gpu_status {
>   	RAS_GPU_STATUS__IS_VF = 0x8,
>   };
>   
> +enum ras_fw_eeprom_cmd {
> +	RAS_SMU_GetRASTableVersion = 0,
> +	RAS_SMU_GetBadPageCount,
> +	RAS_SMU_SetTimestamp,
> +	RAS_SMU_GetTimestamp,
> +	RAS_SMU_GetBadPageIpid,
> +	RAS_SMU_EraseRasTable,
> +	RAS_SMU_GetBadPageMcaAddr,
> +};
> +
>   struct ras_core_context;
>   struct ras_bank_ecc;
>   struct ras_umc;
> @@ -141,6 +155,10 @@ struct ras_mp1_sys_func {
>   			u32 msg, u32 *count);
>   	int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
>   			u32 msg, u32 idx, u32 reg_idx, u64 *val);
> +	int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
> +			enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg);
> +	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
> +			uint64_t *enabled_mask);
>   };
>   
>   struct ras_eeprom_sys_func {

