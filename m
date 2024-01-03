Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC143C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 18:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCDD10E2D0;
	Wed,  3 Jan 2024 18:58:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDEA10E2B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 18:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9xVkh6ezTQspV23/iZX7sCmh3qYY723heIb1W2VrApAGJR7UD+qiSH6OdXM6SKD5rg2cYwp/hs4VTPjj7V+jPCSTn4U98tESErH8eFVnV4lPln+ovoa5XrFE+zVLv9Ly1/pPlXXMbT/jThCeOIZQ7JIxHgjeJkXqbFSLxSuF5Lifg6REHgvNysJQQIokW77O7J+ggLPvtDzXrrUJJqK64I/hj6ZfDjQ1tsJgD5PX95F/3CoEqJk6G6tZxvv1CcLQwwP3zO3eamXyb3Qr/cmc0UwwPam4Bg390frtyLctM/MPYougLuxaOkeSOAOxLc+2DWz9mD/wCfbLdxYAiqvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xqnf+ltkXSw+s7s2tKFIqbtDKYFCgfM7am2ksUfYro=;
 b=J75zQD+gAyBnnYTorNUUMZxtYIIjc6+6VkcXSrYDA6xMz/nxCyeuHXIfVGAKsEaBJNYBRYj47QwkIfsW36INQ+C29c2fufpj1M7Zvqx2Fo8nv6IhuPDl+04D3vp3R1EUeEiBZq27yc+ejGaBYQkA1OFJ8uRMaYW1Hrn/a+GXm2RQzk0qkf8p9IqSkrxpoynN3g+62mzZ3TfGNkAgroar4kcEKvm4DTVqrHX+HgTnnANtT9XjRhKzUt7X/dgWVA0f3rMcxfqrYLGXRNvaLjBfYcKDxY9Ljt4P62c5gjutp/8WOkQsnOv/U2UID7lJXCqZY98uUB+fhrB7UnYI9b5+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xqnf+ltkXSw+s7s2tKFIqbtDKYFCgfM7am2ksUfYro=;
 b=qOpdBauq2pJxWky+tAzG95K/x1RwJLEM8EUcqMsDsAFbx74JqUj5KO5acxWjbCGm60XgzHvXQgUloHkfWUzJ01H0XPCLyk3l3G7VpHctLKi1Y6JEMm2YQ1oZWBpLsQf9cnrH8X5Dlnv3cfI9FiD5Uds6qCf9V8K9oBvXSGBsQRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Wed, 3 Jan
 2024 18:58:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:58:24 +0000
Message-ID: <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
Date: Wed, 3 Jan 2024 13:58:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
To: Jay Cornwall <jay.cornwall@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ec82ef-bdf0-43a4-fef5-08dc0c8df68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hex/7oV+AbwvD3C3kzsyrATXNUlj4v5/Iikq0gXY9GEQt+AtqGmyjKe8thaV1ooF0JfgfyJjW0a2YM3cipOFeXXLFTR1NZmQZMFdweEZgaARIE/0wFYuNCEiE6OanCCcUvTFFyGgOZGbTgRpOX9fw9Y6cWUcq315PhqBX2PTbxUH81a2V79R59mrr0RvMhPx14beD9qd1SobR3hjaNSzd7j3+JcU6zorJKhwgLtuMY2M30EyADE03KJn+uiSvG029drp1SkwH2uSWx/ryD67Demc+QyLbpE3bViZHNwHNc0P5o9WKlRZ0QTMHGr1+WBFz5cEbkUhPuLFkjfRmI/rzYSBgaDt0i/q14MwoSg2G2JMtaOf0yZqECgZVFxWlhag65z6ejdeOtETpBCCZN00+EJVHVILW2OUkwYol5gG5ygfbiQBo3gvb8s//OHC2iy/Q4yf8xa3DegyvIU254y3sYl9IxvIFmAtFPVLxlit/Isn/ERScs7+1V/YQNat/hfag/JxeuAg8IFYYisOKWksi+00zOPA+CKpbMWnp0RTvfg1WBMaVZWwMj0YHCO1sq9NiwPSlIZ54SpB71cfqRDN61vKEUN2F/YHyc4+ewXskRiURjL21pzle+LryQQtFqZ+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(26005)(66574015)(2616005)(6506007)(53546011)(36916002)(5660300002)(4326008)(8936002)(41300700001)(44832011)(2906002)(83380400001)(110136005)(6486002)(478600001)(66476007)(966005)(66556008)(66946007)(316002)(8676002)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUs1dnJzVzBXT0lwbysvR2dqbHRiL1JrUGNMWVBXdnpkOUVyZW9ZT3AvckNy?=
 =?utf-8?B?ZlVVL0dxcTlNWTBEc2ZrdkZXMEdyWC9JSXRkaXRXRGUvZFdpOWhRMzZzb2pH?=
 =?utf-8?B?eW5xaXBNUElFMmlJd3FCV0daWmZvek56ejdNTEl1YytSRDlJdmFnYUpyNDAw?=
 =?utf-8?B?TGxCakt2aCszbVhUNGtpSGJqZm5mTmYzQ0tjWXFKMzd6RlFzejJlRnpjZnJ2?=
 =?utf-8?B?cUpEelZiMTRabExrLy9qL1NweWxXLzBTUE51WHhkeDljaG5saStVOG1jTDRS?=
 =?utf-8?B?NFc3elY0aUJFYWxlTnJWMFFocFdNMEhZQWtRRnVPSEZjYm0xRDBPRDZVTFRy?=
 =?utf-8?B?Ukp5Zk1Jcjd6cU5mRDJaaDVZYnRpVWhlbzdMQ0gvTGhMaTJXaEZIbGdibjNo?=
 =?utf-8?B?b25yMlVIWlpuK2ZMRmhGT0pQSmtMWTNKU29vTUwyVzVDdkR6UnNmMXA1dXNW?=
 =?utf-8?B?YlA1YmNQaDdqbTZDOFppaWdEbGFRVUNhMS9jQTF5T3hNYWV3SVI0TjdKTk04?=
 =?utf-8?B?ZnJIYTdBQ3lLT0xBRUJ5SisxQlFVNGt3dFBVYVZHclV1T0wyOTFkUG1xaHo0?=
 =?utf-8?B?WVF1K2VqM2hVS0dhcVBOZUpMclAwWE5rMUtRcWU4UndlQ0hSMThnQlpoUVhP?=
 =?utf-8?B?Sk1KeU5WWmJsV0c1Z1cxY3paWWhOUGpxRU9LUnY0Y3FEeG41WXZLbTd4ZHhy?=
 =?utf-8?B?b1hTSEJ5K3o0azJBWElSTmtWRzI1NE9jSllyb3NJcHNOS0ZYdlRQZ0gxb3Z0?=
 =?utf-8?B?ajFjdmZONmtuT1dPWnJ3U1lRVHFEdzViM3l4SFNDWkEvTWQxZVc1V01CT3Z5?=
 =?utf-8?B?bUQ3OVRpL29zWVVYcFhjN01ueU5naXhVMXlCQWR2bFlBRHovbjhmdEtlNzZE?=
 =?utf-8?B?cTlNMzBiV1c1Vlp1MXFhM2FwbjhxQ2lKY3ZhR1NLZ2dyOGdvenFyUXRJWmRR?=
 =?utf-8?B?VWxDdVJLZlprZ3BxYnBYdzAyY2pORmJmMkhhRzdycEpHd1BnYm1ManRvZms3?=
 =?utf-8?B?eWZqbk81azBUaVEybEVtTHhWc3pDcFNDRjY5akt4Zm5HMkJwcWtLWXRuTmJz?=
 =?utf-8?B?WGxvRTdGQ0dDSytUWU54UWFpS3FIZGhvcm5RM2l1TVRtQnU1aTcyUWhKYU9n?=
 =?utf-8?B?aGNNOHAwR2IzNnZnU3NLSTBjVDRuRVgzUE1TVHBMeDRTVTZxc0h2NmlhalJs?=
 =?utf-8?B?MVJlWTBtQXB0cVlyWUFLaGdSbm9leUtvR2UyK2xES01nOTlLS21qTEdST0pF?=
 =?utf-8?B?RWRaMHNMZ1NSYmZVVzBZbm8yakoxZFlPaWNqQVp4ekdzUDcrUmNKWDA1VWYy?=
 =?utf-8?B?RVA0aldFclF0V3VVYXBQTGxOQm5BaG9hOFNGd2JJOFJTZjFaTGZqaFYrVkVu?=
 =?utf-8?B?UnIwNTI4cFV6bmkzQm91MU5ZUmFxbGY1YXIwMmNqVmtPN0lxL0ZHQm92bFBu?=
 =?utf-8?B?SVVWR2tQeUh5WHgyQVJCa3V0eHUxRERaalV5d3NSSE8wWnpRWE9pbkl2WTNr?=
 =?utf-8?B?dzF5K1Y1M1RSU2dkRUlzdUJYR2g0TTZ5WWY0MmVKNHJXRi9QWno3TEt0YU9E?=
 =?utf-8?B?bHdyVkhDQU1oTEwxYkZreFZTblc2aEw3V0MyVHFrL0xSNFR3K3daVVd2aWFD?=
 =?utf-8?B?TTRuMENnK1VwVklZdkY1RXgxQUpZSEtFVjl0Q0lDcGhodzBMOUxDUktWSHI4?=
 =?utf-8?B?Uyt4YjNGbTBzdHZvZmQyRXFtOTU0NjRnbU9kekpSTWY1ZzhtbWRZbTlWekhI?=
 =?utf-8?B?Wmc0T2NZc3ZYQVZrZXdoejRBT2g2OUoyRHBUQXR1WlRGMzF4WklGSUhBV0xv?=
 =?utf-8?B?Y1o0Y3BOOEdncDhralV5ck5oY1JRZUkrRTdXa0I4eW55cG85UlVIOFV4dnFJ?=
 =?utf-8?B?OHZsRHVkRFlvMGcrZFZZVEdpcDNJSTJSMkpiUjN6OSs1WEJRaDM4aThneUxU?=
 =?utf-8?B?RVRPcG03OXVYajdDYitjTzE1S2szdWlHTUxQUTZKVzRCdkNOR1hHMVlHeU9t?=
 =?utf-8?B?bTdya0FiZEZncDJDRmtMdG12aWFXT0RZeDA3WGlvb0poTzAzNVBSSlVEWUlE?=
 =?utf-8?B?SnF4bnJ6UnpqYWxyc3dzYXNJVmdobStiZG1uU1hOTUtobjlzSmh3dzRDNGRY?=
 =?utf-8?Q?MEXNuqggTu4DOEPcTFkHtm1ht?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec82ef-bdf0-43a4-fef5-08dc0c8df68b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 18:58:24.7659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4d+h6B2fS+GBRhtSjdvrn1kP76hzgCD/8vLYSJjKhUl3JGj5lHp/uTP6xIXH5WJEwJGMa/lPIMnni+o1X0fuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-03 10:32, Jay Cornwall wrote:
> On 1/3/2024 09:19, Alex Deucher wrote:
>> + Jay, Felix
>>
>> On Wed, Jan 3, 2024 at 5:16 AM Kaibo Ma <ent3rm4n@gmail.com> wrote:
>>> That commit causes NULL pointer dereferences in dmesgs when
>>> running applications using ROCm, including clinfo, blender,
>>> and PyTorch, since v6.6.1. Revert it to fix blender again.
>>>
>>> This reverts commit 96c211f1f9ef82183493f4ceed4e347b52849149.
>>>
>>> Closes: https://github.com/ROCm/ROCm/issues/2596
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2991
>>> Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 26 ++++++++++----------
>>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> index 62b205dac..6604a3f99 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> @@ -330,12 +330,6 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>>>          pdd->gpuvm_limit =
>>>                  pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>
>>> -       /* dGPUs: the reserved space for kernel
>>> -        * before SVM
>>> -        */
>>> -       pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>> -       pdd->qpd.ib_base = SVM_IB_BASE;
>>> -
>>>          pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>>          pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>>   }
>>> @@ -345,18 +339,18 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
>>>          pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>>          pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>>
>>> -       pdd->gpuvm_base = PAGE_SIZE;
>>> +        /* Raven needs SVM to support graphic handle, etc. Leave the small
>>> +         * reserved space before SVM on Raven as well, even though we don't
>>> +         * have to.
>>> +         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
>>> +         * are used in Thunk to reserve SVM.
>>> +         */
>>> +        pdd->gpuvm_base = SVM_USER_BASE;
>>>          pdd->gpuvm_limit =
>>>                  pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>
>>>          pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>>          pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>> -
>>> -       /*
>>> -        * Place TBA/TMA on opposite side of VM hole to prevent
>>> -        * stray faults from triggering SVM on these pages.
>>> -        */
>>> -       pdd->qpd.cwsr_base = pdd->dev->kfd->shared_resources.gpuvm_size;
>>>   }
>>>
>>>   int kfd_init_apertures(struct kfd_process *process)
>>> @@ -413,6 +407,12 @@ int kfd_init_apertures(struct kfd_process *process)
>>>                                          return -EINVAL;
>>>                                  }
>>>                          }
>>> +
>>> +                        /* dGPUs: the reserved space for kernel
>>> +                         * before SVM
>>> +                         */
>>> +                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>> +                        pdd->qpd.ib_base = SVM_IB_BASE;
>>>                  }
>>>
>>>                  dev_dbg(kfd_device, "node id %u\n", id);
>>> --
>>> 2.42.0
>>>
> I saw a segfault issue in Mesa yesterday. Not sure about the others, but I don't know how to make this change while compatibility with older UMDs.

A segfault in Mesa seems to be a different issue from what's mentioned 
in the commit message. I'd let Christian or Marek comment on 
compatibility with graphics UMDs. I'm not sure why this patch would 
affect them at all.

Looking at the logs in the tickets, it looks like a fence reference 
counting error. I don't see how Jay's patch could have caused that. I 
made another change in that code recently that could make a difference 
for this issue:

    commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
    Author: Felix Kuehling <Felix.Kuehling@amd.com>
    Date:   Fri Oct 27 18:21:55 2023 -0400

         drm/amdkfd: Run restore_workers on freezable WQs

         Make restore workers freezable so we don't have to explicitly
    flush them
         in suspend and GPU reset code paths, and we don't accidentally
    try to
         restore BOs while the GPU is suspended. Not having to flush
    restore_work
         also helps avoid lock/fence dependencies in the GPU reset case
    where we're
         not allowed to wait for fences.

         A side effect of this is, that we can now have multiple
    concurrent threads
         trying to signal the same eviction fence. Rework eviction fence
    signaling
         and replacement to account for that.

         The GPU reset path can no longer rely on restore_process_worker
    to resume
         queues because evict/restore workers can run independently of
    it. Instead
         call a new restore_process_helper directly.

         This is an RFC and request for testing.

         v2:
         - Reworked eviction fence signaling
         - Introduced restore_process_helper

         v3:
         - Handle unsignaled eviction fences in restore_process_bos

         Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
         Acked-by: Christian König <christian.koenig@amd.com>
         Tested-by: Emily Deng <Emily.Deng@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


FWIW, I built a plain 6.6 kernel, and was not able to reproduce the 
crash with some simple tests.

Regards,
   Felix


>
> So I agree, let's revert it.
>
> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
