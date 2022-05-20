Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 14:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E1510E7E8;
	Fri, 20 May 2022 14:22:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E719210E6AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0eM9QZKc+/Ni2mCiiEs5K05TLE1oR+qFjlTeRoq3dKOG/x6PvmuLIz7lECi+l65fbUeiEMpNAKwxaFiM4fWAwIlYs5068kNcZ09ybC6sQsn0KdjQjWcbAW7ltxoDkjo7VlGOYv4GreRU7P3ZchyEoKQ5HbJoPnn6XNm+sGqFqm6fk42RJnOcs95dn4alm4slbvgmnGAxgE/WlR/rBxL51HzUwxH72kdpx88wQ7aG5L13v8B/Ff2OU4lcj3VKH2CaEX/88WQhSm3i6M/HrxmLRGXtLxEvaQYDkamz5d6i6iF6C9QI9Gts5UvuOW8e4edk3mzuHZyDso/5F2boMkgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq2k1lOV79pNhrvj3w1rPAyj4h1k9xPyAJP/OTvLpfc=;
 b=ICPSBq+38mGljmk39ktCNj+cstrVRMY3iAkaedOmXz7epZ+ne1J5Rf9DTyYKa8KkWvtuaSg56prKprA+N5wFnU1i7tEINipGLQxg/6MpupXs4SxJaeUEW7Qf/qiJFHM+fEP0qlJCgOMu3bD7WkSouSC8F8lMuZdrhkNtV6MhB3WktZ9JpwQDl5FZzuATxe7nl0qNvEVl7bhwl8oaPg+MsUyHjlbUAyiAkhXc2NU3vfGFtB6hM8yCqmjsYeehKojglJsp/8PgwAgdSePYUmSC8WC5w/ZqFFAqzCAyXF65jIemDXcmdkJSRWVpO8KCpWR1PN0hGGXxFYYC3yZUAssQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq2k1lOV79pNhrvj3w1rPAyj4h1k9xPyAJP/OTvLpfc=;
 b=LBJH5e8x5IfwJbXZqwl7O32n088usniuz7IqOVH/WnygCFVXKBlJixFW8xcQGAvNvem2wz2vzrgNJ4GRZ7hPYAbnm8mDCZcC3Es1qf4+L0XwauYp319NXdETRT4lR6SL8DI90B7ujZo8K3q0x23YE+/dm8ZY6WnGunAmwVsBVd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 14:22:42 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Fri, 20 May 2022
 14:22:42 +0000
Message-ID: <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
Date: Fri, 20 May 2022 16:22:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:203:69::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168501a3-2367-4264-7ef4-08da3a6c338f
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB66089A9D1C3F829457C7613FF2D39@DS0PR12MB6608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWvBIEqb6Og9xatPat/qbjQANbqF8TVaO7X+7+VBtMiorCvFUKXINRmwPpx66yHECZz7KJZGDtnwYITonSihepqk6yIEQl+AnxnDkqMQqXavngpTiy2xXdz52tzyVJkh4+hiSfYOnwt1bzWtOlb0oNYO7FYT33VUMfGqML9EI0sYuYxsJzIq4fq1t5S8jsuxOY+kOYbyIy8LXvTbxebkkfknwZkbAIOTP/uOqBtoxOrbs49yOaMi/MpWHr2f8QzQ97ISxwwQSICB62X5cnn/2NS9DsukwTsTMWavAtM+LXrj9b73PZ0A84njUdh9lMduLnEpx2mAX/Z/H0+2LTVqIjTX6NS1DSjuryhpZtaKHTy3Oqy0OUKy/EdQJASL5VDa5jyDuRSDORHEjlAAxGRegTkmYo5MlQA3C9Wi+S+fdZg5XOJN7TE0HOoVQiu54PRYPdf+qWpkbDP5ZKL3wP5hxGS3VS9Ymg4mM1p0MCHi29IaM/uxiBGTuio0Sg2xl78GFSSP98xe2Olf8T8lwvDuKUAnhPew16XUErJHnnrHOFVjNH8SAeRU9aPtLIzG25M4HU4D6pHdVzhFO8c7nLjhLiy8YpHzT5HD5KRy7rAFVtzYFtt6pmqyvms32po0fIopkrucZ1mw/q2XHA8uO1RUOnGw+VfBSwTM6enyAtNcLNhrAr6aXXk+dvxmRHGIemaY/c/1gr+XEfWCbQc6WrYHYv2ZFiywi4Awy8wk2OStVc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(4326008)(5660300002)(31686004)(36756003)(8936002)(6486002)(66946007)(508600001)(2906002)(316002)(66556008)(66476007)(31696002)(186003)(53546011)(6512007)(2616005)(6666004)(6506007)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFRDenpzUk1Edk1NL0JFSjhKT3YyRkw5SUNXejFCVDVhWVM1TVZmWWlzRity?=
 =?utf-8?B?MENvYjNtV0xYT2VUUHFkZjVka0lNbUxEamRSZkVqemczL1o5c2RFNnoxak9K?=
 =?utf-8?B?Z1UzK3JvSlJwUjNIL2V0ZnpZT3ZCNU5xQUdibi96U3J5RXpibHpEQWhjbzVv?=
 =?utf-8?B?ZENTNGw5ZjdwajdMYnB4Q1hYOGVPdDc1MVFOYmZ2OXhQakM1WW52SkdEeThW?=
 =?utf-8?B?bEs4bW9pejFvaG9aRU9GTlFKZXZLeGlKWTZYL056UnFBOHlvSzVsc1I4NTYy?=
 =?utf-8?B?bmk2OHFjd3N2eGlBZDM3LzA1QmI5Z01pbmY3TlhPVld4VmlNb1lidHYzOThS?=
 =?utf-8?B?RnhFTWZBQzFubjFiNHh0ZlE1cGxvMkxQN3RyTE5UQU5RM1lDZHhCQTJGRHJQ?=
 =?utf-8?B?cXdxaFM4ZWw4WVVQRzlTT1pUTkl0b1Y4RWYra0ZRbnJzejVGR3hXQmo4bWE2?=
 =?utf-8?B?UGMwUjNEWlZhNHdIelVWaHJEaGdMMTY5YkROT3FWd1dkUHkzdnBuTVF3Y04z?=
 =?utf-8?B?cVVhVHlYTzBFY2h1MGEvcHBCL3oxOHpFNUlRcDZRQm41NlNBMGdjajRqbE9I?=
 =?utf-8?B?QlBxMStrVlNNRC84KzJRQTlXS0Y4a2VwVzVybGlPREpnakRpYXpOMXhCUi90?=
 =?utf-8?B?WnlmWWNYL3g0N2EyMW4zRE91RkpyQlJRNUswSmFTSVJvbmdCemttMnd1TGhZ?=
 =?utf-8?B?MFBQRnUvODk2bndOTzBoTjF3UURiRUhSVXhXSEJtM1NMeGdhejJleWk2U2p3?=
 =?utf-8?B?MkQ3d3BUd21WQ0JTdDB5RnNpQWdvNEROU3FKc2ZRelZrODlVREdNb2RaNHBL?=
 =?utf-8?B?RlRXcFVBSTFlRDJtamg0MloxR3l2RmlxUDgvM24zQ2xtTW1TMDIxNFlnekJo?=
 =?utf-8?B?aHVFeVMvZFdVdzQ5NDhITjRBMnlIeHVPbEVCSS9hR3F2TkpsYmppTzBWc2ov?=
 =?utf-8?B?OG9DQ0tJcE00OEg3bk45VU1OSmtIMWRpK1ROZTM0SDFZUkxKMkpGVndjODVC?=
 =?utf-8?B?Um5MVWRTaWlMeWpBY2xVK0pzMzRDTnZ2MU1QMUhEc3FsU1lzZ1JveVdnTkpU?=
 =?utf-8?B?c25QdWdtRWhIL21YY2lTdkJFbUg0RlMrRjVJZHJNVmE0Yy9nQnVxZmVkZmZn?=
 =?utf-8?B?VmlYa3NIWDhLSE9GWnBzUmU0Z0IydElyZk5LdUtwT2tCSCsvZmdFQkRYTkkw?=
 =?utf-8?B?aE43U09pMHJoeW5NbWF6SEFFUGlFRkZ5Z2ozRlpmRDJobkF2dk0yMWFqM1I2?=
 =?utf-8?B?QUxyN1MxWnhqVkxHSHpFSzFFUzRFMnppTjMwWmQyaEx1eXZOaHBMRGVjeGpk?=
 =?utf-8?B?UVltYzNuUE4raEZSbGtDek54QTJhMkhGakJURFlmTmlvTkVoa2lITCtwMlA4?=
 =?utf-8?B?Um5MRnNQZE93ZHh0UllPcUhUNGxnV2J1Z2svZXYrQzQ5NnB1LzJHZEQxWUJO?=
 =?utf-8?B?WHE4NlkrMXJSdWwxb1hhUTcyZDNZYkxPbVZNMTAxOWhYL2J5eVFmOEJSczBY?=
 =?utf-8?B?dGsvR3pKbkkvR29DQlFUbmdSYThTUWNLTFFnUE1kWlM2K29jS2plYW13Z0Fu?=
 =?utf-8?B?TW9RSWR4REtwSnQ1MW8yV2lRdFg3Nmd4anRvQnU0UDh1Q2wrV2pEYTN4RVhI?=
 =?utf-8?B?YzZSbjk3QVFOdzZ4Znp2Y084a3d5REVkMFNlRGF4OVBLWmVmcWZDaG8zNUta?=
 =?utf-8?B?T05lQW9CTyswTkJtcy9RN3Q0TkU3SVQ5c04vc3VNQjU0MThXK2FFdnVHVEY2?=
 =?utf-8?B?M0QzUjErelYwbFlza3lOTkozSUFaa1g0YTNXQlNwMzlzdGlVQ2V2TW5RUXU5?=
 =?utf-8?B?MmhmTlhXZis5UzRMbHhFakhvbEVFOEJyd0diTFk5Z1VkaW5IRENkb2NweDhu?=
 =?utf-8?B?L1BROW9JNFF1MGRXSkhpMmpkcEFFb2cxQVMvbXVCMHJpQVRNM0RSOTQrd3I4?=
 =?utf-8?B?VWpOK2dUQ2NjT2ZJRjhFNTkvVncyU295bVIzWGRRODd1TFliN3hmL2tCdk5D?=
 =?utf-8?B?NFlFNU1xMEFIVHRDdXJDdDEyd25ndnVJNTN6TTVWN2ZVZGlnTWVhOXJ2enRQ?=
 =?utf-8?B?TE5qdFlyVGxYUVU1WTAxdjhtUnNsTGpPamRDNkVBVGxxblVnQVUrcmZZK29o?=
 =?utf-8?B?cjBmcjBqUFNYRGpRd2p3NklOM1JrazVlVExzcFRMQzNTSE00cUxpaEZSUHFF?=
 =?utf-8?B?ODdiWWtUU1pmTzFYL0VSaHhPcnRaYUVyM3N4RFhKNjJUVHhtWC9uUFZ4dWZL?=
 =?utf-8?B?R21VUUd6OWpwMWpNbkZXL242aEtoMkN2UzRFazR3K1QzaUFBSjdFMmtnOHc3?=
 =?utf-8?B?OTBJSXZiR3RqeVBjeHBOeUw0OUE1a05XbWI5K0VYUkhMbDVaLzlIeTEySmVt?=
 =?utf-8?Q?DMhca33G9hYiuejzqAbMqmnOp+dAJX0PokTIWAUyypjXo?=
X-MS-Exchange-AntiSpam-MessageData-1: wggI/bjGYN4Lsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168501a3-2367-4264-7ef4-08da3a6c338f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 14:22:42.4767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWThjHWJN2pcovArgwwYrhZH61pT0SPiVYrI5looj1hpfIplalZL6vJHMfLlzBWAQjtLVBU/aYi+Aoxcb3oosA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
> Added device coredump information:
> - Kernel version
> - Module
> - Time
> - VRAM status
> - Guilty process name and PID
> - GPU register dumps
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 ++++++++++++++++++++++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c79d9992b113..f28d9c563f74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>   	uint32_t                        *reset_dump_reg_list;
>   	uint32_t			*reset_dump_reg_value;
>   	int                             num_regs;
> +	struct amdgpu_task_info         reset_context_task_info;
> +	bool                            reset_context_vram_lost;

How about drop the 'context' from name and just reset_task_info and 
reset_vram_lost ?

> +	struct timespec64               reset_time;
>   
>   	struct amdgpu_reset_domain	*reset_domain;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 963c897a76e6..f9b710e741a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -32,6 +32,8 @@
>   #include <linux/slab.h>
>   #include <linux/iommu.h>
>   #include <linux/pci.h>
> +#include <linux/devcoredump.h>
> +#include <generated/utsrelease.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_probe_helper.h>
> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_DEV_COREDUMP
> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> +		size_t count, void *data, size_t datalen)
> +{
> +	struct drm_printer p;
> +	struct amdgpu_device *adev = data;
> +	struct drm_print_iterator iter;
> +	int i;
> +

A NULL check for 'buffer' here could prevent a segfault later.

> +	iter.data = buffer;
> +	iter.offset = 0;
> +	iter.start = offset;
> +	iter.remain = count;
> +
> +	p = drm_coredump_printer(&iter);
> +
> +	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
> +	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> +	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> +	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
> +	if (adev->reset_context_task_info.pid)
> +		drm_printf(&p, "process_name: %s PID: %d\n",
> +							adev->reset_context_task_info.process_name,
> +							adev->reset_context_task_info.pid);
Please fix the alignment of print variables.

> +
> +	if (adev->reset_context_vram_lost)
> +		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +	if (adev->num_regs) {
> +		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
> +
> +		for (i = 0; i < adev->num_regs; i++)
> +			drm_printf(&p, "0x%08x: 0x%08x\n",
> +					adev->reset_dump_reg_list[i],
> +					adev->reset_dump_reg_value[i]);
> +	}
> +
> +	return count - iter.remain;
> +}
> +
> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +
> +	ktime_get_ts64(&adev->reset_time);
> +	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
> +			amdgpu_devcoredump_read, NULL);
instead of registering NULL as free function, I would prefer you to have 
a dummy no_op free function registered, which we can consume if 
something changes.
> +}
> +#endif
> +
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			 struct amdgpu_reset_context *reset_context)
>   {
> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					goto out;
>   
>   				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
> +#ifdef CONFIG_DEV_COREDUMP
> +				tmp_adev->reset_context_vram_lost = vram_lost;
> +				tmp_adev->reset_context_task_info.pid = 0;
why is the PID hardcoded to 0 ?
> +				if (reset_context->job && reset_context->job->vm)
> +					tmp_adev->reset_context_task_info =
> +						reset_context->job->vm->task_info;
> +				amdgpu_reset_capture_coredumpm(tmp_adev);
> +#endif
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
>  
- Shashank
  					amdgpu_inc_vram_lost(tmp_adev);
