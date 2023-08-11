Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE66C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 14:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8ED10E6A3;
	Fri, 11 Aug 2023 14:07:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA6710E6A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 14:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuEPvzD+qGaJOnLGo0hzfICeF/4dytN7Py3YNPKml03NqyNEHsPJnOo0qm9ezx3YmYvy4xB+EoSBwOrJPqA4/pGPze5iXkGNRg7rTfiRF5D+9YaEYOiE9UEJ4PZYcWV4QIytaV1LsqeTQ0pToA2PUBTRFyugtHkQF68sgde74gw2yKzVxJDrYBFY39KmKndbSCoZqhJ5P9WrFli7sv4xEySR0V311mNlQB2b7F6b6mL3Hbw+l0qcj8mqC44pmOPw1MayHzIMODefHMp4jvv0ba+Yvh++FJ+D5oxjPf3kAzzm5sD239dM9UjyuLBcj1dscsWoxmEB9imEZ1YP0PyfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsYXCxRkHdBnX7EvDr3PoxMcNGFlDOAtHsDh90G+57I=;
 b=mli/y7fWdZ+2d8Uo/2Kbfi30eWAozXY5zXqYkFWo9MD8H3hMl7Gus8w9wIepa/Ra8kBoTeTI3VHOayYxcUQ2O7sn/XHCeUw3jO44iJdcDd7AIG2NJcTKhEYzs3zWWSHDMBrlZ2oSOeTZWD6gGm/ISvwPHMimDCLIWDXnr60IzAzCKQtWEOafLtQTnv8wng1mbGNQnZguT5w780xT8xXoKVcdgyT6SP1mVal6pTTxkNEcNb7LVP/qHTqEVBQL4+x4MJnPFWDmmsCEhjFiv+dSHFEeEF9tGnyD7oraLjNd/E7AdgLUg/oql+yWkAHHdoVqJSe8FXZ+QRaEUYi3x8wK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsYXCxRkHdBnX7EvDr3PoxMcNGFlDOAtHsDh90G+57I=;
 b=ECog69k/8Qt7O6USajeTCD6Lb7UuoDDUJWm2BVuli/rd/s99Qg696ezfmK7PnKDjPmoyDyxjT6USIRjwZB5q57mjkYCY+VB9JDedXMxGsAlo4mjOhU58kAz09oaqS1acKAMy9xQMGAqkpaLNggbdPiDrbmd9Arr7z1jpZPWdfHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 14:07:34 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72%5]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 14:07:34 +0000
Message-ID: <df36b2d8-5109-78a9-e5d0-280b10263dbe@amd.com>
Date: Fri, 11 Aug 2023 10:07:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
 <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
 <e5495ff6-b2ee-ca2d-78a2-4747c0c46668@amd.com>
 <c517196e-5fa8-85b3-8a5b-bb36c2816454@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <c517196e-5fa8-85b3-8a5b-bb36c2816454@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::27) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 04457434-64c5-450c-60a1-08db9a744f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4xxInKVxWFm+3aXxwgy1FaAS4EJi9OSzl0XvdD43flf0/ATM/GSrqtCupVsHEHioQSN3HUvwbGpJjQpK1whK7gbGr08t8/n85FdroEuxKzE2Lc+w7hLMZRmEgXlYuuJuYDKAMFnILKahDsQUzQk2FTFTeb8z78MXkxilMxzn+eLaXULVgncIUdN2e+pP24mgtUdzMcQJKtPe2xc5K0eTSuHAlNthqL/93WDp8zMFXW8fwPuP2FG4p4A7O6f4UbH460qMcyBa93m7KnWBHhPVHajby5nS+8LtuKEQHMPZAHrjaBo/cxeqdzF4cZO9Ul2Qn2DKG2EYOSJzDOikdtrVdg4Rl2/sSqvgHJ33evkeiCoxpr87vEjYG0Y+PWeUAurx0pS9/shCwsIoIq9lM/Ud/JFFzMiLt569Xj3xD6hONlIXLmvI/1yK6tgsekkYMLlgXaMldhKsK3o/MkgD6xf4s6NcLbo3ASttSPoYqpcrxewrPaWckRq1ASDJNwFF4t4f8i6r6kYtBJk64FJrIE+7dPFHERk5kHGn5MTCsTg3Efir7zeLse94f2mqL/xTUr+EqC6HSvaCZyx4c9WZBZEuWOXnUOpjMT+07qEUa5C1cs5DkJo3RC4ATTjP25SUQfnvUjdyvGSSEVdWxOXvQVTnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(1800799006)(186006)(6512007)(478600001)(110136005)(6486002)(83380400001)(6506007)(53546011)(26005)(2616005)(2906002)(5660300002)(66946007)(66556008)(66476007)(41300700001)(8936002)(8676002)(316002)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TENyV254L2NscW8vaUxnRzh1L1IyU0s5V2wyRzRTS3NXRHVkbE9EUUd5T2tB?=
 =?utf-8?B?djJKdzZsMnh1ZUpjZzJBM3NDK0w5NzV1TDU0SUh3MnNMejdXeVFqK2pSWWFE?=
 =?utf-8?B?VFdpOHpyeXBYTW5SSnkzVUVKb1NJc0FTMVZ1WEtqU3Vod09jQ25oN1ZlNXA3?=
 =?utf-8?B?T1ZJNThPUjI2TmN1b3M0UEZoUXREeEJWaUZlVWIxWFZSZ1RPRlorR2t0aCtY?=
 =?utf-8?B?OU1mQ1NKbE4zeWNmOEttSDhTS05nR0p5WHcxbDk5dmFudHJNWnhNMWQrYS94?=
 =?utf-8?B?QkY3OTB3MTRaOU92ejBkNFVLWTdNQURsaUhjektXTDFyWFFkZDhpM1RRVXRi?=
 =?utf-8?B?S3BmMG9IRDU4YlhNV0tmVmlIVmwvZTlteG9zT1NqN0oyOVUxZFR4bndBbEYr?=
 =?utf-8?B?TTNiSWtzUzJyeFdVc2Q2VDdYeGZuVkdnQVNLOXdNK3NBTXc0aDFqM0w5MnY4?=
 =?utf-8?B?YmFncDY2Z3lHdjdCVUM3ditySmdWRHlEYW5oLzQ1dStWcG1xV2d0YnVkTENB?=
 =?utf-8?B?NVhOYUNxa2ZvdDNIOWhadmQ3K0ZsVWVsQzJ0cjhyWEJ1ZmVnL2MrcGdmZ1hT?=
 =?utf-8?B?emk3N3BoM1RiZHUzQjJwMDNRSWozelIrdUxhRElnZHcxZ2lQeEFCSWRCdkVZ?=
 =?utf-8?B?b2N1OUVQL3JYTWJsRnl3elNyQnhHd1BzNTFhWGZBSVZwVW9hN2RNZTF2T09K?=
 =?utf-8?B?cW5FWmJibXpvaUlydENmTjBOVi9TMW9rdnlUMFR6K3hTaFJUUElRQ3VJekNa?=
 =?utf-8?B?QW9rTmpYalNIb3V4Z0FvMmt4Zjh2Kzk1MlJvT05CMUpxREZNRGFTeFZoNE9F?=
 =?utf-8?B?ZlFYcjZkYlJmVFYyWi85NXRvSitDOEErKzVCOFJ6OVpWYzNmMUgvVVBrc2R1?=
 =?utf-8?B?TEVkNGxKcEhkdGJGMGx1N0hjZmI3ZFpmTEdGOGZ4Z012NzM4SjNuV0ljWTFv?=
 =?utf-8?B?SjhpM1V6cTdJakFOdE9RSllzMWdaZzJnbGFsUWJkN0RXNkthS044b000eVp6?=
 =?utf-8?B?ekJSZXBzWkRhWWxQOUVtZms3ZGZCTnpoSVBmczc0RU9XL0dsTmJVV0xSU2lh?=
 =?utf-8?B?RERqUjh3Um9DUUh5Tk5jSXM4NW5HNUFwejJXNHRWeDArdXpDbGtUb0xpeTZN?=
 =?utf-8?B?QVpXREJNQWRZbWJoUnQvV05lWFN4c3ppekRCK2MwRm81Wjk3dElURmF4QXJx?=
 =?utf-8?B?bHhqbGpDSS9KOFE0YUJ4b0kxdHBkQ3h5ODVMNE9WMzhQVDFIblVxcXlYL2Jl?=
 =?utf-8?B?bzBSUjRxNHdlMVdTUVUwZFpYTHF0cnJuUU9jZWxDYlBmSkhHRTlCd1U0N3Bn?=
 =?utf-8?B?YzBDUURTU1JyMHN4N2VpVy9Pb21ScW9Ya2V6eVRWaWdXb1UvOHZzdTBjVnZn?=
 =?utf-8?B?UWZrQnkwSU0yejBMN1hYSzlZZit5V0ZXQ1hvai8yQzdCTkZsYWhtOFJVM3FV?=
 =?utf-8?B?NUVjNERKcHYvZWoyT0ZheGFVWjh2M2NjaWc0clEydStrSzk2Wk1ZY2NXb0xI?=
 =?utf-8?B?WkdoR1hhdnNSRVJqY1lya1Jya1B0eXVPNDZrSFVXOEYrZ1N6ZCtNMGtoejRH?=
 =?utf-8?B?RVVaR3Y3dVU4QTU5Zk5nazl5OThROFVkVFBPZ0N6VXA0eGVmYi95T2djcjhU?=
 =?utf-8?B?NjBvLzh1QStkaU1lYkxVOXFpNzFNRW82RUIrdVplRVB4ZXd6dFAxS2VTUnBy?=
 =?utf-8?B?ZWVIajg2dW5mdEpnTmJkM1FNZFFzdEVLWTV1R3R3MmNSaStLUy9hcVMzMW5u?=
 =?utf-8?B?NWVCWjBwQXRCTFd4dXBFZjhINkJraDBoTkZwM3ViMVVGQWJMNWhQaFJrdHVT?=
 =?utf-8?B?OTRrSGI2YkZSNkN3OTlxRERiMGR0V0U4SW0ycWtCRWNUY0RtbGhlRm51ZGJX?=
 =?utf-8?B?ZzllRG4xMklkelZKR0xOeWdzVmZ3K0pSNlBFZUI1dnBpOGxhSkhFRGZWOUNy?=
 =?utf-8?B?RGpENEFmdytLa2lLaFlwTUtGTnhLRGNVRWtQbTNyOVc3RU1oUEhEQjNkOXRF?=
 =?utf-8?B?RlNXaXVUSytSemRMZXFURzJzQkxJQ1dUSFlwUlA5NUJkS3prUWVJQTVHVlMv?=
 =?utf-8?B?OEhMbjIvT242NVZKVjV2K3BIZVplZEZhbTcxZjRHbDNZcVBUaGRmS2hmc2do?=
 =?utf-8?Q?ZGvIM94IJvm8n8Mt+6zrHcTrP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04457434-64c5-450c-60a1-08db9a744f81
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:07:34.6109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NrimUbsse2FomrehiU8tGXCI2xGHRxsR8bRGdkceOm1pSbjNhqH90guD5aF/H4oqS9f30qAbJMIsy7+M/R9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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

On 2023-08-11 09:26, Felix Kuehling wrote:
> Am 2023-08-10 um 18:27 schrieb Eric Huang:
>> There is not UNMAP_QUEUES command sending for queue preemption 
>> because the queue is suspended and test is closed to the end. 
>> Function unmap_queue_cpsch will do nothing after that.
>
> How do you suspend queues without sending an UNMAP_QUEUES command?
Now I understand what you mean, I was only thinking of UNMAP_QUEUES 
sending after clearing call. So MEC FW should clear the control register 
unconditionally on every UNMAP_QUEUES command. We can request it for gfx 
v9.4.3 to avoid the awkward workaround in KFD.

Thanks,
Eric
>
> Regards,
>   Felix
>
>
>>
>> The workaround is new and only for gfx v9.4.2, because debugger tests 
>> has changed to check if all address watch points are correctly set, 
>> i.e. test A sets more than one watchpoint and leave, the following 
>> test B only sets one watchpoint, and test A's setting will cause more 
>> than one watchpoint event, so test B check out and report error on 
>> second or third watchpoint not set by itself.
>>
>> Regards,
>> Eric
>>
>> On 2023-08-10 17:56, Felix Kuehling wrote:
>>> I think Jon is suggesting that the UNMAP_QUEUES command should clear 
>>> the address watch registers. Requesting such a change from the the 
>>> HWS team may take a long time.
>>>
>>> That said, when was this workaround implemented and reviewed? Did I 
>>> review it as part of Jon's debugger upstreaming patch series? Or did 
>>> this come later? This patch only enables the workaround for v9.4.2.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>> On 2023-08-10 17:52, Eric Huang wrote:
>>>> The problem is the queue is suspended before clearing address watch 
>>>> call in KFD, there is not queue preemption and queue resume after 
>>>> clearing call, and the test ends. So there is not chance to send 
>>>> MAP_PROCESS to HWS. At this point FW has nothing to do. We have 
>>>> several test FWs from Tej, none of them works, so I recalled the 
>>>> kernel debug log and found out the problem.
>>>>
>>>> GFX11 has different scheduler, when calling clear address watch, 
>>>> KFD directly sends the MES_MISC_OP_SET_SHADER_DEBUGGER to MES, it 
>>>> doesn't consider if the queue is suspended. So GFX11 doesn't have 
>>>> this issue.
>>>>
>>>> Regards,
>>>> Eric
>>>>
>>>> On 2023-08-10 17:27, Kim, Jonathan wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> This is a strange solution because the MEC should set watch 
>>>>> controls as non-valid automatically on queue preemption to avoid 
>>>>> this kind of issue in the first place by design. MAP_PROCESS on 
>>>>> resume will take whatever the driver requests.
>>>>> GFX11 has no issue with letting the HWS do this.
>>>>>
>>>>> Are we sure we're not working around some HWS bug?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Jon
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>>> Sent: Thursday, August 10, 2023 5:03 PM
>>>>>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-
>>>>>> gfx@lists.freedesktop.org
>>>>>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug 
>>>>>> for gfx v9.4.2
>>>>>>
>>>>>> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a 
>>>>>> bit
>>>>>> different because it needs to support multiple XCCs.
>>>>>>
>>>>>> That said, this patch is
>>>>>>
>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>
>>>>>>
>>>>>> On 2023-08-10 16:47, Eric Huang wrote:
>>>>>>> KFD currently relies on MEC FW to clear tcp watch control
>>>>>>> register by sending MAP_PROCESS packet with 0 of field
>>>>>>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>>>>>>> packet will not be sent and the previous value will be
>>>>>>> left on the register, that will affect the following apps.
>>>>>>> So the solution is to clear the register as gfx v9 in KFD.
>>>>>>>
>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>> ---
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>>>>>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>>> index e2fed6edbdd0..aff08321e976 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>>> @@ -163,12 +163,6 @@ static uint32_t
>>>>>> kgd_gfx_aldebaran_set_address_watch(
>>>>>>>      return watch_address_cntl;
>>>>>>>    }
>>>>>>>
>>>>>>> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
>>>>>> amdgpu_device *adev,
>>>>>>> - uint32_t watch_id)
>>>>>>> -{
>>>>>>> -   return 0;
>>>>>>> -}
>>>>>>> -
>>>>>>>    const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>>>>      .program_sh_mem_settings =
>>>>>> kgd_gfx_v9_program_sh_mem_settings,
>>>>>>>      .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>>>>>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd 
>>>>>>> = {
>>>>>>>      .set_wave_launch_trap_override =
>>>>>> kgd_aldebaran_set_wave_launch_trap_override,
>>>>>>>      .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>>>>>>      .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>>>>>>> -   .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>>>>>>> +   .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>>>>>>      .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>>>>>>      .build_grace_period_packet_info =
>>>>>> kgd_gfx_v9_build_grace_period_packet_info,
>>>>>>> .program_trap_handler_settings =
>>>>>> kgd_gfx_v9_program_trap_handler_settings,
>>>>
>>

