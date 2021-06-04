Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6619C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CE1613AC
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CE1613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255216F5BA;
	Fri,  4 Jun 2021 07:40:13 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350F16F5BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 07:40:12 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id k25so7562142eja.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=T2LF/iXm2hY6nCrOz0bpKtxr+D9/Llstgz8ndcZZQE4=;
 b=lFPJ6a7hUfz6DhVAry3i4IfjzF4Xlo6tr5YPRskRxKZqVsGryBpx4kTMCgUpygUdhh
 pcyim68U2/THJgtMAKpz3bxstUQHmZ6qkF5O9OXB1uwHArTRHLJFkAuDN7HhUjBfytbf
 Y34FKXedYx2aisX75RdWNEDfPTkihMhpDNzSNb8ZIm0ihAxF1pIW3bnIldnyEx+9RNP1
 rv2fTVBKEgM0fFxwwIIHPjAvDitvHgC/6fWOyaPhdBhUYleyFiHCunnJxcnP5L8Dnui+
 oAX3KHzdHfw+gsX3Mg7VZnll66nCQe8c5hrzQ1cULdzu6KSnvvhGql3TpoD6iYXQRTu3
 YuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=T2LF/iXm2hY6nCrOz0bpKtxr+D9/Llstgz8ndcZZQE4=;
 b=bMk+Ei0KjaBmR+vKfWDiwUO2SNPArN+dTpuJcfO9987NiVM4klERTzPPfMobMlBEGS
 mw4CsXavg4o4IQY5TzXQUHR0TA0ThANnKnvF3eiJISxXiuI/c05AamlY9LZuc+Wj64mi
 Egg1mZhh7snkvrkxs/XLj2VgnXWB+vNc1zFFHMynFSKO+FbNwBDxQc3UwgmHUxqUoaV0
 G69f4XlredklUd6SPF/uv2Jwfu5ZYWw8Iag5DAOsb5KaARDObIceD/JeHvNjMyTC5rE+
 e6/DZhTio0ZgXNKt/Nw5ashKC54oa/B1psgFRtO+StQful03wsotR+O9C0RfkPiZtLuC
 Gnkg==
X-Gm-Message-State: AOAM530gbYDufhn586PRRUiBZV+fXiWgnw2sfF15WfWVqp7UQKgG7FER
 Le03ozxw9Ag74Ufixl3k4sOmEFrQ4YI=
X-Google-Smtp-Source: ABdhPJyxEdyVQGbn2F/W4Nz+1PFKjAQpaTVvTKWspZ03uJPjkOaw4byMNSmgQZw4toy7X56dV1FFrw==
X-Received: by 2002:a17:906:2419:: with SMTP id
 z25mr2984929eja.343.1622792410869; 
 Fri, 04 Jun 2021 00:40:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581?
 ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
 by smtp.gmail.com with ESMTPSA id p10sm2425077ejc.14.2021.06.04.00.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 00:40:10 -0700 (PDT)
Subject: Re: [BUG] Data race when use PACKET3_DMA_DATA?
To: Chen Lei <chenlei18s@ict.ac.cn>, Alex Deucher <alexdeucher@gmail.com>
References: <30855000.34f9.179ccbc8079.Coremail.chenlei18s@ict.ac.cn>
 <CADnq5_Mg+kVrXNLsNW8ZYS9JMmch4Jg5iAzOdCqyPru8UpmctA@mail.gmail.com>
 <66ba8554.40b87.179cf463340.Coremail.chenlei18s@ict.ac.cn>
 <CADnq5_PN+-N+QCuAGJeyEHLJ_WuX_vUf=fDgjruwHcKtD15v0Q@mail.gmail.com>
 <1d273190.41b52.179cff24956.Coremail.chenlei18s@ict.ac.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b5c15d2d-4660-51ca-5205-b724b51f8ad7@gmail.com>
Date: Fri, 4 Jun 2021 09:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1d273190.41b52.179cff24956.Coremail.chenlei18s@ict.ac.cn>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I think your problem comes from the missing understanding that the 
hardware is heavily pipelined.

In other words commands you send to the hardware just kick of 
asynchronously processing, e.g. a CP DMA command just kicks a copy 
operation but the CP then continue executing commands.

Same thing for a RELEASE_MEM packet, it just kicks of an operation to 
write a value to an address when all Compute or 3D rendering is completed.

But if you want to synchronize execution of the CP commands you still 
need to block for that valuie to be written or otherwise the CP will 
just keep going with the next command.

Regards,
Christian.

Am 03.06.21 um 05:37 schrieb Chen Lei:
> I had seperated the dispatch packet and DMA DATA packet into 2 IBs, and called the amdgpu_cs_ioctl twice.
> If I was not mistaken, the `amdgpu_ib_schedule` would emit fence packets for each amdgpu_cs_ioctl call.
> Did I need to insert the fence packet explicitly after the dispatch packet?
>
>
> &gt; -----Original Messages-----
> &gt; From: "Alex Deucher" <alexdeucher@gmail.com>
> &gt; Sent Time: 2021-06-03 10:11:46 (Thursday)
> &gt; To: "Chen Lei" <chenlei18s@ict.ac.cn>
> &gt; Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> &gt; Subject: Re: Re: [BUG] Data race when use PACKET3_DMA_DATA?
> &gt;
> &gt; On Wed, Jun 2, 2021 at 8:29 PM Chen Lei <chenlei18s@ict.ac.cn> wrote:
> &gt; &gt;
> &gt; &gt; Hi Alex. Thanks for your quick reply.
> &gt; &gt; I first submit the OpenCL kernel packet and then submit the DMA DATA packet. And the OpenCL kernel reads the value written by the DMA DATA packet.
> &gt; &gt; If I understand you correctly, that is because the CP engine continues on to process the DMA DATA packet after launching the OpenCL kernel. If so, is there any way to sync the CP engine until the OpenCL kernel is complete?
> &gt; &gt;
> &gt;
> &gt; Once the kernel has been dispatched to the shader cores, the CP will
> &gt; continue to execute packets in the queue.  If you want it to wait for
> &gt; the pipeline to drain you'll need to insert a fence packet (e.g.,
> &gt; RELEASE_MEM).
> &gt;
> &gt; Alex
> &gt;
> &gt; &gt;
> &gt; &gt; &gt; -----Original Messages-----
> &gt; &gt; &gt; From: "Alex Deucher" <alexdeucher@gmail.com>
> &gt; &gt; &gt; Sent Time: 2021-06-02 21:37:51 (Wednesday)
> &gt; &gt; &gt; To: "Chen Lei" <chenlei18s@ict.ac.cn>
> &gt; &gt; &gt; Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> &gt; &gt; &gt; Subject: Re: [BUG] Data race when use PACKET3_DMA_DATA?
> &gt; &gt; &gt;
> &gt; &gt; &gt; On Wed, Jun 2, 2021 at 8:44 AM Chen Lei <chenlei18s@ict.ac.cn> wrote:
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; Hi, I noticed that there are two ways to do DMA for amd gpu: the SDMA copy packet and the PM4 dma packet.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; I had tested the PM4 dma packet:  PACKET3_DMA_DATA. In most of time, it works.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; But when I launch an OpenCL kernel followed by a host-to-gpu DMA packet, it seems that the OpenCL kernel read the new value written by the following DMA packet.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; Both the OpenCL kernel and the PM4 dma packet are submitted using the amdgpu_cs_ioctl, and they are submitted to the same ring.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; I was not family with the hardware details. According to my understanding, because the ring is FIFO, there is no need for any explicit synchronization between the OpenCL kernel launch packet and the dma packet. So the result looked weird. And when I add the synchronization(i.e. amdgpu_cs_wait_ioctl) before the dma packet, everything is OK.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; Was it a hardware bug or did I miss something?
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt;
> &gt; &gt; &gt; The CP DMA engine is separate from the various CP micro engines.  When
> &gt; &gt; &gt; there is a DMA DATA packet, the DMA operation is offloaded to the CP
> &gt; &gt; &gt; DMA engine and the CP engine that processed the packet continues on to
> &gt; &gt; &gt; the next packet.  You need to use the ENGINE_SEL and CP_SYNC bits in
> &gt; &gt; &gt; the DMA DATA packet to specify the behavior you want.  The ENGINE_SEL
> &gt; &gt; &gt; bit selects which CP engine processes the packet (PFP or ME) and the
> &gt; &gt; &gt; CP_SYNC bit stops further packet processing on the selected engine
> &gt; &gt; &gt; until the DMA is complete.
> &gt; &gt; &gt;
> &gt; &gt; &gt; Alex
> &gt; &gt; </chenlei18s@ict.ac.cn></amd-gfx@lists.freedesktop.org></chenlei18s@ict.ac.cn></alexdeucher@gmail.com>
> &gt; &gt; _______________________________________________
> &gt; &gt; amd-gfx mailing list
> &gt; &gt; amd-gfx@lists.freedesktop.org
> &gt; &gt; https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> </chenlei18s@ict.ac.cn></amd-gfx@lists.freedesktop.org></chenlei18s@ict.ac.cn></alexdeucher@gmail.com>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
