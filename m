Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C091C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 15:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F25C10E886;
	Tue, 22 Feb 2022 15:38:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF2D10E886
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 15:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOfYcna7XcXPNRJN8T9DegmYo4qfqbrD5Dp9RU2DNnY5ov/O+FVOZkSOc5Nt6zJUSLbLF0QCT4Zu1RlaKi+aVMkBRanaMtK2EIAkTI0noaFKn9gavauadsQB/i5HtZb19Uf7xn+cG8qVeDHm9wzTy+MJCK8SeoQ6xyX09DuW7EzGL8RPelHkRpeb/yGkCPcIqwRKYLcEbn4XZT5Nz0PXyk/NJr/it637v4kd5BxvvW4vC2aAUaVf18j1EQz3W9odylW6NOsqzTES2HT5rmVFdpEMQtXQ/EUTKspe/8WqhFZQ7f9pIzBUR2eJhR/J9AoZ5uvd9EJExc48C+r/FTK7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KqYZPrEZtJWJEQ951zjKwCqBx/juCwaSub3OJdDL8o=;
 b=Ed1R8Hg4GlnpWFSzpQPYMGrTGhopsrClUGARhLddo9CDp0fF4hB3aiikfMTwSS7NXHe5g5HsJJvuifWx5H+w6+K7DHTFfkgTrFu72LDyqErxmAQDK2DhJdALzA/CkuEb8EmbL3aiX87nwTH7zuyAIf6Zy2TLIfh8L/WR9ljVDhyPT2BPjDQ6Q8Cqjvwmg+otXarwoZjCck0ttHIwdcmlZLG5tqJJPqbUUFo9YK/bv9tNRNqHllJFvj1n0H7aoTSzhUd+nnFvqIRWLtMTLbNCMFEyuzxDuCX8UqfrnTVw3wiBep3dnQQPRfdBk1VD+f8T9kgiww8VPP38ZCTAL1jWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KqYZPrEZtJWJEQ951zjKwCqBx/juCwaSub3OJdDL8o=;
 b=PEYp+lZzogGSh7mvS6PBcJTfZKa2MKmsMuVcY9YZf+eQPs+Dy9hkvQZeeQP7HtB7OQ96hjm4dU7P4/CXzby1NFAA1CiK6LYG7ftfDYbRF2WhBmpdB/5UnIeaRRgHUM0jposKIZnMpZKMuAd8Y9ShNWkQVE1wZKyZb7+X/xzga4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR1201MB0010.namprd12.prod.outlook.com (2603:10b6:3:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 15:38:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 15:38:33 +0000
Message-ID: <4fbd2956-c3f1-182d-fa4d-84206771bb30@amd.com>
Date: Tue, 22 Feb 2022 16:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v12 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220222153433.11464-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220222153433.11464-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0040.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbea9aed-eca8-44b3-e295-08d9f61961d4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0010:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0010249FFEBBBA6D74B5F384833B9@DM5PR1201MB0010.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CluDjd/1GTN8gy7DhxFQXgFr2PmAfTNyrfRKvqhoFQm0gPGja0MYLX3ZDhx53g0XVz93BB4UPgRuWPDmYKaQEfIzxpJj+mN0WtTNLvLMmkb16tNMJ0w3HxZyAfuvtMJkZqnFs7x3WNLRrDh5Me0v3wbX0yV1GF9UJndOQ4iqVTo5fml8VrPgWD1g1Ha9DCu90IEZl6sWnOEqX8YmFoD5SJ2rey9E27FKyJsQslHbRqQDdSiTD76QvfvLl37tyMfb2RJL18TNXwWotZ8+2V3tZkgs5ecUE0gmkyBWVciVVlSh/D7JQJS5L3QrVY7dSYQKe7sJboMpbZDwrxlTJNCRZ0N9u1UbHrkXiijJXbqVRN63mf/87MFoVkb8v5xtfSG9WRcvA3g1/LYmp+9tddrksLIZChFCMSbWSzXUe//36FP60+FLV+n/kf9Y9KJyHYCIbsER6OT2xcBqISAgX0hQySZ2zKMR0hy3WeZh/pj6Z3oE8GHkjIO7bCMt+yr+AJPvww4E2f3072XvOE/O/EEr67vYY2EDbSDKfITSSJYMwegegBNlBhKdX+efwKRrvyoQecf3uqIjpTqFnffDOmlof2cxV58tnV4kUc6yY7H6HSm7JWvkS+vB/MXNjXZmhIGGI0NyHx4ugnNI57Han/5vi+xnUJf1+sF2A5dHsQLw4NwLYOorRh6MX6I1Dvdg+Y86v1KpPRnEinbfQY3e2ozmDM+67wCZCKBVv0V5boq7bfpPXU8xhMV1cU6xqkjPfC+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(6666004)(31686004)(8936002)(36756003)(6506007)(6486002)(2616005)(8676002)(4326008)(66476007)(66556008)(38100700002)(6512007)(508600001)(31696002)(86362001)(186003)(66946007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJJZVFJeTZaT0NTM0JjN0RVQVdnWjM3b0ZQZUtBRFIxZVB4UVVFVmRUby9M?=
 =?utf-8?B?UXdLUEVZa2lKVE43ZkNnbHNOVHRKQmV0Y0UyUUtGNEhYVkRNT2J6OExWMmhR?=
 =?utf-8?B?ZmxHM3k5c3UzQkZNQm1VcmJrdWdxZ3czV2dzSnlBcWZDZi82NVV0NmhFSkJX?=
 =?utf-8?B?Z1J4dDVQdXYxa3JGRXpQTnAzK0lnK3RoeE04SnpmalpvTlZjL3ZkbXRxZ29N?=
 =?utf-8?B?RTRYYTVKMS9XeGlGaE9HbU50QjVWTGw1NVVoYnkxdFdkQkFPNHp5VzlTeThI?=
 =?utf-8?B?Q2hYN1pXcVBrZVBnV09XU25rWlNVV3ZwOFlvYTdsaTBoNnFDNUwyRk05M1dQ?=
 =?utf-8?B?NHhNOHhLekFCdk0ySUo5WXRZdnZaUkVXRWVWOEVkaVpMVysyYWhFaXd4Q09U?=
 =?utf-8?B?akl6dVBvNkxkcnFPTHZTQnpuWjF6RklYaXIrNTE3Q2dMbWhEOTBJZWJHNWI0?=
 =?utf-8?B?ZW5TamR1OWFNSkVaNG9kUXl3YTRINXhYN1AvK2NZd1RGN0RwNG0wRnczT3g0?=
 =?utf-8?B?bVFCVXNtOTF6dlNXT1ZGdmNsMjhzMVdNblI4cDNhakVuNVBIU3o4dnBibjh0?=
 =?utf-8?B?WU4rSnRncGFmS25XRFR0dHlVZjQzTVZxZnRLZmxPcThmMGRIWEo3NmtOQkFs?=
 =?utf-8?B?Snhua2MyNHdCVVBXMGxyQnBiSklydWJsZWhGdTZMSWlMUGZEaDlicEc4cHdh?=
 =?utf-8?B?UHBlZjJVTUk5K24rRWNqZG4vUjEvVlNMcDdiTDhrV2kraDVDS1RxTFpJNmtF?=
 =?utf-8?B?aEZIbk80dVlYMmFlK3Jra09qSkZPRXFrQkR5STI2Z3NSaFN6Z29JZXdIZEJy?=
 =?utf-8?B?Um5IYkZtYVN4eGtBZTNYYWh1ZDhGbURucmNKcWFTeHJvTC8yUkFLam9HNW1Y?=
 =?utf-8?B?RkpveUtIUGtrN3JzdVBJQlZjSnZlYXJZTEhsRjE5aVBIcHRZU0E2UEdoR3Va?=
 =?utf-8?B?bUd2bEdwRk8xaWlvRlFvY0N3WWlqUHdsYklDUFh1STZBUTBQYm5udjhOQjZZ?=
 =?utf-8?B?RGxTSU9mcUwraVJBMGdoUU1xK3g0KzZxL0g1cU1UdEhhZjdJdGNubjhUUWpR?=
 =?utf-8?B?M3lONDhLaEEyQ1BUeDJqMGRIYXhMUXZWenhJVk5Ba2xjQVg2UnhROVUrTlRO?=
 =?utf-8?B?cnBib1B2L0kyV0xtT2VQcUx5VDkvNGxUcTZZUHJaZC9OQ1c0c1FOSG5uZ3NT?=
 =?utf-8?B?YURyOHNicDBJUWVLRUN1OXFOQmxUYzAwV1NHQVU1NUlUaTlhVjF4Umg4blYw?=
 =?utf-8?B?ZzhQcVBML2Y5VGlINlhJSHpmVnNKNWFPMGFVSitsVGVQMFZ1bDdNOTBRcUNm?=
 =?utf-8?B?bm9Ba0g5SC8wS2xlMVVCNTNqbmNXdGsyT0VUYURmRGs0czRTT0R1YjNFWDd2?=
 =?utf-8?B?d0UyeUxDcmRqcVhUUGp4dTRqN0lYcnZjOUN0VEZRWWY5bDdpYnNXRzJoTnJN?=
 =?utf-8?B?aVVrbHRIMTZodndoUzdhSklYQ3Jvd2JXM1ZTQk13UldYTW9maTNMQWNrMUt1?=
 =?utf-8?B?c2lVV1VnaDBMZVNOdFlWYnFidjFaUXJENEFwWk1yTWVSTGhSaXNtaUVhNW12?=
 =?utf-8?B?TXpxZUdTaE5rR3VCUHl3WE9ncDF2SU5EVXdnTUowWjZpTUgvNlRZRnpBRVY3?=
 =?utf-8?B?dFU4aFgrL2ZyOGsra2pocHQxMFNZdDk4Z0hRcXJyRytXbDVDa01hZy9mRHJB?=
 =?utf-8?B?dUtmUmZaamgrSnJSVCsvM2J0ckt5dmxlL0tyZ2ljOXNIa216NjhLcE5Mek9m?=
 =?utf-8?B?LzdPNW1hY1ZNM3VwOUw4NXlSQmNEVFBWWmI0dWUwSjlNOXdUQ3UzemJiOVJu?=
 =?utf-8?B?TG9jSm1lWTFYbGRyVExzbmNDQjZaU09aOWJXcWZuaEJ3TDloeUhhMmxOYXgr?=
 =?utf-8?B?ejVRa3VvUHhuVVdyeWtUU3ZjaG1zMUxGanpydER5aUlsL1IyZWFzNGl5RjR6?=
 =?utf-8?B?N0dCZDRodzgxOVQ3NExDSUV2TlNaSWxabVRSUVpPR0dMWGM3b3d2d3dFVU1z?=
 =?utf-8?B?aDZQOVBSckNJb2RDQ1BNT3lSV2YwazlpL2Q3dWJrdGxhWTlpdjRsT1dCcE8y?=
 =?utf-8?B?VkUzTDVKbGZ3OEtwZHlnVHYrOU03dmMvMVFDYm1nTzVWakp5T0lENXdQOXlo?=
 =?utf-8?B?NllPMHEzZG5aSjlTV1l1eGNlWGNtTjJQU0pONHZYUXducmxOQ1N1eTM4U1hY?=
 =?utf-8?Q?oL7QnwK/SXJjWQWn4MvD5iI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea9aed-eca8-44b3-e295-08d9f61961d4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:38:32.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WmUGB0+XXmoPeJWctJTAM1O9VdFfxWL1i9L1WMgT8j3R0rJ9CHkIUj6My1/zZAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0010
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.02.22 um 16:34 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 83 +++++++++++++++++++++
>   2 files changed, 87 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..6e35f2c4c869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             num_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..0cc80aa1b5ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,87 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	int i, ret, len = 0;
> +
> +	if (*pos)
> +		return 0;
> +
> +	ret = down_read_killable(&adev->reset_sem);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
> +		up_read(&adev->reset_sem);
> +		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +		if (ret)
> +			return -EFAULT;
> +
> +		len += strlen(reg_offset);
> +		ret = down_read_killable(&adev->reset_sem);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	up_read(&adev->reset_sem);
> +	if (ret)
> +		return ret;

That if and return now looks superfluous.

> +
> +	*pos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[12];
> +	uint32_t *tmp;
> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		memset(reg_offset, 0, 12);
> +		if (copy_from_user(reg_offset, buf + len,
> +					min(11, ((int)size-len)))) {
> +			ret = -EFAULT;
> +			goto error_free;
> +		}
> +
> +		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> +		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1)

Does this also work when we write the registers separated with newlines 
into the debugfs file?

Regards,
Christian.

> +			goto error_free;
> +
> +		len += ret;
> +		i++;
> +	} while (len < size);
> +
> +	ret = down_write_killable(&adev->reset_sem);
> +	if (ret)
> +		goto error_free;
> +
> +	swap(adev->reset_dump_reg_list, tmp);
> +	adev->num_regs = i;
> +	up_write(&adev->reset_sem);
> +	ret = size;
> +
> +error_free:
> +	kfree(tmp);
> +	return ret;
> +}
> +
> +static const struct file_operations amdgpu_reset_dump_register_list = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_reset_dump_register_list_read,
> +	.write = amdgpu_reset_dump_register_list_write,
> +	.llseek = default_llseek
> +};
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1672,6 +1753,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

