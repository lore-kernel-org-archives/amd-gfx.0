Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA00C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 19:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D8D10E0CE;
	Fri,  9 Jun 2023 19:43:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C573210E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 19:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADxsCGfyhxsTh+cJ7wIolipenuLbjZBvorXqFVQKNq7nTqS9hT4VWVkzROyCnTRn9z/m2dbd6DL8g6LA0XQAOrYieuCSF9yvyPrv2Cwp/keCp4hBD0RkKhLzupC9v3Zv5doSkhyGWB49Ft6SSb7GRmNrkEnOis1jf8Q0hOQEDxaIR4zxrw9XsKx84oICTLpX5xB76y+i6N9tDlK8sUPSSZHiKhADR4QXRKbAM9jnXTNf1dNK/wxo45z6iSd8k9qvi7AVJxeqQR3IeXSP51WkKPRaKH9+vnBUgvhhwIEXM6l7NCbaYUkMsrpyUXF7JDTn43frJt9MKmWSE7r4KOuJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=891NQRS7Oj2GNnvYzXpYgTYz1n93MWLIv7ihzMc4JoM=;
 b=AUWDkb9Wjw6YxpzFYfpfaUAQaIp/Ti23XTwJhMYiD1mqvNTxYkVa0SLDiP0VVKcsQA7AcJiflwjl9TO4e8ychK28wzOt3rwiiDgMDTO7gQFdKlEK1b9yuIpsrircnZGJaZ1Lxhj/nhfnLzbrFq2w2rcloHzF0uP1UBUtAogxLeIPvrY6m/Iu3eApSECmq7A058joEvq68/aCqdhKYj6V9GegsBYd+6eZLRbnJ5VDL7SBV6EmycDcnpvWPsRlhoZRKeeff3g9kOUmBKrqP/JwpF56P+wAkrnIo00Upaznl7qU3WcV7Z9odAOcxKNQ87ydiYmOifgl4FoFBtMYo8/6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=891NQRS7Oj2GNnvYzXpYgTYz1n93MWLIv7ihzMc4JoM=;
 b=h0dP1uaQTdjH494YqO2+oRMnnP9FlUYz3Ce7TCYTKwxITwqv4h4k/lmebLavtnIb/penwrTQWyUeA6REbXS4orgwON/EU4FxJ0gvAcSb46HrE/5zG4uROr16dAU0n3oNQdQoxOgONEe7cHMua+kbiRo3vWzFQ+viKRaWJx0VbmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 19:43:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:43:51 +0000
Message-ID: <cb634cff-ccf1-1bf1-569e-c3cc503aa7eb@amd.com>
Date: Fri, 9 Jun 2023 15:43:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230608170705.2271276-1-James.Zhu@amd.com>
 <20230608170705.2271276-4-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230608170705.2271276-4-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a8006a-8d4b-4f7e-d606-08db6921d99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAr45jMlffFB+SazV2vl2IksGhJx7JF9i2TuDtG7wy6sHkDOhkbWzstZXGWU6tCIxlnAkl6xpnDDh/zNUNdQ06R8jmBqq7tpRCW927z3D6eSkV2C0K26VungKyKZYP34Nht+htnsJ7+jQruWPZmT7iuDgDafwPAC38H/i829HX7r1OpANby+mNtXEI0nkimGv2XKDShe1MmPOjwsAVl1s7l0yeXJ7jce7N0MkUiXlinurPEE92Q72fA9PHSFmTdDdWDcNeS+szfwQTOQtsdZuag/PXCYONN7ArYai7TNvI+t46ydhohuxTqi76dPbtT2Fqs3fVCGJ270JGe+PBXJP5fzvNE1R1Jnc22kf9RPxmx2wiVJLfw8UFmqmDX6DZvTewZ2hkeDca4OuUcATLAwRcqwrSeWCI/SRFgdN8C75Co8hW+l9SLedT8wGQ7jnGTCPaJEXZBg2WV0tUY7fk0aX1i76bh0d/DV/oNhdb3d04STkk5Kp7jx1JDGvmvFm/TMHW+3aZFM84nerTgJHItQcTv+/aHuRHi1ZT+fyEHq/ILthapJOAEghILrhD4ra6REPNOo5xbGXXQPjDlwmRvGMx8SJHo/3CUwt/0a0kqCU9tSBzqnqaKOTNPI/IRQ2nwguphcq+1pV7cK3VpYxzLY/8vaJyWzPDsounTdjsG0g+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(186003)(26005)(53546011)(6512007)(31686004)(6506007)(2616005)(83380400001)(36756003)(6666004)(6486002)(44832011)(36916002)(2906002)(8936002)(8676002)(478600001)(4326008)(38100700002)(31696002)(86362001)(316002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdsN1Q1WGtvWDIwV0Npc25QVVFJeWloREg1Rk5FMFpRQUxROHlGMXBuQ3RQ?=
 =?utf-8?B?WElFdkZyVHNyZy94QlBmRVRia0N0MFp5V0ExZ0Y3WG5jRjhIdEZIYTJ1MUtY?=
 =?utf-8?B?Y1VjUXczRnllTnRPNEdhSlh2Y21jZHFkQyt5MUNYYmRFZjdWSTR4M3F0VFNl?=
 =?utf-8?B?MFhiRVpEK1BsTmJaSW55TU03d0pHUTRWTGRVTkgyMkxpS2FBakRJdXlNTjNW?=
 =?utf-8?B?MVQyWWwwMkZORDJOQTg0RytsMTJmMkJHU0VHR3hxNENNYWVCNlhPYy9ETG4z?=
 =?utf-8?B?b2V1Y3phSTVKTklmZlVNRXNWU1NjSjJMeWJRSEc3aVBYL0RScUptWFNNZHJi?=
 =?utf-8?B?Q2JDTFNsMUV4NmkvUWxBMUNjWWZQaHU2cTlnSGh6L3pCVEYweXFDajhlUjA1?=
 =?utf-8?B?cUhjb2h4cGNCMG5rM3NPTnJlVE1JWXpjZ3lleUUxTWZKVkQ4emhNVUhpN2JD?=
 =?utf-8?B?NkQ2elBidjRJcmZteDl0NVdnLy9ucm91bUtIYkhzL1ljYS82Vm1uZzlUdUd6?=
 =?utf-8?B?MHRqZzhKT01JalZvclVqNC9XVWt0bFJ6UE8wSmswc2U4THJpVGIySHpraTY5?=
 =?utf-8?B?SVI5U3dGblZadTlweFFLNWp3MlBxSFBJY2h1SHE0eC8yZHJVeThKOThzZm1B?=
 =?utf-8?B?a2ZEZDBGNnpTL1BtM25FemtOOXhwdEE2L1JYelRsb3ZDYnBJUHZLREppN1Ro?=
 =?utf-8?B?TzVqeHNOUFBzZVVXRDdMaVJxN2VmZVBHamhUbHloT1IxWTBSbUpyQ0hxeHRy?=
 =?utf-8?B?dWVScFJWWUt5WkhNWEVxR3RjTkJldDRWeXVnV0tTR3VsREdZalZhcEVFVjdS?=
 =?utf-8?B?WGNuVUNGd2F5Z2QxaUhhQUttSHg5bVo0d2trV3ZPVkxFVlBIMGRuUU9qSzNY?=
 =?utf-8?B?eElQcTZFMHdPd3pLaVZRVVAxVVJWazY0SVQzZHJ0UjJacllGUUNVNnBnR0lr?=
 =?utf-8?B?ZUhjSWVHRmE1QTZaVUh6MGlzTEt1M2ZOazFJZWZGc3EvSURDZkNzc0xMbWVM?=
 =?utf-8?B?UzA3NWF2VUNROHZRZDlSMjkzUkpSQ3pRd2l4VTdrRmplRTNTd1JMQUFqZ3JY?=
 =?utf-8?B?ZWZRVHMrSnB2VURydXcrbHdRSHJMY0tOaTQzcTdQZCtzWTFmd00zWmdseXlR?=
 =?utf-8?B?Ri80NmE2bXEzdytPSVQyQTZYcFlmSWpuMG1wRHlBUmFyV09JL0JGVGdYTWRH?=
 =?utf-8?B?anBpdGhidU5yeGR1eWhUQ3N3d0FXVVBVZGc3WlFka2hFTmlOZHlZZGRjd0tY?=
 =?utf-8?B?SzVPZzNIb2tFNmFxK3pBNkhzc2tUY05nS2tHcDNuSWdGc1pGV2R2b1FCNGpj?=
 =?utf-8?B?SytBNFluNExYOFEvY1NUTXdyL1EyclNvUFJGeWEyQmEzdFhvRjhmaUNTb1lz?=
 =?utf-8?B?V2psNnRpTTJ5b2c5dnd3WDR4RjVJeU9VSmVLUm5zMFNRditCM2JpWmd3UU95?=
 =?utf-8?B?MVNYWG56UzZqZHhHQ2RpVXkyZ2dvU3NQa09hQjkwT0NudmNHYTByY2ZGemwr?=
 =?utf-8?B?d0s5MEVQRCtEVmFzOFhCUm1rWmhvbUdHeVRpYXFHWDU3NXY5NVVsMXJwZXZL?=
 =?utf-8?B?a2J5dC9Tb2UzWGZRNXVabWI2bUNhUUFVT0U1VDNyRHNPdnVRMm93cm5aZXJG?=
 =?utf-8?B?RDg2UHBsTkF3M3RaWisxVUp5N3g2aXJRNlkrZzR5RmR2U2F3YTQ0azdpNHlY?=
 =?utf-8?B?MGVNb01KblZ6VUhTMldFVkpQc05LYThZUUZGWS9RSXU4U2l2M3NSVHBzS3pp?=
 =?utf-8?B?QzhUZmg2aUFRZHBlWjF5TG9kK0tSRTE2N1FiK0Rld3BpSjBBSmhxdUNxdE1L?=
 =?utf-8?B?WGZYYUxNZVVNRmwrZkpCYTFObkJieXo4QVBIN0pOR0tWdUI2bUIwb2FJaGto?=
 =?utf-8?B?Yzk2NmY3VW9DV0xKTWNCclNOVzgxaFhna0YvUExhTGlaSTZ6UUVHSWZhME9U?=
 =?utf-8?B?VTNReWxldWRIUFp0aC94N0c2amFmNzJySWhGYzl4ZGxmY1hEQTRUcjMzSU02?=
 =?utf-8?B?S0ZFSldrN3dScDJ6VmczazJ0SkRNZzJOR0E2ay9uZ056RTFqK0NQSmN6d3lU?=
 =?utf-8?B?WnFGeEJhdHZyTG9OREdGaXVQeDZOeHZTZGdTaVB5VFIxZld2dERETnQvVGxZ?=
 =?utf-8?Q?6mBmJV0fOEG5aC3S+2kv7PKnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a8006a-8d4b-4f7e-d606-08db6921d99c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:43:50.9883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rtg1YewzQ4fBuQKWvX4R4dvutMoRlavMxaVSsCdIAgnopag3flolTu1S3aNjY4InBng6iUc6tyTKSvRp8+oqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-08 13:07, James Zhu wrote:
> Set waiter's activated flag true when event age unmatchs with last_event_age.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index c7689181cc22..4c6907507190 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -41,6 +41,7 @@ struct kfd_event_waiter {
>   	wait_queue_entry_t wait;
>   	struct kfd_event *event; /* Event to wait for */
>   	bool activated;		 /* Becomes true when event is signaled */
> +	bool event_age_enabled;  /* set to true when last_event_age is non-zero */
>   };
>   
>   /*
> @@ -797,9 +798,9 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
>   
>   static int init_event_waiter(struct kfd_process *p,
>   		struct kfd_event_waiter *waiter,
> -		uint32_t event_id)
> +		struct kfd_event_data *event_data)
>   {
> -	struct kfd_event *ev = lookup_event_by_id(p, event_id);
> +	struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
>   
>   	if (!ev)
>   		return -EINVAL;
> @@ -808,6 +809,13 @@ static int init_event_waiter(struct kfd_process *p,
>   	waiter->event = ev;
>   	waiter->activated = ev->signaled;
>   	ev->signaled = ev->signaled && !ev->auto_reset;
> +
> +	/* last_event_age = 0 reserved for backward compatible */
> +	waiter->event_age_enabled = !!event_data->signal_event_data.last_event_age;
> +	if (waiter->event_age_enabled &&
> +		ev->event_age != event_data->signal_event_data.last_event_age)
> +		WRITE_ONCE(waiter->activated, true);

This needs to check the event type. Looking at 
event_data->signal_event_data when this is not a signal event is 
illegal, because it is aliased in a union with other event type data.

Other than that, the series looks good to me now.

Regards,
   Felix


> +
>   	if (!waiter->activated)
>   		add_wait_queue(&ev->wq, &waiter->wait);
>   	spin_unlock(&ev->lock);
> @@ -948,8 +956,7 @@ int kfd_wait_on_events(struct kfd_process *p,
>   			goto out_unlock;
>   		}
>   
> -		ret = init_event_waiter(p, &event_waiters[i],
> -					event_data.event_id);
> +		ret = init_event_waiter(p, &event_waiters[i], &event_data);
>   		if (ret)
>   			goto out_unlock;
>   	}
