Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F59FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 15:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D7E10E8F9;
	Thu, 10 Mar 2022 15:16:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8119D10E8F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 15:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbEwOGVqWhHxmSQ7G+3AZgzTs3UBMzyKUZHlYpcKfNcoZKbKr7iB9CDR3LSscoGYdLI2oOmR4OcqaMVGWbHaVBRx4k9nltoavXVjJWEkXuDHAkTZwSBAOFDmrS2bvvBFNe4bZUOXGoWB0bcQU/xVGyT6plN3+cLQyh5Eir+yQUeJgLymejNJwvlJZBZmyX3xv01ztoEabOTHARh5g59ixxxhmlcPqiXGRBZ50DaaGp7vT+WhEPXXkMQNJI5nHm7UaLoqWIAv/qTVHkcHRkp4wKECcK0gpyDor1fptPzPARpN6jg7FPMcEZAXbeJYEazhV0FAjkarx1y8E9v1Hqd6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILgm2Q3K8E1UeKWOI9aVVWk9oZEit5jKOfwmq7374kY=;
 b=IfuokWZqHWSEottxcq8IU8PDcCNcaYTxrk01m5Jlg6agtPYSLGkS6H+3o9YDeEW45mPWFAudtsCkx5DoXjO5O6MZtyIh2lH4Dhap+uTBYVWofjtMXhZyQ4w4LpCATGnytz7vtEHtBXKldm9/NIsYpqcigVNSlK+aj1MrGVFpUwFI3UwKkTCt7tGjsxZFBN+ndVM9QwB8TwUwigt70aGs1PnlEHfKCV17c973M4xhtVINldx+F5sQ/uFVWpk4j+yQWbBw9vCUDgzlKiCnF6l5fyMsXzC1aiqJPGUyZxNQ+bU2YmInaTzMZqprJ4hxA7DnWAO7SQlkUdRx4/Kp8nQHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILgm2Q3K8E1UeKWOI9aVVWk9oZEit5jKOfwmq7374kY=;
 b=eYiySyxozJna4dYpyqYxIC6btOM/1MZWyUqLcF86E8y/Lg+1E/DoU0tiXRoRTvITrFjX93XbOE17iZWLMXvKajW7vXeoitWLdfi36PwRO7XTtkZj60vOWwmTeqWSfBgpeeI9kRIJ1wa0XbMG7V4jgK2IuKQmGK0qg8JKF+epg3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 15:16:39 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 15:16:39 +0000
Message-ID: <438674d9-3498-3213-6928-6c30971e3d98@amd.com>
Date: Thu, 10 Mar 2022 10:16:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amd/pm: Add STB dump function.
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220309210330.576809-1-andrey.grodzovsky@amd.com>
 <6136f957-a029-3984-4967-7077a18eedb0@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <6136f957-a029-3984-4967-7077a18eedb0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:610:4f::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a7250a-61db-46db-bb3d-08da02a8f9d7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5817:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5817F1A5F0A451C1CDC4038AEA0B9@DM4PR12MB5817.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaZiDtM8WH0HoReTlvR+ZBtu233VK1hNaisPIxx5xK9pKrp2ALeQgYq3ClN1GK2uOvJjCq30Em3D6xyWp0Iu0KNvR/GzihjMiIIRgKL4siIVXZ9vKqczKHuRotlt5ZxPzqzLeDU00lk9ZLrKmhJx+e/kwPPHcfPY9wCnfLfyTpQQpAgBMu2ItL77zDdy1tVbKbzJ/L0HR9s1q/+ToIyDxjO8vCdlqwypWbSb6j1ioaIS3Wfcmyc3faaJ/gAaQ4Af5YWiOJjNEZSwMz1iMedIrHCkbshhifbzbNhBlpBlrB9Yx1YLWHI1rIJMhQmRHx2RrmlwML99VEONKNCsArPyh6cH+gdB/G9UTvAWeFzg2dRZTQ9OKBtTHtTkHHC/Q/b7sW4mXSYPiXJEDb07rfuefXGYXPigtUChBegIhvZ+wJFK/HHaf99RiTpIhWxj1LB6lhJvguj4leMsBsxoLGawOH6FO41zwyCEEUhAWVIfBEM5h7sdHNrr3Lnb7sAwGLhfqKWxlsrGWdkyU2Q30oVNNnZcdjxNcdkFolQ9DXdkoVRENeOB8g3rPj/AJpCenx8q6rF7WfFIj0k3HwwggbOgKWt9404KYUX+Xu/20fp3SWJmPHMsNLJmBpQLietDm1Z/25w2TJMI2HnvkkqmuwC0Sc2dQR8VkmMwzxogpnjmbMyfLgVWDIt3MyVgGu9TLfsPSCJgZ4mHS23JYZQovoByAAjxs3gX+aa3dodOlfjeygY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(8936002)(186003)(31696002)(508600001)(2906002)(86362001)(8676002)(4326008)(66946007)(66476007)(36756003)(38100700002)(44832011)(5660300002)(316002)(6666004)(83380400001)(53546011)(6506007)(6512007)(2616005)(31686004)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFGajVEZm1adjNNdGJMcktrc1lzN2hjeVg0K1lUajcxcE1YeGV5OHVjWVEy?=
 =?utf-8?B?VklMUjYxYTBKNTRLc0lxL1NPMEQyODFPbXpQN25mdWpaWTVRc1ZpeFk3UmFM?=
 =?utf-8?B?TzN4emc0QzZTNm1MYUJIUjNMKy9RVHhrSkx0aDI2WEpaZHQwendYTGtVdGIy?=
 =?utf-8?B?by8vaXE4STdMTVk3TTdtd2g3VXFlT29WL0lxTk03QXg4SklGNmRuZjNqRHR5?=
 =?utf-8?B?MGdhREVmZ0p2ZXRlR2xoMURRQlFvQkx5VEY1ZTRCRXRUeExORGdtWndOdm51?=
 =?utf-8?B?WFEwbDEwY3RianlkbWVuaWdXakJzeGtSZXVYMEhWcVdTeWhqSktCc3Q0UWR6?=
 =?utf-8?B?Q0dSdmZCUzIvbkV1RUFwc0pZVGErSFgrYUQ4V1BrcHhNVllteXRwMWhaelZn?=
 =?utf-8?B?SUZLTzF2ckVNVUk3L0hpSW9jcTQyOHBIaGdxdk8rNTF3SXJZMG5yRGFCRkl3?=
 =?utf-8?B?UUdHS0NLQUdKekJjQzh3VERaVW9vbWgwWXRTcGJHbW9CWFk2TUZMOFN4cUxt?=
 =?utf-8?B?Ykxma1V2bVBiNThObG5pL1ZSL0JPbEttck1waWJKNnp5SkpUSllUcUJlNzEx?=
 =?utf-8?B?VnNldkljbElKUUJWbVFUTXdSNWVXb3NJUEtxcVJ4dmp4VitPQUNkV0tuVDJE?=
 =?utf-8?B?MWtpN0R4Ym9KOGRuOVh4L3NDRUljY2IzWUFsN01sMk5RM2thdjJSY2ExYVo5?=
 =?utf-8?B?YTFkeU9DQ041YnI3bmIzM0xBeEpaY3hyRUovWHdtajFVTXdoYUJsL2JWYUV5?=
 =?utf-8?B?MzM5K29PY1JYSGR0a1B3VnNzNnBNOXdkd0VueWZNbEJVcG5ZTVJPQWxVTEs4?=
 =?utf-8?B?WjRWcSs0bkYwTi9JVTA1YWxHRHVPZzkxa00vL21XSi9VeHNTM2lVTVdMTWZO?=
 =?utf-8?B?UklXL3hLQmxJZFpsckprZUppN012UVp3Y2FVdm1tYVhYdTFsaHVLOHRMd053?=
 =?utf-8?B?OGphN3pWN2d1M2dSY3ZZMFBybElwVFc4US8xaS9selFsZmdCV0FKc05RT3FT?=
 =?utf-8?B?VjF0MCtuYkptdkdsMTJXVTZHYlVxNVhKcGNVU2pMdGx3MlV2Mk1LY1Q5Z2FQ?=
 =?utf-8?B?SkpTdER1Q0c3NWtzMC9LbXkzTGpBYi90YmRlQURUdE1SaE5MMEc3aXVSMXd5?=
 =?utf-8?B?SXRHTVNabkxVbHoxdUp1Qys3c3RzWXJheFNhWGRYUXdQMG9YNHE5YnB5cGo2?=
 =?utf-8?B?YzJtVnJhTDM4aU42MEVSZC9lNzVTRGZiSEJMTjBucnVnR083bjUza2NROXhp?=
 =?utf-8?B?SEpOUURDNGZDcHgzeEp5WFAwNkppVFZWWHNyNUdZYjRRbDdmSi9rSHpRTHZO?=
 =?utf-8?B?UjV0WTIyNlRWM21tYXZmNXBGV2hIaDd0VFdZUnJLOG9oWThOUm9zMlUyUkth?=
 =?utf-8?B?YzhQcTNuNXFyVi9ROUFLalpqMGdPZmhCQXVDNGZsS1JHbmtLWFFZeHM5R085?=
 =?utf-8?B?dm1ralVxVlVscENSVTlReWtYL1c2MXpjOFpsVW9GdjA5UncyQ1ZoNnhCTnRx?=
 =?utf-8?B?Qnp3SEgvZjNBaGRuQVZUeHZmOXJkMUM5S1NDamNCNTYyQllNaVVGbmRicXNj?=
 =?utf-8?B?OXlETnlVM1UvRjV2YUJiVnFPNEcyWUJtKzI1WlpGcElwSGd0Y0ptb0EvVVNl?=
 =?utf-8?B?anFFMW5HU2l1d3R2QmNvN1NITU1PUXY5QUt5MDBWaUwvdGZyZ3hWTlZNUUl5?=
 =?utf-8?B?VkJacmlLYjdQT0JuUTBhYVQxalRNUkhWbzZ5Q1h3a2F0aFE1VHlDNldxVGE5?=
 =?utf-8?B?MWVVMWJrcHgyS2xaeTgxMWwyV1BmYWwxNDhWdENqeGtlM1Bya2RtQ3Jxdlll?=
 =?utf-8?B?d3VOQ3pkMnU3TjRpNCtsL0V4dlNsbVhTR0R1SFA3enBFZ25ndlh2WndUelpR?=
 =?utf-8?B?ZU5UMmZJbUIrQ3o0UWJtejkxRmFlN1E0VnNDck9ibUJDUmZmMUhEV0VjazJC?=
 =?utf-8?B?NEJhZzRNTGR5anhmZm9FQXZVamdBSzhsZjVIakF3K1p5bFlSMXdhWmxjNWRE?=
 =?utf-8?B?SkN2L3RTK1hsc20rSDlUaFJuVFZhOFlrZFpHOVdEYytTc2syS0NhRFZRc05P?=
 =?utf-8?B?bzl1K3FJUlF5RkQ5RHZxWHo3SGxIR21qRkVBcUhRdHU4NWR2dUNvK2lIY1dC?=
 =?utf-8?B?TFFYSlZyYjFpN2dPdThldTBYcjVZaUo3NmN6Z1NRbCtJd01HNXVFR1kyTHl0?=
 =?utf-8?B?UmlwVFEyNHFpM3NNSnRVSC9UNmhjVldaYkxiWko1cTFOQWhmMDgvOEU0OG1U?=
 =?utf-8?Q?GhdK5kwKHXG3C3NtST1eav+lCp1CbHwfXlH2XgXlgg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a7250a-61db-46db-bb3d-08da02a8f9d7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:16:39.8116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RMDTnYz4xCQtY6ndr3UsiARBhh2TcPVpQVyynbm5jcGlXgIDsUXXGwfksY5uzY7t4SJxLOVHqm2odtLSiuzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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


On 2022-03-10 00:17, Lazar, Lijo wrote:
>
>
> On 3/10/2022 2:33 AM, Andrey Grodzovsky wrote:
>> It will be used during GPU reset.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 10 +++++++
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++++++++++++++++++
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
>>   4 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c 
>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index 1d63f1e8884c..815a6367d834 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -1327,6 +1327,16 @@ void amdgpu_dpm_stb_debug_fs_init(struct 
>> amdgpu_device *adev)
>>       amdgpu_smu_stb_debug_fs_init(adev);
>>   }
>>   +void amdgpu_dpm_stb_dump(struct amdgpu_device *adev)
>> +{
>> +    struct smu_context *smu = adev->powerplay.pp_handle;
>> +
>> +    if (!is_support_sw_smu(adev))
>> +        return;
>> +
>> +    smu_stb_dump(smu);
>> +}
>> +
>>   int amdgpu_dpm_display_configuration_change(struct amdgpu_device 
>> *adev,
>>                           const struct amd_pp_display_configuration 
>> *input)
>>   {
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index ddfa55b59d02..99351d463a72 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -503,6 +503,7 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device 
>> *adev,
>>                   size_t size);
>>   int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
>>   void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
>> +void amdgpu_dpm_stb_dump(struct amdgpu_device *adev);
>>   int amdgpu_dpm_display_configuration_change(struct amdgpu_device 
>> *adev,
>>                           const struct amd_pp_display_configuration 
>> *input);
>>   int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
>> @@ -540,4 +541,6 @@ enum pp_smu_status 
>> amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>>                             unsigned int *num_states);
>>   int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>>                      struct dpm_clocks *clock_table);
>> +
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 7e79a67bb8ef..aff0ed9b6f9a 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2958,6 +2958,32 @@ int smu_stb_collect_info(struct smu_context 
>> *smu, void *buf, uint32_t size)
>>       return smu->ppt_funcs->stb_collect_info(smu, buf, size);
>>   }
>>   +void smu_stb_dump(struct smu_context *smu)
>> +{
>> +    unsigned char *buf;
>> +
>> +    /* STB is disabled */
>> +    if (!drm_debug_enabled(DRM_UT_DRIVER) || !smu->stb_context.enabled)
>> +        return;
>> +
>> +    buf = kvmalloc_array(smu->stb_context.stb_buf_size, 
>> sizeof(*buf), GFP_KERNEL);
>> +    if (!buf)
>> +        return;
>> +
>> +    if (smu_stb_collect_info(smu, buf, smu->stb_context.stb_buf_size))
>> +        goto out;
>> +
>> +    DRM_DEV_DEBUG_DRIVER(smu->adev->dev, "START PRINT STB DUMP");
>> +    print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
>> +               4, 4, buf, smu->stb_context.stb_buf_size, false);
>
> Printing to kernel log with each reset doesn't look great. It makes it 
> difficult to associate this with a corresponding register dump. 
> Instead, it is better to have a buffer accepted from user through 
> debugfs and copy the data there for each reset. The app may keep the 
> reset data for a particular reset together at one place.


STB already provides debugfs interface to retrieve the latest buffer if 
needed. On top of that - not all hangs are related to user apps 
submitting commands, there can be some internal kernel driver issues or 
FW issues which could
trigger a hang without any user app even present (working in FB console 
mode) so I wouldn't want to tie this functionality to presence of any 
user app.

Regarding association with a corresponding register dump - I probably 
can switch this to even tracing which is what the register dump is using 
and then u will see them in one flow in trace dump - I am just not sure 
how I dump a variable length buffer into event trace - how i define the 
argument ? Is is just a char* ?

Andrey


>
> Thanks,
> Lijo
>
>> + DRM_DEV_DEBUG_DRIVER(smu->adev->dev, "END PRINT STB DUMP");
>> +
>> +    return;
>> +
>> +out:
>> +    kvfree(buf);
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     static int smu_stb_debugfs_open(struct inode *inode, struct file 
>> *filp)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h 
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index fbef3ab8d487..991586f61a85 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -1426,6 +1426,8 @@ int smu_wait_for_event(struct smu_context *smu, 
>> enum smu_event_type event,
>>                  uint64_t event_arg);
>>   int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>>   int smu_stb_collect_info(struct smu_context *smu, void *buff, 
>> uint32_t size);
>> +void smu_stb_dump(struct smu_context *smu);
>> +
>>   void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>>   int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t 
>> size);
>>   #endif
>>
