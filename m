Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0485C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC3B10ED77;
	Tue, 22 Sep 2026 15:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jSYK0Qft";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DBA10ED77
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfGEmMPUkINYiUHwYe2BsIIe7dToflCVxzcGSFSc0qERCmMPH8PDOV99fXdK3gnzoJaJ7iTlWkilVc3uRgQvh5HCpgN+q/NmR6P4e9T+ZFqyORyKxjfQxMtuVZYfBfPVeTq+vQ6q64YDXLauAWCzsk/6nTLz0kwsNTa07NYSJEkgOBoQYukGJLDyjh4LMWjKAUVNiDhW6gq9lWe6CYQCprV/h52VebdLrc+fIhLmdpQehTB1t1mKQpHcuBn25v4svhpAHw8/N+H+qVCOuisRtMzEH8wtque7l/A3yDOvSIhBOrNT0Vpqn6gSKn41fqzryCW+E477Zn8WdnkWNFPw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVMdAgs75hvAApQJdBCqm3eJIAO1KCWnkNlBGwiSQ7Y=;
 b=YTT2IkQep4NgFJ+PoOS8YlHvzgzQoDqaFbf3FIO8o2SL1dtuJbvWwzP/CJ6Tdemg0jFE/pOi1dVdIDrz7euzeT+cqqGRxCaz8LOLo1WPN1HhhQPzMYI5jIZjUXU2LDKrMXYGArkrsWXDTCHFXrlAUDO1yH+AT8OzBiXMX82xI5S27+hhiWwlaLXh6DdHeR4U42EG/jnFhJw15EXeFYzQAQd3HmoqW05IfpsCro3QcsCM/Oj0KXzLeo/YJeObGMkUm2ipnbUH6wi1UTnvm5r68cVpnEIjwWB4d+Mu0Ccuzp2Blh6iwNjTYOEewfFGLBlYrYpKL330BMUYZzQfW+z5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVMdAgs75hvAApQJdBCqm3eJIAO1KCWnkNlBGwiSQ7Y=;
 b=jSYK0QftIpeE/+mhSTIOK7/eh3M7cnx+rOQjsEtlbDBY77pAt6apH8c4TkkCI8La0RcnvKMh1g0t6MJJ0pntrbZja5dD+NGIAZQiWYbnDEQMdnm1HuJSZyJbGy9v9MWGryN31z4cTKDq88Db184X9q6cDaByANn4EgDKvYKLHmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:30:01 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 15:30:00 +0000
Content-Type: multipart/alternative;
 boundary="------------hQrMWGgGaqzaFOC0wjwhTiJ6"
Message-ID: <c9e51288-9630-4da2-8bb1-1994e2e79599@amd.com>
Date: Tue, 22 Sep 2026 11:29:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <15f96feb-9db9-4a8f-a81b-ecfa2fb605b0@gmail.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <15f96feb-9db9-4a8f-a81b-ecfa2fb605b0@gmail.com>
X-ClientProxiedBy: YT4PR01CA0256.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::23) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fcb169-c13b-466b-721f-08df18be5d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|3023799007|6133799003|8096899003|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: TtRizl6sK+kNmx5sEcFHsE/QbpnueHTCCB9qnkEoQu/OhQcqjf9Z7Q7Jxxz5k/SdrssXp40eVM+G924Tv8q+cootOC7PmFMONL261dbETO1J96EzMqtEMc0u3XcYuU12X7DH7k/TjocHAk88Usc9+buqjSXX98zAuSRe3KdDEd6pmmiQmihvjIkexb/YMQXAeeHIb7Yfais9lOzn1Yy/CT4pmSGOjFYYi2wSzSwDtSlayLzA/yFIBjtNJjXlKC6dUZNCK82F/GZiYTlSaTragp8VidiUfSkNSUxF21KRr8yQBm0kWwWQ3CW8Yg8BXDPfLlIQkFAP2hfSfxJLc39+whCinEQp1ajrJbBV/VTItOgGngMhT0JIzjAsBkUTPQyY0Ib9mJAhQMOIMhzi00cTeoQ5X3KgyA/Byl4bGCoAino0kM0Pho+bUCktP8fW99Qxubrxwfy5ibWa7yonB+kyyxc5UIdAFr6NWq+qTmxb26VkMWvSGfNsMEWqan0frpDIipU3snMWRoRyQDsEfemmjYUuHnf5fl6Q/9Z48HEbHGhXiiKsHVxNjM8qjiFjTdGjgFYy61xYUwq/a85fFAZGd0MyburJwmDqWNgIfa0iBQQukBrLmH6gVnPS2NyZ7bW0RfPVgtngX2b5EOx3zPhBfUwf7T8T3L+O3bTSsG4E3g4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(3023799007)(6133799003)(8096899003)(11063799006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVgyVlRZYnAwU1VKSkxqbkdFY2IzaTBrbURmY21ZbHVKY3Z0cHZycm85K3lU?=
 =?utf-8?B?a0doVS9IbWxqRzVYczZRemRlNVl3UnNxS05PNVRZeERaenh5cGJmM3ByeDFS?=
 =?utf-8?B?cXRMVldwQlV1Q1dMWnJoWWRDMVdXRFhKRTdRWk5xWUIzUHJpcVoxRTRnOW41?=
 =?utf-8?B?UDJrRXY5L3hadFZZMDZxOE9COHp4STNIejNCS0FNQ01TWVZvVTcvMjRNaTAw?=
 =?utf-8?B?WVJ1TXVJMmIwWWFUVGhQbWxGakVGekIyL2NlMzFxb1JVYjlTVnR3NkdZNW0z?=
 =?utf-8?B?WkxEYkNIdytBWU1rSHJEenVhbklxeCtuNVZ5S1RQK05CVW5QRms2SXFuN2Vk?=
 =?utf-8?B?VWg0eGtXQXBTNHQyYVZWd1hJci94ZUhES1owQ3N0ZytvTTI0aXlSK3lrUEh0?=
 =?utf-8?B?VFBNY0pGZzU5QWQva2JacmVSM0lTdVRqWUV5YzlIVEhjQnR0MU1xOHdyaXVa?=
 =?utf-8?B?SC9ockxFV2NqYUxaK0tIQUZRdlhRTGg4V3p3a1d6cmplaWYwRkJaYkNHeUFs?=
 =?utf-8?B?VTVlMXRmc1Bja20vVE05Vk5xaFBjT0pzQ2JTSldrZFRUVXZXRU80RG9wNWtp?=
 =?utf-8?B?VU1kby9LK0l4MjMwZTduTzR5VitWWkViMHhGRHhTOGwzZjJVa1dqRHJ4YXlt?=
 =?utf-8?B?ck1HdzhPVEw5YkFHSTM0b2dWd1h6REt3eVExMVFPMlVQNWEyRkRTZmgwQUN1?=
 =?utf-8?B?QWhJa2NOYjl5TkcrODQ0V3lWa2hua3RrT0tJU0pZYkFpYmhlU0t2dzR5TDdz?=
 =?utf-8?B?M1lueVBnNTgxK21uK0xhVkFrbWlQRGxha2ZjZDQzbW5ENnlaQlA1NklkYmg0?=
 =?utf-8?B?ajJEUmxFV0toQ0ZWT3l4ekl2Q1BNN1FYS3JIQ3RQQ3dWVk5UdStmKzlSSW9n?=
 =?utf-8?B?NDdZei9pYTEyUlpRbi9YdnlHV29kNDF3RVlFajdRTFQ0Y010bnBCa0xEWG9y?=
 =?utf-8?B?NGZFZGJKVzZ4QThHeDA0VFJUYmsxekNvNE8rYnFnNzBCYVpOcGtmV0pubXB0?=
 =?utf-8?B?ajRRc3hSNElzRm13aFloVlBQejd1cEFsWjJDdEhIWWQyYi9GeUpPL09LcWhJ?=
 =?utf-8?B?UkM1aEVWeStZTjZKOFF1M1JXMWRiNVN1Y1BtL0wxSjBESUd2bG1adjMwQTJN?=
 =?utf-8?B?aFlaeXdvc1VpRlNyNUpaNjZwUFFLMEhmZ2pTZEwrT0lXWUNBWnJQY0VJTGEw?=
 =?utf-8?B?OXdDOUFWY1dxSEkvWEN0UDQ3blJTZlMyWU4xMFdheXgwTUlzbTJTZXBGN0J4?=
 =?utf-8?B?YWswelFPR245ZVZpSEdhS0ZVY29LK0xTQndEUi91a1hCSE5hTmFzaStZVG01?=
 =?utf-8?B?TXZjWS9jTkZKak1pbXgySExrYSthdWFNZXNlNlpjRDBtUzdoRWRUV1FRZy90?=
 =?utf-8?B?VzhtbWlwMERBcW1BeG04OTg3SEpuclpaUGVjU0FNMGFsMEpjLytUYmZrOWtY?=
 =?utf-8?B?K1FtUk5RR2RjM2ZIRWl0a2dKQVcwK1E3b1VxUGw5S0FrdXROZjBXOEtodEor?=
 =?utf-8?B?ZmZiN1A1ZmR5RnhJZ1FCYzBMUmxhdjd5RnRhbkRVODM0OHlCdEhzWlJnZE5p?=
 =?utf-8?B?eUdKaEpJRGo5S1hIZGVYblZsM3k3bUc2VG00QTBFdnQrc2NZVk1hb0duem1D?=
 =?utf-8?B?QVNXRVRNT3ZYUzdmZlNpVUo2VGI3M0ZGZkRSY01VaUR2UTZDQjUwVUJaVzN2?=
 =?utf-8?B?MHN2cDNYRUhSbENhZ3ZCN0tJS2V6b3pHc3Q1T1ZBek5uWnRWZzB2Vk1lVmoy?=
 =?utf-8?B?K2YzR3BZR0VyYk5sMmhPclN1TWRxZW1VMlAzdHRjU000Z1lzR0dvNGo4WUpQ?=
 =?utf-8?B?YTU0T2huRmFScjdYWldYSVJsSVdRWnUrQjRGa29SZ0FwSWpTR1huWjEybE80?=
 =?utf-8?B?R3oyWENXdnhRbUowcS92ejhaV3RSVSs0Rjlwb0VNM3ljQi9ONmpyM2piRmgw?=
 =?utf-8?B?bXl5TXhmbDBDWWNWRTNObFd4ckxXTngyaXNBRmo3d1NYT2p0UjNsa25XdDlP?=
 =?utf-8?B?KzZVMThuNUlGYTNzUG1TV2pUUjNQaGQxenhwdGNFQlIvQTF0dXRjSUZ2OWhx?=
 =?utf-8?B?RGxJc3dvKzdpZHMraVBNOUVpTlVsV0hDbWtyaXYyZnRlVElGbUtBWXVDTCtD?=
 =?utf-8?B?VGdYZytkdVd0K0hWQXZwNVgzRUxtL3B3ekR5dXdvSGdNN2xBTjNya3NyRk5k?=
 =?utf-8?B?Z1NMeTZZUzI2cWxxVHFqMjBxMDZPMWJxa0ZoTUlaV1BXcnQrd3ZVOHRVS1h6?=
 =?utf-8?B?YWFtKzBSaW1pYkdEMlpIblY0OVo0QzlrK29STGtwbEN3SjQyNCtGbytoSjdM?=
 =?utf-8?Q?slDGlsxTTfueS+6tVx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fcb169-c13b-466b-721f-08df18be5d7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:30:00.3444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sA7DuARub/n7MeOq2qjwZDubUnwjTgqUngqlhGpuBhSwqFGxZw5XnuYsUplZ0cEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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

--------------hQrMWGgGaqzaFOC0wjwhTiJ6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-09-22 11:13, Christian König wrote:
> On 9/21/26 22:03, James Zhu wrote:
>> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
>> UAPI for GPU performance monitoring features such as SPM (Stream
>> Performance Monitor).
>>
>> struct drm_amdgpu_profiler_args carries an operation selector and a union
>> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
>> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
>> destination buffer are described by struct drm_amdgpu_spm_args and
>> struct drm_amdgpu_spm_buffer_header.
>>
>> The ioctl number and struct layout are frozen here. The implementation
>> lands in the rest of this series and the ioctl is not registered in
>> amdgpu_ioctls_kms[] until then, so this header change alone does not make
>> the interface reachable.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> Reviewed-by: Bing Ma<bing.ma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 124 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 9e5fa6f53e59..285949d63eb6 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -60,6 +60,7 @@ extern "C" {
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>>   #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>>   #define DRM_AMDGPU_TRAP			0x1B
>> +#define DRM_AMDGPU_PROFILER		0x1C
>>   
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -83,6 +84,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>>   #define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
>> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>>   
>>   /**
>>    * DOC: memory domains
>> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>>   	} kfd_sigbus_delay;
>>   };
>>   
>> +/*
>> + * Supported SPM (Stream Performance Monitor) Operations
>> + */
>> +/**
>> + * drm_amdgpu_spm_op - SPM ioctl operations
>> + */
>> +enum drm_amdgpu_spm_op {
>> +	AMDGPU_SPM_OP_ACQUIRE = 1,
>> +	AMDGPU_SPM_OP_RELEASE,
>> +	AMDGPU_SPM_OP_SET_DEST_BUF
>> +};
>> +
>> +/**
>> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
>> + *
>> + * @dest_buf: [in] used for the address of the destination buffer
>> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
>> + * @buf_size: [in] size of the destination buffer
>> + * @op: [in] specifies the operation to perform
>> + * @timeout: [in/out] timeout in milliseconds (in), amount of time left
>> + *           in the timeout window (out)
>> + * @bytes_copied: [out] total amount of data that was copied to the previous dest_buf
>> + * @has_data_loss: [out] non-zero if data was lost (e.g. due to ring buffer overflow),
>> + *                 zero otherwise
>> + * @reserved: must be zero for forward compatibility
>> + *
>> + * This ioctl performs different functions depending on the @op parameter.
>> + *
>> + * AMDGPU_SPM_OP_ACQUIRE
>> + * ------------------------
>> + *
>> + * Acquires exclusive access of SPM on the specified XCP for the calling process.
>> + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
>> + *
>> + * AMDGPU_SPM_OP_RELEASE
>> + * ------------------------
>> + *
>> + * Releases exclusive access of SPM on the specified XCP for the calling process,
>> + * which allows another process to acquire it in the future.
> Clear NAK on that. We already have an interface for SPM VMID acquire/release.
>
> And please CC me on such patches in the future.
[JZ] Sure, I CC to you on these patches.

Here is SPM OP acquire / release, not SPM VMID acquire/release.

in v6.12-0003-drm-amdgpu-add-generic-RLC-SPM-interface-layer.patch
amdgpu_vmid_alloc_reserved / amdgpu_vmid_free_reserved are used

for SPM VMID acquire/release.
Do we have new SPM VMID acquire/release interface releases? If yes, 
please share with me, I can replace with new ones.

Thanks!

James

>
> Regards,
> Christian.
>
>> + *
>> + * AMDGPU_SPM_OP_SET_DEST_BUF
>> + * -----------------------------
>> + *
>> + * If @dest_buf is NULL, the destination buffer address is unset and copying of counters
>> + * is stopped.
>> + *
>> + * If @dest_buf is not NULL, it specifies the pointer to a new destination buffer.
>> + * @buf_size specifies the size of the buffer.
>> + *
>> + * If @timeout is non-0, the call will wait for up to @timeout ms for the previous
>> + * buffer to be filled. If the previous buffer is filled before the timeout, @timeout
>> + * is updated with the time remaining. If the timeout is exceeded, the function
>> + * copies any partial data available into the previous user buffer and returns success.
>> + * The amount of valid data in the previous user buffer is indicated by @bytes_copied.
>> + *
>> + * If @timeout is 0, the function immediately replaces the previous destination buffer
>> + * without waiting for the previous buffer to be filled. That means the previous buffer
>> + * may only be partially filled, and @bytes_copied will indicate how much data has been
>> + * copied to it.
>> + *
>> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss will be non-0.
>> + *
>> + * Returns negative error code on failure, 0 on success.
>> + */
>> +struct drm_amdgpu_spm_args {
>> +	__u64 dest_buf;
>> +	__u32 buf_size;
>> +	__u32 op;
>> +	__u32 timeout;
>> +	__u32 bytes_copied;
>> +	__u32 has_data_loss;
>> +	__u32 reserved[9];	/* must be zero; pads this struct to 64 bytes */
>> +};
>> +
>> +/**
>> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for drm_amdgpu_spm_args->dest_buf
>> + *
>> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
>> + * @bytes_copied:  [out] Amount of data copied for this sub-block
>> + * @has_data_loss: [out] Boolean indicating whether data was lost for this sub-block
>> + *                       (e.g. due to a ring-buffer overflow)
>> + * @reserved:      Reserved for future use, must be zero
>> + *
>> + * This header precedes the SPM data in the destination buffer. The reserved
>> + * field maintains 64-byte cache line alignment (32 bytes total).
>> + */
>> +struct drm_amdgpu_spm_buffer_header {
>> +	__u32 version; /* 0-23: minor, 24-31: major */
>> +	__u32 bytes_copied;
>> +	__u32 has_data_loss;
>> +	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
>> +};
>> +
>> +/* Supported Profiler Operation */
>> +#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI version */
>> +#define AMDGPU_PROFILER_OP_SPM			2
>> +
>> +/*
>> + * Profiler IOCTL
>> + */
>> +/**
>> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
>> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
>> + * @pad: Must be zero for input validation
>> + * @data: Operation-specific parameters (union)
>> + *
>> + * GET_VER operation:
>> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) | MINOR.
>> + * Input: @data must be zero (reserved for forward compatibility).
>> + *
>> + * Design note: GET_VER is intentionally a parameter-free query returning
>> + * the global profiler UAPI version.
>> + */
>> +struct drm_amdgpu_profiler_args {
>> +	__u32 op;				/* AMDGPU_PROFILER_OP_* */
>> +	__u32 pad;				/* must be zero */
>> +	union {
>> +		__u32 version;		/* GET_VER: out (MAJOR<<24) | MINOR */
>> +		struct drm_amdgpu_spm_args spm;
>> +	} data;
>> +};
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
--------------hQrMWGgGaqzaFOC0wjwhTiJ6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-22 11:13, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:15f96feb-9db9-4a8f-a81b-ecfa2fb605b0@gmail.com">
      <pre wrap="" class="moz-quote-pre">On 9/21/26 22:03, James Zhu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
UAPI for GPU performance monitoring features such as SPM (Stream
Performance Monitor).

struct drm_amdgpu_profiler_args carries an operation selector and a union
of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
destination buffer are described by struct drm_amdgpu_spm_args and
struct drm_amdgpu_spm_buffer_header.

The ioctl number and struct layout are frozen here. The implementation
lands in the rest of this series and the ioctl is not registered in
amdgpu_ioctls_kms[] until then, so this header change alone does not make
the interface reachable.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Reviewed-by: Bing Ma <a class="moz-txt-link-rfc2396E" href="mailto:bing.ma@amd.com">&lt;bing.ma@amd.com&gt;</a>
---
 include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9e5fa6f53e59..285949d63eb6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern &quot;C&quot; {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_TRAP			0x1B
+#define DRM_AMDGPU_PROFILER		0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern &quot;C&quot; {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };
 
+/*
+ * Supported SPM (Stream Performance Monitor) Operations
+ */
+/**
+ * drm_amdgpu_spm_op - SPM ioctl operations
+ */
+enum drm_amdgpu_spm_op {
+	AMDGPU_SPM_OP_ACQUIRE = 1,
+	AMDGPU_SPM_OP_RELEASE,
+	AMDGPU_SPM_OP_SET_DEST_BUF
+};
+
+/**
+ * drm_amdgpu_spm_args - Arguments for SPM ioctl
+ *
+ * @dest_buf: [in] used for the address of the destination buffer
+ *            in @AMDGPU_SPM_OP_SET_DEST_BUF
+ * @buf_size: [in] size of the destination buffer
+ * @op: [in] specifies the operation to perform
+ * @timeout: [in/out] timeout in milliseconds (in), amount of time left
+ *           in the timeout window (out)
+ * @bytes_copied: [out] total amount of data that was copied to the previous dest_buf
+ * @has_data_loss: [out] non-zero if data was lost (e.g. due to ring buffer overflow),
+ *                 zero otherwise
+ * @reserved: must be zero for forward compatibility
+ *
+ * This ioctl performs different functions depending on the @op parameter.
+ *
+ * AMDGPU_SPM_OP_ACQUIRE
+ * ------------------------
+ *
+ * Acquires exclusive access of SPM on the specified XCP for the calling process.
+ * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
+ *
+ * AMDGPU_SPM_OP_RELEASE
+ * ------------------------
+ *
+ * Releases exclusive access of SPM on the specified XCP for the calling process,
+ * which allows another process to acquire it in the future.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Clear NAK on that. We already have an interface for SPM VMID acquire/release.

And please CC me on such patches in the future.</pre>
    </blockquote>
    [JZ] Sure, I CC to you on these patches.<br>
    <p>Here is SPM OP&nbsp;<span style="white-space: pre-wrap">acquire</span>&nbsp;/
      release, not SPM VMID&nbsp;<span style="white-space: pre-wrap">acquire/release</span>.</p>
    <p>in
      v6.12-0003-drm-amdgpu-add-generic-RLC-SPM-interface-layer.patch<br>
      <span data-olk-copy-source="MessageBody">amdgpu_vmid_alloc_reserved
        / amdgpu_vmid_free_reserved are used&nbsp;</span></p>
    <p><span data-olk-copy-source="MessageBody">for&nbsp;</span>SPM VMID&nbsp;<span style="white-space: pre-wrap">acquire/release</span>.<br>
      Do we have new SPM VMID&nbsp;<span style="white-space: pre-wrap">acquire/release interface releases?
If yes, please share with me, I can replace with new ones.</span></p>
    <p><span style="white-space: pre-wrap">Thanks!</span></p>
    <p><span style="white-space: pre-wrap">James</span></p>
    <blockquote type="cite" cite="mid:15f96feb-9db9-4a8f-a81b-ecfa2fb605b0@gmail.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+ *
+ * AMDGPU_SPM_OP_SET_DEST_BUF
+ * -----------------------------
+ *
+ * If @dest_buf is NULL, the destination buffer address is unset and copying of counters
+ * is stopped.
+ *
+ * If @dest_buf is not NULL, it specifies the pointer to a new destination buffer.
+ * @buf_size specifies the size of the buffer.
+ *
+ * If @timeout is non-0, the call will wait for up to @timeout ms for the previous
+ * buffer to be filled. If the previous buffer is filled before the timeout, @timeout
+ * is updated with the time remaining. If the timeout is exceeded, the function
+ * copies any partial data available into the previous user buffer and returns success.
+ * The amount of valid data in the previous user buffer is indicated by @bytes_copied.
+ *
+ * If @timeout is 0, the function immediately replaces the previous destination buffer
+ * without waiting for the previous buffer to be filled. That means the previous buffer
+ * may only be partially filled, and @bytes_copied will indicate how much data has been
+ * copied to it.
+ *
+ * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss will be non-0.
+ *
+ * Returns negative error code on failure, 0 on success.
+ */
+struct drm_amdgpu_spm_args {
+	__u64 dest_buf;
+	__u32 buf_size;
+	__u32 op;
+	__u32 timeout;
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[9];	/* must be zero; pads this struct to 64 bytes */
+};
+
+/**
+ * drm_amdgpu_spm_buffer_header - SPM Buffer header for drm_amdgpu_spm_args-&gt;dest_buf
+ *
+ * @version:       [out] SPM version (0-23: minor, 24-31: major)
+ * @bytes_copied:  [out] Amount of data copied for this sub-block
+ * @has_data_loss: [out] Boolean indicating whether data was lost for this sub-block
+ *                       (e.g. due to a ring-buffer overflow)
+ * @reserved:      Reserved for future use, must be zero
+ *
+ * This header precedes the SPM data in the destination buffer. The reserved
+ * field maintains 64-byte cache line alignment (32 bytes total).
+ */
+struct drm_amdgpu_spm_buffer_header {
+	__u32 version; /* 0-23: minor, 24-31: major */
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
+};
+
+/* Supported Profiler Operation */
+#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI version */
+#define AMDGPU_PROFILER_OP_SPM			2
+
+/*
+ * Profiler IOCTL
+ */
+/**
+ * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
+ * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
+ * @pad: Must be zero for input validation
+ * @data: Operation-specific parameters (union)
+ *
+ * GET_VER operation:
+ * Returns the profiler UAPI version in @data.version as (MAJOR&lt;&lt;24) | MINOR.
+ * Input: @data must be zero (reserved for forward compatibility).
+ *
+ * Design note: GET_VER is intentionally a parameter-free query returning
+ * the global profiler UAPI version.
+ */
+struct drm_amdgpu_profiler_args {
+	__u32 op;				/* AMDGPU_PROFILER_OP_* */
+	__u32 pad;				/* must be zero */
+	union {
+		__u32 version;		/* GET_VER: out (MAJOR&lt;&lt;24) | MINOR */
+		struct drm_amdgpu_spm_args spm;
+	} data;
+};
+
 #if defined(__cplusplus)
 }
 #endif
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------hQrMWGgGaqzaFOC0wjwhTiJ6--
