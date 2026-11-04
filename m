Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A79606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HI7WG/M0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FBF112461;
	Thu,  5 Nov 2026 13:45:34 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F3F10FED4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:11:07 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so368623eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793823066; x=1794427866; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=axktSpkMz8G9oKTbdKR+y7TQiCVf6bAQxEAR5q4VBnY=;
 b=HI7WG/M0pf2WfBPgz7XJkqPpLxkDmLtQl8dAw/nIHWWxywZ3U/86kh9IYSB/uO4S9p
 wG5xV5QOhqRAQEDR7ekDgMt06RGr7fwB0KId3S81Wthz3IKEoKxHKVKPL9HU57HvpuNe
 WQorkwl2vIpRqgBVgCoOGQKRwmVMoBFdyreu2++AUrIqsw0K5vfHktAUqjnsDXDNrz7y
 3422GsqQADisV+TtVHd7l8t+72k7F5mrlU2lh0QJfss615tJ4AQ9zgzdwxxdASEWj5yM
 ekx11lH7hNCdFB+0v5EHX222XR0+TuLdTRefeEjQ+OwIInFH99tYjAAXLK/zn5P1zIdc
 NS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793823066; x=1794427866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=axktSpkMz8G9oKTbdKR+y7TQiCVf6bAQxEAR5q4VBnY=;
 b=tyY9pJCMOgELZsbhMRWPF83aUdJlmTWAATpT+ZUz6POPdLQHTqyj8XRgKE/mQNzn02
 VayWM5vJy/OUWRer2XlfdNzFNIs6Dwvz8H/KvnmwiiSPVF799f45+JH3RSLvlamTbtgZ
 HZ3opKHJyL/HNy6eDzAd7MHuMvvw7jEnEq482GmQbgT2kNPZgnEwknOZ3GSzlk0bWX/u
 6SfjYJ9MPn1ZHlrleuscBe/Dcj/KBM6XFUYfEyltqBk7IsWijWmfvKuRbgEAxkvtG4zN
 myU5v+KDr6s+z/v7T0zDBMGFikict8s9tYaSd8HJNCLpaTKUpWYt5g8vfCe1XTFLfpZn
 bt1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaGIZG7ujm2eYh93c0Lk7ZrOaD/sI0XEQQJnCIqYQ/efXdcio0BLEbfLbqbr/w6IT1dHgzuie6@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/BhuaJ25tYTNbzBhieIlL3E5ppFcsu574Y+dx/k2MbRTp4SME2
 9U7e9BMl5hFuWF7BLmLUIFksiOW7F0eTLNjj681z23tQSr2sbEozQW0=
X-Gm-Gg: AYBFou1+Qw8eWSvzr++b5xwHF+202sPSFRLvp3+45QgXnqBoOYLL7Vkep9VNKiX43RP
 IgARMUD+vp70J6h6kSDqS9FyME5UHyEhkii3MKqIPov0EHdpz4jRG78cVe4ftwlLZjhxsjuKba4
 x1Gv5bI9B2zMwt0HLaMbTXHANFDd37KxRrPikwnwWaRUDl3inmkmNcmmv15CbfqbkqSPc/evi6v
 3PFQLhxSp0a5ICzf0ALL8URle1cbMznw13KC3nzDrOMsXQaxkLe/j2wAwuXiXnjHgwtV0q4kD7h
 KG1XR3h5gugyWtULJMPSsfigAraJbRKHHCLUGi3gZfW1oOewfb11j5JRb6AbLF5DiOCxR6diuaJ
 6lhoN+9uJFi4+PvIiZwWEhxbFpuvEbhsIzxFBPnS21ZJTItuE+xW/Dq+TzBQxC4rWzGxDQ8HNrQ
 f2hs7R1rFWmFhYgRA1T9Fs/QxnFsVSeafs3Ua4JDxfsXXLizfXX/BrV8Sj0LLfu53JVyPfqvwq0
 wxL1lZLPS9fFW+9Jr5tzUZ+tIYBaTJVBzYz0o0X1Q/kjhQWyztTapSbm80GeodwqgWhuoiHE1G6
 gzU6likZkY0X0WjQ9rxBrb8qHYPUxe3GOlspYkMs57lgrpZFHyELotweVUFFybEx
X-Received: by 2002:a05:7301:2a95:b0:36c:9afe:fcd8 with SMTP id
 5a478bee46e88-36c9afefe8dmr5613420eec.30.1793823066322; 
 Wed, 04 Nov 2026 12:11:06 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36dd7ec8881sm2731938eec.18.2026.11.04.12.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:11:05 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, linux-kernel@vger.kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
Date: Wed,  4 Nov 2026 15:10:57 -0500
Message-ID: <20261104201057.8395-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
References: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
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

> I think the rest of this can be simplified quite a bit.  I'd suggest
> rebasing this on the other 5K support patches and see how much of that
> code you can share.
> https://lists.freedesktop.org/archives/dri-devel/2026-November/610011.html

The code that i saw, dosent have the ability to change resolutions, and the code
it self, is basically completely different, for example writing 0 to 0x4F1 completely
kills 5K forever, you cant alive it again on iMac20,1 and the code does that.
