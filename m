Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E5F606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTjvhA9i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3947112121;
	Thu, 26 Nov 2026 08:10:25 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887E810E4CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 01:23:23 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so7121156c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 17:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795656203; x=1796261003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1o9ngBXV17K0T9VIdpByWQ1tf1l/DUIzKNbevHfagQ=;
 b=yTjvhA9iNF6vJHPxfCfnMX7xExmYLGEPNUXl0juoyPwXGR64rZT26h7j1hvQbb1NHG
 7WWPmiMz0aqO7VrkxbGqxrlFDyNR8uECqeAFxDFswTlD/6pcRU+s5hE7ZniaRYpILaq2
 ZCowWCt3k47mSxfJ2D3CYfNSWCGg9ahHYzGtAu3XuVgpxvCXZUSsV4+zpSj2x0p875Oh
 TqiOGwOtF44skGxRF+KNf95LIvKaAPsbx2E7NxzaNzdZFi6yAb7kmnjPX6NKwg6pDkoW
 b3Xawek2ow2JS6/bi0qfqx16FESlAJdYay/egRwjcfPw1J12xKWLCLTwpHo30iLmyCPj
 sPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795656203; x=1796261003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T1o9ngBXV17K0T9VIdpByWQ1tf1l/DUIzKNbevHfagQ=;
 b=bdl6XmXY3vWeC57pLiTmlvusAf8KczyH38qg5vzs6eRcFBqMlWSQ8mYVLGmA8vBkGv
 SWOmqiChXK+PzGgPw6scylLxNVep+ilCMjm/58gjRTxVs7CcwaaGX6UUIQ5ypv6IDHVc
 G9wcfAWgb7vkKHXOY7UMRFiza36TAjKpKFzO91yhaJMqUaQIHa5sxO45ABMYnHTyre5Z
 UjQRAQFs0iLugWoL6A3qzDLsmiDmo444PHYN1uS80kKA8mV8YeMISww7BZMRCbwT+kN1
 ps1swLcGl4pvXdp1WaoAez2PMAmZjD1s77wjNzlDNWV3JUEZPdCNHrZ8QaPTHeZcDffe
 dACQ==
X-Gm-Message-State: APuU4Z9A8v63sglJuSusfua6gBDzN2r/vtER5OQ8UUBBcnb74GSi0Alw
 wiRuROsgCI1ZncD/6inPypnVKBL7JM0+W7ynSoFPaXVWB/BvBms7drzCi6Dvnkpv
X-Gm-Gg: AZFdTZco+d0yfx9htQ2MDyez+CGtrrXvjuoeWovtgfrTvpdr08o8cVQbPbk1UpPddJE
 +jSS6kAlBsZbAlBVih+8SrFk2voZuEWYfr8J8lem6/JVSn4RNBQqLodCCu7klzTviqIKalgSZue
 Q92nHEwlX1kWFhdLTeU1s614GTcHHEPXuz+G5UFDVoRfmKVoFZJ9NGIH+3/fPZ9epntwWoYoS/Q
 EYEwoOgpFsnsgXpp1frlTR0vXVc+y+Ei+d81mRAeY763S8dg7g3YZLufY0pMk8TYUEAxtOt5d5H
 ThhFw1v/ipMF7fFCXykg1zHi6bs6gp6/G3zClF/D1ur8rNqFensNOc467BfOzonRlDF6J30s+rH
 nVZ4z/Hey1PzHDHCisg/CuzNHdf3983CpPn9wFt27jcNLtuNnhgK9VLk1ARvVt1JH0h5F3xU87l
 E70BY0WhkBwW88+xtGponm8OqCp2aq92MCgCKjYcF0vb81CSkFERjyrOeAe5gdPL3E3oz/3GAuC
 30ZPS6XchyomCwgJYiFWOrcqs6rv17TQBrL0fL898G3OhwnzxCGVnkTEZeSCijM7V2US3v51iFQ
 EV2ZUrKaIYVnGj/1Hmri
X-Received: by 2002:a05:693c:600c:b0:36a:1bac:6bf4 with SMTP id
 5a478bee46e88-38570451dbemr22625193eec.18.1795656202605; 
 Wed, 25 Nov 2026 17:23:22 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm59360148eec.12.2026.11.25.17.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 17:23:22 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 2/2] drm/amd/display: Document max_gamut_remap_coeff
Date: Thu, 26 Nov 2026 01:23:16 +0000
Message-ID: <20261126012316.2624853-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126012316.2624853-1-takano32@gmail.com>
References: <20261121041427.1743954-1-takano32@gmail.com>
 <20261126012316.2624853-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports:

  dc.h:329 struct member 'max_gamut_remap_coeff' not described in
  'mpc_color_caps'

The 17 resource files that set dc->caps.color.mpc.gamut_remap to 1 also
set the member to dc_fixpt_from_fraction(S3D12_MAX, DIVIDER); the other
ten leave it at zero, and the comment of mpc_color_caps does not mention
it.  Describe it.

Fixes: 1c5e6cd8291f ("drm/amd/display: adjust floating point format for gamut remap when needed")
Link: https://lore.kernel.org/all/ec4d7cff-d23a-46d1-b245-921f442b9a7b@redhat.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: The disclosure moves below the --- line, where Weijie Yuan asked for
    it; the commit message keeps the change alone.  The patches are
    unchanged otherwise, so the diff is the one already posted.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran kernel-doc on the file with and without the change.

 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index debdd69bbe4e..32bf87fed40d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -314,6 +314,7 @@ struct lut3d_caps {
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC
+ * @max_gamut_remap_coeff: largest gamut remap coefficient the MPC supports
  */
 struct mpc_color_caps {
 	uint16_t gamut_remap : 1;
-- 
2.53.0

