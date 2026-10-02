Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC47FCA5FFF
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23C510EBCA;
	Mon,  5 Oct 2026 07:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OsNQ0Bc9";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0B810FA39
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 20:48:32 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b08452cc5so303267f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790974111; x=1791578911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xn8v821wbWVD9E8elR4jk6DR05TUKT+raE3vBfYoiWk=;
 b=OsNQ0Bc9KSV4FOlD11iEb7A8HDozFP2X0NSDxhL2889SE4fj0Ws5OTdKguhGsG/NoC
 +AFG19yw8ar5OgGb1TfR4u2Wgfx/n1aYi6IbxzDjUpLu9RxRl4o7bKSI2nPTfuOfSraj
 O54Eml7TH8X+L99FmFLFSKMMNrIM+yu2aIaYAOyiM08O7BCsjDiD2bE79ZlkGYixmiKN
 f2mCRMVofllnSsasFUha6wcDzoa33A7wr8Fv1YKlzsiLkTpCCEiVieIAM9275zVILA4W
 N68ZMCRf5mt2nBXLnc4vuBHDr9uvCzJdZkL0lRtAv2N3yaWOCz8/JHg+yEL9RQ0i3S7H
 wMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790974111; x=1791578911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xn8v821wbWVD9E8elR4jk6DR05TUKT+raE3vBfYoiWk=;
 b=VlGnKJl+uhkrz3pacmaL2uSB9Ex5A9pOWfSvdLtPP5hNAww/fyTXcujEpB8Z6J0Aww
 mjbgVELKdWyIHpzx+br9SahaGxKe4O6wNi71QAc9Im/wEoZpxH71wFMotfhwyLzhkawe
 ZlvylalJYE3FPMx3fCDZ2hB/p5yU2pQacTRXHhj4/RCM3DBciAFU3d/G+Y+XIGVEd1Q9
 AGrrOIyKrxFRcgeHVA2VZxupFP+YcJcQP5i8RHMAd3RxKQy2+P/bTRJunjBqNDBPApAg
 2z0bcI7qm2fUJhSvWoDLX8FCb+pqysP0ioPAjzZxxiPrvLmDWQTiw6MdN/i3dB6oc9Uw
 XcvA==
X-Gm-Message-State: AFuF++lrxnjpKIsf42fz0A3Grr5Ga7KWF7FuHhXRwGcfFCri5XuAcoK5
 TzEL4kosbBkgY0jb2+ChqtGc4G0JqfT9TRqDJzURJ4PGKOOKjalRJ9td
X-Gm-Gg: AYBFou2ualhTHtrcOkJ7ObHSS18wzn/HIq7cl7nAvlviBvVQr3JAct3FIvygrrHOPOX
 xFwETKT4k1TF73Bo6qgIIpYmtrMvKpLdFpm6ZVv+PNFtF4MP0hmCQ3dKnWAgloxHttal1L8K59P
 1PeMmOZ8ha3uMOpdA18L58+iRTv/htUjXZ7x9tEJrYtzCuYbWHHzdwyFSl+ckCDnvWM26gLggIm
 JDtkQWnBneOtjTost6Ms2WvshKzbmsh/7xYe/iVdB8326feu9IXaK3CyYhGLK3J9t2oVELaBQRf
 mLmOhm6AKiupPx2sQzXZJjcdEYA/UrcNNJhjnQxy+Wt+lzIOMVLO7unEGIJZbTSIvP8jguQPDmq
 xbMaVceeZaaq/YyZZNWmjSsWDP9qxiyku0TOGqna3VuftTCIALWVi/6k+ZNC+yEghXRiKEJK24/
 YYPNAzJt4O2rXjYM+sC4klUB2YwmQrISkUKf2Kw40DxdpBvZt4l77LnAzo9nj/Ln9CBOEJK0y2h
 kt9hkXy8h6K2mmqkcueYWMG3Vfsst3mbw==
X-Received: by 2002:a05:600c:609a:b0:4a0:1c98:de52 with SMTP id
 5b1f17b1804b1-4a02755c4d1mr65627725e9.1.1790974110562; 
 Fri, 02 Oct 2026 13:48:30 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.71.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm39343925e9.2.2026.10.02.13.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:48:29 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com, airlied@gmail.com,
 simona@ffwll.ch, skhan@linuxfoundation.org,
 Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix kernel-doc warnings for cgs register
 typedefs
Date: Fri,  2 Oct 2026 21:46:40 +0100
Message-ID: <20261002204803.27695-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
References: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

Hi Christian,

On 10/2/26 13:38, Christian König wrote:
> We should potentially just completely nuke those typedefs since they
> are actually an unnecessarily layer of indirection.

Yes, the cleanup is necessary, but the four comments don't just name the typedefs, they're the only prose describing the operations (MMIO vs indirect access, offset/space/index semantics, return values). Should i relocated onto the struct cgs_ops members or the cgs_read_register macros?

Thanks,
Omokefe
