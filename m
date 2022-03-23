Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 08:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F9D10E60C;
	Wed, 23 Mar 2022 08:44:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A9F10E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 08:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+dg43IWjYtu4IuSyzNck36XUIPES+JI+GxGi4Pc3wca4UrIWPv1WHi21iAMWB9MgCvMq0QSBu+NuW4e6XXV6W8O928hmqolvQHJ2P2cShOpQ+Dw/JvQmwyjDFS8PArXD1ieezbfvdvvhOyNWwUMeME9fajxzYKxAz+MKUium/9rVA+ci6werqko5k954nzDw2N4Fb4Nd0D6+sLb/ZO+kNEn1FweO0Akf/4o87RO3j9ueGqJORTWzE972flOEMBTo2lNOLsxj4cHt98qS33EFv/ldqMujJ2LUb6uKUARySXk08g9GhmD31hZtPJzOIpC25tm40ry9aL6a/I75xJEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5/pDqQOOseL5SZAP2x7NWIm0ruTAsEdyrtGQ2HWGis=;
 b=dW8ilG/iYFeIUbVVCpNdRUCp2xGW6qEy3Xmi7/7/GAi7Kw8ex+E1lv/H3BAHW1Tx2Ly73RugYZpdBdHDn3WGvtKxsD/Me3FFaqLDGdSS/dQhp+/61A8g7DyEhs0SRwSpdVYwHxkiZHyR8+6Y0hkft2fIMceE/f4JT4ntpdsoR+wr2sZ8f4rglxz/Fd2Ol2b3e+NAl0xmazLtEct6nWQklO0Jy6ZzWjxBm57Z7rTopIbYee3rWdLP7Fq63Me5n0u0k020pcNuQyz8eNjsrRc1apuotAUi5YJGyqRuo7us9MKyFmygzPvCIj1xKs8Kny2w5QAsFQzv0yjbuvT4IpbKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5/pDqQOOseL5SZAP2x7NWIm0ruTAsEdyrtGQ2HWGis=;
 b=BVUkRrPRWDnmBU626E0YUlii6xjmrGO75E2K66nqzmMk4EkFGiUC5Cct6s3dBwXrZXk6Lm5IC2g+LQi2Gc4iLxp0dMq1977wKCO003K2wMOqjkDJBA5xefnWgr2i1pFWqzm2gSWB7FB43EhVAAZpCX5J8k1b4IzuXxGFauSZgAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23)
 by CY4PR1201MB2485.namprd12.prod.outlook.com (2603:10b6:903:d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 08:44:54 +0000
Received: from BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::a486:e9d5:adc7:bdd5]) by BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::a486:e9d5:adc7:bdd5%12]) with mapi id 15.20.5102.017; Wed, 23 Mar
 2022 08:44:52 +0000
Message-ID: <bee530a3-c59e-63da-1302-866830aed353@amd.com>
Date: Wed, 23 Mar 2022 16:44:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: "Ma, Jun" <majun@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220322125308.3771732-1-Jun.Ma2@amd.com>
 <bcf4bb86-4b76-0b02-d0f6-2af822e5276f@amd.com>
 <e424caae-277d-4aec-7057-8b38c27cd9ad@amd.com>
 <c1898ff9-c274-2f74-5998-d5e0afc0d14c@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <c1898ff9-c274-2f74-5998-d5e0afc0d14c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To BN6PR12MB1620.namprd12.prod.outlook.com
 (2603:10b6:405:10::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a36ed873-9993-48da-3b3e-08da0ca9655a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2485:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2485F8A18510E019D42E6F39BC189@CY4PR1201MB2485.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KpQQgb+BTo7kn7fxMv8ACnFn4l8zW0Os3USh8Vke94tbwIsu/2T3wyzBNPMfnwihMm4+/5VS/tU9v648UCHSdvn0um/m0NiIGsTUuHeJ9H4FaXFueqHRk81LQazJ8AJyqiCHDuD39gbohEMfKMg3JbLGxnUwLJcw8ij/BHMwNR9DyxHT8lNqek5x7j7u+0aLIKYhXuQukg5edzPQdgGdd+GfPMh1yP1SDQPDWVMspDANLQrtG+rMZWgVQJ0QLyVBFbkISrXWodEweGcKnymqZzW9iBd9FtJ95jF+ycmZQpXPWu2y+1BSLna7nkaLYT4BvT+swC+m67vDUXErXADAcIneRtHWx9KA1zZ9rYUM5/JkBXWkBp5W+tu424xYBh0PL6HUlb5fartYgZnT0f2x8gzdZvens9JWZvma+xMnTpubZ9vDZ2mrd+eIRJKzWTqMJkl5ec/SKUEKD1Hwi4FXsfkMaUyOi5M718F4nrTuYjer09hU5ZegtAtYmFxzk6bi6ArNfK1V5AUY6UOQMkAIxjcZq+LLy0QK7SGmidEn279VK2t6pVMFbj7joGUcru25sexiReR7zjoWTDAik//VdXbTkUB9ewgEGhSpq1BtbR+DDFohxY5WW1mJkG1VTLsZ1hzsl8rjO0bfANoS6l6pCQskc8740McML9wwty+MVByM9UiEz5qtvj9iNtU/y4ZHeGlbJBds48OEJY4fKaPpc8D9ncX8xhNLRoSGx2yQP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(2906002)(508600001)(8936002)(31686004)(5660300002)(6486002)(186003)(2616005)(26005)(36756003)(4326008)(66574015)(66946007)(66556008)(66476007)(54906003)(6916009)(31696002)(316002)(53546011)(6506007)(6512007)(6666004)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJaNHViUVhFWEFRNkYzb21zK3ZKUDZ5WnRxZC82aEI3Sjc0a29CUzJ5bEtV?=
 =?utf-8?B?Y0doaWNaZDdtMVFQSHc0V2NHN0JRbVkvRlBWNnlucTZhQlF1b0hFeTlhZmUx?=
 =?utf-8?B?aTgzNzFDQ2N0eEFraytPc1NvQTFhanJtYjBnaW5vN3ozTEFONW85YTk0bFJX?=
 =?utf-8?B?RzU0cGQ4Q01KandDbVFweHF2alF2aHBmVFJhNHAvS2FiL0tSOFhaTTMzcFJp?=
 =?utf-8?B?aGZJVWo2a3ZyRjdFTVVhV1o0b1NPK0xkWE1GZmtKSG9LS1JsUHNNZW9NSnBP?=
 =?utf-8?B?czN3R2lGcXR3dEhIaHBKNUdhRkpiRE15d1ovYlZKM08yQWlCOUtNQU5PZUVW?=
 =?utf-8?B?LzkwNTR6MmFGVXZNSUxlWVVnd0tLdVhCZUtBVWZIdlZLRU5YSUVsU2cvRWJH?=
 =?utf-8?B?cXNjRXNzc0tDZFQ1NDNsS0hRb0ZaNElUYUZzbDloV1pKZmxrR0xPUk0wdjdB?=
 =?utf-8?B?K2hQYmJHYlJEZXNPVDhwTkcrbUlkN091VytmMllQdzBZd2IxMnpzSDF0M24w?=
 =?utf-8?B?Nit3YXNKakJWajJpUktlQnZlQWcrdFFxdXBKTUR2ZmxVbnJ5WGpJVDJDS2Vn?=
 =?utf-8?B?OEEzT2RIV2M3T0U3elIrajAyNmN2SWYrVlJRQjJLYWN5anVyM3NFZU56dk9x?=
 =?utf-8?B?VlNnL0g5c3R6c2dHMGIvck92Qyt6ZUZnQ0JobkhHU3dwT1ZMZ04xRnMycXlm?=
 =?utf-8?B?cGxoL0ZEZG9qMmJNS3NaZVlnRDArb3cxVGVzSm5wVlVOTTc0djJUSzg1Wmkx?=
 =?utf-8?B?VUFuUFhsLzB1M1FKV2pSejI3WmkxMWphNDRQeGNEVGpOZGU1REhOT3R1Q2ll?=
 =?utf-8?B?M2V4S0kzVUhPcHdVN0p0ak1neUFzNXE1MXcwRjZXR3REN05CVERYSXpFVitK?=
 =?utf-8?B?WmRjRVRUQ01wcnprWjMweDR5NE0wSzlFa3dZS0hnMVViVS95cjZOdGxmQzhU?=
 =?utf-8?B?Qkg1OXNGSW1Ub05pTXJ2RWlSYkt6SjBHSldPdVRxS2pUdC92RFVhSnZkd1FO?=
 =?utf-8?B?N3ozVmNUNDBVWWZBbFR0dkszSTIxbzI5NHA5ZU53TUZ4MFFuNnFPdGs0T1ZS?=
 =?utf-8?B?bXRHQTV5ZXpZUHRFTTBSc3FaYm80bjZIMXVPR2JpS1hja3dLRmNlWVlqTXdY?=
 =?utf-8?B?aG1Kdnd6bXdBZjV3WEc3NXc3QU5BdlFVdHlrRTFCUU0weG9HRmxQaFk5b2J6?=
 =?utf-8?B?QmtXSGdLVmhYRmlXcmZ6NE5weFdET1I0Q3ROM2prNnd5YmNOcDl0UkNnY2pW?=
 =?utf-8?B?SVN5Q2hnY28wUjd6R04reFdrTFcrT05jaHBEQXprUnJjdjhUZUtOZDVFRnlC?=
 =?utf-8?B?SGRZcWlveW0vRWJEQjZFUHVmK0lKd3JFSDU2K0tLaXlNM2tUckkzNmVlWmhG?=
 =?utf-8?B?RHd4enBSR1VXTzVadzdsNUxUS0JxRlEwRTlaTHdtdEhYVjk3dkVPam9Xc3M1?=
 =?utf-8?B?MkhybVE0YkJ0V0RDM1RGQVNNYUJZRitrZFljSGR1MEk5MXprT3pyZHVQd1oy?=
 =?utf-8?B?d09YNXd0WDBVSVc3SEZ6Z2JGaHBXVnNua0xsMzhjU2ExSEdEcnRmcVV5OWNk?=
 =?utf-8?B?UHNtUkorTnZmbi9nN3RpUE5rOUVhRE91M0hqdjd5SVN0Y2xwWEg5Z0cvby8z?=
 =?utf-8?B?ajJTVVJMNlUzOFBHa0VaMWRLdExic1FYeFVtQ3lQak5SYzNQSEJ3WjBEdDF0?=
 =?utf-8?B?Q2d4SHBBdHFEVXF6V1dKUTk4NlhBcW9laysvVXc4VENxSnpDSUhFWXBTaWJX?=
 =?utf-8?B?L3l3TDF6Z1hSb1c2VVViVGo3bXhkV0dEK2N0OXRaKzRFZTlaZkR5MXFqUTV4?=
 =?utf-8?B?L2NuQUFuU085aVJqOWtLNm1QL0h4bTc3VVlaMy84elAvRHpWd1Yzb0dESFE1?=
 =?utf-8?B?N09BakhkYlYzYkU1VXJMR0NVNXU5SmlpT1BZVGRiVjQ0RkxOcXZmRmE0SHBz?=
 =?utf-8?Q?OvYnNCyPVFoZ+YcltuCzj8PA2VvQ1hDW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ed873-9993-48da-3b3e-08da0ca9655a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 08:44:51.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH4Y6BaDHsauPK2zW9X9LmBAlO3ZBxazHkdj7O5/VlQUQTFxDxOu7yeuNb1tQHMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2485
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
Cc: amd-gfx@lists.freedesktop.org, Ma Jun <Jun.Ma2@amd.com>,
 alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/23/2022 2:22 PM, Paul Menzel wrote:
> Dear Jun,
> 
> 
> Thank you for your patch.
> 
> Am 23.03.22 um 04:02 schrieb Ma, Jun:
> 
>> On 3/22/2022 9:33 PM, Christian König wrote:
>>> Am 22.03.22 um 13:53 schrieb Ma Jun:
>>>> Correct the parameter name of amdgpu_ring_init() in header file.
>>>
>>> Maybe write "Sync up header and implementation to use the same parameter
>>> names", otherwise somebody could think that this is a real functional
>>> bug fix and backport it.
>>> ok, will fix this in v2
> 
> (Your mailer incorrectly quoted your reply sentence, making it look like 
> it was written by Christian.)
> 
> If you re-roll the patch, please also mention both parameter names in 
> the commit message, so people do not have to search in the diff for 
> them, and can verify the changes match your intention. (The summary uses 
> singular *name* adding a little confusion.)
> 

Good suggestion, thank you.

Regards,
Ma Jun
> 
> Kind regards,
> 
> Paul
> 
> 
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>
>>> With the commit message and subject adjusted the patch is Reviewed-by:
>>> Christian König <christian.koenig@amd.com>
>>>
>>>> Change-Id: I202d76ba04b137926b456b1c8a4c05a5b1a01bff
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index 5320bb0883d8..317d80209e95 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>>>>    void amdgpu_ring_commit(struct amdgpu_ring *ring);
>>>>    void amdgpu_ring_undo(struct amdgpu_ring *ring);
>>>>    int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>> -		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
>>>> -		     unsigned int irq_type, unsigned int prio,
>>>> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>>>> +		     unsigned int irq_type, unsigned int hw_prio,
>>>>    		     atomic_t *sched_score);
>>>>    void amdgpu_ring_fini(struct amdgpu_ring *ring);
>>>>    void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
>>>
