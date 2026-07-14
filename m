Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4092C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 10:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7786110ECCB;
	Tue, 14 Jul 2026 10:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UiBPMh1P";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7F810ECCB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 10:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfNZhGVHgLQuccb4reAX/HBBOW1EnDcc6AoFHLSlrnOyBbwDxK6sR6CEQMbGt/DrgvkVLufcKQxm4fE4LMuHzjULXWyUfjoC4Q4v+HtiZ4hhszMsILcAsECfev3D6n6iWeHuhATG5N39jUxXMXQF7CF4dmfbVmtbpGIeHNFFkF3/ukB0MPI494Pw58SJ2Qy/73st9I+YQrJFXLwiwLnoJDgIIXJ38FDy3Y4UN9dELCq9rBiNT4CQvElDPN8j46WYE2phpRlsSyCRfMp7Lq2XYiJeQa79uO+EeKUoQB6Iuv8CKKsNLPfzInZ6hnp+fMlRrDzloSo4bPMRe/4TaokIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUVGS959zaU+2qTTDEsiXHXRd9DA+oY8eOXey8ZEtv4=;
 b=DavHpxNKkyosbMTsKAYhArSEuf+o1rIJy5ryHgh7LMB1OLkPz9Mbl0/fP8BB05Ak1JRSXEiVR/M8XrKlfnd4DhUtHg3g5bDWToWhaMp+pvcqelsIdiaJ7GIFKiKACzaul+pvEKXABzuV7sdk0+M1dzL4YfM0soYzq1eJ945w7QZNP4ecpLWebKCt5gxTw37QZ6VAci472VWku8/Y/CPuw/dXva1spfoRl8yOy04WbkVl5hgRSzt+B8+Ut38WvZsQZBHC1jq/BzSjuR08q00txg9QB+cOPHPKdiTbsWcaRQPwUfTuRy7lKi1KanFW9ZUegj2fVlmlUymHWkqJEnyZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUVGS959zaU+2qTTDEsiXHXRd9DA+oY8eOXey8ZEtv4=;
 b=UiBPMh1PMMb1aXkoyrLb21DG1pakszW5B91qAb7yllCQxrIRGd50Md3IXIzwC7rhEunfs5y/Ap8OfgHcoImjp4MJoDxP0VQUyZXHd8+iq/Yi2nIQNchP1/PR1stxzBtoERUXSIO5WL+1iDFea59zHGwOL58HaVgXaDAlnPgfnZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 10:31:56 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 10:31:55 +0000
Message-ID: <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
Date: Tue, 14 Jul 2026 16:01:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0103.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1ec09b-04f8-4b27-2016-08dee1932032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g/J8icodnMCd4WYlSNxnPYcTtjDpdFWEB9HnhirYeY1qddOdwWYNU1ygX4zf6jOqOuAvSaJxMETFC1LBNk85EJqctWc42ekreLfLIaWUmKZ061eVA6FbwnVkCGe/oJdj5/LPHsd5E9l2HBkOGq0A5YXDUGS7Xfl8e0m6UhUlZVgr9IG90TbR/gKtNoDhGtblF7CoMJvb/U9WlTJR3Eq9Qk3kqKFQO0Rhu11kNtToVelQWUq5WrjXj7akoPoDlBiyZRmt7MXRbhejiKuQEyzKhN36l0PT2qmhxPOZnqJVo8Bk/vtXe0PL01fo761Mt0KUzO38v+hGPmdYNLLbEJUtmDMYPSY/v0AUYvPldXLEErzjAEL7YZKFkAkmpJZ4RXzcChoD08IEu02r1EhYXovgYpITaGP1iLfnlByG4b6ygr0XfDBvJgGSgnZDAEJ6kM4e2royQ0TdwINc6mjn83DG68Nz79YBBpd5L+wUJXPmz5oOAPn3y+30yGU0OP1Knlh7rHnSJ5P7ili47woL59XzyATus+E8YeS03dIWwaHPa93q/fiQzoMztyb69P+BPEmwaL9T3ILTA9+ANnlokGkSC+ot5GVPHTtVYKLXz7kUckg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVdIcUJOS2pPWFpvMkY4QUE1VzNhVWhiMVhIb0xVQ056SGtYVmIya2RPN0Iz?=
 =?utf-8?B?KzNld0gwY1ptZ1l4VkVVRndkeFRVOTJrVkJ2WWZPN0JyODlyZHBoOUV4ZWQ5?=
 =?utf-8?B?MWN0N2o0RkRNUVkvL0JVbEZvQ0JOaG9PcHAzZDMvSUhFbkh5Yk8vVTd1TE5Q?=
 =?utf-8?B?bEtya3dDLzEzam1RNDVjMDNEN21HejVrdDBqYjZjVG5TbFhYRTZBOUdkV3BF?=
 =?utf-8?B?cEpxcFVBU2xTWlQyQU1FMmpBZ0xqMS9GZnh5NUw4Sm1RUkErN2ZhSW0yaEZj?=
 =?utf-8?B?eTdsWHEzZDg3VHF2Mk1NVTRJanN2SG5NRmhrdmo2L3NxS2NnalI0UFNDU1Ns?=
 =?utf-8?B?K2hhK01WYTVSVjViQWV1ZFFjd3V5QmV5NTUxOEhDbUltUE1WVTkrSXNoVEpP?=
 =?utf-8?B?aDIvNlZKbUVGTzFaSGZwcUxPVlRMbTdJY0grWW95enVBV0taNlJMdmdDUzZW?=
 =?utf-8?B?ekNDZzVNYXdhNk1jb0JKalVUaW9Ya2NZSGIwSktNaHJmbk5DN0NvaFdndnJG?=
 =?utf-8?B?d0tNVEhiREFWMjFNQmdBVTgxZ3V3b2pnbk84aFRMWnZNMDdiZVVLZlY0dXRv?=
 =?utf-8?B?OUxnSGM0bU5ZTWduR25nbDJIaGwvQ2F6WlBLZnd1bWZIdTdsUEFuRE5BNG1a?=
 =?utf-8?B?LzI1NzJxdG8yZXVIZWlVeDlsTlRkMExld2FDbHJyWkpYa2tNeC8wc2lmOXdP?=
 =?utf-8?B?NXA1dmxyb0ZJNDBLWmh2R2tOUHNMc2l1dlZiNnBydFVMNlFnYjcvUVpyY1JD?=
 =?utf-8?B?K3BhdmtSbXJaaGZKOG1qNTE1YnVnRmdTa1dnZ21RSDNkRkNaYWVlc1QxMTJT?=
 =?utf-8?B?a2lyemxxRDBJTHVWME9CVkhIbVBnMjRkaG5yaFRyMElUbzVTTTQwTXRCNkkr?=
 =?utf-8?B?bys0bFg1NFpKaTNVVzVnNE1vci94U3NaV21QeWYvSlpVRi9mS1g5TWxRNUh1?=
 =?utf-8?B?czM2TmQ0ZW52bk5BdUsySVF3S3g0aUdiVE1nVGs3U3Bpc2NIMWo4L1YweHNv?=
 =?utf-8?B?M2dnQU5Ob1VCZTlrQlRiWmd6d2dkOW8ycmZRTFZTVmxoczBVMWFDS3ZBNFRN?=
 =?utf-8?B?a3l4SnlMUmxoWVJtNk9YYTFGMjZFUzB4UnVYNzlIZlVzWUFJK2NTMmFjd3pP?=
 =?utf-8?B?SW9NclJRbW9RSnFtM2RiZXI5d2xqaXJPUVRWUUtsU1NFMER0My9EVDRWNFlu?=
 =?utf-8?B?NEREc3g0Qnp3VXFEQXR1WlM0d00xMCszeGthTmI1ckZQYTVCalFpUzJOVzA5?=
 =?utf-8?B?WWJyVlhYd3lkTlpLWUt3SC92V3VoQ1lEaDNkejRZTjRnYzJ6UE9lSFExVmdS?=
 =?utf-8?B?YnRlUWRDcTNhU0YybnYwZHJ6MC9QL2pZd2QrbmhBV3BMOHF2aGV2T0N3S1dE?=
 =?utf-8?B?d3RVYWRVQy9UYTROZmxsa04xSWx5K2RFazFpalhRYS9tcjF3am5FREZPcmxr?=
 =?utf-8?B?UGxXb2RYNm5LZmRrU0VwOWpXei9TOGpxYXpKejNvRmJ5TjdwYTA1Y3c5Kysx?=
 =?utf-8?B?MUNqVTVKTCtyTHA5ZUt5ZWJDWmIrcVlSNWNkOGVMT0NkOWhoeFA4eExsN0hW?=
 =?utf-8?B?dXJoeXZjd09DbVlMR0lpR3RpMXZhRGRNLzJ6T3RzU0FtbTlBMVVNTHU0dC84?=
 =?utf-8?B?VzZiY2JtU2pWMEc0eUljZ1hOd3pOUE83MHlEWUZ3L3Y0NVoweFd5NU9YL2Nw?=
 =?utf-8?B?WGowZEhBMU5ROWlxLzdTMTlwa3hTcHVtbUNVRlhBRFFXWGk4QU1GV2Z6ZVZ4?=
 =?utf-8?B?cXNLR3c2OUpRYjZCNGdERDNpb2JXVUpjd2R2aGtEMnhPR0VoR0hzYklHNjZ3?=
 =?utf-8?B?VXlCRVNrd0ZIbTljancrSVBxMnU3K2pzU2FvRW1LZkFqTnN1clZKYmlpcUkw?=
 =?utf-8?B?Yk02ZUU3NE9lZUpGV3pOUHpjUldUSEZNUkV5d2dsQ3pUZlMvQWdiT3JOS05Y?=
 =?utf-8?B?amVXMVVsS2tJeTRBdXVqM0pXVVFUQ3JPOHU4bGtad2VmSlJYVVJVSU9XUjBv?=
 =?utf-8?B?bEpwWUpYRjJRWTFqM0Nmb0VVUTNaQXc5SFQ5c3paek5oZzlzcEJRZElhcFYy?=
 =?utf-8?B?cHFzaTFMcUZxYWJnNzY4bDB1V2V1OWZkdVNiQ2VFNnp5WW9QdkR2OVp3Rmlo?=
 =?utf-8?B?bzMxRUhuQ3MzMnhUUU5xTXJCbkx5QVVObHlNVjZIZ0ZtdVFIOW8rcklOYlFR?=
 =?utf-8?B?Ym1QN2g5a0NYcis3bWdvd0pXZVFncjBLOWxDWDd1NmhRY3pSTzliQVE5VjEy?=
 =?utf-8?B?TWgyUWRscFJyYkwvb3ZxUHJyTmJId2QvU2NyMWw4ZVJ2SUlCUHREbmRoZWFs?=
 =?utf-8?B?Ky9EVjBQMGhFcTZ5aEpYSHpvTnlzQTZ1Qmg4aWFsSzluaDM5eENTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ec09b-04f8-4b27-2016-08dee1932032
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:31:55.1190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y57dATB4OPa6rQYlR3z+5gFfkwRSZXXfH/9B56eWgv7WrV7BYazLcmyGYiM9xLD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
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



On 14-Jul-26 3:57 PM, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> 
> 
> 
> Get Outlook for Android <https://aka.ms/AAb9ysg>
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Tuesday, July 14, 2026 3:14:34 PM
> *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Deucher, 
> Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil 
> <Sunil.Khatri@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu/userq: properly account for resets
> 
> 
> 
> On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
>  > AMD General
>  >
>  >> -----Original Message-----
>  >> From: Alex Deucher <alexander.deucher@amd.com>
>  >> Sent: Tuesday, July 14, 2026 2:09 AM
>  >> To: amd-gfx@lists.freedesktop.org
>  >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
>  >> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
>  >> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>  >> Subject: [PATCH] drm/amdgpu/userq: properly account for resets
>  >>
>  >> We need to increment the reset counter, force fence completion, and 
> set the
>  >> wedged event when a user queue is reset.
>  >>
>  >> mes_userq_reset_queue() handles this for collateral damage, but the 
> caller needs
>  >> to handle this directly for the original guilty queue.
>  >>
>  >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>  >> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>  >> Cc: Prike Liang <Prike.Liang@amd.com>
>  >> Cc: Sunil Khatri <sunil.khatri@amd.com>
>  >> ---
>  >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>  >>   1 file changed, 6 insertions(+), 1 deletion(-)
>  >>
>  >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>  >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>  >> index 6aa75da27f912..5e1262636e1e9 100644
>  >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>  >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>  >> @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
>  >> work_struct *work)
>  >>                                                         queue, NULL, 
> NULL);
>  >>                else
>  >>                        r = userq_funcs->reset(queue);
>  >> -             if (r)
>  >> +             if (r) {
>  >>                        gpu_reset = true;
>  >> +             } else {
>  >> +                     atomic_inc(&adev->gpu_reset_counter);
>  >> +                     amdgpu_userq_fence_driver_force_completion(queue);
>  >> +                     drm_dev_wedged_event(adev_to_drm(adev),
>  >> DRM_WEDGE_RECOVERY_NONE, NULL);
>  >> +             }
>  >>        } else {
>  >>                gpu_reset = true;
>  >>        }
>  >
>  > After the original queue was reset successfully, it did not update 
> gpu_reset_counter, complete its pending fences, or send the wedged event.
>  > mes_userq_reset_queue() already updates gpu_reset_counter, completes 
> the pending fences, and sends the wedged event for the other affected 
> queues,
>  > but skips the original queue because it has already been reset.
> 
> What is the rationale of sending multiple device wedged events on a per
> queue basis?
> 
> The question of whether drm_dev_wedged_event() should be emitted once 
> per queue or once per overall recovery seems like a broader design 
> discussion.
> 

Along with that, also need to consider if device reset_counter needs to 
be incremented on a per queue basis or based on reset event recovery. It 
could get incremented multiple times inside this - mes_userq_reset_queue.

Thanks,
Lijo

> Thanks,
> Srini
> 
> 
> 

