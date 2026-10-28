Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B0606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbQTH0Ny
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BF210FC3C;
	Wed, 28 Oct 2026 13:00:02 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293C810E526
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 01:19:29 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-35c76e9614aso699971eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793150368; x=1793755168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
 b=CbQTH0NyHyoIWwBxr+u6TO5OMH1JFL5yOaj1MJYkmGQM7OePsU6msFXRs1dlKIPl1j
 eujg7ARgfxFx3b39gXqHx57b0f1EeLfTOkvYEVeUOesmxRHQu/nRCRR75ECKKkCwOJ4V
 BTGadqrdNtMCt3Xt02VhK0DD0xRIWu1OJ1W/qwSo0szOkn0E2CoptomJe9YKDwQ4WwPE
 rkDWXu4toHf7+FQ12T3UEncARX7MAmIwv6s4YwRyGrRdF+EgU7PiqlzSaLCqDOqy66xv
 wXVhtyARPpQleIWUL00xU61+nTxlInwUhfkk6clw/xyPeyIk/xDWz6QVDMWzJCzIScGi
 hYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793150368; x=1793755168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
 b=EyRBM8hoTR9eLewfUnMMl2UL3zBUW6q69kSqymo+ICMqGZBH3vWvhvbJ614ELw/6YW
 82x8qSg7mj4yOUTJ3JyrpFDalz/eHqb/yK9KnyaqN4zofsZSwOgpjtvr3MT8VpSS9ORe
 /c72gbIfKP7vjHe3deFxPqbJXbLaNswOHMFVMf3z2TBcrXvF8kCR3h0DaOsbZmLwdcIS
 hY+yWPtHgVe0utdI9wcmuHTRI6iJ9uihDFmTqgAMzQQJsuOxO9ALYe1dsGqYa48tlTkW
 pcWU6GDUGmwNi3SybNo3okMcYtCSRLxJdYRoW6U2eiSQti+V9pkHCNzyR+x43LVuY+2+
 xwYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMynN3pwMeIqi1lzzA/I3574VW96CsOfO5l7vdUKIotmRDb3yEWhwbbmtFkDHQNOui+6Xjk1BH@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIW9KeNw04S3BwlfEY0xaH5TuGLiW6oiqTTCnHkINgYeN0SuGZE
 97aqJ+WH0gWa4N8M+5IpaV8gZSSAgkknkUaclOCyc1pcfl4msopVbcU=
X-Gm-Gg: AYBFou2tiEueF2nr4V8JM7//+dnt/iMIQCfl6UdWrAtrFSYVWAy/2N0faJ6x9LXws/T
 RVrg2LTreyFlwa1iVAXHXjsXk4Lw29WRmxZzWIQHs56uPYIadaGZVSeVc7gu3qbvmD7ARf2bwI8
 0CY+feA5a+bMjtHJ9jlqM+asAm7e5H6iz/N9ic2ybsrTQe1V66XOV3hrzSVloL7MoBnKiu7RpDm
 AgkIpSAkLuwmTcxXrMyvpGopsIltSNRgPmG/DcH4hohca1sKAgwdt6TPJxhSpV0/TRqVfjQh04f
 eiudpysBOdvnJ/q9NCAkp1Rgijcpy8zMxl3YXsZ4ATsFYUvv50Fh0fxjMth5dBvhNvhLeVrnbyd
 Uw0nA4nekC/p8q1q12HDXyr8c41LIQ8THOOPxg8RmYUBCnfOxZYSjCNcofPkSc7NX1X6UIQxfg1
 vK16bNt/JWk4fIrtUgj98LuEhPSrhB77g+D/++/M8pqtNOO/gUVuQ3n2V7FZf4sCf5hjyX+YdKH
 SjzG9CL29b2sf4LmoEBHptsMY+CumdI4NlgXK1NXZn3LUGatnNp0nGEFhoGam+GiOTWW8KGHVmN
 9fCj1j5EKxG8cXDr5sHbCag1bRKSJFCpiFU91b48qYyobHlzl7jOy5Lkk+SYaaoDBtdj6pK9f2I
 RNDQzcUsj9KOa
X-Received: by 2002:a05:7300:fd0f:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-36a20440ad5mr1939920eec.32.1793150368183; 
 Tue, 27 Oct 2026 18:19:28 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.199])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2392ecfdsm821863eec.17.2026.10.27.18.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 18:19:27 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: atharvatiwarilinuxdev@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, bhelgaas@google.com, bp@alien8.de,
 christian.koenig@amd.com, dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 helgaas@kernel.org, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific
 amd devices
Date: Tue, 27 Oct 2026 21:19:14 -0400
Message-ID: <20261028011915.8217-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
References: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
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

> I did not know about, i will try to remove the ignore_access code, and
> will tell you the results, i added it as a failsafe

I tested, and yes it works without ignore_access code, but we still need no_pcie_port.

