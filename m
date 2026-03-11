Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802AEFD88FA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1180010E30B;
	Wed, 11 Mar 2026 04:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fatooh.org header.i=@fatooh.org header.b="G3IbAOoH";
	dkim-atps=neutral
Received: from juniper.fatooh.org (juniper.fatooh.org [173.255.221.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED3210E30B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:51:04 +0000 (UTC)
Received: from juniper.fatooh.org (juniper.fatooh.org [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by juniper.fatooh.org (Postfix) with ESMTPS id 389A2403E1;
 Tue, 10 Mar 2026 21:43:33 -0700 (PDT)
Received: from juniper.fatooh.org (juniper.fatooh.org [127.0.0.1])
 by juniper.fatooh.org (Postfix) with ESMTP id 1633140400;
 Tue, 10 Mar 2026 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=fatooh.org; h=from:to
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=dkim; bh=5RBRTM5sXAZeqEzW/E0FSVJga/I=; b=G3IbAOoHxGl8oRhD3+Hy
 w+Gr4Q1t7Z+jAdI6Kc1rb4njyzsQL9968LOcVKhGGqIbTY5gCDdIgldht6XvZXAP
 geMIOu8+Jn9vavMHG8JRjfiZYFSKBSaQzOKFC6ofQvx9xZk2TgAcIyMm45YoT44i
 f6b5/yv5wxHK+UNBgQwGYH8=
DomainKey-Signature: a=rsa-sha1; c=simple; d=fatooh.org; h=from:to
 :subject:date:message-id:mime-version:content-transfer-encoding;
 q=dns; s=dkim; b=cjkCvDAprQOG6mP4uCta7looN5p+Edi7alXaK5YjsYFtvi
 mAtuI7FwQqb1sP9PPMcDQbGiB/I7/C4yWaWuwpuJm6VGgd1g9V0bdYkUEYnRjwAu
 KjTd1BEtma+8QwmXeRr+h8PE+dMlMKSr/UutZMcjgYAFhYd35RsWgt5l8ul4s=
Received: from bugfood.local (unknown
 [IPv6:2600:1700:9750:59ef:62cf:84ff:fe62:f2b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by juniper.fatooh.org (Postfix) with ESMTPSA id F200A403E1;
 Tue, 10 Mar 2026 21:43:32 -0700 (PDT)
Received: by bugfood.local (Postfix, from userid 1000)
 id C21E7C219400; Tue, 10 Mar 2026 21:43:32 -0700 (PDT)
From: Corey Hickey <bugfood-ml@fatooh.org>
To: Corey Hickey <bugfood-ml@fatooh.org>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v1] fix 2D OpenGL hang regression (Radeon RX 6700 XT)
Date: Tue, 10 Mar 2026 21:40:22 -0700
Message-ID: <20260311044311.10941-1-bugfood-ml@fatooh.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This fixes a regression I reported earlier:
https://gitlab.freedesktop.org/drm/amd/-/issues/4663

I tested this revert applied on top of a kernel built from
58a261bfc96763 (the commit which introduced the issue) and I did not
find any problems in about 4.5 months of operation.

Today, I tested b4f0dd314b39 (Linus' tree's latest commit) and confirmed
that the original problem still happens. I then applied the revert, and
confirmed that the revert still fixes the original problem.

Other than that, though, I can't say whether a revert is a good fix or
not. If you have a different fix that you would like me to test instead,
please let me know.

Thanks,
Corey
