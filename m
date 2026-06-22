Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078D9CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F1110E493;
	Mon, 22 Jun 2026 04:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hg+MtQwM";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7896410E491
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:47:01 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-91ae31bbaa9so359197285a.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jun 2026 21:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782103620; cv=none;
 d=google.com; s=arc-20240605;
 b=VIOACbEZbzVNXIporcf+WM6ywVqv7z1lTYrr4cbWogYnZEzhqzbY/Tk8w+QcoGouCa
 o7T/BIZ0J26Ll7RFM76CClXz6XNzSFT5KgxepWJDDelGIOOV7dpq5jEtXpI5eYUBj3X1
 wjnJy4rXfxVeBCV5VfPZShtAjpSe0qWuDyvsRrW4Q/Cfr4GEuebB1ZBekyl64jEwii+I
 Mt0/777MO6qnT7PTj4cILkK/dNDP6zHKGiVM43H0D/cV4oQpCD8UEGN0QxNNED9U5suG
 0MyRJMHzeRK7UmrV07na4rjO5LSQK5U4obh6M2sy62NZVED4Ah2HaJYfgTPPn+hCvZU2
 nq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=8g3hqqz068tHp9tVo2PYj7hm9aO3fiSU+NWoJElXV4Y=;
 fh=CYcjSQC70NYevaflXaGiGHemJt27Zp7lga7WMI+/NmY=;
 b=E40EAEE9DvbRy6mAUkFLi27IEaU9vVbEx67Zx6OOP9lvoIPLGgTFTn5PncdeZZcyYo
 DDtWfWUvbKW94irYA8PPiV93awvNICyEtzAqA+HoOwtomwF2wd71vAyTnwpw6ApyGmjd
 AOHgJLf30jZ+Mlv/9ktfz+jWqlSSdy1nQLk8pOVSNsXD88/up2ui1IOW0DxnrNTAPvxD
 87kDcNpP+hdtVOsVnVKEug5YeQKAQZejy+uIqi9Uo8tZ1kqZTOylsjHmCMT+1Vphg6ZR
 KLZnTnfVtKHKGtZXTaXlsuRW3LuIwDth/h2q5xCboCcgJQ0nRs1yh/Wmk6WfVNoGIO1l
 z7lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782103620; x=1782708420; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8g3hqqz068tHp9tVo2PYj7hm9aO3fiSU+NWoJElXV4Y=;
 b=Hg+MtQwMLFmyJLhZz8/NSF1mz5OQ9WWwD0KIiIG9tV5X/6Sv02ylIp5LgZnsP6kXBa
 yyT0hlm63U550paNVQStwxn+Ooxj2wNKv0yW4fIf9lIFA2kj8C6oR9Q6OGbaUrZhEB3i
 FZruh8Te7Z33JYycO/dFlOdcQDQqNY/FOLE1NHrkJNS0YrOctRds/3kOu2b1Kg4O/hh0
 kl3hcEYbmxoa5qDKQDcOJbcnpefSIJ3FF8eD6842HPaks+H5v3RMLCdxN4K/6HF4qjxX
 EGmE4gKriKv6lcIE6bfMZoQPS4ugIlZ5nuAK/eGWG5+rlbNLlHAd7kzGkUcFmoC2RYJY
 hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782103620; x=1782708420;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8g3hqqz068tHp9tVo2PYj7hm9aO3fiSU+NWoJElXV4Y=;
 b=Ir1fFOWVmSHJBoK06QKJCCLdwyOhGMSqus0AVo0cjD3q0cm5/Kdk3R0mCz5V3/y8dM
 ScKOnK1HGcbG1Uo0e30pd6QvwdvKIsTTDYGtML/l9H/4CGd7AsoAjepfhO6ni2epWue7
 gPFEawateayKF22V7Yvs21d8UOja6+LTpFTlnjhHt+f9E7OwuOEKw72rttrg1E+e9uRl
 /8UFxjYElyjJWYwMLG+MZTF7JP+FiY5sF1mIBOXxJuOWGmriigsQjZsgphzxX9sWozuR
 ZiscQN9DPuCioVWPmo7/WK4WIz0OLVnOObqIIrnGQcOTgkmYElo9sY7bHihwJj4gq94x
 8llA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i2jTAY6ofdY2bfFf2jgCr9p6GDXF3SfEjKBHAAJjluBbE2AxwVvOFEi+Zpu0AZ4bXsgRaduuL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrJ1LChSxHQiaxGMUaeDM5JwAWLx4HvEn9UnJ9U2AkWl19Oi4d
 q8JkZ9VXYoow1LW5xuwRy1/bVICo3LGlLwNWFRHeyFNaUlfNCdvBDkAmtuFFMI9ZulzoweBY1VN
 VWpht48cqeBaIrIVnR/TqWN2Nr4zocPw=
X-Gm-Gg: AfdE7cmuiUYDnrSbieLxe0DDIJDPOV6L50iQTvh3WV65QV2DHpcKtaww+0VijgU3CJw
 XEIJvIV1ElHvsEuMUpU1hc1NltISSmFlXUJWd1Wk2RJQuruXTNgC6Lj1zKf/myG03TMHLSkfE3Q
 HD/6nSIQIMcJoVbd0LPa4NfWeGjy+5TZepoWHWPeMUSqbJc3l557kazWeXwf8po7D+PM4F/djdz
 HUMIP3eCqq2e91FB88O1e8CD9XV4P7RFiDHhbZdzHmdFqumr5rnyv4m2WLhrXnMsQFJ42W9M4sa
 MmNZ50D0U1d26NdN3cQudDmLmJ5tVAh9dfZoLXHRbzgFvL3WKfgCkw+3ww==
X-Received: by 2002:a05:620a:290c:b0:915:b9f6:71a2 with SMTP id
 af79cd13be357-920d4fec71amr1839799585a.48.1782103620280; Sun, 21 Jun 2026
 21:47:00 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 22 Jun 2026 14:46:48 +1000
X-Gm-Features: AVVi8Ce2wb8elBNaTluaukjjB1Q3YO-s0ZlkjhsbMmTV2qjA0IBiwLBBoyLdiMk
Message-ID: <CAPM=9txxjsBdQA6HBmUgkT31bNzMizkEzqksA5GJq=n9j+txOA@mail.gmail.com>
Subject: kfd conflict in drm-tip needs proper solution
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Yongqiang Sun <Yongqiang.Sun@amd.com>, 
 Andrew Martin <andrew.martin@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

I merged branches this morning and hit a conflict between

commit 1142738572ef3fcf8b169f1c48d94b4a71cc2d97
Author: Andrew Martin <andrew.martin@amd.com>
Date:   Thu May 28 10:32:52 2026 -0400

    drm/amdkfd: Fix SMI event PID reporting for containers

and

3b347d011773d147b62f84ec60a7824629148be2
Author: Yongqiang Sun <Yongqiang.Sun@amd.com>
Date:   Wed May 27 09:50:47 2026 -0400

    drm/amdkfd: fix SMI event cross-process information leak

In drm-tip right now I've had to effectively revert the latter as it
is not possible to pass a pid/tgid to kfd_smi_event_add anymore.

Please figure this out so we can resolve it in drm-tip properly.

Thanks,
Dave.
