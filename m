Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF803109C04D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 18:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792EF10E827;
	Wed, 25 Mar 2026 18:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="LalpDEiV";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3929010E82B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 18:05:00 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P6WbTD3448655; Wed, 25 Mar 2026 18:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CffkZY
 SLtF7pdkPdtJ8cnop0B6jjmHh/XrdKtHonmzU=; b=LalpDEiVSAVCCItW2Vt3JK
 eU8/jiJQ2NPLpKBPQuo6V9aC8hy1Qry0/tBVDx/937rXR2uEVmT7pvWC2Vm0xiS5
 n7umqLfV4lx01g/j7qOkXnBMcURJZUcFQFWjZsbIn9m9vlShN//m5xac7Tbt0/Vc
 KSTJQ2kN+dZhkRaQ1DL9q+UDOTeCZT+5INHu40D2c9Rpbgic0UhRgvHNTel3k0Dt
 mqHN/kB1YXpDjA8RUKOi1MLd5M4ybz6He5mfYtjnIlCv9HEI5GGSh5MDFokMDrgc
 W/igmlk6LGuQPeAxsRbrSs8vkYX76GmCVLuu4oJWZdZyjRTl82KCiBWda8/weCrw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa1sr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 18:04:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PG9fC4012213;
 Wed, 25 Mar 2026 18:04:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk7frx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 18:04:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PI4u9519595812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 18:04:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C8D858056;
 Wed, 25 Mar 2026 18:04:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1FBE5803F;
 Wed, 25 Mar 2026 18:04:52 +0000 (GMT)
Received: from [9.39.25.125] (unknown [9.39.25.125])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 18:04:52 +0000 (GMT)
Message-ID: <5cad327b-55bd-4cc9-96a4-54318f1b4588@linux.ibm.com>
Date: Wed, 25 Mar 2026 23:34:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults
 correctly on non-4K page systems
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>,
 David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
 <3a5ed765-3a50-446d-bd26-aa09dfe3d6a2@amd.com>
 <CADnq5_Mc5TEBXD+sTLmT2ew6KKH++=8YjN=3N9d_bWUqqKgMRA@mail.gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <CADnq5_Mc5TEBXD+sTLmT2ew6KKH++=8YjN=3N9d_bWUqqKgMRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: tXNFNzbV8tR7jWrQz-aU-46q1AKBFShj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyOSBTYWx0ZWRfX6Nml7kl5UW/T
 0moMqp0cya4NxAdLUXuR7ys47pwG/Fk4ufagHVWlOxUUlSZDFTBXYyOVBVvt4Rll/m+p9xikRL9
 ga1M9RkNcR1yXa/DA3d7gqvYvZFbAUusKt39z57Q5LMg24pgePDnwpw4QgMxGVf865DVCBkMwOj
 vp52inxoS+GYpBsjUlk+cF6E04gHlUVF/vtnl4jDnM7xH5/GRsp5IClJTgkGiN3TxKgarYvFRGD
 vwcZ+Fbrah8ETFp8zQ5TYY9god4k/FamUlbnrCsZx51Gl4JBTuKUlcwmjTOxbz1T0SxGmjkDGcv
 ju+LjW3ubPqOcGdHp47f8QM5Bnkb0ZSfuSlrYrTalfzycs755OD1AE+x0rjkFUzQPhHC2I5kIy7
 mK9p8eZAIFy+cw6tYOoY2Z6OSBF6WbTff6jC7LhdVU+Lwz/dtZrxC8TIO1H05K4Iofm+d8Ifd4M
 Tld/WHroEiiF17v4ZCw==
X-Proofpoint-GUID: mGswtYATQJH5E5WAhViY3TN8ZWAmv9_W
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c423ca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zd2uoN0lAAAA:8
 a=VnNF1IyMAAAA:8 a=7Sst9kd9WwLXTlGBOzgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250129
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


On 3/24/26 6:40 PM, Alex Deucher wrote:
> Applied.  Thanks!

Hi @Alex

Thank you for applying this patch.


I am planning to send the next version for PATCH 1/6. For the
other patches that have already received Reviewed-by tags,
would you prefer to pick them from this series, or should I
include them again in the next version?

-Donet


>
> Alex
>
> On Mon, Mar 23, 2026 at 9:04 AM Christian König
> <christian.koenig@amd.com> wrote:
>> On 3/23/26 05:28, Donet Tom wrote:
>>> During a GPU page fault, the driver restores the SVM range and then maps it
>>> into the GPU page tables. The current implementation passes a GPU-page-size
>>> (4K-based) PFN to svm_range_restore_pages() to restore the range.
>>>
>>> SVM ranges are tracked using system-page-size PFNs. On systems where the
>>> system page size is larger than 4K, using GPU-page-size PFNs to restore the
>>> range causes two problems:
>>>
>>> Range lookup fails:
>>> Because the restore function receives PFNs in GPU (4K) units, the SVM
>>> range lookup does not find the existing range. This will result in a
>>> duplicate SVM range being created.
>>>
>>> VMA lookup failure:
>>> The restore function also tries to locate the VMA for the faulting address.
>>> It converts the GPU-page-size PFN into an address using the system page
>>> size, which results in an incorrect address on non-4K page-size systems.
>>> As a result, the VMA lookup fails with the message: "address 0xxxx VMA is
>>> removed".
>>>
>>> This patch passes the system-page-size PFN to svm_range_restore_pages() so
>>> that the SVM range is restored correctly on non-4K page systems.
>>>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 6a2ea200d90c..7a3cb0057ac5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2985,14 +2985,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>>        if (!root)
>>>                return false;
>>>
>>> -     addr /= AMDGPU_GPU_PAGE_SIZE;
>>> -
>>>        if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
>>> -         node_id, addr, ts, write_fault)) {
>>> +         node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
>>>                amdgpu_bo_unref(&root);
>>>                return true;
>>>        }
>>>
>>> +     addr /= AMDGPU_GPU_PAGE_SIZE;
>>> +
>>>        r = amdgpu_bo_reserve(root, true);
>>>        if (r)
>>>                goto error_unref;
