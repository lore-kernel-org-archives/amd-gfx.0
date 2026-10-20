Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE25606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AJEKI5P2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C55910E0D2;
	Tue, 20 Oct 2026 12:08:59 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4CB10E205
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 12:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1If2XTlIj4Op9XbDpdntMIN0QTLicckBrEufdSWaJ+P994P4SHSvMyDVrJBrp8/37eIwrJGV82s0+FHFOIKrrEN0sWMTalWKqbd4g398DmMz7QvLUiYtYKT4VZo0LfXhothEWeuqOFyOEOLpYX5Ck0A1qMquy2utJLzts78pj1uTd4u8ENlybAKfG0QrSBcW4DGQQ3BHh15qg0tviyNc3kV9BEjc2nuQHE0LdbCDR+vKFd8oFTiTQBZyXeXw9G4mcWCoTqd5Li7xB+qJrPwze88mx4LFeHsA33Au4dw8gJ8VpMGT5wHWB4sr2mZyPWOwVZUGs7uIi4LrHqkYSpesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j50wtNaCLqRI+GBvs5hTRq1/0TsNG7FgwnhK14uECxQ=;
 b=F0OWNYRUwemW0XedLUrHKe4KF/epeShrIVG/ugrrBBdi/+jHAEud/vafnqOIPU9/TtzL9Uh8nO+rVK/x4492nm5JHNNnA8jHlZP+Q8mdIaRgca05T9BOi5l8L3BZE65MmI6H0guDqnkTBtl0B4asxrm//c/kiCjbWOHK3Gk1zbb9CWlFNoBx8xLfnGXsp2sR9SDOaNO995BQi1H6dgsvAjM0dAMpHqd6i1Mz3/UDRk1A4ZrYP5VoQUP6zUyxDInkIciJUodEkmApfmzeBIpNLv9k+gaH9+c/FgaOth7YP0AQ0/LZZSs8tjxX9PLi5OQ6OnYmJApycm3X7t2/lY+Qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j50wtNaCLqRI+GBvs5hTRq1/0TsNG7FgwnhK14uECxQ=;
 b=AJEKI5P2VaUfhzaBgzQ/sqpo6mpWLmFvTxQ7A9WZ4JednKY7LArVGoyh55vhdDuVg4vmHG/vGBDjDsTPCO/tIOqyHknOTgRu+N9mjjnVixt4RDPBXOsSkmtiRYdVc6LluxzJN5A1uwtCG0AIey2rh2cM/pZVUIQmUFsmVhestSw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:08:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:08:51 +0000
Message-ID: <256909c8-6099-4481-8579-f39112bd31ed@amd.com>
Date: Tue, 20 Oct 2026 14:08:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on
 failed probe
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
 <d6a743a1-7268-4167-9378-a364b6c04fbb@igalia.com>
 <e1202a38369202264a735836a2fd6a2de3609a13.camel@mailbox.org>
 <e2777c34-f12c-4861-b7b9-6ae12163864e@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e2777c34-f12c-4861-b7b9-6ae12163864e@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0265.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b343466-a62f-4243-df66-08df2ea2e723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: v9UsJHmc1H81wAlFLKE9UbX0ttrIUMhHP2XUFmwOl6ljMedF+pKlDROtyE2BJ/AjQp3UwQRHW6UeUEc6l5lHPmubPadIhrBccPlgw2nHeNuUIXECrH4fTCqDztT2DLPJx45qbgTyv1gOSFGOYP3S8h7w0rKgIeXbGmoBQ4DtfP6eW5vpgEryzJacHCsCB0Mz+MwuB5iDR6TgSWgUOFERf9O7CM+SkdeZEIKdV9kjT1rga1Le4nlC2mKGykWLqLwJRMzeyYxQVEW4gNb2gUnngCmCuq58lkOV/6y7hkaWSQiRSPsAC8q9kSDThx0lf35goPbtntbzbVjqNE2vCcaEydd8UQeS316UzMEhfikYTsmUtU8WA0k/TQ70DOlWdbF04XRbC2hewiRTICIm1sljLSm+AJVx+lB6gJoGvvGXIYWw5I+kQSNJcOZok7WT7TqAO4pgDAkLj5LLqRIaQO0TKnSIXY01CGKIvRNYbfocSMC+B/3uTujvWj+EFexcZhYjU5xJfW8n6hONc6wv05ZNn7gRrxhlytE8+cd5ag3Bgk/nRmicv+cMHOVvrnpp/2v/4B4M1OJN8LEXqts7TqflhJxOr+akn8lCCPCEgwAHlo7avLpK+0LjvfHdaJTa5y0yTWKoiilPI4kbcNqNBIRTBdcNnUrEJ8FAgk0RqkVXsH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2UxWmlocSt6cll2dWFOTkRrS1QwempwMWZJYzV2TWp6TnJJcmhJVHlQNjlV?=
 =?utf-8?B?T3JBNmVpbE5JQk5tNnoyV0hCbGJkYnRRcjUyZFUvU2ovRnRPSGVYZVVIeWdt?=
 =?utf-8?B?RXZTMlA1bHZoVFJjL2trZkU2dE10MHM4b3Nvek12R3Y1dy9TL3FRK3ZRQWhE?=
 =?utf-8?B?NnhhdXNhalNsb3JVMzRDZUhlUW92aW53ZlF4d1JhL0RnMGpJdUxqbHhKSG5E?=
 =?utf-8?B?eDJSM3NMdEFJdjFJNjZuY2VUdnp2ajduTm5PQVpTSUxjOG5ieGxEVU9Vakl1?=
 =?utf-8?B?YWtqYklsOTlZcGJnZkErdFRqV1BpdjNsR08xZyszVHM5azlGSzBLS2duZnJv?=
 =?utf-8?B?M05FeHAvMGxBb0xtN080T3gzOUVMVnR5dzNVWE5mMEkrTTM0SnFJMVNwdmxq?=
 =?utf-8?B?NWg4TyswYWk2ZTdOWnl3QitTbzkwRnlTUUpUblZhMXpwTkJiVDRyVGNVMmFo?=
 =?utf-8?B?U1lpUHhrRjBPVitjM2RkUGZzV0ZUclNmeHpCS1BuQjlCYytFQmJrczJJRDZP?=
 =?utf-8?B?N3A1cHlPaFBoYmhCa1Ava0ttTjRBUUlIN255T1dXWUdnZjhWOGVPSEwwS2RH?=
 =?utf-8?B?d0FPMWYxaUJHWDFRbmV2SnJEcGFYS2JkSllNendYSk94TkpVZkFlQStvSEc0?=
 =?utf-8?B?d1oySTNSK3N6MzVUU2N3eDlZRFR3ZTZGNjAxL3FmZHhEYkhUTDN0ODdoSWY4?=
 =?utf-8?B?NURRamRUK0pHM09wNW0xWk1Xa0cycy9YU0ZCeC9CNGFrbVA1OUJ5YjZ0N3FI?=
 =?utf-8?B?a2R6bmxVcExpWUpZUTBpQ3NyWExBSS9PZEMvN05JZjB5MkwxYm5nNXJaWnNB?=
 =?utf-8?B?ZU5PaEZzblNwRUVrY0RoV1R2dHM4SU51TUNtNC9mNHBkUFY4SThVRGE2R3JT?=
 =?utf-8?B?bHRhK3JjTjlSY20yZDlsRjliQXZTMlNpbUFXYWd4eEFqTmZmdi9CT1c3aVFh?=
 =?utf-8?B?bmJrVmIzcGVIQ2dLaXhpc1R0NUdRa2VHL0lzQyt0L0NHYXFVQmlONkhWWFBI?=
 =?utf-8?B?STJxMk9sbUx0TzBRV0lDUG1XUi9DU3NhNXpWTVlNenU1TjVrVDFaS1Q0ZHdG?=
 =?utf-8?B?VHBldXN0d1FHaW1abndObTJNS00wWmd1Q1dOUFdsUU8wNjhwMXY2MFJpakI5?=
 =?utf-8?B?T3c1aVIrSE41OFJ3bTcyRWFxaVNRZk9kRVJPWmNNMnFDUXkxd1VZVWtmNlp1?=
 =?utf-8?B?dDd3QWQ0dEVQVFZCMFk1dEdtTWRabjlHakg4U05pOTZYVEFmenBTSDRqNVFo?=
 =?utf-8?B?WS9xMnhPMFdCcWxpZFdnY3dqRStRVEVxYWhTWk5JbHE2bFBRVGtVeXBGZUg5?=
 =?utf-8?B?RkNqT0tJSlRNdGNvbGpVZGRHTlJYcHVoMVRobzhSRTc4SktZaEF0RUgzeENW?=
 =?utf-8?B?MjBueVlMOWV6WkRhUkRKQ05Xb2VTNnNGRitXMjZrVUQ1SHErL3VSUC95WHRT?=
 =?utf-8?B?cU1aLy8zbUZjSnk5a1I3cGNrYXBGVUg1bTlkNmhWMndpZmh5UUhUaENiRUlo?=
 =?utf-8?B?TE9NN1ZOZjBzMVNiTUpINjUrWndqS24wc1ZrMStoTi9GeUJyWjBZLzJxWUVR?=
 =?utf-8?B?K05PcXBCbDF1K2JGcnI0eTloWXNwTDJIbjRrYVZmQkZ0WWljMmJSTGQzeHAr?=
 =?utf-8?B?c2N5UUxzRmpuYWZKakNmWG9XSHV4Q010eFI4NndHTnl2SzE2K1pUM1Y5cTdy?=
 =?utf-8?B?MlVjVVlVWXlXdnE1cUp0ZXp4aXQ0UTh5b0daTzE4VUZUNjV0OHVMeGNVRWwv?=
 =?utf-8?B?Z3BMbWNXbVFTVEZjRk1Ha245YmNaaGRYazNPR21LaGRUdWFhenJRNWxSKzVl?=
 =?utf-8?B?bkxseWFORmNlS2M2cy9lVXVhOXdMdHBUOURSdWlPUFRkUWxMNG1sVmZBWElM?=
 =?utf-8?B?OVlTb3ZoNFpnNG9MVHliUjE4Q0dxMlZLYmVtQkdMRmVyQ2RqSHpXODRuUHd2?=
 =?utf-8?B?Q3pVUmFSOGtMQ1UvdTgyaTVCMytmbGE4N2VoNDYwR3ZMc1U1TmVvOFlDSjRW?=
 =?utf-8?B?SlBrVTRrMktEU1U5eXhRdzROdFBNOXNlYVdsQi80V01ucnNjeWNTTEVIb2JB?=
 =?utf-8?B?QlRSazhzM0NySUtyVjhBQjhpNlFLaXgyRnl3SVZNTFU1TkRFRnpUQy9hdnZt?=
 =?utf-8?B?R0JtTVQyNlljTFlsaytONFVpWWEvT3p3cHQ3SGJpV1dmUUVsR2w2TElYc21V?=
 =?utf-8?B?V0s2SHBWemZLSXBYSVQvYzhZcWZnd2ZSTTYrUC85L1FTVDJWOXdtWDh1ek9X?=
 =?utf-8?B?N2hWVWd0Vk9HWlBkS1EyYXNPSjc5THh2QU82UDA3TVBIQ3ZiKzR0MFhMU3h1?=
 =?utf-8?Q?Ano4YRJ3GMkrfnyCJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b343466-a62f-4243-df66-08df2ea2e723
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:08:50.8762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s887xBD/vitaapNOvu+X5ofSx7OAR0U7Sd78TcL9lU9H9aOz0bc5SbmBXoqnyhpy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 09:03, Tvrtko Ursulin wrote:
> 
> On 20/10/2026 07:47, Philipp Stanner wrote:
>> On Fri, 2026-10-16 at 09:23 +0100, Tvrtko Ursulin wrote:
>>>
>>> On 15/10/2026 20:30, Olivier Kaloudoff wrote:
>>>> The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
>>>> Remove redundant entity->rq initialization and checks") removed the
>>>> if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
>>>> Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
>>>> grounds that entity->rq can never be NULL. That holds only for
>>>> entities that completed drm_sched_entity_init() — not for the
>>>> never-initialized entity this teardown path reaches.
>>
>> […]
>>
>>>>    -    drm_sched_entity_destroy(&adev->uvd.entity);
>>>> +    if (adev->uvd.entity.rq)
>>>> +        drm_sched_entity_destroy(&adev->uvd.entity);
>>>>           for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
>>>>            if (adev->uvd.harvest_config & (1 << j))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>> index 1f7a98cdc..3952af9ae 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>> @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>>>>        if (adev->vce.vcpu_bo == NULL)
>>>>            return 0;
>>>>    -    drm_sched_entity_destroy(&adev->vce.entity);
>>>> +    if (adev->vce.entity.rq)
>>>> +        drm_sched_entity_destroy(&adev->vce.entity);
>>>>           for (i = 0; i < adev->vce.num_rings; i++)
>>>>            amdgpu_ring_fini(&adev->vce.ring[i]);
>>>
>>> Dang, it looks like currently the ownership of entity initialization is
>>> broken between the IP agnostic phase which does the init, and per-IP
>>> phase which tears it down.
>>>
>>> The fix will get in the way of me re-trying to embed the run-queue into
>>> the scheduler but it does look correct.
>>
>> Couldn't the status be tracked through the vce struct?
>>
>> if (vce.entity_initialized)
>>
>> Otherwise you rely on API-internals (again) which is what enabled that
>> bug AFAICS. If it's about amdgpu having called foo_init() or not, then
>> the most robust solution is to track within amdgpu "did I call that
>> function already?" Same applies to all constructors and destructors in
>> the kernel AFAIK.
> 
> Yep, it is such a horrible pattern to rely on being able to call destructors on non-initialized objects. I am looking at some flavour of "track in amdgpu" as priority options. Either by re-arranging the probe steps, or by tracking explicitly.

Yeah the problem goes deeper than the DRM scheduler here.

Normally the sw_fini callback should only be called when the sw_init callback succeeded. Same for the hw_init/hw_fini.

Somehow amdgpu tries to tear down an IP block which was never full initialized in the first place. The scheduler is just the first component where it becomes obvious that something is going wrong here.

So we need to take a step back and ask why sw_fini is called for something that was never initialized *OR* maybe why the DRM scheduler init is somewhere else than the fini.

Regards,
Christian.

> 
>>>
>>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> I will see if I can re-work the init/cleanup phases so this can be
>>> removed, or if not, try to add a proper DRM scheduler API to query the
>>> status of an entity.
>>
>> An API with which you can query whether a data object that you
>> allocated and that you own had the constructor run by yourself? Or am I
>> misunderstanding something?
> 
> Yeah it would be bad. I don't think it will come to it since there is at least one better option.
> 
> Regards,
> 
> Tvrtko
> 

