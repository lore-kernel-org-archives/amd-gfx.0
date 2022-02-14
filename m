Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83701C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 13:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38C910E43E;
	Mon, 14 Feb 2022 13:26:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E7110E43E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 13:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2oIanTw4WjZoRYS3t7oB2/Bpc9Ah/DUxE5cZRMFKSrklxOG54yo3/1f8BjQaj+tUehZijfje/fshCw76T00jsXXDcbzcde/5wCjv3BVqQDB7BfPzNgswsbcMPc8YffTUXrLRWxaVrm8xcem96PakV8NklpL3TtbXcrjvTybHMkwkZtcSLut5VzToB+w2B5XSC1efDqkVBo4mNlocmKuXfs3ir42FmMmkFCAPs4dIUH1joDawQ4voQH8qjwGoe6/gdbDmeMRgJnDZGzCIT3rc8YnLmT7vEf1wF+0AwbWsMkdK5460SMP8sTMZx2itQdJs5pfc0W0HP1yL4hVtqnXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guQu/uOCubsnroSpGCdWmgekf0YOEabQ58vOK+W4EL4=;
 b=X05RlAvnGyTtDxwSJHVLZC7t4JS+SnqBjzMPJqxbGO22YqPRaVA+r5BXMC+j2oVESE+5LmcqeHh6HtYBZK9J5rj82qnwHWC41fE9PJ7GtoBMJOGJLMRskD+kN7mhNRJSoehswR3kgbsgD3C3DMSsUDrhuFGiRu+wTY7cVdnHst4XNdhcvkQnNDmX7OKls2GvqDE3Mk+nPIs8SruASjH1zUn9shs5udLex1F7R3BN+/MYpvGZq8T/+YUVHcosaQOZR22z3n9RkYwfdzsOzs1GUEoP48MuMHZ2BL6LUOEGCLvhSzV+IyhwRR5fAysLxo3Lv/45MmASo4whUTkhWpUcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guQu/uOCubsnroSpGCdWmgekf0YOEabQ58vOK+W4EL4=;
 b=rb7bDmZWbIDWg/5o0b69Pvo3xLJWULszgvpTxkB93DmdMsTIoGpkwWSWS+cl2XIfXEnll0mBXAjz9DUxk2BmS17f3Ec4Ulve07NNCfhRpACiz7PyJHENHpb4UREIf7jEwWZE+zTDSQO3yxwFEEzIHBr8P4XaL+doKHJ6e4hbIXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3522.namprd12.prod.outlook.com (2603:10b6:408:9c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 13:26:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.015; Mon, 14 Feb 2022
 13:26:45 +0000
Message-ID: <0b655bb8-b09c-ec84-1966-b609184ba8ca@amd.com>
Date: Mon, 14 Feb 2022 14:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
 <3a99c1c5-0eae-74a0-58e9-3477387467d3@amd.com>
 <38f77045-7a4d-6d89-7cc6-9b1dcb6c24b3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <38f77045-7a4d-6d89-7cc6-9b1dcb6c24b3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8c9625-042b-432f-ca76-08d9efbda557
X-MS-TrafficTypeDiagnostic: BN8PR12MB3522:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35225B750C096DF7BE1D7A8D83339@BN8PR12MB3522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZMMotHSuZX6//jza5wblTK7xo+BnTYRsxdNePh9zHmU3i3hhqOdxvyM0iz9CMI49phiH3Kve6Tvv3vF3XRIpMHiytFcalzqFpBeT+efqBdgWvPfdmgF/XtCknYhbeYQeXYbscV/imI51K0h9zcJ36UK6fASXn/41ShqR1Z2iwvVacpT7+JmuhLyboqizZemcqhCXbhE3bp9CfUya3yGanVXTVOJUStSQQc3D9luS7clEeY4vqh4izVsGgWV0ZujO3H0KgFSqWNl1ClDFjZsVZsSftPYu7hPrpK689OI4NOQu19T1dkiewFui1oStgxriFhkkDBYDWUOzTQgMO4UXehQd3oH+SWGu+lLchKGhbnK2baxDSj51NxweEA7wYM8EiIUJb0gEtGnWezffpMXi1aE74KQgttq2JxiTSPtWAiLXkDLvyt6OxeChln870ciiB9OjBTeJ6qUcDkP/3uFSVTiUcxKUVpbgiqLJ53IC6MH9uwaTiQgduBeWfkinSbaSWW8ZRvk0/z/FEHlNFbJn+sLLU3cCQeKPeprH5BnC2BUQWOWPQhMDqHnl2a9UEYoggIdXXDLRzn0M779RJKc40aw92SRO8ew3zNqsmX2DhLJr0eteqSyTnVoOFoOcNd06gvLJtBznoqVH6W92LXQ4sH+wza5dNkEqEhCevXQkV+SHKh5fc7G+WHncy5YBN2/Oa8PWfp4qGSah7IQ2Xwp3N2eZgZwUG9pgB9MTveVAhQYFeCEhTtQ3IM1GbPzbtLB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(6666004)(6512007)(2906002)(86362001)(53546011)(31696002)(5660300002)(8936002)(83380400001)(6506007)(8676002)(110136005)(508600001)(31686004)(2616005)(6486002)(66556008)(66476007)(4326008)(36756003)(316002)(38100700002)(66946007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzNaTmhNYlF0NmlxNHR6R0QrWDZ2YVYxbWNHYkhHc0xINjBYOSthN01PRU1C?=
 =?utf-8?B?b2VYODVKWVpUa2NUSlpISWZva2crVTY5eithZjhxempmQzNNSXRERUZ3ZnB6?=
 =?utf-8?B?MnlDRkpPelZBYU5BVnVLVkxBd1ZNZzdwaXJ2Rys5eFlKWU1sWTY3a0tpSE5p?=
 =?utf-8?B?U3Zxc0lMVWdpWWwyVjF3QytIdXZKRUJBUnlTamI2N1FxWENDUktUM3Q5QmZJ?=
 =?utf-8?B?MFVScFE3UE9CdVJVSWpWUDVRcy9Ec0F1dkRPRXpMQmNLSkdMSlF1alBTTUFU?=
 =?utf-8?B?SjJqUU5kOVc4V1JHT3QrVzFFTDAvZXRGR29RYUgwYUIwRTRiNlFCSzJnV09t?=
 =?utf-8?B?QzJocEJXM2ZBYStFNWx6dU1Vb2pzL3d6RUI5VEhnVmNtMnBzeXlqditUYS9K?=
 =?utf-8?B?MHlUbml1ajdPQnJqT3pFNVozTjRnTDlKV3BjNWt0eUM2Z1F5cUJzTXA4ZFA2?=
 =?utf-8?B?SjhybnA2ZW9DS3lGamZuSjI3QldRU1U4YmxMYUZWam13aDhFVGNXWUZyYUdY?=
 =?utf-8?B?R0Q4NWlmZkVuTkZOa0wyUVEveDRqTTFTbGhZNUYwcXhUakJOK2VYRmpHM0Fj?=
 =?utf-8?B?MHE4NzAxMzdmQW9HbUJpN3R3akF5dDRYMXdUeVMzSllmTE5CbWxWS3R1QkZw?=
 =?utf-8?B?OUdrRU50SVh3MGs3ZXNMQm0wTDZnajl0L2dYUTZWbTBBd3drWU9wVjBlNEVB?=
 =?utf-8?B?Z3ZhbVpZQmhWcUQxVXlud1lhU050OVhKSWJIVHc2WnNrM1RNNS9iZmlDQXZN?=
 =?utf-8?B?NHB0cTFTbkZ1QU52bnFJOHpEYWJmMWF6UHpiRW9RLzJ6NFNLMmhqa05XMjRX?=
 =?utf-8?B?TldrbXc1MExzQTZyQkZHRHBxNDBydHYreis2R05PaUc0TzRsbTQ4MFkxWmk4?=
 =?utf-8?B?T0VHR3ZWV3AyeHFPcHIvVGdaVXBVL0R6WVA5eHlFU2k1M1JleDFoMVRjdDd3?=
 =?utf-8?B?RWlPZVY3UEtWU1ovK3hnWmlzMWswSy9kVVVsMjRxTW1VV1pCTlJ4cC9ZYTBp?=
 =?utf-8?B?WjFJTFA2VGVaazM4UHo4ZFpkOE9QNnZYMzRoUWVTZ09uaXZ4M3ExdFd4TllI?=
 =?utf-8?B?eTJSMHdFdnA2bEpCZTZ4UklCU2hLc01BTitzZkwwcTM0TTl3SmtyNVUraXJE?=
 =?utf-8?B?cUhPWW9sWnFKTHBUWk5ZRWdsTnc2TVI5bEppMFBWWGdXY1FIODZrL09hTFdl?=
 =?utf-8?B?bVYyZUpSN28rd0lkZkVjZEN4bVVERnR5b1U1VDhnZGtDdXZOTU95dzB6Nlk3?=
 =?utf-8?B?TlB6SU1Qb0NsNWdjbk5MSTFqc0ZVRWJzemZqWnl1RUtwRENTMTRQN3d4eTZu?=
 =?utf-8?B?KzJjajBXRVdjVjd4WlRKN3pGQ1JaZ2hWK2daNWpSdlJnUXJZVmRVY3hUSGMr?=
 =?utf-8?B?V1ArQkZKZEEzZUZJcW5iMm1FOHYxemRmbU4wSUlHMEtaanZ6T0NwemlDS0Nn?=
 =?utf-8?B?U2JUQzFZa0dlcUdDU1gwYnIwTEpmeTJHYWdnNWpNeEVBMHF3N0V5VVNrRmF5?=
 =?utf-8?B?b3JDeHB4dHJ1RnVXc1ZzaGJRbnVsMFRRQmZyVjNGQ2dxaVJSd2VkYWM2UzRE?=
 =?utf-8?B?YXB2VFpFVy9UUXZSTWtSOGlXcHlOakhFbXQxV3ByZWpjMUFuQXZGSHZZL0Uw?=
 =?utf-8?B?TjZxeEpuV0R2Zkl1QjF3MGJ1dk9lanRXTVkvazRBQjZnNWhzS0RKOEEzRWY3?=
 =?utf-8?B?VW40RnFEakFJdDVwSGhsN3pOd2l5QVVYbTFweUNtSmlOYWV0UG1zek9rMk1P?=
 =?utf-8?B?UVB2amNkTW5jVHM0UmlVMVV1Qmk5OUgyTGtQY0djNmo2dEVGYVZ4N1U1WjIz?=
 =?utf-8?B?bTlOT3FHQm1jOFl6MzExMDY4SzBCeStvMUk5MUNON1dJR043UlFJYUVEaVRQ?=
 =?utf-8?B?UGNqM01MR1ExQzNLZFJvZmVsTWJkS3lBbkcwdGNrTXVNOFNrZXY1cEFyV3RJ?=
 =?utf-8?B?ZUdKYkhiQ2Y1VFNCczdmQjRQYnY1T3IyRm1zSnQyU1dQaEhqYTdrSFVXUVNr?=
 =?utf-8?B?QjN0bDBjVVBGU2IwTlpGbmFUQjY0MU1RYWY4RUNaY0JGc3IvemE5bnAzZTZ6?=
 =?utf-8?B?Si82Rkw5SENMS1RCbERJWnE3WGRHbHNkUEN6YjNEOW5SU21Xa1RmL0xoRjM3?=
 =?utf-8?B?ZVBJTE5lWnQ5M1ZZclA4Mll5QmF2Mng0RTNRUWFwOEJHMSs1OG9WczFCU2Zi?=
 =?utf-8?Q?HsP6AWHoLB4UvDBRODLgnJM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8c9625-042b-432f-ca76-08d9efbda557
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:26:45.2893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk/XsrOt0AIpl5BTlOr9HVPfmP7f2TgoGQbas2EiNbEKSk4aZ+vShgQOmXbNDgjI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3522
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.22 um 14:15 schrieb Somalapuram, Amaranath:
>
> On 2/14/2022 2:59 PM, Christian König wrote:
>>
>>
>> Am 14.02.22 um 10:16 schrieb Somalapuram Amaranath:
>>> List of register populated for dump collection during the GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 
>>> +++++++++++++++++++++
>>>   2 files changed, 84 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..2e8c2318276d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>>>         struct amdgpu_reset_control     *reset_cntl;
>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    uint32_t            *reset_dump_reg_list;
>>> +    int                             n_regs;
>>>   };
>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>> drm_device *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..6d49bed5b761 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,84 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset;
>>> +    int i, r, len;
>>> +
>>> +    if (adev->n_regs == 0)
>>> +        return 0;
>>> +
>>> +    reg_offset = kmalloc((adev->n_regs * 11) + 1, GFP_KERNEL);
>>> +    memset(reg_offset,  0, (adev->n_regs * 11) + 1);
>>> +
>>> +    for (i = 0; i < adev->n_regs; i++)
>>> +        sprintf(reg_offset + strlen(reg_offset), "0x%x ", 
>>> adev->reset_dump_reg_list[i]);
>>> +
>>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>>> +    len = strlen(reg_offset);
>>> +
>>> +    if (*pos >= len)
>>> +        return 0;
>>> +
>>> +    r = copy_to_user(buf, reg_offset, len);
>>
>> Maybe better copy that to userspace one register at a time. This is 
>> not performance critical in any way.
>>
>> Same for the write function.
>>
>> Regards,
>> Christian.
>>
> I tried to push all list of register in one go, so that the list can 
> be overwritten/updated (every write makes new list)
> if we add one register at a time from user-space the design will 
> change to appending the list and cant be edited or updated, it should 
> be OK ?
> and don't see much use of **_read api (as we can see the list in 
> trace) i will remove it (debugfs interface will change from string to 
> uint32_t )!?

You misunderstood me, that's not what I've meant.

What you should do is to have multiple copy_to_user calls dumping only 
one register at at time to avoid allocating all that temporary memory.

Regards,
Christian.

>
> Regards,
> S.Amarnath
>>> +    *pos += len - r;
>>> +    kfree(reg_offset);
>>> +
>>> +    return len - r;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>> +            const char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg;
>>> +    int ret, i = 0;
>>> +
>>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>>> +    memset(reg_offset,  0, size);
>>> +    ret = copy_from_user(reg_offset, buf, size);
>>> +
>>> +    if (ret)
>>> +        return -EFAULT;
>>> +
>>> +    if (adev->n_regs > 0) {
>>> +        adev->n_regs = 0;
>>> +        kfree(adev->reset_dump_reg_list);
>>> +        adev->reset_dump_reg_list = NULL;
>>> +    }
>>> +
>>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>>> +        adev->reset_dump_reg_list =  krealloc_array(
>>> +                        adev->reset_dump_reg_list, 1,
>>> +                        sizeof(uint32_t), GFP_KERNEL);
>>> +        ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>> +
>>> +        if (ret) {
>>> +            kfree(adev->reset_dump_reg_list);
>>> +            kfree(reg_offset);
>>> +            adev->reset_dump_reg_list = NULL;
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        i++;
>>> +    }
>>> +
>>> +    adev->n_regs = i;
>>> +    kfree(reg_offset);
>>> +
>>> +    return size;
>>> +}
>>> +
>>> +static const struct file_operations amdgpu_reset_dump_register_list 
>>> = {
>>> +    .owner = THIS_MODULE,
>>> +    .read = amdgpu_reset_dump_register_list_read,
>>> +    .write = amdgpu_reset_dump_register_list_write,
>>> +    .llseek = default_llseek
>>> +};
>>> +
>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>   {
>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> @@ -1672,6 +1750,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>                   &amdgpu_debugfs_test_ib_fops);
>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>                   &amdgpu_debugfs_vm_info_fops);
>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>> root, adev,
>>> +                &amdgpu_reset_dump_register_list);
>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>

