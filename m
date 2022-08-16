Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638ACC32772
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 09:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CED4CBA7E;
	Tue, 16 Aug 2022 09:01:49 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DE9CB1CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 09:01:38 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id j26so2690104wms.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=4dKgTPXffWGyBfUjtKTJqjgaRaAwQG0cGgJb7UNpJ1o=;
 b=jOoljtsbO5GX8UvVzMJeexhLo/AAAmn4vTsRpRBFy/5BJKe7bSCSyFiVnpgkAooJij
 hr0YW/hyoiRqY/BVLAaEOiu+FUg5S2Se703w2t/K5fu9AMMDv8GZYTSVeMI2uqh0MOHU
 7cxla6lnd4JnVfp7MN45gBVNliIaMdjmTt9KrNcRvUUNZ/fQlGGb1cl23kCyi2vCVNsL
 CD6uwbuKxjXLe3RPSnJKgDpBwenCIcaGR+AAOx7yCwQpa1TAbrCpYGzLP/RSaM0StipC
 MICZrxGVme6ZMfqdlZTyq1yekFbxZIxLwseeTbibzg2JmJ3xK74vhom+SA8ZMqnED2US
 ByWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=4dKgTPXffWGyBfUjtKTJqjgaRaAwQG0cGgJb7UNpJ1o=;
 b=nwOpY5bVZA3qdLOJOWKLdJXov3dz4LfTsw0Ci6pR6WHyPuYD/ecxo4VYizosxkC9tA
 JJkW4zH9q5LnhD4NabfVcMCt9YXi7DYrE9tBVQJqErDxyj8hm3z2FV4jOmm5PCEqZuKz
 rSbXd3vKnelmZGRTkq2q9jKO6UzrkC1u6CFpzFh8jHg/tmeWkb3LKvfWzLIlnjIQFRNa
 x7fWVX5cawn1hoUe4P6i7Lx5HFiAiuJuQsUziGbcnvofi6RyJx9xNBK7Fd86ua1XF0MI
 Hz2MML+YFCpwnD+jOdSrFVbQvzj+G1u8U5zZK81QfJwWuvdjFHK7ADXej57XXR+AUQE2
 NLrQ==
X-Gm-Message-State: ACgBeo3E+qkDUwXi7LmF+ET/hR7B4Autow/zd08sKPcRpsnhdE9wnNpw
 4P5wq26ODvafP/Nb5CVFarc=
X-Google-Smtp-Source: AA6agR72GBhxohOHkDvyMo9PtVjyH5PJVhpeQTH91x8JqMjY3OqMcy5uBpvCIph68pHHeYNf8rX2ew==
X-Received: by 2002:a7b:cb0a:0:b0:3a4:eafc:367d with SMTP id
 u10-20020a7bcb0a000000b003a4eafc367dmr12859010wmj.0.1660640497085; 
 Tue, 16 Aug 2022 02:01:37 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 q13-20020a056000136d00b00224f5bfa890sm8608361wrz.97.2022.08.16.02.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Aug 2022 02:01:36 -0700 (PDT)
Message-ID: <386722eb-2560-2542-92cd-4a2fc46aeacf@gmail.com>
Date: Tue, 16 Aug 2022 11:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Radeon HD 2600 XT, DVI outputs
Content-Language: en-US
To: Andriy Gapon <avg@FreeBSD.org>, amd-gfx@lists.freedesktop.org
References: <1e0f769e-008b-09b3-efaf-4a285323dc0d@FreeBSD.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <1e0f769e-008b-09b3-efaf-4a285323dc0d@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Andriy,

well first of all can you please test that with Linux? If this works on 
Linux then there is probably just something missing on the FreeBSD port.

Regards,
Christian.

Am 16.08.22 um 10:48 schrieb Andriy Gapon:
>
> Out of necessity I had to use an ancient Radeon HD 2600 XT card.
> It has two DVI outputs (and one S-video).
>
> I noticed a curious problem, if I attach a monitor to either of the 
> DVI outputs, then initially there is video output but as soon as 
> radeonkms driver attaches the monitor goes blank.
> But if I attach the same monitor to either of the outputs using its VGA
> input and DVI->VGA converter, then the video works fine all the time.
>
> I tested the monitor's DVI input with a different machine and there it 
> works just fine (and, as I said, it also works fine before radeonkms 
> is loaded).
>
> Here is a piece of output from the driver with the direct DVI attachment:
> [drm] Radeon Display Connectors
> [drm] Connector 0:
> [drm]   DVI-I-1
> [drm]   HPD1
> [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
> [drm]   Encoders:
> [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
> [drm]     CRT2: INTERNAL_KLDSCP_DAC2
> [drm] Connector 1:
> [drm]   DIN-1
> [drm]   Encoders:
> [drm]     TV1: INTERNAL_KLDSCP_DAC2
> [drm] Connector 2:
> [drm]   DVI-I-2
> [drm]   HPD2
> [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> [drm]   Encoders:
> [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [drm]     DFP2: INTERNAL_LVTM1
> drmn0: [drm] Cannot find any crtc or sizes
>
> The same scenario with additional diagnostics: 
> https://people.freebsd.org/~avg/radeon-2600-dvi-dvi.txt
>
>
> And here is with the DVI->VGA configuration:
> [drm] Radeon Display Connectors
> [drm] Connector 0:
> [drm]   DVI-I-1
> [drm]   HPD1
> [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
> [drm]   Encoders:
> [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
> [drm]     CRT2: INTERNAL_KLDSCP_DAC2
> [drm] Connector 1:
> [drm]   DIN-1
> [drm]   Encoders:
> [drm]     TV1: INTERNAL_KLDSCP_DAC2
> [drm] Connector 2:
> [drm]   DVI-I-2
> [drm]   HPD2
> [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> [drm]   Encoders:
> [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [drm]     DFP2: INTERNAL_LVTM1
> [drm] fb mappable at 0xE0243000
> [drm] vram apper at 0xE0000000
> [drm] size 3145728
> [drm] fb depth is 24
> [drm]    pitch is 4096
>
> The same scenario with additional diagnostics: 
> https://people.freebsd.org/~avg/radeon-2600-dvi-vga.txt
>
>
> Not sure if this is something with the hardware...
>
> Thanks!

