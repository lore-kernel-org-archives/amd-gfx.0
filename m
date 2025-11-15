Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67032CEACF9
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 00:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0706710EB83;
	Sat, 15 Nov 2025 00:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxUYZC8H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ObH29VRS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3501810EB83
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 00:50:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEL54nC637810
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 00:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Qs9XNl6C5ygh9qZUkoG6dSnI
 2cAtbM33aIVEqpZU3HM=; b=LxUYZC8H3vZCJgDMaslziF+/Q+DGDpgidTjmxz91
 36M9bXPQASL0FtjnxYfrUVa1RxfX/6Gx0QRblsZWir9/aZGk9+AO/Bx7/lK6htOu
 Kld39VgMAHM2tQvShW6rixT4ooi/0ZDEkCQl+CHmcUqd7XlYKDhy9nIkb/l1G30P
 8MUMR014eDXOtxX+gjWzx34mcc9JA6nEV5BeVunCkD+NB3z6IefYWUeHupCjzzTd
 AzfeiCztR72AYwahKrSIIHEMhcWT5EQsRTFBaSGjKloFPxSK9SPAbPxvOhpNAzVX
 fLJMN8YRUPS0S07zPbKtVfvjn6QEYSfcvTnlirAT3vmhkA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aec1dgcwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 00:50:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-882380bead6so71596116d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 16:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763167810; x=1763772610;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qs9XNl6C5ygh9qZUkoG6dSnI2cAtbM33aIVEqpZU3HM=;
 b=ObH29VRSIo4CXBJr5Ls1jJdOF/txWfYtaM+Tv2nSVLASkQyNU55ffWkrpaD+YS4DAu
 BkWbsrF0W+YZXYMl6Po5gJKU0Mfx7od6vNICfn8j8WGnyZGQydspQqmzFw/JFyuP3DVx
 Qbfez0RVF+Na03SBswQ/N+5yUM7OqrpnP/k1UtKX0MA+KyctIVfucl3nQ8X525PaMF9d
 FORRfqK78ySIGb5Et/gyvUnxD40a6LSy2JMuFVMLJuJcXwTk+dhyOKPzLAOnWrqia3x9
 Vrmyvs2B2Yi9BNQTuD1CaAGjuXFGQ9PRj4k09RNOr5vECPh6t+XDlOm3YIcktOcRpUGL
 uOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763167810; x=1763772610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qs9XNl6C5ygh9qZUkoG6dSnI2cAtbM33aIVEqpZU3HM=;
 b=PRLeujvX3TAjONDunhD3PMXy0HCh4zGHAoYy5mkBP6lqE8oCctMZEzeYoqrpQ+FgPS
 UUOLWRLV+4Q2d0QytMjzgwXeLHlJBUPU2LpwQqZ8kn1KJc0Dtfy+IvYyN1dgWQmbpfPC
 wzw+A27a87htj9E/ZqJu3fmaHjnKG9MZ75AzsTfue7PVyHgQfp/5GhVSev9ETsxuYKTu
 JnxUw4BKHRFczo87qgf63TaBneRCceLnSdEZ7RNMR5F2S8A+3njBVwQrwBZQXHtU0oVC
 aKxGqBykcAa8eGYsUZL5ngiNF2rJNLGSBGDQelreupA0ltBP0ewRz6dOaV9n8HZ1DLPv
 GzJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSrPeyqKc70DxKTKH35Og7ujWx1enqLIB924TWqpFycLbj4RNRAVNF14mgeIDbBOvmXxWYKr9m@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoBGZPazWxQuDO4jbYK2zlh/MjLRJ6SN37eI2UMt5O3vcihki0
 Rb6NMX/24GT6clU2NKjT2NL1l0VCz/3+3JF6qRBnaxBf/JNUzKDXNUfhDQuhSXt3Dnxk8yYVYjm
 ZYS+GFujz0dM+rqTYbFEy6W29G39Sf9JjLAKr0HLuqHzR3tz/WIzndHV0TPHNYfbSuFR2
X-Gm-Gg: ASbGncu2MecU+BiLjs5aMwje1i/DFF3mAqH0dQrYxzr770g+frJ/3y0KYiK0u8o66iT
 Nhb/2AK3JbDZDgJDuf5FMG5mh+Z/Xu+dREHwug+mCK4KyLffLzRKNo4PP3zJ8QnOZK1h+JYjEwW
 gq6uBY/8GkXrwutoBvGZzMPWnefGrxkVOcgXaY4i9G6o7Fd4ANL4IlAO2tjXbX6IjPCSXuzNZfG
 WW9yqxQ9pU1opcTH6/HTRMmytiRQVLysDVvKO06DSyb2FNLm9+YPcmkqm91Pn0ckjlLAEugn2AO
 NK0Ov88wQ7rGJrTp5snfiWv8fCGlWo9Of/9lSoBLxA/XT7l18oTpvDBSqI+qE83NEdQiU8fjkT/
 XaUEuaYrHgm2F6ZK+Lgk/3O8oy+yEAHZdGUC+k9hLeV+b+3L1OW3ZlTktDmv2CBUxGA6KqSreC8
 jHMr2CL+XkpFzr
X-Received: by 2002:ad4:5dce:0:b0:87c:1d89:a245 with SMTP id
 6a1803df08f44-88292699d47mr77113376d6.49.1763167809707; 
 Fri, 14 Nov 2025 16:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjIFGATfZLfaUZaE3KWR5c8p1sYfBsOVpYyQEawnaMA0DTE16Ifr+U3lmX3Y+76mKypsKpog==
X-Received: by 2002:ad4:5dce:0:b0:87c:1d89:a245 with SMTP id
 6a1803df08f44-88292699d47mr77113096d6.49.1763167809268; 
 Fri, 14 Nov 2025 16:50:09 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37b9ce0822csm12716841fa.10.2025.11.14.16.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 16:50:07 -0800 (PST)
Date: Sat, 15 Nov 2025 02:50:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/ci: Move qualcomm baremetal jobs to lava
Message-ID: <ursdbkco5n734zhfqceztib4b6vxb2juq5jfllzcjeuctd6lvn@dbdbkbr4csws>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-3-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114030056.1139570-3-vignesh.raman@collabora.com>
X-Authority-Analysis: v=2.4 cv=cc3fb3DM c=1 sm=1 tr=0 ts=6917ce42 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=Oc5gQ_T1tCqBBtY5fQkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: _y5Whj8MSoqdFiykhvsLDy6c7s8ncDef
X-Proofpoint-ORIG-GUID: _y5Whj8MSoqdFiykhvsLDy6c7s8ncDef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAwNCBTYWx0ZWRfX+m1tnk6WJFNi
 NZmpXnI3H2Nbeku8gqLvexl+Y7Cs7QAShC1UJ+nVn5iC/0zvJjLxJAuRM3jRSSUdrWSyGxRP3qy
 nlve2QKU+xQ+lQQKQb1Bdpret1zB9Tw0Pci/a/LPxGQoCeMGRjAxixwrR8eQAKBQWFIQ/haOjbt
 jMOgjxWL7SFT84cXcNb3mZHXfF6QQa35x3b90I3n/mo9AW2xm/7lBtFnJOVUZ7g+C7RqecY01vC
 7W9TRVO9wRjW2J1hNHQNHarFNgKkr018bpl+gv4JrqkIiMuQdrvKmfaT4qbchQBD87VjR9ZAqoT
 QS8tX1gbM91dva8FwW23T6rhH4d/V9RC3TvTSTVCWdTtNhyBubmE8bX26MHz7golhd8CAnMWQru
 dEZb4HsQ3ZpCSLDzyruLVW8D0FQH+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511150004
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

On Fri, Nov 14, 2025 at 08:30:51AM +0530, Vignesh Raman wrote:
> Qualcomm apq8016 and apq8096 DUTS are moved to Collabora lava
> farm. So enable these jobs to use lava and update expectation
> files.
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/arm64.config               |  1 +
>  drivers/gpu/drm/ci/test.yml                   | 62 ++++++-------------
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  4 ++
>  .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |  2 +
>  4 files changed, 27 insertions(+), 42 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I'll try picking up these patches through the drm/msm tree, if noone
objects.

-- 
With best wishes
Dmitry
