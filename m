Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C2DEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 07:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F3910E3B5;
	Wed, 12 Jul 2023 07:57:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DCF10E3B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 07:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eprhLeFjVHwKCSuultkLv/kNnylA6KPVY+t8LVJbwzn1hDah0+f2Ma5+C1z0W7Cvt9iHDdX/RztcgD0dGJgS8LkVco30ZKliM7eWUHi5P0TGp4TeA28tZzGWttxFMvITsS5zv5x+9fyI6EcEWnwjHx5NOZyBbgjLnq0okFd4JsiyNfuSB/tx5gqw+yFahkdFr3Yks9ToHWpjqjwEg+xO7ZcUtIDbYUO2Fy/yDtd2zVRKnEvlZuCl/xW2+vwLQkYAY5TsLiuZNdnUWaH2wRW/LseBLPWCZoKML8w6UlwEGVNMzWSPsAorDaPj/5XTrWzGN5XZNPiwYfhlwW0ekiLozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbd7SSc3sv1sjyBZ11i11+AkCFnJk/twh5g4mLtJQkY=;
 b=FLV4hwUGD9Y6cAD4c3lQEbZtYhfYtirJ7y7Z7pm7DmVFsD4Y+SB6qpGI6tx7CcrU2LwMdv0vH7QMsmGbUJXklceRQFY9wecuJ+auiNQbjtTXor7nZUssljHFG2nm0dOKk3duoVhineWGNda5Ex6EJIOeQiA9atnk3og/F3t+o9Yz5SdZWq5auYfNGN2brynFdUMNQW1mHCpzFgNbMKgZEucZaoFYA68h/pmIAg63XF9k9rgcHz9u+zpkjef223280iu6KJutQrgjO7hP6z4yRW+rkimuQghhwsQDF4+cwFV5IoYIqoJFtW2xjLW5H00RudViih3cX+WXbBoKqgE+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbd7SSc3sv1sjyBZ11i11+AkCFnJk/twh5g4mLtJQkY=;
 b=LUBYSJmMLZHaNw80W9mSH4h0gdVEmF8RDPalDGdUsW+94JxQWM+BCbrgq7v21QsiepaKk2wOtZT0m2KiXZMozoPYWHyI1aoH827zKNG56M79Vh7MupL+Ov090ufxx0xgl1syFwT2NMnqKuS/FrBG+cFfAN72AgBZAVvdFlMdtYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.34; Wed, 12 Jul
 2023 07:57:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 07:57:35 +0000
Message-ID: <1dc3a6fb-3973-e6a7-519a-440fcfa5ee9f@amd.com>
Date: Wed, 12 Jul 2023 09:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Rename to amdgpu_vm_tlb_seq_struct
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20230712065821.260061-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230712065821.260061-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: a1940d2c-2af7-4081-dcd8-08db82ada783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmcQr1JC5cfzty8w7ftxJcaEHOGc1dl6MSJsrnDFMFaZJ8MqSEHxEzYZfeKsZRB2sUp9WKVTah24bxo11st5WShvCBTLUoYxcEIKprkBJhsyziDmIYrZtCslfWJ7DmDOhfsTSECtg1m/Y0w/7DlXkIN41x+YeRTIkOBa/hS+bmftB6kwuyYBxAuxe0vzZCHqve2tf1lVcX7ayjwiWrv2scllT5vlrHaIACGFCQClVqF0Q1HF4ecDD8TFwacl926M20MqcHNMPBAOb9GopF48Ewoclef/5/+QfoR836HOQGEciIXZsXkcxKJHY4qB80CKTTg8DGB5Acp/wRSclWT4vMMYp/Ui1jSpZGQxCpwheaNSh7KefZbl0N0UeMBtQlB+FRqnHGBzhPsZotXDLy+HqDXpqLf37e22IlTdFboCmpsT4wQbs+SwbIpLpz8y9MUMBegH24SJaKs5mixGW9CcvHD332ToJB3FrT93PjQBH0M7WjGq90PrzQRMMCSm9Fp2KGgCGcxvCPnNjBLl6JxJZqDXcS93BAqjpCCYnaGibmw6/JUP3Do32M3I6lEIEdgi3c0QENcBi06eYoT1m8Zg4EaHamquYuCA1w3tiaTU96EAu/+kMYOanQv1Bpa34k8bp+Fh4Vo8TzcIJ3weO+vlzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(6486002)(966005)(6512007)(6666004)(186003)(6506007)(66574015)(83380400001)(36756003)(2616005)(86362001)(31696002)(38100700002)(4326008)(66946007)(66556008)(66476007)(41300700001)(2906002)(316002)(31686004)(5660300002)(8676002)(8936002)(54906003)(110136005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dBa1VGU3BLL0hlM3ViYmU2UjRHRVJZalhkVkVLdFN1dkZTdWFzdkFpb2R0?=
 =?utf-8?B?YndVVDc5V3Rnc1JWNTNwYUFyUmN1bFI5NXVDZjJ2dDIreXRKcE1GcERIQ21N?=
 =?utf-8?B?OTVaS0VNWjkrbmFsRmZ4emNlYlRyTzhyYzZuNVJjWnFMeGI4Ulp5aFhSdFQr?=
 =?utf-8?B?eklhaDBmOERVVEpHL1E5V2lrTWlFUlEvR0hwa2ZseTkzckdiTVl2QnJ3VVlI?=
 =?utf-8?B?MjlPK2hXc0FhQURuN3NIeGpTbzNCbit0clZtSTVzeUZUdVppY01mU0FFdUZU?=
 =?utf-8?B?Mi9kZzFGZVRMcGg1NUYxalMzYTMzL05wOFlBNGh2d0VJTzBJa3gvMHdSU3M0?=
 =?utf-8?B?VW9qSzVBV3pBK0NEdmdIYVBxYkh4VndTaWVHbmRYOFZLVFFaaWNDM1pSYlRQ?=
 =?utf-8?B?QXhVOTFFNkl6V3lMMlRtV28rOFNrc1hYaHUvVmg2bHNxV2FPcmc2d3NLcyty?=
 =?utf-8?B?UzBhNmhlSENZVkxnWnlFOGZCZzJ0VmZLYUJGV2Y2a0QrNlB3eTFNSXZvWkl5?=
 =?utf-8?B?Z1VZL0RQZ0tTZkZUazduRkZubVNMd3FYTWVVdDJmQnBhZXpVVklJdzVwd01C?=
 =?utf-8?B?Yksza3I3ZXk3ZmMwZ1A3TDB6TzM1NDRHRThBSDJPZW53NElqSWlROG9PWHla?=
 =?utf-8?B?WjdZTzF4Y3I2bkVHdlJzVWxYQVR0a0dyRDFtWlNNRythZmw1NVBHSHBYUERF?=
 =?utf-8?B?U2RwTC82OCtyR3k4NWVKWVIwQ0VQZEVjdDdyM1ZZaldLL1Q3ZVllYU1tMTBj?=
 =?utf-8?B?UWE1WDY3RDdQSFlWNFdlOHJZSzBkWWRiWlBQR0J0eS8zRmZWckhvM21yL1Av?=
 =?utf-8?B?SzVIeU1PSlEwR2lnVlQ2SnJRR2h4RXVLdjRNNG8vdmt4RDZZRjNkRG9PSTVm?=
 =?utf-8?B?Sjdoa0M2Wm4rdHpqUS9TbytLT0hBenppQWlKZ0xGd053ejRmejhwWlhidUxN?=
 =?utf-8?B?VUlIcElvbmlweGttakpwb2NCTTJlVWR4Zi9MZU85eVkwUXJudWd0bjVYSDBD?=
 =?utf-8?B?Yk1rakE2QlhoOTJGeFdPeGJDdGZBSEFhQ1pxYWMwM1dLVjFVVHd0ek1oVDI4?=
 =?utf-8?B?NXBwekY5enRzelEvMjBHZ3d5QklZMnZZb05aUlVDclhGSlFiLzlYcjdpRnZk?=
 =?utf-8?B?RTg5NmtuVlpldExBdm5ML2RVTlpEVVRQS25oaW5sNWRTeUVYdXQxTEFWTWd3?=
 =?utf-8?B?MGxuc3FhalhDU0JUNzJ1aHNPekpMSld1V0tiRVhJb2h4c2hFV0RQelVmNlVi?=
 =?utf-8?B?U0Fla3RxWE52bElLT29MdTJ2cHVJdWdZRWdJMXdvYXVUY3VraG0wRENyRGxo?=
 =?utf-8?B?OUVhN0ZsMGgyQmlyTWdqanRQZFZEMlFjM3h4QnhFbDlHZ0RYYjdTU0JsTjlt?=
 =?utf-8?B?RnVMUE9RTlNzTE9XbEZKdUFpa3hRbDJyVklycnVPWDBieVEzQURQMEo1TWFp?=
 =?utf-8?B?bXE1WkhFQnJubmtQSCtvdERpaEk3dmxKa3prNlUxTjdQNWx1dVlNcVdYNjRa?=
 =?utf-8?B?QUlBdEgrNHBCcTFlYk9JTWdQZEF3R2Z5VUlGVFVaSlVlelQ2dTl1bXU3QWZK?=
 =?utf-8?B?OTVTcTlkMG1BeXVHYjB5OXB1d1luRGk2VWFqZFUrSVJUSlRtOXNZQVRxaHVi?=
 =?utf-8?B?eFRaZS9JeEJaNmprbmNnRCt6NGJnOG9JSlhxSEZpek0zcitPMkVTaW9LdnAv?=
 =?utf-8?B?UFNhejNlYWMrNXBWUzBPKzd3R1FtQmE2WWJ6YXRSUWxKZUdSVnFsYjFKaG8r?=
 =?utf-8?B?dlVITzl5emltV0lRRFI2NzFBM2Q0RXpWc1NScTN2eGhnSlE4SHNXamJ3MnRv?=
 =?utf-8?B?bVJPWXpFQlVBZ09oV0UvclpLMVJMc1h2Y29QNVVyWVJqSXhTQXpsMHYxTEln?=
 =?utf-8?B?Qml6OHZ1MW5DNTlnNHFOU2lVYTNaaFo1L2wvdlRqWjZIS0JOeExnWUVDMkk0?=
 =?utf-8?B?TFdKdVdlNUVrM1AvVUxscFZsY2QvZUQ3NDVZV1Y0NzFteUdJOXdHMjR0cDdT?=
 =?utf-8?B?S3N0TEZtZk1EWkZycUs5aSt2NVhCWFJCOXlNN295NzhUSTQzbnpwVGpERnl0?=
 =?utf-8?B?Tjg4ZzhsN0s3SkZNYW9OM3k0cEt3bWluV3ZFekFXNi9HcFVDYTlrNllCdFZm?=
 =?utf-8?B?Q2VtdmxMcDkwVzUzSkw5THF0TnZJQ0U3Q0MrdHZ0MDVrUk5vSU84TzkrZzFS?=
 =?utf-8?Q?JsAqwNXafNMtN3cPwhAqqhZTnXArMavG/LvnLuVwldQH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1940d2c-2af7-4081-dcd8-08db82ada783
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:57:35.7440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAgtjEEU35CKPoBfRyppCqfhBtnuEFPJS9//WuChtLkn2pwIR2zrR6BrTiGJxypz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.07.23 um 08:58 schrieb Luben Tuikov:
> Rename struct amdgpu_vm_tlb_seq_cb {...} to struct amdgpu_vm_tlb_seq_struct
> {...}, so as to not conflict with documentation processing tools. Of course, C
> has no problem with this.

Hui? What exactly is duplicated here? Is the structure defined in 
different files with a different meaning?

Christian.

>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Link: https://lore.kernel.org/r/b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 92a84e7b0db85b..32adc31c093d84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -111,9 +111,9 @@ struct amdgpu_prt_cb {
>   };
>   
>   /**
> - * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
> + * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
>    */
> -struct amdgpu_vm_tlb_seq_cb {
> +struct amdgpu_vm_tlb_seq_struct {
>   	/**
>   	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
>   	 */
> @@ -833,7 +833,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>   				 struct dma_fence_cb *cb)
>   {
> -	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   
>   	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>   	atomic64_inc(&tlb_cb->vm->tlb_seq);
> @@ -871,7 +871,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_res_cursor cursor;
>   	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
>
> base-commit: 50db2d96b49b7d6cdb12e71e4204cf7180d3bab5

