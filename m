Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8A3C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 06:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB1010F38A;
	Thu, 21 Mar 2024 06:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s4iKZkql";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C02E10F38A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 06:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWjusNmEj54popgeajLC1QOfmv3+2hXEIxR+aK1pC4u0zn36AlVn3sXmqQE4uoYpIwit92K4yW3bSccS3u7NbHUCSdSvlsPeQB+e44teLpXC0U2fNp8WhLQ1l5gBcoumMMNjcUPH3l8bp/ODewxRRDRP624Q0f2GI51AhvON3WoOELN7EulpMFIJjd4Ygla+XgTvEcyNjMfYoGdcxqnffH/Tdxjsi9D5vFCVD8+dTgX/RV86V/7ZqQurXSRxweUY5c1Qg7sTbZeSr8SvCKEFQbWVIEeYNywuPsnLqPon75DtDWG4l/sqtyffx3c1+Lma3bybqCwbUAaFu1BN/szuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPoFMt8INNvzmPoaMF9lKNp6XTxJx3whHaPEdRoXPYc=;
 b=DgAYqkSZTXeYR5ZFqDinmau8Vuf2rAyFVAX2/fLOLuzC2CwwRSqjU/Br8A+M0a4PQWM/fmzzP3uLDC85vtEObujHplafrnp6ucQZe+LmyzwPpIWFYtGmdxJ4f1scsGdZSj9dVDlUOVfbse5Nn9zpMInDd7csh5GdPa3pweRDyY5G1jjD7lSRb0Snohg32PGr2OBQ22CKlSQMzGfTBEgH8WATzQO9YOOznQJjC79AD6lHF+OkGFTXG/mtsSQFJ9QkBreet68DjLKbR9d3f3VJQ9CvpFlqEAS+acrvltbKSfSMltZgvpdtgvvlvVLhzKKiTtPGMpxPDwJjp4qUMyrdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPoFMt8INNvzmPoaMF9lKNp6XTxJx3whHaPEdRoXPYc=;
 b=s4iKZkqlFSSuLwVaAz8zTZEPlSCwDIYO2eCsyuBoFdyB8G3iFfx4+XxYVJrPn+nSYZvbYtXrdJpOR2nqX6jvj2djFQDqMTNV1oTW8UfRBJ5wNlk/AoadG+nPN9jjyRV3vs0wPunGXXqHwgCqZkUVMUwu2jrZuNCT2X/xtrCSxzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Thu, 21 Mar 2024 06:52:35 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 06:52:35 +0000
Message-ID: <dc037723-81ca-4739-8fde-4c82da60b293@amd.com>
Date: Thu, 21 Mar 2024 14:51:58 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime pm mode error
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
References: <20240320100926.2614497-1-Jun.Ma2@amd.com>
 <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0103.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::19) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: e924003a-b9d3-4374-02fa-08dc49737d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCPOFAKUhONoNsJ84CN1g9vCXt3H65IKZThp8MbNm5Ratr9hJjLXrcGgz1afPE8fb3OjuXPdJP73GmaES/nvBSUJ2Zqyn/JCPuU7L7e121R3Krd3htNXhXausnBse2cua1PfsHrnjgSROs2/7BUEJVabmyQAGw935SIPDx3oO/ybeBCaBikm365g1A1DJWMOPO5NYYFPQL9mFiJVXvt4PJRAUCHbvt4gCwgPwp/Dvyr6Vagxg6XlRcEKcrLcDy1fvKC0wr6fkADgNMPsxuVTJuwt1+8tzwkwugaVDUBh9G6+zhmQZOROtvb3moRS0o0dApy98WbBv44SQ/Kb9FiraUMXTW72i15f7pWm7N48aR08Ma/fQwz2gHbTYN4+wYNjO2reklpj3MBsPh2AhigndDjzZeJ4MS0DtlwxTQ2vPQXIXEWwemvQcne2zmP8bHIzBXpCri8opuKss4CsaUKFxUwq4z7/K2YNSc0ZRxsQ+SfcFPbnQ9/9eXPPEGhvZZxdoQqM6cCpQofer3PbkfKffc7DGBLXcAIozjc77Z3gufZPw/lWJzSSHLUrlbO2Op0PzUog6mkKX+WA+KMm0VqhPoSXhmU6dCdKk8rbFTVIJbOTVKLkpDYVRn5qk2KlzE1pc7MEpCBV2szJ+hpOoQ1W9LeTSZwVae8XxX8kRgW15Bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdiUDRHRktQT0hJSG5nSzQ5RUgrUlYzaHJEQ2c2N01sOXdHSDZFT0pYQ3RU?=
 =?utf-8?B?NkhNaURML3hCRlc3WEpqK3NiNitVWkpXdHo1S3d1WXN5UHNEdEtNdFp1SW0v?=
 =?utf-8?B?cDc3SHMxMEFHM3R1Ty9HTENnSVBHN3h5TEx3Rmtpbjl3aFBpQzRYeGRsQ3BI?=
 =?utf-8?B?M3dDMHlMS0UvSzBaQ3JCRExETldidkZIc3FWdkFYSU1OQlZ2d09DVVlsRHZV?=
 =?utf-8?B?N3h5YU1WdUVQTCtEMk5WK3o3bHJVcFQvK09GYzVmQWw1dzVJeUU1VXZkY25I?=
 =?utf-8?B?cFJjTTVwdXo3aUJqamlPWUt3OFFxdzN1STRSTTFsSTdVQUNySTQ3cW4yUUI3?=
 =?utf-8?B?eHVqaml2VVJGazZYeEtXV1lkM2J6UVRES0hmNksxWnZoZEpOZnhqWDZiTWpn?=
 =?utf-8?B?SXgxQTljY1BZbmhnT0Z4WVBkajJWRzhBbGoyUkxYdDdTYVZjL0VCOFo2N3FF?=
 =?utf-8?B?ZlhXSUNERWpNN3V0N1dQSVFUTlQ5R1Eyek0yaXFzOUpmZmF6U051aVZRY1lJ?=
 =?utf-8?B?WW02SmZFbjRDZWVnVGtuVkNkbkhsY2krREp3V1RrbWM2aW1EK1Q3VCs1UWNs?=
 =?utf-8?B?b3dHRDRlZS9oQy9CQWp4dGVoQmF0TE1rMWNZYXZzbmFPZFozOG1QL3d5c25V?=
 =?utf-8?B?SEIxZlJwMEV6R2ViMHhTc2FUSXNkbW5OdmFMbTQ2RjdCSFBhSzMvd3MvM0JI?=
 =?utf-8?B?bWNRUDExV2N3S3Qva3NScFE1cUVjNlM2azU4RG9RcG8waVZ5SVJkOEtXYWtY?=
 =?utf-8?B?RW1LRGhpWUVtSmxORzlJdWhsaFpOWHFxOXN5VEtWcS9PT0M5OUN6YkdMMkdL?=
 =?utf-8?B?VXZTSlBzdDEvc1QvUXVCUWNYVFFPMU5PRHZFZ2lKUzBJV1pTU3h2T3NYZ3JC?=
 =?utf-8?B?Nlo4Y0Y3UGlJV0dCbGZGVyt1M3dOckUzOWpGM0lsNnJJYk1QaXRmYVRjcmpX?=
 =?utf-8?B?RHd3R3pwc214YXZadVNLUzZzclByLzFiWUx5aElpbktUWFBBS2JPSFNGWEFM?=
 =?utf-8?B?cXFQM2grVjF3NUZwNnErdVVPVXhXN3VDWlVYeUlWMERnR3o1TUUzV2NmR2tK?=
 =?utf-8?B?N2c2MEJCYXJQOUUvSjY1cmFUZ2lzM29VWjU5RVdQK1g2Q3kzS0hPOXduYlhp?=
 =?utf-8?B?SnRKT00wV1QvL3BHS1p4QXJjSWVtS1pUeHFHbVd2WXE3dEhhSDhkMWpSSWhw?=
 =?utf-8?B?MmIzRlhOekM1RTNSMHB6MWwvR0VXSkpDME96Q2xwQ2VTcnpwOEE4LzQzbHdG?=
 =?utf-8?B?U0NkMkFHSEdCa3lLR3I1dzlISXVPR3R0bUN5SHJLRkxlUFVTQno4c1pKYThm?=
 =?utf-8?B?SFpCeWw5WldtcjI3VEtkR0J4QThpTGxyU0JDWmhjcVJKU3BJdzQ1OVhBamd6?=
 =?utf-8?B?cnRKRGlEOTdlTGp3SThVeTRlL0paZEtEeWVZQXFuUzVUTVdpQnY1WVFnODVX?=
 =?utf-8?B?UEkvNURxaFpjeUFsOUZxWlVrV3NmeHNQSStMMFlKUC9OdnVGanpZeHF0cHlu?=
 =?utf-8?B?VlNackpNZnZ5cVdXU09NRVhYQis5b0JYQnhocVF0R2NsNjNqVlh5TlVIeVM4?=
 =?utf-8?B?S3FBTW1MUVgzYWR5bWRFNExVVzJmeGRUalgxU0VwcUZtMC9kV2QzZkVXYnlV?=
 =?utf-8?B?enhtTUViMW1xYSs0TFl2NGtsSnhPZW4vY2lUeFVMcmNMSFU4dGgzYjNuQ2hy?=
 =?utf-8?B?OVhlM1pWQ1c3Zlgzdi9PM2xsb1lUZllMRFgzZk5TSFBlYkpnNmtwKzN2VHNC?=
 =?utf-8?B?NVRwYmkvMlVOdTZ0VlhMcEc4dzNVVU40SDB1a3JZcHltYkJ6MnhhNVZLV3hs?=
 =?utf-8?B?Yzg2N2hYSEprU3FxS1VzM29UUUVUZndNSlc2RmNEdEdFbStHcUw4allQYk9a?=
 =?utf-8?B?UlQ1a0xPWEJueHIxNlJvM0pOdjVoZDFoeFQ5Z2ZldXQ1VVBrNllzYTU3c2pE?=
 =?utf-8?B?MG15bTQzdElOU0N4WXFMMUx1MDFRblpKWC95QWRiby9WRFdrRnNBQzFyVkli?=
 =?utf-8?B?b1pHcEhnSU1FOGNqL0dtYUFydE5lRG0wSUo1NlpuUXhiNWVocmFTUXB5OSs5?=
 =?utf-8?B?TWkvQ3dQYkk4Z2w4dkpRanVNMnJFbisrMW1vYkhJQnJFUUV3YUpLMisvSnFn?=
 =?utf-8?Q?SvmF8VmydknmEgqQlXdVOvYFp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e924003a-b9d3-4374-02fa-08dc49737d4d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 06:52:35.3051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z5Mr6bzaHqgRNfy0YoaF3/8wsP4WxL9SrHRECsRIlkmNv+fej5AX/T74351TSPQ
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



On 3/20/2024 9:24 PM, Alex Deucher wrote:
> On Wed, Mar 20, 2024 at 6:17 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>
>> Because of the logic error, Arcturus and vega20 currently
>> use the AMDGPU_RUNPM_NONE for runtime pm even though they
>> support BACO. So, the code is optimized to fix this error.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 56 ++++++++++++-------------
>>  1 file changed, 27 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 1f92fb1e7421..70cf2d0c7683 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -150,42 +150,40 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>         }
>>
>>         adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
>> -       if (amdgpu_device_supports_px(dev) &&
>> -           (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
>> -               adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>> -               dev_info(adev->dev, "Using ATPX for runtime pm\n");
>> -       } else if (amdgpu_device_supports_boco(dev) &&
>> -                  (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
>> -               adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>> -               dev_info(adev->dev, "Using BOCO for runtime pm\n");
>> -       } else if (amdgpu_device_supports_baco(dev) &&
>> -                  (amdgpu_runtime_pm != 0)) {
>> -               switch (adev->asic_type) {
>> -               case CHIP_VEGA20:
>> -               case CHIP_ARCTURUS:
>> -                       /* enable BACO as runpm mode if runpm=1 */
>> -                       if (amdgpu_runtime_pm > 0)
>> -                               adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> -                       break;
>> -               case CHIP_VEGA10:
>> -                       /* enable BACO as runpm mode if noretry=0 */
>> -                       if (!adev->gmc.noretry)
>> +       if (amdgpu_runtime_pm > 0) {
>> +               adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> +               dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> 
> Does this need special handling for BAMACO?  Setting
> amdgpu_runtime_pm=2 is supposed to set BAMACO and 1 is supposed to
> force BACO.
> 

BAMACO currently is detected in pptable_funcs->baco_enter() and baco_exit function.
We just need to set BACO flag here. 

How about adding a new mode AMDGPU_RUNPM_BAMACO, so we only have to check
amdgpu_runtime_pm and detect the PM mode in initialization stage and don't
need to handle it later.

Regards,
Ma Jun

> Alex
> 
>> +       } else if (amdgpu_runtime_pm != 0) {
>> +               if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
>> +                       adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>> +                       dev_info(adev->dev, "Using ATPX for runtime pm\n");
>> +               } else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
>> +                       adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>> +                       dev_info(adev->dev, "Using BOCO for runtime pm\n");
>> +               } else if (amdgpu_device_supports_baco(dev)) {
>> +                       switch (adev->asic_type) {
>> +                       case CHIP_VEGA10:
>> +                               /* enable BACO as runpm mode if noretry=0 */
>> +                               if (!adev->gmc.noretry)
>> +                                       adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> +                               break;
>> +                       default:
>> +                               /* enable BACO as runpm mode on CI+ */
>>                                 adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> -                       break;
>> -               default:
>> -                       /* enable BACO as runpm mode on CI+ */
>> -                       adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> -                       break;
>> -               }
>> +                               break;
>> +                       }
>>
>> -               if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>> -                       dev_info(adev->dev, "Using BACO for runtime pm\n");
>> +                       if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>> +                               dev_info(adev->dev, "Using BACO for runtime pm\n");
>> +               }
>>         }
>>
>> +       if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>> +               dev_info(adev->dev, "No PM mode for runtime pm\n");
>> +
>>         /* Call ACPI methods: require modeset init
>>          * but failure is not fatal
>>          */
>> -
>>         acpi_status = amdgpu_acpi_init(adev);
>>         if (acpi_status)
>>                 dev_dbg(dev->dev, "Error during ACPI methods call\n");
>> --
>> 2.34.1
>>
