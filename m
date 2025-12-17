Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825BAD64095
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFB610E592;
	Wed, 17 Dec 2025 09:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="kNoosXG7";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6AE10E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:05:01 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH7iv3a012679;
 Wed, 17 Dec 2025 09:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RxF7zF
 L2/8p4bPpKESwlr5dbV2DJmsbLTJtpTaB0zt4=; b=kNoosXG7Gg/WiWnkd79wDq
 tNs1XXJt31yH/vYNwNtw1u7D/KygXY9jj9gwoJY0tsS3G8Br+ScFmElGiZIhcmv1
 GkHquTqR89tbOdQ0HWhEVm0sP4xdGAJoz58WGfg9mWwDwbTx6C/JMdUcsKmTy+4r
 z+XXoDgH14OcmFfviVHg/Z0B9iUN5Bd3FWrbejF2xEdN9TZ8mRZwmfK9n4QJj7jZ
 isnFASyueTq8JYBnWxs9wDP+GgT9XdIgGzPFMm1eFVCNCPrqAeBdZpaSWj4DbiWN
 snrbDzS2UP0gg0PgKN4/jc3WOpvJ6aXC4rcH4Z9fFY+PkBw2+Vc82wJ/+5Yhb8Pw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvbyvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:05:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH90l6g022000;
 Wed, 17 Dec 2025 09:04:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvbyvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:04:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH6Kx6k012800;
 Wed, 17 Dec 2025 09:04:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy9gkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:04:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BH94vfG52888062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Dec 2025 09:04:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1212058066;
 Wed, 17 Dec 2025 09:04:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D451058065;
 Wed, 17 Dec 2025 09:04:53 +0000 (GMT)
Received: from [9.39.19.148] (unknown [9.39.19.148])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Dec 2025 09:04:53 +0000 (GMT)
Message-ID: <d677a973-e17a-4057-a4b1-af16925243be@linux.ibm.com>
Date: Wed, 17 Dec 2025 14:34:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
 <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
 <50dee2c9-bcfc-462b-bf46-f110a082e2d3@amd.com>
 <45654396-6b21-4599-aeb9-0fed68135675@linux.ibm.com>
 <a25b3fc8-4a13-49c6-8011-9830a53cf3c9@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <a25b3fc8-4a13-49c6-8011-9830a53cf3c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX83Kvt4cAy+Tm
 EMJQxcz4FqVn1podSIwCRGIoe3VCIB1wgngEf/1Lu1CAhFMgCrKOswKabB6voeAGLVO4JExma6J
 ABeKW3W8b4Ak4YXArstu23bHuRlqQRIG2x9Oajj+hTSOxyA1adcuhGZUgroTRXwBtXhSduPZWlc
 /dxgLM+dH/hydlzabX0dP1hikBAO+qXlpkWCrl/TPfL0pPfdBj7Vn4dgBeGdmMETnLgpPuQ3NPC
 1Tk++PniA4Kyibd/DxgVTVGtEnM5v2P1Y/uKd6paNTqtGGGU7sre9jw+bNnvSUEzLKS4G8uwo6w
 muYdoAXbp8/dWO3jzdsSm14WVERfC8nVYSbOWz60M6asSLL5p6jPwJnN7sNTE/Q6VULQiALtjsW
 7QWpqee4LMJA7OwhD+LtUfAwLUIoiw==
X-Proofpoint-ORIG-GUID: r1JY2RETZIg0r-rvL7r48Ui4CkHnmCaz
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6942723c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=y_DjlmFtwXc1XXJwBUgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h2S7nz45SGRJMFQiPnbARF64dVkpxo00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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


On 12/16/25 9:36 PM, Christian König wrote:
> On 12/16/25 11:08, Donet Tom wrote:
>>> The GPU page tables are 4k in size no matter what the CPU page size is and there is some special handling so that we can allocate them even under memory pressure. Background is that you sometimes need to split up higher order pages (1G, 2M) into lower order pages (2M, 4k) to be able to swap things to system memory for example and for that you need some an extra layer of page tables.
>>>
>>> The problem is now that those 4k pages are rounded up to your CPU page size, resulting in both wasting quite some memory as well as messing up the special handling to not run into OOM situations when swapping things to system memory....
>>>
>>> What we could potentially do is to switch to 64k pages on the GPU as well (the HW is flexible enough to be re-configurable), but that is tons of changes and probably not easily testable.
>>
>> If possible, could you share the steps to change the hardware page size? I can try testing it on our system.
> Just typing that down from the front of my head, so don't nail me for 100% correctness.
>
> Modern HW, e.g. gfx9/Vega and newer including all MI* products, has a maximum of 48bits of address space.
>
> Those 48bits are divided on multiple page directories (PD) and a leave page table (PT).
>
> IIRC vm_block_size module parameter controls the size of the PDs. If you set that to 13 instead of the default 9 you should already get 64k PDs instead of 4k PDs. But take that with a grain of salt I think we haven't tested that parameter in the last 10 years or so.
>
> Then each page directory entry on level 0 (PDE0) has a field called block fragment size (see AMDGPU_PDE_BFS for MI products). This controls to how much memory each page table entry (PTE) finally points to.
>
> So putting it all together you should be able to have a configuration with two levels PDs, each covering 13 bits of address space and 64k in size, plus a PT covering 18bits of address space and 2M in size where each PTE points to a 64k block.
>
> Here are the relevant bits from function amdgpu_vm_adjust_size():
> ...
>          tmp = roundup_pow_of_two(adev->vm_manager.max_pfn);
>          if (amdgpu_vm_block_size != -1)
>                  tmp >>= amdgpu_vm_block_size - 9;
>          tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
>          adev->vm_manager.num_level = min_t(unsigned int, max_level, tmp);
>          switch (adev->vm_manager.num_level) {
>          case 3:
>                  adev->vm_manager.root_level = AMDGPU_VM_PDB2;
>                  break;
>          case 2:
>                  adev->vm_manager.root_level = AMDGPU_VM_PDB1;
>                  break;
>          case 1:
>                  adev->vm_manager.root_level = AMDGPU_VM_PDB0;
>                  break;
>          default:
>                  dev_err(adev->dev, "VMPT only supports 2~4+1 levels\n");
>          }
>          /* block size depends on vm size and hw setup*/
>          if (amdgpu_vm_block_size != -1)
>                  adev->vm_manager.block_size =
>                          min((unsigned)amdgpu_vm_block_size, max_bits
>                              - AMDGPU_GPU_PAGE_SHIFT
>                              - 9 * adev->vm_manager.num_level);
>          else if (adev->vm_manager.num_level > 1)
>                  adev->vm_manager.block_size = 9;
>          else
>                  adev->vm_manager.block_size = amdgpu_vm_get_block_size(tmp);
>
>          if (amdgpu_vm_fragment_size == -1)
>                  adev->vm_manager.fragment_size = fragment_size_default;
>          else
>                  adev->vm_manager.fragment_size = amdgpu_vm_fragment_size;


Thanks Christian

I will try it.


> ...
>
> But again, that is probably tons of work since the AMDGPU_PAGE_SIZE macro needs to change as well and I'm not sure if the FW doesn't internally assume that we have 4k pages somewhere.
>
> Regards,
> Christian.
