Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E5EC27C5E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FC910E479;
	Tue,  4 Jun 2024 12:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="CRvrhF7A";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E964E10E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 07:56:06 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so6304326a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717487765; x=1718092565; darn=lists.freedesktop.org; 
 h=mime-version:user-agent:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2nmZn6mS3jr8gnhosKI24iS14d0rSG1CXX7KP6yM85Y=;
 b=CRvrhF7AUYTal7W5O1c/vUdsst8iGvoVNBS1QGkcaV46mYw5an7wP3GWdAaWbLuNMA
 4j0sKu/qlNxCSdz/Fp6OcEdxDlYv1BoYdV7QB5qTtkjO2FGB1uoioIWww/ES25v1BTCJ
 4R8h48q26RGH4iXD+m27irhdWrRrrZxF6b1H4SPs/QdAESKH9+fXLG6fRYF1ne0aAxz3
 RZe8TVDSnJygVgObuhhdBMHz8aUnjt7YwYmK6LH7/TnTaEr5BEbSR572T3IcdLdpLkuy
 AqEJvKTB3v0jrbNC9V01l1ewyH4Dk3zUTh36i7pE9MBD6gnUOr0Y8GsQQqevkMxBiy2U
 FXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717487765; x=1718092565;
 h=mime-version:user-agent:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nmZn6mS3jr8gnhosKI24iS14d0rSG1CXX7KP6yM85Y=;
 b=KA5wC3zYmK4JSw4HgsNBThT5Wc+uRfrBPCCjAeF3NLokHmZNU+XSCmiDHmuNJXCq7F
 O544DweOjSlfKey7dx93h8eCOp2NzmezJjjn1sh0C5Nh+iD7ek72HrmYzoLdbvvpvLkb
 UvGqI/BkRdeqNp/erUJlr8wc3GgOyHw7ov/B5o/ujwgpty5yEfpd5brf2wvhwWAPC/NL
 bsGM1bAhl214is7MOR95zqNdAblUYhyX2Zbp2ijyNhzHZ0jWK1wmdn8s9u5G1IdruHYh
 ArpjAsanmiP57wTksnYjaX74nhLLKEa1Q9hISui7OnYoaG8OSr2BvpeQLbwknZ5CSwa4
 3DmA==
X-Gm-Message-State: AOJu0YxEB0mCwPWSZ28MG6CvZNh9kAkVrV1Cp8aa8kqInDrVxcMsUa41
 /FhoLXA+VWJ7JI8I00a0HHeFW/yKkcFObKR7559fCl/nGL+kw4JRPc2Zj8CMSZk=
X-Google-Smtp-Source: AGHT+IEAsmTj0bPkIU7NwgtrndKHWmtNg7dXx6TCj/IOKNVSzs8WbF9Gb5E/dzHooV1khdM67yfapw==
X-Received: by 2002:a17:906:2713:b0:a68:2d37:fb59 with SMTP id
 a640c23a62f3a-a682d37fdb3mr789958566b.14.1717487764873; 
 Tue, 04 Jun 2024 00:56:04 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e73f9a81sm585525966b.71.2024.06.04.00.56.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:56:04 -0700 (PDT)
Date: Tue, 4 Jun 2024 09:56:03 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.com>
To: Li Ma <li.ma@amd.com>
cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 yifan1.zhang@amd.com, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: Re: [PATCH 1/6] HID: amd_sfh: Increase sensor command timeout
In-Reply-To: <20240522062916.705147-1-li.ma@amd.com>
Message-ID: <nycvar.YFH.7.76.2406040955400.16865@cbobk.fhfr.pm>
References: <20240522062916.705147-1-li.ma@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Tue, 04 Jun 2024 12:47:57 +0000
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

On Wed, 22 May 2024, Li Ma wrote:

> From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> 
> During the initialization sensors may take some time to respond. Hence,
> increase the sensor command timeouts in order to obtain status responses
> within a maximum timeout.
> (Li: backport for s0ix issue, these patches have landed on 6.9)
> Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> (cherry picked from commit 333861f4cca6d2c959ca2876587c42767853dccc)

All these patches seem to already have been merged, why am I receiving 
them again with some strange metadata?

-- 
Jiri Kosina
Director, SUSE Labs Core
