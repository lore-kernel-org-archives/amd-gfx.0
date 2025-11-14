Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC309CD4F49
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 04:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523BB10E9A5;
	Fri, 14 Nov 2025 04:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcdvIvc3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLj585zx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B5410E99F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:12:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADMb4BL1431744
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=l9FUBbeUidxIV00pdQyQahKH
 PpoxkuEk9fyNczKyhZ4=; b=WcdvIvc3sMDYJHBly1X7GlPj50GGKCEK4vrDj8k0
 5eaZ80++Ws3b6M4a/w2eVgp5fBZPqpReXJ6xcZvCuGqlyHQVAUPNMJplXDtRkmjR
 y6847o+zGxT2XJUEtVt8QOs1dNpy77MXiVZuOJgYMs0BamIgUtjw2hTVBYrDWjPI
 ByZ746JdSL8Gv5MgaoTNMk2yzeUNW4jCf/D2j643Vd/vNt+46rBlvy+jz4Ihw0Z+
 fTd/SLbn6SPCPWVriGZp93nSNSFJRad1vxT6ksE51c5WW0OqhiOxjWbi0pFY79Eh
 201wVoknTjIeNpA4GWGoZTCf94s18YBclqS5YUrFYMV7Vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9g0ra8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:12:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-891504015e5so474111585a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763093552; x=1763698352;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l9FUBbeUidxIV00pdQyQahKHPpoxkuEk9fyNczKyhZ4=;
 b=bLj585zxy40JbPQnB7TYeZCwkJjtX5VPngjGilbV+u4+wuN5Cpl8HwU50qQp27+ivz
 X1O2UYJ/KzjWfW1OIWn5ex3sWdxO7C+Jh9wf3PG3EJyWcYbTO8GkE6njFVQBFoh2XxBb
 RLDeHS9gsxXlhJ6uoiWzQgQuoo8H0iYmq+onuLvtddVMc5Mjw2todKy/HBitYQ9/TdY9
 couWxutqUko0LPLCOExipha+bGUG83HMlOYTysxEVWgiwlexMJmk/raLHlEU74bEHVBq
 pkkLSoV0T7MylTmfg0V11/f4aFM0VPpN67/RIXNA9OQi6GsR3e1+BXmKKK/l2s4RlVoC
 OW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763093552; x=1763698352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9FUBbeUidxIV00pdQyQahKHPpoxkuEk9fyNczKyhZ4=;
 b=SIT58KJQ/KfkIcv0aWVf3ATBJCx3GNlgri9qikmmAkulUcKC67EBfV2Sx8FfvXJF5m
 Oju1Imjah+EqrlTOaBAfz1VSc+UQuILlK1ivu27CePKAbzhRHbzwfbpScjl/oEHNJ8LF
 Jm0C+d/U3JKxQ66OboCmfefnNhzm+aGQMXeIOUkubObfOxjUhppT/tTANISp54rW5QFL
 AjvzIgCNsoooEfce71rf+EsRPIlAjKmx+EUf8wkDnoENYPgFcwuA3Dx7daGJ3d8S5BsB
 qTEHXKJGWlbPKZpKZlNAx0z1Fdzgt2SB4Ytxa87LrqX20korJjX3Tr+JZgQh9qwNRHdr
 wlRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVIj/TCAj9TrH/juaRzZCMwUkT8UCW0kP0zc/tbIl3eK7cQueqdUoGMgx2BtdfEEzzKBNJK29P@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqCbOQM/byg5blklqbPfC4HVprzU1pABxZS80N6btVb2hOHjh6
 5E60q82xappL92jQunRL5F7d7bOheedph4kyKuEI2JKlT/go1M/wOyMNwzrBEGTGKa5/s9OKW/H
 cuBd3XAoHYSewdiiggmgLZ8Sg265P3g8BpIjvFSn9Xw2x9hKGrsA5wqpsWfgX7gt+hjCR
X-Gm-Gg: ASbGnctexoyShCDFP+ArUQnXhT+WeSkK/GEoPHGLTEpG24tIm+hhhVHx2YuZWs19QSi
 PkX/wfC8CZKbmYYckAttZyv5LCZhHr5M9hrbsWdqN3sdCoi+BpOXu0SnLY9Eu9vEZQUfs01Qv99
 89J7EkBEVdUtO0ONHdZvT/RJhsmqtyoNJGfjW/2ioxD9ATQTiiGxTKN1wobjTW9T/QY9ooTCpUZ
 ob1E72ApBOtK43iprzVYPGpcxuhZpfNhNl0ueuUe1aXBLXPc9SJppqFppiQFHAgzafpQetCsL+n
 aULhHiW8p4oWQ9vbWRYGUFppbMNGmo+LpTPKVoX2EyhXzZSISBambpFL6UNiNMDsPtc3V+we9Hw
 cG55k/BTs1y1vWfyXGGsjNQfkbY0g5/Oef5Z78ntyKOVkd96NisMf0jWpEtpSTdfiNGx7p159Nm
 3DFP/95zcuFIYb
X-Received: by 2002:a05:620a:4628:b0:8b1:ed55:e4f1 with SMTP id
 af79cd13be357-8b2c3175d59mr235431785a.39.1763093551955; 
 Thu, 13 Nov 2025 20:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRBRFxxiAD30mEJm55HBtKCBqJwVeb/nqEO1wa7PZ+U+vRFrL3SI4k/Rw4EJ92OxtkmKQ+nw==
X-Received: by 2002:a05:620a:4628:b0:8b1:ed55:e4f1 with SMTP id
 af79cd13be357-8b2c3175d59mr235424485a.39.1763093551352; 
 Thu, 13 Nov 2025 20:12:31 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59580405a4esm784867e87.95.2025.11.13.20.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 20:12:30 -0800 (PST)
Date: Fri, 14 Nov 2025 06:12:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Sagi Maimon <maimon.sagi@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Karan Tilak Kumar <kartilak@cisco.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 Max Kellermann <max.kellermann@ionos.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
 ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Satish Kharat <satishkh@cisco.com>,
 Sesidhar Baddela <sebaddel@cisco.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 06/21] drm/msm: Switch to use %ptSp
Message-ID: <ngzyqzrjg2msv6odahkirdipjizbpaecfscfgnic3su5fl6hs7@qgdb53svq64p>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-7-andriy.shevchenko@linux.intel.com>
X-Authority-Analysis: v=2.4 cv=L+AQguT8 c=1 sm=1 tr=0 ts=6916ac30 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=JNz3O4sEs4oywJvo4n4A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAyOSBTYWx0ZWRfX9r2IvZEj3+8P
 8MrJaJQTEb/5U43rIDO3WarR0QSj4Ew+YM/GzM5ZC4Z1vdmfP85HKB66VGPdHVDuL6hDbsMUJnU
 FAmSL/1nqoIXzRQmgu6nJA0yVhnPxgmW4j1gDaOtfzIDhzwFXR7uRJUq8NZLz40rsMSYWdN6G7O
 TosSYd0P1kth8e9/sjwC/odM4q2fNAssl5rwCObey8V16IRqyEArssJFODc9D034MhDdahiMTQZ
 1XotkaThoUiAbLnV5f57d5zD61gAfUj2d4qmitG6uFyUfxp5Q+Don6xcH72pwuI1ABDZEznvSby
 HOHU9HsERd9hvP1OuuTN8mODBww1U2Y8fz2MQcGDOt7Ltcche4CAU3D+xnmvVw1KHFRmhGqLTNO
 m+zb4ihh0Y7LycQdfj9EXjLDIooyDQ==
X-Proofpoint-ORIG-GUID: G0I986X_guHiBRjnPwz1pGpP2PtKStRK
X-Proofpoint-GUID: G0I986X_guHiBRjnPwz1pGpP2PtKStRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140029
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

On Thu, Nov 13, 2025 at 03:32:20PM +0100, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 3 +--
>  drivers/gpu/drm/msm/msm_gpu.c                     | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
