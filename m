Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9880C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FDD61B1B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1FDD61B1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3921F6EE2C;
	Fri, 19 Nov 2021 16:16:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF10D6EE32
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 16:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhAGNZ6B/amMrMXtRPtxslykXkZaDWQGgZFoY3rnHmbI3HKz7u3R+4M7zv0vZIr5FFVSBpwPyKzjciEs6P86F8tEf0HQTo3h8aytNDye95+4Dyt0LG94GgtESTwy2S0RVg29wTNx/j9SB5C5DYDcKDPmkSJKjl+c/3siWeDmHDDHArUvE5k6XoCsVC2mKgeOS98xMR+bLIImxO4IsKd3BxhT8qNHjXRIQj524Mf4n7/9XOPxRJB83QOacMVSSfzlF1ad6IAkKQPXTFpjgIMEuxTDUx5GvkaG7PtPn+w2P4scqwOMi2EvmsWez7eh+d+gTN7u/aig0QnAHr98w/eALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+np1+0Ct9aP7O5Wk0gLIgabafi75JqZzH0eHEJ/g6g=;
 b=gFem3cCZxAT0ST448UDrMOrUcooOAV0WbQwHEdtSZSVjYqwbaL7Hd6OL3WNAeZyeE1r7LcSTyCE1DTrdFvSKnGhM0ydQwDOxoo8+HNQQNj4RqdJoaxKayC7WF17BQnMk94G0Eq90+4wmVbDnP8D58Vu7n8qGYNtWuSloVxYje+PwitmKuShz7AKyXcOFoDvhmjW7Wi6uZKhRr5MemjJ8KynUNGtijtsNbtuGSVVLN/A0b69VfYCQI2/kqzHwULunIVdVb15Dj4eD8ZkAuVigpGheOvYGPNk4zuEr5LkfU7lCWt9f6M42kEo4fl1Tg8Z5Yjh3GkB7MYEJFvSzIEdIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+np1+0Ct9aP7O5Wk0gLIgabafi75JqZzH0eHEJ/g6g=;
 b=Ig+L7I3nFomr7+Z3SU3/dvqw3psfWyUWZdH9vtvCg3M0GXYeF1HCApZ0WlqntBSguRMGkILdVHo4TUqBKozqr4z6MAbamkWCkHcgIA/BKQFTMGxEKEw/vETlFlBk4/4Oqrd+m+cjkBD5iV9GHFN0q1bA7LWpIEyNHYuy+QPlBHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 16:16:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 16:16:51 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix double free of dmabuf
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119101725.66619-1-xinhui.pan@amd.com>
 <f56cbf03-6447-7774-1914-6fd19fe75dde@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <474bda10-e97c-b572-9287-da35d8bd7f44@amd.com>
Date: Fri, 19 Nov 2021 11:16:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <f56cbf03-6447-7774-1914-6fd19fe75dde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 16:16:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b3916c-7131-45a5-dce5-08d9ab77fe82
X-MS-TrafficTypeDiagnostic: BN9PR12MB5243:
X-Microsoft-Antispam-PRVS: <BN9PR12MB524359B7A259644D5B6A7995929C9@BN9PR12MB5243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEThOeVf+oMYI0bkRs926Y+bp2U65EMxMmIH6x12DhzL0j4/r8Bbqv/nH8d1HpNqzSEFF9GuzGPDk82+ddWooj++4C824qTL+jrmQSRekBKjM/PVhyUbWpMV1vPs2k2Ie0HnKxBXLJiwkRITGKI6YRL1Oz7a5oC7fbs7w/SvfOWcKsmp2T7OcqA4wsevSXGwPfaW17IxZDJrcyh0IbTTA3avdeH9GQ5k28qelb89bWS3ghfVmn50efeUBgCQWcvLk3PsEcT7OL49f/ZK6xWJQhwuLcSqJanoJ5oVgwAg8SLc3e3f/28QUC6VaODuJVp1e/bHkFrmYGnt+QBl5yn22ZPZLCMOZukVL4CK2SGhpr1sDf03Lp+K6gCgnCjdhTT7Td0trQKJJhD5YAn4gKyrmRc4mC6hLNlTqSZNc5qopN+/uwy7f4OiXTMvpvFw3AJlvAIoZOgPbTIMTNDuk2/HcAs4BI5YXhMncHSh7omaE/br1uMp7r4SBuPbc4Q7vN/s0OPRwXEFmGOXSHBAZRPCIXA/YOfTY5CGz2lYO6E8s9WXXXqHMXeGqsI/qPNB1bk+Er7E727nlL72/dBxidwuEgA2Ra8T7m++j7REof7skZT7MqUtSEC0BGV360w+MbgKVx7bCxGS91vV8MTjMin4Gmjaat8NY6qzuZ+q3OrdG+VC8l5tZjL6WRrkpjT3NnCugN6RXqbsK6tMektkWuye6Sa0HhHh28rk0MC8H5C6VtChNLpokYpe9fmLpt6x+YfG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(4001150100001)(2616005)(44832011)(36756003)(956004)(508600001)(31686004)(8676002)(66476007)(66574015)(66556008)(5660300002)(31696002)(110136005)(16576012)(38100700002)(316002)(26005)(86362001)(4326008)(2906002)(83380400001)(66946007)(186003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ZneHdMZnkwc2c4Z2w3cmowaTVnRzZvK2ExVVNDV3czL1lZM2dDaWIwQnVF?=
 =?utf-8?B?czIyVm1VUE0vVS9uc0daR05MbjRQS0ZSMUFvQ3JGb2FOUWhnZVRnZUdQZ2VU?=
 =?utf-8?B?UWZwYnE2bnVySTkxNWpOY3JmMUJsNkY3L2dWSmI5bTJZWEhReUFvenZaZWU4?=
 =?utf-8?B?MU1ZY0ZaNzJhVlNxK0xEVWZKY0twSU5vNG9uRURSUlF0NVBqNndnT2pnNFpr?=
 =?utf-8?B?amlmWHE4NkNpdzdPVlFQZ0VPYzlhbEtwTWRNdk5OTDk5WWJpaUF2dW4vSEd2?=
 =?utf-8?B?ajZ0YjF4VWtWNUdQTWU5N0htOUN6ZlRKYjUvOXV5ZkplNUg2SklpcEZnRDg1?=
 =?utf-8?B?OVdEK3dLSzU2L3JFUmJwN2Y3N0VNRE5EOGdKc09GWkhJMktEN3RmSVdrb3NX?=
 =?utf-8?B?a2lXREVCRU1ObGFuVG0rRm82bWZXSFhYSjdFUnlPelRVUTFBZWhmQ01vMU5U?=
 =?utf-8?B?eWNtek1Lc2Rsa0VNYmZITE03MVNDQ2l0aDI1RjVKQ2g0TjVxcXZYclNtK0ZH?=
 =?utf-8?B?bVVFSHJuYmhGbFFad0ltaWhrRnA4eWdBVkM5Rk9XRU9EUk91MDNNZHFXV3Ba?=
 =?utf-8?B?Rm9vTzQ3c3VFZlZmU3pTV0UzbnBvWHM0NUlZTzFDMVBBNm1wZW8zUS9mSWZn?=
 =?utf-8?B?bjhBbWZTQWYxdDlkSGR2UkcyNDRDeDlHYUhWeUNJekR0S1JRdjR2UWJyUkFW?=
 =?utf-8?B?RklRSXE2L1J5WTRUZDZFUG0wdzRFUFFtYld2b2hic1NTWUlLZFpwZ3ExZ0lJ?=
 =?utf-8?B?RlF0c05uQTd6a1lmWUlIK3Nva2JEZDNBR2svRWtva3pmcjhaUlB2UngySFdL?=
 =?utf-8?B?bVdmeC9BTG9ycWVFUDE0bW5Mc1YrSWtjNi9OYmJzcU55OEZBUnE4VGNCeXVo?=
 =?utf-8?B?Q2pkK0ZPYzdQS2dINWlrWWY0UGk5WEZzclRIeTdHd2JKRDYzNE8zOWd3L2pW?=
 =?utf-8?B?NEl5K1dzVVlpTENaYm1xRllPUlM0bXRWMko4N09hWVgwQTNTOEpWbHA3Qk5X?=
 =?utf-8?B?ZjdFRVJObGpEL0lnYS9SNG1vS3ZIWUlZcU9PdGprTkVqR29ZRldTUEl3TkhP?=
 =?utf-8?B?Y1QySmpMbVYvejZ1OWVCVVVJVjNZYTdKeXlES3NPVW1TOVN1U1NncG9rNmNj?=
 =?utf-8?B?Qmc0VVVMRzRJRGNYR0lYbngxZ3VKcEQvZ3p1SXRWOU56NGxnM016N0x2bktq?=
 =?utf-8?B?Qkc0VDI1eFN4aHBZY2dsYzBOak9KOUxFNVd2TGRRS2I2dkwwblhOMDdrelVY?=
 =?utf-8?B?UlJYQVdQTjdKenpHc3VEc3FJKzNjZHJqQlMzVmpvM2tzT0ZrWStYWFFnRHYx?=
 =?utf-8?B?N2VNbkEwVUpuVnNsU2RzMnpSZEd5cU9zN0FqcnpDZTFvcnExRVBmZUZkNDI5?=
 =?utf-8?B?OGFieHZCYUxZUlQvMnpRVGFhNDU1b2NPVk9PZUZoSllJWmErLzhkNXV2eFZm?=
 =?utf-8?B?UXpyMjkxNDdBNXExb0tLWXNSQmNRdGFBVkVzcHNpYWk3QVdPUmEyUHNIODBH?=
 =?utf-8?B?aVJtajM3NGZoOXhUcUNhMUVEa3RNNFFITHBQSzJBSkFYQXF4NWZ3cDgxbTVy?=
 =?utf-8?B?aEJUUUJOVWRDRU1tRHJwMldVVHNMWXpVSExCUmdZZUxiWEJzenpicDVaR0FR?=
 =?utf-8?B?OUlrcGlnc3ZhaUlaOFdYOXU3RTdrM1QweUZZK1ZtOGZsUXdwTndUcFA3UHFF?=
 =?utf-8?B?MVpvTitvV1I2c2p2dERZeGxqUVJWVE5MMGxJYnAzUFRUZXpBSXBIZG1BRm11?=
 =?utf-8?B?MzlIS3ZTTGpYOWhoM3g1WW5ndzc3N2xVL2lCZDd0S2crVk13emxjVTY0UTRr?=
 =?utf-8?B?MHNpcS9odWlsNElDazZZaS9ialRrNlZPSzFQQmNLakYwcDRPa09GS2pLTDcr?=
 =?utf-8?B?Q0hQbjhZSmpSNlBoRFhiMjRCZWtObm9oWXVjSVJxOEpEcFkwU2JFbXVMZDg1?=
 =?utf-8?B?cDBJVTJQSkdNbDduVTQxOTY4a3Y0SmtGUzgxb1VtaTNKeExWZDR0ZC8ybVpT?=
 =?utf-8?B?emJMSkUxRm1qWmsvUFB2Yk5PRHN3QzE2QlhRNmVNeFZNdkpIR05rb2E0NkM3?=
 =?utf-8?B?dFNGcGF4U0RJdWJKb1JDOFEzVVh0cmd0Z1VabmxSS001QU5BVDRESGVVeHBn?=
 =?utf-8?B?NkJ1Mm5ONlNhbEJiMVNGYXFiRHZiMlZWbmpkWGlHeWkzandoWVR6UzBwb1Z5?=
 =?utf-8?Q?sT84o5Ov+Im2q+w7fNGNwOY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b3916c-7131-45a5-dce5-08d9ab77fe82
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:16:51.3035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMbVJRP0wEK5mJ4WF1B+fjRFs078kFG6FJwcJVe7mvDVWW6ezkivy8YKMcVWPgfY5JhuMyenCdHHOurXl2EC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'm pretty sure I needed this dma_buf_put to avoid a memory leak. I will
double check later today.

Regards,
  Felix


Am 2021-11-19 um 5:52 a.m. schrieb Christian König:
> Am 19.11.21 um 11:17 schrieb xinhui pan:
>> amdgpu_amdkfd_gpuvm_free_memory_of_gpu drop dmabuf reference
>> increased in
>> amdgpu_gem_prime_export.
>> amdgpu_bo_destroy drop dmabuf reference increased in
>> amdgpu_gem_prime_import.
>>
>> So remove this extra dma_buf_put to avoid double free.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>
> Yeah, Felix pinged me as well that the DMA-buf import code looks odd
> and he is dropping the extra reference which didn't made much sense to
> me.
>
> Acked-by: Christian König <christian.koenig@amd.com> for this patch
> for now, but I'm going to take another look at this when I have time.
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 6c6d5d994b5d..0f68d28e002e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -665,12 +665,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device
>> *adev, struct kgd_mem *mem,
>>       if (IS_ERR(gobj))
>>           return PTR_ERR(gobj);
>>   -    /* Import takes an extra reference on the dmabuf. Drop it now to
>> -     * avoid leaking it. We only need the one reference in
>> -     * kgd_mem->dmabuf.
>> -     */
>> -    dma_buf_put(mem->dmabuf);
>> -
>>       *bo = gem_to_amdgpu_bo(gobj);
>>       (*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>>       (*bo)->parent = amdgpu_bo_ref(mem->bo);
>
