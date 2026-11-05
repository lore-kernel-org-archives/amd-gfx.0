Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15C606A328
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NzOkfdez;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R89fOK0Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1909E112C9C;
	Fri,  6 Nov 2026 09:26:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA0210E336
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 19:00:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeTj54075413
 for <amd-gfx@lists.freedesktop.org>; Thu, 5 Nov 2026 18:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fKmGaERdq76NSgO632d0eHUfScDrvJoRi4zomrB3Dnw=; b=NzOkfdezhrfXCyzR
 RKSxvDRJRbatPUweG5tVj9zCMQHVJGSooPRm2jvZzVnznbyNsmEtj+PfSBmEcPFh
 /XBHmMQZd/ZAOqaY6q+t+z95W5GJGu5mjxG2ffPl3CSs7k9vQ+JRASGBTn4PZEPX
 c5GbNh7kXjk+8WTsD4EIVEuT9RkxLGWJltJPfIYFIZzXcNTXwNFK/aSw6vuvzyUL
 2PE6zulP+qQKLDiE1g2VRObWE90WFvaCQljcXrkvwMquCrtzGr+Jw6HrN46lQCEP
 qJigW+x/kucOZOPNtdDop98LfTZXYwhGlO8Cc0rUvRGefaqsxBhO8kCCN8NC3aDB
 x2LzAQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdt4gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 18:59:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso4083608eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793905199; x=1794509999;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fKmGaERdq76NSgO632d0eHUfScDrvJoRi4zomrB3Dnw=;
 b=R89fOK0QQMlGaT4Eyi8NFBTe3FudtKAp19nCsAVNFwWpkI9P6AtgINBuv721lGfHaT
 ZhZronun1xGQphzAEpaePRDP9wjFoDRmFpinrrbB3iTYIJaG/hH5h2RC3WlsNyjcntnc
 TElXz+6sciB8ofsrvolRFt5opMH2d7ICamCnlerEflB5wg5t1RWRir/vcjNnWbArURtx
 oXAtyTSddLNJNVQ4Zu0EaGJ/3DoZR+95676cZnNSKO85ZFiREpDuAjm3nHS4ptEETKIL
 8SvzfC8gygAk51OOg8MSkxLb62D0cixIn1D3Fqjxx3BozZeTUMzWId0RJ3PbUtYYR1gA
 upjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905199; x=1794509999;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fKmGaERdq76NSgO632d0eHUfScDrvJoRi4zomrB3Dnw=;
 b=TG9czHlreaFC8bez6S1/Oxa18w47tTLh0s0YRhDCe1lY65dw6O7cWqfscuwgQNnr90
 8TLIPSMk49U5+uR2XKw54fy8TNTndXyJgfYuLMTSzJ1ufbjP43gOiEUhC9Aoe8J53gU2
 TS6Ljc7BgOZfNOIE/sCaX7pyhjcL6Knkx98yS2/tIcngE+JTWMlkwczailr9PYiIHBve
 4z3PrQkYomKRgNHqzAmO1mGqZai9zFqUdXOmHM+zY1o/LPgeQOkxSd2JkHeyAfVD1S5P
 x1PrEb+zWqZXGo0o1DOkHrBmjgL428zxdQGdrEjxw0d53UCS4bUdtoD0m7QuBDeDcIlS
 ItIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7fWqFGgm5YjqKU61ttAt63vAbI+ohRl31s/KneIlb8njZm19XujocNuFo31mxR4XVkE9ei//1@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2X+BzEGfLbHFNucnxKxQZqBNWpHx+XG8ahVouRUx05Kr3RGqF
 Th1Yc9NOksm0IW3AA+tBDmStQpAY2WFAkp2z8rGSUHnXxUWczDfD77+uGQxG1cMUEDz1W2Hq8h7
 gIvUniKLTejXVUHcWyh1D427jHQw7wtOCcbJy6ztEJsSPHNR9LohPTdq1tVTh+s36G6dk
X-Gm-Gg: AYBFou25dqOghZbbnW3mj9rDTPgAWN9qVCZwchPHKzJ1jHGTrf06alS6l95fCRbJmSU
 BNDlSjFyJ5CfPLfEq5+HAnpr4Y1P3uJTmjHHpJxzboSl9XruvIG21ED6jwPt2eYEcsmRwiFLdNs
 UIoy1bZbQBjGp+Rs6TD1A3bhhyDtqM+fGaVluiVPqDVyqsc1yrg1reufLCc6BtLwvvOri1imadW
 CBcXufaMwIwL6N9mbJp/d98oLzN7Fp9sSCKW5g6t1ssQ/UXYNrsVHo8Le9MWACDBcLMoyDq7BUm
 4U1KzvIeVUxk1s2V6aHk1s/tDiM/VsQ9LJHP50TIR7SjeX3Nr0mraC0RYwMhpqgX0Wr4xiLaLWV
 P21txrdBW1VYiF7z8X0IiSHRNizXI0GqncjyggoAuVn+FswvtKCeleKV7006REp5rX6WmfQmKad
 H1IYiz+OgQKMHwlywPwfhBpqjhWfVUag==
X-Received: by 2002:a05:7301:1522:b0:36c:a104:90db with SMTP id
 5a478bee46e88-36f77eda3afmr9119eec.41.1793905198826; 
 Thu, 05 Nov 2026 10:59:58 -0800 (PST)
X-Received: by 2002:a05:7301:1522:b0:36c:a104:90db with SMTP id
 5a478bee46e88-36f77eda3afmr9078eec.41.1793905198139; 
 Thu, 05 Nov 2026 10:59:58 -0800 (PST)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f72dc5548sm105767eec.12.2026.11.05.10.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 10:59:57 -0800 (PST)
Message-ID: <d7751587-e837-46c2-9089-a5e6587d700f@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 10:59:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/34] drm/amd/display: Keep public DC lifecycle APIs
 stable beside Core 2
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>,
 "Cheng, Tony" <Tony.Cheng@amd.com>, Jun Lei <jun.lei@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
 <20260924184824.596894-10-jerry.zuo@amd.com>
 <a8d97b91-7669-4872-a922-8b160bb32cf0@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a8d97b91-7669-4872-a922-8b160bb32cf0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aecd22f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=zd2uoN0lAAAA:8 a=F1H5Ec0bucF44CCnLrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 4QmUxvegUq3RH0T5YGkuj8N6WiLPDu9G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NSBTYWx0ZWRfXxf+o2wTtUGwL
 XlwJvLqCkHpEBOAdvdM28o4EHq9f+4ThkV1oLQu5VWvl/WC86FCDzhz0turHn8mGXJSeEL8KnC3
 xpZpBVZTvnWi1re6pSj4X4eUDOD7lxE=
X-Proofpoint-GUID: 4QmUxvegUq3RH0T5YGkuj8N6WiLPDu9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NSBTYWx0ZWRfX7ysohIc9lTz1
 AeA1HBtK2LYf7cW6en2PrShryn/q7BjWuztwK1R0m14FWqtPbDlZLVN/VhkFJ5qFzz+/rTxqHOv
 Ud5IjgW66ZHUYOZPwqfLAinG5XQeb3ODVRRJ09/AFtCnde8KRkRe6N6M+kqRmIVda2zjpJDfMem
 Fh6f7UprMXbymAsRp5ge+6w7M9L4fiZc54JbvsTstRh/awMrO1OIYfgC12o4mevFCUaFU/McDf4
 ViJSZJGThooFuLGBKOnZJ2U8zkEsqmZzGiGgNQ7Y/00TxYyVCuq66I7leexSkWR3GPuXdQTxTfs
 50iNijCGys3mbacb/vDYvo1lUbJmUB8yb0EnJHTHZTHDi7pJAYrhKB00IqPC7Mi6UAhhgWZBhI7
 mAD/THZ29IfGvUYC+whFvYBzvzgZfKbk78TCOmtvWQuQaFG9446r+5AFGUL9xXw2CZA+rgIEUjT
 Px2xhzPb3KeZmNKq7Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050075
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:26:02 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 10:55 AM, Jeff Johnson wrote:
> On 9/24/2026 11:45 AM, Fangzhi Zuo wrote:
>> From: "Cheng, Tony" <Tony.Cheng@amd.com>
>>
>> DMs still call dc_hardware_init and dc_hardware_release while Core 2
>> lands next to legacy. Those entry points live in dc/dc_api_dispatch:
>> LEGACY calls the old bodies directly, CORE2 uses core2_funcs. dc_create
>> allocates struct dc2 and returns the inner dc (TO_DC2). The shim only
>> records selection; dc_construct still constructs Core2. No dispatch
>> fields on public struct dc, and no architect spec edits.
>>
>> TO_DC2 is a typed upcast (struct dc is the first member of struct dc2).
>> Shim headers are included for UNIT_TEST as well as production so TO_DC2
>> is defined when core_gtest compiles dc.c.
>>
>> Assisted-by: Cursor:cursor
>> Signed-off-by: Cheng, Tony <Tony.Cheng@amd.com>
>> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
>> Reviewed-by: Jun Lei <jun.lei@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/Makefile       |  3 ++
>>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 ++++++++++++----
>>  .../drm/amd/display/dc/core2/CMakeLists.txt   | 10 ++++++
>>  .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 34 +++++++++++++++++++
>>  .../gpu/drm/amd/display/dc/core2/dc_core2.h   | 19 +++++++++++
>>  .../drm/amd/display/dc/core2/dc_core2_init.c  | 13 +++++++
>>  .../drm/amd/display/dc/core2/dc_core2_init.h  | 10 ++++++
>>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>>  .../display/dc/dc_api_dispatch/CMakeLists.txt |  9 +++++
>>  .../amd/display/dc/dc_api_dispatch/api_shim.c | 32 +++++++++++++++++
>>  .../amd/display/dc/dc_api_dispatch/api_shim.h | 19 +++++++++++
>>  .../amd/display/dc/inc/dc_core_interface.h    | 31 +++++++++++++++++
>>  12 files changed, 206 insertions(+), 6 deletions(-)
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
>>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
> 
> This patch appears to be causing the following build errors I'm getting with
> W=1 C=1 builds. Per my AI agent:
> 
> Found it — definitively. It's sparse, not GCC.
> 
> Your build runs make C=1/C=2 (the CHECK lines). I reproduced the exact failure
> with your sparse (v0.6.5-rc1):
> 
> # same include spelling twice  → #pragma once works
> direct.c       → OK
> # once direct, once via a "../" path to the same file → FAILS
> sub/../real/hdr.h:2: error: redefinition of unsigned int enum e_test
> 
> That is precisely the kernel situation. In the amdgpu build, every display
> include path carries an amdgpu/../display/... prefix. dc_core_interface.h gets
> reached twice inside one translation unit via two differently-spelled paths
> (through dc.h and through api_shim.h/dc_core2.h). GCC canonicalizes the .. and
> dedups by real path/inode — so CC [M] succeeds (I proved a full build exits
> 0). Sparse does not canonicalize .., treats them as two files, processes the
> enum twice → redefinition of unsigned int enum dc2_selection.
> 
> So the chain is:
> - Root cause: the four files this AMD commit added are the only ones in
> amd/display using #pragma once; the rest use #ifndef guards. #pragma once is
> fragile under sparse's path handling, which is exactly why the subsystem
> avoids it.
> - Trigger: your build invokes sparse (C=), which GCC-only builds don't
> exercise — that's why I couldn't reproduce it earlier and why CC passes while
> CHECK fails.
> 
> Fix
> 
> Convert the new headers from #pragma once to standard #ifndef include guards
> (matches subsystem convention, upstreamable, keeps sparse working). The enum
> redefinition comes specifically from dc/inc/dc_core_interface.h (the only one
> double-included in a single TU), but for consistency the same four files are:
> 
> - dc/inc/dc_core_interface.h ← the one causing the error
> - dc/dc_api_dispatch/api_shim.h
> - dc/core2/dc_core2.h
> - dc/core2/dc_core2_init.h
> 
> /jeff

Additional information for my agent:
The four new headers it adds use #pragma once instead of the #ifndef include
guards used everywhere else in drivers/gpu/drm/amd/display/.
dc/inc/dc_core_interface.h is included more than once within a single
translation unit (via dc.h and again via api_shim.h/dc_core2.h). In the
amdgpu build every display include path is spelled
-I.../amdgpu/../display/..., so the header is reached through two paths that
differ textually by a .. component.

GCC canonicalizes .. and dedups by real path, so CC builds cleanly. Sparse
(tested v0.6.5) does not canonicalize .. for #pragma once, treats the two
spellings as different files, and processes the file twice:

dc_core_interface.h:14: error: redefinition of unsigned int enum
dc2_selection

