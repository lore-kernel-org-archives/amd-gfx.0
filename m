Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCAEC7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 14:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EA210E028;
	Fri,  2 Jun 2023 14:55:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B8A10E028
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 14:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6jKwCyqaSgI04UU/74msaubLH/KpRQpNKtZe9te+vsSqFVtxcXJZvVyTL/OtsWGp/nZ8+PBg6683yZLPWq2RK8IBrWSAYrBsU25Wx59C6nqlzDuGZZn7FGLN1mZjKMlcro2TFs8gERoMnHHqgwgD6FjWPuVriCVPAfs1xbDemiPOXwVlbBSYyWzDJ6Y7LhJscLCrBdyllzYNQEduK3b/AnR7F7GTiMminUVB5LTg5xGkzEvJpw3itj3n3ZsYdxulWukTwacdihMPl+H33I7l74ecIYM+OmN42YzPTk/H25ly/PslV40qkYscZNIoeSagExyuyzkXDhUCrZA1fRPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zbZAHzj47sBti+iwFDzZz+OLuC41FODfkbLiSEi954=;
 b=fnU4e+reqoZsUIzzNC//IiRkpDL48DP0QGPbhc1JJvg4JGYiEH0gY8Am2TKJhuDMjlRQmvP6yFBLeNOAE9SL5FB03EojydHm+Ak3n3B5UwolbmEENC2Bnmr7EhxK7455FtEY1bVDU0iG7Ky/dt1rMmAsZ7s0HMUk4o9YQZI+hqH4FhZj2O442viL/MKJT2iS50M8xTIQucRTH2bct/DZ1ZatUCxKk3x8IAyEetKrp9LnA0Rsk9CDbvqu8IH3/0cZMOIZ6iAFGV4Oq2KdvHB4CNugBcesDkZ0JIFOMKMdFY8+kzanrnYBRmtqNaOx2//gBUZeZZpWJ66nBg6Gsdl8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zbZAHzj47sBti+iwFDzZz+OLuC41FODfkbLiSEi954=;
 b=a+BNJPGX8PEU9uIcQzhvAd7jPimtDD7UJveEGaoTNZw97ukyN9zHYlqmluymN+TMvhqdlbHIKAC2iIBfU5mc74tP0pteAlOkpOwRTLMdvTxWhOB3NGAY+48OPvM/oeNkq+Dl4RMOsvF39K89+ir9tQMIC0td7Fxg7pDOx1V0u2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 14:54:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 14:54:57 +0000
Message-ID: <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
Date: Fri, 2 Jun 2023 10:54:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
 <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0293.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 57320473-8314-4ab6-a68d-08db637954dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI+z+FQZ1lXbbbzutkCHlqbMkcORu9yPNm6RAInBl8SPR3NtzUUYOoMAuI0NdbPJLdx/8jF1vmeUE0aenxk3CQEJrEUh6IW/QWzRDYbBr7f38xAXYSCWA3KoSM7Cvl7MMfiEh3CCkse1ulPMNOPOZZRL32N463R6ZL2Zcx20aNhfka170AHdzFs0E/CoEcXqzCKR4U+0M7IVN0jKoE5I54JE9qhCUlqwpvzoag5aC7nnBwV7RrrG+4lwoQgP1SBnkDPWqzNqgHkyP/B/PpCTO0P/p7i5n+9Gphuml7/JCcFq/5U76sgwTgDxbwc9nBMFgL7iFQKMMwCMCllqdYQujeLYzLstUTukB5qeyNEcZz8T3YjTf6Qmo0kPsQgaY4rcjKswwDj/xTDVs32M9BLoUvqc0IckPB97pY0cEDfmOKvjRjchnPsMidRzkn9zoLw1RAr9KnQEx+QmeeckQdVbfn3A/x/TjTnHsvjB83EKAmDz+VzPqqZhTM0H66fUhCRckFUdvBIzaicUmobl9T0HvmhQr+dacXWWe8xXw1cYOSU9ihZ7NbCSqly5KEGYQ6lFPKgg1qVzcxvpmhTa/4zRgsF4VWW/ZUf+Fc1evHjNqzQ+CJzOQQSaqQ+JhiEa+G6YNcPRe0mjq09QWxt0TP91wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(66556008)(66476007)(6486002)(6506007)(6512007)(26005)(478600001)(2616005)(186003)(86362001)(2906002)(110136005)(5660300002)(8936002)(31696002)(44832011)(8676002)(36756003)(41300700001)(66946007)(6636002)(38100700002)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhraEVFbytlNFVkVzFiaGtGNERSZmdMOGR6ZW5NVmRSVW14cEZ3T1gxRzdC?=
 =?utf-8?B?eTV5N2c4NkJYaFJNcWZRVHZEejJFRExNbmRuMkxoQm9tSlZVbkREc01FQ2tI?=
 =?utf-8?B?TUVoaDZ6TS94by9mVHFROTRVSldNNnFxT3hMNEVLd0ZxdVFDdHRVbGhEckZQ?=
 =?utf-8?B?K3E5d004N1ZEaDBEai9mQlozdDUvZEdaUy93T0lwTUpRVVZNSGQrZzViY0cy?=
 =?utf-8?B?b3MvMXhydFBuRW5OR2R3Y0t3T0I1TU9kUTVFQnNHMDdza1dwbGFkWWhFaUQx?=
 =?utf-8?B?TDZRQ2hhcm9wVDRQMkc3blN5V3MxZTN4czk5bnQvQmhoanIwYXoycVEwUlVY?=
 =?utf-8?B?Yld1TUxTbzljK0VXZGtSTGZOd29QcGZJTGVLL0k3RWZ0VnZkWWJDdUxjMnU1?=
 =?utf-8?B?NXhPRVVEdXNaWGlrcGZnRjJLV3NNaGlwbldQRXBCeTd3QUFoL3FGWFRpRUVy?=
 =?utf-8?B?N1NONmNWelVLTm1oMnlUMk5RUGN5KzBZQTFINEZvbzlSbTRGMlFHNEFBWEJt?=
 =?utf-8?B?RTUzenZVdDNZNnQrRUxJWVRVcTFCcUdwREh2WG5QQzQxdUJrTjMvM2UwcCtx?=
 =?utf-8?B?Z0gvc1VvTiszakhaRk96UTNsL0E3WXh1TnE5OUpKSnYwN2plV1JvblM1ZTZ1?=
 =?utf-8?B?ZGxQU05BZDREMHIzSFVjQ2xMd0NJaHNzTVplNXlkcnkvOEY1Z0VYckNKNkZ6?=
 =?utf-8?B?WkVZdVRqRVBadURRRFJvTEFiSzgrVXp1ZjhKUm9Ub3NyQSsvZXU3cVdWbG41?=
 =?utf-8?B?ZlFtY1VWMTgrem4ydXAzQkR4eXA0dHBEOTdpT281RTNTSTdkRjdxMlhXZGE5?=
 =?utf-8?B?ZmNEVFk0U1BiMTNRYmFaSzZ2SndCL2plOXkwcUtPTHpTODVOWE1JVi91Vlh3?=
 =?utf-8?B?R2tLZVpML2pNbVNMSmUzM0wxU0I4V1Z4QWlrbEtIbFpqRDU2WldOSUVaTE9M?=
 =?utf-8?B?VGdHS2dWcE5pMlpBVUppVGp3aEp3MWJKaUpXeEE4aVdYQkNaSzhYZHFFN0ZX?=
 =?utf-8?B?QzBheDdaakN1SHFaSFArMW9QY3hoQzNHVFc2dXBkcUsyMUFGc0tBK2FGUjFC?=
 =?utf-8?B?dmhyNDlBTnEyakNhTDh1dzZ3VDFlV095RDNDSTlBbjNxVjNxbkxBS2F4bXNF?=
 =?utf-8?B?M09tNkpmcEdoVGNKelYzc05FdUdTenZSUk1GdWJGZGFSOWRXZkU3YXVxQ2Fq?=
 =?utf-8?B?d2hNa1hCa0ZMSlJrZXVTaGNXY2Q0K09UTnJuQWZUN1pSU0lEYy9nZUl4c2JS?=
 =?utf-8?B?N0hQOXRXNmxwQjdWdnc2d20rSStCaW1QaVVyaC9aUWhNWmJkOU1hbU1wczRl?=
 =?utf-8?B?SW54TmszZXRaOWw1NHcyMnBFa0hSM3pSc2pvalJJVHBsQ29uTlZzWnpVbWFJ?=
 =?utf-8?B?OFhadkhHS0JtMzlwLzNVU2lYNERxbm1JZkRlVWMxUGZhcHBPdnZYSUxPMnB1?=
 =?utf-8?B?bUkvNXZUbW8rT2lNQS85QkRueStUQ0ZmM1FONEdrblhnRnNyaUM1QjFBRFZs?=
 =?utf-8?B?YVViU3l5YVNheEhpdFh3cjhSQVpOMW5MU1dMeVZwazkybVRMWVd1b01Vcmhx?=
 =?utf-8?B?RUhLTHFvbjQvK3lQTnZlQ2RuSGZuRFp5bm4wbGd3TTVoSEQwSFRodCt3YlJn?=
 =?utf-8?B?ZHJEL05abTJGSXMzTjA5Z2ZidEtsWEE1Wm9vY0RaT2V6UWhVeXBYaHBFRjZq?=
 =?utf-8?B?Ym9SaldJMXovdEtGbzBiUWtISHV6cGIycFh0bnBxc0E4UXNPSHlzOUY1c2Qy?=
 =?utf-8?B?KzQ2dGpiZ0xGL1dTNWZYVG44c1VDVVpvOUl6OGRvdnNIVWhYTjZPQXZQUGtL?=
 =?utf-8?B?TFI4MnNnUFlyWjFQM2QrV1ZCNFRZb1ErTW81RTI0STNacVg4SGFQS0JvbHV6?=
 =?utf-8?B?ODQ4dklsRlNmNkg0VHBJZ0ltNlFxcm5JY0FaTEh3bmhVNzdxbnpHU2VFME91?=
 =?utf-8?B?QVFScHBUdTFnV2h6WFlMUGJyVStVREJhNDZSMnE0RWowRGZ1SEJIK0VueTY1?=
 =?utf-8?B?VEljNEs2cklGNnc4OVkxcDV1ellsQmpiMUJsR3hidVNqUkhBcVdCci92WGtz?=
 =?utf-8?B?S0dqd01IUzZUNmRlREVnTDJMV2l4TTV1emZWNVVoWmNjSjA3aEhNdHprQitX?=
 =?utf-8?Q?qaMVQjQG6gVEEmBlg8aYV6fwo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57320473-8314-4ab6-a68d-08db637954dc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 14:54:57.0797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGQMj36HDwbukmzjS3UuF66a7V4/vOmVvOOBur9S5b1o8ObOeckGJItsgcX5TqhG1BSlhVXCTRHj7OCSHcTRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

Am 2023-06-02 um 07:57 schrieb Christian König:
> Am 01.06.23 um 21:31 schrieb Philip Yang:
>> To free page table BOs which are freed when updating page table, for
>> example PTE BOs when PDE0 used as PTE.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index af0a4b5257cc..0ff007a74d03 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct kfd_process_device 
>> *pdd, enum TLB_FLUSH_TYPE type)
>>               amdgpu_amdkfd_flush_gpu_tlb_pasid(
>>                   dev->adev, pdd->process->pasid, type, xcc);
>>       }
>> +
>> +    /* Signal page table fence to free page table BOs */
>> +    dma_fence_signal(vm->pt_fence);
>
> That's not something you can do here.
>
> Signaling a fence can never depend on anything except for hardware 
> work. In other words dma_fence_signal() is supposed to be called only 
> from interrupt context!

We are signaling eviction fences from normal user context, too. There is 
no practical way to put this into an interrupt handler when the TLB 
flush is being done synchronously on a user thread. We have to do this 
in such a context for user mode queues.

Regards,
   Felix


>
> What we can to is to put the TLB flushing into an irq worker or work 
> item and let the signaling happen from there.
>
> Amar and Shashank are already working on this, I strongly suggest to 
> sync up with them.
>
> Regards,
> Christian.
>
>> +    dma_fence_put(vm->pt_fence);
>> +    vm->pt_fence = amdgpu_pt_fence_create();
>>   }
>>     struct kfd_process_device *kfd_process_device_data_by_id(struct 
>> kfd_process *p, uint32_t gpu_id)
>
