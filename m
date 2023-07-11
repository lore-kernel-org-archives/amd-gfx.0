Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A382EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 18:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A122C10E08B;
	Tue, 11 Jul 2023 18:48:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C0A10E08B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 18:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/przMmjWfloyBdiqnKH2POnNSsDnh+mnlEd3RV1byvJ4FbpXiUGZnZdH34wZjllyHT1HzjEEubRZHQldD9/knR4EPEQTutAka6gdk++TAXDY/NpqD5QmeenAe7l2Nb1Ty9w4SrEjn7luCvlntvAzt3h4A377lPWs055mNciSLVzLVGrsVFsyONxoH6ur3bQrQZslGDgtKQDGtJU1Dm+6xAVLow3H7Z21AFCic8ALSSnLix/vYRQHa3UW1/CHLVcmnBIofk3ecwqAHwMWXIH8MxhHqZNSxfLIIDpYF5ZoUtF+o11NIWFz4W22Jpk6WcMAafstj52F9xQPs7Rm7Y/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjQmY8S5DDt75uC3C1HUn6JHxGXglJEcWhABVuqyUBg=;
 b=UiEWf+mndMTzjJ+c58KujWDPOZH3XLiIVp77fgxuy+68nTJPPJzGPXlYnlykGqEnZ4c8SWyIfKbyESWIzc4GFY3lFfwyuLqH7VNutq26c0lOqV4AhnxPjagwFs/4UNV6cvjy0xxGkk8GlfGTkThwr9oUx60nysbTzkdbYmMhjOZSc+vSgIpiNVt1z0y9uHMfNMAdc408BU+MriMRBdDlK6PCyY46QX8SgBLwI80S0NekHI+yl8OgW9/VIpl8fUIa42lVHq6fzaBKgTdrnhAMy4fgKXYJORIFoeNSmWt1TsJSKzyuki6FRjwOTXvkgb6livH/Xp8C2LjZfZtyMKSPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjQmY8S5DDt75uC3C1HUn6JHxGXglJEcWhABVuqyUBg=;
 b=CH21XtMwIvwGclYRcxa1YaGT6PxiKNWyQ14URwSf8g485q7fHrvqlMYuXJhfO/L3AFiQmTAl43KG3B/G3vhNTRzNg6HGlpUEyCx3ESO4f6XY9s+9ZD2eKEs/DETgbeQ+1lR4ltOmSGWHLyb4XPyDdIIhWPWBCi13l3eQ2R5cg6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 18:48:48 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::b6df:8b5f:9e94:f4c3]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::b6df:8b5f:9e94:f4c3%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:48:48 +0000
Message-ID: <b2167179-e79b-d09c-ef55-167f58a04f8d@amd.com>
Date: Tue, 11 Jul 2023 14:48:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: enable grace period for xcp instance
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230711142807.68327-1-jinhuieric.huang@amd.com>
 <be92a672-8d30-9863-e9a8-ad8bd1d96898@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <be92a672-8d30-9863-e9a8-ad8bd1d96898@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:408:e4::7) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: d50d712c-8cab-4ea4-2cc9-08db823f7608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yteGzCqHKKwi8g4V4XNu9M7PMnuv6q/xq3M503RjeSUCcdqcwNoHl/TKm0UqWta3Rpwn8ji6X/zkgRkDDt9BmuIPRVJULX+iCqdQFRZd73S/YMn8/BhzeOUW0M5TEIiIF9SaGunifgGtpR/wZAK4RbhDcZBZ+snCTNcP8VlfGn6uPe0wq7s2GmUfRJ0GB9cmxDTqWKcKro7Umm8CX8CO9gWyWPorVAzVG7mgCpH5D+qrr1WEsrkWbFSqRTtWShnmTZSp/Nk/GOLWIxX7whShvxNvQPaQCWanKfJ6o4z2WDXqxBXry/wZhQbHFn8DU3sNcEam1zHqmSF5XEuOD8pviDqpkNmZHX34KMLcMoXEOQN/1U/GuSoVn3Ct27ijhu5wCVjfN6HNZTLq5seJ+y2H/J7VmcSrWgDDCKuzshcPFNfepSRcenY346pRzsAOkeOqZX/Hc6RkPB9oQ8d3HGfbI7bHigJiU4Z3bv+7ZI2Ao0Rbq4iAVFvFbqGEr7pVLoteudEB68oLUFS/jPY4JS9xxtTGxG7+iGWsqf7efXNyUy2cxKNFmd79dOMcywEHwB94uKQxpNj7hB+znQmv69Bp+aHGU69lRW43Kc3kuCYgnTjtOoHhq/ca965dbkOIuD1CAPp2koyTlit9LbLf5SEH1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(316002)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(41300700001)(6916009)(66556008)(186003)(2906002)(5660300002)(8936002)(66476007)(8676002)(6486002)(66946007)(36756003)(478600001)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDR0Z050VU9uTTBKdFhBZEUwYXlQcDdwTkZ5Mm56anRaY0ZRTVZmdVpGY0t0?=
 =?utf-8?B?MVloSkdrbDZPdGZqSUNVeXhKVVdhVUl1bXFVeDNmWThKbnFFVy9DUDhWNzlv?=
 =?utf-8?B?MkJhakVBak55R1RpS1A5RFhGMzV0aWdzc2RWMmhQeHhJZXhwd2VwRUU5WUZm?=
 =?utf-8?B?Z0hReVQyVWx0SUdmb1FVeUF5VVBIWUpObTVCVzV6NUozaXhEWVZxWWRSZFpn?=
 =?utf-8?B?M1VBK0phU1R5VlFiZFVYR05WZTRObCtrWVlwQU8vd21nK2YxcW9wcmd0UDFQ?=
 =?utf-8?B?VkhWaG5aQWY1T3BKZ3dPYm1LTk9wS2R0cGZVc0hjM2RJWm5jbjBVS2xNaHU5?=
 =?utf-8?B?anNrMUxqaHlZQ3l2b2J6TzQzdVlFL2pIVkFSenhpQTdid0ZXTnUwMGl2ZVVv?=
 =?utf-8?B?YXg1VnpBOWoyNVhEdldjeTJzRTNOQ2VKdTRSajJ1RHU0eTJMMEVuK3Z0M3N4?=
 =?utf-8?B?NlR0NlFwTGlOVEtnNksrcTc1VWFQVGJHTHBVVGxEcUxTZWN2Njg1cmlpWlI4?=
 =?utf-8?B?Rkx3by9IVFh5RWcxWU1PMkducTd4QXpZUy9qZHIyQTJoeTYzYjFyZk9JMHVs?=
 =?utf-8?B?bGZmakJpQzYyMWR2NTY5dFBOYWl5UlY1bit5K2NjdldvRlhrZUI3N1pzNkdC?=
 =?utf-8?B?ZG1IMVN4elE3U1NnNnduZXhVVWprNGxCNlo5WFFqTE5RUU43N1RNRlNpbGhM?=
 =?utf-8?B?eDE3M3lWWEp3dThWTzAzUkNmaTVBWk9VTm9aTURsSGUwL2ZlNjZxUk1zVDk3?=
 =?utf-8?B?MU0vTExuWUFRQUNqbWZPeW9TdVZaRWdUK3BOd1h3cXFZUUNsdktia1RQQkY1?=
 =?utf-8?B?YnNBVVNzdlZmbTNldjlhVDcxZ1hoYTBVUEZLWVZpUkdtRVpVb240eE16Wk1y?=
 =?utf-8?B?WEtTTzc5R1NQdVRFaXFoa2V2dkx4d2ZXaGNDY0RyMWhXVlpJR2hjdU9lamp2?=
 =?utf-8?B?VTVDVjlTaURsQVRONUdJclVtRWo3Ynk0VjNvVGJrNEZQQmVUQzMyNXBtRVZs?=
 =?utf-8?B?OEJvRlY2MExOZGZQaU5TS3FsdTl6L2EvTGZ2eDllR0YvcER5NThDNkhWWHRC?=
 =?utf-8?B?T2N2RE9KWWtnTzlzbDVQNHY4Z0czMkgyMGJKWGZYWXNxbVJNbDgzRkFyVHZR?=
 =?utf-8?B?aEcrWENIQndFR3FUUUVXRDlKSWhzYit5TE0zeU1sby85UXBQWUs4K0lnUUY5?=
 =?utf-8?B?ZVlWdktJRllOeTFXdjY1QjNCYUNQSkl2OFRxYTVSbnRXSUc4Nm81Ymk5S3VG?=
 =?utf-8?B?N3FDNEJKbWplSEE2Zys4YUl3RmUxc0pCY1g3YU9hWThaQmJBSEdMd2JIL3JT?=
 =?utf-8?B?SmI3Tk9wanNHMEZ4dFVqYzVFN1FqZDlkU1A0TWI3bDRZdlRwWUtyaG0zbllS?=
 =?utf-8?B?V21xNFFlZkNJNFFNU3dUVnhMY3BlcTVrb3V3My9paDh4NEk0TFBGUzhkdnhx?=
 =?utf-8?B?UDlaaTFUVi9jWEJjbnZ2VnNTbEgxYWJQeDRuSDF2dGJLVlhlNzBiYVIxRFJa?=
 =?utf-8?B?RHA1ZE5MTUlweXVJM2NhM3h3MURCV0tYUlpSNkJDMlRERm5wckdWVjhiNlB1?=
 =?utf-8?B?UEhLYi93QS9tcnNFanBvckFDVEpFdkxjMWE2M042ZmU4eG1RbUgyalZFNENa?=
 =?utf-8?B?ZFJYZ3JUb1ZERlljV29OcThhMDJFR1FaNFFicS9ibWQ5Vlg3UE40bmhoQVlI?=
 =?utf-8?B?Q0huZTVpMGliaUhDQVkwVy9kTWRyK095aXM1TEZTWStEZTd3QXF2OFlYaGUw?=
 =?utf-8?B?dDZNVytCQ1RLSUd3ZzNBaUt1QTBnY05PVDI5K3JXb0hBeTYzZTAxZDF2TEZ6?=
 =?utf-8?B?SFMzaENMWisxK3RpZzR4Q1l5S1VmZDhKdVd2NERydGE3SXZrb0hmdXZsbHNq?=
 =?utf-8?B?NEZTRkZ0SFBxUlRneFJJamJwVUhxVytoWnBGeFhqVzF5djQrdENnMlRFcnhh?=
 =?utf-8?B?ZklzWW5uWVRqUkwzVFQ3c055ekVnckxqUTlqT1RyNWEramNlL0VIQnoxWUtZ?=
 =?utf-8?B?TGZwajE1aUNqLysvdzhyUTRXVFlvckNOVkpXR09tSWNTKzVwSTNMeElGbUEr?=
 =?utf-8?B?Y3dJRndKN01sbTlJM3pEYVNLSklBejBjUTU4RzhlTmFZaHlZSXJScVZ1TVlV?=
 =?utf-8?Q?aUCApsgyiArz1MiZ/xhG517j3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d712c-8cab-4ea4-2cc9-08db823f7608
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:48:47.9950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9cJjJwwm+4UZB4TS6axZXyjUebBt2F90Vl8bHChWn3kYTvdRNUKZ2pLsXE9nKks5ZfePsm3PBRl4RTzdOBm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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


On 2023-07-11 14:38, Felix Kuehling wrote:
>
> On 2023-07-11 10:28, Eric Huang wrote:
>> Read/write grace period from/to first xcc instance of
>> xcp in kfd node.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++++-------
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  8 ++++---
>>   3 files changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 31cac1fd0d58..9000c4b778fd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1619,10 +1619,14 @@ static int initialize_cpsch(struct 
>> device_queue_manager *dqm)
>>         init_sdma_bitmaps(dqm);
>>   -    if (dqm->dev->kfd2kgd->get_iq_wait_times)
>> +    if (dqm->dev->kfd2kgd->get_iq_wait_times) {
>> +        u32 first_inst = dqm->dev->xcp->id *
>> +                 dqm->dev->adev->gfx.num_xcc_per_xcp;
>> dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
>> -                    &dqm->wait_times,
>> -                    ffs(dqm->dev->xcc_mask) - 1);
>> +                    &dqm->wait_times[first_inst],
>> +                    first_inst);
>> +    }
>> +
>>       return 0;
>>   }
>>   @@ -1675,13 +1679,16 @@ static int start_cpsch(struct 
>> device_queue_manager *dqm)
>>                           grace_period);
>>           if (retval)
>>               pr_err("Setting grace timeout failed\n");
>> -        else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
>> +        else if (dqm->dev->kfd2kgd->build_grace_period_packet_info) {
>> +            u32 first_inst = dqm->dev->xcp->id *
>> + dqm->dev->adev->gfx.num_xcc_per_xcp;
>>               /* Update dqm->wait_times maintained in software */
>> dqm->dev->kfd2kgd->build_grace_period_packet_info(
>> -                    dqm->dev->adev, dqm->wait_times,
>> +                    dqm->dev->adev, dqm->wait_times[first_inst],
>>                       grace_period, &reg_offset,
>> -                    &dqm->wait_times,
>> -                    ffs(dqm->dev->xcc_mask) - 1);
>> +                    &dqm->wait_times[first_inst],
>> +                    first_inst);
>> +        }
>>       }
>>         dqm_unlock(dqm);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> index 7dd4b177219d..45959c33b944 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> @@ -262,7 +262,7 @@ struct device_queue_manager {
>>       /* used for GFX 9.4.3 only */
>>       uint32_t        current_logical_xcc_start;
>>   -    uint32_t        wait_times;
>> +    uint32_t        wait_times[MAX_XCP];
>
> Why do you need an array here, if it only saves the wait times in one 
> of the array entries [first_inst]?
That is my misunderstanding for XCP. Each DPM should be associated to 1 
XCP. I thought DPM has multiple XCPs.

Thanks,
Eric
>
> Regards,
>   Felix
>
>
>>         wait_queue_head_t    destroy_wait;
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 8fda16e6fee6..960404a6379b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -292,17 +292,19 @@ static int pm_set_grace_period_v9(struct 
>> packet_manager *pm,
>>       struct pm4_mec_write_data_mmio *packet;
>>       uint32_t reg_offset = 0;
>>       uint32_t reg_data = 0;
>> +    uint32_t first_inst = pm->dqm->dev->xcp->id *
>> + pm->dqm->dev->adev->gfx.num_xcc_per_xcp;
>> pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>>               pm->dqm->dev->adev,
>> -            pm->dqm->wait_times,
>> +            pm->dqm->wait_times[first_inst],
>>               grace_period,
>>               &reg_offset,
>>               &reg_data,
>> -            0);
>> +            first_inst);
>>         if (grace_period == USE_DEFAULT_GRACE_PERIOD)
>> -        reg_data = pm->dqm->wait_times;
>> +        reg_data = pm->dqm->wait_times[first_inst];
>>         packet = (struct pm4_mec_write_data_mmio *)buffer;
>>       memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));

