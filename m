Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DA2C001DF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 19:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE42010E214;
	Thu,  3 Aug 2023 19:43:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692E110E0E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 19:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D663/dYa3gZjg6BGOlI8jmS9fRC/RbMMwfnivs5b5uy5MLRwLJgsHYT+KauDmP5xhwWWWMVsqANJh7RVGBTO8Bf4xCO8BIQljYicBXpcnGSW4WnSiGdyOsvnDO0u9SjK3zJ+9JmmcQ03ARWId0yg9dIWiJJ77DQyo+EcaB4f+I9fzJCytekPinG8NX7D1uUmOmqm493uUFrvewK1vDEQowTvM/B+Z7EenYie7IDOMLa/zz2vseX2yiUglQ2nsBsgIjuPYds2/uysQpFlsu5SewtXdSJi+MpnZPmEEEVg9W+QzHN37Q1PN6JJKTlNmDSE9x7Ik4wD1t0Lt0VMgFiNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me3qONMwo0pshOY9S0IYuBo6ZRwHDV7zy6j03TEAtm4=;
 b=OedJk3boiu3fIXtXHvXa/pnjbDNdvr/vrrXv4cGSCc/yXYsSfvWTLZ0VQMk8NWRyqGQP20Z+UKVC0MPTdpAV9X9de7KbjdV1gJmhOEl8gRnSeUOyIoI+CKmqdmS7v6RJi1GgxHwYw2xYKYbwN6jh+nFtMLG2RnEztroudjvhH2aEgwwhd47xJcDqALQdYOerOo7ttz/mhE68WYf7ToGWhzLbjeY7VFvP5AnpG0rCiEtmR9yOI1h/eqgA2K1SW6h0kxc8gMJnhcZkCYU+4dwlcxLjhImlJwMx2aOq1nNHLlEjHRfEi1VzEizuAxPzkdhU/+O89uA8RpGU6VXaxmwv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me3qONMwo0pshOY9S0IYuBo6ZRwHDV7zy6j03TEAtm4=;
 b=p8ebzNm7toTtuS/z7D6MpAupmqMbvMcFvnZYuOAzmSpKDP81BN8lojEEVyQX29Y1EDNgzxHgIl6maz233ELpyiuUl+S4y230lYqnPovjOd6ZyLFI5HD7WuzDVdsLPTNLK4XFtSsvVbmI+L1QM1GA08tLX84NEuUuCYny2GM1Bd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 19:43:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 19:43:07 +0000
Message-ID: <844e90ef-01ec-2ccd-de37-f383c9bb24f7@amd.com>
Date: Thu, 3 Aug 2023 15:43:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>
References: <20230719212255.30960-1-alex.sierra@amd.com>
 <11fa116f-87a7-38c4-f266-d19354bf69fc@amd.com>
 <CAHbf0-HZNEvSN0d2Ddnwg6z500WYDd5zzbTx69bBQmOc7GF=6w@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CAHbf0-HZNEvSN0d2Ddnwg6z500WYDd5zzbTx69bBQmOc7GF=6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: b46e6c02-36f7-4a5e-e678-08db9459dc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sM8jMXuICrw7EJ5aMBV2xEPFSgsWhYgWBsv0x5imVpFeoVwg8MbT2g20QnjKa2avisAAq5maRBaHN+M0WH7hUyRVc2Vmh3SRDnezJ86UeoWDX8bKLLU9rehuBMkmeZd+C/VmeNLr/FjJJXDyWWhuWRDtnAbN8uTy9asaff1xDqCQ4rDuCl9Be7vSf04wGvZURon97OMH1xAfSomM3IsYRj1BnjtKEWgBndLcEPmJVKbPIoQvy2+6+XL/JGLGBwT/ttzOgldfLReD64TW2/rqSB1/mygky/ZMz/KF8XwLBhRReIaKQhlKIti+sBYFh/BGwkMFFJwKPflgyxtGNkFdB/OZyzDpm/2DYvK/piVzESCKyrd3W4powpi1epnfOjJyRpGqxIMq/tRRK+URXSEcy+wmvFobLdNEIqUmoeI+/loSIoUqb6GNxaKcSgSmO8boKu0KlHBKShCh/R2DLIyGPyUn08gsh8wm7PGUco4qBIolXaJijmIeuRjiULa7n4y5E6EE7WM9MOYY8kQUSgMnN4KiRAJ7yKf4HMS/HG1xBFljZQ39Y+c09tHZyVltI8PBmLgGfaYj25ST/9d3qI7FOuqK/52QhEAFLrcJrxvP59NqUCa4ds+Wjb1TBiDut18nAFVioD8KWB+E+qotoUZ29A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(2616005)(6506007)(83380400001)(186003)(26005)(8676002)(66556008)(316002)(2906002)(4326008)(5660300002)(66946007)(66476007)(6916009)(41300700001)(44832011)(8936002)(6486002)(6512007)(6666004)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhMc2NxWFF6bGd6ek9HMWpRYzluT0o3ZUpVK2RPL0Frc1NCUFNiTFgySEdK?=
 =?utf-8?B?NDhUclFvRWsrTkVJam1nUm1HS1hPc3VBTEs1WnlkZlpKU05nVEhYSUtYdFBJ?=
 =?utf-8?B?M1BGZ3NTN3pDWFUzTGx1Z0JSVDVnalkxK2FMUVBRMC9DaFZHbkRqYmNRbi82?=
 =?utf-8?B?c2hzdGtZTm8yRHViU0dLTjdhNjFDTWx5Zkx1OVhCcmpXRWpVR1B5aEFGVnF6?=
 =?utf-8?B?dTZJNzVQUXdNTk1vWWliUitad3NHc2EwOFhFYkdoOE0wMFdBOGxoa2JRN1ht?=
 =?utf-8?B?S0pBSDR0VkRmaG12ZFBnb0t4UVNzYjJIWTJ4NkE3OW5VN1lZVFZhMGc1cTd0?=
 =?utf-8?B?YVBOanIwRGhoN3Y5djZlbXp0U2xaMlo0RXhGQ3pxYzhENFprL0tQK2FVckE0?=
 =?utf-8?B?U0Jsa1UvVGQ3R1ZoNkNmRVZMV21PM2VoK3U1QXF2N3k5T3dxa0xjZ0NJZGU3?=
 =?utf-8?B?SXY2REV5TGpOY2w3SXUxbUMraUJEcmh0Q1lFRStxclE3N1lLV0YzbmlGYVdk?=
 =?utf-8?B?ZW9aR0tNa3Z6MDVlWHlrdFhqNWx3ZjJ3WmJaY1FaaTV5WmhhZUdONmsyV2RI?=
 =?utf-8?B?MjJDYXZva0ZHU2ExeEVuR08reW90aUJ6RU5DOExyTFNuSWYxTGhMWG5qTGhn?=
 =?utf-8?B?ZHNCb0VsN2hEVmZZa2FNQzc2eEhFaWU5bTluc2hWTEdIWVNPVW8vQWIxTlZB?=
 =?utf-8?B?WEdhYkRnRmc2djB5UHNQc1MxeVlaTWw5YVdIQWswN0lMOW5FNHN4V2FNcHJ0?=
 =?utf-8?B?QnA3UnVSbUFlQ0xjbzVzcnV6b05yT25DbVJ2UHV2a0lHSzY0djhsNWdjZytz?=
 =?utf-8?B?eEo3dkpWTTJDTDlycWpnOW1QR1NXaGxtL3hENVBMQTFzODlKOHgydzRZRmVP?=
 =?utf-8?B?SmlDOG1HdzA4OWs1NDdPT1gxSVErTGdzTUFxVnBUdjlveHliUVB5aTMzQ3Fx?=
 =?utf-8?B?OURvZVJ3aWVIejF6eUN3bDEvYzFQY2NhTy93T3BRQTdrOENVU0w1b0grSngv?=
 =?utf-8?B?L2h1YklhL0xpNlIreUVnV0c2OTJ0VlNtb2hZYVYxWUVXR3RoRUNYbmdLRmkv?=
 =?utf-8?B?MUo4ZjJTbTlJMno0Mm9PRVN4V3BNZWhHZVBocGJ2R1dQUlQ4bytXSGZEM0hp?=
 =?utf-8?B?bWh1eVo2MExJTjA5Y09EWlFLWmk3STVQTlJGS3NsSkhJTmUwcXlrek9aa2Rz?=
 =?utf-8?B?dWg5KzRwRnZ0eENEZ2dDOXpmRTZ0Wm9MY0Y5Y3RlMVlyN1dvZWFTY1JMMmdJ?=
 =?utf-8?B?Tk4zeC90WWNUV0c1ZWZiN0tKRWVjaFhnWXE4N3phcDJiRWhQTU9RU1pqWXNG?=
 =?utf-8?B?U2dMa2NOOHg2dnpEZks3OWNKSlB3Qk9ZNUV1OGtVT3Zvb1ZtRUl5WC9xSElL?=
 =?utf-8?B?d0lWNjNXSCswaEIzcmJrbDcwOTJOVzVGY0IwcVhxVXJKNm1lb1Bma3NsMlZC?=
 =?utf-8?B?aWNKK3RXYXA2cUNUcWpQN0dVL2x5dzNQZExJWU9IalM5TXh4WU84SGN0cnBa?=
 =?utf-8?B?UnIrTDJYQUsySGt2WUVjUDhJcE4zTThNamdzVjM1M0NVU1lQUEVjYkJIM2ZS?=
 =?utf-8?B?VmlSRU02UFFFQ0lKR0FqcVJveitBODZFVmpkdlZjOG1GY2JGTVRHampUVnd6?=
 =?utf-8?B?NjZlTkZnajhnTEt4dGVPak9MTVdxL0RxTi9Xb2x6aERFN3dvQ0g4bWdpM3dU?=
 =?utf-8?B?RURnWE9JT3lWMmJWMVY3WEkrNlVzOXRtYTZpaFBoTVp6Z1BrWHdoODRzU3hB?=
 =?utf-8?B?MXpJMCt6c0x6UW51OGl6ME05OGFTcSsvYmIyejQwR1ZqWUExYjVEdzVLUDND?=
 =?utf-8?B?R1VXVW84U29UNStpa1lydFczdkJtMzZ6Z0llNG1hdGhwQm05ZDV1aDdPZFBS?=
 =?utf-8?B?TDE0SEtXL2ZFeXRsNTFLWlVJbmdRZnY5YlJYVS95d3BLaldRUDhIY1h1c0or?=
 =?utf-8?B?ZWhmZVhta3J3YnY0cUc5MlAwcC8vcGkyNnRMSFlLWHNpK2JGMTBaUEFlU2hH?=
 =?utf-8?B?dXNHTTdSTmd6S0pESVpYMTZnVXRvQW91NlF2MkkyUWFFSUxOSTdYeXBhcTJr?=
 =?utf-8?B?eEhqcVNJZzZjcFpXZTZEaDU1MFNZaThHcDM4NWVSYkdZdnR6cnRIRGdsWEVC?=
 =?utf-8?Q?7EpZLwnhASQ9PgFApZNsbX+Br?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46e6c02-36f7-4a5e-e678-08db9459dc0e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 19:43:06.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiWZVBv2r5lUXw9LGBcZpTCar4jbdmGhjcJDTWK8X0apnB8AwoItxGToex5XXkn/+tQ5gIqyeHBf+4oeexBqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 jakub.kurzak@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Is your kernel configured without dynamic debugging? Maybe we need to 
wrap this in some #if defined(CONFIG_DYNAMIC_DEBUG_CORE).

Regards,
   Felix


Am 2023-08-03 um 15:38 schrieb Mike Lothian:
> Hi
>
> I'm seeing a compiler failure with Clang 16
>
>    CC      drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.o
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:3568:2: error: call to
> undeclared function '_dynamic_func_call_no_desc'; ISO C99 and later do
> not support implicit function declarations
> [-Wimplicit-function-declaration]
>         dynamic_svm_range_dump(svms);
>         ^
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:50:2: note: expanded
> from macro 'dynamic_svm_range_dump'
>         _dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
>         ^
> 1 error generated.
>
> Cheers
>
> Mike
>
> On Wed, 19 Jul 2023 at 22:27, Felix Kuehling <felix.kuehling@amd.com> wrote:
>> Am 2023-07-19 um 17:22 schrieb Alex Sierra:
>>> Set dynamic_svm_range_dump macro to avoid iterating over SVM lists
>>> from svm_range_debug_dump when dynamic debug is disabled. Otherwise,
>>> it could drop performance, specially with big number of SVM ranges.
>>> Make sure both svm_range_set_attr and svm_range_debug_dump functions
>>> are dynamically enabled to print svm_range_debug_dump debug traces.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> Tested-by: Alex Sierra <alex.sierra@amd.com>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> I don't think my name on a Signed-off-by is appropriate here. I didn't
>> write the patch. And I'm not submitting it. However, the patch is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 479c4f66afa7..1b50eae051a4 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -46,6 +46,8 @@
>>>     * page table is updated.
>>>     */
>>>    #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING        (2UL * NSEC_PER_MSEC)
>>> +#define dynamic_svm_range_dump(svms) \
>>> +     _dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
>>>
>>>    /* Giant svm range split into smaller ranges based on this, it is decided using
>>>     * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and alignment to
>>> @@ -3563,7 +3565,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>                        break;
>>>        }
>>>
>>> -     svm_range_debug_dump(svms);
>>> +     dynamic_svm_range_dump(svms);
>>>
>>>        mutex_unlock(&svms->lock);
>>>        mmap_read_unlock(mm);
