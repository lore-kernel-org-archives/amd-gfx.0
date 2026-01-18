Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54929C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 13:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FC010E2C1;
	Sun, 18 Jan 2026 13:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M1iqAa64";
	dkim-atps=neutral
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B438110E2C1
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 13:03:50 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-6505d141d02so5873304a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 05:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768741429; x=1769346229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qMU3cs7dn3/fRn2ydn322fJg5BXqI4LTIGvI46YG6H8=;
 b=M1iqAa64SKy5XMEy9b39wodoIW9oeSFpKjcZOEtmEJZ9q3u7a1VS+Bx7lqw3Nh2dpD
 Bj7vbIOJUeqH2d2Ig4z7lcdyKhL+xRNEAfiH18JZdsB0KI6Cnp8TxKiXt6/v01RQMPrX
 80gU889p1NspLapQI5u6P+wxmiMJrR/L/NIMD12ZQ6SXmZsYEzAnK+aUEGhw01St3IdY
 SHesTFJuWMuMC+ISea6zQYZF2JlsqGA5DKUlfpaD2LmUEKis60qjNzOVswWvXG2Cnzp0
 cDrEMOKS6+WDzGF5Umo3XXglmUyB1B5Sc/EeRMizfOlAmkAcb6ytffwJrrBARs3E1La4
 Cc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768741429; x=1769346229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMU3cs7dn3/fRn2ydn322fJg5BXqI4LTIGvI46YG6H8=;
 b=OI1F+74ZPcm9OnB7258KzivCrEc+qIuBEIeL99bfwrXuH+UbgL6TYlhdfWzGtCIABs
 rXT/LKDROgmq1T2U3zxXhe41ONt6bmVgySr/AfXpjIiP+s0whaFEdCgOm88pmOG2U6u9
 Nh60Lad8JnLnzN1LHwNFFoAWk7EQgBedMHQVtCVeK6LEdNnpVylvVnRNKxCAFkskgOuZ
 By3MaGBU+URF/hpY9SW+T638HuTQawaYIpBcCun0w1Lww7jHy5v7Kfhcm4I8kpIDR3wU
 n/mdt3U5De7dW/LK2fHopPTyk09XcarRTTvmVWgz2qHl+A0vklrHMYsnu8NN5Q1TllI6
 o2/A==
X-Gm-Message-State: AOJu0Ywdu0nWs5dWCYPXRqS72P7Y2l9rd7ch/n1oUrCvLEXNr+bjLghh
 FL0WJawnJugDUmQWWwQgY5lsrDfVWmqeJ3D76n0Fh7CO2LbjsdgAJvWfkCKO+tUu
X-Gm-Gg: AY/fxX6g0j67W/crZUE4J44aZNdEuTPRMiDgGRz6q3p+NONKGqnwZMmvn0ytoYFQXq6
 b8UzCGSW/7eIBUMXTpHdaO8gsbOiPp8Y3yExWBDc7QQP4e/T+0qIQKU7VNxu0A8fkkh3q6j24km
 lON2Yk0WbBkz8NX3UCAwvJRN0Pee9NmfR/NJ32/JTFt0cjsn92cMtSZWVRejlBHYOR+nYz8d/NG
 Si6D3MczA/PwgVAT/sa/MSI6FoZcodj4lbfApMVnwhvF1jhdgM3NHHCmNmV0NxOLaTNkC2i1kN0
 49nS/BZVqcWxd2yw3fNa+rL3CesRCMMfqF1bUv1sOHfFX1X4FDtqsWBKf0GsSpAn9bvNtilYXhy
 FYlE+EII+11K+JJw6YML0YAusOsU6QOHNT/+MSK7qvnzKnbvEy7+UYOGl6hgpyPIx5K0sOMTFe4
 5zMYJD4B3QDJqccITZD6blV6j2m6HoL83xnpPOp1FFFg82gj2n3wutAZuGUTjSVFJVVtua2JnY5
 /QKBQKWu4GI
X-Received: by 2002:a05:6402:358b:b0:64d:1762:9ba2 with SMTP id
 4fb4d7f45d1cf-654526c8fdemr6625172a12.13.1768741428971; 
 Sun, 18 Jan 2026 05:03:48 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654522cf02esm7798994a12.0.2026.01.18.05.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 05:03:47 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] drm/amd/display: Only poll analog connectors
Date: Sun, 18 Jan 2026 14:03:45 +0100
Message-ID: <20260118130345.43356-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Analog connectors may be hot-plugged unlike other connector
types that don't support HPD.

Stop DRM from polling other connector types that don't
support HPD, such as eDP, LVDS, etc. These were wrongly
polled when analog connector support was added,
causing issues with the seamless boot process.

Fixes: c4f3f114e73c ("drm/amd/display: Poll analog connectors (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 0a2a3f233a0e..e7b0928bd3db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -915,13 +915,19 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		struct amdgpu_dm_connector *amdgpu_dm_connector;
 		const struct dc_link *dc_link;
 
-		use_polling |= connector->polled != DRM_CONNECTOR_POLL_HPD;
-
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
 		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
+		/*
+		 * Analog connectors may be hot-plugged unlike other connector
+		 * types that don't support HPD. Only poll analog connectors.
+		 */
+		use_polling |=
+			amdgpu_dm_connector->dc_link &&
+			dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
+
 		dc_link = amdgpu_dm_connector->dc_link;
 
 		/*
-- 
2.52.0

