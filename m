Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C623606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v8GBSGj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDE91126BA;
	Fri, 30 Oct 2026 09:13:44 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C7D11260A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 01:55:38 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-353804b591eso416472eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793325338; x=1793930138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Td2Xd1tYhRh3obhb+/yK2U8VEYj+IqVYRyJ5LgiIIoc=;
 b=v8GBSGj9m1AW1exgNwIAXXghN2uJ3lDjTrCfBT16zrx00p2Gm4eaS7Jl8wwBf3Xber
 xFhpIY/32zsBRYH/2RUC6dGqrh2EX8L6DHe6CQpcKo9nzatr6n8WIDk1XVURnScWYXGf
 ZOIV3XyJXVT4nQvF7j4a7bk3lyv5KmWJwVy3Bi7AaiBx7PAFp2JHOg4i4FxPF8E/X/b6
 2Lz6RNvk9GprssVfMozujcYvhfkfxm289F6PQu/cNBk8d7cEFM+qDy9XRN2Pjbe8SGMy
 nxgwW6C51bOWb4gdTEgi3LHppFRpFcwangXCKDiR1J4CyOkjALJu5v1aaPTAP8MbVk7v
 DRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793325338; x=1793930138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Td2Xd1tYhRh3obhb+/yK2U8VEYj+IqVYRyJ5LgiIIoc=;
 b=qACljBrr0tRp4G9asMLfR/YgMsUmj4DUL2sD44aqwYpwPDGMz5fuleRP5epIXAeVCh
 zh+bHN4JeiWDvZ2sTaMm2J7T84XfmUXrF++0VBB25Nnz7WiPkheYzezcR8Sl7UYorPN7
 IyHz87KZQytBW+L2Jj2X4dS+5INodB46bJxJEIA9GVYWEmjsBqLfpnwGvqZRuz9ELsnP
 gVwO0lxMMnqQsZQ5jWKSWk1i4zOeRvIStxoPuEthkNqasOAYoIrCA7MmrFsg/Zhh5xxE
 XHswBeWuL0PcvtAJ7Eblhh4RNApVJpO3a606HQOJrQP9llCOCaT7uaCfUZ773xqmWq7f
 yAuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsN1LQ7vCnvkwECa8bxC+WLI44nVMl10I8I0wOPmc+1zaCJu/0GlK3+3P/24rxmLuVayj65ret@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKkYLbkpNCZnDQHOUBJ//wF3sBW9kFhUf60Aiy7JCen6+65q/zD
 TyDCFNwu06jstWbZIhz/VlENrrH3dPNcl2A0bSmqD2DjTI3jmIWtwhI=
X-Gm-Gg: AYBFou0fGyJP1OWeqHsMeG3jqTL5HebkjQAQ5CrMiL4RkJ6Wb8XMqRcgHd5Ysz7o0m/
 24UqrQ+rhanu7Y+a50YWuWkD7Tp3ZAMntuD0ZpKurJ58pBauiZeRLYpiTTolR7yqQthv9Zw8sbE
 c1GGYkHWIMEy8QXihnfIAxuTCQ1zBjXHr7J4MjLHjitcKI2q4dJWDjft8KPyb+C1D6xswaAxM0j
 gx0HqsH/oP4JBtge3ME7hdG2iU/haGsJDuqYpwz2FG5ZlpWgFSiH8cW9BmIgZz4q3mrp/MyZ+3X
 Q9t7fA/0n9orMjx6YhL39UL5bA+bRNtQ/HLfifiWfapn9d/SST9TG/cJY32byUKYTW35xLOO18U
 R+Yn/aFgeoaX3vb+DowyKekpMHa+us/PGTR3BeL0bnbtQZ2kLMWdoRoMXcMPjvPd6H72Y+6OXAp
 urPGfIau+/pb9CWbQ0deE+In6IxYQGUOLZzi6OaYf9FRi1LbsfYV4K33hNg4zGip+dEH5j8wbj+
 rtPuEtj8OLQeoR1glWEaeXvrPCM/jDY6wbA7ConJsvRDqRjakDvxX5WxoUI2qcnJ6SK+mVGPJq1
 2ER536FbMqduy9mm90BvLpDdx9B+MHru5jeC5oBP8oF/vKQhXjLTwFw4gi+N+ygRikQ=
X-Received: by 2002:a05:693c:895b:20b0:36a:1bac:6bf4 with SMTP id
 5a478bee46e88-36a42389038mr1533637eec.18.1793325337872; 
 Thu, 29 Oct 2026 18:55:37 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.112.166])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm2730757eec.26.2026.10.29.18.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:55:37 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dev@deq.rocks, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 simona@ffwll.ch
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Thu, 29 Oct 2026 21:55:29 -0400
Message-ID: <20261030015529.1686-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
References: <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:13:37 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> @Andre Eikmeyer I think this patch should fix your system as well.
> @Atharva Tiwari are you ok with this patch?
> 
> Thanks,
> 
> Alex

No, as i said this is not the reason, and we've already fixed it properly
You can see it here:
https://github.com/t2linux/linux-t2-patches/blob/main/7003-amdgpu-add-support-for-5K.patch
(Adds 5K support and fixes the boot issue).

And for the 16,1 issue (i assume), the only fix is
https://lore.kernel.org/all/20261024162109.307247-1-dev@deq.rocks/

The PPTables provided uclk clock speeds is wrong, thats what causes the issue,
initializing UCLK in post_init wont solve that.
