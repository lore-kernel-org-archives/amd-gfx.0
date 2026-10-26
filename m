Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F02606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VtzxTUpx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8C910EBE9;
	Mon, 26 Oct 2026 07:41:26 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C9F10EBE9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 07:41:20 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3ab28f3e4dcso30326341fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793000479; x=1793605279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h88WcqDPqZBUi5FkapMuvsXDFtP2x22CkYcuFL5W6bs=;
 b=VtzxTUpxy5rPMaNjumxBhBuk5QO2s+bnAFlRmxcN5EbSDqr/2hxdmLVDU4VM83u1vf
 tB0bfFxQTkufbtlt7zfCKnaL3D9GQQ2Q0geFirVeRbNM1tAtxcWNsfyowCEj8wOIG4Vr
 HD1OWxOSdf39QF+f7418bt7d8L5DJ5YlSLnxzUips9d0zYM8LZ4oeVTXTxKK/Btzujl2
 Ag2sowYwHQpdSRucHAUqdt+T4RdRlQNznClYhQ51w2OTXRBISfyOyCNdHxp2f4H+Jtzt
 9WMh6OkafoCCnvKe9mbtfMHV+cuuOuJdH9i8y5WsyKZyTtjku/NAGdv5T54z2/JPgHAY
 CwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793000479; x=1793605279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h88WcqDPqZBUi5FkapMuvsXDFtP2x22CkYcuFL5W6bs=;
 b=ETG+sIo2VOGfHCWitvk4Gh/DtQ/y3d7YGWJIsdXxeDjgknBkYNIIVhaFzh0J/sKyTV
 FZiiu9BXILHWPU2QB0wDaKh93GytPOLVCDB608cflONxMPBDMMP8mLNYHgTfGZxLdV9o
 CD9H9/JbE25CJQ7PCbPWjR+QvUFF19kqhsOaeit1mIMP/YcnEzuxipzL4p3j3aAMN+4G
 ho44KabD6koAA6Zd56Tg86gnaw90CIFVDuANlvPxxKMvDniyURZV0SigSTHrdQFMmfFN
 9+uvwei9WxQzM5HkiHkstS27TpEOjJganJF51lUW2DgY1Vl6E/3IEemnFh1OivCWIfTL
 DlXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBztGIxJFKeJaM0qWdAlReiEk9H5/VLQjzqp8fEbZJiVqXip7Fhrv2NETtcMVeUrzTp/zbckcYdy@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ97if6RZO3EGT/fiLKXPXpoFB0FOtpVOY3RiIWFkTsvbtxOAAW
 eGfhYxVW4ZU9Nz8aRSvdIodaIIFM+zqI+CRaDvZC+8M8X1LlhtXkOBtLKRT0Dw6nzHm9PjWX
X-Gm-Gg: AYBFou3vCMuzEVhCPIWwRQCfFCZXCmYDosE5wKoBYXUJroKFQTcp85YHmGo63Evg6at
 YFchIZwpIdtQb+cMcsOc0t9aMMYNRVdUXh51BGGc7rnpgJMHphyNyt51+JKy9hGyxoj60i5sBeM
 LMfXv4XIqWjTUFICfMiqY0YiG9B7mZuRKO0tJK4r5GMset05Zdnplx2Y85fNPcCaWU76Xsav7v9
 NfmGQDPl7QB4YZA+MBh75lLXsrB9EUus2ffyTRE+0THKdZJ5PhlIzMBZmiCTOhdzZYhp2GW+s2C
 qcjBbxM5HtdgbxdXKSGkUfKMN4kFxOXnBIVD7lSCg4O/0z7bHOCLQRKnFpNnZU5vQ1vXTwYJruF
 nVurWg6Dz1NKLahzoD8xU84Cf2Y8pd2l0ky+Y46Z/siB0xLuFCGKY+diTqPAny/S/uWDNL3oUKp
 WLSQOEd1EwuKtrQgMRGozn1uDtnxig9wfyl0pLNmejnwetS5Y/GMsBogBUv5rpUcFgSXue7cIVr
 AS/qMRGFOJmatMKZIy+mv19qGVvIy9vuh3pbtMPPjFWvU+DHkSm7cT7J67cHDmOtbCnSl6qMNCR
 r/PIevjoVd3C9DfOSvl5WPDKt/sSBYvfUw1an12G+NP+EsYrhe9rLA==
X-Received: by 2002:a2e:a917:0:b0:3a9:8762:d77 with SMTP id
 38308e7fff4ca-3ac6fcbf58bmr12890491fa.6.1793000478642; 
 Mon, 26 Oct 2026 00:41:18 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a493b6sm15089911fa.37.2026.10.26.00.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 00:41:18 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: set allow_freesync before validating a
 new stream
Date: Mon, 26 Oct 2026 12:41:13 +0500
Message-ID: <20261026074113.299632-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018221726.27259-1-mikhail.v.gavrilov@gmail.com>
References: <20261018221726.27259-1-mikhail.v.gavrilov@gmail.com>
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
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Superseded by v2, rebased onto amd-staging-drm-next, where v1 no longer
applies, and with a Tested-by from a second user:

  https://lore.kernel.org/all/20261026073345.297491-1-mikhail.v.gavrilov@gmail.com/

-- 
Thanks,
Mikhail
