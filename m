Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E229105F7AF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 14:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D4010EC54;
	Fri, 13 Mar 2026 14:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cw2W3XLQ";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334FD10EBAA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:04:51 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-128d600ad25so81756c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 07:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410690; cv=none;
 d=google.com; s=arc-20240605;
 b=YwU25BH/ykgB7C+gZ5DKn+zD6IA/CzyueM9A3y1IME9BweWBez9/XP7MyOoWXT2Juw
 doo1E4AudKMqHRI4+F9t3/6+fvCBqlaFe3SoSBTG0JH+1V8L6GBkfS1gqQlxY4CxHzz+
 TKU81qF/gu3SqACK43M5wcFyz6iiZhIukCcssLxWa5A23RS4VReRgLCOTVkVp4bbi8bH
 gN4Ir56nE1EcC8RAWV8hirLAcGjHZU9rpAdLW4ev12ny+ZGt3BJxn/fgEGBwreluDed5
 aL6RTmRJd3hixXuW2j6AJOT5MY9CUvuJZqv704pxvAIdcmWHrGZ/vEKrQ0KeDf2Z40Ot
 m4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5E88w3jX+YSLLylZTFGH+to3tZ27lkENQ9LYovk5WCw=;
 fh=QgGSmuAcw4+9mSJ220NN6DgGyurJbisaDxZ2fMKpo2U=;
 b=bmAUUHTC6O8+/bxULp88eMcVK+tRxIq1OKJQy8gXIk+ISIIJ4Ldejn1Lh5B23531Iy
 kltpvvUPvKl3DF3nU9s0zJ5CbuRqyybL5HuElLq6Hc6hDYUMw6e3lEOvDNqrltfk5vwZ
 ZT3+ZMK3UPxHeAJ1ic5376iPxclwQPbwdJw7GAr6w0Z4UUEw75ckDH4XflyIZ9J73sXl
 02WpgYwd/5MVFHr2fNkYYmqSWdSu8kKVTnBWvZ+X8AblQUm5d1NtlZUrWte1tLe9LD+g
 8ylzpumXmvpe+We1SCBrnuTN09tq3YWLkQ7dCUc6tJziL4GJCJkPnuDjLpJ2sCot+8+5
 gfJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773410690; x=1774015490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E88w3jX+YSLLylZTFGH+to3tZ27lkENQ9LYovk5WCw=;
 b=cw2W3XLQocKGWFmvdO3nn2yKb+60GiM6NiskuCbCYqm1HJb1yR7f4BeiJwU714iwHW
 ex/82wipCBzJI85H9tZm9q8JJynHw1i3J/mgXksX6jn04I5b4WDYoFgDPmGkpvRVkoD/
 JD1BT6iU3mzJ7DHQtyydC/3lXM6eKSpnV0vFs2wrf+7lZTQxoQope/13tiJBIF5iUvwv
 fvWAheonQdvcWzPSMgd370fG4IO9SR0r/zy6K68YrN/I7u2vi6XJsyBCsbuXlwSRamG7
 biRDbsHfxeDBwcHnIWI3A17Pm0/j9Xq1DQ/4riJNt+HH6Es07VbZX/JLMtiFFDkQiOB5
 jk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410690; x=1774015490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5E88w3jX+YSLLylZTFGH+to3tZ27lkENQ9LYovk5WCw=;
 b=i00wu8iyh12LVxJrh4JAZlxMSpMfDN9F754Ay6Z4B5iZwGGU6nL4Tz0J48+BW4Sr0n
 +N6xtZdz5eXV7qapBavQPZfON15PJeLML4f+6fsF4/8J3nX5N3vD38ENY2R/yZ12AKDf
 TZMq+7Ei8u2n3YDm4zuk29z6yflyfFxVOXJ6uEywDXBdFGRhcE5ea1o9FSa1JWt0bCk6
 Qhl3q8BqhZUA2NbSP9zgjoGxPJD1SdYR7OwX50xBar1QYZUCRTtFP/jg0k/YN5YRH98x
 l77hhTXFzAFwhtubgXdCahND0lNnZUZhtqoIrHICy35N64awBxZJWc5zu87UOt1+riDa
 0gjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKUq8SQB29r+ncvx2anngSPZUe/rxjQCEK+S6mOg9LjHx23ZJAaI9278svi0wKv//ZBA0g3zRp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxOmNmrgjljglf6gYH/XpVTKw0D1KBvdoPf2PZ5Wz1YA4Urn78
 /scZVUUn5CuFvZMGdasSZ5xiQYdJfRJgKA3xzGJlajwTJzaIFazySgPybpvVAwmH9X7MAOjPGC1
 cCkurP91j9C1rapKuua8dPPjXvNj7ViY=
X-Gm-Gg: ATEYQzwH+VWCuaAxJgK72Me37WmII5qQJBAw+3RKmYXzZyxWLJICrjFbqPEK2FpSWLQ
 ZmC/AKHNnDY9UX06FoBvXTry2RbKbYw6RUuJ3Q76MfPe8TszduMcayEgLOVLpIYDNuZcCYKqpl8
 /kHpuO+4gNd7ytiwEfbp5Nx47aErEzPt1Vr9D/AD3T+s0M9Ybm8Zo6ZAcNhw8S6EaiA7T9n850y
 +7j3Ec5rHXM0TvUzQEQlXKCWuHS6m1x/54jhThZ8+IKRqwgIiiOw6da0H9jzYmUnppvHqU2PX9R
 /sbBs6ss3BTMcCshArhaomxyuXxSNFXLfNj3MYou8PxlXVIvK+1Wm4+t1I67LAo7UPKZyw==
X-Received: by 2002:a05:7022:418a:b0:123:2d38:929b with SMTP id
 a92af1059eb24-128f3e33d01mr793389c88.6.1773410690364; Fri, 13 Mar 2026
 07:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260313015226.39727-1-davidbaum461@gmail.com>
In-Reply-To: <20260313015226.39727-1-davidbaum461@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 10:04:38 -0400
X-Gm-Features: AaiRm50d_WEY5sRN59yLf89uD38vQ-LQP7kESvNrj1X-FqVXwJ8QeTLcGXASPgE
Message-ID: <CADnq5_O=Ycrhk1uXO2EfPimZ8EP=nVX4sJ4BUkaB8e0Hwp3_eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: switch XGMI sysfs show helpers to
 sysfs_emit_at()
To: David Baum <davidbaum461@gmail.com>
Cc: alex.deucher@amd.com, christian.koenig@amd.com, lijo.lazar@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Fri, Mar 13, 2026 at 4:55=E2=80=AFAM David Baum <davidbaum461@gmail.com>=
 wrote:
>
> The XGMI sysfs show helpers amdgpu_xgmi_show_num_hops() and
> amdgpu_xgmi_show_num_links() currently populate the output buffer with
> sprintf() and then call sysfs_emit(buf, "%s\n", buf) to append the final
> newline.
>
> Convert both helpers to use sysfs_emit_at() while tracking the current
> offset. This keeps buffer construction in the sysfs helpers, avoids
> feeding the output buffer back into the final formatted write, and
> matches the style already used by
> amdgpu_xgmi_show_connected_port_num().
>
> Signed-off-by: David Baum <davidbaum461@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 11e56df1d91b..13fc7247fe23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -469,12 +469,12 @@ static ssize_t amdgpu_xgmi_show_num_hops(struct dev=
ice *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> -       int i;
> +       int i, offset =3D 0;
>
>         for (i =3D 0; i < top->num_nodes; i++)
> -               sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_hops);
> +               offset +=3D sysfs_emit_at(buf, offset, "%02x ", top->node=
s[i].num_hops);
>
> -       return sysfs_emit(buf, "%s\n", buf);
> +       return offset + sysfs_emit_at(buf, offset, "\n");
>  }
>
>  static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
> @@ -484,12 +484,12 @@ static ssize_t amdgpu_xgmi_show_num_links(struct de=
vice *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> -       int i;
> +       int i, offset =3D 0;
>
>         for (i =3D 0; i < top->num_nodes; i++)
> -               sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_links);
> +               offset +=3D sysfs_emit_at(buf, offset, "%02x ", top->node=
s[i].num_links);
>
> -       return sysfs_emit(buf, "%s\n", buf);
> +       return offset + sysfs_emit_at(buf, offset, "\n");
>  }
>
>  static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
> --
> 2.50.1 (Apple Git-155)
>
