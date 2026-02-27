Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019F5FEFB41
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 12:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8483B10EB21;
	Fri, 27 Feb 2026 12:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OnCzFY58";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5CF10EB21
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 12:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYTZNYR2+zEhWRmfgqOTO6+hiwwaUsYvqbxOCiYzxFVXvnQnfWdlZ5vdhmRGU6dLie7CaJ/+/ErMDGJwjM98OY6FgLkyZ9uHTC0raOC+xMY+pVp6QON3TwsHU97MokHVi6aFfvlU7bTjb0tjTIzFinSx6O3RhCXx6nFPBUeALc996D+qWG3N2d+2LGj0tjrfZ7KY7lz1J75hr1mNIkHkM7mq7xtnvkaTlniZsUaS22dbmN+rNK+lhUWjz4v6Z0Im3hEDHVy9gUU4j7D7tEiBczcSY4qEtG6On2BXPLDaSThRQ7HnutLWMiya2f2VhfPSkTC7o39vMrC6L5j0D3rawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD9j7IG52Kh2BOXPSRYEHLarV90vp8MYPrrJB/tcbeg=;
 b=BWgOiukZap24QolFRNdXGYAqpJ30mj68xGn6a5VE4ZIH7RddNT3SgYaPTsFsfgOJp8Oix6rW6ifMLVP4w2dXOdFuIq+jEB/3nDQpfgvCS0fRWGqVqlc12E0BtrL4atn9CISE63Hgb0LZJWWEzg2+xvMUPiP786RJ7cuTygKdJypxtL9+PM+e3yC3a4lxblQL3QPLNQIPG1BFpLBtOarXXgETM/H/RZXN282xEkzjfS0l9PLVsZdkI/vbk0R8743zdh75XlA+wbCNZo4rRTObUELYUPrLaguMHESs5F6USt6nGJ+4Z7AfqUYuaHOw0jCPjTMnMJNCCoBuX6moH1UpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD9j7IG52Kh2BOXPSRYEHLarV90vp8MYPrrJB/tcbeg=;
 b=OnCzFY58SP4idS49KSILmT95FVUy49QNpXzBpLM692xRxOGjy++qMnhKfAnm+9SR5Bz9iQPAbJzhL0+loz0yhpwcvLfcHQIMN+ZM9i6ekCvR46q1Gm0tC/AXBy6SPe5BIkPNOQqBHqPCOtXrJBtRhGOh21QpTIj7JnDUGcOwtiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 12:12:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 12:12:11 +0000
Message-ID: <1b52d686-5083-439d-a8d5-518d6683e0f5@amd.com>
Date: Fri, 27 Feb 2026 13:12:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update type for num_syncobj_handles in
 drm_amdgpu_userq_signal
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260226155146.3727191-1-sunil.khatri@amd.com>
 <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
 <490f80ef-6614-4ba3-8183-fbca7698f8da@mailbox.org>
 <6e1ec357-6858-48ae-9447-e915fc946417@amd.com>
 <41773dd1-0929-4c5e-9c67-07262ee299b2@amd.com>
 <ae213ed7-ba5e-4e9b-81ac-95e20abd8b1d@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ae213ed7-ba5e-4e9b-81ac-95e20abd8b1d@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d97f20-28bd-4fb2-087e-08de75f96f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: KokDoUzmLs6HUV4Fwf7dcAwqXK4UIVtDZaptKqlYJuFRnNi5HSSahVjyz902EVVbWIe2MzAqN30VZVgWu2LTCatm6CRRnM1Tf3ItyI00/phDoKEhTM2hyxq1PSQuS/EEDOrC+h8R1XdbLG8+cBkXNg+CTpE6my75sDWrI9PfCO3XLarNF1LvOZGacfI0jCbLX1Gu4o4gUO5vp27CRdAJtx2xuXTCZqXwVtF1gAQTjoDpmOOxkIa2HTIHEFbYBSU1JzgMSdRwcRIUeQQfNAUQTvM/anu+YcYyf+LX/5ItVg4jPUDe8DFPrgv0XQLHi0u6pah5CWFoUdtVrcyOS1GpF5N2EpNB9jotXVnGWlPlwxw1k3BZGixKoqo0f0xDxbYQy+hed8cTONJushdIuaQ/i13giAlZ8pj5fmgiktfGJvCsdm7kokIe28SlP8l+qJr5ggHUVU/VPQ7Z2D8fnP2Zk1v1O49DHTAglq4HfLWL4hHLQpOwenhmMb3oDdQyfHZag92cbI80jgXokLzrEhW9V3+Q9pKahCVKkg5CRq/IFRh8Le6/OmcLWi05AKT+ev+zLQI/iQxwfhFCtEX07SebdzFuNXj7QJGMluZBHMrecPKwk7L8YQDXGiy9rvBgnsfZLJ4PTh68yIK1nkMeADMs94b2eqUiuHxQo1UejbHVV6L/NMwyciub/aYdTmyIKJU40KLEkttQ/HfFr2baskwns2l5H+uDwPIbjpVh0iMxCLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktoekpWVDdLUmVBZ3V2ZFg2aS83c1pmeDFON1NEa3MrajlOVFZTeUlYUmlr?=
 =?utf-8?B?aGt1QUdCYzZrdWdRL09XekRrUlE5TzUzL2VSZDdTalRZL3ZNQnBtNWozRERG?=
 =?utf-8?B?RUxVNXpVVXpFMzYzQVhHYXhVWjBreUlmdEpQYk5CSUhESFhEZFJ4S0NINjht?=
 =?utf-8?B?WXY2dUZzTHpnMFdvRmp3WlhucXBBM2NEeVRuUHV2S1pqMGZha2FiaTU0MlNF?=
 =?utf-8?B?SVdWaEdHeUNHSER3UVRNemY3MVRJVGYweUJSVTlqeDJra2xkd09QRWt3MFBJ?=
 =?utf-8?B?R1RzVy9QRTVSdkxlc1kvTVc5bjUxYTZpNFM5N3phSnlrRGVpWnNqZGVNTTV4?=
 =?utf-8?B?d3RIa1JsbTF5SjZXM0Z6U3JXc2hqdUxsSm4wbktnVXhpSGhteG91QWZNQTFC?=
 =?utf-8?B?OWZaVlY5U3pLL3dQQ0xrRFFHQ296WDJaWUFScWZVK0cwcXFVU2E4RHIvSEdT?=
 =?utf-8?B?QmVENGlaZk9hc0NJeVhiRml5Z3g0R3JsbUhQaVNyb2tVbm8zZHI4cWFXck00?=
 =?utf-8?B?M29TZTdUNUk5dytYcHRLdllVTWdzK0ljMTdaS1hYR0paS3cvc1VxVm12T1lk?=
 =?utf-8?B?UGZzdU1JWmg0OGdvNU5FdnJyZUpURktFR213MjE0NDRuN3VvNk9HUkJLWUhM?=
 =?utf-8?B?L1M1WWRjZVlCTnY2b3duK2pPU1d0OFZ1VHJVS2xHZVdaelRlM0g3YlZYNmdm?=
 =?utf-8?B?R3JyTXF6SldQS0I3MldsRmk1TkhUUWtrRXA3ZmdvYWs2UjZuQWRkMjdvanYw?=
 =?utf-8?B?Z1hLdC9iV3hVOEFGMUIrOXBmaTJ1OUNiVGQwREdkQVg0dHBhREtNWTRqTW4r?=
 =?utf-8?B?cW5zempEUkFLU3ZFUUZKcWdSc3hTZnowaldWcTVnMkJiTjlDVHNDNnNTbVoy?=
 =?utf-8?B?d3VxdFMwd0hBYzJIZURFR3Y5SHBXLzNsZTY4alUzUGtQUmhxcHRNR2hhTlNl?=
 =?utf-8?B?em1GRGl3T3lLT2g0UzJVclQ4eEZIaEdNQmdOaFgybS9wM0RHNFQzWkd4TUk4?=
 =?utf-8?B?bG9aVytKMUtQUDFKK0d2a2I1OHI0c3R5MXVMU2lnUGEvdm9EUjI2NWtoYmpW?=
 =?utf-8?B?TGN4NjMzUVQzTE5WSVhZWHVqOHFWMXkxcTV0ZTFaUEtwSGJRVTZvcWRlc2RE?=
 =?utf-8?B?bnB3dklrdjkrdHJ2ZjY1Q3hPNFJSSEo3dS9zdnVyYWhxQjN0R1NXNjBqMXJj?=
 =?utf-8?B?cWJkMDJLTVFDWm02UXEyYzZzRTUzdGpDWXlJT0c5N3dPbHFVWHcvSFA5UnYw?=
 =?utf-8?B?MzNGYWpuZk1aTmxiaFh0YnQzMVFvUWJ3VTRUSyt3R2Y2MEVIMTlsa1ViQUsy?=
 =?utf-8?B?aGtHUDNJcHNFWjg0TURrRzdzOWRTU2oxL1FsMjFLOVBVWFFpL2cxdUwzcW1w?=
 =?utf-8?B?UzZacEJ1OE5sS0c4VjEvcjFTYWtKQTFKWHBpZG53UHJjTUpRNTVocGhQL1dO?=
 =?utf-8?B?K3NMenFUZjRqNFhNc2V5UVZPeW5vL0ZMazlZUkhMRXRnbFY5OWY3YWxGTXht?=
 =?utf-8?B?Vk9WTVluSDgrRWRkcGZZZFdIakQ5WTBTMUZDSjlyTVdCRkhzWG55NE5DSWNB?=
 =?utf-8?B?d3dCYkhTSHVzVVFBVWVBQUF0TUpMaVM2RmlMb1hLdHlleDhQS1lQREZWREM3?=
 =?utf-8?B?NWwvRk5uUm5raytDYnlOT3pWYnJETlAzMFNBQUo3RXR5VDF1YmVWMkk1bXBu?=
 =?utf-8?B?amd6WmV5YTNyK0R2ZVhZb1hxU2RSYlVBSTVVUnp5U1VXL0hERE9BakRncEty?=
 =?utf-8?B?SlZRT2xoNFRURDQvbUh5Tmw4MVBjK0EyOWx6R2VYUTVhTzVGcmhnTGgyc2Jy?=
 =?utf-8?B?bDdPaURvUno3VlZmTXhQdUZ2RlNBc29VQ3ZiTWl4ZkwzelRJaGxYbFB4VEx6?=
 =?utf-8?B?bVdSY0NxdUN3S1Z1aXRnVXRrc2x6cnZWWm5vSmVjUzVLb3pZMlBYTFo4Wnhq?=
 =?utf-8?B?dnVlNi9wNS8yR085cnEwbFdLbGFMRy96djl6WXlseEFXRmVnTUZLTS9oVnlF?=
 =?utf-8?B?NWU0UlRNNnFROUZOUkFBV1BTUVBaS05Rd1BaNlhraEhyaFVZaE1ZbnZtd3hs?=
 =?utf-8?B?YzFrcGlocnFkOFZQTG11V3pYai9OZGJtZHVDZVJTRjM3bHJiUjBVOGpmN0JQ?=
 =?utf-8?B?SWR2QlVaaWN0S2NUWnJuZHJOdnd4QXAvTlViTmhBSUJoUlVtOElWZVNSZzVl?=
 =?utf-8?B?ayt1cno4NGNiWGU0bktXQ1l0aXV3WXcvYktZUEkvYkxvaVBkN0Y0Zmh3bm5Y?=
 =?utf-8?B?UmZvdGtmTFYwb1RhSkJrRlVHUzBEWnNSQjVXa3ZvaE5TbjZlaTZjK053Z0d3?=
 =?utf-8?Q?TRal+OW8kHdAezc9Z+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d97f20-28bd-4fb2-087e-08de75f96f89
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:12:11.5839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRo6oz8+Er5SRdgJ6Qqf6LD2Io+53t7cC/6H+r6xFfSuYnfta5Y4DyLC4ZDXKlA9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

On 2/27/26 11:41, Tvrtko Ursulin wrote:
> 
> On 27/02/2026 10:32, Christian König wrote:
>> On 2/27/26 10:22, Khatri, Sunil wrote:
>>>
>>> On 27-02-2026 02:43 pm, Michel Dänzer wrote:
>>>> On 2/26/26 17:05, Tvrtko Ursulin wrote:
>>>>> On 26/02/2026 15:51, Sunil Khatri wrote:
>>>>>> update the type for num_syncobj_handles from __u64 to _u16 with
>>>>>> required padding.
>>>>>>
>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>> ---
>>>>>>     include/uapi/drm/amdgpu_drm.h | 4 +++-
>>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>>> index 33e8738ce91f..42b4c0f6746b 100644
>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> @@ -479,7 +479,9 @@ struct drm_amdgpu_userq_signal {
>>>>>>          * @num_syncobj_handles: A count that represents the number of syncobj handles in
>>>>>>          * @syncobj_handles.
>>>>>>          */
>>>>>> -    __u64    num_syncobj_handles;
>>>>>> +    __u16    num_syncobj_handles;
>>>>> Could probably cause build warnings/errors for something which builds fine today. Hm on big endian it actually breaks completely.
>>>> Yeah this is a clear UAPI break, no go.
>>>
>>> Yeah i am holding on this change for a cleaner solution. I acknowledge the UAPI breaking here.
>>
>> This uAPI break was intentional. The functionality is used only as experimental feature behind module parameter and new FW anyway.
>>
>> But we didn't wanted to break existing Mesa binaries for easier testing and so kept the ABI for x86 intact with the padding.
> 
> Ack, I wasn't aware, sorry for the noise!

No, perfectly ok that you mentioned this.

Alex, Sunil and I synced up on this yesterday in a personal call and we agreed that breaking the uAPI this way is still ok at this point since userqueues are still beta feature etc...

Everybody else obviously can't know that, so we need to include this info the commit message.

@Sunil: Can you add something like "Breaks the uAPI on big endian but userqueues is still a beta feature and only enabled by a module parameter/updating FW.".

With that Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

Thanks,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards
>>>
>>> Sunil khatri
>>>
>>>>
>>>>
>>>>>> +    __u16    pad0;
>>>>>> +    __u32    pad1;
>>>>>>         /**
>>>>>>          * @bo_read_handles: The list of BO handles that the submitted user queue job
>>>>>>          * is using for read only. This will update BO fences in the kernel.
>>>>
>>
> 

