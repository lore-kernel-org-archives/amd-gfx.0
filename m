Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3624C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7A110E945;
	Thu, 27 Mar 2025 20:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vIhA15z/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E9110E173
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 51081614C4;
 Thu, 27 Mar 2025 20:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A0DC4CEEA;
 Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107954;
 bh=PgaGCH/W8/Trf8TAGievQbkAc4N5jKYxTSPpmhBvOFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vIhA15z/VZDsAv7vlRbOC3B0zvG9Pi/tdShrzL1coGHz6fLOfIuTXmGXpC2H+qdyT
 mlPAoJebUlcvJm4ixph+8OkzrGNU+9UszJ7MB7Oufu+hZd1L7S0JPR1Kvd+RZQwj7+
 8JPGG5P5dzuu19hwhp+aCKwOIQWb7zHwQmU56HB7qrh/MW0YJzm86nEaC3bGMYSdab
 cLtLZEVgaCIyPFqS7lujVAvPnSs2902653jcTg10acE2foSkz0piNlfN1RdfyOdxjC
 llCuxZy5pv4LZlzPf3l4rDbk7fahc3PbMF9NW9wdVrrP0DLxIKGJ+oOzFdtsy+znN8
 zfllPYcZup0Eg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 10/14] drm/amd: Adjust amdgpu_atombios messages from DRM_*()
 to drm_*()
Date: Thu, 27 Mar 2025 15:38:54 -0500
Message-ID: <20250327203858.3796086-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Messages emitted from amdgpu_atombios are currently with legacy DRM
macros. These don't show which device they are using. To make messages
clearer in multi-GPU systems adjust to drm_*() macros.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 28 +++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index e476e45b996a2..efdcedc372887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -370,7 +370,7 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
 				continue;
 
 			if (con_obj_id >= ARRAY_SIZE(object_connector_convert)) {
-				DRM_ERROR("invalid con_obj_id %d for device tag 0x%04x\n",
+				drm_err(adev_to_drm(adev), "invalid con_obj_id %d for device tag 0x%04x\n",
 					  con_obj_id, le16_to_cpu(path->usDeviceTag));
 				continue;
 			}
@@ -875,7 +875,7 @@ static void amdgpu_atombios_get_igp_ss_overrides(struct amdgpu_device *adev,
 			}
 			break;
 		default:
-			DRM_ERROR("Unsupported IGP table: %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unsupported IGP table: %d %d\n", frev, crev);
 			break;
 		}
 		if (percentage)
@@ -995,7 +995,8 @@ bool amdgpu_atombios_get_asic_ss_info(struct amdgpu_device *adev,
 			}
 			break;
 		default:
-			DRM_ERROR("Unsupported ASIC_InternalSS_Info table: %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev),
+				"Unsupported ASIC_InternalSS_Info table: %d %d\n", frev, crev);
 			break;
 		}
 
@@ -1254,7 +1255,7 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		*voltage = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
 	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+		drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 		return -EINVAL;
 	}
 
@@ -1329,12 +1330,12 @@ int amdgpu_atombios_get_svi2_info(struct amdgpu_device *adev,
 				}
 				break;
 			default:
-				DRM_ERROR("unknown voltage object table\n");
+				drm_err(adev_to_drm(adev), "unknown voltage object table\n");
 				return -EINVAL;
 			}
 			break;
 		default:
-			DRM_ERROR("unknown voltage object table\n");
+			drm_err(adev_to_drm(adev), "unknown voltage object table\n");
 			return -EINVAL;
 		}
 
@@ -1365,12 +1366,12 @@ amdgpu_atombios_is_voltage_gpio(struct amdgpu_device *adev,
 					return true;
 				break;
 			default:
-				DRM_ERROR("unknown voltage object table\n");
+				drm_err(adev_to_drm(adev), "unknown voltage object table\n");
 				return false;
 			}
 			break;
 		default:
-			DRM_ERROR("unknown voltage object table\n");
+			drm_err(adev_to_drm(adev), "unknown voltage object table\n");
 			return false;
 		}
 
@@ -1423,12 +1424,12 @@ int amdgpu_atombios_get_voltage_table(struct amdgpu_device *adev,
 				}
 				break;
 			default:
-				DRM_ERROR("unknown voltage object table\n");
+				drm_err(adev_to_drm(adev), "unknown voltage object table\n");
 				return -EINVAL;
 			}
 			break;
 		default:
-			DRM_ERROR("unknown voltage object table\n");
+			drm_err(adev_to_drm(adev), "unknown voltage object table\n");
 			return -EINVAL;
 		}
 	}
@@ -1467,7 +1468,7 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 			(adev->mode_info.atom_context->bios + data_offset);
 		switch (frev) {
 		case 1:
-			DRM_ERROR("old table version %d, %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "old table version %d, %d\n", frev, crev);
 			return -EINVAL;
 		case 2:
 			switch (crev) {
@@ -1529,12 +1530,13 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 					return -EINVAL;
 				break;
 			default:
-				DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+				drm_err(adev_to_drm(adev),
+					"Unknown table version %d, %d\n", frev, crev);
 				return -EINVAL;
 			}
 			break;
 		default:
-			DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unknown table version %d, %d\n", frev, crev);
 			return -EINVAL;
 		}
 		return 0;
-- 
2.43.0

