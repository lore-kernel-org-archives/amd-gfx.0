Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA67C44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8D010ED6F;
	Tue, 14 Jul 2026 14:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gY2M/kHT";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1DD10ED69
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:13:35 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso2135695ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 07:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784038415; cv=none;
 d=google.com; s=arc-20260327;
 b=i23e82W2jWWqIJ9UfwOk7uplGg4awin0FC1Ccz6Hd6s0Z7DhIgklrBmuMMOGgNXkmN
 c0DNVkyHBV5fd6VtaycwoiXRWSTb/D/IcvHmnErNMds8mnuPKJXei9c9fW7HE3d22v1F
 AGNsraqmVcjFu/OEy22S2N+Rg6A7XzyIq7+vhmLSJ95YY/T5YIg5So59DBuWAklzszEL
 geckSn+lcxQhumTiCgLLghhLDpe1YI8fu+p33ZSCrzes5Q9cZKsKwaBBAQ7xj8qd0/cd
 eGreu7CeFojEJyqTICmIAYiIMuhrD+J4j+CN6l6FJ4GmBOFEEqkGCVloKWZVaiMse4YW
 lklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xo3Yaazklc7rUniB78N/gyZJGtlZbrpG2kyaapVSJz8=;
 fh=Y4PceRChdjNNN5THJu26RL0gGdeJDIcoYVYsPDQexIA=;
 b=iHUeqS4ik4pXdHZclb8Dc0H/yZp8OP0V4YjesLE4DvL9Xb+kpY8oQ6bb0p3J0ZAPs2
 wU88bjCkMmwS8HrQjKq2cGpaBn6OmIbtRIqabhJ+DoEzG7Ua6xZkqul94jtDZpjuNhY7
 3cL5wHHeppFAOSjZ1UWF2PNFxrGE9++yXSczIzeL+BAx2F8EVLoOG3xmCmKQCfRnDv9C
 6V2UZI+X6tM4BZsa6L3pJGfE4nm2NOnx8c6HUhf7y9oo3/gGexkry4QoSRLPHaLOR1Pb
 3+svYgJw1OU56CNSZLZu4SHm6fXeJf2HnEdQ1OY2eQN2bqqM4r2mMmDsywrgi+kPVAFq
 e+xA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038415; x=1784643215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xo3Yaazklc7rUniB78N/gyZJGtlZbrpG2kyaapVSJz8=;
 b=gY2M/kHTHs9/2Z62uoYPP7j2qKTGIi4BSPTLMXesKg5jBDdBeS6ESWb/u2+iqzvOc4
 Tbq/ee3/6Mj/2QOhGx2IApJ+AhOIGtFCjUqEanEwAH1FEdoahTvYNz2ztBDZitGAQ9SQ
 6UbUrmF+eQNp8QjAO7Yjg0bcs6wBJLbSv6/5mFvlCGulOs1aUeIHaVabd2COsPQOZmzl
 FIY8gOlcEFmRqBbeNS75SgqxGLViQ12nsbaJvQ0EdgMLgNp9vHa2oZWXH4zlGKQK9PZU
 +NtDVtAsAfiyD681AxVYwEumZB9teoor81HjVmiy+YYuc0zfBa/UhtsnfdFlUCj0rdWy
 YeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038415; x=1784643215;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xo3Yaazklc7rUniB78N/gyZJGtlZbrpG2kyaapVSJz8=;
 b=arRWOMG1xl8kUuo57HSieKGk89BvLmh4nAbW24HOTkEsssPB9BYhkBqNiv1iZvfSDd
 uGDo3BRK+YmVUC76Gknh0XLIr5SaMG0ViDifcgeEEZ1B64lACZWL2JshRHDYGOuW2hbc
 AleEj90KNcoqqnBbLQ6uaUK3C948WxPbaQVAa6vbjGU4G/ImM8sC+xYua3TNQuz3axcP
 hE1pvD5WjuLwMcA2kDxbMp2Aqos8JLZW2VPLVDpB2eZ5NrvK3BfLoMPnOEc5DEzwfaSZ
 I6E0tmgn0h5wq6PdLgfmyBHSR7hru03EqMdwIy6mNCojy3G9AD0q5xG8WFFRJ2pGUpyi
 Pwpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrGcFXSJqfIwAKAjbme+fDFz16csc9z2xG51nDx4cBnivnXyU8kgsuV5YCWEFCEXuYjAF1yjDR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTtS5crcVNwGlhpqSHjBEfxBSTwt4YYBw+aD8BE38avlZfoUNS
 encKubfIckUlO8XTPII9X7Qiu+wjVS3Y+cWH7jIJMH3SJMkyMF75lCyJqfLzdCkDxpzjSCX3Jum
 4dJxQo21yKBeyp8odjcfxdhCGsWfeNd0=
X-Gm-Gg: AfdE7cnsIO0wX+b39Kn5esx8d7X/13JR1MX+93K9PrjJt/+v8xwVWVmbptVgYNrff6h
 YXaItCp0TAyID+Fr3+cH2FGoN4aV5n+MNDw7Xg7HPX3padUe8hqDbWa+dyGzZu72D11Pu1tnG7u
 HisZ5IF5/EAtktsqmv1tguDEAlK+1Eu1U7SJNvh0f6hL8cs0seXeliTFyQAg4mtGP36JFS5P34m
 DvPHxIuq2YQdGCbmlEO/kmHDY65z04cjJY+vIYnRsHfkM+veePo0V1hzVtIDTMoo9GT59vyokx0
 QgSr4Jrh4PTb1SlEoO1pdvJW/y2smiXEMFHAgNgEg5hkZ9DdHb7fs5Ui86c=
X-Received: by 2002:a17:902:ec89:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2ce9e1c7c46mr108657135ad.0.1784038414883; Tue, 14 Jul 2026
 07:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
 <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
 <IA0PR12MB820873CAF481C1993A4913E390F92@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB820873CAF481C1993A4913E390F92@IA0PR12MB8208.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 10:13:22 -0400
X-Gm-Features: AUfX_mymUAwNg3ffg3k_gZ5LQFGcsrgUh2on2DjhgSit7V4FVhU5X4vx5d8YBTU
Message-ID: <CADnq5_Or7=3D1sFk8tkDKq1oekne7YnPAw0C_uXb_Nb_bHMk8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 14, 2026 at 10:10=E2=80=AFAM SHANMUGAM, SRINIVASAN
<SRINIVASAN.SHANMUGAM@amd.com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, July 14, 2026 7:26 PM
> > To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; Liang, Prik=
e
> > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
> >
> > On Tue, Jul 14, 2026 at 9:49=E2=80=AFAM SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com> wrote:
> > >
> > > AMD General
> > >
> > > > -----Original Message-----
> > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > Sent: Tuesday, July 14, 2026 4:02 PM
> > > > To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > Deucher,
> > > > Alexander <Alexander.Deucher@amd.com>; amd-
> > > > gfx@lists.freedesktop.org
> > > > Cc: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil
> > > > <Sunil.Khatri@amd.com>
> > > > Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
> > > >
> > > >
> > > >
> > > > On 14-Jul-26 3:57 PM, SHANMUGAM, SRINIVASAN wrote:
> > > > > AMD General
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > Get Outlook for Android <https://aka.ms/AAb9ysg>
> > > > >
> > > > > -----------------------------------------------------------------=
-
> > > > > ----
> > > > > --
> > > > > *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > > *Sent:* Tuesday, July 14, 2026 3:14:34 PM
> > > > > *To:* SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com>;
> > > > Deucher,
> > > > > Alexander <Alexander.Deucher@amd.com>;
> > > > > amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > > > *Cc:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil
> > > > > <Sunil.Khatri@amd.com>
> > > > > *Subject:* Re: [PATCH] drm/amdgpu/userq: properly account for
> > > > > resets
> > > > >
> > > > >
> > > > >
> > > > > On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
> > > > >  > AMD General
> > > > >  >
> > > > >  >> -----Original Message-----
> > > > >  >> From: Alex Deucher <alexander.deucher@amd.com>  >> Sent:
> > > > > Tuesday, July 14, 2026 2:09 AM  >> To: amd-gfx@lists.freedesktop.=
org  >>
> > Cc:
> > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,  >>
> > > > > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike  >>
> > > > > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>  >>
> > > > > Subject: [PATCH] drm/amdgpu/userq: properly account for resets  >=
>
> > > > > >> We need to increment the reset counter, force fence completion=
,
> > > > > and set the  >> wedged event when a user queue is reset.
> > > > >  >>
> > > > >  >> mes_userq_reset_queue() handles this for collateral damage,
> > > > > but the caller needs  >> to handle this directly for the original
> > > > > guilty queue.
> > > > >  >>
> > > > >  >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>  >> C=
c:
> > > > > Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>  >> Cc: Prike
> > > > > Liang <Prike.Liang@amd.com>  >> Cc: Sunil Khatri
> > > > > <sunil.khatri@amd.com>  >> ---  >>
> > > > > drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-  >>   1 fil=
e
> > > > > changed, 6 insertions(+), 1 deletion(-)  >>  >> diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > >  >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > >  >> index 6aa75da27f912..5e1262636e1e9 100644  >> ---
> > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > >  >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > >  >> @@ -146,8 +146,13 @@ static void
> > > > > amdgpu_userq_hang_detect_work(struct
> > > > >  >> work_struct *work)
> > > > >  >>                                                         queue=
,
> > > > > NULL, NULL);  >>                else  >>                        r=
 =3D
> > > > > userq_funcs->reset(queue);  >> -             if (r)  >> +
> > > > > if (r) {  >>                        gpu_reset =3D true;  >> +
> > > > > } else {  >> +
> > > > > atomic_inc(&adev->gpu_reset_counter);
> > > > >  >> +
> > > > > amdgpu_userq_fence_driver_force_completion(queue);
> > > > >  >> +                     drm_dev_wedged_event(adev_to_drm(adev),
> > > > >  >> DRM_WEDGE_RECOVERY_NONE, NULL);
> > > > >  >> +             }
> > > > >  >>        } else {
> > > > >  >>                gpu_reset =3D true;
> > > > >  >>        }
> > > > >  >
> > > > >  > After the original queue was reset successfully, it did not
> > > > > update gpu_reset_counter, complete its pending fences, or send th=
e wedged
> > event.
> > > > >  > mes_userq_reset_queue() already updates gpu_reset_counter,
> > > > > completes the pending fences, and sends the wedged event for the
> > > > > other affected queues,  > but skips the original queue because it
> > > > > has already been reset.
> > > > >
> > > > > What is the rationale of sending multiple device wedged events on
> > > > > a per queue basis?
> > > > >
> > > > > The question of whether drm_dev_wedged_event() should be emitted
> > > > > once per queue or once per overall recovery seems like a broader
> > > > > design discussion.
> > > > >
> > > >
> > > > Along with that, also need to consider if device reset_counter need=
s
> > > > to be incremented on a per queue basis or based on reset event
> > > > recovery. It could get incremented multiple times inside this -
> > mes_userq_reset_queue.
> > >
> > > Looking at the current flow, both gpu_reset_counter and
> > drm_dev_wedged_event() are updated once for each successfully reset que=
ue. It
> > would be helpful to clarify whether they are intended to be updated per=
 affected
> > queue or once per overall recovery.
> > >
> >
> > What are the semantics around the reset counter and wedged events?
> > Presumably each should be incremented for each queue that is reset? If =
a hang
> > affects multiple queues shouldn't each be a separate "reset"?
> > In the most common case, there should just be one since queue reset sho=
uld be
> > able to reset just the guilty queue.
>
> Thanks for the clarification, Alex. Understood that the reset counter and=
 wedged event are intended to be updated once for each queue that is reset.

Well, I guess that is the question.  We are the semantics around these?

Alex

>
> Best Regards,
> Srini
>
> >
> > Alex
