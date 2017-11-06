From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amd/display: small cleanup in destruct()
Date: Mon, 6 Nov 2017 10:07:33 +0300
Message-ID: <20171106070733.owgzad3bpuabfkkk@mwanda>
References: <e32e3d91-bfdf-5c4b-afb2-2472efeb1079@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e32e3d91-bfdf-5c4b-afb2-2472efeb1079@amd.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Tony Cheng <tony.cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Dave Airlie <airlied@redhat.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Static analysis tools get annoyed that we don't indent this if
statement.  Actually, the if statement isn't required because kfree()
can handle NULL pointers just fine.  The DCE110STRENC_FROM_STRENC()
macro is a wrapper around container_of() but it's basically a no-op or a
cast.  Anyway, it's not really appropriate here so it should be removed
as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: in v1 I just added a tab

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index d911590d08bc..4c4bd72d4e40 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -725,10 +725,8 @@ static void destruct(struct dcn10_resource_pool *pool)
 		}
 	}
 
-	for (i = 0; i < pool->base.stream_enc_count; i++) {
-		if (pool->base.stream_enc[i] != NULL)
-		kfree(DCE110STRENC_FROM_STRENC(pool->base.stream_enc[i]));
-	}
+	for (i = 0; i < pool->base.stream_enc_count; i++)
+		kfree(pool->base.stream_enc[i]);
 
 	for (i = 0; i < pool->base.audio_count; i++) {
 		if (pool->base.audios[i])
