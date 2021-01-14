Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA35C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 07:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFE823A33
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 07:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE823A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1FD89F6B;
	Thu, 14 Jan 2021 07:53:56 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB6689B42;
 Thu, 14 Jan 2021 07:53:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C4C239EF;
 Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610610830;
 bh=BXt2olIMSsLtD8I2dioNC1dF1gnxlCbQs+WN6FCb4nE=;
 h=From:To:Cc:Subject:Date:From;
 b=s0XxntmYYJHZOMEV2ezXMlavrLQamHOON6XCuxktQJvVAECs99C5z/1aJ9vJhpL8u
 ooeeAl2QTMZNzf+wMfEpKpWg40tk1M0qnksP48Wj5LotBytvL5l6d4s7r5DnGwrSaG
 EH99zAztLa1B6MMeto4xMR8BJQ0ZLi5vAvwqfqQhhWEPmUUPibd3hUMclqtKjDn9OB
 Utpv0Ju4+AOG0dmdSki7FZM9GtjIWxV8jruDU/sDouAY8GwvD2n2HBSlFqfv/WWpXP
 DJr7Fq0cZK3daZV+WRhSNlCFNyWFUZ+j72ACR35krQCcJ9iaizMmnvIhYttJJ/HyQS
 YKU4ctJMp8S5g==
Received: by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kzxRz-00EPu1-2O; Thu, 14 Jan 2021 08:53:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH 00/10] Fix documentation warnings at linux-next
Date: Thu, 14 Jan 2021 08:53:35 +0100
Message-Id: <cover.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
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
Cc: kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Harry Wei <harryxiyou@gmail.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 amd-gfx@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, linux-media@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Daniel Vetter <daniel@ffwll.ch>, Wu Hao <hao.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series fixes the documentation warnings found at next-20210114.

Most of the changes here are trivial. 

While those patches could be merged via the docs tree during
the next merge window, It sounds better to have those patches 
merged directly via each maintainer's tree, where the new
warnings were introduced.

Regards,
Mauro

Mauro Carvalho Chehab (10):
  doc/zh_CN: fix Sphinx errors
  ABI: sysfs-fs-f2fs: fix a table identation
  KVM: x86: hyper-v: add a blank line to remove building warnings
  ABI: sysfs-firmware-sgi_uv
  docs: fpga: dfl.rst: Fix a couple building issues
  drm: amd: amdgpu_dm.h: fix a wrong kernel-doc markup
  dwc3: document gadget_max_speed
  doc: zh_CN/mips: fix doc cross-references
  media: v4l2-subdev.rst: fix a missing whitespace
  seqlock: kernel-doc: fix a prototype

 Documentation/ABI/testing/sysfs-firmware-sgi_uv       | 1 +
 Documentation/ABI/testing/sysfs-fs-f2fs               | 3 ++-
 Documentation/driver-api/media/v4l2-subdev.rst        | 2 +-
 Documentation/fpga/dfl.rst                            | 4 ++--
 Documentation/translations/zh_CN/mips/booting.rst     | 2 +-
 Documentation/translations/zh_CN/mips/features.rst    | 2 +-
 Documentation/translations/zh_CN/mips/index.rst       | 2 +-
 Documentation/translations/zh_CN/mips/ingenic-tcu.rst | 6 +++---
 Documentation/virt/kvm/api.rst                        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h     | 2 +-
 drivers/usb/dwc3/core.h                               | 1 +
 include/linux/seqlock.h                               | 2 +-
 12 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
