Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F36CA601D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D4C10FF7F;
	Fri,  9 Oct 2026 08:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmbCSFR1";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635BD10E09B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 19:49:15 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2e4df2e26fso452705866b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 12:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791488954; cv=none;
 d=google.com; s=arc-20260327;
 b=CHQNsWhPmD8kPNPDHc88dHohw1xZQoUCp/3bCDnyMzNbMFflydd5ypiel7lEpuf7Mb
 iL8Z7VrYp0xmidF/NH6E/mpwW77BUqhKUX/33qbvoKop3Mno78FN4AAB0u5+hBecwYgp
 VHxr1puo6FPgoSyNN8XDMQqczYvjfRIDhQ9h9WN8dwRb8W0jLI30PQuan4/YHplPjnQj
 /UEYB1PCwug7FtEi57F1yKCgeO3D22wPoWCbIft7BHEL1aVbJDo2WtLlOdhWUNNkOtib
 33/hFFl64rgwsUGGKx5zrLJY23yLK4NSILt2sBMW07PVxEpgAmLPTPz+dL7+/mUmmWY5
 mpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
 fh=QxvoxP5a0lZsIIYvldtJXa+HC13ElnUfoNTs6fOE/Ac=;
 b=HoNmJh5hQSNKzo4Zxn7yOZVktqdDYHBhIMfIcAGteGkAKEhJV7cKieEhHNWZoOzUe9
 11ty0n26ztWpodD6eKUzeHcQ1pNhLnN0bWgxXrEfxpBPcZ6q/zqFpV1RmUJ+FoG0mgAE
 Z0S1pITkExwrNDzTe6srAedTNoM6/fcHFzpdnJcgrPTXNoxlR3D5zP7IrtiGskW91oeK
 9bbqPsEz7czrRfH++TH3QuzuaRhis2QpoiN5hHABILLe/88NpFYTi0lRkV8aKPEzmCfT
 sab1XxOrjf39wqrf4H8yH7orNB4D7v78u6Kk/siaR023iKa5srx6/u2PQ8tL0fTjynBK
 zEVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791488954; x=1792093754; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
 b=WmbCSFR17cDGrRKKg4LgWEXyaWzgOdxD//fdEYWMG02RHL2UwM2MJON//UQqbVOsCt
 D4Lmoy6lTYla7YQHBbnccmj6Ai2xHLPluyNiAARy++HkPvLnWlqDvy0rMYupF+TaV6Jq
 bYloiZwvACVurJjIwfVsU2fHwOU6IWWE1yVabTlcN1TGToiVgGtKE+MGBFTfwTquDQxb
 vR7nO/QbXDj0AiLMw08hqghqN9cP4+Ljjtx/SQuOGQ2eIC3PBCmCYfVQbZk/RPXE0la4
 llo6HZGCQN5MhQxCH4e25Tc2zrniLcINzKi1lKal4pfKjal9QfvGcjyGMqcAYmJgL+5t
 ql4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791488954; x=1792093754;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VF8T3c+JVdlAKxcXmMWBq81K4KmYQwVJxfIeNGY8A0k=;
 b=shy08Ad2nOgWmSocyHXhJWeGU7xulpJIWWZIALK7TY5kJ0C4YYjPVFBeneVx6ZfweH
 W2+iOZlilay3ZlZC7REzEJod0NMoXl6umLVql/PNbfytXylofacMSE1OqlSrkhotFtyQ
 Kfco/z/zb2dDphitmhq5Oglvmu4ZxCoXD6DsNhUzbQBnWQUPnUuww6BXThnntD4DA96n
 if9cDEWOo13r8awT5H8iLJmVIccuEixUNBAmP0LCbDttl6RD7WSJO5NwUroUr2RNN2Bc
 mSvYlW8CeRWrgf5/emEFeZqcZV9xtrdvOWzSPdhbGkdMJSu4dzrpFJNPJInIXd30E6Ay
 K+7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7xL4RiirBRTdztQ9pGPPGrfud8bYu6PSEYCLoS7G33scnsjtoCHzA1wSS5Gd5fh+WZNqc2DJ/@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHtUQTtcYM+G0W7fmkpmH0lEjYMrAM+J5YjndPKPkGYrMEeecg
 E7TDwlOcm7mZJnBXRwcFhI7AfSrpYnx343UGAPvFpxlXrnOUeoRW9rji3QXpvO7XMU+VHymJS2I
 rPvuTt7kfdBWDog+US9qWAFPQX33DPY4=
X-Gm-Gg: AYBFou1ye3f1HR7FlINUyqWpj+Q5lcewLIH+T4tGbxYo0izGUVKyWnEUzTNpfDe/rUQ
 F5S7BSvzabOs5dnQqMumxgBvWAPA9A0vDxnVvGIPRBYCms1FfqYLJN5ChTej46OTG5DyHqK3a5f
 NJNWYEcCsuxGWlnSXBE8FquYboNs9RejQH++knB8qEN/AU6IEI8mcAZHHcUHF7pIhTo5pFhwIy4
 EGXHx1/v15CNRwC3AG0Iz70ysG5UeGXF2yrbr/DsBO6qCI6+nozIa4qbySVlXn/bhuT26mmcbz5
 MBecSMpAJibvoeZcPropUlaUm8dRJkBFIa09KT2mhJwZ3WFlYyezPirfwVX7AAby8zIg4IrSR0Q
 tIgNLf/Kwzy7fMn2F9TGMlX8bzGBv/peWDNrAMrZA1HnU0NYLesxtO1hAfv/oKEXVCFsfADStnY
 hki39PMkpKv6zpsHMXof63
X-Received: by 2002:a17:907:1c93:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c317bb4d1d6mr678650966b.5.1791488953277; Thu, 08 Oct 2026
 12:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
 <20261008193356.GA920772@bhelgaas>
In-Reply-To: <20261008193356.GA920772@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Thu, 8 Oct 2026 15:49:01 -0400
X-Gm-Features: AclHuK9lS4qMXsIqQtLZTvbvn4pXQsnJpTz-SJNc1hOoHum8WTGW7X9lZuuEvIg
Message-ID: <CABZrw2ErJVdJ=vm15+9YeCmpn3n2OxS6HypjRJ3dZWU0tdcxow@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, 
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
 Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: multipart/alternative; boundary="000000000000ade413065d5986a5"
X-Mailman-Approved-At: Fri, 09 Oct 2026 08:12:18 +0000
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

--000000000000ade413065d5986a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will test the patch on MacBook 16,1 on RC6. Stand by.

On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:

> On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> > On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > > Alex is seeing a probe failure of the amdgpu driver after the Root
> Port
> > > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > > recover from a Firmware First reported Fatal Error.
> > > >
> > > > However all status registers in the Root Port's AER Extended
> Capability
> > > > are blank, so apparently the platform firmware raised a false alarm=
.
> > > >
> > > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER:
> Support
> > > > Advisory Non-Fatal Errors").  It looks like enabling Advisory
> Non-Fatal
> > > > Errors causes code paths to be exercised in platform firmware which
> > > > were never validated before.
> > > >
> > > > Skip error recovery on false alarms, i.e. if no unmasked errors wer=
e
> > > > actually signaled.
> > > >
> > > > Note that this will also skip recovery if both the Status and Mask
> > > > registers are "all ones", as would be the case for inaccessible
> devices.
> > > > However that seems justified because it would imply either a
> hot-unplug
> > > > event or a Surprise Down Error further up in the hierarchy.
> Interfering
> > > > with recovery from that seems uncalled for.
> > > >
> > > > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > > > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > >
> > > Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-b=
y
> > > since he hasn't tested this change by itself.
> >
> > FWIW, I just tested this patch by itself and it works as expected.
> > Feel free to add:
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Added, thanks very much!
>


--=20
*Jason Perlow | Argonaut Media Communications*

*Voice/Text * (954) 242-3484 | jperlow@gmail.com |
*Blog: techbroiler.net <http://techbroiler.net>Read my Tech and Food
Industry articles:* https://linktr.ee/jperlow
*Bluesky:* https://bsky.app/profile/jperlow.bsky.social

*Need to schedule a meeting with me? *https://bit.ly/3y8P3Gp
<https://calendly.com/jasonperlow>

--000000000000ade413065d5986a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will test the patch on MacBook 16,1 on RC6. Stand by.</d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas &lt=
;<a href=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Oct 08, 20=
26 at 03:23:34PM -0400, Alex Deucher wrote:<br>
&gt; On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas &lt;<a href=3D"ma=
ilto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt; wrote=
:<br>
&gt; &gt; On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:<br>
&gt; &gt; &gt; Alex is seeing a probe failure of the amdgpu driver after th=
e Root Port<br>
&gt; &gt; &gt; above an AMD Navi10 GPU has been reset.=C2=A0 The reset was =
performed to<br>
&gt; &gt; &gt; recover from a Firmware First reported Fatal Error.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; However all status registers in the Root Port&#39;s AER Exte=
nded Capability<br>
&gt; &gt; &gt; are blank, so apparently the platform firmware raised a fals=
e alarm.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The issue is only occurring since commit eddba19b8b5f (&quot=
;PCI/AER: Support<br>
&gt; &gt; &gt; Advisory Non-Fatal Errors&quot;).=C2=A0 It looks like enabli=
ng Advisory Non-Fatal<br>
&gt; &gt; &gt; Errors causes code paths to be exercised in platform firmwar=
e which<br>
&gt; &gt; &gt; were never validated before.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Skip error recovery on false alarms, i.e. if no unmasked err=
ors were<br>
&gt; &gt; &gt; actually signaled.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Note that this will also skip recovery if both the Status an=
d Mask<br>
&gt; &gt; &gt; registers are &quot;all ones&quot;, as would be the case for=
 inaccessible devices.<br>
&gt; &gt; &gt; However that seems justified because it would imply either a=
 hot-unplug<br>
&gt; &gt; &gt; event or a Surprise Down Error further up in the hierarchy.=
=C2=A0 Interfering<br>
&gt; &gt; &gt; with recovery from that seems uncalled for.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fixes: eddba19b8b5f (&quot;PCI/AER: Support Advisory Non-Fat=
al Errors&quot;)<br>
&gt; &gt; &gt; Reported-by: Alex Deucher &lt;<a href=3D"mailto:alexander.de=
ucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt; &gt; Tested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deuc=
her@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt; &gt; Closes: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?=
id=3D222095" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.o=
rg/show_bug.cgi?id=3D222095</a><br>
&gt; &gt; &gt; Signed-off-by: Lukas Wunner &lt;<a href=3D"mailto:lukas@wunn=
er.de" target=3D"_blank">lukas@wunner.de</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Applied to pci/for-linus for v7.3, thanks!=C2=A0 I dropped Alex&#=
39;s Tested-by<br>
&gt; &gt; since he hasn&#39;t tested this change by itself.<br>
&gt; <br>
&gt; FWIW, I just tested this patch by itself and it works as expected.<br>
&gt; Feel free to add:<br>
&gt; Tested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.co=
m" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
Added, thanks very much!<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div></div><div dir=3D"ltr"><b>Jason Perlow | Argonaut Media Communicati=
ons</b></div><div dir=3D"ltr"><b><br></b></div><div dir=3D"ltr"><b>Voice/Te=
xt </b>=C2=A0(954) 242-3484 |=C2=A0<a href=3D"mailto:jperlow@gmail.com" tar=
get=3D"_blank">jperlow@gmail.com</a>=C2=A0|=C2=A0<b>Blog: <a href=3D"http:/=
/techbroiler.net" target=3D"_blank">techbroiler.net</a><br>Read my Tech and=
 Food Industry articles:</b> <a href=3D"https://linktr.ee/jperlow" target=
=3D"_blank">https://linktr.ee/jperlow</a><br><b>Bluesky:</b>=C2=A0<a href=
=3D"https://bsky.app/profile/jperlow.bsky.social" target=3D"_blank">https:/=
/bsky.app/profile/jperlow.bsky.social</a><br><br></div><div dir=3D"ltr"><ta=
ble style=3D"border:0pt;table-layout:auto;white-space:normal;color:rgb(95,9=
5,95);width:650px;font-size:11px" cellpadding=3D"0" cellspacing=3D"0" width=
=3D"650px"><tbody></tbody></table><b>Need to schedule a meeting with me? </=
b><a href=3D"https://calendly.com/jasonperlow" target=3D"_blank">https://bi=
t.ly/3y8P3Gp</a></div></div></div></div></div></div>

--000000000000ade413065d5986a5--
