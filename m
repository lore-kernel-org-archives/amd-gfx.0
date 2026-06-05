Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF494CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 09:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5775F11A5C7;
	Fri,  5 Jun 2026 09:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OcQBdwCL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB9211A5C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 09:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpcXJiYNUX3FMrdlm8ywAnOtUbUmoO/p68wmL5zndxpZk/D7gdtMUfIBQtTUWkU+Du6skSQAKV/9ic4/0IaVwYesb3/c51e94JIjsSgdJ43g/2H+e5jxV+10msmiHfHxLmTp1878fXTS+qeNnYV0FOjEitmuNVk/jbKeUJM6uHgtqXdrpyhxsagsSOtQbucO8Nagc2Vftus3ExpVs9uMWsm66v/2erM9DiF64xCiL7J/NaIECrX90W30l6osZoB9oyb+6bh5xjocicxDYffAsg3wovNmr+BiLOTMv8fkhHa335XgfYRKUDVV5GqMtF8PigderdAOmFWwxmGT8bXZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx1TngpY6Hhve4czEaaCwHRdhunMrKFJvDWutzL+I/c=;
 b=o3ffr1Da63vtA1dGPvfdON20MxhBoiqrW/qXQBdt+3JSli6bjzTHNsmJGdQkhalo9foy50c74Zo+z4DgkAZ2HdXF3ScTl+Dk4atW0s4h/r/0kUbTTKzEtubdDT09NRt8h5LfBbJrSJvGw/tdNcSv329T+BDm5n9MHwBd/HIBc7q/D8Aw5ByDxTWJOSr8LWKTDBb0PmbddIonNXCqnoTewL+l18egLrnVxngnLvyzYUAYUe4+LrLFxFNRVREFH4gJ+fsPtKKg+mNCyZAF6DnbjBE1ViAVKhfVSAyLcedcxaN2x5auZnH9y07UTHjM783OR7rUBCYR49gRLPQSJGdG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx1TngpY6Hhve4czEaaCwHRdhunMrKFJvDWutzL+I/c=;
 b=OcQBdwCLlIvUFnsPfAKdlI4Ukd5OXafFCz1R+Bm3B+dt9bMRkC4eWCXSV3fbNwU0mFCyPts1saO/0JzyQl1C7Gm5vdAqXJqMFXNC+FMaG6UTlUtDnRzD8S8rjk+wUfLzoYrZAeTOnAwBQ07/6HmJUhyYUTxKQV/Dyy49IwhZqAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAWPR12MB999139.namprd12.prod.outlook.com (2603:10b6:806:4e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 5 Jun 2026
 09:24:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:24:48 +0000
Message-ID: <9cc1c11a-ffbd-4b33-9608-111ba12bed1d@amd.com>
Date: Fri, 5 Jun 2026 11:24:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: always emit the job vm fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: timur.kristof@gmail.com
References: <20260603194535.2371150-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603194535.2371150-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAWPR12MB999139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f93e3ff-6f0e-4788-140e-08dec2e449fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DApEvBhjl2vyZX2Lgaq7Oe3JguFujtF43RC9AqCdQrwLj8MeGEJGYKd3czUVluXTmLi1KSpTzHBDQpnzBYCvHOwZwq+XC5MfO16pIdTkVsbiYETyPdxUKK4ZQY7p2V614tiDERVa39bK59pqPU//96KVGxESuz2Mkxi9wlqJ3b861P4vW7+zgaWzJ+y58c3pdt5A1jL85s4VG6n1hHP3aK1XDJDqcG6j/1Eu6KaaUDVy0WCbZ5SrFlxbwVWggZKfLFMHX2jNWKFFUr+FObqAytJsnShxEIuea5KniKByq3LvEftBgzujaFOpH5LawUy/I/tZj1olS9seUHxipuVliJF0b9GvCohZvo94mkXuBjZE5iEXY2q9duxPQoZVpXEEjc3FsqY20XIQZo75Bk2R0x4GrsZsA4sXzS9Wq03DmwqDL7hrNyuT34NF9+c0yskomUOXgqRu0WpQ9U5S+X2Jf4WMNZWjjjhpMpeYQEDUHL0eLIsVrtkql5x4bYa5kzpD1inTFIJ1P057jIa5a23LIMqvOjx3WQ30+zc6pm0O5+pfzd+zJLQz0l73Nxr4TOmOajWfa8PRoRE9TpUAIyEiP6hvzA5ptpC1doNLftRGtK0y2P9C6jeB6Fw9sNY0J0NZyi4gQdEOJvxTzRGk07Ka76z18K/QSwBsSEKt6wqdX9mOVMmYExm8Msuvt7yfFLQN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdvU3NvZWNUWWsyWWRRL1lGNFdOZjVKWDRCMzFoYUxBZ3V0WEFOb0xlQUM5?=
 =?utf-8?B?TEx1Sld2U0FFZEkwcWhhSXZKbGh1a0RMbWorRzVjQnBqRHJhOHRVaHJqbWkx?=
 =?utf-8?B?cTBId05HWlhTeVZDOCtyT3lMb0tjMyt4bHlGM00rWEdEZ3YrMEprWXBkRWRp?=
 =?utf-8?B?b2NzbzBFM0NMQnU4OGd6MHQvQk1nUmlyTnRRV2NXQlpheHg2OURwbGpHN2I0?=
 =?utf-8?B?LzRNQVNCdHJ0S2xFcnhuM2ZkaG5NTVpJY3I1Yk11SFZWWHFxMy9LNXl3TTFw?=
 =?utf-8?B?Nnk0MWR4akU1a3RKSGVQb1BSTWx0T0dxeHZhVTdtVHY2U3d0Ly9OeTNYM2JQ?=
 =?utf-8?B?NFNOUXYza05ZSEpmZEo4K0NRK2NaRnJJdjQ2SEhHNlFqenpZOXMyaFRwY3Q0?=
 =?utf-8?B?WGkzdm1LcFdtZUdQcFMrQmdDcm9rVU1GQUpZS1pKTmVnWXRsRWJHMnJXSncr?=
 =?utf-8?B?dTFCeTNLUWRMRkNLR2YvRkFBYjY5SkQrbWl2REp6VHBWc2x0cVkweWNYK0dy?=
 =?utf-8?B?RDV1dHlBdzM2ZHBFbWN0WDV2ckZoTUdXOW50OXFtVFdNL0YvSlFJRjhyMUxz?=
 =?utf-8?B?dmFFMGl4Um5tMk1XdXMwQ3VzbkJBa284U0RnaU1WTi8rZ251L0VOR2hhR1RP?=
 =?utf-8?B?TFppa3lPNnArbjRuOGhLUldqVTZrNjJYQytxSFlSTjV0b01Td2JhUmlPdmFm?=
 =?utf-8?B?MVQyUE9abTNhUjV4UW1pL2U5djhxaTZyUkt1aEc1RGhFVE01a29NK1V3ckxE?=
 =?utf-8?B?SUtqSlBNTFYxaWQvVWVRY085YzNjWXJTUDYzY214Zzk3TlR4ZSszOVhRV0tm?=
 =?utf-8?B?MkNZZEVCMk8xWHVadzFqd1huekl5S2VUOFZ4L1ltVitHUW5SSTh2YnpCZDNQ?=
 =?utf-8?B?NnJOVVFGbk91Vm9iVG5OU3RIaDFBZ1BCVytxVmVQWFArMTZFTEczTWdWZGcw?=
 =?utf-8?B?eWlZRjc4UHJlc01ZT3hiQ0VVMlZSS1pKZ3ArQXk4eStlcWxqZzVGYWU2ODNt?=
 =?utf-8?B?RkE2dFRuc1J6d3pVUGNLUGZvc2R2ZW55eU5iZ0VaL0tKWlVuVnByS1FmN0xt?=
 =?utf-8?B?eGZ4Zkl3ZkRQemFnZ1dBbTREc3NIbkJkRHFsYXZoeVEvQlJrUTB3TnVnLzla?=
 =?utf-8?B?N0RBTE5idWxBWWhCL3FySVRaQ3lCajY0djhtMnNYYVV3cWZnWnppQUFyZjJv?=
 =?utf-8?B?WXk0ZDlEaDk1d1d0YVJPazNWUWJlTzZqRHcycUZUMVVoK0JCL0VJend6OWgw?=
 =?utf-8?B?WlpjNS84dStvdWpjS0FNNGtKRTkxc3haUGRhYnJUK2krWnlKa0JOcEpaajRj?=
 =?utf-8?B?WnduMHFpcHZlNXh2OWlkci9pU3Zna3dLQ3pnSzRkeWFtQ3BYK3NXeHA0bGJC?=
 =?utf-8?B?K084bE5vaE5nMElhRFk4WGlHWEoyUUhlOGRjKzdBaXY1RWtDamFvdkcybTMw?=
 =?utf-8?B?N2VhcGNsZnVXQW5RWGNUVjVPeVJFVDk5N3p1c1Z3L0dxTTZ4MU5Ed0N0Wk0w?=
 =?utf-8?B?WDcrOG1iMjJzdFdMRms5RENEUmROQlM1QVVaRTl3THFnYjE0UEJyeGxLSnh6?=
 =?utf-8?B?Wnd6Mk9rTWlYWG1lNXJZb1VwTEdWZlA3Vm1yTEozaG80dGVEMkRwZXMyNFRk?=
 =?utf-8?B?MDBERmpnbHJvRldnZ2xXUWVOVjBNQ3kvR1R0cWZZMGlBdTVCUSsrLzRibUhI?=
 =?utf-8?B?YytvRE5tMHI3ODFBc2U1a3g0dnVUdzBwb0lRUS9oanZjeG1FS2xYakd4ejh2?=
 =?utf-8?B?NVlKS05HVnZwUHFnRFhWSkYyWklTN2tkd1VsN2hBZnFLd2hmS3REdEdwMTJS?=
 =?utf-8?B?eEU1clZnZzZWUFV3eS9TbDd6bTg3RGozRGdpanB5alVmZFBuSW42V0x2NllQ?=
 =?utf-8?B?ZFEvVFRldTEzS1BVVkJRTWo1ZWdWakxOa0JoWnp6WEdGSGhXMGhXNndPQUla?=
 =?utf-8?B?TUt2MGFpL2hoUUppanlUZ3AyQUU3L0M0U2dZWEg0eUI2WDJFMXFKeHo1a3d1?=
 =?utf-8?B?SXlkWEQ4VzRPeVRJcHh2Mlg1VGVWSFByalZTNlpRZGMxSXVPa3l5bTlocCt4?=
 =?utf-8?B?aVpxbnEzaTJlM2J6MmlmL1dPMWFWYVBDdHlWSFU0bllrdWFCZkpaeWxHOXIw?=
 =?utf-8?B?bENER3IvTGVuNUpCZjRibE5yOGxjYlBjUFZKcTFOVTdQZXBMcmJidFFFbVhQ?=
 =?utf-8?B?cjhrSmJRVm56NTVjNC9DeHUvR21OSUhseXZkMDREajI3b2tSbWxKdktyL2t2?=
 =?utf-8?B?MGNQUEExSkxxWmRFWjEvVkRsczlXRnYyR1M4dGRZME8yUDdNaW1KYk8waHpu?=
 =?utf-8?Q?U2hq7g2YpGAGrfd5jv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f93e3ff-6f0e-4788-140e-08dec2e449fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:24:48.6467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5ExWcJEoA6gUfjFxX3sVaGOmNpj2M43n7WdHu6BcecD+gU3dD0A5GRdxKeXmmMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999139
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

On 6/3/26 21:45, Alex Deucher wrote:
> We need the fence to reemit the gds switch or spm update
> after a queue reset.
> 
> Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v9")
> Cc: timur.kristof@gmail.com
> Cc: christian.koenig@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

That was avoided because it means another entry in the EOP ring buffer which can be bad for performance.

But correctness is obviously more important, just to keep in mind when we suddenly see 1% fps decrease and don't know where it's coming from.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2f3470208829e..7e0e2281719b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -853,12 +853,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  					    job->oa_size);
>  	}
>  
> -	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
> -		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> -		fence = &job->hw_vm_fence->base;
> -		/* get a ref for the job */
> -		dma_fence_get(fence);
> -	}
> +	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> +	fence = &job->hw_vm_fence->base;
> +	/* get a ref for the job */
> +	dma_fence_get(fence);
>  
>  	if (vm_flush_needed) {
>  		mutex_lock(&id_mgr->lock);

