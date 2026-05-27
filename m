Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B4BCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 12:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B69810E1FC;
	Wed, 27 May 2026 12:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="SuKHpDBa";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8548210E1FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 12:56:45 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QL4fiR3594720; Wed, 27 May 2026 12:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3jk8ZD
 PSd66fE+M+C8bYgYwEKurE+lKDjbgQvOpr2pY=; b=SuKHpDBaJshgcDUsjAHBWt
 K8n616c0obEvaGlux++ZJMSV/v841Fm043Dw5OZG79eNKcWvqtuEsRDRfJQ/VBO8
 cTj1OwVAvUo0Q8V3nvajISLqB8hWEfKocpr33YbOmky8elBGxi861+7IjC3o9+II
 u65hpY++D4wOaSzBe3uqW54GXAOMNa9tOyHHjinaFifD89WB6Z7UnPA1PhlMVJJV
 B1bvAj+pVGehQTlmZHCj0hJLzbMfP9ozY4qN9ubZNqHS+d37GeKWYw/dsUFGJxET
 NdWd86PJ/kqvmizCgTXUPYE5yw9iC2HG17CmTGRKUFRICavfH5WRFxiVYw1z3yow
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2hb40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 12:56:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RCsri5017994;
 Wed, 27 May 2026 12:56:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbu1pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 12:56:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64RCufOl28181226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2026 12:56:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE82D58059;
 Wed, 27 May 2026 12:56:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE9AB58043;
 Wed, 27 May 2026 12:56:36 +0000 (GMT)
Received: from [9.39.20.122] (unknown [9.39.20.122])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 May 2026 12:56:36 +0000 (GMT)
Message-ID: <883eba2d-bfae-4aa7-8010-c644ccda245a@linux.ibm.com>
Date: Wed, 27 May 2026 18:26:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K
 page size systems
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, timur.kristof@gmail.com
References: <20260527111750.1084088-1-donettom@linux.ibm.com>
 <ee06fb47-75bc-4f22-ad0d-a7c1a2c8a413@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ee06fb47-75bc-4f22-ad0d-a7c1a2c8a413@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: miEBFBPC2IwTCEH9IRKyLeHKN7N70MaS
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a16ea0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=0NibiDd3CSERIWqxv5MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEyMyBTYWx0ZWRfX2aAq9wOKiSAu
 gXc+Us/Wm1nLILBqxWY4kuD6Hs8PyYaCAsaLngyd/3ZJ5faak06kU4I9MS2R/CPyZrN3yt4nCd6
 JNMVfv3r/cgI4hyL4F4GaSXcklobFPbQz+3rERiGzUGHEcMJiaiWPA1gRCE5dEBDXF1pPOyTzpx
 bIR0ALW0ZwbUKDKM3K+USUp/Qh8mAgPWMCdsQZWuDcdGTC8n7+dE0q1EqofFX7hujYk8rx1miZg
 qP5/CM2/hlsnuu21rE80tuQ7RbkvWJ9CV324gQqynFM2D0bHr6W1lSu2rn/1I0s5+HmZ+HnCu1e
 5pMlB8rv7UQdeOzXhSMbjLrpZY31tF6B65eVA+ea3tZFiKQTRvwROXBadI76rI3Id2ehHrI2Xma
 F6UhkKBKw9HQ/IBDmcZGPcbCqF0E3H5GBJmt7dSYt07u0F4CwDCjarRUsHeEnCsu9ZflAhpYhva
 hjPoKPGy1Ym8VByu5sQ==
X-Proofpoint-ORIG-GUID: fZ7yiC_SNsUh6TF1QRW9WSwKO3JF1eVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270123
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


On 5/27/26 5:24 PM, Christian König wrote:
>
> On 5/27/26 13:17, Donet Tom wrote:
>> When mapping VRAM pages into the GART page table,
>> amdgpu_gart_map_vram_range() assumes that the system page size is the
>> same as the GPU page size.
>>
>> On systems with non-4K page sizes, multiple GPU pages can exist within
>> a single CPU page. As a result, the mappings are created incorrectly
>> because fewer page table entries are programmed than required.
>>
>> Fix this by programming the mappings correctly for non-4K page size
>> systems.
>>
>> Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>> v1 -> v2
>> - Addressed Felix's comment by updating the definition of
>>    amdgpu_gart_map_vram_range() to support non-4K page sizes.
>>
>> v1 - https://lore.kernel.org/all/20260522112838.1311531-1-donettom@linux.ibm.com/
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index b6f849d51c2e..66a15ee13b57 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>>   				uint64_t start_page, uint64_t num_pages,
>>   				uint64_t flags, void *dst)
>>   {
>> -	u32 i, idx;
>> +	u32 i, j, t = 0, idx;
>> +	u64 page_base;
>>   
>>   	/* The SYSTEM flag indicates the pages aren't in VRAM. */
>>   	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
>> @@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>   		return;
>>   
>> -	for (i = 0; i < num_pages; ++i) {
>> -		amdgpu_gmc_set_pte_pde(adev, dst,
>> -			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
>> +	page_base = pa;
>> +	for (i = 0; i < num_pages; i++) {
> Please make that for (i = 0, t = 0; .... and remove the initialization of t during deceleration.


Thank you Christian

I will send a v3 with this chanage

-Donet

>
> I was about to complain that t isn't initialized because I missed the line above.
>
> Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>.
>
> Regards,
> Christian
>
>> +		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
>> +			amdgpu_gmc_set_pte_pde(adev, dst, start_page + t, page_base, flags);
>> +			page_base += AMDGPU_GPU_PAGE_SIZE;
>> +		}
>>   	}
>>   
>>   	drm_dev_exit(idx);
