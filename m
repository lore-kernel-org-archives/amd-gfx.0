Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8F3C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304C210E534;
	Wed,  7 Jun 2023 17:49:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF99810E53B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iYNhw6TbjRjyBFK4G1xsN7oOSA4VbxA+q5BL8BkQWM=;
 b=lGBKw1ABP1zwQEgch92wmNnlIsHxSe2pApmF8HT6EoFveVoOiY/w2b724FMwKOvoLx6d4E5odBxWbSr11OVLeQvRUzpLHdpqGNIXrCcR9AunyndjMxWCw++zUdbXj637R466vv88px+sxrgLDmTL9rV6RF2nnkJu3VbGTYo6rhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:49:38 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a500:7a4:10f6:1cc6]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a500:7a4:10f6:1cc6%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:49:38 +0000
Message-ID: <3a43a066-099b-c5d6-ddf7-0f0977794ada@amd.com>
Date: Wed, 7 Jun 2023 13:49:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] drm/amdkfd: don't sleep when event age unmatch
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230606162418.1862540-1-James.Zhu@amd.com>
 <20230606162418.1862540-4-James.Zhu@amd.com>
 <d7674f97-f5cb-9b79-ed1a-a499fcea27f9@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <d7674f97-f5cb-9b79-ed1a-a499fcea27f9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::13) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd36101-7c93-49fe-0d97-08db677f9049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ho/jxawYteH2eioRzt5xZeieYykmuWogK6kVEKucQfLWSzah9Qe2IuCGevlCjikeWw0IcfZ7y4rINSbJj/GqKbLMuXyFviqSuyx/+Ti4CRFtO6rIZ+5qAACtlbuqcstyXZmbZI3cPWahtSits7hhiSNrqJg4cjn6IL8GyxCNSBYp/ZmbgieoNM6683z+QHtJ8cPfZbOgnHfWjzP5Skg0LBgNxZdSVuf7kVU6J+/Jwsw9Hb0/xRh0Bn9Ycdug5MQGhsW1PMcYa1FPvGW5T5LXnkm8fN9qN6ORx3/I4F4macEw56Kafbz5/cJ2r5fCdow/KYp6CsMEyxXXzTcTUdwb9nRJumImYbt68ml2K+4FT2tyV3qOg/+21LV7snxjWDVlj7u5sW1dyWq3z5LxB2U5QQyiJX/rtHI2YWmEuu8Bf0OXRvTPBVi0dlHlL9GdWiqIo9fQrzW9TQZHZOZ4ouhsQrsYMtzz/yYJyTcUwr9E4Z6Xq+kJ5iIUlnEvtMr7CD5JkAqkv+gxAqoPnp98XwIFA3dlWbhqKzYAWUQrjEM+8ddnjW6TAbrzsyqTlpZ8Sn8s3oLUMwPW7t68LYlDH2KutypR20wqE4cZSrkqQ2vUOQbkc+dJzIlo7+o0tbaMGGl0eQKRlwYHVAv9+b3vYYRs3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(26005)(6512007)(53546011)(31686004)(6506007)(186003)(2616005)(83380400001)(36756003)(6486002)(2906002)(36916002)(8676002)(8936002)(478600001)(110136005)(66476007)(31696002)(38100700002)(5660300002)(316002)(4326008)(66556008)(41300700001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bit0YVgyV3BPVDhhTWlzVDh6MzZmb3dtTkduR2VrN0c2WTRLNDVZZ04yc3lZ?=
 =?utf-8?B?emhYcVlCVElqeVQyWnF1RWVpZDFDWDB3NUZGQ2taRHFGTW4yeTJOREh1aGdx?=
 =?utf-8?B?L1VxNmx4WnovaE11Si9BV2N6cE0zSW9udmtSTFRoMjVKbk1WeUIya3QzMVpG?=
 =?utf-8?B?clhPNEkxa3NZaWxwQVhvMW9QcmQxeDdvcVQvL2I4OFZ0NTVQL3lWNWFONWdB?=
 =?utf-8?B?UDFZdWt5aHkxRWQ4UmQwT0d6ek42SEVZT2tCbWtpRHcrNHozbkZuU2FHeFZr?=
 =?utf-8?B?aEFxZEJ5d3YxaUJ3V1BXMTFmbXN6NDFwWGoyOGdPZ20xTnJxMUFEaXJ6ODZ6?=
 =?utf-8?B?UFkxeFJINXNTZkxzeS9YbmRxN3AwQ1lnVHdoYUlNaXVpNWtRaUtEbmhhSHd0?=
 =?utf-8?B?aWsxRWdxOEp0VzBnRkpkMitpWXFqZ1lLUDVwNjVaTFlzNG02RFhhaUpxRFZD?=
 =?utf-8?B?c2NtejZraEprTlVyUXkyTm5LUUZoU0ZQMFpHVExTRndFVGZVUFZRMlVIRTJa?=
 =?utf-8?B?UGdGamxNR0RoOVRDR3dMaGNDZlcxSUxwTUd4ZEo2bityb2NEWHI4ZXF1MjFE?=
 =?utf-8?B?cmM5Ti80NWN2cHRYbVVnQXBlWVN5SWduNldHRE5qUXBOcUZ0cVZvSTVGVVlS?=
 =?utf-8?B?RUZZaU1JL2RPZlhWVnJncWllaW54Y2prVkl5NVcwMnI1a3duSHNVanVBVmc3?=
 =?utf-8?B?SWNzOTRCTXpPTnRXN3lKTUg0VFJXRTQ0d3ZSZXFaZEtMWkE0dFJucHU5Q1g4?=
 =?utf-8?B?RmZKMHBOZitoSnpLRHdsZWhFbElocXk1Q1paM2NZVGdSSXV2akFVZDVrY0hy?=
 =?utf-8?B?MzlWT1VmdDArN3FWN2UrSVY3Zmk4ODkwU3hxVlFJazRmcm9qbmVFT096UGhZ?=
 =?utf-8?B?bEhYcGtMb2x2b2dFZmxubHVCaEpxektKdDMxdTlQTUwzZExiQUhRV0NQUnNJ?=
 =?utf-8?B?c3UvUzJNSEd3RmI4RUZiZUovOWoyMW5qSjY2emFlSk9IWW5XK00rdGNOdHRG?=
 =?utf-8?B?YjZYdkVWZWhMVW9tUTNsb2M4cXFHOGxOWTAvakhId2d2TWtjbUdsU1c4ZE1q?=
 =?utf-8?B?UWF1WjR3Z2FxTVZQYXI1czdzN2VubmNZb3I5d05ud2RoUndNb3owNUc2QnV1?=
 =?utf-8?B?Zkl5MGxHeHFLbXp6Tmo4ZnRhd1NUZkZPd0dYUFVZMm5HOVpaUXVHTkg0UEF3?=
 =?utf-8?B?VEkySTltMHdRdS8yelZrNGNLVUZsa012NHkvK1dScHg0T1VoMDBBZVdmRDNx?=
 =?utf-8?B?U2JIRWJJa1BwN1FjZDZlU2Z6b0JUMUh0N2IxZ1dNSDA5Vjl5TlA3RldDZTJW?=
 =?utf-8?B?Z2J6MzQvK3lsS1hMNy9uZlNGZUVaMmtWWjc5U2JGZ2h0OVdRSHF0djZkZVFB?=
 =?utf-8?B?bDNTSzBpQUVPZ0lPMmg5WHRtM0hFRHJkWjdLL1BERHh6eXFNQUVOZ1c2Q3ho?=
 =?utf-8?B?SWc4cmVwMURUa0pXOWtCd3lhaU9QdlVudFlsdWJwdXJGcTR2TndsNWEwWHEz?=
 =?utf-8?B?V2EwRGNIcGJpc2E2TTRnQWhlUGRCWjlxVWVrTDhzVk5RRjZqRjMzdmlGbTMv?=
 =?utf-8?B?MmZzNU1PNS92UFQ0VTlrQWdIelN4NUpIc3l2aVo2ZXVpbndEWHZYVDV1SnUw?=
 =?utf-8?B?S3ZQK3d1Ky9aRDJ3dW5CZTM5OWg5SjcyK0RicUxhb1hYSTVnRlhRdWNOS3lo?=
 =?utf-8?B?VjcxNjk1eWdRbWlZbDBaNE9VWHZQWEpPNEFBcVRKL0dDaVdMNEZKNkZsQnFD?=
 =?utf-8?B?ZjFFMGYzU1B6UzNCM21xenpnTzJWall4c2FLNXdtUjV2S2NJTDhaL05kWmhk?=
 =?utf-8?B?TkpHanRXNktrMmRBVGQrUkxyYlFUQVdvc0wrQWRwM2lBV1pSS3d4VGpoZDdy?=
 =?utf-8?B?WllGSlJpUE4yL1ZiQk5aa1h1ZFJjdnpsZ0l1Tis4UHRMS1Y1T1Ywak1UM2hL?=
 =?utf-8?B?NTNuOGhmcTZyMytCMjZCMzJWdm1DRkxDNFpWV1lWb001TUQvUVRpWVR3aEF3?=
 =?utf-8?B?QVRvOEwzcktiSldrd1U2dDY4REdUa1NMUTlwbERsMERXdUZYSUJlTHdjVGgz?=
 =?utf-8?B?dVZGb083TmxGVU44S3JWc0V2L29PRlZjYjdSdW1NSmRvL3FWcjBQRXZwVWZv?=
 =?utf-8?Q?nbR8/PiGbzoR0BE0SglPrNxrp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd36101-7c93-49fe-0d97-08db677f9049
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:49:38.4292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1C5ZapptSWnjGA1jsVS8UtmTi3ctTRtD+om9GABcFIKZM3Kin+yseqrcFDASRxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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


On 2023-06-07 13:27, Felix Kuehling wrote:
> On 2023-06-06 12:24, James Zhu wrote:
>> Don't sleep when event age unmatch, and update last_event_age.
>> It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index c7689181cc22..f4ceb5be78ed 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -952,6 +952,21 @@ int kfd_wait_on_events(struct kfd_process *p,
>>                       event_data.event_id);
>>           if (ret)
>>               goto out_unlock;
>> +
>> +        /* last_event_age = 0 reserved for backward compatible */
>> +        if (event_data.signal_event_data.last_event_age &&
>> +            event_waiters[i].event->event_age !=
>> +                event_data.signal_event_data.last_event_age) {
>> +            event_data.signal_event_data.last_event_age =
>> +                event_waiters[i].event->event_age;
>
> The event_age is updated in set_event under the event->spin_lock. You 
> need to take that lock for this check here as well.
>
> I think the easiest way to do this would be to move the check into 
> init_event_waiter. That way you can initialize the waiter as activated 
> if the event age is not up to date.
[JZ] Sure
>
>
>> + WRITE_ONCE(event_waiters[i].activated, true);
>> +
>> +            if (copy_to_user(&events[i], &event_data,
>> +                sizeof(struct kfd_event_data))) {
>> +                ret = -EFAULT;
>> +                goto out_unlock;
>> +            }
>> +        }
>
> I think we also need to update the event age in event data after an 
> event has signaled. You should probably move updating and copying of 
> the event age to user mode into copy_signaled_event_data. That way it 
> would handle all the cases.
[JZ] Sure
>
> Regards,
>   Felix
>
>
>>       }
>>         /* Check condition once. */
