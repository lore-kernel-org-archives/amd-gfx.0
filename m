Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE5606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kqQHrRIy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0B98112154;
	Thu, 12 Nov 2026 13:56:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B6410E4DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 03:22:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2aUVI1475361
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 03:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=; b=LOpIkJFk1qcw9dNR
 IGn4sA5UCOtmAyOLiqsLJomBSihf4tRG/wVsCktehqAKlkuNZgtYphQhJjW6Y110
 kTG5YWTTru2Y4kr1/8Qaz2fJNsQUA5m5Ka/oMwTdFZcaTTHwgtDbyWShJX3YM2kD
 EmjFp/er0dKt0SxCLGtWua47LlVvaLI2blykILXXkO3UwS+VXzUWZRxAMyr0kUAL
 D2ZraxIHHVBA5T54djHiEvNFaJ4a29MejhkgHnvgHbDKd2hHf1ktkpCFc9c1JW8w
 HlSYTbk1ggYxW2ytlV2rCexQSaEEvjbUKJ7IAbCnqhsZMIW4j1I8fuadDWk7094Z
 MUoEtQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymtdwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 03:22:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2eaae8d29e0so49239855ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794453750; x=1795058550;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
 b=kqQHrRIyODgmIOQ60GqZXxacMKz/HBVlr2+gm05x1bt6d4Ts9n0vZlq6oAWcXvVIjk
 nBr7PWeFvco7Rrv7aKO+k45oAzj9bvftvgQiFmao60XrGagSFLMo8mE4xCF2vWqpB9tQ
 og4GawohwUZqHy5BQzyeqRJMErzIT2zSQKYGrwVpFnUp7pIr87UqfOJzbiYhYHVbTO8R
 f3DFWVwMXGai56nHp7hrp3Aa51bM2PjvClT4zHuQ0p5MwwxC8KZz8K4rf4yzUDDu435L
 HINUEqnaxer2toOOxhHArF9b37MUj0+qE1Ye8tJrvZXsijLI0WrtwIPYW1wmlL5Ql1Bt
 WYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794453750; x=1795058550;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
 b=Z1WPr+zY5RcUUEfJmdrqr8d5K66Pbphk5eIpPxRbcJJYWQ6LUzDtF3ghvCebmh1nyg
 aP4s8PHgMIXjGs7/RYL6JKExWzgfUr/N7Sw/k+DB0JYsdLqvCZpeyThBfZYrdsR0a8Nz
 q+nmKQ8xHxgPHtacoe1o9D4Lyz7XzsNNH5HEWjQGQ0iEBfWpP6eJJ29p247Ipq3G2NB/
 ERQo2G2Fc4pqR3dq7AnSAMXSTFOtEMEz3PLO59EsgG1J6i8hTMtPyUqNfdJ8gAlKllx1
 JV7jQ5ee7S5tSb04WD8l1uDxjXNec12IMgVA0Q5bLpwz6ZtC0KihbrNhn2QR0GEYaGf7
 SFRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE71s45Nw9i6yieqNYHXmfMuvpVZ9vV60Wy43RGpbqAPqEoDAvlHETBjt6pELmb58n/BbHJ8bFl@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85SsYGrAwfh0fUxU0tYrNlyAel6Zdae2odP3atlhxLNqOl41v7
 bWHjeHMTXXIlqxTW/xHqwwYnBas4qQ90qODlcf0Y+Lvlhmw1KH6f6u4emMacmfgm2zI2uOcFHE0
 NIMJ8+PyJqfB+SHToVEumnEaF77vIBePYBXnGu8TzN16516v0BK/f1Hc/FMHrw+ftk0u3
X-Gm-Gg: AYBFou3UEEe4o6guN/6mKWYKCmxb98iaOFrThHa/+Pek97+ymft5Qf/yjMPLrQVdAGE
 TS//GFW+dx+c3si1KHOHa91pEzVz2SLBDXpdxBhduVvspePOBivEGt5LG6TegbSNPOpZDBLNrpF
 sW5kfcvXi8WF67dOzBZfv6F71eafKncBCFbM0AWintz3IY2v4P20g+z2DWXmyV/MMJ2PPpspMQU
 wqD/UI/tsY+CPRYd23yXYJTQPjxTvwjfbCbtLT+jOpHbjccSJUxLc4Sig+dbV5Lk6q6Y70ociO6
 O8oW/Geh6pyBZiwPudAcdrmixd5g37fTc/FhcVcs4GO4s3m5zFTsIXHI0SjdDvIvA6za6+CpVER
 mov2zu1wJM+NaS246suUnn55zi4pxRJUi1PBbpE77GbWrre5fhqNkAwAxvSvM+jZ2XGRQRBhNPo
 tqkKXKuf7sg/s9N4vh7Qknpy1x1aMr6bPVE4fJHoGx7dmBZw==
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id
 d9443c01a7336-2edd7acfcd0mr38209125ad.54.1794453750555; 
 Wed, 11 Nov 2026 19:22:30 -0800 (PST)
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id
 d9443c01a7336-2edd7acfcd0mr38208695ad.54.1794453750048; 
 Wed, 11 Nov 2026 19:22:30 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6dfb58dsm26134275ad.66.2026.11.11.19.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 19:22:29 -0800 (PST)
Message-ID: <acd476e0-fb24-4f11-b917-c4e86f86171a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:22:16 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
To: Pavel Popov <pavel.e.popov@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>,
 Len Brown <lenb@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6h2kT31yWrjB4RogFfYmVYYaPaOSWTbI
X-Proofpoint-ORIG-GUID: 6h2kT31yWrjB4RogFfYmVYYaPaOSWTbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfXx4yTtMPlj1Ec
 6d7ZEtoiTSQzRj3m/L1CzYozPfWtAOBLjAHtYLGje40Z/AIHBPsOCA0FRC+42xKSIl5KdIxD7q/
 x9P6KRbHS+1M5dp5tpV29mwB2dubM4jd3iyJH1WpH6C7F/b3kVtfdezIIqoUvzsbWVybae70+IJ
 1drXlF42UsZF+aGCMe2l1vZL6yghDf2s4EdgqpMdUXcWFtWEAvFbsAanDnlQ5rbbL7h6QtOy2S9
 og8BJ/mvHEd8AvXoZpbrMM41w8f6uihy7vbBKg+e+99zKw4j+bJEF1u1JAzQS2s3MRVnOc9PTzB
 B3AShvPLbScXesa53PqHdw8I3uE+Z13X5J9tj0pWdsOxY8xiY3hIJjID0DuWylSHh/Ybkf3ng2q
 Em35no+S1fb6bNtMEjIU08fc7PDrJmVnIdpnoIL6tKpX5GPTTf8hZ5aHuxrUNRlw4CxaDdOfrVi
 gy9DVmEQjkHWRQGF73Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX5T/8LWRh9DkX
 ieK8nW0feiuPA5arYqmS16ENiysPih53vntRtl4D4Rd7ykUTebDWsEkl2PTeS5Tc41Oa/wgscb6
 NloLlzDLpttU6EOfQqPcWjDOPcZHiDs=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af530f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=L27Nr_72VT4YvYD4_PkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120013
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 7:48 AM, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.


Yeah, this patch strictly depends on [1] (series patch 1/3) being in
mainline first; otherwise non-x86 builds break.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>   drivers/cpufreq/cpufreq_ondemand.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
> index 2ca8f1aaf2e..0e33865f9d3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.h
> +++ b/drivers/cpufreq/cpufreq_ondemand.h
> @@ -6,6 +6,8 @@
>    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>    */
>   
> +#include <asm/cpu_device_id.h>
> +
>   #include "cpufreq_governor.h"
>   
>   struct od_policy_dbs_info {
> @@ -26,8 +28,6 @@ struct od_dbs_tuners {
>   };
>   
>   #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -
>   /*
>    * Not all CPUs want IO time to be accounted as busy; this depends on
>    * how efficient idling at a higher frequency/voltage is.


-- 
Thx and BRs,
Zhongqiu Han
