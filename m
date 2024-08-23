Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50389C54730
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 15:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09AD10EC4F;
	Fri, 23 Aug 2024 15:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jK/CLqdl";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD22C10EC4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 15:40:47 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-533488ffb03so2598373e87.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724427645; x=1725032445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwzRr4x14GDGGx/Wa/l1KFYgNdRnrpk92o9I32BcD1M=;
 b=jK/CLqdliq6JD0HiXix1v7SJxNhay59PgU+ENGGzIUpqIVmUChi3LB6xKKlEecVGXt
 G9EU4CFGpxn9Zgy14sGIPIYrf1096DhEgUW4P/Hh4ztGmUrMIOMzB27olEc+dAbZwPGI
 n8ex1k7zyc4Tp18uiwTXm5IrWnt5huTKY0rg4El6AT+CmflavoUj25vG9V81oTU2Dy+q
 9MhPAKiyaIq4syLeDlIajRhfbEWKBaiKxZ1+7F76rqXnP10bGisa66nJm5smgIZrYnKs
 Ql/EE3yw58ksAwb7Mbatkns8WgidziLdzwQIb22VF5WAi/k6pblLVI9gVcpGL3oBj5fn
 hB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724427645; x=1725032445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwzRr4x14GDGGx/Wa/l1KFYgNdRnrpk92o9I32BcD1M=;
 b=Y4RAhKHhmEB/EU6sdQVxx0nhATMojj2dBalZcIsfJ+HEb/pIqdoK+bO9P0xoShsuxC
 kbMqMpJSp7q475zUwdOJl13bq9dJuyZM5hK1D2SSgbUOACN3jK14x2NnszQsxlv9wEg3
 Naf03+Fbwr/zjF6qnfipk9Dd4OcftWt7ToAHJhRBjUhMD2VHrGAgUS34f0OUbva+dy3q
 0YqkRrwJ6UNI0VxIOdp/GXwHiJ5rrPlN22X4n5J8DVie2IGtGvzhksuN/+Oo9C9JFhAz
 avkztH3GSPhqfjBHiLim1A+7b6tQmYClGWvs9m3s3WdppS3AB+0XFWbn9yKegCJoSQA5
 rWAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrlcxhIVmrvzIBHcjGZDRQxnE9aqydOb4573h6vu9+6b8nr5aT6r0+LAKc7DuAbG+ktT+zBUcc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUCBpRNx2APMRBBDivMKYW1vvcltDy4O/RBnc93YhkAbM64GiE
 GdUSrlTBzWOtkrruIAUy5Y4n5zeooAhGP2KUHoWCA6o85zizqoJ0vmG4dVxFHlvjqEs+OOXGxh8
 0m5z1+PiR3jZzfVt4KHw38mViNUQBU4aq+Wl9bA==
X-Google-Smtp-Source: AGHT+IEuHaxZyQVY8GiHyyz26//af2rggIRdx0JBwtmCQ2Md+VVAhtl7TbQoqqnfxbLsaA2wMwGIyh7yHw85tqG1pcI=
X-Received: by 2002:a05:6512:3a8d:b0:52e:76e8:e18e with SMTP id
 2adb3069b0e04-5343882e2f7mr1898837e87.7.1724427645064; Fri, 23 Aug 2024
 08:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240731122311.1143153-1-tzimmermann@suse.de>
 <20240731122311.1143153-4-tzimmermann@suse.de>
In-Reply-To: <20240731122311.1143153-4-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:40:34 +0200
Message-ID: <CACRpkdbOPGxBFq4FCOPLMfvaEJZiNHCocWQGZwC6fis+FOxjTg@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/panel: panel-novatak-nt35510: Use backlight power
 constants
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
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

On Wed, Jul 31, 2024 at 2:23=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:

> Replace FB_BLANK_ constants with their counterparts from the
> backlight subsystem. The values are identical, so there's no
> change in functionality or semantics.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Jessica Zhang <quic_jesszhan@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
