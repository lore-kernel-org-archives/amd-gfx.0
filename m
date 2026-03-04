Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E15AEF9001
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 16:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F8510EA5E;
	Wed,  4 Mar 2026 16:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShGzyH9t";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6E610EA5E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 16:33:10 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bd5658b901so403637eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 08:33:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772641989; cv=none;
 d=google.com; s=arc-20240605;
 b=b0XltSf5heuxg7AtCejAM6t8AUh2b2cxVNZsgVpD1HYFhBSm2k0gAOARI432Nevbl+
 osXcCWJ6s2/jU8QXr+OP8Wr32MDUMS4r0byukO0M52USDTEheB3OgRcgZguz+XMNyyxW
 0crDKcg6J7bY/+8Yz9uwmeMkLZ0g01jK9LhD/8L+5/TRKtvucoSqMUnCId1Sr8D9AHTY
 RJWxLbHJmuMAjM14aR5QNGSGAKMB0UkMeS3DOqX2vvoqhEpVWiYHz5QwMIaa4UiIK6aS
 C+6xakZOE+QU69AxEXnSsaXXfQ6m2HssK5naU2OaW9G0M5a5rwIsdRIGxZ2R2n7bSu3Y
 ySpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j/giy9beQVz+/rScwRdpnZMgd2sdf7gAoO/VOU+Yy1M=;
 fh=MwYnbjbHwPfQYt9qEgYxtO/fSXMRZ6NX15+HysDrntE=;
 b=ICrh8KyevL7M9XQpqXs1MY68xNcKD+JzfAGQOXIjEYfv+UdDHHGaXkvyICQbWb5ynO
 m54zGx0OiUULvlGwKep3vDMSCVoO73LClJKQmzmDXl+1TIkgxlp/GOF3HJ75uwl0BXGI
 oIaHoscf4D7Rpzh/d6k+U6OF94zZ7MANy20q1SAZh/nLHSY350jW+a5qGQcDrZqOzZPb
 WXGG3PTsfw759cBPpydKkE2RlACedF65rZJlMyyoOkZ4rs1oabYwaUhogRFS9ZQSoMxX
 MIpuYMwy0VPU6DCUzGkJRf+eNO+XI5MHxWjsAG9Zr/+YiU3B6fSOG8n1uQsu4hI6kboC
 80tQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641989; x=1773246789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/giy9beQVz+/rScwRdpnZMgd2sdf7gAoO/VOU+Yy1M=;
 b=ShGzyH9tZGIPrB5bp0TSu9SWOpZeLNx0Imq0cA7e5aTDvs85JOEGaqeGJ6poqZh4t1
 BjPEsjI0mHf+qUc9ZPRpg8lx/CJoYav7aNmt6CadQ2T2LF//mQ+/8xBr3LbZZFmMMPbj
 4az01wTp6rW+ILFmNZivKdl1eH8iJt07eEJPrx3avZlPzETWQJiPBieFXklVtQrQl8UK
 GQIbtF33aRIB5KmRvotDWj6IcLaMhKEHtOpxN7vWU/DDyPqKZkFve+ZRCLvEyMc3tgbr
 k397FP/Kx470UW7CR5DjpqxGOIz3KRT6XfzHmMYEYBQLUZUW+ghjeiiI6u3yntLEVS1G
 GBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641989; x=1773246789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/giy9beQVz+/rScwRdpnZMgd2sdf7gAoO/VOU+Yy1M=;
 b=EyXTt9j6oH36mVZ4GJTh6sPuIcxzMz/5yU/dduWmRZQ1vH8IDf+zgGQM3QmkvzhA7j
 dGhR0yHvY3XZjxGcx0HqyHjd4Vt9dicww8tQZZBNmbfEwUo5D/SVwrsSJzL20VI3ijZr
 2YY7GZiv9cMFg+LKXoAwf3JBUwrJeEYKn3HVkloC2Vy42gOt393NEqtxiRbQGQb8pkZf
 jv+KiKW4L06uGT+1FP9pFrHKVe71ifMl1wurLzI8vqLbmdXLlCkx0LjMlHeBi0MY8pKH
 qSOTRzCxFkQf1CMlQvQwq7olWemGWNKisoYoa5i2L9OLu8IntlC3dLVXy6vjNq1m5SFg
 dc9g==
X-Gm-Message-State: AOJu0YzP71JiFKS/7sWZA1d4kvnCG6f6s+ukhOpzh+AZQ9gebFhkKeB7
 ifzcVPOIfaXvkJnFtmhFJn/D432HQsLhV+IkXskazlxrp3EW+Vo3VBhiFusGLg4ff5dX638T0z7
 0osCG6dX/LQP3SNCKU8OVn3H+PqgPu3s=
X-Gm-Gg: ATEYQzwqTIVlDItg41QR5BR6F4Kyr45+YvODHkNIEPkhtenKCAjttjGNy57a2OrrNHZ
 OU9kkpRaoTO4EiLPWp3cRVmC4JckNoQjVvv1UcdeCTOUMPQp9GK+0yCIsYnGl9vlKJZEqeCJTUH
 ECmzXAnGo3vwaIKEnXIWHrBs5mHLcpc7eGOZbFem0011KuQZ2J7QFUxKjbb9OQf1gNd9ioNA0nu
 M7P2ZYkhPCdf/XPzl27UOWKkL9ZO94P3V5QZJVIdrqny+XOzcZHiu/T3DaPsX01XkKvOcCSy0dF
 8IcLQpBib8DD9HQnoseA3r3Tfx7yqr16AU4v84AaZoxa5XtGuDcB5+hW/+uadxfcS6yNSdJAoKN
 yooG5
X-Received: by 2002:a05:7022:68a8:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-128b70bad39mr594783c88.4.1772641989260; Wed, 04 Mar 2026
 08:33:09 -0800 (PST)
MIME-Version: 1.0
References: <DGQ49PK0QE7U.3O1AQPSD6NI7I@rcpassos.me>
 <DGTZWNGLPVI3.108P2EKGFCO2R@rcpassos.me>
In-Reply-To: <DGTZWNGLPVI3.108P2EKGFCO2R@rcpassos.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2026 11:32:57 -0500
X-Gm-Features: AaiRm534Q6doSjPpf0QK4yrPoiBJU1oTbMFooDJnGdR_5oZDeZtS9L4TkUxGtUQ
Message-ID: <CADnq5_Msmohg3T5KLrqPwvJGbXPOMKeNN-ZcqgTS2pHb+GjuYQ@mail.gmail.com>
Subject: Re: [bug report] 7.0-rc1 flip_done timed out: amd igpu off when
 resuming in laptop (regression)
To: Rafael Passos <rafael@rcpassos.me>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, 
 Bhuvana Chandra Pinninti <BhuvanaChandra.Pinninti@amd.com>
Cc: amd-gfx@lists.freedesktop.org, siqueira@igalia.com, 
 linux-kernel@vger.kernel.org, Martin Leung <Martin.Leung@amd.com>, 
 Ray Wu <ray.wu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Rafael Passos <rcpassos@ime.usp.br>, 
 davidbtadokoro@ime.usp.br, dri-devel@lists.freedesktop.org
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

+ Harry, Leo, Bhuvana

On Wed, Mar 4, 2026 at 8:42=E2=80=AFAM Rafael Passos <rafael@rcpassos.me> w=
rote:
>
> I found the issue, but I'm still not sure how to proceed.
> I would like some guidance in fixing this regression.
>
> The issue is the where a Register is being read from.
> Before this change, the MICROSECOND_TIME_BASE_DIV reg wa read from
> dce_hwseq_registers (dce_hwseq.h) and now from dccg_registers (dcn20_dccg=
.h)
>
> The bisection lead me to this commit: 4c595e75110ece20af3a68c1ebef8ed4c1b=
69afe
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D4c595e75110ece20af3a68c1ebef8ed4c1b69afe
>
> After lot of debugging, I traced the issue to this file:
> drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/d=
rivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c?id=3D4c595e75110ece2=
0af3a68c1ebef8ed4c1b69afe
>
> This card is dcn21, but it uses most of the dcn20 implementation.
> For easy comparison, the following block contains the function with the o=
riginal path
> commented out (from dcn21), and the function it calls from dcn20:
>
> ```
> bool dcn21_s0i3_golden_init_wa(struct dc *dc)
> {
>         if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_po=
ol->dccg->funcs->is_s0i3_golden_init_wa_done){
>
>                 printk(KERN_CRIT "AUYER in %s", __func__);
>                 return !dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa=
_done(dc->res_pool->dccg);
>         }
>
>         printk(KERN_CRIT "AUYER in %s", __func__);
>
>         return false;
>
>         // original flow:
>         // struct dce_hwseq *hws =3D dc->hwseq;
>         // uint32_t value =3D 0;
>         // value =3D REG_READ(MICROSECOND_TIME_BASE_DIV);
>
>         // return value !=3D 0x00120464;
> }
>
> // is_s0i3_golden_init_wa_done -> dccg2_is_s0i3_golden_init_wa_done
> bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg)
> {
>         struct dcn_dccg *dccg_dcn =3D TO_DCN_DCCG(dccg);
>
>         return REG_READ(MICROSECOND_TIME_BASE_DIV) =3D=3D 0x00120464;
> }
> ```
>
> I instrumented this code to compare the values.
> On boot, the value is the same. When resuming from s3 sleep, different.
> If using the output of this codepath before this commit, the screen works=
.
> At the end of this email is my "debugging patch", and the logs comparing =
what shows
> up on boot vs on resuming from sleep.
>
> I am attempting to implement a `dccg21_is_s0i3_golden_init_wa_done` to
> replace the `dccg2_is_s0i3_golden_init_wa_done` that is used in dcn21_dcc=
g.c.
> Maybe dcn21 needs a separate register page, (insted of using dcn20_dccg.h=
)?
>
>
> Note the difference between log line 2 and 5
> [    4.956404] [    T316] AUYER PATCHED in dcn21_s0i3_golden_init_wa, val=
ues compared to 0x00120464
> [    4.956407] [    T316] AUYER in dcn21_s0i3_golden_init_wa, original fl=
ow value: 1180208, bool: 1
> [    4.956411] [    T316] AUYER in dcn21_s0i3_golden_init_wa: MICROSECOND=
_TIME_BASE_DIV reg: 13b value: 1180208
> [    4.956412] [    T316] AUYER in dccg21_is_s0i3_golden_init_wa_done
> [    4.956415] [    T316] AUYER in dccg21_is_s0i3_golden_init_wa_done: MI=
CROSECOND_TIME_BASE_DIV reg: 0, value: 1148576
> [    4.956418] [    T316] AUYER in dcn21_s0i3_golden_init_wa, NEW flow va=
lue as bool 1
>
>
> 1 [    4.942660] [    T343] AUYER PATCHED in dcn21_s0i3_golden_init_wa
> 2 [    4.942662] [    T343] AUYER in dcn21_s0i3_golden_init_wa, original =
flow value: 1180208, comparing to 0x00120464 bool: 1
> 3 [    4.942665] [    T343] AUYER in dcn21_s0i3_golden_init_wa: MICROSECO=
ND_TIME_BASE_DIV reg: 13b value: 1180208
> 4 [    4.942668] [    T343] AUYER in dccg2_is_s0i3_golden_init_wa_done: M=
ICROSECOND_TIME_BASE_DIV reg: 0, value: 1148576
> 5 [    4.942671] [    T343] AUYER in dcn21_s0i3_golden_init_wa, NEW flow =
value as is: bool 1
>
> On wake from S3:
>
> 1 [  279.431636] [   T5497] AUYER PATCHED in dcn21_s0i3_golden_init_wa
> 2 [  279.431638] [   T5497] AUYER in dcn21_s0i3_golden_init_wa, original =
flow value: 1180772, comparing to 0x00120464 bool: 0
> 3 [  279.431640] [   T5497] AUYER in dcn21_s0i3_golden_init_wa: MICROSECO=
ND_TIME_BASE_DIV reg: 13b value: 1180772
> 4 [  279.431641] [   T5497] AUYER in dccg2_is_s0i3_golden_init_wa_done: M=
ICROSECOND_TIME_BASE_DIV reg: 0, value: 1148576
> 5 [  279.431642] [   T5497] AUYER in dcn21_s0i3_golden_init_wa, NEW flow =
value as is: bool 1
>
>
> The "patch" (just a test lab), to understad where these logs came from.
> I applies cleanly to amddrm drm-next, and mainline.
>
> ---
>  .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |  3 +++
>  .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 25 ++++++++++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c b/dri=
vers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
> index 13ba7f5ce13e..0ba20c7969ed 100644
> --- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
> @@ -158,6 +158,9 @@ bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *d=
ccg)
>  {
>         struct dcn_dccg *dccg_dcn =3D TO_DCN_DCCG(dccg);
>
> +       printk(KERN_CRIT "AUYER in %s: MICROSECOND_TIME_BASE_DIV reg: %x,=
 value: %d",
> +               __func__, dccg_dcn->regs->MICROSECOND_TIME_BASE_DIV, REG_=
READ(MICROSECOND_TIME_BASE_DIV));
> +
>         return REG_READ(MICROSECOND_TIME_BASE_DIV) =3D=3D 0x00120464;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> index 062745389d9a..143c552e0fa9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> @@ -88,10 +88,28 @@ int dcn21_init_sys_ctx(struct dce_hwseq *hws, struct =
dc *dc, struct dc_phy_addr_
>
>  bool dcn21_s0i3_golden_init_wa(struct dc *dc)
>  {
> -       if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_po=
ol->dccg->funcs->is_s0i3_golden_init_wa_done)
> -               return !dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa=
_done(dc->res_pool->dccg);
>
> -       return false;
> +       printk(KERN_CRIT "AUYER PATCHED in %s, values compared to 0x00120=
464", __func__);
> +
> +       // original flow
> +       struct dce_hwseq *hws =3D dc->hwseq;
> +       uint32_t value =3D 0;
> +       value =3D REG_READ(MICROSECOND_TIME_BASE_DIV);
> +
> +       printk(KERN_CRIT "AUYER in %s, original flow value: %d, bool: %d"=
,
> +               __func__, value, value !=3D 0x00120464);
> +
> +       printk(KERN_CRIT "AUYER in %s: MICROSECOND_TIME_BASE_DIV reg: %x =
value: %d",
> +               __func__, hws->regs->MICROSECOND_TIME_BASE_DIV, REG_READ(=
MICROSECOND_TIME_BASE_DIV));
> +
> +       if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_po=
ol->dccg->funcs->is_s0i3_golden_init_wa_done) {
> +               // new flow
> +               bool v2 =3D 0;
> +               v2 =3D !dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa=
_done(dc->res_pool->dccg);
> +               printk(KERN_CRIT "AUYER in %s, NEW flow value as bool %d"=
, __func__,  v2);
> +       }
> +
> +       return value !=3D 0x00120464;
>  }
>
>  void dcn21_exit_optimized_pwr_state(
> @@ -298,4 +316,3 @@ bool dcn21_is_abm_supported(struct dc *dc,
>         }
>         return false;
>  }
> -
> --
> 2.53.0
>
>
