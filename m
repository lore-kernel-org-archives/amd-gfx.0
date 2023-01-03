Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038ADC4708E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 22:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF5C10E041;
	Tue,  3 Jan 2023 22:42:27 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0C010E041
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 22:42:25 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id g1so31772854edj.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hLFa4NNjmOnl7NchnbxLJN82kn4VrT3GicYSANyt0I=;
 b=M7C9NeQsF+Pb/wlPpbQY6L2EVoM2eLXchVA5zuh5hoiYgbBtnJ1inQAj0rIGo9V6ok
 jeoK1TOGzjIbGqUb8HI46OxrJTWvm/vgSK+TqNqIi0OlfiENpfJHma5sbmzZVNFErrsO
 TLJq0wBK4xYfI+SZuKQjuWC8cm/q+j5aJTb8k99/Rsd8RRsAfCVNb7x1y9iDsaGGgsfq
 5HkDMqbduoNlw8RI0DI4ORwKmb+JlUW9TMNrn47Horj2KKsdhYQ59kDFA1L8zkRhip2U
 6YpEWW4AgHoIqQ9DxSy6vscV9zO54OKm/s72ovWTaNBG0p6DMpoLdUB+UzfSzTg4kR5M
 2hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hLFa4NNjmOnl7NchnbxLJN82kn4VrT3GicYSANyt0I=;
 b=SVte0BOpKdjB905ImbTTPfSBooGsO/0POv1XnQJ8iQG1fG4wj3cvxW7RCpXc1ZkXQ3
 LtH/qRy+l9x9yl9Y1qcOSJb7Izd1QZXiVMKTmQ/8flQN+WFTaRpCg5lOO3E49+b+9JtW
 zgIIjtGIHIM+Nsfh+ju5ovDVoUYvikO1/pPij9qeOztW+mosPVlrc8tJKmetxyVsjn9F
 MNVPZQVbdr2hjL/tVnq1u13aF1DQWvVZvZokHP577RzIJDu0F1+m5b2tcf3sczfeYC8o
 r3EfttmIMF6L7JIl0YqnFcrUDcC5M5uIRwIWBgMNF3LHDhNUnMxXFyqQJaQyi3Rd3Gx+
 Qs0g==
X-Gm-Message-State: AFqh2kpW/oceBjLGHE7ccwe95fRnIuf1rr5D1GeJ/NF2pVNwkcWBhrfn
 TGGAAjZIU/+Cc0otbOf3dxQ9j6a+W/40wb76YFvJgG35TNQ=
X-Google-Smtp-Source: AMrXdXubXtQNXJYXvn7xhgBqNcbq8mo7l5JoD38qFQXRZuQVuRzzu9bZQ/gYIakTMVvSDNpQDA+Qru4qR1FsJSA7jbo=
X-Received: by 2002:aa7:c30a:0:b0:46d:e72:cc76 with SMTP id
 l10-20020aa7c30a000000b0046d0e72cc76mr5487586edq.344.1672785743898; Tue, 03
 Jan 2023 14:42:23 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
In-Reply-To: <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 3 Jan 2023 17:41:47 -0500
Message-ID: <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000ceb7505f163c852"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000000ceb7505f163c852
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see. Well, those sysfs files are not usable, and I don't think it would
be important even if they were usable, but for completeness:

The ioctl returns:
    pcie_gen =3D 1
    pcie_num_lanes =3D 16

Theoretical bandwidth from those values: 4.0 GB/s
My DMA test shows this write bandwidth: 3.5 GB/s
It matches the expectation.

Let's see the devices (there is only 1 GPU Navi21 in the system):
$ lspci |egrep '(PCI|VGA).*Navi'
0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Upstream Port of PCI Express Switch (rev c3)
0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Downstream Port of PCI Express Switch
0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)

Let's read sysfs:

$ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
16
$ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
16
$ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
16
$ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
2.5 GT/s PCIe
$ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
16.0 GT/s PCIe
$ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
16.0 GT/s PCIe

Problem 1: None of the speed numbers match 4 GB/s.
Problem 2: Userspace doesn't know the bus index of the bridges, and it's
not clear which bridge should be used.
Problem 3: The PCIe gen number is missing.

That's all irrelevant because all information should be queryable via the
INFO ioctl. It doesn't matter what sysfs contains because UMDs shouldn't
have to open and parse extra files just to read a couple of integers.

Marek


On Tue, Jan 3, 2023 at 3:31 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Sure they can, those files are accessible to everyone.
>
> The massive advantage is that this is standard for all PCIe devices, so i=
t
> should work vendor independent.
>
> Christian.
>
> Am 02.01.23 um 18:55 schrieb Marek Ol=C5=A1=C3=A1k:
>
> Userspace drivers can't access sysfs.
>
> Marek
>
> On Mon, Jan 2, 2023, 10:54 Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> That stuff is already available as current_link_speed and
>> current_link_width in sysfs.
>>
>> I'm a bit reluctant duplicating this information in the IOCTL interface.
>>
>> Christian.
>>
>> Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> For computing PCIe bandwidth in userspace and troubleshooting PCIe
>> bandwidth issues.
>>
>> For example, my Navi21 has been limited to PCIe gen 1 and this is
>> the first time I noticed it after 2 years.
>>
>> Note that this intentionally fills a hole and padding
>> in drm_amdgpu_info_device.
>>
>> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>>
>> The patch is attached.
>>
>> Marek
>>
>>
>>
>

--0000000000000ceb7505f163c852
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I see. Well, those sysfs files are not usable, and I =
don&#39;t think it would be important even if they were usable, but for com=
pleteness:</div><div><br></div><div>The ioctl returns:</div><div>=C2=A0 =C2=
=A0 pcie_gen =3D 1<br>=C2=A0 =C2=A0 pcie_num_lanes =3D 16</div><div><br></d=
iv><div>Theoretical bandwidth from those values: 4.0 GB/s<br></div><div></d=
iv><div>My DMA test shows this write bandwidth: 3.5 GB/s</div><div></div><d=
iv>It matches the expectation.</div><div><br></div><div>Let&#39;s see the d=
evices (there is only 1 GPU Navi21 in the system):</div><div>$ lspci |egrep=
 &#39;(PCI|VGA).*Navi&#39;<br>0a:00.0 PCI bridge: Advanced Micro Devices, I=
nc. [AMD/ATI] Navi 10 XL Upstream Port of PCI Express Switch (rev c3)<br>0b=
:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstr=
eam Port of PCI Express Switch<br>0c:00.0 VGA compatible controller: Advanc=
ed Micro Devices, Inc. [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT]=
 (rev c3)</div><div><br></div><div>Let&#39;s read sysfs:</div><div><br></di=
v>$ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width<br>16<br>$ cat=
 /sys/bus/pci/devices/0000:0b:00.0/current_link_width<br>16<br>$ cat /sys/b=
us/pci/devices/0000:0c:00.0/current_link_width<br>16<br><div>$ cat /sys/bus=
/pci/devices/0000:0a:00.0/current_link_speed</div><div>2.5 GT/s PCIe</div>$=
 cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed<br>16.0 GT/s PCIe=
<br>$ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed<br>16.0 GT/s=
 PCIe<br><div><br></div><div>Problem 1: None of the speed numbers match 4 G=
B/s.<br></div><div>Problem 2: Userspace doesn&#39;t know the bus index of t=
he bridges, and it&#39;s not clear which bridge should be used.</div><div>P=
roblem 3: The PCIe gen number is missing.</div><div><br></div><div>That&#39=
;s all irrelevant because all information should be queryable via the INFO =
ioctl. It doesn&#39;t matter what sysfs contains because UMDs shouldn&#39;t=
 have to open and parse extra files just to read a couple of integers.<br><=
/div><div><br></div><div>Marek<br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 3, 2023 =
at 3:31 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerke=
n@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Sure they can, those files are accessible to everyone.<br>
    <br>
    The massive advantage is that this is standard for all PCIe devices,
    so it should work vendor independent.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 02.01.23 um 18:55 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">Userspace drivers can&#39;t access sysfs.
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 2, 2023, 10:54
          Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken=
@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> That stuff is already available as current_link_speed
            and current_link_width in sysfs.<br>
            <br>
            I&#39;m a bit reluctant duplicating this information in the
            IOCTL interface.<br>
            <br>
            Christian. <br>
            <br>
            <div>Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">For computing PCIe bandwidth in userspace
                and troubleshooting PCIe<br>
                bandwidth issues.<br>
                <br>
                For example, my Navi21 has been limited to PCIe gen 1
                and this is<br>
                the first time I noticed it after 2 years.<br>
                <br>
                Note that this intentionally fills a hole and padding<br>
                in drm_amdgpu_info_device.<br>
                <br>
                <div>Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"ma=
ilto:marek.olsak@amd.com" rel=3D"noreferrer" target=3D"_blank">marek.olsak@=
amd.com</a>&gt;</div>
                <div><br>
                </div>
                <div>The patch is attached.</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
                <br>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000000ceb7505f163c852--
