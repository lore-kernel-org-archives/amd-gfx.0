Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F0606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lpmCguqa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DFE10EC20;
	Mon, 26 Oct 2026 08:22:14 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A5B10EC20
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 08:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSjf+WFfoHGrGmeBTXeqAcTVktdrFD7FID7dH19WFeTczZIB8KM+5+NhZsI7e1KynxesG/JySYAS/xY5ypZat4z0pFYAZkByovpmcoDVY2XfObRk6aXDkQkGDqP+xXh9SOq448SzI+B6htKY/zR7m6JTXWK5gcS+mAJovYA5rBmCHUo84B6lnYII3dCVTnMaeTgmcNlIboN3KcKJXpLBwRvkwxI8jgEWnbZ2Zm8mBGlZo7hJV/dBp/7p/j2BzcLJz7Fw8TpTEmy4oqWEBvZkUcdU7H02wSs9Ewt4Nm2ICG9oJN4/m85y4h8qafRCDOBnHDrmWVU2001IKr2pZgjvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpmeQ78j0IekglspeLHtxcBNNacjqKTgEikcY9Z9v8o=;
 b=v7ynG7V6ejVdxYJ/cnEk1fWJPrGEwzd462pCRrt9+iw+NiEe0folnQDDE6JtwdGXeJFdKVgpHOnWHAZnWNCKwL/BbkSjoso+1xPTRlGBDvyTqYg7LDCGQsrWnTqyX5AfIO/Zic0E1fhVTOysM4tuDW2oKvyfdRbtTWXttDNzpIOXg/QDQGZ4fPwKJqWxr8XwAtbnvjjgKLiSLwJ+hSsgaficrPOPWgwrPLRpOCGOexY2xd2iuvTr2kc1AAajxBAC9EQo5LkdEbKaCYGp5gEP5rWeunkCz+TIlNXwzOGMWQRmkn5wtx15iHdKe1zLZPwmqNVpPkq1YdLrApEd8k9gJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpmeQ78j0IekglspeLHtxcBNNacjqKTgEikcY9Z9v8o=;
 b=lpmCguqa3xUSL4QtEEf2p8G3LXc1AyefCcdE5pQ8sU1fCPmdHz/6W870fn5j2ls++Fk0CDuthDBExTt/+lqtqbgXyJxV0FO/7c7PIHJGxGCHdGQ4AkufNtZCBkPgr/sWaXxNhR8VbWZ5e9/FTheTnOCrvds/MGgndo1Ibts4FHM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PR12MB004700.namprd12.prod.outlook.com (2603:10b6:8:47c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:22:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 08:22:04 +0000
Message-ID: <9c4f99bf-4bb4-4c31-9571-31f2aa57da38@amd.com>
Date: Mon, 26 Oct 2026 09:22:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philipp Stanner <phasta@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PR12MB004700:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1e619a-3a73-4f71-97c9-08df333a37c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022105027099003|261021135927099003|261022075727099003|261022115727099003|261021121427099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: nAKi/2NeMqOX/zvJgIdwBtdkxFjbJjQvRRp1AkL1Mfi3bMrvfArv4E2V84tQT5cWTkm4Iebt/DOy76/eu73lYR1+xLqTfBfXQLbroyWoW7MV1Tf0spVulisDz+HrC04pxQkhH5sHUR4SZ9gm6NXfzMPb3qTaMNaSRNO+S0JaMF/HAgy3VZl+jBGlGWgEJlR3qtSMFqVaXNwA5VNuchQcDmW6pBM+IC0Iv+3U3eIBxkcyMK9tYocJcbfI3nN4+QUaA5niYfhXw9kKY2b6HhEcW3mNjYH0DjWwlbb6D1LXfme9opPZbZPuQj1+H0R5YaSGdjx3qCDh+Xt+1yfF0YETnYQ0DOrci2J29kUue9jqFJrTA12ztMdeuSBN0GMXrivOxOOgsSGUTCPbGUxKpp9/l/FKxjVhiy9je3qGByUJ6lNMNaU0ALFJY6Rp6wOc8yshTQWkpeDEST5R2FJjJKt+uENQoq2NwuiQMCEO5c3XdNS4rBGHEe6cjhm7umeK1QEaNpyqvEUcp7Kfc53gDL6iQ7CsmGPsIWswFZC4/+gJZA8dKWAxxagHpej0jA17oh1qjoSye5MxztsiVcd6uxEL2cpTHfNUZ4Akl8h0qj3dhPCHIyuz7BmFQeDpdetTyRwK4g84tw6iA5DgfcuAi3+ylDG8l7ZSQ195WIG02bSii0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261021135927099003)(261022075727099003)(261022115727099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVA1TERkYmgwM09PajFXOVQ1V1dKbE8yMnE5bzBuRXNheTlmQkNzdTRubmdw?=
 =?utf-8?B?RzhhNERtUmVEZEpNN0lqcVMycXZMUVhYVVh1QmVwM1YxRWNwMkJ0OHJXeFI2?=
 =?utf-8?B?MEdieGxmQUpjeVM5U3RMVXlSVHpFdU9uYVlIU1IrbnlTczhsUzVKcEdLWTlT?=
 =?utf-8?B?OU5LN2lmL2kvZSs3a0syNFdOakNQbHdiakhOblZBVDNBdnNOcHEzcGpTUFBq?=
 =?utf-8?B?OElMa2RaNm9rMTYyTHppQk4xYWYwa2tJQ1poZTRTb0FuTEJXS0oxVWE4bks1?=
 =?utf-8?B?cVc4ZXVCZ3pQSVFocU5FTjMvV3ZmTDc1VjJpaVRqZTVHdzcwWXRYd2s1dUU4?=
 =?utf-8?B?cE5SZnNybzRESHJtWS80NVFYb3N6TjB1NnRUNUQ4bHhHV1dnOGdOcXNqSU13?=
 =?utf-8?B?eUFUM2laT1lkbytQZEFqMDBhTW02MHhrMmZXcVlvWTdvdzVCdCtndU5kNjRo?=
 =?utf-8?B?bmFRRVhnSVhDZWN4ZnZMUkhpdFVQd1dKN0I5eS8rZnBrWnNGM3FrS2JmQ3FD?=
 =?utf-8?B?Qytha2ZjRkRzbUtpaGh3VGhyNEpidk1Iamw5K3JCWDZLaml1L2RTSjhDRmty?=
 =?utf-8?B?RFczSVBRZ01zMW4zQnMxTkxOOFFMazVZc1ZVM0kzZFNYVVFoSHJyLzh2V2E3?=
 =?utf-8?B?UlkrQkhtTFQ2VTRCaHgrcXh1LzNiUnlvSlpSZGNxSEVGTE5jVk94L0JyUlNG?=
 =?utf-8?B?TEdyZXdlNFllYmpKQWprZFZCdVhWU0lhZjk5SmpyZERBQXBnV0VQU1BwWGhK?=
 =?utf-8?B?TjBvNG9KS0lxSzd1c0VYL0ZNbUpwT3RKaG9UVmh4UEF4STF4NjVCUjB2YWQz?=
 =?utf-8?B?ZEp3WExjNHYyckcwOHl0a1FXN0F2TkVRSk9jT1BsTDUza0xidVIvTGJWb2lE?=
 =?utf-8?B?dXlWMnozekJWeG43aDBsS1k3SkN1WmFKQi9UYVVNVUQ0YjIwZnd3ZVNOOUJW?=
 =?utf-8?B?bldHalA0ZGtsem80T014N1pzQXZCOTMwMWVCZ245U0VJT2NoWUY2anNZVUJD?=
 =?utf-8?B?US90WU0yay84TmVBRC9xREVsWm5pdFVqajh6elo2N0MxTkgxditOZmlaSWQ5?=
 =?utf-8?B?OFNJaHJUOEtIamFjVFo4RzhWZ2p6UmI5aDRkclVBNS9ad21WMGtJem5HN1A4?=
 =?utf-8?B?QVVadG1sTDRsbW8vaEZOaDZTbXdkTGlTUm1lczk2aHU2RHlsWXZsNTdOaExr?=
 =?utf-8?B?ZTFEcXR0MERmcjhWS3pIL3JEaWJEV0NpVlhjSzl3TzVFNmxVK05CTXV6Yk9v?=
 =?utf-8?B?Yk11QUFnOGlvQVJudm1NVko2dHdIbHFrbEJscnJxeWpIc1dVUDIxVzNoVFJ3?=
 =?utf-8?B?RFFiR1RiUUNRWjh1RmY3L2lZR05XVXJzc25LeXdicHlFYVNtZGtPN0V2Wmo2?=
 =?utf-8?B?RE55R2lDWlFFb0hOdEVjK29lZGJ0Tmw5TGcvYnowT1lhZUs2VWo1UUxkMFJi?=
 =?utf-8?B?Zk1wN3JEY0g4Qm5PMlJzOWkwNXY4clh0U0E4aW1iRk9WVlk4V2tVN3RUa0p4?=
 =?utf-8?B?UXRCa0NITDQva0VWNnhrZ3gvQ1VGNGYrWjRFOUlsK2luYXNGUWhnNWUxTWVP?=
 =?utf-8?B?SzgwZ0tid1dUUzFRY2VLWG5PYnk1UVNzQjNkUVgvZCtwMzZXTVFNSFVMQVpq?=
 =?utf-8?B?WFdUY3hNMlVGZmlKd0tBc05xTmpuMkRZdWhSZXNObDB4N0lnSUJoSnlxVUhy?=
 =?utf-8?B?T0dGeVpPaTZYdkJFQmU3SURqNUp6alNaa1JZRUgrdlZhVnZ4enRwdk5tTTBJ?=
 =?utf-8?B?YmpDeFJZVnZNTXNTVVhtSWJCRHFjQTQvSXNEMWgxblZjQmFidWlkZjlUTHhL?=
 =?utf-8?B?Z3BYZmFOeS9mNzd3OFY3T2N5V1M4V2tacm9FK0YvZmJaRm9QVjM4TkJZdDhl?=
 =?utf-8?B?eXVsMm5BeEZYMjQyQ295eU5SdXE4Tnc1OWttWG5LaEIrVTNLWkdnRU1BRjFX?=
 =?utf-8?B?bUJzK0lNOGFyMUNnTUpOcStQRWN4S3M0UnN2eFV0ajBtZi9NQjQ4cTJVdzll?=
 =?utf-8?B?VXZPRkJvT2tPeW84Y2ZwKzBqNml4c0FUN01ucWgxUGxUbVN6NzlhZWhEUXVQ?=
 =?utf-8?B?UUE0c085ekpHVEdLSGNFQmZnbmZ2RDUxcDhXWndTdXNkMUticnNhYnpDWGJG?=
 =?utf-8?B?TTB0SXRHOXJwL3BrUFdWM2k0d2lXdlZ2aDM0N3Awb25PR2VrL0NzS1A1dUNm?=
 =?utf-8?B?cFBES0dqN2pQVmc1czRiNDZXNVB5RUZDV0tQZkxCZ0F4WkhhajkwMlgxUVBs?=
 =?utf-8?B?L2doTE1EZXBVRHBsVmlKaVhGMDMyUEY5VklpM0JObThKNzEySWFGb1NqdUxF?=
 =?utf-8?Q?WoKMnXTPRcv8sLe+9s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1e619a-3a73-4f71-97c9-08df333a37c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:22:04.8008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p5Z5lTpQLPKyhGflFf9cKU428bLQHG/Uf1doR35aaIKtdHljts8rdglg3D7Q5tV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB004700
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Olivier,

adding Philip and Danilo as DRM scheduler maintainers, just FYI on the technical background.

On 10/22/26 12:54, Olivier Kaloudoff wrote:
> Hi Christian,
> 
>> No, what we need to avoid killing the entity while KFD is still
>> using it!
>>
>> That is basically an use after free what you have here, only that
>> the drm_sched can point that out with a warning instead of
>> crashing immediately.
> 
> The exact "use" we hit is the dying process's own exit fault:
> SIGBUS -> coredump -> get_dump_page -> do_swap_page ->
> svm_migrate_to_ram() submits the migration job on the process's own
> entity after drm_sched_entity_kill() already ran for it.

Well, thanks for confirming my worst fear :) That is exactly what I expected and it is essentially unfixable.
> I think we actually need two complementary things rather than a
> choice between them:
> 
> b) The scheduler-level guarantee: a job pushed to an entity must
>    have its fence complete.

Approaches like those were rejected many times before, but just for the record: Big *NAK* to any hacks with the dma_fence signaling, especially in this particular case here it will definitely cause data corruption.

> drm_sched_rq_add_entity() returning NULL
>    for a stopped entity leaves the pushed job stranded on the spsc
>    queue forever — that window exists independently of who killed
>    the entity when. My patch closes it atomically under
>    entity->lock: either the entity is live and the job queues
>    normally, or it is stopped and the job goes through
>    kill_jobs_work so its fence completes with -ESRCH. This is a
>    generic scheduler invariant, not a KFD workaround, and it is the
>    only fix demonstrated to prevent the fence-orphan hang.
> 
>    It is also required on surprise removal even with perfect entity
>    lifetime ordering: a job can be pushed while the entity is still
>    live, then the device disappears before the job completes. Fences
>    must still signal — which is exactly your "fences *must* always
>    signal" requirement.

That plan is clearly not going to fly.

The problem is caused by a hotplug while memory is still migrated to the device. In other words svm_migrate_to_ram() tries to pull back the data from a device which is gone.

So the data is gone as well and if that is some memory mapping of a file it is perfectly possible that it is also written back to a storage device when the dma_fence signals.

This is similar to ripping out DRAM while it is still in use, the best thing you can do here to avoid further damage is to call panic().

> a) The KFD-side lifetime ordering you want: don't kill the entity
>    while KFD can still submit. Worth doing, but the boundary is hard
>    to place — the submitter is the dying task's own mm fault path
>    (coredump -> do_swap_page), not a KFD-controlled context, and the
>    "mm can no longer fault on SVM ranges" point is earlier than
>    exit_mmap and not obviously under KFD's teardown control.

Well that is not this much of a problem with the fences, but even that wouldn't help.

This is unfixable. You are running into unavoidable data corruption because of the SVM handling.

The only way you can avoid that is to make SVM and hotplug mutual exclusive.

Regards,
Christian.

> 
> So my question: is there an existing KFD ordering point that
> guarantees no further SVM migration submission for a process's mm —
> for example after MMU-notifier release but before entity kill? If
> there is, I'll implement (a) there. If not, I'd like to land (b) as
> the scheduler-level guarantee, and then evaluate whether an
> additional KFD lifetime ordering is feasible on top.
> 
>> drm_dev_unplug() *must* be blocked until all fences are signaled.
> 
> Agreed — the drm_dev_enter/exit submit guard and the unbounded wait
> stay, and copy_done now propagates dma_fence_error() so a failed
> copy can never complete as a successful migration.
> 
> Regards,
>   Olivier

