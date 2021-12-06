Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98A3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 19:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39676EE54;
	Mon,  6 Dec 2021 19:24:19 +0000 (UTC)
X-Greylist: delayed 14387 seconds by postgrey-1.36 at gabe;
 Mon, 06 Dec 2021 19:24:17 UTC
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49F17A4B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 19:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnPhXTf4cTgOtzh1dBnoUtosci65eIK3soKCs1ztgzJnSL9+eD12kaveu5H42Bc5zdJwIwTYhpcFTISvhkkZJ74trnHag3tyQRbaGz323nflHc9OLJcPSL/wMD1rhdOhijWGSj1zQtnzoTiNROErBZN0bUZYDVxhgNNIWrr/IVy71gbkZLUkMG36yYRCQQhj1ujnXo5c8Q6TmbmTpIoe3QVSCFFbRDePNkarqhthlL4HydsVPxcIamq4LNRo4isaC0OEjgEbHXHkMGrJXq5xZ8rsllTeRu4mXgIc6OmYekUJokaBmLZMPtX7qUTMKdgdVyyeUtLwt2d0GYNG5rWbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYt93f2gtM4TyrcRopWyaqlh/REC2+L00Vum2+8p5LY=;
 b=M46ycDvq6mua5Tip0BUqMUJD3LAOL3pvbzdnxn5tTJL78N7yL29estOlfJHqJKrih6BT87IIhPovbOGrOUKUpJOMi51vlDmSF7AZDZTvmPpxhHiEkshT84QmBxkUyc8NMWpkrBd7UA2mxd9164eOUXau9vC8hothp9U2olCrY1ppjvGZoPSZNmMMPpd3wGXzyZAafo+yea/bQVeBM+rPs4DAZMB8QlDWwhXC3rq+XhhOkcd73AFORChZUg7bRObY8U7GukmmWtriNUba9Hzhatj3PEQngocnGWEw+Ii5dFWY7tPGjMS0REazwTneMwlve3/c6YcPr/+vslOYuI5pwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYt93f2gtM4TyrcRopWyaqlh/REC2+L00Vum2+8p5LY=;
 b=1qLfUouRIXmkY2jEGggA0bmF/2F6B0xt9BoUvOZWb3W9Tk/KVNKyGaZE3KTva9X/3GAqPmMPAuiOIHgBrFTWj7x57kKa0+Qcls9bOxJ+fMRMRwm7TEjE8ploFg90akHggeMjsxTGYwYcly8Pl3P0kk7epw60QLBvcIKOOXF3zCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 19:24:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 19:24:15 +0000
Subject: Re: [PATCH] drm/amdgpu: use sdma to optimize debugged non-visible
 device memory access
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202214304.1155207-1-jonathan.kim@amd.com>
 <5a08c767-d7f9-31cc-5e64-a0722575cbd1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ef38f29f-e1b4-0759-e385-d2084414c022@amd.com>
Date: Mon, 6 Dec 2021 14:24:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5a08c767-d7f9-31cc-5e64-a0722575cbd1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14 via Frontend Transport; Mon, 6 Dec 2021 19:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c8e231-2ca1-4d49-22fc-08d9b8edfdb2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53086D68F76DB2F671F11801926D9@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHV0u43goIW0E++uh6/Jh4JCUwxuxQOkEt+JNOKnUS5C1xgiTxH67O9xjdKW378GWV76yWvXEFN/rlxUuqfyYZOxie+CA4L9als8o1wYfLjeTbTozJJHjfzAIJHNq5REci1sJglJfk7Mtt1xWw75CJ2PRhj6q1M0ewWK2r6sqv+nAxgjTtDBCODtitDxCaZZztwWx3MjHbwMPer9LWm6rqPFPivAsfKmua82LzyRJCGe6v3VWCNBrCnhrZFqTS6bvFzR4a3XGz8ficHrsoiqNFuYiIavAOW2dOfENZxfzDRH2vNYKrlL5tiCMT1kmrnzb+s4KXsPIumN58WWQNB0qVUIjSlC4eyLINYuqkBH93rxusvZaQEBqDahIaV2HV7yKjJD802XJXwG9sGE+TnhtfQVxFHAuXxb3KD3aSHFvxDErmChIfTcESSCLmiX+biatgVZ7YHA9vp9YKkNgHXPS/FVBn5U54fWispIoP78yQw6a51EvC6ncgkiS4hky2z2jHGzrg6N7jEQ15QneIU11u0Kme3eSQldqjpIFN1hoqpHhQLQxFeven29483vX0bSA78dDDYBLjKeLE/yAXpHSoYW4rUNZPq2dSYjoHJSwl9LT1VDGkNLdFdwzcjm6g+YZ7jbnAN/kx2xRO67017fugupOOFJ4QpBaoSoNs/6nd9+rB2B5WXN3x5KYd9MwNebG7coyVZovjGDlIwqVDlcEOQJpHVlkfoVCp5MxtoJF/Y90XtP/rtfGaWnR0AK+P+R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(31696002)(86362001)(38100700002)(26005)(8676002)(186003)(36756003)(31686004)(16576012)(110136005)(66574015)(5660300002)(316002)(2906002)(956004)(2616005)(44832011)(83380400001)(508600001)(66556008)(66946007)(6486002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNYTTlHWUU4WHlhbEZYejlkd2ZSMG5QNTRSYWpBZTVEc2huZ3NqdDRjSmZh?=
 =?utf-8?B?eHBtZW9MN0pkSjkxNHV6a3hmRi9zOTg1enBMRmVVRGJJV1REenEwSU00b3FZ?=
 =?utf-8?B?R1BLeUFuT1VKNmxHMEFFUWo0cHdJYStWdnN3dTk3M2FoUGdRTm1MczZKYmlj?=
 =?utf-8?B?T0JLdkpDVUFURlJQZjJJdHpYOC9zZ0VxU05kTlV3UUhoNzZZMkpZMDlsRks3?=
 =?utf-8?B?MERNblNjamRBVW4vYTQzakNkWitSMWd3WEVRMThPUC9GaWJma1ZzbUFMZU5Z?=
 =?utf-8?B?cjRBK1N6elNFK3E0TEJBMmFMVFFoMVNabFVSL2g0bnhKYXJwT2lkbUtWSE1W?=
 =?utf-8?B?a0lOcjdJdjF3dUFiMWhkVDR6SVV2TlZTMEloQkg0R3pybENqemFqWFdEd2JO?=
 =?utf-8?B?L0szY3ppeXlSdzU1SWRpOEtyK2o1Z01UdWxlQWZzZWJvSEFHUW11RXBPRTgz?=
 =?utf-8?B?Q1R4aUFLMEVUUUpjdGtEVERrTDBUVDVwYmZIRjN6d05sZmpBUnlDRTBuTFRw?=
 =?utf-8?B?UVJhM092elJaR05kemVLWTV0eW0zTVJwSFdHdlR6b2FYWXBTc2sreUhnbjRs?=
 =?utf-8?B?M2VnNXFkNmpBNGFtZERWRlpPMmZkemtSaTZtTmltWkFsYk9qZy9QZm5qU0xP?=
 =?utf-8?B?QjU5WCtwV0wvM0pEeHFrcEFBR2FSL3lialIrS20zQmNxUHdCbTM0aHowei9Y?=
 =?utf-8?B?WVNoWE5tdHZUQUZoTU9Oc1dhYVlnMDE0QVFZT2tIOVZyZjFOVHNCSW42TmxG?=
 =?utf-8?B?QXVybDRlSDZUQ3B3YUxHclU0ejRBQ0kzeUsybVRXc2d6aU9YYU9PWG5SWDY4?=
 =?utf-8?B?SXVTS2tJUjE1V0c2bnZmSCtBTHVxclJSNWxHS0c5ZzU4dG14ZzdaaWdjaXB1?=
 =?utf-8?B?amdCVzBDdThTaUNvRWFmQkNob3lKTmUzb0pxbEw2ZzNBUjlkV21uenZkZEp1?=
 =?utf-8?B?VHMyc3RtVHNPQnFsTjlDTFhSVm9kbEpqaDVBRTFrWmRjQWxudWdFNlhEU29k?=
 =?utf-8?B?dWVVdGN0c0lBcnlodnhXeW56TG93N3JOUjU3dmFSL0tpTDlFcitBdHJUdFg2?=
 =?utf-8?B?dFZ2aUxpSjRJMkY2NTlnQi9CMTRxTG90bWFiMGk0NHQwK3UrZ1pvcHB2UGxi?=
 =?utf-8?B?Q0RnSmVlbVNxR290MklqUWtCdjlPWGlxVE53NXNyYkJDRmpGQ3ZiUlBSaC8r?=
 =?utf-8?B?OWcza0JLRk1JYkVYZUtKMjQ2S0FJWjMwWFB1eFZuUDRpQ29sQkpUdGgrWnYr?=
 =?utf-8?B?YThTc0NDdG9vZC9ienJDTXB6YWpESWMvWXBOeHkwYWoydVY1ZjlrcHVYeVVT?=
 =?utf-8?B?Z042RkYrKzVyb1IvaVNlUjZvQUJINHNVSWdoTjNnK09SZU9wb1RqcjQxSHhO?=
 =?utf-8?B?dmhXVW9Ga244TXZHNDhmZTRQVXhsTG80MVdjamJXbFRJU0hNTDl2KzE0REJ4?=
 =?utf-8?B?MXp6azYxNGh6MFA3SWNqOFBqT2VRSkpjTGdrUW13ZmhpU2hKUSs4eXVpQzhO?=
 =?utf-8?B?ZjZCcGRQaDZNOVMzOWJ4bmtiODFXeU9lcWw0eC9scDVNQXM5bUd5Q2dtUHRJ?=
 =?utf-8?B?K3V2NGpIMTJTcTB2OXNRK1Vya3hkdjNiSlVneTZSOWdIWHpPb3BqbDNCeXVE?=
 =?utf-8?B?cHJ1SjJQeUptUXlnSHpwb3c1NlVmSFZUaU1XZDlpaS9WQnpBS2VRd1FweXdB?=
 =?utf-8?B?TTdYOUVBVDFUYzZ2Y25xT0VHTURkOWxhQUIycDVnUC9YRUliVzhyM2xkZlhm?=
 =?utf-8?B?M1lYQWdVU0xWZ21hRGJFYXErVXlGSk5NRHl4SVhQYzJsa21wa0RUVlpjZlNR?=
 =?utf-8?B?ZG1LdmVZR0ZHNUpidkR0Zk5mL2VmRENoM05USFlMZVY4TDNDMHo0VEhISDc4?=
 =?utf-8?B?ODFwY0lXZkwrSDFES0VoQmpqeWUxak9IRUhOdlJLRVdDTkZ5OWxkTjRuMkha?=
 =?utf-8?B?NW1ISmF4UzN5SXJXbXFZWkQ4RGI2QUZGYjBZd1ZYYzlBTVIzTy9FWFVEd2Fl?=
 =?utf-8?B?cEdaTUtqbkFsMnJ0MTRERUFoekxFLzlrazIra2FEbGVUZVdWa3NQYWF6NU1n?=
 =?utf-8?B?NFMvUytvYU1UdUVpZjRlcEdZNWtsUTFMV1NsbVpoVE5tZUdSOUZQTmZrNW53?=
 =?utf-8?B?Z1IwMG4wMHljZWNRMkZ6dVl5MkZYcm91RHpFdEhhcTIyM1VUZW8wNXpGRUhL?=
 =?utf-8?Q?HUyoKNV/8aETZv1ciIoRqjI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c8e231-2ca1-4d49-22fc-08d9b8edfdb2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 19:24:15.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dd82cCafIHxTX+2/pRpPjkUSlPy7g33D5qqWCcd4PPWD+WOQq2Ut2tqtmWhPoedVfDhNqgGtDZ0K5YIwKqNJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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

Am 2021-12-03 um 2:18 a.m. schrieb Christian König:
> Well NAK.
>
> We already discussed this and decided to not use any hardware
> acceleration for the debug access.

Conclusions from our offline discussion for the record:

We need amdgpu_ttm_access_memory (e.g. gdb accessing VRAM) for
post-mortem debugging in some use cases. This requires not disturbing HW
state while the system is under investigation. Using SDMA and mapping
memory for SDMA to access would be problematic in those situations.

Post-mortem debugging requires module parameters to disable GPU reset or
to set an infinite hang timeout. We can detect those options and enable
SDMA only when those options are not set. This allows good performance
for application debugging, while also satisfying the requirements for
post-mortem debugging when needed. Something like this should work
(Christian, please correct me if I got this wrong):

static inline bool allow_post_mortem_debug(struct amdgpu_device *adev) {
	return amdgpu_gpu_recovery == 0 ||
		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
}

We should further guard SDMA access with drm_dev_enter/exit. Question:
is this just needed for SDMA access, or should it apply to MMIO access
as well?

To avoid updating page tables and flushing TLBs during VRAM access, the
recommendation is to use a GTT BO as bounce-buffer, that's pre-mapped in
the GART table at driver initialization, and implement the copy with a
manual SDMA command submission instead of using amdgpu_ttm_copy_mem_to_mem.

Regards,
  Felix


>
> Apart from that you implementation is absolutely horrible and won't
> work in all cases.
>
> Regards,
> Christian.
>
> Am 02.12.21 um 22:43 schrieb Jonathan Kim:
>> To support better memory access performance on non-Large BAR devices,
>> use
>> SDMA copies instead of MM access.
>>
>> SDMA access is restricted to PAGE_SIZE'd access to account for the
>> PTRACED
>> process memory r/w operation use case.  Any other access size will use
>> MMIO.
>>
>> Failure to do an SDMA copy will result in a fallback to MM access.
>>
>> Note: This is an attempt readdress patch request
>> 'drm/amdgpu: extend ttm memory access to do sdma copies'
>> with the addition of restrictions and fallbacks.
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 97 +++++++++++++++++++++++++
>>   1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 23fc57506a20..1cb984252f58 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1741,6 +1741,91 @@ static void amdgpu_ttm_vram_mm_access(struct
>> amdgpu_device *adev, loff_t pos,
>>       }
>>   }
>>   +/**
>> + * amdgpu_ttm_access_memory_page_sdma - Read/write page of memory
>> that backs a buffer object.
>> + *
>> + * @bo:  The buffer object to read/write
>> + * @offset:  Offset into buffer object
>> + * @buf:  Secondary buffer to write/read from
>> + * @write:  true if writing
>> + *
>> + * This is used to access a page of VRAM that backs a buffer object
>> via SDMA
>> + * access for debugging purposes.
>> + */
>> +static int amdgpu_ttm_access_memory_page_sdma(struct
>> ttm_buffer_object *bo,
>> +                    unsigned long offset, void *buf,
>> +                    int write)
>> +{
>> +    struct amdgpu_bo *dst_bo, *abo = ttm_to_amdgpu_bo(bo);
>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>> +    struct ttm_operation_ctx ctx = {.interruptible = true};
>> +    struct amdgpu_copy_mem src, dst;
>> +    struct drm_gem_object *gobj;
>> +    struct dma_fence *fence;
>> +    struct page *dst_page;
>> +    struct ttm_tt *dst_ttm;
>> +    int ret;
>> +
>> +    /* Create an SG BO to dma map the target buffer for direct copy. */
>> +    ret = amdgpu_gem_object_create(adev, PAGE_SIZE, PAGE_SIZE,
>> AMDGPU_GEM_DOMAIN_CPU,
>> +                0, ttm_bo_type_sg, NULL, &gobj);
>> +    if (ret)
>> +        return ret;
>> +
>> +    dst_bo = gem_to_amdgpu_bo(gobj);
>> +    dst_ttm = dst_bo->tbo.ttm;
>> +    dst_ttm->sg = kmalloc(sizeof(*dst_ttm->sg), GFP_KERNEL);
>> +    if (unlikely(!dst_ttm->sg)) {
>> +        ret = -ENOMEM;
>> +        goto free_bo;
>> +    }
>> +
>> +    dst_page = virt_to_page(buf);
>> +    ret = sg_alloc_table_from_pages(dst_ttm->sg, &dst_page, 1, 0,
>> +                    1 << PAGE_SHIFT, GFP_KERNEL);
>> +    if (unlikely(ret))
>> +        goto free_sg;
>> +
>> +    ret = dma_map_sgtable(adev->dev, dst_ttm->sg, DMA_BIDIRECTIONAL,
>> 0);
>> +    if (unlikely(ret))
>> +        goto release_sg;
>> +
>> +    drm_prime_sg_to_dma_addr_array(dst_ttm->sg,
>> dst_ttm->dma_address, 1);
>> +
>> +    amdgpu_bo_placement_from_domain(dst_bo, AMDGPU_GEM_DOMAIN_GTT);
>> +    ret = ttm_bo_validate(&dst_bo->tbo, &dst_bo->placement, &ctx);
>> +    if (ret)
>> +        goto unmap_sg;
>> +
>> +    src.mem = bo->resource;
>> +    src.offset = offset;
>> +    dst.bo = &dst_bo->tbo;
>> +    dst.mem = dst.bo->resource;
>> +    dst.offset = 0;
>> +
>> +    /* Do the direct copy and wait for fence response. */
>> +    ret = amdgpu_ttm_copy_mem_to_mem(adev, write ? &dst : &src,
>> write ? &src : &dst,
>> +                    1 << PAGE_SHIFT, amdgpu_bo_encrypted(abo),
>> +                    bo->base.resv, &fence);
>> +    if (!ret && fence) {
>> +        if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
>> +            ret = -ETIMEDOUT;
>> +
>> +        dma_fence_put(fence);
>> +    }
>> +
>> +unmap_sg:
>> +    dma_unmap_sgtable(adev->dev, dst_ttm->sg, DMA_BIDIRECTIONAL, 0);
>> +release_sg:
>> +    sg_free_table(dst_ttm->sg);
>> +free_sg:
>> +    kfree(dst_ttm->sg);
>> +    dst_ttm->sg = NULL;
>> +free_bo:
>> +    gobj->funcs->free(gobj);
>> +    return ret;
>> +}
>> +
>>   /**
>>    * amdgpu_ttm_access_memory - Read or Write memory that backs a
>> buffer object.
>>    *
>> @@ -1765,7 +1850,19 @@ static int amdgpu_ttm_access_memory(struct
>> ttm_buffer_object *bo,
>>       if (bo->resource->mem_type != TTM_PL_VRAM)
>>           return -EIO;
>>   +    /*
>> +     * Attempt SDMA access over non-visible VRAM first.
>> +     * On failure, fall back to MMIO access.
>> +     *
>> +     * Restrict this to PAGE_SIZE access for PTRACED memory operations.
>> +     * Any other access size should use MM access.
>> +     */
>>       amdgpu_res_first(bo->resource, offset, len, &cursor);
>> +    if (adev->gmc.visible_vram_size < cursor.start + len && len ==
>> PAGE_SIZE &&
>> +            !amdgpu_in_reset(adev) &&
>> +                !amdgpu_ttm_access_memory_page_sdma(bo, offset, buf,
>> write))
>> +        return len;
>> +
>>       while (cursor.remaining) {
>>           size_t count, size = cursor.size;
>>           loff_t pos = cursor.start;
>

