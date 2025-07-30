Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C085C87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 07:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033A710E41D;
	Wed, 30 Jul 2025 07:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JvolLvO1";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD6510E41D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 07:41:02 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so36899665e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753861261; x=1754466061; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVKhywp1/s9Ie1k6DAJdvScjIIu8ZvRx4F3+BnRWkTo=;
 b=JvolLvO1Qce1uqw8H4EehR7vx+5xfQsrrmPB2pI4VUndb7moqibEnU7VNjdHd84cJF
 TAyq5OIckzFLYCtpentjaOmI56ElyQdO/3rSaZlBFlbBZgrKJYO7DWbjUBIQ4oTFsodC
 1/uZ6qhfcWGirEu0q5BBTgq8TG+3JSzPTkYwoj3QarpqB4Qtn44k3pHuIsy96a1Pd1hu
 wqRWqBTjJhtTN+eQ38277JU7wE89+PJbnvz+vMFiprNoIOK4MhbtKTV0tLIxy7tqEH4l
 V38BjJzZX7J5S5rNAIldiKLn6/y1nh09UO4MutH7L5mQQSDhOpKfupMROu69FqwdXiHW
 3wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753861261; x=1754466061;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kVKhywp1/s9Ie1k6DAJdvScjIIu8ZvRx4F3+BnRWkTo=;
 b=mIsKfjlNMT5VSLqGbCdpxLPU+Cl6NWtEvDuOi+3pTvVHqtVgBRB/+sP43t6LzGNXlo
 D3CJhny0jQbFrzCrpCFDtEuz3qhP4+nptWJH5MQ8FP872JKAIz6eJLAU+5TmqHRUxRhR
 WuWjgdppBlr6ZrH+DRDJmNo5McMwKvn691by1isa+dt5QemJAYW9vcFBX6bU6GNbqOkM
 bR3l43EjKEpCBjg0TPvBSTGl7i9HPNja0vxHTzdmELd01DBjjEVFUpF5DbI+mnvPFnVA
 9KeSYs1A2P7P12xGDV7qoRYpqIs4MM3IYaNHu03CPj9YfWC4q0Lyzg1CO001DMa0CaZn
 Ytnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXln3QPyK5aBsQGOaBC//kD4Ac/GL3Ov4KQ2OQCYvgUm9mIZVqd/apb7H/sXi9RuiggdWph9usp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSKH0OdF57lw27CrVuE0GvXYsCLdSmclCpVrGxZRL5477G2bCl
 gXwPqvIRWElIjEAub4TVLAuI/yxaMWqhYL9dbO/M4oZxWtBXD0Nk+01n
X-Gm-Gg: ASbGncuNbhIGmVO0taSykLn67bEkoDla6F+yhDEqYF2UVlEV2KXbep2mvQZU2PbDYuN
 Z6Uf9VkfyTFCjA9Plueev8N5bzGdSsI1E85teo0hOx6cos0hTje6l1wWf/bsGH/Ay0t5MLad9kh
 s0+fVFQkfxJo1Tr9QtdGipho0ojHY3iHERo+lG1f6TD3h/KjUimKZ4peCqyL7l2cBzTzUe13lPv
 SYLNuIU6WiyARSAbMgS4cmRR8GnbtYlg71tAD8fJXZ9aKi/PQsU0fshlv+H+3axCQ26eIsid2lC
 /zTj+YBQ+KrzXDrChWCKCQ++5oUass78MXP6kF2UyMSYITEJ9tkOIFNeoKqKTlQiWmYLrcgiKry
 L9E6uHrDqC6BfTDJwg0V9JmjB8SIDJnIVKR7ufvQqUjRuhtJaYDUhLIE8KcsFsqMW3SIQRYgWKM
 NN1jGdOfjfGROhBmST5uN+kvsDQRFoMHZfIXNd656k6KCyZj9Ldd14BCE/J4bepQ==
X-Google-Smtp-Source: AGHT+IFg6bbTXNlr/1NpGuWrsiO0rQFpBAkV8dJVPwINkmFBtI7fhSdbi9l6bjhqCgjbkD5hVAIx4g==
X-Received: by 2002:a05:600c:3ba7:b0:456:285b:db29 with SMTP id
 5b1f17b1804b1-45892bd1b03mr19622475e9.29.1753861260447; 
 Wed, 30 Jul 2025 00:41:00 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45899fb191fsm10091085e9.21.2025.07.30.00.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 00:41:00 -0700 (PDT)
Message-ID: <d3c18faac0871caae3eb70f4d912a635d175b234.camel@gmail.com>
Subject: Re: [PATCH 03/20] drm/amd/display: Introduce MAX_LINK_ENCODERS
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 09:40:59 +0200
In-Reply-To: <06c41d3c-2f5a-4368-8b2e-aa718c2af96c@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-4-timur.kristof@gmail.com>
 <06c41d3c-2f5a-4368-8b2e-aa718c2af96c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-07-29 at 14:06 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-07-23 11:57, Timur Krist=C3=B3f wrote:
> > We are going to support analog encoders as well, not just digital,
> > so we need to make space for them in various arrays.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0.../drm/amd/display/dc/core/dc_link_enc_cfg.c |=C2=A0 4 ++--
> > =C2=A0.../gpu/drm/amd/display/dc/inc/core_types.h=C2=A0=C2=A0 |=C2=A0 8=
 +++----
> > =C2=A0.../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 24
> > +++++++++++++++++++
> > =C2=A03 files changed, 30 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > index 814f68d76257..d86482611b3f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > @@ -522,10 +522,10 @@ struct link_encoder
> > *link_enc_cfg_get_link_enc_used_by_link(
> > =C2=A0struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct
> > dc *dc)
> > =C2=A0{
> > =C2=A0	struct link_encoder *link_enc =3D NULL;
> > -	enum engine_id encs_assigned[MAX_DIG_LINK_ENCODERS];
> > +	enum engine_id encs_assigned[MAX_LINK_ENCODERS];
> > =C2=A0	int i;
> > =C2=A0
> > -	for (i =3D 0; i < MAX_DIG_LINK_ENCODERS; i++)
> > +	for (i =3D 0; i < MAX_LINK_ENCODERS; i++)
> > =C2=A0		encs_assigned[i] =3D ENGINE_ID_UNKNOWN;
> > =C2=A0
> > =C2=A0	/* Add assigned encoders to list. */
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> > b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> > index f0d7185153b2..55daf348293e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> > @@ -274,7 +274,7 @@ struct resource_pool {
> > =C2=A0	/* An array for accessing the link encoder objects that
> > have been created.
> > =C2=A0	 * Index in array corresponds to engine ID - viz. 0:
> > ENGINE_ID_DIGA
> > =C2=A0	 */
> > -	struct link_encoder *link_encoders[MAX_DIG_LINK_ENCODERS];
> > +	struct link_encoder *link_encoders[MAX_LINK_ENCODERS];
> > =C2=A0	/* Number of DIG link encoder objects created - i.e.
> > number of valid
> > =C2=A0	 * entries in link_encoders array.
> > =C2=A0	 */
> > @@ -508,7 +508,7 @@ struct pipe_ctx {
> > =C2=A0struct link_enc_cfg_context {
> > =C2=A0	enum link_enc_cfg_mode mode;
> > =C2=A0	struct link_enc_assignment
> > link_enc_assignments[MAX_PIPES];
> > -	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
> > +	enum engine_id link_enc_avail[MAX_LINK_ENCODERS];
> > =C2=A0	struct link_enc_assignment
> > transient_assignments[MAX_PIPES];
> > =C2=A0};
> > =C2=A0
> > @@ -520,8 +520,8 @@ struct resource_context {
> > =C2=A0	uint8_t dp_clock_source_ref_count;
> > =C2=A0	bool is_dsc_acquired[MAX_PIPES];
> > =C2=A0	struct link_enc_cfg_context link_enc_cfg_ctx;
> > -	unsigned int
> > dio_link_enc_to_link_idx[MAX_DIG_LINK_ENCODERS];
> > -	int dio_link_enc_ref_cnts[MAX_DIG_LINK_ENCODERS];
> > +	unsigned int dio_link_enc_to_link_idx[MAX_LINK_ENCODERS];
> > +	int dio_link_enc_ref_cnts[MAX_LINK_ENCODERS];
> > =C2=A0	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
> > =C2=A0	unsigned int
> > hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
> > =C2=A0	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> > b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> > index 41c76ba9ba56..dc9b9f22c75b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> > @@ -45,7 +45,31 @@
> > =C2=A0#define MAX_PIPES 6
> > =C2=A0#define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
> > =C2=A0#define MAX_LINKS (MAX_PIPES * 2 +2)
> > +
> > +/**
> > + * define MAX_DIG_LINK_ENCODERS - maximum number of digital
> > encoders
> > + *
> > + * Digital encoders are ENGINE_ID_DIGA...G, there are at most 7,
> > + * although not every GPU may have that many.
> > + */
> > =C2=A0#define MAX_DIG_LINK_ENCODERS 7
> > +
> > +/**
> > + * define MAX_DIG_LINK_ENCODERS - maximum number of analog link
> > encoders
>=20
> _DAC_, not _DIG_
>=20
> Harry

That's a typo, will fix.

Timur.

>=20
> > + *
> > + * Analog encoders are ENGINE_ID_DACA/B, there are at most 2,
> > + * although not every GPU may have that many. Modern GPUs
> > typically
> > + * don't have analog encoders.
> > + */
> > +#define MAX_DAC_LINK_ENCODERS 2
> > +
> > +/**
> > + * define MAX_LINK_ENCODERS - maximum number link encoders in
> > total
> > + *
> > + * This includes both analog and digital encoders.
> > + */
> > +#define MAX_LINK_ENCODERS (MAX_DIG_LINK_ENCODERS +
> > MAX_DAC_LINK_ENCODERS)
> > +
> > =C2=A0#define MAX_DWB_PIPES	1
> > =C2=A0#define MAX_HPO_DP2_ENCODERS	4
> > =C2=A0#define MAX_HPO_DP2_LINK_ENCODERS	4
