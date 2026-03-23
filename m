Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C95EC01B6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC47010E49C;
	Mon, 23 Mar 2026 09:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFcaMe1L";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010048.outbound.protection.outlook.com
 [52.101.193.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF36E10E49C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sco6gOvdtFFicPLHlmrBnQqCNbZ1INT5/+rYkTxw8jtgDYZQb0HObHtR3PUso09iWt7RVtKU0PDMf0uiRa/iUVFeLo8kqnQHNKB+5PNILUzdzqFEXwe7ypbgP/ArUIu6GS/fOJKJkXv8e1iaM5hBDbH9A1ktECZI74Rbeyb4/Kf1+TmVq2xDPtYlljBF+4GRbvve7XHFRBlpLlLzgtjo9BUxQ4t1kSe7JUiJFuOkbngy1Kcb2CpJBcTpVYSEcH5K8tnPMbtaGHAV7li9QnP2nxkuCQE74S07x3oa1mt3utEyLeKfbVAwba0p80rKvJWZJxVH/hXJ4qIbN2mXHyPoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSea44m753W/ELc5Doi3YaadiN6+tNoUygpInMEfw+A=;
 b=JDXLIZ1nwtrfF/STq1//y4uVFsuEw04Ljl6XmSCmDDPLYG7lgrystdf2o14cRxyOt+iIMgiKPnCUR+rD50/A9seH+GWR2dOzsEkDIcVfg3ZJKepFd740GIPh/d8lQYDDAob7N0lJMzfXnAaGYMff2PyqJabNCLGUqvXDI9todWEaVIDDajDLEM3MqzkFNNk8C4pyzvORY62Nhk17r5MbpidKZp6gGfwv86SDsNyuPfivXwCdBLkw+YCUnL7PwfNiRiG2uPqi50AA1tL2qHIdL0rlyEq+Idj4xZ98hQT/FZUu/AuBLXiJTh4D3ql6dcL4gzX+U6iDIwKHDwXLF/sAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSea44m753W/ELc5Doi3YaadiN6+tNoUygpInMEfw+A=;
 b=AFcaMe1Lhb033Vfv/gblMHabAStPvnvpwCjn7pBR17hucdYqyQ7XYIJELNPlUy+RoPpMMWQrPtD8NCvWhdhMjYs+qb7rYMnGwtlV96bEC41WXIV+9EymxTl2eZirTLzsQ0WNBky5fD7mMhEFu+Ge8ymWVPhN+TzLzqEjpraNbec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:52:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:52:26 +0000
Message-ID: <7ba48988-cd36-400c-93fa-eb15062a86bd@amd.com>
Date: Mon, 23 Mar 2026 10:52:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix fence put before wait in
 amdgpu_amdkfd_submit_ib
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260323081808.2046632-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323081808.2046632-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa8d383-5a75-4d5c-4559-08de88c1e3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: LvL9pY+P27TN1NGvLhxyO19kFDC5O2kfyB0PYQH65l4H/CNzjWiBMAcLvp4xUSYWMsbIElgDE0gCASfVpEK75z9YjRn1whuQNQ3blN350WcbD8hAia25tszBKjPs6bfl3I08zvQcPJ6GJ2pbIxW23CcZ2Kg5xdr5HEiOy2gNdQ4IESvBa4HhIC2k+QgAFm9ieoNtzrbOlnjCqK/eMoIgVg2NMuopK4gEMWwaCUBDaFBcsfwWzFz5hRS21rZTUUOtX+T6l9k8+njilpTwmMXAEGfys7VNQd/uvcFUH/Df+2ptGa9PpbCeGveejjq1iY9QrhgFMhbEpoxpyXkHsUQtzX2qttEwXSOlSvRrDD62MAydK5hR21/DZjoxWM9HwbPy0nTGEs2NVfhEyB9Xw/pT6X9mNNWN6dJlHPYN1d7FyrraNE6YvSRJIbCDnIVzGa73RJ7a/5YHcVacYgwqUR2gAd8/Es+npEkgt+/h+LANXjkifasILZrT+BwqPH3RKWvQkPmnsGSTwN9lEd8wLa6LlHfmPxun6vTMTH4eqqR1GVIGYWZodVVniKMbycZdJY+++RhD4I3JEqNbjlnbeAW4EmeaKDxi9kHBo/fDPsn0C57nt0Pk/3HrJX1GvK7IqEO0DSFApR1G6WEY7+J+sT52VLPXkYRK9aGTXf+gymvXaeUzujtUwF15NTXmyEwC+uQ8FORPJWadNc9LULBZRr0BgxtHFytyUmKFekYCGtsf5uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFaTnF4bFBpdGw2UjJpZzZwK3RKTFFaTTJRTnFYQm9ITGZldUJtN0hLR3da?=
 =?utf-8?B?Z2hBSkcwNzduK28zR3BlTkNPQnZQL3FQbHRpNEZOTFR1SENKRTBvZ29YdVVR?=
 =?utf-8?B?dTZ6WGtxR3FwU2hrM0FaU1ZtOUo5RlFKTUVJWW1oQW9VM2h1Z3lPeHlpWUh1?=
 =?utf-8?B?aFptemxOa2wwNlZPMytoSjlvM3FDUGE3dGR0VW1pSSsyUWFFTENpTUwrWmw3?=
 =?utf-8?B?azZMdkc3N0E1TU4vaW0vMklUbCt1RXZpcU1XNGJpakpPYVNKVDFVOXMvLzVU?=
 =?utf-8?B?RVZ4L2Z2V2hLaWl1RzhpeEsvMGZzVE5idUIzSWpVbmlrRWhwUVp0SVFTUlU3?=
 =?utf-8?B?SzNvQURFSUlXVXcveno2MytDenlQWk4va3hHSm5hMjZiakxoNzF6N09VeDE1?=
 =?utf-8?B?VVZrLzNmSHhldGNOVm1rVnFRek5zUnJpQzFEV1hRNnczRHA3RWpSZHJnUjJu?=
 =?utf-8?B?eHZxWk16Ymt2VWZ0MGh2VVRCSmc1clkyU21YWWFaN1VuREZRWVl1WHgrQ2Vr?=
 =?utf-8?B?dm1ycmM1dXhzanNJYSswL1crWlFPaWxoWkwzenZ4V2h5bXNiSlpnVURKUkVk?=
 =?utf-8?B?YmxlcXhlcEpJK3NBbUhJN1lJZVNHczhweDM0bVUwcVlmTC8rTnl2M1BxdGd5?=
 =?utf-8?B?aWt1R3VMNXltcjUyYmRFTW1CaGt0WmlhdXM4Y0IzeE45QkUzbjFwRCtSb3lu?=
 =?utf-8?B?YnJxTDg0dk93WjBiWDQ0MTlZdXYyNHBObTRQblh5V3l0TGlRNXljbnBWWTA3?=
 =?utf-8?B?Q0pFK29scW1YZm5YZTh1MVJENnJuQi9seTBDOXFaVGQrcUg5TFZ1MUY0WDdI?=
 =?utf-8?B?aXRaN3phdnRFK1UrSTFBdFdReVA5UEtNSDY3LzU3OEdqd1UzTVdBdlBKSHFm?=
 =?utf-8?B?Uk1PUWVuWFdobzIzaTQ2ZVdWWVd5T1NzR3owcllVZUZBb2dGaVMyQ2hIOU1t?=
 =?utf-8?B?aEV6MjFSdmNOL2VLU0Nsb1ZVRUgydnpoV3VRWDRHOHRZd0dwa09Eczcwbk5n?=
 =?utf-8?B?UEJRKy81VXhYOUlpWXNLUmd4dzNOcjRjUTRIc2t5eWlkQkRpNnczdUJSOXA2?=
 =?utf-8?B?UCt2SG5HMnpuekZJTG1JQzE0djNLaE1CbS8xeksxVjlOK3ZIRDNjNWpHUUhM?=
 =?utf-8?B?Z1Z4QjJhS25RQzkzMFdiWlh1cXh0OE1QbzYwYmdYRm1HenVMczVDSDJHeTVw?=
 =?utf-8?B?MXl4RmQybGFVNXFGK0M0SU5ZcFVDaXNqc3dFbytGeldrQWtDR1VuTy9QM2F1?=
 =?utf-8?B?dE5QdjFIUlBjWFk0TnoyNlpFOW9hbjllVzRtKzg5bkNnOTdVOEIyRkZsMGxl?=
 =?utf-8?B?d2VtS0YzSFFwS243czhyNlRhT05ObzVqZEtGMlNrc3htWEN6T0FHTXF3YWNR?=
 =?utf-8?B?eW44RWZKVXpnMG9aYjB0RGVERE5pZXUxWmVTWGNXaEd4dWR0UThDS2ppbDFG?=
 =?utf-8?B?ZHlhdUhsdHF2aVpJYVlNV1NSM3BFd0hqdWdXL1VlYUhxMFR4MkVNdmo0M28z?=
 =?utf-8?B?TzVSaU5XNVFYaWVOTHlDc0U4ZHd5RHY1WWcrRi96UWNLTWNNZWdFeGZFVFZ3?=
 =?utf-8?B?eVhqWWJJRjZrdGloWk5zK3dmdmdMWUtENk83c3ZXM3lpa1M3T3V3N3dGWXM4?=
 =?utf-8?B?Yk51UVZPY1F5bGU4cm0vYlpvKy81ZUl2NW1Db25LSDJ2Vk9uNmMzUUpjRjBS?=
 =?utf-8?B?VkowNk9NVUtzRU5ucmZBZ2VTYUYwN0pDR2JHSUVRLzJzN1AwSkNwSlJrN0dI?=
 =?utf-8?B?K0NMSUZpR0RkVmpOMGJtb0ZISytER2poU2pFZGJiWDMxbUlnNlpTbEpQQXQv?=
 =?utf-8?B?U2JHc1kxTHd4cmtMRzhRVmcyZW5rRFhXRnJIRmtUSkZJeFNjNERjZklnRnB2?=
 =?utf-8?B?L0dnWWMvSUtwZG0zR1MvcDc3RHg0VEg4MXUvYzNtVGsxMWpKUVZ4YW0vZzRC?=
 =?utf-8?B?bXhaYjZaN21HRUFza2dWSDdMaWUxdzB5am43elhlaWFwcFpkMy9hSnBNNHpP?=
 =?utf-8?B?bkJaUEVzWUYrbXJRSG5jc0JxNjdrMjRVODVYMkZoUW5zSzA1NUlWL0Z6M3dn?=
 =?utf-8?B?RjE4aUJpam85UmdUa1Zpcnpvbm1zdmhKQmNYUTNxSkVPalA1Mk5scXBSazJD?=
 =?utf-8?B?L2MwNThxSTRScVlRa0p6NG16THBWNVdNSEN5SHl5WHBiUlpuQTlQWGw3MWZj?=
 =?utf-8?B?SzgvQlVQYXpWN1Z5WXBnZjJiVk84am10Q1VoUXFxRzZxMUxBOGFkOVlQcFJy?=
 =?utf-8?B?bS9RdkJmUnRRcXJ1SEtWc3hzdmwwZ28vQjhSbzZJZlNPZGhTWUxLWVdENzJW?=
 =?utf-8?Q?/GCvYE7sr1lKzviU6K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa8d383-5a75-4d5c-4559-08de88c1e3ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:52:26.8356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyQs3YQfMvM6u2ZAtI/5JEZsSgY8nSaqmhq8yvDMzPptNRMaRj/Nsd7Oz8nuB32H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

On 3/23/26 09:18, Srinivasan Shanmugam wrote:
> amdgpu_amdkfd_submit_ib() submits a GPU job and gets a fence
> from amdgpu_ib_schedule(). This fence is used to wait for job
> completion.
> 
> Currently, the code drops the fence reference using dma_fence_put()
> before calling dma_fence_wait().
> 
> If dma_fence_put() releases the last reference, the fence may be
> freed before dma_fence_wait() is called. This can lead to a
> use-after-free.
> 
> Fix this by waiting on the fence first and releasing the reference
> only after dma_fence_wait() completes.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:697 amdgpu_amdkfd_submit_ib() warn: passing freed memory 'f' (line 696)
> 
> Fixes: 9ae55f030dc52 ("drm/amdgpu: Follow up change to previous drm scheduler change.")
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3bfd79c89df3..cf6b8581c969 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -692,9 +692,9 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
>  		goto err_ib_sched;
>  	}
>  
> -	/* Drop the initial kref_init count (see drm_sched_main as example) */
> -	dma_fence_put(f);
>  	ret = dma_fence_wait(f, false);
> +	/* Drop the returned fence reference after the wait completes */
> +	dma_fence_put(f);
>  
>  err_ib_sched:
>  	amdgpu_job_free(job);

