Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D84C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 23:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD4711AB74;
	Fri, 10 Jun 2022 23:06:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5460D11AB74
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 23:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDIePsyVlWU0V7pDTTPRWvZXzgrLTVgV4ndLZ28Pvi3MlsBLxNdkgA9t92k3esaB9yDq+qcwWp0gy8WxL8Zu1xdCzZjSQv5CFHgNLSp4njXT2oWe8PK7fh81PyFOhh5kM/YRe2aIpAJSyFJLVLcJ/zvEcBxW6YqjvFizXksoqaqznAp+PqqXJUb6voU4bBaJj445sVUj+cnf7dS3WpPbdZFeGF3flJuHxK3qw8y/ZB1VuH7L9jUpSJlosNm5YNe3iOoC7r4PVJ+nQ962+zx5ubONG+Atjm6Qiza8y5t75Ze48+1YOj8V+6Kf2ck3LUWahSogUArU71W20pGF5lIzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Kjy6O17DA4CydkcbsHBpUBbaAf3bGiCtGlGcXlp5g=;
 b=TzZ3b0E13rwsVjLDJx9bb2aDcvDQZvSdTOPOIyEiMnlaaYnhaG/08isheTkmeU5qTwWkIG0xZUIqCRMhozsPlJRYglLlttJuxghGtsSurMVVUtysWcKDVF99qVT6lU4Am9cLvdcXPb6Q31Jk7y7MenWQES1H6KY+8VPHZ9W/HWfZvhP7NyZRqQ3aA8DATHZ04aQ5kgv19E9bYqBfhKsXG8ZYfUnOLhq/sFHWal20jEBsX3n8TB8ZNFTkfpsNLDvXt1vrWDXmnYP7MCp43cCtdINPjK/uankeJK2az3edgM/5m/sOcp3PCqQeQL2qSucEZ5Rcdo6ojzWGihuIDb9Iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Kjy6O17DA4CydkcbsHBpUBbaAf3bGiCtGlGcXlp5g=;
 b=Y+SG4ANC54ndF7ihlq2pcSraXHXQrbnatUU4mYm4AIP3Lfl2+eSRNYH1Ziy2iJ7tBSXWzWRS1JwaGqRYrVnoAhCrDqCLZD93JxMMeKgoRCUECm5BlJmu7xvc7pon2G4x2G4E85YfNABkqykWPs17MiueLGjTKvz8s6ewRVeUw8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 23:06:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 23:06:40 +0000
Message-ID: <196f052f-f322-bc7e-e9be-e14be7989308@amd.com>
Date: Fri, 10 Jun 2022 19:06:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Update mes_v11_api_def.h
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
 <20220610171316.2668611-3-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220610171316.2668611-3-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9cbe468-5c42-4afb-1d7f-08da4b35e086
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB309951FD5EB03AEDE9AAD6E492A69@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A46YLwZkEZjEC524PwAUUD6nxpbSUH0okNA8qHAGq2IMx4GF359kEM1OxIM23m5/iiLslAwjLE0NOtGoWVd6F+rZVS4m0aivarLR0/2fbIiBUyr1ef++Iyhkay9Y9GTtlKnNGBy+UAVEvBXbXN6jc4gzzA0f1VnUy0W1WNpuQ5Wcd7x0P7cCrmj0seKHaB+Kc38rHH6BBlrLHXdhqjVgz3h7GY4M+3u5UiptylbFUZ3u/eXAT1f1lYTpmq379wXLPIoIox7NGJDqI8lQLhqY24tQDbZeyOI+OojRq/6Qw/fvbnZNY8bGZEarqyq7ofUT96Y375RUmXecKhcfFSgSMJBnQPqwe1IQebIuziq5k+gm43pIgSzzyfDUfu/j0lEeOxuhHSdI9bU87eStBomjFFJ1X6QVLToX27VAXGOX9zS/nT/zLpT9JRL1Cp2DHZ0i/WdMq6UAGTGce/EbjUtS5UngJvYYn1Z1aE7enCY8ucyU3cRr1sNjxKN4HV/tKZfobNrkXK65995IRjZCwIIwOsL/GhwoJ72ycJpELvfYRgUbMnkku8GgO2ptTBYHYqJ3U+xwDeQmOqWXLZpHp2p2EiTT1ex6gHlCdNqhHHqsN9Zik8jNTV5Cu/dL4ieQuZbcGy51b6TNkUwwBiLa+qgRVnFIBUPTStOdjV+HozTwsmMwe7iWPChV/zxcU9Xk4M0gF8mQ/S0xJLkT08TjaMJehhSdTa0t63tOYWSCKPNU+8OHwtrf7lFwq5Fwt9p3uCn6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(31686004)(83380400001)(36756003)(38100700002)(86362001)(66556008)(66476007)(8676002)(4326008)(316002)(31696002)(66946007)(186003)(508600001)(2906002)(26005)(6512007)(5660300002)(8936002)(2616005)(6506007)(6486002)(44832011)(15650500001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEwzNmVaM3BXMHphWTVKbW85b003MzBCRUY3cjh6c2lOUzBiRkRPdnB0ejli?=
 =?utf-8?B?UVY4a1dSVFcwRnV6a3VnWFdCdlNMWkRZdXVzMHo1OFQwYnNxc2tmYnY0N2gv?=
 =?utf-8?B?VWpwdEVjUGI2bVB0Y2hxaklHZVRhZko0UkgvQVcwdC8rMWNkVWFFSUF4THFK?=
 =?utf-8?B?UkVoN0l4MHZoN0NKcnBCbWpkM20xNk45Q0k2M0NIRFJ2VGJBMG1lb0paR1ZW?=
 =?utf-8?B?T0FjdHhUbDlzNEd0ZnlQTEVmMEFqQzZsNGQ5blprd25JSjAzMHRDUGJPQmZk?=
 =?utf-8?B?RXlSOGFjSmFmUTBxcnZyQVJ2dlhaQ1RseWdJUU03YkNhNUJJOVY4eXE1bits?=
 =?utf-8?B?bnV3NmFFTFpKREM0QXdrNjVVNk83ZEVEem8wWG5DcFJZRVZJNlE3L090OS9J?=
 =?utf-8?B?dlAyM2J1bEc2cTdzRFM4STVZenp2ZUVYUzlXVUR4ajFtQzJFTHpCc0x2OVZW?=
 =?utf-8?B?azZEektQNXRWT2REYm1XM2MxMldxeWhCTVlwTHFWQWxmVjRYdDRtMVRXY3Jz?=
 =?utf-8?B?MFF0NTVpWlQvTzNmcWEyT0lBQUlJaWV1WHM2dFZGOVhIdHhCZkNYTU04d3dE?=
 =?utf-8?B?ZFBuUEx3aXh2REFhMUYxSlBaeUowcjZVSHVVV1diZXd3bG5JWnM3aXU2RGF6?=
 =?utf-8?B?N3hGeVpFQk5VbTNIclBjNVUxK0tjblNSMEE1ZlVIRFh0T3B4UGNURWVoSVJI?=
 =?utf-8?B?SDEvKy9lTnNhcFNNMDNkR3VvSy9jNFNHaWxnTXBIQjY4M1g4NjVaZFJVVEc0?=
 =?utf-8?B?c2xyWHN5K09RNDNJOWphb3Z0ZzhsTDBlY08rOVpmNE1PaVZPdWZpWkxFRG02?=
 =?utf-8?B?NHd4T0prdEtNSEMwTnZrdTBmelNyZnlSOW4wV2cvYVp4Z0piT0pnWFdHUFp3?=
 =?utf-8?B?YSt5bzcyYUtUNzJUdWVFRUdxZ0U3bnRhNlZxV0ZTUEhZQ29Ha2Y5UFZiQzla?=
 =?utf-8?B?K1FPcWVBNDJpMlYweU1TNGtrdm9PYWVTM3d2K2R6UHBiM1hZS1czcUs2cGZC?=
 =?utf-8?B?QlNxc0ZPWkFQUmkxb3pWdTFqNGpwbFpLdmxxaUtLY2hVRUQ3UVhxa2d4Qzhx?=
 =?utf-8?B?UUNXL2piYWk4L282aEhDb1BVTjFiOWE1SjhDWEFIQ0wrYU5ORFpGMVUzeTA5?=
 =?utf-8?B?OG95RkY5bGl0VFM4MGFFOE1PR1lKVnZCbXA4dzN4RUNNcmkxcjIvL3dpeWRj?=
 =?utf-8?B?bzZ2SzNkV3Zua2g2TGl6N1htTU5hbTZ6Umc1bjVrRTRmZDIzcjlWdzlKUWFZ?=
 =?utf-8?B?MUlDYVlwa0YvTFM1MENrQmczMjhySWNJbjFmeWMrVGlucFpqdmhvdVRSS0tp?=
 =?utf-8?B?NHhuUitRV1FoakVQa2pSb3k3cjlMdVRRSHM2a0hxUnZwRXRqT2pSY29ubFhq?=
 =?utf-8?B?SVkvSEQvTWFIQkdlaEdBQm0yWVV1eDVFZzAzcWsxR01LdWY0RlF2ckw4SkYz?=
 =?utf-8?B?U29RNTVPVG5qY3FpdDhaM2h5eC9KWlF4YUpPTXVsSVNiVWZsTnArdTFPSzJM?=
 =?utf-8?B?dFNPT3JjcHRydjRrdktJenQ4OXVsSDVuSWZjelB1VzJadnhQOFh1dEVHZkdR?=
 =?utf-8?B?UU1UU01xemJhcUpEMjZjMWJHS1ZPNnJZYTZMSDkvVG1xeExJVWt2L1R6YlFO?=
 =?utf-8?B?VDBvTVVaTFZRS3A0SGN0L2JRVm5mckxkcTR4VW9hQkFNSUY1YjBBbmhHZjFL?=
 =?utf-8?B?VDBhL29IaDIvZ0FIM1EraHZrTWdrVksycElRbThxdStHZUhNUGpaOEtnS05L?=
 =?utf-8?B?VUNEMmxnU0J5TU03VG1NWHF2b1NNQXI0cDdaSVhvbDJrM2d4RUk3dUtvdjRJ?=
 =?utf-8?B?SC9SY2tkWmduYjJpQ01ra2JxT0k1aWxPbEVRZFR3ZENlS2lyN1M1aHllY05j?=
 =?utf-8?B?NExyVzNGTVhENUZLTHBWOTdXdUpNS25qR1gyT011azVHaEZIYis1M1JQdlRC?=
 =?utf-8?B?SEc4Q1NQVXl1ajg4NnVGZEc3ZVUyemMyYWgwMldTNkpjeXA2dEFqSnNiQlRq?=
 =?utf-8?B?UXNmckR2N3lIaHFmWjJIRkZCb3lTMDJSSzBpSWUyVm9XRHhVdnhiWmZ3Tzg1?=
 =?utf-8?B?TzJRdWU4N2VHY3lOcjh2amp4MkVXUUF0SWl0dzJQMHpQUHU3SDhwaGxkampO?=
 =?utf-8?B?MmZseldPR0ZpdzNXaWdqajFQS1RERThCMWRaNUVhZmsxY1NveGRwc2dnSUpI?=
 =?utf-8?B?d2twN3lQTnM1b1ViQ3ZBQ0NuV3UrRlZ5RThxU0ZzU25pTTZiY3pobG5GWnA4?=
 =?utf-8?B?bFBmVE9Ic1ZLWmlESXpEaUhZbEVTcUNCalM0eE10aUIwNzJFUzFIV0YwN0g3?=
 =?utf-8?B?SHlteDQzbXZGWjV0bSt6cWxFT25Qa09Fa0NZV0RST0VoOTFrcmJ5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cbe468-5c42-4afb-1d7f-08da4b35e086
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 23:06:40.0143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOu/SXZEFYVjp12pz5BA6sJCqvoSheBwi60v6gkundSmnxW2j+7X1L/x0dRPqmrPHGlp5CVywBa5oiFV+BA0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Cc: Mukul.Joshi@amd.com, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-10 um 13:13 schrieb Graham Sider:
> Update MES API to support oversubscription without aggregated doorbell
> for usermode queues.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 4 +++-
>   5 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 2e86baa32c55..3d9a81a8fa1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -681,6 +681,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	queue_input.wptr_addr = qprops->wptr_gpu_addr;
>   	queue_input.queue_type = qprops->queue_type;
>   	queue_input.paging = qprops->paging;
> +	queue_input.oversubscription_no_aggregated_en = 0;
>   
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index aa06c8396ee0..26765a9946a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -207,6 +207,7 @@ struct mes_add_queue_input {
>   	uint32_t        debug_vmid;
>   	uint64_t	tba_addr;
>   	uint64_t	tma_addr;
> +	uint64_t	oversubscription_no_aggregated_en;
>   };
>   
>   struct mes_remove_queue_input {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 2a9ef308e71c..95a1394d3943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -163,6 +163,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.gws_size = input->gws_size;
>   	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
>   	mes_add_queue_pkt.tma_addr = input->tma_addr;
> +	mes_add_queue_pkt.oversubscription_no_aggregated_en =
> +		input->oversubscription_no_aggregated_en;
>   
>   	mes_add_queue_pkt.api_status.api_completion_fence_addr =
>   		mes->ring.fence_drv.gpu_addr;
> @@ -341,6 +343,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.disable_reset = 1;
>   	mes_set_hw_res_pkt.disable_mes_log = 1;
>   	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
> +	mes_set_hw_res_pkt.oversubscription_timer = 50;
>   
>   	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =
>   		mes->ring.fence_drv.gpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index d8de2fbdfc7d..762bc6059387 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -235,6 +235,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	} else
>   		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>   
> +	queue_input.oversubscription_no_aggregated_en = 1;
> +
>   	queue_input.paging = false;
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index f9d02d7bdf77..95f0246eb045 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -226,6 +226,7 @@ union MESAPI_SET_HW_RESOURCES {
>   			};
>   			uint32_t	uint32_t_all;
>   		};
> +		uint32_t	oversubscription_timer;
>   	};
>   
>   	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> @@ -265,7 +266,8 @@ union MESAPI__ADD_QUEUE {
>   			uint32_t is_gang_suspended	: 1;
>   			uint32_t is_tmz_queue		: 1;
>   			uint32_t map_kiq_utility_queue  : 1;
> -			uint32_t reserved		: 23;
> +			uint32_t oversubscription_no_aggregated_en : 1;
> +			uint32_t reserved		: 22;
>   		};
>   		struct MES_API_STATUS		api_status;
>   		uint64_t                        tma_addr;
