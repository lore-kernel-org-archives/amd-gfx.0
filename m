Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29972D2D8FE
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 11:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF3B10E548;
	Tue, 27 Jan 2026 11:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOmoAHbz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LgcG84Ka";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492E810E54D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 11:20:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RA8rZ83857955
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 11:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHcqP74r9VhaV5/cZgET4JduR2x2H6zcTZIlVplq3nc=; b=ZOmoAHbzG7TQYghP
 Q/+fbofrkL7z1l7f55oU9lCHS5tFUbwHxZdoNe8x2Autw64GNBVGPZfGheI2QSXv
 FLteKO5fStxqgUtuFGTqtUmc3bhwpXiwUTAZq+eiWL9XCEl7E9oBmFcwcII/R3A1
 XIXCwti6ZrVikX3lgE3m+BnoMabUKfRhd6rX6vphMzGx4wHMLshJAZJClrQDYRtc
 V9wdwul5Zz53ucOdClomE9fcqt3xWzzcwLuJR/aoXdZY0kjqRw8azEK/efE5heiY
 9HP7tGuOK4teYFXiS9Y1Hx43Up5X4TKZSsUszoo+KyiOSAcSekrY+FTAMewIDm0c
 ocgIsg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs2fck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 11:20:52 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5664600d9adso4856485e0c.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769512852; x=1770117652;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QHcqP74r9VhaV5/cZgET4JduR2x2H6zcTZIlVplq3nc=;
 b=LgcG84KaZPT3q5Eep+sBrDDX5X23Vgw4gwvRUTjRcITxbVw8JQdBWWHU3qFeRJClGO
 ebV00+AOMpaJrnEHjEUhPE6E6qwrh6ZJZNDTTTa5FDf3qis2saW2EB0X7iRYH4Akku+6
 q3ddMhaOode/FNbfSfFJ7makH+HtpfoByupTgsHGh3KhYmXxygmuot3yF4efoHbHpLIy
 DiwRKP2QV6d+MpEUG4FUYYg7jGWP0h6aGdFb8a27rYlwXuIFEX7NP3K49xDJMJUNdoq9
 /ZlYgkuopEUvD3TfXU+t84EAA4aUO+dOlE6M+STOHMf0EJdTY/ALqXyARAwiJSKxen6U
 qCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769512852; x=1770117652;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QHcqP74r9VhaV5/cZgET4JduR2x2H6zcTZIlVplq3nc=;
 b=VX0UiV1IqZszBcT0lz1/Wv6O2akcFQ4YwFlceI48Q+VbmDhEuunYCpAbXpMxJUwAdk
 u79J4yooP5bWghWYjNlXtEMrMHvM2rKiPALAphsVC06CBoZiF83zuDsb/ECUOIQ55YOT
 j3QIl/sU6pd744V/u+ItZ61QCtv0JkF1z7BoebpsZCeYbyz6vaxy6ZoSMJOujfOLToou
 MGlkgiuO2M5vrreSmfme6e2J9P3V2NhyrjdtQRh4fdcF0tXGVedd7UdADM/eUM7eHtBE
 NK1mj3P6m2XlDxfDSt7eB1Y9lsH7KWGOsjt8fHSFXcpUSjY8lnbCiZoiT5VJsEsSlot7
 w6qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ0ztAMqS/b/snklnhUh4dkZhH7lcRMXC2jmHfq0AVMT6o88WcPlkW/1VWdzmww7yar16gPzws@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzHXBWInvfmiTMfK1fFtMyP8ScIM4yLpDzn1KyyEvet1u50vOi
 ZXqt6+xL5ACjTtacAcEu1MoAZen/RyOMnZCrmspAwzEBUvzRig0TeY+8K5oPDDf3vfOFCgkACxL
 x+CGMIBaeMcjGLclwbH2XZzn8LUx8wI28uSA47yuBuMjx7qErUE2Sv1r2dlRw4+ZGQa+Q
X-Gm-Gg: AZuq6aI3i8SaKfMXG/z8iOIO8drQocrS5vvHHdJ2tib0AIKOkH6CWTjFrA10uNbvWZ9
 SFRQFZwK2L0fuUEv6D8AEVGW33lIkYExxTwxaWV+7oBrsZvMDWGVgPf8++jfjtE6kvesD6CYSP1
 kmeWgCTCj9Fhx29s1jjCfO3kkzfA8L88sjxqFHPHho06evBK6ED+/78aGIcqzPBmnXBsVXigsdU
 jW5pAmYhuo8RsoePaT4V/lw6ooDTzNkziAdelpXMriMb7WJtZnvNCW4vb0kEg7WVlf7tUkrPGT5
 Y6qo3rKRCi9In6HIqj5GSmzuxNuqhD53+IUy8SOLwErdSPYGK/nkC4UncGcaPwAzYv9YjsqkMW3
 7AJsIXKn59H4tJxj++vBx70N3ZgU2Ej1pbLbI/+IP9TPVjAC66y810LlQA2Xx7AE3WZto6KHziq
 aDvswpFpNujdbpOxFXoX59yxc=
X-Received: by 2002:a05:6102:291f:b0:5f5:35bd:6fb3 with SMTP id
 ada2fe7eead31-5f7235d4e59mr521474137.5.1769512851690; 
 Tue, 27 Jan 2026 03:20:51 -0800 (PST)
X-Received: by 2002:a05:6102:291f:b0:5f5:35bd:6fb3 with SMTP id
 ada2fe7eead31-5f7235d4e59mr521455137.5.1769512851297; 
 Tue, 27 Jan 2026 03:20:51 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59de48f0259sm3368696e87.45.2026.01.27.03.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:20:50 -0800 (PST)
Date: Tue, 27 Jan 2026 13:20:48 +0200
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
Subject: Re: [PATCH v1 3/7] drm/ci: reduce sm8350-hdk parallel jobs from 4 to 2
Message-ID: <ftkgk4xevcfe4dyx2pqi3gk3bqm7jcv65qvn3ypgrwls5dyx3m@srsgbmsteifw>
References: <20260127104406.200505-1-vignesh.raman@collabora.com>
 <20260127104406.200505-4-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127104406.200505-4-vignesh.raman@collabora.com>
X-Proofpoint-GUID: 6C3IqYOx-ghWHSKWTGzFYE7PeCL0YwHb
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=69789f94 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=_49z0RMimKR0Jg0_r6oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: 6C3IqYOx-ghWHSKWTGzFYE7PeCL0YwHb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5MiBTYWx0ZWRfXxD81CTx5Vanc
 yOkya7zzRU2zBmS4n8ydap5xyL23rOQ154seqvXRO4R8o0IbS4twuT2AwLx7HWMxJrC0UmvqJnH
 ATWLy5UWfW3KWJAO+4BL7ns7R87yoavoCNIAhuND6/cZz1unpk7nFtyA4yZJNTPGNIx7ZBSyB+D
 jdWSyE+YoA36g1KTlPRgZoKW5w8KaWlKjgur44QLW3fWxF9tEJHvYI+yNyqEz1wU88Hp/f4qoqt
 ENjk1NMbg9NvtDTxYfj4+dyjT2egZVbixJlYS+FAE6obtOv1zPRzH5hM6jKy7oTLCY75O0He8XN
 8eJ53PZ199Pw1eRhX2AztVMqlX0LcTC16+9BkGFn6l7QfSx+fjLh99H021KT9gquBSJr+GdFgkF
 LvqPZUV7o27KIOaIKOExkDxyqfWdVRMyA5E3if0xCjOmE7rEfoJglCP9Xrc+JK/5C6GixxKILXy
 hay8CeiIgB71vFP+LFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270092
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

On Tue, Jan 27, 2026 at 04:13:58PM +0530, Vignesh Raman wrote:
> The sm8350-hdk jobs are short and each test takes around 2–3 minutes and
> the full job completes in about 10 minutes. Running 4 parallel jobs uses
> 4 devices at once, which is not needed. Set parallel to 2 to reduce
> device usage.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/test.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
