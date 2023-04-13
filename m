Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C408EC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 01:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3601310E0A6;
	Thu, 13 Apr 2023 01:24:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8EE10E0A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 01:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KegrV0b6+qaYYK6usu+8DUGyOMbiImVgyVBhTZ1XJUo3goWadYWTuntuafkQ+Joy9ta/WthXmpx4+baWTe+Sswp6LkB1dmxs+JxxBPO/9Y2FFpa2hm4bMuaX/BcfurdxGA74nwnmCOB2jJMrGPDweHyyi2wkHBa1WTfa180iQAERn63d7X+Q8uXtw2iCr2MW44CzEoBlNs9FqKEGsoScZpHdqDDzsSNxYXMuTPs+AIgwkXzOL5axtiN5U7uWz7NGAhtckcoIf9OydKwjHGgYDEj18Bm2BmsU91WsUv1qt4NYJX07HEkS+xTz19TVHd5vR/XIaw+SlY5qDhx3C0LiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlYE/q5YDNRgV3xWRmIBw5FYLyC4xXHzLW+Ho/b/mRE=;
 b=kcz/9NDKV8nlnUQYwmAgk8wEtor2Kcseahkh2eYBjAQ+ZsB91MgOAXLxySxjboc1v/ilK8R43kgvoV9/WW6hsUcOI192gT9ObcfLywzf2BUlkYDMPanVnxuX1g70iNNOCo13shk5hLm8iIF9UHolQuZpZHJCptgLYWXYf3+45aDHAMSO1S5dxzJP7ASkTbAn8cqPsbdetoX85e/QRqEB6CIg8RDTsKE4ms8Mk+FZM4V154iMMzRzIHvqvnfh6oMAl2CCJ70jY62gXB0EDZMnOhYhFS/eB0B7EiKqU0XWCNe5Fw9JKVT7NQX7AFtg+CzcJ+iC0+3diuw23L/jgRFz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlYE/q5YDNRgV3xWRmIBw5FYLyC4xXHzLW+Ho/b/mRE=;
 b=UvxIO2pPL2QMYXlx6IoiQ8gt77Dt7iHh80811ZzUW0HNEHN2gI36z6OD7Smfj1+eN9QNpjNRrqsCoq0Qq7OAx3EUce/QTF08c4JUpk85GPZvrxUd1i0PHre/+n+XWZiW96/1Fttzt/I1teIcoL2Zlq7EqRWvC9Nzj5Ede/j+j2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 01:24:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Thu, 13 Apr 2023
 01:24:48 +0000
Message-ID: <62a91a22-0a55-6feb-7b8f-4d234cbd42a5@amd.com>
Date: Wed, 12 Apr 2023 20:24:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: drm/amdgpu: skip kfd-iommu suspend/resume for S0ix
Content-Language: en-US
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230405112921.3690452-1-aaron.liu@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230405112921.3690452-1-aaron.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:610:38::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8b5ddb-955e-4834-f658-08db3bbddeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbXjd/HxF0GHXXrWwy0wW3HclzOmjeOcy54yPPJbPmA4Fo2JNQnQOI9LRw2o4e2LPWen1l8bvowjbSTlyo7uBje0B89+G5onVsBm1u/Zhfxl/clmoaPCdemYCLEcrsBmuLN0oYNgR7+nqS+vgkEgKm5WJG8tybACopNjewF6FlJorksogZdxTq92K2qGJYxBXclVUnMItwQLL9oL4JnxErPt2gijRT4YBjqDT31OZtVplS3LDJmzcbIsvcLfYvdCm/aL2m7XxFwSf5RLgna3lXbt7BDsJqiqgONtL5WstlMrQ2mp+0ItBXX+b3nQxqhCZ5RXjla58zI3EF3XL30b6QhAZOVGIttmo0kKrdlyeDQzbdynhTz780G+mFdggoxA4r/0I+M9+T789dN9gJ6p2+pvUcizk95PXHn9bBCvo5/qs2EzirnJ6IyvJWVyJTJlvRTpjMxOaEmsMQyotQERB5fML31YaH0mokRi5o2TkSGKNR0WV459xU8d/7J3yfA5GipCG833NVIYzXzV1VsizogcDd5oaESDnvhs+QKX/yAe1Xt+Dz06xD6US2ZkQngLeGGo0tx7meH/4uIm/78+Po6YnQOiHqdR/ZIqQMEn5ykbzyFMYc92wmL4oGmRZ8/1dl95FxRxHnJUY7Hq2kDxy06ZVmcA+WECCjECPHY0xhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(6666004)(8936002)(6486002)(5660300002)(31696002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(53546011)(478600001)(38100700002)(316002)(31686004)(83380400001)(2906002)(6506007)(6512007)(2616005)(186003)(36756003)(41300700001)(26005)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhMRkd1ODZUTEozTWpnZWQ1NmVBb0FXcHQwZTR4aEVDSFlKYmNUYlBMay9V?=
 =?utf-8?B?RHB5ZTZ2N2pCVWM0OWFneXdLaWI3WGRXcFEybGNmemZLTEtxL3daczMwS2Mv?=
 =?utf-8?B?Y3BTd2RaRVBlazVMKzNuQWlFSHBJaGd5bEVFZDhPZnhsMk9NRkg0MUVYU2d6?=
 =?utf-8?B?cVc0NHZIYnd4YjRUUVJnVnIxNzgrc1hBRG5zU1duejVoRW55RjV3OXZmLzZm?=
 =?utf-8?B?NEQrMW9UN2FzVDB0eTZleHFjNkp3UnVxdm1mKzlJREVNQThVSnJmdkZweFdF?=
 =?utf-8?B?MGtUVWp0SG9VVHQrMHZNN2dvd3M5cm1qWUV1QTJ5aUJJaVhQTlRCdVZsd2lX?=
 =?utf-8?B?UVg4dU0xQTh0a0xjVkk3MnVjS0pyamRmZVhKaVBMZ2hMUDlBb1RLZ01VKytF?=
 =?utf-8?B?Z1ppcTJ4RDIyWnJyZStqUERjelY3Y0JRVzgzTzlRR3hjN3NGdEcrSzBCWUt0?=
 =?utf-8?B?N0FMQndPTTNpOXcvdTR3L0ZFM0wrclM1c0ZZZ3FJdUZ3QWR4YzRnbmhCcEd6?=
 =?utf-8?B?YUVwczJGaFdlZ3dwS3J2RkdVZ3Q1MHFNVTdmdXdwZVZvK2VGMTQvRkNtZU4w?=
 =?utf-8?B?OG9vS2s2K0s3VHEzYXRpL21IQi95RHk1LzZiZmpXMHoyQWV6TlA1cVRxL3gy?=
 =?utf-8?B?T3lkQTFYbkRHRFA5NWhJK1FYanJxVTZRVUZESWVOMWJwdDIvOEppc05Sakho?=
 =?utf-8?B?MmZONXR3RU5yU0I0YzZEeTArVnpncVBLTjNjazEvOFNSaU8vcDNaM1REcGM4?=
 =?utf-8?B?eVlpV1lkKytvUkN5Tkhwam00TEtEeEVsYzBDbmo3SC9nVFIyZStURGJXK0p2?=
 =?utf-8?B?S3U5NituMFd4K29uYVc0eDlpMG5yZlpsYjZFNGQ0RU8zSXhiNTh1Qjd0NHNa?=
 =?utf-8?B?a0R1YUljQTg5bm9vZEJ0MXl6ZlNFdjA5R3lHWWxHNVh2bnBIZUZzMmtXeUFT?=
 =?utf-8?B?VzhNL2t1cG13ajhuREc1YzAzbFZ2dVI5S0pUUlVZc3FiZWIyQmNFeE9wWlNn?=
 =?utf-8?B?TzMwdEdOSExnNDFSSk1HV3k4MXZWRWdiWXU0cVBoSTd3T1VzNXFBY0QwOWxJ?=
 =?utf-8?B?V1FMalM4eVRCV3hNeEdGWXRtQitUN1JEWGxZUkJVcWNXL3dra0VzWm9tZlFq?=
 =?utf-8?B?YTlNRytDNURsbmgxS3JhaGlpSnVnQWVqQTdUcmNjR2VQZnRVY1M0QWVrR1Bu?=
 =?utf-8?B?SkFEWjNEeXpwcjZNRzRsdjNEdWE1Tm81Q1BsUmpOVVhLbmhNT1FVT3h4TDg4?=
 =?utf-8?B?b0d0eWtwdU14NWQ4VWIyak44K083Zk5IQVUyWlcwdFV0R2w0Q2drYnNpby85?=
 =?utf-8?B?OTh2NXZHd3B3TjQ4d1NWZElnd09QUExJaTNtUys3YWYrT3RXaUhIaUVCUno3?=
 =?utf-8?B?WWtIMnVQZTFGWFRsY1dvaE54YkRXRHhiOUk0MDJ2NVBKRGliN3d6ODJ6M1Nt?=
 =?utf-8?B?cllOcm52ZVM3S0FONnVyVlFnTjNPQjFsaU1GRTVUcm1OcExEK3NLNmxKUUZs?=
 =?utf-8?B?OVMvR1ZraE5Qd1hQaTBkNFZSSTgwbUdnbjdXSlh2eUoxVHlLSmFjYkw2OEVC?=
 =?utf-8?B?cGhkK2NJS1FhMDRhamxURnVSd2xnWUZYcWEvT0xhOGxrckh1Y0RxUDlTdVBj?=
 =?utf-8?B?Tm0ybE41emJrVlBnUTFOQ2N1K3BBVUxXZXh6YnJ1MVQvU0NYZVFxSTBNVFpS?=
 =?utf-8?B?WnJzZW9pODZTdmVEaUMraUt2Z2ZxT3BFY1NlVEF0UjhsTHR1T3NiWWZMaWJ0?=
 =?utf-8?B?RUJ3YzZCaDAybko5YjJkUTFWVW41cG91eG1LbzBOOFdBMXFlRnU5TFZpTU82?=
 =?utf-8?B?Rk0rcE9pTTlQUUFlNEI1SGNpMnhSRldXUjVkZTZwR1N3aXR5elNLS1U0aUdz?=
 =?utf-8?B?VERIMnM4Y2FuRHEvem5xTlF2Mkdlc2pUaE05eTFmQnZJU0R5NTZXMzRzZzNr?=
 =?utf-8?B?MWRVM2VzaVhrWGVFVlptTldTeGYvcDd3QmhlalpzWmRMZlJKY3VOQXFBQjMr?=
 =?utf-8?B?UTNtUXJ3WkRub3gwaHhtbGxKd2pYbmcxbVhRWVJpaGxtTUc4RWIyald6RkV1?=
 =?utf-8?B?WGdpRDNiYWVmeXd1NmlTVDB5SVVkRGxxOGxtY0NLOVJWamtnWEl4K3ZWZ2VZ?=
 =?utf-8?Q?/ALVeXh5ULAK3e4OIs/3nwduK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b5ddb-955e-4834-f658-08db3bbddeb6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 01:24:47.9199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjb3wvPL9hiaG23yhj0blX9iX9/atngTr9SHU3wv4oLLPNHe/bfgfv8m5Y2QY2qGHIiEAWNgdHX4kkCAwZgsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
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
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, prike.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/5/2023 06:29, Aaron Liu wrote:
> GFX is in gfxoff mode during s0ix so we shouldn't need to
> actually execute kfd_iommu_suspend/kfd_iommu_resume operation.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3b6b85d9e0be..5094be94fa06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3304,9 +3304,11 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> -	r = amdgpu_amdkfd_resume_iommu(adev);
> -	if (r)
> -		return r;
> +	if (!adev->in_s0ix) {
> +		r = amdgpu_amdkfd_resume_iommu(adev);
> +		if (r)
> +			return r;
> +	}
>   
>   	r = amdgpu_device_ip_resume_phase1(adev);
>   	if (r)

