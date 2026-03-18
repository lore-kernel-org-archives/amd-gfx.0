Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE15FCD0BE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 06:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89BD10E042;
	Wed, 18 Mar 2026 06:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ChzCnDDs";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A967C10E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 06:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBhLYBuxTv/3sTYTDke2nrz4pQfQwZSCbgZoZZqruZr3hkHg/zn5WdDKKJ8ybpnHkF1OvwgY/GH1yaRnvpY9yVgR8Hay/Ff6QB7ao3yZX9iPWs932z/IHrcz1rLPbIoP2ejAtFswJZaEeHav7I9wd+4s8sDF9dt/8oGoiI7nbshCOqGMCO/DKZ2KNH6Bi2Ok/D3WXGiB9zfEFwtqK1UJfRSviTvsF74Zgf2OEqejfew0GWoYNEfFkkcaJA4roY3Bjh5Y+6s55+QKPSFYajxwjeHECh+jHQFSjXfvq1UXubLgndZE6zqJdQRMcEFHyqb7RI3TspGPFQsP78CEpHFM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO2qvKWTtMItx/hmBPd+y6H7tTd0E6YVNWgw/x1bRdQ=;
 b=chQtr8hkCVS7MzKuPuWIc+QdhAg7z4gFAloJKgDuBbp073qPT+LjsiUavVLLs2IcFHplmqhFYlFRQjNxSa7YW3MShPXm9fKyJiCk7hGzzGMVbFS5WEWfFPTfTTuSqmbFZ0APSJRAY6HLJFJycB1hZIe7Mu44Kd/PkJzlKu3tAbl9VzkB9+cyRy1g3Wui3MnIzefqeuGTEy8IpzkhpjkQfvc81KSSaeTVApZ2IfHH45GA+KMbV1JTP16Azok9nXSfLtxbOACNqIAyAHev/wQTYZ8VVAUcKGH3Owv94byqLYVw7wW2R5Oq1ltlS515kufrSOqjU6C5ahyjuGJfHEYAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO2qvKWTtMItx/hmBPd+y6H7tTd0E6YVNWgw/x1bRdQ=;
 b=ChzCnDDsO3I3zyFqCN51XY5Sd1LBhKK5gHnNKSi4vQYbf0iDFVze5VtwUG7ZR9FpJqV+Fw5FkX1NxsOhNKnvg/hX0rPn0KYntzDGdWvaRF4QLbrflJ3H8zYuw/sC3xcYPhWPc0GPJMkponK17buqMsdOGT2NVQW3nB/P/Wy+9Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:21:40 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::2bc0:451f:661a:ac32]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::2bc0:451f:661a:ac32%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:21:39 +0000
Message-ID: <55186bf9-5204-497e-8bb9-05c74074d080@amd.com>
Date: Wed, 18 Mar 2026 14:21:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>,
 "Li, King" <King.Li@amd.com>
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
 <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
 <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
 <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
 <8a9ffdb8-d76a-43e7-ad3a-3b0f45d04b1b@amd.com>
 <6d411b13-880e-4f7d-ad23-1c94073bb0a3@amd.com>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <6d411b13-880e-4f7d-ad23-1c94073bb0a3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To LV9PR12MB9829.namprd12.prod.outlook.com
 (2603:10b6:408:2eb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a6d171-fe22-456a-35e5-08de84b69d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tcw2xzdOQ0ghR8+HnLNVouCohIxd9W2SLGZH4woxaeu7DoWr/Bl1XOP2w9ywhiSFx2Hp4BTXfyI2b8c4Q2kJZ9HCWLmc700p5AhROR2YQhuqjVMlcwVTTTyR4hL7WHXfujI+MtOVAhrERajgry0Lb93lMXvjOhe3ogHj5WB3hVAZUwq4AXeP5UXlS65x8VYbnqSV+3WDxRVP89199zYQDN76v6uHIN6LSeA6NmRtNRVO9Kn4X6h3BcvZZpkqwMkY1WQ9aCogGRBr7rwF4TEynG9vTXg9nrIPwR63k8eOIhDknurQmdVhNUbU3r6UFy5mvZRE+7QT3WP8Vi6mgNvg45OViM90SwrIEcdoAo9gPNHJle7FmH4u/EudcoDvM0VnPD/OHlnGQZdJPXxDQK7JNBP4Hji695wkOaHhI1jb4BW6w3du1XMeikM2K5ubMbvpCqcygxbyoGNdwxqVOmhGiyl2pgdWSgC8T4CFUATwbn2j5NIEHXL+x9Q4JKFazaDkrreRQAGLyvzGh7d2kpRSvrxmp3NUOpJGdS1AZdRhBxWyc/I57KlmwonVOKzicyUOcq9oQl2CbRHFH7p8gpmU9nbCSeJqUOXLvq/1DRsWNJoRItsHDqwRRxQ3EMEZoUuoZdnQ3mp0jNzOADaEBDZvIJ/jsP4jxtNOU85Vaz0bu8kY9obNKQBDz6Crpeds2njpzDEzgODHlgWTSq0mXGibGdyssBf/G3mY+LJhI6lltpQkFR74m+BCI5McsqZ+WXALdtrjs4TZp8wfV7CBOyC0179x/PpzGXBX8D6jGxwIDgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV9PR12MB9829.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJRVUJyMy9QYitCQVNGbzE2YWN5VlplYmJlckY4RXVjaUtlUWd1ZlhTUGlS?=
 =?utf-8?B?WDU0UytvUW01UFd0L3UzMU0yc044OFNoRFJ2NEV2dmdramN0NUpabjhLQlVi?=
 =?utf-8?B?clZISkoyaVh3VzRBQXpTN1BwZEFGL1hWOFRQekdNcTY5RHpwTWlGdHpwR3p3?=
 =?utf-8?B?cXZyQzNOc0d6UkR0UXQ4NkJrWVk5cjlXemZpeGsvVHJwTTAvRm5KWlFnMHVP?=
 =?utf-8?B?RUl0Sm1HZktKZjFsVHgxMGViUU1OT3pDOW5lbUt6STVOeXlwMGtsV0Jod0VY?=
 =?utf-8?B?Q0wyczM1dmR6RXMwYmUzSUpkN3FnUEE5aWNvQlliM3pZbDVXLzdhZXRyNG5D?=
 =?utf-8?B?enVNK2szZ1pWTGtQRW5Gem1mMTRiLy9uVGdtanl6OTFXT3MvdG4zakl2SEk1?=
 =?utf-8?B?c1N1NkdMTDRSN2dOVnNUTXI1Rzcxb25pSXYwS29FQU1rN2s4MXVieDBGc3Rw?=
 =?utf-8?B?c2RVQlUxNElEK3ZwcGJiTGY4T01FNjh1RUdpSDBqR2hqenU2czMxVkRBeHZq?=
 =?utf-8?B?VDREYmI1T0d0MnhmczYzc0xtUGdsd3JnMnZvTkcrQjJ2NFdrU3Z4NkZ4OFAz?=
 =?utf-8?B?Z1Jsc25hN3pONG5JSXR2MVFlTjI4QjVtLzdyMFhwcHNmVTM4MVRLY3lEWk1D?=
 =?utf-8?B?c1ZCdGtleFNwR2ZtcGZhc05CdHFkT3BJRnd1MWlHZEJuSGhJdEVnekgwWnlN?=
 =?utf-8?B?dFlMUk9qcmRMbG52M3pzcFQvaG9RdlBPS1JOV0E5YUFQSURkUWptUDdpbjI1?=
 =?utf-8?B?ZUNZRjZtd3FVTTlNb1NYcXQ4ZWs4b1FKdmZGSUlzRyszMDFnZ3I5MEhYaDl3?=
 =?utf-8?B?Vmc4LzVjMWpHZDhTbXFLeWtnMHFWL1MxU0p1UUNDbUZrVlBZMXAwanFSaEtZ?=
 =?utf-8?B?UHp3M0hPUDlqRkZtM0xLaFowZ1VzN2RIYW5HNjJ1Ly9VbklsQWRram55am14?=
 =?utf-8?B?cDVSS1dTOTZQb3lNSVBPUHUzTzl5bG9OZmlPSUJkUXJHelluQ1RlYWtkSlow?=
 =?utf-8?B?RVZWM3F6ajV4M0tNOHIvTTVYaHBubkkveUc1Wm5ITTN3dVY2Qm5CUWZIZlp5?=
 =?utf-8?B?T1hjaldnTHRnaUdOdVlCcmJPQnRXOHNtbVMrMVFiZ3NDSURZRXdLYzUwck9Q?=
 =?utf-8?B?RXFnVm1VTytKak5qWmRkQXJMYlMyOTgxVTlYKytUaFJuY09jZTNhdHZ3aGJK?=
 =?utf-8?B?NUhnNlFkWkd4T3Nua093eHRMRlVEYXJZc1RNcjhzY2hKY3RsVW5MclRpREpH?=
 =?utf-8?B?ZzdHY0VvTkJqTWN1cEtOYUdrbnhSMHFTVXg1WmVCQlJLNHRBNHpZWWNOV1k4?=
 =?utf-8?B?bjhDV1A3T1NTR2FzaEJUNzAyNEdOTlk2RjRSWkcrY3B5ZkF4b0NObjdjVkhU?=
 =?utf-8?B?K2tEQUhJVnRXbEVsa1JSTmpjUzZEOS9LLzlBN2JMbnlrYk5ZTmJpQVZkS3RM?=
 =?utf-8?B?QzB3NmpoZlFrd3NXN0paMWlDUEhhSG5ON09sQ0ZIZi9TQ1Z0RVFxd3hRa3RO?=
 =?utf-8?B?emI1aHN1MjJiaUlPdll4MlBUZHJqQzQvQWhuREp3NEVXcHJVZFczSE5zRGgw?=
 =?utf-8?B?UHV2RTVWanhON3JRazRDd0M0OWtwNlN0UGZKY2h3Ni91UlJtNkY5VnFIelgz?=
 =?utf-8?B?ZEZ2bWhtbzZScmxuQjJEOTVoOERLY1hVOUI1VkJpa1MwRUZlbGREZVdlVldZ?=
 =?utf-8?B?aVkxc1ltRUVnam15R0FaNkJ3T201VlhXdDVZQXFCcXpxQklXQk1lV0RpMnVG?=
 =?utf-8?B?cTlxZStrV040a2wzZGtGanhFSkdwdjVQRmIvWjhYbmtPcnFHU0FmOXZPY3Fh?=
 =?utf-8?B?S1kyT3lIZDJzdzlKWXo3VkgreUtoNm5yVVN4cG5kc1BoQm16T3VsVDJqeFl1?=
 =?utf-8?B?dnNtc0cwYnRmVFVUS1JJalM0ZGpPTnEvUnNDcFVOckxON3ZZc1RaN1dPNVVq?=
 =?utf-8?B?UkhJYW4zVHZyejA4eWV3QURaNUxhUnhyVGJFcmM0UlMwS3VQYjZqRnE4Tzlt?=
 =?utf-8?B?RlhSZG1ESU5XOTRqTXFkbWRFWXNCSDRkZWh0Smc2OWQwUnhDUnZlaXVPS29J?=
 =?utf-8?B?ZUFUQnlEaXlsZlNJSndPK1JtTUcrdVZQU1BheVFRL0VWLzgzaUxKUWNWMVNz?=
 =?utf-8?B?cndoN2JyaVBkY1BwVmlGL1VCUzBMUEMxWnR1NVBQUE00anBHRWkzN2MyNEpQ?=
 =?utf-8?B?QmtTY1pMOVZYV3FoN00yTkxhYU1nVnBiQ2t6Snc1dFRIRDRmcHhaK1V0NjdP?=
 =?utf-8?B?MVhrdWxWN05kZysveUhIdGIra2MveVNNQ2lrcVBOMjNwVTc3MUZlMjYyM051?=
 =?utf-8?Q?2a0p0g+46sZFG/xrF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a6d171-fe22-456a-35e5-08de84b69d58
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:21:39.4782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiTnZdZohRIfVjlPih6n3Fsjew3TCEqDWjyaUo97u3IkKnrFX09MTPxGZnJ63D55
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

Many thanks, Pratap, after verification, your patch resolves the AMD ISP 
driver auto-load issue.

Hi Rafael,

Would you please check if Pratap's patch is acceptable since it does 
some modification to your merged patch originally from 
https://lore.kernel.org/all/5081593.31r3eYUQgx@rafael.j.wysocki/


On 3/18/2026 12:03 PM, Nirujogi, Pratap wrote:
> Hi Bin,
> 
> Could you please review the below patch that was submitted to address 
> the automatic modprobe issue.
> 
> https://lore.kernel.org/all/20260318034842.1216536-1- 
> pratap.nirujogi@amd.com/
> 
> Thanks,
> Pratap
> 
> On 3/13/2026 7:49 AM, Du, Bin wrote:
>> Hi Pratap,
>>
>> FYI, the following patch may resolve the AMD ISP driver not auto- 
>> loading issue (without using MODULE_SOFTDEP). Please double check.
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/ 
>> drm/ amd/amdgpu/amdgpu_drv.c
>> index 920595f0d22c..95d26f086d54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3212,4 +3212,3 @@ module_exit(amdgpu_exit);
>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>   MODULE_LICENSE("GPL and additional rights");
>> -MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl- 
>> amdisp");
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/ amd/amdgpu/isp_v4_1_1.c
>> index 485ecdec9618..409c1ca5a5e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -118,6 +118,29 @@ static int isp_set_performance_state(struct 
>> generic_pm_domain *genpd,
>>          return 0;
>>   }
>>
>> +/*
>> + * MFD core sets the parent GPU's ACPI companion (LNXVIDEO) on each
>> + * child, giving them modalias "acpi:LNXVIDEO:" instead of
>> + * "platform:<name>".  Clear it and retrigger the uevent so udev
>> + * sees the correct platform modalias for module autoloading.
>> + */
>> +static int isp_clear_acpi_fwnode(struct device *dev, void *data)
>> +{
>> +       struct platform_device *pdev;
>> +
>> +       if (!dev->type || !dev->type->name ||
>> +           strcmp(dev->type->name, "mfd_device"))
>> +               return 0;
>> +
>> +       pdev = to_platform_device(dev);
>> +       if (pdev->mfd_cell) {
>> +               device_set_node(dev, NULL);
>> +               kobject_uevent(&dev->kobj, KOBJ_ADD);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int isp_genpd_add_device(struct device *dev, void *data)
>>   {
>>          struct generic_pm_domain *gpd = data;
>> @@ -375,6 +398,13 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp 
>> *isp)
>>                  goto failure;
>>          }
>>
>> +       /*
>> +        * MFD core sets the parent GPU's ACPI companion (LNXVIDEO) on
>> +        * each child, giving them modalias "acpi:LNXVIDEO:" instead of
>> +        * "platform:<name>". Clear it so udev matches by platform alias.
>> +        */
>> +       device_for_each_child(isp->parent, NULL, isp_clear_acpi_fwnode);
>> +
>>          return 0;
>>
>>   failure:
>>
>>> -----Original Message-----
>>> From: Nirujogi, Pratap <Pratap.Nirujogi@amd.com>
>>> Sent: Wednesday, March 11, 2026 11:29 PM
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Nirujogi, Pratap
>>> <Pratap.Nirujogi@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,
>>> Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>
>>> Cc: rafael.j.wysocki@intel.com; Chan, Benjamin (Koon Pan)
>>> <Benjamin.Chan@amd.com>; Du, Bin <Bin.Du@amd.com>; Li, King
>>> <King.Li@amd.com>
>>> Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in 
>>> kernel v7.0
>>>
>>>
>>>
>>> On 3/11/2026 1:26 AM, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 3/10/2026 5:52 PM, Nirujogi, Pratap wrote:
>>>>>
>>>>>
>>>>> On 3/9/2026 5:58 PM, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>>>>>>> Add NULL pointer checks for dev->type before accessing
>>>>>>> dev->type->name in ISP genpd add/remove functions to
>>>>>>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure ISP
>>>>>>> driver dependencies are loaded in correct order.
>>>>>>>
>>>>>>> The regression was introduced in kernel v7.0 where MFD ISP device
>>>>>>> enumeration doesn't complete by the time it is added to gendp. The
>>>>>>> timing of ISP device enumeration has changed because of the changes
>>>>>>> in registering the device sources in the device hierarchy.
>>>>>>
>>>>>> It's a little bit pedantic; but I /think/ there are two different
>>>>>> problems here with two different root causes that both happened in
>>>>>> 7.0-rc.
>>>>>>
>>>>>> As a consequence I think you should have this split out as two
>>>>>> separate patches in a series linked to a Fixes tag with the reason
>>>>>> for each of them.
>>>>>>
>>>>> Hi Mario,
>>>>>
>>>>> Few things to clarify before I split into 2 patches and submit v2.
>>>>>
>>>>> - Yes, you are correct, the changes in this patch are not directly
>>>>> related to the Fixes tag 02c057ddefef mentioned. But since it has the
>>>>> dependency on the below patch for automatic modprobe of isp to work,
>>>>> I have used the same tag to cover the dependency. My apologies if
>>>>> this approach is incorrect and misleading.
>>>>>
>>>>> https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/
>>>>>
>>>>> - NULL dereferencing issue with dev->type observed on v7.0 is
>>>>> specific to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As
>>>>> the wakeup sources are registered using physical device instead of
>>>>> ACPI device, wakeup source device (wakeup14) is added as the first
>>>>> child of AMDGPU device; and since its dev->type is not initialized
>>>>> properly it has resulted in segfault.
>>>>
>>>> Sure this makes sense and is a no brainer to get in.  I would just
>>>> send this one right now and we can keep noodling on MODULE_SOFTDEP
>>>> (more comments below).
>>>>
>>> thanks, I’ll go ahead and send this one out now and will submit the
>>> MODULE_SOFTDEP change separately after the root cause is identified 
>>> ( more
>>> details below ).
>>>
>>>>>
>>>>> In 6.19-rc4 or earlier versions, this issue was not observed as the
>>>>> wakeup source device was never part of AMDGPU children list.
>>>>>
>>>>> For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 
>>>>> in v2.
>>>>>
>>>>> - MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic
>>>>> modprobe of isp (and other amdgpu mfd child devices) to work in v7.0.
>>>>> But couldn't identify the specific commit in v7.0 that is causing the
>>>>> issue. I can confirm it is not because of commit 057edc58aa59 as the
>>>>> automatic modprobe doesn't work even on reverting this commit. Can I
>>>>> submit this as the fix needed for isp probe to work in v7.0 without
>>>>> the fixes tag?
>>>>>
>>>>
>>>> MODULE_SOFTDEP is generally for ordering, but I don't think you have
>>>> an issue with those modules loading before amdgpu do you?  I'm not
>>>> really following why the modaliases stopped working and I'm a bit
>>>> worried that it's papering over a more nuanced issue still.
>>>>
>>> yes, this explicit load‑order dependency was not required earlier. I 
>>> agree that
>>> the regression point is not clearly identified. I will identify the 
>>> bisected commit
>>> and submit the patch later.
>>>
>>>> To identify the root cause, it might be helpful to do a bisect,
>>>> although it's a bit complicated.
>>>> 1) At any point that has that platform driver conversion you need to
>>>> either revert or add the change to auxillary
>>>> 2) At any point that has 057edc58aa5926d63840c7f30afe0953d3994fa3 you
>>>> need to apply the NULL pointer derf fix
>>>> 3) At any point that has the changes in linux-media for API
>>>> adjustments in 7.0 you'll need to pick what version of ISP series to 
>>>> apply.
>>>>
>>> I tried #1, #2 and few other combinations, but none of them helped. I 
>>> will
>>> investigate further to identify the commit causing the issue.
>>>>
>>>>> Thanks,
>>>>> Pratap
>>>>>
>>>>>>>
>>>>>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>>>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform
>>>>>>> one")
>>>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>>>>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/
>>>>>>> drm/amd/amdgpu/amdgpu_drv.c index 95d26f086d545..920595f0d22ca
>>>>>>> 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>>>>>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>>>   MODULE_LICENSE("GPL and additional rights");
>>>>>>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp
>>>>>>> pinctrl- amdisp");
>>>>>>> \ No newline at end of file
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/
>>>>>>> drm/amd/amdgpu/isp_v4_1_1.c index b3590b33cab9e..485ecdec96184
>>>>>>> 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>>>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device
>>>>>>> *dev, void *data)
>>>>>>>       if (!pdev)
>>>>>>>           return -EINVAL;
>>>>>>> -    if (!dev->type->name) {
>>>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>>>>>>           goto exit;
>>>>>>>       }
>>>>>>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct
>>>>>>> device *dev, void *data)
>>>>>>>       if (!pdev)
>>>>>>>           return -EINVAL;
>>>>>>> -    if (!dev->type->name) {
>>>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>>>>>>           goto exit;
>>>>>>>       }
>>>>>>
>>>>>>
>>>>>
>>>>
>>
>> Regards,
>> Bin
> 

-- 
Regards,
Bin

