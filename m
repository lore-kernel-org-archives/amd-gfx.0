Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00E5C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BD210E3D4;
	Wed,  7 Dec 2022 15:53:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28B210E3D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 15:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPoU8cafoO2rwiA7cnIYJTiXPedGD6c+RQqNtgz1Ly7ISxHLX/DYXQemflUc2uebRjsinRNA+ieQX0Y/J6xQc7lxtEAQ5jG+bdez/X9ER+BECkg2TmXhv+XbIzZG027QfBZJ/zNn0Q//EtMsYdLW7Tupx/wl69O2OeSAH6bz9rm535iclE/LtFBo42I5/da6JAVCU/Hk+A3dxNAxsVrV33UUuL/B/zV5FEaA7qw7kJj+C/CGcbyQd9UuGWZGR+gcY6/+dZAxH0yOCxJ2Y4dRAIN0xbYN8fpPBuIe3/QMfXzLOeX8OysHiMZLTtZh9CrObobnVOQ9mQiivuoUb8umuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qo/2QRPzLtMHiKfvlYOzFoLPF4qrGC0OiWZ9o2/Qbw=;
 b=UO2ymfCg58nkSGVYQbc6L8h1nalYCPd64huKc8TVQ4PUWU0rfJd0FxrrfLLBh0bTSE0Ti5gHjCGScM0DYd/UxynBU8D5GfS4hFQx6wTFdosdSWAKkV30t66G1a8EysZQERJE60bJ6iUFd2Dv+idBOoROjv4yYRU348UIf9zoHkRmC+hlv5d6HgadZ5oCbrHcM1cHTaS/oB/txDvn4XiRm6+4RJ9ctSO/0D779WWNibaaP+j4Cv09ixY7zG3qUe5ipyeOnBL+DN+Bkk0dnyBaDDpqyWKIpAGL+nUQDIdwL9eYIBd4bb1Oh7mlRKxlBWyQ+FvANZhDOwj24oMsoGBfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qo/2QRPzLtMHiKfvlYOzFoLPF4qrGC0OiWZ9o2/Qbw=;
 b=nm5iXKAnzk86HZN01Py4G434wOnqkWkeZdBp1eRsK7FJt+nD+Mu7RvxL5xD4eHuniy5K18SyvIu7MV1VXY5b/cYn27164x1V39bW5zGXQqPDPDg3+ThKFzJXL0j47aZvY3i0yKAnUXMqAO5E7/PTJkUjIB5AKPApvWYXT6u/p1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:53:01 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:53:01 +0000
Message-ID: <132ba5ca-2040-81c3-691c-40508a584189@amd.com>
Date: Wed, 7 Dec 2022 10:52:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amdgpu: fixx NULL pointer deref in gmc_v9_0_get_vm_pte
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 vprosyak@amd.com, Kenny.Ho@amd.com, Alexander.Deucher@amd.com
References: <20221207074936.1347543-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221207074936.1347543-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bc34c8-2313-4ce4-7d64-08dad86b1e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRqj04yRx42/lIEiSgLSluaotOSCZ66WKuqblCgY/d7jrNRs7PQ5kn6oUfd3WxOIjkgCgU5MgpOSHINVHZAXfcfWY5pGWBEE90z6gGDXQuKuwlFH+u9H/lsrcLMFIhL1pXh6snfFzq8KsM39DZM7gdaFhtXuD1afmpg7V3l0MnUb6KtfW9SGvHzaya0WY9Le0Vt1GmczLLo0p3zA6sOkoCRiWV1S5gXtiBlyioo6AAbCsWNOSBtWlcMSWqX3OXNnB4iE0uw41OmzOCBsy+1QBb8VNCh+pEx521o7idcBX88XHrKM7g1X4Ozk78Pig4aRRwpejj0izC1KgkdA65u8hC15kgcLN4orCUFnJGrqilubD8PCOKiP0Ijvnuj26K7n0DOZUT0A4aeEm9F0d9UdjANTyNyWYusgdjxN+dE3HNYp59s16Pd6+Y6YLv4Uai/b6VYke4Mcq9nQAliXE9o+NssLK54YMTH+wKn4mku7OynfLyfUbVydDxL8NNp2SwI9vK8LhXZa3//53SjjI/1WaSR3BCLjHL4ELTN3Eqn4iA+DcDHtLBNwmhCm/Sdz95KyFzqBCjj175TE9Hct07CSS9EA+l5VimUlnBnQSNn9siFKNaL7Uc/OLNRmS8me3lOEKa9H2dg0CkKbAG/FMtsBMHzH4Xy+YinVRLY++FHgjGq4xeXivXIDuaTAlXYBQowmeaiMpoQZKSGkBcUzxy9X9OiLAAQp8VlKREFHB1PX5q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(83380400001)(8676002)(66556008)(86362001)(31696002)(38100700002)(5660300002)(44832011)(2906002)(66574015)(66476007)(41300700001)(4326008)(8936002)(6506007)(6512007)(6666004)(186003)(53546011)(26005)(316002)(2616005)(6636002)(6486002)(66946007)(31686004)(478600001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHgxdU03RXg1V0x4ak9jV3dLK2FKaVlES0lIcUFGck1DZEdHRE94NGxzcUZq?=
 =?utf-8?B?R0hwa244d01MS1hFOHF5ZWoxT0RiczN1ZHU1ZXNPRGVhL1NRSS8vd1loRmhS?=
 =?utf-8?B?Z1dWa2F6VmdYVHBCNnZvV2lmVTJKMTNOaGszL1pnU3JsU3VYMUNDbWJVU1Y5?=
 =?utf-8?B?TVkvNm9OR3U2K2RzY05BbTNVd2lVeTl5cC9lVk9mUWRQZVJDcURWUWs3Q3Mz?=
 =?utf-8?B?T3lCdXI3MUNQWTNTVEFaSDZaWGk0QVU0QnB6OTloTGpxNFg4d2dzZ01SMHBt?=
 =?utf-8?B?amVKWnQ0RkVrQkhpaU9KS2NWUURBNFVxM2szYmlPVnFpL3llN0JQRSswakhl?=
 =?utf-8?B?MVRkbzdNVzdQdU83WVc2bC9oem84V0xpakNYZll5Z1E1dWY0MEZlWGhYaUln?=
 =?utf-8?B?R3hNTzZFamlvZEJ3Ny9rRkcySnkyQ0RwMXd0VnppY2hzeHZEb1lURndCM014?=
 =?utf-8?B?RUxRVEtuZWVMQ3hvSUNPT1BSMFFkR0Z5U0JjYjJ5Mm42YWJjdHl2a05mdnRR?=
 =?utf-8?B?QzRjd0RyMDI0QjZuS05NaEdLS2dSczZjcEowNTYyZDNzWk83QWEwSHFPYkc1?=
 =?utf-8?B?c3dDcTNmWHliRnFlZjdOTVBSbWNFZ1k0c2s4MDBMNlJTVWN1RjJnQ3IyYTZh?=
 =?utf-8?B?QXpPUWpkM29YaWFHWW5jeEJUL3JaNUFUY3BIMG42MGNKelk4UGZDcE9BYk45?=
 =?utf-8?B?MHlJb3BuV3doMVRvS2x3MkQwTEZ1b3ZyYVJLWUlzMExRZHhiZm9qcktzTWJV?=
 =?utf-8?B?WHd2SFJuTGFKeDkvYUx4dUVzR3RKWXJhV0xKRHlseGxZR3BUL29vRXB3M3lh?=
 =?utf-8?B?ZnBGSmQ1OUwrRUFJS2dRQVZCaFdHMnJNQ2diNnpCN3lqajV0WlBKWmFoWkhP?=
 =?utf-8?B?U2FSNGFCekZxdmpmVDVhY0tSSkthd2U4TFBaOVFLMG0wVW5aeXg5eUQ3YmFV?=
 =?utf-8?B?dU9FVnVKanpSNlk5a09Tc2tHS2pIbFJybW14c2F5Sm9kbG5teU5FTjZIcWJW?=
 =?utf-8?B?ZW1SUW5jTWpWWHd4OW45TUVmTXN3L2JHK1hFdU5heHNTVTRFZlJiMjhFdlVE?=
 =?utf-8?B?OVB2dkdGTDBzN2E5ZGZNTE15TFFHT1BpWDFycXM5YTZnVThndHlIMHZ6aFlZ?=
 =?utf-8?B?b1o4c2ZiNm9BRlMxUHdWcWVsemdSc0szZTB0VUVVdDZ1a0tWUzNYV2ZMN1hy?=
 =?utf-8?B?UWJyaXF4WkxabWJ1YVIrKzljdlZpUHB4c0ZJTVJyb0ZIWng2MzludXhKVnp2?=
 =?utf-8?B?eCsrY1ZDYzVRanNSM0JJMkxZZm03OTR3TXo4OFVrS0xOL1ZMZnBBVzF4YUxx?=
 =?utf-8?B?SExaVU5YT2lpaERTS3R4UFRKUUpaRGJ2Mnl5NG9ITmhBc0pBOUx2YTVVdmZT?=
 =?utf-8?B?THRPUHNKTmtNOEZJenI1UXh1L25xUG96Y1NTWFRoZngzdGdtVHJMTnc4S0s0?=
 =?utf-8?B?N2o2aFBhT0Y5aXUxSG5pTEtTTEFCVVFnaERxNzVUT2dmdm5NTVY0TWVRVkxC?=
 =?utf-8?B?NTR1dW1kdTVpVk11bzRTK1JqdTlQZnZxZWpRaWtPUjZaQytnaEw2R2xobFJq?=
 =?utf-8?B?SmxBa01EUHBZZ0d0NzFVTWNSWnczand6Y3d1d2trYUt0Q1ZMNlJmbDZBcnV4?=
 =?utf-8?B?UENicXUwS0grY1F1KytiY1JZSVRlb3hRT3FLK3dVQWl5TkV3NWJaNVNVYTB0?=
 =?utf-8?B?K0pNRjVjcWNLSGRqVGxKaWdmVC9zYW1KUTJ0VmxnNU96WktFa0UxaHRpcDdP?=
 =?utf-8?B?cWx1bTdkU2ZmamlKZ0VJcUNWWkdiS0EyRTFNQy9BZXF5M1hLTnRoUUdnSHVr?=
 =?utf-8?B?clkrMEZQa25IZ1Q4eUdmQ1k1eENCTHlucmRIajl4ZG5hN1ZQN0pFZGRjNVB4?=
 =?utf-8?B?NER2TEpGZWduc1dja1NTWEVWb0d6OWVibGxDb0lXYy9nMjVCc1pwdW5Scmg1?=
 =?utf-8?B?WWlqWkVENjdlUENGSFZIMEYyRXRUUmdZTjAvNEI2eHFzUGdicFpBbm5JbW0y?=
 =?utf-8?B?VGRsTWowcVR3bGNoY2pVOFlYWExNSi9ob3dROTFhbGdtZTR6dlNlMi9yRFEr?=
 =?utf-8?B?Z2tXRnFwYkpZd3A0NW1uR2hNb2IzTlpoQzNIeTFsUHR1YTRYSk1xaCtETlpG?=
 =?utf-8?Q?rB0rQhC72L67RJJt6LNSZIEB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bc34c8-2313-4ce4-7d64-08dad86b1e66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:53:01.1979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYfQDxbsqK5rw4U5yXOWO1ybUY1TxkQvx3aQFZo4nPMGiOFTgSslpRTo96Chi8ng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Right--I just double checked with the koops and it is exactly the "resource" pointer
in the tbo which is NULL.

Reviewed-by:Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-12-07 02:49, Christian König wrote:
> We not only need to make sure that we have a BO, but also that the BO
> has some backing store.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 50386eb2eec8..afc0cfed5065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1185,6 +1185,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  				struct amdgpu_bo_va_mapping *mapping,
>  				uint64_t *flags)
>  {
> +	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +
>  	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>  	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
>  
> @@ -1196,7 +1198,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  		*flags &= ~AMDGPU_PTE_VALID;
>  	}
>  
> -	if (mapping->bo_va->base.bo)
> +	if (bo && bo->resource)
>  		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.bo,
>  					     mapping, flags);
>  }

