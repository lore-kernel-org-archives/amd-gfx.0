Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A911CD37B9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 11:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02E110E173;
	Mon, 11 May 2026 11:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpq3yc7w";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A312910E173
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 11:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D68Q2hFpmdWDBZs0F47wXzkVmJId+grkxkAS79LAoRgZl96YNQgJ+smw2IHs1/CPpfOIYjEpAlG4eS/nPYKIIsq2YKZEiqo6c8Ms0rYS3MmRML1ppXrkRE2ge6f39HjlOnTR/7JwL9TkGl9x1rPl6U/W2KzxC7oUz1Ourw/D11eszaBy+sHvGWbQST/cyn8VsLlaHoAbVfOkRLtlcLbAvcfCp3d97LbCP+c5mm33cjyVfo6ghG+bnV+QRtCNb9vdRcVWTrKRIWRcwEFDbRatl+EozcLm5YcLvr1KZpDUw3+SLY7DqzLFpMGuenfr49FFJ5TV1nFQrnJyj73ugISmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd2rceu2LDtthQj43yRVON9WUxjeJwhRtWQVI3llyHo=;
 b=fghW6qWSv0KRRk8jHZbjYhnIwWZtMR+69MzpKdfvCBi4D4bBAmvAMiy5oiC2dVCGrzQBoQ8fdF9qlrnSbgzrvq1J4zQEasP3IAe7FYasrJLp75bv55ZYO1BYMIx5+4F7YEM8mvqfMUZvcLfdNqqtTPkXWD+Ha0itD1+GwQN83ksZa2ByOmP/aqgQLPShzQbulnKYf8WfXRCiLxnN5/mLo7bu3+jjlLzrOj1Bufe97iTtNdGlJEa+wBVNdvbOKqzBaxLBbrj2da11U6PUUP9pxlHNGm3l+njZWIbqjAR6vqJII9ZHo0NNvsaUEek3kF8ZRcnvnPlWTH/gdYM6s6GmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd2rceu2LDtthQj43yRVON9WUxjeJwhRtWQVI3llyHo=;
 b=qpq3yc7wcpi8K/bNYgjiAecvGLQs0Gx1Wdn6qEPuLiZAMnurm9r6abMn3Ul+w8+ElblUZJRrquNyXV99lFQOqsVEWPB0XUVq7XdEJlBbi435ot+9v/cvKGjm6triL3eotM72WyjCTRJqoK2LZ2pObWLDSco3XslMU94XKqkroAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 11:31:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 11:31:39 +0000
Message-ID: <16837ea4-4501-4727-811b-430d50fc7b87@amd.com>
Date: Mon, 11 May 2026 13:31:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: kfd vmid should start after vmid for
 gfx userqueues end
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260511091326.3111950-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260511091326.3111950-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f6e196-9985-4845-3740-08deaf50de60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799002|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ITYmGofP0OKIP8bB5CNVsim1U4mPTdIw9uYavMd31bwWGlrrmJgmfOImHdjk/xYMB0jneohjDZBzYL2DurGXOe4XQSUKYwpUBNZ9mNJCM86Mh9XiRuNxNX6cN1NdDdG3OMeDT9zbnE2+yTq49mD9N1b4JOKg6RLvAvXYOQB8D5W9rf/F/83MbF86PeNTIzloPhAJZzMLsxL5AmL8ljdBrukH/nwf4SFqDSQ7pIPZAjvjOLpgVPTjPEq/reC4450GN0EK9aGLKWe8agvmAyDjGIyW1e0C6ogorYxck3SCQudNkoWYefLUZf5jCaS6gfGd5iszlKRNR4eh3B9gmFnwb0C9RWeN6Sue8+IQHCiX9waIVnFmPK+kskN7BYQ8IGonHz5qnU4zH7wtHdMYGyxVeP84VhTw1aEAfPocCa3I4cT+z2A+JmGouI9i1OcTnHJFGVcj25+zObW5HA+xgzkJjYePKpO/PYHQWIU2hx0ITV/fJAq8CoTvOgv9fLU/zjl7aw9TjNgeEY7FS9tFS0u34bS5BVmdnQXAcMu/10dA+vadho/s8CE0A4Y0atWhV1v33OxhGUFM6iwyYMw4n4BQBeiQsyPjVpOZYMmEPOkzdWnSPVi0UlxYbcauCgAb/DE4TPwcBOBzja96ZXslvhD8zAZ0BngI0I4kwF3ihioiCC3Zg67aB6YxPa9oJjx8Z/tn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799002)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJ3bDBkVlBmUkJQeTBSY1I3TTlXNG90aWJ3U3JreU5nOTFEU2lHS2N4cnpB?=
 =?utf-8?B?R3R3R0lldWZjOHhtRkxBSjQ5bzBWWUNITUJlZTVBUE9CSEJOaTQ3MUFYZW1z?=
 =?utf-8?B?UWhMMHRLVHg5VmZwYXVKWGxMNlEyVVRWdHN0ZmZTSVhaeDdGNHZFUFc2NEFL?=
 =?utf-8?B?akdrL3lmOUE3ekoyT014Z1dQTjNodUNDMEdKV3UwQWQzczdqcXVxZG1YdUlj?=
 =?utf-8?B?ZkVVMFZia2t1dnlPU3NKTXk4dDZBNXpHb3FwZ1NUZDFxR29ibFoydnEweHp6?=
 =?utf-8?B?T0xMcUZSY3ViYVltc1BvQXM2YzNrYzdqamU2Y0UxUG9VTjd3QlVNclF0eUh6?=
 =?utf-8?B?YXpScUpQUTZmRjl3aWEzZzBTd2dYVS9neDh4OFM0RTBJNUlqTDlVMzhYWlhX?=
 =?utf-8?B?UWZROC94R3BlOHdOQnB2YlpSbU5ZZlV5bnI4VUViL0VsbHc1S0J6RE03UVBC?=
 =?utf-8?B?ZjdCRHNoSG5PbW0rS29TWmpsZ0h2Z0MzSkxnKzN5VkljdWZvN2o5bkd2QzB0?=
 =?utf-8?B?eGxUVGJobVVhc0RXZjJtNW9vdlRsbTFNWXc3YlVMRTNzbWV2b2MrQkhnV01H?=
 =?utf-8?B?amZYbys0Z2JWV01iaXdjTlM2cU5uMFhxTzZjeUdMSVYyQXdjUlFUZnErSzhV?=
 =?utf-8?B?Z3htWHJtN2hwNC9qNHUydllKMmRDai9aVThDSUFlSWNzdlBzZy9Ec3RyR3lC?=
 =?utf-8?B?eXpZQTRqSnU2cTMzZjcxbXVNOVZPWmpGTm9BSmFCVXBTbzJVUGFJOEs5UE5N?=
 =?utf-8?B?UnpPc3ZVeEhBK1B0WnZJSnFReEJJL1lES0UzR2FQNXlYOHlOcTkyN0VDK2xT?=
 =?utf-8?B?eXd4ZTJaYjVrbDVKSFgycFBvS1c5Q0pGeE9YV0JoK3FmMEFuUktGRy9zNStV?=
 =?utf-8?B?cTZvNkRUYk1zbjY0RTFESmhucXFqUFRVZWFva21RRkUxMXRkRmQreWxscitv?=
 =?utf-8?B?VE8vMzFUa3N5b0x0c25mUDAyd2dOaUZwcTVHUlJTN0svME40MG9HNXdMUi9Z?=
 =?utf-8?B?dXNaRVlzT2VwVGd3UnBCTTNNekFGRTY3R1pKS3VicThmbzJMMnVoT0J0Viti?=
 =?utf-8?B?UmxBclhMQ09Galcyem43SnhRdmFuWmZ5Tk5EanprZkxta0dxVmpzdlVqdDFw?=
 =?utf-8?B?UVh2czZEVU13TSs0R2JxV3ZYdW5iaEU0Zk1jWVhxTHZCK1phNjF5VE9TeDVN?=
 =?utf-8?B?WVptdit5alBJdTVBTHVZdzBkSGNnRk93L0NiWXlJWTg1YUpHbVZlUTZXby8v?=
 =?utf-8?B?S1BNRDl3QzhqOTFRYlVLUEFFT1dXYnVTdDJkYWplRkUvaXY1VlB0bHFJQXor?=
 =?utf-8?B?ZmdHeWxTT0s0TjVQM1hFcEoxTXRpOHdvZU9HNkRSN0UzaGlXZ01DcWx4eGp4?=
 =?utf-8?B?YWNiTmo0NVJxVDhWZ0FRVmxCVzIzNm8wL2gyZWZHRFpEbExySi9adWl5RjRh?=
 =?utf-8?B?QTFiYVE1L0FlbEFjRVFnQTZhTlU1TU1aZ2JkOGVBbVJGR2xDS2VIdm80aHMv?=
 =?utf-8?B?SVJacTVPT2RwNVBOeWFkWGRzZm9qZFFQakg1aXZrUGg5b2JqU25GaFE0aVRt?=
 =?utf-8?B?QlNYMVdlR0hxYXVJTFI3bzYyYTQ3SGIzempUc0dSRGJmUisva3p0KzN5NVFo?=
 =?utf-8?B?ekluY1F2NmJtMzM2MGxTaG9GbER2VTJFaTNWM1lOcWhKdzhzRFgvS0RxU1V1?=
 =?utf-8?B?R2oxM3NnRkV2WUp4V3cwem1nRjdTK3FBZ1ZNTUI0OXpRNm5NWFNSQ3dpS0FJ?=
 =?utf-8?B?MzRnTHhMUzR0NWNMQ3ZWcWhiMEtraXlYRytSZVdUWjQ0QkhjRnYrNzE3WlNR?=
 =?utf-8?B?N3Z4a1E5TnRERmg3T2VCZE4yL0hySFZhNC9BVlBVVnVqVGMydld1UkJwUlRJ?=
 =?utf-8?B?aDgwWUZhVlZFYnk2ek1qbTdQbEM0R2wzSHpRcXhjQTlSQW9qWDNqQkR5dlI1?=
 =?utf-8?B?MVNUbTdQQ0RxQ3ptTHpncFhaSzdvV2tickhEcXI2ZGd1UDdDL3o0RTRPMjN1?=
 =?utf-8?B?Zi81K002ZmpLcXJDTTJIa2RHZUVuRmJrQmxGYy9CSy85Q1FCcHlpb2R0MVQy?=
 =?utf-8?B?UFBHdVZrN2dMRzVhRTZtbjRydEY4RlJDUGJVU3dVZDRvV0wzalppVHpqT3N4?=
 =?utf-8?B?M2Zjb0xvNHQ5ckNSSDNqNFM2dTF5SW9DTVVJTXVzMi96cFlCbUhDcno3WXJJ?=
 =?utf-8?B?UHFRSkw2L2ZuZUtTUll2aG1wVE9RUDQ2S1IxRFNRQjgrZzlFTG5UdUllZTEw?=
 =?utf-8?B?Uy8zN3dFTnIzUTA1VU9LbW1NYVowSkwxbDROT0VtQnByc2RlLzg5eTZ3SE5q?=
 =?utf-8?Q?/z5VcyLCE8h3BwL1Jk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6e196-9985-4845-3740-08deaf50de60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:31:39.8410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG+BBrK20i1HrY31jD5Yax9mgFdCwTUDDkASgDCqUt2Th3YtEVJBajXQaSULdkDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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

On 5/11/26 11:13, Sunil Khatri wrote:
> For GMC11, when KGD userqueues are enabled we should have vmid for
> kfd queues start after KGD userqueues VMID ends.
> 
> Use the variable gfx.disable_uq instead of gfx_disable_kq to check
> if userqueues are enabled or not. For mode 1 even when kernel queue
> submission is enabled but userqueues is also enabled at same time.

Of hand that doesn't looks correct to me.

On GFX11 adev->vm_manager.first_kfd_vmid is the first VMID the MES will use and that should 8 when kq are enabled independent of the graphics userq feature.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 16388e3caea3..354cf1c1b93c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -846,7 +846,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
> +	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_uq ? 1 : 8;
>  
>  	amdgpu_vm_manager_init(adev);
>  

