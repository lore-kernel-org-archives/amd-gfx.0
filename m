Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC41606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WYhHJZM3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0B710F33E;
	Tue, 27 Oct 2026 09:34:11 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC7210E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:29:34 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-35829219da8so946041eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793089774; x=1793694574; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
 b=WYhHJZM387dqAG1gQ31yTFQwdzQv+cXGXsCQ2WX0uhjW9dG2cip9RxYgf0j5rIfBK/
 ilPnC08Ui+VTWFZSawV8xxNe77c4jDHCwPFZXNQl+ahee7s/HrsfIlX2vS97vNZJ3kiB
 dBo5LHBRjwsISYZO1iuI/MCTyCvP5j/0fRhp4I+vEHdxhKXONDZMxzWXiM0vg9mufPf0
 mlkuD2Wo9vrBTeMnebxuauDCR6xYmgrPlsVYe8edgvb9aFfVIV0T7NbHLLJbMhmfcRMX
 YPaOrbb0v8Xn+pxG+9Qi7Fc3hRXrkpkHxpJRoziHcujpmH3oH7PieetxXRoHglp3v+uS
 sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793089774; x=1793694574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MGzHH13ZWFaAze8jomr5kn6NEKQkF5IKK+VbX0oc3KM=;
 b=EKxszn4T2ou4bweoRm/5AS86/BbNdusEsTpgSPmjPrhgomEWv2dddqpaTmwxD+NH/G
 nht1B66jl2ZOUXgKLk0mxIThaBWKcrnZuItJOQMrnILmYwQet2EGhcyURrul3i7uuJmg
 eBuTMLYHDsQb7YlASvqkfKVVIgWTqc/7Qh+pobGobbZQczVEQBPbVNCOm7ahQP8/cGUz
 3YVku0iEMah2HXMHRcd0jk43oUVra3rlHe9qmOBXLsB9m8Bqvm1SbhpbiKp9A7zQn1l2
 xXzJ3Dz/+SnL36c8q7/sAXmVTqCGTL/iuXk/AXEsFbvQBnQCiaXtl90l+Q8bHgLX02M/
 2viw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJeNmV/5gGtYG0l/451jcFn44kuUHMh+QlBUkm/6K3eDfCHxydG8uBpjqt04X+l+KmKPsQGJ1v@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJeQ3Xv2Oanhj8cjW3hdTJAXV1G0StPlbjnZgCcQLetJmvSkr7d
 +iB8OLiP994cYT667C/t2+hvoNxKU3hZUg41gS8yAI5vDELfGLmnhDY=
X-Gm-Gg: AYBFou2UCu97NrPe3iz/pipmyFXIuUznmG0x33VqLMlmwEG/qDdMNSDznH/b39R0gf7
 wXlwi6gIIAmg8rTd7JXoM9/oxWsrYbflfnjT/I/z1tVukA2S/xAxQTcj5yKsqnAxBHIo+s6/KyB
 pfnd+tkh4DMsJbtWCF8JI6m0aR7ijVofu+vGOX7nsaGVkHZqU+bLRLKqic9zpJhQj/uSO8ZDo6j
 nbdJmE/3qdCXVcEwsRCQh0iTHiZYrlGkV2fPiF7zS8LFwyPRdE6O95CRlZCx/1WM1EY+dGwdeC+
 B5zclo9TiUtjpRWuIE0tzGFDELdzYsmvyq4Dxk+92mXUqTSYs4XCO7/EsmIFSBYGnKnkOVjjqe/
 05qxGODrgLWHc2/7PltI7TK9hB8hnH/wIBYFsgd0+QWxYhnp6BW29NkxWcPP26wWeIQ1Wd7MZ0S
 YMAzUAE4Q7te6o3KAOXUbQXwi1zN83qXTXeAm1yUgH1vMGyQOrcJIGhh1SAVTICXhI92YcNFc68
 i64oMJoAxaIiWhMN6QC194l0ZzWIUh9ftSV2O5XpB2CZ9Mphzi+K1OQOMrB0YDxiu/z6D8FKrij
 WOmUOlHdHoTN
X-Received: by 2002:a05:7022:eb51:10b0:144:eb3f:563a with SMTP id
 a92af1059eb24-1a3c84c3867mr2805885c88.15.1793089773456; 
 Tue, 27 Oct 2026 01:29:33 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.26.239])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm43895151eec.19.2026.10.27.01.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 01:29:32 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 bhelgaas@google.com, bp@alien8.de, christian.koenig@amd.com,
 dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
Date: Tue, 27 Oct 2026 04:29:13 -0400
Message-ID: <20261027082913.8002-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
References: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:34:11 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> You can drop this.  Nothing about this is GMUX specific.

I agree, but there needs to be another variable. Using pm_runtime_suspended
or using any other pm function will not work, as amdgpu_pmops_runtime_resume
also requires hardware access and even though hardware is accessable by then
pm core will show that its runtime suspended.

