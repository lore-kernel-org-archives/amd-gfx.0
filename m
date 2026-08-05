Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA48C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 09:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F0F10E033;
	Wed,  5 Aug 2026 09:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="goZkHhnJ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5098010E033
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 09:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfh32Qs0rIvw3DZGysCWEhc6Uim6NVW/ETYJz+ngTzbG7/Uf3y0ZXzR5mQe/AhCbCuzM8c0DmIdd9OV5YVTaGEc4w71jERoli0rXh+c6Y0aGjO4JzlO9ndWoPnxFYZmD7yj6ykf2PmC7S8CeyQUHbxEdWMi+gt868gBF5tRTGyOJVk+pHigkJva8BtwEv8Ogaj9LJIUJrDnGpUNJ1r96M8+c6m/tiTgjViGmBjJsSOoAOKk1Y7MqJ9tpmiQHP7rtewWHcuygxMx3iz12euCc28xBY/gR6lfgE8dSYNhmt7UBNrlL3qiTIVDTucCYDzPmsBMPw/ei1vcEzK5zLz38zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKb/YIq0E7QizphNKceQDGR60P0i9X2dkr3BtC7mljM=;
 b=vMXHNJ6tPNvf8si4Uq04zDbBJZfFxGFu9M1YLOskiDGbwPt48cU4JhKPWTNKrm6w4knvSFMLvJe3MIvjM/Choso4/BPiSb7qplWGT76IqFLPXtc4fFrgSe2EAM5M/q+f3wuLHC1Cjn36pfXPeQOoe+K1YuzQ7Fe+e+5Vcdiw8Pqa9vU0aUB3cvsZsNAPgcHIfky3Db7cz1LIT9gfnh58GbycOkj+8u5EY7PgmGrmGQHHSZWjfl4MB82gtn7UbgNX569HyTJXVXgoEPtYS45S/CCt0YifloSCucCVUmu1/kpnqkXUdHL4UTXPakp7/YCZbHRC6Eoxy+/kc8Hy6JDOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKb/YIq0E7QizphNKceQDGR60P0i9X2dkr3BtC7mljM=;
 b=goZkHhnJBiso56FEZfa1yQOLDhRW1TSlGjFDOLS0gnT4e8GVwL3OWl4eg8DOk8ajiJFN9Ks2aUGU73KtVqaoIDUg5EKntPOCITPS1hOpx6fRllMxwy6dw6hQGOB9hqRyAiAkC98MraYPK6c3OTcrXrbsTGFLPhANDtaBD7psK+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:31:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 09:31:14 +0000
Message-ID: <411640d9-18b2-4b52-ad4c-c16fa5cbc28e@amd.com>
Date: Wed, 5 Aug 2026 11:31:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260727084238.3396808-1-Jesse.Zhang@amd.com>
 <84e4330b-1ea5-4499-a9a8-672f2a12c70f@amd.com>
 <DM4PR12MB5152FFAFB3DCD06996A45988E3D32@DM4PR12MB5152.namprd12.prod.outlook.com>
 <d8d7a3e2-0515-453f-b995-2e18d8591712@amd.com>
 <DM4PR12MB51522DE97EF4AE3626691031E3D32@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51522DE97EF4AE3626691031E3D32@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: a3af919f-e908-400d-3f85-08def2d44b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 0p4ly2tzeXkMkfzPKSEnk0CeYfWLny08FLjPieMAX7MzEHXl63TJLwjkl6kV9+xsdhQ3mVHKJBLyNn7daZj+z3HbbuYGgIp94/vXO+jlQKhssQ048x0Dp+uBjTvfRPeiR92iCxDZJAr5hXXppAtEUp51OD1oro6FGvo9lW1v5p66cSAM/uHM1GNc7EdijoH06cnSDm5u8v2kTmsC8/qh8C/bEpAh0BdBSi54DyxqLTRYDxv2EpLmSyA9DKHMyuR+RgFuIq5bazvJfBPJmcSHJdHqXeAE0wa495C58Qs6Hi03ZGzHGt88Eu7gxA90jwABW0jJQlht13ZTkH5QtnyRzPVST7qm38FIrlHKy4+OrG2k5uGmLFK7uhY6UkHadyQen9lDsh/ck1EO5ZwvPnqKvPTu9OT2+2Tk+HtzbcIdWdk6pFuQb/W7sXlRSqRZDO3vSHBmEJUQWvwID51+4ffvbiJpt9zyN+P11c91OjCRwLcfi2FkKFV2R30LjzAjr+oo1Zo0WFlVOaI4+KIxDjFNlQ0Fpg2VDmcLB+JhruNnXpr8iXhR/DXqMpcc5/ljyKsLAxf5Zr+3DeeZeU11xJ/zHfw8UUfa0B37a4Oe2F7Na9lOMkjYh2e0dK7QDawIWV9ZKRpMfPkm/1g1wh8VttdoQdRzGFXhIMtGMUQmnbgXvKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmkrUDFwKy9JdG1iSG43WDhtOG44R1phM3ZwaW5idjlvcmVPVThkcTRQeGlB?=
 =?utf-8?B?SHkvWHJXOERrRmNXVTZobEdVcHZIeTNZTnhJcGJoUXhNdGZtdHBkaTJnT1hU?=
 =?utf-8?B?NnU5c3NNVVcweGptTGRDQmRGditsWVEveFlXQ1cydXdUVkZxcW9Vc0RFc0RY?=
 =?utf-8?B?SnNjdlhHQ3B2MzVwTTAvbDJ1WE5uNnhHd05GbmppR2NLcHcyRWlyTWo0OCtF?=
 =?utf-8?B?TEptVFQ2eXY4ejY0UzhaRk82OG1IVmNWZlFYdGRON1c5ejFjeWZjOFpFU0Rr?=
 =?utf-8?B?NDNZVC9CU0l5bi9Mc3kva2tIbUdlZnQ5aTk1ZTRZMXB6RUFiMFZoamdIak5y?=
 =?utf-8?B?UzU5ZHk3d1FTdGRXOHdBUGI2ajR4NmJaWGV1M1ZLS3ZZTFhHRHBjTWoyZ3Jz?=
 =?utf-8?B?eERtbFlBOWNWM0VFZnFMZzEyc2dFbGZ3dHhobVRLelJqci9nT0krckMzVjB5?=
 =?utf-8?B?L2dzZEdBcTRES0k2VjJ0QSszbVZSS0ttWXJkN1VEN204WkM0Mllnck5yam1F?=
 =?utf-8?B?ZmNFUDlxcm9hMzBEaW5sUzhFQ29xUm9jbWJYNkZheHUxdmlva2srSnZjb0RY?=
 =?utf-8?B?ajRFRU1uSUM2RlQwZGZRL1NURlpZajhUYk5iVzkzQ1V2WVhpaCtCRGF4Z1FP?=
 =?utf-8?B?bzRaY3RXcUt1OTgxa0J1SWI3K1BpVFZCRFVOTmdpOVFPOG1oRzFZZ1NkRDB5?=
 =?utf-8?B?RXY0bUwwTVlGbHRjM3JMK2srMlVIZjVoOEI0cmYxcnNYTHdjZG9YZjNGYXM3?=
 =?utf-8?B?QXZ2a0JxUkdyQ3UyWUM2MC8wVWNsWkZBT2lWMUFNYjAvd2xHck12M0pZM2U1?=
 =?utf-8?B?ZjlLQ0pqWnpnWnVpVUtFZUJqcE9MMWU2c0cyYnZTa25xNFJkd2VIdjBmZnNN?=
 =?utf-8?B?NEZLQStSbW1kV2dCL2M0SjhkV1pWdll4ZFNPbTZaRDN4eHhvRXB3WUN6MDhL?=
 =?utf-8?B?aUhNU3dmZWtGai9QM0h5Z2RjdEhWRjd2QnZuV1B1NVlFUlEwV0ZmUHFDOFZ1?=
 =?utf-8?B?R1Q2eXY3a3p5VHE1bzhxb1ZZYUFpLyt4d1FxanV4TmhyZXFLRUwzamFiajc4?=
 =?utf-8?B?ZjIzcFd5VkI4WGxqYVhOKzFEVDdldGpNWWdJOFZxWDlUT1pxL24zZUtQOHlF?=
 =?utf-8?B?TU9uYWhUd0VsaTRDeERzUTBBK0hlZnl5amh1YVZUYTN0Mk40Y2wrSXlWbWty?=
 =?utf-8?B?T0ZLNzhLT05XSUxzZHZLemtjNlFKRk92aDYxbDIxSyt1M0ZjK2ZLWXViZGg1?=
 =?utf-8?B?VFd4UFNndTZlbmRPMUJmNWw4M1BaeTRPYVFRS0VUeDl1SWt6Y0ZnakJ4Mnha?=
 =?utf-8?B?MThPMzN4ZG1tb1VWM1g4SVJJSVI0RUYwMlVXdUJoUXJMclZMelU0UzJNbnQ5?=
 =?utf-8?B?UzBJTExOdkpScUE5Y01WbXFyVUxRcUxJdWdZc1pxRktmRUQ1TnNjc0ZwNTJn?=
 =?utf-8?B?WVRaeGZrOHNsaEQ0UVliaU1tTVhScTJyTHUvWEtpNXRNNjhNZW1Od2hERnBu?=
 =?utf-8?B?dUtqUG85WWw2VDBJazV5K0hzQ3hNWnNXSFpVSnZBczk4eWI2YXF4L2c5MDQ1?=
 =?utf-8?B?N0F5eXBzNU4rbldQRXlIeHhKM29tR3o1ZU5Xb3lVK05yUVpzUHRzc2NlaCtU?=
 =?utf-8?B?b2Q5aVVTVDF0a3pMYUQ4NHd2S2k1L2VnYlJ2Um9Yb01Zb2V3RVFYeVhmeE1O?=
 =?utf-8?B?WXM0SWxzb1Q4Y2FYRC93R3pYclBXdVBNZnpXeVA1b3l4WXg1UEhZZkE3akZo?=
 =?utf-8?B?T1BhS29pU3VzSUNvTjhBalpRV0UwR0wzQ21acFBvc3JkaWpGZGFTdXhHcm1B?=
 =?utf-8?B?NUJ4UEhGaG5KNFNCTEVSc1dQaEpBSmplbUgyVkh1cjdpdVNSbDlNcXRFeTBn?=
 =?utf-8?B?U3hhUWd5cVRZYi93aG5ZejdDZ2diYU1XMVVpczZsL1RycTRaaFBYbWRQV0kw?=
 =?utf-8?B?bG1iY00zSDZ1TjRqMnRpMUdIZS9ST2hzRkVVc2RvYUVNZWNpTlNlZHBLY3dt?=
 =?utf-8?B?Sk9jL0ZWS2xndHlRTllHbE5FOGpKWkd6c1AyUTlCSi9UZ1oyTU9FempWRGhR?=
 =?utf-8?B?Ylp2dVpqY0VaQjJhZVhFK01WcHRnRm5uZDQ5K2xabmZCZ1AyNG5XOHNEQjNB?=
 =?utf-8?B?a0RZSXJZVUI0YWh6dVlKUUswUkJYVERwL3RNWVkwNFBKUjlmUmc1dHEvYnFP?=
 =?utf-8?B?MWQzcjZlbnl2ZHNaUlcxN2ZuUGJzeXk5cjh0bUtBL0NkY3hYdHV4OEprOVQ4?=
 =?utf-8?B?VVFGYVZ5MnpiT0pQQ0tnUWt4NWM2ZXVIdDZQdHgzL0xQeldyMDVFQVpyUnZU?=
 =?utf-8?Q?cCpUtmrn2OCk/zDSBu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3af919f-e908-400d-3f85-08def2d44b21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:31:14.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IF+zn18/ttPL/+I6tZdxNYNs+sYUyI6oiy0j3aKWCN8WC8fOgyvw2CfG9O2Tzg5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

On 8/5/26 11:01, Zhang, Jesse(Jie) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, August 5, 2026 3:53 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer deref in
>> amdgpu_vm_handle_moved for BO-less mappings
>>
>> On 8/5/26 05:00, Zhang, Jesse(Jie) wrote:
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Tuesday, August 4, 2026 9:58 PM
>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer deref in
>>>> amdgpu_vm_handle_moved for BO-less mappings
>>>>
>>>> On 7/27/26 10:40, Jesse Zhang wrote:
>>>>> The individual.needs_update loop in amdgpu_vm_handle_moved()
>>>>> unconditionally dereferenced bo_va->base.bo (to read its reservation
>>>>> object, ttm_tt and to test for a DMABuf import). However
>>>>> bo_va->base.bo can legitimately be NULL for PRT/sparse mappings -
>>>>> amdgpu_vm_bo_update() already handles a NULL bo via its "else if
>>>>> (!bo)" PRT path. When such a bo_va reaches the moved list (e.g. the
>>>>> userq eviction restore worker running amdgpu_vm_handle_moved() while
>>>>> a user
>>>> queue is being torn down during a GPU reset), the NULL deref crashes the
>> kernel:
>>>>>
>>>>>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>>>>>   #PF: supervisor read access in kernel mode
>>>>>   Oops: 0000 [#1] SMP NOPTI
>>>>>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>>>>>   RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
>>>>>   Call Trace:
>>>>>    <TASK>
>>>>>    amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
>>>>>    amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
>>>>>    process_scheduled_works+0xa6/0x460
>>>>>    worker_thread+0x13c/0x290
>>>>>    kthread+0xfb/0x140
>>>>>    ret_from_fork+0x1b6/0x2b0
>>>>>    ret_from_fork_asm+0x1a/0x30
>>>>>    </TASK>
>>>>>
>>>>> The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) == 0
>>>>> and
>>>>> CR2 == 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.
>>>>>
>>>>> Guard the BO-less case: skip the reservation dance and the
>>>>> DMABuf-import check when bo is NULL, and let amdgpu_vm_bo_update()
>>>>> take
>>>> its existing PRT path.
>>>>
>>>> Clear NAK. PRT mappings should *never* be on the moved list in the first place.
>>> Thanks for the review.
>>> I tracked the issue to the state-machine path: amdgpu_vm_bo_update()
>>> can put a NULL-bo bo_va onto individual.idle via amdgpu_vm_bo_idle(),
>>> and then
>>> amdgpu_vm_bo_reset_state_machine() promotes it to individual.needs_update
>> after a VM generation reset.
>>
>> Something is seriously wrong here. I've fixed
>> amdgpu_vm_bo_reset_state_machine() to not do that weeks ago.
>>
>> Where do you see that issue? On some release branch?
> Hi Christian,
> 
> Thanks — I found the fix you mean: 989bdec8ca04 ("drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine", 2026-05-22)。 It's already in amd-staging-drm-next.
> 
> But that commit addresses a different problem: it replaces the list_splice in reset_state_machine() so the root PD gets its special handling and the moved flag is set correctly.
> It does not touch the NULL-bo case — after it, an entry on individual.idle is still list_move'd onto individual.needs_update.
> 
> The crash I'm reporting has a different root cause: a PRT/sparse mapping's bo_va has base.bo == NULL (fpriv->prt_va, created via amdgpu_vm_bo_add(vm, NULL)).
> The tail of amdgpu_vm_bo_update() unconditionally calls amdgpu_vm_bo_idle() in the !always_valid else branch, putting that NULL-bo bo_va onto individual.idle.
> After a GPU reset reset_state_machine() promotes it to individual.needs_update, and amdgpu_vm_handle_moved() then dereferences bo_va->base.bo unconditionally.
> 
> I can still reproduce this on the latest amd-staging-drm-next (HEAD includes 989bdec8ca04).
> the log:
> [ 3107.632098] RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
> [ 3107.632469] Code: e8 5b c7 f9 ee 49 8b 84 24 60 02 00 00 48 3b 45 b8 0f 84 45 ff ff ff 4d 8b ac 24 60 02 00 00 4c 89 ff 49 8b 55 f0 4d 8d 75 e8 <48> 8b 82 58 01 00 00 48 89 55 c8 48 89 45 d0 e8 92 c0 f9 ee 0f b6
> [ 3107.632478] RSP: 0018:ffffcda785f23cb0 EFLAGS: 00010283
> [ 3107.632484] RAX: ffff8ad9cc15fe98 RBX: ffff8ada86100000 RCX: ffff8ad9cf4a8188
> [ 3107.632488] RDX: 0000000000000000 RSI: 000000000000000f RDI: ffff8adab01c0248
> [ 3107.632493] RBP: ffffcda785f23d00 R08: 0000000000000000 R09: 0000000000000004
> [ 3107.632497] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8adab01c0000
> [ 3107.632501] R13: ffff8ad9cc15fe98 R14: ffff8ad9cc15fe80 R15: ffff8adab01c0248
> [ 3107.632505] FS:  0000000000000000(0000) GS:ffff8add3c8ff000(0000) knlGS:0000000000000000
> [ 3107.632510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3107.632515] CR2: 0000000000000158 CR3: 0000000117903000 CR4: 0000000000750ef0
> [ 3107.632520] PKRU: 55555554
> [ 3107.632523] Call Trace:
> [ 3107.632527]  <TASK>
> [ 3107.632533]  amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
> [ 3107.632846]  amdgpu_userq_restore_worker+0xa6/0x180 [amdgpu]
> [ 3107.633036]  process_scheduled_works+0xa6/0x460
> [ 3107.633042]  worker_thread+0x13c/0x290
> [ 3107.633045]  kthread+0xfb/0x140
> [ 3107.633048]  ? __pfx_worker_thread+0x10/0x10
> [ 3107.633050]  ? __pfx_kthread+0x10/0x10
> [ 3107.633053]  ret_from_fork+0x1b6/0x2b0
> [ 3107.633056]  ? __pfx_kthread+0x10/0x10
> [ 3107.633058]  ret_from_fork_asm+0x1a/0x30

There is still something going wrong here.

The PRT should be updated in the PTEs separately, otherwise we use the wrong fence to sync it.

There should be something like this in the userq validation code as well:

        r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
        if (r) 
                return r;
        
        r = amdgpu_sync_fence(&p->sync, fpriv->prt_va->last_pt_update,
                              GFP_KERNEL);
...

Similar to how we have it in the CS code.

Regards,
Christian.

> 
> 
> So this is a distinct issue from 989bdec8ca04.
> My v2 keeps the PRT bo_va off the state lists at the producer side (amdgpu_vm_bo_update: else → else if (bo)), which is what your earlier feedback asked for.
> 
> Thanks,
> Jesse
>>
>> Regards,
>> Christian.
>>
>>>
>>> I’ll send v2 that fixes this at the producer side by keeping NULL-bo
>>> (PRT) mappings off the vm_bo state lists, and I’ll drop the
>>> consumer-side NULL guard from v1.
>>>
>>> Thanks,
>>> Jesse
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index aac8ace9d7a6..fbb76c32bff9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct
>>>> amdgpu_device *adev,
>>>>>             bo_va = list_first_entry(&vm->individual.needs_update,
>>>>>                                      typeof(*bo_va), base.vm_status);
>>>>>             bo = bo_va->base.bo;
>>>>> -           resv = bo->tbo.base.resv;
>>>>> +           resv = bo ? bo->tbo.base.resv : NULL;
>>>>>             spin_unlock(&vm->individual_lock);
>>>>>
>>>>> +           /* PRT/sparse mappings have no BO to reserve; just update the
>>>>> +            * page tables (amdgpu_vm_bo_update() handles a NULL bo).
>>>>> +            */
>>>>> +           if (!bo) {
>>>>> +                   clear = false;
>>>>> +                   unlock = false;
>>>>>             /* Try to reserve the BO to avoid clearing its ptes */
>>>>> -           if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)
>>>> &&
>>>>> +           } else if (!adev->debug_vm &&
>>>>> +!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
>>>>>                 dma_resv_trylock(resv)) {
>>>>>                     clear = false;
>>>>>                     unlock = true;
>>>>> @@ -1659,7 +1665,7 @@ int amdgpu_vm_handle_moved(struct
>>>>> amdgpu_device
>>>> *adev,
>>>>>             /* Remember evicted DMABuf imports in compute VMs for later
>>>>>              * validation
>>>>>              */
>>>>> -           if (vm->is_compute_context &&
>>>>> +           if (bo && vm->is_compute_context &&
>>>>>                 drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>>>>>                 (!bo_va->base.bo->tbo.resource ||
>>>>>                  bo_va->base.bo->tbo.resource->mem_type ==
>>>> TTM_PL_SYSTEM))
>>>
> 

