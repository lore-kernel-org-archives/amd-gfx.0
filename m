Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A492C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 07:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00ABC10E5E8;
	Tue,  8 Apr 2025 07:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LhrKWVdB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D54510E4FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 16:03:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378doqw003269
 for <amd-gfx@lists.freedesktop.org>; Mon, 7 Apr 2025 16:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fc3XwojJ5GFfdF94r7F5k7ZenDcWsyFJvzqBaDf4v4E=; b=LhrKWVdB0XApgiSi
 353Kx+c8j0G1MEQPLZS1YUKrFV/20lOlvVl+YLT7USlQXdf8LLogfhBC23nD1Ch4
 yE4zq3OMN6Hmy6UX1oWEBMkk8uQDaXiRe//l6AewLCu27L2z6+tZxByzRYalFM1q
 cj434Xz8yPb/C2ZV41WC7+73j6iqFrLlzbnRPi9DNjcstlwgOzsXWEcCCFGzrFYD
 PjFZPFWjLJi7H76w2fytPAYkrCrh7koGIfqc7vrYHY5pznJFi5IAtg8uamO+n+X0
 cD6jxRUCopbEC5Yap3+i3I15uJlUi63JIjhqmQMg2h4cLzPHob9twNKVgEjY+27B
 Nn0gOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftcqhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 16:03:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-223fd6e9408so41228395ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 09:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744041779; x=1744646579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fc3XwojJ5GFfdF94r7F5k7ZenDcWsyFJvzqBaDf4v4E=;
 b=QHVsUG5fckY7zmDC4OcAxcxPzW0EULw0XWEvs/zm8Q/Ki/cJ+GmvjHQnQgXWFIF54q
 9md8+HVqO5CSWXdlvHFLBtSQNqLyRtQCOCYqzKCUfMOjrWHd0kldDfVrlgyqRSdd8DE1
 h+fM9OMxfd2bAiPy5KZzkGs14LTg4ar+xn3oJrfET0vI+mM8nNY4neuic9iX3y86unOp
 R/ttcdbBe2AHWaaODHGN64Fb1xtf7kzUQYTJaOsT7G1hoSa4fqxowi3SugS9AiACJYD/
 WlZG9nhQtcQT++sccHgv45NMvERwhF4KoLwgUu3CpanemFzt5moznruLuX4TfcYVv5B8
 lpTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcSFXUb8QTBTu/T30Qf8wsNJ9taZl5+jaeDoQ2vLV46Mn1GY4xlYCpoGM/neEODkmggN8FE9tc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwACdLq6Ft0G8b40g/SJqekRyTHYPhKUaVwO4W4dl6yRLjrQ1n3
 feCL78tpBBYlT2j9B5EVbxcoJgrxQX4j7R8iaU5biAdcq3FKuFxLAnQ4T7aPuIryxmWahoizu5B
 Gm2c0YUeOW4g9hS58m47w5RE/eqiA769H6GUva8U4giL2CJIcudGvhfDc+gI0HfZf
X-Gm-Gg: ASbGncvu0fbJflu12ekGJG3RWpjcgi8vJTWSGWZZYZsVdZGQeMv9bPXm5TIgm+BxKZ2
 FZPt1zQNwfCOIE03TUKVimLHbIbpqkjbMTUVLPrNAcquL0mMZYgsouzwwY/ADhqS8HuSTwuRjyK
 zLDNdgbESIE11xhNsYOFkKRdp03kugIXt+34w+0liLIlbQRpvsScJiM45Lt36bqcngUDQjkN1vy
 r3OkFBCdoZ86f/llgadROZl6Bv16bLhbIGpAsQRYMvM/A4DcRSOw+PRTB8k+QJwfYU8tM4hee80
 gq8w/MZ7KdsWc7zSyqPRaXAShgD2BHiWRvNh4nuqi0k9z+S3V0EuhDUL6n+nkmZ2kQ==
X-Received: by 2002:a17:903:2a8f:b0:225:abd2:5e5a with SMTP id
 d9443c01a7336-22ab5df1b0dmr455375ad.4.1744041779596; 
 Mon, 07 Apr 2025 09:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQkBFjjP+ONLlvzzb1gd0pTO1LSFOf1s2n0EEL7fUMEzu7Ove5cxahF9Lf52ILh1wQo+2pDg==
X-Received: by 2002:a17:903:2a8f:b0:225:abd2:5e5a with SMTP id
 d9443c01a7336-22ab5df1b0dmr454955ad.4.1744041779170; 
 Mon, 07 Apr 2025 09:02:59 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97f2fd3sm8971891b3a.69.2025.04.07.09.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 09:02:58 -0700 (PDT)
Message-ID: <cd94dff9-d28d-42f5-a071-26e9dd0c3490@oss.qualcomm.com>
Date: Mon, 7 Apr 2025 10:02:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] PCI: add CONFIG_MMU dependency
To: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Carl Vanderlip <quic_carlv@quicinc.com>,
 Oded Gabbay <ogabbay@kernel.org>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu
 <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Sui Jingfeng <suijingfeng@loongson.cn>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Zack Rusin <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lijo Lazar <lijo.lazar@amd.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvm@vger.kernel.org
References: <20250407104025.3421624-1-arnd@kernel.org>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250407104025.3421624-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f3f734 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=ZLGELXoPAAAA:8
 a=EUspDBNiAAAA:8 a=mM23EaL7GqIQzlWAp5AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=CFiPc5v16LZhaT-MVE1c:22
X-Proofpoint-GUID: 6D2EyvIyaMG-10W6r5SzpY1oeUfN0--n
X-Proofpoint-ORIG-GUID: 6D2EyvIyaMG-10W6r5SzpY1oeUfN0--n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=713
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070112
X-Mailman-Approved-At: Tue, 08 Apr 2025 07:22:33 +0000
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

On 4/7/2025 4:38 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It turns out that there are no platforms that have PCI but don't have an MMU,
> so adding a Kconfig dependency on CONFIG_PCI simplifies build testing kernels
> for those platforms a lot, and avoids a lot of inadvertent build regressions.
> 
> Add a dependency for CONFIG_PCI and remove all the ones for PCI specific
> device drivers that are currently marked not having it.
> 
> Link: https://lore.kernel.org/lkml/a41f1b20-a76c-43d8-8c36-f12744327a54@app.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/accel/qaic/Kconfig              | 1 -

For qaic:
Acked-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
