Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271FFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 19:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBF460ED8
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 19:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDBF460ED8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9933E6E8FF;
	Thu,  9 Sep 2021 19:17:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFC86E8FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 19:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ2tsya2HnALBGfDWyGvAkahRhpHTa+GEfbZhE80J0p3dYywPHXhY0bGhjiEk1yTplKKpT+3kWbbbNPib09G2lonfhE0rip+1zdwC2ZjtC1nV8G3T4CXtkX88lxtUKd70cLI4Z5eUIBjnraQXlxGXDBES8FW2ENA7zauUm9LR+cHllqif50+jHcoacBO5sbgT6KVVFjR8B8n07D9ecIocOsHYF9PftXZ9cAKoES2qVh/Y4izxOfL2vLhvG6zhBrNnzjwhpL++JxM07v1ij7sYWbyRsS5YN3/CMiRd4N5/vGLfIggOorBfAEviLfdXSuMtwseZUIYCauCxhpxzEEc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Dx6JWAeC6nW6jRJPghhL2n4mwrWxXv6urm2KYEmTZlQ=;
 b=bEyF9sdm46TsCRObCv58s0MxQ9SEkQbT++LEBzr5QbgI3gpQMa38OSzKyHQlI8sfd5Zbp1V9FXXPJGsiXj0N4jebK8qTgt+/p5MEBfaxtnTKm4IVAoTtulgXZGVBLSWiNf5zud06Ab5w0/6UsGJpcUAADEXMczpro7q8n6U3BggM0Mlb4tMm/j/TwKHna+wszrBAUPBV9tJgkyEPFDguYx3E2Ryf5e/UAUe4g47lmGrLkoQwmNrYp4+suktpAjTeV/oI28o0LNvSEKRL1yyQfo5m0pH7sjzltCa7tNtBb8uVo1jeUz09H+D54wIB0kPdUT1VhGqfqlq5fssf/KcXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx6JWAeC6nW6jRJPghhL2n4mwrWxXv6urm2KYEmTZlQ=;
 b=Ly5HuZBdaqqCOAt0/lLbJJbnX5q+aRKGcnu0jsymRj4ueTNHw7SRKiUQkTskk5CqqtQLhxV1YZ/V4pXpFnfbONH4k+L/jxxBsXmrE1YdAdT+Epac9CO271ax5xeG/So3n3+Vj3Syi6rc2As0Zh0+eE8IF+wxWFsUy6GwdTpy4uc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 19:17:01 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 19:17:01 +0000
Subject: Re: [PATCH] drm/amd/display: Add NULL checks for vblank workqueue
To: Mike Lothian <mike@fireburn.co.uk>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Roman Li <Roman.Li@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>
References: <20210907141058.90751-1-nicholas.kazlauskas@amd.com>
 <25922a3f-82e4-efb8-78e2-7292f000aa22@amd.com>
 <CAHbf0-ExesNSHeE3WZZiqam7it8y28kJsH13SKZVJQxhSKYC9Q@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <9d9bd91b-eaee-99b1-056f-f854093e6d67@amd.com>
Date: Thu, 9 Sep 2021 15:16:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHbf0-ExesNSHeE3WZZiqam7it8y28kJsH13SKZVJQxhSKYC9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.3] (198.200.67.104) by
 YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 19:17:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32457c2b-7b38-4bed-907a-08d973c66684
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5473A6D2528972C7567E13208CD59@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoA8vui6Kr2X2A6ur+1xr/1j8k6S6nQde0+h4qLDxvAJSf+4DY8Pqz/p32I1a0qgWkFw5UbCadlhb9Va/upEyHaZGuykSoM0k/DbpSEwhjdhTptjHN7QMFdniaPEH2u2t+lLKVwF0jeevzEJQg8ynMCh0QxxsCHCrJuTXdxrNLKLUIZFddE5YN5zPe2WRVKmyuiiyPVMH+JohNZ+VTFJt6OBWqzhHl2p+xkVTC3vSjZfA9MQuLVlb5r7cJPAd389BEOlG2AaAkmr1f1+OPH5xhVtUUFebsevGGvPx3k/pB4v85dWsKrRFZF139uQKUVj0vTFCvc4GK2YfHVhzkKBi+G9qfuWNzE3/b0TmVeG0/8I6lX1bhHVeJtGSZLcokBAIK5sJ3NIM7+ebx3grr12uVR+eRcPMuOZWhREwIoxquhC77osaARK/dBsH31lJwWcH+a7hq9XSKIoiwdJLU3aZswLCi9QyvebZMakaBY9DxroNMIqDMKxuHPyFKfGj0Q4+xuwCAIOrElICIQXYbJUv80x8ovf5j8doVR9bvCG996qDd5vV7BfgEkrT+UPlNE/7rKC6XxklKVm7GgS68FO4/xfHT5zNIpicwnXsRGgcBnVMYEXw5+ArJw+5s4Ry4dxfi2WI3tr8m+3Dt7NdeFWNtGqgFuhBtlDfAOkBYnzt9c1f6sxCRBpY+c5u1Amc1S5mXaarSJz2Myl2t77nHjLi6y5wkWHdGSWTaocdyn8i4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(8936002)(4326008)(44832011)(16576012)(6636002)(66946007)(2906002)(53546011)(38100700002)(36756003)(8676002)(66556008)(186003)(66476007)(54906003)(110136005)(26005)(83380400001)(2616005)(86362001)(6486002)(478600001)(966005)(5660300002)(31686004)(956004)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NPOXdvaVNJTllUZW5nTTQ0QjU5VmVLR3Ira0JkSFluUXM2OVZMSW1TRjhY?=
 =?utf-8?B?cVV0cWxSeDMwUzJrditWRVR5MEdJSm1IWGR5VVY5K2xJSytkODdXdEZWTXVl?=
 =?utf-8?B?cW5vbzNLbGhsMW5jUDBsOUMwWjF0QTJnLy93SlZmQnd6K1VpMDV1cUtNTzBi?=
 =?utf-8?B?ZkNOZWtVYkxHV2RpYVZRWjJzTUgxZHVidEliUXVnWnBjNnFwRzdaQVlzUGFy?=
 =?utf-8?B?YXh0QXI3S2pPVmwyV3Z2Y3B5SFBXL3dYemxLSjdCOWcxN3FoeUZJL1NaM2FO?=
 =?utf-8?B?bmNvbFdEdDZsRWFFS1lZbHkvNFBnUnAxSkJIc3QxRzdWaVlycW01QU0yYnN4?=
 =?utf-8?B?QUd0RkRTQzNwRytvSmQ5RmhZMnRsLzd6UDBUV3ZrbDA5bUVPMTlCbzFJRXR3?=
 =?utf-8?B?ckRLTWNMRVZabWJwQ2JyYjRQelRFVnZTVkdLb3p4WU5qenBHRGlpSnN2Q1Rw?=
 =?utf-8?B?aWIvZWtld0RudmNlKzZ6VGE5Z3hjdjhaYmZOV0d0Tml4d1BjNTZQUVRIeW5v?=
 =?utf-8?B?U2tEMW5CcnNjVEFDVXMyNmkzQmZ6aHo3MFp3VDY3cGNTWGlaS1VaVi9NTmds?=
 =?utf-8?B?Vmh2amtrTVJwT1ZqQUgwaHNrODBWTjU5N0JSSHo2d29mUnlYZXBDTWZ5ZjBo?=
 =?utf-8?B?UVBXdGFOOVN4ak43SDVJNlFlWkJrcCt6ZE9xRUhtOGJCRVBvOG5ocFd3azlB?=
 =?utf-8?B?S0YxR2V0aFgyWG83R0sxOXUwTm5iZ3VNU3dzeVBORFk5V1FScUo1UG9sVVU5?=
 =?utf-8?B?QnhiYmI0QmRBTXlqeEF1aWZLQThGY0F2ZFoxbDRsZEZmWGZvY3hkY3lSc3hv?=
 =?utf-8?B?c1BGNk04U2RDcVlPdFlIUmJKNlRkRTgzNXpuYWlMK09QdWZGNnNRUUdBdHJD?=
 =?utf-8?B?OFQ5RWZkYzc3S2ZXR3lveDE0cTE0OFBIcmhxR21CRXhLWmtWMHltb2lLQ2JX?=
 =?utf-8?B?a1NaY0FlYnFNN1h0QmorM3dFNUs1anZWYnlLNmZzOHE5RDZENWJqeldXNGNF?=
 =?utf-8?B?WGFONVg1akJDQ2FGYWxkMmFlUGMrV1J1VCsrdjdtQmhXanNLd0MwYkh3VXhw?=
 =?utf-8?B?S3dEbnNSUGFhOU54dzFReWl2bU0xcWJTZS91QUs1S0hqQ1paWXp6TzdPS2pz?=
 =?utf-8?B?aXlpUWZJaE9rQnZEN2JUR0hMcmRPN0dTRm1QUGVvMllzMTRZV2N5UXU2YXN3?=
 =?utf-8?B?Q01yanMwd3BnRlB4Um9CWGpHa0p0bk5VY2FLSlVvTjFRdml1cnRic2NWUGJ2?=
 =?utf-8?B?NDRTSzdHYkpmbXZGdE9CUVI0d1hHcEpFN2dkNlV0RXc0Wk81SU01Wk9LM0xk?=
 =?utf-8?B?OWwycmRUZzN5bW1uRnRhRDBaOEFtaGt1Nkk3VVVocDVuU1dZUGtyT01sYkN4?=
 =?utf-8?B?WTVzZ3puRk12bXA2dG5xN3ZMMWp1VWxUWW43Y0xXREN5UElReHV0ZUExUXFB?=
 =?utf-8?B?RmUyRk5ndmNQUVVhYk1Pa1lzNi9kbTJFMzBZdWJyVkVHSmpITGtLTUpSRkJP?=
 =?utf-8?B?UW9LWDhDSE1OeHlLUm1UYmR3dExkTzFudlB0ZUNWelArVTRrMzNEeEt4c3BC?=
 =?utf-8?B?VENOTXF3WTIwMGhHM29nQStpbG0xdHhueFdMRU1PS2U4UTVSYyswQUMySnM4?=
 =?utf-8?B?bEUzVWhmK1htWXZpL2hnVkJ2U2RXbUgrUTd3a2d1K2FPT1B3SmNOTnptaGNp?=
 =?utf-8?B?T2dxTnlKMkVqSjJoamtDbURPMGxmNUdCRWR4M29vU05DcFNLeG4wd3Nmdk81?=
 =?utf-8?Q?pxkQzFNc2GgXK8UzWpZrBLf6qhwf3WCLVnrboKA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32457c2b-7b38-4bed-907a-08d973c66684
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 19:17:01.2120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5wuZLq7jATk7GSVhzNtOga45NrqJR1oBgXmia2oG4CjaMNrlk5nTb+CXovYEJ/g84rmWF7f135LPcDIYdpKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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



On 2021-09-07 9:41 p.m., Mike Lothian wrote:
> Hi
> 
> I've just tested this out against Linus's tree and it seems to fix things
> 

Thanks.

> Out of interest does Tonga have GPU reset when things go wrong?
> 

Not sure. Alex might know.

Harry

> Thanks
> 
> Mike
> 
> On Tue, 7 Sept 2021 at 15:20, Harry Wentland <harry.wentland@amd.com> wrote:
>>
>>
>>
>> On 2021-09-07 10:10 a.m., Nicholas Kazlauskas wrote:
>>> [Why]
>>> If we're running a headless config with 0 links then the vblank
>>> workqueue will be NULL - causing a NULL pointer exception during
>>> any commit.
>>>
>>> [How]
>>> Guard access to the workqueue if it's NULL and don't queue or flush
>>> work if it is.
>>>
>>> Cc: Roman Li <Roman.Li@amd.com>
>>> Cc: Wayne Lin <Wayne.Lin@amd.com>
>>> Cc: Harry Wentland <Harry.Wentland@amd.com>
>>> Reported-by: Mike Lothian <mike@fireburn.co.uk>
>>> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1700>>>> Fixes: 91f86d4cce2 ("drm/amd/display: Use vblank control events for PSR enable/disable")
>>> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> Harry
>>
>>> ---
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++--------
>>>  1 file changed, 18 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 8837259215d..46e08736f94 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -6185,21 +6185,23 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>>               return 0;
>>>
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>>> -     work = kzalloc(sizeof(*work), GFP_ATOMIC);
>>> -     if (!work)
>>> -             return -ENOMEM;
>>> +     if (dm->vblank_control_workqueue) {
>>> +             work = kzalloc(sizeof(*work), GFP_ATOMIC);
>>> +             if (!work)
>>> +                     return -ENOMEM;
>>>
>>> -     INIT_WORK(&work->work, vblank_control_worker);
>>> -     work->dm = dm;
>>> -     work->acrtc = acrtc;
>>> -     work->enable = enable;
>>> +             INIT_WORK(&work->work, vblank_control_worker);
>>> +             work->dm = dm;
>>> +             work->acrtc = acrtc;
>>> +             work->enable = enable;
>>>
>>> -     if (acrtc_state->stream) {
>>> -             dc_stream_retain(acrtc_state->stream);
>>> -             work->stream = acrtc_state->stream;
>>> -     }
>>> +             if (acrtc_state->stream) {
>>> +                     dc_stream_retain(acrtc_state->stream);
>>> +                     work->stream = acrtc_state->stream;
>>> +             }
>>>
>>> -     queue_work(dm->vblank_control_workqueue, &work->work);
>>> +             queue_work(dm->vblank_control_workqueue, &work->work);
>>> +     }
>>>  #endif
>>>
>>>       return 0;
>>> @@ -8809,7 +8811,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>>                * If PSR or idle optimizations are enabled then flush out
>>>                * any pending work before hardware programming.
>>>                */
>>> -             flush_workqueue(dm->vblank_control_workqueue);
>>> +             if (dm->vblank_control_workqueue)
>>> +                     flush_workqueue(dm->vblank_control_workqueue);
>>>  #endif
>>>
>>>               bundle->stream_update.stream = acrtc_state->stream;
>>> @@ -9144,7 +9147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>>               /* if there mode set or reset, disable eDP PSR */
>>>               if (mode_set_reset_required) {
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>>> -                     flush_workqueue(dm->vblank_control_workqueue);
>>> +                     if (dm->vblank_control_workqueue)
>>> +                             flush_workqueue(dm->vblank_control_workqueue);
>>>  #endif
>>>                       amdgpu_dm_psr_disable_all(dm);
>>>               }
>>>
>>

