Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C917EC01B6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B4F10E349;
	Mon, 23 Mar 2026 09:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGS2tsXf";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B929310E33E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vt9Yi52XT5pNqRT9zCUOmaOxNHXx0I16LiTjPc4g+MZCx6GqXwlt1mmbTLwvwxVELAX0dqzRRnO/SutMyeudZ9xyfzlqTVQB7uYdZkzt3QCyVy+gNhNe3cwu9oltVirhdSYjQoDa35uMJucQjmjENjOwHlqBKSr9k4gt9H20ynKJg+7GBNuwOsk8NubSviTLpF9u8fNivxZbnvzpO+Lh0BaXS11Y8Aw2fLRXO0PheG38WfRAhMjxkeKT9TOymF2RRM/8Hm65dcffu18yJKREr9ZrlWQ8OLvT12IP/c3u3P12D4BWtkx7305mMb9knrHJxbnM6BRPjfeYVbgH2NbHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtUBWShl59EM4hUkHXNjw+AeGFUKHjGNnra4B8Snvnc=;
 b=IRykR0RmswPluac9bCr25Rg7MOmAUK+CwhcJf0Zv6ubxw30ONyZXBMzl7midtq5uUBE0go0kcA4tfxqYb6LJvqmRxMkxPs9ESUCwnsQqdPUjjH6r6CzTvubWpbD3upxOHbA/rj8CdM/TUN3ZaPIAZHFxgP8vbFx8Lhyy2iwIMlLf4dUC4sIIUT8rR1bjM1oDQlNIq40NzCklDMCT53JQCy/1nBkGON3xbWhwLh3qAc6fnhdmEvzBF4OrjghnrhdzcvatJEsLiDBFgTdpD+6RemgnPX3NRTcaCYxyXX/o+oRNvogBBbUm0CUcKExLSk28N9IdYzMcciXzonzMgZx+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtUBWShl59EM4hUkHXNjw+AeGFUKHjGNnra4B8Snvnc=;
 b=IGS2tsXfAK66G2/zwVl/ddqyhyr3tR9I3moGsrPnRonKQbpml4MFuZVxjeCh0ro9Yps/e6h62stynEoVicuvv9NSGM4cvI3IxKZKVycxsCaJtNxv9iPWRCMKR/fJlZIxoXfvSmpkpo4galW2Zd0tjJMD3mrcMUxQEYRD+C4NBko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:43:08 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::f67f:61a2:998f:fe0d]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::f67f:61a2:998f:fe0d%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:43:08 +0000
Content-Type: multipart/alternative;
 boundary="------------2RRfx34SupRdbkubsz5jDaXq"
Message-ID: <a341305a-aa2d-4910-9fb6-b2c11fd71fcc@amd.com>
Date: Mon, 23 Mar 2026 17:43:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix NULL pointer check order in
 kfd_ioctl_create_process
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260323085953.2047082-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <20260323085953.2047082-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: SE2P216CA0182.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::15) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f08a5c-1173-4ffb-c329-08de88c096de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CSiJgJvP9bxi8guuiJVpK7jpslD+URpn8XNN8fsA83R8AtWEuMEXJuTRiWE+yBWD5P055Vb+Zeb8EghjKHhBpdcXTvNDJXNoYi7N1gFuPPGT8mbw31u/Ld7S/hEaC03gopTj5dK3gH6ocghgPmM+iFqNThmZDDL4cewgxp18dtCtqvsHsNjOENqv9vxxajgGx7LGUOusLNx4iHSJ91gk4iCdzVcZF2kQYUCwQ22fux+MzTsOdfRROAcDaiHSYPE78MZUtcUnvRpjI9iIMkjmEMxKD8peYFbcTfF8rlvdHYn7NpcAs6JILi+9Y9H1GGnoWW4SdmXD1149Kej4O7L5RSrBrx88Un+MrZLgxYWVojFSC2s2ws3mmH4Vdwr2X4Q/NqXbzUJ6cYcZ4hXVcb3gv+uDCL9ncBSEA0DPGMCwdjvd7ZD3bh4cXwrqRd4VWBp33u5PqgK2GYetgGHtKl+P+DJj9PQCrZy8QIunCSdDVqrIwjBIbX7DonXGRO1SIJc2G/sQyyXjrhANZc+N4tW/jIm45TJsn7z6Bf0sJeSZ6nHjD7OeLV2MxWiHLsQ3x5bIitTWbjaq3ptMjKObdBuUf0W3sKe7p6xIkpOUM8yEVGSmpkBy8rU/OeAa3g6Ncs5TsYVfOkig3RGM0mdatWAVcnv/US/nJbu3QhDNCjz8xcTsFSw/yMQ/2Zc94vMDw8rLisLzQwRTbhdB5vSZm7uCgvw2T7ZZFk07uS0mgosZ9Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRwNVRNaE5KY3Q5bHhRU1dXRWJ6aWt0SUdOYTJ1QVVQcEx2SFVDdHRYWFVG?=
 =?utf-8?B?YWtuSVRmaFdoUmN0MlJHbDFHWDZiNnBSRFM2aHphQlFGUy9WanIrWlFkWFZB?=
 =?utf-8?B?MjRVQmx3Vk9IU1kvWmdaa2U2NUxQYndOeUxEMnBibmZJRGp3RFhDYXlGMG00?=
 =?utf-8?B?ellQNVJUbW1Xb0JpbHpWZVdxcnVFcTgxMnlxK1ByK0IrNVRVbHhScERQZTBX?=
 =?utf-8?B?TWNxSnVVaU1WUmRNY3dvZnQvazE3MkNiRm9SRXJ0UjVQSEVhM2VDc010K2pU?=
 =?utf-8?B?a2lKQTNEdkIyY3JoNjhNM2lrV1FUKytNWVNqQUFyVHFUODdFZW5mL2lCbWMv?=
 =?utf-8?B?bUtjMXFYNWJCUUhVK1ZWb051YXJOL2VWTk9IRE9nLzRUc1Nidm5SdC9NaFdU?=
 =?utf-8?B?Uk5Qa3pJWjJNcDMrbW1pd0ZlcGh2bnRaYlhjOC9IMkkyQkpKSEQxMHNIaEJ4?=
 =?utf-8?B?SnVUbVF4bXdxZm5RcytUcFdQVUxZajlGUGp6L0NsMG9RTXBvb2tzZnNoa04z?=
 =?utf-8?B?MWZHL2d2WTFXdmQ1QUdqMTFhMjJNOE8veXkySHVzTk5GNzRxSkkzMWR1RS9R?=
 =?utf-8?B?VkFMOVArMXdnUkFtQVpPd1NWR1NpNWZqZ01ERUdWZWFmUUVJbTJrd2c5RkNE?=
 =?utf-8?B?S3ppeWdldUhEdkgxcWxLT1piOGF3UzljeFA0OE5VdUJmOGV5Rk95OGxoWFda?=
 =?utf-8?B?LzZXa1F5WVJIRzdkYUUwVWlGdVRzSnB0dHJRR0ZEK0dpMjF3YW9URzBYSGdz?=
 =?utf-8?B?eG84MmExQjVEVDNPU1JSTmd3Wit3YTdPWWZmUUJFcDdOcXBnTU15aWZSTC9u?=
 =?utf-8?B?eTVLT2tRbU5XZ01SaUdoM1NDU0QyWDRYUXgvbXZLa2RmVTNyZitEUHlJY21h?=
 =?utf-8?B?Q0V6M0ZEVHQrUTk0ODRsOXNmWVZKQ3ZoV3R6SGpOV28zY0FUazFHS2J3N0hZ?=
 =?utf-8?B?eTBFWUZmeS91YlhLVzY5RERmK1RSR1IrbDE2WkM0WVA3UlkzSS9BSE9DeDh4?=
 =?utf-8?B?UmpBWTc0MHN0cDZxSVZPV0ZjU1VBdTRkODN4MmlDNmowUU5xR2xhaWFmTEY2?=
 =?utf-8?B?ZVJJdStTS2tNTzVDTnU4Z3ZLVWJTbVZaYW0rMnhKV2RIZ0ExaEhmNnFPN3lD?=
 =?utf-8?B?Vk9SN01Mc2hZc0hYTDFHYTdOYWxZT05nQklHWm1wTWdDUWhYREcwOTcxM1dD?=
 =?utf-8?B?UjlrL0FhZ2NPbEVDUnRwVXdwZGo3d01uaW9XOW5XTjRVNTVUbHkzSWpSYnJJ?=
 =?utf-8?B?S2ZrZWRXTTBCWk5SS2NoYVZyMGVGL1hiL3B0MVBwbHNENnhjeE4rT2RvTmQ5?=
 =?utf-8?B?NXFPUU9sOFNUamNJRFM0c1JjSzh6U1N1Q256S2Y0c2tVOUxKdXc0eTJpZk5a?=
 =?utf-8?B?RkRjWXFpaGFtRlVIRFVNNnk4R29oelJvdjN2TDBXU2t2bGI1OEQ2emp3cGR1?=
 =?utf-8?B?WEJGVk53VCtRV1h3d0l3bk9rSnAxK3VqN0UvdktYMXFKVW1RWlRkOXhxRWRy?=
 =?utf-8?B?Q1J6RmRvNk9WVGhMRFBLY0haSDZNVEJwQ29sekpzVXhYNVRNVURSRUk2SnlI?=
 =?utf-8?B?M044UDBzTTg3cExGRHE5UzNOM2x1UjJFVkVTdFF4TEtzd29yWVk2Wm5vSWhT?=
 =?utf-8?B?T3NqdVJpYng3bm9XVi9na3dZMFhFMzRNdldkM3EyS2U0R2xiaFFjL29jcWlv?=
 =?utf-8?B?L2hKOHJDQmpMWjgvREJ0V3F2ZmhVTHNFNWhHUldNYUcxd2paL2ZkZ0tOam5i?=
 =?utf-8?B?elZzeVEzMVZZTE1TREQ4SjNWUGRMdDNTTDlkWnI5L1M2RzE5Q0lzNitsYldX?=
 =?utf-8?B?ejN2SzVEYUhvcW8vU1Z3VjB4VlJsRVhMRVIxM1REUFlHTWhweUFFRWF3K2c0?=
 =?utf-8?B?Y3Q2SklobzdoRlgvMlhybkJkOEMybkhqQWp3NGRVb0VkSy9uN2MrL1hJclNC?=
 =?utf-8?B?a1NYOFNHZmI2SGRpYUttaW5BdGpYL2dRQzFiQThtUnlTUFFSQURndnhKckZm?=
 =?utf-8?B?Rld3WjlGSVkxM1VYTVZiQURLcHRRVDR4WFllTytFVUxhVnNTZWpIS1lIRXNF?=
 =?utf-8?B?d29CbE8xWGsxNzlXbUMzRW43YzlONGxQNjJLM3ZEaHA3MzF3Rk5hZ3NERys1?=
 =?utf-8?B?OThsdW5BUnUwWlpMT2djY1hvVmp2OW1ZUkxieXRBb05VejVjaXVpeEIyeFFh?=
 =?utf-8?B?dm9qdStvQ1prR2NocDBBZjJSTGJNSDlqVHFISSswNHlsSThweDVWaXJJMHln?=
 =?utf-8?B?SVNyWU1kU1lYYmdXdlQ1cTliMDVsQUVHVGF4bkhjTU1Bc2RQZUg3cUxsSW1i?=
 =?utf-8?Q?OGGS9p4/G6QaLEQRiT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f08a5c-1173-4ffb-c329-08de88c096de
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:43:08.0694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OR5dCtDkeJr8dSMY9V3mZUiG+M6V3P9c3zk3hZx+dfSrQg9y3i8QcnmCGF02HHpuRglRwLqMcf+NE0be4+mgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

--------------2RRfx34SupRdbkubsz5jDaXq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/23/2026 4:59 PM, Srinivasan Shanmugam wrote:

> In kfd_ioctl_create_process(), the pointer 'p' is used before checking
> if it is NULL.
>
> The code accesses p->context_id before validating 'p'. This can lead
> to a possible NULL pointer dereference.
>
> Move the NULL check before using 'p' so that the pointer is validated
> before access.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:3177 kfd_ioctl_create_process() warn: variable dereferenced before check 'p' (see line 3174)
>
> Fixes: cc6b66d661fd ("amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS")
> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 732ad1224a61..1db565442c48 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
>  	struct kfd_process *process;
>  	int ret;
>  
> -	/* Each FD owns only one kfd_process */
> -	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
> +	if (!filep->private_data || !p)
>  		return -EINVAL;
>  
> -	if (!filep->private_data || !p)
> +	/* Each FD owns only one kfd_process */
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
>  		return -EINVAL;

p should be always valid since it is from a fd, it is either a primary of a secondary context

I agree this patch improves readability and better defensive programming.

Reviewed-by: Zhu Lingshan <lingshan.zhu@amd.com>

>  
>  	mutex_lock(&kfd_processes_mutex);
--------------2RRfx34SupRdbkubsz5jDaXq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre class="moz-cite-prefix">On 3/23/2026 4:59 PM, Srinivasan Shanmugam wrote:
</pre>
    <blockquote type="cite" cite="mid:20260323085953.2047082-1-srinivasan.shanmugam@amd.com">
      <pre wrap="" class="moz-quote-pre">In kfd_ioctl_create_process(), the pointer 'p' is used before checking
if it is NULL.

The code accesses p-&gt;context_id before validating 'p'. This can lead
to a possible NULL pointer dereference.

Move the NULL check before using 'p' so that the pointer is validated
before access.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:3177 kfd_ioctl_create_process() warn: variable dereferenced before check 'p' (see line 3174)

Fixes: cc6b66d661fd (&quot;amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS&quot;)
Cc: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:dan.carpenter@linaro.org">&lt;dan.carpenter@linaro.org&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 732ad1224a61..1db565442c48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	struct kfd_process *process;
 	int ret;
 
-	/* Each FD owns only one kfd_process */
-	if (p-&gt;context_id != KFD_CONTEXT_ID_PRIMARY)
+	if (!filep-&gt;private_data || !p)
 		return -EINVAL;
 
-	if (!filep-&gt;private_data || !p)
+	/* Each FD owns only one kfd_process */
+	if (p-&gt;context_id != KFD_CONTEXT_ID_PRIMARY)
 		return -EINVAL;</pre>
    </blockquote>
    <pre>p should be always valid since it is from a fd, it is either a primary of a secondary context

I agree this patch improves readability and better defensive programming.

Reviewed-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a></pre>
    <blockquote type="cite" cite="mid:20260323085953.2047082-1-srinivasan.shanmugam@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 	mutex_lock(&amp;kfd_processes_mutex);
</pre>
    </blockquote>
  </body>
</html>

--------------2RRfx34SupRdbkubsz5jDaXq--
