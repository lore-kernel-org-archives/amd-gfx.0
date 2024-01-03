Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E0AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 15:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAF010E2DF;
	Wed,  3 Jan 2024 15:33:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F2E10E2B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 15:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeCHY+bBGgdkt3o7rZFSg6l/ZKL79koYM6cC22gfJhAp6ZDALVyOGBbdHdqBDIV0DqaL4MkLKOcfAMyZ9E1NTqAbOyb5JejwVpfccenF8czIgyUfMjtdltX5vdqY3OhbCZInuxuQ60jWuK8vfAuGHAo/mrRR4qnNQHIX73Ibpq6IFC2adsbHUO5Ka/v1bXJPI2PL4owXOdNNuycWnqdQxomhHWoBp4DjEGNnJ3lCAu6Cu0dFGVi9rBrk++2CwFHzjCjFEIruqZxUAcxwXIdJPBHeD8UVAOrrb7uDl4zGUxPaWM/pPxGmKOAeZBCi/y4BgBQoGguCBuS70Z88lYNKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uqHNylpTiTzkcENe4Tnw8e1dOeFgl4cOg7Q+0NBayA=;
 b=fw9pZ6ski8VM2TAgBrMHs2092BMn1WNlKbnA4yRejlfxBrT2zLREgKwoqIBSfOqEo/pkGtfVTrAwA8XBfDkQMjs6bisUIMvc5jERv9hDobFHHG4BBDTHBS0Jj9W4OqiSTTaHTUtcQsiusHjV7tYBvIVx40exyYpc5hT35LzzCrS3LiWhmSZ0RWIoA240xzccrVmYbIRrEHpIpN6+SsnirVeKUAIndvEjH9r+zb6I0RW7wM0vqfR+lX4QUZfsKROOKnW2h6/KgI/eADh/l/P7uJjntqnUeAyZAGdBPuSfwDWBg4a+67vBaQo4eF6irKHSMlYifcr2pk3dGdpsthghuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uqHNylpTiTzkcENe4Tnw8e1dOeFgl4cOg7Q+0NBayA=;
 b=idoiHk33DjMerJ8+7/uZ3P08IY6VRrp/WwgTjHchvQxeuAHcz6iHEybzgSi20g/bEnvISAq53QpGZs/SK+FBAPvfitFRyL4cVsx+ZYlco0SuwVZ5LNoHTYlofb623+bjvo3aLlJuORjEpD8m3E0P51W+5B4o5JLit13GWq9Q670=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 15:33:00 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 15:32:59 +0000
Message-ID: <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
Date: Wed, 3 Jan 2024 09:32:57 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 5088793e-727f-47c7-82e2-08dc0c71443f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBesXY+wpV7RSoWrnuOln/Wn67AodYzD1sOu8j1SW2s5xhGknVxBFRFd/9spREE/ct457XnOqSikzJVpL263wszfapykR3oYF37n92k/IzP23PK3wDP5DNTn/Bz0RJEQJ1SjgO+TBR7vXtnHvKdzVN9NAI7WkhRQtY1sWBpA6sd6ytVgOnhKnDxlrEURmKaCT1oRdiLWJ8mHJ7YBD5i+4eKmMg4Myr4aNVTHqmwRSONMCxMHw10TjwuKP+bWd0pgkkjeG//IurXlyF/Y24hX7lL+iCKEt50we7CNCn4eXYjbSrDblV1eo6qoi3SFZkEuBF/GgKlzWKOqRAaA4hKh9/CSfN5+k86jOY/VGW/RL8i5UqknFnG0cKrECuzZ/HgRSThD6GE02Us1QQTV/6kVUKeWk2JFcJeyq3hATE45a7WOOTd+scET7ahjEyqZccXBeVW1lbVI+wWr4DtTmbGGfPZEzZN8QHinSn7BSgkE1F6C1QOTTQhkei9HqN5yLv6a9LpaPa7FGsNg3WX3EmoXboJVZ6hpxPHPLDjH8kaKqQyquFRmERGzCh90qbpazE9F9iwPd9HbgPYimMDOLKr+BBGZVDa7BckeoM5mc6hky/MB+f4NThbB2IoBSjLeZ+Uj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(36756003)(66476007)(53546011)(6506007)(6512007)(66556008)(66946007)(31696002)(86362001)(38100700002)(41300700001)(83380400001)(6486002)(26005)(2616005)(2906002)(44832011)(478600001)(6636002)(4326008)(966005)(316002)(110136005)(5660300002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJyVDlxSTVLcHZTeVdhNXZYT3czbVFUbThsWVZzQi9UTHJPSUlCRWIwQmR4?=
 =?utf-8?B?Q1BMYUtmdVQvcEZEdkVCRExLYlRISVpObCtlNCtWU0R4eHhZVDM2REoxTDlB?=
 =?utf-8?B?OWZJb1JOY0hicHZFY3JpWXYzWWs1ME9zMFFycUNLWlVwbVdldkdXNm1TaGtj?=
 =?utf-8?B?SjBCeExhaXhoaU1lbXdKYUZ3VVpIZUlkNXpYNTl5OGZXRVB2c0VjRnRuNzMz?=
 =?utf-8?B?UUFOYzkydmhtM1ZlUHBZcDY3WVBzZEVmT3NacW91YnFaZVVvd0FIUnh0QktX?=
 =?utf-8?B?OG54WU9FenFUM0JmbW1pS0VXUmV2V0tEZVM5QUZyMWtndGFZVG1lS1pRZXJ3?=
 =?utf-8?B?RDZYMXRyQTM1aHVZZXFaQkVheUNWaS85b0tmeUNrRkkzRlp2SkRKQXVhcWlu?=
 =?utf-8?B?RGsvelNXbjB6ZWlOaE11T0RCWFJiZlJJT1lNQjlRRUZIZmhDL3BUZ0dXUHps?=
 =?utf-8?B?ZHVJWnlYbUpudmlJSFgrSGZTVlFoRElwV252a216dUIrS2JHTkVDTGRPb0U1?=
 =?utf-8?B?S1JjZEkxTUtRSzIxV0prK0J3amhJRGNkdTZvcGdObUVrZDJpTzBiWXZxcXhY?=
 =?utf-8?B?WVBJaGgzT0ZHVGQxcFh5MXlQVmxkM25aalVHbEtrSkh2blNyNUdWZGpIOTc2?=
 =?utf-8?B?d1c3UnMyeWlCRk1UQ3B3UHQ4WVFHeFVjYjRXaVplY29tYmJqVUxXU2k5MlV3?=
 =?utf-8?B?NURiQ29iam1nenVWTWtlSlIxYTZ3NmEycGJMQkNwdDlaWHJnaEhzRXJHTEkw?=
 =?utf-8?B?NEprajBiSi9odm42QXJSbWhkbDJxdnBuNmx4bTJMZ3Jsb0lIK2VRM3g3Q1ov?=
 =?utf-8?B?emtHNkxPKzNYQ05mcUFQc0l5Z1pYbjh5a2FUYW5IMU0xZEI0TVVBTlEzMjIx?=
 =?utf-8?B?akpYUGNYeVl3SkN0NGxzZWRsR0xsMHRYd28wYjFtUUovQUE1UTEyQ3psNVVQ?=
 =?utf-8?B?VVdNQWdKTlZlNFlJNVEyVk1EZzd4dUZuczJRWndzZ1A3MmsvQm1BRFdCbENu?=
 =?utf-8?B?bUZtc2Y0SHlHc3FHSUtlZkZ6UHVPbUp2YUk1U0tGd1VxamNuRkRwaVFMcmo5?=
 =?utf-8?B?dHAySW50WGo0a0NpZmJqMWVvMmo0cjRrdEZYcWdMZFk5YWpCdlVyQUljcllN?=
 =?utf-8?B?MFRJWDY0OThwYmR2d096Zk1nUkFEbllWbHF2YW5tVlU5MVpKTGllNzdqY3RM?=
 =?utf-8?B?M3NXK3NEN1ZNcXBiTzhqUEp6R0s4ZEdIYURiZEpVWVJucEhRTW1PQnJGTkxp?=
 =?utf-8?B?MitsbzVWMkJiS0g3WUhDVUFhOG5jQklSV283NkxoS3RJYkNRVklaVWdaeUE0?=
 =?utf-8?B?WnArY0F5aTRvUjBPelNrU0wrNG9zeUdIVVk2dDJFVFVDVlZjVFZBVFlNMkE4?=
 =?utf-8?B?Uyt2aUNoMjJYbFkvUHQxNzdKOWU0bExkTlRUeml5cjdsaURVVEVJT1BHb0U5?=
 =?utf-8?B?WHI1aWM3Q3I5RG9jQkNWV09iZkw1Wk5neHNueitkOEkxcENVTHNjQ1VxRjVS?=
 =?utf-8?B?Z2hBODF2WW5NSGc1K0xnUEt6am45UFo5M3pzY1kzSWpxbXhPQjE3V2hjRWdI?=
 =?utf-8?B?SEpxcE8yTHF4eGU4aFRyWmNtZ0hnTGJtblpjVUpsUnRpY1VQUzFkMVF1UG9J?=
 =?utf-8?B?TGJVMlArc1QrVWdHM0cyWlMwbGJjeGwrQXVRL0Y3alNWY1U3Si9QQVlpcmcz?=
 =?utf-8?B?M2dESkFwcUZZeXhxaGZQUDJEbmp1UXV6NE42RlUrVm9OK0U5MGpCT0o3R0ZB?=
 =?utf-8?B?ZGc4MHZsMitTc3d6SE5QeDZWQVdnZmJnTGs5aVVjOHlEZ3EvMzI3NE5VZVZF?=
 =?utf-8?B?Um40c25ibjdjV09CUEZtRE5XbWZwSThaUmIxYVB2c2tTZzNxWTZaY01XU2lt?=
 =?utf-8?B?SWR2ZjBjM2g4dEtOeFptdTlqY1BnK2JEQUpVQXdWV0tGRE9ONkh1NmJNVldu?=
 =?utf-8?B?bzBHeWVLOEdwaUY1V1RTWFVnSHBya0hGTXdvaFQ4RmxMUURHbUxoZXBXOVFt?=
 =?utf-8?B?eDNWa3BDRGZjN1NDZGU5QWJEdk1aeVR5aGlITDNHRTRBRUR5UDZqQmE3RjRn?=
 =?utf-8?B?VDdLU1l5MnF6UE9zUzQxRDRveWdpUUFKYlpGODlnSHlwdndmakxWSzYwZHRi?=
 =?utf-8?Q?ztlLB0YQIoFWKryuFbk+pr9ka?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5088793e-727f-47c7-82e2-08dc0c71443f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 15:32:59.8030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB9JB1C4Y8jggxzym5CChOSsDyrUvmzJJX8xgPcum5Fk1yTNajMi+8WnqMWAWkSv/GkB7+nojzNFkn+3hs/+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/3/2024 09:19, Alex Deucher wrote:
> + Jay, Felix
> 
> On Wed, Jan 3, 2024 at 5:16 AM Kaibo Ma <ent3rm4n@gmail.com> wrote:
>>
>> That commit causes NULL pointer dereferences in dmesgs when
>> running applications using ROCm, including clinfo, blender,
>> and PyTorch, since v6.6.1. Revert it to fix blender again.
>>
>> This reverts commit 96c211f1f9ef82183493f4ceed4e347b52849149.
>>
>> Closes: https://github.com/ROCm/ROCm/issues/2596
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2991
>> Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 26 ++++++++++----------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index 62b205dac..6604a3f99 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -330,12 +330,6 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>>         pdd->gpuvm_limit =
>>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>
>> -       /* dGPUs: the reserved space for kernel
>> -        * before SVM
>> -        */
>> -       pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>> -       pdd->qpd.ib_base = SVM_IB_BASE;
>> -
>>         pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>         pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>  }
>> @@ -345,18 +339,18 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
>>         pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>         pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>
>> -       pdd->gpuvm_base = PAGE_SIZE;
>> +        /* Raven needs SVM to support graphic handle, etc. Leave the small
>> +         * reserved space before SVM on Raven as well, even though we don't
>> +         * have to.
>> +         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
>> +         * are used in Thunk to reserve SVM.
>> +         */
>> +        pdd->gpuvm_base = SVM_USER_BASE;
>>         pdd->gpuvm_limit =
>>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>
>>         pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>         pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>> -
>> -       /*
>> -        * Place TBA/TMA on opposite side of VM hole to prevent
>> -        * stray faults from triggering SVM on these pages.
>> -        */
>> -       pdd->qpd.cwsr_base = pdd->dev->kfd->shared_resources.gpuvm_size;
>>  }
>>
>>  int kfd_init_apertures(struct kfd_process *process)
>> @@ -413,6 +407,12 @@ int kfd_init_apertures(struct kfd_process *process)
>>                                         return -EINVAL;
>>                                 }
>>                         }
>> +
>> +                        /* dGPUs: the reserved space for kernel
>> +                         * before SVM
>> +                         */
>> +                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>> +                        pdd->qpd.ib_base = SVM_IB_BASE;
>>                 }
>>
>>                 dev_dbg(kfd_device, "node id %u\n", id);
>> --
>> 2.42.0
>>

I saw a segfault issue in Mesa yesterday. Not sure about the others, but I don't know how to make this change while compatibility with older UMDs.

So I agree, let's revert it.

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
