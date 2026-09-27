Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFA0C9830E
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3BF10E4A3;
	Sun, 27 Sep 2026 13:26:05 +0000 (UTC)
Received: from omta038.useast.a.cloudfilter.net
 (omta038.useast.a.cloudfilter.net [44.202.169.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CBF10E28A
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 00:48:08 +0000 (UTC)
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
 by cmsmtp with ESMTPS
 id AGlnxHzc3JFmFAd3nxIUJr; Sun, 27 Sep 2026 00:48:08 +0000
Received: from delta.websitewelcome.com ([192.185.83.61]) by cmsmtp with ESMTPS
 id Ad3mxKBsLouFZAd3nx81B8; Sun, 27 Sep 2026 00:48:07 +0000
X-Authority-Analysis: v=2.4 cv=Zd4dNtVA c=1 sm=1 tr=0 ts=6ab867c7
 a=sy7HV6YSrPMGO6i17biZvg==:117 a=AaDvNZWQTOfaQVmSqZoT7Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0XjxDzgCAAAA:8 a=Mpv9E8u5tF5z9Bn9wf4A:9
 a=QEXdDO2ut3YA:10 a=dbKRzECqi5yn7_EwFreH:22 a=9Z0VUmeasobPx05O_PEl:22
Received: from [193.5.233.205] (port=14475 helo=desktopmikael)
 by delta.websitewelcome.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <contact@mikaelpelle.com>) id 1xAd3m-00000003lsI-20u0;
 Sat, 26 Sep 2026 19:48:06 -0500
From: <contact@mikaelpelle.com>
To: <timur.kristof@gmail.com>
Cc: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for
 PPSMC_SYSTEMFLAG_GPIO_DC
Date: Sun, 27 Sep 2026 02:48:04 +0200
Message-ID: <003801dd4e19$db9cacd0$92d60670$@mikaelpelle.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad1OGJtJvhxAnrmBSva/rmtQd15kwg==
Content-Language: en-gb
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.websitewelcome.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mikaelpelle.com
X-BWhitelist: no
X-Source-IP: 193.5.233.205
X-Source-L: No
X-Exim-ID: 1xAd3m-00000003lsI-20u0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (desktopmikael) [193.5.233.205]:14475
X-Source-Auth: contact@mikaelpelle.com
X-Email-Count: 2
X-Org: HG=hgreseller;ORG=hostgator;
X-Source-Cap: bXBlbGxlO21wZWxsZTtkZWx0YS53ZWJzaXRld2VsY29tZS5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfELQOT1F/pURgbYp/Lhzp+VZbXYmGfnfmCWgXnBksPMJy3OKRY5EK0akK2PpY07yMCtf5cdAdiDCg3QKJd2ZswHGia/cvlUAYYKKD5ICb18R8bMc0xOv
 /wZkcKQsIO3n7NfGJPjHUMkyqsKn9nTz5v/+eXBU4AVScVyYi76nNbbw9O0AdofV1bRQc+Lm9SkIk9Ca67zKQUgnTxWijSdPQJ0+Id/fEhQ4+VGSrqmv1ggU
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:26:05 +0000
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

I tested this patch on a Late 2013 Mac Pro (MacPro6,1) with dual Apple =
FirePro D700 (Tahiti XT, 6 GB), and can confirm that it fixes the DPM =
issue on the D700 as well.

Test environment:
Arch Linux
Kernel: 6.18.54-1-lts + this patch
Mesa/RADV: 26.2.3
GPU: 2x FirePro D700 (Tahiti XT, 6 GB)
Params: radeon.si_support=3D0 amdgpu.si_support=3D1

Without the patch, both D700s remained at 300 MHz SCLK / 150 MHz MCLK =
under Vulkan compute load.
I checked the D700 VBIOS as well: ATOM_PP_PLATFORM_CAP_HARDWAREDC is =
set, and it contains a battery state at 300/150 MHz.
With the patch applied to the same kernel, each D700 correctly =
transitions from 300/150 MHz at idle to 850/1370 MHz under load. I =
tested both GPUs individually and simultaneously.
As a real-world test, Ollama/Qwen3-8B fully offloaded across both GPUs =
sustained approximately 18.3-18.7 tokens/s, compared with ~2.34 tokens/s =
before the patch. One API run generated 1517 tokens in 81.24 seconds.  =20
I observed no amdgpu VM faults, GPU timeouts or resets during the tests.
Tested-by: Mikael Pelle contact@mikaelpelle.com

