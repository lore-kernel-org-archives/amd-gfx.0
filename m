Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4D6CD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 05:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA1E10E470;
	Thu, 21 May 2026 05:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ZjiQy8g";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00EE110E470
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 05:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mwhh/FVDodR1TTVaEMAfT2ww8yu61SEVTvDh/BxlPF85QWnINyh17bvbR2SLuzKr0PVHgq3vq7hf4oecvNsQ2c4HBA+A8nuEDD2A/Y06PY2CMnitByVrBQPv89qiVQ2O3K41Hy5/X2WB8WNMXOoCHSwIn7We2P2yeSGsAN31goC/mt8P8OJ0atX4LDSozHkEKZEFb8+lUKVUHos3tRS8jQGlytufPQ+xzXFTX4aC9rFEb7XJtTshbYEaudaf8E3BtGk60MMo6Yn6CmbCpDvqJNdEq5r1hVk+052Tc6rLZc9SP2urNI9u8p1IJXSnA0eBe46ExTj/JPcRp2111KXE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ8twzcYmJX10HJktgumaaR7hhcF62oijEQa71/mxw0=;
 b=fwcTOMunM1joz4EL+KY+qCFAp4Xx82MVoyoBcCv7RMpNHSZSSTTQpX9EicsFwkR312A4OIqEO6VdmYv4kbY+defZvzb8vkzHJ43QG9D1D3qQSSoR4qXgx9gOzygW9FhVHg0ZPCqIVw0zOHMBUxVeeLbL5nPeEMlkveta5ZWLaPD9qwKj33N1h1w3cSF5z1OjAkjpc6nq+H+Nfk/m8a3KyUEL3yOwUxK3CuF1gRJajLjRT3ePdBZYahU/xtLKRRdcVEFQxlk147x+h4FemQZ5ajaRyAmmtHtqhtaLCNfFwgrs5Gwt4j+KMfX4zceiiJ433QKltch59dJxXsrPEIxuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ8twzcYmJX10HJktgumaaR7hhcF62oijEQa71/mxw0=;
 b=1ZjiQy8gH3i9Fgez2sn0MUA8f/oSNUhV3EKiSPzA2vzaKQnjVecTKaKBo2VHMczWoqonQYOVLPfWA06GMAheod29UoA7feVu35Qe4WnxRDMY9sZFjnXNFtLBN68pMUnkZn8lvsWrWMiQKEDLpcORMcIvkjJavohl3BSq+JGU/Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 05:30:51 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 05:30:51 +0000
Message-ID: <d706a70d-8b8d-4076-9bcb-e29c770c5c35@amd.com>
Date: Thu, 21 May 2026 11:00:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260515132702.1494187-1-yifan1.zhang@amd.com>
 <adc4600a-1d3c-4e79-9b6e-2e433bb3223e@amd.com>
 <CY5PR12MB63696C68EA513F50DD4C1226C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB63696C68EA513F50DD4C1226C10E2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 81851ded-f935-429f-30f2-08deb6fa1f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|6133799003|11063799006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: +wJSENZTaXa2T2dIbpudGoVp/erp6ZEIgv+7WM6E/7D3ogZAznBzvECf2AMNtqmoq/CEEosXSCaRBcmGSmKzm4ODgDdk5tG/TxizlWDjIHNtmsJ4iU+9cso1RCL9yb1PWlwuumr3956o4KWb3TUxoUQTIt7/x8ODUFtftxtrEcboTlYxpFatOLbILbFZtwIzqM3sBlL+pVng7LNwOiT5M7yuRHXGY8ssjjnXe1nv+5xEfIjx2Aur/XX2cTo10szeYcuHam/vXhNmlHUr1Hgs7sQdMIF59VtUK2SNus0BQFMC/EwqkPxM2+8JYH0dgH6yTiGww1GfUo5yjkZoTk/pQM2UyjXZ2SdDIs3XxFQnqhxWTXlzRkVjCznz04a1bHuWe/YJb5mat27s3byCNxHJwY1hvuQIg/xXRu/X9LaeIKB/brkYh0XJ1RLHAzIpVFCAMvCeYcFgrZq92vSQO6zILxXth4GYb8E8S6dKPcNQ6Kg6gRWv5jfXSHco4H4fDjlhsuQXnTM+H9B1Wki83xnTBm4f8AazBlLMKOZJ2cPkxpcm/tPE2IHQzRjEFIOUbH5DMNqWe+bZoj4JhXa15R1ZQOSEOuvd5G9FjblEQQMxNB7uZzsXkbXWsU+Ucgg3sQhXkjAcsrRfRgTOjQAmvGraK1SVFXyU4RbhcRe5TIcjouzJxE2pRL+Xx+nAgECOU/Lm6y3Whf8h1xNN1IhKA1PmUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VwT0wrZ2UrK05tZjM4aWtxTEszd3BWUzdSQXBMVW1ZZDJXZkc1RFJ5TzlE?=
 =?utf-8?B?VlU1TitVSGlIVU9CenI0aUxLRDNOdlFONWYyUHNIWWphV0hWNlROUmIwS213?=
 =?utf-8?B?Vk9OTCtYMWlxenVMYjJBdklFZ3BHRkIwMnZYSk9MWjI4ejRqWXF2SmhjdURl?=
 =?utf-8?B?amthUWJaMGQyOTRiamhwMWhlZndUVnFYQUtsV0RlL0Q4Szc2cVBncFphSU5V?=
 =?utf-8?B?UkQzQ01TT0ZkZEpwS1l3YWQyUlZhclV1S2ExcjFIRG1nU0tQVk84WjlPSHhT?=
 =?utf-8?B?WTBqV1pPZzREeFVaaS9JRXdWOEx6M0cyejZ3c3l5SUJuQlV0cGJCMU1nVlpl?=
 =?utf-8?B?Tk1wK3BkVE9Id3diUUQwdTN6aVdQclRsUEhyR0ZXRFd6S1pUWnVkMWgvTHBJ?=
 =?utf-8?B?Tm5ySUJLODQ4OE9vbEhxTmt1RHBwL3h4Nm5SZmVpNysyY1NqNFNTUkNleVhY?=
 =?utf-8?B?b09UcENETVBlM1VDNXZicVJrcHJwTFVDZkZ5Nm43K041RW1jeXNMVWlzRWtz?=
 =?utf-8?B?Yi8xZEF6TXA5TG00VWtqT3pKaytJeEJuWWpWd1B0MGVMbXhpSDFOeVJDWnJ6?=
 =?utf-8?B?NS9OQWFDeFVxYjJReGsrWFVram9xWlQ0bmYyNk9BM1lqL2IzY0JHRkdUVGRI?=
 =?utf-8?B?WjBWaGpwMHN3OHI4SmxLaGZGdDlnUmdjcEt2TVVnc1lUREJWWU1sVzVGRUFW?=
 =?utf-8?B?QzhWSWlNaG5sMldUZmE0TXloL0xOUE1BUmZmZEl5Ykd2YkFSV1Jrb0orNzkw?=
 =?utf-8?B?MkpROHlPRnduenAzQ1FscUtKeUM3a2pCUXdWRXp5ZnRTWTdQQXJFcWhwVXk4?=
 =?utf-8?B?UFoveS9uRTFKUVVJMUNHNUpldHpNS3RYUUZvTkRKRDlVRnB6aDQ0L1dLdzBJ?=
 =?utf-8?B?REZ3NnlBdUpGWmVNM2hhOUlYUHZXeXJFT2JPNkxoeEhaaXZ2YWFlV2VZMUls?=
 =?utf-8?B?SDI3cmNoZFQ2Vlp4RDk4MXdZVmFFVDJMM2VuUEZEM1lpN3NNUXphSVZWQ3FI?=
 =?utf-8?B?eWx0Y3NnR29FaWo3SEVFemg5QVdDY3FpZ0hTbUpUSFJBTGZUV3RJemZFdTZx?=
 =?utf-8?B?S0xpdjVhN0NTL3FhMzBqZ1RlOU1HMjVWOEdRR1l5cUZ6azh5Ynh5RjdmYWRs?=
 =?utf-8?B?Q2NyNitrUGsrZ09uTjVnWGF4KzB6eXI5OExPeTBsLzZoUGVXNWpkK080L1pS?=
 =?utf-8?B?RTdKZVcwMWpJeGY1WkF4czQ3aVR4ajVpQzZSVEp1V3pFMmNZMTJ1eE91dGds?=
 =?utf-8?B?MVZnVDM3VFIvVThLR3k0bEtybENrd2ZQc010VENIeCtSb1BGaTFOdFk0R0tp?=
 =?utf-8?B?MXpOQ1J4d01maVNoRVBlMWFvZm1HQVFuY2dmRUd1bEh3emVScVY5R0V3UFJ3?=
 =?utf-8?B?YVFtRHpHRHo1OHVNbGNWOTI5bUtBMTdwN09NSWRFa0JWZHM3aXdxUjQrUDFV?=
 =?utf-8?B?azh6d3ZwYjZzZmk5bm1oL0dIQW52OFN3em0ySDJqM212YzR2QUlRbE1sMW03?=
 =?utf-8?B?MkwzTkxQY1l2M3J0SVU5NDNjWnh0ellwRHpVL3AxdUZXQjZNeThmYVFHRy9L?=
 =?utf-8?B?d2dnN0tLV1BTYXk5cGpxcWE1c3loWGxwRENMZWNQSDErNFNCNGI0M1U4Rk8r?=
 =?utf-8?B?VmhxREFhcmRyYTFCQ1IwRDBXQlFzcVZHM1M5ekFJVXVxT2xhSDJndnVyNGps?=
 =?utf-8?B?MisvUXVoSytmM2FSN1NEMHhsWklUVGFGVHRCa0xZZStuN0F3YVA4VkFOOTBE?=
 =?utf-8?B?emZlZ2FERVlTdlNRamZZYjBPZkk0NTh4TEtwQXg4c1QvN0x2ZXMvNmhpQmZY?=
 =?utf-8?B?NTBEOGFKZU1IMUt3azlFMjFKUGRNcXVsVDJ4OU5xOC8xcXN5d3EvYUpuS3JM?=
 =?utf-8?B?OUlEa1lRMW9GRmdxYTU0d1lsZ2NoU2ZvM2d0UkVIVW8vWmpnek5iNXdNeEpp?=
 =?utf-8?B?eFdLa0dKZFRsWmJtM2JNcHFsODFBKzNuamx3cWxMTDdsN1hPT2pDbVByK0h0?=
 =?utf-8?B?RnhsSDBGVzlsZEl6UzZmcE4rZlN4ZXhYS3BCSCt2bTBGZDlwaVlMckI3Rjkw?=
 =?utf-8?B?MlFyRlpyenV2VUl5cHJyejZ0QkoyZXh1Y0Q1MDA0WkE1MlNUd1NldDNPbERj?=
 =?utf-8?B?ZWdSZW9iQWVGWXFiS0FYbFU4NE5JeFB6YVhKSDJtaGpJRU5VYTdQaVlMaWxB?=
 =?utf-8?B?UzVaN1lRSG9FUENCNysvSlptYzc1NWk4M00yTGZsaVZPM3lDSlNOeUp0VG9h?=
 =?utf-8?B?RHRsVG9uZ2JRNklIT2ZrMElmTjF0aVcxMDBOQk05SzdUbHlNQlArelBsTWY5?=
 =?utf-8?Q?oDl0yW4ecRnh4q+ySe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81851ded-f935-429f-30f2-08deb6fa1f11
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:30:51.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU3avH8Ne90GyPZkscCJPI1x8pRoyDFUt2KZh6+AgwckVZDGq1iiVGzB9rWrYSAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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



On 21-May-26 10:53 AM, Zhang, Yifan wrote:
> AMD General
> 
> The signal itself is indeed process-scoped, but the policy is naturally per-device, because the poison event has a dev associated with it. ROCr already holds one amdgpu render fd per device, so attaching the option to amdgpu_fpriv lets the app configure each device independently with the handle it already has.
> 
> E.g.
> 
> Device A is driven by a worker that has its own RAS handler: set DISABLED on fd(A).
> Device B has no special handling: leave default / use a 10s safety timeout on fd(B).
> 
> Storing a single process-wide value would force the app to pick one policy for all GPUs it has open, which doesn't match how ROCr layers per-device handlers.
> 

 From a process's perspective, what it wants to do - isn't it to delay 
the signal if any of the devices it uses gets into poison error 
situation and buy some time to clean up?

Thanks,
Lijo

> 
> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, May 21, 2026 12:35 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Russell, Kent <Kent.Russell@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
> 
> 
> 
> On 15-May-26 6:57 PM, Yifan Zhang wrote:
>> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
>> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace
>> (ROCr) to control per-process SIGBUS delivery.
>>
>> Userspace for this can be found at:
>> https://github.com/ROCm/rocm-systems/pull/6148
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>>    drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>>    include/uapi/drm/amdgpu_drm.h           |  25 ++++++
>>    5 files changed, 179 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 5d7bfa59424a..6a5459b59af2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
>>
>>        /** GPU partition selection */
>>        uint32_t                xcp_id;
>> +
>> +     /**
>> +      * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set via
>> +      * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
>> +      *
>> +      *   0          - send SIGBUS immediately (default)
>> +      *   0xFFFFFFFF - suppress SIGBUS delivery
>> +      *   other      - delay SIGBUS delivery by this many milliseconds
>> +      */
>> +     atomic_t                kfd_sigbus_delay_ms;
>>    };
>>
>>    int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv
>> **fpriv); @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>>    void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>>    int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>>                      struct drm_file *filp);
>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>> +                           struct drm_file *filp);
>>
>>    /*
>>     * functions used by amdgpu_encoder.c diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 99688391e70b..cad18bd6f8b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +     DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl,
>> +DRM_AUTH|DRM_RENDER_ALLOW),
>>    };
>>
>>    static const struct drm_driver amdgpu_kms_driver = { diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 24526e92f9b8..7903587b8bbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>        return 0;
>>    }
>>
>> +/**
>> + * amdgpu_user_options_ioctl - set per-fd user options
>> + *
>> + * @dev: drm dev pointer
>> + * @data: pointer to struct drm_amdgpu_user_options
>> + * @filp: drm file
>> + *
>> + * Sets options stored on the per-file amdgpu_fpriv. Currently the
>> +only
>> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
>> + * controls how KFD delivers SIGBUS for poison/RAS events to the
>> +calling
>> + * process (immediate, suppressed, or delayed by N milliseconds).
>> + */
>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>> +                           struct drm_file *filp)
>> +{
>> +     struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +     struct drm_amdgpu_user_options *args = data;
>> +
>> +     switch (args->op) {
>> +     case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
>> +             atomic_set(&fpriv->kfd_sigbus_delay_ms,
>> +                        args->kfd_sigbus_delay.value);
> 
> Why this is stored at device level? A signal is process specific. I think the delay should be associated with the process regardless of multi-dev scenario.
> 
> Thanks,
> Lijo
> 
>> +             return 0;
>> +     default:
>> +             DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
>> +             return -EINVAL;
>> +     }
>> +}
>> +
>>    /**
>>     * amdgpu_driver_open_kms - drm callback for open
>>     *
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index e9be798c0a2b..2ff6348105b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -29,10 +29,12 @@
>>    #include <linux/uaccess.h>
>>    #include <linux/mman.h>
>>    #include <linux/memory.h>
>> +#include <linux/workqueue.h>
>>    #include "kfd_priv.h"
>>    #include "kfd_events.h"
>>    #include "kfd_device_queue_manager.h"
>>    #include <linux/device.h>
>> +#include <uapi/drm/amdgpu_drm.h>
>>
>>    /*
>>     * Wrapper around wait_queue_entry_t @@ -1337,6 +1339,115 @@ void
>> kfd_signal_reset_event(struct kfd_node *dev)
>>        srcu_read_unlock(&kfd_processes_srcu, idx);
>>    }
>>
>> +/*
>> + * Per-process opt-in for poison-consumption SIGBUS handling.
>> + *
>> + * Default: kernel sends SIGBUS to the process immediately when
>> +poison is
>> + * consumed, in addition to delivering the KFD HW/MEMORY exception events.
>> + *
>> + * Userspace (ROCr) can opt-in per-process via the
>> + * DRM_IOCTL_AMDGPU_USER_OPTIONS /
>> +AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> + * option. This lets the app's registered system-event callback
>> +handle the
>> + * RAS error first, instead of being killed by SIGBUS.
>> + *
>> + * Encoded value (set on any of the process' amdgpu render fds):
>> + *   0          - default: SIGBUS immediately (no opt-in)
>> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
>> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
>> + *                handle the error in time (safety timeout)
>> + *
>> + * Per-process scope: the option is honored if ANY of the process'
>> +amdgpu
>> + * fds has been configured. This matches the slide deck's
>> +"Per-process,
>> + * App set at init" semantics, while keeping the UAPI on amdgpu where
>> +ROCr
>> + * sets it.
>> + */
>> +struct kfd_sigbus_delayed_work {
>> +     struct delayed_work work;
>> +     struct kfd_process *p;
>> +};
>> +
>> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
>> +     struct kfd_sigbus_delayed_work *dw = container_of(to_delayed_work(work),
>> +                             struct kfd_sigbus_delayed_work, work);
>> +     struct kfd_process *p = dw->p;
>> +
>> +     if (p->lead_thread)
>> +             send_sig(SIGBUS, p->lead_thread, 0);
>> +
>> +     kfd_unref_process(p);
>> +     kfree(dw);
>> +}
>> +
>> +/*
>> + * Resolve the per-process SIGBUS opt-in setting by scanning all of
>> +the
>> + * process' KFD pdds (each backed by an amdgpu render fd). Returns
>> +the
>> + * "most lenient" value across all fds, in this priority:
>> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
>> + *
>> + * Rationale: if the app has explicitly opted in on any GPU it uses,
>> +it
>> + * wants the chance to handle the error in userspace.
>> + */
>> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p) {
>> +     u32 result = 0;
>> +     int i;
>> +
>> +     for (i = 0; i < p->n_pdds; i++) {
>> +             struct kfd_process_device *pdd = p->pdds[i];
>> +             struct amdgpu_fpriv *drv_priv;
>> +             u32 v;
>> +
>> +             if (!pdd || !pdd->drm_file)
>> +                     continue;
>> +             if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
>> +                     continue;
>> +
>> +             v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
>> +             if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>> +                     return v;
>> +             if (v > result)
>> +                     result = v;
>> +     }
>> +
>> +     return result;
>> +}
>> +
>> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>> +                                      struct kfd_process *p)
>> +{
>> +     u32 delay_ms = kfd_get_sigbus_delay_ms(p);
>> +     struct kfd_sigbus_delayed_work *dw;
>> +
>> +     if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
>> +             dev_info(dev->adev->dev,
>> +                      "SIGBUS suppressed for process %s(pid:%d): app opted in to handle RAS error\n",
>> +                      p->lead_thread->comm, p->lead_thread->pid);
>> +             return;
>> +     }
>> +
>> +     if (delay_ms == 0)
>> +             goto send_now;
>> +
>> +     dw = kzalloc(sizeof(*dw), GFP_ATOMIC);
>> +     if (!dw)
>> +             goto send_now;
>> +
>> +     /* Take an extra reference for the delayed worker. */
>> +     kref_get(&p->ref);
>> +     dw->p = p;
>> +     INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
>> +
>> +     dev_info(dev->adev->dev,
>> +              "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
>> +              p->lead_thread->comm, p->lead_thread->pid, delay_ms);
>> +     schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
>> +     return;
>> +
>> +send_now:
>> +     send_sig(SIGBUS, p->lead_thread, 0); }
>> +
>>    void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>    {
>>        struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>> @@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>        struct kfd_event *ev;
>>        uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>        int user_gpu_id;
>> -
>>        if (!p) {
>>                dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
>>                return; /* Presumably process exited. */ @@ -1391,7 +1501,7 @@
>> void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>>        rcu_read_unlock();
>>
>>        /* user application will handle SIGBUS signal */
>> -     send_sig(SIGBUS, p->lead_thread, 0);
>> +     kfd_signal_sigbus_with_delay(dev, p);
>>
>>        kfd_unref_process(p);
>>    }
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index 9f3090db2f16..dfc91d25c80d
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -58,6 +58,7 @@ extern "C" {
>>    #define DRM_AMDGPU_USERQ_SIGNAL             0x17
>>    #define DRM_AMDGPU_USERQ_WAIT               0x18
>>    #define DRM_AMDGPU_GEM_LIST_HANDLES 0x19
>> +#define DRM_AMDGPU_USER_OPTIONS              0x1A
>>
>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -79,6 +80,7 @@ extern "C" {
>>    #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL       DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>    #define DRM_IOCTL_AMDGPU_USERQ_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>    #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE
>> + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
>>
>>    /**
>>     * DOC: memory domains
>> @@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
>>    #define AMDGPU_FAMILY_GC_11_5_4                     154 /* GC 11.5.4 */
>>    #define AMDGPU_FAMILY_GC_12_0_0                     152 /* GC 12.0.0 */
>>
>> +/*
>> + * Definition of user options
>> + *
>> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> + *    0:          Disable sigbus delay - SIGBUS will be raised immediately
>> + *    0xFFFFFFFF: SIGBUS will not be raised
>> + *    other:      Set the sigbus delay in milliseconds
>> + */
>> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY              0
>> +
>> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED        0xFFFFFFFFu
>> +
>> +struct drm_amdgpu_user_options {
>> +     __u32 op;
>> +     union {
>> +             struct {
>> +                     __u16 value;
>> +                     __u16 _pad;
>> +             } kfd_sigbus_delay;
>> +             __u32 _pad;
>> +     };
>> +};
>> +
>>    #if defined(__cplusplus)
>>    }
>>    #endif
> 

