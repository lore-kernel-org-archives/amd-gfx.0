Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE28C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 07:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9957110E1C4;
	Thu, 21 Mar 2024 07:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lkj6ytB4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DC810E1C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 07:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFpxN/lowwTP7YjQf2XMqznqoO8WlSglCPueOCP9EG28XdUCFkKRhwVqgjLWIgk7K+OeQlCeSjiMsqi++1ExwDr5G98hwAfnjqdgiiCeP/XVxA1JHUm1iL4MP1heK5XKXAkN4qQfVyKyO9UL6hE3hCZmGN5wyVDjm5jWzYulff4DZbkIJX42DvXx8c945d5KR4KJRT+slYlTCmxt9IP16CfoeL/m7EuKXJ5Cfvl7Tok7Bn3fEXSi2mg9y7xhx9Q1xs8AqWCdYUlUVIMWTap7zJ4Vb599lHBLVoSZ+4aa2HOjInRAG9jKS3zyRvSgCo+KNlujDW5twStiYooHl+10LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM8KJme3nPzaM/nTN2yBKplg2/W9VSwzrahF9pbzfzY=;
 b=DRIbDxgNl07eQouCZ1DTL7jhjPvzJJMn9NtsnpoU73PYXmXfQtTEStyEau4ciB3sw4oA1hiW//ig68lglGFTFCoD7Q9pxeM6wyK0+ETZaC1tOZz9W0FzkD5YrdDOki54+sKXVfx+QpBfHEHN+4LODsdPMMgUfB/821HXzasHHJZ6PFJ5tXL00V2IIPNqp8/6PQ/tvQo6BryzE7hCKW2OzKAsddD2GMPpIfQkwMotvL+Wf4qX+9a17j8ynIeEpEAKdzc19wCE5jQukNBM90vIukDNefZBoLtgC121iy0nHlUb6PjDVia7gjc0nA/2/uiYBxhGD6/+JnbgxFKmNa5hsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM8KJme3nPzaM/nTN2yBKplg2/W9VSwzrahF9pbzfzY=;
 b=Lkj6ytB4ea2Qi9enI2+ksVlATzKPfqFXvdUEJWKG8bTDSqPUx8we7S5jZtkEVBxU/k1e0vt/WiDIyovJ0sHO2lfASheseh/da6KD1L+ARNT+smIKsFES0ifkO8CZ7Nz8x72aEPLb8UG+fXbJ8NKJJK38GOH9y95X/IGJNv4iP3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Thu, 21 Mar
 2024 07:59:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 07:59:11 +0000
Message-ID: <16a6e81f-b72b-4827-9ee0-778033deda26@amd.com>
Date: Thu, 21 Mar 2024 13:29:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime pm mode error
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20240320100926.2614497-1-Jun.Ma2@amd.com>
 <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
 <cefa5729-e523-4d19-bd1e-d399e255eec3@amd.com>
 <11db5829-6f75-4d7b-a7df-6d7a610431bb@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <11db5829-6f75-4d7b-a7df-6d7a610431bb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 4573746e-47fb-44ad-caf3-08dc497ccaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Moa1gn1FrI7kQzczZTblf2gXSi8637U/7WBQ9LeVYTS75hdSUnMsyRdS4/QOmaY69e+Auus+C+gWWD1wvQcnh7/0UMhtjZkjvDCIdUgJ0Y/EHNoZKHTqOc9T1UtQX/OBIs4snQhjauZwz8+eoLMwP7omWcBR4MmTbE09IiwZHhI61lkC5sGqxiIug7qajTKRBw2/gmmGXqxMsHXKI4vHFf9+DvcAkFpZaPmjI7KbKOVCFmCwrhrPNFYForHHQX0AH9oQtPUQNrrFpvYdW7tcgz2HoMmFVDDqXDsn8SRPl/JmVrAhX2z6lLXAig8XXOfVDTW3Tg3+lNXIi8lQALZSyxyT08DfS5NQSBgeXNo18ajYLPWdXlt1IdGFq8XHEyAlU0racK8rnYq3SFliZn6qnj9OXXIaA+WRXg1G35/3Wu3WwyraRs49VxLS9nrObUUNIKW+7TMHq/A3H+BYvjf7OEJNGKegBOY9Bl8Fud8o2UK+FICc+GkPcJ3nttpO/9HT2EL7UGdHviDVO6ddIBSMHBi1nT5yuN4+8VS3jlFr0MRhDr8C0D6fGLxQ6o3dOt5QXddPWvV49pIDMlpatWbtuWkRQk0JVkHVYkmeu1dQFslmioKbDJtrU7GEiughAfI4m2Z9KObZ4UXPMec8CWsVTiDW6I6KYQ+yXNA52ZOm8k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlYRkNqSTFRanhzZUt5Z2txeGZ5TjNreGxkNVA1UzU2TG4wM2w3OFB3RGtL?=
 =?utf-8?B?K1ZBU3IybzU3ODEza1RGY0gzcmhJR1FiSXk3VmhYdFBxMXJ3NU5MNkVEeWNU?=
 =?utf-8?B?bk1LamkyZDJJam9Id0NaSmdyL1ZEclBBWHlST0lSb3BxL1ZxdFdZenl5eUJ6?=
 =?utf-8?B?NWFBNHhGWGZ1bHl1emhTdHUyUk42TDR5V1Z0ZUJGMTRnMWc0VkF2REU4eHVn?=
 =?utf-8?B?M2dPWlNmNThXNDBXVGVjNk01b1RzUjFySkZ4SGRVdFpJdFRrclVhMm1uRzEx?=
 =?utf-8?B?Vy96VnJ2TTRiMzNMbHRyRk80OTg3Q2JKdGJteTdETytRaWZ6ZmNmWXV1UFpi?=
 =?utf-8?B?cjhJNHcyVnNYY1gvZkxKeDVQbnlFOU0rOThvaDJYcVZOYWQxK2RIZ1V5R2Q2?=
 =?utf-8?B?MHlJOS9vMlNHYmR3dEM4ZFBrOEl5NW83SW15UWpsbWo0OEFxODcwMENpMzNq?=
 =?utf-8?B?MzdZS21kYUNrWGRTWmxGT05zcitXMmV0QzhQZW1pclJtbHRERzUweTlFWG5O?=
 =?utf-8?B?WFd3RkF4YjdsRXh2MHljakpwYWFCakV5bFBNbVpRbVNCMzR4c2JoclJ1TStl?=
 =?utf-8?B?ZS9OVnh0K09vVW15NkhNYU81UE9SVCs0R1BRdGY1QTVGYTRhdXpGZytLWkhB?=
 =?utf-8?B?VFQ2THRQNHFQLytFSmJuSlMvcGd5YXVOYzdpOWVEN3Rnb042SHRoSkEwdHNV?=
 =?utf-8?B?SkhyeEd1alJzRmQ0NnZaSjBBMlllYnFsMHo1bWJieXkxeVUrdDFUUWVoRUty?=
 =?utf-8?B?ZVNYeWNUa2t3TE5OTkh1Vkxkdlc4VG5LRzBraTlVVkNEeG1BV1d2Z0FDRFBo?=
 =?utf-8?B?Tjl5djlEZnFRSzJHeHhMckhJRUQxcCtNbi9ac2s5bkVVWGZueXVBSy9xNml2?=
 =?utf-8?B?NGtqTWFiMHcyYlFVSTlXSG5saUhBVDJUdFpzRWJydjZXVFZvR2dvaXVtL3hF?=
 =?utf-8?B?K09XclZjTm5yUmszVlUrMmRFUm5LaUtLdXdQeGw2aFVmeHNJa1ZZNmxxZ2NF?=
 =?utf-8?B?SHFMV1RaSUNQZ2s1NE9wYXdvYXZJaTM3cUthV3JXRFc4VFpaUnY1TXFIaHJ2?=
 =?utf-8?B?eStVaEppUFFwbWNZcGR1M0ZJbHNza3ROb25hd1gyS1lsR2pjeVFDUWNnMjZB?=
 =?utf-8?B?NXo1elR2STN1Z1o0blZhZlVkckdaVDJ2ZWJYSEMzVkJTSHFld3RlMUFsMFNq?=
 =?utf-8?B?elg2bFNwVjVYRWRhRFRXeFZOSTRobnpmS3hzMjlRamRwNzFLazFWRWRpWi85?=
 =?utf-8?B?L3JJczd2aDdSUk11TGpiQ0VhZC9jb3hYYWpTNEdOTzBZTFQ3Q0RkbHJBMWtI?=
 =?utf-8?B?bDZ4UTdxWmxNRDIwWUVzZnlGTUYwbTdhUjdiMEFhbTVZUGpOcERPMTRvV0xK?=
 =?utf-8?B?YmYxZ21KMk9DelcrL1VMR1lGSW5BRHpRN2xTMWtDR2doVk5rbE9QeFBlYWc5?=
 =?utf-8?B?aGVBeFR6NUwzOEQvdlIrcFlURmJxZFh3Wld5Q2wvVkx6Zi93eU5DSkZNM2RT?=
 =?utf-8?B?VnRLRTVXcktDQTJRc2dKeHBZcUNlQ0ViRjdIUFZMRHdoam9OenZYSUQxUnNx?=
 =?utf-8?B?RXd4OGZjTDRKMXlMc214cU9KRmd5MjF3UWFrNHdZY2NuYUlDOU5ML3BYSmZB?=
 =?utf-8?B?VlNBMFdienIyb3RSRjNEVmYwQjFxRW1ZVjRuMFU5a1ZHRzNzdm03Z0FTOWNj?=
 =?utf-8?B?RmN2ZDVveWhnQmRzZzgzcEhER29ZQnpMSysyd3pISVNMNWVSdUVuUWZmbUtx?=
 =?utf-8?B?WllHQnhrSVllbmRxa2ZLUE04c3FMR0NvY1dhUU90U3ZxcXFhV2VtU1FjNFZT?=
 =?utf-8?B?M0REWE1xVkpTRm5QUHgvK2dVVUtySWJoZWd4eGROTk5oUnN3VHdtZWFKbVdN?=
 =?utf-8?B?UXB5eWVqR0UwUnduWDg3L3VJTnR2V3FxekxTOEFOR2xJZ3BBUGgvODJzbVJV?=
 =?utf-8?B?bUU3NmZ5QllJaFhteVhnTmZHTlppdXN3M2gycExBbU56ME1EWExVaTRKMlZS?=
 =?utf-8?B?cklzYzhuM0VldmNvMzFKY09zUHdFUFRTUm8yUWJSOXorZy9CM014SG9vRUlP?=
 =?utf-8?B?Z29GWjhQdllaeEVoSGFQRnE0NXV4eWc4VHlnR3NqTUlXNXpMU09SQ1NLa1FO?=
 =?utf-8?Q?DcAfQO4rOkzrG9jyDXxAGKo08?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4573746e-47fb-44ad-caf3-08dc497ccaca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 07:59:11.0849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQC9qcpxx3UXy4SLEDXaFnSN+JU/8exkKnjH1fI7gQf1bYGfoUEomrYv+a3oHNK4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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



On 3/21/2024 12:28 PM, Ma, Jun wrote:
> 
> 
> On 3/20/2024 9:38 PM, Lazar, Lijo wrote:
>>
>>
>> On 3/20/2024 6:54 PM, Alex Deucher wrote:
>>> On Wed, Mar 20, 2024 at 6:17 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>>>
>>>> Because of the logic error, Arcturus and vega20 currently
>>>> use the AMDGPU_RUNPM_NONE for runtime pm even though they
>>>> support BACO. So, the code is optimized to fix this error.
>>>>
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 56 ++++++++++++-------------
>>>>  1 file changed, 27 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index 1f92fb1e7421..70cf2d0c7683 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -150,42 +150,40 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>>>         }
>>>>
>>>>         adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
>>>> -       if (amdgpu_device_supports_px(dev) &&
>>>> -           (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
>>>> -               adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>>>> -               dev_info(adev->dev, "Using ATPX for runtime pm\n");
>>>> -       } else if (amdgpu_device_supports_boco(dev) &&
>>>> -                  (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
>>>> -               adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>>>> -               dev_info(adev->dev, "Using BOCO for runtime pm\n");
>>>> -       } else if (amdgpu_device_supports_baco(dev) &&
>>>> -                  (amdgpu_runtime_pm != 0)) {
>>>> -               switch (adev->asic_type) {
>>>> -               case CHIP_VEGA20:
>>>> -               case CHIP_ARCTURUS:
>>>> -                       /* enable BACO as runpm mode if runpm=1 */
>>>> -                       if (amdgpu_runtime_pm > 0)
>>>> -                               adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>>> -                       break;
>>>> -               case CHIP_VEGA10:
>>>> -                       /* enable BACO as runpm mode if noretry=0 */
>>>> -                       if (!adev->gmc.noretry)
>>>> +       if (amdgpu_runtime_pm > 0) {
>>>> +               adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>>> +               dev_info(adev->dev, "Forcing BACO for runtime pm\n");
>>>
>>> Does this need special handling for BAMACO?  Setting
>>> amdgpu_runtime_pm=2 is supposed to set BAMACO and 1 is supposed to
>>> force BACO.
>>>
>>
>> Also, based on the comment it appears as if runpm is not intended to be
>> enabled by default on Vega20/Arcturus (unless forced by module parameter).
>>
> Function amdgpu_dpm_is_baco_supported() is called in soc15_supports_baco
> to check if BACO is supported on Vega20 and Arcturus.
> 

BACO support doesn't mean runtime pm needs to be enabled. BACO is also
used for other usecases like reset. Since these are MI series ones, I
doubt if runtime pm is an intended usecase for these.

Thanks,
Lijo

> Regards,
> Ma Jun
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>> +       } else if (amdgpu_runtime_pm != 0) {
>>>> +               if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
>>>> +                       adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>>>> +                       dev_info(adev->dev, "Using ATPX for runtime pm\n");
>>>> +               } else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
>>>> +                       adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>>>> +                       dev_info(adev->dev, "Using BOCO for runtime pm\n");
>>>> +               } else if (amdgpu_device_supports_baco(dev)) {
>>>> +                       switch (adev->asic_type) {
>>>> +                       case CHIP_VEGA10:
>>>> +                               /* enable BACO as runpm mode if noretry=0 */
>>>> +                               if (!adev->gmc.noretry)
>>>> +                                       adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>>> +                               break;
>>>> +                       default:
>>>> +                               /* enable BACO as runpm mode on CI+ */
>>>>                                 adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>>> -                       break;
>>>> -               default:
>>>> -                       /* enable BACO as runpm mode on CI+ */
>>>> -                       adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>>> -                       break;
>>>> -               }
>>>> +                               break;
>>>> +                       }
>>>>
>>>> -               if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>>>> -                       dev_info(adev->dev, "Using BACO for runtime pm\n");
>>>> +                       if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>>>> +                               dev_info(adev->dev, "Using BACO for runtime pm\n");
>>>> +               }
>>>>         }
>>>>
>>>> +       if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>>>> +               dev_info(adev->dev, "No PM mode for runtime pm\n");
>>>> +
>>>>         /* Call ACPI methods: require modeset init
>>>>          * but failure is not fatal
>>>>          */
>>>> -
>>>>         acpi_status = amdgpu_acpi_init(adev);
>>>>         if (acpi_status)
>>>>                 dev_dbg(dev->dev, "Error during ACPI methods call\n");
>>>> --
>>>> 2.34.1
>>>>
