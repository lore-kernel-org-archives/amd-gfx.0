Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37ABEA795E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 09:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC4610E6AB;
	Fri,  6 Feb 2026 09:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="ZrKy/Eck";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6086B10E028
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 09:58:50 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4362cdf1d5aso273710f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770371929; x=1770976729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YtlKAacdj6VcSmvmFka6uFTtg4j2LxBgXZgRH4Au+E8=;
 b=ZrKy/EckNAYXq7+jTLdRMc/A/M+50Y5uIiFcTCey/O4UrB5yaZKT+Fn62j7MNg1dmm
 K3hxbELukMbXH+nLXZ7q96MkHMeGpCwlhwl8QV6+rVzFqIe/FASZTRf4zCR7Ke/4Mhxt
 p1rDzYsjePsGuS16kLclflUcXI8rQrxqNr+o5CJDmGduaW6aVnNxUW4lovZ+0FnEYwD2
 sswh9gpXs0HLMEY+c//uhorfhIaWoPpn1BKCIz8JicrnM73g/rWglv9w1AOrXrLZstSs
 fyNjY3zS5ku9FpsmQk1f4p5GlbvqZBTMtSGq8db9qWLwOoMDeLu+V1PM3sqBNsCn3Mxg
 iZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770371929; x=1770976729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YtlKAacdj6VcSmvmFka6uFTtg4j2LxBgXZgRH4Au+E8=;
 b=nH/kEaNu83ALAHdLqv6o4fihcH9PZXvqriZ8mlyVSXVauiDhLnqsDt51m9eGlNkhSa
 sTDAxYFm5AUl/J8Aj63ogoCBaoSNA3Wue02SvQixump1QzUmkqPTe+hZUrIPeUBYXljR
 3OQ4gIdTVWDMqYoStFxmkPAmRTh13lftVhxZ3/7wM/mzuK6POmrVlkdFiag387ePDah0
 UlHSbbHPAQtmBMLqOymxULL6cCSUEHCF7p5YMCRgELa4ZAkY9nZEtCq9BzPbUfaJDW6E
 1wP0CcAY744nEDRLzke21woCjrUDLPg9UCCkoYAFr+L9c1aHoP9KL0Azo4MnrQhb3Tx7
 AD8A==
X-Gm-Message-State: AOJu0Yy78lqBjC+vPcVHegaW1VWS0wmH8ILaCrKgQWGoM91UTz/O/tyJ
 e6JyVJ9jtRoMiEDuoKoBIirt9IG472vlOQIH2c/sHlCwcWTe0da/lCyPMogHODOUr08=
X-Gm-Gg: AZuq6aLx4AhQfVq5r1jlub06A7ESCSlMlPjrHSNrXrk0EhJewpTPumQAnhoCxN84cfd
 6BGHHlwckEM8A+oRKYM52y9simcnJTpdk56iAwrlkgsIwuz1xGYNdqxGdd5voYZJ0u6fjdaEudB
 Nh1sJutoa+WZi9a4qATcdn/NApK3VhZQNcV1tlF3witoDGmD1+tNvg4w4E4dQiO3MSBmikDl5fn
 XEpjr1psAjkf/JV6Te5cDX8pmq4JZd5tn4CUENvC6OBDqzqA+hlxH7kNrETNUrv54bdPbHVcpTe
 f+6l+NqH2+75UQ2c2Gr7/nbiMgbBTEozN5H+OX+mE11hxZEWNVSwEjU9iJkMhcFDUeU8U5Rd1+u
 p3K/6yu1rObR1B6uLMnLhCTDS3pD/lDVDqnCVZK0Q2bNEYWbT3zZCUfy5GHiXkgiVPvgh04nkOh
 GqUqcZO0mjsA/Bl2oUMocs65/YfQOuw2Qs
X-Received: by 2002:a05:6000:2f83:b0:435:a815:dd81 with SMTP id
 ffacd0b85a97d-4362933be7fmr3262071f8f.11.1770371928385; 
 Fri, 06 Feb 2026 01:58:48 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bdc11sm4532703f8f.14.2026.02.06.01.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 01:58:47 -0800 (PST)
Message-ID: <a56b7e43-f499-4b52-bee1-15f7087057e0@ursulin.net>
Date: Fri, 6 Feb 2026 09:58:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Accelerator/GPU top
To: Alex Deucher <alexdeucher@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David Francis <David.Francis@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <CADnq5_MTX8CifP25UvE5kdMbCYxgK+A+KGdd-_Ef1m4VYv+WRQ@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CADnq5_MTX8CifP25UvE5kdMbCYxgK+A+KGdd-_Ef1m4VYv+WRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 05/02/2026 18:58, Alex Deucher wrote:
> Has anyone given any thought on how to support something like top for
> accelerators or GPUs?  We have fdinfo, but using fdinfo requires extra
> privileges (CAP_SYS_PTRACE) and there is not a particularly efficient
> way to even discover what processes are using the GPU.  There is the
> clients list in debugfs, but that is also admin only.  Tools like ps
> and top use /proc/<pid>/stat and statm.  Do you think there would be
> an appetite for something like /proc/<pid>/drm/stat, statm, etc.?
> This would duplicate much of what is in fdinfo, but would be available
> to regular users.

In short yes, the inefficiency of the client discovery bugged me since 
the start of fdinfo and it was discussed a few times how to improve it.

AFAIR in those discussions a lists of clients outside of debugfs was 
mentioned, since that would allow the cost of discovery to not scale by 
the number of irrelevant processes. Something in proc was also mentioned 
but I guess for both no one had a strong enough drive to actually do it.

Challenge will be finding the threads to see if there were any 
interesting conclusions... The only one I can remember at the moment was 
this:

https://lore.kernel.org/dri-devel/20240403182951.724488-1-adrian.larumbe@collabora.com/

It looks this attempt died out due proposing a binary interface in sysfs.

In any case, I'd say it makes sense to do something.

Regards,

Tvrtko

P.S.
Just in a case you did not see it, a generic tool exists as gputop in 
IGT but as you say, you can only see data for processes the user running 
the tool can read fdinfo stats of. And there some nicer tools feeding of 
the same data.

