Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D94DC54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 16:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0112D112BBD;
	Tue,  5 Mar 2024 16:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ACkXiGTq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5BF112BCA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 16:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h01IObzLipS1jb/7tJ/x69R4YbiBlDLYF58nGZ4hJ+AjR59Uh6q/FcVKlMts2UYuJKOIieNWH6t1URtzLDbJEBOSWHZ/i2Jt/atkdJiCjA2pcBpVkrlLwgEpFVYv2CyYhje/eyGuJCfT46wDV4CH0YX5IXz3bDa6QdwaXa/fjzoAI4BJiDe0bMVpCizstUCoSD1V54mQg2nNarHGEmugkvp1dXrqQJqpruOtueIRUBhhVL1mtMhzu7ute1AtVKrLAhLdU8xpykL76DqqDS6BeTuZlHarENASnrbbfPSfuY+bmXm8v+hhOkJ7ZIeODRe5UhWNl2OT0G4EAJ4T0KCslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm3af849caT4R8mzs0o2ZE0iJTy2ipbSkfjGwKmfybw=;
 b=fcLAafqbAHvUI0/JnYnMGDIjr4Ni5wXYnaHvki/2+X5/bs85f8pwjiVeJSrWS4jsQCwUn/AUnLZif36G+g4yzMOmzJpZ576DPM/2xIzYiaZJhiZz12n21K+fikWWzgU0eHSuWdboWf84kuhgOS0/R2u6eknHrdIlBu4v4Mg45lKZYs1/onc1f73yi2wv6V57zI9ZPQyBkv8RwCQLMLv998a2kE78UR5ridj7abc7mtNhiAUutTjYK7/CsuZ3OsBsa2hm/mojt+GEvNtOi9HxPKfzZL6fnCWyJkAhEgVBvHi39F4ZbsYSWTcqwK2rwkConst7U+GTynbahcIBTJv1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm3af849caT4R8mzs0o2ZE0iJTy2ipbSkfjGwKmfybw=;
 b=ACkXiGTqEuYgmDJCXWnrA9QbUtvDzV5S4MGsW2CXBCUpilh9s23KEhK1icscMsKF1MH4zFdsL5/ZgGVYSsmoT/ySFCZTTQsIRJ3gKkljN9EWUJqJZ6TnJ8NEubDN+w7azQcGeC/tT2nRTkSEgyvrp4xF4O7xU09v2zwwAnOiAxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 16:07:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:07:05 +0000
Content-Type: multipart/alternative;
 boundary="------------WXhPTvmOR1dORR1Ust81Zchv"
Message-ID: <8004ad48-00ba-4513-b7be-bd1dbd26c5fb@amd.com>
Date: Tue, 5 Mar 2024 11:07:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Content-Language: en-US
To: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wan, Gavin" <Gavin.Wan@amd.com>
References: <20240304220504.367278-1-Ahmad.Rehman@amd.com>
 <d4413128-92d2-4711-ae46-36369a495868@amd.com>
 <CY5PR12MB60344BA3CFBEAA1BDD9D66648F222@CY5PR12MB6034.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CY5PR12MB60344BA3CFBEAA1BDD9D66648F222@CY5PR12MB6034.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0330.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a71b28-4bf9-429c-3fb6-08dc3d2e4d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHdvhUXMamFynCsW7510TVBPxte8JM7mxmtPbrMi58Q2WRvoITU+Rh4/bzCNEsQ4ej6p7hDujzp+an7/bZVwu+vBP2yOCgEneJN3qnmFzyHJbvc74X4nAO0DSgDVugawEhClHGqKqUQMlWVfGBoLZC36jLnVjDCzio2/aSlpIHRZNlI55e2uGGjSqQ98dYyBlIgO+7bU48/Ub8Dj+x4dZUWKH0kRXyUM2dyBohoNhNxX+N+hBBdzMBTzcfXyrdK1LPRVXJCfRmF5AA0dYRrg29MNTZ+jWABa3iLVyDNj2p2VBOvIdpSqgTSuS3qAut3onH/v3j4kMCriMV9Dt0gTMvVsUsYSeJ8SPOuNYSxadN6V59zCekM/TgtlWTslcTZ8neAh7uBr6MPaWlFDgV80Vo1Ab//+2vcI3x4Mcvnk6kCxxbxAUZ7KBFhrgArH/6KiJIdQN8TDDK5MQ/gvBaa3d1WJgXtQAS2XqGIC20QCnXCzVRwrbtJr7Sj3ktaNYnuTsJpHRKzIgj6nKEEKM4zADXIOtJkO2lCytwJLhPSSda/HMnaAkHBdtTtfNTi0ASkURdtEQmt18eE18i1xsP2j/N0WgPhhgpBSm26Fr+kngRD+EOV6gVeWQPeP8k1m51m+p7Tr4KR2p0alfObVEdWP0hz9TAJC0goTKhy1GrJt+94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJEQ01rczdsdjZkU05UWUY3dCtMdnppTkxSS1FzM3kvN1dlVUhXcFNoK0Zt?=
 =?utf-8?B?Z0tkYWtqZnZoQ2c1UDlQWU02VGpma2J6dHFuYjZ1aWVwTVFGUUFqMVZMQ3BX?=
 =?utf-8?B?VlBqYStRWUdESXpjSmYrVGVmVndOZDZkRDVxQ0pxVUdXUnZtSjJGdTRYN1h6?=
 =?utf-8?B?YytyRTVTR3NuWVlLWU9OVHQxN0dnQWFZYTE5RklmWWRBSXIyUzUrUUIvb08x?=
 =?utf-8?B?UU1qYVRJRC9LU3BzNis3Vi92OUpwT3NaOWtRSjFrMEwySkNUQXdSSUtVVmhJ?=
 =?utf-8?B?ZW9DcmI0MENUdVlaakhaSWdUVVhSTVJVY2l5TzhsS25FRnhxdWZudk1rYm90?=
 =?utf-8?B?cnJSRDRFd1RQNUpEZG9NVDREOFpmaU55RzgvSFB2dXdjNnJJZHQ5T3RQWnNY?=
 =?utf-8?B?eG5GeDgrWE1uUG5haDZHbFJHUDRCeFpaMVBXSW01Z0Jla0V1bXJ1MEltNmlw?=
 =?utf-8?B?cXB1TlNXN0dua1QyTTlPSG4vVjBOMldTOHZ6YkN2djRiSGEydFFQdTkreVVE?=
 =?utf-8?B?ZFlESWdIL3lCWlM0RG5OOFBTVDJvSE95WkZMVUhnNG1oblEwZGc3MWdSS2pS?=
 =?utf-8?B?Qm12empBK282QU96NEtUK2k5Skl4bGd5eTRyT2NFaG9OMDhxaEVRUjhFY2xl?=
 =?utf-8?B?M25BTGlZT0NtSVZsVzJaOFF4QjVvejJWYXd3N25uMmVDa0w5aWNmY3k4Ynpn?=
 =?utf-8?B?NFNmdy81QkpDVDBWSHZoTDIrWExvbllYUjlpQ1NvTm9ySldmQVhGUDBXZ0VM?=
 =?utf-8?B?WXhrM2huR3RremRJdXFkZEhTTkFndE1kL3haU2I2K21KRzdTczE5RFRtTW1v?=
 =?utf-8?B?aXhGNGRMNHV1eGE0Q3czOHJ6VjhiT1Z3Ly8xMjV6aUdqeEJsczJLTVVHME1u?=
 =?utf-8?B?bUVtRkxSVVpTTHAyODVFRFVWR1dsQ0lvS09zS0dYVnZPR3BzRERmc1hqeDRT?=
 =?utf-8?B?aTQ4ekozZzdUNUxXcC8zMjgwdUNOWGhWekNnOWllMUg5bHJOeENjcWoxRFFu?=
 =?utf-8?B?NVVnMjRiZ0tCYkJHNEFMWC9lekQ3YldKUmVsY0VmWVROT09Ibnk5K1hxS2R4?=
 =?utf-8?B?QVBRbDBhS1RVTmxXUThCdmZUUlRvSG14dlJiWHdlTTdPdFhGT0loT2lUVzU2?=
 =?utf-8?B?bnQwTE5hYTFyQ1RITlFwR0czdFFxTE5YYkVVRURMZzBOSTdOWGdjQjdOeThy?=
 =?utf-8?B?ak9xMmN6N0lhRHdDR3FEaWRWRXFHUTBMRzl1dW9qZzFkbU5HZ01JeE9YYjVq?=
 =?utf-8?B?M0xCS3RlRjRQeFk3OUFhcnkxZDdZdmwxNno4MzlIN2FDL0tCYSt3SDR2SFNV?=
 =?utf-8?B?b214TUp1Njg2Yjkvd0t1bFEzQjNSaGM4SDBmQVZia0J6ZUl4VHIvNUxpb09m?=
 =?utf-8?B?aWcwMHZ6SmQreGtqc3ZVdE1melFNdVJINW8xV3BqanhubUhQWkdIUTJ1MlpS?=
 =?utf-8?B?T28wMU4ra0hJWjR2UnlnMWlwTE5OSVUxbHEzZXJ4UElvN3czSFpMd0liYjJI?=
 =?utf-8?B?UFpualZpTUxObGdoZDdoQmQyYmdabXVWTWhRY25uMnJwM2RSN3l5VW1UM09L?=
 =?utf-8?B?dmt0SFJFQ050N256c001TGxreS80TlA4T3gwYk90VlpocTFLTDJ0djRaa1pO?=
 =?utf-8?B?VG80anFJUWVTL0FYOTNlV3F2LzZEdFEwclpyemlQMEQrV3NEc2RHZVNwaU1x?=
 =?utf-8?B?NXNDSDQ1d2RzVlNXeWU3OG1Wc1VWeXpkSmxnMjc0bmdESWt6WWtrbFBNdnFa?=
 =?utf-8?B?NlBoM2RDYWlMbm53RmZaa1JxNlgyZXBKU2Z3WEpBd2V2enBhcXBNeGhrejNH?=
 =?utf-8?B?ZXFFTnFaSk01S2R6cWNTMmpWLzMxOS9nUnNCb09BekEvTTQ0dFI1MkttMWdm?=
 =?utf-8?B?SWJhSzRDRWNwMENxTzdUZ2xZZ0pueC9wOFNIak9xREdHY3YvWi9CVDBPMnFv?=
 =?utf-8?B?Yi9TZzVsaG16andJdjFUWG84MFloMk5hYmpqVDVxVGZTSVZRMEJONXdIZVds?=
 =?utf-8?B?M0RHQ0ZFZ1RCMm16RXBqcHAvaDBFOS91b0NuT3F1SFhsK3dxbGtyRERwd0tn?=
 =?utf-8?B?UEh3cDR0dFFEZ29yd3hJUWtTUGNjMHdObGJ0SEM1eDlQUFp6bURpRnQ1SFhp?=
 =?utf-8?Q?09E5kqU9m/b2EpYNaHsadvfQy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a71b28-4bf9-429c-3fb6-08dc3d2e4d43
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:07:05.5070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPHJ/Uzxk2cqlLv9TZlEG4tqBRXlVZ7HL8SOSCGwGkaNe1csQbPmxrrbl6Ykpf0mBMnqAq1nTlpfv/Fti9VrYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

--------------WXhPTvmOR1dORR1Ust81Zchv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-03-04 19:20, Rehman, Ahmad wrote:
>
> [AMD Official Use Only - General]
>
>
> Hey,
>
>
> Due to mode-1 reset (pending_reset), the amdgpu_amdkfd_device_init 
> will not be called and hence adev->kfd.init_complete will not be set. 
> The function amdgpu_amdkfd_drm_client_create has condition:
> if (!adev->kfd.init_complete)
>               return 0;
> So, in probe function, when we return from device_init the KFD is not 
> initialized and amdgpu_amdkfd_drm_client_create returns without doing 
> anything.

I think your change could result in calling 
amdgpu_amdkfd_drm_client_create multiple times. IIRC, one purpose of 
moving the call to amdgpu_pci_probe was to ensure that it is only called 
once, because it only gets unregistered once when the driver is 
unloaded. Maybe it would be better to remove the if 
(!adev->kfd.init_complete) condition from 
amdgpu_amdkfd_drm_client_create. That way we would always create the 
client at probe and it would be ready when it's needed after the GPU reset.


There is a chance that the client would get created unnecessarily if KFD 
init never succeeds. But that should be rare, and it's not a big 
resource waste.


There were some comments on a previous code review, that creating the 
DRM client too early could cause problems. But I don't understand what 
that problem could be. As I understand it, the adev->kfd.client is just 
a place to put GEM handles for KFD BOs that we don't want to expose to 
user mode. I see no harm in creating this client too early or when it's 
not needed.


Regards,
   Felix


>
> Thanks,
> Ahmad
>
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Monday, March 4, 2024 6:39 PM
> *To:* Rehman, Ahmad <Ahmad.Rehman@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Wan, Gavin <Gavin.Wan@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Init zone device and drm client 
> after mode-1 reset on reload
>
> On 2024-03-04 17:05, Ahmad Rehman wrote:
> > In passthrough environment, when amdgpu is reloaded after unload, mode-1
> > is triggered after initializing the necessary IPs, That init does not
> > include KFD, and KFD init waits until the reset is completed. KFD init
> > is called in the reset handler, but in this case, the zone device and
> > drm client is not initialized, causing app to create kernel panic.
> >
> > Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 15b188aaf681..80b9642f2bc4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2479,8 +2479,11 @@ static void 
> amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
> >        }
> >        for (i = 0; i < mgpu_info.num_dgpu; i++) {
> >                adev = mgpu_info.gpu_ins[i].adev;
> > -             if (!adev->kfd.init_complete)
> > +             if (!adev->kfd.init_complete) {
> > +                     kgd2kfd_init_zone_device(adev);
> >                        amdgpu_amdkfd_device_init(adev);
> > + amdgpu_amdkfd_drm_client_create(adev);
> I don't see what's preventing the DRM client initialization in the
> reset-on-driver-load case. It only needs to be created once and that
> happens in amdgpu_pci_probe. Am I missing anything?
>
> Regards,
>    Felix
>
>
> > +             }
> >                amdgpu_ttm_set_buffer_funcs_status(adev, true);
> >        }
> >   }
--------------WXhPTvmOR1dORR1Ust81Zchv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-03-04 19:20, Rehman, Ahmad
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY5PR12MB60344BA3CFBEAA1BDD9D66648F222@CY5PR12MB6034.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Hey,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><br>
          </span></div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Due
            to mode-1 reset (pending_reset), the
            amdgpu_amdkfd_device_init will not be called and hence
            adev-&gt;kfd.init_complete will not be set. The function </span><span style="font-family: &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">amdgpu_amdkfd_drm_client_create</span><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&nbsp;has
            condition:</span></div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">if
            (!adev-&gt;kfd.init_complete)</span></div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;</span></div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">So,
            in probe function, when we return from device_init the KFD
            is not initialized and
          </span><span style="font-family: &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">amdgpu_amdkfd_drm_client_create</span><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">&nbsp;returns
            without doing anything.</span></div>
      </div>
    </blockquote>
    <p>I think your change could result in calling
      amdgpu_amdkfd_drm_client_create multiple times. IIRC, one purpose
      of moving the call to amdgpu_pci_probe was to ensure that it is
      only called once, because it only gets unregistered once when the
      driver is unloaded. Maybe it would be better to remove the if
      (!adev-&gt;kfd.init_complete) condition from
      amdgpu_amdkfd_drm_client_create. That way we would always create
      the client at probe and it would be ready when it's needed after
      the GPU reset.</p>
    <p><br>
    </p>
    <p>There is a chance that the client would get created unnecessarily
      if KFD init never succeeds. But that should be rare, and it's not
      a big resource waste.</p>
    <p><br>
    </p>
    <p>There were some comments on a previous code review, that creating
      the DRM client too early could cause problems. But I don't
      understand what that problem could be. As I understand it, the
      adev-&gt;kfd.client is just a place to put GEM handles for KFD BOs
      that we don't want to expose to user mode. I see no harm in
      creating this client too early or when it's not needed.</p>
    <p><br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CY5PR12MB60344BA3CFBEAA1BDD9D66648F222@CY5PR12MB6034.namprd12.prod.outlook.com">
      <div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><br>
          </span></div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Thanks,</span></div>
        <div class="elementToProof"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">Ahmad</span></div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display: inline-block; width: 98%;">
        <div dir="ltr" id="divRplyFwdMsg"><span style="font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Kuehling,
            Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Sent:</b>&nbsp;Monday, March 4, 2024 6:39 PM<br>
            <b>To:</b>&nbsp;Rehman, Ahmad <a class="moz-txt-link-rfc2396E" href="mailto:Ahmad.Rehman@amd.com">&lt;Ahmad.Rehman@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b>&nbsp;Wan, Gavin <a class="moz-txt-link-rfc2396E" href="mailto:Gavin.Wan@amd.com">&lt;Gavin.Wan@amd.com&gt;</a><br>
            <b>Subject:</b>&nbsp;Re: [PATCH] drm/amdgpu: Init zone device and
            drm client after mode-1 reset on reload</span>
          <div>&nbsp;</div>
        </div>
        <div><span style="font-size: 11pt;"><br>
            On 2024-03-04 17:05, Ahmad Rehman wrote:<br>
            &gt; In passthrough environment, when amdgpu is reloaded
            after unload, mode-1<br>
            &gt; is triggered after initializing the necessary IPs, That
            init does not<br>
            &gt; include KFD, and KFD init waits until the reset is
            completed. KFD init<br>
            &gt; is called in the reset handler, but in this case, the
            zone device and<br>
            &gt; drm client is not initialized, causing app to create
            kernel panic.<br>
            &gt;<br>
            &gt; Signed-off-by: Ahmad Rehman
            <a class="moz-txt-link-rfc2396E" href="mailto:Ahmad.Rehman@amd.com">&lt;Ahmad.Rehman@amd.com&gt;</a><br>
            &gt; ---<br>
            &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-<br>
            &gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+), 1 deletion(-)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt; index 15b188aaf681..80b9642f2bc4 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt; @@ -2479,8 +2479,11 @@ static void
            amdgpu_drv_delayed_reset_work_handler(struct work_struct
            *work)<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; mgpu_info.num_dgpu; i++) {<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = mgpu_info.gpu_ins[i].adev;<br>
            &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;kfd.init_complete)<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;kfd.init_complete) {<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_init_zone_device(adev);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_init(adev);<br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            amdgpu_amdkfd_drm_client_create(adev);<br>
            I don't see what's preventing the DRM client initialization
            in the<br>
            reset-on-driver-load case. It only needs to be created once
            and that<br>
            happens in amdgpu_pci_probe. Am I missing anything?<br>
            <br>
            Regards,<br>
            &nbsp;&nbsp; Felix<br>
            <br>
            <br>
            &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_set_buffer_funcs_status(adev,
            true);<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &gt;&nbsp;&nbsp; }</span></div>
      </div>
    </blockquote>
  </body>
</html>

--------------WXhPTvmOR1dORR1Ust81Zchv--
