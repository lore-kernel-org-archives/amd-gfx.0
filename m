Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF0CCD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 09:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB0111312B;
	Mon,  1 Jun 2026 09:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wXYKKMB";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA6F11312A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 09:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+yeEgWU5aNc30HxrJdKeMhHeNZzJWRXVEQybRASeWKuDDoMd0e+zOKMGAQlxstNSWuGvRcSLn8fHNTUlLvjjv+6tF05Fnl3JQygUNHG/Iure5ZHCh/I8bwcgmMQHd4y5PDo8WkCj3NAQhrceuuWZHxH5nXp/hxEi2JpApNxlBkcbY467cg5STHJ1r0xDpLy8JsZNB1kpTHDJdpemciHcFPMb8UyBXaG79K6KzRxOh+Z406BV1oSN5KuH03FhjDi6vc/cFwDldvGkx6vTNPhRiRGJqtkQmZhDVlzZatn3l7M0S+ckDT3JrYVtK9S2Jrstm5WLbqT9zh6hP/kvfVEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y5elT8JO6gy8YKZnjGBXlayYYPJ5jv4EnkACevO6to=;
 b=Px2kJlmaQoynqkI3y2u/mW1jE+yMdGm0MnSkzuz5p5u9NOhpOfQSWO/CREY4614Yj9elSpCEeJbCoV8mPm2UYzoi0E0yiz+vqe380blKIrZPHODsaHPqOLOOdWw/jJ8D80tgt2cTdPJKuINopoorlDgJGY56zovyZMCVpbQIBhqpuGRW+j//5KU8glo5e1l8dUYnUSTSef1IWo5HsNaESFmcOi+vElqGyhWbefZRBDGmVHspcXHhvl0NSDCiv9fQO10bS+TqSBhO3iGaLIrHh6cl2ThcsSTiYlVkCySosOTP/EbH+Nixoiz2TuWkGPBUelEU2j1H/8ScL4217RDFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y5elT8JO6gy8YKZnjGBXlayYYPJ5jv4EnkACevO6to=;
 b=3wXYKKMB3+iJe2DuoGxhFkdsfR1ZWthFZ+8FYQ9iVxTN7TkM8VT4k/uExnqGE3hNTxheehDWYDCtd+Vr//SJJDeX3/TbO6Gyf2hQ++9xMcmZ2ONcc1DbOVHwwgwTpzvtDHckTjzePmMklJzcLQPxthYT24D0JLXdmUhqOyYswSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 09:57:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 09:57:36 +0000
Message-ID: <e1adcfe9-9ea7-41d8-afee-eebdc5347d1f@amd.com>
Date: Mon, 1 Jun 2026 15:27:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260529155425.418803-1-asad.kamal@amd.com>
 <DM6PR12MB2972E0714BA89B7B178CDB2882152@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972E0714BA89B7B178CDB2882152@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 635ae53e-9d78-4299-b5d0-08debfc43548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: kcsLQsKdgLy8YLxM8J4sMM9h7s2Qrx9IwXbDWsDjPVBFfoDwHS/TDJ1po7q5S3dGgx0t/pROMYahPvZkvvZ73Q1g8LiHItdlJFYDJhjOuLB5RxBu785VIAQdTRPcv5ds+59F04M+q+MODso0JINmu0IgVrA3MDT8y1E1pLd0bR9E8LYQf4cqpJonFBPVdIQ8O4sIQGpeuv+jY9Trk9yTSvfj0p9V0JRGNobK8/Nlo70IFO4+O3usO9A+XN4Bk0M0yflL76nkqk4aZDWuvS5JmxtLpSviq6BV1yZTYIbUq1ifKMi9Yt+aJ17yuzC1B/Rld6McYm9wLnVfCJAgLH8voP/sMl0aQpIcrTpcyrdAg8T75N1/D0P/joAuPyxG8tUU5Czcml4lrs8d7FDpk9Hlh12Dn8DGQ+Lcldl+ic0S3oINc5/TRFJkKq+o1H3mmAbyW1pYFTq2JB/OBisNs6cakI4QiR0fBCGoD+iUYoOf7YYWwNuwgR7i4qYdMmQlIOGz+EIR7qpFfVMP7eoCcWmMrgRa5gU2f4T5zMc20U5vFiugr0sjWevREmfoQvRVPFMTyEIOBnKGocd1h/Ae3rkUWFi2nomKHHrANWN3h5dpcRj2J2/SnaU+suak8NNkN6ZFeWbEFFZJ1V+Pc6n+SHTwswvREh2CMsowZbBiz296997T3Sbyn/XgdHC2fO0nRNu9+dbuPmTpI8fbZ/6QLA6yUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjF0b1piY3Z5NDU0TnVBR0ZqeVB6dlMrMks0dFFhNzVRZFE1MFF6ckFESndi?=
 =?utf-8?B?NUk1NTZkRFo0WGV1TDJKdkhyU1JDTFZyZHdkN0JrL2o1OGlVZGpYSTFyZ3NF?=
 =?utf-8?B?akRpbjJhUGVqN2hwN1pscktSSHgyczN0S3lmeGl2MG9SSUlPMVZzTkZ0TkRp?=
 =?utf-8?B?MnMxU0t2MkFtcjU2OFg1S29XU1l2NXYwNTNHVmh6eS9ValF2eTZmUy96d0VX?=
 =?utf-8?B?aHRvZm1TSnFsZW9ZR0Jicnc5QWJONVlsTHc5dkZQOTFHMzdPbjlRVHRPM1gx?=
 =?utf-8?B?VFJMMHl1andpUUM5UmxoRUdSTEt1dEZoMHZCRVdMbmJ3WW9TZXJ4WVNLdzFR?=
 =?utf-8?B?TWg2cUFCMXNqcmpRWXZMS3ZqVXJvaUQ3cm9uaDI2YUpCTG5KeC9OdjlXY2ts?=
 =?utf-8?B?bktkOHkwbTY4ME5aVk1rcDYwQ1lYamd4Syt2NzMyeXJxMHpiZmZDYVIyMHls?=
 =?utf-8?B?RmRMU3YvdFYzRUFOcGhVV1NEZGxOQWFycURFSWYxZi9DNDNNQk9wU08wWElr?=
 =?utf-8?B?MVV6d3BqS0lBVnhoaWNEUFZqUHNLenZsV0lKdDNwS1doWHR4U1hVT2UwZEJR?=
 =?utf-8?B?N0FPUjV0Wk5iYlpzRHIreHhjci82UFhSR2grZWVaN2NIU0Q2ZFFVZ0puTXlV?=
 =?utf-8?B?R2lRTUtkQ3h5Y1F6cUNybFV0bG8weEtKT3ROR1hPSGFqbktMRlNtMGJFSXFr?=
 =?utf-8?B?M3ZtcHdPOWNHbUpJR3JKZWxOMjBSMkhPNmZHai9ub055MG5xdkdvTWcxeXNh?=
 =?utf-8?B?ak5xcnBUaDA2L2JJenN6RE9kOExXbE1MUTFsOGJNN25qMnlOL0IrV25BeXZK?=
 =?utf-8?B?Q2EvZ1I4OXJsN2YzbFpMN0lLSTFUNE9sUUNaSlRvSXFwcHdLeEpqb3hLRG9O?=
 =?utf-8?B?L01ZTEZLU1NQOVpscG10ZXNGTENLb0trN281RHNwRW5UMXg3L3N3MzhjQ2NK?=
 =?utf-8?B?STYvcEUvREd3NXBpOVltVzZ5aE9vRlgxZjN6dEVtdXp5UEY1Zk12N1o5UUJs?=
 =?utf-8?B?OHVWVFNhL2xWd1poWml6QWFmeTA2SWJxVmhvRW1Gam4xc3RpNldlbktIa1lq?=
 =?utf-8?B?QU1YamZqdVlHU1N2WXEzVkt6U0VaSjlsMURtUVFDbmFySStDb1RqbkdrbEkz?=
 =?utf-8?B?Z1A0MVBtR0ZCakN5Uzg2N1lLMEhjRTVlMlkvbEt4NTRUN0pDSE5LSDBkcG5E?=
 =?utf-8?B?VFkrMjRjZTNQT3djc25RR0dPM1d3QWxsUGt0NnVDOEsrYWJKN1BVTHVNRGx4?=
 =?utf-8?B?bDFJZEJFOVpDMENXMmpVTmV4NmxxMFZONW9SMDVTV2FBemtnYlh5WjhKR3Ba?=
 =?utf-8?B?ZGNhMHFTMnpIRDJJbmhBVzR2WWl0VDM2RFk3aUVoRlZSWGdxTmp6Q3lybXVx?=
 =?utf-8?B?Vm4yZnpUZzlHc0lJN0h6bHA4YnlVemRieVFURUF4TWNBVWdUUUNrUXR2QUtq?=
 =?utf-8?B?dG1VNHFEVW1hTmdzL1hYRTBmbXVHSFM5dnRyaTZvUm5aUDJ3b0Z5NCttRWJG?=
 =?utf-8?B?WFllQjJRdTVQZXR3T3lpNmdubTAzM1BadzZudmhFUzhiaUFabkxueWw2TnNx?=
 =?utf-8?B?dEZLc25LWFdyRUdjVHp5cU9yUW83SEg4TkxDKzVRdkRmejlqb3NSWEgzTnpp?=
 =?utf-8?B?NTgvK0krS3o3V2RYWGxnYnp3cmc4V1VRK1VzRVRTRDdzMldvODZaYmpURXBS?=
 =?utf-8?B?YlhuUW5QNytBS2FJMjBzWVA5MTN1VUpMSGs0QTkwdUZpRXNJUW85eUZtU0Q5?=
 =?utf-8?B?a213a1pHblI5Y290MVdIcnVMd3gxWlJNTGhYcThmUUFBUFJxbWw1VG5YUnJk?=
 =?utf-8?B?Y21wWmx2RDh6R0J3T1Jlck1CenRES2RnemJ5UzE4TjBTNnZNdC9lZ0NVU2JU?=
 =?utf-8?B?U2tGQ3F6NVN2R3d0eE1zM1VPQkxrTWtUS1dDam9EZXVyMDdqNHM3cXMza2JR?=
 =?utf-8?B?L3NmV0VZWk1jamNQcDdvVnlpNkxsT0l1ODBnamYxMmtQSVBLU2JpMGJueUo3?=
 =?utf-8?B?R0VIR2JXclBhbTNmQVptU3ZlaG9JVjF6d1pPUWh1anJYTlpTRzZyN1JHdnpZ?=
 =?utf-8?B?Zi91bTZSUW43VXFsSlhQM2hKUHFEVkluTFpqeHdaWkVxZFh0VWRtaTVKVmpH?=
 =?utf-8?B?dktzazFzVzFySjRtRVo5VWNxaXo3V3V3ckdGVHJHeFQ0dVgyUUJhcmo4L0Ji?=
 =?utf-8?B?cTJrenZRdS9lMzZVYkY4WThSeG1mRmYxQnVmalR5UWlHKzdvcEEyN3RFaFh3?=
 =?utf-8?B?VnpsUHVYdVF6MXBrTlorQVJlZGFvWStBc0cvTVdNS3p2dDFHTTVEczNSTnNI?=
 =?utf-8?Q?8fDBKZHNk+Jfn90o2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635ae53e-9d78-4299-b5d0-08debfc43548
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:57:36.5357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SF2G5OXp0CTsJA8xIkWdDGg4SP4BGTtfBNiIKBXRWSfG8y9KRYUy+VfseQjrH/IC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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



On 01-Jun-26 1:15 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> Hi Asad,
> 
> Your patch doesn't seem to resolve the issue you're facing; I  think the correct logic should check the return value and the size variable
> What's your opinion?

I think stop printing if buffer is full seems sufficient.

The expectation is that size out param shouldn't be updated if the 
function returns failure.

Thanks,
Lijo

> 
> Here is the pseudocode:
> ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
> if (ret < 0) {
>      continue; // for next clock item.
> } else if (ret == 0) {
>      // Check ret and size/PAGE_SIZE here to meet the requirements
> } else {
>   // go out to return.
> }
> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: Kamal, Asad <Asad.Kamal@amd.com>
>> Sent: Friday, May 29, 2026 11:54 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
>> <Shiwu.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
>>
>> Stop appending OD sections in amdgpu_get_pp_od_clk_voltage() once the
>> sysfs page is full, instead of checking every
>> sysfs_emit_at() in SMU helpers
>>
>> v2: Drop the prior series that checked sysfs_emit_at() return values in every
>> SMU *_emit_clk_levels() helper and smu_cmn_print_*().
>> (Kevin)
>>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 60db9b66d08c..03c95621fe2c 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -866,11 +866,15 @@ static ssize_t
>> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>        if (ret)
>>                return ret;
>>
>> -     for (clk_index = 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_index++) {
>> +     for (clk_index = 0; clk_index < ARRAY_SIZE(od_clocks); clk_index++) {
>> +             if (size >= PAGE_SIZE)
>> +                     break;
>>                amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index],
>> buf, &size);
>>        }
>>
>> -     if (size == 0)
>> +     if (size >= PAGE_SIZE)
>> +             size = PAGE_SIZE;
>> +     else if (size == 0)
>>                size = sysfs_emit(buf, "\n");
>>
>>        amdgpu_pm_put_access(adev);
>> @@ -3915,12 +3919,17 @@ static int amdgpu_retrieve_od_settings(struct
>> amdgpu_device *adev,
>>        if (ret)
>>                return ret;
>>
>> +     if (size >= PAGE_SIZE)
>> +             goto out_pm_put;
>> +
>>        ret = amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
>>        if (ret) {
>>                size = ret;
>>                goto out_pm_put;
>>        }
>> -     if (size == 0)
>> +     if (size >= PAGE_SIZE)
>> +             size = PAGE_SIZE;
>> +     else if (size == 0)
>>                size = sysfs_emit(buf, "\n");
>>
>>   out_pm_put:
>> --
>> 2.46.0
> 

