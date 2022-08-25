Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC24C6498F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 15:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F09110E66C;
	Thu, 25 Aug 2022 15:14:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042B310E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 15:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgPt+IAYFK15tX7u7v/eQ3v/UwCneIpYEgOBFEmOMKb83Bw4NNbSPOQVo9shEgS0fQ4hAityKYTjOqr8pgLO84NWx7dYBrgIJmaPJtJd4+9RCSzC+lijZyB6Np8xOTffouINE8mT+9XINw3RkPVpK/R7Bve8E/3l1ZyRJgqpbWJ7RaHXTUM6oSQhFXAHmqXbl4EnslyWUl39CQgAc4kTJEI6WJV7HzVMWioov/+k6EWUMvoWYH4sH+v3/NyyFoSE8HmNfz5OInbBl5NbGBInGBhLKk5Fgp1EIbJBPeV7cqCdHveKnG+lGrOGMrOuElo3JQjCd5tE1ldkxOdCT94wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhkSq+Ee73XtE4WdVFiiOOMqXXz5QWaIogU3aEQAoqM=;
 b=WZaelQPR0ITiCFLkHM1xqye0RMojA4XujooZwOoFMNLIGsiQNJ4aSUuJkZjjGj/zbM71RMY+SQWeqCE2G3FPUKZmv2Hg97bcl1O5T7OI37DJ8VTk7NM5mTFn68MhwXss/gq4G2MLGqWm0ebzeNr9hpMi8fTDvCSTOblxVV/5jWtSXdY6cSTw6lml4ERP8+7ooVyS3WXkFQ7//hoB5M98KD/BvZwpxqIpchdETbqBaCIVJCfm7SrwMaOnbT0ESWEKWC4pB5sqwwdcjJ6KD1fSvoEvKmTUlTnIUESnKypHH+SmRtJn+jxK+X08DHE442DEfWDcgBhafbHWlDe7C3rzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhkSq+Ee73XtE4WdVFiiOOMqXXz5QWaIogU3aEQAoqM=;
 b=gMJZGbZOB13qtonJm8MYu8aBWf9+9Bq/G1xUfK0qZX9g9LH/wbyXAxDMsuB/Gvgz8EvntV7MvLkDmsPPPc9kXey5CRoVaJnhG/DxldQHZRXe5UVyMNJLPmENW6hoifJNHxbCI8dWMQ++nDga5KLxmehBDrr5K1tAAPScAoB6NNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 15:14:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:14:50 +0000
Message-ID: <c361a1cd-5cd3-4b31-0aaa-4b91e7b73f63@amd.com>
Date: Thu, 25 Aug 2022 11:14:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220825085820.1228641-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c534757c-ac00-494d-df12-08da86ac8ddb
X-MS-TrafficTypeDiagnostic: PH0PR12MB5484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGnlgoZtSwWoSzVlbo4rwcgABOI5KyqV/8DbYVY7MrTGWN8BfKaL6K4HWzh6tPjhyYRdzuChIqFUQy0xNEa14Puwpk4UzRsbGkTbN9uWtLUnMM3FjQq8q4AOBDq6Lk042WgSInyBiat1mwl5EsfpggpUp449zxdUKPTHbTS4Zgx0oMP6Y4v6BwqOwk5SHfuL9moDp3JErNqYOYPC5BX9yAhx4IJHYjxQm5fYNJTNSmFJUhL8UE7FAGtrZQBadDiPslF7VCCt7T72lV0f2ME/p5xeietDYAtAlioZv10dPoiS+/IGxR85MfzA55B5iKCtHX0w8pr+b+mqmsqFnsD2JN7W1Lu5Tny5i0VIpS2kqkLJaUjpJUjcBe/4L/EgXsC0fi0Gy9xSEImzMo5837HlFCNVUnUA3+64tfjiymXsRSE/qLXyqWfso0bmNzNIgxJGwG704SXEMYrYGtDRnAQdm/sYN/f+XzyQE9AQl+dEXaipYU4TGKt+NVFOdiAgeqUA2RFeEH7pv2XOKZxYNtWsaWrpDnTWsljG9xvmtqRB6NJlhtQeLCtUZ5dFE2jUkc0qv15ekTeOwXI4Uxg1woFl8CHfquCv6qA9KliGKw8VkEKazPl6ehEsMlW3bGieBhVKVwjJ4J5dKD7sX/mcnVu2HsBnI715o4P4P2yV08boYwoHfWTmmmuJ0Ewn8UihAWKbdDVsIU5VXYVLyLq/ubwL7XOq4u0OjQFHh+oK6/CPY2IKWgKBqIJp3vAalrFzYKgqr44Ko9zywDOmeP6yopZ8oscmOZ17Hl8ZYFfRgsQgt5+LzEfiph1cxjc4iqw2T74fOryvcGebqfv6l9z9MyYG9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(44832011)(8676002)(66556008)(4326008)(5660300002)(66476007)(36756003)(38100700002)(31696002)(66946007)(83380400001)(186003)(6512007)(6666004)(26005)(86362001)(478600001)(6486002)(6506007)(41300700001)(316002)(31686004)(8936002)(2616005)(2906002)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVGdjUxeGxmUEk2ZlkxNHN4OXNxM1laVU56MFRtZzMrazc1WW5UMlAvL2NB?=
 =?utf-8?B?b0tLNzBwdmw2Tmh2M3AyNEMxWE9YTEZlNlZPS0RIay8weVdUbE96VTVia01C?=
 =?utf-8?B?aS9UNDkwZ3NSdnhoYVRjTzZKeUREL0pKSjg2WHlTNXByd3p0UmQwd2pTcUhj?=
 =?utf-8?B?b2VEdnBQWVV1Zk10czU1MlpKeGRmOXF6Z3hybXE4anJmS0FLUjdYUWM0TXd0?=
 =?utf-8?B?bGx6VzBsbHRCTXRrY1pXRmNMaHdhVm8relZzMENqcHVzbFNUdW9tSnFWRC9E?=
 =?utf-8?B?b096bm14bmN6djlldnVDVUJVU0oxTFNXVldFdDNxZE9PbUdqN01ISWw4WVI2?=
 =?utf-8?B?WnNnL0J3ZUg5S0hsTm9ncTJ2UVo0R2xUS2ptV2Q2TkdOWWVuQ3VENkVGQXNO?=
 =?utf-8?B?T2tOQTEvaWoxWVkwYms3VzYvbDlxcmdMYXUrYzdpQldmQWdGOFoxc0xTcnlq?=
 =?utf-8?B?djFweGRzUEFVR3lOOGhlQmYxd3F0d0hoVXlLTDNIOXNwdlE4SVRiK1I5TS9s?=
 =?utf-8?B?STBiV2lpRko4RUhPelFUUy9xeDZXYUROK3Q2YlhuUk1LU1RLdzZjSHpjRGtB?=
 =?utf-8?B?YXVqQ0p0c1FNU3ZRcEY0U3lSZTFlMExzV2lVdk5UeThjM3dhanB6K1RXS0lK?=
 =?utf-8?B?QUd5M055L0Z5VUExL3hCNmc5ZFFoV2l6Wmw1UUpDZ20wREdxbHNTRjhiM0Js?=
 =?utf-8?B?NU4vVlROcXdLZWR0cnNrT2IvR2drVTZFWU5yWFZ6U0c1aWc1STJuQlRNT3lq?=
 =?utf-8?B?ZWhPZlp3V1EwZi9PeU5IemVmejlKMEIxT0lFdFNpTTAvR053czczcmVkZE9E?=
 =?utf-8?B?MFoxQ0JYczhzQks5ZnQzV2YwMWZ6Y21TbUVxeWtmYXREY1J0ZGtUS0RNM1BW?=
 =?utf-8?B?dU92L00rVnZJaCtQNnN0THhPbHNGTlJycFB0Y2czRCsyYUMzTWc3V3c1MUZq?=
 =?utf-8?B?bXZrd04vWDFpRlcxcERJcmt3V1NlSUJ0bWR0bUZNQndzR2xiNDBRdnlqSEVR?=
 =?utf-8?B?NGIwU2txRTYycWpKcjc3bitLby9ZM0xUZlg0OTRuYkU2QWxteEdFWHBBSHpN?=
 =?utf-8?B?cVlNb1dTY1JtN21CcStkNDNCWXduN0hvUVRHb2xMb2RUc3FJcVpYVHNRTmZV?=
 =?utf-8?B?TEl0M01mK2pnQW5hWTdpK05IUGV3a2p1bkhBNUF6WXVZSkhzUGZMbk5nUDFP?=
 =?utf-8?B?ekMwODNWUGsweWZZK2VwaGJ4TTJwaHdXalZPYmRQOHExY0RpZTZtVHkwYmph?=
 =?utf-8?B?Zm1IV1EvcmVYSWZwNFlZZVgvbGZuaXRMZHJjbUYwWkdNQmFLZFk1OGI5N0dX?=
 =?utf-8?B?UWJaNnpTSTZ1V0VXV1FRM2dVOWthUVFQQWprMkVCNldWOCtNUVBjU09HNWo2?=
 =?utf-8?B?Vmg1c1NmMkJTYjA1L1JxVzZVSEt1a1BqaWQvdkwrcm9pcVNDSlliMVN5Z2Ft?=
 =?utf-8?B?akxJYVVaQUxUTVhUcytHb0F5U2FZbFJScnVEblJ0U3VsVzlxSG1SV1Ywc0Rn?=
 =?utf-8?B?NFJpM05oQ2dyTUVMQjZlWk9LUFlBU0h3WDVBQUE2cWY2aDJVSlBuelJLczBB?=
 =?utf-8?B?YmNKU0phSVdDT00zcEpoNFFFYTNiU21TQkVoZGpoenNrK1c5U0N4Tll4Y3ly?=
 =?utf-8?B?dEQ1Ui9ZVWRKYWFGazJqT3RVWjBpUGplenZZcC9oamwzUWlPM3I3Slg2NytK?=
 =?utf-8?B?ZHlIZEN3aHNQR25zRG11cnNTLy91OG92M0xzRHZ1SFdieE1oMkQxMEN2cSty?=
 =?utf-8?B?djdOMU50bVBDZ214bWdBbVNIbk9pYlJzVG92aHkwcEdmYisxY1JFMDlTTXZD?=
 =?utf-8?B?b0VqemQ0L2IxbDdSbFExVS9MZS8vRHU5SERsTXhHY0ZzWmlJNGNrR3pGOENB?=
 =?utf-8?B?VUZ0TnNLc2UwRkdTVytUcXV3VjBmWHR3VFJhM1dzWjRMMkJBcUZBZi8zaGlF?=
 =?utf-8?B?QXFKejliSm04a3V0c3Fjc2VKcERqaTRUbjE5SGdvYlFWTHlKeFFva241SUpK?=
 =?utf-8?B?NDhCbWJ0eTlqUnVoNlEzWE9GZXl2SXh1YUpVNUJDbThHQnVFOG8wRDd3aU9S?=
 =?utf-8?B?ZUdmQ0tseUJVd3l5eU9qUE1sSUVyc0NjcHFJT0d1SkMwZVJ3anNUUWlaL3Zt?=
 =?utf-8?Q?0nQa7KdYEjsLu+fQv8ltkxpu+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c534757c-ac00-494d-df12-08da86ac8ddb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:14:50.3370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+mtAdMMkiFhxB464r6c+Gkq5vL8dndli+5YIdvUqYKlQC6AgzAGaOV4BVizUff8VJix408ubS9cWc69K1uYsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
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
Cc: tseewald@gmail.com, helgaas@kernel.org, Alexander.Deucher@amd.com,
 sr@denx.de, Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-08-25 um 04:58 schrieb Lijo Lazar:
> HDP flush is used early in the init sequence as part of memory controller
> block initialization. Hence remapping of HDP registers needed for flush
> needs to happen earlier.
>
> This also fixes the AER error reported as Unsupported Request during
> driver load.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373
>
> Reported-by: Tom Seewald <tseewald@gmail.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/nv.c            | 6 ------
>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 ------
>   drivers/gpu/drm/amd/amdgpu/soc21.c         | 6 ------
>   4 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce7d117efdb5..53d753e94a71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2376,6 +2376,15 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
>   				goto init_failed;
>   			}
> +
> +			/* remap HDP registers to a hole in mmio space,
> +			 * for the purpose of expose those registers
> +			 * to process space. This is needed for any early HDP
> +			 * flush operation during gmc initialization.
> +			 */
> +			if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))

Does this work on GFXv8? You may need a NULL-check for adev->nbio.funcs.

Regards,
   Felix


> +				adev->nbio.funcs->remap_hdp_registers(adev);
> +
>   			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
>   			if (r) {
>   				DRM_ERROR("hw_init %d failed %d\n", i, r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index b3fba8dea63c..3ac7fef74277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handle)
>   	nv_program_aspm(adev);
>   	/* setup nbio registers */
>   	adev->nbio.funcs->init_registers(adev);
> -	/* remap HDP registers to a hole in mmio space,
> -	 * for the purpose of expose those registers
> -	 * to process space
> -	 */
> -	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> -		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
>   	nv_enable_doorbell_aperture(adev, true);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index fde6154f2009..a0481e37d7cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1240,12 +1240,6 @@ static int soc15_common_hw_init(void *handle)
>   	soc15_program_aspm(adev);
>   	/* setup nbio registers */
>   	adev->nbio.funcs->init_registers(adev);
> -	/* remap HDP registers to a hole in mmio space,
> -	 * for the purpose of expose those registers
> -	 * to process space
> -	 */
> -	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> -		adev->nbio.funcs->remap_hdp_registers(adev);
>   
>   	/* enable the doorbell aperture */
>   	soc15_enable_doorbell_aperture(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 55284b24f113..16b447055102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -660,12 +660,6 @@ static int soc21_common_hw_init(void *handle)
>   	soc21_program_aspm(adev);
>   	/* setup nbio registers */
>   	adev->nbio.funcs->init_registers(adev);
> -	/* remap HDP registers to a hole in mmio space,
> -	 * for the purpose of expose those registers
> -	 * to process space
> -	 */
> -	if (adev->nbio.funcs->remap_hdp_registers)
> -		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
>   	soc21_enable_doorbell_aperture(adev, true);
>   
