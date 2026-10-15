Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F950CC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 22:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233881124F5;
	Thu, 15 Oct 2026 22:09:19 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017841124EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 22:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1my3ZbeSaGIZCajLhEGT/Fgh4YuCR8fIwvBhbvXsFqRwQ6dRUw+ezdBck3ruKCGD7LRDrshVKy3tH+mHutFkK60e8LfRfrm3wueZJIhV5ykjL+Gcxx2ATf2o0/3m8DDWqi+gQC9NKbY9OL2Hrsv+nw/Siw8gcMVpUL89AGFa11JZAuVRllv7mujrI66PU+iSZ16Z4bZoS+gOQf+kvKu8Pmg3vbXwIaPtDT43BBRX9zM/pKrakbZc0kHxhQ2ejtwnEB9mZ5G1nq4P3xW9a0hhRizpYEzK2j6U1rsg3p1sDaDyaU58xkjIaYWf6+fZVo71m6wrJRJIX2OC6Uu5mzSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arRPOskAxnAHdZeQCVAx3jBDZnwqf6uwZ9v9AtTokgA=;
 b=y8i7XzC0AbJFY1G+4gj+xg0+6YoBpipUH5LuofJSQn7kZz+7wXPz223x3NBXhmbbGXDhNyacJJsyLgfojdquifIpgXABynXqNOIZTiWB1RLasOWoRUVhGEWc/Y+ONbKNTZWx/RmfSaSW4YuB7c6CaTW8tDE/kB9W3ZkMtarQOkuVaCPBnSir2m73/QKGrILuCan6g32jJOL5FU8mP4ei1ao9Ld44s3mapOZc6MJNfmhlJIxx/IQRoB6H25V2nKsNhmz/bd005hXOOUJ5zXeMq3I0FCxnuKGq38WkgGia8NOKS1++PCnCyRtQowywzEi0JTRAzGtGyLH3FlgIlFQZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arRPOskAxnAHdZeQCVAx3jBDZnwqf6uwZ9v9AtTokgA=;
 b=LLbJqKLIXhvZYolBkIzuvE77rvn45CWLk1DQy6xy6yZYc/TywggU+wRneNWv6qn4rvAcA0N+kUuI+cVKuyjYNgtGdvk6ve7eRJPIVOEWYBnEZ17GCahdHCZLgOgIZ5Px798jjc2+CveGqlMPseiwk+EW53CVfAJCDs7b5L2Jx30=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by PH5PR12MB394451.namprd12.prod.outlook.com
 (2603:10b6:510:502::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 22:09:09 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 22:09:08 +0000
Message-ID: <30a0fe6e-2966-4f8b-b6b8-f7e0075195e6@amd.com>
Date: Thu, 15 Oct 2026 18:09:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdkfd: send SMI process and VM fault events only
 to allowed clients
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, David Yat Sin <david.yatsin@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
 <20261013092158.2261502-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261013092158.2261502-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::13) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|PH5PR12MB394451:EE_
X-MS-Office365-Filtering-Correlation-Id: e65c1897-9eb3-4cb6-993c-08df2b08ef2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|5023799004|4143699003|261009223027099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: rfKsEMy1QZMd6Pj9Ern+axRGlAjEvPdF6gp3/5vRELNhVUQ5gNHYkbN8akcaETnWwK+XAgo54yGwJcF9Oj1eCOiy7OUzm0c0Odx3Qhk5HJiAJpdAmBy3IzuWPS5MGzUdz0jzjXZ5KRXe34YDWNgwg66HYfbRiV3vUP5TfqngqH2nz1Upk9PVHlTtI5ZOe9sMrn7FHfujfxnSPyxdLe6/DOukUATL6aHMh26fz2alypahS7/PgY9ieeqJq12kQFhEHi/f/ZkEG0bWqj8+LCqZzHrVii+mCeOEGOGIg8TBD7swHgvklMyRSBBQ23G/pi2+6MJjw/po6m3+vkgbEOna9SXFbex5oY+ZRsPrsiP9avD/uHtfzzqfvMLFevsmBBVbVsghstjMeyMqxJCjbFkfKj41ja2Ek8Kf9Eo+v2z/jcWgv968IPSXTYsIngZuW8Lsymi/EDFd16lSmBjhrmGMa5xKFJuY3Az7olp3dyPkrMoVwQ+wy/OYoONnDrf85XwdfvZxGhNO27SuxQrnvG1Z6UZycszmHtGylObFnpwoQvwSKTS3xyo//u3FZ1U0AJOqLE46cCQlaojqET0lbAB9WNF3bfux4AbumThgIpiCMqPFFCtZEROTvtV9elutZPF6FPIsUYVDTRMY5wUqCNX4soIICK4rrqSxDTGvrQxspaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzY3UldGRnYycGQxRnRySW9YR3Y2TytKUDFsL1ZMcC9aaHFkZW1RWUpCaCtk?=
 =?utf-8?B?VWR4R3BpZ1JWaGlwcmYvWVhHL2NvTnFhNVMrUDlEQVJUbEpNOEpJdWZzd3VX?=
 =?utf-8?B?V3l6NFR0eDBSSHc4aE5xYllQMXd1b215VHl0d2drTWdjNlFORi9aS2RSZW9m?=
 =?utf-8?B?Y3JkTDc1WDMvQTU4V3JrQXV0OGkvc2ZFc3h4R002OXRITUhueXJDMnZjQ1RQ?=
 =?utf-8?B?bGo4dFRJZzJIUFZQT21zOTBacVdqSWRpd1ErWjQvYm9OWDhBbkx6SDdFdWVB?=
 =?utf-8?B?YS9jczRMV0ZGU1RNNk5XbFZYSHFReWQ3RkNnSUJJTzdCL1JtZFlwUmlhcVhF?=
 =?utf-8?B?TjBxdUJWTWVnNVVJWjgzdGNRbHFGQzdVTjJEempxZHduclcycUhWV1ppTFpZ?=
 =?utf-8?B?OE53VHNxdk8xaExkWks5Y1Q1NGtTSzVUWTdlZWZSQ3pWd0pleWFKMlZ4L0ZH?=
 =?utf-8?B?ZlJMd2VIeDQ0WUtSMDM4TnBJYzRiejAybHZLQ1RGYktsMElDbHkzTmtReDVO?=
 =?utf-8?B?QzcvOXBNaXZLWlQyM2NSQkFuQWpkTmVEbWE5U1BLaHBuMXZQcnJqdTEwRzVq?=
 =?utf-8?B?N3cyUEhEQlB3Zm55a2tXdkZRN2RObnYweHRrd2dDemZldzBRRG9wTmRCNC94?=
 =?utf-8?B?bExlQWFqVWdFaUhxQWpkZHAzK21CeFluNThHOHY0TitjOFZ3OUk2d3VFSjM5?=
 =?utf-8?B?c3dsMTRPYnRQcisvdmFMeUxPK0JqQjU1aW1CTTEvTEN4blo3N3NsZGl1amo3?=
 =?utf-8?B?NnU4Q1dZMjlGeE5XYVFUamZNZk1jd3pFWGxMV0o3K3BEeDVEZmZib0twdC9N?=
 =?utf-8?B?U2xTSUVQRTA5TE9ZYkU0VllEeCtTVFlxVU9NOXVLSW0vdzhDRjF5amMwZElR?=
 =?utf-8?B?RUZLanUvREhGbERudk5ueFY4NXBpSXd5V2t3VE1jOThqWUsyMEF0SUVwUXJN?=
 =?utf-8?B?Y0lUS2pUNVpkK0l6eVNHK2Z5ejZ6S3JJdFp0VGFQZzlsby9FOWxXNUpob0xn?=
 =?utf-8?B?QkxFTkJrb0YwYkxoZU9yQ2RZSVQvcUFtWlJITk5XWWhIY3pZRzl4eXdZRWxi?=
 =?utf-8?B?YUJtdGdGODdQM1pEWmppd3dFZ1h6b3QxRTBkQW1hSDRnZ0JnTm1OTlFDaVBq?=
 =?utf-8?B?K01YSDlhRzJHQlFweXRqRnQvb3E5UkpMLzh4M1VkOFQ4aU5OV2xuU1JVTU5y?=
 =?utf-8?B?dmNmTW1zY2lUc1dHSHRrUGh6SjBoR2xRZFZVZWpmUkdsMXc1MVlna3lubUdX?=
 =?utf-8?B?dm4zYjdQcU53dmRqNm1VbWRHZC9jNEdkNC9oY2d4RHk1U0RWZllWYk9vWU0z?=
 =?utf-8?B?UW1oVHNjalg2TzBxTis4eDBqWEFQRmJhZEswUmFaT0UwdmlPNjR2QXl6V0xh?=
 =?utf-8?B?NEtQQS8rTHA1M1ZWWk1reDV5RUxJcW1oMVg1R0psL2dYNmJuWWw2NllJZFFr?=
 =?utf-8?B?akdBUUVCcTQzeUgyTm9RT0IwaE1CSlg3WlJKY2ZKVnZWejZJZUMwVVpGcURM?=
 =?utf-8?B?NGRZZVVVQnYxRmNZamFCT0VmNVkxL1NKUFF4S3BJZHpEdEtUWGNpeE5DNEpW?=
 =?utf-8?B?Tm91ZXJYTThiS0ozTmJ5Q1d4NFViUklBQVhqeHA0czZTa3kwekozT2VaaFBV?=
 =?utf-8?B?TW0vNWUrS1BwdklnMWdvdXhkZTF5NFQwZFlJcHVwWjE1d2FSbXpSL05hUC9D?=
 =?utf-8?B?cEdHVHJDT3JncTExeW85QzR6ekRRc2YxSlJBd2lGeXFSL2hqTjJQQTlRVXg5?=
 =?utf-8?B?bi9JVllGY0M5SS9HeXdBc3hzTnBxK2d0OWd6cTlKM09EbGhua3ExOVBqaHh4?=
 =?utf-8?B?QUZwVU9zOE1NLzdvcUpiTEN6WjdJN1FrbnNmTkg4QkV3MW5MZTUvUlMwSUN0?=
 =?utf-8?B?OWlEelZoTkN4RERrMTR6NDBYZlBBRFZiSnRHVTNKVHM5K2llY0ZOaFVpM2RI?=
 =?utf-8?B?dm9jNXNUUkM0TWc1ZWlSeFRhQXQyQ3lUeWpEWDEzLzVJZ2FWVnFpQjBXajZC?=
 =?utf-8?B?ZmhoSHhod2tnNDg2d0xPWmNkUUcvSWtra3ByaW53Z0k2MVVlSUJFd0cyenJD?=
 =?utf-8?B?bG9UcWxXUW5SSnJzUjFrQTNzU1RxMVR1RVlXREtiL3o4TW96cFJvbmxPR2lY?=
 =?utf-8?B?MzJqVzVJNUkzU1N1d1N4R25Db3l4QllJcXphaDZ6RW5KL1IyVk5ac2FtNHZX?=
 =?utf-8?B?R01hdUhVekNjRGxLMlVhdTFCOE12ODN6VVlIRndsajNLcjFJd1VjRlFOdFhx?=
 =?utf-8?B?eVprMHYvQ3NqNWxmTXlHeEl6dWVRR3l1d3U3UEl4ZUhib2graGhYL01HcEVX?=
 =?utf-8?B?SjV3OU9IY3ZuZmxUMmVHNEFFSy9MeEZZaDBySzM1Q1pXcWc3a1NnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c1897-9eb3-4cb6-993c-08df2b08ef2b
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 22:09:08.4191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nstx1lA+Y16DaCnWe/su2K+rYIPyO69uw9YgkHWf9NysOgPJ9P0fXkvBywoUBmxihJjib3tUuXiyu3mcXH0Lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR12MB394451
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

On 2026-10-13 05:20, Jesse Zhang wrote:
> Commit a403d3f65c79 ("drm/amdkfd: fix SMI event cross-process
> information leak") made the VMFAULT and PROCESS_START/END SMI events
> carry the pid of the process they are about, so that
> kfd_smi_ev_enabled() only passes them to clients of that process and to
> privileged clients. Commit fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID
> reporting for containers") then switched kfd_smi_event_add() to take a
> task and passed NULL for these events, i.e. pid 0, which every client
> receives again.
>
> On navi31, an unprivileged SMI client (uid 1000) subscribed to
> PROCESS_START/END sees root running rocminfo:
>
>    event: c 223a9 rocminfo
>    event: d 223a9 rocminfo
>
> The same commit also made the filter compare PIDs of different
> namespaces: the client stores its PID in its own namespace and events
> use the PID of the task in the task's namespace, so a client that is
> PID 1 in one container receives the events of PID 1 in another. And an
> exited task has no PID in its namespace anymore, which gives pid 0 for
> PROCESS_END.
>
> Match clients by global TGID, which is unique and stays valid after the
> task exited, and keep showing the namespace PID in the event text. Pass
> the TGID of the process for the process and VM fault events again. With
> this the unprivileged client gets nothing, a root client still gets both
> events, and an unprivileged client that is PID 1 in its own PID
> namespace no longer gets the events of rocminfo running as PID 1 in
> another one.
>
> Fixes: fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID reporting for containers")

This was a commit by Andrew, who is no longer here. Harish reviewed it 
at the time. @Harish, can you take a look at this as well?


> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 50 ++++++++++++---------
>   1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 6a7b4d959541..2950b871cb7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -210,27 +210,33 @@ static inline pid_t kfd_smi_task_to_pid(struct task_struct *task)
>   	return task ? task_tgid_nr_ns(task, task_active_pid_ns(task)) : 0;
>   }
>   
> +/*
> + * Clients are matched by global TGID, which is unique across PID namespaces
> + * and stays valid after the task exited. Events show kfd_smi_task_to_pid().
> + */
> +static inline pid_t kfd_smi_task_tgid(struct task_struct *task)
> +{
> +	return task ? task_tgid_nr(task) : 0;
> +}
> +
>   __printf(4, 5)
> -static void kfd_smi_event_add(struct task_struct *task, struct kfd_node *dev,
> +static void kfd_smi_event_add(pid_t tgid, struct kfd_node *dev,

Please update add_event_to_kfifo and kfd_smi_ev_enabled as well to 
rename the pid parameter to tgid.


>   			      unsigned int event, char *fmt, ...)
>   {
>   	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
>   	int len;
>   	va_list args;
> -	pid_t pid;
>   
>   	if (list_empty(&dev->smi_clients))
>   		return;
>   
> -	pid = kfd_smi_task_to_pid(task);
> -
>   	len = scnprintf(fifo_in, sizeof(fifo_in), "%x ", event);
>   
>   	va_start(args, fmt);
>   	len += vscnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
>   	va_end(args);
>   
> -	add_event_to_kfifo(pid, dev, event, fifo_in, len);
> +	add_event_to_kfifo(tgid, dev, event, fifo_in, len);
>   }
>   
>   void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> @@ -252,14 +258,14 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
>   		amdgpu_reset_get_desc(reset_context, reset_cause,
>   				      sizeof(reset_cause));
>   
> -	kfd_smi_event_add(NULL, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
> +	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
>   			  dev->reset_seq_num, reset_cause));
>   }
>   
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   					     uint64_t throttle_bitmask)
>   {
> -	kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
>   			  KFD_EVENT_FMT_THERMAL_THROTTLING(
>   			  throttle_bitmask,
>   			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
> @@ -271,10 +277,14 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   
>   	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>   	if (task_info) {
> -		/* Report VM faults from user applications, not retry from kernel */
> +		/*
> +		 * Report VM faults from user applications, not retry from
> +		 * kernel, and only to clients allowed to see that process.
> +		 */
>   		if (task_info->task.pid)
> -			kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
> -					  task_info->task.pid, task_info->task.comm));
> +			kfd_smi_event_add(task_info->tgid, dev, KFD_SMI_EVENT_VMFAULT,
> +					  KFD_EVENT_FMT_VMFAULT(task_info->task.pid,
> +								task_info->task.comm));
>   		amdgpu_vm_put_task_info(task_info);
>   	}
>   }
> @@ -283,7 +293,7 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *t
>   				    unsigned long address, bool write_fault,
>   				    ktime_t ts)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_START,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_PAGE_FAULT_START,
>   			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),
>   			  kfd_smi_task_to_pid(task), address, node->id,
>   			  write_fault ? 'W' : 'R'));
> @@ -292,7 +302,7 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *t
>   void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struct *task,
>   				  unsigned long address, bool migration)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_END,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_PAGE_FAULT_END,
>   			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), address, node->id,
>   			  migration ? 'M' : 'U'));
> @@ -304,7 +314,7 @@ void kfd_smi_event_migration_start(struct kfd_node *node, struct task_struct *ta
>   				   uint32_t prefetch_loc, uint32_t preferred_loc,
>   				   uint32_t trigger)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_START,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_MIGRATE_START,
>   			  KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), start, end - start, from,
>   			  to, prefetch_loc, preferred_loc, trigger));
> @@ -315,7 +325,7 @@ void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task
>   				 uint32_t from, uint32_t to, uint32_t trigger,
>   				 int error_code)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_END,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_MIGRATE_END,
>   			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), start, end - start, from,
>   			  to, trigger, error_code));
> @@ -324,14 +334,14 @@ void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task
>   void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struct *task,
>   				  uint32_t trigger)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_EVICTION,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_QUEUE_EVICTION,
>   			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), node->id, trigger));
>   }
>   
>   void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct *task)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_RESTORE,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_QUEUE_RESTORE,
>   			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), node->id, '0'));
>   }
> @@ -348,7 +358,7 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> -		kfd_smi_event_add(p->lead_thread, pdd->dev,
> +		kfd_smi_event_add(kfd_smi_task_tgid(p->lead_thread), pdd->dev,
>   				  KFD_SMI_EVENT_QUEUE_RESTORE,
>   				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
>   				  kfd_smi_task_to_pid(p->lead_thread),
> @@ -361,7 +371,7 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struct *tas
>   				  unsigned long address, unsigned long last,
>   				  uint32_t trigger)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
>   			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), address,
>   			  last - address + 1, node->id, trigger));
> @@ -379,7 +389,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
>   	task_info = amdgpu_vm_get_task_info_vm(avm);
>   
>   	if (task_info) {
> -		kfd_smi_event_add(NULL, pdd->dev,
> +		kfd_smi_event_add(kfd_smi_task_tgid(pdd->process->lead_thread), pdd->dev,
>   				  start ? KFD_SMI_EVENT_PROCESS_START :
>   				  KFD_SMI_EVENT_PROCESS_END,
>   				  KFD_EVENT_FMT_PROCESS(task_info->task.pid,
> @@ -408,7 +418,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
>   	spin_lock_init(&client->lock);
>   	client->events = 0;
>   	client->dev = dev;
> -	client->pid = kfd_smi_task_to_pid(current);
> +	client->pid = kfd_smi_task_tgid(current);

Also rename client->pid to client->tgid to be consistent and make it 
obvious what kind of ID is being compared everywhere in the code.

Regards,
   Felix


>   	client->suser = capable(CAP_SYS_ADMIN);
>   
>   	spin_lock(&dev->smi_lock);
