Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D9C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 11:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2600310E30B;
	Fri, 14 Mar 2025 11:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NoBMDIia";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DDA10E30B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 11:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjRNEKLh6ZBd1PGfaquFuyjC73PaG4K0/W9Yc+t62pxSEoJAqEDjAEG9IxmjWi1eHfK0gcv8TXGz7Z5Mof/a+ROy7VsG2cd0iVMtvRJJh/8CqtgsIJ1jRcHey2kbxNvYqJuJ5ji5CVMhwq0bZ6hhhOb+NLDYXSP/Ll6iZsyeHShekh2Fwqsh3a8U+qazfippCAP2f4Ccja/TOTnhzT8EqwfgQqGQVp2v4C9/5JClCwoE0GmChLeryGixhrp25dgpxp0XZ9qq1uFSa0hpXPAsSX6mS/oFos0H9gmaO214B8ZcA3dSj5RnFyhZaCnMWHpjgd1d5mDivxtMKYnA7hrmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV/jJQJf7k1nCqGspismCXdtGyq5hNyQPFSvQy3EXac=;
 b=KDpM3GnP/d137AWgsYFJqpBCvsO4nSCqFo++1hYfCYNPc0E3bgdypcA24VV5yhRmBjXy08xqGme81gMnwKgJTkuN3Wty7UuArN0sSIZvX+OORx10OhMn/+hZ0ZHkJkuDL4uZWIa1ipzVpV5RyNCHtkDQL8G05h5PN8yzOv0JNzRXVe2tZqzayZB34rYKeqSLhbWGLJP2YURXKfCNlVOcQgrQf10dKt50ocThKYC7MSfmLl6nINcyaWJBKiKpsoCZ/FqhlIOjzjVaHrqzZkkqIYXpkrvlN/SD4BWgYepjcqUVYArtN7lJ102ikKS1e6jSv9A0KFG/z3JIaAqCKISaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV/jJQJf7k1nCqGspismCXdtGyq5hNyQPFSvQy3EXac=;
 b=NoBMDIiay4YInfEO7RHgM0h/Xig1p3xyUj6YIf7iQtCeTVv5Lp3XW5C1z/vrvQgxEPSdTfgG0jpbudrnXIJ0tEYNrvkRIGXfAHCd6q9BtB5CN8he8qbB/IwOXQSIFZDya8xC/soyyJLseoABsWH9iDRHl6dHnBMWL84YcZIh+S4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 11:20:11 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 11:20:11 +0000
Message-ID: <7fd0f6bf-b83b-489b-843d-ca32f211ad0d@amd.com>
Date: Fri, 14 Mar 2025 16:50:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250313144136.1117072-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2df81a-c8a2-4b7c-4458-08dd62ea2f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmh1SmhlTGtDa1ZpK3JmTkZVMDhhdmxKN2YyVy9tdk1NU1Q3aVNwSUNiTHlE?=
 =?utf-8?B?bFNKaVVWSWxLRy9JU2VMd1hEbTVuZE1GUUJZTnVlT0lEcDBOQTIzaG5iUWVI?=
 =?utf-8?B?SzdCMFNjUld2UzVXUlZmYUl3RWh3YlFMVnVabjRZWnJ4K1J2QldKMnV1Yldx?=
 =?utf-8?B?Q1ZzTjJsdCtyM0QwRExaSllYM3pnWE9DWDJZUVZJWi9ZcXl0SURjQTBWTDE2?=
 =?utf-8?B?czRxYWFpNWpJZ1l6ekt5UXN1a0dGSUw3NXlmdVBjVlVXUnBIaWhtbkp4M2pB?=
 =?utf-8?B?Y1R1RmZMMyt3Y1grc2tFR2RsSURrTUNWU2pMczVyTmphL0F0MkJlai9QTVln?=
 =?utf-8?B?aE52V1VhVlNQaEllSXZ5ZlF6K2ZhUWJVazNCeWZOdGk2OXJMZXFQV3loNWVT?=
 =?utf-8?B?RUZQazQ0L2ZTbzQrVGJuYTZiaTJ6K1ZVNlAvOTBOd2VEV3NNUGwvOXJmMHF6?=
 =?utf-8?B?ejkxMUpNbURhR2VZbXROT1Q0THRIRXF2QXN3a2xHNmExczJqVzNhZ0EyeVRr?=
 =?utf-8?B?L3phR21sKzFqQWp3VXBveUJWSmR1MG1JbzFpcnJIQ0JQcS8zNlVVUEoxdEZ6?=
 =?utf-8?B?aHl6K0p6NHNBbFNnUVFQc2U2dW5LamF5NzU5REoydnF4bGx5dElxU3p2TVM5?=
 =?utf-8?B?eEVOdndDWHhIYjJhME0rK1dIMUFxbkNPUEN1Vms1RnBFWlFqb1hsQTdlVWJQ?=
 =?utf-8?B?MHh0Y1YxVTlYT3BpZEVXeGhNMkpWYkdXS2Zadld2MUMzS0UzZS9NRElIb2ow?=
 =?utf-8?B?ZnRBUW9EK3B5YndVVzFvN3lrQm1YWEdoZ2I0M2NhSUlsR2xmM1VhWk9DaHBV?=
 =?utf-8?B?V1V4SW5iZEFuNm1rYkZMcjdldnp1MGxzMlA0K1dMeGd4WFdITVVYRXhoUmNh?=
 =?utf-8?B?Y0htTWI0UmJlZXNVRms0cGZGYkllVmsyWUprS2NJdUZEWnBQK1diS0VOWmpm?=
 =?utf-8?B?c1JROVZsN2J3V3JPbVpoWW1SQ1lCYzZ6djVGbU91WCs4aFQvaDJlMXg4eG5l?=
 =?utf-8?B?dnV5cHRUalB3cHhpeFlkS3FGc3FMV0NaSjNBc00rRjhHT09nWnRweXhobWdG?=
 =?utf-8?B?R2ZZRCtIakt4TWhuYU1CdVpwbEwwb2tFaTlsbzB4WmFydHZMS3RhOWFpUm0x?=
 =?utf-8?B?UEhXQjFBQVIxbUlwTS9sSEVJWVByZWgxYUZVTWMzbDFyRTZiZTB5WkxpZCto?=
 =?utf-8?B?UzE2NjZIeWtENGQ1MHBlNHNSNDdvb2NFMldQS0FmNks4NkZTaVFVLzY5RHRn?=
 =?utf-8?B?aHBkSVovNEFLSGxtQi8wYVA4ZVpwTzQzanVPMTlma3I5OVIvTytMN3V3QjBD?=
 =?utf-8?B?ajMzc2ZNWVNPYmNXZkxNSnZZWTY2Z3JLZVJTNEZaekUxckpvODFZa01hdS92?=
 =?utf-8?B?SjZaMjV0NmJLM1dXRXpyZEFCUjdlZ01ocm10YmhOU2tIbDRKUEY5cG8vUUdq?=
 =?utf-8?B?UG5XQnNoeHAwUjhLUGgwN00rSG4waDRacCtFS3RNMW1RaVFQWjMvazFudjJM?=
 =?utf-8?B?aERNT216Sko2dEVsSloyQUpiYllVU3Nhd2lUQlRKWHhvbmRoaEw5QVFrK1cy?=
 =?utf-8?B?dUppK24xK2I5RVU1YUYycDVtSmlUUm9YM1NSSllWNFJXQ0oxdzdnblVKVUJn?=
 =?utf-8?B?R01sQkpaUklQTXpYT0dydFhMZTkydVhaU2RUemdzb3dHUjZPMGNldXhCM3hW?=
 =?utf-8?B?VEhscWJEaFE1R0VHZDhsajExVkNHMkZ1TFJTaE1Gb09MbDVSMnB4T21sdnNO?=
 =?utf-8?B?NXVoM1dseDIrZlo2N2gvS2l0Tk1qMEtyejkxcUJnemZvWFNoNEtkWnNMbWlF?=
 =?utf-8?B?WUdOUnVuZ1BCVjFFVHR6ZGNRM01ZaU5hdGVndTZaUzB1N090anJXeGpNSWl0?=
 =?utf-8?Q?ytA21cpDKNVtD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FiWWRqTjFVTWlzYjZPMW41RTNpbDN6ck9KRHdTREpnZXdCSkVnMDZVcnZT?=
 =?utf-8?B?SkpoVjRRRWtxR2NFalRKSHU0bzlVRXYxQTJTektHZzMwRm96b2FFcGZJSmR5?=
 =?utf-8?B?a1BDZCtFU2RzTnhFM1FWRlQ5T2FCSENvaC8xMHZhTy9MQ0hoSTBPWmx3VGJ2?=
 =?utf-8?B?N1BqeWxpVmJyYU9oOXJhOUoyOUI4ZGFFTGZqRlNGSy9HRER1UkVPN3IzUTVP?=
 =?utf-8?B?VWhyUmFaa245NnNzeCs1K3phTnp4QlVOMU5LbVBBdnJHQS8vTlpUT1ZUajBZ?=
 =?utf-8?B?bnVWSTdyZ2YwdDZyVldxK2pTaEFwSTRDOWZnTklNZFEwOVFBbGptaGgvcjJm?=
 =?utf-8?B?TldYK3h6cU9yalhJcFRnNlNKNTd5MEtXdGlNU0NvZkVvN0wvQ2dsOU9XdjQ1?=
 =?utf-8?B?engzMHQ4MW1kbytMaVZhWjhlU1o3ajlISUZ1OGVxMnBCSk40bXhxaWgzeGR5?=
 =?utf-8?B?VUNJdVNXTitaUjlQK3F3NVloR1NUdWo1cm1KUXR5UWlhVGcvalF4V2NJVGF1?=
 =?utf-8?B?aVEramRlVDdLRFdONmdrN1dmZ3grTjlpc3N5QmpPcHorRmFNTnp3OTBlVWFL?=
 =?utf-8?B?T2Y5N05CTFd0M2traGlQWHRjMlprNGM5ck1lcTJ6STNMdkpDczdUNkUvaDV1?=
 =?utf-8?B?WmRIS2xqVGp3RExTV083OEN1U09xV3NQSEVSbDVCcWFCaS8vQzIyQWlocW9u?=
 =?utf-8?B?RldEWmhBdWthRFJITkloOFZydVE4UmpLSW15VHhKYnR4L3FiR0h4UnFnQThv?=
 =?utf-8?B?TXlxczRWWm9hMm5JMnJzditiaDY1blBsSVBPYUdBVkFYK1crS1J1NlV4bmlS?=
 =?utf-8?B?cW96NTdYRjlPVDlBZGQycm13VWd1UUd4OVQrMmZJN2hWRHVyK003SFNkTHRO?=
 =?utf-8?B?Zm1KaWplRGM3bGd4KzVac3JDcWhta1Vpbm9qN3ViVVpBR3FBbnRmWmlKR0NF?=
 =?utf-8?B?b2hzQ2JDbVErSGQwRjZMcGpidXlIVWtPbGhZK3dZOHdCc2VGOVdYenR6Z21Z?=
 =?utf-8?B?TGFlYmpURjIwYVltMStYZ2dxa2VJN3Y2dFVCVWVESEVkR1Ayb29jWlJhOFQ5?=
 =?utf-8?B?S1dIL3lEUDRROHZubWxZM2IvSTJQMzl6NGFwaGV5RlQvVy9ZSmpLTURQWldn?=
 =?utf-8?B?WkQ2Mmd0VDZZNk53T3c1UW40WEJqQjN3VGxFVTNyYnFFdVlsUXZjS0xoSU1m?=
 =?utf-8?B?bElRcXAzMllSUmtTVEhqZThDenlERm84TExEai9maXJVQnh5aWJKd3hLN2R4?=
 =?utf-8?B?VzZqL21BQnZYTzdsT3NLUVVDWHNHNzhiMWtIT2JONXhnZGtUUEdKVEphWEN1?=
 =?utf-8?B?cXVTRHE5Z1c0Qm5CVG5XT1BTYmtLeUl6Qk9QQ29jdDByb2tKT1FDOVNVSVg3?=
 =?utf-8?B?cW1uUDU4bWErS3pOL0tZNDZzeGpZYkQvdzFzUFIyVURMUE9JVy9FT1UzT0RR?=
 =?utf-8?B?QkJyZzNHY29rbTB3VGIyYmZuQmhuWkgvZVl3dlo1cmlSdHkzdUZ3dU05UFhq?=
 =?utf-8?B?YUVCOGpUM2w5UGk0eTBMQnlEQWwwYXM3TzFvZFJDOVdYRytLN2tMd0psY2lH?=
 =?utf-8?B?bldya2NoMDR5emxwc2xOZWhXTW05ZWtDOG9ZOEZzN2NLQ3BzS2lyWjJPcmNY?=
 =?utf-8?B?M0FGWEpHSmJHc2RrTHVkd1RBaWJIS2JLZzRqU2NyTWVQRXd3OFFVOXVPTTZX?=
 =?utf-8?B?cndGaW1mOWxNUEdPV0oyZ3VENGhtaUplUDNFcmxVRkJ5eCtLZ2NmbUJNaVdj?=
 =?utf-8?B?MjV6UFdlZXFMN2JjWkg2Y09OU2ptZ2d5NVYwbVNUbGVpM0FZZXE1SVBNTHMw?=
 =?utf-8?B?V095QjkzV3JxaTZWdnBIWGIrUUowVEpwYnluRkNSR1ZxdlRza0I0TFNPaXhN?=
 =?utf-8?B?RmZ1c1ptRjV1WDhVSEcrZUwycUJhUnEyT2hiUEwzMzVLUzlSblJ2bVBjUjRx?=
 =?utf-8?B?dGI5TjBwN3BkSUxxTTY1Q28ybDk3dWIySDdCZXhvMkxBL2dlRTlDcE40TkVl?=
 =?utf-8?B?N05LaGVyU0hMKytNYXJzR3hTaUF3bXBtQk94SGZXL2hQT0RnMmtDRTRnS0Q0?=
 =?utf-8?B?Y0ZPbithZE5JYXprS1doRVZoYnlPRWZ4NDVibDZrNldZYlJMWFRSYmJFelMr?=
 =?utf-8?Q?WbVVDxSjC6BcHmED9nLLcLFcg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2df81a-c8a2-4b7c-4458-08dd62ea2f3a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:20:11.4049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g71NOk2Yi4L5WkFW6PGIGtc1Drw/dklFYQN3kj4as3Z9Caa4lXs/bowRhph9SWAAZacnN4NuWIvb4TCuIlBuVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/13/2025 8:11 PM, Alex Deucher wrote:
> Add proper checks for disable_kq functionality in
> gfx helper functions.  Add special logic for families
> that require the clear state setup.
>
> v2: use ring count as per Felix suggestion
> v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 984e6ff6e4632..a08243dd0798e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
>   	}
>   
>   	/* update the number of active graphics rings */
> -	adev->gfx.num_gfx_rings =
> -		bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
> +	if (adev->gfx.num_gfx_rings)
> +		adev->gfx.num_gfx_rings =
> +			bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
>   }
>   
>   static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
> @@ -1544,6 +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> +	if (adev->gfx.disable_kq)
> +		return -ENOTSUPP;
> +
>   	ret = kstrtol(buf, 0, &value);
>   
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ddf4533614bac..8fa68a4ac34f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -483,6 +483,8 @@ struct amdgpu_gfx {
>   
>   	atomic_t			total_submission_cnt;
>   	struct delayed_work		idle_work;
> +
> +	bool				disable_kq;
>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
