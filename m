Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D49606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SeM/e3zk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FB610E7AE;
	Mon, 23 Nov 2026 13:54:45 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF84010E76D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:30 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-38587f3de36so3884343eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436550; x=1796041350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fHN89iqHMglA6tA6YLX3To+FpptgLkpu1uDNq5dshLU=;
 b=SeM/e3zk2tN/ixTNyBt/TwMePH9Xeth8Y2T52yYDBv33VE5fcY573wa4vbvUPbofv1
 KMdi9FvbfKz/O1sL8XYKNdOSq72bPyavDxDE8YiY2V4URTr7ckla0/w7Ecad8+x+4X8z
 Og931/CkkH3pEdauoNOPlo7qL4HNgExXipxPjBlrQfexZn+4JQlZuTq7J5dkc9Yfjk/q
 HQTQDdR5UP35WZ0THh1SkcFE+biNXsvExhkGFenlT2+bcr2lopfiWtiYmff0cdyqdJMR
 1fri3garxr3ir5NyHqGs95sc3suE6Xx0G4yavBG7sSu4i8RLqyzTT0WLcg5T36/EQbPD
 MZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436550; x=1796041350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHN89iqHMglA6tA6YLX3To+FpptgLkpu1uDNq5dshLU=;
 b=zYjclD0d4d1tTNChIZyXjrozgA/eyp1XCsyEcTPQtMjWkr/uB+KYpiqU0OwzZl6fUE
 q0oPukANxwH2b/vJ7iciMhgvWKQrjalhb2VhlKgvUBYNmZH406uOaKOS7kozGWGahpEg
 3nFb4I6IHZ57ht9IEEVbYaoFEWh+9SgtG03zurcBCS5lyCyJYaXjV90Dm8dgy4tfUs3Q
 9z3c1EN9efl7Iv6ZyPMWSbs+juk6argT/lSFNM0KjJZpZpN24VjD5Y/1xhxS+KXftGyu
 /ZJaWQYgFT+rxxfZxGpxPxHvENtyJyPOLhQesrE4K1EjW9jEbwPpvzauCMHbh6mBfF1F
 DgtQ==
X-Gm-Message-State: APuU4Z9Ml9k0XkUiM6Y5uHNxlTr/QNXt9HzYzEdh1eK/W0KazLvggPZF
 FFd7Dbb12OQxbiQdreQdri8Uw4kKhKCdriMreRplk/AN0nyqOwaI2rTIj5LOe4ow
X-Gm-Gg: AZFdTZeTxnG7rxeDh0/hv9FP8O3/FHi8l7EEMhF1qJSBoRtz2sPan8d5cpmtjC8GCev
 E+XjVdfhlfzb7j2d148TUGTop+YysJoPJ65SyPcZx7iCYOHzjglxcYfI/26ETZqPYyosBHo+HyQ
 ZnRxgjQ/92nUiOG08VLKhO8tuzGEtU/Hu299bPtOrnApDSLKalWu2+vnkoGXd0Du5TU++hFeOEN
 4SUX4OPjXKBJM/7FcjiVKAfOfBqGJZcdorvKegxY0a9PrRqZFU3ix+keJV/rkK9oD2lDMmZy8BG
 +67ZWeRQL4HyW3J3sR3K9BpacDYTBAdFtSMIzUuT2DMefechVKkUqTsr0qzRHaLG710R82ybUnC
 YuYm5uMQGv9fIjpZ2wmy9Br5U+/HWQKCICSP6Vq/+nBQumVr6F50LgJD7NX9YLFt1UAt5qWcq1W
 KzuR+E2FbwQ/b2l1zShU3J6Bb1jhBsQ+3tH+0t0VLlUqAbfmhmonlCt/g9YeC8EEub8UhAoYdRj
 mopIOTOx/rZ2Tp5X2gWjT5WQOKhuDmvWV9Fu5xC47Xl0zyA4EDQCpfFEck32G4KP9C8K3Gm5KDR
 pDrfQLrdgtbuS9dxwX7T
X-Received: by 2002:a05:7300:8807:b0:369:5583:bf4c with SMTP id
 5a478bee46e88-3856ff5bb62mr12060416eec.28.1795436549928; 
 Mon, 23 Nov 2026 04:22:29 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm25173398eec.1.2026.11.23.04.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:29 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 0/2] drm/amd/display: document two members of dc.h
Date: Mon, 23 Nov 2026 12:22:24 +0000
Message-ID: <20261123122226.4101191-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:54:41 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two undocumented members in dc.h, both reported by kernel-doc: the union in
dc_probe_status has no description of its own, and the comment of
mpc_color_caps does not mention max_gamut_remap_coeff.  Both patches only
add comment text, so no build was run.

The diff is unchanged from the previous posting.  As Weijie Yuan suggested,
the AI disclosure moved out of the commit message: it is now below the ---
in each patch, and it is also in this cover letter.

v1:
https://lore.kernel.org/all/20261121041427.1743954-1-takano32@gmail.com/

The changes and the changelog text were produced with an AI coding
assistant (Hermes Agent, model deepseek-v4.1-flash) working from the tree
and the git history.  I reviewed the diff and ran kernel-doc on dc.h before
and after the change.

TAKANO Mitsuhiro (2):
  drm/amd/display: Document the union in dc_probe_status
  drm/amd/display: Document max_gamut_remap_coeff

 drivers/gpu/drm/amd/display/dc/dc.h | 2 ++
 1 file changed, 2 insertions(+)


base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

