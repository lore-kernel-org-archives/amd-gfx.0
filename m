Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDE9EE3F39
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 01:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1204310E258;
	Wed, 13 Sep 2023 01:01:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A363610E249
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 01:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+7EI/SpteUnIHz7kJAbc6lvDc/DyW47r0heSAk8qYKnLnnMCA1nP4t+t/xWa104YuYUG1q2oLdfFd1dBhqJSaYX+5qq9a522tt5kfd/fllQf/moH1TCrLSbdelw20p47KS6ohgRxQob0SkFabOYmYBDzNIgcZqVyqcOnTn+EImFgAwFz38E8hh46B6IIv41h2XyvKKTk2aC4Lr6Z0DMQ1UDC81Zn1rWZf00jUHTNUb5pjhBk2ountCzJuFv5jscwk0y03BohGkNYZF0OOBDWDrMVhydveZmj85Db2GkVDLFrM/4vgX0vhe05ojHoMll8x/TwdTwsOM5htRlCSrzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeCUU+QuVn5xEQHh74PY+1U5/EO0n2ugqFJMyxAl9KM=;
 b=SqZ9cmtWhJYM8QyvRxobhXETJkvEHuhzqu4YUmHN+G/+gLpgzrQEZGufVHVicw3FtqnmGo6Qvh5SByMJ89cSFZlYruCj7uoL0yR7htFjpFLawDlcAXmmFazfyl8qt6PqBNVki7jR+YsO9ifrPAKZ3agN2os7PaqoAM5Yg8qdzxPTFoHInBZNNhqf+OQKf/iZRqBqs9diLGq+WEnGQbOFbUrsEpgO9AMlpanTaAFVgRV0ETofWNjFaSs0kJNaR3w0B6ox5YpB6Nsh4FpMY3qDYmMuZvsQAnT/GmHRiboZ1/H3w+K6xmTfeWtHHxTMz7n7kjnNz9g/whr+XZ3bIKaXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeCUU+QuVn5xEQHh74PY+1U5/EO0n2ugqFJMyxAl9KM=;
 b=RyTu9TDGXh0IiiwE16uFDb3s8EOvniUxlYphOaIgvpZ6BgYLYBTCQ8jRQgeWDKy33ZqhbWsWOLg5T+YlYtqtSAnOdGvVhhovXuVdoOTCQxzJ54dXy86OujNRJIRRJZgQwu1s8A4PbUV/HnVA/+0BT3jAaqo4eaPyNEFkZxuepvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Wed, 13 Sep
 2023 01:01:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 01:01:22 +0000
Message-ID: <7cc164f2-e44d-a96c-4791-4d400ff6e0c5@amd.com>
Date: Tue, 12 Sep 2023 21:01:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
 <97d7d655-66b8-e117-471e-0785affeb660@amd.com>
 <CY8PR12MB7435E5A7985CB9D26AF0D64C85F0A@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CY8PR12MB7435E5A7985CB9D26AF0D64C85F0A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddea213-745a-419e-6e35-08dbb3f4f291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j71d0TvXwH7SVflOqomMG/0h6iVmwxrJi9hMjlSSpAEn5JpdLn8gL7szAHT4dm/VnTEcnNumY2X/SX9Dj96Pe+hZlDc0CKGcqSdytIxseDmKzDfKVqcRMcEMtXX1ZB9gzl2PMGBfa1mCwX74feIMkzwVVx+7eG2xW6WPCMf4TL2AO5zXZh1X3QbAfUNEW/e+SULpP8WN6AYzkbzcvouap/tARhXpIBnt4eKui77kLz6ahX6uTfRBJ/MeRqGyN3m8l5LMmU9Exz7Qq09/KhszUlyPff9Vck5KTGmOvQwqdfP2PZrt5wfES+TyfH4l+Pe+RqlEd0VO3hIkU4fkBBbVynN8g8FcoHmIWubbHC2omeFCarJil2slafBmnFX8VDSAsuTe1CxMUcb4n8WnJP06iTRifaRsbmREyFKKWiiDYN7EdN/ux/hcBS3DA+orUhtDBgusqpDs/o/nrufWA0hT4lP/Y02jAwd9YDJArKnn1bcxPR6gKSV835hF2dReXHjWBsYA38vZJl705slrP0QQXusD+PGkxiy+zuV9Yn3tAXDt8ten3Vt7HEG3wcWXhvrZSQ6rlFeaD0+ei/Rb78kdIA2LtcFcdjZxL3kXQBSszkRHFJae0FvHnfEtCJT3WCn7MNigrOaYmKyCUdhcHxOH1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(186009)(451199024)(1800799009)(6506007)(6486002)(53546011)(6512007)(6666004)(38100700002)(83380400001)(86362001)(31696002)(2616005)(36756003)(26005)(66946007)(31686004)(316002)(41300700001)(66556008)(66476007)(4326008)(8676002)(110136005)(44832011)(2906002)(5660300002)(478600001)(8936002)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVGQ0NmSGNGdUs2WlVnTlRHNGNBejNNUWM5a25LT2RVNFl5clRoRnF2YmFi?=
 =?utf-8?B?aHpTSGdKWURtYlI1S1FVWmNXYzRTeUZSLzJqM0RVOFBzL09icjBoN2wzcGww?=
 =?utf-8?B?b3Q4NnZ1a0JZMWUrZGtzS1Q2QzNHS2hkRndRQ1lHcWNMQzg4TVh4SjZ5V1Iz?=
 =?utf-8?B?TVhlK0hweUdOR3NKWkNwb2ViMkRJa1c0Wi95dmJFR2NURXlQQm92ODhpZFlw?=
 =?utf-8?B?NjdLckdoNUxjbkIvK2ZkTnJ3ZGJPaDNHODRjYjRmaEpIYWttcWFXamRiRmlz?=
 =?utf-8?B?ZTdXSEkwZXJGblk4NHFMbjZHanBpSFBmOVlNOEhKci84cmpNNnZqUWNlM0VL?=
 =?utf-8?B?d3o2YjZPSEsxWlFjSkJBZG14emhFcklVVFFGcXBCOGRuSjNSWWpwME9IaDFl?=
 =?utf-8?B?VkZ6TGx5OEpFWEZXQUowcERsMXJDYUxLU21QZ0phTW05NDNSeG1UZ3doeHlO?=
 =?utf-8?B?SWNab0xVVTNydjhjY1d0THMxenFaa0ZmSlZlVnJCOFI2UklMU3p4SzlsWFo5?=
 =?utf-8?B?QkRxbXl2bGxMSkY2YjM5NTZMbE0rL1hXODJId2VIUjhKN1l2T25qY3EwZUp4?=
 =?utf-8?B?M0llOHFtWDdsM1BsWUFnc1U3Y0tqaUo1cjZTeGtISnQrSkRidThGSnVYM2Zs?=
 =?utf-8?B?azJiSVNlOWZmc2FWVG9mdFhKYnFxSmlRdWFrRENHKzlxOE1MRU5hMml1UGQv?=
 =?utf-8?B?MzVwMkFrakJlY0duN2VsY0FTZExRU0ZZOHpIOVZQWUQwUVQyZGN2V3NrYm9K?=
 =?utf-8?B?MkRRVnFiVGJLL1ZFN2VleXNzTUtpeitTaVBzSkwydVp6VWpnMTh6STZ6aVhU?=
 =?utf-8?B?VmtsV2xDeEJiYXhpcU1WdzJ6S2JZeW9lMjlmTEtQK3pIbXVPVlU1Rkdtb24v?=
 =?utf-8?B?MG9acjZyOXc3bGFlRGRqaGVaT25oMUNJTFBsWk5Ec292T1RhR01FcVFCK0FY?=
 =?utf-8?B?enR0a3RkaHUyd05ndXh2ZnIyUHdMcEhoRjF6cGlWbHRwcWl3eTJ5cHZhb3RP?=
 =?utf-8?B?dFhrOWZ2VmhwTFRLRDE2TkJtRSt0Q01SbjFDZGN0VFdQUnVuMjV6VUcycERp?=
 =?utf-8?B?N1BSZ1J4d2ZwM0RXclIwaGgrZ0V3MzQ3aDJreGRGdzhENWdBNElDWW0wV1Fz?=
 =?utf-8?B?TmRJN3dLY05NTVVJYVdDejUzOHZQYWtmRmViNDZ0bHdtYXA4aGM1YTc5bFA1?=
 =?utf-8?B?VWhmOUZJb1NpSWMwRStDZ05ZdFgyaEo3blNKdTJDc3llOU1DYnAzSlFvV1R2?=
 =?utf-8?B?eXpUU08rVU5uclpEQlExSmlnUm5GeGRrcnFBOHU5QXhxSXduV2ZydXVIV3RM?=
 =?utf-8?B?MnZ1SUFrN1A0T3cwR0FISWljbDN3Q1V4TjdUVHI4Q25ZcFNKS1FPT2JOWVVu?=
 =?utf-8?B?OFg0VU5Od2VpWW9FVmpINVZGSUcvMWxXa1lVYVo5VWhIRGxFcCtidkorY2Yw?=
 =?utf-8?B?V0d6ckd4a3pIRmt5Q296eisyc2xGR0ZUUXhDek4zbXE4UkJ3dUZjRXR4WFRE?=
 =?utf-8?B?U0lMOFBocWJLam40K2lZcVl1U3BvaUhoY1hqUktLRndROVVVcm9aSUYzMHE4?=
 =?utf-8?B?OVpNRm9pZU85cXg4c1JqbUFMRi9LdzI2RFdqSlJTdjRERFlrQk9DMzg4a0Jp?=
 =?utf-8?B?MzNpOG9hOW5vN0NERFI0ekxseHU4SDkxTlVNT242eTA3aUZYZ1FsdEJ4VHN5?=
 =?utf-8?B?RG1QaGRtQnJpaktHQXk1NXkyS1ZHMzAxWEZJVncyU0M2RTZ6VytXdEtma2Vt?=
 =?utf-8?B?bFJFL3RNMy9tdmtGTlJacG8zWE1CdnpvWUI5NHl1ZFFFZ0tGR2FpSGVLYkI2?=
 =?utf-8?B?R2N0WkdCenBEeXFaZThsejlJU0E2b1Rnd1hReGR0Y2RublJZNk96dmJDT3Zh?=
 =?utf-8?B?azFzWnVCTDZkRnQrQ2R3dlloY1k0WlhHL05WWmVrcjlMMHRHam9vaTVrbEhT?=
 =?utf-8?B?VGpveCtSNFlLcCt5N3RGM1JvM2lQZkY5VDU1aWpjajhTUFVGamYxWENkRXRG?=
 =?utf-8?B?SUJkdnd6UTU0SXo2WFZSSExWTHZ3LzBpOHB2N09acEdQSXlLMWJxTTNqOFNQ?=
 =?utf-8?B?ckJkY09ob3A2emM2THRYNHBrekhQRDhkQUZUUnFTZTE4cU9xYjREUHV3V2ZL?=
 =?utf-8?Q?87BGWYgfXOfZauwg3ureoPl+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddea213-745a-419e-6e35-08dbb3f4f291
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 01:01:22.7973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KovgNFF7ySvOeIwW0hV0XKkIcJbbZBZ7dOFBtYn5GO9ksDtNkbDNRG6C0l1DOeWEGUfPCyhEqZfq6g8oO7Gyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, "Ji, Ruili" <Ruili.Ji@amd.com>, "Guo,
 Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-12 20:53, Kim, Jonathan wrote:
> [Public]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Tuesday, September 12, 2023 8:36 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Ji, Ruili <Ruili.Ji@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>;
>> JinHuiEricHuang@amd.com
>> Subject: Re: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
>> non-init cases
>>
>> On 2023-09-12 8:17, Jonathan Kim wrote:
>>> There are cases where HSA is not initialized when adding queues
>> This statement doesn't make sense to me. If HSA is not initialized, it
>> means user mode hasn't opened the KFD device. So it can't create queues.
>> What do you really mean here?
> I meant the call to runtime enable e.g. KFD test can add a queue without runtime enable call.

OK, this can also happen when you run an older version of the HSA 
runtime that doesn't support the ROCm debugger yet. Please update the 
patch description accordingly.

Thanks,
   Felix


>
> Thanks,
>
> Jon
>
>> Regards,
>>     Felix
>>
>>
>>>    and
>>> the ADD_QUEUE API should clear the MES process context instead of
>>> SET_SHADER_DEBUGGER.
>>>
>>> The only time ADD_QUEUE.skip_process_ctx_clear is required is for
>>> debugger use cases and a debugged process is always runtime enabled
>>> when adding a queue.
>>>
>>> Tested-by: Shikai Guo <shikai.guo@amd.com>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 6d07a5dd2648..77159b03a422 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -227,8 +227,10 @@ static int add_queue_mes(struct
>> device_queue_manager *dqm, struct queue *q,
>>>      queue_input.tba_addr = qpd->tba_addr;
>>>      queue_input.tma_addr = qpd->tma_addr;
>>>      queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
>>> -   queue_input.skip_process_ctx_clear = qpd->pqm->process-
>>> debug_trap_enabled ||
>>> -
>> kfd_dbg_has_ttmps_always_setup(q->device);
>>> +   queue_input.skip_process_ctx_clear =
>>> +           qpd->pqm->process->runtime_info.runtime_state ==
>> DEBUG_RUNTIME_STATE_ENABLED &&
>>> +                                           (qpd->pqm->process-
>>> debug_trap_enabled ||
>>> +
>> kfd_dbg_has_ttmps_always_setup(q->device));
>>>      queue_type = convert_to_mes_queue_type(q->properties.type);
>>>      if (queue_type < 0) {
