Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCDDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 11:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD2A10E633;
	Wed, 16 Feb 2022 11:00:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7447410E641
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 11:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJkLLL16wf/Vly24qmw8ejcnuleajZW6TQhPyvW7I8U6Gg+Dv7Hjl4BRpvUMT5ZKHAmQMCoalJQhIyak/JmjiwsiHlCEu5IraL/Xuih+Cf4/VxdPC/utXwcsZnSF/cBfdMrbD54BvamEj2qigZza9oB7CTLqc3QMewgaMmwZdw5gt9k04/994D6t4m07ZyemfQRn3jNwHZx6T4i5NtCbot1UlqLiTDs60rdpcAeROjm79tmrS8Ywwfj4UNKREL7YYuaX2WlcCc9v703QNTTnP6NX3uHVOrCFylia0WxRo+I9HmQ5G6toQKbj5VPO+qVHmyCl5k6L/XwsXrp9SGm+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZTMUf7S1ECwR46+xORBAbiZj0FL5RfcnQk+g08t+Xg=;
 b=nwd0pyqL+L/sQcdV12bYQ29tYhLRL/cWHuGBjBuZEDy2Y+Oso5SrpTN6lkq4/vJNdc8lNyw6du7ro4Lvf8zmhOqrlit3YpnF4Om4f3Pfk5jIYdxbc5FkgK+PKlzByyiUVRf8YugazS5sCgFI8cIc2sCu2Q7mCc25xs5G/hmMO8GOYlKh3JcZM6FzV/UzSBg694hwjfgKAk7ZrblGhec2NrcSVyKN3ApN0EilM0m37Kw1PYeUt/J+OEcAAIiTd2ZuifWaBK5/6dMQNKNFX4gO0ryZzkWFyyI9xqlTXfpxkrT75xmxxN8+HjOTELqQlUrGtG1X6++PhEVmg2x8WMMVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZTMUf7S1ECwR46+xORBAbiZj0FL5RfcnQk+g08t+Xg=;
 b=Dv212F7DTnTFwtd0MqEXe/GnEC6D4Q4MWlvFeHsoqLiA9w+S9MkYhdv1LuoCo5S9ziz8yHu4/LfUjAPlu1TMKba0E8FZ3+UGt282lomVwYGHKaxsX+q8i4IGVTMmpe0mpMJKJtZr8mUFcVXHcl7barFtlz+5iGlCnsvr5Z5NsBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2554.namprd12.prod.outlook.com (2603:10b6:907:3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:00:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 11:00:37 +0000
Message-ID: <516bf6f7-3573-592f-b306-42098ffc42cc@amd.com>
Date: Wed, 16 Feb 2022 12:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
 <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
 <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93906359-9377-44c8-e2ed-08d9f13b9022
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554D28901210DE2ECD1F1A183359@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMrUimzOecBgEPRgRYd1ZTTP8gHO5sFGbCplLFAL7Y7i8xrRDCjiZnru3KoO8Qoiy2qfyuCN26kzPXmzXx9nEWL6SqdrqdjB5BEAv/Op+/1zEuaKJcSqxMwuaDhEucGAN9sZ2tGNzo7ZdsVkPKfw2vsVs37ZO+bOOGqUDTgKmeogbVnHCA+QTaPjdpWSmT60ZA8md7zFkPcqm4i8DIEegMvqXNSAigOi6f6/4RqA4KAj3b/pD7yX4Wni9l/LmMKiCfsjSjsytTCv+tpzaAYM+HOdZUVmmLMQ9SyI4s1HXCx2f7jfO/clM3vGJrZ1tHkf4C0lvUIRiLIj+JXqAq4jHMU7yIgjl92l9N8YSOUDotPKJWtqHZehvZe0rYMyYz7AwQ3d0jVIltFNFMf51Ef1SUX3+khC7Fg4w88kIB/p9BSQHOXBpSJzjmuNqA7Brf1fz4rbF9qTf+EYeAJIQwXL23TMdCnxBU39JuQXGGx8gOi1AUccZ4o5w3h4fhpcVwHRwBk63c45b7I+a6kQtvYE0tanf6Nu2RffLWarku25RmjozhkKI0dtKQiyt6zuqi5plkuIir7L336TCFsUysR6cvvDwYiBB1H6rFlrvSpIEFn02t32wh3SuEq1Ywa9oUD/7TOBneAQNXEsAe8h1z3orekIS3t6D3owfGQ112n6mYXYA/NNW0YKuloy6FupIxPEE55K1dJpfo8rAXbN/IsTH1EOcyrH+HVF84jYLu6vSZfkPH4kUIzzvtK6mZrxiCfR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(2616005)(5660300002)(66556008)(66946007)(66476007)(53546011)(6512007)(508600001)(86362001)(6506007)(186003)(38100700002)(6666004)(8936002)(31696002)(26005)(316002)(31686004)(110136005)(36756003)(6486002)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNmbU5hL3BZZ29XV1krT1YxVzBoV1JhM29TZGlFbG1TUnpnbmZvdmtvYmN1?=
 =?utf-8?B?VVlwV1RFeHcwSmt3c2NhRUhZNjMrc3ZYS0MxcG00dm1jcWZmd3hTVW9NUk1F?=
 =?utf-8?B?c1REOHUzdlJCUHAyRlNkYnlvanlrbWhpR0U4U0ZQWDJkWFVHYzJSSmdCaEEz?=
 =?utf-8?B?a2ZIUVR3T3VpbFRZVDdlajE0ci9Cdjh5anNUa1lkTXRKN3pRQUNtaEplUzJl?=
 =?utf-8?B?N3Rzbm5ETTVPZFBLUUswQWhZdmdjcmRyLzhaUWc5ZmhYVVJZOWg0UHRlWmZT?=
 =?utf-8?B?bERsV2RzdzdjZ3YvbHI4UUdiMmNnMDZsMnFscHg1SFljNGZyTWp5b0tudTRN?=
 =?utf-8?B?OGtUeUxyendCNlp4TXdJMWVnU29rbGFvRnNEY1NGNVFrcGJGVjYyTnR3dnFv?=
 =?utf-8?B?MTFpMkZqbzYzNkRLT0syZ1IzeC9hVHdYV05ZN09LM1RQWFdTWTRUSTM3NnVr?=
 =?utf-8?B?YjBpSmF2eUV2TitpR0dZQUZ5dThmcm1pRWozTkpBa2NWT1VjYm8rSm1KNll6?=
 =?utf-8?B?TGxKcFhIaElnOE5XcFQyV3QvM2lQbDZ2eWNGL0xmMVpncE1mdVBnK0pPZFhM?=
 =?utf-8?B?QkpQL1RQdDU4Q0VjcnRxdHAwZ2JYOUl1emJudlM0cDJRbW5EQXFkKzYxNHFa?=
 =?utf-8?B?WXhmMGg2YXFneEhvZUtwQmpKY2N5MVU2cjFBWUM3ZGFZMlBpSXhSeWhyRjZ0?=
 =?utf-8?B?T2V3ejJmMzZldjdic2ZVWGNPUENkVzE3dVJDeDdnMXFWSWszUmlRMEM3WlVj?=
 =?utf-8?B?NFBXLzluc0lTUWlDdy9pTGx4SWlkOWlpTkd0bVlJT0hEeEMvNE1nV3ZKWVZh?=
 =?utf-8?B?V3ltcWFjSUZPdnB3MVFMQ0RKWGZxdHhTWmtqNzF6WlA4U3lUY1BXK0hPNUw4?=
 =?utf-8?B?eG9tSFo2cSs0b1FFdURRWHVRMGszZzN1VHc4a29ERzc3bFFDazQ2VzloYXd3?=
 =?utf-8?B?MzViRGp2cnEvZVRHYmlCVmFGeXB2VE5vaXZwRG0xYUhpUGtTMmtQVXJrZm92?=
 =?utf-8?B?Z05yUlR4V0t3STFvTEtyNmtWZitESmhqTEpaL0lrNVN3LzA1d3hzdjRDenRt?=
 =?utf-8?B?SUpLWkVWYldzanJGSFh0ZktRMFJLbVlzaXJJM0tkTGw0RFB6YkgzS2tPRUtq?=
 =?utf-8?B?aUtiRVhyOTRQSHdUbDY5UzRnaExhWHd6M0tqTTcrMi9tUFB2NWVoNlI1NVpx?=
 =?utf-8?B?TmFqNFp6eFNhOWtJUWhQKy9Ja29pUDRtUTd2OTk3R0FiNDhRMXhocHVFcURk?=
 =?utf-8?B?eEExdHJCcys5bHRnS2xSNzFUZWJYeWhzOFhMeHNCeGNwazNQOElNaVhpODRi?=
 =?utf-8?B?QVM3ejVUK3p3dTRWSUxiRy9EMENmTHpwRmhTYm1PWWhPY2V0YTdwRFAxMWxs?=
 =?utf-8?B?TE1LZStFYXFIb2lUcER6WW5SNThwMlBDQU5ITWlyS2dvVFZ6NkFuRDJnaVBm?=
 =?utf-8?B?QWt1aVVGU0FNMnQvRzMzYkp3U1IxcXY5ZE9NajBaSXU2UGtRWVB2STRWRHln?=
 =?utf-8?B?SXNMdjhhWEUraFBBT0FHVVd1Mk9oa2w1d0pYYnJ6UytIbTFKcVRrMzVQTEdB?=
 =?utf-8?B?N3VobGMrMzZhbCtVSjE3U3ZDeWtsRFgzZ2ZDR251Qk1FSXY2RlVEa2VjT2lv?=
 =?utf-8?B?WnY1OHZDaXB4d0xvNTkvT0RQOU5Dd2UxL1BGRUxXUWhvUkhYRU5hUDBwckxU?=
 =?utf-8?B?WnBYRncreXdHOWtaVUw5dytySmNMN0Y4aWZQVXZrME93MnJyb2lpVjM2OE1T?=
 =?utf-8?B?cVdDa095MjViY2ZQc05wWGFHWDNod0E3U3lMU0RBcFF5cjdzZlVYRjN3eWUy?=
 =?utf-8?B?L0FwS0t1TjNFc3dERUZxdXgyTFA1dk5zbTVsUzFLdXQxYkFTNmNpMEpRdUty?=
 =?utf-8?B?b1hXd210bjJSTi9RYmordVRXb1lVWTZvQ1ZBcGFsaWZyekhiQ0QyeitsbUpC?=
 =?utf-8?B?WW5UOGFrUVVGK3ZOYjMrVGs1ZnJkVmxqVzFhQTNlWTlNR051SXNXM1lGSmpj?=
 =?utf-8?B?Yy9XMitSZHdJL2IzMEtsazZ0VUpMNXpkYkwrYzVKei8vbW4zSVJPVHVZZHZP?=
 =?utf-8?B?ZHZZWitPTmhBMVZXODR5SmpQOWl5ZVA5eC8wMGYzcjJEN3NqMlh4RWdsNVFD?=
 =?utf-8?Q?Duxk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93906359-9377-44c8-e2ed-08d9f13b9022
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:00:37.5861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vWIVi2haRq0nY2vWyJkZECIe+8QjDeC3IoeLxJop/LYR//sitYk4xqs74jsog5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
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

Am 16.02.22 um 11:43 schrieb Lazar, Lijo:
>
>
> On 2/16/2022 4:04 PM, Somalapuram, Amaranath wrote:
>>
>> On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
>>>> List of register populated for dump collection during the GPU reset.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>> +++++++++++++++++++++
>>>>   2 files changed, 100 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index b85b67a88a3d..57965316873b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>> +
>>>> +    /* reset dump register */
>>>> +    uint32_t            *reset_dump_reg_list;
>>>> +    int                             n_regs;
>>>> +    struct mutex            reset_dump_mutex;
>>>>   };
>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>> drm_device *ddev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char reg_offset[11];
>>>> +    int i, r, len = 0;
>>>> +
>>>> +    if (*pos)
>>>> +        return 0;
>>>> +
>>>> +    if (adev->n_regs == 0)
>>>> +        return 0;
>>>> +
>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>>> +
>>>> +        if (r)
>>>> +            return -EFAULT;
>>>> +
>>>> +        len += strlen(reg_offset);
>>>> +    }
>>>> +
>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>> +
>>>> +    if (r)
>>>> +        return -EFAULT;
>>>> +
>>>> +    len++;
>>>> +    *pos += len;
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>> +    static int alloc_count;
>>>
>>> This being static what happens when it is called on a second device?

Good point. I've totally missed that.

>>>
>>> Thanks,
>>> Lijo
>>>
>> I tried to avoid adding to adev. It wont work for multiple devices.
>
> Hmm.This is not friendly for single device also. Some one could just 
> parse a text file of reg offsets and do
>     sudo echo offset > file
>
> This will overwrite whatever is there. Instead you may define a syntax 
> like
>     sudo echo 0x000 > file =>  Clears all
>     sudo echo offset > file => Append to the existing set.
>
> Taking all offsets in one go may not be needed.

Yes, completely agree. Now that you mention it the code here is severely 
broken in quite a number of ways, but see below.

>
> Thanks,
> Lijo
>
>>>> +    int ret, i = 0, len = 0;
>>>> +
>>>> +    do {
>>>> +        reg_offset = reg_temp;
>>>> +        memset(reg_offset,  0, 11);
>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>> ((int)size-len)));
>>>> +
>>>> +        if (ret)
>>>> +            goto failed;
>>>> +
>>>> +        reg = strsep(&reg_offset, " ");
>>>> +
>>>> +        if (alloc_count <= i) {

The alloc_count variable and this check is completely unnecessary.

>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>> +                            adev->reset_dump_reg_list, 1,

The memory management knows internally how much memory is allocated and 
when the buffer needs to be re-allocated for grow.

So all you need to do is is "array = krealloc_array(array, i, 
sizeof(*array), GFP_KERNEL);"

Regards,
Christian.


>>>> + sizeof(uint32_t), GFP_KERNEL);
>>>> +            alloc_count++;
>>>> +        }
>>>> +
>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>> +
>>>> +        if (ret)
>>>> +            goto failed;
>>>> +
>>>> +        len += strlen(reg) + 1;
>>>> +        i++;
>>>> +
>>>> +    } while (len < size);
>>>> +
>>>> +    adev->n_regs = i;
>>>> +
>>>> +    return size;
>>>> +
>>>> +failed:
>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>> +    kfree(adev->reset_dump_reg_list);
>>>> +    adev->reset_dump_reg_list = NULL;
>>>> +    alloc_count = 0;
>>>> +    adev->n_regs = 0;
>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>> +    return -EFAULT;
>>>> +}
>>>> +
>>>> +
>>>> +
>>>> +static const struct file_operations 
>>>> amdgpu_reset_dump_register_list = {
>>>> +    .owner = THIS_MODULE,
>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>> +    .llseek = default_llseek
>>>> +};
>>>> +
>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>   {
>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>       if (!debugfs_initialized())
>>>>           return 0;
>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>                     &fops_ib_preempt);
>>>>       if (IS_ERR(ent)) {
>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>> root, adev,
>>>> +                &amdgpu_reset_dump_register_list);
>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>

