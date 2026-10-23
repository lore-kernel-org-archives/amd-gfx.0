Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81997606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V86CXKaK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C73E10ECA2;
	Mon, 26 Oct 2026 08:43:51 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B3410E625
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 10:55:16 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5bcc6094d7fso542807e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792752914; x=1793357714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b2Fd5oNxkb9TwPHoe6jZ2lXM4JNiBNNjJrD7JxD65p8=;
 b=V86CXKaKfiOLUnMgWOr7XR6+DqcVKBNATh/CW92MPSvKNJEIfXvMiSxkX7jbix6sgM
 ScsMPVtjI/CFOI92jimLECL1jbD41OI6VAXMhcMAkZKeUqcU4w2tkOI5jxWnfXuwDUeZ
 kIfEnDsrca/tIdtkWhSZbmtpF74krLs0AjuWWLBbWno0WEHKyFNwPYEUPRppavbC4M3h
 0f+y6GDMkbl/0/+HJuKs4IrlbDF6e9KRimneeobacCUxrvteWLTgqyaS0eOTlXJ3m6Q8
 hprivG9wW1y45nwqjV5XpRWCMKvnKS/sfyB+rTCgVVoJP5ksBF5sMelzYwaxFBDS7xQF
 6adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792752914; x=1793357714;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b2Fd5oNxkb9TwPHoe6jZ2lXM4JNiBNNjJrD7JxD65p8=;
 b=xpemdbkH2LSD/la16fdaV/uGIDhqFuP90tuXXNbDixcYDy+6KjsHnAX44tvx4nq9i0
 CBL7MzJxgRciDRTLswrlevy/mNxwDmgJgyMM5yKz3owrj8d5jhOKxcOKypepjabjAtdN
 03KRVMSrFRuaVXGB3mo/gs7qPzQFx3+sGzraQ1hRo7pvA7KSWSMEzCq22p8OJtY8P4Pn
 3WDJPvOBdH3fJcliQsDFvZ5VSsn2WX/xpWGhGq1prhl/DR7inb6Xmajlnf9/umOYIB2t
 ijUvdRc18pesCyxbpnpHSJjAFKA/HB/58VbobzHhCr6kmogpc4LGu4iynFe3l/3g48a5
 Tulg==
X-Gm-Message-State: AFq9FYI605vQ29iSnocbolHCnGO8SVKPHL84FudySzn+evcLVDHFL69y
 ZyDdYHpda7GVJMwvwGxSbF9GhCbwkAX83EQORYEaU3/8UUknj7wYnkXCN0HLCMyvc1k=
X-Gm-Gg: AYBFou0kBLaJ9RNvfy7dfLw1xrVP+n7uhPjLE71vZsOIYq4k0xh0W95gzDUN46fPJjb
 OQT+jseFhBuEfz/KcymNR2Z854z92svhvQlmt3NeQNwEPq09fFwEkUn4jA7n3422asRc10EKstO
 JZUeZf0UOWVoluHBpVv3xoX0vvAs6UXIVYnlENPMu+9GQZupYFb17kVcwx0unGQVccb9TFYgqL7
 8sapMAuT9+GXGHh5/zLo/ibzkNCXPfcRXoyp9v76EPr7ehhH9dJQd/tnDgl6QKxcah+4Sl3LLUD
 q4B7Dx2biFf81ZUTVP0dDXaq21fUjLVhOSF12c88RO0owRFwwzMIXRxb+kX1rX3T3z7En6A1pvk
 x5vcn1TcYzCaNGQ395033eg8ZPAf7bJr9rzGWqhoav+iWDfYGH80lZYzVYjeGeyhOfurpD6aODi
 GiLjmTtL581CyanTLcUKHP1zI99ak2Z5fwRYwng3bB92iQZPYhRXbbcuxuRSjvfKMA2tjK1uoaE
 Pq2hUK+/foIUbNCMTHtbPWJPBC3VoMLA4AbvbtatPtlknMTicYlLaBfB05BJA==
X-Received: by 2002:a05:6512:1283:b0:5bf:a490:52fa with SMTP id
 2adb3069b0e04-5bfb0b3418emr549995e87.64.1792752914189; 
 Fri, 23 Oct 2026 03:55:14 -0700 (PDT)
Received: from [10.8.1.15] ([149.104.78.189]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb027d075sm324260e87.32.2026.10.23.03.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:55:12 -0700 (PDT)
Message-ID: <99ad760f-c563-4c68-b5e2-bb473c5b41ff@gmail.com>
Date: Fri, 23 Oct 2026 13:55:07 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: julien.lebourg8@gmail.com
From: Ilya Bogomyakov <tofu.connected@gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Julien, all,

I tested the v2 series on a second DCN 2.1 machine, with a different
panel setup from the G733QSA.

Hardware:
- ASUS ROG Zephyrus Duo 15 SE (GX551QR)
- AMD Ryzen 9 5900HX (Cezanne), Radeon 1002:1638, DCN 2.1
- Main panel: eDP-1, 1920x1080@300.01 (666.62 MHz, vtotal 1111,
   31-line vblank, ~93 us)
- Second internal panel (ScreenPad Plus): DP-1, BOE NV140DQM-N51,
   1920x550@60.02
- Kernel: 7.2.11-arch1-1 (Arch Linux), KWin 6.8.1, Mesa 26.2.5

Before the patch, enabling both panels at 300 Hz + 60 Hz fails:

   amdgpu 0000:07:00.0: [drm] Mode Validation Warning: Unknown Status 
failed validation.

KWin then reports "Modeset failed: Invalid argument" and rejects the
output configuration. SDDM's Xorg greeter also falls back to the
ScreenPad only, leaving the main panel on the framebuffer console.
Setting the main panel to 60 Hz lets DP-1 enable, which is consistent
with the short-vblank/p-state explanation.

With v2 applied, both panels stay enabled at 300.01 Hz + 60.02 Hz.
The stutter-latency snapshot/restore is included; this round tested v2,
not the v1 one-liner. Steady state has no validation warnings.
Changing the display configuration still produces a short burst of the
same "Unknown Status" warnings before the final configuration applies;
the status message itself is still not informative.

I built only the amdgpu module against the official 7.2.11 config and
Module.symvers, not a full distribution kernel. The module loaded and
the dual-panel configuration is stable in normal desktop use. I did not
specifically stress MPO/flip_done; if there is a particular test you
want for that path, tell me what to run.

This turns the ScreenPad from a 60 Hz workaround into a normal 300 Hz +
60 Hz dual-panel setup. It would be useful to have in the stable tree.

Thanks,
Ilya Bogomyakov

Tested-by: tof tofu.connected@gmail.com

