Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43475C3A59D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 07:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F0F10E277;
	Mon, 24 Oct 2022 07:13:33 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A84210E1D1
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Oct 2022 17:24:12 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id t25so4982888qkm.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Oct 2022 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CFEmF23TE/KPW9DxQX3TtUFPLdftcyFj+7wIfV/ySrk=;
 b=Kh9q+3eQ8nMIGJcebGwF6XwmXd4YARrcFepFisWQl6kyl0rT+3DS9w5veA+nBflWs5
 7E8PL3tnQaX+0hJ48oNI6L0FtpCgy6rc4pXq6MMfr11scKo/CY9n3lAz4qO1wByCA3R0
 JMFM3i686ZVXh+oi+6JXteOyMAf7MHyE39skU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CFEmF23TE/KPW9DxQX3TtUFPLdftcyFj+7wIfV/ySrk=;
 b=IATB4p1hSmylaMxItrMGlJfUoxWDMbnWLN0u32N1Tc9CbaIrPvKDzuWUW/umBhk4VF
 lvnfcuwnlfmGe/dWNRwv2xOqoI8GqOaOif8Z0Ppv5/uPK4aMFlHGwZ29iV2yFTPbgF4E
 SoJPxc/4XA+6/NS3r/gqGgB2TNo3/rhfhvN2WkQDp7vOA+sNpjFTUsPPjbFe2GOtxfM4
 o9s9q9LYwRgrzYKfe4kd3cKSE0Sb80+otujS68+0MmdFtIMyuX7H5cg2TG54hSleNs22
 KYI/PuVWo6hP4Kq50i9MCAyMSnHA96bh5lT2+JP2zG9Wdt1VkuoH41vr1JHOZ25MsHJA
 s7Cw==
X-Gm-Message-State: ACrzQf2NWw/Bo64KPptle2KAwGONdqerTi/fGuTQAQOO03vy72gPL+ey
 UNLXxM4Ipq1i6k45AYpMkuV4q/k7b8BhfA==
X-Google-Smtp-Source: AMsMyM7an3PM0ZSL0xJOTaP3Q7HurWiax2QJVbkROZHimvBHHKuNaDlS/whAlLprmyEP+jBFkR+jAA==
X-Received: by 2002:a05:620a:461e:b0:6ee:e645:662d with SMTP id
 br30-20020a05620a461e00b006eee645662dmr20541781qkb.631.1666545850963; 
 Sun, 23 Oct 2022 10:24:10 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com.
 [209.85.219.181]) by smtp.gmail.com with ESMTPSA id
 h5-20020a05620a284500b006f16148fa96sm3195332qkp.91.2022.10.23.10.24.09
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Oct 2022 10:24:09 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i127so8758463ybc.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Oct 2022 10:24:09 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr27003391ybu.310.1666545849226; Sun, 23
 Oct 2022 10:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfT2tdZN5s4WEG1q=VCOK7_1vgb6B8VuL+Jw3UqADMxerRMDA@mail.gmail.com>
In-Reply-To: <CAAfT2tdZN5s4WEG1q=VCOK7_1vgb6B8VuL+Jw3UqADMxerRMDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Oct 2022 10:23:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghzRGZtwCU+tDSRGD2HC_7dMT6rnU-urD91gz_AkyCTg@mail.gmail.com>
Message-ID: <CAHk-=wghzRGZtwCU+tDSRGD2HC_7dMT6rnU-urD91gz_AkyCTg@mail.gmail.com>
Subject: Fwd: amdgpu: update from 5.10.145 to 5.10.146...149 breaks boot on
 Ryzen based computers
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 24 Oct 2022 07:13:29 +0000
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was sent to me, but should have gone to other people.

It may already be fixed, but note how the report is about -stable
kernels, including apparently the current 5.10 stable version (149(.

              Linus

---------- Forwarded message ---------
From: Kevin Torkelson <kevin.torkelson@gmail.com>
Date: Thu, Oct 20, 2022 at 8:09 AM
Subject: amdgpu: update from 5.10.145 to 5.10.146...149 breaks boot on
Ryzen based computers
To: <torvalds@linux-foundation.org>


Linus,

--- Possibly Important ---
I know several people who are crashing with Debian Bullseye (stable)
with the most current kernel put out by the distribution. AMD put out
a fix that seems like it might be related here:
https://gitlab.freedesktop.org/drm/amd/-/issues/2216
