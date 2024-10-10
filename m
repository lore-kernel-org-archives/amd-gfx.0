Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96218D1625E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 12:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C5D10E286;
	Mon, 14 Oct 2024 12:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="jKaeuRf9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40DB10E156
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 23:49:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJjQdS000324;
 Thu, 10 Oct 2024 23:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qhj9QjPhMY3N3l11uQGEoOZB1Qu4SEZj3Soa9AAkvms=; b=jKaeuRf9LdWpnvNB
 NFBShdRFQXyynqiREd0rHzQ+Q6Wny12zpyza530MXWdtAoxY51M5+cku/u6kEgUV
 ut5tMr7jRg4DQxjUTevIVJGn5JUV1xT4GVBESuGgYL834lne8tyipLTSqdxSiOy0
 WPqWjdYuqVMqSqhCoJu4s++8Qt7m4okT+aqPPJVL82OCIKU6UdHi10GtjIF7GAWv
 a4Hwsy+FFJPy9iht6wnOPEnHMWEQN+mNT+6VypYhz1Mhr3C+opjuaY4ktSH29pFb
 1UO/yEbd+85bphzvvRJ8SPPLKOg0RM/NhErzZL2oGpcpE9h16+bIN6njo0RiokiJ
 ISb3iQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426nc2gdss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 23:49:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49ANn42x026374
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 23:49:04 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 16:49:04 -0700
Message-ID: <b7abd0b6-ac96-48ca-8165-a3b408137007@quicinc.com>
Date: Thu, 10 Oct 2024 16:49:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES] drm/radeon issues
To: Christian Zigotzky <chzigotzky@xenosoft.de>, R.T.Dickinson
 <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>, Darren Stevens
 <darren@stevens-zone.net>, <hypexed@yahoo.com.au>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Christian Zigotzky <info@xenosoft.de>
CC: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, Hans
 de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>,
 <alexander.deucher@amd.com>
References: <EE14413A-3528-4646-A353-DB5131E56BA2@xenosoft.de>
 <6C389917-EF59-444B-9C33-C3F9A9AD3921@xenosoft.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <6C389917-EF59-444B-9C33-C3F9A9AD3921@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: tdJz5yjJOWf3Dah3YuI-X5mA9T24VSNu
X-Proofpoint-GUID: tdJz5yjJOWf3Dah3YuI-X5mA9T24VSNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100157
X-Mailman-Approved-At: Mon, 14 Oct 2024 12:50:04 +0000
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

On 10/10/24 06:57, Christian Zigotzky wrote:
> Hi All,
> 
> There is another issue with the Radeon DRM driver but there is already a patch available for this issue.
> 
> Link: https://lists.freedesktop.org/archives/dri-devel/2024-October/473314.html
> 
> I compiled a new RC2 of kernel 6.12 with this patch for the X1000 and X5000 today.
> 
> Download: https://github.com/chzigotzky/kernels/releases/tag/v6.12.0-rc2-2
> 
> We need 3 patches for the Radeon DRM driver currently.

Can you provide links to all 3 patches?

6.12-rc2 was back merged to my ath.git project, but then my laptop
stopped booting correctly and I discovered a few Radeon KASAN reports.
Based upon my search of lore I found:

20241003060650.18454-1-wuhoipok@gmail.com
[PATCH] drm/radeon: add late_register for connector

20241007183241.1584-1-christian.koenig@amd.com
[PATCH] drm/radeon: always set GEM function pointer

But that is only 2 patches.

