Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3B6C79FA3
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D0D10E682;
	Mon,  7 Sep 2026 07:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TtW8cTgx";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977C210E012
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 22:25:27 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b0231a3e86so1961980e87.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Sep 2026 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788647125; x=1789251925; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=up7v4iXfsfw0NZXjJnHOv6nLKWdrBroAhEtbXWzurTc=;
 b=TtW8cTgxX0ChAX/Gpc+v1/IPXZ6QlNkpH2WVd/qe6yjcvK++elcsKpS/a554d12sSt
 kp+9p2M2C2WdnmAh1scC4OURYjczlbJ/sgWuns7WEi4zZc5j1eyHBeAXBHpwpgOEdP0J
 P5hvlbxf8dbM2KVBxxlWZ46gUc/Ndi0lpwWr0AVI4B4LdVqHpK1PpBkTYBUYFzpcu3LH
 oTPj4/N+gGB6WBI4T35101otgLV3be9o3t+YdZms2UAwsuJD98KSdygP4CHWPJaIE9sh
 dXQF/zWT757imUmHbI49Etmd+VxuqTxxTKJ9S1cd9wZCyzLz4KWMQq2aLl2NTD5w7gKB
 ZAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788647125; x=1789251925;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=up7v4iXfsfw0NZXjJnHOv6nLKWdrBroAhEtbXWzurTc=;
 b=sFn8F9kOO1qEduEP/2hZiY8YTgJHkywADDxNGwFm7A22TDfCq90CaN5NiBtZiY3fIx
 XiQrOh6+x7/1P1Ws2EOtV7FXsRazHydjo6ApT4qN6TSPG/SGhf3f8zuvgRUZnOEJQ6Y1
 RFPf/fkBX5Gqz0GIP4c8dg8eXjpmZFxgGzL2jd25pBkiB25vlhF0D8eN+qdI6afF1tdE
 HpavMdthEHKmRvvtLf+Ap5+cL00OKZ5k4XjAOpU2RcZsGxuIm7tN+rZhvnNk9SrKdzb9
 xmao8tijM38cLj1Xnmx/eBbdT58nbqpj4hGAjvf1xKfVUe43xoZ+p7ERBUhZ+Zqhzfsk
 VceQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzg9qIWmp+FYtqQyp4LHJZ0llvfiOYuAiQj6299rfn1wcJaiSgT5M62TGHMEypmdZ6HymVM54sy@lists.freedesktop.org
X-Gm-Message-State: AFuF++kPLUdsLAbIZue2HvZ9mNnxlmQQ4uX/xou1wBnu2JRPNyVDr7HL
 EY2o4vZlvD1zwNuZY1hrEOit+dCvVsjzR9H91ZP+h0st7GCphF2B6dnA
X-Gm-Gg: AYBFou18CYnQv10x3HOeiRQ97AjP8akAMhedZtoIKMVbKW62kqFjNuIkzXxYqTfj4Cb
 ijJnmtzVsUs/Er0uFD7M2v0tPVPouuzVMeD7foR56JAwjdG2NkCloFwIkfJzwKN5KsCWmO6F2sP
 KLwGFZvkFspBBiUl5ITry3oz/HbEYhUucFuSByAVFagpAgb2c8ypsDqL5fRc+lrE/xyJAY1Avkh
 bm1UpgjKQxGUj/Tuv8CMp7rru1ikPxJP2NzP7pVlIRPG4bUi0IXDtos3pcNVcI842jp2GH3g6a+
 x57JiYJdC83H7HBmh1Dge82Xao6eMQyK7IjWc49URPkMYqkw683OK4MztM5dZEcQGmgzNKQ5qZ3
 1V3smE0L+p2xrWjBQ48nGYXyW7NPVuWVwwdjudxsIG1w1b0D56ABTikVB/kdUg/xe923zvJwnCo
 mSjr+GsTPbz5H5Bh+H0Y0wEDdHD3lBvBYFcL8EBET3D//FWdg525A6pHUWY3lUuFuG20pLiIFBq
 lVr
X-Received: by 2002:a05:6512:3503:b0:5b5:e8d5:7fff with SMTP id
 2adb3069b0e04-5b616f0ba95mr2232510e87.8.1788647125226; 
 Sat, 05 Sep 2026 15:25:25 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166f6c00sm1299495e87.35.2026.09.05.15.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 15:25:24 -0700 (PDT)
Date: Sun, 6 Sep 2026 00:25:24 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 Felix.Kuehling@amd.com, Mukul Joshi <mukul.joshi@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
Message-ID: <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:01:06 +0000
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

On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
> On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
> > On 8/31/26 20:33, Alex Deucher wrote:
> > > From: Mukul Joshi <mukul.joshi@amd.com>
> > > ...
> > ...
> > 
> > > > error[E0063]: missing field `handle_free` in initializer of `drm_gem_object_funcs`
> > > >    --> rust/kernel/drm/gem/mod.rs:265:58
> > > >     |
> > > > 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
> > > >     |                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
> > > > 
> > > > error: aborting due to 1 previous error
> > > > 
> > > > For more information about this error, try `rustc --explain E0063`.
> > > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
> > > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1442: prepare] Error 2
> > > > make: *** [Makefile:256: __sub-make] Error 2
> > """
> > Full log:
> > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
> > 
> > Reverting this change and 2/3 from this set fixed the problem for me.

That leaves only the documentation without the feature so might as well
drop 3/3 too in that case?

Otherwise, the following also fixes it for me:

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index e1ebad77ebe2..847e0ee38863 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
         vm_ops: core::ptr::null_mut(),
         evict: None,
         rss: None,
+        handle_free: None,
     };
 
     /// Returns the `Device` that owns this GEM object.

> 
> Verified.
> 
> Thanks
>  Manuel
> > 
> > Ciao, Thorsten
> > > ...

Regards,
Klara Modin
