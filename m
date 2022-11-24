Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C0AC43219
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392C210E280;
	Thu, 24 Nov 2022 21:24:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EF910E280
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9bTsm7i3RhXGbdXswhc5yjuB3y0HNLdNEe4tMY/7FN7GtW5yAGMzHe2Bgb678C/F9jV6/sdrgkUYsaKwyiv6T+16Woc+FSXA8BWfHucqj3p9OOrAx6l3vAdpOiyykgjMYwe7isgtcgimQuciMgJlaD5A78dNuKl+E9yBPBNjIQCDzD+/Gwc1XPfJk3UJzkA9sos40AzBjcBd6O42TywbmiH8mNU945PhwprAnyhJxQtFi0t4Ns1BZnJGwig3ADI6Tnm86KkxLm1wrhNXFaQyty2h/dz/f2u70guIr8g9FcTHgXQWlfYaDWe/mqH93/Nvy2zU/nuUlqYwcKPPydWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k13U3s3Rwzyva8YIjrNWGyHTybJkZD9R0F8mCQOQqTU=;
 b=ZqAnzHDkGuTuAojsgw8RQgWAeVz+YmP96qQcA+voVNxlBKzEAhVRb1k0IeJg8YXlmK/+C7Cm3TZkYOSzhXyjgu4P0nsbrNzdYFC1MLEC6Q+itlGptGs8GH0tiyOc33WxhnFh5B7AwRonPqSJjqpTRLvZlJCi/TILmBCtcxra0cvlcv/yFVcmO3xrsDqv75WHOYbZxheafDC095jYLoMApJ0umb1E5Bz9KP/2dD27eJzCAHkuOmNJPH7FGXwQ3/Vqg2FpM1PyzdLrztN1fvw8tukyh9Zba+iVMiDyPtRAbymjMHyUEKU/wvJe1I3TVIdiaMJOGtewMUD8lckRcWXsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k13U3s3Rwzyva8YIjrNWGyHTybJkZD9R0F8mCQOQqTU=;
 b=e38EBllONG6ZXq+J0m/qEWNCR+eucM7jv9uNxnaBuVnKW95m72gOdrJOq+nGIzqImcYzwdEw8i3B8SaN3fo5mGbp2BULRCKmpsPvzsFTDgeYfq/tmstDzSNv4HsPwBoRHs72Rjusy3eQcWnpphiSJNs0Gm589DP8WYPqPNXcZSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18; Thu, 24 Nov 2022 21:24:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 21:24:44 +0000
Message-ID: <a4bcafff-1e5a-9b2a-6d36-b3eba6a9792e@amd.com>
Date: Thu, 24 Nov 2022 16:24:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 19/29] drm/amdkfd: add debug set exceptions enabled
 operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-19-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-19-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b17f018-d253-43dc-2259-08dace624ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vPYSh/nO7ygzsoO+4hUtUHGE49e0jX8arRIWiradVw1lwZMyTbwJ5kAQwRweieDqq6ot6jX3vCmGGMg0WsuTXE0foPTEErXjqdJoqqGERabUxVzWuscm0Dn7lJACvjgwkanjlayksf/N5dsjmDgZFrGKROlg8ytcfuDyLU+5Rx+W8XtRJDjIopsDf4Mhwm4cUpBCIzCDvHMfcB/gaiV8kzKYTFXEYRcIMgpevpTucY0UE+EB/gkY/WuF4d1JzoVfBAJaWa/+2R5LxLxQwEtmD1/SA/GCmvCkAhIFMRseQAses3BrepvKvJ5N44n2qKZLIi5Eu4HirNdR11w/YkIoXpiyNYZ4mv3L/K+eLVEPZSeN52go1Ly7LHApBsCxtZdAIYmMR6Khsft8Uhlr4W+02R7iMR/8+nsE43zXgc+d0pkKcx9ePbPqw8g24SxqKxR8eaBRTtXpu1XXyKemiYyF4sr/rJjbHxJOjBMiJTnX15wQYsRvWewrNnqhpet0hfvc0vDcsgocVmyyRr2ZzYmYrfufRciyGix/psYXjgRh1g4yZFhBwwDMQ8HABf7LrMvpfVzsj6LJ2b4c5dJ4zTTPTmQ1h6Vh3YxsLWmyHIZayyiwho0KhKY1BNA6UAU2zxNRPGrnVomXLKXQjkRaxfXxeJDTc5qap6QIh7shr6hu6rSajssHa/l5PqPw1LyDrtdmMrT7ZKjQDJ9JkX/MnsuIso2NohGEb3JslNKpXSp838=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(36756003)(86362001)(31696002)(6486002)(6506007)(478600001)(5660300002)(26005)(2906002)(8936002)(66476007)(4001150100001)(316002)(66946007)(44832011)(8676002)(66556008)(41300700001)(6512007)(38100700002)(186003)(2616005)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjl6bmJlaUxUZmZrTmNsWW9TNmR4Z1JadjlPVllackFIeXZJNkNkSWc3UzZm?=
 =?utf-8?B?S0d5WWhjSWswQWpIVzdQdUVjaFd1Z3QzdmVoRlVoa0Zjb0lOUVRvSUhvZU5U?=
 =?utf-8?B?WUhJMUhTSmhoM2FET2xXRW9SdHYxUEh1eEVTRjlCRUVBbjFYS0l3VnV1d0RZ?=
 =?utf-8?B?MXVrVG01OVRlTjlHdlUwZUF5bm40MXliQU9IT2tnVGF0TG9WRGV1VE9zK29k?=
 =?utf-8?B?TWFFREp2YWkzc2IrK0Roamt4ZnNVaG5zZkNpc2lpR2gvVlYxYnZUL3RDU2NO?=
 =?utf-8?B?YnliYXlIbU1Ebi9HTWVITDJJa0N4cXFLL3VISlpYQVMxMHJ3RnpGSnRpc2xY?=
 =?utf-8?B?ZUlXRVRDcnB1QnVLWWNGTDgxMHlkdkNMMnphU21HQ2o4OFh0VmxhYUwzTmFK?=
 =?utf-8?B?UjlWQXFTZXM3VGZFVk1ja2cyK28vdG1iNXMwdk8yczNRckpTd0NZb0NjWCs4?=
 =?utf-8?B?dHdUa2puME1TMGFqL0lUMXdsdGRLYVFIc0FzdGNlVnlZay9Ed1VPYllUQWdJ?=
 =?utf-8?B?ekxJNlFPNmJRYWxpU0ZpYzI3dkFRdjNwNDNZQk1xTThJeWNjVW1GL0M4V2Ri?=
 =?utf-8?B?a0FBSERvbURnVk5aMVVlNGxFbmdPMTdEb0NHVkI4NHN6d05UNUdzblpONFBL?=
 =?utf-8?B?Mi9CRVFVWTR0RmtFRllrakdkU2gxZ01nZ24wcVZYM1JlemYyUE85QXVyaW1U?=
 =?utf-8?B?bUJqZG16cjBpWFlmRk9JTXNKbStDbVpJVXo1bGFsRXBYNkNsdmw4eStRMUg0?=
 =?utf-8?B?MGd0SDdETGo1UmhMQUxJeGRHUDRXV0o5WWNJdUdUTnV1cXVuSEk2ckNYSjNw?=
 =?utf-8?B?bHJkM21MYU5iR0YrTnJLUTVVSE9XenZLQ0drYmdKNnhGbGJDWGIxNlVqVFRv?=
 =?utf-8?B?aHZETWVVREFIVTM4VFhBYkxNTExWUnlEazA1RUJNR1hSTnN3b25NSUovZkha?=
 =?utf-8?B?YjJUVC9hb1pObXl6aXYybDBhS05mR2t4NUZHNDhtTkk5QUtiWVZZeVhVeElT?=
 =?utf-8?B?RHNKR1hCcE9mWXozTVQvdk9Zc1hlMUtOZGFKYTZocVkrRFpYTThuOGpQR3Np?=
 =?utf-8?B?NnBkeUlrd29SL3NXOHV1aElZcDYyOVNlbUZ1U2dXWm9OWnhrdGVPZGJWd1BR?=
 =?utf-8?B?VzlkYVZsVHdrNFkxajB1Rk55M25NMnJoTk4zWDVlSkFhRi9hLzNMTHJkdzZ1?=
 =?utf-8?B?ekltL0lJS0ZJTk1HbGtnZ29SVE1xajNHM1I4ZTJFZW5hMWFCaHl4cGhsc1px?=
 =?utf-8?B?Vml6dzZDSnllbVR4VXdGUFVhZTFBT093anNvZ3d6VWdKV0hydmVlbjdMREww?=
 =?utf-8?B?ZzRHOUhRc2NTeUpNMjUvbnBWZGlJRTlRLy9RMHN5cGluYW5GejlVN1VTbWxl?=
 =?utf-8?B?S2IwY09SR2h6SG1kVXlqZkFLaGZoaVJiTmwrVEh2Zng3V09ueHhUelRQcHdH?=
 =?utf-8?B?eFlPblpwRkZJU0IrbkJXSjZRWk5QUkpKQlNiVVBja0hyUG9MekpvaVRKcU1K?=
 =?utf-8?B?M1ovUWtuaThGNHMyRVZBODkyclpnZHNnWTI3V3k5QmNHcHI5Y0tOcnI1K0Ry?=
 =?utf-8?B?Z3VlRnNZQ0FUaGxhL1NCZWcrWFJBaWZBcm44NU8vNmZkUE12K1VYMVdKTzhj?=
 =?utf-8?B?NVlQNjdHYldITTdDL00vYTNMVjlzVmUyWTNTWXhCSjY1Y1FXZFpxMTBINUNE?=
 =?utf-8?B?T3BBbm1Yald3WG1haTVrU1NoMk1SUEg2MUo4U21xUzJIYVp0N09yU1ZKank2?=
 =?utf-8?B?elJjdHg1SFl3U1dOemxabmZjbUVPcWJjQmlzelNYRGd5dm9aSUNXYXUwWFdv?=
 =?utf-8?B?bmhuY3haekJzNTg0WGRBOXpHaDBHdC84THlzSGtoMHFmUlhYRFFSR3U2VElq?=
 =?utf-8?B?WENBNXdQSHB3b0ZGN00wVXl6ODc1ellOKzJmemxMVXg5T1dTSk9oVXBQUWs1?=
 =?utf-8?B?U0luRS9mYzhDQmN6RllqWERGaGV2VkZZTGVjMjZNU3VJdURtMEFPSzE3ZmY5?=
 =?utf-8?B?OER5cjZwNGN4NWJwU01nLzNZUCtWMXJmckgxeFRvb1JNYTZaMUZYM0dsVDVF?=
 =?utf-8?B?VkJCTjZSWHNseWsxc0VJbThabjlCbDE3aXliaHVyL1k5LzkvTjV2TWtRSVM1?=
 =?utf-8?Q?ivffK3LP+cMLxrsaW0gJmNEec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b17f018-d253-43dc-2259-08dace624ea8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:24:44.8780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJr3Xz1hftf/0KN2wckENQO2wtX7cRjHEAXF+4s9o1FIs2IP+wfeUmepHj9DYY7Z6ywDVOOGWVdDqqZW8n7mTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

Am 2022-10-31 um 12:23 schrieb Jonathan Kim:
> The debugger subscibes to nofication for requested exceptions on attach.
> Allow the debugger to change its subsciption later on.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 36 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  2 ++
>   3 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 27cd5af72521..61612b9bdf8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2887,6 +2887,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				args->send_runtime_event.exception_mask);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
> +		kfd_dbg_set_enabled_debug_exception_mask(target,
> +				args->set_exceptions_enabled.exception_mask);
> +		break;
>   	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
>   	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
>   	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 3d304e8c286e..594ccca25cae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -441,3 +441,39 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   
>   	return r;
>   }
> +
> +void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
> +					uint64_t exception_set_mask)
> +{
> +	uint64_t found_mask = 0;
> +	struct process_queue_manager *pqm;
> +	struct process_queue_node *pqn;
> +	static const char write_data = '.';
> +	loff_t pos = 0;
> +	int i;
> +
> +	mutex_lock(&target->event_mutex);
> +
> +	found_mask |= target->exception_status;
> +
> +	pqm = &target->pqm;
> +	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
> +		if (!pqn)
> +			continue;
> +
> +		found_mask |= pqn->q->properties.exception_status;
> +	}
> +
> +	for (i = 0; i < target->n_pdds; i++) {
> +		struct kfd_process_device *pdd = target->pdds[i];
> +
> +		found_mask |= pdd->exception_status;
> +	}
> +
> +	if (exception_set_mask & found_mask)
> +		kernel_write(target->dbg_ev_file, &write_data, 1, &pos);
> +
> +	target->exception_enable_mask = exception_set_mask;
> +
> +	mutex_unlock(&target->event_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 5270d5749828..837e09491a76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -58,6 +58,8 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
>   
>   void debug_event_write_work_handler(struct work_struct *work);
>   
> +void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
> +					uint64_t exception_set_mask);
>   /*
>    * If GFX off is enabled, chips that do not support RLC restore for the debug
>    * registers will disable GFX off temporarily for the entire debug session.
