Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F969F54AD0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 15:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F80F10E716;
	Tue, 24 Mar 2026 15:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8Ouwapw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C7210E716
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 15:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYeKNxy1fhst/DHjp7B0QsRJQ3m/X5gX0v468kmE3yOxeeZCK8svKZGmtjEBH0hbB6Tv3x97fArAbOzFVCaJPaRTqGCyx1etOpqIazhmI+yJLFer+eGPmkg6DvEC1xu9BeuDa8HWG60EgSKOOyQVIYbCy9UpZ9UUF5OzXBBiyK3fwULNiYnv3OEn57aDl7lZBadd2oEZ8fukZITnKX3TpqRKGkD3+qbdfGkSo9NUgd5Sdajug8Y0yVSDYMyb5ypijWOmwtMlRw+X/dRuaLFeOSkirhIs9X0GydVOeOWJmt5MiN67LzbwTywJp7tEE9u9sWKKlU8Wo+quUXABuKv4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlH57Tn23vYMk7K+qe/PnROVASb4QBnGCCDY5udnwH4=;
 b=A8BpQ6jPlrFrFGUiP6wWHcg+yywh4Yd4/qqe31HyAVq4aBHLNAoPMqtqNpncclIeggR8H9SLxk9JsDFRv40y0iuC/fyP+PcVnl27PEGrDEU1izalNQ++86qpb4Lx0W7OzO7B8dt9FcOA4KTFqtiBmY3W9wVVufXG5qgc/C4AooEU0gCqF+VNvveu2aAMrXOpCsPI4rslPVnHPkLMae/t708ACfEFbPqW5xborIfwY3k3hK0Qz8FVKiqYoVzKG2A48MmrlekmHs6TxMqL1OEdsvpAzGnX0l6/ReFDxzLbEoTqZwnDGo9TWZRJDEfr0muTwLXAV7kMKB449TxZjL8DvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlH57Tn23vYMk7K+qe/PnROVASb4QBnGCCDY5udnwH4=;
 b=f8OuwapwO8oNBRwqZydOljZfa/z6ilLHJoPQ9GuMIaVMbUJJS6pfBAf0lPUqIj6/pBTAoz/9efVrx9796kUaZoMGhS7f4XD53fcg93aTYDp3uwOD7GzFPOA68SVinG+c3iIVKdHPg856VkFIV4eEjiNi/JmVyKbUDE/OvhBunMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:33:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 15:33:43 +0000
Message-ID: <ae7e0955-706f-477e-a1a7-5cd97b9c79e2@amd.com>
Date: Tue, 24 Mar 2026 16:33:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: amdgpu_userq_vm_validate does
 not need userq mutex
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260324152514.1419906-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324152514.1419906-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dcca42-1130-4685-472a-08de89babb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: w/Vls8wCuwibLhh93H0DVrNslE7y2kx8KmEe4U5De3myf8upki+OYNrXvaUR4/Bdc5V6Y++rc8H5AORRBmM5Y9QgLdkM/xUEP4QQc3OIqyN+zIlSr7pE27sjl0gdQ/7VKtlord/+ht5OTSlTATVYy1AITMN2M8kRBtW9ex1nJ1iWDqNRUh7gmZJmd4Bbkm5haXUK9ZZMSW9hbAP377JQPLxhoQ3oeFIFL6CP67L44/a50IRe39q/ciNaAr2AsH7eijwisMRrUVZGf9gSATPOqam9MmUl0y/AcagLxiqKBknL4BJdoXs0XZAiA44fvqzT2VXgl8zNF9WLkog3Rw3NFfUkSrIQa1uAsJTbjToR8pnZLdQJj7Q3zTJz0flLRH3MH+1R89rDMu0Lg6RvzSikBuqWfQUmbtu4aMj7yQm4SHrD61yvRQgG0rPyiGahBbeLPHTyqcNmez1sNsK4vlEIPrFzvRxej3OFrr1gNFzvjgWapRDO3XG3ygfGTfuGSn5qI81kNE915lS+bDuzRViuEagx/8rrgjdN/Nlh9xjh3qqZn32LoPmvpTEncfGPdV1nR9ZQ/Enyhv1TvU8WpN6V9j4+e6TWgVToOnCLHPG0Q/lFdOzAuWYFJpTKKl9TrgKnCMU1/0GZmhLak78LcQyB97xFn0WBN5EsWAjPZHa5tn2FIjR5vTHpagi2tqGtYsUfX0HO6ukmR0KTPB7Rzt5lYvkwaf6DwCUUvgZlflF8Ycg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZzVkhqQ1l6dkpaaW9BeFJybmZKWitxWVNmVkVOaFRTVmMvM2VoT01vVWY3?=
 =?utf-8?B?NFRSRzN1RG9rT0lsL2RVZDFoNmkxMVRHYjhMZmVXalV0ZS9YZzdhclNPN3Fk?=
 =?utf-8?B?Ny85dVJmeUVJSkZxdUkxV0xVNll3VW9hWlg2ZVVSTHZjNjRzc05neHIwNFVi?=
 =?utf-8?B?VzFWeUZLYkZTZXJiTkVrdFBWTVZQZmJuSlFlK0hLSnRKUWxLZEsvYVFkWDE5?=
 =?utf-8?B?VEc5ekYyUUd4UW5VNVNjMkdtOXgxQUJjb1ZJd3QwSjFBdWc4NVhjWllGWG5K?=
 =?utf-8?B?ZTByd2ZzQ0YwMjRRVWM0WTVLSGFpNzFEQURFYnYvNDNlVTl4dkE3UFlmaUZ3?=
 =?utf-8?B?Z2R4Y2V5SEVJL3Z2RkZYdUR1bGFjSXpRZzEraWp5bEVkY2J4d1JzOHlsb1Mx?=
 =?utf-8?B?bHpsK1hSZno3WW5JQzU3RVR0cDJ6VlFWKzJqWUFRNjd5QVRGTWJUUFVqcCto?=
 =?utf-8?B?WGpENjZVeGlManhkS1UyaVJsNjY0QkVqU3V6dmVON09mMkFXM0RRNldWTnh2?=
 =?utf-8?B?OWlidDltL01Pd1lUTXhPSVQ1aEdIc1NyWUxtQkhadlV2UU9Wb0NWSS8vczQv?=
 =?utf-8?B?SWp2YXNudWgzbVFRcWNxUXBJdDAvQU92ODNvRG9NQkpneVB1WDQ2MmEyQ0VN?=
 =?utf-8?B?K2Z6ZkRrajVMRCtrZENXSzh3bldGOEszaDU2WGZoSS9qaUlhM0N0REZ2UEVm?=
 =?utf-8?B?NVlRQW5jbUNnT0orQ1hVSC9mMWFvOFVFeDRrTkpkcEo2SHVueUhKZ0ErNm50?=
 =?utf-8?B?NHFXQWFoTDhMSjhRRkZuZUljdXArcHR3ejZNK2tmU2hDOTFlNFlUWWEzN2Fr?=
 =?utf-8?B?YS9ZNUZESjJ4RGJveG0xOUtSUW11R3Vycy9XQlFNTlRkelVmVGhJaGhpZ2xh?=
 =?utf-8?B?MFVGWndIUHZ0TTExMTVjVUJCS0FjVXhLUEpHVWRQeitZaGdYWkdOL05UNk9F?=
 =?utf-8?B?VzE5RXY5VWVoNDByc2VWS3dsZSt5UHFDWEpIeXNmY3NpKzg2R000cmRmSFdF?=
 =?utf-8?B?b3k2bWxpZjNSc1o3YXM0ajQxTlY3enp4TWJQY0xNby9XRUVueDJNU0NhRld1?=
 =?utf-8?B?NEo0SzZrMDYyQUt4bXJQai9zZno5c1pRMWRhNlhGaUJzTFdrUDhFMnhleDk0?=
 =?utf-8?B?VEVZL3FNdFhSWldHUyt0Tm1NMW40dWlJcTRJQ0hjS2FMSXZITmI0eDlIZGZD?=
 =?utf-8?B?ZXgrME9WUitEUVd0ZTFVTEs0clZsRE13RStHSEtkUzlEa05Pb01RNHl6akdu?=
 =?utf-8?B?eERON01aQnI4ZVZFTm56YTVXU2dpMlJxTm93c2JMUHNjdlRoTS9NVkhrbGY4?=
 =?utf-8?B?em0zWjBTWlFpRnM1K3kyaTdHRzdFY1diNFJGeVJyb21JUU5Gd2laZDZQYzYy?=
 =?utf-8?B?MGJiTzBoWWY4ZzN6SUszK2J3MlNyNVlWaGtXZnZ5djZhK1hWandWbGlmV2tI?=
 =?utf-8?B?ejk0VExUOUpDaGtBekRDTEZSWXJDL1VXMXkyVVV5TUtBQzJOMHNGWEYvT3pS?=
 =?utf-8?B?WEUzcGdLaDd4TTVzNGRUNngyNk9udHhQUGFPWVRDREF1SThKL3M4TXRvTWdl?=
 =?utf-8?B?QzR3TGt3S2MwL0FHYmlXYkQwemE3aDZwU1hMSlRzN1dIY0hZMFAzaWtlaGs2?=
 =?utf-8?B?WWRUakhubGZDdUFmVXJsMXF2c2JIWE5YTUJTK050eGVQMVlBekEvZ1hPamRI?=
 =?utf-8?B?cVVjTXFNMnE3aHZqMzlLM1RsVlFxZGxOeWE0NVFWTWdHZTFpUkFkTm8rL2Yv?=
 =?utf-8?B?cWxBM0R3ckNEYkJFdDRvcjgxM0dVdFpEckVuenhNdUduQ3FtanhMUDhBVzJt?=
 =?utf-8?B?OGVVRWsza1Bhb01ValVrQ2RaaUFiTGFJNHg2VkZFNnQ4UlpsYXZzbWV0UWpB?=
 =?utf-8?B?TUVCWmRYbG5hb2xDRjczdERMQkxkbCtoci8zbVdNWEcyQ05NMzBiODBGZ1NU?=
 =?utf-8?B?ZlJJNnpGTGg1MDJuck82WjlkK1UyZm1KemhOd2NFU002Y0lZSmozMkx3Rmp3?=
 =?utf-8?B?UEI0OWRIcmRGZDVObnhhUVFYcTdHcEkwajIxTEdKRUFqczVMVVRhcTVlUHcr?=
 =?utf-8?B?Nm9pOVVRNmEvZldKQ2ZpL3FlWERFZm9XU3dQcTBKUTYvNTlweHhvNy9jZkpG?=
 =?utf-8?B?MVBFbk42Vm93YS9SVkFYeGxXQ2VTN01hcStNUjAvaHloTVdOTnRQQzA4WURM?=
 =?utf-8?B?blhjOG1uYXhuTkxKUTdQSXpCOUIzZTBUTmJFWU1uR2VMMW80Q3ZuRXd3QmlJ?=
 =?utf-8?B?dDA1T1FSaENYQXJZNHVGU1ZuU1RZcU9kZy94WWZXWWdnWXBXWGtNOHE0d2s2?=
 =?utf-8?Q?g0+5RnTfa9AMmKPc4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dcca42-1130-4685-472a-08de89babb6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:33:43.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6TfK5F0Pg55KxjAdUEbe72og/AN0nK4Fykqh7fqY6I1qwYnGeY2srCfIRJ+0doy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

On 3/24/26 16:25, Sunil Khatri wrote:
> amdgpu_userq_vm_validate function does not need userq_mutex and exec
> lock is good enough to locking all bos and updating the eviction fence.
> 
> Also since we only need userq_mutex for amdgpu_userq_restore_all
> so move the locks in the function itself.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a351383b432b..85c6a2256c4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -997,6 +997,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  	unsigned long queue_id;
>  	int ret = 0, r;
>  
> +	mutex_lock(&uq_mgr->userq_mutex);
>  	/* Resume all the queues for this process */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  
> @@ -1012,6 +1013,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  			ret = r;
>  
>  	}
> +	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	if (ret)
>  		drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
> @@ -1215,23 +1217,21 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  	struct dma_fence *ev_fence;
>  	int ret;
>  
> -	mutex_lock(&uq_mgr->userq_mutex);
>  	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>  	if (!dma_fence_is_signaled(ev_fence))
> -		goto unlock;
> +		goto put_fence;
>  
>  	ret = amdgpu_userq_vm_validate(uq_mgr);
>  	if (ret) {
>  		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
> -		goto unlock;
> +		goto put_fence;
>  	}
>  
>  	ret = amdgpu_userq_restore_all(uq_mgr);
>  	if (ret)
>  		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
>  
> -unlock:
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +put_fence:
>  	dma_fence_put(ev_fence);
>  }
>  

