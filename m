Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FE0EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 18:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D26210E676;
	Fri, 16 Jun 2023 18:21:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBBE10E138
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 18:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N47KjMegrXKTwf3cal7M78r1S1leHMYyYkCR8XOA6xj+Zuxw5+teytZzsENWR7GsDLF3M9BySTQr6/OC2PwhZ1cQRanTv/7fxnz/BQuYJLSoR6t42XCWT9QtbYko5kMxHdUMjzQwlBXiU5R9c5anzn62SBIy1+uWJkOHPTnk060sPHXro8BlQ4/Civ3fWwv5EiMR8sx9Uv9QDSlK6Oo57ldEQzMKTIltGdDACoMSYyTamz/o16nLnVw9NxkgfL5sxhnfb+TafRJ6rgIueBXzyN8lNjMPZcGafYFX1orCi86uZzDlbolTqZoJYKfbmFsetHBslynJgaUMJ46JO1Lu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ/N2YjbkNz+A5Egv3di6z2fzV5mJcSuA9cxDRFvU/Y=;
 b=LFEzo1NBZcg5X1gNDQFDXRV1RiJjehe01fO+RQZyeR+K1vMuigWDttRvEMs7yHrrCgP3jdvv9/RwOPo4ff8KXzNw8jhoajBm+LLj2GLNL6wIZBw14taooRFp+PEIUT5zBLGC0LDtshb6C2MMZv+hLaOOOr794hBqjNq3voFUosH0/M7gu6oMwt2lVMT6oCeWj2rESWx4Cc31O8xlNIScPa8FEDMjfNk1BoImwSGrhw8+JwtIgvM8vcH1rKnySo1g0KKu6ibSIhDyoaP16uL2ol+ZG5/iFsLpLVIS82TB5OLdSkHA5LLZuuBmPL4iaJIw9odQAXFUl3zofyBkJYdC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ/N2YjbkNz+A5Egv3di6z2fzV5mJcSuA9cxDRFvU/Y=;
 b=yh+pTxgUciWIqDbUXE5h4nRNIKQABD1lU50djpfD7h8N8CZy6jBzr4VIY/Q/nP1yYmEdzl1lSU5z5zHc9vzIwwdEONnckaGf3hwx28xtdjh0czJM2NchdOE1UCOmcDYxVzu2uApoH3Qoc7IqW9Vykv4ENmFIXjvFbIBexa2U7V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 18:21:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:21:20 +0000
Message-ID: <dcd0f189-deb9-1fa4-3493-61110e354d11@amd.com>
Date: Fri, 16 Jun 2023 14:21:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Use KIQ to unmap HIQ
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230616180030.1270267-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230616180030.1270267-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::16)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: e967224a-a66c-4ed1-1e73-08db6e967b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QWDr7YyEkCgebWMXCpJzRjIanvoXgo0aWvP55/xOmtMt5FUNTsW8W4Veimcwcbn+PUs1XQG5VHB6th/t+aMSTdVrZOxIxK/1zGmgDpXMrYi6r/eaoE0WatRkUBJ7uCTFJReuuseP063YTXK14pmg9WLtSKC5UoEjn2mJ3UBtci6PLuxzaEA/KOc58pdMCjEtc5JPujMtUL19nB8zPJaCGBElAw0izi8k7y0m1hyHMS1NVq1WRkBIL9uot8yajUTvugYUqH/iqx3KJ+mC83vhWyvkYvKcfctv4Y2RFnZNiAPf3sPQuDgFWjzSNzcVkNL+uOaqW9OsUR6BDvTTteIcXq1zFqvDTUr8M1PYZ+G6Bl7hn34SJRsuycMOKbH06yo6OqkRFOgsugQFZImTnRnXJHKzujdMCPfnepg1TaB1QQAhppx+mn47DQ8emT3ZLoPRi5/ZQygQGPmYMxHUn8fNz5pD6agTyLwPSu7R1X3Qk+ybPHpH/zi+90GZb/7aXh62KBzcgTcZ3jey4A30PJY0Alt88B07pasmYHHPWp/8+opnA5038cRbgJjleecinlNtUMKL+fId7Eux2UwH1URff/eUuY6xTN5Ucy9e9M7oRT8vCTZDETZ3BStIo06sZtOUo+dIfUodndDhxc2xxv5SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(8936002)(2616005)(8676002)(83380400001)(41300700001)(6486002)(2906002)(36756003)(6506007)(44832011)(53546011)(26005)(186003)(6512007)(30864003)(5660300002)(31686004)(66556008)(66476007)(86362001)(31696002)(478600001)(66946007)(38100700002)(36916002)(6666004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG92UkxYaFVteUlnTEY2SFNWK2FkQk1kRDZRTUhHbVVjNVBWaVFMdGlYZk1C?=
 =?utf-8?B?SVFiaVpub21NUGFuT0VUeGZKK1M4dW9QMkg1TFV5Ujl1eWxUalBzZ2ZLWU56?=
 =?utf-8?B?a2UxWEVOdi9sR3o1Q3JUOWVJSEZxbVVwaE1NNzJNU3BUTmNTVVpFenBYRGwr?=
 =?utf-8?B?K09sVi8ySUFHVHhlZSt4eFVOODhCN1hTQ1Y4cjVSOEkyZmVnT252T1lBZmcy?=
 =?utf-8?B?S0lrb3N3Rnp6dXpmUWVUR3htRXljQkszU3V4b1dGblhuUG1UTm9oYkkzTnE4?=
 =?utf-8?B?aWNZZlg0MG9hZVBRTHY5NjF5cUR2QzlPUUxyNE9RT2tWOFYyWkp0OUgxREoz?=
 =?utf-8?B?dUdlRzRTUGpmRjhBRU56cU5SVktCN3h1WUFsMjlNdzhCUkNNR3F1Skxmei9x?=
 =?utf-8?B?bDB2b2V5Q08xaktuaGpCeVU2dE1qbld1cFBwcGpsNGYwdUpNRVhYUCt6SWlz?=
 =?utf-8?B?dHlqYkR1S3kwMW56eXh6UnQvYUpBZEpaK3YvTi84MVlXRVE0VFo2WFowbmxF?=
 =?utf-8?B?ajZYVmkrWkw1Z2pVU2FsSU95ZHV0dTZwTEVQc25uQXdRR0ZGV1dvRmIzOGpi?=
 =?utf-8?B?SjlHK0liQnpEN3FsSzZEOXJydzgya0kzMmVkVThzU2VsVHBTWm41SnRjb3N4?=
 =?utf-8?B?cmYzNTlPZTNkdGJadG9keGNDTkV1dDBLbUZ4b2padTdVQktDamlzV2xvTXhC?=
 =?utf-8?B?bWlidFhHUlNGRHF1QlpUSjdwT212RUw3SHRCaVNwOW5xL0RidytHLzhwMlVM?=
 =?utf-8?B?cFhCbDI2VENFcDlnSTNOSUVTbEtNMkZFdm1LMG1rYlhwcnlOK1Y1WmoxazZM?=
 =?utf-8?B?cXQrR01ybmxaSWVpRzVIMmN0Vmlpa0RyTExwYTBGVUYwRUowNlNGZkNQUHR0?=
 =?utf-8?B?UVlsYXdDSngrYnI0SXJmNStsZXRrRjRKK1p4cTgvVXpIeHZjeXpHK0ZNMXVW?=
 =?utf-8?B?bWVXQis4WGVZdGNuUTUrOElwS1QvVmVmT3kyaXRlT1RSUXFOT3BhQnFpbUx4?=
 =?utf-8?B?Nm1yM1lYL0R2bVUzQ2xCaTZUb0FqaStTUGdlR2o3S2themZ0MmxucFJSSmZs?=
 =?utf-8?B?bmJXczZWRlQ1bzlGSVNKek1MUFBCNTNxbGlJT2NURnBDRXNiakc1d1luSGdi?=
 =?utf-8?B?bThLZGR6RjZmd1MyZ0cyZWNNZm5IRTBRRFk3WXl0MnpWWWU5MlQ1S0VQRzAv?=
 =?utf-8?B?UFlYdGxUb21wQm5vZldVME0rQzUyWXJjcU0vYmhlZ3hTRXpHVkFsSE1xUmRN?=
 =?utf-8?B?QWxqVkRiWGdFb0RoV2F6SFUwNlhLTW9SSll0L3ZhWjA2Q3ZuZzgwV3p1K3BU?=
 =?utf-8?B?Q09ybFJaKzByK1R4WkhJWjMxOUlUTnpkMHk2UFVLeE8rSzZORnFvZHRGOFpI?=
 =?utf-8?B?TlZYQ1NtTFhaOXkveXhGdndNN2ZmNGRESHFnRS9MZkNlQ0U3NS9iMFVUSUFu?=
 =?utf-8?B?N0dlQWpCQW94K1JkQlcyR1NVMVlRYVE3MzJ0Ukd4MWc1NWhpSjYyVDVXWWFn?=
 =?utf-8?B?c0ViWHQwTmpISE5RMmFzeFB4V1JpSHMzcVpvWUxKQlFNRUhjZm8vZDRzWVli?=
 =?utf-8?B?cTdMVDY5dzY3T2sydzVGR1ppZDVDZVJiZWRZNTY5RmZ2c0Z5U3VnWlRwSEtS?=
 =?utf-8?B?R3pMbmdiTkRWRjNOZGtLejZjV2I2OFFyVHlhMmFGOFdybGxXcU4ybVZGK0F1?=
 =?utf-8?B?cWgrVE8yUzM3NDl2Q0d3cTh6bjI4Z29ITEtoSlV0QlJiZzVpVW1QdXBacHB4?=
 =?utf-8?B?Qk5rTWJ0d0lnajlWYjlUUk9Zd1pwSWdxYTZGVk1vNVU3b3czb3l6UmlFUjg5?=
 =?utf-8?B?NTFNTE0xb1pMbXRSWVQzbEZjandRd0ZnNklrZzRDN2Qvcnl6WFNXRnVsMkt1?=
 =?utf-8?B?Z2Myd2lHSDNYTHpzb0Y5TWJzWTJUTmJuVEFsOHBCWkZvSzNTdEtlSzVVeFhY?=
 =?utf-8?B?UWJHcTA2UXNKRkw4eVBLbG1LMU5EaWpEdHY2SklWVnlrdy9WNGJWNFEzcVBr?=
 =?utf-8?B?MjhEUDgxQ29yUUpKalRwdjNLS05lSlZ4NmNBajhxbEdZSHpZVUpKRlZpcEl5?=
 =?utf-8?B?QVl2QTRDOFVrOExiNk9sazZQSWZkdWtGYXpWZ21QZ1pVOE9GSStzK0grQ0V0?=
 =?utf-8?Q?I1wBbCg/Tfixf4rtYxU5JY4nw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e967224a-a66c-4ed1-1e73-08db6e967b86
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:21:20.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BfVgUkQ/e5QaXMD5A2kTzu8fvklA+a5lkGM6dsLsow4dN06I4qxAsYz1TyjU4Sd0Cb2Rm5/okbRIRpuE/eGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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


On 2023-06-16 14:00, Mukul Joshi wrote:
> Currently, we unmap HIQ by directly writing to HQD
> registers. This doesn't work for GFX9.4.3. Instead,
> use KIQ to unmap HIQ, similar to how we use KIQ to
> map HIQ. Using KIQ to unmap HIQ works for all GFX
> series post GFXv9.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  1 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 47 ++++++++++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  3 ++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  1 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    | 47 ++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 48 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  8 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  4 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  7 ++-
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
>   13 files changed, 170 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 5b4b7f8b92a5..b82435e17ed0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -372,6 +372,7 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>   	.hqd_sdma_dump = kgd_gfx_v9_4_3_hqd_sdma_dump,
>   	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
>   	.hqd_sdma_is_occupied = kgd_gfx_v9_4_3_hqd_sdma_is_occupied,
> +	.hiq_hqd_destroy = kgd_gfx_v9_hiq_hqd_destroy,
>   	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
>   	.hqd_sdma_destroy = kgd_gfx_v9_4_3_hqd_sdma_destroy,
>   	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..a919fb8e09a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -510,6 +510,52 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
>   	return false;
>   }
>   
> +int kgd_gfx_v10_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
> +				uint32_t pipe_id, uint32_t queue_id,
> +				uint32_t inst)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
> +	struct v10_compute_mqd *m = get_mqd(mqd);
> +	uint32_t mec, pipe;
> +	uint32_t doorbell_off;
> +	int r;
> +
> +	doorbell_off = m->cp_hqd_pq_doorbell_control >>
> +			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
> +
> +	acquire_queue(adev, pipe_id, queue_id);
> +
> +	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> +	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> +
> +	spin_lock(&adev->gfx.kiq[0].ring_lock);
> +	r = amdgpu_ring_alloc(kiq_ring, 6);
> +	if (r) {
> +		pr_err("Failed to alloc KIQ (%d).\n", r);
> +		goto out_unlock;
> +	}
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
> +	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
> +			  PACKET3_UNMAP_QUEUES_ACTION(0) |
> +			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
> +	amdgpu_ring_write(kiq_ring,
> +			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(doorbell_off));
> +	amdgpu_ring_write(kiq_ring, 0);
> +	amdgpu_ring_write(kiq_ring, 0);
> +	amdgpu_ring_write(kiq_ring, 0);

This looks like you're duplicating the functionality in 
kiq->pmf->kiq_unmap_queues. Can we just call that instead? See 
amdgpu_gfx_disable_kcq for example.

Regards,
   Felix


> +
> +	amdgpu_ring_commit(kiq_ring);
> +
> +out_unlock:
> +	spin_unlock(&adev->gfx.kiq[0].ring_lock);
> +	release_queue(adev);
> +
> +	return r;
> +}
> +
>   static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
>   				enum kfd_preempt_type reset_type,
>   				unsigned int utimeout, uint32_t pipe_id,
> @@ -1034,6 +1080,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.hqd_sdma_dump = kgd_hqd_sdma_dump,
>   	.hqd_is_occupied = kgd_hqd_is_occupied,
>   	.hqd_sdma_is_occupied = kgd_hqd_sdma_is_occupied,
> +	.hiq_hqd_destroy = kgd_gfx_v10_hiq_hqd_destroy,
>   	.hqd_destroy = kgd_hqd_destroy,
>   	.hqd_sdma_destroy = kgd_hqd_sdma_destroy,
>   	.wave_control_execute = kgd_wave_control_execute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index e6b70196071a..00b4514ebdd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -53,3 +53,6 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t grace_period,
>   					       uint32_t *reg_offset,
>   					       uint32_t *reg_data);
> +int kgd_gfx_v10_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
> +				uint32_t pipe_id, uint32_t queue_id,
> +				uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 8c8437a4383f..98b3a8cdc2c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -666,6 +666,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
>   	.hqd_sdma_dump = hqd_sdma_dump_v10_3,
>   	.hqd_is_occupied = hqd_is_occupied_v10_3,
>   	.hqd_sdma_is_occupied = hqd_sdma_is_occupied_v10_3,
> +	.hiq_hqd_destroy = kgd_gfx_v10_hiq_hqd_destroy,
>   	.hqd_destroy = hqd_destroy_v10_3,
>   	.hqd_sdma_destroy = hqd_sdma_destroy_v10_3,
>   	.wave_control_execute = wave_control_execute_v10_3,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..d0ef32ec76df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -485,6 +485,52 @@ static bool hqd_sdma_is_occupied_v11(struct amdgpu_device *adev, void *mqd)
>   	return false;
>   }
>   
> +int hiq_hqd_destroy_v11(struct amdgpu_device *adev, void *mqd,
> +			uint32_t pipe_id, uint32_t queue_id,
> +			uint32_t inst)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
> +	struct v11_compute_mqd *m = get_mqd(mqd);
> +	uint32_t mec, pipe;
> +	uint32_t doorbell_off;
> +	int r;
> +
> +	doorbell_off = m->cp_hqd_pq_doorbell_control >>
> +			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
> +
> +	acquire_queue(adev, pipe_id, queue_id);
> +
> +	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> +	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> +
> +	spin_lock(&adev->gfx.kiq[0].ring_lock);
> +	r = amdgpu_ring_alloc(kiq_ring, 6);
> +	if (r) {
> +		pr_err("Failed to alloc KIQ (%d).\n", r);
> +		goto out_unlock;
> +	}
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
> +	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
> +			  PACKET3_UNMAP_QUEUES_ACTION(0) |
> +			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
> +	amdgpu_ring_write(kiq_ring,
> +			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(doorbell_off));
> +	amdgpu_ring_write(kiq_ring, 0);
> +	amdgpu_ring_write(kiq_ring, 0);
> +	amdgpu_ring_write(kiq_ring, 0);
> +
> +	amdgpu_ring_commit(kiq_ring);
> +
> +out_unlock:
> +	spin_unlock(&adev->gfx.kiq[0].ring_lock);
> +	release_queue(adev);
> +
> +	return r;
> +}
> +
>   static int hqd_destroy_v11(struct amdgpu_device *adev, void *mqd,
>   				enum kfd_preempt_type reset_type,
>   				unsigned int utimeout, uint32_t pipe_id,
> @@ -796,6 +842,7 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
>   	.hqd_sdma_dump = hqd_sdma_dump_v11,
>   	.hqd_is_occupied = hqd_is_occupied_v11,
>   	.hqd_sdma_is_occupied = hqd_sdma_is_occupied_v11,
> +	.hiq_hqd_destroy = hiq_hqd_destroy_v11,
>   	.hqd_destroy = hqd_destroy_v11,
>   	.hqd_sdma_destroy = hqd_sdma_destroy_v11,
>   	.wave_control_execute = wave_control_execute_v11,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..c1708de38b33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -523,6 +523,53 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
>   	return false;
>   }
>   
> +int kgd_gfx_v9_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
> +				uint32_t pipe_id, uint32_t queue_id,
> +				uint32_t inst)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[inst].ring;
> +	struct v9_mqd *m;
> +	uint32_t mec, pipe;
> +	uint32_t doorbell_off;
> +	int r;
> +
> +	m = get_mqd(mqd);
> +	doorbell_off = m->cp_hqd_pq_doorbell_control >>
> +			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
> +
> +	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> +
> +	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> +	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> +
> +	spin_lock(&adev->gfx.kiq[inst].ring_lock);
> +	r = amdgpu_ring_alloc(kiq_ring, 6);
> +	if (r) {
> +		pr_err("Failed to alloc KIQ (%d).\n", r);
> +		goto out_unlock;
> +	}
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
> +	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
> +			  PACKET3_UNMAP_QUEUES_ACTION(0) |
> +			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
> +	amdgpu_ring_write(kiq_ring,
> +			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(doorbell_off));
> +	amdgpu_ring_write(kiq_ring, 0);
> +	amdgpu_ring_write(kiq_ring, 0);
> +	amdgpu_ring_write(kiq_ring, 0);
> +
> +	amdgpu_ring_commit(kiq_ring);
> +
> +out_unlock:
> +	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +	kgd_gfx_v9_release_queue(adev, inst);
> +
> +	return r;
> +}
> +
>   int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
>   				enum kfd_preempt_type reset_type,
>   				unsigned int utimeout, uint32_t pipe_id,
> @@ -1154,6 +1201,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.hqd_sdma_dump = kgd_hqd_sdma_dump,
>   	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
>   	.hqd_sdma_is_occupied = kgd_hqd_sdma_is_occupied,
> +	.hiq_hqd_destroy = kgd_gfx_v9_hiq_hqd_destroy,
>   	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
>   	.hqd_sdma_destroy = kgd_hqd_sdma_destroy,
>   	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 5f54bff0db49..37b76c66f0fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -45,6 +45,9 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
>   				enum kfd_preempt_type reset_type,
>   				unsigned int utimeout, uint32_t pipe_id,
>   				uint32_t queue_id, uint32_t inst);
> +int kgd_gfx_v9_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
> +				uint32_t pipe_id, uint32_t queue_id,
> +				uint32_t inst);
>   int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
>   					uint32_t gfx_index_val,
>   					uint32_t sq_cmd, uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 863cf060af48..83101b3d341a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -193,6 +193,14 @@ int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>   					      queue_id, p->doorbell_off, 0);
>   }
>   
> +int kfd_destroy_hiq_hqd(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type, unsigned int timeout,
> +		uint32_t pipe_id, uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hiq_hqd_destroy(mm->dev->adev, mqd,
> +						pipe_id, queue_id, 0);
> +}
> +
>   int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
>   		enum kfd_preempt_type type, unsigned int timeout,
>   		uint32_t pipe_id, uint32_t queue_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 23158db7da03..8ad8c8087da8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -173,4 +173,8 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
>   uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev);
>   uint64_t kfd_mqd_stride(struct mqd_manager *mm,
>   			struct queue_properties *q);
> +
> +int kfd_destroy_hiq_hqd(struct mqd_manager *mm, void *mqd,
> +			enum kfd_preempt_type type, unsigned int timeout,
> +			uint32_t pipe_id, uint32_t queue_id);
>   #endif /* KFD_MQD_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 94c0fc2e57b7..40c0ebb5e7ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -460,7 +460,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>   		mqd->free_mqd = free_mqd_hiq_sdma;
>   		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->destroy_mqd = kfd_destroy_hiq_hqd;
>   		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v10_compute_mqd);
>   		mqd->mqd_stride = kfd_mqd_stride;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 31fec5e70d13..79f245efde5a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -449,7 +449,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
>   		mqd->free_mqd = free_mqd_hiq_sdma;
>   		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->destroy_mqd = kfd_destroy_hiq_hqd;
>   		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v11_compute_mqd);
>   #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 601bb9f68048..7893c53c9372 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -553,9 +553,8 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   
>   	for_each_inst(xcc_id, xcc_mask) {
>   		xcc_mqd = mqd + hiq_mqd_size * inst;
> -		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
> -						    type, timeout, pipe_id,
> -						    queue_id, xcc_id);
> +		err = mm->dev->kfd2kgd->hiq_hqd_destroy(mm->dev->adev, xcc_mqd,
> +						    pipe_id, queue_id, xcc_id);
>   		if (err) {
>   			pr_debug("Destroy MQD failed for xcc: %d\n", inst);
>   			break;
> @@ -846,7 +845,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   		} else {
>   			mqd->init_mqd = init_mqd_hiq;
>   			mqd->load_mqd = kfd_hiq_load_mqd_kiq;
> -			mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +			mqd->destroy_mqd = kfd_destroy_hiq_hqd;
>   		}
>   		break;
>   	case KFD_MQD_TYPE_DIQ:
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d0df3381539f..0f242aad22c7 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -268,6 +268,9 @@ struct kfd2kgd_calls {
>   				unsigned int timeout, uint32_t pipe_id,
>   				uint32_t queue_id, uint32_t inst);
>   
> +	int (*hiq_hqd_destroy)(struct amdgpu_device *adev, void *mqd,
> +			uint32_t pipe_id, uint32_t queue_id, uint32_t inst);
> +
>   	bool (*hqd_sdma_is_occupied)(struct amdgpu_device *adev, void *mqd);
>   
>   	int (*hqd_sdma_destroy)(struct amdgpu_device *adev, void *mqd,
