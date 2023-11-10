Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7781FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0208B10E112;
	Fri, 10 Nov 2023 14:51:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E45E10E0F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANWWh++Q/Ku3ijmYtwpoE62vGdjQk/PvKC2v8kk78nRyfoGb74Zm15vRu/KVQ36JocED3JMlzO+9GtDT98T4yZ5qBAlhqJezcQWPp2G+OCyoGHtryf1I/hBfjMQIHp2s+g24Lmbnbk6cCzF6HoxS+5ATdZsDTqZ3BJSEGpOCTKYQzgoepRi9+8hLjbFKJ978IetxsY+S3YjsLlq32r4MstbiqTGrWu7ycI6hXn4a7DL1NUeZ/dNv0fgJKqHNyUuQgNh6nefN0z7yOroqqhUTu75zCYkLmPOCLcc9saPPuVlAYv52X4SWHNpfcfN9smIn8aFnMS9rDwoY5B2Di0sGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrD0+j0WAEDOq1dEtENRTV1aoZFyWWAxe8BmBhWXP/s=;
 b=XGTLXsIFnBEksaLW9osyBsDUA34uB27r4mHbsO+hi0nWdfgWOyJLnuRnpyizGdqQ1vgR/sfY1ji1ile+/SDqbQq7eeqaGJ5ca9Lue3Jeb4OjU1qz/sqcP9XjbfK+3/2TIZRcVD7MHHQZrbSr/0BbkZdCFYjxuY9pSO02dH/dzL8F8J82sNWq+44ZmAHegcBDBKHr/jI8QVNYePXc+/yl7/fVC4vf5HZx0r/X+txr2EeHPISu7v/cZ6gun9fudKMj/N2wtl4HDD09oWR1zdR8fWA63QognMOKMa3eKmN5ftiR7Dj0UlycWFhhVXVhRI4mgnhUQPaTEtyGEopHCQtu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrD0+j0WAEDOq1dEtENRTV1aoZFyWWAxe8BmBhWXP/s=;
 b=LhF7Y9xkozWQNNxpd6sItdJJhI+yajdRqvfmXPp8+1VA7bP+cil5cDyJFBhUYFAe7Pk1w0p+XSUxKDPXg6NZ2fveDZKUuxmfm07uc55rFbWVEcwoDrjH5O2Yv6/jcn+bh8nvi+h7N3JMm3ZpE60mgcHNL5vxrtWvvhViSXALvPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Fri, 10 Nov
 2023 14:51:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:51:02 +0000
Message-ID: <59668638-00ce-4407-a0c1-47200480fe8f@amd.com>
Date: Fri, 10 Nov 2023 15:50:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231110144701.1895397-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231110144701.1895397-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 890740cf-bfdc-4218-f356-08dbe1fc7559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cP8bD9tUjbnMBMueKXJNT4J8TMMPG0pg+yZLyqqGAo7D5rOY+DRjXf2XeRL2QRABKbwimH9v6hWJXhLBD4jPjWzuYi8jk++pjl87LVV9i582uME7v8fINFlEeRSEfm8ia59dfbIOzvjatyidG/zfZXPgeG9vYKraV6SUvWZRIlfUFQaKb/+YVlY7NffNkuJXOW7Gtb6yVxWuvG0ul7RgjTU0HWX36Y2xR3v4QWkKtnQpGhNctyWbqWnVGJWqi9F0LddV1D2maaORAh2WLWklVMx+6RbaP4oHPh1E/58m+5lYqAVnCoqh5QihubuPYqyKeX54I3QDODuGm/h5VZGBTWTYoXVTpihfviWNeRqLZy3pHAs3hahJRhYTvNLNzrexk6LHeQWaxvV0RRS7LMX+eiW8ohKtDJ/DuhYgfnnxIGmuG1x+VdUkkhyxMGlyZ4U1Qey51IOd+k6MgLuS3BPmjWI6PPYqAu4sClxNRDXeDmW+zPW0qvZPw6Xiu639OPNlYa/r2J09Z7uly2vDCtaQpLWhLt1EN6MUb1Cm7o8sp2aCooGmuxUhChenieVJDC3646FGF4pJvRcIDz/fr27C6hd6R//Zwh+mBSv7njvnk3eG6Ewdrbaro5o4GbfWcV7P9M56184GLSEeXAij6UdsUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38100700002)(31696002)(86362001)(36756003)(478600001)(6486002)(6666004)(2906002)(6506007)(5660300002)(26005)(6512007)(4326008)(8676002)(2616005)(316002)(8936002)(54906003)(31686004)(66946007)(66476007)(66556008)(41300700001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhONWhEMEZvaTA2RVdKVmhmZkVGOE5QaE9VdU9xZE95UitXMERSc0oxcWZi?=
 =?utf-8?B?Y2dqa01LVTJPczdlbklVL2NzMnp6UnBXYUhzSENUVGd5aG9DY1RwNHdWYTg0?=
 =?utf-8?B?bCtTbFNwcHgwQVl1RWd0M2x6TUU0SFRWbzFPaW0vRkJGUHZ5TmZGM3p0WjlR?=
 =?utf-8?B?Vy9BaldSVGlHaDFXMXlOK3hORnhReTgwNnhsQ2NWYW5BdVlCK09vWmJHV0dT?=
 =?utf-8?B?RTJZQlcwTkNvNGN0YVBjaDE5Uno1bVFkWkVaTDc2VjNkK3AvazJaK0E1a1V4?=
 =?utf-8?B?Wml0VUk2Wm5saGFPVndZWEsxT1hYS0VxVUtEb2doZEpsZ3o1V2dOaWZXa1B1?=
 =?utf-8?B?Z3dJcVBwZVJHUnRMYWlFY2RuQ3JPVU1CZGczV2lIQnAzOHF3VWxSeHU5S1Rk?=
 =?utf-8?B?RXRwZytNVTJhTUlMMUtpOWRvdFpwN0QzTlFubmQrNGgwMzRoQVppQ3ZrSkx5?=
 =?utf-8?B?NDZ1YVNVa04wRW1GeVVRZGhiazM4R2JkTVd2NTNKK2F0WGtpK0lPWXRTemVi?=
 =?utf-8?B?NDBMNE5HbkkzazZRWDNCai9NWmg0SWhFVVpVelpDd0liS0xrdnZnUERNUExi?=
 =?utf-8?B?VEJibXlkRkNqL0lpTVd3QXZ1amJWb1RDSzBsdHNiL0VVQ3NFUE5MVmgvUnUr?=
 =?utf-8?B?b0F2b2ZVTEtJeFNXZWhsMTVoNjMyUjNhVTg1MTBaT01hQVkvSW0vWXo5bjRl?=
 =?utf-8?B?MXZoUDNBT0Q2ekZCWktmN3M3NUxHUjRETS8wVTRCZXkzQjlOUStkZkJmUlNJ?=
 =?utf-8?B?Z2VxeWlIODdLNDdUejZudHlkcXBKS3g5V1Q5aGZ1YVBlQlZaU0E0UGZzWnla?=
 =?utf-8?B?QVlFU3QvQURNV2pWbEZoZllINTJpbFpidE9KaktydThLWFpxWmdxbjNFT3ZN?=
 =?utf-8?B?RENuV2ZFZmQyOHRVd1NLQk56TE9qbFBCZTF1WWhiTVF2YXBxOWI3MWR3OWp5?=
 =?utf-8?B?RkZFa3JLYkN0LzdzdVkzU1dTQU9neWRtWVpqd2VrUFlVLzlUY1FwbWErWlN5?=
 =?utf-8?B?RW4zODZLNjQ1VVk1alZab2R6Q29lcFdzbDFTSFFHOFE1VkpEeERGRW96ZHlL?=
 =?utf-8?B?czlkYzZpTGQ4SS9FUUc2dXlkbFZLZEF3WVptbGhFUXNGUzV0b2psdllZeFY1?=
 =?utf-8?B?Q2tBNXltaSswYVdxNzQycW5IR2V3ZDVxY3RyaFVZNDRIbVFuaU4vOWtEcXQ3?=
 =?utf-8?B?L3ArNGsvbDRDRHVvUUp4RW5USkhyWWppMEtLbURFOGxmaHNIYjlKcjdrRUFh?=
 =?utf-8?B?UU9uZVE5YURkaDQ2dXpJOEVIRlZ1eStVbjdjWXVJVTZVZnRsOHhETzNRTTVZ?=
 =?utf-8?B?K0hKVFN0Q2JCQjR5dGRlVlBrUlU5clAyL3pVZ0pGY2xtaXdxMTUyWDU5TXA4?=
 =?utf-8?B?NitEcjRTcHIvaTVOZ3VpUU5NVUkvY05iQzVIMGVSenEzclptYkc1M3lWT2Y0?=
 =?utf-8?B?R29OOG5MZHdaQ1BqWEl1Sk9VdlJCbzY1SHRpUThTRmVWeTllSnMxbU1LbGY0?=
 =?utf-8?B?TURTQzRYZkRxcUx2cU13SEhrbWh4OUhWcmdET2piVGlJYlNwdXV5Zys0MTJB?=
 =?utf-8?B?MlRLdFZSMGxVYUw0dzF0dEZGQWdaWTFkNDMzNzVmZTlyRHBYRDU5VEpvWW5S?=
 =?utf-8?B?d1NtZmp6aWtOcVlPYnB4TXREbS9WbGl4SzgvTDVjYzIzMEpKbHdPQmthYk8r?=
 =?utf-8?B?dWNJWEwzdlZmcytkaExmN1hQcVo3S1RwRlpSVlMvNS9TQzd0ZVliTGlSc1Rs?=
 =?utf-8?B?WXBBMXNSQmoxK253Y1ZYQlRUODNZenNXeVR2MFFuVWQ4TXhpR3owQzAzaU5p?=
 =?utf-8?B?WnRhZmlFYTVyd3N5bklIWC81cUs2aWlid3dtQlF6MVRxQjcyYzFYaVlCd2l2?=
 =?utf-8?B?b0hmQkNkVUhGSzVsSExqVVErSS9OWTd1NUZOM3poUml2YW83QXVzU1h2QVpz?=
 =?utf-8?B?cnkxSThYcnV4eUpVeHNBM002dklmcTFMMExPQ2NTb1kxNkdPY3I0MDZlQnU1?=
 =?utf-8?B?T3hwRWdXdmV3WVdVMzcwa1QxOEh4Z3NMTXJMZnNuQnlOK3drTGJFRWJMRGg0?=
 =?utf-8?B?aUJUTnNTVGl5bFlMZHBMVHBHeDcwQU5Qbmp3cTdzWDZvbGxhN1hSUGFkTm4w?=
 =?utf-8?Q?rm5Fi5oOPWwwaG06gZtn3RliE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890740cf-bfdc-4218-f356-08dbe1fc7559
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:51:02.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiICu9yBThe2mtn7qJUSiyY6//AVYn1GS03e7rXgFQdjvWPf+tXCVYjUDn0UVob+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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

Am 10.11.23 um 15:47 schrieb Alex Deucher:
> This worked by luck if the GART aperture ended up at 0.  When
> we ended up moving GART on some chips, the GART aperture ended
> up offsetting the the AGP address since the resource->start is
> a GART offset, not an MC address.  Fix this by moving the AGP
> address setup into amdgpu_bo_gpu_offset_no_check().
>
> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: christian.koenig@amd.com
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
>   2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index cef920a93924..1b3e97522838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	uint64_t offset;
> +	uint64_t offset, addr;
>   
> -	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> -		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> +	addr = amdgpu_gmc_agp_addr(&bo->tbo);

IIRC you must check bo->tbo.resource->mem_type before calling 
amdgpu_gmc_agp_addr().

Regards,
Christian.

> +	if (addr != AMDGPU_BO_INVALID_OFFSET)
> +		offset = addr;
> +	else
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

