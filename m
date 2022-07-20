Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E99DC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 23:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10D818B0B0;
	Wed, 20 Jul 2022 23:18:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73AD18B0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 23:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0m2SoWEvVPHTzpsTllDQbtRpliX/nNL9OE45NDtYRNBxyczfOC6yoyQ/B3M6cqisxrFHmBmBt1p75DyA/kCSG3829wm8dJE8VcRCJCag55RuDX4sCh0qRXRAh4I5r8R9ovdSln8fa3rET0I5E1ryiIhVaWRUgRkeyrHrKy+bAdaNlC3XT+uK9KLtG0i6lB5JeYsAW5TEkOqwBZxVhYh3Yor093MWP8P2yW+MFpIQjY1xPaLIW9q9Jyu4Y/c9bevjChvQjfPVLIZbx5956a07L2TGS0H3EBdVOk5SyTDcWef5o2hzttdO40/nifCsRrJ3Yuv6pzqM67FuOnKe7wL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoL7ULdA0ZpLLBRFVX+FyFAcAFeTg5NSqVH9QGNdmhI=;
 b=k4HRs9KZEvEXMSneQAhUTIAdfrhj+WuG7PR4KZomqwdHHL83jqbR66r3TLPuMTPeGsWhUH/zmbibW2OD1ikBtY1By1V4LVXSCw8TVJK/JntlBs3rWa6BIFz2CfkG3WZdyzd8QZszA4m/BJ/GDuwC/kwCT1kf0fqI1QOyczvw0d9/NQoj5NF/CXlCZ/9Grpmf4f1Q9ySoHUDEYdR+RNk1pQBAisdsqCTQMOUnUFY8v7hxNdRzsVqZMCDjJB3PrLdC4/XWc9GlI6ZTWJNoTwWR1K+l56hm/xx4JA8UI1sl63MXx8+3vhngc4f8ma0jGGDkqeh5m7vOTFecx2CtXvcFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoL7ULdA0ZpLLBRFVX+FyFAcAFeTg5NSqVH9QGNdmhI=;
 b=lH6NQSdogWvKURvccoza83Sl5OMPONo+9yEewXRBZ+Vd4ECYgrAwXf6B6BzU4BrIBAnrHKmaYvo7U7CQbKNSUjMVOhwsY3Z3Y/agBkdH5/sQPbUA+N7a3RTpMZoYIsnm3t8JetkdtVzd5nbyIp6oeCcykryISVyqT7SWIQCmNqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR12MB1316.namprd12.prod.outlook.com (2603:10b6:404:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 23:18:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 23:18:26 +0000
Message-ID: <e421b561-217b-b4ed-9d8e-a56390734c26@amd.com>
Date: Wed, 20 Jul 2022 19:18:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Refactor code to handle non coherent and
 uncached
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220718225227.17382-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220718225227.17382-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff4e964-58d8-4fed-8fee-08da6aa62649
X-MS-TrafficTypeDiagnostic: BN6PR12MB1316:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vX70VwK2dNyDF1WhSTDr3cUdXRqd7CIZV/xMSyaFnxXkrQ6mKOieSyERu5OdI2j0MVHalaFiq8e8drdBqsJPIo6yhyeId+O38Y4WC5dmmNfefJq8XkZ3dV1KB1XnBjI7FxLEjO/k7qIZJWtMprBXBwYE8L6Qd4JAbuoVpxrGMefPoI8SR40/9gLfSbDU0b0zZ7DZF7QRCA16Fx80z9byX2U3xReEQuMroIeJZBq7UeKXH+gzNFBSh+Zb2+CZ/hrhWyNrKwe+EYoAXydytvhDkTkLFv9kiQXncTtVchXy9UoE7x7sokh1WRaEWSIc0M77RUAFaJ7xsu6NBf9s+zc2AVI4bjFoS1KColSCbq0ghVhgwr3St1S0wFx+n+MTwZQTX6EkL0x+uiCqSQkbKtzkqq4mRdElVaSH/kMtpwVm4JC/+rhdLJfDnoJljXnDpE6E7cUwszHBJLE841VzCN87LDEUYP84DLxZovYo6O2cW35mp8mV/GkAatPQ/Zaki8wOx62gvCBHK1gGEUcbwD7N2Da0JpDbMOjGdFeXNmMDOb4hwbM+BIeKU6AZUdxP9W1e8zX0c4wZrRTU9AWbrjBf5d/CpPqsQdfDoJ0S9tGIRN134SeQQRzCTTPQAEpmtXdeIk4bvKFoqcbHrl88ZDu9y1JbsMOoU4cOt6tbNBotEqzN40GinTCz89jYwfvQBudYBqXTTeVP3rpuFn6j34CV5Fq051sXabxHwFLH7CWMaCMbUcA93bfBgw7FSJ1L4RFcJQyBIkpEeTmgrHdhYW5Ec+QTI4gH3C2ghpTPNy/cDkeGZ/+3MKCSZHxlktp4a1VPKtZ2z5OPFtJpoBmST/3oDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(83380400001)(6506007)(53546011)(36916002)(8676002)(66476007)(66556008)(66946007)(2906002)(41300700001)(26005)(6512007)(86362001)(31696002)(31686004)(36756003)(54906003)(2616005)(186003)(316002)(44832011)(5660300002)(8936002)(4326008)(478600001)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDhmR050QThUanFhZ0lHUHVMMGkyVjJTUU9PRXpXRTFxYnE0SlRKZUlHOUl1?=
 =?utf-8?B?bDZhOXdQdE1mRkM0aW42QWZWRjZyNlRzZEpjcmFyVlhEeTg2dVl3MGxrQTVX?=
 =?utf-8?B?YnU1UTJlUkNLT1FhQzJBMk9XU0FYMStBQUUwN3ZjUXVBbUlKMzJCdXhKZWhO?=
 =?utf-8?B?V01aeDh6SVhMalRrT3FhR2c4NHBaVlRvaEVsVTgyTWsxTUIzZ3NmWkl6YWtu?=
 =?utf-8?B?Q2VRbmxEOCszejEyVHh3VmR0UU1BUXFra2tCSXA0RWhsSmh3dncxbHJaTXJT?=
 =?utf-8?B?Q3lqUVdsWU83RkFzd1FydnN6OThudjUvUDZlRHcyelRSU2VpamMrK3E1SmUz?=
 =?utf-8?B?OUZJM2hBT0hIS1JhVXdUN2tOV0tST0s5bFVxWlFIL3dIVkNoeGxkNlRpZXhh?=
 =?utf-8?B?QS9CUC9FcWlEKzZ0d01yTjhXM1R4K1dvNXJEK0I5dzRKKzZ1RnRTckZVN2N3?=
 =?utf-8?B?cWNTUHphLzErVkJ6N3c4U2FJU1E5b2VmSFZSVWl6SW1YOUxSL0xWVkNtTzAx?=
 =?utf-8?B?Y3k2aEZvYlI4SDFPYWF5Z2F4MFlLaHd3U3kxdERmV3FhaE5mZXUyWHVLby9x?=
 =?utf-8?B?ODFLd1hvVVdxbU1TcElJMW5WTTlVbFU4TDI1bVdHcllCcDhpV05pbWNOM05H?=
 =?utf-8?B?eEpibXEzQitHVmRBVlVOV2xkSmhjNHE1d3VseEptbHFlaVZ5cHY3K0F2WGtN?=
 =?utf-8?B?SVNOTEFld0s0eVNLZUNyZThrbVQ4dnJQaDV3cWs0ZXFwOXRkVzNWMGZlbkov?=
 =?utf-8?B?VGVVbE1qc1piTWxmZXBVNTJZd1NXczNGaXk1OUIvVVhvdmx0NXdyYnlXNWhh?=
 =?utf-8?B?bGdJWEJRUWRiVzdYSW14UnNJS1BHVmh4OHZWRFgyRzFXQVpRbzlsbCtyZU1T?=
 =?utf-8?B?ZERqT2k4UDc0L0kwWWswZ1IrSmI4dEw5cFp2cDlmbUJxRUxSR2RKbU5TTXJt?=
 =?utf-8?B?OTJlTFBMaW9WaTVPUno0cUFSc1RpZU5WUnAvRG1pa3dzYXZzWHp1NHA5bGo0?=
 =?utf-8?B?S0hSbU9Wb3puZW9tTHRpSjZtSk80REY5ZTBKcjN2MHJOOVRaaG5iejdPeFB6?=
 =?utf-8?B?V0Y4aDhjZkpDamlMRlVYbi9EMGtRcGV0T2IwaEJ1NW1XRFB5NHZLRjJjRWhV?=
 =?utf-8?B?SE1jblM5b0hNUFdsYmlQeU56bnVmeHhNMkZDUGloekVqVjRoSzJLTUNkeDNY?=
 =?utf-8?B?S3dDcEx5L3AxZSs2SlJWWGNwTFRlS3E3RUVrV3VWRDVtWVRQSjh1RTVQVXBR?=
 =?utf-8?B?N2k2azVNb0Z0dFp6SFpaSXVMT2NaRC9ydzMyVFdJbmFPYytNRlZrQjlSN1BC?=
 =?utf-8?B?cldleUtZb2I1b3JQQTMvT1d2YjZlaGtKTVVMWUxxQ1RlSXAveG83K1YzK2Zz?=
 =?utf-8?B?MHZSSXU4bW01RWlmZVVVSVpUcXpubDFsbXNRMzhQZDA0ZDlrc3RTamJTUXVZ?=
 =?utf-8?B?MnBNTW1HdTBqN0pMdENaT3ZSanIwTWsveTV6QlloQTYxVG9KalFSVUI2My95?=
 =?utf-8?B?ZU9IOVowcGRWMGdKdzJ5K3FCWWEyVW9IT1Y3NGdMeHBwZWFsRWRYckJKL25w?=
 =?utf-8?B?Z2ErSHhmS1RHWXdFUllKQit6STdtc2doUFN6dUMwdWREY09GNnU4RFJ5VGdr?=
 =?utf-8?B?RTJ5YjhTcDZvdHlCSm1aOTNVeGpYVnY0Njk1a3JrVUZabVB4SjdkUWhOb3Zl?=
 =?utf-8?B?djQ0QitzRkQ5N2laeWpnSndEa2lJM1BBWHM1VE4rNWpIdWJRU3ZUNWc4dFc2?=
 =?utf-8?B?Y0I5VXR5SDVRWW5PZmpKaGJGYTRRaXBmOVVJbjFrTVcxaDN5Uy9sNjllUWV5?=
 =?utf-8?B?bTBQbTJlS1pwZjNJUjlvdlZDbmRlcTNUdHVuZksxUld2dFAyK2kxa3Nyclh5?=
 =?utf-8?B?ZHFGd1NEYzhuYVRSWDhCN01OTU1vdkVoV0R6NUMrbjJWSDFyZFJNa25BL2Y0?=
 =?utf-8?B?S0V4S3FJNTJOMDZLRXBYSjZoODd4cEZHeUJSUTVhSWVqR0hkUGUxa2xXZkJF?=
 =?utf-8?B?Y0ZRZEJqM3VSTm5INHNKWElQeUZnWGZrcDZTNmFFSTlhYkw0L0dNQnBReGcw?=
 =?utf-8?B?THdwekE4akhvVDJkRFZ3WXZrU1ZnSkcvMUlzWXBLR1A5TXFaNDh3VzAxMzd6?=
 =?utf-8?Q?VY668O+xYYmtzYbZofNG/Cr5d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff4e964-58d8-4fed-8fee-08da6aa62649
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 23:18:26.7223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv9HckGc06FxXC1Orojv5qA9Alv/VseK7TM31VDutH5cZ0bj17SB2+9NpBB72urtO13kjy17vl7drMUu92mQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1316
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
Cc: Amber.Lin@amd.com, Alex Deucher <Alexander.Deucher@amd.com>,
 Joseph Greathouse <joseph.greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-18 18:52, Rajneesh Bhardwaj wrote:
> This simplifies existing coherence handling for Arcturus and Aldabaran
> to account for !coherent && uncached scenarios.
>
> Cc: Joseph Greathouse <joseph.greathouse@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 53 +++++++++----------
>   1 file changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d1657de5f875..0fdfd79f69ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -471,45 +471,44 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   
>   	switch (adev->asic_type) {
>   	case CHIP_ARCTURUS:
> -		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -			if (bo_adev == adev)
> -				mapping_flags |= coherent ?
> -					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> -			else
> -				mapping_flags |= coherent ?
> -					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> -		} else {
> -			mapping_flags |= coherent ?
> -				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> -		}
> -		break;
>   	case CHIP_ALDEBARAN:
> -		if (coherent && uncached) {
> -			if (adev->gmc.xgmi.connected_to_cpu ||
> -				!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
> -				snoop = true;
> -			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -		} else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   			if (bo_adev == adev) {
> -				mapping_flags |= coherent ?
> -					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> -				if (adev->gmc.xgmi.connected_to_cpu)
> +				if (uncached)
> +					mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +				else if (coherent)
> +					mapping_flags |= AMDGPU_VM_MTYPE_CC;
> +				else
> +					mapping_flags |= AMDGPU_VM_MTYPE_RW;
> +				if (adev->asic_type == CHIP_ALDEBARAN &&
> +				    adev->gmc.xgmi.connected_to_cpu)
>   					snoop = true;
>   			} else {
> -				mapping_flags |= coherent ?
> -					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +				if (uncached || coherent)
> +					mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +				else
> +					mapping_flags |= AMDGPU_VM_MTYPE_NC;
>   				if (amdgpu_xgmi_same_hive(adev, bo_adev))
>   					snoop = true;
>   			}
>   		} else {
> +			if (uncached || coherent)
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +			else
> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
>   			snoop = true;
> -			mapping_flags |= coherent ?
> -				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>   		}
>   		break;
>   	default:
> -		mapping_flags |= coherent ?
> -			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		if (uncached || coherent)
> +			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +		else
> +			mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +
> +		if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
> +			snoop = true;
> +
> +

With the two extra blank lines removed, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Please check whether a similar cleanup can be made in 
svm_range_get_pte_flags, or maybe even, whether common code can be 
factored out of those two functions.

Regards,
   Felix


>   	}
>   
>   	pte_flags = amdgpu_gem_va_map_flags(adev, mapping_flags);
