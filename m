Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCFBC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 22:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D038764F0C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 22:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D038764F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589F36E16D;
	Mon, 15 Mar 2021 22:28:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2D06E16D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615847290;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hWdPnON1/a9SvTfhLxwcNBcUTA+XUV5FOv0Ei5AJXeo=;
 b=CaOk1luJAxMXx+fDn/XED8O965K8QRV1nylk0pqnlabx6DMk+PA/nAEw1rHVMqo3L1OkaU
 W8WfDLGVzTXAdi0qzW3lyNZT1+HJ2b1sRYRptNo9tLpni0v3ye91Gb+rEv040Kk9KdeFH0
 HRZSu6IKo7Z9RB/KzYQXY5TeDTuuHR8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-OOmoQpSfNRW8aWJ3eH7z-w-1; Mon, 15 Mar 2021 18:28:07 -0400
X-MC-Unique: OOmoQpSfNRW8aWJ3eH7z-w-1
Received: by mail-qt1-f198.google.com with SMTP id r32so14911824qtd.16
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
 :in-reply-to:references:organization:user-agent:mime-version;
 bh=sqp38Oh+qFswdbt985bnVJbnyHryJHB7FqutvuCnxSo=;
 b=foTeUogi5iEfs5CUxeFB5tc6QVilnjCSnQ7bauwMLHjH38ZAmF2FNAFn2FVsgXxML9
 K8zw1wrFM8DcG7k1TcBGdfj/mbhqX9ofscKIOtxAFTKxI/WgK19+TWLtyf1nh5Sgh+zb
 oiWxlK4rwNmTy/V3Ah85kNUfE4k5+vwLmsHeDyo8gYNIbodPrvTclpsl02R2EzEY20Yr
 UqcwHC7NV8stOlelzJPMAAIykm6DeLkHgVfRXjslfbWSXH3DLC9m8kYH5FPt63PYhAgH
 5ahdCvpehXKbmnKQPUNiUgT5cOgCRucikuPsFnjefdXMwvqws4/YNeTSj57xoRGtiMij
 0puw==
X-Gm-Message-State: AOAM530DORD/GgQMnPlWbOtj43veeDqbmGqVoClrEyPo1oYUGU4npyZJ
 9P5XEj64ODq9MhkQJw4dfqS3IO+diHAAWx6NQ4Ux+AAfO8+Zr9eWeyXcdnw/ipXlT+NyW6nhqAG
 kJg12KSJl21e2uXOQ3TLHsHP4WQ==
X-Received: by 2002:a05:620a:2111:: with SMTP id
 l17mr27138009qkl.399.1615847286552; 
 Mon, 15 Mar 2021 15:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi7fxBxQdg1H70sjSu6koc+zBhPXyst553I1a24TmZBWqha32WC9ZzE0LmHhIkJKxZzc0QCg==
X-Received: by 2002:a05:620a:2111:: with SMTP id
 l17mr27137997qkl.399.1615847286337; 
 Mon, 15 Mar 2021 15:28:06 -0700 (PDT)
Received: from Whitewolf.lyude.net
 (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id b22sm13767371qkk.45.2021.03.15.15.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 15:28:05 -0700 (PDT)
Message-ID: <91e8bdfe7980626eb1f9473b3a9a221ea8a76884.camel@redhat.com>
Subject: Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
From: Lyude Paul <lyude@redhat.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Mon, 15 Mar 2021 18:28:05 -0400
In-Reply-To: <BYAPR12MB35286D39AED12CE30E1C2253EB959@BYAPR12MB3528.namprd12.prod.outlook.com>
References: <20210304200851.4937-1-Anson.Jacob@amd.com>
 ,<644d4643c1be3714ae9e7a643a528586d793dbe1.camel@redhat.com>
 <BYAPR12MB35286D39AED12CE30E1C2253EB959@BYAPR12MB3528.namprd12.prod.outlook.com>
Organization: Red Hat
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Reply-To: lyude@redhat.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============0486563434=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0486563434==
Content-Type: multipart/alternative; boundary="=-rFnfRRteioQm5d0Ug2ss"

--=-rFnfRRteioQm5d0Ug2ss
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2021-03-06 at 03:55 +0000, Jacob, Anson wrote:
> [AMD Public Use]
> 
> Thanks Lyude for testing the patch.
> 
> Are you referring to this issue [1] ?
> 
> Is it reproducible after applying this patch as well ?

Yes I am - and yeah, if you're talking about the patch you originally asked me
to try then yes- I'm still able to reproduce it with that patch applied

> 
> [1] https://gitlab.freedesktop.org/drm/amd/-/issues/1473
> 
> -- Anson
> From: Lyude Paul <lyude@redhat.com>
> Sent: Friday, March 5, 2021 6:08 PM
> To: Jacob, Anson <Anson.Jacob@amd.com>; amd-gfx@lists.freedesktop.org <amd-
> gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning 
> Tested-by: Lyude Paul <lyude@redhat.com>
> 
> That just leaves the KASAN error from read_indirect_azalia_reg, thanks for the
> fix!
> 
> On Thu, 2021-03-04 at 15:08 -0500, Anson Jacob wrote:
> > If get_num_sdma_queues or get_num_xgmi_sdma_queues is 0, we end up
> > doing a shift operation where the number of bits shifted equals
> > number of bits in the operand. This behaviour is undefined.
> > 
> > Set num_sdma_queues or num_xgmi_sdma_queues to ULLONG_MAX, if the
> > count is >= number of bits in the operand.
> > 
> > Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1472&amp;data=04%7C01%7Canson.jacob%40amd.com%7Ce9ea7130bcd945a194aa08d8e02ba9f8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505826204096667%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=GEyObPt%2FnEeU9Y7K2I30RS1TBMGbbUneQ6hWkR7pJLM%3D&amp;reserved=0
> > Reported-by: Lyude Paul <lyude@redhat.com>
> > Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > ---
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index c37e9c4b1fb4..e7a3c496237f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -1128,6 +1128,9 @@ static int set_sched_resources(struct
> > device_queue_manager *dqm)
> >  
> >  static int initialize_cpsch(struct device_queue_manager *dqm)
> >  {
> > +       uint64_t num_sdma_queues;
> > +       uint64_t num_xgmi_sdma_queues;
> > +
> >         pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
> >  
> >         mutex_init(&dqm->lock_hidden);
> > @@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct
> device_queue_manager
> > *dqm)
> >         dqm->active_cp_queue_count = 0;
> >         dqm->gws_queue_count = 0;
> >         dqm->active_runlist = false;
> > -       dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
> > -       dqm->xgmi_sdma_bitmap = ~0ULL >> (64 -
> get_num_xgmi_sdma_queues(dqm));
> > +
> > +       num_sdma_queues = get_num_sdma_queues(dqm);
> > +       if (num_sdma_queues >= BITS_PER_TYPE(dqm->sdma_bitmap))
> > +               dqm->sdma_bitmap = ULLONG_MAX;
> > +       else
> > +               dqm->sdma_bitmap = (BIT_ULL(num_sdma_queues) - 1);
> > +
> > +       num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
> > +       if (num_xgmi_sdma_queues >= BITS_PER_TYPE(dqm->xgmi_sdma_bitmap))
> > +               dqm->xgmi_sdma_bitmap = ULLONG_MAX;
> > +       else
> > +               dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
> >  
> >         INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
> >  
> 

-- 
Sincerely,
Lyude Paul (she/her)
Software Engineer at Red Hat

Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

--=-rFnfRRteioQm5d0Ug2ss
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head>

<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr"><div>On Sat, 2021-03-06 at 03:55 +0000, Jacob, Anson wrot=
e:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex"><p style=3D"font-family:Arial;font-size:=
10pt;color:#317100;margin:15pt;" align=3D"Left">[AMD Public Use]<br></p><di=
v><br></div><div><div style=3D"font-family: Calibri, Arial, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">Thanks Lyude for testing the=
 patch.</div><div style=3D"font-family: Calibri, Arial, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);"><br></div><div style=3D"font-fam=
ily: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);">Are you referring to this issue [1] ?</div><div style=3D"font-famil=
y: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);"><br></div><div style=3D"font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">Is it reproducible after appl=
ying this patch as well ?</div></div></blockquote><div><br></div><div>Yes I=
 am - and yeah, if you're talking about the patch you originally asked me t=
o try then yes- I'm still able to reproduce it with that patch applied</div=
><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; borde=
r-left:2px #729fcf solid;padding-left:1ex"><div><div style=3D"font-family: =
Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br></div><div style=3D"font-family: Calibri, Arial, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">[1]&nbsp;<a href=3D"https://gitl=
ab.freedesktop.org/drm/amd/-/issues/1473" id=3D"LPlnk">https://gitlab.freed=
esktop.org/drm/amd/-/issues/1473</a></div><div><div style=3D"font-family: C=
alibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
"><br></div><div id=3D"Signature"><div><div style=3D"font-family:Calibri,Ar=
ial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">-- Anson</div><=
/div></div></div><hr style=3D"display:inline-block;width:98%" tabindex=3D"-=
1"><div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"=
 style=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lyude Paul &lt;lyu=
de@redhat.com&gt;<br><b>Sent:</b> Friday, March 5, 2021 6:08 PM<br><b>To:</=
b> Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; amd-gfx@lists.freedesktop.org =
&lt;amd-gfx@lists.freedesktop.org&gt;<br><b>Cc:</b> Deucher, Alexander &lt;=
Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&g=
t;<br><b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds=
 warning</font><div>&nbsp;</div></div><div class=3D"BodyFragment"><font siz=
e=3D"2"><span style=3D"font-size:11pt;"><div class=3D"PlainText">Tested-by:=
 Lyude Paul &lt;lyude@redhat.com&gt;<br><br>That just leaves the KASAN erro=
r from read_indirect_azalia_reg, thanks for the<br>fix!<br><br>On Thu, 2021=
-03-04 at 15:08 -0500, Anson Jacob wrote:<br>&gt; If get_num_sdma_queues or=
 get_num_xgmi_sdma_queues is 0, we end up<br>&gt; doing a shift operation w=
here the number of bits shifted equals<br>&gt; number of bits in the operan=
d. This behaviour is undefined.<br>&gt; <br>&gt; Set num_sdma_queues or num=
_xgmi_sdma_queues to ULLONG_MAX, if the<br>&gt; count is &gt;=3D number of =
bits in the operand.<br>&gt; <br>&gt; Bug: <a href=3D"https://nam11.safelin=
ks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fdrm=
%2Famd%2F-%2Fissues%2F1472&amp;amp;data=3D04%7C01%7Canson.jacob%40amd.com%7=
Ce9ea7130bcd945a194aa08d8e02ba9f8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C=
0%7C637505826204096667%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DGEyObPt%2FnEe=
U9Y7K2I30RS1TBMGbbUneQ6hWkR7pJLM%3D&amp;amp;reserved=3D0">https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2=
Fdrm%2Famd%2F-%2Fissues%2F1472&amp;amp;data=3D04%7C01%7Canson.jacob%40amd.c=
om%7Ce9ea7130bcd945a194aa08d8e02ba9f8%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637505826204096667%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DGEyObPt%2=
FnEeU9Y7K2I30RS1TBMGbbUneQ6hWkR7pJLM%3D&amp;amp;reserved=3D0</a><br>&gt; Re=
ported-by: Lyude Paul &lt;lyude@redhat.com&gt;<br>&gt; Signed-off-by: Anson=
 Jacob &lt;Anson.Jacob@amd.com&gt;<br>&gt; Reviewed-by: Alex Deucher &lt;al=
exander.deucher@amd.com&gt;<br>&gt; Reviewed-by: Felix Kuehling &lt;Felix.K=
uehling@amd.com&gt;<br>&gt; ---<br>&gt; &nbsp;.../drm/amd/amdkfd/kfd_device=
_queue_manager.c&nbsp;&nbsp; | 17 +++++++++++++++--<br>&gt; &nbsp;1 file ch=
anged, 15 insertions(+), 2 deletions(-)<br>&gt; <br>&gt; diff --git a/drive=
rs/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>&gt; b/drivers/gpu/drm/=
amd/amdkfd/kfd_device_queue_manager.c<br>&gt; index c37e9c4b1fb4..e7a3c4962=
37f 100644<br>&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manage=
r.c<br>&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>=
&gt; @@ -1128,6 +1128,9 @@ static int set_sched_resources(struct<br>&gt; de=
vice_queue_manager *dqm)<br>&gt; &nbsp;<br>&gt; &nbsp;static int initialize=
_cpsch(struct device_queue_manager *dqm)<br>&gt; &nbsp;{<br>&gt; +&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t num_sdma_queues;<br>&gt; +&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t num_xgmi_sdma_queues;<br>&gt; +=
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pr_debug("num of p=
ipes: %d\n", get_pipes_per_mec(dqm));<br>&gt; &nbsp;<br>&gt; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mutex_init(&amp;dqm-&gt;lock_hidden);<br>=
&gt; @@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct device_queue=
_manager<br>&gt; *dqm)<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;dqm-&gt;active_cp_queue_count =3D 0;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;dqm-&gt;gws_queue_count =3D 0;<br>&gt; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;active_runlist =3D false;<br>&gt;=
 -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;sdma_bitmap =3D ~0ULL &=
gt;&gt; (64 - get_num_sdma_queues(dqm));<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;dqm-&gt;xgmi_sdma_bitmap =3D ~0ULL &gt;&gt; (64 - get_num_=
xgmi_sdma_queues(dqm));<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;num_sdma_queues =3D get_num_sdma_queues(dqm);<br>&gt; +&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (num_sdma_queues &gt;=3D BITS_PER_TYPE(d=
qm-&gt;sdma_bitmap))<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;sdma_bitmap =3D ULLONG=
_MAX;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&gt; +&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;dqm-&gt;sdma_bitmap =3D (BIT_ULL(num_sdma_queues) - 1);<br>&gt; =
+<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;num_xgmi_sdma_queues =
=3D get_num_xgmi_sdma_queues(dqm);<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;if (num_xgmi_sdma_queues &gt;=3D BITS_PER_TYPE(dqm-&gt;xgmi_sdma=
_bitmap))<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;xgmi_sdma_bitmap =3D ULLONG_MAX;<=
br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&gt; +&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;dqm-&gt;xgmi_sdma_bitmap =3D (BIT_ULL(num_xgmi_sdma_queues) - 1);<br>&=
gt; &nbsp;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;INIT_WOR=
K(&amp;dqm-&gt;hw_exception_work, kfd_process_hw_exception);<br>&gt; &nbsp;=
<br><br></div></span></font></div></div></blockquote><div><br></div><div><s=
pan><pre>-- <br></pre><div data-evo-paragraph=3D"" class=3D"" style=3D"widt=
h: 80ch;" data-evo-signature-plain-text-mode=3D"">Sincerely,</div><div clas=
s=3D"-x-evo-indented" style=3D"margin-left: 3ch; word-wrap: normal; width: =
77ch;"><div class=3D"-x-evo-indented" style=3D"margin-left: 3ch; word-wrap:=
 normal; width: 74ch;"><div data-evo-paragraph=3D"" class=3D"">Lyude Paul (=
she/her)</div><div data-evo-paragraph=3D"" class=3D"">Software Engineer at =
Red Hat</div><div data-evo-paragraph=3D"" class=3D""><br></div></div></div>=
<div data-evo-paragraph=3D"" class=3D"" style=3D"width: 80ch;">Note: I deal=
 with a lot of emails and have a lot of bugs on my plate. If you've asked m=
e a question, are waiting for a review/merge on a patch, etc. and I haven't=
 responded in a while, please feel free to send me another email to check o=
n my status. I don't bite!</div></span></div></body></html>

--=-rFnfRRteioQm5d0Ug2ss--


--===============0486563434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0486563434==--

