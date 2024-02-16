Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24265C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 20:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85A110E124;
	Fri, 16 Feb 2024 20:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEsua3Gw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8886210E124
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 20:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAvRwHv5NJbnN4yp9Dx0uNZcT0FQM88ObYA4zGfKxEnjvTzNx0ve+GVlH+zDUc2nssE2pfrArTB7HDNxIACckwiJM+PCBjvdZOJqGJlcJs/ZF+1w1IytIDh8sqISsXWtKekrjwssk69pqQBw7r9nqSaqwj9OtO63JRF+67IC4HgKGonEfohjwen4gLrvKPp7YqyYmY9LYxY0WdlAYNvFaEXr7scscNJXzxobWRc6sT8DqXyUPb2r4RqCqRWn6jXO6+pKgjRRWY9CHtmu8AtJynRKH00qnAdo0P8+z4ZDa/PYEFotU/+F8tBJoPEq1axqcSC0w6YgKy4z9DuiZSdiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv2AbsGIcFHCTUgtUbVUthxbwCkkTBDBsr8Z8bpVgmM=;
 b=jkqY+TpmK2SP7b7GtynXpQmKVxp4/b4MFqk3hAnB+dZ7fd+B9vy7yyc2fdLxeULUHpUx7ive9uboLulGoEB9iBOOgRkSzT1A/+nrA7IbP2qKg6008lGSk9i2DmgLRDnzTa6uQlHQSNn1Pa77D2c/p3Cce8tChgEwdLeaGgLCbvc35up8XgFta8SoKING0hq+CkC8SW/pxk9BTmK9TIU4P5yTs0KDD94t/FHKlzkpZsVkqiK7/eU36kknUMCIW+oD8NxYYkjlyUr+fSBlB9mTo7BBkRoeo6xeYvgW9HHj/t0UDCKK9BI8zpLK6/E9t+7Dn6Vc7s7mpwUbRLO3R7p7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv2AbsGIcFHCTUgtUbVUthxbwCkkTBDBsr8Z8bpVgmM=;
 b=mEsua3GwrlVZzxrN14sgTJ+7vuZnlXrQOL7YuEz3QGpgQk1frAnZFkv7mnyqImknBy6kKMDdNSO9Ggy+cLqJsUQthPymY8V4cPshRKOb3OIuGwq80thShY3Px/IhzPrkixyNYzLPko3pJRmnvzSWGPBynBgHXG26PJptOxATwqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 20:16:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 20:16:08 +0000
Message-ID: <0e86e558-3d3c-4d24-9de9-7691d3f672e6@amd.com>
Date: Fri, 16 Feb 2024 15:16:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Document and define SVM event tracing
 macro
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240215151830.22416-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240215151830.22416-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0058.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3910aa3d-c042-401d-d434-08dc2f2c1c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YRVYOzDahINyTRRm/b2tkKMyYaXoigrKkAppelLEG+n5kRO0AWLY25KvTdLTRDHNh765b9Rw4iZRsQ0fWgzsTuDLqHHMSp9kqGOx9JatY/yepbI30O49EGZKzkEKStip4Hv6STHOf36SJ3BBcGSIcK3/Mu4l/uXb+KcOwjTHIDbOovdZmeahU146lYYx3In+WpKeAQLGeRKrNhbBXIMNmsoS2vDecSQJLv+DV63hW3TXzmOliOf9CWiFQS5FtLGlf/6XaEEakA4YWR8rVaEEcTuCY/xQnQX0hm5p0k6vfKqiFCmiHlCq6C/UpxsyQ/Ca0BjpxV5vQYwPRtrrh+z0M/xCaAyRke483r7pd7+W+Cia+wRh6mhOYkoL6tofCpUFPDE2fUvV0DUdP0hz+OninsqpXusIVC8NoFDkhU817XNPuAZewJiRdXwGWEWiIKP/bxi60S5dax54AqihJFMeAJrgix/N4VPWLW5NL8ysWmr3nPHmllp1utB3DCBwfAlL7IckemsRM8smVonfLqIeOtxpYgkta0mC6GU0aHaRHvpYAnoAC1Vk6OqPoIEL9KZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(30864003)(6506007)(6512007)(26005)(36916002)(53546011)(2616005)(6486002)(36756003)(478600001)(38100700002)(86362001)(83380400001)(66556008)(8676002)(66946007)(8936002)(66476007)(5660300002)(31696002)(44832011)(316002)(31686004)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtNbmZkd2RKOVJaTEhlQk9mUGttQ2tuNGJQOE9PQnhvelMxNG5xeUZZcG1K?=
 =?utf-8?B?bVlyZXdyamNjeVJST3Fjd1ovSUkwNHh3UW11SEtVcWFNY0U0eGthN0pqYU1N?=
 =?utf-8?B?K0pFeVAvYWJqN3VkSGV3eE9kL01KdU15emVRVEZqUlRsbEV1eFlGWEpoZUp5?=
 =?utf-8?B?c0Y1dm5aRnhVa0s2UTdzMm55VnFGTFVpMlRDdzh6Z1Q3dUhFSVgzdEhLTkJv?=
 =?utf-8?B?SUlocWZla1R6TmZKVThEVW42d2lsRWdmYmV1cVZxWS9KSTkxam5qWnRwRnZo?=
 =?utf-8?B?cG1aMzRQeGR3VEZTYmd2dUQ0NTJydHFhSmhkd0VsZTdRWjF5VXFBMTVuNU1L?=
 =?utf-8?B?L2NiODIxVitKblZCRmNsQndxQ3lHb1ZqRHFLUkdEU1RZcFFTYnlMdjJoU05L?=
 =?utf-8?B?VlFkUXFsNUtsMmNxa3cySmpmWnBaZDc0bWF0cU5TcWVJT2xvWDkrOElPdkEr?=
 =?utf-8?B?TmtQU1JmN1FVRnhxVVdrU2JpT2JjamtCY1o1VjlUVlQ1UFM4ejRIdUp0bms0?=
 =?utf-8?B?bHFqVmxPWHhuaE5XcURZVlNoUHNYR2xEU3lDQVFnL3ZSNjdVZi95V2pLR3Jn?=
 =?utf-8?B?d2hmRmVaWGk5ajlMQ2lRN0x3SldyY1hxb0N3K0xQS2hVVG9EZGZmNGlHTm5E?=
 =?utf-8?B?RS9jclhrQTBSWkx1Z2NobzdMdHVrQVhNYnlmMkhtWDVJSzVQcTBzQlRTVnZY?=
 =?utf-8?B?aER3TTBWZC9SdERvM3VxUW41RTJKd2dmOUw2Z0NwZFY4MU1ZQ0lzUmZ5eUF4?=
 =?utf-8?B?M0FZZXB5MHRqK243dHhwU0cvRy9WTVNmcm5kUFNkaGQ0Ykg5OWQ1eElmdDc2?=
 =?utf-8?B?VGxnU05hRllUNVBRV1Y5SWluQlJORjhYSDd6cThSNDErT1JhdVJTclJaRmNY?=
 =?utf-8?B?K0Y1L0ZjWFRVbDVpakFnN3gxZE9EZ0FxWEUzUStoeTNvbkY3UXdoK2dYVUkw?=
 =?utf-8?B?eHFBTVBiTUw5dUZsd083cjVON1dFL3FycTBUcjRkbUdBNUdWTVRDTUhFaEpM?=
 =?utf-8?B?N2NXSVNKK1ZWSVBMcUZNK1lIbHpYTjJJSmlJQllUVWI0ZGRLT0o4UFJxMURX?=
 =?utf-8?B?RldIREd4RHhtZ25EVHcycWZrd28zYkk0QU8xRENkZ0FPOGJYL0VwQkYyeWh4?=
 =?utf-8?B?bEVQK0xwejMxd245MEIrMllZWXNUWGRFcTVyelpvZDBRMVhhejRZZDEydWhC?=
 =?utf-8?B?dXdtSmhXclZUUHpaMXl4aWQxcUdXSHRTUTJMbE9nRmFaUEVnYWdEMkxnS2pI?=
 =?utf-8?B?N0NvTWdNYzkwSFI4TGJKMkRmcStDeE8rdVFyL2tET3RlMnR3TytiU1BSTEdP?=
 =?utf-8?B?bExxVkRQU2UwdGVpSHFJeks2TVE1anU2V2NzWDRqcVFlZW81SnlrK2dZcmJ3?=
 =?utf-8?B?UkNKdXpocks1VkhFMm1vdlhaMUxPdGJEdlhwVy90VGdDM1dISXpRSHlZNHRZ?=
 =?utf-8?B?UEJvQTE0TkI4dHdYSFZrRTdUZGlQbk1XK2RNeXhPbnhFYzVMbHk0a2ZSNWcz?=
 =?utf-8?B?WkJhYjkyQ2FGeUI2dWZKM0RwOEhiem5JM216QnJ0eHQ4WXhkN1lnL1ZCT0hZ?=
 =?utf-8?B?N2hSS3RRQ05oQ0w1N2syQ1RrS0tXNGg5cnVId0dHSjJQQ0JtdGtDeEt0ZlR0?=
 =?utf-8?B?V0oyZjBGVFhlNW1idVQ3bVFOeUM2TVE3aUVlRjZMTGN4TE1LS0V2TWE1VVA1?=
 =?utf-8?B?ZStVSGhld3czdE9oOG1sM1dvRS9YUnNkOTZ6Ulc4WFJHeHhlY2JwWUxKQm5F?=
 =?utf-8?B?dmxhdXBMN3lGcnVjVEhXeFlKdUU0Qis1YlhYVm1mZmdvcENtRHo5NGIyUkNx?=
 =?utf-8?B?ZmJuUDRqdlBzNW1HcTlNODVIWHZkSFN6cDcxWWJtcTYrdWdoVytJdjNIblU3?=
 =?utf-8?B?RTIrejA2SlFVOEt5T1dyRHNzSVJDSFdvMmI5VERKOHFPL0owR2dqNmxCWkZu?=
 =?utf-8?B?N2NCaXZIUXp6VGdXaTZvMHBDakNxWHNySzJ0eHhLTGJ1R2w3eHFxaEg5Zm5P?=
 =?utf-8?B?YVBLTFh3Q3o3L0I0OE9yTEYwZUtURFFqOG9OL3pmU3U4UWVMaVpnUitjbGhN?=
 =?utf-8?B?UWlKS3FVSXZ6VW5wWGYrM0Z0YXMwWjdZQVVjVTZEc1BIeHV5Q0l5YzZEd3ZN?=
 =?utf-8?Q?EAY8gGk4h75a17+h24GIEhzMp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910aa3d-c042-401d-d434-08dc2f2c1c9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 20:16:08.6372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfoh/t5AAi61ue74usrOeYxEJlgHtcVRsy3CtXygS/S0M22pZqsVDlImZHdRVB2Rb1rBbPjx53ycqK+OnFJn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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


On 2024-02-15 10:18, Philip Yang wrote:
> Document how to use SMI system management interface to receive SVM
> events.
>
> Define SVM events message string format macro that could use by user
> mode for sscanf to parse the event. Add it to uAPI header file to make
> it obvious that is changing uAPI in future.
>
> No functional changes.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 51 +++++++-------
>   include/uapi/linux/kfd_ioctl.h              | 77 ++++++++++++++++++++-
>   2 files changed, 102 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index d9953c2b2661..85465eb303a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -225,15 +225,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>   		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>   		++(dev->reset_seq_num);
>   	}
> -	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
> +	kfd_smi_event_add(0, dev, event,
> +			  KFD_EVENT_FMT_UPDATE_GPU_RESET(dev->reset_seq_num));
>   }
>   
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   					     uint64_t throttle_bitmask)
>   {
> -	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
> -			  throttle_bitmask,
> -			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
> +			  KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(throttle_bitmask,
> +			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
>   }
>   
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
> @@ -246,8 +247,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   	if (!task_info.pid)
>   		return;
>   
> -	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> -			  task_info.pid, task_info.task_name);
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
> +			  KFD_EVENT_FMT_VMFAULT(task_info.pid, task_info.task_name));
>   }
>   
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
> @@ -255,16 +256,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>   				    ktime_t ts)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
> -			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
> -			  address, node->id, write_fault ? 'W' : 'R');
> +			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
> +			  address, node->id, write_fault ? 'W' : 'R'));
>   }
>   
>   void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
>   				  unsigned long address, bool migration)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
> -			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
> -			  pid, address, node->id, migration ? 'M' : 'U');
> +			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
> +			  pid, address, node->id, migration ? 'M' : 'U'));
>   }
>   
>   void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
> @@ -274,9 +275,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
>   				   uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
> -			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
> -			  ktime_get_boottime_ns(), pid, start, end - start,
> -			  from, to, prefetch_loc, preferred_loc, trigger);
> +			  KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
> +			  pid, start, end - start, from, to, prefetch_loc,
> +			  preferred_loc, trigger));
>   }
>   
>   void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
> @@ -284,24 +285,23 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
>   				 uint32_t from, uint32_t to, uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
> -			  "%lld -%d @%lx(%lx) %x->%x %d\n",
> -			  ktime_get_boottime_ns(), pid, start, end - start,
> -			  from, to, trigger);
> +			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(), pid,
> +			  start, end - start, from, to, trigger));
>   }
>   
>   void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
>   				  uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
> -			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
> -			  node->id, trigger);
> +			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
> +			  pid, node->id, trigger));
>   }
>   
>   void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
> -			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
> -			  node->id);
> +			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
> +			  pid, node->id));
>   }
>   
>   void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
> @@ -317,9 +317,10 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
>   		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
> -				  KFD_SMI_EVENT_QUEUE_RESTORE,
> -				  "%lld -%d %x %c\n", ktime_get_boottime_ns(),
> -				  p->lead_thread->pid, pdd->dev->id, 'R');
> +				  KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED,
> +				  KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(
> +				  ktime_get_boottime_ns(), p->lead_thread->pid,
> +				  pdd->dev->id, 'R'));
>   	}
>   	kfd_unref_process(p);
>   }
> @@ -329,8 +330,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
>   				  uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
> -			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
> -			  pid, address, last - address + 1, node->id, trigger);
> +			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
> +			  pid, address, last - address + 1, node->id, trigger));
>   }
>   
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 9ce46edc62a5..430c01f4148b 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -523,7 +523,8 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
>   	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
>   	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
> -	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +	KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 11,
> +	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
>   
>   	/*
>   	 * max event number, as a flag bit to get events from all processes,
> @@ -564,6 +565,80 @@ struct kfd_ioctl_smi_events_args {
>   	__u32 anon_fd;	/* from KFD */
>   };
>   
> +/*
> + * SVM event tracing via SMI system management interface
> + *
> + * Open event file descriptor
> + *    use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return a anonymous file
> + *    descriptor to receive SMI events.
> + *    If calling with sudo permission, then file descriptor can be used to receive
> + *    SVM events from all processes, otherwise, to only receive SVM events of same
> + *    process.
> + *
> + * To enable the SVM event
> + *    Write event file descriptor with KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
> + *    mask to start record the event to the kfifo, use bitmap mask combination
> + *    for multiple events. New event mask will overwrite the previous event mask.
> + *    KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS) bit requires sudo
> + *    permisson to receive SVM events from all process.
> + *
> + * To receive the event
> + *    Application can poll file descriptor to wait for the events, then read event
> + *    from the file into a buffer. Each event is one line string message, starting
> + *    with the event id, then the event specific information.
> + *
> + * To decode event information
> + *    The following event format string macro can be used with sscanf to decode
> + *    the specific event information.
> + *    event triggers: the reason to generate the event, defined as enum for unmap,
> + *    eviction and migrate events.
> + *    node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0 for system memory.
> + *    addr: user mode address, in pages
> + *    size: in pages
> + *    pid: the process ID to generate the event
> + *    ns: timestamp in nanosecond-resolution, starts at system boot time but
> + *        stops during suspend
> + *    migrate_update: the GPU page is recovered by 'M' for migrate, 'U' for update
> + *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
> + *    rw: 'W' for write page fault, 'R' for read page fault
> + */
> +#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num)\
> +		"%x\n", (reset_seq_num)

If we want user mode to use this with fscanf or sscanf, and we want this 
to be extensible in the future so we can add new fields without breaking 
user mode using these macros (as you do in patch 2), then the \n should 
not be part of the format string here. We can add the \n in 
kfd_smi_event_add instead.

Regards,
   Felix


> +
> +#define KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(bitmask, counter)\
> +		"%llx:%llx\n", (bitmask), (counter)
> +
> +#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
> +		"%x:%s\n", (pid), (task_name)
> +
> +#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
> +		"%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (rw)
> +
> +#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node, migrate_update)\
> +		"%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (migrate_update)
> +
> +#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from, to, prefetch_loc,\
> +		preferred_loc, migrate_trigger)\
> +		"%lld -%d @%lx(%lx) %x->%x %x:%x %d\n", (ns), (pid), (start), (size),\
> +		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
> +
> +#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
> +		"%lld -%d @%lx(%lx) %x->%x %d\n", (ns), (pid), (start), (size),\
> +		(from), (to), (migrate_trigger)
> +
> +#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
> +		"%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
> +
> +#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node)\
> +		"%lld -%d %x\n", (ns), (pid), (node)
> +
> +#define KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(ns, pid, node, rescheduled)\
> +		"%lld -%d %x %c\n", (ns), (pid), (node), (rescheduled)
> +
> +#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
> +		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
> +		(node), (unmap_trigger)
> +
>   /**************************************************************************************************
>    * CRIU IOCTLs (Checkpoint Restore In Userspace)
>    *
