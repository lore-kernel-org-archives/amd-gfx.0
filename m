Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD4C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB9810E32D;
	Thu, 16 Feb 2023 07:24:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DD610E32D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT7ZD/sY/a6uvne/6vvXyo8f99lgsSopllIJB+Oqp5B+mDAU8cEyaDqomLgK7fS3q0DEizSBBkkqZTBSXyf8IpwyZJrn5cfAvgfFDrmTnwcejtPdhlR7CGdRNs+jKafT8UEEuotFAelaohQluC6q0CjKOa+stIIDuYM7xhy5PQy2IUj8jGfPWj4tlwd5yICvnAlo5nwUEHMcYuF1g5cw9a6vtDAqWqdYalrpkZrjz/KmIVH1KOq16JXz2jEfVRaIp3zekSQkxJtlmqZrCy4+uubqx0UbuNjXmyZkfZUDzhqkdrHj5eDS4W/sPduyS+F5sF2erM9yZ50RqCX1W+dGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqfwrAIQTCl+UGC2+h2u+E/vcMXManIyi/m4jquqt8s=;
 b=NifdzS5tGAV3n5xP9gPGXyxjsjWMEJojA3SZao9FZ38eS1b1LeQWOUcQTSgEbqJUN9ukZp76bFpJkZkSfYlPKyiejlQ5kTUHd78SFA+Xz7kB5bEuwkR+dVl4FF6Df+0NK9Nx4ZzuLE0GSvJNshWq9lGh8t2Az9vGkEkf3HAVuNv8scc+a2AMNupm9+Cn32xmRNIBfLQhDTcU72TsNbMaBz2Z2Ce9hmaf/rQbq6C/WTnV8ekQcwVl1+13rQ+FJBMakCwLk0pZ//2pcTFRfjU26cC04FlDMkAJje2MbHVm6Fx0dihzRbiKKCtOtRFFm26xQusOIDdBD0+BHGC0nAvPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqfwrAIQTCl+UGC2+h2u+E/vcMXManIyi/m4jquqt8s=;
 b=YWW/t/fPHkLeQCWWbbzYybB95j7WR+8bGPaNIN4sgE+5Dv0Qc+H5PJLjxsyKl2RB+RfgQH92ittjdG0u3Yv0XQxST9qmAYnMUdE7E3MI/l4QSubqH4oWI7a2vRhoWSef/hlfNzjWrAygWVToJSHJ+dXsYOgtDJRkXnzQwMCMkpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 07:24:11 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::e6e:20a4:1236:aa42]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::e6e:20a4:1236:aa42%8]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 07:24:11 +0000
Message-ID: <c57f334a-e056-f124-768c-8c1cb15b0617@amd.com>
Date: Thu, 16 Feb 2023 12:54:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Xiao, Shane" <shane.xiao@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <ckoenig.leichtzumerken@gmail.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
 <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
 <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
 <46fd3add-e02e-9a88-f672-3ef09da1aced@amd.com>
 <DM4PR12MB5261B9EFFEFB88A558B7E3C39DA09@DM4PR12MB5261.namprd12.prod.outlook.com>
 <ee42c89e-746b-a142-173f-c4d4ba847859@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <ee42c89e-746b-a142-173f-c4d4ba847859@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5e748e-f5be-4ba5-509e-08db0feecc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDNgkKfXZo/iUFqexuZZtSvKa2+o99n8eZZq4OTTF6Imd8JyZmYhKCqNhypEJv4XHXrqV3KB2TdAxUChOA/ZgFJt/BzlnwHQqAH4uONbF2m/pCxakCC8IwvbjSWwwP2CQrfEpQA8ZEcIm1qopLydjIjNnC1J1fuZWrczvkFGVZOCj7HEmwQxY6yrBTv2hdiYgOgoBitfJm5hpQzyUyA9gp+5jiaw4ePu8GfWgSUxSJkWgrv4AvuI1WaXBswVZA77ZJJf5N0oKAse3e+CzK+Ds2NvZFU0OBM5JBLMZL3XDyd/qe5KFUxOhCOmxKg4vOZLHexZJYw5xqkyREykrE7rgCvuo83YdLj7apjaiTE4MLKY7aC+PVBCs9ZwIsJ7r42VIVhqDaRE7QJyTpBtROHTg8I5wX9anq0pmz0h9V3X1PbdXBbQbi1TWEDczjnh5+afUJBWvDriSdqBPQhU8AlKDnKZEi4OAr/QlTfUvtNgdxZV3bJ9JIE1KoGXQE+awvUoVfzxgxH1A3B8qOD6gmskqYPJt6V8Le2f7W+RBg3ExapI7CuAr0nNzdMoJ+LoMOa8sPSoUm0Dd2PrVkz3/HMTmrG8qjrKYW3gv87vto+GszACDWf5fUTjK0MhdlERPn6GxcElzK0mU4PO1PRhaoJZ2W7L3PcMu8erhhSJljcoNdZo1es+lY44J14p3iWLZcdbIPCoe3R3W59U4C5eD85gsXWvJptQCaed8a02HUsHpiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(31696002)(36756003)(66556008)(66946007)(478600001)(31686004)(66476007)(4326008)(8676002)(6486002)(38100700002)(2906002)(86362001)(6506007)(316002)(186003)(26005)(53546011)(5660300002)(6666004)(41300700001)(110136005)(8936002)(2616005)(6512007)(66574015)(83380400001)(19627235002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzV1RTd1SGsySGpmY1ZtS3ZWYmVCVWdUREkxTnNSM3lrT3ROQ0hlZUN6YTJL?=
 =?utf-8?B?NVJibEl3cS85OE5nM2ZUdlNJSFZJQ09qRDhPL2t0WDhuT3g5bnI0M0tPMzFE?=
 =?utf-8?B?UFVOMXdjZytCbDJTN2NvdFE5azhRN2EzdUFkOTFBU0x6cWJmbGZFNFZiNFIr?=
 =?utf-8?B?Ukg4UEpFMXBwOURtamJoUVc5VS9DM2tkb3FOZ3RFdm9YY2Y2aUJ0bkpmWUlp?=
 =?utf-8?B?MWorekQ2ZUdZU0YvL00vVFZNTHp1OVJ4U0IrR0E4N2YzSVV1N3VRN0lCd2hq?=
 =?utf-8?B?Q2hZQWFtSEhuUVc0WW1kMGdwRzh5dlRNV1NlaUFtZVJXNEZjUWl3ME4yeGdO?=
 =?utf-8?B?TzhpdXlpQXNuR2JKYmM5VUV1anRKRU9CUWtoVU13MW5PakVGL01CTktMb2V6?=
 =?utf-8?B?aE5SRjFKR21mbHdLTGxzSGpiQW8zRHdGRWY4RGltVWJ5R0pubzYyNVVvaXQz?=
 =?utf-8?B?L1U0L2UyQ2JWd0FrQ2I0eXl1TWljYnlReGhpTDdLaHlQSFZTMmFJUmZTdlZF?=
 =?utf-8?B?Y2pyQlFUSy9aT0xYT2pkMk11cVVsTjNaQS95RFVqNE1SVE5CSVFoQnE5RWt5?=
 =?utf-8?B?d0dFUnNMZFVWbUlPdG5TdXlrK1Avd0hjVS9tU0MybjZxR0JnblkvT1Q3d0FU?=
 =?utf-8?B?dWw4TXUvdUIzdDNMK2RNWWoySmlnZ2ZjYmgrNENrQXdwU3V6NFNsMG4vakMx?=
 =?utf-8?B?dk5XVU0vOEEyT0V6N1B6djFaSTZESGQ0Tk5NZk9MaUVYYUl0c1ZRS28rUzlq?=
 =?utf-8?B?MXRENkFmeEIxNysrc3I0OHY4SDVReXZYYmxYNHRQSXQyd2ROclZ5RFdTUVlP?=
 =?utf-8?B?R1FQY0FPSWkxQW51UUVydjZzYVN3Wnl6TDlGd1BuWkRXaWhPYmgxQlBPaFRp?=
 =?utf-8?B?TW1GVi9kZFpCQVh6ZURRWndnN2RPTEVSOWZ4OWxDMnR6c1F3b0xZZ24wR0tQ?=
 =?utf-8?B?WGhYUFV2WVFVWmViLzYrWHN2UmUrMW9xc2JZbVVsRVZudm9KbWtQZy9XM0ZZ?=
 =?utf-8?B?WU1NWVhDVEY5RjU2SERIdzZhcUkxTllRakdDS2FuUmxWalo0bXdkRkJRaENs?=
 =?utf-8?B?ZkVNNkhwRkFiUFpSVU5FMForOWRpLzZLek0yQ25wMHh0SjVrWkRtUGlWZnVq?=
 =?utf-8?B?c2c0Z1pwOG9SVkdjVngxbW5DTURTMHJqRmh4Wkw3QklRYWN0cEZYY041S0VB?=
 =?utf-8?B?UCtuQVhKWStKN25YbmJKWUk2QmZ2RTdWZjhxYkxNRWNPc2tGbkVsVjNmMk0v?=
 =?utf-8?B?UlhCcGNpSGtOWE9QK1RQNmJOVi9pdFA3NE8wTmZoTUk4NXIrb056T3Yxbmpo?=
 =?utf-8?B?SjhURlVVZW10WUdvWjZFa01HbENQSjh2ZFRybWlRTXh1TEpnQmlSRzRqYjBO?=
 =?utf-8?B?MlN1YWxxSHcyR0xlbmlqRVRiWXUwMkZIU3lTbHpGbUZzRHpZdkJxRVgrbjRO?=
 =?utf-8?B?Qk91aVowcW4vVC85RndDOVhqdE9qblc4ZmZmYlppd2FlYVlWMWJ0aU42U2lX?=
 =?utf-8?B?dElDSHgxaStjMTZZL2dhRDhrN3VTMHlrQ3Myc0tnQ0I0VDdPYkpUd25hdk5K?=
 =?utf-8?B?NThDYkZEY3BVLzdjdEtwWHE4VmFjdXIzalNWOWQ3MTlra3l5RWJQN2tnREIv?=
 =?utf-8?B?aEhvMUltRDlaREdEclpTbVIreUFsSlFZTkhueUJOMkNPQm5xY2p2WnU0WTQv?=
 =?utf-8?B?Uzd6ZkwzL3BwWnNpOGU2REh1dktsdEhGcklrODMvRTdleFNxUFNxVVA4TWVa?=
 =?utf-8?B?TjY0d0ZCOWp0SEpzRVhHelh5WEc3UE9DcW1LMHlRZGo1TmtwRFJLVGd5R0VF?=
 =?utf-8?B?dTZkWHJkaXh3ZW1ZNFNXcjN4OFp0QkZsWU5hM1F0Y0QzRDd5VWorMldOT2po?=
 =?utf-8?B?ZnJaVjZNTEVTOVp6bTRPcGkzeld1OUdIU0RjNmZOb2JPZ0hGaTRHWU5IQ3Bp?=
 =?utf-8?B?VVFtSXJmdlpWNkRxNzRGeDZuSEpJK1c0R1cxTG50S1RwT2JjUHZrekVTdWtE?=
 =?utf-8?B?b3RET1Z1b2NpQ1FyTGpVUHgvZVd0ejJOMk9JZEhTT0lpUk85RHArVzd5ZWk0?=
 =?utf-8?B?UmMvY3RhL0o1WXZpQmoyWjlzZlF2c0pTWEV6dlB3Q0JXKzVEZDQ1QnVER09D?=
 =?utf-8?Q?+Z+k9QLDYSEkzXiexkoTF/1Pr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5e748e-f5be-4ba5-509e-08db0feecc99
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:24:11.5726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNYAi0E667NOFSZEA2LXSw+WqPQQSDGnRy/0hlpVeZPTYbBdbXvo7FsxpDJhdiZQ7O68jecx+qdSj9y5Tlbzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch seems to pass the rocm memory stress test case.
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

On 2/16/2023 12:39 PM, Christian König wrote:
> Am 16.02.23 um 07:48 schrieb Xiao, Shane:
>>> -----Original Message-----
>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Sent: Thursday, February 16, 2023 6:19 AM
>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Xiao, Shane
>>> <shane.xiao@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
>>> Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when 
>>> using
>>> drm buddy
>>>
>>>
>>> Am 2023-02-15 um 05:44 schrieb Christian König:
>>>> Am 15.02.23 um 03:51 schrieb Xiao, Shane:
>>>>> For public review
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Wednesday, February 15, 2023 3:02 AM
>>>>>> To: Xiao, Shane <shane.xiao@amd.com>; Paneer Selvam, Arunpravin
>>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when
>>>>>> using drm buddy
>>>>>>
>>>>>> Am 14.02.23 um 15:53 schrieb Xiao, Shane:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>> Sent: Tuesday, February 14, 2023 8:41 PM
>>>>>>>> To: Xiao, Shane <shane.xiao@amd.com>; brahma_sw_dev
>>>>>>>> <brahma_sw_dev@amd.com>
>>>>>>>> Cc: Paneer Selvam, Arunpravin
>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation
>>> when
>>>>>>>> using drm buddy
>>>>>>>>
>>>>>>>> Am 14.02.23 um 12:18 schrieb Shane Xiao:
>>>>>>>>> Since the VRAM manager changed from drm mm to drm buddy. It's
>>> not
>>>>>>>>> necessary to allocate 2MB aligned VRAM for more than 2MB
>>>>>>>>> unaligned size, and then do trim. This method improves the
>>>>>>>>> allocation efficiency and reduces memory fragmentation.
>>>>>>>> Well that is a trade off.
>>>>>>>>
>>>>>>>> Allocating the BO as one contiguous chunk and then trimming is
>>>>>>>> beneficial because if we then later need it contiguous we don't
>>>>>>>> need to re-allocate and copy. This can be needed to display
>>>>>>>> something for
>>>>>> example.
>>>>> Hi Christian,
>>>>>
>>>>> This case means that you allocate BO that is unnecessary to be
>>>>> continuous at first time, and latter the BO should be continuous. I'm
>>>>> not familiar with display. Could you give me a few more specific
>>>>> examples ?
>>>> On most generations DCE/DCN hardware needs the buffer contiguous to
>>> be
>>>> able to scanout from it.
>>>>
>>>> Only newer APUs can use S/G to scanout from system memory pages.
>>>>
>>>>>>> Yes, I agree that one contiguous chunk may get beneficial 
>>>>>>> sometimes.
>>>>>>> But as far as I know, you cannot guarantee that
>>> amdgpu_vram_mgr_new
>>>>>> can get one contiguous chunk  if you don't set
>>>>>> TTM_PL_FLAG_CONTIGUOUS flags.
>>>>>>> For example, if you want to allocate 4M+4K BO, it will allocate one
>>>>>>> 4M block
>>>>>> + one 2M block which is unnecessary to be continuous, then 2M block
>>>>>> will be
>>>>>> trimmed.
>>>>>>
>>>>>> Oh, that's indeed not something which should happen. Sounds more
>>>>>> like a bug fix then.
>>>>> Yes, I think this case should not be happened.
>>>>> Actually, I'm not sure that why the allocated BO should be aligned
>>>>> with pages_per_block, which is set to 2MB by default.
>>>>> Does this help improve performance when allocating 2M or above BO?
>>>>>   From my point of view, the TLB may be one of reason of this. But 
>>>>> I'm
>>>>> not sure about this.
>>>> Yes, we try to use allocations which are as contiguous as much as
>>>> possible for better TLB usage.
>>>>
>>>> Especially for some compute use cases this can make a >20% performance
>>>> difference.
>>> We actually found that >2MB virtual address alignment was hurting
>>> performance due to cache line aliasing. So we can't take advantage 
>>> of  >2MB
>>> pages in our page tables.
>>>
>>> Regards,
>>>     Felix
>> Yes, if we want to take advantage of 2M TLB usage, we should keep 
>> virtual address aligned.
>>
>> As you have mentioned that cache line aliasing issue, I'm confused 
>> about this.
>> If 2MB aligned VA get the right PA from TLB or page table and the 
>> cache line addressing mode is not changed,
>> the cache line aliasing issue should not happen here.
>> Is there something wrong with my understanding? Or maybe there are 
>> some backgrounds that I didn't know.
>
> The problem is with virtual address alignments > 2MiB (or whatever the 
> big cache line size is).
>
> Let's assume an example where you have a lot of buffer each 66MiB in 
> size. When you align those to 2MiB in the virtual address space you 
> end up with
>
> 64MiB..2MiB..62MiB..4MiB..60MiB... etc...
>
> In your address space. In this configuration each 2MiB cache line is 
> equally used.
>
> But if you align the buffers to say the next power of two (128MiB) you 
> end up like this:
>
> 64MiB..2MiB..62MiB hole..64MiB..2MiB..62MiB hole... etc....
>
> In this case the first 2MiB cache line of each buffer is used twice as 
> much as all the other cache lines. This can hurt performance very badly.
>
> Regards,
> Christian.
>
>> Best Regards,
>> Shane
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Best Regards,
>>>>> Shane
>>>>>
>>>>>>>> On the other hand I completely agree allocating big and then
>>>>>>>> trimming creates more fragmentation than necessary.
>>>>>>>>
>>>>>>>> Do you have some test case which can show the difference?
>>>>>>> I have use rocrtst to show the difference.
>>>>>>> The attachment is shown that after applying this patch, the order <
>>>>>>> 9 total
>>>>>> vram size decrease from 99MB to 43MB.
>>>>>>> And the latter has more higher order block memory.
>>>>>> Arun can you take a look? That problem here sounds important.
>>>>>>
>>>>>> Thanks,
>>>>>> Christian.
>>>>>>
>>>>>>>> BTW: No need to discuss that on the internal mailing list, please
>>>>>>>> use the public one instead.
>>>>>>>>
>>>>>>> I will send it to public. Thank you for your remind.
>>>>>>>
>>>>>>> Best Regards,
>>>>>>> Shane
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> index 75c80c557b6e..3fea58f9427c 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> @@ -453,7 +453,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>>> ttm_resource_manager *man,
>>>>>>>>>              /* Limit maximum size to 2GiB due to SG table
>>>>>>>>> limitations */
>>>>>>>>>              size = min(remaining_size, 2ULL << 30);
>>>>>>>>>
>>>>>>>>> -        if (size >= (u64)pages_per_block << PAGE_SHIFT)
>>>>>>>>> +        if (!(size % ((u64)pages_per_block << PAGE_SHIFT)))
>>>>>>>>>                  min_block_size = (u64)pages_per_block <<
>>>>>>>> PAGE_SHIFT;
>>>>>>>>>              cur_size = size;
>

