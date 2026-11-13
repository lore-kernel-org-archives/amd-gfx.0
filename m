Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DA606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wp00MVmT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B69112590;
	Fri, 13 Nov 2026 13:44:30 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9ED510E7F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:35:12 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so1856343eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794576912; x=1795181712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SfupC0oc/N96J/Mda9FTAL+K7CQc5gimuxHzutKbmZ8=;
 b=Wp00MVmTWGKXgL+ALud9kyTfOQxrLQrUbnxs13s96kEb3qni0/O5Uy2PKrXdE4bLDq
 FK96gQl91ViW4jl6UkfYf+4v0QPvKxE4ryDQqd096Pf+BimxPAh5lDyLfOTGEvJzUlFM
 Hvx4CaGQi4UVBa10ZD1KNUz+mlaUIcxbWblkMrrAux/cF+44vMWCY2g/wk6i6dxhLBKh
 UKx+qpOtkjzDwakeWYWc8YWYWQcfTCjTspPOFkaXq6FeCwGWUfwUs+JUOUpEvdDXViDI
 LMbSwEzgzPISIa4zv5ZoWshj47GPs5OM5w04hnVy79XuD2QU7t2uGF/A5bsSPsbHxO5h
 p2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794576912; x=1795181712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SfupC0oc/N96J/Mda9FTAL+K7CQc5gimuxHzutKbmZ8=;
 b=Dpn+uzxTFjiEHUCo0RFAOzooLpetq5JEExJaWCrBy8fNH39N4VkSYF0UeijxJMJ+k9
 VjH1AvpdePxI/eOT2pGxaLSLJiCZ5vcjCCrZr+lqXkHdGqSAkLtSgOCN2184IWpYZojD
 8lB2DMrnhQNWf7U8QAg+seyxHgkfvliSHo4ol4E+GDJ+7hiyKc1qCehKfXpniohpMdsw
 HBDMtOBw/OX6BnQz9MwPzAjCvoJnADW2UGHa9DUDYcPdsdITwTOrVadx84EFPo56lUuz
 8dnE2YWUN4OOm1KjG6mtBI1jJIaaY+kL7jCINuf3R9vTtHEws1ys3Qyur5YLSGQtXtkv
 FvOw==
X-Forwarded-Encrypted: i=1;
 AL+hErESxG62ktu1YLwtJ6W9jAVrmjmrPG15ZFqkpaSeFCdzSiRcday7Wb7tjTAcCOrNDr+5Lv0sztff@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wtIAIXWCPcmNXbW2gl52+q5sNlDAnVSuvrm5/USti9IUrErvt
 6qynirCjuetNtr3bWyxddd+9lMHxx/nDL3pb5AfNNadclqhW7X/rfD8=
X-Gm-Gg: AYBFou3wtT+zsbHS/BGYlIU7vpAWLenh2fUNmoARJz7QbFENqkSysd0Q8C3rJf283L+
 SsdGmLWjJ3oMbmFAXglSx3pTBren2YwpSfoMsCunW/IhbGNLgwHR2qaQelGj4pOkLhCLNCiUHf/
 KCV3uoqNfKGv9kp7vcft5lV0T1WRGGzBpSlGtbSJnFkMT8qDXHSlvPrfU42wjUeIrgxs6A7QWb9
 gAgdfqKR9zGvulxMUrOQdlkIMWRrQYXaKMiJSjeyNEyezZvfn0udoyQqsChIfEUict3o2kNylrd
 rXyonoq0Dc96J5PpH7BcwjjN1Ug1FRySsOma6Bj67G58yTOSZiQmPArJNNjsCzf9381DWDJkbxL
 OeJ8DWgd9fIARVhBcQ0T9dk1fFVXybqge/PMivGm7MnXqLEIOO7BZ9WctzLDrnqwayHDodWJbST
 MEWGn+FCR4Ed0LWDLV9PS46izwAYdAYMOFIv4Q5a+huSIxx4KaQSdMyJkvc3r8qcdlF6my8gb6F
 6MqlDzbHOaFzf+UKfRyYzeRFHgUO1Q82m8X0CKfWRBsFWO2q4ofU4tZgNhl9m+TIzrzYbvOCvO/
 jobBkZ7HT8qaSZWfQj00d0GfJt5z2n8NoWbB1YIw5VROQG/dqINbmo3mGcltc8xas0YSEIDB6di
 ZIQnuG4GJO6A=
X-Received: by 2002:a05:693c:808f:b0:375:ed63:5f12 with SMTP id
 5a478bee46e88-37966a5595bmr2552834eec.22.1794576911887; 
 Fri, 13 Nov 2026 05:35:11 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.205.242.248])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379508762a5sm8074632eec.0.2026.11.13.05.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:35:11 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, linux-kernel@vger.kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
Date: Fri, 13 Nov 2026 08:35:03 -0500
Message-ID: <20261113133503.28291-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_Po302dyx5FA9u3A8os_Q-HsA74nk2qeDadcGe97zodbQ@mail.gmail.com>
References: <CADnq5_Po302dyx5FA9u3A8os_Q-HsA74nk2qeDadcGe97zodbQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:44:24 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> That sounds like a separate logical change from the rest of the patch.
> If changing the order of the init sequence fixes the SMU UCLK issue,
> that should be a separate patch from the changes to enable the 5K
> display.  That said, I'm not really keen on this change.  Can you dig
> further and figure out what the actual issue is?  There are now 3
> separate slightly different fixes for this for people with various
> Macs:
> 1. Enabling UCLK DPM in late init
> 2. Using the UCLK states from the UMC DPM table
> 3. Changing the init order for specific Mac models

I can understand your confusion, so i have tested some scenario's to
make you understand the situation. And for the moment you can assume
that OCLP is a efi loader that sets 0x4f1 to 1.

1. Stock Amdgpu, Without OCLP (0x4f1 = 0): Crashes 6/10 times, 3840x2160, UCLK works
2. Stock Amdgpu, With OCLP (0x4f1 = 1): Crashes 0/10 times, 2560x2880 (1 tile streched), UCLK works
3. Late UCLK patch, Without OCLP (0x4f1 = 0): Crashes 0/10 times, 3840x2160, UCLK works
4. Late UCLK patch, With OCLP (0x4f1 = 1): Crashes 0/10 times, 2560x2880, UCLK does not work (Command are sent BUT no change in hardware).
5. This patch, Without OCLP, Without revised boot order
	 (0x4f1 = 0, at boot, after amdgpu init 0x4f1 = 1): Crashes 5/10 times, 5120x2880, UCLK works
6. This patch, With OCLP, Without revised boot order (0x4f1 = 1): Crashes 0/10 times, 5120x2880, UCLK works
7. This patch, without OCLP, With revised boot order
	(0x4f1 = 0, at boot, after amdgpu init 0x4f1 = 1): Crashes 0/10 times, 5120x2880, UCLK works
8. This patch, with OCLP, With revised boot order
	(0x4f1 = 1): Crashes 0/10 times, 5120x2880, UCLK works

So from these scenario's you can probably conclude that 0x4F1 = 1 is needed for SMU to boot properly
and thats the reason for the init order change, to set 0x4F1 before SMU init, if we can for example set
0x4F1 in EFI (x86-libstub) (like OCLP), we dont need the init order change, but to do that we need to RE the DXE
modules in apple EFI and check how apple's firmware sets 0x4f1 = 1.
And even OCLP does not enable 0x4F1 on its own, its fakes being macOS, and then the
DXE modules turn 0x4F1 on, for the "faking" macOS, we need EFI changes across iMacs which is not fesiable.

And the UMC DPM tables patch does not interfere with anything, its not needed for iMacs.
