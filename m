Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D6C74A5B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 08:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580B910E4B8;
	Mon, 13 Mar 2023 08:18:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263AB10E272
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Mar 2023 19:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678648682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gzlqJ3cDfLxXhrKVIf4bvaCCqReIo9siiOkDa42+O+w=;
 b=Orpiolsr8IJVL4B4+86Y1AviIrSVqEv58NHP/G950HZYTiRi//LhoaQB5AU9PFMplXKmsF
 J7jkKSyjst6nUiAFOZmmZcYTF1RZlcDoxA1zT4cbXKAAquYu79k2uGBtRQs52NAEEUythp
 LnwPi0r35x3BIn6W6njujBsq2D6cg0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-QQ9gcM3_Nru4JdDRZxoHgQ-1; Sun, 12 Mar 2023 15:17:58 -0400
X-MC-Unique: QQ9gcM3_Nru4JdDRZxoHgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E412185A794;
 Sun, 12 Mar 2023 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1B3140EBF4;
 Sun, 12 Mar 2023 19:17:57 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v3 0/6] drm/amd/display: Pass proper parent for DM backlight
 device v3
Date: Sun, 12 Mar 2023 20:17:45 +0100
Message-Id: <20230312191751.183450-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 13 Mar 2023 08:18:21 +0000
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
Cc: Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

Here is version 3 of my patch series to pass the proper parent device
to backlight_device_register().

Changes in v3:
- Make amdgpu_dm_register_backlight_device() check bl_idx != 1 before
  registering the backlight since amdgpu_dm_connector_late_register()
  now calls it for _all_ connectors.

Changes in v2:
- Patches 1 - 5 are new, reworking the code a bit to allow delaying
  the registering, so this has turned from a single patch into
  a 6 patch set.
- Patch 6 now delays the registering of the backlight_dev till
  after the drm_connector is registered by doing it from
  drm_connector_funcs.late_register.

Note this no longer is RFC since this has been successfully
tested on 3 laptops which hit the affected code path.

Version 3 has also been tested on my personal AMD Ryzen 7 5700G APU
desktop machine and now no longer tries to register a backlight
device for each connector there.

Regards,

Hans


Hans de Goede (6):
  drm/amd/display/amdgpu_dm: Fix backlight_device_register() error
    handling
  drm/amd/display/amdgpu_dm: Refactor register_backlight_device()
  drm/amd/display/amdgpu_dm: Add a bl_idx to amdgpu_dm_connector
  drm/amd/display/amdgpu_dm: Move most backlight setup into
    setup_backlight_device()
  drm/amd/display/amdgpu_dm: Make amdgpu_dm_register_backlight_device()
    take an amdgpu_dm_connector
  drm/amd/display/amdgpu_dm: Pass proper parent for backlight device
    registration v3

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 100 ++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 2 files changed, 46 insertions(+), 55 deletions(-)

-- 
2.39.1

