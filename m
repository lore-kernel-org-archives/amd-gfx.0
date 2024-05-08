Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DCCC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 10:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3930910FAE6;
	Wed,  8 May 2024 10:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YufD0tDQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F9610FAE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 10:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI4ZcjhzcBq2Esq9I31pVn/MINxhFpk1tqnX4h6jeA4Q7fmJ5B0eJLe5kUO4/bXg/9XQIn1UB9aM/B57tmNZ/wSGwp9NSDt84KmHP9yYhYg6KQG73pyyzBgEuYRtIcYXt+Oa5voBd1QeRRf22zAfHo0di+QMuza91V9hsHyH5Wum0Uj4701meLmmwkmW3DbCtN2Swo6ddouChoQv4TGJNWCh0ZpW3zOfmSVsJQrOBxb0hbF7CuquZiOPwUcRW6wyC35QBu+a3ksZysSpfy+b9r3mnRQMYuNxgRowSAjymMZ5tjBzoyyVe0Tlxdpf8CsqAtLOJv2bV4avK29dZUaSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIcipkWKnqC1oxjODnlGjMSP5C9MyUE5IAnz0fqd0NQ=;
 b=Sj9DHnEt0Of7OsZ8IR2Df5euzvxLXFiPM1FSyMbOi8+eFQftsT7J70NCjUvh+n5a9T0C1dwt9zwNPdoCAHBsOB371kRb8B91Dt5oLO96wMJb4kC1cv65G5wKEdjjpEIB6mjQTM91navtBAJ0TB3tw3aGocZHr5aYi/x//ZiWhycAr6jByQTspHsb2Rm8sLE92NgHIhee2zf6YgD/dJKkW35Ow8HH8LDb/lT4FNYYz1Ki9qEwCN+8pM7WBX1h8o/+EzC//Bq6az+SNymIOClatmXf2yTq6n1rYnrTuc5kHUONk2qu6XSW5V7ZYvRhVNd6SK6t3kgRq3ZnWvMPMjouow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIcipkWKnqC1oxjODnlGjMSP5C9MyUE5IAnz0fqd0NQ=;
 b=YufD0tDQcz4gLp662Aj6goaRn+abEuZs13rcbVjWb3rhjfiV25A46t4V7HN3SC41NYiGUA8sKsjwY2bi4jFadGy6UZIiCNTkQS/GGNIYFHFD+pK3Nru/YtOTweAjPyYxa93yLVnpPOJevjKEnKkXxf5Ms161AVqJVUXQC76GLwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 10:56:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 10:56:41 +0000
Message-ID: <d0aafbac-63af-464a-85a8-68ecc56404c7@amd.com>
Date: Wed, 8 May 2024 12:56:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] problems with "fix visible VRAM handling during faults"
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Jeremy Day <jsday@noreason.ca>
Cc: amd-gfx@lists.freedesktop.org
References: <20240507123907.3a39163546b4643c5d834522@noreason.ca>
 <47c31c39-9ca0-46b6-93cd-e5c4c002fe23@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <47c31c39-9ca0-46b6-93cd-e5c4c002fe23@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8810a62f-0c52-4bdd-3229-08dc6f4d8a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDFQdEZscU5hUVJ2ZTFBREhLMVR3ZVo4ck9MQTJGV3ZkbVhSVzhGZXNWTVBa?=
 =?utf-8?B?TnpmUmRnVWQrUE1CTU9hbWZYUDdOZExrNlJJMjhtUnJSbEhyTVgwakp1RW1o?=
 =?utf-8?B?My9NRFhUZkVITFZSMXJ0OU4yZzkveDh5c25xcGJOcCtTUXFYNDhjSjBKQ1ho?=
 =?utf-8?B?SnM2blYvRXB0ZVUyZmpVSDlacjJqV3BneklYK1hkaDVoaG5ickhIOTR1SU5Z?=
 =?utf-8?B?Q2ljdlpqRDdtaFNrdEJsOC9obTlOMlZ1NExXSE1yaW5DSzBPdzR5NGFpdzRi?=
 =?utf-8?B?MlZtSy9NbTBaTEMzWHF4TlhPN2ZMYWVxZzNiYUk0OUlBNk5VbTg5VnN1NWJD?=
 =?utf-8?B?Ym5nd1JHK2lVWUZwNzFFZkVnRnRtOXBHRkNrUkpRZDFxbmYydytXSnhkZ1hN?=
 =?utf-8?B?czgyYjdYNEozMWN3Q1hPZHFLb1RKdGhqV0kzdVY4dms1ZU9NVFRhMlVNcEw5?=
 =?utf-8?B?bDFud3ZuQ2lGTmV1ZlBvUFpHazJrY240dUZBSS9NV2hXdmcveWpscWtuc01R?=
 =?utf-8?B?ZXlRQ2d0eVAxYndZQWxOV2pWeC93Zm13d1h5dEVUQVNBNE43ZEFNRDcwVjNq?=
 =?utf-8?B?NHpwQjZ6RHJwejU2Z0tUVFZYcGtaTjljb3Q4a25kYmVPQktDVzRvUld2R2Jr?=
 =?utf-8?B?M2w2eHN4ek56bjd5V2R5azRMSXNsdzh3NEFHSTFQMFdHT0U3b1NtaGdodlN3?=
 =?utf-8?B?Y0t0Q0ZnMlA0UTVZRUl0ckdUREt1RWRSaDNkYUEwU3owTmxhZ0lxZUpZRmtR?=
 =?utf-8?B?VHowWG14TmdlLzdGdWcwL2VyOUp2WFo1RXRRYzEvMkluMG8xTnNNcWY0VTkv?=
 =?utf-8?B?aXpHUHJMR0lUMUpjTWhtRCtOZmtCQ2ZTNU1JNkQ5SHBBL0ZYTHZvdEZkSDVa?=
 =?utf-8?B?QnFmT0dzZGYyMnNuaFBFd0ZKV2lPOGNZa0hhZmJxd2xEMHFiOXJIVUgwVHVQ?=
 =?utf-8?B?NkNaL1Y0NHFIdFhQcm1zeVhXT042VHVvNmhRRTBHWkE1bkVDc3FVRHMxLzlF?=
 =?utf-8?B?YjFZSGFURHdodmdkb0ZyZ2VsTEJNNmRPQVB2aHlJYmpIemlwR0lFenhSbGJJ?=
 =?utf-8?B?VXNScHNxSm1RWHo1eWhoTm1KQ1VoRG5oNVk5QkF0Mm50SDVVaVpjUTNGcmhv?=
 =?utf-8?B?TU13ZVAvNWpYY2ZmYjJDeXlMa0FKT3MxV0dKSHU2bGdZTmpaNUhFUzU1aFdv?=
 =?utf-8?B?WDVqVDJNWC8wR0VMbkJkcUZpV0dBem1QSlJadGxnbmZtWTM1NUVmWEZyTnVo?=
 =?utf-8?B?Q0xEeDFRenBxT1JaK2N2OXJ4Mk1DMGFXYURyRW9MdkZreUVaTTBvQWlSRnZp?=
 =?utf-8?B?Qmw3RFVsTFkzVHlmVWJoN2xvNnh3UXU4cHdEb2pOMFB3eGdHMTBhNlp0RTY3?=
 =?utf-8?B?cTgxZGNDZWZ0Z3V6eHhrS0wyV2RDZ3cxbUlSWWxFYnM0NngzOTFmZG9sUHVh?=
 =?utf-8?B?NTlBM2FzUGdpV3hpOVlLNWlpSUV6OXNPU0U2b05xajhLQVhWWnhucUV0UmNP?=
 =?utf-8?B?b2gwY0txT21tYlJqTTlCR3lhb0psT3RlejhMV09HYXp5WFQvdGxkSUhUenpR?=
 =?utf-8?B?M25mc3JIQUJNcExHM3VKSmlVcXRyb1U0NTdZZWZGQjZWanYrK1BNV2ZJeEg1?=
 =?utf-8?B?bzFWUC8weUdKQlcwTlJKK0FWcmJHMk5QT0owMG9ta1hNYnV6SFlCMzd6U05Y?=
 =?utf-8?B?SGhhT1ZzVXhrNWlXcTRZN2UrdmllaDBlbFFqMlZrQUhhNS93YTFxZnl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFHcVlYb3hHUG1oTG9BMnljbGxhRVhFclREMGdpWDM2UC90RUVvdEJRUmgz?=
 =?utf-8?B?QVJldXZHMWNtUnZYQnhoeFltT1FHb1Q4LzNDY2RHTjlqUkZESnpDUCtPVzVY?=
 =?utf-8?B?M2NlRHU3YXcyR290NERIWlVKb3FmaitDTjAwSmlwUy90YVg2Z3MxdkRpbmlD?=
 =?utf-8?B?RndZQ0EzL3BzK2JrbGlISDlhbm1jTHliM2VIdWhpMzczZ1VVTkJzS2NOVFpx?=
 =?utf-8?B?MXErelhTNERKOXk1VFVvSzY3UXlEOWZadXZzVkQyYTk5dWJ4Y1VrMzVhR2Y2?=
 =?utf-8?B?K0RUQndMWmpDNnR3bEhzRGlBS0Iyc3F3N1Z2aDZ1WU8wczcwMWJzakU3KzZI?=
 =?utf-8?B?d3hWS29UK0I3STlnaHBNZ3d6dGlSWDR4bkVYdUJ3Vzdaa0QxRWdtcEtjdDlr?=
 =?utf-8?B?M0s1Sy9TcFB3eEx3djJtcVFuaFdQTE9laWRmYVhqV1hBQUduVU8ycFZlU2hK?=
 =?utf-8?B?SUFYUUVMZTB0aVp4N0NncHZNci81RVhETzRzVTA0OHBHZnpHOWdPZkQ3V0w5?=
 =?utf-8?B?dlZLcldOMVcrb2lsRDZMeGhpSDdIY3lWVXVyZmNxYWFpN0xqa3NSbDVtL3Jt?=
 =?utf-8?B?cXJweUltNUdabnZZekt6MDRJa2t0UWU3bVh3NHIxL24yYkJVNXpqQnhaMno0?=
 =?utf-8?B?Y3d4YXJvbnNJY0tBZ1FrNEZqUS96a2VZVnlmc1R2WGlZK1FoNHQwNy9VdHdG?=
 =?utf-8?B?RngrMXBXYUwwYklXOWwwdEdtNmhVUXVoc2FVYWZBUU5ITkNXaUlZYytiOFpi?=
 =?utf-8?B?VHVrNFVRdE5veWMvMVdnbFhzeHk3ZXZVN2d2dHd0bmtBN3hmVDZ1bDRJYThh?=
 =?utf-8?B?UG5uQWFmQ09Td0JyYmRacGQvZ3crcVNYelBneit0N1VQVlBmSXhNaVdnSzcr?=
 =?utf-8?B?TWNCN2xpZnBCZWVWdXJ5N2pObllZallBWC9WRmRUVlllSTY5TUx3bVpBU05I?=
 =?utf-8?B?UUdWRTdMVm1BMTdIb1dER1hadDNIUkZpOW9JRGR3QkdXYy8zOEJDY2hKbWlK?=
 =?utf-8?B?ejVRcUg3VitUMkNwMTJGM3RhWnN4VFl0OWZZMmJaeEVKck82QnFTWHlyR2F6?=
 =?utf-8?B?bzFvVWhVcjA3RjN4dTlteHErazM1UEM1TU9nVHBGTGlXUlBKdC81djhUSFRr?=
 =?utf-8?B?K3VaaW1ZUU5ZeUxzTkVlalY3SXE0emNjQkoyc1hxZzExYzBDVkRBSURGblRy?=
 =?utf-8?B?cWQwenNDQU1wTDgxOEk5cGpURnI3Z2dWdzJRU0RIZ1FjZTBiRFpFUEFwbFpq?=
 =?utf-8?B?KzQxZzBIMnRsS2F1WDgzWjJSbC91eWhkVmVtSHk5TVZOaFNBMkN1TlZKNmNF?=
 =?utf-8?B?TmdCV1YvRW5aMXN6Sm9GU0YrOUk0OTVUZWpRbHVNZTRhNmhSbEFkczlpM1Fa?=
 =?utf-8?B?dlk0dXhNRWhlUHhvdjNFYlY3Q1hRSkpndnJON213ZnJTdVZRaFAxK1hjNG9r?=
 =?utf-8?B?TEl0dXd4MmNIQnVzZk16Um9meWlMRytBTlJXdzFSUWdDUDR2bG1VR2JXSWxV?=
 =?utf-8?B?TW1Qc3F5SU9NN2JRU0ZOMU8wV3BRSWRaZ2NtREpFdE54L3JIdzdMbFI2L0Vm?=
 =?utf-8?B?d1FVWHljeE9iK0FSN1RlbkRyVUt0ejJUNWdoN0dqcDRNeFNkZWNpd1dFblIw?=
 =?utf-8?B?emlmTnVkQmNrRHBKRFNQZnhBMUdEMDN4OVNFR0lDbXFBQnF3RzVLaVYrS1Av?=
 =?utf-8?B?QlZ3VHoxTzF2SzJVNm9BT0FqWUFER2dab1V1RGVlVVlOdUNnQXdoVWYzNjZK?=
 =?utf-8?B?bzJibjR6SEJ3am94bWFSenhvNWRYNUtSQ3ZvWi9MT2E5OGZmeTltWkRrc01F?=
 =?utf-8?B?eGE3OTFSL2tRVU9PWkxjQm1reWtoWEkzcFVBcmFvV2hSOUJjL1duRHBhMS9T?=
 =?utf-8?B?OGdpMU5ka0hTNHlDRFpLcVUvOWtGanpUTmZoR21xZEpDMGhEODY0b2JYQlVN?=
 =?utf-8?B?eFBJRDd4R3BRY2FzMjVTSzlkRjNjY05GZzJKRjZ0ZWM4VGdKbzdBSHk4L3Jv?=
 =?utf-8?B?YjFKallMdS8rVkpvTFJtSkFwYmVjWHgrZ0xPUFJzMmhTeTN4T0x4eG1KRmVH?=
 =?utf-8?B?UXk5MTk4KzJIUCtBcUFZTTEvUW9Ua2l3MFExZi9IZkF1QVFmaTZ1b1JDTk53?=
 =?utf-8?Q?gQtWNeCuhAnK3jGggRH/9yrUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8810a62f-0c52-4bdd-3229-08dc6f4d8a88
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 10:56:40.9871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihtnrxylXHTOMf1OxQh0htcDmfx7ARJeQTcKAfzMes4K/X+AUw8PhGLvJGVN70v1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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

Am 08.05.24 um 12:17 schrieb Michel Dänzer:
> On 2024-05-07 18:39, Jeremy Day wrote:
>> This is just to report that I've had usually well-behaved applications
>> sometimes having problems with memory access violations since kernel
>> version 6.9-rc5.  This past weekend I stumbled across a way to reliably
>> reproduce the problem in the form of a Skyrim save file which causes a
>> crash shortly after loading the game on affected kernels.
>>
>> Things go back to running smoothly only if I revert one of the changes
>> in 5th April's "[PATCH] drm/amdgpu: fix visible VRAM handling during
>> faults" as follows.
>>
>> Patch is against v6.9-rc7.  It restores the check for partially
>> visible-to-cpu memory in amdgpu_bo_fault_reserve_notify.  Things
>> seem stable again with this change.
> Does this instead of your patch help by any chance?
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 109fe557a02b..29c197c00018 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -427,7 +427,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>
>          amdgpu_res_first(res, 0, res->size, &cursor);
>          while (cursor.remaining) {
> -               if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
> +               if ((cursor.start + cursor.size) > adev->gmc.visible_vram_size)

Oh, good catch. Yes that might be it.

Thanks a lot,
Christian.

>                          return false;
>                  amdgpu_res_next(&cursor, cursor.size);
>          }
>
>

