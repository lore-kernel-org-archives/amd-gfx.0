Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58346E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 08:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D7C10EFFF;
	Fri, 10 Jan 2025 08:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hAbdU+6M";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB6710EFFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 08:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+5a8wXolSMAqRFOIEnzorCzIlq9W7ClywdXArGvL1Oznbe7YcEjeFss3EPT3E/pAYM1qLe02d8KfdCsOmmT3ClyFrF4AjIu1VgE7zDohvewazqcVWbRCJO+vNUnwdmDHVY4qvyUunrqwtiQjlSLIf7ypnaixkPfHn+bR077oYWTvkmriX7c02NsaSpTIue2MWXAI07DPZLcYNZMYJkabHckZaCC529hNxsv8Qx44hi/jJKHZBxvQgggoINcfSA/4+zMyb5GZn+OQ/24ikOoUrv/oe/7dqzA6jZvOMo0rRg5bzg8WZjGwugdOYzWULWZUeUcaLg5lQllXxbOfvyyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUME+ahvZjNRWUiMNPGx24NrSAxi4+Dr7Z0Tbq2velo=;
 b=u+/e4cTE3tITitVfLsfdG+IHlHB2AiW8SAxLbevZYOvuS5vZzHHpTa5mLCfhZByRPf2wbmK8mDw6k9Gxrv/xJLmuRx2LIgHHXFPBHPGTG39wSbdszwZOnniSQVw/3+Zi633BEMvGLv0rQHCJL1qOKOxNamEsDfcA76jwSs8wgL7n6HrwgZRHydpQuu5z0ciAcdgzJyqRuDO2L2iQOSCupe+E61Q5LrqMZljgtvOHElHYuQUMEFLGE/QAYFXmcBwP0APcTg5zOFCS/ZT3MgoDfibIMPgkxvZq+wJm1rS+CHCfcf3m8F6JT4bpfk+Hzudv75JjNp7jYRJJZxCsWsPNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUME+ahvZjNRWUiMNPGx24NrSAxi4+Dr7Z0Tbq2velo=;
 b=hAbdU+6M5vCw8fRtC+3JlqXsQ9iPE7+WUrUjKmgVTE+rFr7kMPHL24w5Fz/i+DfBJvY4e3ybfkO6fmzkPoevp0kfhOiBJueNLeitGlg6Y+VMwXTjRmkk3L7rrBId+WJIbnnXoUi4VuRM/7okCKjlccJUnvW+FyE7fhurEdtA7W8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 08:19:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 08:19:24 +0000
Message-ID: <cf81e44b-f4d2-46a6-8908-3a929316a824@amd.com>
Date: Fri, 10 Jan 2025 09:19:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <b824d12a9636ac43066d731c514de8abbf1d115e.1736474822.git.gerry@linux.alibaba.com>
 <098f1b68-4772-481b-9b50-864d9cd2ad8a@amd.com>
 <E4A0DF29-FB19-49CE-BF2C-373D9D75C39B@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <E4A0DF29-FB19-49CE-BF2C-373D9D75C39B@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: d16dc36b-fef7-44a7-32f3-08dd314f7deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0ZjaS9ndkJjZXMvaVM5eVpGbUFMZnYzS0dPb2s4ekRpcWlRZHRJQkxETXNZ?=
 =?utf-8?B?amFpbFlJek15WWZPbUdHazZSOFhlL0diNnFZcVdvL0pjS0dtcldyZ1lPVzhR?=
 =?utf-8?B?WDRWL29mZmFqVUY3bWIxeU9RSGVqS0JTOHI2bThFQ05MdUhpSDVUemtwQkZ6?=
 =?utf-8?B?NDhnbUJ0eHp2bUtsUW04eUJlOHVzYityZlNiVkNzT2xyc0dReHo3WVFubkpL?=
 =?utf-8?B?RkIvajRXOS9FM2RUWkd3R2xXeGk3TWduemE5YU8rQWtJcjNKcTNjQ0JoeDQv?=
 =?utf-8?B?OWpucmtCLzNsbUtrNEVFSnQ0Y2Q3VDZKVGNUVmR4M3BRVFFWK3hxZVlBSjZF?=
 =?utf-8?B?Y2UxUlk1RnlFcWRrdGxBcTExYk53alprY2ZPU3ZVVUdiSHNQUHllbEZYVEpM?=
 =?utf-8?B?cW5uTEhBbXgwWEpjV0JXUUFhR1YwZUpqTmdLVHdLL2d3MEF5WW9wb3Bic1Ra?=
 =?utf-8?B?dm4xb0NJazZlRTlBVE40MVFKQkRXZGY4L2NLMFZUaDRtVDltZUdNTUw5Yllj?=
 =?utf-8?B?R043YThKTWszL2ZTTFh1TmZmaWNGVEZvcGowSlNaRWYwWWVQcnJCVTlzeFN0?=
 =?utf-8?B?d1RrS2JzS08rcjFlVjJrSUVGclcxZ2xkSEIxY1hQWGxPQ0c1eWM0UzdoNzMw?=
 =?utf-8?B?R2hoV2Y1dUR0dmNUQU9aQWtwQlJveDhHT3R5WjRCVm5CYUlyc3BHVzRtUHFJ?=
 =?utf-8?B?N05QUG1VQ0pKenRSdEQvRVVVWkphaW9wQzZ4NmVDWTc0SWdlRis3azczZkVF?=
 =?utf-8?B?bUF4RlcyOFlBaUgybGxkRHlsdVNlUGZIWlRlR3dTcE1UVWZYaWlhd05ScUN2?=
 =?utf-8?B?M2hyRnFFc2lJaGsySFFNcXlqU3NyanROc1lyeXZrVExJMzZwbjFUYzY4Ymww?=
 =?utf-8?B?SVkwTFFHYzBaL09Zbk40aCtjcDJZay9NQmV2Z3NQelFBVWovRmNMcjZ5dXFw?=
 =?utf-8?B?SXlPaC9kNkJCeEZVb09KcGwwR3QxeW0yazhNdGJvYlFYTTJjUXRPbDNJK280?=
 =?utf-8?B?ekprRGlWa2swOWROSzdOeVVOMGt2eWlsL2haVjdlVjl5SG8vYWpuUTNLZVU2?=
 =?utf-8?B?M3YzNGJXRmNDUE9Jb29BYTBhSmtRdzZHNGE1Q0t0dWdGdTJZWW51N28rWVRh?=
 =?utf-8?B?d1B5djNXZW52THBoNmErWXIvWVlLKzYycEJ6WGgzZ2FSd0pTRk5qRURTM0U2?=
 =?utf-8?B?NmVkbGpZcm1KRlZONFVrUFBIdjhiNzQwbHMwSmhnRXdrREVkMThMMm1jR2w0?=
 =?utf-8?B?dk5PcmV1L3BWSS9LcHp1eG1DcWJ5Umk2UWJxSXB6aGRmcmVNc0JCeWEzend6?=
 =?utf-8?B?MG5YRkdBMlNKRDdqa1FJS21lWDFjcnFrRXlCNE92ZUl0Q0NqVnNvWkFZUTRO?=
 =?utf-8?B?RklYY0FlbmcxTlFIeDlxVW5iUGMyZXJaekpQWWRUd21PUlArRUc0N3NtTWRH?=
 =?utf-8?B?c1lWL2I1dlRDWjY3Wm9ha2tvejFibzZUZjhOYS9Mc0szcWFleGcwWnI4RWhQ?=
 =?utf-8?B?Mkw3YnF1MktNU1VzMzZwbk1OLzZ1M3BMb3B4bWFDaHNWcjVaZzJHZTRtSVhz?=
 =?utf-8?B?YkF4UXZJOWQwa2xySVU4VE1jeS9UZURocG44UE5sc2M1UHpEZVIySmRneWVQ?=
 =?utf-8?B?Q2lFLytSL2VxMDBjNjJaR2hRR3Z6RVgyNHNraVM5N2E1MHB1dG9IYmd2b28x?=
 =?utf-8?B?SmxObmVoVzR5NXJMMkVwWjlGWnVqZWhINWQxVEdBWjRReFUwKzdVQjFxVEkx?=
 =?utf-8?B?WU1wbEZEYUNGeVQ4d1p3NW5HTGVhVGgybC85amJzejc2Njd1Q3dGeVVoL2dL?=
 =?utf-8?B?VUYxOFd2ZTkrWm9rcW9idVFsaytqOHI1cGFEbys5VW1MMDd2cml1WTNtL3cr?=
 =?utf-8?Q?2XHa5GU2a48GT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3llbnVHUTNCczdSaTJYMmpFMkRHY3pUZGpMelcxNDZuK2I1S041TnArNk91?=
 =?utf-8?B?OEh6RWg4Y0EzeDd6dDJKa0c1eGpOQlJiSkY4LzVxR2JJZHU3VXRHWFdEelNl?=
 =?utf-8?B?MHpNRXFmVkhRdTNUa0hFZXd0YmZoajI1UW91Z2FjWG5YZ0lncldDUjRpK0Rr?=
 =?utf-8?B?eU52RFc3ZWZacm5ycW5zdzBMMTVpWVQzOGpnSmRQNnBlNWt6Y1RSUnhqaGxM?=
 =?utf-8?B?dWFwSkJNNlk5dHVGRFpkL2wwWXZZKzg4WGh2SmcwcVhQVFJsbE1Hbk9GZnNE?=
 =?utf-8?B?VHFtM1JvV0E0RFFIemRkbGl4ZDVQWTRFOXFuSm5jVzE5YWxYd3R2M2lwY3Nx?=
 =?utf-8?B?ZFd2SmgwdDZPczYzVFpJbE45bmx0Qkd1aHhSK3BwS0hzZkdITUtGM080eUkr?=
 =?utf-8?B?eTc2eWNaNXJWZ2MvbXV0TFpEZmxpMkJ5UlgwOXI5amNsQ2xwRUdlVVZQSzI3?=
 =?utf-8?B?R3d5ODV2Wm9MeHduMHlPTkN1NlR3OHFOWU5malMwSHpsci9TU0VxcDQrZ3BS?=
 =?utf-8?B?SHR2YmVVeTFxS3hMK0V4V3ZtaW9tWk9Xc3RYNUJ1dmIwYzQ5NWlHYUZzVWcv?=
 =?utf-8?B?L3N5WDNEQ3lZMEdsTkZVUCtkckpob2NNK0tMdjZ3ZUNnZURLSVNLa1EzMnlz?=
 =?utf-8?B?T3BmSU1MWjRYQXNHWXdUWjNsL0hxaENJQXhTR1FVb25TRGthMTF6c3NRblhQ?=
 =?utf-8?B?N29jcFNrbnBiNDM2UzhHei9BYlBRUjZWUWZ0bXZ0MmdGQVYzK0lxUXdxVm9F?=
 =?utf-8?B?SVJseWRTWXNxU2N1TDNTSlVPT3lSVDlZeDZqY0ZueE8yUkhHbW05c0ZaMndD?=
 =?utf-8?B?VldDYXg3d1RWVmZRM2lWSEFpZG1Gek5EZEFaRUE5SGNvdVRJTnRveXlYQkRH?=
 =?utf-8?B?N3FWSjlLN21rNnNXUEhyY2ZHUHBhWFgrVlVpWkFkNDFIOHpNdmtVR3JTNmpC?=
 =?utf-8?B?ajdYQTlzRVBTdU05SnNXeU5kWFpsaHBhVzVzWDFLVENrUytpQWFIc0ozTkZl?=
 =?utf-8?B?THVJaUNCZkhldEdJOW5sTDJ6ZkduVWdUL29MT1M1eEtxR05iQXVsWnJXZ1d1?=
 =?utf-8?B?U2dTRXJsRGtkSGJ4TXlwTVFyb2RjL1YzTWYwdjBXMzhoQy84cjFnS2xoVVph?=
 =?utf-8?B?ckh3ZGpQQm5UbTNVU0Z1alBhRGx3MGNjT2tKL3RvRHBPMmZPT2g1ZUxaSnlR?=
 =?utf-8?B?MUJTZ2YwdjVFanJPZk9aY1NYNjhMZTRNRHgrZTVPSGRBd3QzVkxtaDF4NEVj?=
 =?utf-8?B?aHE5QSs3YTR6VTEvVEN0dkFIb0EzOElMMS9wTG5UeWk0ZVZkbmJUV2M4U0Ji?=
 =?utf-8?B?aWtCQy92QkxpbkFWNDdTbGZMa3cxSCtiR2hXYlY2WEt1SVpOdWlPZmxVVGtu?=
 =?utf-8?B?UkhkSHExMlVQeVFPM3JyWFUwOWs3K2tvUi9NUTd6cHZiRVdGV051dzBLK2FU?=
 =?utf-8?B?SExYUmtvWmFpQkl2aE9ZZ0F1SHN1a3A2d0RmUnNwSk5kRTdId05yM290ZFVv?=
 =?utf-8?B?aHZNdG80eS9idXhqOW14NjdCVkxRZXBQdmhQbjNqb2NkSWlpR1YrdlRQZkZG?=
 =?utf-8?B?WDNaSjcrbExyTy82Rk5pY2hTQ0JhOE44WG90VHRMQlZCcW4ySEpqR1lsMHNQ?=
 =?utf-8?B?TllGdE12OU1EWDhWSDV5V3RsSjJJOU5Ldk5YV08rak8rK3I4eUVKdkNnY2RK?=
 =?utf-8?B?SmlIelFoajFMT2xGL0RBeW45OEVQZGlST25uNzcrcXdSdnErTCtHcUl2NGp5?=
 =?utf-8?B?ZzBZNlBQaitlNXRqdURjRXorZzNVczJYLzFpRUdQWjJNa0k0eFlxcDlmWmc2?=
 =?utf-8?B?QnJEUFVXSlRERVJlUENxZklESTc5elRPZUd1ZFZpZm1XWGZmcEMyOVpJRy9U?=
 =?utf-8?B?OWk1R0N1ZUlkd0dDSHRQRkpwTEhFWk52eGtPem9UalZqYmprRGhCNEc5cGJs?=
 =?utf-8?B?ZDJkeGM3QzVocHpJWlB0QkV3UEMwQmYvVGEwYVgwQWY3R2ZFc2IxMFBFK1NO?=
 =?utf-8?B?cjVGQzVlKzVLWU5YaWl2Vm5keUkyOW9LSnFOa21JSWptUlc3Q0Z5WS9DL1ps?=
 =?utf-8?B?Q0J6WU8yYVg0MHpSVlA4WGZFRmo4NnUxTkVESDdMcFBYYjFiVU9QVUhXYTdL?=
 =?utf-8?Q?Hs8bv/kayaOIZfvM0PD5dV4d6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16dc36b-fef7-44a7-32f3-08dd314f7deb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:19:24.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0nFeiinTncawpy/KdRi/B083RpPIEZkgxBznjGNFW+BhN2aiWoVuqTHBS9UCdN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

Am 10.01.25 um 08:37 schrieb Gerry Liu:
>> 2025年1月10日 14:51，Christian König <christian.koenig@amd.com> 写道：
>>
>> Am 10.01.25 um 03:08 schrieb Jiang Liu:
>>> Function detects initialization status by checking sched->ops, so set
>>> sched->ops to non-NULL just before return in function
>>> amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
>>> to avoid possible invalid memory access on error recover path.
>>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index f29a4ad3c6d0..3688e9eb949b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>   		if (r) {
>>>   			DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>   				  ring->name);
>>> +			ring->sched.ops = NULL;
>>>   			return r;
>>>   		}
>>>   		r = amdgpu_uvd_entity_init(adev, ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 2f24a6aa13bf..b5e87b515139 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>>>   		 * The natural check would be sched.ready, which is
>>>   		 * set as drm_sched_init() finishes...
>>>   		 */
>>> -		if (ring->sched.ops)
>>> +		if (ring->sched.ops) {
>>>   			drm_sched_fini(&ring->sched);
>>> +			ring->sched.ops = NULL;
>>> +		}
>> As said in my previous reply we should really stop checking sched.ops here.
>>
>> The scheduler should not be cleaned up by this function in the first place.
> Hi Christian,
> 	The current workflow is as below:
> amdgpu_device_init
>          amdgpu_fence_driver_sw_init
>          amdgpu_device_ip_init
>                  amdgpu_device_init_schedulers
>                          drm_sched_init
>          amdgpu_fence_driver_hw_init
> amdgpu_device_fini_hw
>          amdgpu_fence_driver_hw_fini
> amdgpu_device_fini_sw
>          amdgpu_device_ip_fini
>          amdgpu_fence_driver_sw_fini
>                  drm_sched_fini
>
> 	As you have mentioned, we should introduce amdgpu_device_fini_schedulers() and gets it called by amdgpu_device_ip_fini().
> But I have no idea about why currently drm_sched_fini() is called by amdgpu_fence_driver_sw_fini() and whether it’s safe to move it into amdgpu_device_ip_fini().

If I remember correctly we just put the drm_sched_fini() with the ops 
check as cheap way of cleaning up all schedulers before we had the 
ring->no_scheduler flag which indicates if the scheduler is initialized 
or not in the first place.

So it should be save to move the drm_sched_fini() into 
amdgpu_device_ip_fini() as well. Just check ring->no_scheduler instead 
of ring->sched.ops to decide if the scheduler needs to be cleaned up or not.

Regards,
Christian.

>
> Thanks,
> Gerry
>
>> Regards,
>> Christian.
>>
>>>     		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>>>   			dma_fence_put(ring->fence_drv.fences[j]);

