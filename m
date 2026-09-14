Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E6DC88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E123410E889;
	Mon, 14 Sep 2026 12:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pxlpBnSC";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CE210E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 10:21:49 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so5725510a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789381308; x=1789986108; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2mF+xH5cIcST6u0nrbtly+TRzH2eXbiWgA+pO5N6DIg=;
 b=pxlpBnSCCiWsDWRC7mNj6/ve7h9XwpWKj0v6BWdordwqJMd21KKqxlwCB3cyg4HPL4
 +X1FIlRCxQowT3+vR0yVRoQ3UbV7GMrFk0osPvi1sWiBPwYzXeeK6bp5h8GK84wFkJh2
 S6kbLYd/dAHfAlQr/IVJRB0GRjNUFATjWTzDlwDsTHj76cpdLmrQAWKsNUWpfI2tH7vp
 QsshrC/qDwo70F7KF2yAVuVutMI18gPd2d5dRYA45ZL0bCrKlTgMqC2VDansV13IBJIZ
 IT0xDcNV7A4Zz64JEo2HmkB7osGyIBZlEWjosYnBIZF3mYjC00dlQUynbVEVvDVG571J
 cnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789381308; x=1789986108;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2mF+xH5cIcST6u0nrbtly+TRzH2eXbiWgA+pO5N6DIg=;
 b=OBLB6870MZc733gM/RvKTZwLCDyHQ6v5mkYIVq2neCiaOrVg/Wh/HNLFCJ7kpS+hYO
 XeHnyqTDN3RjEEZMLf/PGayh4guVc3vJF12JkkdRuDmCFckR97B/njksM7Kgvg83Pxfx
 CSzL9ElwTOUVjJcBSxSjfK47jeGAZuP4VPL+TKxkEpW5pcZ/6XLx39QZewRm5DNGRhxT
 CHHtJaK+OiC3dV7SbgRbMUXjnjG0sxDzz3t0tWuuu8399xUpYVC8KcwfsVtabGcqKcjm
 uFqwINYNRMIFhSdkukpWHv1TupzszwC/kdO3mzbVjz+PUosVnQF6TRl5+7fqI35KKJIy
 dTMA==
X-Gm-Message-State: AFuF++nxMkn7o1tDsMwjNfOl/gfakpjsRkOWkQD5QMIcFxbY/NCh3icy
 Du6IWhxdlNyWUG/KGMfPD2UA+gSUzc2pdwcg5Kb9clAdOUUEbAIplDYH
X-Gm-Gg: AYBFou2JL9n0HdgLV80wdaPpSMLvZvA2Sl7SPMhWXsTGua/whsGAyr9ZHNYWl26EpUv
 sxU8lKgTXfic48OwmPBqnGzOJkrlDc0lZBZnWNLcz4e76I9UCiB2b2ZScxIGhkcw9fiBKE3POAy
 89GEy9Agq8HpxnZAn2Ql1M449/M+4LP0W8UYSClQK1OAUk9BmwgRkjTKcWBeS2EzXyJYXjRXpJh
 jEI3eI3/aZ6Up2lL2oVZWx44cLh8mMzzN+gKOadCgfFSxulZ3XZggs87OHbr4mWQgnaTdSD6GcX
 qAldwGKdNDpMUh2hunOFn9cs/RM1LjKoYhqHrYwjQMqa1yl5BZFIwntF+svirgeTZba+7ZrGW0j
 xIA6uIo6rLX+mIQvHCx/k3sKwvPs2d7GvYItdrXdtjYPi4SOMQe0wyDa+EYFTm4I17n25xjGunn
 dzcns5i/Dhzow6ZpM8jxWbm2c1FiE1O/RtLav9J0RlyJyodUHXnLlYqFXCAwFD9INd4FA=
X-Received: by 2002:a17:906:c10e:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c29b84b85a2mr122980466b.6.1789381307718; 
 Mon, 14 Sep 2026 03:21:47 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660234f2sm403605166b.12.2026.09.14.03.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:21:47 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:21:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: Leo Chen <leo.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Register DCN as a PMFW DF C-state
 client on DCN42
Message-ID: <aqfKt3Ry75gaA4Vz@stanley.mountain>
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

Hello Leo Chen,

Commit 53845307d52e ("drm/amd/display: Register DCN as a PMFW DF
C-state client on DCN42") from Jul 9, 2026, leads to the following
Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:686 dcn42_prepare_bandwidth()
    warn: variable dereferenced before check 'dc->clk_mgr' (see line 681)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c
   680	
   681		dcn401_prepare_bandwidth(dc, context);
                                         ^^
dc->clk_mgr is dereferenced here.

   682	
   683		/* valid C-state watermarks have now been committed to HW, so it
   684		 * is safe to vote "allow" to PMFW.
   685		 */
   686		if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
                    ^^^^^^^^^^^
so this check is too late.

   687			dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, false);
   688	}

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
