Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7B2C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 07:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52BD10E4D6;
	Fri,  8 Aug 2025 07:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="Myt5fAsN";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C6A10E874
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:52:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4byVVn3hsZz9swK;
 Thu,  7 Aug 2025 16:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754578321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBRMuK3kUudd7S76A732jVURDLMo6rQbIR206iOwpUQ=;
 b=Myt5fAsNQbk2DTfj6fGPF/ejkW5jL2g17RphAYiU/tFC/VEhqKZlsA683dz0DUvH1rwnnI
 NZWOtkfcKBFFOnJrnMcSkMMOrZUDYhIykvNO0LFM2BGHcDQk9F561mB5BxDdTje5112FJb
 9KqiYByjK6awrl25TcWp0RcNMRgyCi9z3LhYFw/zJxYz5/ATxDiwHBKhjzpg2Q3BqL2x67
 bEwU8vA1wYEcGY9N5qtx4k6YbW5lqjgXaudqm2FX2DWjUI6d6EDVj5zP/ptDhF/X58gZlm
 DPWAvt9lIMNh/X5QgdgLzd1D8Z52ga6+99QWvxVy8DdaRw9GVPsYHJABji+bBw==
Date: Thu, 7 Aug 2025 20:21:57 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com, 
 christian.koenig@amd.com, sean@poorly.run, amd-gfx@lists.freedesktop.org
Subject: Re: Is amdgpu open to converting logging to drm_* functions
Message-ID: <sgwbcn6yx7crbfzikthdijehrijipwspgokj4mwnt47bwhscbt@fn7o3d66mzu5>
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
 <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
 <CAHbf0-EA6-jn8tOCuXv=9JyZr-4kKhoFBZC-pqQcG4ydncHTOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbf0-EA6-jn8tOCuXv=9JyZr-4kKhoFBZC-pqQcG4ydncHTOw@mail.gmail.com>
X-Mailman-Approved-At: Fri, 08 Aug 2025 07:32:07 +0000
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

On 07.08.2025 15:20, Mike Lothian wrote:
> On Thu, 7 Aug 2025 at 14:22, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Aug 7, 2025 at 9:13 AM Brahmajit Das <listout@listout.xyz> wrote:
> > >
> > > Hello Alex, Christian,
> > >
> > > I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
> > > TODO list on the kernel doc, and specifically this section[0]. Would
> > > amdgpu be open to this conversion. I saw that before starting it is
> > > recommended to talk with Sean and the relevant maintainer. Hence I'm
> > > emailing you folks.
> >
> > It would be nice to get rid of the old DRM_INFO/ERROR/DEBUG macros and
> > replace them with the dev_ or drm_ replacements.
> >
> > Alex
> >
> > >
> > > I guess you can also refer to this,
> > > https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-daniel.vetter@ffwll.ch
> > >
> > > [0]:
> > > https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
> > >
> > > --
> > > Regards,
> > > listout
> 
> Pet peve I get random HDR SB messages printed to my dmesg by the following line:
> 
> https://gitlab.freedesktop.org/drm/kernel/-/commit/88694af9e4d1feaf635c23844833960f8958af78#298241cee0e184ade58580011daae827741f9838_3874_3927
> 
> I'm not sure how this is useful, or how someones supposed to realise
> it's from amdgpu either

If we do something like 

-	print_hex_dump(KERN_DEBUG, "HDR SB:", DUMP_PREFIX_NONE, 16, 1, out->sb,
-		       sizeof(out->sb), false);
+	print_hex_dump(KERN_DEBUG, "AMDGPU HDR SB:", DUMP_PREFIX_NONE, 16, 1,
+		       out->sb, sizeof(out->sb), false);

Maybe it will help in understanding that it's coming from AMDGPU
(assuming we are keeping the print_hex_dump).

-- 
Regards,
listout
