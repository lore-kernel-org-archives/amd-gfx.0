Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F5C87FDA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 12:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8CE810E83B;
	Thu,  7 Aug 2025 12:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="ztYuwhD2";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EA810E11B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 11:28:57 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4byQ0Q03qWz9t2g;
 Thu,  7 Aug 2025 13:28:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754566134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP+azXGZ3l2MDJDwpmFTd8e7rPLPDqQv2ACl8DaU2E4=;
 b=ztYuwhD2pVrZ5T4LTpAlCjLsptZM90IwCyqp5u45ssCDgy5goH29SxmW4zIgQjQWtCE1K6
 BUKfcm1pVNiXBf4IzZPJ7rq8jq9eqs04EbJneJ4gb4j4xTreI2GQdBbnXbkVgX4Qt/DX2u
 zhtbd4DlqEW73C/nYOvqFNx8vCen5B0HXmOPE164bG8eaNCLxO1ACoxeaNIdZj3b7SZR68
 1lEmPUCedi0uEUJn74qF6ZrcW0Dgnro+ZDraDepx75/5dHOUkAfdPyyHEwFAG1KTOcG2E5
 TbmCvhc6ktea44/OqMipGAttsI9L5x9rONh+lgBjTx2rQuUlZB2E2qgAAQvTaQ==
Date: Thu, 7 Aug 2025 16:58:43 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, sean@poorly.run, amd-gfx@lists.freedesktop.org
Subject: Re: Is amdgpu open to converting logging to drm_* functions
Message-ID: <lopi32lqfsue3ptfr3msmfz5e3plc4c4wh6axcfosxc4axr6bd@tso4fq5ijrg6>
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
 <ddd67e1a-3b8e-4ed7-9001-862af3b0e2cb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddd67e1a-3b8e-4ed7-9001-862af3b0e2cb@amd.com>
X-Mailman-Approved-At: Thu, 07 Aug 2025 12:57:25 +0000
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

On 07.08.2025 13:18, Christian König wrote:
> IIRC we settled on printing everything DRM related (e.g. display, device lifetime, clients etc...) with the DRM macros.
> 
> But everything related to general HW information like PCI slot configuration, BARs, speed etc... is printed with the general kernel functions, e.g. dev_err() dev_warn()....
> 
> Background is that a lot of messages are printed by the PCI subsystem while resizing BARs for example and it just doesn't make sense to enable/disable the amdgpu prints based on DRM log level around that.
> 
> So as far as I can see there isn't much left TODO on that side.
> 
> Regards,
> Christian.
> 
> On 07.08.25 12:20, Brahmajit Das wrote:
> > Hello Alex, Christian,
> > 
> > I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
> > TODO list on the kernel doc, and specifically this section[0]. Would
> > amdgpu be open to this conversion. I saw that before starting it is
> > recommended to talk with Sean and the relevant maintainer. Hence I'm
> > emailing you folks.
> > 
> > I guess you can also refer to this,
> > https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-daniel.vetter@ffwll.ch
> > 
> > [0]:
> > https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
> > 
> 

Understood, thanks.

-- 
Regards,
listout
