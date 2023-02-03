Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D212EC05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 13:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE94710E7A2;
	Fri,  3 Feb 2023 13:53:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5089710E057
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675432387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPeIaOgUpyYN5d3lTDBnF3M123TEx8B08kPAaxZlFr8=;
 b=cyiuBg+caDAfwv7ZTg1O1IPcZh8OaZjdGZEp5hFSWYtqYhlsFv95JNrW46BG2EcNodfDw9
 0Z3SdUppwJUCXT3lkdRWkrn1tUcL1Y7hzq1wi3lhX7qQGYg/pnk3xsfk5nW3Wb9Aa841cv
 Q5p42cWTKqE4K9UTLZWVElQ/AFixzn8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-225-axUIK7EzO_6pRtETmgcFpQ-1; Fri, 03 Feb 2023 08:53:05 -0500
X-MC-Unique: axUIK7EzO_6pRtETmgcFpQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 i2-20020a0565123e0200b004d5aee356dcso2167008lfv.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Feb 2023 05:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPeIaOgUpyYN5d3lTDBnF3M123TEx8B08kPAaxZlFr8=;
 b=ivgT73+48ia8eM8O7m+ZMJvig+x2V1CzKD9JkoQumJ1bo7j4bBoXj1zrKHy4RAjyNu
 dbDR98OLbvxy3XX20ccb29OwCsQE6ri1sHgAwb32XqA7vKk+ljCMETmf9HwjrNYjzqNw
 ta1FCuoR5mExLnU+GoZyNpsbr8aDKDA4LSKLfc2T3BC/5iIek4J405oFx+vTt4muSlay
 oS4uEuygTGA7yUGnmTjX3Xkp+iQr5o/RDOh5wsxUkhb5MbptfOII1gT5o0VG49rBhZZX
 iMPkC8yguuHKQPzP6/Eh1MK0U04rudaIffLo2cdlGBjNpm2bweQRFIgGU3vrNjM1OD4C
 kV9w==
X-Gm-Message-State: AO0yUKV5AzU7bf9yF0ni5B8roPV9jzD4YxX3Fr4x8ZH08/IO5ZdiTjTT
 gtWWVdpkgkguULHHGewvFSrdSWi7sBLcPSMbG+hI1rtBCsLnatFZTyl9InWeONGymxLBjOhOIBC
 9JDbZ+58/lHv8M7rzWGWHxXqlqueksZED0OBMy6RnWw==
X-Received: by 2002:a2e:9c90:0:b0:290:60a9:b5e6 with SMTP id
 x16-20020a2e9c90000000b0029060a9b5e6mr1613475lji.62.1675432384137; 
 Fri, 03 Feb 2023 05:53:04 -0800 (PST)
X-Google-Smtp-Source: AK7set8kbVT57YO/rmdVZUqx5me6Uz5HRZkS7X6lkrYpzRlt/o1KInsGQnqA16w0BSc3HPVA7XB9r/jbWrc6sojVdJQ=
X-Received: by 2002:a2e:9c90:0:b0:290:60a9:b5e6 with SMTP id
 x16-20020a2e9c90000000b0029060a9b5e6mr1613446lji.62.1675432381925; Fri, 03
 Feb 2023 05:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20230203020744.30745-1-joshua@froggi.es>
 <20230203020744.30745-3-joshua@froggi.es>
 <Y9zkef5FjtZ7guVS@intel.com>
 <CA+hFU4ymiOg06MQeKLcn5MSrR=BZnOLODdZCFvGUdWqt_ha61A@mail.gmail.com>
 <Y90NkvVabh+ue9hF@intel.com>
In-Reply-To: <Y90NkvVabh+ue9hF@intel.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 3 Feb 2023 14:52:50 +0100
Message-ID: <CA+hFU4xR_8=w=z=Jqs3sujTvnXfEQJVHAMFW-X4-55POF=Bu9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/connector: Deprecate split for BT.2020 in
 drm_colorspace enum
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: amd-gfx@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Uma Shankar <uma.shankar@intel.com>, dri-devel@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 3, 2023 at 2:35 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Feb 03, 2023 at 01:59:07PM +0100, Sebastian Wick wrote:
> > On Fri, Feb 3, 2023 at 11:40 AM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Fri, Feb 03, 2023 at 02:07:44AM +0000, Joshua Ashton wrote:
> > > > Userspace has no way of controlling or knowing the pixel encoding
> > > > currently, so there is no way for it to ever get the right values h=
ere.
> > >
> > > That applies to a lot of the other values as well (they are
> > > explicitly RGB or YCC). The idea was that this property sets the
> > > infoframe/MSA/SDP value exactly, and other properties should be
> > > added to for use userspace to control the pixel encoding/colorspace
> > > conversion(if desired, or userspace just makes sure to
> > > directly feed in correct kind of data).
> >
> > I'm all for getting userspace control over pixel encoding but even
> > then the kernel always knows which pixel encoding is selected and
> > which InfoFrame has to be sent. Is there a reason why userspace would
> > want to control the variant explicitly to the wrong value?
>
> What do you mean wrong value? Userspace sets it based on what
> kind of data it has generated (or asked the display hardware
> to generate if/when we get explicit control over that part).

Wrong in the sense of sending the YCC variant when the pixel encoding
is RGB for example.

Maybe I'm missing something here but my assumption is that the kernel
always has to know the pixel encoding anyway. The color pipeline also
assumes that the pixel values are RGB. User space might be able to
generate YCC content but for subsampling etc the pixel encoding still
has to be explicitly set.

So with the kernel always knowing exactly what pixel encoding is sent,
why do we need those variants? I just don't see why this is necessary.

>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
>

