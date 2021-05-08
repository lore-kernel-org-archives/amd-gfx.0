Return-Path: <SRS0=tImT=KE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC32C43461
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4024A60FE9
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4024A60FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4ED6E20C;
	Sun,  9 May 2021 15:42:13 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8860C6E851
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 04:28:25 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 fa21-20020a17090af0d5b0290157eb6b590fso6681475pjb.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 May 2021 21:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lT+Hlg4ADm1P1P0CFbZk9N2b8mFk7+dIjhu7jpeItgI=;
 b=WwVcj3+2b/E7VuO1+uvwPwiwtxD4mwvEuIz7iicDA4tHqvrpFrjMOBxfPnXT/OF3WR
 oydpGT3MZyypF0tvhycks6EWNYPswhm1XEEYjeZXBjAHJS7lS6//+2WOA3EeYKQS6K4I
 nYMSIKvrazqW8Bfqgej/ktWUdKIB00JSa6Pwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lT+Hlg4ADm1P1P0CFbZk9N2b8mFk7+dIjhu7jpeItgI=;
 b=QZVz6QDBGCalAGx2ypgcX8FD8ZFucDV+5s9IQABQ7ye20XUtGmyU6JSA2aG08yuOwB
 2dczMD8tE0UdE4StFCujyjjqeBp+wMKjt1BXByc10+4uc6Psch+8Nl1jZsKbPldCCTeF
 jGQQCGEl7cUnF9LDSeVAa0hrYyP/+kqag0MXn4o0brpUSZA4EE3YHdaeuOyvyYdzNLDw
 N0im+9idGClGOLn0ijz16vArOS9nuG6COuMtxvNHIgtM8AIKPRFHzk8DsbzTUqH75LMu
 0lBePDM1R37Pw9bXBOYofcIRLtIUpbQmC6j9cY2vePa45kUqQF4psxUW/L94gOJnj58h
 npMQ==
X-Gm-Message-State: AOAM5333ueFsznusgc0Vvp3U2XfyMzR/wKhi/EkeY3f7IILMgQO/Cue/
 UECc2lBZr9NGsnzQcFXDotD+kg==
X-Google-Smtp-Source: ABdhPJxyQVL83KGaDZqCisHbJ1gqhZrZZS3+s8RCn5yUCegW5vh9XJTqAJ98B2I27DWQzDHljRYvtw==
X-Received: by 2002:a17:90a:730c:: with SMTP id
 m12mr26973561pjk.111.1620448105199; 
 Fri, 07 May 2021 21:28:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id d188sm5851024pfd.203.2021.05.07.21.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 21:28:24 -0700 (PDT)
Date: Fri, 7 May 2021 21:28:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Jiawei Gu <Jiawei.Gu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Message-ID: <202105072117.1480D10A@keescook>
References: <20210422023448.24689-1-Jiawei.Gu@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210422023448.24689-1-Jiawei.Gu@amd.com>
X-Mailman-Approved-At: Sun, 09 May 2021 15:42:11 +0000
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 linux-next@vger.kernel.org, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi!

This patch needs some fixing.

On Thu, Apr 22, 2021 at 10:34:48AM +0800, Jiawei Gu wrote:
> +		case AMDGPU_INFO_VBIOS_INFO: {
> +			struct drm_amdgpu_info_vbios vbios_info = {};
> +			struct atom_context *atom_context;
> +
> +			atom_context = adev->mode_info.atom_context;
> +			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
> +			vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
> +			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
> +			vbios_info.version = atom_context->version;
> +			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
> +			memcpy(vbios_info.serial, adev->serial, sizeof(adev->serial));

This writes beyond the end of vbios_info.serial.

> +			vbios_info.dev_id = adev->pdev->device;
> +			vbios_info.rev_id = adev->pdev->revision;
> +			vbios_info.sub_dev_id = atom_context->sub_dev_id;
> +			vbios_info.sub_ved_id = atom_context->sub_ved_id;

Though it gets "repaired" by these writes.

> +
> +			return copy_to_user(out, &vbios_info,
> +						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
> +		}

sizeof(adev->serial) != sizeof(vbios_info.serial)

adev is struct amdgpu_device:

struct amdgpu_device {
...
        char                            serial[20];


> +struct drm_amdgpu_info_vbios {
> [...]
> +	__u8 serial[16];
> +	__u32 dev_id;
> +	__u32 rev_id;
> +	__u32 sub_dev_id;
> +	__u32 sub_ved_id;
> +};

Is there a truncation issue (20 vs 16) and is this intended to be a
NUL-terminated string?

-- 
Kees Cook
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
