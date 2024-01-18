Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583D2C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 07:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B7C10E071;
	Thu, 18 Jan 2024 07:44:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B257110E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 07:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inFUp2ktLxPxueLvZeLX5MAp4VFyB+dJ6OKJKeVLWuXk4nD/wveOMYxuKJtNchPDFfzZH6F1sogmseGFEU73yVN+GZdTCecWDb39pM9zaA6Sqvt4hBUyDedd8hgMiooVGj9gdUbwjxFStkZ+46aReSZ/pqjSuIwWXn856mQHJ0PxVz0aFvbOr/9jxmnJ303uXRbH8moAwDdVhz/oa45Vc9PjZ6SxpxWJ5F3IQPKBesFrt9ACYMDfk2pwk37H14S7W+uumTTFY7EMRWVxRJYWeZnzuU4vj1GKTsVdUICHlWghf5LvcoU1utiVrzUX6qvzxGeeRYvtn3H+0H5i3GeVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkPa6y4CIxPfNZq4QIaj0f0CuXgTBiiIdB3Wa2zmp2o=;
 b=IIVbFoJoRA99jrO1Qf7qL8xk9HbhkBrW8HrK3Z+zYgwQzN4RA4ZOl4+R9pHt7zLcHhL2t4sS7gCQobibXkBXcm5NxwNtIIxOzj3PXZ/Q4dYVnliOrnXLcg+jbuZ/44KJzm43ld4qa2Z2TJQuc80Mtz0+83j28A1ekoJUjc3WHdQd0KwYZrbF88EAPO98kNaAVzowJmzqc04Qrj/0RIeKbfKzC0O4PhCGW/3oOZI9zlSFmWq5w2QoT3O4fV8PaLPik2nL30+3VwXdGWJjFZmvg1aUQ3jbtEtAgwkE+lojddnMgfw/Ya3vkYQlR8zWLRHrdBDOfAaNjyRJO90rJWVoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkPa6y4CIxPfNZq4QIaj0f0CuXgTBiiIdB3Wa2zmp2o=;
 b=Axpy5jL4/prQr/GBkG7/FKTVuuNhpqgFtaUz4OaqaPWRas0iH/1prVCvElkF8KilTxokzfw75n2DnRndC/ELU55U11BC4XGqu5K+AV1P8xl6lPRxv3Llt5OeeTEJoaZsdoCEsIWdHQxOJK7LGcIHikY4IOIRxmAiuB2gdeyOT6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:44:09 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 07:44:09 +0000
Message-ID: <7c18ec41-8772-40e5-9ef8-e7b693ba2609@amd.com>
Date: Thu, 18 Jan 2024 13:14:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: enable amdgpu smu send message log
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240118053711.1975928-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240118053711.1975928-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::11) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: eddef59c-14dd-4338-2cbc-08dc17f94116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK2aa1yMdi5IfRYo34SzBBDaf4LI/wmqFXxL5a4fJ99iI60cDBTTG43vgR6yVUIYnH96jV7jKXpveH7w+v1ZVI2CFGpogbSEkz3buqOpBZLbPaUS6dqT8BY8Mc12WCe8Ny9qStrsBoYaxWnXDfMM5jtPHMSU5bp1zwV4+bUZjTA8R/fJI6LBryuiSrmsqD5xs9bmLjJGIjKKzcpJFIoqUFxPu8cz8QMQOYtAVhbI/25d8bSkBTS2O9zSD5Zkb6SlsSpDXPDJODoJCfKFZZ6i9w23sI9lfBFWX0hLVA/n7+HZJ+DHt7IUojJLGYj+2qI/iz/dDmVhISArLydBJtgtzG0kqDuFRTMrSO4Lqv6UVxx0HCXaqqcaOr27Yj5RUyHO92k+hnJXUWh5WMAsxVpYfnWL6eoUEP8u90ucTmHQFzmpIecZn4vsWN2S1zWvdouv6cGmXhanpE/nYgJDJ8jvWCiSW9PFBwWIYsKxz3Ci4iRb3VXV/+aseGDTKdmgjqeiIBwbfHhKpdY05Jh+Z9Bo7rji9K48A9DWKdGsbOwV41Obz3kpq+pRFBvezyRML2fusLjqybhgvlwGqGciGKilh2Ji6ktcmn0bf5TI/SyzRMFxi69aBNGUuwSiM5A5vX8tuigPtRwz/EOju5CEBZ2fKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(6486002)(83380400001)(8936002)(8676002)(4326008)(5660300002)(15650500001)(6512007)(53546011)(316002)(6666004)(6506007)(66556008)(66946007)(66476007)(478600001)(26005)(2616005)(38100700002)(2906002)(36756003)(41300700001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3h3SlBkdVVUZk9La1JsRndsUGpBSlc0UUFkZkk5NUxqWDRxR2Q3aWRsVnNi?=
 =?utf-8?B?Q0ozT0w4YWJxbEt3RnZkWXFhZHM3ZVRSSXhTRFNmTVBCdGVuWmJPRWJPaWQx?=
 =?utf-8?B?a3VzZlVSTUJ1TTBsREtLdFhVV2QwNWFzLzBadnBOcXVzVDNVbW1aV0pZcnNv?=
 =?utf-8?B?RjcvQVpwenlGMmVYbEh1VWo2M0hLaXV5RzIvOFkrdjg1QUV0bTJSekhYdW1Y?=
 =?utf-8?B?Zk4zZWpUK21sVXJZdzF5anA1bUt5ZWRORHRyT2h0U01KZUtEU2ljQ3dKSGhT?=
 =?utf-8?B?UEhrTGlsbWxUdFdpV29EYXRnM2l2MkVPMmx1QzVhOHl6Z2xZNkZFQTdMQ21D?=
 =?utf-8?B?aVAvcnc5NmY4a01qYzllbzBnY3h4QVVFTUl0R3lNRUgxanVwWVdpM3QxcDVw?=
 =?utf-8?B?M1ZkTVYrWTUrejFEVGp5b3QzWVRMaDd5aFd1S3M2eU1WU0dGajhnU3B6ZFpq?=
 =?utf-8?B?Tys2RkZGeVR0YVMwdU82TlFJYytxUU5HaXZQL0w2bmpsY1Z3WUVOKzBYSm5D?=
 =?utf-8?B?c0QrNmY2di9oVmVsVFNheGF4cU1QQVpGYUpnZ0tKdEhwZ1pKd1Y5dHByZFFX?=
 =?utf-8?B?bUhvNWRwLyt3VXZmbmIxSnN1NWRQNkc3OTloRFpraW1WQ2V2aXR2V2JTMHBL?=
 =?utf-8?B?WmdvVGRLaHlFMEZYRXM5bWE0V2ZzbmRzcENGVjlvTmNDbE42TzlERDM2UVBo?=
 =?utf-8?B?dVBtRjkxZ0FFeFJyUTRpdzJVNjdvV0RTb3lHTzc0eFZWWWx5VzUrRTNCQ05U?=
 =?utf-8?B?UkRjQ1RqRVoycG1ISWttQnRqMUplUzJLM0ZWeTkrTnZ6dytjcjVPL1hWWFNX?=
 =?utf-8?B?L0pHcWF4REpmR3NiNUpBK2YySW1HYTZPVFU1Nk1XTlN6OWFjSXF0elBYeXNq?=
 =?utf-8?B?WkY5ejFEUGRycXVOa2lzblh5Znk0ejJQWDNUSm1NNUo5V2JER3grd21DY2FB?=
 =?utf-8?B?enNKRkxwaWNTb3hJdm1jT2s0OTk2Vk1pYW5qakxTSWtVdStvdGt4b3pCdVVF?=
 =?utf-8?B?WU01MlZrTmJWeENGaXdzMDZ0ZklVdTJKUGx3dWw4ekRRWVpNclVVb1VEQ0Q2?=
 =?utf-8?B?MlpabWlUL3E2QTlmUWFMV2dnWFFOd1RQU2pvRmczMlhNQURoUEUyWFd4ZzVG?=
 =?utf-8?B?OUdVQVNGeUxLV08vcHNjM1NsOTJTZjhCMDJEN2dudzFsYmZkZjlaYlNUYjB6?=
 =?utf-8?B?VEEvR1Z4cmlDa3IxUlVoMFZuNFpjajZxT2d5T0M2aUNBbVVDeVpJdVppMit6?=
 =?utf-8?B?Ukl2ZkVvRlp6OFgvTVVvVEZ3NCtkSnhtUnJ0NklYVTkyMmtMeFNJOEdVaGIx?=
 =?utf-8?B?TFlnQy9PN0FvYjh0alo1ajRRREp0N004bk1lTHJ3VWNEMWM3Y0FRT2JMNG5I?=
 =?utf-8?B?OFBBUXRSRXhWR1AxNVI1b0VtVGdlWG9zWkx5UUlsc2tIQzNsSWc4RG5uSWpT?=
 =?utf-8?B?TFkraEZEcUgrMDJFeUZvRHBPVkYwY0ZhZWV1NVB1MGdvcXNhVEF4KzU3SkpB?=
 =?utf-8?B?OS93VjZsVlM1djMvUWJReElzVmg2Z3R2ZU5qM1R0a3lvSzNVWkN4d0tXbjNJ?=
 =?utf-8?B?RUxuT3cxbVBtUGYrSmNnT29rekM4aEhsRi9NNGZ5MmN4L3R6N2dJb2dWeFBF?=
 =?utf-8?B?dGlFZGtTbzcxZjh6dmRncnVscG9XV1BVSkU1eXBUY3VsUGorRjROdjZMWEhT?=
 =?utf-8?B?RVVTdHM5K2pXZk9LRDdTOFRsOFZDTFRSSEN1VWlOdFgxNklJZVV5Sm5pczJL?=
 =?utf-8?B?OW5qOHFIMDZXNVh5dlIxWm8vSzVXNVl1OW8rLzJqVjNWeDJmNEwzVW1pbWZu?=
 =?utf-8?B?MkUyWTduTUE2NmhpaWhPU1JrUGFDd1JGN2hLYjlaMEVORDNGTmlCNXpqZmF6?=
 =?utf-8?B?RGFDdUZnWVJEN0pxUTlUTyszQzBiZmNsTFhpS0VoNmZucVo1ME1Id0NkVVh0?=
 =?utf-8?B?MXF4LzdjYVQ3ei9YaDh3RHRmV0dFTkZOdFg4QTdoSGNTQ3crdkNJWG92b3NS?=
 =?utf-8?B?Zk05L1Q0ai91NGd6L2J2ZzlJZXMrcHZxMWZTNmF0NHlwTUVkZlJNYS9xMWRh?=
 =?utf-8?B?NzB1ZTNNMEdJQndlK1lVVFBvTUpsWHZLaVU1SzdXTkdNUTlzRmN2azVjazJG?=
 =?utf-8?Q?f0VmjqbLUih4EW1iYcNV///9/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddef59c-14dd-4338-2cbc-08dc17f94116
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:44:08.9557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKShl1sDzBYPqG1E+wYmhd++ODuqRFyqfMprtDF1D0U28gwqFxD+iFseTOHe8z0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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
Cc: Kenneth.Feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/18/2024 11:07 AM, Yang Wang wrote:
> From: Yang Wang <KevinYang.Wang@amd.com>
> 
> v1:
> enable amdgpu smu driver message log.
> 
> v2:
> add smu/pmfw response value into debug log.
> 
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 00cd615bbcdc..b8dbd4e25348 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -378,8 +378,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	res = __smu_cmn_reg2errno(smu, reg);
>   	if (res != 0)
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> -	if (read_arg)
> +	if (read_arg) {
>   		smu_cmn_read_arg(smu, read_arg);
> +		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
> +			readval: 0x%08x\n",
> +			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
> +	} else {
> +		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
> +			smu_get_message_name(smu, msg), index, param, reg);
> +	}
>   Out:
>   	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
>   		amdgpu_device_halt(adev);

