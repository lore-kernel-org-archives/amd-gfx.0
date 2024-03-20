Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B447C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 13:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED09310E148;
	Wed, 20 Mar 2024 13:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXh24zsP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23AD10E148
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 13:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhHOcZFHES6O6WdCV8/zBYggK1J7dTYdu8CIsM8bQwLvFOMvW9tqzExZOtav2JsFQxk2xbUQvwrnndEkbiPCazpRCX2P/T9mUPsBtQrzTmLhQawOlT1qUyelyvlT/KsyTD9p43DkOis6DtIF/MoGxSaHeTqyhl0OvLeZo2sgNEAjc2WscB0mbefHCMaVJS+cppap8B51K8qDyjpbcjISYgH0zvl5hx04Ure2aEvMtx2pScExLpRDSo/Mg6rJBOVA5lq917/YrmODpO2Jym77AfMrx0k09Eln9ZERkbTHPC0HMNdfV44QUKUC8TEmEjNYZqooOVMBGqkCN7m7xyqvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t50QNqHOgk2SQhcQmqDARmNjg8ulRwtGJjJ43fDtPJo=;
 b=aYV60L06uCFVh/QJQQi5mrHPo71AqVwhvm3Qmj9n0pCPhMqRC0DjCCtQD605QN4rJ9Xyxf8ANmrZcjxr/iI/1xYxNpI53TkBo4udxxoC82rCXHg4ofgKhwZE/uC6QRgvvBGEKnPnT+40Sh0rMGCXMIJoa7QpRXjjUsOEQhvSH7SvZVY0yMWSsLJn2LC75guVnNuh9ihpOci9lS7htGTGKauhqy8BQ3e62jQmXtnVpuX5AV9N6tLYHHtVO7KfGM6ChQOl8CpU3t7UkB9ANAZuM8rvAR0cqPHgDPWsTYcmAB4cISspqjVTg7XqItoXk8E3KKXyseZp2dLuVf0DXTq6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t50QNqHOgk2SQhcQmqDARmNjg8ulRwtGJjJ43fDtPJo=;
 b=LXh24zsPnOKebwnJmD9/aC/JBIXRjvQWurgXlHrOvdeGsGk+RWoyjlP2955RokPsgn2GhF65KrPsxohMC9964ZEmLb35ndrNO0AQBV6XEtlGBgRqJ2Ov7EjlN1PPzLOBxzz9Rim4dCHSwE3plD890RaY1ACSCUfo0mvAL9tHXxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 13:38:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 13:38:38 +0000
Message-ID: <cefa5729-e523-4d19-bd1e-d399e255eec3@amd.com>
Date: Wed, 20 Mar 2024 19:08:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime pm mode error
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20240320100926.2614497-1-Jun.Ma2@amd.com>
 <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6569fd-96b1-4403-fdcc-08dc48e30bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNgLDgix7L4Yyebap9k4GkoArhMpJvbiyUSBt8JaTzNC9nAzzEeBifPEdrz6KPqa0PIwqa6eRwn46veH6ex3YyO65F2o/ut6MBQkSmu07i8w1BfZwKPJuF/aSsxyi9ezqMmq0NJaCGoL9sb/7O83zO3Nl+k2W8SzBv0zypLk/kagWW0mcVahixuD8ZYJV9hBOzBIyV3EJwT6ByP7rU9IhOOxuVsaC6Qc0+H7EP3yDCe9+95glalTrCLt3UVJLxEz5eyhjzEAQuKIn5GGH/HBoK7Gvn3xlsq4VY5dYKmXyuqlk5icHwv8umATiHJQNXCKz4K81X2cX82vf9AzVRBBCaMHboi2pMOhSgB/DoGbMi5txVYpbbOcFMJY1HmBVLr3un1DO2DHZfaslyiwluxB7Yp9TJsl7778scxqHE1TQIEAqjRvdTLsJ6vf2k958KG8sGgdAJAaklVhfk7tbQ7UBVk4d0Q9dO8LJs+2e8ykCtZ9zLs5lmrknPVgXHHECBqGvcEJv0abEbmaMC27oSEoWmOBYjtEzYRmS+4trOHwpz7cEPTxfSMKMr4xXh4OMB/pbFEQJvHygrKfMZbKiYdHh5PY06M+orZvU46SUoy3VPQqsBkaiSkiI5UflLmfqe+Y1VTI1Da/kys92jJ/dWr22OxfbxohooB9LujhzMoGh/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRoaGdmTlYxN0x3b3dtWnZkbHYvOURDK0pocTg2eU5iVmJEZGthZDJUZ3cw?=
 =?utf-8?B?WXhJeXVWSHJibVJHSXdwOU9TK0Z4UFhmenZ1T3VRTzNHM1ZxdFV2bkU2Vmdr?=
 =?utf-8?B?bTdNd1dXSmJ3MGlhWkN0VUZnbXpGU2U2cFkxc01NTXR5RHBxdGJGOHVKR3c3?=
 =?utf-8?B?ZnM5QVo1WGlwU1NRd0tkWnBjcW96bHRHYjkrbnNFeE5Zcm9lcW03UkNDU3dS?=
 =?utf-8?B?eGtubzBSMEFVODVVYVBqVDFxMG9YaHBiZ3k2a2VuSmVWUG84dVl6WnRXVTlM?=
 =?utf-8?B?UWZrc2N2SHpnZHd6QTA1MGZPb08rb1pPQzNsc05uY0dwU0xBZ1Q4bmUxMEZ6?=
 =?utf-8?B?dVZDTHlNMjlpbm5ONWJSNktMUDFWMy9IS3Z1Wjc0K1IwZXpYMlk0OWRoUG1a?=
 =?utf-8?B?bElQRjUxQVVJeVBRVy8wZTZKOGh5UFVjYTlva0FtekIyOWVzR09RanZ6MW5E?=
 =?utf-8?B?bTh1OEF5a0tHZEpCa3RUVVp2NDI4N2NSYStaTzBxTU1HQXBJT0Eybmw5cmJj?=
 =?utf-8?B?MGx0cnpqTTRBU0ZvdVBhbk8vT0RCam15WTlWSW5oemxOcGRaRnZmUjFManlE?=
 =?utf-8?B?eTY0UlhkeXZMRmtMZ29CR3ZOL2ZMd2lkZDZKTy9uWWhVS1BoQ2Q4MDFFR1U0?=
 =?utf-8?B?TVFOUHdCMGc3YXQwbjI2T05scWpVL0ozcE56RE1xOXN0Q2tJVE1qa0ZJU2lU?=
 =?utf-8?B?WXAySlVTWFYzalE3ekdWcldQRklLdTQ0WkVOM2VHZFJQVW1lZGVJazhtT1VC?=
 =?utf-8?B?RGtWVkxOK1M4dXdQSktWVG5XdWtEbC8vQmRsT2JGQ1NPTm45ekExeC8wSzRS?=
 =?utf-8?B?bDJGQ2FoSFpEdGY4NlhCOWN2cFNKNGphSXUxTlVWNFRRNC9CakVUOEx3dU9x?=
 =?utf-8?B?TGw2ZVRTL3BXeWp0SklCdDFmekxBTkpVZHo3VE9iWmVzTXhOQ1E5VldHd2k3?=
 =?utf-8?B?dHlMMEo2OUtJYzlsZE9VTzNwaWh6Ry8rR29jL2w3T2RPMjJ1Zk5MLzA5K3VX?=
 =?utf-8?B?d2ZmamhPSG51NjI0cWE1VGZUeld1R1grMFJnOFBldCtkQ1MzZ3JncVVoVFNq?=
 =?utf-8?B?N0k4RXJzeE5RVUd0TVdzMVFXRHlZYTJOVGF0ZXZ4TVRnY2dpaExNc08zR0g3?=
 =?utf-8?B?N1dTMWZ5VjlpcUZEckZCQng5UVhDanc5RENndTZCM3JKK0JSR204Ulppd1hs?=
 =?utf-8?B?bmVqWEJYZmlxQVpSU08zUXRaNnFjazNnalRrK3VBMGR4Ny9CTFBRU3NRWVdu?=
 =?utf-8?B?OUVqRHVhdzA4VjdjRmh2cXJCOTlGb3ViSC9RdG93VlZxSm5TQWozb1hIU0JY?=
 =?utf-8?B?azFTOHUrVlB3SG9DMUVjTi9WazF2ZE5kVTBxRWdwM1RwMFJFSWl1MjFPUFda?=
 =?utf-8?B?NkRCMC9VTE1STWF3c01aMVdrT3dwNGxKZ3Y2WUVZTmpNVnNRUDBxYUlaRW9r?=
 =?utf-8?B?VnA1NkZHSFE1V3pKcHNONnFORmd2K0V6NTVoNlBxSklZcWp1bFVkQ05sSTdS?=
 =?utf-8?B?S0pBdHM4ejlQK2JaZDBOUXZ5ejNndENCUmFEcDQzbkNaUC81SDFFQndlKzNw?=
 =?utf-8?B?MlF5YzJPbWZ6WTdOWG1iV210d3drN3puM1ovNmZrQWh3MTV4YWQ2ZjNBdXVy?=
 =?utf-8?B?SnNDdjlDdW50a3RnUVZJUHVEWWtSMjAxRGlyb3RvcUVzelFIOVFqUjk3dXVp?=
 =?utf-8?B?elQ2c0lpSncyQ1BFVFZlaGVPZ1N3eWdoN2ZScDBwb2dob3Y4ZXZMMmVPRFJ2?=
 =?utf-8?B?ekdJdkhlTy95VStVelJYbEVpOUx0NlFUODhkVjFMdjd2Wlk2VmZNdEora2VR?=
 =?utf-8?B?WTJWdndKS2V4SXlhUzFjc3FzOGhDb0tZNnQ0WVNWWHVrMG56cEpIV3FsaGt0?=
 =?utf-8?B?NlFTYVlmdXZCalZIUHRlZVpFUGpsNTRNVVVuaHNGbE9ZdE5lblA2QXV4aFpE?=
 =?utf-8?B?YlVmWjlySGJnNTlGUjZKS2ZBU1pzdEtaQlY4R1d3NUF6VjBKWk5sQ1FCVW1D?=
 =?utf-8?B?TzJFbjJwYlh0bnJPTzlsUnp1Z0owWmw1ajVNY3d5eElzZGpadnBmdzIwV3E3?=
 =?utf-8?B?cHdGSDZ3aEFudmZmZWFuVjlyMlZxSHVuSXVRYWdyVjUzM2FXb1YrUWNkcGFy?=
 =?utf-8?Q?cy66u4ZKDCGzimYCmctaGt7rO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6569fd-96b1-4403-fdcc-08dc48e30bfc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:38:37.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaTGDjvANBTWNQOzfek/HZJZaZG0wVPOYewQn31KKlnlDMORuntq4XXiixnTJW1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010
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



On 3/20/2024 6:54 PM, Alex Deucher wrote:
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

Also, based on the comment it appears as if runpm is not intended to be
enabled by default on Vega20/Arcturus (unless forced by module parameter).

Thanks,
Lijo

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
