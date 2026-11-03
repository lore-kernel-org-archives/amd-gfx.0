Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76438606A32D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H8yQ6vXP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680CA10FB60;
	Wed,  4 Nov 2026 11:12:27 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319B610F64D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 15:01:09 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1b1ce85287aso2211867c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 07:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793718068; x=1794322868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oarYStm9NOVDCd7EiAguOaCoaegl4vfok0wEv8pYK0Q=;
 b=H8yQ6vXPDIZ+5IXi4TTtIMoD9ET6iNeyFGKQdV9vezH8JzEIh4t5i0MWTTmsYMmtcj
 cuux/OT/5KhEcWWKf+fx/VGpOrNq6apg2JA4/pEJ/OmbOvzeG1XX/7fmE1M8tDDGL5kG
 uHFie/jl2qzferkM5Iw9hKvNX7JWLWsxiZFZRMMwGzWT5feilMXh/uIIjjEjexYc9aX7
 SyxtTymNXBJWnsISbYymrUpw6pT2WHOEg4pIihX3doc1gWBIOLG3840YJB5sNlEj1nNB
 6irMQBNVaVxuoVn3yMWu71XqffZFvu9jbs/i0ZuiaqEmgizEZ6zEZZE71dEN2ZzCDZt3
 lMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718068; x=1794322868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oarYStm9NOVDCd7EiAguOaCoaegl4vfok0wEv8pYK0Q=;
 b=eKaLWpymMZkBJ84yP7TMxH0RrS6wjuvsW/w/EdFAJTmfd3cZsMqrTTS0mYeIGsr6SX
 f+8Z8eMsAA0/G8XnHysOluefAwYXcqpCvXDlqVKqKkdCN6luX68srPIMLPqLgwy6jALW
 eEohvCTjnAfd0vUW1MTQE3JRZBvwSvPlrkybsoGbiq3CI2RAWvlUiemi7fZCEqVKUcWl
 vCamprLxShPxeHGe24yhNdFgAtLXVaYJb9mKYV+iW9OPYyM8Iv1M5FHAUN0636RUNcVu
 ylh2RphsonGnjMH+fT6XV1V6KvF2EophIhijkdboC+X9itatko+5Q6izqOW3YT1UKaE4
 OycQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb5KTITeRsZJL6c45PXI3/UDzIYYncUv0tIJ0X+PpLjK+/VoJ3UlRR6WPSdxQM0LtRqxQXHo3r@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SHRfqHSsp4LkHD63lEQkgrXBbUfVX/rbd4DKeXT7CG4v6+QwT
 QgwUJU7f3y6TRltOGfsRlHP/I9VLopq5R4eVS95v1JEIAM8OP+KoNzY=
X-Gm-Gg: AYBFou0UGcUgx9T4xdUVNlSjh2sjqGXMsSBawHLpb6rx7wxNJrtFs08+4PDga/qhggE
 R8t4664/IcOKl8iwvLH387h93S2eJRhi+RpWD3WDwttOWyZ0klo2or/i329Wokp26drPMotGQ50
 IVddB/uileCS3zUoOv7T2592QRDHTXj/N9cstPPJ4cdFNk5BLKICOiN6BYx2zorEXo7ql5QwOfU
 lnSN9FLJJqIgylAqz9U6a+ov7pgrirr9VSom+nrqFAd+rldYM1rgJYRHZIHvbQwnIDRtEx7zNqm
 y9FE5sXTDNDQh1zM2tk9cLnM/fjCcbV1CfriPKh0XDdKOnexaXKGnG0Sd3gb5AfFrcPY9o3ZGvC
 DyII/Bt9swI707Eg3tRc/kAkaVMpz0LC5mtWk6eeTrEQlg9bd+HMyJpUDJvZPXobpdqN+cJW/nZ
 d5k78aHu0fkuq5mwaXJ0AP8fYfJsVLdgY5Lf2asD3YbLB12iK4lsMYXuMLrDLobsKnUB/ot0aWu
 JD/A+G1MBuZ2X/FYmYptIsQSXb0a2JUb4Npu8LmzNArKUOyoHf/iHD2vN7EgWqk4tCpTC0NtlUr
 QIBzsBpCaq314Xtss5fWxQfLmugtSr4AbBcvFqbG1odhd5aVpGpjkT3A0wB25g==
X-Received: by 2002:a05:7022:3f0a:b0:151:6e80:ba7e with SMTP id
 a92af1059eb24-1ac56c9ff26mr21254345c88.4.1793718067762; 
 Tue, 03 Nov 2026 07:01:07 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.19.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23b847348sm9693232c88.4.2026.11.03.07.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:01:06 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dev@deq.rocks, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 simona@ffwll.ch
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Tue,  3 Nov 2026 10:00:57 -0500
Message-ID: <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 11:12:26 +0000
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

> It is the same issue.  I don't want two fixes for the same issue. I
> just sent an updated version of this patch expanded to cover more
> macs.
> 
> Alex

How is the problems same exactly?, Does initializing UCLK later change the
PPTable?, and as said this is not even a solution for iMacs, so why are we
still trying to upstream this?, and btw initializing UCLK later with 5K,
makes it not initialize at all, so the patch is just wrong.
