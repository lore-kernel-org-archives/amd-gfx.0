Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0687EC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 15:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D72310E2AC;
	Mon, 19 Dec 2022 15:09:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9405310E2AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 15:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0m3ztXU234/6IyMj7kYfM7MbDxtJK+/CxmvqeBVW7dWeJjQ0YMzr+fIxCze7DK++c1XhZ0l2ZUEQAVhoJNfFZv63K+0V1qITgrRwUaeC8oRqvlSO/4dUBlhR0LWb/SYNjUVY6/PvHYsXq4nvtC438SX+QcXnRUzec5pZUWCka6lEkwvNZ12jEH6YGdaF9ceFlIWYCKXAROZfjO8oG4HwvswfmgY7jdv/bTfCt0+2p6JPK40B2LSN1k1ELWvevTLpkk6f/OZ8FarL8GI4JEP1nCaIqUoNLbM0e/wZ//yLzWJmQ3QV2BzRvzOaYobSYHF/dXZYaaZ/F1EK3TFxIk/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2om2tr0hQioj0KmMawZ96BqVA80HuiUYJDYFdGbPPlU=;
 b=RuHmEE3NJPTJjEdbcuir9cukls4qgn3er34EsMZnjPOd1354r0FCnCNd1MyaUWCuKwEwvbxwnnrtgNq/MjDFAdKuzif8UinRR10zmlnOPh0mr7ybXR7vdvz6BtY8eEkfhrIVycNt2CTZeV2Bc9JBRv586okCcPsfwyNigt9zu7t/1hBCy+lFc9KpGJw5Z+7AvSAC7JaKYciK7mNeN4f0/EhOo8L8WAcLl5JqnmDURBAwQxzFgAjWQYGxipoCErCRsCL9fvxPtgxefYpLlbM3zomTXh25WrbFN11ZxvhsaTfmBVcOdWynqbmpqrRD8j9vmxFNigVP3kY9E7ApSkpC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2om2tr0hQioj0KmMawZ96BqVA80HuiUYJDYFdGbPPlU=;
 b=bWM/SW3c9aXuKUqpqULx4j5mTh9nHm/iQvT0UNnVKIObR1gjXy85aCr4FgngmOTWBN8tXpfcX+PRHpMwhQAm1QfWNpoEP4L3XjeuoK2OMvdluBG6JF7gVDxMQ4CIxSbSEM9cBy1u+WJS7zphezjHMKD1aVuk4zlkA7HSPyFNtoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:08:50 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:08:50 +0000
Message-ID: <e3abb7e8-7014-dcb6-815c-5dd67b467c45@amd.com>
Date: Mon, 19 Dec 2022 10:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 bp@alien8.de, mikhail.v.gavrilov@gmail.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org
References: <20221219104718.21677-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221219104718.21677-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 4256ce50-81cf-452a-3d54-08dae1d2ef51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slRfan3Y/1dLDlnO52hvCtSTJw65nS6PZ2VDCOiJ8CtB+FxGWiw5WBpBwLPO4X87R6GyT0ZTfnRxN3CES5WdcA5dbcR3R0sa3YGAKrmcwYujXInQwMgrMxoaUlem6MHGcexUx/I2++akura4mKvjB+JFmgmTuDlg1kp/aLwZDIN/ap5hzl4ipjMZ/OgtfSASwzVwRMKqMnHvOsXWQREGrWcmumF8b0OG2RPqYehXwykERR8m+DjwzUpP/e+UU8InpIxWI+GjgALaUgh5J++l7+3wFTksQ+E2dftUJuGbWFXQpKc7sRe/3O7G7PZsYLGVsEpp0LlH0zGy7yUW95yTK4D3wJWxS++nbhlwbxw7U1Zm7GZyt60k23dvEYXoSDsi1URSw4LKyQMqW7nSdrazvrshowAUBrCWSIzofhYxzebl9tAK7mO7G1nl/rZq5aiw0XvJFMZ175WLOILs17rIO2ag8de34j9iatRrMSgDHifxBGsmd538M+MavYRdf3Mqeb6dhZYIrg6tYoNpTZmC9frtQF95yEAqzM4apW991NENV9it0alI+IvBe0wVSt7wX95XkDDYicACBZwOnnk9T1h/8oyymmdb9cPgkzoBPwTd0zoeIPjVcOqF0fYEd3/j28xOMK8hQbDmfIX8fMRS0Gy3qp4ys/0AhFvDuSLguk8OCbG259ASHlZ2svMfSqGUA0aPjdNBUBJLO8KLg+5dkiPx5bZYbDi9/PaTiKAld7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(31686004)(36756003)(186003)(66476007)(26005)(6512007)(66946007)(478600001)(2616005)(41300700001)(8676002)(2906002)(4001150100001)(86362001)(31696002)(83380400001)(44832011)(5660300002)(66574015)(8936002)(66556008)(6506007)(53546011)(6486002)(316002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3YvbE5xa3B4UHhlcXJMMVEzU1poVEwwMWU1WEZVampMNWhiN2RuT1lpblNW?=
 =?utf-8?B?RlJTeFNveTQ3M1JUaW5BVTdRckh3NUx6TzFTUzd0eXhtOEhYQ0EyQktiUkxS?=
 =?utf-8?B?TDlwYTkrT2poaFFOaytFSWlZNUdxVlA4M25MZWJweWg0RTJ5elp1SDFkZTc2?=
 =?utf-8?B?d2t3Z0tpL2c4NWZQaXUwcEx3aEtYRTBRRXpEblZENHEyMDdtaWpNQTZ1aUFn?=
 =?utf-8?B?bFBHR0ZYVFMzNU9jVHZXMnN4OEEvZE93TTB5RGV2Z3EySnQxRytvTEUyWWhZ?=
 =?utf-8?B?SUxsOHRXZ1E1alFHekNEeCtpMHR1T1FOeURZV2NWUTZKbUs5U0ZzZVljbUxr?=
 =?utf-8?B?WXNwRUpPbmRkc1gvTnZTTUk4MnY0dmVrb2RKTDdrbkJZSEtFbTB5dzUwNGNN?=
 =?utf-8?B?OWpISmR4bU9PaTdkOTBUQVZMVUZtV1lmZ0J4a3ZwaG1na3ZUSnNDYzdRRVNq?=
 =?utf-8?B?QzdiYytXS3M0aG1KUTROc3JsNHRQK24vSURHUjVZbCtFdXpWMDJLR3NYRjFh?=
 =?utf-8?B?VFYxMGdXWTMyaWxHMDljSUJPdi9QcUdpTGZvNGw1dk9NZVNvbzAxWFdXN081?=
 =?utf-8?B?YWRaWFk4VlR5Vkx3QlIwNXg1V25SL3JBeXZDampoRU45T1pMVHhTemtyZnQv?=
 =?utf-8?B?T1BCOWFEUXdqVjM4dDEveGNUYTBZR3V5U3lZeS9YT1d1dWdqODZwNzBxSHFX?=
 =?utf-8?B?c3hzS1lYVG1aYWU2Vi9UYlp6dVNTNS9lRmZJYkVsZTNlN0RQdU5UOHV3YmQz?=
 =?utf-8?B?QUpHL3VoK1I2YUVPQVd4V1lQeXpxbHV0U0luWXBGdXh0V29QRmxqWHVmK0cw?=
 =?utf-8?B?NlRtZ2xNcjltZUREK0JPd1NaNUdjUXVnb1BNWnp2akFrTHo5MTNOYlFBYzND?=
 =?utf-8?B?ZUdQYkRCMjl3VlQrRUFScFhORFlyN0lBMlpYUDFENmdlMzR6WCt0eUdKRGhC?=
 =?utf-8?B?Vzk2UWhEQjV1Q0F3bWN0Q3JGM3VDTWdaYnJiNVBhb1NoR2RneFpDeFEzNWRI?=
 =?utf-8?B?QzVOQnUyQkpaTWs4VkhydTFCd09GNkRHSmdLNmVtMDFoOUtsR1FpTTd5UHRQ?=
 =?utf-8?B?aHYvcHdlelptSFhkck9tNnVlT2FJWlh0M2xjcHYya2RxQVNGWDZYM0RHcVBa?=
 =?utf-8?B?anJNQXJhcW5TMkpQOHJYdDFFcEVrVTlORzZoUDc1VkV3R1VCUHNTUm1TVGlU?=
 =?utf-8?B?UXRJVGhVUnVDQWpBZEJhL3VSZGJqVHI0T0RrcjFNOHVCODlKNGIxYy8zalZJ?=
 =?utf-8?B?OW5JczJvSTJSZEY5RUhVaWxQNkJhRXFCVDROR1hJMW4yc0pQeHNJREp0RVFB?=
 =?utf-8?B?SGRNeHZHQ3I3U0VuTkpnWW1hbTYzenBBTnFCQS9EVXUydVhoYzgxa1k1S0Rq?=
 =?utf-8?B?N1I1b1BLckVRR3ptNkRDdzNydnhMT0h4dE5KdmNVTndDOGtNNThKZG5UMDVv?=
 =?utf-8?B?Ri9MQ1l6bVVTWXNDakkxZHRmZWN2QmVpc1Eya3dSOFI3em1hc29ZTFl6SklW?=
 =?utf-8?B?dURiTjUrK2RnTlVkSmxITnhNbGhrOEdFV3p0akpEcitOQndvcTVQSWJKS0gv?=
 =?utf-8?B?a29PT3VGNGhDRFFtSXFnYTVuOWhDaXA0SkoxdjJ5cEpXMmhubWxWYmx1cnJj?=
 =?utf-8?B?Z1Y2dTBKNCs4Mm83NHhsWmlmZ1EwMStub2JxVnhRcFdnR0FXSFprRVVraUtw?=
 =?utf-8?B?WnczZENPSkcvajdJSTl0OEtlQStJMjFudXZ1bEpJbVp2UkFlanpPL0I1WnM5?=
 =?utf-8?B?MTB0L1o1bVd6ZlZZVGFLdEhmN2VBU1RhbzlDN0ZIaGVXenhZTGUvOXNkWFFF?=
 =?utf-8?B?d3pCS1VTY200WUVmVUNQbGx2UWRacFkwN2NoWit4SU9PdFdpc2JtZ0JoZHR0?=
 =?utf-8?B?WkR1ZXV2clRTNzRWZ2hIa1dMc0pNM2g5SjJINk9rZzFEcndGNzFTTTN5SWo0?=
 =?utf-8?B?WVUwdXpxWWcwOVQzZnoxNnU4Z24yR1ZmQVFsaGMvTDJLUklvZ2c4SlF2VFBu?=
 =?utf-8?B?TW5tcVJ6azgyZUFhK1FyY2Y3UHM5Q0dMLzd5cVJINXNiUTVvWENGbDBGWS9I?=
 =?utf-8?B?MGtCZHBHRXVjeDFJcGxTRzBKcXlFam8yUFhvdEZxS0dTVzd6TzJlRkt6RzRo?=
 =?utf-8?Q?1Jrjiu5+o1LRK9iLtkJav9zWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4256ce50-81cf-452a-3d54-08dae1d2ef51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 15:08:50.2213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tssNsIVwOSofhT7VzrQh5hPbw61OHNFfMNMeddyZZbihfnRf/VALRjGMxXvhdM2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-12-19 05:47, Christian König wrote:
> That function consumes the reference.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM updates")
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 59cf64216fbb..535cd6569bcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -238,8 +238,10 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  	/* Wait for PD/PT moves to be completed */
>  	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_KERNEL);
>  	dma_resv_for_each_fence_unlocked(&cursor, fence) {
> +		dma_fence_get(fence);
>  		r = drm_sched_job_add_dependency(&p->job->base, fence);
>  		if (r) {
> +			dma_fence_put(fence);
>  			dma_resv_iter_end(&cursor);
>  			return r;
>  		}

