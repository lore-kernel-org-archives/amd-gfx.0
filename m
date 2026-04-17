Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499ABF436AD
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 14:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E156710EA2E;
	Fri, 17 Apr 2026 14:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NPbrGLO2";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF37410EA2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:09:07 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d73422431so547382f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776434946; x=1777039746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wsc/qNsnpkCw/f1Y/5f1NMs9mXiI7z5rvcKMr8oODsg=;
 b=NPbrGLO2bFg1cfnbBQSMKGinnAZA8DrKTUITiGrtoegWPV+xjj94ol6vL/Q3Czu5y4
 tvkKPIprx9hqCyiGCU6Eg0XndCpvDnIqTDsfZmpdH+qm1pOTKJhj09EgbNfRxxQzfjA6
 YyBC2slPL6eC82eNjB3pVakzu4YFjdwGyiSFRNsKlA/yiNjPcetHnlj5ONWNvPG7mh04
 NC4LTK4cxXd48bjjHgfkd0eQX2eY249YQOR8m9Dax54CQQyeWx8kGzJBpCHle/OhZ1AS
 dIh1LVrKGhc0ncCkg8ATO4PjvYtO/vRlnNE05+tvlEimmRDDGsOx7HqLFDh2otY6ipWU
 Xhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776434946; x=1777039746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wsc/qNsnpkCw/f1Y/5f1NMs9mXiI7z5rvcKMr8oODsg=;
 b=TpKKMOkVRcgWvV4NL2XK/yz+hRmaa2uGskYEk60p1lZVR4ZDom0qFtjna+GCWoTnQc
 XgFeYokSGfZeWU4uTJHggtDaTqj0GkbY/weQt3b7W0G+JkkRiQJRMGI8kVD+tV3g329V
 vhhdNjFjZA3zSM/ud+3oD5qKlVCBxB//sHBN2PCTWbqRKJ+FaW8h69Fk3eP9yVrGlZWd
 xD3wAekoN/oeCKYj+AiRNzGBW0rNoen8GzJr53vKxdP9ETqmDHbHZcGIANnYIccPcWRp
 HX/SfFPwvZcjAAa+c1aCT6kDNJAI4QEfHYVF763jFaq+Uv6FPqCmihgYjC94datgDD+F
 TNAA==
X-Gm-Message-State: AOJu0YxQd7IToF60H/jz4WHOLJHlw6tI0ZKsF0nnrkxfeA2Mzyh+VIBw
 GeOQz3nKbR9NVk1dCk1t52USr4du6PCPc41zaJolj/rKP2ppE5eFIUOV0E40hQ==
X-Gm-Gg: AeBDieuWpRJJnAdgp407DCo5SYHW/2Zba5Vm6g1Xsl7gkuvFMvFhGTOdoPVNMn6jYYe
 IkCkNCMWFUTsLTdCJdMv2jkg3vnv80siRquDSNCBHa7Fbr8dPdq+szhiLL7/jhtR8sJZLt023K9
 sTLSYGSxBxqS8+E4APeBWJNQJOjkpte33h6/RhTjYQhMwGVaC8fWnwkBRFVoJd2I+GIMsnDByYv
 nDN/V6D2A3GTBP9om/8Dp4swL4/94Hg7ykwKZxaGE1SDjLDLG/JhqIgk2O7xCco7Y4K5aBprS0/
 uQM+ppofTCa1AmhQpbPmxJUvQMI/hYCImO9sR+SbqafE2il5ou0J9ayixItQ+8kNim23FyBCYri
 KxRyUbaLn/DCs8ISQ9PgN3e6SWGr2muEnj7U/gJkIObgOmluntEN1oFD5gHRlOAGY43io1VBBrz
 GsaHDVShqndz4dIDPDMDaVs7lHWP8EvZ1L7px+mdLVg0QpWSufG88PO67rpbpI67iMScawj4fsr
 7Jt7AOz7K4gllgRPx0Qj7xUQGiueeitauo4eHyxZLgD8NtngQ4=
X-Received: by 2002:a5d:584d:0:b0:43f:e263:c02 with SMTP id
 ffacd0b85a97d-43fe3dc8824mr4566670f8f.1.1776434944847; 
 Fri, 17 Apr 2026 07:09:04 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EFEC0033EDEB5C97A7ED1D.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:ec00:33ed:eb5c:97a7:ed1d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d112sm5182040f8f.29.2026.04.17.07.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 07:09:03 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Subject: Re: [PATCH 7/7] drm/amdgpu/gfx6: Support harvested SI chips with
 disabled TCCs
Date: Fri, 17 Apr 2026 16:09:02 +0200
Message-ID: <2835381.vuYhMxLoTh@timur-max>
In-Reply-To: <CADnq5_My527aN+SHpv5YvDCU5u3og8PwPoW7OuzXdc-ZvGRX9A@mail.gmail.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <89ea2f13-57aa-4a9d-98b3-f5693e33c13a@amd.com>
 <CADnq5_My527aN+SHpv5YvDCU5u3og8PwPoW7OuzXdc-ZvGRX9A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. =C3=A1prilis 17., p=C3=A9ntek 15:36:20 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Alex Deucher=20
wrote:
> > > +static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
> > > +{
> > > +     u32 i, tcc, tcp_addr_config, num_active_tcc =3D 0;
> > > +     u64 chan_steer, patched_chan_steer =3D 0;
> > > +     const u32 num_max_tcc =3D
> > > adev->gfx.config.max_texture_channel_caches;
> > > +     const u32 dis_tcc_mask =3D amdgpu_gfx_create_bitmask(num_max_tc=
c) &
> > > +                              REG_GET_FIELD(RREG32(mmCGTS_TCC_DISABL=
E),
> > > +                                            CGTS_TCC_DISABLE,
> > > TCC_DISABLE);
> I would OR dis_tcc_mask with mmCGTS_USER_TCC_DISABLE as well in case
> someone has set additional TCCs to disable as well.  Other than that,
> looks good to me.

Thank you, will do.

I'll split off the VCE patches into a separate series and send a second ver=
sion=20
of this series with the consideration for CGTS_USER_TCC_DISABLE added.

Timur


