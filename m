Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981CB23435
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981CB23435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E196A6E7D3;
	Fri,  8 Jan 2021 08:11:22 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D4B6E7D3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:11:21 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id w5so8049031wrm.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 00:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rRG6a4AIT44rxqdduD/czYsc+caHHBs2lWy2O7YahqI=;
 b=owl9qqo9rA20y0aKWX3gbjWX+VzqRNDKDwtUwuBIaWQwbqOmorlrbooAqyDDn2gctm
 D5wWbjvy/U7n/puBJrLkNlOK9eDHZaO/b7Zz4sIEY/IKNt3nK0+B+mKM1Jyp4Bwj0m1H
 6ZkJlLhHSziFTqxkYBV66T+ob5tqSIQCQqDvp0CrfCpMyioo+YuvgVZvCq+ax3tkDL3z
 NHucM/emGxdIgK75tqzr7DEbTYUyAUR9VW70lCQhh01CUMwR8SqQe/Hyvk99EGti51dK
 lYm4Uu0iNo8I32C+aAxKUs66pCJQjgbR7uS6ptx0pvBKPUdek2O05rio/CzyG7D+jthV
 OE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=rRG6a4AIT44rxqdduD/czYsc+caHHBs2lWy2O7YahqI=;
 b=SCzrwPP0U43WeSIoUwC+8Z/vKhJn35GyjAnoFsI8zXGKSHkiUr6oKwqy03ELQQlRrc
 cSYdVNx3fgVi5Q2XPfsvRJJj50CD20GIHFB3TdjV4PQq+ik+O41LWEKK1lDULl28JXCL
 DoBj67MfsQ6n3g5YKSHwfal7Ku0u5xqTPMUjw4HSSOcGDiFYz22wnoJf52MqgqeJiSL4
 vxTNIg8Uy9vfuE7BRQJlGBQ/6WyPvR5XLST/9BjFzwWVsT1lsuEkOkNipXd6lDpRDQQ0
 7P0zFCC2I5vg7SDAj0Z9GpJrNuFYjThpf9McMEWYff6ibY+PNROewRqbA59rlnCSvmWQ
 QbhA==
X-Gm-Message-State: AOAM531WPqnxmIPK8aoH2OK/cDzSmDhnEM12dWEcwQq64qWB1UBJjw/R
 c7s9QbHeI7KZr9R8MXhYtVY=
X-Google-Smtp-Source: ABdhPJyCww1vtas1oljupQVD1ODINj2sfpIbH1g6vwPY1j4vrt76uSnpgAvRFoD2B9rKNogXfF6feA==
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr2358907wrg.365.1610093480427; 
 Fri, 08 Jan 2021 00:11:20 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a62sm11203585wmf.7.2021.01.08.00.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jan 2021 00:11:19 -0800 (PST)
Subject: Re: AMDGPU VCE 1: some info needed
To: Alexandre Demers <alexandre.f.demers@gmail.com>,
 Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
References: <CAPEhTTFa_c3L8gpxT3=HOrQi9mQxhH2GaGo9_mfdc8gKpV2MXA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d06c8a25-d9db-3a96-064f-964382de73a6@gmail.com>
Date: Fri, 8 Jan 2021 09:11:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPEhTTFa_c3L8gpxT3=HOrQi9mQxhH2GaGo9_mfdc8gKpV2MXA@mail.gmail.com>
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
Reply-To: christian.koenig@amd.com
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alexandre,

Am 08.01.21 um 05:20 schrieb Alexandre Demers:
> Hi there,
>
> Some of you may remember I was working on porting VCE 1 from Radeon to
> AMDGPU a few years ago... about 3 and a half years. I hadn't had time
> to work on it until last Holidays. But why do I persist in this work?
> Because GCN 1st gen was still used in some GPU produced 4 years ago
> (Radeon 520 and just before R5 and R7 in the entry level).

Yes and that is really valued.

If we can get that working and and it is feature equivalent to radeon 
I'm perfectly fine to merge this.

> I'm pretty happy with where the code is sitting now, however I have
> some questions.
>
> 1- should the firmware be validated like it was under Radeon and as it
> is done for the newly ported UVD 3.1 code? This would mean having to
> work with keyselect, isn't it?

No, that should only be necessary for UVD.

> 2- last time I worked on VCE 1.0, Christian was saying that it was
> possible a new VCE firmware could be provided for AMDGPU. Then, it
> wasn't that clear, GCN 1.0 (SI) being in trouble and it was considered
> to strip it from AMDGPU. And a few months ago, UVD and DC were added
> for SI to AMDGPU and a new UVD firmware was released (yeah!). So, is
> it possible to have a new VCE firmware? I produced an "updated" tahiti
> VCE file where a header is added (script available on my account on
> GitHub). Still, if this can be useful, I'd prefer an official
> firmware.

Leo and I can push once more on this, but no guarantee that this will 
ever see the day of light.

It was a really long and taxing process of getting UVD for SI out of the 
door.

> 3- is there any documentation about VCE 1.0 that would help me
> complete this work?

Unfortunately not, we only have what was exposed with the initial code drop.

> 3.1- Some variables that were previously defined are not available
> under sid.c, vce_v1_0_d.h, vce_v1_0_sh_mask.h and others. Since the
> new values (mostly in the range of 0x8xxx) are completely different
> from the ones defined under Radeon (in the range of 0x2xxxx), I'd like
> to be sure to use the good ones. I would assume the masks and shifts
> are still valid though.

Do you have an example of what you need?

> 3.2- Some statuses are undefined, sometimes magic values appear here
> and there without being ever defined or documented (status 0x337f
> anyone?), even under CIK or they don't seem to be easily portable from
> other VCE versions. Having a name for a value is really helpful
> without an official documentation, when the code is supposed to be
> self-documented. I've been able to identify some of them by looking at
> variables used under Radeon or under AMDGPU's UVD 3.1. Interestingly,
> some variables were previously defined under Radeon, but were left
> aside in AMDGPU...
>
> 3.3- Being able to know how to properly set/reset which part, in what
> order, etc.

Sorry, I don't think we can help with documentation here. What I can do 
is to test your stuff on SI hardware if you get stuck with something and 
report back what might be the issue.

> 4- Any input about 40 bit address limitation on VCE 1.0 and how to
> handle it if it applies?

You mean the 24 bit address limitation of UVD, don't you? That should 
not apply to VCE in general.

> 5- Any chance to have some code reviewed even if it still doesn't work
> if I send it on this list?

Let's try to get it working first.

> 6- I have some patches on the side to help document the code and
> define variables (even for Radeon), a few typos fixed, etc. Should I
> send them on this list?

For radeon we are more or less in a maintenance mode. If it just adds 
comments then we can certainly add it, but if you have any functional 
change I would be a bit hesitated.

Regards,
Christian.

>
> Cheers
>
> Alexandre Demers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
