Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A464C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 13:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3FB613B1
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 13:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3FB613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54756EC9C;
	Wed,  2 Jun 2021 13:38:03 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ECF6EC9C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 13:38:02 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 w20-20020a4a35540000b02902458551c0d6so549584oog.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ci4tDtLMSG5G+TJz9ltqcRQGRK+5sr9k13mMj/xDAis=;
 b=DHduo3nx4yk7gco8drSlg/cqNI2gGAijqO0ZCH0EUpn0VrYTq2cq7g3Nbd+XvwlSc+
 l0Z2yAUzozPNNwrp1hC+7AqaNDtoInRBMH+ps2X4v7dlqw78V5brbmYegS092eXuVsr4
 3ozEcypqzuxOzSBW6l/yPKlXcECWDdgRzLzOWYTI8GhFGdAbkvh2+TUmm0It9LG0szZe
 ZkUautzr86Yaq7GvZ8pWit1KtHS9Pq/dzyvuR3nTZddFXD0zyvJjgbNhPXnkqzscW5O6
 ElPWET2e56cdTriQ4bKRQ3Cg7BTlw7gOWPuV46+C4rbNZ46iRc0lOUIY5HdhpdbwMaJ5
 hhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ci4tDtLMSG5G+TJz9ltqcRQGRK+5sr9k13mMj/xDAis=;
 b=DCia5gVMwz8Zxspq2AYn5s4Zd8BW6c4OTLz1OR/hRhFrOIowRSKGhBJtM5nMkQizwK
 7OSGeyzyO7tP1yBlXv4YlPEaW3ANMJbjOujjUZawjP0MlYOXpP2/Z7tnd43q4Wg1QJCu
 +WLANjo69PXkpBfITXeI52BxRWefUrPLYVju7aXn4Ld3FniLrS6/Vv237aWcr6dTwadh
 8JIoWQ/wQFmc5T5A7r9kE1XezRP3e1YccsCapdQIAKxt08mdHb6FEH9gzUfO9or3RYAU
 gYjWgEws7ogqNCFPYf8dA0aYS0HopI2/imB9a8OeET9vypoVHjN1RgKR7kzDg5pMfpqH
 FI/w==
X-Gm-Message-State: AOAM533z3Jq70YCXInDYTF2TkWyojCGhvwsFVojau/UbhOIc28h90JCv
 AgFf+Ya6G/qIOYG1TMEXOS4Rttj3ROYYKkJKRE0=
X-Google-Smtp-Source: ABdhPJwP9ydhsBMshVLyWsY+KY3R8/16AvOMhbK2OhkEseqh6TfJvc4FubI9gbclpY72+1JHBsTj7rstHCMPLiJiWwA=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr24796009oor.61.1622641081913; 
 Wed, 02 Jun 2021 06:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <30855000.34f9.179ccbc8079.Coremail.chenlei18s@ict.ac.cn>
In-Reply-To: <30855000.34f9.179ccbc8079.Coremail.chenlei18s@ict.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jun 2021 09:37:51 -0400
Message-ID: <CADnq5_Mg+kVrXNLsNW8ZYS9JMmch4Jg5iAzOdCqyPru8UpmctA@mail.gmail.com>
Subject: Re: [BUG] Data race when use PACKET3_DMA_DATA?
To: Chen Lei <chenlei18s@ict.ac.cn>
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

On Wed, Jun 2, 2021 at 8:44 AM Chen Lei <chenlei18s@ict.ac.cn> wrote:
>
> Hi, I noticed that there are two ways to do DMA for amd gpu: the SDMA copy packet and the PM4 dma packet.
>
> I had tested the PM4 dma packet:  PACKET3_DMA_DATA. In most of time, it works.
>
> But when I launch an OpenCL kernel followed by a host-to-gpu DMA packet, it seems that the OpenCL kernel read the new value written by the following DMA packet.
>
> Both the OpenCL kernel and the PM4 dma packet are submitted using the amdgpu_cs_ioctl, and they are submitted to the same ring.
>
> I was not family with the hardware details. According to my understanding, because the ring is FIFO, there is no need for any explicit synchronization between the OpenCL kernel launch packet and the dma packet. So the result looked weird. And when I add the synchronization(i.e. amdgpu_cs_wait_ioctl) before the dma packet, everything is OK.
>
> Was it a hardware bug or did I miss something?
>

The CP DMA engine is separate from the various CP micro engines.  When
there is a DMA DATA packet, the DMA operation is offloaded to the CP
DMA engine and the CP engine that processed the packet continues on to
the next packet.  You need to use the ENGINE_SEL and CP_SYNC bits in
the DMA DATA packet to specify the behavior you want.  The ENGINE_SEL
bit selects which CP engine processes the packet (PFP or ME) and the
CP_SYNC bit stops further packet processing on the selected engine
until the DMA is complete.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
