Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE17EEB562
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 18:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EA910E0F3;
	Fri,  8 Sep 2023 18:45:52 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3EE10E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 18:45:50 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1c8c44053e8so1223947fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Sep 2023 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694198749; x=1694803549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWWJvZ0HIcg0r7P9Hb+2+CBrd3k8Cf4SNXZB3ps9LR8=;
 b=QAOgFdFkXCEHdwlLwbF0nglBhPXVvapNqOq6N76si9pyw8gIO/biRaKniZ0ueEZJOc
 KZbYdDd+FBvw5fZ1AmLQM3hQhBpQEu5xfKGSlfYrqX8VrJicayospyavufNCxvC9Cig0
 XMWRtWOGn0umYplBIhz1ui9OnuEXLarvY6EbLLdxAr+C263rKejxsRIz7YW0nG4rXrBS
 pfRHH5c7+xd5kEOIgnUQLvMCxlzhFaQWjCtTtQBZ0tq6JN7WNfWSF/WaYv3QpWB8sZWB
 WgnZCWOPVIMKgAMRhY15C0ayK32o/nAqhsg/EzRb6kzhnbcSlX4AsIzmwngxy0F6EK2f
 XevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694198749; x=1694803549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWWJvZ0HIcg0r7P9Hb+2+CBrd3k8Cf4SNXZB3ps9LR8=;
 b=k0Dlwz/zH6C0TtKbuB0/xe6KWwU5ZwpBvukUz25NUPzYLRCK7dn+siChkqLGOKTtrj
 Wv1hFOO4ui9Vuo7Tl4Vrm9FKNIfOggr1m2+uxgYqgRMw9RH2SGrpt48XFnnq/nUzHP2A
 j7ITotlUO8Vf4mhjkH5VHsTajjPO6ZHTQR/19Y1e8Mai77uD/jdtw/ywywklTFgKPuih
 +MlE2McQeVYRcTXVtRxJ0fd25XhU9xv2PYOhcPuKP6kVnOqa9VTrO4DX7gfSw3Qtwc+N
 mZDMTlK/3/e6BDh7JS+hJ7wPcH44QTmpn4hguJo8aHExmOkwbvd5uOuZgODHwyb1X/yf
 jlAA==
X-Gm-Message-State: AOJu0YyIRYqv/n5ykFRS3bua43oH6IiYer+ytcYQG8iNJGAvHYwlBU8i
 YYWerRMTrU91HKhGMBCH5v6R9KJL5awexPIEXb+ld0SSTWw=
X-Google-Smtp-Source: AGHT+IGMg3DMFbRx0aGSKJR9INjr3F6bagIBK2G9Bln1l627J4hNKoREn6dwuiONzmwue5c7b39RNjUw6whYFwkgPmk=
X-Received: by 2002:a05:6870:2214:b0:1b0:45cb:706e with SMTP id
 i20-20020a056870221400b001b045cb706emr1483691oaf.28.1694198749049; Fri, 08
 Sep 2023 11:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <590a06b6-9f59-2b4e-dd79-091091ccb3b6@iam.tj>
 <BL1PR12MB51443B6E9400D1BE6A1791B8F71CA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <f39d5cdf-74ba-1ffe-ea1b-9160b42e1155@iam.tj>
In-Reply-To: <f39d5cdf-74ba-1ffe-ea1b-9160b42e1155@iam.tj>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Sep 2023 14:45:37 -0400
Message-ID: <CADnq5_OOmCPK6W2Uoq9CDQjgjsdkFPVU_RrzN+4c4WCJkVYC8Q@mail.gmail.com>
Subject: Re: 6.5.0-rc7: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
To: Tj <linux@iam.tj>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 8, 2023 at 2:43=E2=80=AFPM Tj <linux@iam.tj> wrote:
>
> On 23/08/2023 14:56, Deucher, Alexander wrote:
>
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tj
> >> Sent: Wednesday, August 23, 2023 4:54 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Subject: 6.5.0-rc7: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
> >>
> >> Recently, and I think especially since 6.5.0-rc5 (but possibly earlier=
), on resume
> >> from S3 suspend the host sees:
> >>
> >
> > If this is a regression can you bisect?  There are very few changes for=
 the radeon driver these days.
> >
> > Alex
> Typical - as soon as it was reported it stopped occurring!
>
> It would have been difficult to bisect though because I have no idea whic=
h version worked - if any. I could only mention the versions I'd noticed it=
 in and as I build and test most versions some don't get suspend/resume cyc=
les and some I'm testing other things and don't check the logs for everythi=
ng.

I think it's fixed with this patch:
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=3Ddrm-misc-fixes&id=3Dd=
cbad727513d277144aee482b2ffbcd2255c37aa
If so the issue would only happen under memory pressure.

Alex
