Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589C3C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 12:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A23560F9D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 12:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A23560F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDD96E062;
	Wed, 28 Jul 2021 12:34:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5086E062;
 Wed, 28 Jul 2021 12:34:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A710E60F9E;
 Wed, 28 Jul 2021 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627475682;
 bh=2wKeig8qmDRZeeiIJGk5x5q7NdKFK9WJTk7jPfELINU=;
 h=From:To:Cc:Subject:Date:From;
 b=h2jpE/un8sDwiSUvsAyJRH2B6/0t7DfcPb/dZMdPwDgM35PXurqzYneTIjAhnZw2h
 YHckVIRd/1UlbM9UYusDYl//ESgrEhFMEG+jo6JEuN/XPKyEvBJ1dabIgB+QNjuEhl
 RNBBR99lMKO6KC2Nwrq3wNMOmz42WlCoDF8hs5v7/SR04+LdfiUOV8IrT1D9tBB4XA
 /Bcq0uKTGoXtB2QWlbU1OHw4lww5fgb53xNGFKhsjxQN1ZO9fPaEqIZWlgTe0gO0vI
 RfLQBzuJXHqVebUlWdXxR6ttcSnev4Th4sR4f+tS3H0RL6+GgbjkzsFO+g0ePkD/5N
 HSiBpHY/2d6+A==
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Leung Martin <Martin.Leung@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Mark Morra <MarkAlbert.Morra@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Date: Wed, 28 Jul 2021 13:34:31 +0100
Message-Id: <20210728123431.32687-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: dri-devel@lists.freedesktop.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

After merging the amdgpu tree, today's linux-next build (x86
allmodconfig) failed like this:

ERROR: modpost: "dc_dsc_stream_bandwidth_in_kbps" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

Probably caused by commit

  b6b76b0315ed7b ("drm/amd/display: Fixed EdidUtility build errors")

I've reverted to Monday's tree.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
