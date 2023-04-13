Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31388C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 13:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF80710EAFD;
	Thu, 13 Apr 2023 13:28:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7326210EAFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 13:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuVRf/2jYupjX0yjfJkRKvoJzXdEQlCXKcnjTe8+c7jSiOwxIsHxLYOs6Z7N975YBvhzC2ToScNcFeos/00JB/HV8UFbWGTO+uIK93rBqpMAFDVy3csT0M7+1r98n79Nfd4HqBy5H1CcajEs94V3D+hnCP5cP4tdWvxbtAyGbdSJ/3w3ILXhf2q6/hMaJZ0kLWSxRPPplB+AKlI/B8sAMQWZzclE1/e/HGW+pa6jvUeYaUj1AA6T2qxLXNipV07Z2Q4BevFxbfk/XMyVcXsHzdRd6N5M6uE09eL7lqW+Ako5FX7MF3r/TGCfhK2cIGEnBA0KkoJYjQN1+WgRNW+emA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xipu0BZQPs3PI1sldbjksS8bAsIzWq7jz7yI11hrlc=;
 b=T5MnkriBXM451y1flGCX5vje5r/zD5ebossol620NGT+PxbY8goX1UreFEuiXDserF4lSGMpOy+lyR0/A4M7siPNHi4ScWcKGfEaf9Vk5/2crU+YY8nIkwPgPfHoLyTG8nltJPGEEIE3UIxVuUKT7XqekJF2jNfa71hK3Tg4wEEh46Pc5b5ADEuozlCdgKpueRlvtIleqOS4h8LveevDOkow3P9Hv9euw6wpSDgKpyEV4year2LgaHuwEgtD8dv2i+OK3MYder1NpAGGl0qRmaj0cphU3dzr9lMECYQtDg3REqic//Tm5FX3CnhHnvCMLjzBNBUA2LJxIb0CCZ4W0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xipu0BZQPs3PI1sldbjksS8bAsIzWq7jz7yI11hrlc=;
 b=3rzPzTg4lvvbAJkVDYL2LcWyWOMOPP+vrf06+h+H0jWjP/cYQXp4jpjfwPGzPWA6P7JsFemilhbii5O0ye1j/Fn6fF0Ig0kNLomMS3+3+HkDh1WHjVrxh11YtX5f5wgetGoVzWSKPpVDIO8HvVUOI60zZ0YDkL1UvkW+pw6dg9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 13:28:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 13:28:29 +0000
Message-ID: <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
Date: Thu, 13 Apr 2023 09:28:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 479f8740-70e1-464e-e93d-08db3c22f800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAdvx+x/pElOs/qDbyN8zu6414+asTqBFDpATYbeizAvQIU5viUhEhFsqUi13PCZB78BT9QPzJqrqyIKE5a++K088GglnZpfkY3eYETQMxCHF4miXft5yrXObpgxchGnnXWsLvmpgM6LFTuvbCM/DhC5qX6i3Kt5MjvnE/fzOXCYcic7Qe91Zf25F2KyYOrpex0KJdY4mc3+FbulnlOyR+M9ZxBxha20V9bVKUpO2TrXQwFDfxXa+D2Po1WRW1NX6QjZkw8BzhRLbQUskyWdi8Wc+LsARTfWZY5FjRuxIzASeqB1ToJY3dUSlyeeT7pCNbtUDJ+war7efUUqOCf2lBvLHfS9L7sfiZzhyv8EZm3UhJgyhttHQHcrb1B0Ti66Ip/lepsuBy3gvD8Yg7Yh5cUWLfaOE3hMAYU0Rd+WHBXSB/HcFL5rXR8oY/KOHf3SwhEjSvHOfmubVAhSQ4ZIng8Vnnbbf+6fYXB9uD0pnZD6j/rECozPBma68W1SbLueeY/2FuzHuOhCsNeDzP9zAcwM/xQSwd76QB6YsIwUtBhjNsyUVCu4sGDEuj+NejduNlJEbsllTlrnu3lWAVEubkt+ZF/DgBdIPCSOHaURSlXnG2tNRbV3khi0trBJWdGov9zn6fzddbX5hNF3jAQFQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(316002)(41300700001)(186003)(6506007)(6512007)(26005)(38100700002)(6486002)(31696002)(6666004)(86362001)(66574015)(2616005)(83380400001)(36756003)(66946007)(66556008)(66476007)(110136005)(6636002)(2906002)(31686004)(5660300002)(44832011)(8676002)(8936002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitHYit5UGlBYXVFN1VFTk5naFFYdlkvUWt5WS9tWmtUNUJ3azNYb29PSDhQ?=
 =?utf-8?B?N3NMMHFXMFB0N05xNTZjN3pRL2NnbUFuWDVOUzg2YXZ2aUFFN0ZOcUFjTHo4?=
 =?utf-8?B?VzRnWU9XVUVVNGFDL0s5QkdaTDhrQnlNcG5pQzhCeU1JbUE4RWFnaFN6NjJq?=
 =?utf-8?B?RWJlTkFhSFkrZXhPVjYzbjJTT3hFbE9tTitYUzhhSkFUV2FzT2FUY1NLSXY2?=
 =?utf-8?B?VU56ZjJ3aGUraWcySDBkbnZVaERuNXI5SnZjMENrYllHbnhsb3o1cUwwc3k1?=
 =?utf-8?B?M0M4eEZmVFZOc1lDWDY2OXB4U2RZM0MrQUU5YzljbmRsR3VrM2plN1NDZ0RS?=
 =?utf-8?B?eFJJYWt0STRoOVNEY085RzFaUSt4Z1o3cVZEK1J2LzJrRk9ZWHlJOVdyT0ZE?=
 =?utf-8?B?aXpHdHkydlM0WU5CalRSMnRKRVhIZmg4LzdWTFpQM0lmeFg5NkJBcG5LeTB0?=
 =?utf-8?B?RjE2UW1QaXREMEtDQjFQYUkrVkIxQitwN3cyRXhUbTc3TUd6bkRlKzVXZDdX?=
 =?utf-8?B?RlN4emJTRXB5eERYejY3c2ZkTkZkbVZtWU5TY202QnpwcjRUZTZkMmoyRVdz?=
 =?utf-8?B?bWV2RTV4Zm1HWFAzQjRMSzUzZ2JLb0RQQ2NCM1ViSzBkSzlmMU5DajNpclU5?=
 =?utf-8?B?U2xuZ3Jwd1h2YzBRUlRVeU9oS0d1WlVQTlR6MERtRTRxck90WXRxUHNBVElB?=
 =?utf-8?B?QW9Fbk9TcnZQWCtJN0Q5bzIweXlFSHdMcDFSVXdwTG9DMUNrUjBNZ2Q3VlNn?=
 =?utf-8?B?L1RVMkFDOXFVMndVLzVNMXNjTmtUTlNqYkVaWWRLeUs1VXBlQ09iVVpBdVln?=
 =?utf-8?B?RVdiZkxsNkc4b0VvRFNTSnZ3Tmg1RkhYVDhIKzYxUENPcFNCTmNEZUpTTGh4?=
 =?utf-8?B?QTZNbE5vQlg3YzZEcTM0TUd2ZWkrejFTejcvdzFlbDVaU2Qyb2ZtcDRWQXM3?=
 =?utf-8?B?T0FQYzBrODBIMnNWTWl1ZTlrTFIvS0FaMWpscXI1QUJJVEdjekFma0NzNUJn?=
 =?utf-8?B?WFFjNngvdU5DVmFUMkg3NWdmU0xBNVhQSDB4ZTViVW5NUUlxYk1OWWREWktX?=
 =?utf-8?B?eE53eU9ENkFieFF1VHVtZGtVL21PZkxGYXRFeFI2UzNsUDJvUXBlcGh5UHZn?=
 =?utf-8?B?N3ZyaldackYrTWorSUVMOERvMU9VQzFKc0NycDZnck5JYnFtQnBEQnMwUHho?=
 =?utf-8?B?QWFjTnhTQmRGZFdoK0g3TVNuWG5mcjhaV3pVZ2xmNnZtcnF2YzNWdkMrNHUy?=
 =?utf-8?B?cWsrbWxuQkM3RmVmL2NwVmMwTFpLODlGK2crZzNMVkR3Q0Z1NWxMOFZrT2dV?=
 =?utf-8?B?NEtZNkpoMEMrVzNEUmJidHMxMUhpa0tWSHgwYzA4U2d6aGhRbHNUbWhFOGVY?=
 =?utf-8?B?aHdhaEliVWVzdmRVV2g0QWJhRzhRdWZFY1F0RjU4WkF0K1IrTkdxemZnUE9m?=
 =?utf-8?B?S3pwdmZYM1NVMEFxVWE4YTVpSTVuZ21qMDlsbjJiWlVydFo3VUlsd2w0NXcz?=
 =?utf-8?B?NjJ3azJXQkFialBRdGhwSjRZZGVRKzVkeHNPbXdOUDZ2V1dLTmh5OVZyVlRQ?=
 =?utf-8?B?dnI0a2xlaWpjZnNUTlV5TnRiYUJQN1NRL00yS1FiYU5HNTh1Sm9ZTnRoY0ZR?=
 =?utf-8?B?RC9iLytSMGQyd0RmTlRGYjY1WUYrQnNoTmJGY0tDUk1RS2NOd3p4TXRPNEZQ?=
 =?utf-8?B?S3RTN1gxYmpjak9PSmtNRGxWelV3cmZBMitURis0L3VRVjUxdFhTQmRHeERq?=
 =?utf-8?B?THdPdGJNNFpiVldHWlJIV0ZpSFdtM2hJcUZlVkVpYkhGU2NUUW95Z1NiSGh6?=
 =?utf-8?B?Z0lmd2N2WkVrU0VqVm04VEFzZ013K1R2WkhCZ0JMRU9pK3praG1NTHVxYTNx?=
 =?utf-8?B?MWpqYmRNRVRIdUhwU1NNbVgzOTlMbWdCblhFRmVodHpWZEovNVkxdk5iNUx6?=
 =?utf-8?B?VURZMURhRHR4TTVDZkJwQ0J1ZFpDMVc3V1dsNDRNZjNVMGdpNVpCMmtSa21i?=
 =?utf-8?B?ODZTKy9GelNyam5FN3FoK1pPUlZ1UzRDNnh1a2I3eEtjdUQ5T0xZMUpTdW1G?=
 =?utf-8?B?dHRsejlqU084THNHRWh3WEdtTHZtK01ZSGlteGhjVkFFamZ4TDRpV3pybGJZ?=
 =?utf-8?Q?a+HLrIXuNn+E4k+lQKPe/PvkO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479f8740-70e1-464e-e93d-08db3c22f800
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 13:28:29.1837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glFDn+yzJn23h2wKvc1H+3NTZYRgB3+gnPL9IOfqO+y/PS5sgpW2opkIRtPPYpBAPd6dM0KopNppnLeXRQunNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
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

Am 2023-04-13 um 07:35 schrieb Christian König:
> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> I'd like to get an Acked-by from Christian as well before submitting 
>> this.
>
> I have to admit that I only partially followed the internal 
> discussion, but in general you need a *really* good explanation for this.
>
> E.g. add code comment and explain in the commit message extensively 
> why this is needed and why there are no alternatives.

OK. I'll give it a shot:

    This code path is used among other things when invalidating DMABuf
    imports. These imports share a reservation object with the exported
    BO. Waiting on all the fences in this reservation will trigger KFD
    eviction fences unnecessarily, for example when a DMABuf import for
    a DMA mapping on a secondary GPU is being unmapped explicitly. Only
    moving the original exported BO requires stopping KFD user mode
    queues. If the invalidation is triggered through a move notifier
    from the exported BO, then moving the original BO already triggered
    the eviction fence and we don't need to wait for it again on the import.

    We can identify DMABuf imports in KFD for secondary GPU DMA mappings
    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
    operation that ignores KFD eviction fences.

How does this sound?

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Thanks,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>> ttm_buffer_object *bo, bool evict,
>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>> +            r = amdgpu_bo_sync_wait(abo,
>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>> +                        ctx->interruptible);
>>> +        else
>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>           if (r)
>>>               return r;
>
