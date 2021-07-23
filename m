Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70541C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 20:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0F960F46
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 20:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A0F960F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92366E03E;
	Fri, 23 Jul 2021 20:00:03 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B45A6E03E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 20:00:02 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id 21so3047103oin.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:references:cc:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CDh2dbx7HVAmZLLsCbef/IoqPXjueqhwyElByjYWciE=;
 b=ViNBAEzh3FnfAo54c06WbVAQahrZUP67Vi4tEqWzgjU1y4MPr0gq60YicARw5SepJE
 aJnBTnRrMjr5ZqT2bu5KPupYmdIoKjvt0LAch3+OhejzCOLySrL6bh9O/EX8zonCHyQr
 OQZgW/QQ3WA40V3gNnv1ouss6kIB1YJF7UvV1j/4uHpNZC4tR3A8q479h5m/7SKpjs6L
 simSF87RfP/PFiJP5LP0nbdGfG09jekyUwL44CcNEzVaW5NdV5ZPO6wM+UdgCYmA/jKr
 fMJhQayivbsvpiyyi32JFlYIcYPbNEy2bBzHhfj1uPjeRYepmfKcmIvBvlsIo/E9RfbW
 +Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:references:cc:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CDh2dbx7HVAmZLLsCbef/IoqPXjueqhwyElByjYWciE=;
 b=TrlwXWkrJWrxD8RKbJXm/kYY/KVsW1qJYYnQhpI+xGE/Qm998qAVsTQKy6E2HNxSN8
 lMDyuGUSRv2mlpoRigdKG1LW4rD9GTVTL/Qv4yTXPdVk+DzvRVlDIHAgs8rpc7yADI5O
 R/6Pld+lTuKOawATi/CBTPCsFcoNfI8JPjXZpBY8tdyDyPLSPLabTSlSlRDZenRQo94u
 alc8C1zl5kiM8Xf60tYWCCRIAD4ucrNNV+yo7ENv8o0lMpGwgDNvqoGEgZZngh77XL5r
 ikon+4T5RicvhP7NyPh2H7sOEIkB94kyeJFdCVRjV36GTuUCnMtv+w6n5vawdkBrksMg
 G8GQ==
X-Gm-Message-State: AOAM530WNaNAFCc3KWwuka89lH480qJFxUkPCyHJUfXbrb2eoufjgDZE
 mnVHbm+ci+z9KhsTI+wj8ZBBwJzEnvrRQsOo
X-Google-Smtp-Source: ABdhPJw0ihs+qYSvdAodl/D+4SXXFLoq0wibdpKdb/rlFwC6kMAXsrdbDUR3V+mLjtPDGhqyy3waUA==
X-Received: by 2002:aca:3094:: with SMTP id w142mr2902903oiw.37.1627070401156; 
 Fri, 23 Jul 2021 13:00:01 -0700 (PDT)
Received: from ?IPv6:2602:47:d3e4:7800:aa5e:45ff:fed0:7395?
 ([2602:47:d3e4:7800:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id 81sm5904512otv.10.2021.07.23.12.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jul 2021 13:00:00 -0700 (PDT)
To: Evan Quan <evan.quan@amd.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
From: Matt Coffin <mcoffin13@gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Message-ID: <9e502775-bf10-6b0d-116d-1159d674e11b@gmail.com>
Date: Fri, 23 Jul 2021 13:59:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722032046.767094-1-evan.quan@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/21/21 9:20 PM, Evan Quan wrote:
> The customized OD settings can be divided into two parts: those
> committed ones and non-committed ones.
>    - For those changes which had been fed to SMU before S3/S4/Runpm
>      suspend kicked, they are committed changes. They should be properly
>      restored and fed to SMU on S3/S4/Runpm resume.
>    - For those non-committed changes, they are restored only without feeding
>      to SMU.
> 
> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---

It's been a while since I've been through the SMU code so I don't know 
all the places that restore_uesr_profile is used, but, just to confirm, 
these would still go back to default (boot) values on a GPU reset, yes?

I ask because when pushing OD settings too far, GPU resets are often 
encountered, and you might be able to create a state where it would 
continually reset if your OD settings are remembered even through a full 
reset.

Very nice feature other than that, though, as I actually keep 
`radeontop` open in a tmux session to prevent my secondary card from 
resetting my OD settings, so this will be nice.

Thanks for listening, and for the driver in general,
Matt
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
