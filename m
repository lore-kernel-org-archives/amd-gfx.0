Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BB8C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E30D10EB08;
	Thu,  9 Feb 2023 14:47:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC41810E211
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmyljbOcBKMX8CLgk4NkJVv6F+56bBHzV8YCHPDWcmITriwJcYDGDqHraRvARkbT+XuVdpy9TtrYxG8gtwmxO8WOb+Jo/4HDKVdT7OLqg0gx8WSzEKMHLFnaxV3brdLYsdL2qhiXKIpzoZWppHotIPMZGBrTsBHAIYMp2bktXbAATb8MBbLT5ZPoF1ltdX0VrbMaQcruNXU8hm0nescOq76DLdpTBDvoHTqK8/C/KohBP3RQ7OoRCA2S/5eUARzKul6iIqFDiAjV5ub/2UqYoGWPrHhc9KRBgkE7UWHhk17vaXk09eLNooQLJJ+2LgUHnhwmToRNcLAaaGa9EV/JNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RUNhM/mMC1SSeGQsMkMq1Jf8YgFNFOScl4+WzbnNaA=;
 b=cWz9OTuDtJJiXsnfp8TGlACoDJmnjsHziOKTyD2Thfp8r6H9AhahRKacz1HcBlthfaUBbQKl2k/qsTe8XSGwQBgczLbymYiIcUsQy0ZQMcwgk5A/991Btj/qaFsjDGwPbsejGEtfdmsh4aIsNPRyaU2mb6Pi7mtv/4MQ5Tq8IMmn++GHJh/F7Ib1VlWi0VqrAXzQil3qsUi0TrieGxZLenIS7sU8FW93dSb5B9wESVZhLFaMSaq2SCPicuIfbgcv7NCSqpoz4/7BtT3gz/Skq9eV9eA14+V1zLM02ul2WrXGB0XvTsVLzzNQLV9u8MfXXp45+oHQnuteLjHFZgghVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RUNhM/mMC1SSeGQsMkMq1Jf8YgFNFOScl4+WzbnNaA=;
 b=a26VEg2OvjgUCAoRblYRXidaaW8iW/QIhwDV/Av51/d+GX7zuXBVds72If8tBB4GsQNtwfnnBvA6cxOkWAJbfuFz8gO2BYXOdp1xo075YYZmfMFdMn7dGasInpwneRNXIVeRe2Uil73sNdrqmohwt6VLxMi6nFSeq2MXLIKZ/SI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:47:26 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a%9]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 14:47:26 +0000
Message-ID: <9fa65034-71fa-9bbb-13d5-c4828af852ca@amd.com>
Date: Thu, 9 Feb 2023 09:47:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] drm/amdgpu: add S/G display parameter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230209141150.612825-1-alexander.deucher@amd.com>
 <0a4e57da-5960-0955-8fc9-a4cc1a28b9d7@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <0a4e57da-5960-0955-8fc9-a4cc1a28b9d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2b19b9-4984-48fc-4af7-08db0aac8f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gdlvvp6PzDpBZZhp+bkbUKfWfP9f/mtIVGwRgCBYmTOBQr8SWwasuG0XBfSzowtM0GQJbGUXEe5JMRtUSZdG5Wfr5U4ptQ9etgFqKn+0uC6eb4mGRrPnrSK3qcEQGKjrDVS+/VyUOB+agHNYdXU901JI+xNTbzSbjup6t3/sUCv247HBEMlOCA7cEs/5KnHEreQgWQ4qwbVZOsP7Jk4mSLwHqvES+/5NNdxjSC8rJdL9U6DetXSYiOjqpy9UwBNeZWKzbZqrxbLpki2trVUyqx/Mn3w0iKCpX6WANOKP16aDEepULRKDnQqjhfVgWYHX7djVAOS7wbeo1utBbnkgiiHLPyZecMrM4GjoUaEIE01TgxUgGg4mEXLXx6QX3BUpTMIYRCgJJvSkFh8n/WqMZYGz/+fiZRR4y5HnHyNmYunY9He2nchEw7omEvL4QAsZmGvu6aRKJdQJ5T6lmtjxD/Xayz8JrQil/WagQVisuO8lEKfRQKfKcafSoprNkMIHMwimmf5vzp0C4s4FjI2Tgsg6gXgfqkXhFYeF/VPhvfzROTlFCaPJDskKCqasz3xFtDTYMXmNqVFf+zZRyjdOe+Xp23B6bXf2xoQCRGl05QFOJ9rr8521wBYJOKTBcATjkp9V490VSZu6UUko2QAkqiLsYhHGq6r+XyLYFnoFiRi9HVgFyCB5KlfEnahiRZ4+kVOWv8TmO8FKoa3YeF/sD/4AhTrRYjNXaeG/hzVmEd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199018)(110136005)(36756003)(316002)(66574015)(5660300002)(8936002)(38100700002)(41300700001)(2906002)(8676002)(66476007)(66946007)(83380400001)(31696002)(6666004)(186003)(44832011)(6512007)(2616005)(6486002)(478600001)(53546011)(31686004)(86362001)(26005)(6506007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFkOWFWOTA0dlZyeTlnZ3BBeVI3L3UzNWJtUDI2bGRicWxSUFdFSElMZ1A1?=
 =?utf-8?B?Y25yS25YNXF2R3lzUW4xc29sa2UxbmhPRlVCZVhURmtZbWFMVEdqZFhicUFt?=
 =?utf-8?B?UlozVVRSM0oxRHdWTHZ0STlFekVDQllEQzlLTDh2cGVWVklUckRmQUV2WXF1?=
 =?utf-8?B?WFBnMXV3R3U1eVdVOTdIRHlqYVBWWnBKM29KbmR0MXQzUzVOUzZSVmtxa1Uz?=
 =?utf-8?B?RStBY1RpNWJYZVM2YzZsdy82TmsvOFpwaUFVR0hxZ013ZlI1NW9lblZrNFJF?=
 =?utf-8?B?Vm8ycXEyQ0daMCt5Q3BOVkZoQ1dsZHNGclVFc29RT1I4Sk9kcXVOOHpXZCtB?=
 =?utf-8?B?RWk0WXY1QlRiY2JmWERVak10UWNORCtKeDVzWk9jRVM3YzIya2xsRk8rWmJS?=
 =?utf-8?B?clBXVmR5c0oxQWFpc3hPc2RucFZvMzVGZXBDdU5xcnRyUHduWFYzK1pOdEVP?=
 =?utf-8?B?R1lpTVVTT0hWcFo2REVNdjdoYThMRWdNZ0VaeVRmYUVkalRqeVBwRFcrZEY1?=
 =?utf-8?B?NmVscGpybHVyZlpSamtvenYwWVhjM3o1aFl3ZFcxTEQvT3h2NzhQL2Q3MUxn?=
 =?utf-8?B?b0wzYzlyNjJPNGhHcHZTaFFoYlUxM1RCTVBpUVBRRUpGbWRSTmdxbHlMS3lD?=
 =?utf-8?B?K1VZOGZVNkxqWlA0MUJ4ZlhtMlY3eGJpb3RaSEFlNXlvMG55dVVlTEZ6Y0lX?=
 =?utf-8?B?cCtHVWpldlAwaUdqWThmTjZkd3dBNTR3a1NmMkpucUFPRlRxV0xOYWMrdjdR?=
 =?utf-8?B?ODZWeks0VUhleE9UWlVjUjhURldKdVJCcHVJMVBjQWwzVm5XTnh6QkNQelFF?=
 =?utf-8?B?Nnhmb25kV2hSLzhlc1ErbnRqMDh2MStEZEYzTVp4Sy8yeTBvQ0l2MUszdnhz?=
 =?utf-8?B?NmVtRE9Jb0tSQVZ2NHZ6bVl3c1FlSzFrWDdCcEROZWRQcUJtUFVKK1dVanF6?=
 =?utf-8?B?WHdSRlorTUVxWUU0Nkw5NUtUc29IdngwTlZ3eGRsUzFtdHkwcWRyeHNwKzlR?=
 =?utf-8?B?cGNqRWxSV0IyOWZsUGI1VSt1d2kyd2FHVjh1TlE4R1FPVU5aMzdTUkxEQTBJ?=
 =?utf-8?B?L3F5bjRyLzh1emFvbFFmZDNQSUsvQmhLSVZHa2plZVQ5cGRiWXJXSnpUc1dF?=
 =?utf-8?B?VytFWllOQUhHQjgwelNEUmF3Z2cra0p1am5wWS9tK3JDRXRWT2RZT0k0V21q?=
 =?utf-8?B?blJRRnVBNWhQZG1rZ0VaczhWVTdiOVkvRVJsUXdWZmhQcXJCRFpiTTFBb1F2?=
 =?utf-8?B?bjFyd0dzaXB5cHhHQTcwSTdLazlkK1dCTUVGL2JWV2Z6dmhKRmRuaG15V3U3?=
 =?utf-8?B?akU1RkRwaUZsb1lROWdRK2ZqU05Xc0pPSHNTN2ozSEh5aGoreERwRjlGOHYv?=
 =?utf-8?B?bS9KZkhzbll0Y3JDb21uNlZCMTJraWRJZnFKNG8xZGhOUGo2L0RMalpxbHhF?=
 =?utf-8?B?RlJaVXQ4WXN0UjMzamJIMm8vRVBDZmdLT0NVSFdWd0NIYU5na2VybzlsTEth?=
 =?utf-8?B?ejhjQ1pQUFh6MVE4enFIemlQMWhPV2tERU4zMmt3ZEo4dXRsbGE2TnpENlZP?=
 =?utf-8?B?eFZTTmZaUUJlR3UramxQb2d4Rmg1MXljY0ZrOXVpT3BzTVpzQ2ZCQU00YXFJ?=
 =?utf-8?B?WEs2Nkh3OUJsSkp2c0FRNjlrWXlENkFHdm16aXEwK3ZSbVVrVDhrZXFJU3Bm?=
 =?utf-8?B?MVNsOURtcHd5QWdCMWtGdU9iaDZlY2UwY21OQko5YlBraG4yNnpIajJ5SFVv?=
 =?utf-8?B?SDh3VTRHZjV3OUtDSk5oZXdFNE1jRjNkMkFRdUFXaGNTWUJoblZzZzh0eS9m?=
 =?utf-8?B?Q2tGOXNWY1g3ZUkySWQ1RnQ3QkdaOVdFMGE1bzE2TmZMUW53M1pVMkFRZzhq?=
 =?utf-8?B?R3NZSE12cjJEVklMOUtEdXZLVk5qK0YrRzhGQUdHUTBhR3c0cXMrSnRkbEtv?=
 =?utf-8?B?eWs3RWM5Z2pRSEtjaHArZDZrZ1hVUURtcTJNY1VPdnRWaE9hNnU5bW83TVg3?=
 =?utf-8?B?eTJQRWoxRTFVQjl2RkxtUVhqREdVODRjZEpYaTRNVkV3SHpJaHRIUkl0ZzBE?=
 =?utf-8?B?RmgvMDNsTFJtbUE1cVY3eTMxWVprVlROejBiS081cjNxQTVQd1p6R3Y3eTlF?=
 =?utf-8?Q?lMsMbaodNNsgsIMx3j8/ZNAiA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2b19b9-4984-48fc-4af7-08db0aac8f9a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:47:26.4850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj6Nc9pDbZEpclzgqxH1OfAvie/+0AgLU5yTkASb1MAODFR/rhxjR4WvDQ6cMfHxmgmjcX2yrg82kjo+odQQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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

On 2/9/23 09:37, Christian König wrote:
> Am 09.02.23 um 15:11 schrieb Alex Deucher:
>> Some users have reported flickerng with S/G display.  We've
>> tried extensively to reproduce and debug the issue on a wide
>> variety of platform configurations (DRAM bandwidth, etc.) and
>> a variety of monitors, but so far have not been able to.  We
>> disabled S/G display on a number of platforms to address this
>> but that leads to failure to pin framebuffers errors and
>> blank displays when there is memory pressure or no displays
>> at all on systems with limited carveout (e.g., Chromebooks).
>> Add a option to disable this as a debugging option as a
>> way for users to disable this, depending on their use case,
>> and for us to help debug this further.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com> for the series.
> 

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++++
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 64f9cc6fbbf0..187597024c1e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -242,6 +242,7 @@ extern int amdgpu_num_kcq;
>>     #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>>   extern int amdgpu_vcnfw_log;
>> +extern int amdgpu_sg_display;
>>     extern int amdgpu_force_sg_display;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index fa3788bb6a2c..afa5c39c9c74 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -188,6 +188,7 @@ int amdgpu_num_kcq = -1;
>>   int amdgpu_smartshift_bias;
>>   int amdgpu_use_xgmi_p2p = 1;
>>   int amdgpu_vcnfw_log;
>> +int amdgpu_sg_display = -1; /* auto */
>>     static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>>   @@ -933,6 +934,16 @@ module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>>   MODULE_PARM_DESC(vcnfw_log, "Enable vcnfw log(0 = disable (default value), 1 = enable)");
>>   module_param_named(vcnfw_log, amdgpu_vcnfw_log, int, 0444);
>>   +/**
>> + * DOC: sg_display (int)
>> + * Disable S/G (scatter/gather) display (i.e., display from system memory).
>> + * This option is only relevant on APUs.  Set this option to 0 to disable
>> + * S/G display if you experience flickering or other issues under memory
>> + * pressure and report the issue.
>> + */
>> +MODULE_PARM_DESC(sg_display, "S/G Display (-1 = auto (default), 0 = disable)");
>> +module_param_named(sg_display, amdgpu_sg_display, int, 0444);
>> +
>>   /**
>>    * DOC: smu_pptable_id (int)
>>    * Used to override pptable id. id = 0 use VBIOS pptable.
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index bf06875e6a01..1babdfaa789a 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1576,6 +1576,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>           }
>>           break;
>>       }
>> +    if (init_data.flags.gpu_vm_support &&
>> +        (amdgpu_sg_display == 0))
>> +        adev->mode_info.gpu_vm_support = false;
>>         if (init_data.flags.gpu_vm_support)
>>           adev->mode_info.gpu_vm_support = true;
> 

