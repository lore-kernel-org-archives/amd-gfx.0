Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6B9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 18:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0B910EAAC;
	Wed, 23 Feb 2022 18:47:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A16210EAAA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 18:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqbbyl0PUIWRYWEe38fHu6V75sSV3UBJDUIa73jzjy4seadFQURBTwG3Nl2gJ3Cbq+BL1ixAvulcFO/C5PSC0tLFL10Y9gxBQnX8rTEQIq4nlenBfcYo38fu576tUBlP7by/WFm0rCfgSc70PK9Mo0sAmpWmQEwJ/mYuPSaqp3Wc3r31GdxgVsdBQ3Nyu1kF3M7sVA/0XU6Sl2T1tut0VZKM/wgrVYwH0RcRXkJYHBDdj/2bb9Pbj7ndIENCqMyUJlGzdKNsX2rCMSFQ3BmPE4xOrhb4XMJ2lfNwFsYrVaO5I/8OVwLBLwBIhl55/omVoFScY4EmCADFivqRs2v0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3boMWGU03htytqUFzhBEBEs1JzsZplHxLh3owb1QFM=;
 b=SqmfBipVcx4Cg5IvoqkSyHm5LIzXWJ0OHYq1tv4jv6m9TBis6GymoWrHSaqUPY9D1DGuKZx5i0iq+uYlHJiYtOK7uWMi68SRzlqpAk/fTPYvppVkKBxblT7QBXyDxc7aYBfGQOo0FGwvZ5RvYLKEZSY6W0IZddFNjkLt97KuBHwQ4CLreVy3VLtZxAg+fkY14Fa6tVBuDx5WGwezsMTmx1FreQN4eRMD0YMHQxU7cSYZ6cyORL0563i1erddVF8CFYo0YFyJtWfOQBlShl8tevy19gnwWA0d/LD/fzS+eAn11t2Zt0X21sqKMUqaCnLak26BmOPtsdGyPoyz0p4OxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3boMWGU03htytqUFzhBEBEs1JzsZplHxLh3owb1QFM=;
 b=I988TsZLO7vuP4dfFlbSeRMy1w5tpeB0KkqBxlPfiwJadLivgmsWdKljr7XZDbGy8cfYokHWWK3RCxr1/V37+Mu8LsZ0BnhbZJBKqVuSaTMst1bx+mLuUQftWZhs0wwWgtiHLlfAaUqxiGmKRNKzVOTw3/tmsHKH6lmcS1BjLbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR12MB1842.namprd12.prod.outlook.com (2603:10b6:404:fb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 18:47:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f%5]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 18:47:40 +0000
Message-ID: <f55192e6-3f85-715e-6b5f-9b188a7ba949@amd.com>
Date: Wed, 23 Feb 2022 13:47:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220218165349.7489-1-alex.sierra@amd.com>
 <20220223174756.759-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220223174756.759-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:5a::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17d296af-4fba-4d43-27fb-08d9f6fcf740
X-MS-TrafficTypeDiagnostic: BN6PR12MB1842:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB184254A5BDB0068DD3C6FCE1923C9@BN6PR12MB1842.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u12C5p6SKhurfzPuxj8+2ptx4ndOgQtJ/Wcxoa8YPw3YOf30h+cRjZKKzLtGl+aDgbwHE0ZCZfs8euIWsefonWcxT2a0LBvooRdTaRjA0l/QjQY3qDb4zEtyDtQXD16aPF8ZsUAmrU6Ek4peE1IlZKyIRDOuFva14g0QK+9FD3C8P0Dp/3x4DdSMg16pHcLUU1bgp7oP1h4haT+cffmK7551OXd5llwXzjkRKKOn/CdSQlQ+xfySRwdxy50uMQIs+xBnsQ3/vbXUAud1wEOHvfgnyd9ggoXDa0TUxlmdVuFyVpQj7vWr81ojYDcO+N+fxVrxAko6SCfWpNfb7zrGeG75CnvOnCRcWRzE9wfQxXlnx0gLZOmhHbVd2Nx5drUWQusr8hSA704WondbruB7rjP8oC2arGj1GH+bFVS9/kzBT4Dip6YfQgmXPSK5Ym5rz1g0Bn6Gmxr/e+QQVJLu6Kb+s/9NJsVJRfQfmnYW4pZfMToDkR3A01iwFW/PnzgnZbTyonEGaYvLtLCJN1m1i78Gii7P1YxZgH8PREuVkFd9qrjAu90hbfjsIlXhWsGidSEBuo+L+UVeKWbXmgUk2GlmG4PGuJBKONnOrPPNKZ5tmNlcxbhQJ3qMkc00cfqkmMh+t+/CvwhAXjpJLxuFFmT3aXnUqPDfmdOrL4ueYToJEAzg+FsmdjWbgZsesy2xuiMB0COSw7DzSRJ2ZHQ3NAGgnl7WZyhNy98wrmj5gZNwbyflEQ/AVbknOZHvRF6M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(8936002)(6506007)(31686004)(6666004)(53546011)(36916002)(66556008)(186003)(26005)(508600001)(316002)(83380400001)(6512007)(8676002)(66476007)(4326008)(66946007)(5660300002)(36756003)(38100700002)(2616005)(2906002)(44832011)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdpSU9ZTFR5dVVldjFEUTUrTnVzM3VUL1AvM0FEbStMaHBFRGQwU0xrVjlF?=
 =?utf-8?B?dW1iUlM5RFUxSFAwcmMrT21JYytPY3dPZ0NUMWJTZnB2UnZqUU1kZklaV1pP?=
 =?utf-8?B?MkVFWmd2ekVBVTkvVHAyWjZiSEF6M1l3NkV5VTc5ZzdPSUpXamgwYTVTc0hI?=
 =?utf-8?B?Nm5YdnZ6S1owcnhPb1dGKzNXQ1QxSWpiNXl6dyt5RGxyaUpNejdFdFZxbG9v?=
 =?utf-8?B?SXkxaWVBRnFEZy9aYjRweGVoS1huMGI0RDViRkc3RUNIRnZQNFF2ZGplalYr?=
 =?utf-8?B?QnN4eis0dWJYOUo4dlBVb3JURklmZG0rbWtFM0dQVEZXL1ZOeUs5NzQ5dEhC?=
 =?utf-8?B?MVJPT0VDaVJKMkNLWGpSOC9BNnY2S1dCR2RpSmVrY0hZL3ozbzdsTlN5MFI3?=
 =?utf-8?B?WW45QnVLeFlGdmhWeVVrenhNOUpiTTBrcjlmM0taNExhSVVWN3RNbmNERGlT?=
 =?utf-8?B?cGtTS2pVZ29aU3BFYXcxMkYwZ2xXaXN4VituOTRkR05NK0lpU3RGeWU1QlRu?=
 =?utf-8?B?b0FuWnNyTFlEclN4UmZjL09EOENUU2xiZTV4WlU3RXBSSzBRNVdHS2ZsSllY?=
 =?utf-8?B?Ky9IaUhtS25abFVFaHV0VHBTNVo4Vyt1K2JHemdzTTMrMitQVzR5ckQ2U2E4?=
 =?utf-8?B?ZEN6emgvNkYyNFFyU0l4ZHFHUGZKNWhZb0prcTFZTVBWWnZTeERwTlBPUHUw?=
 =?utf-8?B?MEZ3aHA3Z2pUZGgvR0xhQ1NXSHAxMVkrK2xYQTBNUTNTQm83aExMTFVidWFp?=
 =?utf-8?B?QWc1ZkNUMzRraFU2MkRIMTNLb2xTWGZGZjgzdnUwM0tvMUJjY3o5WndBWVAy?=
 =?utf-8?B?QTdCeDc5NEo5Qk1aSXljODB3QXpMS3Q5d1dRQWxkeUxRYitQNUx1cTRGdnpa?=
 =?utf-8?B?MVV6Tk9QOTU0TEpZT0JBem9zZlJ0UW9nc3pZdHR5Z2crRWxDT1pRR2hRSFVR?=
 =?utf-8?B?aUtWUkF4S0JZL0IrYXpwUlZnTTNiTFhqR3l1ZlViZEplYW0zS3kzNnY1NUlx?=
 =?utf-8?B?aTBYOXliT3VuWWNMUjBPUGtwaG5Vci90Qmt6dHdXaFRWM2pGeG1DeFd6dTdx?=
 =?utf-8?B?VzBoWDExM2dzWTBkSzh6d2tvMEYvZlpCSWtIOGNxaUhPYzAxSjJKMlhEN1FG?=
 =?utf-8?B?UTIxYy9XU2ppZnpEUDZCR0JmNmtQUXVkTmYrQVhvZjdud2RMaUd3b2IxZHFk?=
 =?utf-8?B?cVNaKzVPSjl1YklOZXhFaUxqN1N6Tnd6TWw1eUlpTW9zb3M0RStzdFVpb1lF?=
 =?utf-8?B?ZktRWVNyNEtRcFpxaWdpbm5pN25DcTU2QkFMUGNyb0labW9GOHUrdnIvSmxy?=
 =?utf-8?B?SldxbFBRbm4vYkpSZE42bS9wU0swVUwzTHViUFFWa1hhVUNaSzJ5WlJna0JZ?=
 =?utf-8?B?NDdFUHRRWnFzQXdjZkc2UGdPWHpRZ2lzVldDRnRKbGVKcm1mWFo0ZDdCb0tv?=
 =?utf-8?B?YjNndjkvbDJEV3B5ZU1UT3JpaEkxRDYybkFTWHBOOUppdDQ1RDVZaWhKUXpN?=
 =?utf-8?B?RWZZbmt3cEtoWlJUcFVOYytQcGhGekNwOGZaVlFxQWhlZ3RsODF6NU5Hb2Nu?=
 =?utf-8?B?RmMzckVvaWovdG0xN0V1b2pCdWd4RTdJdWV0Rjh3ZzlFUVJqcEE3QWduY0Rh?=
 =?utf-8?B?L2hld01xMks3R2orNytycXAyOE1BN3QyTGFTTkhQTWhEdmY1RWYrZU1jM3Js?=
 =?utf-8?B?NmpVd2NLWE5WeWQ3UjRoTlZ2NjJGeDBrM2k1YjBsYUtibVg0ZFg3NTBCSjZJ?=
 =?utf-8?B?VDA2MGl2S3dKc3hpcnpVWlVUMk82MnlSb1lQdDNHTk8wdFhqblBPcFEwczEr?=
 =?utf-8?B?eWhiRG05UmNFYlZtLzFHcHhaZEV4L0lvRkpLRmZiSk1hTzNBLzFtUEJtcitP?=
 =?utf-8?B?cTkyK3FwaW1OZjM4T3pCQTNoVkRLVHkvRHY2ZDh5WjgwTlluZUMrRFB6ZXNy?=
 =?utf-8?B?eUYyRmlJTVJ2Z3doUHlQLzlMeXRML01TcnVwcEhrRDg3T3UydlVad0ZCRjFE?=
 =?utf-8?B?TTYvNXFZaDlSWDF3S1RKQXFrMWt1aDJpZHJZM3cvQlNJeVhiVlVTaU52ZFNZ?=
 =?utf-8?B?elNYMHIzcHVaS1JieU9ESkhKTEhjcHdyNHJQU1J3Zld2WmJPT2ZtZUtTUnJ2?=
 =?utf-8?B?QzFYNDY3WGQrQUJxbmF3UGNpUWNaSmZLekU5UjJrRnBtb1RIRHdyMGE3bm8y?=
 =?utf-8?Q?d+2X8Lb2LVf72kIi/RxtS4Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d296af-4fba-4d43-27fb-08d9f6fcf740
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 18:47:40.9075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KGctCcwlJ4HAEo/hA0C4Bl8O3NakL02Ex8iFaPjhdXccrGh2HhcZPoQLjWK4nFKwKSqlM5E7nbAy02/klLxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1842
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
Cc: luben.tuikov@amd.com, jonathan.kim@amd.com, Harish.Kasiviswanathan@amd.com,
 aurabindo.pillai@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-23 12:47, Alex Sierra wrote:
> This parameter controls xGMI p2p communication, which is enabled by
> default. However, it can be disabled by setting it to 0. In case xGMI
> p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
> This parameter is ignored in GPUs that do not support xGMI
> p2p configuration.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 3 ++-
>   3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f97848a0ed14..7e95d8bd2338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -217,6 +217,7 @@ extern int amdgpu_mes;
>   extern int amdgpu_noretry;
>   extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
> +extern int amdgpu_use_xgmi_p2p;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2f8eafb6cf22..6156265f3178 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   int amdgpu_smartshift_bias;
> +int amdgpu_use_xgmi_p2p = -1;

We usually use 1- as default if some logic is needed to figure out the 
actual default value. I don't think that's applicable for this option. 
Why not make the default 1?


>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
>   	"A non negative value used to specify the asic type for all supported GPUs");
>   module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
>   
> +/**
> + * DOC: use_xgmi_p2p (int)
> + * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is -1 (enabled).

Same as above.


> + */
> +MODULE_PARM_DESC(use_xgmi_p2p,
> +	"Disable XGMI P2P interface (0 = disable; 1 = enable; -1 default, enabled)");

Same as above.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
>   
>   
>   #ifdef CONFIG_HSA_AMD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 0afca51c3c0c..095921851fb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -66,7 +66,8 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>   static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
>   		struct amdgpu_device *bo_adev)
>   {
> -	return (adev != bo_adev &&
> +	return (amdgpu_use_xgmi_p2p &&
> +		adev != bo_adev &&
>   		adev->gmc.xgmi.hive_id &&
>   		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
>   }
