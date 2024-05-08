Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A403EC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 09:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF9B10E38D;
	Thu,  9 May 2024 09:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XcXZeNEu";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A340810FB8B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 12:29:42 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-a59cf8140d0so844786166b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 May 2024 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715171381; x=1715776181; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LB9ZlymN6uGLs75jdd8paZFsGMg3DqFW7xidEu9V7Wg=;
 b=XcXZeNEu9x939uUIAuDVQnUyXJqpp4JJTOWLcc0sdA/tXhB3e7/ed+I/LFw1eJm/Oa
 1YrMWMDQstAIYw9/OqlWl3+rx7CJRk9QCuTtxdhiPYIJNOs0LrnPg2/BY55/gRu8NuP3
 thkajIZ2A1pmP3TjRUzxIZ6G/5pzQKV7OTzm/g7sHG3vZIpJEOTwaoLLkdNjFtGarSwg
 VtaOPluXd5QUY2jOXzMgS66kQ+gu3fNGxCebYpHPVe3nGn0Wyn/Gbn6kfeEVPtFlFFvq
 imA66B9zjhBfF0n07hlhZKkFH8yYoLbS7hvQd871ewR/0zwFm2puJ0Awn095P9oNaa7n
 k1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171381; x=1715776181;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LB9ZlymN6uGLs75jdd8paZFsGMg3DqFW7xidEu9V7Wg=;
 b=bcygK06/kZVcPmstvdb+cakO/iWQLy9w/fYX+A18xl2HsftZAwzGZA532hYje5JKQF
 21IwDddoVkPq7bJgWIpSaHZuSAKXw4W5LxH+8z+R5/7xbrOb1DbAvtbf1fxxvqQl7Nmc
 YGuT1PfnYna/u/Hf3L2FM8/uK2CRmYeBuTOq4QhGnbVxDZD4s5OVkUIfoIkZr2+B3hja
 RLbdS2QmDj73U8D4028XKEGzqjCSCLndtXcOTqwuLlTGHnxs3iY31JPqH7JqlTJHb6MM
 SxDeI0Y0TLTK5lEjqUg8t7eneYRwFK+pOwReJCTLXFrvDNSS8stwPqbFv+XGtPzpFwF0
 cErw==
X-Gm-Message-State: AOJu0Yx0Kx8dqe8TW11ZDJoFRKywag/1O5cujgZHCmQEsCxkxND0zvq6
 40dgE8i/Y9y/AOvjVP5zMPHArOqmwimbbcrc+56X7negTBEWDZMGqNTZHDiS7c+yWJ8QCfYVpTl
 s
X-Google-Smtp-Source: AGHT+IFhj73sopPVlgBhDv9b7dZoA1+1LcInAx9lAH8JX90wKYNjiegWPjgQSjosidt0SduS4mur3Q==
X-Received: by 2002:a50:ccda:0:b0:572:9c4c:2503 with SMTP id
 4fb4d7f45d1cf-5731da69540mr1778618a12.38.1715171380537; 
 Wed, 08 May 2024 05:29:40 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 cf27-20020a0564020b9b00b0057270606829sm7600965edb.85.2024.05.08.05.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:29:40 -0700 (PDT)
Date: Wed, 8 May 2024 15:29:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingqing.Zhuo@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Introduce DML2
Message-ID: <41ac2ee2-290e-4c85-8df6-163bb168862f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 09 May 2024 09:11:44 +0000
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

Hello Qingqing Zhuo,

This is a semi-automatic email about new static checker warnings.

Commit 7966f319c66d ("drm/amd/display: Introduce DML2") from Jul 28,
2023, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:576 dml2_validate_and_build_resource()
    warn: variable dereferenced before check 'context' (see line 569)

    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:665 dml2_validate_only()
    warn: variable dereferenced before check 'context' (see line 662)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c
   568	{
   569		struct dml2_context *dml2 = context->bw_ctx.dml2;
                                            ^^^^^^^^^
Dereferenced

   570		struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
   571		struct dml2_dcn_clocks out_clks;
   572		unsigned int result = 0;
   573		bool need_recalculation = false;
   574		uint32_t cstate_enter_plus_exit_z8_ns;
   575	
   576		if (!context || context->stream_count == 0)
                    ^^^^^^^^
Checked too late

   577			return true;
   578	

regards,
dan carpenter
