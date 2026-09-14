Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D808C88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A400A10EE25;
	Mon, 14 Sep 2026 12:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f/xVubnU";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E051C10E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 10:18:57 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a9983162dcso3880967a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789381136; x=1789985936; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cPP5td9MAORHe1l/GFVMlFJbMlk9RTsBaXkMCRs+hdM=;
 b=f/xVubnUi+gCwr6fn148IW8IDLAUc7EJAYatPsgvEqFM3YFg3VZgsg3slJugJwm7Qm
 akAlg+Lgg8cwaQ9n8zcLaTof0YQ7nJbRXLzwwExIhHEcXKsqAYr1G3YkxURLH7mOKe4m
 YR4gMJ6CkUX6UgY8vxCJfSq3514UZ0cbqitWaT36N6N+myxOlZY+c/R3cIFIPFr5VJbw
 IwtDgeG8LQmsDG2nNwTW+ZXqGgQfGIgSGJvAvIMFVK6X6Xgn7xWAI3lWwmlSuy6Zt4B4
 6EtHStUnJP3fuFuz3XHwazM8oHuoYBFI3nLfQ9yIm+oVCjWOfuajh+Idvkj/XtfViKlY
 HomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789381136; x=1789985936;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cPP5td9MAORHe1l/GFVMlFJbMlk9RTsBaXkMCRs+hdM=;
 b=gLvOTN8tC+ptdGsaMKjnSXC8MORASymXKAQrQfNxhsdVBOgRM1egY5M+C3PMpkiAFS
 4wSxGUCg0DhInnMBxj9SXhXyv2kKgOvjOy2tClB0XFufums9NQm0xTXK7L5Bv5v6dZui
 ruTzG+B/PK/ajz0qijZpOti++9E6x+Yiz9fyYhnIBMpvMU+MY/ZvjdBIpAOFFfrGSiwU
 rjl7Vxv8XkhPzXClidNSBHMEhzm6DCl2Q9kT0flu1f79739ofUBI2jp+nI0/LQ/GOrGV
 4oJ6ywNzmKQAONaJINaOwvpF4ZU+sroHqpvVsQVwgUdkEl6Fvi9f54kaiyZVJ/2arwxh
 0j8Q==
X-Gm-Message-State: AFuF++nOJrHG3MDnT6hd1cru60056jVhPI2aW7XMBBi6jVpQdcBSUK8U
 xFhnAVjQJ6wsRsOxubv0bvwYO8uC24A1X5S5WfXy6rg4/1UAnq03rfkO
X-Gm-Gg: AYBFou10mUxlo+t61stCeJjFiCBRk2FHkttFuTCobMicCTLERWdBH3dVimdCRhkfITM
 nmI5aTZEQeMfmgYOiAmeS+IS5EZjr71voklj3xO3Vj9atHedeNfHUAvTdq0NMfk7IFkeF2G8Jp/
 ArV1yyD2NUWrmLom9XmCPHjYuYkpcJMjB1mOK/rji4OYGoBrY3FNTwgPNdqP2dTJ/19GcaeFEQa
 w2b07l54hZ9cWvK/izJ/7oh9Y+eM03RHjb2efEY3rqkdg9TCeFCcK4eXSOGjMljIx3kSP9G+9V3
 eVm2NWJuosOroY+nEsF63fxG4Qt7sFufF8BjYITBCFgHLVHbF0e2KuCui2u2NY/6VBN3Pk2HS2c
 2Fhxgx5/ETPRmU6eq1YjCOnIN8RtDJu8sxKx8SUbcpXYv9DgexxuleqeVT8cHvbbXNbcra2ncBn
 D9xVCxovPcIeUb5Jarbm3jPLQ8mtHVw/JSc3rfeDMLmxEr+VuPx9aRGvCiGH1a8xu/OBk=
X-Received: by 2002:a05:6402:3245:b0:6a9:9833:2ecf with SMTP id
 4fb4d7f45d1cf-6a9f62265a4mr896459a12.10.1789381136056; 
 Mon, 14 Sep 2026 03:18:56 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b592470asm3936498a12.17.2026.09.14.03.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:18:55 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:18:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: Improve ualink state transitions
Message-ID: <aqfKCyOnoxf0oxIX@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 14 Sep 2026 12:47:06 +0000
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

Hello Lijo Lazar,

Commit 0a6da5dcfe42 ("drm/amdgpu: Improve ualink state transitions")
from Jun 9, 2026, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c:169 amdgpu_ualink_info_set_accel_state()
    warn: variable dereferenced before check 'info' (see line 164)

drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
   163	{
   164		enum amdgpu_ualink_accel_state cur = info->accel_state;
                                                     ^^^^^^^^^^^^^^^^^
The patch adds a new dereference

   165		enum amdgpu_ualink_accel_state target;
   166		bool ppod_validated;
   167		bool vpod_validated;
   168	
   169		if (!info)
                    ^^^^^
The old code assumed info could be NULL.

   170			return;
   171	

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
