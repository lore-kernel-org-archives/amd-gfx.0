Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF12EC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 14:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BDAE10E09B;
	Tue,  8 Sep 2026 14:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0ZzOD2n";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135EC10E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 14:30:58 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8523cc3d76eso240271b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877857; cv=none;
 d=google.com; s=arc-20260327;
 b=EzcZ8dl4hZvsP/2UpD8sf+h9awL6tnE93lRXFu0/nYlCIjjHB35kFl2kXMovNUbaf+
 Rgyvvtc1ilD/1bK5XL/TjBtEwQR6ktng989g6D/DliKDhIW5ceXys+ijRLVoWv11MUAx
 VzcHuDo/IQ8sWxs8o+7rCxS9hpzZC33PHBTw0suifjGD7LRGpVIwYaDAN8vqA79vRrO4
 +MbTAkPZpbN6XrpndkSTfAOT2rPxQ5NCX+xbu0zXijKrgpvTxc5zVTAxzq92cOAhrxDm
 gEBjg9oW+wiW742faKa+tT+xmKglJHJ6NwoGx5lozhzy1KbVFK5vGdgj0EOJwVcLRoLi
 KDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ONrg+ixeE+npwl1waDzdomaITThLQI9+1cKhJ6k/3o8=;
 fh=pjLESlSgwRh3/1a9EnCt8AGN+cvbnxOhw/jX9mvVG8Q=;
 b=gxfj/M6EWmv1K0q6Mh5U7XbXX50UY1uHzTv/M7lThxJYGzL85bJCvN7YayGKtKoLNM
 kwzRDMdd4UW/tf7RD4CgS/6IyDLewieKzBperZkiBM8+bzscwHRi9V5dP5lQ9vNaCNoR
 /flxuiG4vEZ75DvzalptgqzhNcwNVMSEzb4WvllUln5wMcXuWnYY8tuBAapUj3v2JT2M
 N1luGOzZvOrXZSliH9KQegSkbcOCTw5mkQmpjloQfaiElSiQVEd5mCS13cLSgynYuezN
 amDM4WPGSkdJPF/YoIPViXOE31EjyX6AcxZ789gTj4pdoZMmKAIb7qUtW4Svb0SFIJyk
 /v5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788877857; x=1789482657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONrg+ixeE+npwl1waDzdomaITThLQI9+1cKhJ6k/3o8=;
 b=d0ZzOD2n43H3FBN5IM06mdMdAZF5heg/DiVb/QimjztjhiTY4+H69VKne9vOsRD/ey
 C57w5fb/vkd4YSiIEOi2gntwrZjCryntHoEJGsxY7N7ImG1wzzkafHa56WEXvbzY2PZ+
 AUfk0EoAQHmHegTHk33kwx6VtfbC7zO5Fb7ppzL5gvyhwANrpPjjZwgC2cngEdUgtU1w
 NKjcsCBZ/kOcEnTsDC401h3xJCswYD6e16HTaoXSv8l2sQy52XwNUQiXkx5a/rR3kf60
 rmz14TjGsD9JxRVRSZwpj8IHci+wyQ8LjvkvEo3/tByndKCEkka4qzJN6NTPsqN8t7yY
 cMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877857; x=1789482657;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONrg+ixeE+npwl1waDzdomaITThLQI9+1cKhJ6k/3o8=;
 b=VSVPc5Hv7plJgZwMId3Mvkyc6iSZtra54Vkgb/Rv0U56f3R3RICYZyvH8ZXPkrznEN
 Yg54a5D77CHP8W7KZJHJjuCaCe1OJKKzBFTlzYIh92ngaHb0ptR6CJGEDIl6x5VkqHY1
 okIQnfnLPMyzvdO23IKrtHJuix1w76MSBBhMhPkTFoZWyY28LLDskQvc1zcyrhJqUdoO
 dYghE1hlHpYYZtvbdSwrH+hvaYYHk6tma5Ccs+nKl8ZvNtnInfvm50V19MHppm4CvTdZ
 K0EQZhGby/Ksa86R3o3TWmdxrwHY/4idvLJ/i/DCAmuJwZHccWTjYcRoyTu8kSYVeWku
 1Z2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9hiJFjW2xkpvzcA0rOScgR+iLbp836QCfHaEPuJyBvGjOTaW+9u34Asz8wRkG7qCvluHxwLwz@lists.freedesktop.org
X-Gm-Message-State: AFuF++lohoLFLNcQhHhqpJ7H2it9Ih8Sqc3EARb+cfihJAGwErKXUQQx
 g0tckHL4H/thBXxl5BsCvvIgtsn8agAyDCP3vWVAK1fcn95NTzPrBkNxpkZlSJYwTXwQFgdc8vP
 7jF1XyezD3CrXgo9jwTJOqo96uqVVqhtMqA==
X-Gm-Gg: AYBFou2Pe/5QDl/M0GtOEycPcjK14NLikxaQHU0lB9pc3A09cJ5FSCcxSIwgaWxWzLd
 evagPnQ4gl1biottQG/2ZzKxuQmd+esrtNXRW9CVgPG53ejpQk17NCI1fYoUNf2yuP9gSJH3njT
 n+a0TAZBSvDr1hstPeo1a3V71dapcSeZoexqRf900yN9HF4iw0cEVwFizOFv04eWp5kt2DtZ9P1
 bPcjsOiKigK2ImrKeRa/lHqBcCcE4tdR39nfqP9hzJcjyBtbuxQkmh7427nbolihVny45qzEMFO
 /OoiDbNZlgM+wkZArBS3vKezWBfIf8F8osDJPdyFIRPzGiwamSnQjl1jSzzbWqnumeWHkLU2HY/
 eO5XNUTn9Rr//usCsHMisfO0gGieqvO4=
X-Received: by 2002:a17:90b:528c:b0:38e:7069:7117 with SMTP id
 98e67ed59e1d1-39b3d3f7890mr24314330a91.0.1788877857404; Tue, 08 Sep 2026
 07:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
 <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
 <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
 <CAPM=9tws_bMnxt9QVjt4bP_bO9YM5h2n4FtNZMg1p0ZLsrLw5g@mail.gmail.com>
In-Reply-To: <CAPM=9tws_bMnxt9QVjt4bP_bO9YM5h2n4FtNZMg1p0ZLsrLw5g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 10:30:45 -0400
X-Gm-Features: AcwNN1W8K8dzDY33k3zIoH3vtY8e1CWQdy1FWANClREVCmYHU1Mq0Bl_djRIt1M
Message-ID: <CADnq5_Nt97pLDz6V3hB8CBSDcKA1OXiPnLP5USnN5xj=1NYDMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: Dave Airlie <airlied@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Huang <Alex.Huang2@amd.com>
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

On Tue, Sep 8, 2026 at 6:27=E2=80=AFAM Dave Airlie <airlied@gmail.com> wrot=
e:
>
> On Fri, 21 Aug 2026 at 07:30, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Aug 20, 2026 at 3:30=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> > >
> > > On 8/20/26 09:28, Rodrigo Vivi wrote:
> > > > parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection move=
d to
> > > > the common EDID parser, but its declaration and KUnit tests remaine=
d,
> > > > breaking modpost:
> > > >
> > > >    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] und=
efined!
> > > >
> > > > Remove the stale declaration and the three dead test cases.
> > > >
> > > > Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from=
 common EDID parser")
> > > > Cc: Alex Huang <Alex.Huang2@amd.com>
> > > > Cc: Mario Limonciello <superm1@kernel.org>
> > > > Assisted-by: Copilot:Claude-Opus-5
> > > > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > ---
> > > Thanks this looks correct to me.
> > >
> > > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > >
> > > I'm not sure where we should apply it though, it's from a conflict
> > > between drm-misc-next and Alex's drm-next pull.
> >
> > I'll pull it into my next -fixes PR.
>
> I think this should be merged into drm-misc-next ASAP, since the merge
> is in there.

Applied.

Alex
