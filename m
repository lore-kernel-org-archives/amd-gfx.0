Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE28C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 14:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2A760F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D2A760F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E312389DA4;
	Mon, 27 Sep 2021 14:58:12 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7116389F19
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 14:58:11 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id x124so25886852oix.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cHMFVm5hf7kJJgUtqrzezf6W2fGyhglHfmB/uYFeGQ8=;
 b=TQgBNG+k5XoeTbqFYfcGBQm05buCvHluyA7JLRiJUPNCznuPYFMhdHjv0m0wczRdCt
 tAQIxRbscDyqKWzTYXxN96eSWfhdv0oNSQ9bK4VxoMv67gBdF+UGYC6G1GTCfjOPpn7q
 2erOamrEwrcJW+IkGA25yGdIl5vYntaNBNLAbhj4WlY9VdUles1t4iDa6O2VpitOydFJ
 3LaX7/G7sDCJWwq2XyneroQ2RCeyx21qu91t0FzZa1x2wcoAae3gpEFHOOtVP09FRHWF
 uOog25ya7Vky1MEhTfm3WDt4bb+Antk7ox2sRa523h3hJod2xyIhsktAq8lFcngCFeeQ
 C0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cHMFVm5hf7kJJgUtqrzezf6W2fGyhglHfmB/uYFeGQ8=;
 b=Gk4XSEt0HVsh8LDP/cd4BDhunfDeEcXy8G5YqZ4Fufm4WcbAHl1ia7ZXakvI1+x6Id
 DOwbM9HXAoZfcXvZxn5vdh6MAYyso1Z9jlQi/hO14MNxNoOA5peO0qbX7jVJ50zIstqv
 l3fxCrdZ1BFWe9LhhTayocd2hgYIGYkz5gy7jVQyNLpVQTrbvidjh54aIZ9//fKZEZnQ
 mL3t7WiqCdTRHGjiB9bnBq//8j63z4EH/HrggbusgTiqFleYw7vg/yDLrRkQLTlOUIEh
 Gklz6AlGSO59UrxlY+47xvykwUozkXAinWq5maEGPx3CfS2uNx71d8WKk/CmrPJmnHEo
 v72g==
X-Gm-Message-State: AOAM533OfPFERWC70ghXxuWM7B681vK5EqUXtJ9vPzphg7nhFT/VvFSX
 bcMYMbo6RN5h1XT35Nkxii0SbXLBqDY0CZw4lOsuu0mI
X-Google-Smtp-Source: ABdhPJy/4tliBTh/Vdqqapab71XikNVQlslcIQPduSbmdP7NWU8gy7muYMOwWETs97qebb50PhtoHIBgyHxokuj8nSw=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr290079oie.120.1632754690719; 
 Mon, 27 Sep 2021 07:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210920103133.3573-1-contact@emersion.fr>
 <Kmwa-gfuqYfkMsvvUXAaujfROLLXX4PuTRBRQ5efixoEvM3arNB_yT5eure3D1iqmnFB54wnbB87S1zBLL-79Ci7fhqoKx-M-ciPVs5fcSU=@emersion.fr>
In-Reply-To: <Kmwa-gfuqYfkMsvvUXAaujfROLLXX4PuTRBRQ5efixoEvM3arNB_yT5eure3D1iqmnFB54wnbB87S1zBLL-79Ci7fhqoKx-M-ciPVs5fcSU=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Sep 2021 10:57:59 -0400
Message-ID: <CADnq5_PFMLUfadfA83bH7i4wAQdEtLWsKf7L7iLT_YjEhXDGug@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: check tiling flags when creating FB on GFX8-
To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "for 3.8" <stable@vger.kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>, 
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 27, 2021 at 9:09 AM Simon Ser <contact@emersion.fr> wrote:
>
> Alex, Harry, Nicholas: any thoughts on this patch?

No objections from me with the WARN_ONCE change suggested by Michel.

Alex
