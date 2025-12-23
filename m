Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6459BE6F098
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 15:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FE510E237;
	Tue, 23 Dec 2025 15:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K04efYi7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80C510E237
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 15:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXuoE7Li8guxMPiplWWtwlBrsd82UkIY8FImcLA9ZaXZg2V1XKkZfB/E9FA77KrFa1R8f52kefRhFazeLBvCuuKqeVbamfGb8yPb3z9PmbHbqEylCKCA4HuzE4+H4PE2uRCeyaQU9ms4U1CiSTgpGROtfCO7J4ney8oSBoFOpHQ1IL639Qp06Owg/zcRsjYlslVZ9mxY4shfDcHC6tI2sGUeagvYewlgKstvjK3oKmzF6lg/8RUZw+DBQzWHm7Rk81f4feB1uriexdYtonqRLWxacQ7eUFRx9kF8O+tqu4H/rMcCODqcdnj3HdgegPy4Y1skccp9zoW8J+t8bbpINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beQvXv6cL5jPbA6ORB1IIl7qVotpdv/vtp5SO5aW4eo=;
 b=hu+JorkRVrAJTY+6NfTSazk+uBhdFmuQQYt2Z2AXNhLq2R9fQPc09QjT995cm7TIsXFxz2+Q9XFcE7IMDT2Ws2kH5GH6lcq+EcNFkVDyaB6Kg4KJBLSG//PAbRFXHH2uNavSSR3Xm3rGentTo/XIY01J4xTqnsvoeaUg9/yEHZgeKjeGsgmq49qzqf1DbWGU9uF6y46xmortpUhtklskjSZ8Gb4fvV4CN/E253Mfk3kKEKtsb5WKsUO+QqsZ7ca4KylMQMn4ztS8GAFRGiGIkAR7v5Ts7EArwb3VvbNqYG3nbq+8cZZt6E2a1dtdkJXLnDFSpMy/ygVcQoJvBCmcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQvXv6cL5jPbA6ORB1IIl7qVotpdv/vtp5SO5aW4eo=;
 b=K04efYi7ZM5q14h5pxxPcgi0v+thAsfGDfTqF4Nj93gUpPbLwt/G2G1hrtD9nMVKVPkXVM3+FvURsgUoN041cCIICE7o65RZOdCEjFr45qEBZZgZUNviCGxLtzBhHrHbVNB8TJtkkqVUw1c8QQ6sz9vEt/+5VqewxUoTNjQxdFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 15:01:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 15:01:21 +0000
Message-ID: <f197aea4-042d-48e7-a675-88534f587943@amd.com>
Date: Tue, 23 Dec 2025 16:01:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add entity's check when alloc sdma jobs
To: Bingxi Guo <Bingxi.Guo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251222033349.156700-1-Bingxi.Guo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251222033349.156700-1-Bingxi.Guo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f76eec-5d5d-4a91-5b6e-08de4234221c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEtpOFNBYS9Gcm10T2UxN1BNa2ZiNkNiNHpBRHAzWDhnUXhjcERoRXh4bXRO?=
 =?utf-8?B?SVo0M09QdTJCQ0xEZDNjRzVmOGNaZmR4cmk5Z1RwWFVycFRpVXU5RFpHRmhF?=
 =?utf-8?B?RVYvbGJ5eDMyL3ZzdkFmRkdwQzNBeWhNa1dWOEwzb3A5WFB6SWV0VzJmb1Fl?=
 =?utf-8?B?VFhPMnRtQVhHdmh6YlB0NW5xdmViMEFtdzlkL2RhTkVvcUpDSFNjMFJ6eXRH?=
 =?utf-8?B?ekxMWG1nTmdTREdCbWI0TmF5TjkzeWVxcjFsK1NkMFJCeEkrOXV6cjk5b1l4?=
 =?utf-8?B?UW1vOGt6TVc4TGhVTTlIdm84VnFIM1U3MTRBU1BFYVZ1SERmV3hpbGlMQzkw?=
 =?utf-8?B?MEM4UmZaTm5EekdMNlpsWTg5N1I1SmQzU1hIQ0xIVm9lUWE5VjRMaGxWM0xP?=
 =?utf-8?B?ZFB1K21kNGlWSWFTMmx3WUdnUDhNMDFsTUtIWmhJZThVZFFzTk1WcnloT2hz?=
 =?utf-8?B?eExGdFpEZGJLMWZ0emVRQlJ3NEE3ZmI4alN5a0NuV29JQ1FPSlBsaVVpYzRO?=
 =?utf-8?B?a3gxSzVzQTFiZVlqcEtwUjk0azRKdEtyYnJjWGViamdkdEdZV1FCYkJ6U0tu?=
 =?utf-8?B?MHZNVFVCUVdlYUlHMU5rQmYzL3ZHUGt0Wm9HWm0zS0FvRjJDQ3NVZzlCNC9P?=
 =?utf-8?B?RHczRmYxLzQ2UFZyckxzWHN3RkVMTmlLK2pZYmxBMEcrdGJuSjViMWp3UTFT?=
 =?utf-8?B?UnNMWkJLeDVQOXJoTGdKN2pxYXZjeEpPVGt5R01nVnBHL1B4eFAwUUEwdDRm?=
 =?utf-8?B?cG91c081Tml1WTduZjhScTBycStHajJJMWE2ZVkzNm9DVGJ2YVpWU2ZVSGZR?=
 =?utf-8?B?a1JDL0JpcWx2WlVIWENLNkRyUTlUZGxZYlpqZmQ3ZXU1VmlTbkljVDZGL0pC?=
 =?utf-8?B?aU1SbHdCaEVPZHJWMktMcWJ3bmlraXBHL0xKa3U0d2R2QnVYdzN1bndHSUVG?=
 =?utf-8?B?SDQvQnlhb21rbm9PVitEYjA0NHoyQWNEMUFyMzZFVXZ6TDI3VUd5cm5CWUpj?=
 =?utf-8?B?QWt3VVQwRlRXNHhSa0xGcUdDNFVRdW5xL0dwL2VWV2I1LzRMMSs4OVVNMXNr?=
 =?utf-8?B?VS9xWENQV3NFWFdBWkdyV1BoVklVdk5ibDJwSURIVGQ0TE1wWkhNenBDUWZD?=
 =?utf-8?B?ZjJYNU5wOGNHY0dFTml5K1dCeVJmdTRUWnNtN0d3R0xlTFV6cDJKblZWcnEv?=
 =?utf-8?B?VlYxM1BLM3VNUXQvUnlsYXFBVGY5NkhoTiswdVFEWmhYT1Z5VnhFUWlIR3Bj?=
 =?utf-8?B?Z0RsZTU1UXIvbjBGaER5cFE2a0Q2NUNPTGVsNzE3Q01SR3RqTEUva2plRUJB?=
 =?utf-8?B?YnF5aDU4MWRwQVR5MXVqdi8rcVcvOEk4NldxM0xNNHNxQ1d4QStObHNES0dx?=
 =?utf-8?B?NGp3LytpeUJtL25lcmZ2RHdpWHZNUjFuaUh6MmFSZ2Rxem43ZlJzaVBRUk9D?=
 =?utf-8?B?bmpRd2F6SzBqSHJMSnQ4NzhMWmFMWWZSNDJQaWloSWo0dGRmeWFsdzJHQkVV?=
 =?utf-8?B?S0xLendZL2w2ajJTeXhZTy80R09CWUNwTCtLckUzZEM3dzRtZTBWNE8yQktK?=
 =?utf-8?B?c1Eyd2dDbkVLYXFTTXlhODVabkR0YjNDWVZ1UFIwKzJZR2doM1FyZ0xVcDZv?=
 =?utf-8?B?RStOUGJlYm9oSDEyaUVSZVJRYlJkRXcyYnd0SzBIY2pscnNxZ1JLTVZhVUtK?=
 =?utf-8?B?azEwSWZxSUhIdWZqK2FTRDkzNjRnM2tybloyZm9qV0xXWkNSTHlObEtlT0hN?=
 =?utf-8?B?c1gzMUtXT1dHamE5NE5wQ0hRUXBHeXdqa0huOUs4NTFGeHpwN3dDSmNMbm53?=
 =?utf-8?B?SGtld2hXd25uT3hXcUl1V0FLczJQZXZwQ1UrUHhaT2VzWkZ6aTBaa1hRdWdr?=
 =?utf-8?B?VElZR1BZRkZJdWxUTytpbm5SZmN5RE5ETVBzZWd5YksvZGVSNDhsVU5IYkVw?=
 =?utf-8?Q?pRJUcawTF+IMRXh7arX4KVGmzyzmMvZw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZBVUZTYzc5TjRaQ296c2x2bW9BMUZQSEsxc09FMTZWeDRGZnJiZXQvbFFL?=
 =?utf-8?B?bkZMNzA1eUhhbzhKeDkxQm03SHRQUmdKWGVqNGJZakZ5VTNxb2VyTGcvN2lI?=
 =?utf-8?B?bWJBRGtqeTB1cG54cUkxVDAzRUdMMHRJemdMTGNKZm13eFhQM1d3VFprbkRZ?=
 =?utf-8?B?Sm5hRXQxVUt1U01NUXgyNDJ0NE9FdEtQRFVnSW5GMEEvNkw4NWtiTzJTL09l?=
 =?utf-8?B?bi9IcDR5UGtBT0xzMkFncHlmcDkrSERXVGpzdllUZ3FDRzl4UEZXaTl5Uldm?=
 =?utf-8?B?YjRJUTVzL1pUTmYwMGFDaWFnYlRHdnNtdTNPMXJOZ1RDdXJuSitOOVFQckFO?=
 =?utf-8?B?UnZlN1NIeHhGNXUwaDZwcTNndlp1OUJNNDFMT0ZyY3M2Z2dWUmJrRFNwRGpK?=
 =?utf-8?B?RXl1U01pVkhpbitTMEZsek44eitIUGNaY2NUVmFrSzFjWjhwTHZFeDU3ajln?=
 =?utf-8?B?bmF6Rlgxd2s3WXh6c2sxR3BSSHVDMVcvNVA2cDZGWWxvTEFONGhrNGVBWUpw?=
 =?utf-8?B?T0tUMkl5S2kyNnhjVXlqY1A4L3pTMmwwN05sUVBhODMwY3RLNGh2ZzdreGEw?=
 =?utf-8?B?T2E4QUxwUFF5QmxHVE9seG9CelVBSVBxd2hXZ3pWbEl5SW9oWVliZE5OUlBR?=
 =?utf-8?B?RzBvZ0xnNXErc3ozODVKamNnWVR0UzBQeStCMDd2Ukp4WmFCNHowQXNuT0JX?=
 =?utf-8?B?b3liOVkraUl1dHF1UWNPUHZIbUVoOGljRlIvbUxFdDNUaEM5WXhtNDltTTFV?=
 =?utf-8?B?bEFvYkZIMFpZNDA1L2lndTNic2xkbUorcTNXVEljRFdyQzRaVUZrMVRZN3NC?=
 =?utf-8?B?VldRc0ZkbG9sWjY2NzlVY1FXdUJmRko2STNLemJNSVNmSjB4WnY2NW92Z3E3?=
 =?utf-8?B?bEZWRFNRNGdSODBNQnVobzd3K04ydUNIUE8zUVNza1N5MGYzWmt6ZnMyU0tS?=
 =?utf-8?B?aUNzNUY4c0JLbU1ZVnh0cHRFY2lRVXBINUI4Y0RrVktTbFEzT0J5eXJzRDAz?=
 =?utf-8?B?Q1EwejVsZ0hoR0tOS0diOHNIU1g3dldZTGRkT2VzbjcwRGZ1ayt6WURFWUw5?=
 =?utf-8?B?OHF2bHNtMkQ4cXB2T1M0dHdZRU1Fd0UrRW9lT3RaMnB1akVrQldad05RYk5M?=
 =?utf-8?B?Y1ZxcDdtU0wrWTM4MkxJTEsvcXR0RmZaVFQ5RHdJS0dzcG52eG9GRm9nN0tX?=
 =?utf-8?B?UVM5Mmd6eTdFclp0Y0JGV0RUTXFIYU1DeFZ3WU9aNDdNcG1GM1A1emNISzMv?=
 =?utf-8?B?ajJ1bUdRY2g0SUVETU02YjdhalNNNnR4Nm54RzlNZ1h3MG5Gb1IxVlVSNFkv?=
 =?utf-8?B?UVpDWDIwN0p0MHBZNTI0TStrak11MUdOQ0tVV1VZMTlUcWdrUE1WeXNRS2VJ?=
 =?utf-8?B?T050d1N4OVY5cTRKYWMwcENQM3h4cVl0WkVWWGwzdFBGQWhKUXpMM29RS2xQ?=
 =?utf-8?B?Ti9Ua0ZETW1nUEJFWjVuYnozaHI5OEhhU0JKQUxxSWIyMDBCeDBiK05YcW05?=
 =?utf-8?B?RTlibzdTVE80NEFLOHRpd3Jpd0Y0T1BMRnNVNnNOSUJleEY5TG4wY2Q0OVBQ?=
 =?utf-8?B?TCtFVStBTXhiL2FKdFB1VEo3ZW5TTEdJRkprUVhDK2k5MEovbExtSTJPTFJR?=
 =?utf-8?B?bHVuVTRzek5IbGF6L1ozQ2p6ZzZnZnhZQks4aHdTcWQ3a0lRRGgrTHlTTzFj?=
 =?utf-8?B?dVpDeGFtWEM1M2ttNXNkK2h4SVBndk43dGllYXpwVnJlR0lIVituOVZwU3Zr?=
 =?utf-8?B?SXJXWjRLSnhzWVpUdHZ2Q0xjNlF6TXp2eXgvcVl3QW9JZzlwZWFZS25RU2dN?=
 =?utf-8?B?eTBvUlM3anRXckU2d1ArWk8rbHBQZmtPRWhWUUtIVmFGSXlndXZCYUI1Ymp1?=
 =?utf-8?B?SWd1cVRkZGVYaXpQclhWWUUxS1cvaDA2MVE5di9sK21SVTZNMk5lbWZEUlIx?=
 =?utf-8?B?azUxcmtDcDA1YXFpOHFKLzVJRmZtTmRNenlwVWdiL29waHdORWRTcDMvZlFs?=
 =?utf-8?B?ck1hblE1Y2NtUkxuK3ltOHl2TTN4VCtSSTFHMHVURitZMElmVmNTazVxa0h3?=
 =?utf-8?B?NHd1b3FuSjVnZXJjcWk4eVJpL3JmdGRaRnNTQUpOYVNoZjdLV0lLTDlQTVds?=
 =?utf-8?B?T3R1MGNhZ0l0bHBpOC8yNDVDc1RWSittTWpJTlJyUFF4QXRwdkhybUNlUDhP?=
 =?utf-8?B?Qzkvb0JMdnBSaUMzM05FMnJrQ1VQakhybmNleXdxVHkyOHhiV0ZuVXI3dnNC?=
 =?utf-8?B?ODdNR0ZpMEh0N3UzdStjQXl4eHBmSTVpcEdDdzRyOSs4cEpYRlpHSnFTVmtL?=
 =?utf-8?Q?lHgJ/0xp7QtXoUWBlC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f76eec-5d5d-4a91-5b6e-08de4234221c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 15:01:21.3781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpQLdcZgXX7NABneH/Wg+b30uPo/YSFEoAjYa/5PUgwd0/cvUZENL/1zIrPxkJaL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

On 12/22/25 04:33, Bingxi Guo wrote:
> issue:When one of multiple processes sharing the same amdgpu device

That is illegal to begin with. Multiple processes shouldn't share the same device fd.

> fd is killed, amdgpu_flush runs but amdgpu_drm_release does not, so the
> vm's entitys have been stopped but bos still alive. Later, when the
> KFD fd is closed, the driver unmaps BOs from the GPU VM, clears the
> freed BO list, and normally submits SDMA jobs plus an
> amdgpu_tlb_fence_work to wait on the job's finished fences which will
> not be signaled.

The problem is the KFD code and not the SDMA backend, this check here is especially racy since the entity status can change as soon as you drop the lock.

So clear NAK to that.

Regards,
Christian.

> 
> add check if entity is NULL or has been stopped, if so, don't submit
> sdma jobs and create amdgpu_tlb_fence_work
> 
> Signed-off-by: Bingxi Guo <Bingxi.Guo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 36805dcfa159..e57d496a06e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -49,6 +49,13 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
>  	unsigned int ndw;
>  	int r;
>  
> +	spin_lock(&entity->lock);
> +	if (entity->stopped) {
> +		spin_unlock(&entity->lock);
> +		return -EINVAL;
> +	}
> +	spin_unlock(&entity->lock);
> +
>  	/* estimate how many dw we need */
>  	ndw = AMDGPU_VM_SDMA_MIN_NUM_DW;
>  	if (p->pages_addr)

