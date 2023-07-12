Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE96EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 08:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF93E10E36E;
	Wed, 12 Jul 2023 08:34:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E83810E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 08:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gguOIeJ4a3sQXfspXWstqh57y8o7yrUq59GIcWlvG2xi2rPoW/nLN10pNY/vlFytV0RIGWbQhLu4bFqYnHFZRy4nBT3HAL3aVpWtFHftPDC82n4oTOacZlMi3UzNjhmfW2YdRdMGZ1hCy7dbDu9rSQ6nNQLo7/Yh0YnOPcS4MqGd9a0yXN2QfjFnvvqxppJeidkxTURR5p/3+CTOTnp9V/MSvXCiyi9gCWOcRsdNKqwtT9diXDrbtUfU/y9y8aqbVgjbT3TcDSqPZJpUimI0wNLpJRbG7rPABLhO8ZSp5n8+nYUMEd855YquDVQk1ujgfiNB4C8bXWWMt96k+kaKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WME1zRlCjKZnlFNtRR63VonkxFtgD767O+lek7N8X+I=;
 b=kdfx9I8H4QqQ8/E8NCcXIRJJDfVK4U+ORAYVWvKEM9a6rQfwwoyyE9pZksbgSX/TSukka1easJL0ZxiS+sf7PqAHIHEA6jm+Mc8UwcmdfrjvOX07FV+rqk8X3dc1XNYurwPc8G5lBCSKkMWEnQd3JcfdsPk3S3laS7UcNO/N2gd0OJwYa2SGmcO21nkmyqhnQG4zOEEi+7hoi9j9uJDswn+mIn/dKo+8CmuTll6LHn2whexZalWTyd7TBjEm4c2xx9UUE0fcJHG3rkMQjC+kiEC8flwBj3Mc8Hf8qWPQRtlOkPveg1IlL18tUFeGZfaNJlx1ofJ/r/SmvrrRYsy06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WME1zRlCjKZnlFNtRR63VonkxFtgD767O+lek7N8X+I=;
 b=cycSCh/tgsaErfFc+16XdAQRlvIAgoLNGc10QT+D/iiAvNK4Ex8ZGfxX99+onPLWf5LbhAGnAXpkY7o8RaK1qZi+GZcngO/WCUi0UC02SY64sD5vmZyQH/PImLlxz/6oeCwMU105Ug/4yPQLBrRLxBsQH3vdX8HSTN6AjdFNyZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 08:34:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 08:34:46 +0000
Message-ID: <4748ea86-aeee-fdf8-71da-caf9161ce16e@amd.com>
Date: Wed, 12 Jul 2023 10:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Rename to amdgpu_vm_tlb_seq_struct
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20230712065821.260061-1-luben.tuikov@amd.com>
 <1dc3a6fb-3973-e6a7-519a-440fcfa5ee9f@amd.com>
 <b3964f68-4655-faac-e0ce-64f597ad1837@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b3964f68-4655-faac-e0ce-64f597ad1837@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: b1db07c8-1195-47c1-d141-08db82b2d8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJYJn6VfczF/WicNVFQ94ymSwVeroN0ULx8OOdHWluX1aTx+cSEaMO/HNGU0USLkDufhtsSFAhYlxiyXAbcHz2g3+5n8JDrsPhftXmm/gTOFBGp9aJyfC3rCfj0pTKgjUCKJXQ3vRLf3/HIh/8oYEFoHPc350pLrg+TVlCanSo04LnkOdrBdP0+Kd63tIi1BZb2SdxSgBmufYA5f6o0YmRqVpiESrnwBhQ19Yy6lypQ0qoXJsDW1Us/p+B9wYyhYXaSesD02FI9gPZkfbHpH0/0ST87Pie+I3XlBMwBMN2TxAgcl4looH1MTq+EC2PfFi6rTHmRnUaM+5/W08Y98eBxAipZBZoSgAEF9jHeTrAGlPH1Whw6f8lf4Xk6gESjs06hgEJgxdwpQZjO7dJ7TGR4h+Tb99xAs1AesqCc2WBGN7z49UwLKl7JHuxhqAtY7PnC+iRwBKSDgb2D7Xp8zOp4REmvvkCiLzmaa98Yt8R4s1meZ0d6qKJmbs+ecWed55gXij2lMBeBH4lwpaAUbFXnuBcBj1l7wwN6FKxH0/7hIhUMDjM7KHPtUrWZw8F5ORea4gYUx7lPrrDBYc84XYWD03HUDMcG4/ybpoV1PTEkPJZUevJX3XAoPQlRovFLUV+Kmjb7ZoSrtafIeYKu5xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(8676002)(8936002)(5660300002)(186003)(31686004)(2616005)(66574015)(83380400001)(53546011)(6506007)(86362001)(31696002)(41300700001)(6666004)(6486002)(966005)(316002)(6512007)(66556008)(66476007)(36756003)(2906002)(66946007)(4326008)(54906003)(478600001)(110136005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vzh0WVhXWGxkaWx1R0Y5L1k3cXEzdmNxRGFVclhESDNpd3hkdGhhejI3SWYy?=
 =?utf-8?B?OVJJOTkyekZrVzVwWEdSSU43UXZIUkI1RXFLL1lPdURVNlZBd2tmblNUSDZp?=
 =?utf-8?B?cm40WGxVRDRkZGEwREJqNjd5QW0yZEN3bkd6M0trM2lidGpVa24zVWorMElt?=
 =?utf-8?B?TFhxZ1dTL1k1cVlTelkxSlhwWitqOHdQNUVzbVQ0WFpHU1RqdVBIRDhJdWV4?=
 =?utf-8?B?V0dzUGxPTHRNdjJGbjJEeFpJUUlkU09jQ0cvdXhQZG1aazR3R0dYREp2WDdh?=
 =?utf-8?B?d2pwY3Y1VmRIM1Y2WW04V1dTUThPaCtTVUZiNzVreU1RZHVsRmN1S2hsajBx?=
 =?utf-8?B?YWdOQUx2dzlKWnlIc1dkQ3ZVUyt0V1RxK0d2TEt6SzBBRjFDVFpsWXQrU0p6?=
 =?utf-8?B?T0FJRzNNRllOekVESEE1WUl1MzBWNTloYlY1bWk1MEE0YWU2bW91dU5FTkJj?=
 =?utf-8?B?S3RFaHJTekM0dUZvYllXaEZsRlhXdk9SMU51aGJtejJ1RXIvK1Q0RXBRZ2Rn?=
 =?utf-8?B?TjdVT1VGN1N5NG9DUkJoeXJPSXpUOUpTcnQyK1J6ZEZndzRiRHJRYjQ5ZHRG?=
 =?utf-8?B?RWc1WHYrUTU3eGxhcHlNVUVaMHpwWGFwUFlqblBBN2QrMDFENzQzaks3RzY5?=
 =?utf-8?B?dEZXcXA5QUtwMGVBcmtvWHdqekpXWUZVMGtmYnp1R0pZYUR5OHgvYlhhcTlT?=
 =?utf-8?B?N1o0dzBBNEJJbVZWRmJSUU1sZVNTclVKQWJmU3ZUN082NUxGZmdLNVYxN2F0?=
 =?utf-8?B?VXB6Z1ZkaGd0eGcrdUJNWktEQTVmM1VoZGdtM2N5ZnNEWmpTR2VYK1hkN0ll?=
 =?utf-8?B?TnAvY0pSRk83YVozUStBVENVbnRiSm9oK2VvdDlMWkNuVlpPN0VXd1FnMUsx?=
 =?utf-8?B?dEFteE1GTHdVMVVCYXRwUWVwQVpkUXVmSElMR2VKeWdhRkxHTWt4aDRSejhR?=
 =?utf-8?B?djg4Z29kYW9BYWU1MTFYSndWT3BrSlAwcWVGL0UxNlptWHh6RzBycWREWERv?=
 =?utf-8?B?SmhGeHBpRC90M1R6eTdBaUNET3h5Zkd3c2lsVUxiby9PUjd0dVVNaElxdGg4?=
 =?utf-8?B?WVEyVzF1TGFBeFZxQldlM0lqU2ZheHBKc0Qya2tyWjdIS1E1cUtrNVFhMyta?=
 =?utf-8?B?My8rQjRvWE1Zd21Jby8rRW14K3k1RkhwOWNaOEtsSDc0VGNRSXE5RUg3RmtQ?=
 =?utf-8?B?ZHgvVWhCdERnVWxmeDYyZTVhemV3MCtxN3lub2lmMEFPMGV4VVhoaDE3dW0w?=
 =?utf-8?B?TmU1emRPb3gvS1h2WUpjL1QrUjhtRnlRaWJsWld3cTJGQ3g5MnJkS2tZVitq?=
 =?utf-8?B?UDQzV2k2eVdtUlorZ0trWkV6WDhmWnhVd1BSZ3FRVCs4YmkzcTM5dklJZDdV?=
 =?utf-8?B?Zml1UTNab1Y4ZWV4dDZaOUIvc3BzV1RadWZEQjV5MW9tTVBSTHJjVVQ3RUhm?=
 =?utf-8?B?emZOZUZ3cjlmdXFtaStFejViY08wc0tQSmpweE5ZeWhVdVdjTi8xYy9vaGlV?=
 =?utf-8?B?U1VYT3BkUkZ1ZW1sNzZWeFhkSTFmVWphY293UWNmOTZrUDdDNlJGbXhsRThQ?=
 =?utf-8?B?b1NWNTdkdWNsSGF5RWphRkp2MWp4WXozdkY3MDNSY3owMTR1VEZQdzhzUkR6?=
 =?utf-8?B?VGErWUdTdFYxSVNkV1kxdkxBbVp4YnZibE5kWWI0WElHV0pzVzFGUmxQNlkr?=
 =?utf-8?B?SUhhSlF4bEc0Q2UzaFphenE4dmY3SmY5cnNLemRnVGpRUXpPOWtnZjJFR2Vh?=
 =?utf-8?B?dEtMWEJxczBkTHI1aFRUWGN3M0Rta1FiWGlQU1lMdFk5QUttWkFXOW9PbGNG?=
 =?utf-8?B?WGpFN3FqK1oyRVVjak9YcGcyVlFJcC82UlE5WDQ3ZnRMNkR1NUwvbTEwaklY?=
 =?utf-8?B?eUtRbllwdVptdVM2L0MrRUtjYzdZMDdPekVJVVFIMlRBdWpmVjByd3hZai9k?=
 =?utf-8?B?NlZVY0NYbEVRT2ZBNHFMaHpXN2huNXJwZWpjeEVIdkxtS1c3My8vU3dUTm5j?=
 =?utf-8?B?YjZiR1Axc2UzZVRYbngzSUZXQUI1UFpKaGVNZENLdkhvM0kwbnBrZWN1QmRK?=
 =?utf-8?B?RytSYnlFNjdVWjFLd1RCZUxzWEJMRlJXcy8rdVVMWFY0YktQc1FXMmNTT1M2?=
 =?utf-8?B?dGFVdDNUMWJQMnZSb1pBNExtMkJ3a01Fc2ZEUHk1N2Mxalh5OU8rSE9PZk5E?=
 =?utf-8?Q?GCDwWIUV1mAlQnU5UXc9ifIlCSM4L86nuBIy88OIRZ8I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db07c8-1195-47c1-d141-08db82b2d8cb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:34:46.0044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyejh3m+16p8URSQ2GQhx/2QMdz49ZoKZfkFJoTmwszs4KNpoIpumk9d5d8dZQo+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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

Am 12.07.23 um 10:03 schrieb Luben Tuikov:
> On 2023-07-12 03:57, Christian König wrote:
>> Am 12.07.23 um 08:58 schrieb Luben Tuikov:
>>> Rename struct amdgpu_vm_tlb_seq_cb {...} to struct amdgpu_vm_tlb_seq_struct
>>> {...}, so as to not conflict with documentation processing tools. Of course, C
>>> has no problem with this.
>> Hui? What exactly is duplicated here? Is the structure defined in
>> different files with a different meaning?
> The same name is used for the function and for the structure.

Ah, yeah that wasn't obvious.

In this case the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

>
> struct amdgpu_vm_tlb_seq_cb {...}
>
> and
>
> static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> 				 struct dma_fence_cb *cb)
>
> C has no problem with this, but document processing tools do,
> and in general it doesn't seem like a good practice to have
> the same name for both.
>
> Regards,
> Luben
>
>> Christian.
>>
>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Link: https://lore.kernel.org/r/b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 92a84e7b0db85b..32adc31c093d84 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -111,9 +111,9 @@ struct amdgpu_prt_cb {
>>>    };
>>>    
>>>    /**
>>> - * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
>>> + * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
>>>     */
>>> -struct amdgpu_vm_tlb_seq_cb {
>>> +struct amdgpu_vm_tlb_seq_struct {
>>>    	/**
>>>    	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
>>>    	 */
>>> @@ -833,7 +833,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>    static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>>    				 struct dma_fence_cb *cb)
>>>    {
>>> -	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>>    
>>>    	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>>>    	atomic64_inc(&tlb_cb->vm->tlb_seq);
>>> @@ -871,7 +871,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>    			   struct dma_fence **fence)
>>>    {
>>>    	struct amdgpu_vm_update_params params;
>>> -	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>>    	struct amdgpu_res_cursor cursor;
>>>    	enum amdgpu_sync_mode sync_mode;
>>>    	int r, idx;
>>>
>>> base-commit: 50db2d96b49b7d6cdb12e71e4204cf7180d3bab5

