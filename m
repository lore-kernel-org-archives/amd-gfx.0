From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] drm/radeon: remove some dead code
Date: Tue, 7 Feb 2017 16:16:04 +0300
Message-ID: <20170207131604.GA27416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

If "rdev->bios" is NULL then we don't need to free it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 00cfb5d2875f..04c0ed41374f 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -638,10 +638,8 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
 
-			if (!rdev->bios) {
-				kfree(rdev->bios);
+			if (!rdev->bios)
 				return false;
-			}
 			return true;
 		}
 	}
