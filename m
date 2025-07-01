Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39CBC8303C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 07:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AE210E2E6;
	Wed,  2 Jul 2025 07:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXdIeObC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E5D10E2CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 15:23:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619q9Us002161
 for <amd-gfx@lists.freedesktop.org>; Tue, 1 Jul 2025 15:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exYQa/SxTFohiL9rk/rsqhEqPzoQg/k5BFR36bKcrY8=; b=IXdIeObCcsIBWc8x
 qWgx7B0Ohk6eLOrElKt8nIaWr8OuMFD/ZG22UC69pZKvTltAj51G17N8jEoMZkZa
 ebKwDUu8S3bf1QZIqYD34F8AvzNg+qAVZ4gVaYBDRWxs8wo1efeFX8jiL6iA6nzz
 mwpUIJscwsoUSRQVCFJsnt5Z+enL+6Go8Fplhjer7LRSSV4xTmBACp5JZtR0LL4x
 Fz7SdqRRLY0Oc0xTscvZ7ZCvfP6Lj3OAGCQ6fArguFmPQgzzOeexYTIWP6rOzN8S
 N/T3Eub5jDgqo+OLUov1ei5+mujCoQ4FZrO0P9rzvwm8cogItCVd/R+l6qcu4lBZ
 DjELzA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcs9j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 15:23:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235089528a0so55051585ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 08:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751383425; x=1751988225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exYQa/SxTFohiL9rk/rsqhEqPzoQg/k5BFR36bKcrY8=;
 b=AM4WAixVW11IKdrRUYdGxnQhlwQeYM44tx/d61PzRYXFZrkPv8tH/ZdRXafQxNKOYO
 mfLr93jSHbNnCKCXrrAUah2/Hp5JIvfgtPukt6WYhEuLLIKpdp1JL72wn7Pbg8jKgrlE
 4BR664yRWic2NsWbv/Bkk4iVpgSL45LaVMQqM6Czzl03QfWzjIKDVi0urJy2g2DOJcDA
 xiGooYETvrciFNoRyvWj6sOl9HkEzlH0FP7TypdaaIVkXXHBbpSQJpPU2TiZRv6GWSkW
 LHgYu1IP1R+6QlCFyn41w4fYpwMTLRc9TE+I3iLN8GH9owHoDvkgsRFXw9s5HgNoZ310
 fZ3g==
X-Gm-Message-State: AOJu0YyS8J7f5h45Ajt2bhDBs/UyPEOs4fLZq0kEeGjYcODSzHVk0CIF
 MGRs6pamaW8JsdD2SQ+313+w8CL8/wCFPknrxppFNK658V3brkhrk/1T3YaMOFWiDWz+zYBRaZa
 t/BTMQ/5nfaSeIRrF897fhX6CDfwIRnLLvSmf1W2TwEq/NoMrPRqPgfNVXG3YrhhZgv6ldbSWvk
 bA
X-Gm-Gg: ASbGnctwmNSkhixL1wZSKUMfmF4JrZTz8tU7J3LSR+1Z0gCwlXc869YO5hlhnlQ+xyQ
 WiibK+PSdYPKwEyHPG4ZIjTbxm1Dr1bYjx41YTMvg7yOaYfCessXtFwkAjC9CFk5y03nixczRzJ
 mj9KkYVoeJWbVWDzEEzDtzqLSF0cUFW9iO2Egl9yaqw1tDEuz3srzO2gquX0rdbKe9zr9GTUpOK
 /mt4wif0rR0liGGKWnfJoSe7m+4qFXFuB5sN3+XO6PrCun1d1IZybG3wIk/UD3iwcHG4JOKsf+K
 FaYQJj3nO5/VZsif6CufJ0nSf9Kesho0wevbTzLkbBm3xU/nV5kGLc3X+aI6smrB946s9iLV
X-Received: by 2002:a17:902:db01:b0:231:9817:6ec1 with SMTP id
 d9443c01a7336-23b354dcec6mr61641655ad.17.1751383424984; 
 Tue, 01 Jul 2025 08:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzeFM4sfWDHwxnw4b8YUjQqPTFrx84Wk9Tl/cQIW7vhIff40Tj7+wyn3B1Cpbc96mvyds34A==
X-Received: by 2002:a17:902:db01:b0:231:9817:6ec1 with SMTP id
 d9443c01a7336-23b354dcec6mr61641205ad.17.1751383424416; 
 Tue, 01 Jul 2025 08:23:44 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c8b52sm106544015ad.244.2025.07.01.08.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:23:44 -0700 (PDT)
Message-ID: <643a59de-79c6-4440-bc62-4b89eea784a3@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 09:23:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] drm: move the debugfs accel driver code to drm
 layer
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
 tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org
References: <20250630143613.2520111-1-sunil.khatri@amd.com>
 <9e45cdbe-8cdf-42ab-8769-067ff8f30e1c@oss.qualcomm.com>
 <7d1d4aef-8819-4e5b-af83-762a8d2ca0fa@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <7d1d4aef-8819-4e5b-af83-762a8d2ca0fa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cl7RX0nkHWviKs9l370TGsNRq22f5edT
X-Proofpoint-ORIG-GUID: Cl7RX0nkHWviKs9l370TGsNRq22f5edT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMiBTYWx0ZWRfX3g/fnjhctv1s
 eaQcvkARl8+C8RaTdvgH4l/vnUrtLfbpL2URcoc4PYV9nGaG1SXQRmgkM5df8lIyVSNI48lnGPO
 Smag4UgYg6iBfX8F9mldIFbvujZD1J0PYtX4SaBIbiU8fWQ2vIJYJ2Gx0CThSCcp6BjymSJS4o6
 yCxzYlNLP/xWBueMVj29VyJJu7hk53rx1A5wlcaE14ID/ORR4Gbg5IUUyOWM4jxJsN4dMzTQPuz
 JfzF9sYgHMu00hmCPs/MFwBCr11FLXS8fSyc+r+gBypfzOl7ZlNtwiiMKmlRFe947qo679huP55
 MbqFZtB1i71jjUBZnpoJXX8MaHjNOjpx8++AZL8bIJdvFX/itWTU0jNvJweN4eBVOflmgGSEo8z
 Oa1LD7oJUFNl5KS8BntiVwvrff+/h7uczMS2AXwbRxFg8LQNW8ZTX7LFDj+DjSKef4WuLUcK
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=6863fd82 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=jG12YPyu7umpLBzujXsA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010102
X-Mailman-Approved-At: Wed, 02 Jul 2025 07:21:22 +0000
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

On 7/1/2025 12:14 AM, Khatri, Sunil wrote:
> 
> On 6/30/2025 8:49 PM, Jeff Hugo wrote:
>> On 6/30/2025 8:36 AM, Sunil Khatri wrote:
>>
>> I don't see a cover letter on list. Surely there should be one?
> Yes there is one with the first version of patches.

I don't even see a v1 on the list for this patch when searching the 
subject.  Typically the cover letter is sent out with every version of 
the series.  This is v7, surely the content of the cover letter has also 
evolved.

-Jeff
