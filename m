Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAF2C001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 21:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFB010E05F;
	Thu, 10 Aug 2023 21:52:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA02810E05F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 21:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPsKRkagJGhjUuVbVPJoyuJ122pnaaIhEp7zQWW6lViDe9rP/YwZthDDlTF23+pGYmkQX94wECI+cKvBDmrynTwTMFy5WgJwDVjYB3J1/khBusJx/2nS81PwVGzI+pvbZt1H0tmK/6oV5xHuOawqKNeDeJWm6YTPN3Fcm9Ld6RX6MgyhaG9jdnH2jAjCGZHnWwAA6507GiOlUlSrrr4zhseWb1yeG98Fm9Ly7JDIsYUv4F7L8RPToq0K6ZIuziXSblv75Y/CzjVaYtowmdAYKfd0TdADKSrfWgvOYOW3NE8iYyQB4Ugmk32AhdTDOuKRs/WuJwop2RLkBPb+reYFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9YAMbO/cc+cnuxCvPk24+LcK5HclTheLAoVxBztN6c=;
 b=iMWYiEdoG+kgDhsrGNzQIU7P7QBXhpWFbgvkJ7i4kUfuAHn/lXOmDefiSandsk3s8PzcIgWF5Na2+jxqBAMXGFVWDDdJ/uHJy9dkTzqCiGKlzF6gfHKQyre1CZX5TARKzslOzvgpvJBCIsYV17DjA64Eg2381Wts9PES7KOzVajzoK+6SpnE6TjDBGNFJAh7PliIwC4YqlF6zojshpJfQyaL54CQy2JqQHdiK33a0MlL4Rla0Un1RHjhUyHSAbIwfszbRb9Qc4+5UJBo2BEz9xpot3dsoPGVblbjC5mlhAvn/J06JHgAZQFkW6JL9VGBPlhc1wEOt/6SHVE82Iff6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9YAMbO/cc+cnuxCvPk24+LcK5HclTheLAoVxBztN6c=;
 b=av2woG1TQe682pA3FHJlOtu3qvncIsSkGve0hdD+T2+pHmjOmN2K6lNxiV1esi9pQ/W/8r+4AZtPMdJ2XgD+PA0Zt5Z39IycTjBQw5t81GUF+XgRa9pwMOWMI7bjdD8HlDxaWdGRRKLvmwEuX/iKShdItRmaxsHI3pH9DDHiBRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:52:38 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 21:52:38 +0000
Message-ID: <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
Date: Thu, 10 Aug 2023 17:52:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: f01dadba-f367-4fe7-1828-08db99ec1cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YncKTdVlY0a2s7R/erYd3E/lwH07qIPaJgSOUw3tF15sqgfusnoeH+FHVUq15Gr+E0uXPzXrwapHjNdspI80eTo6B1eXCjtk0sAuFQlRHya4pu27x6JirzHNE4Po99L+0HSIUTpSlgegCyXEXugEyo6U2VlxlbaxiWvKQoQE2LiwW9iV4i2wLrBiezgf+Z85VPcIZ0j32fR5DyciOhVjHPlO5njBwXeEXd9urvxcbv2VVHx7Wbnjdp4rZbCWd85hdNEKtIodw43JEQJ8g7Iw4/rdC59lwdgw0TMlfVsgk/5paL2f6jNt7HmSGPAf1UxRRyva8MjnoVzcO+8kq6p1XxML4B/DkG4HacUWpJoG0wpICB9n/NzYpM8Xea9QI9VoOxBqtGaLDcfD4XLMYK/rvmd9nM2VxBPOb/yKtyX7m89E0KuEey2woAqENeKQ291fFbUL8tQjnFRqEdjXl/WoSOjEYS2sBRXsiXWGJBSNxaRo5dW8tC0HJzCosHxWXcpB3A4KI/zOCmD+9AGuq3wXSru0qdWnIcRqoKZTWzoW7vtNaOcReAY/ihTE5S/dY0UGhptXbFe5iDWZnvw2SZsqIGJAc4535WkiYRglw0CwyZJOuKtcQi4mslzBsrtCFKo+BLreLThpN3AM0RND+OkzbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(186006)(1800799006)(66946007)(38100700002)(66556008)(66476007)(83380400001)(36756003)(5660300002)(8676002)(110136005)(8936002)(316002)(2906002)(41300700001)(31696002)(86362001)(6486002)(6512007)(6666004)(53546011)(31686004)(478600001)(6506007)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGN2czB4MkowazVZNmhhSHNSdlN5NHVGZVc5cEdxSnBIa2JHYkd5WlJzSS9N?=
 =?utf-8?B?MU5OVGp0eFdZNS95Sm9taC9Dd2RKYURHMHhycCt3TXhpZktFSmlaamlNdmFB?=
 =?utf-8?B?bXJqY2JjQkRVUmgyOVBXM2NUU1EwSEZIc1BXLzZ4N3RqZXlWVW9yMTJYakN5?=
 =?utf-8?B?OG4wdkFGMlZKcXBUNGdHTTBtbFE2L29ReXYvb0hUcWhhV2tySGZ4cGRrWXpU?=
 =?utf-8?B?NXMxYytqanlHNHNKd2NZV0p4Z3RxcVR3M04wT0FoeUNudDA4Z1RmMDUralpS?=
 =?utf-8?B?UWEwanNWbnJGT0RQSVd3Ynh6Vk1mQVZLVE9HNjdaYU94dXVkdFkyZXc2cEE1?=
 =?utf-8?B?dHlqOEZ5NmRZbmtXUEk5MFNnN1VLYk5GaXlQSkllT3FMZmRHRmFwUWNzRC9C?=
 =?utf-8?B?ZzhOTktSZEtRci90Nk1JUFhkc3YrZnJtZ082OVJtUitvRVlwYWxCRWhUSU45?=
 =?utf-8?B?NUZ4cXhkTkt3MUYzRnlvZzBqUmlRenRBWnJybGZTNXV6cERLY29Ib2xUUzla?=
 =?utf-8?B?TytlY2tvOHVVZXkrTnZBazVidlpqNWM4V2gwMlhBeTZYOEUvbERpRlAzdnFZ?=
 =?utf-8?B?NmQ4TFpFeHJuYlBtZW1vQ2QyNTJDL20wNlR4eHRsWUJMbS8wM3JQNG9JVlo1?=
 =?utf-8?B?SmlzeTFkUFozMmVtak9oRUl4WVRHczBFR3drQmRRNnptemtSRll1a3RQa05l?=
 =?utf-8?B?OFI0KzBraGhGeHMwRi93dThYRXdhRTg3d2xhUXAvNFdxWHllTHlKRU04dGdP?=
 =?utf-8?B?M2NucnhibFFjL2tpbXE1SUIvWE5MWGxQZDhlUndyZHc1WFQ5VjhHbzlDK24z?=
 =?utf-8?B?RmxGamtDWDMvd0tPZnVsTHlzR2ZMcS9iNTlEUUplUnZjamkyb21yTVE5cTV6?=
 =?utf-8?B?VWZaUWNRc3hhUTdwNnc0Kzc2elRSK01KUzVHVFFqR0E5VnhmSGJNRHg5Q1pP?=
 =?utf-8?B?c2ZFQzBIQ0J3MFE2c2hpc0x3QkpCNDVYM0RZUjZxbkVqc1p1UEFIY2lXUUo4?=
 =?utf-8?B?aVlnbzFCdmd5ODQrZmR6Q29SdW8wNDI3S2tleWxJN3IwcjMwQWRMc2FZamNS?=
 =?utf-8?B?SGs4TlgrUDdPQ1gyWlVFaUFsTXdBZUs0YWF0REY0bjR0R2ZKbXVOTmRUWFFt?=
 =?utf-8?B?eDNhc3dHbWlZRjZOc0NHSmZZcmxocmJ4NEdaQUJKdWdtVGh2aktBWCtQNmFm?=
 =?utf-8?B?VTh5dUdGY1dBVHQwd0lJenZiUnlJdTh6cld5aVJzOUNiUGJtd2IxSWhEaldH?=
 =?utf-8?B?L0VCQ042YzU0enNWSTVPUkJHWDlERHNKYnE4UTBQY1NZd1ZXZE5mamZSY0w2?=
 =?utf-8?B?bzIyc1V0Z1dUWlVMcGFvMkZOR1lib2pBRUxNT1RPcVh2dXFFR1dCTnNlMWZP?=
 =?utf-8?B?TXU2RUdKVksvTVgyMVM2U0loNWxTNVhCeGZUTmxuTzRMN2hKLzBzTGw1a25Y?=
 =?utf-8?B?OXhUNHBoaDIyVzhVZlNET2swY1NjQ0hleThtZHhJM0FXa3oydkRKb2lkZjFR?=
 =?utf-8?B?cDNBU05pWlB5TjhGcXhlZi8rQ1BQdTdBcXpFWmVnSlB1SXZsN0R4Szh1bGNV?=
 =?utf-8?B?dFRHekV6U2puRzkwbm1OTjk4WlA5TnBHcEQvMFdWN0NCMXprSDByRmhVUkhv?=
 =?utf-8?B?YlJxVE1KVWVXbkZncHFsZ1ZlSnJ0dUp3R2UyQVFZOW4wUmhRN2p0aFhIRzBO?=
 =?utf-8?B?NnVuM0V5d0RUN3V6UzVxN2p2NXpFQVc2Ukhwa1g1NHo0SnVFWFVQN0ZsbmFj?=
 =?utf-8?B?eVh6N3hIM3ZmcWR3M3BwVE1KQmNleDJtNUFvUHBnKzN3akZYSU5FaVRQemRT?=
 =?utf-8?B?TndyWDRIZVllSnZyUTR3QllVUG1vK3JFNEh4d0lqTjJ0SUhHT2xNRnVYU0Ex?=
 =?utf-8?B?ZzVkUWE0VzliVU5rUkxLb0NlQnNaR1QxR1pVUStYN0EzZkZEYVplRXVlYVEw?=
 =?utf-8?B?SjdDWEpXUzViL09HbFV0WnphekZaN3Q2cUF3OWE4SStIdDQxamlHOGs2RWox?=
 =?utf-8?B?WUd5STlYL2dFQUdWN0hWMEFXNk9MdCtHMkFlNENQcy9pZG80Nm0vTTg0Z3pF?=
 =?utf-8?B?THkwNnJzS3FCTUxHQWxwTkM1emNFTHljaDVSTWdmY0NNSDVxckxULzBrT2tt?=
 =?utf-8?Q?BdsgcPDHCxWeESYjX7ifIzfzJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01dadba-f367-4fe7-1828-08db99ec1cf3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 21:52:38.1978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+/FfMjg4YnrlFbYn+ErHj6fph2MCvj4iPp5ax1yMAVBNv1XXV+tqaRh/eYRByWZDvuRzeCZDUONR1DD0vQT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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

The problem is the queue is suspended before clearing address watch call 
in KFD, there is not queue preemption and queue resume after clearing 
call, and the test ends. So there is not chance to send MAP_PROCESS to 
HWS. At this point FW has nothing to do. We have several test FWs from 
Tej, none of them works, so I recalled the kernel debug log and found 
out the problem.

GFX11 has different scheduler, when calling clear address watch, KFD 
directly sends the MES_MISC_OP_SET_SHADER_DEBUGGER to MES, it doesn't 
consider if the queue is suspended. So GFX11 doesn't have this issue.

Regards,
Eric

On 2023-08-10 17:27, Kim, Jonathan wrote:
> [AMD Official Use Only - General]
>
> This is a strange solution because the MEC should set watch controls as non-valid automatically on queue preemption to avoid this kind of issue in the first place by design.  MAP_PROCESS on resume will take whatever the driver requests.
> GFX11 has no issue with letting the HWS do this.
>
> Are we sure we're not working around some HWS bug?
>
> Thanks,
>
> Jon
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, August 10, 2023 5:03 PM
>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
>>
>> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit
>> different because it needs to support multiple XCCs.
>>
>> That said, this patch is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>>
>> On 2023-08-10 16:47, Eric Huang wrote:
>>> KFD currently relies on MEC FW to clear tcp watch control
>>> register by sending MAP_PROCESS packet with 0 of field
>>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>>> packet will not be sent and the previous value will be
>>> left on the register, that will affect the following apps.
>>> So the solution is to clear the register as gfx v9 in KFD.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>> index e2fed6edbdd0..aff08321e976 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>> @@ -163,12 +163,6 @@ static uint32_t
>> kgd_gfx_aldebaran_set_address_watch(
>>>      return watch_address_cntl;
>>>    }
>>>
>>> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
>> amdgpu_device *adev,
>>> -                                                 uint32_t watch_id)
>>> -{
>>> -   return 0;
>>> -}
>>> -
>>>    const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>      .program_sh_mem_settings =
>> kgd_gfx_v9_program_sh_mem_settings,
>>>      .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>      .set_wave_launch_trap_override =
>> kgd_aldebaran_set_wave_launch_trap_override,
>>>      .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>>      .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>>> -   .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>>> +   .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>>      .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>>      .build_grace_period_packet_info =
>> kgd_gfx_v9_build_grace_period_packet_info,
>>>      .program_trap_handler_settings =
>> kgd_gfx_v9_program_trap_handler_settings,

