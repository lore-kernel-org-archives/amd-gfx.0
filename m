Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572C606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NCSAwz+X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3589C10E74C;
	Wed, 11 Nov 2026 13:15:08 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93D510E9E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 13:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN6ZEztPOsfXnxw7URhkU4MIL143H8G0BqCTgBGsmBShYYqk2eRz6hVhnjU9RYgygtNPy5GhxaH785RZTZbRSrw/WkOV/0RVD/5bdzUdivN1hPiKdktFb56mzrVWQ/4AXBkXXogpIoBZFfDD/BHyBakU5CQNh5O6NLQzP8cE+pKl3ioJN6WNUKdzVyFFXIm0lcXvhbSO+cnjIML3ci05G4r2wTCFHjxhIMmLnAIejL4dfJ+/ajc3dOPAVIy8FbsWhC7ns3Ic26PHFIRbUdXkDH9gSzDaoi8Qzrqoc9Xq+8F7rvphnY9UPewiQmIK+SjtmdHEV/9asmHD7q9D2hHQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsapFNi9QErA63lwHDxG38cAahNyfp7HXRfKreyB33g=;
 b=biJWruGrUX1PYgrCQepd6lG6pnd97lzeadXs1ZU6Jh+Bd+eS/4iTLEKOJTNvK75MBGnWMjJ8dvt2QQgyWA6nq1qwpuoHMHc/qiFM/1K/uJgngNv3Ew6XQ7dz1V619z+lg/fpywDivKTmxa29X09TKmoj5BN6TdXzp3JE2gCllQORPpzZ19Zxe1e1jCSCh9obmaxQo7KV2bIcFuJ/3bdl9DpF9mQTuvYZWak/1k+z2vaFPjgUcI6EuWHbn3D/leXGx32l0/zQK+s8jqv2knSfy+vlt3KeOw1dvTtm46d9/7ysLXrpY3YVmT9TrUYUPOw/QSRvUDOboTCFvKe+WpWNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsapFNi9QErA63lwHDxG38cAahNyfp7HXRfKreyB33g=;
 b=NCSAwz+XZ8cM48ZtG2Mw+vgEeaEs6pfjy5le7WFHCdUmeK/un8EMUDZgzA9ydujBU+4wA5RE/8s/ZsJkcytpXp+hWR2JkvIahfD/qSDz+RprI8Z3LDGaMOOVfEMV4L82XQ7q/8ovpVzFTwu1+2iO9Y7txD50tv73W5Nhnkq6PG4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS8PR12MB899436.namprd12.prod.outlook.com (2603:10b6:8:446::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:14:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:14:59 +0000
Message-ID: <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
Date: Wed, 11 Nov 2026 14:14:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/6] drm/amdgpu: wait for page-table moves in CPU
 prepare
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:208:23e::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS8PR12MB899436:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f6b3af-6e30-4019-62ed-08df3ff5c9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +CUiYJKjQWnWL+LFTjEXIunkbX8NFmM4Jp23ErJlYYjBBpf8fHjOvFIQSXfBSiOPlSyu+450V0W68sFnHIXsDdeucdWh7xlTmr/jB75o/2jr4Ogu8eTpKEBM7hcf/xdM9fr0wtTjCuZb38iGAWvykN1RnKCXs9vKPQbrq+eQnnDu1u14T0Dpd2SPFcjfQdvn6GqUk8W4V8lC3UTA68+7Aidz76OZ89wrdkXmbuEZMZ0dakFrALvw08zyKLql6L498Sej7d4m2AUEL9RwpaWDN7kNxXF8t443ocEhf0hETPCpXAVXgKyu1QppXN4clQNR9rd+8bABMhgSmKAey1n5S+nfOZN+aU06RqRVIsbx7+RY2g9HKeMyi3RjLzA7ADJbo+8Ci62iKRPLr78wczvIBDzkEQTzO6aMG0Pl3V4sV/GGFuOxeYXpiEfVVWCML90/67fgbciwwgezXziYPIy/vs+sHjCksyEsQzUvypnJNdbaPeha3w/PDevit/WIIEU/9gfVE6EXGqwBpquJjJkA+smFn8mSrc42mrS9D2U9dUBhYEbb4xhPazJ+Q+1ql89QOEgrhsadeX7VZmv6TWdw9/i09WqfFkI1qK+JRB3GeLiUeEVEoDj8BCNycPTv2oCN/7VOfl9mh038SvJgCGdROSBmvm+/v+SK3fG2EaYg4TI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0h3SjBpQUNZK2xGaGVTaFp4YmpWVkRuU3EyWldMa0t1SVE2MGsvcU1RQXF0?=
 =?utf-8?B?NkVIck5yc3lJU2dMZWpjUGVnejNIQ0l6NFZVT0VPYjZaSDlGakczZk1rZnJ3?=
 =?utf-8?B?K3Fsd044NnpEZW54OWdaRDV2T1crazBVWDBnZ1ZpMEhJTzFiSDJoYVZUNVcx?=
 =?utf-8?B?bzRPWDVwYitwZ0dZa080N1dqZGJUdE1wbzNkVVVpUW9WQ1VCZjJmOEVsb3VZ?=
 =?utf-8?B?VnVqcHVGTm1ycXhMSWgyMy9SK1hJL1VhOHgrZ1ZSN0hGbTlkODRDNVJoSlhQ?=
 =?utf-8?B?am1leEVBYldOZ2ZPZHZvRmNKMFljN2NSZXBQdk1FeHpuMUhibmZIOVVlQnVL?=
 =?utf-8?B?R1VzTVdOL25UZnFpck94VFArVkhMTzV4YVNrUWtNNDJZcW85aC84WmJudjVX?=
 =?utf-8?B?ZHFEbEtUOVpVdHNKUzJxaU1qMEl4MDdUZ2k4VnA0dlpNV3pwS3AyeEFzM3Ez?=
 =?utf-8?B?TzNvcXFyLzY5OVZpK3E2aFdHQmp3a1JPZXJLNm9zUDJGYjEzcEwrR3R4ZlhV?=
 =?utf-8?B?Q3NEWlJEbmxQVXp3N0xzWnNtcE1jSXhZOXNWcXJWeitFaE93cWI3cTVUWGJE?=
 =?utf-8?B?NjRuejYrZHZRVlhJZ2xVSUdrVCtCQjNzTS9kY1NzK1V6WjduSDB2K2VBSG1D?=
 =?utf-8?B?bkJTRDFnZzVZRllBbUZsaXN4YXAySDBYQm54WmpVLzFJTmtPTjRzV2pKeUU2?=
 =?utf-8?B?ZnorT2N4b1UwMnRPZnpFTE1vQkM1RGRyelpjZUVwQ2REdHQ1bU5ZZC9vbHRz?=
 =?utf-8?B?aXRCaWs5czJ5RTZJSS9xOEltNlMxM3Y5VWxnbGxKRGhIUVBPa0hlODN5T000?=
 =?utf-8?B?SVZGZWlaQ25QUkxWZUtzVWVic0hHLzljd2tpOWhKZ1B6aXJLVHRrSHdjUVV4?=
 =?utf-8?B?emZOT2xTZ2dnZFVPMnZzbEowWE05SUxuZVR4cnVEVU5yYmtNY3hrblJHN01m?=
 =?utf-8?B?dDcraEhmdyszYlVjb2MrSTVoNmg1U0dBV0FnWEtYQWNGZGpTUTJsR3ZSb0g5?=
 =?utf-8?B?Yi9jcy92NGV2SWdGOExEbGpOQXE4aUtEbTJLVnFycUk0TnE5VS8yZkk4aldF?=
 =?utf-8?B?d2xQVmMxL2NjRCtyM3ByaXdSRVRYZkNFa2FLazljdVRUNWJNeVJnSnEwanA0?=
 =?utf-8?B?NjR3WUU2OUdjdFViRzZJN1h4TkdiM2pKT2FLVUVSMm9zODdyVHdJS01tZmh4?=
 =?utf-8?B?aFdsVmdOS1pDVkFtUmJlK0tJVGV1eGh0clEvSzBiL1dPSEE4VmdrZVlLYXFp?=
 =?utf-8?B?Z1N3UlBnWEFpUUVJZWNIcG9xYy9JTUJYOENtb3U0U2JxdCtENUF5YXZlU0xz?=
 =?utf-8?B?TU45UFUwZG9ZdDhNclhHdDRhbHQ0Wk1hREhud3ZxR3pLRWRDNlJLMCs4Y1Q3?=
 =?utf-8?B?RmsxOGJzR1A0OUdKVjFUY0JNMHR4M05jay9NMFdzN0ltc3h4NFUxYW03SFRB?=
 =?utf-8?B?eE42ZUlGb21ySWF6UkxOTG94azE4SjJDVWc0TDZkZU9rcXg0djBnYkdBS1Js?=
 =?utf-8?B?UmQrczhzOWo4eHQ4Sm43YmtZa0dSK3BvK2pHSVp4WkJ0RDhiN2w1S1pzUXFV?=
 =?utf-8?B?UGs4bTljWkNBd1cvQ2ExckFuWE5IVE5HUzJQY1NlQVRCNEtsNGFhbVNiUStV?=
 =?utf-8?B?VEwyTXZsV1RnaFBFMUk0dVJPQ0gvQWhSN2dzR0dQYWxja3Zla3hwOG1iaUxL?=
 =?utf-8?B?ODR1Ty80dDlZSUtUQTBuMkcrRHFTK2diRUREUUN3TlFrbFdCVzNQcWZPc2Z3?=
 =?utf-8?B?U3JGbFZBMnkyV2M1VU1VTWEyZHB2eGFSeEd0UTl4SXZtUTBNY08yZm4yRFA2?=
 =?utf-8?B?MlJyVFYybTZQRFhEOTdrczhiYzMvbXFKcDBXYVRJNGk0MzcxS2wvVzA2UWVK?=
 =?utf-8?B?V2pZZVgyUDB2aWd0eXZmK09vV3plVXc0NFJnaDkyOTJ4T0dZbHZOWUpOSzZD?=
 =?utf-8?B?dG1hNG5ET2RyOHNYWllTVTlGRkZ6VHp2Q21NTjVZRjI5QVI1dmhnWVE4SlVP?=
 =?utf-8?B?ZkUyWTRxaFp3eGg4UVhwVDdwWXp0M0hhbHNkYlhaY1lIdERyNUJOK044b0VL?=
 =?utf-8?B?cVBzcy9UK2lZUFN3a1RKY3ZVWTVMMVRzVUZERDJaN3M5MVNsNFJuSkZza25R?=
 =?utf-8?B?dm5kMi83bm9qRDEwaHRNaC8vK0hpTDgzd0orUFBheDNORForT014R1RCNlc4?=
 =?utf-8?B?VjE3ckFNbUJLQ1ZXSDJld3Y5WmNvWjQ3bTJLZXYzWnA4TGV5dTJPWVl2SlB1?=
 =?utf-8?B?bTU1MVdyWmVsWVBIUS9qUlNvRGhvUEFqN2dxODRsdytkb3YwRjU1aHJvMXBs?=
 =?utf-8?Q?jx11yE2tzuW52y7Jf/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f6b3af-6e30-4019-62ed-08df3ff5c9a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:14:59.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84ZunLiSOMBwy5LiK8BeqBFbqxfcIhLXjayVzeHAiRbnV35+rcqcSQus8e//woZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB899436
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 12:56, Mu, Zihao wrote:
> From: Zihao Mu <zmu@amd.com>
> 
> The CPU backend repeats reservation traversal for every PTE batch. An
> interrupted wait can also skip a batch whose result the walker ignores.

That irrelevant.

> Wait for the shared root reservation's KERNEL dependencies in prepare,
> including calls without an explicit sync. Allocation now commits and
> restarts the phase, so dependencies added while the eviction lock was
> dropped are covered before the resumed phase writes entries.
> 
> Preserve the existing interruptible wait policy.

Clear NAK to that. As said before unmap operations triggered by MMU notifiers *must* complete and can't be interrupted.

We could add an interruptible flag to the update paramaters but that is most likely overkill.

> An interruption now
> fails prepare before that phase writes any entries, while prior phases
> have been committed and receive normal partial-range finalization.
> Keep explicit sync handling and the CPU write/flags/commit tail intact.
> 
> The update callback now only writes entries and returns zero through
> the existing interface. This does not claim that all VM preparation or
> SDMA allocation operations have become non-failing.
> 
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index d03b9bbe20c..89e76e18d9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -52,10 +52,19 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
>  				 struct amdgpu_sync *sync,
>  				 u64 k_job_id)
>  {
> -	if (!sync)
> -		return 0;
> +	struct dma_resv *resv = p->vm->root.bo->tbo.base.resv;
> +	long r;
> +
> +	if (sync) {
> +		r = amdgpu_sync_wait(sync, true);
> +		if (r)
> +			return r;
> +	}
>  
> -	return amdgpu_sync_wait(sync, true);
> +	/* Allocation restarts prepare before any further page-table writes. */
> +	r = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_KERNEL,
> +				  true, MAX_SCHEDULE_TIMEOUT);
> +	return r < 0 ? r : 0;

That check is unnecessary, MAX_SCHEDULE_TIMEOUT blocks forever.

Regards,
Christian.

>  }
>  
>  /**
> @@ -78,12 +87,6 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  {
>  	unsigned int i;
>  	uint64_t value;
> -	long r;
> -
> -	r = dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL,
> -				  true, MAX_SCHEDULE_TIMEOUT);
> -	if (r < 0)
> -		return r;
>  
>  	pe += (unsigned long)amdgpu_bo_kptr(&vmbo->bo);
>  

