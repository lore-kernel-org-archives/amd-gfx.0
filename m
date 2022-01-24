Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440DBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2B110E325;
	Mon, 24 Jan 2022 16:53:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530A410E325
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kaj8Op79W3B7RS6THnQq6O9TET60IFAlTk+upc+fWcsntvg+Etn40wcZknXvN/iWCfbX7zPuMlygNuFou08U8nuEoAchyijOH6qOs4Fns006FItJeefeWDfFgmmG2mmFDhSZaQ1QgFgRJGUcny/9kEzQHmADcSz7uIbZt3EttnNQypDsepOFejBCV9QdhQOPl1HLkKvLGlQOD4sdyBqtbltpINhbsdUzrcR2soTQ5O3XZLxeZQcvL6iCfygOaP55wxs1n8tIM2BwgZ890oTIPf1Cxm28I71Z30EgDrWbeVz4Q2mbZu6TiHa3vHIuZPppe/b+7ZN8W2IygDIJKqYf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEZlBSWgUz8wF3KF0et+/Xx1zdo2JBFNUE8aKk9wtsM=;
 b=gOANbZWdK4mCwdGuVCMPz600OO33fe6xgdp4t8hjqcZT+VfSeSswJbHc0JGXnGie0G1VHrFlZKOoNJzqcIrvZvuIErtpNq38WVLpJfW5GkgbzGiXuMpRseEBf2vqK/iPWRwkp44f5wwvpx/DWEKpm/N+PZNakOT0PTV25Mtgqe2pnrPvoa9AnycNYHM38dC1LMDpElgCrTNdeiyV6n89Ty8KHGlSgt09kreRvUDFYOWnMOpSf5Yo3HULZiWlk3Yg2nCtu25hgorPSSqrVbHROgcWUhSFzrjynwVOGXhr1IU66bYceM4CwdhlFUeXorDoLBwWSAqZ46ri2JZAX/t6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEZlBSWgUz8wF3KF0et+/Xx1zdo2JBFNUE8aKk9wtsM=;
 b=u2+ubiqbKKokWuuza48JSdZe1VA8tdjU1XaN1ITeKlbvsH9QnBdMa7UuS/tBEHRL0whdTGuIxh9IRv4bWOQ4gSE0NY4E+pG95lAQgKzrTwDTSakelvA0FGNSweNWnV5W8Cdg9vSxvGR7r29hsFYiYM1Aj7HRjHygTckJmcdMQBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 16:53:04 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:53:04 +0000
Message-ID: <2ce641e9-0d47-9f12-df9a-988cf7232531@amd.com>
Date: Mon, 24 Jan 2022 17:52:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <b951f172-45f4-c88d-6655-8eec715c038c@amd.com>
 <5d71f21b-39fb-90f6-226b-fd5dd46ce010@amd.com>
 <88476e37-5069-867b-1192-022e8aa02162@amd.com>
 <47fd2dd5-6e3e-69d8-f01b-a2255f8159cc@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <47fd2dd5-6e3e-69d8-f01b-a2255f8159cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:203:90::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 128efac1-7084-4157-cedf-08d9df59fcf2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4212:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42124520E366FE803CD2970EF25E9@BY5PR12MB4212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz+AOrzTIVouozd/K6lBq69wGMThcrm9boKz1gxOuT+oez9n921tKSy2w4KdtGlpx4mXng8iJFmtTxibDue3iB5qYE2o8A6UtfqvjOYRwCX2exsZIwbilZ/Z+JAPY79GZA+H0U5zF4TTQ66FFs691asFOepbFgyzNZhvi68Mm/ZFxA2ozEejJwZixWhB9q1kFNkEBqxMdyTopHKOhobD7edBCtoIsUy6LYT+J3GNPCLSAPER00HvseRPyIbGCMEeXOrkFO4eUTkBK7Vm9CN/HrSpWZUdXyh7uMdLfhslCnQH200dS54vfTwuxu9oVHxGZ+f2D1oEN1SdDb97fLW9TdZ1udA4Pey74T4ExeZxo3KhULgEZtVXv+YiZX158BnLrdbetiB2A2k3HLOx2vM/awPEJvduCobU1wJNVDC8jN/EOhqWcmu9e7f44AzgyEof9csoJeSAoVxGrkR8DTjsf98PfwduL0ECQw8EntxdAVerrd2z9RZttWsq34Uhd9/xcJoy4wJA6fZ7xVF660zfUrkS5PGAZaX0oxUQ6vJU/zKmfj9cptq4kyg+ss9klA+O3XT9lqmJxZmmyBJtSmieAcfNYdRJ3y1zMaeY2b/jIweuInFSSFlFP9hj1sNQ9H1rPpFetga4S6jBC6ojauAaQpo9zvbDTrXmmVNkL8dE1F6zZsFVlLXZ+Slgah0d6MZnblijiKgbeVuDXi+xx9hSWcXUBbS5MNsvvylhQ46LGFrnPBFr3693RlGpaL0OBSdT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(66556008)(8676002)(26005)(31686004)(86362001)(316002)(8936002)(36756003)(186003)(4326008)(5660300002)(6506007)(6486002)(2616005)(6666004)(508600001)(6512007)(54906003)(66476007)(38100700002)(2906002)(66946007)(31696002)(110136005)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlJTG9iTHJKcVM2enJURExMTTJIREFVWnNnS0U3c3gwdVJKYndNQU0vUUl0?=
 =?utf-8?B?Tk1FWjdFZGE2dGRsZUltVWs3TGM0R3N0akhGcjViZWNWT0hsOXNtdW9xdkVN?=
 =?utf-8?B?KzJXVy9VMXBTYlhNSmNuSkUvU1ZwTjYyZW5wTWp6V2RmQVBnTHMvM2ljdFZ5?=
 =?utf-8?B?eXZmMTRGMjVrcUYzenVveWh4dFBzSDVuN0QzZ0F4YXZBVWh3YVJvSDNMWnox?=
 =?utf-8?B?NGNzLzNQRG52VnFrUDkxT2xudHBoWmxFSlFsaExjakFabVIxUU9UUy9oaWdy?=
 =?utf-8?B?bi9PZHpCb09sMUh5TmczYUVmZ3RwdjU1VElPTEZMTWxzRXdOWUN2blVZU2pm?=
 =?utf-8?B?MVhhaG9iRkRSYlpmVzBWaGVLaFYrWmJrQzRwSXpUUlAydEk5Qlo1cTRCVmRN?=
 =?utf-8?B?Q3J4QU81UlZxYndGM0ZJdFVKRGhpYTRGOVlQMFNjZmdNTHgvVWdiS1hrWEZD?=
 =?utf-8?B?c2VicHJPN1JMMnVka05FRDAwb2F3eitCQVZ6eEZwL2k3MkQ5dUVHWGd6QkFv?=
 =?utf-8?B?dlhJb1FmdVpiVkdWL2FyRWRDS3I5WCt5ckpiQUczQm8zYVgwTEk3OWN0THNE?=
 =?utf-8?B?NENyTmgzOXlFWkxQVlArNURKc0FkNmYreWtSRVIrUy9xTE1Rb3lJSTZHRVNX?=
 =?utf-8?B?WTlhZHpsV3F1SmNvMSswNWU1bG9mL0N0eHc2R1JaQ3k5SlA2RGNrdG5TUlhE?=
 =?utf-8?B?eUZXNW9qUFJjWlNwY0hkRU1YaGhrNUlKV1gzMjBsRDk2NDFWd3JuNkJ0M2xs?=
 =?utf-8?B?V1IxL0Q3UzFiRVlsWS9aZUVrMUlGdzJhQkR3MnhJZE1rdjlHYy96QnhEb2w0?=
 =?utf-8?B?WlRUalZrQWxCNDlNNGtwa3J1L0IzM3Juc0lJdmhYQ0I4UFAzT3JKTFFqT0l6?=
 =?utf-8?B?dHEyYTVRcjJ2cTc0TG1sQm1qNXhEVVFKNitYUURXYW53YzV3NGFsM0Y3a3ps?=
 =?utf-8?B?Qk9TeXdadGZKcEhXWVJnbGRWRmJLY0R5bkZ3ejZuM1NCekV4cmFDeExPRTdz?=
 =?utf-8?B?OXZQQnd3MGJBeFdhSWc0RDVBOGFQQ1RZbjN5RzBFR0x4UytDMno4S0VIMkI2?=
 =?utf-8?B?aVMvei85L1UyTm9sRE9OQ1ZpK1hKeGtnTGV1TysxMWJMNEhGbGZ4ZVRsUk5o?=
 =?utf-8?B?bjZTUUMyZmRoakYyVXBRenl1dmJYTjNydG5adjRYaElsN0dGZ3BLUmo5dVc1?=
 =?utf-8?B?bFNRNVBJK0p3NnJtVnhVR1ZGa0tEOElCT1ZNQmFGdFNsMytldlRRazFqRWFY?=
 =?utf-8?B?Y1RkanFvS25jcWlPK0ZFNExoNzdWTXdUelo3SldDSGNLcTJNUk5jckxwUjZ0?=
 =?utf-8?B?MXhhbmZsQlE0ZjloSTQxMXNVVGVMR0QxbXo5dzdIZm1nVnRYZ01rU3FNcjIr?=
 =?utf-8?B?b1I0R0NNZ2dFWjkvdjByRjN4cnh1akFreVluWlduL0JGajNkTUhUWDdsMm13?=
 =?utf-8?B?eGM4YUU5Tithd1NvUTArM21PaWpRVWdpT2hISEppWVRZbHVwdmR5LytWOVJT?=
 =?utf-8?B?aUtzb1VCaURxK2lVMnN0WFZ4U0JGS0s3elU1d1BKMGNERWxJNGlQNkVxaHJV?=
 =?utf-8?B?Rm8zQTIzL21hTTRXMWNNNVVpT0dCUlRoZ3pybjljUHR3R2NSc2tXeVFoaEwv?=
 =?utf-8?B?TDBYS1ptUDh5VUxRQjRzM1RIajJYZ21XWE9TTGdVU2VxY2lFVnJVWjdweWM5?=
 =?utf-8?B?ZWQ0b0NFOXBSbU0rRjlIRkhQTVlVV2pCOWJEb0YyTzBpNnJqTE9QU2F1K3U3?=
 =?utf-8?B?eW9IaWJTVmZNZEhNMk03c00vQytGT0pjTWlCek0xTFdhREJQbGZGV3d2TmZC?=
 =?utf-8?B?SFRycTFYQnRMV2xwMElMTE9XTk5rYXpPQlVCSkd0K0ZGR1Z6cDNHL2JSNTVj?=
 =?utf-8?B?YkRTSTFyRThWOXU1UlFTMzVpN2FTZDRTMGsxRlh1czQ5NjR1bWhRSmE0Z1cr?=
 =?utf-8?B?ZVBOZ3FsVlF0bGxjN1hLNnp5V2dYVkpIV2pKbW83Wlh5VjdHbTlVQ3VMY3dE?=
 =?utf-8?B?OS9rL2YrbXhmSUdpOUFjQTlyWFhQMWhrZk5ZVmEzQ0dmbjUwQXNrVXRURjdL?=
 =?utf-8?B?OCtYYnJMVFZDVDNwWTRjSTgvVHNDYU8vWGpWTnYyc1JUaVdhLzQwUXliZmNy?=
 =?utf-8?B?cUY0YkJ2VkJMMkNub0Q1ckE2STlJMDFpbzlXRTRKcU9aRnRxU0JwaWlscERD?=
 =?utf-8?Q?6F5ssAsCWTziLBbwh5NuTnQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128efac1-7084-4157-cedf-08d9df59fcf2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:53:04.0833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nohbQdsCTk1cjuj/wTDyZoI1Zq+QSp0Y+aIz0LS6vJg1NgGTQWld4m8oxB9pVX+MOtNkZYBaxA8HAd794Nlc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 5:49 PM, Christian König wrote:
> 
> 
> Am 24.01.22 um 17:46 schrieb Sharma, Shashank:
>>
>>
>> On 1/24/2022 8:17 AM, Christian König wrote:
>>> Am 21.01.22 um 21:37 schrieb Sharma, Shashank:
>>>> From c598dd586dd15fc5ae0a883a2e6f4094ec024085 Mon Sep 17 00:00:00 2001
>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>> Date: Fri, 21 Jan 2022 17:33:10 +0100
>>>> Subject: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
>>>>
>>>> This patch adds a new work function, which will get scheduled
>>>> in event of a GPU reset, and will send a uevent to indicate the same.
>>>> The userspace can do some post-processing work like collecting data
>>>> from a trace event.
>>>>
>>>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
>>>>  2 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 269437b01328..79192f43bb71 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1057,6 +1057,8 @@ struct amdgpu_device {
>>>>      struct work_struct        xgmi_reset_work;
>>>>      struct list_head        reset_list;
>>>>
>>>> +    struct work_struct        gpu_reset_work;
>>>
>>> This needs a different name. "gpu_reset_work" would indicate that it 
>>> does the GPU reset, but this really only signals the reset to userspace.
>>>
>> Agree, let me come back with something like gpu_reset_housekeeping or 
>> something less weird that that :)
> 
> How about send_gpu_reset_signal ?

Yes, sure, that is exactly what is is supposed to do. I will accommodate 
this in next version.
- Shashank

> 
> Christian.
> 
>>
>>> Christian.
>>>
>>>> +
>>>>      long                gfx_timeout;
>>>>      long                sdma_timeout;
>>>>      long                video_timeout;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index af9bdf16eefd..e29e58240869 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -72,6 +72,7 @@
>>>>  #include <linux/pm_runtime.h>
>>>>
>>>>  #include <drm/drm_drv.h>
>>>> +#include <drm/drm_sysfs.h>
>>>>
>>>>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>>> @@ -3274,6 +3275,18 @@ bool amdgpu_device_has_dc_support(struct 
>>>> amdgpu_device *adev)
>>>>      return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>>>  }
>>>>
>>>> +static void amdgpu_device_gpu_reset_func(struct work_struct *__work)
>>>> +{
>>>> +    struct amdgpu_device *adev =
>>>> +        container_of(__work, struct amdgpu_device, gpu_reset_work);
>>>> +
>>>> +    /*
>>>> +     * Inform userspace that a GPU reset happened, and it should 
>>>> collect
>>>> +     * data from the trace event.
>>>> +     */
>>>> +    drm_sysfs_gpu_reset_event(&adev->ddev);
>>>> +}
>>>> +
>>>>  static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>>>  {
>>>>      struct amdgpu_device *adev =
>>>> @@ -3506,6 +3519,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>                amdgpu_device_delay_enable_gfx_off);
>>>>
>>>>      INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>>> +    INIT_WORK(&adev->gpu_reset_work, amdgpu_device_gpu_reset_func);
>>>>
>>>>      adev->gfx.gfx_off_req_count = 1;
>>>>      adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>>
> 
