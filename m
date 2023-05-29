Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A710C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 21:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DF510E2FA;
	Mon, 29 May 2023 21:38:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA7510E2FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 21:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYf0sJeQjk9aNOgYdvM9qfWkAi6dMPTr0aKjV5bHe5tEty79UKGx8Lcmchf2h+Lz9u94onjR7no73/b5ETGFMz4Ii7rO5aPGrVolBC4itLG8cVtkkY+91eOrmwSypJKOssOYoxB2k3GMSxh7PSHqxK9uY0bxUllQU3nIZXDRL33WxdPgA3T6A56E/cA9eu9aAj1KhsYfAWVWpgG967Htf7vW2WSx4QAqqNWlTJo2qAotCbtIBvu8raYCAHm7n2RDoVFx6J9a4I4hnYFloZdXTcob2g/Qm/oDiiyjgqvrMISvp8ZenMFeMR+vYlBhZP31/SeGB4dKPVDnjIhuILGl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIcg3U7sVVatndDbkZi93i3rYP82h8PaFys5hr3DuJI=;
 b=Mkfd4pGzAkfrn/wsjOY0mjST0asLtWjCwsuUyiA92zhFHdjedca6WVErIYl7XZNn317DmdD2gNJPJM/euCZdhsuTQBUY1Ib1S+ZcSjnyxiebxl7SIhMLfqDbUpMMvz2hWWYt9sdCPbYAx+Dn/fFkzoMn7eWG/VoRKhpeIafawm8tn7PtB+gzrtS5yOWu3gtckCjmwbOzzTSu+b9vFFtADQ2tXeEwt2QXaY/mEMrTXUx3IHse+WFT5UeG0QiqG4Zghs9UMkkyaW5qaEN0d0MwkoGBOBAnS+slSTe/YHlsLzJ2F9Z62NIuxDvQ1GUix0FBa3tQp6OF9+X14tOlar5szA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIcg3U7sVVatndDbkZi93i3rYP82h8PaFys5hr3DuJI=;
 b=TWpubwrT1aPLEosJVvYxPA9k2/bXV8qOftO+M58H4YjTG0anaZmj/jJQ4FRLLHoEzQbhExdQNIrVthXEuCQ8qgCXTpHYV7M5zXHMhXq+H5LSxtAZaKF8iUJyWOJGdFRzh2rb/5NpJsyAuYLdp9+GELqQQv5OjzTQn2HMF4L5JRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 21:38:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 21:38:49 +0000
Message-ID: <cad8358d-334f-d54c-4130-6d276698cd20@amd.com>
Date: Mon, 29 May 2023 17:38:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: flag added to handle errors from svm validate
 and map
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230529211143.25265-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230529211143.25265-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: ed875811-51c1-467f-8427-08db608d1680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIxQit/QR6XNF+E7dpzpS7tgx0KDJM03nbeeqdJACTp3pDXsoa+wvmPWqvdxPiCy+J1Ww0se1dBQllASJWJZaAO1kWRxjr+ipTvmqkWVn6EUJLURRf0S7YI/l3xFgGF+lrb6iYoqhK1DYBXb/jlHikHlPtVBhzuUjKsuQOdFOTTuEsYuhJfdtX8Xx9hZbx1ZnmuM2joO2sMK7VMC0yXXPApewj0ZoHfCxE9qu1sJuS+6rBGISXjoGAVNbNCM81M+da+LHolWWaGwhZr7UnemD7WNH7BxhNR1dcyy2jKxm/Wp3lscE4AcDw6KaXiWFqEaekUGob0dKQaEh0ixOhyBMEgoxScNDoompBrp6gvLoH+vBHNgpEZsoPWAJK7imgqsoabsIAH69rAZmIVn4sFr00/RxnrL+hbXRxIv0XvG7okA12O4vtXcT2x7Ht4Kii7d3K/pTJT0YLmobvKckZMQuHB6O86wxbVbvwWKRYM+10rx5TjSPC1/zHcaX5HOHN91pMlXPMUq4v57jspyRpH9HoXl6a09wfuKKVFGQ897V/SHAURIXPogHzBxFWdltYyMRe5DstVgoq1KXAAmm/7Rx03FFUEne1oC/+NnUy5a3ROLe2WFppmlfoHkU9dz/Bkr92GS49mTl3YfofR/82MFNkGBDWmzZgUgcivph9xUg47aNWec+JvPfgK7HfEeqfHx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(31686004)(38100700002)(478600001)(86362001)(66946007)(83380400001)(2616005)(66556008)(66476007)(31696002)(4326008)(2906002)(6666004)(6512007)(6506007)(53546011)(36916002)(6486002)(186003)(15650500001)(26005)(316002)(41300700001)(36756003)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRsMlM0a29zT29mM2lIN0JsWGR6TVhqSXloT3NvNjhDWTIrSUJYUldMaFJV?=
 =?utf-8?B?T1B4ZDRYUzhWbTVXaEV2a2hnbHUvY2ZsNlNtbndZS2JPWUJnRW9ucy9lSUdn?=
 =?utf-8?B?NUlybXA5SzZXampSL2FKT1d1Q3VTdGNFMzJrdDVrbkJCZG8rd1RWSTZOQlBZ?=
 =?utf-8?B?NnJxeStWQTFBbXBHZGlmNDF1dU5PRkJ3SXZ1dlFwQXdibzh6bG8rTk9pNmx6?=
 =?utf-8?B?TklWckJnK0hPR2lYOFNNbkYwN21Ud2VkY2VGaXNHTW85dkN1TkFRd0V3eE5z?=
 =?utf-8?B?aUxKTXJycnBtaG04RXAveEN5L3dHZ2FQZmtycmh5cWNZeXpTZE1zZ3J6dEZm?=
 =?utf-8?B?TzJmcHdSR01XN1BuWS8rK2lMN3JuZThpdG44WlVDM0NKbXRvSG9TaVRwaXJB?=
 =?utf-8?B?N0VCRFk1bU9BdFRtSGo1ek0wRjgxTmRvTG9xSE9UcGozWWh6SHF0elFra05E?=
 =?utf-8?B?ZHo2b1ZlY1ZUUmVxbkxlUXdaN0FQWit1MW9XQWRtdGlTZkI4cXdLbWNKVzds?=
 =?utf-8?B?T1hSNjlhUDFLU0tRQm1RZmFUTW1PVnJvMk9FMWJ6OU4zSWt4Slp4Rk9zakhr?=
 =?utf-8?B?VDkrR1NJQ0xPR0VzTFBzUWRHQ0VJVUdSTERaZFlKL2V0K1ZJaGJHNHBweTh1?=
 =?utf-8?B?SGVSemZpMUx6Zm1CbzdmY0JWcitad3lFV2RRY2Z4bENCVXAzdmQ4ME80MW4x?=
 =?utf-8?B?d2pNWWh0WWptTU9rK1JISEpmSjhlWko1UzVTUkI2bnVFRUNBWEE4dk1qQjhJ?=
 =?utf-8?B?M2dRdktiUlh1Slo5ZTNuWTZlcWhNdVVvYkx2RHNVRXNvYnJrd1hZZEZaUGV2?=
 =?utf-8?B?YThBODFiK0kwUEVOYVlSU1dKYXNjSWR3bVhMSDFHMGJ5WEZZeE5vVWxGMWdW?=
 =?utf-8?B?TS9SWWEzdXdlcVZMRFFKNVRvV0ViZ2w1aUJJbFh4THMxNnFlbzdhU1VDVWNW?=
 =?utf-8?B?NkJVUEg1QnRtLy9xVkMxTm1lMStZU3drQkhZWUVub2tQY2JEcFlPdm40L0Vt?=
 =?utf-8?B?N3lTWXBFRk5aTDFRY1lPc2R3RGQ1OUdVZXFlK3YwNUxPSFB1Zy9IcjZHTGdl?=
 =?utf-8?B?cUdmZGJEOW1BYTNnUVhEcHhULzg1QUhTdm9YV0dlMGZRTEx3T0QrL2hiYklN?=
 =?utf-8?B?Y1FpUFRRRlBQV3pTdUFiOHlrdlF1ektLNTVLQ0hNYUZiY1lvK25zaEtyZ3RV?=
 =?utf-8?B?a2YzZEk1Y0dITm9mUVRZNGFnZHd0VktubnJBZ2ZkclVsN1NQS2ZPdXVYS3d2?=
 =?utf-8?B?V3g3a0pOSHYyK1k1Q25weWQvRkNpaDh4Rm1Dd2UzMzNwZG52ZFMxUDJBb2t5?=
 =?utf-8?B?UW1vVjFvMk5TcEE2d0orZmhVSTZMNmZMZkdaeEJPdGY5VTdzaDFxbUtkMHl6?=
 =?utf-8?B?Y2xkWWx6eDEyRnZyU3hkcnRxeWJGZnBiZmh3R0x2UFU1T2gzNy9pV0hBQldJ?=
 =?utf-8?B?aDRvWW9CNzlmOUhGREpzZkpieTJKLzJYdzNLZG5yQWlERHh3UTV0R3UwOUxr?=
 =?utf-8?B?andnaWFGbmROcXpXajBra2tGOG5FYWlCMUpXWTlmZWZGMlBCR2pOeWNNTHRZ?=
 =?utf-8?B?NWNSVlRYYXdlb0RtNnduZjhQSTQ4aWY1MjN1QnYvVzY0V0liY3RYelVkQm5i?=
 =?utf-8?B?MzVzckZFY2NMRE45endpbnZCTDhoZTFTdTBMVE12b3ZhcFB1SWh1dGNMdzJj?=
 =?utf-8?B?VEt4cTJPTUk4WTh1UllOK1dtYWFmTGNScGtKUHEvbUJXY1hIMWJXMVAyODdH?=
 =?utf-8?B?dmZDYWkydkN2ZzVQZVpaQ2lJT08xSzM2ZE5DT0tzTEF2cGZIVlpDVDBMZVQ0?=
 =?utf-8?B?QTlBemNOZGlPT1ZsUkJnV0ZQRzVzVlhiNmhCNFllWk4xZU8vNDBtaFVBdExZ?=
 =?utf-8?B?bmx5ZUpwMXZkVWdJWkd4R2p0eVVpeXk1MjVPamZMcEhGWXg3RkRpR1VnamlH?=
 =?utf-8?B?OUtWeGhDNFlxY3BON0Y2TEljT2VDYytISnh2YkNmL0ZHTS9uYStpc1dWK3BC?=
 =?utf-8?B?c2lxaGZ1Q2pHK3lDNC9LOGNDdWROSlRDNXR3RmIrQzE5ODhFb3VOazQzQWE1?=
 =?utf-8?B?UTlwazNpRTJiVGk3NUJmU1hvR0NKVllhb2lEWWZzR2dORlZ2cDBiRVJsM0lv?=
 =?utf-8?Q?DQpe5Gc/gifrR//snY4/RTJj/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed875811-51c1-467f-8427-08db608d1680
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 21:38:48.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jhiCSI0OU1fC0egPhlaksJIz/perkD1hH2+h7NqlfMdEV+JFfw/F+UTlrS6ag2aLpoZwndCyaw/adXzKil8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-05-29 17:11, Alex Sierra wrote:
> If a return error is raised during validation and mapping of a
> prange, this flag is set. It is a rare occurrence, but it could happen
> when `amdgpu_hmm_range_get_pages_done` returns true. In such cases,
> the caller should retry. However, it is important to ensure that the
> prange is updated correctly during the retry.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fcfde9140bce..910c0269598a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -823,7 +823,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>   		}
>   	}
>   
> -	return true;
> +	return !prange->is_error_flag;
>   }
>   
>   /**
> @@ -1657,6 +1657,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   unreserve_out:
>   	svm_range_unreserve_bos(&ctx);
>   
> +	prange->is_error_flag = !!r;
>   	if (!r)
>   		prange->validate_timestamp = ktime_get_boottime();
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 7a33b93f9df6..b716d4bf7ee0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -133,6 +133,7 @@ struct svm_range {
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>   	bool				validated_once;
>   	bool				mapped_to_gpu;
> +	bool				is_error_flag;
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
