Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC27AC88E70
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1570010EE35;
	Mon, 14 Sep 2026 12:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YiVYkzYV";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C3710E81F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 10:23:48 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a9cb66f7b4so2758335a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789381427; x=1789986227; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E1sCd6BdyPRJ9aYNHdQzAgjNIIzlvS2qtHsqw6qJAKg=;
 b=YiVYkzYVGKVHqMeebwdHE+Ykl5+ovDHjJ2hb/NqlVaOkxRFv5XEIb738RYrRiptU0d
 3mtaforz2NuqoHMHJvj5UiMpTaXj3ekpmhQAdbv//NZl4seyUtc36DbAXBkQ6iOaiVPJ
 YcZOkQtM9HgFvymDr0CZJ4YJ8SwspLIGw2Oxj4WKEMTnNbQEA323M+7IUaQlsOa0VCxy
 nbDeh02vi+Vhad82055JwNCnMUF04187cPySHZT9T57zfDU7DdUQrqnpMBUfSUcYNBKd
 TiG7FqD1cgO6wYbJWLSwYSd6x4mpO3U/4uC0SqBwVUQJlRmyH7hoFZ2+2g1Cn8g2uWuX
 h2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789381427; x=1789986227;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E1sCd6BdyPRJ9aYNHdQzAgjNIIzlvS2qtHsqw6qJAKg=;
 b=iycINN0vJnlRM4NRFkgT+k0PFJHCoX/2egpBaulbJww0nkf1RoBUYC5BnWW08siGXn
 fkQC/YkR/cV032hsWaTD5ywYg2JT4iLAFJoz6khUw7/F8PvBBGqCXJbRx7wkvD84/mOk
 s+FEF7mDqyc8EPrkSNkhL5n5NEx3ABebZDcJ8VkHSX3R9G5qXoIr6yV6+tOK0Kta8HpZ
 +FMw7fj5JcuL19EnZ5IBvKTVP+k3z1R2w3OVbeJPevgmtlsPr86Ra7RX5X3LTkTWqaGG
 YR7XLUnHxphem1Yel86uYFUJtk+C0tiDKOUuFd5u6zP0bVPJJdycGx4vUw9voHpHCw2a
 Xazg==
X-Gm-Message-State: AFuF++nvsQfAwYYLGki6RALFw8g+g2L+TFyDSco9PKt4UGbwa7PMHJuq
 8ztAaeNN9c80HgS+7ZFxivKX3AbBia8xabMlZdDuAPM/W7byajS05o9K
X-Gm-Gg: AYBFou35dshMM8A83kf9sbS4N6AyPNF8Hyy2Z34tlz32hM+tYshEkzID2DTUQ92AWNu
 8PCC2NDkmIG1296Tk6iR46Z3+V50wHOniasYg3HSliUdUiOsjeobzs+89wzr+L2SB6oC3/YK9Kj
 SD1BaqXDnTO4QVS6RtgXaGQwVPuf9+RpzHogGwdvdPILUZfW0B+IYNVvWvf2n3XStd5u8bJN66g
 QE2T5AI59x3mP8MeiDfmPj3LO3n35RSU5yaJEG2JZzoerVxRz5rG1m3L1NewCo/aC3zfCa3EJUb
 nixnKyVljcWhyj3+le86MlceRbhE4N+tLBtLZSJmdfQqBHH7Avd7/o20i56NISYadXOYbwdSNIC
 mP84FUUPYrgZDUjI6LKNBaDETNJKhYMJfJVRF+JXav6I3yk1MRs97iVZiKY8nxHvOcV1obB0Lxh
 S70eUiVWWyXSXpARoF5VEQmFSV8jvy8GfAkfk5BzHuO1uw1vG9KdfbtYue1kvmP38TlRYWM8c1T
 2Ei2w==
X-Received: by 2002:a17:907:d19:b0:c29:6400:ef8e with SMTP id
 a640c23a62f3a-c29b876253emr121178966b.42.1789381426952; 
 Mon, 14 Sep 2026 03:23:46 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966021c63sm404118766b.13.2026.09.14.03.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:23:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:23:42 +0300
From: Dan Carpenter <error27@gmail.com>
To: Leo Chen <leo.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: Re: [bug report] drm/amd/display: Register DCN as a PMFW DF C-state
 client on DCN42
Message-ID: <aqfLLt5rO31_2y_g@stanley.mountain>
References: <aqfKt3Ry75gaA4Vz@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqfKt3Ry75gaA4Vz@stanley.mountain>
X-Mailman-Approved-At: Mon, 14 Sep 2026 12:47:06 +0000
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

On Mon, Sep 14, 2026 at 01:21:43PM +0300, Dan Carpenter wrote:
> Hello Leo Chen,
> 
> Commit 53845307d52e ("drm/amd/display: Register DCN as a PMFW DF
> C-state client on DCN42") from Jul 9, 2026, leads to the following
> Smatch complaint:
> 
>     drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:686 dcn42_prepare_bandwidth()
>     warn: variable dereferenced before check 'dc->clk_mgr' (see line 681)
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c
>    680	
>    681		dcn401_prepare_bandwidth(dc, context);
>                                          ^^
> dc->clk_mgr is dereferenced here.
> 
>    682	
>    683		/* valid C-state watermarks have now been committed to HW, so it
>    684		 * is safe to vote "allow" to PMFW.
>    685		 */
>    686		if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
>                     ^^^^^^^^^^^
> so this check is too late.
> 

Actually, dc->clk_mgr->funcs is dereferenced as well.

regards,
dan carpenter

