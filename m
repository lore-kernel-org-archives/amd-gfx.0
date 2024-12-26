Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE9E7718F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2024 09:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F8A10E7BD;
	Thu, 26 Dec 2024 09:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NcGZrvQH";
	dkim-atps=neutral
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29ACC10E653
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2024 01:27:31 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso5230327f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735176449; x=1735781249; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w+1gJ6KVd4d91QuBEx/cbFE3H0/ijnRtOxNNQIBNOxI=;
 b=NcGZrvQHj14+w3DqqHzQaXhlBBJa+J6nHr1nLwJrxYklhydKRZktkM2QtZXGgsfLzi
 6t1sXXHc6xs/xOAj5N/SqAor+m+422Wqm3oopPMkuirrArP29vnlO53gShiYHi5NdbN2
 unF9y07dF6pX9XnJWvGwZ6TjR4evdRZLZTJgYdUuNOvV01eFEJuDmyiRv6EDcV/syosG
 IDfRa61kTMl37q+DPFRYiXi96lMTHHmnNTTiT0xSqBSQt0oSVkz70t5D19/Y8zMV1Hwa
 9scy9UfFJL4fHjcgb/E5IxuGjrA1xuZTyB3+l8r8JK3eKwXzALwHvzKqpP8UtR9Olrvy
 JEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735176449; x=1735781249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+1gJ6KVd4d91QuBEx/cbFE3H0/ijnRtOxNNQIBNOxI=;
 b=xGAlCJxNb145ZlaUnMYj8g5NaYbJ7wzdV1olqM03jmtSqps0T5xckKykHL7s8rWtS0
 8QvLIISrRFNbkduKLRmxgo6K9jJgYmoVks1qnAyXmvXaKNcT3msmXVp8rdi4Av66SUDo
 i4woqFS2S8LybSHUwZCNvUFOa4yf15kn4+Rmo6vEQIM0zNJo6nGFhAuBrLBZBc8bDJHr
 Pia6IIOmDeprL7PQd/TufZZIqjmlQ3SyBLEt4VLk2aRvzjri0/eNw3t2JflqajcYdLPG
 RNmrFc765wmQVv4a1pKD0FVCD4M8CwaIJS8U0zsEemX2msKd8AtXgleSR2tl0sZa4Nju
 Yu9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKB7xTWvK380u+H63eg/MJkGw1Hj8iHQhhsGT0WeMBNDZ1aFG3diDssjgWoQcczbwmnO7VnwD8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGWdbrC13SV0qaYCANLnDs1Sw3uWgXGprGdDthq1INz5sVc9G2
 vwsYYODtKt68vopVV7/f6lB6euKcmAQMy7q6u+z4QU9HeNkM0UhS
X-Gm-Gg: ASbGncsBgvMm+wcCzck/s4nWAMMZOZMhqt0PtYjVPe6Rg7JEgup2+lxtbhdCwX3VfEv
 s+tzglEzDsQiqaXKCLsVPC/ihAeKNrcq0aKIeAY5lCWZR4eA0pAK9IjaLa+S/pv3pTdjSkhjRzo
 wwMUd8iHupr3JupAp+jpEXBVj1wHSRYVRWsme9fPKV5v69LjqAYeSr5pwiNMcbBwS+gFbmq9pr+
 VzA/ws93q18Z7vUXuwFvEmQ8R7wdMew0CKlM7x2nJ7sATi+YHlqORIzrvny4mA=
X-Google-Smtp-Source: AGHT+IEhKxgf4hIQTI+Klr0apBS3ueanh/tTSMf0cm7MR8jqtmgAC2JCW+Dv1tvv1AYLHnhwnZnAgg==
X-Received: by 2002:a5d:47c3:0:b0:385:e35e:9da8 with SMTP id
 ffacd0b85a97d-38a221f69e0mr18547954f8f.18.1735176449451; 
 Wed, 25 Dec 2024 17:27:29 -0800 (PST)
Received: from debian.local ([31.94.62.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219611sm218332885e9.23.2024.12.25.17.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Dec 2024 17:27:29 -0800 (PST)
Date: Thu, 26 Dec 2024 01:27:25 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
Message-ID: <Z2yw_eJwR5ih1Npr@debian.local>
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
X-Mailman-Approved-At: Thu, 26 Dec 2024 09:00:11 +0000
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

On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
> Hi Chris!
> 
> On 12/26/24 00:09, Chris Bainbridge wrote:
> 
> > Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> > available for eDP") added function dm_helpers_probe_acpi_edid, which
> > fetches the EDID from the BIOS by calling acpi_video_get_edid.
> > acpi_video_get_edid returns a pointer to the EDID, but this pointer does
> > not originate from kmalloc - it is actually the internal "pointer" field
> > from an acpi_buffer struct (which did come from kmalloc).
> > dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> > resulting in memory corruption which leads to random, intermittent
> > crashes (e.g. 4% of boots will fail with some Oops).
> > 
> > Fix this by allocating a new array (which can be safely freed) for the
> > EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.
> 
> Hmm, maybe I'm missing something here. But shouldn't it suffice to just
> remove the kfree call in dm_helpers_probe_acpi_edid()?

Yes, that would work to fix the bad kfree, but there would be a small
memory leak of the acpi_buffer struct. It's not a huge problem since
this code is rarely run, and the Nouveau code has never tried to free
the edid buffer and apparently nobody noticed, but it would be better to
do the correct thing.

One other curiosity is this comment in the code that allocates the
memory:

case ACPI_ALLOCATE_BUFFER:
	/*
	 * Allocate a new buffer. We directectly call acpi_os_allocate here to
	 * purposefully bypass the (optionally enabled) internal allocation
	 * tracking mechanism since we only want to track internal
	 * allocations. Note: The caller should use acpi_os_free to free this
	 * buffer created via ACPI_ALLOCATE_BUFFER.
	 */

Which makes me wonder if all the calls to kfree on acpi_buffer structs
with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
acpi_os_free instead? I used kfree just for consistency with the
existing code.
