Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C22C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 05:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E43110EAC9;
	Thu, 10 Mar 2022 05:18:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F111A10EAC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 05:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuV9+v2MWPqtZg54AG5KVWEbjSEbFBDDh5uzCSjM+1ygBJVKsaVeMTQUP/4BSednNp5VRmh6VFJlrOWJZgWu30oYwFFMotWXGsg16QmIy+ALjBCVE2ZO5HavGPd6j7v/cpGtcRG2KlqTLW0Tq5+rhHJkmBvzD4U26DbGB5dXsGBaoO3GcFvcqfyoy9KJ7VE/C3pvv/PeLuw+l9+318sRZ7W9zaQ6XjzXdiif0hysmA+ScRMBbbbbkOCIkAAH0zrf8ovr3eh9kYqt4f2CxrcuoBLaWz5f1TeIPrwEXrlp0lEVwziM2edg7YiOslolrmdX7nKAzUghr9ubXtn3SrkoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d4VFOvU3itxQizi/WqH0mrYHhuJOq1/Ey2QEUMDSqg=;
 b=RVDswfRyPn1pl9BLim1joXA8tuB016cLAHnML/D/rAI3aUeTxusDstzqxb9v3aMIDRI0GX89aPomC3r9J77KRzbErfm/ci3h6qDCyLxNcsjNjHKzjwfK6q8qaB3Z5pP3U4Ht9FFx29B4Ar4w8aoGfuwXgkvsksUAcIuTeZWSim38lwhdKIe9M6dGMA8OkzH00v3rDGHNNWs+SNQ5irKhRxverTDE2W7Rlyuz6JgRNHLjbSkxLVb57fdKmQ9fyCNuBRfzpLjFuWqyWKoCqOCaDpZe1v57VJTdsyeq+O2vkf7StmML0k6WQFCPC00i9DFZh/ZysKQLT6Q94FgAeYaSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d4VFOvU3itxQizi/WqH0mrYHhuJOq1/Ey2QEUMDSqg=;
 b=r9YkKZVm05AHtsgmYlp45/UFvkal1Yud0CjV/5DBMv7sXqED5fKshSjONzZhfRk57SkxKqByFPRPpVNm9C6sDeOUBm3JOeELhf9yMuq0ZaZaIPDv/JTdtQb959MISyLbCbHIahDS5nXqyE9YsCfmNEZfLsCr/i4yCNOJ2aVJ1y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 05:17:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 05:17:58 +0000
Message-ID: <6136f957-a029-3984-4967-7077a18eedb0@amd.com>
Date: Thu, 10 Mar 2022 10:47:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] drm/amd/pm: Add STB dump function.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220309210330.576809-1-andrey.grodzovsky@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220309210330.576809-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f97f287-6996-4272-581c-08da0255569d
X-MS-TrafficTypeDiagnostic: DM4PR12MB6009:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6009BA76989B21721A99A3C9970B9@DM4PR12MB6009.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Vr3RGr2Z0/iFA2qtW1qPvjWV/un6oPpPueKtiNibSA1IVCE0o+/CIfoFAwda8pECK2lK7PdfACrpkxUACWYzjD7Vbdf1aUeckxp7ZUVLC6cdMHWRlgVVXUaFl7Lj7L4qOOr2yu6Q9jel59PSatZKmXagysJ2dRQ1bU+oWWyW1cOSTgiVPi2DMYcj3fnuMitjSbkFddNlZDOuGcr0zWyr9bvFdY0RKmPDVFQi29AHWM77Be09P4AF+NahQUF+5efVKLEidxAVi90eEQP6fUKQ4upjalpEVGOYhColkl0VzlbetBH/UZelWmQN1Q4ow9TCT55BzpGUMfjWe2RNcZUmL+098G7t9ty9F+UktCjiLhDL6iLslHgyop71CD+k6kNtJFjQ/P6FUI7XSSrfTmWVYoxczn8wlulxZ0SUIOSAob6Qdc1ePXdDLRxhCd0yRy8GETdgpKaRDhINrdZjMNGiIE195IfDT1FOJrxm5aap547Jl7A4DAhMlTAXufKfC6OTExtv82+m4WD9cGYBK6Ap7Jqb8lNOhgNudW1dmBoPxdKC3vx1rv3+iR47IUjSBDVZ74ODE1wnkhkr3VDeFh+KBcyNcOl6jlAPeXz3v2CLlhbBIFue5XlPsAWLFJi2iyzO7BfJIm6tDGcGShW/Q9IXmwcBzVfLKHFd+JH/RAuAQ9us76y8d5ZfKbA8egddMtgdbXbvzfq/2qKV9rQp0trRjSaEggXX3PyS3SXJFH4kIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6486002)(31686004)(508600001)(8936002)(6506007)(6512007)(6666004)(316002)(2906002)(31696002)(66946007)(66556008)(2616005)(26005)(186003)(5660300002)(38100700002)(66476007)(53546011)(36756003)(86362001)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FwdEJKOFJtU0hJSDhFNzZ4aVFLcnhGaHBvS2Y5Z3hRUTFQUzdsQXJFSkVK?=
 =?utf-8?B?RXBwbS94TXRGVVFGeWFCR0FuaXVGL0x3UTJDbzZtMnFZTDQ2NGxBQ1VaR21x?=
 =?utf-8?B?dFl4bVVYanVtT3l6RVBVbFJuUjR6MHpibXcwWXVCVjZKQjZhSkFWS1EvRUNl?=
 =?utf-8?B?UFBxUmoyUEZ4Nk56ZFpQenRWY1RubHdBK0s1RGxPUVh1VzhJVXJ4VzhlZU0r?=
 =?utf-8?B?OGw3ME5qcVZ2cWZ2NzNUWlJKMHBMbXZJMlBKV0lHVVcxdlZRN0VyRGNSV3RY?=
 =?utf-8?B?Q1FtVGNCemJIcDdJS2l6YVozSURRRDJvcU1GckQyVVZ2cmt2U1Z4WVRZK0dt?=
 =?utf-8?B?RWszZUJYZnl2ZVMwWjlQNUdlMCtKRnNhTlg4Sytma1NaVkZBVzkxVFNuTWxM?=
 =?utf-8?B?UnhGbkpCdWZScStCM014czRJSWlVL2hRSWEwUGZURzYyR1owNzBJSmZSc21z?=
 =?utf-8?B?czlLek8zb1RRUEUxWmY4OUhVMWc3Y0Z1eVVZbXZpZm1KcXZ5ZWdVVDVFVWFB?=
 =?utf-8?B?U3ZZbEVqWU4xM3huUDFsVm9QQ0FqS1V6blAyUysyWHVxSmJaMXp5RGRHKzZS?=
 =?utf-8?B?bVdnTkE2MEZ0dFRIbWIvWEdTZ3Jub0djc1ljZmFBVG1nQyt3bGIvQ2JSWkY3?=
 =?utf-8?B?c3pEUFZKOGpPY1F6M042cjlRN0FURlFMaUFlK2FKcm83enRkeWttcXB4amNY?=
 =?utf-8?B?elBOeDR4NGpKZFZLSWQ3bjBZUWtLVzh6Ulg5VnlJdmcxdlhTc1lDakJRWVBL?=
 =?utf-8?B?L1pxVkNVcGNrVTZMcVNIdlVrV3UxYTVMejZoRG5BczRvUXRMMVM4UHdCU2p1?=
 =?utf-8?B?VnpOSEI4bUk5VnFRVlRYTGhKbFQvZlJlMGdBSm1TQkd6a2l5U3NQZlVmUVdm?=
 =?utf-8?B?OXRBdEpJNm0xTmRhNTk4ejM3UzVHVXZMSTVMcmphUjRJc0ZSc1A4OTJEUkFm?=
 =?utf-8?B?dkRyciszRFFFSHk5ZlV6aUFjZys1TEJhOGJBc2RqWitvYksvcmpLMG5uWUNt?=
 =?utf-8?B?WFNHNXBFNzJHeVdxczQyalo3NDZod0ZzcHY4aUlRNmNmcGlaeTl2NllYeVFo?=
 =?utf-8?B?cTBuNS9ReTZWMFdyVTl3Z0lpaHhsai9PSGFxVzhybVc2ZFZlOTJzV0UrMTZw?=
 =?utf-8?B?QnRvZVdOMXE2aEU2a1lEbTEvYXhFM3R1QlJEejFEU0E2cW5nZ3FUTWYxQkZx?=
 =?utf-8?B?UVFwV1Y0MWRMckRWSjJhR29mRW11Q1Z4aVpIZ3pPUXgzWDVJM1FZa2s0SXZl?=
 =?utf-8?B?bDBxSmkwdFhrdHl3QjNMd0YrQjljMmx2c3NKUk1uUFZuZmNkNi9MU1RCL2JC?=
 =?utf-8?B?b2lQaWNuYUxKM09naktNVXBheGFGS0RtR3N4MHlhWUt0V1UreTBKeTRzM0hm?=
 =?utf-8?B?d09CaVZOWFVhaXhMN2VBS1g0TEdpMHdTOGRWd0kwSG5mSTBITm5ITjdRcTNq?=
 =?utf-8?B?MUdCRnEwZ2pMVWhnbjhrR1RhNk5XM01GUXFkOHFuRXVLd0hhaTErd2ppODZD?=
 =?utf-8?B?bEpSb1pvV0NZNzN6c1NsVXlQL1E3NDZpblBJWGpLM2l5QUQ2Z25RaVhQR0tt?=
 =?utf-8?B?ZXpTVHRHQWg2NG1vWlhnYTJEcUhCTndWUnAraUsweWFtOXFIbXg1ZndCZFJ1?=
 =?utf-8?B?ZUVvMkFlbGdQWjY0dXhKbXkzbU1oaU9aTHhpUkY2QTV6UXFGSkl4NmxYQjgz?=
 =?utf-8?B?NXJWOFduajdEWnUvaDlnVTNXb29BdXhmdzRDODNXTWl3R3paVndzYkpwME5D?=
 =?utf-8?B?NjJNQWF5S3RUWWM0aEZsOWorVGxiRm9BandFeWIzemZjdGh5aEJxUnBoZVpD?=
 =?utf-8?B?R0JzNWpqL1I3NVhkLzEvWlVLOXMwdnUvZzNjemhScVV2Q3JvZVRuNTlPVUdV?=
 =?utf-8?B?Yk1DeW51eFc5ZlYxY3dGaU9KT0tWUTdkRlluNzdjNU5jdS83bTFqTWNWeEZ3?=
 =?utf-8?B?SUV1dXFwSHVhMEFGbDFLTTkzeXFzZ3Y4M3ZlWDdGUzR6VXZhSWkvdG02NWY1?=
 =?utf-8?B?SFdOaXpBMnlRYmZoeE5WaTg2cXBPcWdONno3QVh6WDRpOGNxQWttZ0VGbkl2?=
 =?utf-8?B?bnZYS0cyMWhheVpRdXJ3TGxybUVHMkxIaU1SbWg1T00xLzZmRWlWakpIRmZ6?=
 =?utf-8?Q?sPk0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f97f287-6996-4272-581c-08da0255569d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 05:17:58.1067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a5ukhZj46z16CGlN/BOvHidMB6bJMFuTi35CbkWoRQBXVoR9jd/Xzn7UmeeAOqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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
Cc: Alexander.Deucher@amd.com, Amaranath.Somalapuram@amd.com,
 Christian.Koenig@amd.com, Shashank.Sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/10/2022 2:33 AM, Andrey Grodzovsky wrote:
> It will be used during GPU reset.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 10 +++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
>   4 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 1d63f1e8884c..815a6367d834 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1327,6 +1327,16 @@ void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
>   	amdgpu_smu_stb_debug_fs_init(adev);
>   }
>   
> +void amdgpu_dpm_stb_dump(struct amdgpu_device *adev)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +
> +	if (!is_support_sw_smu(adev))
> +		return;
> +
> +	smu_stb_dump(smu);
> +}
> +
>   int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
>   					    const struct amd_pp_display_configuration *input)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index ddfa55b59d02..99351d463a72 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -503,6 +503,7 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   			    size_t size);
>   int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
>   void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
> +void amdgpu_dpm_stb_dump(struct amdgpu_device *adev);
>   int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
>   					    const struct amd_pp_display_configuration *input);
>   int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
> @@ -540,4 +541,6 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>   						  unsigned int *num_states);
>   int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>   				   struct dpm_clocks *clock_table);
> +
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 7e79a67bb8ef..aff0ed9b6f9a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2958,6 +2958,32 @@ int smu_stb_collect_info(struct smu_context *smu, void *buf, uint32_t size)
>   	return smu->ppt_funcs->stb_collect_info(smu, buf, size);
>   }
>   
> +void smu_stb_dump(struct smu_context *smu)
> +{
> +	unsigned char *buf;
> +
> +	/* STB is disabled */
> +	if (!drm_debug_enabled(DRM_UT_DRIVER) || !smu->stb_context.enabled)
> +		return;
> +
> +	buf = kvmalloc_array(smu->stb_context.stb_buf_size, sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	if (smu_stb_collect_info(smu, buf, smu->stb_context.stb_buf_size))
> +		goto out;
> +
> +	DRM_DEV_DEBUG_DRIVER(smu->adev->dev, "START PRINT STB DUMP");
> +	print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
> +		       4, 4, buf, smu->stb_context.stb_buf_size, false);

Printing to kernel log with each reset doesn't look great. It makes it 
difficult to associate this with a corresponding register dump. Instead, 
it is better to have a buffer accepted from user through debugfs and 
copy the data there for each reset. The app may keep the reset data for 
a particular reset together at one place.

Thanks,
Lijo

> +	DRM_DEV_DEBUG_DRIVER(smu->adev->dev, "END PRINT STB DUMP");
> +
> +	return;
> +
> +out:
> +	kvfree(buf);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static int smu_stb_debugfs_open(struct inode *inode, struct file *filp)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fbef3ab8d487..991586f61a85 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1426,6 +1426,8 @@ int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   		       uint64_t event_arg);
>   int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>   int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
> +void smu_stb_dump(struct smu_context *smu);
> +
>   void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>   int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>   #endif
> 
