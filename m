Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E4CC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 19:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E111910E2DB;
	Wed,  3 Jan 2024 19:13:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FD710E2DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 19:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtGyl8sWDDtpMYGyyNPWCJ7CMIwTBpdL6mG2ewGgZUdAnVFg4tUAOFUrprl+mtRrueYmm7UvGhqiLjO1gtqevkay+StIxUMe4ZWcODs4Ezew/BLLhk7Vs3P4Q3hSw3fsPm9pDKSj60NitT/G9e3KhVB+BqaK16KYf4WEVPjm4tEs/WkUQL1XLmJQtqw7xsuE6PGgyhHbU12E2M8WtKUwysxeOclRnJkAZOh5d2JNtcOx7TyxXA6GxlMXzcEhVfYA70A1NiZBvAGtzN/UsSmay3RAthZLQyfoxiS4Cr8cpDbYQJfx7nxv0VIijIv+whpKBTRyja8+GlN4k5kJLGi9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbveQhnsD+ofOIwgk8z/L0DBfxxlrysxaCdmGCByBBc=;
 b=N7ufESPSz+jzSRSewhWZtPcDM0KktSPUjjzHDqfeGGMg51Lo9zh/TMFqM5zjvcnUyOP7WCPPdaq+LciTNpFrjnAMnlThi092fBPL+iln3SgA9JT8X/iCo4vpDBV8b3MoC3k+yQuDttjhpcCi6ouJbE1Nd+nqZ7RV/xezG6Si81sfZHohSMExBNVCT7cyjgQ3UUjlyG/HXHIgnW45fqCrWgO9RCQ9+j+MwvOhzzy2VmcLIkF6Bg8R6zRFWh8d5275X3UGW+DshyyukATLs7SkitjXRo+JtA5472JW55IaV3Uj+ftAvFPFUr7SmxcRczLqlB9z1g0GgDRTg9NsUwO/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbveQhnsD+ofOIwgk8z/L0DBfxxlrysxaCdmGCByBBc=;
 b=zdb9V7AXDdbDbRyZG38mRfLVsHP6vqyf+jANCT94K2ARItnmmL9rZ8Q6Kfu/INQfaiWSOmEeL79Jnor2nh9/Rv2cOz+fMmp1WKl09nPktNYu2eKGmHDHW3fSqteA4TfC8sCW02HZs3ysarkTRhfBVx7pE4yxrTDWYFNmhrz+aLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Wed, 3 Jan
 2024 19:13:35 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:13:35 +0000
Message-ID: <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
Date: Wed, 3 Jan 2024 13:13:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:d3::27) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|CH2PR12MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: db6329ff-888a-420b-5124-08dc0c90155a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faByUtxfxv4iaq7KX27GGrvm7tClauBrjuReOW/4XlYAlqz4tG0hjMBf6NXZDov0sB+x+JuUrEGUBiytrqX5JHBEoKMvRPYwswgdLJW/IFV31UluktCoP629ayyZ8puVE2FHWFTkRBDTceNTrEgA91ijCA9PSSfEVVZpLJG8KucrDv5VbgVlypgOcdhX604lRudAOqbSn8iyU2Fio9CUyz4epR6hMYR68ZMLmeCoLpATGZS+ruXclmu3+Uv9j0mX1wcDMFhx3xRzIESkZ9pN3tYtlHTVnjhoFbOHtId0ll9Sx0ohegYI/QmXmvE5djuIyKYb7J4x/8BuTZJKypCtIqzgImoS6ObPuKS1ZbY4JWQBC/8WVW1QWPvQO20O2MEofFpk0Ik6T2YyexyCpNiVFc6mqzi8mAZQ7D0261qXQaHX6diQ9ek2lo1kc1XN8xtK3fD3t3Tef7jI/hU04jsn9yyUyJGD43icvhZKiN1X2INzzlA6q3yLodbTnS9YyseawEuj3cLoKroG4i1owx5Waa5UptgxmgrFpte0wEFywl3RXFFNtKlQcuHnWsJnNIBCQTebeB20skcpw2dk3JvkIP0as8cUTnsPiQQUAu8N9dY1S5NUG7SHwgh34K5L127DfdnC+XFY0q7CsRt3K1leLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(38100700002)(44832011)(5660300002)(36756003)(26005)(6486002)(66574015)(478600001)(2616005)(66946007)(66556008)(66476007)(83380400001)(41300700001)(31686004)(6512007)(6506007)(6666004)(86362001)(8676002)(8936002)(4326008)(31696002)(110136005)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0plSzA1VGN6UTREUFlDcWxpaGo5bzQ3UWRBMWFmY284SGV5Ym5FSFo5bi94?=
 =?utf-8?B?MDhuUGZEMXdaVTJSKzgzL2FDTTVibFNXQWZaNWFCYTh2MzFIWXdMTDY1K1JE?=
 =?utf-8?B?Y21JNksyN0gyOEp5M2R0Z0ZYYnRSN09hQ00vNk1zWDBLN1ZNUlJya0o3WmhE?=
 =?utf-8?B?OEJ0cWdZSERzeTNkbVJ3SWVzWjBMTjU3cmM4SlFIdDY5dW5FRy9nbCtLUVRv?=
 =?utf-8?B?ZlZrWDkrdExDNWRiS09FS3lSNklxSGJMTjhkMk45T2ZtVXZvOXNZZFQ3S2Jv?=
 =?utf-8?B?M3k0dENBVGsvWEdZYVFkd1h3OUE1OGhyUlZ3WHpsaVlrOXhheDhWWHZlTnQy?=
 =?utf-8?B?RnRWNlVwNzZBWWRGZlRPblBUbjFkY1NuT1kyaGFQTmtXM3JTMmIyYWp5TjNS?=
 =?utf-8?B?Qkc3RDdMYzdZVFVKaVBtTWlBaUlQaGwyaFNMRmN4c09OU3JqSmZqMm5XQ2xR?=
 =?utf-8?B?cVd3TVdqbE94YmRoNy9RQjNWTzA5VGhhamVqTUhlalRZMXlHUEZscVVLL2Za?=
 =?utf-8?B?L2ZSbGNha1E5VDVOcjNLNnRpQVlRK2I3RGswWHNwcUZacGRla0p2Z3ZzUmxD?=
 =?utf-8?B?RDZYK1V4dkNOT2kxQnMxUmR2UW9UaGtKSnlqZStFY0ZLSlQzc0FZTElYcmow?=
 =?utf-8?B?YmlhQWJ4TzF2TVVOMzVaY3lKNS9ZZDNEOUhXUGJKY1oza2liZ0pFZDR5RUlu?=
 =?utf-8?B?MjNUODNnTlY1L3FDeThlemlUZ05vVVlpWnVxdWZ3K1hRbWRQWkhmNy9HcWRT?=
 =?utf-8?B?b1A0Nkl4VTAvc2VXSkhib0Rsa0Q5TFdPV2NQcE5uMmtzVHpTcTF3WjJVTVpl?=
 =?utf-8?B?T1pMVFp4bllPTy9sWnpmN1FRYUhBREpxUnhXbWg5VGFJK2YvTkQ4VDFoYzEx?=
 =?utf-8?B?YkJuTTlxakNBRzYvN1ZBeGovV29SRW80RWE0YWdjNkM3Sy9YYUJlUzN5QTFT?=
 =?utf-8?B?ckpkVWFzYWlBVlZyblQxVWdMTHVxNHJoaUR6cFVHdXEvV05RNWlGdFlSZzFw?=
 =?utf-8?B?QXRNQlVGSkI2Q1VmR2xGeGtubXQ0NDZzMi9FU0k4WXlYR1BHZ2hsbWx6T3Jv?=
 =?utf-8?B?a3R4NzdVNVZhdWI0Q3h4Qzd0TUJHNFFSZ0Q4ZGROcnBIWnNzM0Jjc2FPYzIr?=
 =?utf-8?B?VzF3V3Ntd3g2dXNCYk5tbXE4bFlseXQ5M1RQbXl2T0VKY1RhNGZZREVGa1A1?=
 =?utf-8?B?Ullia3ZIUkZxL0xqY21UUXZxNUV2cnNYTlJsUmRjZWFzVEpjeCtLTlFXTWY5?=
 =?utf-8?B?YVgrWGxYR05XR3ZqbVYrVDhvcVpuTi9ZcktGMWtXbXNCK1ZBbzdpczJqQWtD?=
 =?utf-8?B?ZDU2a3BuTXVmNW5zOE0wSUdGc2dDcXBqREoyVlpLQnVHc0pxeVRhRkg1WHJL?=
 =?utf-8?B?QnJzMGxjSW1DdjNPN0hwM3RPbEdWRXRpUWE1RzdRSjhBY2QxTkdQT2Z6TTVE?=
 =?utf-8?B?U0ZVRkd2RXhWTTJhU3FGc01RcG15Tng3RkwzempTSitSV0w4aXpEZlNtQks0?=
 =?utf-8?B?U00yWU9CZm1zbkNZNG5QUWJyZTlFc0tVQm8rL3lkOFNFQVZjKzFkZ2N1dW8y?=
 =?utf-8?B?NDc4QVVkWlhuUGZBZjVFMTdvUzRCbXVNaGVWemlrdnptbHpvZDB4T3dVamE1?=
 =?utf-8?B?cHZjQkFad2ozNzNPR0xDbUU5dWxTR0ZrWDZBalJBUkNMVHEvOS93N2RyQTlW?=
 =?utf-8?B?TTRNU01Kd0FHVlFyOUdUYmtnWm5FbWorTE5UVSt6Yzh5TXZaL0dtVWRPczBQ?=
 =?utf-8?B?Z1UwTDRjWjllMnZWbFBGVDRqMTFrek9BbnQ2Z1hmZTJZSGtMUHJieEkzL29j?=
 =?utf-8?B?RzB6ZWpNMHlsdnBNVGJ0QVRHZFc0MnZlczBwemxlV2VEc3V5ZEZTQlJuYkFQ?=
 =?utf-8?B?bHZpOUdsczArdk90TEg5UHB2b1dwczZmQ3N6cloxQUZ3WVJaZE9YU0xTN0tj?=
 =?utf-8?B?elFBYUI5YTBodlRhdnl6VG9xekltVmFyYXlGaWo5UEhRekdGVDBvNnVod3Ft?=
 =?utf-8?B?YStpN2RiSG5kaW94UXBDajVsVDZTRGJtZ2dEVzRqaHRpY0wzSTRmcGh2NFFF?=
 =?utf-8?B?YXpRaVpCbTgrWVpNYU4wcGIvWWhJcjJQTllMZ0tyMnR3TTZ2Skl3RE9QUXRx?=
 =?utf-8?Q?auewwqH839YE2ZokeEnHXM2mh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6329ff-888a-420b-5124-08dc0c90155a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:13:35.4490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0WubgpzZy4eS1nawI9GSTKOzaY5SnTISKig84BBCBH2UNOHImpanl4DQnGeBvop6JwH8Ylt6s4+f3026dEZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/3/2024 12:58, Felix Kuehling wrote:

> A segfault in Mesa seems to be a different issue from what's mentioned 
> in the commit message. I'd let Christian or Marek comment on 
> compatibility with graphics UMDs. I'm not sure why this patch would 
> affect them at all.

I was referencing this issue in OpenCL/OpenGL interop, which certainly looked related:

[   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 va 0x0800000000-0x08000001ff conflict with 0x0800000000-0x0800000002
[   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 sp 00007ffd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000] likely on CPU 15 (core 7, socket 0)

> 
> Looking at the logs in the tickets, it looks like a fence reference 
> counting error. I don't see how Jay's patch could have caused that. I 
> made another change in that code recently that could make a difference 
> for this issue:
> 
>     commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
>     Author: Felix Kuehling <Felix.Kuehling@amd.com>
>     Date:   Fri Oct 27 18:21:55 2023 -0400
> 
>          drm/amdkfd: Run restore_workers on freezable WQs
> 
>          Make restore workers freezable so we don't have to explicitly
>     flush them
>          in suspend and GPU reset code paths, and we don't accidentally
>     try to
>          restore BOs while the GPU is suspended. Not having to flush
>     restore_work
>          also helps avoid lock/fence dependencies in the GPU reset case
>     where we're
>          not allowed to wait for fences.
> 
>          A side effect of this is, that we can now have multiple
>     concurrent threads
>          trying to signal the same eviction fence. Rework eviction fence
>     signaling
>          and replacement to account for that.
> 
>          The GPU reset path can no longer rely on restore_process_worker
>     to resume
>          queues because evict/restore workers can run independently of
>     it. Instead
>          call a new restore_process_helper directly.
> 
>          This is an RFC and request for testing.
> 
>          v2:
>          - Reworked eviction fence signaling
>          - Introduced restore_process_helper
> 
>          v3:
>          - Handle unsignaled eviction fences in restore_process_bos
> 
>          Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>          Acked-by: Christian König <christian.koenig@amd.com>
>          Tested-by: Emily Deng <Emily.Deng@amd.com>
>          Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> 
> FWIW, I built a plain 6.6 kernel, and was not able to reproduce the 
> crash with some simple tests.
> 
> Regards,
>    Felix
> 
> 
>>
>> So I agree, let's revert it.
>>
>> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

