Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263BFCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70E1112EE5;
	Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U6tRcwfH";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA4D10E0F1
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 10:07:24 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-439712b3416so5192800fac.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 03:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780135643; cv=none;
 d=google.com; s=arc-20240605;
 b=JzCIb6Zrf9YKUSN1nDWTNQSlZmI0397Z2ezloC+uaHodEYJg3pL6Ih4ENyY3YPeJQM
 8wfiwspkyvwI9Xy7M/tDfIAtpBG76V758Qi6WgvFi9EmEEqNyz3+cAU6P/nu5WUqRqdS
 yG1hDDVy4plpJI1HZIlC+NCLCDO4b8fLGow9Zq8WICN2rT6ZmHPAKJDBX63cs67FAXfC
 zLleqQQ2cylKezAq8iVk5G8JnYodxl5JszRgWLjkIuqf/M8qAJQ6MH+Dg/NHycPVlqe8
 9jdmABQ5UQzidZPyr9x4I3FPAxdGLEhwMn+aWRkyHJUEQw+2wMUVJPzDIsw0+fGKwLOY
 2QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=uwSRW0mEi+7q45onIXKo2tHEqDCEPX2QklwvRYXemGM=;
 fh=4sd3I4nDI4kAEgglDreZAV/lcOXf9wwia3ra2v1hAws=;
 b=KcgdHlSFC+DkpUtNrhgOL9L5/pUBwdWqYeZsJDrBc8UrRWLtZC5pbYJ7iPTrt8BLOj
 zMZPUMh4mOhJL1A8vprd482WYqAOs7iK6egIaVj/J0O1zar5ZuErzmFeRovPkig+bw9g
 a3LquHZ7YYFjOvymkgWTNYNLbkNdPTB9l4xHVz0z7SnNB1+ASaTvLfz723uJBFRoSd2g
 JoCpZKcW4MJ7Xl2X82KhZUpDZ7lMVqJNfybVQa04fNhs4A+uupmgMATbV65tfvs2a15G
 /NTmyvIxCPQoRqLY6QOljTMnwiNWsToJ8VywSgbVSje2Vnb5wO/HWb1v/0JQH3agYGHZ
 7v2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780135643; x=1780740443; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwSRW0mEi+7q45onIXKo2tHEqDCEPX2QklwvRYXemGM=;
 b=U6tRcwfHJTTl6fZbP2tXhPvVPEz+WUO+VKDVzM5k6KUTbK+Gzt+6JRVSagTZm1F7QP
 5dHQQ+KNeLKa/lP/L4NIpJ4u4639fjcIshZZ0tXc2GahTp7k/8Joiw8HgL66rdQRz414
 5VdU1uqmqFOG7/Jl+BUFfARPAhlBSCLrNNxGd74kqLc2pdT0BGoC7b2O6bxhnXzRT18r
 7eY+oNtRIU7laO1T/y1IAzLCywvyktaqZ5P5mP6kw2hg79e19MOd6iSMQUSYP06Zj1M5
 nvKmIYuZW8XM+swtyXW7tM8U9/pXswbqGCESUBwCsHbxGV7D2CSARyjO+h3cHxUMiM1Z
 dtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780135643; x=1780740443;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwSRW0mEi+7q45onIXKo2tHEqDCEPX2QklwvRYXemGM=;
 b=erERF4LRTnFF7NaFiZjA0MbfEMeq9J9pq5vlDJ5NLL8XwMa1sDavtX10/1A/C52Bmr
 rm7A6JjFp4GfQUwi2+fE6+yOXU7yiIaeGamh5Q0lGeTvX+KPqoNk6XVoSQ1+EINbvCio
 hOMyDsQz7fu8gJ9rIYOke5SCPltY0xfDmMXWjsFA7H+g/U537cG4LClBuoY9/z+qfxSX
 HH5etCkvpGQkvl4a8N+6xHWVc6uwTnFkuupEm/L0iCf2YBBydMBoAsJJn0T5Hgrb0luN
 8wdyH1qJ4aHRvpQQ7yr2uQWmCwtmqZe7HMJsApdvIgdMEQ6ouemax5eR4e2814nPRbaz
 X/7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kHwjMhCdnYRm4OHBO2XsaGrGfFHp/IWPp0u1Zv/5x5mPwCCBzDQUGkREYFuMngGyFHmEk7nUH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmLKiSNzKoHelt4k/cbTTQ+ise86PYC+K4KvrofF5FDd8+cncg
 /cCCeEmK50f4dm2uJ7qpxCwXdyLvyWEVSnQU9GAFAd8p1dEBwMqrIWyMqnu7f0Jc8pQ1OczStWA
 coRu1FhJW2eQH5z7VTy6jgzfj9zAwDJE=
X-Gm-Gg: Acq92OGrW6gbu3dlSdqbPGfrG7g6qHeAQxc1XkBHK77slwZuGE4JkfyzKTdEhgM3Uzn
 X8egKk7QGm8d0fBJ1eY/UuBa+rEjceSHomT4sw4hy72eq1qt10qCSnEl55NS3fGSkqfC/cNT34a
 JiW/+XEpO9fnxk9IWb+1cS3UcKGOekWjL7Su9kHq8QRWM5RsVcB8Lm67pqORuxx1NFoLatMT0Ki
 AY00s1uWaBE+jD6KRY5dKXnPNpMpVUzt4hR+gG9NhiZ+V/THZd0xbVYfRddMZFI0t6U69OpjGyW
 Pc6awpnRTFJ5jYSvcn1Fnkvj/m0/famHa2R2nkZGuYcEj28MDik=
X-Received: by 2002:a05:6870:c241:b0:43a:f95e:cf14 with SMTP id
 586e51a60fabf-43ca4086da3mr1957421fac.12.1780135643486; Sat, 30 May 2026
 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260519084158.72960-1-timur.kristof@gmail.com>
 <CAOGA6Hix7yPkF2o3hapz9zfpRZ5HHjaaJuDcyWjp+Aoihxf9-A@mail.gmail.com>
 <3626507.sQuhbGJ8Bu@timur-hyperion>
 <BL1PR12MB51440DCA164ED993EA5FAFBFF7162@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51440DCA164ED993EA5FAFBFF7162@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Date: Sat, 30 May 2026 12:07:12 +0200
X-Gm-Features: AVHnY4L9led2QIdaMP_akC_AA8P8ePHTZ8m2bDCF6JEmvGdpEzt_0ozXFvBiTFc
Message-ID: <CAOGA6HgfUjbT9wKU1Baz3QXFsDaRTEUd8WCrRQn2D5Fh8REEbg@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, timur.kristof@gmail.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000aea03c0653062050"
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:37 +0000
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

--000000000000aea03c0653062050
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks everyone.

> My suggestion would be to call pm_compute_clocks() inside notify_ac_dc()

I tried this patch and it's not working. The specific behavior I see:
1. Clocks do not respond to plugging/unplugging. Always idle.
2. Severe system stability issues. After opening a process that uses the
AMDGPU, opening any more GPU processes (glxgears, radeontop, etc.) hangs
forever during init. The system hangs while shutting down and requires
force power off.
3. This message is seen in dmesg. Not sure if it's related.
[  151.684427] amdgpu 0000:01:00.0: bo 00000000c5a63ba0 va
0x000010cb00-0x000010cb53 conflict with 0x000010cb44-0x000010cb45

> Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your
laptop?
Yes, without sending this message, the SMC switches to idle speeds instead
of AC/performance speeds. Unplugging the laptop ironically makes it clock
back up instead of down. This fix was found while reverse engineering the
SMC and confirmed by the clock speeds beginning to rise after implementing
the message. Commenting out just the one line that sends the message undoes
the fix.

> the ATOM_PP_PLATFORM_CAP_HARDWAREDC check is inverted
I've implemented this into my branch. Thanks for checking.

Here is the current state, still a 6th commit on top of the original series
of 5: https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6for
applyingfdc670b5890de661a3bdd42e9b80
<https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6fdc670b5890de661=
a3bdd42e9b80>

This has been working reliably for a week without any problems and I'd be
happy to submit it if there are no objections. A separate commit will be
needed to apply this to SMU7.

On Fri, May 29, 2026 at 10:33=E2=80=AFPM Deucher, Alexander <
Alexander.Deucher@amd.com> wrote:

> AMD General
>
> I dug into this a bit more and the ATOM_PP_PLATFORM_CAP_HARDWAREDC check
> is inverted.  Switching that should fix it.
>
> Alex
>
> ------------------------------
> *From:* Timur Krist=C3=B3f <timur.kristof@gmail.com>
> *Sent:* Sunday, May 24, 2026 7:32 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Jeremy Klarenbeek <
> jeremy.klarenbeek99@gmail.com>
> *Subject:* Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
>
> Hi Jeremy & Alex,
>
> > Apologies for my late reply. I tested the patch series (SI laptop
> > 1002:6606) and the problem remains where the clock speeds don't boost
> upon
> > switching to AC. Timur and I investigated this and found 2 problems
>
> Thanks for getting back to us on this topic.
> At Alex's suggestion, I removed the clock recalculation and added the
> check to
> verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I'm sad to hear that this broke
> your
> patches. I apologize for that.
>
> Unfortunately I don't have a SI laptop GPU to test this stuff, so there
> was no
> way for me to verify the correctness of those changes before I sent the
> patches to the mailing list.
>
> > 1. It seems that it is necessary after all to recompute clock speeds wh=
en
> > toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effect.
> > Each ASIC family's apply_state_adjust_rules appears to be responsible f=
or
> > the switch by setting the max_limits, and this function is only called =
as
> > part of computing clocks.
>
> That's right. I took another look at:
> si_apply_state_adjust_rules()
> smu7_apply_state_adjust_rules()
>
> Both of these rely on adev->pm.ac_power when determining max_limits, and
> they
> set the maximum clocks accordingly. We should indeed re-calculate these
> clocks
> on both SI and SMU7 when there is an AC/DC switch to make sure to apply
> the
> updated max_limits. Additionally I think we should probably lock the
> mutexes
> to ensure that we are sending only one message at a time.
>
> My suggestion would be to call pm_compute_clocks() inside notify_ac_dc(),
> and
> also to lock the mutexes:
> https://gitlab.freedesktop.org/Venemo/linux/-/commit/
> e98279dff480cc297cbb1fe50c2b71ebd65b9576
>
> if that works, I'd like to submit that patch (and will also port it to
> SMU7).
>
> > I'm considering removing the .notify_ac_dc field
> > from the IP block entirely and just calling .pm_compute_clocks from
> > amdgpu_pm_acpi_event_handler, but I only know for certain that this wor=
ks
> > for my GPU.
>
> I don't agree with that. amdgpu_dpm is generic between all supported HW
> generations and shouldn't contain HW generation specific code. Also, it
> clearly
> doesn't work the same way on every GPU generation, so we shouldn't
> generalize.
>
> Furthermore, we should minimize the amount of messages we send to the SMU=
,
> so
> we shouldn't send the RunningOnAC message every time we recompute the
> clocks,
> only when it actually switches to AC.
>
> > 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU,
> causing
> > PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled
> > erroneously, or we're interpreting its intended usage incorrectly.
>
> It's hard to judge that without having access to the hardware or docs.
> Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your
> laptop? Isn't it enough to just re-compute the clocks?
>
> Can you check what exactly is the value of adev->pm.dpm.platform_caps on
> your
> laptop? Maybe we are looking at the wrong flag, or maybe the HARDWAREDC
> flag
> only refers to the AC->DC transition and not the DC->AC transition.
>
> This is just guesswork on my part, but maybe we should look at the
> SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:
> /* This cap indicates whether power source notificaiton is done by SBIOS
> directly. */
> Can you check if this flag is set on your laptop?
>
> Thanks & best regards,
> Timur
>
>
>
>

--000000000000aea03c0653062050
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks everyone.<br><br>&gt; My suggestion would be to cal=
l pm_compute_clocks() inside notify_ac_dc()<div><br></div><div>I tried this=
 patch and it&#39;s not working. The specific behavior I see:<br>1. Clocks =
do not respond to plugging/unplugging. Always idle.</div><div>2. Severe sys=
tem stability issues. After opening a process that uses the AMDGPU, opening=
 any more GPU processes (glxgears, radeontop, etc.) hangs forever during in=
it. The system hangs while shutting down and requires force power off.</div=
><div>3. This message is seen in dmesg. Not sure if it&#39;s related.<br></=
div><div>[ =C2=A0151.684427] amdgpu 0000:01:00.0: bo 00000000c5a63ba0 va 0x=
000010cb00-0x000010cb53 conflict with 0x000010cb44-0x000010cb45<br><br>&gt;=
 Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your<=
/div>laptop?<br>Yes, without sending this message, the SMC switches to idle=
 speeds instead of AC/performance speeds. Unplugging the=C2=A0laptop ironic=
ally makes it clock back up instead of down. This fix was found while rever=
se engineering the SMC and confirmed by the clock speeds beginning to rise =
after implementing the message. Commenting out just the one line that sends=
 the message undoes the fix.<div><br>&gt;=C2=A0the ATOM_PP_PLATFORM_CAP_HAR=
DWAREDC check is inverted<br>I&#39;ve implemented this into my branch. Than=
ks for checking.</div><div><br></div><div>Here is the current state, still =
a 6th commit on top of the original series of 5:=C2=A0<a href=3D"https://gi=
thub.com/luisfonsivevo/linux/commit/083a2bbe81d6fdc670b5890de661a3bdd42e9b8=
0">https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6for applyingfd=
c670b5890de661a3bdd42e9b80</a><br><br>This has been working reliably for a =
week without any problems and I&#39;d be happy to submit it if there are no=
 objections. A separate commit will be needed to apply this to SMU7.</div><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, May 29, 2026 at 10:33=E2=80=AFPM Deucher, Alex=
ander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@am=
d.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div class=3D"msg1170818841561361933">




<div dir=3D"ltr">
<div>
<div style=3D"font-family:Calibri;text-align:left;color:rgb(0,0,255);margin=
-left:5pt;font-size:10pt">
AMD General</div>
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif">
<span style=3D"font-size:12pt;color:rgb(0,0,0)">I dug into this a bit more =
and the
</span><span style=3D"font-size:11pt;color:rgb(0,0,0)">ATOM_PP_PLATFORM_CAP=
_HARDWAREDC check is inverted.=C2=A0 Switching that should fix it.</span></=
div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div id=3D"m_-380171997459857998appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-380171997459857998divRplyFwdMsg" dir=3D"ltr"><font face=3D"Ca=
libri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From:</b> =
Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gmail.com" target=3D=
"_blank">timur.kristof@gmail.com</a>&gt;<br>
<b>Sent:</b> Sunday, May 24, 2026 7:32 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.fr=
eedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;; Deu=
cher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"=
_blank">Alexander.Deucher@amd.com</a>&gt;; Jeremy Klarenbeek &lt;<a href=3D=
"mailto:jeremy.klarenbeek99@gmail.com" target=3D"_blank">jeremy.klarenbeek9=
9@gmail.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7</fo=
nt>
<div>=C2=A0</div>
</div>
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>Hi Jeremy &amp; Alex,<br>
<br>
&gt; Apologies for my late reply. I tested the patch series (SI laptop<br>
&gt; 1002:6606) and the problem remains where the clock speeds don&#39;t bo=
ost upon<br>
&gt; switching to AC. Timur and I investigated this and found 2 problems<br=
>
<br>
Thanks for getting back to us on this topic.<br>
At Alex&#39;s suggestion, I removed the clock recalculation and added the c=
heck to <br>
verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I&#39;m sad to hear that this broke=
 your <br>
patches. I apologize for that.<br>
<br>
Unfortunately I don&#39;t have a SI laptop GPU to test this stuff, so there=
 was no <br>
way for me to verify the correctness of those changes before I sent the <br=
>
patches to the mailing list.<br>
<br>
&gt; 1. It seems that it is necessary after all to recompute clock speeds w=
hen<br>
&gt; toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effect=
.<br>
&gt; Each ASIC family&#39;s apply_state_adjust_rules appears to be responsi=
ble for<br>
&gt; the switch by setting the max_limits, and this function is only called=
 as<br>
&gt; part of computing clocks.<br>
<br>
That&#39;s right. I took another look at:<br>
si_apply_state_adjust_rules()<br>
smu7_apply_state_adjust_rules()<br>
<br>
Both of these rely on adev-&gt;pm.ac_power when determining max_limits, and=
 they <br>
set the maximum clocks accordingly. We should indeed re-calculate these clo=
cks <br>
on both SI and SMU7 when there is an AC/DC switch to make sure to apply the=
 <br>
updated max_limits. Additionally I think we should probably lock the mutexe=
s <br>
to ensure that we are sending only one message at a time.<br>
<br>
My suggestion would be to call pm_compute_clocks() inside notify_ac_dc(), a=
nd <br>
also to lock the mutexes:<br>
<a href=3D"https://gitlab.freedesktop.org/Venemo/linux/-/commit/" target=3D=
"_blank">https://gitlab.freedesktop.org/Venemo/linux/-/commit/</a><br>
e98279dff480cc297cbb1fe50c2b71ebd65b9576<br>
<br>
if that works, I&#39;d like to submit that patch (and will also port it to =
SMU7).<br>
<br>
&gt; I&#39;m considering removing the .notify_ac_dc field<br>
&gt; from the IP block entirely and just calling .pm_compute_clocks from<br=
>
&gt; amdgpu_pm_acpi_event_handler, but I only know for certain that this wo=
rks<br>
&gt; for my GPU.<br>
<br>
I don&#39;t agree with that. amdgpu_dpm is generic between all supported HW=
 <br>
generations and shouldn&#39;t contain HW generation specific code. Also, it=
 clearly <br>
doesn&#39;t work the same way on every GPU generation, so we shouldn&#39;t =
generalize.<br>
<br>
Furthermore, we should minimize the amount of messages we send to the SMU, =
so <br>
we shouldn&#39;t send the RunningOnAC message every time we recompute the c=
locks, <br>
only when it actually switches to AC.<br>
<br>
&gt; 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU, cau=
sing<br>
&gt; PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled<br>
&gt; erroneously, or we&#39;re interpreting its intended usage incorrectly.=
<br>
<br>
It&#39;s hard to judge that without having access to the hardware or docs.<=
br>
Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your <=
br>
laptop? Isn&#39;t it enough to just re-compute the clocks?<br>
<br>
Can you check what exactly is the value of adev-&gt;pm.dpm.platform_caps on=
 your <br>
laptop? Maybe we are looking at the wrong flag, or maybe the HARDWAREDC fla=
g <br>
only refers to the AC-&gt;DC transition and not the DC-&gt;AC transition.<b=
r>
<br>
This is just guesswork on my part, but maybe we should look at the <br>
SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:<br>
/* This cap indicates whether power source notificaiton is done by SBIOS <b=
r>
directly. */<br>
Can you check if this flag is set on your laptop?<br>
<br>
Thanks &amp; best regards,<br>
Timur<br>
<br>
<br>
<br>
</div>
</span></font></div>
</div>

</div></blockquote></div>

--000000000000aea03c0653062050--
