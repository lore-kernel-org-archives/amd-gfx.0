Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2F3C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 21:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC3B10E9B0;
	Mon, 13 Dec 2021 21:48:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D2C10E9B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 21:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbIYnVJ63jbwuaj43Hq+6qgwBv99pADbJNoH+T+1JuXmAWRVhIWaCO0+0KizxBn0WDpuKAEpr+W+n/H0Qvr8odkffau9geS3x1B1UWe5dG7qcHQaN/LhBESLb4m6y4A6OJcQ6mSHqJb2a2+1j6tqhcaBtcbD9IaOoum+TF5oP150H2b0ehbU7ziaK9cAY82ouQzOBlRHeLcXYX814pnf1bAQKBloclVYCnje3H42cmywZWpwSbsEp9Y7wj0ihDtH4l8HbaSJ0m7Lyzp9MMyYYio8wJuY5lxr3izziO+TodK/61lfQiUX6AKOu3/WnmxrIA+KKppElVDkEJ89rJ/WlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ulCuaygjvU3tXJcqZyFd/oC3gnWxg5gHWam6qGuSyY=;
 b=HeUIDB8JY6aWVdboRoCR/dbMUvBJzu5epVa5EjXgcp8AyXJGPVruIug/u2ePH/kL8lnRp/DCx6IZcnQTeyJWTb7QrWJ8QqQRsp6JUnjyq765KrNsjgLDH2bv+MKeRlq2XgoEjzUMeKf7slurxeqw8cS1b0O9ySVRxdDAZb8w0Po7xcUwUZTsmK11Z349BTfXD+BlJisTdpkyOh6weWCKH1W9LNkjqzp+YnYxnBpHlKtVb5cKcLfWHkoB240QjQAVVHgxTaZN0U/J2BUQyN8qX8NOwt8LuP/YrCzhIvtMmgEr6XH2bAIr04iAMDPMV08MsyW2Ogt0f3MNR89vb1c7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ulCuaygjvU3tXJcqZyFd/oC3gnWxg5gHWam6qGuSyY=;
 b=vlyO2EdQ4F8auO4PHeaS5G+QeTu04GMDwP79r653b8Jx72Ku/2qKrY/yDraXpJY9o++LqFIGQAs/ifBdw6DIpr8u6dRN54Groo4oBmaRZdd/fhotF/gX1sLNmD+/eeMsbyDIsaInSDfEYOqTjz2DEn7IF2TVtW+KmZt1JRttgDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 21:48:12 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 21:48:12 +0000
Message-ID: <ff5cbfd0-f5b7-d03f-82ab-dad0b9c50a49@amd.com>
Date: Mon, 13 Dec 2021 15:48:06 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [v3] drm/amdgpu: reset asic after system-wide suspend aborted (v3)
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::17) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47fd1ca4-93d2-422c-9e0a-08d9be8242ba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640546307D7CA025CA191BDE2749@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvq9fr6XfhqBXqfn1PmSCYJcJhEilWkt0v8673E5yXElJzJs9PqpmXr9RUUt3s+6IyO7g4TdhDBDp2pqaMr9WBLIipSyLI9pKy1/z1dvARk17/p3JoupD4G5EyL7OtTl7Ozak2i3m+GAnkzOHREzCbKtIgfpzJWswp33SuJQzigk0BLL7zo7dpF+flyjXHb6LAnUITxerzEiq2FePJMTgbYif6B65ykXs2S/lA18XOnpfBSHLX3k58I32la6Pb9ZKi8GXn9ggCS9dkzevVCeq+hsET/pLRmOpQ9h/OhjkZsj5fgK5iXP4FqFAPIDgW2rXCy57AjZzAWNG96SlHXbsY5Q9kegK8Urqrjtj7gispSZyuEP1irWnefZu8YiDAxy8XVc80z5/Nm+X2Y2H+kifkwfMbsG9Hqa8gqiktQKNVrf0cXuiQPvOSxA4fL3iukVBF3pTZCs58eBi3LeBDmkXUz65HRbdbA+n5yI6RCBQEZfI50BpPGp4ByOhCLY9zHEh2wP0eU2gYb+e05TTh9kMfbpfxFbWc8uAl9hsBDTiFrqaSHGi/xC7Ub1ulAyAEWoTQJXPR47kfZYx5F9MhQmrB63+2fHxLR5Kzce9emWmEy5++v+3K1oeod35DCwYTy5M6dr3wXn32tZOr9+cQIl4PgiJqqyxGTK37Fp2auVrHILh0T+5NecaD4udOnA7fIWWxoc5HIN78aHK3uTa+QJV3AOaekwQfZ4YJdmjhY0nOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(66476007)(66556008)(66946007)(6486002)(186003)(8936002)(2616005)(6506007)(31686004)(53546011)(6666004)(2906002)(26005)(86362001)(316002)(8676002)(36756003)(4326008)(31696002)(6512007)(5660300002)(83380400001)(966005)(38100700002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEw1VzFRcUdjUFozRktIVlhNUWQ5SnlINTc3eW1mdjRIVVIwcjBrdWp0cUE3?=
 =?utf-8?B?MTVOTVM0NWppM3FGbkRTeDhadlBmenhvb1FhMVZweks4VWEvbEt0ejh2eGhm?=
 =?utf-8?B?U3d1UC9xYyt0UEdHRXRpTjV6S0VTbnJuaHhkTXFQN2xMWVliMTk5c0NZZDdy?=
 =?utf-8?B?WTRqeUFlSlNSTk9heWZpMWNDOGJyeGVZK3llb3QrRkVnNkpyazZTdmJIUmRV?=
 =?utf-8?B?SnFYaWNTbDNOLytCT3kwWUlVaVBKeGJtSHE4YjA2SFdtZGREL1hGVlNIRWxG?=
 =?utf-8?B?aWlQNk1TTVFBbkNmdklMZWxJRE10Z08vTlA4RnZ6MHJXckdtK3pOcE1UZTh5?=
 =?utf-8?B?M2dFbk5GcysvdlhHZjEzS21yalo5dlNZRlJqOEozYzRkS1pmYjJXNmtKelpT?=
 =?utf-8?B?WVE2N0M5UWpKNmFoWFE3VkdNdmp2N1FJUjJDa2dobU5LV29UQUV1NDI5SHZT?=
 =?utf-8?B?VGk4Z2xZcE9FY1ZTWEFzaGJIZ2QvcFZzTy9ieEZ3b3BxNDl5WDBNRmVud09D?=
 =?utf-8?B?WWx3dE9sYm1MbmN3NFhodTNPWENMV1p4UjJLbFlZci9OZU40cmpFUkpGa1dC?=
 =?utf-8?B?ZDVqZVBaYTlNenAvb1AwalMwT2JJVzJad3FWTHZzSVJTREIxaUNYU0xrbmho?=
 =?utf-8?B?U3RvcytVRnJFSitMMUgwY1R2WUlLNGpHR2VqZEJWMTRPRkFHOTd3cFljMEc2?=
 =?utf-8?B?TE01dXNmTjVCM0Y4S0J1ZDNGMkE5Sld6V2c4b2Q3SHpEM3dhemxuK1VDeXNy?=
 =?utf-8?B?V3NTSEczVHJUbzJ4aFZKTE11b0xRdmJ3VGxSUXBxTzVtMTEzaHhJVnZCeEx1?=
 =?utf-8?B?SE8zNU1leXIrY0RjdEM1MG81cUVWMDdnNlk3NytPWFdXV09SNE9rbkppL3d3?=
 =?utf-8?B?eDRKeWc5NXlGQnM1aVUvWjhhVmMvRGR0M0xQU1hZK25PRGtPZzNsczltMzJu?=
 =?utf-8?B?eWI4TDRUb0loTG9DdzhQOXRua0xhWGozcjMybmUvaUdUU2lVWnJmZjNqeVdn?=
 =?utf-8?B?UUlmVldvUDZjRGkxOE8yRmFtSzNPYU5BclNrK0JnOXpCRmRPeFMwT21aWmJX?=
 =?utf-8?B?VDU1dk9wdlBuQ1J4VmdEREdFSFUxU1BYQU45Q25sSTNIV2c1SHpYVlBuU0sx?=
 =?utf-8?B?MWNwd2ZoOElXbk9jcm5mcnZMV1NHTGVYL1ZZWW5NV3VjWDFxQkswazNvdXJC?=
 =?utf-8?B?ZzJKVlBZUHgzdjVFbFp3QkJjR1RiQ0MvQlJWWEhiOTZIN1hhUm82MjFYN3dM?=
 =?utf-8?B?MDBFSlBNcnZlV1EycXcwY3h5bmIwOGxleXoyTHpiYXJhNHBpOEdJNGVzTldU?=
 =?utf-8?B?WkRMSDhVWDduUDBOTkVvWGhtb0J6RWxLSmRPSldrdUk1WlJ5SFVFVFNid2ZL?=
 =?utf-8?B?OFRhZ1pWTVRWcm5TTlNoNnMrU3QydHk3ZlJjZjhvNThuYlZJNW5PZDZ1Z0dr?=
 =?utf-8?B?OWJ4cEJ0am5ZS2lVOUdyc0Y4R1p2MWIrOFRlNDBpWVROSnVISDNyYlpzMHBv?=
 =?utf-8?B?WGJpUmIwWE8ySnBSc1lzQTh1dmlqSUo3L3Y4dEJ0QVhIRjFVMFhiOVl4WW1T?=
 =?utf-8?B?cGVsL0NVdWZUUXdYazVBR1dXYVFIMHNlaUJVT09aOWdVSXJ4WTZZWUFEd0ls?=
 =?utf-8?B?TTIwTEFWOUFlalBwcXlhWnhFYkM1ZWJEYmszNmxoMXlwamt0UlBuVlNBeElC?=
 =?utf-8?B?WXI3SFlVUVFlNitkRkxtVWZCUTEvZDhLYUE4Q1c4Z05kL21nV2N3ODN4a3pu?=
 =?utf-8?B?SDNvS041RjNEekF5TXFiN051ODQvUVEyUWtNMmlUeXNYZVVZaCs3WlJBTjRE?=
 =?utf-8?B?VUxrMjNJRWx2ZzRQZlBoM1lodXh0Y3dXZnRaaTdNbExyYlhMcUhOK0NjWWdD?=
 =?utf-8?B?eElkRjBYQVFzUlE5RW9uYlRZdE01dlB4NmM3NkNCQnVBT0Jzb09OWFdFSlVw?=
 =?utf-8?B?MkFZbXY4aUVyUFl5V2pjVGJsRFhUNWFqQ3dWVnZGd1paQWt2RXVzTHpQYm9C?=
 =?utf-8?B?SENLWXFGNTE5dWxwMXhVUERqaXJrSVVCc1p2cFczV21NY3BlWHhrcXU0ZHZt?=
 =?utf-8?B?cUlNUHExVjVhV29WYWlYaUtaNDFScWttczFxSUVyWU1zMm0vR0dZZUZiZGVj?=
 =?utf-8?B?MmhrUE93Um5MeFBMYUk4UVdZUDlod0svQnN2clBYNUtLNHNDNkJ1cXJKMGVK?=
 =?utf-8?Q?St+zshPNHezR1C0zfQvw3ZE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fd1ca4-93d2-422c-9e0a-08d9be8242ba
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 21:48:12.7224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgPnJ+sM+ELn4sUoWNYwmwlawuAvvtYLHgQQsiedxv3Nd56aN5ZtukYdqJYYJu/wmv4PtgZ58XrX4ZvmF67yyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/24/2021 23:48, Prike Liang wrote:
> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
> to keep AMDGPU in a clean reset state and that can avoid re-initialize
> device improperly error. Currently,we just always do asic reset in the
> amdgpu resume until sort out the PM abort case.
> 
> v2: Remove incomplete PM abort flag and add GPU hive case check for
> GPU reset.
> 
> v3: Some dGPU reset method not support at the early resume time and
> temprorary skip the dGPU case.

FYI to you that this was tested on an issue with S3 exit to show success 
that you will want to include in a Fixes tag for v4 when you change it 
to just run for S3 path, not S0i3 path.

https://gitlab.freedesktop.org/drm/amd/-/issues/1822

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7d4115d..f6e1a6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3983,6 +3983,14 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	if (adev->in_s0ix)
>   		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
>   
> +	/*TODO: In order to not let all-always asic reset affect resume latency
> +	 * need sort out the case which really need asic reset in the resume process.
> +	 * As to the known issue on the system suspend abort behind the AMDGPU suspend,
> +	 * may can sort this case by checking struct suspend_stats which need exported
> +	 * firstly.
> +	 */
> +	if (adev->flags & AMD_IS_APU)
> +		amdgpu_asic_reset(adev);
>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
>   		r = amdgpu_device_asic_init(adev);
> 

