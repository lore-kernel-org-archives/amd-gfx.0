Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C41BC54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 06:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733B210F462;
	Thu, 21 Mar 2024 06:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mSOgf8R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABB410F462
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 06:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVoOeD51NHjmXmD92+34CNFmwP2U7YEkG3mChct6puHOXAVl4gP2gsCD3ngaqXkH+O74pw1+87e1jlH0y/6l6GwRs5L8OmmZgg1lUts3j40713nggOZjHltEiAqc8l//k26LcgQmRo63B7p1fe57eUEafQMaEd2MMO2ZRJ35FkpSnKOuurGJyl4uxOaf8c84+DG200ET8B3h5FjcS8rQUsaxd7vzQ6eZJi3n5GnOr5Pt53Tk0QsvzWMk2adN7xnP8PcNpoMr2n2XQl13PlpCPL1DKmhh0v44yzpHhQ78UIZbQkiPNwlJuRBna2Gf/O8qgqB0DyS6VtFwV5HJ6yssLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URYz6EpgjELBx7QKN6V2gniqCtqcAW51ZSaNykHi/+c=;
 b=McxB383594//h1FumeeytMxkftoEYye9tdClpNB9RzLs0ql/qYb8pKNRzFDybWU1FOliQy+CaA2OcB3QJ6cQLimP6alnLtUZCNQ0DW42rF9Mb3D3YKdxWCDOYcbg7W0/bMeqliqzQU5UQTwTExkHbuGebFyHZ/5h1Sm1R49B3HM9DswakUwLwG3aNVQRKgK3ZQNQT9tQAQBA+iggj4gxkaUxeUBHGEV+Z3Hj5low604sIs5XWm9ofDV37IKWdLDXjWISfeU/lcUypY7Y9pVfTir9VpuRl6+mkltLuisSQdzTh97iC6YsDzCMHhESYNnHa5CcGucnCs+90x8xaEaz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URYz6EpgjELBx7QKN6V2gniqCtqcAW51ZSaNykHi/+c=;
 b=3mSOgf8RizdRbDBDpqnJsJONcUiWMM0ktIV5GrUqy9zeRyY5mEgcQWOTHPqpjsoqS3yZgLwvevVd3iQBqlqpHLUEcRKHR94sZ5KHxgUhDXTIPiMF0/pt4pMk0aUxzAjXRG9t1HGbZqJ8eJrPww7kzyUejMVZfzxPT+UXJFG+lmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Thu, 21 Mar 2024 06:59:17 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 06:59:17 +0000
Message-ID: <11db5829-6f75-4d7b-a7df-6d7a610431bb@amd.com>
Date: Thu, 21 Mar 2024 14:58:47 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime pm mode error
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Ma Jun <Jun.Ma2@amd.com>
References: <20240320100926.2614497-1-Jun.Ma2@amd.com>
 <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
 <cefa5729-e523-4d19-bd1e-d399e255eec3@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <cefa5729-e523-4d19-bd1e-d399e255eec3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad26c89-67e6-49e3-7b8e-08dc49746c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5lQ8qMGnQyNKjCG7nlv74WejbBGUTlv0bZa/usvcp70TAr+zS4BPei9SLzJ+ZRd60yB0jyNzheEKWMz6nkemqkJ1LicLmvLuqz4jiVmYkTpL9MxN0lV9z7SEm8B3rRkfbDF7qbhB/JBSVwkrrHjn0MXCjcXl3Xxcms0Gy0sNh9hjwtaoyClijhc4hqli+90GKgP6EZf4CGve1HEzIMZc+weyp1lkOCyaHw3tv0AnH4ogWiHV1DSd6UOo8pb8E7S5/Lnt8R5RGm4ecossAnUNIcIPM+7i1mHS6OtKlJroRQMqFVLMsl989v1UrmS2TX4SRFGrrSzn8Wxg4Wg4JOzBSqWM4tL0MvIGWFRCbrA/NJsT2YxHQ5t7n6xHFN68Jevs4YrWom3aXyuOpRqA7gWYUFrC/l87SlZVoGbSC1fxSC/XnMqWV6fBYaSZZv9cH4aW+qw8r7nUyJvD1NYtgbJl89bFpYGXGHM3wilPwOAN6I//UWLpL/MwnyE50A7hLa8FZWp0/GxLdAyw8qL8Y3ypxMLY1lFvi0e7d+hUcQYN14oVCoxmfZTPy199nT4NSmA5BvKTwi2i1FKiWDwL8H1U/p4Df8HUiq0yfu0rqq+pq8XomPUGyJlv6XSwDH5JfNXclcrdcyNWB4SH8KUwI8yBlE9QnvMFdp0zt+SEo/W/jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJwclpESDNUL3cxajFJWkNqRm8yZGtmbXl1WkozOHRFd2FXdFhHOVN3Skxx?=
 =?utf-8?B?WHpBSjl6WVRnS2xaS3NxYmpQL2o4S2publEyUFdoSWxXMkRCYXBDUDRYMFpV?=
 =?utf-8?B?dG1PNFFHWXBUbU5PMmRGOXRVVTg1SU5MOFdZZ0xXd2JzaVFpSXFHcG5HVjdN?=
 =?utf-8?B?Y1dyQWR0TnRYUGpOcHVCdmV6Zmg2N0MrdHZUaWZXWFZBcEVPeUl5RXpTbHpo?=
 =?utf-8?B?TU5VQlVqMWQxVjhiTGgyWlo0aXVaN3drUTA0NGlnei9LbUNQYU8xSC9YWGg3?=
 =?utf-8?B?L29uRkNZM25DNzFmajdrWldUN3ZSSldpSlBZNXhMTlhxVWRPWWg3emxXYXVN?=
 =?utf-8?B?aFJVd1VvaG53KzVvQWllY1lKSzR1TlRoNXl4ZlhCRW1sZkl3NEsya2hRVlJw?=
 =?utf-8?B?RG0xRWNCc1ZNdzJxUzEvejVvT2l5b1pZMGd1N3lmY2pJTm5yRmFSSG9NN2Q1?=
 =?utf-8?B?bHBaYlBVY3dCcE1VZjhoSVNNcWM2Q1NmaXYzTW9scmNyVThJZWNYaCtEVkNX?=
 =?utf-8?B?OFUyRlk3MS9SL2ZHME83OG9YZkw5Wk5JRWEwNTN4NkRORFd2YWtJRGpFejFB?=
 =?utf-8?B?SUczL21nZEQxL2VxcDBXeUFoaE43ZE1hOFZEeTJSTE1aZElYV3lzT3hpdXJj?=
 =?utf-8?B?bUJ4VDBTSnNVc1c2blpCMVpPYW8vL2RqcFZ2VTcrOFlhem9mNkRZNERuTHFp?=
 =?utf-8?B?NXpTKzcvSzBrcVY4VjNydk9VRmZ0M2V1THdPZlgxZDl2WE8wUXUrK0lhQms4?=
 =?utf-8?B?NnkzcHZxV1VmeUxkVG5MZFVYWmtFMm8wQkZSYkJWOTFjSGJ5Tk1ld2FUNndZ?=
 =?utf-8?B?cEJrUWx3RFpVQTUzLzRabGZqUE5XRG1iTzh5N3ZNZzZQS2ZGUXRReVZ3U3dV?=
 =?utf-8?B?cmNjSEN0SDZYeVl1SWNaVG1GVGxDdEdDOUF0cUFuUWZKMVd2dmpkdVJXdmpH?=
 =?utf-8?B?MWJhVURrbkxPY3BvdXk1VXNDVTg3NGNoeEJUeWVVMis5THVpWXZWd0VBMlJ1?=
 =?utf-8?B?WVpIQWR4ZUxHS2hydUpFODFvUEpzWThFNk5uVm5aRG4vRjdXNkNxWGlRa3dY?=
 =?utf-8?B?UmF5SUdtWEpET2ZTY3FDcDdYa1NldzB6U0M2enZqSmNRVEc5cVRTa0Zna3lY?=
 =?utf-8?B?bHFrdkI3Y24rdWVQUEJSeDBPT2RYUlBsS2VNWFdHS1MxaUV2QmY1dmRyd2M4?=
 =?utf-8?B?S1lOWlZiRmZUbDFiNm8xTzUrazUydDVJRCsyMjk4L05IanR6S1FQTWpYTG1m?=
 =?utf-8?B?ZjJGYm91VGVhWTJxcFR5SzEzbE9lbDZLTHByckFpR0ZKcyt4aXMzd0VpRVdI?=
 =?utf-8?B?eFhhVUlEdGFLUnNOSFYvQlBMZnhyVVNJckhxU3ZnN1YrVmVJQm80NEplOFIw?=
 =?utf-8?B?VzJkRk5QcElOSU4zelByMTRrZUFoSlRXOGRoelFlNG81NzlvaXQ2bCtyUkNj?=
 =?utf-8?B?L3p2UDdXMWtTUHZHcTRLaWM0NXlUVnB1V2lQejRkZ0dybkFFb1F5NXI5M0xY?=
 =?utf-8?B?VVFrMlpQY1FTb0NYNndadms4YWdmZzZWeWtOWCtPajVMY2hQdktUeThKYlZl?=
 =?utf-8?B?M3lGZzdRQkhaT3laWHEwK3RJWCsyTFcvbDNzY0RtbGRjS1BDclNWTGovQnBC?=
 =?utf-8?B?TE4raUtHSmdYU1Y4R05PY2JWaDhaVytkTXZYSkRRRWhuZ1ROL2FyUUd2QUNH?=
 =?utf-8?B?K0NzaTlSSlh2bENLM1l5NTFuUlZwU2VMN1J5Ykg0RDBRM3BxdGlLUVpkNEVz?=
 =?utf-8?B?UkllMnZLcXFjZm1aNkNtM2hSQUw4N2JrRkxCYXIvTzJ4Zjhiekpxak55TVU1?=
 =?utf-8?B?blIyYXNPa01kZUpGNnpKRzA0TGFJOTNteGJLWXkwRlhic1lQOEJQWUN6bWIv?=
 =?utf-8?B?WHg5UkpBN1EzeHk0WGh1anVia0F1UzBOQ0xGMjVHNmh4WlViZzVkSEgzMDZs?=
 =?utf-8?B?bU1GNlV6ZHhjMGFDWjdEa1BiN2xLYzJmNnBiU3dVdVdjZlBmNGt0anErREFm?=
 =?utf-8?B?M25CZW5Ld05VVU5tYkd6RCtmU0R4MWJMbmVnaUVCSFJDcEw0ZlhOMnJsR0Nm?=
 =?utf-8?B?T05FRWdvTnZOZDJ2MmxuQzcwTUQ0OWxHOHVwOEJhL0hNVW5qd2pYRXVWNDJl?=
 =?utf-8?Q?AogeSFf5n7n86+j1aMdkYpVyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad26c89-67e6-49e3-7b8e-08dc49746c92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 06:59:16.9195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI+UGF9LTv85zvUd2pYjhHcjREk24wjTyHylKg/3X3v3zrRseLMOpd7bme565+bG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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



On 3/20/2024 9:38 PM, Lazar, Lijo wrote:
> 
> 
> On 3/20/2024 6:54 PM, Alex Deucher wrote:
>> On Wed, Mar 20, 2024 at 6:17 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>>
>>> Because of the logic error, Arcturus and vega20 currently
>>> use the AMDGPU_RUNPM_NONE for runtime pm even though they
>>> support BACO. So, the code is optimized to fix this error.
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 56 ++++++++++++-------------
>>>  1 file changed, 27 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 1f92fb1e7421..70cf2d0c7683 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -150,42 +150,40 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>>         }
>>>
>>>         adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
>>> -       if (amdgpu_device_supports_px(dev) &&
>>> -           (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
>>> -               adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>>> -               dev_info(adev->dev, "Using ATPX for runtime pm\n");
>>> -       } else if (amdgpu_device_supports_boco(dev) &&
>>> -                  (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
>>> -               adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>>> -               dev_info(adev->dev, "Using BOCO for runtime pm\n");
>>> -       } else if (amdgpu_device_supports_baco(dev) &&
>>> -                  (amdgpu_runtime_pm != 0)) {
>>> -               switch (adev->asic_type) {
>>> -               case CHIP_VEGA20:
>>> -               case CHIP_ARCTURUS:
>>> -                       /* enable BACO as runpm mode if runpm=1 */
>>> -                       if (amdgpu_runtime_pm > 0)
>>> -                               adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> -                       break;
>>> -               case CHIP_VEGA10:
>>> -                       /* enable BACO as runpm mode if noretry=0 */
>>> -                       if (!adev->gmc.noretry)
>>> +       if (amdgpu_runtime_pm > 0) {
>>> +               adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> +               dev_info(adev->dev, "Forcing BACO for runtime pm\n");
>>
>> Does this need special handling for BAMACO?  Setting
>> amdgpu_runtime_pm=2 is supposed to set BAMACO and 1 is supposed to
>> force BACO.
>>
> 
> Also, based on the comment it appears as if runpm is not intended to be
> enabled by default on Vega20/Arcturus (unless forced by module parameter).
> 
Function amdgpu_dpm_is_baco_supported() is called in soc15_supports_baco
to check if BACO is supported on Vega20 and Arcturus.

Regards,
Ma Jun
> Thanks,
> Lijo
> 
>> Alex
>>
>>> +       } else if (amdgpu_runtime_pm != 0) {
>>> +               if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
>>> +                       adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>>> +                       dev_info(adev->dev, "Using ATPX for runtime pm\n");
>>> +               } else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
>>> +                       adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>>> +                       dev_info(adev->dev, "Using BOCO for runtime pm\n");
>>> +               } else if (amdgpu_device_supports_baco(dev)) {
>>> +                       switch (adev->asic_type) {
>>> +                       case CHIP_VEGA10:
>>> +                               /* enable BACO as runpm mode if noretry=0 */
>>> +                               if (!adev->gmc.noretry)
>>> +                                       adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> +                               break;
>>> +                       default:
>>> +                               /* enable BACO as runpm mode on CI+ */
>>>                                 adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> -                       break;
>>> -               default:
>>> -                       /* enable BACO as runpm mode on CI+ */
>>> -                       adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> -                       break;
>>> -               }
>>> +                               break;
>>> +                       }
>>>
>>> -               if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>>> -                       dev_info(adev->dev, "Using BACO for runtime pm\n");
>>> +                       if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>>> +                               dev_info(adev->dev, "Using BACO for runtime pm\n");
>>> +               }
>>>         }
>>>
>>> +       if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>>> +               dev_info(adev->dev, "No PM mode for runtime pm\n");
>>> +
>>>         /* Call ACPI methods: require modeset init
>>>          * but failure is not fatal
>>>          */
>>> -
>>>         acpi_status = amdgpu_acpi_init(adev);
>>>         if (acpi_status)
>>>                 dev_dbg(dev->dev, "Error during ACPI methods call\n");
>>> --
>>> 2.34.1
>>>
