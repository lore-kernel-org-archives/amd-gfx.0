Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 14:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B0210EF20;
	Thu, 27 Jan 2022 14:11:20 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C927210EF1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 14:11:19 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 n6-20020a9d6f06000000b005a0750019a7so2656928otq.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sOcCI4PoFLRFI5TcwqfY5vOZY5/8yoIL19ZLtfizDdg=;
 b=DI5U9KzLhcwj/jAoYCyKFDpE8qKaTEywZXGHf5j/b3zlZzoMrlVCiFn+zUq+ejzIPf
 3/gEJotvPlmseg8ocPf0xL7PTD50JKqSFMzlJbKYsNmcWfzT5SlzgK8hUS7+NkGUTZlF
 pkefREwb7f+9HMPY2zA57gNcSyjoRV2hkh87CS/9T2q+BHgiofjU2OjHmRORDbdPiw9x
 gmDWTmRANLtfeep7HoVc0YeR46X4MP19kgKsaI55vUm3uwfTxOULcijM5tWvQZh0qtbu
 mkfx7S/fYwsQssPix7Yz7QhXPBFLtH+DOO2+FV23+t5Rr1v6wJoNCKDgXbUgb9ynygro
 OHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sOcCI4PoFLRFI5TcwqfY5vOZY5/8yoIL19ZLtfizDdg=;
 b=avU3fBU7rO//oSbHKK88ZN6FenVyXS/te98fA7WWhx1AlnyQEK4cVNwc6semlZUjMo
 hwpm9zkY1RCipHol3HHWS0QEN5awlR0KfDFGTOpuN7G5aVORcht9KkujVQSh23MttA81
 gQEWCKLabcQ16QluP2x0KzChDbXbFF/khorEnnDxMqn9lak/f0bAfVSLCGNlbgeA8qG0
 NZChfY8F3IUU3Pj3wj2e9yCwFlLMBoP1BsY0MR5latFx1PXvEFzRTdUmm9ovOt7Jo1Cb
 v3QuYDCg+fDEna5xb47ihKGvsEgMCMmvwb1kAMYPscgw/LkZDmZLOTcfPtLDH04IjCF8
 ydeQ==
X-Gm-Message-State: AOAM53285JCVfHcecrc4JhOGlSuPWWXtm8oI5W+NqDiqY7zyTjb6CW/4
 4npjUSPDFi5ke6jGbR/c+plHJIBJRGzafl0gikAV00PT
X-Google-Smtp-Source: ABdhPJwNKsroVg9DLK5ppaNIJx65Ap6q5f/vTvGE5YKPBeTctx7+gMt9bb/Qbk6TlOZ2AKAzjspyCCF9IWI23mwfPAA=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr2167051otj.200.1643292678725;
 Thu, 27 Jan 2022 06:11:18 -0800 (PST)
MIME-Version: 1.0
References: <DM8PR12MB54148E41D5C03634DDAC738FF6209@DM8PR12MB5414.namprd12.prod.outlook.com>
 <DM8PR12MB5414E5088A8AFE9240C57654F6219@DM8PR12MB5414.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5414E5088A8AFE9240C57654F6219@DM8PR12MB5414.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jan 2022 09:11:07 -0500
Message-ID: <CADnq5_PYaE16eEJ45d4Sq4D8LvHH7jrZVwhvET0hQHwogus0RA@mail.gmail.com>
Subject: Re: FIx for UMR arm build
To: "Newton, Jeremy" <Jeremy.Newton@amd.com>
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jan 27, 2022 at 8:39 AM Newton, Jeremy <Jeremy.Newton@amd.com> wrot=
e:
>
> [AMD Official Use Only]
>
>
> Sorry I think I forgot to attach the patch =F0=9F=99=82
> ________________________________
> From: Newton, Jeremy
> Sent: January 27, 2022 8:39 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: StDenis, Tom <Tom.StDenis@amd.com>
> Subject: FIx for UMR arm build
>
> I know we only technically only care about x86, but this just fixes a syn=
tax issue if you build on arm.
