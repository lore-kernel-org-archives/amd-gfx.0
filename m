Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745B7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 15:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423CF61246
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 15:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 423CF61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017CA89F73;
	Fri, 19 Nov 2021 15:48:01 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5005D88861
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 15:47:57 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 h19-20020a9d3e53000000b0056547b797b2so17410586otg.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NWY6W2JCTNpOQUKIOl+FskPGC8kOzP3BdQ6FYn/A7Hw=;
 b=kYXrwpz63MK2CnH82uwWreolsgbePj98e/Gz9xV+aYnXtnnKQlziPda982pNa2dGdF
 LtkkQkMRcuAvT+ulNSGA0nx1RqwKfvlDnZQL4qb3AzMuJAEtCKIu2W73fHFzgHsVIPvH
 v49yvhd3mW+4jYikg5Ulm0cvj+vcXXP4QUVlQJZMrkqxYcSUQDe7ExLOUywjxG4A6HkA
 bCd90vR4+wgAfWXuCRzzoEGT/izS+H7epRj0L07qX823j8xt5gSalGEbHutat4bTe3bS
 5sLZeKPwQeVgIE1zA0dhKTcKasG28Wg0G0Fv2AeRfAuvYkHxiBj6InQCxgn3Gr88euee
 bCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NWY6W2JCTNpOQUKIOl+FskPGC8kOzP3BdQ6FYn/A7Hw=;
 b=yKTY0PNr4WwA4PR3YgfUTTumZsTfxT/mTpjqcHquubjzbcuGTYso9/TtocyxH+oqKX
 tvuWiexcaIiEJ+TF6QdiKRe0ZBZQ5Ia2KzvF9CdIIUuP1FrnFapaVMib7VQvXR2M2bPQ
 gQVJKmt/WFZcGuQHMdBbtQ6OzMUmzR2hL0opJRHnnOJ6wmip33G7MQes78+1yn9a5c7F
 hv8TSIxdM9e7zNC84K6tvjYUuNorgfo0oIBUw3gtlfcaRfIBx8kHIqYRDmG7YjwP9MNh
 Us2MrWKIbQQkSJ8Div4xO9AOP3Of0yZjNpe2Ru2NKG8zlZ6bW/1Spt2Lea6OkRlCzwgv
 JMKA==
X-Gm-Message-State: AOAM530ngDauGgFSvBeyA7s8p9s9jLdTVPmU3IMZikhQoNXHEvhzlRQ3
 74w+65zn8sFCExGk1YsMlWhHR9YuQ4W0DTT1H6o=
X-Google-Smtp-Source: ABdhPJz7l/MTbPqsb1S9dV50wMhw2J15leW9M1TnqukNsNXUo0yQ0JMrr/qWsAD6M7bHA0qy01W3dlVdUW6z7VtOIuk=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr5665761ota.200.1637336876366; 
 Fri, 19 Nov 2021 07:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
 <4ccd33e5-5b98-2798-0f74-7bdc8432fa16@amd.com>
In-Reply-To: <4ccd33e5-5b98-2798-0f74-7bdc8432fa16@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Nov 2021 10:47:45 -0500
Message-ID: <CADnq5_MgyMj1qhukghs4KSEpnv_zS9FJSQf9yvgvmSq5QAZEcQ@mail.gmail.com>
Subject: Re: [RFC 0/3] Add Smart Trace Buffers support
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Tuikov,
 Luben" <luben.tuikov@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Nov 19, 2021 at 10:39 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Ping - mostly just to get final ack to push it into amd-stagin-drm-next
>
> Andrey
>
> On 2021-11-18 1:18 p.m., Andrey Grodzovsky wrote:
> > The Smart Trace Buffer (STB), is a cyclic data buffer used to
> > log information about system execution for characterization and debug
> > purposes. If at any point should a system encounter a functional
> > failure the trace can be collected without need for reproducing
> > the failure while running additional instrumentation.
> >
> > Andrey Grodzovsky (3):
> >    drm/amd/pm: Add STB accessors interface
> >    drm/amd/pm: Add STB support in sienna_cichlid
> >    drm/amd/pm: Add debugfs info for STB
> >
> >   .../amd/include/asic_reg/mp/mp_11_0_offset.h  |   7 ++
> >   .../amd/include/asic_reg/mp/mp_11_0_sh_mask.h |  12 ++
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   2 +
> >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  16 +++
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 104 ++++++++++++++++++
> >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  55 +++++++++
> >   6 files changed, 196 insertions(+)
> >
