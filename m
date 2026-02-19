Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EA0C531CB
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 21:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C124C10E74E;
	Thu, 19 Feb 2026 21:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Frp57pIq";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E5810E766
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 21:01:02 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124a7216c9cso144911c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 13:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771534862; cv=none;
 d=google.com; s=arc-20240605;
 b=HAeJ0wCI3AkD6d5XBOJcHbt+/NwrIFyaTpIei6p/+8KjgjuX8FF2DltDFIy2+JUR/2
 aHIBJBph851inyv+GHtAFUe2vPu1UrHwYhTsQZW/6b+IfUxrvcn2j90kTx3+j4awebAd
 paOHxLMQ0LV1XtTixbyz1Pq+LNZz5AqxidvuZA5sIxgfuPX6Ja68C/bHO1p/Sb+E+/OD
 g5WYjb/xOiJlNjX1U5o+tOJO1DODk+2c7SpZWx7EhYi8WeZoE+phf1HU261B1d+Sr2HL
 i/6QF3krbibiOAOfOKvHt9csRBWZM1IuMat19ScGGsBup+UKeW4Ad8fsc8kQQAak9JuG
 m4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0PPyVVLAcp3G+WaD2vy3cNWWUGjwPgDF3ZSaqTuBYms=;
 fh=v0URucQiGKvY/ZNMgrNzcW9yI7K6eiCFrkF4rdZyi0c=;
 b=JNV3jxnmxGIsx9BLqbQZBnopimxgMCryA2JCvHTosQKKjUF0WVPMNb430uVy80UFu7
 MlidlIMqKNTxjrErjAIBtXsyCdqe6M+oO3dCHaR+pz7ce0q7SSuE+Q7rrx9OqkZjfs5t
 H9ZO5Y82WYINiyBqKlEZMNjZ/4tkXUn8mcaMr3+kIf4mCp09ti1gTRgY5piRMqqwutlH
 i26rOCVq3JXpSnIRfz+pBK1XXoPGc3YtuOE+CJzKkFKKPdN5LZFmnwlh8IvSDsQYhiHZ
 JsemkWNsTPqLHqKq8o86DTgkPLaWMvyvYpie86G9nAalQMcB/O0qBGh5UZbklGbEz43x
 Rgiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771534862; x=1772139662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PPyVVLAcp3G+WaD2vy3cNWWUGjwPgDF3ZSaqTuBYms=;
 b=Frp57pIqk8apWSxwSzbjTbWqzmc9Zq7YquWZMPDBsA7wS4TBVCj4TO0JWdqWKCRVKm
 GrNDOCRFq0O6frI9jFLOAE4sRhOZXBAqz8Z7pFx7q2VXovvytaQauhJ8auJ4apW7jVFL
 UDKu4526cRX/Y/kzHZjTpSiREOfWrH/rhet2WHEwEDZLldI5EMIx8I5JOnu8QrMOFsIB
 ZEmHGUf4FwlBd0zXDinJklzWtIv9edSVcOgp2rHc58VEOdecnYgPWr1Ltv2OeOB0bFTg
 Gi/+ihJviVkl5RdmOdB3Idm9RlbdBHLV46tjZG7MqFZWbOMqW4x+TH59FJSMNd8xY6+N
 Cj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771534862; x=1772139662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0PPyVVLAcp3G+WaD2vy3cNWWUGjwPgDF3ZSaqTuBYms=;
 b=w2kHXipbXYB7i+31iyMCgQ3eey21unzwPhksENjlyArQHYwLCVY4O3MGrkXQTYqC0N
 b9V2o4zKhmk0dMIQsP1Kr5qVGZfstj2sx7sHm9sP1mHiPbehwkcCnPf6ytfIdGkro0nJ
 91RqGxydrfosVMNQ6CkiSWPJ8yfFOOi4MlAbK0qzIil4/e6YxaAQ91JKDLJdMxwigndX
 fTbSEqWGwN/Xzd7VqI3zGC6a5jsk6ulahGJWA/z5+yqC5LNDG7GXc5NacxZD8gFkQitq
 Luc4e1ehwNJw3GBvDIr/6Orukqz1Oemc7J71LB7Fy1YB/EkKSZDBNSoBq9vB5KckhbZ1
 jJvA==
X-Gm-Message-State: AOJu0Yw7WUroQVDBLpp4ryFz68HHk5KbjL81CVPL4x/AlpFfNbO4CRTp
 C/tPiknTnCFjZISF60t+33x5BWs09kqICmYt3DZwCc1ttbLLxhYBtnimYtbIZtEVP4245ol9rk5
 vBVZbTpDxbdOWgEIvM4Dazz0mRufiI74=
X-Gm-Gg: AZuq6aJDaiumlsAT2taUJCDvB6zk4nIRdyoL9lpgmoBY9hpbX75ZWuTGDQIgO/0wHeX
 7vyF0Hp313VqwgkrSmqKw9oxpiVSwsDmhLcTgE8CHZ45xbML/8f14BTlKbcI/GtztOidrDPjpVj
 HrXBFQJwjh/EbDns3e/lSNTgbfSXNitZeM1n21wwfjH6y/Hb12AwT/eF7g36VfYKxHf7P3lFRro
 oBG/4O9DBFRWkLobgYKN0W1w1GR0hnwLFExUX6qshqPytPDy8HPAbk75ZzbDPlk6sVEX3sr9654
 xbTuWjIvLhDJHlgf9q+PxILVOo03hxvf77moXJD40z3xkjtCR6Hz5+z1qOAbZ7p7qExlsg==
X-Received: by 2002:a05:7022:eac5:b0:127:332d:63e with SMTP id
 a92af1059eb24-12739968a00mr5258367c88.5.1771534861412; Thu, 19 Feb 2026
 13:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20260219000146.21818-1-capajj@gmail.com>
In-Reply-To: <20260219000146.21818-1-capajj@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Feb 2026 16:00:50 -0500
X-Gm-Features: AaiRm51egAMGb_7X26qR2whYgEuJyztBqAYB5HSrKBfFUVp7cQ32nw4H3udEJuw
Message-ID: <CADnq5_PF70O=JBq8zQB6qGgZMbJ1_GAOhqBwxBYBFg9zVHVqTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable pipe1 for Navy Flounder (GC 10.3.2)
 to fix ring timeouts
To: Jiri Spac <capajj@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, stable@vger.kernel.org
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

On Thu, Feb 19, 2026 at 6:00=E2=80=AFAM Jiri Spac <capajj@gmail.com> wrote:
>
> From: Ji=C5=99=C3=AD =C5=A0p=C3=A1c <capajj@gmail.com>
>
> Navy Flounder (Navi22, RX 6700/6700 XT, GC IP 10.3.2) suffers repeated
> gfx_0.1.0 ring timeouts when multiple applications request high-priority
> Vulkan GPU contexts simultaneously (e.g. VS Code + Brave browser, both
> Electron/Chromium-based).
>
> On GC 10.3.x hardware, high-priority contexts are routed to the pipe1
> hardware queue (gfx_0.1.0). When multiple processes compete on this
> single queue the Command Processor hangs, and ring reset fails:
>
>   amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 timeout, signaled seq=3D107=
039, emitted seq=3D107040
>   amdgpu 0000:03:00.0: amdgpu: Ring gfx_0.1.0 reset failed
>
> The seq delta of 1 is consistent with a single job submitted to pipe1
> that never completes due to a preemption/scheduling deadlock. Once reset
> fails the display manager crashes and the login screen appears.
>
> Fix this by setting num_pipe_per_me =3D 1 for GC 10.3.2, disabling pipe1.
> All other queue parameters are kept identical to the rest of GC 10.3.x.
>
> Reported-by: Ji=C5=99=C3=AD =C5=A0p=C3=A1c <capajj@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4985

Both gfx pipes have been enabled for years now on gfx10.3 hardware.
Can you provide your dmesg output on the bug tracker so we can see
what's going wrong.

Alex

> Fixes: 3b094d4df4b0 ("drm/amd/amdgpu: add pipe1 hardware support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ji=C5=99=C3=AD =C5=A0p=C3=A1c <capajj@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 1893ceeeb..a44103622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4773,7 +4773,6 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->gfx.mec.num_queue_per_pipe =3D 8;
>                 break;
>         case IP_VERSION(10, 3, 0):
> -       case IP_VERSION(10, 3, 2):
>         case IP_VERSION(10, 3, 1):
>         case IP_VERSION(10, 3, 4):
>         case IP_VERSION(10, 3, 5):
> @@ -4787,6 +4786,22 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
>                 break;
> +       case IP_VERSION(10, 3, 2):
> +               /*
> +                * Navy Flounder (Navi22): enabling pipe1 (gfx_0.1.0) cau=
ses
> +                * GFX ring timeouts under concurrent high-priority Vulka=
n
> +                * workloads (e.g. multiple Electron/Chromium apps). The
> +                * high-priority contexts routed to pipe1 contend on a si=
ngle
> +                * hardware queue, the CP hangs, and ring reset fails, cr=
ashing
> +                * the display manager. Disable pipe1 to avoid this.
> +                */
> +               adev->gfx.me.num_me =3D 1;
> +               adev->gfx.me.num_pipe_per_me =3D 1;
> +               adev->gfx.me.num_queue_per_pipe =3D 2;
> +               adev->gfx.mec.num_mec =3D 2;
> +               adev->gfx.mec.num_pipe_per_mec =3D 4;
> +               adev->gfx.mec.num_queue_per_pipe =3D 4;
> +               break;
>         default:
>                 adev->gfx.me.num_me =3D 1;
>                 adev->gfx.me.num_pipe_per_me =3D 1;
> --
> 2.51.0
>
