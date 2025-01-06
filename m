Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A636CE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE1110E6B5;
	Mon,  6 Jan 2025 15:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vEw8bBW1";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5827C10E6B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 15:41:08 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YRdgh0dwSz9shs;
 Mon,  6 Jan 2025 16:41:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736178064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaRXNCT9LAYcfP4tUqJO1NGf/nICCwxiIOioG0Qs+so=;
 b=vEw8bBW1eeAD92x6msKIIID6ZJismcVbVllovp4ZTBu0Jq36lHqlR+syqo+ms9FraANLuT
 od1VJebBjzbPuaiQEMM3Ib3Jcbt14xEq8vf+0c+rj4KjmEV8Sqa4JmK9W/6Kx1ocdbkOnZ
 mpQzVD5Mmx9RHUZF5/OH56PzrA7AQi4C5F+TxTrTxT7fVdJqpC+zGo48U1kCtZweGcJ8qA
 unCz2sorli/K5aV1Xrp9b8rjH+RzD88gPU16Lvx1nx99Ok+VjI3pk2G0rslKjFMzvPXgGe
 GLYOFeq8pqFgA5CZRLnlm+eVZOmyUZuVIH0rRIzvdi4jVKnN/3iBiYz9fSKeAg==
Message-ID: <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
Date: Mon, 6 Jan 2025 16:41:03 +0100
MIME-Version: 1.0
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: Mischa Baars <mjbaars1977.backup@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 614997cb3ae6463869d
X-MBO-RS-META: kqb9e696irtcp46ozeogdtzjqzx1qksk
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

On 2024-12-31 13:42, Mischa Baars wrote:
> 
> In the meantime I also checked the framerate synchronization through
> glxgears at different resolutions and framerates. This does function
> as expected. Although I haven't yet inspected the glxgears source
> codes in detail, the OpenGL double buffering must be functional up to
> some level. This means that the problem must be confined to GTK and
> the GtkGLArea widget. Using GDK_BACKEND=x11 I do get a double buffered
> context, but the default buffer does not alternate between GL_FRONT
> and GL_BACK.

Yeah, that's not how double-buffering works in GL. The draw buffer is always GL_BACK, SwapBuffers doesn't affect that (it just may internally change which actual buffer GL_BACK refers to).

I don't see more context about the issue you're investigating, any pointers?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
