Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63AEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 15:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD3310E5E0;
	Mon, 20 Mar 2023 15:55:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F9F10E5DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 15:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxCu/c80Jl2UeDgYGNrNSlTlHzD0sP2wFQL3e52IRzBePxPZpLe1+idDzMkjnFD3L7ygJkKlnZTzY1zTTfNSBDG3ai3M9VeS2rTYxQG2OZR9dofp0oC36PpqMHOtg6L5Wzd8kuHrvkpNgVL1w+WZfRiQEXwmE4RgNNyWrIA29Ajhzlgr0e4h680dZ3N6SakoKQNXU5GLNcjfjecchCD9o7QNYAycR8vPmH9I98JTgcT8JHFBnfjKhdZ7I0Sf/sHsabIkB5fmlMqsn2TDiGvy4dXGIHfcRtQNJPbaniBcJu1ww2Cem6nfOvvKw6t6OI9mz5ddCCkPcYAtmCDX2PeBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXMOzOszEgEYXI8toLPVGSIpt2NOgVIulrscCx5JniQ=;
 b=haP/ZaaO7Z0Om69/Lr05CaiF6SasxLoQSMVh4ryrzMXG9fboUpWtj4TmZJIJ6FBsvl7Olc2t3DoBSJg9sB518ELrTdAekC7cRk04PYF2WMUvaVrp2wj6emZmiFhoh/RNqIp2vgOikvzne/0hhfGWihl7iwYO1JDzK7w3fun/uGe+hJmUhzzyEIvNZrWXTQ+epQkydA1jfSPpGXZcFu0PN2C8P0+UhFOSgDFRB6lRoQ6UU5S+w+ZsIBQExgdnak+EEfvtL0LolGwczfhE/XNrZIPXqrbR63nm6YZoH8z4ON5BpTWYIppu7R80xYDfz0vrT5KssmBfB8ujzZi1a4LGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXMOzOszEgEYXI8toLPVGSIpt2NOgVIulrscCx5JniQ=;
 b=SzCfx4QeMJJtzxXmpSqQ1UlA+mn6l/xyyBeGxXyFXLz+1wovk/fTJiN6sT/eT4Qb5aXJ1FVVuvVdN6fn/nDkJrS4ggQAtSTbRSPKFIjexNLDGOAH/oUNSQref0AjJjS42Dx27ObYRNom/J20XAUyNATVSuxmsUTSjF/EHJL7H2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:55:05 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:55:05 +0000
Message-ID: <0bb546d2-e208-2250-2eeb-797e8486ef89@amd.com>
Date: Mon, 20 Mar 2023 16:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] drm/amdgpu: add gfx shadow CS IOCTL support
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-4-alexander.deucher@amd.com>
 <a1b61e2f-d69c-4401-b9d5-46c80c14ae15@amd.com>
 <CADnq5_NenjAzNtjw_LFRQM96j3jXYTRi7MBFOr767v=PVSW+BA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NenjAzNtjw_LFRQM96j3jXYTRi7MBFOr767v=PVSW+BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b926ccd-e39d-40e9-8ebe-08db295b792e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvAPa3q6SNhjdvlp4P/tQSjiqRpyoC0zyic7u7z5p4q4kHMpzrm82SY8xkxTSU1SoXb5W4XU34etmd8Jft9cOj9MIVVdL7ScjmkyC6bMhs0UMIeIbi2YTiY0ipC71eFGDY+6dOyrISYXXluIsQxHOHtM3JgUl0jTqP2l4J/roc2yPVbHQtmcM3Qk1a+NCea2ZWNSlmwHUEfAmEvznJhYHBsu9fXNLduTx0Zm2amWMRCMshTKhhFkDKhek/2coFmO96fLLtb2/oWK7Xi/A8Obzi4t0QoOVsVCtnpRSx8yLapgJDTaDkxwfSgau97hmEQWPGWOS4ZIsXDTaPK4atBnKVoDlYF9Z2sVqKxUDyMqOhWViVpGcBUQRZOf/cXevDKc0h6+IDrWPENryu48MytuMBV2R8KarMcJBt4wVbLwC+Y97DRHNAwPMxcDEDML/nc4h2W+2mD0fx2SAP1RtPfiHsDv0XqXN6rtSg5c8n2Cxhvjqx6Y1MDwP5UJK+5IGFjMmvhyXoeqX4oXgHK/zarj6BM6RV+QhcMsV4qbp6DkqoyGaK6/YLNEsfJigLQ2rUQsl919mQbaOy2ezCYsbkfWqtcvGStZa+zkYeqDQS0dR9RtFnIjtFluGJ4J2NWgj0V6Q8vdWcIM2ErPaJq2otaGO+7AjPbxYomJC7Vcx5YuPkrs3icDLz/K248YRO0wGMXjZqZgUOHL4JWYug0HCIv7T2VhDHrGu3Ht/f3INxhg0Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(31696002)(86362001)(31686004)(6512007)(6506007)(2616005)(53546011)(6666004)(38100700002)(6486002)(66574015)(2906002)(36756003)(5660300002)(8936002)(41300700001)(83380400001)(478600001)(186003)(66476007)(316002)(66946007)(6916009)(66556008)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDUzSldpb0VuS0RWeWRpcEEwaUc5ZVJncEFxS2xac01qb1czWE9VTWI5Wk91?=
 =?utf-8?B?d3ZuOVpkOWVVQXRBZzJ3SjRZZDgrZ1VCMHRWVjFWL0labG5FTlAyTDZMbGov?=
 =?utf-8?B?bzRaOTd5TW9IUUMyZDRycEEycDNYclNJTFI1RjZLNnlDaG5FTUV5K3NrSmdp?=
 =?utf-8?B?Vi9qSmhSOUlkdVl0eGpjeVIvSGtpandpZDU3RlFjSStJSWRYMmpzMVlES0hX?=
 =?utf-8?B?K1BJekVlVkllTk90eDViOFo4UHQ1R2RGWXBMQzJVbjNDRUp5eTVCYThwT0di?=
 =?utf-8?B?MG9yazQxZlV2cm9GelBONXhLYU40aFNEdWNWTHo3R2N0eXhKUmZZWitiL2F4?=
 =?utf-8?B?VEI0eXBrZytuMEZDQm9Bdlk0eTl4UFNPMVppM0NlODdsOFg3NzFyZ2tZNFRM?=
 =?utf-8?B?OTZBVlcwOWFONG8wa3ZnbFNpeTIvQ3owWDU2aVMrZWtjUVlZQXpNSWwwbm9Z?=
 =?utf-8?B?VXE5YVpBRjJoaVd3TmxMWW8zejIyTUtKd0dEcGYrSHB2a2xLUjJXR1pLS0pZ?=
 =?utf-8?B?OHV4NENzNjNmeHA4WlVqMURNaUI4aEE0UlE4cmhoNCtFYkxHTmkzc1pvSXRw?=
 =?utf-8?B?cVBDVjY4R3A2VkZvR0grMkFPUDAvNkwwSzVwQWdVRGJWeTZsdE96UElSMFF3?=
 =?utf-8?B?TStYN2FMVVJWcG9uNG1ZeE0waTZhU3NRTkhpV2k0Zy9GQ2JTNFpIeTdvYmZF?=
 =?utf-8?B?Y1loOEt6anF5MnNsRTJJMFZGK1ZtVzVPVW5TTmNPdEEybnNoVFBkSjFscVZR?=
 =?utf-8?B?NjNVVXU3MFd0cmxGenk3WjBobFpRWjFzMHlCU21GZ1R5RUpoOEZIQ2tpT0Zr?=
 =?utf-8?B?U1l4NVJ5c0E0TStqWXBaUHdLL0ZHOUU2eEIzbXBtMlpNM3BaejNXNHNhSUxI?=
 =?utf-8?B?U21OQ2k2TDNVZG91dE5tWnNWK0ZjNVZVcE9UWC9nb0llcC9oTVhpcUlHQWxI?=
 =?utf-8?B?eC8zTlhvY0J5UUdDSXJPV09LYWdybWUzeUxUOGhmSDJDSjIvL21way9vZURT?=
 =?utf-8?B?TkozL04rMU9ybUQ3M3dLdzFXU1FHb2YwWmV0YVRrcmZEaytzYjlrQXF1NXha?=
 =?utf-8?B?aXU5R3c3Y25VbGpPMDhjVGtrTk5YbURwMWJZMnAyeDdTbUxkVkVTM0NyM3Nw?=
 =?utf-8?B?T0dHK3FyU3BzVzVIdVNkU2JHOVBOZzN5NVZ1bXEwcjJzMXlXbnk2TEZWMm1k?=
 =?utf-8?B?NUtReFhQWm9iSzZURmMwaHNSbHlrQmpjQkRPc1ppQ0J3THBIYlJhUzJEMW00?=
 =?utf-8?B?dkhkY0VzZEkzYm5lNHUzUGxQcGhmZFUrL0NMTFkzb2pGVlFKTjd5cUtkUG0x?=
 =?utf-8?B?c21veGJycVdYYm9HTkNra2lnZTZLenVvRVQ4Mk9weWJweHNGcWJuS3c5VG0r?=
 =?utf-8?B?QXdsT0U4dmRuWFJiS1FONWsrOVBqL0dxSXdacktwNDhuSitSaFV3MGNlTk1m?=
 =?utf-8?B?L1VnTlBybkd4UVlQaFd2WGl0aVA5THFmVC81YUJwQnpSM2pqak5jMzZ3S0NB?=
 =?utf-8?B?TVpjVDF2eExJc3BCVG9Sdjg5MS9TdnVHNlRwdGRXdGRGMFlQLzlDK1BZMXk4?=
 =?utf-8?B?WkY4d0YxcWs1T1lKMkNJOGFoQ3BsNlZ4NDNtRjUxUVhVL2lxVWg5QkpxbTU5?=
 =?utf-8?B?ejNWZGVaUytZWXhDQ1JxSG5GZ2pMM3ZrZjg4T2JqLy8vQnd1ZDg3d21CSEpy?=
 =?utf-8?B?Y3NkMFFWVHQvNXNiTXV0d3dhcmxuUlhyS0oyVUJVRjZiVkdaNmJtdlozeWhj?=
 =?utf-8?B?ekJUOC9KaUhiVnBPM3RWbW9ZZjVLMDJiUmIyNVQxMG9sanJzM1Fic2E1ajBM?=
 =?utf-8?B?VWtpTVVoTHcxTmNNdzVZeUltR2hUZUw2RWNFdEF2ZTkzYm5NckdJWENjejlW?=
 =?utf-8?B?eTdFa3RwL2VDU1Y5T29lZzEyV1hCbXVLSXRmaU5qUUh3bmdZUXdxd1FFVXZH?=
 =?utf-8?B?endEUkdzSkY1aG5wazVETDJWU3RoZmFTWWhibk5rZ3FqSlZSbmlGVTBSUVQy?=
 =?utf-8?B?R1A1VkVSRjloclV2eHRkQURQRFRaT05hZjBhZnQ5OFpjV2tKSmlodEg4azFo?=
 =?utf-8?B?OGYwNU5mbzhXT2cwSGZrM3pLMkJ6OUtnM1NxSXdoLzFjV2ZxRGJkMUd2c2Ew?=
 =?utf-8?B?OUlwSGRQS0hjZW9lUjJnRzZFYzlTVzl1ZXVDQlRnQStmOVRkSlkvM29MMkxW?=
 =?utf-8?Q?bIV0THpiJp5ASRJA/RUUXpjU9vsN9W/y4o+lciGExNdg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b926ccd-e39d-40e9-8ebe-08db295b792e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:55:05.7101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cOyYwgvWfYlL946aZ7BhLBldpP4nVp/dbO9hRcCXXlYnUnHf4iYLWh3bGfI5uBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.03.23 um 16:49 schrieb Alex Deucher:
> On Mon, Mar 20, 2023 at 11:46 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 17.03.23 um 18:17 schrieb Alex Deucher:
>>> From: Christian König <christian.koenig@amd.com>
>>>
>>> Add support for submitting the shadow update packet
>>> when submitting an IB.  Needed for MCBP on GFX11.
>>>
>>> v2: update API for CSA (Alex)
>>> v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
>>>       Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
>>>       amdgpu_cs_pass1()
>>>       Only initialize shadow on first use
>>>       (Alex)
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 24 ++++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  4 ++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>>>    5 files changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index f6144b378617..9bdda246b09c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -280,6 +280,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>>                case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>>>                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
>>>                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>>> +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>>>                        break;
>>>
>>>                default:
>>> @@ -587,6 +588,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>>>        return 0;
>>>    }
>>>
>>> +static void amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
>>> +                             struct amdgpu_cs_chunk *chunk)
>>> +{
>>> +     struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
>>> +     bool shadow_initialized = false;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < p->gang_size; ++i) {
>>> +             p->jobs[i]->shadow_va = shadow->shadow_va;
>>> +             p->jobs[i]->csa_va = shadow->csa_va;
>>> +             p->jobs[i]->gds_va = shadow->gds_va;
>> Do we really need all three VAs separately?
>>
>>> +             if (!p->ctx->shadow_initialized) {
>>> +                     p->jobs[i]->init_shadow = true;
>>> +                     shadow_initialized = true;
>>> +             }
>>> +     }
>>> +     if (shadow_initialized)
>>> +             p->ctx->shadow_initialized = true;
>> This is a really bad idea since the IOCTL can be interrupted later on.
>>
>> Why do we need that?
> Yes.  We have to only initial the buffer the first time it's used.
> Doing it again will overwrite whatever userspace has done with it
> since then.

I don't get what you mean with that? This here doesn't make any sense at 
all.

The shadow buffer addresses must be given with every CS and updated over 
and over again. Otherwise this solution won't work correctly.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>
>>> +}
>>> +
>>>    static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>>>    {
>>>        unsigned int ce_preempt = 0, de_preempt = 0;
>>> @@ -629,6 +650,9 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>>>                        if (r)
>>>                                return r;
>>>                        break;
>>> +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>>> +                     amdgpu_cs_p2_shadow(p, chunk);
>>> +                     break;
>>>                }
>>>        }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> index 0fa0e56daf67..909d188c41f2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>>        unsigned long                   ras_counter_ce;
>>>        unsigned long                   ras_counter_ue;
>>>        uint32_t                        stable_pstate;
>>> +     bool                            shadow_initialized;
>>>    };
>>>
>>>    struct amdgpu_ctx_mgr {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index bcccc348dbe2..d88964b9407f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -212,6 +212,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>>        }
>>>
>>>        amdgpu_ring_ib_begin(ring);
>>> +
>>> +     if (job && ring->funcs->emit_gfx_shadow)
>>> +             amdgpu_ring_emit_gfx_shadow(ring, job);
>>> +
>>>        if (job && ring->funcs->init_cond_exec)
>>>                patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index 9790def34815..b470808fa40e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -68,6 +68,12 @@ struct amdgpu_job {
>>>        uint64_t                uf_addr;
>>>        uint64_t                uf_sequence;
>>>
>>> +     /* virtual addresses for shadow/GDS/CSA */
>>> +     uint64_t                shadow_va;
>>> +     uint64_t                csa_va;
>>> +     uint64_t                gds_va;
>>> +     bool                    init_shadow;
>>> +
>>>        /* job_run_counter >= 1 means a resubmit job */
>>>        uint32_t                job_run_counter;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 3989e755a5b4..8643d4a92c27 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -212,6 +212,7 @@ struct amdgpu_ring_funcs {
>>>        void (*end_use)(struct amdgpu_ring *ring);
>>>        void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>>>        void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
>>> +     void (*emit_gfx_shadow)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>>>        void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
>>>                          uint32_t reg_val_offs);
>>>        void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>>> @@ -307,6 +308,7 @@ struct amdgpu_ring {
>>>    #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>>>    #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>>>    #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
>>> +#define amdgpu_ring_emit_gfx_shadow(r, j) (r)->funcs->emit_gfx_shadow((r), (j))
>>>    #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
>>>    #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>>>    #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))

