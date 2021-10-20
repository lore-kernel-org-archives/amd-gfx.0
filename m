Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F228EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EA161361
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4EA161361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F12589DB9;
	Wed, 20 Oct 2021 10:04:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8825E89DB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlT6b7LGpK3skYTxJBDvqQ7BOT82qrbrNliFSMMITxOYKgtJVQRLZwg8rwarTr3/MgLmKwG13LX+ws5XGpdBycTBi1QsIYfNfg1yYSqZJM7H05qWncu/WluOQKla6+nhJ/ZXnzDs9KbQed3DnkbBKs62tYQlnHHMvl548UPiytpvoqiSFoIaEjznS86g7NOUB09YI4tjQZDQHqGMRjsg6o7dgsvGWy1bNdIfbnATVBPWpZ2Bc6//5ZxAbROtzX1iOGH4qMfqhDHgbbBgvnM2g8eCivPSuGYNl5obYiMjhNWZoiqfQkcynRefNRq/WP2iPS6qAzje09RXdDPgWdVopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLrFqVjEBYj/TA4oCUxmvNmun3ZkAbvRTBXVQVn9BU8=;
 b=ZXxbLMFvxLJev0G+C4coKW38rS9xpoW71QdU0TY35ak37pBdpOOrf7GCEi2768NlKfFxyWqOJFYohmAAxN+n3bvH+1AcKhoCxkHLOCkPKo9j2Ifx8Gu2VWuvjk+Uo5lPrPu3Q3CNJ0VOQwFIpWb2Hayu3AvG00bSHU7FLZCE6q6ufBSYNA7xpZrXZuMfThpFkuEecenJ6eDxhwvm8AMfl6U3z0Co0GWrxWv/f4MOz55VZ8sqZwjiZBYuL0IyOTieIfUfIu/RH++j0tVzGOCDsQQVbVkzcJKJXKgO+rMwgswfyFWSMdsrPTzI3FCYy9/prlozg7OmFvIX+23VDSnbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLrFqVjEBYj/TA4oCUxmvNmun3ZkAbvRTBXVQVn9BU8=;
 b=LzmKC3s97FFS/TiwZ+3LrWP+mXYYOUr/IfW0Fslh3N9BQEas17C+bgiPrdCpz5BZAHb3z6EWW15F8/ekdYAruEfePQL9Lje1ELUI0hmvoudS9BMRBXMCOyVpbpfdZ5Ajm2msZVIuyWrx4853Fk8/iOQXAXlOMyB37MPSj9I8jAQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Wed, 20 Oct 2021 10:04:02 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 10:04:02 +0000
Message-ID: <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
Date: Wed, 20 Oct 2021 15:33:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
 <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:96::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17 via Frontend Transport; Wed, 20 Oct 2021 10:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b933d2-5db9-489d-75c7-08d993b0f11f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548ABA4DA00BBAC90AB337E97BE9@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWCX0lgcdY8zjuLSFbFc0At1LYQhYVxvguEm9ffHMiKNh8xR21k4R/Dxl8W1ldNt28rnK9e791HQDu0hqz23c8xW6BYAux0hi/Z27nvbP/aQjgZE1ZM0vLmhXs0B7eaTI/DSNO1nlsSo9VwgZ5+Tq4bN4MPadrflGvTJOGCPR4tiWu4kcpxTgl124vX2KpL5Xc1AWQkyGlTWU+W8l76dzs0qthTQ4rXnUjW3IXbaGqmwdmeVR9SbLeVZyyjnBU6xpYP6e/e25BH4JYvdy6mfvL6hLNveH8g/jb1KwEk4Dwr0HSEIGsqlGNxbCQwyp3svw9m8LeNkZKLXxF5H6VoXKV/YwMIfkcq6+sxhEXi9HCQdbZRHQ/gdajXtivYFc11hDhG46p6FfECShFoXLIrGWL1YkOHlnGTNoWjOGpzOSqhMhZX5B8ETb00Z2G+S3fc9aMt9nUHm3PeGK0uzowFf5eqaW+ucd8Eb6yvdLZ5RDnwCtBX74haYZTHsY2M4V/iXO7xsVPNaqk+lnzjDzr665A2IhYxV/7EzoNRKHw76yCD03VvLs2Xh7OgAWCXHKifUs6dJlmDthQqnp5WQwPfMtwRQyX89/Ug1rxm1gKV/H0x8RyvvTFtMILUYZmH+oIK2KaQy8KwS0pHafxdWT2rY5CAhMrxky286i2YtRHhuw+iq0Dj7pO2HZXUHJhVLuK6VJvlr4/9beSUE+bVOGlRcSGRB071uTwysAAOT++gwrwaNZrZKqW//7FmQFDYLS+rA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(6486002)(316002)(31686004)(26005)(36756003)(5660300002)(186003)(66946007)(66476007)(66556008)(6666004)(83380400001)(8936002)(508600001)(2906002)(53546011)(2616005)(4326008)(8676002)(38100700002)(86362001)(31696002)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkk1ZVZicWdDN21lUFV0ck9sQXpaYkZGWUVRbFZuVzkzQkRia2RoNzczTkh4?=
 =?utf-8?B?ejY5bU9ldXU3ZGxYbXZhSHg0ZkZOVEtSRDlXQzRBUFYwQ2RoeVNjcUhMN2VR?=
 =?utf-8?B?clBwbHVoRXhoWFhuMXNHYmNEZ0hLRmNJUThPblRHVzIzUm1ocUFjdnp2RlhT?=
 =?utf-8?B?blVxejNOUC8yRWkvN2JkUkRtMmRlbndRZlA5TlBtMTZRbWNtQkpZOFBOYS9I?=
 =?utf-8?B?ZEJnSVc3WmRNY0ttSEIwUjVLYk1zUTFhQjljbWowd0V2Wm5uam52RTBuWGZ5?=
 =?utf-8?B?cStqSGFRa3pIeEY2djNVTFRNaHU1UUFzbGkwdDZTWHBCbUJxcWpSNDBXUm1N?=
 =?utf-8?B?RFh2Q0ovd3JSeHB6bHVlNXZUZTNlbFUzaWdCeVBYRFpVT2Jta1MzMHVtNGk4?=
 =?utf-8?B?NVRiTWVzU1V5d3V4VzJNTmZGVWNheUpSSlovZk82R2t6dGs2a1pEaXdkV0Ra?=
 =?utf-8?B?dlYzVWhVcmxoQzMyNmVkcHR4TWlhWC95TzVlRlRaenlDamtPWGYrNTFDanNZ?=
 =?utf-8?B?QmY3cDlzYVdRc3FvNkMyTWZWSU1KdVRTRmdNMkJJZWUzTlRkQzJlMldQWm1U?=
 =?utf-8?B?cmQxYlBYRTBxUHBPY3RDYU1zdHRwVitKWHhRbGlrM3FGNXFqUXk3SkZlSmJF?=
 =?utf-8?B?Y2J4VlB4bGhxdU50djIxQldvSzY4aFA1bXVIMDh1cGh1TUlCODRHS0lvRVpF?=
 =?utf-8?B?TU0yTXk2T29DMmFwaGZNbUZhbjVITER2VTVPVlNXSnNNY1hrU1ZRZThyYTh0?=
 =?utf-8?B?dDhMTGxvOE9LeWFrYTRCK3ZnTXh0UCtQZDkyOE0yNFhwNENHQ295OVV2RGdk?=
 =?utf-8?B?MFhpYXJma2ZUUFlyWFNCRnY1T2NtMzVURS9lNUYyRmF6UG1zTjhrNWFyZGsx?=
 =?utf-8?B?YTVUOWpkeStqeUlPcFlFclhVTWFZUnpYdTUvWTlxdGFQeDIwYjcyZGRlQkxF?=
 =?utf-8?B?K0ZUd0JXdVE3ZXNSSk54b3A1Q2R5cGw4RG0wc20xRDlXc0ZwWm5TQ0VwN1RC?=
 =?utf-8?B?QjBCYkJRTC92ZnNJcGVTNmU0TVZjYWwwV2tYZDYzZzVHWW4xRkhLN0JLS3Zm?=
 =?utf-8?B?Z0cxOGwzSWQyd3dxdjVGTVFYMDF3RkE1MWxlSXZoa0lNVDRic3BDTW1mZ1Yx?=
 =?utf-8?B?TTlSTU9PL293cTNmQWpQQ25VdlZiRW1xUmFHSlYwcEVOcUJ1Z0JENDhqUmI3?=
 =?utf-8?B?a3FmZmVZRzZXY3U1a0lRZkU5LzZ5Nk84S1NudENRcC8ycTFhUU00blZJQTJX?=
 =?utf-8?B?YTQ0KythdFo4YUxuOC9RWlVuZ203c09sL1NPaGtQbmNMTzcwR1pkYUNsbWl3?=
 =?utf-8?B?WUhqQlFRZHg0NE5NaDE5c2pWUS93Zml6WWxvdkZ6aEN5eTQzMEpoTGxKcUpS?=
 =?utf-8?B?MGdWM0Q1UTBydDNnb2xJME5SZGxyenQ5c0xqajlLWEtyZXIxcG55a1p3UWtG?=
 =?utf-8?B?N29VVlFBc1ZWamJFaEt0NDRhVjJ2S3RlM1pMVnBQSlZOeEZZRWRiL2NhZS9k?=
 =?utf-8?B?M2FwMXNkNjMxTHdmbFZlZ2J2TE9kVldSeEUrNjltZEJZaXNSZGpoeGx5Sk03?=
 =?utf-8?B?TjFCZmdNVzdmQWtBb1A4c29hVnRkUmltSWt4OWNUQWdEbTlBODF4ZUZXNURF?=
 =?utf-8?B?QlYrK1kvNCtWaWVyZzBjVXJwQkR4RFNqbEI1a2ZLMGErS2VrdmYzRU5Ic1VT?=
 =?utf-8?B?YUhCM0hKc1RFQTZtQnVVOW1kQlRwZjNHdFRnL29MTDVPM2JzR0hpUW82K3hC?=
 =?utf-8?Q?sQdybK6LKmmd6p7FQgE+pMg7Z7z7QuAdWp71aBE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b933d2-5db9-489d-75c7-08d993b0f11f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:04:02.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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



On 10/20/2021 3:23 PM, Das, Nirmoy wrote:
> 
> On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>>
>>
>> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
>>> Get rid off pin/unpin of gart BO at resume/suspend and
>>> instead pin only once and try to recover gart content
>>> at resume time. This is much more stable in case there
>>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>>> while evicting GART table.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 ++++++++++++----------
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 5807df52031c..f69e613805db 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>>> *dev, bool fbcon)
>>>       amdgpu_fence_driver_hw_fini(adev);
>>>
>>>       amdgpu_device_ip_suspend_phase2(adev);
>>> -    /* This second call to evict device resources is to evict
>>> -     * the gart page table using the CPU.
>>> -     */
>>> -    amdgpu_device_evict_resources(adev);
>>>
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> index d3e4203f6217..97a9f61fa106 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>>> amdgpu_device *adev)
>>>    *
>>>    * @adev: amdgpu_device pointer
>>>    *
>>> - * Allocate video memory for GART page table
>>> + * Allocate and pin video memory for GART page table
>>>    * (pcie r4xx, r5xx+).  These asics require the
>>>    * gart table to be in video memory.
>>>    * Returns 0 for success, error for failure.
>>>    */
>>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>>   {
>>> +    struct amdgpu_bo_param bp;
>>>       int r;
>>>
>>> -    if (adev->gart.bo == NULL) {
>>> -        struct amdgpu_bo_param bp;
>>> -
>>> -        memset(&bp, 0, sizeof(bp));
>>> -        bp.size = adev->gart.table_size;
>>> -        bp.byte_align = PAGE_SIZE;
>>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>> -        bp.type = ttm_bo_type_kernel;
>>> -        bp.resv = NULL;
>>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>> -
>>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>> -        if (r) {
>>> -            return r;
>>> -        }
>>> -    }
>>> +    if (adev->gart.bo != NULL)
>>> +        return 0;
>>> +
>>> +    memset(&bp, 0, sizeof(bp));
>>> +    bp.size = adev->gart.table_size;
>>> +    bp.byte_align = PAGE_SIZE;
>>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>> +    bp.type = ttm_bo_type_kernel;
>>> +    bp.resv = NULL;
>>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>> +
>>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    r = amdgpu_gart_table_vram_pin(adev);
>>> +    if (r)
>>> +        return r;
>>> +
>>>       return 0;
>>>   }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           return -EINVAL;
>>>       }
>>>
>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +    if (adev->in_suspend) {
>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>
>> When the existing usage of this function is checked, this is called 
>> during reset recovery after ip resume phase1. Can't the same thing be 
>> done in ip_resume() to place this after phase1 resume instead of 
>> repeating in every IP version?
> 
> 
> Placing amdgpu_gtt_mgr_recover() after phase1 generally works but 
> gmc_v10_0_gart_enable() seems to be correct  place  to do this
> 
> gart specific work.
> 

I see. In that case probably the patch needs to change other call places 
also as this step is already taken care in gart enable.

Thanks,
Lijo

> 
> Regards,
> 
> Nirmoy
> 
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>
>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>       if (r)
>>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>   {
>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>       adev->mmhub.funcs->gart_disable(adev);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>
>>>   static int gmc_v10_0_hw_fini(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 0a50fdaced7e..02e90d9443c1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>           return -EINVAL;
>>>       }
>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +
>>> +    if (adev->in_suspend) {
>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>
>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>
>>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>       WREG32(mmVM_L2_CNTL2, 0);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 492ebed2915b..dc2577e37688 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>           return -EINVAL;
>>>       }
>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +
>>> +    if (adev->in_suspend) {
>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>
>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>
>>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>       WREG32(mmVM_L2_CNTL2, 0);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index cb82404df534..732d91dbf449 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>           return -EINVAL;
>>>       }
>>>
>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>> -    if (r)
>>> -        return r;
>>> +    if (adev->in_suspend) {
>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>
>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>       if (r)
>>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>>> amdgpu_device *adev)
>>>   {
>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>       adev->mmhub.funcs->gart_disable(adev);
>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>   }
>>>
>>>   static int gmc_v9_0_hw_fini(void *handle)
>>> -- 
>>> 2.32.0
>>>
