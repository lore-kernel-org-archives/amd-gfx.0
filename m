Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4373CD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 18:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2D410E7ED;
	Tue, 16 Jun 2026 18:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZ4BuJOI";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A8B10E7ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 18:51:53 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-306f1213aadso443056eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635912; cv=none;
 d=google.com; s=arc-20240605;
 b=gWmlmdrqs7tD0rTEigIjlvY+fkn05KiW89ZEc5WjNE8coH+q7D4B+f30kSP7pqmsCg
 XmtFHh6CwnU5sZb/9A/az/A3scAGmP+AH13QLKpgTrB535a0ajYWGOQ3WHoEf0uAbj1v
 ggbERnLFvrUdqtPzqU7/iM6a3NsZXJDfQ+bMoBt+MOAb8b08qWb6jE5Rd4th5XelwQmC
 NCdYsj6+zGI8j3oqAH6/vtHIi8gETFJuiTQyPRqO8VoI6nFz8Jcw5qOyTMnTZ2XEPrlD
 HifRQ/9EHBrtVx8zWuANedVRR5P1zXEnriUTFUPCLh3e/34W+GOyM3hD4LyOjnYA3As4
 fMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lLZGG1vL2Dqwzut/Q/EWnM0Po9IOyB/nN+ycn9QeZq0=;
 fh=8NZK/li2IV6I8S/rS1JLlv99vfsCN11tCzFwSSRu8c4=;
 b=kzFDLJGB/+kavuEcs9TnVrxCpwNdrJfXbpR/mj14XBrW+qx9Y6gJ1YyzDsJ7g0Nzft
 wIIGHTV8JD5H7j7OwiY5kfpBI+3XQYV0tKxhURSVjcznZilt6zlhKvBg1boHXtc/XDWS
 edysHil4znSl/rSDrp6lN2jhiq5umGSb69p8jWRMEO3mk7QGKAEVfk/PEHk/LxCWIY19
 LoK6PNUuBRZVAcfmENDdFjZgm1UXGlhkKWUPpYVHDYhpSwUkz8AxTuw+GZ5iBNlVOnJm
 M6NmzxT1kJ9E1lQkV38AqJJ4dh28kXd7CbvYRhf4bvojH819II7nsSsZUOod6bHlCySb
 O3Pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781635912; x=1782240712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLZGG1vL2Dqwzut/Q/EWnM0Po9IOyB/nN+ycn9QeZq0=;
 b=sZ4BuJOIRfRaU6AZFHTsC/XDxviprJhubhgqmb/DpxXWCzPFV7QGFAWqMqeIZJLhYY
 WhLowUflXYp+5rAxZejAbZeYFv7DEOucKw4YJCh6E9qWNwwkdj63z04q0bh1d8uXxv+k
 L8wPeCFzekwSDee1eZ9WDRI5Oo5Zd+2ksiBSRElbdGmPq33Gd4awv3cfbdgv7B4iq5yZ
 IUZi7vVQIx8m9awpcQbG+d6DgKSDeuewSKU1qiqwWkzzVz/iwP2ra4m6LD9pxYpgCuIW
 mT90pQTkK0HxNwzhiUb1qgGu8gB4d8zhoCu/ORAT1YP1GjtRpW+lFLMQzubSSHbWeDEo
 kb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635912; x=1782240712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lLZGG1vL2Dqwzut/Q/EWnM0Po9IOyB/nN+ycn9QeZq0=;
 b=BYcjCc/EIUG3RhfQ4wuEGKzdKCAQpAEy/tMlJxPKsuVlzSHHx9OW3ouGFz+ITo2wo6
 oBabBxFeLe880+6VhSREvq5oaL/vgkYKSuZA7br6cBs42GZpWRExz84dtMnH+l656yr1
 SwmoOk855vUEcMJM67CN1wMWV1S/P5HJFYw+QbRHdXBFe3RyYHqOAXn8a7HNo1x33a6d
 XAzyUhqEJ4vJvAosbJVWC4QHxvvQVOZBuwCwpmzOitsjhNDP0Ry3MupgSBj2Kppni1dx
 QhryKUu6dPsC61hr1h2FQjhiojX5wX5TAUPeR8DJQxmLgzinTC8d05RYpEhlYQ8og88b
 XAMg==
X-Gm-Message-State: AOJu0YyrKtmz6hsIpAKVlRH092eANqekxxyTKJsqqn4iQekLd2tSC/9V
 gnDTtqb42xq05KW+rMit90t1ls+UImRDAxH9MZ6A/DxPkWZ27iXENrYiBpAFo3NQge7BQNrOtqX
 do9/jMf8sgIkxHEyuinh9gcOl5MHTELE=
X-Gm-Gg: Acq92OGisr9SJI9B9wWQqVGgCiyPZSLqmXY/jRDBkku/QiH8OQsjQIw76ENOht93zyY
 yEz4ONwq8WEnnhbcjSiwoM+UGUlfblJ8GfctGEI/NpIs/QO9Pqmwq8D5eJ7wehkqocB2pQevhij
 L/LpEMS/kHb4yueaA9oSmY7y2XAsqfahVjC/P3zRGeEbsIZvCbonn0EXBO/v1Io+tXmkv/kENaj
 vCAcNZWd4dQoiN9p0r8ARx7qvwkK2pQONEhnJgZIrCrG+43YmXSXfKyeKZ47Yfb1sH6SJFRu3O5
 IHfnxeCrBHnKwEuj7DOVdQqTwtLulpLdoqmFO6htCMq0JPlHjh3KuqJwk2L1cy8MpLUjL7B5Vd8
 vp89a
X-Received: by 2002:a05:7022:110:b0:136:d029:451 with SMTP id
 a92af1059eb24-1398f6ab309mr34977c88.4.1781635912245; Tue, 16 Jun 2026
 11:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
 <e2023393-da68-4775-9f55-16363191328a@web.de>
 <CADnq5_P6aSFKefO+f3aofhfNh7kELEQWxid4EWgwAUr2saEh8Q@mail.gmail.com>
 <1ed4140f-83b6-4393-a67d-ed321b72ecb2@web.de>
In-Reply-To: <1ed4140f-83b6-4393-a67d-ed321b72ecb2@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 14:51:40 -0400
X-Gm-Features: AVVi8CefSVV3ctlIm4JKXFEe2ToHhWyUVnA3pqitzvirCD1F3rsg-SVQpZJKAs4
Message-ID: <CADnq5_PSRrvhUvzkZQGiA=U7kyyowXjO+GC_bPP95jg_OzpOUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/display: Simplify data output in
 psr_capability_show()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jun 16, 2026 at 3:19=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >> Move the specification for a line break from a seq_puts() call
> >> to a seq_printf() call.
> >>
> >> The source code was transformed by using the Coccinelle software.
> >>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >> index 4b09a740f205..6e6f391b640e 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >> @@ -1076,9 +1076,9 @@ static int psr_capability_show(struct seq_file *=
m, void *data)
> >>         seq_printf(m, "Sink support: %s", str_yes_no(link->dpcd_caps.p=
sr_info.psr_version !=3D 0));
> >>         if (link->dpcd_caps.psr_info.psr_version)
> >>                 seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.ps=
r_version);
> >> -       seq_puts(m, "\n");
> >
> > Why not just convert this to seq_putc() and drop the rest?  It seems
> > more logical from a code structure perspective.
>
> I obviously propose to omit a function call at this source code place
> because an intended line break output can be achieved also with the subse=
quent function call.
>
> Do you insist to preserve a similar statement here?

I think the code reads more cleanly that way, but it's not a big deal
either way.

Alex

>
>
> >>
> >> -       seq_printf(m, "Driver support: %s", str_yes_no(link->psr_setti=
ngs.psr_feature_enabled));
> >> +       seq_printf(m, "\nDriver support: %s",
> >> +                  str_yes_no(link->psr_settings.psr_feature_enabled))=
;
> >>         if (link->psr_settings.psr_version)
> >>                 seq_printf(m, " [0x%02x]", link->psr_settings.psr_vers=
ion);
> >>         seq_puts(m, "\n");
>
> Regards,
> Markus
