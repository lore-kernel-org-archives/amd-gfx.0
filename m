Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D23C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 17:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7621311299D;
	Fri,  4 Mar 2022 17:10:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB66011299D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 17:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLSHyaEC8aBWNxA2qPhICJaTYJWzF3hzXUFOSTnp+fMLtiM+c3fbMLicSiBr1rvi8nx6dP35F7PhT52x2y0dLUcp1T5NjyygbMLaCyZqqEmZIiRVuqpXCNBHZeLy0CzhgoIGru8KiWo3NKuQXPycTGynUFH+cJ1TaxERjg68OAG6XV5AXaXDhrWfQ6gUiliHLALzWW2ygII7hNTibrkW2F2mp94N1J97ZH3sExPk0HHOSGiqkOATvDFZdxTbyCR1ZI0LSMTns//Torzv/tRoVWKPX6ZGeLYDk86ssF8t25tBPHBH8Zb87R4h7/kIStzn6mAN3V0MTkHsPeaH1msEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjfwJqbsaDA9+gis19AdMeOCdyn1QfGd2tdg2wKotw0=;
 b=IdMxlXcYCyLbZz/7lYVJoZ4aPzPObKpCIoSkiOT6eI/moNSadf5JEC5x1n9FYOVc4GyouUvxMonfeucMYtUkQjlE83gDYbw+HyZ+FHA29JjL+jwQPsl8P2zk7EBW/J0xowVPB5eC29hZd3nBzrAqxO2ivLxYeWG7b5Jh2x216fdLw8sVvg4VLiy9rFpw0nUkNG7mtJlEwX0nOEEPH7+34z7ANBec+VcA+IuidY1UV3pDXmWjbXvrvTmxM6W7cpdh/GD1x0dCvN4qU0t+MgUHPyKWwEjmJty/1+ZCpChNuxvRUQ59i8BeqDcidS4Jdnl89X8rcnq4j7TPMHo9WbmueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjfwJqbsaDA9+gis19AdMeOCdyn1QfGd2tdg2wKotw0=;
 b=sV5TSVzzqtzYuXogZaOJhwJzfeOj3VlxTcupoTRprg3KWQsGNMoMm+FkwfGfVwsShEgjVd2ZSfcotmld4B/FtR1oqT2FVRLJtp7pplJFrCOmLRMMcFOmyVpq8oef2pZyncEAMQ+YqeQRX3y5W9ybEgiL5LNaUo6MYmGr4it6VZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 17:10:33 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 17:10:33 +0000
Message-ID: <9bf49ccf-09a9-15d5-5591-ee2164c07f3c@amd.com>
Date: Fri, 4 Mar 2022 12:10:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-10-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220303082308.38217-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d980901-88c1-4edd-dd11-08d9fe01e495
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB454936C903B1A1EE522D7A91EA059@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf0RYiPT7geTgQfWv9zvw+3lP9RZTtNPIpAM6NxUdYgv4J8jnPr8NjXjgpp7RBLUpOCfTt5NKIFTk1JIPp9S2coLVjOWHru29YAEEy/B3BVKdJh3etFIyqhdGg1gRBLJjc4IPBgB/4SqpJP9f+7XHMCTlwFmcBCIgTsQE7ehGbzZFwgllklRqtlJOM6NAeO1qMd3p1Xt6qYGTBZa9oBl9Y6sUUYFrbV+4T6kE0pDkXJmcu7JlCTP/uePaRkw+Tppj1pLw7RLt1jj67MtqR+SDf8MSfw5nghB4x7biU4FcZLGx+uPvfazQwO3gHHiNbi/XajVPANZF0AGEPd+OWfPK3xxPSXXQh7VZpH5aCnKK37K6cRZPER4PcjSkBq0xaY1KdtMDYqdPtfXXm9RC8VvfWy554n7AMnYxJEbvIR/jA8xclbpw1iWuMomae1KLF7Tyg1240KpjoN57qsTMo4NFV/fiOZzN9vRcFRidBFqgdv8mdx0X4mpANhPSss13otoYnGz+oRuacNMngqP/VxI6lB4eNjq5Ru41fualZ22+KbkuDUyCZKZbXtOB/M9nxpKnm2evsQ8W8aaLPDpmbUadykbrKe64VeNSmmnTRsbrSCxBk+nw5BlG5slqDuivIHrJksO84Zfh+qvIYbJp6yeIJH5+0bkIKjwqD+97nncYEg5Xx3h6rMJj6B/geYaHf6Fy9tCtMEeD6gSiKBi2PRXCC4rAntMvXfTsGLDKkk4OmicrxkCg+LNBxwvLCVQF2jB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(508600001)(5660300002)(44832011)(86362001)(31696002)(2906002)(8936002)(4326008)(38100700002)(8676002)(2616005)(83380400001)(6486002)(66556008)(66946007)(66476007)(66574015)(53546011)(6506007)(6512007)(316002)(36756003)(31686004)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VisrOG9NTmFEaEZpbFZJWGtoWG5GbENrQldwbXVodzJHSU43RVlETUxaZVJV?=
 =?utf-8?B?cUYySVV0SDZKdWkyWHZjdldERGMzNGN5SnNFNkkrbXFaKzlIeVdDa08vQnVD?=
 =?utf-8?B?clIwTFBsUkZLbEhQdlVucjlwei9aSlhsalhVZ3prU2NHSWNWYU5wU3hkN21t?=
 =?utf-8?B?UWt0ODNtUVc3blRqUC9Xbi83bytHSmhyUWkyNlhmRjVJOW5xaVJIcWZUbFBS?=
 =?utf-8?B?ODBlRVVSM0Q0ZzV1cE5OYlMxVFNucnlRbUdqVUhkV1RoN3FSYmM0TG9rQXd3?=
 =?utf-8?B?UDJFRUNtazVNdjJLSStUTjlqVDhEOUdaOW1NT3hTUkNZY1V4dE1sazhQMW5k?=
 =?utf-8?B?TWtML0xyMWpJVjhQdVhqVzh2UzN2TWR1dmZzM3hvd2JNbDFiQnNwN1ZYZ21X?=
 =?utf-8?B?eFdpYXRuRE1SbURDbEJuL3ArY09hNVBFWDl0SjRjSlpZczFHQis0VytiVHRT?=
 =?utf-8?B?bWFJdmhJekF4RlhQcjhjby9NZkFkMnJqdGhBT2xlTWJtZ2kxcXczMXpQcFVs?=
 =?utf-8?B?N3RqTHJ5NndHZkxpZ2xuVFNGSzlGQzBJVTEwVTZRUWJRUHVHbWVCcS9ndC9X?=
 =?utf-8?B?clQ3cGU2eUx3WnBNUUxPa2RabWFuWTBRWWY3RFBvRWhya2ZkbkhRWDNmdHJ4?=
 =?utf-8?B?cHd2aCtiTnV5VmhrNTlObTR3Qk84bjlYZUtLSUN5WUlhNDBNQkJFcTN6Sko1?=
 =?utf-8?B?bWk3bnFzUGw1aDFvWG9XUlVOWXQ1WlpwdmJzTDRHeENvRDl4NS9ySU1EWENH?=
 =?utf-8?B?dGdndnRFalhOOE1VVTQ2UnZ0VVg2Z2IzY3NLcU1XeTdpdHJxeXN5Wm1BQ1dM?=
 =?utf-8?B?cmJLbU5peGgzdFZNa3p2V29GS1JyU3dnbkpzTVFIcE9WSWl6N3VYTUdlK1Er?=
 =?utf-8?B?RC9vYUpRQ2VrbnZabWpPbXdWelo4bG9kREpxVTk3eDUvNkR4bUhoNmQ3akk2?=
 =?utf-8?B?K0xuMjNHb2RqMjZlbEtpZ2FSMmlzZ0FYVStHcENyVzlTNW9SQmtpQ3haMUF3?=
 =?utf-8?B?dFROOXFmd24ra3JQWmxldUgxTUtPeDU3azVabDNBR1RDcWQyODlxcGVqbG5x?=
 =?utf-8?B?QzcrbHhvVUlnckFJNjZrb1VRWUx1cTExWHdQVmNhU2dqZmFhZzdMZ290K0Rt?=
 =?utf-8?B?ckc4YjdTWkVweDNCbnZldWFtQ0JUNFFxRUVmaHd5ZlAxai94NWZUQmhQaStV?=
 =?utf-8?B?aVp6UEdoR1cwemhSRGwxSjJuNng5YWxpaWdDU2JmaVNhWDdWM0dEbzA5dXVL?=
 =?utf-8?B?Mmx5ODhVM3paR0crdTNEd2Y3TERsUzBQeHIvUVNUT0IwbGFtbC9JSW11WXAr?=
 =?utf-8?B?NzVrZG9EeEwwUHRaRWJkd081bmwvdEJRdlhtV0tMNEx4NU5BeW13VVR0Z2lZ?=
 =?utf-8?B?bTJXZ1lPSzBVaDE5RlV4dkF2alhiRFhpdldVd3luTDZyZHVFMGl5b1pMWUFU?=
 =?utf-8?B?RDUwdkFCd1JhU0tQcU5BdWNnZ3NnOHYvRGJ0ZHlPay8ydE03SERTdFg2bUpJ?=
 =?utf-8?B?U2hWVEM0VEpRZzQ3SzhoOHk4OUxTSThRSThoZTZvaWtXcEZmanNvRWx3cjR4?=
 =?utf-8?B?cHB3clA2ZXNGT3hzeWVuMUorMWhqTC96NTRMVTF0bGF5NzdRVjM2UGMzMFhZ?=
 =?utf-8?B?ZE5XYjBtQVFQY2ZUZGcyVGh3Y1Urbm1jc3VSUjB3N3BObEtQVjlpZ2k5Y1VC?=
 =?utf-8?B?NndPMWlWejh4aTExU1RHSkhZNnFNalNoSWZRRXpuOEN5blc5U0k1S29PTUs3?=
 =?utf-8?B?c2VLZlRGRjBXaHN1NTY1RTVaQmVLVVFNdjRtYlZIRjZoUnUzdm1lYVY5ZXdP?=
 =?utf-8?B?VjVScHMwWlBMN29KdXQrVy92Sko0eVkxcUFzYUJjVzNtL3NpeE45RENVd2Rq?=
 =?utf-8?B?VTFQa0FwdERvUWdKYzFHSmh2YmZqR3BmKzZ6S3plUFVOSkNtQlRVQWpmbXZB?=
 =?utf-8?B?SlMyZzluSE5CZTFuYjg2dkNEOE15RzNydGg0SkEyODZBZWhRR284Q2RqbTBN?=
 =?utf-8?B?dG9mck1VaTN2SC9JOWp3L1YwNzY3NEY0aFRUdXNFV1BwUjNrNHpVTXpFVUpi?=
 =?utf-8?B?d1o1YXNBM0JLajJmc0dob2pBRUNiZS90c2ltTytsN1hFSXBPNEU2cVRkYWVV?=
 =?utf-8?B?OFhFd1R3Q1dGVGh6OEhCQ2tNODVsM05CNnFGbVZucHpaWkZ2WC9UR2lLSWVo?=
 =?utf-8?B?Q2JtZ3E3ZnZGazJQTldUSTJPNlVGOXJoZmRjY2tyWkMzQktJREJZSzBiM1p6?=
 =?utf-8?Q?ao1JgpXdwBM26T945CAnSgCl12XwUozT2ecjBLhZqk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d980901-88c1-4edd-dd11-08d9fe01e495
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 17:10:33.6365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JiAJolrHn+O9/lO8CuD9W7IefrXCFN0bNPUdRuLXTH0cqeHcF4WCShz2G4mWFfyyj96v+ZqtHEoS8axZz1Mkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-03 03:23, Christian König wrote:
> Allows submitting jobs as gang which needs to run on multiple
> engines at the same time.
>
> Basic idea is that we have a global gang submit fence representing when the
> gang leader is finally pushed to run on the hardware last.
>
> Jobs submitted as gang are never re-submitted in case of a GPU reset since this
> won't work and will just deadlock the hardware immediately again.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
>   4 files changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7f447ed7a67f..a664d43d7502 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -852,6 +852,7 @@ struct amdgpu_device {
>   	u64				fence_context;
>   	unsigned			num_rings;
>   	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
> +	struct dma_fence __rcu		*gang_submit;
>   	bool				ib_pool_ready;
>   	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
>   	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
> @@ -1233,6 +1234,8 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   		struct amdgpu_ring *ring);
>   
>   void amdgpu_device_halt(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +					    struct dma_fence *gang);
>   
>   /* atpx handler */
>   #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d78141e2c509..a116b8c08827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3512,6 +3512,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	adev->gmc.gart_size = 512 * 1024 * 1024;
>   	adev->accel_working = false;
>   	adev->num_rings = 0;
> +	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>   	adev->mman.buffer_funcs = NULL;
>   	adev->mman.buffer_funcs_ring = NULL;
>   	adev->vm_manager.vm_pte_funcs = NULL;
> @@ -3989,6 +3990,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	release_firmware(adev->firmware.gpu_info_fw);
>   	adev->firmware.gpu_info_fw = NULL;
>   	adev->accel_working = false;
> +	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
>   
>   	amdgpu_reset_fini(adev);
>   
> @@ -5744,3 +5746,35 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>   	pci_disable_device(pdev);
>   	pci_wait_for_pending_transaction(pdev);
>   }
> +
> +/**
> + * amdgpu_device_switch_gang - switch to a new gang
> + * @adev: amdgpu_device pointer
> + * @gang: the gang to switch to
> + *
> + * Try to switch to a new gang or return a reference to the current gang if that
> + * isn't possible.
> + * Returns: Either NULL if we switched correctly or a reference to the existing
> + * gang.
> + */
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +					    struct dma_fence *gang)
> +{
> +	struct dma_fence *old = NULL;
> +
> +	do {
> +		dma_fence_put(old);
> +		old = dma_fence_get_rcu_safe(&adev->gang_submit);
> +
> +		if (old == gang)
> +			break;
> +
> +		if (!dma_fence_is_signaled(old))
> +			return old;
> +
> +	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
> +			 old, gang) != old);
> +
> +	dma_fence_put(old);
> +	return NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e07ceae36a5c..059e11c7898c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -169,11 +169,29 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   		kfree(job);
>   }
>   
> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> +				struct amdgpu_job *leader)
> +{
> +	struct dma_fence *fence = &leader->base.s_fence->scheduled;
> +
> +	WARN_ON(job->gang_submit);
> +
> +	/*
> +	 * Don't add a reference when we are the gang leader to avoid circle
> +	 * dependency.
> +	 */
> +	if (job != leader)
> +		dma_fence_get(fence);
> +	job->gang_submit = fence;
> +}
> +
>   void amdgpu_job_free(struct amdgpu_job *job)
>   {
>   	amdgpu_job_free_resources(job);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> +	if (job->gang_submit != &job->base.s_fence->scheduled)
> +		dma_fence_put(job->gang_submit);
>   
>   	/* only put the hw fence if has embedded fence */
>   	if (job->hw_fence.ops != NULL)
> @@ -247,12 +265,16 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>   		fence = amdgpu_sync_get_fence(&job->sync);
>   	}
>   
> +	if (!fence && !job->gang_submit)
> +		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
> +


Why job->gang_submit should be NULL in the check above ? Don't you want 
to switch to an actual new gang fence here ?
Jobs that don't have gang_submit fence set are not gang jobs anyway and 
we don't care for this dependency
for them right ?

Andrey


>   	return fence;
>   }
>   
>   static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
> +	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence = NULL, *finished;
>   	struct amdgpu_job *job;
>   	int r = 0;
> @@ -264,8 +286,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   
>   	trace_amdgpu_sched_run_job(job);
>   
> -	if (job->vram_lost_counter != atomic_read(&ring->adev->vram_lost_counter))
> -		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
> +	/* Skip job if VRAM is lost and never resubmit gangs */
> +	if (job->vram_lost_counter != atomic_read(&adev->vram_lost_counter) ||
> +	    (job->job_run_counter && job->gang_submit))
> +		dma_fence_set_error(finished, -ECANCELED);
>   
>   	if (finished->error < 0) {
>   		DRM_INFO("Skip scheduling IBs!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 0bab8fe0d419..615328130615 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -51,6 +51,7 @@ struct amdgpu_job {
>   	struct amdgpu_sync	sched_sync;
>   	struct dma_fence	hw_fence;
>   	struct dma_fence	*external_hw_fence;
> +	struct dma_fence	*gang_submit;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
>   	bool                    vm_needs_flush;
> @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
>   			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>   void amdgpu_job_free_resources(struct amdgpu_job *job);
> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> +				struct amdgpu_job *leader);
>   void amdgpu_job_free(struct amdgpu_job *job);
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   		      void *owner, struct dma_fence **f);
