Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737EBCD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0694610EDA1;
	Thu, 11 Jun 2026 09:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tFLIAmPZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633CC10EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 09:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/kBx095NdNzv1jwjWuNskKnrLDCFqTzHFHbQSq3P9oZ85tZbEvRRViB5a4cBHt4Qp0Yi2VkcZl7Y97CPXEx5QjxFQtnReek+fGs19STl4bxcY1L+zxek3RwIN/qkNXgb1UC+sT+tGrCxbnKVygZZq4UGz8P45sWrmmeE6qgUc9x7BWPlDQMTHH8byk1rcSx5Kny59XCJa+oG471qJnMxFPOMl3qyEx1LNMXNt06H/ITgK5fCHn1yyNM7mdbwNow79FCsSIQZkcpPhxV8h0i+QrJHppXORxSinO7zXEJ22nZw+Q+SuGsG8kOoMR9zl29FIjvQ6F3t9gZuH1PqyxtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTqWT1SviWxG0+hWG2I+kNYNU3JpVuvRtEoZv9HrWyI=;
 b=fVJACYXKc+vsyhF9hmIKfvDpGVGjmmT8w4CcsZ2GG52bHqIE+w+xBmcUHcbCjITXnwtgH6PE9MBhqVi8fMnZYBoaoHB+12o0BmMLxYNzyx7RMQs4HlTeMrJ9DlHjT8LG+PG+WR8K8L1eINPopwoJAuUpyFwik1hLgVOkgXDVjxjdnet8d7Ewuvve069nmge3ZPFPWrFl+o5VFcYdk4LyCWDqoS4vrE8excDegzgkHeybnlV7Rb5OPURMcljAiFAr/HDejV0r04pjIpIAe/+ujzXnIh7IDGq0YnGnMfcHDGH6yib3pqtRPR63irnRwLQm07qCXW4PBFM38D81Ua6u3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTqWT1SviWxG0+hWG2I+kNYNU3JpVuvRtEoZv9HrWyI=;
 b=tFLIAmPZJp9g26ixuEeGsymJspO6PXqqDOWqLZAuNwHJwKJzd6x0mNN55bBE81FBEwnTX8c4h3zIrs6aAuR0SwgM3H1IpR5TBBPyqDudnktZmuB7Vvxf7SPeC6HU0yp+iFZZ533Le9btn4t9YqlDals5FsaoGHQ8oxZBfFpuZgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 09:46:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 09:46:46 +0000
Message-ID: <d59d635a-399f-4138-9bcc-bdf965c6bc17@amd.com>
Date: Thu, 11 Jun 2026 11:46:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/5] drm/amdgpu: Add render-node EVENTFD manager core
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
 <20260611072644.2856170-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611072644.2856170-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:208:32d::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 598c0861-bd5c-4e26-b735-08dec79e59c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|3023799007|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5/5liXl1UETAwckM1atmbbxaX06pxaIfUlf5ozt6KAyiBeKsUq5WmW5/KC/oU8iGnLOglbsGNn3skPFFHeBFS4StqEPT8UYWLH9R//vOu4PAQij0xB8Lw2pX1JtqBJ/nsSfA3f8L6Bxib9C8/aXSVaSKE4+M69q0fm+axzPiazNzOC8v0f1uR6waCWvLDfu7IzbW31rm9XB0V2fms+oYmgYyUImhzhzagTVbyKaHtHDciuhAFDgNIyDS56pGnuFsdGTP4FNMbT5Wg0X9YFtonjv9XM+9cReM4zKVyR38IHEKQOrK33P6D8MQ9zvdwum4k55GpyIw7aZTJOBouzIBYKBX6Tv9ofHeM6KJHwx4hmW/62twIAuckgbId9WPGhraKwpyDDjQ9YzTUzfD+RbOKvp1ooQU4/D0Rj02ooK0sj+yLN5OD97bM+Ucq41hFzaDJgesd6tbSENe5yvgGbP21qDfVp3EC6AlFlNX8B9QDphGLH58di5cbEIYWh8rcRQj3AxlzVj2kYNgvYNg+mBklKJaVAM0lVgld5FRkyxzBcTOSTq6zGSsY/YEAy/ImAOiODzQfPbcy7WWvlGVcElOfbb+4IhxkYapag5ESBKG2cFGwlY2j0dkyM00Y9bK0cnjI+XUAPH3aHB6rFkPfZQAAdmego723qXAUKItnFYZSF16nJr/te1dSjDi7KWV9I7U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(3023799007)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFvTkgxc25MVzBFbm9HVHZvWUg1aTJvaDBWQXdXQm9LR0d3VHBsMFBOWURG?=
 =?utf-8?B?RDg0aVpzaWpHdnorOEdXbTcwMUkvazQ1cjNtYTEvRzdLVUZhT0ppZk42Y2pZ?=
 =?utf-8?B?SElVUjZuaURTN3AxR0ZURlJjUjJocm5ZQUkrZjY5dWpxK0FMa2UwUVI2RFRB?=
 =?utf-8?B?T1hocW9WSEJLN0M2MG1kRCs5QjFDU0RXWHFxRHpFTnZnYldmMkJJVGl3djlP?=
 =?utf-8?B?UHBJcEhodnRGYWZ4bXdMYXFBRWphRFRpUnJpZ1QwbXdnenZuMEYrUWZZais4?=
 =?utf-8?B?ak1jUGFWeFNrbzFPbkxzZW1FaCtyYXhjNUd6NjNEak9qZzFNN0JOTk93S2NR?=
 =?utf-8?B?Z09IUzJlQUdqSitSdm5mcWx5MWYzS0s1VEhsQ1U0eGhpemt2dEYwNC9GRjJC?=
 =?utf-8?B?UUk3bzNrdlhRNy9hZlQ4Q3drNXl2UVo2ZzlGK0p3ZFVRZUpyZ0tod2ZPN016?=
 =?utf-8?B?MWFqTmpYdjl3Y0pBL2VJMytVNmp1c3c4aDk4U0JDVlR1czZieGhxZkdHMjFE?=
 =?utf-8?B?UnNudVpHVmVkQ2ZzUFJTYSt6T2VaQ01Xd0gzS01NZzhzNEdZZFkxM1orQjZ1?=
 =?utf-8?B?VlU1RkpMTUxla3dtMTlhR0ppNHduSzZJd0paZ1J6TFBRdTVWUVVta1R5UWlO?=
 =?utf-8?B?WGh5b2xFdCtYeWxESDZnTE1FYW50M2lLaTVTYS9MVElKd1VZYkhDcGw1UnVP?=
 =?utf-8?B?UzYwMjdMUkxxdXR1SzdxckErSjg5V1Q5bFEvZHVXZDFCMk9JbzczUHBSVTV4?=
 =?utf-8?B?c29JeUgycEIwdFN1NXFqRDNydGpRSkdZbGVzSnNzRkMrZktsZFdxU2xaRlZZ?=
 =?utf-8?B?bHZ3cWtJT2dieDNSSVN2dm4rNDJ0citkZEF1eVRVTWtFZUVVK3hBQmtSY0w5?=
 =?utf-8?B?YkViblhnMUFUVG5wYXVQSjluWWJKcW03aGs5MVFLeU5QclVYTFlrc0ZIbjB3?=
 =?utf-8?B?SWtyRExiMlljczhVWWFQSkxjOGNmdk0wT1VMK1cvbmszUFhlbUpUNWhEZVR1?=
 =?utf-8?B?SHV4VURLdHI0WVNpbTVIN01ob0JMMENBbncyN2xBc0VVNkdtYnJtdzBjVU9r?=
 =?utf-8?B?Qy8zOEZmL2J1ems5cCt5ZDV6Y2dtdXpobzMrUHR3TUFvSE9xNCtBcyt5UnZ2?=
 =?utf-8?B?Q1pLWndLdjdrS3ludmMraDdyaVBEb2VKdmNlc3dJYnVZVDlBWElIcWdGK2JO?=
 =?utf-8?B?YnRGN2l2M3NFWUo1YkZyR3pydG1FQ25JSHE4bTArZmRMSFBCdk1TYzdNVGRF?=
 =?utf-8?B?RXRMREtwNXBQY0VsN24yZndldkhIZG1LZktBZExkWU91akNnVHVscWNsVnVC?=
 =?utf-8?B?OVpJK2pJYWhRZ3h0RmRJR0Rka0dUTnFlUXQrYy8xR1didGNkN3BBdHRQZWp1?=
 =?utf-8?B?alZ5R1U2c1BxVEt2eGVuS0VrNUx2Yk5SUWJtU1dQejZQRm9YUGhqYW1SejFR?=
 =?utf-8?B?V2xhVjZxakd6T01SOHA1R3V3M3hHRnU2QXo4OWNXSEZKNXlFdXV2TUpuMlJN?=
 =?utf-8?B?WU9qUzlRV1ZkTzNQQk5SZk5JVzZqWExxa3k4YlR0SXVqbUhsUUFCQlFWY0FW?=
 =?utf-8?B?MlB3M2hZbU9yaGNmOFRyTTdYNGVjK2d4WWRadDBaVnFnU1NBN015RnVKVWdE?=
 =?utf-8?B?eXV0bncvN0hhVGF0aWNlQk93Ry9YRE1udHovQU1QQXZrNHE2eUNzbU5KWkJC?=
 =?utf-8?B?WkV0QjBmL2M2SmovaUFqcTM1UTNHU1BHd2RENnZTMjJLQzVxUXdqYy9BWVlt?=
 =?utf-8?B?c2oxbTMzUWJRYmthZzlLTDVlTldSdWVjOVVjVVhtbWI5YVdESjdPUEozSjRl?=
 =?utf-8?B?R2M5N1FobTBCMmtZNk50MnprN2FBTng3ekdhaDVsSGl0c0xFQThqb0JaZVpK?=
 =?utf-8?B?aUIxWkhQU09PSnRGU0o1RnJ6ZjRycEZ6eWJuc1ZxNXlwZ3NtTXdpTDM4WERV?=
 =?utf-8?B?Z0RreGFLeWdncE55dFowV2d5MCtlYVZ2WHg0QS9VTEpNSGZxYUxmaEdCTnRw?=
 =?utf-8?B?emRueWc3aDh6SUt0TEJ5VUJ5OERUbWxONExSTFgyTUZZVlVHUHZvdGxrZHZr?=
 =?utf-8?B?RTFQWVkwY0h0cGwrdTRXN0kxbEFFTEgzUTRrSWo2bHBpQUp4V1BpYlNTemNK?=
 =?utf-8?B?Mkc3TFQ0ZitnYnFlUy9Xd1pHelp5anhjTVhkcXdDdEpjK1hMTDlQRmxGWUNC?=
 =?utf-8?B?Q0QwNkJUdHY4YWp0UFdkMGVFYnpvdDI4WDBYWjJyWFhBUVlWUU1aUTJOMjdW?=
 =?utf-8?B?bXMzL2UyK08yVm9kTURydjdtQjg4SmR6NG1TTXBIbmFYMHJXYVVJQ3ZLNjZB?=
 =?utf-8?Q?N54+1AEE9CjhgSLTqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598c0861-bd5c-4e26-b735-08dec79e59c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:46:46.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRJCf7yFP7diB02YXlwOcJWi8CZtRBpzZu7TXC6D0KrSSm39XIvMq0QielQFvEmL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

On 6/11/26 09:26, Srinivasan Shanmugam wrote:
> Introduce a per-drm_file eventfd manager to support render-node event
> subscriptions.
> 
> The manager is implemented in amdgpu_eventfd.[ch] and is owned by the
> drm_file (amdgpu_fpriv). It maps an event identifier to an eventfd_id
> object, where each eventfd_id can have multiple eventfds bound
> (fan-out).
> 
> The design is IRQ-safe for signaling: IRQ path takes the xarray lock
> (irqsave) and signals eventfds while still holding the lock.
> 
> This patch only adds the core manager.
> 
> Duplicate binds are treated as success, allowing userspace to
> re-register subscriptions without errors.
> 
> v10: (per Christian)
> - Avoid GFP_ATOMIC in the event identifier insertion path.
> - Use the recommended xarray insertion pattern with memory allocation
>   outside the xarray lock.
> - Simplify the eventfd unbind loop for readability.
> 
> v11: (per Christian)
> - Use goto-style cleanup in amdgpu_eventfd_bind() to avoid repeated
>   cleanup paths.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 386 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
>  3 files changed, 447 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee3574797bc2..dd5a6fc5cbc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -71,7 +71,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> -	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
> +	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> +	amdgpu_eventfd.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> new file mode 100644
> index 000000000000..4955ee942a1c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -0,0 +1,386 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + *
> + * This module provides a simple event notification mechanism for render-node
> + * clients using Linux eventfd objects.
> + *
> + * Userspace can bind an eventfd to a userspace-defined event_id. When the
> + * driver signals that event_id, all eventfds bound to it are notified.
> + *
> + * This mechanism is intended to support lightweight GPU event notifications
> + * without polling from userspace.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +#include "amdgpu_eventfd.h"
> +
> +#define AMDGPU_EVENTFD_MAX_BINDS 4096
> +
> +/**
> + * amdgpu_eventfd_id_alloc - allocate an event id container
> + * @event_id: userspace-defined event identifier
> + *
> + * Each event_id represents a notification category. Multiple eventfds can
> + * be bound to the same event_id.
> + *
> + * This function allocates the container which stores the list of eventfds
> + * associated with that event_id.
> + *
> + * Return:
> + * Pointer to the newly allocated structure or NULL on failure.
> + */
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return NULL;
> +
> +	id->event_id = event_id;
> +	INIT_HLIST_HEAD(&id->entries);
> +	id->n_entries = 0;
> +	return id;
> +}
> +
> +/**
> + * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + *
> + * This helper returns the container associated with the given event_id.
> + * If it does not exist, it will create one.
> + *
> + * The function is designed to be callable without holding any locks.
> + * Memory allocation is done outside the xarray lock to avoid blocking
> + * inside critical sections.
> + *
> + * Return:
> + * Pointer to the event_id structure or NULL on failure.
> + */
> +static struct amdgpu_eventfd_id *
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_id *new_id;
> +	XA_STATE(xas, &mgr->ids, event_id);
> +	unsigned long flags;
> +	int r;
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	id = xa_load(&mgr->ids, event_id);
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +	if (id)
> +		return id;
> +
> +	new_id = amdgpu_eventfd_id_alloc(event_id);
> +	if (!new_id)
> +		return NULL;
> +
> +	/*
> +	 * Allocate xarray memory outside the lock if needed.
> +	 * This avoids using GFP_ATOMIC while holding the lock.
> +	 */
> +	do {
> +		xas_lock_irqsave(&xas, flags);
> +
> +		id = xas_load(&xas);
> +		if (id) {
> +			xas_unlock_irqrestore(&xas, flags);
> +			kfree(new_id);
> +			return id;
> +		}
> +
> +		xas_store(&xas, new_id);
> +		r = xas_error(&xas);
> +
> +		xas_unlock_irqrestore(&xas, flags);
> +	} while (xas_nomem(&xas, GFP_KERNEL));
> +
> +	if (r) {
> +		kfree(new_id);
> +		return NULL;
> +	}
> +
> +	return new_id;
> +}
> +
> +/**
> + * amdgpu_eventfd_mgr_init - initialize eventfd manager
> + * @mgr: manager instance
> + *
> + * Each DRM file (amdgpu_fpriv) owns one eventfd manager.
> + *
> + * The manager stores mappings:
> + *
> + *   event_id -> list of eventfds
> + *
> + * The xarray provides efficient lookup of event_id containers.
> + */
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	xa_init_flags(&mgr->ids, XA_FLAGS_LOCK_IRQ);
> +	atomic_set(&mgr->bind_count, 0);
> +}
> +
> +/**
> + * amdgpu_eventfd_mgr_fini - destroy eventfd manager
> + * @mgr: manager instance
> + *
> + * Frees all registered eventfd bindings.
> + *
> + * The caller is expected to ensure that no IRQ-side signaling can occur
> + * after this function begins. This typically happens during drm_file
> + * teardown.
> + */
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	unsigned long index;
> +	struct amdgpu_eventfd_id *id;
> +
> +	/*
> +	 * Expected teardown ordering: caller ensures no further IRQ-side
> +	 * signaling can race with this before fini() is called.
> +	 */
> +	xa_lock(&mgr->ids);
> +	xa_for_each(&mgr->ids, index, id) {
> +		struct amdgpu_eventfd_entry *e;
> +		struct hlist_node *tmp;
> +
> +		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +			hlist_del(&e->hnode);
> +			eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +		}
> +
> +		kfree(id);
> +	}
> +	xa_unlock(&mgr->ids);
> +
> +	xa_destroy(&mgr->ids);
> +}
> +
> +/**
> + * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * @mgr: eventfd manager
> + * @event_id: userspace event identifier
> + * @eventfd: eventfd file descriptor
> + *
> + * This function allows userspace to subscribe to notifications for a
> + * specific event_id.
> + *
> + * Multiple eventfds can be bound to the same event_id.
> + *
> + * Duplicate bindings of the same eventfd are treated as success and do
> + * not create additional entries.
> + *
> + * Return:
> + * 0 on success, negative error code on failure.
> + */
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e = NULL, *it;
> +	struct eventfd_ctx *ctx;
> +	unsigned long flags;
> +	bool dup = false;
> +	int r = 0; /* duplicate binds are treated as success */
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Enforce total bind limit without a separate manager lock.
> +	 * For duplicate binds, we decrement back before returning success.
> +	 */
> +	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
> +		atomic_dec(&mgr->bind_count);
> +		return -ENOSPC;
> +	}
> +
> +	ctx = eventfd_ctx_fdget(eventfd);
> +	if (IS_ERR(ctx)) {
> +		atomic_dec(&mgr->bind_count);
> +		return PTR_ERR(ctx);
> +	}
> +
> +	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +	if (!id) {
> +		r = -ENOMEM;
> +		goto out_put_ctx;
> +	}
> +
> +	/* check for duplicate binding */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	hlist_for_each_entry(it, &id->entries, hnode) {
> +		if (it->ctx == ctx) {
> +			dup = true;
> +			break;
> +		}
> +	}
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	if (dup)
> +		goto out_put_ctx; /* duplicate bind: success */
> +
> +	/* Allocate entry only after ctx/id prerequisites are satisfied. */
> +	e = kzalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e) {
> +		r = -ENOMEM;
> +		goto out_put_ctx;
> +	}
> +
> +	e->ctx = ctx;
> +
> +	/*
> +	 * Re-check duplicate under lock to close the race with another bind()
> +	 * for the same (event_id, ctx).
> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	hlist_for_each_entry(it, &id->entries, hnode) {
> +		if (it->ctx == ctx) {
> +			dup = true;
> +			break;
> +		}
> +	}
> +
> +	if (!dup) {
> +		hlist_add_head(&e->hnode, &id->entries);
> +		id->n_entries++;
> +		e = NULL; /* consumed */
> +	}
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	if (dup)
> +		goto out_free_entry;
> +
> +	return 0;
> +
> +out_free_entry:
> +	kfree(e);
> +out_put_ctx:
> +	eventfd_ctx_put(ctx);
> +	atomic_dec(&mgr->bind_count);
> +
> +	return r;
> +}
> +
> +/**
> + * amdgpu_eventfd_unbind - remove eventfd binding
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + * @eventfd: eventfd file descriptor
> + *
> + * Removes an existing binding between an event_id and an eventfd.
> + *
> + * Return:
> + * 0 if removed, -ENOENT if binding does not exist.
> + */
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	struct hlist_node *tmp;
> +	struct eventfd_ctx *ctx;
> +	unsigned long flags;
> +	bool removed = false;
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +
> +	ctx = eventfd_ctx_fdget(eventfd);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	id = xa_load(&mgr->ids, event_id);
> +	if (!id)
> +		goto out_unlock;
> +
> +	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +		if (e->ctx != ctx)
> +			continue;
> +
> +		hlist_del(&e->hnode);
> +		id->n_entries--;
> +		removed = true;
> +
> +		eventfd_ctx_put(e->ctx);
> +		kfree(e);
> +
> +		atomic_dec(&mgr->bind_count);
> +
> +		if (!id->n_entries) {
> +			__xa_erase(&mgr->ids, event_id);
> +			kfree(id);
> +		}
> +
> +		break;
> +	}
> +
> +out_unlock:
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +	eventfd_ctx_put(ctx);
> +
> +	return removed ? 0 : -ENOENT;
> +}
> +
> +/**
> + * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + *
> + * This function is typically called from interrupt context.
> + *
> + * All eventfds registered for the given event_id will be signaled.
> + * Userspace processes waiting on those eventfds will wake up.
> + */
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	unsigned long flags;
> +
> +	if (!mgr || !event_id)
> +		return;
> +
> +	/*
> +	 * This can run from IRQ context. Keep the lock while walking the list
> +	 * so entries cannot disappear during signaling.
> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	id = xa_load(&mgr->ids, event_id);
> +	if (id) {
> +		hlist_for_each_entry(e, &id->entries, hnode)
> +			eventfd_signal(e->ctx);
> +	}
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> new file mode 100644
> index 000000000000..248afb1f2f14
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + */
> +
> +#ifndef __AMDGPU_EVENTFD_H__
> +#define __AMDGPU_EVENTFD_H__
> +
> +#include <linux/eventfd.h>
> +#include <linux/xarray.h>
> +#include <linux/atomic.h>
> +
> +struct amdgpu_eventfd_entry {
> +	struct eventfd_ctx *ctx;
> +	struct hlist_node hnode;
> +};
> +
> +struct amdgpu_eventfd_id {
> +	u32 event_id;
> +	struct hlist_head entries;
> +	u32 n_entries;
> +};
> +
> +struct amdgpu_eventfd_mgr {
> +	struct xarray ids;          /* event_id -> struct amdgpu_eventfd_id* */
> +	atomic_t bind_count;        /* total binds across all event_ids */
> +};
> +
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
> +
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
> +
> +#endif /* __AMDGPU_EVENTFD_H__ */

