Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405F4D65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7FF410E06A;
	Wed, 17 Dec 2025 14:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mkH4ZDSl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326BB10E06A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqKBPDYsbfJdgotRhKihch7O8HA5/HaT2TwCahaNU2av/kQKVWTjw5/oS0R7TQSkhRMsHRH0MYLaazQw/Ki+9UGbR9ty64aiwYrRcZYD+eO0A/bAb0oNwRzNr0YETiA4/cbG+oQWh4SFbCT7DMGZy1pOlovWnrvX4hNH8ubgZYQqn3B7bJNaGkExG6qwVTEQIP7YRb8FE+kH7iNzBZRQlsBtxgXas/wtODi29Sl3PdT0tknDLRB9+0iUKx4A0HPlsglu0tFD4mWCRp8Sj4LAF2fQ+vKeaCodw1O45/7J5Sa2E79I0ZjtMLUbIn5aUkaglfPniHS6a4sEYV2mIlX4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHZWhlo48ak5+HZT1Cn1qBj7X7QDpBzSJRlFxPpr6Vc=;
 b=XNTB8D6XrIBtxcNn8dKcpzgqwYI7A9Ss1p1y+vapkFRTe3T09FR6rkZxUrBfOd1QKiGj4e62M1EA+FnupOy5aLeUFwW5owMSihox697imM9Lfd9SozfV1z7oCC1W58LlizXjVhPkvQHIIHUOFmiADINqQL4FNg78AJZiml8fpTg2yxQx98z11nRZABi9zno1Qf2wcyN0lsMSfFbN6lzYLy+hO8iTeckBGaUu7kLM+twWpF4vIRMxYuu/8czdGPIvIyRetNQt5l7ZtZocAy0xBDCh5us2WWdvxCI9WfBMuiANMCA+Ujy8ZsMDLcLYT7SN3LSWjOw94OyJZAzpVGUfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHZWhlo48ak5+HZT1Cn1qBj7X7QDpBzSJRlFxPpr6Vc=;
 b=mkH4ZDSlz948DObP28NBNApycF/3ATXbA26V8E7HCJPAztLet5C+eRMUyktAybRYoQ9Mo+WiNAnNCHmzPDxs7ZrL8H3MhZbAEs0OavPugRUeJIG/jHEEFd/uckZdHeIrRm5S+2VCowcKvnEtdnYOZauw/3ui03F1lSXFVeEU5/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:46:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:46:58 +0000
Message-ID: <6d5e7d49-3518-4e9a-9ba4-f201a578bb18@amd.com>
Date: Wed, 17 Dec 2025 09:46:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
 <902ba436-9549-40f7-a202-810b1b1ae818@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <902ba436-9549-40f7-a202-810b1b1ae818@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e835a2-71f3-492e-cb95-08de3d7b2128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkU0N29VOVYwRGMydFMvdUpGVVp2QWpzUWdUZ3g3MytianFadVZvclFtZkw2?=
 =?utf-8?B?WHdEckkxdDNFdnUyUm11UlZkMnpCQ3hnTU11cXRjU0gwTXhHci81V21QODRu?=
 =?utf-8?B?ZjdwOElIdm1TWk4rSll6a0x5d0JhSmpobU5odnNJbEdNcWI3REROaEYvODdH?=
 =?utf-8?B?MWEyRXROOVNGOXo4R1g3UUVIcXNtQ0h2aHl3cGptWmlsZTc4T0NtT1l1VEtI?=
 =?utf-8?B?MVR2T2FRS2FHYUIyODNEaGZNZW9zSmZNQUVBdG9jQVM5Q0JPZzNDRUNib3Nu?=
 =?utf-8?B?c0NIeDN1VzdjTGRQcWtMREFFUzVtWXl1em5JMVU2bkEyd001NmVKVDBsOEl3?=
 =?utf-8?B?d3NwcUpzUWdlOUV5Qlh2dlVGK0NaOGkvd0I5T1V5K0RraXRVTDV0ODdHa2NP?=
 =?utf-8?B?KzVJVHdqWXVaSHFaNkdwK1NJRlNyQjYxUVVLaENPWmRHM3daS2c1Wk94QmEv?=
 =?utf-8?B?TU5DSCttejVpcE8vblZrMmZDa1kxN1o5VmQ4YVJqUnNXbEJwYjZRNGI4V0ZN?=
 =?utf-8?B?NTJXSzFqWVY4TWJZOEpEOXI4cnRlMmdBR21Kc1RJWi9PWEptaEJWdmF5M3M0?=
 =?utf-8?B?b3pxTU9iaFlTRmVFQ2Faa0VpUXVtaGFtczlVT0F5MEljZUdVQVllMHRUNGdY?=
 =?utf-8?B?cTVJSW5xT0lqdjJlbmZSQjI4TWdsclY3dnVYSVNmZGNRRnBsM2RQTkZaMitm?=
 =?utf-8?B?VGt4Tko1Q0hUSXI2ZitpTXBzUzFkQlExbjNxekFIbVFwM2J3YW4xOFM2cW1s?=
 =?utf-8?B?WEUydmlkOUN0eWFHRW9HN3RIOFI0bkJZbDlWWGF1VVlGOFF6aGtBRHRYRy9Z?=
 =?utf-8?B?d3dtN2o2Z1F2aDdSTHMxckluMjc3OWRVd2JnZHBqZGtHVE1RZHg2NlJRTHNP?=
 =?utf-8?B?ZzdXckYyN1FraU53R2ZqSlp4N1Y5UjRCV0g2d2h1WHZYUjcrS3BTanozYUgv?=
 =?utf-8?B?M1ZOUnk0YWptMCsyREQyY1RoQ1k2cXFRZ0wvdDJsTzZiVFVjeUJoWGRYODMr?=
 =?utf-8?B?cmt2WndvUkF2aFdkbmFSajNsaUhPYU1XdVJmMjFxekV2dW5vVUlMbVRITVk3?=
 =?utf-8?B?R1FYNlNwTThOUFlROGFLYUhZQzByeGMyU2NpVHJXbFNiaWxtNWcrWVA0UHBt?=
 =?utf-8?B?dWpqcGtVU3BPSDRDSXY5NVo2L0k0VkZlUTFsQ0t5SVBkcmVyM0FaWm90dm5o?=
 =?utf-8?B?bnpOZk94NXBaa1plbmk0VmY1UzhUam5JT2JlUTJBQjVUMDdua3h6UWxPeXg0?=
 =?utf-8?B?bE16WU1udkk5M2F0R2lySy9RWFhJQ3RWNjlOMVZUSEpNVm8xQnVydFNUSlJs?=
 =?utf-8?B?YnJvYm0yWHRwUm9yRjZWMWhLenVWNTErV2MyY29FL20wU0tHb3VFa2RqdFRI?=
 =?utf-8?B?QTF0YXhMQVM1UDZTc1plNHpHSFdaZlExeXJRK0gvbUhHNk1nL1ZqbVJOcnIz?=
 =?utf-8?B?VEZRUVlLaVJCbkVlaE53eHp3Z2lmaFhnbGNYZVI1RGlyUndoUGlTWVk4TjZZ?=
 =?utf-8?B?VUszVW05eWxSYVZjUUJzZXhoQkdKM1o0MDd5UDR3QUJJdG1iZzJIdFVHN09B?=
 =?utf-8?B?RFM1ZG40bjZKSnVKa2o5T3puT1dqcVkzb1p0ZEo4RGlKaHZ5YmFiVGczY05o?=
 =?utf-8?B?NEZoWk9vVFcxMWxsVy9lL3E3N21RWVN6d2F2dmpWQVlrN2F1QzNWcXVTZVVx?=
 =?utf-8?B?b0dRdHdCdTBIcTc4YjdxQ1JCQ0VJNDltQ2ppcllYbXNDRnpQUnprYU1oY3JN?=
 =?utf-8?B?dHNsMjdjMWtPNnZpVjN3S2RNSjYrdDV6K3NydnhPY2h6SW0vRnNHcTB1YmZL?=
 =?utf-8?B?WkUyckxZMWhHOVd2d3ZnekEyNThWSUV3OElLTWVvWE5abERVM3p0VW11VXVO?=
 =?utf-8?B?djE2MElrQkdUcVNteHBTb1UwdmRvYmczdzBjV0dMVjhLaVVjclBwN0JvYmFC?=
 =?utf-8?Q?rc5rAC4VcQCzSZZkl8H/emrcntCTPfSM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndlazJHb0dqMXpqamxNRXVDREo3VXZqWUE3QzhuS08zeDVBYlFGcHFLd0Z3?=
 =?utf-8?B?aHo3SS85UjhWVzBUdW5QK0NMZGUzbVBwSnA2UlF6R2VOVkkyKzZwNDJ3dHdq?=
 =?utf-8?B?bGxER1NvdFhMZWlpSHZYWEJRai9uOFlORmhLcFpIa0xIc0JPS1NjZ2YxRHdC?=
 =?utf-8?B?M00zUk55OCtkcVBWYmt1SFFtU01mTDR1dmdQWXlvY2ZLL0RkS2pvb1ByT25K?=
 =?utf-8?B?ZXpWQWFTd3JtS3hmdXJScFNhcXhjMUY1TjZwWjZ5VmJrNFkxd2ZYT0t0MFFZ?=
 =?utf-8?B?Z293Q05VVmFHaGt2Tkg2UkQ5UmtYQ2RyK2g2OGNsVndNSjNyY2JMMWpuZEsy?=
 =?utf-8?B?amhBQmpqdHpObzJIdi9oOVRJTDdSSjJseVhKaXdJMDdyL1BpOURlV3ZicXpH?=
 =?utf-8?B?Z1g4MGVud3J6SVZ4amMra0RKVCtpZTBFYllkVGZnQ0MxRGpKMG9vTUdXZGhp?=
 =?utf-8?B?RWorbzh1ODJqb2ZrOVVzWG4yMXFkZFptTS9DOFpDdlpFdDd1MkxCOHVOS21W?=
 =?utf-8?B?Sllia0lmd3lwVWxuN2RFL3ZEQWtFaklQb3hXR3FnOVlvSjJHYVdOaHUybGVx?=
 =?utf-8?B?WUNDdi96U2N6OHVYL3dmTnJTZXVjbnVWdmJvcklyK3N5RHc0RXVLTG5kMGNW?=
 =?utf-8?B?eG9WUUZzckkxdVRabGIxblpVc2ovYmtkVG9SUjQranJMK0hxSno4VmJBRitl?=
 =?utf-8?B?N1hjSFRBb3NpZ285N2RWeXZqU3duRFdDVkRHZHFvMzJ4dUZhUjg3VGUyVkZM?=
 =?utf-8?B?Z0ZzRXNJOEhlaTliditqK0xxYU5XUDZrYkdFenMxMmNGQ2lScmFmTW55U05z?=
 =?utf-8?B?dCt3Q2M0MDljcVBtRk1jUkNEUUhUOHBHOWN5c0h6TnNtYVk5ZXFVbUNrS09S?=
 =?utf-8?B?WXBZNURPdm1UTE11STBnbFdsVm5BbWF6T0dpSlVXVHVoQ2RzYTN0ODVFQXdT?=
 =?utf-8?B?aFQwcDZmNlZSM2poTEVlOTMzVXoxZ1JveGFNOGVNMEZHVlp3bVFzUUJxS0ls?=
 =?utf-8?B?WGlVbHFBS0wvaVFGTC9SeXdVMnpQSXIwRjY2bnA5eUlJei9ham0xRWswc2tU?=
 =?utf-8?B?aitwU3RsWmkyaURPKzc5ZUZ0Qmd6ZUN6YW05T3MxSVdkVGMrSithRnFudC9m?=
 =?utf-8?B?SWRxK1NuWXZUWWtFcFBQNE9zQWRZN2R0Q2gzZitKc3o4U0grbUd1Q2Jpc1FV?=
 =?utf-8?B?U3ozSmUwR1Q2R3lFMm1HVThXWnJqYzZJcWs1Mi9XanlVakZRbU9zaURGNmtr?=
 =?utf-8?B?bHlkSmxBQlF4NlNNY3hiWkFzWDQ5Yi8zUkF2QlVsRTR2SVdsK3BJVUQrTzZa?=
 =?utf-8?B?QlFqNkpmOFhHSGZjeFJUUU4rb1VKeWN4WWJTeEtmNDZkMlhIR0VRQnkrcFg1?=
 =?utf-8?B?MHJQSnZkRXFhYUpONTlBZmR6b01FTHE1ZU9tNEZwRHFZQ3hIMHpkeDhiblJv?=
 =?utf-8?B?VmR4Zk4rdkpQemlYdmVYQTBtZlVaR0ZKQWNUeGdoOHZKMCtzeU04NldBcmhN?=
 =?utf-8?B?ZUJzWUYzYWhoTXRlNjUyejMrRVNFUWpmZmxQemRsS0ErWXNubGZmUW9OMU1l?=
 =?utf-8?B?ZUpsZVE3OStSM29qc0dvRlVVTUVWWFFYTkJPMUdBMEE3WEo0WktGdjRFWVQ5?=
 =?utf-8?B?RVRPTEVLeVNBeEozNTAydmdBdDAvOXF3bVZIZVBhR2VGbG9zbFVJWFhNa3B4?=
 =?utf-8?B?TjBSY2pjVkwzRG9CVGhjSXl5RUh1T0Z0NzhXK0VjcnF6VU5sUVhYZVFFTHdD?=
 =?utf-8?B?RmJ6M1pSRjdrYXhzV29hblM5TndJQzZRb2FKNDFML2JvOFFsak5mdlVlWSt1?=
 =?utf-8?B?YXAvS1BVclRselYvTmxXc2NIcFVXbThwMldxYnBJNklXeStPQ254UUpwWlY3?=
 =?utf-8?B?MEVHYTdsdG1neUk2bHhFYSsxUmlYSEZtQWRoYVU1ZEMxZXZVNjJVT21HUlhG?=
 =?utf-8?B?Zkx3dWxYTW0wRFArVkNRb1dGc250cXhBQmQ2dmV6bERPTkZJS0tja3VSam1L?=
 =?utf-8?B?eVRESEs0QWpDa2tnUXBXbU8rZXJHcUF6dEtCcFBDQkxoVlhsR3ZTbTcxc3dB?=
 =?utf-8?B?QjZxQzVjNStnS1VMU0grWXZOZThBc1grTlgyRWZMRFZEOVkyYyt2WnZuTjNh?=
 =?utf-8?Q?IZQ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e835a2-71f3-492e-cb95-08de3d7b2128
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:46:58.1575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dprLfOxVWe7JibT100vSvixnqN+na/rF4MSlohvIAu3tVuCeLZHp7K0ftC90wNjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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



On 2025-12-16 04:10, Christian König wrote:
> On 12/15/25 17:56, Philip Yang wrote:
>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>> to GART as mtype RW caching, to reduce queue switch latency
>>
>> Add GART mm_node to kfd mem obj to free the GART entries after
>> MQD mem obj is freed.
>>
>> Use resource cursor to handle VRAM resource which maybe on multiple
>> blocks and use cursor_gart to handle GART entries.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>   5 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -880,6 +880,67 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>   	}
>>   }
>>   
>> +/*
>> + * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
>> + * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
>> + */
>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
>> +				struct ttm_buffer_object *tbo,
>> +				struct drm_mm_node *mm_node,
>> +				uint64_t flags)
>> +{
>> +	uint64_t total_pages;
>> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>> +	uint64_t page_idx, pages_per_xcc;
>> +	struct amdgpu_res_cursor cursor_gart;
>> +	struct amdgpu_res_cursor cursor;
>> +	uint64_t ctrl_flags = flags;
>> +	int i;
>> +
>> +	total_pages = tbo->base.size >> PAGE_SHIFT;
>> +
>> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
>> +
>> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>> +
>> +	pages_per_xcc = total_pages;
>> +	do_div(pages_per_xcc, num_xcc);
>> +
>> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
>> +	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
>> +
>> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>> +		u64 start_page;
>> +		u64 npages, n;
>> +		u64 pa;
>> +
>> +		start_page = cursor_gart.start;
>> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
>> +		n = 1;
>> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>> +					   flags, NULL);
>> +
>> +		npages = pages_per_xcc - 1;
>> +		while (npages) {
>> +			amdgpu_res_next(&cursor_gart, n);
>> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
>> +
>> +			start_page = cursor_gart.start;
>> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
>> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
>> +
>> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>> +						   ctrl_flags, NULL);
>> +
>> +			npages -= n;
>> +		}
>> +
>> +		amdgpu_res_next(&cursor_gart, n);
>> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
>> +	}
>> +}
>> +
>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>   				 struct ttm_buffer_object *tbo,
>>   				 uint64_t flags)
>> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>> + *
>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>> + */
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> That need a better name, something noting that it is mqd specific.
>
> Potentially just merge the code into amdgpu_ttm_gart_bind_gfx9_mqd_vram() and keep that name.
Looks better to merge this function into 
amdgpu_ttm_gart_bind_gfx9_mqd_vram, then don't need this function name.
>
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr)
>> +{
>> +	struct ttm_buffer_object *bo = &abo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	uint64_t flags;
>> +	int r;
>> +
>> +	/* Only for valid VRAM bo resource */
>> +	if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
>> +	    AMDGPU_GEM_DOMAIN_VRAM)
>> +		return 0;
> Please drop that check.
done.
>
>> +
>> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
>> +					 amdgpu_bo_ngpu_pages(abo), 0);
>> +	if (r)
>> +		return r;
>> +
>> +	/* compute PTE flags for this buffer object */
>> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>> +	amdgpu_gart_invalidate_tlb(adev);
>> +
>> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
> And a helper for this would be better. Maybe we should move all the gtt_mgr functions into a separate header like we did for the vram_mgr as well.
>
> But that can come later on.
mm_node->start still use in many places, will add helper later.

Regards,
Philip
>
> Regards,
> Christian.
>
>
>> +	return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 25640bed7dc9..9f07856433fd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>   
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>> -
>>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>>   				 struct drm_mm_node *node,
>>   				 u64 num_pages,
>> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   		       u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index f78b249e1a41..edb72f4ef82d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>>   	      struct kfd_mem_obj *mqd_mem_obj)
>>   {
>>   	if (mqd_mem_obj->mem) {
>> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
>> +					    &mqd_mem_obj->mm_node);
>>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>   		kfree(mqd_mem_obj);
>>   	} else {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 14123e1a9716..5828220056bd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			kfree(mqd_mem_obj);
>>   			return NULL;
>>   		}
>> +
>> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>> +						       &mqd_mem_obj->mm_node,
>> +						       &(mqd_mem_obj->gpu_addr));
>> +		if (retval) {
>> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
>> +			kfree(mqd_mem_obj);
>> +			return NULL;
>> +		}
>>   	} else {
>>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>   				&mqd_mem_obj);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 06cd675c9e74..55738b30c2ec 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>>   	uint64_t gpu_addr;
>>   	uint32_t *cpu_ptr;
>>   	void *mem;
>> +	struct drm_mm_node mm_node;
>>   };
>>   
>>   struct kfd_vmid_info {

