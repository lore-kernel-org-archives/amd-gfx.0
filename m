Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B175CDC195
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 12:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D7A10E2EA;
	Tue,  6 Jan 2026 12:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="QY3dkptY";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3E110E2EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 12:55:17 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6063BWlm026573;
 Tue, 6 Jan 2026 12:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=XBQztzUCclq8bBeN2xGKvGZTvsqIdl
 aPRq7YkjVYrC0=; b=QY3dkptY5YIuXUbTqShVVA7NOicnOQXbttNQ4YTcMU0JSf
 AdksIj+ijfSPJBUhn7AmDY4gFa+2llDMQjxP1VpJJk1VMMIu8pOd4blul6CouXHo
 m1VvMN/0rIjHVCQU3s5Jw8V1AZIQwrnFwP3BECASa4XP45pSNaT8zeduinrFDIk4
 yDpV6Xh8R3hY9X2mhqFiEHn0mft9hmUIEi1w3dgx4TdqqimXX5G6SeE6Qu4uJ+pe
 TR/r2xVSKbLh1CHUxDONKNHhqIIhsn0Td1amSwiHQrkacGyY5SRM1ggQVAfcEHXk
 uCz8IpSIxNEmPH15Y38lQEACCdXMf4XJwC25f+pw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtk2m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 12:55:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606ClWQI010445;
 Tue, 6 Jan 2026 12:55:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtk2kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 12:55:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606CKWAJ023487;
 Tue, 6 Jan 2026 12:55:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rm811f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 12:55:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606CssR016319036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 12:54:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 389755805A;
 Tue,  6 Jan 2026 12:55:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67C9858056;
 Tue,  6 Jan 2026 12:55:09 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 12:55:09 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------086fTYrQ2rT2jh4SEIxPkD0F"
Message-ID: <c28b117f-b3bb-42de-a1fb-a4dceccfbb72@linux.ibm.com>
Date: Tue, 6 Jan 2026 18:25:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
 <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d0633 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=i1_rtTS1CBzSE8fu5qYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zd2uoN0lAAAA:8 a=VakubJATnfHkqmAd:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: wZp0pDYes0fKimoC2wTWFfKpjt2j69q_
X-Proofpoint-ORIG-GUID: sssKpM45-Qq9fpa2Javi-B9j0M1gUsG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX87S3ahLOVJLH
 5y1ozLCNLHWnTU6LaqHGD8vnWN72ZdjC3hov8UiKIQeEC7Kv0FiIWoShgs7xt+uh3cMUL3tqljc
 hrgN0vp9uTxWFI2pMDbjs5mfv5Tnk4fm1JwMjuKXABWiTFcrG7WCjdrIidfaXxGm0ew1Q/A4SlQ
 wRCX1Atw7EYF8j7f5PnTgkCsPlKWAATMaluWsQr432PpcpCa+++AlWRyo5WW9BMaBzB/rn/5/1K
 3gfxDrIDjo7aBe0O9sMetbKc1Jp7jkzXFPaS1BKWqH0LlZlQYXkQo2DJbn4JITVRoL3307F8vUa
 XIdWb7I4PiimCfwYHb6aekXZYgbBM4LqhhZ0oZn6e5CcHZ8K57p+JhXTzl+IpcPswyunCvenTEU
 VOy7CE+eB0lbzI8GRCmZiwzSqPsq9/Tf4o21AFt/X+8UCookuV9SPI1YTphG2jWPf+GeiGRRuZy
 +CSeSXQ/gwiD2A6WTIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060106
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

This is a multi-part message in MIME format.
--------------086fTYrQ2rT2jh4SEIxPkD0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


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


Hi Christian, Felix, Alex and philip

Instead of hardcoding the AMDGPU_GTT_MAX_TRANSFER_SIZE value to 512,
what do you think about doing something like the change below?
This should work across all architectures and page sizes, so
AMDGPU_GTT_MAX_TRANSFER_SIZE will always correspond to the PMD
size on all architectures and with all page sizes.


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 0be2728aa872..c594ed7dff18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -37,7 +37,7 @@
  #define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
  #define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
  
-#define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
+#define AMDGPU_GTT_MAX_TRANSFER_SIZE   1 << (PMD_SHIFT - PAGE_SHIFT)
  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS

Could you please provide your thoughts on above? Is it looking ok to you?

If this looks good - here is what we were thinking:

Patches 1-4 are required to fix initial non-4k pagesize support to AMD GPU.
And since these patches are looking in good shape (since Philip has already
reviewed [1-3])- We thought it will be good to split the patch series into two.
I will send a v2 of Part-1 with patches [1-4] (will also address the review comments
in v2 for Patch-1 & 2 from Philip) and for the rest of the patches [5-8] Part-2, we
can continue the discussion till other things are sorted. That will also allow us to
get these initial fixes in Part-1 ready before the 6.20 merge window.

Thoughts?


>
> Regards,
> Christian.
>
>> Signed-off-by: Donet Tom<donettom@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
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
--------------086fTYrQ2rT2jh4SEIxPkD0F
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/12/25 2:23 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com">
      <pre wrap="" class="moz-quote-pre">On 12/12/25 07:40, Donet Tom wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The SDMA engine has a hardware limitation of 4 MB maximum transfer
size per operation.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is not correct. This is only true on ancient HW.

What problems are you seeing here?

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
512 pages, which worked correctly on systems with 4K pages but fails
on systems with larger page sizes.

This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
to match with non-4K page size systems.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is actually a bad idea. The value was meant to match the PMD size.</pre>
    </blockquote>
    <p><br>
    </p>
    <pre>Hi Christian, Felix, Alex and philip

Instead of hardcoding the AMDGPU_GTT_MAX_TRANSFER_SIZE value to 512,
what do you think about doing something like the change below?
This should work across all architectures and page sizes, so
AMDGPU_GTT_MAX_TRANSFER_SIZE will always correspond to the PMD
size on all architectures and with all page sizes.


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 0be2728aa872..c594ed7dff18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -37,7 +37,7 @@
 #define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
 #define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
 
-#define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
+#define AMDGPU_GTT_MAX_TRANSFER_SIZE   1 &lt;&lt; (PMD_SHIFT - PAGE_SHIFT)
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS  

Could you please provide your thoughts on above? Is it looking ok to you?

If this looks good - here is what we were thinking:

Patches 1-4 are required to fix initial non-4k pagesize support to AMD GPU.
And since these patches are looking in good shape (since Philip has already
reviewed [1-3])- We thought it will be good to split the patch series into two.
I will send a v2 of Part-1 with patches [1-4] (will also address the review comments
in v2 for Patch-1 &amp; 2 from Philip) and for the rest of the patches [5-8] Part-2, we
can continue the discussion till other things are sorted. That will also allow us to
get these initial fixes in Part-1 ready before the 6.20 merge window. 

Thoughts?</pre>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Ritesh Harjani (IBM) <a class="moz-txt-link-rfc2396E" href="mailto:ritesh.list@gmail.com">&lt;ritesh.list@gmail.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 0be2728aa872..9d038feb25b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -37,7 +37,7 @@
 #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
 #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
-#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
+#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
 
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------086fTYrQ2rT2jh4SEIxPkD0F--

