Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F29EC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 14:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCD410E109;
	Mon, 13 Jun 2022 14:34:31 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FD210E20E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 14:34:29 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1013ecaf7e0so2935855fac.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OeYAVOKz0A8N/zBMzPqr0q1MaHpMwctcFDu4AKt4dkE=;
 b=UMkspmTof2Vrvmeldc+ce54Bq6mgN7CJ1rL5Kc/+iLK6gSJMK2vqqCo7dTOudR0u9B
 gDeHWondq4ayHCYdY+owJMl6qUmGsTpElBiUuCGWO1B1fY0lMdafqFvYHevKiXqpDc73
 +zfFEd7SB1kCvJ+IJ1A5NjVKQd2nCUHVfXJ9cBYL05YzSxIb54HLniQ6bfBuaUbWVfb2
 nfyVabzF7zpX6XiPPN8tmwDbuJZ52XFV4Py7W5OQlV1o0bQw1Z5GpMrXhvU37Yn1fZNT
 hHERLJa17lWyzEzk27n65Wjt8B9RktCLPo2iPNBBmIrdvUIQIQiElbfovFinp3UM2L2q
 kTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OeYAVOKz0A8N/zBMzPqr0q1MaHpMwctcFDu4AKt4dkE=;
 b=B62aIJIYXKZP+PY4q0Xv27MVIPKZSLGy/UuqHhPU5/xttNzvGZXW1fmxplJIptfRWM
 4rinPBZ63Pq7yeylLuPahNkf25vDML029Yca8lvX9XPFdA7qk5YtHloVFvXoDXwP0l+/
 oXcKtKxjqtaKZl2PrVSf0QBMQvDq2am3fOJrl82ctpKekzuhcTqW9GODbgpZWbeeeErO
 DvpoVRW7s5XsHzqv7exVxCd25kgNtTe3MZnpGFaeTStFZx98yZqMl42XgGNPKSKOHLHm
 2q++8Fd2MSSBzDShf0iCaDGnktv5DSEBXWLeGubI314b9mJZVDBl+Witg44lBcbSZZwX
 pszw==
X-Gm-Message-State: AJIora/6O/P6gXHDff0CbvnfYze+LnKLqkZvQY9eO2A1UwUOumUpwaoJ
 1N1rRI0jZH4ctUhUjzUfWVborglv5zphWg/MvdBO+Ias
X-Google-Smtp-Source: ABdhPJwArKl5y56r/kDGTPNVFBK6JVNcZ8QLlbzB4OmgKXtD0Pc2ne4Q0j47R5OBLmBCWadcbfom+i1ISTWUIGy3gQY=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr32361oap.253.1655130869200; Mon, 13 Jun
 2022 07:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
 <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
 <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jun 2022 10:34:18 -0400
Message-ID: <CADnq5_O0yYM6vG+R9wf7-v4uNmKqvBXWy_-kKewiBQfN6SmY+A@mail.gmail.com>
Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
To: "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should be noted that FAMS is an additional feature to enable mclk
switching in more marginal cases than would normally be possible.

Alex

On Mon, Jun 13, 2022 at 9:32 AM Vanzylldejong, Harry
<Harry.Vanzylldejong@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Chandan,
>
> When using Firmware Assisted Memory clock Switching (FAMS), when the memo=
ry clock is switched the frame rate is dropped for at least 1 frame,
> sometimes 2-3 frames to make the V-Blank long enough to handle the period=
 where the GDDR6 memory is unavailable when the memory clock switches.
> This drop may be noticeable by gamers, especially if the memory clock wan=
ts to change it's clock rate several times a second,
> which is what we observed just on the desktop.
> To guarantee best game performance, we disable FAMS during game play.
>
> Harry
>
>
> -----Original Message-----
> From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
> Sent: June 13, 2022 8:42 AM
> To: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>; Mahfooz, Hamza <Hamz=
a.Mahfooz@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Liu, HaoPing (Alan) <H=
aoPing.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@=
amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.=
com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Vanzylldejong, Harry <H=
arry.Vanzylldejong@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harr=
y <Harry.Wentland@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>;=
 Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock=
 switching in games
>
> Hi,
>
> Can you please elaborate on why dynamic memory clock switching can affect=
 Game performance?
>
> BR,
> Chandan V N
>
>
> >On 2022-06-10 22:52, Hamza Mahfooz wrote:
> >> From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
> >>
> >> [WHY]
> >> Game performace may be affected if dynamic memory clock switching is
> >> enabled while playing games.
> >>
> >> [HOW]
> >> Propagate the vrr active state to dirty bit so that on mode set it
> >> disables dynamic memory clock switching.
> >
> >So dynamic memory clock switching will be disabled whenever VRR is enabl=
ed?
> >
> >Note that there is ongoing discussion about how Wayland compositors coul=
d usefully keep VRR enabled all the time, as opposed to only while >there's=
 a fullscreen application like a game. So "VRR is enabled" likely won't be =
equivalent to "game is running" in the long term.
> >
> >
> --
> Earthling Michel D=C3=A4nzer            |                  https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;dat=
a=3D05%7C01%7Cchandan.vurdigerenataraj%40amd.com%7C005764271a144b5832c408da=
4d293dee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637907136793233201%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DNSiOtjfwkelxkZMRFLzFs1mFPvosOFZnq=
rcNvRb9J6E%3D&amp;reserved=3D0
> Libre software enthusiast          |         Mesa and Xwayland developer
