Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7540C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 17:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4711F6E39B;
	Mon, 29 Nov 2021 17:58:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151C76E39B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 17:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esPFU4SSr4CFJPPzT/7YvFO2WSXb8J6H3wltt2JKZo4pYcBdB7W3Hr9n0DRrifPG8dv9qOpXtdd4yUj3rXXQuFAF/Uq3Lz/WyzTAd0qhv0bLu0PH3ex0THBHtpp2GPDmJ/aK91/nk2QCCt8OvddqOTmLJmuqOenDAiXzyDYTCViZrWaE7qgOJukpMjf8xm7hw+cdbgafBq3PAWwYgG4X2pkmky7K5hh64+zUaP2SvJCxxiBm/qr+AuJhO0GG9w/waisQtuALS3wrH0NkCfeDzpwkvaiuylv7Nr5Od9ri/ucFp/T66W4WmBzPRt/ngHVuvF71XRWKj5A5KiFpIGanxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFPvVsolq3mgC8GmMpCSfSFwvY2u9HqDwdDnTrPTpnA=;
 b=dErRNOmGrzHsbz8nMrxhLxIryexuxeYpSNzUlFJ81Jp1PjizcRdoNMYJWaincxvBkCHCEysHU3ygoh5q5p+R5XHhlIcAMBfuVbrzQH39WQOePx3LCPCAox7POTFbKA8M/zdENQHL2KGp5b7ChdwatFn+MmH6ll2GeyKAC//SCsxu5vwQ9u76+IKON0hS3xxkrtBwgcG4fDEo/8e6+WZW2viz68RpxtS83HXg7yDIfhnY+riTkV27PTo7zWQPKhsfPkxPPuE0GzRBPbYn51k/P625RktPwttcpB1fUuqQ+8p8FvlDr0tqlb3i7D+fyC8mYHVXpbaEROZmZkmKOB+NKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFPvVsolq3mgC8GmMpCSfSFwvY2u9HqDwdDnTrPTpnA=;
 b=gAIxqKc256ekyn2ivWP8bziCesBSL1zojvxjOxcIv4dYStuNPO3msi34d9qTuI2Y1QWdAIPIBGAu65IB+cmCdxoamCDt98WTox6G230bE8BljIDSY/Ah7DnNhlypB+16t6FkBeeZUCugkkq6iSnyDI6NMzMOwr9gjPuODKx3fxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 17:58:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 17:58:24 +0000
Subject: Re: [PATCH] drm/amdkfd: fix double free mem structure
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211126235837.11229-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <133e2764-7b17-0212-1e9b-8c93872ee2e1@amd.com>
Date: Mon, 29 Nov 2021 12:58:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211126235837.11229-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 17:58:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2aaf75c-ad71-4082-5690-08d9b361d64e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5212:
X-Microsoft-Antispam-PRVS: <BN9PR12MB521226C25521AD4B5428217592669@BN9PR12MB5212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nu3/5BcHWkSDeRvtmGFTe/1cbqaA0cw2IpGFgWh/VBjRB8NRF4AJICtLX65NU3JDKaHf1pQM0eKI8X9gW0VR1amuLmC00U6R7Y7YAR3Wtkqxd6H4ILPsIR+Neck7BcIRPSYm2c5T8BgLdJG6agdOfOII1AZcU77jio9DAE3m2ZTtXsWQxOkSBhgQkYBF98eNeh7COJEjihvo3gXwdrP0bTff0Bn2k18s5sxX7vylxfq8RS2HANLE0dzr+N9mvMQCIqr88vp58u4Gf6RdYUKqjGu7vR6vXTRIV97iywBXd8Ap5tViPmTAC3y7K9CrwIXU6EpCC+rXcz8xe1q+kSWbDRoKciEYEjJ4Jzl0PR6byixUiQ1imj34gEiF5I3903IjIrrOoHOYZbS5BAGpCxRX0M45DlluEF3X/7sM8y4feho7f2XASeFDbEb5uDPTAiZOBG3F/761xQGomZOHYxe10gSbvJS4Vivm35dgfvXT2k3ldr3vbqnFYejdk0JXlLPY60E/2oy89X9+87v7R+Gzf7lPAIkEavsqjSPZ6fEdB9uWU5bUR0SCqTzPtv0WDB01YwuJRlxehxPfatZVKFbeW/85GzsSTGXIM76kSeSKqCJELOHvSTl5azkwSJLf4imcR4GhPA4FQhPcJ6fu/bdCvWQXYLgiL2L8Nw4xrDGT+mN1+gr6FOUWb7Mtj7FEE6IdI0yNK+jmg6651YgFg8KSz71DaFW3kD9LcCZygAJ77dH/s7HBUFUXi+rvzpQbGo7s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(44832011)(4001150100001)(31686004)(956004)(2616005)(86362001)(316002)(6486002)(66476007)(66556008)(26005)(66946007)(38100700002)(36756003)(31696002)(508600001)(83380400001)(2906002)(16576012)(186003)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEUzMDRuRUx1bU1QL3ZBL3ZHLzJmNUlzL3VLcXBFd0NsWWdHWVJEbk40dU9N?=
 =?utf-8?B?cHRXZzBncUZGK05DMm9vRHVURitrUVBVNWFGMjc0a1hBaW55R2VCSTIydkxq?=
 =?utf-8?B?ckRweEZGdW94TC9oS3hHNjViUTg5MWhDaEdFZ2Z6cE1oeGdscW5ER1JUUlRp?=
 =?utf-8?B?K1R0SzlQaStsSGdndzJyYm1maFpFT3VVUTJaWTdSMDRGbjdlRzg0elFseGNE?=
 =?utf-8?B?ZVEyd3JCeU8rT0Z5eWdaQy9seEtEdzhUcDFKb3VnZFpXaEFVQ1BwbTFONmNQ?=
 =?utf-8?B?dEcwdHN6WGd3ODZNRmw4TWJZcjhzb200ZEF0U3ZTNkZPUGtERS8yK2pGT0dk?=
 =?utf-8?B?a3RHTVc1Wm92c2FiSHR5M2hXM3Z0SnhuODcydTRGNlNLTml4cTFVZzZoUk1D?=
 =?utf-8?B?MjBqNXVDc2xvNGlpdmsxUVNnRW9jYmh6dFM2enFaOFNSdTFKWHRFY0tvQXBV?=
 =?utf-8?B?NG9FNmRGWTFZOEhBeWF3bVBZWEhBc291SFdsaDVRV2xjcEhqdWU5OG5PWXFv?=
 =?utf-8?B?Witab0gvRVpTUk1DN3Vta3hQUkxlV0xwbCthOGNSbFB4TlpqTlRBRWpaaHE0?=
 =?utf-8?B?bENCTkQ5TDNVTWh5NWJRQ3lFUE1DM1orR25LNE9YU3F5akV1WWdXMG95VWdR?=
 =?utf-8?B?TTZWUUFoMkdqVExZQzU1RWdjTHZ6em9FVEJGQ2JBZng5eGdxbHl4V09YbmUv?=
 =?utf-8?B?Z3liTlJZN2tYNitFeUg2SlhGaGpkU1JPOVhTMytTT1lDSDJSRDJhRHVybGdw?=
 =?utf-8?B?UGVmUE0vNlJTTWhOR0RLZWx2ZkN5Vzc0Yml4eXJsWWZCS1V2djQwSm9tU055?=
 =?utf-8?B?d3FYNDZCRVJzU096czFSZzVlTHRWdHowODAxeDREa0E4OC83VWdLdU9qTUFM?=
 =?utf-8?B?ZW83ZXhZR0RndG5uZ0R0azV3dmcvUWtYdFZHTkJlVitPSTk2aWlmT2kwRldu?=
 =?utf-8?B?WWFnWkJsaEFHeXR2TFF1b3VjU05JU0NSLzZTWFJ4M1MwY0VuMC96YzNsbnc5?=
 =?utf-8?B?WFpZV3pVU2h1UHpJN201NmwwbHpKd3QzNTFTTzhCOWZQU3JxUW1xK0ZkbGZ6?=
 =?utf-8?B?WjF4NndQZlM1bG1Nc1o2UlgvRTN2VXIzYml4MXhOQVVWYmxza0h4TXE3UTRY?=
 =?utf-8?B?cTFpTGl4WVJ3WmRrcXIwVnJuZGZOaS9makx3WjZHWkgwdDlhZVd4TE5qRjlh?=
 =?utf-8?B?bFFXZ1RiNy9VS2x6a2RFQ3pQZGdaVHdlWTl6Q2RibnMrUHg5ZEV5RmY3Rm5n?=
 =?utf-8?B?eGVLU1FtL2paYldOaDVhK3A1UEtYNWRWakJkaEROT3lYSWNmcm80aFlsQUlz?=
 =?utf-8?B?WjNpc2VDMkpibkVUVWxxRy93UlV2WHdUdHJhSTJJTDV2RTVRM2NsSUhTUFJk?=
 =?utf-8?B?Z0h3d1V5eXFDM0o0MjhFNTlUZytsMHRVZEFYdi9uc09XMTdBUjY3MHVXTkM4?=
 =?utf-8?B?SFN5QmcwMXY5eThWSnY0eTJENEsxeXJ2WjBQNHlOZXhNT2F2Kzh0Q3pGNGph?=
 =?utf-8?B?S0NPaXQ5ajNqUnlJSGdsUnVZNDhWUHlWZHF1Z0FJbEhFVEJtZVBXVjU0c1lr?=
 =?utf-8?B?ZDdNemlDVGpvTTNhOGpzcEpiNjYzbWJOMVhaTjQ1c2xBdUUvVzdmVzVlQnZK?=
 =?utf-8?B?M3Jhc2tpQjIzazYwTTVSd0duNjNNQ0tOTjN1cjk2VFlpN011NDU0ZDBZd3pY?=
 =?utf-8?B?OUdGMFRVODkvQzMwbnVPV0xnc3ovOUtnL0Z5NEIvRTFUbXRHdkJJWGJSaFYw?=
 =?utf-8?B?a0JUbzRaRUJ0UEoycGdqcVZjZzdjZCtrWUMyUlBsVU51U3ZJMHBJcVJvRHRq?=
 =?utf-8?B?K2NUVGUwQ2ovd25UQ3FOSCt5ZkVmSTJDdFc1amdYV0NONmg4SkZzS1pNV1U4?=
 =?utf-8?B?eVgzakhPamFaSm9iM09XT0JHQ0RiOHFvUjFpaU5idUFudXBiWG1FMEJUeTVJ?=
 =?utf-8?B?ZThySEJ1blRnMEhyTVZhSDlYYmtmaHpaZ2ZkYXBqQ2RjdFIvZzk5U3Y4cTla?=
 =?utf-8?B?MHIyVHpaSDJ1OXc2b3ZmdUZ6MTI1alQ1ckxJbm5LL2EvaTFscEo0K2cxcDdJ?=
 =?utf-8?B?Qmc2bTI1K0hjUmZVa2Z5a2haRkZteE1DaHBINi9HaytueGtoNUJUNEw3Z2t6?=
 =?utf-8?B?bEwyMmRUTzdyeFpOSWZ6ZzNJTjZNc25FODJ5NWl3UVFkZWpLYlNuQnp5WVBs?=
 =?utf-8?Q?vfXhS+cymSBM0AEEmNrFNjc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aaf75c-ad71-4082-5690-08d9b361d64e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 17:58:24.0464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 050ojlLBYsb94cYfArYAtsbtqMkFubIMxidxLdAsQ7BnnBWaDjq3gQEIu7I6JzC//LA1z8d3mqEuaeihl4nANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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

Am 2021-11-26 um 6:58 p.m. schrieb Philip Yang:
> drm_gem_object_put calls release_notify callback to free the mem
> structure and unreserve_mem_limit, move it down after the last access
> of mem and make it conditional call.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c5362c23e687..e592a2067133 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1582,14 +1582,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  err_pin_bo:
>  	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>  err_node_allow:
> -	drm_gem_object_put(gobj);
>  	/* Don't unreserve system mem limit twice */
>  	goto err_reserve_limit;
>  err_bo_create:
>  	unreserve_mem_limit(adev, size, flags);
>  err_reserve_limit:
>  	mutex_destroy(&(*mem)->lock);
> -	kfree(*mem);
> +	if (gobj)

For this to work you need to initialize gobj = NULL at the start of the
function. I think you should also see an "uninitialized variable"
warning without that.

Regards,
  Felix


> +		drm_gem_object_put(gobj);
> +	else
> +		kfree(*mem);
>  err:
>  	if (sg) {
>  		sg_free_table(sg);
