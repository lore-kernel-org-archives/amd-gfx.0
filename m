Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795FDC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BB210E277;
	Tue, 14 Feb 2023 18:27:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A7710E266
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSewi4Qp/Q0T0IU3ewo717xAgMwFeKNrEOTh900Z2qc7V0a05SGhLYZqAqA20iRKh+YSApARl0CBMwp2pSCuJ+vsRgQ/QVICSnzrGPg00IPidaEFaEfxa7eq5pu/ChSGHsXB/wnjnumBOyQrOT7NnCBjDWxgooOQOXV4irOsiMjY6g65vFA19Tv+HXx6Nw6+2ADT0OEiM850GayVc8IaCWVK+sLo8kdF9cxGp+w4V8M9s09FThOr8WY3kGPg/ccGatGgo9pO9QvLZiUM1cm5LCk/3vAAWic2K1HEALUEdPQWgbmV/t8mBL58ydk+e5UzvyLtQl+uKYxe670pp2Zpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMa8JRCuHKZHEhjQnNMWmkiSD4pVz86QFSvdMb3yEbM=;
 b=mTuy9dCQmZA8n2fHAkzjpQV6PHG/K1SQcUZcy4OPpc6md7RJ96OcEsR7fVzZXm+mbD4KEPyT0Pt2Uwo5pjNn62P40b/72ft6D29mSl8y+IEcEnkNQcDFbKGWgYQrvRfbEp/cqcVoc+T2buOKAwYXZoIlNVS1vsPcG+xYafOZbvpZO0ncjg7wcYCDGv9IfpdX23jtUKBalgGii+KSK+XeIxcVFGSS+5J1qyPJ+E77Ulj+5lmGECZTir/dHIuyX3H7ezNPsJRh8kqGZnvVTz7Ofp3G9xxxyNIZYC5tJ40hoeIhZ7H2WPlBPRTgyNdGJHzS782XoP0Ok8wboPOBJr9rdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMa8JRCuHKZHEhjQnNMWmkiSD4pVz86QFSvdMb3yEbM=;
 b=R8Wl8QodksV4ioGCB+IxtmoUy5WWpOuP+vRCElfpiUAe1vE7K2XF6vFIIwH2qL1OphTr6ggevaj0x+J7YuPT4/L4JDFRlAO4onI7Z+oqv94nR3CrKErMs7vGP2Zh2ZM+rNMowkjUW9/WdZC+SDifymItWtCHOdBNJHlqGofUANc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 18:27:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:27:39 +0000
Message-ID: <d68c855f-03de-5f24-3da3-553209648603@amd.com>
Date: Tue, 14 Feb 2023 19:27:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/8] drm/amdgpu: rename doorbell variables
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: a532e7fa-497f-4d04-50a5-08db0eb926f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMPhZgxjxdIQNgcExnKJuwT0BTXELK11WsOYLiQkqOrkA2i/c0r1nFBohHsz+Tiv/juQf8p12vSyAjQCwlMWIltWXsq7sQsje5d+kAQPWhdFx1xzmHj4i3sST90CQT77JyCzSx5fZZ4nQnl5kdcnlhTh9cX7gv9SFPUFKv/O4V6pKHioimmatCGuap1dn7FgbHM/wL5oKOFQijeBA9PLsyw87SUI6vzXQSt9D2LtxVjefM2ZEFGBL2jC4RT2BXcyzbag6ERgM6UWJzUYMvbVVO37NQiqq5fq++fQwMH3oSpgFfBv8KWMhY9k4Lkc+9uADEDxadhfN3t8yB1l9NeSImTM2uJtX1quV+OvYiixrDcw++yxsah+oluP2WRJ9wsDQWOaoAAsyhH0bwXmF2ZnveITZ6S0ph6C0K0m3Nnm50tOI3/EWV2MZBGm8Hm6pF5QL6Bvu97SAgj9Gw6Fs+7sj6PjZpm4JHJGUe/h5zxqPcx2dBh2xj1VIJ76baVaDAPak53Ebgs5FBObxpRuxprtzUj2Kuy/DLmXq2AlK8KriTKBhUGIWNSrZLzT3d7tCqKBpjvh1wxFUvwqDvolegQmGHlju/ZbqkFWmB3sfWRkfnUFLOyqtdWh0QZPYAUI0IcQ1uMvY9Z/u5aUHMnfnJzK2neKOQJO7yvpjeVal+4gU6Y/BlRPsBosTE5kqK5d8PhRfm0sAy0CSEU+/43jPLgH6DCMKuElYMt7O8gMrfBXgok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(6506007)(2906002)(2616005)(6512007)(186003)(6666004)(31686004)(38100700002)(86362001)(4326008)(6486002)(31696002)(66476007)(66556008)(66946007)(8676002)(478600001)(8936002)(316002)(83380400001)(30864003)(41300700001)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZDanhyRHkxMXZPOStBTFlaYUtBVHE3VVJYTHdIVTk0cWVwYytYaTc0eExo?=
 =?utf-8?B?MXdRaGdnVzFqTzRWUkVFeklnTEZEbHFrSWRjcVBGOHMzWExzWURLcW9JT05t?=
 =?utf-8?B?dk1SUHdrUTcwcm9yYUJNN3VnU3RsVkdidCs4Q1A3NW1vZUtxUTl1b1loRElQ?=
 =?utf-8?B?V0lVNDhUK3JHbmdheDhiRG1BaWROUGYxVFNHbTRwQ0JCdFdEd1RZRldHUElJ?=
 =?utf-8?B?T1FMV0hkWC9TSnRXMGJNby9lNkprTXV1eWhiR3RLQUlsdVJTVEJWUU92QWlQ?=
 =?utf-8?B?ZEg2c21HaXRuQ0NnMWFjNVBIZnhROFA1N3R0NmJIL29JSWxId1E5N2RxTTZO?=
 =?utf-8?B?aTREUnRYU0VBVHlXQXVONXhRMm5GM0w1Tit1SzlkM0V5UTFZZFJ3RDlPRXVu?=
 =?utf-8?B?d3VsM0Vmd0NzbWU5amJGejBUM2pua0F6TUpoTTRZeWVlM2J3NldOVWgzbExM?=
 =?utf-8?B?NjdBQ2J2bDNEamdhUVFLd2o4L1ZiWHZVTnBMTExXWUt5QzZxekRDU2ZtN3lT?=
 =?utf-8?B?dmZyZkxsQ1Y4OHZzQVIzRG1oTEVleHl1ZG9BZEdCRGNSMXU3QmYwWEpYcXBU?=
 =?utf-8?B?K1l6MURUNnZZakNDajdkM0w0WS9CRkw3OERmYlB1T3lEb2VObUtkbkpGamZ2?=
 =?utf-8?B?SG1rMDEwdzZYRWlFSkJrbkZkNnNuSEhQa0tYa0VBV3RCaVNjWkZRM2xzMGky?=
 =?utf-8?B?YW5PaGhVaWplbE12NmkxTCt0Ui8xY0lleXZkeVhCMVlvMXRLZnV3bWZWWUNh?=
 =?utf-8?B?UUtDcFVMOEZ6Ri9jNWM3ei9VUHZVV0tvT3cvb0RZUDdFa0prSStPbzdvZit1?=
 =?utf-8?B?bzdLenBlVWdYeVM5MVZjcTh6RHJnUDUycjNjT2dQQ3lEWGRYOE1nOE9qMXNi?=
 =?utf-8?B?aEdnWkVQSFhLeUxpNXFjREtsV1VkZUtXWXdrRVZ5YktCZFpyYjNWOUR4bm5m?=
 =?utf-8?B?Z1hHOHhtWTRvQ1ZXd2RSanZhcCtIU0lzKzNCRVlncXQrQk5sRmt2TXNNS2s2?=
 =?utf-8?B?OUU4NGFnVEhBQ3BMSW1qVWFaSlB1WG00V2hNN0dyNWhNQ2lKYmRhanhBc01X?=
 =?utf-8?B?amZMZThIb2VqczhYd0x1V0NWT09udFhVUUQvUTlud3o4V2pzcTM4UWVYUEQ5?=
 =?utf-8?B?cmc1RXpITFBrOERWN2g3V0EzYWxCalZxQXQ2QXZRQXU5N2hlckVsWC9zWGxj?=
 =?utf-8?B?dXVGQ00xeHRLUVNVTXE3WXQ0N2JjOEV5NWRmeWpZdW9PSzVvbCtNaTFwTjJK?=
 =?utf-8?B?U0QwT3JTa1lGbnBBeGVHZTY4QUd3dDYyazdQQzJEd25MaVBDbDRWY0dvM1VF?=
 =?utf-8?B?THJKeVRDa01sYno0TVdtWnBBNnBrUGFVUlFSWnJQN3pEd3lCMWFkV1NaeWJv?=
 =?utf-8?B?d3Q2WjBaVitjQm5vSVZxcU5BSlozbHg3cHRHMHR2aTVwcTBldlZ5NHFYZm5D?=
 =?utf-8?B?NGFZTTIvRTVKbHF4Mjc5NDIvbG93aWRXVm4wTlpidGNHSjZOSW5mVU5NUk5o?=
 =?utf-8?B?ckJuVnZ6eTFVTlM1ejdCNndBS3orME1ZRWYwU0dldjNQMVJXZUZNdHdQZ3p3?=
 =?utf-8?B?Y0F0YnExNklmREtoeTFVL2VoUmo1aGxtSDNqTW9jTlpxYzBaSDMzUGo0MWpQ?=
 =?utf-8?B?MVBGdWxRYXlxZmJLSnBVWjJlZXhOSXpiOSs0SWUzaVFZNVJlYm9XcHI4bWY4?=
 =?utf-8?B?NVFIM21Nd0NsVnFlcXYxbHB2VGZtVHRtNVgwWHd2RGRNWTRqZk1rZE03S3Fy?=
 =?utf-8?B?RTZ6cStPdzh0bzY5OHFGQTJkYlJlMTRwUU5KZFlEeUtweWRuc0xRcGloT0w1?=
 =?utf-8?B?MVc3ZmNCTHJCYzlhSWdmekROczRrTG9ob3JPNitwUFQ1c0ZuaE5OWURaeGQr?=
 =?utf-8?B?YUI4NVU4SU1RV0NuM2hIZmRrc1A0ZUF5MTV2a2FRbjlPUzdzd1JtTytvVWdQ?=
 =?utf-8?B?VnN0Tld4WlJwUStvV0o2dC91d3RpY2hmSXZ2a1dzNXlCTkEwM3ovd29NNXNJ?=
 =?utf-8?B?dTkwY01mTzRlTjlSNnoydG11NE5ZcWxabDBkQUR3UGhXVUJsL3VOYWNVUVBL?=
 =?utf-8?B?ak9YNEl5UHYwUm84UmFOa3ZKTnhKWm5YSFJRSzBYVGNEU2VMekhhTXRtZUNw?=
 =?utf-8?B?QkkwczBTVFJ0MkZKYVBmaDhOT0dnditEbDhPQUtTVkt2S21aa2wrT05Ma3oz?=
 =?utf-8?Q?NryjEPK9aAdVctsxG9htEs3TKod++twnKf0hmnzpkiDt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a532e7fa-497f-4d04-50a5-08db0eb926f5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:27:39.0438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGlFHl4iNqDcRbzTR/COwVt8UHXw1w0DY9fjcpLiCoxOK1ANTziUULviP0mLudFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch:
> - renames the adev->doorbell.base to adev->doorbell.doorbell_aper_base
> - renames the adev->doorbell.size to adev->doorbell.doorbell_aper_size
> - moves the adev->doorbell.ptr to adev->mman.doorbell_aper_base_kaddr
>
> rest of the changes are just to accommodate these variable name changes.
>
> V2: Mered 2 patches into this one doorbell clean-up patch.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  8 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 34 ++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       |  4 +--
>   drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       |  4 +--
>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       |  4 +--
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       |  4 +--
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       |  4 +--
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       |  4 +--
>   12 files changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 58689b2a2d1c..0493c64e9d0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -106,13 +106,13 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   		 * not initialized as AMDGPU manages the whole
>   		 * doorbell space.
>   		 */
> -		*aperture_base = adev->doorbell.base;
> +		*aperture_base = adev->doorbell.doorbell_aper_base;
>   		*aperture_size = 0;
>   		*start_offset = 0;
> -	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
> +	} else if (adev->doorbell.doorbell_aper_size > adev->doorbell.num_doorbells *
>   						sizeof(u32)) {
> -		*aperture_base = adev->doorbell.base;
> -		*aperture_size = adev->doorbell.size;
> +		*aperture_base = adev->doorbell.doorbell_aper_base;
> +		*aperture_size = adev->doorbell.doorbell_aper_size;

Well that now looks a bit duplicated and you completely remove 
doorbell_aper_base_kaddr later on, right?

Christian.

>   		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>   	} else {
>   		*aperture_base = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 45588b7919fe..43c1b67c2778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -597,7 +597,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		return readl(adev->doorbell.ptr + index);
> +		return readl(adev->mman.doorbell_aper_base_kaddr + index);
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -620,7 +620,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		writel(v, adev->doorbell.ptr + index);
> +		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -641,7 +641,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> +		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -664,7 +664,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> +		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -1035,10 +1035,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   
>   	/* No doorbell on SI hardware generation */
>   	if (adev->asic_type < CHIP_BONAIRE) {
> -		adev->doorbell.base = 0;
> -		adev->doorbell.size = 0;
> +		adev->doorbell.doorbell_aper_base = 0;
> +		adev->doorbell.doorbell_aper_size = 0;
>   		adev->doorbell.num_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
> +		adev->mman.doorbell_aper_base_kaddr = NULL;
>   		return 0;
>   	}
>   
> @@ -1048,15 +1048,15 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	amdgpu_asic_init_doorbell_index(adev);
>   
>   	/* doorbell bar mapping */
> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> +	adev->doorbell.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
> +	adev->doorbell.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
>   
>   	if (adev->enable_mes) {
>   		adev->doorbell.num_doorbells =
> -			adev->doorbell.size / sizeof(u32);
> +			adev->doorbell.doorbell_aper_size / sizeof(u32);
>   	} else {
>   		adev->doorbell.num_doorbells =
> -			min_t(u32, adev->doorbell.size / sizeof(u32),
> +			min_t(u32, adev->doorbell.doorbell_aper_size / sizeof(u32),
>   			      adev->doorbell_index.max_assignment+1);
>   		if (adev->doorbell.num_doorbells == 0)
>   			return -EINVAL;
> @@ -1071,10 +1071,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   			adev->doorbell.num_doorbells += 0x400;
>   	}
>   
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> +	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->doorbell.doorbell_aper_base,
> +						      adev->doorbell.num_doorbells *
> +						      sizeof(u32));
> +	if (adev->mman.doorbell_aper_base_kaddr == NULL)
>   		return -ENOMEM;
>   
>   	return 0;
> @@ -1089,8 +1089,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>    */
>   static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>   {
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> +	iounmap(adev->mman.doorbell_aper_base_kaddr);
> +	adev->mman.doorbell_aper_base_kaddr = NULL;
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 7199b6b0be81..526b6b4a86dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -26,9 +26,8 @@
>    */
>   struct amdgpu_doorbell {
>   	/* doorbell mmio */
> -	resource_size_t		base;
> -	resource_size_t		size;
> -	u32 __iomem		*ptr;
> +	resource_size_t		doorbell_aper_base;
> +	resource_size_t		doorbell_aper_size;
>   	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 0c546245793b..b79fb369f0f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -126,7 +126,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>   		roundup(doorbell_start_offset,
>   			amdgpu_mes_doorbell_process_slice(adev));
>   
> -	doorbell_aperture_size = adev->doorbell.size;
> +	doorbell_aperture_size = adev->doorbell.doorbell_aper_size;
>   	doorbell_aperture_size =
>   			rounddown(doorbell_aperture_size,
>   				  amdgpu_mes_doorbell_process_slice(adev));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 929bc8abac28..967b265dbfa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -51,6 +51,7 @@ struct amdgpu_mman {
>   	struct ttm_device		bdev;
>   	bool				initialized;
>   	void __iomem			*vram_aper_base_kaddr;
> +	u32 __iomem			*doorbell_aper_base_kaddr;
>   
>   	/* buffer handling */
>   	const struct amdgpu_buffer_funcs	*buffer_funcs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f202b45c413c..7722da8e7cb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3526,7 +3526,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>   		 */
>   		if (check_if_enlarge_doorbell_range(adev))
>   			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> -					(adev->doorbell.size - 4));
> +					(adev->doorbell.doorbell_aper_size - 4));
>   		else
>   			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>   					(adev->doorbell_index.userqueue_end * 2) << 2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index aa761ff3a5fa..c5fd58d5fef9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -173,9 +173,9 @@ static void nbio_v2_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->doorbell.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->doorbell.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index 15eb3658d70e..9d716ec71f28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -169,9 +169,9 @@ static void nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->doorbell.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->doorbell.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> index 37615a77287b..19e175cc7340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> @@ -121,9 +121,9 @@ static void nbio_v6_1_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->doorbell.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->doorbell.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index 31776b12e4c4..bb2f1857b1e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -175,10 +175,10 @@ static void nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			lower_32_bits(adev->doorbell.base));
> +			lower_32_bits(adev->doorbell.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			upper_32_bits(adev->doorbell.base));
> +			upper_32_bits(adev->doorbell.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 19455a725939..ee1982bb06aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -223,9 +223,9 @@ static void nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>   
>   		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			     lower_32_bits(adev->doorbell.base));
> +			     lower_32_bits(adev->doorbell.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			     upper_32_bits(adev->doorbell.base));
> +			     upper_32_bits(adev->doorbell.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> index def89379b51a..180d50bcb40f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
> @@ -132,10 +132,10 @@ static void nbio_v7_7_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>   
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
> -			lower_32_bits(adev->doorbell.base));
> +			lower_32_bits(adev->doorbell.doorbell_aper_base));
>   		WREG32_SOC15(NBIO, 0,
>   			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
> -			upper_32_bits(adev->doorbell.base));
> +			upper_32_bits(adev->doorbell.doorbell_aper_base));
>   	}
>   
>   	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,

