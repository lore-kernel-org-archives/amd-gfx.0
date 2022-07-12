Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241D3C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 07:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCD612A374;
	Tue, 12 Jul 2022 07:27:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBD912AD14
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 07:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cokRTv3t+Xsmzqnhc7OAK/vPs9UiecjRfKe8AxGPhtuLfwsAro3BrrWOn0qGd40O258Hx8nU9a5wn1Ym2moT/JmoNqQ4An7fO3j9EpnAVZGx7ZzrrBVPBvAvVlRnJw21sZVV8GL29luMflXRW6jVsZzJNb5GVt/xeWJV48kYhIYv+bxxD7za2g7vmCFdgwWEdy3Xc4nIsu1arn5JAPir+ZW/vALThYeyckQo6PwA5ckv6NiZv7t8Lhjg/fQZ03i5dRgXkEoXEOs2/RHjPnoTtuz6wCkbQxcXApA+dWiS/IR5KiXq6QGw40/y5KntypZnOqEnVnAcFpVV9pKeWT8mBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJmNhN1af11+BL6xDmL4ScGjERAQn7r4EnIgM13OlNQ=;
 b=TeBIGx9GkRjjGzEewNfnbVygEYGrLuRVhsM8W+fnXMMcgfxvjJrPeU5QppHx6PxWOW9IaoyzS4nZFL0lm5unf/12AFTadD/XYZPNIBJYW9xUROEFbInPpR0IyJI+QbxQtF0pucrHxHyzf77ndOiIz15tzsEkl+qIh/UL4Xsy7o65JNQ1c7kH67ZNewnA9s0p7S91yQIcgSZrB1E5lMMk9GhNaYIxG9+9RqgZ6K8P3mYx+aCISWWev3yyvAyIeUC8TS7Gk5NtT4Qf/4oe6mo2VdWljIKOiUpg098YKms0/fyr7Re4JTZ/uOotfvZRG52a/n6yCC6MClOaMLOi+00lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJmNhN1af11+BL6xDmL4ScGjERAQn7r4EnIgM13OlNQ=;
 b=KGDKSsP/xdQw9lPjnD6Ae4d5VtxcVwOjEDL5lJlZKdC4epgtCqppaqsNGvxmSwjGRXkpUaG9yQISDrIuKBrOPPfHGwwIwsQsaJ7t8gYk1YuY1UAm1WUEGbq5JJ/24ledBx8CxJ+h8omeZOqwlQHHyppWt1VxUODSUwhCNbcFDcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 07:27:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:27:51 +0000
Message-ID: <bd018180-a1b1-2d26-ab88-7cb00a60a85a@amd.com>
Date: Tue, 12 Jul 2022 09:27:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Check BO's requested pinning domains against
 its preferred_domains
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220711224443.1157747-1-sunpeng.li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220711224443.1157747-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0402CA0015.eurprd04.prod.outlook.com
 (2603:10a6:203:90::25) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d22ed8-0ece-4200-20c5-08da63d80729
X-MS-TrafficTypeDiagnostic: SN7PR12MB6670:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdvHIhg3f5lBf2LTO4LHQrpDX6UBkgBsVCS5GF8mo/dvsdNegV3edHQZlfGdqIWR6mPil7y11nkqh3yLjooRMciRGPREa7HNnA28DxU+Nh8JRiV4r/e2uVFPtiG/wbAN+CNfOKypX30PVh8t8yDDhdDPMQ/Qt+Pu5czmBb9Uz/9N2ahphiGRr97dC5ALDqpHneQ1ub7Jvj4+te3IaZ2Lu42N/HbTiW8Ywqf35iDiiNj5sFdt7FltVCSub10YzwZFOOVkGeUFR5zW9h3TYwZyfp2BtrcyUHb79Po+8Ylv0m6/Rbf3EH2EHpzaWmpRZ36mJjmnTbSUKqk+5R5LoYg6xKwQPS1a/VRar2Y92PMkU9/sBiUUiv+iTEb89uilD814hQ+0N9lCGHE5v7ngSFFBr/Up4B74SF09IHskK22v87s5YwLZdep/WFDXnB0cUwZun61knXij2j3W9ffn4EaFv0Pu5vgUMYGlaSHIvxwaXNv4dMpuCPLbjyms8uQQC5JsgvUq8gK1CSPxaDA6qPR++oLE5+2aVTQhf2OGtBGKNE0EuOhoZb3ItRCXcGGI9zzNhajFB6q1FgOM9fCap5TTMiiia3j0qMjfdbCft2i2zvGUMUlV42PCDXAunGKzsGf/Noe8Vj3CTpemPBGOejNG72gLhPohr+4ivCo3vnL3rEnqUOBuWSXa2ehiUGB5uBDdNDEalt2fv7hx74xI/uVn/zIM9wA7ZeuaY1367QnyW6UK7rraN2j39ZoahtuuT/Cvr+9kGRi3pf1f4bWrgwPgD4ydbEgh6rDOUHFqoRAgA8cbu2Jdm2DwEeDtcBxIBR6aIOk7J6IjWji9iffg11lnqqdhYOftOqLg+Qn2YJcvmaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(6486002)(478600001)(66946007)(4326008)(8676002)(66476007)(316002)(41300700001)(2616005)(186003)(83380400001)(66556008)(6506007)(38100700002)(6666004)(6512007)(26005)(31686004)(8936002)(5660300002)(36756003)(2906002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUlPdkxuRjgxdG51NkZHN2NYRXNwQWNkNTNPcFEwM08zVW9SZEkvYTdLS2ZO?=
 =?utf-8?B?U3drS1piQm5paE9vc1A5anVCZ0xMeGV2Z2htQW5RRko5aUJoV0JiQkhUM0JY?=
 =?utf-8?B?RWFRZnBWWHVxT3JpbGhMNEdOcmZRVjdjbXF0V24wU1NZYW9mNDh1RFBlcmlh?=
 =?utf-8?B?Rld0TmxrWUNpQkhMdVI5d2RVZzJaVCs5Njg4Q0lWQTNWdHVMNXhaYWs5QjNV?=
 =?utf-8?B?SzByYWFJSGxLRjlIV2l2WFIvQXpwNHVrcXNLMjU4SFlGYkNvUzBCcFh5bDFS?=
 =?utf-8?B?NXIrTHF1YWwyVElMOEIvZ2JHVDFlNXJpSU9zaWZkNG1aMXRVVkYyS3dVTE9D?=
 =?utf-8?B?UkJZNzFSVyt6bm1oL3cvaXNHUnJRdGNxNjBqeTdWZytYdkdSQzk1amJnV1Aw?=
 =?utf-8?B?NlA0YVJ1eFQ5RWFNaTdkL1dBL2RtOUV3aFp3ejNnK0pGRFJrQ2JKMmlBOVdO?=
 =?utf-8?B?TWJUbEhsQnJTL1E3TTlqVGVoU0YrK0cxcWM3Zko2MUJzdUNyVDZ0SEdtN0t0?=
 =?utf-8?B?NE1KUk9xeWJmQ2s5Y1l1emJ6S3YzdXhpZXo3U1h1c1BqLzEwYUZSNmg4Nnhm?=
 =?utf-8?B?eWpxWjQwN2ZFZHhPdzYwK3JlbnJlcWorNHkyN3ByeThKbk1UZWRJZFVERTQy?=
 =?utf-8?B?bG1zYXRSK0FCcnhSbExJK2pqMHFlbi9ieDNRdnB3SWxaT2Iwc2p0aHdHUkhE?=
 =?utf-8?B?ZWFYUjgrR09BL0Rva2NJSitwZGJMbTRURDIvRHp0TUlKbnhSdGsyU3F2SGdC?=
 =?utf-8?B?dTdwM2tGYkh5akhiSkpNUk1EbEVVNlpraVc5TkxybW8wOTk4ZWN3KzBRV00r?=
 =?utf-8?B?cGRVV1ZKZUJmMWFoMmlMd3ByOG1wekdweUlPRU5kcW93YkdxbHNvUXIyN2Mv?=
 =?utf-8?B?QWVSaXhDK1ZzZC9TZFF3KzFxWEd5KzE4QmpGdnFrNWhlRDJxTEFkR0c1MDRs?=
 =?utf-8?B?TGI1MUdJK3l4eFdVS21YWldlbFUyR3M3R1UzZkMrTDlkYWU4OUk1Y0hyQ1d0?=
 =?utf-8?B?aU5tSTRrTDg5SUdrcDkrWW5Jcm4yWUlzTXhRcHh6UGJ5amRFdEw1RTlRSENI?=
 =?utf-8?B?aCs2a2JMbCtGQ2IxcUVBTnBxMm9oakF6L0lQR3pDWXczeEFSRWZ2enBCU1Vi?=
 =?utf-8?B?RlROWHFVWTlhNWI0Y3Y5QkhBWlhDSHpoM2RlVXBvYnZwdk9COFdVM1h5U1gv?=
 =?utf-8?B?UG1JM2Uvb0xRb1dPUkF0Q2JrVVZTeTZEQzBtQURvN3FKSENySDY5R2JXK1N5?=
 =?utf-8?B?dHFXYkkzRmhTWFlKZ1RMaE9kZk5DYzZMaFlPbThCU2wra29TWUZRblRzby9n?=
 =?utf-8?B?K0t1QWxaaXY0eEhRb0UxM25qNG10MGRPQ04xNGZSRG9KQm5OeXlReXVCQjFO?=
 =?utf-8?B?UkpQaE1STFIxZFJZdkxpZFZGa2ZKbG44aTFVTjEwU2F1ZHA4SC9wMzN4Ynl5?=
 =?utf-8?B?M3hFTWdFbk9sS2VZekZRU25IMWVLQ2Nxa005NU5hN0lnZldyVVpLUFhVaEIr?=
 =?utf-8?B?Z3dYMlFXck4yOFpMNCtMS2FrdWFhSWJGdXdHRUdFNWZVa09pd1BUdzNlT0Y3?=
 =?utf-8?B?M3hmejlKdnI5RGV0bGR6cUpMa3JWelJPM2Yybmt1SU5yKzJyTTMvWmpTaE5a?=
 =?utf-8?B?VUFxQStad1hHVm9aVXVOUHZJVythNW9VT1hnQm1tN1plZGR3MHVVVXR4VTNt?=
 =?utf-8?B?L2ZXY1NWRkdBa0krRi9CakZkSUQzclVlc282WFdjU2daSkRxTVA3bkdXOU56?=
 =?utf-8?B?OEcxRWdqU3V1emhoV2tMdmM4cDVDOXBVSjN4TzNCdis4aWcxRTRNeTU5cFFV?=
 =?utf-8?B?dGRaaDBwdlVuZ3ArNFpsME1uQTc3NDlyNTB4Z1F5Z2c3ajJnYmx5MVRnVGFM?=
 =?utf-8?B?ZjNtOWcvbWxxNGZzcFNpUTFUMjlsSWVvRFUzSGhLL2UyeDU2dDJWYWZ1VzVZ?=
 =?utf-8?B?S3B2RUJHcnhXdWtPK205TWFzVE1EblUyZk5SR2l1NG5vcjNyYXIrdkVnZDN5?=
 =?utf-8?B?UEtuQ2VuVjlpQTMwSTdNRnB6RUEzalZ2N3hFN0Y3S0RqeDdyZlp0TFkyWklK?=
 =?utf-8?B?NE1OcnhxZENySGNFWU9Ta0d0allQTG5nOGdtSW9MTjVvV1NSTFNqcW1wRmM1?=
 =?utf-8?Q?+9nonbMMsrZHpL2O6b0Je7aU5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d22ed8-0ece-4200-20c5-08da63d80729
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 07:27:51.2755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRTyUgmRLIIQYP2KX04nAuvi1GUciAWecv7FMwkCro2iZENrHn68SBrPUMlEJMsU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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
Cc: Alexander.Deucher@amd.com, Harry.Wentland@amd.com, Marek.Olsak@amd.com,
 Leo.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.07.22 um 00:44 schrieb sunpeng.li@amd.com:
> From: Leo Li <sunpeng.li@amd.com>
>
> When pinning a buffer, we should check to see if there are any
> additional restrictions imposed by bo->preferred_domains. This will
> prevent the BO from being moved to an invalid domain when pinning.
>
> For example, this can happen if the user requests to create a BO in GTT
> domain for display scanout. amdgpu_dm will allow pinning to either VRAM
> or GTT domains, since DCN can scanout from either or. However, in
> amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
> adequate carveout. This can lead to pinning to VRAM despite the user
> requesting GTT placement for the BO.
>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8a7b0f6162da..50400d70ef12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -883,6 +883,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   	if (WARN_ON_ONCE(min_offset > max_offset))
>   		return -EINVAL;
>   
> +	/* Check domain to be pinned to against preferred domains */
> +	domain = bo->preferred_domains & domain

Please guard that with an "if (bo->preferred_domains & domain)" to 
handle the case when the kernel needs to override the pin domain. That 
can happen when we export a BO to a V4L camera (for example).

Apart from that looks like a rather nice bugfix.

Alex should we add a CC stable to this?

Regards,
Christian.

> +
>   	/* A shared bo cannot be migrated to VRAM */
>   	if (bo->tbo.base.import_attach) {
>   		if (domain & AMDGPU_GEM_DOMAIN_GTT)

