Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB247C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 08:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCE210E46A;
	Fri, 19 Apr 2024 08:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvLtgoDd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB33F10E436
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 08:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke0qbiHTH3tzt2FYeJPazfb+C/XFp7Ajte8FV0STyxSEYwKA1qoInMHCXFccnOwSdnazYQ7+P0hmilaxD88XbSln1ukSwJmFpfpCPgoCe2KlMv1awYzXdAZlpHAuKMdmXjT65IjKcETulgs/UzMzQC9mM0BepwTqRjPX+d0W0Nn27Ylk/J125LMoW4coZKEo2tFBBIU8bm+fPlnKwyw1t/0lNNqcwp6VRYrDobGsFsXHeSU32haZ9DJePIz49W4QEOYTw5tKmiNjOO4qIi0K8l2SwD73xgWBS48IEZUWNXTuOyxme2Tt0K5y0ALqfBMSYHtIhzFxiFUuNro3kfn+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us/sQr/CIiS7eaO/iGQj0itW2MAIyDYPbykaqx+/XN0=;
 b=ckyzlsFeLdJKxgr31CfwKGSSv384ZIfvlaMnYSz6tDYw5LRwnt6YTQ6YXwK4ox6Fj96pQRkoDZYY5tTaefIoEtYbufwCOMZxhZtH3XahQ/lJWYr69GrFXTiJQbVjy8j78OQkIgBakVhnfvPYDjc0otXF/68PYzJNXZ28naVu48xVnMxVwOiRUqAa+jApO8fU4XNtaPbXMBxIjRB5vVdNK7UZ0VhQU7gSklfQuMV+Rz2XXa8+ClV4iGV1DocKC6nmXzkjWa2XxRJFBfQTLFSrJg7CitI+cjvnm7nHQsgDuz1ltLVVzq/90TzEsGn+gla/Y8fw6dg/6C+s/qG4tnfV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us/sQr/CIiS7eaO/iGQj0itW2MAIyDYPbykaqx+/XN0=;
 b=mvLtgoDdm2exkvknGICp2dbBxwqAya/rbrHlnu6h3MTeRJJw3hWexJ1Xgg8gDbgIrGPYFGvOYvueCnAWCSxXGashrCDbFIHcFMh52VsjuSF6uJCmmh1I6ppPSpD+y9Ew13WJhBQ362B7G9255bSLUXy6j4CrDnenIMjFIgoork4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 08:44:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 08:44:17 +0000
Message-ID: <869dbd47-6f85-43e9-9c13-705d209ca994@amd.com>
Date: Fri, 19 Apr 2024 10:44:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update BO eviction priorities
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20240418180648.2934147-1-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240418180648.2934147-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:803:50::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b15e9b-5641-4386-6951-08dc604ce621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGI4NElZZGp2WGF6TkwyOHEycFZTWnJGa3hqaGR6QWFEYW5Hc1BNV2hYTllZ?=
 =?utf-8?B?YmFzOVF0aGNramkvNDJScXVnUVNKcTI3anpKdU1lR2x1K091NmQrSE1PcFdk?=
 =?utf-8?B?L2E4NlFpcWVrMUkrbEZueTIvRzA2K1dPaGtaejZCYVB3QUtERVNvdWo0Zk5n?=
 =?utf-8?B?UEI2QlNBOVlXZE9jNlBXV3h5cE45NEp2QjdQRUtVZG1rRU1ETmRuUFlJa0Zm?=
 =?utf-8?B?NVFpZmNyaE5Ed01Fa2hVSms2L0tXejZiSktVQk80ZVF4U1RCVHByMXRDczA5?=
 =?utf-8?B?b0ZxbUV3cllITDJXZ2lMR0o4eElqdmZsdkJUWEFESzB0U3ZhRWZQaHRlY1lM?=
 =?utf-8?B?dUhLQk5yb3VWRzMyQzZ4R01wM2RFeW5Hb28vZVloOGRucGNqekU2VkFRRy9l?=
 =?utf-8?B?am5NMTFHbnYxUTBnajBvRDhFa1JBa2RPbU9IN21zcGRyTWJBOVpZTUJNVy9H?=
 =?utf-8?B?ZVZYbklRekFtbUpVL3FJazJsZ2xQNTgwNm1QTkszamx0bGFMZ1h4VUhDTDNM?=
 =?utf-8?B?Tm5IUkZqUkdsb1lnMkVta0lGMlZGSHR0eUFGUnk1My94TGpEeVhoWWltNjlI?=
 =?utf-8?B?MWZ1Y1hEWnB5RWFEd29lQlBraWJ3M2c0ODd6KzlTL0hVR2V1WCtzbEtwSFBE?=
 =?utf-8?B?K2VIZjFhK1lBc29oMjRnb01TTnFRa25GZUhqV2dYWGg3SFpLQXl0YVlldlNN?=
 =?utf-8?B?MTVWN2E2UG40OXVDQ0szVXN6VURwRFlHS0NGbFhmY3JUOXdKclRYVlNOWXdP?=
 =?utf-8?B?N0FzckQwVVY4ZlFBa1pQWlQwSEIydkMxM2k0TjhRbENZYmJ2czN6K1lqeGEw?=
 =?utf-8?B?WmlKUFk0enA1QkszMFJibHY5bXBnU2xQMUdrZXNkeUJvV2hwSzIxT1hQWkV1?=
 =?utf-8?B?azVaaDJQblZUZGR0cTFGYkVNaDd3bzl2dGd6cFk2STk0c3hPSkVTdXN0b2NO?=
 =?utf-8?B?K09CTi96TFF2SDlFazh4UUR2QThjam5QdndaM0ZhdWdWYWFDeUVBNHl5cWJ5?=
 =?utf-8?B?b09WTE9RV1dySHhHb01Ka2FvdklQYUJ1MThodU1Rc0tTSEdVbWxNY0pISGhL?=
 =?utf-8?B?bDFvcmFTZ2MrS3NnaGpQR1lEaDN1dFFqOUlMbndhNnlEbVVQOWNOV0dTYU54?=
 =?utf-8?B?U3NqUTNGdzZEUFlseEFyeGgrcDNZQnNvZW9DS0xpeE9OWEhzSVB4TU5rbGxJ?=
 =?utf-8?B?YVp4cmdMU2hVM3lRa2Vndmo5M0pCYnd6VE55Mk9nMys5Q2ZZUStTS1JVK1Vn?=
 =?utf-8?B?K3NUWTlNeitydkoxbVZOUHlvdmZwSXlBSXR3dnRIR3VRQVRiZ1ZwNEw1WDZO?=
 =?utf-8?B?VE9uV0JlbmR3bk5xTE9lSldacEtDaVNyVVJwakNRbHdCdnFVMk90bnRsQjFy?=
 =?utf-8?B?WFg3OVErWkV2VENuL3dJaE9MNzBrRTA3cGF3dENReWtHditVbmFncnVRU3px?=
 =?utf-8?B?YTY2M1FLMWRSdXpTcitkUmJEcXlzVndmWm0xc05mTlFwUURkbTgxRWdSd2Jo?=
 =?utf-8?B?UFpqMUhyblpZK3lFb2FucmZsbk1SL1dQMERTUFNGZlpXTUR6enFPaThLbFBB?=
 =?utf-8?B?QVcwU1ErT0hPM0ZuV3hJRENNRXR2VkFnRFFVWWJZbDNsVUw0dVU3ZG9LWXcy?=
 =?utf-8?B?TlJOTFFaaFlHSmhPNklIeDZsMEtVY3M0RGtiWlY5TFlGVEo1Z1Z1UWZwWTRF?=
 =?utf-8?B?cVlvLzZ6OVR6dk5UUnhrbHlRZjVHdUxEOSsxYW8zZm1VdU5CdExjUjd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FxemFPUDB4Y2ZBRy9aNmR6bWNnNHZZdXFmbjFIeFpvT1htbENhQzlGZmtq?=
 =?utf-8?B?WTM5Skx0Z3ZSVm1Pais5QjZBNkRvcTNwY3VnSGFmbzAvdVpFVndoRkVhdlV5?=
 =?utf-8?B?Y1h1VVlRU1lvaEJkUnQwZGtHMXJiK1lZM0FJamlwQzBVaEM1N1ZLYmlXVzh4?=
 =?utf-8?B?OHNwOGw2cmFiWWtocFhGclgrNnJ6dHJIc2JCRGE1b0Rzb2Z5MlZkSWpydmFO?=
 =?utf-8?B?RVBWckRTNDJyYkF6bmtyYVFQaXUycUFmdm1aYW1TK0QvdEVkdURnamlWSTh4?=
 =?utf-8?B?TFVJUDZnd2EzMWZzZkhMaHIxOVJaaHBVUE9vR2RydjFydFhFeFozeUFZTDR4?=
 =?utf-8?B?WHNuSHhESFZjbllIVDNTekRROGNlZ2R1T0hTNWlGRGlwQ0J5OCtsbEZvc0th?=
 =?utf-8?B?anpEWnVIMmdUbHhYRDZScXZyUXZ2eG5XOTJhc1N1SkVMOWgvT0R1T0g3Tk00?=
 =?utf-8?B?cDR1VXJ3TWVPUEJRSm9xTDkva0ZzZ1V1ZlFSWUdESHBiSWEwYWFPQzNVenJZ?=
 =?utf-8?B?WWNsN0ExK1JiZXJVNDB4aGFhTFpadVE0NEUzTDZ5NTdEclViVi8rRW0wM0tx?=
 =?utf-8?B?aGI2WWpETlpQaGNUT25mYjhRSnhZZ2d3SGVEZkp6WFFKeFI5T3FzeEo0VzZ4?=
 =?utf-8?B?amgvT0xsY0FHZkZGTi9iZlRxb2pGallIbnk1Slc0MUprWkR6NmNBeVVNSnpG?=
 =?utf-8?B?Ny9UazBQM3lKUElxSWVGZjQwVmYyK3g3bk9VQzg3UWpYZzBRVHNOYm1UUnQ0?=
 =?utf-8?B?QnlCTGZ4NEtlcXNoVTRPOVZrY3lxeGZyOU04U2dEbG83Y0F0aTRYd2xkSk5Y?=
 =?utf-8?B?NnlPVGI4bjNQOU1pZWptRC9USUg3THcxdlJWZnF2cTlwalg5VzZpaDNPQzdo?=
 =?utf-8?B?MGhydlRacTFOakYxS1E1NkNrcUNpU0ZoYS81emQ4QzN0dDFGOVdHQmg2WmZ0?=
 =?utf-8?B?eC94aERhUWw1bVVqKzFEdStReGxIdGZwam1HeUF3SVA5N2JkKzlmZ1hJbmha?=
 =?utf-8?B?anRZZkdBdlhoQ0c5T3FrN3RDUzFCaGNqWnNsNWlCZHZyaGpGTlBsSEJSQnhN?=
 =?utf-8?B?WjZnRC9mdTg2dHF0ck5xU2NuTDFSblFYNDhpQjAzQ09XSXpSaHluYzV6a0x5?=
 =?utf-8?B?OUNWYzRqSmJoMzd1U2JzRXlhajBuOVJvcmtERlBXcGNEUzBjSEdnZkgwNkpR?=
 =?utf-8?B?UWtLc1FKeGU5ZGJ2aEJwQ0FrZC8rTTdHT1FZREczRlJrVmM3WUJGUDAvUzFk?=
 =?utf-8?B?Nno1dW81S05qQmE5RlpnT2UySXlua0oyenJzd2xQVld2VkdoemR0MENFQi9B?=
 =?utf-8?B?NmJad0tKNE01U3ZjYVJ5RU4zN1hXdStySkE5M3FzeXNEbVVMY2RqZFVmdWRS?=
 =?utf-8?B?NFFCK2xjQWJxMVZscTB6R0o5RGUxcmh6NTB3M1lzZWd0Nm80dDdUUzZmMFdJ?=
 =?utf-8?B?UHJMUDNhRnVvbVQ3YmxTeUN5b0ZqWWp3UlA3elI3dVhTVVJnK3UzdWRpYmdp?=
 =?utf-8?B?cE85OFdvMW00RXB1ODdQektTUlU5Vk1EVVR2YTEzZm41emRPRnYxaU01cmw5?=
 =?utf-8?B?MWEzMUFMRTFUTUxrZ0FjcUMzN0RxcTV0cGhpUDVJSVViQ1NqTzhCb2ErRFVM?=
 =?utf-8?B?Wm5za0xtZ2dCUFdtbllOMlNFRDVraUYweW1PZVkxNjNoR25Lc3JkQlp6eFdt?=
 =?utf-8?B?eVVBQ0M1bG54ekpqaENEcGNDRFFjMEpudlpPZm0rMTNwU0twYTFFWURGV3VU?=
 =?utf-8?B?enZqOGlDdWZCZ3RJRUNXN0drUXMrLzBKalZpb01YeWpVMTJCaGMyWWY1L0ph?=
 =?utf-8?B?L2Q1b25XSm1MR2JEbGsxNUtKdHVmVTlFWWhJNVZqajVUTmRwc3ZtWHdjWmJO?=
 =?utf-8?B?REwrbFhaSVQwYldVL29hTXJaWm5JYTV0WXNxNUtiOERBMGR5c3hZRkNSZEM3?=
 =?utf-8?B?Z2N2TFVPM210ZkJnNWZ3VXY4eHBmVFE4QlZoT1VnK1F2a0xINC8wSUFwS2FH?=
 =?utf-8?B?YnppQ0lYLzVlMWoxYWFJSVpUc0F4TUJRZVJaMmxWMzhQYWlkTkt5d08wODZX?=
 =?utf-8?B?azcwQkY0VzBmS3NWalpXR1QzRC80bHQwaURnQ0xaOWYrZGZWTDZMZlhqeWdr?=
 =?utf-8?Q?0Fjo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b15e9b-5641-4386-6951-08dc604ce621
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:44:17.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4aOhutlJIi20NfIA27nngt8r3yHCA5ATamVGf8VqWGC+YJ19wvwlilOKSn9SU5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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

Am 18.04.24 um 20:06 schrieb Felix Kuehling:
> Make SVM BOs more likely to get evicted than other BOs. These BOs
> opportunistically use available VRAM, but can fall back relatively
> seamlessly to system memory. It also avoids SVM migrations evicting
> other, more important BOs as they will evict other SVM allocations
> first.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Good point and at least of hand I can't think of anything which could go 
wrong here.

Just keep an eye on potentially failing CI tests since we haven't really 
exercised this functionality in recent years.

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index cd2dd3ed7153..d80671535ab3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -608,6 +608,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	else
>   		amdgpu_bo_placement_from_domain(bo, bp->domain);
>   	if (bp->type == ttm_bo_type_kernel)
> +		bo->tbo.priority = 2;
> +	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
>   		bo->tbo.priority = 1;
>   
>   	if (!bp->destroy)

