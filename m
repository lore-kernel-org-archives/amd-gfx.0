Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8E9EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 16:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAEE10E5C1;
	Fri,  7 Jul 2023 16:44:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F0010E5C1
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 16:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxs0PgHOOIe7Tkd+Vi47R+8Wb5rWoSNVZeLc77lS/pjiCcKNjJ80H61MN75gEx7kjvg6lUkhXDoDAxW0NzjNKvFU+I/U9LiIWy57EtkQHsGMfnSq+eLVqyw9oTfKoa90a8e/Gi6U5M0WDxxb45RxaZi37bJ3bVPgA9ndyHN6r25mYi+8dM0X75RLoVBOP4f0+QcOc3M0QMU+CYktL4aXBDYgMMZ4i0MbLFjAhbUO8uUh6m/p3bTU3g2jsBHDbWeO7J9PVG7JAxjJfWdnNNL9TE96O7T9Jft8yErujtHP5S3gCY6imPJSrPh6ZV/xa39VV7baakJor4CXNuoosmfgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFi+UzJB8SapsBKeYQpa0ZJz21DhL2uSgPfE5JBx9Zg=;
 b=i8UeEhiRd959lqdRgDehEYZG7vj6/k5FtB4yMn8g3hDE45uqWxG3jubkNSdL0BkpezKhpxSGWQqx+RF4mF4bLo0MgUriy5zdMW905LXNGij+LoCpsFZfoWNmR49U6y3L0RmkAUWxYK8fsELUR0zaMl0FPIr0BIzZGJzKCmBh+oRHe4CRoBy1CgtVLmDtHT9TKiqvXCKp5wMJr1FLRVK6IGWdZ4APcN5/axgxeyxLI0hhLYVl4VkUHxM5duGgdlkdBETsjgM1+F8m9i/II+rMsNTrwybB9ENyrgZFSX/gyxuVjDgodYO6meGCbaKw22peU0/0Rw56R4t8GR6nYGwAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFi+UzJB8SapsBKeYQpa0ZJz21DhL2uSgPfE5JBx9Zg=;
 b=1OidVdrRFuxkLuMw3Td7g75/S/7aEWjRO+6NhlEvJa6cdAf5VOYjQ5BVZWY3SE2v1yuc0Tv1I4MKK5M+Ai/EbTZEWuILTu24wji9MFb7O7xEOQCNz14UDFl5ZVav6d2raeJEYfMXeo5VcGQY+QPJKgaZVk89/30XXZnWc4KT2b0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 16:44:03 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d798:c26b:8d50:aa2c]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d798:c26b:8d50:aa2c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 16:44:03 +0000
Message-ID: <a40f3ad8-cb5e-328a-32d7-b26b827fdfe8@amd.com>
Date: Fri, 7 Jul 2023 12:44:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-5-jinhuieric.huang@amd.com>
 <CY8PR12MB74359A316EAE92978FA47386852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
 <ab49d1db-c386-993d-67d5-b638dad121f7@amd.com>
 <CY8PR12MB743593DCD12B8FF748849A92852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CY8PR12MB743593DCD12B8FF748849A92852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:408:eb::9) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 603b40de-e07d-42fa-8b6d-08db7f095f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0afART8dzz8t27ZM3zi6GEEUOcTfNBBMFFOZ5a0M2gm2NFZoVNGKUT5VPwpdWStSZ/xMQE7rvESzxwDTR9ryQsedVrmRsRoCMDpW6Ibru90TwHevI++q/o6eKy8LFWp83WyJMVzdUCYgzIOxsYA2a02aM3Bt7IFwQslo1b2SnS5S8djOJF88Wkgph6tX/65TUrhv6AYKPZarNTL7+JcuWVimwLtfH8ozOEAjjylCxMt9zpZtwTNVRHodmnppatUouN6/N2ZtUTlJnbtYiahxb1R8OZZpR/nMQkorotxBjInwRVAriUn5AWgEiuJ4sSl+sZxcwd7XeCBPysvtqTwE+95xxfn9rz5YAuwiXJUxwVMSUlweuZO0wk+9+eadJ3cfHlqDVXntDLK4ScaN7FXt2zJRnK0pLCsebRvet0trHtySJKPCpntLriomISRyLbUGRZ2t5jVygO+TH54LEolgxlKAjWKOog5HtBJ69cvq44FgDkN58d/kDY1zPQe5WeRYiuFdT9jvL5wV/EFK+yGzs62QU9M4+FMJMFqQ6Vv2BQqCyUZomKlC8j1KkSJMqMLPApCbMPd4bPGM13AXkoCyXnNKdroQ6V+eXqEDQFH2eWlCu021ckW1dhmF7Nbp3Pio+6l9GOiArfHnJIarU22fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(6486002)(478600001)(110136005)(5660300002)(8936002)(8676002)(36756003)(2906002)(31696002)(38100700002)(66556008)(66476007)(66946007)(4326008)(316002)(41300700001)(26005)(86362001)(6506007)(83380400001)(31686004)(186003)(53546011)(2616005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um8ydWNua3pqckh2UGsxb1N3b1VkcWM2UlduNHFvRi9Sd2ZqelpleFN2TWlF?=
 =?utf-8?B?alZEdEJJdXpUTmN6ejUwZUxPSzZNcC9aYzBDbkg3MWZpQmJybVUwa0MzZ2t0?=
 =?utf-8?B?azBETUNIMk85ejd6SHFMMGJqZzFVWHkweEtiTExOdEt2Mmx5dXN2RXREY3R3?=
 =?utf-8?B?WklSNEVPQ1JLNWpUQ29lK3VydzlWcTArY0VMR1RlOGkrUVAzOU56V2I0aW9V?=
 =?utf-8?B?WUx1bUhOYUg3QW82RHMrSGZTSzhHQjFaV0o2YkxDS3hPYkZZc1ora3FCdWNa?=
 =?utf-8?B?Rm5rZm5IdFJpNXl1dnFBRE16RS9Rd1VpRFJ3QnpoOEZ6MXY2VlZ4Szk1VWJk?=
 =?utf-8?B?bzZpbXh0ODV1eENSMklFQUFnTk1nYlA1M0RuZUFtSnhCbG1JR3Z6d3hGcXhG?=
 =?utf-8?B?aFkzMVBGY2Z0Sm8yS2FEYTgrdlh6S29oc1NrOS9qSXk5c2hkYkFIb1RRT0ZF?=
 =?utf-8?B?eFhPbFZMekFpaDNDc25rTzRmakhCc2FVWHRqeEhxOURkUktjR2xvYnZENkxz?=
 =?utf-8?B?OTdKWGhNT2tRTXdOK053SFZmdTJDOEhPczh2aUdhRCt3SVgzNWNadDNTOUJi?=
 =?utf-8?B?cFlxNE9oMWFtZklJWUNTdWdPdG5Dc2VsNFRkUHlCTWs1MkRnc28zTldPQ21o?=
 =?utf-8?B?SnVuOHoweHc4NEMrMmRoaW12ZWxvV3NLd0MrRFBJWGpVT0pUT1duL3cvaG5M?=
 =?utf-8?B?OGpqbDNKbE9xZGxNR1pqelM4bWpSSjBFRlZmLzRYdzg4WCs0SlNwV2RtVFRU?=
 =?utf-8?B?U1IzQ3VHUVlzRFcxdmRuZ2tQT1VJZHp0TmR3MSsxeENaUHJWOGhhdG1oQ1di?=
 =?utf-8?B?TStkNlMzbmhqNnhBZkw4SUZidWtIcllkdDY4THViTXlaZlN0ZW4vYncweWt2?=
 =?utf-8?B?OXFNOXA2VEhLWXBWdlRsamo0c1JVdDJQQk5FUFJacllhME5KR1FUVFdhTU1m?=
 =?utf-8?B?SGFUVUhVbnRxQjVBZ1BaTVhaOWpVYzNFd3ludHlDdWtydXRSSGFGTkp1allF?=
 =?utf-8?B?NnJoRVlObm9XaEtjKzd0OWI4V1RzV3U1OFlGY0xRZEl0VnZFeU9pTjhaM1V0?=
 =?utf-8?B?R056MCtqOWs5MnFkQkhaUnpWRXVrNmhvZ25MTE9iM3U4V1RqdFJieWVuSDZB?=
 =?utf-8?B?T0RtZmc5QytmMGwxNEc1YnRwRzlkR05MdTdtWlpabHF4OGc5MTl4NDl0MWww?=
 =?utf-8?B?c0FHTlRUZS9vY1ZqV21JOU0zenJZSldFVk4zcml4bGhJcFY4WnFaVi9BSUZl?=
 =?utf-8?B?RUw0dmQyRjhURWhaeVFOVG9nKy85SXZ6QXdhdURGaVFFa1ZYT0FXZUwzbzJD?=
 =?utf-8?B?UVZHemlqYnhKK1BZL2xVV2F2M3RCeE4xMGVHcy9QR2g3dFhONFJHQVQ5UVV6?=
 =?utf-8?B?RmZmSEtDL0VwTTRBMFVET1RqWkxaZ3J1K2sxV3V1L1RpRm9CNlYrL1JYV0tj?=
 =?utf-8?B?eXJxcmxKK3pHSHhqZjdDN1JzV0Q3R1lQMW1wRStkaDJsZ0JkVzJyc0lYSlZK?=
 =?utf-8?B?YUo4YUJpRmJBNkRTTFZzaWxINDd6UkdNaFdadG1HaHdjWmxjMkt3UW1pVVZG?=
 =?utf-8?B?ZVBWSnhGMFZJTFZ6dXBCTWZ5UlAwSVFiTmZ0d3VNZGlncDNXaERFVThoSkJt?=
 =?utf-8?B?OGtUTEc1TXZqYjQzYmpybzNHem5FVFg3cFgrcUJTMUQ4STQwNUFUY2NyR2l1?=
 =?utf-8?B?ZkE1d05MMlZ5Nm55SElDdElYU0FlZjVsQmUzWm0vTWRxVXlUT2JYUFdXd0hX?=
 =?utf-8?B?UUJnSTl2SCtUZ0JoSG4zTW43azZndWE1bFRZNUhudTIyQ2xKRDBiV0tMQnUx?=
 =?utf-8?B?UENUd1lLZDRxaTRuSXRYN0J1NW9sTW1kT1BoRWNESTVuUGQ1VWQzZ3g1QXlX?=
 =?utf-8?B?MDVXSG5PZ1NKSlVlVFI0S01BSVVYS21PWnpTVkVGc0FMU2lTc25UV0Uvd1Zw?=
 =?utf-8?B?S3JZMStWSEl3NzFSU1Z0cmVjVGNCbGcvL0VVN2xFKzJ5ekFXL2hLRkNUd21N?=
 =?utf-8?B?SUF1eXhQcW9LdEorOWphK2N1ZWlEYmNZalFnSVBldjdCWmFiandSRC9lUXFH?=
 =?utf-8?B?dG81SGhSYnJoTTB5czRNMUhubHUwWVd1TkNHQm51MmlpaS8yTHRmMnhseGVr?=
 =?utf-8?Q?vxDbvHaBjUqugPrQVz6UFPHDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603b40de-e07d-42fa-8b6d-08db7f095f27
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:44:03.3499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kvd8iRMKWiHLEAmqnpJbkVAJ/xqpVXb84e27APvRX4+p+lynx0I5ycZtCrYuytz9evTzq7Yt9cDojXy17ejxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-07 11:56, Kim, Jonathan wrote:
> [Public]
>
>> -----Original Message-----
>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>> Sent: Friday, July 7, 2023 11:46 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
>>
>>
>> On 2023-07-07 10:59, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>>>> Sent: Thursday, July 6, 2023 2:19 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
>>>> <JinHuiEric.Huang@amd.com>
>>>> Subject: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
>>>>
>>>> each xcc instance needs to get iq wait time and set
>>>> grace period accordingly.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>> ---
>>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++--
>>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>>>>    .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 32 +++++++++++-------
>> -
>>>>    .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  9 +++---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>>    5 files changed, 32 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> index a2bff3f01359..0f12c1989e14 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>> @@ -1606,6 +1606,8 @@ static int set_sched_resources(struct
>>>> device_queue_manager *dqm)
>>>>
>>>>    static int initialize_cpsch(struct device_queue_manager *dqm)
>>>>    {
>>>> +     uint32_t xcc_id, xcc_mask = dqm->dev->xcc_mask;
>>>> +
>>>>         pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
>>>>
>>>>         mutex_init(&dqm->lock_hidden);
>>>> @@ -1620,8 +1622,11 @@ static int initialize_cpsch(struct
>>>> device_queue_manager *dqm)
>>>>         init_sdma_bitmaps(dqm);
>>>>
>>>>         if (dqm->dev->kfd2kgd->get_iq_wait_times)
>>>> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
>>>> -                                     &dqm->wait_times, 0);
>>>> +             for_each_inst(xcc_id, xcc_mask)
>>>> +                     dqm->dev->kfd2kgd->get_iq_wait_times(
>>>> +                                     dqm->dev->adev,
>>>> +                                     &dqm->wait_times[xcc_id],
>>>> +                                     xcc_id);
>>>>         return 0;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> index 7dd4b177219d..62a6dc8d3032 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>>> @@ -262,7 +262,7 @@ struct device_queue_manager {
>>>>         /* used for GFX 9.4.3 only */
>>>>         uint32_t                current_logical_xcc_start;
>>>>
>>>> -     uint32_t                wait_times;
>>>> +     uint32_t                wait_times[32];
>>> I think wait_times[16] should be sufficient.  We only get the hamming
>> weight of 16 bits for NUM_XCC and I believe the xcc_mask is declared as a
>> uint16_t in the KGD portion anyway.  We may as well align to that.
>>>>         wait_queue_head_t       destroy_wait;
>>>>    };
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>>> index 401096c103b2..f37ab4b6d88c 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>>>> @@ -374,27 +374,31 @@ int pm_update_grace_period(struct
>>>> packet_manager *pm, uint32_t grace_period)
>>>>    {
>>>>         int retval = 0;
>>>>         uint32_t *buffer, size;
>>>> +     uint32_t xcc_id, xcc_mask = pm->dqm->dev->xcc_mask;
>>>>
>>>>         size = pm->pmf->set_grace_period_size;
>>>>
>>>>         mutex_lock(&pm->lock);
>>>>
>>>>         if (size) {
>>>> -             kq_acquire_packet_buffer(pm->priv_queue,
>>>> -                     size / sizeof(uint32_t),
>>>> -                     (unsigned int **)&buffer);
>>>> -
>>>> -             if (!buffer) {
>>>> -                     pr_err("Failed to allocate buffer on kernel queue\n");
>>>> -                     retval = -ENOMEM;
>>>> -                     goto out;
>>>> -             }
>>>> +             for_each_inst(xcc_id, xcc_mask) {
>>>> +                     kq_acquire_packet_buffer(pm->priv_queue,
>>>> +                                     size / sizeof(uint32_t),
>>>> +                                     (unsigned int **)&buffer);
>>>>
>>>> -             retval = pm->pmf->set_grace_period(pm, buffer,
>>>> grace_period);
>>>> -             if (!retval)
>>>> -                     kq_submit_packet(pm->priv_queue);
>>>> -             else
>>>> -                     kq_rollback_packet(pm->priv_queue);
>>>> +                     if (!buffer) {
>>>> +                             pr_err("Failed to allocate buffer on kernel
>>>> queue\n");
>>>> +                             retval = -ENOMEM;
>>>> +                             goto out;
>>>> +                     }
>>>> +
>>>> +                     retval = pm->pmf->set_grace_period(pm, buffer,
>>>> +                                     grace_period, xcc_id);
>>>> +                     if (!retval)
>>>> +                             kq_submit_packet(pm->priv_queue);
>>>> +                     else
>>>> +                             kq_rollback_packet(pm->priv_queue);
>>> In the event of partial success do we need to roll back (i.e. resubmit default
>> grace period) on failure?
>> The function pm_set_grace_period_v9 always return 0, and it is not
>> complicate operation, it should be always successful. Partial success
>> will not be the case we should care about at this moment.
> There's a roll back logic already built-in prior to this that's now only partial with this patch.
> Either way, after a side discussion with Mukul, it looks like the CP register to set the default grace period is done by the master XCC per partition so we'd can just stick to the current way of setting the grace period as long as we reference the start_xcc_id correctly on read and write.
The start_xcc_id is not defined in amd_staging_drm_next. If we assume 0 
is always the first instance number, the instance parameter in function 
get_iq_wait_times and build_grace_period_packet_info will be not needed.

Regards,
Eric
> Plus the suspend call will set the grace period per partition, so the wait_times array wasn't required in the first place.
>
> Thanks,
>
> Jon
>
>> Regards,
>> Eric
>>> I believe the default grace period is put in place for better CWSR
>> performance in normal mode, so leaving fast preemption settings on failure
>> could impact performance.
>>> Thanks,
>>>
>>> Jon
>>>
>>>> +             }
>>>>         }
>>>>
>>>>    out:
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>>> index 8fda16e6fee6..a9443d661957 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>>>> @@ -287,7 +287,8 @@ static int pm_map_queues_v9(struct
>> packet_manager
>>>> *pm, uint32_t *buffer,
>>>>
>>>>    static int pm_set_grace_period_v9(struct packet_manager *pm,
>>>>                 uint32_t *buffer,
>>>> -             uint32_t grace_period)
>>>> +             uint32_t grace_period,
>>>> +             uint32_t inst)
>>>>    {
>>>>         struct pm4_mec_write_data_mmio *packet;
>>>>         uint32_t reg_offset = 0;
>>>> @@ -295,14 +296,14 @@ static int pm_set_grace_period_v9(struct
>>>> packet_manager *pm,
>>>>
>>>>         pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>>>>                         pm->dqm->dev->adev,
>>>> -                     pm->dqm->wait_times,
>>>> +                     pm->dqm->wait_times[inst],
>>>>                         grace_period,
>>>>                         &reg_offset,
>>>>                         &reg_data,
>>>> -                     0);
>>>> +                     inst);
>>>>
>>>>         if (grace_period == USE_DEFAULT_GRACE_PERIOD)
>>>> -             reg_data = pm->dqm->wait_times;
>>>> +             reg_data = pm->dqm->wait_times[inst];
>>>>
>>>>         packet = (struct pm4_mec_write_data_mmio *)buffer;
>>>>         memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index d4c9ee3f9953..22c4a403ddd7 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -1400,7 +1400,7 @@ struct packet_manager_funcs {
>>>>                         enum kfd_unmap_queues_filter mode,
>>>>                         uint32_t filter_param, bool reset);
>>>>         int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
>>>> -                     uint32_t grace_period);
>>>> +                     uint32_t grace_period, uint32_t inst);
>>>>         int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>>>>                         uint64_t fence_address, uint64_t
>>>> fence_value);
>>>>         int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
>>>> --
>>>> 2.34.1

