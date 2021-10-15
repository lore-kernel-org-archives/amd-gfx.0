Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 21:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8050610D2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 21:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8050610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E2D6E3F2;
	Fri, 15 Oct 2021 21:52:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B856E3F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 21:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X85SLOsX+ElzQuoLRc2OktiSsPUWyw5Bh6be+Baerll1SPcMAjqXe+PpH5koey5kB7tsNn9Qg416zR96ym2JrjOm2fVmrG3ZaUeAgC1EVMaSxx6d0T7MNeCMynoDsKpttaBV3l/0VrGdyJLahq/4b8guN1XDC6o0rKqTCsA9XEJFiuZj6YTt9pzOYdZcUXaj1H9mBUOG17A5jIgWPh3rOffEU7HKET50R6Rj/haNGfOfWkMYELR789hgW7358Yvr6zzBYjghpupIYRTuTdavEdRvMg5wMmSSg9gsRk9zHdt3vb/ZyRGkg/3ok3ONjmnYWp6j3HPReJle4z5f3f9A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvMtN1SbePG1+wGrkUDJP0vWm8V9/pA2uphM4A3yPws=;
 b=Le1fzkfKTpblLa6XUL458/TBEfPnguhbIb8nU+i1WIByHqtCXJIrA8kySTl9hLI3824qJLSKzbJBJU/3S8pVn5fPDcNCoEyR8WHQmewStN7NVc0c37XwrNVBhlFcsvTio45530h0FdKYylgJdX5wuujOWZ0mT3kfKBc+yGUAcTUX+/4P9U3r8s9pKqzeu3CP14ukX/+imLylbYTk2UC55IEEbpP2+xKJScLyFTpTw44HUs29smb60NMATOROJAMqNBXPXK9MPk5BF0XJgxmjfbgfy2J/AictjP1wP3EBXs6m3PzxBB90uStMHKjWHO3HhHkAs6tuJgGN69/eVxIB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvMtN1SbePG1+wGrkUDJP0vWm8V9/pA2uphM4A3yPws=;
 b=fHv9Jbawbn5lgTwPKFuUy4wu9vIzUTkmmFDqfb3qFT/SxIFNo0bIibPUwyULV2h6bBKnUKialTzw9882FI7afO1Qc7pupjhctX9ZWckawZpkQplPTMP865qHw9BBAr5SXPTwqh9jI9Jzc5CBdImnZJTBX62xWtsg/IrYsJBACHw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Fri, 15 Oct
 2021 21:52:49 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.032; Fri, 15 Oct 2021
 21:52:49 +0000
Subject: Re: [PATCH] drm/amdkfd: map gpu hive id to xgmi connected cpu
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sean.Keely@amd.com
References: <20211015151103.3590983-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <bc14ac97-0086-2de8-ef26-bfd45f063f61@amd.com>
Date: Fri, 15 Oct 2021 17:52:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211015151103.3590983-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 21:52:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a18d0b-2086-4329-dd39-08d99026218c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3931:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3931B0B796D6F6E92311CFEB92B99@DM6PR12MB3931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9QqM2Y3+5+YxN0kUXAE9wlpNAoFBbMnCrk026ZaaxKEGvr5LpOHOi1WrWjWz5sSGML9Dethy/Ty9v8hg/22HmoVQXORDom7a/TxIqRZiD35AISCNqJugWEKG30ByVIXWWzYhSZKQAzXXHcwJrbDB7buUp9kqi3veSBVnuk2axdeGKq2BcJUtWdyr60n4gBEodPSI+XxTJVMrslU5ScNbUEj4YRZCgp4EujsEDdI1WSqnZR1LAvTKlk6QlfZN1PeuEhrvzPHfwbl9NeA4TPm394mAgxq86KPIgZjeVGZNonLyyWheAgGF643oex1BbN+WjSjASdAs0jJXhwRk9/ByDhZw1TPGd1SYW4FOnCMpvDVrGfBbnXBtY+TbQRkCDX8iCtnYLmMljlwP0224ZL/zWWGJcdGT+imOG0q/e+xo3m++0SKpzxrgXQT6iNo5JqUDp2IrnJGTu0adxSdyaKklqDBtAvOCBD1MPRCd1E+17dyqQIEyS/wFxQmT4+x4un7PXqvCiayM1XzrBDlN2+7I3njXgGc1c9XnYHGrWvySuKV5G+XsOWgFHL8iwEHwOGrADY/Namj9QEpfdc9PGwbA7B0DdggzWP+Nx5BeSS90Pjp6B7T8cf8Y+c20OJ9fYJvWSO7brH2cIys+8hRzFquSY8TzWfdI/kmO5qvZbmrBDIn32nTAH4LZfhmiVttpavco7013Fb1M6AfkxKJ201feuKjQUfdfiaCfOyyZlEJvyoqMiGrGLJux5/eIb3stp7X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(4001150100001)(31686004)(2906002)(5660300002)(4326008)(66946007)(508600001)(8676002)(66556008)(36916002)(36756003)(186003)(26005)(66476007)(53546011)(2616005)(31696002)(16576012)(38100700002)(956004)(6486002)(86362001)(44832011)(83380400001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cng0Z2tBT0M3LzB5TDBlNlhqSHFiSVZRelBNd1RzalQyVHViV2szYis1MytR?=
 =?utf-8?B?QzNWV2c4VE5uczBuT1lPTGFidW9oU1VoeEZCTHNocCtKVmxTWUxHYllqa1ZX?=
 =?utf-8?B?YXVGZjgxSkNsOW9wTnFwSVd2dWQrVjhjS3lPQnppRWRXYUtVaCtLVjNDWUpm?=
 =?utf-8?B?cHBYWTRkNnArRGMxYmVMc2FzQ1l6dnRURDdsZnJnUGlBeDNia2dzZzUwOVUv?=
 =?utf-8?B?Y1BhV1loeEh1b0xHZVAvS0ZxOG0vN0lRTndzdzNVb09kdDdyYmJPZW12REpT?=
 =?utf-8?B?UHdZNnZTLzR5U3gvYmhpN0ExeW11enNDTFd4TjE1ZlA3Wm9JOEpGSG5ZaTdt?=
 =?utf-8?B?Z1JUSkZCYkJ3ZHBBOFlmVm56bWduZ0xScVZaZFdZY1hJN24wd3hiMURyeGVB?=
 =?utf-8?B?cTZLWEUyZTFVMGgrbmFzMlU3alpNMWFnVldsNE95WDIxOGdLeTJ6SnduUmJF?=
 =?utf-8?B?VnQyK2YwNUNVbGdRRXJqMXpVY09ScEE5VFpNRkd3QWFkVHgyZGtFNzA0Ui8y?=
 =?utf-8?B?NDRaelRvVzhjQkEvdjZMQzNPVVNJMS9FN3VDdVcwblJTYkJ0MkJES2RCSkdo?=
 =?utf-8?B?VTZWeE9rVXdIYmRhajRoUkNYcVlwSFQ2VDhWVVk2YTVCaENxTEpaVjBKZzFp?=
 =?utf-8?B?SHBxSkZQRjlDemJTWFByb2lLaHRaQTBzcGw0RkJvTEs5bnRXWWVFaVZYRWNV?=
 =?utf-8?B?OEJ1M3lkdHcrYXE5b0pYYVFob0NzUjV6M1gvTTB6UXQ0NC9UTWxoWjhObFVv?=
 =?utf-8?B?c3ZoMHdtRTJZUEwwa3k4NjM0dnkwb2NlUmc0R2I1WW1OMlR6RXVNTmhWbVg5?=
 =?utf-8?B?SzZqSWtaMTlCYitGMTI1MFZWamNNVkMxTDVHMnIvejBXWDRUdVhnalp5bjZm?=
 =?utf-8?B?T3BaLzhFbkFiL3JGN3FQLzM4d3ZzYm1HeWFvZlVzTmJxOEs2ZGRUZWF0MUFQ?=
 =?utf-8?B?NGVNUE5VNkJjU3ROdXBEWjZKVXBDTWFld1pWSXZJQnBpM2xyemorc2o4R2tl?=
 =?utf-8?B?N2VlM2VTa3poU3BoWEw5RXNJbEtmS0dMdGlEWUtSSXVwRnR0SG9wUUt1NlpV?=
 =?utf-8?B?b1Bua09UdndwNXppYWxKL3l6dVdGTmRUaFdoZFFvU1NPbXAxY2pKaFhqWlZw?=
 =?utf-8?B?dFF6Y0k3RWYxandKTkZ4VTJzQTBtNlZHaFAwNTQwL3drQjhhdDczcmpuZjFV?=
 =?utf-8?B?Yk43MHl3ZlVEVm5GUHhVNkhadGtCQ21yVkcyVE9LWFNYY0d5UWFVUTNzWFRh?=
 =?utf-8?B?RTdoLzBHYjMwSGR2RUtDOUxoZXl0cXNKdUVYdUNKY3pDYmpsM085RzRzQ1Nw?=
 =?utf-8?B?S2EwV2o4a3JWR3ZKQjQxZDhpcE5MSTJ4ZHFYdUNmOUxCQ1AwSnJUMlZwWmdZ?=
 =?utf-8?B?VUhCNVFzUFFqZTJHdE1GUUJnUmlSdjF2VDY0aDNSV09YUWVlNjJkZ3k0NmJV?=
 =?utf-8?B?bm5yR0ZPTlVvUDk0Yzl0RTNtUEtuY1pIS08vQXNla0V1dVg0VE9UV2FXNUtI?=
 =?utf-8?B?cnhHSncwdUFFRml5MWVjdXFhZFVvaFJtZUN3VHV5TmpsQ003ZEdyZjhhZ3Ey?=
 =?utf-8?B?ME14TTZOZno2YzFtSWJrZVNoNTlubk41OGt3dFcrZENzSlpzZk1tb2xYZk9N?=
 =?utf-8?B?ekxWQlJ6aWVIV1N4czRhZVlVc2VhSmVHaG8vRXY1UG5UWDY4Q1AvU1ZyZlZv?=
 =?utf-8?B?TS9ZLzBOSmdEOFZwTjUzbENPcnRvaFRjVlJ3K2RqaXQ1RExHS0NnZjZhNCtj?=
 =?utf-8?Q?RT5VSJyD3Vr15LVvmDtmvytiFyLbUIKKxMDLyOt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a18d0b-2086-4329-dd39-08d99026218c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 21:52:49.7511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4oTjbaBKUbyUf2XT5LQxTILYu1ZvNkDR3ZTXDQ09iJnfQQWIaof+iS1RQmCOI84IhnKxFIHSR8mNXqynxrZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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


On 2021-10-15 11:11 a.m., Jonathan Kim wrote:
> ROCr needs to be able to identify all devices that have direct access to
> fine grain memory, which should include CPUs that are connected to GPUs
> over xGMI. The GPU hive ID can be mapped onto the CPU hive ID since the
> CPU is part of the hive.
>
> v3: avoid quadratic search by doing linear list read instead querying per
> proximity id
>
> v2: fixup to ensure all numa nodes get the hive id mapped
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 98cca5f2b27f..dd593ad0614a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1296,6 +1296,24 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
>   
> +	adev = (struct amdgpu_device *)(gpu->kgd);
> +
> +	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
> +	if (gpu->hive_id && adev->gmc.xgmi.connected_to_cpu) {
> +		struct kfd_topology_device *top_dev;
> +
> +		down_read(&topology_lock);
> +
> +		list_for_each_entry(top_dev, &topology_device_list, list) {
> +			if (top_dev->gpu)
> +				break;
> +
> +			top_dev->node_props.hive_id = gpu->hive_id;
> +		}
> +
> +		up_read(&topology_lock);
> +	}
> +
>   	/* Check to see if this gpu device exists in the topology_device_list.
>   	 * If so, assign the gpu to that device,
>   	 * else create a Virtual CRAT for this gpu device and then parse that
> @@ -1457,7 +1475,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		dev->node_props.max_waves_per_simd = 10;
>   	}
>   
> -	adev = (struct amdgpu_device *)(dev->gpu->kgd);
>   	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
>   	dev->node_props.capability |=
>   		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
