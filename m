Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF1FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 18:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1517B6E93F;
	Mon, 29 Nov 2021 18:05:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557A46E8F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 18:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxVPqm5UTkovis/ZzQDEG8jdETtIEb51+0Ej+1d2BSZqoWcVW20XXXx5yaVhEpQqIKRCQISymfpcrS+GTQ7CJU+KRAhXim46iOBfGoPLStqK9Bcn2svWlMlb9L8RYx/8bg2dtPMiWvoxxx45Qy/WwykZJwbPM6Hv0Xxg+w31xzIPVjOT0e+3bGFe50Ye1t4XdonxqdO3lBX1t3zivet5o/Q/+iMIjjjPnxvzja/asKvoAnU4EYSuiw5fgBlQnLxtv3FDjbqndpLEyU2dvmTqLUc0l/4tECErutthJ4pLTXXR8xxOjqImAXm0yAcW1j+OiLppK/rwQetneokcYVUEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVc1BoLbg5tIoO0l5RcSPnSldkXr8BMsuECL65+KvEI=;
 b=f7Qn8AmKoNBy3Cf9tSthcr7QtBkXMk7EOvpFhFGsDX+VQbeuCRP3Ay/+n3jgyTN+h86z9FfEWucrVHNzy1Bt7RmI2eSdwfZ6YzJgwWRuGy+pQJ/odZWy46oY9vYq/so6/bPlJYKeeZlBd68vFv2JALhLLzwNhbKNg+XrYSim24i46BHtnaNj7FSqgiDRr/uN7j2K7VJ9PQkVuBdrpEl3A0JpLYtAoBrMba08pz/y+M2IPAYguucd8Ge49Quo2tXuPSf7tJQRuMdC8XdJ1ZzrH+Tc9NnDyzN46/Fxug5GGSR8Y2nMBjLkaJ5VuBwpJmztIp34INYyWSVv6n/pngYryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVc1BoLbg5tIoO0l5RcSPnSldkXr8BMsuECL65+KvEI=;
 b=NnpQ79Ego8kXnGtoN9FHX62IXfMkzHf74Z9RSOCl36pHnz2Zp5IgRPpP8ypUjNshCOEz+dIHFXIsx/Kx0/hKD407mPl+z/xzYg/SNiN0DFk6wwSoQSRadk1rl/+B2lxDfYBVuQ2ZyfEExr2ZK0CPr5U2d1DTwCTS74SsY4RWEmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 18:05:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:05:35 +0000
Subject: Re: [PATCH v2] drm/amdkfd: set "r = 0" explicitly before goto
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211126184221.17598-1-Philip.Yang@amd.com>
 <20211129140519.18202-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <67a22e8b-7d00-ee2e-d7fb-6900a86c9595@amd.com>
Date: Mon, 29 Nov 2021 13:05:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211129140519.18202-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT2PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 18:05:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3179542-815f-434b-44e6-08d9b362d756
X-MS-TrafficTypeDiagnostic: BN9PR12MB5114:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5114F4BB9AD164A07FC190A992669@BN9PR12MB5114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaWAOnydcXJweTQ5uN3KRmHDzaqbL0vYPN4MbobU/P32ObktXxPcjugnBJMJFUiQnEy7bjbv3w5NVufU2p+udlMGmSQQfJAnc9Vq5x99GxTWrw8SPlpESv9AH1DtZv8PMYpyfhXLXAMeSjiHLvU48Dlthx9F6P06LkuiarAEbzPTxzkesWWa5/KuyiCTSqZbHp79+IsKfROs+hrHEIYDcSUDfZd+YGADI5mE64PLN7cLtL6jpUtUZryxqP1DPh9RZ605WqljmfORvfqjMzn2xBbwEi+ezBa8Y47Y4NOLZB84HIfMghH/1l8FA+lKLiCyhHbXR3/D3asC7pyr666vAc5o2BwqMPO1Uvt/5lsSMytQh0Ma2EmKb7a5cViSNahVlqUCdafoVtxzluOPboWFK2ualWjgwpfz6hj+dIRcKYEyXyjN2fy+tArCJAz4BIeQhteKTR4Zej11Gc36SIT/uHkKEfLxGPDqM3mcCOPufsFnz0yqae0kRZRsMsxQTR7VzoVp/PJRpZWFtCpd9yO8P5PF7yjAO/SJCYebASiUQZOsuHU36nU7Bp9XgYRvIQt5kJTV6hlfDMF+IahNUyGcsf6rbi7Q8XL8IuH0PeqdqYYxpBTgiaJgFopGnaojjxBqyuRJid25qgBWWQ5h35YBQM3f82RiRWZKr6owYadhVopuGjKy6V+06dsWnIRQOK6ESc2Ra0KkTm6d6fkea1nBOWrz/j7LONzN9obONX4wJlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(66476007)(86362001)(66556008)(26005)(44832011)(2906002)(83380400001)(38100700002)(508600001)(4001150100001)(66946007)(186003)(2616005)(16576012)(956004)(5660300002)(316002)(31696002)(6486002)(36756003)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUw1Q2xNNnhlQlQ5T0pPL3RzWExhcVNERGdYZnRJWk9CQnJya05PN1h1a09E?=
 =?utf-8?B?aXpBcjI1NTJWcUZLQzVtOFA1K1o1dU5kZ3RuR2RIME16eHdtOENibXpTRHNT?=
 =?utf-8?B?MC8yb1VpMGtKcy9ERFdkNE1UZ1F2TGlvNlAxVVBodGlacHFhZ0lwYWd3VkF6?=
 =?utf-8?B?L3d6SGUweVVSK05EampVYlJFQm5OclVEbmJNdzRkcG4xZFAvc3VFWTZ0UklF?=
 =?utf-8?B?cFd0aFFYbDRpTGlzeU12bFRSWGpvVmZRcVlYMFRzeGJkdS81R1Z2QTJTenNk?=
 =?utf-8?B?ekFBN1NiQUtsRzI2SkRaZFNOM09MSjNrajYxczE1S2tOS3NyUUVDNjhjbzNv?=
 =?utf-8?B?bzE2dktDQW9TbXNUOEQ3QUVGclRtVmxXMXMxSlZxLzIwZXE2TW91NTNCY0Fy?=
 =?utf-8?B?MVAvZGMxdkZWb2N0WjJYWkE5d1pSb25aSTJGbklLSGNxeTNqYU5sY0ZtRi93?=
 =?utf-8?B?MDExMlRJWU5FKzJvdHkzVk82aVJhdnB4UnBhQVlJSU1yZW1ndFViMVFqdVli?=
 =?utf-8?B?bU51UllONkxDTEdLWFl4MlBkdTZrUTBOOHFwb3duRDB6RE1oZ09FNUVISzda?=
 =?utf-8?B?SnpLVHQrQSs0b1ljRGxiejZrQW8yV3dlUHB5U08xcUZQWmtTSnkwRGgxeXRY?=
 =?utf-8?B?V09SejNmWVZUSUR2NmtqZHNlQjhzNnhRRHFxWHVmSXVDV0w1R01nVDRZNXVG?=
 =?utf-8?B?Q0N3RTNSM1hnVldzVjZSS1g4SGI5YnZBWGFPN3c0cHQrbGF5aGU0b0dTbEJv?=
 =?utf-8?B?R0U0bldYZnAyZVdLcnMwTzl6ZUk1MWlPRWVoR01CNmxqa1ovc1F1NURXdDVO?=
 =?utf-8?B?UVVFRHNLSzVDcFNEeGozbGpHYlFBR0p4d0ZjK0o3RTBXWVh1SGswMDFHbWg0?=
 =?utf-8?B?T0RDOVYrc0pmVDRnRGV0d3Z5RTBqN09TUC9xUldUeldnd0MxTjVyOUszTThx?=
 =?utf-8?B?RDBoR2hpcEg0MzlsVTJUY3MwTU9DcGNuS1FoZWN0bWlUZnlhQUtqTis5MUg1?=
 =?utf-8?B?cWR0ZDR4Q1BZV3JseVFnSmNyelBQRWpJWjdVSWxyejgvYzVlNVB4MDZWZ1J3?=
 =?utf-8?B?VEtOVEZldC9OVkptUGhsQVlldWtYS3k5WHlZSEhnd1paNlNaWUZPVk1WQ1pa?=
 =?utf-8?B?Y0JQTlF6NzBIRC9qTVI3TkhSM2pSUzRmMDBobzkxbmc1RlBxc1U1akE5Szho?=
 =?utf-8?B?b1pvb2l0ZzR4c1FqVkp2WnhUbmZjZkxxeUN4VnJaK3lXRnQ5eEthVkhlVGhN?=
 =?utf-8?B?cXl1TS94eDdEN1YzSzE0a09Mbmk5SDVYZitlSHpyTkhMSmZuZWEzTVc3aTZw?=
 =?utf-8?B?Q1RnSEJrWmFvWFNNZTZMZHNrQzV1RlA4WFJFZEJiQ0VHVDBsZjRWWGd1STNO?=
 =?utf-8?B?ZlU2ckZ5SHQxSHVBQ000UTVhZTlpQWx4MzhqREtGVEw2MnJzdG01NnhBSEJI?=
 =?utf-8?B?eE5Cc1g1YUJMOEdKVVdJQldXcDNJYnZkTzBiV0t5Vi9NZ3NRMlRQVjhMY3JF?=
 =?utf-8?B?NkhIdVM0Q2lpbmtiMW9JRld3RUcrakNhTzB0NlE5R3pXT1dyZ0wybEdmRWlG?=
 =?utf-8?B?U0ZBeWVNV29MbEI5dnRiL0w3Z2xsUHZOMlB6TEhJdHN2c0UrMGlTbHFSVDZP?=
 =?utf-8?B?WVBvWjlHdFM1NHpRdE9yUWhEdlAvMzB6L2tvSFltT0pjZDN0K3BoU1BFcG5Z?=
 =?utf-8?B?TS82Y00rYnp0UUVWY2d0L2Rlc2MvdlVZNkt5T1RSOVRFcWZYanMvdzlkMFoy?=
 =?utf-8?B?WlJuNFoxRnlpT3diN1VGa3ViTDZHakFBdkhyZG0rQWdoQ083cGp5MU5SWVlC?=
 =?utf-8?B?cklnMzVDRnppc0F4U0tITlZFNXhFUWZ6cWNjTCtkTTVwVmJnK0FTU2kwOTJR?=
 =?utf-8?B?RjNsUGkraUVFQ1BTNG1pTTlMTnJ3TS9TVjBqVjdqcUxqMnI1ZW9nenZWZ2E2?=
 =?utf-8?B?WlpNSkMzcm81U0NhQlNiRCtWWlhjbEs4N2ZHRmRQdVd6M1JoMm5aRzJhREVK?=
 =?utf-8?B?RmlvN3pXRTZXTVYzR2Rqb2VpOGVnRkxtWTA1YjNYOUE5bHRieDJRWFJMcnBs?=
 =?utf-8?B?R0R1bngzYkZBNkVYNXZqbld0cWwyeWFDbTVJS2ZxcGxmMjJQOWFaZTRDOEw2?=
 =?utf-8?B?ejliZTExRUV3anJNY0hTTm1Gb0FxWUlsWURJNDcvOWdRZkl3QS9RNGFTZVNM?=
 =?utf-8?Q?2YiBXu+odhQaSXb/ZGQjdrE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3179542-815f-434b-44e6-08d9b362d756
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:05:35.2359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFFou4dsyB3CwC93ddKMXlp3SLUbzS8283rwT9kjOCUJ/2f4uTtIu3xtC1btCMf5+UEXnJwqQXUKOmR9KlAXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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

Am 2021-11-29 um 9:05 a.m. schrieb Philip Yang:
> To silence the following Smatch static checker warning:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2615
> svm_range_restore_pages()
> 	warn: missing error code here? 'get_task_mm()' failed. 'r' = '0'
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 663489ae56d7..187e8ab66baa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2603,6 +2603,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  
>  	if (atomic_read(&svms->drain_pagefaults)) {
>  		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +		r = 0;
>  		goto out;
>  	}
>  
> @@ -2612,6 +2613,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	mm = get_task_mm(p->lead_thread);
>  	if (!mm) {
>  		pr_debug("svms 0x%p failed to get mm\n", svms);
> +		r = 0;
>  		goto out;
>  	}
>  
> @@ -2649,6 +2651,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  
>  	if (svm_range_skip_recover(prange)) {
>  		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
> +		r = 0;
>  		goto out_unlock_range;
>  	}
>  
> @@ -2657,6 +2660,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
>  		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
>  			 svms, prange->start, prange->last);
> +		r = 0;
>  		goto out_unlock_range;
>  	}
>  
