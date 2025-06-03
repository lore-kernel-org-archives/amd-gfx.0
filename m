Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBB6C5B555
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 07:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B71910E6A7;
	Wed,  4 Jun 2025 07:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SH0U9N5+";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9892E10E205
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:36:54 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-450cf0025c0so39818325e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748957813; x=1749562613; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XwaOA2UFIdL6uhmEEF3zq5uKFSYlQf1QNo+y/xH05aY=;
 b=SH0U9N5+MAapHlCBNhGTCugJqwda4xv6B7QQwNLyREreC5/QgXGOe8YANNlB2fx0BC
 UIgsfPtRX6LDKn07XYz9ceMlMaSGXDMFSDttzcu1BQf3GQctL1vsZ/JCo48PVwPmuVZ/
 zAhYKCmA+hJOlgZgXtdoW2Llrj3nu7Lu5Dq92TJSSkk1y9XNuPmCEPb91hagXnhAWLcO
 CObDuzcQYawM7E4BgJsU8GjZVhq0E+XS8QjFs8FrwztkFJfR4BNhij+vfb9isc2ucNik
 JhCt1OFf6kkXJ80ZrPtx7DRB/ZT0SRKsBN7AsY6RTDNxJVlLaJ8SyUzj0tZKzzEmHVzs
 px4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748957813; x=1749562613;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwaOA2UFIdL6uhmEEF3zq5uKFSYlQf1QNo+y/xH05aY=;
 b=TPPpG5VdK55IWWgT8G3+V9O/857HIzRoIjSy7jOssKS9TP96XkJZIZ6BMkag4pMHQG
 mpUf+V2yUB6xLEn8OVlWpFq7hTko+v3fcg8rd5bQfcZtBRoSh92bDYCr/OZiAI9Sylaf
 OW5pfEoLFLRI2Tg1pcXnWKDgVoO48QsAjB7WXspxZKz7XX3m0uWiobcmsX9g+ZqlYvHX
 QpB7xFf6su7NKkYpY0hMGiIQ+D4Vd9iQhry1zPfpHhkY4lDvXpCcWUe5rSNzsUOVZD+w
 wLKkk81FYET92rk2bhIksH9r1TBoTsdVlDhDmCmP+YEX6Q1TA4xFQyOHzZDHoUFQICnu
 XSnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbdJMTZ6oGjpYWqj4AewsFZ7c9U3cjIt6oQJMX1EW8Q1n/kNzbKtEZcCBs8VrbSAwlmbYToVtC@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4ktZhePj5sxQgrPah3bl0n30MyJswco2awCqkZql9gCfqYhvZ
 G71v578sR3J8pou4/BOmz0eDa0+aC90nQ9fEmtZOO9SAqAmbsCnTKuvD
X-Gm-Gg: ASbGncu1tic/JprH8PxYuTRBIlnfdbQpMKC6UaaUQi9Eo/YEIBF4TF3Pw4lHWKfzTjJ
 OSputkIvtZhUJJf1lhD6FvfvJsY6dRlxRzalewJZd5kfIix1RPxACv2GQfOjpMJnUTM8qWWTbSI
 HwWlv5EFOJzeOOg+Kyc0kVbA//5a0VOWyHD6rshEhLn4CMc+xVTJwwjF/XaQZX8q55XqkP5A7Sa
 1JMofSkA9FgzCJ7OTGMgFStYRkGHjYEkld5GfeabyWOghl+sAlIVAbYdEtq0BO5edcoE6e7JGWm
 SwlT9T8rGnDhR/cmw9HiAlVsPPu26IqITuJdXniUO4pfTIXYK9fjEQy1VUHU
X-Google-Smtp-Source: AGHT+IHlffBpVFQtzIlEFJvBh6YUPRlNSnuEKeo8Dt5LtNWl5139bqwkGJfzkGnuetqW1tpQrNzwAg==
X-Received: by 2002:a05:600c:8b11:b0:450:d4ad:b7de with SMTP id
 5b1f17b1804b1-4511ecb9cd9mr122631155e9.3.1748957811494; 
 Tue, 03 Jun 2025 06:36:51 -0700 (PDT)
Received: from debian.local ([81.78.104.57]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa27b4sm159437275e9.15.2025.06.03.06.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 06:36:50 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:36:48 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
Message-ID: <aD76cCE5qyALjKHc@debian.local>
References: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local>
 <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local>
 <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
 <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
 <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
X-Mailman-Approved-At: Wed, 04 Jun 2025 07:34:27 +0000
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

On Tue, Jun 03, 2025 at 03:04:33PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 3, 2025 at 2:27 PM Chris Bainbridge
> <chris.bainbridge@gmail.com> wrote:
> >
> > On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > This patch does fix the list corruption, but the "Unbalanced
> > > > pm_runtime_enable" still occurs:
> > >
> > > Have you applied it together with the previous patch?
> >
> > Yes
> 
> So it looks like some devices have power.is_suspended set from the
> previous cycle which causes device_resume() to attempt to resume them
> even though they have not been suspended in the current cycle yet.
> 
> Please try the attached patch in addition to the previous 2 patches.
> 
> Thanks!

That fixed it. Passed 30 attempted suspends without error.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
