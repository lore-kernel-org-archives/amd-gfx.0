Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09BD606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFITT5d5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905DD10F5E3;
	Tue,  3 Nov 2026 14:30:52 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD3E10F5E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:30:47 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36a6b774d12so328159eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 06:30:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793716246; cv=none;
 d=google.com; s=arc-20260327;
 b=CXjNhfqCNYEWFlR4SWIvxbbFvUCuaCpAGZqD4dvo7hALFw5t7rPLJ9/HOvH1TgKNf+
 xu2g1VpEDmHprzk9bH/vNKHn38PsnhzadYDjrZ5pHbLS+NN7E2350rp2nCmq3jX2TRmG
 qh3/TC7N7FsRvLIds1G6Czej2Enh2Dzl0B5kUJEkJ44xD+wa6j58r6ThSaJd/W8DXuUT
 oAngmwk/S5jIbjLpe1JcEHYMZEwUUil47FHjv/D+79PyU/SMh+n2Ug4vy/kr6fuO07GT
 RKnIbU2PpxWUvTXEc9n617tkBWzQXu7nkWEmI1Qov2006M+CSyZKCQjKeOPqdOaNRrn1
 GEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/OyNH4m47qkiBrtBEXVKxPfbZI/Pm865e0NtmQba4xg=;
 fh=09rAGuKY6oA2KouUTgHQkGbExQ/ewRvzOJJfNO9lXQA=;
 b=qzFKpm34oLRGsIjhtJk3l3Y8G3qJzbbeXAtL6bphP6tFbYsxjp7qQ3je1ddZHW7rZh
 nlP/ZXXKWjRPhGEglZnMGhWsWETlLd4cIDLcPERd8s2pYVhlT+NX70m879rcmOCfE9o4
 wUioWln0e4jFN5pl4nfVvuif+ev7KSpY/oQ/20DrTcBOvDuJYVvy4VnIFgdmeIWCv5Y9
 CDzOw2qn1BJ5BoPAsFWtf6q3f/6cZW0gwtHjHOnZEy21JQcGgKwOH47awJpkd31NafOn
 u82YGWavJ57c6ROWgejJdxpkMakMxbVU2jXygnfyakeXInX4fRGhx4lHM/O08uZ7TC1F
 HfaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793716246; x=1794321046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/OyNH4m47qkiBrtBEXVKxPfbZI/Pm865e0NtmQba4xg=;
 b=NFITT5d5DfgrMMdtdmPlq335LGIMtC/4PSZHttnrb4QT9/6QSXFP2/I/q2z0EP5Fqo
 +IlIUJLGtBfEq81QV/dcPwZDg83fJDxEETuSk3lY/qpQO+Bq20dZ0k9kXpTCrrNBjOTP
 XF3yQ5X8rQlf2TP3c/ZBGh3PYz0dhAsaHf6oPe1LtCDkMpF13d5vPv+9+eH//RakaQlp
 yFAYAUwUOCyCZDL//qgcVjnE9nKuV0pOkgweqRmBEGudVqzLjLkJmfuoXticoOUqO9m+
 oxc2Q5K8pLYY3m4Tk5s1e4pVLb2r5Aj4NL8zeK5GMUmuDuzbdWJQtLindgEXbeaI4Qas
 SG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716246; x=1794321046;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/OyNH4m47qkiBrtBEXVKxPfbZI/Pm865e0NtmQba4xg=;
 b=R2GXcYAH34wC5zAB+hzdzQIgsFD9BcI38ZcLprxJ6f1WqW6CS+BlmONgPEIQModLk8
 /uVrwU+MmjChj8xNC6T9UXQIntV4kVGK15K/3cTuZ1cJVl7UVYc/t+B/gWHMrvme2RIa
 PcMwnpPRCyAV38cHIyx5smwy1qncjX6bZTAoKCnzzkE/piXCcmDK/oehh5DehLprnqxr
 zD0sv0J7RvQsrx/GI8hpKP82lTmj5Xy1VnQQfnZ075WGWHVvjvmf6meIN9L+GpTpU+6B
 6T1tAB2UNXxwoGKnBgZWKwuCZsnseWbA8+pmB3zicAYId7nRy+un5A/MdvyESzLws16L
 WK/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByODf/j0/KX6zHqQAsrJPijbjwYxsZQx2dQNvIYw57ZROPx6U2Kmyhdwj7uocCUpeDHcLPFO0E1@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vdrBs/jEyP7hFyPEPuFuKbwA0BwAeQ1052O4cEFsM5JLJ+Zbx
 juBMUc6Zys/MQvyC7bIUDwUowdaVeCfVqQ+p2V+II9jQTGZExyoay4gk+TgVaNHYn3vSakVXkZd
 qB3IcdYvtJaWk8romBVrGLh/wj0rl5X8=
X-Gm-Gg: AYBFou208+F7bQM+cmCkKVQ03URfftnnA5sozV0PIwFWxjh75f7QKgFejrGP9//RhtO
 NdKgfQFE/jOQTFH6Z9uZZ8vUUl/eIOFiUDp5I+dCPoNZ7725vn52u59Umb00JB7PhmKHAeXOthn
 9uUMXW8PCorKPlNk1rwUpYmyJMOBtMazr1UD0EQ0980vZX6s/NbomRLplynY+IR+mOzRnP6wmpC
 wLka9/q2+1+n8QqYFl2LFk8Sku6cvob/RHHbrbDHcEFycnZCt4x/ROTdM8IGdWlsrslBzq985j6
 bcxsDc0Rn0b0Qv8b9s/LpyOCvGiqJo9uSqx7r6NR/gCtnMSGSNGH2MJ0Bcd5S+E6fECWU+0DwSl
 EbTuAX//91LfHnUkfK8vYsfDUXOF6fiHS+Ktz/0XujgHiq4AtBr8E/oSMwyz7PNqRspfC4glKrZ
 U05FTrDpCZDh2JFqyTdyuFMnY=
X-Received: by 2002:a05:7022:eb46:10b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1ac4fd01362mr31568742c88.0.1793716245958; Tue, 03 Nov 2026
 06:30:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260916144014.879355-1-ed@aicharmers.com>
 <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
 <20261030123000.5573e70f@kait2en-mbp15-1>
In-Reply-To: <20261030123000.5573e70f@kait2en-mbp15-1>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:30:34 -0500
X-Gm-Features: AclHuK_LxctmigwVoDcx69kjcX_YjAvRxU28VYR1bNj9rG5Y2V1BrN_dTiv7lGw
Message-ID: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: =?UTF-8?Q?Andr=C3=A9_Eikmeyer?= <dev@deq.rocks>
Cc: Ed Schofield <ed@aicharmers.com>, amd-gfx@lists.freedesktop.org, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 7:30=E2=80=AFAM Andr=C3=A9 Eikmeyer <dev@deq.rocks>=
 wrote:
>
> On Thu, 29 Oct 2026 17:57:49 -0400
> Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > @Andre Eikmeyer I think this patch should fix your system as well.
>
> Hi Alex,
>
> I guess you have seen it already but the patch doesn't match the 16,1.
> Its boards are 7340/020f and 7340/0210, and v4 only matches 0218, 0219
> and 021a.
>
> That hang is what I sent a fix for
> https://lore.kernel.org/all/20261024162109.307247-1-dev@deq.rocks/
>
> The VBIOS trains the UMC p-states at different frequencies the pp-table
> lists. The SMU hangs as soon as UCLK switches into level 2. Deferring
> the UCLK enable doesn't change the levels, so the hang just moves from
> boot to later under load.
>

It is the same issue.  I don't want two fixes for the same issue. I
just sent an updated version of this patch expanded to cover more
macs.

Alex

> The two patches can coexist after a trivial rebase.
>
> > ...your system...
>
> I need to clarify here. I actually don't own a 16,1. But I maintain a
> distro (KaiT2en) that specializes on T2 Macs. So the patches I develop
> are extensively tested by the community before submitting. Atharwa is
> part of this community. Ed is not, but Atharwa reviewed and tested the
> code.
>
> Best,
> Andre
