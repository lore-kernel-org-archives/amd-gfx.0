Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A74C25B06
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 16:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD2811AA45;
	Thu, 11 Aug 2022 16:43:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD57A10FFC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 16:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGjYCSavRez/NB6BCnfuVQMutdBo6kj03j88b1cn76L2oh2rXAciHSyMPFC9dCj+AP8AqKbjqiE5cIGsEetH7bptfpixs1sy0H2MNv2NyBbtYQC8yOA2166AseV+3G68yiWdKei20l9TDlav1DBiWqUVef4ltRJXQhM8zD127+LznVOIzzeUStiQygqumoK1IKa4g+UiZy0LDPWnUUQmDRe2Q7y4E+8NG3WYPzm47vWZMgzWeYkMPzQoz8fXEiDG1Gbp+UBeBJzsRazHx/feWUVKWtgDCWujxU+y2MTrK/I1kpMu0o0jsvDuSyk1J8sQt8c3xZ5KLAC0rIVUVNAvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY7osna0L08sQ+EQMZk/ci9qtjxbCMg2rgffMRYBL+Q=;
 b=Dsk6GLlHPJnEu7n7wWPEDGz+kfjusqeQJmE7cVfQM0PR1V3huopC5TMnVl6p75pPtWIiCR8edozavRKRlB/VYyfM9oMA4W7yXyYx2TrnuLYhoiVitDURFx9xK0r/reqPmJdZ0WOXykcHCpa3Lc3/M8hfv7oYE2lsSPWYGd4gbSZOm9BZkn4sFqBcIC1cau8eaCIRYfcxZ8L6nMVlcjW8XcCLoX9uYC+kxCHWQbude3PncQeZVuBtsjx2pnulzpNBoOCgvg1SfoR3IntZxH2yGYmHCDOPLfavQ6KtCnzQKag8pI09h8D3eddiVqXC+E9SQfbiY0JyOXB6m69SF2xD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY7osna0L08sQ+EQMZk/ci9qtjxbCMg2rgffMRYBL+Q=;
 b=4cEt+NH4hUkHpOObnTYjc3A4F/BRRX/Bo2v5RfMh0lbS/n1jtcRRIUlq3QcjA8BikwDU4nye6+00pqVyjbb4uQ1LTHaDDhvrSDaVOl0TZ8HEJCoLIRiazDfBh/8y9SFybYo94+xTKnHw2MhjZxyhfxwx7Ah18q9H39PnECQxZNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Thu, 11 Aug
 2022 16:43:19 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5504.025; Thu, 11 Aug 2022
 16:43:18 +0000
Message-ID: <cfb0bf9e-27b9-940c-ec4d-25adcdabf5e9@amd.com>
Date: Thu, 11 Aug 2022 12:43:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: fix reset domain xgmi hive info reference leak
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220811134217.138701-1-jonathan.kim@amd.com>
 <78c8501b-fbda-43a9-764b-2176eeff1243@amd.com>
 <DM6PR12MB3163B08025CE90BD591C08BB85649@DM6PR12MB3163.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DM6PR12MB3163B08025CE90BD591C08BB85649@DM6PR12MB3163.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1625d99e-313e-49a4-73c4-08da7bb89859
X-MS-TrafficTypeDiagnostic: LV2PR12MB5823:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGe1jnHPXhcPMqtF0faCpjTefid4OVw8cjFxaL1JLjyydrIZGGdqCvSRMJ6UOd75XI7He5V29FbSriWcqRQmcR1V+95YimSAxGyWajjMtnmgslKi6svGZLpgRTLgXp4nMacaBCQQYhkYko0vyc3rZZlJbxt1rlq3dE3y9acXswAgLUbnTYVGRF68ZIhFpix8bIU+IdhDw5mviBWcJkDOR6JqiOveLP5c5/lW/CWB8ob1+7j8MVr3RZXRpk+3EcraaCKUEOei+4F3TnutrIxwfb7cuddeFuREMqBw7OPF2A0oPqJlr6HJVSrjfJaG1EKpSLDDE2sVbiHnO7CNpxxMe5KtVmkeA0nAjjBg/Yp1mj0DE/Nub/3kJlqCgxyDozhPOLhaWRDlZOZETQ/inXTKFLts5rDGYoM89TN9qBmtEEYM21+iivq1ah3v+Hq03QWEfDQcBl1flpHRtE60PtWjcRurGE7488pSN/lhzSPNvGxOc87E4oEoGyNYpGrBU4Oy1U+ynKOZboip1JgZfoHFWwbt1aZDF0Uyv7xPWECsRp3lxiGHEA63hH0gJTMZixgdSPgpP5QvbSGonPDyPKkKOsVcGLqpzSdui4KUptiO7LcjEN1EgN7sRbdJEP8jmn4KGDc/0vjSZqBDUKNyyzD4R0THq3oZsPo1rj20Xsp9P9HCrdrmKFxxTXPT23aUji+4tuEnqd4gDC+/qFHV/+J0ryKUL/4MpSz1ATmcFi27XxYTebQBVZhm302iJwAhzucMLNs1ZoDmLAbb52XYcENY6YuxR5whJJ3dWO2eWv2ZiEfp9ynfc5AwwXNV8WX4XBf+jthq4JtSqO3Krd8lNCfni7bSgUeaavK6JR5JrfwD6aI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(110136005)(8676002)(41300700001)(5660300002)(31686004)(53546011)(478600001)(186003)(66946007)(31696002)(2616005)(36756003)(6512007)(44832011)(8936002)(6506007)(316002)(66556008)(86362001)(66476007)(2906002)(966005)(6486002)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhXQkx4RC9ZcUl3VUZERkdQR256WitRVnRFVkVVV2srSGcveWgxUzkyUytT?=
 =?utf-8?B?aUFPV1ZtNEVFUVFlU2w1dVhhSjdUTkZ4bEpKV0lvMnJkYXJsSFlsbmJSdkNl?=
 =?utf-8?B?RnRhMnBGMlpHdFNrMmxnenpZd0hJVGJwb1hnYWpsV0JVZ2Ewa0czL2xtVC91?=
 =?utf-8?B?TElvRElvRWR4eW5na205bENCdFAyZHZIVnB5TEtySGRkMUpLSHNYNkMyeSt0?=
 =?utf-8?B?c2NhSUtQSzlWTUZDWWRXN1gySVIxZnp2UlltNHRRdDJpaERHdk5RN05yTGRF?=
 =?utf-8?B?UGJNRkNBVWUwQ00xZVg3MUVKQlczRE4zM0FQbm1la0orWTBPYnpESzZvKzRF?=
 =?utf-8?B?WWc2ODBGVlFqOTBLRFBEVm9zTlIza1NoWnhlUExQN3BMYnZ2VlVwdEFZMyti?=
 =?utf-8?B?WTZaL0xSckNJMGlDOTJxZzNjbUk0cm5EdUNFcCtxRVozN3RaWXR1NnNoSFdv?=
 =?utf-8?B?MzI0T0dVNDU2bVV0cFg0ODhMb0dGWEJjaURsRWN2Wlg1SjdIaTZKcFFOSmph?=
 =?utf-8?B?eU1pK3FndUFnU21VMDUxaGJVb0hYNXZhcEZOYVBSck1lT2NMUGZ2RGo4WFh0?=
 =?utf-8?B?TEtoS2JLbEtZVlV2QnMraXp3Wk5mTlgzRDBQNlhTbng3bG1PN2VHOGJSc2lX?=
 =?utf-8?B?NDNqaWtJNHNmWCtqc1JEeUF3VXBET1BRemtJZ1Jkek5KWTAyY0lLaXprQWho?=
 =?utf-8?B?a3BDa2dYVWxwaUxnN0JSSUN2NDQyMVo3ak5FME5NWkpZREZEOGNkalRuY0VG?=
 =?utf-8?B?L2NLQVZ2RTY4dVRlOWlCckhjRG0wdFd3OHhubDJhSnBZUWtveHlMU0tMZ2lh?=
 =?utf-8?B?VVZDWnZGcGFjdlUvWk94UVJ0bUtXUmJ0Z2pkY0Voa1VHRnNuZXJaL2Rjbktq?=
 =?utf-8?B?eXVFYU9jVCs2eXM1WDJrZGpxWWlpMmI5OVp3QmczVXIycVNCcTlueWZWTmtO?=
 =?utf-8?B?ZnVra0JRb05ZNENsUDB0Vy9aTGRyblJ1QVFLZDZBK3RDMndJUEhSTFRLa0tG?=
 =?utf-8?B?TlArSXhpSm9IZWIweEdqZDJORVdIdUNqVG13aTh3RFV5VnFWQUdyT0xHRWYr?=
 =?utf-8?B?c1BVV2E4RHV3TldMMWpRanVkR0ZKY2NPVXQ1dzBQSWgvK2JLV1JSTTU0d1V2?=
 =?utf-8?B?ZXFabkxzMXo3cEN4aExuL2V5czlsdE5zSkNhZFR4MTRjdzJraW54US9OQ09x?=
 =?utf-8?B?N2ZwYzF6bTgzRDgzQzZYSmhUZS9tUExLRTdBKzRaaDlDZHF5WVFrUVg5b2RD?=
 =?utf-8?B?RC9FblkvbnoxZ3NYR3ZKc0FSL2Fza0I0NStTa2VDdWNBTlh1K21sNFcyZnY4?=
 =?utf-8?B?S3dWV0Z0YnZ3aldqRWNSOHFIWTA1VlEvbkNUaHNYQ3drMWoydUw1cDVEUHBE?=
 =?utf-8?B?QmJUcEM2d1k1cy96ZEJYb0E2bXNMZ1dPL1hsT3c5bTZWTFQwdkIwdTlkclo4?=
 =?utf-8?B?ektCVVRqcG9Uc09MSXBKMDhwUFNPeWx5bzhmVFg0T050eExYamE1NFZYVmgx?=
 =?utf-8?B?S3U4MU1uWENMUUhxU2VDZnNaSUNBSWsrVVZlVEpEeUxKT1AwZ21lR2NWeXIv?=
 =?utf-8?B?Y29ETHJXeExpcEhvVUViRmwxKzZIay9EZXBEbDZhcytZQ2lHdEc0RTFZYVVX?=
 =?utf-8?B?Qkg5bVZSUHNURSsyOFRnM3NyZytLUUdKUEpMbTNGVThPeTRJdWtWOXdrRitr?=
 =?utf-8?B?ZUNuMk50SVZ0a05Ka0tGQ2dRdVhGZGtGRkE2cDdvQ0pmRU1IT1NIalE4Q0hH?=
 =?utf-8?B?UGRCLzlKc2V3ME91c215alpNWGNwZ1ZISEpuOHFpM3liUmc5eEtaai9oblVt?=
 =?utf-8?B?akJTS1V0bFFoOHVScE1YWGwxSldoRzZhK0JmNXZHSzZUaWIyS2dvRTZuek1H?=
 =?utf-8?B?WDY5cDJmd3Nma2s5emUyVytDbTUvWGZnVnhRa2wzSzEvNENxT24xU2c5bXJ1?=
 =?utf-8?B?NHBNdHc3YnJHbU1wQ2tUbmtuMGVIdzhreDZUdWRvNUljeDVuUi83WDIxOE8r?=
 =?utf-8?B?K1k1MXp5WEkveE1tUnZEU2VtdXhsRGo2QXR5NEdUNW1sZVQzQlIwSUYyc0wv?=
 =?utf-8?B?MXkxWXl1WExkYU9jMytXZFhsb3ZISnV0WWEzM3BQZFo5U21kL1Q4TitpaDI4?=
 =?utf-8?B?Y3hseFhqZnpjUzdxK05jaG5pQWFOS1NaanVmUDFkQVVUam1rU0FQQVZ3VFJ3?=
 =?utf-8?Q?9fW92RB1TO0Gm6k6sokKiUxSwZWfni8sFKWi2/tNyCbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1625d99e-313e-49a4-73c4-08da7bb89859
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 16:43:18.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFxs2Xd4lzX7zAYg+PgZ8U/zEe0skMis7PkYom1vVgfcFZ/LfEySNfJ8Ynf4+IEbkqPJsaY8RbQu6NK5VkdTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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


On 2022-08-11 11:34, Kim, Jonathan wrote:
> [Public]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: August 11, 2022 11:19 AM
>> To: amd-gfx@lists.freedesktop.org; Kim, Jonathan <Jonathan.Kim@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix reset domain xgmi hive info reference
>> leak
>>
>> Am 2022-08-11 um 09:42 schrieb Jonathan Kim:
>>> When an xgmi node is added to the hive, it takes another hive
>>> reference for its reset domain.
>>>
>>> This extra reference was not dropped on device removal from the
>>> hive so drop it.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> index 1b108d03e785..560bf1c98f08 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> @@ -731,6 +731,9 @@ int amdgpu_xgmi_remove_device(struct
>> amdgpu_device *adev)
>>>      mutex_unlock(&hive->hive_lock);
>>>
>>>      amdgpu_put_xgmi_hive(hive);
>>> +   /* device is removed from the hive so remove its reset domain
>> reference */
>>> +   if (adev->reset_domain && adev->reset_domain == hive-
>>> reset_domain)
>>> +           amdgpu_put_xgmi_hive(hive);
>> This is some messed up reference counting. If you need an extra
>> reference from the reset_domain to the hive, that should be owned by the
>> reset_domain and dropped when the reset_domain is destroyed. And it's
>> only one reference for the reset_domain, not one reference per adev in
>> the reset_domain.
> Cc'ing Andrey.
>
> What you're saying seems to make more sense to me, but what I got from an offline conversation with Andrey
> was that the reset domain reference per device was intentional.
> Maybe Andrey can comment here.
>
>> What you're doing here looks like every adev that's in a reset_domain of
>> its hive has two references to the hive. And if you're dropping the
>> extra reference here, it still leaves the reset_domain with a dangling
>> pointer to a hive that may no longer exist. So this extra reference is
>> kind of pointless.


reset_domain doesn't have any references to the hive, the hive has a 
reference to reset_domain


> Yes.  Currently one reference is fetched from the device's lifetime on the hive and the other is from the
> per-device reset domain.
>
> Snippet from amdgpu_device_ip_init:
>          /**
>           * In case of XGMI grab extra reference for reset domain for this device
>           */
>          if (adev->gmc.xgmi.num_physical_nodes > 1) {
>                  if (amdgpu_xgmi_add_device(adev) == 0) { <- [JK] reference is fetched here


amdgpu_xgmi_add_device calls  amdgpu_get_xgmi_hive and only on the first 
time amdgpu_get_xgmi_hive is called and hive is actually allocated and 
initialized  will we proceed
to creating the reset domain either from scratch (first creation of the 
hive) or by taking reference from adev (see [1])



[1] - 
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c#L394

>                          struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev); <- [JK] then here again


So here I don't see how an extra reference to reset_domain is taken if 
amdgpu_get_xgmi_hive returns early since the hive already created and 
exists in the global hive container ?

Johantan - can u please show the exact flow how recount leak on 
reset_domain is happening ?

Andrey


>
>                          if (!hive->reset_domain ||
>                              !amdgpu_reset_get_reset_domain(hive->reset_domain)) {
>                                  r = -ENOENT;
>                                  goto init_failed;
>                          }
>
>                          /* Drop the early temporary reset domain we created for device */
>                          amdgpu_reset_put_reset_domain(adev->reset_domain);
>                          adev->reset_domain = hive->reset_domain;
>                  }
>          }
>
> One of these never gets dropped so a leak happens.
> So either the extra reference has to be dropped on device removal from the hive or from what you've mentioned,
> the reset_domain reference fetch should be fixed to grab at the hive/reset_domain level.
>
> Thanks,
>
> Jon
>
>> Regards,
>>     Felix
>>
>>
>>>      adev->hive = NULL;
>>>
>>>      if (atomic_dec_return(&hive->number_devices) == 0) {
