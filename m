Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FE606A32C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gBYxxEPH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BIpZehCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636AF112C9F;
	Fri,  6 Nov 2026 09:26:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374FD10E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 18:55:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeQmE1122105
 for <amd-gfx@lists.freedesktop.org>; Thu, 5 Nov 2026 18:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zGeidKpPdgIJrPS/hfV3kKQ43GMkPtZpCvDdv6SfFfs=; b=gBYxxEPHncxDHSoE
 zr+lWWWalEeUQmQQ3Lm3fTr6LLdJVV0UUlDHrZtD0v7z1DN1Tgagd77wQiBycFq7
 iMAPs1sBNo9bZgdVz5hSBUCfXHzuIDgV6polThcDAlplDPJRvBCDs2rEuBenj+0a
 0b2BLRU75/6W9ie1wsyBUGEvUZ5TN6uI8kLFbjN7Zh7KQzqpP4ajQbzRgH0t6nXq
 3XCITDonoD7uqnXEaYm171+87OZDYSj9ibyGiCloPQXu2UoyJkXpwQPrUVWls4l1
 9PE9mJM2KWaB5ujH2SDy2hCxSICVczSmC+iDPremadxJ+CsYnlz2Da9p7/8KTlOh
 wVQTrA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p2j41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 18:55:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f1e7d9d4dso662471eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793904927; x=1794509727;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zGeidKpPdgIJrPS/hfV3kKQ43GMkPtZpCvDdv6SfFfs=;
 b=BIpZehCPD9CwDISiFooAIjcMgHtgKUT0MT2A5oJPd59mGLiZ9jBGOCQxi190Tqh7II
 3p6dY3dpn9UbUNFz9TMVKITlCi7twGjKllilhDVGSFMZmbQ1vb73LjX0b2N8fgxvYibG
 BwSM95hRAMBc/BiheJQ4c2f5f41FdWaYZe0hy5JXLTFJJUi11WaIBnk5D44UImbqb6pQ
 MK778briNu57ob5NNh/+xtkUs7y1OYMmi8jaRSj1IM1z7JGHYUDY2FBlqLdu8O5HilCS
 37oM7wMX4zcfabustcxU3XR2Ay1PRf2Pwo5k7DDubzIr+cGJFfriFNUWXhgkp2hHy3DG
 Ua+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793904927; x=1794509727;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zGeidKpPdgIJrPS/hfV3kKQ43GMkPtZpCvDdv6SfFfs=;
 b=yjPmT7brD/YNr9/2R0OUfyVRgFrL7PSkU2nW2WlZhNwCnaNmj/MB8wWCCDkMsS+YUw
 A6JlTSmGFlRJhimQVsEPyu6gUW1ICMprA0dr+SWsfCgi9TToqjel38tsTUqnF/b1x+D6
 jF12qvUHj/c+MwKHFAZs0zQ04nJoa50Du50zRNCAzDx15UC1zjGwWyrdM8t9HAzTD+u9
 kRAzLMS8c0IInEciSsoPV+6U8K86OAPQki4wwwDISDGZ1Dl7lP/2XNRh35cl3IayzGNv
 0t0f98BgRlfAuw6LXhXOCx+Kc8ohpConrtzGLwHzEVBFiT7XSXbIWQml2rU8e6WGHnDv
 l+eA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcAKoJYQGExnKIqgxoqsFmh/R7N+MEiMsdftDl+nZfvfkMNZJ8ddtAsMDx0QFjLfD2ruyxxf9a@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/oGlIANAKwVxbuiPWYefPWLjRrjC5vhqNk04ZCKsM2skV/FsRr
 alHJwNj+wsmFQoudAU4ulQN0oHtgCP4ExPfN64qorSfKFaesgGpWT2B5sY03dTP5WsmEPglo/Bf
 K7MgG+PVC5wfZvAW6NlWC827OZKZHIrmtF82uJSXDCbRqKZOwJc5C1YtDkeXSMi0b3I0h
X-Gm-Gg: AYBFou2ZoRiABMtDi40EXYlprKTXB6wiK1UczfFRLAMNF5OVu19eiPVZyH9GkxFraMY
 1u24Zsc93QaBf7ZwMmWsbJNQceG3bJEGxIMm3I1z9GIhSl7NeXOE/YBxYda2L6bCK4EuQUKq9Vk
 aVpuYIVtYFmfYH38Q8b8R0vmMK1nKTpm3tStv9b09gUIyB6BNt0/vMwY+jPCyyut9D2FnWUWaNs
 hS4YntNqiZuto4pPtbF2iv3DooEz9e4q6Y7/GukhuHDuHFOBuiI5MBMV9U6hK/ZBd4dY0h6x+we
 0iAArcTp+McPNG17I+bL/TUlnxIaslUiVy7ZOiBZnvN4E2GfGk9PFpF/Vu7bH3a3/LzCVLUZMF5
 P+zBKhO7oIVEkCPoXus0H0ujBAs7aSEfUyOka076gfI8gy/9hWRt/6hLKcP16laHWtKxcwcfpu5
 lNO7vJKcXbmFUqfYdkee9eoMDgyRQXcg==
X-Received: by 2002:a05:701b:2411:b0:167:4198:2cb3 with SMTP id
 a92af1059eb24-1b2366f4972mr15998722c88.18.1793904926687; 
 Thu, 05 Nov 2026 10:55:26 -0800 (PST)
X-Received: by 2002:a05:701b:2411:b0:167:4198:2cb3 with SMTP id
 a92af1059eb24-1b2366f4972mr15998650c88.18.1793904925905; 
 Thu, 05 Nov 2026 10:55:25 -0800 (PST)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245ac2f44sm18748652c88.0.2026.11.05.10.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 10:55:25 -0800 (PST)
Message-ID: <a8d97b91-7669-4872-a922-8b160bb32cf0@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 10:55:22 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/34] drm/amd/display: Keep public DC lifecycle APIs
 stable beside Core 2
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
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260924184824.596894-10-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aecd11f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=zd2uoN0lAAAA:8 a=Wnven-Pe7xXxCdNjZt0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NSBTYWx0ZWRfX9WP5koiRvHJy
 el/DEX/dvLfNuXfWh+tfcUvdnYr4ptx5AE1TUqyTVc+3YpFEh/2g2cxMGdjHeUjLs/TQ6FvjA5n
 b7CXqGCU/vleiLy/iYnU2GdpTHjLAg3SIwwXOWVliW6ee2M4UHb11YGWL3p/024slTxs4jLPOmj
 y7me0jroBoIIlAxUeQ0WvnkwGF8svZY+Eig2S6MEP/adFt3XvNuXKngZ5XzcZ8b8MixxCDwDhaA
 lcTiCmma8R6L+RBSuaWm/1OX+ZwhSSu5lAZuXoG49XSJluVFMcLzHsYPZDwhu3iqsRfUAS9SAVd
 ktRDiBIymiV126oELRhOtJUcmdCvW3bV6eXTtJMbHRDmhHLScjAZul3DOt0fUpmbl9sPIT17E1L
 vLApEjuEcjMdYHbaUnXy7ES2MZ9Uj9AZ7laL27yKRcjMXvjAv86iCBnuAw1P7mHsKOBXJTh5By2
 CvGDpbzjzeDNB8M9rGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NSBTYWx0ZWRfX6n/bCaMeS/sA
 ZcSiLIfEovBPzeTQk4NmJfb+FmOrAWTKYav2PVgImrtsNHNdtOthxBtCBecQXcAP9HmH9yIf4+f
 wdcUejuF/f4DxgESHuNp/iQD3AjHkpg=
X-Proofpoint-ORIG-GUID: 6OW0-9rBTcDEc4PZTbTeFCN-oVINfbNG
X-Proofpoint-GUID: 6OW0-9rBTcDEc4PZTbTeFCN-oVINfbNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050075
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

On 9/24/2026 11:45 AM, Fangzhi Zuo wrote:
> From: "Cheng, Tony" <Tony.Cheng@amd.com>
> 
> DMs still call dc_hardware_init and dc_hardware_release while Core 2
> lands next to legacy. Those entry points live in dc/dc_api_dispatch:
> LEGACY calls the old bodies directly, CORE2 uses core2_funcs. dc_create
> allocates struct dc2 and returns the inner dc (TO_DC2). The shim only
> records selection; dc_construct still constructs Core2. No dispatch
> fields on public struct dc, and no architect spec edits.
> 
> TO_DC2 is a typed upcast (struct dc is the first member of struct dc2).
> Shim headers are included for UNIT_TEST as well as production so TO_DC2
> is defined when core_gtest compiles dc.c.
> 
> Assisted-by: Cursor:cursor
> Signed-off-by: Cheng, Tony <Tony.Cheng@amd.com>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> Reviewed-by: Jun Lei <jun.lei@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/Makefile       |  3 ++
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 ++++++++++++----
>  .../drm/amd/display/dc/core2/CMakeLists.txt   | 10 ++++++
>  .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 34 +++++++++++++++++++
>  .../gpu/drm/amd/display/dc/core2/dc_core2.h   | 19 +++++++++++
>  .../drm/amd/display/dc/core2/dc_core2_init.c  | 13 +++++++
>  .../drm/amd/display/dc/core2/dc_core2_init.h  | 10 ++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>  .../display/dc/dc_api_dispatch/CMakeLists.txt |  9 +++++
>  .../amd/display/dc/dc_api_dispatch/api_shim.c | 32 +++++++++++++++++
>  .../amd/display/dc/dc_api_dispatch/api_shim.h | 19 +++++++++++
>  .../amd/display/dc/inc/dc_core_interface.h    | 31 +++++++++++++++++
>  12 files changed, 206 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h

This patch appears to be causing the following build errors I'm getting with
W=1 C=1 builds. Per my AI agent:

Found it — definitively. It's sparse, not GCC.

Your build runs make C=1/C=2 (the CHECK lines). I reproduced the exact failure
with your sparse (v0.6.5-rc1):

# same include spelling twice  → #pragma once works
direct.c       → OK
# once direct, once via a "../" path to the same file → FAILS
sub/../real/hdr.h:2: error: redefinition of unsigned int enum e_test

That is precisely the kernel situation. In the amdgpu build, every display
include path carries an amdgpu/../display/... prefix. dc_core_interface.h gets
reached twice inside one translation unit via two differently-spelled paths
(through dc.h and through api_shim.h/dc_core2.h). GCC canonicalizes the .. and
dedups by real path/inode — so CC [M] succeeds (I proved a full build exits
0). Sparse does not canonicalize .., treats them as two files, processes the
enum twice → redefinition of unsigned int enum dc2_selection.

So the chain is:
- Root cause: the four files this AMD commit added are the only ones in
amd/display using #pragma once; the rest use #ifndef guards. #pragma once is
fragile under sparse's path handling, which is exactly why the subsystem
avoids it.
- Trigger: your build invokes sparse (C=), which GCC-only builds don't
exercise — that's why I couldn't reproduce it earlier and why CC passes while
CHECK fails.

Fix

Convert the new headers from #pragma once to standard #ifndef include guards
(matches subsystem convention, upstreamable, keeps sparse working). The enum
redefinition comes specifically from dc/inc/dc_core_interface.h (the only one
double-included in a single TU), but for consistency the same four files are:

- dc/inc/dc_core_interface.h ← the one causing the error
- dc/dc_api_dispatch/api_shim.h
- dc/core2/dc_core2.h
- dc/core2/dc_core2_init.h

/jeff
