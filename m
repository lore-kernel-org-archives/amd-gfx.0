Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6870C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506A710E52D;
	Wed,  7 Jun 2023 17:27:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F8A10E539
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX2qxx2QXfAnO84jgvVdEIn253SMN9R1TIyTLZ+n4Jwa4/BVHdwLRlsu9ZPW+O1EP1srBR+3j2w9nKornJXApxlMPXyu2jzSmhAJz3U3/+2PhleNJ8uKhzEVy0vsLNiM+kGDgdyfqEi1gyYYltEfYRaNZfiV/o8Mpm5eq9EQ9IDofjpkwG+h/XwHCLm+dL1wZw+Eea+7VpOF4rP7vDDgNIe/t73P86iOe47uW10NjEKYPfW36AKOw4K0ZuKqLAF97CqHmeZDWoPEqJXuZPSmCw9+slrJhUfFa+hrj+H198Eo8nxzHo+G84HFq/NxTIkJQe2l7KBJiBIs1YlDqeoL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpWhpEogxs68KjiMkSyF0xMRkpQH0PKhstBo3qnP1/M=;
 b=HCsMwS6jzXSZU84K6rBzxaLiDxVF8IzW64GZcwWaqytMRtja0EZ/rtK7wQMXDmlfauVp4I9VPCFCaz6aomDaPWCmvEnv/LXCfJq7tATJstCXpYIaVmhMoZhiinb/2aHB2zyua6XwekUtv4qJb6m6IHWfoPbbnoEwKzPXrZWXxZa45LokoPe1YnoehlOCZ6GmJrieCT/7FvcnG5+7U0zqdnUP6h2oOApwPtsg77G5gIaa/wYio/c47E78wUFZAIQjQdEE8nmbuPiXKa9RTR81fQvBxG95LctpP275TLoP5HEbpdIhUqY0WAGhE+875raC4M6MBIXOwG+Dnrz7AoBwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpWhpEogxs68KjiMkSyF0xMRkpQH0PKhstBo3qnP1/M=;
 b=BA8zPrb8Q5BOyOzOS4m+z8EFIOM5ZS9gRF9DbtCi5TO8/cG7wp1rf4MlDxgklo0GfMeJzeENDDFqmyMj8fjh0kq5bh0/VKvMymxd6x50/kYC+lw4Pop7pcRYtu1LDQxkJuwxDhpx1kbR5ZSgB6+jUi6dW6CGImSxMoJDod0cTZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:27:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:27:28 +0000
Message-ID: <d7674f97-f5cb-9b79-ed1a-a499fcea27f9@amd.com>
Date: Wed, 7 Jun 2023 13:27:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] drm/amdkfd: don't sleep when event age unmatch
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230606162418.1862540-1-James.Zhu@amd.com>
 <20230606162418.1862540-4-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230606162418.1862540-4-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 1752946f-d642-4ef0-4021-08db677c77b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naKewCHciVwfxH9iocOj4dAQlzla0MWzkReYRv1fKjYAscEz7+qnIsv3oeqgxMO+IA7kYjFlczkfofe8EI2da9I/yqqSTAz+kh+5kqXsOFoHCpe9p76z3Sw1wzN6D8yCkEFfQPZIPrwc661bu2xhomStIlFy3sD5smA08nCka4stCh1MAQdPEyw207TQ6XD8L7gZvQzNU0989qOloLMeb6R/KAQ/G4nHVz6rzXIko1zQWqQGyaiQ1IDHqnBqi2axPCBS05dvytxeNUDhU8FAjQriBBZMwckeGy146UC9/KMMIxFgQ881pKSYW/oWVJl1fZikrNnQot5zeoaAMAIsIc0+FGPM0Wkz17DwRXCK+5PjOYBbXhxZ9jjU3uYWd17d3jKTEBmKbGOJQTuLL6phQdluFRSBpmwvzRjQFLfFJsGm/U/s6ssseEdld+tORTC83uo/g6+EI4Z4xvPK3tfD0+3G4yoO2hZ0xJX7aqYG4aBr74NneJ70uLIkxpme61flhTcXXdDYy9+BqxrBxqC62l3h3ImKOXNIB1YgFRr9EkZSefUngLQA6TXS8+kxKO2sN0bukcXXEfVlJIs9ng5642kKXe/CUA9mF9fuo94tvgfygw9KvM45M/JUuG8P1t+W20DFiXYslLj1LdpB5cWsIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(31696002)(5660300002)(186003)(86362001)(31686004)(26005)(6512007)(36756003)(2906002)(53546011)(6506007)(316002)(44832011)(8676002)(8936002)(41300700001)(4326008)(38100700002)(66556008)(66476007)(66946007)(36916002)(478600001)(2616005)(83380400001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VYUUExbkF5eUZ5TWt3WTNTUHpOeTJaNW1RUUY3ZkRYT0NNNXRVdmFMRkFO?=
 =?utf-8?B?eEZaUS96akowbGRDbkd0ZHhvKzZxUXcybmpKQTk1aVZlY1lXVEZrdmdlYmhP?=
 =?utf-8?B?UTRXTlE3Y2pSeWdnZDZMbGh4bmIyQngyajJpL1Y2MDZCRkliNGR0M2Ric0dG?=
 =?utf-8?B?d0ZNNWFrK0VSWmZManpZN2RyaDJMYmdGd2k3Vk4vbWZPbHRnaFNkRjVsbU1a?=
 =?utf-8?B?OHNVcXdLRE9aZnRFWmdGRkdtZDBrUkxmdWpwaUd3Q09jRkt5TmJQbGZ6T2l2?=
 =?utf-8?B?bW5xeUpOZFMray9SaHRYYVltSUplTXozM0FjblNINmJWb0Z1MFljV0IyaG5I?=
 =?utf-8?B?eWgrL294cnh3eS9VVUw1REV3a3lKOGpYeFR0Nlg1Qzd3TUZIakFabWtLNGpM?=
 =?utf-8?B?Q05ya2dFQ2pyemVDemZzUDlTZ1U2RkJVcHg0NDBTaU14eXA3RzhYWUtPbWNP?=
 =?utf-8?B?UTY2MHkvWVNISW9CaGdnaEJmcXdId3RFY2o5UzArVHE5d05DbG5nQTlHUHls?=
 =?utf-8?B?MEpUT0d0NEhlSUg4NkgrZUhqODljdWFnT0tQSGFIZ0Rka1ZKZkVQMS8zV2pP?=
 =?utf-8?B?SlFMNWZ6SHJVYUJPMWNiUy9PaVhiSmIrUnk2ZW8yMTNWWEhOWlRIdjBvRXEr?=
 =?utf-8?B?SXQ3S2dTTFlhZU5mejAxWDBGU0plUXJUS3d4Rm93dUJnRnlNdkdXWUdKNzhi?=
 =?utf-8?B?ZmpKTWM2UllnQkF5eXp6NkxpbTdhSWMzdlpVejVncmVxZ1ExVUFOSXhERlV3?=
 =?utf-8?B?NmxsTmVTL1FKY1BhREpRV012Q2w3bWNleFFVUmJ0eEgwY2dTTU5rZDdTTE9E?=
 =?utf-8?B?TmMyTlovSDdOYjhDR1BNTnUxMVRXU2k4S0ZJMDdkOHdjQytNVGhBTGRmYU9S?=
 =?utf-8?B?QmpNWWk5MWxhL2xJV0hDeU90aHpNcmZiNDRZRTlzZUNKQU5zRkNaZkZiNTBG?=
 =?utf-8?B?eHRMeE0zOERSVGVDbW05RXoyekt6VHpLdUN5YWpoaWFJYWxFY3hNS0kvanBV?=
 =?utf-8?B?U1JxT1lpaSswcTVWbG4yVDBEa1hhUUhqaVVPQXI0V2VXdDAzcnA5WUdWUDRP?=
 =?utf-8?B?bEkwYTJtcTdoRzJ3RzFoMDIrbXI4NllYZXJCSnNSeWI4RDhJTll5dzUvVzBV?=
 =?utf-8?B?Ym9zYXg0SjFjZXBhSloraWpINFdlWTRKdk1Va1A0Y3dsbk1ZNkZEYy9FVVJr?=
 =?utf-8?B?WlRQTzFFSzNvbDl2VGRyU2NKc2pIekN3TkgwNGQ2TzAwYWxPMnAxWVBwV0wz?=
 =?utf-8?B?VWZrZEh0L3NjR1MwUzZJY2NBdUJ0Wm9EdmxnZkpPcDJwaE5PSU1lcFRwaXds?=
 =?utf-8?B?WEdZUkFlYkJMenRXZXVnY3VINFRVaVlJeUZOcWkvRndWSFRZMk9NUE9kU282?=
 =?utf-8?B?ckdmZjlyNkpRdDI5bUtCUk5lWjhrM1VkNGdxR0RhbUoyZ05iS3BvY3FReTdU?=
 =?utf-8?B?V3h6ejlnQlgrSzRoQ2x4dFRsczNYRWNoY3R0ZVN0R0NBZmxjUDZ4ODU2Zmtp?=
 =?utf-8?B?MXFrbDFmVStRMGszR3pyNlc0RVdTL3lXT0o4dkF3TUF1WlpyTktSOWI3eTRH?=
 =?utf-8?B?TFdYSG93YUpad1VGVlVKWUpqRnU0R1N2NU9Mc2l0R0VKSFZycFh3cjdpak5T?=
 =?utf-8?B?K0crZTlNMk8wZUl6a1AwazNpNksvT3hBaTI5RDJ0WHo1bkxsWlhPZTU5cnV6?=
 =?utf-8?B?UU5HV1gyU2pXcnI2UlBkMDMvaXFPOHNJSlFxNWR6RHBydm1ZM0RrUFZJWUFt?=
 =?utf-8?B?TkE3UlRTNEt4TzA1OUExZlhxNVFMeDlJZFYrdS8vY2c3UW96OTJqSVd1TnRM?=
 =?utf-8?B?ZEgycUJTUDFGcGIzU3BYYkEwZ2NkR2g1aVNqYUlSbkFKZDg5YVdqd3NUY1Ur?=
 =?utf-8?B?OWJXcmRCWENkNVphWlY3MjQ5M0I1VlZGTEw3UnVRQ1JpSHA2RW9qYVJTeW9T?=
 =?utf-8?B?QU5SZis5Vi80TVZQdjlHRnBjNW0veHVpWFE4RW1ldnJPTlRGUlhqa3JjWFBX?=
 =?utf-8?B?WHpkRXJDL2NKclFMZUdwT2RvYWVFNUpmSGU5RHpVSXo2NTdjSmVGQTRqNDdF?=
 =?utf-8?B?ZlZsRU40OHVEazRBYjc5ZGxQSG1tWC9yVWtIUysrWUgxMDFxeUJCMWEvTDMw?=
 =?utf-8?Q?rAXc3Xd5VxfmTaztYbRWjczPN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1752946f-d642-4ef0-4021-08db677c77b9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:27:28.6715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vjY9T4W1m69o5mPJWi/9ZezSEiFJTpBWuO3UmEn2Dk2JFsblehPwIb92sJj5Ld6BncKWXIuxnmA1fvQjcS7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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

On 2023-06-06 12:24, James Zhu wrote:
> Don't sleep when event age unmatch, and update last_event_age.
> It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index c7689181cc22..f4ceb5be78ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -952,6 +952,21 @@ int kfd_wait_on_events(struct kfd_process *p,
>   					event_data.event_id);
>   		if (ret)
>   			goto out_unlock;
> +
> +		/* last_event_age = 0 reserved for backward compatible */
> +		if (event_data.signal_event_data.last_event_age &&
> +			event_waiters[i].event->event_age !=
> +				event_data.signal_event_data.last_event_age) {
> +			event_data.signal_event_data.last_event_age =
> +				event_waiters[i].event->event_age;

The event_age is updated in set_event under the event->spin_lock. You 
need to take that lock for this check here as well.

I think the easiest way to do this would be to move the check into 
init_event_waiter. That way you can initialize the waiter as activated 
if the event age is not up to date.


> +			WRITE_ONCE(event_waiters[i].activated, true);
> +
> +			if (copy_to_user(&events[i], &event_data,
> +				sizeof(struct kfd_event_data))) {
> +				ret = -EFAULT;
> +				goto out_unlock;
> +			}
> +		}

I think we also need to update the event age in event data after an 
event has signaled. You should probably move updating and copying of the 
event age to user mode into copy_signaled_event_data. That way it would 
handle all the cases.

Regards,
   Felix


>   	}
>   
>   	/* Check condition once. */
