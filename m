Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969EAC6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 21:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083C010E235;
	Thu, 16 Mar 2023 21:14:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A911810E235
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679001248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqxFInp2VmQbK8vSNjqSt6mzQoSr9Quz9c9/NhmSHFY=;
 b=hkyBckY27d5v0FHTYMDXRCg/IhSKbIb11QsXAQO7HLXJ9QLK4eU9WNe0ZYvvKFCeAfk0bh
 T0sLmuZK1AfKf4MuLI+1Sk4X6Dm+QcYIcbzjGDHm3YEMFKwlJ5gvIZS2Hr4uZ3HvImiYQD
 yoQTA179gx+HcpiIYBG/ueAR58JjOz8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-FptZ-V6DPze-YUU1OURyig-1; Thu, 16 Mar 2023 17:14:07 -0400
X-MC-Unique: FptZ-V6DPze-YUU1OURyig-1
Received: by mail-lj1-f198.google.com with SMTP id
 i14-20020a2e864e000000b00298ab0c9877so782787ljj.19
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 14:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679001246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqxFInp2VmQbK8vSNjqSt6mzQoSr9Quz9c9/NhmSHFY=;
 b=I4BJhY/fsfQQeesbwR68q5DSt8h8mWyYnXqgew68lxCbB3jkOUmp8FvRO8tJhOBb/e
 jldNhxbveqisbHxRdtJyPNMRi3apaSLvlvyPpJnxV/dLlF5U/xpW2utGP2Vc6LvOT2QV
 +puhCLLpqt3c5jxrAug393r21xaGQyUkJHiFVM9OAxcExNNLFbDu5jbeENwqrz87bfFA
 Cf62xLEjBZ2jCDrGX0XgU1QQotY3kvUEzhO/gVRGyC0w4BxZyGOZwF77uSJmIpHXz51P
 BsLlCArJjh3D47msgmA/Dc6ipW+WIBWxBOhyYtbwI6rbVgA5AF9eWbtjbVK+RBf5gqQb
 hGEg==
X-Gm-Message-State: AO0yUKV6bEdIO2DoNpGEKBdfbzW6n1GhqECe4dLvDZtYGNg3fpZW5rT3
 X6RvvR1rL461fEHvUXYN6fYYcBh61ooDgCFVYDAdsfAZP6tJweEIK0R6JzOyPI0SXlBgTtvLmoc
 TmhUsHIxOK/yS4SP5OcJYFbL7yEINBGoQyYZ52mPSeA==
X-Received: by 2002:a2e:7219:0:b0:299:a9db:a5 with SMTP id
 n25-20020a2e7219000000b00299a9db00a5mr1090490ljc.1.1679001245841; 
 Thu, 16 Mar 2023 14:14:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set9u6oNUXwAYA7L8OQgK6NF5AbbqomyqJ0OqfKPTetbwRbeaddA3EOQb/RfQFSsLIVrSUl3xyqon3tp9gfv1/Yw=
X-Received: by 2002:a2e:7219:0:b0:299:a9db:a5 with SMTP id
 n25-20020a2e7219000000b00299a9db00a5mr1090481ljc.1.1679001245539; 
 Thu, 16 Mar 2023 14:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230307151107.49649-1-harry.wentland@amd.com>
 <20230307151107.49649-10-harry.wentland@amd.com>
 <CA+hFU4yiniJdxWOxDKnD7bTGw3QA8uSLyG5sbeiQ5oWqitTZcQ@mail.gmail.com>
 <ZBLmYzVcnBgU6uo5@intel.com> <20230316120701.523bcb37@eldfell>
 <ZBLz17f8YFmNEJlY@intel.com> <20230316133449.26b62760@eldfell>
 <ZBMNEdYWsyfVq46p@intel.com>
In-Reply-To: <ZBMNEdYWsyfVq46p@intel.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 16 Mar 2023 22:13:54 +0100
Message-ID: <CA+hFU4zWvm3-SSjtF17zjRnshEDw27gkQDLGZRk2AbnWN8+1Vg@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] drm/amd/display: Register Colorspace property
 for DP and HDMI
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
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Joshua Ashton <joshua@froggi.es>, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 16, 2023 at 1:35=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Mar 16, 2023 at 01:34:49PM +0200, Pekka Paalanen wrote:
> > On Thu, 16 Mar 2023 12:47:51 +0200
> > Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> wrote:
> >
> > > On Thu, Mar 16, 2023 at 12:07:01PM +0200, Pekka Paalanen wrote:
> > > > On Thu, 16 Mar 2023 11:50:27 +0200
> > > > Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> wrote:
> > > >
> > > > > On Thu, Mar 16, 2023 at 01:37:24AM +0100, Sebastian Wick wrote:
> > > > > > On Tue, Mar 7, 2023 at 4:12=E2=80=AFPM Harry Wentland <harry.we=
ntland@amd.com> wrote:
> > > > > > >
> > > > > > > We want compositors to be able to set the output
> > > > > > > colorspace on DP and HDMI outputs, based on the
> > > > > > > caps reported from the receiver via EDID.
> > > > > >
> > > > > > About that... The documentation says that user space has to che=
ck the
> > > > > > EDID for what the sink actually supports. So whatever is in
> > > > > > supported_colorspaces is just what the driver/hardware is able =
to set
> > > > > > but doesn't actually indicate that the sink supports it.
> > > > > >
> > > > > > So the only way to enable bt2020 is by checking if the sink sup=
ports
> > > > > > both RGB and YUV variants because both could be used by the dri=
ver.
> > > > > > Not great at all. Something to remember for the new property.
> > > > >
> > > > > Hmm. I wonder if that's even legal... Looks like maybe it
> > > > > is since I can't immediately spot anything in CTA-861 to
> > > > > forbid it :/
> > > >
> > > > Wouldn't the driver do the same EDID check before choosing whether =
it
> > > > uses RGB or YCbCr signalling?
> > >
> > > I suppose it could. The modeset would then fail, which is perhaps
> >
> > Could? What are they missing?
>
> The fact that the new property that also affects the rgb->ycbcr matrix
> doesn't even exist?

I think the question was about the current Colorspace property.

> >
> > I mean, drivers are already automatically choosing between RGB and YCbC=
r
> > signalling based on e.g. available bandwidth. Surely they already will
> > not attempt to send a signal format to a monitor that does not say it
> > supports that?

That's exactly what they do. The drivers don't check the EDID for the
colorimetry the sink supports and the responsibility is punted off to
user space.

>
> We just signal default/bt.709 colorimetry. There is nothing to
> check for those IIRC.

You do support bt.2020, no?

> >
> > > not a huge issue, except maybe for suspend+resume if we fail in
> > > the resume path. Although I guess the EDID/etc. should not yet
> > > be refreshed at that point so if the modeset worked before suspend
> > > resume should be able to restore it without failures.
> >
> > I assumed that if a monitor can be driven, and it supports any BT2020
> > format, then it always supports the BT2020 format it is being driven
> > in (RGB vs. YCbCr flavors). Bad assumption?
>
> I didn't spot any rule that both must be there. But didn't look
> too hard either.

Didn't see anything like that either and I looked a bit harder as well.

>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
>

