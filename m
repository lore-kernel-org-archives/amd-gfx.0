Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9718C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 06:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6484E10E207;
	Tue, 21 Dec 2021 06:25:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E9B10E207
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 06:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkKIXdQ6jo5xHo1nQGayHnAX3xwG8kP7Ks3ToCATx3b7AMU5fvbGS9DCBVWVVgvrvEJlAhMyxKRd3LxbfgPXrm7oT3jzCRm6fFetcJ0xWqADXJW55xhxv5r8Uoydv7YK0o1yUVWhK0F9hiYpqKKHnDAJwqSoN9q00vRYh6eq5Ic8QTiGoljOaKLkb2BvyuYKTYWoUPahsmkSZ5DhkH/B7gYiVyBVOzljegpFAPI/OyTl2tScLu4ZDbay/UZbu9noYcY8BR8/rJKgytTVwcH+KldnGaiKzPbrvoOSM39kskfvG1dZ4zFm9VckVBFtPQrhtui8Ooes7RT/ZAxWXqqvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J01TLDcQ0aSMNg4w2SSCK3oeaYKv6bqsreWGDpJjP74=;
 b=YzuW4PAO5QvRacRI6r98IQksmerV/VNl9La4EXFdZ2uFhy+8QZopwa9GVpm01Qsj1x/7QvQVevLHoYbR7CFu2u695maCB1yOEpYqHhnC3/Lml0KDbvMTzqij4fRn9sPjJnjfEtdubTKP1xy3+/NbqtaZRG+Ey1zSIL167boWiDjeCL5nyar+2MrRJ3vZUD7AboOZwQFfVFHk/pzxPVKFwbrsMtZtCgxaJmaME37TeMGqaXicrsKttpvQRSv9FdN+v0uNMeXpKLcJoM7QAbhyowmEK3xNPqTKX6D/oHXB9QiIW2KsHjhLZq4OHnk9Ib29rXkYCUBz8AFsMMijkoDtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J01TLDcQ0aSMNg4w2SSCK3oeaYKv6bqsreWGDpJjP74=;
 b=cCjAiLO85a8DrRgRnqXRqhY13L6xYzxTpLu8zwTy7r3bv/gEr7/3Xp2RmBkNQAH++zbi3PG/o2LCudR8Rx+PsqbvrpQQmz8g1rLHZLRKvzI6XUBNvP1lKmclse+Shd71HJnHTuoWBKiAwfCRSUTYFfRO8GLYE9fDlcHAMuWLMds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 06:25:01 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 06:25:01 +0000
Message-ID: <9e7da941-a63c-5c79-4f40-0fd41df682ae@amd.com>
Date: Tue, 21 Dec 2021 11:54:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V5 00/16] Unified entry point for other blocks to interact
 with power
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211213035223.772700-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecef8946-b52c-4a20-bbda-08d9c44a9e1e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29383AE96B86B20466B0B046977C9@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YIcbeXo8uVhYZlZ8Y0w2jMVdu8fiNiZq9rIQm/UtMiV90aLeZnnotcgmW5DfjX53VI+FBggpq6VpwT7RnmLKhcJrOBMWncFpToaOKXcosXnNXSnQUx/Wb7uSH6IiXmDoB9GY3tfBQmSrtGqJOOHOCle6RceERq/G0EnI2AGmnIYc2aUYQuLcL5yv2ro9bYfgiVNegZsz+77+B8/44nht9sTIVvPWFoAPsfTSWX2IGTPEurrjbbvyI4XL30K6OxhwbBzMmgFjVLnInIrulJ3q/lpTPMo34vuQLp+3MIw+5FQ7b48wxZ4mOyam1Ki+Qea0lITYvvHa08KNazXZLmog3deopCzum0uZoXl54DgH+PxnlKFOM0DFkxibwEzjnIjBhjMDYBOEQGhBbkwSJLVm393ZFOOE0YChhMXv+b0EvOn/N3PfUnnZ2iLalYx4Zhdl2i+DJ2LCWPUhGlVZBzpIb/h980dk2QnRssabHXZZnriGJTALEL/PI91a1FHwDMxY0BLNR5SMJDsUSFTMpDMnUN1c84277aauWsxTISH3jjLyt8CbrMeftdCp94c5YWwG087Rp1+TYpAMfvX0LdIOQSSCccCJp2ZLuvcAoemA11JYaUH8aXWxW9CzxjyOcG8SrZxbbRUP8pQFYU8yRA8XcD/0rEwdAQQJe2IaK6kT4r0xOcfbocWGtzor+jCeCglSI+oiyLRj+t4D5YMik74RHU3Fis+KvtEueVYDYXny8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(31686004)(66476007)(6486002)(2906002)(508600001)(38100700002)(53546011)(31696002)(66946007)(6666004)(6506007)(36756003)(8676002)(186003)(30864003)(83380400001)(2616005)(5660300002)(8936002)(4326008)(316002)(86362001)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1PWll4TzNXdXBqS2ZsUHhDamg5UmRTR2xnN29XVTY4MzF4WE80ZFZYQko1?=
 =?utf-8?B?TXZuL1JaS3JGc1FMY2NpUkJWMlF2T1I0NG1GWFRPVFY0eEdKc2FvU2lSb250?=
 =?utf-8?B?Z3QwQ1Q3VUxxbXZ2cUd1Tk5obmM5U3A3OU9XOElpV1NHVGYzQzduaDg1ZGd4?=
 =?utf-8?B?VDFOQ05WcHVxZWNkRlNveGNQUkNYeVBwOW0xck9MNXJrVUpFNUNjY0plU0cz?=
 =?utf-8?B?aERvNGRaN3NOQ3JYZGVmQis1dHpuRkpSSFRBRjNkNWwyZkM5ZXYyd3V4a0ZF?=
 =?utf-8?B?cmw4dlFYcWlsUjhreU5Fdmc1RFhVaHJMWjVBSkU2OHkxdkEybEhibDBxSDJp?=
 =?utf-8?B?eHZBbVBpVFF2dmhmMkJ2UkxwZElDSGZCZU1weDNiMkwweGpYVStkdmpVSVE0?=
 =?utf-8?B?OXhZRWhLaTlKTDZ1YVp3SGV2UEkrUG5CMDVBNDZ6WXl3RWtvbk5WSjB2ZVo4?=
 =?utf-8?B?RThCV3lRbmZVOUQrUFRDcTVPQnFGRzlNVi8vWUtkL05LL2I4UjRYRGNBUE5M?=
 =?utf-8?B?ZXk2SzUxZ3pvTUJDL0hVQ01iUVI3blBUbTRDa3dQM0lYbmgzYlJKZlhPYWtw?=
 =?utf-8?B?NytRcTdnTVl0UDQ3RXJGUC9UYzc5NjBkZEZseUhpSWNzZy9PVGlycXRaWG1N?=
 =?utf-8?B?TVhtT1RjbGxxbE5zdnEreENLU3ZPVWNkdmQ3a0xRc0h2aU5mVTNSRGlwMU90?=
 =?utf-8?B?ZFl5L3FTQnNxRFpMQnFuMVpHVUd3dzhCeXBwL1N6Y3c4ZlB2RDlHWXJpQWVw?=
 =?utf-8?B?YXEwdy9WczJSY0tqRXJIRmxaSmJraVBFdXFqUjZkdFhUbFd3U2dJZWJUTGNs?=
 =?utf-8?B?QmFsQVJzZzU1dHdDd3hzaE85YVRnNjR2UE9jUW9Jd3g2bGFDNkZ2VzdxYVpY?=
 =?utf-8?B?elZhaDcyRUtPOWFrS05nVWpFbHl5dGhic2dreitISTl5S1Fxd2preGNGRDBE?=
 =?utf-8?B?NlBUaDIwZ0E1R2E4bnhkaXZsS29OTnBDdzNpNVZ1TUQ2UGZ0K2QxWGNpSnBZ?=
 =?utf-8?B?ZUxOMUxzV2MxamtLZXV1RmdnbExZSm1LZmgvRUpoNkFZQkR2eTN3Z29laEdr?=
 =?utf-8?B?bUcrMGw1MDQwYVc4VlpNTisvcmdML1czcTBvVENUK1djTEZlY2srWC9tV21W?=
 =?utf-8?B?dnQxUlkrTjlVVVFVY29UZy9OY3dIM05zZDlvU2M3ZVhUTlh6YUdnT2pzVWJ6?=
 =?utf-8?B?a0lCbVpWSUo5Yll3VnJ4dENwVU1KMktDdG1tYS9hcVhPS3ZUNUVacTVTUEJi?=
 =?utf-8?B?cGhXY2g5NEJFMDlLT3ZCRHNHVlp5Sko2RUUyWGRxeEZJUGVyY0FLWk5DQXhD?=
 =?utf-8?B?b0tTaVl0SXR6dnB4RkIvS1dQdko4NndSUGdVSjNDcXgxQUlpMVpZdnh2Y0tO?=
 =?utf-8?B?MC85V1JMOW5hZ09CbXZFeW1DdHlYOTBMWGR5RW9NZzgySFZ0M2RwVzF6NEky?=
 =?utf-8?B?MG1UT3Z3KzJObEgyTXArOEtvSTZiY2Jidk1nSjgrM0laTkxyeVBQdC93TmVu?=
 =?utf-8?B?UjNsL0ZKYWtxNElnU054WUdHd3NBM3pQK3hESkdtcW5zdjFQSWk0NWZTRXVM?=
 =?utf-8?B?U1lYK2hBWjNNT3ZUYU1rT2Z4NXB3WWsrWUtjM2Q2Qm5tb1FnT2VNK01qTUJG?=
 =?utf-8?B?eEJWczJQd0lCRUE1VGIwZzRFbUI2bnVYTzRrTm9EYWZIeDRLM3VRWDZGd0lk?=
 =?utf-8?B?b3FyMDRyWnJwdjJzNWNMeWRZRnA5ZjAyOEdZaTRwQU9UT0ZKMFJxakJWTUN2?=
 =?utf-8?B?dzIxaUVUYjRqb2J0MDFGRWJYMk1MWlNMNmVhS1pjeDNyYzExRGF2eWpic3kz?=
 =?utf-8?B?cGo0ZXRVWkQxbjJITU1jdExNVm1CWTdaTXlITGZlanpLR3pveEZLYzZsY1Nm?=
 =?utf-8?B?Q2lybFZKZ2pFRjhMQVUyWmlSWjZUaTNheWhXQWFwa1lCQXk2a1NyQWhvZCtX?=
 =?utf-8?B?SHB2aUVhejFrU2NMMzRBd3Y2UmF6c3pid2VyOHNYeFpiMXVMK2JrdGtRc1lB?=
 =?utf-8?B?c0UxUlZYVEs0dURMZDkxSVdUSGlXQmNSTnBVQWFLUDhQK0lmYmJ0aisrOUVG?=
 =?utf-8?B?Ti9JaVBZMnY2SFY2OHVYYWZhU3FVUWdhTGZHRGk3Q0hMZkxVdjJIeTZaT1lx?=
 =?utf-8?Q?lGJs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecef8946-b52c-4a20-bbda-08d9c44a9e1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 06:25:01.6389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaI8knUBS40xpn7eq9i3sACvD+QWeZD+iy9kySUMYWdLEg6b9PvZalYHoEq2Koui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/13/2021 9:22 AM, Evan Quan wrote:
> There are several problems with current power implementations:
> 1. Too many internal details are exposed to other blocks. Thus to interact with
>     power, they need to know which power framework is used(powerplay vs swsmu)
>     or even whether some API is implemented.
> 2. A lot of cross callings exist which make it hard to get a whole picture of
>     the code hierarchy. And that makes any code change/increment error-prone.
> 3. Many different types of lock are used. It is calculated there is totally
>     13 different locks are used within power. Some of them are even designed for
>     the same purpose.
> 
> To ease the problems above, this patch series try to
> 1. provide unified entry point for other blocks to interact with power.
> 2. relocate some source code piece/headers to avoid cross callings.
> 3. enforce a unified lock protection on those entry point APIs above.
>     That makes the future optimization for unnecessary power locks possible.
> 
> Evan Quan (16):
>    drm/amd/pm: do not expose implementation details to other blocks out
>      of power
>    drm/amd/pm: do not expose power implementation details to amdgpu_pm.c
>    drm/amd/pm: do not expose power implementation details to display
>    drm/amd/pm: do not expose those APIs used internally only in
>      amdgpu_dpm.c
>    drm/amd/pm: do not expose those APIs used internally only in si_dpm.c
>    drm/amd/pm: do not expose the API used internally only in kv_dpm.c
>    drm/amd/pm: create a new holder for those APIs used only by legacy
>      ASICs(si/kv)
>    drm/amd/pm: move pp_force_state_enabled member to amdgpu_pm structure
>    drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations
>    drm/amd/pm: move those code piece used by Stoney only to smu8_hwmgr.c
>    drm/amd/pm: drop redundant or unused APIs and data structures
>    drm/amd/pm: do not expose the smu_context structure used internally in
>      power
>    drm/amd/pm: relocate the power related headers
>    drm/amd/pm: drop unnecessary gfxoff controls
>    drm/amd/pm: revise the performance level setting APIs
>    drm/amd/pm: unified lock protections in amdgpu_dpm.c
> 

Have some nitpick comments on two patches. With/Without those addressed 
and with the understanding that there will be some follow up patches to 
  address some other comments made, the series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    7 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   25 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   18 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    7 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |    5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |    5 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |    2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  248 +-
>   drivers/gpu/drm/amd/include/amd_shared.h      |    2 -
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |    8 +
>   drivers/gpu/drm/amd/pm/Makefile               |   14 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 2467 ++++++++---------
>   drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |   94 +
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  552 ++--
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  341 +--
>   .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |   32 +
>   drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    |   32 +
>   .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |    0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |   47 +-
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |    0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |    0
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 1081 ++++++++
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |   38 +
>   .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |    0
>   .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |    0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  163 +-
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |   15 +-
>   .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |    0
>   .../{powerplay => legacy-dpm}/sislands_smc.h  |    0
>   drivers/gpu/drm/amd/pm/powerplay/Makefile     |    4 -
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   51 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   10 +-
>   .../pm/{ => powerplay}/inc/amd_powerplay.h    |    0
>   .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |    0
>   .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |    0
>   .../pm/{ => powerplay}/inc/hardwaremanager.h  |    0
>   .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |    3 -
>   .../{ => powerplay}/inc/polaris10_pwrvirus.h  |    0
>   .../amd/pm/{ => powerplay}/inc/power_state.h  |    0
>   .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |    0
>   .../amd/pm/{ => powerplay}/inc/pp_endian.h    |    0
>   .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |    0
>   .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |    0
>   .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |    0
>   .../pm/{ => powerplay}/inc/smu10_driver_if.h  |    0
>   .../pm/{ => powerplay}/inc/smu11_driver_if.h  |    0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |    0
>   .../pm/{ => powerplay}/inc/smu71_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |    0
>   .../pm/{ => powerplay}/inc/smu72_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |    0
>   .../pm/{ => powerplay}/inc/smu73_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |    0
>   .../pm/{ => powerplay}/inc/smu74_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |    0
>   .../pm/{ => powerplay}/inc/smu75_discrete.h   |    0
>   .../amd/pm/{ => powerplay}/inc/smu7_common.h  |    0
>   .../pm/{ => powerplay}/inc/smu7_discrete.h    |    0
>   .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |    0
>   .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |    0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |    0
>   .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |    0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |    0
>   .../pm/{ => powerplay}/inc/smu9_driver_if.h   |    0
>   .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |    0
>   .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |    0
>   .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |    0
>   .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |    0
>   .../inc/vega12/smu9_driver_if.h               |    0
>   .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |    0
>   .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |    0
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   94 +-
>   .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |   16 +-
>   .../inc/interface}/smu11_driver_if_arcturus.h |    0
>   .../smu11_driver_if_cyan_skillfish.h          |    0
>   .../inc/interface}/smu11_driver_if_navi10.h   |    0
>   .../smu11_driver_if_sienna_cichlid.h          |    0
>   .../inc/interface}/smu11_driver_if_vangogh.h  |    0
>   .../inc/interface}/smu12_driver_if.h          |    0
>   .../interface}/smu13_driver_if_aldebaran.h    |    0
>   .../interface}/smu13_driver_if_yellow_carp.h  |    0
>   .../inc/interface}/smu_v11_5_pmfw.h           |    0
>   .../inc/interface}/smu_v11_8_pmfw.h           |    0
>   .../inc/interface}/smu_v13_0_1_pmfw.h         |    0
>   .../inc/message}/aldebaran_ppsmc.h            |    0
>   .../inc/message}/arcturus_ppsmc.h             |    0
>   .../inc/message}/smu_v11_0_7_ppsmc.h          |    0
>   .../inc/message}/smu_v11_0_ppsmc.h            |    0
>   .../inc/message}/smu_v11_5_ppsmc.h            |    0
>   .../inc/message}/smu_v11_8_ppsmc.h            |    0
>   .../inc/message}/smu_v12_0_ppsmc.h            |    0
>   .../inc/message}/smu_v13_0_1_ppsmc.h          |    0
>   .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |    0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |    0
>   .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |    0
>   .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |    0
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   10 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    9 +-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   34 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   11 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   10 +-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   15 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |    4 +
>   117 files changed, 3232 insertions(+), 2264 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
>   create mode 100644 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (99%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (98%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (99%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (99%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (98%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_arcturus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_cyan_skillfish.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_navi10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_sienna_cichlid.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_vangogh.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu12_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_aldebaran.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_yellow_carp.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_5_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_8_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v13_0_1_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/aldebaran_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/arcturus_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_5_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_8_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v12_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v13_0_1_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)
> 
