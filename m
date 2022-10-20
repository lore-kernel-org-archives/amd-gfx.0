Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DADEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B91110E607;
	Fri, 21 Oct 2022 07:31:41 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2537210E1D6;
 Thu, 20 Oct 2022 14:52:27 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id 63so24916053ybq.4;
 Thu, 20 Oct 2022 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qZSF0rU/LadxcXivSMUu41VqTSGqH3cS7lnDUCpCbSE=;
 b=V4bzuVfCQb8oZNc1313fCgiGezNI7Q0DGAHlDFbsq8DV9fiyV1nE0FOfGBM7Ra3GVs
 j2yWvCoyZC/1wKa7k8vVGhSwdblPIIEYU0FJ6LzbUk8Pv44Xa4oSSJPAPZCHV+85QgJN
 iFK1PYjlLgLzQbkgkTRKnmrMM4DExs8WD6MePBGzW18XKq0ejyDIem7dOn5IRA82I6Kd
 W2VnNun5T0WIU1nqtozcRUmHyhNI7y/IkqnQMr9ab5ycczyl1lk2IAlxMm01TcWlAuUN
 4RlUfqIuWImjiAS7StfMe210fvnQmuZ7BihywSl9Hf9w6dpHNhX7iSJLv+eDOlIG1UN3
 HUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZSF0rU/LadxcXivSMUu41VqTSGqH3cS7lnDUCpCbSE=;
 b=QB2G+YWmbcewzR6mZyxO2varwTgfCacZRMM5kbZy9OsGRY0F6CWpc2U7IN+OYghinZ
 UkL/pAI7POTCMAgknkxtlw0aZdHWes+L8MJ6YvRWjGmObOQOJKqlo3wXNUyiOpE2mi6i
 LLq+j4P3cj4VdOYUml02XIrwRYSwkBgIUarcoqKM6FTVO52Seqie2jE+KRM+DcOljgEL
 K4ATf6S4Qy8gErJYHNpGXnxQ5tGrY+mULsQxpvLM/bxV/lMNoe4EUNVT2sNH0EzJWeyJ
 sKhYzhGN7PSy93xyKaGeLRyd4wOtsHbD3x7Nx4a8uWljjM18tN99xkvMaxk/AYWX0sDn
 UTJA==
X-Gm-Message-State: ACrzQf3digYxTdb+Yi/fucuQnqvUbhSUVtcI1TLU8h+xKKPu3iol5MwP
 mElLHeoMe7SflCP94EkrI/CkfZgxfJQ5KKa6eks=
X-Google-Smtp-Source: AMsMyM6faIOERk3Qv0Bv0TKrmHhqO1XiIx0BoEMZsPkMj+hZHVLPGppqQbzCt2ntAkW5S16O3AjwZdeNXiflEnrWKqY=
X-Received: by 2002:a25:1807:0:b0:6ca:4e8c:fa5e with SMTP id
 7-20020a251807000000b006ca4e8cfa5emr1100089yby.196.1666277546315; Thu, 20 Oct
 2022 07:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221019151543.22753-1-samsagax@gmail.com>
 <ea5d60cd-8d0b-7018-425e-b91e5750a830@amd.com>
In-Reply-To: <ea5d60cd-8d0b-7018-425e-b91e5750a830@amd.com>
From: Joaquin Aramendia <samsagax@gmail.com>
Date: Thu, 20 Oct 2022 11:52:14 -0300
Message-ID: <CABgtM3igg8+Skj2YNqQN0egctWrLAo8HRrb25UFcbo8+r_P8eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Revert logic for plane modifiers
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003ed4e105eb7879de"
X-Mailman-Approved-At: Fri, 21 Oct 2022 07:30:36 +0000
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
Cc: sunpeng.li@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000003ed4e105eb7879de
Content-Type: text/plain; charset="UTF-8"

Hello. Thanks for the reply, Rodrigo
Will redo the patch and resubmit.

Cheers

--0000000000003ed4e105eb7879de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div data-smartmail=3D"gmail_signature" dir=3D"auto">Hell=
o. Thanks for the reply, Rodrigo<br></div><div data-smartmail=3D"gmail_sign=
ature" dir=3D"auto">Will redo the patch and resubmit.</div><div data-smartm=
ail=3D"gmail_signature" dir=3D"auto"><br></div><div data-smartmail=3D"gmail=
_signature" dir=3D"auto">Cheers</div></div>

--0000000000003ed4e105eb7879de--
