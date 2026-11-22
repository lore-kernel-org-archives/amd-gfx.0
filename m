Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06631606A320
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b/Wy6KJU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9880E10E273;
	Sun, 22 Nov 2026 14:36:14 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC60010E273
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 14:36:08 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1494979f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1795358167; x=1795962967;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
 b=b/Wy6KJUM2gaBntoApG9Lkfdw4vomCaxodktDo3g3+d/sAzQ1r1ahi2e+yQ0qPct73
 OwbKfwAC3qC84lxnX3JsXwehDTPn7rsiG0cSACNVMnUTCvX/2cKKJ42wYQyP19fMBG0c
 rkFx2QQVIxjBVACE9w7E1F3Hu+G/v9Hjr0uXRaJxQ3N9MDNMPfrRuQETKRVjsFuENUro
 6mNE4mn4GO3NPEVohE31faFAFXJ7kK783rQxyEBD5ZFbUgYc3PPK6Z4Udrbvmlf9rK6H
 C9iQE097eLFD26fdiqVLxoa7CleB9x2Ixcif36R5nkRM3UQFAy3hu/7msf+V/e+xZuTq
 BuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795358167; x=1795962967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
 b=y0gWDylqfTg1IAFoCtQAytEMnT7IfUsrM+zs9Ja/ighk2y8Fr3zfftiomDIUkTsYyY
 lyVyXA7Fn3PFUrQu0osppGC9PsvrYdxLuJcpFLfp/ht7NrG6XXr+wlgsHn7aklas4OXi
 4YfrfSh9UldoSP4Hyn0myHBXCDDTvavyZHeQtZCcO822OOLxko0rJaA6w9TcnCIcAxea
 RAirEDfib43ePcPoYy0Fp4gVEiL/WL5rrsIzSE+/OLa6ZIp24+v9weTJBss9YO0+Vvfd
 /oqn51atwM9IIttFmXIyz3we/U5H8B+OurLcb/DAtwgTx4untPohxcE2KKqTYtK5Kckm
 ASDg==
X-Gm-Message-State: APuU4Z8BRu64Mu7/4B5BxYbVx8845Tbj8eZumQF+eVSO07llB4+hpAjb
 EnlfoxrHerHPDNoQq9+hVAwoLTnA5fQwQI717+G6CACoTh6kHC6e84djmDYB3dpomA==
X-Gm-Gg: AZFdTZe9ShQ0fM8FoQqalZo9jxmkcyhB2+7kQEtUMeEhrOdqZff9dmWC2297g/Zayqo
 LykhVbSYr29FQD/iBeG+fW1AR3zsyxxcvne0Inf6voiahT2L9UZOvVa5eozOHPRjl01PEeV8DYZ
 S6UBFfWjKOM73iVU8vpgzsQFYHl2YTBKU5tJsFPTcO3jKQ0e7DRAzJYj9+ilLNqa+PYvPI+cSZD
 vy2VlXVlnCDsf0F/n6FbCN5sOtZa9kzv0APi618bCo473NFf4lx4U84BSUXDIsx7LHDgEmp8vnV
 sUnHYIGl6u+2ytCs8N2ioZmFbA3zRvTREtLJJYHEbQ2Swn4grctqjgjDzEDfv4qejGsdPsNvOEC
 5h9wIOOWCzTO0TYF3HBoxWIimAXu3wqBXnmpfbOjSJKoPEqtrAaJE/bRpEzjdZInfOxLyohesVa
 CiWWqbgLomrJ3dttgzalYcaYmAkiPWHCTLidmoNweyqsCG4qnQYkYsDe38kkEtT7n0a+eRQ2i3c
 DCCn67w6Cn110HoSPgMubeJGPboeZT8BKXGZdTlV+AAo3AFkreESxPF9UoUtTp4r7q8mEt2EMPS
 E4h2VqM2iWkGKd1QMzDgq4cfkVPM+9Exkf1eSZ3kbbme8sD529qkk9esfMT18ayiskJ8lukqVZw
 c
X-Received: by 2002:a05:6000:4616:b0:4a8:cf12:6f34 with SMTP id
 ffacd0b85a97d-4abaab6318fmr18378688f8f.4.1795358166624; 
 Sun, 22 Nov 2026 06:36:06 -0800 (PST)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm18945409f8f.24.2026.11.22.06.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 06:36:04 -0800 (PST)
From: Mike Lothian <mike@fireburn.co.uk>
To: superm1@kernel.org
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Date: Sun, 22 Nov 2026 14:35:57 +0000
Message-ID: <20261122143557.2412982-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
References: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Mario,

Thanks for the CPM _L05 quirk. I've tested it on the G513QY (BIOS G513QY.335) with the dGPU runtime-resume patch on top. The boot log shows `CPM: \_GPE._L05 notifies missing \_SB.PCI0.GPP0.VGA, using \_SB.PCI0.GPP0.SWUS.SWDS.VGA instead`, and the external displays come up after a dock attach with the dGPU in D3cold

Feel free to add my Tested-by

Mike
