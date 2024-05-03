Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B75C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 08:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD44710F915;
	Fri,  3 May 2024 08:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="if9DQbmp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56C610F915
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 08:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEKB1yNUzPCC97ZaXiWxwaVbcQzc27DnqQup7v6suNKR7whti2bwvtZT2LcznIOnBOhjseyEs5LSFTmNsNLPH1hqdh9AGGirtdMpIjg0DGbfCUosGIjebM0+HTl4Gw1C/LrNtaW0ixS7cQ4torx3xkJAOr3tEV+/y+ijQJ6E7pHM1VnEEyvXWrBUj8y5cqD21Fb1BM8mzsEiQpZtyq9ZUgHPUPHvEhiD+FJnFmN0ZO2serA1y7Tyzay3aV2cx5I4AL2N0rMPv59PyFrNhY8ntBvR/1JalmChAmpVdPBn2YngFWkK14OOckmEhlY+aTrEo7/eKtfSflF4AmLIFeUqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEsu4zSShurcPlrKJbXQUITtWW8MiTwM5Pnhbk8jRpc=;
 b=JNPZBAxuRz4nKaJyKdpm+xm8+WkZ0CQ2+4MIXPgvBLpi1T9C14DIERpzgYdxRRpMqZqmCuGk8ProLt7IsQEwls3yT0tpgj6aTUDZXSOTwh+4Vg/A8p4Yp4Al0nPKufmNPfFv9oyL0Q6Ag/QIOrlenXPgd19VIXAQgoYLXYhGmE49Hasd9J0aeuDvACRKVbRAt0lPVbKobtK1B7k4MEK/HoFfiH3+1FED/+c9zeJSYwmEyaEzf733PCnSv/w9pf3OGW3eJVnA/2D0z8bEZ7in3xItoQE9VRXko/AnWDSffduGmaMrjvp8DZTu4vEbT477fFSnFB06uEWqIPsdp4Ev+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEsu4zSShurcPlrKJbXQUITtWW8MiTwM5Pnhbk8jRpc=;
 b=if9DQbmpkB0rhLiEu18+6U5Pz/Uia7SGLfcJg3MqgugtpU+Jo/Z7MiN7RT3Pj41qqYgJxqC4VnosQ25xP7FzX2RsBfarTdlVtTc+3XyYcUagbDYiq+B5KjK4uQzcAR0qb6XZ4oUh/1XY30d4iS9g37kir9OEsCrXT2ttzNr8bNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 08:27:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 08:27:59 +0000
Message-ID: <559bd553-7f5d-4fe9-bac7-07d3010b0ff4@amd.com>
Date: Fri, 3 May 2024 10:27:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240429164707.49196-1-tursulin@igalia.com>
 <bcbd2c3f-30c2-4e98-93d6-b752ae3a0a0f@gmail.com>
 <9ee3e832-8310-4626-96e2-5653b7fe8ea9@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9ee3e832-8310-4626-96e2-5653b7fe8ea9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da2338e-ddb9-455f-e4f0-08dc6b4af0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2dtRnhDZFV4OWptQXA2WS9XdXBic1FlYW40T3lFbFNPVlpHTHIwQ1hTRUJM?=
 =?utf-8?B?elpZNG1Oa0VFWXp5NU1CZjFRRGhBbXQvL0dWSGFjTlNzeVVwWmJsTDBtaU5j?=
 =?utf-8?B?cGNFZ2Y2ZE03dTRmeStVWEdqUTgyaExxUS9EVVI3MXR1ZnNXNFhadEpxMEpj?=
 =?utf-8?B?a3dSRjdoQXlMbkk1c1JZOXV5SkFjL0xWQ1JXYzg5dnYyZVBUV2RURnphdllR?=
 =?utf-8?B?SmY1SDZqeEpPTk1pMVoxZTJOa0p1MGxTU0k3Ulg0Z3RyeENrSXd3ZUhVNGRn?=
 =?utf-8?B?MVVvdnRBa21SeGtBUzdteENKOWVLUm9PaWtDcENuZXlJZEtyam9KUkFYSzR0?=
 =?utf-8?B?RXRGZEgvQ1JLMzhRNVVvaE03c1lPN1JiM3lhZWpzbk05NFF5RXBrNHZ1alZu?=
 =?utf-8?B?UEFSL0QwMTg5NGZEMXEwYkp5dUFGRndjMlZrbjQvc1pYak93TGRuYllOdmlh?=
 =?utf-8?B?NmNZRDVaVU9xcWF0RmpyWjJRWjFKZ3BjdWhlamZndFU5Q1NjSXVha09sZW81?=
 =?utf-8?B?YUVMYU9nVVA3VGRaWVpYcCsrM1VOcCtMWVRReC8vMVRmTGhCVkFhNmdJKzRj?=
 =?utf-8?B?VytPZUVzd1Jiand1Y3VBQk1ZUWIzblhtdW9PNFdmRlhvaDJKdmlqZG0zZGRN?=
 =?utf-8?B?ZVNscmlvMVBnYnNDT09WMVg3NXUyOWJvUlFvelJvdkFZNHpCWU5LR1ZGMkE0?=
 =?utf-8?B?dVNGYVdUaWlFeWpWRVF4Q1VkVUcrak12bHpKN0ZuM2p2OC8vSnV4K3FVNm9B?=
 =?utf-8?B?dWtwTzVjUEF1S0ZYZ1BqeEdzUjd3SHFDQ1ZxcG9qWlFydUEvTHVQMm45Z082?=
 =?utf-8?B?U1N2S1BMQ1diSkx1anJncE9jVlBNQ3JHUEdjR1JIQzg0WkJ6T3hLeWtPb01t?=
 =?utf-8?B?SGthd2ZkS0poQ0NIQmVlOEo4RzA3VmRWTXdiWURRU3lxUEpiWnQ5clFld1dW?=
 =?utf-8?B?clVGU2lxVlUzV1hNMXRIeGVPS1NnWFVGTWM1QWVBQWZZTE82TjBHM21INzZa?=
 =?utf-8?B?RUtpSmlZbmIwcjVMaUNxMjFUdFg4cFpmaVV2aEFDUjhBUE5wV0NLUFpKK1Jn?=
 =?utf-8?B?dnJSZS9KczZnRjBlRWNoYkY3bWtGb1hqTk9oanBpcFpSNk1UeFRFZHMxSG1V?=
 =?utf-8?B?MTFNR2tIZFhzUitvdlhkWXo1U1czNGprZmZ3Y0pncDhJL25BZWhTakN0UlVG?=
 =?utf-8?B?dVV3WnBkaVV4cXdzS05sSmRNYU9ta29ZSzlrUlpSZ2J1bWRkZUV6bGJvWXpl?=
 =?utf-8?B?TXNvN0s4YTNDMi9vRWdRK3E1QllsY3dJd3NabElVRUZPRVVSRGNxN1MwMElX?=
 =?utf-8?B?MXZSQ091Z3doK3J0UFhnQlhIcEpZZ2kzeGNIUFdsMllYUHNadUgwejROenlO?=
 =?utf-8?B?RXl6S1AvdGZmVVNxUi93bmE3anVseEFUUiswR0tjR2luOFpGS0MvM2drYTli?=
 =?utf-8?B?WVVBbzFicUFVOEp4b2JzV1JKMXhaRWl5ckIwaWI2L3A5cmtxek81Ui9BR25k?=
 =?utf-8?B?Mjd3VVl2MXUxWWZDMnJ5UlU1c2lpMVd2MjZkdjJPS0lvcE4xcHdISHRtUnQv?=
 =?utf-8?B?U05kZzNTem5RSFBjMVdhVlU2bHppY0N2VTJ1YTczSC9tbXkzbWRZZHhPNEYv?=
 =?utf-8?B?MG4rQmhPTHA4VUhMMDVzczhqcWQ4U09UT0VwYWpxN25tMHVFWkNCU2ozQnlQ?=
 =?utf-8?B?MUo1eGQ2K3hiakVKQ1dvYWsxblZLT0hMTzFBTDFtdFZqeThmOFlJaDlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay94czExa3RzeUxQZTNYMU45RHlRbmJZRGxtZFpoL0xnaTFBQkpPSmR0dVBj?=
 =?utf-8?B?ZVJWbk1YbFJRbXliK0pHN3FDUXhNMnYrZkl0RitwTEsrZk1ZT2ZsdkR3YzVG?=
 =?utf-8?B?Y2tIMzhRZEdSeEVTNmZxZ1h5dWx6dStsZWlLR2xoSGZ1S1MxQjRtS1dULzZZ?=
 =?utf-8?B?M3VkekNwTTVJdks5UEU3WUdtNUcvYVc1aklXZUxVSG91R1F2bng3VHB0cGx3?=
 =?utf-8?B?SU4zUjJiRXltbjNnR0M5SEpuYzhlQUxLRlVETm01VlNZcU9tWUxaY3pncFVS?=
 =?utf-8?B?bVFOTzlsaFE3S0N4NnlXL2tpaS9NK0tvTlQyM3IvQ21wZS85bFQ1aTd2UWdt?=
 =?utf-8?B?V2xFTkZzd1dFb2Y4Nk9wR3l5czV0Rkd6Smo2TU5BZ056Z3gzY1ROalFYZGlk?=
 =?utf-8?B?aVVrNlpUQWFkZ0NaNnNHVmI1ZEI1alFWcmZPTWE3QkF2bVlDSEhzdGtBL2JG?=
 =?utf-8?B?bnJua2gycjdhNlhsZjN4NUJPOGI5cVozeXUrV2ZFdm9XUEt5Y2VpME5YR2Vk?=
 =?utf-8?B?cHFHTTJ1QU1ia1pkZXRucFd0UjhRNHhVTWUwc1A0SFFveEkwQ0FpQ0d1Q29X?=
 =?utf-8?B?U3d2QXBHU2Z4VXVIYnFvZDNTYnZWT2dVem9hM0c0VjMwY0tnMjB3S21EbHQr?=
 =?utf-8?B?QjljVlNlNnlCR2hXdC9wSTArcUZxMjF2SnRpK053Tk02TjU1V2I2bTB4S1Vo?=
 =?utf-8?B?a01YTXMwbjZSWXVaUVQxbkpJUU1peHczZGRSVU9va2pJemxucVhQYzRLVWJQ?=
 =?utf-8?B?SGNtYlJ3ZVJwS3hkcDE1eFk1bkpwc0NTd2ZUSjMyUTB0OStVTjRTOUpCbks1?=
 =?utf-8?B?dUZCMzhKL1M1SklpV2hkOFBndExzTjc4dnBxekJkZWM3NnFEc3Zuc0lpSkx4?=
 =?utf-8?B?RWNJRGpoZnlxRU5sdDIrcmRKZC8xcGJOSjRiQ0lhTDBFUi9SUklvbzV1Nm4v?=
 =?utf-8?B?bzBLUDFTUE1ieU1lL0t3MzlOYkNONTBnb00razVualExYXR1QS9VZDNodE1K?=
 =?utf-8?B?bFM4bklKTFpUSHozOWw2c1VrM2RWQlZkbDlvZVZxUTVJUGNITm0yV09RWDZM?=
 =?utf-8?B?S2h0Zy9CNmpFc3lEYk5RN1c5Y3BGeGhnaWxHbXl6WStBc1d4VU1nNXA2amFx?=
 =?utf-8?B?YUZlYzJSZEFDTkp2QmtXN2Zxci85aTNiQkd6TG9kbmZJSVJQa2Nubnk5dXJt?=
 =?utf-8?B?dHZXOFFUNlhVdHlud3RQaUlQTytITzFsaENRdm94WTZQM0NOcEZzOTJKNGxk?=
 =?utf-8?B?U01PcXBTdU1kQzJteVBWU1c5cUdYK1F4cm44Q3dDRTRtZFdrTGYrTlZWMDZn?=
 =?utf-8?B?bk83TXl0bkZnczAzRkdxWk1HVUNZNlZpaXh0MHk2bFF0QWdmUG9iK0RCYXkw?=
 =?utf-8?B?TkVCMjFvNXA0SFk0ajJzVkJxNXBiam9Ebno5cjVWSExBK2pmWGJ2dlB3QUht?=
 =?utf-8?B?VVVOOUE5T2ZWTnl1amVUY0NTZkppdjVsbGF3NlV4ZGxmYWxua0xjL3VTM2Fs?=
 =?utf-8?B?SzJqTTFBUDNyTENVdXRLVFFyOEhkSjc1M0NWdHBDb0ZlNkRqcDRSdm1wY0xv?=
 =?utf-8?B?TUNveFYyWTMyRHJNaFRNcjZsTXdCQUo4WVlxNm5iRFc2T2lIem1NdHdyUldF?=
 =?utf-8?B?UmJ0WVYrUllOREZXOEw2dHZOdW9tNXhOMHFnZ3hqb1lPNUE3NHJTMDkzZDJR?=
 =?utf-8?B?RUttNE00bE1IWk1hZUxaZUFpSElUQkl5R3VRcjRPQjJYN0RWbHg3OXZreDZE?=
 =?utf-8?B?OW9GTkV5bFI3czk5L2kvdU90VGZxSTRuMC9lcGxJdHBETTFBZ2pxNWx2ZmJP?=
 =?utf-8?B?aGRQd3h6c1BIVjd4eDVIbkwrNjk5ZmJ6QUh2T0xXQ2dOUnRiUmRCN29xdWdF?=
 =?utf-8?B?d1dENkdLZHhIRUFwRjBzSWxxZ2pXVWM3bVR3WmJqWjBWTGwyNTZNSFpkSGZL?=
 =?utf-8?B?V2ROd0dLSXF1Q21iNVVuWVFFL0xlV011MWNUTUQrdTNVZ2c0ZTZYcHN1MVA0?=
 =?utf-8?B?YTZSN3Q4V2RjdWlvVmVJMkxaNHRIbGd0ak9EUGlLQVFjRW5SYWF5S1FzeEZr?=
 =?utf-8?B?RTlMOWZOSCs4RDA2STJPS2UvZnA0RlNOZGJIZW1POWRhQ1ozSVVubmdlem9J?=
 =?utf-8?Q?jWxX1lDcSRGD1zbfGRe8tSLPf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da2338e-ddb9-455f-e4f0-08dc6b4af0ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:27:59.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xazrS4TS8Cw8v059taaEEX/7nKRtGiHnCtotiFL2G8jXN3UPm35djW+XPCndewr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

Am 03.05.24 um 10:23 schrieb Tvrtko Ursulin:
>
> On 03/05/2024 07:26, Christian König wrote:
>> Am 29.04.24 um 18:47 schrieb Tvrtko Ursulin:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> Help code readability by replacing a bunch of:
>>>
>>> bo->tbo.base.resv == vm->root.bo->tbo.base.resv
>>>
>>> With:
>>>
>>> amdgpu_vm_is_bo_always_valid(vm, bo)
>>>
>>> No functional changes.
>>>
>>> v2:
>>>   * Rename helper and move to amdgpu_vm. (Christian)
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 
>>> +++++++++++++++----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>>>   3 files changed, 28 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 67c234bcf89f..e698d65e9508 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct 
>>> drm_gem_object *obj,
>>>           return -EPERM;
>>>       if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
>>> -        abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>> +        !amdgpu_vm_is_bo_always_valid(vm, abo))
>>>           return -EPERM;
>>>       r = amdgpu_bo_reserve(abo, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 8af3f0fd3073..01ca4b35b369 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct 
>>> amdgpu_vm_bo_base *base,
>>>       base->next = bo->vm_bo;
>>>       bo->vm_bo = base;
>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>>           return;
>>>       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> @@ -1101,13 +1101,13 @@ static void amdgpu_vm_bo_get_memory(struct 
>>> amdgpu_bo_va *bo_va,
>>>        * For now ignore BOs which are currently locked and potentially
>>>        * changing their location.
>>>        */
>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
>>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>>           !dma_resv_trylock(bo->tbo.base.resv))
>>>           return;
>>>       amdgpu_bo_get_memory(bo, stats);
>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>> -        dma_resv_unlock(bo->tbo.base.resv);
>>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>> +        dma_resv_unlock(bo->tbo.base.resv);
>>>   }
>>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>> @@ -1203,8 +1203,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>           uncached = false;
>>>       }
>>> -    if (clear || (bo && bo->tbo.base.resv ==
>>> -              vm->root.bo->tbo.base.resv))
>>> +    if (clear || amdgpu_vm_is_bo_always_valid(vm, bo))
>>>           last_update = &vm->last_update;
>>>       else
>>>           last_update = &bo_va->last_pt_update;
>>> @@ -1246,7 +1245,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>        * the evicted list so that it gets validated again on the
>>>        * next command submission.
>>>        */
>>> -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
>>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
>>>           uint32_t mem_type = bo->tbo.resource->mem_type;
>>>           if (!(bo->preferred_domains &
>>> @@ -1640,10 +1639,9 @@ static void amdgpu_vm_bo_insert_map(struct 
>>> amdgpu_device *adev,
>>>       if (mapping->flags & AMDGPU_PTE_PRT)
>>>           amdgpu_vm_prt_get(adev);
>>> -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>> -        !bo_va->base.moved) {
>>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>>           amdgpu_vm_bo_moved(&bo_va->base);
>>> -    }
>>> +
>>>       trace_amdgpu_vm_bo_map(bo_va, mapping);
>>>   }
>>> @@ -1922,7 +1920,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>> amdgpu_device *adev,
>>>           if (before->flags & AMDGPU_PTE_PRT)
>>>               amdgpu_vm_prt_get(adev);
>>> -        if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>>               !before->bo_va->base.moved)
>>> amdgpu_vm_bo_moved(&before->bo_va->base);
>>>       } else {
>>> @@ -1937,7 +1935,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>> amdgpu_device *adev,
>>>           if (after->flags & AMDGPU_PTE_PRT)
>>>               amdgpu_vm_prt_get(adev);
>>> -        if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>>               !after->bo_va->base.moved)
>>> amdgpu_vm_bo_moved(&after->bo_va->base);
>>>       } else {
>>> @@ -2017,7 +2015,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>>       if (bo) {
>>>           dma_resv_assert_held(bo->tbo.base.resv);
>>> -        if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>>               ttm_bo_set_bulk_move(&bo->tbo, NULL);
>>>           for (base = &bo_va->base.bo->vm_bo; *base;
>>> @@ -2111,7 +2109,7 @@ void amdgpu_vm_bo_invalidate(struct 
>>> amdgpu_device *adev,
>>>       for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>>           struct amdgpu_vm *vm = bo_base->vm;
>>> -        if (evicted && bo->tbo.base.resv == 
>>> vm->root.bo->tbo.base.resv) {
>>> +        if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
>>>               amdgpu_vm_bo_evicted(bo_base);
>>>               continue;
>>>           }
>>> @@ -2122,7 +2120,7 @@ void amdgpu_vm_bo_invalidate(struct 
>>> amdgpu_device *adev,
>>>           if (bo->tbo.type == ttm_bo_type_kernel)
>>>               amdgpu_vm_bo_relocated(bo_base);
>>> -        else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>> +        else if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>>               amdgpu_vm_bo_moved(bo_base);
>>>           else
>>>               amdgpu_vm_bo_invalidated(bo_base);
>>> @@ -2986,3 +2984,15 @@ void amdgpu_vm_update_fault_cache(struct 
>>> amdgpu_device *adev,
>>>       xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>>   }
>>> +/**
>>> + * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>>> + *
>>> + * @vm: VM to test against.
>>> + * @abo: BO to be tested.
>>> + *
>>> + * Returns true if the BO is VM always valid.
>>
>> Maybe improve that a bit, e.g. something like this:
>>
>> "Returns true if the BO shares the dma_resv object with the root PD 
>> and is always guaranteed to be valid inside the VM."
>
> I am only unsure if the dma_resv and root PD are too much of an 
> implementation details? Or really something the API user must know? 

Yeah that's exactly the reason why I wanted to add this note.

It is an implementation detail, but everybody working on the kernel code 
needs to keep that in the back of their minds.

Background is that sharing the dma_resv object has some consequences on 
synchronization for example you can't ignore.

> Considering from the uapi we have this:
>
> /* Flag that BO is always valid in this VM */
> #define AMDGPU_GEM_CREATE_VM_ALWAYS_VALID    (1 << 6)
>
> Which is the reason I thought to keep the comment high level.

It shouldn't matter for the UAPI, but we just need to keep it in mind 
inside the kernel.

Regards,
Christian.

>
> Give me a final verdict and I can change it accordingly.
>
> Regards,
>
> Tvrtko
>
>> With that done the patch is Reviewed-by: Christian König 
>> <christian.koenig@amd.com>
>>
>> Thanks,
>> Christian.
>>
>>> + */
>>> +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct 
>>> amdgpu_bo *bo)
>>> +{
>>> +    return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 54d7da396de0..ec688a47dec1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -561,6 +561,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm 
>>> *vm, struct seq_file *m);
>>>   int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm);
>>> +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct 
>>> amdgpu_bo *bo);
>>> +
>>>   /**
>>>    * amdgpu_vm_tlb_seq - return tlb flush sequence number
>>>    * @vm: the amdgpu_vm structure to query
>>

