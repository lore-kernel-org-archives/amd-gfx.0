Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92D7C4708F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 00:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2878561028
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 00:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2878561028
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78AB6EE9B;
	Thu,  3 Jun 2021 00:29:24 +0000 (UTC)
Received: from cstnet.cn (smtp48.cstnet.cn [159.226.251.48])
 by gabe.freedesktop.org (Postfix) with ESMTP id A3F526EE9B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 00:29:22 +0000 (UTC)
Received: by ajax-webmail-APP-13 (Coremail) ; Thu, 3 Jun 2021 08:29:14 +0800
 (GMT+08:00)
X-Originating-IP: [159.226.43.53]
Date: Thu, 3 Jun 2021 08:29:14 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Chen Lei" <chenlei18s@ict.ac.cn>
To: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Re: [BUG] Data race when use PACKET3_DMA_DATA?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn cnic.cn
In-Reply-To: <CADnq5_Mg+kVrXNLsNW8ZYS9JMmch4Jg5iAzOdCqyPru8UpmctA@mail.gmail.com>
References: <30855000.34f9.179ccbc8079.Coremail.chenlei18s@ict.ac.cn>
 <CADnq5_Mg+kVrXNLsNW8ZYS9JMmch4Jg5iAzOdCqyPru8UpmctA@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <66ba8554.40b87.179cf463340.Coremail.chenlei18s@ict.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: twCowACn3JRbIrhgW8AIAA--.40888W
X-CM-SenderInfo: hfkh0zthlrm2g6lf3hldfou0/1tbiCQcBBV02aOwfiAABsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex. Thanks for your quick reply. 
I first submit the OpenCL kernel packet and then submit the DMA DATA packet. And the OpenCL kernel reads the value written by the DMA DATA packet. 
If I understand you correctly, that is because the CP engine continues on to process the DMA DATA packet after launching the OpenCL kernel. If so, is there any way to sync the CP engine until the OpenCL kernel is complete?


&gt; -----Original Messages-----
&gt; From: "Alex Deucher" <alexdeucher@gmail.com>
&gt; Sent Time: 2021-06-02 21:37:51 (Wednesday)
&gt; To: "Chen Lei" <chenlei18s@ict.ac.cn>
&gt; Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
&gt; Subject: Re: [BUG] Data race when use PACKET3_DMA_DATA?
&gt; 
&gt; On Wed, Jun 2, 2021 at 8:44 AM Chen Lei <chenlei18s@ict.ac.cn> wrote:
&gt; &gt;
&gt; &gt; Hi, I noticed that there are two ways to do DMA for amd gpu: the SDMA copy packet and the PM4 dma packet.
&gt; &gt;
&gt; &gt; I had tested the PM4 dma packet:  PACKET3_DMA_DATA. In most of time, it works.
&gt; &gt;
&gt; &gt; But when I launch an OpenCL kernel followed by a host-to-gpu DMA packet, it seems that the OpenCL kernel read the new value written by the following DMA packet.
&gt; &gt;
&gt; &gt; Both the OpenCL kernel and the PM4 dma packet are submitted using the amdgpu_cs_ioctl, and they are submitted to the same ring.
&gt; &gt;
&gt; &gt; I was not family with the hardware details. According to my understanding, because the ring is FIFO, there is no need for any explicit synchronization between the OpenCL kernel launch packet and the dma packet. So the result looked weird. And when I add the synchronization(i.e. amdgpu_cs_wait_ioctl) before the dma packet, everything is OK.
&gt; &gt;
&gt; &gt; Was it a hardware bug or did I miss something?
&gt; &gt;
&gt; 
&gt; The CP DMA engine is separate from the various CP micro engines.  When
&gt; there is a DMA DATA packet, the DMA operation is offloaded to the CP
&gt; DMA engine and the CP engine that processed the packet continues on to
&gt; the next packet.  You need to use the ENGINE_SEL and CP_SYNC bits in
&gt; the DMA DATA packet to specify the behavior you want.  The ENGINE_SEL
&gt; bit selects which CP engine processes the packet (PFP or ME) and the
&gt; CP_SYNC bit stops further packet processing on the selected engine
&gt; until the DMA is complete.
&gt; 
&gt; Alex
</chenlei18s@ict.ac.cn></amd-gfx@lists.freedesktop.org></chenlei18s@ict.ac.cn></alexdeucher@gmail.com>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
