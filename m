Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C57C10FCAD2
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50E910EE89;
	Wed,  1 Apr 2026 18:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aT60FZUu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MnmQ6rxA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B69810EAD7
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 19:08:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VHX5J83103973
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 19:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=; b=aT
 60FZUuy8A4IbOSs+BO2hguvHvzM+G61XTY1pG1b5tA7MA24iNTc3H7zYCbMUNdVS
 EVJ26EBsOcKMriR+B8bkdOg2al7gdXuao0Z96Kh7FVHzpaTh1Q4KPUwFdPbnpm8K
 IMkbjmbwXsPlc3ZJ9QZuHgB/cYUkPq3acGF6L+Eso1urVJrmJTP4rNMnj/nv5AG1
 f1BDw8NsdIqMgeffyZdMX7AN/LdhbSpdHl47EiTnNDhArK8C1gzg/aByaG4GigZO
 L9p/RnyWEaT5rkWx/p8eYhjKOeE2hZYYKR0CVtsW5/PxovOEvCD5RWYg+U5wXKrX
 CAljSIRuTLtwhLqkXGRg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js20ejh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 19:08:41 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-67e0df20fc1so23314605eaf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 12:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774984121; cv=none;
 d=google.com; s=arc-20240605;
 b=hhvdZT8o2bSw491EDI58qWiQzJg327/OPLXoKNJmiPuuEtFlxeYxYf+5GEwS9dxbFl
 BMMC+13yS9JQKVLR6Z9DNVKVwRLkLiuvT2ONR/EK2NNEfc7lbXZpl09QeWi4qQOD5jUL
 kVjPyNF25ViyTkMWG7EstJWMHrwM5faHncODARHnM2T0jqzQrIWs97xnf0wKptG3lHF4
 NKdjGXHbxTY5jIX4MIkUtXz7hxhFkZsIfuAfZjSqaeAOheHJ7Ea3dI+3TYmcLlMdZ8rY
 KVj8f+L/BpuugIe+Q6VNQY0/H2GYiDoIs3jdI4eBKoktmg5wkl4e9GsSh5FYR3Wk+G0b
 jsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=;
 fh=oRC25rBm0l6NF6zAcfv/w37LC83Tpf52Mhg+EUKVSnU=;
 b=dZ0Qeqct44AC++mgcYo6F/VB57y2dbel6Og0FiYHzav1soOXf0bQthYBHIUch2QoFN
 /mqxMwewFGa1ciSdxKmJnBt2ZThITcJUowAMk4xdO0R6NWsuLZBNduzLIM3VLsBZ2Oea
 J6NA3B0lwgHgLg8TRPnBDS3Q5kh1q/5CdWLIYRtN5yRr2OB+3ED6TXCvP8EluYk/20vN
 ZeEsS+5PNJCRLt4mY3YwHD86Zu9oiuqDmop0DwdE/BjotFG1MLQOwjEcdAiWtloH3qm0
 uEj7Z+unze7Isu4n2yvhS9G9Vq8Nw8rYEAiOptOi75Fv20J9Q4UQAPEdc8ksjOBufDl6
 27Kg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774984121; x=1775588921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=;
 b=MnmQ6rxAhHD3kIVXIkq+9rbUwQ9taTyeHe+dY2Db4KX1XxWxvIl3w27zbBd66xhqWc
 tfzpLvHlDhplnzDwDIBb9+GCtgMdNwgn1SCvDJc+QD+F6rjYJ9eY7/YSHOXWe5BS7WKt
 s5NIoBjsQB7rApulaofUCLRYfH9dWxh/bK3QCKmsxkHbSMHVV1dFmmv7KoHGDOqr2Jzd
 nA+caFw0N+/b8Z+GfUo1zRzWIrj/XXXc//p1yeZH4rIZAGn77k48A9KxlcIFg8NL0MTs
 1X39OVKp30KMvVkPfbaQoUvdcEO3voC/e4G/Q5XS4wrSRaOOWaJozoOSz3hRlBW7B/Ei
 tegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774984121; x=1775588921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=;
 b=HFy5PVI8pjmdpIEcjyqNxFH+cucv8bx3/InOF+Fa3MGWImzcHJfVMDyp+RhPN2rYtz
 Ri3pkZBNPf1+Wl3ZEx043FZlTlPcmTOv+177fxm5U3YlIMbiXSAXc9ajYN050yOBXxbV
 z+TV7wVovYuK5jOSq2CTd1DUxkclB4ya7navNuqgJ3PEgL82tyhrH141iL1kWthYmzdB
 VFvfmYcSUJw5b/ttxaR8/BHb6U8keWqtqjUSsMMpihowaduDKe7Z1u+GxHnSHcHUEdKd
 +3t14VaBusZlugboLnqob2l3DcGLfIbrfh5LIBJk9j28rK5eDi2Pskf3G4LLAur4lK7r
 rC4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYbIuiozEAu16hT2nVDGsLz57s5q7A4993iRJvJtMAGOU0aprCQpr3RJo4EzzGTBoQji2HTvo8@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9nhrQ2l0E7eS+KFkLSn9KnmFtE06+6cVNm3ZViCCRCdd9j9EQ
 9AB62rqMaz/5RWqI9mrsTCeHV+sWU/8ISErAI+XVh9nljhfeI/8amuWpwVJBbi/V/PvegYLe4rF
 unVjn2cgr97yyZHLwBI48DlZ0zkHJFua1VMi/2lGfUA59DKntNA42wTfgwF3YHneivC+A3oCq7L
 h3v/jey+Rf7W3hqYvIkJ8rvoUi3npagw82QeXNVVNJGQg=
X-Gm-Gg: ATEYQzypVFpwjiY1LeGgIGm9vHkd+dy3LaPIKueWpz+gw03ET/qSHxmBweoebjPpVE3
 rjP0ox6J/oAjkExNA+POvC92cffndl/U+dcrDeue34CyxWS1uP8hEMCoAAGebm6lHcGI5WbcsbH
 jtSnRqujHt0DH1GxaUh2PFU9z8nqW26Hs7vqNRStRsyn+m299hGWeQOmhHdZs/kaxpOMyITBOkZ
 /jnWjreFxSTDRKg3kk3WjTZ94y9viufRZEekw==
X-Received: by 2002:a05:6820:1390:b0:67b:c5ef:abcb with SMTP id
 006d021491bc7-67fabc3ccb1mr275725eaf.23.1774984121044; 
 Tue, 31 Mar 2026 12:08:41 -0700 (PDT)
X-Received: by 2002:a05:6820:1390:b0:67b:c5ef:abcb with SMTP id
 006d021491bc7-67fabc3ccb1mr275686eaf.23.1774984120592; Tue, 31 Mar 2026
 12:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 12:08:26 -0700
X-Gm-Features: AQROBzBvAateYSIgol1xE404p0QVo18CvuQ9I4yG1ka6RfVGOoveibudl0Ox9Yw
Message-ID: <CACSVV03FFvi0c4XMEShmH5ou4OKKZcvvni2j=0DBoYnuT55ecQ@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: N-zv0vQBOZtvggO0hsB_4y15TFSM-jpD
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cc1bb9 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=uC2hiXKo-rcvbCjx3PIA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4NCBTYWx0ZWRfX0TIxOdro6xBr
 2QDEv8R811QKYYp5nR336OB6hlc/J0woqFqkvFRTnTtoBnJ6pOtd6pyQP6gDlOfQPSAecoY01FH
 99magh03gGTkHt1+i0wddm0xPR8Kcud7Mn/T2O7Wj6xr3EgHogfuuoDSlTYRGf6jnGWaM8EzBlM
 F+F+kFm60FqJ/LQ6XcyLcXTPfbA2EkOgNgOMuqpmNclqKjNH1xmjTx1f8QNXSz2qhj27NLU+qSI
 278YLjynuc+FbJsg7O7fQolPdYqMQewlbd779gAjezBM4sdvDgAKY6NIY0GIhNHWCqt8Pm6lQwD
 EV+fefNi0lh3GLUzGNhTBwaUpgdWgfE34/+B0/U8VgDKtisQ0ixjg7XwpjKSOXYrk251e3DcGfX
 BVG2+XHVnIfNDQzfaH1KT7YKBnlSqjqvYz5j80zNzEjoZytb6SuMnX3CnfwqvLkZyKION9U8pi8
 IacltGEkbP9A7COCr9A==
X-Proofpoint-GUID: N-zv0vQBOZtvggO0hsB_4y15TFSM-jpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310184
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

On Tue, Mar 31, 2026 at 2:21=E2=80=AFAM Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> The code was reading drm_exec internal state to determine whether
> the drm_exec structure had been initialized or not, and therefore
> needed cleaning up, relying on undocumented behaviour.
>
> Instead add a bool to struct msm_gem_submit to indicate whether
> drm_exec cleaning up is needed.
>
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

This is pretty stand-alone, so I can pick it up for v7.1.  Or ack for
landing it via drm-misc with the rest of the series if that is easier
for you.  It shouldn't conflict with anything in flight.

BR,
-R

> ---
>  drivers/gpu/drm/msm/msm_gem.h        | 1 +
>  drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.=
h
> index cb32093fda47..762e546d25ef 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -452,6 +452,7 @@ struct msm_gem_submit {
>         bool bos_pinned : 1;
>         bool fault_dumped:1;/* Limit devcoredump dumping to one per submi=
t */
>         bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
> +       bool has_exec : 1;  /* @exec is initialized. */
>         struct msm_ringbuffer *ring;
>         unsigned int nr_cmds;
>         unsigned int nr_bos;
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 75d9f3574370..26ea8a28be47 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_=
submit *submit)
>         int ret =3D 0;
>
>         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +       submit->has_exec =3D true;
>
>         drm_exec_until_all_locked (&submit->exec) {
>                 ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> @@ -304,6 +305,7 @@ static int submit_lock_objects(struct msm_gem_submit =
*submit)
>                 return submit_lock_objects_vmbind(submit);
>
>         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +       submit->has_exec =3D true;
>
>         drm_exec_until_all_locked (&submit->exec) {
>                 ret =3D drm_exec_lock_obj(&submit->exec,
> @@ -523,7 +525,7 @@ static void submit_cleanup(struct msm_gem_submit *sub=
mit, bool error)
>         if (error)
>                 submit_unpin_objects(submit);
>
> -       if (submit->exec.objects)
> +       if (submit->has_exec)
>                 drm_exec_fini(&submit->exec);
>
>         /* if job wasn't enqueued to scheduler, early retirement: */
> --
> 2.53.0
>
