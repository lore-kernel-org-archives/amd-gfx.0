Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B2606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=r1Pejf5R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338F5112675;
	Fri, 30 Oct 2026 07:57:59 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA8C11268C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:57:52 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so162862f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793347071; x=1793951871;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
 b=r1Pejf5RTR67g98yPpQUrkH5Lh4XP01C77S4skRSTrHEgg5d1iPvWF+NKR+3G4UiBO
 9Pe0vFFiUH3qvqPFmq8bPrRpJ6f0g9MmdP2osGLJQ+lrKT9u4kuQx6VVKvAPWGKq30H0
 YOvRTIsS6/M6WLPy5tXMZNLaXhxSZ5eifCaTBUwi8YLpu1uGRDmwRFe68kplxZHptt4s
 2lZ4E4gnDbHUk+GGgJSYUhqRxeccY4Lvk/hlvJD2HRtMittCor6wyrQKouM7vA1yGSaB
 ogZEV3WP2L3k4trCAZTIlRuKlWE8fYW7FJ3hjFaRE2cDdNAB6cBgBgjN46lMUH0o+Hbz
 SBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793347071; x=1793951871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
 b=JC4cyEHKhK1VDZPgqk2hc7EQDEAZQ8ZaCeji6B1UmauETQWPSP4npQqzTVrpoRbyTL
 JdknylTqRoQRULZVlSass6I5qR2K+2euapWPXnGA/hFkAPOL/UScO4ziHXO1J1KBzT6K
 15RqNzxA+eSfnwLdQoRsqds7+kHAcerSVP5w58gBl4I1IhluVodiSpZOJYHIdwLgtoNn
 pfVruWW1mhc5a3hK/47u/v095f3GiME6OXsZRdNxayHGctt0gs+En+a4fmEtMUk5J8iJ
 7N0j+slksPZzOQ0SmuqlJhAue8uxkpntB2LBfy9BrPM0kTitKQR01NHbFUCfCC2LLp0o
 iTqg==
X-Gm-Message-State: AFq9FYId9O6gYvHhsr5vunOMosxNOJLQ9oTabBZh4FRm8aFJIk+5+TrU
 XicBoccHjuGF2AxOXEE4w8a2LzrzSo7xCqp+KroT/PgC9rIHMLbYNZVMZCvtMID4ng==
X-Gm-Gg: AYBFou23R8Jo3XiRb9RjFI/QgjQxbCA3VAiqtwgqXCZzXJy5JJ0QgF8CqmZIJEKWw4K
 5aCojk6zD94+yAYiHH1a1NH0jkFWnPgGZFscfQ2DzViiXFipwJYHB9vnpB4CS5hgugqIOs5krWX
 frdn59JNoAp+6nWkFQMsDR/+E72RoPWiWQ3t4kwBwxFDmdbhTRDg9hfxQxaY85JwHQMhVb4FB5v
 79eaeW9JK55rFGOhXgU8jxC4d5fqrYy4K2qBNrmmqASXaDLimfNBCNESftmRDCSfshpg6ke2fPM
 Iem+ZSAmgs9tYhEJ0DwEm95/BKEb+Yzepms9fcy5YBUNiEWIUUU96hui1kBhLrjaaJgIBSKLsfR
 PAIQR4LThYKLwllpp4JzsGbmKtWvVaKqpmZ5FfSV+L0Wwv9Pi9OVeuLVekjZIgi25eRwfn5qIR+
 NQpNvA35OvQ9roFmqIPkxNl7vkTDHvWq88oDK4Z8BTTf1uufQ9altvzhsJp7RvKGfKEjFV1ISkj
 ZXQe06jbhi8wtw4sP3E9NWYPtyuX/F96DRyGeOgmc2nv8msOzrQHhKezJ99nnPD5UOYO0fscbmZ
 9KB5wJOVZKcggguZl3ymKMXZPCVKkvp8iSw66TvCX2F7WedmBUnOzf9tkd5ujp8XjmwDjRiq+tE
 p
X-Received: by 2002:a5d:588e:0:b0:48e:6bbb:c3f3 with SMTP id
 ffacd0b85a97d-48e6e2fd071mr3556678f8f.28.1793347070787; 
 Fri, 30 Oct 2026 00:57:50 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm1676007f8f.42.2026.10.30.00.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:57:50 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Date: Fri, 30 Oct 2026 07:57:43 +0000
Message-ID: <20261030075743.356835-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Mario Limonciello wrote:
> Can you please get an acpidump and put it on a kernel bugzilla or drm
> bug?  This generally feels like an ACPI interpreter issue to me.

Done: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

It has the errors and the tables from /sys/firmware/acpi/tables, minus my
local override SSDT.  I haven't got acpidump or iasl installed so it's the
raw files in a tarball rather than a real acpidump, I can redo it if you
want the proper format

On the interpreter question: _L05 is only Notify (\_SB.PCI0.GPP0.VGA,
0x81), and \_SB.PCI0.GPP0.VGA doesn't exist on this board, the dGPU is
under GPP0.SWUS.SWDS.VGA_.  I don't know what the interpreter is meant to
do with a Notify to a path that doesn't resolve, which is why I put the
question in the bug.  Rafael, if there's a better place for it I'll move it

Mike
