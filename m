Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9412C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4179610E6FD;
	Fri, 11 Aug 2023 21:28:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C393710E6FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKrQmbeMPaMVC1NPDfRUc800DMJxyrstaV3iuQhZ35n6iXawOjjFOSg/zNS2oj9tfWNVQBrGc9Qxg1sJEj7vr1kJnYQOVyJMVEccb+7aNT9BmgcPvqb6tXRNy7dBAtinM6sWUrmM+xLhCAK/bHqr3jxniX9LH5mVyq/QbarMCMzFiEFIMYVNwwmt1f8jY960HDTXWQLudcmD7xkkJtFStEzbj/3axqo8spqCkOVnkmIgSaq/vW0wFoYnlGPJdEZlv2EwyWwRoCjAZJqkBDA4yuJPitC3G4lcxCalvuN2PQfcbijQeOMq0uYGeWZF1uBR4Z3MlxKvDMut0xz8YNRU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQhcZGc2wxrj3ZE/TrgBWVSbqGmz/gjMEQ2LAUWb464=;
 b=KXmdExFYVjAI+ks7ylvsxXPNyKTthTCb+RmVqhplRSvpY1fl2kAQeiycksbUPg7dWZNDU5vo6+6I+f0IPo5uGBgfITiMSUp97h7eOSzHnqBEWmba/yWDZaIUbzhJo8IQamtWVPy9S5vmRkAcn7Atk8Dy0ITO+QaS7l6JHph17TYqsM/Nhx6XjNqDu5vNohEQfCqA4ZIHd6LjgvuRMSDECl1NyJ1YpsKjHfpkOkHFaeF/sfyoWUgSsspoaSqpej63A7MXDvqoAq3SLOEEW2J8Z4uxsjk8QgRoRmCDcoH+rMSjtCMwNdu8JxF2CgNZvz82SilJqsT4VDg9fPZpWPIrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQhcZGc2wxrj3ZE/TrgBWVSbqGmz/gjMEQ2LAUWb464=;
 b=LFkUQZEkHUb49LAmOP53xy98dpa7x8eM7KYAwrg13lhBKwBngV1dZLH74+Vt0gm/QKDbb4tAYSs7hzMEn616qbm3SbnOhbIn+vtNqHd3nqRNyt0IO64sk9DmuTjYDKau9gnjRzTAroXUBGJ40PsMPHeqiaEpbj4t6CcAPqZxVBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:28:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 21:28:43 +0000
Message-ID: <40478280-ee35-ca33-350b-300b9396e04e@amd.com>
Date: Fri, 11 Aug 2023 17:28:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230811202337.1867891-1-James.Zhu@amd.com>
 <20230811210627.1888328-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230811210627.1888328-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::25)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a634913-3cf1-4793-0a12-08db9ab1f041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gPclrs1oMawqPEN1x29fj5R+mYlpo47D+cQ9YLXKV6abu6nw6CQXTZcDgz2jqvZEsx3G/ge/HNFBc3pzveK0JfkHvRNS8pzN2/nXtzw09q6R1IOz2RdJuoigX1AGDdQRPclbg4ddgYyJ77FNt8F5gxL1zZ8LvunYi4AUINtWn6NNh9VD6b2JEXzouA5a+9AQa7Ur8g2Leb66dwVU6aCSZheYeWNAs2SDTE997nYckQXhALaEa72p7bkALxICbY3VohKuQt/Kna79cJZbShaEANSEhscmm4tAqX1QI0A335GMpicrs56/9W3hi+qvIGK6dyRL3445YCBvQAYbHTTvE2nRu1m7B6iRATDMnvHZj0SzWEdk8bJzLfmXzpEIPRwXcqQiaqFURRijbtaJXbxcKivWNJe24p0Zffbdz9GQbVF1Q9xBVLspGUewnM4I+4dD3DZxivv1sMjqwy3Rku9V8mK6HxvPxfjvkBiioqJJVQ2V8D6DDZELU5SQ38NkA6FuBNUj47HY0INnhaZlHLkQ/y90XpXUQ+MQ8qyuw4YUIU/tlENd5PdphaVsqLUFIrCVNwl48bhCc4u2YBb8vRT8S3/QHdJQf8rCjSZkV7SunE6Rt9tPPmMNYaIazwlFzcmLi9AhJAWFCWZbP0dwMg+kEEkZxsQIe72ZjvjhLw4GL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(1800799006)(451199021)(186006)(316002)(4326008)(31686004)(66556008)(66946007)(66476007)(38100700002)(41300700001)(8676002)(8936002)(5660300002)(83380400001)(6512007)(966005)(2616005)(31696002)(44832011)(66574015)(86362001)(26005)(6506007)(2906002)(478600001)(36756003)(36916002)(53546011)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRZcnNUcklLRk9FRmE4USs1OWNoeHViY0JJbjZJUzc2Wkozc3JFNFVGdHZL?=
 =?utf-8?B?ZUVWTXZvZGdnVWo5YWVweGo0VkJIVnduYm9uRHd3UkVrRUM1TEY4VTYrL1Yv?=
 =?utf-8?B?NWt5UjN0WnNrcXMvRzF4YS9lNW5JbHloL2hQVGFGRkZGQTJZTmthNVoyc2ZC?=
 =?utf-8?B?c1NvdWdCVXRWY0pRVUVmTkV4M1VBUGZqYlNsM3FmM1JkQTlzUkl5T0RUZktj?=
 =?utf-8?B?MGVBdFp1VVNCUXN0TlpSZlhOSnh1ODQxVzVrRG9LRHU1VFdSbWVuL3ZIbVJy?=
 =?utf-8?B?MGFXQmtMVmZNTFM4WWRXeDE3cldEbFQxamFnS1NPcVAwWEZyQkM3dEo2cFFV?=
 =?utf-8?B?Zjk0NCtZZ09zVHhMdXltMmhnU2F3bXd1dkU5TWpNWFRaTUkyYm13V2p5bnhK?=
 =?utf-8?B?MWlLZEVTTGNjMjVhSGhBaENnK01sMHR6VmswZHRVM2hQeUxNS0hjVFN3K1lw?=
 =?utf-8?B?clRQVFExbHZZZlBpR3UybU1VcVZ6THVsSU9FN25xaGNXaUxTekdoWkFVMnRr?=
 =?utf-8?B?QW1MUmlCU3FrbzladHkvVzR4VXZtaUIxUC9tV2NZWUQ0aG1kOElMQ1JranpB?=
 =?utf-8?B?UTlXWm55SlM4ZG04clArWlVhaGxaN0tkWU9IekJuM3g4QWJvVXQvL2l1VEt4?=
 =?utf-8?B?SDVZcGd5T012eGtTNlFYUGVZaDBEOGUyUmJzeHJpZ0c3aDFwdWRKa1ZGdGVi?=
 =?utf-8?B?ODU5Y1IzaTBNR2RmVkx6RkNZL1BaWFpneStrOUV5WWNKY1RaNmp5T0ZQbHM1?=
 =?utf-8?B?eFRhaWViL3R3dW9DdUh0dTJoSi8za3hBVnd2UUxzeHZISDgySC9GeTZFa2Fy?=
 =?utf-8?B?TzJ6bGUzb1NVSXl3MTM3dGVUaUJkRm9QYXRMT2dUZlhNZzBYVUw2WEQwWTVM?=
 =?utf-8?B?ZGhmMnNXaGMyV0xWanZVSlp6VExRYTFWcndVcGFUeG9OaDN3alRiV2V0OWtH?=
 =?utf-8?B?Q2RmTmthZW8xS25PcDVFZlVYekkxZTBmSFBHSlA1NEtlNnVnejQxSG82c2s5?=
 =?utf-8?B?S0ZEYXlZNFpBWWNvT0Q2aW1YZjBoSXJ3UVNuQy9FMTI0WGJPZkp5dlFGc1lP?=
 =?utf-8?B?U2pVU1BQVytPZ1YyK0tDenJ5alNKMWxlbFJ3RGRRRlFhVHBVaDU2c0RpVjJG?=
 =?utf-8?B?MEFnY1E1Y2kxbjBEdnFVRHJ3RmtPdndVeDJ6dmgrV3FyWG82TmtjZitwNnJN?=
 =?utf-8?B?Uk9JYzgrWW1iclM5akpwUWdVcTk2cmFpVGJXVW1WblF3YU5HVDFOaFRUUHJD?=
 =?utf-8?B?Mzk2eVpwdDZ1VmtuNlNsQnp4azk1dzRMUGZFVTAxbGtwV1lrdFFmNXI1SDFi?=
 =?utf-8?B?d0xzSm1tRTRxbG53b3kvUzFFWnVzQlloNHdkUS9sVVpjcU8vRFE0UmxqR0Q5?=
 =?utf-8?B?azRxbHRjcE1aczVvanNSVSt2SXloV0RVQ0x3WGRrUjU5TE9ZNFVvKzNBMHlI?=
 =?utf-8?B?TnovNVlDZWFrUDdsOFVlS2xHLzV4d1VrNnA2ZGl0ck1iVEFFK09EcjFzajVl?=
 =?utf-8?B?cG45MnpLeFRuM3IwL1FNbzZURkhSOUxmK0tKTUhCcFJXR01sQkl5aDBrQUJO?=
 =?utf-8?B?eEdTWHV5TXhHQk82QmJjRmhiSGplMWlyN3ZQYmpsU2dVNVR2NFlBcGFRa3c1?=
 =?utf-8?B?VG5TWmFueWZWOU1RUEVFUm8rbGZDNUd3Y1h5dkdMNTdMbWN0ckZqR2hJT1lR?=
 =?utf-8?B?RFNtZ01ia3FNTlJHdE00aytRcTdwcXZ1RHZhVW1yY2hNQXFxMzJuZkJZMmRj?=
 =?utf-8?B?NGNPaW1sZGlJSnpPWDJCVlVDdVFRbWc5VGRMenB1YUlTM0I4Q3gxSkJLMjgz?=
 =?utf-8?B?UXpHV0NZSzRQVjdzb2xtaytlZC9GRm4zcnJxMWFQZGl3OGZ6SnB6aU0yMmRr?=
 =?utf-8?B?U09jTjVUSjloS25uWXlzRW1EcFQwMllLK2ljek02Q3B4ZDlMUDMrSlBBclNq?=
 =?utf-8?B?N0FNdUhzenRtRy9acUliY0g1R3IxNHBrSjBiRXd6aFg4bjJLd2NZRW5HaVdF?=
 =?utf-8?B?MHIweWpLQ1FHRGM4ZU5KT0srd2NaeisxMUVEWGtHa3dDa05mb1U1RmxGb0tt?=
 =?utf-8?B?ckZtMDJsdTcwVUJic2xFbjVjMVZ2aDM2QkZGcHJFQmJObFNOMVhpdHFUZ2pD?=
 =?utf-8?Q?GJ/gGDsnUG5CbMEsH2stZ8cx3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a634913-3cf1-4793-0a12-08db9ab1f041
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:28:43.5200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5kMhDKBPDtTSjFs0CDOnvl2uzIrqdQk5P3MbWzeoMmp/Bl3CUgeNI5ZUsdiwDlwoceI8efjU5gndc1GwlVMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
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
Cc: Amber.Lin@amd.com, jamesz@amd.com, Harish.Kasiviswanathan@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-11 17:06, James Zhu wrote:
> Return 0 when drm device alloc failed with -ENOSPC in
> order to  allow amdgpu drive loading. But the xcp without
> drm device node assigned won't be visiable in user space.
> This helps amdgpu driver loading on system which has more
> than 64 nodes, the current limitation.
>
> The proposal to add more drm nodes is discussed in public,
> which will support up to 2^20 nodes totally.
> kernel drm:
> https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/
> libdrm:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> -v2: added warning message
> -v3: use dev_warn
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
>   2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 9c9cca129498..565a1fa436d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
>   
>   	for (i = 1; i < MAX_XCP; i++) {
>   		ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
> -		if (ret)
> +		if (ret == -ENOSPC) {
> +			dev_warn(adev->dev,
> +			"Skip xcp node #%d when out of drm node resource.", i);
> +			return 0;
> +		} else if (ret) {
>   			return ret;
> +		}
>   
>   		/* Redirect all IOCTLs to the primary device */
>   		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
> @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>   		return 0;
>   
>   	for (i = 1; i < MAX_XCP; i++) {
> +		if (!adev->xcp_mgr->xcp[i].ddev)
> +			break;
> +
>   		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
>   		if (ret)
>   			return ret;
> @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>   		return;
>   
>   	for (i = 1; i < MAX_XCP; i++) {
> +		if (!adev->xcp_mgr->xcp[i].ddev)
> +			break;
> +
>   		p_ddev = adev->xcp_mgr->xcp[i].ddev;
>   		drm_dev_unplug(p_ddev);
>   		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3b0749390388..310df98ba46a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	int i;
>   	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>   
> +
>   	gpu_id = kfd_generate_gpu_id(gpu);
> -	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
> +	if (!gpu->xcp->ddev) {
> +		dev_warn(gpu->adev->dev,
> +		"Won't add GPU (ID: 0x%x) to topology since it has no drm node assigned.",
> +		gpu_id);
> +		return 0;
> +	} else {
> +		pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
> +	}
>   
>   	/* Check to see if this gpu device exists in the topology_device_list.
>   	 * If so, assign the gpu to that device,
