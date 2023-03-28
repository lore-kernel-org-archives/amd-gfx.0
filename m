Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F912C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 13:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C7610E07B;
	Tue, 28 Mar 2023 13:17:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 820A710E07B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 13:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIuQLovGuUMz4rpF0drQdlDovbe3muAodS2xjPFsJtQYt6qT/oAk51tu3JunQGb8+LFFdHFYRUZeYdduvSsJQPezq1QVirBQW39fvut+u59numUmFonEY686BKZLs0wtfjLEcTT4gUeFKl4D0TSFIXROTZ98EIGhWlh8k+ECJfN9QtE/bQ3pIsvuLxDQAkkNyeXdxOB7UeBocL+TXljrErABuYZA6F9EHp3gTidOmPuO5XigYYAf4kOn2F1eKnk1uKDHLTT0VIW8W1c1g0vewKSoRqo4XmHzcHzxpDnm0jTIXhVjWTMi1IicGbUEUo8zTXwalHImHiKEfUebLXtWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls/xVimm1QjJj3n41AnxnIrjABg4Jn5R/zgZmHEzw/o=;
 b=mtidQxe/vn0S8EqE+uEcgqNms+lFKLJCt87pS4/RhCZIaB2IpSRNYX7JeMVbqYKYQIZbTu5js5yhzc+ChdN0WR/mZqs65Vx/AZD0/Z94/1uADh2ERvhkrdzlfqEASyXICUKEvOn0meZ0CdJBCO9Iz2lgLxMJjMMlEQLDjzNdyeigrpMyBdH2kS2U+Bao7AFelXSPXWRvWZ+dN1SweBH44/Xuy4PS0SMvlkXNx1Cmfv/C+kSIoy/lvlQBckkU+oC6jG4bqYnW5cyloWBitjDRahp7U2BHRSEwXvao/U1W5Kaj5at9YER75TqlXnXGznIgNelc1RU+nxKaxmoQoo8//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls/xVimm1QjJj3n41AnxnIrjABg4Jn5R/zgZmHEzw/o=;
 b=iv50D8SFYMSBUnNI4JRYZhkTaEhvghMvBaqIErdzgT1PdHdRUNn6zFLFazATdVG4ASHwKdTlHBzAZM+A9CVbEXSLwHaiwuaFKKPd/5M/dEy+1z/Rltb7Ye/W2F/ecx7qR7zMThSP5hG/60GYW7zyagzdrkQpkuWpOXcvNMIqnZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 13:17:21 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 13:17:21 +0000
Message-ID: <6bfcc0d2-eee1-0fac-0b47-51c674cec30a@amd.com>
Date: Tue, 28 Mar 2023 09:17:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some asics
Content-Language: en-CA
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230328114141.1154742-1-Tong.Liu01@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230328114141.1154742-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f0603494-58eb-499b-ed76-08db2f8ec364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O28S9N9tcRLOdtNPIXEFCtdAytpFWFpWJSkWk1/sjxSK5h03/2EIspNkYtupHlYJhT8NFTPru8gBdD/MOZlQgmXla9tewzF6XVF8nafoarPoZLes1+B94umq42QHsmPgBieWWFqTGMHdU9hUP6uIUoURxGG61zVHSSg6LjEk3yEpeOXnjXrHo8USdQcC3+E4z5dicQ1x8S6XAndST09cEOwhYgzme/lwC2KVlMaBeI2TzPS7v1A86XLqbDRERvLzcZdEyvpL2wEuFwaW2s7ODifgjqUbPF5lY3EupIMUnj0idyJNRlG2UwPGo1hCP3SIeWIlm2H8mF40AApPavwmSSrBCWDIj9/8++b/tqaWgH4O3lAe0qYqvkoLgI3ALkcpbbeRWad4z/OSEskjDWKcF6vcS+EMDBnM8hXukbPcdflRioV3+XyVFl6qljJRXKlq3i0Ak4bJuA/QP+1REQTAz+sNENxoc7j1+jwjZWa9c1N5eqMXCK8aQ+EtfV1woc7AVOIezkh/cXYi6yXoXFJaEBt9YqjDWc1Fpu9Ta1JVbu5dKWJPIcUIy+U+jfAccO+YhmT8UNcUqfHlMuT6ijDsIlPw+D7zp3/sW0d0RmvKnNXm+6JVzTi0gDvumVN54PuYISxPhzeZtXJNY9jzjzUBYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(36756003)(478600001)(186003)(54906003)(31686004)(38100700002)(316002)(53546011)(8676002)(55236004)(41300700001)(2906002)(6512007)(6506007)(8936002)(5660300002)(44832011)(26005)(83380400001)(66476007)(66946007)(4326008)(2616005)(66556008)(86362001)(31696002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhVd3ZEem4rT2VYVDdncXNjVC9nMDhvQ2ZpSUxQeExUMzgwL1NtRTBwVmhh?=
 =?utf-8?B?clpYci9CanhrdXdOTmJuT3MyNk0zc1VUZFpGcHR0NldDejlQWUNyaktkZjZJ?=
 =?utf-8?B?aHJOWUh0REVPbkVpRjRjbkJabHVzNS8xQkVFWElVK2xNdVdudHdLWkxaUndt?=
 =?utf-8?B?TkhORXZlNkd2dkZsaXVIUmhuSStsYTJUOXZUamZMZ1hJenlGQ3ZHbkdKOERY?=
 =?utf-8?B?ZElTUm5kemt1Y2hrdFBqSFliNVNZVWpvMnJuUHJrVUJjZ09CajkxMk44YmhD?=
 =?utf-8?B?dEV2Smdwa0VnNjJCanV3V0ZaQ3pVdUVhYm4vZmZ6MWdhOFRxOVA5L1FPanB4?=
 =?utf-8?B?MkdVenlCYUYxUlRobXZCZXR1WU11QnBUUENvS09MZWd4MjJaMTlCT0RSZVFp?=
 =?utf-8?B?clUzOHZJeUFFREkwYjRwN2FiODJyUjZxNThkbjNEOVVaeEFjWTdQOEw4bitF?=
 =?utf-8?B?Q2wyUGthOW94dTBOUjRHOVlkSGRnTjV5VkNRL1VDbVdZeHZLZnlNUFhMUk5H?=
 =?utf-8?B?UTIxUCsvK0hhSTFpcC96RUd1WDVkUlR0a0FjZWhpWUM4UDJuZUtKbjhVdUxT?=
 =?utf-8?B?ZkZiNHpVU0xWR2R2TVhmTjFxR2Uxb3B5TG9HdThQL29iaTNzdjBlV0E0VHdm?=
 =?utf-8?B?ZkZMT0FERkZMeTJpM1NIMVYyeVNMQTljdG91UDVQMm13ZHZGOGhaTGlaYnhk?=
 =?utf-8?B?clZEMXE5aDBIbWUybGVBR2cvQ0MrL2VXdmVVUWNydmNOSDVlRE5JWFZodzJC?=
 =?utf-8?B?bGp2RVU4NEdTMkFMMHBwVlp2WHVaMzg3d21tKzZCVVlHV09WaStZVFJlMm5L?=
 =?utf-8?B?Z3VGVTVMYUpYa081TVd2WjI5RUROTmFGeGlybGltYmEzalhRTDFibXR4Vmc2?=
 =?utf-8?B?VklHRUhyMnRMU1BtRi9DQkZpNEJlY21waXVERlM4a0FpUkhFSnpuOEFXbTBP?=
 =?utf-8?B?MEFqSU9rRW0rN0k5dm5yWTh6NStIbmxDSUdqOWxIVHR6TUhnVFc1dW9ZS1Nu?=
 =?utf-8?B?ZzhjZ3Z6OThZZzY0ajFtSWVYN0ZuTTgwNUZ3VDd5S3c0czFzS2U1b3ZCVnln?=
 =?utf-8?B?bjJvd3RmY3J3cWhpOXRuenpOVGU0VXUzaTR0TUVNclAwVWRFb2VtZ1J0ZnRD?=
 =?utf-8?B?STdrR2JoK0o4K2txaTAzUUFPMlFOUnJxOFFwYysyRGp6cEdxV2JkSjkxMnBI?=
 =?utf-8?B?Ui93U0Y5TGtNWVM1VHAzSS9nOHNEWlVCa1pWNDRXN3NJUklVbE51QTlFL20r?=
 =?utf-8?B?ckM1WVBQbEpDcnEyc29RUmpoQVV3RXpWdWlZcStnbkJLZlZkNXN6RnA4Ri9R?=
 =?utf-8?B?bUo2U3QvYUF5RjRoNVYxSEt6NWtRV2t2bUJKZzV1SUl1K1U5a2NqV3RDMzZ3?=
 =?utf-8?B?ODhySG9EQldzNk5xMU1ZMlJmYWVkczJnaHVtS1hQTERYS0F0Lzd4SnJwYWVm?=
 =?utf-8?B?NHRVU0RjbWpFdkh0aXBXRVpYT3NhOGsrc0hHTS9FZjY3a3dxSzl0dzY4UFZT?=
 =?utf-8?B?UEtYZ3U3a1UyazVzMkxtSFFQSzBBRGR5SERRRVh5OFQ0UXZ6NXhyWlQrV2Qr?=
 =?utf-8?B?Nk1YeXZzOGZDT0hCNWNUS3dIRXoyYXI3VjZZU0xtNzNnVFQzQ3lBL09ZdDhY?=
 =?utf-8?B?OU04NGNNZEVCcFJxTmtSMmN1ZlZ0SXBlNk1XVHR5bCs5U1pZaHY4M2docXBV?=
 =?utf-8?B?d0xHbERvK3FwOUxhbGdvWG5CcGQvNjNBbGZhcVE1d3BwRDBLMURITGRiNVU2?=
 =?utf-8?B?VEJWREpxczAzT3VOdzFrTFZLWjlIWk92aFpsb1RTODVCNEp6VjdhdW1aU3ZL?=
 =?utf-8?B?WGpUM3pQMjFJajFJTk9rNTlSV1F5akJMTUlPbVp0cFhaNCtuVVpNZWN3WS8x?=
 =?utf-8?B?QWNvZFEyanpvTitwUDNTNVlQNmtaZHhLTjRzclI2WVQ4aGVhbVE0eXpUTUFs?=
 =?utf-8?B?d0dIYzNqYXlPZG1zZFkwamhFNXgrOVFpVThEUnZDalViZEhSalRpSzJOcDVP?=
 =?utf-8?B?cEk3OVZEUjBLNWFGZDRuZjZYRzBmenNUTlUvdXFMS1ozNTB3NlB2cWhSdUNr?=
 =?utf-8?B?WGVRMVVHVU8rTHkxVW9aMmtQS0xIcitHRERKc2NpVTdxMWpiRU1ycksxeDBB?=
 =?utf-8?Q?bqeJhGUAS0n4rt2u808/oBPkd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0603494-58eb-499b-ed76-08db2f8ec364
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:17:21.5354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi7wCT3H7OlGhkxF/FgZJa/zLg73pQ3DKNd25ARXa2yKLbel5DektxYeHUvnLYWg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good--thanks!

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-03-28 07:41, Tong Liu01 wrote:
> Add sysfs node pp_dpm_vclk1 for gc11.0.3
> 
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 22 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 86b6b0c9fb02..fe75497eeeab 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -104,6 +104,7 @@ enum pp_clock_type {
>  	PP_FCLK,
>  	PP_DCEFCLK,
>  	PP_VCLK,
> +	PP_VCLK1,
>  	PP_DCLK,
>  	OD_SCLK,
>  	OD_MCLK,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d75a67cfe523..1da6e9469450 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1180,6 +1180,21 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);
>  }
>  
> +static ssize_t amdgpu_get_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK1, buf);
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK1, buf, count);
> +}
> +
>  static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -2002,6 +2017,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -2091,6 +2107,12 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  		      gc_ver == IP_VERSION(11, 0, 2) ||
>  		      gc_ver == IP_VERSION(11, 0, 3)))
>  			*states = ATTR_STATE_UNSUPPORTED;
> +	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
> +		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
> +		       gc_ver == IP_VERSION(10, 3, 0) ||
> +			   gc_ver == IP_VERSION(11, 0, 2) ||
> +			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
> +			*states = ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>  		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>  		      gc_ver == IP_VERSION(10, 3, 0) ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..bffbef3f666d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2006,6 +2006,8 @@ static int smu_force_ppclk_levels(void *handle,
>  		clk_type = SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type = SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type = SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type = SMU_DCLK; break;
>  	case OD_SCLK:
> @@ -2393,6 +2395,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
>  		clk_type = SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type = SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type = SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type = SMU_DCLK; break;
>  	case OD_SCLK:

