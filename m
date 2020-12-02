Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B070C64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 08:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013302222E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 08:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013302222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823A46EA35;
	Wed,  2 Dec 2020 08:27:21 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A39C6EA04;
 Wed,  2 Dec 2020 08:27:20 +0000 (UTC)
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH 0/2] Fix some kernel-doc markups with wrong identifiers
Date: Wed,  2 Dec 2020 09:27:13 +0100
Message-Id: <cover.1606897462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
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
Cc: xinhui pan <xinhui.pan@amd.com>, Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Jarkko Sakkinen <jarkko@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-sgx@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After applying this patch over next-20201201:

   https://lore.kernel.org/linux-doc/cover.1606823973.git.mchehab+huawei@kernel.org/T/#m0072adc6eb1af595a31fcc3b019cb81ab28c7b9f

There are a couple of new warnings that the kernel-doc prototype
doesn't match the documented function.

This series address them.

Mauro Carvalho Chehab (2):
  asm: sgx.h: fix a typo on a kernel-doc markup
  drm: amdgpu: fix a kernel-doc markup

 arch/x86/include/uapi/asm/sgx.h            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
