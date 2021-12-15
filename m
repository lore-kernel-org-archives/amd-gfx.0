Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3A9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 11:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198B010E59D;
	Wed, 15 Dec 2021 11:00:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0207C10E596
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 11:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF5tnff3fgGjozFdhe+0I516KEccaA+mpSnr5Fn2TS/Dcqj9UCBRSDhl2zhQVzgK1zODJa21HLeFzsJdGZUJp/t1Db82OHUB/XJOE2xPxndNl9yCP9jISof/2+UoxfH2S+483xLSyEbRTSTmv8nAxupMkQpTQQvZ4K/GdyoLA98GMdGwC/7w/EFojo6/HCNODp51vgxMQE9oN+hDsXKU3eay5ruIK+e8JCv7O9h0/ZTHgszcRiNKHKez/PTak4YE4rXZrup6S/Q33e1hWtW8KeU+iAg5K3zPbabX2Unh1cOnR8rG1L0+fI61jfHM9KDicLZvVR0Nru6HfvAok04deQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LMbN5rOhOTDxmslJ4BMBM5xcVtq3ql4BhZ3wGMyMrs=;
 b=BDVS6ZlTB2lnoUTc3BX29ft4jOtzCHC4u0DCdKpcOFApQ53r8daZG/NkVKINqWkhCp26AFN/HJVk8Gn7xwEjd1yEN+MDC1ekJD0teIoCA9EDmO7VxIUD7Fvy6Rplfw5Xv+Ds/tNWmEvK4LlMaDfMtIqHJeaCPzpE++A+XdzraibBSBHgZOVjTzA5BYxcaS9YFgerFKhXtBbp8R11iDbZxtlkUOWwaFDqQgvLdeDWvcp41HZlpEHqWMyOV8P6QD0F/ni7aC/7sr9uqJCrB34+KiAu/Qz1QeTK0HGTLOdYK8VfFAVo+Hyf32xsQaE5O0tefUI2vw2WM/WW56GrN7p2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LMbN5rOhOTDxmslJ4BMBM5xcVtq3ql4BhZ3wGMyMrs=;
 b=M6FCtbmzCqhAfgau4YA0f5kon3YuujDaCRUpFIUALwMq/b/sYuxMzzzolo6IaWbG7Z1tQ/ODsmi8gzmciYbAXjpvUXPsXnWLy94juPqSYgobmlvMnUQtmQwCBZ+LShA8UgEIPNFpwmhDJV2mcpD4naSiD+uMYJ34Wi5k39Rj21M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4345.namprd12.prod.outlook.com
 (2603:10b6:303:59::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 11:00:04 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4778.018; Wed, 15 Dec
 2021 11:00:04 +0000
Subject: Re: [PATCH] drm/amdgpu: add drm_dev_unplug() in GPU initialization
 failure to prevent crash
To: Leslie Shi <Yuliang.Shi@amd.com>, andrey.grodzovsky@amd.com,
 xinhui.pan@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20211215084636.2133355-1-Yuliang.Shi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a8f7b8b6-669c-86b8-78eb-e08e6ce147a2@amd.com>
Date: Wed, 15 Dec 2021 11:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211215084636.2133355-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR0202CA0044.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::21) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca47426-329d-4e5a-489c-08d9bfba0c27
X-MS-TrafficTypeDiagnostic: MW3PR12MB4345:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43452B05514871207CF42F2C83769@MW3PR12MB4345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFySt1ws+4eTVhoiNq+XtiMSFK98lIbfsq1pqp7KLxJWNHExcs/4KBqmQvy1ZXgXR2w4bQWXV9+RkZ2qUiRxCA0DeaH+vkKPjMn+JGSvdOI2aZ6ETOMxZyL1/bNH4DqloOIJRtalJUQVxd/nnN1mGzO+Q2n6l3GLsk7aDncHNvcz7KORdRzm9Dxr6tacDplFkdDudZogoA4NZypDlccUMIam86Qrm520O9Pmy6LpuZ/rRxWVmmz1+zkJ6LeQoKUCqXS5GXH3R50fQp56NhKmdxE3hCMMm8JLB8qfOujnml2vIxvaZH4nVpTr7xwgNWC6c309ESYWjsEoHVsCx/88OTHRjJqnKMCCX4c/ecLQDYzVqohooZjcVh+2OqrrQxU4EkSQ7BM9G6cM/HvxXai5GCgLiJ9DhI+LXpOvvGcFfirxED62jGZjChG41xQOQj4E3QoLo9PpNDbIyYw46zGbGVV8FWxRWiBpflmYucrNRXKxHTF0H1zzv0X+3c6b4aacZ9Pbj+y5ht01joP/ADEcBES0nhxd9scNfl+zJydps7E79jwDuEGgka+xzCtDPRS8jWOt0fnBskqVJRCZCu8MEQ6NDfgDnCWFq8uAaDdO4+tw+k2nwjNCk60BAhg8dINEQj3TfI0uTerqHufQbE10QrBw3UmhJClv207erC2SakzNBoFjAe7jGPejqCZvwUK+qWqyxJCZU10Uzdo2pAEkeq0FI7uOlAenyTdh/nNivxy0jxDMX+mqA+zcnnstYGZz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(4326008)(36756003)(66476007)(8936002)(38100700002)(6512007)(8676002)(66556008)(83380400001)(508600001)(66946007)(316002)(86362001)(186003)(2906002)(6486002)(5660300002)(6666004)(31696002)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1piYU9QQndWR3hKWkdZdnFuQkFvVnY4SkVOQ2dEVVcreUsrdGpCVDRuaGR0?=
 =?utf-8?B?OUdlS0ZuZlVVTjFYZHFLNGdBMkhUVUkwT3BGeldjVmwwNURuMHAvQnJkdlhv?=
 =?utf-8?B?bk5iellHNjhGNm5UM1YyRFpwekk0dzNyM1Q1UFEwS2w5dmdSQUU3VElWN0Q1?=
 =?utf-8?B?dXF0V3Z1b2dzR0ZFZnhXZVNWOTZoNFVoSnBjeFphdThBM3IwZEZ0NUQrQ1Fp?=
 =?utf-8?B?N2xkejlRMVJuVlRBY0hYS01ZQjVZa0dOa3VjU3VoRmFlcjdhdm1FLzZQNlNh?=
 =?utf-8?B?REpSZFFFdkFzL09UcEg1U1g3QkFsTDR5ZWM4SnZNTWlhREEyaU1MR0YxV0ho?=
 =?utf-8?B?Sm1sTnl4R0ZWWlhIZmdpS01VN1FPSEx4UjUxdGlLQ0NJb3krWHc4WkU4QjJt?=
 =?utf-8?B?dWhCaGkvWnJKek9LdmJrc1FmUkdiUG1RVjkyUHFnSXdmdzNjaTYzSFpWanZj?=
 =?utf-8?B?SzZTN3Zibm5VVlV2Y1RJMkY4R3MwUFk3NVBzMG4raCtVRDJuQ3NSODAyRjlq?=
 =?utf-8?B?MjF4Zm1sK2FUVEU4R09ubGJuUVA4aXlVbk40QVFZRnJxeFlpUHN1ZzdiOGly?=
 =?utf-8?B?RFRPb2Vrd2hBYStxbndPYXZpcktja1NiV2xWU3JSQVBsay9XN05YZEdaTTFN?=
 =?utf-8?B?bTVuV2MxUERjMzNSY3hieXZ5TDd1Zi8rWXB2ZDdXZ3lRbTlialZUaG1VZDlo?=
 =?utf-8?B?Mm9Xc3pjeTc3WkROZWxsVUlTNXdqVis1Qld0ZEtUbXNjb3NoQlljMUJiVHZF?=
 =?utf-8?B?dUhBaFBQdXNVTWtNaXAxRlNwWGZ4bERJT1J4dHhUU3dxQmxFT2pTbUU5UFFt?=
 =?utf-8?B?eG8zZ0J4cFRwaGpyS3JnUDVzUlFtM29lK2RYVlVTc1dPVWI4akhrT2xHTG91?=
 =?utf-8?B?clVqa3ltUHlKUExoT0lTNnl6c2Yva3I5Vk9DTTN3UEEvY0NoTm82RXBXWmJs?=
 =?utf-8?B?NXpVTFU2MHp5Nm1GUnBFdklXZndnMHZkR2gzU3RYYjkrREVXUWZLSS9YMEdO?=
 =?utf-8?B?TkRjRTlBTWZTTUNVbS9kcEtuYk9YNExwZ1NlZUZzejV0elhKdGhPaVZrUWVE?=
 =?utf-8?B?STJ3c2xiaTZzUTIwQU0xY3NURko2cVJnKytwckQwTEw2T2tvMytVK0hQVGxS?=
 =?utf-8?B?a1dycWdEaDZNbUNiMDdrNlR0RXpHNnJyUTY0VS9aa0c1c1lnTG1WR3NxQk5t?=
 =?utf-8?B?Q0dIMWtydnk3MG1nZHhtclN2RjY4WDgwLzJTU2p2NEx5VzdkaUJpTzFPeHhM?=
 =?utf-8?B?U1QyTy9hTTFVVndGbEZCbVpUaUx0RnpEWjNyMm1uRS8wbTYzOTlQcmp6NW0v?=
 =?utf-8?B?N0NrWjhJYWFQbFYzREVlRTQrVnNWMFdHSHpCTExUbkhRQjlhOUtoSDlXV1hR?=
 =?utf-8?B?dERDSnVkY2FLcERhUXBEeWJKaFBBYmhTbjBZaU9XYy9iOXh6dWI5UG1QQ0Zx?=
 =?utf-8?B?ZldlTDRIZzF5NTkxYnJmNElmbUw4cCtyVXlOWGZXUzA3a2UyMDdjWiswV3Nj?=
 =?utf-8?B?RXBNclB3Z2pIR3BHSXhQYlpQZEtIcGdtU3N4Ym1SZW5EbW11cDdQVk5Uanc0?=
 =?utf-8?B?bzFQNk9GUHRRdXdZNzlEWEEzSExBZU1WREVGR1NobkRlZllYeVlDbjJ5SjZJ?=
 =?utf-8?B?YW5IUlNZQnVIeCsxck1HcjNGTzNuWWhncldGZW1xVUNsV21HbWt3MldyZW0y?=
 =?utf-8?B?VGxsdVF0dHJhSDU4V1dvWjN0bE44MEFVck9ZYlVWZCt4TDE4OWFyeDdGT1RN?=
 =?utf-8?B?dWVuZUhmYXlDTjBDUGxDYm5IS0lFTGhaR3Z3bjZkQmR5Mlg1ZC8wcW5GRW9E?=
 =?utf-8?B?NEpKK2hDSWV6S3FKSmZFWG9MTkVpZHlhK0w1cnNLZk44UEt4ZlZHTnhzSHBV?=
 =?utf-8?B?RHJ1OGt5ejM0bGlreFVVN01NcGg3YlR3R3ZYL1NRS3Q0TVBrUDdPUDRCV1VQ?=
 =?utf-8?B?S0ViWklpS2ZJVXNoSXNSb0J1ckk3Umhpanh4ZzdjT1BqSVV0SitJOTQxbEhO?=
 =?utf-8?B?MVpqa3JtTDR1K2dJbVBSZFhHSWJvS3pGZ0hmMWpRTEVnZTBLYjRwVFM1d3dX?=
 =?utf-8?B?NGxMUEdTeGw5L3YyK2dLOC9nT0RHNnFhdEdyRGFGNFJQUTM1dEsyTGhnUXQr?=
 =?utf-8?B?ejNMeGM1V3k2b001Z2xNUDZ3dERydEN4T2QzTXlqNkxNbjFGd0gzYzBVQ3cy?=
 =?utf-8?Q?qeeLvOdOkorxruSxryOi+Z0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca47426-329d-4e5a-489c-08d9bfba0c27
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:00:04.0108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkL9T4I481hufAD4x8Zp4FNEReiFsDJvV7dwNLRuQeMh31mLgPBKTPoZ4SyhiYBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.12.21 um 09:46 schrieb Leslie Shi:
> [Why]
> In amdgpu_driver_load_kms, when amdgpu_device_init returns error during driver modprobe, it
> will start the error handle path immediately and call into amdgpu_device_unmap_mmio as well
> to release mapped VRAM. However, in the following release callback, driver stills visits the
> unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

Mhm, interesting workaround but I'm not sure that's the right thing to do.

Question is why are we unmapping the MMIO space on driver load failure 
so early in the first place? I mean don't we need to clean up a bit?

If that's really the way to go then we should at least add a comment 
explaining why it's done that way.

Regards,
Christian.

>
> [How]
> Add drm_dev_unplug() before executing amdgpu_driver_unload_kms to prevent such crash.
> GPU initialization failure is somehow allowed, but a kernel crash in this case should never happen.
>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 651c7abfde03..7bf6aecdbb92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -268,6 +268,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		/* balance pm_runtime_get_sync in amdgpu_driver_unload_kms */
>   		if (adev->rmmio && adev->runpm)
>   			pm_runtime_put_noidle(dev->dev);
> +
> +		drm_dev_unplug(dev);
>   		amdgpu_driver_unload_kms(dev);
>   	}
>   

