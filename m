Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8F5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 16:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F6310E9E0;
	Fri, 11 Mar 2022 16:29:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E8310E9DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 16:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIBK0LTiVnSMtj1+zLm5rf51bsUPNwjAJp2JC0Wv/GP3GUXiB8ht8PWS9tEGy4MzXWTY4ifdYVBxlJKsnH6Sl2qHdE+Q6c7/YXPeYwgZhk1pUZXiPgThFtsW/jVsYk3DAgxa9ZO8oeT2dhnastG8VCR95Hk2Wjcy+VxKEnO9kg2YChSw3lNBcM4its78sFQafmNM9zvXQSydgir9mv1lTJmZG18mdcyRpBjau5hKK52pShsbcas2hLnR8OEHqxOV5tKJkmaPs55ukHzV8TE7GfNpMjbrnbvE/R4xwsZpnb3cAupyoxKG0MZc6M8Xxh9dE1o5yL+GI8cGmpbuv4uKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYaBomQCubf3AMSSI5/nli+5XUvhsfTpAjmQ1m+JXa4=;
 b=Ttb6bnl5LjVkAiZ/5ubeTWzkLh6ij9KOuS/mXlJeYBeaekWeAcn2qbagEU6vXarYoI/tnP0AQ0R3+bV94PhOT9qszJ6HK0Hjb02Xdl+IZoKqv+tpSrm8Xhj88s7FdnYFfg7VoHlMCzeNnfwG0b4NGhF3r+HWbpvX9HC2pJ/2c9ddYhcjdKgtqbaET6bW0iNzaC2gPCVzt58o4c0xU9O1/YVyXj3NISYr9fsaIvy6vDyctSZM8vi/P3TeAIztQ3jTXG+5wsytUFoziulwfQ9+nejMwwYLNNpAk+F0IYfgUyvlDqSJylVzYPmk5QwD0Q5ZNjg4QqYyHnIMl1LSGD+J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYaBomQCubf3AMSSI5/nli+5XUvhsfTpAjmQ1m+JXa4=;
 b=SON2XiNhWYmbIYmFGkHbAk4SEnR5e741UDZ/98aYGKX+QNWa573R2yBV0+sLGzo1TPmk2bhaZXaPKpJijQvMswOS+iQsn70uj7a+Qas9YnBtY+3j4Bw8cjPEIFBwIoThe8Jf0eseVtbQ5MUuB86HulW5tBA9yftzwvtO8hZlhuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB4760.namprd12.prod.outlook.com (2603:10b6:a03:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 16:29:33 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.030; Fri, 11 Mar 2022
 16:29:33 +0000
Message-ID: <d43c6ac0-73a4-84ef-a188-94e85569005f@amd.com>
Date: Fri, 11 Mar 2022 11:29:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Move reset domain init before calling
 RREG32
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220311151509.4760-1-Philip.Yang@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220311151509.4760-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2afce9dd-2875-4c82-57e0-08da037c52d8
X-MS-TrafficTypeDiagnostic: BYAPR12MB4760:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB476087AA2345720CDB62562AEA0C9@BYAPR12MB4760.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqS8JJRm5JdqddONTcet8m+u3LTmvEpTSJeIEEBh7FYY5FB34Wjmmll9u7GSFAy8lm0ROtJD45EhAef2FODDDuvkklb//LiBxqIL6PVlZ9g06KQmhyEzNMbsXms1fGAOwFdi/UDMKDUHpL23a3FZyXdx6957LZJ2qWFHlegbz6uCUKCWPQOAZjATyVG0Y7/DOuL8KY1rYTmfnBGYgFRM6enOk4IgYuY1fR35oaT2MxhSToX/5RY5KcxAalDCc6iSie25lNMltpO92jBPLd7w5nVdXq8Q/rVJTSXiy4cZ1k7h+JApax/niCNt99Y1vVga8OzCIGCbUr0VuakGll5ESTa9wG4k0tAd5FOsAPo4Zg8ti0N7p+kx0dZqeIWThykQZaP8n5eURyIKPQ9YDJvUF5SCCT6BkadNtDLXKUN7LsZFLYCJ8zzldGO1IDfe1kh5unyxi/KuNOIljOowfD1uUoYvm4NF7g8vkZXbZYxfRbkIvcEjtn3HRlsGv7LpMJJ70XDa9Oq076F4mP4FWo80kqx/g5o+TkMrL//5i2rUjZRHt9qx60gRtSMttkVCiUMOtY13IYVKk+YiUi66cOJTET+uThTPtoFH4xtHRrw6dwQ8cRXBsaVxt0aW2BtclO+sx4q7ziLXVeoRciEj5Zw2wsdgcgmb206E082Q+Hmi2q1dLnKJxUxDkt/m24mRaPprgXK/myqnKz95V5Xr2KnOb6B73nrKrE+KnB7XhwiPHtEZTJj3LMSKX8LmLvFXreXc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(53546011)(66476007)(8676002)(6506007)(5660300002)(508600001)(38100700002)(2906002)(6486002)(36756003)(31686004)(8936002)(83380400001)(44832011)(2616005)(186003)(6512007)(86362001)(316002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZvUElpWWNWSWNib1FrSk1IaFZiN3ZMTmM2K3FqTlhqdUtRT09VK01vM0xP?=
 =?utf-8?B?VU1SRHF0TXE4dDJpdnZtM2x6cGJZQitKSFRaY0tRWkNCeHhFSXNOS1lGUnVP?=
 =?utf-8?B?ckZ5TjRJYVJRN3VNcHp0eGFob1llVVA0UEsvWVNJMk9EQ0c2N1lZdnpkY0py?=
 =?utf-8?B?b0xPVjRhU2EwWXR3Y2ZMVmVYT3VVdFRiL1JmSXJaN21ST2duVmUzUVBtblZD?=
 =?utf-8?B?dkd2Y09CNVdlbC9Zc0o4S3FGVlU3dGdEVVJVUkV0RzcxY0ZiZmw4cGpseGZK?=
 =?utf-8?B?bFd3b0d4YTFwRzlYcDMxa0RvQVkyQXJCeXVLbnZrSC9tUDhXVjd5c01zMDFj?=
 =?utf-8?B?QnhSRUxkTnRjcDM0RHlVbWQwR2JNcVJ4L0xLMytSMHlZSzY0bjZwMSt2UHIx?=
 =?utf-8?B?OXZqdlhNbEh4NW1INjlDeWpxMHI2T0tsV1VtdC8yZUNCRnFZWlRJN3dNeDJj?=
 =?utf-8?B?RUVTeWpHK2xaa2lMcXFOU0gxSVREM3J5WWY0aEJ3TUlNY1JMVm16MEl0SEs0?=
 =?utf-8?B?OFpqRk5XNU9HOGNUcFA2UUpjTGJFZUY0WVFPOHQ1OE1MRmE5dHd4aW9jMDNa?=
 =?utf-8?B?NHNCT2crb0JvbE1ZZCt3UG1tVXI2SlJmNm50bDhGSENma1Ntd2sxR0lja1pa?=
 =?utf-8?B?RWhVZGJXTXBFSUpvdjNmcFlkVys2Wit3OHMzd0JadC9JTThSUmZGU2dYZmhl?=
 =?utf-8?B?ZWZnS0JCQTBsTDU3RitoSE1lL1BhR0ZwYVFHRjJBL2xCQjRQLzVhY2t4OURY?=
 =?utf-8?B?ODNSSzYxdmZJN2IrVHZGWmJvQlpVeXd0UXZEanRnZ0ZzV1hIR3c1TzVHQVQz?=
 =?utf-8?B?bGNwczMyUEI5Znl6UUhEUnZJc0FQcGR5T1phb3l6bmpuSHZsbmFLdC9ScGR5?=
 =?utf-8?B?OE1VT1czaFBFd283S010WVM5bHFKa0NhL2JLbHZEVjQrNU1yeUZsZDg0UEs2?=
 =?utf-8?B?b1JPOGUra05kN2RoUUNCVWdFSmNOOEJUUmswTjMrRy9vaHcxTHdhaE9HTGxT?=
 =?utf-8?B?SHNGMnlvN29oTWpaeG5sekZVTmd4S0ZMK3ZUOEVUYWhhbU5SK2sxSjBHam1u?=
 =?utf-8?B?Rk1IU0NOWlFrUzRFeWtIVjFXNTVJeHVYWEZhU0NpdnhPWnFqVUFxV0dHa2FT?=
 =?utf-8?B?YWI4TzEvcXI0bUZpWlIvR3VqWDhsd083WDBWdGNDMXI3YzVqTHd5ZERGNGsx?=
 =?utf-8?B?M29NaWZGWTQ5UVd2bmNYQ3EwdXJIWlh1UDY0V0d1Y25tcnJYajhIMjlUTUZC?=
 =?utf-8?B?V1NzSFhlWWw4TFBhbk45ZWNVcDBEM0E2RFE1RFhoR1VzTXIzUjFGUkRKdlJh?=
 =?utf-8?B?b0JvcTc4L2dlZTNUMUdxSjJFeU9ieEFJRlk1RFVrMjVML2ExY09YNTZ0dDlh?=
 =?utf-8?B?bXc5Z2hnc013a1VxTmoyanFJb1R4eElURmFtbFhJd1RqMzBqc2hxZWlCdFpE?=
 =?utf-8?B?a2dxc2duajJEd2tSK2tlVUVpMVhyUldVMTZQMDNOeEZqN0FLVS9CZDRBSC9m?=
 =?utf-8?B?QlV4MngwMVFFSTkvaUM2bjBVZWN5a29NNStNT2V1VmhGRTZFSWZab2EyMGVV?=
 =?utf-8?B?cklZQzdlME1qdUp3cC9IaUNJMkxZVDdYOWFDbVZ4bk1VekJESzY4QVRmb25X?=
 =?utf-8?B?T2hSZGo5MlZ3SjA2eGF5Z1JTWEl0cTVGbFNGeTVjeVJXUEhlOFdHN2JxRGZC?=
 =?utf-8?B?cFJ5RmRySUg4YmpFekFzY3RNRlpRUVlXYWh0U0pDeFFNalBaM0l6SWtrRmxv?=
 =?utf-8?B?Qy9oZFBFNks1MG41dCs0WXZtVFIrUUZqaTRrdFRTWUpKc2t6RmxvSTBqWGJR?=
 =?utf-8?B?Wm5YNitHRG03Q2hTdmNreHMwazByYnFrbTNXVDB3RUo4UW1QWE40NVovTkhW?=
 =?utf-8?B?RzZqNE5sejUwUlJZTG5ndFhIQVhDdjN1bW1FOTFNVFdieEtnSmZxZFF4N3FW?=
 =?utf-8?B?QVlsU0FvekdSdUxjeGV4ajhmT050RktwWWovQzZNd0pYUUxJNnVZaCs1WUpE?=
 =?utf-8?B?Ry9MYTZCZW1kcnd4TTgzQ2tkakg3dmNTZStlUzBzZkJrZHFRVlM2WDVTZWsy?=
 =?utf-8?B?bUNBUTdXanc1dHM1VTFLckdZZldTMjJlMDZ3NFd0M1ZtZ2JiL2FmSVRkdk91?=
 =?utf-8?B?QUNQTGJEbjEzZVU3RlQvZllPajhWbnlwaTNPQzYzeDR3N2FlczRGVm9FbXQ1?=
 =?utf-8?B?cnBPNFJYVVFSbVlMalBBWktQWkpZNjZqM2ZvSVBoV1JqYU4rZnFMdlZqOVdk?=
 =?utf-8?Q?DD1kD8opQXxX/TPzINl5gYAE+TMdMYcuUXSPORzVzI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afce9dd-2875-4c82-57e0-08da037c52d8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:29:32.8490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCUTCb3rNijp0IzAQx0Lzp7uG+QPRBONI/7koBqVigzyudvXnUDeTRMdpeh4tK0xiXWVRKfbt9cA72tTIvkVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4760
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

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-03-11 10:15, Philip Yang wrote:
> amdgpu_detect_virtualization reads register, amdgpu_device_rreg access
> adev->reset_domain->sem if kernel defined CONFIG_LOCKDEP, below is the
> random boot hang backtrace on Vega10. It may get random NULL pointer
> access backtrace if amdgpu_sriov_runtime is true too.
>
> Move amdgpu_reset_create_reset_domain before calling to RREG32.
>
>   BUG: kernel NULL pointer dereference, address:
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   Workqueue: events work_for_cpu_fn
>   RIP: 0010:down_read_trylock+0x13/0xf0
>   Call Trace:
>    <TASK>
>    amdgpu_device_skip_hw_access+0x38/0x80 [amdgpu]
>    amdgpu_device_rreg+0x1b/0x170 [amdgpu]
>    amdgpu_detect_virtualization+0x73/0x100 [amdgpu]
>    amdgpu_device_init.cold.60+0xbe/0x16b1 [amdgpu]
>    ? pci_bus_read_config_word+0x43/0x70
>    amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
>    amdgpu_pci_probe+0x1a1/0x3a0 [amdgpu]
>
> Fixes: 1228996f0 ("drm/amdgpu: Move reset sem into reset_domain")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71876ff466df..a35c6acfe2ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3665,6 +3665,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
>   		adev->enable_mes = true;
>   
> +	/*
> +	 * Reset domain needs to be present early, before XGMI hive discovered
> +	 * (if any) and intitialized to use reset sem and in_gpu reset flag
> +	 * early on during init and before calling to RREG32.
> +	 */
> +	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
> +	if (!adev->reset_domain)
> +		return -ENOMEM;
> +
>   	/* detect hw virtualization here */
>   	amdgpu_detect_virtualization(adev);
>   
> @@ -3674,15 +3683,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> -	/*
> -	 * Reset domain needs to be present early, before XGMI hive discovered
> -	 * (if any) and intitialized to use reset sem and in_gpu reset flag
> -	 * early on during init.
> -	 */
> -	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
> -	if (!adev->reset_domain)
> -		return -ENOMEM;
> -
>   	/* early init functions */
>   	r = amdgpu_device_ip_early_init(adev);
>   	if (r)
