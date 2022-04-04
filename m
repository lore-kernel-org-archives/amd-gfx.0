Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBCFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6E810E6D5;
	Mon,  4 Apr 2022 19:46:10 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F5910E6D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 19:46:08 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id z12so19268851lfu.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Apr 2022 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=1upASloOetUN2vgt8dTfG9wFHGFB6pQWdQN7Kd2Q+Cc=;
 b=qjrnVYpTn1cW5ldwMEbn1mMM0dgLNeDD7KttIiWHFg/X9AjFP1U6SqYtys4a2Wte+A
 cPBwzFWTk1c5OtQaDUHX3HA18OrycqeC0eKDou2dGo48MpjjRZvDVvxyVDM3hogBv2so
 lMkzKrX2UbQzUOJGbkOGkL/Pkd9AAFNUpcoNYuTY6wpJftDdIXKazROOXm3vqOn2Nw04
 shITk1Mj4wXAfjlJv5SVpzQawnvpoGWhO1TJDzBG/LUxuQ0NzDsIYNjDr6VzirOBFhww
 lDe2uvLCwJrmT+L2FzbTZkpQw5Hglm9eah2YvuS3hFsKN22/X7bfopO0CM9efVw7DLt5
 sXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=1upASloOetUN2vgt8dTfG9wFHGFB6pQWdQN7Kd2Q+Cc=;
 b=j7KJUXVf2cRvuMusv/hfvim381gAAeOzgPSVQHRS3HiUiKSgs0csCGwcACPFRXsGyH
 JDcGb0XH38XJVfINl6B8WOaqLNziK+qjPjH19X1YQLJpnkj3W3XIIQJVabUMVUZ5roLe
 SpUkhva+aEGOF1DxwSf/oHRPxuMWU1y/+Vz8i0AXU4NOg4/ipYlGlQHPZeunNWlzAG+4
 J7SiuEtPxHvE9/2Nm1oIp1rCL05bGJ5jAIKCmBzxIZMgnwRjtR3VeXeC8YLXbylhTS9F
 JJ8j6FgtPZkRw3XJOn1YtoqbeKKd9ysm1xAg9xOm6B0UG5zDC9TOxpwWHotE32VMJZyL
 5Y4Q==
X-Gm-Message-State: AOAM530Rj/fKVkS4oYzIitr+U/b1MRDbUb+2mO2u0jfsVO1Csu7ijJJQ
 VmJtAEzpHEhnIRF7L0ZzqsM=
X-Google-Smtp-Source: ABdhPJxX3WZeAfm+9PcAkZ8c6QurvZ7tKT9ZTTVtuUYL65E/a+LwKnIV7CzGPBm5TWLe0LBXAG2gzw==
X-Received: by 2002:ac2:4adb:0:b0:44a:d01:e2a with SMTP id
 m27-20020ac24adb000000b0044a0d010e2amr727647lfp.338.1649101566714; 
 Mon, 04 Apr 2022 12:46:06 -0700 (PDT)
Received: from [172.16.41.128] (078088109026.wroclaw.vectranet.pl.
 [78.88.109.26]) by smtp.gmail.com with ESMTPSA id
 bp4-20020a056512158400b0044332792f30sm1239011lfb.175.2022.04.04.12.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 12:46:05 -0700 (PDT)
Message-ID: <b90412bbea1439a614badede2450316099dd08e6.camel@gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
From: Tomasz =?UTF-8?Q?Mo=C5=84?= <desowin@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 04 Apr 2022 21:46:04 +0200
In-Reply-To: <CADnq5_Mh+auV8yNSqAet-zsC8WC+8=NZWmsbg-uON_166bJ8gg@mail.gmail.com>
References: <20220401195726.21436-1-Philip.Yang@amd.com>
 <3fce21b7-f1a0-28db-5322-6eb89a10fe8d@gmail.com>
 <CADnq5_Mh+auV8yNSqAet-zsC8WC+8=NZWmsbg-uON_166bJ8gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Philip Yang <Philip.Yang@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tomasz =?UTF-8?Q?Mo=C5=84?= <desowin@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2022-04-04 at 15:18 -0400, Alex Deucher wrote:
> On Mon, Apr 4, 2022 at 3:03 PM Tomasz Moń <desowin@gmail.com> wrote:
> > On top of what commit does this work?
> > 
> > It does not apply at top of v5.18-rc1.
> 
> This is stuff for drm-next
> (https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next).
> E.g., 5.19.

This does not compile on current drm-next, just like I noted in the
next paragraph of my email.

> > It does apply, but fails to compile, on top of "drm/amdkfd: Create
> > file
> > descriptor after client is added to smi_clients list" that is
> > commit:
> >    * cbe879c87245ce6272afe6456dbc8ce2c8f38d64 in amd-staging-drm-
> > next
> >    * e45422695c196dbc665a95526c85ff4b8752aff2 in drm-next
> > fetched from https://gitlab.freedesktop.org/agd5f/linux.git
> > 
> > The compile error is due to flush_tlb being undeclared.

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: In function ‘amdgpu_vm_bo_update_mapping’:
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:845:9: error: ‘flush_tlb’ undeclared (first use in this function); did you mean ‘kfd_flush_tlb’?
  845 |         flush_tlb |= (adev->gmc.xgmi.num_physical_nodes &&
      |         ^~~~~~~~~
      |         kfd_flush_tlb
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:845:9: note: each undeclared identifier is reported only once for each function it appears in

Best Regards,
Tomasz Mon
