Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194FDC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 15:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91F210E0E9;
	Fri, 10 Nov 2023 15:03:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5BF10E0E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iovqgQ2IbSc6J1aOsyc6u7hEifgnn2GdNMjFI6i43GA8ifs3fmn4ohX9grT9I3aHBjThdLqQVkivGGySGcyXFALOgEQsCxb6kjiJ4gYkgisBPAG/IWYicPQ95um/aLNC3hMo4GxsTWAnoJSKstv3F62rwpj9bJgosajmFDD8RvO1WZjhkqt80SXHCdKr5H4HeyCCdQxMREefg+2orosdatLp3j5paounqcdRmIMeFq1gqnbJNsG4f9cArGTQnBXV28glxh8HoIO2uBNSCo0crzx3wYKN52Zp5+7LYWO/wAXuRUBOgrmCAzUAiKt+ardZ9mLBTuQvNBBSYIGF088FmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dilQ7Hbdz1x1S+DYkjq2Clkj1xY/r1FGjC4b1bJ3//k=;
 b=AYmdXI2zDk0KcVuxaBooz5qFMxEpEkN7imBpOcAm/SU8zJ+wTrvwE0hSWZW/nRo/FA3iLelfSnpTExBMHpvQTBVPrWWXnfs5Mu5bD/jD93BB5xnyyO/qFkqLN+LuSWM0IyVS6yL4PjqWI4/32TLsGe3BvfsTXmSH1RtrLLcmwWiRP5cY9fby25jCcQTHx8nPFeaAdpwIaWX1PW3Oh4bZLIVwX+PEmnU7CdjtvRrNY2dTVdxh8E7nt2HzRDxyILo/n7aothRhtUzYw0yHJGLhVD2mxa4iHCmPpZNjXP9o78pRMv+MwuZPvVRHPrct5uWuzk15fnWsS608h4FP1TkpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dilQ7Hbdz1x1S+DYkjq2Clkj1xY/r1FGjC4b1bJ3//k=;
 b=nqYsk+sc8pJmsaqH8GYQHCJ++D8NVh74hx6IVWEa22yTIiYMisygXhsIzef+f2TwkYegSnhKam1vNzazFZMTLnbgmz1zLGJ7qxS3TnO13TOzrNRe89d/+u9rHVg0GpKZ6u+96sDRlBA8jtlFREJgvvTo7a+btDwKFhc/QkU+1/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 15:03:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 15:03:43 +0000
Message-ID: <95b9b67e-1a85-4de2-8c93-226075401c48@amd.com>
Date: Fri, 10 Nov 2023 16:03:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231110150206.1900871-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231110150206.1900871-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: d939102c-34b3-4187-bcb8-08dbe1fe3afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pKJFIUY387G8Rsdwimaz5AOsvA0Z1GHAIgPZghttt5xPf5ky+1VsID2WpuvEIOTxIF4oxNO0T+dck0otDSGNmcY+ncGzNEpBxuoJxTaklaqpRBFyWYGo8EZ1vc6lpaeCWuJRC7sM0+nAljyNU5Qbu3zLnlyWb4daYioPnE5+UCV8WzZtTE3Uvgpyl/UDV3zfFPNZ2mISoe3irXYiOU9hru1nWdYD7Zy9uY4cHd5DHIGOfjgZT0SHJQCtiu1hHmSHik8H1rK/tpRP206Bmxe2Qm6eKqHBy2tQuEvyW9tR5yYsj/nwN1nJIH/ZPuT0iaU5BaTwIFwkZovwE1Z3PQca/YrjDz4WhPuuGynooXEwPRGQqCPczeFgTHmDzme1GyjddNdVFG4VdNN73Z/mQU21s58WTWi3X1l87kPOC9XL16PjabclPlVipWqcYODz9qTf/Z7Cf5xljXEXb5rrGeOC3VzTVEiQKXgQU94EE3cSw5JeXVAgtkKJ0kY14WrgfRGIJCL1kTKj9elxe7D1LUGeuySJGq4ZUkZT+LUeo/0STuyXTCv55YrzXpUtsrLecJHPlsZq/HSzGCNVyDVmCPbTD1/S3i4Z0Prnio1TeWGR+SVZaoF7Rt3OfU26E1tDBjrqc5wzLg7VvDU9cvLLoMRqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(26005)(83380400001)(66946007)(6666004)(6506007)(478600001)(4326008)(6512007)(66556008)(66476007)(2906002)(8936002)(36756003)(41300700001)(8676002)(38100700002)(31696002)(5660300002)(86362001)(6486002)(316002)(54906003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC9SSXAxd1JxSFU2eU5UenBIbWNjS21Jd2tsay9BSFIxZG80ZmdiUmh6d2dR?=
 =?utf-8?B?SXQyc2k3RGJXTk5lYWkwTTVBby8vUC9TK0NEYllOcVVqenJSaVBpQ05Yblhm?=
 =?utf-8?B?N0hINDN3cXpib0s0NzN5VjhrenBnelFuR2xBR3dEYWM3cHZkdTlLelVPVEpt?=
 =?utf-8?B?VzQ1OEJXQWdVRzdNU0ZOT2daY0JCUnRSdWwwSS9DZ2F3WEthL0IycjRlMGJ2?=
 =?utf-8?B?Zmc0TFg3QkZ1UW1HOGJpTm13WkNxaXZwTE5MbzdXT3g3bUoyTTREQ0QxRHBJ?=
 =?utf-8?B?S2xOWmNPaDhPV2FIMWdoTG1wVng5c3J2QTlYZGdveEp0eDcyMG1SSVB5MW9Z?=
 =?utf-8?B?VUZET0RmL052czg3SzRIWFdOMzV4N0J2aUJhYVpLVm5hZ0lkdWFuWGRKNHp6?=
 =?utf-8?B?dUp3bTBvSmVlOEhrcll1eU1PL2p2eGVyVUVabkw1OHFpYktaaGNucVRLMTla?=
 =?utf-8?B?Vk9oMTBhekZLU1UrSHlzNXpERGtLUTd4LytkdndVNmlERVlLRGxJUGRqZzgr?=
 =?utf-8?B?c2NuNWtrQ2pTcmdWeGVXWUF0U1c4SGdHcHR2RHdRWjBCdGx5dVNaZGs3dlBD?=
 =?utf-8?B?UFlROThnNWJIeDdUanp0Y3dQVWZCcEFYQzdJYU96d3Y0c1RFdEVCSHJCbVFI?=
 =?utf-8?B?L2tNUS9uZXd5S21ncUo4Q1UrWWdHc0JyQmxXcjNZZERRazJ4dzNmRVh1eU0v?=
 =?utf-8?B?dlB4OXNFNENmdFYwd3R1VGNpTUZUL0UxL2YyUHdEMEhwODFmR3ZMSGlZcTVE?=
 =?utf-8?B?MjRPUWs1cWMvTDJjWmx4aVNGUDVuWmp0dFNMcm1QaDQ1bkNpSDlxOTlGV0Vp?=
 =?utf-8?B?RFZ5MEhoUHZsTzJxQ0prUUk5N0JycUpCbElQNDVYYUI2S3g5OXprL2pUODkv?=
 =?utf-8?B?SDJDdHZPZ3NHSVVnVVV5SXhlOFRtMnNPNTNxL3dlN3owT3BFT3hZcHhpdER5?=
 =?utf-8?B?d2dXQVJaWnExRDdpZUQ5U3U3Qi84anNLdkMrS2EyaEpuYlFTOThIMjJKQmJJ?=
 =?utf-8?B?SHVqYWxjVk1WZS9KRUtYdTU3WWJ0cTUvcXpLMjhjTkw2bU9CZkdNN3hXbzhn?=
 =?utf-8?B?cENkbWZBWUVrcUt5SzZReEYzNlRCVURFWTl6N2dkZkl4T2FIdDBZOG05bGE2?=
 =?utf-8?B?TnF4SE81bVhrSS9nYkhtOThLbFEvcklTQVJIQzUza1hiWklDUmZ3WlhRQURS?=
 =?utf-8?B?NVRMdTZwd1F4TXl3b2RMazZXaHh4cVh2RFVrNW92bE8zNzh5TTI1Q3hDRzl4?=
 =?utf-8?B?dWFqblZISVJ5d2hCTm40VDIyM0Y2WTZuLzNZalZZdFN4eWtmVkFlTTlJRWQ3?=
 =?utf-8?B?dXZmR2V2WTVhbU1kbXVrd041MXJaNHRadG1PSkVvbE9vdDRKdWxiVFlYYy9a?=
 =?utf-8?B?SzMyZGRraFgrVzllNXF4cU9CeU9tT2NyN3RGRGlxcjFtQ3drZ3FaMU1BVnhv?=
 =?utf-8?B?RTdMSVhxeHNBaUN0cG9Rb3B0Q3ljNmdlT09jSld0QTlST05FbGtqelRLL0Fa?=
 =?utf-8?B?LzdZUTNBcC9icGFQZE9JMFhpZ203LzNLVnRaZzkvSVZ0MURFZGRwZnpzeVFU?=
 =?utf-8?B?VkZuOGY2K1NpOHZLSkpCRXlKcmVvN3hmRzVZaUI2TkpQc0Q1S3k0ajViQUJM?=
 =?utf-8?B?VG5tTVEwdTE4b3o2TjdWbXFEMWJsY1FiSkQ2TzNFTDZQVW1TeDROam9meHNQ?=
 =?utf-8?B?eTI2UUJScGZsb2ZaeWtzc1B3dnpOR3ZIUkcwOEFWMEQrR1FXcUt1RGpBZ2pZ?=
 =?utf-8?B?RmNrY1ZkSG5MZzIzaWx6SnVWVXJNeHFpVWlGZDBzK2c2OU9MZjZHK2wxUkJY?=
 =?utf-8?B?M1BOMDZzNFk3M3VlOG8zbmovOVE5Y3VPZFdmNnJVTUtDMXNrNnBZY3hTKy8x?=
 =?utf-8?B?NHNpRkc0UlZEYUJwbEVkMmh4cFhCRDAzWWtyUlNCRkttQUtsbkY3djFYa08y?=
 =?utf-8?B?WVpjV25zVmZ0WTdseCtUU1BjSGZVM3duSFlEMlRPQ0I3ejZVQ0JreUYzZFZi?=
 =?utf-8?B?b08rbnlRUVVheERQRmgrRjlXWmtxYURXNFR1dlFheGpDNVhiWVYzY1NEYzBU?=
 =?utf-8?B?cVNsQi91ZU4vdXU4MnUzL3ZyRW9xRlF5cGJBOUNxTHA5Zncxa094ZTRpRHhJ?=
 =?utf-8?Q?CjjsZx9X823YEUdpm2shi357g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d939102c-34b3-4187-bcb8-08dbe1fe3afa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 15:03:43.2088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ANBUcbUMilRMX8Ed5VVqqjtOG/ZRd3uYC55tFxbKml/wH6TNV5a5hYs4YzdJlkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.11.23 um 16:02 schrieb Alex Deucher:
> This worked by luck if the GART aperture ended up at 0.  When
> we ended up moving GART on some chips, the GART aperture ended
> up offsetting the the AGP address since the resource->start is
> a GART offset, not an MC address.  Fix this by moving the AGP
> address setup into amdgpu_bo_gpu_offset_no_check().
>
> v2: check mem_type before checking agp
>
> Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: christian.koenig@amd.com

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
>   2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index cef920a93924..d79b4ca1ecfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	uint64_t offset;
> +	uint64_t offset = AMDGPU_BO_INVALID_OFFSET;
>   
> -	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> -		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> +	if (bo->tbo.resource->mem_type == TTM_PL_TT)
> +		offset = amdgpu_gmc_agp_addr(&bo->tbo);
> +
> +	if (offset == AMDGPU_BO_INVALID_OFFSET)
> +		offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> +			amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
>   
>   	return amdgpu_gmc_sign_extend(offset);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 05991c5c8ddb..ab4a762aed5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   		return 0;
>   
>   	addr = amdgpu_gmc_agp_addr(bo);
> -	if (addr != AMDGPU_BO_INVALID_OFFSET) {
> -		bo->resource->start = addr >> PAGE_SHIFT;
> +	if (addr != AMDGPU_BO_INVALID_OFFSET)
>   		return 0;
> -	}
>   
>   	/* allocate GART space */
>   	placement.num_placement = 1;

