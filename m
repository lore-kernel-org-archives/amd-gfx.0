Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66B2C48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 12:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E8310E22B;
	Mon, 19 Feb 2024 12:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H2irE5q5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C78510E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 12:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baX7VZWdK6J0/zDsiRfh9G8e8yWQJyOs17wJCe/G2tqOobSMnknhnxdE1ActQzQxB7BBzh6sbLvDWS0Z2c1EG4hbxZy88IH5OfNpLIwz5oX1Z0nbzWpQ8E7ackFR4vw5r0Ie2DQs+k0rCJTPm/uJ3fJfg7DK2C8ldvvfl95gw17j6Qx2GR2FJ92hMGI6JSEAQaQBlKFJDIbBK6C4I/ozRwUNWEDrXBvZyxaQffCR6GL/mh+Hm0uGEJ5MorpIxGKduhhoDN103exDlo+jWNTFTB+W39327C/6IE8vpYi5/cY0GCJI7okKpKNQWnXxeHBN5uOrJdvM6UpFLmzVaOGe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bUrBgeVL62gwaYscvoNTvQamtVMoKZNMwE7C0+SByU=;
 b=Z1jaQKOiQYgMkkOIFyoYN4ENMMZXOaJQAtg+tsneo3ZBiv8zQBzvk0BYgQsoUJQw8oM7iS2wCmvlU1MkXKv5X3MDrEYmeVPRlL8IJknU6PBIxLMbZfQD8S6IMNFrXS3JCsYAT1mXwGpZ6AGCCBm9skM2qwR8E78qnQKE8Y92wz5Vem6kw8jsfX7ybAQQk4PjAu0IHS35XNMa5KR+C6LlpjCmMChJlhCO8V3m3HvwBfe5yedkf9jWI3vnLOyVHcKGs0XiqAsmzioKX4y4SALatWCPsvS1tWz30QZVxih2oCT292oib9pI9tVFEXfXUXOhb8no7PsCicdi3TrbYBRwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bUrBgeVL62gwaYscvoNTvQamtVMoKZNMwE7C0+SByU=;
 b=H2irE5q5Y9FrvodKdJzzeWk2TA6krrK1YsOfLNqrf8u/5wQ95pa1xyWR5KRJiqw4neEIGaxoL4XTDVpZ3bT1dY3IHSdmMw1Sh7BWPNYK16xIi/3+3/+LUhN6YTiCe5GKhaBS3eFUoHSFrhOiyyHABtrUwKBp7RnLD7YKTHR756g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 12:40:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 12:40:30 +0000
Message-ID: <fe223d29-27ad-464d-bd4e-70ec89695d2e@amd.com>
Date: Mon, 19 Feb 2024 18:10:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: skip GFX FED error in page fault handling
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240219081520.316064-1-tao.zhou1@amd.com>
 <20240219081520.316064-5-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240219081520.316064-5-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d43bf3d-90cf-45ea-c12e-08dc3147f4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxWzi51nhCe/U/3ve1u68LnQU70HU5M6pqXDDTvzefduZliC2guZiGpK8HTxwZjLc2fRu/jxX4cFwScuf5ek+iDn4Pq4tFm68Rt1LXBKosLWV3iIzbtkUpmFJFdzApEf2/0E81gxTYvRuz8btysjdfMqqLDVEQQYNM/3bD6Lej68q1scubW2pQ2DvwBeQWJJH1XpWy+IOdY3N6QCaH5KeeuBXrdWboEPu0k490kedjuAh0Wpl78v+Q8QKTKcgcodeav3b7iUQlxA/WtmDZnz4ZA7RSgouRM9qhn3qooHy6VX9fWHXoqvkHzKYhv3rLoTkE2HmlGbELl2RHudx/9CACUwsqyy2xWyDWgV0ZCiSZprP+NXs2Z/mqanZTOk334AYcmEGRRtB1Jxlv/lxzByyv6ASe8fT/VkAZD6f79ARSDlifGOnqOFO9Oex92V4QVM05LTWlz9bFs22XOHpfKtwYBpJP3dQu9X7u0bLgXRBjMDk0Ybww8B7aulYYLfrTjSTJ7zyUz/L4FdAHXA7XJzN9hgySiIKZgoLxM+fRki9IY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2g4VzJNTkI5R1h2TCt0T1VlaVdwMHRjRWtiYVlMbjl3OW5EV01LQzd6RUZH?=
 =?utf-8?B?di82RFV3M0JBZEZBbUczMG81RCtWMkg4QUFzdk9yZ0J6SFJDamwxSjA1SFFU?=
 =?utf-8?B?YlFpbzYyT3JSdVVTRnZhMlFJaDEyQWM3MGNOUE9RT0VmWlJRUHFlM1NQZVRh?=
 =?utf-8?B?M0xXYXhmZVVOTDBzbForeFZnbTdGZHJaNUVPT1dHTC80VTJRdEhDWGw2U0Iv?=
 =?utf-8?B?WnhiZ0paUVI1QTBPMFlTcEpxK1F2OVhuMEh5SU53VjBOTFdlbzJNUnAyWmhF?=
 =?utf-8?B?WjJtMEtIWThLdytHUUpQTTBRTXQyMy9UOStSbXQ5alFzVmo5UFkyb0xQcHIz?=
 =?utf-8?B?eGQyNkVFTDZ1Z05wY1V2ekFMczJ3N1dCSHNiV3N4TWNJZ1NUVXJjQVRyNWdB?=
 =?utf-8?B?a0tmYTd3eTcwcUxKQkRMektZNC9vVCt6aGYyc29VTHV3SFByNEdSMEQ1elRT?=
 =?utf-8?B?WEFZaEMrZEYxdGlwcHpmamxlQlVnOUZ1K2pMbWVNZHowd2x6eWdSd2tzYkpE?=
 =?utf-8?B?Z3RRbWdwblhxZ1lndjg3eEdMb1puQ1FzR0RrREFhQ0hydE5kNzluVTJObGRJ?=
 =?utf-8?B?a1o2eXFNMWFNWUZ0MXpLbmVOVEpGakpXR2pFSWVJWUk3eHd2YTRIYUZHYkEv?=
 =?utf-8?B?TzJlRjhkcHBlQkZLUHh4OFYwMXBlOCszb0NPYTMyMUtkQjNvRzI0bXhEY0dl?=
 =?utf-8?B?Vmh5S3ZWek1lN3lsZVQ2RS9wSU11Qlh0NWtjaVQ2MUxCQlZxdmtlbENYSjRR?=
 =?utf-8?B?dE5vck5IdDV5VUIxTzVIaDVUVTFKOWtEZGVLVUNuZ0o1b1NtWDVSN1dqVUpo?=
 =?utf-8?B?LzFiblByRFUwa3BWeGZYV25RbURoYXhzYngzRjhkQVJyMXc4T042OFM2MnY4?=
 =?utf-8?B?dkxlbTBnT3kvSDl4ZnZBbVQ4bFJpbG1WUVpMblhaVmVZeDJVSHhjWjB0K2pt?=
 =?utf-8?B?NzhYVmQ5R0xHbjdNWE5tbXZTSlJkSjZsbkpTcWRmQnNDT3BENDhvU2VOUUs1?=
 =?utf-8?B?WGptWTRzSU5aNXZaUEZIUjdQUUJma1ZrdXdwbUZUc0lOZ2pUdFNHVnBjQ3d3?=
 =?utf-8?B?NHpyQXkwL2JjemNiYWpZWWRxYURUQUdFTm9uczRDUG1yWGw5UG5IMENZR1Rs?=
 =?utf-8?B?S2d5WDBmRit4VE43Ym0yaWNDSldZK3JnZ0VNdGdxREtRNXk3c2VkTElObGU1?=
 =?utf-8?B?MzRQS045aURnQTBVQVB4Y0lEOGRVQ2ZXWWFFUmNBbnNKTEtscDJCdWdSZ0tQ?=
 =?utf-8?B?RC9xV1VIeUlEWjNuUnZsYU1Pd282ZXZ0K1FZT1RzaFZxNjNuUUNwZG05WFFk?=
 =?utf-8?B?aFRSZ0JGSkRNbk01UE1uZ1N5TDlqZlR2ZVRUZmthWklDZ3FjU25NTGJUZTU3?=
 =?utf-8?B?T251dG5QVjFWK3NRaHlhRjQ0WndhWC9OK2pWNDkvRWdQR2REU3Z0S3plaFhH?=
 =?utf-8?B?TDNKY1MraHJ0cHFvNVVYRGxneTlKdDVhR2dNUFJTN2pGZmJ1UHVBOXBIZ3VN?=
 =?utf-8?B?eUtlT1hySzczaThVZGFaWFVoUTdvb0Z6UmRHcWYzN2I4TjkwNDU3dWxLeXRV?=
 =?utf-8?B?NitWYkw5U3ZkeWw4OFg1WTc4VmovRExjaWNyRzV0b2ppQi95OUNmMXFnVUYy?=
 =?utf-8?B?ZHpkbE5pVENJYjlZeU92K09SeWlsclBCL1BMYnJITnNSeWkxWnUwMmtCempN?=
 =?utf-8?B?OUdFNzRzQTBqWXdYSnFYM0RUSGtSRXQvRDJnalJ6ZE1FS2JSTnBlVE52YUdn?=
 =?utf-8?B?M1lvMTBHVXNHME1qbVJvNjF1WGQ1NFhmWEZTeTV0UXRHUjNLbGVrYmhxWVlP?=
 =?utf-8?B?Tnp0clZmSmZvb2lUSy9sVlJaNWdaQlNKL1pYRk5hMkN2bzh5cmNXQnYyUWVY?=
 =?utf-8?B?MVZmSG5Qa013L3BGUHBTVjU3cmJQdFJKV2NLNjk3THRnVURKeHREaXovNUp5?=
 =?utf-8?B?UWE1am5tUFhDOGFpanp1cVdnWEV5RG4rU1FxYWwwVWw0VlM2MmdFRGRlbXg0?=
 =?utf-8?B?V0d5eERrS2RzcStoS3BGNFYwL2YxUVNzMnI5TXBxdGVFSlM5OW9xVXJEaGxD?=
 =?utf-8?B?dXdVV3NTd3RmSXNndEtEdHgwaWNvZDkyZkxUb3VDSFFUVmJGQWlIZDB2cWdm?=
 =?utf-8?Q?iLtAcnp3/1i6cn++LJFs88bwT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d43bf3d-90cf-45ea-c12e-08dc3147f4b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:40:30.1454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY7bY4m46XfDNb1E/vADSzOQoLmkx83JxBQQBn8/0Va/6MNjD2wqz8TNVpg6fkx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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



On 2/19/2024 1:45 PM, Tao Zhou wrote:
> Let kfd interrupt handler process it.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 773725a92cf1..70defc394b7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -552,7 +552,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  {
>  	bool retry_fault = !!(entry->src_data[1] & 0x80);
>  	bool write_fault = !!(entry->src_data[1] & 0x20);
> -	uint32_t status = 0, cid = 0, rw = 0;
> +	uint32_t status = 0, cid = 0, rw = 0, fed = 0;
>  	struct amdgpu_task_info task_info;
>  	struct amdgpu_vmhub *hub;
>  	const char *mmhub_cid;
> @@ -663,6 +663,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  	status = RREG32(hub->vm_l2_pro_fault_status);
>  	cid = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, CID);
>  	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
> +	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
> +
> +	/* for gfx fed error, kfd will handle it, return directly */
> +	if (fed && amdgpu_ras_is_poison_mode_supported(adev) &&
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
> +	    !strcmp(hub_name, "gfxhub0"))
> +		return 1;

amdgpu_irq_dispatch() gives the impression that return value of 1 is
treated as handled, hence won't be passed to kfd. The commit description
says it is intended to pass to kfd for handling.

Also, FED status check may be moved up so that it's not misunderstood as
a regular page fault with the extra prints coming to dmesg log.
Otherwise, poison status also needs to be added to dmesg.

Thanks,
Lijo

> +
>  	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>  #ifdef HAVE_STRUCT_XARRAY
>  	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
