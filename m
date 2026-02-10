Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FE5EB2701
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 19:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06A210E079;
	Tue, 10 Feb 2026 19:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/8Auz55";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F7510E04E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 19:17:28 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1244bce2c17so407772c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 11:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770751048; cv=none;
 d=google.com; s=arc-20240605;
 b=e5iygVLYS5xO7meVAZARfG4yz2pEr6iKITkVee+UFHOTpPfm2dHX+fxJr1Lcb6kg+7
 aQUrKygedFPbrdOy3XRWQ7d7fC3SqcHV97448dbGgi6NWPWwYMY2R1G5PAilIkP7pJY4
 NV175rMv2bnh3IGEPSLT89rFcO+PCTe/doZROXyzrwpNaN4QqNlJND/Ht8P06LTR+YUv
 Fla+cvlm9gUVVVHQ+hgAV4H85/Qjzhj82Ee1uH9YrnGqseFrTP18bQ/aVZ6iwtVQIe0Q
 0bZ5tZkjFhUlNY7LyFnyjvmMUhg6jUZIN5iRTkkEWSyju/+PurV2kv6HHAZiFEzfA8G5
 vqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qkTmjGRqOjouXcxynJDTcMNXeIorXeHUOIvClnb8AXo=;
 fh=CP46xrtiIUQhW3ksM8BPYEOz0KEUGa+uFIdbNdG8mVU=;
 b=Y3vl+2HqJUeeUsfx9SJtcPHxmwxSMPHucbEmpnZNyUU0mUFi7c6pa9ZWGBhCAIeAyh
 Xxaz5BbT3ptT25y0f/vb7QQNx0YjgQKfMBaG8XYOlVtSCoqBremkIjOvyLhXbTFeoENu
 VjazsiwL9XZ+IiCYilWNSS1X+IwzEZkXn6Ev0fT8fzrItqCNLHWyTHO202eF/b2sGCu8
 M7ZgjPI5zhZhCS7DuoqJcDet5U7k+ndXAxpnnzJ6FWiVSoGZUPZdVcKfYdYi4MtbiLv8
 EfvA+QpmHm+ZbejW1rjb89aS25fNZI/L4hRaE8Dpx8u1BH2d7abCxFof02/R4pPI4mfZ
 9iMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770751048; x=1771355848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkTmjGRqOjouXcxynJDTcMNXeIorXeHUOIvClnb8AXo=;
 b=W/8Auz55yKCaoz4FOl5ook2fi+A52GXtt/gTaZh4hnOC349C4hEG9ybNBSYMOrkTpK
 cZS0xWx5L57dfOUDLFYm4eHb1W7AdooVPVpmsj18YTzaci5a+ocZ7rMfb83O77V6fWQT
 8F05YEARiLy3wCRZLqSzjhqFcmSWr28brYcHmm54Q5PIZEXtdugKoIMc2G/sQzeeEd0U
 UwcS8sGEXSdyjLl6HaCOCSJtpbB/rDQ5jbNrLG26lCeFN/NVxWLPGuiB3MZQ1dkRysh2
 EgnMPuBIQggpA16GirJ75UTCzIilbSYGBaLB6FVGyJnEhUJdWosVUYmPsoT0nUFJmDhT
 NTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770751048; x=1771355848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qkTmjGRqOjouXcxynJDTcMNXeIorXeHUOIvClnb8AXo=;
 b=Taf2nIT2b49W77bXZrI8UumsSvlL8Trcr+A7XFIfwzeoNBG7NccaGwXxkER/8e8yVb
 USK4BXFiPiPRjQFwjQd/McXyLkw2Hw4Hyc85KrROTpN8FWf0OxEjeIvNJf22NnL6Uko1
 qB+auBOrmvQ6hpjWxldfup3ekREWTDiYLWFHZt3WzyH486IErB/adwFXSCnLwRpMK1Ta
 VwEZVYAHUaCfCzeio/8wb5vVeL9zCn3Sl/NIyny2/4Uof2OAuWKUd2UGhZQM3mrfxy4Q
 rxyjeNrhAJ0Gqs4sxsHjvO66LqHlpZAnM9HjdcnVm5atC9sX6G7q1uc9k5zKRT/3WiJV
 9mDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaELjf9/evSFNAPLxsuMrph659a0BWIY9Co4aaRV0LNe65Om0FiuNzKtrKbbmDoUjDy3QESKkM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzbq5rzj1kWM66iqwGpgnNWCjqqd/zbABvQ/E+dw9GgkW0Cj/e5
 /zyGSpS2zGMt0WWr8gXC7t4ur4Iejz34FFvU79stePkw+LL/9W03BNMiV2N6zQ4J82wEMn7b0Vx
 qAzRninb7STmL6XDjVlXU1FeUmKOSI3I=
X-Gm-Gg: AZuq6aLGYxtEwQT3jEW1z7ylxmSU0XHodpD3WAV1kETEt9U2cz676K32jFROpNh7SXS
 CqsmmduUQBwLE6ekEMb4FgYug40FMIXM7vzz9jGg/2HdNIhnkK+rHaWnVnmk9UTD+jU7oOXsrQX
 8IBTLfA+Y14lwbWeqRNRVaw9SUO2p59uaUUk9ex4GLihKwAKEZz4ShYxtszNYByf1dXdM92QDlJ
 7ho8Po71DhMzmT8poodYyPVT1oqaepGK3zzphFji1qpSJX4i6rKsGXRLKPyLrkBryTYjUtlx3DL
 0G+hnVMf
X-Received: by 2002:a05:7022:a92:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-1272494f67dmr620116c88.7.1770751047940; Tue, 10 Feb 2026
 11:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-17-tomasz.pakula.oficjalny@gmail.com>
 <f19af3c6-f865-4758-8c50-aba40ec1cf68@amd.com>
 <79264ab170e48e1372b3b847d75f4635dcc57aa6.camel@gmail.com>
 <CADnq5_PhcNPU=4s1P30OqbWY7qPD3dHmjEtoz4_Md41u=xaxFw@mail.gmail.com>
 <1002281ca27d58a47a47fb655a88637e49776706.camel@gmail.com>
In-Reply-To: <1002281ca27d58a47a47fb655a88637e49776706.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Feb 2026 14:17:15 -0500
X-Gm-Features: AZwV_QgJB6v1nKXY2CnqRwBQYAE-sHXcGFH7dydSUxWcivhgCfgEW1B0ZDDvrLE
Message-ID: <CADnq5_Nrni6_Y7BCn9GH-aF2A1iOjgbr4Ebouf76Qogtb_v3zQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/19] drm/amd/display: Add parameter to control ALLM
 behavior
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, alexander.deucher@amd.com,
 sunpeng.li@amd.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, bernhard.berger@gmail.com, 
 michel.daenzer@mailbox.org, daniel@fooishbar.org, admin@ptr1337.dev
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

On Tue, Feb 10, 2026 at 1:44=E2=80=AFPM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> On Fri, 2026-02-06 at 17:04 -0500, Alex Deucher wrote:
> >
> > Also, maybe a per connector kms property would be preferable.  Then
> > you could change it per display.
> >
> > Alex
>
> I've dealt with all Harry's comments but wanted to make sure I
> understand properly. Do you mean, that the two settings should be a
> connector property like VRR_ENABLED? I understand the intent and I think
> in some time, it would be best to have these exposed in compositor
> settings but how would a user control this until then?
>
> Would it suffice to fire IOCTLs from a third-party tool like LACT where
> support for this could be added in a short time?
>
> I made it a module property in the first place, because I thought such
> settings are pretty set-and-forget and module properties are just easy
> to set :)
>
> Still, I think the defaults are sane. If I have to spend some more time
> to get the connector properties working, I could send the patches with
> the module properties ripped out for now.

My understanding is that these are something the compositor would like
to manage.  I'd like to avoid adding module parameters if we can help
it because they usually cause more trouble than they help due to
unforeseen interactions with other features or "conventional wisdom"
blindly followed which leads to a bad user experience.

Alex
