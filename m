Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE63C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA8F10E6D8;
	Thu, 25 May 2023 16:57:35 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555C610E6D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:57:34 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5552e031f47so456648eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685033853; x=1687625853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McBhd+7mTe52GIHijhOk99gzQMAOGW3feIo9aUSSsJ8=;
 b=jbnIvoF6xhTnz9Xis4/DC8rvWy5YAIpJwxcNGJX/WTXFkkSBRagc9R2x9miVAo55Uu
 aKvDlhpTZSsgHiOvVr6ik6/jleO7Bdfrg2/F8WAxzv8075SZruc3QNz4ZhMWE5Iy7z4U
 oXYKyF1lh84Y2Tvz/TKPSu95bdJ/OZ4BSLiK6VlLJhmKTFVVkw0WduYd9NGn0nN1riuq
 1nB2I4MyzVtCvhloFj44eDHZYiaQcbp48Rvrl/Wh1mtGqxczZYHpHfPZbVfCm5waEFV6
 4sg+ZCDOpRNuvsgAvJhpIpK+xNXCykFrv9tFqxCEME2ESSDrNLm/4DlAOcE6igXT6+fj
 42TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685033853; x=1687625853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McBhd+7mTe52GIHijhOk99gzQMAOGW3feIo9aUSSsJ8=;
 b=fYljmwo6JEZftTA+QC7ScNoL9NIRkUtV7ItQhSl5ZtHqVQmFmlm+EERgUrme1928U6
 xzVfvQmjO8B47gRWFkJVf0StZys4lWoUP4uDUOaCoy+tRNAFjN/UabHHgMOEZoKV5t0U
 lleCYY633dR0/kuScf8R4Heqca+Jhv5XAB1LLryNnhRo7lmG06Pi2Gf/F1uNGmpnYVn7
 6SBqqsXtmyCxol4ccHssBSnDIAYyRcV0dlxx/dEi/9k1tVR4ALWxf8kWjKp8S2J+nvtA
 OJ8vnS3K+xWFwHKmnUpPGLNrvjI6mMZAKn+9Ykn3XTxT6GjYvO5htq/a6ORFrge5XOpd
 c1JA==
X-Gm-Message-State: AC+VfDwX/3mQywCk8VIH54CaEhRaZXWhmnpxXI+GDA7F8DeEWJToo6+v
 mvy5+inMu/SGYT9NTozyugLHAeLlvcFgcMxc5r7RODTF
X-Google-Smtp-Source: ACHHUZ7o5KeGcPQOyevcDFeTJL8y1t4PQuct+pBY4PyslE7XzMPXDYAReEOUtgCzLMNrOTapN4PSRSfBs4J/8/Ik3JI=
X-Received: by 2002:a05:6820:45:b0:555:2ba8:a75b with SMTP id
 v5-20020a056820004500b005552ba8a75bmr7663069oob.1.1685033853131; Thu, 25 May
 2023 09:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230525161455.750526-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230525161455.750526-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 12:57:22 -0400
Message-ID: <CADnq5_PnWUJ9GktxToxHw+soy16nvnZ6wBPhODgR6Or=MxX69A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix up missing kdoc in sdma_v6_0.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 25, 2023 at 12:15=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Address a bunch of kdoc warnings:
>
> gcc with W=3D1
> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter o=
r member 'job' not described in 'sdma_v6_0_ring_emit_ib'
> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter o=
r member 'flags' not described in 'sdma_v6_0_ring_emit_ib'
> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:946: warning: Function parameter o=
r member 'timeout' not described in 'sdma_v6_0_ring_test_ib'
> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1125: warning: Function parameter =
or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'
> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1176: warning: Function parameter =
or member 'vmid' not described in 'sdma_v6_0_ring_emit_vm_flush'
> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1176: warning: Function parameter =
or member 'pd_addr' not described in 'sdma_v6_0_ring_emit_vm_flush'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 1c90b5c661fb..967849c59ebe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -238,6 +238,8 @@ static void sdma_v6_0_ring_insert_nop(struct amdgpu_r=
ing *ring, uint32_t count)
>   *
>   * @ring: amdgpu ring pointer
>   * @ib: IB object to schedule
> + * @flags: unused
> + * @job: job to retrieve vmid from
>   *
>   * Schedule an IB in the DMA ring.
>   */
> @@ -938,6 +940,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>   * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
>   *
>   * @ring: amdgpu_ring structure holding ring information
> + * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
>   *
>   * Test a simple IB in the DMA ring.
>   * Returns 0 on success, error on failure.
> @@ -1167,6 +1170,8 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struc=
t amdgpu_ring *ring)
>   * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
>   *
>   * @ring: amdgpu_ring pointer
> + * @vmid: vmid number to use
> + * @pd_addr: address
>   *
>   * Update the page table base and flush the VM TLB
>   * using sDMA.
> --
> 2.25.1
>
