Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9877BD1A613
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 12:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AFC10E8BE;
	Fri,  9 Jan 2026 12:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="rwHM5m0F";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC6C10E8BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 12:58:01 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 609BQke2004324;
 Fri, 9 Jan 2026 12:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2nqxj0
 05IjQyp5ur4CynBq/joOtETLcbPrpnMdYApMk=; b=rwHM5m0FoWCkxcSbWHIYgw
 DJ+C+O6daQCfFyzuG4hJHUu7yNBHxTj3rEF7DZTFJ/dDet4lMgaDJPYZSKGcqxWJ
 bcT/mqz3HmdeSmkLZkqgo7tdkSQsQoN8Sd4EA7C1B8FKbWeN5ZWUXY2/uZdpbujN
 LYlxJqQiHwXWoN5F7kuSumzkazdhAinQcFP30b6aU22DEdCtpmDT60q30n+kFAyS
 mfNpchzsAKsF0JXPzNclgVh/wz8Oszn6EiFuOHsIldWdWH79jZxW0KdGG9dVB4u6
 TGa+x7VX34cEkhVF5hYzFY0SLMRcrnEBW3CQk27+QAEwhwQdGy3dwR+4CJ0eM3kg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6kad4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 12:57:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 609CvxHU012824;
 Fri, 9 Jan 2026 12:57:59 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6kad1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 12:57:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609BAtCI019161;
 Fri, 9 Jan 2026 12:57:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51mk3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 12:57:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 609CvuTH32047712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jan 2026 12:57:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3006158052;
 Fri,  9 Jan 2026 12:57:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30F2658062;
 Fri,  9 Jan 2026 12:57:53 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Jan 2026 12:57:52 +0000 (GMT)
Message-ID: <85ad5b59-cedb-409f-a670-972a5d7013a2@linux.ibm.com>
Date: Fri, 9 Jan 2026 18:27:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
 <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
 <c28b117f-b3bb-42de-a1fb-a4dceccfbb72@linux.ibm.com>
 <430ac9a5-8665-4f0a-a658-5266668bc846@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <430ac9a5-8665-4f0a-a658-5266668bc846@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=6960fb57 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Plcl0eGns2TPwASHvvsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9DNE9gu88-LmZgnjuvbfmu4D48IIylrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5NCBTYWx0ZWRfXxfo1gPjvcjAg
 EhBKNg8PaCyb4P3MXU4isDjPBjruIXSaCfoDb92Fh1zQ92BeAxG1lC3eWLzhdwMj9UIqRXvPlFn
 K3foAWzMSWtgdeivHl1BZ9rO3uy+mx3d+UeqAp4eKsbBLJaO0aBdUg+VCanXGdtG5wFl6I0wWc5
 OrKvgA/7YinRw+EicnWmP3xJqc+TxSrjwAyzlGzOmloIKtQMOstrKnJb+u67gi5CRZj+qCkaF+/
 7jEuHbp8F3BNom3cTMecFJxIa/6qs9CI3d9ccSq8VQB4DSS5uTWmSEvUGRJLgXtZxHA0x2pdfPC
 EJCSW4ZEFwQ8e8y2kRSjRIICuFy8WBQGbvbaLTyjCZRg+/nRn3GLfXQp5hPqay2YgM3Zya7DRqT
 fENLFPzloBqXvyXonzHlwifIOweOpSZFeqCnF0hXNTNH2dbDBFTv3egLqI/a5Q40WyZJou2jG+W
 7g1o0hfQ12zx4Jwkg6w==
X-Proofpoint-GUID: 0sqBw0cnFExn4rafUWMP278nQmd1ZBuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090094
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


On 1/8/26 6:01 PM, Christian König wrote:
> On 1/6/26 13:55, Donet Tom wrote:
>> On 12/12/25 2:23 PM, Christian König wrote:
>>> On 12/12/25 07:40, Donet Tom wrote:
>>>> The SDMA engine has a hardware limitation of 4 MB maximum transfer
>>>> size per operation.
>>> That is not correct. This is only true on ancient HW.
>>>
>>> What problems are you seeing here?
>>>
>>>> AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
>>>> 512 pages, which worked correctly on systems with 4K pages but fails
>>>> on systems with larger page sizes.
>>>>
>>>> This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
>>>> to match with non-4K page size systems.
>>> That is actually a bad idea. The value was meant to match the PMD size.
>>
>> Hi Christian, Felix, Alex and philip
>>
>> Instead of hardcoding the AMDGPU_GTT_MAX_TRANSFER_SIZE value to 512,
>> what do you think about doing something like the change below?
>> This should work across all architectures and page sizes, so
>> AMDGPU_GTT_MAX_TRANSFER_SIZE will always correspond to the PMD
>> size on all architectures and with all page sizes.
>>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 0be2728aa872..c594ed7dff18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -37,7 +37,7 @@
>>   #define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
>>   #define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
>>   
>> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
>> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE   1 << (PMD_SHIFT - PAGE_SHIFT)
>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS
>>
>> Could you please provide your thoughts on above? Is it looking ok to you?
> It's at least reasonable. My only concern is that we have patches in the pipeline to remove that define and make it independent of the PMD size.
>
> @Pierre-Eric how far along are we with that?
>
>> If this looks good - here is what we were thinking:
>>
>> Patches 1-4 are required to fix initial non-4k pagesize support to AMD GPU.
>> And since these patches are looking in good shape (since Philip has already
>> reviewed [1-3])- We thought it will be good to split the patch series into two.
>> I will send a v2 of Part-1 with patches [1-4] (will also address the review comments
>> in v2 for Patch-1 & 2 from Philip) and for the rest of the patches [5-8] Part-2, we
>> can continue the discussion till other things are sorted. That will also allow us to
>> get these initial fixes in Part-1 ready before the 6.20 merge window.
>>
>> Thoughts?
> Sounds reasonable to me.


Thanks Christian.


>
> Regards,
> Christian.
>
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 0be2728aa872..9d038feb25b0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -37,7 +37,7 @@
>>>>   #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
>>>>   #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>>>>   
>>>> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
>>>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
>>>>   
>>>>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
