Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42C0C02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 11:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CDE10E5D3;
	Wed, 15 Jan 2025 11:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDYdR7bE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B961610E4F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 11:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzR2visTWJx6IrE7O7NjuHkAnQePfd7iTNVnieFuETsXIexyajN9mH2Ah6k6UHEBAMqPkMhP0CuTZJ0oCbPADlHp3dUqa8T30kPWrnC6T5hk2Nd+vlDVdf2UsTC99JW2Im9veZlUZlp4AO8zSJAMobKybY9iOezKQ3mOtQ9YwTasj6SPnpbXdiNRz6cFc8C3DPii1+adw7RvTnA4aOqWD74RFFNWtpykVxbZhd9cH1ELulR/CJZaPlSWNHk+KCpUd5CvahTn1NVW7VaKwk1R4vIL+uG/a56laozFKl5kA+fdeCVzVNROl5NXvyxOwpNBL9XemSJdisdvJvxZCPmGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaKNC7Ihouqep/iepG9IGEpzp7SbMl4GLnLhEkazBYk=;
 b=Kjoq8gwFwvyzzdwHIr3hN3XK+5/CJJrj9IkUFXjq1YPlcQPjTw1GNtRwYqLobI5Gq++iOucpKAUDNDD28kNF8m/kLAEiMRAks7bgsfHHi6eclO3HrHUK2dJ1IofDLPVDiB8As0aQmGRhGRY+IdivLcWWv3YX88eCo7ZmhM4ypb0VmXzih223TlRon2v65obYda2RPJ9GAON3X0izBDmL6iAwB6MRlP5MGzKel1V11EchKwYGCI5WS/mJke+sjYvRJ0nXJ7SNdAkGHWaxYTBqaeU02mbPWKOjJcwOXBUvUkL1Tp5M76CCT6tmlh7u0A1nvBHCNlBzZoyLeYWMqkf3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaKNC7Ihouqep/iepG9IGEpzp7SbMl4GLnLhEkazBYk=;
 b=jDYdR7bEITXiUEJr23nBYbIJKbbVKsWNcDIpt+SKI4b0eY1PZPSr1rGfm8SkDTgFT0mZHLq7n53FmsZVt6mOHwl76gvGldnj9cTQeeoxKgZSOhXQZkMh++vABRPDyxd9zwHZMzPq0V8uh/tXrSFHu/T971OsgRFTuqyAk5tlbuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 11:01:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 11:01:27 +0000
Message-ID: <f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com>
Date: Wed, 15 Jan 2025 12:01:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Unlocked unmap only clear page table leaves
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250114145314.4633-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250114145314.4633-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: a27c5a16-888b-4b5f-9f9c-08dd3553f594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0YrSHhyWkw0K2FCd2tlN05jVmVtRU1GQ0JNR1gzUFg3QmVhak0xc3BqZWs1?=
 =?utf-8?B?c2dHTTk0OS9YM0RkZ1ZHdUdMTG5QSzIwR1k3bkpCNXFvbERDODdqemtEZWFF?=
 =?utf-8?B?eUtxZDdHS1EwN3F1SDRVUmM3T1c4V0poTWRSVTcrb3pLQ1dJbVIvOGJiTGln?=
 =?utf-8?B?cDFrOG9UMHZ1QkdyU2hiaE5kK2RHZmdyZGNrU0hTUXhxRzVOMWFkMlkweUk5?=
 =?utf-8?B?T0JRZWpoSG94WVZReHBxWEUzQmQzcFVteDFCZ3RSaFJqWU5TQ0FEYWpSRlht?=
 =?utf-8?B?OENkSUtqOG9lTjJNV0tJczFsT2VWdW13SnZtdDBoOCt3SW5iUm9vd2htOG4y?=
 =?utf-8?B?ckpZbmkvMFVOcHMvalllR0tUOHBvNHBsNXQwd1VjdHhiNTZ5NXUwRUx2Sld3?=
 =?utf-8?B?eU4wVTlJL1N6QUFhcVAzTlIvS3ZFMGZZNkRmU0ZodzVVaTlZN3lnQVB4WitH?=
 =?utf-8?B?UndmS0ZzUEtVZjZSem8vMmZZQXN3RVhXSnI2cHZFQk1DUysxZnp2OVdzNlJr?=
 =?utf-8?B?RDh5RzdGT1dEWkZMYkVoeCt0QTBvOG9xaFNEK295WDZQV3piWHdEOE5xS0RR?=
 =?utf-8?B?ZzBUSmh6bUxwUFBSRFN5dmdCdmlzN1h1M2ZQRzhCNjVXOHdoQ0syOU1pSXV3?=
 =?utf-8?B?SHo5T1lOZDUwTDVlQ3Z6OFdSR094SlFjOGFOaUt5TVFoMGFJRjh6TVdVZVhG?=
 =?utf-8?B?K2Y2VWxCY2dGQzB6d0lEbUpYWWVIYUhvdktqQ1ZTcTFnUkNocGFlQTYrUzRx?=
 =?utf-8?B?K3c0K1BjMHlBbjExQUZmMXpWd2Qra05FdjhkSElKMzBwV0drRDB3S0MyQW5z?=
 =?utf-8?B?RDlSWDBOWVByblFxNGZ4UHN1QkhIWXRzMVdUOEtoeUt6ZS9keDkyWi9NVTBU?=
 =?utf-8?B?ODBzUjRrWGI0aFJoWncwZ0ZWZ2JPWUZCNWtVQ1MxczNCSTRhNlZudTdWQ0ZS?=
 =?utf-8?B?SWpRTjdzMHJaUE5KaUpBTkZWWkJhVEc0bGI5RmNIS1VoQmV0YURqT3EzOVRz?=
 =?utf-8?B?TEhFVWJQYVBUWG43OUNYSVMxYTRBZmFrV3hxczVyK1JFbkFxdE85Q01BYTBm?=
 =?utf-8?B?cm90Z2xNWWpkRENvWlA0Q2NZQ0x4cHpGczdteGNTM2g2WFFDSU9LNU9ScGpC?=
 =?utf-8?B?b2tISkRPWHBHOExEbHJMWFFoZmdsNjFGOCt5cnZPcUhtZ1hoTjRTclQrSWlR?=
 =?utf-8?B?eVdlNUl2YWh3MUo3cVp0M2dHNVJydjRlOWVIU1R4cmdQZE5tNjlUalJsejdF?=
 =?utf-8?B?L250Nm9qcktMSFFSdHlha1RXWnJqbGZnR1lncWhoNHg1S0xUSnJENHBGSkZa?=
 =?utf-8?B?VG5YZnFEazcwUFhBN25mWUdJSkpDQ05mZzFIS0pXRTlvcTA1ZHpNc0xRYk9I?=
 =?utf-8?B?OEtuWkwzT1VQSkNhUUlnMUEreGkxRDRiQ1lqQ2tZdzZTSTh2RTlrdllEUDJJ?=
 =?utf-8?B?ZDZpcVRvcDdsSWxKSStWbWNMRmtZdFlZOGszQTVXcHNqcnd6Q1NGYnAyZE1H?=
 =?utf-8?B?SXVvempoSnVXaGgyODFlRDNhZWcyTFFaL0UrNlNkZER1eUdsQ3ZUaW5ybU9P?=
 =?utf-8?B?WVJ0MGlSQ1hXa3MxZ0E3QXRSdmdHeXlEdEVVcXdCYjMxbEVOS09jWkdPQ0FM?=
 =?utf-8?B?RldDSTdHbFp4MHgwcUxRL25OZDJRbE5HVmdDc3Rzd1B2WU9zWHc3V2NZU3Az?=
 =?utf-8?B?aG1BYlc2OVhmNzJwUXdqR1VqelEvRkFybVYwOW8veW5ucS9FZDFTNUpDNDhW?=
 =?utf-8?B?M1hOVUZENFUxb3RzSzNIa0xCaUNEampnNjRzNmtCaHIzSlBSMVVHK01uUDI0?=
 =?utf-8?B?VENVVGJRNVNvdmlNSHpReTJmbDgxM1BJcGNta1V0a3E2NlBHYmQ4dkZXRGps?=
 =?utf-8?Q?cnfFuoOkgAhI0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGlCYUlDWGtPbzVSai8rb29SdVdzelhKcUp2eExvUnkzV0Jwd09ETWJrOWcx?=
 =?utf-8?B?dnFoL1lGaEIxQlZ4OEt5S0krNmdTdVM4ZWJUNnhpNE45WG1lTVdRVDE5b3dI?=
 =?utf-8?B?b2x0Wld4akZNSnZiM3NEdnREcXYzSENXOW9XZHlOUXBUUlczN1hzejlNZ2d2?=
 =?utf-8?B?OXBlc24rNFY0TGRRR0NuQmJpQXFIWkxaRy9UenJnS0VML1U2eVFySEsxTEJJ?=
 =?utf-8?B?Q2J5TU9ZbkwxaWF0ZWRTNGFMYUlncmhrcVJFbWVnQzlNRmRNeE5YZ0JEckc2?=
 =?utf-8?B?YldBZk9qaXpsK2NFeUVqM3BlUkRXMS81T0JvbzAxUmV4OTM1UTJSc2FDbjdX?=
 =?utf-8?B?N3BaVlArQlNVSUdpamtFL3NKRWp6TURBQzc4RHlhaTc1M1Y3S3d0NHpyT0VQ?=
 =?utf-8?B?alJXUG9TSFZFU1RvU3JqUWtQUmRpTlkxbVBuQmgxdG5qNDVZaldseW9ZZllC?=
 =?utf-8?B?UzNNRG4yajFMc3ZCVkwzbzZIbnV3cnlSdHV0cDdiTDhpb2hyeWRHUUFzVEJK?=
 =?utf-8?B?a1ovekZsZ21TZGd0dnRpVVk0U2VHa3IvM3NabWVsTFBDTWpNN0tlYUVzdlJm?=
 =?utf-8?B?bmJoMWF1bU5wTU44NVY0ZDBOOUcwRFgvN1EzQ0dPWmRjcG9hMU9Xc3VGT3dt?=
 =?utf-8?B?eitRVStGVC9jMWo3WVVnY0lSdXppUmZsZGZROGxWMk80Q0xmSythRExGaytt?=
 =?utf-8?B?QnVpSFhYU1BoK2VpSEV1eVRZMmdZMFR2bFVEc1BuRE9XOXhZN08zMWNqQTMz?=
 =?utf-8?B?bG44UGtKS1V5SHpsQW1UNG8raXNsUGZDWFZKamtaakJ5Mjh1ZHJiYlFIc0Ew?=
 =?utf-8?B?SExYWWQ2amwwWU9oV0trM0FnZTY5Vk9RcEgwOHUwdHVQeXlSWmx4OUF4OWJF?=
 =?utf-8?B?a3cxeXVldURjTWcyVnNtdHl4d3dVQWVIK1YxS3FkbUNmdDZoVk1kZTlYcEEr?=
 =?utf-8?B?eUpmZFNuTUdZZDFLcTNoL1U0SnVaVjJ4OHRnZWxkWS9YRnhmVEI0WWxkSEhR?=
 =?utf-8?B?Q0lLNGpiODIydVMvL0poYnhFQWoyR0gvOVVFZWVFblczT21RN3Yva25IWFRB?=
 =?utf-8?B?YTBkT1BqTHVjZTZ6Tmx4QmEwd3RNSDcrK2pKcGZST01VWXg0aEZ5SHNNanNH?=
 =?utf-8?B?VzltUUc2YWlqZkZobGJsZFVOUjFHRXlPNnQ2aXBOTlRoRkJzK04xbHhkd2FJ?=
 =?utf-8?B?YlpjRlpCc2JaSWw5Q1B5RVNhRUpxT3ZYcFRRek1uVFVGTkpUeVp5aUFDTm4v?=
 =?utf-8?B?RFJhMS8rNWpUck11YmVQRWE2aTVaMG9qK014SHdwdzN1d1UyNW01NlhzeXVV?=
 =?utf-8?B?NDd5OWhIb2RRcWlpZjIwbDdXVGN1TUZlVXM5TU80MHlwQitxc0VlUzcySGow?=
 =?utf-8?B?SlFINytycFJITS8vK1IyNHU5bEtFdG8rN2I4Z3lwOUliMVU1RHpLTERkeG9t?=
 =?utf-8?B?cU8xdERabGRHUlUyMXZzWGtDdWx1NS9oak4vY0pvV0gvQTQ3Zk5UOVM0dzNZ?=
 =?utf-8?B?MzZ0bW4vT2EwZjhuNitrTjJYUWF3bWdUOHNEbEZzMGYrQkpLKzhnbzRZc2pP?=
 =?utf-8?B?cDVrbFp6RU4zRkJlaVhWeXhJeUUzajAxTVZJdFpSdUttVnFOOVQ0NkNLMjd5?=
 =?utf-8?B?aExYRGhNRWdQaGd1ekpaOTBCVXRMUFhtUXBoYWlqdWxIMUxwR1N0ek83ZXVx?=
 =?utf-8?B?SzFkMlFTWitRSHcrSFVWRDNrWUpVVXpEMzBrcTVjeUhhR1dmVS9zRXJEUW1v?=
 =?utf-8?B?SFBiTEtqM2lVQ3FHcTcwdnRQcXhEVnJ0ZHpKZVUvNVN6Y3hjMzFLOVNGaFRK?=
 =?utf-8?B?anhCUEZHU3UxcXE1bW5pQ1J1dmJJM28rMmxMN2RyMnZPZ2hJQURCSXBNY1Mv?=
 =?utf-8?B?OXJrTG1GNzhWek41TkpjQjJHamkvYldUTVZCV2VFWXRGQTU5bFV1QkN0dFFP?=
 =?utf-8?B?UVlHMUJBRzUySG5xY0xmbmpiTnM0MjlkMVFWMlpWUWVxTDBOSEpmSWdOSzdC?=
 =?utf-8?B?ODVqV2UrNHlKMTVQcjd3L2dKRnprclRuRUlRbTdLSndlUUhLTEhyTzBhOW5t?=
 =?utf-8?B?dC9SSDVCVGpHbll4ZkFacnFFVGRISmIxWWM3a1pmZTdoQWVzYkMzazNHLzlR?=
 =?utf-8?Q?lFOMAsu63tuiTV+1x8J35AJB3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27c5a16-888b-4b5f-9f9c-08dd3553f594
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:01:27.6599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv/9Wgx1801zXM/S6EsE6G8fbYhuTRbTFmJbKvZWnVJcpPbyJQkj2Vo8ZLI1Wyxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

Am 14.01.25 um 15:53 schrieb Philip Yang:
> SVM migration unmap pages from GPU and then update mapping to GPU to
> recover page fault. Currently unmap clears the PDE entry for range
> length >= huge page and free PTB bo, update mapping to alloc new PT bo.
> There is race bug that the freed entry bo maybe still on the pt_free
> list, reused when updating mapping and then freed, leave invalid PDE
> entry and cause GPU page fault.
>
> By setting the update to clear only one PDE entry or clear PTB, to
> avoid unmap to free PTE bo. This fixes the race bug and improve the
> unmap and map to GPU performance. Update mapping to huge page will
> still free the PTB bo.
>
> With this change, the vm->pt_freed list and work is not needed. Add
> WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to free the
> PTB.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 +++++++----------------
>   3 files changed, 13 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c9c48b782ec1..48b2c0b3b315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> -	INIT_LIST_HEAD(&vm->pt_freed);
> -	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   	INIT_KFIFO(vm->faults);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
> @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> -	flush_work(&vm->pt_free_work);
> -
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_put_task_info(vm->task_info);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 5d119ac26c4f..160889e5e64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -369,10 +369,6 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> -	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> -	struct list_head	pt_freed;
> -	struct work_struct	pt_free_work;
> -
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index f78a0434a48f..54ae0e9bc6d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> -void amdgpu_vm_pt_free_work(struct work_struct *work)
> -{
> -	struct amdgpu_vm_bo_base *entry, *next;
> -	struct amdgpu_vm *vm;
> -	LIST_HEAD(pt_freed);
> -
> -	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> -
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->pt_freed, &pt_freed);
> -	spin_unlock(&vm->status_lock);
> -
> -	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
> -	amdgpu_bo_reserve(vm->root.bo, true);
> -
> -	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> -		amdgpu_vm_pt_free(entry);
> -
> -	amdgpu_bo_unreserve(vm->root.bo);
> -}
> -
>   /**
>    * amdgpu_vm_pt_free_list - free PD/PT levels
>    *
> @@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	struct amdgpu_vm *vm = params->vm;
>   	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
>   
> -	if (unlocked) {
> -		spin_lock(&vm->status_lock);
> -		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
> -		spin_unlock(&vm->status_lock);
> -		schedule_work(&vm->pt_free_work);
> -		return;
> -	}
> +	/*
> +	 * unlocked unmap clear page table leaves, warning to free the page entry.
> +	 */
> +	WARN_ON(unlocked);
>   
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> @@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
> -		entry_end = ((uint64_t)mask + 1) << shift;
> +
> +		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> +			/*
> +			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
> +			 * only clear one entry. Next entry search again for PDE or PTE leave.
> +			 */
> +			entry_end = 1ULL << shift;
> +		else
> +			entry_end = ((uint64_t)mask + 1) << shift;

That here looks to much like a hack for my taste. entry_end basically 
denotes the end of the pages tables and not the updated region.

We already set frag_end to this here:

frag_end = max(frag_end, ALIGN(frag_start + 1, 1ULL << shift));

Which basically means that we should update just one entry at the time 
and then walk the page tables again.

The issue is just that we immediately calculate a new fragment after 
each update:

                         if (frag_start >= frag_end) {
                                 /* figure out the next fragment */
                                 amdgpu_vm_pte_fragment(params, 
frag_start, end,
                                                        flags, &frag, 
&frag_end);
                                 if (frag < shift)
                                         break;
                         }
And that looks like the place we need to adjust something to allow 
updates of the leave nodes.

Alternatively I wouldn't mind having a complete separate function for 
unlocked invalidations.

Regards,
Christian.


>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   

