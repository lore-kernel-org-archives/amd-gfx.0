Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6378FC4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 21:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42B710E911;
	Tue, 13 Feb 2024 21:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xT7uxfg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD5C10E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 21:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNhdF4axdoKwDLZ37ftGoixQCLCLDI3sYm/XQlaBVQpcJR3OinwnYjdZs900uU5hWQ3YHixeueRUvsJjqIZS6pn5Z2msYB0DwQne9xf7RxKHcwJ6tT2kvkKrVUY+GdXH372yZdiWKm82T+RNhV8aXZgXaLuJMlAMzd0iJuyqnj+RAzqpgtQu8aqYl7Ew/qtHiR/F94SYc4iQm3knzBsctGPPsTG6u5TH2jKAfxVY/POXQXmHHztRMP5WWECfLyjNJdfd3Q5ouzESc1EPfgkngSpDoXDPK6PkCQb2fo+hMCgTzAQIJUDIprn1RLRuZ4otC9Dk16hvvC+0R3s+Tc3D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7Wk50x81WPDXQMHzRkXi6L7hsiW6dcqevQmn6Airtg=;
 b=TRIdw60x4NaAIYonDdUC4eU3w/UhRNIwnuKm/Iuw7znoRp5ZzWU6LBIk5JFwtAU54MGJ3K34sYquWZ5cSMIHLyrodnQXCDT9ShxhOnGKHcxnO8xpP0aQ1BTqhjCYPFtqMfXsjCLllVajgyr6r7J4qaFwU8zTjtDlnSIqT+FoSVsoevyqm0PNTm6DnrpfBdbxEvzoWAn391DIthC5FgO3Vs8HFsoskJklhSfbJg395r2Mh87hkSHVPVupL0e/JiXxGhxg35BrU0WYxNplPk0ruXpzrbIRLOabKrfuhpHH+V76X76c8ZQ81osJJVsTjE5WqptoznNGGRn3xgsSIbUTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7Wk50x81WPDXQMHzRkXi6L7hsiW6dcqevQmn6Airtg=;
 b=1xT7uxfg8oliwEfL2UX549G94J2TmieP4XTPua592B0OVyQhWTrFAmhMsNqvhFGsnDyuyLqUTcKybOv1rLgnqzj2naO165Y1kbeP6KfNHO7MST7UkHB7M8/5WRyGN5EqbHE7tt4JdzpY4wa3Zu9oG62Vttuo/8TtECYYK0siezU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Tue, 13 Feb 2024 21:39:07 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85%7]) with mapi id 15.20.7292.013; Tue, 13 Feb 2024
 21:39:07 +0000
Message-ID: <6171ce99-10a0-407a-9791-7349306143cc@amd.com>
Date: Tue, 13 Feb 2024 16:39:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
 <a3e3f082-f2e9-48f7-8e1a-42eff3dbc886@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <a3e3f082-f2e9-48f7-8e1a-42eff3dbc886@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::11) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 55014af1-3067-4ddc-c0d2-08dc2cdc34d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDuHU9i8/oEj1mkOFTWX7VUQoF8bWVwoNHM4ZHpa1LZMf/jz+IjTQrzt3n3kfxZwWoQb4MFyAW7lhFet9OTMcZI/kgZ92A8/FyUDYlVeRgbz0tw5ltP+iazcBnQe5EP8SXYx5Hj+sLL9TUo/jx08gBKdHJjnW4XjjkiZM4Ok9QjFw1tikLI0MYtJ2YA4+zbiPPzd7NMpaS3PTO2a8Yylbm9DuvbGDfMBOeN8h7pndqGUmqk4cK38RD3OAqChn95PJPjchzAeEfKjNBYVSBYtXaQT2CPEGXnpou2JUqZYJFtc226QhLrtjzqhFC15t/6fdzxQjS9UPRxat56El6JtGVnvYwMAaSze0LnS35viNME4pCJYyH9wADDU3i6jSh8AdZtwG80BfkQywyCfhupwK4s8/2/ze44l8gDEPwSf9b4lPVC/vt2am7wFtE6xyBU6kfyMk+DgvXwaAQllft3rj1XspMHCTaReCW69H0CHSCpxprw3SRPGnVznxEP9o7Huf/rOrrQFSP0E629SwXVgp3jJzjKgsCQFJtI7KkbHIMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(8676002)(4326008)(15650500001)(2906002)(5660300002)(66899024)(83380400001)(31696002)(2616005)(26005)(36756003)(38100700002)(86362001)(6666004)(316002)(66476007)(6506007)(66556008)(53546011)(66946007)(6512007)(6486002)(478600001)(966005)(41300700001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFtNVd6VGdjWDlHNGFiaDcvK2hEWXRweWRZNHhNWnA0ZFpmQm9lSkg1RjZJ?=
 =?utf-8?B?ajJYUEpUaDlXaVY2WEl5R2ZYWXhKOUNRWll0UlA4dWc0NGl4Z3RqekViNW1u?=
 =?utf-8?B?UCt2ZzY1dzFseE16NE5aemZBc0QxcnJIWW9wY1dFWGVsYXEzUElUTEM5VFZ0?=
 =?utf-8?B?eCtvVmJ3SHlhSTZhNDZBb3NRb0VWeG5HcWhPM1V2a3krUnJycWVTdDIzanl5?=
 =?utf-8?B?MGtnVXBLc1VHelpXT2NpdzVhdGt0b2Z1cXJ3cWZramJYc2NjWEF2RnhsaU1S?=
 =?utf-8?B?T2hhcHNaeWJUaTNyZFdqNVoweTZ2RWdVeFZodHIyRXlTaWcwSXRXdVZKMjhp?=
 =?utf-8?B?cVBsVXhmWXh4VXZ0L1NtRGJSZGJHRzF2bk14SDhwVUVTUTN3MjNkZTRvbnZ3?=
 =?utf-8?B?eGlIMHNzaGh4bGgzSWg2M3pWOXoyK25MK2V3azQ5Q0lUY0ZNUzJVaDF3OCtG?=
 =?utf-8?B?clFoZkNwRmlaYjRZbVY5bDVmKzl5L3VrTkdQWVlPKzZRaG8rRUVWZG81dnpu?=
 =?utf-8?B?ZGZmTVAyM1BkTW50R1VwVFBlZko1bWhpK2tIakpkNk55TndSbXVFVmVzNmxY?=
 =?utf-8?B?QnQ4RklkOHFPS2ROc2ZoN25PT3ByUzhJRzVGN3JaZ0FYSGs2b0NUb1QrZUlp?=
 =?utf-8?B?WVFKV0lzS01WeXVEbmkvaTRDMVBESXo1NElJcGk1T1IwTU43SU02OWhhcFRV?=
 =?utf-8?B?VDRvY0hzVGV3dDg0WDZKdmFKd2dPbU01VmNMNTh6ckdHL3NEbjRQNzM4MTZn?=
 =?utf-8?B?Zk5zUUdoUU16b2U2KzlWUTlyZGcwWnh5NXZRZGlsdjkrMnVFckhuYU1XNzll?=
 =?utf-8?B?NU9vL0lCOU84YjEvcVA1Yy85cnUxUytXdnBDYXEzZlNHR3JGZFErQ3hmV2xG?=
 =?utf-8?B?dHVVMllXSkwyaC8vOEtKa3R5MytvVmpmVHpmenpTczZFZFZPdE9yYXo3S1M0?=
 =?utf-8?B?TzZ6VmRqYUh3Zzhjc0lySlFQK2VMdWdUcEtubkhDMjRLVkh0RkwvVTZzVnFI?=
 =?utf-8?B?SW1lL2xyNkNheFJ6TmJRRUlpdDB5bGhEeU5tS2RSRm5kQ2MvR2s3dHIwZ2Z3?=
 =?utf-8?B?R25WVnp5Yjl6eXZHTlJoZ0oyaXRzQVNFRGhMd2ZzaWNpL2s3SjI1SVdVZkc5?=
 =?utf-8?B?V3k3WVZ2NFZCNEpSL3MvTkRDODJFNlI0cXpiS29ENlFWVEVrM0FxMWRjSmRQ?=
 =?utf-8?B?NDFONFhhQ1hzTmc4eGxnMGN3SHJjeERJRTdIazJJMjBHNW9CeFF4MzdVQU84?=
 =?utf-8?B?bHpobGxwU3VNZXVnSEM4VWh1SmJEdklXR2l5K1h2OExhVnNQTVFGRkFzSHJM?=
 =?utf-8?B?aXdTOEhZcGlYdmhYdGlyTXlUY3NaZzg5TTQ2Z1R4d3Nab0g5cE1kbjI1K0FM?=
 =?utf-8?B?ODdmekJWTVpodGpQTlNHbTgyc1pkWEU1QlA5b0Y3Um1XSW12bExWL3BaeldT?=
 =?utf-8?B?ZklUWDJLNktEcUNHRWNITXVEeEs1SXJhT2lkeDNucXN3dHVRd3l1Nm1HYVE5?=
 =?utf-8?B?RzM1dFFWc1l1YVBlTjlNL0NFbkNITkI4aHJCRzFadWVuSFFEV2lYcVlQK3Uz?=
 =?utf-8?B?MWdzTEVCeVRRREtRcUJ1RTZsOUdtN012MXFLbzFKZEJTY21razNtMWFIbWpE?=
 =?utf-8?B?UUdTZllyM3pYVEIyaDJNeCs0b01DTGtVTzU5azBFQ1pjMWg1MmZTU1JseFVL?=
 =?utf-8?B?VXM3RW8wRFRHc0pwQk13NUNKT2QrUzI1VmM1eUJaQkk0bnpJOVdUY3ZPWEhG?=
 =?utf-8?B?L0pqbUorZ0o0T2p0S3hPcEp0SW1panE5elhvRUFuemZSQ0h0SnVKRUxGOWJp?=
 =?utf-8?B?Z2s2c2dWZTh1WGZ2L3E3eEtXckQvMmYrRXdGZ1V6VlR4NmFLSnd6bWRxYVY4?=
 =?utf-8?B?aUJIK3FjNFZCTWMzRVNTV3lxMklvTjRJOUMwYzYxUVVYUStHUGpFOWQ0ZmhM?=
 =?utf-8?B?U2dCZFB4SFJBVlNWbWcwZk1TcUYzdjJVWHVnMUJ1bFkzVjNNbmtMZDl5dENV?=
 =?utf-8?B?b0UvKzhtVWllN0NSTUQyamRCTGVPdGNCNGJCUkhrT3dRTHY5c01hR0FNSlpo?=
 =?utf-8?B?c0ZvODl5T1NiRWJPWENUYUJEdE1qM055TU5yOXNxZUROMWtwQVJ6TGVoVVpC?=
 =?utf-8?Q?LhZW4gT7nWyU10Tjq2rEAf1j0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55014af1-3067-4ddc-c0d2-08dc2cdc34d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:39:07.1893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y87Wd3t90rbsSek65t26Un3YRHztdE0JNWgLsPfmd0Ov2j1nSm+lHehK7ph+6r4G6phOM+OVRn2K9LSaG+ML9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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


On 2/13/2024 3:52 PM, Felix Kuehling wrote:
>
> On 2024-02-09 20:49, Rajneesh Bhardwaj wrote:
>> In certain cooperative group dispatch scenarios the default SPI resource
>> allocation may cause reduced per-CU workgroup occupancy. Set
>> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
>> scenarions.
>>
>> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> ---
>> * Incorporate review feedback from Felix from
>> https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg102840.html
>>    and split one of the suggested gfx11 changes as a seperate patch.
>>
>>
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 9 +++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 42d881809dc7..697b6d530d12 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -303,6 +303,15 @@ static void update_mqd(struct mqd_manager *mm, 
>> void *mqd,
>>           update_cu_mask(mm, mqd, minfo, 0);
>>       set_priority(m, q);
>>   +    if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2)) {
>> +        if (minfo->update_flag & UPDATE_FLAG_IS_GWS)
>> +            m->compute_resource_limits |=
>> +                COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
>> +        else
>> +            m->compute_resource_limits &=
>> +                ~COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
>> +    }
>> +
>>       q->is_active = QUEUE_IS_ACTIVE(*q);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 677281c0793e..65b504813576 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -532,6 +532,7 @@ struct queue_properties {
>>   enum mqd_update_flag {
>>       UPDATE_FLAG_DBG_WA_ENABLE = 1,
>>       UPDATE_FLAG_DBG_WA_DISABLE = 2,
>> +    UPDATE_FLAG_IS_GWS = 3, /* quirk for gfx9 IP */
>
> This flat needs to be a separate bit. So it should be defined as 4. 
> Otherwise it looks just like UPDATE_FLAG_DBG_WA_ENABLE | 
> UPDATE_FLAG_DBG_WA_DISABLE. I agree that defining bit-masks in an enum 
> is not ideal, but I've seen the same in other places.


Yes, I agree. I am have sent the updated patches. When we extend this in 
future if required, it would be 8, 16 and so on...not a great way to 
extend/define an enum IMO.


>
> Regards,
>   Felix
>
>
>>   };
>>     struct mqd_update_info {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 43eff221eae5..4858112f9a53 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct 
>> kfd_process_device *pdd)
>>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>>               void *gws)
>>   {
>> +    struct mqd_update_info minfo = {0};
>>       struct kfd_node *dev = NULL;
>>       struct process_queue_node *pqn;
>>       struct kfd_process_device *pdd;
>> @@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager 
>> *pqm, unsigned int qid,
>>       }
>>         pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
>> +    minfo.update_flag = gws ? UPDATE_FLAG_IS_GWS : 0;
>>         return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>> -                            pqn->q, NULL);
>> +                            pqn->q, &minfo);
>>   }
>>     void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
