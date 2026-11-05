Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57D606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n6IWGWAp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=egEqzlBA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74760112CA6;
	Fri,  6 Nov 2026 09:26:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E306710E293
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 19:26:12 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JLicN2293827
 for <amd-gfx@lists.freedesktop.org>; Thu, 5 Nov 2026 19:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f1MinKAjnVfvxFtBwpXAOJ4qndP5KfhVCCWpJH3cRGo=; b=n6IWGWApAFs+7C9y
 UbVEcsaBxF2xAlKxlz5WAl+XB1y+EP2D7zTvvw7K0QIdkZ9ThWMibIaJO2zb+guw
 7lBecNPdbSKxV2QOjr3MilgpozfMEmOIVZ1nJXcn/F81ji8dUY12SIh6PmedYR/w
 cH1uxhvyUsgTmNva4Ir0mwIXh3ApjahsUJba/GNykhDViQzctWkivfxhKQTqkxOS
 5p2XJpn0LFd7DXNQu2L+6cbDhn99ZSYvC47kKsQGhg8t+VX8MMTgEymkP2Jm21s/
 KM28UFokSmIHZ3gfx+NRGptbBT5NyJXJlDarZzfBYG9t+Vzxan+ya5dRwT1CNctz
 qx7w0A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryw180n1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 19:26:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f479b9819so338752eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793906771; x=1794511571;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f1MinKAjnVfvxFtBwpXAOJ4qndP5KfhVCCWpJH3cRGo=;
 b=egEqzlBAq1RoqHUQlKELwSu4mIlVIhizyupzucLLyh1/aHhMxL/D2tV8o1KAysaG3Y
 zMlhWAtJ4fkNIOKR3ETOf+tJtf96aDv6OJ5NXA+e4ktuZ8Ask9TjmsdxX66HbVx+Rlpj
 LV7Kblb0zcAYHthOmK+3aafzd9s+XSeWDKhq4F9nzkY7TNYhtVMVlH6UCztpz88bgzWR
 REqTm8ZLcqw2mAvHv+il1/qXLeSuhAIDH1/FYKSTKAs2z34Hmawn1r8Qm0Z65KVMavPh
 /zY9XkPJqz7+Y0kMj9jqeVPpvqRI/8lsk+4rZOFKhShLqH644zKemyOFvvhcNiKxSwFu
 UUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793906771; x=1794511571;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1MinKAjnVfvxFtBwpXAOJ4qndP5KfhVCCWpJH3cRGo=;
 b=qATQnJqkjjPNVceoBRojvSA/YcPgo59Fn4d9xlmA/MXrsBPPMtA/Ri8U2GnTdticfb
 x31TGgBp0upAqKjKof5uIrGSSzuPmAYb+qocnQWtBH8qP1oRlXmXYc5cyfVyaXWTVykh
 hpa1g0vj5dJx1uqNPrCeM4zgc38PFmj98KDmo0uHFfBiXTg6VpIDwGW22Qs7x8o/sTQU
 IgSsuEo8BRKGS7gneB/KyDMNELx1Rau+WlS2JeOWc4eyC4+dK+3c3IDtDJsibW8k09wq
 k1XbBcxVKKlIndz1NDug0J9i3h0COECxxcEqpdNMmg3qSqgS/bwIuli1i15vbX05yZGq
 onrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCVgjCBcDUeN+nIAn+3wFq76XnPgc7Smn/oLxCgEJUcvUx6bOq24zoT/nWXJSVbhcBMvLim9Gb@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+EfH+g9cPHjLwrIXaznb6n82eIuk0vXfjnvfZzqwqZVrtTWvb6
 4OAZId7KaDkjd/Uugu5NF4xReHCGQuTkmZvejY9Vj+OMJL7S+WSqs0nyDuFAlBUzrqfvq9a/42h
 rs51vJ83RVbXakPOcgsN77Hw7cuF8zbQ/ryyatQ89gSPsLFdhnqx7emErJ+BpSd7FMTI7
X-Gm-Gg: AYBFou1zR+xCx5h/px5G1IDGofk/cRTBsdYpF/VnmeE8oVhwPiJ9jUe26IPtVkT56YN
 vFYaEKxFpjCrZiMJYzRtMYf6uuMONt/2+yAK1K+aqFPJKWI2mmjtVmPbpxmkKTvAa5C350ABQdU
 C3Cxm4FHAno62ds75PA9LkrSrXJJtNDUsECkGHk2kg71xKv6GvFMDPpEJGc3cIQWXFfd7JLwsL1
 QTugtbM8xqvCrqFlyBKLYZ4SpmQVkyxJMYjrVG0EM+C+RM6cfe4bfyKKQe3CaYbVLDyWi/PiKKo
 bLUbZyBhqjPxlWCF1FeP+ksTQMsv0L7ef11YbWfzr4+rggetCDIeVQ5MhDmTUpD8jhvC4BRyXns
 V6pQEJ1R41llcxcDMAu9zEoQhWchG2w7nkBBzhXA3y6IZS0XKDZfdwLx31Gv1JLED1PRqoVOc/v
 icnLBQ7ekHGwG8mZXuvB+Q+g10fYuEDQ==
X-Received: by 2002:a05:7301:170c:b0:36d:1b8b:617b with SMTP id
 5a478bee46e88-36f75443edamr116869eec.9.1793906770024; 
 Thu, 05 Nov 2026 11:26:10 -0800 (PST)
X-Received: by 2002:a05:7301:170c:b0:36d:1b8b:617b with SMTP id
 5a478bee46e88-36f75443edamr116828eec.9.1793906769344; 
 Thu, 05 Nov 2026 11:26:09 -0800 (PST)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f7379e4f5sm211508eec.5.2026.11.05.11.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:26:08 -0800 (PST)
Message-ID: <b75bfd6f-2090-4ce7-8e89-6c705e583779@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:26:06 -0800
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
 <d7751587-e837-46c2-9089-a5e6587d700f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d7751587-e837-46c2-9089-a5e6587d700f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yhd1SCIGWfoqFYCAlhxpXEDBkM5wO_i_
X-Proofpoint-GUID: yhd1SCIGWfoqFYCAlhxpXEDBkM5wO_i_
X-Authority-Analysis: v=2.4 cv=RdYFmFtv c=1 sm=1 tr=0 ts=6aecd853 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=rT2Y_KPMIqF3AAh7pesA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX+URc0mm2EDPo
 nuP047ItzAAV4YU9eqxfg9vHE8E+Jslmp2wq7ag0ntdicuIlEsGDahU5BeJ9X0Np1BMyOV8vGkQ
 +t70hGzsOu1lmIdwIHBXuu0yDnxiun0rc02wkJz9cJEYJO9KRowiPagLmBPE0VXQagLkes2wGpN
 GLKhVcGzdJdEc3sYT4XtwoFRABmHMNqNpFhXO6c3LW+4Qk71BtW0QXaWSUexKn3SJTuZQ1SCLlz
 YxwTkKv0kxY7qN9kC8PR8WxDxl4bY+GWS58HlZWilduoe6BHauyGwlhlO7GX8rDEG+YgQA+ieMa
 k2mP98I6xeo/OWr1f4cjwSmEDvDod4oYU4D886vEv7KGqftd4S5t4AZp3BEV8avyCEcNiF6C3Rj
 /e/6aD+GXWNWp/OqsP3+9AioFx4/MXtM5Bi5ZWxZA5yqco6RA4GzrfPe51xjWyzRohmD9LGVyJz
 rB4eaGKxOSSkQavOmGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX3jpymVj6AayO
 9JSjgDtzhww5k/DKnWCjYt/X1hdwpQdWGMx0r9tSN9blrbWG6JBub+9GCvWmVaHfYZ/NZgsW98i
 +lR4NxzxfaxteShRy2yXZs+WxMgkaiQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050077
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

On 11/5/2026 10:59 AM, Jeff Johnson wrote:
> On 11/5/2026 10:55 AM, Jeff Johnson wrote:
>> On 9/24/2026 11:45 AM, Fangzhi Zuo wrote:
>>> From: "Cheng, Tony" <Tony.Cheng@amd.com>
>>>
>>> DMs still call dc_hardware_init and dc_hardware_release while Core 2
>>> lands next to legacy. Those entry points live in dc/dc_api_dispatch:
>>> LEGACY calls the old bodies directly, CORE2 uses core2_funcs. dc_create
>>> allocates struct dc2 and returns the inner dc (TO_DC2). The shim only
>>> records selection; dc_construct still constructs Core2. No dispatch
>>> fields on public struct dc, and no architect spec edits.
>>>
>>> TO_DC2 is a typed upcast (struct dc is the first member of struct dc2).
>>> Shim headers are included for UNIT_TEST as well as production so TO_DC2
>>> is defined when core_gtest compiles dc.c.
>>>
>>> Assisted-by: Cursor:cursor
>>> Signed-off-by: Cheng, Tony <Tony.Cheng@amd.com>
>>> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
>>> Reviewed-by: Jun Lei <jun.lei@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/dc/Makefile       |  3 ++
>>>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 ++++++++++++----
>>>  .../drm/amd/display/dc/core2/CMakeLists.txt   | 10 ++++++
>>>  .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 34 +++++++++++++++++++
>>>  .../gpu/drm/amd/display/dc/core2/dc_core2.h   | 19 +++++++++++
>>>  .../drm/amd/display/dc/core2/dc_core2_init.c  | 13 +++++++
>>>  .../drm/amd/display/dc/core2/dc_core2_init.h  | 10 ++++++
>>>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>>>  .../display/dc/dc_api_dispatch/CMakeLists.txt |  9 +++++
>>>  .../amd/display/dc/dc_api_dispatch/api_shim.c | 32 +++++++++++++++++
>>>  .../amd/display/dc/dc_api_dispatch/api_shim.h | 19 +++++++++++
>>>  .../amd/display/dc/inc/dc_core_interface.h    | 31 +++++++++++++++++
>>>  12 files changed, 206 insertions(+), 6 deletions(-)
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
>>>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
>>
>> This patch appears to be causing the following build errors I'm getting with
>> W=1 C=1 builds. Per my AI agent:
>>
>> Found it — definitively. It's sparse, not GCC.
>>
>> Your build runs make C=1/C=2 (the CHECK lines). I reproduced the exact failure
>> with your sparse (v0.6.5-rc1):
>>
>> # same include spelling twice  → #pragma once works
>> direct.c       → OK
>> # once direct, once via a "../" path to the same file → FAILS
>> sub/../real/hdr.h:2: error: redefinition of unsigned int enum e_test
>>
>> That is precisely the kernel situation. In the amdgpu build, every display
>> include path carries an amdgpu/../display/... prefix. dc_core_interface.h gets
>> reached twice inside one translation unit via two differently-spelled paths
>> (through dc.h and through api_shim.h/dc_core2.h). GCC canonicalizes the .. and
>> dedups by real path/inode — so CC [M] succeeds (I proved a full build exits
>> 0). Sparse does not canonicalize .., treats them as two files, processes the
>> enum twice → redefinition of unsigned int enum dc2_selection.
>>
>> So the chain is:
>> - Root cause: the four files this AMD commit added are the only ones in
>> amd/display using #pragma once; the rest use #ifndef guards. #pragma once is
>> fragile under sparse's path handling, which is exactly why the subsystem
>> avoids it.
>> - Trigger: your build invokes sparse (C=), which GCC-only builds don't
>> exercise — that's why I couldn't reproduce it earlier and why CC passes while
>> CHECK fails.
>>
>> Fix
>>
>> Convert the new headers from #pragma once to standard #ifndef include guards
>> (matches subsystem convention, upstreamable, keeps sparse working). The enum
>> redefinition comes specifically from dc/inc/dc_core_interface.h (the only one
>> double-included in a single TU), but for consistency the same four files are:
>>
>> - dc/inc/dc_core_interface.h ← the one causing the error
>> - dc/dc_api_dispatch/api_shim.h
>> - dc/core2/dc_core2.h
>> - dc/core2/dc_core2_init.h
>>
>> /jeff
> 
> Additional information for my agent:
> The four new headers it adds use #pragma once instead of the #ifndef include
> guards used everywhere else in drivers/gpu/drm/amd/display/.
> dc/inc/dc_core_interface.h is included more than once within a single
> translation unit (via dc.h and again via api_shim.h/dc_core2.h). In the
> amdgpu build every display include path is spelled
> -I.../amdgpu/../display/..., so the header is reached through two paths that
> differ textually by a .. component.
> 
> GCC canonicalizes .. and dedups by real path, so CC builds cleanly. Sparse
> (tested v0.6.5) does not canonicalize .. for #pragma once, treats the two
> spellings as different files, and processes the file twice:
> 
> dc_core_interface.h:14: error: redefinition of unsigned int enum
> dc2_selection

Since I was blocked I had my agent create a patch:
https://lore.kernel.org/all/20261105-amdgpu-local-fix-v1-1-4af7abf820d0@oss.qualcomm.com
