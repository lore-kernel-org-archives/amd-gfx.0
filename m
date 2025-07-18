Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE28C83F22
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F0A10E386;
	Sun, 20 Jul 2025 15:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MT33T1UE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6CC10EA17
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:53:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9HoD1016243
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m1zCD0dfghAVW4/iCikI1Mzy4E0jkoMJk9ypegKSOwQ=; b=MT33T1UEHYC6YVkh
 xssZayZWI3HS9jTCahfMVvQEQoKilwVkz1JDIhdTWrr4fS2s0bFRtxtea1tSz0cx
 WvCNn89b9XbKFUWvy6JOzg8z9k0pDLm7fTdPcpsfrG9CsK7EbrbZhsQP7pwVM8w5
 dhFWVEnhlBAWK3K5ERCzbGmCe3HsEwoOaaln7zV7ZWLEaThH+tVSpffHKWuRfTzK
 e0mUY7unvjQaE/RrPs7Tow3QPlwL6d9HfPpq/Ltwe3CCoZtcvp8935E6BXZHVjWo
 gx/UHuloGVJyE1k90Gixf1pB/v3W/YqPVPFFDXsrUPlD4rBg6S8NVsUuIkC3+ABz
 xfDK0Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc47tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:53:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235089528a0so29388805ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 09:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752857616; x=1753462416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m1zCD0dfghAVW4/iCikI1Mzy4E0jkoMJk9ypegKSOwQ=;
 b=Ot5mCElr8+2AWeaAYP6e1nLe7VNLwDI21Sxa89Iz+Ep2j2igyRC2L9OmcAdDhyEFTv
 IPGtph7JMKQYBLOmYcOv4BjsqXvrS3djck6/0cRyyOk7V4UfZem2KbOZk9knW3zzoLPq
 4gJWbSlhZrU59czp3bkv55U9TKT8W12pxUi8zzYfD8JBb98D+wR09OQi3CWqTHtk6pXL
 92qu0Zqjen3mMRgTXLxme9Rcxhi5bKtcOFsnpRtYG0l9Fg3Bknn4+6LaYBnFTU6SBjbn
 oYhFI6s2JN4jcEhQy2RdHZIsqs8SpS5Ddl5MQxAru3waV97Cvo34is1xZvAn5slYjd0y
 OVYQ==
X-Gm-Message-State: AOJu0YzqfQUbp6xhHgAXzslok/TkWgtcLxjUYryOBPd9umhuSkOvZDmM
 8nEZzO+QSpkfUUcodM7GRb9f2sSuuvfHBGVSDUFE+xMcDbGlqJrte6kGV99F+LngQcgfqhq2Swr
 ZlJuN+bMvxWQKx4DMSlYYKjt0+sg7aVAXklRkQOhDFXzku8J2h6YkKpvbSkAk2mgIZuV9
X-Gm-Gg: ASbGncsHor/hhEWTvlv5mjh1/2DV3s3BFXWuUcju0IUQggIwBvXdIqpXqzZ2LUkPlHx
 xy4av5MSSvAyDCme5VTpIz24JVQ2mhMnW7DnZth+DuM2VBui+cy0gjP2IlwTj6ethuEomvKWrZm
 OuP48Ye836LyCznhos1XAUIMTTSX4i67iWMtIvZVwxgnCrPeUX4jNcCVRwYLMGEke6izdKbGIe7
 yog5C4IH5I1c0qWRjCsKQijRLNUEKXHFOBP/7ISY+Qj8J3kxYlYfA33kY+TWZ30nPGOKMxdIIP7
 G7W2k3Cq+I9Jg8WggYJwgOK86aCdmxKeupG51BrmQWGjePdRn+XtNmV0CGvjrJpVinWds1Hv2QY
 dXGdrHBrzOnm1kQ==
X-Received: by 2002:a17:903:186:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-23e2f744c24mr114646215ad.20.1752857615751; 
 Fri, 18 Jul 2025 09:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuWrniCXSDlgPowFyHtxd19vZI/IqgnQedWoC58cRaes2308e8m8bmwseHhboSm6uY1fQsWw==
X-Received: by 2002:a17:903:186:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-23e2f744c24mr114645715ad.20.1752857615304; 
 Fri, 18 Jul 2025 09:53:35 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b490fsm15812805ad.112.2025.07.18.09.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 09:53:34 -0700 (PDT)
Message-ID: <515c3aae-13f7-47d4-91e4-d2d54fc8e2f3@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:53:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] drm: add debugfs support on per client-id basis
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
 tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org,
 linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20250704075548.1549849-1-sunil.khatri@amd.com>
 <20250704075548.1549849-3-sunil.khatri@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250704075548.1549849-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a7c10 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KjCdSd8fyryEu2hfdkEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: xzwoLLv0aX1rE3s0rq18ipkHNxIAMncl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMiBTYWx0ZWRfX2FNaW7Pql+LD
 HMiYHA6MdQROXGijFGN8TB1jjVMLN4Jf5XmHSL3O8etHepZSzl/IUhS5dtZXflU0RtZ9ljlSmv+
 mNdqGyGpoWombwQBei83LDfXarur8cSjLDfK2JgxwKfdxW5YYHQNTOo9+RcY/zTtEMrsls3rDYS
 OSk8HW1Y1wQeyon3dwtYXxpWoqwM9mtvsFKBVDUfsdJd9dWSBWnumS16sykP5L1eAKtv7iZbkrA
 kgxTNlI/kM9uw2AK57MEwm+x/NZOKJyrjp0yWBW8lE6CKo4XIVgcLDMC+oJviBNvRaR0DFhA9aV
 U8w9Qcr1CzL7NtulnkWDJZsHQgnaGM2fiMu+PqiEOFaouabSlg45AOtMJgA50Ts8YlqKJOtpuHJ
 xZpVHaE18o8cXoOdGy6D7HDosic9SizhSLshGsYFx6apdq4jKxE40FtN33bjZOX+HevaSLF9
X-Proofpoint-GUID: xzwoLLv0aX1rE3s0rq18ipkHNxIAMncl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=791 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180132
X-Mailman-Approved-At: Sun, 20 Jul 2025 15:32:54 +0000
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

On 7/4/2025 1:55 AM, Sunil Khatri wrote:
> add support to add a directory for each client-id

Nitpick.  This is the start of a sentence, and therefore proper grammar 
would have the first letter capitalized.  So, "add support" should be 
"Add support".

-Jeff
