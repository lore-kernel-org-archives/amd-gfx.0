Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BABEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 16:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8538910E29B;
	Mon, 10 Jul 2023 16:41:12 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C21F10E16D;
 Mon, 10 Jul 2023 16:25:47 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-c01e1c0402cso4303873276.0; 
 Mon, 10 Jul 2023 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689006346; x=1691598346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcUxYhRfSgJ6UJMmI4gvN/iDnQgX6gIvJpFELMHmLcE=;
 b=V8r9oUmNILl8gpI7KePWigjGb6juPhMnDQ/wrv4DQP5As/oXU9XrXK246f9ZHhlBJL
 NgW9whpWQvfU7c+x8gRKyIabFQLq8y1KB/91koW4cjzXCsMLGDiimO1rnhQ4A+SGtHR5
 0qPaQafXZZht0IpaBmneBm8MpeuLhudZwHH96ZviOLxHsfACKzldhpgZodjAA0l922q2
 pnlbiw/dn1xzxjuAiZWozy6KLAqPUfb7KpDVMBORNS1iEcJq7uIR6HeZQpCMJbhktMq6
 tW+actNpC+n4lGbQUGm2PT9us1+XZ/aHXZ8LEEsgbXOFg1elQLdqT5ptELvD1jDfTUxq
 L3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689006346; x=1691598346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcUxYhRfSgJ6UJMmI4gvN/iDnQgX6gIvJpFELMHmLcE=;
 b=SP0cYQvfs+DHaoLdSQncHF/wMON9NzIyvB6F6LXdCz9OAWhKk4B1G8tAsfJ6Sf/M2h
 SrZzeF64ZEcUasp0M2KUty/WL0N9cwom6ohOMLAvw6cPoa4Kyb/wf43HrPcr7MJORFHr
 JMkNSAN4Aicz2EfU4e+8pI2SghDmgzkHJOCL6K2/VtVq7xm94g3DtCJ5LiKBmlpbDV3a
 t0XRBw90hhFXkMM7kOkmjlU7967h2WqTOJzwipk2RFPb889x9BuIJfm1TxrlpQtvO7Hf
 KdTi+8XPD+J3QAhPu9jnnPkOt+3Na7bPAVVh0xwFACBzbdEmMv1jISM61Ig77FqknkSd
 HHEw==
X-Gm-Message-State: ABy/qLYP2p4xcjjCbrwI/tCDbiJwKOtPJ5yrTB9obsh8xUREjAeCyobH
 PK+QBNBqXS9UkE+XyA+hfK+fvs/wNHJ7bGDxf5Y=
X-Google-Smtp-Source: APBJJlE/krGaema6oAIGHffoO9jr9rNxV2NJ9f2ty64/UeXp1MrrtGwo2Rtyks4ROqL/F/KxuN96NsyBfRrrBujlbXI=
X-Received: by 2002:a25:c0c8:0:b0:c86:55c7:d053 with SMTP id
 c191-20020a25c0c8000000b00c8655c7d053mr2292204ybf.25.1689006345894; Mon, 10
 Jul 2023 09:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230710130113.14563-1-tzimmermann@suse.de>
 <20230710130113.14563-10-tzimmermann@suse.de>
 <CANiq72=9PoV3FOcXx9FdiSLePKXDG4BSY_5-jddBkqDL=ua3FA@mail.gmail.com>
 <733273ad-89e1-d952-37ee-bb75c3ab8188@suse.de>
In-Reply-To: <733273ad-89e1-d952-37ee-bb75c3ab8188@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Jul 2023 18:25:34 +0200
Message-ID: <CANiq72kPh2KE=ADUxhPyyr7noWhC0fkzmDu8EBn_20focnZqtw@mail.gmail.com>
Subject: Re: [PATCH 09/17] auxdisplay: Remove flag FBINFO_FLAG_DEFAULT from
 fbdev drivers
To: Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Jul 2023 16:41:11 +0000
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
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-sh@vger.kernel.org,
 Robin van der Gracht <robin@protonic.nl>, deller@gmx.de,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, linux-nvidia@lists.surfsouth.com,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 10, 2023 at 5:22=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> I'll append a patch to the series that documents this.
>
> Sure.

Thanks!

If you are planning to take it into some other tree:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I can take it into the `auxdisplay` tree.

Cheers,
Miguel
