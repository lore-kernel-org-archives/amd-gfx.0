Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CDEC61D97
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 16:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A2310E16B;
	Thu, 23 Nov 2023 16:07:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F98D10E17B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 16:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwJjuDo/qrQgWNHss/Y3AHYcQBucBjjrMOF793yABI6SKQj7wU1zCXXutspnQmdTmf/gsTTxP5H7s2mXOCkt4+NvzncWypZe8PaUQgFL/00Zk66Ht6upng5QJUwQidsnw3ysRsH/3kWaRYnodh0MR67H7AsJZcXweqGYU98BG/iDPu5YARbgBrMMPvIbgStKRVOlQPuPZYrb9cVusJuFYvZmBH7GypLo54QILfozy8pVATpu7YF370IZ7taTEB0Paq94HSAYfi57vgsDu0pOuJE/AyX4PaItTvuKCorYW/DA3VB1qmUKI0Wtd5wAijn1LcsLbGBrpoBUHab4v/NVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp95uvm2iinMHKZF52/JAhcQfsemhGnHbjQITVxJ9ZQ=;
 b=i2EUDcffG/PRuLGyzizgblV6BPpagAaH6CEgoXpbX3yM2iJ+TS2E1o5jlh556MpeUPwi1dS0DzIog0FGMdi0hDWEcgQNzw2RZ/y/4j7rYNX9+Xk8ML/viuPFkdILUbYWH+qsWU4WcvmZBFaSyKlj/0r1Rae6kxHCFh1LL0WrLRhG9DmHQpi6VBmqpvSU4lzttHslDEcxgzxo2mFMUqS1bdzABZRQAGwK60jmm5A+s4ldcwM5+ahuTsU49abK6eDtuBohTSIyE5nJ/xJ2QcD7adOiPN14pFEtByO1kmuB6lqrCv5n2JzejSG0ykFTwr3UvYXYwfc6BHqHYO+TowVTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp95uvm2iinMHKZF52/JAhcQfsemhGnHbjQITVxJ9ZQ=;
 b=5bOsG1cof4uNiruafgh/LNfz/jBTFQtv/StU8phMde1E/WW4eML0TRmeJMFoQxdBwTetcXo6t4endsp1282OZm3aqbs3vCgBvfel4LGQZrEQGhha9gELvB3uSkLZpGVV0j+sjo57bZkjgcjEoQepopu3IZRatzxwUU1M4nJu0rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 16:07:03 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 16:07:02 +0000
Message-ID: <d70e0aba-600c-4014-a7f2-79ba553f6a62@amd.com>
Date: Thu, 23 Nov 2023 11:06:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] drm/amdkfd: add pc sampling capability check
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-24-James.Zhu@amd.com>
 <f58f8c06-ff76-4d85-9116-6f63f22c29e5@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <f58f8c06-ff76-4d85-9116-6f63f22c29e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::32) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 787d18e1-d927-4cf0-2a30-08dbec3e3ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83E6k+LPCaN5WA0q+FMz42079qE1OIntFbzUyNYITkqNNM0dCU8TT/sAB5QkuGmxHplN6OKDxqfh87Z7B19Glm6WVxr4YVcqogXppM4sD3tTMdYNWB/BzqiueooKQ/N8510mF9dUzQt57RjlX/05yn677/iVUsbciIGHyZLI5JKvLkd3NmP6U3NB+TUE0Aj0nzdBxmLENC8CLSOdD/Xhne+plcmNLUfM7Cdlyy4Bz81RaBBG0LTdjTqhe9mPGf8XBzJuuahiU+IHq8sNTmp1xFpP3kLwF9ldlIpa1zqDkrJA4mp/gyGMtt4FTzCzQhjEUUdaT9nLy5eU9/ZTin81itIO8YHd3O4INAJPBp2w0C5aVB7/PEc2pDliO03zpe/9xrMPjHCpps2SJeAJ5MZBn1iBZhSiPsquqG+rTKAAqfJipym6l6E5cxOywTsA+O/R1S4TfNnC5b1CE8x+e4uu3BwxL8C++wBRajnsHTMzCrJwDWVCfsucp63TJGbJhvmXWH5wwVYZE+6LHdmJ09tzvNW/meIL93ZeDmWLQDi+7cGpB0b+s7JSBr7qTc0kqAmpgDF8hDneYQRgEv3EJ3F2YbrivmskZ4Vf3bKysgK37Apm++9TbKEzBbkHvXwvtl5uwDYNkWFYgBpnr7/heKs5HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(4001150100001)(2906002)(4326008)(8936002)(110136005)(66946007)(316002)(66476007)(66556008)(31696002)(36756003)(41300700001)(8676002)(6512007)(26005)(6666004)(83380400001)(2616005)(53546011)(6506007)(36916002)(31686004)(38100700002)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFZTytHRkErZjcxVzU1Qm0vbWN6bUpuZk1jenpyYjdXWVB3WGFUM1NpQUdQ?=
 =?utf-8?B?NzFUV1Z1czVJalNaSDU3c2dEaUFqdUFpaCtzdVpUakc3a2ZTOHM3dWprdTIr?=
 =?utf-8?B?SUUvRUlocCtGTHdKMHB1MzQzam9NTFExcWdVTXRGN2dqTjRaWXY0NUtmSmtD?=
 =?utf-8?B?dXVycGVsalNULzJFMmZIY3BzSWNRczdZSmw4TTVkbEtIQmlFbEwyWGpmbURV?=
 =?utf-8?B?aFFwN0hseU5HM1N0WUdoOVMrZnA0bGh0UDVsak5SemFkYThyb0o2cVQrOFZX?=
 =?utf-8?B?cmZ2R3YwU0ltVzhYY1ZzNzNvTUF3aWZZRVBaWnFLUEJxaXFmZnVBWVM0ZzIy?=
 =?utf-8?B?c3VBeUszTFRlT04yV05TMURPeDlCL1NjeU5IckhQYjMrN3hHVkVLV1hwRFZa?=
 =?utf-8?B?MnNWN3F0MnE3L21nTW1KeVR3ZjhJbnJtdzhLRnNiaVF0N21tZjl2RDZFOWFR?=
 =?utf-8?B?N1VlNDVhbmVUbWdNeSs3VDhhK2I0VEpHWVdaNUhqdGoxYnYwbHc0bHNzWkhK?=
 =?utf-8?B?MThTd0x2VXNxNFFxRHFFUlR0Q0p1ZjhWQk5vUVZMdzJxYVlYUitmaHJFZGtX?=
 =?utf-8?B?YVJCNmR0cWFrd2FENVllTVh5K3l6MW9xVFRSSTNYclF4OVlKWDZsZnZRckxG?=
 =?utf-8?B?WURiZWczRXhKcHZjTWNtemdicjhpVkZkY1QxV0hSYVB0SzhEZHgwYnpERGFp?=
 =?utf-8?B?SHdGYlhtOFFIN2hoRkNxanhtUzh5M1JTNkJwRmhrYi9vc1NXdVI1RHJWRVk3?=
 =?utf-8?B?WDNORFp5cnpFVkd3cGNWNWVrTjI0QnQrNHY2dTFJT3p2QWhacnI0U250REV4?=
 =?utf-8?B?bVZGQW9kbUdZWm85TjRQZldGSjNVYXI0cEdqRVBVQ0FVdkVRa0ZvT0MzdXVm?=
 =?utf-8?B?OHhJbUVGTG91TmhXNVJCazQxUkpKb1EzQXlHbWtDdWphTW9Ib01naXBhdmZ2?=
 =?utf-8?B?MG5Ib0FlaE1DNFVYd3c3KzRkNGxkM2YwNFY3RE9RdmZhSEtYNTl0Z0lZdzda?=
 =?utf-8?B?TnBmTjJ0OTJJNXA4bTJZY0ppY0FVaFJXRlZnQlZsalRxMjVsZGVRRnhBakI5?=
 =?utf-8?B?M3hiQXMzdVN5akZoc3RES2FLNHFNamM1d0RLaE03RmZXQVpCa2s3Y2dqSWZD?=
 =?utf-8?B?SmcveXo3dGhNd0gzSTJGdmt1THd5T3YxNllCb21TZmtZZWNkYm1ZZU5zVDVW?=
 =?utf-8?B?YVlXNDhiUkhheTNlQ2lOcisyUDg1NVh5T0p3T1EzSjJsdXN4WlptTlpOZ0xX?=
 =?utf-8?B?YlJnVHlDR0d5Y2VsYzkrcXVNSE84N2tVc2FMOUt4SGxvOGdKQW4vVTlPbW80?=
 =?utf-8?B?bTJYdlB5MWNmdmlLa0VHZUsyNDN1ZW13a2JpdnpOUEZkNXFSMVpqYlFtQ3h3?=
 =?utf-8?B?WU9OTHk4V0tIMWVpYkcraWJOeGd6Ui80RURHalBlYjNvQXcyeXZJUzlXL1Vp?=
 =?utf-8?B?Y2JtN2dmZE91WC9LeUxnMzNtTDFFWW1NRW5CbEd5LzEyMXFxaEhKcllwMjhO?=
 =?utf-8?B?YTdrVGp6TVZXSm53Q3kvMlRaOEhKeUtyZHpQcUt4dFVnck9ZVDFnRzB1eUJq?=
 =?utf-8?B?d2dpdXY1TEpXQ2p5RXdPWjVGY0ZzMnl1anB0U2I1dGlOUU9MMmJjVm00b2hR?=
 =?utf-8?B?cUI1cmRmMmgwSFRndXovc2JGSTNReE1INitxc3hYd1hmcHlwaDlKeUhDT3gr?=
 =?utf-8?B?d1BOdDJWV1prUkJoU1hEZnFCRUoydE05NjFKNk1aWE1sZHlLNWFzQi9MMEFh?=
 =?utf-8?B?ZEx3MVg1bjRWN3Z5ZElQeTluT1piaWRVMmQxYmZCOXJqa2Q4NlhFRktBTUhZ?=
 =?utf-8?B?TWc1eVFGUmVIUG9RN0R3WlRJU0dreGR1Z0Z2WGlFdnlDS3BuRjVKTm12eUxD?=
 =?utf-8?B?MHNpVFlkSFMzb3I4aHlIdGNEU0VJeUhuQ3dEWmtMSlhTZDNDZlBodHBwdVJK?=
 =?utf-8?B?cEhQT0hSYS9FS1praUw3N2txSGE4SEZHRDlnOE0yc2MvYm1RWncxclpwOEhM?=
 =?utf-8?B?VDdFRzVGU1h1b0pPMWk1eFdaeStDbmFXbnhDOWV0Z3Jaa29kVnlvVU5qUnFX?=
 =?utf-8?B?cWhBSytXU0tMdHZPOGxveENsL3ZWTlR1dHUxSkxjQW1YZzVBN090RGhFM2Vt?=
 =?utf-8?Q?ns8GleAa3qw0dkQm/bFmykV2J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787d18e1-d927-4cf0-2a30-08dbec3e3ae0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:07:02.5946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBKR2JnSie105kugwR2cIG3pcp7/h0ylYt/cPmFHQUJ0Mly6UAINvdXag1k3rs8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-22 17:40, Felix Kuehling wrote:
> On 2023-11-03 09:11, James Zhu wrote:
>> From: David Yat Sin <david.yatsin@amd.com>
>>
>> Add pc sampling capability check.
>
> This should be squashed into patch 2. Or if you want to keep it 
> separate, put this patch before patch 2 and define 
> AMDKFD_IOC_PC_SAMPLE with KFD_IOC_FLAG_PERFMON from the beginning.
[JZ] will do , thanks!
>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 13 +++++++++++++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index b00390e451bf..5e47e374d824 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3259,7 +3259,7 @@ static const struct amdkfd_ioctl_desc 
>> amdkfd_ioctls[] = {
>>               kfd_ioctl_set_debug_trap, 0),
>>         AMDKFD_IOCTL_DEF(AMDKFD_IOC_PC_SAMPLE,
>> -            kfd_ioctl_pc_sample, 0),
>> +            kfd_ioctl_pc_sample, KFD_IOC_FLAG_PERFMON),
>>   };
>>     #define AMDKFD_CORE_IOCTL_COUNT    ARRAY_SIZE(amdkfd_ioctls)
>> @@ -3336,6 +3336,14 @@ static long kfd_ioctl(struct file *filep, 
>> unsigned int cmd, unsigned long arg)
>>           }
>>       }
>>   +    /* PC Sampling Monitor */
>> +    if (unlikely(ioctl->flags & KFD_IOC_FLAG_PERFMON)) {
>> +        if (!capable(CAP_PERFMON) && !capable(CAP_SYS_ADMIN)) {
>> +            retcode = -EACCES;
>> +            goto err_i1;
>> +        }
>> +    }
>> +
>>       if (cmd & (IOC_IN | IOC_OUT)) {
>>           if (asize <= sizeof(stack_kdata)) {
>>               kdata = stack_kdata;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index b7062033fda4..236d3de85153 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -144,6 +144,19 @@ enum kfd_ioctl_flags {
>>        * we also allow ioctls with SYS_ADMIN capability.
>>        */
>>       KFD_IOC_FLAG_CHECKPOINT_RESTORE = BIT(0),
>> +
>> +    /*
>> +     * @KFD_IOC_FLAG_PERFMON:
>> +     * Performance monitoring feature, GPU performance monitoring 
>> can allow users
>> +     * to gather some information about other processes. PC sampling 
>> can allow
>> +     * users to infer information about wavefronts from other 
>> processes that are
>> +     * running on the same CUs, such as which execution units they 
>> are using. As
>> +     * such, this type of performance monitoring should be protected 
>> and only
>> +     * available to users with sufficient capabilities: either 
>> CAP_PERFMON, or,
>> +     * for backwards compatibility, CAP_SYS_ADMIN.
>> +     */
>> +
>> +    KFD_IOC_FLAG_PERFMON = BIT(1),
>>   };
>>   /*
>>    * Kernel module parameter to specify maximum number of supported 
>> queues per
