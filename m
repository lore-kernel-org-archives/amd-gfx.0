Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A756C636D7
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 14:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6685810E792;
	Wed,  8 Feb 2023 14:13:26 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8EBF10E78D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 14:13:23 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id 20so14784275oix.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Feb 2023 06:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XEc+YMR/q8WGAbLGzsbCZhNQMPY6ljT9TBFsDFMVWOM=;
 b=oaSGYBWk5ZPYNKGs8VG7hQd9wrwq/MJ0ZQqnojRWq6pUeJEHmNjoxqaPttBdsirNYO
 B8LgAdvqAxQ+PYd6yNJC9eFU7EtmwVB4nxGRu/bMPiB0bDaJRhCKYcglhbGOhJ6anoXb
 LDebA6KAaSH6jZztmfGzjRc70A2CYVTHoT8rfD1CeXBciMVhCV89q6PSFP7da9xgqI3z
 R9hos7AieCW6lavD+UQbnRefuSxVwd5fO8UhadEUPTFvBkFZYzXsju23YMINanVPKOrT
 I1TFaEiPf4XDIo9Xn47Hs/ezxujt2nQfy+C4w+gj0s24bU0iCMQhVSVRaI5/OzcAT8ml
 4tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEc+YMR/q8WGAbLGzsbCZhNQMPY6ljT9TBFsDFMVWOM=;
 b=Zt2LMzk3Z8rYkByN+W0M41kKLsahS0uEOZD8nlo77W6bfwm2S9K1AhlEyIQ+OyeCaK
 pF86X3BVF57Bc3dUPJMOzJbIAo4mMVJcjcQ47XXkhTEW2ndy5BS4F5kZVZkDn91HL3vb
 5wFEXT9QqdClpvhNdftkNcbFTOp1XPvzmhNR46EP3cPzjyeD9POnJTm7Aq+eEufAOlim
 1k1edc0HWDLsyr0/3+KliJEJdjFFvegALxhinMTr83bDcamE0TkkqPlna4dUpYUrTQSe
 gAczE8zkevTlKNeAn5Ooj0VfkmE1r6ABFhY5U7GPc6L3Li44V24H47TkWkDcBjbyOmyz
 1FYw==
X-Gm-Message-State: AO0yUKVG9R+O4yp9Loynu8r/tVlBqNa65ihH49+/isagUCJ1zGlJRA/Q
 hZO0NJd35bZ7cQQtECX2pt9SLU7bOkDQOXrqjyY=
X-Google-Smtp-Source: AK7set+3oUVtdylN+oASAAcWPCXM5+Yd8DRLdOCMdSXtpKkY1W6ex+EK9IDd1cNwpUKYB7TNdB4GgvvfInezQsQpEV8=
X-Received: by 2002:aca:3dd4:0:b0:378:4edd:a89c with SMTP id
 k203-20020aca3dd4000000b003784edda89cmr234957oia.46.1675865601597; Wed, 08
 Feb 2023 06:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20230208072519.2412564-1-Jun.Ma2@amd.com>
In-Reply-To: <20230208072519.2412564-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Feb 2023 09:13:10 -0500
Message-ID: <CADnq5_PVOebmN49JzthxjMBudR=eXb42iw8k9-8Gwub-aA5d3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the warning info when unload or remove
 amdgpu
To: Ma Jun <Jun.Ma2@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 8, 2023 at 2:26 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Checking INVOKE_CMD  to fix the below warning info when
> unload or remove amdgpu driver
>
> [  319.489809] Call Trace:
> [  319.489810]  <TASK>
> [  319.489812]  psp_ta_unload+0x9a/0xd0 [amdgpu]
> [  319.489926]  ? smu_smc_hw_cleanup+0x2f6/0x360 [amdgpu]
> [  319.490072]  psp_hw_fini+0xea/0x170 [amdgpu]
> [  319.490231]  amdgpu_device_fini_hw+0x2fc/0x413 [amdgpu]
> [  319.490398]  ? blocking_notifier_chain_unregister+0x56/0xb0
> [  319.490401]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
> [  319.490493]  amdgpu_pci_remove+0x5a/0x140 [amdgpu]
> [  319.490583]  ? __pm_runtime_resume+0x60/0x90
> [  319.490586]  pci_device_remove+0x3b/0xb0
> [  319.490588]  __device_release_driver+0x1a8/0x2a0
> [  319.490591]  driver_detach+0xf3/0x140
> [  319.490593]  bus_remove_driver+0x6c/0xf0
> [  319.490595]  driver_unregister+0x31/0x60
> [  319.490597]  pci_unregister_driver+0x40/0x90
> [  319.490599]  amdgpu_exit+0x15/0x44e [amdgpu]
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 466054719842..5fb919cd9330 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -620,7 +620,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
>          */
>         if (!dev_entered)
>                 WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
> -                       psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
> +                       psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA &&
> +                       psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_INVOKE_CMD);
>
>         memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>
> --
> 2.25.1
>
