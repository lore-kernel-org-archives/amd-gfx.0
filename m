Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA99105F78C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 11:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B05A10EB87;
	Fri, 13 Mar 2026 11:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6t3GnIN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EFF10EB87
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 11:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSGfdbmwv1BBbBzL0b5R1VtKGhrN9z7TCJng596RykGSCMRGwtzMbzhM7UBv4HMHuDH8XQimH8Pq9DbmhFg/HxbLXyNthCcZLovHylOoyqpA8TmQDh29qbzYwCc8KwforCM+b4ga7PrMNI2syYnkbSDsL8hn+U0es80WoOhQ8koEqynQ2tPzhCT8Y9PoGPyCvJ5YrVrYJVbVKdgEamlpILsuIYNLzOuLfor0WISS3lwUo2BBAEu2Rbn74I1g6VMlBznx/CKWApZurlb5pGIt/ccvvaoKcgyhAaB/WuwXli8SgFTtriEO49FgjKZc8dnRYDuvUDsLFDil7PbipcT4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQNGRcURJ9DTr8gBxP8lrxynBIa+J1CouFhzE/8xOk4=;
 b=yhWH4RBJejJYfGO9x5c6IweAn0evFhK0KrvE+qh/x01Lkn9KXcquWUgScLhSt2bi1K9QjOGqY+uLjHEioOMO0v6Oxx1hAQF1WNvqhD7OzX4U4nQPbprmWaxrfyrl/8p2dv2Aw/C0OlNUPrFhEMTBIKVyeBilnfT6p/120hrnjvPBDiMe7zNJfA0W8DMI8yCKtwqYwRytq4Rw+58J6nx3mDU0pRl0Ke/GAC/ijAUmBs4Z5Ujt2cAzozxJdOz6CI4zOIPPI837nCAHdA6g3Ahabk5h7sMWGSyknR8yH0meWmfZ//TDhBrmFySrMyFtRPKxMML3hHDw3HgCCb9COJN0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQNGRcURJ9DTr8gBxP8lrxynBIa+J1CouFhzE/8xOk4=;
 b=A6t3GnINKklL9TDwTSC5XT2ahzpCkSj4pEd/xZe9CfeRt/3gV50nqX2ui7d6ZYrjWc7GiacQBRcosyBzBLQOnHjwPgsosWzXnj4sxGS+pSQIBFK/fNRycYYX5KbtMTzPB/Gv1zDeX0nnVYu+kdvMWQIgV1Iixn2KoDjNvOsGDb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 11:55:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 11:55:03 +0000
Message-ID: <cb2aaf02-a537-4268-aba6-e33e32c551f2@amd.com>
Date: Fri, 13 Mar 2026 12:54:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Jesse.Zhang"
 <Jesse.Zhang@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
 <CADnq5_PXhLYs85cU2FZ6ZYtBBtv1wOmwiJL-rDbYsCFXpTL_cw@mail.gmail.com>
 <d1ef0e7f-ff3f-4012-9074-b87425fa2fc2@amd.com>
 <CAAxE2A5qX2e8rzZvSdUUbCvz2AN64=HU49pQptkYodOXiv32_Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A5qX2e8rzZvSdUUbCvz2AN64=HU49pQptkYodOXiv32_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e902bb-6c2e-4091-2e6f-08de80f75cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: LKFYdzMqTrNoRTypGNIV4NgjJ+gBQMdvQbgt7BKac/5RaCpBnhGkg6g8dGRht+xvmvGd/n3Xnx2gT0kJdP0y7A/vlXgPKEk5aAuat0HRxQH7tyntsDxKVkS8UJqP4itYu2tNARqcOC5qDGhDsilgJz127muXw7urH21i1Kr7l2VlrHmaU79G9lrOO7Sfcf4tjIqJsjZWJ9+niB1DTT3O4zmCYbEerNnMy2bmmIIde1dLmcg+Wo0U/ww3krRzbaJiQisgvI44akuyQoHIyvAJnQIq7qUHg4gsBBb15LGADl7K1C7jvnHKSOqjEJDS+xcPjWPF0secY3A+KlmZ7qSg63fXmm8lOzRCMH9rpsJIdBUSqrFzBJIhPaH433uPBIV4KrnV5CAnXBs2w4BYTbi2eX5cfUX64Krg7SV7Od0iqmLKEep4455WLjgdKcdGvsMrJjKqJH/nfmO+73zHSwFkg5SKzIIa8NOHEmdRalEpL5w8Pexp85gwBk+4dKqGPggIXo9a8UFaEg1kDv163F5lDnDDFjKKn+fJzcAKMSPwUuciuP/QWe6m8pEAffSnpz5edg30gSGXTr2f09FXaF3/kAnYX85MpatfTgpAMxpk3H/ZHBFg0y8eK2QXue3Lw/MzdOZ4TZUrL8yBwaS1rs9lFjD9/8P1Y6wVqsWG9QJ90LXVkoaXzdlMBSGCmeSlc96OCK6A1Kib6LicVqYVgoU9PYMD5z1qxhpycM2pB44YyhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2gwUDJjTWlmM1c2OUdOc2tvQldYUG1lL1BIMjMreElMU3p1SDF1MmhqbVNH?=
 =?utf-8?B?TWF0Q1ZZQmFMenYyRzZYZ0pYWURsTDNrVWRlQ0hCTjRudkhhOTNxQWpnbnMv?=
 =?utf-8?B?V3AvdWcvd3hYcVdQNTJVbDVDZ1I3TC9EUy9rNFpLUGM1WURkbTQ4Sys2WmdR?=
 =?utf-8?B?a0VUYTlBbGxaSnJnNnQ0UWh5bk9rZytPdmhEL3dUd0tudUlIUVlGYm5yUFpQ?=
 =?utf-8?B?aUoyR0JKTDdJT3pCT3pjU09xUXlyd01za2ZUQVFVeWUyZ3JIMXV6aFpRZVFt?=
 =?utf-8?B?d3dVNUdzTk1oSDNzenVvaTJmanNJcGl0SHo3MCtmeHVOWXdwWkwvYUIyU2FR?=
 =?utf-8?B?YmExN0x4VHM5RDRPcXg2L3ViaVAxblNiWXROQ3gzWW1VU0pyZENKQzdWYXRE?=
 =?utf-8?B?OUYyNWZmcVd0aHRkZDRPNVNwci8raE1uaCsydnBKOGJvVkJJQWtQN2RBQmtR?=
 =?utf-8?B?U3BQb21QUkVsdmJJSnlFZVdNakh6ekkwcVo0T291OHlscllvM3hBeEhad1g5?=
 =?utf-8?B?Q3htZ3V1c2tOK29BRDFYZG56ZmZsM1pPeVZhYmFpcGEzSWNmWDdlMVVJNFpz?=
 =?utf-8?B?bHZub1pHMGNZaWw5ejhmeUJVTVk4MmFJUE51cVZ6TngyRW9BTjhqRDc5V3kx?=
 =?utf-8?B?QzV2bTZTcThrSktvWkY2RG1abjNzUlFaelJpUExidjhucEV6VEdxQXNQUW5y?=
 =?utf-8?B?YU9jN2ZLRklZWVFMbEFtVlRkUlJvYTBCUk93V080K1ZzZi9ZTURuYSs3QTZo?=
 =?utf-8?B?TGNLSzhIR3Q1SEZtd0F2YVJRcEpiSEJHSkdZUHFYNVhndzR0ZHNVWWpvaGgr?=
 =?utf-8?B?MUhwa1oycmY2YWdWOXhoaUdFMEYvenNPa0JCNk5ITWRleVY1dzY5TkwwaWpI?=
 =?utf-8?B?RUdJaEkrSkNtb3pXNmE3OHRBRjlCQ3RjZGc0b3lDV2dxZm9nMS95MnJIdHpJ?=
 =?utf-8?B?NCtLUENRWGtjamJNd2JHYXp5cmZxS0VscG1FeU9FRUQwejl0ZFJUbUw1ZnBI?=
 =?utf-8?B?N3o4T1dRb05ZMnlrRkZhWFRHdm5WN2JremkzVVdBakx5MnJjVHNLN1ZKRU4y?=
 =?utf-8?B?N01YaUk1L2QxSU9ZeGFGY1RqVjVuVXNmMWExQXplMUVIWUQ1VTY2cllzSlg5?=
 =?utf-8?B?blB3bklnOFVNT2RMVzhXajUwZlcxaGxPS3Zxbm42YWRwUzBsNVl3enlsejFB?=
 =?utf-8?B?RWJMZUVhVitEQVhIRkc1TDlWNjdGQ2dXY21lZ2g5K2N2b04vOGxTRlJlRWdk?=
 =?utf-8?B?MTFUTFljYmtuSmZudFloVHppbGFPZGhYZ2ZXeG9Rc2VVLzRrTkdqOUN0eWQ5?=
 =?utf-8?B?Ni9tVTIyVnpGNnd1WU1uWDNkdW9NbVY4eFNSTFg3ZEljeDlJbDlUenNTNzY1?=
 =?utf-8?B?bjdPOGNoNytDRHp6STJONlozRGRhTG9yWFBzbk4xcm5qdlhjMUZvUWkrRDBK?=
 =?utf-8?B?NEJtRWhUTnpUSk1UbHgxaG5mbE1oUmpBVjRZRnJ0T0grT0dFa3FINHpJQVkr?=
 =?utf-8?B?Q29ISmF2MGlSUFVqZjV1MllINDJFcU5EU1RiOGJSUUFtaVF5Q1JvUXRzd1lR?=
 =?utf-8?B?TXgxbUh2cjRRcktyVG5FKzJHSmRrcEx3ZHFuS1JtUzZUU0htRS9WNm1udlhu?=
 =?utf-8?B?bXBSRXRPR2J2WkI1REJMMUhqS3pKZkdnalJjSGpYRDh5MDdaS0dTWGJGcHRO?=
 =?utf-8?B?UTQ1N0RSUXU2L0kxR285V2J4eFN3TnlFN1NFbHFtUEhBd0J5ampOQjA3VHBE?=
 =?utf-8?B?NkczNlY4WHZkZDJMUWloU3hpTjVnY28wOGlFS3VYZlVGME13VzdjSHZKeHd1?=
 =?utf-8?B?Qjd0b3ZOd1hDZ3dXamtJTFZicWcxcW1QQVV3MVI2d3ZTYTFDVHdwVWhzN09j?=
 =?utf-8?B?eHVkMnowZ2VLNnpNVEFIN01lTHg2R3ZnVndUT2E1WkpTdFpBekNibk9KbWN1?=
 =?utf-8?B?SGRubk02SEgweWkzUG9RTEVUenM2NHU0UFRJMXpFMWQwUXR3OUk1bnROZnA3?=
 =?utf-8?B?WlZDZnpacXI4Tktobm0vU2F0L2Vla3BWMTRrNzlxNFRLdnVGam9GQWZEME5z?=
 =?utf-8?B?dTB0UkRrZjB6K2Q3Q09RUmU3Y0NwTnVKMDRxQmE0bzZCMExpVHhNTUJMZUlM?=
 =?utf-8?B?ZXFGdXdtei8xSGlpWk1uVTNRdXE2azNRTmdrbW1uTkI5SlFIV01mcmxtWlRL?=
 =?utf-8?B?QnBGNTJIaHdBRlRjR1NZY3FaS1pyZnp6bjJ3VWUwMmZiMFpuWkxMQWd2OXlt?=
 =?utf-8?B?WVZSTWlmNTdvRnFZL0NvaFRadjFXRitxK0FKRGNwc2tLTXpieTBCRUlUTWtH?=
 =?utf-8?Q?zxEm8zHs8rwZZIrOZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e902bb-6c2e-4091-2e6f-08de80f75cd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:55:03.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6GjlpMrMZRaWWIjHkjUiue2GPoRLDR2IcQU6WSbJB21kgQjeDd3B3C69v/zfppo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

Yeah that matches my expectations.

And yes we need to make sure not to completely overflow such arrays.

Christian.

On 3/12/26 21:43, Marek Olšák wrote:
> I have just gathered real data on this and the result is surprising.
> Viewperf 13, Viewperf 2020, Unigine benchmarks, and others have been
> used to gather BO list data.
> 
> The maximum number of BOs that has been observed in the CS ioctl for
> radeonsi is 283, even though the actual number of OpenGL BOs can be on
> the order of 50k. That's thanks to the slab allocator in the Mesa
> amdgpu winsys.
> 
> RADV uses VM_ALWAYS_VALID by default currently. radeonsi could also
> start using it if the kernel memory management behaves optimally.
> 
> Old Mesa drivers might use more BOs, especially RADV which doesn't
> have a slab allocator.
> 
> Some limit may also be needed for lists of sync objects in all our
> ioctls and all arrays in general.
> 
> Marek
> 
> On Thu, Mar 12, 2026 at 1:59 PM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 3/12/26 18:44, Alex Deucher wrote:
>>> + Marek,
>>>
>>> This was the feedback from Marek the last time this was brought up:
>>>
>>> "USHRT_MAX seems too low. Traces for workstation apps create 20-30k
>>> BOs, which is not very far from the limit. RADV doesn't suballocate
>>> BOs. Neither GL nor VK has a ilmit on the number of BOs that can be
>>> created. The hypothetical maximum number of BOs that can be allocated
>>> on a GPU with 32GB of addressable memory is 8 million."
>>>
>>> Does 128K sound more reasonable?
>>
>> I think so, yes. Event 64k seems reasonable large to me considering that only BOs which are not per VM need to be in the list.
>>
>> E.g. RADV barely uses this feature as far as I know.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>> On Thu, Mar 12, 2026 at 6:13 AM Jesse.Zhang <Jesse.Zhang@amd.com> wrote:
>>>>
>>>> Userspace can pass an arbitrary number of BO list entries via the
>>>> bo_number field. Although the previous multiplication overflow check
>>>> prevents out-of-bounds allocation, a large number of entries could still
>>>> cause excessive memory allocation (up to potentially gigabytes) and
>>>> unnecessarily long list processing times.
>>>>
>>>> Introduce a hard limit of 128k entries per BO list, which is more than
>>>> sufficient for any realistic use case (e.g., a single list containing all
>>>> buffers in a large scene). This prevents memory exhaustion attacks and
>>>> ensures predictable performance.
>>>>
>>>> Return -EINVAL if the requested entry count exceeds the limit
>>>>
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> index 87ec46c56a6e..3270ea50bdc7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>>> @@ -36,6 +36,7 @@
>>>>
>>>>  #define AMDGPU_BO_LIST_MAX_PRIORITY    32u
>>>>  #define AMDGPU_BO_LIST_NUM_BUCKETS     (AMDGPU_BO_LIST_MAX_PRIORITY + 1)
>>>> +#define AMDGPU_BO_LIST_MAX_ENTRIES     (128 * 1024)
>>>>
>>>>  static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>>>>  {
>>>> @@ -188,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>>>         const uint32_t bo_number = in->bo_number;
>>>>         struct drm_amdgpu_bo_list_entry *info;
>>>>
>>>> +       if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
>>>> +               return -EINVAL;
>>>> +
>>>>         /* copy the handle array from userspace to a kernel buffer */
>>>>         if (likely(info_size == bo_info_size)) {
>>>>                 info = vmemdup_array_user(uptr, bo_number, info_size);
>>>> --
>>>> 2.49.0
>>>>
>>

