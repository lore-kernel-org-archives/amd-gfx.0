Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB839D46BF8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 20:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4942510E76C;
	Wed, 28 Jan 2026 20:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BrWUewjV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E973710E76B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 20:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769633305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7NjC70Wbx6k2PSI9JfnskuYqjv2MVHWZWOdPzDzqJk=;
 b=BrWUewjVlSg5XW+TSqJCA7HIwi1/xqYyE4NCvuFJrPVPuw9MCpzapovQ4/Wz5PLoroMnvV
 EcEO3Nxl5FbMWBBd2ATnP0bXJEmCjN6Vv+raA32Is6bAwG1hrBQZtpLCGhOPmqvGoq3PTQ
 kC/fdkS14Mv4B1VscB5EEYUhawOH4sI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-8tjsLuXiPF6iXs2Wes9BzA-1; Wed, 28 Jan 2026 15:48:23 -0500
X-MC-Unique: 8tjsLuXiPF6iXs2Wes9BzA-1
X-Mimecast-MFC-AGG-ID: 8tjsLuXiPF6iXs2Wes9BzA_1769633303
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88fcbe2e351so36324516d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 12:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769633303; x=1770238103;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7NjC70Wbx6k2PSI9JfnskuYqjv2MVHWZWOdPzDzqJk=;
 b=KD5DdJRw5io1Odyp2gYjR1pyiXfEoROLw/qbHB+6jWguwC5mNjoUpowWz0CbULQuui
 qfFRQnbZRazYD1cXDoUAYFgH8zeStbblj3aHvhvgdQnLxGDUXUPpIB4n9YMNnGs3d3QX
 IA7eOApKamiInxpFGsbT5rHpR0bsnLExtRXUnSA5ocJ7qXo5RVPF9ovUb//AXWiQg6hW
 nBnmxQ9jWo74pvmNO8yOhbLFA8KMHkRGQwSEwuNy6dc6mUbuZu75l8A+qt1+66GDI3kf
 xN/RCpPvYNEIYsSK2cUm/6ySPKyj+SQ6PGJZIYMVgX0zhYuQgg4aZQgOEJYn+uGfarf3
 Tr5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgQtphITpxAIzdHjbqugC2PlgC6zYWmsHb0kaUvQRz2ZEDReM+l6ma3eVhXPo5/WM8gR/LoCnC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyK0TTDNCdPkjEAyEH2BlFSaHqwJvFVlN3VFte14c4BLV9Gy/DN
 OupRzmPbNj0X1gYzJXgMYYX26U9yN+7yg+LU5esLp/NbZnyaWl66IlFvZFmxS8kzHBTeT6mSkVJ
 oNipYglE6kKEojbJQmlo89g9MdceIu1PiOYNffHzd0km77myuwML4XUAt+Y4ETLcBEYM=
X-Gm-Gg: AZuq6aKxy1NKiU2wB07l2qFsWGoIKpmSZd5mibMHlsx06rtpKUCw/F8AccY4DVL99uI
 QP9pIDsPIyWGduE5maCUKj0sy1qxO7oe/ezGWAjj5WYzSnyWEEIbZYVL7at0VOAR3RYdg1R0+JE
 kIYQ6/L5kfXJl7v0YRbu5/VfOCtMdfQmrdxseKSTg341uW1W4HNPJXmLM6kBRIgE0rjYBXr0RLJ
 4zl7pXoLr5TrAsLvmO109rKLVx4tkGFqnI4eNh/d1aIMeM2b0mm36w5ar+TSsyptjpl4oxHIniU
 QWrgTFuayaS6XxMTqvGC1ctgt44GLcE9o24mMFaeIGI0wdWFRVDs0nHZbfB2cnxEsWg5OIg3rnN
 /Kxe2oLkj
X-Received: by 2002:a05:6214:1c4c:b0:894:6da3:219e with SMTP id
 6a1803df08f44-894dfb2fc42mr12642566d6.25.1769633303097; 
 Wed, 28 Jan 2026 12:48:23 -0800 (PST)
X-Received: by 2002:a05:6214:1c4c:b0:894:6da3:219e with SMTP id
 6a1803df08f44-894dfb2fc42mr12642106d6.25.1769633302582; 
 Wed, 28 Jan 2026 12:48:22 -0800 (PST)
Received: from localhost ([2607:f2c0:b0bc:f100:e97:de30:9768:6518])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-894d375debasm24038726d6.42.2026.01.28.12.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 12:48:22 -0800 (PST)
Date: Wed, 28 Jan 2026 15:48:21 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [REGRESSION] drm/amd/display: Add an hdmi_hpd_debounce_delay_ms
 module
Message-ID: <aXp2FRLJh-7Q6TxS@earendel>
Mail-Followup-To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
References: <aXptBPF3L07zJB1O@earendel>
 <CADnq5_OqFEi_ML9zR-i_WFtFmBBQQcbQNRAiP8pVdD+prvEoiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADnq5_OqFEi_ML9zR-i_WFtFmBBQQcbQNRAiP8pVdD+prvEoiQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TatCXSPjDKkEeXxc9ES2UksjjX6RuWnO94DHWxqNyt8_1769633303
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On Wed, Jan 28, 2026 at 03:17:18PM -0500, Alex Deucher wrote:
> On Wed, Jan 28, 2026 at 3:09 PM Peter Colberg <pcolberg@redhat.com> wrote:
> >
> > Hi,
> >
> > I hit a regression introduced as part of v6.19-rc6 (and still present
> > in v6.19-rc7), where, upon unloading the amdgpu module, __flush_work()
> > is passed a work struct with the work function set to NULL. The issue
> > is seen with an AMD Radeon Pro W7900, but not an AMD Instinct MI210.
> 
> I think this should be fixed in:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/17b2c526fd8026d8e0f4c0e7f94fc517e3901589

That fix applied to v6.19-rc7 does indeed resolve the issue.

Thank you for the pointer and apologies for the noise.

Peter

