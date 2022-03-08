Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496CFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 09:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB74E10E1F3;
	Tue,  8 Mar 2022 09:16:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288D910E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 09:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPzMqdh0dAYAJCt7hyqkiQYXeFU3o9v4Tq/YR3W+Lm//VdIEr+7oPL38aNJJY8bFKeMDrIN4lw3fll+OMxRYDPA7grvR6CIxqy+rfEaGlqqw12TSyYKkRNUGkqQAEMQhI6VgWLyu/MqCxzbtRCIamcoeABEolteCdG51KNBt75D+GauesXnplLOF+mtMIP8MUvE9bd576WK3ZtNcUXvS3QRI+7ABDoQaXUNwxgYTAke0CAaebQh86jQAYTsyp4fb91sXzxUf9mtAlGZo6x3Xc/SJsPHsSeX78mw81MQAZiIdthcbHdkeJVvCG2da4OQF0uwuZj2yhJv7jQ2OV2bQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjL6rwNFieDTJAyFhx388fKH82kms5L91P8U8RKQLn0=;
 b=cV8Dt/BPK1N0Fu3SJRMnRgosvJQtvey5AcpQA8fwlOA+M5/zE39iVZ/n3uXLrqCxQdzjwVohwl7kgGtkxqsNh8Juibg4iLNJwJfaovQDSIh7uKL3sZLpfjhcT2DDY/xN0qXYRsqFtqKgdtfGt2nt+RUR+GQvohG9A/kvZoobxtyk4N0wpXx3JUlEd6JGZL3cb7MqeknR09DKHuTpPN0WllIDWyVEAb5kUXJo7+uuuxejLCw3Bc9GYPylWyGNRN71C4dydOOvgDElWfJao9b/j6/p40mCscA/j12AE6u3b2t4s2Gv3VyRw98ktDpUeae8/O13H33twzJ8p57ng+q3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjL6rwNFieDTJAyFhx388fKH82kms5L91P8U8RKQLn0=;
 b=czh+wZ0ySBHkaMQK1o+09PI+1Wh4k53Ion2Exy4hw2Fs7u6LukLhMrlrlyiF+MTgNHlk3i1T3D8UYx3vObbFCR/JRaxUG49IFLGv44s8NlLi5tHcroyP5JvYSYm9zXm3kKoGUvvKkQG2i8jGsFXt25F0DJmHgVg3IxXXL7ZJfcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:16:41 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:16:41 +0000
Message-ID: <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
Date: Tue, 8 Mar 2022 10:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YicOku9HhC3wJUb8@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0069.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::46) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc61689-c05f-4b23-7ccd-08da00e45b38
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44561589C18F5453ECB55AFF83099@MN2PR12MB4456.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmU7qNjvyNfWEmBb743LGxCaUw9w4eAWGa2vQJf9vYRXfDFgZrkJLSVUGhJ3ltpt4RltazonS6pAahpbUBDokME1n3AwODKcF2UezUElslGqMQzJvbP6m7qlH548kua/dXPPKqODDDkWRKse9X5sO5mr/fVz/D7HeVctpbjK30mF1TWUpOXgKfGES1hpqNEvJ8jxx/2AQCOgShRxX8yq/+0hr5VPTpJ77cIXp6owaFKjbLMiLJnPHM9kMkgMWJmsPLe4B90fRo/XsAhiCZF7kShOO0AyKxdmCtnDNYV3Vt6ZtdO869Sk14ZBiw2fEgaUzYHFf2JHuv0Me2BDcz/1aZXBRJyvZZQgZuKZuA8cAQKegfaHbnOjElF8Vam9SUVJzCAAToCqS6HXjSKz8NrkKIh6Ga/U+2K1RDPgm0MU+Uwmv6Z6nheNJ1FiGpvMKvWamqmCld6Vi8csXZEoJeVRbVDl9E0X5XIhg6WaeJwUI0U1yW6+zn0zRB2fEEzTunJtJ8MFuX7iRPykGyR3RW6mVzUX19JoxEKIKroLkddEL6cQCWoEoCX5aCjecGdsXnzewtqZMyzqnwyCXp8wKZhLVaLACHEBKb4uxj7loz2E84yZDg5Ev/n2e+WADXGuN4WH94IrFz0JOgCS9uaTfmqi8rf+O9WrT30CXSjgzp2IkqMLDTm67XUyFlzJ3Tjv2qEU37poAdfhwUD6OmSOb4m2gQl1soC+Pxc7T9Xk6HLEGAsgy2znw3FPGX72UBm8LNA2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(110136005)(2616005)(66556008)(66946007)(38100700002)(36756003)(66574015)(54906003)(83380400001)(31686004)(316002)(6666004)(508600001)(6506007)(86362001)(5660300002)(8936002)(6512007)(186003)(26005)(2906002)(31696002)(66476007)(8676002)(4326008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhDRDc5T29iL0ZlWDE4TlRMbFphRXlybGhxMU9VQktraE91MEtCOGQyODVu?=
 =?utf-8?B?UlFJbmUzNVJ6V0g1NFhiYlNJekMvcndkeXJBYlhScTFoT1FsTy9WVEtValdV?=
 =?utf-8?B?Zm1LeEJOc0JyRjV4eEhvZUN0Z2tHMXRjT0syWDhJdU9uelhrOTBBWi85VGhn?=
 =?utf-8?B?Q3B4YkdUbC9tMSsveTNtTVI5WkxRcS9DRWt0c1dkU2d6RlVnVHcwbkg5K2RJ?=
 =?utf-8?B?cXJvUzRra2kxSmhxc29nd0IxVSs1eFh1SE9GOVQ4R3dXY0hGSWdCZk5vbk41?=
 =?utf-8?B?enhodGNtSCt2SmtVaEw1QjRhbmt5RzdWVDJjczYwa01uWTk0Z2ZFaEVvNFcw?=
 =?utf-8?B?eVZTa2ZSUnV4dU9oWUdhRzd4SXZDTHFFbzhjd1pYT21tMkFmT0tWaDlyUU5h?=
 =?utf-8?B?V3hGaDhqU0ExVm4wWU1TM2ZseVBMbTJoekdFZ0ZQWW1EbnFhb0ExNERwcGhW?=
 =?utf-8?B?MHBwMmJha3hEUW93VWdSMmFIWmFVYlhhVHNreit6WVhGMVpFcnJwZnp5WWhI?=
 =?utf-8?B?d3k0QkpjT09SWHZnWFVlc1ZrZGRlTEdzOCtDOGRUam5odG4wU1VLUjc0cmtT?=
 =?utf-8?B?K1VNcS9wUU1JbVVrQlVXUTJYdEszaGsxMktmdU4zcWZCVlBCOFNQZXhJaGRs?=
 =?utf-8?B?T3Z4S3l6SHdLcXNpQ0FzR1ZYV3FkaCs2c3FLMnR5TGs5V2RCaEMyazRzMzBj?=
 =?utf-8?B?YnprUjJ2ZU1sc1RKb3YrM0VFKzhTUFNVSmQzUlEyakZwQnhmaGVnTExSaG5W?=
 =?utf-8?B?ME9oVlpZb3JCbXcwYmtDTmVaRDU4VjQxbkgxSDBZSzFvV1lTQXpOSFU1eVZp?=
 =?utf-8?B?RVc3L1RrL0FHWGRsTm81UGkxbWZNUW41cStqaWJzNm5GUWgyTzFPdjk1d243?=
 =?utf-8?B?OE5yZitKV3lQajdhRVRVaVc4T3ZUa2tnbGxkWUZzenNpeDZsWW1wdThYR0Nm?=
 =?utf-8?B?dDRWV1A0TE5WVVhDVGhwd2lINjNYRUdVYWs1cU4yUVhiSFprNEZaRmpzcDVO?=
 =?utf-8?B?QmdjREJzeWd4YndqNkNFcWZRaW5oSjZ0Znh5RktGN3AwK3lPeGVrSkdSUjBM?=
 =?utf-8?B?c3ZaaFlIZmFiTnFUYzJPdHF5WFI2RXVXM01zUW5hd3RUS2FqNW5hZVRpeE1a?=
 =?utf-8?B?ODZqbG9XMEFOTjNmQTIvV09PTW5DdHdVK1NkWWtpVjhTZGJ2dElLTGp0cms0?=
 =?utf-8?B?ZzFzY3E0TDI1TUJ6SkNBTDNCai9XWlpoNjd0WHg0Qy9OT25vNE9vOGdtUzZ6?=
 =?utf-8?B?YTFrcnJxNHRjM2JEZ21lR3F1Z1FFVkFRNUNTMjhyVmN6TWxPU0t2MzU0amxN?=
 =?utf-8?B?K0dyenVOZmdQT29hUi9hRVFPTlN1MlFvbVNSMjhqVFUwTExSaW5lSCszelFE?=
 =?utf-8?B?ZkF0a0IrS2RrcGl1V0tESUpEdHE1OUFVWnRPTER3RCt3Ui9HbFE3azZBVHpC?=
 =?utf-8?B?L3F6bitGbFpvQXJvd2doZzNPZCs4THRLOWhISDh6TjRRNGtybEtmNEphVzdV?=
 =?utf-8?B?b005T2I2K2JMMUpEZGxUUFJYTk0wNnFjK3BlMG81VmxMRDVyTWRJWUxzL21V?=
 =?utf-8?B?MmhpZ0h1TXZBWXdLdkw5dTRQVUlqOVJtM1E0WkMvck9Pbk1jNFBkRm5JVlN0?=
 =?utf-8?B?d0pITnVkZkthR1BCRnA1MEpxNC9MRHh3QjJ5MTdvems4TDZmT3ZnWVpBMUN4?=
 =?utf-8?B?SnMyc3VXL0FqL1ZQQlZXSm9RdkIwTGNrQjBicmtCQ3pYbUNCRUEyR1pLZXdL?=
 =?utf-8?B?NDNlbXA1VUI0ZmVGMFI2SzhPaWZUUzgzSS91WjRhWkxTWm5Od25VR3FESGNY?=
 =?utf-8?B?czc3bHc5dXJ1TXJqTlM5R0hLcGEwT1pxSXE3UERodWdFU3EwRG44a2FhVUdQ?=
 =?utf-8?B?NHhJR2VvRXFrOTJrOG9UZHVBdFNtTzhPdTFZaHZCSjM4MEp6VWNLVkFVOHpL?=
 =?utf-8?B?bUFsaGJKWENiNzBVR2IxZHRHejVJczNNV2IxSnRLT3Rlcmg5cGR6UVNXWmJX?=
 =?utf-8?B?YTZsY01pL29Eci8zd0hzcFJKMVlrc2phZktDbWVnR0FRL1NqbER3eGtqbmFk?=
 =?utf-8?B?Nms4NGlTdkRBcUFCYTVkQ3VrVkNwVnZ4YnUxbVg3RDRiL1ZoTmlRaG44V1hL?=
 =?utf-8?Q?N+yg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc61689-c05f-4b23-7ccd-08da00e45b38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:16:41.3380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUO4TJNndHckXFnUonorTakfwh3xTpXpKI4ibN2urfFrIJupN0p5uguWaL0EcTLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.03.22 um 09:06 schrieb Lang Yu:
> On 03/08/ , Christian König wrote:
>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>> On 03/08/ , Christian König wrote:
>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>> backing stored TMZ buffer on Raven.
>>>>>
>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>> submission.
>>>>>
>>>>> v2:
>>>>>     - Use patch_cs_in_place callback.
>>>>>
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 +++++++++++++++++++++++++++
>>>>>     1 file changed, 68 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> @@ -24,6 +24,7 @@
>>>>>     #include <linux/firmware.h>
>>>>>     #include "amdgpu.h"
>>>>> +#include "amdgpu_cs.h"
>>>>>     #include "amdgpu_vcn.h"
>>>>>     #include "amdgpu_pm.h"
>>>>>     #include "soc15.h"
>>>>> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>>>     	.set_powergating_state = vcn_v1_0_set_powergating_state,
>>>>>     };
>>>>> +/**
>>>>> + * It is a hardware issue that Raven VCN can't handle a GTT TMZ buffer.
>>>>> + * Move such a GTT TMZ buffer to VRAM domain before command submission.
>>>>> + */
>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>>>> +				struct amdgpu_job *job,
>>>>> +				uint64_t addr)
>>>>> +{
>>>>> +	struct ttm_operation_ctx ctx = { false, false };
>>>>> +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>> +	struct amdgpu_vm *vm = &fpriv->vm;
>>>>> +	struct amdgpu_bo_va_mapping *mapping;
>>>>> +	struct amdgpu_bo *bo;
>>>>> +	int r;
>>>>> +
>>>>> +	addr &= AMDGPU_GMC_HOLE_MASK;
>>>>> +	if (addr & 0x7) {
>>>>> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
>>>>> +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	bo = mapping->bo_va->base.bo;
>>>>> +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>> +		return 0;
>>>>> +
>>>>> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>> +	if (r) {
>>>>> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
>>>>> +		return r;
>>>>> +	}
>>>> Well, exactly that won't work.
>>>>
>>>> The message structure isn't TMZ protected because otherwise the driver won't
>>>> be able to stitch it together.
>>>>
>>>> What is TMZ protected are the surfaces the message structure is pointing to.
>>>> So what you would need to do is to completely parse the structure and then
>>>> move on the relevant buffers into VRAM.
>>>>
>>>> Leo or James, can you help with that?
>>>   From my observations, when decoding secure contents, register
>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer address.
>>> And this way works when allocating TMZ buffers in GTT domain.
>> As far as I remember that's only the case for the decoding, encoding works
>> by putting the addresses into the message buffer.
>>
>> But could be that decoding is sufficient, Leo and James need to comment on
>> this.
> It seems that only decode needs TMZ buffers. Only observe si_vid_create_tmz_buffer()
> was called in rvcn_dec_message_decode() in src/gallium/drivers/radeon/radeon_vcn_dec.c.

Mhm, good point. Let's wait for Leo and James to wake up, when we don't 
need encode support than that would makes things much easier.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Lang
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +
>>>>> +	return r;
>>>>> +}
>>>>> +
>>>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>>> +					   struct amdgpu_job *job,
>>>>> +					   struct amdgpu_ib *ib)
>>>>> +{
>>>>> +	uint32_t msg_lo = 0, msg_hi = 0;
>>>>> +	int i, r;
>>>>> +
>>>>> +	for (i = 0; i < ib->length_dw; i += 2) {
>>>>> +		uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>> +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>> +
>>>>> +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>> +			msg_lo = val;
>>>>> +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
>>>>> +			msg_hi = val;
>>>>> +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>>>> +			r = vcn_v1_0_validate_bo(p, job,
>>>>> +					     ((u64)msg_hi) << 32 | msg_lo);
>>>>> +			if (r)
>>>>> +				return r;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +
>>>>>     static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>     	.type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>     	.align_mask = 0xf,
>>>>> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>     	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>     	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>     	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>> +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>     	.emit_frame_size =
>>>>>     		6 + 6 + /* hdp invalidate / flush */
>>>>>     		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +

