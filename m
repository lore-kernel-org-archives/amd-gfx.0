Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C3FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BBEC10E32F;
	Thu, 30 Mar 2023 13:11:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A66910E32F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk8wV+jLupZeZJdJhLRmGcsWVjq7WBVhAFWL/gGathEz7HSDlkgw/OP/s5t2egk3uvsBMzISKKlpc8croBjUu5ree43NyAg0EYRYLehgJcrRJrmeKCgUXBun5+H280GFsCYyA3j2E/Vii3TP5q3XuPM5Ny7H+k8rZxNk2KEYHDWLDehnvNgTQvUIab4r/Lkm0S+PCOxBwC7Y8Qw8DHfjWDDUSwdUvsq7UqzfTWqnsMimGYxWXrw8OxnoNksOrEJAiEIdfkZbqVi1XVVzE0mmpsilmr+yPM3CYSyv/ZRKWv8DBc1SZzqG9er8nV7L355xc2CC12gpRApznuqVGyIQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEqxanf9/vIXGnTIN1WxUCdL9iBssVwua1mCd3xeqCA=;
 b=aFsfn8VWVQP3eNUyzUvgJzwaN5thfG9/Ee4W3OTMZ/SGd/Nybve8vT3bu48Hj4TlEVnTP8jGoGsSVDG8cSfDi+1DC8h37W+VZQFWmEBZjuSZJZAWRLHVR7vn66Yt5tf8oonj2xEZUt2T47t0KFF+DPqmWWpRoqXVY+1cWH2K3hKJjVPlnuZH0EezhndKgXqQZ0W3NkTYny/pNwKYG6jAv2UidrAccs41ptJIZc7I7YdYood2AGdKw4gONwE8ZJLHqt5lOjc1QBUYWq6KnjNgLhD8OlA5XEp7BnCfbVvl65oprFbx4Bct6oqxMm1Sy35KJMQwx9eYhNOTVhBat+lFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEqxanf9/vIXGnTIN1WxUCdL9iBssVwua1mCd3xeqCA=;
 b=FCtHEdxlSZTYXm/ZdJZFeU4UAeWu7MzeUiPL31nl7dDBt/rFc7fCariUmHe69VOyhyjN9Tst7AF4JeKB5IeCpkRe5vmIkdsNDV5OZq3UryMvG6cQY9zFoAVa37ppie1zbnHgA6roUPr08LUEsHbh8jQM3NFgSmYXpQlpTRtuo/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 13:11:40 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:11:39 +0000
Message-ID: <488b89ff-e9f4-3017-503f-59456e935000@amd.com>
Date: Thu, 30 Mar 2023 09:11:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-2-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 01/16] drm/amdgpu: rename num_doorbells
In-Reply-To: <20230329154753.1261-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 888d8eb3-4286-4403-25d7-08db31204c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ykk9Py4FaqHsXOrHX3tg489WV2BnW/4RZXhwKwg4s5mOmABiVlzj5P4O6PfKyiNlRhmj67wyqvAmqu8IN6vaJOzjtIG+lOSgSIe9vA6DDrTaxP9y0HAteWqZfJox4p63XSb04/6pOe03i37kEj+LTIwQtlgqduFLYmAQbpMPnjrfJGQ0fRQ3xXNcKLBEbCrOSqkKM3JmmPxCLB6TIhN9uSAtMgFQvMLMZ3WIxj2sVb5p/Ea3498yB8/UeTCyoDZTOFxIjZ4P0Hyf8Gx+b9v5g0yVUT6bw5T+APjjZZbxSQpGuOsn70KSM/+Fg+Ksk2BIdhX6qSBdIwfnsr8Rcyf7j70zEAJeaMqp+iGkIYfUqnajHVYkjuJpnEw6wLFqnl0hDFPij7j5gw7EQBE5jM8ihNqgnXAwKaoszIXIZwJ+nGGaEL+v6JsSCxB72L2D0VMdZuFCcl3fPbxytBLdGujOGPt3zu89pdKZRUqGuBC4dzVOmwyiVmAAZKe+f+zWCwIKUrMNiyaOEg9A7wzUf8pTkXLq/uz6xiN2ye3iOEvBMOMBGytcZijbZwc8DN7GjmJ9SyjuN1UAhFk4Weltc6DgZ8jNShn5bv/oYcQXhx5lYbg45BdE85jl5opp5nFgvx3BgyDcC4GmsE74WIqjAHMtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(2906002)(31686004)(66476007)(83380400001)(2616005)(44832011)(5660300002)(6666004)(41300700001)(478600001)(36756003)(316002)(8676002)(66556008)(4326008)(54906003)(6486002)(8936002)(186003)(66946007)(31696002)(86362001)(26005)(6506007)(53546011)(6512007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BWTEU5Z0VOeXd5bzBkQmdyL0dOUzBjeThIWUJNVmw1dkl3RXZ4RythanRu?=
 =?utf-8?B?UnN5VjgxWXpJQjZ0SzVQME1mamFITzBGQmxrWGhTN054KzdxK3ZNUTFsL05T?=
 =?utf-8?B?QVFaRGMzU0h2U2V1Vy9yYmVXdEM2VThSSVNoSjhnME44T1ozTGFRNG9rZGNZ?=
 =?utf-8?B?V0xxYTR4WkZqQXFYNkRmQTBQYVd4bzVkTWpnZlNJSWpzSmI4ZHpsOUpxdEJV?=
 =?utf-8?B?VHN5WnF3NDVNcm56SVVPZFpxSkFLSFczbStMc0w2RG0xQXhGSHZxaE0xZ0Vt?=
 =?utf-8?B?QU5xOWNDMGJsQkdQV2dTcEpVWTE3c0xnMnJPaTh2MWhkNXVaUlFINFQ0eVdG?=
 =?utf-8?B?T1BmQkFhRTVHMmNabkY1Y25RbExpWXpmelNwNmR2OHMxK0RVY2FXZjRUY3pp?=
 =?utf-8?B?dGZXLytkc1lTclE3YVNoY0pVTnpQMXNSMGdSL284TTRrd2lGMGNxM3lGYzJP?=
 =?utf-8?B?aStyeDkrK3VLemxJeTVrQ0F2WCtXSWErbUJpSGRjL3EvM0RFMkI4NEFCc1FQ?=
 =?utf-8?B?aE50YjZiV212NHFFc1Z5enppUDlKcUtYZnFqWEU2L0VpMjJQRTZpYUFuLzc1?=
 =?utf-8?B?MzZsS2wxWmwvU2FZQTljQ2Q4K3RiRE03MnRicE1JMzFZYXhtQVZ2TThUVXN2?=
 =?utf-8?B?WDYyUWQyR1ZmZFh6UDhkWXVlWTdqckJ5WU5BUFFJR0dZWXZRTmVTUjY5ZUx0?=
 =?utf-8?B?QitzYytuTjZlaHBrdTRmaVVWTEk3cU5aaU5WZnVGdFFVdjJTZllOUHBnY1Ir?=
 =?utf-8?B?R01KYkVwTXFJSXcySHpwaXdCQlZhQmJJWkMveWdNZEV6ZEYrNDc0N3NhOVBo?=
 =?utf-8?B?ODA1Mk9EREo2VDd6WkVOcmpDMjA2alNLbHBmNUtqVDNmenNqWEdDWUZSWHE2?=
 =?utf-8?B?cTNSSVR5NGdTVGIwZHdYZ1hyTjBIMnVwU1lPSkcvcGFnV0NrR3BUZG1vZnhv?=
 =?utf-8?B?aGtrSXkxMkdYVjJoSnd0bC9RcFc3SmVuSHZkZm8zS0E2RHhTakhVanNYMTBO?=
 =?utf-8?B?TkFCTUFCd3NocEdyOXNwQ3lZcC9Yd1I5WnpVVUVaMzF2U0VkU1EySGw0K25C?=
 =?utf-8?B?a09ULzBBOVRvQzVBalRtWG1OK0Q3Smt0TUgyNkI5L3JVME1QN3JzSHNIK3ZS?=
 =?utf-8?B?YjRvK3FvdE9udWZnWXNNTlZYbjRUUnV6aSt1UzZwLzQ1YlNIVFlaOTNBOCtk?=
 =?utf-8?B?Q0wrUjF0ZVpOZFR5U2pGNVBiTlNRcmRZYjZiRWhXVUNZNWwxY2hJWHJYd0JC?=
 =?utf-8?B?UzVPZW92aXhNR2Q1VkJ2WU4vdlJ3VnlWUEtpd0QyUExaVUs4WnNJYnE4c0w5?=
 =?utf-8?B?MS9DSVpXZjZRZlRyWjRXaXBkSEV5UnpuOW8zb3dueUZXbytrWU80RFgzeUhH?=
 =?utf-8?B?NWdGVEJhMElLRVdGOUhCeU1SVEpoUG5aOTFaVWdCNXdGUlMrTzZyNllSazU0?=
 =?utf-8?B?T2VoeXJxcllMMFBPTkphZHZuTGJ6ZDRsRWlxODExc21JdnJmSnZiQlZKSHA5?=
 =?utf-8?B?R3p5REl6ZjA3WURaMHNCWi8zRlExdlVXMFZiSHF3cDJXY0hsMXNhZGI4bjJt?=
 =?utf-8?B?T2tuL2pvSDJtdysrNlVmZEFBU0grL0pPRTI3LzRHaDRqdXhrUHJNYUthbmtq?=
 =?utf-8?B?Ujl4OHdWaUxaYllXVTI2a0RDVXB0bHZBYlEvdVVVZFNabEdFdkpKZFlhd01W?=
 =?utf-8?B?Y2ZIMkVCcEI4R002OTRJWWFjdGI4UEkxOHN0NFBqWkFJZVp6TGZLVTRmc2RX?=
 =?utf-8?B?aTN2TGxmbmNKUU5zamxOZlRtVWRhdGwxWDBOdXRSMzVudTZwZ3hSNXZiSzN1?=
 =?utf-8?B?cGNUREYvRUJ2S1FydEg1enJyYTJ1QytwN20rdVV3RzVVOEVwOEkrZjdDNC9D?=
 =?utf-8?B?Q3ZtRkJtSk9EeER5MDhYMW5CY2t0SEE5WVZuT1MyZDFIbWU5a09aMTZWTjRi?=
 =?utf-8?B?ZjRaeU1tUlA0Qmg2RmdwZXFEMEhkYTR0bnRJZEZ6NjhoVExvOEtGdGVLcVM4?=
 =?utf-8?B?TzRoNnY1VDZsYUNJM1VNQThrb21pSG9kUGFTTVU4b1k4NmtzMk80WmxVanVh?=
 =?utf-8?B?ZExBZis5c1pZOE91UGo5ckZhY2ZUTkRRNWt2LzJUYjVFZUFaTVd4ZTdWTEZy?=
 =?utf-8?Q?DP+j3w7R1NUAmg6rdZc7ZjLhe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888d8eb3-4286-4403-25d7-08db31204c94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:11:39.8854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVVZF+kpXvTKyqxA5za0HByqPU8MlJybutG2dqcnXfeXj5CUn1wTZNonp/UwgL66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Shashank,

Inline:

On 2023-03-29 11:47, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> Rename doorbell.num_doorbells to doorbell.num_kernel_doorbells to
> make it more readable.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 +++-
>  3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f99d4873bf22..0385f7f69278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -96,7 +96,7 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>  					 size_t *start_offset)
>  {
>  	/*
> -	 * The first num_doorbells are used by amdgpu.
> +	 * The first num_kernel_doorbells are used by amdgpu.
>  	 * amdkfd takes whatever's left in the aperture.
>  	 */
>  	if (adev->enable_mes) {
> @@ -109,11 +109,11 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>  		*aperture_base = adev->doorbell.base;
>  		*aperture_size = 0;
>  		*start_offset = 0;
> -	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
> +	} else if (adev->doorbell.size > adev->doorbell.num_kernel_doorbells *
>  						sizeof(u32)) {
>  		*aperture_base = adev->doorbell.base;
>  		*aperture_size = adev->doorbell.size;
> -		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
> +		*start_offset = adev->doorbell.num_kernel_doorbells * sizeof(u32);
>  	} else {
>  		*aperture_base = 0;
>  		*aperture_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index afe6af9c0138..57ee1c4a81e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -593,7 +593,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		return readl(adev->doorbell.ptr + index);
>  	} else {
>  		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -616,7 +616,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		writel(v, adev->doorbell.ptr + index);
>  	} else {
>  		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -637,7 +637,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>  	} else {
>  		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -660,7 +660,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>  		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>  	} else {
>  		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -1034,7 +1034,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>  	if (adev->asic_type < CHIP_BONAIRE) {
>  		adev->doorbell.base = 0;
>  		adev->doorbell.size = 0;
> -		adev->doorbell.num_doorbells = 0;
> +		adev->doorbell.num_kernel_doorbells = 0;
>  		adev->doorbell.ptr = NULL;
>  		return 0;
>  	}
> @@ -1049,27 +1049,27 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>  	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>  
>  	if (adev->enable_mes) {
> -		adev->doorbell.num_doorbells =
> +		adev->doorbell.num_kernel_doorbells =
>  			adev->doorbell.size / sizeof(u32);
>  	} else {
> -		adev->doorbell.num_doorbells =
> +		adev->doorbell.num_kernel_doorbells =
>  			min_t(u32, adev->doorbell.size / sizeof(u32),
>  			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_doorbells == 0)
> +		if (adev->doorbell.num_kernel_doorbells == 0)
>  			return -EINVAL;
>  
>  		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>  		 * paging queue doorbell use the second page. The
>  		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>  		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_doorbells should + 1 page (0x400 in dword)
> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>  		 */
>  		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_doorbells += 0x400;
> +			adev->doorbell.num_kernel_doorbells += 0x400;
>  	}
>  
>  	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_doorbells *
> +				     adev->doorbell.num_kernel_doorbells *
>  				     sizeof(u32));
>  	if (adev->doorbell.ptr == NULL)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 7199b6b0be81..12263986f889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -29,7 +29,9 @@ struct amdgpu_doorbell {
>  	resource_size_t		base;
>  	resource_size_t		size;
>  	u32 __iomem		*ptr;
> -	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
> +
> +	/* Number of doorbells reserved for amdgpu kernel driver */
> +	u32 num_kernel_doorbells;

The variable name should be indented to the same column as the previous variables.
	u32                     num_kernel_doorbells;

With that change, this patch is
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
-- 
Regards,
Luben

>  };
>  
>  /* Reserved doorbells for amdgpu (including multimedia).

