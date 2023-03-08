Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECD6C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 21:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9069B10E729;
	Wed,  8 Mar 2023 21:59:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C6610E721
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678312724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bpflyvgP7Tk2FiT7NC9tK3mz7yhJSeyaL97M7+sFE6c=;
 b=HgC3z0WyMU6PcEMzNZcd8xO8lfxTB0jVsC/wMFVGWovWNH9E/DjqZ/Ze2fmVTvoPGj0Yn/
 Cx4PCRPaFel3zvbAtRLM1h7Q55Rd226AEfRrmctB4GrAAHNn1CBkDHHopPLx1qY9KdiEqu
 cv7h81rYMOvnjq12VW1Qa5hpayefD2s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-ogRfrDZcMZK6yjQtodHy4g-1; Wed, 08 Mar 2023 16:58:41 -0500
X-MC-Unique: ogRfrDZcMZK6yjQtodHy4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD4553C58C46;
 Wed,  8 Mar 2023 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F37CC440E0;
 Wed,  8 Mar 2023 21:58:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC v2 0/6] drm/amd/display: Pass proper parent for DM backlight
 device v2
Date: Wed,  8 Mar 2023 22:58:25 +0100
Message-Id: <20230308215831.782266-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 08 Mar 2023 21:59:55 +0000
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

Here is version 2 of my patch series to pass the proper parent device
to backlight_device_register().

New in version 2 is delaying the registering of the backlight_dev till
after the drm_connector is registered by doing it from
drm_connector_funcs.late_register.

This involves first reworking the code a bit to allow delaying
the registering, so this has turned from a single patch into
a 6 patch set.

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
  drm/amd/display: Pass proper parent for DM backlight device
    registration v2

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 99 ++++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 2 files changed, 44 insertions(+), 56 deletions(-)

-- 
2.39.1

