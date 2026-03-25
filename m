Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0DF103A99E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 02:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1B610E68D;
	Wed, 25 Mar 2026 02:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEEb6Ip2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5001510E68D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 02:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX6gXXt6RwatdyRMxKDi4/7i7ahYzktAeh6g7/T2Rpjs/+IPpYuWb14HhO9FrZyw0Tk7IzijLQKvBwdnZsk34lp7Lv6TrmEibluWOzPw1VMKSL6YzF4nJo5gVi6BO/PEOAXbNUT/EGZ7lqOOPNo7HijUPfDYkPjqJELyImZ9V6I90Tx/dvKMSR9UCiQXo1ca8zH19P1OOCrmZG1Hy/02LHQq9a7qO3+f03oj5wzqXPfx/AMEoBPML2oPHNOs03vWHMYg3d/aaoT1ew3p1eKf/ESCFYd34h8VLhXQNzJwUsoWN7ZmKEfi8l+rEx6CS6wjAxFDY7wO70BaHy57kZoMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODBlNzPlp2XVI4j1CSZbklCvOSVflh3fk0NqXEk1Qsw=;
 b=fwiPgWgoipd9azslglvQcf43R26baoa6Qcek4EPGQHVI5cioU+su20NWrSD5ldkCr0UHxeORGiqbimBOOEeUAwz2+Mw66HGalDr/+8AeKHH8vAOb+6RBALYRq374/IcQXOcO11Cwvfg/g0ej7KOAoukfN1ToCgSOnFvtCLfkcC8eO8OHyTdGCIKM9RZcm2xftaeObIS2MGUsp4OCVESE9mDwegtmzNiXTniqasHeDbZHArXE/LxrjOW2ObCGBQvhmZwYpsUmkqzyY0Q3sv+Qj9RGWaox5ulzPHrfFtZ3SEvODAC28Wv3iU9trm3gF7h+3TW15CUd3xW2VH8rR7nyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODBlNzPlp2XVI4j1CSZbklCvOSVflh3fk0NqXEk1Qsw=;
 b=TEEb6Ip2kt+pcswbCIecWamjis2oalbzAqi9ham7cGDy4CXUedEoGZesjzQxaqHtuwHMx0pMMuOhDinjKi5owrmV6ryrXkFfmfC4v0LXtdptkh+GqxVV+stsqvHdk1cvnw4uxwHLoPxQqSHQ6DgeGqPyTjoeFDQQ5mSA5sJHVNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:30:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:30:37 +0000
Message-ID: <08afa28c-0e9e-480f-a27b-04103da2b419@amd.com>
Date: Tue, 24 Mar 2026 22:30:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults
 correctly on non-4K page systems
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0486.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4e69db-6c37-42e3-d375-08de8a167f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xRUncfT+8GxeBLrw1z6MZyyu/zwvAt/Q9srX/FHoBgkHDJpoHlx8MtaPWkIaZQOTOMS5eJx9hy6sneeppPTPll2ap70++QngXP9t1OucfSeLe15z2ZAMcYUtEM/9JhTk2eS59A68BAUM2GtRHeSTDNpZQmVNY+gSzP7GpiaKDz9ZZ9V0rDGflLqIq5+16jxn0wyOZoYC3PNueClVMfE6ie2C0GAzCshiv2UET+N4d59lT4aoGQy9AHIiZL6FyB3P79ZxzRX/1C0uXhhOPQLr4e8bf5UJR57Rm/KvlcTYfHRSvt6vQTbXe+qEfE/XYDfaaNlBRyc7cbdOIi2HsnuPIXzW6waUliUzbcFdloY7cREwyr9BkvGjXLj/Cx2Wj5eXRyZa8TnYB2o0tMaRoDzRYxtgS9TmF3FZLhBzC3iu3t9JDo6ttUKw8huqWBlMR7GAH0yYEBGnTtpwnYFKddJvuNN8hUkgPp80PZck8wgYLpCrnS06kNSNU+3as40yB5Gt6BQpjevXVDQSRUUX4wA3uhwqSqA9VsuI94NVh2qaVoamTfxCgB1J61OGiSgEIjjss54qkNJ3gCCm07yQmImqC8E2cFf9WGR5JNRoobLVsvEpdG9ulmiSzz1lZnQijDWauowMXngh8mjF3b6PEZzNrVElnVniZYNuHf1SQ6bn2+60f2hQrZ7ZPrAfZG41P0Q9UDE2gQlMTHu4WILV6MdMs32pzpoJNf0qLSdcxKHRuV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(7053199007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZSM0w0dHVPOHN0M2pZNG5JOWx3R1RUS0d1M2Z5WWUrcFJHVDBHZ1FzOUdo?=
 =?utf-8?B?SEJzU1BSMFhadnJkbWUyNUVvNURRWTdhWWMrNEtqek42NjkwLzVOSUh6cnAx?=
 =?utf-8?B?YlBaY3RFai9tWDhQMGFhVFVFY0VTdGhwbmdBdU4yZXZPOTE4bXB5ZTk2MTQw?=
 =?utf-8?B?Yk1iNkF2SVVlZlQrZ3A5NkZESWo4TUhOcDFvbTdHN1FjRlkvNVdvODhQRDla?=
 =?utf-8?B?OHZwaXE2ckRJdUpWN1QzRytXVmZ4WWcvZFd4UnM4bzhHL0xFQUwzZjNJaVZl?=
 =?utf-8?B?L3lCalg2RmphNnRUZ2FERGVEVTF1VEhUQmp5WFRVbEdXUHkxbTBJeEVJcDdS?=
 =?utf-8?B?TzZjUHFDWDJmYjdUZ21rTFU1V1EzbitBWFhiSEFFeUdmNnE2dWVYTmF3blZ2?=
 =?utf-8?B?Zk9uVG5GK2JUcDFKWHZJaUpWUElVUEwvQ0tKa0RET2p4eXpvdXRNOGI0Vnl1?=
 =?utf-8?B?K2ZSQ2tLUEJuVXR6OHc5Z21JeVdoVCtjYWNZa3FtWDNKaVIrbjAyVWpEdzFi?=
 =?utf-8?B?NWJ3ZTFtZmZpNUhrSGFFSW5rQTFyc0U1d2xaSnllVFNVWTFlZ2g3VWhES0s0?=
 =?utf-8?B?Y1dMTVduem1ScmJpVlBJU08wUzJ5ZjlYdmU0OVhoRyt0bFRuUFdNdWVsN1Rw?=
 =?utf-8?B?UEdnQWtEMU14K3lxTFFNMjRuVEVqcHRMblp2STR5US9UY0FpSXdFQjJDSFVp?=
 =?utf-8?B?UHRiSGlRUGZYekhPSXhhMWNKK3FHbzVoYS9sNTVzV25wbzYybTN5V0VJalJD?=
 =?utf-8?B?NEVIek4wcnJJVk5pVGFQeDRkTWd0Sk5XUVVCZDl0MnZVMHFWaEwrN3pDMWtF?=
 =?utf-8?B?N2ltQlBKRmkzaWpocUdzVlEwN2poNHl3c2ZRNW43QUpRclhjWkwvZjFrVWtE?=
 =?utf-8?B?K0R5NkhaUWk4NTlhckI4N0ZFRHVmSXlEb2dVbFN5QURhT3NkTmxQSEJ1aDNN?=
 =?utf-8?B?c2NsbVJIL3hFc0Z5d0dySmZPV3BiclZGNnJ6TmN2cjZTYy9iNzNRaG92N3Vn?=
 =?utf-8?B?RWpSd0dWWVBWakM1YlVRQU9DZGtxMWhTOVQ5TmlST3hjQkFCUFB0cnJiYlVs?=
 =?utf-8?B?L1QwQ3NpK2h3cmkzNHJpWEtJTERBVTErcURXdDZibUNxVUVxWVkyZWUxNUYw?=
 =?utf-8?B?UG5HcWYwbjVYamRmTjhObTRBb0hudE9FZndWamdiVjVwSldJaitzTlBmY3Rj?=
 =?utf-8?B?TXdKTzJjVHd3dG82Q1BHRnJNVW5mSFg5d09SdnB6T1RiV29neFFtTnVTd2FT?=
 =?utf-8?B?YmY4SWNNUWllVTBjYVFlSm1HaHFMYUNWR250K0NmbksxMUQyVEpQbEZjZ3Ro?=
 =?utf-8?B?dGgvSDUvaldoRENZbk1JVlhqWUVZRkhxSE1KalhrY3lIZkErVlBRYVI0L3ZN?=
 =?utf-8?B?N3VaUXRvdzJtYm5XUnRYTTNKSWZZbm1KUDVKcEJRR1hGNnNzRmF6akdTTDdm?=
 =?utf-8?B?MWxST0crNm4xeXBwYTFQM1JsdFJNSm9aM0l4cTUwUlNlMzgvRHF1RHY0TFAw?=
 =?utf-8?B?TDJmOGJVNkE0TUk5N3dCWit4TUNGbVNyQjgyNGh1ZmJGTlpxakRkVXhDOWlv?=
 =?utf-8?B?MWxjN3doTTVyRml1Y0tSRVAvTUJWaDR1TkpMbkhsQjJFS0U2ZE40NUNwbEVP?=
 =?utf-8?B?bkhHZFBQYjd5eUppdUlXaDl0UEV0UXpQcnFlS3BVNHVGT0NMNWhYYkRjZlBL?=
 =?utf-8?B?USs2Y1lrMXV1NkhGdDFOVmN4eGdUaTdUeUpxd3lUY0p3UXhwWVFFSkM3TENu?=
 =?utf-8?B?blo5dFlDN29rNURPbm94RXh6Znh6T0p4ZjNQT0pIcVBPYWtHL2NkQUMyOU81?=
 =?utf-8?B?MVlWTm1sVWZGcFdWd0ZOcVNHdGVSWEt3aFk3Q09wRjNGNzFDell3azZLWEZI?=
 =?utf-8?B?Wm9aZ3NhekZEQW53ZmZBaVJIUkwydU9NUU9jSGdzSlBlcHNQQmZrOWtQdXdR?=
 =?utf-8?B?dzNwbU4xSmh0SlhlQlUyZ1poRFRRY2Y0L0hwNmkyLzB0RkNjVW9tdlNsdWw5?=
 =?utf-8?B?ZWljTE4rZTQ0aUE4QUd0M3JDUWZUQmJHYVFycUxxQUJNQXJrSkNBdUhuOUdI?=
 =?utf-8?B?QmtENzVkRXJpZkFuclFvd1lzUytoMmFFZjVDUVJaWHlWSWhWRURWV203Qy9C?=
 =?utf-8?B?NFVzc2hPT0ZodjFNd0F6S2dJSE9CQ0MyeFArTGQ4WlV2cG14dkxtT2Q5M2Jx?=
 =?utf-8?B?SXU3OW0zM1ZWdU9TOXZ5VEZwMENLZHcyaUkwZE40eE4yNWYydWp4aWFRWU85?=
 =?utf-8?B?YkV6TjJ1eldKZmVmZU9UZGJPTmZ6ZU1mMFNqampPWHZmNnJuam9YTWF4L0J0?=
 =?utf-8?B?VWs3VGNwaVRwc2R3dG9HbGNMSWxINWdiVjB4MkJqWGhlaDNZYStGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4e69db-6c37-42e3-d375-08de8a167f9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:30:36.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8SqqETywkzXLEueNQHblV8jFZsukgSdX3EGeD6GU+PgI4rBir6x3o5kEt02FusA1hqhvjHj61R8VGhHKZWy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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


On 2026-03-23 00:28, Donet Tom wrote:
> During a GPU page fault, the driver restores the SVM range and then maps it
> into the GPU page tables. The current implementation passes a GPU-page-size
> (4K-based) PFN to svm_range_restore_pages() to restore the range.
>
> SVM ranges are tracked using system-page-size PFNs. On systems where the
> system page size is larger than 4K, using GPU-page-size PFNs to restore the
> range causes two problems:
>
> Range lookup fails:
> Because the restore function receives PFNs in GPU (4K) units, the SVM
> range lookup does not find the existing range. This will result in a
> duplicate SVM range being created.
>
> VMA lookup failure:
> The restore function also tries to locate the VMA for the faulting address.
> It converts the GPU-page-size PFN into an address using the system page
> size, which results in an incorrect address on non-4K page-size systems.
> As a result, the VMA lookup fails with the message: "address 0xxxx VMA is
> removed".
>
> This patch passes the system-page-size PFN to svm_range_restore_pages() so
> that the SVM range is restored correctly on non-4K page systems.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c..7a3cb0057ac5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2985,14 +2985,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	if (!root)
>   		return false;
>   
> -	addr /= AMDGPU_GPU_PAGE_SIZE;
> -
>   	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
> -	    node_id, addr, ts, write_fault)) {
> +	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
>   		amdgpu_bo_unref(&root);
>   		return true;
>   	}
>   
> +	addr /= AMDGPU_GPU_PAGE_SIZE;
> +
>   	r = amdgpu_bo_reserve(root, true);
>   	if (r)
>   		goto error_unref;
