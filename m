Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1892C5478C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 16:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B64210EFC9;
	Mon, 26 Feb 2024 16:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t8DUomTZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C1910EE86
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 16:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLiDPFwHq2yeSMatc54TVcOlwhiiHUFnu9bcYI0lo62c0K+V5cWZ9NeIUMWVRfq4RRGowD4LunIBCIw463u+BEV0naFVB+Pfj6cXhwTdyRCnrZe6nBHp7BTmiwL5ffQA3fnTnYZYtAGFDRVvdVW7klPh8sTJNeH9xB8WLTHe9Un7yZcUr9gYmxqGqxPrPMHzAz3pyQwkzPH8XRw5UP21UPf53ap33+IDL8xE8Z4YWneTJoKCuFVGMiX0xR1jN7QKr09iTj+Ettz4XM27EEKxjX/087RKUGdTQX/bQCDNLqx5vZWVObM4lb7bEw+hd0QzsE+orVjpTE16D1P/65V4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78h97sLBl1F8bl+gACM7dBavynXt1xYW6wxsGKNJNfo=;
 b=Kvp4vnSBNpZIye5p9xy0E9xfu9e/TFnjQjXG6MmCPdgiPuKRuuKuAuBgK230sT2DMXSt8AMcxzhH6v1aWfZbadOqF7KXph0WqmziuEwEEuyBXwp+JuQD6aHM53afIFaOzu4Dwn9USS/q2gk2rGDFvvejTFhfXL82z0/3Nuizw+ltR8c36z4WoZpud1txDvtRxqImeeRJdrR6Gm9dIPi2L0aV10dpM5jyPcCwv+VmxziSCgiWjAq1XwRChA6rlJ20IIHGiD4QKz3VdV9ZIjTjQIcciKaxbLhp0PCdploDT+lAlFhiiTn7FGrJtMZ4vRKm8lRCEjnn+ovzHDRs/H5qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78h97sLBl1F8bl+gACM7dBavynXt1xYW6wxsGKNJNfo=;
 b=t8DUomTZaB6WstbbzazEAgOSRnP6uMxJRLg5QZdd4frQuFxibB0ifIzOjyU6yALrhQnTkPd09yyRfiFIfKVAao5+wIs8n8GyjQK2QoQ8H4Wwnc6sOsmZHkHX+SPd7ftRNSRHq76GsjVF47rTeaMbp6D4nZzN1pTcY86WLb2LYY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 16:02:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7316.031; Mon, 26 Feb 2024
 16:02:33 +0000
Message-ID: <9577db1c-ec96-4508-aa74-f9284761f361@amd.com>
Date: Mon, 26 Feb 2024 17:02:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable ring_muxer if mcbp is off
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240223094132.880396-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_MLkUTnLE=eFFSEV5gEq0gd3GobB5Pwsf5dJfG0MPOEgw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MLkUTnLE=eFFSEV5gEq0gd3GobB5Pwsf5dJfG0MPOEgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: d460df40-28f5-4e37-e8e9-08dc36e4578a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFBaVVDFzj6LAqE2/Li83ABEn+MlUPf9vr+JN2UK9iIgBbTHutVtDzEOF6qfa9bYmLQOzT/sQKgnLQ+UYdPQ5VH3HUVvxnEnBlUkqGyqlrW/sjnSo3BHDEh0UlLujyTKg/Z/VOcAF4P5KsSJdmIacDMZexDXQQOnK4CiHPW8XAuMvjXc8UQw6dmeLNpQxpuAeL6z88EaZn7NXSsy+A1ISSYKBiQDETlNS/qub5wDqpyAAIjUq6m/lvgRIFP7eO3Q/QIA0XjKoITDSdP2ksm6I2lKw2zH1pGTJDF0sLKKQUC4BBFmmKbJO2y8QYrpiiyW2LHcxO5wE6CaFJiJltTKAjWfa/RwEbMX+zDopZBr1trO4C49z4Ff0hZgwPvRunJXzaWZRa/u8vdcUtmnrhxpE9+xeIoZpTlWELuYBpaiOUlHz5n/IzDZM3fbvuOPxUo+aLoITrfAR411GcUASSL+9n4RfKplri3T4k4550EpUdWSJr1t5+JePfdZB5CI7Eun12d2fZDSxoM8LBjItxuudk1oXN+V0w3OlV+zUUV4uNZnxSxDlWUe9ni84MaKdteaqxcpW6y9MNR3TBschkfxpfSyHHLoK3gtxBWjsuco3+QRavrqggNnzJFGhuahtTTG9jQ7nvqMG1/u2bzptvc9eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURKYXhSL3pFbCtjd0pWUGp0ZTBBMWNKajZERmJXNmNRdHZKLzhyVkhQT1dV?=
 =?utf-8?B?b1NvQVVSQXcwbnFQajJheklja3hQZW1PN2o3WGZnaGxGZE81cExWSW80bHR0?=
 =?utf-8?B?Mi9WeUJDajhhcTQxSG1tSUNQUGJFNDUrN0hRczkvRXVGcTNtQVBNeWMrS3lX?=
 =?utf-8?B?ajhTYmJIZkZsMWRVQm1VOExYVUNUVDMzWVZqdjMwRFk4cnNxVHBzNWFab3RD?=
 =?utf-8?B?T0ttR1Vad3VWOEVBRFIxSUZzbXA2NGZIdEptMmZXYmJIZkFDZEhTN2czTnIx?=
 =?utf-8?B?bnl2QXVMTUg2dUJSQ3ZTNVVnS0tCVGNmREtIUVBqeDhqblBpQm5QK0tTbGsz?=
 =?utf-8?B?VEdHdlg2S1ZKRVFwSm1YdG5MQ2p4L2loQU1ZZDNVbzBiQ3c4Wkh2cHBwdVZL?=
 =?utf-8?B?ZlZXck5qMFlNclh4MHFmaVRsTmJ6SmJqY0tIOU5ibmtuNldsenJ5UTg2Z2tq?=
 =?utf-8?B?WlNubDA5V0h3a3JVUnlHUlp2Rk9kejd6ZXE0ZHRYTU8zYWVhdWt6WG5aei9t?=
 =?utf-8?B?ZGNKQ3RQclJyeE5sZzdSWUdjdzF0UERBNkdodDRiUnBSck9McldKa2t0a0o2?=
 =?utf-8?B?V0hHSmJMRTlQdzkveXQ2RzU1QWFSODV4TzhTWmRjMloyY1NnVTVoM3VjQWg3?=
 =?utf-8?B?YVdlc21zK0FUOWV0WGNVcmM2Qk8yS3F2dmlkaGt5M2hzODJ3b3l4UEtkYjhx?=
 =?utf-8?B?U3F3SzYycC84dkpPSWE3VmpBSWtUTWlSd0dHSWxYakExb3ZjckZRcnc4eUlm?=
 =?utf-8?B?TEhvNFRMb1lnUThKTHRhSTBBV3FOMGhxaW54ZTRYaDBUNlNuUUdGMUl3aVlB?=
 =?utf-8?B?alpja1d0em1Oa3RKb3pULzR6eThLZGFEaEk5SkRLR3ZLSWdMc0xEN3k4eXQ5?=
 =?utf-8?B?WkJGSVIraEZwWW9xZkNkTEMzUGpzR0svNlowR09JV200TkFoK3MweDlDc2x0?=
 =?utf-8?B?VzdpTVpjVko5S3NNamhTbXdwbERYbnZ6MERIb3IyYUlDdGozNjF4WEFaM1pC?=
 =?utf-8?B?Q3N2U0FEZUptZ1dvRFg0SlF6YUViTW0rcURrQVBxUWZCZWQ5eGZEVUxKTUtv?=
 =?utf-8?B?M0p0dVFoaW03bDVJeWM3U3UySUl5VVc2d0cxRzhLanBJcTFaeUlVRlcvYjNj?=
 =?utf-8?B?S29TcE9EdFl0NXRkQVE1dk43ZnkwOGNtU095TWQ4d0RJeEVtejd6ODhLSmNZ?=
 =?utf-8?B?U1cxYUticzlpbnlVL2RTaDNYbmJoUG4rUklORFp0MHFmTFZjTFI1VWczZVpK?=
 =?utf-8?B?M3JJSnRWVFdkTjlzU1FybjRpR2djaXlGbUZvbXcwWGlZOCtxS2RPZ2p0eEdV?=
 =?utf-8?B?eC9QNno0VmlOVHFjS0NkKzBRaGlEMVlmYW5HN0ZQYUF2bXhPU3RVQzRmOXVI?=
 =?utf-8?B?czVQb21SVWtzTXdxOHFJOTdjUHZpRWdPazZnR1FFSE05bVhWQ0dUZXZzZjdR?=
 =?utf-8?B?TnVYaG1hVWVEcXVPSjBXbXkzbXBqMVdFWkpjQkJrSEtjRG5QUHdvd0Izbkhk?=
 =?utf-8?B?cnAra3k1RzFOaTdvWE85NXFESS8wc3dWaExDcVNaZ2tiQ00zRmxjckswQXBH?=
 =?utf-8?B?RWd6Sm8vcFFrem9WNEJ3ck1CZ21KL3VpWlFpeU1KbzZuZUwzVVhsSldOS1F4?=
 =?utf-8?B?dkNRcjdlNzZDRjk2ZjFlQXFzajR2M1RySVhPRFNadDJOUDhyK3MvUXVETHlk?=
 =?utf-8?B?eTdJcWFEdUtzbTZ5TmphUUhRTERXdzQzeWlvdzlhWkR3S1BQdzIwYzJvQS9k?=
 =?utf-8?B?VWU3MG95bVBtMzdtaTFlS1crQTRMdTJvV2g2c1F0Z09rMlpoWWd6Y0VwQ2Nt?=
 =?utf-8?B?QlFtaVYxT2dyQXI0bHhBZGxIODBaaVhkSmN3c2dCQ2ZJc2lrbGc0d2YrS3Jp?=
 =?utf-8?B?RmVLQUVyZzRoeFRlampqOEJUMVFOeGZwbDRjTXRORDFEVk5ZZ2c2TWtnVnNK?=
 =?utf-8?B?QlJBUVovZDVITHRGQXp4VTc0UlNWNnJsVFVtbU9wT1pOazRYcFloYW5ONHkz?=
 =?utf-8?B?WEdhRGZlR2EyRThiTlYwR0Y1NStOak4wSkFOeXRTZTV6ekhJbythNDJvS3lZ?=
 =?utf-8?B?WWVreFRvNjFXT0VuRVY5VmM4MGs3N2ZGZHBBVnFoME1nckpQT29oTUM4ZDFH?=
 =?utf-8?Q?R/Rve6O327IZ9r1QX2Ug2g9ZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d460df40-28f5-4e37-e8e9-08dc36e4578a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:02:33.1742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrzQTDC5R+/wmCjowfepsEO5v7sR+1fKfcON+tfEHLZEsyYkp5H+Z2sgjVpKWIkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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

Am 23.02.24 um 17:30 schrieb Alex Deucher:
> On Fri, Feb 23, 2024 at 4:48 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> wrote:
>> Using the ring_muxer without preemption adds overhead for no
>> reason since mcbp cannot be triggered.
>>
>> Moving back to a single queue in this case also helps when
>> high priority app are used: in this case the gpu_scheduler
>> priority handling will work as expected - much better than
>> ring_muxer with its 2 independant schedulers competing for
>> the same hardware queue.
>>
>> This change requires moving amdgpu_device_set_mcbp above
>> amdgpu_device_ip_early_init because we use adev->gfx.mcbp.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 21 ++++++++++++---------
>>   2 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index d534e192e260..40516d24026c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4054,13 +4054,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> +       amdgpu_device_set_mcbp(adev);
>> +
>>          /* early init functions */
>>          r = amdgpu_device_ip_early_init(adev);
>>          if (r)
>>                  return r;
>>
>> -       amdgpu_device_set_mcbp(adev);
>> -
>>          /* Get rid of things like offb */
>>          r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
>>          if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 169d45268ef6..f682f830f7f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2080,7 +2080,7 @@ static int gfx_v9_0_sw_init(void *handle)
>>                  ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
>>
>>                  /* disable scheduler on the real ring */
>> -               ring->no_scheduler = true;
>> +               ring->no_scheduler = adev->gfx.mcbp;
>>                  ring->vm_hub = AMDGPU_GFXHUB(0);
>>                  r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>>                                       AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
>> @@ -2090,7 +2090,7 @@ static int gfx_v9_0_sw_init(void *handle)
>>          }
>>
>>          /* set up the software rings */
>> -       if (adev->gfx.num_gfx_rings) {
>> +       if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
>>                  for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
>>                          ring = &adev->gfx.sw_gfx_ring[i];
>>                          ring->ring_obj = NULL;
>> @@ -2181,7 +2181,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>>          int i;
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>> -       if (adev->gfx.num_gfx_rings) {
>> +       if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
>>                  for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>>                          amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
>>                  amdgpu_ring_mux_fini(&adev->gfx.muxer);
>> @@ -5910,11 +5910,14 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>>
>>          switch (me_id) {
>>          case 0:
>> -               if (adev->gfx.num_gfx_rings &&
>> -                   !amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
>> -                       /* Fence signals are handled on the software rings*/
>> -                       for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>> -                               amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
>> +               if (adev->gfx.num_gfx_rings) {
>> +                       if (!adev->gfx.mcbp) {
>> +                               amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
>> +                       } else if (!amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
>> +                               /* Fence signals are handled on the software rings*/
>> +                               for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>> +                                       amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
>> +                       }
>>                  }
>>                  break;
>>          case 1:
>> @@ -7051,7 +7054,7 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>>          for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>>                  adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
>>
>> -       if (adev->gfx.num_gfx_rings) {
>> +       if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
>>                  for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>>                          adev->gfx.sw_gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
>>          }
>> --
>> 2.40.1
>>

