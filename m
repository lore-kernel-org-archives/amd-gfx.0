Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856D1C7618D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 07:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0898E10E5F0;
	Tue,  4 Apr 2023 07:31:54 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF2310E169
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 06:50:14 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id j24so31669302wrd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Apr 2023 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680591012;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7vG2/aSJ1ryPEMKG409SA6jE/BoJuhjEwdd0NcyN9lY=;
 b=GC6i5kB+uj+cJUGHHEpaHzy8+KWoCn5i4Xz2Vg0CHGvQh9jZ/59GswTmYhOJ4J1KD3
 f8zfWmwXT/bZB9APqOL1w/uHWizvh2FOpTgXVhjkUYg3kVTo4QiIuvni4rcDh6mz7G2w
 y3W1lWydI/udpEa0tCB5C49WgcrvsZXwcK+4TnLL3O76yRSkLr+odvExfPXATzjNgsIH
 D4glgPWR+582/hlqw392G7vd1k5tR8BaRHpKej+oUr/EVG6TmrrxNsYpGPf4WwAMy9mN
 eJb6+mbn5a2vwBAgEg1wcM98rGk3m7Ad8265QJy/IiTfMZSkFJIlwfaavDh06MWev3Dj
 F7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680591012;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7vG2/aSJ1ryPEMKG409SA6jE/BoJuhjEwdd0NcyN9lY=;
 b=n5BvIts7RitqUtB2shXaJRqx8hMXq+QUpTjI8VMbFZGs7mLkoI+HCORCvMmPw2/67V
 MvfO5f2+1IAZ06olsTxVQsns/nu6knMAgWZkrIF9VKpsEH6XumF8ou3W0fU7MmOhr4WJ
 3Z/7bY2oEv5mk1yUd7vLpU71/l2iCLy4nHHWOPeRD3oqTo+BquC3hE6c9f80FYrquLVS
 bXKPifS0CpSOkqVMSCg6K8aejXpWDnawS8ZssFVM0wO0INoeqCY5+Jx8LQDEEfmPyb4K
 qoDGFjLUP9qYhFwNgspPqAX2bv/CtzHJWFcpfhX0ZeH12to/V5m+KgsDdTiHEgNg+aqL
 8JxQ==
X-Gm-Message-State: AAQBX9fbrUbT5uU7T1dub1B+bYiPFKBmPPdwJAxlMI0bTU8hKlqxoh9Q
 0oRFqJmfWfosXEAwnfE+vzE=
X-Google-Smtp-Source: AKy350aeqLI+ETFuHlpJwTTy4X2yycv1s7d41psRllflY1lCPf3Gfy09QRA0aH7qOv2lAhd/6mvIHQ==
X-Received: by 2002:a5d:4846:0:b0:2ce:a8d6:309a with SMTP id
 n6-20020a5d4846000000b002cea8d6309amr755882wrs.61.1680591011913; 
 Mon, 03 Apr 2023 23:50:11 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 a2-20020adfed02000000b002c55de1c72bsm11418192wro.62.2023.04.03.23.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 23:50:11 -0700 (PDT)
Date: Tue, 4 Apr 2023 09:50:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alvin.Lee2@amd.com
Subject: [bug report] drm/amd/display: Use per pipe P-State force for FPO
Message-ID: <22e834e9-a23c-4e32-a6e3-2279d280454e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 04 Apr 2023 07:31:53 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Alvin Lee,

This is a semi-automatic email about new static checker warnings.

The patch 4ed793083afc: "drm/amd/display: Use per pipe P-State force 
for FPO" from Mar 15, 2023, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:2009 dcn20_post_unlock_program_front_end()
    error: we previously assumed 'hwseq' could be null (see line 2003)

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c
  2002		 */
  2003		if (hwseq && hwseq->funcs.update_force_pstate)
                    ^^^^^
The patch adds this NULL check but hopefully it can be deleted.
Otherwise we are screwed.


  2004			dc->hwseq->funcs.update_force_pstate(dc, context);
  2005	
  2006		/* Only program the MALL registers after all the main and phantom pipes
  2007		 * are done programming.
  2008		 */
  2009		if (hwseq->funcs.program_mall_pipe_config)
  2010			hwseq->funcs.program_mall_pipe_config(dc, context);
  2011	

regards,
dan carpenter
