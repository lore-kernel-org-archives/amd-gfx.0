Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824D5E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 14:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4D110E45F;
	Thu,  9 Jan 2025 14:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fO878uUb";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A8110E45F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 14:57:54 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YTSYm5CWBz9t12;
 Thu,  9 Jan 2025 15:57:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736434636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PIcf94QpdY4vCtUlne7B4MNOeArydMMKo6iwMMk+Eg=;
 b=fO878uUbCoCdeKfyMJM/P/H8ESgCLhxica4T70sPqMzo02ZUC64kIP5/DDZFyBy6uGvroS
 qj4+E+UfFKF1HlSTrksPLBUIaRjfe2FZfitY4UaND+4VL1d4+WAYDkUYqX0kYvTcl8TyYh
 pqzf3tOtnLtuzsGjINUAqJyLVaI+inaMRTqGj31E0aagPPuFwQMRuyy/a64fVwqDJ/sKo8
 lBBgYX6mCCC8C3QOLeBpYcDhtFAQ7roSTMDpXelKiya4KHNLKiN4rdNbvaKTIBnk86tPIB
 Op1pTFuFHf9EiuVwSbrdQPkzaH0EAmRKu8jdGw9NfHd4Io+4q66DOiJT+jv9xQ==
Message-ID: <7893ceda-5260-46f2-8a87-ffb7734fa99b@mailbox.org>
Date: Thu, 9 Jan 2025 15:57:15 +0100
MIME-Version: 1.0
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: Mischa Baars <mjbaars1977.backup@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
 <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
 <CA+b5WFEjG1DE1+_gG0qwmEf4nQZFg=9O+rHDJZmiADL5Hi7fbA@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CA+b5WFEjG1DE1+_gG0qwmEf4nQZFg=9O+rHDJZmiADL5Hi7fbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d8e73b97bab921b69da
X-MBO-RS-META: e3bycfzjg6t1xar7phm19hhzjn63i3ng
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

On 2025-01-09 12:00, Mischa Baars wrote:
> On Mon, Jan 6, 2025 at 4:41 PM Michel Dänzer
> <michel.daenzer@mailbox.org <mailto:michel.daenzer@mailbox.org>>
> wrote:
> 
>> I'm sort of a fan of Michael Abrash, as he inspired me to learn
>> programming assembly language a long time ago, but in his Graphics
>> Programming Black Book, Chapter 23 <https://www.phatcode.net/
>> res/224/files/html/ch23/23-03.html#Heading6> he shows how the CRTC
>> Index Register is used to change what is shown on the screen by
>> alternating between two memory pages at PAGE0_OFFSET and
>> PAGE1_OFFSET.

That's much lower level than OpenGL. OpenGL implementations can and do internally use page flipping under the right circumstances, it cannot be enforced via OpenGL / GLX / EGL APIs though, it's an implementation detail.


> The glDrawBuffer() <https://registry.khronos.org/OpenGL-Refpages/gl4/
> html/glDrawBuffer.xhtml> reference page however does speak of
> initial values for double buffered contexts and the use of both
> front and back buffers.

The OpenGL app can use single-buffered drawing to GL_FRONT if it doesn't care about the artifacts possible without double buffering.


> Can you explain to me why we are only drawing in GL_BACK and how
> that relates to what portion of memory is shown on the screen?

A big point of GL_BACK (and double buffering in general) is that it's not what's currently visible on screen, so there can be no artifacts due to visible unfinished frame contents.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
