Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900A5C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 14:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B0D10E97D;
	Wed,  5 Apr 2023 14:13:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4461710E989
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 14:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr5A7O0FfRqcffu/db18X/S/HMR6MjU/6Xb3hXrqm74XYNvd+epBDqaQiG/Iea4JST6X76fUKqd6E1NxkPHBI8Y2xsOJOHc7nADk33cGc3bFdYOIC2bcF5PqJ6dcChDpw5KNHLfIhCVU1VzhIvHzHBzntqfpXNd01xsvJHM8bn0FLsheK8+hN5FbBnFIydGJVeSmGBTcGnPDCqEEZ59pCIryeFVtnl8N+hTFpfxlVqyWfoC3bE8qolnSN+WWhzEmT470olrtCNMugnDolGg/piqRs+Opa5Tef/qUT7xPFKTcMPpPIhAua9qc2gS30rtWnO0onXwnuvqv3BQF+F4paQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dszZlbUkE0HWarHcCySXowIy+EigJ5XI16EmJ0kn5sc=;
 b=QIrNltbNKxxSUW6FA+4D9Wh38Sap23PP9UBJTbqwLMnInD9L5DRWFUp/nhsJ8QFubvpKDHuw5WX23+51WN3DBq2H6Pw+hMERmQypkA+CtGU1gq5MFHC+NhiLidgattoMqEZG5AvngXQdweE2l3ioAxIekQkldDs715r9J/6Pb7RrBbDJszlrz5BgjbF7cB7DKlaBoZdgP/Db5zvL/NbLNv6/B0Q6bawcU2Bfd0zwic3PRxELyi7fUfO97ol15Ikic+/hU998zh0AlBG7J+HpZJAAl1cMpVIZoLF9fmADFiEyt/yLRga9BqY9Lr4I8M33tZ6wnyw7cVXZh3MLSAR5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dszZlbUkE0HWarHcCySXowIy+EigJ5XI16EmJ0kn5sc=;
 b=iVptTztyrmlPQlX/DopE37qK1RBbvQCpU3VbRDwMV48Yso/ZHqYDZ9buPv5O2GYHjDWtTYrpcgaoTsSUCjYdd0RYUEldFV6CX2IlW7MzyQTujoaMiIA3kvRAggpWpM0C6a+j6u5GeYOHIwr+vy/9XytAQBgRmhpYyNeIajTW7Kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 14:13:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 14:13:50 +0000
Message-ID: <a35a4485-42f1-fdd0-cc18-051b355448f3@amd.com>
Date: Wed, 5 Apr 2023 09:13:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix trivial style errors
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230405132428.393593-1-srinivasan.shanmugam@amd.com>
 <DM5PR12MB130816E7449E8137E84EBE6585909@DM5PR12MB1308.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DM5PR12MB130816E7449E8137E84EBE6585909@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: f3483fe4-7e10-456b-eaa5-08db35dffa8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErwGZ+wy7tOzV7+Gk23hBHQQMNVx+riGNV0uL7t9Uav4mzGe3lhVBXQsnAGaXJTGWPMtnVg36Bvcpo/BrWrMvPxpD4Sy7ugo5u8Ynvye/ddSBsD+BnkRNFfIDwYGFCpdoJPZP2bZzEQS+LXwkDVfp8t8dq5+41wRyh6QgQxY4Ia1yNEBjyGt5bZeCRhCARVzSr4psMFfDP1fpVzq7iaORiGPpobGd0pi5xxcooCurLamjbup7ShUa6oMYsFmmK52J7C9hGGQRUxesVOvd1UXscr8+x0Eyhh7odGqf07FMgBPYUkDKPK2jc/nesXAJJ44F1o5epa/55qHYNJu/8BSweJR4CMADbUr9mlkyy1XJN9rksu3VpvZcgwDsbIV9CS2c2eGQcOcZO1Xz2akq1LhM6hqBRKt4ZwWgwUlFWrewYLFlD41NG1IKrZYtjkyjxGacX0RwZzwCJ+gGDFrXMXm6CqOd+MiJ06PNMZHDuHk4LOEVV3GHmMltJjLMs07EVNBBOdUCJ0jlb7mMGXurHKH0gX0fsZKyDLfcCIy4bGqFYyK0Qp1LgrZn5/rBtfjERS3iCHJZi0V8wRgh+BIzcP3a4SzaSvq9lwErV/OYKCM6hbv/eqFKBrScWU0zSINqwpTwMvbJqgFHh/gedSIOU1AbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(86362001)(31696002)(36756003)(2906002)(31686004)(66574015)(6486002)(2616005)(53546011)(6512007)(83380400001)(186003)(6666004)(6506007)(8676002)(4326008)(478600001)(66946007)(66556008)(66476007)(38100700002)(44832011)(5660300002)(110136005)(6636002)(316002)(41300700001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JiMVZVdXduUmY4dXNyd3ZFL1FxQ0NOM0krVDZMTEtWTm82a0VBanZSbnFK?=
 =?utf-8?B?OTlienN0dlBTWHQ0Nm50V3JYVEl3aUVYSEJYSmdHdWVCTVlDU3haWnNSdFZh?=
 =?utf-8?B?T29pVkQ2Zmd1Q2s0NWdDbXNNcldPOWpFMlpSbDdXbUNqeG5HT2VRamRnM1Yw?=
 =?utf-8?B?SXlDcUtaVU1LRUVmYi8wVWREMEJzbEZCMUFuYzM1T1dMTElySDNaY1dGeTl5?=
 =?utf-8?B?em1Cdm15bDRIVllZRElCUmoyd3hZOVh3OFJUVFVyUVhGTGxacUhFTUcyaVdG?=
 =?utf-8?B?Tml3WmJlck11bGZzZFA2SlFQc0l1Q3UrcTBrRjU5SUMvRVk3aEhxOUlTS1FJ?=
 =?utf-8?B?bVFZdTEyRGF2YWM3MEpTemRVV1ZhOEsxQWxteWs3b2FqUG5WNS85aklxbnNH?=
 =?utf-8?B?ZkNBTmNJZTVyUWNuSldjekZhSk9mMGphUGhJNzZNWUxsRldsT3VLVTNNWTJ0?=
 =?utf-8?B?K1pScEZuN2lmc1VIb3I3eHp3QjM0L0ZlZ0Y3eTc3RGVUN2xuTjJHZ3Eyd0dn?=
 =?utf-8?B?K3RBN1d6MVNLQmdZK1RGb2MwL2V5MGlKQVlCV1VNYmZ3OUlKMDRISEdOajB4?=
 =?utf-8?B?Rm05UXZDZldwNUhQZm5KdjNIMTFXZE4yc1NEbm9NcE9FOHp6NTh5K1NUSFlT?=
 =?utf-8?B?MWlwY1RBT1BEbWlWSWh5VkNKOXlXM245U3VYVXhEMm1acytFRGpEcEhzcXdC?=
 =?utf-8?B?UHc2YWlTdUxaL1piUkx5QmViaTRJcmErUXUzUEQ3ZGRxUEpQNEkwM0F4TFJP?=
 =?utf-8?B?ajg5dm81ZExXNnozNStwWEhzWG5oNzdtU1lzMW84YTR2ampDKzhIYjZzS2JX?=
 =?utf-8?B?bnBRRmhOV3hQOWp2dWFQNzVyRzdPY1NVRm4xZytsSXlyUjRkVjZlVSswRHJ1?=
 =?utf-8?B?V1oyZTFhSUlKMlZBbkt6VVhoQjVZa0pFTGZyQS9qbEd3dkRQM3NvNEQ3WUZS?=
 =?utf-8?B?ZlJrMDRGQ0pwWHNBdCtOSU5vUFhPTmVnNzV4MS9ZWnI0MStjZUtrUW10amJa?=
 =?utf-8?B?SHVVM0xtbUpNMW5Nd0lpL2NIdE02MnllWWljVldxRzNJOEV1SVUwVHY0endk?=
 =?utf-8?B?cWVHN09ja3VxODZ0aTc0UlZ5VWE1UHVjMVlYTnJKeVQ4ZG53TXZaL3pXa2t6?=
 =?utf-8?B?TUM0V1REZzgyWXVFV1VYdklycG0rZndZOUEwK2V0NVV5elF0clRVT3lPT0xn?=
 =?utf-8?B?TmxNYXhXajVDamNQaTBvUGtBczdJWGk4RjlLbkk0UjFLaEpsL09NYlA4cWY2?=
 =?utf-8?B?RlpEV3VuWFV4VGc4OVdNdUtJYmRDYlFFbEJ4Sjl1NlgwSWJ0N1NwUGpqeWJQ?=
 =?utf-8?B?V1A3Y3JIL3FxSWFmYlBSNDdjdmhFNTg4VE8yRlAxZWZOYWhnYm95VlBzMHMr?=
 =?utf-8?B?NTA0azhJQU9WQjhXSkRZZnU3UkRydGxTRTFvRlV0YTZoSGx2SjVhSlhJMHV4?=
 =?utf-8?B?R2ZSMmJMazBjOTI1TWpqb2p5S052UnhsNHdQanpVcG10OWYxK2VNdVhLeTJx?=
 =?utf-8?B?YlExRXN6MStrenR3ZzBHZDhHMnZscENWY2FYby9LSE03V2FRU1BlL2JyRW5J?=
 =?utf-8?B?UzdCcVZkMytnM1VrcmoxdUtnaVJtVDNtVVk4VVgzRGtZa2R6VDd2WjVOd2Iv?=
 =?utf-8?B?aHpLUHlJWVA2T0NDNzBpeEQxUTdTN01nS05aMDd2eDJZclBlNTVwVlJ5MFF6?=
 =?utf-8?B?LzVJU09HeVRTQ1RoU25sVUFGVXNEYU1XQm0xR214bGZXOThLNGdzWU1KZmxI?=
 =?utf-8?B?eUJKOTZxVUh1aEVGWmdmeS9sNlVVSlNERjUrZktIU3RabXV6TzRGZDVNOVJP?=
 =?utf-8?B?RFZwYTdjRUJoWlhhdjlGTUVkQnZkcngwK0pnYjU2cFNqMkJBbmIxTXJpN2tM?=
 =?utf-8?B?WVJEbCtTQm5aMldxaVloWG12b2FXNDhIeU9YaDJRTkcxdHVlV0tpK3ZpQWl1?=
 =?utf-8?B?eEoxU2k5aDdSd2loa05VU3htakJqcHFRUGZPK29HbXNrRmZXMm9tQ1pVa3k0?=
 =?utf-8?B?NmM2SnhoVjd6NWVMQnhldFpBSmRTUFpwQW1Oa1ltVGtaS0ticjV1UDBwL2Fl?=
 =?utf-8?B?R3FmMDBnQjkzb0JqUTgvWVgvTDFteFZ0cUFwR0RlUUwxWUcxL1d1cmFvY0tt?=
 =?utf-8?B?a2VpQzMvN0VHSVIyMmN6VTJNRDNzbUV4RHBqb3BMc0JIM1EraWJIQjZJQjh0?=
 =?utf-8?Q?9q2Axs0tAtaqLhes6Iv5Ikqp6viDFllt1pekD9YubEKC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3483fe4-7e10-456b-eaa5-08db35dffa8c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:13:50.2500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq9cEIVk5pe3RJ6IdnAJnU+bl5HUna6hiHjMPk6XI/4YWMS8dd7vxSGBbyd2fHAURXBzLuGYIv9E13SZJdDncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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

Also the changelog should be below the cutlist (---).

On 4/5/23 09:12, Russell, Kent wrote:
> [AMD Official Use Only - General]
>
> Probably worth changing the commit message and headline now that you're removing the parameter instead of just fixing the code style.
>
>   Kent
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Srinivasan Shanmugam
>> Sent: Wednesday, April 5, 2023 9:24 AM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: [PATCH v2] drm/amd/amdgpu: Fix trivial style errors
>>
>> Fix coding style errors reported by checkpatch, specifically:
>>
>> ERROR: space prohibited before that ',' (ctx:WxV)
>> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>>                                                                 ^
>>
>> ERROR: space required after that ',' (ctx:WxV)
>> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>>
>> This patch gets rid of all above type of  "ERROR" messages in
>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c.
>>
>> v2: The driver doesn't resubmit jobs on hangs any more, hence drop
>> the hang limit module parameter. (Christian)
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index e652ffb2c68e..25606af348b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -521,13 +521,6 @@ MODULE_PARM_DESC(virtual_display,
>>   		 "Enable virtual display feature (the virtual_display will be set
>> like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
>>   module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
>>
>> -/**
>> - * DOC: job_hang_limit (int)
>> - * Set how much time allow a job hang and not drop it. The default is 0.
>> - */
>> -MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and
>> not drop it (default 0)");
>> -module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>> -
>>   /**
>>    * DOC: lbpw (int)
>>    * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 = disable).
>> The default is -1 (auto, enabled).
>> --
>> 2.25.1
