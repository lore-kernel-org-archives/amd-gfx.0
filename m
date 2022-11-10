Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE23C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 17:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6127510E76D;
	Thu, 10 Nov 2022 17:54:36 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79610E76D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 17:54:34 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-13d9a3bb27aso2922942fac.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhUs5LDBzVM/uCBsu2q6GlPxhKBD8pUKkUZDeOW6kg0=;
 b=RLAYTigSZdm6c/kCaHC23uK8pLQPIHxiVXmbaJnAILcMd/OlVJyfdQTnaUkvrBbRVr
 mzIKpkK15+OJPmM8/MgBBpnvj6PR18upgEemt5LJlOS4dtFyEi1U//F8pYlvbdo/VtPF
 m7KYRoE+rSzRnWUhucqwOwPOAotX4WE2niHJSUnHVgrYTHgp9S15hX8WdX9H7lS1aJ0F
 o6TK4IsmS8R0Z5IP1z8vZIxLc/LNQoBcrjqPY7+MrHRHY3QJzNAAprBRyce3Vlb1YQLL
 0CZW7Fo2kETNyo69jqub5qPkJP+BdR0dY769vFp1NSA5mCPRsOQeeyTOZas4vTANZ+XR
 wurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhUs5LDBzVM/uCBsu2q6GlPxhKBD8pUKkUZDeOW6kg0=;
 b=Doqdj7wbK5vQih9h0EqFx5PdIEiIFMW63FqcheoaHPRp9NpPL+OjtgHTdOAB/RKM6e
 Lr8lT2zIoVmMTbmgC0lLJOUbtg3rL3LEOoaHTCaScKqH6WrOS2Kw1ZAk4JuY+/Su9VCC
 tTzFAE2zzmZuDHc5xCZaWzRYXktRMWn0+pc3q2+vz8sWzNM1M2lVfcYJZxK0wyD313Mc
 RVUzf2+j+VwUTPlorWqdZcv9mDZNcygEBPNEwhDnkm5deRYmeTSKBxVU+oErElWgFFqt
 BbfilpwbAh83opYmewp0yNA+6a1mC1fxcoRdzuQC6yZEbOqnDjCvTSP7hLDLm2I08CnC
 ELzQ==
X-Gm-Message-State: ACrzQf1Mn86eXqctstDlHSJN1Op+dqRESx7mpvv8u+LlStzvwkpZkHrx
 KNEveJZ6s8/uiwVt+LeMOE1KjZXikLV3hcBj3dU=
X-Google-Smtp-Source: AMsMyM7z8uduI7msP4Y+tLgb2x78lZFNzTmZbhZw3elRUeZg75xFJuCv1KZaXpZaVQPbKtmP13R/knXJAFVYULgFr9Q=
X-Received: by 2002:a05:6870:6b86:b0:13b:d07f:f29d with SMTP id
 ms6-20020a0568706b8600b0013bd07ff29dmr1826772oab.96.1668102873567; Thu, 10
 Nov 2022 09:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
 <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
 <92da389f-3c26-6fe1-0525-d38730b6924a@daenzer.net>
 <8b3240e6-c460-5dbd-eede-29ff4825e642@daenzer.net>
 <DS7PR12MB63332B114E5E3B45F91178AFF4389@DS7PR12MB6333.namprd12.prod.outlook.com>
 <04361686-5bdd-8ca8-2ecd-c5dfdaa1a41b@daenzer.net>
 <DS7PR12MB63331E4430DC731D92B0A7CAF43F9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fb72d05b-dc74-fa84-51cf-3c3911aa46fc@daenzer.net>
In-Reply-To: <fb72d05b-dc74-fa84-51cf-3c3911aa46fc@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Nov 2022 12:54:22 -0500
Message-ID: <CADnq5_MKjxf-YngEVJe8AbZQ0Ss6ghGhVHUeSErwPsUg2paoYQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 10, 2022 at 12:00 PM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> On 2022-11-08 09:01, Zhu, Jiadong wrote:> From: Michel D=C3=A4nzer <miche=
l@daenzer.net>
> >
> >>>> The bad news is that this series still makes some things very slow. =
The most extreme examples so far are glxgears (runs at ~400 fps now, ~7000 =
fps before, i.e. almost 20x slowdown) and hexchat (scrolling one page now t=
akes ~1 second, I can see it drawing line by line; before it was almost ins=
tantaneous). I suspect this series makes the overhead of running a single G=
PU job much bigger. On the bright side, I'm not noticing any significant in=
termittent freezes anymore.
> >>>
> >>> Hi Michel,
> >>>
> >>> Thanks for the trying.
> >>> Is there high priority jobs running while executing glxgears?
> >>
> >> Yes, mutter is submitting high priority jobs. However, I don't think t=
hat can explain the problem by itself:
> >>
> >> mutter only draws once per display refresh cycle. Let's assume mutter'=
s GPU work takes ~6-7ms (conservative example, should be less than that usu=
ally). That leaves ~10ms per display refresh cycle (at 60 Hz refresh rate) =
where GPU work from glxgears & Xwayland can run without getting preempted. =
Since glxgears runs at ~7000 fps without this series, it should be able to =
draw at least ~70 frames in 10ms[0], which corresponds to over 4000 fps. Ye=
t it manages only 1/10 of that.
> >>
> >> [0] Worst case consideration, ignoring the fact that without this seri=
es, glxgears runs at ~7000 fps while mutter sustains 60 fps.
> >
> > I reproduced the glxgears 400fps scenario locally. The issue is caused =
by the patch5 "drm/amdgpu: Improve the software rings priority scheduler" w=
hich slows down the low priority scheduler thread if high priority ib is un=
der executing. I'll drop this patch as we cannot identify gpu bound accordi=
ng to the unsignaled fence, etc.
>
> Okay, I'm testing with patches 1-4 only now.
>
> So far I haven't noticed any negative effects, no slowdowns or intermitte=
nt freezes.
>
> The only issue is that there's hardly any positive effect either. While c=
onstantly moving the window of a GPU-limited GpuTest benchmark in circles, =
most of the time it looks exactly the same as without these patches. Only o=
ccasionally, at most every few seconds, I notice that the window movement b=
ecomes smoother for an instant.
>

I think it will largely depend on the workload.  The gfx pipe can only
be preempted on draw boundaries so if most operations are a single
draw, you probably won't see much difference.

Alex
