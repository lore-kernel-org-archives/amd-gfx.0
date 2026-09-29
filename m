Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD8CA5FB3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 07:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A12D10F5A2;
	Thu,  1 Oct 2026 07:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zixi5faG";
	dkim-atps=neutral
Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com
 [74.125.231.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935E310F071
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 19:19:25 +0000 (UTC)
Received: by mail-oi2-f42.google.com with SMTP id
 5614622812f47-4e849c5fe49so2743270b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 12:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790709563; cv=none;
 d=google.com; s=arc-20260327;
 b=FNUrG/Ycaaeu9/+pqORstP+6kM/qJ0m8a/CjkBQ96hJtNoeodggbJdqzjgQP/uBpZx
 1cmY154g4+0KR/CYjl4IpwRD+KbFjFlGesKlLBqCRTkofZuZIX10CuL7ByLnClE+i+hP
 e1OxndQLxaLYdnAFNVKm3utIJVfF82du32QLGuh3j5Ec+O3Rm8mUNl5E3h6CETjLSO7o
 5cboI9N4Sdrf/xE6ZneaZ52y41w/QfK4cnea2KyMVpgDEUmzAtbBEsDv5vpV1OQDO7qN
 +wf3bd8wleZWVbUVb6udqZ1JdJ70R+4JEnhBWz+8AVA6KadCWy/j9YUPR5sHH64jQypy
 rWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kzJgW1rsJZfo72Y77K+E8QsTkrVDWI4mp7BQj3TrqUo=;
 fh=9gFPfwZcI6CQrDy2zUIiF4+9XjZKVuJeRtII9S1+3SY=;
 b=CyCG5AjzAyARx8AsmdjEjN/AQIOqAsQH7yhNVKmjyar0t7Z4B8V2N5zlNmW0Y6acnZ
 Uuli7r3uKSR+vjz+F4fOZaPe0KgusxPFHwv23iGa70573j1RGs0LnQovQ2ci+xk/b1pO
 Wb/by9k0I6c6myMbXDBls+HHWrZZiBLF4W2LyEgJUsOicG9wZo9Wx30oaU6E2sze773I
 RgDosT86bbnscsYaLydAxS8s5f9LsItAgui0ygNF+3wJS5SNrtCuZJ87BOdB2lP1oA6C
 Hv1LrmzUixu/ghMdmvJjuStgZq5FnnJdk39BC5WtFysY7eXzXgR/JUKA0EmH6lNGdLqW
 zWsg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790709563; x=1791314363; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kzJgW1rsJZfo72Y77K+E8QsTkrVDWI4mp7BQj3TrqUo=;
 b=Zixi5faGCARIr10YoSmACtnAogM/1h/AJXrYd4DxpF7AuAwX3M6GoU4arms/5bBgbL
 coZY7lGrmGJAIdDTHRKsKM/gWdc2HVQD7XT9YTvXtFloy+L5sG5UJfVgqNDn6dkSwQ2O
 rgLIHK5ihUBqYQ4yStiqjkN1LCNCvHqRwAcM7+qDE2ic4vuAxoEJYtrq+xwhpZEBvOcM
 aUbXW+VlU8ziwQI1uoCPUuvhNVq1vvgkM+Awl0AuDj3HzntHyIWgds4tZcPiVg5AGrIH
 OTTDFagYBVV1da0JD2lfM3evzlBsCjSz0KkDavSOO40AT7JHCh//OPBOi3fNfZAnvCpD
 JnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790709563; x=1791314363;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kzJgW1rsJZfo72Y77K+E8QsTkrVDWI4mp7BQj3TrqUo=;
 b=m5bD7nePMgSsPLLhKbkQ0GYyhA/kouR9AEhJeF+gby7Almv/YWEfI2Uiuuz9Xh9uIP
 0ff9Sj66jE24z5tQaDx4ErPH/knbaITK0msiNxiJa/7BCwRlWP77G4Apg2gBXiw1Ztpo
 SxKohblicOeRWa0NruHBKEHJ+Q0Q0Zm1oXvJkNbT+2YjfiS51/AyRp6mBbAmopNWXFPR
 VEWH7bXxVXpaHdrA3TDctl4d0ZgVHCVQB290+SL4oOL5s2uCUTvJsekfbcBGW1zpdbMi
 /1CkUNE3G5jvS6F8BRWUO2uV5BvFgtsWSqqZpCo7UZUEmDDMk1sOcQGZkF7uoEdrx5T+
 lj+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyfJAg5dwWLHc8Pw6h+LGZzbZjgpc0cgBB3lvzJz/sk+RiLCmxI/dM0SNtpPW/7kj92/T7m1nV@lists.freedesktop.org
X-Gm-Message-State: AFuF++lmYExDy9a1dn/gSYpywQiG0eOP23CLv6+cPq1qwc8pbN55+pZm
 3ftDsg+8T6JlGN63OQBiAGaXjDWmedya0dpLs+KmBJx+dw7vY7u/ilBLF/XU3x5APrSfEz3n6bS
 KZDwNoUvkdmt9w14/55SSRoJzOG2YYM0=
X-Gm-Gg: AYBFou1XjLT4aiXFSWgAQ+MqGN1/T9ygqCBdchZhyUHDuemenIRpiWoXFlECkcx2GgC
 4erclHEuddrbZsYUeIhO+d7xGOnXnddlHl0QNpMlT4EHP2ef5CAyQ+sS8FKnQaJoNLC01ZkpWz2
 fFzuj2Gbht06b+L8KTd/q5/Bu+zEBHKWeNhAvfd4rvYPBtiopUeIONwpqv7F+X4rjLLVd3PRm6s
 Ia17jGLvJPiYzFjNfzZ6ruu6QgMEordpoE4yWWg4udCpIxKshtEgEKEvk3TS3tdfbG6KEwgUgGC
 zCmrknmKhoaSq+dN93CPJLSduTTBVuNHqDt3Wse7aV7qNKs+WQ225dMRxp9ZKXjCuxPNWXpubtO
 mku9Y9eEpPw==
X-Received: by 2002:a05:6808:1714:b0:4c3:82cd:601a with SMTP id
 5614622812f47-4f06a4671d5mr577481b6e.32.1790709563185; Tue, 29 Sep 2026
 12:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260926174406.346253-1-devnexen@gmail.com>
 <e5b5770f-8ae1-41c3-b5d9-53798dd3fd45@amd.com>
In-Reply-To: <e5b5770f-8ae1-41c3-b5d9-53798dd3fd45@amd.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 29 Sep 2026 20:19:12 +0100
X-Gm-Features: AclHuK-hjcBmIezQ0GYgI88OqlUbULC7G7Y8Vcu-Rocor7p5PAhT4RVRzBr4btA
Message-ID: <CA+XhMqzQRS4Re6YXONFmrt2rOOKoghyQqFgHu=Ziixpm2n4sLA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 01 Oct 2026 07:16:44 +0000
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

Hi Mukul,

On Tue, 29 Sept 2026 at 20:05, Mukul Joshi <mukul.joshi@amd.com> wrote:
>
> Hi David,
>
> Thanks for the patch. Yes the race is real, however, the patch needs some updations.
>
> More below.
>
>
> On 9/26/2026 1:44 PM, David Carlier wrote:
>
> [You don't often get email from devnexen@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The exporter records an importer when it answers NPA-REQ, so it can send
> NPA-REVOKE as soon as the BO is freed, before the importer has finished
> building the dma-buf for that handle. The revoke handler assumes a fully
> imported node: it dereferences imp_xa_node->dmabuf, which is still NULL
> until the import completes, and drops the xarray reference the importing
> thread still relies on. The importer then links the node and marks it
> READY regardless, so the node can be freed while still on the per-remote
> list.
>
> Only tear down a node that is READY. Otherwise mark it for teardown and
> send NPA-RELEASE, as nothing has been handed to user-space yet, and wake
> the importer if it is still waiting for NPA-RSP so that it fails right
> away. A node already in teardown belongs to whoever moved it there, so a
> duplicate NPA-REVOKE no longer touches it either. The importer checks for
> teardown under the xarray lock before linking the node and marking it
> READY, and unwinds otherwise.
>
> I think NPA-REVOKE cannot land before a NPA-RSP so we will not hit the condition where
> we have to wake up the importer.
> NPA-REVOKE is sent only when the exporter's XA entry's ref count goes down to 0.
> That will happen at the end of process_npa_req(), by that time, the NPA-RSP is already sent.
>
> Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
> Assisted-by: LLM
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> Changes in v2:
> - Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
>   in teardown neither dereferences a NULL dmabuf nor drops the node
>   reference twice (Sashiko).
> - Complete npa_done when a revoke arrives before NPA-RSP, so the importer
>   fails right away instead of timing out into a connection reset (Sashiko).
> - Use the current Assisted-by format.
>
> Found by code analysis and compile-tested with W=1. Not tested on hardware,
> as it needs two UALink-connected accelerators in a vPod.
>
> v1: https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 34 +++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8411ea17172f..cb35026e6eba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3265,6 +3265,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>  {
>         struct amdgpu_ualink_imp_xa_node *imp_xa_node;
>         struct amdgpu_bo *bo;
> +       u32 node_state;
>         int r = 0;
>
>         /* Remove the entry from the Xarray. */
> @@ -3288,7 +3289,23 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>                 return;
>         }
>
> +       node_state = READ_ONCE(imp_xa_node->node_state);
>         WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> +
> +       /* Only a READY node is torn down here. If the import is still in
> +        * flight, the dmabuf may not exist yet and nothing has been handed
> +        * to user-space: leave the node to the importing thread, which sees
> +        * the teardown state and unwinds, and wake it up if it is still
> +        * waiting for NPA-RSP. A node already in teardown is owned by
> +        * whoever moved it there, e.g. an earlier NPA-REVOKE.
> +        */
> +       if (node_state != AMDGPU_UALINK_NODE_READY) {
> +               if (node_state == AMDGPU_UALINK_NODE_NOT_READY)
> +                       complete(&imp_xa_node->npa_done);
> +               xa_unlock(&adev->ualink.imp_xa);
> +               goto send_release;
> +       }
>
> As mentioned above, NPA-REVOKE cannot land before the NPA-RSP is sent by the exporter.
> So, if the node_state is NOT_READY that means its a stale NPA_REVOKE and we should just ignore
> that NPA-REVOKE. Having said that, we should definitely do the teardown when the node_state is READY.
> We should also handle NPA-REVOKE while node_state is in PENDING state.
> So, maybe we can refactor this code to something like this:
>
> switch (READ_ONCE(imp_xa_node->node_state)) {
>     case AMDGPU_UALINK_NODE_READY:
>         /* existing teardown */
>         break;
>     case AMDGPU_UALINK_NODE_PENDING:
>         WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
>         xa_unlock(&adev->ualink.imp_xa);
>         break;
>     default:
>         xa_unlock(&adev->ualink.imp_xa);
>         return;
>     }
>
> +
>         list_del_init(&imp_xa_node->list);
>         xa_unlock(&adev->ualink.imp_xa);
>
> @@ -3299,6 +3316,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>         /* Drop the refcount for the node */
>         amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
>
> +send_release:
>         r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
>         if (r)
>                 dev_err(adev->dev,
> @@ -3760,9 +3778,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>                 return r;
>         }
>
> -       /* Add this node to the imported handles list for the remote GPU */
> +       /* Add this node to the imported handles list for the remote GPU,
> +        * unless the exporter revoked the handle while the import was in
> +        * flight. The dmabuf is released with the last node reference.
> +        */
>         xa_lock(&adev->ualink.imp_xa);
> +       if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
> +               xa_unlock(&adev->ualink.imp_xa);
> +               dev_warn(adev->dev,
> +                        "IMPORT: handle:%llx:%llx revoked during import\n",
> +                        handle.handle_hi, handle.handle_lo);
> +               return -EINVAL;
> +       }
>         list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
> +       WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
>         xa_unlock(&adev->ualink.imp_xa);
>
> The changes here makes sense. One nit-pick is to change from dev_warn to dev_dbg().
>
>         return 0;
> @@ -3938,9 +3967,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>                                         "IMPORT: XA import failed for handle:%llx:%llx\n",
>                                         handle.handle_hi, handle.handle_lo);
>                         goto cleanup;
> -               } else {
> -                       WRITE_ONCE(imp_xa_node->node_state,
> -                                  AMDGPU_UALINK_NODE_READY);
>                 }
>
> ACK.
>
>
> Regards,
>
> Mukul
>
>         }
>
> --
> 2.55.0

True, a revoke can't arrive before NPA-RSP, so
v3 uses your switch and dev_dbg():

Cheers.
