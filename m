Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A265EC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 16:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6F11135CF;
	Wed, 10 Aug 2022 16:42:39 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A762918BA6C;
 Wed, 10 Aug 2022 16:41:23 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 cb12-20020a056830618c00b00616b871cef3so10992975otb.5; 
 Wed, 10 Aug 2022 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=XTiTJ4FxwpWw84LKiNSYSTO/gnrN5qUZqhqmKW/Gh4w=;
 b=iga87Q0F4KLtml0NyMbtr1doo/KawlNydW0obAC9W9XBiNKTLuc1dMMr/L4myWJJ96
 RjUTWxAXFZr3TjlQ21zg9Of0DCXVXPRilL9UrcA8kO7QEhdtNkFddzJx/QOHI8CbQWIm
 7W4UcXySZoD/kMnHqpgnbDT3yf1ctBtw3XpjfDz/Nv3fYhMV3x1Ui3sG8O73WGnfFMAe
 Y7LRSZCv7bOs1dQa/KbAX9s7/bHvJnL0OAzEIqFm0nxq3ObFt0VMZrAPsC0ZvUDh/IZ6
 4hVNzZlY6ScDa9WRaxIODBundsFeu2eK/lej7WY//Sp2ZdQVZX4euO6ivO6wgJNB8C4U
 J1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=XTiTJ4FxwpWw84LKiNSYSTO/gnrN5qUZqhqmKW/Gh4w=;
 b=plRdnXNK23U2IHQvk0n/Ps17LdEp+P+C7GO9wapSRue/qQp24QZOS0rk20fr0aZekm
 pyKYZNV3w0myhw7KQdhi7dxyGrBMU33IzE4lEg24ooBfMyTaF1q3OgdYhfOu0T/AQEfp
 cYTMUFaILLSm1orEEYXqFJWBsUeQmDtmsgbKon81Pw0LRwml3dIpnCfAY2bqtEIUFnD6
 FQ0Viy0fjwYzt9ooZoXZQiysMtUPN+7ioFIygvW2PZjv4asFAcXQKlnZGOaakmj+laoD
 op4whgtTE3VfG3XzEKLMzjH6kRykGY6iWlPLzkQgVPD3CZTXkP34vUbAnO7/MICOJew6
 Qgtg==
X-Gm-Message-State: ACgBeo1qlruzyd1Zaj1HIcCE6YiJQ+I02qeBQzS83lPIdykSL2QQsdr0
 B+o+wtLaxsb631Fb/IdiJcc+ci9Y0Nrb9PERc74=
X-Google-Smtp-Source: AA6agR6wR4ecNZe8+daGyRZM7VDRQFe/FZPJGUKIa38dUFuAS7M6VAf17HivKhzzWW1T/4Ni+myaw/45sJblGkIs5ZM=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr5897353otr.12.1660149682412; Wed, 10 Aug
 2022 09:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220730034923.25500-1-mailmesebin00@gmail.com>
 <31187f41-64c8-d7ce-fcf2-5da421b3e194@igalia.com>
In-Reply-To: <31187f41-64c8-d7ce-fcf2-5da421b3e194@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Aug 2022 12:41:11 -0400
Message-ID: <CADnq5_OOWekUj-Y8Y64=vUUMfUmEXUyQ1Ougmqj2afKtu6hdNA@mail.gmail.com>
Subject: Re: [PATCHv2 -next] drm/amdgpu: double free error and freeing
 uninitialized null pointer
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
Cc: Tom St Denis <tom.stdenis@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 David Airlie <airlied@linux.ie>, Sebin Sebastian <mailmesebin00@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Aug 1, 2022 at 1:08 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com> =
wrote:
>
> =C3=80s 00:46 de 30/07/22, Sebin Sebastian escreveu:
> > Fix a double free and an uninitialized pointer read error. Both tmp and
> > new are pointing at same address and both are freed which leads to
> > double free. Adding a check to verify if new and tmp are free in the
> > error_free label fixes the double free issue. new is not initialized to
> > null which also leads to a free on an uninitialized pointer.
> >
> > Suggested by: S. Amaranath <Amaranath.Somalapuram@amd.com>
> > Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
>
> Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
