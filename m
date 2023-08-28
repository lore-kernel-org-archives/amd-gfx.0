Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10544C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2072110E277;
	Mon, 28 Aug 2023 10:10:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFD610E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 10:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntsHaBTx+80MvMAx+RnVPs8VONNj+i1RiCgS7T7c9CRBfmCN7vGvfKxLYv1PsE3JN5brIfNR4QLcmbGLPJF38cQBIGlT6fWzlbeZe9Icy7y+qSMHsVfiXl0cdBpo9eM4gjopS0Q2f/hpF6y4YG+jQNOSi8P/gHXXHJuzC3jIaHbT2/wvW5xoPlcFnyljGbjuokolveV/anaD5b6+IDpCqBB25U/nsT719dck0nDXRaE+JckpF8Puk5i+fPXzhnAs0u1AW7OZpAZv7W9hs/tl70yHXQPxVKmJZRFmYhT8NJ66EoXBPb8vqiEQWnhX9FwJDLtxTqk6XEfAnNcOPjnVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWhxjkLDLHywHOx8s3+OuwRWM/wHHoDW4lC4gJMjH4s=;
 b=bJbaFC0htyuL7j4oMAWz3OPX37jP1CxmTm2miJysQMyn6dIg1wCvliax+WfR3s/LbT97qFJBO9pj2LIBfBuO6wJ92SkFo1m+tFRjCOvA4wFOWBXXH8PFtCORk12aFlzFBhmrRa8nSepCkOU/TrFsY10XcbVBviTasSjAUUsh9tb3W0wJXxMhYpOi24fJJOobFct0HbitqJfY2beud8qK/A9qgv65BxBPTiIHkW5Rqw8Uzx1XA4Uukaw9tKUZZKYqsqmwQFKV5wH28axUUhB/U7r7XXv0IZiUSFj50LimiJPhmzJjuvz0TEuAcSZ7VEY7YTHWBfYwSDoWTVuN2Uj3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWhxjkLDLHywHOx8s3+OuwRWM/wHHoDW4lC4gJMjH4s=;
 b=GO98UfWtN+dA6Q9RSfkvRdo1yt/gpfocmoC8vtlpIdjmuLDHX7ynvb7OKmoO3mcGCOf+lkCyfsZw4euFDZXwqdlB8jZ3sklTn3pct4AnCOi0NmXildtAlByWNjfFAGtJaprLBcarFb7FZGjJwrOYtuZmnP9LdF5Ido6alez5+jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:10:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 10:10:17 +0000
Message-ID: <78c564ea-1159-14b8-c57c-478677416665@amd.com>
Date: Mon, 28 Aug 2023 12:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amd: Simplify the bo size check funciton
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230828100218.1629093-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230828100218.1629093-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 162e56bd-5001-4cae-7e8e-08dba7aefa37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCWCovpqCn0e5KTGSovOm7ifQRoHCe9Y8I1rhc3xIcrFlsby9xMFiLXp928IX61XWBN5o8RAFPf+PnMOF8Kh1ZXYJilLu44V2j7yRWjJkxd8de343wn8DY0yeDsTOGSfxvKJxL0aBGTHlcV9BipYxSTSlXiipCTW5oVRxadtGoH11qs1vc7iLr2bfGfExLb4kpc2GPFXwGU4kcdbJaWbJB3EDJWMLAM3y25lU8Vge82ih+qw/tbkx78iJ6It6GMEQuGe6mKpG5Z80WducS8z/VwgeXCqx90t7eZ20+r/MDDKzYIjDsk4sOwxHL6dAUJ+vn9nFkfIfPT1i1Ytq1GziKSpULfjMb4vZ6z96IsZQqyiC/ZUMyI1Z/51aYVCzggZ7YL1op0BNsukb86qQHKpuNWU1SH2dCaowcBVDUbvl0yv3ZoIMjc7QPGNQK0YJX1iX5Me6XnzBJfZ90oWFzaSeeJ8l/X+/Y4ulCk1t4grLQxj6/1Nw1mpEDfGYwkZSLpAMlQNBCh/0TUCkkEBmW4uFOxdYAuxfkIsXm0FS+N+YygtjUIgyUMc5O7u1hWCIYizSGfpo7eAKv1EqYw56svMzkwai0IB8bReuWKSgljKhsceyqMusLnCxgA7qE13IRURxXce/vSE67syVmUXyRwruw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(31696002)(6666004)(6506007)(6486002)(2616005)(6512007)(38100700002)(5660300002)(86362001)(2906002)(8936002)(8676002)(66476007)(66946007)(66556008)(36756003)(41300700001)(4326008)(316002)(6636002)(478600001)(83380400001)(26005)(66574015)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2tBazlkUERnY2JWUFVoMVE4UXZjVSt5eVBSNGdHeTdNcnFob3ViajVCdlUx?=
 =?utf-8?B?MTR0cU5EeVk3ckpiU0kwTWRuaXhpdUJTUFJ5eU9GMjNGRHNjQ1YybU5HVTcz?=
 =?utf-8?B?M0I4S2EvYkowWXhrZytYcmtmRDJxaWFtUDMrODFWNWtuY0t1cjFDekFFL3RR?=
 =?utf-8?B?WG1FbThDSG1za05ORnJ6TkNvbVgveG4xSGNhVWJtZzRDV0crOGRhd3VPbUxS?=
 =?utf-8?B?SnBXTlJ4K3dsNlRUK2Raek9YSXpJV3hpTUxZcjVDVGlEZmVodXBNajAvS2FD?=
 =?utf-8?B?N0lXUW1WSXV6SG5wUWVhOEZtWkRrSVR6aW4zdFArMGVYamhPYW5EUjNPNGRD?=
 =?utf-8?B?QUdseGwvZytJZ1hNcUg1K0ZDNXN1UDcrUVZoRWcrUWk3Ky9qQmZEejJ0UlpL?=
 =?utf-8?B?bXhFRnlVZXNIdlVBRStPT3U1Y2JtOVJ4VTZCOGsyNVJXTnV1NFhTd0FyZHNl?=
 =?utf-8?B?ZEVlYnI3ZjNWYnExenpEMjhyL1k0elFRVHRCZkxrQ3lXb1gxRGdscnI2c0Vu?=
 =?utf-8?B?NytsbjJhbnRDb014bWZWbTRKSGx0d05mOGcra0VwQXBTR0NMMFRQZlNNdDgv?=
 =?utf-8?B?NTRldGlnY0NzWDdVTHRkQi8xODZUcldVQW95R3lleW0ydmhtNHJMbTV0Zlpk?=
 =?utf-8?B?M3c1Q3VJRWw4R0FBb05GdE94aSswOVZLREVoZzRIU1l3T3l6NlY3cHJ2cWJW?=
 =?utf-8?B?dnBxWnJlMThyU2FZS1VFUEVXN1R3MmxQdEE1eEVWeFdKTkVyVGRvN3k1SU4x?=
 =?utf-8?B?VUNMVUpXY3FydGcwMUpTUVhrZDQwK3MvWXZ5NU9wQTlYZVA2RVIrNkRISy8v?=
 =?utf-8?B?ZHVmbUJyQldyOXpZYWxaTlhwSS9OS0M0MXFCYU5DSUFKNStDaWUwSDVwV1NO?=
 =?utf-8?B?YXBrWWI3d2RpWm9mQnN3Z0xEd3ZRRlQ0eWZGcTd6dEFYbjM3akZ3YWUyaUdx?=
 =?utf-8?B?L0FBZ25KRUdsUlhuK01tTFNrODIvYjIvM25HTzBNLzMwSHhkZEZMc0pwYzRJ?=
 =?utf-8?B?bVpJTkF4Q3ZqNHQ3L0M2ZGJUd0VvMmRYVGNtN1Q4Q0d5NjZOVnA2dnZPL0JX?=
 =?utf-8?B?NTB2NHQvUFJIclUvQmlBYUtrQkswSWF1YkJ3ajBING5SNFhYUSsyWDQ0azR1?=
 =?utf-8?B?cUlRQTQ3NGZJTGxpMnRBMUdvMmdFc0hJd0xUKzN2L2o2WU9zREhQcS9Oekdr?=
 =?utf-8?B?V0hHT1ZUdDNRMkhMc0piOUUwa0FVRjVFR1RCMmpQRTlkN0lrODZLYzlIZkxq?=
 =?utf-8?B?M1Y3MUc5djJyV3Z4T2pIVmUwVHpjQnNaOSsyS2JNc0V1bDNzU3EwTXJxWFIr?=
 =?utf-8?B?NWgrVnk2S1Ezb1F2aWV4WTBGSlR1clhQbFlvb3JCVDRjczRVQURFNGpZTTlx?=
 =?utf-8?B?ZlI5UGFsZDU4eU5hbjNBZVBTczg4SDEwRFJMQ3JENGhyQ25PTENsbzJhZVlO?=
 =?utf-8?B?dkdQTitoNEx4cTBONzg1a3N4MWVKTWNlaC8rcmFKaFJkV3FML2VLcnVoRXlO?=
 =?utf-8?B?Z0lmM2FraWliYUhTeVVoWG53U3AzSjF5cjRBMXBCampwWWFBZEYyeDVpQjlO?=
 =?utf-8?B?QTJ0aVEweWNiNVVwOFhwZFV3WURPZlcxM0tKRHloQkFNUnZKeDllR3crcC9C?=
 =?utf-8?B?WFdSM1AybExybENZVnBmaERTMzEvRER1RUdrOWNYWlY4L1IyQ3V5cXQvaWpX?=
 =?utf-8?B?RnI4U01tRFFLZk56eXBhYUdrLyt0NVJpemhWd2pXMWdKWXA5OWxXN0dscEZ6?=
 =?utf-8?B?Q3RpYjI4dFlrNTA3Q29nK3lYNUtIUWZJZG5uTHh2OWRoN0FDZ3Y5dkpVQmt3?=
 =?utf-8?B?ODhOM2dUcTdyN2J3RWZwa1ZFR21TYUxvOEkzQ2c5c1laYnlrY0NYQnJXMllL?=
 =?utf-8?B?RnNNZGhYT2xqK3ZxSXBJV04zQlpsc1c3eTMwZkcxd095VFZVSEFQaWZOQkU1?=
 =?utf-8?B?YlJmTXJUeVg4bldSVjJXL2VKaUk4S21RZXM2eXMrSlB6ekxZeDhrMnNZV1VY?=
 =?utf-8?B?Z0wvLzlhQVZDY3lURCtraW85cUI0UXNaYWtCUnJycS9oMXJxWWt5cHp6cWw0?=
 =?utf-8?B?K092bjNRd1ZOZkwvanJ3UDFJTjhMTEx4UUFDY1laT2MydG1ZSnRPSDRjRTQr?=
 =?utf-8?Q?LOHs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162e56bd-5001-4cae-7e8e-08dba7aefa37
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:10:17.0094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+hLPq89UqIx6RfwKOdSlNqWAPtEJwHwXeYnPWNJdedYRRGVi9ZWQKwUx22o9BI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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

Am 28.08.23 um 12:02 schrieb Ma Jun:
> Simplify the code logic of size check function amdgpu_bo_validate_size
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 +++++++++-------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 807ea74ece25..e603ca062fcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   		*cpu_addr = NULL;
>   }
>   
> -/* Validate bo size is bit bigger then the request domain */
> +/* Validate bo size is bit bigger than the request domain */
>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   					  unsigned long size, u32 domain)
>   {
> @@ -490,29 +490,24 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   	 * If GTT is part of requested domains the check must succeed to
>   	 * allow fall back to GTT.
>   	 */
> -	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +	if (domain & AMDGPU_GEM_DOMAIN_GTT)
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -
> -		if (man && size < man->size)
> -			return true;
> -		else if (!man)
> -			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
> -		goto fail;
> -	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> +	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> +	else
> +		return true;
>   
> -		if (man && size < man->size)
> -			return true;
> -		goto fail;
> +	if (!man) {
> +		if (domain & AMDGPU_GEM_DOMAIN_GTT)
> +			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
> +		return false;
>   	}
>   
>   	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
> -	return true;
> +	if (size < man->size)
> +		return true;
>   
> -fail:
> -	if (man)
> -		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
> -			  man->size);
> +	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>   	return false;
>   }
>   

