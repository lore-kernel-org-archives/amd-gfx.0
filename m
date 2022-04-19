Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A84C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 12:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E27710E2A3;
	Tue, 19 Apr 2022 12:49:50 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE4B10E77E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 10:38:14 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id z16so8482252pfh.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sslab.ics.keio.ac.jp; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v4bWODHAE/RCs4ytYs4rVZozOzTNQQhYomCKGYtkHnA=;
 b=W8Wh+xVGh01Uc6uix5XTB5eMRgqUJ+4MkQcIETafwAEScVJukF0ttf7X4iq06hKoaf
 cIPu+UaoGXFpd3kAAVt7vrZLTGo/1qMBHYSyyKQ6s6zXuUTVdPZ9+vrwmEaKjWJmwAmZ
 XkR7r2pFM/dpnZ6mhMrqOs7cEAyVItIpifS5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v4bWODHAE/RCs4ytYs4rVZozOzTNQQhYomCKGYtkHnA=;
 b=7pVOXf9B60wiOsGRiWhKBOT8pckG7q+7diDZ8uvkYcXD47TsadES7xVzCMSjD1lYnM
 davNEylgZ7Z9aoGZyffHD1kAHgtFUG/MNdMwQMVyC4mHm65+WUVvHmNH4vMlKAWW9BXw
 vfC/040c2YED4oH/sf9kx2AyXD2HBuULLiPMLbVlkrQ6MNF+epgLZEqbNVOlCd/9GRIM
 4L8CAMYv2531S9PLx4mNYbfBc+xAm2KX0ogX/yXtwPf3EJ96hH4AJzQj/5MJEi36ZHJW
 3GGwonj7lYi5lhkmPOyezCuyiZw5L1tqlPlF+SVkp512Ojujc3E5HHyla1LzLwA2JM51
 BE+g==
X-Gm-Message-State: AOAM530aLnFen6HbIpat3kJxA7cJ5Beh2pxS6jz9NUBF6qGK3FK6tVcc
 icFjhykZGnHJO3eHZOfRL+h41w==
X-Google-Smtp-Source: ABdhPJwByVB/GAZirrV7LzYHS9EcpAwq2tKDU98/ISXTP+74UwHctRW7VQ/dDonrNaJ1o+CdOq8ahA==
X-Received: by 2002:a63:6a85:0:b0:398:9e2b:afd6 with SMTP id
 f127-20020a636a85000000b003989e2bafd6mr14279075pgc.582.1650364693955; 
 Tue, 19 Apr 2022 03:38:13 -0700 (PDT)
Received: from saltlake.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp.
 [131.113.126.173]) by smtp.gmail.com with ESMTPSA id
 z15-20020a056a001d8f00b004fda37855ddsm15085869pfw.168.2022.04.19.03.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 03:38:13 -0700 (PDT)
From: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
To: 
Subject: [PATCH] drm/amd/pm: fix double free in si_parse_power_table()
Date: Tue, 19 Apr 2022 10:37:19 +0000
Message-Id: <20220419103721.4080045-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 Apr 2022 12:49:49 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Lijo Lazar <lijo.lazar@amd.com>, David Airlie <airlied@linux.ie>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 keitasuzuki.park@sslab.ics.keio.ac.jp, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function si_parse_power_table(), array adev->pm.dpm.ps and its member
is allocated. If the allocation of each member fails, the array itself
is freed and returned with an error code. However, the array is later
freed again in si_dpm_fini() function which is called when the function
returns an error.

This leads to potential double free of the array adev->pm.dpm.ps, as
well as leak of its array members, since the members are not freed in
the allocation function and the array is not nulled when freed.
In addition adev->pm.dpm.num_ps, which keeps track of the allocated
array member, is not updated until the member allocation is
successfully finished, this could also lead to either use after free,
or uninitialized variable access in si_dpm_fini().

Fix this by postponing the free of the array until si_dpm_fini() and
increment adev->pm.dpm.num_ps everytime the array member is allocated.

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index caae54487f9c..079888229485 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7331,17 +7331,15 @@ static int si_parse_power_table(struct amdgpu_device *adev)
 	if (!adev->pm.dpm.ps)
 		return -ENOMEM;
 	power_state_offset = (u8 *)state_array->states;
-	for (i = 0; i < state_array->ucNumEntries; i++) {
+	for (adev->pm.dpm.num_ps = 0, i = 0; i < state_array->ucNumEntries; i++) {
 		u8 *idx;
 		power_state = (union pplib_power_state *)power_state_offset;
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
 		ps = kzalloc(sizeof(struct  si_ps), GFP_KERNEL);
-		if (ps == NULL) {
-			kfree(adev->pm.dpm.ps);
+		if (ps == NULL)
 			return -ENOMEM;
-		}
 		adev->pm.dpm.ps[i].ps_priv = ps;
 		si_parse_pplib_non_clock_info(adev, &adev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -7363,8 +7361,8 @@ static int si_parse_power_table(struct amdgpu_device *adev)
 			k++;
 		}
 		power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
+		adev->pm.dpm.num_ps++;
 	}
-	adev->pm.dpm.num_ps = state_array->ucNumEntries;
 
 	/* fill in the vce power states */
 	for (i = 0; i < adev->pm.dpm.num_of_vce_states; i++) {
-- 
2.25.1

