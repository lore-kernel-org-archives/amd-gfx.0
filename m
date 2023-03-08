Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7990C678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 14:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99C710E5E4;
	Wed,  8 Mar 2023 14:14:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96D910E5E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678284601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mXndFig5MxMz39oru/IvohSxV+rytJfkgOQsYDdo+fQ=;
 b=GUwUdwBjjxq+VPBzYbMlhrML2aMcWfpZ1UwVNiHO3IW1zqLTikPo5deEIg+3Vp6QG1axFl
 KY3If1CbMW4jdOeB+XUg4uU6JxN2pDa4HSThzWymV7TTLO9MuzeRCigPhkjxswbVQDxaUF
 5dVuT8I808WzSw8ch7LGhACGkG5OPq8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-WhqoILbiPkyC7holBxgAUg-1; Wed, 08 Mar 2023 09:10:00 -0500
X-MC-Unique: WhqoILbiPkyC7holBxgAUg-1
Received: by mail-qv1-f71.google.com with SMTP id
 jo13-20020a056214500d00b004c6c72bf1d0so9261045qvb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 06:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678284594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mXndFig5MxMz39oru/IvohSxV+rytJfkgOQsYDdo+fQ=;
 b=kaE3Z3K298PV0+Lp9Xc4FxDNjcbHIzxIs1T3nQJsSz53ZKg2A8GyebtqMUseDnuu1j
 gHPUF95oXfn2KZzW3/9pkssFMbLV7s6tcypGCGay7swoMzZLHR/RzK28cM9fqEtA2hsH
 92O7rQWB7OHPsCNfBOq5ZMrobcrdLFSFSquI1OH5QrDcw54MnKhLQ1IHAWdrz1VZLGKz
 UKDyHDvCI35REBRTI3J7J0ZIamTiE9IL+w/HPTeectlC0qWRbwwDWBj/9zYzeD7PT9vM
 TOhgR/sP2hHZ3OoT/ueGGoU5rj3EMbqBcANTZosBP0pu4D93Rph6P7P0xJ7eQfEEOp9b
 l7vw==
X-Gm-Message-State: AO0yUKVdKGD2dDuHQ+ANLieaDxkPbiipi3vlgPmyChU+zeyaE2fohba+
 3Y87AcQJ0MLeY1jiNC/3Q8897gt9qWC2oqxEV21ngNsbo+FoPBqp7/yEAyaj8oFu8MfTijc4gqJ
 cp/gsTjNs68bwrR4cPi8ZYN1VAw==
X-Received: by 2002:a05:622a:1443:b0:3bf:d4c3:365d with SMTP id
 v3-20020a05622a144300b003bfd4c3365dmr4212478qtx.14.1678284593681; 
 Wed, 08 Mar 2023 06:09:53 -0800 (PST)
X-Google-Smtp-Source: AK7set/OjUR2DEyaB2HDQqosX6A/GPRFh2BbK8gtM7CV145ROLD4Op15ZKZMuAH5bQJg0F1d3/souw==
X-Received: by 2002:a05:622a:1443:b0:3bf:d4c3:365d with SMTP id
 v3-20020a05622a144300b003bfd4c3365dmr4212441qtx.14.1678284593432; 
 Wed, 08 Mar 2023 06:09:53 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 b1-20020ac812c1000000b003bfa932525dsm11523571qtj.51.2023.03.08.06.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:09:53 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, lyude@redhat.com, Wayne.Lin@amd.com,
 hersenxs.wu@amd.com, hamza.mahfooz@amd.com, Jerry.Zuo@amd.com
Subject: [PATCH] drm/amd/display: remove unused variable res_pool
Date: Wed,  8 Mar 2023 09:09:43 -0500
Message-Id: <20230308140943.2009970-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Mar 2023 14:14:14 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With gcc and W=1, there is this error
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1214:31:
  error: variable ‘res_pool’ set but not used [-Werror=unused-but-set-variable]
 1214 |         struct resource_pool *res_pool;
      |                               ^~~~~~~~

Since res_pool is unused, remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2739bef9b90c..4b9b5e4050fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1211,7 +1211,6 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 	bool computed_streams[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
-	struct resource_pool *res_pool;
 	int link_vars_start_index = 0;
 	int ret = 0;
 
@@ -1220,7 +1219,6 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 	for (i = 0; i < dc_state->stream_count; i++) {
 		stream = dc_state->streams[i];
-		res_pool = stream->ctx->dc->res_pool;
 
 		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
 			continue;
-- 
2.27.0

