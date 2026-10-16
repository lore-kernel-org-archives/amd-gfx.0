Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26108CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885BF10E30C;
	Fri, 16 Oct 2026 13:16:49 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4750F10E30C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:16:43 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-313bab9cfe7so832332eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 06:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792156602; cv=none;
 d=google.com; s=arc-20260327;
 b=dBVYb/Va+jZDrIVRnapE9vaE2mszwmDvuSCf524qScT0F+iUghFL6l/SM/x6bVCN6b
 hVECGuDVevQ1qOdKcNz8A+pd1RwGk+5Cz/4YpgGLgIsHzL+7wA7PaHrkl6Io1mL16K/S
 YfL6uCUieZXUuXYcvgyKX8NVNI3e1uQ6otM/Rm2lxpy16leobI19HA1FlLUOMHg1Y7pu
 zcEhPeCUv8RCDX/807GaWHvIgBepgxwEAu8YYy88g/09CyKVztieEGnkWfy0kTMJx/b+
 ulTwVRzKHdwO8vtdd/ROEYiUQ9+QJ0YaBR1bzLG00Lo9/g19bpNq6GQMb6dFh939UYnY
 U2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I1dAxWV/rPUEH3ZT8A5MLhwJi8P3FXUcxTuqcMt5Sxc=;
 fh=0Vt0Wgwy1hvT0mRTNF4+lgb4KneHPwx0pY3rdSBEyXw=;
 b=Zr/HS6m2z201IAgYm4nMferBX3MTaz6FdTnfA7z/3JUvO9NdllGRb7zWOyaZ3oXsKn
 L2Kr182MAgh6xf03sL4p3kydhotcIAXxoMgxeEdK9SiUx2kNygM7RQIZzjZbBn/J6auG
 4hzusjEhEBYgYlJktPezkWvLmUiTSlcGIQRgPKHmC+2VzuaucsGvoUrOs36Uc2qmPPQY
 JEoVHwZEy4KIYsW3NZWgIECZjcvbPgHCQQtW67emEEcOv9HXo/BdFxQ3/hlybJ6L4ohf
 0owP8T+RpAZ8+5LwGibc1F/CeMUIDPprzIozEKM73aAsoemhcabCaBhXjVnbUE6VkAWM
 qmeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792156602; x=1792761402; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I1dAxWV/rPUEH3ZT8A5MLhwJi8P3FXUcxTuqcMt5Sxc=;
 b=KbSGvAYhO8HmocOhEgkifyf6CdRan7V71WcfK9XJmZirTpDR7KF05uDlt2x2YuImgA
 yHmA5j/fojZ0ODFwwtywUmk35v4o3IrfdMW9qyic3Y86vHf2Ba82IdDXsyHH9HeiQ9yJ
 bQU1/Rj+5UnMnIOSgfm1ka27ydGHhSHPmHMRlzkxsMKApxkZtSFw9TB28sHccgxtaXie
 5C+YVhbYFASiPRjpxyyjee4CIRh44LzAPlnv/9igC3Es30/NfT2zK0L1hPa3YjXyz9Qc
 IfqXmJL77se7aF6O5K4AxD7+bAPlgjpsQHoq+3EeyupDOTSo+O/QqK7IPcKkpBX9smaG
 m5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792156602; x=1792761402;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I1dAxWV/rPUEH3ZT8A5MLhwJi8P3FXUcxTuqcMt5Sxc=;
 b=Ad+QCLcAabfU8XGcbd//KJmbwaOb+t0yWd30YUNaxPSQA3jVTdWqotWXFveRNfycRI
 9JAiw7UPH1vj1XpxAXMT+eGVBCs5uROhzCsfsi4ctlEVUq2xd9dCYRsizUsmATalCnHh
 pbC2I7KuG7/0XlOM3cWwFY6Qz6ByxdihyCOaK6MKHAqT6Led7bdv2D8n8pKizA2GL7L7
 IBdQqawqnGkMIAiL1pSrAAvGf85SB06vROmGqqwRBfSbsDPOVUy2hqphT8uJd+rSutX+
 OiKM+UxtVEjOx4rqjvyk7vKDzUFIrcopKSFW2Z8e9jREujp4JXeqMdKKXqcWtjF1G3FD
 nKNQ==
X-Gm-Message-State: AFq9FYIN4fQlxBkamEcNu6Se11LPDE4rbEgoSwktjYOcrFkbyOJ1H3Vp
 E+/Gk8/cCIgDp8aMSntvfo96GDHu4ZH9kZkfuM0RaBdarqAaID5zV1C2Fago2XNZ0fUmhm49yxo
 eRRvTQbIhDMUqHAg/R5hmOPqBWXeT8rMdduZy
X-Gm-Gg: AYBFou0hgZG311I0Aod59kvlplQdNSpK8SvO8fdYjK/8uEqJrjXsZK4k8BZF5DIDZjL
 Xh7eIZhpl/h2a5tCR8AMllNdd//ZF0l3q6/dG7H8oxBzgpCHftLsNVFO9dbW91y8ld3RGwDoxLs
 gybTpOY0GmHKrGcPZNNhjOQG1EsDXdLFDQjHSUuRuGc5ALyuzJLUA54dBIQs1bdVBo4d32BWMuN
 7oC7775f0oJWo9/0DvlDNQRKpJDq2Rw93m6rm/4wVajMjb5xcsm2Ak2GvH6wDvF7e9iJ00wazC7
 9dCRD7lWAMn0UCFZRMRhnXbkalUgq1DyfdA+eI0h5/xg8VsIGCmvCHkIlIjQTvkz7K3ixjBJLUs
 CkcV7yVonIPyaFIssM+FdzDtXJWkhUYjGs1dzm8LpAA==
X-Received: by 2002:a05:7022:170a:b0:143:8212:a43 with SMTP id
 a92af1059eb24-16a5b97d796mr42673872c88.1.1792156602310; Fri, 16 Oct 2026
 06:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <CADTJRYdDAY0aYDeUCGWb2BuhKSGU2EzLoUwQHkv2SEqU53fjLA@mail.gmail.com>
In-Reply-To: <CADTJRYdDAY0aYDeUCGWb2BuhKSGU2EzLoUwQHkv2SEqU53fjLA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 09:16:30 -0400
X-Gm-Features: AclHuK-s5iGCF81qwtpCMoMivIyATWWZ-b2NzwKYN_NZKMCSTAmbit263bpmmTU
Message-ID: <CADnq5_NEaLL3b4JRO=sC3PZzJ3=8f65nAsX6sutzb0g2ozsHFA@mail.gmail.com>
Subject: Re: TUNNEL_DISPATCH on gfx12
To: =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 16, 2026 at 9:01=E2=80=AFAM Jakub Oko=C5=84ski <jakub@okonski.o=
rg> wrote:
>
> Hi,
>
> Kernel commit 9196339 enabled tunneling for gfx10,11, but this was never =
done for gfx12.
> Is that intentional? It seems like gfx12 code was copied from an older ve=
rsion of gfx11 and this
> hardcoded zero value was never revisited since.

Probably just a race condition when gfx12 was in development.  Just
sent patches to fix this up.  Thanks!

Alex
