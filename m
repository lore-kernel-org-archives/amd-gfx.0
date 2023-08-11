Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E0C001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C67D10E0DC;
	Fri, 11 Aug 2023 13:27:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E3E10E0DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 13:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/QOZN6r4vjC6cUT5zqR17hGotf42Gn4yd/x0z+sxobrXmoKi0JXZMREn2esalOfZQMYEeHHX0f9esAxe/PoLLdJ9lTMBBIoXcp9PZMd3pQGvtdeQX1F8yGffWJZJZtPc+x1tY7e+AqTsszMc9lvpRi9l8+0sfjWHc1zXPqCoPTeQHYCuX8O1JRGy6NW+0XTkc4wft5a6RYVYjraeparEjpoOO8fS6a9qtRFKLOLNiMoz8nA77gwlfEMHmhrY3NIRWBveJiobsd1oDQxf8CGnpHzo7904a8BiDGMqKc/K3J45780Ra0dZia0Yeu7O+oxRFgH+GjWuXRRdTOzSczXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acnJECL5dern37/A3XlT/3xoRV4BxqnHhwvGP5J5tS0=;
 b=LHPR6m2mVLSrushSS2M6YHLOleyXvIE7yxOexpX5N9xoLKhsvs3izjILmHe7KhjdWRe/uF5ec0tGShhzz/bUIcDbzwaeugbAGOUefQO720JPZi2Ok444nM+WRkqhIUYT8F2b8BdaW9J95tIQBh4f6CAOo5Pn4HeBtoIzxyWdg9sGkFgNichtyXs7DvHizgPie590yTF8TAXRdsypFyFpToBMMC3AiIm7jnPZh43WB0m49gp/RE5yf1di6i4bu+sXH0AYHZYaU7TDmv3R/p8GQoYpvgMM3iQl2CdkQmwcfGSLrI74SAb9v9q5G6S+JSIy9BnEi8NVPfF4ugq13eZf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acnJECL5dern37/A3XlT/3xoRV4BxqnHhwvGP5J5tS0=;
 b=3DkbN3F7JpoXJYZmFTZz6ljOpakGahI6nuwBmBWhjW1a2PHdPfr8ULi0HaM5TNSAmMprlLWOPEmFSefcwbhLDDIRE8vG349cysToX9+bUXfI8XLxVdJbRfQ8+qAGWZ/YQh+0KOZsH8+rfiHPiOOJFLdlkyeLsL95ScAE+VA5p3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 13:26:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 13:26:53 +0000
Message-ID: <c517196e-5fa8-85b3-8a5b-bb36c2816454@amd.com>
Date: Fri, 11 Aug 2023 09:26:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
 <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
 <e5495ff6-b2ee-ca2d-78a2-4747c0c46668@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <e5495ff6-b2ee-ca2d-78a2-4747c0c46668@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0462.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 368a9e43-1d04-4c67-61f5-08db9a6ea05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niHYEASDnV07gM9XXALHO3MqjCjgWhMOJnavR3vqRlH0GzT6y7J8900e7g38X/MeAZE5xytEW0xXlwY7NjrvDRmfP2uWbYohByDdfsXjcF2+tMAKrBORVqXFdDAXoqqQksKcCpn2kHecuYyexWLkeqmp0JmcIe0fGeccW9PYtJ9PZU7aB/PtGoRrr0OlQNBW1U8CAXmGIqgP2ZbksNlwz1/v+W5qa+6pscAau7L7BNn/f5mnZeHQXa7YQe/ubBv84f5dI8am9usDoeTns4sZq6bcV2nx5Tc2IKJM0sy65w1kKvGWSSl0eFhsGWtKGfsKoPRSJd0cHDa/OyNKbbkUd/8nK+uEPAhzEV6I0YIyqFw1Xf//rLPbHmkxvNiFqymlZc1a68+fNV6hlmL9ZlqZac78iFgn5HHCF5hUzpfdePVzlsqOZHRVcH9MDOYm4sHfEXouqhEQhGnzy7802thzve4nO6koS1W6OlcGQl385uVL05DPEE6IrnMZBT3s1+sEvzMgkyuJdJmquGSNkPaA95LqMleA7qlnef2PNSnQFOAsqKVsAAL6H40BxTNqq0SbSq01pV3AAHBCvEiELu6Vi775hLpTouoW5+qBMPExWOoE4UwCP6m/c19WdS695wzP2MbyMfMUBumnepU6FxKgfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(186006)(1800799006)(451199021)(26005)(6506007)(8676002)(8936002)(41300700001)(53546011)(36756003)(83380400001)(2906002)(2616005)(38100700002)(31696002)(86362001)(44832011)(66476007)(6512007)(66946007)(66556008)(478600001)(6486002)(5660300002)(110136005)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVsL0M4QVFRZlhObzRBdVFJZkpnVW96MkR5UXR4RldUYVpXMGpyekVhVU1V?=
 =?utf-8?B?RFBqSTVRc3pGNmMrT2tWMkhqVjRTV1NsM0ZaY0o4SXRRc2NxbWZmVy9KbG9J?=
 =?utf-8?B?ZFlmdXVkdGdHMnJwSUtmemxOeDNhd005Zk56cEc2Y2pDSHJwWENsd0M3cjJY?=
 =?utf-8?B?dmhiMFFSODN0dWNhVE1vOEpnNE9mRjczQ3JMaUYvSmFFdHltTVUwWVlFOEhC?=
 =?utf-8?B?RisrWk9TMGQ2RXNuTWxNTXBTenhSZnBrTjFXOUlVbGhGUGkwNE5PU0k4K2RB?=
 =?utf-8?B?OWErWU0rUzhxVzVyL0RoUkt0RDdva3VPTnNIalBmQXJvM2lHU2lDNDVzOVVW?=
 =?utf-8?B?bXd5WW1waUs1cERRRjhOa3g5Tk14THIwT0NBTjd4U3grenJvbUk5UHFTNW9o?=
 =?utf-8?B?V3l1Wkp5TzBsZlhWNlpzc2VjblFKdzR0SHZSSWJ6WE8xNmgweHB0ck1kZ1ds?=
 =?utf-8?B?UlVTeWY0dVd3MzQzeWxVSGw2UEl2TFYxM3ZVa2NXRW5lY1ppVDJGOFJPZDlH?=
 =?utf-8?B?MXNabWcvU2d0S1FNNkVwTnFyeDNkQklnMkZ1VU1UL1ZGWm9zUUFWbXVla21p?=
 =?utf-8?B?V2NaYkNLOTRpY1FobDVHaWxuNHk0NEZmcmhsbWxMcTdPTVFnYWZKejlSYnJF?=
 =?utf-8?B?QWRCdjJHUUl3MG1sa3F1ak5MOUg2L3NubnNSYkYxYmJMMFV2YzRodW5QUlVE?=
 =?utf-8?B?eDB5SzNCblp5OHV1NDRmck9EanRuOUc5NE04bFZNQ1RsSHdFUXBFRkJNMnNS?=
 =?utf-8?B?TDZOMHZjZFd0bkNkZ1MwaWdSWFJ6d0l3ejQ2R0tjcE5kZ05OV0lnaEZHR0dj?=
 =?utf-8?B?cWl5UW0vRFBiWUwzdjgxYXcwZk40SzVOZlRISjYzOVJRZFVmbEFQWExoM1Vt?=
 =?utf-8?B?djREMGpkdFQxc1ZXRDJUVlhtYld3R3R3N0cwYXRqZVFseGtpTUk4RWlMWGY4?=
 =?utf-8?B?dHRWMlhoNE15UFdMalN6bnc0L0Z3Z0Jib0ZocThCZkxvbDZjQm10RlprQ2w1?=
 =?utf-8?B?L1FDdjRQVDJ6QmFoeWNGT2xyWG1VUkd1bkVPeFV4SUlRTFRpN0QyQXBmaWJP?=
 =?utf-8?B?b2k0aE1Xbld3ODBqYkQ4VTduQ3AvRDczcjJHWHdUdW9pL2pEN2pzeVVadWdZ?=
 =?utf-8?B?NzJCTkVxL1dmYW5qam1pbTFCdGp4WXJXbHNKSWxIUHhlRURnUy95TklIVTVt?=
 =?utf-8?B?UVBTYVRRRENlMkZObEtseEE3RnQvUDJxRDRFRGRWZGIzd05CK3UrK1VJUFNS?=
 =?utf-8?B?MXZzNm4yQiszd1hRb0NTTENRL0NsRFI2U015Zzl1VmVobEpYSWVsVWVZYkNF?=
 =?utf-8?B?MDF1TldPeG9MYUlkMmNsVXFpSkhKL3M3M2JQdytkdS8ySzlqd25jWkovQS8v?=
 =?utf-8?B?Q2JIRE1yNy9IOVJQTjM0dWlXQXNYNVpEL1Z2a0x5MXphU2RUd2Z0b0JSSTNJ?=
 =?utf-8?B?K0ZBTHJCZStRUzRCUVB3ZEMzOE5rbVpTd2VHSFh5MTNqeHBzMkJ3M0RzYzl4?=
 =?utf-8?B?WEpURG95MzFnT0tHSGhYWlpOYVFrNXlzRlpIUkwrNHpRR0sxd0ZkVC9vTmdZ?=
 =?utf-8?B?dEZlbGpLeW8vUmxOSkEwS2pVay9sNzdlMmFlNklFWk1xcU1wQ2xmL01SZm9y?=
 =?utf-8?B?STBtSGdJbWJYTFVJakkwYzUyWVZQa1NTdVVxaWlMZUplK2hiQ0xMVVBFcm1P?=
 =?utf-8?B?UnhycHBsZi94MWVWWWM0anRtdXY4bDNOSlJkWGlpUFBvQURxWmQ1QS9pU3N1?=
 =?utf-8?B?L0dSaUd1T0xndEpVc2dzN0VGYTJZWlZHaU10b3NUVGZ3WU9aNHFwSWk5M3F6?=
 =?utf-8?B?MDM0Q0pFOTJRMVFwUjQ5Tkl3bWFDTmMyZC9IMzYreEVNaFJDc2hreGxMMFo1?=
 =?utf-8?B?dWtQNURVVURYTWRRRGZ6YW1JeDJXMFlWWVhWeWVic1lqcDd4cmxtMy8xOWtS?=
 =?utf-8?B?QWdrSHREeERpU01qVlJPUEE0cTRnQkNkQlVSVVpFRmV1QTVaTytVdG1lTk82?=
 =?utf-8?B?a1RSR2d1UVJvbVRDYi94ZHhlUnluSUtDZnIrRTB2RHRLMjVXNDZqcjRoaEow?=
 =?utf-8?B?NG1HRzk0OE1GWi9MM0xVM2RNKzVBZlBjY3psZjNSanZScmJVK25KZ2JLWkNo?=
 =?utf-8?Q?4u8NlQqTFJmYeNl49ceALDxCh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368a9e43-1d04-4c67-61f5-08db9a6ea05b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 13:26:53.1508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhfpdW2xYBW0kGonuhuvsfxq1XPWQPOry7PB5kKRDv8kTOmt1LX31KEiyEue7gNlxN/jb57BFYVFAxjRrq7zdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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

Am 2023-08-10 um 18:27 schrieb Eric Huang:
> There is not UNMAP_QUEUES command sending for queue preemption because 
> the queue is suspended and test is closed to the end. Function 
> unmap_queue_cpsch will do nothing after that.

How do you suspend queues without sending an UNMAP_QUEUES command?

Regards,
   Felix


>
> The workaround is new and only for gfx v9.4.2, because debugger tests 
> has changed to check if all address watch points are correctly set, 
> i.e. test A sets more than one watchpoint and leave, the following 
> test B only sets one watchpoint, and test A's setting will cause more 
> than one watchpoint event, so test B check out and report error on 
> second or third watchpoint not set by itself.
>
> Regards,
> Eric
>
> On 2023-08-10 17:56, Felix Kuehling wrote:
>> I think Jon is suggesting that the UNMAP_QUEUES command should clear 
>> the address watch registers. Requesting such a change from the the 
>> HWS team may take a long time.
>>
>> That said, when was this workaround implemented and reviewed? Did I 
>> review it as part of Jon's debugger upstreaming patch series? Or did 
>> this come later? This patch only enables the workaround for v9.4.2.
>>
>> Regards,
>>   Felix
>>
>>
>> On 2023-08-10 17:52, Eric Huang wrote:
>>> The problem is the queue is suspended before clearing address watch 
>>> call in KFD, there is not queue preemption and queue resume after 
>>> clearing call, and the test ends. So there is not chance to send 
>>> MAP_PROCESS to HWS. At this point FW has nothing to do. We have 
>>> several test FWs from Tej, none of them works, so I recalled the 
>>> kernel debug log and found out the problem.
>>>
>>> GFX11 has different scheduler, when calling clear address watch, KFD 
>>> directly sends the MES_MISC_OP_SET_SHADER_DEBUGGER to MES, it 
>>> doesn't consider if the queue is suspended. So GFX11 doesn't have 
>>> this issue.
>>>
>>> Regards,
>>> Eric
>>>
>>> On 2023-08-10 17:27, Kim, Jonathan wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> This is a strange solution because the MEC should set watch 
>>>> controls as non-valid automatically on queue preemption to avoid 
>>>> this kind of issue in the first place by design. MAP_PROCESS on 
>>>> resume will take whatever the driver requests.
>>>> GFX11 has no issue with letting the HWS do this.
>>>>
>>>> Are we sure we're not working around some HWS bug?
>>>>
>>>> Thanks,
>>>>
>>>> Jon
>>>>
>>>>> -----Original Message-----
>>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>> Sent: Thursday, August 10, 2023 5:03 PM
>>>>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-
>>>>> gfx@lists.freedesktop.org
>>>>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug 
>>>>> for gfx v9.4.2
>>>>>
>>>>> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit
>>>>> different because it needs to support multiple XCCs.
>>>>>
>>>>> That said, this patch is
>>>>>
>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>
>>>>>
>>>>> On 2023-08-10 16:47, Eric Huang wrote:
>>>>>> KFD currently relies on MEC FW to clear tcp watch control
>>>>>> register by sending MAP_PROCESS packet with 0 of field
>>>>>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>>>>>> packet will not be sent and the previous value will be
>>>>>> left on the register, that will affect the following apps.
>>>>>> So the solution is to clear the register as gfx v9 in KFD.
>>>>>>
>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>>>>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> index e2fed6edbdd0..aff08321e976 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>>> @@ -163,12 +163,6 @@ static uint32_t
>>>>> kgd_gfx_aldebaran_set_address_watch(
>>>>>>      return watch_address_cntl;
>>>>>>    }
>>>>>>
>>>>>> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
>>>>> amdgpu_device *adev,
>>>>>> - uint32_t watch_id)
>>>>>> -{
>>>>>> -   return 0;
>>>>>> -}
>>>>>> -
>>>>>>    const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>>>      .program_sh_mem_settings =
>>>>> kgd_gfx_v9_program_sh_mem_settings,
>>>>>>      .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>>>>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>>>      .set_wave_launch_trap_override =
>>>>> kgd_aldebaran_set_wave_launch_trap_override,
>>>>>>      .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>>>>>      .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>>>>>> -   .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>>>>>> +   .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>>>>>      .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>>>>>      .build_grace_period_packet_info =
>>>>> kgd_gfx_v9_build_grace_period_packet_info,
>>>>>> .program_trap_handler_settings =
>>>>> kgd_gfx_v9_program_trap_handler_settings,
>>>
>
