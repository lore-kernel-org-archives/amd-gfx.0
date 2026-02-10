Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9185EA3F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D454E10E4EE;
	Tue, 10 Feb 2026 08:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dThjKCmu";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576FE10E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 06:59:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so6972545e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Feb 2026 22:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770706772; x=1771311572; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+IkxppGZ5uCYKAXW0neBai+nAE7kZiGiTY4eR/yYtlI=;
 b=dThjKCmur0OJCGHqcvrww6kpEM/lHKqjGh9OkxXFZKf5/8b5f8XOwM/KwIu2SE2gD8
 ilqPP+fvCKOYTt0wmHHez+h0+f3AsQyf49G+mjr4CUqm6MjX94FuK0M1FEnp8DcnNDn8
 O5rC7b+uIqqkmD0rE2mLb2d8uesOMtT+mRmHvXDiNCr2QtkWQ6QFW0nsAAYQ3bFL0Mee
 opoMCL1o+ocKIuFn0C0rdbyr0WyNRFocmohwUEipM21yPNaN8vlBP72CNokNK1nj+srH
 hhgPbspl/OTuFpRa4uUiqcyOdMGIGdhKMtRVkrkd7/ucov21nNnjFyrFEQBFRmJE1cts
 9IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770706772; x=1771311572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IkxppGZ5uCYKAXW0neBai+nAE7kZiGiTY4eR/yYtlI=;
 b=ZrUVdmqMVMMna4PNn49jZvRyMKVLD+WplduVzeutWdxc/aMiYpeOkdUmmzJXnmnJsS
 kxypByn92gL5Zb7ZrT/ROIGf7Q5nBoDIWiT4wQ7s7Jmq/eCbZRL8nm42BxvD47kuON+x
 R73Ouec7QU9zgMjmA0VJldfAt2vWWrXedhGi0jF6lasyMDPpqSRBYqhfY0vBCywdWCMM
 OEYdraYgHsQPj9Q6naLz0zJpJj18HmieOYmWOZThZdFkEG50553fiVjmwJcFWgd44bKD
 VSfE/lqyg7anDNZa1nnz+eMqwe2aaFfwzdvM57VSJp3zD+LzvoZduFyK5W5CkEE5kiXf
 FQrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvz9kjzLGgu24T277E57yqIh767S1LwPGCu0VoirQKeClSUoDRqPVOIvcfSaZKbeAQIFsgueXR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVNutOcVFWjJrgLyauWKFDRoS0vEtJOKA//da3ulz3/lQO8C5W
 nd8OWiTmal21cIitpYEkhIVJFlZLhivR21pocXivLAgcAK5WclhadgrX5v7OiUimZkU=
X-Gm-Gg: AZuq6aIq2HEyre14SNxyNfvLwy0izZDbQeenqEV/lS+NMvVWi5qc21qlGG2K55KGVJn
 rG4Lom9NsgA9sT5CDpUANoBXlIiYvb+wSUlBAYdX9BhDJALfPMjzMBv2qcf+mDjOGDSI20bpLEe
 YvUqRJNAsck4ESVQQNeCRtm9wP5q7aRSviJy05JVRx7QrH5+2gPSDZxCQCdYQ1Bb47gKGsV8TG+
 Ofep2NOYFSoi4izCt8+YhWcEnkZCdyQIhau+PunpFeitk6JUy3NRfIbP7sMx/Aj3KXuuVuD18tR
 pkhloE33uvHg0UFIFxI40WmHMW3vBqQZWk6RkIfI3g4lWsKM0Nhy/Ri1f1x+XDPTzdhNHpQVWR5
 EmBWA9IvxcB60Pbm6Npq2u4WjKNd45uwGCub8sm4VvDAIEbTY6vaJPeSCVipkXoha5uc5FZgVtT
 QFLRQ+OKSkyO7W8Gr+WoO1nmTGD9ceMN3BzO4H/A0=
X-Received: by 2002:a05:600d:6447:20b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-4832020dfadmr135875365e9.9.1770706771609; 
 Mon, 09 Feb 2026 22:59:31 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d8ebfsm63393755e9.2.2026.02.09.22.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 22:59:30 -0800 (PST)
Date: Tue, 10 Feb 2026 09:59:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Li, Roman" <Roman.Li@amd.com>
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 Mario Limonciello <superm1@kernel.org>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix out-of-bounds stream encoder index
Message-ID: <aYrXTyT6G2u--dFJ@stanley.mountain>
References: <20260206151923.1479783-1-srinivasan.shanmugam@amd.com>
 <CY8PR12MB8193570B0F1446F4E65B346E8965A@CY8PR12MB8193.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB8193570B0F1446F4E65B346E8965A@CY8PR12MB8193.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Tue, 10 Feb 2026 08:20:22 +0000
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

On Mon, Feb 09, 2026 at 11:34:08PM +0000, Li, Roman wrote:
> > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> > b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> > index 4e962f522f1b..d8c1f1911c37 100644
> > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> > @@ -1230,12 +1230,12 @@ static struct stream_encoder
> > *dcn315_stream_encoder_create(
> >       /*PHYB is wired off in HW, allow front end to remapping, otherwise needs
> > more changes*/
> >
> >       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
> > -     if (eng_id <= ENGINE_ID_DIGF) {
> > -             vpg_inst = eng_id;
> > -             afmt_inst = eng_id;
> > -     } else
> > +     if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
> 
> Could you replace the unsigned cast with an explicit bounds check, i.e.
> if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs)) return NULL;
> It would be clearer about what values are being rejected.
> 

Also ARRAY_SIZE() is type size_t so type promotion would mean that it
was already cast to unsigned long.  Casting it to "unsigned int" makes
me itch because u32 is smaller than ulong normally.

regards,
dan carpenter

