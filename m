Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67290C43219
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 19:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7383110E10A;
	Mon, 14 Nov 2022 19:33:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2331410E10A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 19:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHMXFM+5LvZH9/izhUo28Iki+1fNSbd7fNISyxADxwtJK+KTgef3tHm+27CBKH7nNfr6reGSi6rH1Pdbf8mkOjygOSQM74/4Sy+ju3Jja0zIafja9f/atVsGyHl4ljRqj5OP/PZdiZiuLzw3oQq7Bemx1HTT3jPoLRpGTtScpc+mSigrE99aKnY9xv7uHjUoyg4tPAg82KJrfGFGWuxHCPJsPAIKr4T4HRZywn6YxKl3yTts/VXBy/qY76/r7j3CwhWsc/snpT3h1skfMBngLj+Ji30o//vIr1C1pTdfhFEmYZDXa/AU8SBc4tFzCl2NyA16Z2Afl+LyUEOH2y2QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzNatmDoXA+0P71U2V+qHWkYYmRJQI17yBXlrD0nqV4=;
 b=NFiQvDR+fAw7Ol3EHjQ+VYlFnLr1fml0PCTI/KpbeQk5hpkoDJu0JF5JrkjJ5+sKVdVjhL6ZuIRBCXrkGT8dw+dEUv4sLQUxYXQ3A7jb6v5BTkJnh/eik3hqQ+F+06yMgHo+HclDqdYbch7GkbV+0kltrFmoCOI1hjzGaWSpKYf+VlqMXRGZEV+NRGycmVLXfh36T5GSzRn9Fi6jgIyaBG+5E1paAouYM2QmyqkeqRZwpbwx62iAjcAXH6lTGbl4uH8O/tJMq+MUeJ+oE97z1JawguMoR5bg4jnfkRZUHLn2KParaaI795ZSYKS5mVRBsbc1q/cu8THr+S/rxjqZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzNatmDoXA+0P71U2V+qHWkYYmRJQI17yBXlrD0nqV4=;
 b=nhDBI7U/Kd/D/Ye7ZZvpUCs7GtOBIKWfC3HuhIgbyCdaNsMZb7g5mA6+uDOO/dGAWpjswvXmf1pQ2ciVuhXXwC1VxLEVsNEYEHrYVJxudA6oHb6jkrqpUfW4oBhbbEgCBXp43xI6F+4r0QqWpGtv0Lp6WVAuWGiCJ3e4T6y326A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 19:33:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:33:50 +0000
Message-ID: <7738f147-23df-c031-ca8a-d06a091ed345@amd.com>
Date: Mon, 14 Nov 2022 14:33:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] amd/amdkfd: Fix a memory limit issue
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221114184538.111848-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221114184538.111848-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: f02ff1ae-8215-4a5f-d3f2-08dac67727df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDVdvfYrGGXkKqHao5tH8JVQFZo2ucRmzjNvBbFv6k2TfMkFMNGSvoi7n7KvZnoVJsBkx2pw/pysv7PyU1FbNIUVSECgbiqleHHHlnLrR6N5NzOI6rkzoeyQWDgn6UVA9b7OIlbOjV19hSIXqIikO1BMaWgy4biTqINFVfwpTWbA7SFjZZMKSep9vzZdy2IIfy/486NSgX5d4SuzEUIRtgEcje8QU9XAU/k55Ibzimhn1nmxsI9JpfugNQxq8HxhUghtOKBmUIPfU4IO/ZBRkRqaqF9/x8VRVv6yv5/EDB9IV+vC1mJyry/1r6C8G6dpRH44fXS4IU2pKNzfnN9QaGwAEDw5qEgfsPRcYrJD3zfPUIsMDtJ19przSILmffernSOYvNyb+iRZdQT3BLSJCbiy1iUmGCq9e2x1JxJtKYpKJgRaRxHe3Lmfdnb9ExCM1ZyWIT0QSzL6MSs3SlSvs4zCDc0rhnw9sA3b8zqoB0Jqm/EesGb6+wpqvbQTtC8AzUQvj9Q4k0AMeQWd6zfik+QHyuSxF+Y+bLHnmOmqvIyjKmZUpznbVN08ZaHPFGvVuzWvfarw/pDiJDSyeDTIp4JJmyyD7pKj0imzPkKtIn3gHjHuDEMXeWk3CrhULuwosD/KSq9tT8Srwy7Ax5t290mnX4pBBxQb+jAO0Cs+nyTBHMahZa82cAHpkRi8Efv512nNDnOrNqYWsNi/nTXtQaepDS6s6NH+n0hmy04OVc7dAMxo+lXnLpwcRla7R7WVMTq5iu6uU6C/mzmSg9pfKiRddijJ632wGqMhbsJ8LCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(4001150100001)(2906002)(66946007)(66556008)(44832011)(66476007)(41300700001)(5660300002)(8936002)(83380400001)(8676002)(86362001)(31696002)(36756003)(38100700002)(478600001)(6486002)(31686004)(6666004)(6506007)(6512007)(26005)(186003)(2616005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3d3aXVsazZMcEdjOHpKeXk5dkhuWGVZMjFoaW50d283c2hXYVFodEkrTEZV?=
 =?utf-8?B?RjNyaHhQMDZjTUxHM0xlU3c1NmkwNzR6V0VPMHhVMC9MS3VjWWNSMmg4cklq?=
 =?utf-8?B?ZzBQU1cvUWxrMEpxbWI1OTZmdk9ja0gyeEo2WmpkUkorSWtsdlR3aldIMXhi?=
 =?utf-8?B?K3VOcHFPTnEzbm1icDhWc0U4OFZkbWkzV0phZ2ptRm51Zmh1TmZVZnFDR3Y4?=
 =?utf-8?B?bXdCY2NwT1gvNE9UUjg5c1YybUZESXF6ZXFLV0pwdk9iZ2lDV1NyM0FPVUVN?=
 =?utf-8?B?dDRGbTV4RFdlTHFZdUlPVVRWTjdkblBrOXZRVTBYL05uMXIwUEJFSitNS0Fq?=
 =?utf-8?B?Y0NMZWxPdzdVQ2xFU2UzQWljaXdjODB2RzZsVzVOV3pGQmdXbzVFUCt4S21w?=
 =?utf-8?B?WTMvU1NqZnlQTUFHWmV4YXhFbUswTUtocUp2bFB3SWFNUWJKZGdvbTAvNGNM?=
 =?utf-8?B?V3VOZFM4R0s5a2NwSnEyQk9LdkU2dVorUEcvOTlPaEZsa01ZZlVDQkQ5WVlN?=
 =?utf-8?B?RlhodGdsT1QyVEF0YVF4dmhEUURKUmVrWHNFb3Z3blBhd1FteW5mT3JpYi9C?=
 =?utf-8?B?OWFDR3Y0SCs5dFhXRnBVNXkwTzNuUUhJR3U1MndFcC94Q3pqRTN3aXg3bmFU?=
 =?utf-8?B?UW5CYnlVQ0VFdWt5UXBDZFJYQjJNbTZJNXQwZ0R2YmtDbUtxL2ptQldORGtC?=
 =?utf-8?B?dHYvVkpOR3YxWFUxV0tER0lhelVrWjF6RXVVQnA0KytsekpQam9ISnliMDhF?=
 =?utf-8?B?OVhabnpyRW8zNjIzMmI1bDArNnBUOCtMMnMzTmlXYVdPbkVUS0xsdDh5cnUv?=
 =?utf-8?B?ajZLc1ZtRlh6ZjN5VHFadGsycmhBejR5b25GSjRiNFpxczRvMHI0clQ0em9z?=
 =?utf-8?B?KzBSTndmWjZoeHh3SnVCZVFCb3kxVmJYcUlSWjJValRBRlU5OCtyMDQ2bUlC?=
 =?utf-8?B?WnhzWnBhQWJDU2xXalNML0FncldHTlFTT09uU2NGMFpvcUhWdGlxYjZGbkp2?=
 =?utf-8?B?RU12TmZNZ2ZyWGlOdGZjTE5jZm45SVJTNEhEMm1lbnVRZlJKUDBKSWkzclpE?=
 =?utf-8?B?SnAvOFhuSmVmdzRHYUhRTk9mbUZTODUyZjJjOFBYSE9jaEJQMlJ4aTFSdWxS?=
 =?utf-8?B?cFlLSmVKQUxoRU5yajVPcGNJTHpwSmRGUXY0d3BzcXFrcmJJZndhN0s3VjNQ?=
 =?utf-8?B?b25HUUhiaGs2ZndUQk5Ya2dVamV4Q3NMRTJjRkt2S3pIN0JTZ1JzSVR1eW9n?=
 =?utf-8?B?ZEthcytRcnJ6MkJZbXRpZ2ZQZU1MVk9qd2FGMnRyQmloVGxUOGxyWlBHclVz?=
 =?utf-8?B?dUQxWmVSYnQ1QlI0U0tGYVpxbjNKQjA1WUdqa0ZkdWRndmpzdUdWQmN5T0Qv?=
 =?utf-8?B?MnZGMTNvRXRxQm1PUm9xaGN1SmVyZVVmQkEraDFrdWl0SEJGbm1UbVZ3ZEMr?=
 =?utf-8?B?Sm14cExPVEJ4VG5oZEtoSklrNWl4S3A2NjZsNi9HNWdpbjJsWk9LcURLTEhP?=
 =?utf-8?B?eSt4RWh6QmxqRmdPS0R5aXpsSlZjM3I1UnVBejVnM0VxQmhyWU1hUmpnYWZp?=
 =?utf-8?B?bHFCWFFOeG5BME5yYXhicHVrVnVPOGZ2am1VUFhheG5JMHVYNHc4WGZFSE5N?=
 =?utf-8?B?ZjlTK3dLVlMyQzd5c3pFdE1qN3NBNFpkdUV6Ti9wRWtCRUFLK0RsN3ZRRXVh?=
 =?utf-8?B?b0F5SFNtNkNpSmNveFhtWU5pMk1DaitMVzVzYUk3dXRIZmk5TkYxdzdld21R?=
 =?utf-8?B?ZjltLzl3TUIrbmxrN3RQZEdoZDBiNHpQUmFiNWJNbDRzMFZ0OE4wcTl6aEw5?=
 =?utf-8?B?VTFsMGhOQTZwelB5RldsUXhSVDV0Z3p5cjJSWkVGdHVSK3NEL0NKaGlTODFC?=
 =?utf-8?B?V25RdnJtZmtwQkdtODNTdFlvdjQ0VGsvQ3ZpMlR5dnN0QzlqcWIvQTAxV2Va?=
 =?utf-8?B?WUV3aklWYW8rQ3dCN0VJaTMvMnUxbnYra25RV2lQdVpGUXdPMmM2S2NOV3pG?=
 =?utf-8?B?dG52SHNpT0gvZkRLUzJDaHZIWm0xNW9hcDhWM28zMlVwQU8zbEMvWll1cGNC?=
 =?utf-8?B?cmZxR3V4Z21zdktjMjNQb1lRTUhpS0haWGx0SnRVOHc3MDIyK3dTSzBmSkdN?=
 =?utf-8?Q?Gf+tmGTRQAmB8SRba04CFAiFM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02ff1ae-8215-4a5f-d3f2-08dac67727df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 19:33:50.2796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+c4F4D6jcJkQ3YJ4vEXvCVNIFi6hhs7R0hYjvXm7E0SqLBgvaZmHEKbp1slpHU6juFxpeo1cSqZ25IPjJTKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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

Am 2022-11-14 um 13:45 schrieb Eric Huang:
> It is to resolve a regression, which fails to allocate
> VRAM due to no free memory in application, the reason
> is we add check of vram_pin_size for memory limit, and
> application is pinning the memory for Peerdirect, KFD
> should not count it in memory limit. So removing
> vram_pin_size will resolve it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index db772942f7a6..fb1bb593312e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -172,9 +172,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>   	    (adev && adev->kfd.vram_used + vram_needed >
> -	     adev->gmc.real_vram_size -
> -	     atomic64_read(&adev->vram_pin_size) -
> -	     reserved_for_pt)) {
> +	     adev->gmc.real_vram_size - reserved_for_pt)) {
>   		ret = -ENOMEM;
>   		goto release;
>   	}
