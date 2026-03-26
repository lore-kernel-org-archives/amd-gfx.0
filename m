Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C45210A62D6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 13:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7B810EA1E;
	Thu, 26 Mar 2026 13:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="qM/6m6kx";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9817D10E308
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 13:37:22 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QD3J3G3548859; Thu, 26 Mar 2026 13:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=P7c/CF
 G8zxiLgQYxpQHUX53jmYV6LOdCbqhVOaqssLM=; b=qM/6m6kx5iBWkY2/plXuUu
 GipikUY98FsyLaTQK4lVCfR0kRLAe/9ZYfr8+vRnCgg/luUchZ2AdNOUhqmrXtgF
 Wz9q73sRl0rIsTuusgtX34rZME/NJE2j3lA1tidRBQ5B0xhnlWKSRVPpNRwGdpMD
 /XUt+VnfBSJgRodNTguPS3ZbqNBALpiu6nOxSKHs1CQnwjIxfgwBpQ9lEvupKRju
 FvLcLBs+gJGGPm4ugBarAKzn4oYjB8PfUTmtHYd87ndXbqLloaIP8dH91XUUjtcs
 5b4n5pYa3E+l2iYDwgB26AO12JrLsYVA8tIr0wdRHP0Xu2DiX7+Fl8yowUjZWv7g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqnfj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 13:37:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAq207009118;
 Thu, 26 Mar 2026 13:37:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnu5e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 13:37:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QDbHfU12124892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 13:37:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D834A5805C;
 Thu, 26 Mar 2026 13:37:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B338258051;
 Thu, 26 Mar 2026 13:37:17 +0000 (GMT)
Received: from [9.61.251.205] (unknown [9.61.251.205])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 13:37:17 +0000 (GMT)
Message-ID: <cb64b92e-6749-4ffa-a622-7d9ea352f51f@linux.ibm.com>
Date: Thu, 26 Mar 2026 08:37:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, =?UTF-8?Q?Dan_Hor=C3=A1k?=
 <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 Donet Tom <donettom@linux.ibm.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
 <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
 <5x6knm5q.ritesh.list@gmail.com>
 <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
 <341nolfr.ritesh.list@gmail.com>
 <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
 <1ph6ooyc.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <1ph6ooyc.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SkmfrxFAFge6aiBFuCe-9I7V69Np-h-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfXxi0SDK2T29Xp
 NUK0zTyuYunpRzwuYeznW/6+gsic0EJgw+nQA2k1NLNlxbJ1bf8/iznhJOOHiVteYnfzCiOHDja
 ktHDYX+sSiaSvMSxkmDe20H6KUmNavFBgoMV3eEr1rlT4xxQ+53zK+Vc5gttw/gSmuz28IKZhII
 s8ZW5vnAvAgkUWwAOqDO40VxNvnfKpI9V/yz8N879XYYUNXNYxHSswKMvpIdeFJklOxfgbEPhhZ
 2T7vKMzLIk5L0F8WsmuZ0JPzzwveKf/bC5fAEqDIWBE4GPr2LgFvNgGLP3d6z7R2wRkPno0G8l/
 UDoCumeqRYUncd4xJWqSwJvmWzINvAplFejZUGn031F5pWYqWcMfevUqsqOyUFoyjqJ5Wwm+MAl
 TUxa0bwqFbBhTqT3WcUOAZgn+ZEDgjtvtDhNUe53YTh7pSSqkUWTEGAYbeit8hzuVUQFMKcTw4l
 nlT5IoyK5U1DeCWqu4Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c53690 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=uAKUDkwnAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=dFWNSFL3s1b0WEMLFdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=lN7tEWgsE9RogSd6Vyyi:22
X-Proofpoint-GUID: cqgDZrrqfau6syr0sa10POMnOiOB9qVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260093
X-Mailman-Approved-At: Thu, 26 Mar 2026 13:57:22 +0000
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

Thanks a lot Dan for testing Ritesh's patch.

@Ritesh, I need to test the 2 scenarios for which I sent the first patch,

Thanks,

Gaurav

On 3/26/26 5:38 AM, Ritesh Harjani (IBM) wrote:
> Dan Horák <dan@danny.cz> writes:
>
>> Hi Ritesh,
>>
>> On Wed, 25 Mar 2026 23:12:16 +0530
>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>>
>>> Gaurav Batra <gbatra@linux.ibm.com> writes:
>>>
>>>> Hello Ritesh
>>>>
>>>> I think, what you are proposing to add dev->bus_dma_limit in the check
>>>> might work. In the case of PowerNV, this is not set, but
>>>> dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it
>>>> was before.
>>>>
>>>> Also, since these both are set in LPAR mode, the current patch as-is
>>>> will work.
>>>>
>>>> Dan, can you please try Ritesh proposed fix on your PowerNV box? I am
>>>> not able to lay my hands on a PowerNV box yet.
>>>>
>>> It would be this diff then. Note, I have only compile tested it.
>>>
>>> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
>>> index 73e10bd4d56d..8b4de508d2eb 100644
>>> --- a/arch/powerpc/kernel/dma-iommu.c
>>> +++ b/arch/powerpc/kernel/dma-iommu.c
>>> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>>>   }
>>>   bool arch_dma_alloc_direct(struct device *dev)
>>>   {
>>> -       if (dev->dma_ops_bypass)
>>> +       if (dev->dma_ops_bypass && dev->bus_dma_limit)
>>>                  return true;
>>>
>>>          return false;
>>> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
>>>
>>>   bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>>>   {
>>> -       if (!dev->dma_ops_bypass)
>>> +       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>>>                  return false;
>>>
>>>          return is_direct_handle(dev, dma_handle);
>> this seems to fix the amdgpu initialization, full kernel log available
>> as https://fedora.danny.cz/tmp/kernel-7.0-rc5.log
>>
>> Tested-by: Dan Horák <dan@danny.cz>
>>
> Thanks a lot Dan!
>
> @Gaurav,
> In that case, please feel free to take the diff and submit an official
> patch (if you think this looks good for all cases). You might want to
> test your previous usecase once, so that we don't see any new surprises
> there :)
>
> -ritesh
