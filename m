Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC2C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E81021744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYRjbqed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E81021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB12B6EB1B;
	Tue, 25 Feb 2020 15:07:58 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698A76EB13
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 15:07:57 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q9so3355285wmj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=fsQ5dwqo99EEbk9chVa3t12IZwB6AgBewspmrPWOgmM=;
 b=bYRjbqedvZ7HoKOfhkDvmgCCyqYdYAfJJW5xmkEiBDxo/ylQOxop+3VFE7WGF0Qsbg
 xxvMiXVXiyqQFb2fJe7874X+tjWcFj7MGiKueArG8nhhicxpDBSOdxSwWbPNDIh/fkhd
 bo2M6odl/JpB7xF8rkHTpNt5x8t5JuwW9XAMwstJuU6ZXoOsWfMf4xcI0+zTcNmsXzar
 zMV8WWxNTyyj+5EaWFMbl6lbuQKq/9I5TMimGXaOxc16609yUdxL0/PHk0qOhN7q6dlG
 w12HruVZcq32odiHBbDhca5gAPzW6Phy9jRn/8GPDAxikfpOznLYvnujJDgxlnI8Fcta
 lzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=fsQ5dwqo99EEbk9chVa3t12IZwB6AgBewspmrPWOgmM=;
 b=MbeJfMpRQY+TioavkOlKDlUSg1c1+SZf9iOV6oR+eO8Nzn9BrtXRz07yg1qcQseURg
 SwF4pFtLBjdcR3LYVkBvNLWnwWo/nNg3MPcWcMYuE5FQYt0QGtdaef81OhWrMpcihylq
 YfuKxL8yXvJWaB7Q3LRballTyzfKvE1pe6pl/weW+vAYbcLPrE8riOid7OuPMFm38bot
 BmoeDW2i8Rp+frUtUu/jmjxLTcNx0H0uOsxRY5MH+xT6+yFUDXz9k8csiQPE6Vuqn/K8
 HA6MSYyBOpRBPeQQeW+Gr7xgIUsMvt3O8QKQ5mrDVTQwTuQFytLc65hQvLJgu2Tk+41F
 qJ/g==
X-Gm-Message-State: APjAAAUteqhVHLswWoWu2AToolu8FD1Sg11z9JI+mkd0uueP48Detb4p
 /sOttJm6JFQnDgIP4hiT+NZ/qi9/OwX8ytfE6i2tvA==
X-Google-Smtp-Source: APXvYqyTy+gR1ma4hceFCfnxG/nOgFlP+hI0QRXVYe/TZm4Rn698Dk04cgm2u/PFqmF8vIE5XxFvd01+b11vN/pAvCk=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr5787714wmc.39.1582643275878; 
 Tue, 25 Feb 2020 07:07:55 -0800 (PST)
MIME-Version: 1.0
References: <584AF8CA80%devspam@moreofthesa.me.uk>
In-Reply-To: <584AF8CA80%devspam@moreofthesa.me.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2020 10:07:44 -0500
Message-ID: <CADnq5_Ocmq8v0SGV+8S55XOZUqUi4EpqzUsN+t2Cva+di0sPqQ@mail.gmail.com>
Subject: Re: [PATCH] radeon, amdgpu: allow for symbolic errno output when
 reporting drm_edid_to_sad errors
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Darren Salt <devspam@moreofthesa.me.uk>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please send a proper patch using git format-patch.

Thanks!

Alex

On Thu, Feb 20, 2020 at 9:04 PM Darren Salt <devspam@moreofthesa.me.uk> wrote:
>
> This fixes some kernel log text when CONFIG_SYMBOLIC_ERRNAMES=Y.
>
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
