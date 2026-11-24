Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA01606A6B1
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTu8Rody
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5BE10F6E7;
	Tue, 24 Nov 2026 15:54:47 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D3F10ED2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 13:12:35 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1b5786e099cso2310691c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 05:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795525955; x=1796130755; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LS00jFvr9PC3GhAzX4jYHWKxPE6OoS0tT2nH27Ds460=;
 b=nTu8RodyPd+evAHgovM9Dv2GPlNgiN0L20rZxNWkIksvGC7v7k8v0fIQSGTNh1o+Uw
 UppSlS4/Ygdnk6wDnxlDFqzLnmqVd1eQq43A2sM5UTE4VZWsDdJYyRG/C26+FJlWGiUa
 pR1mzUWzvwxnGbW43CaI+qIR07tkNgs/mBj7wm7M1L3sxp8iG7FD2fE5crcNQBrki0pl
 c8miUoBxcDBZuI8/eVTD76azgLLAxnYRFY1AXGIGLjRq/T8foyaSyD53lI4arBfu+cik
 emPvz0uWkNIvKlUK6u1OTyCpyBra4gmJi8TdALbsDkazISSiFQq4UYnm0cygUVW9D/T/
 P45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525955; x=1796130755;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LS00jFvr9PC3GhAzX4jYHWKxPE6OoS0tT2nH27Ds460=;
 b=aLO6Gmpu3tZiKq+yulXINak486x/x8v6orM++7ee9/ju06BaL8dAd9JauCQAHu4ELJ
 qqB3PLJgdK+mujHnvIX8Ucf3I1Xs6GjICkz3huxp9r2t3fTjs8t3fQhDcXH7GwM9Yugs
 ZwAD6eY2QWE8F76ZbGU18MrJhnCfrb3DVlBvpqu/mM5LYXupzBkrn0t1y5dBnhW/Pxew
 fCv//8IDgZzx/JuLkLK7hNBFuDO0iXEaB/NCSVQdD97V5r4VwQiY+Z8QLIw/nfN45TZ1
 8AsoyyqprHD5iLyF1bo8IXdz/JEXCCbZq2n/x1n55OFMRChPc9BL7x5Q5x3kF6V3l+z7
 6xGg==
X-Forwarded-Encrypted: i=1;
 AL+hErFp6crOxsYlThXrs2ALrm6PiGzANFJ0fKLPuuqqtQMHV6L8gnBg196/AiUM8YMknQ6RXXxo1ukp@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+SbOYEnBun4lf3IdRdWWARDeRHT3mnK4xKep04cF2mJ7dgxwXu
 /wGGilEpB3Ir9vXXagN+JfAceefYHaKA46uzOINrtjWxScHSaHKhEQcn
X-Gm-Gg: AZFdTZeUlrCWt5ERVpwGfjOPOXSN/k0kgeDJ+VbjwTmhNRliQ9yTnzjbTU0mR4z36Xd
 5eBPa/EOYMGIq4J8M7yP69mPC2BrOga6I+5Wh5ak7W+j2+cznHaJ+D35ShcVqU+dLDDNXHmR9FN
 p5dOgEUkAPFLORnnaOUWW+ChVN2pocOjkzABzYkEVaMzRgki+tL/0NmCj0jc2wf5TiyUd7H4YYo
 KkhbTn5mf5oHDDphCH/ANtRur4qOU+qClja5V3B2BvczHxJHRkBpjPRsx7aNBMy5AVloO0vsneK
 q3VPNmMZc6tw2uPb56DH0830oy0TZAQjHemOUnFkU4NviRq7Maw1LxTj5DCWlfjiDfZ4hAgphXS
 z6cHWDm8IM4Vqd/g8CHt4OeKfoOAMMfhYr85sFTxnz9goKBFPecWfoOnD5RbyRn5brxLiDo0GCL
 MGDt8eK6ey2H/Q0DoOsYo/zWFqvqPLeaCooq0zmSDhdZhCnHvxPowwZV1WqemVYtgaXda6r4cCL
 2LG4Uarn3Qk/jzVJUjJE6igPT0pl2XrjG8OfKGt5OyXiqt9qlRdZ5BrLwHh/65xgp/ocvjaIB4Y
 I5QqL9ZJrtlgXSztD4Cd8pDV+5fW8xNQOK9sajGfO29FIPoF6UNMqv/DUyg=
X-Received: by 2002:a05:701b:42d4:20b0:1b5:43d8:b82a with SMTP id
 a92af1059eb24-1b55689e7b7mr14691957c88.9.1795525954542; 
 Tue, 24 Nov 2026 05:12:34 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:1412:77ad:61f2:79f2])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55682d301sm35659682c88.10.2026.11.24.05.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:12:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drm/amd/display: fix USR retraining support check
From: mdshahid03@gmail.com
To: mdshahid03@gmail.com
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <179433297650.153576.17456786292064820559.b4-reply@b4>
References: <20261101104727.141852-1-mdshahid03@gmail.com>
 <179433297650.153576.17456786292064820559.b4-reply@b4>
Date: Tue, 24 Nov 2026 18:42:13 +0530
Message-Id: <179552593350.187453.11405172136554803760.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Could you please check this patch and give feedback.When time permits.

Thanks
Shahid.

On 2026-11-10 23:19 +0530, mdshahid03@gmail.com wrote:
> Hi ,
> 
> could you please review this patch and give your feedback ,when time
> permits.
> 
> Thanks
> Shahid.
> 
> On 2026-11-01 16:17 +0530, mdshahid03@gmail.com wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> > 
> > The USR retraining support check tests the address of
> > USRRetrainingSupport[j] instead of its Boolean value.
> > 
> > Since the address of the array element is non-NULL,the
> > condition can always true, even when USR retraining is
> > required but not supported.
> > 
> > This issue is reported by script test_addr.cocci.
> > 
> > Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> > index a8519f547dce..74cb65687a50 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> > @@ -412,7 +412,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
> >  	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
> >  	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
> >  	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
> > -	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
> > +	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
> >  	dml_print("DML: MODE SUPPORT: ===============================================\n");
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> > 
> > 
> 
> 
> 
> 


