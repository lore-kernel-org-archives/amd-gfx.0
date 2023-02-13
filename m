Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B8C636CC
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 12:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C3010E5A5;
	Mon, 13 Feb 2023 12:38:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F74110E5A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 12:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4JNX5yOCWxh44X8lVCxyo5CpDjbGs7HuMYsoZr38jyeFeirGOMP5+q3kn5DqTk9EJ5E3Lfuo2zgs9mlUIOJDwMU0yb0ibLbNkADymvjNHOMs/VPBDbB/NBfsfazhiH3KS7sNFBTfB1pqTIDvwKdddtfncp2kzpeTcCZbblg0j6TOZ7e4d90ToW9DVO8yLfm3EkgoUfuE9nHXH8bzAC54H8tFTl23NCQzECV79tfoVeqpiAs+XCcodlxCsimK8wAROF2n0oDKESByB5fdAts+1gjTXNtAq38zh6hysne4KB65aIe21rW7BCySTs22OnDu3UYgkR6M7FhyDjHzxOZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gMFK3XYFOqjPBXDTaL3+A8C0Tvo9tfGnYug4Gy9eUU=;
 b=ET0NNUKqGR1ozTkKPM0MDp8C1DzrHsRVdQhHN9q1nYVm16UL/NRtLdBLuGp0NDRVaZMPY7GX6O9swfBuPcEnubYsaaBhkbPYxAXwnVx+My9GLCB3ng8azEPAjnY8yc04REOrSAt7SC+Ctl0Sw9r17juMpPdmFBRwnI7JQ3qTpMuSIhYpra7tHonJfg7FVjiWpYD8zHRqkA2fLV4LoEvH4arG4L+iaVGH1gvUw3qWZ3gRG+NW61jCG9FYi9MjeSFvtnacK25ZuDOjDL6+E8iqHEH2RXWSeoPRay2BL/24RYMQDh1brOogmsMq3JXaez2D5cpJcORXHqPICQnP5rY3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gMFK3XYFOqjPBXDTaL3+A8C0Tvo9tfGnYug4Gy9eUU=;
 b=CMB0BDL5Tralv9/tf/roRgRlx1UkXcTlQPXDdzh56BeHHjGQPh4Wq8QLbRU7wCK/YaGkPQQUO1e3lQaa5z56E1cXY9g60YO/Mho+bBRGw+RNk41gXwoPy4K9dVTJAdafZv4PMohhA4aYTxJFXzt8Rty71+KJ0Hw2OQFRwT4Vp88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 12:38:08 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6086.022; Mon, 13 Feb 2023
 12:38:07 +0000
Message-ID: <fe541c9c-4684-fd02-e5bc-f28b583744af@amd.com>
Date: Mon, 13 Feb 2023 18:07:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com,
 candice.li@amd.com
References: <20230210084529.9695-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230210084529.9695-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 3966e731-7431-4f89-578a-08db0dbf288a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: co7sqZjtIdedtpakQWC+SI9hBU/C1mQ5vScXUHLeDLGrz3Oj0NumnTBKTyBUxoPSPNB7KTmDIbp7enPLDaFBX4tEKkupkWnBOCvMQ9NDhjN6HHyahYTmCD4g6A8zX+DFc35cVPlyNlV2m+0jh6Dnkb9May42/AayraLwcEkBPjBKltcKrUEeQ89hphPyr3QckfXn4MKQEeuSvKZ9zhp/Dzw2sGwqhJJSZKt1R/2+E011e4b8B0xdRpxj0LLYaUw/mzDpG2Vjx3jz1U9uLMoZmI95ywo8MbFEVG5a+4SzSldVq2KsXLPjiwED8CHtK775g4wBueTErNpjDvxkDdMpuxXi2SANgwMtJqXWAlUwzUVXRgNPjFvqtiwX02w9eh2G5y/nzR2FdNuOdWMrlQhDrgaV+DjbOKnDlBENB8gxmnm7uBWjhCJObYnWHvoQaCItdxf5Pw3nVs+MjKesYk63b/rduYHcRPSm9z7f8x/u2QW/RbRqDU8aL7a4jtLV6yjRAWDmJ3F3G36WXijkVcJgKsIcU94NHHdTGteRtDShxhWTXLexgW7wnTLWlml1uvEnUWD+PHLX3tpXk1z26hXGo027pb2GATNeYfx+1rgEi77KGtdSJF6Eg8FJIZGcVZdDSRKgRgWVUyd1qUyZ+xRXp/c6am+XEVYFEI1sPN0FTOTtEjn0kvu3Vj97QhE2hCOz9rJxRwqQAEv4V5oKI8z5cJZ7AjeKonzjJjqFHeWlP1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(31686004)(31696002)(2616005)(86362001)(83380400001)(2906002)(36756003)(478600001)(6486002)(53546011)(6666004)(26005)(6506007)(186003)(6512007)(38100700002)(66556008)(66946007)(5660300002)(66476007)(8676002)(41300700001)(8936002)(316002)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BMRVZPSGRDRmI5aGV6RmhkMGx6SXRDRjUwRHlteTZta0VjUExGOTJLMEI1?=
 =?utf-8?B?VktUQmxadWZ6V2hycUt3cGpoZldZQ3Z5ZnU3Vyt5N1p3TFdXaHhnWUpUc0I3?=
 =?utf-8?B?RkxOZDc0YXF2SE5QRFBCVW5teXhJQ3JOWjYvQitNYU9VZGpiN3RpNVJXRlVV?=
 =?utf-8?B?T0pkTzk5NzlNQkVOd3FLZ0dRQ2Y2UWdTakVWSkhnTllVS1NlakxKcG5GY2k2?=
 =?utf-8?B?N2g0ZEFnTGN2VGpycXl6ZzUrQ2NONzlhanY5ZXVGNFExeEdRSEUyL1hvdXNG?=
 =?utf-8?B?T3pqVmUzRFh1czh3eUtPSHRLazF6UVVrVFZrVWYxRzBzejVpcE0vSDFTelQx?=
 =?utf-8?B?SktUNGk0enF2YUdodXNTWjIvdU0xWGtqVVlQcmJaUkRsRUd2VXJpT2gybW1D?=
 =?utf-8?B?eVVSNjlUNHFhV3lOZ2FKQm41Ri9Qb2tWdjNqTWF2bXhZTmxPMTVQRzhuU2RT?=
 =?utf-8?B?QXpqbFQ1ZXh0a3VOMWQ0ZzNURnFxeFVkeUlEYzNWZy9nbFM2d2ZjNlF6Ym5V?=
 =?utf-8?B?eDdHZGZWQkIrWmlOa3ZrUVNNeXArK0tvek9HdE9VVG12aDdibXFucDEraU9V?=
 =?utf-8?B?UUlnTjZSNVIxYXY5MTFmOXZRd25YakduaE1KNWZxZWJoSFA1clM3a0NyTzRM?=
 =?utf-8?B?bllNL0M4N0NyNHJrTno1YmloWXQwU241Tm9Gc0F1clhjTnBuWUI1ZDkzSWJ4?=
 =?utf-8?B?UFdSODIyYTRYTms3aXU2aXBuNHBWNlk2V0tqb2d0SkZUdGFNOTlUWmJaYm9p?=
 =?utf-8?B?ajlCZTRJOTJuQ2R0dVgvcklEc21JRjBRMEtZODJheHZUTHhDUERIUmlBak1q?=
 =?utf-8?B?TVhZMlBEZU9NWlVFamdqRkl4Q25ibFI3QVFpNnFDUUE4Z3FrVUc0cEdoaXRR?=
 =?utf-8?B?dGhRRmd0dTNLVUlvcmJxU0dHeEdldHVscWVwQlRaTy9PNXZJeVlFUjFHeWFo?=
 =?utf-8?B?SG01SEhzVVhEWVIzc2t3bFd5TTRZd2VSRzdpa1B2UHZMSCtreTFGMkx2MndE?=
 =?utf-8?B?dExBV0hMMkJUYmdUQ2pEZ2RWSjNjNkk0ZUJtdGJtSnNLTnhTOVpBSlpQOUxU?=
 =?utf-8?B?QnhHMVhJMWFFdTIrM244OU1teS9OeVFsRE1Tc29COGNmOTFSaXNvQndCbFhK?=
 =?utf-8?B?K0pGd2ZqbnlqRkVFcFg2cy9URU5MWkU2UGdXVVNyclZ5N1BmRTNCd01Gcitx?=
 =?utf-8?B?UnRJN2E0VlBPcks0bVNSOWF2Q3JVOWllRFAzOXVicjlUR25iaG9LLy84SVVv?=
 =?utf-8?B?S2VjaXBYR3NZNzVXQ2Zsb3FaR0thL214NjB6TjBCdnlHRGtGOVVpdkVjWUxX?=
 =?utf-8?B?bXMxZ0daaFY4eENIN051ZERLUmc1U2dPaGtwUGhtcUpxWFV6aklZclZUNTMz?=
 =?utf-8?B?QlVhU3ZpR3ZTNUFZQktLQlVBNHVTUkVWRzR3eUJsbVIzQjF4V3ZTV0c3eTg4?=
 =?utf-8?B?dSsvUWh4YnF0Q2pna3o2TDRjZFRYNGY2YUFHVlpHejlXSFZmZWlhbXZsaU9V?=
 =?utf-8?B?d0VKWFRsaXlzcldSR0JQU3VZZ0JObVlrbXlnYkl5TmFXT2dWV205UlFPaENB?=
 =?utf-8?B?SHZuTnVwem5GVExHSVNMY1BNVTZHVmlEY3QrdjNwbzhBOEdPVjJnVmR0T2o1?=
 =?utf-8?B?V0JweEZUR3hVN2ZSWmQvdHZCeHpmK0lwUUM1WU5wR3JpWTNRM3kyUmlRd3R2?=
 =?utf-8?B?emtFQStYTlpjSTUyRFlKY2liWTd1VmsxRDM1QjdpSDNkcjk1VmIvL2V4K0tE?=
 =?utf-8?B?U0g2akJpRnBlSFNqaGc5UHU1aEtaMk43dFpDM1FIVitOM0NvakU0N09wWXdk?=
 =?utf-8?B?UXFtUnhOZm1jWXZLMG81bXE0TWtmNDNrTXI5amk1dzdPMEhsVmxPVzRXU0Uz?=
 =?utf-8?B?SXFkLzVlWGhYa3ZOZDdJK2tpajlKbzVLWEswNzJrOHFGVm5lck5XL01VQStF?=
 =?utf-8?B?UVAwTi9rdWN1Zk9KUHg2Y3ByQTZ6ZWZPZlgycjRCdkEwUHhucnZNbXpmYmFF?=
 =?utf-8?B?cnVQOHdxUlBRa1VxaWU2bDkzRVRXYU5Ycjl4YTRSUXVxeThCM2EySTVRVEpV?=
 =?utf-8?B?ejhOeGliSHFzRXFsSnV2YTdtcGZRZWZLMHA3Q1ljbHRCMEhXL2tVeTlpTmJY?=
 =?utf-8?Q?Bu8IVS+t1h6/CtpxRqO+9n62U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3966e731-7431-4f89-578a-08db0dbf288a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 12:38:07.6876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EieMKsQLV5Bb6DpDiOeMbz9y1brTobeGF0QrpHD7Zpdp6LCRXySh9j7hbqg2iIXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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



On 2/10/2023 2:15 PM, Tao Zhou wrote:
> If a UMC bad page is reserved but not freed by an application, the
> application may trigger uncorrectable error repeatly by accessing the page.
> 

There is amdgpu_ras_check_bad_page which checks if address is already 
part of an existing bad page. Can't that be used?

Thanks,
Lijo

> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e85c4689ce2c..eafe01a24349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct ras_err_handler_data *data;
> -	int ret = 0;
> +	int ret = 0, old_cnt;
>   	uint32_t i;
>   
>   	if (!con || !con->eh_data || !bps || pages <= 0)
> @@ -2060,6 +2060,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   	if (!data)
>   		goto out;
>   
> +	old_cnt = data->count;
> +
>   	for (i = 0; i < pages; i++) {
>   		if (amdgpu_ras_check_bad_page_unlock(con,
>   			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
> @@ -2079,6 +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   		data->count++;
>   		data->space_left--;
>   	}
> +
> +	/* all pages have been reserved before, no new bad page */
> +	if (old_cnt == data->count)
> +		ret = -EEXIST;
> +
>   out:
>   	mutex_unlock(&con->recovery_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1c7fcb4f2380..772c431e4065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -145,8 +145,12 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
>   
>   		if ((amdgpu_bad_page_threshold != 0) &&
>   			err_data->err_addr_cnt) {
> -			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
> +			ret = amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>   						err_data->err_addr_cnt);
> +			/* if no new bad page is found, no need to increase ue count */
> +			if (ret == -EEXIST)
> +				err_data->ue_count = 0;
> +
>   			amdgpu_ras_save_bad_pages(adev);
>   
>   			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
