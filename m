Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54C2D4921D
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 12:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7691210E2BC;
	Fri, 12 Dec 2025 12:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="Z0JB+jbN";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2718825B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 12:14:34 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC3RW1M014495;
 Fri, 12 Dec 2025 12:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lRBRYe
 OUKjrkhRM3c47jKQPxXyt/A/Os+0siGsJeM7o=; b=Z0JB+jbNPWpqALzY6wSWPi
 b04xLMyAENqXPQ53vR1m03O4laR8pA5wykvkGQONSmlZGcimVXAf+ilirGVMGgu4
 SSF/xTFdd9ScSz6mlOQxZOxatK+by60kMqX8HEoZe8tVnYBg9Wu1yDHbisQs/e78
 fAEigXfTcqs1Fa/7ww0AWnnKmEsaWu0+uDQRPEQWgz2HUVA7h4BMUrdi7OsQDirV
 sjPAb70b3gfiZvIT/P4BzxFOEK9fmPCgqsyzdVJYLZ5u3BslVGWu0co1+IF8BX5C
 gnZKRPopqW8nV66YAe/vXD7NB5fTh3M740CyI2tLHURGnQvZp75MuY1KDuP5mYAw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53vb2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 12:14:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCCEWFO031527;
 Fri, 12 Dec 2025 12:14:32 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53vb2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 12:14:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCBTAad026807;
 Fri, 12 Dec 2025 12:14:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h1kfk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 12:14:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCCEUST29491744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 12:14:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D02CB58059;
 Fri, 12 Dec 2025 12:14:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 513555805D;
 Fri, 12 Dec 2025 12:14:28 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 12:14:27 +0000 (GMT)
Message-ID: <39652916-6c9e-497d-801e-23e38f93dee3@linux.ibm.com>
Date: Fri, 12 Dec 2025 17:44:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
 <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfXzvvUnlXajI72
 CHWrntMTLfxnGU3rPiKiqyHKpS/RblKjCLzzEj+VacuEPnyWXXaljxpPO6wDUc3MWY6tYAS9s5z
 myfApQ+64E/6q7NWsRHPwHOrg3CXYRhrcmX5kP4AYOiS/apmrlCHsbZxkOyFa4GdRLHfMR5qgkI
 zvegFc+91+1VtMNnRH7fPcYlXlMBMcnDzgpuLPhkSQ4iYyy4cRNh8hhTI2C2fjSLcrQsj1ZfMjX
 BKCAjSZFvFDBfiaNOhPoQQpwXrVX3IqWrzaWznyq8j4CGm+Pr5BZHGi930+MPTNcJIYa7/wcPgS
 bWF5ImLU4ZiD8EOJvDFzCfNRCP6Ytu8Q0LkAuaM9Sns7ufdMiBpoO7LE6QpfKmAebz9cP/W6/wr
 QjMwI5FVGaklHwuCVn+rjvI3QD7rHg==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693c0729 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=NFEJ4HaQLmvlPOxn2psA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ifv-5tHlYZ189XbNro6faVt0Rsde4MX1
X-Proofpoint-GUID: SBnwb5pgHNIoyWvOGtuy9FcAREFWLepp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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


On 12/12/25 2:23 PM, Christian König wrote:
> On 12/12/25 07:40, Donet Tom wrote:
>> The SDMA engine has a hardware limitation of 4 MB maximum transfer
>> size per operation.
> That is not correct. This is only true on ancient HW.
>
> What problems are you seeing here?
>
>> AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
>> 512 pages, which worked correctly on systems with 4K pages but fails
>> on systems with larger page sizes.
>>
>> This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
>> to match with non-4K page size systems.
> That is actually a bad idea. The value was meant to match the PMD size.


Hi Christian

Thank you for the reply.

In svm_migrate_copy_memory_gart(), the number of bytes to copy passed to 
amdgpu_copy_buffer() is based on the PMD size. On systems with a 4K page 
size, the PMD size is calculated correctly because 
AMDGPU_GTT_MAX_TRANSFER_SIZE is 512, and 512 × 4K = 2MB.

On systems with a 64K page size, however, the calculation becomes 512 × 
64K = 32MB. As a result, amdgpu_copy_buffer() ends up copying data in 
4MB chunks instead of PMD-sized chunks. To ensure consistent behavior 
across both 64K and 4K page-size systems, we adjusted the transfer size 
so that the maximum transfer remains 2MB, matching the PMD size.

The issue we observed was that the rocr-debug-agent test triggered SDMA 
hangs. This happened because an incorrect size was being passed when 
copying the GART mapping in svm_migrate_gart_map(). That problem was 
addressed in patch 3/8. While root-causing that issue, we also 
identified this inconsistency between 4K and 64K systems, So we felt 
that this change was needed to align the behavior with 4K system page sizes.



>
> Regards,
> Christian.
>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 0be2728aa872..9d038feb25b0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -37,7 +37,7 @@
>>   #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
>>   #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>>   
>> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
>>   
>>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
