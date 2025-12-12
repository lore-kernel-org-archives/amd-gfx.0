Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E77D44145
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C6C10E580;
	Fri, 12 Dec 2025 08:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="RKcuFZYu";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C8D10E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:47 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC3w03q022889;
 Fri, 12 Dec 2025 06:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Wjp0XC0M5S++DFByi
 M7FGae9j5gFR3KSIble3nX3WNQ=; b=RKcuFZYuuT/dZMEOIEmR3Ep1q+Ec5HAyl
 /JYNOOhR/cL0QKirjInBWCdXtIwwHlRHwtJyGe2zrY5wJClaKpRJuu5kHrFce+MW
 wPoXj3MJqjSr6VUXZoVvSXWxNnfM54z/qzkMkB2zhC9CFKF/n5t7mWsdi3NOK2rp
 KW453JmaSvJG241A3b5e4YL47fHWGaHFYAoLZEZx52IaMHHXhfp6poIHO64Hyumh
 35f1WF5F0p5WWs5bmWELgJWyWojg4KhylSlvBKvgE43K1K38vUP8pGp8hU++i+3T
 g1uNx2UY6RkQ5uEBPADqXQmEUy8f0gUyOfI/dyR6oAayzr7MTM0Cg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6ei6c030810;
 Fri, 12 Dec 2025 06:40:44 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC3AUdu002031;
 Fri, 12 Dec 2025 06:40:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jtc6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6ee0a44302716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23E7020043;
 Fri, 12 Dec 2025 06:40:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6091120040;
 Fri, 12 Dec 2025 06:40:38 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:38 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
Date: Fri, 12 Dec 2025 12:10:11 +0530
Message-ID: <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GghY70p18NVaHLESx8-g9sRwEaYwvogP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX/IxDbyYZyjqd
 zI00CT2YKN3gOHxtTinOOMul+KmcFVnDz1iZVvZlgfRJCneWqN6YhinW3YCPrvDa+3gIoFABzcs
 SwF7M+JhYP95CBdT4wLxcsAO5KHtTz0FiGgqMLKmswdaVJLpmkx6mjmQRvtLmdmP+zZbieSyqxp
 y1OnbZnnT6cYUwFrL2SVrPYzcljATdjnCNM4M9q0r4Me93hNzPJEjN7w09kh6EZtmWgS1z2PQhx
 tzIJUFgmSetZ8dw3bAVIO0FZfAVZnJ+dRCZs7dv31H42MK9IVD2bVA66OZPcsk5bowkPawr6+gH
 M77ijRPaJfOhAdRMR/lcXM2lCUy/sCYYuxycZ60BvGn76m6Kz0PiSpdRClSQVbjlwedByyrE3Cg
 J7GiGOsmfPn+wCf1l5axlUhrRbG0dQ==
X-Proofpoint-GUID: cGSvbyiBXInBrDx3HV62BXZfxNkGLLt8
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693bb8ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=FF0XGVAgeIgctPtqneMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
X-Mailman-Approved-At: Fri, 12 Dec 2025 08:29:54 +0000
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

The SDMA engine has a hardware limitation of 4 MB maximum transfer
size per operation. AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
512 pages, which worked correctly on systems with 4K pages but fails
on systems with larger page sizes.

This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
to match with non-4K page size systems.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 0be2728aa872..9d038feb25b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -37,7 +37,7 @@
 #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
 #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
-#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
+#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
 
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
-- 
2.52.0

