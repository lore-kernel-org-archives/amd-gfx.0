Return-Path: <SRS0=QO8y=PF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A0BC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FC560F56
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51FC560F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B997C6E7D9;
	Sun, 17 Oct 2021 11:35:10 +0000 (UTC)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5296E7D7
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Oct 2021 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634470503; bh=LVcmEa0vrkSBhcYNxojfgIPVMwkXJfQgc1SBCfA4BAY=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 b=ds0ULEYm/av2+icVt/aocronkOXWUxzBvgPomtDNHxZVGIanGIjm6pEMkrOIwyoKY
 id5PBP0aZF+Rhkh88xs5oAqUNoUqsJSL4APjIi9OMESZSvwmL+/Twn0aBQNsQ3vj+3
 TL0BJJT1Ce1N69olofN+YD4Qu7N0VxJgg/WlzAAg=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sun, 17 Oct 2021 13:35:03 +0200 (CEST)
X-EA-Auth: jZVVlCcK5PK+GxUBt2PaJW78B4RHnvs1e7N+UJo74NNqt5sFepUBEwy8u9d91Vy3K04XtKzx93YwkBmEP9sSQjvGL7RZmwzi
From: Claudio Suarez <cssk@net-c.es>
To: amd-gfx@lists.freedesktop.org
Cc: Claudio Suarez <cssk@net-c.es>
Subject: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Date: Sun, 17 Oct 2021 13:34:57 +0200
Message-Id: <20211017113500.7033-1-cssk@net-c.es>
X-Mailer: git-send-email 2.33.0
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


From the TODO list Documentation/gpu/todo.rst
-----------------------
Once EDID is parsed, the monitor HDMI support information is available through
drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
retrieve the same information, which is less efficient.

Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
drm_display_info.is_hdmi if applicable.
-----------------------
The task is divided in three small patches. The last patch depends on the
first one.



Claudio Suarez (3):
  drm/amdgpu: update drm_display_info correctly when the edid is read
  drm/amdgpu: use drm_edid_get_monitor_name() instead of duplicating the
    code
  drm/amdgpu: replace drm_detect_hdmi_monitor() with
    drm_display_info.is_hdmi

 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 +-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 37 +++++--------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 8 files changed, 29 insertions(+), 44 deletions(-)

-- 
2.33.0



