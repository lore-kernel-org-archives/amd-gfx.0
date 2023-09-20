Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA3CE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0781B10E41D;
	Wed, 20 Sep 2023 03:00:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C4810E41D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMw/DGMkIOOjmJyIOZqI07pBo2n0EW6M5wU5iigSjI544MFMx9Qeot4z+uHgqwnaD12JhtdCe91kopKnMcIhNLwAg0aMgqrVwZCK2RuJ/dFLAxjfRwHj0+qC+sbpnJiX7By6nnPXQZUdY5oVzncIKJW2scP72I2S80d+8axAfL7tgGZ59ExphhOs0BZ9T2jxEjT5N4vbtVddFkoDanP+ACCDOQ5Ha7cXg4oM9aTnWJdLHnUe+9h3UvN/PiITt+RUZ04ohXsx8DEwRbpz+v4TvOL5ftyGUow3+U0kYoCPHfOGu+tMroq471u+NhY3UfzoBDMuVDbx7JzO9hXksRGNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7VZlNo335iGvX97p/MFnemsdVT4xEqyiaE2pEvZ5gY=;
 b=PRThBQkTQsEMx2AkjIsqwHjCW+ztMTKhXecvbkNnohPlSuOLzqprR93nbjsf0e9HhhRaJsX0rIyMO4c6VP2B28nUQ9Ygz/1dajMNaNnnt1NbhwSBN4YbHrVB8ODMhcpxPlZKdcI6Ou+1Yb/RXJhwcgpYSvzy6dLFpt8dEU+NIeeoEmMP11ppb51hT5xYnK2o/EtZgiLjNVo074aOqeLpai3Lc2VSCssInf/d6fiqyMOKrjJgDP44WFfRLFEpWlgTx9OqNH68++s4zO+o9BIQ+68NKEGWU5f75cZdEJCN5zmUmPD8R9/bXExOqnZyVKyAXpRjVGghkyq3BwXVSOnYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7VZlNo335iGvX97p/MFnemsdVT4xEqyiaE2pEvZ5gY=;
 b=0MdtyAZELdIw3DkSWLtXqApVr+apC7vdE7r/GS/kGdXlYguAGO0BvV1COuhq24wCoq/c5Lpjhp7pgv9w7JjGSGNk0jhEne52Rl7n4jx8AmD1WWOBUtrNWaqpIPFzwLCw+P6Mpd1H6TPsK4y0Kh3LXjsMwh71YRLEpBk0y+njEp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Wed, 20 Sep 2023 03:00:36 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 03:00:36 +0000
Message-ID: <429163f7-5a22-331e-4caf-697c9e73a78d@amd.com>
Date: Wed, 20 Sep 2023 11:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amd/pm: Add reset option for fan_curve on smu13_0_0
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
References: <20230911055350.3940534-1-Jun.Ma2@amd.com>
 <CADnq5_OXMm9aP0oXpqA2bpV+UcikuXbDcNjGs8JMD+i4nq4JvQ@mail.gmail.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_OXMm9aP0oXpqA2bpV+UcikuXbDcNjGs8JMD+i4nq4JvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: c8de68d8-798d-4c52-d0e0-08dbb985c322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpwIsUgCgSjVPC08+87FNgy5wl0gkzVw6CozgGHz5sN4dwRynI55iSj/Fm3xgiETvR3Vqtab+NBYUpw+YeNYI0jfdIGkLr6gmbR7HzsDgS+kMX9QIlkTNhyHVJ/LfBPV3Y+y1E+IrhGzmRj2tw0GKf4T1SAKbCjUpHIFcc0UdyQoSUcJtetvje6Nf/VwtSAVJeiTmXGi8LXEeImF7Qh+DZb+eR0B702WvWGnctCK61m6qoLtpX+K6GoZ0gdL0uDhEtThDSk52P+D3gxU99SJjqGMALDkoqHEogQpq/4/PT/st1C9YrO4Mm/ZA4vWEPiuq9ZYQOkppA5usO3eM5GFi9yYWVMlLSpHl1QMP5eCfRiv9PGxum5D8ZHQpf81+i4sjXw1L8Fqt83F0KsgbizieMjfL1sEX1Cc6Dt5Je2PnyOJUib8/qQhFV0KLOrcH+1RTBGdy+SNWb5AWJCxOjf6DcX4+8n85GNaeCOjazBlDVZ4+M44amKcMOPISbR6YvuNfxgTWxCBzoWvfbLR38+Mh5Ylm4cqjhtEDeA42grSHXrNFA7RhkBMLae3fFEW1mPVoDMD7V07VTq0EMGPQ0Wa/MrTcTi/eV5o8S/Ohj5olURnPzhZ4a671mi/ymDyfQeGKGKFUqm++zykRFNA3y9pLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(6506007)(6486002)(53546011)(6512007)(66946007)(36756003)(478600001)(110136005)(2906002)(31696002)(38100700002)(6666004)(6636002)(66476007)(316002)(66556008)(8676002)(4326008)(8936002)(2616005)(83380400001)(5660300002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ozRHkzWkY1Sm1yY3lXVDNRbjlzR3BMTUNTOVRVcFl1a0NPZTljcXZHbmsr?=
 =?utf-8?B?OXVNU05KTWF2bkdkWGVwUTcrNkpkYVhiRk5hdkIrUjZpVnZ0cG9CczdWMGFw?=
 =?utf-8?B?U25KYzY3Wk1HSmVvbjNxakprTThHSHEwenZubG1QQ1dXRGhOYy9McHBXOFln?=
 =?utf-8?B?T3I4V1JvTWRBK0kxRDAxQ2RHNHpvcFMvRVhFTjdqTXhFM2JsYVpVdndLSTJz?=
 =?utf-8?B?WU5aZUNGdEIwaUxxL3htZFdxNjBqaXQ0Q3lOeGtreUp0Nml1QlhieThzcVgz?=
 =?utf-8?B?elJPRlRuaDhLR0tZcWd4M1VVMkcvY3ZlWHFpR0V6K2MwdkttTUtocmNXVzJz?=
 =?utf-8?B?b0JSdm0xZURzaGl6VVo1bXBWcTltbDZCRU5lODlYRGxDSC9nUUFqMHRxODFS?=
 =?utf-8?B?MmNrY1o3L1h2dS9uK3FnR1FtSWJQazBreU5RTXdDZmFnSlFEeVU5ZFhOQXpa?=
 =?utf-8?B?blBsQnkyOEc4Z3VkczQ5U1NpUERpdURNV2ZodE83dGVXcXZ6U1hIT3lUM05x?=
 =?utf-8?B?djAwZU5PRU9JRHdVRjU2OTJRN3BPdDM0ckN6andZam82Yk5VY0t6VnZKQTNk?=
 =?utf-8?B?ZENxUUFNWGsyUDM2Q1VkOFBOOTNyNUZEdWZETGRVMmdXNXVRRjFkVm5vaG54?=
 =?utf-8?B?eXErSGJYNXRYdWQwQjBRRmJHWHBJSFV3bzNlL09ObCt1VHdEVWsxTUp5TW5t?=
 =?utf-8?B?MlpZSzhnc1pmVWFRK0lmVjhnZ2NOREtlOWxCKzhia2pxVUJ0RmRyc3RlMStw?=
 =?utf-8?B?WUZRRVk0NWppQkJVOEc3RmdoWDhteVpWNlJ2WnJ3REcyT1VKVy81UzBZVVhS?=
 =?utf-8?B?N3pxQ0VwNUFOeTdGNGxhWGdWa0JOTVFHUXVMTldPSll3MDVJbERkR2NRQlZi?=
 =?utf-8?B?MUF3emV6QjJReTNHZkZOYVZINFp1eUVTUFRNOGtjSk5rRlJ1OGFlbWY4OG9W?=
 =?utf-8?B?ZWtCenVRUU9tQ0Zwb25NYnNJVDk2K2w3N1M2cTE3TzV6YnpEb3NqZ1hZKy9p?=
 =?utf-8?B?ZS9rbmxwSmcvbGhXeFBUWXczWEhoT01veHBZbEFzaUFKSnJXbXRFdkt0UzhY?=
 =?utf-8?B?QjFLOCs3d3RGSkd6c3hKTlVEcjhFNzNCeVQ2SU5RaVBDN0VpS2htMkVoMEdT?=
 =?utf-8?B?MEE4aW00cTlLa2tybzJ5R0ZzelZEcEREMzRTUmlYL0lnd0h5dzEyTFdtb2F6?=
 =?utf-8?B?NUNlUlVWb3ZDZXhkMndUaDh3bVY5ZnhlS3pqeENiRXBKYWY5NWMvcFNTcENl?=
 =?utf-8?B?bTdiU3FneEErbEFDbmQyaEE2YlNnUzJLMmNMeW5rajZYZzlrUmpLd3FTSFhV?=
 =?utf-8?B?WWxSWHZucjYwMEhGdG1wMW11L0tYUEM2dlZmUXprRW1rbVErSSs3NXRITUtI?=
 =?utf-8?B?UHViSjVaRktWMG82MVFLVEVKeW8vblVwQytTUWxYenlFZXM4WitUY0VkWDl0?=
 =?utf-8?B?U0lUeWlaODdvWnFiZmhJQTZCM29hZTMyaFRLeklVb3p5Sml1Vk5oUlVjLzJu?=
 =?utf-8?B?WWhjQ3J1RWVPQ0h5c0hVMWR1dUtSSkJRZlJqN2ZBbDRIeHFjbEZUMkswZ0l0?=
 =?utf-8?B?Y0toUm92S0JuWUtUWTVUMysvOGlTam5MTXFJbjFyMVNFVGtGak9uUVRzS0tB?=
 =?utf-8?B?dFFLQ1RkSFp4eFpLZEdJbk8rT25wSG50RnZaMWxUS3dEcXA3NUNrMkFNaThP?=
 =?utf-8?B?UDU2ZXBzbFUrekl1ei81MWhUbDNSd3R0bm5NODJPUnhlNEF0ekhlYkV4L2tu?=
 =?utf-8?B?QnFYS3JHQ2tRNVlYdnQzbGtpbnBqWTNXeU1uZ3FvVTlsVXR4dHNSbFdjVkZ2?=
 =?utf-8?B?bnd0ck9WTis5TFp4MU5FSUxMeVZsaDBLUy9yOEE1SmRtVUtuWEFKSU9SZ2Jo?=
 =?utf-8?B?blIzNzR6RVFZbDBkQktEVWdjVFo0V1JOMk0yZVpEOXJLcThMVVhkQTJrQlpw?=
 =?utf-8?B?V0VGb2czdVFaUUFPbFFoRWk5dE5jbGFXQWZhYVdjY0JsYXJ1V1ZlRkRhWkRz?=
 =?utf-8?B?SWZqcVVwa3ltV003ZFc5R1B2aENGQXozMWNIZU01MHgzYjZxL0RvQXJVK1Br?=
 =?utf-8?B?Y2FKV1E5aHV0RUVTQ3ErL1hxVTBlaEhJT25PUUMvdkZMNmRDOFNWRm40Nkdl?=
 =?utf-8?Q?xM0JttfHGmUFTHctJUmaIEYIB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8de68d8-798d-4c52-d0e0-08dbb985c322
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:00:35.9904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4odsghakkaNZ5NOpXVXv7iRsuImmLtITz8CFPw9ZEkosK4zrAhlLVvJmAIZ8YYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 9/18/2023 10:05 PM, Alex Deucher wrote:
> On Mon, Sep 11, 2023 at 2:00 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>
>> Add reset option for fan_curve.
>> User can use command "echo r > fan_cure" to reset the fan_curve
>> to boot value
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 ++++
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 43 +++++++++++++++++--
>>  2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index d05d9cd61331..2acac21387bc 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -3437,6 +3437,11 @@ static int parse_input_od_command_lines(const char *buf,
>>         case 'c':
>>                 *type = PP_OD_COMMIT_DPM_TABLE;
>>                 return 0;
>> +       case 'r':
>> +               params[parameter_size] = *type;
>> +               *num_of_params = 1;
>> +               *type = PP_OD_RESTORE_DEFAULT_TABLE;
>> +               return 0;
>>         default:
>>                 break;
>>         }
>> @@ -3531,6 +3536,9 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>>   * When you have finished the editing, write "c" (commit) to the file to commit
>>   * your changes.
>>   *
>> + * If you want to reset to the default value, write "r" (reset) to the file to
>> + * reset them
>> + *
>>   * There are two fan control modes supported: auto and manual. With auto mode,
>>   * PMFW handles the fan speed control(how fan speed reacts to ASIC temperature).
>>   * While with manual mode, users can set their own fan curve line as what
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index a719bae54e2c..644773c4bccb 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -1484,6 +1484,36 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
>>         return size;
>>  }
>>
>> +
>> +static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, long input)
>> +{
>> +       struct smu_table_context *table_context = &smu->smu_table;
>> +       OverDriveTableExternal_t *boot_overdrive_table =
>> +               (OverDriveTableExternal_t *)table_context->boot_overdrive_table;
>> +       OverDriveTableExternal_t *od_table =
>> +               (OverDriveTableExternal_t *)table_context->overdrive_table;
>> +       struct amdgpu_device *adev = smu->adev;
>> +       int i;
>> +
>> +       switch (input) {
>> +       case PP_OD_EDIT_FAN_CURVE:
>> +               for (i = 0; i < NUM_OD_FAN_MAX_POINTS; i++) {
>> +                       od_table->OverDriveTable.FanLinearTempPoints[i] =
>> +                                       boot_overdrive_table->OverDriveTable.FanLinearTempPoints[i];
>> +                       od_table->OverDriveTable.FanLinearPwmPoints[i] =
>> +                                       boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
>> +               }
>> +               od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
>> +               od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
>> +               break;
>> +       default:
>> +               dev_info(adev->dev, "Invalid table index: %ld\n", input);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>>                                          enum PP_OD_DPM_TABLE_COMMAND type,
>>                                          long input[],
>> @@ -1770,13 +1800,18 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>>                 break;
>>
>>         case PP_OD_RESTORE_DEFAULT_TABLE:
>> -               feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
>> -               memcpy(od_table,
>> +               if (size == 1) {
>> +                       ret = smu_v13_0_0_od_restore_table_single(smu, input[0]);
>> +                       if (ret)
>> +                               return ret;
>> +               } else {
>> +                       feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
>> +                       memcpy(od_table,
>>                        table_context->boot_overdrive_table,
>>                        sizeof(OverDriveTableExternal_t));
>> -               od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
>> +                       od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
>> +               }
>>                 fallthrough;
> 
> I'm not sure the fallthrough here is correct.  I think setting the
> reset should just reset the values, but you'd still need to commit to
> actually set them to the firmware.  Double check that the behavior is
> consistent with older chips.
> 

We also use the "fallthrough" in sienna_cichlid_od_edit_dpm_table() and
smu_v13_0_7_od_edit_dpm_table().

But other chips used "break" here for reset. I think user maybe need
to use command " echo r > xx" and "echo c > xx" to reset.

So, It seems that it makes more sense to use  "fallthrough" here.

Regards,
Ma Jun

> Alex
> 
> 
>> -
>>         case PP_OD_COMMIT_DPM_TABLE:
>>                 /*
>>                  * The member below instructs PMFW the settings focused in
>> --
>> 2.34.1
>>
