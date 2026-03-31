Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9188410FCACC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19F910EED6;
	Wed,  1 Apr 2026 18:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ExGjnv4c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kap40kjn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9675A10EB94
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VKX7Zm3363546
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=; b=Ex
 Gjnv4cRYbBcnoWP5H/dLR6n48B9J1sTVKiTQZXxU0BoU8dxXO5dscAbXvvlfVA+v
 DfkwTOrt6dpnY3yIncxH84L5furMm99iMKrhdzRnV5xr8saPU8IOM5gS5QlsD+e9
 nFb9a2lDjTfpOqkcAzksxKv8TKDxBKsOdLIA3rovkWPJ/kNM0cHMWErKb+8p8syC
 oIvs/CxxpCUG3jbbg6faWy3shnAjzSBREbHqKuHfwxqd2VdGLHZoAM0k+4EDHLDp
 WleH3Pt4VXAiXjU3G9IJeubOyhEDlNHVZp+hHLFrlTZ6xAhXhC8b5T5fklNC7RKb
 4jeZ7ijjIqr+FdvB+I/w==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddg116-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:24 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d9d3230cf8so1091895a34.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774989564; cv=none;
 d=google.com; s=arc-20240605;
 b=WTu98VigdiJw9SU2DVJUsQccmBaIZ7N4tghEY/8jYwce/Eu6H4SLdyHIu0Fn79pbuH
 WPbgKy6Y6Ziaw0i9T9ccjD2lIWtxnA+OohEzDKpR0hbWsYhhu1bd+02RRtaHANzsaPNT
 FnvkELBFBHgMSUhwHKQJuhjNhxDvfGFKW+chgaOzrV6KmiZ/rWw1/2FhkqPJAIvqAOy4
 VPfjzz+T28BlT96AHXRbyE4Tn03j3UgizSMHTAmeCFgV9vL97tmNrSi49zspCLT5pQVs
 EJzUH5lhMYBqjsTj8Ve9bcWv8rdzuHMMov0Rz6INgVHmbP7kgHJBqQTwozFlrcfQ3diC
 ulsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=;
 fh=g6rxfPSX3A6avXFvsc6SR05Z7rDZz4+joT+rk+VXKeU=;
 b=iJ8gHClVaL1NETSw/ta4KDe3rrvHLBErcO+Hi0bHZXXVSRQO6WY6YucUYVcDIeKz+K
 68hJYrk4MTHRKc+ZDLLju9egFdDVuSTND9QPZ63DG8M8dmORaJHCIqW07DyJ8ago74dY
 sFkdFmHhCutv6jN+HT6Jbu2l50Nrr8b5JQoR7//JVE/hgrqcCDYUbawe9snaxL1q4jAg
 fohpjxylcfmuWunOMWR707MqDegg77w/OACq6P5dA+vTNOszM6TYxoNer/B6HgSdK727
 mhc04HXNjH15DYgokXyoA69g83tSoQL91P2Fw80czMoBtI4LjUdL8MYALlt6ZdlS+ySx
 cI9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774989564; x=1775594364;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=;
 b=Kap40kjnfGuefZvypHJvNk+lNhBmjP4DCtqWCCS0HsXQDyene0U37FrQezebiktJcH
 X7aY7iYbEY+kkkqSuZ3TrRvJ4yK/X3XJjMG03CPm11+Qd1veQrd8B49lBOHrYS/7s3h7
 eP3XaVgDqj2pNrqCWjEmVb+cuf9w6eC/7Ky7s7BRmafRLhgDOSqqB5SBO6iP5dsDIHKn
 j17+vKKIZrYxJY9Qc0zDcCF4ncD2xqV7RqhmhY15zTkCF0b5xGClmF0Zl+UyFQ3hExem
 8SwHxYePtCaTYlgeJ3tF/byKKqgHVzWZuWzXBkuglD978OZecT83mEJ6ES/RCUuIrMXb
 Y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774989564; x=1775594364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=;
 b=Yo4s54deFlCJbiHiKVoQRciZsiVJbCbmNw6fjeYqHBYtzYe5nNeq01vplEmisb9WQU
 8hEOn3JEa+oDeMBA9jIgXr1mJEYfn03xZ7Jyb8C6oqE1XWWxt2A63UZsAho6wsTcOlTD
 roN95ejb/KLqTiPs/ME4HTV6eTPh12/KA17CPeJXc4kWRjqrbJb4CpHP2qCZO4lkJ0n3
 C06g+TFtPJkyEjw5RaTIKpucBpwj1otuEdkLijrJkcyv1x1zTqY2LcvKgrQpN4UZMi0Z
 X/jdbbRy97NwMcLConG0fmZi+As6X96b5/Xs4htftKFZUS+4sub98z1KnGB4TOVpBeIH
 IWAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuGCqEocL+ntjVr+IvHtf70s+iqRdkLRarO/OFgRWD9qvk9ILKLe86G8JxOYyt0+uhd8SEJlQf@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+zTxPfph0IGZxJ2ikeqbHpCjY2RpwsO6BDdnaubHnGFNIAFwy
 ubvtzpKLwei5DK927jkmv3o+pDfkvFclf+Fw7KrcLRhUWoLZHRoD+dRtTfafzkrYZA1d0Te3J5O
 hgW5xnSiJCmgh4fRPW5CJX+23fk9GImC5E/TOScX5U3XMv85COoSqz5mE756dSfP3PkL5wRbOrB
 q81JHOj7RaeKiCmb7dsPg/GcDQSWjfZZkgzaxcTdBzNjU=
X-Gm-Gg: ATEYQzwZhDvfBwmgp3cnv71aTprJnP9afJEZMXd3bJ7cbeGg50p+9A3O8HqcFimFAOY
 ybI+bgK4VYhT/f3GwHZde53cr/6bJYskYnX5JWmQxzeEPhYomDOJ6VHkj1XUTF4Oac01MOiwGN1
 WMn3vh3QNrGTki1QuP10+BQKSQxHqK9CJuYXT66+W88GSBujzucGqbB5dx6WCpfplET1J4Cuhmm
 30O7Es70BMV2RSWGTL5/CFtruDlwU+pFlskcg==
X-Received: by 2002:a05:6830:1bda:b0:7d7:c79a:cb69 with SMTP id
 46e09a7af769-7da3775aa76mr2018799a34.18.1774989563895; 
 Tue, 31 Mar 2026 13:39:23 -0700 (PDT)
X-Received: by 2002:a05:6830:1bda:b0:7d7:c79a:cb69 with SMTP id
 46e09a7af769-7da3775aa76mr2018781a34.18.1774989563512; Tue, 31 Mar 2026
 13:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
 <CACSVV03FFvi0c4XMEShmH5ou4OKKZcvvni2j=0DBoYnuT55ecQ@mail.gmail.com>
 <bd45632be1a5bcd2ce34834b45a35254e23f7679.camel@linux.intel.com>
In-Reply-To: <bd45632be1a5bcd2ce34834b45a35254e23f7679.camel@linux.intel.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 13:39:11 -0700
X-Gm-Features: AQROBzA8VsO3mMQtD1h3R-Aco6tohePIO4VrDwi1_DI8AqCbRSrROyb9UzFEmww
Message-ID: <CACSVV01XKYegc3B-WAdDCCPYX1M8As1k42kT75JVjKeY+7QAWA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/msm: Remove abuse of drm_exec internals
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69cc30fc cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=pqXIF9v9MgCKvzB1QCwA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: nyzp0LmseNuyCL0A1nUa91Q4ZgIP2Jw-
X-Proofpoint-ORIG-GUID: nyzp0LmseNuyCL0A1nUa91Q4ZgIP2Jw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE5NyBTYWx0ZWRfX2FwqHpRzHrdr
 PSS5Ll0bEYbNjuWQCTIFJ0ZoI9ox/clARMKV48gBRiQu4oxvzsYpv4q18nZTR/IRuBf2wRien1f
 f0mczpR43r8OOu67QxBbnfi2//s+POgdvG0gczeIwlvZubTbD011BUwn156WeL05TCGn3ffHHU2
 96UKmgVk3Q7EEC9cN16I4+JIq9N//jv+YxUU9Jl9aeUU6JZ9xB557KWDhZocym4hl3JRMYO1Zlx
 fnsq0vODCU3iaKiAZKikWG8erQSvov/JE8vuNpwmqk08pq1skil1zBUmqi7crWj2anH+RtMS3o4
 0bGIWCfmbgEKDd8JbqCt5SGgDcH6/6cCxmPGL6+iZP3c2fFazhj7ht4yOvw9eeV6dddPFe9yEDS
 CUdImgRzoQYcgzf4dAxA6lD8u2f4BvQIzJXZ9AmKWLLeY2nmTVkQKnoqU3b/lZ0MG1A1dgP8v2t
 2cP7pjvn4BZ4yW2tVCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310197
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 31, 2026 at 12:52=E2=80=AFPM Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> On Tue, 2026-03-31 at 12:08 -0700, Rob Clark wrote:
> > On Tue, Mar 31, 2026 at 2:21=E2=80=AFAM Thomas Hellstr=C3=B6m
> > <thomas.hellstrom@linux.intel.com> wrote:
> > >
> > > The code was reading drm_exec internal state to determine whether
> > > the drm_exec structure had been initialized or not, and therefore
> > > needed cleaning up, relying on undocumented behaviour.
> > >
> > > Instead add a bool to struct msm_gem_submit to indicate whether
> > > drm_exec cleaning up is needed.
> > >
> > > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m>
> >
> > Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
> >
> > This is pretty stand-alone, so I can pick it up for v7.1.  Or ack for
> > landing it via drm-misc with the rest of the series if that is easier
> > for you.  It shouldn't conflict with anything in flight.
>
> Thanks Rob. Please pick it up and I'll exclude it from the next
> iteration of the series.

Will do, I have it queued up:
https://gitlab.freedesktop.org/drm/msm/-/merge_requests/227

BR,
-R

> Thanks,
> Thomas
>
> >
> > BR,
> > -R
> >
> > > ---
> > >  drivers/gpu/drm/msm/msm_gem.h        | 1 +
> > >  drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gem.h
> > > b/drivers/gpu/drm/msm/msm_gem.h
> > > index cb32093fda47..762e546d25ef 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem.h
> > > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > > @@ -452,6 +452,7 @@ struct msm_gem_submit {
> > >         bool bos_pinned : 1;
> > >         bool fault_dumped:1;/* Limit devcoredump dumping to one per
> > > submit */
> > >         bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
> > > +       bool has_exec : 1;  /* @exec is initialized. */
> > >         struct msm_ringbuffer *ring;
> > >         unsigned int nr_cmds;
> > >         unsigned int nr_bos;
> > > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c
> > > b/drivers/gpu/drm/msm/msm_gem_submit.c
> > > index 75d9f3574370..26ea8a28be47 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > > @@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct
> > > msm_gem_submit *submit)
> > >         int ret =3D 0;
> > >
> > >         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> > > +       submit->has_exec =3D true;
> > >
> > >         drm_exec_until_all_locked (&submit->exec) {
> > >                 ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> > > @@ -304,6 +305,7 @@ static int submit_lock_objects(struct
> > > msm_gem_submit *submit)
> > >                 return submit_lock_objects_vmbind(submit);
> > >
> > >         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> > > +       submit->has_exec =3D true;
> > >
> > >         drm_exec_until_all_locked (&submit->exec) {
> > >                 ret =3D drm_exec_lock_obj(&submit->exec,
> > > @@ -523,7 +525,7 @@ static void submit_cleanup(struct
> > > msm_gem_submit *submit, bool error)
> > >         if (error)
> > >                 submit_unpin_objects(submit);
> > >
> > > -       if (submit->exec.objects)
> > > +       if (submit->has_exec)
> > >                 drm_exec_fini(&submit->exec);
> > >
> > >         /* if job wasn't enqueued to scheduler, early retirement:
> > > */
> > > --
> > > 2.53.0
> > >
